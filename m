Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DA4399F9
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791793; cv=none; b=e8zG69Rg/0Eks2NAn7VKlpSsN1p51RgwG9g0f4IqTY5htxiREnEUEjGvA3OSoH6lpkmPAcW91hVm7X9JcRPrsMAdLxWyW6+vtHEvpg0OlGHmWP5tnSY7oYY0heBB6+nUJV5kRWFHYCK52dtj+v7NZgQ6kT5q1UiTkeQvE39+hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791793; c=relaxed/simple;
	bh=5g/vd714QxtXPxteGWzkxZjzLcmYZFh4LjP5LF+kwko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cj3VUE6R7ndWLrce3yGqUL3dTXOh7wAMaV1G0Wx64aSn9TU5LrcRsNhTzXG0OG65RDoNfewXB/3vqyG6tZYOAX9uwVnFYlioELjIraOWjNU8ZkHWxIsj6Y/M8aBbDQK3c9EwZT2i5V5qIUrHw/IBgGutLI2UGtAuAaUizLjHtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0wQ+9E2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0wQ+9E2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791791790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ablnLGW299doho7l5Tl3Z5zKXL0TE4+5th6qvfwQSUY=;
	b=Y0wQ+9E2tIWA84+OAQqMAF6DMKptDZ3DNJ1TpW5bMqEh52aTr9ratVauRD8tU7wE1sM72m
	qyOrfIyaWw7z3oGT9PZnTZkO7nhfYLLmfbH0EnLdBntRqzChXaybycOdwHBn+6tU4yHfdM
	pQjHTdo0ZAAt3HuPIFia1NGk5Pv6+XY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-ISj1wVsTP36bboTZr6pxgA-1; Mon,
 12 Oct 2026 07:56:27 +0000
X-MC-Unique: ISj1wVsTP36bboTZr6pxgA-1
X-Mimecast-MFC-AGG-ID: ISj1wVsTP36bboTZr6pxgA_1791791785
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA7F31800D84;
	Mon, 12 Oct 2026 07:56:24 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0533A30001B9;
	Mon, 12 Oct 2026 07:56:21 +0000 (UTC)
Message-ID: <f5ce3575-3c1b-471c-86aa-e74d9f4df0be@redhat.com>
Date: Mon, 12 Oct 2026 09:56:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/5] dpll: zl3073x: reject output frequencies with
 too small divisor
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261011061211.448373-4-ivecera@redhat.com>
 <179178562335.434549.16077864729187599251@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179178562335.434549.16077864729187599251@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/12/26 08:13, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The current output frequency skips the new minimum-divisor
