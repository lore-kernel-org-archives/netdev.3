Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F133E00B4;
	Fri, 25 Sep 2026 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377865; cv=none; b=nfGDW6RNo97IdJfJhInKuTz9s85eA/w2I//gAUBSvX01DWgvILC5rBbSIyDp3oulcEYZCIbKUlzIUPPauFDSLCT/kVcTQw1fD22PRkxk1VheUOkCq/GCkEZ5PozBvCXstFX5sZG6flYOQ/pjX5QnwpoUDzDGTgQHNR3RMHnvJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377865; c=relaxed/simple;
	bh=WDuhiKoto+GckTuEBZVglaXPfxxrI3TMeVmIEz4ttGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niRGNSHGNf2qZb1KnsEEx8InGLPCy5kKx4TwRfW2Yw85Go9G+3/mb02IvyF8CbA9owb8rVWuNKvmLkob5Yn4K6e3x+5KH37rt5dPQJz5hKuqvewa2S2zRZTB4SHdQh1XS0y1lc/ocLM3VvkGrjtZ4UZnN2F3fu/IhTKsqirDKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4JtgAefU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4JtgAefU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IGuHgtxJPba8b9kLu8sf/C1GQa9JsFH4QyigTFqdx9o=; b=4JtgAefU6c/DWinFRd1OJq8pLp
	ds1uVQMYpNQshwUYpOvGh02ngxT5IxYmZwT1N8WeW7JoSMX+mi0pvEsbqotIdRkdlutD9ePOwWbMI
	H1IAGUOcvi0Wh6Y7VyuDXNCvpswx5/jDbGYCPVyNrfz7MLU7aXSWpS/SsD1CEJFdJe2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAF4B-007KAX-Fh; Sat, 26 Sep 2026 01:10:55 +0200
Date: Sat, 26 Sep 2026 01:10:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 5/8] net: mdio: Add SoC-e SWIP MDIO
 controller driver
Message-ID: <e4440c27-5551-482c-95ae-9b75481bcf7b@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>

> diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> index 048586746026..079b46dea25f 100644
> --- a/drivers/net/mdio/Makefile
> +++ b/drivers/net/mdio/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
>  obj-$(CONFIG_MDIO_PIC64HPSC)		+= mdio-pic64hpsc.o
>  obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
>  obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
> +obj-$(CONFIG_MDIO_SOCE)			+= mdio-soce.o
>  obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o

Maybe the indentation is wrong here?

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
