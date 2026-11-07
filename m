Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071749;
	b=pWNbnCwZklWtTGXqnviWRc6eF5Tc2RjmR4b5SBPajkHRq42+QhrRxru0k34HVC9VfXsZ
	 f4pX5ewSegrBmP0Q+TF8NUxAayIGmA/j3VJox0T1J/+vCE0ZfaWFrX7+rtAZRihWBtcIX
	 0nVI3ymY2NzbRFBf4nu6fp2/xMYKnsB4olYPPbEmVkrcSjQ6T2C1Il7AplCPvNuB+xMiZ
	 z+eViQ1T2YdHE6gs8u/wQXHDt4yqtqh3U15TFkhZTtWdRMP0YyK46Eh9xxefLNBWyS7+n
	 K9xRax2wSL4XR+C8xUYW7YX3XVA30WMF6FvCon7g7gkuOz3Hm6ssMf+bQfTaKxxtoKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071749;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xebWBu8uxtMVzUBXpbfkcUM2BjPmTJhv+4Pcphjd6Xs=;
	b=zcipvoZqhW6U0pnwoSmjAoLxJ3zLLKnVESc+T2eXkJph8R1oAPZ+4Qklf4rbJSH9yWhl
	 WjwYO3ib8Yo5uiNtvQold6QRvAP9H2zETNqwnigUM9WuQrFJYuYGCQIN7eifAJoxRtPCj
	 XfcxNU8rlbQ2T7+DJxZrwnGvealzTqhhpC8QeB3V0C/g0RUlhCj5c36yIqCUObWKWYYI+
	 dfryec97NwzByCNJNvaPckzL/COfPWVusFNG2ZaS7hFU7zntv9RqSDpj7z7MDpz16ImfQ
	 WvfnrxV4Oxygn4ScxfTwIhZhQVUTdou9fqgrh/RUqvpakDhCzcMjzYbefpUz4ePtDUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=tFrZ74L5;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDD606A326;
	Sat,  7 Nov 2026 17:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5FDD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=tFrZ74L5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xebWBu8uxtMVzUBXpbfkcUM2BjPmTJhv+4Pcphjd6Xs=; b=tFrZ74L54EWSKcPpiXne9+xeAH
	GG3e2tRuJ3nXX9epjsGsdk2UWxlNZV6U2xy8Vk6Fa7UCcV0z9zJBAQgYoXuT/fn07xf4pyhuZXGJz
	Z0Nus21XgEC04osCA5T588d/xvyC0aS6XfJs2qcEqkRkKCUa//m+vB98i/Ai+BIVTUlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPk0b-00Ez5l-Lh; Sat, 07 Nov 2026 18:15:17 +0100
Date: Sat, 7 Nov 2026 18:15:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: me@marleb.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: ethernet-phy: add
 property #thermal-sensor-cells
Message-ID: <440d83d4-a012-45d6-9c21-051414bd8097@lunn.ch>
References: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
 <20261107-realtek-hwmon-tz-v2-1-6b9a69d44470@marleb.org>
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
In-Reply-To: <20261107-realtek-hwmon-tz-v2-1-6b9a69d44470@marleb.org>

On Sat, Nov 07, 2026 at 06:00:45PM +0100, Hleb Shauchenka via B4 Relay wrote:
> From: Hleb Shauchenka <me@marleb.org>
> 
> The Aquantia and Marvell PHY drivers register their hwmon temperature
> sensor with the thermal framework, and a following patch does the same
> for Realtek PHYs, so a thermal zone can reference the PHY node through
> thermal-sensors. That requires #thermal-sensor-cells in the PHY node,
> which no PHY binding allows: dtbs_check rejects it under MDIO buses
> whose PHY children use unevaluatedProperties: false, such as
> realtek,rtl9301-mdio.
> 
> Allow it in the common PHY binding.
> 
> This patch was prepared with AI assistance (Claude Opus 5.5), after an
> AI review of the previous posting pointed out the missing property.
> 

I would put that under the ---. We don't need it in the history. We
just want to know it to aid review.


    Andrew

---
pw-bot: cr
