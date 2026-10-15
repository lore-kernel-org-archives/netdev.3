Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B047D44D;
	Thu, 15 Oct 2026 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792098566; cv=none; b=cg5pQFy7alAxB2wBfB0FuvM6Z6iTxDp+Yn0yyVxxnYwzlyhbi5q9vcM5OvZHKMl0DwmngIOEu8JakVBfJ/2aASTj6K0TQ/KEjJCgWqezbWSAH8dC0MWvmU+JilWvqGTzNQ2eA9FYVrirwEE+ZKAxXMaf6nf6fObDw3eG3+sIpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792098566; c=relaxed/simple;
	bh=9Y46DEC3PPmcE7MNTmHva0nYD66oOBCo5fZT6uzi2hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu7L0fDwc4riCijtt+FPABEub1kgXAkQBJh+0DoIU9a/OkV/V2fvSNIBnGrYociAQTPazhSPYpPuhzCuDahfxEU+KOlQZ0M5HfzzSldVoKNsonHvyg0m5fOBr1XlnZJFj0daA3mUtgRwCTPWzNcGIkGZOVWqG4LlXo7QIk7pRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5kbK7uYa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5kbK7uYa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sm5AtA3zThJ2soW28fcDouT2WceUmE7esbpI3ceQWzU=; b=5kbK7uYa1Ou7FlQWVyTZ8WKHtz
	JDfumCJ531FNlHHYqePgLc+EUYJ3tL/CFJaX9A1qRn+fzyu6XBf2je/j5y34tKIbDOtrQflGy9KqW
	mxXg4VwLpcafgNcymJwGAGfY8EyMDIJ3jA4mJrJIkFqw2FzyJaiv4W0zwzTDP/KPBNwM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHShO-00B1oK-D4; Thu, 15 Oct 2026 23:09:14 +0200
Date: Thu, 15 Oct 2026 23:09:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for
 10G-baseR capable PCS
Message-ID: <f8c01002-da88-4f0f-a02a-7480591f4296@lunn.ch>
References: <20261014223100.304486-1-elder@riscstar.com>
 <20261014223100.304486-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014223100.304486-3-elder@riscstar.com>

I don't know this PCS driver, so maybe dumb questions....

> Currently the XPCS found on Toshiba TC9564 is unable to operate at
> 2500base-X and slower with a PHY connected using SGMII/2500base-X
> (in our case a Qualcomm QCA8081).

Is the PHY actually relevant here? What about SGMII/2500base-X for an
SFP?

Is this purely a PCS problem, or does what the PCS connect to make a
difference?

> The problem arises because this XPCS supports 10Gbase-R. That means
> that the reset value of SR_XS_PCS_CTRL2:PCS_TYPE_SEL (0) is valid and
> this suppresses the modal switching based on bit 13 of SR_PMA_CTRL1
> or SR_XS_PCS_CTRL1.

~/linux/drivers/net/pcs$ grep SR_XS_PCS_CTRL1 *
~/linux/drivers/net/pcs$ grep SR_PMA_CTRL1 *
~/linux/drivers/net/pcs$

This is not helping me understand what is going on here.

> +	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_SGMII:
> +		case PHY_INTERFACE_MODE_1000BASEX:
> +		case PHY_INTERFACE_MODE_2500BASEX:
> +			/*
> +			 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want
> +			 * the modal behaviour that comes when we pick a
> +			 * reserved value. XPCS allocates extra bits to this
> +			 * field and allocates values from 15 down so
> +			 * MDIO_PCS_CTRL2_TYPE + 1 is the value likely to be
> +			 * allocated last (and hopefully never).

MDIO_PCS_CTRL2_TYPE is 3. Looking at 802.3, the value 4 is
40GBASE-R. The 2022 version of the standard has values defined up to
10011b, for speeds up to 400G,

Alex added support for 25G, 50G, 100G.

Is this an issue?

	Andrew
