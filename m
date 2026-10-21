Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592567;
	b=wXQjHpptnxeBXz2LH4Ih8qDf6GplTqTkTI5tYUoa5akFaUEmj9NQdkrBqAzxTTWi3oMB
	 a2HunALHp495CCGGFJLQirqSCE4FiiyTualuXBtvG/cyRlYjmnX1WW6HvDtNEPr76m1XU
	 4GF2qFz4jvy936DJYgDZTQXH5cgogopCmUb/WMKz7P/qP71iF2deGGjjwfiunrG71qJFd
	 hsuY14OqJqczf1lXsanPIAG5Zw+k3n0nUck442K+lMx14DXZOibInQrdCTJOcXThpmWnp
	 ZbLXyDL7nPYrc/IpVqXWQhfunC8Ya34rUUFbGuw9icVjTneWMJshmUuaAFZfJ/YWyyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592567;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vk57SPWS/t6RVGCi+z0GkTQpZ5fp3N6nbyO7Mh1yZJk=;
	b=0OI07GxtMr4Y591oTRR8E6IMGale13Ms0gWQGrDw1QIrKoJNd6PfF03wve+RfcBYEs5d
	 +1CfzxcYQset65CCaZBxUoc6QKFtMR1W8uKX4CeVwAzlFRGZnUTNaSQ6DIqSE5irYat8J
	 5W2JeWmMGPmFkJO/3TTe6OCMUvYWoToduDi11HYsVHKwlbnoyvtueKEXjRHdjzvlQj1Fp
	 ohXlqnhH6QLrGsnbiEH8Kw+AJzt/BnCEdzK+RrOT9hvvnmBGyw9428BXM8kJSeadzIdQF
	 fj6F24D4kHrWxSgMvX9M0CscDpunUiLcUUUNCZBtPulA1oleilzVJH5ePHqhVjLJwbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KtRJFCGg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cvCd+Hyc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688060A260E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B688060A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KtRJFCGg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cvCd+Hyc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792592565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vk57SPWS/t6RVGCi+z0GkTQpZ5fp3N6nbyO7Mh1yZJk=;
	b=KtRJFCGgPZaDTVPYK4eZ7ikkgMCVfv7zWGCpbrlagFhFYZv+cp2XF6g3XXWufzuqWRyr2E
	YRQ8yh+Uojb+PeURSNSS17vsN+L2vqXDAVCuG4FuBb7O4ncJ3ThDBtRVx/bteNDar/1b9m
	YuWzElThicVWMT4dxLIbdSx0L8xp25g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-wHnzPjXeO1et1yhLqI0eqg-1; Wed, 21 Oct 2026 14:22:44 +0000
