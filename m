Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473B7261C;
	Tue,  3 Feb 2026 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148639; cv=none; b=Sz+4VNySOYySebs4bwbts3D2tLhnC16fBkMWcU/ZeR10P9e78l+wHr2op0Fe3XIDttZckSeyr5AjuqxaSpMFLtNnCtty6p/JJEqUZS25cb0uYqys+SEjXN7yrhZaSoqn/alD+dAgdwcLXjAWoXq4HKOnm1saAEn7aHmN1KtYsk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148639; c=relaxed/simple;
	bh=WjRWiSP6xdJFHmnQYRZlsn+5o27f57toaWDOn5TrWwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYciIBmDgsCHtiqLTaYvF//W+PM50CEWAYfakGk1LfG0cTjf77HS6UkhBZ7lCqv83akbJhNZqLamnLYRgih34veIPTEfViU7M0uEBARjX8wz3stEp4dspSc+NLOL0494UXf0qDxYMS4O/rRw9Cfnn9l2LVTAiCS54weRa9jk2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4V5NPVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4V5NPVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD5C116D0;
	Tue,  3 Feb 2026 19:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770148639;
	bh=WjRWiSP6xdJFHmnQYRZlsn+5o27f57toaWDOn5TrWwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4V5NPVWz1tOisW/7qD1uox5NDQSepBcyBwbeGxQUWvkyc8leMXBIJuUMnBy+08fr
	 9nT/X5iS76wXJ0xGnouQyb7vgKUhnHt5WFgVT13BNOEBAFva4IGPL/lYlkTmAYdbuH
	 C2VqhgHZ/tx27qWR92o+0dqCKODmRHCmX/fFM8ySu0t1gmGRY3aLIcL1hy+JkW/69F
	 TZJljVCqx+pW/ixPw3n1LLAmkZ3NWGqJhwqjNo0HQf0BJg1cWzEG1PA1P7qmrhsvI7
	 mQYoYUgtz6PUe6U3mSX8Y0adNM2nM38jXiy2lIYkKrbyNP2XpjFbpighujYIlKHlzU
	 FgpDX4su+23oQ==
From: Simon Horman <horms@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	nicveronese@gmail.com,
	kory.maincent@bootlin.com,
	f.fainelli@gmail.com,
	o.rempel@pengutronix.de,
	kuba@kernel.org,
	mwojtas@chromium.org,
	daniel@makrotopia.org,
	davem@davemloft.net,
	dimitri.fedrau@liebherr.com,
	edumazet@google.com,
	romain.gantois@bootlin.com,
	vladimir.oltean@nxp.com,
	kabel@kernel.org,
	christophe.leroy@csgroup.eu,
	thomas.petazzoni@bootlin.com,
	herve.codina@bootlin.com,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com
Subject: Re: [net-next,v3,06/11] net: phy: Represent PHY-less SFP modules with phy_port
Date: Tue,  3 Feb 2026 19:57:10 +0000
Message-ID: <20260203195710.2176606-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201151249.642015-7-maxime.chevallier@bootlin.com>
References: <20260201151249.642015-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: Represent PHY-less SFP modules with phy_port

Now that the SFP bus infrastructure notifies when PHY-less modules are
connected, we can create a phy_port to represent it. Instead of letting
the SFP subsystem handle that, the Bus' upstream is in charge of
maintaining that phy_port and register it to the topology, as the
upstream (in this case a phy device) is directly interacting with the
underlying net_device.

Add a phy_caps helper to get the achievable modes on this module based
on what the phy_port representing the bus supports.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1609,6 +1613,74 @@ static void phy_sfp_link_down(void *upstream)
> +static int phy_add_sfp_mod_port(struct phy_device *phydev)
> +{
> +	const struct sfp_module_caps *caps;
> +	struct phy_port *port;
> +	int ret = 0;
> +
> +	/* Create mod port */
> +	port = phy_port_alloc();
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->active = true;
> +
> +	caps = sfp_get_module_caps(phydev->sfp_bus);
> +
> +	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
> +					phydev->sfp_bus_port->interfaces);

At line 1638, phy_add_sfp_mod_port() dereferences phydev->sfp_bus_port
without checking for NULL. Can this be NULL here?

Looking at the initialization in phy_sfp_probe(), when sfp_bus_add_upstream()
fails, the error path frees the port but then unconditionally stores it in
phydev->sfp_bus_port:

> @@ -1700,7 +1774,7 @@ static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
>  static int phy_sfp_probe(struct phy_device *phydev)
>  {
> -	struct phy_port *port;
> +	struct phy_port *port = NULL;
>  	struct sfp_bus *bus;
>  	int ret;
>
> @@ -1729,6 +1803,8 @@ static int phy_sfp_probe(struct phy_device *phydev)
>  		phy_port_destroy(port);
>  	}
>
> +	phydev->sfp_bus_port = port;
> +
>  	return ret;
>  }

If sfp_bus_add_upstream() returns an error at line 1800, the cleanup path at
line 1802 checks 'ret && port', then calls phy_del_port() and
phy_port_destroy() to free the port. However, line 1806 still executes
'phydev->sfp_bus_port = port', which assigns the freed pointer to the
phydev structure.

When phy_sfp_probe() returns an error, probe fails and the PHY device is not
properly initialized. Later, if a PHY-less SFP module is inserted, the SFP
subsystem calls phy_sfp_module_start(), which calls phy_add_sfp_mod_port(),
which dereferences phydev->sfp_bus_port->interfaces at line 1638.

Should the assignment at line 1806 be conditional, or should port be set to
NULL after freeing?
