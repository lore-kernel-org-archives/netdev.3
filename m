Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91934AFE2A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531279; cv=none; b=Ty5jzCXk0U3QwHKQ3s7Fr9UXm1RQUKvkvDKkEgT5/dTZNuwt+xXqGLdAXR4XunJ6BNkAjo2IMHh00dPZ+MyekF9v1xr0ErJFw5sC2Xk/6/TuCl42sDyJmiASoc9ToW3Vih5glmCz1uPdYQPmKz67cum8xLjFdeutVpyaJyr9eJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531279; c=relaxed/simple;
	bh=5cOsq/Q3S9J60MxF0T7IjniXMOMBOWSojeVSUpw78wQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cB/L0DB2hXU7ndHRn16l+fVVwAJFKMiUoRzcq9Vkgg7O/JPD3OWzb/kUNsK7kk4xef0uqRj3qBYtbtsorw5u0L7zXhA/RF9HY3jXuXktMw9p3jXJVc3jqVBRtVKGN/ahyxrLeaQm4OKy17NuU/mnV+4sbRdP8JTpftiwkeSZPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b1ca037684so58039eaf.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 07:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531277; x=1789136077;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrmQXxq+VMZilUy3MnBpTbj9a1HxAA2ccanctw/k1pk=;
        b=XfmzIfQ68mnAu47KXahmeVStg9W72r2UNEUZ0Y9w6ed4tKbIOFR/l43mONkxNsttzG
         8tKJ4IrPRBhKI4lSdNB8nyGEhplXcjyigwQiRQjR12W9XYO+/kl+T9V/kXFf6LqQqt2K
         bOeTZYUu6d8ivDNZrBHLZzjmDLhlBSUEkXf8oJ2+mogE3LV5alqVxldN6cFEQUxGmnQ0
         J6MJfOggGZdpbXwjbDTMHk+jVmIIiDOWbfDShdrY+QYOkD6+2pRV7sBXuZKOcxHe3dAj
         JlY9lvUJmXCFj9WPVBNwVFVK03WAopERkRZGvxIIyCT9pAccZPyBFRpGBOn90jrj7aZn
         6xYw==
X-Forwarded-Encrypted: i=1; AKwUvBxERyU35nGRjaKLINEDnVNgsznX+9OoQ5VwYdCl/dnKL7ykmi7eUXUjyCwU1Ry5n1tReQIgUYk=@vger.kernel.org
X-Gm-Message-State: AFuF++nuz4Crw6veA4uVBnyPbRzj6Jq7KQeh04UMfWXHSYJwz69CiMtk
	jouAX/CiVTe7j3tYKShEUkr66txULgtvPqpdx8TLLWWDfHJ5wKAHz80AVOovJVYNUK3sDJRtEf7
	1BSTaVLIFlaoRZO0ghsOAIKFrhE+VRNIbc1nbklR1vmLoPE3eEa3RDWdCGZ4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:214:b0:6b3:61fa:102 with SMTP id
 006d021491bc7-6b6fdfc2b9bmr4233842eaf.34.1788531276739; Fri, 04 Sep 2026
 07:14:36 -0700 (PDT)
Date: Fri, 04 Sep 2026 07:14:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9ad24c.b5d4176b.238c3e.0001.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_mark_chain_precision
From: syzbot <syzbot+7b47f87674e9a1569110@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e044668419b9 Merge branch 'misc-bug-fixes-part-1'
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=162038f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13dd96f4206498c4
dashboard link: https://syzkaller.appspot.com/bug?extid=7b47f87674e9a1569110
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165fcb49580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112038f9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c0c9fa35baf/disk-e0446684.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ed2d74549a1/vmlinux-e0446684.xz
kernel image: https://storage.googleapis.com/syzbot-assets/479e5164ed3b/bzImage-e0446684.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b47f87674e9a1569110@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: backtracking misuse
WARNING: kernel/bpf/backtrack.c:829 at bpf_mark_chain_precision+0x571b/0x76b0 kernel/bpf/backtrack.c:829, CPU#1: syz-executor403/5624
Modules linked in:
CPU: 1 UID: 0 PID: 5624 Comm: syz-executor403 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:bpf_mark_chain_precision+0x571b/0x76b0 kernel/bpf/backtrack.c:829
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 16 ff ff ff 48 89 df e8 76 17 44 00 e9 09 ff ff ff e8 0c d0 d4 ff 48 8d 3d b5 50 6a 0e <67> 48 0f b9 3a 48 8b 3c 24 48 81 c7 88 08 00 00 48 c7 c6 a0 c6 f6
RSP: 0018:ffffc90003957228 EFLAGS: 00010293
RAX: ffffffff81f23d54 RBX: 0000000000000001 RCX: ffff88807f7b9f40
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff905c8e10
RBP: 0000000000000003 R08: ffff88807f7b9f40 R09: 0000000000000003
R10: 0000000000000007 R11: 0000000000000000 R12: ffff88807f4f3050
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00005555805e0400(0000) GS:ffff888125024000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006a9ee0 CR3: 000000007133a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mark_chain_precision kernel/bpf/verifier.c:3373 [inline]
 check_helper_call kernel/bpf/verifier.c:10894 [inline]
 do_check_insn+0x12a74/0x17c20 kernel/bpf/verifier.c:18177
 do_check kernel/bpf/verifier.c:18363 [inline]
 do_check_common+0x3c19/0x5d30 kernel/bpf/verifier.c:19444
 do_check_main kernel/bpf/verifier.c:19540 [inline]
 bpf_check+0x2639/0x2e10 kernel/bpf/verifier.c:21195
 bpf_prog_load+0x14d6/0x1c20 kernel/bpf/syscall.c:3133
 __sys_bpf+0xd0d/0xd90 kernel/bpf/syscall.c:6367
 __do_sys_bpf kernel/bpf/syscall.c:6486 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6483 [inline]
 __x64_sys_bpf+0xba/0xd0 kernel/bpf/syscall.c:6483
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4f25cf1749
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff991a6f18 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4f25cf1749
RDX: 0000000000000080 RSI: 0000200000000300 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4f25d84c40 R15: 0000000000000002
 </TASK>
----------------
Code disassembly (best guess):
   0:	ff 89 d9 80 e1 07    	decl   0x7e180d9(%rcx)
   6:	80 c1 03             	add    $0x3,%cl
   9:	38 c1                	cmp    %al,%cl
   b:	0f 8c 16 ff ff ff    	jl     0xffffff27
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8 76 17 44 00       	call   0x44178f
  19:	e9 09 ff ff ff       	jmp    0xffffff27
  1e:	e8 0c d0 d4 ff       	call   0xffd4d02f
  23:	48 8d 3d b5 50 6a 0e 	lea    0xe6a50b5(%rip),%rdi        # 0xe6a50df
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 8b 3c 24          	mov    (%rsp),%rdi
  33:	48 81 c7 88 08 00 00 	add    $0x888,%rdi
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c6                   	(bad)
  3d:	a0                   	.byte 0xa0
  3e:	c6                   	(bad)
  3f:	f6                   	.byte 0xf6


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
