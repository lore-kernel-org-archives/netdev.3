Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980A1E1E16
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289250; cv=none; b=u2B5lFjmkgUEphmAdy9Gv1DP5LLjUmTm0ExYlGmnYNv7cb4dAtci2Y/X7PT6J0/UdO+0H++ArfKamUXcK2sVpbs7jVYTGlrWg8qEOb7W0HLoBPvTQWMpT+U/kKZ2okYgjiRVdunOcPjYZXirVcufNTSi0Iw0IRAfDM7Ma3X1PDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289250; c=relaxed/simple;
	bh=h64g/b0720y2ZRKty+R1YMO5NWwggUNzbsyMCGCOtwM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lwNqEmVRQU19kWyzrR9TnedU4gEhSbbp483ELWuCRolMF/uMgZ2Rx70c6C1VmmgX8xnu/Bl7weeQP5vpQ7d3nLUghc5Qc31vyoFty/Y/7FHZtHl0JV9lYE3R1t9pYrR4EsX3NAu6MylFW6kkSrfAWSRvlmGEbL/6zlzAXs0aENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e9eso1795823b6e.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289246; x=1792894046;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OSIzwYp+kpSkd3JrVxUdpyc6DkTq2zzJU/4smuBmDK8=;
        b=gx7Z+RXuJfBANztN9u8+sTsAO5z9E8/xdqSIZwvlFTJ9JJgVVJl+6oXykfPqQjA8im
         lRciHoz1zSkCbkJSGuSoMeP/EJup4JyqWK02BIOdblBilew1M02kizF/wrp8cVBAfBKg
         8Y5c8NDmjq4fYTkhs5LNO48jKHMKZGvR26YMcN6lemppyEMe3uzdbK8auVlDTRaqK02H
         ZqVswzVslRMabr5YNltmgEoS0kJijH9T9psZ9YFGFXmM/qM3n3ihZHQUfxKikoiwdPbC
         t/wpEX+FLDpoTU/pervUf562D/DYVbvE7SyTqqA4znNfDxgQ3QIhNdsOCyzvMOW4do+/
         6u7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzd7jxjuaoRXY3ZwQcQzwz2s1coB91nZdLU585ZPHAnVTAfBvN0fsTYaCOpONNparCsiVb3+6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWm7Lr4+yYLiN/RmP7zSclbF6uO0BRgu7H6tmFaYTJam0xbnhR
	sasZMT9uTbAQ8wb6DiBxfpjY+7snKs9bqYIunfR0nBH8B3QJuck6nhb9+J/Rm9008qYR4urGLd/
	Huj5XSzrPTZSOAxG2Ptpahd0MB1d4/49Kwf1O2HcJoBePiixt8JPo4C8gIMk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8f:b0:4d5:2b09:a6a7 with SMTP id
 5614622812f47-53cd93a4abcmr2967907b6e.65.1792289246563; Sat, 17 Oct 2026
 19:07:26 -0700 (PDT)
Date: Sat, 17 Oct 2026 19:07:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad429de.7f4e89eb.3d59aa.00aa.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in ndisc_alloc_skb
From: syzbot <syzbot+7b5c2544e5ff37a729cb@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@kernel.org, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a19f0cc94ad Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16df313e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26d6221a572842ac
dashboard link: https://syzkaller.appspot.com/bug?extid=7b5c2544e5ff37a729cb
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1555fda9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/296cd4b77dbf/disk-7a19f0cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e57669ed895f/vmlinux-7a19f0cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c679c1ad76d4/Image-7a19f0cc.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b5c2544e5ff37a729cb@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff80000000020c
KASAN: probably user-memory-access in range [0x0000000000001060-0x0000000000001067]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[dfff80000000020c] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Tainted: G   M                syzkaller #0 PREEMPT 
Tainted: [M]=MACHINE_CHECK
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/23/2026
Workqueue: ipv6_addrconf addrconf_dad_work
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ndisc_alloc_skb+0x284/0x460 net/ipv6/ndisc.c:435
lr : read_pnet_rcu include/net/net_namespace.h:431 [inline]
lr : dev_net_rcu include/linux/netdevice.h:2816 [inline]
lr : ndisc_alloc_skb+0x270/0x460 net/ipv6/ndisc.c:435
sp : ffff80008f9178c0
x29: ffff80008f9178c0 x28: 1fffe00019eaa40d x27: 0000000000000001
x26: ffff80008f917900 x25: 1ffff00011f22f20 x24: ffff0000d5973990
x23: ffff0000d5973976 x22: dfff800000000000 x21: 0000000000000000
x20: 0000000000001060 x19: ffff0000d59738c0 x18: 00000000d557e235
x17: 0000000006512135 x16: dfff800000000000 x15: 0000000000000001
x14: 00000000001cb30b x13: 0000000000000009 x12: 0000000000000009
x11: 00000000f2fb2cc2 x10: 0000000000000003 x9 : 0000000000000000
x8 : 000000000000020c x7 : ffff80008579a0c0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008579a1a4
x2 : 0000000000000001 x1 : ffff0000c1a00000 x0 : 0000000000000000
Call trace:
 ndisc_alloc_skb+0x284/0x460 net/ipv6/ndisc.c:435 (P)
 ndisc_ns_create+0x1f4/0x54c net/ipv6/ndisc.c:627
 ndisc_send_ns+0xbc/0x168 net/ipv6/ndisc.c:669
 addrconf_dad_work+0x77c/0xfe8 net/ipv6/addrconf.c:4318
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
Code: 96ba87a4 52820c08 8b0802b4 d343fe88 (38766908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	96ba87a4 	bl	0xfffffffffaea1e90
   4:	52820c08 	mov	w8, #0x1060                	// #4192
   8:	8b0802b4 	add	x20, x21, x8
   c:	d343fe88 	lsr	x8, x20, #3
* 10:	38766908 	ldrb	w8, [x8, x22] <-- trapping instruction


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
