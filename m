Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3113A5E8F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789264; cv=none; b=P6ylavrhlzqh/LS0pvm+/Xnv4ZPoTvwlAx7CJJuD/HQRsPJe1RyT0FHWNYJnAnYlSjoMpohQHbuK34wwnrnG8BHlkqg5h8Y+r1+yFiP/L4I9QJbC02LN58tTfXYOeRAG5dyCMMjBtNZspm7nS3yCR5Xrv/ZxPUefnNEeOr7VKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789264; c=relaxed/simple;
	bh=9WaIHFKSEp1Mh0EY4LzoXVDcItB39+QZBsM6F7Y9/bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoUtP+HcZ0NDz77kCfgZ7n5Z2T1S/hetH/K8mMU5jbQSG6pW7UQTa6CZSiJc119gsuJ/OEs5rUzWmShFh2LndEvCZ44DrO84xrDSopMkRcwWjED2RN8MYIY/si9KkwFkIGRUMwNnYDfgYKi841bBa+vI5AjlncW/qk0yWaIlsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wo8p7fTy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo8p7fTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791789262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kQhW7XHwd2bgZ0aOycOAbqVJ+65LKVZRmOarAwwtYo=;
	b=Wo8p7fTyi4Y7X6Q53yDA5BamQ7Wf0G2nYR4Ycqog/hR/CviM/EEatqezLulbM6CUIGaEB9
	IM++9VF7DDUlbKxCBZEcxesVWD1a9ve8RBR1pob5yh/wh5tIhT0FnpuIUEKzvkMokfTOzo
	gtPSr+qX+3zRAsK0S8I54VyyJXKndtQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-a7cONxfTP1G9uCsl59Fj5A-1; Mon,
 12 Oct 2026 07:14:19 +0000
X-MC-Unique: a7cONxfTP1G9uCsl59Fj5A-1
X-Mimecast-MFC-AGG-ID: a7cONxfTP1G9uCsl59Fj5A_1791789257
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C0921800D84;
	Mon, 12 Oct 2026 07:14:17 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C22830000E7;
	Mon, 12 Oct 2026 07:14:14 +0000 (UTC)
Message-ID: <2f91b950-1daf-4e41-829c-5c0f02b19ace@redhat.com>
Date: Mon, 12 Oct 2026 09:14:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/5] dpll: zl3073x: do not offer 0 Hz as a
 supported pin frequency
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261011061211.448373-2-ivecera@redhat.com>
 <179178562093.434549.11224993829134202451@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179178562093.434549.11224993829134202451@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/12/26 08:13, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The patch fixes two separate 0 Hz bugs, but its only Fixes: tag
>    names 85a9aaac4a38 ("dpll: zl3073x: Include current frequency in…
> 
> Pre-existing issues:
> - [Medium] zl3073x_pin_props_get() still adds the probe-time current
>    frequency at index 0 after only a zero check (prop.c line 302).
> 
> --
> 
> dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
> 
> This patch stops zl3073x_pin_props_get() from adding a 0 Hz current
> frequency to the supported list. It also makes zl3073x_pin_check_freq()
> reject 0 Hz firmware node entries. If the resulting list is empty, it is
> not published.
> 
>> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
>> index ac9d41d0f978e..768e5424de2d2 100644
>> --- a/drivers/dpll/zl3073x/prop.c
>> +++ b/drivers/dpll/zl3073x/prop.c
>> @@ -30,7 +30,7 @@ static bool
>>   zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>>   		       u8 id, u64 freq)
>>   {
>> -	if (freq > U32_MAX)
>> +	if (!freq || freq > U32_MAX)
>>   		goto err_inv_freq;
> 
> [Severity: Low]
> 
> The commit message also says that a 0 Hz firmware node entry is divided by
> in zl3073x_pin_check_freq() at probe time. Does the Fixes: tag cover that
> part of the fix?
> 
> Before this patch, zl3073x_pin_check_freq() had:
> 
> 	if (freq > U32_MAX)
> 		goto err_inv_freq;
> 	...
> 		if (synth_freq % (u32)freq)
> 			goto err_inv_freq;
> 
> Both checks came from a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin
> properties from system firmware"), not from 85a9aaac4a38. On input pins,
> zl3073x_ref_freq_factorize(0) also succeeds, so 0 Hz was accepted there too.
> 
> Would it make sense to add this tag as well?
> 
> Fixes: a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin properties from system firmware")

Maybe, does it make sense to make another respin? Paulo,Jakub?
> Without it, stable trees that have a99a9f0ebdaa but not 85a9aaac4a38 might
> not pick this up.
> 
> The later patch in this series, "dpll: zl3073x: reject output frequencies
> with too small divisor", carries Fixes: a99a9f0ebdaa. It still divides by
> freq via div_u64_rem(), so it seems to depend on the !freq guard added here.
> 
>>   
>>   	if (dir == DPLL_PIN_DIRECTION_INPUT) {
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
> 
> [Severity: Medium]
> 
> This is a pre-existing issue and was not introduced by this patch. The new
> comment says a frequency that cannot be set is not offered, but only 0 Hz
> is filtered here. Should curr_freq also go through
> zl3073x_pin_check_freq(), as the firmware node entries do?
No. The current frequency is listed so that the pin always reports
a frequency from its supported list, even when the flash configuration
uses a value the driver itself would not set. Going back to such a
value can then be inexact or fail.

Thanks,
Ivan

