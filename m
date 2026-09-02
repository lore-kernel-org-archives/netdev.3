Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8424AA408;
	Wed,  2 Sep 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369123; cv=none; b=K4K28dRPzmfGryZ4wzkqXiWGr2rOngu1S7COlzu/zNyI6vitc/wqgu6X1oN2jEVH0cobdQOhlMK98kyCLCsiGVr8WrVRvVgFqgr8mpflzoQYlttRITJtEGYWRuAmorrJmj1qiqqyuMG4Ydc2RYKO6Igjg1fXoSIUDwvk+cSkzi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369123; c=relaxed/simple;
	bh=A4y7BzlZlHbVHQA3YDutbqAGnen7Yd6Hsb7ZXhmRCXg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtcSD7d8m8usiacf3ghyIjTnVNiD/+mLSB+Ffb5dctab0YAkI5z5Y4Itj+9QJhU5RR+GYBoN9H6niFL+ffdddAIkrF1jxApW2q28FDNyuc1t4CkoUjAVHJW1f/6bnkcVWJam26RlwCiiygom8i7KTJuxN+SmXxOdipPWuJN7bc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXmMoAce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXmMoAce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590A71F000E9;
	Wed,  2 Sep 2026 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788369121;
	bh=dI/+mP/6uy+hmXcv9a7wdhNXo+dqlKQKNB0Rfwccc7c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WXmMoAceO6WalM+RQcPj5zUJvYFuLD72kMv6C5UCOnCq2nligUFKfsiNJzq8q3Fa8
	 lbJLzArPjXN719IBvEX/ZvCJWlFbCX7HS4OPyYollmenOq8Zgnqxl7J6mPrbkSayAr
	 7VFPjd3hz10n5AMrzmkwFcL+4IfNut9nBMFtcciAD6K7dC+D6Jm/QJ4m95+ha6JupM
	 98vnEKfU/umRgFNfXUlQppFMNiZepkOOWh9jZVLCBStdmAxtMPQPKWM0jjHVZgFmxb
	 zyOg8r/8u12koSzxq32oyFtX/E/CLfUGBwtRWjYCaHUWqmIxzPR7Z+OAZ+H/EBG6de
	 dhzOejWQRJt8g==
Subject:
 Re: [net-next,v3] net: dsa: microchip: enable the SGMII port of the KSZ9897S
From: netdev-bot+sashiko@kernel.org
To: tapio.reijonen@vaisala.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com, nb@tipi-net.de,
 Jerry.Ray@microchip.com
Date: Wed, 02 Sep 2026 17:11:59 +0000
Message-ID: <178836911986.3394541.10513395709262597554@kernel.org>
In-Reply-To: <20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11@vaisala.com>
References: <20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11@vaisala.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

- [Medium] The new `[KSZ9897S]` chip_data entry in
  drivers/net/dsa/microchip/ksz_common.c (lines 1489-1522) declares…
