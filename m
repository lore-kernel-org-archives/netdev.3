Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7273033EC;
	Fri, 24 Jul 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910184; cv=none; b=QfehyH7RiFpTgYW1dFUqeokRS/1NiJnVTpX0+Wttb68OdbEVXu4eo6G1JDuYVHqkeSCMA1MneygPy335Q8YzsndgB5BRo/kNVeUtMQXcnacR5TC8NEfRo7T2ahuFTIUNS6hocVMX/0lHLMpBJMfxQQRrZS3vCePi7X50jY3zCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910184; c=relaxed/simple;
	bh=HDhXm15uHBQirnAiO7enPua9uAvw2fO9UrzeeK/Pkaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOFaRlhwa29Vlr0iUCWvj2CkTV4tZr40HvK44oLSZmBQhUd+tl7rfEOUakQosveFhc+HdIjXRXdzb/eH0D/DYlaUV32Y3S6u8ADEHsBl468/CsL7nAowbcUWk3eKbcWFr0iPuYZD9KL4TGbh+me5CmcMLWRhU07bPF+V6DxMy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5IHJT29Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5IHJT29Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SEaO6NwPsKJWTMWpexS5pfc3xfPosppbbehOaq4DfwM=; b=5IHJT29QAdopSjr4DXUwA44Hvl
	g9uY5z74a2k+QLuX/kGjCSBo4IWt+w8/yBvqUSic0ocN0azC0UHitihI3YE0O/vj68SftX50sAV/S
	rH249vpVFC4BHbvKM9sOXoKqeSa3k4PsdEHNhXOizZ5XRhaZjFGpQtUDnWavsUQHEzTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnIfi-00E1Yj-Fk; Fri, 24 Jul 2026 18:22:50 +0200
Date: Fri, 24 Jul 2026 18:22:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/13] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <9cf523c0-f765-4be4-8b8b-7b29a3ed6329@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-2-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-2-bdde4f905883@birger-koblitz.de>

> +static void ax88179a_mac_link_up(struct phylink_config *config,
> +				 struct phy_device *phy,
> +				 unsigned int phy_mode, phy_interface_t interface,
> +				 int speed, int duplex,
> +				 bool tx_pause, bool rx_pause)
> +{


> +	ax179_data->eee_enabled = ax88179_chk_eee(dev);

With phylink, EEE works differently. You need to provide
.mac_disable_tx_lpi and .mac_enable_tx_lpi in phylink_mac_ops, and set
bp->phylink_config.lpi_capabilities etc. Take a look at

commit 0cc425f18f59f992c61c1802331d25ce689ff5d1
Author: Nicolai Buchwitz <nb@tipi-net.de>
Date:   Wed Mar 4 11:54:29 2026 +0100

    net: cadence: macb: implement EEE TX LPI support

and there are other examples.

> +	netif_carrier_on(dev->net);

phylink devices never touch the carrier. Leave phylink to set it.

	Andrew
