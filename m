Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60F3115AE
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835846; cv=none; b=PVhs+krwCCKMXHRReneZ0Im91u7CIDCQgHkdhSUrHQWFIhnBtGOWdQEYUlKnqWYl9xFo/TRZF0fhpqz8y/AJtbrC3qY//z7auJkH1DdGU+UV+x5/EIaNYBHRThRSDshNnWP69V+4ZFyPe9t7jbugclPo7WYFp4ZM3F0jw96qg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835846; c=relaxed/simple;
	bh=2Nvl+FcCWnQTP8dz7BDgrCn/pvk04Qu1rH0pORcvUuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pcDcobRYlYEPETlDzJfVtNpkC8BO6xVk9N5fKBVzxr6PP8PP7/JqPzmi4ZV20xT238FTCzQqsAtGa8xin6TRWfQl2mbRk2zChVBehECTsxDh26/VC2ScNUIfTjpu7oe2KsiLp0Z4TKTVzgdGFcVbONyRef4gSKgbTT0jiot3rMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7ebeeb51976so1347610a34.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 02:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835842; x=1786440642;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWYLaZJYHGeTT3/jLXgg+lvcsltZ1764CitCaIrhdEE=;
        b=EtciTJ1Hgxo1YCvMsfamQuuIbhMvkzE79Iv+G2zcmAXx60ajH0D/u9Hhg+NRKzrkBu
         5kTIQg+3BRbSXB43Wl1eJPIe3B8ZvsqcRmGhBx0xvBxfkCdnUCrEDxZN2j75RCNVecc/
         EJWjeAZC0EyxUSAoIZBa4SGxLNlV3h3CB/YXbVb3Wapxuo3xzWTzjJDDzrGR/ywCqF8F
         R1jJJ9U3HhCSrJaEMOKej+c1fOAufrXMzKfpPLU/ofVZhm+seSyYiUz66M4sTx0bgg6h
         xHqYwYbs8EdVUxEBFc3cyg9IvuRYFzYONthSrHYe9zBhqIfmiddvR31TC8E7QMv4NRu0
         mGnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqajeoKt3vXd9qLCRJujRCP5tGXcjF7PPaxWyckn182GWpzfOsUkJuzkPAn/Oy5Qn2LM1ixFFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eoQvEXEBqyH4WyiylQIjJ/g2djqiwTEOsZvKEZq4igIRmF8a
	zJYf+QYZSAPNhqyPqXR29WVpU8qHOqVOBMAJYzk6BmwpldM9thrEfjFgg8oxE0MY+g18wrJcWzK
	X0jehwcpoNmPEpNyQgRj6X9r8J5N80vVuRk9ZPnyKWBb1kf+BJ3LUHpWrMus=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160f:b0:69d:7fdb:3416 with SMTP id
 006d021491bc7-6ae82b35c55mr3480032eaf.21.1785835841773; Tue, 04 Aug 2026
 02:30:41 -0700 (PDT)
Date: Tue, 04 Aug 2026 02:30:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a71b141.9511d2ce.1fc5b9.033b.GAE@google.com>
Subject: [syzbot] [netfilter?] WARNING in nf_flow_offload_ip_hook
From: syzbot <syzbot+76d4e3a055aec3b007ec@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075b74841bd0 Linux 7.2-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13a8a649580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=76d4e3a055aec3b007ec
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14725db9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12581c9e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1dc04730d019/disk-075b7484.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d76da42271f4/vmlinux-075b7484.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07b1cdbcbe45/bzImage-075b7484.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76d4e3a055aec3b007ec@syzkaller.appspotmail.com

------------[ cut here ]------------
(skb->_skb_refdst & ~(1UL)) && !(skb->_skb_refdst & 1UL)
WARNING: ./include/linux/skbuff.h:1170 at skb_dst_check_unset include/linux/skbuff.h:1170 [inline], CPU#0: syz-executor103/5623
WARNING: ./include/linux/skbuff.h:1170 at skb_dst_set_noref include/linux/skbuff.h:1234 [inline], CPU#0: syz-executor103/5623
WARNING: ./include/linux/skbuff.h:1170 at nf_flow_offload_ip_hook+0xf6c/0x2b60 net/netfilter/nf_flow_table_ip.c:864, CPU#0: syz-executor103/5623
Modules linked in:
CPU: 0 UID: 0 PID: 5623 Comm: syz-executor103 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:skb_dst_check_unset include/linux/skbuff.h:1170 [inline]
RIP: 0010:skb_dst_set_noref include/linux/skbuff.h:1234 [inline]
RIP: 0010:nf_flow_offload_ip_hook+0xf6c/0x2b60 net/netfilter/nf_flow_table_ip.c:864
Code: 89 ee e8 87 4b 14 f8 48 83 fd 01 76 20 e8 dc 50 14 f8 83 e5 01 31 ff 48 89 ee e8 6f 4b 14 f8 48 85 ed 75 09 e8 c5 50 14 f8 90 <0f> 0b 90 e8 bc 50 14 f8 e8 e7 73 f7 f7 31 ff 89 c5 89 c6 e8 1c 4b
RSP: 0018:ffffc90000007798 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff89f61151
RDX: ffff88807cee8000 RSI: ffffffff89f6115b RDI: ffff88807cee8000
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88806f5d0558
R13: ffff88807a526900 R14: ffff8880291401c0 R15: ffff88807a526900
FS:  00005555816fc400(0000) GS:ffff888123dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006a1b90 CR3: 000000007029a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xbf/0x220 net/netfilter/core.c:619
 nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
 nf_ingress net/core/dev.c:5975 [inline]
 __netif_receive_skb_core.constprop.0+0x1689/0x3530 net/core/dev.c:6071
 __netif_receive_skb_one_core+0xb0/0x1e0 net/core/dev.c:6210
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6325
 process_backlog+0x37a/0x1580 net/core/dev.c:6676
 __napi_poll.constprop.0+0xaf/0x450 net/core/dev.c:7735
 napi_poll net/core/dev.c:7798 [inline]
 net_rx_action+0xa40/0xf20 net/core/dev.c:7955
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xac/0xe0 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 tun_rx_batched.isra.0+0x407/0x750 drivers/net/tun.c:1512
 tun_get_user+0x1e31/0x3c20 drivers/net/tun.c:1955
 tun_chr_write_iter+0xdc/0x200 drivers/net/tun.c:2001
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd3f3236427
Code: 48 89 fa 4c 89 df e8 78 1e 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffce22a8bd0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005555816fc400 RCX: 00007fd3f3236427
RDX: 000000000000002a RSI: 0000200000000300 RDI: 00000000000000c8
RBP: 00007ffce22a8c60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffce22a8c30
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
