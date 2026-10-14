Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1D4D17B7;
	Wed, 14 Oct 2026 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978736; cv=none; b=LNdFwhY+1O1FmGvig3FIC/MzyZXU8i3TtATqJq4QhzQDRh97rhajlXen/X49hiZ7O4idE+jxhJkKuduWpUYV2DxmyHxFtrEhZ1TcZvKIEluI78cFjVVGKZDlue/YGo1BLHlQsEpKPCXeqXC+WnOoYK7Si5XBtK4czaqkZlAtEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978736; c=relaxed/simple;
	bh=EoqjZJbZpuHfV9MGKCulG//iWekFQgAbAwPud8Rl0n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzaDaVIlYDFmO6Gsfgr7BVQNV4qk3MOQGKjF6Wn3UzCQF5uf8J185qxLf7zsREk+RBbDYiIpqlPpZGrjlgsa6KSHzICDF5Te18zlANrfeFpa8YCnHw0LiBwV7KcFo24DrfjoyHuC96MlNKfvq/ZYP8p3IAEJc6isDJ2YDdkVSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HCURjbPg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HCURjbPg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zi7WsHQw6vpZpbLKcVYGRjU7uMh3sos9g0/EkOfVN7o=; b=HCURjbPgJ8PaWdJWkP/zxvxQAx
	L6P0ntvvdMc+MLW97Nlz8mJCeiqe6UcwZuuD1xIHKBF/GHP4WzvHjURxyXDl0AvJRc6NZDsW+HxEe
	2pWfcR0IL3NRI+JT+WduC+hIANP7K3PBQj/SQlvSSFMqM2KOPYQITYEGU8d42LO5w9NY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGxWS-00AipH-Pk; Wed, 14 Oct 2026 13:51:52 +0200
Date: Wed, 14 Oct 2026 13:51:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v6 1/2] net: phy: refuse a second attach before
 touching the PHY
Message-ID: <b5df1546-4208-4dff-b494-6db516188795@lunn.ch>
References: <20261013151200.2473464-1-f@lex.la>
 <20261013151200.2473464-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013151200.2473464-2-f@lex.la>

On Tue, Oct 13, 2026 at 06:11:59PM +0300, Aleksei Sviridkin wrote:
> phy_attach_direct() tests phydev->attached_dev only after it has taken
> the driver module and, for a PHY with no driver, bound the generic one,
> and then leaves through the error path that calls
> phy_detach_internal(). That call works on the PHY's current attachment,
> so a second attach of a PHY in use tears down the first consumer: it
> clears that netdev's phydev pointer and the PHY's attached_dev, removes
> the sysfs links and suspends the PHY, while the first consumer goes on
> using it. A PHY on the generic driver never reaches the test: the
> attach runs its probe again and, when the bind fails, clears d->driver
> under the first consumer.
> 
> Found in review of a change that makes phy_detach() put only the
> module the attach recorded: with it, this path leaves the first
> consumer's reference pinned. On a Keenetic KN-1012, a test module
> attaching a second netdev to the EN8811H that the lan4 DSA port holds
> got -EBUSY and left lan4 with no PHY; with this change lan4 kept it.
> 
> Test whether the PHY is attached before the driver module is taken or
> the generic driver bound, and refuse from there. A PHY attached without
> a netdev, as DSA does for its CPU and link ports, has no attached_dev,
> so test phy_link_change, which every attach sets and every detach
> clears. A second attach of such a PHY used to succeed and share it;
> with that change it would also leak a module reference.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
