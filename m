Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797047;
	b=xrh5JpF8mEDvYzpCvxFWgLUkenrhgopFxA8qxZB20P/pJJvbptYtQH9pCXimeUzaqcrz
	 TS1EaEW2UWrsM4WinYbcq0k8jRPMaiIk9i71nC3LpAxZFuE21Ix/YwxINHcLlwzY8HwrK
	 2G0O33TQJZtcK5YdXcYsuGBZqUjESwHMvxVunJ5PYonicQ1LK+fKhuSTwoPm6k3ZtpLmP
	 OUc9S9D6On7Gzv3DwyTZcPPutgQxt5203RVr2IOLtynQehXV4RTqp/KCSa4VGbqAVL10Y
	 QxfR2/4RmLgQRXkYum/t8k1bKZVNKWZma/njaPx4V/FiW3af0xATMZG3DWhq7jI0Z3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797047;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D0kbrHSKBE89ndUNPmq1KVMe/vU62aec77sGzOP1AEQ=;
	b=ZcchScCfUaWKIz+GbUW0L/Fi5heP9KU+YU6f8epiR9w8urqn7nPACsh0ikUiPv8jryfo
	 8zj4AF0QYGybmkEQ56ITzas6YsVYCAvNJZpUukoCG0dETf2gqYgPn2K2vIM2kijnw3TNW
	 iBcubkL+EbsVJA1vm/4oMqVeDoZIGZ1we0c1mO/nDoj86PF9zl0EqyM/FX6jbDAVEu1AN
	 wIonXQ1lrCsPh7MGd+nP4DrmMokyX4VDU7FyTmlPsP8Z8VKkLDqILqjBhQ51P53bV2zbt
	 1N3gFBT9iUhbmHkKy6n6KZNyXYRNsKnwRV6t9GMqrKyJwbRkJ5u/VaC+iB/iL7L3kFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXe5agtj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8A606A328;
	Wed,  4 Nov 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXe5agtj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDBF1F00A15;
	Wed,  4 Nov 2026 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797046;
	bh=D0kbrHSKBE89ndUNPmq1KVMe/vU62aec77sGzOP1AEQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nXe5agtj4MLNgQWd/YS6im2iGRrSEAeDHckdWLHlOsnjJ7Ojr7OKtQcGx9CwlKBDa
	 Cq2r8xQ6rGVyeMY08bM1+sblieSohUFr2+WFbgYBg+MpuJHuH79ro8vsFyTybFOLLY
	 mjW6p5rTpDNmHS4gZ4hoamHE9JzCyz+0iGdm/9fqISVDgl2m3X7wSCt8cmiXV140f0
	 T3ZSMezEFYEP3SzNnu7MhSjAoZ9eFs9df30S5hY7qlvqAx5jeDuDkwXmvOg+kqvSNr
	 WK0BsgLl6w6yYYpaKRIN8xoaOp2kW30aVIFjcGUm8HnwMMU7lkHXsZkJmwveNKo4PE
	 Y3IbpK4au9LXg==
Subject:
 Re: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel interrupts
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, lorenzo.bianconi@oss.qualcomm.com, nb@tipi-net.de,
 magnusleatti@kernelriot.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 04 Nov 2026 12:57:24 +0000
Message-ID: <179379704484.488856.2140619507341432623@kernel.org>
In-Reply-To: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag points at the wrong commit for the storms the
  message describes.
- [Medium] The new DMA_DIR_ERR path does not own the abnormal bits it
  relies on.
- [Low] The commit message says "there's no multi-msi mode on dwmac1000".

--

net: stmmac: Clear DMA errors for multi-channel interrupts

This patch adds a DMA_DIR_ERR direction and a DMA_CHAN_STATUS_MSK_ERR mask
for dwmac4. In multi-MSI mode, stmmac_mac_interrupt() now walks every DMA
channel and clears the AIS/FBE/RPS/RBU status bits. A tx_hard_error seen on
that path calls stmmac_global_err().

> Fixes: 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for multi-MSI")

[Severity: Medium]
Is this the right commit for the storms described above?

Before 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU interrupts"), dwmac4
never set RBU or RPS in DMA_CHAN_INTR_ENA. DMA_CHAN_INTR_ABNORMAL and
DMA_CHAN_INTR_ABNORMAL_4_10 were only:

    (DMA_CHAN_INTR_ENA_AIE | DMA_CHAN_INTR_ENA_FBE)

With only 6ccf12ae111e applied, RBU and RPS could not raise AIS on the
INTM=1 MAC vector. FBE was the only abnormal source left unhandled there.

The RBU and RPS storms, and the selftests listed in the message, only seem
reachable after 1b9707e6f1a9. That commit enabled these bits so that the
statistic counters could be updated.

