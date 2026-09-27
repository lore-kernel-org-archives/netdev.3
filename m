Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855582BEC55;
	Sun, 27 Sep 2026 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529813; cv=none; b=V1k9C15IFo1duGAo/hIDnwDyOHI607xiOTeqnwb86iOm3t2a30Sto8e1jDeyKC5BZ99YItLrxrtFy2g4xWGs3aYLxdUFxApLT1TaHlLfoz1J1M6O+ti/O+fhnEYgp1v5nndp3FoKgjyhlV7t6/gnsiCbfLOHRsfc1F0VQhCG54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529813; c=relaxed/simple;
	bh=KCn0NKT3NmbuLOYJdphcBJtaaVq6i14mF5IG87QPXpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R13KmbftTOIYZtFmkxvOEb2lI3f0MIFPsZgAFloQHOsg7x4bz6YMoNTkoyEeyhhSShdlC4SqF94y5xiSgJk0XbBALKlCeMHxFO4duByCmbPdK5aoG1pB6eZfZoDO3Cdqgx/TvMcDbto3qKb7zLc6L+eNLCJ3qCwfOqc6YQETi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IH39dNs/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IH39dNs/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RNBsNnSyabL0IsJzCwhXF02Q2ZIIDvubGJgXRakt0xY=; b=IH39dNs/k3aZE6LPxPj0DV+rKc
	phJ1geg7zNuzUcf/uVWwBcQFA07LRCNt+GZD3JH8V46fA/12nbeklBi5cJo5BGzNl1adtltJkvG1/
	/jLo7hXcyjhw+ZbER0xpbTC9jWkXZpqpM/nnl5rgHPpZllpGAaDIkKR2PIXjLNgPxNvc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAsan-007Xr1-4w; Sun, 27 Sep 2026 19:23:13 +0200
Date: Sun, 27 Sep 2026 19:23:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] net: phy: Add support for the Maxio
 MAE0621A
Message-ID: <c47f2a80-5b29-4fe0-9944-cbad125ce000@lunn.ch>
References: <20260926225625.25969-1-andre.przywara@arm.com>
 <20260926225625.25969-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926225625.25969-3-andre.przywara@arm.com>

On Sun, Sep 27, 2026 at 12:56:22AM +0200, Andre Przywara wrote:
> From: Liu Changjie <liucj1228@outlook.com>
> 
> Add exact PHY ID matching and optional 125 MHz CLKOUT configuration
> for the Maxio MAE0621A Gigabit Ethernet PHY. Preserve the existing
> hardware configuration when the firmware property is absent.
> 
> Signed-off-by: Liu Changjie <liucj1228@outlook.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I sent a follow up email saying i was withdrawing this
Reviewed-by. Please ensure it has been dropped for the moment.

pw-bot: cr

This is an RGMII PHY. However it totally ignores phydev->interface.
There are four values which we require the PHY driver to act on:

	PHY_INTERFACE_MODE_RGMII,
	PHY_INTERFACE_MODE_RGMII_ID,
	PHY_INTERFACE_MODE_RGMII_RXID,
	PHY_INTERFACE_MODE_RGMII_TXID,

Every other RGMII PHY in linux will configure the delays based on
these values. If these values are ignored, bad things will happen.

From what i understand, the delays are currently configured by
strapping. We are going to get into situations where the strapping and
what the MAC requests are different but no errors are reported.  DT
developers are already bad with RGMII delays, and this is just going
to make it worse.

So you have some choices:

1) Implement configuring the delays in the PHY driver

2) Find out how the delays are currently configured and return
   EOPNOTSUPP if the requested configuration is different to the
   current configuration.

3) Always return EOPNOTSUPP for all the RGMII values, and only accept
   PHY_INTERFACE_MODE_NA, which means configuration has been performed
   using some other mechanism, the PHY driver should not change it.

Additionally, my understanding is this PHY will respond to address 0
as a broadcast address. This is not part of 802.3, and always causes
issues. Please ensure this is turned off.

    Andrew
