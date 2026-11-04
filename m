Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793816;
	b=UBKmRsWuev2p4ouS8L/KqjgABKC9nnnjZqD1R8JLJI+EYks0jQ/zDrlIWeJSwo4cjyud
	 2sooSIAe0FwyLOiin1F4YTWqYJ4TLH8oEZUh5tEPNHewwaf3gcane8BEFHAFs89NNdBlV
	 B2O6Hq41kHpCQo+JV56vwBW1blp3KicMndfkE5r3EIPBRNMMZPv6X5TlnzVGUxPE3+f1v
	 IF0CccbUDwkh0tYsSR/SVxI3BqkA0T32SMYIfB6fn5RB81qeTDrH9B1T1/tEhbothv1Ma
	 5dRYetc4gilqa7GZMhPbYwMWOYuCmz+UE7nQfsXdeSypiUYn8P/S+067Gxwvl/dArgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793816;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=l57276igouuRQJAjLj8Sb/hMkbh0i0sCSRUMRL6Irbw=;
	b=rCDGgANd5/D+556O3dV1PMaIEqTULVAQRQYTQghxVtZlHGycXLkeAH3c0X285beUH+dD
	 nJm8dEhyrfsxcEoOtaAq/5p80G0zSqLCURC2jg0l09Rje8vn+8WSbKkFfn8Kx13MvyP0A
	 zp5KYFNrZFBsqzqYK64eQRyJ7jbpZdm3LeEwtVSTncRKkDg3MFSjUJ3oKcX8vJCvuj+US
	 U9eTizfnijKHopG91GALt2bw3edJ+9H4nIN1W/JiXvh6hoCNsBjUFbFbGiAv/1ghy7y05
	 BXr0BXVeEuWnNYHviu6l/1EgA3IGztINOcExlLZAIp42pGaYgFBjCcun2pf8uJw6i6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="G/11QUp7";
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED6606A31B;
	Wed,  4 Nov 2026 12:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1ED6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G/11QUp7
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l57276igouuRQJAjLj8Sb/hMkbh0i0sCSRUMRL6Irbw=;
	b=G/11QUp7QiM2J/Nqm+ndy7Wzdj5Q/BB0Us2d16yl4vx/MB/a38TVyrPomqzDWflvwoB2H5XxE
	DD70O3ICBNoDY/bqv8iw8jZwNu27HUSm3hkY9lV3YTnTP71HvBVM6mzCUmJfJRKlQ8sUud6daYu
	TE/OUw6nZ7u9ld4bEjvDHz4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jKPGh5PWJznTXW;
	Wed,  4 Nov 2026 20:03:24 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 871CB4055B;
	Wed,  4 Nov 2026 20:03:23 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 4 Nov 2026 20:03:22 +0800
Message-ID: <9f74e163-b1cf-4957-8fef-06b11824903d@huawei.com>
Date: Wed, 4 Nov 2026 20:03:21 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net 3/4] net: hns3: fix interface stuck after OOM with
 full hardware rx queue
To: <netdev-bot+sashiko@kernel.org>
References: <20261030095633.377289-4-shaojijie@huawei.com>
 <179370110851.488856.11507275405301229461@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <179370110851.488856.11507275405301229461@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/11/3 18:18, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 · High: 2 · Medium: 2 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] hns3_set_ringparam() (ethtool -G) calls hns3_init_all_ring() on
