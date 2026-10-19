Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280294EC653;
	Mon, 19 Oct 2026 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413055; cv=none; b=Czd+budnWm7UmulWRbZjsSD+ANhizstTqHeZtPUoWQNRy/T5W/8lrJbmjW+5kVS3eSRW/2m6u+5/xKGOgcQ0s6ZbPNPBemxtqpX9ezOryH10hqYCsPgKoR2bBLPwVua3COddtlEqq+rw9PdAMzVxPChirZlrzmc52R7ObVIDLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413055; c=relaxed/simple;
	bh=zSf4aXy8T9THsYKKiop3NtLaYmSnRT+Q+AiZBZpzG2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZk/zDHbh+Ls9oqar6cXcPbhEcw+K/KuT/UJ4NB1f92mb3cNVEAhs69qSQMJ9zdp/EjpvbajVF4f2m6OfxgLBa3979LElenA3A/2mAk6ROd230Aq1WDJqMs/tIUF/Fu6L5zOZOUUGcd21ULM/5u3Nto/FlNkbH66fsz42t5TBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SBqQ4hDM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SBqQ4hDM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0B8EA4E4127B;
	Mon, 19 Oct 2026 12:30:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1B0560582;
	Mon, 19 Oct 2026 12:30:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41C3010328A96;
	Mon, 19 Oct 2026 14:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792413031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Logan3gn6C/KU3n5Q3xCq0kz6xJTn36NU41NqOjNh2E=;
	b=SBqQ4hDMhIVyg7hDwTgClDvVzXR1QrwSevbck8neNch1NkNEU8m693eiC82ayamRPt5wMk
	KrlIDMW2gZeFt+MHAwbqMhinVt1JPlmr8zOo86Tr1oS9QDCZoH/0bgSsdGKqcCxVUvDSFM
	hFKOhd+J+7I8P/pBw2v0/eKXgHy0s5PMuC97e2jGI8Bd3iKVnyC+jB9RMQAl7Ks+Z9/1YP
	5haA4bB2jWIs6QDE/dAQk+/8nqNNuOBLYyUokA/RtRj7T0pl+EHtPWe+9COfh5iXWJx2pN
	0UtYNV3tAfVf90W5oZ8pqEj4/JtB0870/oQGQDL8DRUdkWA0VhSIwfLwHTsJRw==
Message-ID: <bb8eaf92-2b5b-46a1-b39d-a29ae273a3b5@bootlin.com>
Date: Mon, 19 Oct 2026 14:30:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 05/10] net: pse-pd: check the PI state under the lock
 when setting a power limit
To: netdev-bot+sashiko@kernel.org, github@szelinsky.de,
 o.rempel@pengutronix.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, piotr.kubik@adtran.com,
 saikrishnag@marvell.com, horms@kernel.org, kyle.swenson@est.tech,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261018082314.48950-6-github@szelinsky.de>
 <179239987339.3135.11130245905103238734@kernel.org>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <179239987339.3135.11130245905103238734@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/19/26 10:51, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] The patch puts the PD-state check and the budget change in one
