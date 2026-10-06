Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42F46EC79
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299782; cv=none; b=jbzHHj+QvVCokxdY1GNagFoYabxyTzEu4vSi03mdq4m21xr9JjnYJFLMLHEcZ1P32eVepGMxQi2/xIH+9J7b37i5X7kdv7AVNe+EqButRi8IZSyiYxN864HxToG71WZByF/nORRP2P6GiuEdxUDQcuPtaoaDoVvAkIWNGAswLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299782; c=relaxed/simple;
	bh=AIAk9dR2qeH9nC0eiOFeAQQ8fKCgksr5ekr1SKtasZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oi7UlFhrGKAAPwIfzkTgk+myWJe5gcejdrTaj5OVWkB0Ks6WUoaeK/fvvOx6PVZHZVjoIpiUL+imYnuEmHDJmzobZhN6JILFWnXOe/ENoBdVivcwA7dokk/nSIjcvyfIPRwOQu4se8kXD4jr4GSDjaKs12H2nKHwz6MLjCbP8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHGXub1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHGXub1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791299779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzTOMvDj+JJjzO03quDmcKt3wcRTX17eYSh2It/X1yY=;
	b=bHGXub1kfQdVYTGHwtTl6t8k0ofykzEZ+QCANRRisreJiwkNZ5Lglaxcc4zu7XE1VqWj0i
	Q/+hrlI+he2XLtosTHD7r29hlMAxqrS96tdL/q3JNoAt5lAuyV6I1zQaIi7HF0Zcro3ewK
	L7vxkQMfsc55c/SV/3vtqr8YaIXqgos=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-8wnv1dQAO0eIpyGRN3o1FA-1; Tue,
 06 Oct 2026 11:16:18 -0400
X-MC-Unique: 8wnv1dQAO0eIpyGRN3o1FA-1
X-Mimecast-MFC-AGG-ID: 8wnv1dQAO0eIpyGRN3o1FA_1791299776
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94D711865FFD;
	Tue,  6 Oct 2026 15:16:16 +0000 (UTC)
Received: from [100.91.101.41] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FDB31800579;
	Tue,  6 Oct 2026 15:16:13 +0000 (UTC)
Message-ID: <c0dd5313-360b-47a8-88ac-497409dfbc1b@redhat.com>
Date: Tue, 6 Oct 2026 17:16:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] dpll: zl3073x: notify sibling pin when shared
 output config changes
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261002074520.30048-3-ivecera@redhat.com>
 <179127408644.434549.11543498613900347079@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179127408644.434549.11543498613900347079@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/6/26 10:08, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] In zl3073x_dpll_output_pin_frequency_set()
