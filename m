Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A4248896
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802210; cv=none; b=h3+r9x9kKQ7aI5iwJB7AJ304JdoxPVrznGNkQ97Bd0T9BfB7dymCHdATL2xoTtGDP/0exmolZKp0ed14uXqEl7CMFvcsAZNZHYxSHvMwFSelYIwUmj7xKd/VbKkWPNQ4AckTL06CLyArE0MfMxzVcwq65M8yXgwUyqE++e3+lIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802210; c=relaxed/simple;
	bh=sQKglJNAbqhrL8K+V5bAoDAKpP5fO2JK5WzfEJBYW+E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YPGOyld0K/ULFygFjZlWPKNejKnq4ikdp4wu8UUsVt/lBHT2m0bFJ78seMvtY6HxYoLo+mEILhB5LnehVg2g8TEYXXFFl16VaxzV8kH4/xqhQYKjkIZJjt81e9PSIeKa3TJRoU2fa94lPVPrEdsUjMx4bTnKffr/WzB1AvycK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN79mAyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN79mAyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D771E1F000FF;
	Sat, 19 Sep 2026 07:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789802208;
	bh=4FsqR9YyaxDoZGUZQfxbtrA5ZTQHDmOhwrGoSLRBlLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VN79mAyUN5ZiE2zTlviTBAYue1RocUNiYc5bQ92mZMd1J9n1AyeLr4/ubCdKOna0o
	 0xKfXUBk9Jr3C3g9MSmWyWgVNip6Xj4LqFYmVlnr0+WJ38NbYWwf91C4+IDkClg/S/
	 IY/dY0nOwmA7cJVkR5+JzrmA+OakpC4Vx+KcsD3e2noZOaK7Ybe66q6uZSHd5zkwAQ
	 rJOjmXdvX9w3kSwbrg2j80CdL5lWLDOt38WkJG4TBw/eLEYHD7QjFp0+vjtv2Lxnh9
	 5ssTc+OQuME8lccy2X7hTkCdCqYfkR7kG/MnCaEOoA/wf4JY5pDH498k1g35WlaLaA
	 eWSDeo50XSxrQ==
Subject: Re: [PATCH net v6] net: Wangxun: protect ring accesses with RCU
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 richardcochran@gmail.com
Date: Sat, 19 Sep 2026 07:16:47 +0000
Message-ID: <178980220740.22033.15257166624913083817@kernel.org>
In-Reply-To: <20260915065731.6007-1-mengyuanlou@net-swift.com>
References: <20260915065731.6007-1-mengyuanlou@net-swift.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 3 (3) · Low: 0

