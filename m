Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216B4137AE;
	Sun, 27 Sep 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531740; cv=none; b=sy85vkBUGtMhJOj94zqmFqpqyg22yZOPIW7OdIA/mqlDIbFsTiD76dpzfywAvl9faAh0FvE4y5FVAT4W7DkwGd22vbveLsLGqESyBI26ht22S7CVPhkj6HFBWTbOulj9lJHbMWQEXHmVDE/tTpPukEeywncog5vb2RuM8IaoT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531740; c=relaxed/simple;
	bh=HJpSBegpXdPBTGaMIIMQxnOXULmZcvJrgHqxUltWPMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha6Vt8VXaKOvEPR9lx18cvaEPps9n6Xi0fuCrNZHuvj7uUQTLJofx3mBlpcsV7xOczeom1KP3risknuSVeriv/A0CVO/X/t+yGwoqGWOnNe4vlWWGtRf8mSLeHYgrb2E8+/ftW5qXlYhua9csF2ML8m5A4VSykT5zLhHuCg64fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hEp60/fn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hEp60/fn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XN3adG8n48aXlFD1oGyPwbYbvAFkDP/CnzFiAMWmyQ4=; b=hEp60/fnREcY6JQT7sBraSKoyp
	FrNRR2k2n55oXex+eD3KgkOyCycM0kBHzK4jAnF0ybvsKFaZVCrFN20fsfaMcUllSvx8k3zUzZ6La
	DRVU8leSB/IKcQq4+c5FAtfDDK7tKiZAaB5Woc8H1uOWNSzGqdEUEWZP5P1BpVeX00mE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAt5z-007Y7E-CH; Sun, 27 Sep 2026 19:55:27 +0200
Date: Sun, 27 Sep 2026 19:55:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com,
	michal.simek@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 1/2] net: axienet: use device_property and
 fwnode APIs for probe-time config
Message-ID: <6ab4896c-c4d0-499b-befe-045cafa8e470@lunn.ch>
References: <20260927073843.346910-1-maimon.sagi@gmail.com>
 <20260927073843.346910-2-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927073843.346910-2-maimon.sagi@gmail.com>

> -	lp->switch_x_sgmii = of_property_read_bool(pdev->dev.of_node,
> -						   "xlnx,switch-x-sgmii");
> +	lp->switch_x_sgmii = device_property_read_bool(&pdev->dev,
> +						       "xlnx,switch-x-sgmii");

What version of the core is being used:

6c8f06bb2e5147b2c25bdd726365df8416c13987
Author: Robert Hancock <robert.hancock@calian.com>
Date:   Fri Feb 12 18:23:56 2021 -0600

    net: axienet: Support dynamic switching between 1000BaseX and SGMII
    
    Newer versions of the Xilinx AXI Ethernet core (specifically version 7.2 or
    later) allow the core to be configured with a PHY interface mode of "Both",
    allowing either 1000BaseX or SGMII modes to be selected at runtime. Add
    support for this in the driver to allow better support for applications
    which can use both fiber and copper SFP modules.

If this property is not needed, please leave it as OF only.

>  
>  	/* Start with the proprietary, and broken phy_type */
> -	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,phy-type", &value);
> +	ret = device_property_read_u32(&pdev->dev, "xlnx,phy-type", &value);

  xlnx,phy-type:
    description:
      Do not use, but still accepted in preference to phy-mode.
    deprecated: true

This property is deprecated. So it should remain an OF property and
not get expanded in scope.

	Andrew
