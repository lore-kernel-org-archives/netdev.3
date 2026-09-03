Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0178850C29B;
	Thu,  3 Sep 2026 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468146; cv=none; b=OOqHjLcdtxT+aR0aGQxZvUtSOk3WMA/jqg4a6nVSS7RTLZUZTJzpv2SUvpW7raHxvdv+pBJ5oeUW+d++50TheFxNGdbMgt/agyN0CV4v8upi8EnhEa/7XQ8py3GOOCu0Rb8G8flKw7KLUGsCTSVO0dTFATKxOHdgLTbu1V3qeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468146; c=relaxed/simple;
	bh=IzbZ0lK9L3NKaOv+QY61OK3CYrMuT+/HNsVKcqffIWk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sA8FY67kqvgcoRGPBF9BWtQhWSsBo45ym9X8zHwkMaZz1rUt/sR0vNN8NcoKfgmGJnSN3LuAcyP7wz98hdJZ+hn08t7RfBBCPuj0I7R1GCrxmvEANeSO/gtdRvajaKQAtvVaxnmuIqhq8814uttVM4kue7JxsjOnCXFcK0XpfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfk0JDcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfk0JDcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A51C1F00A3F;
	Thu,  3 Sep 2026 20:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468124;
	bh=aqts4RHjA3gu+Vie+o3/J1ftxOtePcHuo2dAu8V0WjU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pfk0JDcKcn/K2Tbjo081u+sA9EnR1lyWEMQiNKsBzB7kDVUGwJcWwwiHQTmfNRUOU
	 mnhCoEirC6EeXiqEsiWzk7E0ArVvKfq2SeKerM704g5iJkp96VCW0CCl0TWp83zrkr
	 leSjNagycpKJ24G1rD5ephAaOf0WFCrxO/ksObWakCu4zGZ8eJIiSOTE1XDFT7Eh/q
	 f8OaGn1LrRAPP10DnfiemAr8El7haNrfoi3HmZu3cY/9XIgrb27ngdcJFmzNFzEp7Y
	 j9TIchpUTy1uJUQJ1zmG8fp70VaOAcEJ+65n4skbQNJFIPmHIHmq38Ay6iCToPNAIZ
	 oxTqiAna74r2Q==
Subject: Re: [net-next,v12,3/7] r8169: add support for new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 20:42:03 +0000
Message-ID: <178846812391.3394541.15180410522231123333@kernel.org>
In-Reply-To: <20260831053940.620-4-javen_xu@realsil.com.cn>
References: <20260831053940.620-4-javen_xu@realsil.com.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 4

- [High] Concurrent execution of lockless `rtl_tx()` due to redundant Tx
  NAPIs being scheduled simultaneously by `netpoll`.
- [Medium] NAPI completion unconditionally unmasks hardware interrupts
  for vectors that were explicitly left masked, risking unexpected…
- [Low] Concern (assessed as a FALSE POSITIVE): every new code path added
  by this patch is gated on tp->irq_nvecs > 1, but at this commit…
- [Low] Concern (assessed as a FALSE POSITIVE): rtl_set_irq_mask()
  unmasks ISRIMR_LINKCHG (BIT(29)) and ISRIMR_TOK_Q0 (BIT(8)) for any…
