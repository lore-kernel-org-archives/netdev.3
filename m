Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098738E133;
	Tue, 14 Apr 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156966; cv=none; b=cxIxTb5Xq8lzzUX80tL1SPhBNRl3KShwYcQUDb7r4L1TIF6BxcLDrRA/KMugdScJwVSXqfxAxJXR4/Hcv/N5lp+H88IFNYur9hcm0y5v42doUkTWd9Til/PKPZ2c70kJJcc7am3dYRMRHyxJOJAl6gPe4VgO6mM3BL2g8ubgxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156966; c=relaxed/simple;
	bh=ddsWFfIl/VETsteuvgn397chs9OXhkanqE9nCc4TKKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRy6R4H0yg1dBxGj0kq90w7zTP+3NPra1Y8X+IMfeAy/smQKCTHww8us3jnndn9hmM0/P/AqnVStponEXj6GBG+Rkn5u0h5an2Vgl2kooojND/Q8LTfafQeMDVJekw4jwA0Vfm4snvmIu9ZBGGky/O+adRYz5JXEbIZknS1ClpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9GGERux; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ymcbsrcR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9GGERux";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymcbsrcR"
Date: Tue, 14 Apr 2026 10:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776156958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z1QpA+qBGabRB5GEeoNNWm8Cfr0P4jmbI9PJZ/m6U8=;
	b=c9GGERuxMen8Y1k4DP9eE6sR2RLz06Y/ctnXUP/MNtAVD0UW0RbWZnQAPLROGmxG35RNEw
	eTXzARH6bUqYdK8HUgF4QPrR/0GY8CmKEYOGX5Ze3bZWlFzQcAGAqBwzz6lxyS9DJo0LpG
	joK7XhKZYu0H6AKoXcumkTeuGX50CYVzrLzOJmZyj3YnZJaeiKPK2Vm2XHQA7sttFN1fAk
	whMBUjH8x2xkaWih3TX6hjBZ1YITGM0r85S25jcHYX5LVPek1KcUYwulULKbWxY+/2/Qm1
	h0w5bqyqHvZ4rSg2NcP0AgVWx8q6aH0bHmd56E2GeDfgnmYYx/JQJRpx1zb0xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776156958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z1QpA+qBGabRB5GEeoNNWm8Cfr0P4jmbI9PJZ/m6U8=;
	b=ymcbsrcRFCWuxi+mfcZgoznfpFlPsjwPmGZQoVZrZrK3PRNqriGzY+ONcUhHj5NJojU/hX
	swfcqLN6nUEY37DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260414085556.SJSDwbpW@linutronix.de>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org>
 <20260413125744.TVKkZcEK@linutronix.de>
 <16fdeec9-9208-4c9b-b228-d6c6e045e116@nabladev.com>
 <20260413160336.GQCaw-1d@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413160336.GQCaw-1d@linutronix.de>

On 2026-04-13 18:03:38 [+0200], To Marek Vasut wrote:
> On 2026-04-13 17:31:34 [+0200], Marek Vasut wrote:
> > > I don't see why it needs to disable interrupts.
> > 
> > Because when the lock is held, the PAR code shouldn't be interrupted by an
> > interrupt, otherwise it would completely mess up the state of the KS8851
> > MAC. The spinlock does not protect only the IRQ handler, it protects also
> > ks8851_start_xmit_par() and ks8851_write_mac_addr() and
> > ks8851_read_mac_addr() and ks8851_net_open() and ks8851_net_stop() and other
> > sites which call ks8851_lock()/ks8851_unlock() which cannot be executed
> > concurrently, but where BHs can be enabled.
> 
> I need check this once brain is at full power again. But which
> interrupt? Your interrupt is threaded. So that should be okay.

I don't understand. There is no point in using spin_lock_irqsave() in
ks8851_lock_par(). You don't protect against interrupts because none of
the user actually run in an interrupt. As far as I can see, the
interrupt is threaded and the mdio phy link checks should come from the
workqueue.

What is wrong is that the ndo_start_xmit callback can be invoked from a
softirq and such you must disable BHs while acquiring a lock which can
be accessed from both contexts. Therefore spin_lock() is not sufficient,
it needs the _bh() and _irq() brings no additional value here.

Sebastian
