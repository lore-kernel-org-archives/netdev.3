Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77783E3D86;
	Fri, 25 Sep 2026 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366572; cv=none; b=FdsYCl+jjq9MQGuXCYZYOG6IK0nXgoPDtT1sZNeGyF4gNhbb31Ub1fIpXTc4a/2qbb3UWaYITE2Rp2CCQ3RIOFcMbdOtw9eRewEu9Pf2hb+DR88CWscCHE4OyqvodL5U/wNqIP/P9DkFwmw8f3lO8oVRPO4kT0HKJqZk6MoJ7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366572; c=relaxed/simple;
	bh=I87a+TgPwoFR/xesW1OS3yyO05m0/4fbwy3NLcAtNm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qn1napaNM6agB2v+rEOj5P1VHbKLSG2QoV3Q6hCqbli8T62vRcFH03st/Gs+I/kMG5TM99fBIqBqZ6zxWL3W8S75LHI5b3kMZeUt/53uU/rjwyAiP5Re+G3fSqc6dE/Ba5sK/IZozCTg6W8Wpm7ixCo5LK40CJC29QJ75sSx5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ftAqJu03; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ftAqJu03"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C98CB4E41076;
	Fri, 25 Sep 2026 20:02:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 896446073B;
	Fri, 25 Sep 2026 20:02:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24A9B102F1E35;
	Fri, 25 Sep 2026 22:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790366560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=I87a+TgPwoFR/xesW1OS3yyO05m0/4fbwy3NLcAtNm8=;
	b=ftAqJu03PKELrq/9DVzKPyaxyLEbv8nks7KxPKkhG6WIpbSLyHDyRc2riMwEi6JVOBt8nm
	YK8iwOQK31hgIIKb87uF2joMZID5OP2sQlwexE5QcoIEsSfnW7mwi3kj1ws4GlJ2URzOl6
	aTPgFsf7fXn2eYqnCs1hB9UB0YxVBqZIXwLRVNRLEAs9/J6Y96L8q4x82pte9mYoOf+OhV
	aQF/njcNUtOa2YnqeravxM1Udogx++NzjCT/64+PFKqwXp9UmjdNoA2PFd3VDGBryAELgz
	0SfuEl5j4GPQcxfsd5JQ5Axy5LmKX4X1MtkbhlNn9V3pVzP5jG0wHMX/itdfIw==
Message-ID: <d704ea9d-6cca-4f2f-b18b-0267a9082e18@bootlin.com>
Date: Fri, 25 Sep 2026 22:02:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/7] net: stmmac: More selftest-related fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 David Laight <david.laight.linux@gmail.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
 <20260921152202.64d4c67a@kernel.org>
 <f8fc89b7-15ff-4915-8f1c-49c3b2357699@bootlin.com>
 <20260925122202.611d655a@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260925122202.611d655a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/25/26 21:22, Jakub Kicinski wrote:

> BTW - I see you have a thing called "netdev series report"
> I've been meaning to ask someone if they want us to add to SUIE
> subsystem tracking (https://netdev.bots.linux.dev/suie.html)
> I could easily add a drop down to filter just stmmac patches there.
> On the scale of 1 to 10 how useful would that be?

I'd say, 10/10. To give you a very concrete example, I was on training
for the past 4 days, with little time to look at my inbox.

Today was a struggle to just browse through the stmmac pending
patches, some being straightforward patches, some complex but from
well-known contributors, some large glue series that are 10+ patches,
and then some likely AI-generated series sent as-is without real clarity
on whether the author actually fully grasps what's being sent.

So, I resorted to SUIE, ctrl-f stmmac, and going over that list in order...

I think you're asking this question at the best possible time, at least
for me :)

> Is there something beyond "active series" that you need to see?

All the info I'm interested in is already there I think :)

Maxime
