Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100A410D13;
	Wed, 23 Sep 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202007; cv=none; b=OLvft5UXO4/WwVmGO/d3zunJ02XvlIZS0dSPgrxtjJOYhMvLpLJLYfyM2mxDsqSy0jtYkvgkkB7WLEVT26jOMD9bFhEWrx819wnmfwUv71pH7W3owwu//LLM1t4gUPSvKmQERYAXN13LB2bklyeiX22qmgoft5mv1GlulcJb8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202007; c=relaxed/simple;
	bh=052+S21nULlpvbLS5JXY/wmkVp7OavARQS40hzPiyuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVfl38JXch4cDkKEoCIFet2+ApY/w1ORcEn2/4pe+ZhnZXl9dfPi0MgS3GR4yI5oRCyJ7VrL5NL44WFvr+HjGQ/Zf0PL9/4/DWpocBP7DVumPrk9RJBpG6i2PP2wh/BbeppMtLAY2bVzg+P+p+IyExYSWcts1wLH9irXwgbkGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v4aY/kP1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v4aY/kP1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/r/VPJN9CDJhmNdhWRSdElLGuVctjxCds5gWyL7ngvI=; b=v4aY/kP1g/K3rv2M6AttWFUwC1
	QPL6uHHZzQfOPCaxq40B+3gHZk9qsKy4onEhXz9XaXFX6fMxVBY+TJP+fxTspSsdFC6aiFaYRKW3A
	6L6rN0hvI1uwQUkckiYYiAdUm76arbf3HxmCd8nAGlV3/t+Osq7K+3iTYAz9EmhW1XUE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9VJg-006ss1-5p; Thu, 24 Sep 2026 00:19:52 +0200
Date: Thu, 24 Sep 2026 00:19:52 +0200
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
Message-ID: <9cc61625-47c9-4bdf-97f0-0528f661a399@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>

>  * Unstable EEE/LPI: If the device stays in LPI mode long enough, the
>    link sometimes (but not always) goes down, coming back up when the
>    device exits LPI mode. This is apparently due to the PHY; the vendor
>    driver disables this feature. The solution is to use genphy with the
>    eee-broken-* DT properties or wait for the upcoming mainline driver:
>    https://lore.kernel.org/all/MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com

Looking at this code, it totally ignores the interface mode. So you
have no idea what RGMII delays it is adding. When this driver gets
fixed before being merged, your DT fragment will likely break.

       Andrew
