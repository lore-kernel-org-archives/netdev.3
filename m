Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB854D9F7D;
	Thu,  1 Oct 2026 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846028; cv=none; b=ELIev0b/+HqmB1qJ+9mYPE06nDCnW8ntNwqyQ3+qhSJIDI4iEzIsc5IdLqcH/0I5IJRpPvhVNhosEKQxAuXac7U3FGwdlMKw65lldeooYRuxHeDpW+49i0+qSCZ58cmOYK2TV8CIyROVVk29pbk+3UNhpueryt60ugOaUXA4EfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846028; c=relaxed/simple;
	bh=YmIBog0e+2g8vUNWwqPzJtXRLjbDQesOzRJ10T6vFXQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNwe9wZTPFzrpNo3gIIf2pWn3SRHxssj1PGeHr4z+JKqbdtSGkFoZHxoMi25ubFSxChU0pXqIfkNw6wmbEMxJVuweb0DcsQEMAQUZ70I8Syg3KhvxV1ZoAKEHni5c+NuREk33ab1LSbqV89p4mAZPZsXpCLZWqJgsTbmwe84ML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdP/sYNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdP/sYNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A721F000FF;
	Thu,  1 Oct 2026 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846025;
	bh=gtf5iw6OP82TU65kkAZVnTp9DHCOwq9ANDoi/A+/X/Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JdP/sYNIaSj3Z6CDXcBWXfrsU0358Rm2+MzLq4yiddX/aqGQTBEshH4owQyZ8/jHD
	 LGTCSaCGsIiP13aFnMpzvsHl7ib7tV44QGv14sw2f/xDeTAfv4z5v5Nrm972iyEy4N
	 EFPAPRu9Nv4UZn5VzWlDk57V1/oqdJsywQvFAhc5hFFxjZwM5URY0J/jEHc5/NllK9
	 7Qih/TQyaBHUJwpiJ8zz1vrKkvPNz1I8yFvIzPsDtiYutxZCEbI/h/x1dj4zljnXd1
	 3vbnIMi9j387G67PSqol9YcWpq8O7Ype8P3QG7wslsKARrtHq2cjfF73YwRI9WYBcq
	 hxvcyxR7oZxFQ==
Subject: Re: [net-next, v4 10/10] bnge: add cpu_rmap support for IRQ affinity
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:43 +0000
Message-ID: <179084602395.434549.9769381174533285357@kernel.org>
In-Reply-To: <20260928061307.1172344-11-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-11-vikas.gupta@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Now that this patch publishes rx_cpu_rmap, the core starts
  passing target queues to bnge_rx_flow_steer().

--

bnge: add cpu_rmap support for IRQ affinity

When CONFIG_RFS_ACCEL is enabled, this patch allocates dev->rx_cpu_rmap
and fills it with the RX IRQ vectors. The kernel's aRFS code can then map
flows to the RX queue serviced by the nearest CPU and call
ndo_rx_flow_steer() for that queue.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index de7818d2c2af2..a4156a12c8714 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2437,10 +2438,23 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
>  {
>  	struct net_device *dev = bn->netdev;
>  	struct bnge_dev *bd = bn->bd;
> +	int rc;
>  
>  	bnge_setup_msix(bn);
>  
> -	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
> +	rc = netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
> +	if (rc)
> +		return rc;
> +
> +#ifdef CONFIG_RFS_ACCEL
> +	if (bn->priv_flags & BNGE_NET_EN_NTUPLE) {
> +		dev->rx_cpu_rmap = alloc_irq_cpu_rmap(bd->rx_nr_rings);

[Severity: Low]
Once dev->rx_cpu_rmap is set here, the core starts calling
bnge_rx_flow_steer() with CPU-derived target queues. That function came
from an earlier patch in this series ("bnge: add aRFS flow steering ndo
support"), but it can only be reached after this patch.

When bnge_rx_flow_steer() finds an existing filter for the flow, it
returns that filter's id. It never compares fltr->base.rxq with
rxq_index:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_rx_flow_steer() {
    ...
	fltr = bnge_lookup_ntp_filter_from_idx(bn, new_fltr, idx);
	/* Filter already exists; return its id.  A stale filter (queue
	 * changed) is freed later via rps_may_expire_flow() and recreated.
	 */
	if (fltr) {
		rc = fltr->base.sw_id;
		rcu_read_unlock();
		goto err_free;
	}
    ...
}

set_rps_cpu() counts any non-negative return as success. It stores the id
in the target queue's flow table and clears the old queue's entry:

net/core/dev.c:set_rps_cpu() {
    ...
	rc = dev->netdev_ops->ndo_rx_flow_steer(dev, skb,
						rxq_index, flow_id);
	if (rc < 0)
		goto out;

	old_rflow = rflow;
	rflow = tmp_rflow;
	WRITE_ONCE(rflow->filter, rc);
	WRITE_ONCE(rflow->hash, hash);

	if (old_rflow->filter == rc)
		WRITE_ONCE(old_rflow->filter, RPS_NO_FILTER);
    ...
}

The hardware filter keeps steering to the old queue anyway.

Next, bnge_cfg_ntp_filters() calls rps_may_expire_flow() with
fltr->base.rxq, which is still the old queue. The core has already cleared
that slot, so the filter is expired and freed while the flow is still
active.

Is the "recreated" part of that comment actually guaranteed? The target
queue's entry still holds the sw_id, with cpu equal to next_cpu. After the
flow falls back to RSS, set_rps_cpu() can take this branch without calling
ndo_rx_flow_steer():

		if (READ_ONCE(tmp_rflow->filter) != RPS_NO_FILTER) {
			if (rps_flow_is_active(tmp_rflow,
					       rps_tag_to_log(q_tag_ptr),
					       tmp_cpu)) {
				if (hash != READ_ONCE(tmp_rflow->hash) ||
				    next_cpu == tmp_cpu)
					goto out;
			}
		}

That writes next_cpu into the RSS queue's entry. From then on,
get_rps_cpu() sees tcpu == next_cpu and never calls set_rps_cpu() again.

Could the flow then stay on software RFS, with no hardware filter, until
the application moves to another CPU?

mlx5 and sfc update the existing rule's queue in this case. bnxt uses the
same pattern as bnge.

Would it make sense for the existing-filter path to either reprogram the
filter to rxq_index, or return an error so the core doesn't move the
filter id to the new queue?

> +		if (!dev->rx_cpu_rmap)
> +			return -ENOMEM;
> +	}
> +#endif
> +
> +	return rc;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
