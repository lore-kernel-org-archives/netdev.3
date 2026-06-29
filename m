Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A0426ECF;
	Mon, 29 Jun 2026 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750542; cv=none; b=uO0kgPcWzKyoLqIUhPfaIQXnxD50oY5CA8l+3opE+0dLT4vJmDip847xu+q99LB/N+QjS4v2+96jIQ6GuV9BlGQ6/cmXzaOJrPG+MVz0M1IICl3YfWwqPcDo5XcoVrm+S8uz4IWZQKc4u3IcQgPfrqQ8Iovo7vRutEghcQQCjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750542; c=relaxed/simple;
	bh=v+ZzzwyTZpCd3A9wLJNj/5QREFo40R32KmC0KRi4trI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Obf7md6Lo8ggoIif5l7xfQA+/SVIwm6y6sgUzfBfqwMgp0Bn63Z1cm/54wGTSp70k5l0lqc03OGW65hvLjrRFedMmydmY5jcLQSIwtm7hb8dUXSf7h6jVXyNJa8cGJI2LtixlMJTExO49th/WKFQjNhGR+nxfqkJCoqvtAbcy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bLn6iDGC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bLn6iDGC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lkQrR2HpPgR/4lUKYt2XGoq32UZZpopn65LXb2S9Gvk=; b=bLn6iDGCIGIthV8lH6CA1r1R56
	LWrmERqrTdeCOoN6Ta7IXP0Yuv6NvPF7DPhnIxw+5dCTL9CG8CIcPArIx2KRDV2DW25MVQZG8SH2T
	5fDuA1PCiEQMmNncnv93Ge1bYj72X923k1/ZpV/HpXD3T5ly6gdGlKaXtrEU2iK4oY2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weEql-009mmn-0P; Mon, 29 Jun 2026 18:28:47 +0200
Date: Mon, 29 Jun 2026 18:28:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] net: mdio: realtek-rtl9300: Add page
 tracking
Message-ID: <f3b0ddab-372a-49c5-977e-59c7a104d0a8@lunn.ch>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
 <20260629152336.2239826-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629152336.2239826-3-markus.stockhausen@gmx.de>

On Mon, Jun 29, 2026 at 05:23:30PM +0200, Markus Stockhausen wrote:
> The hardware polling unit of the Realtek switches has a very special
> handling for PHY register 31 (aka Realtek page register) in place.
> 
> - On the RTL838x it is permanently reset to zero.
> - On other devices there is some magic saving/restoring (aka parking)
>   in the background in place.
> 
> This makes access to PHYs a gamble.
> 
> As of now all known existing hardware designs have Realtek based 1G PHYs.
> Otherwise the polling engine and the MAC status update will not work at
> all and the vendor SDK would fail totally.

If you are going this direction, then please somehow validate the PHY
is a realtek PHY, and error out if it is not.

> This driver differentiates clearly between c22 and c45 buses. During
> probing it enables only one of the protocols for a bus. So it is safe
> to assume that any c22 access will only target a Realtek based 1G PHY.
> 
> Intercept access to register 31 and store the desired value for each port
> in the driver. When issuing access to other registers add the saved page.
> This given, the hardware will run two consecutive c22 commands that are
> not interrupted by polling.
> 
>   ... hardware poll ...
>   phy_write(phy, 31, page)
>   phy_write(phy, reg, value)
>   ... hardware poll ...

How do you guarantee the polling will not get between?

	Andrew
