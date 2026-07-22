Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B12D97B9
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724991; cv=none; b=uAjRxh5WAtVj9FMHQb5830x6iWt+0Hbcn94ZWoqYkQalC7pefByoBUAOJU0xcCuZ5HwPM8kpPYcHu3wt9MwgQRdwVYJ1u07B2IfGxB6OkNFp1eoPWxyfwixKovu4cuvPiKymWlQdWWNBMjJ3hnTodYe/QuFlR/UenuSrR29f9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724991; c=relaxed/simple;
	bh=IgcOH20bdGsH9QeYJXFhiP7nhUP7lAbDOQsHz/vmrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvXje8UJUM9u98uSXJXNBcPjXol4Uo6/qaxp72PDeYxw/SJsUVCvycFjGXwM+HIgEghrRgfPUvjQsulUDUwkoZvkAON9uzMCQYlP790OvWNKaQI6JuBl6qI0iV7Ce5fGDIKFmhMXZUIeSH31TuJVrbEsQNSOfwOixl9vxQjPo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=b2/jXr4z; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="b2/jXr4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1784724986;
	bh=i0SeIfWvKE8BRqBGZtZxo3wp6f+EfrFAfpHqRNSd+gk=;
	h=From:Subject:Date:Message-ID;
	b=b2/jXr4zdLGk1XzxLyQG1ZSXBnI97jfeuLZHoSx6tGaWKWqvG8kCWkW7AIpaBtkAd
	 zZvYOAUXJj0TCToUWGNOM8aw3OrHwDrNC7ObIL3bYIiOLzab7sqVATgT2Cd/mzcwTc
	 6o7RzaU9ATdLwlMztGFBkt33P5FrkWje7TEQGnTk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.152.105])
	by sina.com (10.54.253.31) with ESMTP
	id 6A60BDED0000706E; Wed, 22 Jul 2026 20:56:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4103836815950
X-SMAIL-UIID: 30F5E33652204A6ABC524CE1E159B6AA-20260722-205616-1
From: Hillf Danton <hdanton@sina.com>
To: Nikolay Ivchenko <nivchenko.dev@gmail.com>
Cc: syzbot+2ad5ec205a38c46522b3@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in unmap_region
Date: Wed, 22 Jul 2026 20:56:02 +0800
Message-ID: <20260722125604.664-1-hdanton@sina.com>
In-Reply-To: <20260722071417.229890-1-nivchenko.dev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 10:14:16 +0300 Nikolay Ivchenko wrote:
> On syzbot report, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    32f1c2bbb26a net: airoha: dma map xmit frags with skb_frag..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=116c2c0a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2ad5ec205a38c46522b3
> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132f5861580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7b7c3a22a8ed/disk-32f1c2bb.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/168b43c87305/vmlinux-32f1c2bb.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/70704720d284/bzImage-32f1c2bb.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2ad5ec205a38c46522b3@syzkaller.appspotmail.com
> >
> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > rcu: 	0-...!: (1 GPs behind) idle=6664/1/0x4000000000000000 softirq=17730/17732 fqs=2
> > rcu: 	(detected by 1, t=10502 jiffies, g=17101, q=1895 ncpus=2)
> > Sending NMI from CPU 1 to CPUs 0:
> > NMI backtrace for cpu 0
> > CPU: 0 UID: 0 PID: 6010 Comm: modprobe Not tainted syzkaller #0 PREEMPT(full)
> > ...
> > Call Trace:
> > <IRQ>
> > __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:176 [inline]
> > _raw_spin_unlock_irqrestore+0x1b/0x80 kernel/locking/spinlock.c:198
> > debug_hrtimer_deactivate kernel/time/hrtimer.c:490 [inline]
> > __run_hrtimer kernel/time/hrtimer.c:2000 [inline]
> > __hrtimer_run_queues+0x239/0xa10 kernel/time/hrtimer.c:2096
> > hrtimer_interrupt+0x448/0x910 kernel/time/hrtimer.c:2215
> > local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
> > __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
> > instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
> > sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
> > </IRQ>
> 
> I have analyzed this issue in sch_taprio, and configuring extremely short
> schedule entry intervals (e.g., 700 ns) in software mode
> (!FULL_OFFLOAD_IS_ENABLED) seems to be the root cause, leading to an hrtimer
> interrupt storm that locks up the CPU and results in RCU stalls and softlockups.

