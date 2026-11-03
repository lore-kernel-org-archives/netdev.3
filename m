Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701110;
	b=EOYfByq8vcbJ5NUrGC9MMqFJ9fMhzOmyWuJll5cubb0fKGk0q0qIpbkvwAvoIu0hgaTb
	 CrbgFnEluugzZ7iygEkli2rb0+G8NADtBI7nJaj6Zm7QgXxICFDBE7oC4wokR6MbZ2G/d
	 zBO+NfWS+oZf5y6bPt54gmNo1Dpaf7pmOBoTX3dkALTcgMQBtgVZXJdHkQyX9i9AymKpb
	 +vOuLO/ek7g/hcPlSrCRvTtwERs9rZlaXf3putvV7MMgKDjkpEGnsxTWWhOEpLoxHO11l
	 A5EFBKGzPkcr51FRPd1DiVIb533SXN+FBGhMq3w0UapNwzMyyYGu1JwMUhQJM5i45gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701110;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/WrTRJTJyDL5yO49DfTGKrFvY1pAjJDpAMlRs7MEfus=;
	b=WyiLEwe2MuRFW5rfsFlUMT0z3428nC+1KBTO9F3iIPNkdN9XT76bPKcnp5uMHlIVxqHk
	 qylBRLl74FdjG9HOusQPb470gOlsbM8xSIvw4CuUwy8dnlkqobdD5c3PtqN7LsN+DeWPa
	 SoC0BHOWQ0Qcs0If1nIEr6Hj7LT3YUMUE5+3vYzh29hsX2RfEB6SsdVMrI922qKlhCTSL
	 CnXWbnd/6haOjVYPrqFUgLiFCxi0JxluuRp8saOQMk9/eJHlCylI4wdhwqdkJWmmPYRWc
	 j0Fubz6UnTxZ2APPXRXsGZP2smIVv22O9PTeg639L7o0uczeTS698ASk9z+7tAm9aeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TavMdk52;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B36082BDD;
	Tue,  3 Nov 2026 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TavMdk52
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C11F00A02;
	Tue,  3 Nov 2026 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701109;
	bh=/WrTRJTJyDL5yO49DfTGKrFvY1pAjJDpAMlRs7MEfus=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TavMdk52mkYKNcFihy92gi6ynOuTothI404oxWqRPGXp/pP4AxZrbXlsdsrbzp0Eb
	 wn24xNBica/LPNQugt/KboZr4NJ5qk0uHuLmjkR5WOSPiJqxZK5ciXx5hIXy4wn6tB
	 iZk0JawKTE0ziWCGt/YGLyjqEeDoazJutAnEE99kr1OfKXDq7gxyFMgDqJRXVGh3iV
	 s6uDN947XrtjNMuA1F45t5uUFq3RUJGL2AWqh3vrORUvnecBVO2149i5gd/CtqFFsW
	 Zy8r5c1TRY9ieyyMS5FWqHpwREa1KkjdK/lwGnHXrCsEMWexQu/XYYmWjQ5P+KM/E6
	 aKAFlFfCBlifA==
Subject: Re: [PATCH v3 net 3/4] net: hns3: fix interface stuck after OOM with
 full hardware rx queue
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:18:28 +0000
Message-ID: <179370110851.488856.11507275405301229461@kernel.org>
In-Reply-To: <20261030095633.377289-4-shaojijie@huawei.com>
References: <20261030095633.377289-4-shaojijie@huawei.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] hns3_set_ringparam() (ethtool -G) calls hns3_init_all_ring() on
  a live, already-initialised priv and never calls…
- [High] priv->oom_task is cancelled in only one place,
  hns3_nic_net_down().
- [Medium] Stale OOM bits survive an ifdown/ifup.
- [Medium] net: hns3: rx_oom_cnt in ethtool -S duplicates
  netdev_queue_stats_rx
- [Low] In hns3_clean_rx_ring(), the patch now sets `failure = true` when
  hns3_handle_rx_bd() returns -ENOMEM.

--

net: hns3: fix interface stuck after OOM with full hardware rx queue

This commit adds a 250ms delayed_work (oom_task) and a per-RX-ring bitmap
so that NAPI is rescheduled for rings that hit an allocation failure,
instead of depending on hardware RX interrupts. hns3_clean_rx_ring() now
returns recv_pkts instead of budget on failure, and a new rx_oom_cnt
ethtool counter is added.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 024d435ab62b6..2aa491095736c 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c

[ ... ]

> @@ -857,6 +859,7 @@ static void hns3_nic_net_down(struct net_device *netdev)
>  	const struct hnae3_ae_ops *ops;
>  
>  	hns3_disable_irqs_and_tqps(netdev);
> +	cancel_delayed_work_sync(&priv->oom_task);

[Severity: Medium]
Do stale OOM bits carry over into the next ifup?

Suppose oom_task is still pending here because NAPI set a bit less than
250ms earlier. cancel_delayed_work_sync() removes the work without running
it, so the HNS3_NIC_STATE_DOWN branch of hns3_oom_task() never runs its
bitmap_zero().

hns3_nic_net_stop(), hns3_nic_net_open() and hns3_nic_net_up() never
touch rx_ring_oom_bm. Only hns3_init_all_ring() and hns3_uninit_all_ring()
do.

So after the next ifup, the first hns3_clean_rx_ring() on that ring sees
hns3_ring_is_oom_state() return true. It then queues recovery work and a
napi_schedule() even though no allocation failed.

The next real OOM on that ring is also not counted in rx_oom_cnt, because
test_and_set_bit() in hns3_ring_set_oom_state() finds the bit already set.

Would a bitmap_zero(priv->rx_ring_oom_bm, h->kinfo.num_tqps) right after
this cancel close the gap? A stale bit is also one way the self-test path
below can queue oom_task on a stopped device.

[ ... ]

> @@ -4451,6 +4455,35 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring)
>  	return 0;
>  }
>  
> +static void hns3_oom_task(struct work_struct *work)
> +{
> +	struct hns3_nic_priv *priv = container_of(work, struct hns3_nic_priv,
> +						  oom_task.work);
> +	struct net_device *netdev = priv->netdev;
> +	struct hnae3_handle *h = priv->ae_handle;
> +	u16 i;
> +
> +	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
> +		bitmap_zero(priv->rx_ring_oom_bm, h->kinfo.num_tqps);
> +		return;
> +	}
> +
> +	netif_dbg(h, rx_err, netdev, "rx ring oom bitmap: 0x%*pb\n",
> +		  h->kinfo.num_tqps, priv->rx_ring_oom_bm);
> +	for (i = 0; i < h->kinfo.num_tqps; i++)
> +		if (test_and_clear_bit(i, priv->rx_ring_oom_bm))
> +			napi_schedule(&priv->ring[i].tqp_vector->napi);
> +}
> +
> +static void hns3_oom_task_schedule(struct hns3_enet_ring *ring)
> +{
> +	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
> +
> +	hns3_ring_set_oom_state(ring);
> +	schedule_delayed_work(&priv->oom_task,
> +			      msecs_to_jiffies(HNS3_OOM_POLL_INTERVAL_MS));
> +}

[Severity: High]
Can this work be queued after hns3_nic_net_down() has already run its
cancel, which is the only one?

The ethtool offline self-test (ethtool -t <dev> offline) polls RX rings
outside of NAPI. It does this after ndo_stop(), or on an interface that
was never opened, so HNS3_NIC_STATE_DOWN is set in both cases:

hns3_self_test()
  hns3_lp_run_test()
    hns3_lb_check_rx_ring()
      preempt_disable();
      hns3_clean_rx_ring(ring, budget, hns3_lb_check_skb_data);
      preempt_enable();

hns3_clean_rx_ring() now reaches hns3_oom_task_schedule() on any RX
allocation failure. It also gets there whenever a stale bit is set in
rx_ring_oom_bm.

Neither hns3_lp_down() nor hns3_selftest_restore() cancels the work, so
it can still be pending when the device is torn down.

