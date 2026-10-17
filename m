Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1CD3B6C06;
	Sat, 17 Oct 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258447; cv=none; b=Ps2w2vE8VKYa1fc2/HtkgLcPjZKZR078DthbOj+SvMR7Mhz2SMWpIBWDKYfbyxn7EFktRav5tmuOrkR//2IEjrpeQaOJm+VZuk66o44wIxvdJJvX30uQcmVjc+5eUFrQK2+z6w8Yvc/DUVCNWthBH6JABuViu4TcAM1PpYEVEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258447; c=relaxed/simple;
	bh=+8pAPjRjaGWejxcu/xOh57SE4snp5QPNrEHd+xkPGVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx7pOGtudtKncvgSzAkJLrlqBsoelSmYg0apmiwbq0s8WbqM9Ls6U29cR/yAoKLM+Fjo9aAklEDqLI73N3NzPYSd83Y7agtRedjCsBdnRTTe8DXyJQmZmfrtdlW2OeHKMrEaZhg08ZQhgxVS3P0dWCDSKnHH2922Sq+WS8wq2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=JUi7yPBl; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="JUi7yPBl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D57DB105FB3;
	Sat, 17 Oct 2026 19:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792258444;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7ZMZTPvh9tMJLNdO7mYMSY3WuW2Rj56qTgdyt1nrogg=;
	b=JUi7yPBlYsym0othMpS5J+dTlNByXsPSEu0yY4K0tzee4Mt9vKkHtjALk4Ja3quKrwHpRh
	RgJqSt5ELaOBgXRZRS0gPjFgRJF1KwXPCRMzrVv0zXYULmKVTka5wtOtbm3aFb9p1SThEa
	4IBTpweRBmkOciJT6N8lDjHSoxwuthk1O3O8yfEBQs4Z1O1+uf1wucrSW58ruCmicU0k2J
	Wf+yJTTG0evga8/qKX6V02dmTc7LgNUVNjEMo9iS7vB3ukx+ClYxZkXpKevehAxUfujOMV
	ELmsH9+znF2F2K3wsV9+j63Rwlo9faZGEv7X0Dd7ewh9APWWWIKnN+52fUyByA==
Message-ID: <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
Date: Sat, 17 Oct 2026 19:30:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from
 DT
To: Wei Fang <wei.fang@nxp.com>, "Frank Li (OSS)" <frank.li@oss.nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Frank Li <frank.li@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com> <atKDNdxl0w65s8yQ@SMW015318>
 <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/17/26 4:24 AM, Wei Fang wrote:

[...]

>>> +int enetc_mdio_update_mdc_div(struct mii_bus *bus)
>>> +{
>>> +	struct enetc_mdio_priv *mdio_priv = bus->priv;
>>> +	struct device *dev = bus->parent;
>>> +	struct clk *enet_clk;
>>> +	u32 div, mdc_freq;
>>> +
>>> +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
>>> +		return 0;
>>> +
>>> +	enet_clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(enet_clk))
>>> +		return dev_err_probe(dev, PTR_ERR(enet_clk),
>>> +				     "Input clock unknown, not changing MDC
>> frequency\n");
>>
>> binding said clock is optional. If return failure here, it will block
>> existing dts, which have not clock property.
>>
> 
> For EMDIO device, the clocks property is not added to
> fsl,enetc-mdio.yaml, I suppose this property should be added to the
> dt-binding doc if the clock is really needed here.

Isn't this what 1/2 in this series does ? (maybe I misunderstood this 
paragraph)

> For ENETC device, we already have a 'ref' clock in the enetc node,
> so devm_clk_get(dev, NULL) may get the 'ref' clock rather than the
> system clock of NETC.
Shouldn't the clock be described in the MDIO DT node ?
