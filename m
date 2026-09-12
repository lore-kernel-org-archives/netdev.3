Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0413D53C
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244387; cv=none; b=kk7N1OW96fRnngGicfNcOoQKtwPJrj6qKi5V7r7LWX6kW/uxX7iBSgK+EyYPjY2EHpqeeCjeoOb1v+wzS+TzjD03GdRwYCIOseSpgGLFE+au0ZXfQiDdis3WjpsPybY9eB+b+MJBa7b8xdEwMFkyh+09+wTPJe19Cu9ZccBWmj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244387; c=relaxed/simple;
	bh=BIf90RX/JHTZzee7Q6peRu51omLGEg/qpsJkb7fSmlM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6QXx74Ux7I3RFlTQe42ta8TA6BXF1DgUn5Fs3umcdedxHI73FpV4RHckMaZivQ2JRlPF8gBKJx0hDKRNmR9JGNmBkaC5lPYG5Nybf9hBKMrHsNG3Vb3DZOOXNZOllmSPdyg+w6u8kcFZzCjHUCFD2BOVSA41DlrPVQT/v9S3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaL4ba7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaL4ba7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA191F00893;
	Sat, 12 Sep 2026 20:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244386;
	bh=Fp1HFgZ7ybXKz8qOFsXFsS76s/ZXe4D9ZUBQX+6g6Sk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YaL4ba7N9rUhUVia5b26adysyMYqm84K1nXVZz/qogETtTxkt3femvD0udjjfC6b2
	 8pdTN8S9AQ6RzifVzedn5uuG3hK3y1O7L0o1Q4aMl8Aol5+mvQhw2R9X6f03DvtzPq
	 X07x4MrwrhLMmjKwpT8n4Ja35KHoutKJgzCgAhZ66ZJBBLkqMWMwkH7LNmBKzvrsDL
	 6c2qDlroaY7UuMlOXteT78o4ElRqD1ngSZYNnP8PFW5kXOBGFcmX/bEkiVUxb5ndTz
	 a4tl4dh+gHWMcwwnH9Af/EhBXDSmrgDCiYa65lknVQyKDLNDXskXUFiHDH0dJGNEWi
	 gRRarIkLjJilg==
Subject: Re: [PATCH net] net: libwx: fix races in Tx timestamp handling
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com, kees@kernel.org,
 aleksandr.loktionov@intel.com, vadim.fedorenko@linux.dev,
 sashiko-bot@kernel.org
Date: Sat, 12 Sep 2026 20:19:44 +0000
Message-ID: <178924438495.3125.9357764978603392354@kernel.org>
In-Reply-To: <8F4D34F6863177CC+20260908081142.86235-1-jiawenwu@trustnetic.com>
References: <8F4D34F6863177CC+20260908081142.86235-1-jiawenwu@trustnetic.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] Incomplete locking conversion: wx_ptp_quiesce() still
  detaches/frees wx->ptp_tx_skb and clears WX_STATE_PTP_TX_IN_PROGRESS…
- [Medium] The new identity check `if (wx->ptp_tx_skb == skb)` in
  wx_xmit_frame_ring()'s cleanup_tx_tstamp path (wx_lib.c:1692) compares…

--

net: libwx: fix races in Tx timestamp handling

This adds a dedicated spinlock (wx->ptp_tx_lock) to serialize publication
and consumption of wx->ptp_tx_skb between the Tx path, the PTP auxiliary
worker and the timestamp cleanup paths.  The skb is detached and the
WX_STATE_PTP_TX_IN_PROGRESS bit cleared under the lock, with delivery and
release done after unlocking.  The Tx DMA mapping error path also gains an
skb identity check.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/6C7EC12D69217315%2B20260818074721.45536-1-jiawenwu%40trustnetic.com

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd9..9118813334a9e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c

[ ... ]

