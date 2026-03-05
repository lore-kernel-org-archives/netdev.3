Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D33D5242;
	Thu,  5 Mar 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732236; cv=none; b=g4WR2piJBn+2VbhK02px5YtfBXuFoUhHT4rVpDT/Dw6kS2frx/Ar9PBzQRnyGafeiHZUiawDHSszyb2905xRNMv3NDx3yIFVqVvInKVIZdApvOTk8E+qegNO/ufnLjfsYHDlZa2QsVt2+9oN4lTr6zT9ijEYF61SB8O3ia3Lt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732236; c=relaxed/simple;
	bh=FPU9+K5FZpLr/vnCVIdP3CNVxs73aKrczX3fGBx3eg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjWqC90B8x+EicP8ZNrxm/WZhf3/nei6UXphfLvr0ZkP466iXKFujDmt6+bNY8sNFEh9GviaucXz7d9eYqwXCYxJcZfhQ0QKp9Ggc3Ovxj66QQLC6Xj+46Gy7cyKk9qXtRSlpYCi8KyBZQiPPzKzbN3CNGbl7CIM5Ae0v1FJVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FuelH896; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FuelH896"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7ZM5KkU/rZ9felY/Udq9uvELvoAu/GlxCR0aSRgP124=; b=FuelH8960mElIpPhMBcrh+8qcv
	BCbjDv3Dd5tJKosddVsPNg6hc+FZmTYmrt1g5BarxkFpGNl9TxIMWLwG1GtDtfTnln7bAFkJJo3gb
	Ct7fSAC1r+tLZoo/WeW+b/w0A42dtKmAdIzeOZ/Z7P536uDWsnSOV9SX3rP1/66+00SI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyCdC-00AM5y-30; Thu, 05 Mar 2026 18:37:02 +0100
Date: Thu, 5 Mar 2026 18:37:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <3de08c66-adc8-455d-b23c-b3464153b38c@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
 <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
 <7365618.GXAFRqVoOG@steina-w>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7365618.GXAFRqVoOG@steina-w>

> > However, this is a multi-giga switch, with high speed SERDES ports. My
> > guess is, a SERDES port is used to connect to the host, not RGMII. So
> > i would not implement this, until somebody reports having a board with
> > RGMII connecting to the host. KISS.
> 
> We intend to do exactly that with this switch, just because the host
> doesn't support SGMII, just RMII/RGMII.

:-)

Then i suggest using {rx|tx}-internal-delay-ps as Vladimir suggested.

     Andrew
