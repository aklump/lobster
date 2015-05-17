# {{ lobster.title }}
{{ lobster.description }}
_Powered by [Lobster]({{ lobster.homepage }})_

## Features
* Designed by a Php web developer and is influences by Php and html concepts (func names, etc).
* Draws from [Bootstrap](http://getbootstrap.com/), [Drupal](http://www.drupal.org)

## Goals
* To provide a common pattern/API and constraints for consistency amoung BASH projects.
* To make BASH scripting easier for the person with a php web development background, by abstracting difficult shell processes into familier patterns and language.

## Lobster concepts
You must think in terms of three scopes when using Lobster to build your shell project.

### Conventions
* All lobster functions begin with either `lobster_` or `_lobster_`.
* Private functions begin with `_lobster_`.  The api for private functions is not guaranteed to stay consistent, so **you should not call private functions from your project for stability reasons.**

### Scope: Lobster
1. There is Lobster core `__lobster/lobster`, which you never touch.
1. It is the code portion of Lobster that will be extended by your project.

### Scope: Project
1. There is your project core `__lobster/, which is created when you install Lobster.
1. It contains the folder `lobster`, as well as a myriad of folders (which make up the scaffolding) of the Lobster framework
1. This scaffolding imposes architectural constraints to your project.

        .lobster
        your_project/
                    /lobster

### Scope: Instance
3. Then there is an instance of your project.  The instance of your project has as one of it's folder, your project core, AND it has a folder called `.__lobster` which contains instance meta data.

        /some_instance/
                      /.lobster
                      /your_project/
                                   /lobster
## __lobster
The core folder, this is necessary to run lobster and may be present in an instance or it may be moved to one central location on a server to serve as the core of all instances.

## __lobster/patterns
This folder holds patterns that may be used like rubber stamps to install or compile and instance.

## __lobster/tmp
This folder needs to be writeable and will be used as temporary storage during operations like install and compile.

## .lobster
This folder will be present in any Lobster instance; it contains the instance config and other instance only data.

##

## About
The name comes from: **LO(ft)B(a)S(h)TER**.