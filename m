Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893654;
	b=3OqgoicLDW5sdGcc2FN3Jgvk8nm1vKD3uUuWzu94eazQaLZMuLImZfQX9o73I1//BC+a
	 lyXQhGeevfCXi/J71sjTLBUCcbWQfDyRl3qgJFCXDs72MrsgbUyKK+pEXFxwIAOs7wHhv
	 qXo6zMyBUuPWlJIpfMIAPo096bgSnN6GNCsLkhxnntk1fku+y1fqTO38XzxHfVLM/l41N
	 HIjAikcaFuX3o+7HjIOPdUx+iTmDGqvjWj0vYiUAla0ftEIhGuEQV9dVp5MxQT1Oxik/C
	 l1gcwH0wHuzznECNavuLPne2vCyjZj3hZ5V2WXq8RZVrDW5ukV87u6iG1pOzKhIvJHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893654;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=uKgCwPx0XcVlKQatI7uQ08zv+nNRGJomiJbLaZj7TUg=;
	b=BdmU8K/Bt1Jn8bOKmCf0SgRHziH3cM/yd1mEgNFtQnVEqaz66/tgKin4OqrwLX7ckrA9
	 cyRZdy+0t0C0h8ncHhgQRq9HZTWtVMraQGbpvBdwbBVqHyK+kSIlthYoXX4iAg7kRtASD
	 V+ci4+Jx3E64XkAOjFADyj14/fZsS1Jz57lk9U8Z4SBALjvVSp8Pqwo4No4k2Q8oRPklj
	 na38dEnFt07DTa8nac6BPL9v96gwnCyGviHKvJqjWyQzBbBa1eHCBtHSkJ5nLljw97Bn1
	 mZeGyXkCTauRigusQq3+md11MUyH8Q7qX17KxofzCS7K08cDSa1svJ+Qh3+ZEYNbjdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ceyf4Xm5;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737B6082BFF;
	Thu,  5 Nov 2026 15:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B737B6082BFF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ceyf4Xm5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uKgCwPx0XcVlKQatI7uQ08zv+nNRGJomiJbLaZj7TUg=; b=Ceyf4Xm52NX4OwB72Ect2eiM7X
	1cEqc5wfLUp+UwbStmw7W94MMj2xX13JYiLLorkfN0fR+GhozHAGoPdi+DgbQ9OMRkg6JxXq4D7Ls
	EL8ryhx0XKBwFa7SNFMLfLXQ30fKrjmBG76UpjTsnfWNXeR6GFS1HfZvfr78O8vJkxKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOzgG-00EbAL-VP; Thu, 05 Nov 2026 16:47:12 +0100
Date: Thu, 5 Nov 2026 16:47:12 +0100
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
Subject: Re: [PATCH v5 4/7] net: stmmac: dwmac-meson8b: follow the generic
 RGMII delay rules on the T7
Message-ID: <f0925b45-26b2-4d79-9da7-e73a7a852efa@lunn.ch>
References: <20261103163715.385394-1-tanure@linux.com>
 <20261103163715.385394-5-tanure@linux.com>
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
In-Reply-To: <20261103163715.385394-5-tanure@linux.com>

On Tue, Nov 03, 2026 at 04:37:12PM +0000, Lucas Tanure wrote:
> The delay code reads phy-mode as the list of delays this glue has to
> add, falls back to a 2ns transmit delay when no property asks for one,
> and takes the vendor delay properties. ethernet-controller.yaml says
> the opposite: the PHY adds the 2ns delays, and the MAC properties only
> hold small fine tuning added on top. Every board in the tree depends on
> the old reading, so it stays as it is.
> 
> No T7 board uses this glue yet, so the T7 gets a path of its own that
> follows the generic rules: the receive delay line is fine tuning in
> 200ps steps, and the transmit side, a quarter-period phase step, offers
> none, so the transmit property is refused.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
