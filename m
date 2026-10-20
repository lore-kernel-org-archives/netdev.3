Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491585;
	b=lKvogLWrQU5S3eE9UMCdaRDKAMLyi6Mza+bNonLRVyuWbJQgK5iPIWqt17/U7SQAafW5
	 T1GZJvtfI5vSy8hoHefoC3JKSjbwKbz7FJXTmankpx0hno73qPscOxPJ1nDdYfSG+MQQ1
	 bDTd8kCUVvB4WlUapoo2M7kbIHCGkO6fi9hIY8VYeiLe3pFkAiZXOXm4U0dixPylQYA+6
	 T/vtXUV6u2NqMtR8pMXtDIB5Ct2hoaZC9Jp0x7exvHHzfg+7VNJp3XSnLeGVvndNN+Ej/
	 BnVdjTGMon4eTSUje+qYNETvkMeDAtt33QDNWhVEbb7WqaohGaXAROmgFD2EtGrTwXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491585;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=aFC5vuSMT2esAzOCEJeRc9z+/o392JRV+udxwIAa+1k=;
	b=pkQQyltXKVIlAASBin2wZJD0uaUv49cNy/PN6tN79Qv4VysxQHW3VW+HWy51ypQCIvjJ
	 mBBNo/T/xCAWetsamyiYvuiaS0iJ2a69zatnFQos42pDei1D25yM7CJctmrROGjiB8yAr
	 FfmAO/F9OOgIyhXgbGsznf+ThU+dUP0+TPV7oIxT70R8ALnPGQdXxp1YqkuIlDYLCDUj2
	 AJIt5Jj6nI6lfJGyM8SCG/urxavNPOz5S0CvmkJSluE8fOj1i2JC25pDGH73fboi/ejaQ
	 W/pKv7uf9PHfXng867a2tLTUBwtxRkZv4S62bKZ5bNtDeYJvgtufK1cVobGMvVwqM6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=otWV8YI5;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B913606A327
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B913606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=otWV8YI5
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D39871A1294;
	Tue, 20 Oct 2026 10:19:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A680260393;
	Tue, 20 Oct 2026 10:19:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEF4A10328DF9;
	Tue, 20 Oct 2026 12:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792491576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aFC5vuSMT2esAzOCEJeRc9z+/o392JRV+udxwIAa+1k=;
	b=otWV8YI528uoGxC1Iyj3a0kwxyXAzCgSmQsnFKk2O+oYEDJ0sbQ1+yCTZfFimgZ6jRiUPb
	Sgbn/1AkFg9zkEhBj6wu+zy4VAGIUQptMimCdmDnCBQDXU1FSGDbmG50npCVVZPGU0jmJv
	I6Er+wU1irOngQyZd62ameMt9S/AJT8c6vGQLUmA70+v4hC7CbJ1txUctgISbOFZCLus6k
	MxbhvIUVs6Z6Z0+Hhncu2mI0oRav73P1F09WDB0fBlf+KBBn4WaDirsPOj7vi28dguYotm
	lI648DlbfJARfSj8FSYUD+hyFzvdPfEya95fUiyFEeiF/qEs8q6UTjdvORcHzg==
Message-ID: <0378ccc3-4807-4d63-8e61-03b465952929@bootlin.com>
Date: Tue, 20 Oct 2026 12:19:28 +0200
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
To: Oleksij Rempel <o.rempel@pengutronix.de>, kyle.swenson@est.tech
Cc: netdev-bot+sashiko@kernel.org, github@szelinsky.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, piotr.kubik@adtran.com,
 saikrishnag@marvell.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, broonie@kernel.org,
 lgirdwood@gmail.com, mazziesaccount@gmail.com,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <atb-3EIJynaRwuwe@pengutronix.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <atb-3EIJynaRwuwe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/20/26 07:40, Oleksij Rempel wrote:
> CCing regulator related folks.
> 
> On Mon, Oct 19, 2026 at 02:30:24PM +0200, Kory Maincent wrote:
>>
>> On 10/19/26 10:51, netdev-bot+sashiko@kernel.org wrote:
>>>>    	previous_pw_allocated = pi->pw_allocated_mW;
>>>>    	pw_diff = pw_req - previous_pw_allocated;
>>>>    	if (!pw_diff) {
>>>
>>> [ ... ]
>>>
>>>> @@ -1908,21 +1920,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
>>>>    	/* Update power budget only in software power control case and
>>>>    	 * if a Power Device is powered.
>>>>    	 */
>>>> -	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
>>>> -				      psec->pcdev->pi[psec->id].pw_d) &&
>>>> -	    psec->pcdev->pi[psec->id].admin_state_enabled &&
>>>> -	    psec->pcdev->pi[psec->id].isr_pd_detected) {
>>>> -		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
>>>> -					      pw_limit, extack);
>>>> -		if (ret < 0)
>>>> -			return ret;
>>>> -		previous_pw_allocated = ret;
>>>> -	}
>>>> +	ret = pse_pi_update_pw_budget(psec->pcdev, psec->id, pw_limit,
>>>> +				      &updated, extack);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	previous_pw_allocated = ret;
>>>>    	ret = regulator_set_current_limit(psec->ps, 0, uA);
>>>
>>> [Severity: Medium]
>>> The scenario in the commit message, where budget is reserved for a port
>>> that is no longer powered, looks closed now. But can the budget and the
>>> hardware limit still drift apart in the other direction?
>>>
>>> The state check and the budget change now share one pcdev->lock critical
>>> section. The hardware limit is still written in a separate one:
>>>
>>> pse_ethtool_set_pw_limit()
>>>     pse_pi_update_pw_budget()        <- takes and drops pcdev->lock
>>>     regulator_set_current_limit()
>>>       pse_pi_set_current_limit()     <- takes pcdev->lock again
>>>         ops->pi_set_pw_limit()
>>>
>>> The threaded pse_isr() only needs pcdev->lock, so it can run in between:
>>>
>>> CPU0 (ethtool set_pw_limit)
>>> pse_pi_update_pw_budget()
>>>     sees isr_pd_detected == false
>>>     *updated = false, nothing reserved
>>>     mutex_unlock(&pcdev->lock)
>>>
>>> CPU1 (pse_isr, classification event)
>>> pse_set_config_isr()
>>>     isr_pd_detected = true
>>>     _pse_pi_delivery_power_sw_pw_ctrl()
>>>       pw_req = min(pi_get_pw_req(), pi_get_pw_limit())  <- old hw limit
>>>       pse_pi_allocate_pw_budget(pcdev, id, pw_req, extack)
>>>       ops->pi_enable()
>>>
>>> CPU0
>>> regulator_set_current_limit()
>>>     pse_pi_set_current_limit()
>>>       ops->pi_set_pw_limit()         <- new, higher limit
>>
>> @Oleksij, Here is another example of an issue related to the PSE PI being a
>> regulator provider.
>>
>> @Carlo, Kyle is working on a series that remove the support for a PSE PI
>> being a regulator provider. We will see where it goes.
> 
> Removing the regulator provider support is a bad idea:
> 
> - We will end up implementing a poor man's regulator framework inside the
> network subsystem. Networking folks will have to deal with physical constraints
> already solved by the power management community, requiring a different mindset
> and domain experience.

That's what we thought at the beginning of the implementation of PoE but 
in fact that's not the case. I don't see currently any cases of using 
already solved regulator constraint in the PoE core.
The drawback are:
- locks issues: solved one by using worker but there are still others
   appearing like this one
- code complexity due to all the regulator callback wrapper
- converting mW to mA for regulator framework then to mW again for the
   PSE driver callbacks. There are even devices that are using current
   limit therefore there will be 3 conversions.

The more painful issues are the lock issues.

> - We lose built-in regulator infrastructure: DT safety constraints
> (regulator-max-microamp), over-current/under-voltage notifications, and
> sysfs/debugfs (regulator_summary) visibility.

I disagree here.
regulator-max-microamp: has not interest from the PI side but this is 
related to its power supply. The PI should still stay as a regulator 
consumer so the power supply could describe this binding.

over-current/under-voltage notifications: we are already reporting these 
PSE PIs notification through ethtool. We will loose 
regulator_notifier_call_chain() call but well there is no consumer to 
the PI regulator provider so it's mainly useless.

Yes, we will loose sysfs/debugfs visibility, but is someone really using 
it as all PSE communication goes through ethtool?

> - The race above is just a lock scope issue across pcdev->lock and the
> regulator call, not a flaw in the abstraction.

That's not something easy to solve as PSE and regulator provider are 
nested together.
Either we put all of the lock issues inside workers, it will not be 
synchronous and will smell hackish but well...
Or we try to combine the PSE lock with the regulator nested lock in one 
way or another.
Do you have a better idea?

> - Writing a custom power state machine in net/ will introduce more bugs than it
> fixes - especially if we overestimate our ability to upstream complex custom
> logic under LLM review supervision.

Removing regulator provider will simplify a lot the implementation so I 
think it will rather remove bugs than introduce new one.
I think we should let Kyle works on it with a RFC and we will see where 
it goes.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

