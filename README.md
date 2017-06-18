# pfManager

This is the project you always dream!
Now you can manage all of your pfSenses in a single system.

Fell free to make pull requests to improve our system.

Here some steps to start the application.

# Ruby Version

Thi project was created using ruby 2.4. 

# Install Procedures (CentOS 6) 

Following, are the procedures to make the system up.

- Installing packages

```
$ yum install curl git -y
```

- Installing rvm (Ruby version manager)

```
$ \curl -L https://get.rvm.io | bash -s stable --ruby
```

- If you don't want logout and log in, run command bellow:

```
source /usr/local/rvm/scripts/rvm
```

- Install rails

```
gem install rails
```

- Download the code

```
git clone https://github.com/fastsupport/pfmanager.git
```

- Ruby procedures

```
$ bundle install
$ rake db:migrate
$ rake db:populate
```

# Start application

To start this app, you have to run rails server inside your project folder.
<br>
*Obs.: We suppose you will use port 3000*

```
rails server -b 0.0.0.0 -p 3000
```

# Using application

Now you have application up, you can access using address http://localhost:3000.
The default username and password is admin.

<p align="center">
	<img src="/readme_images/login_page.png" style="max-width:40%;">
</p>



