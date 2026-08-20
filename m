Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E43FFAD7
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219004; cv=none; b=QWlOXeT5yXhS58TKJ5+rEjzeJZ4pPji7zYHI9OGRnKAVOp7GZuXmKFowdruU+BzVQq2tIp0uTzTsI+j72IsuBP54Qc+bqA0aPNsMipyy9cUL/UIZ/NozmJSDsdGsx8ACPDf6obZENMD1uQwpOdePL/hhKey6WviiZGrzUcQOR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219004; c=relaxed/simple;
	bh=2Se/R1PDY8b8PnlIAoeqQwyOTNnaR8VcPQQ+lAxAWxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzJ8JqTQ/UGg13s0ywT74Dina56p9h7kg46SwNSQiknOtD8flqUPLPxLOePWfwR+7y5oQumzw59xuqhW9Pl3eX371N/9QVJUAH97dZUClTqko9VwSxQm1qFWmk4oxmdRQjYQSRmmFa2xvQP3dmBhuxnoNZy7dmjOPcB+Jwg4SCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVhoz4zt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5hH7Hnf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVhoz4zt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5hH7Hnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787218995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u2zk+UMLCr8IYSxUT7KHSPV+PCcsMNjHBcMIg9fE3Q=;
	b=AVhoz4zt3L+Q0IOLqMpTqdr6PfBPfMsQCwI5H73Gs4xP5FRcdbmR6/uJHjCnm9ujAZUHgo
	r6HqKCT83bQXeq3iTYIMeIADAM4ZADGHmmHssuEQsqxFCZPM9mrRt1NKDwoRJcIP9gj4qq
	Ni9AjpPUR2LjPQA+ffEodp200RAvPiE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-K2cGQr82OLCf-Je8sDes5A-1; Thu, 20 Aug 2026 05:43:14 -0400
X-MC-Unique: K2cGQr82OLCf-Je8sDes5A-1
X-Mimecast-MFC-AGG-ID: K2cGQr82OLCf-Je8sDes5A_1787218993
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so18667345e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787218993; x=1787823793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8u2zk+UMLCr8IYSxUT7KHSPV+PCcsMNjHBcMIg9fE3Q=;
        b=U5hH7Hnfj1hY15z409ptf2jnR8OiSUC8zwUCFRtJFIxWfOyJTvaBFdhPBXWh8X1VaZ
         jXsR+O7dmO3vAkb9KlzCisthSxIQawG/PBUpoFGyEs83v8MAcfLcETkO6L+RDFeQNAJB
         cK8VzL+ZGRFZ5UabyaG7kiz+UYrfi54hke+XiNGmtTC4hC+h6DmZkw37GdAb4PcyLgjF
         rSUmSnGfrcRDnd0NrS6hrECSYmX27e3+v6PNPVLXpZTVuAiWRKi9QqNTjHJOfMrtUfs0
         WDzLdvZOS1dJBvdcN0t63u+5wgWqdqIkPa+MMMYbDip4a3YZSr35N9uAY45ZxSLPIRkq
         2cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218993; x=1787823793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8u2zk+UMLCr8IYSxUT7KHSPV+PCcsMNjHBcMIg9fE3Q=;
        b=jw30BHAu3FMWBklRTCyusnx9zwLEo/geVmGIIKuYdyDbpUoBGkMv80UH+F97rkfKSs
         d74IsekcLfyszaKyqKR22h6qxt9t9xVhhjURp5OJM0iL03rbq8stLbQY4A9e3HXIXXyZ
         +Ylyiwy+WIbRTfpJSV2piLCLeiC+YFkf8RmlfpDzAuNnY4TC8YrJ8qkRh+ZfCbpnNcq+
         DmRchVFlMTCXhCLghwBhayx7KBc1bFR4443pYEVWegeXvY39gEAI+SG8r4aCwWJueFXh
         Y5qtWfI8ODhwGwoFT9/UPYSIuOI1BEzZIfA2gnxMoRfZcFUbrpOv1xXkkwxyTl8a5FpT
         elyQ==
X-Gm-Message-State: AOJu0Yzwm1dZ9iw7vIRj7RP2BR3FL+O8DMoXxyozxmlk5IKiMVKHPvrE
	FDNuUSmwYk6FPB+/rVXJCgRwZDVmZdXGDIVDQZ3ZlzWD0/SQU0PpSRQlGeAUVoO4VN/aaCm2/Qv
	8bB9yTV5MHV9wLfRsH/cjO7DdkEv67dEM7KNYrMYil0hIoFWYoPEyvTNsdA==
X-Gm-Gg: AR+sD10nXYTas8xlNwHFDUB8ePvKwiTxPOG1fq/CAX04cEWm9e7omXxbw8JdzcfXbtk
	mo9E4D5KzwNEmj+MHIDZsfeOdDuKB1lzCMinSQoNTnJOE7D5dWsOZHnSvf4tP0fAY1QiG/BrwRi
	VB2gMIak73bULfOuXSxAN2iQKclvlWmguoiJNsmy/c7Q7Zz8qR94Db5lmZdXdtWEOMtNHiuAS+E
	wIsPA/mGhxix0c05HvW995r8ZGwO8qpxqa0hR3cOtV1SCsXohOGSY783eO7M+0fFVAsS5R70zjD
	KB68fYBuniFNX6SSvrrUO+lRkKm0WoqYNl6BjMeIcPAtSLJcG6TXOk0aqQP0pBQH4Ggsn2ZLBGU
	i2bS8bbpOx/Gi7X8a5sArMD3egbwyen8PeWQBpCyMCqRUCUNlmbwHzJXxdjDRUDOWRGNusVfId4
	U=
X-Received: by 2002:a05:600c:3150:b0:499:900c:9c68 with SMTP id 5b1f17b1804b1-499aa1a471bmr185691065e9.6.1787218992105;
        Thu, 20 Aug 2026 02:43:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3150:b0:499:900c:9c68 with SMTP id 5b1f17b1804b1-499aa1a471bmr185688495e9.6.1787218990527;
        Thu, 20 Aug 2026 02:43:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b2af1973sm15366435e9.3.2026.08.20.02.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:43:09 -0700 (PDT)
Message-ID: <d6770227-a034-48e8-ae36-ff49ef3f83ec@redhat.com>
Date: Thu, 20 Aug 2026 11:42:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] net: xilinx: axienet: Handle optional IRQ return
 value correctly
To: "Pandey, Radhey Shyam" <radheys@amd.com>, phucduc.bui@gmail.com,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260817105241.63345-1-phucduc.bui@gmail.com>
 <20260817105241.63345-2-phucduc.bui@gmail.com>
 <38099370-269b-4d3e-a686-5b29d806e6a3@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <38099370-269b-4d3e-a686-5b29d806e6a3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 8:39 AM, Pandey, Radhey Shyam wrote:
> On 8/17/2026 4:22 PM, phucduc.bui@gmail.com wrote:
>> From: bui duc phuc <phucduc.bui@gmail.com>
>>
>> lp->eth_irq is assigned from platform_get_irq_optional(), which returns
>> a non-zero interrupt number on success or a negative error number on
>> failure. Errors other than -ENXIO are handled before this check,
>> so -ENXIO is the only error value that can reach this point.
>>
>> Check for a negative value instead of treating 0 as an undefined IRQ.
>>
>> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Thanks!
IMHO even this one is 'net' material deserving a fixes tag.

@bui: please re-submit the whole series targeting the proper tree and
including the needed tags. Be sure to read and understand the relevant
documentation including:

Documentation/process/maintainer-netdev.rst

before submitting the next revision.

/P

