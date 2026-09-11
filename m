Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A99384CEC;
	Fri, 11 Sep 2026 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152723; cv=none; b=R1UgFDo8N0U0AjGYu4nImTqN3vVsEgFTUvpwvSnNT6SC6ECsFtiIVmykYlJP38HS2nlKfzYw8G5xWYQjWyTpdruEFJYDI31HYD+L58iTWYDwnSOMi2XCaS2d5oDI7AwELnripgOu1FCMVgWl+LZCTiLAXxXSdYLUx5P9WGI0GME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152723; c=relaxed/simple;
	bh=YoLZdHfYUDKZiIGuPobJ+qdjxlZ5L36ikQj4ePDQMOo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJT8+5ajrPbcr0we89U2IrNO8EW8fesamep4DINOSPqC+VA2ilbEANEwHRkY3wvHtpwr/yLBYWYE3+wdCsyR9f54XWmgCWMC8uN8oUjYBBGpeRoFka1KuuNpExh2KofQOOR6U7SF5TErC3W0jApKp82SrH7Tuq92LxxvaeQLZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqeRJbUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqeRJbUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D021F000FF;
	Fri, 11 Sep 2026 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152721;
	bh=f+6ZKOGA5YsWao0IZpyUtgeHVx3PC7VhFf0ZEGNQZEQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FqeRJbUTusOhaF3FxbHXBlx0xahvf/t5pupE20JZMKOksidM+p0ZSjfrbP+FJgeaa
	 AsZRQZXtJ7MaqgKfqMFmYdWzg+sVFNfFQY1EEm5Nvohr/nJ+C7rH9xGImeoZL4YlaJ
	 1wJzy1KbEB5Ml0s/bNmupwS/voFm+yndaJLKl+FljX9t8VCzXic+nrmXzsLcdzo4gf
	 4PNY/L5IWi+qSVvQdsVqlvSkfEDpA2BSsRgNsYFV9udYLaS5/PCF+M+pBMpcw/2YRy
	 uP/fxkFp0RSLwbz0c7s/aMHQR857xF9G1ca4WwGoJf6dQNR5wyHrAYzG8MGTMzdpqH
	 lOE6mvWQg4G5g==
Subject: Re: [PATCH RESEND net-next v17 01/10] net: phy: phy_link_topology:
 Add a helper for opportunistic alloc
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it
Date: Fri, 11 Sep 2026 18:51:59 +0000
Message-ID: <178915271948.219967.6044042768895968016@kernel.org>
In-Reply-To: <20260910170103.1029108-2-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-2-maxime.chevallier@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The comment added to phy_link_topo_get_or_alloc()
  (drivers/net/phy/phy_link_topology.c:38-51) justifies the lock-free…

--

net: phy: phy_link_topology: Add a helper for opportunistic alloc

This moves the opportunistic allocation of struct phy_link_topology out of
phy_link_topo_add_phy() into a new helper, phy_link_topo_get_or_alloc(),
which returns the existing topology or allocates one, reporting failures
via ERR_PTR().

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 4134de7ae313d..0462283c80202 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -28,11 +28,39 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
>  	return 0;
>  }
>  
> +static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *dev)
> +{
> +	int ret;
> +
> +	if (dev->link_topo)
> +		return dev->link_topo;
> +
> +	/* The topology is allocated the first time we add an object to it.
> +	 * It is freed alongside the netdev. It can be called on multiple
> +	 * contexts:
> +	 *  - It can be called from .probe() : No rtnl, no netdev_lock
> +	 *  - .ndo_open() : rtnl and possibly netdev_lock
> +	 *  - SFP state machine : rtnl held or not
> +	 *
> +	 *  However, we can't really have races :
> +	 *  - If we have a PHY, phy_link_topo_add_phy() will always run first
> +	 *    and trigger the alloc. Only then the ports can be added through
> +	 *    phylib or sfp.
> +	 *  - If we don't, the SFP port for the cage is registered first, and
> +	 *    only then other ports/PHYs can be registered.
> +	 */

[Severity: Low]
This isn't a bug, but the new comment in phy_link_topo_get_or_alloc()
reasons about objects that don't exist yet at this commit.

At this point struct phy_link_topology only tracks PHYs:

include/linux/phy_link_topology.h:
	struct phy_link_topology {
		struct xarray phys;
		u32 next_phy_index;
	};

and there is no phy_link_topo_add_port(), so "Only then the ports can be
added through phylib or sfp" and "the SFP port for the cage is registered
first" have no counterpart in the tree at this commit.

Would it read better to move that part of the comment to the follow-up
patch that adds the ports xarray, next_port_index and
phy_link_topo_add_port()/phy_link_topo_del_port()?

For the record, this resolves itself later in the series: the next patch,
"net: phy: phy_link_topology: Track ports in phy_link_topology", adds the
ports xarray and the port add/del helpers that call
phy_link_topo_get_or_alloc(), so by the end of the series the comment
matches the code.

> +	ret = netdev_alloc_phy_link_topology(dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return dev->link_topo;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