X-MC-Unique: wHnzPjXeO1et1yhLqI0eqg-1
X-Mimecast-MFC-AGG-ID: wHnzPjXeO1et1yhLqI0eqg_1792592563
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so7161725e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792592563; x=1793197363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vk57SPWS/t6RVGCi+z0GkTQpZ5fp3N6nbyO7Mh1yZJk=;
        b=cvCd+Hycx5ucC+lrH0hgSmmBnWOPeryZAT6Y+HpH4mnV7eqCa/u9cSW8CMwDvf3Eyl
         erVAb444YVYbNYVaCEWwXNDkZCrRK9wdHdw76T3X8vL53DumnEZjXbYUN78ul42b6xeY
         JBuEJKZ/RL1p3ssT1nOULRa3tZUKUSnuwHKMELDnOcRh4NSkXKuPjc9HYInGV+Tt8bn6
         XsvjR47ADTHQGyvAHzv5/6JvdGg4RQJOlD3Z3T6+z9ejcOXEiAvJggUjll6kueStd2PQ
         796S3cjMRyzSwoNuyP07IOVe/hjbipARwp9092q1vM/4lukE15nqGgk/2v/4Y0cddY74
         /0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592563; x=1793197363;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vk57SPWS/t6RVGCi+z0GkTQpZ5fp3N6nbyO7Mh1yZJk=;
        b=DDvmB8XZVfmsBKblQMO7zcHhnNvxuXIZwqIJRsJf0oR8OddrBo7P68S7oWlSJZ5n0Z
         Z33QBn9Skyj2mz6SRY7x4XbcS6/qLmE3Xsb1hjlj5EVidf8InjYwRcrunkzAJvPKPuan
         FRiJeZ0zr5iqgLQuLhv2ucrQIHrFvqJbb7cKKbU4norpf0F2W6QkBH1byCAvHUHUtyJ0
         IDGsE0jQJ6mYJ0XNrJ7iTtDjD/vBR8860xx9g9Z/yJe1xNdxsp7oduAZZxuMWbeMMZ1D
         qReij/pRVVdQOd+KZRg0rQI8sErgt9N3ICjlcUNBlRXHQAnnYRAbkgDrKqDi37ah8NVj
         DXPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXippUiW+6FIskWdY03xgCyASixFO+28KFDfPTPXs2EVmWpYDkT+QRwBaMj0doKyPnH2wmH8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHrHBD1Z2k7ZIkFtWtceSEW6FjefYZPpKO7D+VR42lrKncM++1
	HE2nPrdeMOIgZ+0dshsB6WOaDQsfcBiA4Gq9vSAvYiaTZm+0xBR5PJnyGOR6qnjpgbYsOcsBQYU
	pe3C2FnpMBlDcuiQZFReYRcyRDhUpLFva5xU5DpSWMxoh9qp9RN0QnA7Kww5XZ5qbFQ==
X-Gm-Gg: AYBFou0qeJXfveC/n2Tb1Tyw6rN242ogoLW6rfEW/Lkj8yzeshULww5usZMDtnqVedr
	Za2SgquFbLvv2fAVcFlRXarAKIcD1BF1pBYiN/L9qt9UJwUVfE1Hb7fCT7g19j7cOrljAcY9NQi
	XaDL//n5yoq7PtsudFp9LMa/NClkdViYoAb8+ywmx7ifMkNEsDoIv7b/LW4D0p/c+EnjvoYhFVi
	5JFE0EZp7wct2wa6YKxcHvUk1mZ/DMtmEysIbQprSoW0MKGBOCn9YCMmAoKqfVsy9jbWGlxt/WL
	iNgKbnqH1EyR030LZPBhcJVxJVekLVjIOIrn37kwWHpZ2XwXWw/T0Q3yWZlwklFtnyg5RcoHzQm
	rL7u8q1zauljKZnB7DPpgxJzLPRc1i1DPegKnD/qvnvZZZIrGK4U8+mkl1/ZEuWjrNFK8j9Wxew
	==
X-Received: by 2002:a05:600c:3b82:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a1fdaf7464mr52006185e9.7.1792592563014;
        Wed, 21 Oct 2026 07:22:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3b82:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a1fdaf7464mr52005605e9.7.1792592562546;
        Wed, 21 Oct 2026 07:22:42 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ca3666sm170631885e9.1.2026.10.21.07.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:22:41 -0700 (PDT)
Message-ID: <3ab59725-e34c-4243-bc72-d93f837bcad1@redhat.com>
Date: Wed, 21 Oct 2026 16:22:40 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net/sched: drr, ets, sfq: skip empty
 rounds in the deficit-refill dequeue loop
To: netdev-bot+sashiko@kernel.org, victor@mojatatu.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 horms@kernel.org, sashiko-bot@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <QDISC-TIAE.v2.r0.20261015163454-1@mojatatu.com>
 <179244597608.3135.14866688728455017187@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179244597608.3135.14866688728455017187@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/26 23:39, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] drr_dequeue() and ets_qdisc_dequeue() allow only one bulk
>    refill per dequeue: `scanned = true` is set at sch_drr.c:414 /…

This looks legit.

Also is would be great if you could somehow deduplicate the code a bit,
(but I have no good idea on how to achieve that)

/P

