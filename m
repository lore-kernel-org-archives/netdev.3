Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1E37EFF2
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452598; cv=none; b=bnYJYbuIimxj2G06t44iANhXK5NF6bk5ch/1MSFgceueFEzJasWiPXr3GJdvVtVtUjMkmHsWv2GELDqqcdOgh/BBwdADM7SWrU2NjVKItjR7Pa0jmcBSOeb5NJrvb52saEG+LS3DJr5Y6pAh+bOW7sMUctmFtWuTycy+dv9NYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452598; c=relaxed/simple;
	bh=tmYRf7Bmh2hZcMDwzAKTNTMXWsybObh18JBQhRfW30M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/h5QYqMK5Vifi57j+0yn2WHvsSvAFava59lsoYMUty+eCg7SWKv+AHweGRnU/rffrJ9gNHTKXvvRIMYVydehlDE56Rfn2EjqPo/isRv7mmqCGvg5PCr2sAFg0Fx9uxlW0GKWTEuuY2vZSOX4gGm6grKoX3Gj14k2fQPmvc6+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zTInwWpr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4/wPnzbr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zTInwWpr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4/wPnzbr"
Date: Fri, 22 May 2026 14:23:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779452595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj6JxJTYAxkFXydOgqe3O9kkBNjL+RXAgK7UWwnuCJs=;
	b=zTInwWprlhBBHLiKjhsZqNaa2VohjaXBfwZa0TGKw/SqwupcmxSoFL71dKZwGi9qYcJUf5
	THhImyJFgLYUtt9Wwwv9CMSgCZDz6xhC9ApD2sNaBQHq1z5miUrLOhgUrnWmn3lDRu5cDb
	YNtV/coahVnV47DFaONLvbNeovYiwuHNMMXCrEE+xxHF3ebvbv1gB03N53opJlrBGZC9M/
	Qr2Nf0wY5exWTlzGGzek9257qShAN2UJ9PUUMgJp9Nn2IVqhUm2YV9CdWrD0gsP4e9V/Qm
	Iq/smVSRhHsF21o6q1C2UrD3Z7xf+EknAs2j02T1FQVfPGaHZaAfutHK4us+Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779452595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj6JxJTYAxkFXydOgqe3O9kkBNjL+RXAgK7UWwnuCJs=;
	b=4/wPnzbr+bjS2qV4cEkPrCST6u7SzmueT5tIHZOUNxIPY36snD6oe9rZnHx6SUOpOi22rr
	UR6jt5T2TRnBq/AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, Jayachandran <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v4] hsr: Allow to send a specific port and with
 HSR header
Message-ID: <20260522122314.4SY-dYPg@linutronix.de>
References: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
 <ag9NU2iGKLlSd6tz@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ag9NU2iGKLlSd6tz@thinkpad>

On 2026-05-21 20:22:11 [+0200], Felix Maurer wrote:
> Hi Sebastian,
Hi Felix,

> I unfortunately didn't get to properly reviewing your patch before
> leaving for vacation. But in general I like what you're proposing at the
> moment. The inline header feels like a bit of magic to me still, but
> it's probably necessary to have some amount of magic to make the
> different sending options possible. Also seems like it doesn't put too
> much burden on user space.

The inline header is the common ground I established with Willem.

> Skimming the patch, one thing came to my mind: maybe there is a simple
> way to make user space opt-in to the inline header handling, e.g.,
> something like a respect-hsr-inline-header flag at socket level(?) that
> only gets checked in the hsr code. Without such flag, the special
> parsing wouldn't happen at all, with the flag we still check for the
> inline magic value to support sending normal frames and special frames.
> But this is mostly an idea, probably not too well thought through yet.

We would have to invent this flag and then af_packet would have to use
it. In its current shape, we need to look at skb->protocol and is
restricted to the PTP case. This shouldn't cause too much overhead.

> But I have one real ask: can you add a simple selftest for this? No need
> to do any kind of real PTP, but just verify that we don't break any case
> of the matrix "add header/includes header" x "send normally/send on
> single port". Maybe just by tcpdump'ing on the other end of a veth?

Okay. Sounds reasonable.

> Thanks,
>    Felix

Sebastian
