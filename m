Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DA3FD960
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399408; cv=none; b=IeCD79qYqVSN6szUpiYwtSgGJyLk7/+ALGBl76Ld4tcX7C1ECncBTRfWPyjKEARAEmwZyowCnDtInvyjwZaC/h/RyPNhKXdvdKDsIUDBxyydvawYEibzova7xjuGJQyB6TtoEIEJ6/jYVS0pJu6iey81nvkBGLGMTPi2ROpS9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399408; c=relaxed/simple;
	bh=vLInWXHZzviqWQ27RVDsMpzKgdnAlGLLXXLkOY3TKo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0fgOIt5JDcGtHSb5Qj7eI/B42WjLRYy0UxRcQ3Q6dm9Mpr56Vdk6zGLNNjqcAc3todPWsRWxwLaeKPqCovDPbUllSYrUmRncvVzfW0fW24JKUyqBpGhHJv9Ux+Tw5aLyokyX+xDNuE0L3b4Cq2dftTbH7t69WRXS4ZINu/AAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUdFi4wB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkZa2YTD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUdFi4wB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkZa2YTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791399405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdJ0yl4Y7a517Zh171Ufd/qnh/YUt3oPd6EQX5MGSs8=;
	b=JUdFi4wB+SlWYGDd6dsZWEIZ2SCor8DjtswLngJAM9lVyg7g+eMhvLaDJ4MWVAqK3G6fk7
	2hPsR7b4gXisf1YXhbLe2wFqie48cqsVkL22N43knStsYL5Hf8bp9RS20wK/HC1+Vg26By
	c2SrOrhJJLsgvRlz0WOVgc0M/19Lo2A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-30YuusurNh-oU9FzVvjDpA-1; Wed, 07 Oct 2026 14:55:52 -0400
X-MC-Unique: 30YuusurNh-oU9FzVvjDpA-1
X-Mimecast-MFC-AGG-ID: 30YuusurNh-oU9FzVvjDpA_1791399351
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c427421f6so2938994f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791399351; x=1792004151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FdJ0yl4Y7a517Zh171Ufd/qnh/YUt3oPd6EQX5MGSs8=;
        b=TkZa2YTDoSuAvBN7UAAWeSDgyq48zeGum3HQGBD2dJMiMaWkt+MDFCQtIyMlNlqlpH
         XC6pgNRDRpFP+AB+DCHVKKx4z5awou4ADNNG/qrAL3Rb5kM2OUrPXTiccTy8SJEKcLn7
         WxDYmhiXYNTPDiELSPBw4yQrlIsOPpFNEjNxEO5YUDFL/QE2Mnf4ktWxtE0gy718jxwf
         hPhlo+/lb92UsOtwDgAbSvBu4yzg8d4kAytZEFSvt/Hq+2+IwC3Rcx2k5T/sonwNS8lA
         qfbZ5iNYN/3BpBwVl8o8UQkP07tZwwy3t9uXbWJkxTXySAhYT36S3hdiJNp1Qg/IjDUG
         1exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791399351; x=1792004151;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FdJ0yl4Y7a517Zh171Ufd/qnh/YUt3oPd6EQX5MGSs8=;
        b=J+fuhPZZIIBUA6rgBeo+Tckql9rWSNQ5aGDXbM5ZF9kBeCdjDSTJ1z8++Kw58SeQxW
         1ZDlxKlBefW3+SLZ578JaUVcvxK5TkcRLK5yvLjRJp8KayA7scpXesnfimIIr32E2ho+
         wuoBPNFWXyAgsFbfkwiZfbmX1haNKAmBlrVq3w9+NIP0rhtGajz+gizhVMGY7cgImcZQ
         3rdyTZhASjxPMh87phlAd/7fBquMlFSyA7/dilPJI4vVEtlR70ZpDv3Z7HMoRo/+4aVz
         6LMBb5RtE3vOndr42Wn00HK7umfxmH91Wyxskam14h58suZ35GFuu/5+8Ue6WMxZyt6A
         YvYg==
X-Forwarded-Encrypted: i=1; AKwUvBxmTNPUihJsVHy5s2Fn4Nzx2RVcVX5J003iQi0OHhKwui+kafTDe+F5ApdJ92pFweSb2Uq/788=@vger.kernel.org
X-Gm-Message-State: AFuF++mD0ljrrOhtg/theUl0aL6PRxGbXXg26O6WG8U901y7GtN7ek4m
	DuaVqtmBvR3tdQQK3VvBgRKSgAhaD2pc07dnOAwwJI6lXdwb1lrKiKueCRHGSRAB1x1t5pjEb0Y
	yK+ik9HHL4dYTldtn66a34KGw2dqrj2YpfaJXpY+SL5B6FA4zYmFploLm9w==
