Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86444B68D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385444; cv=none; b=d1W1P/KRztHiYPLxttvOGCUSjhgXnGb8otJTfDC1MY2CPbDp7TIO4mjTUrWg7INya9KC+2PfKAumYjgY8Fcdqc117eMHbiuuBxrtlOSi6Jmts40YBSPxwt52JxrIjwr379V4nqLhqSf6a5hjm7ZiatWkEfrMP9+5Zex9Ei1RzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385444; c=relaxed/simple;
	bh=pO0oJmU8jV7UtXIvDl8U6ZtQpJ2YBqo9uF6e2i/ss+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMYzfcYEPviwS4H0jh1ZVb6lpTKG0ntd+b3AhzurAvpHmwO2UeJTBN9bwYDINJRIYxM4QweVn8ZB5fsRESd+qmq3/fc0XFGqn5tfQB5WMtIKJ1dwoyebyMXyahUQtRfk8IvTB2pb1Kgako/gMDVKd2WDYFNxYSxFe5CgDseA8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=m6pnVgnb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="m6pnVgnb"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 50160201E4;
	Mon, 14 Sep 2026 13:30:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rL5uwme4zmkU; Mon, 14 Sep 2026 13:30:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9108D20185;
	Mon, 14 Sep 2026 13:30:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9108D20185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789385438;
	bh=0MzPPGJrhB//L9w0pDUFaNG4UT19N821oLM/UvXI1gA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=m6pnVgnbsKpr1GhKDEzAxUvFRRPBSi6aEa6lvGkQriFe5n3CreiRS7MNPGqhpGn15
	 zEf8aKeRzk/OkpAgbyJmOzpnmV3bq9nIby3HIp7hTmU+sHEfKc59yZvTQNKQmexMMc
	 QtqZnxIsKqFilnVTU2PaZRyOXPYNg6TKJTE1LnjhmbFFgT8VtV/jnMXy0UNs+Bw+WB
	 qIPaQ1CJWrTSWCBpiEoEOnolSAPw0V8eMI6nWr1QKveKTwLI/fPPP5mHskWOxRyuXb
	 WGZGybfkgDHen6U8eZsl77uJ3msTwHMFCbwpwpza3TxI1I+1XnBks5CsRSQeuXJ8KT
	 huwl6p1aLOxUg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 13:30:38 +0200
Received: (nullmailer pid 1964473 invoked by uid 1000);
	Mon, 14 Sep 2026 11:30:37 -0000
Date: Mon, 14 Sep 2026 13:30:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 07/12] xfrm: add missing rcu_read_lock(), skb_dst_force()
 and dev_hold() for xfrm_trans_reinject()
Message-ID: <aqfa3dvQcB52VnBQ@secunet.com>
References: <20260907093020.2228346-8-steffen.klassert@secunet.com>
 <20260908224857.1591225-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224857.1591225-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch.

On Tue, Sep 08, 2026 at 03:48:57PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
> 
> This adds rcu_read_lock() around the finish() callback loop in
> xfrm_trans_reinject(), forces the dst to be refcounted in
> xfrm_trans_queue_net(), and takes a reference on skb->dev across the
> workqueue deferral.
> 
> > diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> > index eecab337bd0a7..8f6109eada7ea 100644
> > --- a/net/xfrm/xfrm_input.c
> > +++ b/net/xfrm/xfrm_input.c
> > @@ -800,12 +800,17 @@ static void xfrm_trans_reinject(struct work_struct *work)
> >  	spin_unlock_bh(&trans->queue_lock);
> >  
> >  	local_bh_disable();
> > +	rcu_read_lock();
> >  	while ((skb = __skb_dequeue(&queue))) {
> >  		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
> > +		struct net_device *dev = skb->dev;
> >  
> >  		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
> > +		if (dev)
> > +			dev_put(dev);
> >  		put_net(net);
> >  	}
> > +	rcu_read_unlock();
> >  	local_bh_enable();
> >  }
> >  
> > @@ -821,12 +826,18 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
> >  	if (skb_queue_len(&trans->queue) >= READ_ONCE(net_hotdata.max_backlog))
> >  		return -ENOBUFS;
> >  
> > +	if (skb_dst(skb) && !skb_dst_force(skb))
> > +		return -EHOSTUNREACH;
> > +
> >  	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
> >  
> >  	hold_net = maybe_get_net(net);
> >  	if (!hold_net)
> >  		return -ENODEV;
> >  
> > +	if (skb->dev)
> > +		dev_hold(skb->dev);
> 
> [Severity: High]
> Is skb->dev guaranteed to be alive here for every caller of
> xfrm_trans_queue_net()?
> 
> The three transport-input callers look fine: xfrm_input() holds
> rcu_read_lock() around afinfo->transport_finish(), and espintcp_rcv()
> sets skb->dev via dev_get_by_index_rcu() inside the same RCU section.

The patch fixes a syzbot report in the input path and is corrext as is.

> 
> The ESPinTCP output caller looks different. esp_output_tail_tcp() in
> net/ipv4/esp4.c (and its net/ipv6/esp6.c twin) only does:
> 
> 	local_bh_disable();
> 	err = xfrm_trans_queue_net(xs_net(x), skb, esp_output_tcp_encap_cb);
> 	local_bh_enable();
> 
> There is no rcu_read_lock() here, and per this patch's own commit message
> local_bh_disable() is not an RCU read-side critical section under
> CONFIG_PREEMPT_RCU.
> 
> That path is also reachable asynchronously. esp_output_tail() registers
> the completion with aead_request_set_callback(req, 0, esp_output_done,
> skb), and when crypto_aead_encrypt() returns -EINPROGRESS,
> esp_output_done() later calls esp_output_tail_tcp() from a cryptd worker
> or driver completion context, long after the receive-side RCU section
> ended.
> 
> For a forwarded packet, what is skb->dev at that point? ip_forward() ->
> NF_HOOK(..., ip_forward_finish) -> dst_output() enters the xfrm bundle
> output with skb->dev still pointing at the ingress netdevice:
> 
> net/ipv4/ip_forward.c:ip_forward_finish() {
> 	...
> 	skb_clear_tstamp(skb);
> 	return dst_output(net, sk, skb);
> }
> 
> Nothing on that path resets skb->dev (net/xfrm/xfrm_output.c only assigns
> skb->dev on the HW-offload xmit path and in the IPv6 pmtu error path), and
> nothing holds a reference on the ingress device - the skb only records
> skb_iif, and the bundle dst references the egress device.
> 
> So if the ingress device is unregistered and freed while the request sits
> in the crypto queue, does dev_hold(skb->dev) here increment a refcount in
> freed memory, with the matching dev_put() in xfrm_trans_reinject() writing
> to it a second time? With CONFIG_PCPU_DEV_REFCNT=n this would also hit
> refcount_warn_saturate() on increment-from-zero.
> 
> There is a second aspect: esp_output_tcp_encap_cb() only uses
> skb_dst(skb)->xfrm and never touches skb->dev, so the hold seems to be
> unnecessary for that caller. Would it make sense to take the reference
> only in the callers where skb->dev is provably live and the finish()
> callback needs it - for example recording the held device in struct
> xfrm_trans_cb - rather than holding unconditionally in the shared helper?

What is described here is in the output path, this needs separate
investigation.
