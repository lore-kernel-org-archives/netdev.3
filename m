Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1078376A0A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810803; cv=none; b=nQZoTj0H/11V0Jdv4Xzmdw3BVcqJIAlb205/33hu5OhddPh2RIPfsr8sT5P47PgXXKfZrVIx0pGtrDWjumGapbAOtf5wOlP1S+n+Z7XDXb1Yj3dMQUhI6296iNlMT7o8hKDRfKwJDQYHQZbBileX29uo8vyQ3xO7urtJpj+WkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810803; c=relaxed/simple;
	bh=16Vdr3njBpayvPvHY+v2H8p658ISH4Sv+E1Rh3pF3zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnZMQw8aHUC9UoAPGlKJSlQWSZSg3WU/BHiDm4ZoLAJzqiwrGlrog5ptZ3kdHdrOkdubrLvH1Q5XHKQuFYJrWxEDFNAdPyixbs4ZeVc5idI0LWaDewvIpkf43UE1WYK9bhGXfyK5DSu2IKhzlX4awmfE93CV/t76FoK863sQWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3v2cHvq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fH63h63Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3v2cHvq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fH63h63Z"
Date: Mon, 12 Oct 2026 15:13:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791810798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IMT8lAi0GIIK1m4j6o5TAjkT3sLD2BkttvOXdoak+s=;
	b=P3v2cHvqg5VFyVl4FgVyTwLT6jbIW+O7v2KTHGF0tHVoRU6MOniNv78+3CrN7ka1EL6N3M
	ek1NdBfH+RFYFLzfm4LSmZ9SM0zXiVeY1QbkJzws1RJpigBblzr5w8BojcDX5LJax7L9VE
	oH2rkwRgw3r4Hi07yXT278I7e08htp8AouVKKDmurUik4cad3zdZGMKErLmGmWSZJOC3Ps
	dKTG767tw2ak5GAAhKProfKDuIvCYlWWHsAEi4+vpJREvcwu08nbTAflWNR8LgzFaapPwx
	Y0/clLB8yxLdm8R53RoqOTZFeYAF21JPjtmbBSRCIe3zEbqGJTDRtxIWHMZXlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791810798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IMT8lAi0GIIK1m4j6o5TAjkT3sLD2BkttvOXdoak+s=;
	b=fH63h63ZS/B+RxF+ORw2iOj6J5BPNfSVPqkk8p06+qid0tQE7f8dcH272tktl14eREp2sF
	5UcC7LGCbuO/1tBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, edumazet@google.com, fmaurer@redhat.com,
	kuba@kernel.org, neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v8 1/8] hsr: Add header_ops::parse_protocol
Message-ID: <20261012131317.UjrdcJ0I@linutronix.de>
References: <20261002-hsr_ptp-v8-1-60dabc07e554@linutronix.de>
 <179129707240.434549.8562830732842344341@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179129707240.434549.8562830732842344341@kernel.org>

On 2026-10-06 14:31:12 [+0000], netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> This isn't a bug, but could the commit message also say why this is
> needed?
> 
> The description is correct. In net/packet/af_packet.c,
> packet_parse_headers() does:
> 
>     if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
>         sock->type == SOCK_RAW)
>         skb->protocol = dev_parse_header_protocol(skb);
> 
>     skb_probe_transport_header(skb);
> 
> As far as I can tell, the reason for the change is the later patch in
> this series, "hsr: Add a magic header for sending PTP packets". That
> patch adds this check in hsr_dev_xmit():
> 
>     if (skb->protocol == htons(ETH_P_1588)) {
> 
> A SOCK_RAW sender bound to protocol 0 or ETH_P_ALL only passes that
> check because of this callback. Should the message mention this
> dependency?

Yes. It is missing for the HSR case so I added it in order to make the
mentioned check work.

> Users of the hsr device will also see some changes. They now get the
> real ethertype instead of 0 in these places:
> 
>   - skb_probe_transport_header()
>   - the VLAN network header adjustment in packet_parse_headers()
>   - tc/clsact protocol matching on the hsr device
>   - taps on the hsr device
> 
> There is also no Fixes: tag. Could the message say whether this is a
> standalone fix or a prerequisite for the PTP work, so backporters can
> decide whether they need it?

I'm not aware of anything broken so it is just a prerequisite for this
series. Therefore no Fixes tag.

Sebastian
