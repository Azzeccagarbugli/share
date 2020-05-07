Implementation
================

The following page will show what has been **our implementation** of this pattern by providing the documentation of the APIs created.

Share
------

The **Share** class is the beating heart of the pattern of the same name, the *raison d'etre* of the same and spokesperson for the 
current of thought that characterized the project in its entirety: **elegance is everything**. The class has the list of services 
that a device proudly makes available to all, and offers features to add or remove others. But the main responsibility of this 
class is to perform the ``discovery`` function, a symbol of an endless adventure, an adventure that begins in the search for the 
services that best lend themselves to the arduous and meticulous work that the calling service requires. 

The function uses the **MDNS protocol** to first calculate the ip address of each device on the network, 
then subsequently examine the table of services available from the same. 

.. note::
    In computer networking, the multicast DNS (mDNS) protocol resolves hostnames to IP addresses 
    within small networks that do not include a local name server. It is a zero-configuration service, 
    using essentially the same programming interfaces, packet formats and operating semantics as the 
    unicast Domain Name System (DNS). Although Stuart Cheshire designed mDNS as a stand-alone protocol, 
    it can work in concert with standard DNS servers.

The ``discovery`` function is called by ``call``, a function that finds an origin but perhaps does not find an end, a very long path that 
only the best services can undertake to the end. And so it is that from these services the transfer of **knowledge** takes place between the 
calling device and the called device, a knowledge obtained in a transversal, unorthodox way, based on the code and not on the network. 
The caller does not get knowledge directly, if he has to conquer it by executing the code that was provided to him by the caller. 

Share doesn't give you fish, but it can help you fish. Elegance is everything.

.. lua:autoclass:: Share

Service
---------

The **Service** class represents any functionality made available by the device that owns it. 

The responsibility of this class, in addition to providing the result of the computation with the parameters 
requested by the caller through the ``daemon`` function, is to establish a safe and reliable communication protocol with the same. 

Each Service has a personal **MIB** which makes it **unique** in the environment in which it operates.

.. lua:autoclass:: Service

Feature
---------

The **Feature** class represents the entity that contains the complete set of services that perform the same function. 

In fact, this class has a **MIB** that identifies a macro category within its environment. Each Feature has a feature called ``post`` which 
checks the postconditions of each result received. 

The responsibility of this class is also to identify the list of desired services that share the same network through the ``call`` function.

.. lua:autoclass:: Feature