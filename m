Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855993DFC7D;
	Tue, 24 Mar 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345888; cv=none; b=Ujh9PTi7DV5c4z9EXp40fcobnsLLymjUSDLYE8XhMKwqhX+L4KRVmGje98W4hzqhHF0GjGocENQ1691V6qKVmZfc+vZWW1DUrBesa26tQNh9UewyemmWVT/XyzSYxU83T3FQEOpoMdjgzHNHOdrLLFF2Iu0q7t8WVlFkBcluCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345888; c=relaxed/simple;
	bh=Ju8aKO9buetkPVG2aGq/PNZJ2j8APDT4HWpcPMHbRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmn7s+85xcxlFAzoYCEgrbZa8W6nfAQmXMA/TLoU6jZec9T1txEs4yhgfrv4099YqfySs2NNdQw/3K9c2UDPvpnJ0R4SyVFHgKAcn+ZJLM7CS68yUvROpl/9N6Lg8yX2iEZjNkp1rGaZRfN8KhCerfW2BQ0MdVb2cxwnsxWAWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U46ofiAT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U46ofiAT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qM7docOz3+I2UfqJvceRPUIWzXOJQc92AP8ly2Gule8=; b=U46ofiATHLoxKEf4Yy73zNPJ1f
	JKHxWCjmWY3V+JggGvOa2auChkoOlNseqvnK4KxYP2+txgkdW6lKHd4EUuG0tp/qojPQGmbPd0vRo
	mypPEA3vT+mmT1sK3ao4nshMYjiDHpdC6470aaQKI9JSDROWEFCoNL7SaQ3yEY1mX9ElqViLalKSC
	WVJTQXtrk60btewfEUKLWCIDQTbevX+C0wjQa2hOOpfZd8cH8LxBUvEmpctJZ7LJRgG8XzI8+j6ce
	E/IaffiqP+Wjfi8GzxZMsjTQCHyhzqkQP9cyClWU+Lw52ugeSP3yIyiSrbr+jCliAp07mqi1SsPfD
	Z66GwNsg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56012)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4yPv-000000001ia-04nV;
	Tue, 24 Mar 2026 09:51:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4yPt-000000004y8-2A0m;
	Tue, 24 Mar 2026 09:51:17 +0000
Date: Tue, 24 Mar 2026 09:51:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 4/5] net: stmmac: dwmac-socfpga: get the
 phy_mode with the dedicated helper
Message-ID: <acJelVznH_OUwn9A@shell.armlinux.org.uk>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
 <20260324092102.687082-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324092102.687082-5-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 24, 2026 at 10:20:59AM +0100, Maxime Chevallier wrote:
> We enable/disable the sgmii_adapter in the .fix_mac_speed() ops based on
> the phy_mode used in the plat_data. We currently get it with :
> 
> socfpga_dwmac
>   ->dev
>     ->drv_data
>       ->netdev
>         ->priv
> 	  ->stmmac_priv
> 	    ->plat
> 	      ->phy_interface
> 
> where we can get it with :
> 
> socfpga_dwmac
>   ->plat_data
>     ->phy_interface (done by socfpga_get_plat_phymode)
> 
> Use that helper here.
> 
> Note that we are also being passed a phy_interface_t from the
> .fix_mac_speed() callback, provided by phylink.
> 
> We can handle that in the future when dynamic interface selection is
> supported. We'd need to guarantee that we have a Lynx PCS to handle it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Nice cleanup!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
