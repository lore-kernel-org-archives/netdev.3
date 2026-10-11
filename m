Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EA1D9A66
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698914; cv=none; b=AC0iBjGQFkBA3WGgHF8DPnrtH2LdGqZOEDASMF2DmNzihzyYKZEqPLnFN7DR70W1xJA79n3xMBnnQ3p4I66sjUll46QnxpDkmO1gRuRl9G512HDApzmGr9ZD8eU26hX77jOr+PyApS+zH8kcumbLZWtS7j8p22ReUlFc8JoX4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698914; c=relaxed/simple;
	bh=L83EC1yVpH8jPT98rYtWh0VLRV6lhwCzyCmbaCjzW9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPp28F3KF7qPjKWK2IA/wT1xdvSlj5iAe7IEv3rq+MjPlejlAKWe4g24SClXNiB9eHg7+i4t877Y3mpANsiTXxTY8oF5epXtlMq6f0jRXTEBQxIqTvjFjja1i2kV/1FbhSUH8KPC9MGMF/HhRjC8a+Yy+MT0zx0fS/oQr3J+5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASdBfMv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASdBfMv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791698911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wo1efaTMpeT/4NBcKrfwC/YnsyXmNc2l9OW89Ez3udA=;
	b=ASdBfMv5bQgluO3ZWfLUH86xrfEgfHwbthcl6uCITgJ9EQ19PY9E01DI695i4Kj5n5bAtI
	FOsl4BSL/MzKMhZ90oa2pn7SzMN8egYtbhttgGgTRyH0tV5ff++oRGFxjqGxLToRbWb774
	5oRxDqQ2/eVNvn1VJqp2YY3RbwYEnv4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-4oJXwfekOxKwRo7fDzlc_A-1; Sun,
 11 Oct 2026 06:08:28 +0000
X-MC-Unique: 4oJXwfekOxKwRo7fDzlc_A-1
X-Mimecast-MFC-AGG-ID: 4oJXwfekOxKwRo7fDzlc_A_1791698906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21040194510D;
	Sun, 11 Oct 2026 06:08:26 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60A5830000E3;
	Sun, 11 Oct 2026 06:08:23 +0000 (UTC)
Message-ID: <d4e4faab-002b-47c7-b437-0d8f92f8dbf3@redhat.com>
Date: Sun, 11 Oct 2026 08:08:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 5/5] dpll: zl3073x: notify sibling pin when shared
 output config changes
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20261009192556.272263-6-ivecera@redhat.com>
 <179166042422.434549.15231909137129079099@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179166042422.434549.15231909137129079099@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 10/10/26 21:27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Pins that are on the list but not registered get passed to
>    __dpll_pin_change_ntf(), and the new NCO comment is wrong.
> 
> --
> 
> dpll: zl3073x: notify sibling pin when shared output config changes
> 
> This patch adds zl3073x_dpll_output_pin_sibling_get(). It sends a change
> notification for the sibling P/N pin from frequency_set(), esync_set() and
> phase_adjust_set() after zldpll->lock is dropped. Pins are now added to
> zldpll->pins before dpll_pin_register() and removed after
> dpll_pin_unregister(), so a registered sibling can always be found.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index 6d9a6d21d30b7..1d61fe5fe5862 100644
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
>> + *
>> + * Return: pointer to sibling pin, or NULL if it is not on the pin list
>> + */
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
> 
> The kernel-doc for __dpll_pin_change_ntf() in drivers/dpll/dpll_netlink.c
> says its argument is "@pin: registered pin pointer". The kernel-doc for
> zl3073x_dpll_output_pin_sibling_get() above says the returned pin "may
> also be one that is not (yet or any longer) registered".
> 
> Should the sibling's registration state be checked before it is passed to
> __dpll_pin_change_ntf() here? The same question applies to the matching
> calls in zl3073x_dpll_output_pin_frequency_set() and
> zl3073x_dpll_output_pin_phase_adjust_set().
> 
> __dpll_pin_change_ntf() runs the notifier chain before the
> dpll_pin_available() check in dpll_pin_event_send():
> 
> int __dpll_pin_change_ntf(struct dpll_pin *pin)
> {
> 	lockdep_assert_held(&dpll_lock);
> 	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
> 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
> }
> 
> This means a notifier subscriber can get DPLL_PIN_CHANGED for a pin
> before it got DPLL_PIN_CREATED, or after it got DPLL_PIN_DELETED.
> 
> It looks like this can happen during probe:
> 
> - zl3073x_dpll_device_register() runs before zl3073x_dpll_pins_register().
> - The P pin (even id) is registered before its N sibling.
> - A userspace PIN_SET on the registered P pin holds dpll_lock.
> - That PIN_SET can find N on the list after list_add(), while
>    dpll_pin_register(N) is still waiting for dpll_lock.
> 
> list_add() now runs before dpll_pin_register() for every pin type. So the
> existing callers of zl3073x_dpll_nco_pin_get() and
> zl3073x_dpll_pin_get_by_ref() can also get a pin that is not registered
> yet and pass it to __dpll_pin_change_ntf(). Before this patch, that could
> only happen during teardown, between dpll_pin_unregister() and list_del().
> 
> As the commit message says, no netlink message is sent for such pins, and
> ice_dpll_pin_notify() ignores DPLL_PIN_CHANGED. So nothing visibly breaks
> today.
> 
> Would a per-pin registered flag be cleaner? It could be set and cleared
> under zldpll->lock around dpll_pin_register() and dpll_pin_unregister(),
> and checked before notifying. Another option is to relax the core
> kernel-doc and have dpll_pin_notify() check registration.

Such a pin gets no netlink notification and the only in-tree notifier
ignores DPLL_PIN_CHANGED, so I would rather not add a registered flag
in a net fix.

> Separately, the new comment in zl3073x_dpll_nco_pin_register() says:
> 
> 	/* Add the pin to the list before registering it with the DPLL core so
> 	 * that the list reflects the DPLL registration state.
> 	 */
> 
> Is this accurate? With the early list_add(), the list holds every
> registered pin and also pins that are not registered yet.

Right, will fix the comment in v5.

Thanks,
Ivan

