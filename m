Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E04562B0;
	Wed, 30 Sep 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773783; cv=none; b=dp63O/BVf09wBmv9Pouu6LPyLoxT/jQY5aeEtAGBBQa2XBh9VTdJR9Nwvdb7Awr+f3BfmBryrhNK2m5iGqLpGV6M6uXtzxDyf9g13UWjO6UPoGDm8Mev2aI77JBTQriDULz0W4msG4qEJfxmICsPfjMoyl0v8OBDOrhp163c6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773783; c=relaxed/simple;
	bh=ll2LPvIKpEkwZ77h4B19yw/2rk8FFkU9LL8yKpswNyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrfPqHDb4bZhE2VUo02mtGXM+R9JftL4Tov/QzPp44rr4sMT//tpyNQ8J7ddK7ReyHqed3/uC/X0SapqvZgZvVoM0prA0+tg75Fm3AEBxhfx5uNxO71UBXfF53xuLpAg5eJSeggI0CW12CbJP+3EJe6t5OhckdDRZFL1neKt0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rllCC+fK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rllCC+fK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AF7E21A1074;
	Wed, 30 Sep 2026 13:09:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7FA1560749;
	Wed, 30 Sep 2026 13:09:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8685110328C6D;
	Wed, 30 Sep 2026 15:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790773760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LclRS6GiAqzpJ+OFOtJcaTT8MvnLFW6hByRdlzKJ/3c=;
	b=rllCC+fKRbDgQq4uVuZXlMEAXyLuvu58maz0mxCqZe38hn+XDf60Ke0NqIwvp43VWXttdQ
	HnVr47dtfsVdu+uN0q+/LkrSY0cRKkdzR7tZd2NrRyj0YZZOnjxX5/3mJTITUee24WHKNl
	8y6MA7a9uN2IgKaT7e4J3qZblrB2G9fW+psPO6fPvlIezIjZeFN1EOCGcO6I5LC4kfrFNi
	wFGGR3jLpCC1DuXBFwpBra8nanmowfMmLeRr0yZFJiVQFXV+20syWN8EDaPHlMndO425FX
	9w1Nn1vp9GuPlkKTP1IlkEXFMTKOYT0MgTlm8WoxqId9/gtyA8BKAz53m0dGJg==
Message-ID: <4115d11a-20bd-4d8b-91db-a995b69dc989@bootlin.com>
Date: Wed, 30 Sep 2026 15:09:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 07/10] net: phy: phy_link_topology: Add a
 helper to retrieve ports
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la
References: <20260927133619.955236-8-maxime.chevallier@bootlin.com>
 <179064232141.3145.9140453636997333793@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <179064232141.3145.9140453636997333793@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/29/26 02:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 

> 
> [Severity: High]
> No reference is taken on the returned port. The only thing keeping it
> alive is RTNL, and ASSERT_RTNL() only warns. The commit message states the
> rule as "the caller must hold rtnl until it's done with it".
> 
> Do all the paths that erase and free ports hold RTNL?

Nope, but really this isn't that simple, unbinding a MAC/HY with an SFP
module that itself has a PHY isn't straightforward, we deadlock if we
grab rtnl as the SFP cleanup path also acquires it.

unbinding is a blind spot for the PHY-in-SFP case it would make sense to address
that as a separate work :(

Maxime



