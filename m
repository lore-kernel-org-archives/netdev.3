Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52981421233;
	Thu,  1 Oct 2026 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870808; cv=none; b=BudbpEkMv9uEq58ei6+yZNWqYpsCR4UYAkBFkpTb2P9skgjUODuRurRNjV4/MpDxKHleTmuwurkLPsJOE5ZUolTBJFlCbLFNFHvifduxgYp4vcQde9Iyo8v79m5K3H70yUhYhCjezkUOuDZU8ORg9fQzeBZOxrYZe+Gb7zm6iGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870808; c=relaxed/simple;
	bh=fya95p6rf19iZKG9rsku+VShvKhanNh55tGMtSVCvLU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ujcb0hyKfe5e5Z7VYFu2kivXVYCj80/BNqp3C181qBXnJmrn4NGXpe9ow5Fj49QDPeBYX2jluQ0bznqLeyArogcXvePgr5EaQ4yjGd+0ZuX+s+S1ls+F48Zt2M09Rk9ApQtsQEGlGbykoVpv9dNNMSEyFc5SnsI+88kgyV0qiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTITGzY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTITGzY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB871F008A4;
	Thu,  1 Oct 2026 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870804;
	bh=hsYJY4gqk/w1f2wMRiwM06BibtGwHSY5LV/kxEiJ170=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JTITGzY+vxsK+5aByrFyiKxUYgTqCs2JFR4xXPQPkWd8MeyJQ4c5VvqNT96nWnF9v
	 UtQf9dypcAK/HZJsUBrSDQ3gybbASLQHDeDVg98KYS+FWu/a5220dSE7xQmYmumozA
	 OocD2C5AYl1h1VfaUUaccMfDPcKF/FpuIQ7mboITT/pbXgc7AXZIumRRDnMsDvAZ+I
	 qkJYAtCo73t+XQbMWJH3ArF8kR2wyHIBotYDyw/7um3gSo00aQpk18ZXbb41Gk6BCJ
	 8lPzxV/eaQKZTpCLlBsAbA6BkQVlJGRO6COwJef6UssamAVEk09ctNUBFSofX2OzSE
	 e8QhKtrqc9+oA==
Subject: Re: [PATCH net-next v15 2/7] r8169: refactor RX path to prepare for
 multi-queue
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 16:06:43 +0000
Message-ID: <179087080396.434549.4178383263370729507@kernel.org>
In-Reply-To: <20260928070423.202-3-javen_xu@realsil.com.cn>
References: <20260928070423.202-3-javen_xu@realsil.com.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message calls this a 'preparatory refactoring', but it
  does not mention that the source of the RX buffer DMA address changes.
- [Low] The diff contains changes with no functional purpose.

--

r8169: refactor RX path to prepare for multi-queue

This patch adds struct rtl8169_rx_ring. It moves the RX descriptor ring,
the data buffers and the cur_rx index out of rtl8169_private into a
per-queue array that is allocated at probe time. The netdev is now
allocated with devm_alloc_etherdev_mqs() for up to 8 RX queues, and
num_rx_rings stays at 1 for now.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 006c17ee778d1..f24a1e1f435c0 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -74,9 +74,13 @@
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> +
>  #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))

[Severity: Low]
This isn't a bug, but this blank line looks like it was left over from
the R8169_RX_RING_BYTES padding change that the v14 changelog says was
reverted. It is still there at the end of the series.

The patch has a few other changes that do nothing. rtl8169_rx_csum() is
re-wrapped with no other change. The later "r8169: add support and
enable rss" patch replaces it anyway:

    static inline void rtl8169_rx_csum(struct sk_buff *skb,
                                       u32 opts1)

The new unwind label in rtl_init_one() is misspelled:

    err_destory_phylink:
        phylink_destroy(tp->phylink);

The misspelled label is also still there at the end of the series.
Should it be err_destroy_phylink?

[ ... ]

> @@ -750,6 +755,14 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_rx_ring {
> +	u32 cur_rx;
> +	struct RxDesc *rx_desc_array;
> +	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
> +	dma_addr_t rx_phy_addr;

[Severity: Low]
This isn't a bug, but the commit message calls this a preparatory
refactoring. It doesn't say that rtl_rx() and rtl8169_rx_clear() now get
the RX buffer DMA address from a copy kept by the driver, not from the
hardware descriptor.

Before this patch, the address was read back from the descriptor:

    addr = le64_to_cpu(desc->addr);

Now both functions use the new array, which rtl8169_alloc_rx_data()
fills in:

    addr = ring->rx_desc_phy_addr[entry];

This adds 256 dma_addr_t entries per ring, or 2 KB with a 64-bit
dma_addr_t.

The reason for the copy only shows up in the v8 changelog below the ---
line, and that text is dropped when the patch is applied. The reason is
that in the later "r8169: add support and enable rss" patch, the RSS
descriptor format reuses the desc->addr space for rss_info and
rss_result.

Could the commit message mention this change and why it is needed?

The names are also a bit confusing. rx_desc_phy_addr[] holds the DMA
addresses of the RX data pages, not of descriptors. It also sits right
next to rx_phy_addr, which is the base address of the descriptor ring.
The end of the series keeps the same names.

Would a name that refers to the data buffer be clearer here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928070423.202-1-javen_xu%40realsil.com.cn
