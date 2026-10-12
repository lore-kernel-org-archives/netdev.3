Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041F48EBC5;
	Mon, 12 Oct 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825590; cv=none; b=hckzaxksOwA44eosHkEKAOQNu9nI2JAbSZqfmF2ppRkjWJHBG0PWb5aRTKcFJh6mOB4grJ0kMtqqgOiBrpXgHHjCs5s1bH2FM+odshYx5IP/WgvELOmrd/DAI4G9+6XC93VQZK5flFo41JCV1p2r0Z7Ge1cw2bFlkvUCSztlPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825590; c=relaxed/simple;
	bh=4qUcr0qTenisD18TVuFES5obRPPVDR82BpQapAPcCCU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMpCFHKA/uXsk0w4OJO7qNLEp0GW2OvdfFUaFM380rc8ewF+WyoV2ifD6crgYLTYtkbMUyHCqanVQfEGA4YtNAFz5t1gk0YgFchxWr0ItEZv12dD/2WYRBcz8B0f9hI09eNODIYGPzTjTrGROnz23hMSZAcjnqqUFLtuxfRU+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDpjMqte; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDpjMqte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAD21F0089C;
	Mon, 12 Oct 2026 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825588;
	bh=W8nzKHZeRQ3lBDX3WHX6H5mmwgueCYe3aSG3qXouAfc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DDpjMqteKeW6B6VK4Dn8IF0twUVSE4c8S7AUgH/j9hwj17FWebuhtk4hfMPIeg+l1
	 xCQg/iusdARSAH0c2EUdW3SPRSuX/NeiiribT0z9ZNyn/wl47yjn83X1Tx6yHz/Lb9
	 BDUZwG/vCSAH5vfH9lLsuydlA3G5c3WoZNmyrnl+p39/nt5WUULxxP7wIbsfqpbjuK
	 llBWFfhM1m43UBQzTVwTXhxXyPrpctSC7/27b0U0wgva5oS66N9NSx+OPUhKMjaVjc
	 uOuUVYaFDewcBvuHSv+iL+/zlX61OeMqTYJnwwGeOuiTmTUhHBW5aJpcjm2QPIURC3
	 ad4NllfNvoz8Q==
Subject: Re: [PATCH net-next V2 2/5] net/mlx5: nodnic: Implement data path
From: netdev-bot+sashiko@kernel.org
To: tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 cjubran@nvidia.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
 shshitrit@nvidia.com, leon@kernel.org, mbloch@nvidia.com, saeedm@nvidia.com,
 dtatulea@nvidia.com, horms@kernel.org
Date: Mon, 12 Oct 2026 17:19:47 +0000
Message-ID: <179182558716.434549.11018514583239999958@kernel.org>
In-Reply-To: <20261008171821.660739-3-tariqt@nvidia.com>
References: <20261008171821.660739-3-tariqt@nvidia.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 6 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mlx5_nodnic_activate_queues() (en_cfg.c) calls
  napi_enable_locked() first.
- [High] mlx5_nodnic_deactivate_queues() (en_cfg.c, added in this patch)
  calls mlx5_nodnic_disable_port() only if…
- [High] TX stop/wake between mlx5_nodnic_xmit() and
  mlx5_nodnic_complete_send_wqe() uses plain, unannotated sq->cc/sq->pc…
- [Medium] mlx5_nodnic_handle_err_cqe()
  (drivers/net/ethernet/mellanox/mlx5/nodnic/en.c) handles…
- [Medium] mlx5_nodnic_napi_poll() (en.c) does not handle budget == 0.
- [Medium] In mlx5_nodnic_napi_poll() (en.c), when '++tx_work_done >=
  MLX5_NODNIC_TX_CQ_POLL_BUDGET' (128) the loop jumps to poll_done while…
- [Medium] The CQ consumer-index doorbell record (cq->dbr.db[0], set_ci)
  is written only in mlx5_nodnic_arm_cq(), which runs only after…
- [Medium] mlx5_nodnic_handle_recv_cqe() (rx.c) passes the device-
  reported byte_cnt to page_pool_dma_sync_for_cpu() and skb_put()…
- [Medium] mlx5_nodnic_enable_port() makes three separate PORT_NETWORK
  writes: data/event MSI-X enable, then network_en plus…

--

net/mlx5: nodnic: Implement data path

