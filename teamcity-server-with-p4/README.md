# teamcity-server-with-p4
Run this example using:
```
docker run -itd --name teamcity-server -v teamcity-server-datadir:/data/teamcity_server/datadir -v  teamcity-server-logs:/opt/teamcity/logs -p8111:8111 anushibin007/blog:teamcity-server-with-p4
```
The above command will start a TeamCity Server which has P4 CLI installed into it. You can now set up P4 jobs on your TeamCity Server.

You can pull a Teamcity agent too, which has P4 installed into it. Run it using the following command:
```
docker run -itd --name teamcity-agent -p9090:9090 --link teamcity-server -e SERVER_URL="http://teamcity-server:8111" -v teamcity-agent-conf:/data/teamcity_agent/conf anushibin007/blog:teamcity-agent-with-p4
```
