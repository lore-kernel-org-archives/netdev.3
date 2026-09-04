Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8D3F4DC7
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543996; cv=none; b=Uxttq4Cn1h9uMe1OPjDqEgED+ZhoIhkhP+NQbcnDh1JZA99gVIuIRXdYVKsyQyGkYPKa2r5V/bQUE4BsThGqmJQ4ApTh/ca2o0vq8EyJ3lH+miqm24akSzX//62ZuDdu9pf/lqQKLV/IrV02+z1/8x5GB46jPl1+OqmON7pTR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543996; c=relaxed/simple;
	bh=Aq9Bhjqqep6oHAYLdXZcoyCDB0SBpjxzeBIB4qvz0nM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cv763Nj8RnoTx+RkZBVopwrQl/O7zR0SKsMMXPfYug0pQNNTD2ZQW0LeLf7cf3+boX1NWIku6voLcH0ivM89/4phKfzF5utaopO8SxJzM/ZPWQ+seFVdogpfQxVxPtGgmU1besGgybTTtnZil8+w0HGgndFkpxdEN9Wp7bEqE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b128c3af4bso135431eaf.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788543993; x=1789148793;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5VUHBlO0z49QR7LIDwdKlWg3VDkFrVJvHBXEnS8+cPw=;
        b=Rgrq0LaT+NAZXieSOvBL/3RO264oqcZEjmuMklCGvLQ4haXQcsXL1FW8joAZNfIHdA
         dxFOS5hMGlWByNxI61GBzEYjNol5i/0O9Zzu/h17hgpm5bw25qW5CUuteLO4i/brlI1c
         I7nCcl4WxyZ7NQcJCpNzDcsJuC3JRb0NxOYe53OwcbjMiSWTBxBlyvmU2S8BKxN1zX3G
         2KTZH0b6xj2aEe1YMdLsJMYY0B6JY0MB6+o8d8hzZzRYD8FgyByYPV3aeIeFTGp7bLlJ
         vBR+MFpG4RN/RNBX06EancDSTgmDkQCYuPhbMFeYSuNERR2n7c507f08TwDeUFcBjMnt
         GRFg==
X-Forwarded-Encrypted: i=1; AKwUvByHcPypacwBL/rLL1twW+q1vWqhaP6mwydJSy+evn1yaQeCbo6dv81EiaGQfG7i0tOk9UPaXzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kkIFovi1TYkujv+6hyulfE5pWkcI4P/WXIpK8Pu2W46Cc/AQfY
	7Kz/3FCPaZ7jGWKYkLTRH7u/yQ25YSlDHOEhweX5JVsA8/BNHS/W7NCI8dmo/4H7QCp4QFmBPiD
	O8zc1bKqqxcr0K29UbBI711El27KKsS7230+UBgxiV9C+1Aa665eOgQ0FCeU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:179b:b0:6b4:c316:6fdd with SMTP id
 006d021491bc7-6b6fd2ce829mr5897354eaf.19.1788543993352; Fri, 04 Sep 2026
 10:46:33 -0700 (PDT)
Date: Fri, 04 Sep 2026 10:46:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9b03f9.04649fcc.10325f.0003.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in __ip6_del_rt_siblings
From: syzbot <syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89a312991dc6 Merge tag 'cifs-fixes-7.3-rc2' of https://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14096f79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=a73e5ee0fd534fed75bd
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/120fc5c06ced/disk-89a31299.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/accc50a0c85b/vmlinux-89a31299.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0aec83a14f94/bzImage-89a31299.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 UID: 0 PID: 15348 Comm: syz.1.2507 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__ip6_del_rt_siblings+0x31e/0x7c0 net/ipv6/route.c:4056
Code: f7 4d 8d 74 24 10 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 80 fb 2d f8 4d 8b 36 49 83 c6 20 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 63 fb 2d f8 49 8b 06 4c 39 e0 74
RSP: 0018:ffffc9000564f120 EFLAGS: 00010202
RAX: 0000000000000004 RBX: ffffc9000564f430 RCX: 0000000000080000
RDX: ffffc90005222000 RSI: 0000000000000307 RDI: 0000000000000308
RBP: 1ffff110069ec605 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100c66d413 R12: ffff888034f63000
R13: dffffc0000000000 R14: 0000000000000020 R15: ffffc9000564f4b8
FS:  00007fd3d4c866c0(0000) GS:ffff888125bd5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb3e2f95ff8 CR3: 0000000060a36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ip6_route_del+0x1054/0x1110 net/ipv6/route.c:4232
 inet6_rtm_delroute+0x5d7/0x6d0 net/ipv6/route.c:5669
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7132
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x565/0x870 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd3d6a2e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd3d4c86028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd3d6cb5fa0 RCX: 00007fd3d6a2e159
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007fd3d6ac5024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd3d6cb6038 R14: 00007fd3d6cb5fa0 R15: 00007fff66fa0ad8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__ip6_del_rt_siblings+0x31e/0x7c0 net/ipv6/route.c:4056
Code: f7 4d 8d 74 24 10 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 80 fb 2d f8 4d 8b 36 49 83 c6 20 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 63 fb 2d f8 49 8b 06 4c 39 e0 74
RSP: 0018:ffffc9000564f120 EFLAGS: 00010202
RAX: 0000000000000004 RBX: ffffc9000564f430 RCX: 0000000000080000
RDX: ffffc90005222000 RSI: 0000000000000307 RDI: 0000000000000308
RBP: 1ffff110069ec605 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100c66d413 R12: ffff888034f63000
R13: dffffc0000000000 R14: 0000000000000020 R15: ffffc9000564f4b8
FS:  00007fd3d4c866c0(0000) GS:ffff888125bd5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa5bde16d58 CR3: 0000000060a36000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	f7 4d 8d 74 24 10 4c 	testl  $0x4c102474,-0x73(%rbp)
   7:	89 f0                	mov    %esi,%eax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	4c 89 f7             	mov    %r14,%rdi
  17:	e8 80 fb 2d f8       	call   0xf82dfb9c
  1c:	4d 8b 36             	mov    (%r14),%r14
  1f:	49 83 c6 20          	add    $0x20,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 63 fb 2d f8       	call   0xf82dfb9c
  39:	49 8b 06             	mov    (%r14),%rax
  3c:	4c 39 e0             	cmp    %r12,%rax
  3f:	74                   	.byte 0x74


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
