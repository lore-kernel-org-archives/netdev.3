Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034B3C5540;
	Fri,  3 Apr 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228047; cv=none; b=uOfPKgmCCvIMXhP0XwY97NA7v+ALQxP+9IturyOq64SMBJlD6wO7kFceFbUduhLH86tpQK4GcmJrFNVs6wfD+Hv+tjllNgySaoSpLB+DWakIkFHnQNco8gMJj3AGoXv7ErmoAbTlrMLvVt2xwgSoqn9etYxkkypjd7e6boUGOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228047; c=relaxed/simple;
	bh=R08rVJlTdruqD6FSMDDUzmCr/ZjtK2uR0Lro7X9Gj0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epAbZkWL8ThlFha1/82yFA051u0ee7jmA7V1GhIa9RblGJqUF5mvWbRr7FfLSiiVSQeqRYC3IwrP39paXXF5vWX8JXIraNJKvVzkr0NASs5fvx4an0Jigpu34OLhKdyfWe77Zq1KbgogxwE/70maUHYH4HsbH8MPSq7MWeBI2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QKd0W4Us; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QKd0W4Us"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xpf6gNJ8L1cd23U5E7csKeaV0ZNA9Z8Ukut8ksbXGvQ=; b=QKd0W4UskDmj83tw1B2mklmM6o
	Jl6qc2vSVnqb3lVx4IPtTJ2WMVYx/Cus2IoE7ffkoBPWstiMV/Ak5VtLQW/i9BQtlvqp3B/dLOTlT
	eOENonj7EKF8IS7/tZ0lbMFw0ybA4+oiUMqeSHSc+bLh6r6TXHzjafM5T2ZML58AR2rGTP6S8Fhvt
	rzBoMmZ2+UR1FtTUWDJ46OHfwqmAgwMxSjhlj1t3bPE5cTgQkZ7Q4zDq1SuUOi2slKUVxPLT2atk7
	9LI9QLzvE38RJ9FKuj0pS4D3CUArMfDHYltINaoBUegWP6asYPFBWDuobp2vuPBNsS2LsvXu48DCA
	bIwfQUKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47544)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w8fu5-000000005kl-3PWM;
	Fri, 03 Apr 2026 15:53:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w8fu2-000000006pn-37h4;
	Fri, 03 Apr 2026 15:53:42 +0100
Date: Fri, 3 Apr 2026 15:53:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	biju.das.jz@bp.renesas.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net] net: phy: micrel: Fix MMD register access during SPD
 in ksz9131_resume()
Message-ID: <ac_Udvtrj0Bl-6wl@shell.armlinux.org.uk>
References: <20260403111738.37749-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403111738.37749-1-ovidiu.panait.rb@renesas.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 03, 2026 at 11:17:38AM +0000, Ovidiu Panait wrote:
> During system suspend, phy_suspend() puts the PHY into Software Power-Down
> (SPD) by setting the BMCR_PDOWN bit in MII_BMCR. According to the KSZ9131
> datasheet, MMD register access is restricted during SPD:
> 
>   - Only access to the standard registers (0 through 31) is supported.
>   - Access to MMD address spaces other than MMD address space 1 is
>     possible if the spd_clock_gate_override bit is set.
>   - Access to MMD address space 1 is not possible.
> 
> However, ksz9131_resume() calls ksz9131_config_rgmii_delay() before
> kszphy_resume() clears BMCR_PDOWN. This means MMD registers are accessed
> while the PHY is still in SPD, contrary to the datasheet.
> 
> Additionally, on platforms where the PHY loses power during suspend
> (e.g. RZ/G3E), all settings from ksz9131_config_init(), not just the
> RGMII delays, are lost and need to be restored. When the MAC driver
> sets mac_managed_pm (e.g. stmmac), mdio_bus_phy_resume() is skipped,
> so phy_init_hw() (which calls config_init to restore all PHY settings)
> is never invoked during resume.
> 
> Fix this by replacing the RGMII delay restoration with a call to
> phy_init_hw(), which takes the PHY out of SPD and performs full
> reinitialization.
> 
> Fixes: f25a7eaa897f ("net: phy: micrel: Add ksz9131_resume()")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
>  drivers/net/phy/micrel.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 2aa1dedd21b8..4236dbf4ad6b 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -6016,8 +6016,13 @@ static int lan8841_suspend(struct phy_device *phydev)
>  
>  static int ksz9131_resume(struct phy_device *phydev)
>  {
> -	if (phydev->suspended && phy_interface_is_rgmii(phydev))
> -		ksz9131_config_rgmii_delay(phydev);
> +	int ret;
> +
> +	if (phydev->suspended) {
> +		ret = phy_init_hw(phydev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return kszphy_resume(phydev);
>  }

mdio_bus_phy_resume():

        ret = phy_init_hw(phydev);
        if (ret < 0)
                return ret;

        ret = phy_resume(phydev);
        if (ret < 0)
                return ret;

where phy_resume() calls your resume function.

If a MAC driver is handling suspend/resume by setting
phydev->mac_managed_pm then maybe the MAC driver should also be
issuing phy_init_hw() before calling phy_resume() ?

Which MAC driver are you seeing a problem with?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
