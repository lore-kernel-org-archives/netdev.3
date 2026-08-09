Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEE23EAAA;
	Sun,  9 Aug 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289698; cv=none; b=SG4X0XO952T+CKUYlApJ7qI35DSI0gUylZ2V3toszq/8dhdfe0ted021t1saRwgberj98atmwyYkkXyYQqPY+moQdvxfvxjolnYHxy3hHbBBZmL9vb1YDPzLBhVZSfCSD/ALbrgiLaP2GDB1U2oBdvKUhXYbdT1diWkH/G16MvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289698; c=relaxed/simple;
	bh=bBBR+KEozpcjPBzN1uRPL4I8omNTkgl5swN/UhzMgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onj3ctrRwkvXErdG2QtL9/CJkxNPSRN8gDJv9wHM/CBBKNCEBkaQ58fkWNGupXR83UBVEYa1r5cjEwbt5cNl01v2cW0PInAa5s4xBzKJYvL/P0DDHSLqgY1qCzhN93QZKaQqqn2Ee/SQWISCPD8bG2QqxrWWKYxab3p8CeZPHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ncx+9eVI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ncx+9eVI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dTUBsWZFIsIwqxnoOusq3cuwh01JC/V2VN2RCCat/k4=; b=Ncx+9eVIhu6pr3ocToEyYR0NGG
	mbo5p+4miJMErQlpGh1B0lttjc75uPUNBCjnZf8FvHsD9M4sWSUtWUIXZu9T7FkpBVGGHSa2LwizY
	oKbbW+yt3TdlfkyyAbO1XH6esQru+DAKCUM90D/1A093Pm2rsAQquuO2cHCdjroTE0g0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt5Xx-00GpBt-BX; Sun, 09 Aug 2026 17:34:45 +0200
Date: Sun, 9 Aug 2026 17:34:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: mfd: x-powers: Add AC200
Message-ID: <0cdd9998-51e7-40eb-8c01-54684f6944dc@lunn.ch>
References: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
 <20260806-submit-acx00-of-dynamic-v1-v4-1-9bf2f7441632@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-submit-acx00-of-dynamic-v1-v4-1-9bf2f7441632@gmail.com>

> +description:
> +  The AC200 is a mixed-signal companion IC containing audio, video, RTC and
> +  Fast Ethernet PHY functions. Its control registers are accessed over I2C.
> +
> +properties:
> +  compatible:
> +    const: x-powers,ac200
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      AC200 input clock. When using the Ethernet PHY, its configured rate must
> +      be 24 or 27 MHz, matching the rates encoded by the documented EPHY clock
> +      selector.

What is the scope of this clock. Is the PHY the only consumer?

> +  ephy-vcc-supply:
> +    description: 3.3 V supply for the Ethernet PHY analog front end

This sounds to be specific to the PHY, so the PHY driver should be the
consumer, not the MFD as a whole. That then would allow the PHY to
perform power management, turn the regulator off when the link is
admin down, so suspended.

	Andrew
