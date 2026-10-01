Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812B4A5C49
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866646; cv=none; b=qAho7ki/pEmXpg9B7DSt4VZaHHQKbZPyPRRU7CjtGYbKnzW+q55W1mF2Pj7rl8Vs1/E6Zq5jXSJrBWKtJSp39GhjL4gcoBPUTCCqyWngGQvXcQUvhup5c/ju82RLL3u+5tm7aUPAohAWuvDUmEXamCR6KF3nl78N+xf4bzWdKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866646; c=relaxed/simple;
	bh=IU3x95AVHCNQ2IPfoAbzl9xPOW5hs4deCdgSO6e3Ugw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9LeL+6ddclmPJ2GcTITZMXqHY/B2izXcIR8pnPPISet4Mhb0SQmnDTIStHnZGkEUFa7tefWXY3fHAlHyrgXHEU1Q9QuuKVW7hc2H5gOYiLaSDpbaAqjrcA6oC4Wl2dMdCVzNZ24oCuRW4YrMDlpG/Py6YvFQ4MvIvXjqvwVLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjT1KGJF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjT1KGJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726771F000FF;
	Thu,  1 Oct 2026 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790866644;
	bh=TKorFNQiGdNVXAq9lADKC3Dz2QKEHq1gIupr5bOnFuo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NjT1KGJFFKO/3ccjvSCmOrs9yoXhef39ljMAsUQVCS15pak+tBewVhYsqOHkAcSiX
	 Qj/UGvx+Be1Tn+YxtvStVNrHmhWC6fgGj6fgrr0tqZFcM6ccn/ITKL2pAkHk1Em9Rx
	 IL2fQw9/WuRJ1d1QGFL2uYGOvOyh974NPAQfrMaGmTGNtuYepiKpa990a+1J7CjTEN
	 nD5phtBrXeHt1Fs3fCVPkJE3VZn/oeb4qkSD6de33pHU+mCgadXHFLlXGC6OqHmLki
	 Vy4AJ80MJO8wRMgW9SsbZl9CAxvdWnUXgX/XE5MeR1PbDekhDZXuywCInQieU1wN8s
	 CV2aZP8aQe+jA==
Subject: Re: [PATCH net v7] net: wangxun: protect ring accesses with RCU
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 Oct 2026 14:57:22 +0000
Message-ID: <179086664298.434549.9799301627011029213@kernel.org>
In-Reply-To: <20260928085443.14595-1-mengyuanlou@net-swift.com>
References: <20260928085443.14595-1-mengyuanlou@net-swift.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] wxvf_suspend() takes RTNL around wx_clear_interrupt_scheme().
- [Low] The new comment in wxvf_suspend() and the matching commit-message
  text give the wrong rationale for the RTNL section.
- [Low] wx_xmit_frame() now reads wx->num_tx_queues with READ_ONCE()
  because the read races with reconfiguration.
- [Low] wx_alloc_q_vector() publishes each ring with
  rcu_assign_pointer(wx->tx_ring[]/rx_ring[], ring) while ring->reg_idx…

Pre-existing issues:
- [High] wxvf_resume() leaves a running VF interface in a state where the
  first transmit oopses.
- [Medium] This problem wasn't introduced by this patch, but a failed
  interrupt-scheme initialization leaves positive queue counts with NULL…
- [Medium] This problem wasn't introduced by this patch, but
  ngbe_set_ringparam() and txgbe_set_ringparam() throw away the return…
- [Low] This problem wasn't introduced by this patch, but no ring's
  u64_stats_sync (ring->syncp) is ever initialized with…

--

net: wangxun: protect ring accesses with RCU

This patch annotates the wx->tx_ring[] and wx->rx_ring[] arrays with
__rcu. Lockless readers move to rcu_dereference() under rcu_read_lock()
with NULL checks, and control paths move to rtnl_dereference().