> @@ -1649,6 +1650,7 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  
>  	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>  	    wx->ptp_clock) {
> +		spin_lock_bh(&wx->ptp_tx_lock);
>  		if (wx->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
>  		    !test_and_set_bit_lock(WX_STATE_PTP_TX_IN_PROGRESS,
>  					   wx->state)) {
> @@ -1659,6 +1661,7 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  		} else {
>  			wx->tx_hwtstamp_skipped++;
>  		}
> +		spin_unlock_bh(&wx->ptp_tx_lock);
>  	}
>  
>  	/* record initial flags and protocol */
> @@ -1685,10 +1688,17 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  	first->skb = NULL;
>  cleanup_tx_tstamp:
>  	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
> -		dev_kfree_skb_any(wx->ptp_tx_skb);
> -		wx->ptp_tx_skb = NULL;
> +		spin_lock_bh(&wx->ptp_tx_lock);
> +		if (wx->ptp_tx_skb == skb) {

[Severity: Medium]
Can this comparison match a different skb that happens to reuse the same
slab address?

By the time cleanup_tx_tstamp runs after a wx_tx_map() failure, this
function no longer holds any reference on skb.  The PTP branch above took
one via wx->ptp_tx_skb = skb_get(skb), but wx_tx_map()'s dma_error path
drops the ring reference before returning:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_tx_map() {
	...
dma_error:
	...
	dev_kfree_skb_any(first->skb);
	first->skb = NULL;
	tx_ring->next_to_use = i;

	return -ENOMEM;
}

So the only remaining reference on skb is the one held by wx->ptp_tx_skb,
and the local skb variable is just a bare pointer value.

If the PTP aux worker on another CPU consumes that request before this CPU
takes ptp_tx_lock:

CPU1 wx_ptp_tx_hwtstamp_work()
	skb = wx->ptp_tx_skb;
	wx->ptp_tx_skb = NULL;
	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
	spin_unlock_bh(&wx->ptp_tx_lock);
	skb_tstamp_tx(skb, &shhwtstamps);
	dev_kfree_skb_any(skb);		<-- last reference gone

CPU2 wx_xmit_frame_ring()
	wx->ptp_tx_skb = skb_get(skb);	<-- new skb on the recycled object

CPU0 then reaches the compare with a stale pointer whose value now names
the newer request, so wx->ptp_tx_skb == skb is true and the newer request
is detached and cancelled, with WX_STATE_PTP_TX_IN_PROGRESS cleared and
tx_hwtstamp_errors charged for it.  skb_tstamp_tx() never runs for that
packet and SKBTX_IN_PROGRESS stays set.

Would something recycle-proof work better here, for example keeping the
local reference across the compare, or a per-request generation counter
instead of the pointer value?

The commit message says the change makes it "so that the error path cannot
clear a newer timestamp request" - does the pointer comparison alone
achieve that?

> +			ptp_tx_skb = wx->ptp_tx_skb;
> +			wx->ptp_tx_skb = NULL;
> +			clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS,
> +					 wx->state);
> +		}
> +		spin_unlock_bh(&wx->ptp_tx_lock);
> +
> +		dev_kfree_skb_any(ptp_tx_skb);
>  		wx->tx_hwtstamp_errors++;
> -		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
>  	}
>  
>  	return NETDEV_TX_OK;
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 4708e7f3958f7..a0929b4844e8d 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -139,12 +139,16 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
>   */
>  static void wx_ptp_clear_tx_timestamp(struct wx *wx)
>  {
> +	struct sk_buff *skb;
> +
> +	spin_lock_bh(&wx->ptp_tx_lock);
>  	rd32ptp(wx, WX_TSC_1588_STMPH);
> -	if (wx->ptp_tx_skb) {
> -		dev_kfree_skb_any(wx->ptp_tx_skb);
> -		wx->ptp_tx_skb = NULL;
> -	}
> +	skb = wx->ptp_tx_skb;
> +	wx->ptp_tx_skb = NULL;
>  	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +	spin_unlock_bh(&wx->ptp_tx_lock);
> +
> +	dev_kfree_skb_any(skb);
>  }

[Severity: Medium]
Was wx_ptp_quiesce() intentionally left out of this conversion?

It is the one remaining place that detaches and frees wx->ptp_tx_skb and
clears WX_STATE_PTP_TX_IN_PROGRESS without taking the new lock:

drivers/net/ethernet/wangxun/libwx/wx_ptp.c:wx_ptp_quiesce() {
	...
	if (wx->ptp_tx_skb) {
		dev_kfree_skb_any(wx->ptp_tx_skb);
		wx->ptp_tx_skb = NULL;
	}
	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
	...
}

That is also the pattern this hunk replaces, i.e. freeing under the same
sequence the other three sites now perform while holding ptp_tx_lock, and
it skips the rd32ptp(wx, WX_TSC_1588_STMPH) unlatch read that
wx_ptp_clear_tx_timestamp(), wx_ptp_tx_hwtstamp_work() and wx_ptp_tx_hang()
all do.

