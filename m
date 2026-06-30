Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E23D1CCF;
	Tue, 30 Jun 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803453; cv=none; b=OEww4ttPJZgu54qNjJproBYCxU3QTCa0LBXqDN0ReP7JU4dfqXT/minLehJjr8PK61bItsjZkFss1i1tHws6/V5Ptl63wPrEDdbX7j8tzsboRtedi8NZiQSz+zmq4lZwGVTpUJVZ5ecypbTvgzBh7D0thQPg7BR54VefUmaAfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803453; c=relaxed/simple;
	bh=coe15ogFPnrnNLGsSFkOoXrK9juFWi8tMyZD8xBfr7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xtp5TeBQ0KGL8ip2nbiZ8DZOGPdt9iJozFjEEQtdxip5nP2J2Azj7K4wb1/Uw2TbKj8nE6vS/xQ4IO5qBm7kRQNdUHasomy6KQILaZG+smaFldA/CeBOgQhmqIcxNGFXAS7n6/ZrXGYwdUiEpvka7egn5KHUFjP0Th522TbDpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ukauNkjo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ukauNkjo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EFF13C5CD4C;
	Tue, 30 Jun 2026 07:10:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6543F60233;
	Tue, 30 Jun 2026 07:10:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7836106F1C3F;
	Tue, 30 Jun 2026 09:10:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782803447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2WEvFOUe3RFPl/fYwecdyACzR7RbrE8OMXLcd2G9smQ=;
	b=ukauNkjoFa+Izzi7oPn2g0tA9q7whk8DxJSbSLP4SFqYdfTnlnKGZ1S4XqYxEEwP8ROc9E
	HBc0hiAPp7t+IiAp+olwJx+tnk551HcHvSjWCDN0CAqAC9n0GWw0PdeayEatvn0B87x+i2
	UtCQ70rLf2WOGxPOPxiLprWMeC8InZK5XbLOStrcUyN9FT/CSPIE8djSzaSgoUsGbVtrxe
	ZHuWI77VuVPssz2DRPOR0uitBZkzZoNSB2PL41BJvUg7Ik0Og/41Mijhl8L8HyfqFLpmni
	K2yR3zqh15Dqv+kBkWLY7EwbaAqDcVbg9hQlF4vujxerOUvHat58mr27FL4SvQ==
Message-ID: <0083a957-7afb-489b-b2db-de3acd71b445@bootlin.com>
Date: Tue, 30 Jun 2026 09:10:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/6] dt-bindings: ethernet: eswin: add EIC7700
 eth1 RX clock inversion variant
To: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 weishangjuan@eswincomputing.com, horms@kernel.org, lee@kernel.org,
 wens@kernel.org
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063239.1158-1-lizhi2@eswincomputing.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260630063239.1158-1-lizhi2@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/30/26 08:32, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> The EIC7700 SoC integrates two GMAC instances. The eth1 MAC exhibits
> different RX clock sampling characteristics due to silicon-inherent
> timing behavior.
> 
> The eth1 MAC has a fixed, non-configurable RX clock-to-data skew at the
> MAC input in the order of 4-5 ns. This cannot be compensated solely by
> the standard MAC internal delay configuration and PHY delay, and RX clock
> inversion is required at 1000Mbps for correct sampling.
> 
> The eth1 TX path also includes a fixed silicon-inherent delay of
> approximately 2 ns. This delay is always present and cannot be disabled.
> It is therefore part of the effective transmit timing observed on the
> wire.
> 
> For the eth1 variant, the valid tx-internal-delay-ps values include
> this fixed delay component. Consequently, the effective range becomes
> 2000-4540 ps (approximately 2000 ps fixed delay plus 0-2540 ps
> programmable delay).
> 
> Introduce a dedicated compatible string
> "eswin,eic7700-qos-eth-clk-inversion" to represent the eth1 variant,
> allowing the driver to apply RX clock inversion only when required by
> hardware variant selection.
> 
> This keeps SoC-level differentiation without exposing silicon-fixed skew
> as configurable device tree parameters.
> 
> To reflect this, model the TX internal delay as a base 0-4540 ps range,
> and constrain valid values per compatible using conditional schema rules.
> 
> Update the binding schema as follows:
> 
>   - Define tx-internal-delay-ps as a base range: 0-4540 ps
>   - Add compatible-specific constraints using if/then rules:
>     * eswin,eic7700-qos-eth:
>         max 2540 ps
>     * eswin,eic7700-qos-eth-clk-inversion:
>         minimum 2000 ps (effective range 2000-4540 ps)
> 
Maybe Andrew can help answering that one, but does it ever make sense to insert
a delay beyond 2540 ps ?

Maxime

