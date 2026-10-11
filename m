Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9F2BD022
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698478; cv=none; b=rufBb0tuHlx4hh9+bsjzL7xW6HfC3JRoc5pamqrZjGELxwxZEc0sf7RsfvVwTfK86Qi2CRLJ2QiXwRQBhmf1hPpA8Bv5kbdy1FjmOaSvyGK9CFsSkt9gcLPoF11cI18GiygziZ/1f+wI7jtMpISY5SF5JUggIPNRC6iOoaFiD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698478; c=relaxed/simple;
	bh=1TgYOlUToR7bsqnqylHn2mvtz1Gmx/1YF4g318T7Gq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4xJdIJ8G3e5bg7J1EquhWYhhjZOt9a+UTqTzBwsKk6+l0UsmpVptW5Byha7EkVr07+G5SDFgznQupd8wyKplXetbrQ0LSs3AOJtOo0/l7Ez6Kzfsi3NXHshZd0ql13kXjJ6h+Myz6L+eR+isqkGdmT0/eIOmcSt0xINsphHWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/G2Fb06; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/G2Fb06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791698475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeZFZYg+H8IU4LKDAbgrE/pPmIzi68yx/ItbHA91QWc=;
	b=G/G2Fb06Gipj15VBfAwmsfexPFbiK+Im1w8Pe+aG+ZKjIqbyAM9Pm+enPshYEPCJyOaYID
	b4xonHAdgSsj1WQgeVjFt2fBtgIBdN1Ip3eABBcKtokzjBE5aYdYvGFvtVQLFqoc37Wzu3
	6kOj+1uTWN9MH5W9Zp8T0SUSzONH7CY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-vCJ_yTrdMlSD6gGDyPpyog-1; Sun,
 11 Oct 2026 06:01:12 +0000
X-MC-Unique: vCJ_yTrdMlSD6gGDyPpyog-1
X-Mimecast-MFC-AGG-ID: vCJ_yTrdMlSD6gGDyPpyog_1791698471
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63D931800643;
	Sun, 11 Oct 2026 06:01:10 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31E8518004D4;
	Sun, 11 Oct 2026 06:01:06 +0000 (UTC)
Message-ID: <5a711944-cd08-42f9-ae6d-6909b6b722ca@redhat.com>
Date: Sun, 11 Oct 2026 08:01:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/5] dpll: zl3073x: do not offer 0 Hz as a
 supported pin frequency
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261009192556.272263-2-ivecera@redhat.com>
 <179166042014.434549.4178521508120779611@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179166042014.434549.4178521508120779611@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/10/26 21:27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] At this commit, the subject says 0 Hz is no longer offered,
>    but zl3073x_pin_props_get() (drivers/dpll/zl3073x/prop.c) only filters…
> 
> --
> 
> dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
> 
> This patch stops zl3073x_pin_props_get() from putting the current pin
> frequency into the supported list when it reads back as 0 Hz. If the
> list ends up empty, it is freed and not published, because the DPLL
> core rejects an empty non-NULL list.
> 
>> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
>> index ac9d41d0f978e..18a1bf3103326 100644
>> --- a/drivers/dpll/zl3073x/prop.c
>> +++ b/drivers/dpll/zl3073x/prop.c
>> @@ -295,13 +295,20 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
>>   		goto err_alloc_ranges;
>>   	}
>>   
>> -	/* Start with current frequency at index 0 */
>> -	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
>> +	/* Start with current frequency at index 0. A sub-Hz frequency is
>> +	 * read back as 0 Hz and cannot be set, so it is not offered.
>> +	 */
>> +	j = 0;
>> +	if (curr_freq) {
>> +		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);
>> +
>> +		ranges[j++] = freq;
>> +	}
>>   
>>   	/* Add frequencies from firmware node, skipping current frequency
>>   	 * and filtering out frequencies not representable by device
>>   	 */
>> -	for (i = 0, j = 1; i < num_freqs; i++) {
>> +	for (i = 0; i < num_freqs; i++) {
>>   		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(freqs[i]);
>>   
>>   		if (freqs[i] == curr_freq)
> 
> [Severity: Medium]
> Can 0 Hz still end up offered through the firmware list?
> 
> The subject says 0 Hz is no longer offered. However, only a 0 Hz current
> frequency is filtered.
> 
> Suppose the "supported-frequencies-hz" property has a 0 entry and
> curr_freq is nonzero. That entry is not skipped by the
> freqs[i] == curr_freq check. It goes on to zl3073x_pin_check_freq(),
> which has no zero check at this commit:
> 
> drivers/dpll/zl3073x/prop.c:zl3073x_pin_check_freq() {
> 	if (freq > U32_MAX)
> 		goto err_inv_freq;
>      ...
> 		/* Check the frequency divides synth frequency */
> 		if (synth_freq % (u32)freq)
> 			goto err_inv_freq;
>      ...
> }
> 
> On an output pin, does this divide by zero during probe?
> 
> On an input pin, zl3073x_ref_freq_factorize(0, ...) succeeds on the first
> base frequency of 1. Here 0 / 1 = 0 <= U16_MAX and 0 % 1 == 0, so 0 Hz is
> published as supported. It could then be programmed with base 1 and
> multiplier 0.
> 
> The dpll-pin.yaml binding sets no minimum for supported-frequencies-hz,
> so the schema does not reject 0.
> 
> A later patch in this series, "dpll: zl3073x: reject output frequencies
> with too small divisor", changes the first check in
> zl3073x_pin_check_freq() to:
> 
> 	if (!freq || freq > U32_MAX)
> 		goto err_inv_freq;
> 
> That fixes this by the end of the series. At this intermediate commit,
> though, the 0 Hz case is still reachable from firmware.
> 
> Would it make sense to move the !freq check into this patch? Bisection
> would then not land on a kernel that can still divide by zero here.

Yes, I will move the !freq check into this patch.

Thanks,
Ivan
---
pw-bot: cr

