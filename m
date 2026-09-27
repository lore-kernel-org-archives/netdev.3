Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3A2AD3C
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497744; cv=none; b=K/DMu6MaKo2owRpzd+UNmS+mo9AfSrsrcVr8r3mVAaKmXDI2CuS/YUu0XIuZJ+hy3F9tIoLZeW/YKIyqlFKCPGmGOgg8c8yBxL1W1G3+n5Pf3kpId1eDVW10ttJxPBmjEQGHlYgVBfduwatq6RAZ/uXst1JogGnQqLPLGYhQJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497744; c=relaxed/simple;
	bh=5J/wLB1+LRP5/omLkXxmg34WIC7l6MT45U8sOJ8r4gQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nnbNGjitT5OwwQQNXyEbELoFM5KLuP0yyGH3rKIiBUq+ULp6sUnuxuZAMWpoTa5eLfZhCJ/wJYW3Sl6aVPlaaTw4s/8KTv1pTDypXN1ux/B7fFl+UDM0X7AxIrilwhrKesgZj9Ebn+KW0HHxELuTrRGqojk2tKZtyqy1B83irAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4574f1cac98so3712177fac.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 01:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790497742; x=1791102542;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xb0U4y4WdgYCeZKVxlGgjl5e3S7LrU0XCMC1dQKLZj4=;
        b=gDegJpeaaVWnJYA9jcll7BEPe0pcgLe0S/b/R9/AKPDfWHe/6Xaf7OuEt9nqi0Qjp0
         vCBPY9+bNa3YL7jgD08SdovudTjFvXULqDLoBy4U4CrkcbYQfGQW2DCyzh4HStRW3fZZ
         RaqlmltLVzmMrk5MOqmvuFRIuydUN/r2aYpc4Rop5eZnKvslbWWihOZ4j2UpihdgYMqF
         3VVm4yWckmBkbhfIotdb01w1Mi7Dz7mYhhBFgMYGRHBXFB7Blw7fPvb8D+ThM9D+Tlkk
         VzhLshLT3ytru9bfez/kRLCseo9C8zmKQUxCAPEzYssVHAmSikmqpzEpGOinaTrSdA0V
         ztGw==
X-Forwarded-Encrypted: i=1; AKwUvBwm+yWSAWa8o/P+G17KpxC8XHIYSHR9QfxT9zQJNzx8bfSXq5ttdLMms/AFL2QK9xL9pNfb9Xk=@vger.kernel.org
X-Gm-Message-State: AFuF++mBwT01jQu1O2wAA8FgDk/y75wbVCxKz3C6xy26lgIq9t8JltlL
	f8hS4aFGrSjot19EDQfSA1mgNxNjstf4MgTUGwtHAWYN794sZZL/CFJM5eYefrHHg4qizw+tAOx
	LZxD1N1BYrBWAu8tcLmpQMwskksT6o7VEDvf2j8iNnJNosLwt6ThZGbBL7GM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14ce:b0:4c7:30a6:97b9 with SMTP id
 5614622812f47-4d72aa5bb67mr10195684b6e.38.1790497742233; Sun, 27 Sep 2026
 01:29:02 -0700 (PDT)
Date: Sun, 27 Sep 2026 01:29:02 -0700
In-Reply-To: <arjO9qbNdbvdi7ao@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8d3ce.dc2998a4.2261f5.0063.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in rxrpc_destroy_all_connections
 (2)
From: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
To: azpijr@gmail.com, davem@davemloft.net, dhowells@redhat.com, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in rxrpc_destroy_all_connections

bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
rxrpc: Assertion failed
------------[ cut here ]------------
kernel BUG at net/rxrpc/conn_object.c:488!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:rxrpc_destroy_all_connections.cold+0x12/0x14 net/rxrpc/conn_object.c:488
Code: ff 90 0f 0b e8 6e 97 99 00 48 c7 c7 20 73 5d 8d e8 72 be af ff 90 0f 0b e8 5a 97 99 00 48 c7 c7 20 73 5d 8d e8 5e be af ff 90 <0f> 0b e8 46 97 99 00 49 63 d6 48 83 ce ff 48 c7 c7 40 02 01 91 e8
RSP: 0018:ffffc90000107970 EFLAGS: 00010286
RAX: 0000000000000017 RBX: ffff888053d70000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81ea1579 RDI: fffff52000020f1f
RBP: ffff888053d70064 R08: 0000000000000007 R09: 0000000000000000
R10: 8000000000000000 R11: 0000000000000001 R12: 1ffff92000020f30
R13: ffff888053d70078 R14: ffff888053d70088 R15: ffff888053d70088
FS:  0000000000000000(0000) GS:ffff8880d5d52000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005562f0adc000 CR3: 000000002d8eb000 CR4: 0000000000352ef0
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
Code: ff 90 0f 0b e8 6e 97 99 00 48 c7 c7 20 73 5d 8d e8 72 be af ff 90 0f 0b e8 5a 97 99 00 48 c7 c7 20 73 5d 8d e8 5e be af ff 90 <0f> 0b e8 46 97 99 00 49 63 d6 48 83 ce ff 48 c7 c7 40 02 01 91 e8
RSP: 0018:ffffc90000107970 EFLAGS: 00010286
RAX: 0000000000000017 RBX: ffff888053d70000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81ea1579 RDI: fffff52000020f1f
RBP: ffff888053d70064 R08: 0000000000000007 R09: 0000000000000000
R10: 8000000000000000 R11: 0000000000000001 R12: 1ffff92000020f30
R13: ffff888053d70078 R14: ffff888053d70088 R15: ffff888053d70088
FS:  0000000000000000(0000) GS:ffff8880d5d52000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005562f0adc000 CR3: 000000002d8eb000 CR4: 0000000000352ef0


Tested on:

commit:         a7bfaba4 ipv6: fix prefix route expiry in modify_prefi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16e8fd25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=89001660f14fb7684c83
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159dda05580000

