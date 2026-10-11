Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774E3603DF;
	Sun, 11 Oct 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746017; cv=none; b=fD4xPW/M04vWof3nMEU2n6Y2l+vxOQ76EWOp6Mnkq+uDi6tU0V9fE8YRfRDOOX7TpJH3QGClAdeosNONFqGDUeSJRoBdMeyMSJpXe9k3Ey6P5xYdx5EeMZM2S0sCzX+aLkGUyGcf3Hxq8b2snZwvyXecDiOYnU40Y8kWFkgK5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746017; c=relaxed/simple;
	bh=ZGV2vIh0/KBGU1oZwFmHUpi4kBz6Xm2Llfiyjwm8VTs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkVBgzyVOsaKK8sOiN222WohmSr+dC8Se+3hko5gOZiR+5UHoi1StfzP4Rcf4tqFFEjrfBWdygVS02GnkD1R498CZvXQAaEV5mRL8pTpVnPrz097g0Siq6L4sN6SB/34mN9dxniQsehKGZkHLc6uQL6WEYK25WrlyMFXmMz7y/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4u/IgrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4u/IgrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC84D1F0089B;
	Sun, 11 Oct 2026 19:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791746015;
	bh=oFMGe7A7jXBHyDAEo+RvnvGYBzGkORWLEt7pLGKtQtA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H4u/IgrRqHLPj8XKdbQrORvWlM4V0UeY31e1XGeREclAhdqFiZiUbfXc1rBi3mVjm
	 YdwyR/2zj+kcyTm8iziNhFs3oOVw2HS74Z37C4aCCsPoadPkIWNwixRBa4C4ll55Lc
	 cf17Uo6P35DT0W99oKb0+HGJ7JAQU1n9pflLBA30IYQ8mGuQrNl4jwoEBWqkuAhRVT
	 Yi+3246yC8h6PS+tYZSLJok4xO/gHMZImgOA1D3KQN1W/W0vCK5ZmYtt10ZL0nAsz3
	 3yjRfM/zy60YQoF4Uo/GihhqBFi1/aS1MtzxjAry1/UQwDbwpGT7Xa9i22l2qpxHC/
	 6Ahv6GWX+8Nwg==
Subject:
 Re: [PATCH net-next v2] net: stmmac: dwxgmac2: enable L2 split header support
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
Date: Sun, 11 Oct 2026 19:13:34 +0000
Message-ID: <179174601434.434549.13553290378854885570@kernel.org>
In-Reply-To: <20261007183905.2582759-1-sagar.cheluvegowda@oss.qualcomm.com>
References: <20261007183905.2582759-1-sagar.cheluvegowda@oss.qualcomm.com>
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
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On XLGMAC cores, dwxgmac2_enable_sph() writes to the wrong
  registers.
- [High] net: stmmac: incorrect shift in non-IP header length calculation
- [Medium] dwxgmac2_enable_sph() programs the MAC-wide split
  configuration regardless of `en` or split-header capability, which…
- [Medium] stmmac: missing mask clear before setting XGMAC_CONFIG1_SPLM
  field
- [Low] The commit message presents the RX header-length change in
  dwxgmac2_get_rx_header_len() as a fix for an existing defect: RDES3…
- [Low] net: stmmac: dwxgmac2: missing mask when setting multi-bit SPLM
  field

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the error
  handling in stmmac_rx() can lose the partial-packet state.
- [Medium] This problem wasn't introduced by this patch, but the XGMAC RX
  path reads descriptor write-back fields without a DMA read barrier…

--

net: stmmac: dwxgmac2: enable L2 split header support

