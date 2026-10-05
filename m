Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BB4A49AC;
	Mon,  5 Oct 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215790; cv=none; b=g07aRTz539OqP/m9wB+TUFS5R3M83p43HsPA+4KODeb9pPYBSJcMiYEx2jAJAdhOhaqIbbiTeSxaHkmfu9frfV5bEWHJHtJZ6pVJ1czQsuzONiftgkoIwe9wc8zsvzB7NhBPAGcBDrq896Olhyr3WDWLKY11Blnbu1yLRJv8BD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215790; c=relaxed/simple;
	bh=CVb0jwQFjrJg53BgX1GCc06aDMg+ZPMbNsQyW8oa+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGS5V4lFVoKxCa9757ScCK5RqjOsSjPwulBff+Os4tKBdZWHiZiDtkXIyJhAZmk5KgXHU9Ag5vYHcc6yYORd5m2ICY6kG79KlpobAIW4lKffCkZan5xC286McAoiKKrscMQdhVzrrPKkE7MRokYYd/ebuF1UFKUnmvbP1xxV37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zTyc7cz1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zTyc7cz1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ozhBT/7/VytNYmqj1zwDdXmvQwSa3zBNWtW17/LMIWQ=; b=zTyc7cz1q7j3w9ngmTqOhART3N
	rDVPcD7swj8UOMFW8VMtjNSo4ZTuRdPjrFArrsvpF4nhjAUhmdv0u2x69X24n09PVFNPcHuZqzr8b
	B1RyomobMnaKwerkCSZvH3rQQZzRO8ByKM6tz95/sg1CvFMC1R/qfQrPCbDM6LsmNPuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDl2p-0094h1-93; Mon, 05 Oct 2026 17:56:03 +0200
Date: Mon, 5 Oct 2026 17:56:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH 6/6] arm64: dts: amlogic: t7: khadas-vim4: enable the
 ethernet port
Message-ID: <f282770c-2238-4a1b-b811-c0c483fa7681@lunn.ch>
References: <20261004144046.391444-1-tanure@linux.com>
 <20261004144046.391444-7-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004144046.391444-7-tanure@linux.com>

> +&ethmac {
> +	status = "okay";
> +	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names = "default";
> +
> +	/*
> +	 * The RGMII clock delays are added by the MAC, so the PHY is
> +	 * asked for the mode that adds none.
> +	 */
> +	phy-mode = "rgmii";
> +	phy-handle = <&external_phy>;
> +	amlogic,tx-delay-ns = <2>;
> +	rx-internal-delay-ps = <2000>;

I agree with Maxime here, rgmii is wrong. We really need to understand
what is going on here, especially since you are asking for the MAC to
do the usual 2ns, nothing special.

Is the PHY not actually inserting the correct delay? What does the
datasheet say?

Also, we have one vendor property and one generic property. Can
amlogic,tx-delay-ns be replaced by tx-internal-delay-ps? But that
comes later, once we have determined these properties really must be
used.

Humm, what is meson8b_init_rgmii_delays() doing?  What is
phydev->interface in the PHY driver.

Please take a read on:

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

and figure out what is going on here, because at a first look, it
seems broken.

      Andrew
