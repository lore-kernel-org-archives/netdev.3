Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA051A723
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778312; cv=none; b=k/pa2gWU1n8g3WHNx2U15JXdtCkQZAjoUJ9xX4bf2IvP0n7CuCsidQuc+GgmUUPUKJi67SARepKyt7LgvuUCsyaRX48pa+IugaTQs2uxN0hQ+D3J3AFkTEJuYnu5W98QCCeqUq+BKIEHNt+X4KO6a/KuPTlE5Qo5DDcUmrSQvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778312; c=relaxed/simple;
	bh=6XX/mbi7gy8/2ofVApvgqfPc7bRQKgya0ZaSKKV+QfI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JHHE36SzY4uGg7FlILHVuJebP29vmgwdD6bdrO/JK2iOcy9UPfS/IJ0jrggO4dvn2BriNx+o1gHugmUvNg8KTAL7JU/Octhnx1ywqwNXnAXRgwM2YyeRx1OyhObiMlSaJUC5wVLlXlabMj6r38rMhY/t2U0N1ZKyfbjLfTVRokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJcOLbL/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJcOLbL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790778291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrMOOS/D9EUBGZMO6OeW7Lw5PFy3M+31Pwt16QAA64Y=;
	b=aJcOLbL/Fx/Xxef4X1tmUUZB42Win4jML7k+phrM2OiDfsg0q+X/xTVHX9MVqu8Vj1xnha
	Dg6x7SlqZGffqznK7XTmDEac1z+j1ldxOcWuWE6uMhOEVuO7fZJRVdNege9Kg4qOckJdCr
	sS+REOgURFQJTxd95bw8UX2ngqjKqzo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-zugMvPWqPcqTA-G4QDcUeA-1; Wed,
 30 Sep 2026 10:24:47 -0400
X-MC-Unique: zugMvPWqPcqTA-G4QDcUeA-1
X-Mimecast-MFC-AGG-ID: zugMvPWqPcqTA-G4QDcUeA_1790778285
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF85C195399C;
	Wed, 30 Sep 2026 14:24:44 +0000 (UTC)
Received: from [100.90.87.156] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B674030000E7;
	Wed, 30 Sep 2026 14:24:41 +0000 (UTC)
Message-ID: <cd768cab-78b7-4269-9e86-2bd49d261e1c@redhat.com>
Date: Wed, 30 Sep 2026 16:24:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] dpll: zl3073x: notify sibling pin when
 shared output config changes
From: Ivan Vecera <ivecera@redhat.com>
To: netdev-bot+sashiko@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, min.li@microchip.com,
 pabeni@redhat.com, poros@redhat.com, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
References: <20260928185552.1103515-2-ivecera@redhat.com>
 <179075143120.434549.1576015918203645155@kernel.org>
 <d631d2ed-63b5-4785-80ae-b16deb3edd1a@redhat.com>
