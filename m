Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57883D47C2
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698608; cv=none; b=RRWzTctaVRL6kvpJUhwN7TB8CRc9pPYANVuWNjaXfi2bX1/CiARgzS0ot5NOnrYg5AtOEk3/BhYeerjS0Y6uN7fotKIHfWTti2oet/z9KmF2f4H/LTOSAYtfYm7iJtzyS7T2J2nFbuFebPdVyS2f5/HU1IRmTDala4838QlDPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698608; c=relaxed/simple;
	bh=nQpvMCGgkyt9MSyqRY39sw1GnvJ/gaZQbXT41fvRwsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=di3FuLHVcvIGWmpPJRN66aWwpiiX6o62emSy99mBEM31pwfaEyhQAErbGFQRYpuszFPsC1PesK2ai8lo0wnA/6BQrAWp9iT2ErNrXlgAYUVduMnvX+UabYo4y5qw4ppCw2ua9ZrYPs3me4OqUgl40GZ8Cne+X5E/X3KkGsnAJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfWLgMSA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfWLgMSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791698604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1jVgua0NnXL0iJG6bxgz1clkCHyQrP2VfEQZ2SSg/I=;
	b=gfWLgMSAUK+Zw3kL5jDb35XRxH6dwMWP3kDDu3MP+61oaHOH7zgKcl3HKBjspj14TxPvlB
	oY8O6PAgn8unz8kWSGOo5XsnZBwXwr8V109aUYyEXglGfTWfwt10uH9egGOS3uO0Cx6gRS
	8epZmP9SyIhvKfx5GMwzgGsKd9TrQjw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-UiaRzfvqPSKaEQ0Evd5Nlg-1; Sun,
 11 Oct 2026 06:03:20 +0000
X-MC-Unique: UiaRzfvqPSKaEQ0Evd5Nlg-1
X-Mimecast-MFC-AGG-ID: UiaRzfvqPSKaEQ0Evd5Nlg_1791698598
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48852182F550;
	Sun, 11 Oct 2026 06:03:18 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33ECA472;
	Sun, 11 Oct 2026 06:03:15 +0000 (UTC)
Message-ID: <975fef61-6f4c-4e39-a800-ea1df868520e@redhat.com>
Date: Sun, 11 Oct 2026 08:03:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/5] dpll: zl3073x: reject output frequencies with
 too small divisor
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261009192556.272263-3-ivecera@redhat.com>
 <179166042155.434549.16991158418874345163@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179166042155.434549.16991158418874345163@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/10/26 21:27, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] Kept only because requires_validation=true.
> - [Low] The commit message does not say that the new `!freq` check fixes
>    a division by zero that firmware can trigger at probe time.
> 
> --
> 
> dpll: zl3073x: reject output frequencies with too small divisor
> 
> This patch makes zl3073x_pin_check_freq() reject output frequencies from
> firmware when the resulting divisor is below 2. For the N-pin of an
> N-divided output the minimum is 4. The patch also rejects 0 Hz for both
> input and output pins.
> 
>> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
>> index 18a1bf3103326..4e006ed5950ad 100644
>> --- a/drivers/dpll/zl3073x/prop.c
>> +++ b/drivers/dpll/zl3073x/prop.c
> 
> [ ... ]
> 
>> @@ -30,7 +31,7 @@ static bool
>>   zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>>   		       u8 id, u64 freq)
>>   {
>> -	if (freq > U32_MAX)
>> +	if (!freq || freq > U32_MAX)
>>   		goto err_inv_freq;
> 
> [Severity: Low]
> Should the commit message say that this check also fixes a divide error at
> probe time?
> 
> Before this patch, the output path did:
> 
> 	if (synth_freq % (u32)freq)
> 
> zl3073x_pin_props_get() only skips a supported-frequencies-hz entry when it
> equals curr_freq:
> 
> 	if (freqs[i] == curr_freq)
> 		continue;
> 	if (zl3073x_pin_check_freq(zldev, dir, index, freqs[i])) {
> 
> The dpll-pin.yaml binding doesn't set a minimum value. So an output pin
> entry of 0 in firmware would reach the modulo and oops during probe.
> 
> The same check also changes how input pins behave. Before,
> zl3073x_ref_freq_factorize(0, ...) succeeded, because 0 / 1 <= U16_MAX and
> 0 % 1 == 0. That meant 0 Hz was advertised as a supported input frequency.
> With this patch it is dropped.
> 
> The commit message only says "reject 0 Hz". Could it also describe the
> crash fix and the change for input pins?

I will move the 0Hz check to the first patch and update commit message
accordingly.>
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
> 
> [Severity: Medium]
> Is the "checked when the frequency is set" part true at this commit? The
> commit message makes the same claim:
> 
>    "For N-divided outputs this is necessary but not sufficient, the rest
>     is checked by the frequency set callback."
> 
> In zl3073x_dpll_output_pin_frequency_set() in drivers/dpll/zl3073x/dpll.c,
> both N-divided branches only reject an N period of zero:
> 
> 	if (zl3073x_dpll_is_p_pin(pin)) {
> 		...
> 		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
> 		if (!out.esync_n_period)
> 			return -EINVAL;
> 		...
> 	} else {
> 		...
> 		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
> 		if (!out.esync_n_period)
> 			return -EINVAL;
> 	}
> 
> Neither branch requires an N divider of at least 2, and neither checks for
> a remainder.
> 
> For example, take a 1 GHz synth with out.div == 4:
> 
> - Requesting 250 MHz on the N-pin passes zl3073x_pin_check_freq(), since
>    div 4 >= min_div 4. The setter then programs an N divider of 1.
> - Requesting 100 MHz on the N-pin gives esync_n_period == 2, so the pin
>    runs at 125 MHz instead of 100 MHz.
> 
> Neither request returns an error.
> 
> A later patch in this series, "dpll: zl3073x: reject inexact frequencies
> for N-divided outputs", appears to add these checks. It uses
> div64_u64_rem() and rejects n_period < 2, n_period > U32_MAX and a non-zero
> remainder.
> 
> Could the series be reordered so the setter checks land first?
> Alternatively, could the comment and commit message here be changed to
> match what the code does at this point?
Yes, will reorder.

Thanks,
Ivan

