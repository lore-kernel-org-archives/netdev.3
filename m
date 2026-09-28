Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB54E06EC;
	Mon, 28 Sep 2026 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616691; cv=none; b=c9JdmPX+RJAcHvt8IgVNbQxYHYkYCkygpq6+98jMHOTMFcRwMw8lAEGrKSXXys180r2+W6S0Imxs3qliWjmnitf/Pay0t9KISKoZ7g0I52WTBfvrzit2xABw3AMLLeyGqozRBGYfJbamQT0P7Y+YxQ57vBKH+BENNnQl2r7YkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616691; c=relaxed/simple;
	bh=e610i3YkKCJ7ovp5CVxmH37BSfaeDa6goPAswzlSaxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1VaPBeRLImj4R+MG5LgFVzs1564lbIo1EAaENfmpzuBBI6pIYVrlHEVr0sHdewgSwVT6432BflUDLMLWo7c5MX0T3sIPGjZRx6YKsXwqhgYdGUfY/Utr+ClefbFc27+whg1i3pfiA/o+OPxYBlMl48TYj74PoDl5Fu3vckJyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWdT5vPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWdT5vPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFF71F00893;
	Mon, 28 Sep 2026 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616689;
	bh=iQQS9XYFhdTKtd3oL9IPy/F06HT1iz+PJR+Bok9jroc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AWdT5vPaGegKrRimuMHvTQfHH9WjlmeyLB3ovAArHUmSPCdybJNTQOboBaDfwQwWk
	 2hnc+xRHY6JjRh7dXntj5PFFxEfWqaWDzAPNLFV8e3b9sg4RESbPxFHz1LoLq4lStO
	 QD+gnzsOH1WbTJp7BlJuL0LgnYZWPVolmvvB+n9LGqMX8qqBgJJpnlEI3EvIeFSB2z
	 rHKkoH9RMywfGxgVerz2GHQWvEHGN5gSsW8QOdHRUgZSQyehyAOmzNUygXXx8dHzMN
	 dn1VzscpxHO1HhR1c9kxUQNuHKZ6FKdOkC2BlxfmeaSQUbZWH6X4MrFndJpZlG+Hb2
	 kbSl4ZKlfzUSg==
Message-ID: <7a4003e7-3c8c-4c9a-9365-10475a61c08b@kernel.org>
Date: Mon, 28 Sep 2026 19:31:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 00/10] net: phy_port: SFP modules
 representation and phy_port listing
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> Hello everyone,
> 
> Here's V18 for the phy_port improved SFP support and netlink interface.
> 
> V18 aggregates Andrew's reviews (thanks !) and Aleksei Tested-by tags
> (thank you as well, this is nice). It also contains a few tweaks
> following sashiko and Aleksei's report after testing, the ops-locked
> check also checks for NULL netdev ops. I also added a missing rtnl()
> around port deletion in phylink, and changed a bitfield to a bool in
> phy.h following sashiko and Aleksei's reviews.
> 
> This work extends on the recent addition of phy_port representation to enable
> listing the front-facing ports of an interface. For now, we don't control
> these ports, we merely list their presence and their capabilities.
> 
> As the most common use-case of multi-port interfaces is combo-ports that
> provide both RJ45 and SFP connectors on a single MAC, there's a lot of
> SFP stuff in this series.
> 
> This series is in 2 main parts. The first one aims at representing the
> SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
> by far the most common cases for multi-connector setups.
> 
> The second part is the netlink interface to list those ports, now that
> most use-cases are covered.
> 
> Let's see what we can do with some examples of the new ethtool API :
> 
> - Get MII interfaces supported by an empty SFP cage :
> 
> # ethtool --show-ports eth3
> 
> Port for eth3:
> 	Port id: 1
> 	Supported MII interfaces : sgmii, 1000base-x, 2500base-x
> 	Port type: sfp
> 
> - Get Combo-ports supported modes, on each port :
> 
> # ethtool --show-ports eth1
> 
> Port for eth1:
> 	Port id: 1
> 	Supported link modes:  10baseT/Half 10baseT/Full
> 	                       100baseT/Half 100baseT/Full
> 	                       1000baseT/Full
> 	                       10000baseT/Full
> 	                       2500baseT/Full
> 	                       5000baseT/Full
> 
> 	Port type: mdi
> 
> Port for eth1:
> 	Port id: 2
> 	Supported MII interfaces : 10gbase-r
> 	Port type: sfp
> 
> - Get Achievable linkmodes on a SFP module (combo port with a DAC in the
> SFP cage)
> 
> # ethtool --show-ports eth1
> 
> Port for eth1:
> 	Port id: 1
> 	Supported link modes:  10baseT/Half 10baseT/Full
> 	                       100baseT/Half 100baseT/Full
> 	                       1000baseT/Full
> 	                       10000baseT/Full
> 	                       2500baseT/Full
> 	                       5000baseT/Full
> 	Port type: mdi
> 
> Port for eth1:
> 	Port id: 2
> 	Supported MII interfaces : 10gbase-r
> 	Port type: sfp
> 
> Port for eth1:
> 	Port id: 3
> 	Upstream id: 2
> 	Supported link modes:  10000baseCR/Full
> 	Port type: mdi
> 
> Note that here, we have 3 ports :
>   - The Copper port
>   - The SFP Cage itself,
>   - The SFP module
> 
> This series builds on top of phy_port and phy_link_topology to allow
> tracking the ports of an interface. We maintain a list of supported
> linkmodes/interfaces on each port, which allows for fine-grained
> reporting of each port's capability.
> 
> What this series doesn't do :
>   - We don't support selecting which port is active. This is the next step.
>   - We only support PHY-driven combo ports. The end-goal of this whole
>     journey that started with phy_link_topology is to get support for MII
>     muxes, such as the one we have on the Turris Omnia. This will eventually
>     be upstreamed as well.
> 
> If you want to play around with it, here's [1] the patched ethtool that I've
> been using to produce the outputs above.
> 
> Thanks !
> 

Tested on one of my powerpc boards, I get the expected result:

~# ./ethtool --show-ports eth0

Port for eth0:
Port id: 1
Port type: phy
forced : off

Tested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Looking forward to the support for MII muxes.
