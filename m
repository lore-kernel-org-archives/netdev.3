Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10271B7910
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481186; cv=none; b=tpH2ti23vTJYjNDN8mcQuaW5mqpg0uxeg/CkkU6ss6F8d19pzSrwVvwvbigqXGhBrJCWVegp0gmA1hpgmwCxBHLcmHZiaURLe7cOm0wUNP8x5ByE4U8MkQKuzo2lz0NSLO20A/w3Vu/yJzHZwSr3aMStZU2tB4O+KmKftP0m2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481186; c=relaxed/simple;
	bh=DIn0xecdp1HnqW6H1I/OxyrV97B7r5eWPJEoiDO+tdQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGovHqor3E14fBa/ARqxC72WKkHOtVt50iM/shJ+9PC9VfE/rRWzTVr1TbkAUAqHdwQzLET70Doydh5h2fyZZCpL058cBMJBU/qnBTN3wVM8gi8ZP7ku9vzft0XzlKPXXv05pf5xF2M3z3c98jix6awOkwGW2p1AplEuhbx871U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC2qL6gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC2qL6gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346701F00A3D;
	Fri,  4 Sep 2026 00:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481184;
	bh=C2VL3gZkwmadkCsMaaE8KHlPspMhSV9asmSBXRRJl00=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KC2qL6ggtWbEyS/V8GdSi5XTCBa1nVATznuInO+ecA4PtY4hQeRhZ6EZbY59mxxSZ
	 ZVtac5nSiH1UQ7gsYITd3eV5zh8LbEgWWDCzG18Xf7zA8hPMIS0i+MR0BGEZsjLnqb
	 qCdiewyDY6HyDrnmrmEC2qH/KNpS6IaOxE6/ztbcpkEIFzkeWC9UnxuVMZa1Ot8Rns
	 q1/Ht3vgDhxggcMJqwYLdQvC5PnC06diYPctCO+GO8WSFcRxu5lNUDyKdgTT9d8GvF
	 Npqm3NR+Z5g4urchCEwg8VsmHYGLQB0dgRPNe30beSQF8Ugq49HgLVJGf34ZR0cbF1
	 0fqXnhLduvjiA==
Subject: Re: [PATCH net-next v8 3/6] idpf: support pacing offload
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 04 Sep 2026 00:19:43 +0000
Message-ID: <178848118375.4131868.13506511829846201867@kernel.org>
In-Reply-To: <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Divergent EDT state across a hard reset: the netdev-side
  pacing horizon survives while the adapter-side timestamp granularity…

--

idpf: support pacing offload

Adds EDT (earliest departure time) support to idpf: the txtime from
skb->tstamp is bounds checked and programmed into the flow scheduling Tx
descriptor. The feature is negotiated with the device through a new
VIRTCHNL2_OP_GET_EDT_CAPS exchange, and the resulting horizon is exposed
as netdev->max_pacing_offload_horizon.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 827c795afcb6..c2ad3fdf72aa 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -890,6 +890,12 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>  	netdev->min_mtu = ETH_MIN_MTU;
>  	netdev->max_mtu = vport->max_mtu;
>  
> +	if (adapter->edt_caps.time_horizon_ns &&
> +	    idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
> +	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
> +			     VIRTCHNL2_CAP_SPLITQ_QSCHED))
> +		netdev->max_pacing_offload_horizon = adapter->edt_caps.time_horizon_ns;
> +
>  	dflt_features = NETIF_F_SG	|
>  			NETIF_F_HIGHDMA;
>  
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 24b91be25676..d80b6f5a0fde 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1742,6 +1742,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
>  			q->desc_count = rsrc->txq_desc_count;
>  			q->tx_max_bufs = idpf_get_max_tx_bufs(adapter);
>  			q->tx_min_pkt_len = idpf_get_min_tx_pkt_len(adapter);
> +			q->ts_gran_pow2 = adapter->edt_caps.tstamp_granularity_pow2;
>  			q->netdev = vport->netdev;
>  			q->txq_grp = tx_qgrp;
>  			q->rel_q_id = j;

[ ... ]

