uint64_t time[string];

syscall::connect:entry,
syscall::poll:entry,
syscall::close:entry,
syscall::read:entry,
syscall::write:entry
/ execname == "nc" /
{
	time[probefunc] = timestamp;
	printf("%s(%d, 0x%x, %4d)\n", probefunc, arg0, arg1, arg2);
}

syscall::connect:entry,
syscall::poll:entry,
syscall::close:entry,
syscall::read:return,
syscall::write:return
/ execname == "nc" && time[probefunc] > 0 /
{	
	elapsed = (timestamp - time[probefunc])/1000;
	printf("elapsed time %s (ms):%d\n", probefunc, elapsed);
}
