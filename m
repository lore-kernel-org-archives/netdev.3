Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09633BCD1A;
	Fri, 16 Oct 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179060; cv=none; b=QLmFr9moIjMK8DTPEEwRTqUUnlcNChHAhqxYcaYEKQZRX8uKWSL4OvACufOBDpgjmWhgVdxFeUbCdpWH0a/cC+VXESCRTjSVy6HELdaH7wwlWrsuT75+Y+C2AKMiGgar5kNZ3gwZfLLehxhvGugjc9A46Uy9MfATXXe2uNGmIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179060; c=relaxed/simple;
	bh=45U0Yo+9dc437szOY85Y5vFkWH3SF+AlY1EEU1xrMmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU5gZ3G9hXgVro7aBSCTC8zB2+nGvuS2/F6s9ggsi1shIAG4DODad9pTa+r5cnMjDC0N4qHOxtAZIt+SdonXevmizRjMuA6ry3l+RjvCDZzQnce9KKOwbe6WvKI09YGtnTwOVrydJLd07Nc1XpOSMH132xg1CTTQpKp/i24qvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=WMIvn7+K; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="WMIvn7+K"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 543E21095A8;
	Fri, 16 Oct 2026 21:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792179051;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Ftac5hNpu73HqQ+Lp14U18oLY21RAU8CtkP/Hk44Pww=;
	b=WMIvn7+KxB/AdvL8u2kr16MS8bdozpz7l7bTCcBpRE8L9b1wxp4wS+dc2dywASQOBcaWgQ
	PVuPGI5qqrKhLMi507U3RWAhgTvqY9rPGeuSeDxXRi5UpbAHJ+qYNVVHS3ADa15Mp3dT5d
	lnYnP+E9NwrKPxW6tbm+G6XWkZ124/dbU6gq/DlyGCzKrumcZJg8DRY1GC6dudigcgxDvD
	Twjj5qdFdaLR9LqU6zyudCefCk4ceqB3rWukFdKaK9aEcM4fafWB9rKNmX9A45pEyHo0aQ
	/6Ot7KrNOFaAwF7ywLghdB0KNyUGq8T+f9G5fw4d3MAEaCJ5qZwC6HXiGBU7AQ==
Message-ID: <cea83807-2469-4d9e-b331-aa7e4e31d88b@nabladev.com>
Date: Fri, 16 Oct 2026 20:18:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on
 i.MX95
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 xiaoning.wang@nxp.com, claudiu.manoil@nxp.com, edumazet@google.com,
 pabeni@redhat.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261001223947.60189-1-marex@nabladev.com>
 <179121421089.434549.4883192954268711704@kernel.org>
 <20261007172230.53347039@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261007172230.53347039@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/8/26 2:22 AM, Jakub Kicinski wrote:
> On Mon, 05 Oct 2026 15:30:10 +0000 netdev-bot+sashiko@kernel.org wrote:
>>> -#define ENETC_EMDIO_CFG \
>>> +#define ENETC_EMDIO_CFG(mdc_div) \
>>>   	(MDIO_CFG_HOLD(2) | \
>>> -	 MDIO_CFG_CLKDIV(66) | \
>>> +	 MDIO_CFG_CLKDIV(mdc_div) | \
>>>   	 MDIO_CFG_NEG)
>>
>> [Severity: High]
>> What divider do the other users of these accessors get?
>>
>> The exported enetc_mdio_read_c22(), enetc_mdio_write_c22(),
>> enetc_mdio_read_c45() and enetc_mdio_write_c45() are shared with several
>> bus constructors. Only enetc_pci_mdio_probe() sets mdc_div.
>>
>> These constructors install the same accessors but set only hw and
>> mdio_base:
>>
>>    enetc_mdio_probe() in enetc_pf_common.c (PF external MDIO, LS1028A
>>    and ENETC4)
>>    enetc_imdio_create() in enetc_pf_common.c (internal Lynx PCS MDIO)
>>    netc_port_create_emdio_bus() in drivers/net/dsa/netc/netc_main.c
>>    vsc9959_mdio_bus_alloc() in drivers/net/dsa/ocelot/felix_vsc9959.c
>>
>> For example:
>>
>> enetc_pf_common.c:enetc_mdio_probe() {
>>      ...
>>      bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
>>      ...
>>      mdio_priv->hw = &pf->si->hw;
>>      if (is_enetc_rev1(pf->si))
>>          mdio_priv->mdio_base = ENETC_EMDIO_BASE;
>>      else
>>          mdio_priv->mdio_base = ENETC4_EMDIO_BASE;
>>      ...
>> }
>>
>> mdiobus_alloc_size() allocates the priv area with kzalloc(), so mdc_div
>> stays 0. MDIO_CFG_CLKDIV(x) is ((((x) >> 1) & 0xff) << 8).
>>
>> As a result, every C22/C45 transaction on these buses would write a zero
>> clock divider into ENETC_MDIO_CFG. Before 587acb86d646 the value was 258,
>> and after it the value was 66.
> 
> Looks legit.

Let me fill the default into Ocelot and enetc_pf_common.c
