Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245E37757C
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122037; cv=none; b=BblMRxyfZSl63S5KVw22bawswxzmZBS9sem/I466hTcNmVgAPooGlirqfizvvgqKWIuDe9S2yTz+sp+cFf/JRVtEEm4+9k1H7Cz/j5HB9wQi9uRGNZO3BhJfBGuTHsy3q1IT/7ahh1Ov9K5E2FYj0geQrrRUueFQGztdTDzfEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122037; c=relaxed/simple;
	bh=A+oa7b/4hLHjAVA4dNTtCXzJC0TD9M3Ce1kb6VXg/F0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UI1aS56RKjzSN9ge1CCQzXbuiLRkUN+ACbjO4USOs2aH72h270SbF5knhX8OSoipCg6bgQYUBDRVU52q69p0ei4eRZaw5R2jXKdKYW4wzleZGxkXhycSqGAO0vB5XnSmuwqwJM7+4mv8vtJFLP827QjtORKS6N/ycZRz558jwaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-455ad408573so3592907fac.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122034; x=1786726834;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6+TeH4L3fLoIHr7KBCoOybLOigVRHKJmIcLVkS1FSY=;
        b=A/vUb4M91A/JL3Jwb1T8ahcPTUEjvvbu7uDl3ANQfxskTf3j1A+xgKKar47VGfdekj
         cSQfYULcrrjgdDt36VUn5XbTinuMRXi41ggki8STquwWCoHpct+yP1Shi54DMtp6tqyM
         Cs6nCb/9peecviQRmoKT6wmqYWb/iXjaB/ntNK1NHENjjIxO7Kjl5x/03bNFxVFtLbV4
         OILDcFka424JueZEJZeNsvZDxdNvomDcq7rzRHfKzFBdwKUYdk1Ht8l2QEs/fg3lbLcR
         iaNOZNhakjeKhm0Of2wuQfzZYibxziY7VC51beGqZQ6DQ2xzs4pj0P4iFBWRPdu/O5DS
         dCCA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1DmHoSAV49YqAMnAx1ZAZ5ft/gTv3nw+2cRvorgNt36joZeRvkhju2qMILL8rsh1jl228O2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VFBPZHEb67F3l9XDzciqr/FF9cy1wfFjbX+IXygxgcNLuQsv
	Rw8Oj7d9vrl5lH90lp94kME6WeFOujj36nUIhgD1FdcDR8oUWrn0TrQsiDSH1RQfsXZuLNAlZaJ
	NKqWTy184QcQzAndMdV9UiU9Ih7SMPVZ92pRali1jtUyXN1PPA020qqhBitY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b82:b0:6a1:4040:97c9 with SMTP id
 006d021491bc7-6ae96c848ecmr13298478eaf.9.1786122034725; Fri, 07 Aug 2026
 10:00:34 -0700 (PDT)
