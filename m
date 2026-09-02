Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB8311968;
	Wed,  2 Sep 2026 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309053; cv=none; b=YlyTeXC+2awMDo234n2YkvMZfbWFBfiRJU/xvnrbUarpjAQMffERfs2PVU3A7HsbhYn9P7dgUNnd41bogO5ODcImY2f5oby7hCxGlADEUKesyoWFbdY89VB8PCE6hYXsCHj2ihT4MqjmddcRTUgTPT1lgX23Ptay4xPmXasMU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309053; c=relaxed/simple;
	bh=tcefJ9eRfN5nh8SxFFUeAKtQKV+guKONqjOK8K5INIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdeoiFztSbVIdg1SdKBqVebX723iisMaupxhplex52vyucrTryRvpgavP6z4ql4+cwnaKnQkVpVBPmXkB19OdIR6rzlx3XG8pZ7G5DBr4q8fXT/FECWh3EobXfXcGjaElAAphiCqfoG5lf61kpMM7ZVXAEoSYYf0RFst+XWCyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nAt8TMWW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nAt8TMWW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uLrCu/nSiddMjz3H2hoWarDDsSzxak5sEvVTLBefrdk=; b=nAt8TMWWiRrtDXhRAUD3hXJWeC
	bSJF7P4Ea16kt05a1XX6oPtnwcqGRdv8hllVQYqgfzuWB0lvOv5ueHDLulaKRfW5K7PbZR1YfXqu+
	edc3Tsu7Gg1+KIaa6T5h7Bf1tPRdeIlStLFACfsN9nBvcW2ksRxkiC3ngZRmCJp0rtKs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1YsF-002RkP-Sm; Wed, 02 Sep 2026 02:30:43 +0200
Date: Wed, 2 Sep 2026 02:30:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
Message-ID: <713d8963-6aa6-460e-83dc-157d37d66662@lunn.ch>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
 <20260901130948.212914-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901130948.212914-3-parthiban.veerasooran@microchip.com>

> @@ -600,6 +642,16 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
>  		return -ENODEV;
>  	}
>  
> +	ret = oa_tc6_phy_irq_setup(tc6);
> +	if (ret) {
> +		oa_tc6_mdiobus_unregister(tc6);
> +		return ret;
> +	}
> +
> +	/* Deliver the PHY interrupt through the nested virtual IRQ. Set before
> +	 * phy_connect_direct() so phylib enters interrupt mode.
> +	 */
> +	tc6->phydev->irq = tc6->phy_virq;

I don't know how messy it will be, but it is better to set
mii_bus->irq[] to the interrupt number. phy_device_create() will then
copy it into phydev->irq.

	Andrew
