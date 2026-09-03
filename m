Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35640681A;
	Thu,  3 Sep 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438413; cv=none; b=McyNbDkcs62HTQjK1HEECqA0gaPrx4p/jIZ7bTpmWAz/iUBQh0imamDvBdLsif1KTJVzWeRm+zvQ+5K2ePIY/CA/zLjw9ax5rrNxQGupAU/FqfjonUFhtDrOw6EyAp/HUQPVGQk9M1cRVDkbMp797eeo+LD40OOCciFQNW4+eZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438413; c=relaxed/simple;
	bh=aRVsZf+IeDg7H1USx6COdGFGSvxpXScpaNYJDUmI9tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYmlj3/B+u3FpIeTM+FKN7ZRMQaG55yWxLXxcmWyCerAOaffSnn4bWHkPpXaEysMDrmji2KjnNUF02mr8Z3nkhKUlPddqjD/Gv5K3gpdDpHvLaTB3TrAbF0RWyMROaXzF4CrEuBwEJjwjg0lXFio+SN07Ejgyd1wIwybHgsaW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wtlVfjjJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wtlVfjjJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fx0WgZnUlBwY/g9jObZUMhXjJIYEYr1WANTLvXc5zwI=; b=wtlVfjjJzc2EQQlqeJJbLoeGWl
	x7tvmRKZXIaWwtC8nJ20IoXcNyJrVlhoUii3NPhqyr3MwjpPN/TIzFoQLZ8ORTkLmPcIMNDMBVaf1
	soajtuG7qdsJ9aSK3JABVIQe7xyz7rK5SmD+GYD5ULRfhuG9J0f/XoblZHGUyjJYm+3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x26WX-002ieC-6o; Thu, 03 Sep 2026 14:26:33 +0200
Date: Thu, 3 Sep 2026 14:26:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: mdio: realtek-rtl9300: Convert
 "fwnode" left-overs to "of"
Message-ID: <4d692d7d-3b00-4ba5-bd22-3dcb4130c618@lunn.ch>
References: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
 <20260903122119.2638354-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903122119.2638354-3-markus.stockhausen@gmx.de>

On Thu, Sep 03, 2026 at 02:21:18PM +0200, Markus Stockhausen wrote:
> The latest developments of the MDIO driver consistently used the
> "of" API. Convert the remaining "fwnode" left-overs too.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 11d078ef941c..429321e9114f 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -831,14 +831,14 @@ static void otto_emdio_notify_phy_detach(struct phy_device *phydev)
>  }
>  
>  static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv,
> -				 struct fwnode_handle *node)
> +				struct device_node *node)

The indentation looks odd here.

	Andrew
