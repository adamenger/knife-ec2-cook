EC2 Cook
========

This is a simple knife plugin intended to be used with Chef Solo. Current usage assumes that you have an instance tagged with "app" and "environment". 
Apps meaning which applications the instance is running and environment is which environment you'd like the node to live in.

For instance, I currently have an instance running in a VPC that's tagged as `{'app' : 'my_app'} and {'environment': 'production'}`

![knife ec2 cook example](http://i.imgur.com/n4bIG4e.png)


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

This plugin assumes a few things. One assumption is that you already have a node configuration file for the node you want to cook and that it's placed under ~/.chef/nodes/<your_env>/<your_app>.json. With that in mind, here is an example node file for you to use if you don't have one already.

```
{
  "run_list":
    [
      "recipe[your-cookbook::default]"
    ],
  "environment": "production"
}
```


```
$ knife ec2 cook -e production -a my_app
```
