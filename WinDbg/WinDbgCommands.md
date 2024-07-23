# WinDbg Commands

## Using SOS

https://learn.microsoft.com/en-us/dotnet/framework/tools/sos-dll-sos-debugging-extension

Load SOS:

```
.load c:\Windows\Microsoft.NET\Framework64\v4.0.30319\sos.dll
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

## Using SOSEX

https://knowledge-base.havit.eu/2017/10/09/windbg-sosex-help-command-reference/

Load SOSEX:

```
.load C:\Users\GaborHorvath\OneDrive - Telio Group\Desktop\Sosex\sosex.dll
```

Build heap index:

```
!bhi
```

Dumps the contents of the specified generation:

```
!dumpgen 2 -stat
```

```
!dumpgen 2 -type System.Data.SqlClient._SqlMetaData
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