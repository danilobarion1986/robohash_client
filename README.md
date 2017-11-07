## Robohash Client

A simple client to get robohash avatar's from Robohash.org.
[![Gem Version](https://badge.fury.io/rb/robohash_client.svg)](https://badge.fury.io/rb/robohash_client)

### Installing

+ From Rubygems:
```bash
$ gem install robohash_client
```

+ From source code:
```bash
$ gem build robohash_client.gemspec
$ gem install robohash_client-0.0.2.gem
```

After install, you could save one or many images from Robohash.org like this:

```ruby
require 'robohash_client'

# One image
RobohashClient.get('your_image_name')

# Many images
RobohashClient.get_many(['first','second','third'])
```

If anything but a non-empty String is passed, these are the returns:

```ruby
# One image
RobohashClient.get(:symbol)
 # => Name should be an non-empty String!

# Many images
RobohashClient.get_many([Hash.new, 1, :symbol])
 # => []
```

If you want to return only the URL's, you could do this:

```ruby
# One URL
RobohashClient.get_url('your_image_name')
 # => 'https://robohash.org/your_image_name'

# Many images
RobohashClient.get_many(['first','second','third'])
 # => ['https://robohash.org/first', 'https://robohash.org/second', 'https://robohash.org/third']
```

The options allowed are:

1. :set   (:classic, :human, :heads, :cats, :any)
2. :size  (:small, :medium, :large, :extra)
3. :bgset (:one, :two)

```ruby
# Small image, with the cat's set
RobohashClient.get('your_image_name', { size: :small, set: :cats })
```

If invalid options are passed, they will be ignored.

The images will be saved at 'robohash_images' folder, in the folder where the ruby code is running, with the name passed as parameter and .png extension.

If you want to change the default directory where images are saved, you could use the default_dir property:

```ruby
# Change default save directory to '/home/my_user'
Robohash.default_dir = '/home/my_user'
Robohash.get('my_image')
 # => "Image my_image.png saved successfully on /home/my_user!"

# Reset default save directory to './robohash_images'
Robohash.reset_default_dir
Robohash.get('my_image')
 # => "Image my_image.png saved successfully on /path/to/ruby/file/robohash_images!"
```

_Currently is not possible to change the default image extension, but I plan to include this option as soon as possible (or if you want to help, contribute!)._

### Tests

To run the tests, do:

```
$ bundle && rspec
```

### How to contribute?

If you want to include more functionality or suggest some change:

1. Fork this repo and create a branch on your fork for your new feature/change.
2. Write your new feature/change.
3. Submit your PR!

Once your PR is approved, repo owner (me!) will merge and deploy to Github and Rubygems.

### Contact

If you have some doubt, feel free to send me a message!
