Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274728;
	b=XXfderq2YEcfJljlfuEJZIiL3Z45qBNMeMiLLyUmBB70xd/a7Ilk8gC/b/kVqW47wfKo
	 fKvgukD7C7FUcnlC91wc6kNfGwsJSVP8XFWOyDFbb0NJNKml/3fdKiFUBtC0eIyC6NiZA
	 htRBdfHMR0X4Fr3ZZw2NpBnZjfN7NbZlgqsF7sxn0DrbCyUVjAfMf6AfDMuv2VFG4SZ9Z
	 iKsMtvec+aLpHSCJ3MVSbj/rMQTBEqTdxJTYVWqQFM3p/0Ait5hlqXTBu7GLsEcPBu2Pf
	 Bb/paAIq3T264e9j8ouoEI/H58WYvFygZEYXPhuhhE02/++LGYnx9bTjuJ60b4BKcOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274728;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yHdaa5SHknrKYMQ9LgMfKhfAdpZAC1oCwJJhw6z/bsM=;
	b=MTeSuXR9A5x83iUDmVxWuExCGhl/bKM1jHYUwqiW933A9QWh7rZfjLGWtvMHcqkIaSb+
	 E9ysEpHO7kKPEK5tVAZRFPRLypKYfd+nKgsthuz8PsKgT5AoGy+MKasBvFF2PNH0kzUtk
	 gZvxFi9J6aTO/PPdK1MoXsTSZMMKXwlpo2FYQnQR7LD0NKW3k6T6/UhG1YNbS5ql++MkK
	 P4D6kjvWKw8icolvgxdXd6pgFZWCN7NhSZFbc9MN0UBvf3BEHVFbVzJarusSgoGG9IzSU
	 4+X59UXlYZyVUZsNin/RZ6wTAeTPVPGG5w+ZE0BCSQOS0D+KBQ4KcC6o96gFZ1Ato1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+jqwou0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795E606B511;
	Tue, 10 Nov 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+jqwou0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BBB1F008A1;
	Tue, 10 Nov 2026 01:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274727;
	bh=yHdaa5SHknrKYMQ9LgMfKhfAdpZAC1oCwJJhw6z/bsM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V+jqwou0lnEXxpN8Be9ZUm88IoXRkxRnb8OwjYp1kZzTLf5EmGphPXb/93efMuLLi
	 7jter6X5rZz3RM6R6t5BakyDXDxRtUxkhZJ7BzZpfaQPXOHDTxJbQO+S3nk38nHuFb
	 K3dhfaBARB7py3UOOJLuvpcTlm2TgyQU1jDg2YEerlq7nUm1vEgflKp4arDBQoMBu2
	 fC8Sj7PDzP5R3/XSADmmzmF2YpErtjVk0mtJ9SBGGXOfvEhwMKxVMtXtXV14ilwbaT
	 MnJKACiM+M1Yrm7NX5TBL7lkj5vwZ/SPdoBPgw6uQXgwyapMqu+nN+VR6qt4dcyDS+
	 7JmtlCk/FE/Zw==