This commit implements the TX and RX data paths for the mlx5_nodnic driver.
It adds WQE posting with a BlueFlame doorbell, page pool backed RX, and a
single NAPI context that dispatches TX and RX CQEs. It also wires up
ndo_start_xmit and ndo_features_check and enables TX/RX checksum offload.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.c
> new file mode 100644
> index 0000000000000..3572aff50194f
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.c

[ ... ]

> +static void mlx5_nodnic_handle_err_cqe(struct mlx5_nodnic_cq *cq,
> +				       struct mlx5_cqe64 *cqe64,
> +				       int napi_budget)
> +{

[ ... ]

> +	netdev_err(priv->netdev,
> +		   "%s CQE error: syndrome=0x%02x (%s), vendor_syndrome=0x%02x, wqe_counter=%u, cq_ci=%d\n",
> +		   queue_type,
> +		   syndrome, mlx5_nodnic_cqe_err_syndrome_str(syndrome),
> +		   vendor_syndrome, wqe_counter, cq->cc);
> +
> +	print_hex_dump(KERN_ERR, "mlx5_nodnic err CQE: ", DUMP_PREFIX_OFFSET,
> +		       16, 1, err_cqe, sizeof(*err_cqe), false);
> +
> +	if (opcode == OPCODE_CQ_SEND_ERR) {
> +		struct mlx5_nodnic_sq *sq = &priv->sq;
> +		u16 sq_pi = mlx5_nodnic_sq_get_pi(sq, wqe_counter);
> +
> +		mlx5_nodnic_complete_send_wqe(sq, &sq->wqe_info[sq_pi],
> +					      napi_budget);
> +	} else {
> +		struct mlx5_nodnic_rq *rq = &priv->rq;
> +		u16 ci = wqe_counter & (rq->ring.num_entries - 1);
> +
> +		mlx5_nodnic_release_rx_wqe(rq, ci);
> +	}
> +}

[Severity: Medium]
Is there a recovery path for the SQ or RQ after an error CQE?

mlx5_nodnic_handle_err_cqe() calls netdev_err() and does a 64 byte
print_hex_dump() at KERN_ERR. Neither is rate limited. It then completes or
releases the one WQE named by wqe_counter and carries on. Nothing stops,
resets or recovers the queue.

The driver decodes MLX5_CQE_SYNDROME_WR_FLUSH_ERR, so it seems to expect
mlx5 flush-after-error behaviour. If so, one non-flush error (for example
LOCAL_LENGTH_ERR) would make every later TX WQE come back as a flush error.

mlx5_nodnic_napi_poll() also reposts every released RX WQE through
mlx5_nodnic_rq_post_wqes(). An errored RQ would flush them straight back.

Could one hardware error then become a flood of KERN_ERR output from
softirq context? TX and RX would stay dead until the interface is bounced,
while the queue and carrier still look up.

[ ... ]

