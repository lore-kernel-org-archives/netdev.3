Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182841B8D7
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438806; cv=none; b=WSNQIpP3GAbNy8VLBNPpO7zQGBIWSGghtTZT+1W2Q5+u7aSZ+K6ktT42SQBuiIYnrzhGwsSsYIRYMe1/YVftO/te+0qAaC6aTOSogWbOpOYDYAbXHHWa81gszcm4UXbf6lG5a403HxvtgaxduAvV6Jgmpcg7vRRV4UyTaLzqsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438806; c=relaxed/simple;
	bh=t7BOke3s47mhHVNiaxIizFib9eVQnX2fxrkzE8J1y+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ4SgrmhmTG9dcU9hB4gf0aYYQI+RWRz9h8rcCRTe1b5f6jxHJ5Ca/dYihUEdPLvSkt04YquB4PVmrOjsiRV0gn3qYyzkpWrtOA7PKjUmnd83PaSwCsTZVUfQ82VV9uZXM6QllftHCY/ycyy0vZfOq7DSfH8m+6+IdfZbWOFiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iim77Cz8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+DbLMsT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iim77Cz8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+DbLMsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786438802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eshuqxPuNO4xGCQCYL4zRadx/VGkau93YdDo0MWtilw=;
	b=Iim77Cz89RkFeXbOwysxb8koQAd7b4oFpuwobWS4mKuBWEUSd/FQ1T/azhbYkJ5fF9kTi2
	liV+paCeGUkT7xhs7IDpi2K3L9JB6ZVCTWFMDXUr/daTpe3bwaRfv65Nx3c6Q0G/KFfbYp
	w/UFkAsUbXzfHB+nHup9Q+Tn9pY99t4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-JsrB37MBNnOvm7zDo72wNA-1; Tue, 11 Aug 2026 04:59:59 -0400
X-MC-Unique: JsrB37MBNnOvm7zDo72wNA-1
X-Mimecast-MFC-AGG-ID: JsrB37MBNnOvm7zDo72wNA_1786438798
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f83999cceso2274789f8f.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786438798; x=1787043598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eshuqxPuNO4xGCQCYL4zRadx/VGkau93YdDo0MWtilw=;
        b=R+DbLMsTycJBDbXuhsEUPnGjS57jO1PdUZKPqAV0jRPcCwtn4esfBtAoWZ8k2Yqcm2
         BgcsduBl80iSMPuhYbPDaEoFo0Rc9NlGQZNcEbK10jwaCxYwJ6fwoBlZxSk/BF57yl7j
         YhHPEhh8kg9Rtwmd162zMnnhVUtonq7hGTfn9TR6qAbsU8RMPoCEJXVCflY2TQynf1Py
         pm012IwsOojitxQK6+f/hXOE4QQ84b/8IboWHPRyj3Hl5ARZq3OAlLPp8OtTN/sYeARP
         ZwpSSCG+RbBbabUet7h30PwDLDevD93GtZu/lb0NjiG8tZXjs9/7eOh1ySiPLL0DJOKj
         4Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438798; x=1787043598;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eshuqxPuNO4xGCQCYL4zRadx/VGkau93YdDo0MWtilw=;
        b=NC0TYHMWMuIqjhwIlr7tFiiux5TRwc8Qwp8Yw0YQ8pHLvHlrJMvjCxi+I0IlWzoQlF
         hGvmdFA+eCO1gJUGeSCSMrGSAMzOlj4ZK72p8t8RkN9pirCmZskw3EiYav8Rd3IzlhSt
         ONVElNdRaKksu1D7SKN8mWEcnuk8UUb4dl/YIiSdTK4Avu4tblV69EKqR03YVrm3rIYy
         cxCdKBTBxr0iAhotM5Kw1U/mqXN2g9ZLNMOxIz56QLKqVWcB74oRmlDX7VqdUD0X4uUP
         B8/c2rmAv/MRq8VCuWEXMrKezC9Xw6zkrsYG2Xd613Dkmw6JBpr+vttOmV6n8RIXoxSD
         EiGQ==
X-Forwarded-Encrypted: i=1; AHgh+RomK3ybbkoNhGcWrWTajbRuyembSoUlL1az/MPB+oc0LOfBSS2ZgT/dszPufbfptbpy2Nm0j94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdB0cksLuamDzFIrqhZdp8c0Vk68Clo6nM+ZqApxIA49mfEF6
	XF4PrtBOQ8GZ2mfbiqtdAEuVa2tq5j2+lLpXbtM/Z7BTqBv/smDcvBPX13KOnpTlLRDKEGImrgZ
	LKRRCK6Mii+BmqvnSE5hmZ9VmXU/evOdbWBFwYSVdb429Sp2JHoz3Bwy7wA==
X-Gm-Gg: AR+sD121+GHb5NgckvALjB6x3CW7xCPtpIgT/2O0VO696SfUKo3Jm4CPAeFZHSj7def
	GSW931QswbSh+WNrUliGM6fLzwBnYQfsTQyyGn5XVCDTaN4NeFvOezz5Q5cpbE+kIuOXalUiWg5
	69WkVJnVSZnrSUR7qX8XF6phyx0XEoImXpes/1Bqp4QKd22fAduHCNCV9q0eXFYvk5P865GIwd/
	UYXY7XJX6kXb1WzV4NvSH2HWvchksm2WDAXLxBGhnQfgdP1trCpHe7FngCh5nKauuXEKaze4WT0
	vNqO7r4BjoKqxBDDvvCc29W88fuzDBP2cu1mQv/R08RUJxkKrAh+3r2bH0bRq1Y=
