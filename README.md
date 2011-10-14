OS-EXTENSIONS
=============

A demo of how to use OpenStack API extensions with fog.

Background
----------

OpenStack is a Infrastructure as a Service (IaaS) cloud controller that is free
as in love, speech, and beer.  Fog is a multi-cloud client API that is free as
the wind and written in Ruby.

OpenStack can serve many fontend APIs, but the OpenStack API (osapi) is able
to be extended in various ways, including adding new resource endpoints.  You
can look at [this nova source directory](https://github.com/openstack/nova/tree/master/nova/api/openstack/contrib) to see some extensions in action.

Cloud administrators can provide their own API extensions outside of the nova
source tree and point to them with the --osapi_extensions_path, but API clients
won't know about the new endpoints.

This is an example of how to make fog aware of custom API endpoints.

Setup
-----

If you already have an OpenStackcloud, that is amazing and I'm sure your mother
is very proud of you.  Just use that for testing with your new API.

For mere mortals, you can get a cloud in just a couple of easy steps using
[devstack](http://devstack.org/).  Follow the instructions to get your cloud
working and enable an OpenStack API extension using the --osapi_extensions_path
flag.  I'll be providing a custom extension and more specific instructions in
a short amount of time.

Make sure you have a version of fog that knows about osapi extensions.  Right
now this means using
[a branch on github](https://github.com/xtoddx/fog/tree/osextensions).  Check
it out one directory above this one.

Running
-------

exttext.rb included in this directory assumes the fog checkout is installed
one level above the current location (eg: ../fog).  Then it includes the
demo extension defined in the foo directory here, and uses the collections
to make requests to the cloud API server.  Edit the script to define your
credentials and the proper endpoints.

Writing an OSAPI Extension for Fog
==================================

Fog has a very pretty way of defining models, collections, and requests.  This
method uses those same metaprogramming methods to keep the same syntax that
the main components of fog are built in.

Example extension
-----------------

Pretend, for the sake of argument, that our cloud knows about rainbows.
You can query the API for a list of rainbows, and for each one get a list
of unicorns that frolic there.  This is the best cloud ever.

In this case, we'll build a `rainbows` extension, with models for `rainbow` and
`unicorn`, a collection of `rainbows` and `unicorns`, and the request methods
`get_rainbows` and `get_unicorns(rainbow_id)`.

Play along by reading the extension code in this repository after each section.

Build the extension main class
------------------------------

The extension main class is defined in rainbows/extension.rb.  This is the
file that is included by your client that wants to access the rainbow resource
from the OpenStack API.

The main extension class, lets call it `OpenStackRainbowsExtension` must derive
from `Fog::Compute::OpenStack::DelegateService` and be registered with the main
OpenStack compute service via the `add_delegate` method.  At the class level
you should define the paths, models, collections, and requests that comprise
your extension.

Read the code in `rainbows/extension.rb` now.

Build the collections
----------------------

For each collection (rainbows, unicorns), you need to make a class in the scope
of `OpenStackRainbowsExtension` that derives from `Fog::Collection` and lives
in what you specifed as your `models_path` in your main extension.

The collection should sepcify what its item model is using `model` and should
define functions for retreiving data.  Inside the data retrieval functions
you can use `connection`, which is an instance of
`Fog::Compute::OpenStack::Real` and has the requests you defined earlier mixed
in.  You can `load` data that is a list to build a new collection, or use `new`
to create a new single item model.  For collections you should specify an `all`
method where appropraite to load data when the collection is lazy loaded
(including when it is inspected).  You can define any other methods on this
collection that you like.

Read the code in `rainbows/models/compute/rainbows.rb` and
`rainbows/models/compute/unicorns.rb` now.

Build the models
----------------

The models specify the attributes that are returned from the OpenStack API
extension.  Each model must have one field that is the identifier and any
number of additional attributes.

Read the code in `rainbows/models/compute/rainbow.rb` and
`rainbows/models/compute/unicorn.rb` now.

Build the requests
------------------

The requests are descriptions of the HTTP transaction that occus between the
client and the OpenStack API.  They describe the valid HTTP status codes for
responses that should be loaded, as well as specifying the HTTP verb, request
path, and any request body, in the case of POSTs.

Each request has two classes, `Real` and `Mock`.  The `Mock` class returns
some fake data that can be used in testing.  The `Real` class is responsible for
calling `request` which actualy makes the call to the OpenStack API endpoint.
The `Real` class must derive from
`Fog::Compute::OpenStack::DelegateRequestClass` so the `request` is proxied
through the active OpenStack::Real service that has been authenticated and
has the connection data.

Read the code in `rainbows/requests/compute/list_rainbows.rb`,
`rainbows/requests/compute/list_unicorns.rb`,
and `rainbows/requests/compute/get_unicorn.rb`.

TODO
====

* Include the code for the OpenStack extension
  * Document installing the extension with devstack

