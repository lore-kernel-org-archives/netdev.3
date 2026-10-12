Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73372446821
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791965; cv=none; b=NEc8Wmq8HDQaOMXvdpiD9wUkMal/jVqhIYnDz8+jq/K/ajxErIFGCnm5fKkPLb7jRhl527KKm+PEMJB6PBYpapz/+1IGjTL5q3gMc0di3gUeW9ZuqYzgBEvMaSdoPy+g8LD/7Z2XOC6lFO3kwK2FcfVhB4AaWqotGltjIk6WDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791965; c=relaxed/simple;
	bh=VuKQATNNb00pBd3oa3jDiiDozIDu5Uj4xu0uZs2agts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+/p146h2N0S7oAGQeK5Y6a5KTfkNSvppZ32IoBhKAL7tKq1oMwv9JnDeHqNC2Y1O/EsTX01HVC2R300d7cz/NTSTU8r5T92LKPqqqbuf76q8bZSx8kverS4rgi074eoAm6ddniNXPPpjRENc2nhsXZtRaFdItzYJIY068jWBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsZ0VHz+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsZ0VHz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791791956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7hLxKxMSyjuSYhbWKOFrrXPm1Js4YCY+YTSmqlFxD8=;
	b=fsZ0VHz+au8/WLxKGl/xIT5LNaIx//EoCf1KnvIrUS5KJS1Y4YunAb0HnBWLF9sVHTaqg/
	7AIDRAhcA7Kbt9ZstG7O9FH0mMKjfY+X3RRdFt02XAlVSc1rxHKnuKlIyRnx4dIc44yBVf
	Fwaz/oQXje497a82YThav2iTXgLWy+0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-XhKpsvMrM5-1YsFJltON3Q-1; Mon,
 12 Oct 2026 07:59:14 +0000
X-MC-Unique: XhKpsvMrM5-1YsFJltON3Q-1
X-Mimecast-MFC-AGG-ID: XhKpsvMrM5-1YsFJltON3Q_1791791953
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABBAE1955DC2;
	Mon, 12 Oct 2026 07:59:12 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B506F418;
	Mon, 12 Oct 2026 07:59:09 +0000 (UTC)
Message-ID: <efb108c8-dc9e-4c14-a834-2cd6af6c44f6@redhat.com>
Date: Mon, 12 Oct 2026 09:59:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 5/5] dpll: zl3073x: notify sibling pin when shared
 output config changes
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261011061211.448373-6-ivecera@redhat.com>
 <179178562457.434549.16379323333856475098@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179178562457.434549.16379323333856475098@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/12/26 08:13, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The patch passes pins that may not be registered to
>    __dpll_pin_change_ntf(), whose kernel-doc requires a "registered pin…
> 
> --
> 
> dpll: zl3073x: notify sibling pin when shared output config changes
> 
> This commit adds zl3073x_dpll_output_pin_sibling_get(). The output
> frequency, esync and phase adjust set callbacks now use it to send a
> change notification for the other pin of the P/N pair. So that the
> sibling can always be found, pins are added to zldpll->pins before
> dpll_pin_register() and removed only after dpll_pin_unregister().
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index 6d9a6d21d30b7..1cdadb8e46fb2 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
> 
> [ ... ]
> 
>> @@ -132,11 +134,42 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
>>   	return NULL;
>>   }
>>   
>> +/**
>> + * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
>> + * @pin: output pin whose sibling is sought
>> + *
>> + * Output pin ids are allocated in P/N pairs (P even, N odd) that share a
>> + * single HW output. Looks up the other pin of the pair in the pin list
>> + * of this DPLL. A pin is on the list from just before its registration
>> + * until just after its unregistration, so a registered sibling is always
>> + * found, but the returned pin may also be one that is not (yet or any
>> + * longer) registered.
> 
> [ ... ]
> 
>> @@ -937,9 +974,24 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>>   
>>   	/* Enable 1PPS eSync for this pin frequency */
>>   	zl3073x_out_esync_enable(&out, synth_freq / out.div);
>> -
>> +commit:
>>   	/* Commit output configuration */
>> -	return zl3073x_out_state_set(zldev, out_id, &out);
>> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
>> +	if (rc)
>> +		goto unlock;
>> +
>> +	/* The clock type, esync period and esync width are all shared by
>> +	 * both pins of the output pair, so the sibling pin's esync
>> +	 * configuration changes too and userspace has to be notified.
>> +	 */
>> +	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
>> +unlock:
>> +	mutex_unlock(&zldpll->lock);
>> +
>> +	if (!rc && sibling)
>> +		__dpll_pin_change_ntf(sibling->dpll_pin);
> 
> [Severity: Low]
> Is it ok to pass a sibling that may not be registered to
> __dpll_pin_change_ntf()? The kernel-doc for that function asks for a
> registered pin:
> 
> drivers/dpll/dpll_netlink.c:
> /**
>   * __dpll_pin_change_ntf - notify that the pin has been changed
>   * @pin: registered pin pointer
>   ...
> int __dpll_pin_change_ntf(struct dpll_pin *pin)
> {
> 	lockdep_assert_held(&dpll_lock);
> 	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
> 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
> }
> 
> dpll_pin_event_send() checks dpll_pin_available(), so no netlink message
> is sent. But dpll_pin_notify() runs before that check, so the in-kernel
> notifier chain still gets DPLL_PIN_CHANGED for the unregistered pin.
> 
> This window looks reachable during probe. zl3073x_dpll_register()
> registers the dpll device before its pins, and pins are registered in
> index order. That means P is already registered when N is list_add()ed
> in zl3073x_dpll_pin_register():
> 
>      mutex_lock(&zldpll->lock);
>      list_add(&pin->list, &zldpll->pins);
>      mutex_unlock(&zldpll->lock);
> 
>      /* Register the pin */
>      rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
> 
> Suppose a DPLL_CMD_PIN_SET on P holds dpll_lock from dpll_pin_pre_doit().
> N's dpll_pin_register() then waits on dpll_lock. Meanwhile P's callback
> finds N on the list and sends DPLL_PIN_CHANGED for N before N's
> DPLL_PIN_CREATED.
> 
> Teardown is the mirror case. list_add() inserts at the head, so N is
> unregistered before P. N also stays on the list until after
> dpll_pin_unregister() returns in zl3073x_dpll_pin_unregister(). A
> PIN_SET on P during that window would send CHANGED for N after its
> DPLL_PIN_DELETED.
> 
> zl3073x_dpll_output_pin_frequency_set() and
> zl3073x_dpll_output_pin_phase_adjust_set() have the same issue.
> 
> zl3073x_dpll_nco_pin_register() now also adds the NCO pin to the list
> before dpll_pin_register(). Because of that, the existing callers that
> notify the result of zl3073x_dpll_nco_pin_get() (the input pin
> state_on_dpll_set and mode_set paths) hit the same window.
> 
> As the commit message notes, nothing breaks in-tree today, because
> ice_dpll_pin_notify() ignores every action except DPLL_PIN_CREATED and
> DPLL_PIN_DELETED.
> 
> Would it be better to skip the notification when the sibling is not
> registered? Alternatively, the __dpll_pin_change_ntf() kernel-doc and
> dpll_pin_notify() could be updated to accept unregistered pins
> explicitly.
Such a pin gets no netlink notification and the only in-tree notifier
ignores DPLL_PIN_CHANGED, so I would rather not add a registration
check in a net fix.

Thanks,
Ivan

