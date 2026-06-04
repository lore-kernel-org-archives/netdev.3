Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB60405C45
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569913; cv=none; b=blQ1OypdGud5gMtpmopRQOLYXqndBk5STaLuviI/fQMLYLkrgYElzHZqGYHf7VjXNQuRbBEYDF79R3cxG/6aZwvt/AX3vl//RAVczv6A0miZEqekxyY1U/I3A6t88WM0FqdfKgP5tOyQ8Cc72r/c1K8DI6iviKdP3Wbvi1GlCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569913; c=relaxed/simple;
	bh=pXOC3ieQ42cIu2RuSkFAP20upsmn2zTEUHKrLTllEys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fA33R2O1sKn+NaIaT9c0FRasuFmmh2oQyDivOOO+oDLzDAfeMxdN9TXYXp1+ZFhVDLZYLf1uFFT8tfIc+D+e3f+0SmrrRCNsug4VvRmZ9cQ/We4tn1vY58bqBizMIqRE/c/sG3Dn/Bg73/mp9VE5GP//DKLq6Hob+Imv2p0Q6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b46L+aXq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbaR1EaB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b46L+aXq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbaR1EaB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsaCU5Vs3pFhS9fw5gs64Im6dVDjZtVePKSfJVpfmE=;
	b=b46L+aXqwLVX1J0jH9FpQozbT9lQBxt0fM3XW2CuIwecb7blFQ9afjs4DmCxxJc0A6IOlK
	wzdQ0FM16OBVI2pz8UEJlZOy49gMrDTAb6N4KX4mqDkvy6UOYVS9ZYVSmUYF3RamBsFDWR
	5W5Iy4hojFrCgwBoVunA4mhqj5eTbRM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Y_3n-ANgMkemzzPADHAarA-1; Thu, 04 Jun 2026 06:45:07 -0400
X-MC-Unique: Y_3n-ANgMkemzzPADHAarA-1
X-Mimecast-MFC-AGG-ID: Y_3n-ANgMkemzzPADHAarA_1780569907
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso388492f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780569907; x=1781174707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbsaCU5Vs3pFhS9fw5gs64Im6dVDjZtVePKSfJVpfmE=;
        b=MbaR1EaBzuQi6kWyyyeG9yiP71rnPBoQpA6gULTMXy1ppsS4fGeiTBJm25xmOm08+S
         LJL/Sz8X1F7m/ulP5/h2bGXSmbbJPZ+A9y+x/IuI9ehTPqYfxePshWe34T/FjetoldbS
         6dj277tA8Z9ior2ExYwd/+GcXNpNQzcGz2go0jxlJEQrtTJXtsOdSgSj6boy9bGvAxXS
         5maSIIHjmwc7OviPWvkoe1Vndaf+vN+m1pGWzn9hF5buM0Xugc2xm9JU/XcrlDgKzq94
         1JDxueuRI3KC2Efk/6Zgc2RO3vHUQLyqfvEtv0Y8vCYDl9o8qcLXAZ6v4SVZVLqWCaxw
         iqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569907; x=1781174707;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbsaCU5Vs3pFhS9fw5gs64Im6dVDjZtVePKSfJVpfmE=;
        b=O7Z9J9Be49LoESeiBQ5UT0ZZVQvbIFpGRKixAIO/TTe3XjLwdj9FkPmqTInc2Ye39T
         HoQxwf3jYj/ZDSW5XDdI9CTUJq08F4AshxwBqlJ3kRJiTMbXZ49NkGnMAXLKCYX54HSD
         P/lZtOTwCwsf67dDC03IebIvHK4FH41SUwIQ07KN/qaJL4XhDpFAaGpGHW1I675HLGnT
         wATK3L0KCFjdyq8A5Z0WuEIz/J1DSQrA6DtodfAeLepP62bzDJ2CJwUjWDOrEEJ8VLkD
         ENUMknbKyaMlyrNEXCV9Jq/Bq2McSck0N3DEY2FK72WD3NQSj6urHYeEDsXCKah0Pu3o
         5q0g==
X-Forwarded-Encrypted: i=1; AFNElJ/f52ItjVWdlGi65PkTRSO7o5s+oqGlDcm5XV8bQfezQw5sNPEHYbj7TJZq2gFpzOFbEo5cscY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxDAm6MPph1ZlfaoqHQRA2MaVK0ouTm7STjPBk0Y/MmagFTvM
	3T09sCKI+kNI79Vs6vMJsMyGlDyl0OeVpIZJ2w6x72zkjJ1x2icyx15OXziM6OLs3dVupTYcg31
	EcFp69VRs8MdooSZgeQvhfaUZ9/7SMbWk2XEXzV9/mOFme/mWmy3eSgRomA==
X-Gm-Gg: Acq92OG6zT1gxGM0BWbFGT7G5Fq9TLjvw2mlfbBZ/d4uIBGs1RLQ1CjKVFXdMXkkkOn
	PxmuzeQ/GRH8ZLZGXCq6AmcAjNF2qh/CGZctuLTgNaAuWzDRvDuN8to0VimLTDU9eNkfQIHX6pK
	Yra9TV//kkB5Rh4ztgFnG6PO8ox8glFUlvosiiurWiwBy8654DZ0Th855Jwx6kQeOh0HdNX3nAj
	EYaRNSYXVA9MU1TzoIT6ZcV8biAq3tMwKjBXnNiJ29T/r6v3lWCkHpRcPb+QkH0mq2dClGxOKpz
	El42x1zbULXa07kiqc2AIU6Rs/TXD7ncU/sqB1e2D02TYgbSUdQPk+rNgTXq28qgZgvSmKPk05j
	tfH/1R+OErYqyhX3F1uEKeSKw69IHXuLlWMGsu0ljOv8y4uXE2FSOkyfDIAHHkmn7kjQ=
