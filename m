Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159F3E8345
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282503; cv=none; b=ckPpLCCaiK7mgxAvmL+s4RLFIy7adMVg+vUz8sS/wzkCXfkEQzxspviQ8mRQZxUneGZQe4Ogjtm/Iyl1OrJhyHo7FxOK95zttqsbVRH/bTEnxKRxIUjQPdkq7NtSC9C7iSwzOlwmDiwC1vtjF+nxMhC/KSl0ToU6jBbKrNniqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282503; c=relaxed/simple;
	bh=rCW0XW339WQShVSkp/G/vr+Ov6bW/EF8t3dnY+O0Acs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ7hXp1iipH0CXtgbCkLJL9ZKjw+j/2AXgOxiABgPhfqodyjzoBzXHBGrwbUFFJzn4F39FFZZDA4+tnYA17lmRM/frvyLI3i2b8l1KGOKiy7R/vvfTlZC4CGN38MhADaFGoIYkvoGn7/aJ7dks79zZ4Rt5JIcNI7d5DIeoFD9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPLDKfxV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCXKmS8s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPLDKfxV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCXKmS8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784282501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlF929HUL2yF/ZKhW8onebAgtJEMRck4oEN/pqFd3go=;
	b=LPLDKfxVolQZ+elSqCKIc6oGQCqMkBBDzZaAh0QWDNX9cMU7DIm2AZg781+a/6kF2f6CJz
	WAUb61c74+5p4dL7ctnw+9rmmkKFkYXhremwdr9ADHvlVPv6dWGbA3uENXzkLIb9LVsaXx
	9gmK4aGhXiAv1zJoM4JRVkZ+dnj/f5o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-3o43yVDiOqmh2OYTll2mFQ-1; Fri, 17 Jul 2026 06:01:39 -0400
X-MC-Unique: 3o43yVDiOqmh2OYTll2mFQ-1
X-Mimecast-MFC-AGG-ID: 3o43yVDiOqmh2OYTll2mFQ_1784282498
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47162f83c75so788751f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784282498; x=1784887298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlF929HUL2yF/ZKhW8onebAgtJEMRck4oEN/pqFd3go=;
        b=bCXKmS8sl9dnlS6RSFDsafAbjMTT9j79TFIgvdAqyyAL+A6II/KgQkrZiiCvm5cXcg
         usL+TkTvOJQGIxrvsmJaxi6CZ4zcQjzYrCkTkolYaEgx/aIEso5munoOk5L/HSJ7mawD
         JfgtowhXXP/hrztGCC3w4u816rKqdvwYqeC/z0iYLcoBF0pm5mWJw3k1K+NZyaA4hXVT
         5vtMm2qKhSWF60OBlcKAVPgciPwZ9kilxWAuIrAOJ2Y6fpgYjqTBEmYw1ZtBw4vcHdpl
         /5xHyWdSJzCPx2JdrrqziH4ifqJT8grRA2WHXmC1kSX6wUaTe1QlpcRWtErorMj+K3YZ
         VbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784282498; x=1784887298;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlF929HUL2yF/ZKhW8onebAgtJEMRck4oEN/pqFd3go=;
        b=pEIBnFhyALw6o8MHKKr7YRAGy2DGQBkd1utLiEUhr4To44W1PXXk7hhqHuq4CRBzqx
         FeY8re8htxY0g5sjMLeMmlUaZZrmHPUeQLTYDzzhhRGzGvxFFIsl0Bj8GV2LHvYwkMgo
         gRuQgurWTeronZ9xSoCreUFXlXgPQuqgcMJfdYFHn4pLedMu8QFaoIvGBfTMIJ6lNoBn
         QYriNEFEgKS4PrbpZFxWsAcaRtZioCv+T8p+xUEDi5ODGow9jzkrTEjMvR7rM0zj+ZFY
         +Ds8pICKkCTiYi28ztB1vFspnH7z3ja0f6AeeJ+aI46n4XBILZSd1So5/tgD0vM2scgR
         wsTA==
X-Gm-Message-State: AOJu0Yy3P32DQV3lxze1cM6ccyFYMpA2V6LnlLjpEkEV4QtmHPlLvGX3
	5plmsLgL+ESe9HSjUjLLMNXhmuO2O02+R+V1Q8ficDgjnjGtxQqnpe+1H0bofZGh3+jHxbHBo7l
	9bWQWPXZ0n1k8Ee9PPBDDUihZcfcB1uJ1AP4UCkeJarx+fMo7YmKhxU8WtA==
X-Gm-Gg: AfdE7cnPhPN9ZSQ3TBhajxHSrWBrK2pE9a67rEOiQ5Qn1i1Vn8oHnMMKTf588awyoQT
	ptPyc4pH3TQFPwtAjxB8e3xJi82KiuucqgzV7qtXxgEX5gEQYsm2zs5TnwRUvWHBnfP7W5xzaK4
	TADd2/YMmLmlVY9edC4Hw4zEmyqSHqInX3nT6LBFzxBiqsrlepqNEpayyrC4zpuhg9EXmnBIfRm
	HpKJOK/RqgBJr3Z9Ko4lE2F81NyJY+ai4rIy8D7nqgTT2UVWzjcBJ5IWX4d9PCZz21t+yA7A7S0
	Q/pIZz8FAgd0dMePLnh0WDhj/0KyAIo9IhyBTPcfLNZ4i8js7E+qXe/1Z3pnLSG5+rMvkk5IqhP
	cyWdCxluQB6p9yeemGLHT8jXGj8QCXAuhDDIsKLhgL0bIR03rL8XdcRSGvepxzLM04FbJYotZ3Z
	K9YQ==