How many hours were spent?

> When testing with larger intervals, the lockup completely disappeared.
> Furthermore, no matter how many times I captured this stall, NMI backtraces
> consistently showed the CPU trapped inside the timer handler
> (advance_sched / hrtimer_interrupt).
> 
> Please note that this bug can show up in different execution contexts and with
> various crash titles depending on what the CPU was doing when the interrupt
> storm hit. As such, despite what the subject line of this report suggests, this
> is not a memory management issue — the root cause is entirely in sch_taprio
> (networking).
> 
> === Cause Analysis ===
> 
> Currently, fill_sched_entry() validates schedule intervals against a minimum
> duration using length_to_duration(q, ETH_ZLEN):
> 
>     int min_duration = length_to_duration(q, ETH_ZLEN);
> 
>     [...]
> 
>     if (interval < min_duration) {
>         NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
>         return -EINVAL;
>     }
> 
> On high-speed interfaces (e.g., veth, which defaults to 10 Gbps),
> transmitting 60 bytes (ETH_ZLEN) takes only ~48 ns. Consequently, an interval
> such as 700 ns passes validation because 700 ns > 48 ns.
> 
> However, in software scheduling mode (!FULL_OFFLOAD_IS_ENABLED), the hrtimer
> handling overhead easily exceeds 700 ns, particularly in virtualized
> environments or on slower CPUs, leading to CPU lockups and RCU stalls.
> 
> === Minimal Reproducer ===
> 
> Based on the reproducer provided by syzbot, I have created a minimal shell
> script reproducer:
> 
> #!/bin/bash
> ip link del dev veth0 2>/dev/null
> ip link add dev veth0 numtxqueues 4 type veth peer name veth1
> ip link set dev veth0 up
> 
> # 700 ns interval passes validation on 10Gbps veth, causing softlockup:
> tc qdisc add dev veth0 parent root handle 1: taprio \
>     num_tc 2 \
>     map 0 1 \
>     queues 1@0 1@1 \
>     sched-entry S 01 700 \
>     clockid CLOCK_TAI
> 
> Note that after running this script, you may need to wait about 20-30 seconds
> before the RCU stall or softlockup warning appears in dmesg.
> 
> === Discussion ===
> 
> I would like to ask for opinions on how this problem should be addressed.
> One approach is to enforce a minimum software interval threshold at
> configuration time in fill_sched_entry() when
> !FULL_OFFLOAD_IS_ENABLED(q->flags):
> 
>     if (!FULL_OFFLOAD_IS_ENABLED(q->flags) && interval < NSEC_PER_USEC) {
>         NL_SET_ERR_MSG_MOD(extack, "Interval too small for software mode");
>         return -EINVAL;
>     }
> 
> However, I am doubtful whether this is the correct way to fix the issue.
> Hardcoding a fixed lower bound (such as 1 us or NSEC_PER_USEC) is a heuristic.
> An interval that works safely on high-performance hardware might still cause
> softlockups on slower hardware or inside heavily loaded virtual machines, while
> a conservative threshold might unnecessarily reject valid configurations.
> 
> Where should this problem ideally be solved? If it belongs at the input
> validation level, how can we properly validate input data when we cannot know
> in advance whether a given CPU will handle the processing load?
> Conversely, if we should try to detect this issue at runtime, how exactly
> should that be implemented?
> 
A known issue, feel free to grep broken in the 2025 report [1].

And my 2cents suggestion sounds like sit back with netflix on.

[1] Subject: Re: [syzbot] [net?] [mm?] INFO: rcu detected stall in inet_rtm_newaddr (2)
https://lore.kernel.org/lkml/CANn89iLjjtXV3ZMxfQDb1bbsVJ6a_Chexu4FwqeejxGTwsR_kg@mail.gmail.com/

> Best regards,
> Nikolay Ivchenko
> 
> #syz set subsystems: net
