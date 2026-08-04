Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7F412C0C;
	Tue,  4 Aug 2026 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872673; cv=none; b=i5QeAE7D+NRytmRN7Hbtp2tA/zQOKinBL9WLxHPD4HJ9OLxMZUab0bk2MD4MP7dENgcOFi5A6iqSCjSwypAYHlI5cdKL/FC7p55/uGXnX5eiDtkv4TL8qQqI1C5z77EtYqr8JBLgu28OekT0ZIbwNT/lqg6zucZeIZUjxhGZ31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872673; c=relaxed/simple;
	bh=j3+K4h1wrpUIVVhL+z3lvViBQkniwHOhXJr+jcUmteI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyaWryVrg+CRx4nbctDUDONBrxLat3Fn3g2PL62n5VHX2S7S2X15xgX1eDVU8G2/GIygasIUpv7byjVB+Am7N/+0UAL1KBRNyar02q/Cthlu7CWhsVuru/ymGT8ICxonlq0DIgUZtf5m1VNvq4tVgvcNIntt5i+2+73TvJJIPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wZvbJyPQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wZvbJyPQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kfMWIjz06sn4XEVpzbsEA+MT9XMJpOofhYIonsVdqUE=; b=wZvbJyPQqM/v0df4gh/qeWP1AM
	CNyjsrV0dEBeBzsN0EA5fVwLpZPkJo+Y0EWu4YFXyHaxDcMpuRQiLee31C3bIeAFsK3nlURlXVXhr
	X72cTVsUzoTDdJ3AWJWQufHm4+Hr3DOWGy65GgA35/EnkzIEKx2GaU2ZI34FqoYhEELA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrL3g-00G358-11; Tue, 04 Aug 2026 21:44:16 +0200
Date: Tue, 4 Aug 2026 21:44:15 +0200
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
Message-ID: <62591c23-87c5-4dd5-bf3b-d9adba3ae2cb@lunn.ch>
References: <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch>
 <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
 <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch>
 <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>
 <a9ce53dd-0873-41c0-ad6a-fb42e6cc7aaa@lunn.ch>
 <CADvTj4qpHU3F0DrEmc0vFi+JiwTNERniiMHKo1LmBd8sg58wJA@mail.gmail.com>
 <205e9051-8e43-44bb-a4b5-4ec69a192fa3@lunn.ch>
 <CADvTj4qmXWbDsc-vigcSrF1N=zpxmZWGp3YaZ9PFcWK551h3mg@mail.gmail.com>
 <fb6f8065-a655-4d53-acfb-8171b2e003dc@lunn.ch>
 <CADvTj4pdZN4Jmx0D4Yh0KDPkh_-zJ5iXCM=vUybGn0aFAAqAgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4pdZN4Jmx0D4Yh0KDPkh_-zJ5iXCM=vUybGn0aFAAqAgg@mail.gmail.com>

> However, the MFD and networking portions necessarily meet at the AC200
> EPHY function. I do not think the correct way to avoid that
> cross-subsystem dependency is to make a driver bound to an MDIO
> phy_device take ownership of registers and resources belonging to an
> MFD device.

We can pull the MFD Maintainer into this, but an MFD core driver
typically just provides methods to access the shared registers, and
instantiates drivers to make use of those shared registers. In this
case, we don't need the instantiate part, that happens via the MDIO
bus model. But we do need access to the shared registers. I personally
don't care too much how that is done, but regmap would be normal.

The PHY driver should then drive the whole, entire PHY, using both
MDIO and whatever method the MFD exports to give access to the
registers.

	Andrew
