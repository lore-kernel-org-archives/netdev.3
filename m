Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448992;
	b=I7UvYnj9LbYyPHYt+QCc6H/krIJ86GX4TXkjHV/t26zhf7XWUd5q8pR/T7pETK3XQh1u
	 nfmo0oJ8DlzpHhfQF09CJ0YfrMg9sg99pBAM4Ld20Yl7H8Jkymmv6j9l9F7QoA4SNBEQt
	 U48mJmzOVzfplCOyGTFLCKIyP1PoBpyvoScHL+s+1Eqtjk0OKijAAmi26Q3jLKs0bDPfq
	 A095LJNGPcdeNKGHNXEmWJ7hfQNLrSrrDD0xEOkmQO980gxy29O9Den2X83jJag/B7q4K
	 u4D6D7mmF2qJBX9arE9R3gzRnVdiWuytV0nV6X+ez7/qELwYdWt4oEM4Eeysd+0xNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448992;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bn0LUV8nV0X9AL2Oe4mZF4R4gBNcAcDh87LSeEPK0aQ=;
	b=wOJBytxu6qIeGFTqjw09ACZmjtvUR7fOD5Vu86+W1W9U/v6WYFXGat2A3+ol3dWoBLpD
	 rX8UheofdpssNmS3oZJUvDYa7Mqx6n5ozdxabjS00wkdufA++euaJT1XRfuaYbQGpFXCT
	 1l6frqhvju4QzgNZoD0WmjnM/JD02BhwyOYr8i8RwljlWwegWVdeSOCaBvlhMNpmJvoze
	 3hb0cFEjjKGw5T1ACDmSb12gTDQxwGenoNMCQzXOQA2pj46VYC6LNMW5lfoW9F6u2C6Ht
	 kQGvdtdf0/uFVfr6uJGVlmPGneA52fSQ+AW2sEDRG3V0Mby+RvkuCB9PLZNcmCyDIWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYpjPcO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E026606A31B;
	Mon, 19 Oct 2026 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYpjPcO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3FE1F000C4;
	Mon, 19 Oct 2026 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448991;
	bh=bn0LUV8nV0X9AL2Oe4mZF4R4gBNcAcDh87LSeEPK0aQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oYpjPcO4+qyVgDvU0SXTwuY03Cd2EM9GgCLwi1KJycLvfsoISiFgeC+/vCtrHS6XR
	 WwUhW/XFyuaRVUFj3NDGImX7TebArRQIIRgpbiMqQi1CKZbOs5FOYy8ovxKjJC+mQA
	 Q0H59J9WpJ6lbBRizcyO2B1xnIGHmo5eGZOKjPL/JRuxXDhbQ/M+9u/m0YbZpdkOgz
	 aglhJjgWCro1GTi7eqZpbYGPMQJMxMCOsGvR9q+PZ9WAQcd97d/zMaKSIvmFS/+ZjJ
	 hSvgRSVWV5eLah25O2qz/oO0LyVuwyT814urBfaEYZyU2Y8gDWyELU4tdOqKNXj8Qy
	 q7tJkkGi/z8/Q==
Subject:
 Re: [PATCH net-next v4] net: stmmac: dwxgmac2: enable L2 split header support
From: netdev-bot+sashiko@kernel.org
To: sagar.cheluvegowda@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lorenzo.bianconi@oss.qualcomm.com, hongmei.xu@oss.qualcomm.com,
 abhishek.chauhan@oss.qualcomm.com, sarosh.hasan@oss.qualcomm.com
Date: Mon, 19 Oct 2026 22:29:49 +0000
Message-ID: <179244898962.3135.12890405028818098249@kernel.org>
In-Reply-To: <20261015221215.1714047-1-sagar.cheluvegowda@oss.qualcomm.com>
References: <20261015221215.1714047-1-sagar.cheluvegowda@oss.qualcomm.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On XLGMAC cores, dwxgmac2_enable_sph() now corrupts the RX queue
  enable register.
- [Medium] dwxgmac2_enable_sph() programs MAC-global split and preamble
  settings regardless of `en`.
- [Low] The patch includes a fix for an existing XGMAC split-header bug
  inside a feature patch, with no Fixes: tag.
