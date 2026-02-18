Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777D2EA749;
	Wed, 18 Feb 2026 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430912; cv=none; b=N4tMDp2RIC51FwjT4H1rgrJQr/lEsrriiF/0DD7IZIvtRHiXNe8sfP5EJnTFr0IYt+tHg5jCFX9nnhcLU2i8VAcMoVyNvCYVbXb4jdcahqMHswrWCgT14dSNxMunj/vIJz/Z4y5jfZkxrw9XI87mpLzoHCETOur8Y9YuAF1bH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430912; c=relaxed/simple;
	bh=cq5L+CADSg7qJpOpjqIsVMGSltF78pmgkj2DdYsUd2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBwuva/E+ywXttYGk89sBxPXkX+cl7l8DGxJ7gvmsEOvwDvIvkfdMXkFubrjp5SRYdMGrf7K0xyxQD9t6jYB7iL8CiT4aaIMgNmf3PkGaKt5I2Cnai+My8jQ6m8fTQoRPd3KI6zDZjLWuGzdhaWmXJEdzNcT8TNDTXHsXVdLozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qbQRPki1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qbQRPki1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eFT6C+yxI0sjPQxe8mIfCtcfndXXgVW1UOPFbDb9HdA=; b=qbQRPki1h7R962mTDOovjF6s+E
	XtvHZ7pfnqcp//JbLEgrdA40zw8X2upNlhWXsnkMyULfNNgtSOEXF5xJSHMSpMmj+5ZLLq/BItkLh
	EK/XsPKm7Q8gEI/CnECFGuWls4RnJIKZpDKrhD6YnN3vZhH2yOBIru6uy0d4Sn/mMjs/kRaTAKXiR
	SE76B2ruo32FDhtVKUX7taP8O0oZUmIXoXP1N0qz46YrpSPmUpHDKQqC0/KzbHgFa5A56uLvwKDuT
	xyJ4z9tW9/TocwAIyooo5dmkWKx0uDdB273FDujQNLNHPkG8YT0+1Wh7mlJTiV3R71l4kkFmh1iLs
	sMPARL8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51350)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vsk68-000000000DG-3P6c;
	Wed, 18 Feb 2026 16:08:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vsk65-000000002MC-35eI;
	Wed, 18 Feb 2026 16:08:17 +0000
Date: Wed, 18 Feb 2026 16:08:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: sja1105: protect link replay helpers
 against NULL phylink instance
Message-ID: <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
References: <20260218160551.194782-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218160551.194782-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 18, 2026 at 06:05:51PM +0200, Vladimir Oltean wrote:
> There are multiple levels at which this could be avoided:
> - add an "if (dp->pl)" in sja1105_static_config_reload()
> - make the phylink replay helpers NULL-tolerant
> - mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
>   has run, such that subsequent dsa_switch_for_each_available_port()
>   iterations skip them
> - disconnect the entire switch at once from switchdev and
>   NETDEV_CHANGEUPPER events while unbinding, not just port by port,
>   likely using a "ds->unbinding = true" mechanism or similar
> 
> however options 3 and 4 are quite heavy and might have side effects.
> Although 2 allows to keep the driver simpler, the phylink API it not
> NULL-tolerant in general and is not responsible for the NULL pointer
> (this is something done by dsa_port_phylink_destroy()). So I went
> with 1.

^^^^^^^^

> v1->v2: select option 1 instead of 2

Given this, I think the paragraph above needs updating.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
