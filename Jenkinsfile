pipeline {
  agent {
    kubernetes {
      label 'nix-agent'
      defaultContainer 'nix'
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:latest
    tty: true
  - name: nix
    image: ghcr.io/akhiljohnchacko/nix-builder:25.05
    command:
    - cat
    tty: true
    volumeMounts:
    - name: jenkins-workspace
      mountPath: /home/jenkins/agent
  volumes:
  - name: jenkins-workspace
    emptyDir: {}
"""
    }
  }

  options {
    timestamps()
  }

  stages {
    stage('Check Nix Version') {
      steps {
        container('nix') {
          sh 'nix --version'
        }
      }
    }

    stage('Build Flake') {
      steps {
        container('nix') {
          sh '''
            echo "Building hello-flake from flake.nix"
            nix build .#hello-flake
            ls -l result
          '''
        }
      }
    }

    stage('Run Binary') {
      steps {
        container('nix') {
          sh '''
            if [ -x result/bin/hello-flake ]; then
              echo "Running hello-flake:"
              result/bin/hello-flake
            else
              echo "Binary not found!"
              exit 1
            fi
          '''
        }
      }
    }
  }
}
