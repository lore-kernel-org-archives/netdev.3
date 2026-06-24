Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498B3BB112;
	Wed, 24 Jun 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315906; cv=none; b=c4GmUTFSNk8PGPW/q46nbcF1XGuZgVg2ZqPk8bnsJWZPclP072Fh8SMQkUvbTS8Eh6jKZUIT3KvThbfzN9XiZMOU+TC/5Rxk1lqQGYW+hI9oR+hqufm4G1I+q/K4rX9ffRWf3LLSDjyQz4/WvGcrgO7O6K6Gx3DVqX4E+Dia6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315906; c=relaxed/simple;
	bh=ev79dUy3ZM1QzjkEIk1j5MMuBKZXUEwSes3AAEkdV7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETvdWwpRaT6s1EwONFMLBeT7KVEZ6W/m+/azUqEjXxLQWFyThXp6Fc19qyXpakjAMDEWe3i+R75qy4h3NQiWzRX+0m4o3M4AvLp0+oIv1ACjKVaqpQX6TUJoVw8INxdPOJeIVsTrE6P8mWyRTZq28Be8CeYS8fT2v1eIgVGiZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BtxnOHP1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BtxnOHP1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4HoG5nibkY73X5+Sim6btQdITTv97/tVHKTgeohtTGg=; b=BtxnOHP1PijdZwZuVcOKI5sK5c
	54MUxwFe6LX9lO9Pmeo0BFQVIa2+yf4XeAstyWjbCgm9jMq8IzD7dil3cUJsGjnBOpScm4R7Ar7Lv
	oyeZYEXG1rjg2PQBNMNnupaLRQ8zvVYxAcnKFMXOhp/Q576eiWf2LxAF45Nuk+DIxkSM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcPmY-0096vk-Jm; Wed, 24 Jun 2026 17:44:54 +0200
Date: Wed, 24 Jun 2026 17:44:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanan He <grumpycat921013@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	david.wu@rock-chips.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 7/7] ARM: dts: rockchip: Add Alientek DLRV1126
Message-ID: <f526c23f-2ead-4246-bfaf-5bf4fbaec29f@lunn.ch>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-dc42d99f75a7@gmail.com>
 <20260624-rv1126-alientek-dlrv1126-v1-7-dc42d99f75a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-7-dc42d99f75a7@gmail.com>

> The board consists of a CLRV1126F core module and a DLRV1126 carrier
> board. The core module contains the RV1126 SoC, eMMC and RK809 PMIC,
> while the carrier board provides Ethernet, SD card, AP6212 WiFi and
> Bluetooth, PCF8563 RTC, ADC keys, GPIO LEDs and audio connectors.
> 
> The board has been tested with Ethernet/NFS boot, eMMC, SD card, SDIO
> WiFi enumeration, Bluetooth LE scanning, RTC, ADC keys, GPIO LEDs and
> RK809 audio card registration.

Ah, here is the networking nodes. But why was it not threaded to the
rest of the series?

> +&gmac {
> +	phy-mode = "rgmii";
> +	clock_in_out = "input";
> +	assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
> +			  <&cru CLK_GMAC_ETHERNET_OUT>;
> +	assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>,
> +				 <&cru RGMII_MODE_CLK>;
> +	assigned-clock-rates = <125000000>, <0>, <25000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmiim1_miim &rgmiim1_bus2 &rgmiim1_bus4
> +		     &clk_out_ethernetm1_pins>;
> +	tx_delay = <0x2a>;
> +	rx_delay = <0x1a>;

As i predicted, this is wrong.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

Please try removing rx_delay, rx_delay and setting phy-mode to
rgmii-id.

	Andrew