- [Low] Concern (assessed as a FALSE POSITIVE): the new comment above
  r8169_init_napi ("RTL8127 MSI-X vector layout: Vectors 0 .. (RxQs -…
- [Low] Concern (assessed as a FALSE POSITIVE): with per-queue Rx NAPIs,
  rtl_rx() could run on several CPUs at once while still doing plain…

--

r8169: add support for new interrupt mapping

This routes the 8125-style ack/mask/unmask helpers through the new
per-vector mapping registers (IMR_CLEAR_VEC_MAP_REG, ISR_VEC_MAP_REG,
IMR_SET_VEC_MAP_REG) when more than one IRQ vector is allocated. It adds
per-vector MSI-X handlers plus separate Rx and Tx poll routines, a
link-change handler on message id 29, and adjusts the NAPI allocation,
free and netpoll loops for the new layout.

No regressions to report from this review pass. The candidate concerns
that came up were checked against the code and did not hold up; they are
noted inline below purely for the record.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9311a0cab4eb..ca6be1e38408 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -5047,8 +5124,26 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>  
>  	for (i = 0; i < tp->irq_nvecs; i++) {
>  		napi = &tp->rtl8169_napi[i];
> -		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> -				     NULL, napi, "%s-%d", dev->name, i);
> +		if (tp->irq_nvecs > 1) {
> +			if (i < R8169_MAX_QUEUES)
> +				rc = pci_request_irq(tp->pci_dev, i,
> +						     rtl8169_interrupt_msix,
> +						     NULL, napi, "%s-%d",
> +						     dev->name, i);
> +			else if (i == MSIX_ID_VEC_MAP_LINKCHG)
> +				rc = pci_request_irq(tp->pci_dev, i,
> +						     rtl8169_interrupt_other,
> +						     NULL, tp, "%s-%d",
> +						     dev->name, i);
> +			else
> +				continue;
> +		} else {

Checked and not an issue: at this commit rtl_alloc_irq() still calls
pci_alloc_irq_vectors(pdev, 1, 1, flags), so tp->irq_nvecs is always 1
and none of the new branches run yet. The follow-up patch
"r8169: enable new interrupt mapping" switches the allocation to
get_min_irq_nvecs()/get_max_irq_nvecs(). Splitting "add support" from
"enable" this way is fine and leaves no broken intermediate state.

[ ... ]

> @@ -5508,10 +5612,16 @@ static const struct net_device_ops rtl_netdev_ops = {
>  
>  static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->irq_nvecs > 1) {
> +		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_ROK_Q0 << i;

Checked and not an issue: unmasking ISRIMR_TOK_Q0 (bit 8) and
ISRIMR_LINKCHG (bit 29) for any tp->irq_nvecs > 1 would only be a
problem for a vector count in the 2..29 range, since rtl8169_request_irq()
installs the Tx NAPI handler at vector 8 and the link handler at vector
29. That range cannot occur: get_min_irq_nvecs() returns 30 for
RTL_GIGA_MAC_VER_80 and 1 otherwise, and rtl_alloc_irq() falls back to
exactly one vector, so tp->irq_nvecs ends up in {1, 30, 31, 32}.

[ ... ]

> @@ -5796,10 +5906,64 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +	int work_done = 0;
> +	int message_id;
> +
> +	tp = netdev_priv(dev);
> +	message_id = napi - tp->rtl8169_napi;
> +
> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id],
> +				    budget, napi);

[Severity: Medium]
The two new poll routines re-enable the hardware vector
unconditionally on completion, which loses the masking decision that
rtl_set_irq_mask() just made. With irq_nvecs > 1, rtl_set_irq_mask()
only unmasks ISRIMR_ROK_Q0 << i for i < tp->num_rx_rings, plus
ISRIMR_TOK_Q0 and ISRIMR_LINKCHG; the bits for the unused Rx message
ids (num_rx_rings .. R8169_MAX_RX_QUEUES - 1) and for the redundant Tx
ids (R8169_MAX_RX_QUEUES + 1 .. R8169_MAX_QUEUES - 1) are deliberately
left clear. But r8169_init_napi() still adds a NAPI for every one of
those message ids, and rtl8169_poll_msix_rx() / rtl8169_poll_msix_tx()
write BIT(message_id) into IMR_SET_VEC_MAP_REG whenever
napi_complete_done() returns true, with no reference to tp->irq_mask.

Those NAPI instances are reachable: rtl8169_netpoll() walks all
min(tp->irq_nvecs, R8169_MAX_QUEUES) entries and calls
rtl8169_interrupt_msix() on each, which schedules the NAPI, and the
poll then unmasks the vector. After a single netpoll pass the hardware
mask no longer matches what the driver thinks it programmed, and
vectors the driver never intended to arm are live. This is dormant in
this commit because rtl_alloc_irq() still asks for exactly one vector,
but it goes live with the follow-up "r8169: enable new interrupt
mapping".

What is the intended fix here? Gating the unmask on
tp->irq_mask & BIT(message_id) would keep the two in sync, but it may
be cleaner to only create NAPI instances for the message ids that are
actually in use, which would also drop the message_id <
tp->num_rx_rings test in rtl8169_poll_msix_rx().

Checked and not an issue: the worry was that per-queue Rx NAPIs let
rtl_rx() run concurrently while still doing plain increments of the
shared dev->stats fields. At this commit tp->num_rx_rings is
unconditionally 1 (the only assignment is in rtl_setup_rx_params()), so
only ring 0 is polled, and the follow-up patch converts those counters to
per-ring u64_stats with one writer per ring before RSS is enabled.

[ ... ]

> +/* RTL8127 MSI-X vector layout:
> + * Vectors 0 .. (RxQs - 1)		: Rx Queues
> + * Vectors RxQs .. (RxQs + TxQs - 1)	: Tx Queues
> + * NAPI is only allocated for data path
> + */
>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> -		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	int napi_num = min(tp->irq_nvecs, R8169_MAX_QUEUES);
> +
> +	for (int i = 0; i < napi_num; i++) {
> +		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
> +
> +		if (tp->irq_nvecs > 1) {
> +			if (i < R8169_MAX_RX_QUEUES)
> +				poll_fn = rtl8169_poll_msix_rx;
> +			else
> +				poll_fn = rtl8169_poll_msix_tx;
> +		}
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);
> +	}
>  }

