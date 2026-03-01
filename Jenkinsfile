pipeline {
    agent any

    environment {
        DEV_APP_HOST = '192.168.12.60'
        DEV_APP_PORT = '443'
        ANSIBLE_PLAYBOOK_PATH = './ansible/playbook.yml'
    }

    stages {
        stage('Test') {
            steps {
                script {
                    echo 'Test nginx in docker'
                    
                    // 1. Запуск
                    sh 'docker compose up -d'
                    
                    sh 'docker compose logs --no-color > test.log'
                    
                    def url = "https://${DEV_APP_HOST}:${DEV_APP_PORT}/indexdev.php"
                    
                    def response_code = sh(returnStdout: true, script: "curl -k -s -o /dev/null -m 5 -w '%{http_code}' ${url}").trim()
                    
                    if (response_code == '200') {
                        echo 'test ok'
                    } else {
                        error "Health check FAILED. Code: ${response_code}"
                    }
                }
            }

            post {
                failure {
                    sh 'cat test.log'
                }
                
                success {
                    echo 'Test passed. Deleting log file.'
                    sh 'rm -f test.log'
                }
                
                always {
                    echo 'Stop dev env'
                    sh 'docker compose down -v' 
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Run ansible playbook...'
                    ansiblePlaybook(
                        playbook: "${ANSIBLE_PLAYBOOK_PATH}",
                        limit: 'prod',
                        additionalParameters: '--syntax-check'
                    )
                }
            }
        }
    }
}
