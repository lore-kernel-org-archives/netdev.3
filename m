Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669655111A5;
	Thu,  3 Sep 2026 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468139; cv=none; b=c38I1wv/dG74vrHVyLqmS+JMTsKUaRTKJ/CYMbMf1JuRXhhNacdgP6PWpUrjZb148cc9wzecIy7SUb9JITkFnePY+VFse8Abemfr1v8gQ4trz7b5fmYjEYNEdtPgD38jlYcXY2rdgCNJ4dgO7O2Slj4oc2XTwSsJbu+/uZlRH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468139; c=relaxed/simple;
	bh=kuFa/TEjs+63nJEkR93TgtBPEowbMZIWmPgNnEqgEIk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPelWBMvFGWPDYNy6qNoncwrmf7KNB27D2w1NbHUW65L84HOtp+5phU1TdUiKpZ5xtsu8HeR74ZGV+y2kWTRhZTHCFviozrRQ3lvT7DcyXEm9BiXOWA+WwCEQM/a9EHkezTHw1Hyf+5SIBfalHaKGfZMR/54w7LxDNXveTv1oWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVdttzud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVdttzud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBE61F00A3D;
	Thu,  3 Sep 2026 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468123;
	bh=QWWOnb4aExcuin8dsH3n9zyB4wMVlMbFayWtniFW7IY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PVdttzudJvJAErx6aa+NMt0lq1H8Xgpkyp7QvczOiLnqKm2QAeMFp4WKmbEhbPmzL
	 sLiuWDGXo8tQ1R+WqK7+jCeKHBGkj2hmLsOwyiHJ602xfsNhRCPbk3ZlXUez/zSQwc
	 PBGnS6Up4EMQrrzvRMpEZiHe6CmwZIkk0ANN71E1FFvteAYn44vQKBZNSXXh5gSxnz
	 2ZWcf/Mc9ERR2nYLNnyxsuZzMoa8pZdYZXf9YAajsACLEYmM+MPmlR0zpffiZSGeIt
	 60/L1g93bu/KQXVgAkMzLyCR05mGeTcicFcHjMki4rMJrIEphtSxaaVmkKVP3Hv94i
	 AYXNkMTakeHzw==
Subject:
 Re: [net-next,v12,2/7] r8169: refactor RX path to prepare for multi-queue
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 20:42:02 +0000
Message-ID: <178846812274.3394541.14036248825057917928@kernel.org>
In-Reply-To: <20260831053940.620-3-javen_xu@realsil.com.cn>
References: <20260831053940.620-3-javen_xu@realsil.com.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] Undisclosed functional change folded into a patch whose
  changelog promises a pure refactor: `R8169_RX_RING_BYTES` is changed…
- [Medium] State introduced by this patch that is never consumed, and a
  netdev queue count advertised to the core that never matches reality.
- [Medium] IRQF_NO_THREAD is silently dropped for MSI/MSI-X vectors.

--

r8169: refactor RX path to prepare for multi-queue

This patch introduces struct rtl8169_rx_ring and moves the RX ring state
out of rtl8169_private into a per-queue array, and switches the netdev
allocation to devm_alloc_etherdev_mqs() with up to 8 RX queues while
num_rx_rings stays at 1.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 87eb10616a0c..9311a0cab4eb 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -74,9 +74,19 @@
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> -#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
> +
> +/*
> + * Workaround for the hardware DMA prefetcher. The H/W might aggressively
> + * fetch one more descriptor even after hitting the RingEnd mark. We
> + * allocate this extra dummy space as padding to prevent out-of-bounds
> + * access and potential IOMMU faults.
> + */
> +#define R8169_RX_RING_BYTES	((NUM_RX_DESC + 1) * sizeof(struct RxDesc))

[Severity: Medium]
The changelog describes this patch as "a preparatory refactoring of the RX
path", but this macro changes behaviour for every supported chip.  Two
questions about it.

First, if the hardware really does "fetch one more descriptor even after
hitting the RingEnd mark", then the driver before this patch lets the device
DMA past the end of the ring on all chip generations.  Would that make this
an independent fix that wants its own patch with a Fixes: tag, so that stable
trees pick it up?  As submitted the change is invisible to backporters.

Second, sizeof(struct RxDesc) is 16 and NUM_RX_DESC is 256, so the old
request was exactly 4096 bytes and the new one is 4112 bytes:

	rtl8169_alloc_rx_desc()
	  dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES, ...)

