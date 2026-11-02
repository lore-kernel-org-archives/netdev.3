Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582768;
	b=rxi7U1o2EGodNmMYhn2AQJEv1SOXqGbNYZLOiJK/PakZQjPnzHlT1BYSZHzrnB3465Ee
	 cqcOGCJg/JpY/ByZ8MqRh6f2IXDW7KhwetxTRoF671nIiTVx7J2IhcjO/keB8K4hyWcab
	 eRdnB4VCRp0yYS5rXb3sTXmGVC4cTVwp0Ir0iDzZ7fujQqa/87iuZkqcjTIaGOM7CCmM5
	 hJtT5xFz7FXcQ++4MSv4A1FSEEpt2uZJESw9H3RNDHRRspZGsBEnIFcsdw5agtfHV8VYX
	 TexZFvNiVSV6w4pY70ytREQSraqdBLkFyjaXtPKM8Uthrp/mxLfZ7+juFK3NlGkt57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582768;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zzCU2zkthIhynh/pGZOVADh4w3xaW1IuAwNsbHBIwe0=;
	b=xj/mgOu/fkrZ+viygK3bcUV9QatRCRHmc2cFId/jFko6Hq1Pk5SbGG0cO2nc84xwj63r
	 c32J3iHPEo76BKgVoQyiXFNhVE3q/9LB8cDKq7HZaDYvxaCedWFNasW+jOpWXdzP4mbtd
	 BxVDqQKKcADEE65P3gb3WrY73CPRovruJU33Jx2szeWJMPpaTjATnqbQLlImTnRqsSt1A
	 Dmu1HGXDYlcEvxQAI45y3UO7UcvWfUa9hQmZI2SQkL/jJmFDsHOgrJaKKbcvc82+rEKqD
	 KyERkICjXnAg31Oh1AOgrpvKfA5m1YZIDN6tHUnUi+EBs1d1K5iV8CK9PTdJyUAJPrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hWW8bLso;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84A606A324;
	Mon,  2 Nov 2026 01:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E84A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hWW8bLso
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zzCU2zkthIhynh/pGZOVADh4w3xaW1IuAwNsbHBIwe0=; b=hWW8bLsomnVzGKHciWTUasclCf
	8tmij0rf9vle4WJmwrKBGRVLJEfPlPE3MvYaFpK0jK4y3Tw9p7hXOGoaWPTSZFHq0TTrSgmdOBInF
	huHicLfIk5HSbl7mXDafx5b2aEcPLZnPtJt9IPhYJhEDi+miOklAFfHAc0Tt1MU8O0Hc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNgo6-00DiZC-2x; Mon, 02 Nov 2026 02:25:54 +0100
Date: Mon, 2 Nov 2026 02:25:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
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
Subject: Re: [PATCH v4 4/7] net: stmmac: dwmac-meson8b: follow the generic
 RGMII delay rules on the T7
Message-ID: <ce7d357b-8990-49bb-94c5-5491496f3ba8@lunn.ch>
References: <20261022200640.3101932-1-tanure@linux.com>
 <20261022200640.3101932-5-tanure@linux.com>
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
In-Reply-To: <20261022200640.3101932-5-tanure@linux.com>

> +/*
> + * Delay handling of the SoCs up to the G12A. It reads phy-mode as the
> + * list of delays this glue has to add, falls back to a 2ns TX delay and
> + * takes the vendor delay properties, all of which ethernet-controller.yaml
> + * rules out. The boards in the tree depend on it, so it stays, but a new
> + * SoC must not use it.
> + */
>  static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
>  {
>  	u32 tx_dly_config, rx_adj_config, cfg_rxclk_dly, delay_config;
> +	struct device_node *np = dwmac->dev->of_node;
> +	u32 tx_delay_ns, rx_delay_ps = 0;
>  	int ret;

Does this code need to change?

It would be better if you did not need to change the old code, so you
don't need to worry about breaking other SoCs. Just don't call it for
the T7, use you new function in its place.

	Andrew
