Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACB17BCA
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745335; cv=none; b=Gj+IL01AlVHSRAg/9+1gFwBABM/87O0iEfgZX8mScui33awtsjW7F6ZtJ0KvvaaKF5ih9w0IuhifV5oEtbK7qeW2rA2P3IekWuYVuu7RHtLxzw/Pblclg2ynQG2rnjzBfni3CxLktf+xlne6HCL6GLfCLR2j/NKXBohRb5Jewic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745335; c=relaxed/simple;
	bh=WQOg1GVIOHW5KRCh3gpzmCsFm/tWYnoVt2bAdpgllkg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jqGdJmuQ41YairYS7ZTjpv4osCWquAoXqn2dbdYa9pePXp7kONuiPGr2b3KakoDPHXzDnqaF4FD0cUm9LAO6HRjU3Dgc6WhnHxrGzAccAP3tTonKhZ5r3IYDIyg4tpaCin1W3mpHVkM0NM99pCMnrlR+GHs7NGyVS9nMH/yeBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45958a0c7c4so279260fac.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 04:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745333; x=1788350133;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFYWTRqsZ+S1YPbAJm/ppesJOdbaQUOz76T2WSP5MLs=;
        b=MaHl21+ZLD9mYw2vsE7nYooE75oTN4HnDDDTCAwk55LriO96bf2ttvhaSjSsgazE0k
         xfQSyqK1o7quF6a00gsCHwMpvsdFFaWOCV9t5mPFbHLeTVReOt2D93gdGYVWjZOMhnxy
         d3Us1QjQE8HDgD7YIazFKfujVIGnlaD3FNPaQt3BHJ9uAJqhCp+IKW9thfHGUfyQLsX/
         F1fuk8UoqKqrrTlVFjXwWp+ElUWwpLqkrMyramGIMTwfvF9s9CQDNP4Rvi0D+HhCEoVN
         MZ8Bt9OU9DFOjphHnCUMpYQeb6rxFc/HtsQbY1ubCdymcEv8zYe2fle8bJDI0zqw98w6
         TISA==
X-Forwarded-Encrypted: i=1; AHgh+RoNxyWDiJNRL8cQqU32b22Lpb0MgPxirArfQ8nceu1+ARr+MCBVpFHKqZ2ulezsRt9Sexf11uA=@vger.kernel.org
X-Gm-Message-State: AFuF++nBFE3riIrUM7K0NkzIg/hKrFLjLIFCmpUELGqL3rUURAgS682B
	w7cT3ovxHqIAxcm4PAF11tpNyNu98mLF2jShAbqSyUJ6EMVPBAoJCEnAE1mNY24+jVI1Ol/Z8DW
	IxDM2bZwnq3eCX5Dbu1nNaSY1jFsLaZQUWeoWPICbtjpT49txljm1r7yqMTc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a28f:10b0:6ae:a950:9faa with SMTP id
 006d021491bc7-6b1a03c51c4mr4179543eaf.10.1787745332788; Wed, 26 Aug 2026
 04:55:32 -0700 (PDT)