Should the Fixes: tag point at 1b9707e6f1a9 instead, or also include it?
As written, stable may backport this to 5.13+ trees that cannot hit these
storms.

Since RBU and RPS were enabled only for statistics, was masking them in
multi-MSI mode considered as an alternative?

> This seems to only affect dwmac4, there's no multi-msi mode on
> dwmac1000, and on dwxgmac these interrupts are masked as of today.

[Severity: Low]
Is the dwmac1000 part of this accurate? dwmac-loongson uses a
dwmac1000-family core and it does enable multi-MSI:

drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:
	plat->core_type = DWMAC_CORE_GMAC;
	...
	*dma = dwmac1000_dma_ops;
	dma->init_chan = loongson_dwmac_dma_init_channel;
	dma->dma_interrupt = loongson_dwmac_dma_interrupt;
	...
loongson_dwmac_msi_config() {
	...
	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
	...
}

On multichan Loongson parts, stmmac_mac_interrupt() is installed on
dev->irq. Loongson is only kept out of the new path by the
core_type == DWMAC_CORE_GMAC4 check in stmmac_mac_interrupt(). That check
also keeps DMA_DIR_ERR away from loongson_dwmac_dma_interrupt(), which only
handles DMA_DIR_RX and DMA_DIR_TX.

Could the message give the real reason for excluding this core? For
example, Loongson reports abnormal status per direction (AIS_RX/AIS_TX,
FBI_RX/FBI_TX), and its per-channel RX/TX handlers clear it.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7ffed295eb14a..6360605ef5ead 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3145,6 +3145,22 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
>  	return status;
>  }
>  
> +static void stmmac_dma_err_interrupt(struct stmmac_priv *priv)
> +{
> +	u8 channels_to_check = max(priv->plat->rx_queues_to_use,
> +				   priv->plat->tx_queues_to_use);
> +	int status;
> +	u8 chan;
> +
> +	for (chan = 0; chan < channels_to_check; chan++) {
> +		status = stmmac_dma_interrupt_status(priv, priv->ioaddr,
> +						     &priv->xstats, chan,
> +						     DMA_DIR_ERR);
> +		if (unlikely(status & tx_hard_error))
> +			stmmac_global_err(priv);

[Severity: Medium]
Can the per-channel RX/TX MSI handlers clear FBE before this loop sees it?

DMA_CHAN_STATUS_MSK_ERR (AIS | FBE | RPS | RBU) is a subset of
DMA_CHAN_STATUS_MSK_RX. DMA_CHAN_STATUS_MSK_TX also includes AIS | FBE
through DMA_CHAN_STATUS_MSK_COMMON.

Every direction goes through dwmac4_dma_interrupt(). It reads
DMA_CHAN_STATUS and then acks what it read, with no lock in between:

	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(dwmac4_addrs, chan));
	...
	writel(intr_status & intr_en,
	       ioaddr + DMA_CHAN_STATUS(dwmac4_addrs, chan));

Suppose FBE latches while RI or TI is pending on the same channel. The
per-channel vector can then consume FBE first and drop the error:

stmmac_msi_intr_rx()
    stmmac_napi_check(priv, chan, DMA_DIR_RX);
        dwmac4_dma_interrupt()  /* clears FBE | AIS, returns tx_hard_error */
    /* return value is ignored */

stmmac_msi_intr_tx()
    status = stmmac_napi_check(priv, chan, DMA_DIR_TX);
    /* status is tx_hard_error | handle_tx when TI is also set */
    if (unlikely(status & tx_hard_error_bump_tc)) {
        ...
    } else if (unlikely(status == tx_hard_error)) {
        stmmac_tx_err(priv, chan);
    }

When stmmac_mac_interrupt() then runs for that event,
stmmac_dma_err_interrupt() finds FBE already cleared and does not call
stmmac_global_err(). The error is counted, but nothing resets the DMA
unless the TX watchdog happens to fire.

The commit message says stmmac_global_err() is called upon tx_hard_error
"to avoid possible races with other interrupts/napi". Does that only hold
when the MAC vector reads FBE first?

The overlap also means one RBU or RPS event can be counted twice in
rx_buf_unav_irq or rx_process_stopped_irq. This happens if the DMA_DIR_ERR
and DMA_DIR_RX paths both read the status before either one acks it.

Would it work to make the masks disjoint in multi-MSI mode? For example,
AIS/FBE/RBU/RPS could be dropped from the RX/TX masks when the ERR path
owns them.

Also, stmmac_request_irq_multi_msi() installs stmmac_mac_interrupt() on
wol_irq as well:

	ret = request_irq(priv->wol_irq,
			  stmmac_mac_interrupt,
			  0, int_name, dev);

Could two copies of this loop race over the same per-channel status
registers on different CPUs?

> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103125430.962715-1-maxime.chevallier%40bootlin.com
