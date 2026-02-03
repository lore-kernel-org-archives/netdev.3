Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3664F50F;
	Tue,  3 Feb 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141316; cv=none; b=VcNAOpbINszWwmd3CM/pt8SkkmXA8mzMGBFxWFO3M7rDSDwGecUOCnXTsGW1xMqHYD1OT9xDeYxkhs3gBu9dlWISvKDcfVKaQ+K+uV5920xiuQ+CJPYzriwjy5nbbPv1PheY8l2bVNldb1XN35dS6ZLRoZr6chg9WvrGJdrVSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141316; c=relaxed/simple;
	bh=fhXu3myPBQm4b4CwJjxgsBi3evYqCIPnYH4wv8re0Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWmqV98BzKphU71zh9pUEh42JrSZismbTIPNYxbfe0cZygRUUv7qU5aJSzSuu19zSosOW3Xg4+Pxju8kK0FYq99bIHu3bWW2dn4M+vBsYidTxOTUN/VxDtCmfZgQyOHyQiEWOJP1x6YA2H+nm4CBokNWSEwo70LHVciszGa+ReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFz39KYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFz39KYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6540BC116D0;
	Tue,  3 Feb 2026 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141315;
	bh=fhXu3myPBQm4b4CwJjxgsBi3evYqCIPnYH4wv8re0Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFz39KYLoFs7fFx+qLtReEpvgi/WO+K+4jmYJDutHSJQT2gX6LwfrffCqVuOR0nOn
	 O8uCJklZ0bPc07DNfWReY6pu375je6RJ2JwH873mj+lK88WwT4kWRLZwWQLZpSU5K+
	 eevhj6E9UNHLK/Ty+OtE3frhc6+uUsyRGD43Lc2UIDf+jC9O+YwnTTYR5M8woeu4UP
	 R9i4aIAjeQva9FOwWLGaG5RYPRvNmZEuU/RNCB+xbBEiF34e/Cu/F1K5F0GOWSnvx2
	 vVJ7/CijA3ikfsflOQRzmcJjcdFXAQ22hs7U12E6+lD5JwpvRQZawamFnKsE8TLCNg
	 K0c1vgCIUES/Q==
Date: Tue, 3 Feb 2026 17:55:09 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v3 10/11] netlink: specs: Add ethernet port
 listing with ethtool
Message-ID: <aYI2fZPCehPkke1G@horms.kernel.org>
References: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
 <20260201151249.642015-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201151249.642015-11-maxime.chevallier@bootlin.com>

On Sun, Feb 01, 2026 at 04:12:47PM +0100, Maxime Chevallier wrote:

...

> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index af56c304cef4..3e673755800b 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -2522,6 +2522,40 @@ Within each channel nest, only the metrics supported by the PHY will be present.
>  See ``struct phy_mse_snapshot`` kernel documentation in
>  ``include/linux/phy.h``.
>  
> +PORT_GET
> +========
> +
> +Retrieve information about the physical connection points of a network device,
> +referred to as "ports". User needs to specify a PORT_ID for the DO operation,
> +in which case the DO request returns information about that specific port.
> +
> +As there can be more than one port, the DUMP operation can be used to list the
> +ports present on a given interface, by passing an interface index or name in
> +the dump request.
> +
> +Request contents:
> +
> +====================================  ======  =================================

Hi Maxime,

make htmldocs complains that "Bottom/header table border does not match top
border.".

> +  ``ETHTOOL_A_PORT_HEADER``             nested  request header
> +  ``ETHTOOL_A_PORT_ID``                 u32     port id
> +  ====================================  ======  ===============================
> +
> +Kernel response contents:
> +
> +  =====================================   ======  =============================
> +  ``ETHTOOL_A_PORT_HEADER``               nested  request header
> +  ``ETHTOOL_A_PORT_ID``                   u32     the port's unique identifier,
> +                                                  per netdevice.
> +  ``ETHTOOL_A_PORT_SUPPORTED_MODES``      bitset  bitset of supported linkmodes
> +  ``ETHTOOL_A_PORT_SUPPORTED_INTERFACES`` bitset  bitset of supported MII
> +                                                  interfaces
> +  ``ETHTOOL_A_PORT_TYPE``                 u8      the port type
> +  ``ETHTOOL_A_PORT_VACANT``               u8      for non-mdi ports, indicates
> +                                                  if the port is connected to
> +                                                  another device that could
> +                                                  expose a MDI
> +  =====================================   ======  =============================
> +
>  Request translation
>  ===================
>  