>    (drivers/dpll/zl3073x/dpll.c), the N-div case is excluded from the new…
> - [Medium] Pins are on zldpll->pins only for part of the time they are
>    registered with the DPLL core, so the new sibling lookup can miss a…
> 
> --
> 
> dpll: zl3073x: notify sibling pin when shared output config changes
> 
> This commit adds zl3073x_dpll_output_pin_sibling_get(). The output pin
> frequency, esync and phase adjust setters use it to send a change
> notification for the other pin of a P/N output pair. The setters move from
> guard(mutex) to explicit lock/unlock so the notification is sent after
> zldpll->lock is dropped, and all accesses to zldpll->pins are now
> serialized with zldpll->lock.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index 19456fbeeea84..b60d3280574ad 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
> 
> [ ... ]
> 
>> @@ -1001,7 +1053,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>>   		}
>>   
>>   		/* Commit output configuration */
>> -		return zl3073x_out_state_set(zldev, out_id, &out);
>> +		rc = zl3073x_out_state_set(zldev, out_id, &out);
>> +		if (rc)
>> +			goto unlock;
>> +
>> +		/* The other pin's frequency changed too - it has to be
>> +		 * notified about the change.
>> +		 */
>> +		sibling = zl3073x_dpll_output_pin_sibling_get(pin);
>> +
>> +		goto unlock;
>>   	}
>>   
>>   	if (zl3073x_dpll_is_p_pin(pin)) {
>> @@ -1013,8 +1074,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>>   		 * Update divisor for N-pin to keep N-pin frequency.
>>   		 */
>>   		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
>> -		if (!out.esync_n_period)
>> -			return -EINVAL;
>> +		if (!out.esync_n_period) {
>> +			rc = -EINVAL;
>> +			goto unlock;
>> +		}
>>   
>>   		/* Update the output divisor */
>>   		out.div = new_div;
> 
> [Severity: High]
> Can the N-pin's frequency still change on this path without a
> notification?
> 
> In N-div mode, zl3073x_dev_output_pin_freq_get() computes the N-pin
> frequency from both the shared divisor and esync_n_period:
> 
> 	freq = zl3073x_synth_freq_get(synth) / out->div;
> 
> 	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
> 		freq /= out->esync_n_period;
> 
> When the P-pin frequency is set, the esync_n_period rescale above
> truncates whenever old_period * old_div is not a multiple of new_div.
> 
> For example, take a 1 GHz synth with div = 10 (P = 100 MHz) and period = 4
> (N = 25 MHz). Setting P to 40 MHz gives new_div = 25 and period = 40 / 25 =
> 1, so N becomes 40 MHz. Both frequencies pass zl3073x_pin_check_freq()
> because they divide the synth frequency.
> 
> zl3073x_out_state_set() then commits the new DIV and ESYNC_PERIOD values.
> However, sibling is only assigned in the non-N-div branch, so it is still
> NULL at the tail of the function:
> 
> 	if (!rc && sibling)
> 		__dpll_pin_change_ntf(sibling->dpll_pin);
> 
> No notification is sent for the N-pin, even though it is registered in
> N-div mode.
> 
> The truncation itself predates this patch. The missing notification,
> though, is the case this patch sets out to fix. The commit message says:
> 
>      share a single HW output and, outside N-pin divide mode, share the
>      output's divisor, ...
> 
> and:
> 
>      ... to notify the sibling pin, if it is registered, whenever the
>      shared HW state actually changes.
> 
> Is that accurate, given that the divisor is also part of the N-pin
> frequency in N-div mode?
> 
> Should this branch either notify the N-pin when its effective frequency
> changes, or reject a rescale that is not exact?

I will take the second option and reject a rescale that is not exact. For
the next version I plan to add a preparatory patch ("dpll: zl3073x:
reject inexact frequencies for N-divided outputs"), ordered before this
notification patch, that changes the P-pin branch to

     prod = esync_n_period * div;
     esync_n_period = div_u64_rem(prod, new_div, &rem);
     if (rem)                   -> reject (-EINVAL)
     if (esync_n_period < 2)    -> reject (-EINVAL)

so the request is refused whenever the rescale is not exact. When the
P-pin set succeeds, the N-pin frequency is

     synth / (new_div * new_period)
       = synth / (new_div * (old_period * old_div / new_div))
       = synth / (old_div * old_period)

i.e. exactly the old N-pin frequency. So on this path the N-pin's
effective frequency never changes and no notification is required. With
that patch in front, the claim in this commit message ("to notify the
sibling pin ... whenever the shared HW state actually changes") holds,
and I will adjust the wording to make the N-div case explicit.

> [ ... ]
> 
>> @@ -1954,7 +2049,9 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>>   			goto error;
>>   		}
>>   
>> +		mutex_lock(&zldpll->lock);
>>   		list_add(&pin->list, &zldpll->pins);
>> +		mutex_unlock(&zldpll->lock);
>>   	}
> 
> [Severity: Medium]
> Can zl3073x_dpll_output_pin_sibling_get() miss a sibling that is already
> registered with the DPLL core?
> 
> zl3073x_dpll_pin_register()->dpll_pin_register() publishes the pin. It
> takes and drops dpll_lock and sends PIN_CREATE before the pin is added to
> zldpll->pins here. P (even id) is registered before N (odd id), so this
> window exists:
> 
> CPU1 (probe)
> zl3073x_dpll_pins_register()
>    zl3073x_dpll_pin_register(N)
>      dpll_pin_register()
>        N is now visible, PIN_CREATE sent
> 
> CPU2 (netlink PIN_SET on P, dpll_lock held)
> zl3073x_dpll_output_pin_phase_adjust_set()
>    zl3073x_out_state_set()
>    zl3073x_dpll_output_pin_sibling_get()
>      N is not on zldpll->pins yet, returns NULL
> 
> CPU1
>    list_add(&pin->list, &zldpll->pins);
> 
> At that point userspace still has the CREATE values for N, but the shared
> div, esync or phase_comp has already changed, and no change notification
> is sent for N.
> 
> Teardown has the opposite window. zl3073x_dpll_pins_unregister() empties
> the list before any dpll_pin_unregister() call:
> 
> 	mutex_lock(&zldpll->lock);
> 	list_splice_init(&zldpll->pins, &pin_list);
> 	mutex_unlock(&zldpll->lock);
> 
> A PIN_SET on a P-pin that is still registered therefore also skips an
> N-pin that is still registered. A DELETE notification follows in that
> case.
> 
> This cannot cause a use-after-free. The sibling is freed only after
> dpll_pin_unregister(), which needs dpll_lock, and the PIN_SET path holds
> dpll_lock.
> 
> However, list membership does not match DPLL registration state, so the
> notification this patch adds can still be lost. Should the lookup be tied
> to registration state instead of list membership?

You are right, and I will tie the list membership to the registration
state. For the next version I plan to:

   - add the pin to zldpll->pins *before* dpll_pin_register() (removing it
     again on a registration failure), and
   - remove it from zldpll->pins only *after* dpll_pin_unregister(),
     instead of splicing the whole list away before unregistering any pin,

both under zldpll->lock. That closes both windows you described: a pin
that is registered - and thus reachable by a PIN_SET on its sibling - is
always present on the list, so the lookup will find it.

The opposite transient state (a pin on the list that is not yet, or no
longer, registered) is harmless:

   - __dpll_pin_change_ntf() is a no-op for such a pin, because
     dpll_pin_event_send() bails out on !dpll_pin_available(), and
   - there is no use-after-free, as you also noted: the sibling is freed
     only after dpll_pin_unregister(), which takes dpll_lock, and the
     PIN_SET path holds dpll_lock across the lookup and the notification.

Thanks,
Ivan

