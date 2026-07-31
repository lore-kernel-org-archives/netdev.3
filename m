Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2B3101C0
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481104; cv=none; b=aS+3djSFLRltyGaPzRORGFvlfWMGpoFz3WtrLFoqV7CmsvijiH+H6U7tgHmgryYGklb+aCCKGZDX/67wVbRRo2jYpzAR7ANXaPl/bT8fsZ9/Y3ApuYdNBR38aWAmEqbPuBEtRwdG6ZLc99oQy6CSV91DJTVJGqlEztAKER/hE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481104; c=relaxed/simple;
	bh=U/aUJssbFDVShhs3jI/L1wEPdHplGQXWwAdRRKJarH0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GK5HBNIepZ6qFHXg6qKOBPVPhGWOoxCSNl6PJaZIjoTrANoYDDwMAD4E2NamzuR/RvXsdbOH9Xg8dLdonhnNyIqQL9Vxus5pTWWXFZyfLzm0jM/3EJ8I6FteAHtaqr+pkdUbn588vR+2owJ5sJWo6hsMV2pXIlW0shn9oEgytOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49f3a97f1caso435775b6e.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481102; x=1786085902;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHauDrZbyLbJNwi2kBXhjYQh1jMBcJwNHp/E6dnN5vo=;
        b=DYLJfn5u9XQIa1k+vT01a3hb/QGKxKI0o+WKkLciSdCTYplf+XZ9FduxxwwSG6mYq+
         8RN/BkKAUtO2dV04cCw9Jmbkf0rqkWKYi3d3RjhiX+cZPcq0pkCQCX6GcsNbJ57ZUo4s
         ZRpmK7FBpiqpJTeP+UuJtmyDy0oyARcBkhCMLHJWhHfnUZltZ7MQhrgI2saAMxyTu/vB
         Jxl1osJaoRwx2KG/LXnqmO0kuH7uDrpPS68eDqjMXv6Sh0xipXWmCbxWs0O0Anf7JUIQ
         Aq0ZqeL6oJiJMAS3bJjvxLZmqSJW84AQ8/wKqUstZ48M0HM1MbXSgGccGPhwhZ62+tCv
         6t5w==
X-Forwarded-Encrypted: i=1; AHgh+RoLjhqEvtmq7B91x/xidoUSL2t4PDqyXe58YyYD7k1DZBrT/Z/5lzcoWoiev1hXrBf8qxH26IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNbAwOMCHJPeVYIrGPt1v15svqOY4ebpqJYQKW//2kHQyDzSO
	JhoN8slsL9hI/U/WF8hbmEiXq6HiG7IQUtn0w08mfjYYCgH0ISXCechg83UdkZazXrhdMxrdpi5
	vbOz0eEpG8zF0pysS5NF8my+e0+dIYp4iSEUZjZy3mgdAOz7uhb9G2o+HNFo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1994:b0:4a4:af7f:83d3 with SMTP id
 5614622812f47-4ae5ab9ef78mr727757b6e.20.1785481101937; Thu, 30 Jul 2026
 23:58:21 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6c478d.b5e7dbf9.21bf3.0007.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in xfrm_nlmsg_multicast
From: syzbot <syzbot+c0e99a1aa85a286d7a3b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4235cb24ec1e Merge tag 'vfs-7.2-rc5.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126091b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=c0e99a1aa85a286d7a3b
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f16499580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5e6b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34e9a122d3c0/disk-4235cb24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c47e8d86e0/vmlinux-4235cb24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b287db60160f/bzImage-4235cb24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0e99a1aa85a286d7a3b@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
net/xfrm/xfrm_user.c:1630 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.0.17/5947:
 #0: ffff888029cda048 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_netlink_rcv+0x6a/0x90 net/xfrm/xfrm_user.c:3928

stack backtrace:
CPU: 1 UID: 0 PID: 5947 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 xfrm_nlmsg_multicast+0x1d8/0x1f0 net/xfrm/xfrm_user.c:1630
 xfrm_send_migrate_state+0x870/0xae0 net/xfrm/xfrm_user.c:3340
 xfrm_do_migrate_state+0x1749/0x1e90 net/xfrm/xfrm_user.c:3507
 xfrm_user_rcv_msg+0x7a8/0xf30 net/xfrm/xfrm_user.c:3907
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3929
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x565/0x870 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb235fede99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc10a8b768 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb236275fa0 RCX: 00007fb235fede99
RDX: 0000000000000000 RSI: 0000200000000500 RDI: 0000000000000003
RBP: 00007fb236083eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb236275fac R14: 00007fb236275fa0 R15: 00007fb236275fa0
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