For a reset, hns3_reset_notify_uninit_enet() skips hns3_nic_net_stop()
when HNS3_NIC_STATE_DOWN is set:

	if (!test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
		hns3_nic_net_stop(netdev);
	...
	hns3_uninit_all_ring(priv);

That frees rx_ring_oom_bm and sets it to NULL. When the work then fires,
it takes the HNS3_NIC_STATE_DOWN branch of hns3_oom_task() above and calls
bitmap_zero() on a NULL bitmap.

If reset re-init runs first, hns3_nic_init_vector_data() calls
INIT_DELAYED_WORK() on a delayed_work whose timer is still pending.

For unload, hns3_client_uninit() on a down device goes through
unregister_netdev() without ndo_stop(), and then does:

	hns3_uninit_all_ring(priv);

	hns3_put_ring_config(priv);

out_netdev_free:
	hns3_dbg_uninit(handle);
	free_netdev(netdev);

Does anything cancel priv->oom_task before free_netdev() frees the priv
that embeds it?

If the interface was running before the test, hns3_selftest_restore()
calls ndo_open() while the work may still be pending or running.

A worker that has already seen HNS3_NIC_STATE_DOWN set can then clear a
bit that NAPI set after the reopen. The OOM recovery for that ring is then
lost.

The later patches in this series don't appear to add a cancel on any of
these paths. Would a cancel_delayed_work_sync(&priv->oom_task) be needed
in the teardown paths and after the self-test RX polling?

[ ... ]

> @@ -4472,6 +4505,9 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>  
>  		/* Poll one pkt */
>  		err = hns3_handle_rx_bd(ring);
> +		if (unlikely(err == -ENOMEM))
> +			failure = true;
> +
>  		/* Do not get FE for the packet or failed to alloc skb */
>  		if (unlikely(!ring->skb || err == -ENXIO)) {
>  			goto out;

[ ... ]

> @@ -4493,7 +4529,10 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>  		failure = failure ||
>  			  hns3_nic_alloc_rx_buffers(ring, unused_count);

[Severity: Low]
Now that failure is set to true when hns3_handle_rx_bd() returns -ENOMEM,
does this short-circuit skip the final refill?

The only -ENOMEM source is napi_alloc_skb() failing in hns3_alloc_skb().
That also leaves ring->skb NULL, so the loop takes goto out.

At out, failure is already true. hns3_nic_alloc_rx_buffers() is therefore
never called, and its writel() to HNS3_RING_RX_RING_HEAD_REG is skipped.

Before this patch, failure was still false on this path, so the refill and
the head pointer sync that the comment above asks for always ran.

Now the cleaned BDs stay withheld from hardware until the next poll, which
can be up to 250ms later via oom_task. That includes reuse_flag BDs that
need no allocation at all.

Would writing it this way always attempt the refill?

	failure = hns3_nic_alloc_rx_buffers(ring, unused_count) || failure;

>  
> -	return failure ? budget : recv_pkts;
> +	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
> +		hns3_oom_task_schedule(ring);
> +
> +	return recv_pkts;
>  }

[ ... ]

> @@ -5193,6 +5233,10 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
>  	int i, j;
>  	int ret;
>  
> +	priv->rx_ring_oom_bm = bitmap_zalloc(h->kinfo.num_tqps, GFP_KERNEL);
> +	if (!priv->rx_ring_oom_bm)
> +		return -ENOMEM;

[Severity: High]
hns3_init_all_ring() is also called from hns3_set_ringparam() on a priv
that is already initialized, and there is no matching
hns3_uninit_all_ring():

hns3_set_ringparam() {
	...
	ret = hns3_init_all_ring(priv);
	if (ret) {
		...
		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
			memcpy(&priv->ring[i], &tmp_rings[i],
			       sizeof(struct hns3_enet_ring));
	} else {
		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
			hns3_fini_ring(&tmp_rings[i]);
	}
	...
	if (if_running)
		ret = ndev->netdev_ops->ndo_open(ndev);
}

On success, does this leak the previous rx_ring_oom_bm? The pointer is
overwritten here and nothing frees the old allocation.

On failure, priv->rx_ring_oom_bm ends up NULL. Either bitmap_zalloc()
failed, or a hns3_alloc_ring_memory() failure took the error path, which
now does:

	bitmap_free(priv->rx_ring_oom_bm);
	priv->rx_ring_oom_bm = NULL;
	return -ENOMEM;

The revert path in hns3_set_ringparam() only copies the ring structs back
and then reopens the device. The next RX poll goes:

hns3_nic_common_poll()
  hns3_clean_rx_ring()
    hns3_ring_is_oom_state()
      test_bit(ring->queue_index, priv->rx_ring_oom_bm);

failure is normally false at that point, so wouldn't this dereference a
NULL bitmap? If the interface was down during ethtool -G, the same thing
happens on the next ifup.

The comment in hns3_init_tx_spare_buffer() says hns3_init_all_ring() is
called from hns3_set_ringparam() with live state that is restored on
failure. Could the bitmap be allocated outside hns3_init_all_ring(),
somewhere hns3_set_ringparam() does not re-enter?

The later patch in this series, "net: hns3: fix use-after-free in debugfs
read during reset/unload", only adds dbg_mutex around this code and does
not address it.

[ ... ]

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -62,6 +62,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
>  	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
>  	HNS3_TQP_STAT("frag_alloc_err", frag_alloc_err),
>  	HNS3_TQP_STAT("frag_alloc", frag_alloc),
> +	HNS3_TQP_STAT("rx_oom_cnt", rx_oom_cnt),
>  };
>  
>  #define HNS3_PRIV_FLAGS_LEN ARRAY_SIZE(hns3_priv_flags)

[Severity: Medium]
Does this counter need to be a private ethtool -S string?

Per-queue RX allocation failures already have a standard uAPI. struct
netdev_queue_stats_rx has an alloc_fail member. It is reported as
rx-alloc-fail through the netdev netlink family when the driver
provides netdev_stat_ops->get_queue_stats_rx().

Documentation/networking/statistics.rst asks drivers not to add
counters to ethtool -S when they fit an existing standard category.
Once this string is in hns3_rxq_stats[], userspace starts to depend on
it, and it is hard to remove later.

hns3_ring_set_oom_state() only increments rx_oom_cnt when the ring's
bit in rx_ring_oom_bm goes from 0 to 1. So it counts OOM episodes
rather than individual failures. That is not quite what alloc_fail
means, but it is still a per-queue RX allocation failure count.

Could the driver implement get_queue_stats_rx() and report alloc_fail
per ring instead? The value could come from this counter or from the
existing failure sites in hns3_alloc_skb(), hns3_add_frag() and
hns3_nic_alloc_rx_buffers().

If the per-episode count is really needed to debug the oom_task
recovery, could the changelog explain why the standard counter is not
enough?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030095633.377289-1-shaojijie%40huawei.com
