Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFC40A926
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374154; cv=none; b=hXstT3juf27Dygf47F3l/v2R9G0B6/B2qn+jzilOXQHi6Sz/MNtq+l9bpDMwzOe2r446BYfEuQ+p1wXAzP1nnfKJscd3L3QUljPW5DkAoEr/BAnOtXx056iycS0lRa/1gYB7/AwGFkj14bKjfMz5SUUP4QPkdpC5houHC1nnIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374154; c=relaxed/simple;
	bh=Jq62E+3qxTTpgr/y0/42GQ7T0lONh5L3aBDqQDxHaHM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LaB6F4uk1lD1VIXravq6Lgn8ZbYv4GN5fZ0AZBpXtKUqATdT7FAfffkMBlqyHAauYoNzrXOtzu/7y5eatoUI4LuljQJmIWYVxXjLr8ilxyWW+Hg5qV6GQ9kUQ61mVg3jHw8dt3y+xYK0DuWw4MMjoo0lLYuVFSaQTsCbuGqFVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6ae41d34275so1838464eaf.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374151; x=1786978951;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLF0SDRD6elYaH9H4nlQOFBkwrP0OZh6Z0oOkhFeE5E=;
        b=mrGQiwlQHDaA/P6PNEvOkmY/1nJ+BlsbSFQz1K070B5DMtFNHe5HcMcQsLY9i7igst
         yClEBixV6tyDhsd8eZ+bskz4zgxAEgXfjlxXPit/7Kymj52vfyqHeG/2Su+Ti7GJ3MTe
         sr917wiYkeeBlDEv2838HS5cJmjE5HloeTLL9ChoSq2+eNDg/mBKMIaQLq4sIPxRXe5v
         FS8eauPdk5Nji1jOTQwYEnVxrmS9cGVNJCvslqIDoshRnwjMrUWm4C1UA9OT+hzpFiUr
         8P9tG7DmMD0gqdkny6uKy6/Jbw4S7/ElJx2cagLzfWhyknPB25m4UZ+twbPBindH/8J+
         pFSw==
X-Forwarded-Encrypted: i=1; AHgh+RrVmNkOENKgV50xW542Xh0e9z7R7pymARd8OqRATnbdwOa+LIXGA/q32ZaNjsnUrrgGgVPcMYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtdjckq7xq2nVrtahK9koqNRFwsLWrxfCZwwkYAqjrfmfpnVZ/
	x+TxfDx9h+VWMjckO/vIaox0y25qQt6r6tumQZUjH5hpyhTq/8ovuk9E++iZ0eO1zWkGB/z9RtQ
	CBEHB3edA+8LfmLrrFT89zPoTh0qH/kDG+L8a4z8Fq9Up3HsEWGX5d8Fla7w=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:208a:b0:6a3:1e40:6329 with SMTP id
 006d021491bc7-6ae96cc8e23mr24245025eaf.13.1786374151224; Mon, 10 Aug 2026
 08:02:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:02:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a79e807.01d0871a.3a0d52.00ac.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __dev_queue_xmit (6)
From: syzbot <syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-4..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165f2132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e8a402093abe6b2
dashboard link: https://syzkaller.appspot.com/bug?extid=30b93b6845b19cc38581
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12038fb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13357e49580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef40f2831e11/disk-f9a2394a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/083195a6f16a/vmlinux-f9a2394a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08e150858f10/bzImage-f9a2394a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com

------------[ cut here ]------------
skb_assert_len
WARNING: ./include/linux/skbuff.h:2753 at skb_assert_len include/linux/skbuff.h:2753 [inline], CPU#0: syz-executor184/5631
WARNING: ./include/linux/skbuff.h:2753 at __dev_queue_xmit+0x1fb8/0x3820 net/core/dev.c:4781, CPU#0: syz-executor184/5631
Modules linked in:
CPU: 0 UID: 0 PID: 5631 Comm: syz-executor184 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:skb_assert_len include/linux/skbuff.h:2753 [inline]
RIP: 0010:__dev_queue_xmit+0x1fbf/0x3820 net/core/dev.c:4781
Code: 48 c7 44 24 10 00 00 00 00 e9 50 fe ff ff e8 28 45 26 f8 90 0f 0b 90 e9 d6 e1 ff ff 48 8d 3d 48 00 c6 06 48 c7 c6 7c bf 43 8e <67> 48 0f b9 3a 80 3d ee 0a a0 06 01 0f 85 86 03 00 00 e8 fa 44 26
RSP: 0018:ffffc900038c7660 EFLAGS: 00010246
RAX: ffffffff89a09fa1 RBX: ffff88801b04e5d0 RCX: 0000000000000000
RDX: ffff88807f661f00 RSI: ffffffff8e43bf7c RDI: ffffffff9066bdc0
RBP: ffffc900038c7910 R08: ffff88807ae068a7 R09: 1ffff1100f5c0d14
R10: dffffc0000000000 R11: ffffed100f5c0d15 R12: dffffc0000000000
R13: 1ffff92000718eec R14: 0000000000000000 R15: ffff88801b04e5d0
FS:  0000555586b70400(0000) GS:ffff888124f55000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005628d19fb000 CR3: 0000000073c3e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tpacket_snd net/packet/af_packet.c:2907 [inline]
 packet_sendmsg+0x1f38/0x4e80 net/packet/af_packet.c:3134
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2252
 __do_sys_sendto net/socket.c:2259 [inline]
 __se_sys_sendto net/socket.c:2255 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2255
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda58f481c9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9aa6f188 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000200000000200 RCX: 00007fda58f481c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fda58fb3489 R08: 0000200000000000 R09: 0000000000000014
R10: 0000000004000010 R11: 0000000000000246 R12: 00007fda58fb33f1
R13: 0000000000000001 R14: 00007fff9aa6f1e0 R15: 0000000000000003
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
   7:	00 00
   9:	e9 50 fe ff ff       	jmp    0xfffffe5e
   e:	e8 28 45 26 f8       	call   0xf826453b
  13:	90                   	nop
  14:	0f 0b                	ud2
  16:	90                   	nop
  17:	e9 d6 e1 ff ff       	jmp    0xffffe1f2
  1c:	48 8d 3d 48 00 c6 06 	lea    0x6c60048(%rip),%rdi        # 0x6c6006b
  23:	48 c7 c6 7c bf 43 8e 	mov    $0xffffffff8e43bf7c,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	80 3d ee 0a a0 06 01 	cmpb   $0x1,0x6a00aee(%rip)        # 0x6a00b24
  36:	0f 85 86 03 00 00    	jne    0x3c2
  3c:	e8                   	.byte 0xe8
  3d:	fa                   	cli
  3e:	44                   	rex.R
  3f:	26                   	es


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