X-Received: by 2002:a5d:630a:0:b0:45e:e44b:3147 with SMTP id ffacd0b85a97d-4602178318cmr7176628f8f.5.1780569906580;
        Thu, 04 Jun 2026 03:45:06 -0700 (PDT)
X-Received: by 2002:a5d:630a:0:b0:45e:e44b:3147 with SMTP id ffacd0b85a97d-4602178318cmr7176572f8f.5.1780569906004;
        Thu, 04 Jun 2026 03:45:06 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm16588064f8f.5.2026.06.04.03.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:45:05 -0700 (PDT)
Message-ID: <6d1fa9d9-73c2-48b5-95a1-51710d81b3ed@redhat.com>
Date: Thu, 4 Jun 2026 12:45:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu
 configs
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Shiraz Saleem <shirazsaleem@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Yury Norov <yury.norov@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
 Shradha Gupta <shradhagupta@microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>, stable@vger.kernel.org
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 12:27 PM, Shradha Gupta wrote:
> In mana driver, the number of IRQs allocated is capped by the
> min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> than the vcpu count, we want to utilize all the vCPUs, irrespective of
> their NUMA/core bindings.
> 
> This is important, especially in the envs where number of vCPUs are so
> few that the softIRQ handling overhead on two IRQs on the same vCPU is
> much more than their overheads if they were spread across sibling vCPUs.
> 
> This behaviour is more evident with dynamic IRQ allocation. Since MANA
> IRQs are assigned at a later stage compared to static allocation, other
> device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> weights become imbalanced, causing multiple MANA IRQs to land on the
> same vCPU, while some vCPUs have none.
> 
> In such cases when many parallel TCP connections are tested, the
> throughput drops significantly.
> 
> Test envs:
> =======================================================
> Case 1: without this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
> 	TYPE		effective vCPU aff
> =======================================================
> IRQ0:	HWC		0
> IRQ1:	mana_q1		0
> IRQ2:	mana_q2		2
> IRQ3:	mana_q3		0
> IRQ4:	mana_q4		3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU		0	1	2	3
> =======================================================
> pass 1:		38.85	0.03	24.89	24.65
> pass 2:		39.15	0.03	24.57	25.28
> pass 3:		40.36	0.03	23.20	23.17
> 
> =======================================================
> Case 2: with this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
>         TYPE            effective vCPU aff
> =======================================================
> IRQ0:   HWC             0
> IRQ1:   mana_q1         0
> IRQ2:   mana_q2         1
> IRQ3:   mana_q3         2
> IRQ4:   mana_q4         3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU            0       1       2       3
> =======================================================
> pass 1:         15.42	15.85	14.99	14.51
> pass 2:         15.53	15.94	15.81	15.93
> pass 3:         16.41	16.35	16.40	16.36
> 
> =======================================================
> Throughput Impact(in Gbps, same env)
> =======================================================
> TCP conn	with patch	w/o patch
> 20480		15.65		7.73
> 10240		15.63		8.93
> 8192		15.64		9.69
> 6144		15.64		13.16
> 4096		15.69		15.75
> 2048		15.69		15.83
> 1024		15.71		15.28
> 
> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org
> Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Why do you consider this patch a fix? To me is a configuration
improvement and should land on net-next.

> @@ -1717,11 +1719,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
>  	return 0;
>  }
>  
> +/* should be called with cpus_read_lock() held */

Minor nit: s/should/must/ or just drop the comment, as
`for_each_online_cpu()` usage implies that.

> +static void irq_setup_linear(unsigned int *irqs, unsigned int len)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (len == 0)
> +			break;
> +
> +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> +		len--;
> +	}

As this is another heuristic regarding irq spreading, why don't you
implement that inside irq_setup()?

> @@ -1767,13 +1784,42 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  	 * first CPU sibling group since they are already affinitized to HWC IRQ
>  	 */
>  	cpus_read_lock();
> -	if (gc->num_msix_usable <= num_online_cpus())
> -		skip_first_cpu = true;
> +	if (gc->num_msix_usable <= num_online_cpus()) {
> +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> +		if (err) {
> +			cpus_read_unlock();
> +			goto free_irq;
> +		}
> +	} else {
> +		/*
> +		 * When num_msix_usable are more than num_online_cpus, our
> +		 * queue IRQs should be equal to num of online vCPUs.
> +		 * We try to make sure queue IRQs spread across all vCPUs.
> +		 * In such a case NUMA or CPU core affinity does not matter.
> +		 * Note: in this case the total mana IRQ should always be
> +		 * num_online_cpus + 1. The first HWC IRQ is already handled
> +		 * in HWC setup calls
> +		 * However, if CPUs went offline since num_msix_usable was
> +		 * computed, queue IRQs will be more than num_online_cpus().
> +		 * In such cases remaining extra IRQs will retain their default
> +		 * affinity.
> +		 */
> +		int first_unassigned = num_online_cpus();
> +		if (nvec > first_unassigned) {

An empty line is needed between the variable declaration and the code.

/P

