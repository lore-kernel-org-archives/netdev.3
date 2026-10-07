Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BC471CFE;
	Wed,  7 Oct 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378776; cv=none; b=m//9peBUhK9u+lP6fRF7R+BIjvbY0H0v6nkuH68WI1C/cA+6iIO0wCC9srOBduoceIQHMDPXiOyQzlSjxvEzkBYYK+j6FF3DwV0aMkLbjAaTd7SQdUz9nmGsXdNsn1UFhH+wFePTcZQEERuPXm+1HLlEWOC0JfKktcZJ315pEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378776; c=relaxed/simple;
	bh=PiceYSJREFaFsXqOSoQMQNyJznx/Y9V3H1mR5oLVKJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvDdW12+eWsQ86jnx5G6Z9VwTUtNzNIyASqmFdPtIt36PF4JPoRtanWKzTqH51EAaxheAt+5DV7Bx7Pt2NhszibLGJJidkcNC5vipn3MDca1wWpxqu17RCnx7/EzN42iG6XYgXE/mbdEVqHjRO3KdzsJCPbZb89px4LLET25GXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EGjnEmdN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EGjnEmdN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ODCTZAb7yCutEAg61KAN127W0Xr4Uf0HpQFO8eWY668=; b=EGjnEmdNwKR/iAlHfjQRl3D4w6
	2P/GYhl77uLT3erz810QPl4qjUPMgpF94TcGVojUJDsMV3NI41WuvWZShnxo/ZVbriNUdhwTjEZ3H
	e7IMpCOXb6qXzJaP21s/6O/CdOMw0qVrireAA9PMhUNSqYBGwWneJ/ffwtYRDwMo7zn0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xERRg-009SjM-M0; Wed, 07 Oct 2026 15:12:32 +0200
Date: Wed, 7 Oct 2026 15:12:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 6/7] arm64: dts: amlogic: t7: add the ethernet
 controller
Message-ID: <c1764303-9f18-4487-ba93-06173cd8a53f@lunn.ch>
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-7-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007082627.63807-7-tanure@linux.com>

On Wed, Oct 07, 2026 at 09:26:26AM +0100, Lucas Tanure wrote:
> The SoC has a Synopsys gigabit MAC, a block of glue registers that
> selects the interface type and trims the clock timing, and a
> multiplexer that points the management bus at the on-chip 100M PHY


> +					internal_ephy: ethernet-phy@8 {
> +						compatible = "ethernet-phy-id0180.3301",
> +							     "ethernet-phy-ieee802.3-c22";
> +						interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
> +						reg = <8>;
> +						max-speed = <100>;

It is a 100M PHY. What supported speeds does it report in its
registers?

You should only need max-speed when the PHY is broken, says it can do
more than it actually can do, or when a 1G PHY only has two of the
four pairs connected to the outside world etc.

	Andrew
