Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42D3009F2
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143683; cv=none; b=pGGwykkBO1tuk3/RGyB+3/THbnEOHeNeICsU4SJ5yuXSfbWj06km5MJ3ZPVoeCkhp47WWjbUg91lHEGD/TM8bYSqaDz4AMgleCVdSaAYCx5N3VFmIiaX0bFQUrllooKA4sx5BG0+D0Lpr0FcOGkKUH9G3i0uNtHwoynHzVf5dy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143683; c=relaxed/simple;
	bh=gJCiGoLLKOmJpmZ9OZW7ZdzxjAATVbpJAQVVgRHL6xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFIrgZdc0wcDzAMUxcoI7AYbQgh6BCLFhwiFd/IHo64l9DxjkRIUjmSml2Nz6eaXuLgWJ9o/gRHuAJbpK1yaPLBxmFlGwfdea7ew0kvWABcY07dZJD41JAiDbu0/DtqismA2tNS7LSFjlKYAvCw1XVz6yXPO+qa1wmgFDk76fmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3e4cKmj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7pidpLK6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3e4cKmj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7pidpLK6"
Date: Fri, 16 Oct 2026 11:41:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792143680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm26KGue4PPLs6eD1Ge0A1+Hag972Tgpim1O9AKYkhU=;
	b=E3e4cKmjvUzHTzsEQ0Vjou7YGZvsjy9QVWJyvTtZ4mWJ9gecOKJVu/yknUk+y23eAqk8qE
	qmbexMfzM7owDchetwHv0QzH/IzOaZNXE4xQHVayocL87bJZH8PR2J9L08uPQbuE3DG738
	IaSR1jjJD+UAFpn3MtDaei1MrliqGIatevIezu11ooiVkDdGoiIGXLRCzMJxDbI3JvsV7w
	oX419ysh8/pw3sL0WPyW5HnyDUvJE26+3bK50PuayuSo3Gz7HLqxDVwsFhBNAjN27fI56w
	nTwYRS6ux7tpvRHNPJd0S8qNI8TmZCRglLOdQQvkuQ28tPKHnyb89s/w/TWPYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792143680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm26KGue4PPLs6eD1Ge0A1+Hag972Tgpim1O9AKYkhU=;
	b=7pidpLK6Solet0vvJY0JOtguG7IhM4NSD3sY0USzUIEyEByGYKcL9dZrnmOIB5c+CcDMAy
	6TM31pMe7bgJ47BQ==
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
Subject: Re: [PATCH net-next v9 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20261016094118.Mq6pgtly@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
 <20261016090940.a2ztkv6p3wtysk57@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016090940.a2ztkv6p3wtysk57@DEN-DL-M70577.microsemi.net>

On 2026-10-16 11:09:40 [+0200], Daniel Machon wrote:
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 7734a521a96c2..5862c05f52110 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -342,33 +341,40 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
> >  		/* set the lane id properly */
> >  		hsr_set_path_id(frame, hsr_ethhdr, port);
> >  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
> > -	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> > -		return skb_clone(frame->skb_std, GFP_ATOMIC);
> >  	}
> >  
> > -	/* Create the new skb with enough headroom to fit the HSR tag */
> > -	skb = __pskb_copy(frame->skb_std,
> > -			  skb_headroom(frame->skb_std) + HSR_HLEN, GFP_ATOMIC);
> > +	skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> >  	if (!skb)
> >  		return NULL;
> > -	skb_reset_mac_header(skb);
> >  
> > -	if (skb->ip_summed == CHECKSUM_PARTIAL)
> > -		skb->csum_start += HSR_HLEN;
> > +	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
> > +		return skb;
> > +
> > +	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
> > +	if (skb_cow_head(skb, HSR_HLEN))
> > +		goto err;
> >  
> >  	movelen = ETH_HLEN;
> >  	if (frame->is_vlan)
> >  		movelen += VLAN_HLEN;
> >  
> > -	src = skb_mac_header(skb);
> > -	dst = skb_push(skb, HSR_HLEN);
> > -	memmove(dst, src, movelen);
> > +	/* The entire header area needs to be linear */
> > +	if (!pskb_may_pull(skb, movelen))
> > +		goto err;
> > +
> > +	skb_push(skb, HSR_HLEN);
> > +	skb_postpush_data_move(skb, HSR_HLEN, movelen);
> > +	skb_set_network_header(skb, HSR_HLEN + movelen);
> >  	skb_reset_mac_header(skb);
> > +	skb_reset_mac_len(skb);
> 
> It took me some time to realize why skb_reset_mac_header() and the
> csum_start adjustment were removed, and why skb_cow_head(),
> skb_set_network_header() and skb_reset_mac_len() were added. Could the
> commit message say why? Or maybe a comment.

If this is important, I could add to the patch description. The removed
skb_reset_mac_header() should be obvious.
The csum_start() removal and so on was mostly sashiko complaining about
one thing at at time and memove() got replaced with
skb_postpush_data_move() in the last iteration which I just learned
about myself ;) That looks like a nice clean up.

> /Daniel

Sebastian
