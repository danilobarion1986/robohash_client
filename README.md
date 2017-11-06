## Robohash Client

A simple client to get robohash avatar's from Robohash.org.

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
Robohash.get('your_image_name')

# Many images
Robohash.get_many(['first','second','third'])
```

If anything but a non-empty String is passed, these are the returns:

```ruby
# One image
Robohash.get(:symbol)
 # => Name should be an non-empty String!

# Many images
Robohash.get_many([Hash.new, 1, :symbol])
 # => []
```

If you want to return only the URL's, you could do this:

```ruby
# One URL
Robohash.get_url('your_image_name')
 # => 'https://robohash.org/your_image_name'

# Many images
Robohash.get_many(['first','second','third'])
 # => ['https://robohash.org/first', 'https://robohash.org/second', 'https://robohash.org/third']
```

The options allowed are:

1. :set   (:classic, :human, :heads, :cats, :any)
2. :size  (:small, :medium, :large, :extra)
3. :bgset (:one, :two)

```ruby
# Small image, with the cat's set
Robohash.get('your_image_name', { size: :small, set: :cats })
```

If invalid options are passed, they will be ignored.

The images will be saved at 'robohash_images' folder, in the folder where the ruby code is running, with the name passed as parameter and .png extension.

_Currently is not possible to change the default directory that is used to save the image, neither the image extension, but I plan to include this options soon (Or if you want to help, contribute!)._

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
