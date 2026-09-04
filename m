Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606C4A3857
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529904; cv=pass; b=FEvhuY26d8Oio8xYVVRUsMkvGT/QCcwet4TvBbXcPfBJx7OSyRcH70WF4h1krmzUJLoe458DK2PmbhQN9OngHoCkrb1LmpgDOhnlvJFqDNGtAJwwqTg2QvDwssRNdnqfwEBkY1UeHJTbZdzpvf+0HLeaPGirj/iZkUnKTKNS4qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529904; c=relaxed/simple;
	bh=rUxAJT6nswew/ORA99ORiDvpqxI6SWmTWlokP43mF6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvYWV2oUFgGQpw81vz0nKLxr0yq53iRKbbScmY7du7sW4ofGHsBmlX5VQrtr5oLJ/kjzovypKkjvooxJQ6wPAYSrPLffkc1BwdSNnJkVOBp4W3919hmv4mMtEus2UJ+ic62cU3OilBR+Ct8iCg1z5gnTzx3p5gXBiwJTKO/Bj8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KhWS4IjW; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhWS4IjW"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ee4f241f42so1786099a34.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 06:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788529901; cv=none;
        d=google.com; s=arc-20260327;
        b=etcfXyEF/sYqY3Tu4DthkTKEIERmvIihXcXUGSJZ9jTgUPUNais+qpxn6iASqq5cJs
         SwtX0KdedDQKagFTsTvhEXVwJJZKoN2wCOJReTkUMBezHWmssmcYCmr1RW3lDcRNixcW
         k5M7wrX0fJVX6Hgwa2c2RYO3Eqsp1w3+uVoGA2d2tXo8FHU36/zw6grIi1LX6fmR2try
         gxeJfw3C7ZiSyOxHtx3WXcftyGyxW0dkG61193xMJ7tY25MKuPQl4yg5WHew1Cpv9pD+
         tS7LpMqg8iindBFmw7hmhw6q6/Zn4W1fTV4OOf4C7FRrwKHffsi284aAtb8sK1aqkx5e
         9IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4uFYT7VMRvCyS8FvgbQyCRWlBNEPRejHQL1eIDdHeMc=;
        fh=tAH7RWSoXNazHof/l/FjOyjitQjjVYuf+QRPJgNl8cA=;
        b=I1aFK9FO39r8rKM1l7LHXbnmAlS2XyTvmB3cNTSoNZss5Fx4QD8pAD4K80c8rBECGw
         mMDFR5AQ2vgT55iRBEQTLcsfuwBhnaUddK4N1v9ba19qwGKH7LO1YGk/NpH59wR1aTnu
         M4JBf7ZRJYDy3lUbrzzSUeheJPvdSRD6xnVd0QfGEGbkrptHKalEykKkofzLx6CjasS5
         mjPB31XRInmOhczvBY1KDnhyW41lFqY9bfwQ+WPgPMEt6Rm7rG8N1mWI5pKMc3JVA+dt
         0QELQ7ybmn97RcUNQpccSI8I0iibc/WEwOD8VsCH324zfm7qoRrtcTtEON3V3qGlu8xV
         5UnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788529901; x=1789134701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4uFYT7VMRvCyS8FvgbQyCRWlBNEPRejHQL1eIDdHeMc=;
        b=KhWS4IjW2ueh3WzRIWIMLKIs8NKJ1aD63V4dhoF5Nz36MQhltSWPlAbOfZEBudDkoh
         vQSG+UFac1nxQJ3A7RBsD2Q5gaFSzovAXfoyM9kraQJROD2zSPXr1/6eszfddHRQaXAs
         wa7Eja/kmgg0mv8jwvXCsFVA/mPZ7fK+m9/wEHo+2lbnz1wRBLTL74374zCtF++jT6Vp
         fEiZpW9a3d36lFXyLMlIWN9/IEv2WA4RlcbCg0BVfAJOtEDsQXI+tPoVrMsvBSrE6yPS
         RX13vTb/Xrx+vCeRlq51s3BDPt23XXFl+t1A4qL0aHIg8tnmEh3t5BK9bpSSGgQ7yFFs
         qBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529901; x=1789134701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uFYT7VMRvCyS8FvgbQyCRWlBNEPRejHQL1eIDdHeMc=;
        b=KWeB8PVhILgKUkgcfk+qKIOiY3f9XBfGmxeKp6zurAB5gaE6oyKYf042UUVT2KfCpv
         ppynE9HWle+KBxYJ7Md/OMvv2WrCTnETpLndoTcr6OTXqUTFbp3SY02Ydk5yn2Yrky21
         MXH5iitNaF/pFrCjosQzBvwgU2/rUKGTCQRoPqbfWqVGKG1R/WGNiszgmTlZqys7g/sI
         vgm+xdWFsIgTX+PuCO7Pe8ikbOPFWWG+IACSDIRJXM1cV3qBL9+MkUSNqI3ak4cTqhoU
         eigb+lI5AyguukAiCOfRbqz2s8XtVTFAA9VXievZvUVqx4LQumfYxxBI9Wt8naVYO7ld
         tG2w==
