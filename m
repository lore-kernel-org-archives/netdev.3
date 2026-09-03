Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D08421241;
	Thu,  3 Sep 2026 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468147; cv=none; b=BD9eTBjXqyy/NuZnIKpnDYDjYZLl43wGbKs4pwYnI7tTTkcWWuBK7kkS+CmDHZlwiDvrIiu9blAIAkAFmvqw1H2TrAdJw7FiGINTA5vLs+DplnRQsMk1G1t/UpE6Ng8sVfyoIf+SOiZBivYWNQ/tkp16JmgxGzdxr32QWkD84QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468147; c=relaxed/simple;
	bh=Tk+WhthGSkd400sko5yGRTapwE6g6knMdn+kCkqb2Uo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LD0ZQpLVrLl9pgxe85WwoJkbbWpDC5s2S6FTwZggtWXINlUPOlukdzPNCCtzOf9n5il3rMDx2Xj4GVPfApRCkX4Wumj16Cxr78M+y3kjIE8LTlwdu61ZQo4OeqjGoS0RyN0VqnHf1gPx75Q+mexE3hbdlo/OrG+7dSehtmgZNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ58Nqiq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ58Nqiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16181F00AC4;
	Thu,  3 Sep 2026 20:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468127;
	bh=Zz0HmX9sFqZKCadeJvGRHXCzyADzY9aJ/hfi6i8q2CM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UJ58NqiqT7gkg/gKnnfUqfOLkEDLQ0dzVyDx9+gh91a83G+ZvgYwzsHJ6hdWcspPJ
	 xC0HRR5qc3hDhQ/mm6Wikdy2myWeLxHtjLo0PIKAwSM/Co4XkPFb9cWcdL4yci78x/
	 YkfRGkEljxFdK0PdcKO4vuqLyKlhA45O1zhlHqJcCQzQtMmjLVz8WANYHResR7mE5p
	 Al2f1A+wnas577MBjuXf4n+SWzB1/z9Xj/911cbYX9QznbENXAl+fuJt2DUIYtYcKJ
	 W9h/AodJCktsyA1Rn808BuM5FVhq9h52wx3svzdg53ilYZzvzBYnbTLvmavw4nmqv1
	 x6EcYrYE95pnQ==
Subject: Re: [net-next,v12,5/7] r8169: add support and enable rss
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 20:42:06 +0000
Message-ID: <178846812623.3394541.17417405223017097887@kernel.org>
In-Reply-To: <20260831053940.620-6-javen_xu@realsil.com.cn>
References: <20260831053940.620-6-javen_xu@realsil.com.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 (1) · Low: 1 (1)

