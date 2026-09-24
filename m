Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E83E3DA4;
	Thu, 24 Sep 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233081; cv=none; b=RVeDC1gEna4KliZLcpuM7Ifqf5dJC/fYRPGs2/c12eZIINIDzlo2hoRsSFwB9TKBCis0JwmFbflHfM2OvO2PEkvpoiu1AF3UQ2YA8ksS4tcFuXYKw5w/fbCnJnRZRQ7qNpZekehrcbwTVp6BEQbZYLRQSTOkiqHLiy++ccpBpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233081; c=relaxed/simple;
	bh=k8zpomm5sY+59fh7sktTqXfEBRJBSy6GiKowG9MoNsg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cdt4BiL/iFKz50lNaTzOmSEIMIKO2u1QFlNyDFPGui/Py3TtddPbMFATIvau036daQ7+0P+As/9R4XDy1cwPpGphVUnhAsod45b9FhZFXhMmtna2rtrIy/f6WjncziN88JNn0Jtaqc7cVYeRPQ+92gaiRzXx2O0lG2LbfOTrNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClLzcWF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClLzcWF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA081F00898;
	Thu, 24 Sep 2026 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790233069;
	bh=6+kiYrDbz0GStx6HXp6Ht35U2/8WI8AniMTXkFet7xk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ClLzcWF6107/QtddG3BxWdXCoBYNNCwT51idQtNiTeViEn6wWAbnq/Pgbimo18YL1
	 FdrwAsbEdbXeV83fM55tAqdu58iq5Bsl11SFFAx9Wt9HSzP2VfxoHRXfWm341/wonJ
	 0+t8Iy6ZRXeyt2nZv9LgMw7gRcuhQm1cPQ2P+DcE9YKtEG98FVD4n8gsyXiDY/2kBP
	 tcSFhvQk7ETuBx1fhDmE/M1tdK+PQq8dcSJrTSHlq9z/U+y4u1p8t7o4XouXWHGeRu
	 k3OBHQu56hsimoYdf4gKCSC1SabuuDmTO1k1v9RRhHjvR6KWMXz8PSFyRC1VVpNaP8
	 xz4IEkiyjHS4Q==
Subject:
 Re: [PATCH net-next v3] net: pcs: enable autonegotiation for 10g-usxgmii
From: netdev-bot+sashiko@kernel.org
To: pbiel7@gmail.com
Cc: ioana.ciornei@nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
Date: Thu, 24 Sep 2026 06:57:48 +0000
Message-ID: <179023306822.2160803.2695214743921817863@kernel.org>
In-Reply-To: <20260922-b4-fix-pcs-lynx-an-v3-1-dda3ac4e499c@gmail.com>
References: <20260922-b4-fix-pcs-lynx-an-v3-1-dda3ac4e499c@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] lynx_pcs_config_usxgmii() now writes BMCR_RESET |
  BMCR_ANENABLE | BMCR_ANRESTART (drivers/net/pcs/pcs-lynx.c:210-211) on…
