pipeline {
    agent any
    parameters {
    	dockerhubUserName 'rolandstech'
    }
    stages {
        stage('build-docker-image') {
            steps {
                buildDockerImage()
            }
        }
        stage('deploy-to-dev') {
            steps {
                deploy("DEV")
            }
        }
        stage('test-on-dev') {
            steps {
               runTests("DEV")
            }
        }
        stage('deploy-to-stg') {
            steps {
                deploy("STG")
            }
        }
        stage('test-on-stg') {
            steps {
                runTests("STG")
            }
        }
        stage('deploy-to-prod') {
            steps {
                deploy("PROD")
            }
        }
        stage('test-on-prod') {
            steps {
                runTests("PROD")
            }
        }
    }
}

def pushDockerImage() {
    echo "Pushing image to docker registry.."
    bat "docker push $dockerhubUserName/python-greetings-app:latest"
}

def buildDockerImage(){
    echo "Building docker image..."
    bat "docker build -t $dockerhubUserName/python-greetings-app:latest ."
    
    pushDockerImage()
} 

def pullDockerImage() {
    echo "Pulling image from docker registry.."
    bat "docker pull $dockerhubUserName/python-greetings-app"
}

def deploy(String environment) {
    echo "Deployement treiggered on ${environment} env.."
    String lowercaseEnv = environment.toLowerCase();
    pullDockerImage()
    bat "docker compose stop greetings-app-${lowercaseEnv}"
    bat "docker compose rm greetings-app-${lowercaseEnv}"
    bat "docker compose up -d greetings-app-${lowercaseEnv}"
}

def runTests(String environment) {
    echo "API tests treiggered on ${environment} env..."
    String lowercaseEnv = environment.toLowerCase();
    pullDockerImage()
    bat "docker run --rm --network host $dockerhubUserName/api-tests run greetings greetings_${lowercaseEnv}"
}
