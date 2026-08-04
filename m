Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495B395AD1;
	Tue,  4 Aug 2026 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808128; cv=none; b=ESUctV9jVZccPfuYpf10GV2Suc4O+HmyySEHnjkZqk2xhCbamcOJ0CaPY7nqXEZLVEiGAHEIHRXEkUpct2zTcIsfvGWaK6JVMLGPA2pVHzVrWMM/sBuhN47PZg5DSpxr7fR3TakIpthF+QysRb+q7IhhxAFwKKVlxSYIJAuAz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808128; c=relaxed/simple;
	bh=NxjsSSkdpT5mUvmkatg8Sh0ZZ7tsLvYRX9TT/V7JO50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2ZRNdaf19x24tnq6ETSd5rZvaxU3P65lxco9tmd3ZmXGH0D11+fh93iTDjt5ILMx32GiG3fMJVdRH31MW7z9qPIYbgQf9F8E+cHPZ6PunbEffvRO/+84i09/tpi1btkvPmywZXZ19j8qWATd5k7BdQvl1wTVqFNJSAZV7h3PV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns/P25Cy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns/P25Cy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA171F000E9;
	Tue,  4 Aug 2026 01:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808126;
	bh=atvoUZ0ndRCAEA+FN9BP0CgBJ2RUzrx/AXNpuzExCWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ns/P25Cyoz0sePxvq5hvNvcG3xgwZnIQNTf7sLmU5FLtJqawjmr1c+1lC6WIeFO2q
	 hkCJrkb4LveQqz4POw3sv5sNIypwDke/BCeBFV3DtDXhxrGZ9ui/+g+GysFf3rrRLE
	 Qd5Kj/jTOq/EnL3VcYdjT7RF/dn+j1+gaub26JJuZ+IjDKKGkNJZNd0L3ikQpp4Jrf
	 gqMh3xHvJg8EUy3jL83T1RzYX2iK6aGD4JfOdEq4/m1RaPXFcBRQmas+ry5xNiLNVv
	 ois3z7RD69b/vcDH2UDAeAAst/T1d+NRhpQCDcBN2YLwtBFEh3MhtnNlRsUsYvrO+b
	 8Mh0VCEH5FnXQ==
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
Subject: Re: [net-next PATCH v4 4/4] net: pcs: xpcs: Add handling for 4 channel rsfec device
Date: Mon,  3 Aug 2026 18:48:44 -0700
Message-ID: <20260804014844.2532758-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178536393447.250758.12698568086617343381.stgit@ahduyck-xeon-server.home.arpa>
References: <178536393447.250758.12698568086617343381.stgit@ahduyck-xeon-server.home.arpa>
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
--- Patch [4]: [net-next PATCH v4 4/4] net: pcs: xpcs: Add handling for 4 channel rsfec device ---
commit 7b16dc0f9f781491095c890579bd7608f7d1a49f
Author: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

net: pcs: xpcs: Add handling for 4 channel rsfec device

This adds programming of the DW PCS vendor registers for the alignment
marker encodings, the PCS mode and the alignment marker insertion interval,
repeated over each configured channel.  Marker tables for 100G and 50G are
added and selected per interface mode.  No Link: tags are present in the
commit header.

