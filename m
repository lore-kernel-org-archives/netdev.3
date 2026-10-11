Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3351A682C
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698762; cv=none; b=kqaWgaBc2JNf7W3uu2ppRDb122Zg7cPNAQVXptykg4vskzvurxaMNKwUCR05zGSGtWJxArh6U1Unp20kacgk2Hg87yVlGAPWo02pI5HsCWBX89vywRaiJUoY54Bc8AZcxz8EuJ3mnlw4PWfigjbTxz1ZA6FZhdthM2YlCnKDYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698762; c=relaxed/simple;
	bh=Ko1rwNvxOIo8WlbGiktUw0zsW1dF4F4oBjsnhDJcW6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBkIK7NyxSQBNdhbO12okfghTi58A5V+TEKBlh2W8mNJZCPFhcdgR47znVRPiOWjhH8+e896VmHcOduGQZHzKJHl4tjlfz6o8f/haRhBa0N2X2eKSiI7yKcqHT8WF3nG8mVFaTQp1SFYYcAGahTkXGurXjqEO/+2+jlj4egS4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RE3QOd+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE3QOd+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791698758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzD+3xdEd5Q/l4mFO/uhSnmUpJTKzxsMZ9agePwBXUw=;
	b=RE3QOd+ALXhJkFZ9NvpS0OdR7ZeUHRUEr1O6z87FEoGT6xlNUqyeF023Hc12H3LByrrj9J
	4jCWqHR96e15bUDqpFnVKxAvpxrJ2QOdNd4/D1Z7pjj6noc2shGH154h6MKO4+4Iueoaou
	ve9FWoMkRURfCc62QaMlKWnKw9dvI2c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-awbPnuu8Mr2ZWVo23w4D2w-1; Sun,
 11 Oct 2026 06:05:53 +0000
X-MC-Unique: awbPnuu8Mr2ZWVo23w4D2w-1
X-Mimecast-MFC-AGG-ID: awbPnuu8Mr2ZWVo23w4D2w_1791698752
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF29F1955F07;
	Sun, 11 Oct 2026 06:05:51 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0CB21956095;
	Sun, 11 Oct 2026 06:05:48 +0000 (UTC)
Message-ID: <04fb95ae-92e6-428c-b1d6-d6adffe748c7@redhat.com>
Date: Sun, 11 Oct 2026 08:05:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 4/5] dpll: zl3073x: reject inexact frequencies for
 N-divided outputs
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261009192556.272263-5-ivecera@redhat.com>
 <179166042288.434549.8898926010926233618@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179166042288.434549.8898926010926233618@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 10/10/26 21:27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] After this patch, zl3073x_dpll_output_pin_frequency_set()
>    rejects an N-pin frequency that the driver itself advertises as…
> 
> Pre-existing issues:
> - [Low] The three NL_SET_ERR_MSG_FMT() diagnostics this patch adds to
>    zl3073x_dpll_output_pin_frequency_set() never reach userspace.
> 
> --
> 
> dpll: zl3073x: reject inexact frequencies for N-divided outputs
> 
> This patch changes zl3073x_dpll_output_pin_frequency_set() for N-divided
> outputs. The esync_n_period computation now uses a 64-bit product, and the
> request is rejected when the resulting period is below 2, does not fit
> into 32 bits, or the division leaves a remainder.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index 8bac680394d76..6d9a6d21d30b7 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
> 
> [ ... ]
> 
>> @@ -1033,17 +1029,31 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>>   		/* For 50/50 duty cycle the divisor is equal to width */
>>   		out.width = out.div;
>>   	} else {
>> -		/* We are going to change frequency of N-pin but if
>> -		 * the requested freq is greater or equal than freq of P-pin
>> -		 * in the output pair we cannot compute divisor for the N-pin.
>> -		 * In this case indicate a failure.
>> -		 *
>> -		 * Update divisor for N-pin
>> +		/* The N-pin frequency has to divide the P-pin frequency and
>> +		 * be at most half of it.
>>   		 */
>> -		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
>> -		if (!out.esync_n_period)
>> -			return -EINVAL;
>> +		n_period = frequency * out.div;
>> +		n_period = div64_u64_rem(synth_freq, n_period, &rem);
>> +	}
>> +	if (n_period < 2) {
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "OUT%uN freq must be at most half of OUT%uP freq",
>> +				   out_id, out_id);
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but will userspace ever see
> these three new extack messages?

