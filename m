Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36163290AF
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789391; cv=none; b=NPhWDLLfofRdq5Gi3ZZtEhPmB1AMdpwlWscX9G2ZdtwHV8Qw+0GYAa/9c7dZw/MeXTMLMnVunC6xj0rt653wEKVmpBxbD75vHqilHrRYRL60rhwq9BfElgt/UUXEKgzvQ69XeOeDp0na6ImHkbDxkgPXhMNN+PUCz43oHidk9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789391; c=relaxed/simple;
	bh=Ltepxoxgsvwi/c+zVbGbBb5nUiL/dfxeLhn5Yz8DHU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgTZzmGwpk8L/egVOcnXnhYn2dGnkVU1HCZa2AgEpmIADwpb5NOAnrjbtfmP2Pef6EklA6TjizVKx1NCQkK2t5bHT2r3MQ3eiNg4gfQLS/qBhKc6D2gOh7O4DbwTP5W/y/qtaLou3TTrd4mza89R/sTf/DTN/NiyEHiNvmlvipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIZwFDLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIZwFDLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791789388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TxRBaTllIGO8wccGzCsg07PDjlTm9+uFFv0sibxJJA=;
	b=JIZwFDLXpViF/aozlyDI+5VQghJcGSv4yTTz2DbKWVGLcKWMwf6nPyWHoI5znokAH7ZAjj
	dhuk8J6rG+WsiWCNdBBT8x7X8XI+IwD6xe1nK6G6Bd4joSqbFNcVBNBHutuUpdMZX7UTPa
	C4fcEQHADEEzGeCc778MsF5GCfEWarY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-bd08KXrdPXmmteXhr7NK7g-1; Mon,
 12 Oct 2026 07:16:23 +0000
X-MC-Unique: bd08KXrdPXmmteXhr7NK7g-1
X-Mimecast-MFC-AGG-ID: bd08KXrdPXmmteXhr7NK7g_1791789381
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD9971955EA8;
	Mon, 12 Oct 2026 07:16:21 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DEBD1800351;
	Mon, 12 Oct 2026 07:16:18 +0000 (UTC)
Message-ID: <8c0f0cdd-9de7-4f33-9864-d25585bcd589@redhat.com>
Date: Mon, 12 Oct 2026 09:16:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/5] dpll: zl3073x: reject inexact frequencies for
 N-divided outputs
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261011061211.448373-3-ivecera@redhat.com>
 <179178562205.434549.16391656740065795175@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179178562205.434549.16391656740065795175@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/12/26 08:13, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Concern: zl3073x_pin_props_get() always lists the current
>    (truncated) frequency as supported.
> 
> Pre-existing issues:
> - [Low] Concern: userspace never sees the three new extack messages added
>    in `zl3073x_dpll_output_pin_frequency_set()` ("must be at most half",…
> 
> --
> 
> dpll: zl3073x: reject inexact frequencies for N-divided outputs
> 
> This commit tightens zl3073x_dpll_output_pin_frequency_set() for
> N-divided outputs. It computes esync_n_period in 64 bits and requires it
> to be at least 2 and to fit into 32 bits. It also rejects any request
> whose division leaves a remainder, and reports each failure case through
> extack.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index f2e137475b40f..7a617d9bd6712 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
> 
> [ ... ]
> 
>> @@ -1031,17 +1027,31 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>>   		/* For 50/50 duty cycle the divisor is equal to width */
>>   		out.width = out.div;
>>   	} else {
> 
> [ ... ]
> 
>> +		n_period = frequency * out.div;
>> +		n_period = div64_u64_rem(synth_freq, n_period, &rem);
>> +	}
>> +	if (n_period < 2) {
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "OUT%uN freq must be at most half of OUT%uP freq",
>> +				   out_id, out_id);
>> +		return -EINVAL;
>> +	}
> 
> [Severity: Low]
> This is a pre-existing issue and was not introduced by this patch, but
> will userspace ever see this message, or the two added below it?

No, as I mentioned in v4, dpll_pin_freq_set() overwrites them. That is a DPLL
core issue and out of scope for this series.

> 
> When ops->frequency_set() fails, the DPLL core overwrites the driver's
> extack text:
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
> NL_SET_ERR_MSG_FMT() always writes into extack->_msg_buf and resets
> _msg. The "must be at most half", "is too low" and "must divide" messages
> are therefore replaced by the generic text, and they can only be seen
> through the netlink_extack tracepoint. The -EINVAL return is still
> correct.
> 
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
>>   	}
> 
> [Severity: Low]
> Can this check reject a frequency that zl3073x_pin_props_get() lists as
> supported?
> 
> zl3073x_pin_props_get() always puts the current frequency into the
> supported list. For an N-pin, that value comes from a truncating
> division:
> 
> drivers/dpll/zl3073x/core.h:zl3073x_dev_output_pin_freq_get() {
>      ...
> 	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
> 		freq /= out->esync_n_period;
>      ...
> }
> 
> Also, zl3073x_out_state_fetch() only refuses esync_n_period == 0, so a
> boot config with esync_n_period == 1 is accepted.
> 
> A request for the current value never reaches the driver, because
> dpll_pin_freq_set() returns early when freq == old_freq. If the pin is
> first moved to another frequency, though, a later request for the
> advertised boot value can fail.
> 
> Take a 600 MHz synth, div=60 and a boot esync_n_period of 7. The N-pin
> is advertised as 1428571 Hz. After N is moved to 1 MHz, a request for
> 1428571 gives rem=180 and returns -EINVAL.
> 
> In the same way, a P-pin frequency that would bring back
> esync_n_period == 1 now fails the n_period < 2 check. According to the
> series commit "dpll: zl3073x: reject output frequencies with too small
> divisor", that state gave no N-pin output.
> 
> This looks consistent with the goal of rejecting inexact N frequencies.
> A later comment in prop.c in this series also says the supported list
> for N-divided outputs is only a necessary condition. The old code
> already rejected some advertised values, such as N-pin frequencies at or
> above the P-pin frequency.
> 
> Is it intended that a user cannot go back to an inexact boot-time N-pin
> setting by asking for its advertised value?

Yes. Such a value can only come from the flash configuration and cannot
be requested exactly in whole Hz. Accepting truncated values would
bring back the silent rounding this patch removes.

Thanks,
Ivan