A few questions on the new registers, constants and comments below.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 3800c129dae2e..8f990291d5190 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -1394,11 +1394,67 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
>  	return 0;
>  }
>  
> +/* m0 - m2 from Table 82-2/82-3
> + * m4 - m6 are skipped since they are inversions of m0 - m2.
> + * Inverted parity fields (IEEE 82.2.8) bip3 and bip7 are omitted.
> + */
> +struct lane_markers {
> +	u8 m0, m1, m2;
> +};
> +
> +/* Alignment marker encodings, see table 82-2 in IEEE 802.3-2022 */
> +static const struct lane_markers xpcs_100gbaser_markers[] = {
> +	{0xc1, 0x68, 0x21},
> +	{0x9d, 0x71, 0x8e},
> +	{0x59, 0x4b, 0xe8},
> +	{0x4d, 0x95, 0x7b},
> +};
> +
> +/* Alignment marker encodings, see table 82-3 in IEEE 802.3-2022
> + * The content of the 50G markers is identical to 40G values (IEEE 133.2.2).
> + */
> +static const struct lane_markers xpcs_50gbaser_markers[] = {
> +	{0x90, 0x76, 0x47},
> +	{0xf0, 0xc4, 0xe6},
> +	{0xc5, 0x65, 0x9b},
> +	{0xa2, 0x79, 0x3d},
> +};
> +
>  struct pma_pcs_values {
> +	const struct lane_markers *vl0_markers;
> +	const struct lane_markers *vl123_markers;
>  	int channels;
>  	u16 rsfec_ctrl;
> +	u16 pcs_mode;
> +	u16 vl_intvl;
>  };
>  
> +#define XPCS_VL_TO_REG(vl, lh) \
> +	(((vl) * 2) + DW_VR_MII_PCS_VL0_##lh)
> +
> +static int
> +xpcs_write_pcs_ch(struct dw_xpcs *xpcs, int ch, int reg, u16 val)
> +{
> +	return xpcs_mdev_write_ch(xpcs, ch, MDIO_MMD_PCS, reg, val);
> +}
> +
> +static int xpcs_config_ch_vl_markers(struct dw_xpcs *xpcs, int ch, int vl,
> +				     const struct lane_markers *m)
> +{
> +	int ret;
> +
> +	/* m0, m1, m2 written to _L and _H registers
> +	 *
> +	 * _L = (m1 << 8) | m0
> +	 * _H = m2
> +	 */
> +	ret = xpcs_write_pcs_ch(xpcs, ch, XPCS_VL_TO_REG(vl, L),
> +				((u16)m->m1 << 8) | m->m0);
> +	if (ret < 0)
> +		return ret;
> +	return xpcs_write_pcs_ch(xpcs, ch, XPCS_VL_TO_REG(vl, H), m->m2);
> +}
> +
>  static int
>  xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
>  {
> @@ -1407,9 +1463,28 @@ xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
>  	 * work for enabling a non-fbnic device on this PCS.
>  	 */
>  	int pma_mmd = MDIO_MMD_SEP_PMA1;
> -	int ret = 0, i;
> +	int ret = 0, i, vl;
>  
>  	for (i = 0; ret >= 0 && i < v->channels; i++) {
> +		/* code word markings */
> +		for (vl = 0; ret >= 0 && vl < 4; vl++) {
> +			const struct lane_markers *m;
> +
> +			m = vl ? v->vl123_markers + vl - 1 : v->vl0_markers;
> +			ret = xpcs_config_ch_vl_markers(xpcs, i, vl, m);
> +		}
> +		if (ret < 0)
> +			break;
> +		/* vendor registers */
> +		ret = xpcs_write_pcs_ch(xpcs, i,
> +					DW_VR_MII_PCS_VL_INTVL, v->vl_intvl);
> +		if (ret < 0)
> +			break;
> +		ret = xpcs_write_pcs_ch(xpcs, i,
> +					DW_VR_MII_PCS_PCS_MODE, v->pcs_mode);
> +		if (ret < 0)
> +			break;
> +		/* rsfec register */
>  		ret = xpcs_mdev_write_ch(xpcs, i, pma_mmd,
>  					 MDIO_PMA_RSFEC_CTRL, v->rsfec_ctrl);
>  	}

[Severity: Low]
[Finding: main-1-3]
[Sources: opus-5]
This isn't a bug, but should xpcs_config_rsfec_pma() keep its name now that
it also programs PCS layer registers?

It is registered as the .pma_config callback of struct dw_xpcs_compat and
invoked from xpcs_config():

	if (compat->pma_config) {
		ret = compat->pma_config(xpcs);

After this patch the body writes MDIO_MMD_PCS vendor registers (the
alignment markers 0x8008-0x800f via xpcs_config_ch_vl_markers(), the VL
interval 0x8002 and the PCS mode 0x8010) in addition to the single
MDIO_MMD_SEP_PMA1 MDIO_PMA_RSFEC_CTRL write.

The other .pma_config implementations stay inside PMA/VEND2 register space:
nxp_sja1105_sgmii_pma_config() writes DW_VR_MII_DIG_CTRL2 in VEND2,
nxp_sja1110_pma_config() writes the MDIO_MMD_VEND2 PMA PLL registers, and
txgbe_pma_config_*() write PMA registers.

Would renaming it (xpcs_config_pcs_pma or xpcs_config_mode) or splitting
the PCS layer programming into its own step make the layering clearer?

> @@ -1422,6 +1497,13 @@ static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
>  	const struct pma_pcs_values v = {
>  		.rsfec_ctrl = 0,
>  		.channels = 1,
> +		/* 25g markers from 100g and 50g tables per 802.3-2022
> +		 * 108.5.2.4
> +		 */
> +		.vl0_markers = &xpcs_100gbaser_markers[0],
> +		.vl123_markers = &xpcs_50gbaser_markers[1],
> +		.vl_intvl = 20479,
> +		.pcs_mode = DW_VR_MII_PCS_MODE_CLAUSE107,
>  	};
>  
>  	return xpcs_config_rsfec_pma(xpcs, &v);

[Severity: Low]
[Finding: main-1-2]
[Sources: opus-5]
Where do the .vl_intvl values come from?  The commit message says:

    The encoding tables are derived from the IEEE 8023-2022 spec sections
    82.2.7 and tables 82-2 and 82-3 for the alignment markers and their
    insertion.

82.2.7 specifies a 16384 block insertion period, which matches the 16383
used by xpcs_100gbasep_pma_config(), but the 20479 used here and by
xpcs_50gbaser_pma_config()/xpcs_50gbaser2_pma_config() corresponds to the
Clause 133/108 50G and 25G period, which the message does not cite.  Could
the reference for 20479 and the reason for the -1 bias be spelled out?

The two values also need different widths (16383 is 0x3fff, 14 bits; 20479
is 0x4fff, 15 bits) and are written raw with no #define and no
GENMASK()/FIELD_PREP(), unlike the other multi-bit fields in this header
such as DW_VR_MII_EEE_MULT_FACT_100NS.  Is the interval field width
documented anywhere?  If it were [13:0], 20479 would truncate to 4095 and
bit 14 would land on a neighbouring control bit, and an MDIO write cannot
report that.

Also, the lane count is hardcoded in xpcs_config_rsfec_pma():

		for (vl = 0; ret >= 0 && vl < 4; vl++) {

Would it be better as a field of pma_pcs_values, or tied to ARRAY_SIZE() of
the marker tables and the documented 0x8008-0x800f window?  As written, the
single channel 25G and 50G-R1 configurations still program the VL1..VL3
marker sets, so the table does not express which fields are meaningful per
mode.

Last, the subject says "4 channel rsfec device" while DW_XPCS_MAX_CHANNELS
is 2 ("2 channels per group DW PCS devices") and the largest .channels used
is 2, which also reads differently from the message body ("over the one or
two instances as required").

[ ... ]

> @@ -1442,6 +1528,10 @@ static int xpcs_50gbaser2_pma_config(struct dw_xpcs *xpcs)
>  	const struct pma_pcs_values v = {
>  		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
>  		.channels = 2,
> +		.vl0_markers = &xpcs_50gbaser_markers[0],
> +		.vl123_markers = &xpcs_50gbaser_markers[1],
> +		.pcs_mode = 0,
> +		.vl_intvl = 20479,
>  	};
>  
>  	return xpcs_config_rsfec_pma(xpcs, &v);
> @@ -1452,6 +1542,10 @@ static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
>  	const struct pma_pcs_values v = {
>  		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
>  		.channels = 2,
> +		.vl0_markers = &xpcs_100gbaser_markers[0],
> +		.vl123_markers = &xpcs_100gbaser_markers[1],
> +		.pcs_mode = DW_VR_MII_PCS_MODE_DISABLE_MLD,
> +		.vl_intvl = 16383,
>  	};
>  
>  	return xpcs_config_rsfec_pma(xpcs, &v);

[Severity: Medium]
[Finding: main-2-5]
[Sources: opus-5]
Why do the two .channels = 2 configurations differ in MLD handling and in
the marker interval?  The commit message explains the repetition with:

    The DW PCS IP specification calls out the need to configure both lanes
    identically when using 2 lane modes such as 50-R2 and 100-R2, so the
    programming is repeated for each channel.

but xpcs_100gbasep_pma_config() sets DW_VR_MII_PCS_MODE_DISABLE_MLD and
.vl_intvl = 16383, while xpcs_50gbaser2_pma_config() leaves .pcs_mode = 0
and uses 20479.  On top of that, the RS-FEC control value here is
MDIO_PMA_RSFEC_CTRL_4LANE_PMD, a 4 lane PMD bit.

PHY_INTERFACE_MODE_100GBASEP is described in include/linux/phy.h as
"100GBase-P - with Clause 134 FEC", and fbnic maps a 2 lane AUI to it:

drivers/net/ethernet/meta/fbnic/fbnic_phylink.c:
	case FBNIC_AUI_100GAUI2:
		return PHY_INTERFACE_MODE_100GBASEP;

16383 is the Clause 82 (40G/100G-R4) insertion period and 20479 is the
Clause 133 50G period used by the sibling 2 channel configuration.

Is 100GBASEP here intended as a Clause 133 100GBASE-R2 (which would suggest
20479 and MLD semantics like 50G-R2), or as a Clause 82/91 4 lane 100G?  And
is programming only four virtual lane marker sets correct for it?  Every
fbnic 100G link brings this path up through xpcs_config() ->
compat->pma_config(), so if the values do not match the hardware the
alignment marker/FEC lock would fail and the link would not come up.

> diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
> index ab47d6dd050c7..adb7b1c13c2df 100644
> --- a/drivers/net/pcs/pcs-xpcs.h
> +++ b/drivers/net/pcs/pcs-xpcs.h
> @@ -100,6 +100,31 @@
>   */
>  #define DW_VR_RSFEC_CTRL_TC_PAD_ALTER	BIT(10)
>  
> +/* Vendor specific 4 channel PCS registers */
> +
> +/* DW_VR_MII_PCS_VL_INTVL and DW_VR_MII_AN_INTR_STS conflict
> + * but code paths are different
> + */
> +#define DW_VR_MII_PCS_VL_INTVL		0x8002

[Severity: Low]
[Finding: main-3-7]
[Sources: opus-5]
Is there really a conflict to document here?  The new register is only ever
reached through xpcs_write_pcs_ch():

	return xpcs_mdev_write_ch(xpcs, ch, MDIO_MMD_PCS, reg, val);

that is MMD 3, while every access to DW_VR_MII_AN_INTR_STS uses
MDIO_MMD_VEND2, that is MMD 31:

	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);

C45 register space is per MMD, so MMD3:0x8002 and MMD31:0x8002 are simply
unrelated registers.  The same applies to the commit message:

    There is also a conflict between DW_VR_MII_PCS_VL_INTVL and
    DW_VR_MII_AN_INTR_STS but an_mode differs, so again there is no issue.

Would "different MMD" be the accurate reason instead of "code paths are
different" and "an_mode differs"?  As written, a later reader could
conclude the MMD selection does not matter, or add an an_mode based guard
that has no purpose.

Two smaller wording points in the same patch.  In the lane_markers comment:

    Inverted parity fields (IEEE 82.2.8) bip3 and bip7 are omitted.

bip3 is the parity field and bip7 is its inversion, so calling both
"inverted parity fields" reads incorrectly.  Also the spec references such
as "IEEE 82.2.8" and "IEEE 133.2.2" omit 802.3, could they be written as
IEEE 802.3 clause 82.2.8 and clause 133.2.2?

> +/* 0x8008 - 0x800f */
> +#define DW_VR_MII_PCS_VL0_L		0x8008
> +#define DW_VR_MII_PCS_VL0_H		0x8009
> +#define DW_VR_MII_PCS_PCS_MODE		0x8010
> +
> +/* DW_VR_MII_PCS_PCS_MODE bits */
> +#define DW_VR_MII_PCS_MODE_HI_BER25		BIT(2)
> +#define DW_VR_MII_PCS_MODE_DISABLE_MLD		BIT(1)
> +#define DW_VR_MII_PCS_MODE_CLAUSE49		BIT(0)

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5]
Is the DW_VR_MII_ prefix the right one for registers that live in the PCS
MMD?  Every pre-existing DW_VR_MII_* define in this header is a VR MII MMD
register: DW_VR_MII_AN_CTRL and DW_VR_MII_AN_INTR_STS are accessed with
MDIO_MMD_VEND2, and DW_VR_MII_DIG_CTRL2 likewise in pcs-xpcs-nxp.c.  The
PCS MMD vendor registers use the DW_VR_XS_PCS_ prefix with the DW_VENDOR
bit added at access time by xpcs_read_vendor()/xpcs_write_vendor(), whereas
these new defines hard-code the DW_VENDOR bit (0x8002/0x8008/0x8010), which
is exactly how DW_VR_MII_PCS_PCS_MODE ends up equal to
DW_VENDOR | DW_VR_XS_PCS_DIG_STS.

The new bit names also share a prefix with existing defines for an
unrelated register.  DW_VR_MII_AN_CTRL (0x8001, MMD 31) already has:

	#define DW_VR_MII_PCS_MODE_MASK			GENMASK(2, 1)
	#define DW_VR_MII_PCS_MODE_C37_1000BASEX	0x0
	#define DW_VR_MII_PCS_MODE_C37_SGMII		0x2

which xpcs_config_aneg_c37_sgmii() uses as field values:

	mask = DW_VR_MII_PCS_MODE_MASK | DW_VR_MII_TX_CONFIG_MASK;
	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
			 DW_VR_MII_PCS_MODE_C37_SGMII);

A later xpcs_modify() on the new 0x8010 register that picks up the
plausible looking DW_VR_MII_PCS_MODE_MASK would silently drop
DW_VR_MII_PCS_MODE_CLAUSE49 (BIT(0)).  Could the new register and bit names
be given a distinct prefix, and the DW_VENDOR bit be applied through the
existing vendor accessors?
