Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97D2F851
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769906648; cv=none; b=rxUDgMrBb3/faUQwfAvNfIYNUkzfp1KvjVTnlK+QexNK5wi/uXlRYfeMUvdiMKuGggkqlFENFHa2IIF1SxUB6pnmZXtz9C4cMDZXjC/gVdQJ67xGqTUVPpAj2Nrt7uAehf3YbW3n862cq+ivYBKQQ+TnmgiP4qwVvQ3kJsER/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769906648; c=relaxed/simple;
	bh=OA7Q9YrHL2xoPfi2sklWNonwOgZc4d+Wx+DZIdbyklo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKFwseUGfgOYGY+D9jUZtzMJd8OydPnRnitqNEVXVS0VIQro7aPBK8WwWqWCWXvuWD0hrzEMQxDArWrlaHRCGj5x6zPWJrg7LOOGHKXIlZYHii/hu28vr/uEXDELzAdjkQ5ATC2g9IAx8s2h1V8QYK4AXxO+vBjeBu5pfUnmTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvX99E3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvX99E3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC401C4CEF1;
	Sun,  1 Feb 2026 00:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769906648;
	bh=OA7Q9YrHL2xoPfi2sklWNonwOgZc4d+Wx+DZIdbyklo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvX99E3vssMYn5lQzJFdI61X61d3TmyvBziTkrjluG/VMSY5VbfgfqWvh7Dr/T2qv
	 79LiipB/GXy/Z2Aj0XufJ2mmkQf4se1bK7Euv6n0KD2WKuuluVHJKp0LMXXP80v9fc
	 1y7Da4yNqlUeXIcAieuPuzScx8WJOqa38oDGJSC15IixczeiWbRDJRAlJ5ScQttPcJ
	 E2a0CUd5EeFHwV3uhfh9hgdwN5TRMUko5hSPRDtltc+xcaE3vsV1ReA0+1p81LpQCp
	 5sQxBW/SIkA5PTMWeW3v2mmWD4EWoSZ7xA9ZDeOIbVqOBykw5djtK6SeSXir2HRYpo
	 TlHHX1+CQHmSg==
Date: Sat, 31 Jan 2026 16:44:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiko
 Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: stmmac: rk: convert to mask-based
 interface mode configuration
Message-ID: <20260131164406.3c90587f@kernel.org>
In-Reply-To: <aX6P9D99Xi4PnI2J@shell.armlinux.org.uk>
References: <aXyPK9rlMt8h_fze@shell.armlinux.org.uk>
	<E1vlmEY-00000006znn-0N0Q@rmk-PC.armlinux.org.uk>
	<20260131140850.3c35f95a@kernel.org>
	<aX6P9D99Xi4PnI2J@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Jan 2026 23:27:48 +0000 Russell King (Oracle) wrote:
> > > +	if (bsp_priv->gmac_phy_intf_sel_mask ||
> > > +	    bsp_priv->gmac_rmii_mode_mask) {
> > > +		/* If defined, encode the phy_intf_sel value */
> > > +		val = rk_encode_wm16(intf, bsp_priv->gmac_phy_intf_sel_mask);
> > > +
> > > +		/* If defined, encode the RMII mode mask setting. */
> > > +		val |= rk_encode_wm16(intf == PHY_INTF_SEL_RMII,
> > > +				      bsp_priv->gmac_rmii_mode_mask);
> > > +
> > > +		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
> > > +		if (ret < 0)  
> > 
> > missing
> > 	gmac_clk_enable(bsp_priv, false);
> > here?  
> 
> Opinions vary on whether errors from regmap_write() should be handled.
> See the recent thread:
> 
> https://lore.kernel.org/r/aXh9lcfw6D6KouI_@stanley.mountain
> 
> Seems that if regmap_write() fails, it's "buy a new computer" realms.
> If that's case, is it worth cleaning up resources, or even checking the
> return code from regmap_write() ?

I don't feel strongly, happy for you to make the call.

Just wanted to flag this now rather than Monday when it can be applied.
(I try to give reviewers 24h of "non-weekend" time before applying so
this series would have to wait until Mon, anyway.)
