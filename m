Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606254A6CF6;
	Wed, 14 Oct 2026 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015449; cv=none; b=O4vjFIemEGDbqzybIERb8pXis7qX6EO8+/NH1wF8SHmwdRVAABNcQuRLNY40mR+i8rTtTB1YwusOaSljLlKLjVdccEClU6BVwsY5xAKexiVdiYG3qOEbYCcACZbcmf1JXoCbQIwcR4hk33fojSw/mtbAjkiZj9bm22TETxJJoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015449; c=relaxed/simple;
	bh=7iCkqsU4Ad7M8KWA124YeJwDPvtti4iHztzsXKUlQGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfZ1ZiwFBNKWYVvtWp09HxtLqsxtE1fkB2bnx6XHg2+deEHuyy3S45g6brzQ4Uk8idRSJhzwYnK3dcTwVQf8ycyzfCxH4vF9Pmj8MnSk6Vh8FLXN8Ic1V4ypfjiEjTDw8xqY/IwaUXnZENMA3kmzaWpmG/vE9mlYx7UTJ5R6gRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uu5GCBh+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+z8kiiBM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uu5GCBh+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+z8kiiBM"
Date: Thu, 15 Oct 2026 00:04:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792015445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbhZUdKqlUjyf4jQIZVOFYUKhQ/g3sxzg2YLeQTEr+s=;
	b=uu5GCBh+F2eJAZ6DatREDVi9wL9zlkFpvAgpCIB8aoQKxMSFiQyWcoJj4RNca6CUf/ViZ5
	+1qEmeWlQh6gDkW1w1N8mS3dAjRW729BWIqJ+jyLmNSh25J77/wT6Yojgp7IEpdyIapIeP
	Od49rE0ZXxkz5u8voPS/91mz/iVSdBqfSsp1UP4ju1mE5dmJrC25OEznZuYJ2fkMRLwjgC
	uFhx1RIbZZYwaLFYiORe9KVojMiTXkH7lUu5YkSIz/f+zJq1XJZWvScQbJhLJTJlfXxCW3
	Ks4KFOJvxb+ERHBF+Ajjd88WFvGKffeEoi6lM58MhiuTULuu3Thkm2nnQv0BOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792015445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbhZUdKqlUjyf4jQIZVOFYUKhQ/g3sxzg2YLeQTEr+s=;
	b=+z8kiiBMOE5gHHBox/v0UyxyrYrqkYlgHGiZ/3m2ZVQaXFiCUVWKxANkpgHc+J0XnKWAye
	LRh75uJRNMukF4Bg==
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
Message-ID: <20261014220403.R38Gf0pW@linutronix.de>
References: <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
 <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
 <20261014191141.GxlJhR1e@linutronix.de>
 <89da3b1f-60e5-4f18-9592-3d6d7175c437@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89da3b1f-60e5-4f18-9592-3d6d7175c437@rowland.harvard.edu>

On 2026-10-14 15:22:51 [-0400], Alan Stern wrote:
> > "local interrupts disabled" as is local_irq_disable()? If so, that is
> > not the case. If it completes in BH context (due to HCD_BH) then
> > interrupts remain enabled.
> 
> Yes, but we can call local_irq_disable() before invoking the completion 
> handler -- if we decide that would be a good thing to do.

Oh please don't. This will break PREEMPT_RT badly.

> Otherwise I would say that we don't guarantee anything.

Okay.

> > > Of course, in special cases you might know more about how a particular 
> > > HCD works.  But except for platform-specific settings, it's hard to be 
> > > certain that your driver will always be used with that one particular 
> > > HCD.
> > > 
> > > If this is okay with you, I can write a documentation patch.
> > 
> > Sure. The kernel doc for usb_hcd_giveback_urb() says BH or caller's
> > context. I think you need to clarify that part and once we have tha, we
> > can proceed with the drivers.
> 
> What do you think?  Should local interrupts always be disabled, or 
> should we offer no guarantee?

No guarantees in this regard, please. Disabling interrupts will break
PREEMPT_RT here.

> Completion handler routines will have to be conservative, so if we don't 
> guarantee anything then they will need to disable interrupts themselves 
> whenever they require it (for example, by using spin_lock_irqsave() 
> instead of spin_lock()).  The core could save them this extra effort, at 
> the cost of unnecessarily disabling interrupts sometimes.

The problem is spin_lock_irqsave() will not disable interrupts on
PREEMPT_RT while local_irq_save() will. For this reason I would prefer
to skip it.

> USB isn't a tremendously fast bus, so the overhead probably doesn't 
> matter much.  Which tradeoff do you prefer?

So if we don't guarantee that BH is disabled then I would say nothing is
guaranteed, anything is possible.

A little note: cdns and dwc3 do disable BH in their voluntary threaded
interrupt handler. The reason is that the networking driver expect this.
I know this is the gadget and not HCD side but sort of the same issue.
While BH is disabled for interrupt handler (and forced threaded handler)
it is not if requested explicitly.

This would mean that the completion handler of the networking driver
would have to do local_bh_disable() themself. I could live with this ;)

> Alan Stern

Sebastian
