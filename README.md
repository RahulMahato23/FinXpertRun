# FinXpert Dev Environment Setup
## Prerequisites:
1.	A PostgreSQL and Mongodb Database (multiple if you want)
2.	Docker and Kubernetes must be installed.
3.	Skaffold must be installed in the system.
4.	You must have an OpenAI API Key for the AI Features.
Extract the development.zip and open the folder on your IDE, then follow these steps.

# Steps:<br/>
## Secrets Deployment
1.	In the development.zip file, go to the secrets/secrets directory. In there, go through each file there and modify the environment variables there as per the given instructions.
2.	Then in the parent secrets directory, run the file secret-deploy-script.sh on your command line.
3.	If something goes wrong and you want to change and redeploy the secrets, write the command `kubectl delete secrets --all -n finxpert-dev`to delete the existing secrets and then deploy again after changes.

## Deploying Kafka
1.	Make a PVC for Kafka: `kubectl apply -f ./k8s/kafka/pvc.yaml`. Wait 10 seconds.
2.	Deploy Zookeeper: `kubectl apply -f ./k8s/kafka/zookeeper-depl.yaml`. Wait 20 seconds.
3.	If previous operations were successful and you can see the zookeeper pod successfully running, you may move ahead.
4.	Deploy Kafka: `kubectl apply -f ./k8s/kafka/kafka-depl.yaml`. Wait 60 seconds for kafka to be running. Verify it then go ahead.
5.	Run the topic creator job for Kafka: `kubectl apply -f ./k8s/kafka/kafka-create-topics-job.yaml`

## Deploy the Ingress Controller
1.	Run the below command on your command-line to install ingress-nginx in your cluster: 
2.	    kubectl apply -f "https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml"      
3.	(OPTIONAL, only run if scaffold dev shows problems related to ingress) Now run: `kubectl apply -f  ./k8s/ingress-srv.yaml` to apply the ingress routing.


## Change the `hosts` file
1.	You have to add a configuration in your OS so that finxpert.com points to 127.0.0.1 (localhost). I am giving the steps for windows. For linux/macOS it is even easier and the steps can be found online.
2.	Go to C:\Windows\System32\drivers\etc directory and open the hosts file on any text editor. (You will need Administrator permission for this)
3.	Add the line `127.0.0.1 	finxpert.com `, there and save it. 
4.	A reboot may or may not be required.

## Starting the backend
1.	Go to /services/user/src/migrations/up directory, and run the sql files on your user database. Use your preferred way to do it.
2.	Now simply go to the project root, and run `skaffold dev`. This starts the backend. Wait till it completes everything.

## Running the frontend
1.	Create a ‘.env’ file in the /frontend directory.
2.	Add these two variables there
VITE_REACT_APP_API_BASE_URL=http://finxpert.com/api<br/>
VITE_REACT_APP_BASE_URL=http://finxpert.com
3.	Run: `npm run dev`

