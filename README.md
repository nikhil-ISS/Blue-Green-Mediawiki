# Blue-Green-Mediawiki
Blue green deployment for Mediawiki

## Brief of the solution:

We are using below tech to apply the solution to the given problem.

* Strategy : Blue Green Deployment
* Cloud : AWS
* IAC : Terraform
* Container : Docker
* Source control : Github
* CI/CD Pipeline : Github Workflows

## Approach:
* -> The approach here is to create two Auto scaling groups spanned accross multiple AZ's and use them for Blue-Green Deployment
* -> Use Docker container to reduce the overhead of installation required to run mediawiki on the ec2 instance
* -> Since Aws ALB's are intelligent allowing us to choose the percent of traffic to required target groups, this helps us move ahead of traditional B-G deployment wherein entire system needed to be replicated and pointing was dependent on Route53

## How Was it done:

1) We have 2 ASG's a Blue ASG and a Green ASG. the Green ASG is in Deactivate and Blue is in Activate state on production 
2) when there is a new release a docker file is pushed to docker hub registry with "Green" tag
3) we then activate our Green ASG and run the terraform apply to get the ASG created , once the green ASG is created we hook it up to the target group of ALB.
4) once the 3rd step is done we change the target group setting to send 80-20 traffic , 80 to Blue ASG and 20 to new Green ASG.
5) now we test the new ASG and deployment and keep changing the percent of traffic as we need.
6) once we are sure the new Green deployment is good enough we move 100 % traffic to it we deactivate ASG Blue and take it down.
7) Then we push the docker file with Blue tag.
8) Rebuild the ASG Blue with docker image with tag Blue and attach it to target group.
9) now move the traffic back to ASG Blue from ASG Green by changing the percent in target group (for now its 50-50).
10) once all the traffic is back to ASG Blue strip down ASG Green.

## Workflow:

### The above 10 steps are part of github workflow actions.
* -> terraform-Green-Deployment.yml (step 1,2,3,4)
* -> terraform-Canary.yml (Step 5,6)
* -> terraform-Blue-Deployment-part1.yml (Step 6,7)
* -> terraform-Blue-Deployment-part2.yml (Step 8,9)
* -> terraform-Canary.yml (step 9) [to make it 100 % Blue and 0% Green]
* -> terraform-Green-Takedown.yml (step 10) 