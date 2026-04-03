Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD23C944F;
	Fri,  3 Apr 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230067; cv=none; b=uncpFGxvLw1BAj13J14vZCCnzXSuM0P41e9Ct879jyQyYuPAwwjs/XLyt3g+OeXeC5v1kMwv0Nx0Fp2U25Z0Oy0lgOEJ6kkemSfmrSQStWs8Par2BrZtSvjrKC2S4A9f2yY2/7NMAiyvrYC7vvzWIek5fVf3pfKTbXR5ouYDT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230067; c=relaxed/simple;
	bh=2YMI5pgxql3AtVXz91JbKDz8JNfnuo7TDqvJp1BwkfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao16OKAtH9EWznOnM8oQGf4Geu8mBpRT708Kzg9ikdmXDOxxS0b02trgdZSi01QrY8u7kkjve7V313Pf+wGuF5UPRo6LPLFstr5wPDBeF1dw1CBbCZGT1ul21IBjKFZI3s5YNWvLweVqOEEvOSNutbEXnXM3GEEUDNjdeHM+An8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hcJSb6U4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hcJSb6U4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tKVOhuzgNNUeA7HRd/Hj2OZajDtiYpskD9RzY7YjiGY=; b=hcJSb6U4IL74l+lmShyRUWSEAV
	56deHxP69l0VbcJ4h123W7CbK+8ZeoNRMFgHIv/Itl7wcxeFYR5r9avrK8rozpBQlOrLaiRSIfOqZ
	NAi71RW+J3VhxNyh1adyNi9TYPzvE3ReOStay3EGthC8MYIsIg4GPozLWfvCbyiq4TsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8gQn-00EgJ4-1z; Fri, 03 Apr 2026 17:27:33 +0200
Date: Fri, 3 Apr 2026 17:27:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/3] net: phy: add support for disabling
 PHY-autonomous EEE
Message-ID: <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
References: <20260403090656.733985-1-nb@tipi-net.de>
 <20260403090656.733985-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403090656.733985-2-nb@tipi-net.de>

> + * @autonomous_eee_disabled: Set when autonomous EEE has been disabled via
> + *	phy_support_eee(), used to re-apply after PHY soft reset

Thinking ahead to when autonomous EEE is supported, there will be
other reasons to disable it than just phy_support_eee(). So i would
not say this here.

>   * @eee_cfg: User configuration of EEE
>   * @lp_advertising: Current link partner advertised linkmodes
>   * @host_interfaces: PHY interface modes supported by host
> @@ -739,6 +741,7 @@ struct phy_device {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
>  	bool enable_tx_lpi;
>  	bool eee_active;
> +	bool autonomous_eee_disabled;
>  	struct eee_config eee_cfg;
>  
>  	/* Host supported PHY interface types. Should be ignored if empty. */
> @@ -1359,6 +1362,21 @@ struct phy_driver {
>  	void (*get_stats)(struct phy_device *dev,
>  			  struct ethtool_stats *stats, u64 *data);
>  
> +	/**
> +	 * @disable_autonomous_eee: Disable PHY-autonomous EEE
> +	 *
> +	 * Some PHYs manage EEE LPI autonomously without forwarding LPI
> +	 * signaling to the MAC.

My understanding is that LPI is always from the MAC to the PHY?


> +	 * Called by phy_support_eee() when the MAC indicates it supports
> +	 * EEE. PHY drivers that implement autonomous EEE should provide
> +	 * this callback.

Again, there will be other reasons to call this, than just
phy_support_eee().

    Andrew

---
pw-bot: cr
	
