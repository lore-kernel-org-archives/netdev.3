Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2C383987
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286691; cv=none; b=TvPSp5bEewUmT5hwtC5xnhZn/jL8tGKTOmBwZ33THCuH5/I8yrvFJ3Tx/V8Cs09Lg/AL/sk9WBTM9o/gzYK20mDJGTj0q3uwDetCtIip1OK4U/uqcdXhx0oBXJdFIKUhluQ3W8Ci8Cg/vxyBnX5Sdaeu0UpWQUsubUourRdnu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286691; c=relaxed/simple;
	bh=Wd3KSlAioJV/7oPp15oN/oAaKkVCnRLCkMXjFYtEoTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCKTSsOkCt6dcpUlY53aFePqwCpe7y0l/2GtWHm7/9Lr9Clz6R7fTNk0KXfbN8swQ1J4OyHZEftzz6vzawFyBhwDHAOb9KaiaPooYj/tnIe8whhNEN+VK8EHOlYJZkQTE6NXCSvIYJoYh58zfrrMQdnMp0EnpE9gQEJMvN5hau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wigh9B3r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR2zNMjC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wigh9B3r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR2zNMjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784286688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHIfBM0S8wL95GpNTxr+CMsZKZuRkWlh0xl4GFsFICM=;
	b=Wigh9B3rgtNUtKnFGLceVhO4A78REzfeF3Bqi0cSkFwbz05J60oo3esaSvTN58a0nUdJSs
	/wZwodpFZHxaRTneI342/5V/3jvAtA+yKLyA9PW2czdvT/q+dLfc7qx5O+c7WNB1Ga4ifT
	BNh3tIfmFKseAaHO4Dg6Eu7ciZRNQhA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-hjxSrOnVOx-WX08L1HFBMw-1; Fri, 17 Jul 2026 07:11:27 -0400
X-MC-Unique: hjxSrOnVOx-WX08L1HFBMw-1
X-Mimecast-MFC-AGG-ID: hjxSrOnVOx-WX08L1HFBMw_1784286686
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472a798fc7cso3193608f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784286686; x=1784891486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHIfBM0S8wL95GpNTxr+CMsZKZuRkWlh0xl4GFsFICM=;
        b=DR2zNMjCP+6RIeVlLtj5rHEYkoME3ZVcl6DaH1BsIf10AIH3Ay14qnGKf5fJSZ7CT0
         zTfU9M4gCdjETciyLPm/REMm6pKO1zPZob2rROQ3mxEuZcdxx7pPRed/sSn46dEKM6qj
         w6A4GHQO040XTEflbWJHFJthZPUqhBkrhAi8xASkrsk2IXYWJaNQ+o6tekmIlSODOUVi
         p/q2eBT8eP06LMcir7ydrKd2mMmCJwBvvjhDYUyaB/LdDCWft+t828e/tyypX71hrkLN
         hYKz9BAakHZjElCwYl5AnP+prcxO06oyD5//t8h1kAaNZ2Qwcb7PBipzJ9VmH9TZAPIi
         E4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784286686; x=1784891486;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHIfBM0S8wL95GpNTxr+CMsZKZuRkWlh0xl4GFsFICM=;
        b=OWoMPzu1OLcJMNK0lyntAtXW8bsNL4buElOnbNw7OELQ6QIeOgtfcihv6CzNpgDBOF
         0nZXGRNbsIssNOjWfSMyM7jKUgcjR/Im44NvBliQMWpsBk8poHFoD+TL+9wyLLIvXWPj
         9ppW3F8w12H9kDOtXPw8iB077brNRCowe55g/vG9tUBufCpAqdogaSuvna7jjGisTevd
         NtMB1yJf1+tZGEbh8uBlA7CWgqWXDZcIU8e+OglZp2uMEcwdPJXQJQl/ZqWbXmAb8pCw
         0vaUDjbiEupFdVm8hErRJMN1awv21JUNhlJiDSwVHMGzCtxJZVrd3uA9q5k+C2lmob8d
         /80Q==
