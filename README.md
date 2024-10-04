# nqueen solver

Simple nqueen solver written in zig

It currently is single threaded, but multi threaded behaviour might be
implemented later on when needed.

> [!WARNING]
> This code does not follow proper zig writing style such as allocators being
> passed to structs for initialization, it instead uses the libc allocator.
