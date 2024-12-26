@Library("Shared") _ 
pipeline {
    agent { label "agent" }
    
    stages {
        
        stage("Hello") {
            steps {
                script {
                    hello() 
                }
            }
        }
        stage("Fix Permissions") {
            steps {
                sh "sudo chown -R $USER:$USER /home/ubuntu/workspace/DjangoCICD/data/mysql/db/"
                sh "sudo chmod -R 755 /home/ubuntu/workspace/DjangoCICD/data/mysql/db/"
            }
        }
        
        stage("Code") {
            steps {
                echo "this is cloning the code"
                git url: "https://github.com/Bilal-Sidd/3-tier-Django-notes-web-app.git", branch: "main"
                echo "clone successful"
            }
        }
        
        stage("Build") {
            steps {
                echo "this is building the code"
                sh "docker-compose -f docker-compose.yml build"
            }
        }
        
        stage("Push to DockerHub") {
            steps {
                echo "this is image pushing to dockerHub"
                withCredentials([usernamePassword(credentialsId: "DockerHubCred", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    // Log in to Docker Hub
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"

                    // Tag the built images with Docker Hub repository

                    // Push images to Docker Hub
                }
            }
        }
        
        stage("Deploy") {
            steps {
                echo "this is deploying the code"
                sh "docker-compose down && docker-compose -f docker-compose.yml up -d"
            }
        }
    }
}
