Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615781;
	b=fEROzusDER28yWYDCMYq2mHH3sP2k/Ark5RvArmrQF48P0I8PpAun0+yZS4DyAYA2o8P
	 TnchQk64oNPA21IhMRv989q3uW6svqbcM7xGnfQeIf3D58YlVbwgyu4XFIN7yluQosnMW
	 XPCIU8o6QbfvJ81tNbgq0JDXsYOi1AIE/lh5C+XxoB4jlYK5PM2GzFRgeEY6Ty+ODmiia
	 7kR/LgnmoNXKc8Bj4GPA/gdvLM00JPI4kTZU/64X9ssvTQqk2GqKneLYYi6EPXnTVoPjW
	 nGtz2yGHRgz8X7uB/IS3Wyq/JEHTtNr1wF/qstX7jNcKMrvorw43WeKh4gNFw2SUAMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615781;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=KH4FqHRRPkaUzPXBlL7FuVKAgCFrwQWnlweUMoj5tUY=;
	b=QGybM8UPTEZXz0q4alQuvxZNhjpkYIxIHwZr0ygMvF6yWCJ8XfZZQLZ0M1FlYGmvhHb1
	 SHdheW3aYt6QkqNdsEg5O0CdGmh5ZyxYTaQ0xohAtp6cVVyt5RImora40DjJyZ3/UeduV
	 DY0jpwWmt42NZkaj1vXlN66Y+tSj+GzQ7mRkJH+9QhxYk4lX3eXhiCCAg7q2rW77xnipO
	 R0DE7DILgJrWybw77ItDC07onEuUwoNwLLPO+Mo7DyEq7zSU4qBPgt18g0wTaQs7L9DIM
	 AgukSjcp2LtKcIhvZa7AJx/fRXAM81vX5JQig97S/7gHN3d4ADiGfyQtOGCeh4y1XZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9820606A334
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 00:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9820606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4dc57e2a3f2so2271281b6e.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 16:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794615780; x=1795220580;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KH4FqHRRPkaUzPXBlL7FuVKAgCFrwQWnlweUMoj5tUY=;
        b=o554nYhDRmmfQ5EQF4kN3ad9Ui0zBjAv58KkDo5I3FBii15co24zeWteNWzefvF3nq
         Ng3Dy4C7HwxYLmXfWnB3yczyu7FnIBgpJzsX0P8M1J+7BbZvYt+3kBRM8sCcUA29P8eP
         xN+fVZNAzoT6+J6BotMJ/sMTLei/mXJ1KGobfflLm5SI6uNudm8NPw6a3Y/8wiBHPdyK
         i2rh3LR/pzeGF3dwDlMvA1GgtYIBujR3IBvG0GsAemRxChTeAQ8m2lvCzKSpswGivujF
         KYs+iyArp3tjZmkS6EnMsR/d71NhbY2m84xJQmo2Nn8/mINOzrvIAT6BpJK+dnGm+AM2
         IZ7g==
X-Forwarded-Encrypted: i=1; AL+hErFokJdyklpDRQfeP9R9WETX106TgF1JApCC0/y8Pk1FL/Wf+NySk6U06oKQtnpQF2Zw3N7GXzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZXzc57a0NQC9IClS/B5SB7TVlQhXRQdfzQVQbQMlm8PjWUZZo
	28Cild+ImIltrcGgDJF5tOFTtDAaEZd7hoborSQt8BN/sbMSbLUGX3UPm07HOl+CPjomUfzTEVR
	3BetiJJU6CTdDs1LbSX9/4d6Q1MQuiJ92Hhq9u0+DcCGUfsjZWvUs/JTKj9M=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f2b:b0:4d6:9153:2965 with SMTP id
 5614622812f47-56e6541434amr3703135b6e.54.1794615779864; Fri, 13 Nov 2026
 16:22:59 -0800 (PST)
