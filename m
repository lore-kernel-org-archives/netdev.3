Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF646EF8F
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787232928; cv=none; b=kmrPBd7xKBvpmNGnQTxccSaYezYMOPiUU/6IRG3YKlnaDCEiXB1HEU677pAI+FYc9b1+5Oubaq0yj8EwbiPjajtmzecxIDyo5TnfoVyy6Cvg6edoLe8Y/6fK+J0GcZQ3CEbBdwwhtXtDahqutIe9FDhsaKMMjU4mezsD/9zKzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787232928; c=relaxed/simple;
	bh=kv56IyJSLXDZDI5uGxyXhKo01hT3IEvuWYBzTOT1q4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6hpVTi4ZLQ8bvxUK7mIaAYSaF+w/phtftabcENB/AUNkn1Bi4km2Ga5zlvIL/5fo0hfDmVCG4vGGxDsfYQAvSGN+kQyUON701zpYXoaqDnozfjor+5NHGeL2dYqJ/Dj9/+I/aBBMmFaU58l6MLp2rIxTOD9ltp4cBpEcxEgJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdyCpycO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLijHh+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdyCpycO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLijHh+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787232923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DENzyJCbPVumPD2NaNVtKm7SHktzDEBfRWzZ0RiuIUs=;
	b=TdyCpycOWQfzycshiKt6hyTNTupufXDQpI8TlwxFm/u6YVuFlNZWr4h6o6b4kcX288ns10
	tfpjmFzgsshKzS1cSGeKEQIsIshhhfZjZpM/37i6xoOfHNcOZInlV+TmWiwV2EFNjb3ty9
	RNKAJuZX1ddkxuel2TXBTPHjN1tPzv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-NbR3idiOPwSpj0-epFaTWA-1; Thu, 20 Aug 2026 09:35:20 -0400
X-MC-Unique: NbR3idiOPwSpj0-epFaTWA-1
X-Mimecast-MFC-AGG-ID: NbR3idiOPwSpj0-epFaTWA_1787232919
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994aebe932so27399135e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787232919; x=1787837719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DENzyJCbPVumPD2NaNVtKm7SHktzDEBfRWzZ0RiuIUs=;
        b=JLijHh+FlXLtvnIxZNehugDb60h42lJaKhup95CPxYqPoGwkqeZGtlCO1QJADi6Aj7
         Q8J4xwiIiQbH2nuk1ZtlsXDAPyIGjTvTcKtTVin/6rzp7+XIdHNS+TNy8DzC5gtUDz0/
         fnfetDrHaek1pGIefZsO5kaPoYAOulLsH0XbemHnxwukakIxEKHnSoQPyAWD454taA2W
         8Lsmk7UT5VjFNpQnSW3VcxnRvz26LCausMjdDy4CJ/niIgOj7QUfe/1VjXQd6AfWC7o/
         obQo1mAz3A0uGkpnTvbrF8mW8Z2dVv1ziwL4dtopRb11R30nsoqTVV7R/eSPoNSKVSiJ
         i5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787232919; x=1787837719;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DENzyJCbPVumPD2NaNVtKm7SHktzDEBfRWzZ0RiuIUs=;
        b=CPCm++xAxeAT1+lPuxKvo2shF2mMhoXdbP4DKlh+4bz/FrdXE/YaSbF5kJDDC8IVOG
         0snyN/JV5twAAxF5cfiWdIt6zWLLaGtot4yOnv+Fto01PD7qFsnCXQBZb9qiI8eHnXNr
         5fVjDtxxbE2CmYkA1gQ6dYdt3n8v6CM6OOGJqy90LezK/bX3vsHUM2i8Vv+/N+WWYuyT
         bpGD1ZiMODVrbHNeiDzWH+WxzqHSqPSwAYqfxR/3DiP1LUSRVOaAwafv7q62uLTAaqt5
         Q/3PLdBK1LZA3nTREYPLpuQUWZLk0gvrlwGpNFOtEIfCK2UN1ivWWobELqKJAaG5y2A4
         u58w==
X-Forwarded-Encrypted: i=1; AHgh+Rq1IirttAkJqpmxFUtpozzyQG091VNqYIbBrQA+JFrjITPViEpKTswzIacD0qe+oE/cp0cnI5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPzi28HRLdnroVSlX87EpjPhloiKUO/xjimy+OMWR6eRMBmyN
	RIFSnXigvA66BrKxKNGRBNu6WW7s1uOcSp0FzGOqMCrw3GM3t1A8fZ+Zbh+zzszFEc87uw0C9ES
	4l98PAN+cROxpTGbY4TNAIwrKTKc44ZR3tvusUab7vbxNC+QMTz5afk895Q==
X-Gm-Gg: AR+sD11UVAiJD7oLntDYFaa2GZJmeW/XH/5XuHsvDvWsbIpAWLSURgYlWOgpVODUPNw
	eAKfGYXHA22oDDYAnHw6NqUV4dcx5ZgAA+6S0qF2r7OBM83dsHSNyRswxe3p4BE+PRIkMdPdADg
	SO87MZ/q4jVPU9JHlXYP5629L+UY+RzBxjw8+PoVu6vwDOcY2JjTIRex6sLD/BCD6oP61NtM/n/
	X3TohWc08TFs0X2UQgTrmrXGbYVaGx5JmTtNfqJljhS7MmJkuKwHTb6q2LMpCSuTHqLxAq1iddZ
	GvcKt0Dcgri3x2x5TEJgFA5IhWoghlZKq8e26+Siko5D7FnxAkBFnjgZ01o/NOC49x9TxGo9riT
	8PUQvl4Ls0EOvRMsICAf9pjhUHkLT5ZaDaqTnkRg+yaw5VDs91T81f7y/AwGm07RbDxiAQSTBbR
	Q=
X-Received: by 2002:a05:600c:8b32:b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-499aa200efcmr243535725e9.14.1787232918946;
        Thu, 20 Aug 2026 06:35:18 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-499aa200efcmr243534265e9.14.1787232918443;
        Thu, 20 Aug 2026 06:35:18 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d0360sm12432273f8f.33.2026.08.20.06.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:35:17 -0700 (PDT)
Message-ID: <b258cb1e-57f6-45b3-8d3a-91d3e2727eed@redhat.com>
Date: Thu, 20 Aug 2026 15:35:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: davicom: Propagate wakeup IRQ errors
To: phucduc.bui@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260820111548.97990-1-phucduc.bui@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260820111548.97990-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 1:15 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The wakeup IRQ is optional, but errors from platform_get_irq_optional()
> are currently ignored. Propagate errors from the IRQ lookup, except
> -ENXIO which indicates that the optional IRQ is not available.
> 
> Also propagate errors from request_irq() and irq_set_irq_wake() instead
> of continuing the probe after the wakeup IRQ setup fails.
> 
> Found by manual code inspection.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

