Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A194F7CAE;
	Mon, 12 Oct 2026 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840333; cv=none; b=djlwk174gtZmnVGe8ajbPCShUzpU8vAWRR9q4yxvOtbzdfyIJ/6i+GjBjwhXaTUegsWiKN49HJMbaEiD87hqSitFm5d+VmXGOd8q74jP2saOsP3bHGr4LJ6+pZs/6I0qaSfWcSnQTqS09Y/WGjAW0cMEjNsWqCGZFKhx833ZFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840333; c=relaxed/simple;
	bh=fvjje0IIW6MOjzpPa7bXnEazhGyVa6KL4EdFPoxyr1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjVY5rMupFVzNEuye0zi8Qu6EJIT5P0VHyq0zBl2nPl14WLDmqIJ43j/8H0p/gGQJuevguOpu2f6ITx4oF1zO85tagKuEAJ3dJMtqZCKaTFWElubYsuJSHxYOCOrf5mRZ32iweRnBDma3DdPfVQwfK5jtJYVouC5k8h06DM2/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MORn/rI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17yHSlhA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MORn/rI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17yHSlhA"
Date: Mon, 12 Oct 2026 23:25:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791840329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAiScCw3xT8qTEUpGk6BjUljTycDujh4sIDNa9F0P6Y=;
	b=3MORn/rIhXC6vXHl+Ic4CJZNg4nCzhRynPtsaXuNdTdZQyU7/8gOg7C00CPcz+KYO5IWn+
	bBouNB2iVrq2lI3yjbDrJ4Mj1Cr/0zZz8uKtOC4AxfYduH5k0wQGUGiHtFrCZv24rjsPY7
	RNolF2ITKJyBEjiF+oJXYBlGFeakqjkmWM356qJrl8bCLLpR5NX8aFOOOCN09N8S0FsbG5
	+mPS7xcGwAw8rxaA4QmkqhJkP9oUmQq3pnUJcPv5sr8//jhj32YrkD7f15BPSn/xJUmlen
	aGQGUDU4lOcapu4NFcVIvLwHqEu9/5A250b6OiwimsH/so/suZ6iEUZOaJGmhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791840329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAiScCw3xT8qTEUpGk6BjUljTycDujh4sIDNa9F0P6Y=;
	b=17yHSlhAgmgweZpYB2yF8SSxvq0aiaHhIdD0JuRpHX7jKQo8h/igxWvs4KjIw8Ym9+gFMu
	hLLYGAapiJUxyiAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <20261012212527.5sFqlGYu@linutronix.de>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>

On 2026-10-12 16:26:28 [-0400], Alan Stern wrote:
> On Mon, Oct 12, 2026 at 09:49:02PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-10-09 13:31:17 [+0200], Greg Kroah-Hartman wrote:
> > > > As far as I am aware, there aren't really any guarantees on the=20
> > > > context of a USB URB-completion callback.  The kerneldoc for struct=
 urb=20
> > > > in include/linux/usb.h says "The completion callback is made=20
> > > > in_interrupt()", but that is most definitely out of date.
> > >=20
> > > I don't think so, I think some platforms still have those callbacks in
> > > irq context, unless we changed to threaded irq handlers everywhere?  I
> > > could have missed that, but we should still write the callbacks to
> > > assume that and then we should be fine even if we aren't in irq conte=
xt,
> > > right?
> >=20
> > The HCD invokes the completion callback usually in IRQ context. I think
> > the VHCI is an exception here.
> > For the forced-threaded mode we disable BH before the IRQ handler is
> > invoked. I think even dummy_hcd invokes them from the timer if my memory
> > is right.
> >=20
> > > > Drivers shouldn't rely on any particular context guarantees.  Not e=
ven=20
> > > > whether local irqs are enabled/disabled.
> > >=20
> > > Agreed.
> >=20
> > I would suggest to make VHCI invoke the completion callback with BH
> > disabled. usbnet's tx_complete() does also defer_bh() which schedules a
> > BH worker via queue_work(). While this works without disabling BH it
> > leads to waking ksoftirqd and an additional context switch which we
> > could avoid by dealing with it directly.
>=20
> Today you fix VHCI, tomorrow some other virtual HCD will cause problems.

We don't have other virtual HCDs, do we?
The other driver is drivers/net/mctp/mctp-usb.c.
mctp_usb_out_complete() -> =E2=80=A6 -> mctp_usblib_tx_stats_update() does
get_cpu_ptr() for stats. But mctp_usb_in_complete() has=20
mctp_usblib_rx_complete() -> mctp_usblib_rx_stats_single_drop() and
mctp_usblib_rx() which do just this_cpu_ptr(). Plus the queue wakes &
netif_rx() which wake ksoftirqd.

That makes two drivers from a quick grep. But I guess it is just
networking for the per-CPU stats.

> Should we document any requirements that all HCDs will have to follow=20
> and that all completion handlers can rely on?

It used to complete in IRQ context. Then you added the possibility to
complete BH for those HCDs marked as such (except for the RH). I think
it was always reasonable to assume that it is either IRQ-context
(force-threaded or not for !HCD_BH) or BH (for HCD_BH). It makes hardly
a difference, BH is always off and networking uses to rely on it.
So yes, documenting would make sense.

Do you want to document it yourself and have me do the VHCI bits?

> Alan Stern

Sebastian
