Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2C2BEC27;
	Fri,  5 Jun 2026 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629431; cv=none; b=BTFcz9tr+uhz5GgilNXduhMkJB57rFg+F0ubGIIZKDLls3y7v/xMibi9VrBZaMj4Mmo1FdtD0gv2YmhDBczUWYJcGpNmM071dImVGo6VHFODaeV8mx39jmb7WCGrh2KnydruZ+aRAVjOwYTWAH9nUTUQU2kFGMJkZK8LnG6PezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629431; c=relaxed/simple;
	bh=xd/9j3/ENuPiwUbFsPg/j2s7qeB5GS10FkVFDPd8i7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uswuSYENICmFOoAZZTq/2jMgQg4sZb1M1ngPEYTl1jvjmLsgcYIacBwcfqGsE/vFAYzlWS57VgNQ/HqeXhB0PeMu0YdGoKi/atMBCdXVqEZkFOX3dxV9BdZznyECFg9KKDXLfVxJMwA8PfrU0p+BvAfwiqBQLcYX1tAfCP+vUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=O4JDKQHB; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="O4JDKQHB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1A571171EC;
	Fri,  5 Jun 2026 05:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780629419;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RYCdo5ZX9A+UjzMZvC7m8OuShR08M/FT//5UWv1YUdk=;
	b=O4JDKQHBac5LWiVU8tDEsrZ63KRNrPCl8jfFEVMDj8pi/lQqjVgUI8o3s7D0v9GOLa2J2z
	4nSRRb4YW3NX3ZkSpIzXqDTktp9yl6+nPnf4af3LtZ8rKQbAVn9Y5J+br+vm3VdHpmCa7v
	SXaLIWpSJeQFfyP9nOe8SqUKhcxgNcrXS6mD+cVSmsN/zYA1gtKULnMlgyeqVpaL+ORnsb
	EdGnYkVT/Mavapn2kIhoI2EdIWcRbi1ZgWKnOWaBxpPtIi/ElCXVz/PZCzrl+kgkHmIEdp
	TMEOMz/mmfP0NAQ44U7VsRHdb3Qes3xqYvxLlDY0wm4prE2a85BYPQXBV7jhcA==
Message-ID: <4098dafb-838e-4854-add6-cb3ce6668a70@nabladev.com>
Date: Fri, 5 Jun 2026 05:16:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: lawson.fidelio@gmail.com, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, maxime.chevallier@bootlin.com,
 horms@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Tristram.Ha@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de, fidelio.lawson@exotec.com
References: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
 <20260604114119.170747-1-pabeni@redhat.com>
 <20260604193545.0a906598@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260604193545.0a906598@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6/5/26 4:35 AM, Jakub Kicinski wrote:
> On Thu,  4 Jun 2026 13:41:19 +0200 Paolo Abeni wrote:
>>> @@ -3114,6 +3114,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
>>>   	switch (tuna->id) {
>>>   	case ETHTOOL_PHY_DOWNSHIFT:
>>>   	case ETHTOOL_PHY_FAST_LINK_DOWN:
>>> +	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
>>> +	case ETHTOOL_PHY_LPF_BW:
>>> +	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
>>>   		if (tuna->len != sizeof(u8) ||
>>>   		    tuna->type_id != ETHTOOL_TUNABLE_U8)
>>>   			return -EINVAL;
>>
>> [Severity: High]
>> Is it intentional to enforce an 8-bit type constraint for bandwidth and DSP
>> equalizer tunables?
>>
>> This heavily couples the global API to the 8-bit register layout of the
>> KSZ87xx hardware without defining generic units like Hz for bandwidth.
> 
> AFAIK this is the one comment from AI that survives scrutiny.
> Seems unlikely we'd need more bits, but then again - why not.
> u32 should be our default for integer values, u8 is more for
> booleans.

Why waste memory space if we are already sure the space would not be used.