>    rule.
> - [Medium] The commit message says that for N-divided outputs the min-
>    divisor check is 'necessary but not sufficient, the rest is checked by…
> 
> Pre-existing issues:
> - [Medium] eSync can be enabled on an output whose divisor is 1.
> 
> --
> 
> dpll: zl3073x: reject output frequencies with too small divisor
> 
> This adds a minimum output divisor check to zl3073x_pin_check_freq().
> Firmware-provided output frequencies must now give a divisor of at least
> 2, or at least 4 for the N-pin of an N-divided output. Frequencies that
> fail the check are dropped from the supported list.
> 
>> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
>> index 768e5424de2d2..4e006ed5950ad 100644
>> --- a/drivers/dpll/zl3073x/prop.c
>> +++ b/drivers/dpll/zl3073x/prop.c
> 
> [ ... ]
> 
>> @@ -41,18 +42,38 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
> 
> [ ... ]
> 
>>   		/* Check the frequency divides synth frequency */
>> -		if (synth_freq % (u32)freq)
>> +		div = div_u64_rem(synth_freq, freq, &rem);
>> +		if (rem)
>> +			goto err_inv_freq;
>> +
>> +		/* The driver requires an output divisor of at least 2 -
>> +		 * below that the hardware bypasses the divider and ignores
>> +		 * the pulse width and eSync registers the driver programs.
>> +		 * For the N-pin of an N-divided output the effective divisor
>> +		 * also includes the N divider (>= 2), so the minimum is 4.
>> +		 * For N-divided outputs this is only a necessary condition -
>> +		 * whether the frequency can be set also depends on the output
>> +		 * divisor shared by both pins, which is checked when the
>> +		 * frequency is set.
>> +		 */
>> +		out = zl3073x_out_state_get(zldev, out_id);
>> +		if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
>> +			min_div = 4;
>> +		else
>> +			min_div = 2;
>> +		if (div < min_div)
>>   			goto err_inv_freq;
>>   	}
> 
> [Severity: Medium]
> Can the current output frequency get past this new minimum divisor check?
> 
> zl3073x_pin_props_get() puts curr_freq at index 0 of freq_supported
> without calling zl3073x_pin_check_freq(). It also skips any firmware
> entry equal to curr_freq, so that value is never validated either:
> 
> drivers/dpll/zl3073x/prop.c:zl3073x_pin_props_get() {
>      ...
> 	j = 0;
> 	if (curr_freq) {
> 		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);
> 
> 		ranges[j++] = freq;
> 	}
>      ...
> 	for (i = 0; i < num_freqs; i++) {
> 		...
> 		if (freqs[i] == curr_freq)
> 			continue;
> 		if (zl3073x_pin_check_freq(zldev, dir, index, freqs[i])) {
>      ...
> }
> 
> zl3073x_out_state_fetch() only rejects a zero divisor. An output can
> therefore come up from the flash configuration with div == 1, and then
> curr_freq == synth_freq stays in the supported list.
> 
> dpll_pin_freq_set() only checks that the frequency is in
> freq_supported. zl3073x_dpll_output_pin_frequency_set() puts no lower
> bound on new_div:
> 
> 	new_div = synth_freq / (u32)frequency;
> 
> 	/* Check signal format */
> 	if (!zl3073x_out_is_ndiv(&out)) {
> 		...
> 		out.div = new_div;
> 
> 		/* For 50/50 duty cycle the divisor is equal to width */
> 		out.width = new_div;
> 
> The N-div P-pin branch also does out.div = new_div after checking only
> n_period.
> 
> A user can move the output away from its boot frequency and then set it
> back. The driver then programs divisor 1 again. The commit message says
> the hardware then ignores the pulse width and eSync registers. In N-div
> mode those registers also hold the N-pin's N divider.
> 
> At the end of the series, a frequency_set with eSync enabled calls
> zl3073x_out_esync_enable() with div == 1, which writes
> esync_n_width = 0.
> 
> The previous patch in the series ("dpll: zl3073x: do not offer 0 Hz as
> a supported pin frequency") already filters curr_freq for 0 Hz. Should
> curr_freq also go through the divisor check? Alternatively, should
> zl3073x_dpll_output_pin_frequency_set() reject new_div < 2? Later
> patches in the series don't seem to add either check.

No. A divisor of 1 can only come from the boot configuration and is
rarely used in practice: with the synthesizer running at up to 750 MHz
it is only needed for output frequencies above 375 MHz, which only
differential outputs support. Setting the current frequency back just
restores that boot state, which the hardware supports, and the
hardware ignores the pulse width in that mode anyway.

> [Severity: Medium]
> The commit message says:
> 
>    For N-divided outputs this is necessary but not sufficient, the rest
>    is checked by the frequency set callback.
> 
> Does the frequency set callback actually check the out.div >= 2 part?
> The N-pin branch of zl3073x_dpll_output_pin_frequency_set() uses
> whatever out.div is currently programmed:
> 
> 	} else {
> 		/* The N-pin frequency has to divide the P-pin frequency and
> 		 * be at most half of it.
> 		 */
> 		n_period = frequency * out.div;
> 		n_period = div64_u64_rem(synth_freq, n_period, &rem);
> 	}
> 
> After that it only rejects n_period < 2, n_period > U32_MAX and a
> non-zero remainder before committing out.esync_n_period.
> 
> The check added here only looks at the total divisor
> synth_freq / freq >= 4. That can't tell out.div = 2, N = 2 apart from
> out.div = 1, N = 4.
> 
> An N-div output can end up with out.div == 1 in two ways:
> 
>    - the boot configuration, since zl3073x_out_state_fetch() only
>      rejects 0
>    - restoring a P-pin frequency equal to synth_freq through the
>      unvalidated curr_freq entry
> 
> In that case the N-pin set succeeds, and
> zl3073x_dev_output_pin_freq_get() reports synth_freq / N.
> 
> The hardware ignores the N divider register at divisor 1. Wouldn't the
> reported N-pin frequency then differ from what the pin actually
> produces? This looks like a variant of the "no output on an
> oscilloscope" case in the commit message. It still seems to be present
> at the end of the series.

The datasheet requires an output divisor of 2 or more in N-pin divide
mode, so out.div == 1 there is an invalid boot configuration. N-pin
divide modes are also CMOS only, and CMOS outputs are limited to
250 MHz, so a divisor of 1 is never needed there. The driver does not
try to fix it.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the eSync callbacks seem
> to reach the same divisor 1 case.
> 
> zl3073x_dpll_output_pin_esync_get() advertises eSync ranges whenever
> the output is not N-div, esync_control is set and out_freq > 1:
> 
> 	out_freq = synth_freq / out->div;
> 
> 	if (!pin->esync_control || out_freq <= 1)
> 		return -EOPNOTSUPP;
> 
> With out->div == 1, out_freq == synth_freq, so this check passes.
> zl3073x_dpll_output_pin_esync_set() then sets the clock type to ESYNC
> and commits without checking out.div >= 2:
> 
> 	out.esync_n_period = synth_freq / (u32)freq / out.div;
> 	...
> 	out.esync_n_width = out.div / 2;
> 
> For div == 1 this writes esync_n_width = 0.
> 
> This commit says the hardware ignores the eSync registers at divisor 1.
> Would the driver then report eSync as enabled with a given frequency
> and pulse, while the device outputs a plain clock?

Yes, but only for an output that the flash configuration left in
divider bypass. Supporting eSync in that mode is out of scope for this
series.

Thanks,
Ivan