Content-Language: en-US
In-Reply-To: <d631d2ed-63b5-4785-80ae-b16deb3edd1a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 9/30/26 9:49 AM, Ivan Vecera wrote:
>> [Severity: High]
>> Can sibling->dpll_pin be NULL, or the sibling already freed, by the time
>> it is dereferenced here?
>>
>> zl3073x_dpll_output_pin_sibling_get() returns any output pin on
>> zldpll->pins with the matching id. It does not check that
>> sibling->dpll_pin is still set. The lookup runs under zldpll->lock, but
>> the dereference happens after mutex_unlock().
>>
>> The teardown path does not take zldpll->lock:
>>
>> drivers/dpll/zl3073x/dpll.c:zl3073x_dpll_pins_unregister() {
>>     list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
>>         zl3073x_dpll_pin_unregister(pin);
>>         list_del(&pin->list);
>>         zl3073x_dpll_pin_free(pin);
>>     }
>> }
>>
>> zl3073x_dpll_pin_unregister() ends with:
>>
>>     dpll_pin_put(pin->dpll_pin, &pin->tracker);
>>     pin->dpll_pin = NULL;
>>
>> and dpll_pin_put() has already dropped dpll_lock at that point.
>>
>> zl3073x_dpll_pins_register() uses list_add(), so the N pin (2k+1) sits
>> before its P pin (2k) on the list. That means N is torn down while P is
>> still registered and reachable over netlink.
>>
>> One possible interleaving:
>>
>> CPU1 (devlink reload, flash_prepare or unbind)
>> zl3073x_dev_stop()
>>    zl3073x_dpll_unregister()
>>      zl3073x_dpll_pins_unregister()
>>        dpll_pin_put(N)          /* dpll_lock released */
>>
>> CPU0 (DPLL_CMD_PIN_SET on P, dpll_lock held)
>> dpll_pin_freq_set()
>>    zl3073x_dpll_output_pin_frequency_set(P)
>>      mutex_lock(&zldpll->lock)
>>      sibling = zl3073x_dpll_output_pin_sibling_get(P)  /* finds N */
>>      mutex_unlock(&zldpll->lock)
>>
>> CPU1
>>        N->dpll_pin = NULL
>>        list_del(&N->list)
>>        zl3073x_dpll_pin_free(N)
>>
>> CPU0
>>      __dpll_pin_change_ntf(sibling->dpll_pin)
>>
>> In that case, would __dpll_pin_change_ntf() get NULL and oops on
>> pin->id and pin->clock_id in dpll_pin_notify()? Or would CPU0 read the
>> freed zl3073x_dpll_pin?
>>
>> The list walk in zl3073x_dpll_output_pin_sibling_get() can also run
>> while list_del() is in progress, because the writer never takes
>> zldpll->lock.
>>
>> zl3073x_dpll_output_pin_frequency_set() and
>> zl3073x_dpll_output_pin_phase_adjust_set() have the same pattern.
>>
>> The later patch "dpll: zl3073x: add PTP periodic output support" also
>> calls zl3073x_dpll_output_pin_sibling_get() from
>> zl3073x_dpll_ptp_enable() without holding zldpll->lock at all.
> 
> This cannot happen; the notification is already serialized against pin
> teardown.
> 
> The output setters (esync_set / frequency_set / phase_adjust_set) run
> with dpll_lock held: the dpll core invokes the pin ops under dpll_lock,
> and they use __dpll_pin_change_ntf(), whose contract is exactly "caller
> must hold dpll_lock" (dpll_netlink.c: lockdep_assert_held(&dpll_lock),
> "suitable for use inside pin callbacks which are already invoked under
> dpll_lock"). So sibling_get() and the __dpll_pin_change_ntf() call - even
> though it runs after mutex_unlock(&zldpll->lock) - are all covered by
> dpll_lock.
> 
> Pin teardown frees the sibling via zl3073x_dpll_pin_unregister() ->
> dpll_pin_unregister(), which takes dpll_lock. While a setter holds
> dpll_lock for the whole callback, teardown cannot even reach
> dpll_pin_unregister(N), let alone the following list_del()/kfree(). The
> proposed interleaving (CPU1 freeing N while CPU0 notifies) is therefore
> impossible: CPU0 holds dpll_lock throughout.
> 
> The PTP enable() path (zl3073x_dpll_ptp_enable(), added in patch 6) does
> call sibling_get() outside dpll_lock, but it is serialized differently:
> zl3073x_dpll_unregister() unregisters the PTP clock *before* the pins
> (zl3073x_dpll_ptp_unregister() then zl3073x_dpll_pins_unregister()), and
> ptp_clock_unregister() quiesces in-flight enable() callbacks. No
> enable() can run while the pins are being freed.
> 

More thinking about it... and yes this can happen :-(
The pin removal from the list must be performed prior its unregistration
and also the list management has to be protected by zldpll->lock.

Will fix and send as bugfix to net branch with proper Fixes: tags.

Thanks,
Ivan