Subject: Re: [PATCH net-next v20 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:45 +0000
Message-ID: <179427472591.994134.4882634953420736856@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-13-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-13-37b5a1189983@birger-koblitz.de>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new AX88772D/AX88179A/AX88279 PHY support is added only to
  the C driver, ax88796b.c.
- [Medium] asix_ax88279_read_status() returns early on `if
  (!phydev->link) return 0;` before it reaches…
- [Low] Series ordering breaks bisection.
- [Low] The commit message only says the three PHYs exist.
- [Low] asix_ax88772D_get_features() sets phydev->c45_ids.mmds_present |=
  MDIO_DEVS_PMAPMD | MDIO_DEVS_AN with the comment "to allow reading…
- [Low] The AX88796B_PHY Kconfig help still says it "Currently supports
  the Asix Electronics PHY found in the X-Surf 100 AX88796B package."…
- [Low] The three new PHY IDs are synthetic.

--

ax88796b: Add support for AX88772D, AX88179A and AX88279

This patch adds PHY driver entries for the AX88772D (100M), AX88179A (1G)
and AX88279 (2.5G) PHYs found in ASIX USB-Ethernet controllers. The
AX88279 gets its own get_features, config_aneg, read_status and
config_init callbacks, and the AX88772D gets a get_features fixup.

> ax88796b: Add support for AX88772D, AX88179A and AX88279
>
> The AX88772D, AX88179A and AX88279 are 100MBit, 1GBit and respectively
> 2.5 GBit PHYs that are found in ASIX USB-Ethernet controllers of the
> same name.

[Severity: Low]
Could the commit message describe the restrictions and quirks this patch
adds? It only says the three PHYs exist, but the patch also:

  - refuses AUTONEG_DISABLE with -EOPNOTSUPP in asix_ax88279_config_aneg()
    and sets PHY_BROKEN_FORCED, so "ethtool -s <if> autoneg off" fails
  - advertises 2.5G through vendor bit 0x1000 in MII_ADVERTISE
  - infers the link partner's 2.5G ability in asix_ax88279_read_status()
    because MDIO_AN_10GBT_STAT_LP2_5G is broken
  - always reports DUPLEX_FULL and switches phydev->interface between
    SGMII and 2500BASE-X
  - removes 100baseT-Half from the AX88279 and 1000baseT/X from the
    AX88772D

This isn't a bug, but the subject is missing the usual "net: phy:"
prefix.

> diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
> index f20ddf6491499..0df44e0e236ab 100644
> --- a/drivers/net/phy/ax88796b.c
> +++ b/drivers/net/phy/ax88796b.c
> @@ -13,6 +13,19 @@
>  #define PHY_ID_ASIX_AX88772A		0x003b1861
>  #define PHY_ID_ASIX_AX88772C		0x003b1881
>  #define PHY_ID_ASIX_AX88796B		0x003b1841
> +#define PHY_ID_ASIX_AX88772D		0x003b772d
> +#define PHY_ID_ASIX_AX88179A		0x003b179a
> +#define PHY_ID_ASIX_AX88279		0x003b2790

[Severity: Low]
Are these IDs actually inside the ASIX identifier block? The MAC side
fakes them in ax88179_mdiobus_read() in drivers/net/usb/ax88179a_devices.c
(added earlier in the series), with this comment:

	/* When reading PHYSID, return unused PHY-IDs from the ASIX vendor range */

In the C22 identifier layout, bits [31:10] carry the OUI. The existing
ASIX IDs 0x003b1861, 0x003b1881 and 0x003b1841 all give phy_id >> 10 ==
0xec6, which means PHYSID2 values in the 0x1800-0x1bff range.

The new IDs give:

  0x003b772d >> 10 == 0xedd
  0x003b179a >> 10 == 0xec5
  0x003b2790 >> 10 == 0xec9

so all three fall outside that block.

asix_tbl is a MODULE_DEVICE_TABLE. A PHY from another vendor that reports
one of these exact IDs would autoload this module and bind to callbacks
that assume MII_ADVERTISE bit 12, vendor register 0x1d and full duplex
only.

Would model values inside 0x18xx-0x1bxx be a better choice?

[ ... ]

> @@ -83,6 +96,107 @@ static int asix_ax88772a_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int asix_ax88279_read_status(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret)
> +		return ret;
> +
> +	if (!phydev->link)
> +		return 0;

[Severity: Medium]
Does this early return leave a stale 2500baseT_Full bit in
phydev->lp_advertising after a 2.5G link goes down?

The bit is only cleared further down in this function:

	linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->lp_advertising);

On link down with autoneg enabled, genphy_read_status()->genphy_read_lpa()
only clears the C22 derived bits:

	if (!phydev->autoneg_complete) {
		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
						0);
		mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
		return 0;
	}

Neither phy_check_link_status() nor phy_link_down() clears lp_advertising.

phy_ethtool_ksettings_get() then copies the stale bit to userspace, so
ethtool would show the partner advertising 2500baseT/Full while the link
is down.

On the next link-up, phy_resolve_aneg_linkmode() also runs with the stale
bit set, before the AX_CTRL_STATUS read overwrites phydev->speed.

Would clearing the bit before the !phydev->link return fix this?

[ ... ]

> @@ -94,6 +208,25 @@ static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
>  	}
>  }
>  
> +static int asix_ax88772D_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
> +	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
> +
> +	ret = genphy_read_abilities(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* AX88772D does not support (possibly) reported 1000baseT modes */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, phydev->supported);

[Severity: Low]
Does the mmds_present assignment do anything here? genphy_read_abilities()
only reads MII_BMSR and MII_ESTATUS and never looks at
c45_ids.mmds_present.

