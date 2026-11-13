Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558218;
	b=o+Hw7DMZ2Ea/01YKOyQe23Cdxx9unrTho68MCp0ORwOqe78Yqs3r2ezGvPQOFZVSPat1
	 Kel1MnpnEYdgaa/ZzCd1bvWVts3vtyQVfv3PF68ncmEdPTlOMIdAE7S0DlhEmSGY/W2dG
	 C2Fm1nTF03UMc2QCadNzTGSg2o9s3BT/io9qRxTZNmxNuFPCIfkUJijsyPXbioMbsD8FQ
	 hSwfde36mUaB55NG1xLNCS6M+dG62zkaO5S1vDN/XH3QNmCxBRpmaF+N9sA9Hyo7jYpHG
	 ZhNlbzs9Cyrio4jpBu+HXYiUZYIDHfZy0XC3XyNi8+NOHohEfP0ptQDgzicaju8wyRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558218;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=+xvWra1IEANazOUIzu9aYSpzBjP8CbiiZ/8VsGzinn4=;
	b=iCngHPUVk9gs71XwApXqbAcet2qZTgvBSJKRT7184S1dCvoAZ/hQ4bzLG7Wc+6Mx6Qk/
	 6kjvJQgAvzyMb5i6PkEeHMO3IMQ8WMlpyi3R2CVT6Lh6Yb1dyEQqhCJXcD1p9ZMxykot1
	 JBtTo4lzj2PolJWYrb2QjNpCxNOcwTgcwViSvTpG1TX8fJt0fTjO9dpyrpyy0Ee9FvMDZ
	 HDoEjy4YSuewOr/nAQX9u+jOv1X5j7jWewnwsy3VTnFTARMxk1Qpbr48n4lZW+xBAXyZ5
	 0+DOEi8OGSFz6bi6lw0mceyGO+J3nKyvPCDedKBz3UethyT1Tk2DhrHU/VrDAhKgR/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GU+JXV4Q;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6760A6F51;
	Fri, 13 Nov 2026 08:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA6760A6F51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GU+JXV4Q
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B1D71C4F76E;
	Fri, 13 Nov 2026 08:23:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1B0A5601D5;
	Fri, 13 Nov 2026 08:23:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF65B11BC06F0;
	Fri, 13 Nov 2026 09:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794558214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+xvWra1IEANazOUIzu9aYSpzBjP8CbiiZ/8VsGzinn4=;
	b=GU+JXV4QJPFmtQbnhkL9VJX0jszc0OySFQarr89JdBgAZRT+LZu/MiIgtdoT4ptk/co1XE
	vsGS6kdmJMih+mTBZiY42Paf0jfqPWaS0sQrEYRKCsRXuVs3h7y0GZEXx46e01IYQ4tDdW
	QgbC1iwhetxZ+CijzqOpweUJVEfygITk0Ez7uGaIhOga5s3OYpAQErtUi2dzqKRK6BXAel
	f1LdK7ZKYvepAKJhW8QHJQkwXkg5cZVDWJLuzMeHfP+dFCbqU3HDpW9Au/mKkXgY9FNqua
	Q5OELq4eunCmxyg9bXqytE5A+MO36ZAyOmCSDYGGl0ZQgkgkoW1VDuro8ehBYg==
Message-ID: <36ecbf49-0d09-4abf-a93d-fc3f92191f7d@bootlin.com>
Date: Fri, 13 Nov 2026 09:23:27 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac-rk: only read the delays the
 MAC applies
To: aiyengar1990@gmail.com, Heiko Stuebner <heiko@sntech.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org
References: <20261110-stmmac-dwmac-rk-delays-v1-1-87abb6592921@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261110-stmmac-dwmac-rk-delays-v1-1-87abb6592921@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/10/26 08:13, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> The tx_delay and rx_delay properties are only used for the directions in
> which the MAC inserts the RGMII clock delay itself: both for "rgmii",
> TX for "rgmii-rxid" and RX for "rgmii-txid". For "rgmii-id" (the PHY
> adds both delays, the recommended setup) and for RMII they are ignored
> by rk_gmac_powerup().
> 
> The driver nevertheless parses both properties unconditionally and logs
> an error, plus the default it picks, for each one that is missing. A
> correct device tree using "rgmii-rxid" therefore gets
> 
>   Can not read property: rx_delay.
>   set rx_delay to 0x10
> 
> and one using "rgmii-id" gets the same pair for tx_delay as well, for a
> value that is never programmed.
> 
> Only parse the delay values that will actually be used, so the error is
> reserved for device trees that really lack a required delay. Behaviour
> for "rgmii", "rgmii-rxid" and "rgmii-txid" is unchanged.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

LGTM, I was worried about breaking compat but the rk_gmac_powerup() only
applies the rx/tx delays based on the ID mode, so

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

