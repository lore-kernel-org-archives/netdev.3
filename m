Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9B2673B0;
	Sat, 26 Sep 2026 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465626; cv=none; b=QZJimrczJKU1mzmL4cWN+GlTiR3d9jtijYfBLgGAirH70R8799SwNGz65IV8/f0cNL7aMgw2GQE1vebYHiRpMIyGa3S8p4BypEGTc8epG682Wvj7LL6mWpwZvqHSUMPQLTfUX+6x8N9jPXoqRRktHgO9tHw3Of0ESm6Cq/eyUrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465626; c=relaxed/simple;
	bh=MfGzSCc8SXHx1oywkMzxZQGcgBju3HaeHsl7BrLtmws=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UjR4sv8WZ/K9KoKHIDgEtHlgDzBpp62dqhD58SqH2RP8gOuBrAh5B/1HMicZ9zxN4A1hZtC89gSfqksE3tX3fhlSoke8jFJQR8Azz665bGrqYumd8QV+DHfgCZmTYRKKYHltTsnWEp9Ow/TLBR+ofeCf5tfF+uI1mPalwuLPpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRXjA+ZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRXjA+ZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07141F000FF;
	Sat, 26 Sep 2026 23:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790465624;
	bh=9RkUhFAL62ohEscAjBGNX48Voa4MxdKcG5fMWMesOEM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eRXjA+ZWYBY5SpjosjiSNnRcuD2bGsAOppwZrn26rDr2DTi0LG+wVEfD3cA0pHG1z
	 RVDvA+Cc12RqemZBm7+g/3bGDmTwh/QPziSN8xmFzvpLKxFEjli13KybXwxsOF1vNR
	 at3FaPCmjEB6Uq6yYijqEqV0nfES1krwVPIbEt7l7tQ8drsXevcrAKpE+mtxXRlRot
	 fHMZ37Ew7cg6s70HKY/uaDbccZFrJ49tsYyUB4kznQv5cdjIuhoK6OQK/3orgrfhCq
	 9rzf/JBvk5j1kX/ESEuq8DiVVcQfzD1ybpT7aDeHCSxE7e7tc+ow262nQeQuc+YQyZ
	 i7UCQSkFE0Dng==
Subject: Re: [PATCH] net: stmmac: dwxgmac2: enable L2 split header support
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
Date: Sat, 26 Sep 2026 23:33:43 +0000
Message-ID: <179046562333.2160803.721625925826147093@kernel.org>
In-Reply-To: <20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com>
References: <20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new writes in dwxgmac2_enable_sph() use XGMAC register
  offsets, but the XLGMAC core runs the same code and its register map…
- [High] net: stmmac: kernel memory information leak in split-header path
- [Medium] In dwxgmac2_enable_sph(), the new MAC-global writes (SPLM(1)
  and SAVE_EN in XGMAC_EXT_CFG1, and clearing VPRE in XGMAC_EXT_CFG0)…
- [Low] The commit message says it fixes an existing bug in
  dwxgmac2_get_rx_header_len(): on a first-but-not-last descriptor,…

--

net: stmmac: dwxgmac2: enable L2 split header support

This patch programs SPLM and SAVE_EN in XGMAC_EXT_CFG1 and clears the
variable-length preamble bit in XGMAC_EXT_CFG0 from dwxgmac2_enable_sph().
It also changes dwxgmac2_get_rx_header_len() to read RDES2[9:0] on
non-last descriptors, and adds L2T-based header length decoding on the
last descriptor.

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
> +		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> +		return;
> +	}