In drivers/net/phy, only genphy_c45_read_link(),
genphy_c45_pma_read_abilities() and the phylink C45 MII emulation check
mmds_present, and none of them run for this C22 PHY. The line and its
comment look like they were copied from asix_ax88279_get_features().

There is also an ordering question for EEE. genphy_read_abilities() ends
with genphy_c45_read_eee_abilities()->genphy_c45_read_eee_cap1(), which
masks supported_eee against supported:

	linkmode_and(phydev->supported_eee, phydev->supported_eee,
		     phydev->supported);

At that point 1000baseT_Full can still be set in supported, and it is
only cleared here afterwards.

If ESTATUS reports 1000T and MDIO_PCS_EEE_ABLE reports 1000T EEE, can
supported_eee keep 1000baseT_Full after it has been removed from
supported?

With the in-tree MAC, lpi_capabilities is 0 for the AX88772D, so phylink
disables EEE and users don't see this today.

[ ... ]

> @@ -111,6 +244,35 @@ static struct phy_driver asix_driver[] = {
>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
>  	.soft_reset	= asix_soft_reset,

[ ... ]

> +}, {
> +	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88279),
> +	.name		= "Asix Electronics AX88279",
> +	.flags		= PHY_IS_INTERNAL | PHY_BROKEN_FORCED,
> +	.get_features	= asix_ax88279_get_features,
> +	.read_status	= asix_ax88279_read_status,
> +	.config_aneg	= asix_ax88279_config_aneg,
> +	.config_init	= asix_ax88279_config_init,

[Severity: Low]
Can a bisect stop on a commit where the AX88279 doesn't work? This patch
is the last one in the series. The earlier patch "ax88179_178a: Add HW
support for AX179A-based chips" already returns PHYSID1/2 of
0x003b/0x2790 (and 0x179a/0x772d) from ax88179_mdiobus_read().

That patch also sets up phylink for the AX88279 in
ax88179a_phylink_setup() with only 2500BASEX and SGMII in
supported_interfaces, and an initial interface of 2500BASEX.

Between that patch and this one, nothing matches these IDs, so genphy
binds. It fills supported with C22 10/100/1000 modes only and leaves
possible_interfaces empty.

phylink_validate_phy() then validates against 2500BASEX, because is_c45
is false and it does not fall back to PHY_INTERFACE_MODE_NA. The only
capability for 2500BASEX is 2500 full duplex, so no mode is left and the
PHY fails to attach once ax88179 binds instead of cdc_ncm.

The AX88179A and AX88772D also run on genphy without the quirks added
here.

Could this patch be moved ahead of the MAC patch that depends on it?

[ ... ]

> @@ -124,6 +286,9 @@ static const struct mdio_device_id __maybe_unused asix_tbl[] = {
>  	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772A) },
>  	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772C) },
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_ASIX_AX88796B) },
> +	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772D) },
> +	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88179A) },
> +	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88279) },
>  	{ }
>  };

[Severity: Medium]
What happens to these PHYs when CONFIG_AX88796B_RUST_PHY=y?
drivers/net/phy/Makefile builds only one of the two drivers:

ifdef CONFIG_AX88796B_RUST_PHY
  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
else
  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
endif

drivers/net/phy/ax88796b_rust.rs still registers only the old three:

    drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],

USB_NET_AX88179 selects AX88796B_PHY so that this module provides the
PHY driver for the new chips. With the Rust variant, genphy binds to
0x003b2790, and the AX88279 fails phylink_validate_phy() against
2500BASEX as described above.

The AX88179A and AX88772D also lose the read_mmd/write_mmd hooks, and the
AX88772D loses its feature fixup.

The AX88796B_RUST_PHY help text also still says "The features are
equivalent", which is no longer the case.

Does the Rust driver need the same entries? Alternatively, could the
Kconfig dependencies reflect that it doesn't cover these PHYs?

[Severity: Low]
This isn't a bug, but the AX88796B_PHY help text in
drivers/net/phy/Kconfig still says:

	  Currently supports the Asix Electronics PHY found in the X-Surf 100
	  AX88796B package.

It already left out the AX88772A/C. Now it also leaves out the AX88772D,
AX88179A and AX88279 used by USB adapters, and USB_NET_AX88179 selects
this symbol. Could the help text be updated?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