>    a live, already-initialised priv and never calls…
> - [High] priv->oom_task is cancelled in only one place,
>    hns3_nic_net_down().
> - [Medium] Stale OOM bits survive an ifdown/ifup.
> - [Medium] net: hns3: rx_oom_cnt in ethtool -S duplicates
>    netdev_queue_stats_rx
> - [Low] In hns3_clean_rx_ring(), the patch now sets `failure = true` when
>    hns3_handle_rx_bd() returns -ENOMEM.
>
> --
>
> net: hns3: fix interface stuck after OOM with full hardware rx queue
>
> This commit adds a 250ms delayed_work (oom_task) and a per-RX-ring bitmap
> so that NAPI is rescheduled for rings that hit an allocation failure,
> instead of depending on hardware RX interrupts. hns3_clean_rx_ring() now
> returns recv_pkts instead of budget on failure, and a new rx_oom_cnt
> ethtool counter is added.
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index 024d435ab62b6..2aa491095736c 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> [ ... ]
>
>> @@ -857,6 +859,7 @@ static void hns3_nic_net_down(struct net_device *netdev)
>>   	const struct hnae3_ae_ops *ops;
>>   
>>   	hns3_disable_irqs_and_tqps(netdev);
>> +	cancel_delayed_work_sync(&priv->oom_task);
> [Severity: Medium]
> Do stale OOM bits carry over into the next ifup?
>
> Suppose oom_task is still pending here because NAPI set a bit less than
> 250ms earlier. cancel_delayed_work_sync() removes the work without running
> it, so the HNS3_NIC_STATE_DOWN branch of hns3_oom_task() never runs its
> bitmap_zero().
>
> hns3_nic_net_stop(), hns3_nic_net_open() and hns3_nic_net_up() never
> touch rx_ring_oom_bm. Only hns3_init_all_ring() and hns3_uninit_all_ring()
> do.
>
> So after the next ifup, the first hns3_clean_rx_ring() on that ring sees
> hns3_ring_is_oom_state() return true. It then queues recovery work and a
> napi_schedule() even though no allocation failed.
>
> The next real OOM on that ring is also not counted in rx_oom_cnt, because
> test_and_set_bit() in hns3_ring_set_oom_state() finds the bit already set.
>
> Would a bitmap_zero(priv->rx_ring_oom_bm, h->kinfo.num_tqps) right after
> this cancel close the gap? A stale bit is also one way the self-test path
> below can queue oom_task on a stopped device.

Acknowledged. Will add bitmap_zero(rx_ring_oom_bm) after the
cancel in hns3_nic_net_down() in v4.