This patch makes dwxgmac2_enable_sph() set SPLM and SAVE_EN in
XGMAC_EXT_CFG1 and clear VPRE in XGMAC_EXT_CFG0, so that L2 header
splitting works on XGMAC2. It also changes dwxgmac2_get_rx_header_len().
On non-last descriptors it now reads the header length from RDES2[9:0]
directly. On the last descriptor it uses RDES2[9:2] for non-IP packets
that have L2T set.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index 6719ac6e395bc..65ac5403ec583 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -292,8 +292,18 @@ static int dwxgmac2_get_rx_hash(struct dma_desc *p, u32 *hash,
>
>  static void dwxgmac2_get_rx_header_len(struct dma_desc *p, unsigned int *len)
>  {
> -	if (le32_to_cpu(p->des3) & XGMAC_RDES3_L34T)
> +	u32 rdes3 = le32_to_cpu(p->des3);
> +
> +	/* when FD=1 and LD=0, HL is RDES2[9:0] */
> +	if (!(rdes3 & XGMAC_RDES3_LD)) {

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The
comment says FD=1, but the code never checks FD. Can a continuation
descriptor get here and be treated as a first descriptor?

In stmmac_rx(), suppose napi_build_skb() fails on the first descriptor
of a multi-descriptor packet:

stmmac_rx() {
    ...
			skb = napi_build_skb(page_address(buf->page),
					     rx_q->napi_skb_frag_size);
			if (!skb) {
				page_pool_recycle_direct(rx_q->page_pool,
							 buf->page);
				buf->page = NULL;
				rx_dropped++;
				count++;
				goto drain_data;
			}
    ...
}

error is not set, and the code goes back to read_again. If the next
descriptor is still owned by the DMA, status is dma_own and the loop
exits. The state save is then skipped, because status has no
rx_not_ls and skb is NULL:

	if (status & rx_not_ls || skb) {
		rx_q->state_saved = true;
		...
	}

On the next poll, len and error are both 0 even though the descriptor
is a continuation. That bypasses this guard in stmmac_rx_buf1_len():

	if (priv->sph_active && len)
		return 0;

dwxgmac2_get_rx_header_len() is then called on a descriptor with FD
clear.

Would buffer 1 of that continuation be handled as the header of a new
packet, so a malformed packet reaches the stack? Split IP packets
could already hit this before the patch. The patch only changes which
RDES2 field gets read here.

> +		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> +		return;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but is there an ordering
problem between the OWN check and this RDES2 read?
dwxgmac2_get_rx_status() checks OWN first:

	u32 rdes3 = le32_to_cpu(p->des3);
	u32 rdes2 = le32_to_cpu(p->des2);

	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
		return dma_own;

stmmac_rx() then reads des2 again through
stmmac_rx_buf1_len()->stmmac_get_rx_header_len()->
dwxgmac2_get_rx_header_len(). There is no dma_rmb() between the two
reads on this path.

On weakly ordered platforms, could the RDES2 load complete before the
RDES3 load that sees OWN cleared, and return a stale header length?
This patch now reads RDES2 in more cases (non-last descriptors and L2T
packets).

> +
> +	if (rdes3 & XGMAC_RDES3_L34T)
>  		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> +	else if (rdes3 & XGMAC_RDES3_L2T)
> +		*len = (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
>  }

[Severity: High]
Does this shift turn a byte count into a dword count?

If RDES2[9:2] holds the non-IP header length in units of 4 bytes, the
value masked with XGMAC_RDES2_NONIPHL is already the length in bytes.
Shifting it right by 2 then gives the number of dwords instead.

stmmac_rx_buf1_len() passes hlen straight back to stmmac_rx() as a
byte count:

	stmmac_get_rx_header_len(priv, p, &hlen);
	if (priv->sph_active && hlen) {
		priv->xstats.rx_split_hdr_pkt_n++;
		return hlen;
	}

stmmac_rx() then uses buf1_len for dma_sync_single_for_cpu(),
xdp_prepare_buff() and the skb_put() on the head buffer. For a 16-byte
header this returns 4, so only 4 bytes of the Ethernet header land in
the linear part of the skb, and buffer 2 is attached after them as a
frag. The rest of the header is lost.

Wouldn't stmmac_rx_vlan() and eth_type_trans() then read past the
4-byte linear area, and the ETH_HLEN pull in eth_type_trans() hit the
BUG() in __skb_pull()?

The L34T case right above uses RDES2[9:0] as a byte count with no
shift. Can you confirm against the databook whether the non-IP case
really needs the >> 2?

[Severity: Low]
The commit message describes this change as a fix for an existing
defect:

  Also fix the RX header-length calculation for split-header
  descriptors. Per the XGMAC2 descriptor format, RDES3's L34T and
  L2T fields are only valid on the last descriptor (LD set); on a
  non-last descriptor they can hold stale write-back data from a
  previous packet.

The L34T-gated read being replaced came from commit 96147375d49f
("net: stmmac: xgmac: Only get SPH header len if available").

If that premise holds, existing XGMAC SPH users can get hlen == 0 on a
split first descriptor. They then fall through to this in
stmmac_rx_buf1_len():

	if (status & rx_not_ls)
		return priv->dma_conf.dma_buf_sz;

Should this part go in its own patch with a Fixes: tag? Then it could
be backported without the new L2 split and VPRE changes.

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
> +	value |= XGMAC_CONFIG1_SAVE_EN;
> +	writel(value, ioaddr + XGMAC_EXT_CFG1);
> +
> +	/* Disable variable preambles to keep the L2 split offset deterministic. */
> +	value = readl(ioaddr + XGMAC_EXT_CFG0);
> +	value &= ~XGMAC_EXT_CFG0_VPRE;
> +	writel(value, ioaddr + XGMAC_EXT_CFG0);

[Severity: Medium]
This read-modify-write keeps whatever was in bits 9:8 of
XGMAC_EXT_CFG1 and ORs in SPLM=1 on top. If a bootloader or earlier
firmware left SPLM at 2, the register ends up with SPLM=3 instead of
the L2 offset mode this patch wants.

dwxgmac2_enable_sph() is called from stmmac_hw_setup() for every RX
channel, and again from the XDP and stmmac_set_features() paths. None
of those calls would ever correct the field, so the MAC would stay in
whatever split mode the combined value selects. What does SPLM=3 do on
XGMAC2? If it is reserved or selects a different split point, the
header length the hardware reports would no longer match what
dwxgmac2_get_rx_header_len() expects.

dwmac4_enable_sph() looks to have the same pattern for GMAC_EXT_CFG1,
so copying it here carries the issue over. Should the field be cleared
with XGMAC_CONFIG1_SPLM_MASK before XGMAC_CONFIG1_SPLM(1) is applied?

[Severity: Low]
XGMAC_CONFIG1_SPLM_MASK is a two-bit field, GENMASK(9, 8), but the
old contents of that field are never cleared before the new value is
ORed in. If bit 9 is already set when dwxgmac2_enable_sph() runs, the
field ends up as 3 rather than 1.

The reset value is probably 0, so this may not matter in practice.
Still, the usual pattern for FIELD_PREP() in a read-modify-write is to
clear the mask first:

	value &= ~XGMAC_CONFIG1_SPLM_MASK;
	value |= XGMAC_CONFIG1_SPLM(1);

The v2 changelog says the mask was added for XGMAC_CONFIG1_SPLM().
Could it also be used here to clear the field?

[Severity: High]
Can this clear an RX queue enable bit on XLGMAC? The DWXLGMAC_ID entry
in stmmac_hw[] in hwif.c uses the XGMAC DMA ops:

		.desc = &dwxgmac210_desc_ops,
		.dma = &dwxgmac210_dma_ops,
		.mac = &dwxlgmac2_ops,

That means dwxgmac2_enable_sph() also runs on XLGMAC. On that core,
offset 0x140 is the RX queue enable register in dwxlgmac2.h:

#define XLGMAC_RXQ_ENABLE_CTRL0		0x00000140

dwxlgmac2_rx_queue_enable() programs a 2-bit enable field per queue in
that register:

	if (mode == MTL_QUEUE_AVB)
		value |= 0x1 << XGMAC_RXQEN_SHIFT(queue);

For queue 4 in AVB mode this is BIT(8). That is the same bit this code
clears as XGMAC_EXT_CFG0_VPRE.

stmmac_hw_setup() enables the RX queues in stmmac_mtl_configuration().
After that, it calls stmmac_enable_sph() for every RX channel, without
checking sph_capable or the core type:

	sph_en = (priv->hw->rx_csum > 0) && priv->sph_active;
	for (chan = 0; chan < rx_cnt; chan++)
		stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);

Would an AVB-mode RX queue 4 on XLGMAC end up disabled after every
open, every XDP reconfiguration, and every stmmac_set_features() call?

The write to 0x144 also sets bits 8 and 24 on XLGMAC, and the driver
doesn't define what that offset holds on that core.

Should these MAC register writes move into the per-core MAC ops, or be
gated on the core ID?

>  	value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
>  	if (en)
>  		value |= XGMAC_SPH;

[Severity: Medium]
The XGMAC_EXT_CFG1 and XGMAC_EXT_CFG0 writes above run whether or not
en is set. Only the per-channel XGMAC_SPH bit depends on en. The
commit message says:

  Finally, disable the variable-length preamble when L2 splitting
  is enabled.

stmmac_hw_setup() and the XDP setup path call stmmac_enable_sph() for
every RX channel without checking priv->sph_capable. Does that mean
every XGMAC instance gets SPLM and SAVE_EN set and VPRE cleared? That
would include cores without SPH, STMMAC_FLAG_SPH_DISABLE setups, setups
with XDP attached, and setups with RX checksum off.

The en == false path, for example stmmac_set_features() after ethtool
-K rx off, also never clears SPLM/SAVE_EN or restores VPRE. The dwmac4
sequence sets SPLM/SAVE_EN unconditionally too, but the VPRE change is
new.

Should these settings be applied only when en is true, and undone
otherwise?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007183905.2582759-1-sagar.cheluvegowda%40oss.qualcomm.com
