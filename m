Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE538E8A6;
	Wed, 16 Sep 2026 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521855; cv=none; b=JRtRYpBrp/skP7E9AX7AoiDMbrqbDTDqgtCGLdxS+/S+bL8stvKBlN15OGfXdLXgMYxhDf09LjEcIqfPVEwXBGvq4jyV4HqF7f7SVrNG2FIZXP+hHJM8L6oDg5GtJ7t5SD4KDCk9zYC/NMe4KjT4ihmiDEmR3rMH5ltqZI0zPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521855; c=relaxed/simple;
	bh=npcSujyEEd2SRHw4nuUMiecjC5st/1wY1TITZ68AlA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIZ/yHShVfqikCnpjZn+XP9EX7n6WSkC76P8Idk1CRAt3wF4zM2ywfaoRny4cas7+Ynv8HTnflyAXG6bOmDhz+sO+WRox5mHv473ui0u6AEYe1oW9Y7nBGnE3e2BJLfn7iju3oDR8Un22JCSyt5RakGI70U5rGntqKpM+SjnnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HThccR3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HThccR3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3092F1F00893;
	Wed, 16 Sep 2026 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521853;
	bh=32XND97J7LshlJf99P5j6/iwoGe5IIErkGrBE+ritiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HThccR3oIye0ixR/VSDCj6DWOfQxiYCRZ4lurbDh6sJA5QWZ2OtCmm3UTxKM4EOz5
	 Cjdax7oBmnTUNhvaFBZ/iPmqwyu1pYbx8luU9ePXl6wt7tW4D8AU+bFTI2hjVcJa/G
	 1+I4uSaJG4aUiPwUqFYcAGKs71wn9OQMduI3Hj6+LKXz1Ubp/O/QKLppUajYqBOGrt
	 Pf6x4c0MLGSLhxKujh+ELg323uS1LY8lJu+6zYPObJpW59GACUq9/t5YsATnHYbWGx
	 EVwMiOGPhIjZwZrjgn3UfoWoqustevvpLDbb0FgQbSDDQh14KTyq+F0SBtRDqL9BLG
	 hRpG+PQNEx+Eg==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 2/7] r8169: refactor RX path to prepare for multi-queue
Date: Tue, 15 Sep 2026 18:24:12 -0700
Message-ID: <20260916012412.1649399-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063110.1350-3-javen_xu@realsil.com.cn>
References: <20260910063110.1350-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: refactor RX path to prepare for multi-queue

This patch moves the RX state out of struct rtl8169_private into a new
struct rtl8169_rx_ring array, switches the netdev allocation to
devm_alloc_etherdev_mqs() with up to 8 RX queues, and keeps the active
ring count at 1.

No Link: tags were present in the commit header.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b362855c262f8..f80ad229ae5f8 100644
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
The commit message says this patch "is a preparatory refactoring of the
RX path", but this macro change is a behavioural change on every chip the
driver supports.  Could it be split into its own patch and described in
the changelog?

The new comment asserts that the MAC "might aggressively fetch one more
descriptor even after hitting the RingEnd mark", causing "out-of-bounds
access and potential IOMMU faults".  If that is accurate, every released
kernel has that DMA hazard on the RX ring today.  Is there an erratum or
vendor reference for this, and should the change carry a Fixes: tag so it
can be picked up for stable?

There is also a size effect worth mentioning in the changelog.  struct
RxDesc is 16 bytes and NUM_RX_DESC is 256, so the request goes from
exactly 4096 bytes to 4112 bytes:

	256 * 16 = 4096	/* order-0 */
	257 * 16 = 4112	/* order-1 */

Since dma_alloc_coherent() is page granular, doesn't this turn each RX
descriptor ring allocation in rtl8169_alloc_rx_desc() into an order-1
allocation, i.e. 8 KiB of coherent memory per ring instead of 4 KiB (and
64 KiB instead of 32 KiB once the series scales to 8 rings)?

>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
> +#define R8169_DEFAULT_RX_QUEUES	1
> +#define R8169_MAX_TX_QUEUES	1
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  

[ ... ]

> @@ -4349,55 +4403,107 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)

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

[ ... ]

> @@ -6283,10 +6408,17 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		}
>  	}
>  
> +	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring),
> +			      GFP_KERNEL);
> +	if (!tp->rx_ring)
> +		return -ENOMEM;
> +
>  	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
>  				   GFP_KERNEL);
> -	if (!tp->rtl8169_napi)
> +	if (!tp->rtl8169_napi) {
> +		kfree(tp->rx_ring);
>  		return -ENOMEM;
> +	}

[Severity: Medium]
Do these two bare returns leak the phylink instance created by
rtl_init_phylink()?

By this point in rtl_init_one() phylink_create() has already succeeded,
and it is not a devm allocation.  Every other failure path in the same
window destroys it, for example the r8169_mdio_register() failure just
above:

	rc = r8169_mdio_register(tp);
	if (rc) {
		phylink_destroy(tp->phylink);
		return rc;
	}

and the register_netdev() failure just below:

	rc = register_netdev(dev);
	if (rc) {
		phylink_destroy(tp->phylink);
		goto err_free_napi;
	}

rtl_remove_one() is never called for a failed probe, so when the
tp->rx_ring kcalloc() fails under memory pressure the phylink state
machine and its internal state have no owner.  The tp->rtl8169_napi
failure path that this hunk touches has the same shape.

Would a goto to a label that does phylink_destroy() (plus
kfree(tp->rx_ring)) be preferable to adding more bare returns here?

This is still present at the end of the series, so no later patch in the
set appears to address it.

>  
>  	r8169_init_napi(tp);
>  

[ ... ]

> @@ -6328,6 +6460,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  err_free_napi:
>  	r8169_free_napi(tp);
> +	kfree(tp->rx_ring);
>  	return rc;
>  }
