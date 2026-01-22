Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BD35CB80;
	Thu, 22 Jan 2026 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123525; cv=none; b=CO1FDpYQg5E0KNQ+m+hLr1CilfS+X0QPoYjL4k1Hp3AA38MMBWqQDlFBSWuPT3L7aP4DzhkgiWvM2p0unKhHxy2Sj7nnu0AN2+7c0umfnU1ZNWe4EcAjv5wBVvOWOtPhSddCZ832giyupiwiWtModYeu0ZQMFV/n0K2nG3NimuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123525; c=relaxed/simple;
	bh=5Ach7FQh0kSIfmJrAu7ACPYtsNfM+oR2FY6U6x+dxT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb2m0DD9SwAX1aaq8qPL+FVWILvGHd+yJoD941tY7OUnVr9BNZclFB2TomZfK4CSW/x+6/zw90tXDMAzOU2dKMOgPYXzEn08A+aEcDdzGDi6ayYRt/GSPX0UK6gAGSJFfkQ2joTIEx4Q41HTrPx30T1oSWkHjHJp0ZwuSKQzApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fU3KMWft; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fU3KMWft"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FxLcaXRPfi9zcjCrv3XME+vG698ByHEWZmdDgcDOrwk=; b=fU3KMWfta0rG3ErYDO2wLNeQa5
	gstN+V9ikpsZPqf1cucuIbBmuNDi68wcR5+SXU3lQ3cOB0HN9qgrTChsCNGAXZd4g8JriwvAJOXMT
	sm61w0mZUo5DvskZiU9l4h8Rg87A1sWFLCXj11wmI/bZ/kHiwQqnF/vchPfhJHywkb+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vj3q4-0042bT-Si; Fri, 23 Jan 2026 00:11:44 +0100
Date: Fri, 23 Jan 2026 00:11:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 02/15] net: mdio: add driver for NXP SJA1110
 100BASE-T1 embedded PHYs
Message-ID: <bfd1058d-5acc-4147-9609-2b257070f7a3@lunn.ch>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-3-vladimir.oltean@nxp.com>
 <aXIUJbEwnAvIkeKK@smile.fi.intel.com>
 <20260122124708.pxckp6vgi2rvagmm@skbuf>
 <aXI339TiHFaEAWXE@smile.fi.intel.com>
 <20260122221003.p2cbemzvi2mayety@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122221003.p2cbemzvi2mayety@skbuf>

> I wasn't prepared to go down this rabbit hole, but it turns out that the
> __mdiobus_read() and __mdiobus_write() functions do support regnum >= 32.

It could be historical, from before their were C22 and C45 operations.

Previously, both transaction types were passed through one call. The
MSB indicated if C45 should be performed, and there were some macros
to split the number part into MMD and register.

With the current implementation, it should be O.K. to add a range
change.

	Andrew
