Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652574BB284
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680787; cv=none; b=KukjJErDMv+WWLIYA4lq8rkOfXGS47RQwYT5nI9fXZzlaCnBJTODv0te5rgSb3DRSJJL6Z0MlOMb+4G3tTU72y10/JzAONqqDM4VW0LFCblkM7WvTUiRRjdvJ0zaFRWAIPFGq9Q8Xr5xmmHNLseEOrdQ1t4f09Ms3Gm7ABqTAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680787; c=relaxed/simple;
	bh=XH9sLH3jqE0/dWfCsF/FmunOKTDZA+dD9OsiDA3MbAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBKQY+GWHPBRvoAtdFvEAWWScCE7dyvr5I1zowQ3i0arD5KjTVmaNmH6h8o//shN5suRpqFx0VNAXp+8Aeu1ioef7bSGLR9bCz6xafUosrvAsmRxghUk8sUcVFv28+WMjgZsnX0O3ZmG+kVdNiMKRINtXi1DF9qxYcmewh1Y6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqAIswTH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkO1epG+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqAIswTH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkO1epG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790680784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2isVric10Za1n/W13Ev8nnpjUkrnpozXkUYW4Nb1a1Y=;
	b=MqAIswTHdrDFZbUOOZggt+wX+za8M2Hx0p5oBfb4d1/Kd++qWrMGItqWKQD2/6AKLIiiJN
	ttgsalMYOoMwJhtAz4fRYqUvOdfVEioSk3bM4TWPDKbAYgkfwK1a+VzyKQ9f4Vw9Mfcb+o
	aHAwPqanWwlpUlGz5YVkVE2lKwyWwYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MtXdDPiYOCiUeivPiPfNzA-1; Tue, 29 Sep 2026 07:19:43 -0400
X-MC-Unique: MtXdDPiYOCiUeivPiPfNzA-1
X-Mimecast-MFC-AGG-ID: MtXdDPiYOCiUeivPiPfNzA_1790680782
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so29664455e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790680782; x=1791285582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2isVric10Za1n/W13Ev8nnpjUkrnpozXkUYW4Nb1a1Y=;
        b=SkO1epG+CiL14CUo+m6MhtwpzrEVaYOyj3xR6vkQNSYIUtVgtdqrWMjKW2+sOzqGqT
         y5sZBezIdKLFP6xze7a9k8hRX/yg1f6tb7gS2lWadKh+FQTp127m7x/QgACCfOXc05j/
         RdB4xQ9fpFNv4zaf7G01UOBx8l3er1Rf9SVL0+Vo6ebOTeiulYghX3yfoabMnEFLXu4D
         5FiGU0IkADjGy+KaWrfF3vAtNtD698p3PQwEY1bHFXMQWV3vgAaCnuMWeikC3IZo2nRE
         eQVgAvPQtez5HaKUM9PKE3+KFqNukhyNBSLn4cOxTOgW4jjkYxVUZK2xMSx+HtEYwxP8
         zY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790680782; x=1791285582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2isVric10Za1n/W13Ev8nnpjUkrnpozXkUYW4Nb1a1Y=;
        b=cMW/E+DC8HqhPRruL/6TiEeQLLLznRCq0WG/aSpI4ImMhvz4Qkl0Vjrv4jTCipfIZr
         O24Tjqe+dY4cnekvDbXBczdbkBOH7IaKge2r63t8LVRSAaS6hHkuwYJpEA0n2ZDUjUGv
         wSrwWlkfl8ANqG2md8q6BBxiiCImZ3NVO5h4WOD6gulzyC3dBj98xulUCBfN5BbAK7gh
         uX8CtzLm2THpSFHv8F7l/Y42Cs+5E9Z7FVOEenJQkcIF6hjGO9ttKPBedCryLgv4Eyrx
         3ryuHTstPsfqkRGJ+UuksStjKO3ev8f5jNtM4QADuo2uKQJUIylaUTMfEFogw9lsfB+1
         UywA==
