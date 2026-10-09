Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDB3D45C5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791580657; cv=none; b=hTgWoFRQ+bNQcprVHufsXaO6TfxMEq3o+2cuS0rn7JqjAeJrynE8vtatQMJBPfgH/nRtzTPT0IMgx42eetISLFXOGLS/ZpsQVe/bMUKt6Yf3gQIHNZ5PtiUDxN3YZKmFOONikZJWAEv0sfl7/rQw5oNcJo+DJ9tNxqBqhcIWZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791580657; c=relaxed/simple;
	bh=AebLdlZvrBgnr3ZCZaRNMfttGEn5kvyk+nxFiWh0KGY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AzY8EtjNBdtn+9atYSpdE3O9spgBZkSRm5TCnxLX29Y62a8w/F84xTWaJVZ1HrKsvz6gBC2/+OObVCSbDtfCorhfBSDR7f2wk6Mgsf/GLawwZqkLQvLskbfcPNsLR4D8oVWLTQLFJgrapOMc1M30s8IRfmoRHkrf7yEs+TSVJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-45e6091d8a1so289938fac.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 14:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791580654; x=1792185454;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5ivLcaaRRS7RzUE+jb7bTuZ/lCyDyq+i4BBz+22TLE=;
        b=dyCg/6KJ+M7K1s4O9OCsfRhqDG4mwvxGSLAubjm8iNdsXzc0ssObqhUcilgK56Zw4a
         Vp2fPXT7hU39l0W3yF72r80AFovhHme8rLwSHnFiCzlXeg8DAud4WL1giwGCN5hU/6hv
         SjoxY3/sDyGPRhUS+QXXIm4s2l7lPKUguuRH8ggrP+DrgGXbh0IwwCCg6sdUy1BDYB8Q
         OIFqjAggorFxZEG9jdCEg5o1BpfgjbgnobrrASzHXks682Iv4iUYNZ7QZ0yFXQ/DhpuM
         6axMmVHqt8bZLsvOOsqz0MIytN9aIbzsqLvSypeDZQ5tKL02RqR9elNC64w9nX7gO32x
         bwEw==
X-Forwarded-Encrypted: i=1; AKwUvByYEy5kszpeplbmKP7t/H3DtsS4v5+NpVyGT7C2fHbenQ1m0ubpFGNKigLRe1UimyReizPyLTE=@vger.kernel.org
X-Gm-Message-State: AFuF++mtSyI+8C1nWU5ll4M1H8gyHn2XgfRVb+Xv9X6332HG2I1dW10G
	30kkOxMlYdMgrafqv7fynlLtsQm1OVJtV3qAL/jRDr5Xo7jaMLMEfGPK5YJN8qmHfdQKWYLEMZL
	j3aOIj7K/PHXfj4t4iM+NobX4g7uATXH4K+I8OlWBizeY8sHbP2/lV9X9mPk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1908:b0:4b9:a88b:8884 with SMTP id
 5614622812f47-50c50f2e1f2mr2829696b6e.26.1791580654092; Fri, 09 Oct 2026
 14:17:34 -0700 (PDT)
Date: Fri, 09 Oct 2026 14:17:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac959ee.70ed5d86.2ac85.007d.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in xfrm_state_fini
From: syzbot <syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a90ee4305c4a Linux 7.3-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f60ff5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929e4854a828f434
dashboard link: https://syzkaller.appspot.com/bug?extid=f3f4fce0609f8e91b540
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a90ee430.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f80138e4fa3/vmlinux-a90ee430.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54534ec642dd/bzImage-a90ee430.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hlist_empty include/linux/list.h:1037 [inline]
BUG: KASAN: slab-use-after-free in xfrm_state_fini+0x3f5/0x450 net/xfrm/xfrm_state.c:3402
Read of size 8 at addr ffff88802c88f300 by task kworker/u32:4/5832

CPU: 3 UID: 0 PID: 5832 Comm: kworker/u32:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 hlist_empty include/linux/list.h:1037 [inline]
 xfrm_state_fini+0x3f5/0x450 net/xfrm/xfrm_state.c:3402
 xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4369
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

Allocated by task 6654:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5414 [inline]
 __kmalloc_noprof+0x32f/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 xfrm_hash_alloc+0xcf/0x100 net/xfrm/xfrm_hash.c:21
 xfrm_state_init+0x15f/0x570 net/xfrm/xfrm_state.c:3358
 xfrm_net_init+0x20e/0xcf0 net/xfrm/xfrm_policy.c:4336
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:443
 copy_net_ns+0x345/0x7a0 net/core/net_namespace.c:582
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:132
 copy_namespaces+0x468/0x5e0 kernel/nsproxy.c:195
 copy_process+0x395c/0x8380 kernel/fork.c:2314
 kernel_clone+0x176/0x9d0 kernel/fork.c:2771
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2913
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5739:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 __rcu_free_sheaf_prepare+0x5d/0x300 mm/slub.c:3009
 rcu_free_sheaf+0x1a/0xe0 mm/slub.c:6061
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1260 kernel/rcu/tree.c:2919
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

The buggy address belongs to the object at ffff88802c88f300
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 freed 64-byte region [ffff88802c88f300, ffff88802c88f340)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2c88f
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801c0428c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5143, tgid 5143 (udevd), ts 19750388551
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x67c/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 tomoyo_encode2+0xfb/0x3c0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x18c/0x690 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2af/0x3c0 security/tomoyo/file.c:776
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0xb5/0x1e0 security/security.c:2739
 do_dentry_open+0x588/0x14d0 fs/open.c:973
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x19fa/0x2440 fs/namei.c:5000
page last free pid 5160 tgid 5160 ts 19738479149 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:361
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x2cc/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 tomoyo_encode2+0xfb/0x3c0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x18c/0x690 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2af/0x3c0 security/tomoyo/file.c:776
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0xb5/0x1e0 security/security.c:2739
 do_dentry_open+0x588/0x14d0 fs/open.c:973
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x19fa/0x2440 fs/namei.c:5000
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417

Memory state around the buggy address:
 ffff88802c88f200: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff88802c88f280: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88802c88f300: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff88802c88f380: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88802c88f400: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
==================================================================


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
