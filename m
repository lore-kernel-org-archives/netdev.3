Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C313D891;
	Tue,  4 Aug 2026 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810181; cv=none; b=bptwe1/V7ZE8Q9e9QeiRlghN6RcVKsyuwzGR9VD26Jawirw8dmLzsUa6zOo3K/sidjESGCr0tM0om5o9jAJTSCgvu9KfqLqMVFX4dhIZNu2Y7YxK7NvyFdkdEo9NdwIDvOfgVmMBsbxFl7uxEnrdzn27I9gLFlZJWyOLBhK/vZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810181; c=relaxed/simple;
	bh=SX13vEZQJkXZJt2UHR/f4IBlJrPFgf+XlGj5qM4/Nr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8jKT5KRzymkWTcF9Z+FatLVG5EjwmAA1KC6uw5gHhDt5X2zpbwf8/vokjYDkdU0Gr8ahjjOwbIlKscy/z2FGa4HimazCkgM3/UOPQ1G6xW6LAE8vlhyqWMsXZzoisqYMOCZuQDvIG2FIJIWEHHE/xZA2FUi8tmFVpCcO75CblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cfJHnsPS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cfJHnsPS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KBCTp/Dj4hax8K4vdk++/al4/OPtT9I69ZVO8QctjQ8=; b=cfJHnsPS8+lt50R34OIpYaoLFK
	3lvFwqf1TuEaHrQJmULImiw3DzOwrg5RFpQF9v0Ipby2paypRM5+7jvqmZmujLgRwKkFh9J/juiLJ
	X1Qz8nuJE34gNeAFfnoL6029h1zKwlN23cRHzSHI+DEAFprImoSaATxAc7NSwMLiGJKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr4nj-00FtTG-BR; Tue, 04 Aug 2026 04:22:43 +0200
Date: Tue, 4 Aug 2026 04:22:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mfd@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
Message-ID: <a9ce53dd-0873-41c0-ad6a-fb42e6cc7aaa@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
 <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch>
 <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
 <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch>
 <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>

> > So what i'm trying to do with both of these is make it look more like
> > standard Linux building blocks.
> >
> > If that is not possible, i would actually put all this code into the
> > PHY driver. You then have a regmap property to gain access to the I2C
> > registers.
> 
> I understand the goal of using standard Linux building blocks where they
> fit, but I do not think folding these control paths into the common PHY
> driver gives the right device model here.
> 
> The AC200 and AC300 expose the same Clause 22 PHY interface, but their
> control functions are separate devices with different transports and
> lifetimes. The AC200 control function is an MFD child accessed through
> the parent I2C regmap. The AC300 control function is a separately
> addressed non-PHY MDIO device. A regmap reference only describes the
> AC200 transport; it does not represent the AC300 control device.
> 
> Folding both implementations into the common PHY driver would make that
> driver manage AC200 MFD registers and resources as well as an AC300 MDIO
> control endpoint. That would mix the package-specific control transports
> with the otherwise common Clause 22 implementation.

Given how messy this hardware is, i doubt it is discoverable. We have
been pushing back on hacks to enable various things before probe in
order to make it discoverable. So you are going to end up putting IDs
in DT so that the driver probes without it being discovered. That
means you can put any ID you want in DT, and the driver. So you have
two different phy driver structs, two different probe functions, etc.

	Andrew
