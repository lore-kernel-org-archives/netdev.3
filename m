Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415624F68D8;
	Tue, 29 Sep 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698263; cv=none; b=Er8RkGHtt4DbNlB2K41DEAmILU9YgQO7jXY5QaMJjJXXRIuKOmW1nrPoclSNdWkKuk4R8H7gse/zRI3kOA/6wm/qzpGoDQmgjRnRGG5GuR53GyJ3rtBR5ChIMQ2i0eOUNrLqr2kJQ0G9HIrGTEqMvo2OEELXF+rvmY7VyADIKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698263; c=relaxed/simple;
	bh=84nDE9fBkBoKW9uNwTHmAnfF3kvZuT4RsbrntzXBEKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGFWS/0Jbm+FSJGVeVm2XeHGD9ubsJQfgObFrEI59E9J7UnLefkxrikLD1SqsLms/duUcnpkQbS8T3szXuBYlUuQp7x3Eb6fbmzEm4zNFFghvdE9Xq58CPhdq5AnSaS3g7eH/cI2U8Na7SiDM4lJTf+5BNUi6pxRqErbLOU6z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3+zr4eic; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3+zr4eic"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wSDpv1cK4ROYQ8y4HkuXiu+aWSa+g6zObCto20zUYas=; b=3+zr4eicpBhwbJf1E88FQ1yQj6
	vzpIVLyibo4vAI9bUfs/vIXeJt9eS8xMCmNB787frZMILX7i7xihJAwugT6bm6twt5NLalJ2/s+In
	0J+aCSII/4YVrHH0XV6YrpKPuqTqHQB1NhdI5RAsOPYefMf6VTfOtaaf8N/9u67B6Fow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBaPd-007yxK-4d; Tue, 29 Sep 2026 18:10:37 +0200
Date: Tue, 29 Sep 2026 18:10:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v3 0/5] net: stmmac: Add support for Allwinner
 A733 GMAC210
Message-ID: <93870bce-b18e-4eed-a9ca-1d01313c61a7@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
 <9cc61625-47c9-4bdf-97f0-0528f661a399@lunn.ch>
 <1j7bkb9h5k.fsf@starbuckisacylon.baylibre.com>
 <5fae3b42-552a-458a-9710-927360e58c37@lunn.ch>
 <1jv77u8yak.fsf@starbuckisacylon.baylibre.com>
 <491f043e-6dc6-4936-a490-31a3362c5b6e@lunn.ch>
 <1jse2x91oh.fsf@starbuckisacylon.baylibre.com>
 <b41e7fe4-2ec8-428e-81ff-47e1c75003b1@lunn.ch>
 <1jecec3xnd.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jecec3xnd.fsf@starbuckisacylon.baylibre.com>

> Thanks for the heads up. So if I'm reading the doc correctly the PHY
> adds 2ns
>  * on RX if there a 4.7k pull-up on RXD0
>  * on TX if there a 4.7k pull-up on RXD1
> 
> The schematics for the board are available here [1]
> 
> * 4.7k pull-up on RXD0: so we should have 2ns Rx from the PHY
> * 4.7k pull-down on RXD1: no idea what this does. Presumably no delay ?
> 
> I've cross-checked the HW, the resistors are actually fitted as the
> schematic says they are.
> 
> With the HW setup, the MAC setup that works for me remains
> 
> 	tx-internal-delay-ps = <1620>;
> 	rx-internal-delay-ps = <1800>;

These values suggests there are delays on both Rx an Tx.

> 
> I know it is not aligned with what it expected but still.

I'm flexible, if in the end this is what is required, that is fine. It
will need a comment explaining why it is needed, why the guidelines
are not being followed.

Where i have real problems is with developers who don't respect what
the guidelines say, even when their hardware could do what is
asked. They just do the minimum to make it work, and call it done.

The comment is then important, because i don't want developers using
this as an excuse not to do the correct thing.

     Andrew
