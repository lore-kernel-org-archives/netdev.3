Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B884E73B7;
	Mon, 19 Oct 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410196; cv=none; b=qFB2kMBAUpKk7mHQMNDti9tDe/rbZtjhvPWiBuTvu9bZqffApspFQaE/heMC2ckfbiwld6rhTssYmAVl9SD5F4mK3b53mlH4wPyW7HyMxt1IrmD8g2jefwO+3mjx0njbpmL7co80efnRbmegbptlpBfx1tKe6DCJY2TYD1l5jWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410196; c=relaxed/simple;
	bh=+3r96WgvaLZ51mkYfUtue7nreKIDjPHuZYIvt5AP5dQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hlQNNVNgu563/1QobuOvNfWUTZKn3RCD8OVvcUwei9J9mMLuoUBrpZbe0bX4K85/BrKaFvD+uHc4SrfyOodp7WCzBMooW9115BX5kHxnPiVHS9/Bl51xNby8skXVoqbq9+BSisDJVQ8fz6s8HDO0vCvO4ZcJdGMi3ScZZrKwHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJADmtGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJADmtGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCEF1F000C8;
	Mon, 19 Oct 2026 11:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410192;
	bh=meEGW/GS3/XRT3foeZLouvqwfWIt69ajcD2dNzgktWU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aJADmtGTCzDVNXW2PAtON20bThik6+ooDjIxlG69gMAO8Oe2N94jox5/vL+e02Ov1
	 y/DzQV8ofCC841ZTXpafZTJzfTlvmqM2QQJyzssKdKU00ZUrZVbXuZGNXRnB91i05n
	 MDVrj7KKyWR+RPZ3NrGZtNQ5kIbVn8PgkHlIT0Ozs9cVhijZ27bw0zgagbXrBB7uAf
	 wBpWoIOmwFCZ45/iik4O3kdrVOvyIEbehNWR2f/V+CYYcDcli2rcTfCu4lNl/TQg75
	 kZDoIpzjdH5SIchIstgA00odtazP6z5QIUSC+xPjwNgeI4BLZ3EsUiC1h3lWHWHVsp
	 Z7KD1lAKQ/UCQ==
Subject: Re: [PATCH v4 net 8/8] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 11:43:10 +0000
Message-ID: <179241019093.3135.3031150554563643199@kernel.org>
In-Reply-To: <20261015105536.1692348-9-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-9-vladimir.oltean@nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In enetc_xdp_xmit()
  (drivers/net/ethernet/freescale/enetc/enetc.c), the doorbell condition…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it comes from
  the earlier commit in the same series, 'net: enetc: serialize access…

--

net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()

This commit changes the doorbell condition in enetc_xdp_xmit(). The TX ring
tail is now updated only when at least one frame was sent and either
XDP_XMIT_FLUSH was requested or the frames array could not be fully
enqueued. The redundant xdp_tx_frm_cnt variable is removed in favour of k.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 218065b9a3777..3003a415418ba 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c

[ ... ]

> @@ -1928,22 +1928,20 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  						    &xdp_redirect_arr[i]);
>  			break;
>  		}
> -
> -		xdp_tx_frm_cnt++;
>  	}
>  
> -	if (unlikely((flags & XDP_XMIT_FLUSH) || k != xdp_tx_frm_cnt))
> +	if (unlikely(k && ((flags & XDP_XMIT_FLUSH) || k < num_frames)))
>  		enetc_update_tx_ring_tail(tx_ring);

[Severity: High]

Does the new k && term skip the doorbell when an XDP_XMIT_FLUSH call
enqueues zero frames?

The old condition rang on every FLUSH call, because k != xdp_tx_frm_cnt was
always false. XDP_XMIT_FLUSH asks the driver to publish everything queued so
far. That includes frames from earlier ndo_xdp_xmit() calls made with
flags == 0.

devmap makes calls like that when the bulk queue fills up:

kernel/bpf/devmap.c:bq_enqueue() {
    ...
	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
		bq_xmit_all(bq, 0);
    ...
}

Only the later __dev_flush() passes XDP_XMIT_FLUSH:

kernel/bpf/devmap.c:__dev_flush() {
    ...
		bq_xmit_all(bq, XDP_XMIT_FLUSH);
    ...
}

The flags == 0 call advances tx_ring->next_to_use without writing TPIR. If
the first frame of the next FLUSH batch fails, k is 0 and
enetc_update_tx_ring_tail() is never called.