X-Gm-Gg: AYBFou0p5efz2bysHvDe6QGY0YoTZX0npA8dOVUzh+Teno6cfwIX/J3T3xwdV0X1f1h
	b9ZIXogfEcV+k/tL3udnbSSI/Saoof2s0qKALvUSfOGdmodtAx+eXB6VpbvTB+x7AJFOAkmBCid
	OzZhxAizjYdMGjOoV41nB3IgQv6sihhMYZuFq4R9m9+wP0l6OELdEuF649cFZEajSt3k8uud9KG
	8IgXSV5AC4pf/H48af1qDEtQLGrPXs+yC9AMlO3xO79nnbpET16AlC51CXSGqG2CacOQMQyyv4P
	6Y9vN/VbAJZG9oN/3NzQ0d/xAMAjgHBNNDMgGBv63sbvBISKgk7Y6uchBzWIGzXkrPKVe8fwLA=
	=
X-Received: by 2002:a05:600c:3e0a:b0:4a1:6c79:fd31 with SMTP id 5b1f17b1804b1-4a180459354mr49839065e9.12.1791399351184;
        Wed, 07 Oct 2026 11:55:51 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:4a1:6c79:fd31 with SMTP id 5b1f17b1804b1-4a180459354mr49838785e9.12.1791399350752;
        Wed, 07 Oct 2026 11:55:50 -0700 (PDT)
Received: from [192.168.2.75] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18044c970sm47111245e9.4.2026.10.07.11.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 11:55:49 -0700 (PDT)
Message-ID: <2a263f32-82a9-42b7-8aeb-8ac51a801fd9@redhat.com>
Date: Wed, 7 Oct 2026 20:55:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/4] dpll: zl3073x: notify sibling pin when shared
 output config changes
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20261006153116.347497-1-ivecera@redhat.com>
 <20261006153116.347497-5-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261006153116.347497-5-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/26 5:31 PM, Ivan Vecera wrote:
