Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D065456E1C;
	Mon, 17 Aug 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985269; cv=none; b=RxDm07M8vDdm7tcLtZKkiJ0Sm3K2XdO7lO99g4UAec86tdBpP7hX2plRGMLTrhxQEFFHZRerreMhnI8980dCyOdFmzQguXJvvIPo+5FPP1ptD8oXoUEBtfZIhl3sUZXlHru/5WUS21j7ecJH7PiSlW97gyLh/4uU8xgjXdmmSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985269; c=relaxed/simple;
	bh=zToDJMEWC6+d1MMhxxoBvKw1IqxnjhdTtgjBIJ0lj2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX3yI4mDN30Lez5N9+tcNC1YxipJX26m+o58J1VwyhgC7zP7oC01OcEE2RIGXTSYTjafzMfl3tTY8hxkYa/GiTC+WhlbORD+mIPyEmQdfDu94EUcgn1PI5/KGV7hDFEnknlEfoQgftIVf6I6OTZ6FjLiIbXhWfYARhcKTSle7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vxHhlGa8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vxHhlGa8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WFBzJIunrIaEdYUzj5rxIAaKRvaoP4qIgW0VICoyCoc=; b=vxHhlGa8WfiiRwSS7KmAtDBG1y
	bwxxx0dgmM/CDzxCBxOgorKae1EnSkSpy2cuHAwyTqoEELDSFsodu5H1g3Brl7vg3aDvAMhpkSG7M
	67ff7JQAW/ArD8GzgfD0lygc2X+LIRnkrG4VOaP9Vzts+M7nIdIkC2vsnVRmsY96pGeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww0Uo-000LGl-Og; Mon, 17 Aug 2026 18:47:34 +0200
Date: Mon, 17 Aug 2026 18:47:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 06/13] net: mdio: realtek-rtl9300: suppress
 sysfs bind/unbind attributes
Message-ID: <4dea9699-483c-46ba-aced-19f74e555dea@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-7-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817162632.1208891-7-markus.stockhausen@gmx.de>

On Mon, Aug 17, 2026 at 06:26:25PM +0200, Markus Stockhausen wrote:
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
> Fixes: 24e31e4747 ("net: mdio: Add RTL9300 MDIO driver")
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
