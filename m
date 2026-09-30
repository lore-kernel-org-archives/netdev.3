Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2545D92C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756932; cv=none; b=qXjAWDd1rMzOOHK7/EvpUOfm60xhyB7P1jZ9GOpDr0AAgFmWqFRAM3gfNYAnZpyyvZ/G9wfMgUE1hTxcsfSlMaoBlPnEJa6hQtKYe6vhxgC7o3uKzAc6BTQpWnLhGxQ7zl1vtmBJFk3Yp7j2lkbvTpS4lxELaOYyCdA/klNoBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756932; c=relaxed/simple;
	bh=9xlGIBlEd4FEddkp9VZEIFSUa3iN/rNVQcUTrMnUx80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKY8jVF01uULKJJbpCz/R36LCBGU7jarsnjAvK+wo2GP23Uebolqxf32mMXMOWzQD0QEwoLcOAQq2X2+np+1dWVLfKLRLuUlYJwVtu5Ol2sU3N9OZa/iMhSQywSmjdbUU8UgauVVKKPn5zF4nBqZ0lHh0k52NNCs3LMnRDWusUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW3I8fFh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW3I8fFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790756928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0Wj5TfmrFkoMQOOcM/66XQTRHLZfVyACEg8tosyf88=;
	b=RW3I8fFhBzNd83RqERZmNPEQw13AJgwFVF1qBLaHHii4U7SQ9jxvnyPcVfYAqHdWMeBqqu
	f6o27rUUwOaysRHScBweLY4vinpf0K3Jf6RLUIPO0oHhDPYmBB7zaDfPFH7iN73wMN5It0
	ieuadQi53lvsV0Ek41dsmM+rm7nX4vk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-O_NCQGvZMOS64mKpR1goBw-1; Wed,
 30 Sep 2026 04:28:44 -0400
X-MC-Unique: O_NCQGvZMOS64mKpR1goBw-1
X-Mimecast-MFC-AGG-ID: O_NCQGvZMOS64mKpR1goBw_1790756922
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD3781800666;
	Wed, 30 Sep 2026 08:28:41 +0000 (UTC)
Received: from [100.90.87.156] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6373B180057F;
	Wed, 30 Sep 2026 08:28:38 +0000 (UTC)
Message-ID: <6347acf5-4372-48dc-aa2e-47e7e94e1f33@redhat.com>
Date: Wed, 30 Sep 2026 10:28:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] dpll: zl3073x: add GPO support for output
 pins
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, kuba@kernel.org, jiri@resnulli.us,
 min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org
References: <20260928185552.1103515-3-ivecera@redhat.com>
 <179075143241.434549.4937444709313263420@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179075143241.434549.4937444709313263420@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 9/30/26 8:57 AM, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] Error-recovery path applies the output restart before the
