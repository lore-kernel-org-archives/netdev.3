Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6731FF1C7;
	Mon, 30 Mar 2026 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875679; cv=none; b=dDsMi+8vFm04/OfR70zW3gsmtQdIyDbLmonmu57N1tvi9q9htc1t4o1sVAdvS4DGAm21JCylSeIIiHC+IdPweFpMi8cOvBHQJfi3E5MMSyPbXID0WZGOmxe0LCuWeu493VmAvH+bu3mUaWveGf5Ofkb6iSbMMYkJHRMtSVpxeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875679; c=relaxed/simple;
	bh=nP9f1EqIPdqAMjlrltvj90GqZmirg/40G3V7UFz4aiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc7rfYevqKV7NQxQIXQ0BzcfWyLQzwAei818kSTQRLQe97XT+un/wT/N6nTeGzVB/EV/l7zRbBptj+q9qYs2wkX3XuP6EYTjZBgFDIDnfGMP936Z+TcicwZzQxzKyxkIbTiaR+Q3Aa9dvLYU1ATcu83qVUKj8gmNPVZUWW2lEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gYzAgezo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gYzAgezo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SM5++uahSjWdn9lZl3+feCFnrHEokV98lFnyAP0vFD0=; b=gYzAgezouYEkgP4jpnvkVpjXjm
	8XGi9C4EHFi8z6P2L1cm1g0BQtuY4ce4iSU6IbRdhROXshGXo4R6IHaIDVhDotFiSvO+ekJbZwPcc
	G7f1ylCE+xjaFAzrOJgfHhO1HYS72PadscKYmaPGoP8TlcP41590zq7O6nmRRz7E/HHQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7CEq-00E29h-2L; Mon, 30 Mar 2026 15:01:04 +0200
Date: Mon, 30 Mar 2026 15:01:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: microchip: add downshift tunable support
 for LAN88xx
Message-ID: <ea58ad33-ac25-4907-8fa5-167479070b97@lunn.ch>
References: <20260329224202.500229-1-nb@tipi-net.de>
 <20260329224202.500229-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329224202.500229-2-nb@tipi-net.de>

> +	switch (val & LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK) {
> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2:
> +		*data = 2;
> +		break;
> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3:
> +		*data = 3;
> +		break;
> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4:
> +		*data = 4;
> +		break;
> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5:
> +		*data = 5;
> +		break;
> +	}

> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2	(0 << 2)
> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3	(1 << 2)
> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4	(2 << 2)
> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5	(3 << 2)

It looks like you can replace the switch statement with a FIELD_GET() + 2.

    Andrew

---
pw-bot: cr
