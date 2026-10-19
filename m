Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460285;
	b=QPWcboIUCwsWuo77p1DvKL9S4dpqZYjK3sib3tj1/XzXC6mRS6ydjESwWBo3PFQM0Nx8
	 p4MwuH5AqafoH5/x5ia6KvF3MFWswft5UDV82c/Y7ZPfn9FxPkvNGlabOWQsfiGniEP6U
	 LpgqUnU4BWCDHJTR78DA4mBDZboQSGHw353qN9KrJGXlOUGK+/Kz2SfL4FJ6jiBdx9VIw
	 DTONNUkR9c4EF8wfs0blP8Ybd5z3gPgvf8asboAO/LwI2TiloKMwnZAfCPHZqK7DYi4PW
	 O6GCcQtZwNsDu0PXwA7Pia0OCXSh8RTvJgwikLJLDV+rHmfTEA+KgIUiUCvR1aTm6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460285;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=PbjFjYksln6X5VCuok/GYUEp4Jt2bFAm9SetP90rGcM=;
	b=3yM1FUTxHf2jQ8exWJqIo0VVpiLZ02N3lYNzcxiNISTnwOKnJmUlP/STN/1h3zYttreO
	 6uhGJXLjWeRwBxjylaT1NCx9i8Ex8MnTBiySKZAQGXI/ySJplgowKYKnn5oQ1tuBqiq0B
	 QZ1II9lhRV7KhMJGk/amJ5avb0V6Ut0blK7dRBCJWOJ9mAwortDwFZCUQZ40/JR5WwoLQ
	 dZQzyW29VtC+nIWsqA6KdW7cL8DkNh4qc2X/t2+UNTTg3oMvT1SvC+rOcoP/P7efcnBGJ
	 QrFLPti5vaKCDfZcOzt7tW7RGs1AGq/xbICAHHT8QYUoKK90e130GrWEjiPPBeGm4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gkhjrsVg;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFF606A319;
	Tue, 20 Oct 2026 01:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECFF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gkhjrsVg
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E71FA108825;
	Tue, 20 Oct 2026 03:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792460281;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PbjFjYksln6X5VCuok/GYUEp4Jt2bFAm9SetP90rGcM=;
	b=gkhjrsVg8YdzKJiWw+oBJJoGOWMSaX2plJh2ECGP6pobGez/hDtH0UV4Rc2GlxMKP/fXbF
	mFRHOvJDQ5/kcprfkbErcvoAO2cidfW1VgzDUdVmsiwoKZq51M2pIyMSiB9+mFd5e2Y+XE
	zIrWXd21uoO8qiwXwxlMoS1cEEkqb5V7RipLdtD1smpxlx42HVcI2xhjn7frxAydftEr9K
	BRNUqGr0Hyai2/OODFby0KhwLg52WWQJ0Ndu4cZfDaERlK07618LcHO8wB2hrcFgrUvMa/
	vQkCTJEDpb9ssDuGPZeYe/7oi7OrMmtFkutPvii2Ku6bc20iYPHtQno+K7cwGw==
Message-ID: <fe920b05-6d89-4dc1-83d3-0664fbc2e00c@nabladev.com>
Date: Mon, 19 Oct 2026 18:10:18 +0200
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
 <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
 <AS4PR04MB933821150913BDCF35C4827F88982@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS4PR04MB933821150913BDCF35C4827F88982@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/19/26 4:59 AM, Wei Fang wrote:

Hello Wei,

>>>>> +int enetc_mdio_update_mdc_div(struct mii_bus *bus) {
>>>>> +	struct enetc_mdio_priv *mdio_priv = bus->priv;
>>>>> +	struct device *dev = bus->parent;
>>>>> +	struct clk *enet_clk;
>>>>> +	u32 div, mdc_freq;
>>>>> +
>>>>> +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
>>>>> +		return 0;
>>>>> +
>>>>> +	enet_clk = devm_clk_get(dev, NULL);
>>>>> +	if (IS_ERR(enet_clk))
>>>>> +		return dev_err_probe(dev, PTR_ERR(enet_clk),
>>>>> +				     "Input clock unknown, not changing MDC
>>>> frequency\n");
>>>>
>>>> binding said clock is optional. If return failure here, it will block
>>>> existing dts, which have not clock property.
>>>>
>>>
>>> For EMDIO device, the clocks property is not added to
>>> fsl,enetc-mdio.yaml, I suppose this property should be added to the
>>> dt-binding doc if the clock is really needed here.
>>
>> Isn't this what 1/2 in this series does ? (maybe I misunderstood this
>> paragraph)
> 
> Sorry, my email filtered out the 1/2 patch, so I missed it.

No worries.

>>> For ENETC device, we already have a 'ref' clock in the enetc node, so
>>> devm_clk_get(dev, NULL) may get the 'ref' clock rather than the system
>>> clock of NETC.
>> Shouldn't the clock be described in the MDIO DT node ?
> 
> The enetc_mdio_read_* and enetc_mdio_write_* interfaces are not only
> used by EMDIO devices, the ENETCs and NETC switches also use them.
> NETC switches and ENETCs can access external PHYs or internal PCS/Serdes
> through their own port MDIO registers, instead of through EMDIO devices.
> 
> Your first patch only modified the EMDIO binding-doc, not the ENETC and
> switch binding-doc.
So I need to patch also 
Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml ? Any other 
binding document ?

Thank you for your help !