No, dpll_pin_freq_set() overwrites them. That is a DPLL core issue and
out of scope for this series.

> The only caller, dpll_pin_freq_set() in drivers/dpll/dpll_netlink.c,
> always writes its own message when the driver callback fails:
> 
> drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
>      ...
> 	ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
> 				 dpll, dpll_priv(dpll), freq, extack);
> 	if (ret) {
> 		NL_SET_ERR_MSG_FMT(extack,
> 				   "frequency set failed for dpll_id:%u",
> 				   dpll->id);
> 		return ret;
> 	}
>      ...
> }
> 
> NL_SET_ERR_MSG_FMT() unconditionally replaces extack->_msg, so the
> "OUT%uN freq must ..." strings from zl3073x get replaced by the generic
> core message. ice_dpll_pin_freq_set() loses its messages the same way.
> 
> Would it make sense to switch the core to NL_SET_ERR_MSG_WEAK(), or to
> keep a message the driver has already set?

Yes, it make sense. This will be handled separately (not in this series).

 >> +		return -EINVAL;>> +	}
>> +	if (n_period > U32_MAX) {
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "OUT%uN freq is too low for OUT%uP freq",
>> +				   out_id, out_id);
>> +		return -EINVAL;
>> +	}
>> +	if (rem != 0) {
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "OUT%uN freq must divide OUT%uP freq",
>> +				   out_id, out_id);
>> +		return -EINVAL;
> 
> [Severity: Medium]
> Can this reject an N-pin frequency that the driver itself lists as
> supported?
> 
> The hardware N-pin frequency is synth_freq / (div * esync_n_period), and
> that does not have to be a whole number of Hz. The getter rounds it down:
> 
> drivers/dpll/zl3073x/core.h:zl3073x_dev_output_pin_freq_get() {
>      ...
> 	freq = zl3073x_synth_freq_get(synth) / out->div;
> 
> 	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
> 		freq /= out->esync_n_period;
>      ...
> }
> 
> zl3073x_pin_props_get() then adds this rounded value to freq_supported.
> Unlike the firmware-listed frequencies, it does not go through
> zl3073x_pin_check_freq():
> 
> 	if (curr_freq) {
> 		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);
> 
> 		ranges[j++] = freq;
> 	}
> 
> For example, take a 600 MHz synth with div=60 and esync_n_period=7. The
> real N-pin frequency is 1428571.43 Hz, and it is advertised as 1428571 Hz.
> 
> Say userspace moves the N-pin to another supported value, such as a
> firmware-listed 1 MHz, and then tries to set it back to 1428571 Hz.
> dpll_pin_is_freq_supported() accepts the value, and then this function
> computes:
> 
>      n_period = 1428571 * 60 = 85714260
>      div64_u64_rem(600000000, 85714260, &rem) -> 7, rem = 180
> 
> The new rem != 0 check returns -EINVAL here. The old truncating division
> gave n_period = 7, which restored the original hardware setting.
> 
> The comment in zl3073x_pin_props_get() says a frequency that "cannot be
> set ... is not offered", which suggests the current frequency added there
> is expected to be settable. Should the advertised current frequency be
> skipped or checked for inexact N-divided outputs, or should the setter
> accept the truncated value?

Neither. A non-integer N-pin frequency can only come from the flash
configuration, and the DPLL API works in whole Hz, so such a frequency
cannot be requested exactly. The old truncating division restored it
only by accident. Accepting truncated values again would bring back the
silent rounding this patch removes.

Thanks,
Ivan

