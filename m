Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98D385527;
	Wed, 15 Apr 2026 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237600; cv=none; b=NL3ZfGFHqNBi9mm8QjwVZ2RC9sH05yeBd9KxiGCdCgJR0RVCGWb30o9MJkJnNvgAEMPeGqmGTzx73ZPlTtx5idMLwUXJWoqAPhZyhwN30kDYLCaip6TFtMuEmV1LQIKqy76cZoGnvahYVQxccGmqAcsT0dCaVy8AePXnMUCHblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237600; c=relaxed/simple;
	bh=iL4qnyzYD0+HjPCZwNoVOf7kj2fFo/CQ5dfX0B7N0+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYvFcPhmCtqeEUo2QIO8w5x9THtKG965iTaqvfUbM73ts3JU6VmzjJiIYmK4ef6xwqhQMlYl1tE1f+HUq6IqkIiHT/vm2e/TdFwh4vSrrnnsSx80di97VopCwkoHwWH5fD5m4vLP63L+J4GGkE3boEF2mwNCsHPjk4AjN1ynz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G1i0Q2jh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G1i0Q2jh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E63DDC59F5D;
	Wed, 15 Apr 2026 07:20:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F9A760420;
	Wed, 15 Apr 2026 07:19:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A4CE10451388;
	Wed, 15 Apr 2026 09:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776237595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RAWdFKvWHQ1+QstGKwxtv4g5iwHO+BNUcp9lPcgcG0Q=;
	b=G1i0Q2jhuQ53aL/8i+69T+paXUk+sXyT65qxBI6DMReGMzguVK27jou24s3uCJr8SU86Xj
	jxvkFoDq2iBdXHmr4hbTcbGBKbpMOcfiqBTxG330Q6gur0Ag02DYmKzyjLAYeHshRVKBBQ
	xPAKZCUyuhBvUtDErzVbROvTEMpY/skyLVyOCIw5pHX0qzmjAVZeYnww9cLg7mglKTrztl
	F0f2SsRFLjQv7bUPHM+1qX3hpClmctaYuh9mfmCRcgePMaOvCKQ0fLC4Q6R8x4Dt4z0IWg
	g/bSLRCrJCSUshhs4m4Jwcsor21SFYiiHon0HXcOvWpF9MOgTEOTjCP5huVgLw==
Message-ID: <e4f6503c-6514-46f1-bf4f-a38c12903c16@bootlin.com>
Date: Wed, 15 Apr 2026 09:19:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 04/10] net: phy: Create SFP phy_port before
 registering upstream
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <20260403123755.175742-5-maxime.chevallier@bootlin.com>
 <2bdd6224-6acf-49db-955a-5552e64d4b73@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <2bdd6224-6acf-49db-955a-5552e64d4b73@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 15/04/2026 01:46, Andrew Lunn wrote:
> On Fri, Apr 03, 2026 at 02:37:48PM +0200, Maxime Chevallier wrote:
>> When dealing with PHY-driven SFP, we create a phy_port representing the
>> SFP bus when we know we have such a bus.
> 
> I'm missing the big picture here.
> 
> Do we have three different things represented in the topology:
> 
> SFP bus-> SFP cage-> SFP module
> 
> 	Andrew

Ah by bad, this is a wording issue, this is the port for the cage indeed.

The model I ended-up with is to represent the SFP cage itself as a PHY
port, but I've been calling that the "sfp bus port" in the code so far :/

Let me try to summarize the phy_port usage, especially with SFP :


         phylink->sfp_bus_port (should be renamed sfp_cage_port)
          vacant = true
              |
              v
+-----+   +----------+
| MAC | - | SFP cage |
+-----+   +----------+


           phylink->sfp_bus_port, vacant = false
                |
                |             phylink->mod_port
                v                v
+-----+     +----------+     +------------+
| MAC | --- | SFP cage | --- | SFP Module |
+-----+     +----------+     +------------+


                    one of phydev->ports
                           v
+-----+     +-----+     +------+
| MAC | --- | PHY | --- | RJ45 |
+-----+     +-----+     +------+


                      one of phydev->ports
                             v
                          +------+
+-----+     +-----+   /-- | RJ45 |
| MAC | --- | PHY | -+    +------+
+-----+     |     | -+    +----------+
            +-----+   \-- | SFP Cage |
                          +----------+
                             ^
                      phydev->sfp_bus_port +
                   is also in phydev->ports
                     port->vacant = true


                      one of phydev->ports
                             v
                          +------+
+-----+     +-----+   /-- | RJ45 |         phydev->mod_port
| MAC | --- | PHY | -+    +------+              v
+-----+     |     | -+    +----------+     +------------+
            +-----+   \-- | SFP Cage | --- | SFP Module |
                          +----------+     +------------+
                             ^
                      phydev->sfp_bus_port +
                   is also in phydev->ports
                     port->vacant = false


I should probably add that at least in the cover. Does it clarify the
picture a little bit ?

Thanks a lot for the reviews :)

Maxime
