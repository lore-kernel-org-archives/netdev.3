Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE83F4DC1;
	Tue,  7 Jul 2026 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428191; cv=none; b=N+VvJMJR0gesR8q3wAJh8oTEn+WKvieBn1LAFVOWTOGTKvaO2wru3mFa9D8e9O51/DqYRACqG8QmHyo8T9VCeJyKXCG034dzGZDpZg+lB3zaYusftKQloqnO8GEPGL8ofnA+MmJv3tWVw1lND90FTa7o0ieMi7t0h1VrR5VKjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428191; c=relaxed/simple;
	bh=spjdZUxyFc6sRcTtWGbYVwY5Vvl7/q1NRDmjtMtiiZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOWkLR5ERAhX4JlxapFGyTXt7S9RrWU0khoOzWzvu9g0ZLReacvU3LKNb1hYa9JCLH5sNZhRiwCF67/6I9WnoZBMHZpY2T0KDvrYdegrHC5O6no4w4pHAcW0BKsDj27zb7KlFDGWpq5IWmOCbH8ItqsN8jPXwpqQL0ze/sYxEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xNDKmKLF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xNDKmKLF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WGnoM0RyzV43Ghs+593I0p51zAgB7jugq7icsoB0chY=; b=xNDKmKLFkXiDfSxJf42Y4VuQ/H
	iY+XPbQPA+WTT2gt1DBe+ndWSah2pwzWw/48J+/MjYBlMrvn+qamvRT2EPSZPHWNUM6y1uELHYTKC
	tr4NlHmGMudpIDbYttbTlcC1757lpNT5KOlwf6See3A1E56VGaR0ZRimxDoMGhUjfrlQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh58a-00BA3I-EW; Tue, 07 Jul 2026 14:42:56 +0200
Date: Tue, 7 Jul 2026 14:42:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/6] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
Message-ID: <b810b9cd-8f5e-4c9d-8496-908aae55dac1@lunn.ch>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
 <20260707-dwmac-mediatek-mt8189-v1-1-17f345eaaca3@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-dwmac-mediatek-mt8189-v1-1-17f345eaaca3@collabora.com>

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8189-gmac
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: MAC Main clock
> +            - description: PTP clock
> +            - description: RMII reference clock provided by MAC

Since this is a MAC, it sounds like it is consuming its own clock?

	Andrew
