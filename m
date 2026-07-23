Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0412BB13;
	Thu, 23 Jul 2026 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769199; cv=none; b=RaCf8Dapa7Jk85rM75vt0S5RFGtCouJ0zNzrHDrJl26/Ablc/aiElaD72Sbu2WVNR0S3g+EYV5C4P7q/axeZ7TcLP8BDsEyy0LRv8M1gbMt4LDloQJFXFSix2ndFKNbokrA3Y1DOCalT9L24gKCez+oDzztDnbzPB4iUEdQsYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769199; c=relaxed/simple;
	bh=Ob8UC9O4EsxULGJIxQudc7T4cx4VsGoToptVsHdT+aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKSzepcBpYSEv9q40MRx1xGRNgPZX08Agjwc+JGFJSyZjwAjNH8RE5mBii42L5aRmzM9iCi8ziS5BACvAlUUVSt7t7qTYSv2G2S8+pBOdn+nJY6B1nE7S89r7Peo2OdbfeEsXjYtGMCE+WyLPVmFBW5YDKsLLfxHUhOko2zFgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y3vsnf79; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y3vsnf79"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1hhg42kdhfDZi5EATxLg1/9iNGwNoBnW1agkoiGFvRc=; b=y3vsnf79+rwUnf9LBY1jVtgHml
	clP6XHvbufisfpIskHCxZSZzdvd/uslcFyIMcUnfvt9D+k6XVfwh17yakc2fMzTQn4bTh7ztb4Yza
	BUat+Py61RCEw6d7Cq6j88Vw7TiWJiYdE5H5At8fI/MSFG9Gnu8vcMQL+68JgLbiHcA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmhzk-00DifQ-Nv; Thu, 23 Jul 2026 03:13:04 +0200
Date: Thu, 23 Jul 2026 03:13:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v7 4/7] r8169: add support for RTL8116af
Message-ID: <ff90f295-31df-490b-aad3-1bba6ef0ab5d@lunn.ch>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722022906.271-5-javen_xu@realsil.com.cn>

>  static void rtl8169_init_phy(struct rtl8169_private *tp)
>  {
> +	phy_init_hw(tp->phydev);
> +	phy_resume(tp->phydev);
>  	r8169_hw_phy_config(tp, tp->phydev, tp->mac_version);
>  
>  	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
> @@ -2562,7 +2607,7 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
>  	    tp->pci_dev->subsystem_device == 0xe000)
>  		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
>  
> -	if (tp->sfp_mode)
> +	if (tp->sfp_mode == RTL_SFP_8127_ATF)
>  		rtl_sfp_init(tp);

This could be diff getting me confused....

You unconditionally call phy_init_hw() and phy_resume(). And then if
this device should have an SFP you do something else. How can a device
with an SFP also have a PHY?

	Andrew
