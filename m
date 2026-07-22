Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056953C1961
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704488; cv=none; b=i+0wLn7w/UfkmLlyjO103A5eVOpjxa5ovU+ZJTRFG/pWqoVyN5Kt5PGtizrwGOipk8REeY7w+qbUzBMXujsu0fPxtC+nQUNJS91+vaTix3S/JpQJT/x2wKeeavTD6GSffZz/54K5xb5WUIoJi2GfRcU8JBPKoL51lu+6Hhbw+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704488; c=relaxed/simple;
	bh=wXNegPrSHIE29llJt/GinDElc+28WOyHaWJFnX80WVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCGI+Xdwm3RAeMOHWDhw5Hmi/cVrkrnroI4y5nhJzBoiwh7OTB8qWPGvQRPNTqHn9Q5iMMkCwxhabsAcGLl+rfdfmEXy9BWERBli0nMTrGk5HDYfn/7PKqy6uQkJAW1Rb/3lnPL6dS+8JtprW2ndRuDZmgDrm5aPv7Z486qNNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT86rnas; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT86rnas"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aec090da14so1181673e87.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704485; x=1785309285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6x2HH5cDLmqxla1ueBrVL4yEKp2Gf+nJs7XENhnhYZQ=;
        b=LT86rnas6BJDszak5QZ/kQKYhthCY+xB8eJD3gP1lxLTTTxLMr4oWVHawy6fDXIpL3
         1tWxmbATXtU15pvUGUPzvZL9wNddnqcRFH1avBWclsyqnWGUmm8AK5z3ytE2Iy+1uXov
         eGI6ast5wsU4ClvQuauq2WX3gmHRXkolOcSGJRI7LpeSw6o7OyoQUdq0n6XD7Mlo37nG
         5oztqek2ReTlFnImcaAixzRD3gaWmikYtZw37WqYqdohNpnQEpdh25EuifV6mZGy9ngV
         2u25m5yO9NVRg4IGritT1jqJlbjOlv0TpCApCfa7BNcZT3Wgd4qvgHei0EYsxHKCmv8D
         wo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704485; x=1785309285;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6x2HH5cDLmqxla1ueBrVL4yEKp2Gf+nJs7XENhnhYZQ=;
        b=gM9WtJmonZdnsQKTRtCCiyIBeGRs8Nv4NfnElay4HfpHEGHRFLNQN6Gmq0ZpJzoB1j
         jW1kYXvkDFEWUMWv0xh667Qp2hhp/ilEs1LI0grMAoTWdKuY48H8jK8cxVLa8f5YcOGF
         blExzLXRe//YnJG1cA59Y+dpooKG+o1roJpg3nggOhwvq/KJSKSnZeMfGvZGFOsrD88n
         tZkMWjeEDpM2rlcBlX5rStJm9giJCy3FfiWcZyE7W7tt1urGLjPVqzRYO1Kr3L6gaUCx
         d/eZhblNDEFsNwebH6Us9wUvveBiCIX1qDIyj+3kAg3fLh36X93W5vTM9vlK3UW+Lcbg
         qh5g==
X-Forwarded-Encrypted: i=1; AHgh+RpnDmk0ZsVFD42WBkCgTj1pFQymF0LwdObjg/LIozbuY6md7LDXvSzHBp2ejmHCeC+ABajnlRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYd1kyNN+zxPHxG9QKYPhoCkRdaGdi6rA8q2wJiMXK5XUHJJP
	vAcRRZ0sK923haI00IGkcyjwW46CDIKx50XBf9WEcODOApbDUFAwy0PO
X-Gm-Gg: AR+sD13jbmmH67i/nXEQoS47HXqKC3+5DpK0KA4x59LxsFpo00uVYnkciFTzzutbUVX
	1oSNt+xxpxniWIj/28tLMMGtKKCGaTS06tKbL4mmcZ2VAy4Ux00FPwDglyPQJK5t20Bef1k8E3J
	XS6xUOzPJl2O1mOLvCSU0Myk991EgZBrlLm2yJDWHgzFkSBc26NJJA9cFG5AxETZ1aA/JrMilbJ
	gOcyseBFelay6bt29rnGsxHOHAkCp6g+qh8YffjpiYJVSHa+HhXuIsuzCeehvFg6XEt7Z9SeP1F
	2DBtEd5LwNRhZeYOT4RThCQt8YBcp0eE+Mhk3xPrdllmQjojYCUz9Y9c1gZl2NQ8E8d61qUQrQb
	KvN2qXqFBrHfp7xumrU8HcbKKSqOLfHv9UfqHp/4z+1X7cGTZ2PxtDAoD1tmZ0D6Z1/FJUbOJbp
	PEhphGtSB54QxXIJHxc1gXNQ==
X-Received: by 2002:a05:6512:1327:b0:5ae:cf48:bd37 with SMTP id 2adb3069b0e04-5b2a49ef6c0mr729643e87.1.1784704484709;
        Wed, 22 Jul 2026 00:14:44 -0700 (PDT)
