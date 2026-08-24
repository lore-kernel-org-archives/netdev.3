Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F0448380
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586272; cv=none; b=Jltzj4EFBcDDN5+uudLE4pcD4rb2YhTa0+/bXZh/ASS++aMOFeYitlePG00oTKwwuYinz62BwbNriZS8tGgetad9ltQ+fYOEUDUYg+uEZ0eZJD0rzb5V5Rfjxll5fETMqBoGgVvVcKoHLIJubLn1LkA4uQduCQbqDQTRq0f5xAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586272; c=relaxed/simple;
	bh=/eTcaer6dKTrwxYyg/rGmfmFEL/wIyRzRqXtBsn/bFs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R+V24ZRedyNjBd66RwxtsB7brrAFOFqciyez1XEBzMcrHTQ/dn2slBnb//knLre7DphPDSW7mwLqaG8pmwoKdDZzPvyx/myaWS0v6TBHVvi4xHcyXhhU+/MTVBpkxVDgzJ42q3G+wzkFSDb8yhU97Q4utzsQJN8HyQHMefdtMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e9e2db9914so16587a34.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586268; x=1788191068;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZaeHcI4/3k/LqeQzVwjn1Yft0kd3mMiIr8kgaHQ2vM=;
        b=XhqzOeKJThM5zNAt2AjSesMmzV+zMldgfdGix8tuN/PXBbtEdTtPNJEalG8UQGnaL5
         /2QyPXacsVjo/4JdowG5/YPuClrJVdVnvHxKMfSKHbhSm6Ny2qHJlP+0/K/N6OMVXj4B
         VIdkrLFj/F8eJ1T4DgU4/ViNbylkbuC9W33uTb+8YdqNJHbNcrtUtly5a9mXekMnsC/q
         bN0A4/CMmcq0nGFMJbYLX9kY0SjcI6PioP+jeswlKStN3x313n0I9BiDfJ5CeZtnFYry
         FD1jJSFQ0cAZCEWoSYdnuxvc89FyrARmGopuVddDmfhXef0Lm5KDei7VSkbvMVNguQSO
         RGgw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5QK9HMI9e4xkN6mO87T1oPVS4DTk4jzlxpuXeeauSABFOgCwBMx890B3l8QQS/eXMJV4vTqo=@vger.kernel.org
X-Gm-Message-State: AFuF++mhAYZsPXTZ8Zpnab1SwE7pgnCJI3P8yWM3eiwrd3YVwsyLkbWj
	lZNDGjSC7nsgWLKcqQuxvIrBmwcNjlwY6psCqTA7PpcNTGv0g7nQZd6zNDiOYeUvH6TXUEEaolp
	q3g6S7KGYedAO/CM7Y6bnQ0qRRUrG382cmGlIp3YzS5yg4L8ALSXDJSTeqbw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c95:b0:6b0:ab1f:ebf8 with SMTP id
 006d021491bc7-6b18f8da555mr141794eaf.0.1787586268510; Mon, 24 Aug 2026
 08:44:28 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:44:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8c66dc.4d75e56a.c9a88.0050.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
From: syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    388b607d107c Merge tag 'efi-next-for-v7.3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f98979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335632b21d0ce540
dashboard link: https://syzkaller.appspot.com/bug?extid=2d770620059281e225a4
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c3549580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20c420e92df0/disk-388b607d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82f836a86dcc/vmlinux-388b607d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3b00ac47be8/bzImage-388b607d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d770620059281e225a4@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: kernel/locking/lockdep.c:238 at hlock_class kernel/locking/lockdep.c:238 [inline], CPU#1: kworker/1:0/24
WARNING: kernel/locking/lockdep.c:238 at check_wait_context kernel/locking/lockdep.c:4870 [inline], CPU#1: kworker/1:0/24
WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0x382/0x2cf0 kernel/locking/lockdep.c:5203, CPU#1: kworker/1:0/24
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4870 [inline]
RIP: 0010:__lock_acquire+0x389/0x2cf0 kernel/locking/lockdep.c:5203
Code: 83 3d fa 48 f9 18 00 75 27 90 e8 b2 88 35 03 85 c0 74 1c 83 3d eb 3f d7 0e 00 75 13 48 8d 3d 1e 43 da 0e 48 c7 c6 8f 4c 59 8e <67> 48 0f b9 3a 90 31 c0 0f b6 98 c4 00 00 00 41 8b 45 20 25 ff 1f
RSP: 0018:ffffc90000a089b8 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000042000 RCX: ffff88801eaaddc0
RDX: 8000000000000100 RSI: ffffffff8e594c8f RDI: ffffffff907cef80
RBP: 0000000000000001 R08: 0000000000000100 R09: 1ffffffff20f3d88
R10: dffffc0000000000 R11: fffffbfff20f3d89 R12: 0000000000000949
R13: ffff88801eaaea08 R14: ffff88801eaaddc0 R15: ffff88801eaae968
FS:  0000000000000000(0000) GS:ffff888124df4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f390df782c0 CR3: 000000007747a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
 __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
 spin_lock include/linux/spinlock.h:347 [inline]
 tcp_tsq_handler+0x29/0x200 net/ipv4/tcp_output.c:1291
 tcp_tsq_workfn+0x384/0x410 net/ipv4/tcp_output.c:1325
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 bh_worker+0x451/0x870 kernel/workqueue.c:3773
 tasklet_action+0xc/0x70 kernel/softirq.c:997
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 do_softirq+0x77/0xd0 kernel/softirq.c:546
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x140 kernel/softirq.c:473
 wg_socket_send_skb_to_peer+0x16b/0x1d0 drivers/net/wireguard/socket.c:183
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1c8/0x7e0 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	83 3d fa 48 f9 18 00 	cmpl   $0x0,0x18f948fa(%rip)        # 0x18f94901
   7:	75 27                	jne    0x30
   9:	90                   	nop
   a:	e8 b2 88 35 03       	call   0x33588c1
   f:	85 c0                	test   %eax,%eax
  11:	74 1c                	je     0x2f
  13:	83 3d eb 3f d7 0e 00 	cmpl   $0x0,0xed73feb(%rip)        # 0xed74005
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d 1e 43 da 0e 	lea    0xeda431e(%rip),%rdi        # 0xeda4341
  23:	48 c7 c6 8f 4c 59 8e 	mov    $0xffffffff8e594c8f,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	31 c0                	xor    %eax,%eax
  32:	0f b6 98 c4 00 00 00 	movzbl 0xc4(%rax),%ebx
  39:	41 8b 45 20          	mov    0x20(%r13),%eax
  3d:	25                   	.byte 0x25
  3e:	ff 1f                	lcall  *(%rdi)


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
