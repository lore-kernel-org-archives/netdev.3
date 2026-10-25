Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932178;
	b=DX/OIA9z5dtJgwR7yipgqcNWChui5An70xUFzIIWEN2gXM3tBjDYTV81WMVSI/i6Bb9T
	 uy1fI/UkdLMYXei9CBiGW1V8j212FRqYmNmYp9fBxh1zsEzDSzwlS98nYsjuKNZ5s8i0B
	 9ebO1P0bodUdU8zG8Wh6YhpdeGGGqYQ6onrZsRoqipzIAMg3+Oxj1q4HGdh0KoK3j7K2y
	 /lraBXWXyCEWQrpJgO6j73DaiOUgAO8fb1GnpAWqB108AMInf5xsGZZRR8FMer8jqsXYV
	 6+WN2UzL+xQETf7yfsCPGx7sfoKpU9c3johpqKIXXSXPrlpI0IAtHrnLcfvFs7VUJCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932178;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Zm/oFsVOfJ0RXZ/nFSGCGMR9k9BaX9pVXws0r98TVOE=;
	b=OGemdT37kQOD5UviVXMQFh+xGwsUBQT9NSMmB3Sp6lKPyJxO/TwajKIEwBLI43s77+ou
	 iz1XRHHfkkoJc4amkdDy3Jje/BIr79A4zpmdGvL44HGRILSiOI4Rrj6zUvmyEEhmW2QXd
	 XHgRyvsx2irzEEKTTZb8/1muq34iuPpU+YCoUB6Rdm5jOKxvVhJl0m9HY6VWQfZloCTF3
	 T9L0OHNFFv9fcQsL73xjO7yu4MAPOoYrrpEYtVrMz9FeSZ7JujYkeEGSUzu2/nnfdSniI
	 0C8gyrN41D13nLyOjBMNG3MzGLsGFlN/tduKFLkE09mfDGaWEKUUHFnd0MqkpedjULQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFfm2MWc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D9606A323;
	Sun, 25 Oct 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFfm2MWc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8704E1F01828;
	Sun, 25 Oct 2026 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792932178;
	bh=Zm/oFsVOfJ0RXZ/nFSGCGMR9k9BaX9pVXws0r98TVOE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QFfm2MWczw3gK3cpbLpeS7sfMCAUt+DVqhrrg3X7WwOcPOLl7zhoayT4tY/b1KIC+
	 wF/hWnNVhJ2zXOt1CJ903+pfiJousZLia4XnCyo7x6ev57KNq35JBdvUSSr5dCh92j
	 PD/a4/WkFGJbjv3OmP7D2FSYNt5mIAn0+OCFbffRx4YCz53Mmh3UM3AC7qDxjrVE8A
	 PtSgr7hVLPr5o78FJlf0tvmxcAje1ndvsTW5jXhWshbutP2OuG8lLs5cZeOeqYHjc0
	 oaNI9LJIwYTD6+n+m912/bljKZchfCnOSMPSsXMzDa+8gEQYcmbZqlQGJ4oCK0vZkz
	 kL4bG8q9eFpvw==
Subject: Re: [PATCH v2 net 2/3] net: hns3: fix interface stuck after OOM with
 full hardware rx queue
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 12:42:57 +0000
Message-ID: <179293217710.3134.10122362985230809773@kernel.org>
In-Reply-To: <20261021121426.3096838-3-shaojijie@huawei.com>
References: <20261021121426.3096838-3-shaojijie@huawei.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a new driver-private per-RX-queue `ethtool -S`
  string, "rx_oom_cnt", to hns3_rxq_stats[] in…
