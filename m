Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55BF51991B
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571273; cv=none; b=NcO4slba9b5uXKyBAmfTMRv70yCKh/f+bgx6JyZjYyDhGOf12YOQ1Vx8KhxyLrO4SJn2339AXd+LZiHcmqjCB+/HN42/ptsMGRx/eHWK7H7fPP4hMZy81loplJ7ipjjhaWu+aSnQtuBpoARukYBBiKJQoQHC8NFRieUGQHr2aBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571273; c=relaxed/simple;
	bh=vTrWBmMvp8WFpyb24R12A1RrmYTlug5OeboLAhCxb4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SizgKa33QFDbLxR6pF1aA/h9g9kBJqnBExhRA0ChIP6AMjPnoNaHI7x/3AsHqFFJaGkl2lBSNXqOmOiO1p5keN4wnVsJltHg9ITP/DP0dGpQsFdWUgjljtZR6N8tWaVx4XCrYyedSREr+RrWsaGBv7IGTYXYGhI8vhXlm16F0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fK4t18XX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK4t18XX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791571267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJXBMwKHdGGK5q70e2crt+gZcUlv4iFqfxFi6Qooujk=;
	b=fK4t18XXrYjBnH1zR2+Lyb6W30tJoQ4QC4Ys7peWOI52jaZ4rw/pqaZDJY/3IIeeVOxRnL
	h/Hox3QQ7SorrrXwR0tCejve8V7Koci+QKhxjynypAQz0hGBgkYwtD4BKGIK7E8wv2PoIG
	oMefuugw63Jb7irmKvoX92D9bV0+0X8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-lkvAwPd0NEadJktmUFarOA-1; Fri,
 9 Oct 2026 18:41:04 +0000
X-MC-Unique: lkvAwPd0NEadJktmUFarOA-1
X-Mimecast-MFC-AGG-ID: lkvAwPd0NEadJktmUFarOA_1791571263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 786741944A8A;
	Fri,  9 Oct 2026 18:41:02 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1F7D1800586;
	Fri,  9 Oct 2026 18:40:59 +0000 (UTC)
Message-ID: <9745f505-3455-4167-b190-9c19e1e6a695@redhat.com>
Date: Fri, 9 Oct 2026 20:40:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/4] dpll: zl3073x: reject output frequencies with
 too small divisor
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261006153116.347497-2-ivecera@redhat.com>
 <179147350175.434549.6966003929996681994@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179147350175.434549.6966003929996681994@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/8/26 17:31, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] In N-div output mode, the new probe-time check in
>    zl3073x_pin_check_freq() (drivers/dpll/zl3073x/prop.c) only requires…
> 
> --
> 
> dpll: zl3073x: reject output frequencies with too small divisor
> 
> This patch tightens zl3073x_pin_check_freq() so output pin frequencies
> from firmware must divide the synth frequency with a divisor of at
> least 2. For the N-pin of an N-divided output the minimum is 4. It also
> rejects a zero frequency so the division cannot be by zero.
> 
>> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
>> index ac9d41d0f978e..a4bdc3878590f 100644
>> --- a/drivers/dpll/zl3073x/prop.c
>> +++ b/drivers/dpll/zl3073x/prop.c
> 
> [ ... ]
> 
>> @@ -41,18 +42,32 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
> 
> [ ... ]
> 
>>   		/* Check the frequency divides synth frequency */
>> -		if (synth_freq % (u32)freq)
>> +		div = div_u64_rem(synth_freq, freq, &rem);
>> +		if (rem)
>> +			goto err_inv_freq;
>> +
>> +		/* The output divisor has to be at least 2. For the N-pin of an
>> +		 * N-divided output the effective divisor also includes the N
>> +		 * divider (>= 2), so the minimum is 4.
>> +		 */
>> +		out = zl3073x_out_state_get(zldev, out_id);
>> +		if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
>> +			min_div = 4;
>> +		else
>> +			min_div = 2;
>> +		if (div < min_div)
>>   			goto err_inv_freq;
> 
> [Severity: Low]
> For N-divided outputs, the new check compares the effective divisor
> only against the synth. It does not look at the shared output divider
> (out->div). Does that let an N-pin frequency pass this filter even
> though no valid N divider exists for it?
> 
> In this patch, zl3073x_dpll_output_pin_frequency_set() in
> drivers/dpll/zl3073x/dpll.c computes the N divider with a truncating
> division and only rejects a result of 0:
> 
> drivers/dpll/zl3073x/dpll.c:zl3073x_dpll_output_pin_frequency_set() {
>      ...
> 	} else {
> 		...
> 		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
> 		if (!out.esync_n_period)
> 			return -EINVAL;
> 	}
>      ...
> }
> 
> Take a 1 GHz synth with P-pin divider 10:
> 
>    N-pin request of 100 MHz: div = 10 >= 4, so it passes here.
>    esync_n_period then works out to 1, and that is committed to
>    hardware.
> 
>    N-pin request of 40 MHz: div = 25 >= 4, so it also passes.
>    esync_n_period is truncated from 2.5 to 2. The output runs at
>    50 MHz, but the call reports success.
> 
> The P-pin branch has the same truncation and zero-only check:
> 
> 		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
> 		if (!out.esync_n_period)
> 			return -EINVAL;
> 
> The later commit in this series, "dpll: zl3073x: reject inexact
> frequencies for N-divided outputs", fixes this. It adds remainder
> checks and esync_n_period >= 2 checks to both branches, and returns
> -EINVAL with an extack message.
> 
> After that commit, one gap remains. Some frequencies have an effective
> divisor that cannot be split into out_div >= 2 times n_div >= 2, such
> as synth/5. They still appear in freq_supported, but setting them is
> rejected. Since this check is necessary but not sufficient, should the
> commit message or the comment say so?
> 

Yes, next version will say so in the commit message. The remaining cases are
rejected by the frequency set callback.

Thanks,
Ivan