>
> [ ... ]
>
>> @@ -4451,6 +4455,35 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring)
>>   	return 0;
>>   }
>>   
>> +static void hns3_oom_task(struct work_struct *work)
>> +{
>> +	struct hns3_nic_priv *priv = container_of(work, struct hns3_nic_priv,
>> +						  oom_task.work);
>> +	struct net_device *netdev = priv->netdev;
>> +	struct hnae3_handle *h = priv->ae_handle;
>> +	u16 i;
>> +
>> +	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
>> +		bitmap_zero(priv->rx_ring_oom_bm, h->kinfo.num_tqps);
>> +		return;
>> +	}
>> +
>> +	netif_dbg(h, rx_err, netdev, "rx ring oom bitmap: 0x%*pb\n",
>> +		  h->kinfo.num_tqps, priv->rx_ring_oom_bm);
>> +	for (i = 0; i < h->kinfo.num_tqps; i++)
>> +		if (test_and_clear_bit(i, priv->rx_ring_oom_bm))
>> +			napi_schedule(&priv->ring[i].tqp_vector->napi);
>> +}
>> +
>> +static void hns3_oom_task_schedule(struct hns3_enet_ring *ring)
>> +{
>> +	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
>> +
>> +	hns3_ring_set_oom_state(ring);
>> +	schedule_delayed_work(&priv->oom_task,
>> +			      msecs_to_jiffies(HNS3_OOM_POLL_INTERVAL_MS));
>> +}
> [Severity: High]
> Can this work be queued after hns3_nic_net_down() has already run its
> cancel, which is the only one?
>
> The ethtool offline self-test (ethtool -t <dev> offline) polls RX rings
> outside of NAPI. It does this after ndo_stop(), or on an interface that
> was never opened, so HNS3_NIC_STATE_DOWN is set in both cases:
>
> hns3_self_test()
>    hns3_lp_run_test()
>      hns3_lb_check_rx_ring()
>        preempt_disable();
>        hns3_clean_rx_ring(ring, budget, hns3_lb_check_skb_data);
>        preempt_enable();
>
> hns3_clean_rx_ring() now reaches hns3_oom_task_schedule() on any RX
> allocation failure. It also gets there whenever a stale bit is set in
> rx_ring_oom_bm.
>
> Neither hns3_lp_down() nor hns3_selftest_restore() cancels the work, so
> it can still be pending when the device is torn down.
>
> For a reset, hns3_reset_notify_uninit_enet() skips hns3_nic_net_stop()
> when HNS3_NIC_STATE_DOWN is set:
>
> 	if (!test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
> 		hns3_nic_net_stop(netdev);
> 	...
> 	hns3_uninit_all_ring(priv);
>
> That frees rx_ring_oom_bm and sets it to NULL. When the work then fires,
> it takes the HNS3_NIC_STATE_DOWN branch of hns3_oom_task() above and calls
> bitmap_zero() on a NULL bitmap.
>
> If reset re-init runs first, hns3_nic_init_vector_data() calls
> INIT_DELAYED_WORK() on a delayed_work whose timer is still pending.
>
> For unload, hns3_client_uninit() on a down device goes through
> unregister_netdev() without ndo_stop(), and then does:
>
> 	hns3_uninit_all_ring(priv);
>
> 	hns3_put_ring_config(priv);
>
> out_netdev_free:
> 	hns3_dbg_uninit(handle);
> 	free_netdev(netdev);
>
> Does anything cancel priv->oom_task before free_netdev() frees the priv
> that embeds it?
>
> If the interface was running before the test, hns3_selftest_restore()
> calls ndo_open() while the work may still be pending or running.
>
> A worker that has already seen HNS3_NIC_STATE_DOWN set can then clear a
> bit that NAPI set after the reopen. The OOM recovery for that ring is then
> lost.
>
> The later patches in this series don't appear to add a cancel on any of
> these paths. Would a cancel_delayed_work_sync(&priv->oom_task) be needed
> in the teardown paths and after the self-test RX polling?

Confirmed v3 regression. v2 had cancel_delayed_work_sync() at the
top of hns3_nic_uninit_vector_data(); v3 dropped it. v4 will
restore it. oom_task does not hold rtnl or dbg_mutex, so a
synchronous cancel is safe.

>
> [ ... ]
>
>> @@ -4472,6 +4505,9 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>>   
>>   		/* Poll one pkt */
>>   		err = hns3_handle_rx_bd(ring);
>> +		if (unlikely(err == -ENOMEM))
>> +			failure = true;
>> +
>>   		/* Do not get FE for the packet or failed to alloc skb */
>>   		if (unlikely(!ring->skb || err == -ENXIO)) {
>>   			goto out;
> [ ... ]
>
>> @@ -4493,7 +4529,10 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>>   		failure = failure ||
>>   			  hns3_nic_alloc_rx_buffers(ring, unused_count);
> [Severity: Low]
> Now that failure is set to true when hns3_handle_rx_bd() returns -ENOMEM,
> does this short-circuit skip the final refill?
>
> The only -ENOMEM source is napi_alloc_skb() failing in hns3_alloc_skb().
> That also leaves ring->skb NULL, so the loop takes goto out.
>
> At out, failure is already true. hns3_nic_alloc_rx_buffers() is therefore
> never called, and its writel() to HNS3_RING_RX_RING_HEAD_REG is skipped.
>
> Before this patch, failure was still false on this path, so the refill and
> the head pointer sync that the comment above asks for always ran.
>
> Now the cleaned BDs stay withheld from hardware until the next poll, which
> can be up to 250ms later via oom_task. That includes reuse_flag BDs that
> need no allocation at all.
>
> Would writing it this way always attempt the refill?

Acknowledged, v2 carry-over. Not addressed in this series.

>
> 	failure = hns3_nic_alloc_rx_buffers(ring, unused_count) || failure;
>
>>   
>> -	return failure ? budget : recv_pkts;
>> +	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
>> +		hns3_oom_task_schedule(ring);
>> +
>> +	return recv_pkts;
>>   }
> [ ... ]
>
>> @@ -5193,6 +5233,10 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
>>   	int i, j;
>>   	int ret;
>>   
>> +	priv->rx_ring_oom_bm = bitmap_zalloc(h->kinfo.num_tqps, GFP_KERNEL);
>> +	if (!priv->rx_ring_oom_bm)
>> +		return -ENOMEM;
> [Severity: High]
> hns3_init_all_ring() is also called from hns3_set_ringparam() on a priv
> that is already initialized, and there is no matching
> hns3_uninit_all_ring():
>
> hns3_set_ringparam() {
> 	...
> 	ret = hns3_init_all_ring(priv);
> 	if (ret) {
> 		...
> 		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
> 			memcpy(&priv->ring[i], &tmp_rings[i],
> 			       sizeof(struct hns3_enet_ring));
> 	} else {
> 		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
> 			hns3_fini_ring(&tmp_rings[i]);
> 	}
> 	...
> 	if (if_running)
> 		ret = ndev->netdev_ops->ndo_open(ndev);
> }
>
> On success, does this leak the previous rx_ring_oom_bm? The pointer is
> overwritten here and nothing frees the old allocation.
>
> On failure, priv->rx_ring_oom_bm ends up NULL. Either bitmap_zalloc()
> failed, or a hns3_alloc_ring_memory() failure took the error path, which
> now does:
>
> 	bitmap_free(priv->rx_ring_oom_bm);
> 	priv->rx_ring_oom_bm = NULL;
> 	return -ENOMEM;
>
> The revert path in hns3_set_ringparam() only copies the ring structs back
> and then reopens the device. The next RX poll goes:
>
> hns3_nic_common_poll()
>    hns3_clean_rx_ring()
>      hns3_ring_is_oom_state()
>        test_bit(ring->queue_index, priv->rx_ring_oom_bm);
>
> failure is normally false at that point, so wouldn't this dereference a
> NULL bitmap? If the interface was down during ethtool -G, the same thing
> happens on the next ifup.
>
> The comment in hns3_init_tx_spare_buffer() says hns3_init_all_ring() is
> called from hns3_set_ringparam() with live state that is restored on
> failure. Could the bitmap be allocated outside hns3_init_all_ring(),
> somewhere hns3_set_ringparam() does not re-enter?
>
> The later patch in this series, "net: hns3: fix use-after-free in debugfs
> read during reset/unload", only adds dbg_mutex around this code and does
> not address it.

Confirmed v3 regression. In v2 the bitmap was allocated in
hns3_nic_alloc_vector_data(), which set_ringparam() does not call.
v3 moved it to hns3_init_all_ring(), so ethtool -G re-allocates
it: old bitmap leaks on success, NULL-deref on failure after ring
restore. v4 will back up and restore rx_ring_oom_bm across the
hns3_init_all_ring() call in hns3_set_ringparam().

>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> @@ -62,6 +62,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
>>   	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
>>   	HNS3_TQP_STAT("frag_alloc_err", frag_alloc_err),
>>   	HNS3_TQP_STAT("frag_alloc", frag_alloc),
>> +	HNS3_TQP_STAT("rx_oom_cnt", rx_oom_cnt),
>>   };
>>   
>>   #define HNS3_PRIV_FLAGS_LEN ARRAY_SIZE(hns3_priv_flags)
> [Severity: Medium]
> Does this counter need to be a private ethtool -S string?
>
> Per-queue RX allocation failures already have a standard uAPI. struct
> netdev_queue_stats_rx has an alloc_fail member. It is reported as
> rx-alloc-fail through the netdev netlink family when the driver
> provides netdev_stat_ops->get_queue_stats_rx().
>
> Documentation/networking/statistics.rst asks drivers not to add
> counters to ethtool -S when they fit an existing standard category.
> Once this string is in hns3_rxq_stats[], userspace starts to depend on
> it, and it is hard to remove later.
>
> hns3_ring_set_oom_state() only increments rx_oom_cnt when the ring's
> bit in rx_ring_oom_bm goes from 0 to 1. So it counts OOM episodes
> rather than individual failures. That is not quite what alloc_fail
> means, but it is still a per-queue RX allocation failure count.
>
> Could the driver implement get_queue_stats_rx() and report alloc_fail
> per ring instead? The value could come from this counter or from the
> existing failure sites in hns3_alloc_skb(), hns3_add_frag() and
> hns3_nic_alloc_rx_buffers().
>
> If the per-episode count is really needed to debug the oom_task
> recovery, could the changelog explain why the standard counter is not
> enough?

Acknowledged, v2 carry-over. Not addressed in this series.




