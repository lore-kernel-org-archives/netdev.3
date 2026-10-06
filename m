Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401F30216D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299688; cv=none; b=jRR1e/j91OBy1fP/4D7FiM032H4flE+IFCxq3nhdf7q9cPG+n3Mll1JIKLSB7Env04T12z/BJIH0URjDRzvq2YdmHHf7qmoZIMTHzEEWeiqovKvJTpXpSK98cxaUOPdPL24ZpT3PJzKXW4Tgt/sbHGAtAFtfGQNMpPLI2fdQims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299688; c=relaxed/simple;
	bh=t9TjWoa9Ep5fv1CZltqsKXKThnPxH5Qvvp4QVUZyKOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5RuCVCAUwzEmMqsYygEV7hDqOIEaonh2Rrlwq8EFYbqvZ6IpbGA39V8igtbD49hQE93e7EiJyXZOEa1iUm7clGTUanhJedYWG9B7jNlsDVv47vwAyqNRwZc184yRsZqXASAxLzoDGx32FAoP+z8u0B3HqjpQEqZVoOs5GdGFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbXLjxDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbXLjxDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791299685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7M/FWRLC5KBLjqHC/8DNsmEQ8giOtO8ac2o4QKknuU=;
	b=LbXLjxDGeZiyxhOGp90XClgj8htr1cA87bgRvy/va2HynxVCUl3Lbi8tknO44iEkm1ywYB
	sHsv9whKml9FLv5outAecRBPbysVa9CIhGnJDAZK9AT1h3JrxYmeB4cDptewB7fGAOnJja
	Ciy9D0w7/As2+dsXUmIF6P88aqDKwYc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-oZyP9VfePxiTF5hGONLxYQ-1; Tue,
 06 Oct 2026 11:14:39 -0400
X-MC-Unique: oZyP9VfePxiTF5hGONLxYQ-1
X-Mimecast-MFC-AGG-ID: oZyP9VfePxiTF5hGONLxYQ_1791299677
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64E2B1967C63;
	Tue,  6 Oct 2026 15:14:37 +0000 (UTC)
Received: from [100.91.101.41] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD79041D;
	Tue,  6 Oct 2026 15:14:34 +0000 (UTC)
Message-ID: <417953c9-001b-4f48-a594-bfa49f387b49@redhat.com>
Date: Tue, 6 Oct 2026 17:14:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] dpll: zl3073x: make embedded sync follow the
 output carrier frequency
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261002074520.30048-2-ivecera@redhat.com>
 <179127408522.434549.10860667170628048867@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179127408522.434549.10860667170628048867@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/6/26 10:08, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] zl3073x_dpll_output_pin_esync_get()
>    (drivers/dpll/zl3073x/dpll.c, lines 881-887) now reports esync->freq =…
> - [Low] When the requested output frequency equals the synthesizer
>    frequency, new_div is 1.
> 
> --
> 
> dpll: zl3073x: make embedded sync follow the output carrier frequency
> 
> This patch moves the output pin eSync handling into new
> zl3073x_out_esync_{is_enabled,enable,disable}() helpers in out.h and uses
> them from esync_get() and esync_set(). It also makes
> zl3073x_dpll_output_pin_frequency_set() recompute the eSync period and
> width after the divider changes, and disables eSync when the new frequency
> is 1 Hz.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index f2e137475b40f..19456fbeeea84 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
> 
> [ ... ]
> 
>> @@ -864,38 +864,28 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
> 
> [ ... ]
> 
>>   	esync->range = esync_freq_ranges;
>>   	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>>   
>> -	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
>> -		/* No need to read esync data if it is not enabled */
>> +	if (zl3073x_out_esync_is_enabled(out)) {
>> +		esync->freq = 1;
>> +		esync->pulse = 25;
>> +	} else {
>>   		esync->freq = 0;
>>   		esync->pulse = 0;
>> -
>> -		return 0;
>>   	}
>>   
>> -	/* Compute esync frequency */
>> -	esync->freq = out_freq / out->esync_n_period;
>> -
>> -	/* By comparing the esync_pulse_width to the half of the pulse width
>> -	 * the esync pulse percentage can be determined.
>> -	 * Note that half pulse width is in units of half synth cycles, which
>> -	 * is why it reduces down to be output_div.
>> -	 */
>> -	esync->pulse = (50 * out->esync_n_width) / out->div;
>> -
>>   	return 0;
>>   }
> 
> [Severity: Medium]
> The commit message calls this factoring the eSync handling into helpers.
> However, zl3073x_dpll_output_pin_esync_get() now reports freq = 1 and
> pulse = 25 based only on the clock type. It no longer computes them from
> esync_n_period, esync_n_width and div. Is this change in the reported
> values intended?
> 
> zl3073x_out_state_fetch() reads the period and width from the device
> as-is, and only rejects a zero period:
> 
> drivers/dpll/zl3073x/out.c:zl3073x_out_state_fetch() {
>      ...
> 	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
> 			      &out->esync_n_period);
>      ...
> 	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH,
> 			      &out->esync_n_width);
>      ...
> }
> 
> The device could be running a non-1 Hz eSync, either from its flash
> configuration or from a stale period left by an older kernel (probe does
> not reset the chip). Would that now be reported as 1 Hz?
> 
> The pulse value looks affected too. zl3073x_out_esync_enable() sets
> esync_n_width = out->div / 2, so an odd divider such as div = 5 gives 20%.
> The old getter reported 20 here, and this one reports 25. With div = 1 the
> width is 0, which is also reported as 25.
> 
> The frequency case is harder to recover from because the core skips the
> driver when the requested value equals what esync_get() returns:
> 
> drivers/dpll/dpll_netlink.c:dpll_pin_esync_set() {
>      ...
> 	if (freq == esync.freq)
> 		return 0;
>      ...
> }
> 
> Suppose the hardware eSync on an output is not 1 Hz and a user requests
> 1 Hz. Would the request succeed without reprogramming anything?
> 
> For comparison, zl3073x_dpll_input_pin_esync_get() still checks the
> hardware divider before it reports 1 Hz:
> 
> 	esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
> 
> Should the output pin getter keep deriving the values from the cached
> register state in the same way?

Yes, reporting the fixed values is intended. The driver only ever
programs a 1 Hz / 25% eSync (zl3073x_out_esync_enable() always sets a
1 Hz period and width = div / 2), so esync_get() reports that nominal
model from the clock type and stays symmetric with esync_set(). I would
like to keep this behaviour.

What I do not want to do is claim that it faithfully reports a
configuration the driver did not establish. You are right that:

   - a non-1 Hz eSync left in flash or by an older kernel would now be
     reported as 1 Hz, and
   - an odd divider gives width = div / 2, i.e. a duty cycle below 25%
     (e.g. 20% for div = 5), which is still reported as 25%.

These are both configurations outside the driver's supported eSync model.
The getter deliberately presents the model the driver implements rather
than the raw register state. In practice mostly 1PPS and 1PP2S (0.5 Hz
that is not supported by DPLL core) are used.

The real problem is the commit message, which overstated this. It said
the computed form "could only differ for an inconsistent register state,
which is exactly the stale configuration this change prevents". That is
not accurate: a plain esync_set(1 Hz) over a stale non-1 Hz configuration
is short-circuited by the core (freq == esync.freq in
dpll_pin_esync_set()), so it would not reprogram anything. For the next
version I will reword that paragraph so it only claims what the change
actually does - report the nominal 1 Hz / 25% model - and explicitly
notes the two cases above as configurations the driver does not try to
reproduce. No code change is needed for this point.

> 
> [ ... ]
> 
>> @@ -1009,6 +984,22 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>>   		/* For 50/50 duty cycle the divisor is equal to width */
>>   		out.width = new_div;
>>   
>> +		/* The embedded sync period and width are computed relative to
>> +		 * the output carrier so they have to be adjusted to follow the
>> +		 * new frequency.
>> +		 */
>> +		if (zl3073x_out_esync_is_enabled(&out)) {
>> +			if (frequency == 1) {
>> +				/* Disable eSync if the new frequency is 1 Hz */
>> +				zl3073x_out_esync_disable(&out);
>> +			} else {
>> +				/* Update esync period and width according to
>> +				 * the new frequency.
>> +				 */
>> +				zl3073x_out_esync_enable(&out, synth_freq / out.div);
> 
> [Severity: Low]
> What happens here when the requested frequency equals the synth frequency?
> In that case new_div is 1, and zl3073x_out_esync_enable() sets:
> 
> 	out->esync_n_width = out->div / 2;
> 
> That gives a width of 0 while the ESYNC clock type stays set.
> zl3073x_out_state_set() then writes 0 to ZL_REG_OUTPUT_ESYNC_WIDTH, and
> esync_get() still reports freq = 1 and pulse = 25.
> 
> The 1 Hz case disables eSync. Should a divider that cannot hold a non-zero
> 25% width also be rejected, or have eSync disabled?
> 
> zl3073x_dpll_output_pin_esync_set() already had the same div / 2
> arithmetic. This patch adds a new path that reaches it automatically on a
> frequency change.

Good catch. I will make this new path unreachable instead of handling
the width = 0 case. For the next version I plan to add a preparatory
patch ("dpll: zl3073x: reject output frequencies with too small divisor")
that requires an output divisor of at least 2, so zl3073x_pin_check_freq()
will no longer offer the synth frequency (div = 1) in freq_supported. The
only way frequency == synth_freq could still reach frequency_set() is if
the output is already at div = 1, and then the core skips the call
(freq == old_freq in dpll_pin_frequency_set()). With that in place,
frequency_set() can never compute new_div == 1, so the eSync path this
patch adds cannot produce width = 0.

Ivan

