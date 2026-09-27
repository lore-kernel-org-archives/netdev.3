Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F77361DAB;
	Sun, 27 Sep 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790547604; cv=none; b=t5XjUQBUvE6nTenSDg10uK4EWrO6Qr6XyG4ter8+cwfmz8pSLy96OtWAmSik4plvT9P2sADse7+FMmb6yPzJLXATsjDKVw3Fxr7e3eX99ci/sBWMV4b0sDs2ONNdGsnAml6SHXlhhnvzcaU7+R+hYXZRV+38QrnhtcxrQOOOwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790547604; c=relaxed/simple;
	bh=EMF+WRoUUq1Mb2twuqRd96ARKYXb86GZA9XuOCi7bC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpmKA2i7tcaJ6dYpxNpCStSOQKpJw8MEXYfjBQWq/dFbniyHFHSs3e9148k+k09G6XAvQPfnO2KPobtAaUloWxb0S2jw+UCZnGiqccqDjXxYFiKhNR3ILP5ZIhfODWwbHj00uAHx79sycCu+yaAXvRjBZc4tBX/LDONAbZXjyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hipIpSoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hipIpSoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84EE1F000FF;
	Sun, 27 Sep 2026 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790547602;
	bh=308i+ynqxKiGdxe2Ownd10fFXxGBXHadKMPci0rGYLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hipIpSoCjJO/Gxnb3untPZTbfBc7Ohv2TWF70x1n4HM4124/KEgHZv2yOLxbLPF3k
	 pC4uodg2jo52DB3Z3De9d4GdZ1BbfaFrxYcFVtTy7tNjUan31acJ0EvMfG9rANmZT4
	 45ActnRL4ofZb1/RJ14JzBD5CteRslTTjDgvIb+0wu5hHiY5RfF7lN/6g5gw5unXw+
	 KlocbpIZHYFXNcFdcps8Tng4CP2Sao8goPn/HvYo6ySFU5LuMHJHh+lJ/nANRMLUfN
	 qlRR10XFhCjnhqEsoQTEWN+dqydd2ALKSiSoJ4Rv6MqmWLONUpz6YjBjHT6SkL1YQR
	 TgbjWzc/XtfCg==
Date: Sun, 27 Sep 2026 15:20:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous
 <jan.petrous@oss.nxp.com>, Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Jose.Abreu@synopsys.com, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v4 0/7] net: stmmac: More selftest-related fixes
Message-ID: <20260927152001.2e890f9b@kernel.org>
In-Reply-To: <20260925132204.03ce9495@kernel.org>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
	<20260921152202.64d4c67a@kernel.org>
	<f8fc89b7-15ff-4915-8f1c-49c3b2357699@bootlin.com>
	<20260925122202.611d655a@kernel.org>
	<d704ea9d-6cca-4f2f-b18b-0267a9082e18@bootlin.com>
	<20260925132204.03ce9495@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 13:22:04 -0700 Jakub Kicinski wrote:
> > > BTW - I see you have a thing called "netdev series report"
> > > I've been meaning to ask someone if they want us to add to SUIE
> > > subsystem tracking (https://netdev.bots.linux.dev/suie.html)
> > > I could easily add a drop down to filter just stmmac patches there.
> > > On the scale of 1 to 10 how useful would that be?    
> > 
> > I'd say, 10/10. To give you a very concrete example, I was on training
> > for the past 4 days, with little time to look at my inbox.
> > 
> > Today was a struggle to just browse through the stmmac pending
> > patches, some being straightforward patches, some complex but from
> > well-known contributors, some large glue series that are 10+ patches,
> > and then some likely AI-generated series sent as-is without real clarity
> > on whether the author actually fully grasps what's being sent.
> > 
> > So, I resorted to SUIE, ctrl-f stmmac, and going over that list in order...
> > 
> > I think you're asking this question at the best possible time, at least
> > for me :)  
> 
> Excellent, let me work on this over the weekend.

Added the per-MAINTAINERs entry filters under the funnel icon
(Note that you also have to enable the filter as a while with 
the checkbox at the top, or middle-click on the funnel to toggle)