- [Medium] The commit message describes only four annotation-level
  changes (add __rcu, add rcu_read_lock() sections, use…
- [Medium] The patch adds rtnl_lock()/rtnl_unlock() around
  wx_init_interrupt_scheme() in four probe routines (ngbe_probe,…
- [Medium] The three ethtool set_ringparam paths annotate the ring-array
  dereferences with rcu_dereference_protected(...,…

Pre-existing issues:
- [High] wxvf_suspend() tears down the whole interrupt scheme
  (wx_clear_interrupt_scheme() -> wx_free_q_vectors() ->…
- [Medium] wxvf_resume() ignores the return value of
  wx_init_interrupt_scheme() (the call this patch wraps in…
- [Medium] ngbe_setup_tc() and txgbe_setup_tc() close (or reset) the
  device and destroy the existing interrupt scheme, then call…
- [Medium] ngbe_resume() stores the result of wx_init_interrupt_scheme()
  (and possibly of ngbe_open()) in `err` and correctly skips…

--

net: Wangxun: protect ring accesses with RCU

This converts the wx->tx_ring[]/wx->rx_ring[] arrays in the Wangxun drivers
to __rcu, wraps the lockless readers in rcu_read_lock() sections with
rcu_dereference() and NULL guards, publishes and clears the slots with
rcu_assign_pointer(), and uses rcu_dereference_protected() in the control
paths.  A few call sites also gain rtnl_lock()/rtnl_unlock().

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 940d2e59876c7..414523fe83cb4 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c

[ ... ]

> @@ -805,9 +807,13 @@ static int wx_set_ringparam_vf(struct net_device *netdev,
>  
>  	if (!netif_running(wx->netdev)) {
>  		for (i = 0; i < wx->num_tx_queues; i++)
> -			wx->tx_ring[i]->count = new_tx_count;
> +			rcu_dereference_protected(wx->tx_ring[i],
> +						  lockdep_is_held(&wx->reset_lock))->count =
> +				new_tx_count;
>  		for (i = 0; i < wx->num_rx_queues; i++)
> -			wx->rx_ring[i]->count = new_rx_count;
> +			rcu_dereference_protected(wx->rx_ring[i],
> +						  lockdep_is_held(&wx->reset_lock))->count =
> +				new_rx_count;
>  		wx->tx_ring_count = new_tx_count;
>  		wx->rx_ring_count = new_rx_count;
>  

[Severity: Medium]
Does wx->reset_lock actually exclude any writer of wx->tx_ring[] and
wx->rx_ring[]?

As far as I can tell the only writers of those slots are the
rcu_assign_pointer() calls in wx_alloc_q_vector() and wx_free_q_vector(),
reached through wx_init_interrupt_scheme()/wx_clear_interrupt_scheme() from
probe, PM, ndo_setup_tc and the SR-IOV reinit path.  All of those hold RTNL
and none of them take reset_lock.

The same function then calls wx_set_ring(), which declares the opposite lock
for the identical slots:

	if (new_tx_count != wx->tx_ring_count) {
		for (i = 0; i < wx->num_tx_queues; i++) {
			memcpy(&temp_ring[i],
			       rcu_dereference_protected(wx->tx_ring[i],
							 lockdep_rtnl_is_held()),

ngbe_set_ringparam() and txgbe_set_ringparam() carry the same reset_lock
annotation.  Would it be better to annotate these as RTNL (or
RTNL-or-reset_lock with the rule spelled out next to the array definition in
struct wx), so that the assertion can actually catch an unsynchronized
caller?

The commit message also states:

    4. Use rcu_dereference_protected() in control paths guarded by locks
       (e.g., RTNL or reset_lock).

which reads as if either lock were sufficient for these arrays.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd9..bbd670504b276 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1700,6 +1700,7 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
>  	unsigned int r_idx = skb->queue_mapping;
>  	struct wx *wx = netdev_priv(netdev);
>  	struct wx_ring *tx_ring;
> +	u16 num_tx_queues;
>  
>  	if (!netif_carrier_ok(netdev)) {
>  		dev_kfree_skb_any(skb);
> @@ -1712,9 +1713,18 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
>  	if (skb_put_padto(skb, 17))
>  		return NETDEV_TX_OK;
>  
> -	if (r_idx >= wx->num_tx_queues)
> -		r_idx = r_idx % wx->num_tx_queues;
> -	tx_ring = wx->tx_ring[r_idx];
> +	num_tx_queues = READ_ONCE(wx->num_tx_queues);
> +	if (unlikely(!num_tx_queues)) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +	if (r_idx >= num_tx_queues)
> +		r_idx = r_idx % num_tx_queues;
> +	tx_ring = rcu_dereference_bh(wx->tx_ring[r_idx]);
> +	if (unlikely(!tx_ring)) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
>  

[Severity: Medium]
Should the commit message mention this part?  The message describes only
annotation work, but this hunk changes the behaviour of ndo_start_xmit in two
ways.

First, the new zero-queue guard removes a divide by zero.  Before the patch
the code did:

	if (r_idx >= wx->num_tx_queues)
		r_idx = r_idx % wx->num_tx_queues;

and wx_free_q_vectors() zeroes the counter while the netdev is still
registered:

	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;
	wx->num_q_vectors = 0;

so a transmit racing with wx_clear_interrupt_scheme() (ndo_setup_tc,
shutdown/suspend, wxvf_suspend()) could hit "% 0".  With a Fixes: tag on the
patch, would it help a backporter to have the divide error named explicitly?

Second, both new paths free the skb and return NETDEV_TX_OK without bumping
any tx_dropped/tx_errors counter, so those transmits disappear silently.  Is
that intentional?

[ ... ]

> @@ -2245,10 +2261,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
>  	struct wx_ring *ring;
>  
>  	wx_for_each_ring(ring, q_vector->tx)
> -		wx->tx_ring[ring->queue_index] = NULL;
> +		rcu_assign_pointer(wx->tx_ring[ring->queue_index], NULL);
>  
>  	wx_for_each_ring(ring, q_vector->rx)
> -		wx->rx_ring[ring->queue_index] = NULL;
> +		rcu_assign_pointer(wx->rx_ring[ring->queue_index], NULL);
>  
>  	wx->q_vector[v_idx] = NULL;
>  	netif_napi_del(&q_vector->napi);

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 9454e90258d8e..9d06003259dba 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1359,8 +1360,8 @@ struct wx {
>  	u32 tx_ring_count;
>  	u32 rx_ring_count;
>  
> -	struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
> -	struct wx_ring *rx_ring[64];
> +	struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
> +	struct wx_ring __rcu *rx_ring[64];
>  	struct wx_q_vector *q_vector[64];
>  	int num_rx_pools;
>  	int num_rx_queues_per_pool;

Would it be worth adding a short comment here naming the lock that writers of
these two arrays must hold?  Right now the only documentation of that rule is
the two disagreeing rcu_dereference_protected() annotations discussed above.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69ef..93a4d7632ea8e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -17,7 +17,9 @@ int wxvf_suspend(struct device *dev_d)
>  	struct wx *wx = pci_get_drvdata(pdev);
>  
>  	netif_device_detach(wx->netdev);
> +	rtnl_lock();
>  	wx_clear_interrupt_scheme(wx);
> +	rtnl_unlock();
>  	pci_disable_device(pdev);
>  
>  	return 0;

[Severity: Medium]
Could the commit message cover the new rtnl_lock()/rtnl_unlock() calls?  They
appear here, in wxvf_resume() below, and around wx_init_interrupt_scheme() in
ngbe_probe(), txgbe_probe(), ngbevf_probe() and txgbevf_probe(), while the
message only describes RCU annotation work.

For the four probe routines the reason seems to be the new
lockdep_rtnl_is_held() assertions in wx_cache_ring_rss()/wx_cache_ring_vmdq().
The wxvf_suspend() case is less clear, since wx_clear_interrupt_scheme() ->
wx_free_q_vector() only uses rcu_assign_pointer(), which has no lockdep
requirement.  What does RTNL protect there?

[Severity: High]
This isn't a bug introduced by this patch, but since these are the lines being
touched: does wxvf_suspend() leak the per-ring resources when the VF interface
is up?

The PF shutdown path calls ngbe_close() when netif_running(), and
wxvf_close() shows the expected order:

	wxvf_down(wx);
	wx_free_irq(wx);
	wx_free_resources(wx);

wxvf_suspend() does none of that; it goes straight to
wx_clear_interrupt_scheme(), which reaches wx_free_q_vectors() ->
wx_free_q_vector():

	wx->q_vector[v_idx] = NULL;
	netif_napi_del(&q_vector->napi);
	kfree_rcu(q_vector, rcu);

The struct wx_ring objects are embedded in that q_vector, and they hold the
only pointers to tx_buffer_info/rx_buffer_info, the dma_alloc_coherent()
descriptor rings and the page_pool, so those allocations become unreachable.

The MSI-X handlers requested by wx_request_msix_irqs_vf() use dev_id ==
q_vector and are never freed here, and the DIM works are never
disable_work_sync()'d, so can a late interrupt or a pending DIM work touch the
freed q_vector across the grace period and across pci_free_irq_vectors()?

And on the wxvf_close() following a resume, would wx_free_irq() call
free_irq() on vectors that were never requested?

> @@ -36,8 +38,10 @@ int wxvf_resume(struct device *dev_d)
>  	struct wx *wx = pci_get_drvdata(pdev);
>  
>  	pci_set_master(pdev);
> +	rtnl_lock();
>  	wx_init_interrupt_scheme(wx);
>  	netif_device_attach(wx->netdev);
> +	rtnl_unlock();
>  
>  	return 0;
>  }

[Severity: Medium]
This is a pre-existing issue, but the call being wrapped here still has its
return value dropped.

If wx_init_interrupt_scheme() fails, wx_set_interrupt_capability() or the
wx_alloc_q_vectors() error path has already run:

err_out:
	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;
	wx->num_q_vectors = 0;

	while (v_idx--)
		wx_free_q_vector(wx, v_idx);

so every ring slot is NULL and the queue counts are zero.  Should
netif_device_attach() still run in that case, re-waking the transmit queues
and arming the watchdog on a device with no rings, IRQs or NAPI contexts?

And should the function still return 0, telling the PM core the resume
succeeded?  Every subsequent transmit would take the new
"!num_tx_queues"/"!tx_ring" drop paths in wx_xmit_frame().

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610c..c670f4eb2759a 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -866,7 +869,9 @@ static int ngbe_probe(struct pci_dev *pdev,
>  
>  	ngbe_init_service(wx);
>  
> +	rtnl_lock();
>  	err = wx_init_interrupt_scheme(wx);
> +	rtnl_unlock();
>  	if (err)
>  		goto err_cancel_service;
>  

[Severity: Medium]
This is a pre-existing issue and not part of the diff, but two other callers
of the same function do not check it at all.  ngbe_setup_tc() ends with:

	wx_init_interrupt_scheme(wx);

	if (netif_running(dev))
		ngbe_open(dev);

	return 0;

and txgbe_setup_tc() is identical.  Both have already destroyed the previous
interrupt scheme at that point, and wx_init_interrupt_scheme() can fail:

	ret = wx_set_interrupt_capability(wx);
	if (ret) {
		wx_err(wx, "Allocate irq vectors for failed.\n");
		return ret;
	}

Should ndo_setup_tc and ethtool -L callers be told the reconfiguration
succeeded when the device is left with num_tx_queues/num_rx_queues == 0 and
all ring slots NULL?

[Severity: Medium]
This is a pre-existing issue as well, but ngbe_resume() in the same file
tracks the error and then discards it:

	err = wx_init_interrupt_scheme(wx);
	if (!err && netif_running(netdev))
		err = ngbe_open(netdev);
	if (!err)
		netif_device_attach(netdev);
	rtnl_unlock();

	return 0;

Should the final statement be "return err", so the PM core is not told the
resume succeeded while the netdev stays detached?

> diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> index d79cf8d8484f9..aac88c77d3b85 100644
> --- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> @@ -202,7 +202,9 @@ static int ngbevf_probe(struct pci_dev *pdev,
>  	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
>  
>  	wxvf_init_service(wx);
> +	rtnl_lock();
>  	err = wx_init_interrupt_scheme(wx);
> +	rtnl_unlock();
>  	if (err)
>  		goto err_free_sw_init;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915065731.6007-1-mengyuanlou%40net-swift.com
