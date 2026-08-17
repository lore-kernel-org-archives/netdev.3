Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAE442377;
	Mon, 17 Aug 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984887; cv=none; b=F3cyupJVrlq7TA5reM67NF4zqAHGXrNDIqWC6tdfBGacVHr1o+eYHktRuFlKuYjRZCBc+MhuYiFEqnV4Zof2rjFHjLknrVlQQ2QRtuC51hXEtfj0ANHAgfIxMEU/LaqkAwBRiQr26GOizt79bMETT2HaVqfWfw9/y6axGjxSqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984887; c=relaxed/simple;
	bh=YefWs10omkpXFntnRM+AJiT+L3apLCmMwLdYEEVQ6G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndSSS20uYeW40lZhkGvBHgx69LHOU8PKIHvIFeXqMqkNPY8ccqDyIisuLmPIEEIUVW4u7ffsBahP2rYi/wtvifmav8qsL9TL2LgKjdTZFsmWpNvJndQCSYBW/qSBTL/PNFXibTUCSfA1/paNgIYIUHSoQKBnselXUyjSz1gRec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zikAsAJr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zikAsAJr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LaKbhxdXvX8tknig+YsLj2T2XA3CrangdxPpcV3Aans=; b=zikAsAJrvLBdpQn5FdD8udPg6D
	TugwlwJu+3rcLRYouSVnhVLcaR6rUH+hRz8QNKe6UZcQL53TJW07XntDYagqjVVAOUwZNlq0ilogW
	hLhQRSYMVs7VN2dRq+TXy+SwQiKjvftEDoBkkI5E6vnyX7MyDrALUd9Cwj0KTJ5cyw+4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww0OS-000LDX-Ce; Mon, 17 Aug 2026 18:41:00 +0200
Date: Mon, 17 Aug 2026 18:41:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 04/13] net: phy: add phy_detach_internal()
 helper
Message-ID: <5d3ecdd9-3721-4710-a1c8-e48a2a020799@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817162632.1208891-5-markus.stockhausen@gmx.de>

On Mon, Aug 17, 2026 at 06:26:23PM +0200, Markus Stockhausen wrote:
> For the upcoming MDIO bus notification enhancements the PHY detach path
> needs to inform the bus about these actions. Until now phy_detach() is
> called normally but also in the phy_direct_attch() cleanup parts. So in
> the future there must be a clear indication if a notification is needed
> (normal path) or not (cleanup path).
> 
> Carve out the phy_detach() code into a new helper phy_detach_internal()
> and make phy_detach() a short stub that calls the new helper.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  drivers/net/phy/phy_device.c | 165 ++++++++++++++++++-----------------
>  1 file changed, 85 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a3..835d71306b4d 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1734,6 +1734,91 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
>  	return phydrv->config_intr && phydrv->handle_interrupt;
>  }

It would be good to copy the kerneldoc as well, since what that
describes is actually performed here.


    Andrew

---
pw-bot: cr
