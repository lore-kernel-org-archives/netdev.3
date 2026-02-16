Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243B2C0F8E;
	Mon, 16 Feb 2026 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248519; cv=none; b=TsoUTeii03SoPLNhLKyiNkFqyNj/+TMQDaAXKY1N5FfYX2Zst9wmyCj6ZK/BLV2ZSaeHf9y2aqQwNj9XKVoETrjWII5FEPH+wl9ECRG6zm71vHxTfby1MRqgofYdOgCuUXg7V346hue8rdf19TlAEtYYyakHhJqZ/4PBeyhxjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248519; c=relaxed/simple;
	bh=MLvnB4LUZrbUzkjPdcQQYfZryqEDpQ9MZHqqk49lMlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uME8jPoAQIcJqus8KZV86KV+dApA0CeokvDpcsX+Okpl/CMxWzTGzzcE4VjlxXoyN//lEGRViheAhILy8K13FQ7VVJps3bG6OIxLbIDoH/xm9pLly8zF1GsbXlj1d4BstH4TN8WRc7ed3Yd3kiInAsTdxy82iX3QbpCrZSAl2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y0zJLilE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y0zJLilE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0IZHl2hkbGFR85ZuJZXZzqjsQVDZ5cXGujPx0TD3CZA=; b=Y0
	zJLilEB51U5QmzqPPV+SnvEutN/zC2C2ULs4oKNi5KEItq9dyhpB67hTgD/Kd/V3PyANSSXIBB6oU
	czho7qXnnSLM3PPZhjN6l3wUNX0iDrkdL/x44S2ty38s52EgAokyKPR4Qxk8xd5Kmcex1w5T85Hwu
	rAm5Yi/B7Ul6LhI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vryeH-007UTK-Ev; Mon, 16 Feb 2026 14:28:25 +0100
Date: Mon, 16 Feb 2026 14:28:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Martin =?iso-8859-1?Q?P=E5lsson?= <martin@poleshift.se>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: scan all MDIO addresses on LAN7801
Message-ID: <5ffa1e71-198e-49d1-9c06-f0c51f620993@lunn.ch>
References: <0110019c5c13b668-dd1f5db3-309a-442a-b483-262c4edbb360-000000@eu-north-1.amazonses.com>
 <d5e4a2e9-4ecd-4103-9537-74fbb58692ed@lunn.ch>
 <0110019c64d659d2-815ad63f-3a90-4967-ac0e-850ec981ec27-000000@eu-north-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0110019c64d659d2-815ad63f-3a90-4967-ac0e-850ec981ec27-000000@eu-north-1.amazonses.com>

On Mon, Feb 16, 2026 at 05:04:55AM +0000, Martin Pålsson wrote:
> Hi Andrew.
> 
> Thank you for reviewing.
> 
> As for the PHY interface mode: the RGMII configuration (including TX/RX
> clock internal delays) is set via the configuration EEPROM on the device, so
> PHY_INTERFACE_MODE_RGMII_ID as set by lan78xx_get_phy() is correct for this
> hardware. The DP83TC814 supports RGMII and the link works well as-is, so no
> change is needed there.

Ah, i was not expecting a 100Mbps PHY to be using RGMII. But if that
is what it is doing, then fine.

> I will resend with the Fixes: tag added.

Thanks
	Andrew
