Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61746459ADC;
	Tue,  6 Oct 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291939; cv=none; b=YdtVNXrJWguFql9VRRomEegNtO8q83yrztw4IpQyeNOd0GCuzF2bmImR6FrNv5zVCUBzHid8rhio19soQCWiBFwgs/0R62GKecwu/VTLy3w10ntRVvHtWOeSGR7SQ5Yk729F565J7MVKg8XZK/JBpjfsQZCcbCBIr/jrGpA3H8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291939; c=relaxed/simple;
	bh=MGiultBOuqRmL7qBHpb+pJQ73KIxYkC5pkeXcC2F2b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZoIkWmnAdtHCs5sU8PvvYNVepRXtE8GEaGPVuL7SjUhH5u9NvdIaJVxn0gjivrTmqDWaCO5t3bYoLDz7v85y6u9jZTqO8XgrT4PiSwrzqyoC0+2XVvWbyFg/3bcVRMpVxXUXbzocjtP6+/Wicq9TlQ9i8q1uZ4aFtbxQ7Yr0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=30W+rHrM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="30W+rHrM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xSWqE/JaJxUwkDfIRPzTHJ+p4Qo0eZDPBOfDxqG1+xM=; b=30W+rHrMpVQ8icuBWUSutdD2PW
	u5Lr5PrcwEE69yC5zcgVWMg2VVqHAfHo0cUP+yjozzTw/dhssTII2AdzQ6wnbTDIT3NEZzkbDPSfz
	i57CKdO1ju1JhjnQx8dJ1pKWgiQx/cOPNdv/+ON2Nvdk8RBmyujhr67s23WsYwmJAUVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE4rB-009GRf-2p; Tue, 06 Oct 2026 15:05:21 +0200
Date: Tue, 6 Oct 2026 15:05:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 09/11] net: phy: ncn26000: Support for
 loopback
Message-ID: <7723127b-a713-4e96-bb63-fb2dc5367560@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-9-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-s2500-mac-phy-support-v8-9-7e011aacc309@onsemi.com>

> +/**
> + * genphy_loopback_fixed_speed - Helper to modify the PHY loopback mode
> + * without affecting any other settings.
> + * @phydev: The phy_device struct
> + * @enable: Flag to enable or disable the PHY level loopback.
> + * @speed: Speed setting. Not expected to be set. Error if it is set.

Naming is hard, and i'm not too sure about this one.

fixed_speed could actually mean, fix the PHY to use the given speed.
It is in fact doing the opposite, the speed is not fixed at all, it is
left to whatever the device supports. In this case, it just supports a
single speed, but that is unusual for PHYs.

Maybe call it genphy_loopback_no_speed()?

This helper is also not what most devices actually want to use, since
it only works if the device does not support autoneg. The "without
affecting any other settings" is not the best way to describe why you
would want to use this, not genphy_loopback. Please expand the
documentation a bit to make it clearer why you would want to use this
and not genphy_loopback.


	Andrew
