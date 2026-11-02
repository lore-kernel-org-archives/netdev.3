Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793581898;
	b=hZGzuWffSITAA/SdneMv/c0MSP/OM0eMVmmpNXhK4gBQ1HSPpedP+8MlphN36pCE2/Ry
	 h6a6e3GHxDFcjxfEzoz/1lnGzguMj179XI5lR8fijJOI6EA2/CDMfyo2EW6ERiKSLjQql
	 glkWt9fO2rqtzwQ1aqgADqY72eelLjHizOlKmOO9n6HdoQrHRh/LjZ3v1qyDj7igwAKE4
	 /Y5bgxBJMKTToWMSuieia6neTDTA7fCXvjFP9mmxfqgpL2IXdW04QhTuOfe89HpO3ZYYV
	 Y4+Mye8HB3JAIKTdjzVfxUNm1TXGrhFXCSt/fOpHi38T7UnqE2aA3RX8s1Fna7eGSLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793581898;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Rcwix2uwEWKi7035aDG+amqfMVRyuFKx2q048RQMB3c=;
	b=LbFvWZy4Bacfq7U9HXN8MKSXC5J1l0TA5hkHnd75WUSO3Zc5mE3PN8M+MdSKmKAmDJpu
	 06pBZbOAXVvU5a5ge9I/eNsxNTT/8PZ1ab6133gVhXTYms0e2VsDoGoHGAXvVjx8GI34o
	 pYlTgqyGfmNknSO0AnXiEoNZexkcJ6tS1PyxtlPzOYkkZH+Mo0bEBPyfmD9MMzU0XJRDP
	 S9siSnAX22DaDmbye5OIKpgsvhqwUhZ5k1MC6DhZ5GiiNDvuPWl1tT2+9TSOsPoAhkGsz
	 Wqe+/2cnjPy98r6tro9g2WGv2oeR+2IUHDiqYdQNISRG9YPPfbCszegA96S3SxqPIaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="0/4lWtGA";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B669606A324;
	Mon,  2 Nov 2026 01:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B669606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=0/4lWtGA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rcwix2uwEWKi7035aDG+amqfMVRyuFKx2q048RQMB3c=; b=0/4lWtGAM1ZgkRyu9eUa46Ex7I
	1F3RO1pfEwk9FGgEG3y40hILMDHAzmjjFloJY/FIlLfa5XzqJra3K8P0QwJZdV24R1d1gClKRe2rC
	o5WTvX+FTtCngvvbgBKD41qu2nU75HEqU1efGHsXW7G+w0FWHS6gHqgWSzlcg+v8M46o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNgZr-00DiR9-NI; Mon, 02 Nov 2026 02:11:11 +0100
Date: Mon, 2 Nov 2026 02:11:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
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
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <f8da1842-bdc0-4bf7-8f15-46b57a9eedc9@lunn.ch>
References: <20261022200640.3101932-1-tanure@linux.com>
 <20261022200640.3101932-3-tanure@linux.com>
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
In-Reply-To: <20261022200640.3101932-3-tanure@linux.com>

> +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.yaml.
> +        # The RX delay line of this glue is fine tuning in 200ps steps,
> +        # added on top of what phy-mode describes. The TX side has no fine
> +        # tuning: its only step is a quarter of the clock period, the full
> +        # 2ns at 1Gbit/s, so the TX property is not accepted.
> +        tx-internal-delay-ps: false
> +
> +        rx-internal-delay-ps:
> +          enum: [200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000,
> +                 2200, 2400, 2600, 2800, 3000]

This is good, thanks.

> +
> +        amlogic,tx-delay-ns: false
> +        amlogic,rx-delay-ns: false

Maybe add a comment that these are deprecated in new SoCs favour of
the standard {rx|tx}-internal-delay-ps properties.

    Andrew