[Severity: Low]
The commit message presents this as a fix for an existing bug: on a
first-but-not-last descriptor, RDES3.L34T can hold stale write-back data.
The L34T-gated logic being replaced came from commit 67afd6d1cfdf ("net:
stmmac: Add Split Header support and enable it in XGMAC cores") and commit
96147375d49f ("net: stmmac: xgmac: Only get SPH header len if available").

If that is correct, current kernels would compute the wrong buffer 1
length for multi-descriptor split packets in stmmac_rx_buf1_len():

	stmmac_get_rx_header_len(priv, p, &hlen);
	if (priv->sph_active && hlen) {

Could this part go in its own patch with a Fixes: tag, so it can reach
stable? Right now it is bundled into a feature patch. The new
L2T/NONIPHL decoding also relies on the SPLM/SAVE_EN programming added
in the same patch, so the fix cannot be backported by itself.

> +
> +	if (rdes3 & XGMAC_RDES3_L34T)
>  		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> +	else if (rdes3 & XGMAC_RDES3_L2T)
> +		*len = (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
>  }

[Severity: High]
The non-IP path masks RDES2 with GENMASK(9, 2) and shifts the result
down by 2. If RDES2 holds the header length in bytes, as it does on
the L34T path, this gives roughly a quarter of the real length. A
14-byte untagged Ethernet header becomes 3, and an 18-byte tagged
header becomes 4.

stmmac_rx_buf1_len() returns that hlen as the buffer 1 length on the
first descriptor. stmmac_rx_buf2_len() then computes the buffer 2
length on the last descriptor as the frame length minus the
accumulated len. An undersized buffer 1 length therefore has two
effects:

- the header copied into the skb is truncated;
- buffer 2 is treated as longer than what the DMA wrote, by the same
  number of bytes.

Those trailing bytes come from a recycled page_pool page. They can
hold data from an earlier packet, which is then handed to the stack
and possibly to userspace or forwarded out.

The wire can trigger this with any non-IP frame (ARP, AVTP, ...) that
fits in one descriptor, since FD and LD are both set then. That is the
common case for the tagged AV traffic this patch targets.

This is also inconsistent within the function. The non-last
descriptor path just above reads RDES2[9:0] with no shift.
dwmac4_get_rx_header_len() uses RDES2_HL, bits 9:0, directly as a
byte count.

What unit does the XGMAC2 databook give for the header length on L2T
packets? If it is a byte count in RDES2[9:0], should the mask and
shift be dropped? If the field really is an 8-bit byte count starting
at bit 2, could a comment or the commit message say so, and explain
why the non-LD path reads the same register differently?

[ ... ]

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

[Severity: High]
XLGMAC cores run this code as well. Is offset 0x140 still EXT_CFG0 on
those cores? The XLGMAC entry in stmmac_hw[] in hwif.c reuses the XGMAC
DMA ops:

		.dma = &dwxgmac210_dma_ops,
		.mac = &dwxlgmac2_ops,

On XLGMAC, 0x140 is the RX queue enable register (dwxlgmac2.h):

#define XLGMAC_RXQ_ENABLE_CTRL0		0x00000140

dwxlgmac2_rx_queue_enable() programs it using 2-bit per-queue fields:

	value = readl(ioaddr + XLGMAC_RXQ_ENABLE_CTRL0) & ~XGMAC_RXQEN(queue);
	if (mode == MTL_QUEUE_AVB)
		value |= 0x1 << XGMAC_RXQEN_SHIFT(queue);

With RX queue 4 in AVB mode, that sets BIT(8), which is the same bit as
XGMAC_EXT_CFG0_VPRE. Would clearing VPRE here disable RX queue 4 on
XLGMAC?

In stmmac_hw_setup(), stmmac_mtl_configuration() ->
stmmac_mac_enable_rx_queues() runs first. The split header loop runs
after it, with no sph_capable check:

	sph_en = (priv->hw->rx_csum > 0) && priv->sph_active;
	for (chan = 0; chan < rx_cnt; chan++)
		stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);

That means the clear would happen on every open, whether or not SPH is
supported. stmmac_xdp_open() and stmmac_set_features() repeat it.

The EXT_CFG1 write at 0x144 (SPLM bits 9:8 and bit 24) also lands on
XLGMAC. The driver headers do not say what register sits at that
offset on XLGMAC.

Should these writes be limited to XGMAC cores?

> +
>  	value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
>  	if (en)
>  		value |= XGMAC_SPH;

[Severity: Medium]
Only XGMAC_SPH depends on en here. The new MAC-global EXT_CFG0/EXT_CFG1
writes run for both values of en.

stmmac_hw_setup() and stmmac_xdp_open() call stmmac_enable_sph() for
every RX channel without checking priv->sph_capable. Does this mean
every XGMAC gets VPRE cleared and SPLM/SAVE_EN set? That would include
parts without SPH, parts with STMMAC_FLAG_SPH_DISABLE, and parts where
SPH is inactive because of XDP or because rx_csum is off.

That does not match the commit message:

    Finally, disable the variable-length preamble when L2 splitting
    is enabled.

When SPH is turned off at runtime, through stmmac_set_features() or an
XDP attach via stmmac_xdp_open(), only the DMA SPH bit is cleared. VPRE
is never restored, and SPLM/SAVE_EN are never cleared.

Also, value |= XGMAC_CONFIG1_SPLM(1) does not clear GENMASK(9, 8) first.
If the field already holds a non-zero value, it is ORed with 1 rather
than replaced. And since enable_sph() is called per channel, these
MAC-global writes are repeated once per RX channel.

dwmac4_enable_sph() also writes SPLM/SAVE_EN unconditionally, but the
unconditional VPRE clear is new in this patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922232116.889630-1-sagar.cheluvegowda%40oss.qualcomm.com