> +int mlx5_nodnic_napi_poll(struct napi_struct *napi, int budget)
> +{

[ ... ]

> +	while (true) {
> +		cqe = mlx5_nodnic_cq_get_cqe(cq);
> +		if (!cqe)
> +			break;
> +
> +		result = mlx5_nodnic_handle_cqe(cq, cqe, budget);
> +		switch (result) {
> +		case MLX5_NODNIC_CQE_TX:
> +			if (++tx_work_done >= MLX5_NODNIC_TX_CQ_POLL_BUDGET)
> +				goto poll_done;
> +			break;
> +		case MLX5_NODNIC_CQE_RX:
> +			if (++rx_work_done >= budget)
> +				goto poll_done;
> +			break;

[Severity: Medium]
Does this poll handle budget == 0? netpoll calls it with a zero budget:

net/core/netpoll.c:poll_one_napi() {
    ...
	work = napi->poll(napi, 0);
    ...
}

The next CQE is fully handled before the budget is checked.

For an RX CQE, mlx5_nodnic_handle_recv_cqe() calls
page_pool_dma_sync_for_cpu(), napi_build_skb() and napi_gro_receive(). For
an RX error CQE, mlx5_nodnic_release_rx_wqe() calls
page_pool_put_full_page() with allow_direct set to true.

Only after that does ++rx_work_done >= budget exit the loop. poll_done then
always calls mlx5_nodnic_rq_post_wqes(), which allocates from the page pool.

Documentation/networking/napi.rst says that with a zero budget only TX
completions should be processed, and page pool and RX APIs must not be
used.

With netconsole on this netdev, netpoll can run from hardirq or printk
context. Can this path then touch the page pool's lockless cache, the
per-CPU NAPI skb cache and GRO? Could those get corrupted if it interrupts
a softirq user on the same CPU?

> +		case MLX5_NODNIC_CQE_IGNORED:
> +			break;
> +		}
> +	}
> +
> +poll_done:
> +	if (!mlx5_nodnic_rq_post_wqes(priv))
> +		return budget;
> +
> +	if (rx_work_done >= budget)
> +		return budget;

[Severity: Medium]
On both return budget paths, does the device ever see an updated CQ
consumer index?

The CQ doorbell record consumer index is only written in
mlx5_nodnic_arm_cq():

	cq->dbr.db[0] = cpu_to_be32(ci);

That only runs after napi_complete_done() succeeds.

Under sustained RX that fills the budget on every pass, NAPI never
completes. cq->cc keeps advancing in software, but db[0] keeps the value
from the last arm.

Meanwhile mlx5_nodnic_rq_post_wqes() keeps reposting RX WQEs based on the
software rq->cc. mlx5_nodnic_complete_send_wqe() keeps freeing SQ slots
and waking TX.

Suppose the device uses set_ci for CQ overrun detection like other mlx5
devices. Could it then see more outstanding CQEs than the CQ size and
report an overrun or stall, even though software has consumed every entry?

For comparison, mlx5e updates the CQ doorbell record with
mlx5_cqwq_update_db_record() at the end of every poll pass.

> +
> +	if (napi_complete_done(napi, rx_work_done))
> +		mlx5_nodnic_arm_cq(cq);
> +
> +	return rx_work_done;
> +}

[Severity: Medium]
When the loop exits because tx_work_done reached
MLX5_NODNIC_TX_CQ_POLL_BUDGET, more CQEs may still be pending:

		case MLX5_NODNIC_CQE_TX:
			if (++tx_work_done >= MLX5_NODNIC_TX_CQ_POLL_BUDGET)
				goto poll_done;

Suppose the RQ refill succeeds and rx_work_done < budget. This path then
calls napi_complete_done(), re-arms the CQ and returns less than budget,
even though polling stopped with work left.

Should this return budget instead, as mlx5e does when its TX poll hits its
limit?

As written, the remaining TX completions, and any RX CQEs behind them,
depend on the device raising an event when armed with unconsumed CQEs. If
it only signals on new CQE writes, TX completions could stall with the SQ
stopped. There is no ndo_tx_timeout to recover.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
> index 5724ed41d8b89..9657c43e9958f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c

[ ... ]

> @@ -573,6 +643,143 @@ void mlx5_nodnic_refresh_carrier(struct mlx5_nodnic_priv *priv)

[ ... ]

> +static int mlx5_nodnic_activate_queues(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
> +	int err;
> +
> +	napi_enable_locked(&cq->napi);
> +
> +	mlx5_nodnic_init_cqes_ownership(cq);
> +
> +	err = mlx5_nodnic_activate_rq(dev);
> +	if (err)
> +		goto err_napi;
> +
> +	err = mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx);
> +	if (err)
> +		goto err_rq;
> +
> +	err = mlx5_nodnic_enable_port(dev);
> +	mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
> +	if (err)
> +		goto err_rq;

[Severity: Medium]
If mlx5_nodnic_enable_port() fails after its first or second write, is the
port left partly enabled?

mlx5_nodnic_enable_port() makes three separate PORT_NETWORK writes: MSI-X
enable, then network_en plus receive_filter_en, then dma_en. It returns
early on failure and does not roll back.

This unwind goes to err_rq without calling mlx5_nodnic_disable_port().
mlx5_nodnic_open_locked() then reaches:

err_close:
	clear_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
	mlx5_nodnic_close_queues(dev);

That frees the rings, DBRs and working buffer, but their addresses are
still programmed in the device.

The dma_en write might take effect but still be reported as failed, for
example on a VSC flag-wait timeout. Could the device then DMA into freed
memory?

mlx5_nodnic_disable_port() also notes that data_msix_en and event_msix_en
can't be modified while the port is active. Could the leftover state make
the first enable_port write on the next open ineffective?

