Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D747CA64
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030599; cv=none; b=Gh7MaVW1tiM/s6AlkzKodKGN5MpFpcFHxRpp0oLSCTnkU61zjqHD43q1M8ZS2geb0jklH4PJxSkF7tSfhYbut4Fg4p1FOZMTOMGp1ILK5diN965t5POPba+2WyQSZ07ydUrrplSZ166rAAooeqjpQK0MDEU4jKBXiyR0cMJvOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030599; c=relaxed/simple;
	bh=5FACC5e1ZtjaXDFfL86iuNJYEcdN9YlWw9UtFPexxYg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oLDEVXLx8AL6tHnFJ3V25fNl5osJRIDhu8c6kdp/edhB48JRMJnFuUwAfv2U8bEGIp6pdYdIeHeS3+bGeiZomQimpVXTFv657DzjasbNlGcHY+iYG38J29L22IZ0GmuHgJQuaOOs9n7PcyWhVHHVyOOcLCb2KtJ4PLJ9IGdfrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6aae0178901so1575302eaf.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030597; x=1786635397;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ltjwKw9xsNgldC8Auz2dE7yQ7zTtgu0hAxcZDOb6FA=;
        b=gRLO9sBBede44YAIkpOiVZy9B8b2/EkJb88622cLj8QKvKfurWgwLsBB5DlgWODyRf
         7Ia7PomyMD/aMuGjUPToFBvAONuPQG8GpQKnI20Lw5JFXuPiTCNz+xBheo7bTCr021Yj
         xlBPuKSSI+dzlaSQaLPNwIe72im3ioHk/ejS0IDA+/6iFVYr0lN9A1affJ9sVozdRteO
         g7A3xb/PD+46AcoLP1f6LXgqHIiFdD3+1O6PtyHKz1kss3jPRjEUnM/RpgLtQaOXzYsf
         wXi4Z7Z/16zvXhWyRHC0xtw7xbpYOZMYy5hPkAlNEMCRbBoqicvvuL5lQ/8NqTa/fT4L
         +gTg==
X-Forwarded-Encrypted: i=1; AHgh+RrNLs65oQ67vo8NvrhpyIIyp+xTq8xH2/nhXeoe16JB3MYZw/N17Q9gKIl2I17+nU+H1Lx3XUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSBNMYyd9PdY9iH9uxG2RIS6RQfOettpGI/sMU+uosC9UWmXh
	VvFqj1FoA3I6tCg5jy5d0IhyvbANwkAhxB2fk9EEAzqyANF7PNpBbebmk/AihBJtQqy5wb1qYMf
	g9p0v+/aQf0SSIBp0nbCI9c0f/JOOUK8Zr9+AWzNrKdE3Z/vukUDFtxc5pIA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1792:b0:6a3:a335:1ccd with SMTP id
 006d021491bc7-6ae96c7e7c5mr7984217eaf.8.1786030597180; Thu, 06 Aug 2026
 08:36:37 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:36:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74aa05.01d0871a.3a0d52.0026.GAE@google.com>
Subject: [syzbot] [intel-wired-lan?] BUG: unable to handle kernel paging
 request in e1000_get_variants_82571
From: syzbot <syzbot+0ddf1022b4d5c391c09b@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ae93b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0ddf1022b4d5c391c09b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b7649580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117c6cc6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32c9dc084aaa/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7604244b0a9/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4cd321f6fe47/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ddf1022b4d5c391c09b@syzkaller.appspotmail.com

e1000e 0000:00:03.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:03.0 0000:00:03.0 (uninitialized): Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
BUG: unable to handle page fault for address: ffffc900035b4b58
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 13fe5c067 P4D 13fe5c067 PUD 1cae3067 PMD 22725067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: sync_wq local_pci_probe_callback
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_init_mac_params_82571 drivers/net/ethernet/intel/e1000e/82571.c:278 [inline]
RIP: 0010:e1000_get_variants_82571+0xe08/0x1c30 drivers/net/ethernet/intel/e1000e/82571.c:320
Code: f6 ff ff e8 da 1f 0f fb 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 f7 0b 00 00 49 8b 87 00 07 00 00 <8b> a8 58 5b 00 00 89 e8 31 ff 83 e0 02 89 c6 89 44 24 10 e8 10 1a
RSP: 0018:ffffc900000f7a00 EFLAGS: 00010246
RAX: ffffc900035af000 RBX: ffff88807ed91694 RCX: ffffffff86fb44f8
RDX: 1ffff1100fdb22b8 RSI: ffffffff86fb4506 RDI: ffff88801eaa2540
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff9200001ef45
R13: ffff88807ed915c0 R14: ffff88807ed915b8 R15: ffff88807ed90ec0
FS:  0000000000000000(0000) GS:ffff888123dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900035b4b58 CR3: 0000000073af9000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 e1000_probe+0x1123/0x36b0 drivers/net/ethernet/intel/e1000e/netdev.c:7494
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 local_pci_probe_callback+0x35/0x80 drivers/pci/pci-driver.c:361
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
CR2: ffffc900035b4b58
---[ end trace 0000000000000000 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_init_mac_params_82571 drivers/net/ethernet/intel/e1000e/82571.c:278 [inline]
RIP: 0010:e1000_get_variants_82571+0xe08/0x1c30 drivers/net/ethernet/intel/e1000e/82571.c:320
Code: f6 ff ff e8 da 1f 0f fb 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 f7 0b 00 00 49 8b 87 00 07 00 00 <8b> a8 58 5b 00 00 89 e8 31 ff 83 e0 02 89 c6 89 44 24 10 e8 10 1a
RSP: 0018:ffffc900000f7a00 EFLAGS: 00010246
RAX: ffffc900035af000 RBX: ffff88807ed91694 RCX: ffffffff86fb44f8
RDX: 1ffff1100fdb22b8 RSI: ffffffff86fb4506 RDI: ffff88801eaa2540
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff9200001ef45
R13: ffff88807ed915c0 R14: ffff88807ed915b8 R15: ffff88807ed90ec0
FS:  0000000000000000(0000) GS:ffff888123dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900035b4b58 CR3: 0000000073af9000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	f6 ff                	idiv   %bh
   2:	ff                   	ljmp   (bad)
   3:	e8 da 1f 0f fb       	call   0xfb0f1fe2
   8:	4c 89 ea             	mov    %r13,%rdx
   b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  12:	fc ff df
  15:	48 c1 ea 03          	shr    $0x3,%rdx
  19:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  1d:	0f 85 f7 0b 00 00    	jne    0xc1a
  23:	49 8b 87 00 07 00 00 	mov    0x700(%r15),%rax
* 2a:	8b a8 58 5b 00 00    	mov    0x5b58(%rax),%ebp <-- trapping instruction
  30:	89 e8                	mov    %ebp,%eax
  32:	31 ff                	xor    %edi,%edi
  34:	83 e0 02             	and    $0x2,%eax
  37:	89 c6                	mov    %eax,%esi
  39:	89 44 24 10          	mov    %eax,0x10(%rsp)
  3d:	e8                   	.byte 0xe8
  3e:	10 1a                	adc    %bl,(%rdx)


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
