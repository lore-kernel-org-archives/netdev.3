Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2801388883;
	Mon,  6 Jul 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351526; cv=none; b=lIUEiC6rZMK08MJ/10wsSNMC11tOhIAMha8EbtVmdbBvBGJ2wBZ5gnqweKtgdS6Q8Gz9DkflBTq0VuOeFLUf5Z5zCO6axB7Qe1kXV+MCk7qrqIB5WJoNLr2rraZkymI2Vj8PyD6P3RcJsb991dlWfAprJ66D55JnG06YK1T4kW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351526; c=relaxed/simple;
	bh=B8qC/sOUfGgxsWgL7Xbz2l/bDzeOQmhKlWdGp8SVQic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmH8gYAk3zxUCaE8gyLuKfDQA8TOz5Sm/J4XK/Y1HKFruuQX6iQEVEoePoLI6aFfZeoOC8VcMyULakeiwk0G5b8Y2pAeZibQfGPzg88qW7l/2O497pTH4gNOlqP1CKdxOCXvKoFbO3Fvq4w+yYm9IQd3OVhITBn1cOcMLl03P+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dWoyJl8M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dWoyJl8M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nAeEal0yordf3IkcFRL0DcicUoj11amUlNY6z/7ECI8=; b=dWoyJl8MN7X4GClEmFlywIrot0
	UGKloY6QO4ujPa/CYnWjBpxP+01+L7cGKaTyPm1LqDlViSf4Ud0Mb+57jmNG5CkXU1TA3uCfrdMLW
	+segjyhqZihx3MQC1axkwT1oL706yCs1aSnbSfTUfi8nZik+XBXDhM4O8E+kPNEa384U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wglC1-00B0rI-CT; Mon, 06 Jul 2026 17:25:09 +0200
Date: Mon, 6 Jul 2026 17:25:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 5/5] ARM: dts: rockchip: Add Alientek DLRV1126
Message-ID: <18acc27e-31e7-4c36-9600-a2bd8b806de5@lunn.ch>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
 <20260706-rv1126-alientek-dlrv1126-v2-5-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-5-ff3176ca362b@gmail.com>

> +&gmac {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "input";
> +	assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
> +			  <&cru CLK_GMAC_ETHERNET_OUT>;
> +	assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>,
> +				 <&cru RGMII_MODE_CLK>;
> +	assigned-clock-rates = <125000000>, <0>, <25000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmiim1_miim &rgmiim1_bus2 &rgmiim1_bus4
> +		     &clk_out_ethernetm1_pins>;
> +	phy-handle = <&phy>;
> +	status = "okay";
> +};
> +
> +&mdio {
> +	phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		clocks = <&cru CLK_GMAC_ETHERNET_OUT>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&eth_phy_rst>;
> +		reset-gpios = <&gpio3 RK_PA0 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +	};
> +};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