> +
> +	mlx5_nodnic_arm_cq(cq);
> +	napi_schedule(&cq->napi);
> +
> +	mlx5_nodnic_activate_sq(dev);
> +
> +	return 0;
> +
> +err_rq:
> +	mlx5_nodnic_deactivate_rq(dev);
> +err_napi:
> +	napi_disable_locked(&cq->napi);
> +
> +	return err;
> +}

[Severity: High]
Is this unwind order safe?

mlx5_nodnic_activate_rq() creates the page pool with
.napi = &priv->cq.napi. On the err_rq path, mlx5_nodnic_deactivate_rq()
frees rq->pages and calls page_pool_destroy() while NAPI is still enabled.
Only after that does err_napi call napi_disable_locked(). The
err_destroy_page_pool path inside mlx5_nodnic_activate_rq() has the same
problem.

page_pool_destroy() reaches this check through
page_pool_disable_direct_recycling()->napi_assert_will_not_race():

	WARN_ON(!test_bit(NAPI_STATE_SCHED, &napi->state));

napi_enable_locked() has already cleared that bit. So wouldn't any open
failure after page_pool_create() hit this WARN? That covers RX page
allocation, VSC acquire and enable_port failures. The pool is also torn
down without synchronizing against a running poll.

mlx5_nodnic_deactivate_queues() uses the other order: it calls
napi_disable_locked() before mlx5_nodnic_deactivate_rq().

A related question is why napi_enable_locked() runs first. It comes before
mlx5_nodnic_init_cqes_ownership(), before mlx5_nodnic_activate_rq() sets up
rq->page_pool and rq->pages, and before mlx5_nodnic_activate_sq() sets
sq->txq.

napi_enable_locked()->napi_restore_config() re-hashes the napi_id kept from
the previous session. A busy-polling socket can then call
mlx5_nodnic_napi_poll() straight away, without the netdev or state lock.

On reopen, rq->pages still points at the array freed by
mlx5_nodnic_rq_free_pages() during the previous close:

	kvfree(rq->pages);

rq->page_pool still points at the pool destroyed then, and open_rq has
reset rq->pc and rq->cc to 0. Can
mlx5_nodnic_rq_post_wqes()->mlx5_nodnic_rq_post_one() then read
rq->pages[pi] and call page_pool_dev_alloc_pages(rq->page_pool) on freed
memory?

Before the ownership init runs, the zeroed CQ ring has op_own == 0. That
matches software ownership 0 and opcode OPCODE_CQ_SEND. Would a poll in
that window complete a bogus send through wqe_info[0] and push sq->cc past
sq->pc?

> +
> +static void mlx5_nodnic_deactivate_queues(struct mlx5_nodnic_core_dev *dev)
> +{
> +	if (!mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx)) {
> +		mlx5_nodnic_disable_port(dev);
> +		mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
> +	}
> +
> +	mlx5_nodnic_deactivate_sq(&dev->priv->sq);
> +	napi_disable_locked(&dev->priv->cq.napi);
> +	mlx5_nodnic_deactivate_rq(dev);
> +}

[Severity: High]
What happens to the device if mlx5_nodnic_vsc_context_acquire() fails here?

Acquire can fail with -EBUSY when the gateway semaphore is still held after
VSC_MAX_RETRIES in mlx5_nodnic_vsc_gw_lock(). It can also fail with
-EACCES, or when setting the space fails. In all of these cases
mlx5_nodnic_disable_port() is skipped. Even when it is called, it returns
void and only warns if its read or write of PORT_NETWORK fails.

Either way teardown continues. mlx5_nodnic_deactivate_rq() returns the
device-owned RX pages to the page pool and destroys it.
mlx5_nodnic_close_queues() then frees the coherent memory:

	mlx5_nodnic_free_ring(dev, &priv->working_buffer);
	mlx5_nodnic_close_cq(&priv->cq);
	mlx5_nodnic_close_rq(dev);
	mlx5_nodnic_close_sq(dev);
	mlx5_nodnic_free_dbr(dev, &priv->dbr);

At that point the device still has network_en and dma_en set and the ring
and DBR addresses programmed. Its RX WQEs still point at the freed pages.

Can an incoming packet then be DMA-written into pages that are back in the
page allocator? Can the device keep fetching the freed SQ ring and doorbell
records?

Even when the disable write succeeds, nothing reads back or waits for
in-flight DMA to drain.

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
> new file mode 100644
> index 0000000000000..7736a1f24ea5b
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c

