pipeline {
  agent {
    kubernetes {
      label 'nix-agent'
      defaultContainer 'nix'
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
            if [ -x result ]; then
              echo "Running hello-flake:"
              ls -lrth result
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

