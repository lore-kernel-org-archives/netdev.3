Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6C3C8732;
	Mon, 12 Oct 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834548; cv=none; b=fmCRu0F/lyn7MtWpPiCxogasC3Pgo4HjSK2kOe391zCxmpVPKJck0IbnffJaUoII0Gu+IBN8hURfiHjE7/HK7wHFlWUP71nYwFoBlWCGZ1GVCf+vNRs0KZpurEhhYck9Rxkj2kDNGiJUdMZZ5FFcQyWnXsn1xLOX4wMkGf3PITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834548; c=relaxed/simple;
	bh=kHCl1KPcs4JQ2lBe65lP91LIfLvSSdqz1yDPqOeS0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFW5uHRH1YMs05v6ipgwu2YOQ3TfynTVh+g5+fLgYJNTzQOzNNmGcWXBjx/WiXGSt0Mo4TM/UErpMGxe8zkPjVsn0/joy9QET++Kok2ISWKqwRErUkzodsT/37SOsvtBz1mTOJLJuanNFU53UUGkfdV/pbHJx85WTcAgovWoav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaM+Y5hR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mfcIhzl6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaM+Y5hR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mfcIhzl6"
Date: Mon, 12 Oct 2026 21:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791834544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uv9gnh2e/1G7nlYzg1SvfKojobbnrAlhAiOC70Px+YM=;
	b=IaM+Y5hRxY8aCbq+XhWRYSEr4DrcUfNfVC024vDvpymLBsJlLPi5gmaVwWNBeSvSZXUJoa
	uwQ5QFP/bSNs6N/HCSUhdMKGF63vVkz8vJIfgvzBebEdK6McjHcKSBcbcqhgy7i6eiUnyr
	9OwVDKrPB7r357j8/hTrZe5NAz0QcNrEXZvU/QJDycw6EaXI40wPruh9d+hXMpG+ovGKtJ
	H4jwIzqSd4PqC+pw7wWl/ewVEFEkYPMWCKdlvt+jKDmPsjU8DlyNh6cFzYeV9FXhkh1bxZ
	mfUFluKA+L9hsEnSKXJHhNUD9qPzfPVFV7YAiU76W/tXzVt4N7M4DS+RefJ2QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791834544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uv9gnh2e/1G7nlYzg1SvfKojobbnrAlhAiOC70Px+YM=;
	b=mfcIhzl6EBwnnPqeZZJ4+MftIUKGV+r07W+lgz31kbx/Jo9KpsXJDCxpMMeBSzDWlamXq/
	6eRi0xpxBHBRuvCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <20261012194902.aEq58Q6b@linutronix.de>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026100910-petition-embattled-94cb@gregkh>

On 2026-10-09 13:31:17 [+0200], Greg Kroah-Hartman wrote:
> > As far as I am aware, there aren't really any guarantees on the 
> > context of a USB URB-completion callback.  The kerneldoc for struct urb 
> > in include/linux/usb.h says "The completion callback is made 
> > in_interrupt()", but that is most definitely out of date.
> 
> I don't think so, I think some platforms still have those callbacks in
> irq context, unless we changed to threaded irq handlers everywhere?  I
> could have missed that, but we should still write the callbacks to
> assume that and then we should be fine even if we aren't in irq context,
> right?

The HCD invokes the completion callback usually in IRQ context. I think
the VHCI is an exception here.
For the forced-threaded mode we disable BH before the IRQ handler is
invoked. I think even dummy_hcd invokes them from the timer if my memory
is right.

> > Drivers shouldn't rely on any particular context guarantees.  Not even 
> > whether local irqs are enabled/disabled.
> 
> Agreed.

I would suggest to make VHCI invoke the completion callback with BH
disabled. usbnet's tx_complete() does also defer_bh() which schedules a
BH worker via queue_work(). While this works without disabling BH it
leads to waking ksoftirqd and an additional context switch which we
could avoid by dealing with it directly.

> thanks,
> 
> greg k-h

Sebastian
