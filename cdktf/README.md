# Getting it working

## Installing CDKTF
To install the most recent stable release of CDKTF, use npm install with the @latest tag:
```shell
$ npm install --global cdktf-cli@latest
```
Verify CDKTF is installed by running:
```
$ cdktf help
cdktf

Commands:
  cdktf init                Create a new cdktf project from a template.
  cdktf get                 Generate CDK Constructs for Terraform providers and
                            modules.
  cdktf convert             Converts a single file of HCL configuration to CDK
                            for Terraform. Takes the file to be converted on
                            stdin.
#...
```

## Installing `node_modules`
Install [nvm](https://github.com/nvm-sh/nvm):
```shell
brew install nvm
```
For the purpose of recreation, I used the following:
```shell
nvm install 16.19.1 
nvm use 16.19.1 
```
In the specific folder, e.g. `./create-s3-bucket`, run:
```shell
npm i
```

## Running
Simply `cd` into the folder and run:
```shell
cdktf deploy
```

# Learning
Please note, my reference at the time was:
- v0.16.x of [CDK for Terraform](https://developer.hashicorp.com/terraform/cdktf)
- [@cdktf/cdktf-provider-aws](https://github.com/cdktf/cdktf-provider-aws/tree/main/docs)

## Set Up

### Terraform Cloud
This step is optional. You can choose not to use Terraform cloud. But if you do choose to use it, you will need to generate a token.
1. Navigate to Terraform Cloud. It will require you to sign in, so sign up if you haven’t already got an account.
1. Store the token since it will only be visible once.
![image](https://github.com/LanceTe/terraform-learning/assets/109207166/bbf74cbc-7fd7-4c85-a8bb-4fc8efbb9114)
1. On the left hand menu, click Organisation and follow the process to create an organisation.

### CDKTF Repo
In your terminal, create a directory, and `cd` into it. Then run the following to initialise:
```shell
cdktf init --template="typescript" --providers="aws@~>4.0"
```
You’ll get prompted to configure the set up. You can choose whether to use Terraform Cloud or not. For learning purposes, I decided to use it.

**Note:** Your Terraform Cloud token will be stored in ~/.terraform.d/credentials.tfrc.json

Give it time to run as it will:
- Generate the Terraform Cloud configuration for the 'lance-learning' organisation and 'create-s3-bucket' workspace.
- Install node_modules.
- Check whether pre-built provider exists for the following constraints.

The file structure will look like this:

<img src="https://github.com/LanceTe/terraform-learning/assets/109207166/8c7d1e40-0ada-43bb-afbf-a5bd6a6682a0" width="20%" />
