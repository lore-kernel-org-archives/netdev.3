Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532075;
	b=lWO3AGAQzJ+l1xramrHaLP1gaYpMWofvzEWcvkLSzubcy8lW8BOJPUaQ9J6QfwYq8kI7
	 gXljbYzfqsdoQesKzOHSpC972Zu5O+eZuapd1takSkKCOIIEhZ4Ivtl361UGLfS0Y12+H
	 OT8IAypW/eyIOOw1pDz8A3myX5XMRDxz6Hb7Gls7npK7rwFoG64VaxMjYbPDvFo4JYbYO
	 cSWAbm6dCy4UqhXqm/OzhlEJc7iiEvkH1Emr3OfZl8UvYm6FVxZls4B6cUFyNYuqb5gw6
	 LTkMtEtkJ1vA3Kf4/Fb2gpm/C8IKXeeiFE5seoYYFUyyNPIZzMaoT3liropsIK1mRiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532075;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=SeGWYFi/n0Lblm9iaCke+B2p70tFL4hdkNwQxuOUa3U=;
	b=c95Y8xsh8vXkJD1QtR+0umZDUOtujhrHX4ji90I0AfV6ta6A/ds1m8Cc7iD+lBLDikHS
	 Obzb51WtGni4AfcF1hm+55t/PxCP7C5BW+CgR8IY8HmJxZbxG9S+AIXC/fwV4BIMQV186
	 bMPDXZ8oS2IN7Pib5c1vOBKDqG8g0lE+rApt9vgdG0kn9wfZ2xLr7SbDv9ynLOZgPqA8W
	 bSKcnbppHh2L7aIVc5ZuVtMrDWCDpJlWPIUqj+Ap0V3+MiXdWlxD73d0e/rE7Pf/dBeRD
	 1rzLvvwoSo+2SXDKDUkaYQcDcC0fgwHORHJyjO9jp0J2s8WIt5tmR74S6d+J2ZaLDcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="xF/ukmbf";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400D606A32D;
	Fri, 13 Nov 2026 01:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9400D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xF/ukmbf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SeGWYFi/n0Lblm9iaCke+B2p70tFL4hdkNwQxuOUa3U=; b=xF/ukmbfd3uVVeWQFwYi1kzqzO
	exrzeAT/DJipxxiBU8mABEJQCso/XVuVIsm/aUwekV3vJfkhJY+KreQxXz7FjCC6DNrIZ7QhgADP+
	4XOkfe1cavOY6fWNJkMnoTQgrN2XTVZaeA6hi+3PHqp3LeVCs4lURqL3eNfcsBKfksGM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRflR-00G9Eq-3H; Fri, 13 Nov 2026 02:07:37 +0100
Date: Fri, 13 Nov 2026 02:07:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 16/24] net: phy: Add Sanechips ZX5201 PHY support
Message-ID: <95e7fc97-2bd1-4b68-a9ef-246302ed9ec7@lunn.ch>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-17-ghahramani.navid@gmail.com>
 <788c9b01-473e-4c45-b6f0-b2ba054da8e9@lunn.ch>
 <20261113003655.3665572-1-ghahramani.navid@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113003655.3665572-1-ghahramani.navid@gmail.com>

> > We need to understand this, because if it is an RGMII PHY, we need to
> > address the RGMII delays, which that page says it can controller.
> 
> That part I still have to find out. My driver has always told phylib
> gmii and the WAN port runs at 1 Gbs, but I have not worked out yet
> what the link between the SoC and the ZX5201 really is.

https://www.sanechips.com.cn/en/Products/WiredEn/fixedNetworkTerminalEn/1558027080778723330.html

This says it is RGMII.

> SerDes was just the name I gave the registers at the second address,
> and there is no public documentation for them. I will find out what
> the interface is, and how the delays are set if it is RGMII, before
> I send the networking patches again.

So picking SERDES is probably causing some of this confusion. SERDES
implies there is a PCS, and the PCS is doing signalling for SGMII or
1000BaseX. With RGMII, none of that exists. The registers might be
controlling clocks, or regulators etc.

https://www.sanechips.com.cn/en/ProductEn/WiredEn/ethernetConnectivityEn/index.html

Also says RGMII.

     Andrew
