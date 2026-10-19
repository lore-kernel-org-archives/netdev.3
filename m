Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B8414A2F;
	Mon, 19 Oct 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415856; cv=none; b=mLQpTMG6M0wuNSvRX8UUBBOn4/QPWUxuleaK53TDM+XtipxiDww6Bi/DdElp5qMqijPynUDjOtjiiDWwK/bogc+9/js/9X12DrFfpHj6y4T9AJq641kxGH/kV2TNj/JD0lvwxqWnwhlk+OugjhImTStK+1ymKWD7/AvlbEeUA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415856; c=relaxed/simple;
	bh=ESS5sQJzOkkSis9LRLQDrWC8KynNjLxLXZB+lF08++s=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mDUtIHNz6Ozwb+6iSXrwq0B0EBhp9xws1O20VbAEQFsHTerWQfRfrK4sYA20AH43TwSBOzMt7DG5ySJZqeGAg1w5BXcxwl1O7Bdpp+dwq3tgYflH3RA8b26i1rHzNO2XdQAhZbCEqHjijIpsve/5pIAtS+KfL77fctIuWDi+ATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KDKF2q50; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KDKF2q50"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oRGOy428y2X+3xDqX+8jmbflKwqhbr4B0UgrIwV/U6I=;
	b=KDKF2q50L5ZSjauxY7RadxAen3VdkozXuCD5RdCcsKUyi4akKSDPByA8AqmQVOnsyT1QPJqd7
	+U+fh9Dml7yG/Fd1ynXtCKoJS1G+Y3LeKp8r0w8oH+wl/GD28zFw7+Caw5KpARNAhV9oHMajhBM
	kF0KIHAb4G9JRCRW72TKdl4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j7bgS0LzJz1prRD;
	Mon, 19 Oct 2026 21:17:24 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D9CFE4056E;
	Mon, 19 Oct 2026 21:17:26 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 21:17:26 +0800
Message-ID: <fa3fded3-9813-4df6-bcb8-81ba7c1f1934@huawei.com>
Date: Mon, 19 Oct 2026 21:17:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/3] net: hns3: fix interface stuck after OOM with
 full hardware rx queue
To: <netdev-bot+sashiko@kernel.org>
References: <20260915132434.1141742-3-shaojijie@huawei.com>
 <178983224859.22033.3557054515593192784@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <178983224859.22033.3557054515593192784@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/9/19 23:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 5 · Low: 1