Date: Fri, 13 Nov 2026 16:22:59 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af7a9e3.ff6dfe28.557e.002d.GAE@google.com>
Subject: [syzbot] [net?] WARNING in xfrm_output_resume
From: syzbot <syzbot+622de7e1f18a30fc404a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7475ea8b5861 Linux 7.4-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=177f9fe1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44b06612b68f56
dashboard link: https://syzkaller.appspot.com/bug?extid=622de7e1f18a30fc404a
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338e03d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11877f8d580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1dc544ec8515/disk-7475ea8b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb265017368/vmlinux-7475ea8b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f78347f28bf/bzImage-7475ea8b.xz

AI-generated root cause summary:
IP-TFS (net/xfrm/xfrm_iptfs.c) registers iptfs_output_collect() as the
dst->output handler for XFRM IPTFS mode to aggregate outgoing packets onto
xtfs->queue for delayed transmission via an hrtimer (iptfs_delay_timer()).
Packets delivered to dst->output can carry an unrefcounted, RCU-protected
destination entry (SKB_DST_NOREF). Because iptfs_output_collect() does not force
a refcount on the dst entry with skb_dst_force() before enqueuing, the SKBs
retain an unpinned dst pointer after the caller's RCU read-side critical section
completes. When iptfs_delay_timer() subsequently dequeues and transmits the
packet via xfrm_output() in softirq context without rcu_read_lock(),
xfrm_output_one() invokes skb_dst_force(), triggering
WARN_ON(!rcu_read_lock_held()) and risking a use-after-free if the dst_entry was
freed during the queuing delay.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=622de7e1f18a30fc404a

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+622de7e1f18a30fc404a@syzkaller.appspotmail.com

------------[ cut here ]------------
!rcu_read_lock_held()
WARNING: ./include/net/dst.h:326 at skb_dst_force include/net/dst.h:326 [inline], CPU#1: ksoftirqd/1/24
WARNING: ./include/net/dst.h:326 at xfrm_output_one net/xfrm/xfrm_output.c:549 [inline], CPU#1: ksoftirqd/1/24
WARNING: ./include/net/dst.h:326 at xfrm_output_resume+0x41d9/0x64e0 net/xfrm/xfrm_output.c:597, CPU#1: ksoftirqd/1/24
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
RIP: 0010:skb_dst_force include/net/dst.h:326 [inline]
RIP: 0010:xfrm_output_one net/xfrm/xfrm_output.c:549 [inline]
RIP: 0010:xfrm_output_resume+0x41d9/0x64e0 net/xfrm/xfrm_output.c:597
Code: be b4 01 00 00 48 c7 c2 20 fd 53 8d e8 f0 05 07 f7 e9 aa fc ff ff e8 96 b1 2b f7 90 0f 0b 90 e9 7e ed ff ff e8 88 b1 2b f7 90 <0f> 0b 90 e9 44 e0 ff ff 48 89 df e8 c7 3c 52 fa 84 c0 0f 84 e1 00
RSP: 0018:ffffc900001e7660 EFLAGS: 00010246
RAX: ffffffff8a9d6fa8 RBX: 0000000000000000 RCX: ffff88801f2f5dc0
RDX: 8000000000000100 RSI: 0000000000000100 RDI: 0000000000000000
RBP: ffffc900001e78f0 R08: 0000000000000100 R09: 1ffffffff237c017
R10: dffffc0000000000 R11: fffffbfff237c018 R12: dffffc0000000000
R13: ffff8880243df198 R14: ffff888021b2b210 R15: ffff888028e9a780
FS:  0000000000000000(0000) GS:ffff888123509000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f781b792e9c CR3: 000000007dcea000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 iptfs_output_queued net/xfrm/xfrm_iptfs.c:2325 [inline]
 iptfs_delay_timer+0x3803/0x4310 net/xfrm/xfrm_iptfs.c:2362
 __run_hrtimer kernel/time/hrtimer.c:2079 [inline]
 __hrtimer_run_queues+0x3bc/0xa10 kernel/time/hrtimer.c:2136
 hrtimer_run_softirq+0x1e3/0x2e0 kernel/time/hrtimer.c:2153
 handle_softirqs+0x265/0x8d0 kernel/softirq.c:669
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1133
 smpboot_thread_fn+0x5f8/0xb30 kernel/smpboot.c:162
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