X-Gm-Message-State: AFuF++lyes8bH2CShY5cHzXxREuaq7wDO/83xtUQcgRAQojW2SW0QEFl
	tBhRBUi74gqGDHaaBm/JhtMIPqXtixg1ZqbfsZOeoqeQ9qk1r3s3pUPFlokR2h5CnlmocWwomoq
	Zu7JMY1pkMFv/3BWCTcezHq8XI4RNuSVDtCiO1AjzGbwHGP67EAvby0pK0rrTaB80RA==
X-Gm-Gg: AYBFou3tBo+wTA3PjgaP/txOsb9Z9rcHTyN28ub5IYyYvQiuEqCbrp12u+NVnkWhNkC
	xgNaiPd3piMQjdohL8xmLCVYyLb+4/KLtu5F3LIdfSF4ls5dz+lBbY4boBpE+swpG6+6F8RvnYj
	vBmsnsiW+IX1qeArolePjQoi1chvGhfia3eaQFzhYa3+ZgW3tOJTY/V6x2XC78niH4F1FArtxsW
	oPRAjsZTNwU5agJOp2I6DPCtof9ypXuQO3yOHeUGdfHH1wMSMK9EuV8UpYAUSpUpYXw/28YPOyN
	myBbA+/p5hAi09pHV0k2fEWJZ2y7uLDEI/fxX3oo78ombui6e/NbXg0MtomRiYgLqVZcs+AF0iQ
	8SnkS1XX997C/Tjb7Rci7+F2SJydPlc2UJgxwNmSw6vuQsn96QEW6Lg7jqztSWcysyLKdOe8P5w
	==
X-Received: by 2002:a05:600c:870e:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fe670b208mr288528125e9.33.1790680781870;
        Tue, 29 Sep 2026 04:19:41 -0700 (PDT)
X-Received: by 2002:a05:600c:870e:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fe670b208mr288527525e9.33.1790680781428;
        Tue, 29 Sep 2026 04:19:41 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf4598esm75102415e9.0.2026.09.29.04.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 04:19:40 -0700 (PDT)
Message-ID: <53c1812f-993b-4028-8ffe-6428113f5aae@redhat.com>
Date: Tue, 29 Sep 2026 13:19:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: use two lockdep classes for the
 netdev instance lock
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf.kernel@gmail.com
References: <20260926041832.1649675-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260926041832.1649675-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/26 06:18, Jakub Kicinski wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0db..a8eb382f40ca 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -568,6 +568,41 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_PROVE_LOCKING
> +static int netdev_lock_cmp_fn(const struct lockdep_map *a,
> +			      const struct lockdep_map *b)
> +{
> +	if (a == b)
> +		return 0;
> +
> +	/* @a and @b must be of same class - both virtual or physical.
> +	 * cmp_fn won't be called for devices of different classes.
> +	 *
> +	 * For the same class only allow nesting under the protection
> +	 * of rtnl_lock. Note that we can't use lockdep_rtnl_is_held()
> +	 * here, it always answers UNKNOWN from within lockdep.
> +	 */
> +	return rtnl_is_locked() ? -1 : 1;
> +}
> +
> +/* A virtual device can be locked before the physical device it leases
> + * queues from, see netdev_nl_queue_create_doit(). Keep the two kinds
> + * in separate classes so the dependency graph enforces the order;
> + * netdev_lock_cmp_fn() then only has to rule on same-class nesting.
> + */
> +void netdev_set_instance_lock_class(struct net_device *dev)
> +{
> +	static struct lock_class_key netdev_virt_instance_lock_key;
> +
> +	if (dev->dev.parent)
> +		return;
> +
> +	lockdep_set_class(&dev->lock, &netdev_virt_instance_lock_key);
> +	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);
> +}

Sashiko noted that mlx5 IB should enter !dev->dev.parent code path and
could possibly need a follow-up.

/P