X-Forwarded-Encrypted: i=1; AKwUvByMcOvHN5XvC0qxnd0ICN2t49meb5wOSNOFmTJ43vWYJr7o2e7mJ+ZjtBf3jp4euhhcJUG7DB0=@vger.kernel.org
X-Gm-Message-State: AFuF++lAEkqFm5aCiqM1EhCkuesz/ed3d/sghO8BJsZW+YS6ywlIzimu
	IvR4LLlqLM1pHleqWMq2l+Ul6Lo4W6bGl6yfjLBXxGC0r/f7j6QtqTx/ZdNwLhTFNwj7+6iyHCO
	ZUQVqf8lpVuTQcksMOg2JkCC35hOQIf52wayjSzMK
X-Gm-Gg: AYBFou0zOA7dl9C0oiHWwJZZNEiSHhhCZ4NRe89nkg9XJ36xOt5Y+ODfNCJ7bY/oxdS
	Gm+kOu5fdokgIwP2owISO971C5ZBZSlxbrqwc3zZYnDGKki7UaUCVrMQv6QSbCs87abqXBpOLh9
	7ZPj+64epML3dTsunnPEzpHu3MxW0O234mNAr8VWvcEj1k3Lx5dFEkMB+CFSt9rBQPqDfGU72qS
	vlXzXfC+JaKwltpc+QdCbCJyNG+fYVhxXkQCn7Hb453fA39WVdRXd3MwwP3IZkotRf82HEEtGaZ
	k//PAYg2u8Q8Ec2tP2N5Vks9l5Edv6XDhc+ML+1iFOXUQkviCr9hh5+Fyw3MTCbmjCOKCCT3pdd
	lyQ24x7bpteNi+WUzc0SGEPInZthP+psSxprEJWDKqU8FZcNViqhuAV5oH+qckMMmDgVLQbVlge
	JBKbI8sHj4HSee
X-Received: by 2002:a05:6830:349b:b0:7f9:5a3:c248 with SMTP id
 46e09a7af769-7f905a3c423mr4914514a34.31.1788529900324; Fri, 04 Sep 2026
 06:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a95a3f2.99925153.16bd3d.0004.GAE@google.com> <87o6eda9vj.ffs@fw13>
In-Reply-To: <87o6eda9vj.ffs@fw13>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 4 Sep 2026 15:51:28 +0200
X-Gm-Features: AcwNN1V2TR8rTm15-GefrXasAhHE5zTAKrvE0tUIeUr7oihJPBFSchlZZX3QIYc
Message-ID: <CANp29Y5A88TfpKi_rY4WkMEaDdxAwOhA6QSO=R272A2z4xJP2Q@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in
 __hrtimer_run_queues (3)
To: Thomas Gleixner <tglx@kernel.org>, Edward Adam Davis <eadavis@qq.com>
Cc: syzbot <syzbot+6d991f16f4bcc8eeea24@syzkaller.appspotmail.com>, 
	anna-maria@linutronix.de, frederic@kernel.org, linux-kernel@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:00=E2=80=AFAM 'Thomas Gleixner' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, Aug 31 2026 at 08:55, syzbot wrote:
>
> CC+: ARM64 folks. It's their magic git tree ....
>
> Maybe some day syzbot people get their act together and actually figure
> out who should be CC'ed. Hope dies last...

