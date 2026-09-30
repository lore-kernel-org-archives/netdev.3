Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261051617E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787762; cv=none; b=gGKTpG62ZPnZYjbFgoUHmmx/cpAoY9iMZqjwanNlBnHWuCCeSGYxoJqXJp+0dAGLkU2VX1P0K0Ta4JqiDvpjwiCsmk8AW/3tP4WdTWXvonfKVE1rnDHcusOuA+CV3BhALXiTUZe3qmfrICly/swEG5LpSEgeP++jUJmsU8oUm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787762; c=relaxed/simple;
	bh=dALmUEdG5EWfXTijtmFQiMsJEwrQV+3rOWZZ8DyLmx8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XEqWbed4VpXKG9OdEVhSLPmumYzVg75T5sE3QhRy6tT5Iwxgyvwv5NPZ5YoWZLQar4AlhxaKSemO79s5f4Hwtx5QzJDFPL8wBtG4spZ2vZjE+RSud/3lUWPbfgK6hywaprkTjDHMyebPMf/lf/7i13TkmvYNYN3IvPK/30idUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b1bc2e44e0so8590477b6e.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787760; x=1791392560;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmynAp8tHrw2Eto/AmEqwtrm2Mc1Vd5QPga8ueQFsN4=;
        b=gDSaZ9KntInAeSQMhTECZ0qytPHe1a9OsHc2b4JO/L2WrHK6uTb/cqP0yDlwpP/kdN
         dvCFMM+LwjicHDldl/A3/U3RmDgid5+vvKnaZTv2ZZVaCscnZu/YzrrKzrRby2+//riO
         bAk2YINeTGxgojwYmoLna1U9fwWvigajRD56gjmf3FJ8qbyk5mAhAbxHaSnxjJYcelMc
         mZ4509/yO9GDJFW+i5+vvfiZ4zjhViLeqcySrrNKE8zvH972+fjrfS7VnjyTsTEp333r
         ngKKoPwFv3I8WPAH2RYEwf0+JNLmrACUkIVRSLyfAWqcp7LL8HwyjsueiF6r0rnAD1sq
         RI9w==
X-Forwarded-Encrypted: i=1; AKwUvBydjGBLcp0/DTLMWuNZYdcXHWDJOdbTzayBY/kc/PRwyzIihWXW9H4QkmOD6kgYyMehBuXoNqI=@vger.kernel.org
X-Gm-Message-State: AFuF++mPLXVw+AhfiF0kEuongFh0APn+PAs+XoO7e+z2pXY17Jx13QsM
	n2F2BwCilIimuQ/ujfauwChxpcKjR4Io+LHkCgDUZXFDJDdAwI8TkzeFM3Fyco8scIPjcFond4m
	lzZu/CdR4aG8FTHUt2RGET2i2MCnhaxSy/HA6+3GWBPl10Gl8qgc8Is94Ikw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bce:b0:4d6:90d3:e18e with SMTP id
 5614622812f47-4f1b85c2d2dmr2235776b6e.45.1790787759808; Wed, 30 Sep 2026
 10:02:39 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:02:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abd40af.fac9d4e5.17396.0008.GAE@google.com>
Subject: [syzbot] [openvswitch?] WARNING in set_ipv6_addr
From: syzbot <syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com>
To: aconole@redhat.com, davem@davemloft.net, dev@openvswitch.org, 
	echaudro@redhat.com, edumazet@google.com, horms@kernel.org, 
	i.maximets@ovn.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    47a144672573 Merge branch 'mptcp-misc-improvements-for-v7-4'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1342db25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88147dd7e4cb6a0f
dashboard link: https://syzkaller.appspot.com/bug?extid=4cc63fcfb3845e149969
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c35e05580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11908035580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/974586b80355/disk-47a14467.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/05ff7f1eb7cf/vmlinux-47a14467.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d63ff990e2c6/bzImage-47a14467.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com

ovs-dp0: entered promiscuous mode
------------[ cut here ]------------
!skb_transport_header_was_set(skb)
WARNING: ./include/linux/skbuff.h:3075 at skb_transport_header include/linux/skbuff.h:3075 [inline], CPU#1: syz-executor463/5635
WARNING: ./include/linux/skbuff.h:3075 at skb_transport_offset include/linux/skbuff.h:3250 [inline], CPU#1: syz-executor463/5635
WARNING: ./include/linux/skbuff.h:3075 at update_ipv6_checksum net/openvswitch/actions.c:361 [inline], CPU#1: syz-executor463/5635
WARNING: ./include/linux/skbuff.h:3075 at set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399, CPU#1: syz-executor463/5635
Modules linked in:
CPU: 1 UID: 0 PID: 5635 Comm: syz-executor463 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:skb_transport_header include/linux/skbuff.h:3075 [inline]
RIP: 0010:skb_transport_offset include/linux/skbuff.h:3250 [inline]
RIP: 0010:update_ipv6_checksum net/openvswitch/actions.c:361 [inline]
RIP: 0010:set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399
Code: f6 e8 12 d3 05 00 ba 10 00 00 00 4c 89 ef 48 89 ee 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 14 89 7a f6 e8 ff 80 0a f6 90 <0f> 0b 90 48 8b 44 24 10 42 0f b6 04 30 84 c0 0f 85 c8 01 00 00 41
RSP: 0018:ffffc90003b3ee68 EFLAGS: 00010293
RAX: ffffffff8bbd5b01 RBX: 000000000000ffff RCX: ffff8880780bbe80
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: 000000000000004c R08: 0000000000000001 R09: 0000000000000011
R10: 000000000000001f R11: 0000000000000000 R12: ffff888071cdbd36
R13: ffff88802d028396 R14: dffffc0000000000 R15: ffff888071cdbc80
FS:  0000555579c36400(0000) GS:ffff888124dc5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd90696af0 CR3: 000000007065a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 set_ipv6 net/openvswitch/actions.c:531 [inline]
 execute_masked_set_action net/openvswitch/actions.c:1073 [inline]
 do_execute_actions+0x557e/0x8600 net/openvswitch/actions.c:1366
 ovs_execute_actions+0xde/0x520 net/openvswitch/actions.c:1592
 ovs_packet_cmd_execute+0xb4f/0xf10 net/openvswitch/datapath.c:705
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
 __sock_sendmsg net/socket.c:818 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2715
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2769
 __sys_sendmsg net/socket.c:2801 [inline]
 __do_sys_sendmsg net/socket.c:2806 [inline]
 __se_sys_sendmsg net/socket.c:2804 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2804
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe073a4fd39
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffece969af8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffece969c28 RCX: 00007fe073a4fd39
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffece969c28 R09: 00007ffece969c28
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffece969c18
R13: 0000000000000002 R14: 00007fe073ae0ca0 R15: 0000000000000002
 </TASK>


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
