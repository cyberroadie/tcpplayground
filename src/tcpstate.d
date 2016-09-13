#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=10

int last[int];

dtrace:::BEGIN
{
        printf(" %3s %12s  %-20s    %-20s\n", "CPU", "DELTA(us)", "OLD", "NEW");
}

tcp:::state-change
/ last[args[1]->cs_cid] /
{
        this->elapsed = (timestamp - last[args[1]->cs_cid]) / 1000;
        printf(" %3d %12d  %-20s -> %-20s\n", cpu, this->elapsed,
            tcp_state_string[args[5]->tcps_state], 
					 tcp_state_string[args[3]->tcps_state]);
        last[args[1]->cs_cid] = timestamp;
}

tcp:::state-change
/ last[args[1]->cs_cid] == 0 /
{
        printf(" %3d %12s  %-20s -> %-20s\n", cpu, "-",
            tcp_state_string[args[5]->tcps_state],
            tcp_state_string[args[3]->tcps_state]);
        last[args[1]->cs_cid] = timestamp;
}