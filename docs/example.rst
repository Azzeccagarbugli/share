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