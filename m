Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC613D5228;
	Mon, 29 Jun 2026 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751097; cv=none; b=PlFJX6Be4IxNvVIP6KjLYAJzyTc0gvGJjq1TIAnigF6fw5e1B//91A1T5E5QIX1pO0gikWY6rm6jjskRC6t+EDshHTnv8kvOJkC2bCl+Pbd3XUsec2Kz1mvfZ0SR6vtWapt7TyQe6UpS2ttmezQDpb7JrfcPKjwNVSIa6iXqlmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751097; c=relaxed/simple;
	bh=pXdEEBimIbr7xxEckypyquPWKpgN4m2iam7gQ9Vn+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5fA0bRYOJAUrQiKSLqaVUbV//GerahWdZrk4R0rKuzAs1GrziuANojlsS/eHg/+byUer8b1bClngSXYNxL/O3Aki+1xkbLIxIDZnb9tFhNO9Q9q63FZar+TvguSgFdowHPQF/UoX8AdY/f7d+2nKrTGameD1UD7PzxTQyx3hLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nMMQuAIc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nMMQuAIc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f2klZqYr1KN+TL+pZAqIoiMZ6Uq1Px+Pfvk6vZjAQH4=; b=nMMQuAIckQuHCwzXCJakWo5wM5
	7LaNmTJyDtP0yQ581xWvDQXFnH05FiUAsQHsEkf2y6EeDqJMfBRx/BuTNLrziXDeXdkIp0PEXt5v+
	2PLC/mg57qH86oIvK3IaP0zeQVgs0ga95kjCh4RU9GuCIDvoHxmdiFk+Y0DWfhZmOoqs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weEzh-009mqJ-U5; Mon, 29 Jun 2026 18:38:01 +0200
Date: Mon, 29 Jun 2026 18:38:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/8] net: mdio: realtek-rtl9300: Configure
 hardware polling during probing
Message-ID: <6f0a60b2-5083-46c5-aae4-3197d66007da@lunn.ch>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
 <20260629152336.2239826-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629152336.2239826-5-markus.stockhausen@gmx.de>

> +static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(phydev->mdio.bus);
> +	int port = otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr);
> +	int ret;
> +
> +	if (port < 0)
> +		return port;

Here seems like a good place to check the PHY is a realtek PHY, and
return -ENODEV if not. That should cause phy_attach_direct() to fail,
making it impossible to configure the port up.

	Andrew
