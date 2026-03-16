Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4E31F9B8
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696116; cv=none; b=pl3vyM65Jaa0LZ6m+YIiyFWaggmDUhyMaagApI4hQhsXoYarYygyOoCTEb3A8EDEsotHfCvMKSTIwPhlWwHWwYDGoaCWPOrchx1VLDNZMDXGGCiqGU0xUdZr6HlVwZRf4uHL3WvffMWSmALW+njxSlU0+ero4k6vSG5RG7rT8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696116; c=relaxed/simple;
	bh=9JS1Euum17JWQ8mWMsbya80wwUnSHtPpcynM37NTo1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+bCrrhQVYFaGFfoZevQnK3muHdqztOFpk3LBLc1xzFcfogPGnaH5TjY+jXCIJ+Gz+TbZCVrxA2bUut1zcmiP8Re7Z0PKa35FWLZXXG8hcL2yq+QAY4LYJ1md8N8Czx1VevVOWyV4O1TkjxXoxNkJLMIo61Pps4zfM0Q3XD7k+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G48Wk/y/; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G48Wk/y/"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4b77adso6161685c88.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696114; x=1774300914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOZ8t3Rj5dlKpUY985hxlvkSKTBIFVvaOU6e7SGFF3w=;
        b=G48Wk/y/zyVQz3GYGHeEtquHfiq7rbTtHcnp3vgeWFf7uInsQN6pag4QgVUZgEwxUv
         r/o/TDqLnj0d4RQTTo5WWp2mMvPnOKgB+s+qXveFJ+O9r2yWw85iZo6klG8gs6ZHXX4S
         +yfVZkT4+oFASVHtWqzPlX/nc49K2G0m4ips6hjLBx8o7Yyfws0NSUpuvTfugeAIuMpc
         1vROmkfoYCHstB3KXATiWUv+2dMIZmiamC0LRDvwCIV2h9y95DzGmoUIO+nN373iTVTt
         Hj4ROkC+WxuZ4aGaW70oRKSfvw1wSFjAv3Y1dZ6on0VIdsT7Y/Y1v0+uPI0egj7A+M6j
         Atgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696114; x=1774300914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOZ8t3Rj5dlKpUY985hxlvkSKTBIFVvaOU6e7SGFF3w=;
        b=FU9un6u7WEGSlceF6hU7ZLF5Plv5xMm185Uc9TN9dltVkVSoP1207EWCzCz22fHpuR
         mWhPWljQAmBBcyHcms72ocaRRuC2+ga0k6+oQIAG+p7K/azvhd5zMVwfgChEs8QZaZ/Y
         n69i6K73a1ff1A9ePzdLFuXQbruYMsbeTplDdCNQtGA6uKwz6fgnbIiBbLzmOIqMevRS
         ecR3tzP8ee8SalAhKYMVJs5csp4iCNUxCegC8hSjdcfOCbprAfYlK4vY5B+j0bxH3+EV
         poSFaDsW/KY7dna3Vdnl6h8ZlH67/UN4rYQh7zTAeZln63Y0j/oFAoxzAQIo4xYu6CeP
         KSgA==
X-Forwarded-Encrypted: i=1; AJvYcCXyIiZ0iq/dsNCvq5EhUSsHOKN8naYytDSakyK0ZrlYWBM/ZFv6LPeP1bU58RDf8ldSjETcwNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzng1zwzY2dErLennJKZ82zxXCW7NS8o9FbYqUbdtwEk7AQVKxq
	wt+6zITAYJ81gByX0rA3AV6HA+ou1Km2F4rwBan18LlNehLX68wRtXVC
X-Gm-Gg: ATEYQzzukiEy2FApk5+eUxePXSixYF3oIIus2zWdGriWp62OxDXUQHVUJNnMTqhRCIy
	aNLgwjMHVqy9gGhISYg03K7JIHrXWov9u13e/wgKoulqBycBw/3LxMes3cE261M3zh724Ab5apd
	gugwWtjkhh0hYpMZ1FVhsZvNjv8hBEaoql81WWouNNooInpql46wEwHM1wWqEeF86RIFR9Aydg5
	Xz1LozJoqUyV3na9hJ3+U62DldvHFT0wytodq9MQCIiHvMaJq75PKdRs94dic9i97fRC3Rn15U2
	JfEIMolnMWDGurDVnh+4JKNSiUsc1hxMnaxqzOWUjbKGbIAtPAWflmUjETglNkZdqsS+iWUutPv
	e8HhMnvKwSx2V54rHTR0uHJ9h6dXiGrp6Gqp0kawkXNoO0F9gGan+fTDSlDuF7JuXXZk8iNzW2v
	Y4XnYfPq3nEITc8mCtUy8sCpyWEQ7/5kp3T00qRRDWqyDsHB48jw==
X-Received: by 2002:a05:7022:23a9:b0:122:2f4:b251 with SMTP id a92af1059eb24-128f3dc5578mr6453854c88.21.1773696114378;
        Mon, 16 Mar 2026 14:21:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62991c7sm13728522c88.5.2026.03.16.14.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 14:21:53 -0700 (PDT)
Message-ID: <8b086643-44e1-4c02-9d88-aba369d7d9b7@gmail.com>
Date: Mon, 16 Mar 2026 14:21:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bcmgenet: enable EEE TX LPI by default
To: Jakub Kicinski <kuba@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303160225.542613-1-nb@tipi-net.de>
 <997daf22-260b-40c4-a2d6-8c63f59df9a7@broadcom.com>
 <20260316135915.28c64ec8@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260316135915.28c64ec8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/26 13:59, Jakub Kicinski wrote:
> On Mon, 16 Mar 2026 12:54:46 -0700 Florian Fainelli wrote:
>> On 3/3/26 08:02, Nicolai Buchwitz wrote:
>>> GENET never initializes priv->eee.eee_enabled or
>>> priv->eee.tx_lpi_enabled to true, so the link-change callback in
>>> bcmgenet_mac_config() always calls bcmgenet_eee_enable_set() with
>>> enable=false.  The result is that EEE is negotiated at the PHY level
>>> but the MAC never enters Low Power Idle, wasting the power savings
>>> that EEE is designed to provide.
>>>
>>> Users can work around this with 'ethtool --set-eee eth0 eee on tx-lpi
>>> on tx-timer 250', but the MAC should enable TX LPI out of the box when
>>> the hardware supports it, consistent with how phylink-managed MACs
>>> behave (phylink calls phy_support_eee() which sets eee_enabled=true and
>>> tx_lpi_enabled=true by default).
>>>
>>> Initialize EEE software state during bcmgenet_open() on GENET v2+ so
>>> that the link-change path activates EEE in hardware once the PHY
>>> negotiates it.  Use an LPI timer of 250 us, matching the default used
>>> by other MAC drivers (mvneta, mvpp2).
>>>
>>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>>
>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> FWIW this patch is set to Changes Requested, I _think_ based on this
> reply from Andrew:
> 
> https://lore.kernel.org/all/d352039f-4cbb-41e6-9aeb-0b4f3941b54c@lunn.ch/
> 
> LMK if the patch is good as is.

It is good after 908c344d5cfac4160f49715da9efacdf5b6a28bd ("net: 
bcmgenet: fix broken EEE by converting to phylib-managed state") reaches 
net/next which is what Andrew was commenting on.
-- 
Florian
