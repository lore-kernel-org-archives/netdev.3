Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602915;
	b=gmQhJpEJrj70FccE2Egn2DojPkzXERSz5x6zNoHcu57w9xqUgsewJQIKXm3CU6MiZgsE
	 dvPiwZTV4o/0EdpAWJdGhfW+h3WSkQSR3K0l+/606gH4yDpqCXqrvWGhMPZrh8PRiiLag
	 026/MLt5BQDOtXl4XJPH0rOSAvzUvADN5nsY1+FzevVsDZzu/ko3LSfXr5Slh7ENVQBld
	 PUqYDuQ6QV9qHqtvS/V8DZebqK+kh9L+yOgwS1NST/JQlBC3a0gc+uUSK4E2IIAvBvvl5
	 oaCjJ0P1jblZ9SGx2DI0FIo91B8T0YyGF1LOJn7PzwxnapAde3U47bHzSzMAvutnZZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602915;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/Ktn3E20uyErc4L/7IYjC7izDZZdI2uwat4zTaX+wOI=;
	b=pvzkJfBuo4J6uBtB0Q69EvGH0mrbLWSchdp2vfM6xXszu9DYhWEHaQAL0nPCqhXeiu8O
	 7FYEhcAWUvDXq1epWXeU9l4UNrcKWhkl2UtnYQL2rTPeHxYIf3sIJElV8GBbaNO57taiM
	 OZ2N1FlARgX5hus9An0ipOfFmrvPu0T4vjR3/e7Dd//DPpnOeGXnY3XjXsLfC+YPECUmi
	 pilbT70Y4v17QEedGa8P5k/s7pYQDf+xzZoikjq3xCS+NkFJwMTqVlAkUCBXXdo0UjfZZ
	 OIEy5hzwbAkiMybQRbBKRNYRfHK9qxeXLeZFk13tC+8y1EqjJnm4qAXSdmOB1X2nJVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fPpm7z8e;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840F606A33A;
	Fri, 13 Nov 2026 20:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0840F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fPpm7z8e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Ktn3E20uyErc4L/7IYjC7izDZZdI2uwat4zTaX+wOI=; b=fPpm7z8eZEPGwBxfGOC2TEjOnF
	kA8xLUy/kTF7tMOzsMFXeDU/1hPQ79YR5NBN+RwZgm3KJDbzOSloDeqwYcyPMHU+FU+iE4o69CdQk
	/I9Oqq6V1WsHm4DQNvubF5r8cNHvGFK9EQvfyvxSuhz87pUfglPSuD1G6HzFeNInUfRY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRyCB-00GMVK-MP; Fri, 13 Nov 2026 21:48:27 +0100
Date: Fri, 13 Nov 2026 21:48:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, mfd@lists.linux.dev,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v4 4/8] dt-bindings: mfd: Add SoC-e SWIP parent
Message-ID: <e4417d39-390d-4ece-bb2d-5f1745185d37@lunn.ch>
References: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
 <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>
 <20261106-judicious-penguin-of-enhancement-b28c8b@quoll>
 <f5c7c9901aca84f0b814e5b6c153db84af826dd7.camel@linutronix.de>
 <cc35b2127b04772f05948ac51c8faa5ef07da0b0.camel@linutronix.de>
 <20261110192118.GA1412882-robh@kernel.org>
 <5a6183e3480a0d910e275acf591e2db8700da827.camel@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6183e3480a0d910e275acf591e2db8700da827.camel@linutronix.de>

> > Given the MDIO bus and mux registers are adjacent, I don't know that 
> > putting the mux into its own node and driver really buys you anything. 
> > Can't your MDIO driver handle the muxing directly? mdio-mux-mmioreg was 
> > created for when you have mux registers in some completely unrelated 
> > block.
> > 
> 
> What it buys me is less custom code to maintain for bus selection and
> selector-value validation.
> 
> The MDIO controller and mux were combined in a previous version.
> Following Andrew's suggestion [1], I moved the controller into its own
> driver and stacked mdio-mux-mmioreg on top of it.
> Sure, the selector is part of the same MDIO control register. But the
> generic driver already provides the masked register update and
> selector-value checks. My preference is to keep the current approach
> to reuse existing code, even if it requires some integration and
> documentation efforts.

Since you have both implementations. Did the lines of code go down
when you reused the existing mux?

> The IP core can also include an I2C master for accessing external
> devices as a synthesis option.

SFP cage being the obvious thing.

It will need to be a Linux I2C master in order that phylink can use
it. And i would not be too surprised if the existing I2C drivers can
drive it, it will be licensed IP. So an MFD will make it easier to
instantiate.

	Andrew
