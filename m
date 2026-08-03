Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62439376A08;
	Mon,  3 Aug 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765076; cv=none; b=KHg5LzqiMl3tST8Ksu+biBtNPFQi/zrbb6gPy7rI2ecx39FXBPUg24X+F3/F++J1yWpPoazWFWk1/+kDB0rFXLND5p/JXPedSx3WOAOQeFiefDCV1Ju2DhJd8zvQnpJvsjvxiQ6IaT8htxDc5qkipQkguUcwbCbQUSmkQqxho9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765076; c=relaxed/simple;
	bh=inaStIkU+iRlGjgIk7MdyPxRRaE/xD71ClVr2QxRYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0U4ZqsPqfpR+Vba8vrqfQ4FR4NfFJsQK887uEH8bBz/SO+7lq8P3bVnaOJ8IZHhDdW9mUMNtMalXkGPFQtcqFjZPcfQqq6oUwYofohJJvd4Xnzdota2hF+punsdF6B62wASerfrp2T8L1qDfluEx1YiqDZ6DgSfXkpYNmkwDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M1H1iu/p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M1H1iu/p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uqpuCmGbDC7MQgqg4rNwLa59ffLN5tM7+k6xoxCEPxg=; b=M1H1iu/pjR8kYw7PfRwEcrhdUG
	Mmpf5DE9eGVvhtIB6rk06xkB1BWps31tCUziHtFIcdGiQHcjdPICgwrIDeT7j82klQNqStFTs3Khx
	gokx13xO1aev3e48O2pDastt4vTy37tA5ANceoV4o3b7dHqudb6h8H6N8brmXzWgq65o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqt46-00FjZz-CF; Mon, 03 Aug 2026 15:50:50 +0200
Date: Mon, 3 Aug 2026 15:50:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mfd@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
Message-ID: <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>

> +static int
> +ac200_ephy_ctl_set_led_outputs(struct acx00_ephy_control *control,
> +			       unsigned long outputs)
> +{
> +}

> +static int
> +ac200_ephy_ctl_set_led_polarity(struct acx00_ephy_control *control,
> +				bool active_low)
> +{
> +}

I've not looked into the details, but these look like pinmux. Does
this I2C device have a GPIO controller? Can these pins be used for
other things than LEDs? Maybe you should be implementing a GPIO and
pinmux driver. The Ethernet PHY driver can then just select the
correct pinmux configuration.

> +static int ac200_ephy_ctl_power_off_locked(struct ac200_ephy_ctl *priv)
> +{
> +}
> +
> +static int ac200_ephy_ctl_power_off(struct acx00_ephy_control *control)
> +{

> +}
> +
> +static int ac200_ephy_ctl_power_on(struct acx00_ephy_control *control,
> +				   unsigned int phy_addr)
> +{
> +}

These look like a regulator? The phylib core has support for
regulators.

Maybe take a step back and look at the overall architecture, and how
Linux can represent these blocks.

	Andrew
