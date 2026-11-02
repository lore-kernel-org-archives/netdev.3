Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582061;
	b=ZtYphaIGDpf+vXRckvtx3B7pv+iTtNZRMsvOVwcRuJJo2TO0MP3oz8Pj/CW8XdIMODWh
	 KYOLh5m3F1J/3MP/1dNdLjD2k80C8xBZDPeNtzzfYWrB3+HzslEK3LWTghXNw11LSiAar
	 cdZotx9ItN9iuWcpDn/5IEPW0xZWYBBpClPs1C1G8Nkt6VaYtiNyrrIh9XED0ThrzXHtg
	 p1y6XpmyPy6kHgQGCjCfVCPzGTPHgbmG3aAHcO1M4sJNqFk87Tst9a9ZT4h0H9uktSHVj
	 sIFpcY/dlVjZpnxzKK2IOm4E365kndmillVI/Cda9sVU+Sl2qOr2MwGyXV2+adXazAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582061;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=S0Q7MjKWFiLIKrIxH78/CGwgNug5pMrs4qMFldikjPo=;
	b=fJlnS1rAiUQryNeZc1K+OxSxl5QNRnmZPKGQ1W98IWID/ftNqXIhVb+j4g3brluAlUs8
	 cDZhXK6YsYZNqIe+3WFHVjwL4n1x336NjJuvP9M65XnFNGfraeEkOl5uYBnn5N4FH0M05
	 Qr942ilNfVuU2djrVu3cHQRK3+mGljNWOV/fY1AYfw+ivcQJwV0/EXzT/mijqE5b4Bjki
	 dMUvnBNYoOwk0iuu4VEWfqhHWsWbcllYlPM19rjbfgEPBroEocBDgsFidP/ZesSuHckDR
	 OBq4jLy5ONbO8lC6OQou30vMtjjhRsjnshTvxQD0Xgbnz66BgoLMI48x4NlEoU5u9fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="Eud/Q1dp";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD9606A32F;
	Mon,  2 Nov 2026 01:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AD9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Eud/Q1dp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S0Q7MjKWFiLIKrIxH78/CGwgNug5pMrs4qMFldikjPo=; b=Eud/Q1dpcP91kMAdhRdBGv5UiS
	s/gb8x2fBdhir2tj9Tx5BPqErsCK1Y+JTXmepxsDTIzpt2XH2+H2lfKaJseDZRCZaUOEMbwBx/p8a
	PjSRTQN4ISB8bzle6CE4I+c7WGT+AZmKdpETOgFNkCfPsZb15KymOM2Jjdu7uA0QnK58=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNgch-00DiT4-8m; Mon, 02 Nov 2026 02:14:07 +0100
Date: Mon, 2 Nov 2026 02:14:07 +0100
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
Subject: Re: [PATCH v4 3/7] net: stmmac: dwmac-meson8b: add support for the
 Amlogic T7
Message-ID: <c7d703f1-57fa-42cc-82fc-3e0aab05b71a@lunn.ch>
References: <20261022200640.3101932-1-tanure@linux.com>
 <20261022200640.3101932-4-tanure@linux.com>
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
In-Reply-To: <20261022200640.3101932-4-tanure@linux.com>

> Without that gate the controller cannot do DMA at all, so it is
> required rather than optional: a clear probe failure beats an
> undiagnosable hang later.

Does the DT binding mark it as required?

     Andrew