>    pending GPO change.
> - [Low] The struct zl3073x_dev kernel-doc in drivers/dpll/zl3073x/core.h
>    (line 65, '@out: array of outs' invariants') and the inline '/*…
> 
> --
> 
> dpll: zl3073x: add GPO support for output pins
> 
> This commit adds the GPO override mailbox fields and the direct gpo_out_x
> registers for CMOS output pins, along with helpers to read and set the pin
> function. It also adds the output_ctrl_x stop bits and stop/start helpers.
> ctrl moves into the cfg struct_group, and zl3073x_out_state_set() now
> writes it directly.
> 
>> diff --git a/drivers/dpll/zl3073x/out.c b/drivers/dpll/zl3073x/out.c
>> index 410d15b96d0b..82564045890d 100644
>> --- a/drivers/dpll/zl3073x/out.c
>> +++ b/drivers/dpll/zl3073x/out.c
> 
> [ ... ]
> 
>> @@ -120,11 +135,17 @@ int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
>>   	struct zl3073x_out *dout = &zldev->out[index];
>>   	int rc;
>>   
>> -	/* Reject attempts to change invariant fields (set at fetch only) */
>> -	if (WARN_ON(memcmp(&dout->inv, &out->inv, sizeof(out->inv))))
>> -		return -EINVAL;
>> +	/* ctrl is a direct register, independent of the output mailbox */
>> +	if (dout->ctrl != out->ctrl) {
>> +		rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_CTRL(index),
>> +				      out->ctrl);
>> +		if (rc)
>> +			return rc;
>> +
>> +		dout->ctrl = out->ctrl;
>> +	}
> 
> [Severity: Medium]
> 
> zl3073x_out_state_set() now always writes output_ctrl_x before any mailbox
> field. It does not roll dout->ctrl back if the later zl3073x_mb_op() or a
> mailbox field write fails.
> 
> Can this order apply a restart before a pending GPO change on an error
> recovery path?
> 
> The follow-up patch "dpll: zl3073x: allow enabling/disabling output pins"
> adds zl3073x_dev_output_pin_state_set(). It puts a stop before the GPO
> change and a start after it. Its recovery path looks like this:
> 
> 	rc = zl3073x_out_state_set(zldev, out_id, &out);
> 
> restart_output:
> 	zl3073x_out_start(&out);
> 	rc = zl3073x_out_state_set(zldev, out_id, &out) ? : rc;
> 
> The second zl3073x_out_state_set() call only changes gpo_en/gpo_config.
> Suppose it fails in zl3073x_mb_op() or in one of the mailbox field writes.
> Then dout->cfg keeps the old GPO values, while out still holds the new
> ones.
> 
> The recovery call then carries two changes: the cleared STOP/STOP_HZ bits
> and the uncommitted GPO change. Because ctrl is written first, would the
> clock restart, with the GPO override then changed on a running output?
> 
> That looks like the toggle the stop/start pair is meant to avoid. The
> driver's own comment says the GPO toggle is not glitch-free. For
> enable=true, the override is released onto a clock that is already
> running, at an arbitrary phase. For enable=false, the override is engaged
> in the middle of a clock cycle.
> 
> Also, if the retried commit succeeds, the "? : rc" still returns the
> earlier error. zl3073x_dpll_output_pin_state_on_dpll_set() would then
> report a failure even though the pin state changed.

Good catch. I will reorder zl3073x_out_state_set() to commit the mailbox
fields first and write the direct output_ctrl_x register last.

That fixes the recovery path in zl3073x_dev_output_pin_state_set():

   - stop phase: only ctrl changes (STOP/STOP_HZ), there is no cfg diff, so
     the mailbox commit is skipped and only ctrl is written - unchanged.
   - restart phase: state_set() will write the GPO change through the
     mailbox *while the output is still stopped* (ctrl not written yet),
     and only then clears STOP via ctrl - a clean restart, no glitch on a
     running output.
   - on a mailbox failure ctrl is left untouched, so there is no premature
     restart and dout->ctrl stays consistent with the hardware.

The other callers (frequency_set / esync_set / phase_adjust_set) only
change cfg fields with ctrl unchanged, so the ordering does not affect
them.

> 
>>   
>> -	/* Skip HW write if configuration hasn't changed */
>> +	/* Skip the mailbox commit if nothing else has changed */
>>   	if (!memcmp(&dout->cfg, &out->cfg, sizeof(out->cfg)))
>>   		return 0;
> 
> [ ... ]
> 
>> diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
>> index 660889c57bff..66a8432c00df 100644
>> --- a/drivers/dpll/zl3073x/out.h
>> +++ b/drivers/dpll/zl3073x/out.h
> 
> [ ... ]
> 
>> @@ -29,8 +32,9 @@ struct zl3073x_out {
>>   		u32	esync_n_width;
>>   		s32	phase_comp;
>>   		u8	mode;
>> -	);
>> -	struct_group(inv, /* Invariants */
>> +		u8	gpo_en;
>> +		u8	gpo_config_p;
>> +		u8	gpo_config_n;
>>   		u8	ctrl;
>>   	);
>>   };
> 
> [Severity: Low]
> 
> This isn't a bug, but with the inv group removed, struct zl3073x_out has
> no invariant fields left. The struct zl3073x_dev comments in core.h still
> describe out[] as invariants:
> 
>   * @out: array of outs' invariants
> ...
> 	/* Invariants */
> 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
> 	struct zl3073x_out	out[ZL3073X_NUM_OUTS];
> 
> These comments are still unchanged at the end of the series. Should they
> be updated along with this change?

Yes, I will fix them in v2.

Thanks,
Ivan

pw-bot: cr

