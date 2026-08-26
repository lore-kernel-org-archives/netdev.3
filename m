Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145E48381A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775865; cv=none; b=PyIeqBoGlqJDfCxrl/wr/kTFdRrnOvqzwOc5MSnYd/9nEf1xNRvBTyFzKc+CJh4W9/q0WDvQ7UDBr1SQ5Sq1WHun7OMOGb1UszmYamMlbIrkyX+y7m5v5bJxE3+5Lhtoub/yIXHEgum31YQo8vM8IM4/CnI0vL+Lefqt/YJPbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775865; c=relaxed/simple;
	bh=svIkOf/v5aT22FomNAh1zzSGPmFhoqLQRx54nVG+t/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjYMNw0TgTTuT+Qqk4AtBL4lu2LGliNlzjtAirV7XxOJugEpX1gnLJgiOdxSNKCDlpc5mn+m9Z+oPNBFw1tlIu2nX9LvBWxLtmIf1iMnBWMD6k8W0auyujMcQvg2+hcna3g71wXRAbkb2M50FWS4ZkmjbxblJ31tdrVN1e7uArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VlA5J1cH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VlA5J1cH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 226D44E413CC;
	Wed, 26 Aug 2026 20:24:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB7F0604EC;
	Wed, 26 Aug 2026 20:24:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04A9C11C78051;
	Wed, 26 Aug 2026 22:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787775856; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=flnw4YFK4nn1JRtl3vh2WWZ6rVH7arDpTg03KSn5OIQ=;
	b=VlA5J1cHVpEd9kEiVxwJcKflxfDypdppGrggNcyw7rxRmJ+AuLAA/6+uCm6wCFeE82DX4E
	kDnlPG4inybAFRsrNfmE/1Ix8AujGPlJ+RTMkKQq2p43da649RnlSQOgL9uNEmCPkbxQQJ
	7d/zY4Uc0VmfqcRptLfFR3idsbbIO4/EyP9oxhtnJ/b0bN/UBAyUHczkC/ymMpdEMXL4dO
	WYLRpDkGTYbxLS5ArRO0VHNuQcdoBZPUVj0qn0yRmEbmQfs+agENzVSo+wmmKaTwWGuJhT
	Q80sLBcnc6zRLhS/5i4cVtwi6v+HgZ3qiGWg9bKOmlQ4NoWWzIpCKVSrLzN5sw==
Message-ID: <5bf8b713-55aa-4dd6-ad8c-afaa96c787dc@bootlin.com>
Date: Wed, 26 Aug 2026 22:24:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/6] net: stmmac: selftests: Check multiple MMC
 counters
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260826140500.616466-2-maxime.chevallier@bootlin.com>
 <3d6e75eb-be26-47a2-96de-d29c0b634bfc@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <3d6e75eb-be26-47a2-96de-d29c0b634bfc@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/26/26 19:14, Andrew Lunn wrote:
> On Wed, Aug 26, 2026 at 04:04:53PM +0200, Maxime Chevallier wrote:
>> The MMC counters report MAC statistics. Multiple counters can be
>> enabled when the IP is integrated, however there's no way to know
>> exactly which ones. Un-implemented counters seem to report 0.
>>
>> It was found that on StarFive JH7110 and Amlogic SM1, the counter that's
>> used by the selftest (mmc_tx_framecount_g) isn't implemented, triggering
>> an MMC selftest failure.
>>
>> Both the above SoCs seem to implement mmc_rx_framecount_gb, let's use
>> this counter as well for MMC counter validation.
>>
>> Note that this doesn't guarantee that we won't encounter the same issue
>> again if another IP implements yet another set of counters that don't
>> include that new one.
>>
>> If the game of whack-a-mole with implemented counters becomes too hard to
>> maintain, we may simply consider removing the MMC selftest entirely.
>>
>> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Seems sensible.
> 
> If more moles need whacking, we could consider the value of 0 as
> success.

We'd need to see what the values are on platforms that don't implement MMC
counters at all, what the registers read in that case.

Another approach is to bruteforce the selftest and look at all the MMC counters,
passing if any of them changes during the test.

> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew

Thank you :)

Maxime