> Each zl3073x output has a P-pin and an N-pin that share a single HW
> output and, outside N-pin divide mode, share the output's divisor,
> clock type, esync period/width and phase compensation registers.
> Changing one of these settings through one pin's dpll_pin therefore
> also changes the other (sibling) pin's effective configuration, but
> only the pin the change was requested on gets a dpll_pin_change_ntf()
> notification - userspace listening on the sibling pin is never told
> its frequency, esync configuration or phase adjustment changed.
> 
> This was found by code inspection rather than triggered at runtime: a
> dpll pin-get on the sibling pin returns the correct current values, but
> because no change notification is emitted for it, userspace is never
> told that its configuration changed asynchronously through the other
> pin.
> 
> Add zl3073x_dpll_output_pin_sibling_get() to look up the other pin of
> an output pair, and use it in frequency_set() (for the non-N-divided
> signal formats, where the output divisor is shared), esync_set() and
> phase_adjust_set() to notify the sibling pin, if it is registered,
> whenever the shared HW state actually changes.
> 
> The three callbacks are switched from guard(mutex) to explicit
> mutex_lock()/mutex_unlock() with goto-based unwinding, because the
> notification must run after zldpll->lock is released: the notification
> re-enters the pin get callbacks, which take zldpll->lock again, so
> calling it under the lock would deadlock. The DPLL subsystem's own
> dpll_lock is still held across the callback, so the __ (lock-held)
> notification variant is used.
> 
> The sibling lookup walks the zldpll->pins list, so the list membership
> has to match the DPLL registration state. dpll_pin_register() publishes
> a pin (and P is registered before N) before it used to be added to the
> list, and teardown detached the whole list before unregistering any
> pin, so a sibling that is registered - and thus reachable by a PIN_SET
> on the other pin - could be missing from the list and never notified.
> Add the pin to the list before dpll_pin_register() and remove it only
> after dpll_pin_unregister(), both under zldpll->lock, and assert the
> lock in the lookup helper. A pin that is transiently on the list while
> not registered is harmless: __dpll_pin_change_ntf() is a no-op for a
> pin that is not available, and the sibling cannot be freed under the
> lookup because the freeing goes through dpll_pin_unregister(), which
> takes dpll_lock that the notification path holds.
> 
> Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
> Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
> Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 187 ++++++++++++++++++++++++++++--------
>   1 file changed, 146 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 65107b4cc4f8..9c678acc3e77 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -123,6 +123,8 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
>   {
>   	struct zl3073x_dpll_pin *pin;
>   
> +	lockdep_assert_held(&zldpll->lock);
> +
>   	list_for_each_entry(pin, &zldpll->pins, list) {
>   		if (zl3073x_dpll_is_input_pin(pin) &&
>   		    zl3073x_input_pin_ref_get(pin->id) == ref_id)
> @@ -132,11 +134,39 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
>   	return NULL;
>   }
>   
> +/**
> + * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
> + * @pin: output pin whose sibling is sought
> + *
> + * Output pin ids are allocated in P/N pairs (P even, N odd) that share a
> + * single HW output. Looks up the other pin of the pair, if it is
> + * registered as a dpll_pin on this DPLL.
> + *
> + * Return: pointer to sibling pin, or NULL if it is not registered
> + */
> +static struct zl3073x_dpll_pin *
> +zl3073x_dpll_output_pin_sibling_get(struct zl3073x_dpll_pin *pin)
> +{
> +	struct zl3073x_dpll_pin *sibling;
> +
> +	lockdep_assert_held(&pin->dpll->lock);
> +
> +	list_for_each_entry(sibling, &pin->dpll->pins, list) {
> +		if (!zl3073x_dpll_is_input_pin(sibling) &&
> +		    sibling->id == (pin->id ^ 1))
> +			return sibling;
> +	}
> +
> +	return NULL;
> +}
> +
>   static struct zl3073x_dpll_pin *
>   zl3073x_dpll_nco_pin_get(struct zl3073x_dpll *zldpll)
>   {
>   	struct zl3073x_dpll_pin *pin;
>   
> +	lockdep_assert_held(&zldpll->lock);
> +
>   	list_for_each_entry(pin, &zldpll->pins, list) {
>   		if (zl3073x_dpll_is_nco_pin(pin))
>   			return pin;
> @@ -899,12 +929,14 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>   	struct zl3073x_dpll *zldpll = dpll_priv;
>   	struct zl3073x_dev *zldev = zldpll->dev;
>   	struct zl3073x_dpll_pin *pin = pin_priv;
> +	struct zl3073x_dpll_pin *sibling = NULL;
>   	const struct zl3073x_synth *synth;
>   	struct zl3073x_out out;
>   	u32 synth_freq;
>   	u8 out_id;
> +	int rc;
>   
> -	guard(mutex)(&zldpll->lock);
> +	mutex_lock(&zldpll->lock);
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = *zl3073x_out_state_get(zldev, out_id);
> @@ -913,12 +945,14 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>   	 * for N-division is also used for the esync divider so both cannot
>   	 * be used.
>   	 */
> -	if (zl3073x_out_is_ndiv(&out))
> -		return -EOPNOTSUPP;
> +	if (zl3073x_out_is_ndiv(&out)) {
> +		rc = -EOPNOTSUPP;
> +		goto unlock;
> +	}
>   
>   	if (!freq) {
>   		zl3073x_out_esync_disable(&out);
> -		return zl3073x_out_state_set(zldev, out_id, &out);
> +		goto commit;
>   	}
>   
>   	/* Get attached synth frequency */
> @@ -927,9 +961,24 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>   
>   	/* Enable 1PPS eSync for this pin frequency */
>   	zl3073x_out_esync_enable(&out, synth_freq / out.div);
> -
> +commit:
>   	/* Commit output configuration */
> -	return zl3073x_out_state_set(zldev, out_id, &out);
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +	if (rc)
> +		goto unlock;
> +
> +	/* The clock type, esync period and esync width are all shared by
> +	 * both pins of the output pair, so the sibling pin's esync
> +	 * configuration changes too and userspace has to be notified.
> +	 */
> +	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
> +unlock:
> +	mutex_unlock(&zldpll->lock);
> +
> +	if (!rc && sibling)
> +		__dpll_pin_change_ntf(sibling->dpll_pin);
> +
> +	return rc;
>   }
>   
>   static int
> @@ -959,12 +1008,14 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   	struct zl3073x_dpll *zldpll = dpll_priv;
>   	struct zl3073x_dev *zldev = zldpll->dev;
>   	struct zl3073x_dpll_pin *pin = pin_priv;
> +	struct zl3073x_dpll_pin *sibling = NULL;
>   	const struct zl3073x_synth *synth;
>   	u32 new_div, synth_freq;
>   	struct zl3073x_out out;
>   	u8 out_id;
> +	int rc;
>   
> -	guard(mutex)(&zldpll->lock);
> +	mutex_lock(&zldpll->lock);
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = *zl3073x_out_state_get(zldev, out_id);
> @@ -977,7 +1028,8 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   	/* Check signal format */
>   	if (!zl3073x_out_is_ndiv(&out)) {
>   		/* For non N-divided signal formats the frequency is computed
> -		 * as division of synth frequency and output divisor.
> +		 * as division of synth frequency and output divisor, which
> +		 * is shared by both pins of the output pair.
>   		 */
>   		out.div = new_div;
>   
> @@ -1002,7 +1054,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   		}
>   
>   		/* Commit output configuration */
> -		return zl3073x_out_state_set(zldev, out_id, &out);
> +		rc = zl3073x_out_state_set(zldev, out_id, &out);
> +		if (rc)
> +			goto unlock;
> +
> +		/* The other pin's frequency changed too - it has to be
> +		 * notified about the change.
> +		 */
> +		sibling = zl3073x_dpll_output_pin_sibling_get(pin);
> +
> +		goto unlock;
>   	}
>   
>   	if (zl3073x_dpll_is_p_pin(pin)) {
> @@ -1017,18 +1078,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   		u32 rem;
>   
>   		out.esync_n_period = div_u64_rem(prod, new_div, &rem);
> -		if (rem != 0) {
> -			NL_SET_ERR_MSG_FMT(extack,
> -					   "OUT%uN freq must divide OUT%uP freq",
> -					   out_id, out_id);
> -			return -EINVAL;
> -		}
> -		if (out.esync_n_period < 2) {
> -			NL_SET_ERR_MSG_FMT(extack,
> -					   "OUT%uN freq must be less than OUT%uP freq",
> -					   out_id, out_id);
> -			return -EINVAL;
> -		}
> +		if (rem != 0)
> +			goto err_n_nondiv;
> +		if (out.esync_n_period < 2)
> +			goto err_n_toohigh;
>   
>   		/* Update the output divisor */
>   		out.div = new_div;
> @@ -1046,25 +1099,36 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   		u64 rem, prod = frequency * out.div;
>   
>   		out.esync_n_period = div64_u64_rem(synth_freq, prod, &rem);
> -		if (rem != 0) {
> -			NL_SET_ERR_MSG_FMT(extack,
> -					   "OUT%uN freq must divide OUT%uP freq",
> -					   out_id, out_id);
> -			return -EINVAL;
> -		}
> -		if (out.esync_n_period < 2) {
> -			NL_SET_ERR_MSG_FMT(extack,
> -					   "OUT%uN freq must be less than OUT%uP freq",
> -					   out_id, out_id);
> -			return -EINVAL;
> -		}
> +		if (rem != 0)
> +			goto err_n_nondiv;
> +		if (out.esync_n_period < 2)
> +			goto err_n_toohigh;
>   	}
>   
>   	/* For 50/50 duty cycle the divisor is equal to width */
>   	out.esync_n_width = out.esync_n_period;
>   
>   	/* Commit output configuration */
> -	return zl3073x_out_state_set(zldev, out_id, &out);
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +unlock:
> +	mutex_unlock(&zldpll->lock);
> +
> +	if (!rc && sibling)
> +		__dpll_pin_change_ntf(sibling->dpll_pin);
> +
> +	return rc;
> +err_n_nondiv:
> +	NL_SET_ERR_MSG_FMT(extack,
> +			   "OUT%uN freq must divide OUT%uP freq",
> +			   out_id, out_id);
> +	rc = -EINVAL;
> +	goto unlock;
> +err_n_toohigh:
> +	NL_SET_ERR_MSG_FMT(extack,
> +			   "OUT%uN freq must be less than OUT%uP freq",
> +			   out_id, out_id);
> +	rc = -EINVAL;
> +	goto unlock;
>   }
>   
>   static int
> @@ -1103,10 +1167,12 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
>   	struct zl3073x_dpll *zldpll = dpll_priv;
>   	struct zl3073x_dev *zldev = zldpll->dev;
>   	struct zl3073x_dpll_pin *pin = pin_priv;
> +	struct zl3073x_dpll_pin *sibling = NULL;
>   	struct zl3073x_out out;
>   	u8 out_id;
> +	int rc;
>   
> -	guard(mutex)(&zldpll->lock);
> +	mutex_lock(&zldpll->lock);
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = *zl3073x_out_state_get(zldev, out_id);
> @@ -1115,7 +1181,21 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
>   	out.phase_comp = phase_adjust / pin->phase_gran;
>   
>   	/* Update output configuration from mailbox */
> -	return zl3073x_out_state_set(zldev, out_id, &out);
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +	if (rc)
> +		goto unlock;
> +
> +	/* The phase compensation register is shared by both pins of the
> +	 * output pair, so the sibling pin's phase adjustment changes too.
> +	 */
> +	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
> +unlock:
> +	mutex_unlock(&zldpll->lock);
> +
> +	if (!rc && sibling)
> +		__dpll_pin_change_ntf(sibling->dpll_pin);
> +
> +	return rc;
>   }
>   
>   static int
> @@ -1739,6 +1819,13 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
>   	else
>   		ops = &zl3073x_dpll_output_pin_ops;
>   
> +	/* Add the pin to the list before registering it with the DPLL core so
> +	 * that it is findable as a sibling as soon as the core publishes it.
> +	 */
> +	mutex_lock(&zldpll->lock);
> +	list_add(&pin->list, &zldpll->pins);
> +	mutex_unlock(&zldpll->lock);
> +
>   	/* Register the pin */
>   	rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
>   	if (rc)
> @@ -1750,6 +1837,9 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
>   	return 0;
>   
>   err_register:
> +	mutex_lock(&zldpll->lock);
> +	list_del(&pin->list);
> +	mutex_unlock(&zldpll->lock);
>   	dpll_pin_put(pin->dpll_pin, &pin->tracker);
>   err_pin_get:
>   	pin->dpll_pin = NULL;
> @@ -1784,6 +1874,13 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
>   	/* Unregister the pin */
>   	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
>   
> +	/* Remove the pin from the list only after it has been unregistered so
> +	 * that a still-registered pin is always findable as a sibling.
> +	 */
> +	mutex_lock(&zldpll->lock);
> +	list_del(&pin->list);
> +	mutex_unlock(&zldpll->lock);
> +
>   	dpll_pin_put(pin->dpll_pin, &pin->tracker);
>   	pin->dpll_pin = NULL;
>   
> @@ -1803,9 +1900,11 @@ zl3073x_dpll_pins_unregister(struct zl3073x_dpll *zldpll)
>   {
>   	struct zl3073x_dpll_pin *pin, *next;
>   
> +	/* Unregister each pin before removing it from the list so that a
> +	 * still-registered pin is always findable as a sibling.
> +	 */
>   	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
>   		zl3073x_dpll_pin_unregister(pin);
> -		list_del(&pin->list);
>   		zl3073x_dpll_pin_free(pin);
>   	}
>   }
> @@ -1918,16 +2017,24 @@ zl3073x_dpll_nco_pin_register(struct zl3073x_dpll *zldpll)
>   		goto err_pin_get;
>   	}
>   
> +	/* Add the pin to the list before registering it with the DPLL core so
> +	 * that the list reflects the DPLL registration state.
> +	 */
> +	mutex_lock(&zldpll->lock);
> +	list_add(&pin->list, &zldpll->pins);
> +	mutex_unlock(&zldpll->lock);
> +
>   	rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin,
>   			       &zl3073x_dpll_nco_pin_ops, pin);
>   	if (rc)
>   		goto err_register;
>   
> -	list_add(&pin->list, &zldpll->pins);
> -
>   	return 0;
>   
>   err_register:
> +	mutex_lock(&zldpll->lock);
> +	list_del(&pin->list);
> +	mutex_unlock(&zldpll->lock);
>   	dpll_pin_put(pin->dpll_pin, &pin->tracker);
>   err_pin_get:
>   	pin->dpll_pin = NULL;
> @@ -1979,8 +2086,6 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>   			zl3073x_dpll_pin_free(pin);
>   			goto error;
>   		}
> -
> -		list_add(&pin->list, &zldpll->pins);
>   	}
>   
>   	/* Register NCO virtual input pin */

Reviewed-by: Petr Oros <poros@redhat.com>

