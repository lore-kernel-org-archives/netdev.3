Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38D3B2D0A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746718; cv=none; b=qKLXWV9F34ozNe39XOFZmFXe9VMwNfATan9WA/11L/dYDkiM02wDb7oQrxHuE2pj/7rOMwg4UeZMzCsxQf36cuxx5ZXInj3/NNFVdUG02fi5BnqfwTaOYNbSxX42yoHq8wsvcPcpEBCT8kVHrCzcPs3NyITOJbAgys2ga9/Z+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746718; c=relaxed/simple;
	bh=+4+M6dZAUhASDX1TdfrYD3AYj4jHa/a2eMfo72zu5Lk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uvBp075HoiCivJpSRGcFeg5wKM136I88DmUIYAlvE2IZ8sW/3saX3807xA2rHBV6cG14qQGmW1/3HqsTWkgJoVEjs4E05ECFcN+UGuxsL25d0dbabEoDzpGDrT7UPgNY6AwQlBumyXJIQ7WRyvDHuwpOF+tadPCUDz7xAlxT3u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f8.google.com with SMTP id 46e09a7af769-7f3a9f626a1so376691a34.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787746715; x=1788351515;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6O+Yx3dqixsBvupZN/KGdiqVoNV2KtYYbYkmAMAGd9Y=;
        b=a0FGO4BX8UMqQBv6oa88BYKJ9T38ikmW2EvsrW8cF+OeryyTdiD2mHaEF4q8d3eM1N
         nzLB/fSwwQiAskbYDZcyeicecAmowpP4WhC9Sg+U71FXA1+f70CLuezZ9lRRjPermsUV
         rCdh9PUJEUt64Byj/8KB3xTRIld/kITqYx4MuKe/kCULCtK9vlUAIb0UcfA21LsnDhBS
         cEmolLsCECm4AFG906rzCVzt5lswVtV9BvmcfeOpCKVIsd+wLIVk4KFSYU3zMj5GGn4+
         HrHupCzWKhoiC7PAuRxtVnu/LoHtbcxM2ISIpm/NSDQwhVHDQlLFD52K2Uw17cBWxXNm
         nlBw==
X-Forwarded-Encrypted: i=1; AHgh+Rpfa7BOPLiKRBwxa1n3e89vX/5KwZNhgO6f2x0wy8U2Fx5ddIciJlyK83mF/hFT1gfmseUAxoA=@vger.kernel.org
X-Gm-Message-State: AFuF++mOnQm0aAil66SCjKTONUeYM/x1F891ROabIU7uPtOzF6MJm1Tc
	RBwsv1HhYk+3x10RdyesuJtUTDfSaUd2VxA7wtzo7qqwrSGpQecJePbK/YbwyaD/yhiqfsj5cQW
	aIZG7GSB4A9HG4M3wv0GtAZwNKaHspI6+rdX0zALwOa7q4Hbvytgg8i1TrcU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c2cc:10b0:6b1:8ebb:7efd with SMTP id
 006d021491bc7-6b1a03672a4mr4766496eaf.4.1787746715710; Wed, 26 Aug 2026
 05:18:35 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:18:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8ed99b.1d9ded08.62e62.00ab.GAE@google.com>
Subject: [syzbot] [net?] [usb?] UBSAN: shift-out-of-bounds in __vcc_connect
From: syzbot <syzbot+f6ac161ee9699270b8dd@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fa5179580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a70bec3546180b6
dashboard link: https://syzkaller.appspot.com/bug?extid=f6ac161ee9699270b8dd
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12698625580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/858149e586b7/disk-26260251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8c4a5ad34e66/vmlinux-26260251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa4efe98315e/bzImage-26260251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6ac161ee9699270b8dd@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in net/atm/common.c:382:32
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 5987 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
 __vcc_connect+0x14b4/0x19c0 net/atm/common.c:382
 vcc_connect+0x328/0x8f0 net/atm/common.c:498
 pvc_bind+0x272/0x380 net/atm/pvc.c:52
 __sys_bind_socket net/socket.c:1945 [inline]
 __sys_bind+0x2e3/0x410 net/socket.c:1976
 __do_sys_bind net/socket.c:1981 [inline]
 __se_sys_bind net/socket.c:1979 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1979
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc16739e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0c105ee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fc167625fa0 RCX: 00007fc16739e0d9
RDX: 000000000000000c RSI: 0000200000000300 RDI: 0000000000000004
RBP: 00007fc167435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc167625fac R14: 00007fc167625fa0 R15: 00007fc167625fa0
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
