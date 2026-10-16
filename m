Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E334E761
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144146; cv=none; b=tXnFHEz/78MFBa1LePeIg1sYqntes2tebw4+e3/G4LUIPAnGINoLU360Wid1LNzYqv7Q/WQSAtJ2G/dx1XqX7/kymoClAUJsrFtliF1P8B+bTAZYKVBzA9V6+qEq9VPCvajtOgL1rYh72qpB1v+OvJnnYB4E+ngar1FCYwBFtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144146; c=relaxed/simple;
	bh=0p8mStJxUijdNxGeSNjB7RJI1CkTPQ5aUvj8ueBuyaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwGbICcEycqdLTz7pk/mr8cs1riAd65YzvPrGUQgO3BbN70v6E1UJfIJzBdcNV5oREoxJpsZLXaYJh4x4TdPxUzgbJs4ptBB6bACzDoe1BSCmacJNGrTV7JocP8s++OwZfxflTA3vNbg8ZJf6uHcNUe5QSdJImzLBO+JraY2ENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OcTIbgV9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jy6Je/z6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OcTIbgV9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jy6Je/z6"
Date: Fri, 16 Oct 2026 11:48:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792144141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RXr79HYsNu4MhzyqTZJMWqhjRKSduRhOwijYdXm+wQ=;
	b=OcTIbgV95kZTPRg/xur7Si2iUhDlLn9vP2vYSbQa7assaUvl6xJHTkKYDiVv0HDzfWbWii
	WQbuhvZ6csurK7KalVecBcGHmfF87GBiaJ6jKtygFaMbKBEQNOZIhTmZxl2G2Mu03taYQW
	K0GYNvUxZbp7gK2ARzazSxG1fMaGLuiT+e5EsDeDypXeyo0jhPw91Fh7VHc8dyDMEj89YZ
	ScehKdFM4GLybt1T+UxIsPmZdgk36C+3Dw7EshxZNk9BGl//Gky0M2UlYW6yAl/i0sC9dQ
	qvUAPnsEZA/dmdFKIqjJrAjgJ+35Hq8P3N9/lpY2fIqutBMqALucQf8C7bpRzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792144141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RXr79HYsNu4MhzyqTZJMWqhjRKSduRhOwijYdXm+wQ=;
	b=jy6Je/z6erlTbZRp8D42id/o/QXPBYotvI8vj9x5ULbqs4wUWdthajVny0a+zOIMo56tgW
	bB86QmS+Cuz2C6AQ==
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
Subject: Re: [PATCH net-next v9 3/8] hsr: Add a magic header for sending PTP
 packets
Message-ID: <20261016094859.SNXzYBmu@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-3-2d20a2a0f816@linutronix.de>
 <20261016091512.tqrunkdgiorm4jo3@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016091512.tqrunkdgiorm4jo3@DEN-DL-M70577.microsemi.net>

On 2026-10-16 11:15:12 [+0200], Daniel Machon wrote:
> > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > index 6d96bc4a12446..c5ea7ef0209db 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -223,24 +223,66 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
> >  
> >  static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> >  {
> > +	enum hsr_port_type tx_port = HSR_PT_NONE;
> >  	struct hsr_priv *hsr = netdev_priv(dev);
> >  	struct hsr_port *master;
> > +	bool has_header = false;
> >  
> >  	rcu_read_lock();
> >  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> > -	if (master) {
> > -		skb->dev = master->dev;
> > -		skb_reset_mac_header(skb);
> > -		skb_reset_mac_len(skb);
> > -		spin_lock_bh(&hsr->seqnr_lock);
> > -		hsr_forward_skb(skb, master);
> > -		spin_unlock_bh(&hsr->seqnr_lock);
> > -	} else {
> > -		dev_core_stats_tx_dropped_inc(dev);
> > -		dev_kfree_skb_any(skb);
> > +	if (!master)
> > +		goto drop;
> > +
> > +	skb->dev = master->dev;
> > +	if (skb->protocol == htons(ETH_P_1588)) {
> 
> Seems like this is also accepted for PRP - should it?

Nothing bad happens if one uses this. The timestamps will be missing so
worst thing would be a complaint. If the packet is dropped the same
complain might follow. It doesn't make sense to use.

> > +		struct hsr_inline_header *hsr_opt;
> > +		struct ethhdr *eth_hdr;
> > +		unsigned int hdr_len;
> > +
> > +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> > +
> > +		/* need to access the magic header */
> > +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> > +			goto drop;
> > +
> > +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> > +		if (hsr_opt->magic != htonl(HSR_INLINE_HDR))
> > +			goto drop;
> > +
> > +		has_header = hsr_opt->hsr_hdr;
> > +		tx_port = hsr_opt->tx_port;
> > +		if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> > +			goto drop;
> > +
> > +		if (has_header)
> > +			hdr_len = ETH_HLEN + HSR_HLEN;
> > +		else
> > +			hdr_len = ETH_HLEN;
> 
> Nit: Maybe hdr_len = ETH_HLEN during declaration, hdr_len += HSR_HLEN reads a
> bit simpler.

Okay.
 
> /Daniel

Sebastian
