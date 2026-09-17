Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718A44AB6E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675348; cv=none; b=Vl/y0MXubVnAutXBSNC8EgUVkd5MuTBlR1E+sqNlrtye+IzmjirJ2XHMC7mxLEQJNjvb3nRbwjD5JjSDIYkJIB1roCfd+I6Q/Tq7oGmwiZ4hcRszYfFqD7ovzQstRKwac8zc45D6M0BBcJl6c3GQq96TeDnb+zVK69WTg7nmVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675348; c=relaxed/simple;
	bh=/X2jtHiAlrp4szQ7xJ80twMkpO9Qdv0b541j12k9s80=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxLM/SGK9pOWtR0D67MScCmOqpF2SjBdRO+rW+fsVCrGaBZVx5vP3LRynzzxt8rJxsgXVvNmlK6/ffhzul+Ie1Cs98wVE5Zgfjs6RKq2EsdrS2D53xFCHPy2UPX+hIctI8UcbspimbhuAGVl5TipUvguE2bcQoCxxWf08LfqDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLdNprLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLdNprLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB6F1F000FF;
	Thu, 17 Sep 2026 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675346;
	bh=sVNwjYnBzYhbEdmq5c8BxdeB7KNKYPM//BKmrCuGT7Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eLdNprLBTfF34foWkoodOywMv7rSN2ugu8Gg6nGuXc7pz+Rd/NF6ugP7jkK4MSEGN
	 1O7NhdM/4QRMhumlSXbUDeQ1ewwyQ2pVKxTnTJD7c/GWcSYyBDZuTCVqGJ3Bi4vJI0
	 soFk7WkrN9k549ld/iapR446wE54KA4WdntRmApBSKO8IJIUh25zN2ka649B6s7AoF
	 mI77BThsR24IF+lSDffaCGclnRWiTswk3CGF9yO8KghHG5aYNJ2vbpcJ9NKDWnBP4z
	 ss9UXeW+duASCCMYNHGi1h7PQrL2tQzWKrZCycQF0Zncz2DoifyVbA45cSkfIQE+Hq
	 FjTNHLjtwpnCw==
Subject: Re: [PATCH net v2] net: libwx: fix races in Tx timestamp handling
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com, kees@kernel.org,
 aleksandr.loktionov@intel.com, vadim.fedorenko@linux.dev,
 sashiko-bot@kernel.org
Date: Thu, 17 Sep 2026 20:02:25 +0000
Message-ID: <178967534514.22033.6813523642554517754@kernel.org>
In-Reply-To:
 <73D0D3F5D96A6928+20260914080020.211580-1-jiawenwu@trustnetic.com>
References: <73D0D3F5D96A6928+20260914080020.211580-1-jiawenwu@trustnetic.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (3)

- [Medium] The patch makes wx_ptp_quiesce() (wx_ptp.c:886) perform an
  MMIO register read on a device whose PCIe channel may be frozen or…

Pre-existing issues:
- [High] The NAPI Tx cleanup path can call ptp_schedule_worker() on a PTP
  clock that wx_ptp_stop() is concurrently unregistering and NULLing.
- [Low] wx_ptp_suspend()
  (drivers/net/ethernet/wangxun/libwx/wx_ptp.c:841-852) tears down the…
- [Low] wx_xmit_frame_ring() reads wx->tstamp_config.tx_type inside the
  new ptp_tx_lock critical section (wx_lib.c:1656-1658), but the writer…
- [Low] In wx_xmit_frame_ring()'s out_drop path, wx->tx_hwtstamp_errors++
  is executed after dropping ptp_tx_lock (wx_lib.c:1706-1709), i.e.…

--

net: libwx: fix races in Tx timestamp handling

Adds a dedicated spinlock (wx->ptp_tx_lock) that serializes publication and
consumption of wx->ptp_tx_skb between the Tx path, the PTP auxiliary worker
and the timestamp cleanup paths.  The detach sequence is factored into
__wx_ptp_detach_tx_skb(), and the Tx error path now compares the outstanding
request against its own skb before cancelling it.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/6C7EC12D69217315%2B20260818074721.45536-1-jiawenwu%40trustnetic.com

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd..940ba2c6150f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c

[ ... ]

