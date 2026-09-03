Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E135C1BD
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404897; cv=none; b=l0iSlXrQR/Yke7rqEqKxJd5LB2dIBHhLhL1+OpHqiguxJo3gsRD2eruwDD87vwcfYh4PrMrBV/rNPUR7tCSPhC9ngk4xuvMzPGP1S7cTOENIYYyTm+KTMU3V7CnO8/2RRo0Tpw27swkU465wjFBcwApugsaxIipQudRMj0vKtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404897; c=relaxed/simple;
	bh=Y40n9YLM+RP6KIaB6uIxHdSlKdtOiVE8Z7UhXQbZo1s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvFHCsNeDNg/ZMc61dIf2ryKuq1ldQFK89s+tsmoqQ9+dOcAkNuIfRifpQhwTguxxn00Gn2FM1aUdzBLd1538UoMAclvayO96qnuiH0wcBLH0DpQaE1+ba/xySdC+NftQl9OGEdMQ9MMvTxRhwc5MEaZkYDp6swI8hEcDLMFgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMamBfwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMamBfwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1FD1F000E9;
	Thu,  3 Sep 2026 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788404893;
	bh=3Jouh/x03Sa0q7AB6QwhIixWEBFF4jE4cHKWpK4b8VA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RMamBfwySlAxTRi+SgG0RldPaqsPFOp3D791lyS6VKpqv6Hblhvt251vIImdYbXpa
	 fVDWC9+vt6YbBj/tynBy7nO3rRdBJxLLJTGU2IHS+KVSTZHRy+Oz49OvV7UNzLo2sM
	 2G1k7NKOS7j1cDdGtMpeKGgdafOGdWXokIWfXCzZD1ms92KftZvJ9UDSF1XiBmBdeM
	 C8noB+5NhPpmJS7HTag6fZ+sez/DU9lFS0rm8E3DVmWd7oAI2zcd2qtNoGPcuGDnFx
	 qWRkOO8g2hJ96Bk1HvS9rEUc4I1lR9FLfPjcPKGnBTC0GixiVo/rb5kyQDf9RFLG9L
	 phyfnpVIl/W4w==
Subject:
 Re: [net,v4] net: libwx: protect ring accesses with RCU and NULL check
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, linglingzhang@trustnetic.com,
 jiawenwu@trustnetic.com, duanqiangwen@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 03 Sep 2026 03:08:12 +0000
Message-ID: <178840489278.3394541.1727945751975594257@kernel.org>
In-Reply-To:
 <4353E83B1147D652+20260830070624.7410-1-mengyuanlou@net-swift.com>
References: <4353E83B1147D652+20260830070624.7410-1-mengyuanlou@net-swift.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

- [Medium] Commit message premise is unsubstantiated and the single
  `Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")` tag…
- [Medium] Ring pointers are published to lockless readers without
  release ordering.

Pre-existing issues:
- [Low] The loop bounds of every newly RCU-protected traversal
  (wx->num_tx_queues / wx->num_rx_queues) remain plain, unannotated…

--

net: libwx: protect ring accesses with RCU and NULL check

This converts the wx->tx_ring[]/wx->rx_ring[] traversals in the libwx
statistics, error, VLAN and PTP paths to READ_ONCE() plus a NULL check
inside rcu_read_lock()/rcu_read_unlock(), and switches the ring slot
assignment and clearing in wx_alloc_q_vector()/wx_free_q_vector() to
WRITE_ONCE().

A few questions below, first about the changelog and the Fixes tag, then
about the publish side in wx_lib.c.

> In wx_update_stats(), wx_get_ethtool_stats(), and other service tasks,
> the ring pointers wx->rx_ring[i] and wx->tx_ring[i] can become NULL or be
> freed asynchronously during queue teardown or channel reconfiguration.

[Severity: Medium]
Does this premise hold for the service task paths?

txgbe_disable_device() and ngbe_disable_device() stop the service task
synchronously:

	timer_delete_sync(&wx->service_timer);
	cancel_work_sync(&wx->service_task);

and the ring slots are only cleared afterwards, in
wx_clear_interrupt_scheme() -> wx_free_q_vectors() -> wx_free_q_vector().
So can wx_ring_tx_pending() or wx_detect_tx_hang() actually observe a slot
being cleared or a ring being freed underneath them?

The PTP aux work is similarly quiesced by wx_ptp_suspend() ->
ptp_cancel_worker_sync() before the rings go away, and
wx_get_ethtool_stats() and wx_vlan_strip_control() are reached from
RTNL-serialized callbacks (the latter only from wx_set_rx_mode()).

The one reader that does look unserialized against
wx_clear_interrupt_scheme() is wx_update_stats() reached from
wx_get_stats64() (ndo_get_stats64, e.g. a read of /proc/net/dev), which
before this patch dereferenced wx->rx_ring[i] with no NULL check. That is
the hunk the changelog does not call out. Could the message describe that
path specifically and mark the rest as hardening?

> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")

