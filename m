Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC25347536;
	Fri,  4 Sep 2026 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788486240; cv=none; b=cVWKOo4NdzB1bpWgjkuvwPDkkbFifxYUIDEX2k7a7xhQQKgkihbGZbgI/hWtOJiBGG41XGSG05uWDeI1/RHlA3eIb0AlZrFuCsTKEeldYYPYL7iZPw74tubF2+SmRNcM9iUHWWfzlwZtu8/khDucz+zDPHkB/tVvS3Fy1CRoD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788486240; c=relaxed/simple;
	bh=AdJLmpAFuK8x1Y/0XJQvufQwFe8ZC7cSctQMc+gDSVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8+osK+rPplb/TVgb1q7DMm0yPce30lJgJ6+kOfIVxDHw+e0jOplrrW1FQ4j+1Ds+uJN2PbUTn5nXXUQeQtWzTf3gZaOI28CVI18BdcOqGjoWcUPyw0/LCb1V9aHPsBVAbqat4WaI6nweyG8/SfoAY3DccvTorbu6hIrOv876Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wJxaOdaV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wJxaOdaV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/dQiqbcR8vn2iti6+8xRgjt3v4roCt+kRO9rD0/T9Q8=; b=wJxaOdaVRNPTTVKg8wvYkkWmMf
	4Z4R3H/VmNGE7PeCEBMs9NN6tymsnA7BIWbaYiTwj3WENn+gRBVJGi6NDMvNa85tnjXCkr2cx3fBS
	M+L5R9kY+TCEW3fmGCrpTGLhLvkTflEBRgmFXjBLEYakKqUkOeZi7PNMb+iNbUgQ/zPQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2Iy7-002pau-QZ; Fri, 04 Sep 2026 03:43:51 +0200
Date: Fri, 4 Sep 2026 03:43:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 7/9] net: mdio: en8811h: add the nested
 pass-through bus
Message-ID: <89e7053a-3c03-4411-a5c1-1cf050125b2d@lunn.ch>
References: <20260829052546.1152446-1-f@lex.la>
 <20260829052546.1152446-8-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829052546.1152446-8-f@lex.la>

> +	bus->name = "airoha-en8811h";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> +	bus->priv = mcu;
> +	bus->parent = dev;

Maybe set bus->phy_mask.

Also, copy parent->irq[addr] to bus->irq[addr], so that interrupts
work.

	Andrew