X-Gm-Message-State: AOJu0YzuaRe9S/uk3kAXlqH4QY1i2rtpYmuvkbb2pHNPsT0rJSJQnISI
	kfNZOE04FSMKGaKv6+vAqVy94lLW1+F+9QoqEGwVC0rcntyJwNolrgQ2lbaQ6+zrZ1d7RIkz20b
	W2+RcL0hV+aAwV6gPisiVs09lVPwjUIAQh4IjhDWZ4a8+DIXSBBbVI8DLJQ==
X-Gm-Gg: AfdE7cm/vnNILyl20Sp4r/JHex4w6bxaD0gK9nbCCAvDGStW3utSkoN9vFbpuDb1TOO
	yQ7XjwHddtZ0IJBBfMpx5TE9DzrOMpyclcRVuTJc/piG25tV/S5+Ceq0rIyTqQ1bfPeOwL++cYQ
	H/BLObhlrzCJRI0QsE7iMU8FSoefnYCPd3R/OfA+skdG6w3P4lLRQC0AbQCjymgUbd2S7aUpstw
	rm2XsJSOxPZafImzxT+PhaNto025vGD27n8fi0VIKlXuEN08zlSGyQPXdpzqFixgu7KfG1p2Vo1
	kzmGqPQ7oj2N8/hEOYD1P10TCXK7+ev7Hn24Y3rx4MSAtLgpUsNdHT4qtb7XcnY6XyQ1xcR71er
	ywMIm4PMytbcdMJTTd6Icfrc5kirPU7w10m34BpRBCCHuaWLWkvmP+WYrzlTCUPUsQVuXvXXiBz
	WEQQ==
X-Received: by 2002:a05:6000:18a9:b0:478:33fe:f97c with SMTP id ffacd0b85a97d-47f62314fb3mr3114972f8f.26.1784286686033;
        Fri, 17 Jul 2026 04:11:26 -0700 (PDT)
X-Received: by 2002:a05:6000:18a9:b0:478:33fe:f97c with SMTP id ffacd0b85a97d-47f62314fb3mr3114916f8f.26.1784286685412;
        Fri, 17 Jul 2026 04:11:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed2313sm2733376f8f.23.2026.07.17.04.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 04:11:24 -0700 (PDT)
Message-ID: <26cb3349-5344-48c0-b0b7-37133b4e0662@redhat.com>
Date: Fri, 17 Jul 2026 13:11:23 +0200
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
 <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>
 <DK0RLUBEKFVS.168UHY5BP8D4E@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <DK0RLUBEKFVS.168UHY5BP8D4E@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 12:13 PM, Michael Walle wrote:
> On Fri Jul 17, 2026 at 12:01 PM CEST, Paolo Abeni wrote:
>> On 7/10/26 4:47 PM, Michael Walle wrote:
>>> On Fri Jul 10, 2026 at 4:39 PM CEST, Sean Anderson wrote:
>>>> On 7/10/26 10:22, Michael Walle wrote:
>>>>> Before converting to the phylink interface, the init function would have
>>>>> set the correct I/F mode depending on the maximum link speed of an
>>>>> interface. After converting to phylink, the established link speed
>>>>> is used to determine this setting and is set in the .link_up()
>>>>> callback. The callback isn't called because the link is never
>>>>> established between the PCS and a connected SGMII PHY.
>>>>> To fix it, don't use the current speed, but set the mode depending on
>>>>> the interface (which implies the maximum speed) in .mac_config().
>>>>>
>>>>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>>>>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>>>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>>>> ---
>>>>> FWIW, I dropped setting a non-reserved mode in init(). The hardware
>>>>> default is 0 and the mac_config() will set a valid mode anyway.
>>>>>
>>>>> Changes in v2:
>>>>>   - the setting is/was based on the maximum speed, not the current
>>>>>     speed. thus, move the setting into mac_config().
>>>>>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
>>>>>
>>>>>   .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
>>>>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>>> index fe35703c509e..7075f93bab49 100644
>>>>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>>>>>   {
>>>>>   	struct mac_device *mac_dev = fman_config_to_mac(config);
>>>>>   	struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
>>>>> -	u32 tmp;
>>>>> +	u32 ecntrl, maccfg2;
>>>>> +
>>>>> +	maccfg2 = ioread32be(&regs->maccfg2);
>>>>> +	maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>>>>   
>>>>>   	switch (state->interface) {
>>>>>   	case PHY_INTERFACE_MODE_RMII:
>>>>> -		tmp = DTSEC_ECNTRL_RMM;
>>>>> +		ecntrl = DTSEC_ECNTRL_RMM;
>>>>> +		maccfg2 |= MACCFG2_NIBBLE_MODE;
>>>>>   		break;
>>>>>   	case PHY_INTERFACE_MODE_RGMII:
>>>>>   	case PHY_INTERFACE_MODE_RGMII_ID:
>>>>>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>>>>>   	case PHY_INTERFACE_MODE_RGMII_TXID:
>>>>> -		tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>>>> +		ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>>>> +		maccfg2 |= MACCFG2_BYTE_MODE;
>>>>>   		break;
>>>>>   	case PHY_INTERFACE_MODE_SGMII:
>>>>>   	case PHY_INTERFACE_MODE_1000BASEX:
>>>>>   	case PHY_INTERFACE_MODE_2500BASEX:
>>>>> -		tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>>>> +		ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>>>> +		maccfg2 |= MACCFG2_BYTE_MODE;
>>>>>   		break;
>>>>>   	default:
>>>>>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>>>>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>>>>>   		return;
>>>>>   	}
>>>>>   
>>>>> -	iowrite32be(tmp, &regs->ecntrl);
>>>>> +	iowrite32be(ecntrl, &regs->ecntrl);
>>>>> +	iowrite32be(maccfg2, &regs->maccfg2);
>>>>>   }
>>>>>   
>>>>>   static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>>>>> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>>>>>   	iowrite32be(tmp, &regs->ecntrl);
>>>>>   
>>>>>   	tmp = ioread32be(&regs->maccfg2);
>>>>> -	tmp &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPLEX);
>>>>> -	if (speed >= SPEED_1000)
>>>>> -		tmp |= MACCFG2_BYTE_MODE;
>>>>> -	else
>>>>> -		tmp |= MACCFG2_NIBBLE_MODE;
>>>>> -
>>>>>   	if (duplex == DUPLEX_FULL)
>>>>>   		tmp |= MACCFG2_FULL_DUPLEX;
>>>>> -
>>>>> +	else
>>>>> +		tmp &= ~MACCFG2_FULL_DUPLEX;
>>>>
>>>> Did you test this when forcing 10/100 speed?
>>>
>>> No I didn't. Well I can't. I have a very weird board which only
>>> supports 1000base-X (and copper SFPs in 1000basex autoneg mode). On
>>> top of that there is a Marvell 88E1112 in between the SFP and the
>>> MAC, for which the PHY driver is completely broken. Long story
>>> short, I'm not able to test that (yet/at all? Not sure).
>> FTR, sashiko suspect this patch will broke such setup:
>> https://sashiko.dev/#/patchset/20260710143430.2276141-1-mwalle%40kernel.org
> 
> I've seen that, but.. that was the actual change between v1 and v2
> as suggested by Sean. It does not depend on the actual link speed,
> but the maximum link speed. So it is not relevant if the link
> negotiates to a slower speed or not. At least that now matches the
> behavior prior to the phylink conversion. If that was working -
> that I can't tell you.

I'm sorry, following all cross revision discussion is a bit hard here.

I don't understand if the 'link never established' is specific of your
board, or it a constant with this driver. Could you please clarify?

/P

