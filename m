Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D13624D7
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861735; cv=none; b=PiBxCGB2EGFyo3gfTZ+v6HjrYZl9WwWvCrx3VKm0Xj14z4h4zAmbCD7Y2mDbozzMMLItz6HGHOpDiBWv+nEnRNo1nKba4IqoRGOUDXYVh6ibGMaovXt0uxN31Ih86XcdomLFfO80ewD2Nm9e36AsswOG5CtNRMEuaWR216nwkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861735; c=relaxed/simple;
	bh=pY013jS0LPZ9UmNvcXGdBCVyqQQa+Ob7vs00yyRlIXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUfxLfm0XoomkMgYDGnVX34wW3Dan8eM4Wh3EjffWdKlJHIYWKRk+0R1C35x//w2taQAdE/ZZdh8FjZ/7JBKtietkZKiCchKEqzIx4aiJblhPjbC8q6j0IIG3YLzCOTjGoChvoahWaJGTA//ntKK+dGb7EwMX16SswE2M2VfYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nse81hVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nse81hVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AA61F000E9;
	Fri, 19 Jun 2026 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861733;
	bh=5+2frUvJgyuU1DhxH6tVVVczOdx415NKr3b/JAICXF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nse81hVraxu2A6OSRWpKQJEIGXFRP2qifVav3Ziipg5rdn2/t0CZ2pAmWemSBgQH3
	 0JhGdoSNPIMFDpfIBsyvg55s+s0VEK1z+nBGTsZhfzv5CczW/jAOmnye/RSrW2RjiD
	 tYvjVH6zuytfF+GrAZeWK5vTT1FyZyKSrMWwEabWeiM5XIz+7RDb1uThtqHZDhvIF0
	 Q3raaGck5eafPQgaWaVfb/3LWWidW14r9o/jABA2rVPsTk73WnoCMjunVbQKvCXlza
	 jdZvZotA8gY/OWVfW6EaoEI4TY2kuV/SDhEeXE5+ufc5qXpQqdJQG2ovj6IDfi/lcc
	 eA0yoLFHa1YyA==
Date: Fri, 19 Jun 2026 10:35:29 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: airoha: fix netif_set_real_num_tx_queues
 for sparse QoS channels
Message-ID: <20260619093529.GV827683@horms.kernel.org>
References: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
 <20260618-airoha-qos-fixes-v1-2-37192652157f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-airoha-qos-fixes-v1-2-37192652157f@kernel.org>

On Thu, Jun 18, 2026 at 08:00:30AM +0200, Lorenzo Bianconi wrote:
> airoha_tc_htb_alloc_leaf_queue() assigns queue IDs based on the channel
> index (opt->qid = AIROHA_NUM_TX_RING + channel), but updates
> real_num_tx_queues with a simple increment (num_tx_queues + 1). When QoS
> channels are allocated sparsely (e.g., channels 0 and 3 without 1 and
> 2), the returned qid can exceed real_num_tx_queues, causing out-of-bounds
> accesses in the networking stack.
> For example, allocating channel 0 then channel 3 results in
> real_num_tx_queues = 34 but qid = 35, which is out of range [0, 34).
> Fix this by computing real_num_tx_queues based on the highest active
> channel index rather than using a simple counter, in both the allocation
> and deletion paths.
> 
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c

...

> @@ -2806,7 +2806,10 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  	if (err)
>  		goto error;
>  
> -	err = netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
> +	if (num_tx_queues <= netdev->real_num_tx_queues)
> +		goto set_qos_sq_bmap;
> +
> +	err = netif_set_real_num_tx_queues(netdev, num_tx_queues);
>  	if (err) {
>  		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
>  					      opt->quantum);
> @@ -2815,6 +2818,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  		goto error;
>  	}
>  
> +set_qos_sq_bmap:

I would prefer if this could be achieved without a goto.

>  	set_bit(channel, dev->qos_sq_bmap);
>  	opt->qid = AIROHA_NUM_TX_RING + channel;
>  

...
