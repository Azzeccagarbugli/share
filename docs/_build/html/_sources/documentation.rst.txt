Documentation
==================

    *One documentation to rule them all,
    one documentation to find them,
    One documentation to bring them all
    and in the darkness bind them.* [1]_

The entire generated documentation that is being used is the result of the union between **Sphinx** and ``sphinx-lua``, 
two tools dedicated to the generation of texts starting from mere and pure code.

Tools with which it was made
--------------------------------

Usually the part of the code documentation in Lua is somewhat **boring** and **stylistically questionable**.

From this premise comes the integration of Sphinx [2]_ within the project which has made the entire software 
park a *pleasant* and *clear* product in **understanding its API**.

Integration with Lua
-----------------------

For the documentation of the classes created, therefore, we relied on a tool that puts **Python** *(given the nature of Sphinx)* and **Lua** in symbiosis.

This tool is called ``sphinx-lua`` [3]_.

It can be easily installed using the following command:

.. code-block:: 

    pip install sphinx-lua 

Once that you installed this on your machine your could simply start to document your class in this way:

.. code-block:: lua

    --- Define a car.
    --- @class MyOrg.Car
    local cls = class()

    --- @param foo number
    function cls:test(foo)
    end

.. [1] *Modified version of The One Ring, the central plot element in J. R. R. Tolkien's The Lord of the Rings (1954–55). It first appeared in the earlier story The Hobbit (1937) as a magic ring that grants the wearer invisibility*
.. [2] *Sphinx is a documentation generator written and used by the Python community. It is written in Python, and also used in other environments.*
.. [3] `GitHub page of the project sphinx-lua <https://github.com/boolangery/sphinx-lua>`_