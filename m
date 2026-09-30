Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE13921CE;
	Wed, 30 Sep 2026 04:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741964; cv=none; b=EKMFOyvsaLmuYE5hAwyMQUNdTJSmg535cQ4X6hJQzGUGWiUooVCnkmo9O7RgtKKhIqhhV8X6TRpPrK/QXbli6mk5EDnGs9yU9RCYY+NpwARHENAxHROhX4LzJTn9uujIjaULMvbwx8dMQeZ6FatddwefUPa5RYodgK827an2KOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741964; c=relaxed/simple;
	bh=W6oTjCqB7b/JzMZQ5GPKFWJ3siqJQajSbxgWS5eQuwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eei7oJmRlHbmugtRtRM1jBn9ucqvTNmp4umMrsXd8VZyZh5wh3Wow+Tnsfjd60+dZUOz0llyDQUYqarYcSY3mNq7vLaLY/ALJBOsFisCDAJXDg/vpqcXMrTSctKKB0VdqcM0Ux9Kp8RfBH6lqeO8D+kYEomyid3BVs2l9AjbebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=bZkj6nfp; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="bZkj6nfp"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60DEA106E14;
	Wed, 30 Sep 2026 06:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790741949;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gqTJHUz7tHNAEycDuNrzBNgDUuLLCrtcBiT40+X0peM=;
	b=bZkj6nfp8TaAHjFmXc+7PiYudfAKcHMYPf14BM93GeSkydWtQ+ULnDv2MsK/zPswhrMYuI
	DXyy99PIxruV3/vu7bTmCj72DnLZt/LIuZlyaOt3HutDZqHBw/oY2P0k4x36ExRHS4UUoQ
	M+RAGzxJYQE2Zl4gRymvlObp5hzMqzkgxzEWI4G5OGnKrhnrKt456fNVeU+QEvXOzsYxtl
	Ue5pbjNbJK8GG2IfQUGX/3UuKpcWDqcVM5dqnkDFztwxksJhpdBSeEMkl9HWobvVhOisb2
	IFvYLULOwFHOSAizMNXOPxbkxDxwx3faZGz93CSlh6KtxqxjpMMJyQJieW8W6g==
Message-ID: <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
Date: Wed, 30 Sep 2026 06:19:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
To: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/30/26 5:40 AM, Wei Fang wrote:
> Sorry, this email was missed because it did not match the filtering rules I set.

No worries.

> Hi Valdimir and Claudiu,
> 
> Please take a look at this patch, it may affect LS1028A and S32N7 platforms.
> 
>> The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,
> 
> The system clock of i.MX95 NETC is 333MHz, AFAIU, the MDC rate should be
> 333/(2*258+1) = 644KHz. I'm confused that why you said the rate is 558KHz.

That is what I observe on a scope on local MX95 board (not the EVK).

>> but also very compatible. However, for example NXP TJA1120 PHY needs
>> at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.
> 
> We previously used the TJA1120-SDBR daughter card to connect to the ENETC
> interface (RGMII) of the i.MX95 19x19 EVK board. However, we did not encounter
> any issues with MDIO access.

Most PHYs are fine with the low frequency.

> Furthermore, I did not see a minimum MDC
> frequency rate of 1MHz on the TJA1120 datasheet. I'm not sure if this is an errata
> of TJA1120.

The TJA1120 RM is not public, but look at its predecessor:

https://www.nxp.com/docs/en/data-sheet/TJA1101B.pdf

Page 46 bottom
Table 37. Dynamic characteristics...continued
Tclk(MDC) MDC ... clock period ... Min 400 ns

400ns ~= 2.5 MHz .

>> As a minimum change, increase the MDC clock to 2.5 MHz which matches
> 
> The prerequisite is that NETC system clock is 333MHz, so that you can get a
> MDC clock rate of 2.5MHz (333/(2*66 + 1)). But unfortunately, not all NETC
> versions have a 333MHz system clock. For example, LS1028A is 400MHz, so
> the MDC rate will be 3MHz, which will be a problem.
Yes, this is my concern.

Are those clock which feed MDC clock available via clock framework on LS 
? If so, we could calculate the divider based on those clock.