RTNL is now taken around interrupt scheme init/teardown in the probe and
VF suspend/resume paths. wx_xmit_frame() drops and accounts packets when
the queue count is zero or the ring slot is NULL.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 940d2e59876c..2307149b07fd 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -154,8 +154,9 @@ void wx_get_ethtool_stats(struct net_device *netdev,
>  		}
>  	}
>  
> +	rcu_read_lock();
>  	for (j = 0; j < netdev->num_tx_queues; j++) {
> -		ring = wx->tx_ring[j];
> +		ring = rcu_dereference(wx->tx_ring[j]);
>  		if (!ring) {
>  			data[i++] = 0;
>  			data[i++] = 0;

[Severity: Low]
This isn't a bug introduced by this patch, but is ring->syncp ever
initialized? The loop below calls u64_stats_fetch_begin(&ring->syncp).
I couldn't find a u64_stats_init() call anywhere under
drivers/net/ethernet/wangxun/, and the rings come from kzalloc_flex() in
wx_alloc_q_vector().

On 32-bit kernels with CONFIG_DEBUG_LOCK_ALLOC, zero-filling does not set
up the seqcount's lockdep map. Could these readers, the ones in
wx_get_stats64() and the NAPI writers trigger lockdep warnings?

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index dcbf5811046e..cd0e5382ab75 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c

[ ... ]

> @@ -1733,11 +1732,22 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
>  	if (skb_put_padto(skb, 17))
>  		return NETDEV_TX_OK;
>  
> -	if (r_idx >= wx->num_tx_queues)
> -		r_idx = r_idx % wx->num_tx_queues;
> -	tx_ring = wx->tx_ring[r_idx];
> +	num_tx_queues = READ_ONCE(wx->num_tx_queues);
> +	if (unlikely(!num_tx_queues))
> +		goto drop;

[Severity: Low]
This READ_ONCE() has no matching marked store. wx_free_q_vectors() does:

	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;

The following also write the count without WRITE_ONCE():

  wx_set_num_queues()
  wx_set_rss_queues()
  wx_set_vmdq_queues()
  the wx_alloc_q_vectors() error path
  the VF set_num_queues callbacks

The other lockless readers converted by this patch use
num_tx_queues/num_rx_queues as plain loop bounds: wx_get_stats64(),
wx_update_stats(), wx_ring_tx_pending(), wx_detect_tx_hang(),
wx_ptp_rx_hang() and wx_update_xoff_rx_lfc().

With only one side marked, would KCSAN still report this race?

Also, struct wx declares "int num_tx_queues;", but the local here is u16.
Should the local use the same type as the field?

[ ... ]

> @@ -2238,7 +2248,7 @@ static int wx_alloc_q_vector(struct wx *wx,
>  		ring->queue_index = rxr_idx;
>  
>  		/* assign ring to wx */
> -		wx->rx_ring[rxr_idx] = ring;
> +		rcu_assign_pointer(wx->rx_ring[rxr_idx], ring);

[Severity: Low]
The ring is published here while ring->reg_idx is still 0 from
kzalloc_flex(). The real reg_idx is only written afterwards, with plain
stores, by wx_cache_ring_rss()/wx_cache_ring_vmdq().

This patch turns wx_vlan_strip_control() into a lockless RCU reader:

	struct wx_ring *ring = rcu_dereference(wx->rx_ring[i]);
	...
	j = ring->reg_idx;
	wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
	      enable ? WX_PX_RR_CFG_VLAN : 0);

It is reached from wx_set_rx_mode(), which the core calls under
netif_addr_lock_bh without RTNL. During ngbe_setup_tc()/txgbe_setup_tc()
the device stays IFF_UP, because ngbe_close()/txgbe_close() are called
directly.

Can a concurrent rx-mode update see a newly published ring with reg_idx 0?
If so, it would read-modify-write queue 0's RR_CFG while the RTNL path is
configuring that queue.

The release in rcu_assign_pointer() does not cover fields written after
publication. So the contract described in wx_type.h does not seem to hold
for reg_idx. The ordering itself predates this patch, but the patch now
describes these readers as safe lockless RCU readers.

[ ... ]

> @@ -3057,7 +3067,7 @@ static int wx_setup_all_tx_resources(struct wx *wx)
>  	int i, err = 0;
>  
>  	for (i = 0; i < wx->num_tx_queues; i++) {
> -		err = wx_setup_tx_resources(wx->tx_ring[i]);
> +		err = wx_setup_tx_resources(rtnl_dereference(wx->tx_ring[i]));

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens here if an
earlier wx_init_interrupt_scheme() call failed?

wx_init_interrupt_scheme() sets num_rx_queues/num_tx_queues first. It then
returns early if wx_set_interrupt_capability() fails:

	ret = wx_set_interrupt_capability(wx);
	if (ret) {
		wx_err(wx, "Allocate irq vectors for failed.\n");
		return ret;
	}

That leaves positive queue counts with no rings allocated.
ngbe_setup_tc() and txgbe_setup_tc() ignore the return value:

	wx_init_interrupt_scheme(wx);

	if (netif_running(dev))
		ngbe_open(dev);

So ngbe_open()->wx_setup_resources()->wx_setup_all_tx_resources() passes
a NULL ring to wx_setup_tx_resources(), which then dereferences
tx_ring->dev.

wxvf_resume() also ignores the error and returns 0, so a later wxvf_open()
would hit the same NULL ring. Should these callers check the result, or
should wx_init_interrupt_scheme() reset the queue counts on failure?

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..acacf3b35aa5 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -17,7 +17,14 @@ int wxvf_suspend(struct device *dev_d)
>  	struct wx *wx = pci_get_drvdata(pdev);
>  
>  	netif_device_detach(wx->netdev);
> +	/* wx_clear_interrupt_scheme() only clears the ring slots with
> +	 * rcu_assign_pointer(), so RTNL is not needed for the ring arrays
> +	 * here; it serializes this teardown against the VF reset subtask,
> +	 * which rebuilds the same interrupt scheme under RTNL.
> +	 */

[Severity: Low]
Is this rationale accurate?

wxvf_reinit_locked() calls wxvf_down(), wx_free_irq(), wx_configure_vf(),
wx_request_msix_irqs_vf() and wxvf_up_complete(). It never calls
wx_init_interrupt_scheme() or wx_clear_interrupt_scheme().

wx_configure_vf()->wx_configure_tx_vf()/wx_configure_rx_vf() read the ring
arrays with rtnl_dereference() and no NULL check. The rings live inside
q_vectors that are freed with kfree_rcu().

wx_type.h now says "Control-path readers use rtnl_dereference() while
holding RTNL". Under that contract, isn't RTNL exactly what protects those
ring array readers from this teardown?

The commit message gives the same reasoning:

  wxvf_suspend() takes RTNL around wx_clear_interrupt_scheme() as well,
  not for the ring arrays but to serialize the teardown against the VF
  reset subtask, which rebuilds the same interrupt scheme under RTNL.

Could the comment and the commit message be corrected?

> +	rtnl_lock();
>  	wx_clear_interrupt_scheme(wx);
> +	rtnl_unlock();
>  	pci_disable_device(pdev);

[Severity: High]
RTNL stops the teardown and wxvf_reset_subtask() from running at the same
time. Does it stop wxvf_reset_subtask() from running after the teardown?

wxvf_suspend() does not set WX_STATE_DOWN or WX_STATE_RESETTING. It does
not stop wx->service_timer, and wx_service_timer() re-arms every 2s while
wx_service_event_schedule() only checks DOWN. It also does not cancel
wx->service_task.

wxvf_watchdog_update_link() can set WX_FLAG_NEED_DO_RESET on a mailbox
error. Suppose the service task is then blocked in rtnl_lock() in
wxvf_reset_subtask() while suspend holds RTNL. Once it gets the lock, it
only checks:

	if (test_bit(WX_STATE_RESETTING, wx->state) ||
	    test_bit(WX_STATE_DOWN, wx->state)) {

It then calls wxvf_reinit_locked() on the torn-down scheme.

By then pci_free_irq_vectors() has cleared pdev->msix_enabled.
wx_free_irq() therefore takes the INTx path and frees pdev->irq, which was
never requested. wx_request_msix_irqs_vf() then skips the queue loop
(num_q_vectors == 0) and does:

	err = request_irq(wx->msix_entry->vector, wx_msix_misc_vf,
			  0, netdev->name, wx);

wx_reset_interrupt_capability() has already set wx->msix_entry to NULL.

Can this NULL dereference happen from the service workqueue after
suspend? The same path would also do mailbox and MMIO access to a disabled
PCI function.

Does this need WX_STATE_DOWN set, and the timer and work cancelled, before
the teardown?

> @@ -36,8 +43,13 @@ int wxvf_resume(struct device *dev_d)
>  	struct wx *wx = pci_get_drvdata(pdev);
>  
>  	pci_set_master(pdev);
> +	/* wx_init_interrupt_scheme() reaches rtnl_dereference() through
> +	 * wx_cache_ring_rss(), which requires RTNL.
> +	 */
> +	rtnl_lock();
>  	wx_init_interrupt_scheme(wx);
>  	netif_device_attach(wx->netdev);
> +	rtnl_unlock();

[Severity: High]
This isn't a bug introduced by this patch, but after resume, will the
first transmit on a running VF interface oops?

wxvf_suspend() tears down the interrupt scheme without the wxvf_down(),
wx_free_irq() and wx_free_resources() calls that wxvf_close() makes. As a
result:

  The per-vector IRQ handlers (dev_id = q_vector) stay installed while
  wx_free_q_vector() kfree_rcu()s the q_vector and pci_free_irq_vectors()
  runs.

  NAPI and the hardware queues are not quiesced.

  The descriptor DMA memory, tx/rx_buffer_info, headwb memory and
  page_pool leak.

wxvf_resume() then calls only wx_init_interrupt_scheme(), ignoring its
return value, and netif_device_attach(). The new rings from kzalloc_flex()
have desc and tx_buffer_info set to NULL. They are published, but
wx_setup_resources(), wx_configure_vf(), wx_request_msix_irqs_vf() and
wxvf_up_complete() never run.

netif_running() is still true, so netif_device_attach() wakes all TX
queues, and carrier was never turned off. wx_xmit_frame() passes the new
num_tx_queues and NULL ring checks and calls wx_xmit_frame_ring(), which
does:

	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
	first->skb = skb;

At this point tx_buffer_info is NULL. The new check in wx_xmit_frame()
only catches cleared slots, not published rings that have no resources
behind them.

Should wxvf_suspend() and wxvf_resume() close and reopen the interface
when it is running?

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index 1960f7154151..2997a93f786c 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -37,9 +37,9 @@ static int ngbe_set_ringparam(struct net_device *netdev,
>  
>  	if (!netif_running(wx->netdev)) {
>  		for (i = 0; i < wx->num_tx_queues; i++)
> -			wx->tx_ring[i]->count = new_tx_count;
> +			rtnl_dereference(wx->tx_ring[i])->count = new_tx_count;
>  		for (i = 0; i < wx->num_rx_queues; i++)
> -			wx->rx_ring[i]->count = new_rx_count;
> +			rtnl_dereference(wx->rx_ring[i])->count = new_rx_count;
>  		wx->tx_ring_count = new_tx_count;
>  		wx->rx_ring_count = new_rx_count;
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but further down in
ngbe_set_ringparam() the return value of wx_set_ring() is thrown away:

	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
	kvfree(temp_ring);

wx_set_ring() can fail partway. For example, wx_setup_rx_resources() can
fail after the TX rings have already been resized. ngbe_set_ringparam()
still returns 0 in that case.

txgbe_set_ringparam() does the same, while wx_set_ringparam_vf() already
returns the error. Should the PF setters return the wx_set_ring() error
as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928085443.14595-1-mengyuanlou%40net-swift.com