>
> - [Medium] The changelog misdescribes the pre-patch allocation-failure
>    handling of hns3_clean_rx_ring() and hides that the patch removes the…
> - [Medium] rx_oom_cnt is exported as a per-RX-queue counter (offset
>    inside struct hns3_enet_ring, printed as rxqN_...), but the state that…
> - [Medium] The new per-RX-queue allocation-failure counter is exported as
>    a driver-private ethtool -S string (HNS3_TQP_STAT("rx_oom_cnt",…
> - [Medium] In hns3_clean_rx_ring() the newly added `if (unlikely(err ==
>    -ENOMEM)) failure = true;` (hns3_enet.c:4507-4508) poisons the pre-…
> - [Medium] hns3_oom_task() returns early when HNS3_NIC_STATE_DOWN is set
>    (hns3_enet.c:4466-4467) without ever reaching the…
> - [Low] The per-vector OOM bit is read with hns3_ring_is_oom_state() at
>    hns3_enet.c:4531 and then unconditionally re-set by…
>
> --
>
> net: hns3: fix interface stuck after OOM with full hardware rx queue
>
> This patch adds a 250ms delayed_work that re-arms NAPI for vectors whose rx
> rings hit an allocation failure, tracked in a new per-vector bitmap. It also
> changes hns3_clean_rx_ring() to always return recv_pkts and adds a new
> rx_oom_cnt ethtool counter.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index 2f3aeade558cd..0c088feae03ca 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> [ ... ]
>
>> @@ -4451,6 +4455,34 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring)
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
>> +	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
>> +		return;
> [Severity: Medium]
>
> Can this early return leave bits set in priv->oom_vector_bm forever?
>
> This is the only function that ever clears the bitmap, and the DOWN check
> returns before the test_and_clear_bit() loop. The up path does not reset it
> either, hns3_nic_net_up() only does:
>
> 	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
>
> and priv->oom_vector_bm is zeroed only when hns3_nic_alloc_vector_data()
> reallocates it, which does not happen on a plain ifdown/ifup.
>
> Bits can be set while DOWN is set: hns3_lb_check_rx_ring() in hns3_ethtool.c
> calls hns3_clean_rx_ring() during the loopback selftest with the netdev
> stopped, and a work item queued just before hns3_nic_net_stop() will run
> after DOWN is set.
>
> After the interface comes back up, the new tail test in hns3_clean_rx_ring()
>
> 	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
> 		hns3_oom_task_schedule(ring);
>
> then evaluates true on every poll of that vector, bumping rx_oom_cnt,
> re-setting the bit and re-queueing the work each time, until the work
> finally executes. Would clearing the bitmap in hns3_nic_net_up(), or
> clearing the bits before the DOWN early return, avoid that?

Yes, will be fixed in V2.

>
>> +
>> +	netif_dbg(h, rx_err, netdev, "oom napi_schedule 0x%*pb\n",
>> +		  priv->vector_num, priv->oom_vector_bm);
>> +	for (i = 0; i < priv->vector_num; i++)
>> +		if (test_and_clear_bit(i, priv->oom_vector_bm))
>> +			napi_schedule(&priv->tqp_vector[i].napi);
>> +}
>> +
>> +static void hns3_oom_task_schedule(struct hns3_enet_ring *ring)
>> +{
>> +	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
>> +
>> +	hns3_ring_stats_update(ring, rx_oom_cnt);
>> +	hns3_ring_set_oom_state(ring);
>> +	schedule_delayed_work(&priv->oom_task,
>> +			      msecs_to_jiffies(HNS3_OOM_POLL_INTERVAL_MS));
>> +}
> [Severity: Medium]
>
> Is rx_oom_cnt charged to rings that never failed an allocation?
>
> The counter lives in struct hns3_enet_ring and is exported per rx queue, but
> the state that gates the increment is per vector, since
> hns3_ring_set_oom_state() and hns3_ring_is_oom_state() index
> priv->oom_vector_bm with ring->tqp_vector->idx.
>
> One vector commonly serves several rx rings:
>
> hns3_nic_alloc_vector_data()
> 	vector_num = min_t(u16, num_online_cpus(), tqp_num);
>
> hns3_nic_init_vector_data()
> 		u16 vector_i = i % priv->vector_num;
>
> and hns3_nic_common_poll() cleans all rx rings of the vector via
> hns3_for_each_ring(ring, tqp_vector->rx_group). So after ring A fails,
> hns3_clean_rx_ring() for sibling ring B sees hns3_ring_is_oom_state(ring)
> true and calls hns3_oom_task_schedule(ring), which increments B's
> rx_oom_cnt.
>
> Since the bit stays set until the work runs about 250 ms later, does the
> same single failure get re-counted on every poll in that window, making the
> value track polling frequency rather than the number of failures?
>
> Also, hns3_nic_alloc_rx_buffers() collapses all refill errors into its
> boolean return, including the dma_mapping_error() path:
>
> hns3_map_buffer()
> 	if (unlikely(dma_mapping_error(ring_to_dev(ring), cb->dma)))
> 		return -EIO;
>
> so should a mapping failure be reported as an OOM event? Bumping the
> counter at the actual allocation failure sites instead would avoid both
> issues.

You are right on both counts. The counter increments on every poll while the bit
is set (tracking polling frequency, not failure events), and sibling rings in
N:1 vector-to-ring configs are charged for failures they did not experience.

