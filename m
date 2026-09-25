Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F33B4432;
	Fri, 25 Sep 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326690; cv=none; b=bprWj696z0GBphiL+Odv3bVfG0sbvjm9Xn0KTGth5NuSV+4hqjbGiPo0RwQ19FH6GLh3X7JkqxetJ5IxkvmmSdPUHakHn6ucsJ7CyWd96KkKlbiKUt9V2hf+b+3V0+XnNOR4bmnBpqS0pEUy117GDtKUS4jxHB+z3WaOo5TfoY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326690; c=relaxed/simple;
	bh=CeunScU1sYCT3r/Guxyul91uD7K6PeXLLRf45vgb+PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gx0JFE3xWBzcEk253FwK13lR1/H26VZ/rmdoe7VdnWL4fNSk63psYbjBZRGg0wu6d5O9zK1uBcMW0YcjazZEZpBPk3WbSNCIwC5+irFWFce1KflIP5VudZhakaw1+zGBzDTHoGHCdrM2RW+u8iU+s2DMj1Onf7IJFiZVFio3CQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TqUsIQA4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TqUsIQA4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 92260C1398B;
	Fri, 25 Sep 2026 08:58:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC84F6073B;
	Fri, 25 Sep 2026 08:58:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 419DE10329598;
	Fri, 25 Sep 2026 10:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790326683; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eHCG0ODHZ7xlVaaRQu9FzyxyFGKDSMgb9j6Z9r2xLQQ=;
	b=TqUsIQA4JAmHsWeyPMnXQ/nzDgbLTDbnBS3DfTqvzdEa2cqChVQZoxcVWYKS2z9DwNkm8L
	tR9FP16IkoHDGz/T7tAvYvIQuD+Xllagg0IujDva8C6zR71AJOWMJSeTEEvLRciHIcnqIu
	ct1l+I4nBQeg2h1jsXX2WVzpGS+GjFySoaMvt9acHfYAQY4/64SQwT1MzLRgJPaGqdXJbD
	nqix3Vss/moV59ORfXdB8yhrpjoVJVURfobbYjeburgNajVIvA3DIDDY0GmL/4grtFz+P0
	PKaxUULPY0NM5PAOz6ODM/wdswTg8+70Cm47ENGWA7ib9jCL+aZuWGNtXpBAtw==
Message-ID: <e95bb870-11fe-4402-ade2-994b54fbf404@bootlin.com>
Date: Fri, 25 Sep 2026 10:57:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v17 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Aleksei Sviridkin <f@lex.la>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
 <20260910170103.1029108-10-maxime.chevallier@bootlin.com>
 <20260924220124.2129700-1-f@lex.la>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260924220124.2129700-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/25/26 00:01, Aleksei Sviridkin wrote:
> On Thu, 10 Sep 2026 19:01:01 +0200, Maxime Chevallier wrote:
>> --- /dev/null
>> +++ b/net/ethtool/port.c
>> [...]
>> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
>> +				       reply->interfaces, NULL,
>> +				       PHY_INTERFACE_MODE_MAX,
>> +				       phy_interface_names, compact);
> 
> The supported-interfaces bits are raw phy_interface_t values. OpenWrt's
> layerscape kernel inserts PHY_INTERFACE_MODE_2500SGMII between
> 2500BASEX and 5GBASER, so on that kernel every bit above 2500BASEX
> means something different than on mainline.

There's no such thing as 2500SGMII :/

This is an openwrt problem, they need to make sure their kernel headers
matches the kernel they are running...

Maxime