The first frame can fail in these cases:

  - enetc_xdp_tx() finds too few free BDs. This is likely right after the
    previous batch used up the ring.
  - The head buffer is shorter than ENETC_MIN_BUFF_SIZE.
  - The frame fails the ENETC_MAX_SKB_FRAGS check.
  - DMA mapping fails.

On a ring reserved for XDP, the only other TPIR writer is the XDP_TX tail
update in enetc_clean_rx_ring_xdp(). It rings only when it has enqueued
XDP_TX frames itself:

	if (xdp_tx_frm_cnt) {
		spin_lock(&tx_ring->xdp_lock);
		enetc_update_tx_ring_tail(tx_ring);
		spin_unlock(&tx_ring->xdp_lock);
	}

So the stranded BDs stay unpublished until a later call both succeeds and
flushes. If traffic stops, they never go out.

If they fill the ring, every later enqueue fails on its first frame. TX
completion cannot reclaim BDs the hardware never saw. Can the XDP TX queue
then stall permanently, with the xdp_frames and pages still pinned?

Other drivers ring the tail on XDP_XMIT_FLUSH no matter how many frames
that call sent. For example, i40e_xdp_xmit():

	if (unlikely(flags & XDP_XMIT_FLUSH))
		i40e_xdp_ring_update_tail(xdp_ring);

Would something like this be closer to the intent?

	if (unlikely((flags & XDP_XMIT_FLUSH) || (k && k < num_frames)))

The commit message says:

    The correct condition on which we should ring the doorbell is when at
    least one frame was sent, and either the caller required us to flush, or
    we couldn't enqueue the entire passed array.

The subject says the patch ensures the tail update happens, and the patch
has a Fixes: tag. Even so, FLUSH calls with k == 0 no longer ring the
doorbell, and the commit message does not mention this change.

>  
>  	enetc_unlock_mdio();
>  
>  out:
> -	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
> -	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
> +	tx_ring->stats.xdp_tx += k;
> +	tx_ring->stats.xdp_tx_drops += num_frames - k;
>  
>  	spin_unlock(&tx_ring->xdp_lock);

[Severity: High]

This isn't a bug introduced by this patch. It comes from the earlier patch
in this series, "net: enetc: serialize access to the same TX ring from NAPI
XDP_TX and ndo_xdp_xmit()".

Can tx_ring->xdp_lock and enetc_mdio_lock deadlock on PREEMPT_RT when the
ERR050089 workaround (enetc_has_err050089) is enabled?

enetc_xdp_xmit() takes xdp_lock first and then the MDIO read lock:

	spin_lock(&tx_ring->xdp_lock);
	...
	enetc_lock_mdio();

enetc_clean_rx_ring_xdp() drops xdp_lock at the out: label but keeps the
MDIO read lock. It then takes xdp_lock again, so the order is reversed:

out:
	spin_unlock(&tx_ring->xdp_lock);
	...
	if (xdp_tx_frm_cnt) {
		spin_lock(&tx_ring->xdp_lock);
		enetc_update_tx_ring_tail(tx_ring);
		spin_unlock(&tx_ring->xdp_lock);
	}
	...
	enetc_unlock_mdio();

On PREEMPT_RT, rwbase_write_lock() takes the rtmutex and removes
READER_BIAS. New readers then block behind a pending writer. That would
allow this cycle:

T1 (RX NAPI, enetc_clean_rx_ring_xdp())
  holds the MDIO read lock after out:

T3 (_enetc_rd_mdio_reg_wa())
  write_lock_irqsave(&enetc_mdio_lock, flags);
  waits for T1 to drop the read lock

T2 (enetc_xdp_xmit() on another CPU, targeting the same XDP TX ring,
    e.g. after an IRQ affinity change)
  spin_lock(&tx_ring->xdp_lock);
  enetc_lock_mdio();          <- blocks behind T3

T1
  spin_lock(&tx_ring->xdp_lock);  <- blocks behind T2

Non-RT testing would not catch this. On non-RT, qrwlock readers in
interrupt context ignore a waiting writer, and lockdep treats this
read_lock as recursive.

Would it help to use one lock order in the RX tail update path? For
example, the MDIO read lock could be dropped before re-taking xdp_lock and
then taken again inside it.

>  
> -	return err ?: xdp_tx_frm_cnt;
> +	return err ?: k;
>  }
>  EXPORT_SYMBOL_GPL(enetc_xdp_xmit);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015105536.1692348-1-vladimir.oltean%40nxp.com
