Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199E3B0584
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672246; cv=none; b=YOVgUFs0x4fEMeRw0zlzFdJecr8Tqpuv9UpGYrMhwr55K78ESzDt2oNarEGcuZrMWSThV616L9eG4SXzMaciL9ODxwLOLafMJ5TZ+4Z3maBYNhTaGwwko+kX6pmD0GZTuobwH0fZTuaxd+JjaGd4gb184XivMTgNk0y5bfiZCLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672246; c=relaxed/simple;
	bh=fn01v37sTX+YflkjNpAtD8uiYjLXgWJk7Gmw9YTWLKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGSoI/JB5C7W6G/2Ui/lqbjd/qFLHpvUz/6w+V+VdkQ26BfjuzK2uKKnGju23fsECe6hhDlhdPVkLGzax0KlLT11eAYLQM2GYNf7rM1O6UDEBFKmaWBF0nkuJjD0aC+6IojsNawpHXUAtDPx+JtptAFRaQE2VcZ2e30R39Bw/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KgLqauzA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KgLqauzA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 32BDA1A1042;
	Tue, 29 Sep 2026 08:57:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFE24601BD;
	Tue, 29 Sep 2026 08:57:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB3F9103297AE;
	Tue, 29 Sep 2026 10:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790672239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=H5UwJNPGKcha+BEqcOeEOR60KH3Iqw+tbYJAQ8Lz5aY=;
	b=KgLqauzAR6/y8fJ7UrTmLhZEq9sGDWuoQKVmMLsfIXs8KOxeN/scZ0m7RstahgEovHqcsS
	RSCf/3vZO1swFxm4mQGCGMHb0ETcOsE4WtUpeAMZ6rfYp6JQbkmnvfG81zT9vDx8y0c/HK
	b0pwoZ1X3+ZR5hGZtpt2DxAItkfUQ8FYKku9b6bo1UF+brG9hHcRfq0g/mnwU68n7S1s0l
	MgEKP4EZv92gacR7fL//8mpexu493XGC5kHwsaLYR0v4iXK1+rqEyGk38uam2Cl3WCxAX1
	Wa/ikYwb6ksKP9OamsQwD1IE6+DQpdve/eKPUC7UhfkrQbr9axcSOu3oeFjOXg==
Message-ID: <71adb267-2dd9-4225-91e5-19848a87eb49@bootlin.com>
Date: Tue, 29 Sep 2026 10:57:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Don't set or get RSS
 parameters when not supported
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, nb@tipi-net.de, jitendra.vegiraju@broadcom.com,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com
References: <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
 <179067171307.434549.1093187286398187440@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <179067171307.434549.1093187286398187440@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/29/26 10:48, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch makes stmmac_get_rxfh() in
>   drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c return…
> - [Low] The commit message describes a user-visible bug: on stmmac
>   devices without RSS, 'ethtool -x reports an indirection table and a…
> 
> --
> 
> net: stmmac: Don't set or get RSS parameters when not supported
> 
> This commit changes the stmmac ethtool RSS ops to return early when
> stmmac_rss_is_supported() is false. The key and indirection sizes now
> report 0, and get_rxfh/set_rxfh return -EOPNOTSUPP. The aim is to stop
> reporting bogus RSS data and to make the RSS kselftests work on stmmac.
> 
>> The RSS kselftests fail on stmmac, and this is partly due to the driver
>> reporting bogus data for the RSS ops :
>>
>>  - ethtool -x reports an indirection table and a key while the hardware
>>    doesn't have any of that
>>  - ethtool -X fails with -EINVAL.
>>
>> Let's return early in the rss ops if we know the hardware and platform
>> don't support RSS.
>>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [Severity: Low]
> The commit message describes a bug that users can see, but there is no
> Fixes: tag.
> 
> Blame shows that the unconditional stmmac_get_rxfh_key_size(),
> stmmac_get_rxfh_indir_size(), stmmac_get_rxfh() and stmmac_set_rxfh()
> logic came from commit 76067459c686. The later refactor fb6e30a72539 only
> moved these functions to the ethtool_rxfh_param API.
> 
> Should this carry the following tag?
> 
> Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC core")

targetting net-next, problem always existed, doesn't crash the kernel,
it's just returning bogus harmless stuff

> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> index 1cf0f8820b33..56019683f399 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> 
> [ ... ]
> 
>> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
>>  	struct stmmac_priv *priv = netdev_priv(dev);
>>  	int i;
>>  
>> +	if (!stmmac_rss_is_supported(priv))
>> +		return -EOPNOTSUPP;
>> +
> 
> [Severity: Medium]
> Does this -EOPNOTSUPP break namespace-wide ETHTOOL_MSG_RSS_GET dumps?

This was reported by Nicolai already, and other drivers report -EOPNOTSUPP
here.

If we address that, I'd say we do that in the RSS ethnl code.

Maxime