X-Received: by 2002:a05:6000:1885:b0:47d:f6a5:1fd6 with SMTP id ffacd0b85a97d-47f623f189bmr2298607f8f.26.1784282494103;
        Fri, 17 Jul 2026 03:01:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1885:b0:47d:f6a5:1fd6 with SMTP id ffacd0b85a97d-47f623f189bmr2298025f8f.26.1784282489513;
        Fri, 17 Jul 2026 03:01:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49500sm2394927f8f.2.2026.07.17.03.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 03:01:28 -0700 (PDT)
Message-ID: <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>
Date: Fri, 17 Jul 2026 12:01:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
To: Michael Walle <mwalle@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
 <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 4:47 PM, Michael Walle wrote:
> On Fri Jul 10, 2026 at 4:39 PM CEST, Sean Anderson wrote:
>> On 7/10/26 10:22, Michael Walle wrote:
>>> Before converting to the phylink interface, the init function would have
>>> set the correct I/F mode depending on the maximum link speed of an
>>> interface. After converting to phylink, the established link speed
>>> is used to determine this setting and is set in the .link_up()
>>> callback. The callback isn't called because the link is never
>>> established between the PCS and a connected SGMII PHY.
>>> To fix it, don't use the current speed, but set the mode depending on
>>> the interface (which implies the maximum speed) in .mac_config().
>>>
>>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>> ---
>>> FWIW, I dropped setting a non-reserved mode in init(). The hardware
>>> default is 0 and the mac_config() will set a valid mode anyway.
>>>
>>> Changes in v2:
>>>   - the setting is/was based on the maximum speed, not the current
>>>     speed. thus, move the setting into mac_config().
>>>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
>>>
>>>   .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
>>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> index fe35703c509e..7075f93bab49 100644
>>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>>>   {
>>>   	struct mac_device *mac_dev = fman_config_to_mac(config);
>>>   	struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
>>> -	u32 tmp;
>>> +	u32 ecntrl, maccfg2;
>>> +
>>> +	maccfg2 = ioread32be(&regs->maccfg2);
>>> +	maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>>   
>>>   	switch (state->interface) {
>>>   	case PHY_INTERFACE_MODE_RMII:
>>> -		tmp = DTSEC_ECNTRL_RMM;
>>> +		ecntrl = DTSEC_ECNTRL_RMM;
>>> +		maccfg2 |= MACCFG2_NIBBLE_MODE;
>>>   		break;
>>>   	case PHY_INTERFACE_MODE_RGMII:
>>>   	case PHY_INTERFACE_MODE_RGMII_ID:
>>>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>>>   	case PHY_INTERFACE_MODE_RGMII_TXID:
>>> -		tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>> +		ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>> +		maccfg2 |= MACCFG2_BYTE_MODE;
>>>   		break;
>>>   	case PHY_INTERFACE_MODE_SGMII:
>>>   	case PHY_INTERFACE_MODE_1000BASEX:
>>>   	case PHY_INTERFACE_MODE_2500BASEX:
>>> -		tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>> +		ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>> +		maccfg2 |= MACCFG2_BYTE_MODE;
>>>   		break;
>>>   	default:
>>>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>>>   		return;
>>>   	}
>>>   
>>> -	iowrite32be(tmp, &regs->ecntrl);
>>> +	iowrite32be(ecntrl, &regs->ecntrl);
>>> +	iowrite32be(maccfg2, &regs->maccfg2);
>>>   }
>>>   
>>>   static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>>> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>>>   	iowrite32be(tmp, &regs->ecntrl);
>>>   
>>>   	tmp = ioread32be(&regs->maccfg2);
>>> -	tmp &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPLEX);
>>> -	if (speed >= SPEED_1000)
>>> -		tmp |= MACCFG2_BYTE_MODE;
>>> -	else
>>> -		tmp |= MACCFG2_NIBBLE_MODE;
>>> -
>>>   	if (duplex == DUPLEX_FULL)
>>>   		tmp |= MACCFG2_FULL_DUPLEX;
>>> -
>>> +	else
>>> +		tmp &= ~MACCFG2_FULL_DUPLEX;
>>
>> Did you test this when forcing 10/100 speed?
> 
> No I didn't. Well I can't. I have a very weird board which only
> supports 1000base-X (and copper SFPs in 1000basex autoneg mode). On
> top of that there is a Marvell 88E1112 in between the SFP and the
> MAC, for which the PHY driver is completely broken. Long story
> short, I'm not able to test that (yet/at all? Not sure).
FTR, sashiko suspect this patch will broke such setup:

https://sashiko.dev/#/patchset/20260710143430.2276141-1-mwalle%40kernel.org

I think we need either an explicit test from a 3rd party or a new revision.

/P

