Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626243;
	b=X4UdqlbFImpcfMPxcGHEXMoa7voLamTO+KTubUwxbF7tNP7IvDIBGllICHWpGbmRJ0T3
	 bZsK3ytrSzETFJ7krhV1JGJlPcjdKRsezjGsKVUzIWnbsNe9PdOrjquPmmRpSe2aMRTzh
	 Vd6AZejEOoXWpmwk/055XmQXlNUtJ+xRinlTk1px9v3dtFK3VoqBCU2b0CKbZdssap3CX
	 P398bCM6N/CqaIHK4tgJ16QkWnCA3LKAiE2V4aIH53Y+B5CNfXL+8bs3IBKu1daA/c6ow
	 33vexfbJj5sJT/ohKxwrDcoO4GUbr4uNIQjotJG399XYElNTkakUxWZ7gQi95WzUYlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626243;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OeguhAR6tr/+2Ritf0VsevI/Iplx6NkFE+EAgh0CL/Q=;
	b=ymu5r2n0Jk+f9YB44kCnw4VDYpE/wtq9k+/e4qLlI2UtJB7VeFeXBF9DWaoQX5QQYNKt
	 xaznhP9i4kGaeyAEnTNpl/lyVi8Tmfz9aW4pe7+6gddn/Bzogs6JjXg98aeyNx2XJrll3
	 Y126SvhzvdncmUz0SDW0HNRkFEiFzuYNeGMpOJyqaFfzV75gkAFYXSHfjhoh0dzGK3Hv7
	 ZTsKHEiPNlzKjF4L3yTo/6V2yodwcLGa0MdXQgnZ3feu4snH8h69JLjU9nEY6C12gwb0G
	 FA3GMmfQ/bZ/vAyw+h4OypbafsYCxKW/uvqYR3LeC5pfi9cArHI5eBvGMxiDgBFakhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6IFN8Ly;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7F606A323;
	Sat, 14 Nov 2026 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6IFN8Ly
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BBF1F000C4;
	Sat, 14 Nov 2026 03:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626243;
	bh=OeguhAR6tr/+2Ritf0VsevI/Iplx6NkFE+EAgh0CL/Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d6IFN8LyYSyftJUR+YzfVzDFjth9SEfMAeWe82gouRlQI+tJ6knbBON3NrZgK53Dw
	 cXkSi+82Cfkztn9jrK+jAvMAzr5dW5FRyN1d27SUv+GYZTckIX2ElxdBQ5c48tenm3
	 SWrdjZuAvg3ntTuQ2Ac1IrsjHjCCJuMb0/RxiMzRHizp0oiGf1wDxppn1QyZqmS9uG
	 +mIlzoKD1cKdTdzQEmZfC76stYXxaVwN7S6UZ61wlcywxp6paFnuR/q4WsYhZAyFXt
	 RPnnK8d+CBpusvsyJDdk/x/RtWYH8ZEBcln7em2H584tBtVg953vU7Dljo2XhjV8/k
	 eUTXpvN8/8tHw==
Subject: Re: [PATCH v4 net 3/4] net: hns3: fix interface stuck after OOM with
 full hardware rx queue
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 03:17:22 +0000
Message-ID: <179462624232.2199510.16700149583019655532@kernel.org>
In-Reply-To: <20261111125810.3359030-4-shaojijie@huawei.com>
References: <20261111125810.3359030-4-shaojijie@huawei.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a new private `ethtool -S` per-queue string,
  "rx_oom_cnt", at hns3_rxq_stats[] in hns3_ethtool.c line 65.
- [Medium] net: hns3: rx_ring_oom_bm freed before cancelling oom_task on
  init error
- [Low] In hns3_clean_rx_ring() (hns3_enet.c around lines 4499-4533), the
  commit message says that because the exit refill is always attempted,…
- [Low] When HNS3_NIC_STATE_DOWN is set, hns3_oom_task() clears
  priv->rx_ring_oom_bm with the non-atomic bitmap_zero()…

--

net: hns3: fix interface stuck after OOM with full hardware rx queue

