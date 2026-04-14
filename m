Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35340DFC3;
	Tue, 14 Apr 2026 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178343; cv=none; b=nm9qJGME+kATbvinlvBlvi+26JixREGgYp7sQ3YPeVTxKv6aAOnP20XTt49lPYEGDrGTywB1UWT6bTQXsCSV+p1umup/7QLAf6e6I0A+H+y4W7qL+VPV9lyXIP8+iL0PHif+A1KCkPB9j8nR2xCF/oYN0NyRfJ67QErUCMXmgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178343; c=relaxed/simple;
	bh=FyNFq22OhHv2Uq0gQRgQgJmKXPxe1cwbacldtyh4gSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVOab8DNel3AY016WJaNvGz/Qd61AaAr1VUcApbJ1y4WmHpotYW8X+wN0QOUX7t8PapaS1mL3EQVCgeVH+2EDidTBdW+5P4Grjx9B4egkese9mqt7ReTYKq73uREsuwMxmcseDMVi9XrdpOfCXfKoWbaXWbZiv9Ue8sR8eCsrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUDOimQ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yS2FBc3b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUDOimQ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yS2FBc3b"
Date: Tue, 14 Apr 2026 16:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776178340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NczqJSvb7D2JbBqpsIRK9tRIb6npKGXPUg4+M7x7Etk=;
	b=wUDOimQ/Td2fFgAKxasB+wTs+OR5mDYfLShmZBjc3LIylaAXN58ptt5EkpJ+wJhoIG+IBX
	SlvmOU5N0V0znagYmJIUx3gx6bCoiBeQ3OteLoQbcfpM9WtLCKSEpR/IjJab0qdIHoKq7v
	wLTP4W6VJbxtIKMsGa0TKY58Bc0hwW0E3/UpLRBJGOD6qtkuShzrH+kXKpD41Seu2FE7SY
	9e6YmXd3qQwbhRgB0dei/PHOzvyeQKbGsbVOUw79Udokw5Bz81oa7Qsrs9agHNrRMqGYo8
	avTn2zVayeiG84RChKuusNIBJOu/2fKcAFWzQrYZM+vgUPcLVC0sHt3npP+A2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776178340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NczqJSvb7D2JbBqpsIRK9tRIb6npKGXPUg4+M7x7Etk=;
	b=yS2FBc3b5vQKhGu0Kx1Mc7bxKNIGUPMh2r0tl7DJN9LkKzFvJtYeu9DPtNb+CufcPojT2K
	n4PZFg86YsRoW1Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs
 around IRQ handler
Message-ID: <20260414145218.lsNpdAJI@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
 <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>

On 2026-04-14 16:20:46 [+0200], Marek Vasut wrote:
> > This is what happens since commit 0913ec336a6c0 ("net: ks8851: Fix
> > deadlock with the SPI chip variant"). Before that commit the softirq
> > execution will be picked up by netdev_alloc_skb_ip_align() and requires
> > PREEMPT_RT and a RX packet in #1 to trigger the deadlock.
> 
> Do you want me to add this into the V4 commit message ?

The description does not match the code since the commit mentioned
above.

> > > Fix the problem by disabling BH around critical sections, including the
> > > IRQ handler, thus preventing the net_tx_action() softirq from triggering
> > > during these critical sections. The net_tx_action() softirq is triggered
> > > at the end of the IRQ handler, once all the other IRQ handler actions have
> > > been completed.
> > > 
> > >   __schedule from schedule_rtlock+0x1c/0x34
> > >   schedule_rtlock from rtlock_slowlock_locked+0x548/0x904
> > >   rtlock_slowlock_locked from rt_spin_lock+0x60/0x9c
> > >   rt_spin_lock from ks8851_start_xmit_par+0x74/0x1a8
> > >   ks8851_start_xmit_par from netdev_start_xmit+0x20/0x44
> > >   netdev_start_xmit from dev_hard_start_xmit+0xd0/0x188
> > >   dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
> > >   sch_direct_xmit from __qdisc_run+0x1f8/0x4ec
> > >   __qdisc_run from qdisc_run+0x1c/0x28
> > >   qdisc_run from net_tx_action+0x1f0/0x268
> > >   net_tx_action from handle_softirqs+0x1a4/0x270
> > >   handle_softirqs from __local_bh_enable_ip+0xcc/0xe0
> > >   __local_bh_enable_ip from __alloc_skb+0xd8/0x128
> > >   __alloc_skb from __netdev_alloc_skb+0x3c/0x19c
> > >   __netdev_alloc_skb from ks8851_irq+0x388/0x4d4
> > >   ks8851_irq from irq_thread_fn+0x24/0x64
> > >   irq_thread_fn from irq_thread+0x178/0x28c
> > >   irq_thread from kthread+0x12c/0x138
> > >   kthread from ret_from_fork+0x14/0x28
> > 
> > The backtrace here and the description is based on an older kernel.
> > However
> I actually did update the backtrace in V3 with the one from current next
> 20260413 .

That would be from yesterday and the change is merged since v6.10. But
why is the softirq starting from __netdev_alloc_skb() instead of
spin_unlock_bh(&ks->statelock)? After that unlock, the softirq must be
processed and __netdev_alloc_skb() _could_ observe pending softirqs but
not from ks8851.

Sebastian
