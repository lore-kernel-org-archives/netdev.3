Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610660;
	b=ydKLCiC6VrWBa+sDnp1puYZ5cG4DDIMMAF5D9nNl5qonqMuTcLWEJGySotVQKVSnWTSW
	 CfbMH9PI6yroiiRkHjwF3joUXX08opKksYRiC+Oh9kRC8LYSeEch3vuULQEVBqCXBuLBN
	 3y2dk1CtYGbwRRMyJ+DCqwQooW9xbqyEzGRMAHCN1om5LhN5R1dcUM2y7iFeYlIbFLnaJ
	 j4pB/TAbKt/yu5ezLhUN5k3McBRAsZ0N8LRaWA4TNO/DKYHkoodVvIxWGNN05NnWxaL1j
	 i1okXaNOQrgldWX4wNAtLtleaMQET89U+qsvx2BPlj2r5oC7y8vIglSoJ6PiXkDs0Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610660;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=7wp70HDZeIasBRNgpVKGEOqf7KfJMOUeDTkBNsUqsDY=;
	b=hKz4iufrfiLtTiz0jDElTFK6LiYW+7w78VrtvbQV+uW7QLWY1jbWrATz+dT8FMCn7I5I
	 LgPZEY2JPML8+cxFXpC/SJwn3tUPlr15IndJWmHq/85zkU3vXxfd/7+FnILVyrUVWHdib
	 +xHI9NXeqLqEC5UF7qhd0if6RFY7i04FMRt1l9Mi05L/r2Dg+5fmE0IxSti6jWNBb/KyZ
	 G2yQFM7pDFq2V9LNeNXyi1FUCe67p8L2ahw5IbJmvuct21OrpPB0NDkPGvILjO8TuAHFU
	 4k7TA9besWMlwtpW3o6bYUeoZohMZDS75jfQQeobn3r8Mxg+qMZJmvErIqtl3Qe5reg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B35606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B35606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a45b3f0bdfso1986193b6e.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610659; x=1795215459;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wp70HDZeIasBRNgpVKGEOqf7KfJMOUeDTkBNsUqsDY=;
        b=ngIRdPx2fE9zITDXcGjSpON0OoTHUuLQSw2vo2nL4vwZr6Ev7A3MLZqW4Fr76KsM64
         nSfo758BMhjFiMBaGF4wduXOexBxQwKavhjGouWfEq/bgHPPv76UqacTMf99sNyb8a3+
         Jg3xi+ZqVReegiYtxuyeJJGoB0lxH29xphozWqfHeY7SAL6wT7TYyTb1KGQHpdbmkHOE
         BT143ir1dQed47Q4s3pVR+Feby8WQssbNcrQXuauiQ9RfrrHd1UiSOGfnO5Q9wM/KNRB
         wX1448jodbS8kSs6nxqPykTfcs/OIfD/3bB3CWjzAmqaUY0y9/YGNIbR+MdYc6itspk7
         +5YA==
X-Forwarded-Encrypted: i=1; AL+hErHY+7tNYBjjNnJXl4XwAYQDzPqs/SyQEmmW+eU+iuR1XrtoNRI5TtONc4A4ix2QDWuPLxyl704=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cJhtEz1s9UI9IntcUC5ovmbNgGH7RzsEB7Az/SCeD4vUrlm/+
	BdqgUfK59PMe4EUfbkClghe3PwMwOqBs7+SIHjqDHu6m+XEA+pJTW3Dgv1DxO4ITnObKWB+KB5L
	AFr/b/DbDQgmBOrZgzSEWZPPakxAZfZSzcorZ+1JHE689sc/p5bTM5GxGhgI=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1914:b0:56a:bf02:e4aa with SMTP id
 5614622812f47-56e6389a9f1mr3448659b6e.23.1794610658896; Fri, 13 Nov 2026
 14:57:38 -0800 (PST)
Date: Fri, 13 Nov 2026 14:57:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af795e2.98e60839.1e023a.00d4.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in
 percpu_counter_add_batch (3)
From: syzbot <syzbot+84e27adb95fd2a1fe9bb@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2800868f6322 Merge tag 'sound-7.4-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12acfe4e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf189394a856f11
dashboard link: https://syzkaller.appspot.com/bug?extid=84e27adb95fd2a1fe9bb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2800868f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a4b1a29003d/vmlinux-2800868f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02da498b013d/bzImage-2800868f.xz