X-Received: by 2002:a05:600c:4709:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-4997844c55emr29605685e9.10.1786438798093;
        Tue, 11 Aug 2026 01:59:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4709:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-4997844c55emr29604685e9.10.1786438797554;
        Tue, 11 Aug 2026 01:59:57 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788f11b8sm29690255e9.10.2026.08.11.01.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 01:59:56 -0700 (PDT)
Message-ID: <3cde09fa-3b68-4fdb-9797-f6e23b7166c4@redhat.com>
Date: Tue, 11 Aug 2026 10:59:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] dpll: zl3073x: update all DPLL channels
 on ref_sync_set
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
References: <20260807095926.386923-1-ivecera@redhat.com>
 <20260807095926.386923-2-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260807095926.386923-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/7/26 11:59, Ivan Vecera wrote:
> zl3073x_dpll_input_pin_ref_sync_set() excludes the sync source from
> automatic reference selection by setting its priority to NONE, but
> currently only does this on the single DPLL channel whose pin_priv
> was passed to the callback.
>
> Since input pins are registered with every DPLL channel, the datasheet
> recommends covering all channels to prevent the sync source from
> remaining a selectable candidate on the other channels. This is
> a preparation for the following patch which changes the DPLL core to
> invoke pin-level set callbacks only through the pin owner's reference
> instead of iterating over all registered DPLL devices.
>
> Replace the single-channel priority write with a list_for_each_entry()
> loop over all DPLL channels. Each channel's lock is acquired
> individually for its read-modify-write sequence. The guard(mutex) is
> replaced with explicit mutex_lock/mutex_unlock to allow releasing the
> owner's lock before iterating, avoiding nested locking of the same
> mutex class. A change notification is sent for the sync pin if any
> channel's priority was actually modified.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 58 ++++++++++++++++++++++++++++++-------
>   1 file changed, 48 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 0488ae6ac486c8..83bd3027dbaa1e 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -263,9 +263,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>   	u8 mode, ref_id, sync_ref_id;
>   	struct zl3073x_chan chan;
>   	struct zl3073x_ref ref;
> +	bool sync_ntf = false;
>   	int rc;
>   
> -	guard(mutex)(&zldpll->lock);
> +	mutex_lock(&zldpll->lock);
>   
>   	ref_id = zl3073x_input_pin_ref_get(pin->id);
>   	sync_ref_id = zl3073x_input_pin_ref_get(sync_pin->id);
> @@ -285,17 +286,20 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>   		if (sync_freq > 8000) {
>   			NL_SET_ERR_MSG(extack,
>   				       "sync frequency must be 8 kHz or less");
> -			return -EINVAL;
> +			rc = -EINVAL;
> +			goto unlock;
>   		}
>   		if (ref_freq < 1000) {
>   			NL_SET_ERR_MSG(extack,
>   				       "clock frequency must be 1 kHz or more");
> -			return -EINVAL;
> +			rc = -EINVAL;
> +			goto unlock;
>   		}
>   		if (ref_freq <= sync_freq) {
>   			NL_SET_ERR_MSG(extack,
>   				       "clock frequency must be higher than sync frequency");
> -			return -EINVAL;
> +			rc = -EINVAL;
> +			goto unlock;
>   		}
>   
>   		zl3073x_ref_sync_pair_set(&ref, sync_ref_id);
> @@ -308,20 +312,54 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>   
>   	rc = zl3073x_ref_state_set(zldev, ref_id, &ref);
>   	if (rc)
> -		return rc;
> +		goto unlock;
>   
> -	/* Exclude sync source from automatic reference selection by setting
> -	 * its priority to NONE. On disconnect the priority is left as NONE
> -	 * and the user must explicitly make the pin selectable again.
> +	/* All code paths accessing per-channel reference priorities are
> +	 * serialized by the subsystem dpll_lock, so it is safe to release
> +	 * our lock here before iterating over the other channels.
>   	 */
> -	if (state == DPLL_PIN_STATE_CONNECTED) {
> +	mutex_unlock(&zldpll->lock);
> +
> +	if (state != DPLL_PIN_STATE_CONNECTED)
> +		return 0;
> +
> +	/* The datasheet recommends excluding the sync source from automatic
> +	 * reference selection by setting its priority to NONE on all DPLL
> +	 * channels. This is advisory - the ref sync pair is already
> +	 * configured, so a failure here is not fatal. On disconnect the
> +	 * priority is left as NONE and the user must explicitly make the
> +	 * pin selectable again.
> +	 */
> +	list_for_each_entry(zldpll, &zldev->dplls, list) {
> +		u8 prio;
> +
> +		mutex_lock(&zldpll->lock);
> +
>   		chan = *zl3073x_chan_state_get(zldev, zldpll->id);
> +		prio = zl3073x_chan_ref_prio_get(&chan, sync_ref_id);
> +		if (prio == ZL_DPLL_REF_PRIO_NONE) {
> +			mutex_unlock(&zldpll->lock);
> +			continue; /* Ref is already non-selectable */
> +		}
> +
>   		zl3073x_chan_ref_prio_set(&chan, sync_ref_id,
>   					  ZL_DPLL_REF_PRIO_NONE);
> -		return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
> +		if (zl3073x_chan_state_set(zldev, zldpll->id, &chan))
> +			dev_warn(zldev->dev,
> +				 "Failed to set ref prio on DPLL%u\n",
> +				 zldpll->id);
> +		else
> +			sync_ntf = true;
> +
> +		mutex_unlock(&zldpll->lock);
>   	}
> +	if (sync_ntf)
> +		__dpll_pin_change_ntf(sync_pin->dpll_pin);
>   
>   	return 0;
> +unlock:
> +	mutex_unlock(&zldpll->lock);
> +	return rc;
>   }
>   
>   static int

Reviewed-by: Petr Oros <poros@redhat.com>


