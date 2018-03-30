# Resume

This repo serves as simple dockerized resume that can implemented on any operating system.

To be able to use it you need to have dokcer installed as per [this link](https://docs.docker.com/install/)

Then just clone the repo and run the following commands from inside the folder:


```bash
docker build -t resume .
docker run -d --rm -p 4000:4000 --name resume resume
```

The last step is to navigate to http://localhost:4000 on any local browser


To remove the container:

```bash
docker rm -f resume
docker rmi -f resume
```

This project was inspired and built on the basis of this [GitHub project](https://github.com/adrienkohlbecker/resume/)