- [Low] The patch carries no Fixes: tag even though its commit message
  describes a user-visible functional gap ("its chip_info entry never…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  newly routes KSZ9897S parts through it.

--

net: dsa: microchip: enable the SGMII port of the KSZ9897S

This adds a separate KSZ9897S chip_info entry that is the KSZ9897 one plus
.sgmii_port = 7, detects the variant at run time from the read-only bit 7 of
the port 7 XMII control 0 register in ksz_switch_detect(), and lets
ksz_check_device_id() accept a detected KSZ9897S for a device tree naming the
KSZ9897.

Link: https://lore.kernel.org/r/20260811-ksz9897-sgmii-port-v2-1-04ae287a0b27@vaisala.com
Link: https://lore.kernel.org/r/20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com

One comment on the commit message before the diff:

> The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
> entry never set .sgmii_port. ksz_has_sgmii_port() is therefore false,
> ksz9477_pcs_create() is never called and ksz9477_phylink_mac_select_pcs()
> returns NULL for port 7, so a phy-mode = "sgmii" or "1000base-x" link on
> that port cannot come up.

[Severity: Low]
This isn't a bug, but the description above reads like a user-visible
functional gap while the patch carries no Fixes: tag.  Was that
deliberate?

For what it is worth, it looks correct to leave it out: this is hardware
enablement (a new enum ksz_model value, a new KSZ9897S_CHIP_ID in
include/linux/platform_data/microchip-ksz.h, a new chip_data entry and new
run-time variant detection) aimed at net-next, and the direct precedent,
commit e8c35bfce4c13 ("net: dsa: microchip: Add SGMII port support to
KSZ9477 switch"), which introduced .sgmii_port and enabled the previously
non-working SGMII port on the KSZ9477 and LAN9646, has no Fixes: tag
either.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1a9d6f83a023..78442cc37643 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1486,6 +1486,41 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.gbit_capable	= {true, true, true, true, true, true, true},
>  	},
>  
> +	[KSZ9897S] = {
> +		.chip_id = KSZ9897S_CHIP_ID,
> +		.dev_name = "KSZ9897S",

[ ... ]

> +		.supports_mii	= {false, false, false, false,
> +				   false, true, true},
> +		.supports_rmii	= {false, false, false, false,
> +				   false, true, true},
> +		.supports_rgmii = {false, false, false, false,
> +				   false, true, true},

[Severity: Medium]
Should index 6 of these three arrays be false in the KSZ9897S entry?

Index 6 is physical port 7, which this same entry declares as the SGMII
port, and the commit message says "Only the KSZ9897S has that port; the
KSZ9897R has a second RGMII port instead".  The [KSZ9477] entry, the other
7-port part with SGMII on port 7, sets index 6 of all three arrays to
false:

	drivers/net/dsa/microchip/ksz_common.c:
	[KSZ9477] = {
		...
		.supports_rgmii = {false, false, false, false,
				   false, true, false},
		...
		.sgmii_port = 7,

What happens if a device tree names microchip,ksz9897 (which the new bypass
in ksz_check_device_id() now accepts for a detected KSZ9897S) and declares
phy-mode = "rgmii-id", "mii" or "rmii" on port 7?

ksz_phylink_get_caps() turns the flags above into advertised interface
modes, so phylink accepts the mode:

	drivers/net/dsa/microchip/ksz_common.c:ksz_phylink_get_caps() {
		...
		if (dev->info->supports_rgmii[port])
			phy_interface_set_rgmii(config->supported_interfaces);
		...
	}

But because .sgmii_port = 7 makes ksz_is_sgmii_port() true for that port,
the xMII control registers are then never programmed:

	drivers/net/dsa/microchip/ksz_common.c:ksz_phylink_need_config() {
		/* No need to configure XMII control register when using SGMII. */
		if (ksz_is_sgmii_port(dev, port))
			return false;
		...
	}

and no PCS is attached either:

	drivers/net/dsa/microchip/ksz9477.c:ksz9477_phylink_mac_select_pcs() {
		if (ksz_is_sgmii_port(dev, dp->index) &&
		    (interface == PHY_INTERFACE_MODE_SGMII ||
		    interface == PHY_INTERFACE_MODE_1000BASEX))
			return p->pcs;

		return NULL;
	}

Does that leave port 7 with neither xMII programming nor a PCS, and without
any error or warning, instead of rejecting the mode?

Note the in-tree [LAN9646] entry carries the same combination since commit
e8c35bfce4c13, so there is precedent for it, but it disagrees with the
vendor-authored [KSZ9477] entry and with this commit message.

> +		.internal_phy	= {true, true, true, true,
> +				   true, false, false},
> +		.gbit_capable	= {true, true, true, true, true, true, true},
> +		.sgmii_port = 7,

[Severity: Medium]
This isn't a bug introduced by this patch, but setting .sgmii_port here
makes ksz_has_sgmii_port() true and newly routes KSZ9897S parts through a
PCS lifecycle that has no release path.

ksz9477_pcs_create() allocates the dw_xpcs and stores it in p->pcs:

	drivers/net/dsa/microchip/ksz9477.c:ksz9477_pcs_create() {
		...
		pcs = xpcs_create_pcs_mdiodev(bus, 0);
		if (IS_ERR(pcs))
			return PTR_ERR(pcs);
		p->pcs = pcs;
		...
	}

The counterpart, which does xpcs_clear_clks() plus xpcs_free_data() and
drops the mdio_device reference taken by xpcs_create(), is never called from
drivers/net/dsa/microchip/:

	drivers/net/pcs/pcs-xpcs.c:
	void xpcs_destroy_pcs(struct phylink_pcs *pcs)
	{
		xpcs_destroy(phylink_pcs_to_xpcs(pcs));
	}

Per-port teardown only frees the ACL, and p->pcs is left set:

	drivers/net/dsa/microchip/ksz9477.c:
	static void ksz9477_port_teardown(struct dsa_switch *ds, int port)
	{
		struct ksz_device *dev = ds->priv;

		if (dsa_is_user_port(ds, port))
			ksz9477_port_acl_free(dev, port);
	}

ksz_teardown() has no xpcs_destroy_pcs() call either.  Does every
unbind/rebind cycle, or a DSA setup failure after ksz9477_setup() created
the PCS, then leak the dw_xpcs and its mdio_device reference while the
devm-managed mdiobus it points at goes away?  The omission dates back to
commit e8c35bfce4c13, which first set .sgmii_port for the KSZ9477 and
LAN9646.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11%40vaisala.com
