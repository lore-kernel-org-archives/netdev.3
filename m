Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227030DD1F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191947; cv=none; b=LLCqjFaxedxzPpvCF3NS3R+CuuzKBr7zlc4S++I1ZBdm+41T47OGDE0vHQjs0xmnXrn/doamivHPrMZoGFqTihe2Aq3q1sxZJ3pAo0QnHvYvrFTsRWH9SUSyprLFG1Qn4opzSgfOZ50QmchuqbRpwUBSwhKCuzQRHGUO8eDaGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191947; c=relaxed/simple;
	bh=Hjqwyf4OBvxKH4vDGLehy3Ni08UVc8H2mgeX1ja1CXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scR+Q06RPILhVpgEIo4/hZ0oGc2PbYuTOsBBt47eM0ML+AEZGxBV3hOkulHKLHa25aomlQo3zGbkW+9JT5ugsN1auxkz8BafcwrLsbQGSS1eLRHdqpdKzPHowv8yQ4dhk6oGxWkzxFtew1tm14Xkr5Z8SDXQIR6hb8zOj0HPRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZA3qaEg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZA3qaEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779191944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL1m1PMakBeZyY2dvfYeN67iANOcVCIWNfrp8gF1mEE=;
	b=CZA3qaEgicGrl82ABpeK6CW9bALh4yPpRzS8dazNhVCUkLyDb+Zu3VjkM6zIRiFjKKMx8S
	MSqF4h2MAEMvlWxqTqR+OZ8tqMpgGa1jQr7jz1PjJhNbSQJmJMjma6c5nIgjFZmM92tBys
	nH7SIidy/Hkh9JhFFZsvE2vyw2jnQDE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-HPcM_jgaPn6lzPba-PfXHw-1; Tue,
 19 May 2026 07:59:03 -0400
X-MC-Unique: HPcM_jgaPn6lzPba-PfXHw-1
X-Mimecast-MFC-AGG-ID: HPcM_jgaPn6lzPba-PfXHw_1779191942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BE47180056E;
	Tue, 19 May 2026 11:59:01 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D9BB30001A2;
	Tue, 19 May 2026 11:58:59 +0000 (UTC)
Message-ID: <e127781a-fd4e-4526-bac7-075f3c21a10c@redhat.com>
Date: Tue, 19 May 2026 13:58:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: zl3073x: fix memory leak on pin registration
 failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, poros@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org
References: <20260515193956.351092-1-ivecera@redhat.com>
 <20260519000526.3259243-2-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260519000526.3259243-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 5/19/26 2:05 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Looks related enough to fix together"
> ---
> dpll: zl3073x: fix memory leak on pin registration failure
> 
> This patch frees the freshly allocated pin when zl3073x_dpll_pin_register()
> returns an error, since the pin has not yet been added to zldpll->pins and
> would otherwise be missed by the unregister loop.
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index 6fd718696de0..a39dedac8b58 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
>> @@ -1597,8 +1597,10 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>>   		}
>>   
>>   		rc = zl3073x_dpll_pin_register(pin, index);
>> -		if (rc)
>> +		if (rc) {
>> +			zl3073x_dpll_pin_free(pin);
>>   			goto error;
>> +		}
> 
> [Medium]
> Can the new zl3073x_dpll_pin_free(pin) call trigger a spurious warning
> when zl3073x_dpll_pin_register() fails at the dpll_pin_get() step?
> 
> Looking at zl3073x_dpll_pin_register():
> 
> 	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
> 				     &props->dpll_props, &pin->tracker);
> 	if (IS_ERR(pin->dpll_pin)) {
> 		rc = PTR_ERR(pin->dpll_pin);
> 		goto err_pin_get;
> 	}
> 	...
> err_register:
> 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
> 	pin->dpll_pin = NULL;
> err_pin_get:
> 	fwnode_handle_put(pin->fwnode);
> 	pin->fwnode = NULL;
> 	zl3073x_pin_props_put(props);
> 
> 	return rc;
> 
> On the err_pin_get path, pin->dpll_pin is left holding the ERR_PTR value
> returned by dpll_pin_get() (only err_register clears it).
> 
> Then zl3073x_dpll_pin_free() does:
> 
> 	WARN(pin->dpll_pin, "DPLL pin is still registered\n");
> 	kfree(pin);
> 
> Since an ERR_PTR is non-NULL, would this WARN fire on every dpll_pin_get()
> failure (for example ENOMEM), producing a misleading "DPLL pin is still
> registered" backtrace and panicking kernels booted with panic_on_warn=1?
> 
> Would it be appropriate to either set pin->dpll_pin = NULL in the
> err_pin_get path of zl3073x_dpll_pin_register(), or change the WARN
> condition in zl3073x_dpll_pin_free() to use !IS_ERR_OR_NULL(pin->dpll_pin)?
> 
>   \
>    		list_add(&pin->list, &zldpll->pins);
>    	}

Will fix in v2.

Ivan