> @@ -1649,9 +1651,11 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  
>  	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>  	    wx->ptp_clock) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&wx->ptp_tx_lock, flags);
>  		if (wx->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
> -		    !test_and_set_bit_lock(WX_STATE_PTP_TX_IN_PROGRESS,
> -					   wx->state)) {
> +		    !test_and_set_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state)) {

[Severity: Low]
This is a pre-existing inconsistency and not something introduced here, but
is the read of wx->tstamp_config.tx_type actually covered by the new lock?

The writer side never takes ptp_tx_lock, and it publishes the new config
only after the hardware has already been reprogrammed and cleaned up:

wx_hwtstamp_set()
    wx_ptp_set_timestamp_mode(wx, cfg);   /* clears WX_TSC_1588_CTL_ENABLED,
                                             calls wx_ptp_clear_tx_timestamp() */
    memcpy(&wx->tstamp_config, cfg, sizeof(wx->tstamp_config));

Can a transmit on another CPU still observe HWTSTAMP_TX_ON in that window,
arm WX_STATE_PTP_TX_IN_PROGRESS and set SKBTX_IN_PROGRESS for a frame the
hardware will never timestamp?  The request then pins the skb and its
socket until wx_ptp_tx_hang() cancels it (WX_PTP_TX_TIMEOUT is HZ) with a
bogus tx_hwtstamp_timeouts increment and a "clearing Tx timestamp hang"
warning.  Would publishing tx_type under ptp_tx_lock close that?

>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>  			tx_flags |= WX_TX_FLAGS_TSTAMP;
>  			wx->ptp_tx_skb = skb_get(skb);

[Severity: Low]
This isn't a bug introduced by this patch either, but can this publication
outlive its only consumer on the suspend path?

wx_ptp_suspend() clears WX_STATE_PTP_RUNNING first, so wx_ptp_do_aux_work()
returns HZ without ever running wx_ptp_tx_hwtstamp_work() or
wx_ptp_tx_hang() again, and then performs the final cleanup while
wx->ptp_clock is still set and Tx has not been stopped yet:

txgbe_close_suspend()
    wx_ptp_suspend(wx);          /* clears RUNNING, wx_ptp_clear_tx_timestamp() */
    txgbe_disable_device(wx);    /* netif_tx_stop_all_queues()/netif_tx_disable() */
    wx_free_resources(wx);

Does an in-flight wx_xmit_frame_ring() that is already past the
queue-stopped check then leak the skb_get() reference (and the socket it
pins), with WX_STATE_PTP_TX_IN_PROGRESS left set and nothing left to
consume or time out the request?

On the PM path this is recovered later by resume -> ndo_open ->
wx_ptp_init() -> wx_ptp_reset() -> wx_ptp_set_timestamp_mode() ->
wx_ptp_clear_tx_timestamp(), so it appears to persist only on the
poweroff/shutdown path.  The ndo_stop path looks unaffected, since
dev_deactivate_many() and netpoll_poll_disable() run before ndo_stop.

>  @@ -1659,6 +1663,7 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  		} else {
>  			wx->tx_hwtstamp_skipped++;
>  		}
> +		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
>  	}
>  
>  	/* record initial flags and protocol */
> @@ -1677,19 +1682,34 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  		wx->atr(tx_ring, first, ptype);
>  
>  	if (wx_tx_map(tx_ring, first, hdr_len))
> -		goto cleanup_tx_tstamp;
> +		goto out_drop;
>  
>  	return NETDEV_TX_OK;
>  out_drop:
> -	dev_kfree_skb_any(first->skb);
> -	first->skb = NULL;
> -cleanup_tx_tstamp:
> +	/* The hardware will never report a timestamp for a frame it did not
> +	 * transmit, so drop the request. Only do so if it is still ours: the
> +	 * PTP worker may already have completed it and a concurrent transmit
> +	 * may have submitted a new one.
> +	 */
>  	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
> -		dev_kfree_skb_any(wx->ptp_tx_skb);
> -		wx->ptp_tx_skb = NULL;
> -		wx->tx_hwtstamp_errors++;
> -		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +		struct sk_buff *ptp_tx_skb = NULL;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&wx->ptp_tx_lock, flags);
> +		if (wx->ptp_tx_skb == skb) {
> +			ptp_tx_skb = wx->ptp_tx_skb;
> +			wx->ptp_tx_skb = NULL;
> +			clear_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +		}
> +		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
> +
> +		if (ptp_tx_skb) {
> +			dev_kfree_skb_any(ptp_tx_skb);
> +			wx->tx_hwtstamp_errors++;
> +		}
>  	}

[Severity: Low]
This is a pre-existing pattern rather than something the patch changes, but
could wx->tx_hwtstamp_errors++ move inside the critical section that is
already held just above?

It is a non-atomic read-modify-write performed after dropping ptp_tx_lock,
and two transmits on different netdev queues share no HARD_TX_LOCK, so can
one increment be lost and make ts_stats->err in wx_get_ts_stats() undercount?
tx_hwtstamp_skipped is incremented under the lock in the arming hunk above.

> +	dev_kfree_skb_any(first->skb);
> +	first->skb = NULL;
>  
>  	return NETDEV_TX_OK;
>  }
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 4708e7f3958f..f6346d257250 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -129,6 +129,31 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
> +static struct sk_buff *__wx_ptp_detach_tx_skb(struct wx *wx)
> +{
> +	struct sk_buff *skb = wx->ptp_tx_skb;
> +
> +	lockdep_assert_held(&wx->ptp_tx_lock);
> +
> +	rd32ptp(wx, WX_TSC_1588_STMPH);
> +	wx->ptp_tx_skb = NULL;
> +	clear_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +
> +	return skb;
> +}

