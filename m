Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8304C33D6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631326; cv=none; b=a0rYimxpO5+l4WDXsUrqcJo23BqL/+AbnjmtSjObbELJsoNQJAKqGIOTmaU03aDGNJIMoIKzsUIqpFi7lFxIbTpbPd2meRCl2/nwY8BXCrO4g7aTpmO3nOgZxtk3Ev0f2xdBSttdo79U+SNfTK1Clv7/DZp8d90rBJSTV5d8fLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631326; c=relaxed/simple;
	bh=RfR89RpfeKdZerhR/DGK9Vn0yTbd9SSuCVpkU5M8w6U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B0mC1CgJeMn6WhSWSsqI5EtSvvCL4JqPA+FHalT8OLictaMMYViQXYww7jNVJT991Zbx8kZqyFDFT/Y0XJDb+8Vsiqxer1DoZ+/zAkU3WsiuFiAuquanWMlnvJwyYiWEsq9kkRzoaAXWJfw5geLDHV6kh25rX0+quRP+FULJzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AtoeIs/h; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AtoeIs/h"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94DDBA4A48;
	Mon, 28 Sep 2026 23:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790631311; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=40qIwvCs45op1p7WjK9kukoIvc5ES8VqsImli/ianvw=;
	b=AtoeIs/hVxQuseZXev6IkYXa5ErSovRpz4MYdqygSgGULV0x0VTpwa+xa2mJI698CRFDaG
	tNL9cP0NzTJMrGHM375KmQhRkq8VwvMaCwM5UEPBExm3dvgg77NR+qA0GOTE0WIPWCvSlm
	KY5F5iMXEfDCynHTlBXCRfML5nkthilPSdrbtzhFTzrYbif2z/U1yUxCCe6VG2kV9DuZjm
	+pz+SMtdOTVsDYgBRtbwDNgT0RzameJ9iUj3m4dLqSHgIR6j2L/n0eoMmGZySxEq3e1+lS
	X0g5B37ha7ZPF5cVJuhCTQlHRkNdLSeR/TW+J/lBCFb+faJY4/61KH+xwSFYtA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 23:35:08 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
Subject: Re: [PATCH net] net: bcmasp: fix lost TX wakeup race with lockless
 queue API
In-Reply-To: <20260928201816.3935530-1-justin.chen@broadcom.com>
References: <20260928201816.3935530-1-justin.chen@broadcom.com>
Message-ID: <a65f6e3445b1ea32becb8d974bc147ad@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Justin

On 28.9.2026 22:18, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> netif_stop_queue() in bcmasp_xmit() raced with netif_wake_queue() in
> bcmasp_tx_poll(): a reclaim landing between the ring-full check and
> the stop call left the queue stopped despite free descriptors,
> hanging TX until timeout.
> 
> Switch to netif_txq_maybe_stop()/netif_txq_completed_wake() (the
> lockless TX queue API, which also brings in BQL), replace
> tx_spb_ring_full() with a live bcmasp_tx_avail() count.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet 
> controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Assisted-by: Claude:claude-sonnet-5
> ---
>  .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 68 +++++++++++--------

> [...]

>  static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
> @@ -241,16 +239,18 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff 
> *skb, struct net_device *dev)
>  	struct bcmasp_tx_cb *txcb;
>  	dma_addr_t mapping, valid;
>  	struct bcmasp_desc *desc;
> +	struct netdev_queue *txq;
>  	bool csum_hw = false;
>  	struct device *kdev;
>  	skb_frag_t *frag;
> 
>  	kdev = &intf->parent->pdev->dev;
> +	txq = netdev_get_tx_queue(dev, 0);
> 
>  	nr_frags = skb_shinfo(skb)->nr_frags;
> 
> -	if (tx_spb_ring_full(intf, nr_frags + 1)) {
> -		netif_stop_queue(dev);
> +	if (unlikely(bcmasp_tx_avail(intf) < nr_frags + 1)) {
> +		netif_tx_stop_queue(txq);

nit: AFAIU this is unreachable for now, but to prevent future races 
maybe
better use netif_txq_try_stop()?

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