- [High] This patch is the first to make tp->irq_nvecs > 1 real (30-32
  vectors for RTL_GIGA_MAC_VER_80; the baseline requested…
- [High] NAPI poll function assignment mismatch causes TX queue to
  permanently stall when num_rx_rings < 8.
- [Medium] The one-line commit message ("This patch adds support and
  enable rss for RTL8127") does not disclose several substantial…
- [Medium] The patch stores a driver-generated RSS key and indirection
  table (struct rtl8169_rss_data filled by rtl8169_init_rss() via…
- [Low] rtl8169_store_rss_key() carries the comment "/* Write redirection
  table to HW */" although the function writes the 40-byte RSS hash key…

Pre-existing issues:
- [Medium] In rtl_rx(), the device-supplied receive length is taken as
  pkt_size = status & GENMASK(13, 0) and then decremented by ETH_FCS_LEN…
- [Low] Concern (validated as a FALSE POSITIVE): rtl_alloc_irq() now
  enables up to 32 MSI-X vectors but the driver never calls…

--

r8169: add support and enable rss

This patch adds RSS support for RTL8127 (RTL_GIGA_MAC_VER_80): it adds a
dynamically allocated struct rtl8169_rss_data holding the hash key and
indirection table, a second Rx descriptor layout selected by
tp->init_rx_desc_type, and it changes rtl_alloc_irq() to request many MSI-X
vectors so that multiple Rx rings can be used.  A few questions below.

> This patch adds support and enable rss for RTL8127.

[Severity: Medium]
Could the commit message say more about the behaviour changes that come
with this?  Some of them are user visible and hard to derive from the
one-line description:

- rtl_alloc_irq() goes from pci_alloc_irq_vectors(pdev, 1, 1, flags) to a
  request of 30 to 32 vectors for RTL_GIGA_MAC_VER_80, with an unlogged
  fallback to a single vector, so whether RSS works at all depends on how
  many MSI-X vectors the platform can supply.

- multi-queue Rx becomes the default through rtl8169_set_rx_ring_num(), and
  NETIF_F_RXHASH is set in dev->features at probe time.

- the runtime Rx descriptor layout switches to RX_DESC_TYPE_RSS, which
  changes the meaning of every Rx status bit.

- UDP 4-tuple hashing (RSS_CTRL_UDP_IPV4_SUPP and RSS_CTRL_UDP_IPV6_SUPP)
  is enabled unconditionally in rtl8169_set_rss_hash_opt() with no knob.

Where do the values 30 and 32 in R8127_MIN_NUM_IRQVEC and
R8127_MAX_NUM_IRQVEC come from?  They only seem derivable from
MSIX_ID_VEC_MAP_LINKCHG being 29 plus the ISRIMR_TOK_Q0 / ISRIMR_ROK_Q0
layout used by rtl_set_irq_mask().  Could a comment spell that out?

The v11 changelog entry says "add comment on pci_alloc_irq_vectors() call",
but there is no comment at that call site in this version.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 1798a98b860b3..9de27cf916932 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -2881,6 +2975,58 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
>  }
>  
> +static void rtl8169_store_rss_key(struct rtl8169_private *tp)
> +{
> +	u8 *rss_key = tp->rss_data->rss_key;
> +	const u16 rss_key_reg = RSS_KEY_REG;
> +
> +	/* Write redirection table to HW */
> +	for (int i = 0; i < RTL_RSS_KEY_SIZE; i += sizeof(u32))
> +		RTL_W32(tp, rss_key_reg + i, get_unaligned_le32(rss_key + i));
> +}

[Severity: Low]
This isn't a bug, but the comment in rtl8169_store_rss_key() says
"Write redirection table to HW" while the loop writes the 40-byte hash key
to RSS_KEY_REG.  The redirection table is written by rtl8169_store_reta()
just below, which carries the identical comment.  Was this comment copied
from the neighbouring function?

> +
> +static void rtl8169_store_reta(struct rtl8169_private *tp)
> +{
> +	u8 *indir_tbl = tp->rss_data->rss_indir_tbl;
> +	unsigned int i;
> +
> +	/* Write redirection table to HW */
> +	for (i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i += 4) {
> +		u32 reta = get_unaligned_le32(&indir_tbl[i]);
> +
> +		RTL_W32(tp, RSS_INDIRECTION_TBL_REG + i, reta);
> +	}
> +}

[ ... ]

> @@ -4998,8 +5269,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  
>  			if (!(dev->features & NETIF_F_RXALL))
>  				goto release_descriptor;
> -			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> -				goto release_descriptor;
> +
> +			if (tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT) {
> +				if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> +					goto release_descriptor;
> +			} else {
> +				if (!(status & (RXRUNT_RSS | RXCRC_RSS)))
> +					goto release_descriptor;
> +			}
>  		}
>  
>  		pkt_size = status & GENMASK(13, 0);

[Severity: Medium]
This isn't a regression introduced by this patch, but can the length
arithmetic just below the new RSS branch underflow?

		pkt_size = status & GENMASK(13, 0);
		if (likely(!(dev->features & NETIF_F_RXFCS)))
			pkt_size -= ETH_FCS_LEN;

There is no check that the device-reported length is at least ETH_FCS_LEN,
so a descriptor reporting 0 to 3 makes the unsigned pkt_size wrap to
roughly 0xfffffffc.  napi_alloc_skb() then adds NET_SKB_PAD + NET_IP_ALIGN,
which wraps back into a small successful allocation, and the copy uses the
wrapped length:

		skb = napi_alloc_skb(napi, pkt_size);
		...
		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
		skb->tail += pkt_size;
		skb->len = pkt_size;

Reaching that requires rx-all to be enabled so errored descriptors are not
dropped.  The new RSS branch above accepts RUNT/CRC frames without the
RxRWT guard the default path has, so does it widen the set of error
descriptors whose length reaches this computation?  Would a
"if (pkt_size < ETH_FCS_LEN) goto release_descriptor;" style check be
appropriate here?

[ ... ]

> @@ -5677,6 +5958,32 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int get_max_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MAX_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static int get_min_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MIN_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static void rtl8169_set_rx_ring_num(struct rtl8169_private *tp)
> +{
> +	if (tp->irq_nvecs >= get_min_irq_nvecs(tp)) {
> +		unsigned int rss_queue_num = netif_get_num_default_rss_queues();
> +
> +		tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
> +							    tp->hw_supp_num_rx_queues));
> +		if (tp->num_rx_rings >= 2)
> +			tp->init_rx_desc_type = RX_DESC_TYPE_RSS;
> +	}
> +}
> +
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -5697,7 +6004,11 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp),
> +				      get_max_irq_nvecs(tp), flags);
> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);

[Severity: High]
This is the line that makes tp->num_rx_rings depend on the machine
it runs on: netif_get_num_default_rss_queues() is CPU-count derived,
so on a 4-core box num_rx_rings ends up 4, not R8169_MAX_RX_QUEUES.
Can you confirm the Tx completion path still works in that case?

r8169_init_napi() picks the poll callback from the vector index alone:

	if (i < R8169_MAX_RX_QUEUES)
		poll_fn = rtl8169_poll_msix_rx;
	else
		poll_fn = rtl8169_poll_msix_tx;

so vectors 0..7 always get rtl8169_poll_msix_rx, independently of how
many Rx rings were actually created.  rtl8169_poll_msix_rx() then does

	if (message_id < tp->num_rx_rings)
		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id],
				    budget, napi);

and nothing else, i.e. vectors num_rx_rings..7 poll neither Rx nor Tx.

If the hardware raises TOK on the vector that follows the active Rx
queues (vector 4 when num_rx_rings is 4), that vector's NAPI is an Rx
poller whose bounds check fails, so rtl_tx() is never called: dirty_tx
never advances, tp->tx_skb[] entries are never unmapped, the ring fills
up and the queue stays stopped for good.  Which vector does the chip
use for TOK_Q0 once RTL_RX_Q_NUM_MASK is programmed by
rtl8125_set_rx_q_num() with fewer than eight queues, and where is that
mapping documented?

If the Tx event really does move with the Rx queue count, then the
poll_fn selection in r8169_init_napi() should key off tp->num_rx_rings
rather than the R8169_MAX_RX_QUEUES constant.  That would also address
the separate concern about Tx NAPIs being created for vectors that have
no Tx queue behind them.  Could you either make that dependency
explicit, or explain why the fixed split at eight is correct for every
num_rx_rings this patch can produce?

[Severity: High]
This is the first change that makes tp->irq_nvecs greater than one, so the
multi-vector NAPI paths become live.  Can that lead to concurrent Tx
completion processing on the single Tx ring?

With 30 to 32 vectors, napi_num = min(tp->irq_nvecs, R8169_MAX_QUEUES) is
16, and r8169_init_napi() creates eight Tx-poll NAPIs even though only Tx
queue 0 exists:

	if (tp->irq_nvecs > 1) {
		if (i < R8169_MAX_RX_QUEUES)
			poll_fn = rtl8169_poll_msix_rx;
		else
			poll_fn = rtl8169_poll_msix_tx;
	}
	netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);

All eight call into the same rtl_tx():

rtl8169_poll_msix_tx()
	/* Currently r8169 only supports a single Tx ring. */
	rtl_tx(dev, tp, budget);

and rtl_tx() is written as a single consumer with no lock:

	dirty_tx = tp->dirty_tx;

	while (READ_ONCE(tp->cur_tx) != dirty_tx) {
		...
		skb = tp->tx_skb[entry].skb;
		rtl8169_unmap_tx_skb(tp, entry);
		...
	}
	if (tp->dirty_tx != dirty_tx)
		WRITE_ONCE(tp->dirty_tx, dirty_tx);

NAPI only serialises a single napi_struct, so if two of these eight Tx
NAPIs run at once they both start from the same dirty_tx and both unmap and
free the same entry, giving a double dma unmap, a double skb free and a
corrupted dirty_tx / BQL count.

One reachable path is rtl8169_netpoll(), which schedules every vector:

	napi_num = min(tp->irq_nvecs, R8169_MAX_QUEUES);

	for (int i = 0; i < napi_num; i++) {
		if (tp->irq_nvecs > 1)
			rtl8169_interrupt_msix(pci_irq_vector(tp->pci_dev, i),
					       &tp->rtl8169_napi[i]);

With threaded NAPI enabled each of those NAPIs runs in its own kthread on a
different CPU, so the eight Tx NAPIs can execute rtl_tx() in parallel.

As a related point, when one of those NAPIs completes,
rtl8169_poll_msix_tx() calls rtl8169_enable_hw_interrupt_msix() and unmasks
the TOK_Q1..Q7 vectors that rtl_set_irq_mask() deliberately left masked.
Should the Tx NAPIs only be created for vectors that actually have a Tx
queue behind them?

[ ... ]

> @@ -6144,6 +6467,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  
> +	if (rtl_hw_support_rss(tp) && tp->num_rx_rings > 1) {
> +		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->features |= NETIF_F_RXHASH;
> +	}
> +

[Severity: Medium]
NETIF_F_RXHASH is advertised here, and rtl8169_init_rss() generates a hash
key with netdev_rss_key_fill() plus a default indirection table with
ethtool_rxfh_indir_default(), which rtl_set_rss_config() programs into the
hardware on every rtl_hw_start().  But rtl8169_ethtool_ops gains none of
.get_rxfh_key_size, .get_rxfh_indir_size, .get_rxfh, .set_rxfh or
.set_rxnfc, here or later in the series (the following patches only move
the ops table and add .get_channels).

That means ethtool -x and ethtool -X return -EOPNOTSUPP while RSS is
active, the indirection table cannot be inspected or changed, and the UDP
4-tuple hashing turned on in rtl8169_set_rss_hash_opt() cannot be disabled
with ethtool -N ... rx-flow-hash udp4.  Is the plan to add the rxfh
callbacks in a follow-up, or could they come with the patch that enables
RSS?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053940.620-1-javen_xu%40realsil.com.cn
