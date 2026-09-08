Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4D37A494
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907746; cv=none; b=t3TtaVZEXgxzgtuJ36Ojc6G7vgBPRsLRTtA/fNfEaDzrlWmndAePJr/zFl6jSEc4pQIsTtQWRk9pZ8WkERTn2JGKjGrQoTGwDeWQ2EaEFzVIlx804RIAKFxckU8/SLUs6/TUBKqN28ZFsC6752JudkhYyWEFASStkbOiRwo6DxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907746; c=relaxed/simple;
	bh=htn/h+ofYPgzTt9tjHPvIdzzgLxAwik/dJEUhgv9q1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9IIq/+xmL5MMydrjrdEZ9qkUFCpU5BnEknELHBziXhJ4OgF4QHugt0i450UEPnD7rQ/eA+aXmHZPlHEDGtHo769vaU/lINQ/VDX0JSjZ4jR4a/GUHIcDJh8wndE9LTZDhId8uhTc/TN8oJR8U5lFTFfxqWH1DiJJYUOAA1lE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdWsXdgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdWsXdgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EF51F00AC4;
	Tue,  8 Sep 2026 22:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907738;
	bh=cFUEH6zwwQjoXsbUDkwhCzcZHl7MSu+XQeKuWVyfFNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdWsXdgtgWAtbajJ/GeVQaOuRnPb402DFjU1H0K1NcaCbgd22XeVgRvpdZDVuYW9B
	 PR6ZlEe5j1sFbh6EDamL6LArHasXEVveKYtASpfzSdUbKF2E9yDPYpQCNPBtT3AhpH
	 OQ3sJ7fIuYgUSXMmEGurWU6fBRLECi66v3FPiAhrFvRzlPQ6s3mFnvt5kajbDtqVu6
	 44bSHpZ1Ebh7b/I8ATXiNouHtAvDToD2Oq5yUbfnBC8QcTXeYNiNQ7hGPEV7begHhr
	 Sluy6fO9VJocq4YJdPTsxooLI7u1XIaNHde0SbiW9VRivW9z75UH4TxXICFgvhZqyE
	 wB9tYG/QnQaww==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 07/12] xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
Date: Tue,  8 Sep 2026 15:48:57 -0700
Message-ID: <20260908224857.1591225-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-8-steffen.klassert@secunet.com>
References: <20260907093020.2228346-8-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()

This adds rcu_read_lock() around the finish() callback loop in
xfrm_trans_reinject(), forces the dst to be refcounted in
xfrm_trans_queue_net(), and takes a reference on skb->dev across the
workqueue deferral.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index eecab337bd0a7..8f6109eada7ea 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -800,12 +800,17 @@ static void xfrm_trans_reinject(struct work_struct *work)
>  	spin_unlock_bh(&trans->queue_lock);
>  
>  	local_bh_disable();
> +	rcu_read_lock();
>  	while ((skb = __skb_dequeue(&queue))) {
>  		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
> +		struct net_device *dev = skb->dev;
>  
>  		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
> +		if (dev)
> +			dev_put(dev);
>  		put_net(net);
>  	}
> +	rcu_read_unlock();
>  	local_bh_enable();
>  }
>  
> @@ -821,12 +826,18 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
>  	if (skb_queue_len(&trans->queue) >= READ_ONCE(net_hotdata.max_backlog))
>  		return -ENOBUFS;
>  
> +	if (skb_dst(skb) && !skb_dst_force(skb))
> +		return -EHOSTUNREACH;
> +
>  	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
>  
>  	hold_net = maybe_get_net(net);
>  	if (!hold_net)
>  		return -ENODEV;
>  
> +	if (skb->dev)
> +		dev_hold(skb->dev);

[Severity: High]
Is skb->dev guaranteed to be alive here for every caller of
xfrm_trans_queue_net()?

The three transport-input callers look fine: xfrm_input() holds
rcu_read_lock() around afinfo->transport_finish(), and espintcp_rcv()
sets skb->dev via dev_get_by_index_rcu() inside the same RCU section.

The ESPinTCP output caller looks different. esp_output_tail_tcp() in
net/ipv4/esp4.c (and its net/ipv6/esp6.c twin) only does:

	local_bh_disable();
	err = xfrm_trans_queue_net(xs_net(x), skb, esp_output_tcp_encap_cb);
	local_bh_enable();

There is no rcu_read_lock() here, and per this patch's own commit message
local_bh_disable() is not an RCU read-side critical section under
CONFIG_PREEMPT_RCU.

That path is also reachable asynchronously. esp_output_tail() registers
the completion with aead_request_set_callback(req, 0, esp_output_done,
skb), and when crypto_aead_encrypt() returns -EINPROGRESS,
esp_output_done() later calls esp_output_tail_tcp() from a cryptd worker
or driver completion context, long after the receive-side RCU section
ended.

For a forwarded packet, what is skb->dev at that point? ip_forward() ->
NF_HOOK(..., ip_forward_finish) -> dst_output() enters the xfrm bundle
output with skb->dev still pointing at the ingress netdevice:

net/ipv4/ip_forward.c:ip_forward_finish() {
	...
	skb_clear_tstamp(skb);
	return dst_output(net, sk, skb);
}

Nothing on that path resets skb->dev (net/xfrm/xfrm_output.c only assigns
skb->dev on the HW-offload xmit path and in the IPv6 pmtu error path), and
nothing holds a reference on the ingress device - the skb only records
skb_iif, and the bundle dst references the egress device.

So if the ingress device is unregistered and freed while the request sits
in the crypto queue, does dev_hold(skb->dev) here increment a refcount in
freed memory, with the matching dev_put() in xfrm_trans_reinject() writing
to it a second time? With CONFIG_PCPU_DEV_REFCNT=n this would also hit
refcount_warn_saturate() on increment-from-zero.

There is a second aspect: esp_output_tcp_encap_cb() only uses
skb_dst(skb)->xfrm and never touches skb->dev, so the hold seems to be
unnecessary for that caller. Would it make sense to take the reference
only in the callers where skb->dev is provably live and the finish()
callback needs it - for example recording the held device in struct
xfrm_trans_cb - rather than holding unconditionally in the shared helper?
