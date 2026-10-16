Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39285424646
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144622; cv=none; b=BTA0+KYlW1lHZs+lsskJtF9bCM9+KTVxgbeHLXIN+39ynmR1dqtqd6ESAuTlY/Qkylv2VQCFqWrTChClX4kj+vTYKYFj1MqGpdzDjn5IXicjTjzNhsjEFo2vTAzyCbg/xajWvjGSlaNEZHHQtaRaVmHre+r5dvw/YIvycR7v4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144622; c=relaxed/simple;
	bh=FdUe6Cg7Sh25aWq/EVfkWuxfidG0UCXxzVULIpnQ2dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLg8c1b4IcSOzou3kpRHIsjDKGenP25iX7McQs3CEx3NQ43Rp+zwZk5wW5/rlnodtbuhOvIRbUbFJUnBCThm3uy0jIAP4quIl6O3C01OhH3mzdaYS31hTm8/isn2Qf7CG277gdwaI8f7gBHdSDrEMAfA34GXT3tgt+Rq8WclpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ptZayXs1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8SWm7g/P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ptZayXs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8SWm7g/P"
Date: Fri, 16 Oct 2026 11:56:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792144618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCEynf4G/vqIko3KGGHtnSNDmhQUwVyX9cLOjdNynbs=;
	b=ptZayXs1jd9/N5+E6w5e6RBYcORatod9T/ZHf+oLCQiQ5HNhPvQUh5DtqqByPe88qI9eG1
	f1e860ksmQkj4cS44cP3tGgmnVg+GNwCLOFaLo02Z9Vm9D3rIr7s6pTKqZvd0MCFGlQD2i
	gvbAT1T6rQigWK02LmX4xwvp9ApZPT3tT4DP66DG2L7DAwMXcuprm3rpoyiK03JDTymb1i
	B0PIYUgON4/r9Bj1Gf48AZfJdN7h6Zn7zXNVQ1sOu6QV5/QGUIyJBH5pOyPtdpCHXkpZg5
	sb98nE+PS0IUQQVEs1CYhhEC2g8NYaSHVKjsLCtIqcapx3MePCx2TDldzc8Xmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792144618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCEynf4G/vqIko3KGGHtnSNDmhQUwVyX9cLOjdNynbs=;
	b=8SWm7g/PjYiWr/KZloJgWOU7VIpNycOHG3VOLR6yguydfcVSQpjpKtBigV+U/jAEOglgOK
	K2ehDKJwGK+PuvDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 6/8] hsr: Assign a socket for cloned skbs
Message-ID: <20261016095657.qU227Kr_@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-6-2d20a2a0f816@linutronix.de>
 <20261016093444.dkdhdmuvo4fg2mjt@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016093444.dkdhdmuvo4fg2mjt@DEN-DL-M70577.microsemi.net>

On 2026-10-16 11:34:44 [+0200], Daniel Machon wrote:
> > The cloned skb does not have a socket information recorded of
> > the original skb. The original skb is never submitted. This means the
> > requested timestamp information gets lost.
> > 
> > This does not consider PRP part of the stack. The specification says
> > that PTP-PRP packets do not have the RCT therefore these packages can be
> > sent directly from userland skipping the stack.
> > 
> > Assign the socket of the original skb to the clone so the timestamp is
> > forwarded to the user.
> 
> The commit description seems right, but is maybe a little vague. Could go a
> little more into detail about the effect: skb_clone() clears skb->sk, and
> skb_tstamp_tx() drops the timestamp when there is no socket, so without this
> ptp4l never gets its TX timestamp.
> 
> nits:
> 
> s/a socket information/the socket/
> s/these packages/these packets/

Okay, will do.

Sebastian
