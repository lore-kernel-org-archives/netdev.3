Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE993A7D63;
	Sat, 17 Oct 2026 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258373; cv=none; b=MuVcEmeGiyIQZuS/2mnGUlhB3jzq5bmxbr4vQNOvhSOsHoYf9NBugmSs0yMe9PQlJR/1nhH1xXUBv+NmsOIorAt6T7hTBD1Zjm/6PETqTw6BT6l/JFlodXK3CuxAMPeVrHqc4P1QNLg8JCITOVzy3NPNMctHys41BRXwEJ02VNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258373; c=relaxed/simple;
	bh=8q9gTXWjkyurVHTIYBRu3kMfmEX64bUpQa09VGPt7Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAg0cVNngCGETS9Z4WSt+QON2gSkdbt9ZhMnN9MMZuBRqHRvP5OeoqoyeBif3fdcXRyLFc4pQin1oRnai+cQseROa5RE6Np2MUAiAOwZPyWKzIP9CODZA3zP3wtqB9zrljC5o14A6118pD+FQYbb6+X6S6jwhI6Ks2tBfvarr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=NJe2De6d; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="NJe2De6d"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F16D8105FB3;
	Sat, 17 Oct 2026 19:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792258360;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gOGIRzzzR0vzZdCdgNOPxzBc4k7KuaPHEI2DL4pIPwY=;
	b=NJe2De6d9yMBsAIyHgnWUF4nKZu9OND0sgMZkUEkHsg5woqC9kyaczQTArtK2tevf2S6tM
	9qn9wzt/NbkmDwrS13Ii2WUGTm3CACAwuYOmutnz6HUCrAF5GaxlDiQrCf3C1D8P3b1sZw
	OPl+JEYCiGVaHUGpeg1OkTzzIWz4BXWs1/U8xJ68XuG+3Q+7qx0joL1hDuTDsrEV7X9CYl
	D80mBi99+Z8KMgxo3mOvl6x7xwk2unBMI3G0jrmny1O2sHtH1BbbBE5vC8SZEl9V6upivH
	3t4xCn7VqbbSnYNmjKUbUuzX1JS+tuppNZUEDxHDuvg/yV+xR7pcxUMJ6DDLpA==
Message-ID: <329d56ac-00ce-4fb6-87fc-eeb14ed78959@nabladev.com>
Date: Sat, 17 Oct 2026 00:04:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from
 DT
To: Frank Li <Frank.li@oss.nxp.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com> <atKDNdxl0w65s8yQ@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <atKDNdxl0w65s8yQ@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/16/26 10:04 PM, Frank Li wrote:

[...]

>> +int enetc_mdio_update_mdc_div(struct mii_bus *bus)
>> +{
>> +	struct enetc_mdio_priv *mdio_priv = bus->priv;
>> +	struct device *dev = bus->parent;
>> +	struct clk *enet_clk;
>> +	u32 div, mdc_freq;
>> +
>> +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
>> +		return 0;
>> +
>> +	enet_clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(enet_clk))
>> +		return dev_err_probe(dev, PTR_ERR(enet_clk),
>> +				     "Input clock unknown, not changing MDC frequency\n");
> 
> binding said clock is optional. If return failure here, it will block
> existing dts, which have not clock property.
> 
> should be devm_clk_get_optional()?
Existing DTs are fine, since they don't define clock-frequency property. 
And whoever wants to define clock-frequency property, they also must 
provide clock property.
