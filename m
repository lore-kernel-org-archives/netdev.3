Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29CF315D3B;
	Tue, 27 Jan 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530764; cv=none; b=F+9B2UdythjXg5Y7gA94FNK0BA0uydDIWN8i5VRK2F6l8iJZGuU4eRDRwyh1ITFSsmvfRaGM91n7Y8wBP5cVaBTtnvuuHH06eCHAQyfKwCy7uu5qzroFergGHJl0FiGEZKZSESHghb67+Eq0BZJ7K3PAX4LHUafTEBZNj5u4+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530764; c=relaxed/simple;
	bh=XcbpJRUuL3Ubt5Ed2F7bTwq/ybs5kf2kzi+mBjStBb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6r9eqlZzHrDTmRM35eC298M6qDWkoM1io81jhooGgS18XOANatHb1WYF9wu37W9gwpFGYrVEcRrpTPpjuO+05Fon3LGnrI0DcFDUASdmfkVQ71sxzIiv/+GLNnQFR4yX7/Yh9N8s/zTKZ9h5ObQyS3rM4aHrT4/0CDKkW8RShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1slvacn4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1slvacn4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uQ6dpDIMwFcx1DIyqitolqe18roGblvdy6umSFchGlQ=; b=1slvacn4dO0ytY5r0FD2qvr9/t
	e8zwmuGAdLrNpB0Z+KY0HhEUe1C5ft8z6sek4n3mDDCALCNolN3TOM7xVam+mxCYI8IV5+xNUtfhE
	McA9oYM2eseerQ4ijCe67rfSTYF33kYs5AEvdfa7UQ0SjAvo1IXhKw3t5As8b3L4j66LGCGdf+pEU
	nutNiWZjT8maF+UaxOli9w2NkLa1VsZeXaI6piSRQYH20dPvsCJ5uBw9z+R4H0LbPkYzC/bu4+FWZ
	qrY/b/fSNbZNhK6SAvfp8iaowy0VyVzCxx3CheeKXMoEOaCvoU6KgfXPgJ0wZ5os2+R4B8sPfL+fI
	JrHNl/HQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34082)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vklmV-000000006PY-3xAy;
	Tue, 27 Jan 2026 16:19:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vklmS-0000000062w-145r;
	Tue, 27 Jan 2026 16:19:04 +0000
Date: Tue, 27 Jan 2026 16:19:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v8 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aXjleHGRAIaSji48@shell.armlinux.org.uk>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 22, 2026 at 03:42:07AM +0000, Daniel Golle wrote:
> +static void mxl862xx_phylink_mac_config(struct phylink_config *config,
> +					unsigned int mode,
> +					const struct phylink_link_state *state)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_down(struct phylink_config *config,
> +					   unsigned int mode,
> +					   phy_interface_t interface)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_up(struct phylink_config *config,
> +					 struct phy_device *phydev,
> +					 unsigned int mode,
> +					 phy_interface_t interface,
> +					 int speed, int duplex,
> +					 bool tx_pause, bool rx_pause)
> +{
> +}

The above three are required, but...

> +
> +static struct phylink_pcs *
> +mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
> +				phy_interface_t interface)
> +{
> +	return NULL;
> +}

This one isn't, you can drop it and phylink will assume NULL.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
