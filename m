Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B941D127
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511675; cv=none; b=TILzAQZj5M5Lt8MKqoSI1X+Wy4m7gn4YAmTPKZeiNDb9NnpHWi5kKBm/K0r8bZVRVhUiCQnHUxWoA8gsZGTrBQFFKwhM/iC42Zw0S1Ht7PwVuJnQqxSkX2/dSibKp6oi7yO/Ntxzo1EjhrKrR7oirIgmiz6sDY30DTWwNVXIO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511675; c=relaxed/simple;
	bh=SKDIl6gUKjcd7PZ7p59sq7JLrAihNvMJGUpWGd0ydmA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R415Y/Tbd4iWT+OyJ6wmqFR7Z1xOpZpsxpxETNwWQBPJhyYdJ/MSV3veIxq2mmYpifTyyWz00fv/OBEyPvF+6Is55kKNR4bLZLi98F59Zv6cGGea4ecjTMQNocgtoVgq3yAtsJ14ei2lHE1CGifufWUDRyeB+fiulAeyF/8caeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6c1ba2091cbso1350902eaf.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511672; x=1790116472;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBWFnaWw5jXr3ddwzQPC0GqRWckCJTkWzckXqZAhHFI=;
        b=eOc5bTC83eDDfctNdJF6ISmE9k+NYh0B8geHZ/ZG0f2e/kBAOua69Ko83Hg0BlxlUV
         3XCj9LnXTZU6OsEVyN3ooA0RWtZfCQYOkfg7DbYKxXeoAfgvPVmS2JpUowKJ/p3+aOaW
         7sphCB9sHeMbO8MKa/0M9Bml3CsGgHd0gg/rcmYY0/ENS7TZDvu+x3VCV5li+RbbCr+D
         gy8sAD95NZrl3EKdI5jkIYBVzkZoUHadiJrBEh1W23YpYlP9fBKkN8XjJ2Y3OAn4nC3N
         WYVwLMbP3clRhlJQKycHd9jENVXGYMckWYIQv9yHg5m+ZjzODKOPlw98dS8lBB5ZA/F0
         AD/A==
X-Forwarded-Encrypted: i=1; AKwUvBzDPpHn50uYnwjqd8JQ3/mvLeqQu3dkryj/JYKieqrJs3kn9MASxBUsnIr56gzuir2A20696Yg=@vger.kernel.org
X-Gm-Message-State: AFuF++lr+JCpmzAX3H9eHFBVSaLZWwzD4pjseGeJRrNiiAFjrzBSgUUy
	P2kkMmtK4yP2Uphlkz6QoGB6wxQ9luPJaSPbWPcD5fv0UJv3BCeyHTTqpGQ05Rntn7cEYbYZ4Po
	8RUl9muw2DVZ0+bJ7vPuvENn8dC3vA0HsxlyAzAsFFiZ70bO/lpkAvoPMDA4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f003:b0:6b7:8415:d790 with SMTP id
 006d021491bc7-6c7d3802648mr545705eaf.59.1789511672466; Tue, 15 Sep 2026
 15:34:32 -0700 (PDT)
Date: Tue, 15 Sep 2026 15:34:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa9c7f8.a211d2ce.1a5198.02b5.GAE@google.com>
Subject: [syzbot] [netfilter?] WARNING in nf_flow_table_extend_ct_timeout
From: syzbot <syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ac428e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=521f7e7e2b974abde99a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daf497619736/disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/748fbd82f647/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e61c59099d07/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: net/netfilter/nf_flow_table_core.c:546 at nf_flow_table_extend_ct_timeout+0x1ee/0x2f0 net/netfilter/nf_flow_table_core.c:546, CPU#0: kworker/0:2/3335
Modules linked in:
CPU: 0 UID: 0 PID: 3335 Comm: kworker/0:2 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/08/2026
Workqueue: events_power_efficient nf_flow_offload_work_gc
RIP: 0010:nf_flow_table_extend_ct_timeout+0x1ee/0x2f0 net/netfilter/nf_flow_table_core.c:546
Code: 00 00 00 41 83 ff 06 0f 84 9a 00 00 00 41 83 ff 05 0f 85 b0 00 00 00 e8 70 d1 ab f7 41 bf 30 75 00 00 eb 0f e8 63 d1 ab f7 90 <0f> 0b 90 41 bf 01 00 00 00 48 c7 c0 80 f2 a0 8e 48 c1 e8 03 42 80
RSP: 0000:ffffc900040ff938 EFLAGS: 00010293
RAX: ffffffff8a1bf92d RBX: ffff88807da5be00 RCX: ffff88803247ddc0
RDX: 0000000000000000 RSI: ffffffff902f6960 RDI: 000000000000002f
RBP: 0000000000039e60 R08: ffff88803247ddc0 R09: 0000000000000002
R10: 0000000000000011 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff1100fb4b7d8 R14: ffff88807da5be48 R15: 000000000000002f
FS:  0000000000000000(0000) GS:ffff888124cd2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7238c10 CR3: 000000007a894000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 00000000000001f7 DR2: 00000000ffffffff
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_flow_offload_gc_step+0x545/0x7b0 net/netfilter/nf_flow_table_core.c:581
 nf_flow_table_iterate+0x13c/0x1f0 net/netfilter/nf_flow_table_core.c:452
 nf_flow_table_gc_run net/netfilter/nf_flow_table_core.c:604 [inline]
 nf_flow_offload_work_gc+0x22/0x70 net/netfilter/nf_flow_table_core.c:612
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
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