Is this tag right for most of the hunks? git blame attributes
wx_ring_tx_pending()/wx_detect_tx_hang() in wx_err.c and the tx_ring loop
in wx_update_xoff_rx_lfc() to 22d95e93c05b0, and wx_vlan_strip_control()
to f3b03c655f678. A stable backport selected on this single tag lands in
trees that have neither wx_err.c nor wx_ptp.c, so the patch cannot apply
there. Should the tag be narrowed to the wx_update_stats()/
wx_get_ethtool_stats() change that fixes the user-visible dereference?

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 122c4952d203..9e2cf794f81c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c

[ ... ]

> @@ -2893,10 +2906,13 @@ void wx_update_stats(struct wx *wx)
>  
>  	spin_lock(&wx->hw_stats_lock);
>  
> +	rcu_read_lock();
>  	/* gather some stats to the wx struct that are per queue */
>  	for (i = 0; i < wx->num_rx_queues; i++) {
> -		struct wx_ring *rx_ring = wx->rx_ring[i];
> +		struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
>  
> +		if (!rx_ring)
> +			continue;
>  		non_eop_descs += rx_ring->rx_stats.non_eop_descs;

[Severity: Low]
This is a pre-existing issue and not introduced by the patch, but the loop
bound itself stays an unannotated plain load while the reconfiguration path
writes it concurrently:

wx_free_q_vectors()
	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;
	wx->num_q_vectors = 0;

	while (v_idx--)
		wx_free_q_vector(wx, v_idx);

The count and the ring array are two independently updated variables, and
the same pattern is in wx_ring_tx_pending(), wx_detect_tx_hang() and
wx_vlan_strip_control(). Since the counts are zeroed before the slots are
cleared and the rings live in a q_vector freed with kfree_rcu(), a stale
count inside the new RCU section resolves to either a still-valid ring or a
NULL slot, so the visible effect looks limited to a partial statistics
sample or a skipped register write, but it remains a KCSAN-reportable race.
Would annotating the count loads be worth doing while the traversals are
being touched?

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd..c227e9ab8a4a 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -2191,7 +2191,7 @@ static int wx_alloc_q_vector(struct wx *wx,
>  		ring->queue_index = txr_idx;
>  
>  		/* assign ring to wx */
> -		wx->tx_ring[txr_idx] = ring;
> +		WRITE_ONCE(wx->tx_ring[txr_idx], ring);
>  
>  		/* update count and index */
>  		txr_count--;
> @@ -2217,7 +2217,7 @@ static int wx_alloc_q_vector(struct wx *wx,
>  		ring->queue_index = rxr_idx;
>  
>  		/* assign ring to wx */
> -		wx->rx_ring[rxr_idx] = ring;
> +		WRITE_ONCE(wx->rx_ring[rxr_idx], ring);

[Severity: Medium]
The v3 posting used rcu_assign_pointer() here and v4 changed it to
WRITE_ONCE(). Does that leave the newly added read side without ordering?

WRITE_ONCE() only stops the compiler from tearing or reordering this single
store, it does not emit smp_store_release(). The ring is initialized with
plain stores immediately before the publish:

		ring->dev = &wx->pdev->dev;
		ring->netdev = wx->netdev;
		ring->q_vector = q_vector;
		...
		ring->queue_index = rxr_idx;

		/* assign ring to wx */
		WRITE_ONCE(wx->rx_ring[rxr_idx], ring);

On a weakly ordered CPU, can a reader doing READ_ONCE() under
rcu_read_lock() see the non-NULL pointer before those field stores become
visible? The NULL check added by this patch does not cover that case, since
the pointer is non-NULL and only the contents are stale.

reg_idx looks like a separate hole, because wx_alloc_q_vector() never
writes it. wx_init_interrupt_scheme() sets it after the pointers are
already published:

wx_cache_ring_rss()
	for (i = 0; i < wx->num_rx_queues; i++)
		wx->rx_ring[i]->reg_idx = i;

and wx_vlan_strip_control() feeds that value straight into a register
offset:

		j = ring->reg_idx;
		wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
		      enable ? WX_PX_RR_CFG_VLAN : 0);

If wx_vlan_strip_control() can run against a freshly published ring set,
can this reprogram the VLAN strip bit of a different receive queue? Note
that switching the publish back to rcu_assign_pointer() would not close
this one, since reg_idx is written after publication.

Publication is reachable on a registered netdev through
txgbe_setup_tc()/ngbe_setup_tc() and the resume paths, concurrently with
wx_get_stats64() -> wx_update_stats(), so the statistics readers can pick
up uninitialized per-queue counters and export them to userspace.

> @@ -2245,10 +2245,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
>  	struct wx_ring *ring;
>  
>  	wx_for_each_ring(ring, q_vector->tx)
> -		wx->tx_ring[ring->queue_index] = NULL;
> +		WRITE_ONCE(wx->tx_ring[ring->queue_index], NULL);
>  
>  	wx_for_each_ring(ring, q_vector->rx)
> -		wx->rx_ring[ring->queue_index] = NULL;
> +		WRITE_ONCE(wx->rx_ring[ring->queue_index], NULL);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/4353E83B1147D652%2B20260830070624.7410-1-mengyuanlou%40net-swift.com
