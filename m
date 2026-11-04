Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804418;
	b=DCY3BYUs4LX4vYP2aPvfPCPMPC6gu/Fy3OrU7xcNGu2V+iVQyJM75mcKRi3dCzUusfWo
	 +sxhFuT32WkCrgiT8MbguyP+WGlC18h+EPqFzLRBG8f5UGpxk0HWuGaBHX8EFi3VEveRU
	 iHLylwtWl2ZH9qSIlb+cEfyBD5+Ua7CNZk3DxPDu2dIDFbt2s1FxoPK4lHuYfOGZKMoku
	 7/pf8wi1lJ+J1BlzjphyFVFpHropgw0RDK0exOOOGuivoJzAm5G3cPKwUfTepnW2KHhK6
	 //kxanqvldIx8nQYcAuvQ8Zd2ihRcrXenkSrs7oovD6WY7gLfod51gfHEQzg65pAirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804418;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=L2TX4jw8nBgVDDi3cr/Q5stFGHBBLzs3q4obJ5FleF8=;
	b=B2Kz4S53jjiseXt5ew78SF58uGUWRGnhyg6ehldpHJhwuPzLUwtUMDWuWs/YWwznfcAm
	 G3Qs+wkOPQ3ezwbTclmrJCALDI4uyxJ7Ola3PANycMZQC/q/oveJE+K8UX2ln/LD5eM/y
	 EwCO2uxxBCX5FKl6bRHJlCyumEyTcmVNbT+VfeKCksYokg0fY0bGxUrnyzTYcJJqORmiG
	 ES2bg7UCmM1o9kAIqYLw0IySkQTHm9OyIbYDqylnu8RXoQWs4ISE1GbPEI83F8tGyDbqk
	 mfJoI8pYvhritTQvN3qkKBjIPWmHUELKJTJ0y98wWGfex6hYKtD9nrLJvneXe4NhwoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mdjSfNjz;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B77606A331;
	Wed,  4 Nov 2026 15:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B77606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mdjSfNjz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L2TX4jw8nBgVDDi3cr/Q5stFGHBBLzs3q4obJ5FleF8=; b=mdjSfNjzuysfatSV3UV5aMC+2m
	LLA4mrTdxlRu5ZW7vy8FnbTi08PDsefTmZsYT4HSI5QmxXr6b9kQ6gwpJoP3w2GNCz+3yIzQClEGW
	MovEpP2TUpGaakLgsn/Opwmj1HaO62nrediWVdWoN4HdC/txEiq40bsbXLoL5HdKtcv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOcT0-00EL1c-U5; Wed, 04 Nov 2026 15:59:58 +0100
Date: Wed, 4 Nov 2026 15:59:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Stolniceanu, Iustin" <Iustin.Stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Schmitt, Marcelo" <marcelo.schmitt@analog.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Regus, Ciprian" <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN
 Alliance TC6 support
Message-ID: <c1747691-2c2e-4a7a-af04-92c94cb041b2@lunn.ch>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <49b292c4-c0e9-4b19-aa4d-d15dd20d25b6@lunn.ch>
 <IA3PR03MB8453F2E91946AE59A9818B9AF2682@IA3PR03MB8453.namprd03.prod.outlook.com>
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
In-Reply-To: <IA3PR03MB8453F2E91946AE59A9818B9AF2682@IA3PR03MB8453.namprd03.prod.outlook.com>

On Wed, Nov 04, 2026 at 08:06:56AM +0000, Stolniceanu, Iustin wrote:
> On Tue, Nov 03, 2026 at 20:49 UTC, Andrew Lunn wrote:
> > On Tue, Nov 03, 2026 at 06:09:13PM +0200, Iustin Stolniceanu wrote:
> > > The ADIN1110 supports two SPI host interface protocols: the generic SPI
> > > protocol, which the adin1110 driver implements today, and the OPEN
> > > Alliance TC6 protocol. The protocol is selected by the SPI_CFG1 pin,
> > > which the device latches when it comes out of reset.
> >
> > Is it possible to read the status of this pin from a register?
> 
> No, not for SPI_CFG1. The ADIN1110 has no register that reports the 
> SPI_CFG1 level or the selected host protocol.

Seems like a badly thought out hardware design.

> The only way to detect the mode at runtime would be to probe it:
> read the PHYID register using one framing and fall back to the
> other if the value does not match. I have not tried that yet, and I
> am not sure that clocking a transaction in the wrong framing is
> harmless for the device, so I went with a DT property describing how
> the board straps the pin.
> 
> If you would prefer autodetection, I can try it on hardware for V2.

Do you have an reference design using a jumper, so you can try all
combinations? At minimum, it would be good to probe the chip, print an
error message, and return ENODEV, if the property and the hardware
don't match.

      Andrew
