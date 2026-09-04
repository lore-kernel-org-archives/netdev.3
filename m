Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D03F8EB3;
	Fri,  4 Sep 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517132; cv=none; b=Dqua8Lnb2hEK+glCaaX4nYCUfxXdPJc9pAtO4K4pwl+oPv1cwvlsHfF6f/Es05mlmxEmKA72hF1B65ECgRQdlxchxUogAKFqT5DIhfUK5CD/Q4wsCi/keVYO7nX01m5bDHlkcMBlniuvd2dcJuvhUTFiQkUxDUm5glj+JGb2vrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517132; c=relaxed/simple;
	bh=8mYikl6kiVArrb/teISjbXJxIklnUi4M8/Rj2mHxvcg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2ewJbaOwQfmxqTiy0mbVdfLOHSTIexkfdycne6W9MEiDo9q0cyifB5Db2xbgDMKTVlOYidSNrBPDlkLoIUlSNNiZwSglv8o0/eBzFesjBwmgsdTdKnq3OW8xCOavS5i1YV6H46zj/+inUvw5+LuKS13UEzDQwkD4UqvSr6tSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrehZVKK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrehZVKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0EA1F00A3F;
	Fri,  4 Sep 2026 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517128;
	bh=JH8/TocAbumlqPZ6S+kQ16DGPI71YfmXPZ0E/Jzf+ho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VrehZVKKmli3ZiLLhHffzHmI2wLP+WlGx8DWQEJ5aCK/HW6ur6fRmlNejGwMD03tG
	 DcewqR+flu6uqBpqTMYtNfnDBvt2GgdbSZWOJmdC2NRBnsuyn4uTQmoF2dzIp6bl85
	 7Un8DpfjscOWHmyBD9lzNBqSpbFhXh6Th8BY5NeCQu0Xuj2GIbbheV/wMgWmkY1lfT
	 laU60rMSHvhYJ6nyGdZYBubawcjSx2ps4GwGl9vDaKYsrN6qBuEiWDDP36KzQ3Lz/x
	 EZFasJRFa+Gf3ITAOT44Nn7+6l5l7Y9OHqF7Bc6OAVMX4cuJ3gr1bkBL+o4dqXLojk
	 9hM4/aqw+k7CQ==
Subject: Re: [PATCH net-next 3/7] bnge: Move bnapi and ring_grp allocation to
 probe/remove
From: netdev-bot+sashiko@kernel.org
To: bhargava.marreddy@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com
Date: Fri, 04 Sep 2026 10:18:47 +0000
Message-ID: <178851712739.4131868.90269602624228034@kernel.org>
In-Reply-To: <20260901191728.643212-4-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-4-bhargava.marreddy@broadcom.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] bnge_init_nic()'s error path frees probe-owned memory,
  permanently NULLing bn->grp_info and causing a NULL-pointer write on…

--

bnge: Move bnapi and ring_grp allocation to probe/remove

This moves the bn->bnapi and bn->grp_info allocations from the open path
into bnge_netdev_alloc(), frees them in bnge_netdev_free(), and adds an
irq_re_init flag to bnge_init_ring_grps() so that open only resets the
per-group state.  bnge_free_core() now clears the bnapi queue
back-pointers instead of freeing bn->bnapi.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 6c1cb3aab5a8c..dcf04d391570b 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -1176,20 +1176,26 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
>  	bn->grp_info = NULL;
>  }
>  
> -static int bnge_init_ring_grps(struct bnge_net *bn)
> +static int bnge_init_ring_grps(struct bnge_net *bn, bool irq_re_init)
>  {
>  	struct bnge_dev *bd = bn->bd;
>  	int i;
>  
> -	bn->grp_info = kzalloc_objs(struct bnge_ring_grp_info, bd->nq_nr_rings);
> -	if (!bn->grp_info)
> -		return -ENOMEM;
> +	if (irq_re_init) {
> +		bn->grp_info = kzalloc_objs(struct bnge_ring_grp_info,
> +					    bd->nq_nr_rings);
> +		if (!bn->grp_info)
> +			return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < bd->nq_nr_rings; i++) {
> -		bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
>  		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;

[Severity: High]
With irq_re_init == false, which is the only value the open path passes,
the allocation branch is skipped and this loop writes bn->grp_info[i]
unconditionally.  Can bn->grp_info be NULL when we get here?

See the error path left behind in bnge_init_nic() below.

>  		bn->grp_info[i].rx_fw_ring_id = INVALID_HW_RING_ID;
>  		bn->grp_info[i].agg_fw_ring_id = INVALID_HW_RING_ID;
>  		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
> +
> +		if (irq_re_init)
> +			bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
>  	}
>  
>  	return 0;
> @@ -1201,25 +1207,6 @@ static void bnge_free_bnapi_mem(struct bnge_net *bn)
>  	bn->bnapi = NULL;
>  }
>  
> -static void bnge_free_core(struct bnge_net *bn)
> -{
> -	bnge_free_vnic_attributes(bn);
> -	bnge_free_tx_rings(bn);
> -	bnge_free_rx_rings(bn);
> -	bnge_free_nq_tree(bn);
> -	bnge_free_nq_arrays(bn);
> -	bnge_free_ring_stats(bn);
> -	bnge_free_ring_grps(bn);
> -	bnge_free_vnics(bn);
> -	kfree(bn->tx_ring_map);
> -	bn->tx_ring_map = NULL;
> -	kfree(bn->tx_ring);
> -	bn->tx_ring = NULL;
> -	kfree(bn->rx_ring);
> -	bn->rx_ring = NULL;
> -	bnge_free_bnapi_mem(bn);
> -}
> -
>  static int bnge_alloc_bnapi_mem(struct bnge_net *bn)
>  {
>  	struct bnge_dev *bd = bn->bd;

[ ... ]

> @@ -2834,9 +2858,7 @@ static int bnge_init_nic(struct bnge_net *bn)
>  
>  	bnge_init_tx_rings(bn);
>  
> -	rc = bnge_init_ring_grps(bn);
> -	if (rc)
> -		goto err_free_rx_ring_pair_bufs;
> +	bnge_init_ring_grps(bn, false);
>  
>  	bnge_init_vnics(bn);
>  
> @@ -2847,7 +2869,6 @@ static int bnge_init_nic(struct bnge_net *bn)
>  
>  err_free_ring_grps:
>  	bnge_free_ring_grps(bn);
> -err_free_rx_ring_pair_bufs:
>  	bnge_free_rx_ring_pair_bufs(bn);
>  	return rc;
>  }