Date: Fri, 07 Aug 2026 10:00:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a760f32.01d0871a.3a0d52.004f.GAE@google.com>
Subject: [syzbot] [net?] memory leak in l2tp_tunnel_create (2)
From: syzbot <syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fc3c99580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7c2d1679fb08a2
dashboard link: https://syzkaller.appspot.com/bug?extid=d6fa74e3f19d6ee01e3a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10268132580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141697b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42469bee3e3a/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e97e8a3401c/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9204877a302c/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812fbbb200 (size 256):
  comm "syz.0.17", pid 6072, jiffies 4294946752
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ff56d525):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    l2tp_tunnel_create+0x55/0x130 net/l2tp/l2tp_core.c:1581
    pppol2tp_tunnel_get+0x132/0x250 net/l2tp/l2tp_ppp.c:654
    pppol2tp_connect+0x1f4/0x8d0 net/l2tp/l2tp_ppp.c:711
    __sys_connect_file+0x7a/0xb0 net/socket.c:2135
    __sys_connect+0xe1/0x110 net/socket.c:2154
    __do_sys_connect net/socket.c:2160 [inline]
    __se_sys_connect net/socket.c:2157 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2157
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888101d20b00 (size 1408):
  comm "syz.1.18", pid 6073, jiffies 4294946753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace (crc 66f8ac40):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    kmem_cache_alloc_noprof+0x34f/0x440 mm/slub.c:4931
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2246
    sk_alloc+0x36/0x3d0 net/core/sock.c:2308
    inet_create net/ipv4/af_inet.c:333 [inline]
    inet_create+0x168/0x4b0 net/ipv4/af_inet.c:259
    __sock_create+0x1a9/0x2d0 net/socket.c:1651
    sock_create net/socket.c:1709 [inline]
    __sys_socket_create net/socket.c:1746 [inline]
    __sys_socket+0xb7/0x1a0 net/socket.c:1793
    __do_sys_socket net/socket.c:1807 [inline]
    __se_sys_socket net/socket.c:1805 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1805
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812d56d7e0 (size 32):
  comm "syz.1.18", pid 6073, jiffies 4294946753
  hex dump (first 32 bytes):
    f8 52 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 42a7bc0e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __do_kmalloc_node mm/slub.c:5333 [inline]
    __kmalloc_noprof+0x3bf/0x550 mm/slub.c:5359
    _kmalloc_noprof include/linux/slab.h:992 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:218
    lsm_sock_alloc security/security.c:4478 [inline]
    security_sk_alloc+0x2d/0x290 security/security.c:4494
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2255
    sk_alloc+0x36/0x3d0 net/core/sock.c:2308
    inet_create net/ipv4/af_inet.c:333 [inline]
    inet_create+0x168/0x4b0 net/ipv4/af_inet.c:259
    __sock_create+0x1a9/0x2d0 net/socket.c:1651
    sock_create net/socket.c:1709 [inline]
    __sys_socket_create net/socket.c:1746 [inline]
    __sys_socket+0xb7/0x1a0 net/socket.c:1793
    __do_sys_socket net/socket.c:1807 [inline]
    __se_sys_socket net/socket.c:1805 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1805
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812d473880 (size 128):
  comm "syz.1.18", pid 6073, jiffies 4294946753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __do_kmalloc_node mm/slub.c:5333 [inline]
    __kmalloc_noprof+0x3bf/0x550 mm/slub.c:5359
    _kmalloc_noprof include/linux/slab.h:992 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    udp_lib_init_sock include/net/udp.h:295 [inline]
    udp_init_sock+0x88/0x120 net/ipv4/udp.c:1813
    inet_create net/ipv4/af_inet.c:391 [inline]
    inet_create+0x301/0x4b0 net/ipv4/af_inet.c:259
    __sock_create+0x1a9/0x2d0 net/socket.c:1651
    sock_create net/socket.c:1709 [inline]
    __sys_socket_create net/socket.c:1746 [inline]
    __sys_socket+0xb7/0x1a0 net/socket.c:1793
    __do_sys_socket net/socket.c:1807 [inline]
    __se_sys_socket net/socket.c:1805 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1805
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812fbbf800 (size 256):
  comm "syz.1.18", pid 6073, jiffies 4294946753
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 2ce433f4):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    l2tp_tunnel_create+0x55/0x130 net/l2tp/l2tp_core.c:1581
    pppol2tp_tunnel_get+0x132/0x250 net/l2tp/l2tp_ppp.c:654
    pppol2tp_connect+0x1f4/0x8d0 net/l2tp/l2tp_ppp.c:711
    __sys_connect_file+0x7a/0xb0 net/socket.c:2135
    __sys_connect+0xe1/0x110 net/socket.c:2154
    __do_sys_connect net/socket.c:2160 [inline]
    __se_sys_connect net/socket.c:2157 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2157
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812d747c00 (size 256):
  comm "syz.0.24", pid 6076, jiffies 4294946754
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8e7bd6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    l2tp_tunnel_create+0x55/0x130 net/l2tp/l2tp_core.c:1581
    pppol2tp_tunnel_get+0x132/0x250 net/l2tp/l2tp_ppp.c:654
    pppol2tp_connect+0x1f4/0x8d0 net/l2tp/l2tp_ppp.c:711
    __sys_connect_file+0x7a/0xb0 net/socket.c:2135
    __sys_connect+0xe1/0x110 net/socket.c:2154
    __do_sys_connect net/socket.c:2160 [inline]
    __se_sys_connect net/socket.c:2157 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2157
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
