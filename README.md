# DiffResource
[![Gem Version](https://badge.fury.io/rb/diff_resource.svg)](https://badge.fury.io/rb/diff_resource)
[![Dependency Status](https://gemnasium.com/katsugeneration/diff-resource.svg)](https://gemnasium.com/katsugeneration/diff-resource)
[![Build Status](https://travis-ci.org/katsugeneration/diff-resource.svg?branch=master)](https://travis-ci.org/katsugeneration/diff-resource)
[![Code Climate](https://codeclimate.com/github/katsugeneration/diff-resource/badges/gpa.svg)](https://codeclimate.com/github/katsugeneration/diff-resource)
[![Test Coverage](https://codeclimate.com/github/katsugeneration/diff-resource/badges/coverage.svg)](https://codeclimate.com/github/katsugeneration/diff-resource/coverage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'diff_resource'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install diff_resource

## Usage

output your resource file's diff list, you execute under command

Usage:
  ```bash
diff_resource create <directory> <comparison> <file> [<options>] -t, --type=TYPE
  ```

Options:
- -t, --type=TYPE          : resource file type
- -o, [--output=OUTPUT]    : output file path.
- -c, [--compare=COMPARE]  : comparison target type. other directory or git object

Arguments:
- directory:		resource file root path
- comparison:		compare directory path or git hash
- file:			resource file name format ex) test.resource, \*.resource, \*-en.resource


Show detail, you execute under command
```bash
diff_resource help create
```
## Contributing

1. Fork it ( https://github.com/katsugeneration/diff-resource/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
