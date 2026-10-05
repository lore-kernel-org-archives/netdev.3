Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E254C10F2;
	Mon,  5 Oct 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214214; cv=none; b=P7RL/g0wCEjjwAgrDcfwuoJO3iBqZCCXreDa6Dsmp/8FRMPqXTc1cSBcVtYPCVgaqTDbwtTI3wwqpoknM2gvHmzVczKeUeZ+ZskoAVXb/aAyKMWNgCH7Yuih44Jk5KbBLyw9JYTcN/2ekJ2cYq5aUE+kSgX1UQCe8wta+H4e3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214214; c=relaxed/simple;
	bh=+mh6fGc2EvZo4Lle8zRFz7+1L5Agg13BL/ovI5j42SE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h48p9KnC4S86nQdUJx/yzQYVCYx9srlDmDTC9uAC57+ZZszxoi9BVoBOXu0zZmn9Xs7/CMYaSfOGvvN+S7YCqxwjPEwrzFarq62sm6Tef2s1vwY9cIYNX8yuTRav2NmljS7y8UudDCKdj422EC2TbwnwTOo62q0mjwaNtlZCjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nECkh00r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nECkh00r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588051F0089E;
	Mon,  5 Oct 2026 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214212;
	bh=baki7qI+ECUvLpKtBVaynp3tTMH5IOwp3/tEcZabwP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nECkh00r1NlhvNS0HzHjz8AvRDcMl2kyfQj+bXuL/0uosTWWEnNKTHzNS+IW96OV+
	 EGj1MH42Kqy+Xt6IfW+eOdcK3cbmfIvJtoK2QQM4v6MzMjPu21c+CMCB4DFoOdU+Bk
	 L9jcTKrcaVHA7UP7NfaljGbtg2U1QZG5tlOMSMGDwGvrR1ohr3hOrukq2acywkNdSZ
	 rwo3tLVwUehUwXTcADm5w7oa52TY1FdlGSeHYhFgBcd5LgntXELBSPJGe3euTKhqkM
	 wvJ5iYfQpj0lD2IHkQOtjnFid1e+Xg1mr74RnY6Sn4NWwInhk/0IyaM2VyZ1YN0Ott
	 EFfOBoqTRqZjg==
Subject:
 Re: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on i.MX95
From: netdev-bot+sashiko@kernel.org
To: marex@nabladev.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 xiaoning.wang@nxp.com, claudiu.manoil@nxp.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 15:30:10 +0000
Message-ID: <179121421089.434549.4883192954268711704@kernel.org>
In-Reply-To: <20261001223947.60189-1-marex@nabladev.com>
References: <20261001223947.60189-1-marex@nabladev.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes the MDC divider in the four exported accessors
  (enetc_mdio_write_c22(), enetc_mdio_write_c45(),…
- [Medium] The i.MX95-specific divider (66) is selected by the PCI ID
  table entry `{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID), 0, 0,…

--

enetc: Set eMDIO MDC rate to 2.5 MHz only on i.MX95

This commit moves the eMDIO MDC clock divider into a new per-bus field,
mdc_div, in struct enetc_mdio_priv. enetc_pci_mdio_probe() fills it in
from the PCI ID table driver_data. The LS1028A EMDIO device ID gets 258
and the NETC EMDIO device ID gets 66.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> index a90a04a47befd..7ed9b9120f447 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> @@ -22,9 +22,9 @@
>   /* external MDIO only - driven on neg MDC edge */
>  #define MDIO_CFG_NEG		BIT(23)
>  
> -#define ENETC_EMDIO_CFG \
> +#define ENETC_EMDIO_CFG(mdc_div) \
>  	(MDIO_CFG_HOLD(2) | \
> -	 MDIO_CFG_CLKDIV(66) | \
> +	 MDIO_CFG_CLKDIV(mdc_div) | \
>  	 MDIO_CFG_NEG)

[Severity: High]
What divider do the other users of these accessors get?

The exported enetc_mdio_read_c22(), enetc_mdio_write_c22(),
enetc_mdio_read_c45() and enetc_mdio_write_c45() are shared with several
bus constructors. Only enetc_pci_mdio_probe() sets mdc_div.

These constructors install the same accessors but set only hw and
mdio_base:

  enetc_mdio_probe() in enetc_pf_common.c (PF external MDIO, LS1028A
  and ENETC4)
  enetc_imdio_create() in enetc_pf_common.c (internal Lynx PCS MDIO)
  netc_port_create_emdio_bus() in drivers/net/dsa/netc/netc_main.c
  vsc9959_mdio_bus_alloc() in drivers/net/dsa/ocelot/felix_vsc9959.c

For example:

enetc_pf_common.c:enetc_mdio_probe() {
    ...
    bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
    ...
    mdio_priv->hw = &pf->si->hw;
    if (is_enetc_rev1(pf->si))
        mdio_priv->mdio_base = ENETC_EMDIO_BASE;
    else
        mdio_priv->mdio_base = ENETC4_EMDIO_BASE;
    ...
}

mdiobus_alloc_size() allocates the priv area with kzalloc(), so mdc_div
stays 0. MDIO_CFG_CLKDIV(x) is ((((x) >> 1) & 0xff) << 8).

As a result, every C22/C45 transaction on these buses would write a zero
clock divider into ENETC_MDIO_CFG. Before 587acb86d646 the value was 258,
and after it the value was 66.

Could a zero divider drive MDC far above 2.5 MHz, or leave it undefined?
PHY and PCS reads might then return 0xffff through MDIO_CFG_RD_ER. That
would break PHY probing, PCS configuration and link bring-up on these
buses.

The commit message says:

    and reinstate previous divider ratio for all other SoCs. This way the
    other SoCs are unaffected by the i.MX95 specific change.

That doesn't seem to hold for LS1028A, or for the PF, PCS and switch
MDIO buses on ENETC4.

A smaller case of the same problem: if the PCI driver is bound through
driver_override and no ID table entry matches, pci_match_device() returns
pci_device_id_any. Its driver_data is 0, so mdc_div would also be 0 on
that path.

Should mdc_div be set at every bus creation site? Alternatively, the
accessors could fall back to the legacy default divider when mdc_div is
0.

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> index e108cac8288d3..6704033067ecc 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c

[ ... ]

> @@ -125,8 +126,8 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
>  }
>  
>  static const struct pci_device_id enetc_pci_mdio_id_table[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
> -	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID), 0, 0, 258 },
> +	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID), 0, 0, 66 },

[Severity: Medium]
Does this entry match only i.MX95?

It matches any 0x1131:0xee00 function, whatever its revision.
enetc_pci_mdio_probe() then applies ent->driver_data without checking
pdev->revision.

Both arch/arm64/boot/dts/freescale/imx95.dtsi and
arch/arm64/boot/dts/freescale/imx94.dtsi describe the EMDIO node as:

    compatible = "pci1131,ee00";

So i.MX94 would also get a divider of 66, not the previous 258. That
conflicts with the subject ("only on i.MX95") and with the commit
message's point that the divider input clock and ratio differ per SoC.

The enetc driver already tells the two SoCs apart by NETC revision:
ENETC_REV_4_1 for i.MX95 and ENETC_REV_4_3 for i.MX94.

I couldn't confirm the i.MX94 divider input clock rate from the tree. If
it is faster than on i.MX95, MDC on i.MX94 could exceed 2.5 MHz.

Does picking the divider here need pdev->revision, an SoC or compatible
match, or a known reference clock?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001223947.60189-1-marex%40nabladev.com
