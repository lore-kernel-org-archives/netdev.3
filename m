Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE64A3F25;
	Thu,  3 Sep 2026 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438654; cv=none; b=ovi4nd/+pAky2gr+qB4jbxCr3YtCvViya8JbBbYAfF5SBulQCZAGxvsHeC+AhOBM9WI8srzjMPOklWwr/fnOaXQINT4TBehzhJRHSWI7tk18N6YYKFE6z7PeT8LcNhFe8WuivMgEo9LkH9nxqOSjhShyegZgzCmdB3UDubadlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438654; c=relaxed/simple;
	bh=c3I4ymVjsts3J6RNRMAF54snNuPusZgDAN74nnp0/Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUXHnnBCetq0Ae4JIbtVM6VDiT5+M9RdTttmhcrYEKNudYUwbkQKMkKIZtDT+lpWFbFiHZ9gVSjB/xHMswILd5Jclt/qBs9GwnyfGgckM9gnd3hb7/akxVaAy8ugVwAvhvgB2ob1GmhZMZ4tnDoHtQLwBsrTMNoYDnidjxarm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KJzdzXBf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KJzdzXBf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 683231A197C;
	Thu,  3 Sep 2026 12:30:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 387AC602B8;
	Thu,  3 Sep 2026 12:30:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C87F11C7A19D;
	Thu,  3 Sep 2026 14:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788438648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=30P0mS+0MFmck9EFC/85NlKC+HMHgYOVgWAeHcXr+5M=;
	b=KJzdzXBfRkaqEJ7b7KhYBHtYs6HDd4TYF3uCKmxvH5wyvYkQCA1OtOXtozzK//ytVxdF5K
	LUjPG9h5vAhCyJ5MDHzPGvO6gyTiHe7Pol1hH9V3MIy2kCxI3Uf97aUibXjc7zhATC+bs4
	TP7hiTZMqO/EpHqqSMCiAcHsS+K4s4CuHARIHoTA2oY3PKCNt8VgJK4YRb4MBguR/yQrl6
	nG7DMkA+JYI/uBSf9RcRcLrDTVy47EKnF3ALs8+9i3endbpZosg2PV7k+HzeSfDAAM4ChB
	ryXW4QXB7glSmbWN9RO/jeXi6bMTD60qFcFdrwPVbE5kDCXhjvaRG2RRmqc/Ug==
Message-ID: <8611dff3-56ea-4798-8303-b0a8af84580e@bootlin.com>
Date: Thu, 3 Sep 2026 14:30:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add UltraRISC DP1000 GMAC
 support
To: Andrew Lunn <andrew@lunn.ch>, Jia Wang <wangjia@ultrarisc.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>
 <910be156-b631-4b62-972a-79d9a9e38697@lunn.ch>
 <178842162417.2701756.3296149694160507506.b4-reply@b4>
 <1622b0a7-5516-4e72-b5e1-60c12b65b52e@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <1622b0a7-5516-4e72-b5e1-60c12b65b52e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/3/26 14:10, Andrew Lunn wrote:
>>> This looks to be 90% identical to dwmac-sophgo.c.
>>>
>>> Do you expect any further changes to this driver? Is everything
>>> supported? Are there more clocks? A GPIO for WoL?
>>>
>>> I'm just wondering if the common code should be pulled out, or even
>>> dwmac-sophgo.c made generic so it can handle all plain boring devices
>>> which have RGMII delays and not a lot else.
>>>
>>
>> The probe boilerplate is indeed largely similar because both drivers
>> use the common stmmac platform helpers. However, their platform-specific
>> requirements differ: Sophgo requires additional TX clock handling and
>> other configuration, while DP1000 requires fixed TX and RX delay
>> handling. ACPI support under development is also intended to use the
>> UltraRISC glue driver.
> 
> ACPI is going to be fun, since nobody does ACPI networking.
> 
> But how big is the change to the glue driver? I expect the change will
> be minor, a call to devm_stmmac_probe_config_acpi(), in addition to
> devm_stmmac_probe_config_dt(). Anything else?

I agree that if ACPI support is added, let's try to make it part of the
core.

> 
> One problem the stmmac driver has is cut/paste glue driver
> development. The same code is repeated again and again. Russell King
> spent a lot of time and effort trying to reduce the duplication. So we
> should not be adding more duplicated code unless it is actually
> required.

It seems to me that all the RGMII handling could be made much more generic,
as this is commong pattern in glue drivers :

dwmac-sophgo has the "has_internal_rx_delay" field, and dwmac-eic7700 has
both has_internal_[r|t]x_delay.

With this third one, it makes sense to start sharing that logic across
glues.

Maxime
