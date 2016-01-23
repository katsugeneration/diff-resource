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

To output your resource file's diff list, you run under command.

Usage:
  ```bash
diff_resource create <directory> <comparison> <file> <type> [<options>]
  ```

Options:
- -o, [--output=OUTPUT]    : output file path.
- -c, [--compare=COMPARE]  : comparison target type. other directory or git object
- -s, [--setting=SETTING]  : setting file path

Arguments:
- directory:		resource file root path
- comparison:		compare directory path or git hash
- file:			resource file name format ex) test.resource, \*.resource, \*-en.resource
- type:			resource file type. you can set custom type in .diffresource.yml

You should run on git root directory when using git mode.

To show detail, you run under command.
```bash
diff_resource help create
```

## Settings File Format

To create custom resource type and set custom default option value, you create ".diffresource.yml" as the following.
```yaml
types:
  custom-resource : # custom resource type name
    format: "xml"  # file format. xml, json, yaml are enable value
    root : "data"   # resources object name. if object is nested, you set path split "."
    key : "key"     # resource name. * means resources object is hash
    value : "value" # resource value

comparison: "dir"   # custom comparison value

output: "./dir"     # custom output value
```

It is enable to parse like these format resources.

```xml
<?xml version="1.0" encoding="utf-8"?>
<root>
	<data key="string1">
		<value>hello</value>
	</data>
	<data key="string2">
		<value>hello hello</value>
	</data>
</root>
```

Case resources object is nested, you should set path split "." as the following.

```yaml
types:
  custom-resource :
    format: "json"
    root : "root.data"
    key : "key"
    value : "value"
```

It is enable to parse like these format resources.
```json
{
	"root" :{
		"data" : [
			{
				"key" : "string1",
				"value" : "hello"
			},
			{
				"key" : "string2",
				"value" : "hello hello"
			}
		]
	}
}
```

Case resources object is hash, you should set "\*" to key as the following.
```yaml
types:
  custom-resource :
    format: "yaml"
    root : "root.data"
    key : "*"
```

It is enable to parse like these format resources.
```yaml
root:
  data:
    string1: "hello"
    string2: "hello hello"
```

## Contributing

1. Fork it ( https://github.com/katsugeneration/diff-resource/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