AI-generated root cause summary:
During network namespace destruction, IPVS flushes its virtual services and
destinations in __ip_vs_cleanup_batch() via ip_vs_flush() ->
__ip_vs_unlink_dest() -> __ip_vs_dst_cache_reset(). When resetting
dest->dest_dst, __ip_vs_dst_cache_reset() defers releasing the cached dst_entry
via call_rcu(&old->rcu_head, ip_vs_dest_dst_rcu_free). Because IPVS does not
invoke rcu_barrier() during netns teardown, earlier-registered pernet subsystem
exit handlers (such as ip6_route_net_exit) proceed to tear down the namespace's
dst_ops via dst_entries_destroy(), which destroys the percpu counter and sets
pcpuc_entries.counters to NULL. When the deferred ip_vs_dest_dst_rcu_free()
callback eventually runs in softirq context, dst_release() invokes
dst_entries_add() -> percpu_counter_add_batch(), which dereferences the NULL
fbc->counters pointer via this_cpu_read() (%gs:0), causing a fatal kernel page
fault at the GS segment base address.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=84e27adb95fd2a1fe9bb

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84e27adb95fd2a1fe9bb@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff8880d456e000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1d131067 P4D 1d131067 PUD 0 
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:percpu_counter_add_batch+0x4b/0x230 lib/percpu_counter.c:98
Code: 8d 45 58 48 89 c2 48 89 44 24 08 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 9f 01 00 00 4d 8b 65 58 4c 89 ff <65> 49 63 2c 24 4a 8d 54 35 00 48 89 6c 24 10 48 89 eb 48 89 d0 48
RSP: 0018:ffffc900006b0d68 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88803e0cf400 RCX: 0000000000000101
RDX: 1ffff11007045bab RSI: ffffffff85702e00 RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88803822dd00 R14: ffffffffffffffff R15: 0000000000000020
FS:  0000000000000000(0000) GS:ffff8880d456e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880d456e000 CR3: 0000000025b53000 CR4: 0000000000352ef0
DR0: 0000000000000010 DR1: 00000000fffffffd DR2: 400000000001001d
DR3: fffffffffffffff6 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 dst_entries_add include/net/dst_ops.h:59 [inline]
 dst_count_dec net/core/dst.c:163 [inline]
 dst_count_dec net/core/dst.c:160 [inline]
 dst_release net/core/dst.c:177 [inline]
 dst_release+0x2aa/0x330 net/core/dst.c:166
 ip_vs_dest_dst_rcu_free+0x32/0x50 net/netfilter/ipvs/ip_vs_ctl.c:1081
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1220 kernel/rcu/tree.c:2919
 handle_softirqs+0x216/0xa20 kernel/softirq.c:669
 __do_softirq kernel/softirq.c:703 [inline]
 invoke_softirq kernel/softirq.c:542 [inline]
 __irq_exit_rcu+0x178/0x220 kernel/softirq.c:786
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 56 9f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 33 4e 1b 00 fb f4 <e9> 4c 62 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000187e00 EFLAGS: 00000206
RAX: 00000000009bb6ed RBX: ffff888020abcb00 RCX: ffffffff8bf07375
RDX: 0000000000000001 RSI: ffffffff8e62a27a RDI: ffffffff8c835280
RBP: ffffed1004157960 R08: 0000000000000001 R09: ffffed100d426825
R10: ffff88806a13412b R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffff92000030fc4 R15: dffffc0000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:768
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x3ae/0x5b0 kernel/sched/idle.c:355
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:458
 start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x158
 </TASK>
Modules linked in:
CR2: ffff8880d456e000
---[ end trace 0000000000000000 ]---
RIP: 0010:percpu_counter_add_batch+0x4b/0x230 lib/percpu_counter.c:98
Code: 8d 45 58 48 89 c2 48 89 44 24 08 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 9f 01 00 00 4d 8b 65 58 4c 89 ff <65> 49 63 2c 24 4a 8d 54 35 00 48 89 6c 24 10 48 89 eb 48 89 d0 48
RSP: 0018:ffffc900006b0d68 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88803e0cf400 RCX: 0000000000000101
RDX: 1ffff11007045bab RSI: ffffffff85702e00 RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88803822dd00 R14: ffffffffffffffff R15: 0000000000000020
FS:  0000000000000000(0000) GS:ffff8880d456e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880d456e000 CR3: 0000000025b53000 CR4: 0000000000352ef0
DR0: 0000000000000010 DR1: 00000000fffffffd DR2: 400000000001001d
DR3: fffffffffffffff6 DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 45 58             	lea    0x58(%rbp),%eax
   3:	48 89 c2             	mov    %rax,%rdx
   6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  12:	fc ff df
  15:	48 c1 ea 03          	shr    $0x3,%rdx
  19:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  1d:	0f 85 9f 01 00 00    	jne    0x1c2
  23:	4d 8b 65 58          	mov    0x58(%r13),%r12
  27:	4c 89 ff             	mov    %r15,%rdi
* 2a:	65 49 63 2c 24       	movslq %gs:(%r12),%rbp <-- trapping instruction
  2f:	4a 8d 54 35 00       	lea    0x0(%rbp,%r14,1),%rdx
  34:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
  39:	48 89 eb             	mov    %rbp,%rbx
  3c:	48 89 d0             	mov    %rdx,%rax
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
