Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828129;
	b=Yy4WELS9eilyrKWxvq5uPkBCn724tFWADCaQY3q+OHgBl5TDguh6PZSbU+Uxn0e3gmtR
	 6SVXlyD5X3fxHuw2DBa83NVdITP5TGpOz6Cft7qZPkAHR9+2RpLXCZjeVTExEIiCskRyK
	 sZgyUxttKbgBUfrSN0VboIcFsbKWXFFPCfTRQXqtVakCHdGa8r+41Hno5vb3l9e5IbEPU
	 7Ng2+a3fFKaqjorrP1MwFMpeQbd5jDhSEUzuFqqEAM07Eos5RZ09zbWXnpM45/WvLAlV7
	 D4f3ZeU0FiyS62Hr3jRxHyZnc+i3tu/u9fLIp6MIViLNzf4r661YUiwxcll8g8LuYfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828129;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UZCPbOxuHxVfcCpmEyp2FuF94MWKe2jTtQcOlBA8NP8=;
	b=oZ5kAyE4Xg0/1d5x1pQ0XaWRMEDwCzDZzoaFYe2A3goCoCZ6FocFbHd6cZdAoOFRZACX
	 +ImHqDwgY3p7kYyFQT/e9J9+ZD2zUBD51cp636coZ2afEexGLZoG8jdoy9Rf52B4n7fKn
	 JgxWdANwmgOnvbmslVnc/ScxJtKyyDWRLDvKfbGNQxKG08HtM23h/51zdR0qpz1WaihVF
	 u/QNCyIgkIrwJMOcApkGflBnJkHbUL1hPGC8gmTrvhMrvQY4BMctauPSgr6j1OYE4WJsN
	 vuZC/y3pfMbYf/VpAwQbZJwdEByA3utL6AipmX73b4fhRg3VPUnJxPXRe76K9uxXaRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VDrsKog5;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16A606A328;
	Wed,  4 Nov 2026 21:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C16A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VDrsKog5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UZCPbOxuHxVfcCpmEyp2FuF94MWKe2jTtQcOlBA8NP8=; b=VDrsKog51b2RF7ESU9eYKcZLb8
	VqMM9W/eeGlQgJy1/KjdcLA2TaK3nJJH1QKsBvJ1gSnoIvwrZDLlOnhXQnczL8BcAFReUSgXn/+Yv
	uXArciRi7epVa64gYAv3P0Khywv0cbo4wUI7FDbezlCziZysGT/TTxixnefFk+tS31rs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOidY-00EOR7-8u; Wed, 04 Nov 2026 22:35:16 +0100
Date: Wed, 4 Nov 2026 22:35:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: joseph@telaak.dev
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: Add Siflower SF19A2890 glue
Message-ID: <ba345fce-e88a-4aac-b9a4-59c500f80247@lunn.ch>
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
 <20261104-sf19a2890-gmac-v1-2-a15965a49574@telaak.dev>
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
In-Reply-To: <20261104-sf19a2890-gmac-v1-2-a15965a49574@telaak.dev>

> +/* The MAC adds an RGMII delay only where the device tree asks for one */
> +static int sf19a2890_gmac_set_delays(struct sf19a2890_gmac *gmac)
> +{
> +	u32 tx, rx;
> +	int ret;
> +
> +	ret = sf19a2890_gmac_get_delay(gmac, "tx-internal-delay-ps", &tx);
> +	if (ret)
> +		return ret;
> +
> +	ret = sf19a2890_gmac_get_delay(gmac, "rx-internal-delay-ps", &rx);
> +	if (ret)
> +		return ret;
> +
> +	writel(tx, gmac->cfg + SF19A2890_GMAC_TX_DELAY);
> +	writel(rx, gmac->cfg + SF19A2890_GMAC_RX_DELAY);
> +	writel(!!rx, gmac->cfg + SF19A2890_GMAC_RX_DELAY_EN);

What does SF19A2890_GMAC_RX_DELAY_EN do? By default rx is 0, so the
delay is not enabled. Is that any different to actually enabling it
with SF19A2890_GMAC_RX_DELAY set to 0?

	Andrew