In this particular case, the fact that the reproducer ran against the
arm64 tree does not mean the bug is arm64-specific. As shown on the
dashboard (https://syzkaller.appspot.com/bug?extid=3D6d991f16f4bcc8eeea24),
most crashes are coming from the x86_64 instances.

Judging by what reproducers do, it seems to be related to
net/sched/act_gate.c's gate_timer_func(), for which a patch has
recently been posted by Edward Adam Davis (Cc'd):
https://lore.kernel.org/all/tencent_19FD76F366C43D4737EE9682371A4BF87409@qq=
.com/

Syzbot attributes reports to maintainers based on the crash stack
trace rather than the git tree URL. Because CPU lockups and stalls in
a looping timer callback were caught inside kernel/time/hrtimer.c,
get_maintainer.pl pointed it at the timer subsystem.

>
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    f1b8fa82cab7 Merge branch 'for-next/core' into for-kern=
elci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15aee379580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd1128bc53f2=
ef7f3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D6d991f16f4bcc=
8eeea24
> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e=
255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15632d9e5=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15dd1c15580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/932d85a2bda2/d=
isk-f1b8fa82.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5b6b8fb76e8d/vmli=
nux-f1b8fa82.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c246b61ee396=
/Image-f1b8fa82.gz.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+6d991f16f4bcc8eeea24@syzkaller.appspotmail.com
> >
> > watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [syz-executor:4831]
> > Modules linked in:
> > irq event stamp: 38640849
> > hardirqs last  enabled at (38640848): [<ffff800080557cd8>] seqcount_loc=
kdep_reader_access+0x7c/0xf8 include/linux/seqlock.h:75
> > hardirqs last disabled at (38640849): [<ffff80008690cd0c>] __el1_irq ar=
ch/arm64/kernel/entry-common.c:527 [inline]
> > hardirqs last disabled at (38640849): [<ffff80008690cd0c>] el1_interrup=
t+0x28/0x60 arch/arm64/kernel/entry-common.c:543
> > softirqs last  enabled at (147672): [<ffff80008013891c>] local_bh_enabl=
e include/linux/bottom_half.h:33 [inline]
> > softirqs last  enabled at (147672): [<ffff80008013891c>] put_cpu_fpsimd=
_context arch/arm64/kernel/fpsimd.c:251 [inline]
> > softirqs last  enabled at (147672): [<ffff80008013891c>] do_sve_acc+0x3=
2c/0x4b8 arch/arm64/kernel/fpsimd.c:1349
> > softirqs last disabled at (148217): [<ffff8000800204c0>] __do_softirq+0=
x14/0x20 kernel/softirq.c:656
> > CPU: 0 UID: 0 PID: 4831 Comm: syz-executor Not tainted syzkaller #0 PRE=
EMPT
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/07/2026
> > pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
> > pc : trace_hrtimer_expire_exit include/trace/events/timer.h:321 [inline=
]
> > pc : __run_hrtimer kernel/time/hrtimer.c:2035 [inline]
> > pc : __hrtimer_run_queues+0x32c/0xbe0 kernel/time/hrtimer.c:2096
> > lr : arch_static_branch arch/arm64/include/asm/jump_label.h:36 [inline]
> > lr : trace_hrtimer_expire_exit include/trace/events/timer.h:321 [inline=
]
> > lr : __run_hrtimer kernel/time/hrtimer.c:2035 [inline]
> > lr : __hrtimer_run_queues+0x32c/0xbe0 kernel/time/hrtimer.c:2096
> > sp : ffff80008eb67de0
> > x29: ffff80008eb67e40 x28: 1fffe00034bb7c3a x27: ffff0001a5dbe1c0
> > x26: ffff0000c6453a90 x25: ffff0000d1a50d38 x24: dfff800000000000
> > x23: 0000000000000001 x22: ffff800084ec6bd4 x21: 1fffe00018c8a752
> > x20: ffff0000c64545a8 x19: ffff0000c6453a80 x18: 0000000000000000
> > x17: ffff80011d2d8000 x16: ffff80008eb60000 x15: 0000000000000000
> > x14: 00000000ffff8000 x13: 0000000000000001 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000102 x9 : 0000000000000101
> > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff80008046a634
> > x2 : 0000000000000001 x1 : ffff0000c6453a80 x0 : 0000000000000000
> > Call trace:
> >  arch_static_branch arch/arm64/include/asm/jump_label.h:36 [inline] (P)
> >  trace_hrtimer_expire_exit include/trace/events/timer.h:321 [inline] (P=
)
> >  __run_hrtimer kernel/time/hrtimer.c:2035 [inline] (P)
> >  __hrtimer_run_queues+0x32c/0xbe0 kernel/time/hrtimer.c:2096 (P)
> >  hrtimer_run_softirq+0x15c/0x21c kernel/time/hrtimer.c:2113
> >  handle_softirqs+0x2ec/0xd98 kernel/softirq.c:622
> >  __do_softirq+0x14/0x20 kernel/softirq.c:656
> >  ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:78
> >  call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:885
> >  do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:83
> >  invoke_softirq kernel/softirq.c:503 [inline]
> >  __irq_exit_rcu+0x1ac/0x428 kernel/softirq.c:735
> >  irq_exit_rcu+0x14/0x84 kernel/softirq.c:752
> >  __el1_irq arch/arm64/kernel/entry-common.c:531 [inline]
> >  el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:543
> >  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:548
> >  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:586
> >  __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline=
] (P)
> >  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] =
(P)
> >  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inl=
ine] (P)
> >  _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:198 (P=
)
> >  __debug_check_no_obj_freed lib/debugobjects.c:1180 [inline]
> >  debug_check_no_obj_freed+0x2c8/0x3a4 lib/debugobjects.c:1201
> >  slab_free_hook mm/slub.c:2608 [inline]
> >  slab_free mm/slub.c:6377 [inline]
> >  kmem_cache_free+0x120/0x6b8 mm/slub.c:6504
> >  file_free+0x128/0x1dc fs/file_table.c:104
> >  __fput+0x538/0x74c fs/file_table.c:525
> >  fput_close_sync+0x10c/0x278 fs/file_table.c:617
> >  __do_sys_close fs/open.c:1511 [inline]
> >  __se_sys_close fs/open.c:1496 [inline]
> >  __arm64_sys_close+0x80/0x110 fs/open.c:1496
> >  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
> >  invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
> >  el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
> >  do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
> >  el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
> >  el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
> >  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
> > Sending NMI from CPU 0 to CPUs 1:
> > NMI backtrace for cpu 1
> > CPU: 1 UID: 0 PID: 4802 Comm: kworker/1:3 Not tainted syzkaller #0 PREE=
MPT
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/07/2026
> > Workqueue: rcu_gp process_srcu
> > pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
> > pc : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 =
[inline]
> > pc : _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:19=
8
> > lr : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 =
[inline]
> > lr : _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:19=
8
> > sp : ffff80008eb77dc0
> > x29: ffff80008eb77dc0 x28: 1fffe00034bbc63a x27: ffff0001a5de31c0
> > x26: ffff0001a5de31d0 x25: ffff0000d2a4a538 x24: dfff800000000000
> > x23: 0000000000000001 x22: ffff800084ec6bd4 x21: ffff0001a5de2d80
> > x20: ffff0001a5de2d80 x19: 0000000000000000 x18: 00000000ffffffff
> > x17: ffff80008a7d6000 x16: 0000000000000002 x15: ffff80008a35fda0
> > x14: ffff80008a5d5e28 x13: 0000000000000001 x12: 0000000000000000
> > x11: ffff80008a5d5e28 x10: 0000000000000003 x9 : 0000000000000000
> > x8 : 00000000000000c0 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff80008015611c
> > x2 : 0000000000000002 x1 : ffff0000d32c9d40 x0 : ffff80011d2fd000
> > Call trace:
> >  __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline=
] (P)
> >  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] =
(P)
> >  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inl=
ine] (P)
> >  _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:198 (P=
)
> >  __run_hrtimer kernel/time/hrtimer.c:2028 [inline]
> >  __hrtimer_run_queues+0x22c/0xbe0 kernel/time/hrtimer.c:2096
> >  hrtimer_run_softirq+0x15c/0x21c kernel/time/hrtimer.c:2113
> >  handle_softirqs+0x2ec/0xd98 kernel/softirq.c:622
> >  __do_softirq+0x14/0x20 kernel/softirq.c:656
> >  ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:78
> >  call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:885
> >  do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:83
> >  invoke_softirq kernel/softirq.c:503 [inline]
> >  __irq_exit_rcu+0x1ac/0x428 kernel/softirq.c:735
> >  irq_exit_rcu+0x14/0x84 kernel/softirq.c:752
> >  __el1_irq arch/arm64/kernel/entry-common.c:531 [inline]
> >  el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:543
> >  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:548
> >  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:586
> >  __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline=
] (P)
> >  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] =
(P)
> >  queue_delayed_work_on+0xf4/0x140 kernel/workqueue.c:2624 (P)
> >  queue_delayed_work include/linux/workqueue.h:714 [inline]
> >  srcu_reschedule+0x240/0x338 kernel/rcu/srcutree.c:1957
> >  process_srcu+0xd04/0x1eb8 kernel/rcu/srcutree.c:1991
> >  process_one_work kernel/workqueue.c:3322 [inline]
> >  process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
> >  worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
> >  kthread+0x304/0x3d4 kernel/kthread.c:436
> >  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
> > watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:3:4802]
> > Modules linked in:
> > irq event stamp: 44430735
> > hardirqs last  enabled at (44430734): [<ffff800086932074>] __raw_spin_u=
nlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
> > hardirqs last  enabled at (44430734): [<ffff800086932074>] _raw_spin_un=
lock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:198
> > hardirqs last disabled at (44430735): [<ffff80008690cd0c>] __el1_irq ar=
ch/arm64/kernel/entry-common.c:527 [inline]
> > hardirqs last disabled at (44430735): [<ffff80008690cd0c>] el1_interrup=
t+0x28/0x60 arch/arm64/kernel/entry-common.c:543
> > softirqs last  enabled at (6136): [<ffff80008030e6e4>] softirq_handle_e=
nd kernel/softirq.c:468 [inline]
> > softirqs last  enabled at (6136): [<ffff80008030e6e4>] handle_softirqs+=
0xc28/0xd98 kernel/softirq.c:650
> > softirqs last disabled at (7461): [<ffff8000800204c0>] __do_softirq+0x1=
4/0x20 kernel/softirq.c:656
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
>