[Severity: Medium]
Is this rd32ptp() safe on the quiesce path?  With this patch,
wx_ptp_quiesce() reaches it through wx_ptp_clear_tx_timestamp(), and
wx_ptp_quiesce() only runs while the PCIe channel is known to be in
trouble:

wx_io_error_detected()          /* including pci_channel_io_frozen and
                                   pci_channel_io_perm_failure */
    set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
    wx_soft_quiesce(wx)
        wx_ptp_quiesce(wx)
            wx_ptp_clear_tx_timestamp(wx)
                __wx_ptp_detach_tx_skb(wx)
                    rd32ptp(wx, WX_TSC_1588_STMPH);   /* readl() */

wx_reset_task() takes the same route after wx_check_pcie_error() has
already decided the link or memory space is gone.

Before this patch wx_ptp_quiesce() performed no register access at all
(it only freed wx->ptp_tx_skb and cleared the state bit), which also
matches commit c023e9769de9 ("net: wangxun: implement soft quiesce for
PCIe error recovery"):

    Function wx_soft_quiesce() provide a lightweight shutdown path during
    PCIe error recovery. It avoids MMIO-dependent operations in PCIe error
    status.

Since the read value is discarded and a dead device returns all-ones, the
unlatch this read exists for does not happen anyway.  Would an MMIO-free
detach for the quiesce path (take ptp_tx_lock, clear wx->ptp_tx_skb and
WX_STATE_PTP_TX_IN_PROGRESS) preserve that property, leaving the
WX_TSC_1588_STMPH unlatch to wx_ptp_suspend(), wx_ptp_tx_hang() and the
worker where the device is known to be alive?

>  /**
>   * wx_ptp_clear_tx_timestamp - utility function to clear Tx timestamp state
>   * @wx: the private board structure
> @@ -139,12 +164,14 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
>   */
>  static void wx_ptp_clear_tx_timestamp(struct wx *wx)
>  {
> -	rd32ptp(wx, WX_TSC_1588_STMPH);
> -	if (wx->ptp_tx_skb) {
> -		dev_kfree_skb_any(wx->ptp_tx_skb);
> -		wx->ptp_tx_skb = NULL;
> -	}
> -	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wx->ptp_tx_lock, flags);
> +	skb = __wx_ptp_detach_tx_skb(wx);
> +	spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
> +
> +	dev_kfree_skb_any(skb);
>  }

[ ... ]

> @@ -849,11 +883,7 @@ void wx_ptp_quiesce(struct wx *wx)
>  	if (wx->ptp_clock)
>  		ptp_cancel_worker_sync(wx->ptp_clock);
>  
> -	if (wx->ptp_tx_skb) {
> -		dev_kfree_skb_any(wx->ptp_tx_skb);
> -		wx->ptp_tx_skb = NULL;
> -	}
> -	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +	wx_ptp_clear_tx_timestamp(wx);
>  
>  	if (wx->ptp_clock) {
>  		ptp_clock_unregister(wx->ptp_clock);

[Severity: High]
This isn't a bug introduced by this patch, since wx_clean_tx_irq() and the
close ordering are untouched, but while the locking of the in-progress bit
is being reworked, is wx->ptp_clock safe against the NAPI Tx cleanup path?

wx_clean_tx_irq() reads the state bit without ptp_tx_lock and then hands
wx->ptp_clock to the scheduler:

	/* schedule check for Tx timestamp */
	if (unlikely(test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state)) &&
	    skb_shinfo(tx_buffer->skb)->tx_flags & SKBTX_IN_PROGRESS)
		ptp_schedule_worker(wx->ptp_clock, 0);

and the callee dereferences it right away:

drivers/ptp/ptp_clock.c:ptp_schedule_worker() {
	return kthread_mod_delayed_work(ptp->kworker, &ptp->aux_work, delay);
}

The same clock teardown as in wx_ptp_quiesce() above is done by
wx_ptp_stop(), which runs before NAPI is disabled:

txgbe_close()
    wx_ptp_stop(wx);          /* wx_ptp_suspend(), ptp_clock_unregister(),
                                 wx->ptp_clock = NULL */
    txgbe_down(wx);
        txgbe_disable_device(wx);
            wx_napi_disable_all(wx);

ngbe_close() has the same wx_ptp_stop() before ngbe_down() ordering, and
netif_carrier_off() also happens only inside the disable step, so the
early "if (!netif_carrier_ok())" return in wx_clean_tx_irq() does not
help here.

Can a poll that already passed the test_bit() check then pass a freed or
NULL wx->ptp_clock to ptp_schedule_worker() and oops in softirq context?
Should NAPI be disabled before ptp_clock_unregister(), or should the clock
pointer used by the Tx cleanup path be synchronized with teardown?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/73D0D3F5D96A6928%2B20260914080020.211580-1-jiawenwu%40trustnetic.com
