Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48563A1A55;
	Fri,  4 Sep 2026 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561160; cv=none; b=bmaH49uKBXaiukvJCG/Cixmj03e0lAHx0OBxy1+TbQkHZoM9qqEGUjax5/3TEzWdlqW8+mv2ySlvKzN4oxNcUYg0I46OgEX7FYryVw3WDfhUFHn74Phgx5qbQEnONdaJdWsGXjOQgqyzAzZ/x58BKnHHnCwRFsQAbT7kGTYsnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561160; c=relaxed/simple;
	bh=mFphrMnbwWUpvBvBXFy9STaEKqwSmpXj0GVI8p19lWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KlAM4LtYCz8/uhteiQQooeoQtktIA6nbh7YwHjJyMfa0pgOsG4jfIPMwrx+0EeNbf7EpnBDPBqJevNGgwjV6RMpPdiGZ2nR3FmZvVKiNCXebK0BoEWNHmS0ORVlH7Yipe5OMpBrHXfHHyzyT0wKqUocBqznErBpIh1XdOJhfXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVQzArvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVQzArvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D5B1F00A3D;
	Fri,  4 Sep 2026 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561159;
	bh=N4XOuKI8bdF6QrOt8dFiolMnMsgRG8ZfclkPeoIoNPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KVQzArvUxiuJF5M0oi+G3BUMBRfQ53DgPJCvhYT1Fx/BmCxBq6OWFIdPvBAu9nYWc
	 jt1+oqW2tbg4MXJWXn4tY3OaNolXg5EW10l6JeHRbW6fG+d0tKBPmbUhtr46a/WofO
	 hVn/uVXJencrrSEmypj18S+dGwLIKw1rWK3ERffKP7H2mKVM8iFWUcwlGoqZFi69BQ
	 gAHN3DGZAFU56CAKj+UAkyOR1awamUjITDsCzZlV2n26o9tEv0zZdsxKgCnjg6xcU1
	 /Nm08svpaMHIrjoJpfxjmRkHXvYjIY0Cwfj9qauPiB3PuOtE9fTLH+s7fv5j4ePmot
	 N8SUOOhtT8H1g==
From: Thomas Gleixner <tglx@kernel.org>
To: Aleksandr Nogikh <nogikh@google.com>, Edward Adam Davis <eadavis@qq.com>
Cc: syzbot <syzbot+6d991f16f4bcc8eeea24@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, netdev <netdev@vger.kernel.org>,
 syzkaller-bugs@googlegroups.com, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Will
 Deacon <will@kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in
 __hrtimer_run_queues (3)
In-Reply-To: <CANp29Y5A88TfpKi_rY4WkMEaDdxAwOhA6QSO=R272A2z4xJP2Q@mail.gmail.com>
References: <6a95a3f2.99925153.16bd3d.0004.GAE@google.com>
 <87o6eda9vj.ffs@fw13>
 <CANp29Y5A88TfpKi_rY4WkMEaDdxAwOhA6QSO=R272A2z4xJP2Q@mail.gmail.com>
Date: Sat, 05 Sep 2026 00:32:36 +0200
Message-ID: <878q5g7im3.ffs@fw13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04 2026 at 15:51, Aleksandr Nogikh wrote:
> On Fri, Sep 4, 2026 at 7:00=E2=80=AFAM 'Thomas Gleixner' via syzkaller-bu=
gs
> <syzkaller-bugs@googlegroups.com> wrote:
>> On Mon, Aug 31 2026 at 08:55, syzbot wrote:
>>
>> CC+: ARM64 folks. It's their magic git tree ....
>>
>> Maybe some day syzbot people get their act together and actually figure
>> out who should be CC'ed. Hope dies last...
>
> In this particular case, the fact that the reproducer ran against the
> arm64 tree does not mean the bug is arm64-specific. As shown on the
> dashboard (https://syzkaller.appspot.com/bug?extid=3D6d991f16f4bcc8eeea24=
),
> most crashes are coming from the x86_64 instances.

Honestly I have no time to click through dashboards to figure this
out. If you already have that information then please include it. With
the gazillion of trees which have fresh patches in them it's not
necessarily a wrong assumption that it might be tree specific. It's the
same problem as bug reports against some random out of date kernel
versions.

> Judging by what reproducers do, it seems to be related to
> net/sched/act_gate.c's gate_timer_func(), for which a patch has
> recently been posted by Edward Adam Davis (Cc'd):
> https://lore.kernel.org/all/tencent_19FD76F366C43D4737EE9682371A4BF87409@=
qq.com/

They look similar, but the reproducers are completely different and the
act_gate backtrace shows the actual problematic code. It might be the
same bug. Edward should be able to tell.

> Syzbot attributes reports to maintainers based on the crash stack
> trace rather than the git tree URL. Because CPU lockups and stalls in
> a looping timer callback were caught inside kernel/time/hrtimer.c,
> get_maintainer.pl pointed it at the timer subsystem.

I get CC'ed on boatloads of reports which happen to show a back trace
somewhere in the code I maintain. In the vast majority of cases the
[hr]timer, interrupt ... core code is just the messenger. The hrtimer
interrupt does not magically rearm timers rapidly or leaves NULL
pointers around.

Don't get me wrong. syszbot is extremly useful, but the amount of work
it creates for those on the receiving end is not really managable and
it's not surprising to me that a lot of reports just fall through the
cracks in general. I try to avoid that, but at times I have to just deal
with more important problems and by the time I come back to it there is
a pile of new reports to wade through.

So having better information in the report would make this definitely
more managable for me and probably for others too:

 - a quick summary that this happens on upstream too and is not
   restricted to the tree which is in the report

 - a TLDR summary of the reproducer operations so it can be seen quickly
   which subsystems might be involved without decoding the reproducer
   file manually.

Also for these kind of issues the robot might grow some rules how to
provide better debug information. Let's look at this particular report:

  __run_hrtimer kernel/time/hrtimer.c:2028 [inline]
  __hrtimer_run_queues+0x22c/0xbe0 kernel/time/hrtimer.c:2096
  hrtimer_run_softirq+0x15c/0x21c kernel/time/hrtimer.c:2113
  handle_softirqs+0x2ec/0xd98 kernel/softirq.c:622
  __do_softirq+0x14/0x20 kernel/softirq.c:656
  ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:78
  call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:885
  do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:83
  invoke_softirq kernel/softirq.c:503 [inline]

So it deduces that the lockup is in __hrtimer_run_queues(). So far so
good.

So if I'd had have the time to download and run the reproducer I would
have enabled the hrtimer trace points with a relatively small trace
buffer, added 'ftrace_dump_on_oops' to the command line and let the
kernel dump it when it crashes. In case of a self rearming timer which
keeps it in that loop, that surely would dump a series of
start/expire/start/ events with the same timer and the expire_entry
tracepoint would have the offending function in it.

Just a thought, but maybe there is something which can be done.

Let me stare at __hrtimer_run_queues() whether we can add some
lightweight mechanism to prevent such issues.

Thanks,

        tglx
