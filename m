Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1D4AEBD9
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820582; cv=none; b=IEDHZmxhWEtXDjZr7To4BVrxnZ83kYuBBj9agtRhgt9z4FCLPY4mn2D9cToj+4UPEu6TETis4S82aKw+x134MxX/CiAHYcVxmz07mkLRF3mlv5QWflvZwx4q6xlNGSzSZ2kSVkUX7zgc24Z8B0J0RLWeVH1tCQVuhLaKsR/jgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820582; c=relaxed/simple;
	bh=Flm9Md3ok4OHiB3RcmhuAMTh2Z27yQSUstu0/3y3NuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9VwYQc97JWjs93kcsls9gCwXzuSCy/YpoInQzaGOiXiVyiHv5ALfOjRA9JVDlEpUlPptxuuslvwQFKtgYC7DSxi4wPxoyr6TGJnZRZ9l3Pb02ggFoElmd6E3B6JGknjnXpbL2CprVByzSC7/xA/iYUySLSYIBTXXt2wd6Ot1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDerUD9c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4Bzlauk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDerUD9c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4Bzlauk"
Date: Mon, 12 Oct 2026 17:56:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791820578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TDo5Ix5B1oJWnH8uZQ+d+WTZcUSvpYCe/dkS/9hJac=;
	b=FDerUD9cpMBuJu6/dt6RPCgRkXNIMG07iOF2gh8bNy9zUoqLc/C/8Y5vGJVOEHpP/U2khE
	c8KX+Kq1C/gPuCmwM4yl84gp7OMMgTep5+zEt775BRKsZXevt0tXuNVCFM3cUCRCc4O/bv
	1imufT+ALeHhSCOinSgIvG+5bcxXBZNoQmgiQrz19VpZbbmlV+W8uOjJnR6YIpt6NxM2PF
	yCrvmthLOL6Z1rSJ8qRLUQJlplRF4/tz4RNwsjQeQPlk/7y2gfZIkW5HVwTtGhbrYOi54a
	LRq3qxRONi4pzMnk3VspUx8bUzOnx+/ltrQ/AEZ51y0SZs4xsY7DDCgp7KCQkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791820578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TDo5Ix5B1oJWnH8uZQ+d+WTZcUSvpYCe/dkS/9hJac=;
	b=l4BzlaukDvnHbVN100X2yJOwbCNnvbV1725ur1OllrcNUyo3VyaZT66mn5MmWAywr9Ls6c
	6qNzHUNv4LTa36AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, edumazet@google.com, fmaurer@redhat.com,
	kuba@kernel.org, neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v8 8/8] selftests: hsr: Add test for the inline
 PTP header on HSR
Message-ID: <20261012155616.4XXTteGo@linutronix.de>
References: <20261002-hsr_ptp-v8-8-60dabc07e554@linutronix.de>
 <179129708214.434549.3458194670714306366@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179129708214.434549.3458194670714306366@kernel.org>

On 2026-10-06 14:31:22 [+0000], netdev-bot+sashiko@kernel.org wrote:
> > +	if (memcmp(hsr_hdr->dst, p2p_dst_mac, MAC_LEN))
> > +		goto again;
> > +
> > +	if (hsr_hdr->type != htons(ETH_P_HSR)) {
> > +		printf("Error: Unexpected ether type: 0x%x\n", ntohs(hsr_hdr->type));
> > +		return -1;
> > +	}
> > +
> > +	if (hsr_hdr->encap_type != htons(ETH_P_1588)) {
> > +		printf("Error: Unexpected encapsulated type: 0x%x\n",
> > +		       htons(hsr_hdr->encap_type));
> > +		return -1;
> > +	}
> > +
> > +	if (cnt < sizeof(struct hsr_hdr) + sample_len) {
> > +		printf("Error: Packet %d is too small for data check\n", cnt);
> > +		return -1;
> > +	}
> > +
> > +	if (!memcmp(&buf[sizeof(struct hsr_hdr)], sample, sample_len))
> > +		return 1;
> 
> [Severity: Low]
> Do the "PortA, hsr-header" and "PortB, hsr-header" cases check that the
> kernel keeps the HSR header supplied by the caller?
> 
> pkt_send() fills the foreign header with values that would identify it:
> 
> 	hdr->hsr_hdr.src[3] ^= 0x21;
> 	...
> 	hdr->hsr_hdr.sequence_nr = htons(hsr_seq++);
> 	...
> 	pathid_size |= (port - 1) << 12;
> 
> raw_recv() only checks dst, type, encap_type and the payload. It never
> compares src, sequence_nr or pathid_and_LSDU_size with the values that
> were sent.

It does not check the HSR header details, true. It expects a reasonable
HSR header followed by the payload. The payload is checked but it is not
modified during the individual transfers. It is however checked that the
packet arrives only on one of the two ports and the "inline header" must
not exist. That should be enough.

> On the kernel side, you can only see the foreign header handling on the
> wire through these two paths in net/hsr/hsr_forward.c:
> 
> hsr_xmit() {
> 	if (frame->port_rcv->type == HSR_PT_MASTER && !frame->has_foreign_header) {
> 		hsr_addr_subst_dest(frame->node_src, skb, port);
> 		...
> 		ether_addr_copy(eth_hdr(skb)->h_source, port->dev->dev_addr);
> 	}
> 	...
> }
> 
> hsr_forward_do() {
> 	...
> 		if (frame->has_foreign_header && frame->skb_std) {
> 			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> 	...
> }
> 
> Suppose the !frame->has_foreign_header check in hsr_xmit() were dropped.
> The source MAC would then be rewritten to the slave's address, and
> hsr_addr_subst_dest() returns early for the multicast 01:80:c2:00:00:0e
> destination. Would every check in raw_recv() still pass in that case?
> 
> Could raw_recv() also compare the source MAC, sequence_nr and path id
> against the values pkt_send() used for the hsr-header cases?

That could be added. But a if you remove the "has_foreign_header" check
then we should end up with two HSR header at which point we don't have
the expected payload after the HSR header.

> Also, the file header comment says the interface needs to "accept a
> foreign HSR header and prepend its own header". Is that accurate?
> hsr_forward_do() seems to keep the supplied header ("PTP TX packets may
> already have a HSR header which needs to be preserved") and does not
> prepend a new one.

It is accurate. The interface either uses the "foreign HSR header" _or_
"prepend its own header". Both things are checked.

Sebastian
