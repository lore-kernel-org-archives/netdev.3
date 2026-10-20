Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524783;
	b=GPAF9bWPcy5/bUhkw/beLUyGCxT7aACGtsvbdIJ8YWAWX/tT4jnvF8JcOEDvIK9Hl6zT
	 30HVF3mBN+dMPrf4jAuq+Eeujy0/jY2ryIr16MNSGeJEu8q7PSGfLkOhnzrvMNTm7G/W0
	 IHPCXzFMy+vBnk+sqiki+yuaq/LNE49aMbXDioKJMZ2J3mAdFykb2f36i6gnx9VNawUpc
	 cE/06s3FXe9KlQd4NQ6mqbqVQ4bSRyIzwiCk22zw5ABRb6kmgrVglyEmrrPEYMzLNe64n
	 mLbb9mCggk1M3cD7RJkwBLa4/W3Ge8q/155+PE3c/1dOJxFfUS66MQqg4x2B3V6merA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524783;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ZI2XOhYhSS+ON68+ycU1NaNTWPtxOOczoynazLMcOec=;
	b=hN2/MANa7iAMwHpez2N8VbJqOSl5Hj2vkyYnahCb2db3hQHok2GDFcKMo4INJDJQj22j
	 6DipQO0OZJhGu/3g3zrgEK/MxZ8Kdhh3XNeCbH+fev4eiimPctgxn7caCIo1sG592fdvH
	 jNjdluBffWIqpOZWy/1rFFFB/zcOobK8Dxoo1ZuDy6o7jWbEDEvqAkoIA2PqDQ0yBkceE
	 e24Ld9EtY3GScZpiBDPa9LyEDbdtF3BkoBn1hJtw7ITny0qu2+//plpk9c08BhQTe/ipr
	 xAKMtaF4GyxKGi9lzkRBuaMosRSGx4xbrwjJs2ZLJy+G0dM+UfsZtc6Uy9ODMx98lrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="Ck1M7/DE";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F8606A319;
	Tue, 20 Oct 2026 19:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685F8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ck1M7/DE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZI2XOhYhSS+ON68+ycU1NaNTWPtxOOczoynazLMcOec=; b=Ck1M7/DEzX3otab1/vZLj5+glh
	JtHxK8DuJsK8W172OphKQJHHORFhLFqv7/rWaQAztGFA3PAc6aMpUemJTWoEqbBvi/qHiLelD6NoP
	eNU1WfAiR8RH45pWI+6mTMbb9m2PHU/1L7AkfCOawTPZyE4PdV2Gtr3QJlng7QZL7A7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJFZz-00BuiX-3P; Tue, 20 Oct 2026 21:32:59 +0200
Date: Tue, 20 Oct 2026 21:32:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prashant Sengar <prashantsengar25031@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v3] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL setup
Message-ID: <9b6cff4a-3717-4d70-8a7d-6d2f040b798c@lunn.ch>
References: <20261020181237.2374075-1-prashantsengar25031@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181237.2374075-1-prashantsengar25031@gmail.com>

On Tue, Oct 20, 2026 at 11:42:37PM +0530, Prashant Sengar wrote:
> LAN7801 supports fixed-link configurations without an attached PHY.
> However, lan78xx_set_wol() unconditionally passes netdev->phydev
> to phy_ethtool_set_wol(), causing a NULL pointer dereference when
> a userspace WoL request reaches this path.
> 
> Report no WoL capabilities when no PHY is attached, and return
> -EOPNOTSUPP from lan78xx_set_wol() before modifying the wakeup
> configuration. Keep the existing phylib WoL handling for devices
> with an attached PHY.
> 
> The issue was reproduced using USB Raw Gadget and dummy_hcd in QEMU.
> An ETHTOOL_SWOL ioctl triggered a kernel Oops with the original
> driver. With this change, the PHY-less configuration no longer
> advertises unsupported WoL operations, avoiding the crash.
> 
> Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
> Signed-off-by: Prashant Sengar <prashantsengar25031@gmail.com>


> @@ -1807,6 +1814,7 @@ static int lan78xx_set_wol(struct net_device *netdev,
>  
>  	ret = phy_ethtool_set_wol(netdev->phydev, wol);
>  
> +
>  exit_pm_put:
>  	usb_autopm_put_interface(dev->intf);

Please avoid changes like this.

Once fixed, please add: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr
