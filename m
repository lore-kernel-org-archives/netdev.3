Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597396;
	b=kxr7a9PpdcNJj3ZuKy9Smn8RggAu9rEQh1N7r7bb/z/T+CKaQsCRwdZJLi9Qcmx7yfda
	 JHHOqqoOHocBb8OMnKhvL/gbLDt2PnxAuNxT0eBNYiwYkzW82LiG0mb3P+leUSWoeRZd9
	 5zKW05OpIdToZEqGIhp76OIq+rmMPeccIdOvofBpg2HB+VWsL0juw6t0/WUtPAQnExwuJ
	 JXX13VYUxSW2OcZU6geu+uKGyKkbdYvsfgxf2p09gomsmPRj8ee/6B26rGg4oen6fQ4I7
	 Qz4xlH6mULsvapHD0GRruJqgcbbgw05oG3572cc/mtFEcqslJIZAti5z585YFPikaaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597396;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=hnp5nKDzgJnODvsFmkdgk+eeQorA0gslwBiNwwkyGhY=;
	b=N4QaV7LiMdmOE2wu7sCtYMRoagFLT3xUQqTQEZt6Q09Cz0/gtC1DaPYTfg+Qun+CiL32
	 LfYf/BewZFsUKHRb89c0khQnEr6hrhMfT3rqbQiG8B9W2+PSmyUvpf87J6kLyxFmlCWKx
	 YrGfZsekB4+2JCi5iXxHvAb1hMNCFOl30TV6358dlqP6c28T4MfKUyl11HbGx62SbLO6e
	 BAGBwHoWfAebG9+37O+wQU94JA580wLuYVEIYbje9zOKIIzUEQpHtSaeIBl0OJqM8l0i1
	 p51txmVPxKJVkYhm8lZfidf6VjiVokplSp93L3T31Cz1cC++J1aNjqBxMuAVEyLX50w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="W0ffC/xJ";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C4606A32A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A7C4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=W0ffC/xJ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4F6DAC5CD6A;
	Wed, 21 Oct 2026 15:44:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DBB7606E3;
	Wed, 21 Oct 2026 15:43:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8AFE10328DD2;
	Wed, 21 Oct 2026 17:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792597386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hnp5nKDzgJnODvsFmkdgk+eeQorA0gslwBiNwwkyGhY=;
	b=W0ffC/xJr/vsjzk/DEL2NTX9HR8MZpnQOJA7N7VLDM1nu2baVu7R9mvlpzJ2NiI72N4VIz
	ohqn6bCn9Cw8k4Sa4KJBy0r/Gorqc4ce5aaZtsRgbcm3YmxcZgQcKcMtsY0HScEVMMJcUK
	pnUjRe9E5dIQFPVcu2tVR+L6S9Ea4BmbsLOOZ49SeXoEcR+M64UM0rsnKNrpEFvHLLUk5A
	kaaZ+VTczl3qxfLEzfk3xc6NOn9pwZ9Ow7j0tbYL6nsn+xSuUnIuoXpWYNu5983aBulATP
	sfQoq395ir7VjJLqkXmvgYLP78a1IVY0lCvmpu7Cr2MSubxW5Xz0XV5n+ujt1A==
Message-ID: <2c27a1a0-b0a4-4adc-a3af-edb74e12dcfb@bootlin.com>
Date: Wed, 21 Oct 2026 17:42:59 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 05/10] net: pse-pd: check the PI state under the lock
 when setting a power limit
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
 "github@szelinsky.de" <github@szelinsky.de>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "piotr.kubik@adtran.com" <piotr.kubik@adtran.com>,
 "saikrishnag@marvell.com" <saikrishnag@marvell.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <atb-3EIJynaRwuwe@pengutronix.de>
 <0378ccc3-4807-4d63-8e61-03b465952929@bootlin.com> <atjcxjV-scVhA6aF@p620>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <atjcxjV-scVhA6aF@p620>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/21/26 17:40, Kyle Swenson wrote:
> On Tue, Oct 20, 2026 at 12:19:28PM +0200, Kory Maincent wrote:
>>
>>
>> On 10/20/26 07:40, Oleksij Rempel wrote:
>>> CCing regulator related folks.
>>>
>>> On Mon, Oct 19, 2026 at 02:30:24PM +0200, Kory Maincent wrote:
>>>>
>>>> On 10/19/26 10:51, netdev-bot+sashiko@kernel.org wrote:
>>>>>>     	previous_pw_allocated = pi->pw_allocated_mW;
>>>>>>     	pw_diff = pw_req - previous_pw_allocated;
>>>>>>     	if (!pw_diff) {
> 
> [...]
> 
>>>>> regulator_set_current_limit()
>>>>>      pse_pi_set_current_limit()
>>>>>        ops->pi_set_pw_limit()         <- new, higher limit
>>>>
>>>> @Oleksij, Here is another example of an issue related to the PSE PI being a
>>>> regulator provider.
>>>>
>>>> @Carlo, Kyle is working on a series that remove the support for a PSE PI
>>>> being a regulator provider. We will see where it goes.
>>>
>>> Removing the regulator provider support is a bad idea:
>>>
>>> - We will end up implementing a poor man's regulator framework inside the
>>> network subsystem. Networking folks will have to deal with physical constraints
>>> already solved by the power management community, requiring a different mindset
>>> and domain experience.
>>
>> That's what we thought at the beginning of the implementation of PoE but in
>> fact that's not the case. I don't see currently any cases of using already
>> solved regulator constraint in the PoE core.
>> The drawback are:
>> - locks issues: solved one by using worker but there are still others
>>    appearing like this one
>> - code complexity due to all the regulator callback wrapper
>> - converting mW to mA for regulator framework then to mW again for the
>>    PSE driver callbacks. There are even devices that are using current
>>    limit therefore there will be 3 conversions.
>>
>> The more painful issues are the lock issues.
>>
>>> - We lose built-in regulator infrastructure: DT safety constraints
>>> (regulator-max-microamp), over-current/under-voltage notifications, and
>>> sysfs/debugfs (regulator_summary) visibility.
>>
>> I disagree here.
>> regulator-max-microamp: has not interest from the PI side but this is
>> related to its power supply. The PI should still stay as a regulator
>> consumer so the power supply could describe this binding.
>>
>> over-current/under-voltage notifications: we are already reporting these PSE
>> PIs notification through ethtool. We will loose
>> regulator_notifier_call_chain() call but well there is no consumer to the PI
>> regulator provider so it's mainly useless.
>>
>> Yes, we will loose sysfs/debugfs visibility, but is someone really using it
>> as all PSE communication goes through ethtool?
>>
>>> - The race above is just a lock scope issue across pcdev->lock and the
>>> regulator call, not a flaw in the abstraction.
>>
>> That's not something easy to solve as PSE and regulator provider are nested
>> together.
>> Either we put all of the lock issues inside workers, it will not be
>> synchronous and will smell hackish but well...
>> Or we try to combine the PSE lock with the regulator nested lock in one way
>> or another.
>> Do you have a better idea?
>>
>>> - Writing a custom power state machine in net/ will introduce more bugs than it
>>> fixes - especially if we overestimate our ability to upstream complex custom
>>> logic under LLM review supervision.
>>
>> Removing regulator provider will simplify a lot the implementation so I
>> think it will rather remove bugs than introduce new one.
>> I think we should let Kyle works on it with a RFC and we will see where it
>> goes.
> 
> For what it's worth, and for others that might be interested but I missed
> on cc, the RFC is here:
> 
> https://lore.kernel.org/netdev/20261020-pse_regulator_fixes-v1-1-fd6084a22cba@est.tech/

Thank's for that.

I will take a look at it when I have time, but it seems promising to me 
to solve lots of issue as you mention.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