- [Medium] hns3_oom_task() (hns3_enet.c:4466-4468) does `if
  (test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {…
- [Medium] net: hns3: broken per-ring rx_oom_cnt in
  hns3_ring_set_oom_state()
- [Medium] net: hns3: spurious OOM state set in
  hns3_handle_rx_copybreak()
- [Low] The patch adds `if (unlikely(err == -ENOMEM)) failure = true;` in
  hns3_clean_rx_ring() (hns3_enet.c:4508-4509), but the exit refill is…

--

net: hns3: fix interface stuck after OOM with full hardware rx queue

This patch adds a 250ms delayed_work that reschedules NAPI for vectors
whose RX rings hit allocation failures. Those vectors are tracked in a
per-vector bitmap. The patch also stops hns3_clean_rx_ring() returning
budget on allocation failure and adds an rx_oom_cnt ethtool -S counter.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 2f3aeade558cd..09f688893aab1 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c

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
> +		bitmap_zero(priv->oom_vector_bm, priv->vector_num);
> +		return;
> +	}

[Severity: Medium]
Is this bitmap_zero() safe against the NAPI producers, and against the
interface coming back up?

On stop, hns3_nic_net_stop() sets HNS3_NIC_STATE_DOWN before NAPI is
disabled:

hns3_nic_net_stop()
    test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state)
    ...
    hns3_nic_net_down()
        hns3_disable_irqs_and_tqps()
            hns3_irq_disable()    <- napi_disable() happens here

So a poll that is still running can call test_and_set_bit() in
hns3_ring_set_oom_state() while this worker does a plain memset of the
same word on another CPU.

Isn't that a data race? Can a bit also survive the clear on DOWN?

On reopen, neither hns3_nic_net_stop() nor hns3_nic_net_up() cancels or
flushes oom_task. cancel_delayed_work_sync() only runs in
hns3_nic_uninit_vector_data(). Consider this sequence:

kworker                         open + NAPI
hns3_oom_task()
  test_bit(DOWN) is true
  <preempted>
                                hns3_nic_net_up()
                                  clear_bit(HNS3_NIC_STATE_DOWN, ...)
                                  hns3_enable_irqs_and_tqps()
                                hns3_clean_rx_ring() hits OOM
                                  hns3_oom_task_schedule()
                                    test_and_set_bit(idx, ...)
                                    schedule_delayed_work()
                                      (succeeds, work is running
                                       but not pending)
  bitmap_zero(priv->oom_vector_bm, ...)

When the requeued work runs 250ms later, it finds no bits set and calls
no napi_schedule(). Nothing requeues it after that.

If the RX ring has filled and RX interrupts have stopped by then,
wouldn't the interface get stuck again, which is the problem this patch
is meant to fix?

Would it help to clear only individual bits with test_and_clear_bit()?
Alternatively, the stop path could call
cancel_delayed_work_sync(&priv->oom_task) after napi_disable().

> +
> +	netif_dbg(h, rx_err, netdev, "oom napi_schedule 0x%*pb\n",
> +		  priv->vector_num, priv->oom_vector_bm);
> +	for (i = 0; i < priv->vector_num; i++)
> +		if (test_and_clear_bit(i, priv->oom_vector_bm))
> +			napi_schedule(&priv->tqp_vector[i].napi);
> +}

[Severity: Medium]
rx_oom_cnt is stored in the per-ring struct ring_stats and reported
per RX queue through hns3_rxq_stats[]. The increment here, though, is
gated on a per-vector bit. Can the per-queue values be trusted?

hns3_nic_init_vector_data() maps rings to vectors with
vector_i = i % priv->vector_num. vector_num is at most
min(num_online_cpus(), num_tqps), and get_vector() can return fewer.
Whenever num_tqps is larger than vector_num, several RX rings share
one tqp_vector, and hns3_nic_common_poll() walks all of them in
rx_group.

The first ring on the vector to fail flips the bit from 0 to 1 and is
counted. Another ring on the same vector may also fail before
hns3_oom_task() clears the bit. That ring sees the bit already set, so
its rxqN_rx_oom_cnt never moves. The per-queue numbers then depend on
ring order within the group, not on which queue actually ran out of
memory.

The changelog says the counter increments once per OOM event, but that
does not hold either. hns3_oom_task() clears the bit with
test_and_clear_bit() before the NAPI poll it schedules has succeeded.
Under sustained memory pressure the next poll fails again and bumps
the counter. One long OOM episode is counted about four times a
second.

Is the intent to count per queue or per vector? If per queue, could
the count be taken at the failure sites without the vector bit
gating it? The bit would then only drive the recovery work.

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
> @@ -4493,7 +4529,10 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>  		failure = failure ||
>  			  hns3_nic_alloc_rx_buffers(ring, unused_count);

[Severity: Low]
With failure already set by the new -ENOMEM check above, doesn't this
short-circuit skip hns3_nic_alloc_rx_buffers() on exit?

The -ENOMEM comes from hns3_alloc_skb() when napi_alloc_skb() fails for
the skb head. That leaves ring->skb NULL and takes the goto out.

Because failure is already true, the BDs cleaned in this poll are never
re-armed. That can be up to 15 BDs, since the refill at the top of the
loop runs at 16. HNS3_RING_RX_RING_HEAD_REG is not written for them
either. This includes BDs with reuse_flag set, which need no allocation.

Before this patch, failure stayed false in this case and the exit refill
ran.

Under sustained skb head allocation failure, every poll triggered by the
OOM work could fail on the first BD and skip the refill again. Should the
refill always be attempted, something like:

	if (unused_count > 0 &&
	    hns3_nic_alloc_rx_buffers(ring, unused_count))
		failure = true;

[ ... ]

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index e7318f2363157..392653635bda2 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -62,6 +62,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
>  	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
>  	HNS3_TQP_STAT("frag_alloc_err", frag_alloc_err),
>  	HNS3_TQP_STAT("frag_alloc", frag_alloc),
> +	HNS3_TQP_STAT("rx_oom_cnt", rx_oom_cnt),

[Severity: Medium]
Should this go through the standard per-queue stats rather than a new
ethtool -S string?

struct netdev_queue_stats_rx in include/net/netdev_queues.h already has
alloc_fail. Netlink exposes it as rx-alloc-fail: "Number of times skb or
buffer allocation failed on the Rx datapath". hns3 does not implement
netdev_stat_ops today.

The new counter also does not count each failure:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.h:hns3_ring_set_oom_state() {
	if (!test_and_set_bit(ring->tqp_vector->idx, priv->oom_vector_bm))
		hns3_ring_stats_update(ring, rx_oom_cnt);
}

It only increments when a per-vector bit goes from 0 to 1, and
hns3_oom_task() clears that bit every 250ms. Its value therefore depends
on when the recovery work runs.

Since this is a Fixes: tagged change, the new ethtool string also becomes
permanent ABI and makes the stable backport bigger.

Could the counter be dropped from this fix? Or could it be reported as
alloc_fail through netdev_stat_ops->get_queue_stats_rx(), counted at each
failure site?

[ ... ]

> @@ -3793,6 +3795,7 @@ static int hns3_handle_rx_copybreak(struct sk_buff *skb, int i,
>  
>  		hns3_rl_err(ring_to_netdev(ring),
>  			    "failed to allocate rx frag\n");
> +		hns3_ring_set_oom_state(ring);
>  		return -ENOMEM;
>  	}
>  

[Severity: Medium]
Does a failed napi_alloc_frag() here leave the ring in a state that
needs the recovery work?

hns3_nic_reuse_page() returns void, so the -ENOMEM from
hns3_handle_rx_copybreak() goes no further. hns3_nic_reuse_page()
falls through to out: and attaches desc_cb->priv to the skb with
skb_add_rx_frag(), as it does for other non-reusable buffers. The
caller then advances next_to_clean and the packet is delivered. The
new err == -ENOMEM check in hns3_clean_rx_ring() never sees this
failure.

hns3_nic_alloc_rx_buffers() refills the consumed descriptor like any
other BD. If that refill fails, failure is already set and
hns3_oom_task_schedule() runs anyway. If it succeeds, nothing is
stuck.

With this call, though, the vector bit is set for a packet that was
received normally. hns3_ring_is_oom_state() at the end of
hns3_clean_rx_ring() then schedules oom_task, and rx_oom_cnt is
bumped. frag_alloc_err already counts this failure.

Could this call be dropped? The OOM state would then only be set
where a BD cannot be reaped or re-armed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021121426.3096838-1-shaojijie%40huawei.com
