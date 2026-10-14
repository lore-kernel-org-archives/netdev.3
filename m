Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8443F4BB;
	Wed, 14 Oct 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005107; cv=none; b=tv7xHmEvcJjA/mlAhi7xsgbmM5AjV9q4R8RodvhUr9UFDPU5a/py830YRvkNElNIguH0wKoAyMNKeO5JZOBfgEitBcfYGMpdv+SC44Nsv4tw9MzPZxIqSKUB/InGY6+FOeHYIngt9vSsh70yYEbWVVaqMv7VfrSOaSahFlEKDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005107; c=relaxed/simple;
	bh=Oe/sbg8uwHAjPb4YLfnECfFwUY87hHT1lXsjkgwXos4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlEcWLKYMTA5f9IOp04Wx3x/kdw4HOvvbSJkeLJ8SFUVoRghP+hcZ+/PATbIsw1YoSuFj4C1e9lv4C2dQxaB/zoVdGMBfqCEeTcAa/TJhgJRFJktSoUNjfvWjDTQYb/zR4gtguv94wDRmIcXtzAyiOKzrYmryrmwX+NPmgTZ/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iq07hdar; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PYnggFmR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iq07hdar";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PYnggFmR"
Date: Wed, 14 Oct 2026 21:11:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792005103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lgvme0OT2A0ZVkdd7ArF0xH/WUsFMUOgkkS6/tlJyDg=;
	b=Iq07hdaru+qQRF94+1hMxme4fw6RUyDl7SKiXRGibz+3HjWqgEBov68EiEtuqTR0JPGsnz
	ZlUKOvJLEKO4CClPSym4UmBdqE6GP4rOojjoQU0yDzNM4o9yD9QBSR3IqGr1NXehU0OztT
	NqAxhnEs9cUG6DnYhscEjV1+mQKR+E2GTfeJ5DrWcVHvB8sorIFJJ8WSXtsPDyJQaSq9rq
	1tdWP/gIBknyF97sx/ZN6o0ZVz+yQujZZOCFCtdhupKN4g6xyTDNFjoiwEXoHmbBqphJhP
	gTCAZu4jwjQSRh5eNwWOl+GwuZQCo7eoIXJJVZz0+Lv8p6mVb2R2I3f1q7Gotw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792005103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lgvme0OT2A0ZVkdd7ArF0xH/WUsFMUOgkkS6/tlJyDg=;
	b=PYnggFmRS+DRLzr0OF5oguLZ/kxGOBQuPFBKZ9FiiDkDstT9zVkBSnT1d7ijf2VfQYVG39
	JWGKkdk4yJ5/zFCw==
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
Message-ID: <20261014191141.GxlJhR1e@linutronix.de>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
 <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>

On 2026-10-12 22:09:25 [-0400], Alan Stern wrote:
> > > Today you fix VHCI, tomorrow some other virtual HCD will cause problems.
> > 
> > We don't have other virtual HCDs, do we?
> 
> Well, we've got dummy-hcd.  And just recently there was an RFC post with 
> a virtio USB HCD implementation.  It wouldn't be surprising to encounter 
> other ones.

dummy-hcd is timer driven (so BH). Without looking at virtio I would
expect it to be interrupt driven.

> Also, don't forget, URBs can complete in several different ways.  
> There's normal completion, explicit unlinking, unlinking because the 
> device was unplugged, unlinking because the device or HC is going into 
> suspend, and so on.  And there's a difference between URBs sent to 
> root hubs as opposed to devices actually on the bus.  Not to mention 
> that in some cases completions may occur synchronously with submission 
> or unlinking, even though they usually are asynchronous.

True.

> > Do you want to document it yourself and have me do the VHCI bits?
> 
> At the moment, the only thing I think we can actually guarantee is that 
> completion handlers will be called with local interrupts disabled.  No 
> commitments about process context vs. interrupt context vs. BH context 
> or anything else.

"local interrupts disabled" as is local_irq_disable()? If so, that is
not the case. If it completes in BH context (due to HCD_BH) then
interrupts remain enabled.

> Of course, in special cases you might know more about how a particular 
> HCD works.  But except for platform-specific settings, it's hard to be 
> certain that your driver will always be used with that one particular 
> HCD.
> 
> If this is okay with you, I can write a documentation patch.

Sure. The kernel doc for usb_hcd_giveback_urb() says BH or caller's
context. I think you need to clarify that part and once we have tha, we
can proceed with the drivers.

Thank you.

> Alan Stern

Sebastian
