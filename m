Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080432C8B;
	Wed,  2 Sep 2026 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307937; cv=none; b=c1/6OV8JZwFE6/tJXFYNpUMFO32FZOY5NsvMtzywLgyq+ZHb/lVbIYCnbzfQjKLgMwdcpiZ96F9MXbjAy4np11OTnkugRThG805Qi/7kgnqre2F8MKtnFnB85YrnB+iocwRqu36AX1o3nguCFWDhqseZbrs0DqeJoqNOyx72Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307937; c=relaxed/simple;
	bh=0rVOP61wINPFhD+Qp57kUT39jaQjGDGMS95wW7WGuxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsIRLDQPvlINPh2kal+gK42K7n9rNYqshat/zUxoq/yrEWZW54au97lNYumjlEvfSuNDbBy3BR/KaSvReJRgNlF4D43gdyXc9No2EfXZwh8u2GaEcjjJ/OEjMR2P3rHuoJDFaKU64XCeYMPBB5ji+6CjcUUtXsOZHarF9atmFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3YJrNc13; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3YJrNc13"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k/fPMqFoonPAyi45v4BrXWjMlFevWJ52NypyGpAuZto=; b=3YJrNc13hxn8Mwx2iIoy08HLP5
	fc5o40rrZP8kgssRTbzuVHvK/nplswBRzjobAbFcNBN6AG16wa/L3CFXj7d3qPmr17Spc1pnCJ0a+
	QwkASfOe4rP2xUHjBIIETtlPqdyFH63HBBU1a3JnUxkJNHqgV88D0EnAouQ3IxHSI+yE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Ya9-002RZ6-LC; Wed, 02 Sep 2026 02:12:01 +0200
Date: Wed, 2 Sep 2026 02:12:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 06/13] net: mdio: realtek-rtl9300: suppress
 sysfs bind/unbind attributes
Message-ID: <3064d6a0-8d94-4411-9994-99108ce6232b@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-7-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-7-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:32PM +0200, Markus Stockhausen wrote:
> The Realtek MDIO driver relies on devm managed resources for lifetime
> management and allocates its internal central controller structure
> otto_emdio_priv via devm_kzalloc(). This can lead to a use-after-free
> in the following sitauation:
> 
> - If the driver is removed or unbound via sysfs the controller devm
>   cleanup is triggered immediately. A corrupt devicetree might produce
>   a load failure and a cleanup too.
> - However the MDIO buses are allocated with devm_mdiobus_alloc_size()
>   and are reference counted. So if a MAC driver still holds a reference
>   to a PHY device on the bus, the mii_bus will remain alive.
> - Any action that is run for the buses afterwards still relies on the
>   availability of the central priv structure. This will access already
>   freed memory.
> 
> There are multiple mitigations to choose from
> 
> - Clone all controller->priv data into the bus->priv structure.
> - disable sysfs bind/unbind attributes
> - Check for "bus->state != MDIOBUS_REGISTERED" in all callbacks
> 
> This SoC-integrated MDIO controller cannot be physically hot-plugged
> and manual unbinding gives no benefit. The driver is usually
> integrated into the kernel and not loaded as a module. Avoid a
> complex driver rewrite (data duplication) for now and set
> suppress_bind_attrs to true to prevent unbinding via sysfs. This
> mitigates issues for the known use cases.
> 
> Fixes: 24e31e4747698 ("net: mdio: Add RTL9300 MDIO driver")
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
