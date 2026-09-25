Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6119D074;
	Fri, 25 Sep 2026 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367728; cv=none; b=GBQF6jLd4NhHXVb3cp7c0b/n2zgWpYb4fQ+M7KCf033wBvSumi3+/csyJjSNW1y/QzT2Om9kUg6S9FSk839LCjY4304xAZr7fXFW71Fi05HP/XMlE1rvpglZoFbjML0zY4f2YiLiox/wifeLqZzIMqCzSWnZkJ/AcOoaOOdV+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367728; c=relaxed/simple;
	bh=ghCnQ9udedaHpuCB9EGJ6OkRUzXaMlrCsF2HILyFl2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiUyKb9cIT7HUzT6xRMx2HhHFClmf48Nheaxxfgr+8uexFhjvltlB5pRGnHnhDRW1oTsG0jefRQIU86zRFMC4XcQl66jkZbcD7bzLgn/47iQ1t6ZpEUuHUyVcI0hkfzx1hvBY/oMZkbWNDwW9GJDsoFlH0Mw2gUoQcJcaBfZNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMvASfwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMvASfwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912611F000FF;
	Fri, 25 Sep 2026 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367726;
	bh=RloHWNhcOY6jiXO7W98mGw5Z5KAg+PTBGMdz0OxO5xI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WMvASfwH8cTlHEs2kfQc6XOiEh8inJJzJPrnhrApPd+OJ/IrbE5ELpNNeSXGnAY8q
	 tAai8ITY8ZPO17UZ+XVXlIskorpSY6c8fWMUc0lW9AUVf5oyq/U3qyXm1r5k9Ra1Av
	 bj6nn4VaHwGmCPsr25kt2WrKgF/G8OT1nnFQa93xHy+1wYcsdcg7GDIa080zVeBcPF
	 6vC2gahk8/8FTrxlw8pz0yz7ecRJmPtUJhIxIVviDd74rpGLej1c4l1g/H5XgZN/wS
	 Tt8jFr9gT+AKbVIqEb7PuyJ66sxdiZj2d4ph+IbmckjnozQ3rZ03LctHkZ7jSmYEnR
	 TaFnt5YFgrAgg==
Date: Fri, 25 Sep 2026 13:22:04 -0700
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
Message-ID: <20260925132204.03ce9495@kernel.org>
In-Reply-To: <d704ea9d-6cca-4f2f-b18b-0267a9082e18@bootlin.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
	<20260921152202.64d4c67a@kernel.org>
	<f8fc89b7-15ff-4915-8f1c-49c3b2357699@bootlin.com>
	<20260925122202.611d655a@kernel.org>
	<d704ea9d-6cca-4f2f-b18b-0267a9082e18@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 22:02:25 +0200 Maxime Chevallier wrote:
> On 9/25/26 21:22, Jakub Kicinski wrote:
> 
> > BTW - I see you have a thing called "netdev series report"
> > I've been meaning to ask someone if they want us to add to SUIE
> > subsystem tracking (https://netdev.bots.linux.dev/suie.html)
> > I could easily add a drop down to filter just stmmac patches there.
> > On the scale of 1 to 10 how useful would that be?  
> 
> I'd say, 10/10. To give you a very concrete example, I was on training
> for the past 4 days, with little time to look at my inbox.
> 
> Today was a struggle to just browse through the stmmac pending
> patches, some being straightforward patches, some complex but from
> well-known contributors, some large glue series that are 10+ patches,
> and then some likely AI-generated series sent as-is without real clarity
> on whether the author actually fully grasps what's being sent.
> 
> So, I resorted to SUIE, ctrl-f stmmac, and going over that list in order...
> 
> I think you're asking this question at the best possible time, at least
> for me :)

Excellent, let me work on this over the weekend.
