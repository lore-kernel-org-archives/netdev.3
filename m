Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD33D300E
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749049; cv=none; b=FkJsiVktOFZF3S4Ky7xt0EspwKK9rixCfpVSk7KiOwaEZ4VwGEwgzK5+QcePRenIIAF6GgjAnw7DOCdUvkBD7/3OPVHE8Ewhhz8/2ejyQzlnQI4IYmQTzfrGBgUw6IQMLgAZIouBtHDF8MVFGHcRUvHzi6WcJGNdw3UshJfF1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749049; c=relaxed/simple;
	bh=NeJ//uueV251Gzxqgu9MjWRJnDnl1fN24s5ZL2pPQQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgygTHbGCHhtxFcabYImfEhql6EakgWZKg0UMIFL3L3V5IeK49bke0qsDhZPtgBgVPXZ4A9+CiZenBoB+z2Nk2sT6kf4LQrqgRBrc4UHScyPQvyRbzzQndBRQrMsQff3W4pJ7Pir0rCbn52jvJvVVqdw4n2M458Knuh0iqK1wV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMQ/vf8h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IHeYyYNT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMQ/vf8h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IHeYyYNT"
Date: Fri, 18 Sep 2026 18:30:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789749044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwTxMQYTMmq3jxVCerteLcIsqOAQQcm34no4lSszO8Q=;
	b=sMQ/vf8hCJHVwYpakNnsyQxf6hrPCFTGWF3TwUqmnORU6rh+ZKI3KTyKHAKccYUF83IBnT
	b0I+5LjTb9MQcJfnP3xP58sq7HDpeMtd/cwJEkx4m06oQi59xokHUbo8lR4DCOmuzT1pkn
	JQlPECFLXHAgysZHj2PnbBoIxjS0oLe1SUmFGLLaoJujywOqsNn5YwbQuG+1Q+YmoEWVLw
	sLCJfyrCDBts6I6yuwxqMdrXoAMz0Ldl/fmfZsXgN0EjJoSfGEl+rmvGlk/5mF2Tsbllv1
	Kh3Jdd19IA59/1THu8i/8+FPvQMirvA17683P28OuN2ADWe8sTJ1C4O9y9UmIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789749044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwTxMQYTMmq3jxVCerteLcIsqOAQQcm34no4lSszO8Q=;
	b=IHeYyYNTFKkIQ7rNmvj+3aS+i+Krocf3zvOTWhGYJvlADKWD4Ym6KhUogtmbtUFFIPHYsc
	usw7OGV9Jz94njAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v5 3/8] hsr: Add a magic header for sending PTP
 packets
Message-ID: <20260918163043.nBGatWbi@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
 <20260527-hsr_ptp-v5-3-158a7633eac0@linutronix.de>
 <willemdebruijn.kernel.28f56d129e0b1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.28f56d129e0b1@gmail.com>

On 2026-05-29 15:58:28 [-0400], Willem de Bruijn wrote:
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -223,24 +223,61 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
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
> > +		struct hsr_inline_header *hsr_opt;
> > +		unsigned int hdr_len;
> > +
> > +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> > +
> > +		/* need to access the magic header */
> > +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> > +			goto drop;
> > +
> > +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> > +		if (hsr_opt->magic == htonl(HSR_INLINE_HDR)) {
> > +			struct ethhdr *eth_hdr;
> > +
> > +			has_header = hsr_opt->hsr_hdr;
> > +			tx_port = hsr_opt->tx_port;
> > +			if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> > +				goto drop;
> > +
> > +			eth_hdr = skb_pull(skb, sizeof(struct hsr_inline_header));
> > +			if (has_header)
> > +				hdr_len = ETH_HLEN + HSR_HLEN;
> > +			else
> > +				hdr_len = ETH_HLEN;
> > +			skb_set_network_header(skb, hdr_len);
> > +			/* Ensure the header can be accessed */
> > +			if (!pskb_may_pull(skb, hdr_len))
> > +				goto drop;
> > +			skb->protocol = eth_hdr->h_proto;
> > +		}
> 
> Should the packet be dropped otherwise?

We could make the inline header mandatory. Before this change sending
would not work anyway so this wouldn't break anything.
On the HSR side it mandatory and on PRP the stack isn't used here.
Nothing broke after testing. Let me drop the packet if the header is
missing.

Thank you Willem.

> >  	}

Sebastian
