Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58600365A00
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482425; cv=none; b=Mg7zdrNPziniMtveA3dLBhXcQXPyqI6jKsyz7VuwR6mvSrL1FhS+3jhbvFqfDLJeJu+AQQq2KU5TGce5v9lUfnyvgP4fYFQSvCQQwdaz6SnzMlYkpFiglCOBABb/OTxBYn42zoWxwXUY06ZHH+TLJFxJi/rYeCbZ1mtwNv63P9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482425; c=relaxed/simple;
	bh=8E/LciLa3IYLzRf+Zlz5yzVyJpFpMka4OSWFlI6bQdk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mt6K7Sak6s6g5nK17GkYZssXIARIB8+LlJraqRLqWxrnLlCzNrLrOKfCvtU+mOkRz3kmrcrF4yXHzl72wDvKzItWtVbfjwF0OPjTZ3FUIs/eTnQCGiIlLQwFZkhd0/bqHPMX+uRqow9JlhOM13YbVqYXx+DYIG2L06RlfoPPF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49ab6a82cd5so911786b6e.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785482422; x=1786087222;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljhdjo0fMR4e/Us3tqIvPkeAArgmpt1zk20VsMrfHKA=;
        b=I8oCYMhCJxNR1EdTuE4zIxXzY+7EYOE+oAxCbXhHdrDbtdzZ66XNI9LtGv2Cp5GuC5
         +h1BcovqarilqTL2+5MI6kyjNqqBrgMTKozItE1azV7avE+jDKCBgoltUm7zD/rtPoGG
         k2gBy4KCaA8PoRBVZGJeoc3YYpB+4RA1DRg6mK36TM8+6UFHnmk/5ODHL8H+15ngXvjW
         g7lDzhQ5hKlpMOXWHj92510PWsGhbGU5rmuFSFyv8kZnMaP3pKyDat9rX0pCevEsn0jO
         XebLN+E+xZ2aRx8/xDzKLkr+XidvVTXuMibh+E7Nwlm8tCgWe12SJOGr8innFFwXSPwf
         1HlA==
X-Forwarded-Encrypted: i=1; AHgh+RrvYmOolfm9/Z1lZpwSSrpUNMMtY/1XZNLt0LpJIUqWOJ4H2F6k2PpMRnkHoyc8DUqy+g9Wf9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUXIBswPXsUo4cLs89jLLdMv0UpWaeKxQWv39QVrKgaeTe62L
	5EqM/Pdp8nQo5HgSMQdnyyPlogoH2yfp/CKhC5kBcVdJ9odBNQDtLzmBLT30YS6ac8anmxwSI/Y
	HwmY2D+RsaDmGuOzxQLyR8+v6A88mKHZSm9vNWL/MyU/KUQli+teBNfk308I=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c413:b0:4a4:da68:9434 with SMTP id
 5614622812f47-4ae4c40689amr967166b6e.14.1785482422328; Fri, 31 Jul 2026
 00:20:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 00:20:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6c4cb6.77639fcc.3d4fd0.0021.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in xfrm_send_migrate_state
From: syzbot <syzbot+b9e97485773456b16a4a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    365f9c7a6b81 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14863632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72c97575381cec47
dashboard link: https://syzkaller.appspot.com/bug?extid=b9e97485773456b16a4a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12863632580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b0e49e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eafe0adb7386/disk-365f9c7a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29422d607579/vmlinux-365f9c7a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98ca955a8b54/Image-365f9c7a.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9e97485773456b16a4a@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
net/xfrm/xfrm_user.c:1630 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.0.17/4942:
 #0: ffff0000d8a19c50 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_netlink_rcv+0x70/0x9c net/xfrm/xfrm_user.c:3928

stack backtrace:
CPU: 0 UID: 0 PID: 4942 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 lockdep_rcu_suspicious+0x168/0x26c kernel/locking/lockdep.c:6876
 xfrm_nlmsg_multicast net/xfrm/xfrm_user.c:1630 [inline]
 xfrm_send_migrate_state+0x6b0/0x958 net/xfrm/xfrm_user.c:3340
 xfrm_do_migrate_state+0x1114/0x1728 net/xfrm/xfrm_user.c:3507
 xfrm_user_rcv_msg+0x4e0/0x950 net/xfrm/xfrm_user.c:3907
 netlink_rcv_skb+0x238/0x414 net/netlink/af_netlink.c:2556
 xfrm_netlink_rcv+0x80/0x9c net/xfrm/xfrm_user.c:3929
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x600/0x7f8 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x648/0x948 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0xc8/0x17c net/socket.c:790
 ____sys_sendmsg+0x3d0/0x6c8 net/socket.c:2684
 ___sys_sendmsg+0x198/0x224 net/socket.c:2738
 __sys_sendmsg+0x158/0x204 net/socket.c:2770
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2773
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594


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
