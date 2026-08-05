Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FC3D25C5
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785970044; cv=none; b=oDQzvyBV1jEDgv1I30C+NA8wnu+eGL/xdWP8j1iUb4oGvk1nkpLSa8kbj+JXTrg3EygENHjHMFn0gf4gSzw3jJZKngy2XWpd8c7HDCIMCPiIvxyTuH88Te+Ylm3Q8eKjzJPHbsc1IyFC5PQ/nd0JKIOPYjIpKowHs3C3zWItN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785970044; c=relaxed/simple;
	bh=sQ4jHpi/PkJ7/6tuu+sr2vhgIx5UM0q/OHYn6aHzB20=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CdXtjSBh8suF7Ero5X7tRojfsc0aqFR9hNwjx9bwMkDatJTEe/MiJwO8+8piIgJl2MSk18TqyKwaNAV50gMnwa4Hr4uo1qi5QiE2yfg9nSpvev9GhjmYJj29Jg5U5IOG7EmcIkO9PFRGtM59hW9HeGm9uCCXMRBhSjeUJM1OdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-451fd211101so838717fac.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 15:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785970041; x=1786574841;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZoRDaPm/CzbKCtbuCQjctddB9ds+MKUfZ5Z6mPCGwM=;
        b=rPVaR2/L5Bg36gs/740HgXZxjhPlxf21sJ04ry/CjLaARBnrqjqcobrpm3LA6L9bkF
         xgHFaoZAfg3oh0EOgzafisE5HxVBs0bTVBUcY8aCsw6Z2+ak0FPJUhJJkJcry41yQhcQ
         YZ1dvq45ftv9qPUdM90sTSfmPOh+6sPqcrMEweoAvBBpuad2tBFSuNeUgfXmGbgreK+A
         mwe7IxU/wAx0mPpXoj2ZEDQvOy56COyd2K1T2gj+l8iDZPN1Ay1IpNo3IXudzkXzdfPh
         RQl3G4EQd3Zvo0aQfE4Egxgle471ppVL5FbjW1rbJNF7BRGtKlj3+OMmM+0QqPNtngBW
         Cw4A==
X-Forwarded-Encrypted: i=1; AHgh+RoNkXpSUgk/lqg1R4YZOKoAaFDNU0akcj3+pV1+9rW1f3aQL5W9d0X/ZZqAUJRvX4oGVlra25E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxni+BEvoVv3e1aFB1hqDo0JEr8GhtYJDDxEKTZXkjT1dup1SH
	ZHcd5ucV8jUGEYV6tYcjD03akCqwj72XtHrlY6ZFy34m0KCCOEdiraiZQBIr4bVobatc4/D6Tjl
	tk3mL1jJOI/hOiZcjyYX4uowa5FIH+/YSR2QvhLk05tPYymhvA2EiXURBvCE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee87:0:b0:6ae:8103:f6ce with SMTP id
 006d021491bc7-6ae96d1aa1fmr5305720eaf.15.1785970041631; Wed, 05 Aug 2026
 15:47:21 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:47:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73bd79.6851e1c7.236b5a.0003.GAE@google.com>
Subject: [syzbot] [ath10k?] WARNING in ath10k_pci_probe
From: syzbot <syzbot+5c061dd050f2b84b2e1b@syzkaller.appspotmail.com>
To: ath10k@lists.infradead.org, jjohnson@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16cd13b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=5c061dd050f2b84b2e1b
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b24bb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1061acc6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/375d27e96ecb/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ba19a656b9d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c2a17aaee7c/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c061dd050f2b84b2e1b@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: drivers/net/wireless/ath/ath10k/pci.c:3597 at ath10k_pci_probe+0x6e2/0x1c60 drivers/net/wireless/ath/ath10k/pci.c:3597, CPU#0: kworker/0:2/198
Modules linked in:
CPU: 0 UID: 0 PID: 198 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: sync_wq local_pci_probe_callback
RIP: 0010:ath10k_pci_probe+0x6e2/0x1c60 drivers/net/wireless/ath/ath10k/pci.c:3597
Code: 35 fb 45 85 ff 74 50 e8 dc 12 35 fb 48 8b 7c 24 18 48 c7 c6 80 2d 07 8c 31 d2 44 89 f9 e8 26 a7 9c fa eb 7f e8 bf 12 35 fb 90 <0f> 0b 90 41 bf a1 ff ff ff e9 7b 01 00 00 e8 ab 12 35 fb 4c 89 ef
RSP: 0018:ffffc90003aa7980 EFLAGS: 00010293
RAX: ffffffff8690c681 RBX: 00000000ffffffff RCX: ffff88802039dd00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003aa7ab0 R08: ffff88802039dd00 R09: 0000000000000009
R10: 0000000000000100 R11: 00000000000011ac R12: ffffffff8bcd1d44
R13: ffffc90003aa7a40 R14: 1ffffffff179a3a8 R15: ffff888021ad8000
FS:  0000000000000000(0000) GS:ffff888125c3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 000000003b198000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 local_pci_probe drivers/pci/pci-driver.c:332 [inline]
 local_pci_probe_callback+0x120/0x1e0 drivers/pci/pci-driver.c:361
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
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
