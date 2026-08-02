Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F713B3C01;
	Sun,  2 Aug 2026 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682559; cv=none; b=RptX1Nq8275tN+X3NvSdZSuMVHmgXaC2vd4tAqPUgokCwWkk0KLxwySWnYQiN1sXsVUki+G4OWRMt5UNvF0XXnc2c9wq12jr0v37eLMDjrf523TUB3h2Ey0PkQqjPld2qwivGIOmpGEjbFJeMPJ0F41lpBmzUu2FB1c2qicSS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682559; c=relaxed/simple;
	bh=FIVqjxuZSHXy4Qe0+AmBkOHAPGhpUG64xobPWjkzZ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKRo+P+4UxrSmLUpFKU3Iw/8DCqusZe6gvCRxZmTHHwqm8Vff9ruJeLJpMkj9EBOTBvm7Rx/Sdd1BPAtKr+F1SSpT1vaFyuWlGKrcY4DJRBRpMKjgEG5FT8ct3LBU62slnbykq3AKYTOB6mXljxnlZ24UdspNS0Inb5YeU6f+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C4meES7S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C4meES7S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d9Y1SDF18pKG3jbj1C4xQmU1iWHwOec2o8Dvaiq0XS8=; b=C4meES7SoYNSHM3WwonODJbzRy
	BQ5GEQyxBrSc7E+salVlq6B9ecfiTtx2K4o0vcvIJfEQfr1E4dStxSfgPOkK5hOTePFfunaT21i0L
	CSjxAHj5Y7oUojeL/0MTms4+F2P7ltJ7vmUz99O274DVrQPAr19qKKZKih35FDY+sKBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqXbG-00Fa8c-OL; Sun, 02 Aug 2026 16:55:38 +0200
Date: Sun, 2 Aug 2026 16:55:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v8 3/7] r8169: add support for phylink
Message-ID: <cfcf87aa-3d4d-411a-9af0-5a5b78c9ae89@lunn.ch>
References: <20260730065014.883-1-javen_xu@realsil.com.cn>
 <20260730065014.883-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730065014.883-4-javen_xu@realsil.com.cn>

> +static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
> +			    unsigned int mode, phy_interface_t interface,
> +			    int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +	struct device *d = tp_to_dev(tp);
> +
> +	tp->speed = speed;
> +	rtl_link_chg_patch(tp, speed);
> +
> +	pm_request_resume(d);

This does nothing with rx_pause and tx_pause. How is the MAC getting
configured for flow control?

    Andrew

---
pw-bot: cr