[Severity: High]
Every index from R8169_MAX_RX_QUEUES up to R8169_MAX_QUEUES - 1 gets
the same poll_fn here, so eight NAPI instances all end up running
rtl8169_poll_msix_tx(), and that function calls rtl_tx() on the one
shared Tx ring unconditionally - it does not derive a ring index from
napi - tp->rtl8169_napi at all, as the comment you added acknowledges.

rtl_tx() is lockless by design: it reads tp->dirty_tx, walks
tp->TxDescArray / tp->tx_skb, calls rtl8169_unmap_tx_skb() and
napi_consume_skb() and then does WRITE_ONCE(tp->dirty_tx, dirty_tx).
Its only serialization is that a single NAPI instance owns the ring.
With eight NAPIs bound to the same reclaim path that guarantee is
gone. rtl8169_netpoll() schedules all min(tp->irq_nvecs,
R8169_MAX_QUEUES) instances in one go, so several of them can be
running rtl_tx() on different CPUs, each reclaiming the same entries:
that is a double dma_unmap_single() and a double napi_consume_skb() on
the same skb, plus a torn tp->dirty_tx update and a bogus
netif_subqueue_completed_wake() accounting. The Tx vector interrupt
itself can add another concurrent caller on top of that.

Since only a single Tx ring exists, the extra Tx NAPIs look like they
have nothing to do. Would it not be better to create exactly one Tx
NAPI (and size napi_num accordingly) instead of padding out to
R8169_MAX_QUEUES? If the padding is needed for the message-id to NAPI
index arithmetic in rtl8169_interrupt_msix(), please say so, but then
the surplus indices must not be given a poll function that touches the
Tx ring.

Checked and not an issue: reading RxQs in the comment as the chip's fixed
Rx message id count (8, matching R8169_MAX_RX_QUEUES and
tp->hw_supp_num_rx_queues for RTL_GIGA_MAC_VER_80) makes it agree with
both the R8169_MAX_RX_QUEUES split here and ISRIMR_TOK_Q0 being BIT(8).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053940.620-1-javen_xu%40realsil.com.cn