Will be fixed in v2. The counter will increment only on the 0→1 bitmap
transition using test_and_set_bit().

>
>> +
>>   int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>>   		       void (*rx_fn)(struct hns3_enet_ring *, struct sk_buff *))
>>   {
>> @@ -4472,6 +4504,9 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>>   
>>   		/* Poll one pkt */
>>   		err = hns3_handle_rx_bd(ring);
>> +		if (unlikely(err == -ENOMEM))
>> +			failure = true;
>> +
> [Severity: Medium]
>
> Does setting failure here skip the buffer refill and the head doorbell
> write at the exit block?
>
> The only -ENOMEM reaching here comes from hns3_alloc_skb(), which leaves
> ring->skb NULL:
>
> 	if (unlikely(!skb)) {
> 		hns3_rl_err(netdev, "alloc rx skb fail\n");
> 		hns3_ring_stats_update(ring, sw_err_cnt);
>
> 		return -ENOMEM;
>
> so control goes straight to the out: label with failure already true, and
> the short circuit there never evaluates the right operand:
>
> out:
> 	/* sync head pointer before exiting, since hardware will calculate
> 	 * FBD number with head pointer
> 	 */
> 	if (unused_count > 0)
> 		failure = failure ||
> 			  hns3_nic_alloc_rx_buffers(ring, unused_count);
>
> That means the up to 15 unused descriptors are not replenished and the
> HNS3_RING_RX_RING_HEAD_REG write inside hns3_nic_alloc_rx_buffers() does not
> happen for that poll, contrary to the comment above it. Buffer refill uses
> the page_pool cache or dev_alloc_pages() rather than napi_alloc_skb(), so it
> could still have succeeded.
>
> Before this patch, failure being true at out: implied
> hns3_nic_alloc_rx_buffers() had already run and written the head pointer.
> Would setting failure after the out: block, or using a separate variable
> for the head SKB failure, keep the refill attempt?


Correct. The skipped refill targets only pre-existing empty slots. The next
NAPI poll (re-armed by the delayed work) will attempt the refill again. Under
severe memory pressure the allocation may fail anyway.

No change in v2.


>
>>   		/* Do not get FE for the packet or failed to alloc skb */
>>   		if (unlikely(!ring->skb || err == -ENXIO)) {
>>   			goto out;
>> @@ -4493,7 +4528,10 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>>   		failure = failure ||
>>   			  hns3_nic_alloc_rx_buffers(ring, unused_count);
>>   
>> -	return failure ? budget : recv_pkts;
>> +	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
>> +		hns3_oom_task_schedule(ring);
>> +
>> +	return recv_pkts;
>>   }
> [Severity: Medium]
>
> The changelog says:
>
>    "Also fix hns3_clean_rx_ring() to return recv_pkts instead of budget
>     on allocation failure, preventing NAPI busy-poll under low memory."
>
> Was the removed return really a bug? git blame attributes
> return failure ? budget : recv_pkts; to 68752b24f51a7 ("net: hns3: schedule
> the polling again when allocation fails"), which added it so that a buffer
> allocation failure reports an incomplete poll and keeps NAPI running:
>
> hns3_nic_common_poll()
> 		int rx_cleaned = hns3_clean_rx_ring(ring, rx_budget,
> 						    hns3_rx_skb);
> 		if (rx_cleaned >= rx_budget)
> 			clean_complete = false;
>
> With this change, the retry for hns3_nic_alloc_rx_buffers() failures moves
> from the very next poll to up to 250 ms later, and only if the delayed work
> actually runs. Could the changelog state that the return value change
> supersedes the recovery added by 68752b24f51a7, and that the two changes are
> now coupled, since the patch carries a Fixes: tag?
>
> Is the described deadlock also broader than what the code shows? Before this
> patch, only the napi_alloc_skb() failure in hns3_add_frag() returns -ENXIO
> with failure left false, so that was the single path that could complete
> NAPI with the ring undrained, which matches Fixes: 81ae0e0491f3. Refill
> failures kept polling.

Right — the return failure ? budget : recv_pkts was intentionally added by
68752b24f51a7 as a busy-poll recovery mechanism. The delayed_work supersedes
it; returning budget would cause the CPU spinning we're trying to avoid.

Will be fixed in v2.

>
> [Severity: Low]
>
> Is the read of the bit here and the set inside hns3_oom_task_schedule() racy
> against the work function?
>
> hns3_ring_is_oom_state() tests the bit, then hns3_ring_set_oom_state()
> unconditionally sets it again, as two separate non-atomic operations, while
> hns3_oom_task() does test_and_clear_bit() on another CPU. A poll that read
> the bit as true before the clear can set it again after the clear,
> resurrecting a request with no allocation failure behind it, so the work
> fires again 250 ms later, clears it and issues another napi_schedule().
>
> Would setting the bit only at the real allocation failure sites and gating
> this branch on failure alone, so that hns3_oom_task() is the only writer
> that clears and nobody re-sets without a failure, remove the resurrection
> cycle? Making the state per ring instead of per vector would have the same
> effect.

This race does exist. The worst-case effect is one spurious napi_schedule()
call, which is harmless. Acceptable given the simplicity of the per-vector
bitmap design.

No change in v2.

>
>>   
>>   static void hns3_update_rx_int_coalesce(struct hns3_enet_tqp_vector *tqp_vector)
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
>> index 933e3527ed824..27a09629cbcab 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
> [ ... ]
>
>> @@ -711,6 +714,20 @@ static inline unsigned int hns3_page_order(struct hns3_enet_ring *ring)
>>   #define hns3_rl_usec_to_reg(int_rl) ((int_rl) >> 2)
>>   #define hns3_rl_round_down(int_rl) round_down(int_rl, 4)
>>   
>> +static inline void hns3_ring_set_oom_state(struct hns3_enet_ring *ring)
>> +{
>> +	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
>> +
>> +	set_bit(ring->tqp_vector->idx, priv->oom_vector_bm);
>> +}
>> +
>> +static inline bool hns3_ring_is_oom_state(struct hns3_enet_ring *ring)
>> +{
>> +	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
>> +
>> +	return test_bit(ring->tqp_vector->idx, priv->oom_vector_bm);
>> +}
>> +
>>   void hns3_ethtool_set_ops(struct net_device *netdev);
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> index e7318f2363157..392653635bda2 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> @@ -62,6 +62,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
>>   	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
>>   	HNS3_TQP_STAT("frag_alloc_err", frag_alloc_err),
>>   	HNS3_TQP_STAT("frag_alloc", frag_alloc),
>> +	HNS3_TQP_STAT("rx_oom_cnt", rx_oom_cnt),
>>   };
> [Severity: Medium]
>
> Should this new per-rx-queue allocation failure counter go through the
> standard netlink queue statistics instead of a private ethtool -S string?
>
> struct netdev_queue_stats_rx in include/net/netdev_queues.h already has:
>
> 	u64 alloc_fail;
>
> exposed as rx-alloc-fail and documented in
> Documentation/netlink/specs/netdev.yaml as "Number of times skb or buffer
> allocation failed on the Rx datapath. Allocation failure may, or may not
> result in a packet drop...", which matches what rx_oom_cnt counts.
>
> hns3 has no netdev_stat_ops/get_queue_stats_rx implementation today, so this
> adds a driver-private string for a counter category that
> Documentation/networking/statistics.rst assigns to netdev generic netlink.
> Would implementing get_queue_stats_rx() and filling stats->alloc_fail be
> preferable to adding the ethtool string?

Agreed in principle — struct netdev_queue_stats_rx.alloc_fail is the right
interface. Introducing get_queue_stats_rx() touches the statistics reporting
infrastructure and feels out of scope for this targeted fix.

No change in v2.



