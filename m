Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEC331ED0;
	Thu,  1 Oct 2026 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837853; cv=none; b=QrFUeDJSSDayfWJ3dQPrQq/sF5LLljIh0htPJfdHCflwFNrKqtCHQx3HiJlMFXYCOpt1DsrZUIBlfc3tiFTVa4Ad06SAUkMo3hXFtELKeXWlIMpQf2uf9eJ1dbe2SORWf8qMiUgrTKTTb6uIQOzEV6AuVC7lupyNObS1BQgLrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837853; c=relaxed/simple;
	bh=v2DNtaU4Ytuy/NTTd1GI+VTG8VXVYDvJxpo5g6xE6Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZg90JvPhSD5AnxY/GRBLf/WraMay8BSu1a0T4YVXKrROibg/lHSfP+g1Px0b+M07V3jyHaBVJWTm4jtxqwW4jPecYtcgjtvRNIvNGKfH5Fw8zlhUzdLh2rjJ5r0tqUq8CzCc4IIM9yUofVZOdO2BD7G57fB5pO730sS7PlH1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=siqqtFYF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="siqqtFYF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7C3D01A1099;
	Thu,  1 Oct 2026 06:57:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48E8F60341;
	Thu,  1 Oct 2026 06:57:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E313B103290E8;
	Thu,  1 Oct 2026 08:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790837847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=07N0PHQU4LwZUH80/tjJ8cgNHIHJP97XyXQaOg5pfN4=;
	b=siqqtFYFl6CbtJ6Semf57D9diifiMZhx4tSlwfY93tG5GWuKsklnmnUELjOTZss+2tHvb5
	h2UAjA9x+HOsE9kkhldzRX7e2eSW/nDq2yI4AIG/4qyBJCHiyLNYDcOJPm11efqjFN8hQ5
	UjRQAY8DSt/nXli/hsZowN+wjJ+aDeSAhvG0hEXAD4dqz618SOoYK47/cb8WNKUvBWpOfi
	z8+bfaUWFztlA/u2BNwvVUJoAalIZ7BaqXRGwF77dvZSsdbB+o/B44L4ZnQkdC9/1o4vco
	CQH6PVTwCzhqpvVGp251CHCsEstcXb5y9EggAz0YSIb6dHc2Mzad3rELBiiNAw==
Message-ID: <04bc6323-273a-4536-a862-9ba363bc444c@bootlin.com>
Date: Thu, 1 Oct 2026 08:57:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 00/10] net: phy_port: SFP modules
 representation and phy_port listing
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
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
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
 <20260930155600.3b18c7c7@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260930155600.3b18c7c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/1/26 00:56, Jakub Kicinski wrote:
> On Sun, 27 Sep 2026 15:36:09 +0200 Maxime Chevallier wrote:
>> What this series doesn't do :
>>  - We don't support selecting which port is active. This is the next step.
>>  - We only support PHY-driven combo ports. The end-goal of this whole
>>    journey that started with phy_link_topology is to get support for MII
>>    muxes, such as the one we have on the Turris Omnia. This will eventually
>>    be upstreamed as well.
> 
> Any plans for representing a few "complex but expected to work" cases
> with netdevsim? Or are you thinking of trying to cover this with NIPA
> HW tests?

I have the PHY netdevsim series I can fairly easily rebase, and for port
it would be IMO a good idea especially for muxes.

Devices with a MII mux are not extremely common, I have a few of'em but
having the switchover code in netdevsim would help a lot with the coverage.

So I can add netdevsim yeah :)

Maxime
