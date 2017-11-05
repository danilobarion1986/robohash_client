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
# One image
require 'robohash_client'

Robohash.get('your_image_name')

# Many images
Robohash.get_many(['first','second','third'])
```

The options allowed are:

1. :set   (available options:  :classic, :human, :heads, :cats, :any) 
2. :size  (available options:  :small, :medium, :large, :extra)
3. :bgset (available options:  :one, :two)

```ruby
# Small image, with the cat's set

Robohash.get('your_image_name', { size: :small, set: :cats })
```

If invalid options or values are passed, they will be ignored.

The images will be saved at 'robohash_images' folder, in the folder where the ruby code is running, with the name passed as parameter and .png extension.

Currently is not possible to change the default directory that is used to save the image, neither the image extension, but I plan to include this options soon (Or if you want to help, contribute!).

### How to contribute?

If you want to include more functionality or suggest some change:

1. Fork this repo and create a branch on your fork for your new feature/change.
2. Write your new feature/change.
3. Submit your PR!

Once your PR is approved, repo owner (me!) will merge and deploy to Github and Rubygems.


### Contact

If you have some doubt, feel free to send me a message!