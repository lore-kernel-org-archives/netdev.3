Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733D486439
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089070; cv=none; b=hjZUK5AvHxQmN35mgR6/2/Sd58Cj5HkdHn+1pOIrb4gzt+Nub4AXK+Fuv3u/xP1k+Lhhq3FA+525VUkZT2LaQ3Sy990V3prhyOLjQWeNqOqUJJtCWMo5m3ke4dvpgGG9iTbA9GvsurqzB/JwYLkHe7+bG4upmavnVvoH6uYwZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089070; c=relaxed/simple;
	bh=wo2hhVqXSDFNsEqid+p3Qr8x3erIJj3OEshDQsUgz5c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EsAjBbjg8DN/nRUdNuZYrgkA0478NOXOUpejphNpDLVeyGgV/UqJmB1IRqzBDdsw3fBYBaT65/6/jxpLhX8LEo/kflMkMGDJ2NJK1Wr3tK6gmMgPfpYh2Frwc5LzGO/A4enhjQpxBTcOXiFPneYSH3a2MvKxbrbjc2QCsMf0hV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4511f6a63edso587895fac.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089065; x=1790693865;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kOSrLV6iwvAWsPLksNnW/w4j/mbXLy6tE/r1nVS/H88=;
        b=KSFRJFoEUp6rnfqyRVX6sbVgjQgmJBw3duQz4fQvkyw/k/0agLWcxY3XWvwYL8FwDe
         M+Yn5afPjIF+UDsYhCpHxDIqg97ztqbmps9ePs2VILbRptYLa8g5HC7GoMolzSDVnrnx
         8Ze+xxL/OwfLEu3lHZFkPVtYddEso+smM2RFOyZgm4umj9ZVX5Lpm7Yrar69NgxK1Gfq
         eyJg5i6MIEp2YVf0sZQeYJBYoYv0qtFpGvMfmbr/O8QECf324qo0OXe77sMSbcx7xNtk
         dDCY1cPi01xDGLCC497Xb+/PXoqtZoN4Uwjgt79VYRRaEOF0bpbYsmXdY+aPp5MA1o8l
         39Og==
X-Forwarded-Encrypted: i=1; AKwUvBwTv4DD/4AaQIucZ+loh0D8jX5t8wSYogs8i1uBDoXL0a15p/MH7JA1pMCGtfkeTF1cBibOjJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lE0pK7+1SI238ZKK6ADZbcPYbPt4uDywmD9P6C6CjzeM6aN/n0
	k28yPlwMapY/2cdwq0p8qmd9h4CiMn/W24E2g6TFDht+jJjZJgaokiNfWstWaZ3fNPDdUt0x/Do
	spfRo6SUHSPteRm39ZO6NZVccz5dk1JfqVx2o/toFQ7OJSoJx+w7DF9nCk5I=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168b:b0:6d2:9ab6:471c with SMTP id
 006d021491bc7-6d29ab64a21mr248105eaf.84.1790089064861; Tue, 22 Sep 2026
 07:57:44 -0700 (PDT)
Date: Tue, 22 Sep 2026 07:57:44 -0700
In-Reply-To: <6a73d174.5aeeccc9.207e63.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab29768.514bccd6.255447.001e.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in rxrpc_destroy_all_connections
 (2)
From: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f0100363d8c3 Merge tag 'xfs-fixes-7.3-rc5' of gitolite.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17660c5e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=89001660f14fb7684c83
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ecb805580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e6f525580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f0100363.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57240753f5ee/vmlinux-f0100363.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2930b9a97546/bzImage-f0100363.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
rxrpc: Assertion failed
------------[ cut here ]------------
kernel BUG at net/rxrpc/conn_object.c:488!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 5766 Comm: kworker/u32:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:rxrpc_destroy_all_connections.cold+0x12/0x14 net/rxrpc/conn_object.c:488
Code: ff 90 0f 0b e8 39 99 99 00 48 c7 c7 60 6a 5d 8d e8 3d c0 af ff 90 0f 0b e8 25 99 99 00 48 c7 c7 60 6a 5d 8d e8 29 c0 af ff 90 <0f> 0b e8 11 99 99 00 49 63 d6 48 83 ce ff 48 c7 c7 40 f3 00 91 e8
RSP: 0018:ffffc90003f27970 EFLAGS: 00010286
RAX: 0000000000000017 RBX: ffff8880394c0000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81ea1579 RDI: fffff520007e4f1f
RBP: ffff8880394c0064 R08: 0000000000000007 R09: 0000000000000000
R10: 8000000000000000 R11: 0000000000000001 R12: 1ffff920007e4f30
R13: ffff8880394c0078 R14: ffff8880394c0088 R15: ffff8880394c0088
FS:  0000000000000000(0000) GS:ffff8880d5d53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a4b15ca000 CR3: 000000003c5bd000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 rxrpc_exit_net+0x7b/0xc0 net/rxrpc/net_ns.c:113
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:253
 cleanup_net+0x499/0x920 net/core/net_namespace.c:706
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rxrpc_destroy_all_connections.cold+0x12/0x14 net/rxrpc/conn_object.c:488
Code: ff 90 0f 0b e8 39 99 99 00 48 c7 c7 60 6a 5d 8d e8 3d c0 af ff 90 0f 0b e8 25 99 99 00 48 c7 c7 60 6a 5d 8d e8 29 c0 af ff 90 <0f> 0b e8 11 99 99 00 49 63 d6 48 83 ce ff 48 c7 c7 40 f3 00 91 e8
RSP: 0018:ffffc90003f27970 EFLAGS: 00010286
RAX: 0000000000000017 RBX: ffff8880394c0000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81ea1579 RDI: fffff520007e4f1f
RBP: ffff8880394c0064 R08: 0000000000000007 R09: 0000000000000000
R10: 8000000000000000 R11: 0000000000000001 R12: 1ffff920007e4f30
R13: ffff8880394c0078 R14: ffff8880394c0088 R15: ffff8880394c0088
FS:  0000000000000000(0000) GS:ffff8880d5d53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a4b15ca000 CR3: 000000003c5bd000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
