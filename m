Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC53C988D;
	Fri, 25 Sep 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359055; cv=none; b=V+p8MIiRQztRjHZewCIAdnHi30WwDcI/YmzJkhDtbkQFQt0o4sJcYZWKSpdmHFN0MSjdImdkKMDVONaHzLCW8ozbJF38BaQPwhd088121cpUKVQUznS6rdbhNERqagC9eCurRkOmE+DOd8pRrugeO94W8VEV/PitqzRt11rlyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359055; c=relaxed/simple;
	bh=PHxCuEeF4HHaxhjxw6i/PZUo0/JK1gx/Z7MoOSiiyQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CY2x4bUdGFjcQ2o/mboYJq4thC45CWKp76VswY4/+5kEh7WgnAfqUMFMmkyFcSS7D1n4PvTpq7V+xr/w+T71Z8xacr87zN1P3ZvjFbOpMGlsb8JdSzA/vRLd0cupBr1Zq1mL2GBSpFBi4mrTIdiviOkPqOYH4xoXsZZlgcshVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RN8h2xi9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RN8h2xi9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA2AF1A1022;
	Fri, 25 Sep 2026 17:57:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A3A266073B;
	Fri, 25 Sep 2026 17:57:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24CFC102F1E35;
	Fri, 25 Sep 2026 19:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790359045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=T8jXapbk2liRqW3NjH6Ovlrn1tf36ydrI5huGY01104=;
	b=RN8h2xi99PBulxUYPNzsT1yIuwSGdn6TaVPiO6KGaPsOAwiC5q1KAtMMPMnOQRl3fcfTbO
	5FOAB+L9bYqRP2zaf1A2YFh0133NEfj6sMe7ahHIhRRssZ+JYDPHtM59rSNPjOma313R6V
	j4CGgopYeh290VzmPUuOq/rWiabOtiNbZPeXofhkbwYlSE6fvQCcPZghvXhyab7lFhhz1i
	kIVjG3hlzrtax3Ba3StcuiiuQ2cSoLW58Z3GOFZ3r/ok/tcK0YRvFu59X6tX4LHNRsUqx9
	C0oN8duUFz3YqkqvhOMFMPFgIy4WwsNGcbkrx1/sd+WfTzljdZgiWQNScwZN2Q==
Message-ID: <7782c263-503d-485b-9029-de611536abd6@bootlin.com>
Date: Fri, 25 Sep 2026 19:57:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net v3 1/2] net: ethtool: reject an out of range hwtstamp
 provider index
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260925135237.3432266-1-nb@tipi-net.de>
 <20260925135237.3432266-2-nb@tipi-net.de>
 <0ddf8280-0a66-4dbf-9195-1b90e97015c5@bootlin.com>
 <5ff0fa6eee1605e546d433c7944fa769@tipi-net.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <5ff0fa6eee1605e546d433c7944fa769@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/25/26 16:07, Nicolai Buchwitz wrote:
> Hi Kory
> 
> On 25.9.2026 15:55, Kory Maincent wrote:
> 
>> [...]
> 
>>>   static const struct nla_policy
>>>   ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {
>>> -    [ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] = { .type = NLA_U32 },
>>> +    [ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
>>> +        NLA_POLICY_FULL_RANGE(NLA_U32, &ethnl_ts_prov_index_range),
>>>       [ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =
>>>           NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
>>>   };
>>
>> I think you can simply do this:
>> [ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
>>     NLA_POLICY_MAX(NLA_U32, INT_MAX),
> 
> That was my initial thought, but unfortunately it doesn't work. struct 
> nla_policy's
> .max is s16 and INT_MAX is truncated to -1. It ends up as U64_MAX in the 
> range check
> and in the end nothing gets rejected.
> 
>      include/vdso/limits.h:8:25: warning: overflow in conversion from 'int'
>      to 'short int' changes value from '2147483647' to '-1' [-Woverflow]

Indeed.
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

