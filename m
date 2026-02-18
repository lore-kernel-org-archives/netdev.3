Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768330C36D;
	Wed, 18 Feb 2026 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404671; cv=none; b=XX4/l8h9wszv6AJJ2M5c0vQKuaE6DtTUUuMNQ1Ua5oSIu5cXcbFAB3seuELlAm4DJ4XbDCwgnvMOcEtlgNQnaMELmtrNB1aMYrcPw8H3q4aKGJ+yiDbd53xv7zLJmiXCdhZy9JetdxnsAzHnplcHFqaq70dz+wAsNbxh3PoXYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404671; c=relaxed/simple;
	bh=nes0Jm4wQ3o08IosrR5HMJuAEWV4ZECFMiLZjrYwgfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTG6jnqD8YCEuM90MaGddwWTlCL8T6eZJlHCr6Baq58rN+9HE1sGhROEva7WwF30q/LRH5XnlvlTt5q1VZalitqoPxzifeadwsbGjyvQl3ZDvUFtJ3OaWiDbtQvg5mb+HUDjdHfGsePnEka2S3DW//f/dXmH5BtbFX9L1Phtqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TfMyM0xS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TfMyM0xS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q9PdRsv4oqQEVjsON/ocmS3V9+KatKpnLZcn3ErO6qY=; b=TfMyM0xSBrrKT1CiuQJKM0uc7k
	ucnbw5TizCFgds/lH6jRMqWhKLeihC0t/sGFqZ8H4ZpS/LWPxfpEatP1Oehtqtb4IN9tMFLoNf8h+
	RLC5TkwgqvC3wER391OsmS2HAL132OFwg4vlCiptgnJhfcoTgwRixYiu4Ax/IAdp903uZxoiFlAEC
	P0gTQTSA8veYQDHJ/ueDasVzVLNKtO1YgQ7i4k+D+PSEuPBMeSzPY10yBC5i+Pzdg66S0pY6nvKKe
	4+BhlKw3tvif5XqdAb9wIP1QjRX5zQDcoseo8usv24Afi7fMPoyP0+PLN3HSvf/cacQAnh1MDXZ5a
	xP/SGL9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45412)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vsdGv-000000008ML-3Hpb;
	Wed, 18 Feb 2026 08:51:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vsdGt-0000000026z-3ltu;
	Wed, 18 Feb 2026 08:50:59 +0000
Date: Wed, 18 Feb 2026 08:50:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: stmmac: manage error case during
 stmmac_dvr_probe
Message-ID: <aZV9c6lBeLX5s5Fo@shell.armlinux.org.uk>
References: <20260218083618.67805-1-christophe.roullier@foss.st.com>
 <20260218083618.67805-4-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218083618.67805-4-christophe.roullier@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 18, 2026 at 09:36:18AM +0100, Christophe Roullier wrote:
> In case of error during stmmac_mdio_register, pm_runtime is not
> cleaning before exit probe.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
