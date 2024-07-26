pipeline {
    agent any
    environment {
        GIT_CREDENTIALS_ID = 'id-github'  // Remplacez par l'ID de vos identifiants GitHub
    }
    stages {
        stage('Clone repository') {
            steps {
                script {
                    checkout([$class: 'GitSCM', branches: [[name: 'main']],
                        userRemoteConfigs: [[url: 'https://github.com/nader2112/angularTemplate.git', credentialsId: env.GIT_CREDENTIALS_ID]]
                    ])
                }
            }
        }
        stage('Install dependencies') {
            steps {
                sh 'npm install'
                sh 'npx ng version'
            }
        }
        stage('Build') {
            steps {
                sh 'npx ng build'
            }
        }
        stage('Deploy') {
            steps {
               script {
                    def nginxContainer = 'mynginx'
                    // Supprimez l'ancien conteneur s'il existe
                    sh "docker rm -f ${nginxContainer} || true"
                    // Démarrez un nouveau conteneur Nginx
                    sh "docker run -d --name ${nginxContainer} -p 9090:80 nginx:latest"
                    // Supprimez l'ancien contenu dans le dossier /usr/share/nginx/html
                    sh "docker exec -u 0 ${nginxContainer} rm -rf /usr/share/nginx/html/*"
                    // Copiez les fichiers de build Angular
                    sh "docker cp ${env.WORKSPACE}/dist/angular-template/browser/. ${nginxContainer}:/usr/share/nginx/html"
                    // Vérifiez les fichiers copiés
                    sh "docker exec -u 0 ${nginxContainer} ls -l /usr/share/nginx/html"
                    // Rechargez Nginx
                    sh "docker exec -u 0 ${nginxContainer} nginx -s reload"
                }
            }
        }
    }
}
