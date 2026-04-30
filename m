Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC13019D6;
	Thu, 30 Apr 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567774; cv=none; b=XyZXbrSsJ4cHRhoUoBWJptPC28fXRI2pJVRnRE0qZOw/5ASzuc6UWbm6Mq3D0Nn8dNT2iktrDSo3Nde+IKWsTuCZoQQpGiIkSF4mXDGWx/ldEdAye3UIyxWXFe1KD5a1ULLq2KqSrfPHPvk1RyWon+9NHa7TyfejTdL7tf/TRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567774; c=relaxed/simple;
	bh=rc94khdHXYE6Mq0nAe17Y1EGkpWccVgBj7qAQMIerc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IURrdSciZJ6z82ylqui4l/U9JOWUMBd8kY0JHvPr9Z6cFNsPgqUNtLsCQklbLky6PKgyy1vOeHDL5GWMPGdgEYAnSfbD96YQZa+85UHs4NhrYWCHPOCWhraljUiP9fsMF9b81+Tccb4CQKoa4k1evYosDwPFXPsLLHvaS2S3h0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vzaGZftK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vzaGZftK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=chRC1YitdRUSoDJcc7gltKwhvPCsDSDtuA6AljdNUME=; b=vzaGZftKGtnAKFFpd3XDXTahpX
	wGjT0XbTTHqXGEZqIw/jT8ikVEKkagbRGl0mZZxf3NZfm/1NdPDNCKiceVi2XRCoUlIdEvunlCwIq
	Rv2ZcebwZZ3af0uUhKRB5Ok7oaV3FbrZo2YA3XcjNds8hQxCzjwlmfpS4968ERwpm8dM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIUZj-000iG2-Gx; Thu, 30 Apr 2026 18:49:19 +0200
Date: Thu, 30 Apr 2026 18:49:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch net-next] r8169: add phylink support
Message-ID: <d212f15b-8b5d-4125-bd04-35abfb9c0013@lunn.ch>
References: <20260430083244.703-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430083244.703-1-javen_xu@realsil.com.cn>

> And one more question, when the driver initializes RTL8116af,
> r8169_mdio_register() will still be called. So tp->phydev =
> mdiobus_get_phy(new_bus, 0) will still be executed. This feels redundant
> since we are now using phylink. However, if I bypass this assignment,
> it breaks several existing functions which are strongly rely on
> tp->phydev. Is it acceptable to keep this tp->phydev for now, or is
> there a preferred way to handle this problem?

You probably want to do some refactoring, before swapping to phylink.

rtl_link_chg_patch() needs to know the link speed, so looks at
phydev->speed. The rtl_mac_link_up() call gets passed the speed.  So i
would refactor rtl_link_chg_patch() to be passed the speed. And then
when you swap to phylink, and r8169_phylink_handler() disappears you
can call rtl_link_chg_patch() from mac_link_up.

rtl_coalesce_info() i would refactor to put the current speed in tp,
set is when rtl_mac_link_up() is called, and back to -1 when
rtl_mac_link_down is called. This can be another refactor patch, have
r8169_phylink_handler() set the speed.

Same change for r8169_get_tx_lpi_timer_us().

EEE is quite different for phylink, so rtl8169_get_eee() and
rtl8169_set_eee() will change and should not need to reference phydev.
The same is true for rtl8169_get_pauseparam() and
rtl8169_set_pauseparam().

rtl8169_set_link_ksettings() is broken! It should not be touching
phydev members like this. That also mostly disappears with the swap to
phylink.

r8169_apply_firmware() is interesting. Is this putting firmware in the
MAC or the PHY? Or both? If it was only PHY, i would move this into
the PHY driver.

I would try to move the code in r8169_phy_config.c into the PHY
driver. The tricky part is knowing what MAC version is being used.

/* Chip doesn't support pause in jumbo mode */ should be done
differently. We have helpers phy_support_sym_pause() and
phy_support_asym_pause(). A new helper should be added
phy_support_no_pause(). Both advertising and supported should be
cleared. And these should be an else clause for when jumbo is
disabled, and pause can be used again. phylink however does this in a
different way. It might be you need to call phylink_stop() &
phylink_start() and ensure the mac_get_caps() returns the correct
capabilities.

Try to remove as many references to phydev as you can.

I would also suggest lots of small patches when doing this
refactoring. When you break something, it will make it easier to
figure out what broke it.

    Andrew
