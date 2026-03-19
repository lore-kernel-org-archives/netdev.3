Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DDB32571D;
	Thu, 19 Mar 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949997; cv=none; b=cpSGsuHqs29YQw6kwp5I5SKO1J6HJtaOWI62L3rLaJ+WHZIWVC/PqX8aUDxvlxB9VnxH2Eyma/Qo10NbZbftrwEAsYixpHLdlufMccOjEWpOkWwe8D8h0HLj/v8kuLvQBrWui/KtpropW0J3vULdVnODGaPabSw+FqIWqj8HCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949997; c=relaxed/simple;
	bh=LvUjnJyYsDx/TG591wwIYhQQJQmtFBbv0OLb4l6ZHBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKpBwAsmXS1JOWKFZ86ncOUDgusonEL3oacBbsdYwnYdKAGFQqbNBQ2MQG/9pSrFEnNwu5cK2JuQIklnlxhx4eK/IwbWxmkMw9Pv2Mino4cXMVURE+mv8Vz+xdkRpegaXIdNd2MGC9a+RQnBrADphBIdLuwmcnW2XHmzNX1/PkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wl7g+DrZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wl7g+DrZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZpXwRW01ZNFzDB9NgODHrS2uUX86e3mO4LWP42BM1Pk=; b=wl7g+DrZ0NtI3arXFXd+yqe67x
	NgLyezRd65oMlLPis+qa60sN6GzQFE12lzghKxq2hWcT+ufiHjz3B7MbtmabSQavT7B+EY4IWB7VB
	R0SQS+R3WbUImZ/+0WWJo1ANlx4RkomcSS5YuUGtmxfoDuvDr/+g0diEErmyuA8FM3pY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3JQT-00CRS0-Sl; Thu, 19 Mar 2026 20:53:01 +0100
Date: Thu, 19 Mar 2026 20:53:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <10f97968-ddb7-4a96-b08e-d4355cf82a79@lunn.ch>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
 <6dc9a358-4140-457f-bdfb-b4fb22aaf88e@lunn.ch>
 <abxN9aGnCYA6s13u@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abxN9aGnCYA6s13u@bby-cbu-swbuild03.eng.microchip.com>

> My idea is that if someone wants to use whatever is the hardware default
> or what was set by the bootloader, they have an option to do so. For that
> reason, I made the clock and the clock-frequency optional. This is
> something I can do without if you think it will homogenize better with new
> drivers.
> 
> Now I just realized that I can achieve this by just making the
> clock-frequency optional and not the clock.

It gets complicated pretty quickly, if you leave things open.

802.3 sets a maximum of 2.5Mhz. When this driver takes over the
hardware, and there is no hint from device tree what frequency to use,
but the hardware is configured to 50Mhz, what should it do? Trust the
bootloader? Or assume the bootloader or something else has messed it
up? Same goes for 1KHz?

Is the hardware default documented in the datasheet? Does it default
to 2.5Mhz?

>  - mdio-airoha.c: use 2.5MHz if not specified

I personally would do this. This keeps you in line with 802.3. Anybody
wanting to do anything else then uses clock-frequency, so the
intention is clearly documented.

	Andrew