- [Low] The commit message describes a user-visible functional defect
  ('Systems which do not get the USXGMII replicator preconfigured before…
- [Low] The new comment at drivers/net/pcs/pcs-lynx.c:23-25 states
  'USXGMII replicator link timer step is 3.2 ns (312.5M XGMII columns…

--

net: pcs: enable autonegotiation for 10g-usxgmii

The Lynx PCS USXGMII path previously only programmed the replicator
advertisement.  This patch adds link timer programming derived from
phylink_get_link_timer_ns() and a BMCR write that asserts reset,
autonegotiation enable and autonegotiation restart.

No Link: tags are present in the commit header.

A few questions below.

> The Lynx PCS USXGMII setup programs the replicator advertisement, but
> does not explicitly enable and restart in-band autonegotiation or program
> the replicator link timers.
>
> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.

[Severity: Low]
The message describes a user-visible failure ("may therefore fail to
negotiate the link correctly"), but there is no Fixes: tag and no
statement of the intended tree.

git blame on the baseline shows the advertise-only USXGMII configuration
in lynx_pcs_config_usxgmii() came from 0da4c3d393e40e ("net: phy: add
Lynx PCS module"), and the PHY_INTERFACE_MODE_10G_QXGMII path this patch
also touches came from 76cd8a2ea98a3d.

Should this carry a Fixes: tag pointing at one of those, or should the
message instead say this is net-next completion of the USXGMII setup
rather than a fix for broken negotiation?

> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index da4f99059eef7..6d94f92a33329 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -20,6 +20,12 @@
>  #define IF_MODE_SPEED_MSK		GENMASK(3, 2)
>  #define IF_MODE_HALF_DUPLEX		BIT(4)
>  
> +/* USXGMII replicator link timer step is 3.2 ns (312.5M XGMII columns per sec)
> + * for single port mode. For quad port mode, it is 1/4 of that.
> + */
> +#define LINK_TIMER_VAL_USXGMII(ns)	((u32)((ns) * 10 / 32))
> +#define LINK_TIMER_VAL_10G_QXGMII(ns)	((u32)((ns) * 10 / 128))

[Severity: Low]
Do the comment and the macro contradict each other here?

The comment says the quad port step "is 1/4 of that", i.e. 1/4 of 3.2 ns
= 0.8 ns, which would need ns * 10 / 8.  The macro uses ns * 10 / 128,
which is a 12.8 ns step, four times larger than 3.2 ns rather than a
quarter of it.

With phylink_get_link_timer_ns() returning 1600000 for
PHY_INTERFACE_MODE_10G_QXGMII, the macro yields 125000 ticks, while the
comment's wording implies 2000000.

If the intent is that the per-port column rate is 1/4, so the period is
4x, would something like "for quad port mode, each port sees 1/4 of the
column rate, so the step is 4x larger (12.8 ns)" match the macro?

>  struct lynx_pcs {
>  	struct phylink_pcs pcs;
>  	struct mdio_device *mdio;

[ ... ]

> @@ -166,10 +175,46 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
>  	}
>  
>  	/* Configure device ability for the USXGMII Replicator */
> -	return mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
> -				 MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
> -				 MDIO_USXGMII_FULL_DUPLEX |
> -				 ADVERTISE_SGMII | ADVERTISE_LPACK);
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
> +				MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
> +				MDIO_USXGMII_FULL_DUPLEX |
> +				ADVERTISE_SGMII | ADVERTISE_LPACK);
> +	if (ret < 0) {
> +		dev_err(&pcs->dev, "could not set USXGMII replicator config\n");
> +		return ret;
> +	}
> +
> +	link_timer_ns = phylink_get_link_timer_ns(interface);
> +	if (link_timer_ns > 0) {
> +		if (interface == PHY_INTERFACE_MODE_10G_QXGMII)
> +			link_timer = LINK_TIMER_VAL_10G_QXGMII(link_timer_ns);
> +		else
> +			link_timer = LINK_TIMER_VAL_USXGMII(link_timer_ns);

[ ... ]

> +	/* Configure autonegotiation */
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_BMCR,
> +				BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART);

[Severity: Medium]
Can this bounce an established link?

The BMCR_RESET | BMCR_ANRESTART write happens on every successful
invocation of lynx_pcs_config_usxgmii(), with no check for whether the
interface mode, advertisement or link timer values actually changed.

The .pcs_config() contract in include/linux/phylink.h says:

 * pcs_config() will be called when configuration of the PCS is required
 * or when the advertisement is possibly updated. It must not unnecessarily
 * disrupt an established link.

For a PCS-only in-band link (managed = "in-band-status" with no
phy-handle, so pl->phydev is NULL), a pause parameter change reaches this
path:

drivers/net/phy/phylink.c:phylink_update_pause_state() {
	...
	if (!pl->phydev)
		phylink_change_inband_advert(pl);
	...
}

phylink_change_inband_advert() then calls phylink_pcs_config()
unconditionally, so phylink_pcs_config()->lynx_pcs_config()->
lynx_pcs_config_usxgmii() soft-resets the replicator and restarts AN.
phylink_ethtool_ksettings_set() reaches the same helper for in-band
links.

Would it work to make the reset and restart conditional on an actual
configuration change (or on the PCS not yet being initialized), or to
return a positive value so phylink calls .pcs_an_restart() instead?

> +	if (ret < 0) {
> +		dev_err(&pcs->dev, "could not set USXGMII replicator control config\n");
> +		return ret;
> +	}
> +
> +	return ret;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-b4-fix-pcs-lynx-an-v3-1-dda3ac4e499c%40gmail.com
