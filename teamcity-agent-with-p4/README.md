# teamcity-agent-with-p4
Run this example using:
```
docker run -itd anushibin007/blog:teamcity-agent-with-p4
```
The above command will start a TeamCity Agent which has P4 CLI installed into it. You have to actually refer to the official jetbrains/teamcity-agent's Docker Hub page at https://hub.docker.com/r/jetbrains/teamcity-agent to know as to how to properly use this image. We need add some extra parameters when running the TeamCity Agent image as a container. The same environment variables used for the official image can also be used for this one. The only difference is that this image will have P4 CLI pre-installed to it.

++UPDATE:++
You can check the [teamcity-server-with-p4](../teamcity-server-with-p4)'s README for a better command to do this.