Date: Wed, 26 Aug 2026 04:55:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8ed434.1d9ded08.62e62.00a9.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in ip_check_mc_rcu
From: syzbot <syzbot+a5a07d2f6a71972dc5ed@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f6f3b36c15ed net: ethernet: qualcomm: remove unneeded 'fas..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15de4b46580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=a5a07d2f6a71972dc5ed
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47ae09206bf6/disk-f6f3b36c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e3daf94ae30/vmlinux-f6f3b36c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c266cfd24092/bzImage-f6f3b36c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5a07d2f6a71972dc5ed@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.4.3416/18916 is trying to acquire lock:
ffff888042dfe6b0 (&im->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
ffff888042dfe6b0 (&im->lock){+.-.}-{3:3}, at: ip_check_mc_rcu+0x448/0x670 net/ipv4/igmp.c:2869

but task is already holding lock:
ffff8880331d08b0 (&im->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
ffff8880331d08b0 (&im->lock){+.-.}-{3:3}, at: igmpv3_send_cr net/ipv4/igmp.c:727 [inline]
ffff8880331d08b0 (&im->lock){+.-.}-{3:3}, at: igmp_ifc_timer_expire+0x852/0x10b0 net/ipv4/igmp.c:843

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&im->lock);
  lock(&im->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

9 locks held by syz.4.3416/18916:
 #0: ffffffff9057afc0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff9057afc0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff9057afc0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:595
 #1: ffffffff9002c240 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff9002c240 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:366 [inline]
 #1: ffffffff9002c240 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc10/0x1c30 net/core/rtnetlink.c:4194
 #2: ffffffff8eb4bfa0 (console_lock){+.+.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2026 [inline]
 #2: ffffffff8eb4bfa0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x2cf/0x560 kernel/printk/printk.c:2478
 #3: ffffffff8ea33838 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:305 [inline]
 #3: ffffffff8ea33838 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:428 [inline]
 #3: ffffffff8ea33838 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:291 [inline]
 #3: ffffffff8ea33838 (console_srcu){....}-{0:0}, at: console_flush_one_record kernel/printk/printk.c:3246 [inline]
 #3: ffffffff8ea33838 (console_srcu){....}-{0:0}, at: console_flush_all+0x123/0xaf0 kernel/printk/printk.c:3343
 #4: ffffc90000a08cc0 ((&in_dev->mr_ifc_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd4/0x5e0 kernel/time/timer.c:1745
 #5: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: igmpv3_send_cr net/ipv4/igmp.c:689 [inline]
 #5: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: igmp_ifc_timer_expire+0x28/0x10b0 net/ipv4/igmp.c:843
 #6: ffff8880331d08b0 (&im->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
 #6: ffff8880331d08b0 (&im->lock){+.-.}-{3:3}, at: igmpv3_send_cr net/ipv4/igmp.c:727 [inline]
 #6: ffff8880331d08b0 (&im->lock){+.-.}-{3:3}, at: igmp_ifc_timer_expire+0x852/0x10b0 net/ipv4/igmp.c:843
 #7: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #7: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: xfrm_policy_get_afinfo+0x30/0x1b0 net/xfrm/xfrm_policy.c:263
 #8: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #8: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #8: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: ip_route_output_key_hash+0xd8/0x2a0 net/ipv4/route.c:2701

stack backtrace:
CPU: 1 UID: 0 PID: 18916 Comm: syz.4.3416 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/25/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x24df/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:182
 spin_lock_bh include/linux/spinlock.h:348 [inline]
 ip_check_mc_rcu+0x448/0x670 net/ipv4/igmp.c:2869
 __mkroute_output net/ipv4/route.c:2600 [inline]
 ip_route_output_key_hash_rcu+0xe7f/0x2720 net/ipv4/route.c:2872
 ip_route_output_key_hash+0x18d/0x2a0 net/ipv4/route.c:2702
 xfrm4_get_saddr+0xb6/0x170 net/ipv4/xfrm4_policy.c:57
 xfrm_get_saddr net/xfrm/xfrm_policy.c:2472 [inline]
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2508 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2567 [inline]
 xfrm_resolve_and_create_bundle+0x6df/0x3070 net/xfrm/xfrm_policy.c:2865
 xfrm_bundle_lookup net/xfrm/xfrm_policy.c:3100 [inline]
 xfrm_lookup_with_ifid+0x576/0x1b40 net/xfrm/xfrm_policy.c:3231
 xfrm_lookup net/xfrm/xfrm_policy.c:3330 [inline]
 xfrm_lookup_route+0x3c/0x1c0 net/xfrm/xfrm_policy.c:3341
 ip_route_output_ports include/net/route.h:213 [inline]
 igmpv3_newpack+0x2a7/0x1190 net/ipv4/igmp.c:402
 add_grhead+0x70/0x340 net/ipv4/igmp.c:473
 add_grec+0x1123/0x13e0 net/ipv4/igmp.c:607
 igmpv3_send_cr net/ipv4/igmp.c:744 [inline]
 igmp_ifc_timer_expire+0x93e/0x10b0 net/ipv4/igmp.c:843
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:console_flush_one_record arch/x86/include/asm/irqflags.h:-1 [inline]
RIP: 0010:console_flush_all+0x7d2/0xaf0 kernel/printk/printk.c:3343
Code: ff ff e8 71 2d 21 00 90 0f 0b 90 e9 9c fc ff ff e8 63 2d 21 00 e8 3e b0 29 0a 48 85 db 74 c0 e8 54 2d 21 00 fb 48 8b 5c 24 18 <48> 8b 44 24 28 42 80 3c 20 00 4d 8d 77 58 74 08 4c 89 f7 e8 e6 b9
RSP: 0018:ffffc90002fe6840 EFLAGS: 00000283
RAX: ffffffff81a544ec RBX: ffffc90002fe69a0 RCX: 0000000000080000
RDX: ffffc9000db64000 RSI: 0000000000043066 RDI: 0000000000043067
RBP: ffffc90002fe6950 R08: ffffffff905775f7 R09: 1ffffffff20aeebe
R10: dffffc0000000000 R11: fffffbfff20aeebf R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffffffff8f46ec20
 __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
 console_unlock+0xd1/0x1c0 kernel/printk/printk.c:3413
 vprintk_emit+0x485/0x560 kernel/printk/printk.c:2479
 _printk+0xdd/0x130 kernel/printk/printk.c:2504
 vlan_vid0_add net/8021q/vlan.c:347 [inline]
 vlan_device_event+0x13e6/0x1580 net/8021q/vlan.c:388
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2291 [inline]
 call_netdevice_notifiers net/core/dev.c:2305 [inline]
 __dev_notify_flags+0x31e/0x510 net/core/dev.c:9798
 rtnl_configure_link+0x2f5/0x510 net/core/rtnetlink.c:3712
 rtnl_newlink_create+0x343/0x7b0 net/core/rtnetlink.c:3957
 __rtnl_newlink net/core/rtnetlink.c:4078 [inline]
 rtnl_newlink+0x166d/0x1c30 net/core/rtnetlink.c:4195
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7112
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff1f559de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff1f37f6028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff1f5825fa0 RCX: 00007ff1f559de59
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000000006
RBP: 00007ff1f5633e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff1f5826038 R14: 00007ff1f5825fa0 R15: 00007ffdfbb2bc38
 </TASK>
GRED: Unable to relocate VQ 0x0 after dequeue, screwing up backlog
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	ff                   	ljmp   (bad)
   1:	e8 71 2d 21 00       	call   0x212d77
   6:	90                   	nop
   7:	0f 0b                	ud2
   9:	90                   	nop
   a:	e9 9c fc ff ff       	jmp    0xfffffcab
   f:	e8 63 2d 21 00       	call   0x212d77
  14:	e8 3e b0 29 0a       	call   0xa29b057
  19:	48 85 db             	test   %rbx,%rbx
  1c:	74 c0                	je     0xffffffde
  1e:	e8 54 2d 21 00       	call   0x212d77
  23:	fb                   	sti
  24:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
* 29:	48 8b 44 24 28       	mov    0x28(%rsp),%rax <-- trapping instruction
  2e:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  33:	4d 8d 77 58          	lea    0x58(%r15),%r14
  37:	74 08                	je     0x41
  39:	4c 89 f7             	mov    %r14,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	e6 b9                	out    %al,$0xb9


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
