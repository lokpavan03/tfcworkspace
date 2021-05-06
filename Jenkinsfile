def TFC_ORG= "loktf"
def TFC_URL= "app.terraform.io"

pipeline {
    agent any
    
    //Active Choice Parameters these values are input to the terraform.auto.tfvars
    parameters {
        string defaultValue: 'VM001-Jenkins', description: 'Please provide the VM Name', name: 'VirtualMachineName'
        string defaultValue: 'West Europe', description: 'Please Provide the Resource group location if you want to change', name: 'ResourceGroupLoaction'
        string defaultValue: 'TFCloudRG001', description: 'Please Provide the Resource group name if you want to change', name: 'RescourceGroupName'        
        choice choices: ['Standard_B1s', 'DS1_v2', 'D2s_v3', 'D2as_v4', 'B2s', 'B2ms', 'B4ms', 'D4s_v3', 'DS3_v2'], description: 'Choose only one and default one is', name: 'InstanceType'
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
                \nazure_virtual_machine_name = "${params.VirtualMachineName}-${BUILD_NUMBER}"\
                \nInstanceType = "${params.InstanceType}"\
                \nadmin_vm_username = "${params.VMUserName}"\
                \nadmin_vm_password = "${params.VMPassword}"\
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
            steps {
                echo "${TFC_ORG}"
                sh 'chmod +x ./JenkinsWS.sh'
                sh './JenkinsWS.sh "" "" yes'
            }
        }                  
    }         
}