[Severity: High]
Now that bn->grp_info belongs to probe/remove, should this
bnge_free_ring_grps() call still be here?

bnge_init_nic() reaches this label when bnge_init_chip() fails, which is
reachable through bnge_hwrm_stat_ctx_alloc(), bnge_hwrm_ring_alloc(),
bnge_hwrm_vnic_alloc() or bnge_setup_vnic() returning an error, and
bnge_free_ring_grps() does:

	kfree(bn->grp_info);
	bn->grp_info = NULL;

The unwind in bnge_open_core() (err_free_irq -> bnge_free_irq ->
bnge_del_napi -> bnge_free_core -> err_if_change) does not reallocate it,
and bnge_free_core() no longer touches grp_info at all after this patch,
so the netdev stays registered with bn->grp_info == NULL.

A second "ip link set <dev> up" then goes:

bnge_open_core()
  bnge_alloc_core()		/* does not touch grp_info */
  bnge_init_nic()
    bnge_init_ring_grps(bn, false)
      /* irq_re_init == false, allocation skipped */
      bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;   /* NULL deref */

Does that write oops?  Even if it were guarded, both
bnge_hwrm_stat_ctx_alloc() and hwrm_ring_alloc_send_msg() in
bnge_hwrm_lib.c dereference bn->grp_info:

		grp_info = &bn->grp_info[ring->grp_idx];
		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);

so the driver would also lose its mirror of the programmed firmware
stat_ctx_id / rx_ring_id / nq_ring_id associations.

Would dropping the bnge_free_ring_grps() call from this error path, so
only bnge_free_rx_ring_pair_bufs() remains, match the new ownership
model?

For reference, this is not fixed later in the series: at c51d67eb
bnge_init_nic() still has the err_free_ring_grps label calling
bnge_free_ring_grps(), bnge_init_ring_grps() still dereferences
bn->grp_info unguarded, and "bnge: Create NQ0 during probe and keep
active across open/close" adds another use of the same pointer in
bnge_free_nq0():

	bn->grp_info[0].nq_fw_ring_id = INVALID_HW_RING_ID;

[ ... ]

> @@ -3544,14 +3565,27 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
>  	spin_lock_init(&bn->stats_lock);
>  
>  	netdev->request_ops_lock = true;
> +
> +	rc = bnge_alloc_bnapi_mem(bn);
> +	if (rc)
> +		goto err_free_port_stats;
> +
> +	rc = bnge_init_ring_grps(bn, true);
> +	if (rc)
> +		goto err_free_bnapi_mem;
> +
>  	rc = register_netdev(netdev);
>  	if (rc) {
>  		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
> -		goto err_free_port_stats;
> +		goto err_free_ring_grps;
>  	}
>  
>  	return 0;
>  
> +err_free_ring_grps:
> +	bnge_free_ring_grps(bn);
> +err_free_bnapi_mem:
> +	bnge_free_bnapi_mem(bn);
>  err_free_port_stats:
>  	bnge_free_port_stats(bn);
>  err_free_workq:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901191728.643212-1-bhargava.marreddy%40broadcom.com
