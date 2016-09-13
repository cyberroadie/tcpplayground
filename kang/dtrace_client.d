uint64_t time[string];

syscall::bind:entry,
syscall::listen:entry,
syscall::accept:entry,
syscall::pollsys:entry,
syscall::read:entry,
syscall::write:entry
/ execname == "nc" /
{
	time[probefunc] = timestamp;
	printf("%s(%d, 0x%x, %4d)\n", probefunc, arg0, arg1, arg2);
}

syscall::bind:return,
syscall::listen:return,
syscall::accept:return,
syscall::pollsys:return,
syscall::read:return,
syscall::write:return
/ execname == "nc" && time[probefunc] > 0 /
{	
	elapsed = (timestamp - time[probefunc])/1000;
	printf("elapsed time %s (ms):%d\n", probefunc, elapsed);
}
