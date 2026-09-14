Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471B471256;
	Mon, 14 Sep 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389465; cv=none; b=eBXPKEk7oXN2Q14q0C10/h5O6rjkjtTzTbD8eELTyg73pAJfsUvsn+8poHvUOwixFC/r0in/kkhps55+rtEXXOaZB4/pgJxOFjwejJC3n0lFUiWklWOCdl4ychzbde8Zgk7wtcxF9aaCl1VrOXUMI11lDdntMk9wqMboraGXnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389465; c=relaxed/simple;
	bh=unHGFqFI3Vc6Ehw1zKTLVRWLmr5GW/DE/rxNl5THv4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSdhLRW96KgZ49qB0SgPQPmIcFyvzwmR3so5R/oSW2MnsdFjVaXBXK0+7yxYmY0ss33LuRPJKFqpDSPERCltUt4szfERvNmlHp1yDtoxy0okeQimjkeiXFdDZCF3bqJUB1guboEtiQqtcTJCUTfdgx0BXgwrJ0sKo6vfHRtMUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sBroTqwr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sBroTqwr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EQvmED0XLnRiwVr+hqQN5dNbbcwXDcg5FEOEt6uQaAU=; b=sBroTqwr4aHv8+LplZswgoX3aU
	0Ss5buFm1c3RrFWkMwVnYWKyRfaZhFX1ouyFnw2t0qDn5TNJ/XxoYHHJkXeDuw+IV28RTbuxXnr9m
	v34tXwpKoqoTtxi/+HLGgoIdg5KRyVRQe0kKD/j2eyyWE4sLTs1mwCheiF4c6/TS1vYE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x65w8-00550T-FI; Mon, 14 Sep 2026 14:37:28 +0200
Date: Mon, 14 Sep 2026 14:37:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <dqfext@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: phy: mediatek: do not report link and per-speed
 LED rules together
Message-ID: <06b12441-4018-46ab-87a8-668078bcd9f7@lunn.ch>
References: <20260912134306.3544329-1-naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912134306.3544329-1-naseefkm@gmail.com>

On Sat, Sep 12, 2026 at 05:43:06PM +0400, Ahmed Naseef wrote:
> mtk_phy_led_hw_ctrl_get() reports TRIGGER_NETDEV_LINK whenever any of the
> speed bits in on_set is on, and in addition reports every individual
> TRIGGER_NETDEV_LINK_* bit that is set. The netdev trigger refuses that
> combination: netdev_led_attr_store() rejects TRIGGER_NETDEV_LINK together
> with any per-speed rule, and it validates the whole resulting mode rather
> than just the bit being written. Once the hardware has any link bit
> programmed, every write to the trigger attributes of that LED therefore
> fails with -EINVAL and the LED can no longer be configured.
> 
> The rules are also fed back into the hardware: the trigger stores what is
> read back, and a later write of device_name programs it again, expanding
> TRIGGER_NETDEV_LINK to every speed in on_set. An LED configured for a
> single speed is thereby silently widened to "on at any link speed".
> 
> Both are easy to see on the EcoNet EN7528, whose four PHYs share one LED
> block. The first LED programs the block correctly, the second reads those
> rules back and rewrites them widened, and the remaining two then read the
> widened value, so an LED configured for "link_10 link_100" ends up lit on a
> 1000 Mbps link.
> 
> on_set holds every speed the LED can indicate and is exactly what
> mtk_phy_led_hw_ctrl_set() programs for TRIGGER_NETDEV_LINK, so report the
> speed independent rule only when all of them are on, and the individual
> speeds otherwise. The mapping is then the inverse of the one used when
> programming the LED and round trips without changing the register.
> 
> Fixes: c66937b0f8db ("net: phy: mediatek-ge-soc: support PHY LEDs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
