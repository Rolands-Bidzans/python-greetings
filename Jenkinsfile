pipeline {
    agent any
    parameters {
    	string(name: 'dockerhub_username', defaultValue: 'rolandstech', description: 'Dockerhub username')
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
        stage('tests-on-dev') {
            steps {
               runTests("DEV")
            }
        }
        stage('deploy-to-stg') {
            steps {
                deploy("STG")
            }
        }
        stage('tests-on-stg') {
            steps {
                runTests("STG")
            }
        }
        stage('deploy-to-prod') {
            steps {
                deploy("PROD")
            }
        }
        stage('tests-on-prod') {
            steps {
                runTests("PROD")
            }
        }
    }
}

def pushDockerImage() {
    // echo "Pushing image to docker registry.."
    bat "docker push ${params.dockerhub_username}/python-greetings-app:latest"
}

def pullDockerImage() {
    // echo "Pulling image from docker registry.."
    bat "docker pull ${params.dockerhub_username}/python-greetings-app"
}

def buildDockerImage(){
    echo "Building docker image..."
    bat "docker build -t ${params.dockerhub_username}/python-greetings-app:latest ."
    
    pushDockerImage()
} 

def deploy(String environment) {
    echo "Deploying Python microservice to ${environment} environment.."
    String lowercaseEnv = environment.toLowerCase();
    pullDockerImage()
    bat "docker compose stop greetings-app-${lowercaseEnv}"
    bat "docker compose rm greetings-app-${lowercaseEnv}"
    bat "docker compose up -d greetings-app-${lowercaseEnv}"
}

def runTests(String environment) {
    echo "Testing Python microservice in ${environment} environment.."
    String lowercaseEnv = environment.toLowerCase();
    pullDockerImage()
    bat "docker run --network=host --rm ${params.dockerhub_username}/api-tests:latest run greetings greetings_${lowercaseEnv}"
}
