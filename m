Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFD38F24F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628080; cv=none; b=bz5UoFghWTkYFp+tAZ+Yxs1IsZiYGbke5ndbsFSSFmzGa8/68bUOkrevPI00h551W6C0cq3QPdr5MQmo5nnB4O3n86nE3bWFeyDB6iuS3qsjCanMP5ItIkDPJdYuFy4XFMbCAQyLxIhSKNCfhsiSItyUMZ+CQgBmsUyTJnquQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628080; c=relaxed/simple;
	bh=va5lIycxnTKYt5HfD45SzBTgb4p72ZnN7bue4cjd3QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ntk0FzvJGsnrOHebw/m1Go/oc8AtpXEU809YuJZmxntyYFzjAuz+KM333d+jfQVp28uzefXNUxZknpO8yYJPm1VnBI65rmk0a0UVYZ20fHzIKWF2j8f3Hqqwcunn5dRtlC8YDrDn3wHLTbUNNtVh0Ay+hVsp/KNYHjRe5V+FQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F09OQfoE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F09OQfoE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 287421A1131;
	Tue, 21 Jul 2026 10:01:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8E3860368;
	Tue, 21 Jul 2026 10:01:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8A0411BD3B3C;
	Tue, 21 Jul 2026 12:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784628073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jhh9IK+rT66VZNU2sloXw2cDlu3T2Nk4oei93xkVNBg=;
	b=F09OQfoExNE31a1YryyV8pfFiNgrzdpiSUF2LVDjJtrCAny86c19c/Gs6OwlCwmO+dAUn5
	zAS8YZs37USAxfFAwzJYtf5ght8ILp9BFMBE2/AUhtufiRjmKaUWZ1byCwzWFXTaniLgpg
	sKDAzq7yEnV6CotZqOzRxZQB3348HbzdZRcpmwQY/HskpqW7/192T7OQahaZSV0Nfx+utf
	MyRyERrGoBsi9J8Rv+9jYMfwWz9InI2PJ8WWele36JcaVZ4AwHwcz53iRByalWs97s/Gfa
	lErZrhex34nQlcjdNrFD5anXCNekKjYgkyrI7vw5DucW1NMXmNrcnpOkJwRWBQ==
Message-ID: <c1e3f0c6-89a7-42de-ad77-aede3cd93ea5@bootlin.com>
Date: Tue, 21 Jul 2026 12:01:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
To: Javen <javen_xu@realsil.com.cn>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
 "daniel@thingy.jp" <daniel@thingy.jp>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
 <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
 <aeed474059bc4fd7b9c5e3074ef591a4@realsil.com.cn>
 <044a9996-1cd0-49c4-892b-fb267037c568@bootlin.com>
 <ba61c475562f49c4a18038130f3508bc@realsil.com.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <ba61c475562f49c4a18038130f3508bc@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen,

On 7/21/26 11:52, Javen wrote:
> Hi Maxime,
> 
>>
>> Hi Javen,
>>
>> On 7/13/26 09:51, Javen wrote:
>>> Hi,
>>>
>>>> There's a change in the MAC's ability to support Pause, so we should :
>>>>
>>>> - Recompute the pl->supported field. Update the
>>>> config.mac_capabilities with the
>>>>   new pause settings, calling phylink_validate() should do the trick I think,
>> this
>>>>   will rebuild the capability list:
>>>>
>>>>   phylink_validate(pl, pl->supported, &pl->link_config);
>>>>
>>>> - Then update the pl->link_config.pause,
>>>>
>>>> - Then update the pause advertising, like done in phylink_setpauseparam
>>>>   ( I think, everything that comes after pl->state_mutex gets released in
>>>>    phylink_ethtool_set_pauseparam)
>>>>
>>>> Ideally, the logic to update the advertising and re-trigger a
>>>> negociation should be factored out in a private helper, then reused
>>>> from both this path (MAC updates pause support) and the
>> phylink_ethtool_set_pauseparam path.
>>>>
>>>> Maxime
>>>
>>> Thanks for review and helpful suggestions.
>>>
>>> I agree with your suggestion to factor out the logic into a private helper and
>> reuse it for both phylink_ethtool_set_pauseparam() and
>> phylink_update_mac_pause_capabilities().
>>>
>>> Here is the refactored logic. I want to share this specific part with you for a
>> quick check before I submit v7 patch.
>>
>> I'm currently attending the netdev conference, It'll take a few days for me to
>> look at this, sorry about that :/
>>
>> Maxime
> 
> Just a gentle ping on this thread. Could you please take a quick look at this refactored logic whenever you are free? Any suggestion would be greatly appreciated.

Thanks for the ping, I just looked at it from a high level and this is the
thing I had in mind yes :)

I think you can post a new revision then.

Thanks for that work,

Maxime

