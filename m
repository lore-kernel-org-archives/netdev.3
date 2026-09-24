Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B81D8E01;
	Thu, 24 Sep 2026 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254474; cv=none; b=D4+pWAuwENtvIyzpuK0oRYnIguKFmRdMULawyud4+jsuqyS5MWRcCw7bX30VumOXlX82FOpdgWQEaaCT9tQcFmWSltJN2pxrrj4E91z/egH7CydU/T9P/L7+5Lvfsu8DaxORcvnh9Z8AgI3ElPtNX6l7CKN01SyRUT1nFvaJnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254474; c=relaxed/simple;
	bh=Ut9VAd+CTmuWwGEHuUzGDBErDOEmqc5PAolSzbTNfbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFW0l1DVx+JWET+yKaqIikAJsPdeu03lLoDeCJf/I0Kv56JZqnJ404JfqCsIbYjJmNtiOWa+GVOzQDvHNbNSldnJJNcWZQpr+dcu26FzxvajVz4emH26ikvyKkaNBtjtEfuNZ8iAUAyBLnESKmXtcnotn+c6nENUfJ0S247x71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ORH9DIUB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ORH9DIUB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V/WZw9rLkA8GgKGtwNNWTWSV66Yxdcd2UG4mDpKAM0U=; b=ORH9DIUBwALlitNdRlOCOfiq2n
	PqekiHAmB+WJkW8o0RXVvZlpTiO6YWlB9pAodNUiqUPahzAw6+uJr/xShYzU5ZopAMzxFmBV6OXKW
	/V/Id+2JYL2IQTMdlaaOlfLSh1DTwlYcTLRVJd79ScgSCQRil90tDTb3YZnzo0dfjbPo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9ixt-006zeO-5j; Thu, 24 Sep 2026 14:54:17 +0200
Date: Thu, 24 Sep 2026 14:54:17 +0200
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
Message-ID: <5fae3b42-552a-458a-9710-927360e58c37@lunn.ch>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
 <9cc61625-47c9-4bdf-97f0-0528f661a399@lunn.ch>
 <1j7bkb9h5k.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1j7bkb9h5k.fsf@starbuckisacylon.baylibre.com>

> I've changed the phy-mode to plain rgmii which seems more in line with
> what the PHY actually does.

No, it is much messier than that.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

rgmii-id is very likely to be correct, if you were using a sane PHY.

But this PHY is going to cause you lots of problems.

    Andrew

