Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42519253B73;
	Sat, 26 Sep 2026 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790381736; cv=none; b=IOKX13j5UYNQxWNnmdF8glMsU8fCw+fCS+ywM1Chy6qEL7xBUYjH9pkW6QYVT3PhdtNOD5IOSPXsT/GKSkI09ItsjKvXzC6/msS3C9YjGuNBVnm+6xM/nEBBaY4HlWSY0GYoqpNzFJ8INTGFziFJ86Pfxset0fq/n12AR5AAJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790381736; c=relaxed/simple;
	bh=hh1IrxLo36J1HFItgdHJiyP5PfhTZFEre9QcVbXwQgI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGDBpzx0nogeM1xe55fzZFxzO4J1N3ct+DK3Cn5ZONVAjEHHtr7w6P0tQWQmKfL4KtV4na0GfcBmNrlTZ8KT5WIoEzgsUb2eugM400Gs4tkF+F5h/brZ9T6XQuG3+tsMIBYUkxzY23eb8yPK1baaLzJf+Mw8PunBslzVQoOWPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUfVGuyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUfVGuyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572D41F0089A;
	Sat, 26 Sep 2026 00:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790381735;
	bh=oev2bMQjMXidVh+iiOuNzzFvsZd0IbtOvyMFoWjyDts=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QUfVGuyFRdvQp9L3UT/fRMnyh473nny0kiIddT4yd72te2WgihiX/7HSZaPofefhG
	 iUfAkqqko0RvTpxh8x5aNItKf0CEXJp0hntgaheqlXrsD3r5/X7yQdqlaqYq7QLIZA
	 4p2HzLVu0sImvsDilLjyUthCf+CiCg/KngVORQpog8K8Q1UGCOOhmcT65b5af5hiK7
	 E0jsNTObUIqy2cxBxOpqHa/bCvnLfH1tkadBt2avG/xuVxi7MHjwOZHkX8IXR8a7kd
	 m2a5h9wkpi7F8igvApGMcJUQdzCFW82S1oExtEFHlfykjyFrzDcwOnoKm/AnbGFABJ
	 igIlWYEjMDbHw==
Subject: Re: [PATCH net-next v4] net: pcs: lynx: enable autonegotiation for
 10g-qxgmii and usxgmii
From: netdev-bot+sashiko@kernel.org
To: pbiel7@gmail.com
Cc: ioana.ciornei@nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
Date: Sat, 26 Sep 2026 00:15:33 +0000
Message-ID: <179038173385.2160803.9549528767206805239@kernel.org>
In-Reply-To: <20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12@gmail.com>
References: <20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] lynx_pcs_config_usxgmii() (drivers/net/pcs/pcs-lynx.c:209-215)
  now writes BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART to the VEND2…
- [Low] The commit message describes a user-visible failure: systems
  where firmware/bootloader does not preconfigure the USXGMII replicator…
- [Low] The comment above the new macros (drivers/net/pcs/pcs-
  lynx.c:23-25) says "USXGMII replicator link timer step is 3.2 ns…
- [Low] lynx_pcs_config_usxgmii() writes MII_ADVERTISE (line 178) and
  LINK_TIMER_LO/HI (lines 194-206) first.

--

net: pcs: lynx: enable autonegotiation for 10g-qxgmii and usxgmii

This patch extends lynx_pcs_config_usxgmii(). After writing the USXGMII
replicator advertisement, it now programs the replicator link timer from
phylink_get_link_timer_ns() and writes BMCR_RESET | BMCR_ANENABLE |
BMCR_ANRESTART to the replicator BMCR. The goal is to stop relying on
firmware or the bootloader to preconfigure the replicator.

> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.

[Severity: Low]
This describes a negotiation failure that users can see. However, there is
no Fixes: tag, and nothing says whether the patch is meant for net or
net-next.