[ ... ]

> +void mlx5_nodnic_handle_recv_cqe(struct mlx5_nodnic_cq *cq,
> +				 struct mlx5_cqe64 *cqe)
> +{

[ ... ]

> +	u32 byte_count = be32_to_cpu(cqe->byte_cnt);

[ ... ]

> +	page_pool_dma_sync_for_cpu(rq->page_pool, page, 0, byte_count);
> +
> +	skb = napi_build_skb(page_address(page), PAGE_SIZE);
> +	if (unlikely(!skb))
> +		goto err_recycle;
> +
> +	skb_mark_for_recycle(skb);
> +	rq->pages[ci] = NULL;
> +
> +	skb_reserve(skb, MLX5_NODNIC_SKB_HEADROOM_BYTES);
> +	skb_put(skb, byte_count);

[Severity: Medium]
This is mostly a hardening question. byte_count comes straight from the
CQE and is passed to page_pool_dma_sync_for_cpu() and skb_put(). It is
never checked against the posted buffer size (MLX5_NODNIC_HW_MTU) or the
skb tailroom.

A CQE with byte_cnt above roughly PAGE_SIZE - NET_SKB_PAD minus the
skb_shared_info size would hit skb_over_panic()->BUG().

This needs a buggy or misbehaving device. Every RX WQE is posted with
byte_count = MLX5_NODNIC_HW_MTU, mlx5-family hardware normally reports
oversize frames as LOCAL_LENGTH_ERR, and the mlx5e linear RX path doesn't
check this either. Would a cheap bound check here still be worthwhile?

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
> new file mode 100644
> index 0000000000000..f2efc8d3f5b85
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c

[ ... ]

> +static int mlx5_nodnic_tx_is_sq_full(struct mlx5_nodnic_sq *sq)
> +{
> +	u16 pending = (u16)(sq->pc - sq->cc);
> +
> +	return pending == sq->ring.num_entries - MLX5_NODNIC_SQ_STOP_ROOM;
> +}

[ ... ]

> +netdev_tx_t mlx5_nodnic_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{

[ ... ]

> +	if (unlikely(mlx5_nodnic_tx_is_sq_full(sq)))
> +		netif_tx_stop_queue(sq->txq);
> +
> +	next_offset = mlx5_nodnic_tx_get_next_sq_offset(sq);
> +
> +	wqe = (struct mlx5_nodnic_tx_wqe *)((u8 *)sq->ring.wq + next_offset);
> +
> +	err = mlx5_nodnic_tx_write_wqe(sq, skb, wqe);
> +	if (err) {
> +		dev_kfree_skb_any(skb);
> +
> +		return NETDEV_TX_OK;
> +	}

[Severity: High]
Is the stop/wake handshake between mlx5_nodnic_xmit() and
mlx5_nodnic_complete_send_wqe() safe on weakly ordered CPUs?

sq->pc and sq->cc use plain loads and stores with no barriers. xmit does
not re-check after stopping, and the full test only matches
pending == num_entries - 1.

When pending == N - 1, xmit stops the queue and still posts, which leaves
the ring full (pending == N). NAPI then does:

	sq->cc++;

	if (netif_tx_queue_stopped(txq))
		netif_tx_wake_queue(txq);

On the next xmit, nothing orders the load of sq->cc after the observation
that XOFF was cleared. On arm64 or POWER that load can return the old cc.
pending is then N, the == N - 1 check fails, and the queue is not stopped.
That post uses the slot just freed, so the ring is now truly full with the
queue still running.

The xmit after that again sees pending == N and does not stop. It writes
the WQE and wqe_info at pc & (N - 1), the slot of the oldest WQE the
hardware still owns.

Can this corrupt an in-flight descriptor, lose its skb and DMA mapping, and
let pc run past cc + N?

On the completion side, cc++ followed by test_bit() of XOFF has no full
barrier to pair with xmit's load of cc followed by set_bit().

The dma mapping failure path above also returns after netif_tx_stop_queue()
without posting anything. With that path in the mix, could the queue end up
stopped with nothing outstanding to wake it?

netif_txq_maybe_stop() and netif_txq_completed_wake() in
include/net/netdev_queues.h provide the smp_mb(), a >= test and the
re-check. Would they fit here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008171821.660739-1-tariqt%40nvidia.com
