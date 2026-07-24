Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2525487C;
	Fri, 24 Jul 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899936; cv=none; b=ZFBX9PR1fUHfc94rDv0ef3ysTeqJJmD/69saIYhbq7hObZ3L8Ly4tlR0Dy1KxATdXk5x8h324IF1Y0x0/dn7yh5u5EtdJLsLBAwZlxxCSgJ5rQ5OymSypmh1gnKM5Pnx484W9du/Db+iAxe21HBdjwV0h2cGiERjRqq0QnnX2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899936; c=relaxed/simple;
	bh=XTG4wZjDO7F4xbKFzO0zRgvt9Q3L5ZAseFwMIpYF+CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc+JbWuQljICbhpQeq8cKaMJQzlnNX2ZbI2ENIQU4ZJrcxbT2IfbokJZT948pIjH++9AYAmtvqKXJuluNZghzPL3dJdvZhfrLJ9nx1DJDpvy+qIDCNoXzLQKYIJPHOxxXFq5SgTwHZR2SvKw7w9KnWQtNWr/cMiAKkhKUUe9Z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ht+WE01v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ht+WE01v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d5Ndja1XTEQtXNMBV9Ptqjp/+QvlljffO2q5Aq9XOIE=; b=ht+WE01vdlrS8rFoG0/88Omo8P
	MtCxzLlCV7mw79qO0m1Amkq5Y1VR/rMwjjBzEPWb9Y8dXtyTUcXYV0NmGEvFdvgJcTTcT55Bj9Yw4
	l+1ntmWqc8JANJl15fF4Eak8DziVlndNQDcdE2aTIFI2ZbOyUS2MCwXrQ9wgX1EbmmwI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnG0U-00DzyS-MK; Fri, 24 Jul 2026 15:32:06 +0200
Date: Fri, 24 Jul 2026 15:32:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/13] ax88179_178a: Add EEE HW configuration
 support for AX88179A
Message-ID: <1a5a0720-5913-4935-8ae8-d3d0f54734c7@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-4-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-4-bdde4f905883@birger-koblitz.de>

On Fri, Jul 24, 2026 at 09:36:47AM +0200, Birger Koblitz wrote:
> The AX88179A uses a much simpler HW configuration for EEE
> via a single EEE configuration register. Add support for
> this register and replace the EEE enable/disable functions
> with a single EEE configuration function which enables/disables
> EEE in the hardware.

EEE is split between the MAC and the PHY. All the PHY parts will move
into the PHY driver when you convert to phylink. 

It looks like this is about the PHY?

> +static void ax88179_eee_config(struct usbnet *dev, bool enable)
>  {
> +	struct ax88179_data *priv = dev->driver_priv;
>  	u16 tmp16;
>  
> -	tmp16 = GMII_PHY_PGSEL_PAGE3;
> -	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> -			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
> -
> -	tmp16 = 0x3247;
> -	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> -			  MII_PHYADDR, 2, &tmp16);
> -
> -	tmp16 = GMII_PHY_PGSEL_PAGE5;
> -	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> -			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
> -
> -	tmp16 = 0x0680;
> -	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> -			  MII_BMSR, 2, &tmp16);
> +	if (priv->chip_version < AX_VERSION_AX88179A) {
> +		tmp16 = GMII_PHY_PGSEL_PAGE3;
> +		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> +				  GMII_PHY_PAGE_SELECT, 2, &tmp16);
> +
> +		tmp16 = enable ? 0x3247 : 0x3246;
> +		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> +				  MII_PHYADDR, 2, &tmp16);
> +		if (enable) {
> +			tmp16 = GMII_PHY_PGSEL_PAGE5;
> +			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> +					  GMII_PHY_PAGE_SELECT, 2, &tmp16);
> +
> +			tmp16 = 0x0680;
> +			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> +					  MII_BMSR, 2, &tmp16);
> +		}
>  
> -	tmp16 = GMII_PHY_PGSEL_PAGE0;
> -	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> -			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
> +		tmp16 = GMII_PHY_PGSEL_PAGE0;
> +		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
> +				  GMII_PHY_PAGE_SELECT, 2, &tmp16);

I would maybe put this into a helper. When this code gets moved in the
PHY driver it is probably going to be a function per PHY.

    Andrew
