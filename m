Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E58283FD9;
	Tue, 25 Aug 2026 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686909; cv=none; b=SCOpB7w9WJ7ypIhrhXr16Ni03INNpn/p1u6sWM/TjRit+s+RuQaU9J7veKg8Ok0E5q1jV8ZIOSS+ApO1RAwPcwcawl8kImW7jw0Z7SgUGBWQqus06MAYAORqBNiwY+iqBSjQjTUulDNpnMzKPDm5tYYRHugogvPNC49H2r+123g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686909; c=relaxed/simple;
	bh=tRImxGGwEw/b5IRFHRQ07pLw4FyyPD7cSMvsouuds7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD2aieNEQgSaFxRgS8wlhWXJUhA3Qbl3O72NZvckq/rwVVVOIHnw0ICAuKkZvH+BE8WQCEBT7MTI5fXq7/sTYig4VgaTIAJ0j0p11ilDB7lSe6o7TjmSmRc3QPoUQPAnoYRPKBOwKQOPF8wvNbWWwI8PhjZPjllZusUbTQ6GCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4YFhZUK0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4YFhZUK0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/d/XiaZLLKv+vI0B4miB6NRoNYuVfQaCGlqHEYGWIuU=; b=4YFhZUK0eI4ur0yv9gJdwPmjyR
	4vMUTdTgXiaYg7JZGn1wDU0Wdeh7Ug3cDd5m2RRmFen2AOMTdYheuprh+e/SWX0PAzpzxGNMxOATx
	25mRanfOgPdoEbTH3E7SkBiByj8iOJyp3Bd7MuqXvIRMiPJxkCJ4px27NL/WG4il9Egg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyx1a-001QDG-2d; Tue, 25 Aug 2026 21:41:34 +0200
Date: Tue, 25 Aug 2026 21:41:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 5/6] net: phy: mediatek: add calibration
 logic for AN7581
Message-ID: <53415965-602e-4638-98db-43e0b899f837@lunn.ch>
References: <20260724190811.198339-1-ansuelsmth@gmail.com>
 <20260724190811.198339-6-ansuelsmth@gmail.com>
 <d18d84e4-af86-405e-aadd-bd9a8dfe8742@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18d84e4-af86-405e-aadd-bd9a8dfe8742@cjdns.fr>

> > +	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, 0,
> 
> 
> This should use AIROHA_DEFAULT_PORT0_ADDR as the base_addr to avoid a
> collision if another PHY driver also uses devm_phy_package_join().

Please trim the text when replying, otherwise comments get lost.

       Andrew
