Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E20439F90
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010893; cv=none; b=c2D9gfQ9tjz5Uh2in+FA4LHyaNSSM6DoPX9rDXcgAiv9bBybZAP4mtOWX/28L2ekaMn+AuYXuHjQYRaafkCMd8e69xHDacJUT3zFR60LmleHSZQGkqwrqUKbi2mWNddFt6zYHeDWAwqyU5uV3UZMyhCvdH/UVUKJjCI1gy9gcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010893; c=relaxed/simple;
	bh=iEsjQhRi801AJkEUAaX9s8GzQmbuw9LKcr9UyleNKMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz6u0MeKBF9w2fg8FKZG+oSF2N9KFKu3K957Biv0OF0+oo+Y4eJGlrp2SVPyg+i50Wu2IPjRqi+RnfpF50aYnPd7vKoph1PJc8EmwHGXhm3Uw2++WzIye77aIux28laS6NkpwMYIqXytWVmGJiSKofk8VmhMemRRV4ZbLl11GeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQqpuE65; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OStu+iHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQqpuE65";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OStu+iHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786010884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhZld27+M+uSfFp/4mUcI1U/RKA6sGB9YBQVMpH+L0A=;
	b=aQqpuE65T6EJfhifQXSr6PtHR9oC0sTfW70Hl0I94sxHZBSLeczV+dmUp4HMFbWX4xJATQ
	HeMVB6zk93UVrZvJ7lgtJhZB5FFDYt7JKPV9NxiBHyfFoeqerg45Avy9bZPr/R6eXh4Kei
	1wJf8cS8QYhvD5XQeMBHwACcxvzcCvk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-tSdltyPBMJ6XLMLcTQRXVA-1; Thu, 06 Aug 2026 06:08:03 -0400
X-MC-Unique: tSdltyPBMJ6XLMLcTQRXVA-1
X-Mimecast-MFC-AGG-ID: tSdltyPBMJ6XLMLcTQRXVA_1786010882
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4740be00302so1611346f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786010882; x=1786615682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KhZld27+M+uSfFp/4mUcI1U/RKA6sGB9YBQVMpH+L0A=;
        b=OStu+iHcCFETz6KOFG98nVlpChzpzpJ4hqSZ8dJcv/4AzXP9clboJmQUEqW4c97lCD
         UWCUqCj+WG8JJ8qfNTENrytxwBPQxnpdTmcNAv6DQRK/L9w7gTx15PSysk5ty8PA76gZ
         2g8CZNDpoLl2hNYgLt3iloNA58wOitMJqW7Xf4UzI2Sl8os4ahjvSWW1AQNhMfvgi4Q2
         j88kMrt+7F8wagZPahxw+vnZX+2SwYnFRWqnPmBiao2f8B9bi+152seKlzFmyhPclsyk
         cv6fcauiL4gf1UPMI8chJj2TPJ+ZQVw6K1aJ10GrZMWNUTpEQbMOhfvFlJf9FO6QvDIR
         TC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010882; x=1786615682;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KhZld27+M+uSfFp/4mUcI1U/RKA6sGB9YBQVMpH+L0A=;
        b=iQh2zZoZl2frW4KvopSCglxSyxJ2IefjOBRl412vEsevRXnyyE68fith+Jkckkszmu
         OHvUn+0kBLXC1dzo/NSZO8I8ymuisVGfeNwcs/lcagK+3X1fNLtntAl1CX9JGM4Az+Kg
         2RyRYAshAtGFkC2yAPY0mEMS+INGOa6Ip57FcKDipoRAMF7FxYJlC5yCJ2JtWaaOrX9e
         6vyIBiFcLAR4S8ZvkaWDIY7fwQn7p9fqar8O0qZ/iCc+IL4FVvzON/DR5PmCxlY3ZrV1
         it5IE0xShsDOsgsJH3lBEgfNRlPKAmF6GmFEeeuoou2/ewTgaZ0iMgt349vlNSGDolps
         QRfw==
X-Gm-Message-State: AOJu0YwXERcxObVkOR5rFzc51cUG/EKuQFCW8FYmwb9f1sFJ92fBuGyA
	RSQSu/9AiRKWEsK0NFdZH90mzg91NjjcieDrZfW9GpYdm414uopJjl3N350P/VfR4jOJB4ieCLH
	FFI2iEOXBoGrt4WE5vLTt5uc7CweWvplVoIOi+xlYKFZbdqIiZ4U+AHsc2U0l+h1iIQ==
X-Gm-Gg: AR+sD13vavXlG281M55XG2EtIWGt8rUOlFesaOliTSYhbJzKLe9Lo3U1FUyMz/6LUVU
	x1O1mJTndxD6jGX9hzaxhmtvZshNQdI3uThZSfKlLhqqzj3kpkopjcCfhAoja3yN5e0qWPvmqAz
	a9d/EAKzO5UNHPFMN8ihVqbja8BDPxKE6zzyfC1SBeiiyFEl7uCpl9fvxy0FcFU55YZwHOXUBzh
	PcEEpJVgbk/8umnDVxEEzCgWFkAGE4AV6S/3zlKCb17ukFng3asKm1PthA8ATZy1oa0S0kCx1c6
	yDjvNFQNyF0AuFAOrpHxhxmGXV3NPAm03KOgub4yFZINfw97hsZWImLX8/qE3pRmliiyXhDVZCe
	BmhaEPXQHEh1rIHotTjf6/UJDVpz8uspEUHFKesJ95OsEBhz5pfPOC6LzzDhA4rINk0J33JKLqc
	k=
X-Received: by 2002:a05:600c:8010:b0:499:521d:bff1 with SMTP id 5b1f17b1804b1-499521dc012mr92037245e9.2.1786010881760;
        Thu, 06 Aug 2026 03:08:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:499:521d:bff1 with SMTP id 5b1f17b1804b1-499521dc012mr92036505e9.2.1786010881353;
        Thu, 06 Aug 2026 03:08:01 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49952d16496sm24832495e9.0.2026.08.06.03.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:08:00 -0700 (PDT)
Message-ID: <a4b4b8c1-6c6a-40d3-a8f2-727407b0bfa2@redhat.com>
Date: Thu, 6 Aug 2026 12:07:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: fpe: Add missing return in
 stmmac_fpe_init()
To: muhammad.nazim.amirul.nazle.asmade@altera.com,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260803032358.16282-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260803032358.16282-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 5:23 AM, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> When FPE is not supported by the driver, stmmac_fpe_init() prints a
> warning but falls through into the pmac_enabled initialization, which
> should only be reached on supported hardware. Add the missing return
> to prevent this.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> v2: No changes. Collect Reviewed-by from Maxime Chevallier.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index 2f880c5e35b0..3436e962a238 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -174,8 +174,10 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
>  			  &stmmac_mmsv_ops);
>  
>  	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
> -	    priv->dma_cap.fpesel)
> +	    priv->dma_cap.fpesel) {

Sashiko noted that the above condition does not reach the intended effect:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade%40altera.com

Also please be aware of net-next commit c82ff94592fb

/P

