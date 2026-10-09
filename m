Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E93B3BE5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571413; cv=none; b=Xxm36xf/iEFd5nsDXQAXKXCRyIbvzcUCoNVWAqEzCCKzr+l9Ydp8wlk2qeOInmz6ubrJN6XOKQELBsx9UwvhLmAEmIzST9XBccz2CknzejBomHGLDLs1S1JxIFkEzOsXH5b3Yc9N4Th8dwW79eA5mdvImuNZ8IbbR4FxQcEap4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571413; c=relaxed/simple;
	bh=rNXguC4VOaGi/y8+RHWdMtoYrO65JP57HrQWzN78/iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDQ8bFpNhVJb6fTjV4dJgi1vIDTegp+7CAlO/CqdmonAYSHLweRfOHSkxh0LjAnscRgOEpLrFHeuzAtohmvWN/iGIM1ZHINcnECPBU40N4IYjrqnjIXa8AmNeFIrnSJYy3afIvghVSw/BN6mXkyqGoVvFegVUGKoKUgF3uh3c2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DG8YamNn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG8YamNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791571410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y484Fi29po6q2WF2MGFtTVxohCU2z1YoDAcFHwy/iUc=;
	b=DG8YamNnUTJs5fU53BzlL3OyJXmnsDDjx/mF53AvMN8N6DxBNhCRWfXP1gn/WDEVtSJuzD
	26K2DbnUJLiQadMEgv4l5/5S5p1qfakTyhhq0oYESqAqCBuHP0uHgxMFpMbka8GdXJV1Gf
	x5BtJjNBb1NwrFWivCPZKWXZxKlVsco=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-uBQ1WXQkO5KF_OTNZaEvww-1; Fri,
 9 Oct 2026 18:43:20 +0000
X-MC-Unique: uBQ1WXQkO5KF_OTNZaEvww-1
X-Mimecast-MFC-AGG-ID: uBQ1WXQkO5KF_OTNZaEvww_1791571398
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C37E195E917;
	Fri,  9 Oct 2026 18:43:18 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8343472;
	Fri,  9 Oct 2026 18:43:15 +0000 (UTC)
Message-ID: <0fc24fc1-533f-4bc3-9ac3-d36e1d65dadc@redhat.com>
Date: Fri, 9 Oct 2026 20:43:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/4] dpll: zl3073x: make embedded sync follow the
 output carrier frequency
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261006153116.347497-3-ivecera@redhat.com>
 <179147350298.434549.8122554224626691119@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179147350298.434549.8122554224626691119@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/8/26 17:31, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] zl3073x_dpll_output_pin_esync_get()
>    (drivers/dpll/zl3073x/dpll.c) now returns esync->freq = 1 and…
> - [Medium] The fix for the 'stuck-on' eSync only works when the driver's
>    own frequency_set() moves the carrier to 1 Hz.
> 
> --
> 
> dpll: zl3073x: make embedded sync follow the output carrier frequency
> 
> This patch moves the eSync handling into zl3073x_out_esync_{is_enabled,
> enable,disable}() helpers and uses them from the esync get/set callbacks.
> On non-N-divided outputs, a frequency change now recomputes the eSync
> period and width, or disables eSync when the new carrier is 1 Hz.
> esync_get() now reports a nominal 1 Hz / 25% whenever the clock type is
> ESYNC.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index f2e137475b40f..7c997966c3c33 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
> 
> [ ... ]
> 
>> @@ -864,38 +864,28 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>>   	 * for N-division is also used for the esync divider so both cannot
>>   	 * be used.
>>   	 */
>> -	if (zl3073x_out_is_ndiv(out))
>> +	if (zl3073x_out_is_ndiv(out) || !pin->esync_control)
>>   		return -EOPNOTSUPP;
>>   
>>   	/* Get attached synth frequency */
>>   	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
>>   	synth_freq = zl3073x_synth_freq_get(synth);
>> -	out_freq = synth_freq / out->div;
>>   
>> -	if (!pin->esync_control || out_freq <= 1)
>> +	/* The esync is not supported for 1 Hz base frequency */
>> +	if (synth_freq / out->div <= 1)
>>   		return -EOPNOTSUPP;
> 
> [Severity: Medium]
> Can eSync still get stuck on if the output already has the ESYNC clock
> type on a 1 Hz carrier when the driver probes?

eSync on a 1 Hz carrier needs output_esync_period = 1, which the
datasheet defines as undefined. Such a state in flash is an invalid
configuration and the driver does not try to recover from it. The
patch only makes sure the driver itself never creates it.

> The commit message mentions configurations "left in flash or by an older
> kernel". zl3073x_out_state_fetch() keeps the mode register exactly as it
> reads it from the device. So this state can exist without the driver's
> own frequency_set() ever having run.
> 
> In that case this check returns -EOPNOTSUPP even though eSync is enabled.
> dpll_pin_esync_set() then returns before it reaches the driver's disable
> path:
> 
> drivers/dpll/dpll_netlink.c:dpll_pin_esync_set() {
>      ...
> 	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
> 			     dpll_priv(dpll), &esync, extack);
> 	if (ret) {
> 		NL_SET_ERR_MSG(extack, "unable to get current embedded sync frequency value");
> 		return ret;
> 	}
>      ...
> }
> 
> The new disable branch in zl3073x_dpll_output_pin_frequency_set() can't
> be reached either. The core short-circuits a request for 1 Hz on a pin
> that is already at 1 Hz:
> 
> drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
>      ...
> 	if (freq == old_freq)
> 		return 0;
>      ...
> }
> 
> The only escape seems to be: move the pin to another supported frequency,
> disable eSync, then go back to 1 Hz. That doesn't work if 1 Hz is the
> only frequency the pin supports.
> 
> Could the driver clear the ESYNC clock type at fetch time when the carrier
> is 1 Hz or less? Alternatively, esync_get() could report an enabled eSync
> so that it can be turned off.
> 
>>   
>>   	esync->range = esync_freq_ranges;
>>   	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>>   
>> -	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
>> -		/* No need to read esync data if it is not enabled */
>> +	if (zl3073x_out_esync_is_enabled(out)) {
>> +		esync->freq = 1;
>> +		esync->pulse = 25;
> 
> [Severity: Medium]
> Does reporting a fixed 1 Hz here stop the core from correcting a
> mismatched eSync?

Agreed. I will drop the fixed 1 Hz / 25% reporting and derive the
frequency and pulse from the registers again in V4. The pulse should
be also computed in 64 bits, as 50 * esync_n_width can overflow u32.

Thanks,
Ivan

pw-bot: cr