> @@ -3011,6 +3017,60 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
>  	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
>  }
>  
> +static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
> +				      const struct idpf_tx_queue *tx_q,
> +				      struct idpf_tx_splitq_params *tx_params)
> +{
> +	const int offload_slack_ns = 400;
> +	u64 ts, now, horizon;
> +
> +	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
> +	if (!horizon)
> +		return;
> +
[ ... ]
> +	ts >>= tx_q->ts_gran_pow2;
> +
> +	/* 0 is valid 23b timestamp, but also means field unset.
> +	 * Increase by one to avoid this case
> +	 */
> +	if ((ts & 0x7fffff) == 0) {
> +		tx_params->offload.desc_ts[0] = 1;
> +		return;
> +	}
> +
> +	tx_params->offload.desc_ts[0] = ts & 0xff;
> +	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
> +	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706973..030ecd9b6c41 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -573,6 +575,54 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>  	return err;
>  }
>  
[ ... ]
> +	if (xn_params.recv_mem.iov_len < sizeof(caps)) {
> +		err = -EIO;
> +		goto free_rx_buf;
> +	}
> +
> +	memcpy(&caps, xn_params.recv_mem.iov_base, sizeof(caps));
> +	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
> +	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
> +	if (horizon_ns > U32_MAX) {
> +		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
> +		err = -EINVAL;
> +		goto free_rx_buf;
> +	}
> +	if (!gran_ns) {
> +		dev_warn(&adapter->pdev->dev, "EDT granularity undefined\n");
> +		err = -EINVAL;
> +		goto free_rx_buf;
> +	}
> +
> +	adapter->edt_caps.time_horizon_ns = horizon_ns;
> +	adapter->edt_caps.tstamp_granularity_pow2 = ilog2(gran_ns);
> +
> +free_rx_buf:
> +	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> +
> +	return err;
> +}
> +
[ ... ]
> @@ -3085,6 +3135,14 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>  		}
>  	}
>  
> +	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
> +		err = idpf_send_get_edt_caps_msg(adapter);
> +		if (err) {
> +			dev_err(&adapter->pdev->dev, "EDT init failed, err=%d\n", err);
> +			memset(&adapter->edt_caps, 0, sizeof(adapter->edt_caps));
> +		}
> +	}
> +

[Severity: Medium]
When this re-negotiation fails on a reset, edt_caps is zeroed and init
continues, but nothing revokes the pacing horizon already published on the
netdev.  Can that leave the two halves of the EDT state inconsistent?

idpf_init_hard_reset() calls idpf_vc_core_init() again on the same adapter
while the netdevs stay registered (IDPF_VPORT_REG_NETDEV is only cleared in
idpf_decfg_netdev(), on driver remove), so idpf_cfg_netdev() takes its early
return:

	if (test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags)) {
		netdev = adapter->netdevs[idx];
		...
		return idpf_init_mac_addr(vport, netdev);
	}

and never re-evaluates the new assignment:

	if (adapter->edt_caps.time_horizon_ns && ...)
		netdev->max_pacing_offload_horizon = adapter->edt_caps.time_horizon_ns;

The dev->pacing_offload_horizon value the admin set earlier through
RTM_SETLINK also survives, since it is only validated at set time.

The re-created Tx queues do pick up the zeroed granularity in
idpf_txq_group_alloc():

	q->ts_gran_pow2 = adapter->edt_caps.tstamp_granularity_pow2;

and idpf_tx_splitq_set_txtime() gates only on the netdev horizon:

	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
	if (!horizon)
		return;
	...
	ts >>= tx_q->ts_gran_pow2;

With ts_gran_pow2 of 0 the shift is a no-op, so the low 23 bits of a raw
CLOCK_TAI nanosecond value end up in the descriptor ts[] field while the
device still interprets that field in its own unchanged granularity.  Would
departure times then land on effectively arbitrary points inside the hardware
window (up to roughly 4.29 s), holding a descriptor and buf_id each, after
only the single dev_err above?

Note that granularity 0 is a value the driver itself rejects from firmware
("EDT granularity undefined"), so it is being used as an invalid state here.

Would it be reasonable to clear dev->pacing_offload_horizon and
max_pacing_offload_horizon on this failure path, or to have
idpf_tx_splitq_set_txtime() also check that tx_q->ts_gran_pow2 is valid?

One more thing on this part of the commit message:

    On device reset, dev->pacing_offload_horizon, fq offload_horizon and
    granularity are not re-negotiated. It is safe to assume that firmware
    does not change these EDT capabilities across resets.

idpf_vc_core_init() runs again on every hard reset and does re-issue
VIRTCHNL2_OP_GET_EDT_CAPS, so granularity is re-negotiated.  Could the
wording be adjusted to match what the code does?

>  	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
>  	num_max_vports = idpf_get_max_vports(adapter);
>  	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902181747.2483351-1-willemdebruijn.kernel%40gmail.com
