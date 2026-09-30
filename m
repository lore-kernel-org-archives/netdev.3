Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB14483BE
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754580; cv=none; b=gE8lq2tBPyM1yMklJ5jsq3TBk2V/+pc/jGFnJGcKPSAqLkA0Hztj+fwR+yTqiylFES9heLdqO8VamJP6IO1g+Av8t3tyrcBtNE9THDZcVD09cJvF9ouRvxMPSDYaNwzkSM6iVk67KIAGLHCsDK8rIzdNO8vMpCTbuj3vuHM+rwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754580; c=relaxed/simple;
	bh=GM0fMTtibvMYSkQZnSNnnDOl3C8/olyP8Aap3fUgpqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAWTi6tYBzqU2Ae+LRGbNBsh4EIVeyubz+V4A9RkQkhto5Y2pK6+k+Z2bmz35uvFxOql20VZpo49ng9E1WOz9DFenBWTiFK85bZEWXWmfQ+pFUmKwKw0q4Giby3WvIESXwo1Z9pdwHBvojVGD0wLOMO6RJBah6bQctMEDe28T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+o9c3wt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+o9c3wt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790754573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBsxn8sPTYMpQMRwhykYmzuFeTHYzCaE09zTd/pe7uc=;
	b=T+o9c3wtlNeL0qL2IxwWu6HEpU4gMZZTC1pSrne0kYX+YulYa/WsGkvsaRyqZYLzu3cd8x
	LftrphKXXkDTUvZHI92b3lXdUovNhq1vBnyGaN95ZF1VYhgCeBQz73oI3qnzwWxNCjsBoD
	9tvKTgGoqevZ1P68D2h4z8kP8xGjo0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-DSqrtX7_NxGI0LZ9ryMl6Q-1; Wed,
 30 Sep 2026 03:49:28 -0400
X-MC-Unique: DSqrtX7_NxGI0LZ9ryMl6Q-1
X-Mimecast-MFC-AGG-ID: DSqrtX7_NxGI0LZ9ryMl6Q_1790754566
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D44C41955F21;
	Wed, 30 Sep 2026 07:49:25 +0000 (UTC)
Received: from [100.90.87.156] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AEE2180057F;
	Wed, 30 Sep 2026 07:49:22 +0000 (UTC)
Message-ID: <d631d2ed-63b5-4785-80ae-b16deb3edd1a@redhat.com>
Date: Wed, 30 Sep 2026 09:49:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] dpll: zl3073x: notify sibling pin when
 shared output config changes
To: netdev-bot+sashiko@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, min.li@microchip.com,
 pabeni@redhat.com, poros@redhat.com, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
References: <20260928185552.1103515-2-ivecera@redhat.com>
 <179075143120.434549.1576015918203645155@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179075143120.434549.1576015918203645155@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 9/30/26 8:57 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch adds zl3073x_dpll_output_pin_sibling_get()
>    (drivers/dpll/zl3073x/dpll.c:146).
> - [Medium] The commit says it closes the case where the sibling pin's
>    frequency changes without a notification.
> - [Low] The commit message presents the missing sibling notification as a
>    user-visible defect: userspace listening on the sibling pin "is never…
> 
> --
> 
> dpll: zl3073x: notify sibling pin when shared output config changes
> 
> This patch adds zl3073x_dpll_output_pin_sibling_get(), which finds the
> other pin of a P/N output pair. The esync, frequency and phase adjust
> setters use it to send a pin change notification for the sibling after
> the shared output registers are written, and they now use explicit
> mutex_lock()/mutex_unlock() so the notification goes out after
> zldpll->lock is dropped.
> 
>> Changing one of these settings through one pin's dpll_pin therefore
>> also changes the other (sibling) pin's effective configuration, but
>> only the pin the change was requested on gets a dpll_pin_change_ntf()
>> notification - userspace listening on the sibling pin is never told
>> its frequency, esync configuration or phase adjustment changed.
> 
> [Severity: Low]
> This describes a user-visible defect, but the trailers only have
> Tested-by: and Signed-off-by:.
> 
> The dpll core only calls __dpll_pin_change_ntf() for the pin in the
> request (for example in dpll_pin_freq_set()). The sibling has not been
> notified since the output setters were added.
> 
> Should this carry Fixes: tags such as these?
> 
> Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
> Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
> Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")

Agreed, this is a pre-existing user-visible defect. I will add the three
Fixes: tags in v2:

   Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
   Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
   Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")

