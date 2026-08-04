Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0513E558C;
	Tue,  4 Aug 2026 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808125; cv=none; b=fwu7J2zmTY7ermPfeitmfySt/u60+AN9ew1H+S+lfMscK7xSDoikaOmxtECYSyeVcgFvzlLMHIbx00RqK6WHvxFGRSmXWqvQJKlbD+QzwCrNoykizwOmgRhdmNO1RFet/A+SbCYZC8UHje0WRPxzKOR//CUNqr62eS/DZnIwFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808125; c=relaxed/simple;
	bh=GdBrPCmLTTSeYl2vrGZ24aPjvdnAQDGYXxoUy+REh8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5aGRUw8Z8/PQt3p2YgQPfsa/YXrxJMHGYIg6d9udmBW/DbRiJj6SY6d2WGTQJj/gBVSEE39Nr0xF/5gvIVknu+20qRSI30CBXGfHJhQf0mvolyl0xAyQGo7/kwYtI0YKp8LNl/c0yeRpYjIz+tgL+Sef0pdvhi3VjqTnVUxK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ+0cI+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ+0cI+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC9F1F00A3A;
	Tue,  4 Aug 2026 01:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808124;
	bh=KOj/MoIuWTIbulUmAd9OiQ8Ymew8MDhrYEbW1DUwYUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZ+0cI+OfocFuubmx3Nw24umAr8gIJO4NI3+yXOpNc0Gm2iBDjG039+DEdkPWa8Y7
	 gz8l8AZkDMwELY/eySGpbdu5wRrPTU4fIh6pfSBYcT4T9hkio2NlT68wFiFa+gYKHX
	 /sMQQ+rl4o5jS54NUocf1W1/2UCPmJYUEt8cdRgvDSiVMCsSlfJ6nRGgPctGctsMWH
	 mOm44ZPNynsb9o/3ejSXnJTlzKcd2ipryvx1LS8fan8+VZCorjSnNMVXkILjKxaWY1
	 BlD5pFSD6ZhbSMt+n7z3LwAGNhF+nl+9eebm1v8h31OZIb4sKnwpcSMNOmjIB6f+qD
	 CzvtctOTswoYw==
From: Jakub Kicinski <kuba@kernel.org>
To: alexander.duyck@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mike.marciniszyn@gmail.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	jiawenwu@trustnetic.com,
	kees@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	mengyuanlou@net-swift.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com
Subject: Re: [net-next PATCH v4 3/4] net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
Date: Mon,  3 Aug 2026 18:48:42 -0700
Message-ID: <20260804014842.2532708-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178536379932.250758.16153445046800294554.stgit@ahduyck-xeon-server.home.arpa>
References: <178536379932.250758.16153445046800294554.stgit@ahduyck-xeon-server.home.arpa>
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
--- Patch [3]: [net-next PATCH v4 3/4] net: pcs: xpcs: Add hooks for xpcs configuration of rsfec ---
commit 6935ace349fd9a75ff7b20b38cca3d38ecc8571b
Author: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

net: pcs: xpcs: Add hooks for xpcs configuration of rsfec

This adds a per-interface-mode .pma_config hook to the Synopsys xPCS
compat table and uses it to write MDIO_PMA_RSFEC_CTRL for 25GBASE-R,
50GBASE-R, LAUI and 100GBASE-P. A new vendor bit is added to pcs-xpcs.h
and a new bit define is added to include/uapi/linux/mdio.h.

A few questions below.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index a6b993745f3be..3800c129dae2e 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -1394,6 +1394,69 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
>  	return 0;
>  }
>  
> +struct pma_pcs_values {
> +	int channels;
> +	u16 rsfec_ctrl;
> +};
> +
> +static int
> +xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
> +{
> +	/* fbnic's DW IP exposes the RS-FEC PMA at SEP_PMA1, so use it
> +	 * directly. Scanning DEVS1 for the correct PMA MMD is left as future
> +	 * work for enabling a non-fbnic device on this PCS.
> +	 */
> +	int pma_mmd = MDIO_MMD_SEP_PMA1;
> +	int ret = 0, i;
> +
> +	for (i = 0; ret >= 0 && i < v->channels; i++) {
> +		ret = xpcs_mdev_write_ch(xpcs, i, pma_mmd,
> +					 MDIO_PMA_RSFEC_CTRL, v->rsfec_ctrl);
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
[Finding: main-1-0]
[Sources: opus-5, sonnet-5]
The comment states the SEP_PMA1 placement is an fbnic property, but the
hooks below are attached to synopsys_xpcs_compat[], which xpcs_identify()
selects for every device matching DW_XPCS_ID/DW_XPCS_ID_MASK (stmmac via
xpcs_create_fwnode()/xpcs_create_mdiodev(), ksz9477, txgbe SP). Should
these hooks be gated on xpcs->info.pma, or live in a device specific
compat table?

The file already has both mechanisms: xpcs_do_config() checks
WX_TXGBE_XPCS_PMA_10G_ID, xpcs_create() checks
MP_FBNIC_XPCS_PMA_100G_ID, and nxp_sja1105_xpcs_compat /
nxp_sja1110_xpcs_compat show the separate table approach.

There is also no MDIO_DEVS1 / MDIO_DEVS_SEP_PMA1 presence check before
writing, so on a DW xPCS that does not implement SEP_PMA1 this writes
into an MMD that may not exist. Is that intended?

Second question on the same loop: the iteration count comes from
v->channels rather than xpcs->channels. Given:

drivers/net/pcs/pcs-xpcs.c:xpcs_mdev_write_ch() {
	if (ch >= xpcs->channels)
		return -ENXIO;
	...
}

and xpcs_do_config() propagating the pma_config() error, wouldn't a
single channel xPCS instance selecting PHY_INTERFACE_MODE_LAUI or
PHY_INTERFACE_MODE_100GBASEP (both .channels = 2 below) fail interface
configuration outright with -ENXIO, after channel 0 has already been
written and with no unwind of that write?

In the current tree fbnic creates its PCS with two addresses so
xpcs->channels is 2 and this is not reachable today, and the 25G
Wangxun AML part never instantiates an xPCS at all, so this looks
latent rather than an active regression. Would deriving the loop bound
from xpcs->channels avoid it entirely?

> +
> +static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
> +{
> +	const struct pma_pcs_values v = {
> +		.rsfec_ctrl = 0,
> +		.channels = 1,
> +	};

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]
The commit message says this "enables the correct FEC settings to enable
RS-FEC encoding on the link". Which write sets an RS-FEC enable bit?

For 25GBASE-R the value written to MDIO_PMA_RSFEC_CTRL is a literal 0.
The other three hooks write only DW_VR_RSFEC_CTRL_TC_PAD_ALTER (BIT(10))
or MDIO_PMA_RSFEC_CTRL_4LANE_PMD (BIT(3)).

Also, xpcs_config_rsfec_pma() does a full 16-bit write rather than a
masked update via the existing xpcs_modify() helper, so the RS-FEC
enable / bypass-correction / bypass-indication bits of this
standards-defined register are unconditionally cleared. Is it safe to
discard whatever firmware or an earlier bring-up stage programmed there?

A related question on the keying: the value depends only on
phy_interface_t and not on the selected FEC mode. fbnic handles
FBNIC_AUI_LAUI2 with FBNIC_FEC_OFF in fbnic_mac_get_link_status(), yet
PHY_INTERFACE_MODE_LAUI here always programs the transcode pad alter
bit, and FBNIC_AUI_25GAUI with FBNIC_FEC_RS still ends up writing 0.
Should the register contents track the negotiated FEC mode?

Nothing reads the register back or checks an RS-FEC status bit
afterwards, so a wrong value would be silent.

> +
> +	return xpcs_config_rsfec_pma(xpcs, &v);
> +}
> +
> +static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
> +{
> +	const struct pma_pcs_values v = {
> +		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
> +		.channels = 1,
> +	};
> +
> +	return xpcs_config_rsfec_pma(xpcs, &v);
> +}
> +
> +static int xpcs_50gbaser2_pma_config(struct dw_xpcs *xpcs)
> +{
> +	const struct pma_pcs_values v = {
> +		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
> +		.channels = 2,
> +	};
> +
> +	return xpcs_config_rsfec_pma(xpcs, &v);
> +}
> +
> +static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
> +{
> +	const struct pma_pcs_values v = {
> +		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
> +		.channels = 2,
> +	};
> +
> +	return xpcs_config_rsfec_pma(xpcs, &v);
> +}
> +
>  static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {

[ ... ]

> diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
> index 36f4906e689a8..ab47d6dd050c7 100644
> --- a/drivers/net/pcs/pcs-xpcs.h
> +++ b/drivers/net/pcs/pcs-xpcs.h
> @@ -94,6 +94,12 @@
>  #define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
>  #define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
>  
> +/* Clause 133 defines */
> +/* RSFEC transcode pad alter
> + * DW vendor extension in RS-FEC control
> + */
> +#define DW_VR_RSFEC_CTRL_TC_PAD_ALTER	BIT(10)

[Severity: Low]
[Finding: main-3-8]
[Sources: opus-5]
This isn't a bug, but is "Clause 133" the right reference here? In IEEE
802.3-2022 the RS-FEC sublayer and its MDIO registers are Clause 134
(Clause 108 for 25G RS-FEC), and Clause 133 is a PCS clause. The next
patch in this series cites "IEEE 133.2.2" for PCS alignment marker
content, which suggests the same.

Also, the macro name implies a register macro DW_VR_RSFEC_CTRL, which
does not exist anywhere in the tree; the register actually written is
MDIO_PMA_RSFEC_CTRL in MDIO_MMD_SEP_PMA1. The rest of the file prefixes
a bit macro with the register macro it belongs to, for example
DW_VR_MII_DIG_CTRL2 -> DW_VR_MII_DIG_CTRL2_TX_POL_INV.

The define is also placed right after the DW_VR_MII_* block, which is
MMD 31 vendor MII, while this bit belongs to a PMA MMD register. Would
moving it and renaming it to match the register make this clearer?

> +
>  #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
>  	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
>  
> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index b2541c948fc1e..5219c877b2cfd 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -317,6 +317,9 @@
>  #define MDIO_PMA_10GBR_FECABLE_ABLE	0x0001	/* FEC ability */
>  #define MDIO_PMA_10GBR_FECABLE_ERRABLE	0x0002	/* FEC error indic. ability */
>  
> +/* RSFEC PMA Control register */
> +#define MDIO_PMA_RSFEC_CTRL_4LANE_PMD	BIT(3)
> +

[Severity: Low]
[Finding: main-1-2]
[Sources: opus-5]
This isn't a bug, but could the IEEE clause and table that define bit 3
of register 1.200 be cited here? Since the sibling bit of the same
register added by this patch (DW_VR_RSFEC_CTRL_TC_PAD_ALTER) is
described as a DW vendor extension and kept in the driver header, it is
hard to tell from the patch whether bit 3 is genuinely standard or also
Synopsys specific. If it is vendor specific, pcs-xpcs.h with a DW_VR_
prefix would be the better home.

Placement is also a little odd: the new define sits inside the
10GBASE-R FEC ability block, between MDIO_PMA_10GBR_FECABLE_ERRABLE and
MDIO_PMA_10GBR_FSRT_ENABLE, rather than next to the
MDIO_PMA_RSFEC_CTRL register definition earlier in the file. Would
moving it beside MDIO_PMA_RSFEC_CTRL be preferable?

>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>
