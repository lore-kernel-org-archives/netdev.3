Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE12765D7
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511222; cv=none; b=Hy5ab3yflWuRuZMwbZLEEQjjEXwMDLPUO0uFwRKZ7CH7BC2+DWnyRqhx3s66y3dyR/a76A0ZVIx0YLr31/s/SDQZt8bCiiJl6dvlEBKmYtnWW0SuIz8WuXkMhRNY4S7SnyMsQCp1LR81XNCSMFs26CHxe4Szw6zaVe7HdZAuW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511222; c=relaxed/simple;
	bh=WTksam5mMLhz7n6lMlgAb94sGR5kh2LCcO7+DRlNbCs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fH8ehIp8tG+VLIeapw1b23XLFG5JW2C+JEdJdtU5/VdK1g2ftSS+ohpm+fI8BZ+XGptagboDyGqioR/reUTzOJzZKgzKII8PAM2vSJ+9nNHimF/Fffp+8PGRoVgB39A5N0Fev2D8SkLISfs/zNJGOd44DSNJMv/CX1Rn/QKSlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4ab260600easo7424379b6e.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511220; x=1788116020;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQNESQLTwJVhBbULXD8kpwkLCSyER8yPmkxG+TsSPnM=;
        b=WOQd4+nH9dYB+oqcKdx/5eX+mmb2vf3LT22fvdc0RVBq3o5+C5AVbrkswcP7ZksFpE
         KEvgxc9KIF8VQK9M1PqLWRC6Mj9m9EKlzX+0ZeiUwtDf2rADlFcbjeZzlePAJvfQwb5W
         Tp76bPGcnx1dgq3rsuNuZbjq/OwEwVgy2Ple9wKKU2llHEuQUknOjHZicOwbID63IfQl
         sd1x2hlGs0ROmpsq5MydByAtH3hurq5DbIIldFHRmsnCoxXCaD0Biej98n+H3Q/2UjrR
         DCvpbVS+yiXq52AimVdt99W992rK2hdENc7n1/j2jd1yJFgJ4t4+bcN+82W0JH8XLSvk
         UqUQ==
X-Forwarded-Encrypted: i=1; AHgh+RoudanWdElZpHcGJ+Ih6QzWupxAAtZRU4gfkNTGfUeAtetBnJtg39YxA8fNLcbGz+JbS8t3kPI=@vger.kernel.org
X-Gm-Message-State: AFuF++k8OOTIgpQOcYMzNXGS7u9imcp+poaDJaflHgo12YVXnSTjLKf2
	BtqKBqK2c3GTtNYCZES+t7MHSVhclHY/IHaAxUh0E4SoCCfRA/k4OBOp+eb9WWi1Dt8eCLgHCAs
	rlaTlv/TDJBDSAwEYePJ4HmN2fYV5HCUnKE1PLcrbidF636AZUFTZi39yo9s=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4704:b0:4ab:224d:6dd6 with SMTP id
 5614622812f47-4b2cddd4647mr25073978b6e.15.1787511220196; Sun, 23 Aug 2026
 11:53:40 -0700 (PDT)
Date: Sun, 23 Aug 2026 11:53:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8b41b4.dbb3a75c.13dd47.0052.GAE@google.com>
Subject: [syzbot] [net?] [usb?] UBSAN: shift-out-of-bounds in vcc_connect
From: syzbot <syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bd5f485f3f02 Merge tag 'soc-arm-7.3' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16736e79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d6c2a05eaadaf10
dashboard link: https://syzkaller.appspot.com/bug?extid=6665d3db5fef15914802
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f2549580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2da33ef8d789/disk-bd5f485f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e8921e0c1e1/vmlinux-bd5f485f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7e5335b79c8/bzImage-bd5f485f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in net/atm/common.c:381:10
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 6073 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 __vcc_connect net/atm/common.c:381 [inline]
 vcc_connect.cold+0xe0/0x123 net/atm/common.c:498
 pvc_bind+0x33f/0x460 net/atm/pvc.c:52
 __sys_bind_socket net/socket.c:1945 [inline]
 __sys_bind_socket net/socket.c:1937 [inline]
 __sys_bind+0x1a9/0x260 net/socket.c:1976
 __do_sys_bind net/socket.c:1981 [inline]
 __se_sys_bind net/socket.c:1979 [inline]
 __x64_sys_bind+0x72/0xb0 net/socket.c:1979
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a3099e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff44bcea08 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007f6a30c25fa0 RCX: 00007f6a3099e0d9
RDX: 000000000000000c RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007f6a30a35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6a30c25fac R14: 00007f6a30c25fa0 R15: 00007f6a30c25fa0
 </TASK>
---[ end trace ]---


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