The advertisement-only setup in lynx_pcs_config_usxgmii() comes from
commit 0da4c3d393e4 ("net: phy: add Lynx PCS module"). 10G-QXGMII was added
to the same function by commit 76cd8a2ea98a ("net: pcs: lynx: support
phy-mode = "10g-qxgmii"").

If this is a fix, should it carry a Fixes: tag so stable tooling can tell
which releases are affected? If it is new enablement, could the commit
message say so?

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
This isn't a bug, but does the comment match the macro? The sentence is
about the step, so "1/4 of that" reads as a 0.8 ns step, which would be
ns * 10 / 8.

LINK_TIMER_VAL_10G_QXGMII() actually uses a 12.8 ns step, which is four
times longer. That matches the v3 changelog ("1/4 tick rate") but not the
comment.

For the 1.6 ms timer, the code writes 125000. Reading the comment literally
would give 2000000, which is 16 times larger.

Could the comment say that the tick rate is 1/4, i.e. the step is 12.8 ns?

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
> +
> +		ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
> +					LINK_TIMER_LO, link_timer & 0xffff);
> +		if (ret < 0) {
> +			dev_err(&pcs->dev, "could not set USXGMII Link Timer 1\n");
> +			return ret;
> +		}
> +
> +		ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
> +					LINK_TIMER_HI, (link_timer >> 16) & 0x1f);
> +		if (ret < 0) {
> +			dev_err(&pcs->dev, "could not set USXGMII Link Timer 2\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Configure autonegotiation */
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_BMCR,
> +				BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART);

[Severity: Medium]
Can this drop an established link every time phylink calls pcs_config()?

For USXGMII and 10G-QXGMII, every call now soft resets the replicator and
restarts in-band AN, even when nothing has changed. The advertisement is a
constant, and the advertising argument is ignored. The link timer is also
fixed. So a repeat call has nothing new to program.

The pcs_config() kernel-doc in include/linux/phylink.h says:

 * pcs_config() will be called when configuration of the PCS is required
 * or when the advertisement is possibly updated. It must not unnecessarily
 * disrupt an established link.

phylink_change_inband_advert() calls pcs_config() on a live link and only
restarts AN if it returns > 0. On a link without a PHY, ethtool -A reaches
it every time:

phylink_ethtool_set_pauseparam()
  phylink_update_pause_state()
    phylink_change_inband_advert()    /* whenever !pl->phydev */
      phylink_pcs_config()
        lynx_pcs_config()
          lynx_pcs_config_usxgmii()
            MII_BMCR = BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART

phylink_ethtool_ksettings_set() also calls phylink_change_inband_advert()
when ethtool -s changes the advertisement on a link without a PHY.

Before this patch, those calls only wrote the same value back to
MII_ADVERTISE. The gigabit path uses phylink_mii_c22_pcs_config(), which
only reports a change when the register value actually changes. The commit
message doesn't mention that the link is now reset on every
reconfiguration.

Returning > 0 wouldn't help with the code as it is. lynx_pcs_an_restart()
only calls phylink_mii_c22_pcs_an_restart() on the C22 BMCR, not on the
VEND2 replicator BMCR.

Would it make sense to issue the reset and AN restart only when the
replicator configuration actually changes? Another option would be to
handle the VEND2 AN restart in the pcs_an_restart() path.

In 10G-QXGMII, the four ports share one SerDes lane. If the replicator
reset acts on the whole lane, could configuring one port also disturb the
other three? This is unconfirmed and would need the hardware documentation
to check.

[Severity: Low]
Does the link timer survive this reset?

MII_ADVERTISE and LINK_TIMER_LO/HI are written first. BMCR_RESET is then
sent in the same write as BMCR_ANENABLE and BMCR_ANRESTART, and nothing
waits for the reset bit to clear.

Suppose the replicator soft reset restored its control registers to their
defaults, as IEEE 802.3 clause 22.2.4.1.1 describes. The link timer just
programmed would then be lost, and so would the independence from firmware
that the commit message aims for.

The older enetc code, from before the Lynx PCS module existed, used the
same order on this IP. enetc_configure_usxgmii() wrote VEND2 MII_ADVERTISE
and then BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART, so vendor registers
are probably kept. Can the reference manual confirm this for
LINK_TIMER_LO/HI?

Skipping the wait for reset completion looks harmless. A concurrent
lynx_pcs_get_state_usxgmii() would just report link down, as it does
anyway until AN completes.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12%40gmail.com
