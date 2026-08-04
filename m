Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA044949E8;
	Tue,  4 Aug 2026 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865147; cv=none; b=YFpQ6PKn4ElhwqeFLACohfKjvZ351v9PqhRouxUP4IxBnxUgoMszvhfC24hRMSTTCysBJlGF8ZbiELJxNIdzuU+pPLb+iVCOKDtQlCPaNxzgP7fv+DjRoCUu4w7VSM6226Yl/RO2LWsRVNIrbtwqsIWL2ZZfQJPya8KGsBEWwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865147; c=relaxed/simple;
	bh=n9k+STtkLseuWk2U/CPOHJLHCuyJ8LwrTKpV0GGni7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvMecZ3enbnbsuX0QgW+XUSDK40vWCcbhLvzKooLB00uod9antQ85bxkyywDQ6uACfhDUwfwOP6hwABakL0Wl33I9gXULd2x99La/kr7uupZr9o23SY3X+3DWXPlBElIAVHaVwR17FYN54eIxFl2n9w78fe2dvk3RmNuMgyaRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yoyLWprD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yoyLWprD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iEI0tsAN27gcGUyJPUFdfbIkSDOcl8zJRY+yO6IjA8E=; b=yoyLWprDwgxFu5mYAEn0SWOsHd
	Oi46csV9zN33JyPIvHApKBtCDW42AQUUUlGXzFn6E7Dze5qPN7pVQwVvCWC4K1hG93ghBJ021aTf0
	ySxCwlGTz8UX6CmusMreZx/UoBOyZxDReyZBxhEut4FvMZpxKWFxCBhafQuqyXb/cWCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrJ63-00G1hx-Un; Tue, 04 Aug 2026 19:38:35 +0200
Date: Tue, 4 Aug 2026 19:38:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
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
Subject: Re: [PATCH 00/21] net: phy: add X-Powers AC200/AC300 EPHY support
Message-ID: <9dd29610-d9e4-48f2-9638-2c92863626f8@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <aaec8809-8218-4412-a60d-931406dbf287@arm.com>
 <CADvTj4qCYjQHOQn1jRTHNNL=xeX6z3Dgc-PLwOBUvX34AU6cuA@mail.gmail.com>
 <AGtA6uUwR9yJMX3xYVDz6g@gmail.com>
 <CADvTj4qBhiPczrP9YC2uTW3xss3W7ghoBzbctM45yUROfsgPhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4qBhiPczrP9YC2uTW3xss3W7ghoBzbctM45yUROfsgPhw@mail.gmail.com>

> The AC200 Datasheet V1.1 and AC300 User Manual V1.0 block diagrams show
> effectively the same EPHY organization: MII/RMII, auto-negotiation,
> Auto-MDIX, 10/100 transmit and receive PCS/PMA blocks, LED and
> clock/reset logic, a PLL, and the EPHY analog front end. Both variants
> also report PHY ID 0x00441400, and testing shows compatible link-side
> paged registers and behavior.
> 
> What differs is the surrounding control path.

Which is still part of the PHY, needs driver code, and so should be
part of the PHY driver. 

> AC200 is configured
> through its RSB/TWI-backed MFD registers, while AC300 has a separate
> non-PHY MDIO control endpoint.

Which is an implementation detail.

> I do not think the control-provider reference is artificial. It
> describes a real functional dependency: the Clause 22 endpoint cannot
> be accessed until the selected package-specific control block has
> powered, calibrated and configured it.

Nothing too special here. There are PHYs which do this, in the PHY
driver.

> I also do not think a bootloader fixup should be the only supported
> selection mechanism. Boards using the same compatible have shipped with
> either package, and the SID field provides an authoritative package
> selector which Linux can read directly. Handling that selector in Linux
> avoids making support depend on a particular bootloader implementation.

There is a trade off here. If the hardware design is just ugly, badly
thought out, poorly executed, not following the industries norms, we
want to push back on the hardware vendor to make the next version
better. Until that improved version comes out, either the vendor crap
driver should be used, not Mainline, or we try to hide away the issues
in the bootloader. A vendor which actually cares will improve, they
know what Mainline means. And for vendors which don't care, why should
Mainline care, especially if the issues can be pushed to the
bootloader.

We don't want to mess up core Linux code to handle one broken device,
that just makes ongoing Maintenance more expensive for everybody.

> A bootloader fixup remains compatible with this design. If firmware
> enables only the correct provider, the fixed-description path is used
> and Linux does not need to change the tree. Runtime selection is used
> when firmware leaves the package variant unresolved.

So i would not try to fix up the unresolved situation, just do a
dev_error(dev, "Please upgrade your bootloader"); and return -ENODEV.

	Andrew