This patch adds a 250ms delayed_work that schedules NAPI again for RX
rings that hit allocation failures. The interface can then recover after
OOM even when the full hardware ring stops raising RX interrupts. It
replaces the return-budget busy-poll recovery in hns3_clean_rx_ring() and
adds a per-ring rx_oom_cnt ethtool counter.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index dbf32c00bb7f3..90f0a8ac9295c 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c

[ ... ]

> @@ -4451,6 +4454,35 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring)
>  	return 0;
>  }
>  
> +static void hns3_oom_task(struct work_struct *work)
> +{
> +	struct hns3_nic_priv *priv = container_of(work, struct hns3_nic_priv,
> +						  oom_task.work);
> +	struct hnae3_handle *h = priv->ae_handle;
> +	struct hns3_enet_ring *ring;
> +	u16 i;
> +
> +	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
> +		bitmap_zero(priv->rx_ring_oom_bm, h->kinfo.num_tqps);

[Severity: Medium]
The commit message says oom_task is cancelled in
hns3_nic_uninit_vector_data(), which every teardown path reaches
before the bitmap is freed. Does that hold on the init error unwind
paths?

hns3_client_init() calls hns3_nic_init_vector_data(), which does the
INIT_DELAYED_WORK(), before hns3_init_all_ring(), which allocates
rx_ring_oom_bm. The error unwind therefore runs in the opposite
order:

    out_init_phy:
        hns3_uninit_all_ring(priv);
    out_init_ring:
        hns3_nic_uninit_vector_data(priv);

hns3_reset_notify_init_enet() is laid out the same way:

    err_init_irq_fail:
        hns3_uninit_all_ring(priv);
    err_uninit_vector:
        hns3_nic_uninit_vector_data(priv);

On both paths hns3_uninit_all_ring() frees rx_ring_oom_bm and sets
it to NULL before cancel_delayed_work_sync(&priv->oom_task) runs. If
oom_task is pending or running at that point, hns3_oom_task() calls
bitmap_zero() or test_and_clear_bit() on a freed or NULL pointer.

Can the work be pending there? In hns3_client_init(),
register_netdev() can open the device from a NETDEV_REGISTER
notifier, for example net_failover_slave_register() calling
netif_open(). An RX allocation failure in that window reaches
hns3_oom_task_schedule() and queues oom_task. If
register_netdevice() then fails, the device is closed through
hns3_nic_net_stop(), which sets HNS3_NIC_STATE_DOWN but does not
cancel the work. hns3_client_init() then unwinds from
out_reg_netdev_fail through out_init_phy and frees the bitmap while
the work can still fire.

The reset path looks harder to hit, but it has the same ordering, and
both contradict the invariant the commit message relies on.

This is a cold error path, but the result is a NULL dereference or a
use-after-free write from the workqueue. Would it be better to cancel
oom_task in hns3_uninit_all_ring() just before bitmap_free()? Or
could the bitmap allocation and free move next to
INIT_DELAYED_WORK() and the cancel in hns3_nic_init_vector_data()
and hns3_nic_uninit_vector_data(), so the two are always torn down
in the right order?

[Severity: Low]
Is it safe to clear rx_ring_oom_bm with the non-atomic bitmap_zero() here?
Every other writer uses atomic bitops: test_and_set_bit() in
hns3_ring_set_oom_state() and test_and_clear_bit() below. bitmap_zero() is
a plain store or a memset.

A writer can run while DOWN is set in at least two ways.

First, hns3_nic_net_stop() sets DOWN before hns3_nic_net_down() reaches
napi_disable():

    if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
        return 0;

hns3_nic_common_poll() checks DOWN only on entry. A poll that is already
running can still reach hns3_ring_set_oom_state() from hns3_add_frag() or
from hns3_oom_task_schedule().

Second, the ethtool loopback self-test calls hns3_clean_rx_ring() directly
while DOWN is set:

hns3_lb_check_rx_ring()
    hns3_clean_rx_ring(ring, budget, hns3_lb_check_skb_data);

Wouldn't KCSAN report this plain store racing with test_and_set_bit() on
the same word?

There is a separate problem: the test_bit(DOWN) check and bitmap_zero()
are not atomic with respect to an ifup. Suppose the worker is preempted
between them, the interface comes back up, and a NAPI poll sets a bit and
queues the work again. The resumed worker then zeroes the new bit:

hns3_oom_task()
    test_bit(HNS3_NIC_STATE_DOWN) -> true
    <preempted>
                                    ifup clears DOWN
                                    hns3_clean_rx_ring()
                                      hns3_oom_task_schedule()
                                        test_and_set_bit(queue_index)
                                        schedule_delayed_work()
    bitmap_zero()

When the work runs again it finds no bits set and does not schedule NAPI
for that ring.

Could this lose the only recovery kick for the ring? The commit message
calls both outcomes harmless, but it does not cover this case.

[ ... ]

> @@ -4490,10 +4525,12 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
>  	 * FBD number with head pointer
>  	 */
>  	if (unused_count > 0)
> -		failure = failure ||
> -			  hns3_nic_alloc_rx_buffers(ring, unused_count);
> +		failure |= hns3_nic_alloc_rx_buffers(ring, unused_count);
>  
> -	return failure ? budget : recv_pkts;
> +	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
> +		hns3_oom_task_schedule(ring);
> +
> +	return recv_pkts;

[Severity: Low]
The commit message says:

    The exit refill is still attempted, so the descriptors cleaned
    by this poll stay armed.

Is that accurate? The refill inside the loop in hns3_clean_rx_ring() is
unchanged:

    if (unused_count >= RCB_NOF_ALLOC_RX_BUFF_ONCE) {
        failure = failure ||
            hns3_nic_alloc_rx_buffers(ring, unused_count);
        unused_count = 0;
    }

After the first failure inside the loop, the || short-circuits. Even so,
unused_count is still reset to 0 each time it reaches 16. The exit refill
above therefore covers only what accumulated since the last reset, not
every descriptor consumed in this poll.

Before this patch, returning budget forced an immediate repoll, which
recomputed hns3_desc_unused(). Now recv_pkts is returned, so
hns3_nic_common_poll() can complete NAPI while that deficit is still
outstanding.

After a transient allocation failure, couldn't up to roughly a budget's
worth of consumed descriptors stay unarmed until the next RX interrupt or
the 250ms oom_task kick? That would include reuse_flag descriptors that
need no allocation, and it would happen even if memory recovers right
away.

[ ... ]

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 7b92a3c73ef6d..14642f81efe1a 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -62,6 +62,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
>  	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
>  	HNS3_TQP_STAT("frag_alloc_err", frag_alloc_err),
>  	HNS3_TQP_STAT("frag_alloc", frag_alloc),
> +	HNS3_TQP_STAT("rx_oom_cnt", rx_oom_cnt),

[Severity: Medium]
Does this new ethtool -S string duplicate the standard per-queue
rx-alloc-fail qstat (struct netdev_queue_stats_rx.alloc_fail)? The netdev
netlink spec documents that counter as "Number of times skb or buffer
allocation failed on the Rx datapath".

Every increment of rx_oom_cnt comes from an RX allocation failure. Either
napi_alloc_skb() fails in hns3_add_frag(), or hns3_oom_task_schedule()
runs after hns3_handle_rx_bd() returns -ENOMEM or
hns3_nic_alloc_rx_buffers() fails.

The commit message says:

    It counts OOM episodes rather than individual allocation failures,
    so it is not the standard rx-alloc-fail counter.

However, hns3_oom_task() clears each ring's bit every time it runs:

    if (test_and_clear_bit(i, priv->rx_ring_oom_bm)) {

The next poll that fails sets the bit again and increments the counter in
hns3_ring_set_oom_state():

    if (!test_and_set_bit(ring->queue_index, priv->rx_ring_oom_bm))
        hns3_ring_stats_update(ring, rx_oom_cnt);

Under a prolonged OOM, wouldn't rx_oom_cnt increase about once per 250ms
per ring? That makes it a rate-limited count of allocation failures, not
a count of episodes.

hns3 does not implement netdev_stat_ops/get_queue_stats_rx yet. Could this
be reported as alloc_fail through the standard qstats interface rather
than as a private ethtool string?

This patch also carries a Fixes: tag. Would it be better to leave the new
user-visible counter out of the fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111125810.3359030-1-shaojijie%40huawei.com