- [Low] dwxgmac2_enable_sph() sets the 2-bit SPLM field
  (XGMAC_CONFIG1_SPLM_MASK = GENMASK(9,8)) with `value |=…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the stmmac
  RX path has no dma_rmb() between seeing RDES3.OWN cleared and reading…

--

net: stmmac: dwxgmac2: enable L2 split header support

This patch makes dwxgmac2_enable_sph() program SPLM and SAVE_EN in
XGMAC_EXT_CFG1 and clear the variable preamble bit in XGMAC_EXT_CFG0. It
also changes dwxgmac2_get_rx_header_len() so the header length is read
only on the first descriptor. For non-IP (L2T) packets on the last
descriptor, the length comes from RDES2[9:2].

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index 6719ac6e395bc..b28aa39f99472 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -292,8 +292,22 @@ static int dwxgmac2_get_rx_hash(struct dma_desc *p, u32 *hash,
>  
>  static void dwxgmac2_get_rx_header_len(struct dma_desc *p, unsigned int *len)
>  {
> -	if (le32_to_cpu(p->des3) & XGMAC_RDES3_L34T)
> +	u32 rdes3 = le32_to_cpu(p->des3);
> +
> +	/* HL is only defined on the first descriptor */
> +	if (!(rdes3 & XGMAC_RDES3_FD))
> +		return;
> +
> +	/* when FD=1 and LD=0, HL is RDES2[9:0] */
> +	if (!(rdes3 & XGMAC_RDES3_LD)) {
> +		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> +		return;
> +	}

[Severity: Low]
Should this FD/LD handling go in its own patch with a Fixes: tag?

The commit message says L34T can hold stale data on a non-last
descriptor. If so, the old code:

	if (le32_to_cpu(p->des3) & XGMAC_RDES3_L34T)
		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;

could return hlen == 0 for the first descriptor of a multi-descriptor IP
frame with SPH active. stmmac_rx_buf1_len() would then take this path:

	/* Not last descriptor and not split header: buffer1 is fully filled */
	if (status & rx_not_ls)
		return priv->dma_conf.dma_buf_sz;

even though buffer 1 only holds the header.

That looks like an existing XGMAC split-header bug in the code from
commit 96147375d49f ("net: stmmac: xgmac: Only get SPH header len if
available"). With the fix bundled into this feature patch, stable trees
would also need the new EXT_CFG0/EXT_CFG1 programming to pick it up.

> +
> +	if (rdes3 & XGMAC_RDES3_L34T)
>  		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> +	else if (rdes3 & XGMAC_RDES3_L2T)
> +		*len = (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
is a dma_rmb() missing between the OWN check and the read of des2 here?

dwxgmac2_get_rx_status() loads des3 and des2, then checks OWN:

	u32 rdes3 = le32_to_cpu(p->des3);
	u32 rdes2 = le32_to_cpu(p->des2);

	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
		return dma_own;

stmmac_rx() then calls stmmac_rx_buf1_len()->dwxgmac2_get_rx_header_len()
with no barrier in between. The TX completion path in stmmac_main.c calls
dma_rmb() after its own check, and dwxgmac2_rx_check_timestamp() also
uses one.

On weakly ordered CPUs, could the RDES2 load complete before OWN is seen
as cleared? That would give a stale HL and a wrong buf1_len.

The new FD/LD logic doesn't depend on this ordering.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index ff83858ebc1f3..0a9c787305a4e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -561,6 +561,16 @@ static void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	value |= XGMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
>  	writel(value, ioaddr + XGMAC_RX_CONFIG);
>  
> +	value = readl(ioaddr + XGMAC_EXT_CFG1);
> +	value |= XGMAC_CONFIG1_SPLM(1);

[Severity: Low]
SPLM is a two-bit field (GENMASK(9, 8)). Should it be cleared with
XGMAC_CONFIG1_SPLM_MASK before the OR, the way HDSMS is handled just
above?

	value &= ~XGMAC_CONFIG_HDSMS;
	value |= XGMAC_CONFIG_HDSMS_256;

If bit 9 were already set, the field would end up as 3 instead of mode 1.

In stmmac_hw_setup(), the SWR from stmmac_init_dma_engine()->
stmmac_reset() runs before this. So in practice the result depends on
the register's reset value.

> +	value |= XGMAC_CONFIG1_SAVE_EN;
> +	writel(value, ioaddr + XGMAC_EXT_CFG1);
> +
> +	/* Disable variable preambles to keep the L2 split offset deterministic. */
> +	value = readl(ioaddr + XGMAC_EXT_CFG0);
> +	value &= ~XGMAC_EXT_CFG0_VPRE;
> +	writel(value, ioaddr + XGMAC_EXT_CFG0);

[Severity: High]
Can this corrupt the RX queue enable register on XLGMAC cores?

The DWXLGMAC_CORE_2_00 entry in hwif.c uses the same DMA ops as XGMAC:

	.desc = &dwxgmac210_desc_ops,
	.dma = &dwxgmac210_dma_ops,
	.mac = &dwxlgmac2_ops,

so dwxgmac2_enable_sph() runs there too. On XLGMAC, dwxlgmac2.h defines
offset 0x140 as:

	#define XLGMAC_RXQ_ENABLE_CTRL0		0x00000140

and dwxlgmac2_rx_queue_enable() programs it like this:

	value = readl(ioaddr + XLGMAC_RXQ_ENABLE_CTRL0) & ~XGMAC_RXQEN(queue);
	if (mode == MTL_QUEUE_AVB)
		value |= 0x1 << XGMAC_RXQEN_SHIFT(queue);

BIT(8) is therefore the AVB enable for RX queue 4. Clearing
XGMAC_EXT_CFG0_VPRE would disable that queue.

The write to 0x144 also sets BIT(8) and BIT(24) in an XLGMAC register
that the driver doesn't describe.

stmmac_hw_setup() enables the MTL queues through
stmmac_mtl_configuration() first. Later it runs:

	sph_en = (priv->hw->rx_csum > 0) && priv->sph_active;
	for (chan = 0; chan < rx_cnt; chan++)
		stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);

There is no sph_capable or core check, so this would happen on every
XLGMAC open, whether or not split header is supported. Should this be
gated on the core type, or moved into a per-core MAC op?

> +
>  	value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
>  	if (en)
>  		value |= XGMAC_SPH;

[Severity: Medium]
Only the per-channel XGMAC_SPH bit depends on en here. SPLM/SAVE_EN are
set and VPRE is cleared on every call, and nothing restores them.

stmmac_hw_setup() calls stmmac_enable_sph() for every RX channel, even
when sph_en is false or the core has no SPH support.
stmmac_set_features() calls it with sph_en == false when NETIF_F_RXCSUM
is cleared, and stmmac_xdp_open() also calls it.

Doesn't that leave the variable preamble disabled on every XGMAC device
after hw_setup? It would also stay disabled after split header is turned
off with ethtool.

The commit message says:

    Finally, disable the variable-length preamble when L2 splitting
    is enabled.

which doesn't seem to match this behavior.

Also, dwmac4_enable_sph(), which this extends, doesn't change the
preamble configuration. And these MAC-global read-modify-writes are
repeated once per RX channel.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015221215.1714047-1-sagar.cheluvegowda%40oss.qualcomm.com
