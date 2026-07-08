Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A43AC0F4;
	Wed,  8 Jul 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521357; cv=none; b=dCrP9hBL6UPtc4eS2L7AIqHdPASrzU1JU+jkapiB/ARN51XPq1Ngg+6jtFvQWwqHio5h1PIci8DNINo7L5jnuZlT8AJa1hhKSjtMQCs2Fxrs74DDYaFrY6MyLtj1kvqAcA/kD6TuVXTBayP18VEiYp96rzxgt4gYpsLEcFHGmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521357; c=relaxed/simple;
	bh=y3rT/mjcH4xI9BKcUNq8uwljgKi3IFXGXPepiCwt2w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgXzmFaCWYuybWARiMj29hTzm8trfwRTHoesRW1vFg3rMMxdizndU2uwWV7pn0E3ylGekPQXN9mBcez0OXGINFPdhECJ3mfPIW51/N+h7AT8aodqQU8S/1mBdSrMe9UTDhhcIcl3e28hi08bNllXHqNIu+2H9t/DQVSilXGaWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YbOHKqa1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YbOHKqa1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=3RsIPvZTD5nyIx31RnZBoJDbs5La8Zh1JeU+CoAk0mc=; b=Yb
	OHKqa1T/B64IUbHGnRIp5MUkE/sqUTcfU+fOTp4OdCC8IXPMUblg7xAEbtfI6mPatQsy5wLoEIfw5
	k9FEupjoPV+I/yDDkkQBFzXdcyd2+uZmyhbI8FrJpRIj2U70jU17dy+IY9pmVK3R++4cIYekuR7l7
	ftGjZ2nL0usWUlI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whTNB-00BKwC-V6; Wed, 08 Jul 2026 16:35:37 +0200
Date: Wed, 8 Jul 2026 16:35:37 +0200
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
Message-ID: <6ea11726-8d50-411e-afab-da346e09ab9b@lunn.ch>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
 <20260707-dwmac-mediatek-mt8189-v1-1-17f345eaaca3@collabora.com>
 <b810b9cd-8f5e-4c9d-8496-908aae55dac1@lunn.ch>
 <8304b0a704c8db697767584b8c34388f07ba401d.camel@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8304b0a704c8db697767584b8c34388f07ba401d.camel@collabora.com>

> On Tue, 2026-07-07 at 14:42 +0200, Andrew Lunn wrote:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - mediatek,mt8189-gmac
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          items:
> > > +            - description: MAC Main clock
> > > +            - description: PTP clock
> > > +            - description: RMII reference clock provided by MAC
> > 
> > Since this is a MAC, it sounds like it is consuming its own clock?
> 
> In the driver ([1]), this clock is described as being only used and
> needed in RMII when MAC provides the reference clock, and useless
> otherwise (RGMII/MII or RMII when PHY provides the reference clock).

So it sounds like this is a clock output, going to the PHY, as its
reference clock input. So ideally, the PHY should consume this clock,
not the MAC.

> Its use and configuration also depends on the "mediatek,rmii-clk-from-
> mac" vendor property ([2]) presence in devicetree.

This makes it sounds like it is historically wrong, and the patch is
just extending this to the new device.

Do you have a board using RMII? Can you list the clock in the PHY
node, not the MAC, and see if it still works?

Ideally, for a new device, we should not repeat past errors.

	 Andrew