Received: from sheldie-RC14UD.. ([109.69.61.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9f49b70sm309117e87.74.2026.07.22.00.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:14:44 -0700 (PDT)
From: Nikolay Ivchenko <nivchenko.dev@gmail.com>
To: syzbot+2ad5ec205a38c46522b3@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org,
	jannh@google.com,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	netdev@vger.kernel.org,
	pfalcato@suse.de,
	syzkaller-bugs@googlegroups.com,
	vbabka@kernel.org,
	vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in unmap_region
Date: Wed, 22 Jul 2026 10:14:16 +0300
Message-ID: <20260722071417.229890-1-nivchenko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a475ec3.6912059f.e0473.000a.GAE@google.com>
References: <6a475ec3.6912059f.e0473.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On syzbot report, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    32f1c2bbb26a net: airoha: dma map xmit frags with skb_frag..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=116c2c0a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
> dashboard link: https://syzkaller.appspot.com/bug?extid=2ad5ec205a38c46522b3
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132f5861580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7b7c3a22a8ed/disk-32f1c2bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/168b43c87305/vmlinux-32f1c2bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/70704720d284/bzImage-32f1c2bb.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2ad5ec205a38c46522b3@syzkaller.appspotmail.com
>
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	0-...!: (1 GPs behind) idle=6664/1/0x4000000000000000 softirq=17730/17732 fqs=2
> rcu: 	(detected by 1, t=10502 jiffies, g=17101, q=1895 ncpus=2)
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 6010 Comm: modprobe Not tainted syzkaller #0 PREEMPT(full)
> ...
> Call Trace:
> <IRQ>
> __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:176 [inline]
> _raw_spin_unlock_irqrestore+0x1b/0x80 kernel/locking/spinlock.c:198
> debug_hrtimer_deactivate kernel/time/hrtimer.c:490 [inline]
> __run_hrtimer kernel/time/hrtimer.c:2000 [inline]
> __hrtimer_run_queues+0x239/0xa10 kernel/time/hrtimer.c:2096
> hrtimer_interrupt+0x448/0x910 kernel/time/hrtimer.c:2215
> local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
> __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
> instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
> sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
> </IRQ>

I have analyzed this issue in sch_taprio, and configuring extremely short
schedule entry intervals (e.g., 700 ns) in software mode
(!FULL_OFFLOAD_IS_ENABLED) seems to be the root cause, leading to an hrtimer
interrupt storm that locks up the CPU and results in RCU stalls and softlockups.
When testing with larger intervals, the lockup completely disappeared.
Furthermore, no matter how many times I captured this stall, NMI backtraces
consistently showed the CPU trapped inside the timer handler
(advance_sched / hrtimer_interrupt).

Please note that this bug can show up in different execution contexts and with
various crash titles depending on what the CPU was doing when the interrupt
storm hit. As such, despite what the subject line of this report suggests, this
is not a memory management issue — the root cause is entirely in sch_taprio
(networking).

=== Cause Analysis ===

Currently, fill_sched_entry() validates schedule intervals against a minimum
duration using length_to_duration(q, ETH_ZLEN):

    int min_duration = length_to_duration(q, ETH_ZLEN);

    [...]

    if (interval < min_duration) {
        NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
        return -EINVAL;
    }

On high-speed interfaces (e.g., veth, which defaults to 10 Gbps),
transmitting 60 bytes (ETH_ZLEN) takes only ~48 ns. Consequently, an interval
such as 700 ns passes validation because 700 ns > 48 ns.

However, in software scheduling mode (!FULL_OFFLOAD_IS_ENABLED), the hrtimer
handling overhead easily exceeds 700 ns, particularly in virtualized
environments or on slower CPUs, leading to CPU lockups and RCU stalls.

=== Minimal Reproducer ===

Based on the reproducer provided by syzbot, I have created a minimal shell
script reproducer:

#!/bin/bash
ip link del dev veth0 2>/dev/null
ip link add dev veth0 numtxqueues 4 type veth peer name veth1
ip link set dev veth0 up

# 700 ns interval passes validation on 10Gbps veth, causing softlockup:
tc qdisc add dev veth0 parent root handle 1: taprio \
    num_tc 2 \
    map 0 1 \
    queues 1@0 1@1 \
    sched-entry S 01 700 \
    clockid CLOCK_TAI

Note that after running this script, you may need to wait about 20-30 seconds
before the RCU stall or softlockup warning appears in dmesg.

=== Discussion ===

I would like to ask for opinions on how this problem should be addressed.
One approach is to enforce a minimum software interval threshold at
configuration time in fill_sched_entry() when
!FULL_OFFLOAD_IS_ENABLED(q->flags):

    if (!FULL_OFFLOAD_IS_ENABLED(q->flags) && interval < NSEC_PER_USEC) {
        NL_SET_ERR_MSG_MOD(extack, "Interval too small for software mode");
        return -EINVAL;
    }

However, I am doubtful whether this is the correct way to fix the issue.
Hardcoding a fixed lower bound (such as 1 us or NSEC_PER_USEC) is a heuristic.
An interval that works safely on high-performance hardware might still cause
softlockups on slower hardware or inside heavily loaded virtual machines, while
a conservative threshold might unnecessarily reject valid configurations.

Where should this problem ideally be solved? If it belongs at the input
validation level, how can we properly validate input data when we cannot know
in advance whether a given CPU will handle the processing load?
Conversely, if we should try to detect this issue at runtime, how exactly
should that be implemented?

Best regards,
Nikolay Ivchenko

#syz set subsystems: net
