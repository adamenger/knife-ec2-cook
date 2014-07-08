EC2 Cook
========

This is a simple knife plugin intended to be used with Chef Solo. Current usage assumes that you have an instance tagged with "apps" and "environment". 
Apps meaning which applications the instance is running and environment is which environment you'd like the node to live in.

Installation
============
```
git clone https://github.com/adamenger/ec2-cook.git 
mv ec2-cook/ec2_cook.rb ~/.chef/plugins/knife/ec2_cook.rb
```

Now you should see that you have a knife ec2 cook option available when you look at your ec2 sub commands.

```
** EC2 COMMANDS **
**knife ec2 cook (options)**
knife ec2 flavor list (options)
knife ec2 instance data (options)
knife ec2 server create (options)
knife ec2 server delete SERVER [SERVER] (options)
knife ec2 server list (options)
```


Usage
====

```
$ knife ec2 cook -e production -a my_app
```
