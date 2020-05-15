Example
===========

In the following section some examples will be shown that have the purpose of making 
the substance of the pattern **more concretely** understood and what some uses of this pattern may be.

Abstract
------------------

The concept of service management is of significant importance, as is the dynamism of the 
same, which plays an important role in the **reliability**, **stability** and **correctness** of the services provided.

In this context, **Share** allows you to change the semantics of a service according to the 
devices available at a given moment, thus leaving **complete freedom** on the low-level 
interaction model, preferring the modularity and composition of the services.

In order to correctly verify the constraints defined by the communicating devices, 
we have relied on an approach based on the design *by contract*, which defines ``pre-conditions`` and 
post-conditions on the values ​​provided respectively by the caller and the called party. In this 
way you have a guarantee on the validity and consistency of the data obtained.

Calculation of the square root
----------------------------------

For simplicity, assume that the service requested is the mere calculation of the 
square root on a set parameter. First of all, the device requesting the service must know the 
``MIB``, that is a regular expression that uniquely identifies a class of semantically equivalent functionality.

First step
        For example, if the category **"Mathematics"** had the number ``1`` 
        as specific ``MIB`` and the square root had the number ``2``, 
        the mib on which to make the call would be ``1.2.*``. 
        In this way the device is able to search, and eventually 
        **discover**, all the devices that provide services that at that 
        moment calculate the square root.

        Client side
            .. code-block:: lua

                -- 2 is the number on which we calculate the square root
                services["1.2.1.0"].features[1]:call(2)

        Server side
            .. code-block:: lua

                udp_discovery:sendto(Utilities:table_to_string(disc:find(data_discovery)), ip_discovery, port_discovery)

Second step
        Once the table of available services has been obtained, the 
        calling device interrogates these services **one by one** by 
        sending them the parameter on which to perform the calculation 
        *(in this case the pre-conditions must verify that this parameter 
        is greater than zero)*.

        Client side
            .. code-block:: lua

                check_param(mib, ..., udp_feature)

        Server side
            .. code-block:: lua

                if (services[mib].pre(param)) then 
                    udp_call:sendto(services[mib].func, ip_call, port_call)
                end

Third step
        In this phase, a **unicast communication** is initiated between the 
        devices (managed by the function and daemon functions) **which 
        guarantees confidentiality between the parties**, and in which the 
        calling device receives the function to be performed locally to 
        obtain the desired result.

        .. note:: 
            In computer networking, **unicast** refers to a one-to-one 
            transmission from one point in the network to another point; 
            that is, **one sender and one receiver**, each identified by a 
            network address.

        Client side
            .. code-block:: lua
                
                .
                .
                tcp:connect(host, port);
                tcp:send(data.."\n");
                .
                .
                local s, status, partial = tcp:receive()

        Server side
            .. code-block:: lua

                services[mib].daemon()

Fourth step
        Once the result is obtained, the calling device can decide 
        whether to validate this result *(checking it in the post-conditions)*
        or whether to move on to the next service. As soon as one of these 
        services is able to meet the established ``post-conditions``, the 
        **workflow** will end.

        Client side
            .. code-block:: lua
                
                if (res and self.post(..., res)) then
                    log.info("[POST-CONDITION SUCCESSFUL]")
                    return res, true
                end

Temperature measurement
--------------------------

The pattern also provides for the possibility of requesting services that 
**do not provide parameters** from the calling device. For example, we 
admit that a device needs to know the atmospheric room temperature to 
perform a certain task. This request does not include any parameter 
as the calculation of the temperature is a procedure that **does not involve 
any operation on the data**, but simply makes a measurement and query a 
possible thermometer.

First step
        The calling device will therefore simply need to invoke the ``MIB`` 
        that identifies any service that has a thermometer, in this case 
        for purely demonstrative purposes it is assumed to be ``2.1.*``

        Client side
            .. code-block:: lua

                -- the call function has no parameter as you can see
                services["2.1.1.0"].features[1]:call()

        Server side
            .. code-block:: lua

                udp_discovery:sendto(Utilities:table_to_string(disc:find(data_discovery)), ip_discovery, port_discovery)

Second step
        Once the table of available services is obtained, the calling device 
        **interrogates** these services one by one (in this case the ``pre-conditions`` 
        are always exceeded as no parameters are received).

        Client side
            .. code-block:: lua

                check_param(mib, ..., udp_feature)

        Server side
            .. code-block:: lua

                if (services[mib].pre(param)) then 
                    udp_call:sendto(services[mib].func, ip_call, port_call)
                end

The third and fourth steps correspond exactly to the example shown above.

Nested call
-----------------

A ``nested call`` is defined as any context in which the device called, **to fulfill the
result of the local computation**, it needs to in turn make a call to another service.

In-depth explanation 
~~~~~~~~~~~~~~~~~~~~~~~~~

Home automation devices, smart industry, smart city, smart energy or any other type of device
they are installed over time and vary in number and type **without** a pre-arranged installation plan.

Providing services that include **their collaboration** is difficult because interconnection
and service interaction protocols are different and could vary over time.

In this context, the adaptive and very flexible nature of the pattern allows the 
possibility **to perform nested calls between devices**, so as to further enhance the concept 
of interoperability between the themselves and take full advantage of the 
dynamism that distinguishes them.


Concrete demonstration
~~~~~~~~~~~~~~~~~~~~~~~~~

Let's consider a sporting event, where racing bikes compete. Suppose it 
is necessary calculate the speed of the bikes and compare them to 
each other to understand which is the **best** rider.

The devices available are:

- A **big screen**, which shows a general ranking to the fans based on the average speed of the drivers

- **Speed detectors** scattered across the track, which could be of different brands and calculate speeds with different measurement systems *(km/h, m/s, mph)*

- A **classification device**, which sorts the set of all speeds detected in descending order and ensures uniformity between data *(converts m/s to km/ h or vice versa)*

In this context, the maxi-screen, in order to update the 
data shown in the table, **makes a call to the classification device, 
which in turn makes a call to the speed detectors to first receive 
any updates on the drivers' speeds**.

All these logics can be developed on the individual devices that have 
competence on the actions they undertake according to the different 
configurations that are detected allowing ``flexibility``, ``adaptation`` 
and ``fault tolerance`` to the system.