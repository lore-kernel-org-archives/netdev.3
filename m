Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C64749FA
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127126; cv=none; b=RubzxLxy1fmBta9EwPtQ+U7PeVV5KLZPxY9nShp3mOogq3UIECELXXLZR8ykNhywk95FPuzZEiWvGkbOJdR2ShZ3kQOEMGBEaKlvVgfubSdcpANFNiKLQbxd8Oz00fN+mAsDJPsRdTwGhfi3qBf94wg4JgE98mjcdQnNBnKwHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127126; c=relaxed/simple;
	bh=XhJtIOc3u2hLLNzWnkH5OWfmH7YYPxIQ2OCmKVrFqrM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OoONCXMDtVqC4CfpC7K3Jd+KqnX2JUe18OuA98kEVRuj8+slHbTpeQo2Nfnv8RcuwtG6qWU/+3EQjiRheYR1SJaC0i2n2pPqmBAQS1K1I1B8dCHnbpOWd8XaubMNN7LeysQocY8hQuTJIm2ImBSBvHoEEqArVteuYZCtQXyVPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6c18e7d53b9so238305eaf.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 04:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789127123; x=1789731923;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DixrXJooAk+5iJDF/dnwtd5cfPxBUrdvO4OX36Wx9tA=;
        b=su0IKfB9pfP9hzT734A2Rw84I4tAu76CBrtxc4wCDWJrP/GV0qi9/lIF21c8BkVnf0
         N4D6u4Fv/ulw4Gd9xIZv8fK2rKGaLFjoEhcFfHk9TQB1lxRJIDe3jNYD0czSu2ym/mTu
         nZu8LCJrf5ENHyjWQnXNa1hPtk83AmIFjvKbgjqyTWkfgFdOZEF36f5eIS+61URNdrIH
         UrdyS0cWd01Nq5soGxoPtUmurQIBn4GOOA1ykL/+uDpblCvmUPlk5B4qWolXZZIuXiTQ
         8QTp5A88fSHOoqbyWsp36dDRZ1cUDcPACYZIam+sAkVH98yzhSIEMn2cHC9BnU12dxMA
         XejQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7+RhD5V7E5rslwSnysfjLpmmmELjP8D9tY8MmHVKpGb5xCYBMwAjJlXWR9zAB9v7uhku2ka0=@vger.kernel.org
X-Gm-Message-State: AFuF++mN3buUNo7rcsguPrDxMqTYiL8lFOPbFsrr+Ea9xp2ra5ZSd5n8
	T4Y44Ffdus0UKK7N/FS9Rir6/LM5tqZn+J3Jilp71875wUHgNabkXtHWKxkkXsWNo/jWQxcMNQq
	amus9XPmojFdfZMYSpwKmiKaV4YDnw+hbgQ5TnLSXDOBW3/FtKV5OD1+6hgc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1889:b0:6b5:ec2f:356f with SMTP id
 006d021491bc7-6bf46bb2c16mr4634956eaf.32.1789127123419; Fri, 11 Sep 2026
 04:45:23 -0700 (PDT)
Date: Fri, 11 Sep 2026 04:45:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa3e9d3.f2639fcc.29487d.0028.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in net_dm_packet_work (2)
From: syzbot <syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nhorman@tuxdriver.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08df884136f1 Merge tag 'thermal-7.3-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cd4925580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=586af68eb819833c2d91
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-08df8841.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21cf9eeaddab/vmlinux-08df8841.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a041f1e01a69/bzImage-08df8841.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com

skb frag:     00000100: 44 d2 0a a2 e2 47 a7 df 6f 97 84 d1 f7 fb c3 2a
skb frag:     00000110: 21 54 9f 61 2b aa b4 19 63 72 89 80 f0 62 f3 61
skb frag:     00000120: 9f 89 a0 49 03 f5 e7 66 b6 4b 34 44 cd b9 03 b5
------------[ cut here ]------------
kernel BUG at ./include/linux/skbuff.h:2847!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5877 Comm: kworker/1:7 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events net_dm_packet_work
RIP: 0010:__skb_pull include/linux/skbuff.h:2847 [inline]
RIP: 0010:skb_pull_inline include/linux/skbuff.h:2854 [inline]
RIP: 0010:skb_pull.cold+0x29/0x2b net/core/skbuff.c:2677
Code: 0b e8 6b b3 9c 00 44 89 65 70 89 de 48 c7 c7 60 cc 38 8d e8 b9 e6 b2 ff 31 d2 48 89 ee 48 c7 c7 a0 cc 38 8d e8 e8 30 26 08 90 <0f> 0b e8 40 b3 9c 00 4c 89 e2 be 01 00 00 00 48 c7 c7 00 ff ca 90
RSP: 0018:ffffc900044df9f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000000000ea RCX: 0000000000000000
RDX: ffff88802461a580 RSI: ffffffff816f5ede RDI: ffff88802461a580
RBP: ffff88802c76ca00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000001b38
R13: 0000000000001a4e R14: 0000000000001b38 R15: ffff88802c76ca00
FS:  0000000000000000(0000) GS:ffff8880d5c5c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa64e227dac CR3: 00000000647d3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 net_dm_packet_report net/core/drop_monitor.c:700 [inline]
 net_dm_packet_work+0xafd/0x1290 net/core/drop_monitor.c:739
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__skb_pull include/linux/skbuff.h:2847 [inline]
RIP: 0010:skb_pull_inline include/linux/skbuff.h:2854 [inline]
RIP: 0010:skb_pull.cold+0x29/0x2b net/core/skbuff.c:2677
Code: 0b e8 6b b3 9c 00 44 89 65 70 89 de 48 c7 c7 60 cc 38 8d e8 b9 e6 b2 ff 31 d2 48 89 ee 48 c7 c7 a0 cc 38 8d e8 e8 30 26 08 90 <0f> 0b e8 40 b3 9c 00 4c 89 e2 be 01 00 00 00 48 c7 c7 00 ff ca 90
RSP: 0018:ffffc900044df9f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000000000ea RCX: 0000000000000000
RDX: ffff88802461a580 RSI: ffffffff816f5ede RDI: ffff88802461a580
RBP: ffff88802c76ca00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000001b38
R13: 0000000000001a4e R14: 0000000000001b38 R15: ffff88802c76ca00
FS:  0000000000000000(0000) GS:ffff8880d5c5c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa64e227dac CR3: 000000000eb96000 CR4: 0000000000352ef0


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
