# WinDbg Commands

## Using SOS

https://learn.microsoft.com/en-us/dotnet/framework/tools/sos-dll-sos-debugging-extension

Load SOS:

```
.load c:\Windows\Microsoft.NET\Framework64\v4.0.30319\sos.dll
```

```
.loadby sos clr
```

Find instances with a specific MemoryType:

```
!DumpHeap /d -mt 00007ffed944bc28
```

GCRoot:

```
!GCRoot 00000263673c1258
```

Dump Heap:

```
!DumpHeap -stat
```

Dump Object:

```
!DumpObj /d 00000263673c1258
```

```
!threads
```

```
ThreadCount:      2551
UnstartedThread:  0
BackgroundThread: 179
PendingThread:    0
DeadThread:       2372
Hosted Runtime:   no
                                                                                                        Lock  
       ID OSID ThreadOBJ           State GC Mode     GC Alloc Context                  Domain           Count Apt Exception
   8    1 9e9c 00000262dee825b0    28220 Preemptive  0000000000000000:0000000000000000 00000262def1c870 0     Ukn 
  50    2 99d8 00000269d2645f50  202b220 Preemptive  0000000000000000:0000000000000000 00000269e714fd40 0     MTA (Finalizer) 
  52    3 7f14 00000269d267dd90  102a220 Preemptive  0000000000000000:0000000000000000 00000262def1c870 0     MTA (Threadpool Worker) 
  53    4 be00 00000269d269a050  2021220 Preemptive  0000000000000000:0000000000000000 00000262def1c870 0     Ukn 
XXXX    6    0 00000269d2ae2b30  8038820 Preemptive  0000000000000000:0000000000000000 00000262def1c870 0     MTA (Threadpool Completion Port) 
XXXX    8    0 00000269d2c34b00  1039820 Preemptive  0000000000000000:0000000000000000 00000262def1c870 0     Ukn (Threadpool Worker) 
```

```
!ThreadState 202b220
```

```
    Legal to Join
    Background
    CLR Owns
    CoInitialized
    In Multi Threaded Apartment
    Fully initialized
    Interruptible
```

```
~~[99d8]s
```

```
!clrstack
```

## Using SOSEX

https://knowledge-base.havit.eu/2017/10/09/windbg-sosex-help-command-reference/

Load SOSEX:

```
.load c:\Temp\Sosex\sosex.dll
```

Dump stat:

```
.shell -i- -ci "!dumpheap -stat" findstr "^" > o:\Public\20240710_UnityMemoryDump\dumpstat.log
```

Build heap index:

```
!bhi
```

Load heap index:

```
!lhi o:\Public\20240710_UnityMemoryDump\w3wp_HeapIndex.bin
```

Dumps the contents of the specified generation:

```
!dumpgen 2 -stat
```

```
!dumpgen 2 -type System.Data.SqlClient._SqlMetaData
```

Dump into file:

```
.shell -i- -ci "!dumpgen 2 -type System.Data.SqlClient._SqlMetaData" findstr "^" >o:\Public\20240710_UnityMemoryDump\\dumpgen2.log
```

Displays the fields of an object or type:

```
!mdt 00000263673c1258
```

```
!mdt -e:2 00000263673bfcf8
```

Displays all references from and to the specified object:

```
!refs 00000263673c1258
```

Displays GC roots for the specified object:

```
!mroot 00000262e7aae4d0
```