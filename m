Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD41862A;
	Fri,  8 May 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252871; cv=none; b=onIzaMAgj/gkME6Ci4mCJhDRmIPpa2xsKGw1XFW4nlAzZMDqkm0bLxeq8r9moNOpL9WdFFCuau7fAQOQOTkexH4J+kH5O9SJbyiMTOuhzRcO52CHQLhkrB3JGJiwxDwVl68hRPaIlSqFbqbKA2s6L2umTQmuVKHjGNLXrQcoNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252871; c=relaxed/simple;
	bh=Pv3FTZ9ATrmxysMyOtkuTpnXuq4GVIFE10nmL33sesA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP/bc400z8EZIg6zevpjOQED8gBC7znJ2SyJjr3I32abi7bseT7IeUHebB9eGeQyeIQ0pO8Mdw5WM3wE/ci3igRyfX24XsCQmlmxAKzikaI+7fw+qce5WxCKtTc3sHvCzxZJye7j1Ya4XZCcR6l9npP9wIY3kdWbWO5zrtiCyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3I1Uqus; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3I1Uqus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8181EC2BCC7;
	Fri,  8 May 2026 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778252871;
	bh=Pv3FTZ9ATrmxysMyOtkuTpnXuq4GVIFE10nmL33sesA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3I1UqusQTbPx2G0/KhCqg7Z6bstEV0lYpshgjIf6OeKxRcnAr4zjJiT3GCzG8apZ
	 HfuKbe3KnUUtxyXJ2Xyw3vpr120w0NsOXZ+0rwNp2Wal+LFGL6Z4dA8UT5Z9SHA90H
	 7DKSqJVcPB6MYQA4qmW+6VR/K1EagTlaNPbohLchPhU8f+JwDU0EyCO/lNdGz4L8tn
	 e+VM1PNU93ptdxVFbQlucNJcQ0+jpb1oPJoZyg7WOKdu5KK/aQtXkYxwBN8Wso/8F5
	 wvkI+esKEc/2O/lLcdo46oNSttsgrvJeGytiB2ckPLG7FymOCpDDTzGAgG8+I28hwo
	 3T0I9mMENSkZw==
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kohei@enjuk.jp,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 4/5] ice: implement Rx queue management ops
Date: Fri,  8 May 2026 15:25:06 +0100
Message-ID: <20260508142505.1210977-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152923.1040589-5-aleksander.lobakin@intel.com>
References: <20260505152923.1040589-5-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
    ice: implement Rx queue management ops
    
    Now ice is ready to get queue_mgmt_ops support. It already has API
    to disable/reconfig/enable one particular queue (for XSk). Reuse as
    much of its code as possible to implement Rx queue management
    callbacks and vice versa -- ice_queue_mem_{alloc,free}() can be
    reused during ifup/ifdown to elide code duplication.
    With this, ice passes the io_uring zcrx selftests, meaning the Rx
    part of netmem/MP support is done.

> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 1add82d894bbe..4e0b8895c303a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -653,6 +653,43 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
>  	return err;
>  }
>  
> +static int ice_queue_mem_alloc(struct net_device *dev,
> +			       struct netdev_queue_config *qcfg,
> +			       void *per_queue_mem, int idx)
> +{
> +	const struct ice_netdev_priv *priv = netdev_priv(dev);
> +	const struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
> +	struct ice_rx_ring *new = per_queue_mem;
> +	int ret;
> +
> +	new->count = real->count;
> +	new->netdev = real->netdev;
> +	new->q_index = real->q_index;
> +	new->q_vector = real->q_vector;
> +	new->vsi = real->vsi;

Is it safe to assume netdev_priv(dev) returns the correct VSI here? For a
loopback VSI (ICE_VSI_LB), it shares the PF's netdev, so priv->vsi resolves
to the PF VSI.

Could this copy the PF VSI pointers to the loopback ring and cause hardware
context corruption later?

[ ... ]
> -/**
> - * ice_qp_dis - Disables a queue pair
> - * @vsi: VSI of interest
> - * @q_idx: ring index in array
> - *
> - * Returns 0 on success, negative on failure.
> - */
> -int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
> +static int __ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  {

Could this cause TX data corruption? This function appears to call
synchronize_net() before netif_tx_stop_queue(), meaning the RCU barrier
completes before the queue actually stops.

Concurrent transmissions might then race with ring modifications.

[ ... ]
> +static int ice_queue_start(struct net_device *dev,
> +			   struct netdev_queue_config *qcfg,
> +			   void *per_queue_mem, int idx)
> +{
> +	const struct ice_netdev_priv *priv = netdev_priv(dev);
> +	struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
> +	struct ice_rx_ring *new = per_queue_mem;
> +	struct napi_struct *napi;
> +	int ret;
[ ... ]
> +	ret = ice_alloc_rx_bufs(real, ICE_DESC_UNUSED(real));
> +
> +	return __ice_qp_ena(priv->vsi, idx, ret);
> +}

Does this cause a use-after-free via hardware DMA?

ice_alloc_rx_bufs() returns a boolean true (1) on success. This is passed to
__ice_qp_ena() as the fail argument, which returns it back. Since
ice_queue_start() returns a non-zero value, the core networking stack assumes
failure and frees the queue memory, while the hardware queue remains active and
DMAs into freed memory.

> +
> +static int ice_queue_stop(struct net_device *dev, void *per_queue_mem,
> +			  int idx)
> +{
> +	const struct ice_netdev_priv *priv = netdev_priv(dev);
> +	struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
> +	int ret;
> +
> +	ret = __ice_qp_dis(priv->vsi, idx);

Does calling __ice_qp_dis() from ice_queue_stop() disrupt the global interface
carrier state and TX queues?

__ice_qp_dis() calls netif_carrier_off() and cleans TX rings, but
ice_queue_stop() is intended to be a granular, per-RX-queue operation.

> +	if (ret)
> +		return ret;
> +
> +	page_pool_disable_direct_recycling(real->pp);

Can this dereference a NULL pointer if the queue is configured with an AF_XDP
zero-copy socket?

In that case, a standard page pool is not created and real->pp might be NULL,
causing a panic in page_pool_disable_direct_recycling().

> +	if (real->hdr_pp)
> +		page_pool_disable_direct_recycling(real->hdr_pp);
> +
> +	ice_zero_rx_ring(real);
> +	memcpy(per_queue_mem, real, sizeof(*real));

Could this lead to a memory leak of RX ring buffers?

ice_zero_rx_ring() clears the next_to_clean and next_to_use indices to 0
before the memcpy(). When the stack calls ice_queue_mem_free(per_queue_mem),
it skips cleaning because next_to_clean == next_to_use, leaking all active
skbs and page pool buffers.

Also, does this memcpy() leave dangling pointers in real that can lead to a
double-free?

The dynamically allocated pointers like rx_fqes and pp are not set to NULL
in real. When the interface is brought down later, ice_clean_rx_ring(real)
may attempt to destroy the already-freed page pools again.

> +
> +	return 0;
> +}
