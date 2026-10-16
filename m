Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F519B3CB
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145275; cv=none; b=E7mZtXKAdddF1TFLtvnuQoDW5HC0vMGocqhq+jUx/50JhX4F0j1Sj7DbYFVcOiwXfbZTfd9uXrAJEiIMh6eQAOrB8GUJMUeeaECYL20wnfoquk3P5TvYk90qujVA4BTmIANz/ooFgfxdeN4tQpVQ+ZXVLkhfzpxB4PR8KHLsZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145275; c=relaxed/simple;
	bh=Lw7ry8qE9AnNu+CE1/Kfh6G56DYqu4g9NYMjU+/cZxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAztqnF2O53yE50mxhNFzEtV1zDe/zvYFNiSGEZjeuMJY3fFYtLeqfCBa+bnJx/nhx0Q+UAxPKQFmOoXD/xLgqDp1xMashMbI6JvL1BrCvzyCrBlLTwsAQ38Mpk5pc374Npnypf+sffmd0NgQVYpzP6sKuKrj3Mdy2+jwpgT3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sksA7gnc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=thvPcgLM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sksA7gnc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="thvPcgLM"
Date: Fri, 16 Oct 2026 12:07:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792145270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gSIBi/Ddz2p3ZlUqjHRoWlV/9RS4bZP1oJWny8/slwY=;
	b=sksA7gncPFKUKVsBDMz5BuYA3zMooU1UtoXW8ytVtY3IJ+MsZ/9TIUJlX1zSelQulLvibP
	S3LiZKdBnRB2lfAAZso/w4NlPs9a9DE3Nv+baB+Ir2/CrkVyT56hdAIII8en0SnrCf4mBT
	KXWsqoMdWjOPwsnE0vKfo4swS5M0S0n/uq10Q5Rc8trsSupefuYomy4QgS+PSLWbAq1QFI
	CrgJF+U4+bbBT6lM8XrSQ+gzFmO45A/CLv6Er7y7oKAHwWtfFk+2GQ9Z24z6YHn3siZAEP
	UzvmHhbcWKmYSrvsRFAVoSYE3Jl/5ks1SnexOunXI9V5nUYrQAlUcqUQb8NGQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792145270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gSIBi/Ddz2p3ZlUqjHRoWlV/9RS4bZP1oJWny8/slwY=;
	b=thvPcgLMIiD7RuXxtufvHM7KBKXDFuDAZ6Z3Sb4vdsr/gago3wh2NXWlFtZsA2HXJCy0K+
	VPas2ba7uFlYnQBQ==
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
Subject: Re: [PATCH net-next v9 7/8] hsr: Move struct hsr_ethhdr to a global
 header
Message-ID: <20261016100749.52Kn_i9J@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-7-2d20a2a0f816@linutronix.de>
 <20261016093853.jugkxkcvzxsm2kgx@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016093853.jugkxkcvzxsm2kgx@DEN-DL-M70577.microsemi.net>

On 2026-10-16 11:38:53 [+0200], Daniel Machon wrote:
> > In the offloading case the network driver needs to inspect the HSR
> > header to find out if the encapsulated type is a PTP packet where it
> > needs suppress offloading of the packet.
> > 
> > Move the header so it can be included the driver.
> 
> nits:
> 
> s/needs suppress/needs to suppress/
> s/included the driver/included by the driver/
> 
> This is the header that drivers needs to poke into, to find out if they should
> steer the frame and add a header or not, right? Would it make sense to add a few
> helpers here?

This is correct. Could we talk about the helper once we have the first
driver using them so there is an idea how a helper could look like?

In icssg, for PRP I have just
	"eth_hdr(skb)->h_proto != htons(ETH_P_1588"

as a check among a handful driver internal checks to figure out if
offloading here applies (so no header, no sending on both ports).
For HSR I have this:

|                       /*
|                        * On HSR:
|                        * - all packets except HSR including PTP get a
|                        *   header added
|                        * - HSR including a PTP frame or PTP frames are not
|                        *   sent on both ports, everything else is.
|                        */
|                       is_P_1588 = skb->protocol == htons(ETH_P_1588);
|                       is_P_HSR = skb->protocol == htons(ETH_P_HSR);
|                       if (is_P_HSR) {
|                               struct hsr_ethhdr *hsr_hdr;
|
|                               hsr_hdr = (struct hsr_ethhdr *)skb_mac_header(skb);
|                               if (hsr_hdr->hsr_tag.encap_proto == htons(ETH_P_1588))
|                                       inner_is_P_1588 = true;
|                       }

so it could get this logic and have is_P_1588 + is_P_HSR as returned/
set arguments in the driver logic, that follows.

> /Daniel

Sebastian