Today the only caller is wx_soft_quiesce(), which does netif_tx_disable()
and wx_napi_disable_all() first, and wx_ptp_quiesce() itself does
ptp_cancel_worker_sync() before touching the pointer, so I could not build
a concurrent execution against the locked consumers.  But wx_ptp_quiesce()
is exported, and the exclusion depends entirely on that call ordering
rather than on the lock the patch adds.

Could this site just call wx_ptp_clear_tx_timestamp(), or use a factored
unlocked helper plus a locked wrapper, so all four paths share one
sequence?

> [ ... ]

> @@ -174,50 +178,43 @@ static void wx_ptp_convert_to_hwtstamp(struct wx *wx,
>  	hwtstamp->hwtstamp = ns_to_ktime(ns);
>  }
>  
> -/**
> - * wx_ptp_tx_hwtstamp - utility function which checks for TX time stamp
> - * @wx: the private board struct
> - *
> - * if the timestamp is valid, we convert it into the timecounter ns
> - * value, then store that result into the shhwtstamps structure which
> - * is passed up the network stack
> - */
> -static void wx_ptp_tx_hwtstamp(struct wx *wx)
> +static int wx_ptp_tx_hwtstamp_work(struct wx *wx)
>  {
>  	struct skb_shared_hwtstamps shhwtstamps;
> -	struct sk_buff *skb = wx->ptp_tx_skb;
> +	struct sk_buff *skb;
> +	u32 tsynctxctl;
>  	u64 regval = 0;
>  
> -	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPL);
> -	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPH) << 32;
> -
> -	wx_ptp_convert_to_hwtstamp(wx, &shhwtstamps, regval);
> -
> -	wx->ptp_tx_skb = NULL;
> -	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> -	skb_tstamp_tx(skb, &shhwtstamps);
> -	dev_kfree_skb_any(skb);
> -	wx->tx_hwtstamp_pkts++;
> -}
> -
> -static int wx_ptp_tx_hwtstamp_work(struct wx *wx)
> -{
> -	u32 tsynctxctl;
> +	spin_lock_bh(&wx->ptp_tx_lock);
>  
>  	/* we have to have a valid skb to poll for a timestamp */
>  	if (!wx->ptp_tx_skb) {
> -		wx_ptp_clear_tx_timestamp(wx);
> +		rd32ptp(wx, WX_TSC_1588_STMPH);
> +		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +		spin_unlock_bh(&wx->ptp_tx_lock);
>  		return 0;
>  	}
>  
>  	/* stop polling once we have a valid timestamp */
>  	tsynctxctl = rd32ptp(wx, WX_TSC_1588_CTL);
> -	if (tsynctxctl & WX_TSC_1588_CTL_VALID) {
> -		wx_ptp_tx_hwtstamp(wx);
> -		return 0;
> +	if (!(tsynctxctl & WX_TSC_1588_CTL_VALID)) {
> +		spin_unlock_bh(&wx->ptp_tx_lock);
> +		return -1;
>  	}
>  
> -	return -1;
> +	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPL);
> +	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPH) << 32;
> +	wx_ptp_convert_to_hwtstamp(wx, &shhwtstamps, regval);
> +	skb = wx->ptp_tx_skb;
> +	wx->ptp_tx_skb = NULL;
> +	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +	spin_unlock_bh(&wx->ptp_tx_lock);
> +
> +	skb_tstamp_tx(skb, &shhwtstamps);
> +	dev_kfree_skb_any(skb);
> +	wx->tx_hwtstamp_pkts++;
> +
> +	return 0;
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 9454e90258d8e..6b9460147ca93 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1430,6 +1430,7 @@ struct wx {
>  	unsigned long last_overflow_check;
>  	unsigned long last_rx_ptp_check;
>  	unsigned long ptp_tx_start;
> +	spinlock_t ptp_tx_lock; /* protects ptp_tx_skb and ptp_tx_start */

[Severity: Medium]
This comment states the lock protects ptp_tx_skb, but wx_ptp_quiesce()
still reads, frees and NULLs wx->ptp_tx_skb without it, as noted above.
Should the comment be narrowed, or wx_ptp_quiesce() updated to match it?

>  	seqlock_t hw_tc_lock; /* seqlock for ptp */
>  	struct cyclecounter hw_cc;
>  	struct timecounter hw_tc;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/8F4D34F6863177CC%2B20260908081142.86235-1-jiawenwu%40trustnetic.com
