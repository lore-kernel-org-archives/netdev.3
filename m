Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17829992A;
	Tue, 23 Jun 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232482; cv=none; b=cjknsJVOO4b431nEkAE3iF1oRJfYQN1t1XjNc4+6NHa3BCJSiPPLnxsRb0W5MT1Y4kd/QGBynDGBIXMse7IgGFHnL7kzGAoS631ifBqJGxtRTwiJthc+NBsDIpAgHrxz5uNlhi5uHSLkpfEQzBT09/3Tc/ZPQo1BmVC9y6ebe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232482; c=relaxed/simple;
	bh=Q7C2WLq+w3wseZRK2d2WjJK33bsL447mI7ejl55BvK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgxbdKZtBBhY11zEI/nsKCzmIMwOwRIYsP91YyrCpF85T0MZVLIwZ/NCM6xcOlrOfLy0EhFz8/TL1ayiOinICJ/M1qsMQOeqGXUwkSYCEvQ3DbamOCKaSJXwJouYrBRjqDCtDcr1Eg5Hx1AcF+gGd7hOe4ZPW1JlfIAFEWD3WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PwsCCeSx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PwsCCeSx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A0DA51A08AE;
	Tue, 23 Jun 2026 16:34:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F793601C2;
	Tue, 23 Jun 2026 16:34:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85E0A106C8382;
	Tue, 23 Jun 2026 18:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782232477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2wrqOjRzMhTb93M3exBJA5foYnr34jfu7Zmsb7q95s4=;
	b=PwsCCeSxTkhSaGoTDg4xMxOoL2zk6ED1MVfvwyPJwRYk5o/tBKr9xwp0bp3tVAV+1jWQFx
	aXOFvygrE8H0EM9WRUdBcMhbSGm5hdjaRUlOF4YjdOBWMz7ruzOkAzqJZq+GSinJ0PHaZS
	OIvOUOReO5w6MMQYLlYlmJiiF6wmd+BoxMc33zS7hYx/XqLHFTnwqI+GspefyRnGHr+p/N
	hi36FB6nBMSnCDhwtkRiwqd5l44Pf0use01uJ9BgFF5cek9TkqE/RIy9ywPS072cIjLgoM
	7JDhtOCvX+1BDNMuow4M5LA+oaq6a1O23DTc0O20HQMNJmTcvTSGYPgmgT4Omg==
Message-ID: <6738bbb7-63ed-4c65-a0df-f5f9514fcde0@bootlin.com>
Date: Tue, 23 Jun 2026 18:34:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] net: phy: sfp/mdio-i2c: defer RollBall
 probe + fix mii_bus leak
To: Petr Wozniak <petr.wozniak@gmail.com>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, bjorn@mork.no, olek2@wp.pl, kabel@kernel.org
References: <20260623080538.7646-1-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260623080538.7646-1-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Petr,

On 6/23/26 10:05, Petr Wozniak wrote:
> This series resends the RollBall bridge probe deferral (a fix for the
> regression in commit 8fe125892f40) and adds a related mii_bus leak fix.

These are bugfixes, you need to target the 'net' tree as explained here :

https://docs.kernel.org/process/maintainer-netdev.html

Thanks :)

Maxime
> 
> Patch 1 fixes a pre-existing mii_bus leak in sfp_i2c_mdiobus_destroy()
> that has been present since the helper was introduced in 2022. Patch 2's
> new -ENODEV path destroys the MDIO bus via sfp_i2c_mdiobus_destroy(), so
> patch 1 is a prerequisite to avoid leaking the bus on that path.
> 
> The v2 deferral patch was corrupted in transit and failed to apply; it is
> regenerated here against current net-next with no functional change.
> 
> v3:
>  - Resend: v2 defer patch was corrupted in transit and failed to apply
>    (netdev/apply); regenerated against current net-next.
>  - Fixed block comment style flagged by checkpatch. No functional change.
>  - Added patch 1/2 (sfp: free mii_bus in sfp_i2c_mdiobus_destroy).
> v2 (defer):
>  - Generalized scope: regression affects boot-inserted and hotplugged
>    modules where bridge init exceeds 200 ms; Aleksander Bajkowski
>    confirmed FLYPRO SFP-10GT-CS-30M / AQR113C broken when hotplugged.
>  - Corrected state machine description (probe runs in SFP_S_INIT after
>    SFP_S_WAIT) - Jan Hoffmann.
>  - No code changes from v1.
> v1: initial submission.
> 
> Petr Wozniak (2):
>   net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
>   net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
> 
>  drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
>  drivers/net/phy/sfp.c         | 23 ++++++++++++++---------
>  include/linux/mdio/mdio-i2c.h |  1 +
>  3 files changed, 24 insertions(+), 15 deletions(-)
> 
> 
> base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4