Since dma_alloc_coherent() rounds up to a power-of-two page order, does this
turn the per-ring coherent allocation from one page into two, doubling the
coherent DMA footprint per RX ring (and eight times that once the rest of the
series enables multiple rings)?  Would allocating one page and reserving the
last descriptor as the pad, or documenting the extra page, be preferable?

>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
> +#define R8169_DEFAULT_RX_QUEUES	1
> +#define R8169_MAX_TX_QUEUES	1
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  

[ ... ]

> @@ -728,6 +739,15 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_rx_ring {
> +	u32 cur_rx;
> +	u32 dirty_rx;

[Severity: Medium]
Is dirty_rx used anywhere?  Grepping the tree at the end of this series
returns only this declaration and the single store in
rtl8169_init_ring_indexes() below - there is no comparison against cur_rx and
no refill or doorbell logic reading it.  Should the field be dropped until the
patch that actually needs it?

> +	struct RxDesc *rx_desc_array;
> +	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
> +	dma_addr_t rx_phy_addr;
> +	struct page *rx_databuff[NUM_RX_DESC];
> +};
> +

[ ... ]

> @@ -2620,9 +2638,26 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		memset(ring->rx_desc_array, 0x0, R8169_RX_RING_BYTES);
> +	}
> +}
> +
>  static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
>  {
> -	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
> +	tp->dirty_tx = 0;
> +	tp->cur_tx = 0;
> +
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		ring->dirty_rx = 0;
> +		ring->cur_rx = 0;
> +	}
>  }
>  

[ ... ]

> @@ -4184,55 +4240,107 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)

[ ... ]

> +static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pci_dev;
> +	struct rtl8169_rx_ring *ring;
> +
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		ring = &tp->rx_ring[i];
> +		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
> +							 R8169_RX_RING_BYTES,
> +							 &ring->rx_phy_addr,
> +							 GFP_KERNEL);
> +		if (!ring->rx_desc_array)
> +			return -ENOMEM;
> +	}
> +	return 0;
> +}
> +

[ ... ]

> @@ -5688,7 +5812,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	u32 txconfig;
>  	u32 xid;
>  
> -	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
> +	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
> +				      R8169_MAX_TX_QUEUES,
> +				      R8169_MAX_RX_QUEUES);
> +

[Severity: Medium]
This asks the core for 8 RX queues on every chip, and alloc_netdev_mqs() sets
dev->real_num_rx_queues = rxqs:

net/core/dev.c:alloc_netdev_mqs() {
	...
	dev->real_num_rx_queues = rxqs;
	...
}

rtl_setup_rx_params() keeps tp->num_rx_rings at 1, and there is no
netif_set_real_num_rx_queues() call in the driver, either here or at the end
of the series.  Does that leave every r8169 device advertising 8 RX queues to
userspace - /sys/class/net/<dev>/queues/rx-0 through rx-7 with their RPS/RFS
knobs, plus the netdev-genl queue enumeration - while only ring 0 ever
receives packets?

Should rtl_init_one() call netif_set_real_num_rx_queues(dev,
tp->num_rx_rings) once the ring count is known?

>  	if (!dev)
>  		return -ENOMEM;
>  

[ ... ]

One more observation about the series rather than this hunk.  Before the
series, rtl_open() picked the IRQ flags explicitly:

	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);

[Severity: Medium]
rtl8169_request_irq() now uses pci_request_irq() for all vectors, and that
helper hard-codes the flags:

drivers/pci/irq.c:pci_request_irq() {
	unsigned long irqflags = IRQF_SHARED;

	if (!handler)
		irqflags |= IRQF_ONESHOT;
	...
}

There is no way for the caller to pass IRQF_NO_THREAD, so does this lose the
behaviour that commit 870f531e178e ("r8169: set IRQF_NO_THREAD if MSI(X) is
enabled") added, namely keeping the handler unthreaded when the interrupt
cannot be shared?

On kernels booted with threadirqs, or on PREEMPT_RT, the small handler that
does rtl_irq_disable(), napi_schedule() and rtl_ack_events() would then run
from an IRQ thread even for MSI/MSI-X vectors.  Was that intended, and could
it be mentioned in the changelog if so?

Keeping request_irq() with IRQF_NO_THREAD for MSI/MSI-X and IRQF_SHARED for
INTx, using pci_irq_vector(pdev, i) for the vector lookup, would preserve the
previous behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053940.620-1-javen_xu%40realsil.com.cn