Jakub, a process question: this patch is both the fix and a prerequisite
for the rest of the series - it introduces
zl3073x_dpll_output_pin_sibling_get() and the notify-outside-lock
handling that the output enable/disable and PTP perout patches build on.
The defect itself is only a missing change notification (no crash, no
data corruption). Is it OK to keep it as patch 1 of this net-next series,
or would you prefer it split out and sent to net first?

>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index f2e137475b40..2c6de4dab8b4 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
>> @@ -132,6 +132,30 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
>>   	return NULL;
>>   }
>>   
>> +/**
>> + * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
>> + * @pin: output pin whose sibling is sought
>> + *
>> + * Output pin ids are allocated in P/N pairs (P even, N odd) that share a
>> + * single HW output. Looks up the other pin of the pair, if it is
>> + * registered as a dpll_pin on this DPLL.
>> + *
>> + * Return: pointer to sibling pin, or NULL if it is not registered
>> + */
>> +static struct zl3073x_dpll_pin *
>> +zl3073x_dpll_output_pin_sibling_get(struct zl3073x_dpll_pin *pin)
>> +{
>> +	struct zl3073x_dpll_pin *sibling;
>> +
>> +	list_for_each_entry(sibling, &pin->dpll->pins, list) {
>> +		if (!zl3073x_dpll_is_input_pin(sibling) &&
>> +		    sibling->id == (pin->id ^ 1))
>> +			return sibling;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
> 
> [ ... ]
> 
>> @@ -934,27 +962,44 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
> 
> [ ... ]
> 
>> +	/* Commit output configuration */
>> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
>> +	if (rc)
>> +		goto unlock;
>> +
>> +	/* The clock type, esync period and esync width are all shared by
>> +	 * both pins of the output pair, so the sibling pin's esync
>> +	 * configuration changes too and userspace has to be notified.
>>   	 */
>> -	out.esync_n_width = out.div / 2;
>> +	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
>>   
>> -	/* Commit output configuration */
>> -	return zl3073x_out_state_set(zldev, out_id, &out);
>> +	mutex_unlock(&zldpll->lock);
>> +
>> +	if (sibling)
>> +		__dpll_pin_change_ntf(sibling->dpll_pin);
> 
> [Severity: High]
> Can sibling->dpll_pin be NULL, or the sibling already freed, by the time
> it is dereferenced here?
> 
> zl3073x_dpll_output_pin_sibling_get() returns any output pin on
> zldpll->pins with the matching id. It does not check that
> sibling->dpll_pin is still set. The lookup runs under zldpll->lock, but
> the dereference happens after mutex_unlock().
> 
> The teardown path does not take zldpll->lock:
> 
> drivers/dpll/zl3073x/dpll.c:zl3073x_dpll_pins_unregister() {
> 	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
> 		zl3073x_dpll_pin_unregister(pin);
> 		list_del(&pin->list);
> 		zl3073x_dpll_pin_free(pin);
> 	}
> }
> 
> zl3073x_dpll_pin_unregister() ends with:
> 
> 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
> 	pin->dpll_pin = NULL;
> 
> and dpll_pin_put() has already dropped dpll_lock at that point.
> 
> zl3073x_dpll_pins_register() uses list_add(), so the N pin (2k+1) sits
> before its P pin (2k) on the list. That means N is torn down while P is
> still registered and reachable over netlink.
> 
> One possible interleaving:
> 
> CPU1 (devlink reload, flash_prepare or unbind)
> zl3073x_dev_stop()
>    zl3073x_dpll_unregister()
>      zl3073x_dpll_pins_unregister()
>        dpll_pin_put(N)          /* dpll_lock released */
> 
> CPU0 (DPLL_CMD_PIN_SET on P, dpll_lock held)
> dpll_pin_freq_set()
>    zl3073x_dpll_output_pin_frequency_set(P)
>      mutex_lock(&zldpll->lock)
>      sibling = zl3073x_dpll_output_pin_sibling_get(P)  /* finds N */
>      mutex_unlock(&zldpll->lock)
> 
> CPU1
>        N->dpll_pin = NULL
>        list_del(&N->list)
>        zl3073x_dpll_pin_free(N)
> 
> CPU0
>      __dpll_pin_change_ntf(sibling->dpll_pin)
> 
> In that case, would __dpll_pin_change_ntf() get NULL and oops on
> pin->id and pin->clock_id in dpll_pin_notify()? Or would CPU0 read the
> freed zl3073x_dpll_pin?
> 
> The list walk in zl3073x_dpll_output_pin_sibling_get() can also run
> while list_del() is in progress, because the writer never takes
> zldpll->lock.
> 
> zl3073x_dpll_output_pin_frequency_set() and
> zl3073x_dpll_output_pin_phase_adjust_set() have the same pattern.
> 
> The later patch "dpll: zl3073x: add PTP periodic output support" also
> calls zl3073x_dpll_output_pin_sibling_get() from
> zl3073x_dpll_ptp_enable() without holding zldpll->lock at all.

This cannot happen; the notification is already serialized against pin
teardown.

The output setters (esync_set / frequency_set / phase_adjust_set) run
with dpll_lock held: the dpll core invokes the pin ops under dpll_lock,
and they use __dpll_pin_change_ntf(), whose contract is exactly "caller
must hold dpll_lock" (dpll_netlink.c: lockdep_assert_held(&dpll_lock),
"suitable for use inside pin callbacks which are already invoked under
dpll_lock"). So sibling_get() and the __dpll_pin_change_ntf() call - even
though it runs after mutex_unlock(&zldpll->lock) - are all covered by
dpll_lock.

Pin teardown frees the sibling via zl3073x_dpll_pin_unregister() ->
dpll_pin_unregister(), which takes dpll_lock. While a setter holds
dpll_lock for the whole callback, teardown cannot even reach
dpll_pin_unregister(N), let alone the following list_del()/kfree(). The
proposed interleaving (CPU1 freeing N while CPU0 notifies) is therefore
impossible: CPU0 holds dpll_lock throughout.

The PTP enable() path (zl3073x_dpll_ptp_enable(), added in patch 6) does
call sibling_get() outside dpll_lock, but it is serialized differently:
zl3073x_dpll_unregister() unregisters the PTP clock *before* the pins
(zl3073x_dpll_ptp_unregister() then zl3073x_dpll_pins_unregister()), and
ptp_clock_unregister() quiesces in-flight enable() callbacks. No
enable() can run while the pins are being freed.

> 
> [ ... ]
> 
>> @@ -1010,7 +1058,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>>   		out.width = new_div;
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
>> @@ -1022,8 +1079,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>>   		 * Update divisor for N-pin to keep N-pin frequency.
>>   		 */
>>   		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
> 
> [Severity: Medium]
> Does the N pin also need a notification on this path?
> 
> In the N-div formats OUTPUT_DIV is still shared. The N-pin frequency is
> computed from both values:
> 
> drivers/dpll/zl3073x/core.h:zl3073x_dev_output_pin_freq_get() {
> 	...
> 	freq = zl3073x_synth_freq_get(synth) / out->div;
> 
> 	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
> 		freq /= out->esync_n_period;
> 	...
> }
> 
> The rescale above truncates and only rejects 0. zl3073x_pin_check_freq()
> only requires the new P frequency to divide the synth frequency.
> 
> For example, take a 500 MHz synth with P = 10 MHz (div 50) and
> N = 2 MHz (period 5). Setting P to 25 MHz gives new_div 20 and period
> 250 / 20 = 12. N then becomes 500M / (20 * 12), about 2.083 MHz.
> 
> This path reaches the unlock label with sibling still NULL, so the N
> pin gets no DPLL_CMD_PIN_CHANGE_NTF. The commit message says the sibling
> is notified "whenever the shared HW state actually changes". Should this
> case be covered too?
> 
> The later commit "dpll: zl3073x: factor out output pin frequency helper"
> does not change this. The truncation moves into
> zl3073x_dpll_output_pin_freq_set(), and frequency_set still calls
> zl3073x_dpll_output_pin_sibling_get() only when
> !zl3073x_out_is_ndiv(&out).

By design the N-pin frequency is meant to be preserved when the P-pin
frequency changes - that is the purpose of rescaling esync_n_period. With
an exact rescale, div_new * period_new == div_old * period_old, so
N = synth / (div * period) is unchanged and no sibling notification is
needed.

The only thing that can actually perturb N here is the truncation in that
rescale, which is the separate issue Sashiko raised on patch 5 ("does this
rescale really keep the N-pin frequency unchanged?"). I will fix it there
by rejecting an inexact rescale with -EINVAL (i.e. when div_old * period_old
is not divisible by div_new), so N is guaranteed to stay unchanged. With that
fix there is nothing to notify on this path, so no sibling notification is added
here.

Thanks,
Ivan