>    pcdev->lock critical section inside pse_pi_update_pw_budget().
> - [Low] The kernel-doc for pse_pi_update_pw_budget() (drivers/net/pse-
>    pd/pse_core.c:1835) still says "Return: Previous power allocated on…
> 
> --
> 
> net: pse-pd: check the PI state under the lock when setting a power limit
> 
> This moves the software power control, admin state and PD detected checks
> from pse_ethtool_set_pw_limit() into pse_pi_update_pw_budget(), so they now
> run under pcdev->lock. A new updated output parameter reports whether the
> budget changed. The rollback after a failed regulator_set_current_limit()
> now runs only when updated is true.
> 
>> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
>> index 336f00d82b5f8..d5f863834179c 100644
>> --- a/drivers/net/pse-pd/pse_core.c
>> +++ b/drivers/net/pse-pd/pse_core.c
>> @@ -1829,22 +1829,32 @@ EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
>>    * @pcdev: a pointer to the PSE controller device
>>    * @id: index of the PSE PI
>>    * @pw_req: power requested
>> + * @updated: set to true if the budget was changed
>>    * @extack: extack for reporting useful error messages
>>    *
>>    * Return: Previous power allocated on success and failure value on error
>>    */
>>   static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
>> -				   const unsigned int pw_req,
>> +				   const unsigned int pw_req, bool *updated,
>>   				   struct netlink_ext_ack *extack)
>>   {
> 
> [ ... ]
> 
>>   	mutex_lock(&pcdev->lock);
>> +	/* Only a powered PI under software power control holds a budget.
>> +	 * Check it here, as pse_isr() changes it under the same lock.
>> +	 */
>> +	if (!pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d) ||
>> +	    !pi->admin_state_enabled || !pi->isr_pd_detected)
>> +		goto out;
>> +
> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc for pse_pi_update_pw_budget() still
> says:
> 
>   * Return: Previous power allocated on success and failure value on error
> 
> This new early exit returns 0 with *updated = false, whatever
> pi->pw_allocated_mW holds. The existing !pw_diff exit also returns 0.
> 
> pw_allocated_mW can be non-zero when this check fails. For example,
> _pse_pi_disable() returns before pse_pi_deallocate_pw_budget() if
> ops->pi_disable() fails, but pse_set_config_isr() still clears
> isr_pd_detected on disconnection.
> 
> Could the Return description say that 0 can also mean no change was made?
> It could also say that callers should check *updated, not the return
> value, before rolling back.
> 
>>   	previous_pw_allocated = pi->pw_allocated_mW;
>>   	pw_diff = pw_req - previous_pw_allocated;
>>   	if (!pw_diff) {
> 
> [ ... ]
> 
>> @@ -1908,21 +1920,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
>>   	/* Update power budget only in software power control case and
>>   	 * if a Power Device is powered.
>>   	 */
>> -	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
>> -				      psec->pcdev->pi[psec->id].pw_d) &&
>> -	    psec->pcdev->pi[psec->id].admin_state_enabled &&
>> -	    psec->pcdev->pi[psec->id].isr_pd_detected) {
>> -		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
>> -					      pw_limit, extack);
>> -		if (ret < 0)
>> -			return ret;
>> -		previous_pw_allocated = ret;
>> -	}
>> +	ret = pse_pi_update_pw_budget(psec->pcdev, psec->id, pw_limit,
>> +				      &updated, extack);
>> +	if (ret < 0)
>> +		return ret;
>> +	previous_pw_allocated = ret;
>>   
>>   	ret = regulator_set_current_limit(psec->ps, 0, uA);
> 
> [Severity: Medium]
> The scenario in the commit message, where budget is reserved for a port
> that is no longer powered, looks closed now. But can the budget and the
> hardware limit still drift apart in the other direction?
> 
> The state check and the budget change now share one pcdev->lock critical
> section. The hardware limit is still written in a separate one:
> 
> pse_ethtool_set_pw_limit()
>    pse_pi_update_pw_budget()        <- takes and drops pcdev->lock
>    regulator_set_current_limit()
>      pse_pi_set_current_limit()     <- takes pcdev->lock again
>        ops->pi_set_pw_limit()
> 
> The threaded pse_isr() only needs pcdev->lock, so it can run in between:
> 
> CPU0 (ethtool set_pw_limit)
> pse_pi_update_pw_budget()
>    sees isr_pd_detected == false
>    *updated = false, nothing reserved
>    mutex_unlock(&pcdev->lock)
> 
> CPU1 (pse_isr, classification event)
> pse_set_config_isr()
>    isr_pd_detected = true
>    _pse_pi_delivery_power_sw_pw_ctrl()
>      pw_req = min(pi_get_pw_req(), pi_get_pw_limit())  <- old hw limit
>      pse_pi_allocate_pw_budget(pcdev, id, pw_req, extack)
>      ops->pi_enable()
> 
> CPU0
> regulator_set_current_limit()
>    pse_pi_set_current_limit()
>      ops->pi_set_pw_limit()         <- new, higher limit

@Oleksij, Here is another example of an issue related to the PSE PI 
being a regulator provider.

@Carlo, Kyle is working on a series that remove the support for a PSE PI 
being a regulator provider. We will see where it goes.
I think you can ignore this sashiko point as for now.

> The port would then be powered with a hardware limit above its reserved
> budget, and nothing later corrects pi->pw_allocated_mW. Could that
> over-subscribe the power domain?
> 
> A disconnect followed by a reconnect between the two sections seems to end
> the same way. If regulator_set_current_limit() then fails, this rollback
> writes back the previous_pw_allocated value that was read before the
> reconnect:
> 
> 	if (ret < 0 && updated) {
> 		pse_pi_update_pw_budget(psec->pcdev, psec->id,
> 					previous_pw_allocated, &updated,
> 					extack);
> 
> Would a full fix need the state check, the budget update and
> ops->pi_set_pw_limit() in a single pcdev->lock critical section?
> pse_pi_set_current_limit() takes pcdev->lock itself, so that looks like it
> needs a different structure from calling regulator_set_current_limit()
> after pse_pi_update_pw_budget().
> 
>> -	if (ret < 0 && previous_pw_allocated) {
>> +	if (ret < 0 && updated) {
>>   		pse_pi_update_pw_budget(psec->pcdev, psec->id,
>> -					previous_pw_allocated, extack);
>> +					previous_pw_allocated, &updated,
>> +					extack);
>>   	}
>>   
>>   	return ret;

With the change ask by sashiko on the kdoc you can add my Reviewed-by tag.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

