

pipeline {
    agent any
    environment {
        TFCloud_ORG= "loktf"
        TFCloud_URL= "app.terraform.io"
    }
    
    //Active Choice Parameters these values are input to the terraform.auto.tfvars
    parameters {
        string defaultValue: 'VM001-Jenkins', description: 'Please provide the VM Name', name: 'VirtualMachineName'
        choice choices: ['B1s', 'DS1_v2', 'D2s_v3', 'D2as_v4', 'B2s', 'B2ms', 'B4ms', 'D4s_v3', 'DS3_v2'], description: 'Choose only one and default one is', name: 'InstanceType'
        string defaultValue: 'adminuser', description: 'Please provide the VM User Name', name: 'VMUserName'
        password defaultValue: 'Admin123', description: 'Please provide the password if you want change default', name: 'VMPassword'
    }
    stages {
        //checkout the Github code
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitCreds', url: 'https://github.com/lokpavan03/tfcworkspace.git']]])
            }
        }
        //createing the terraform.auto.tfvars file from the choices parameters input
        stage('Creating File') {
            steps {
                writeFile file: 'terraform.auto.tfvars', text:  """resource_group_name = "${params.RescourceGroupName}-${BUILD_NUMBER}"\
                \nresource_group_location = "${params.ResourceGroupLoaction}"\
                \nvnet_name = "${params.VirtualNetworkName}"\
                \nsubnet_name = "${params.SubNetName}"\
                \nazure_virtual_machine_name = "${params.VirtualMachineName}-${BUILD_NUMBER}"\
                \nInstanceType = "${params.CHOICE}"\
                \nadmin_vm_username = "${params.VMUserName}"\
                \nadmin_vm_password = "${params.VMPassword}"\
                \nsubscription_id = "eab04c08-63fc-4336-909a-e1b7f7d8ca1e"\
                \nclient_id = "24cad02a-ae8d-4ef2-93c8-c7a8afb31cf6"\
                \nclient_secret = "-~_pDh0o0sF649FAfzTyyd~gl2DL4_USvA"\
                \ntenant_id = "7f3f7804-5327-4427-ba97-e16ad406dd43"\
                \n""" 
                sh 'cp ./terraform.auto.tfvars ./config/'
                sh 'echo env.TFCloud_ORG'
            }
        }      
        //API hit the Terrraform cloud with CURL and retreiving Terraform API Token from the Azure Key Vault
        stage('API Workflow') {
            options{
                azureKeyVault(credentialID: 'AzureSP', keyVaultURL: 'https://jenkinstf.vault.azure.net/', secrets: [[envVariable: 'Token', name: 'TFAPITOKENAD', secretType: 'Secret']])
            }
            environment{
                TFC_ORG= ${env.TFCloud_ORG}
                TFC_URL= ${env.TFCloud_URL}             
            }
            steps {
                sh 'chmod +x ./JenkinsWS.sh'
                sh './JenkinsWS.sh "" "" yes'
            }
        }                  
    }         
}
