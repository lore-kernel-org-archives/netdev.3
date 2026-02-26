Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADC30E0F2
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095838; cv=none; b=GzaYaviHMLthkRtbvZ0UXvk/kHe42oYxMnJwUav4m79ukTlXGLrnA2WoSgP2fsPvq3l4WC71PbHfKapa2ComVH/HSbaQcayYgd44QeX1hG0f0ughp56PhOZTCf2Ybs0spsUFcEOOs5KMnGps7lFd1Bl8NtC0tYuL5Gx6KPvGX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095838; c=relaxed/simple;
	bh=dYep3U4Zc5IVGubelE0EKQYVSOiGcukJc4hsbggek7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHMG+MinPcrnoPV+M3+gCxB0zkFoxdfK6qEg0lXUSfhA2VUHkIVl6yWHHN+Q5PNTPaEUmh1J8w5q0Oci0brqA6UYVAdf8MbU6jakfsWIiSv0GpZfN5X7wvnILg+juGLt20AdyRfcsQvvvbtyXDVxTDwYtR0yI9p6XllbJDAhN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y3K+MQ2v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5COcQiaY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y3K+MQ2v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5COcQiaY"
Date: Thu, 26 Feb 2026 09:50:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772095835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlwFFAUYmlwSm+mwJpPe5OwpT+QqMfVXVr1Yrv1Aw9w=;
	b=Y3K+MQ2vA4dG2JSz0LgiYAbdt5w1AZuedMbz2YsEi4DrktJIV5e3zqOMOtALXRHiQI9q9g
	Q50KpBKaMiMOT0p/9F296SDMmlosppfJ6E656v7SEHQx2WHWN90vQlfLX1q3qdwZ8wyXnt
	Yo5LeM6uB+A209fv7QjsuOAXTSuXTK1EWyeaKQSJC1uGYVh4vQYAuSqHKuBynvlWNNFaG8
	gF5d4JYwOSq4L8+bWvcKgRr1s4t+KGRej0V8CtsHuHvzEtNFQNynPDz2Ab8Ulx0TKRnuyq
	e1xW+DpJa6Bx4OagEqka9CKEUms0DsExnt2SqmlF3z8MkirGomD+1LzIAHD9Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772095835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlwFFAUYmlwSm+mwJpPe5OwpT+QqMfVXVr1Yrv1Aw9w=;
	b=5COcQiaYH499Fxg1T22ua3qVZCUhNanfzx07bxlZ+8sbtNImN/dfp2mRtn6VMlnUMq55xZ
	neRhR2Y2kcitcwAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, willemb@google.com
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260226085033.1g_feyIW@linutronix.de>
References: <20260220183858.N4ERjFW6@linutronix.de>
 <177193020629.3444651.13248671448207071630.git-patchwork-notify@kernel.org>
 <87jyvzvs9n.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyvzvs9n.fsf@jax.kurt.home>

On 2026-02-26 09:11:16 [+0100], Kurt Kanzenbach wrote:
> Hi maintainers,
> 
> thanks for applying the patch.
> 
> What's your preferred solution for igb? Can we do the time stamping from
> IRQ context now [1] or should we switch to BH workqueue [2]?

We have this quote from Jakub [a]:

| But FWIW I can't stop myself from restating that networking core is not
| supposed to be called by drivers in hard IRQ context in general.
| Especially when it comes to anything that may involve user sockets.

which I kind of agree in terms of "easy" maintenance. The kfree_skb()
in the error case does not hurt as of today so does the socket
interaction.

Based on Paolo's [b], we can have this fix and insist on !hardirq
processing?

[a] https://lore.kernel.org/all/20260220132932.1ed45656@kernel.org/
[b] https://lore.kernel.org/all/55b24261-45cb-41f1-857f-f29527a1ee8d@redhat.com

> Thanks,
> Kurt
> 
> [1] - https://lore.kernel.org/intel-wired-lan/20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de/
> [2] - https://lore.kernel.org/intel-wired-lan/20260211134436.1e623034@kernel.org/

Sebastian
