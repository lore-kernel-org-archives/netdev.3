Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE93BCD14
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524762; cv=none; b=BUT5gqFkcb6NQTKi+vKyyr7koBtaKEb6e44RgB/JxARSc94qQ9ap2Hu/wYaysFL3yLVyttH51SM5nZ0vOwe0BYdWACVDJsVm0xFsHaHFyj1yOsI9Vm064JMrRpfjLWp1GgsnmkWliNpu2W+ICBHsoH+JH8ZMPWKtp2SomwvdPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524762; c=relaxed/simple;
	bh=rdvdAZ/LIltJL6/ZqnNsATM1FdCywDLJ5OVcE/EqH6M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=obYvsl2RPxkMG8cDtYlcIGcVT7716cne0uSalB2ISuDixIiNQgWPbWkSL0jXOSVxyn9b3jA2kAYXbYM2lN77TnsIeWEWSR+aVxnPC3EJnV6T4MgVXUY+NASawbQi7uJX5VNuBIfK8wK+8lKd4VcS7hyTrzeFkvE0daTtVg9r7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4b1bd347d5fso413828b6e.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524760; x=1787129560;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geG1mDOLSLjhAUKKy7yx1hwfYe0E0r539anreB4VsuE=;
        b=CL7BuSjIW1b/HvHOJ2c0ROE0kTthhD3kHCotHiTvF4ujQ7IDc/A8/Tk1h6XkcyV2RH
         mRD4OoJVY2B/BN9ayYLCUUB22EXoB+jjWNle23CFtEI6VNQ4giXCzk68v07aJATjgSiP
         oeeEGG8+A7+nOw8k4jQeAOvwgBi3TcmLFpa5Z29+ucDnz1lYR2O/dTb59VBKq7SW67kh
         2swPOJ2bafjiv2vRYWG/7gxhBXNjYVuI9f36oAg8z7Wtd+go0ojW7ziBlKLHqj/V8iFV
         tduLC3onMlGFCBCBjxonH0w5LxIXe7ORlQYq+kHeEP55RXmBiPviLZVRLqaOIytnGcfV
         sK1g==
X-Forwarded-Encrypted: i=1; AHgh+RrEvyvi8eb1dWvvTV9nXqL6w8E6D8vb8L1x6Km//0tgpqj1QsWDFwxBnxmopDpPT38dihgOKZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1JYK2WChNCe2H5FukPopvyZU/WUYxjG9o41TUhAmDCojJgci
	qUxDwHbijlSNaT23WFOj7EM9P5stheAcaF7cdgniELLAPGUNdFrEs0nNxkAb589c44ETzIalRe0
	GJG/qjpYaD0sufx16OPxfJJdMw2C7JsbGZFrzLMEWhChnvVAn8vTjApVWWuI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2209:b0:497:df42:1e04 with SMTP id
 5614622812f47-4b210c4e4fbmr3012471b6e.18.1786524759956; Wed, 12 Aug 2026
 01:52:39 -0700 (PDT)
Date: Wed, 12 Aug 2026 01:52:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7c3457.d5f0ebe7.22d851.000a.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in advance_sched / netdev_set_num_tc (2)
From: syzbot <syzbot+a181d44496a497911353@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06cf61899d64 Merge tag 'x86-urgent-2026-08-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e95fb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33c5ac947f6be69e
dashboard link: https://syzkaller.appspot.com/bug?extid=a181d44496a497911353
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9d74d5e3090/disk-06cf6189.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3933e211e222/vmlinux-06cf6189.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73924770119d/bzImage-06cf6189.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a181d44496a497911353@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in advance_sched / netdev_set_num_tc

write to 0xffff88811ac5c036 of 2 bytes by task 4421 on cpu 0:
 netdev_set_num_tc+0x1b2/0x1d0 net/core/dev.c:3117
 mqprio_init+0x68b/0xb90 net/sched/sch_mqprio.c:417
 qdisc_create+0x57f/0x9c0 net/sched/sch_api.c:1346
 __tc_modify_qdisc net/sched/sch_api.c:1780 [inline]
 tc_modify_qdisc+0x102a/0x1550 net/sched/sch_api.c:1844
 rtnetlink_rcv_msg+0x6a7/0x720 net/core/rtnetlink.c:7085
 netlink_rcv_skb+0x11e/0x220 net/netlink/af_netlink.c:2556
 rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:7103
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x5a7/0x680 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x5be/0x6f0 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x532/0x580 net/socket.c:2684
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2773
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811ac5c036 of 2 bytes by interrupt on cpu 1:
 netdev_get_num_tc include/linux/netdevice.h:2684 [inline]
 taprio_set_budgets net/sched/sch_taprio.c:667 [inline]
 advance_sched+0x58f/0x730 net/sched/sch_taprio.c:984
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x1f8/0x510 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x257/0x810 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x5f/0x1c0 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x6f/0x80 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
 encoded_page_ptr include/linux/mm_types.h:268 [inline]
 free_pages_and_swap_cache+0xe1/0x3b0 mm/swap_state.c:577
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
 tlb_flush_mmu+0x552/0x6d0 mm/mmu_gather.c:424
 zap_pte_range mm/memory.c:1973 [inline]
 zap_pmd_range mm/memory.c:2020 [inline]
 zap_pud_range mm/memory.c:2048 [inline]
 zap_p4d_range mm/memory.c:2069 [inline]
 __zap_vma_range+0x2521/0x2c70 mm/memory.c:2109
 unmap_vmas+0x200/0x310 mm/memory.c:2178
 exit_mmap+0x1a2/0x5e0 mm/mmap.c:1300
 __mmput+0x28/0x1c0 kernel/fork.c:1187
 mmput+0x40/0x50 kernel/fork.c:1210
 exit_mm+0x113/0x1a0 kernel/exit.c:615
 do_exit+0x438/0x1500 kernel/exit.c:997
 do_group_exit+0xfe/0x140 kernel/exit.c:1152
 get_signal+0xe07/0xf10 kernel/signal.c:3046
 arch_do_signal_or_restart+0x96/0x480 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x15d/0x8c0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x23c/0x3c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000 -> 0x0001

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 4434 Comm: syz.1.244 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
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
