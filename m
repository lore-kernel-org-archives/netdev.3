Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F093A4F50
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647641; cv=none; b=pcinT/3TsnmwWhREBKg33Ku9NTSrtF47iolcGOP41g6Z68PA+SkT7PAIG1palxx+DHIZg7OorRT6O1LJgWDBiHT5LjAl38SE8pncBgWZRpio6gZ4noiGOJ4Q9z8O/u+dCVWQkGBCbsRp1yBXrV2k7JWQEYbbt9Ia+lzwoTr7b0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647641; c=relaxed/simple;
	bh=jQmRjKS3+vMFIIdVez2XmwoympGUXadkF7Jjo3Uyo1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TboMWh+KLc4d3wTxjYInmBkbpE5HymrnpBgsQ7yHJdkewI1lMPX1O0hx09aQ/KMxX6beJMp0YmwaRYOtX3gzi1hhWiT1YKT1nK+QPHsbvK5LjkIEepoGKZWX1L1DsmwF3zFZ/xvevfWF1cbylUvVAnqYyB5SVgffJ+IztW2CprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlmTSvR8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkY4+IoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlmTSvR8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkY4+IoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787647638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTpkfInV+KzHo/KAHdT9LTZrdvGy13iGVgmGM9DUQIA=;
	b=UlmTSvR8LTkokXaVseUsR4b2RVJ2nsGT/NVtX2qxD+l9nIAc35ffsz4BOe21X2Wb3nY955
	+aaKnJItPzsATAkWmU5UXXSuw+QvXptuSr02tMZT4UrP8No/f784UiLZ+ErSxLClTfTE2M
	AuwMB5dzZ4RYgAty17BXUPxRUSij/EY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-YDAxYSsuMvWT0YutYzfAQw-1; Tue, 25 Aug 2026 04:47:17 -0400
X-MC-Unique: YDAxYSsuMvWT0YutYzfAQw-1
X-Mimecast-MFC-AGG-ID: YDAxYSsuMvWT0YutYzfAQw_1787647636
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a0fab609c4so605293a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787647636; x=1788252436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTpkfInV+KzHo/KAHdT9LTZrdvGy13iGVgmGM9DUQIA=;
        b=PkY4+IoZIOMR087l4ddJSXUPqUezsfy5X7fSnqezuvjnexUhXMuDn2SVgK2FVEzDDU
         tnp+Up5cXySCJ/ONp9LYICi/BnRrdxI3bu1cVBQwP5VRZFue/AdgE48YQd0WkgaQ+Oat
         mMqxkw+EvJKRal/MSZtUMU4IJKrjLhD/mqrg+K8Ji0C1g620w2QrD4zplte2I5k0/Cas
         lJYnwDFJFeJ/X7BQCEi1A3IxfH3TNt1P4zDlCm0ZQ6mhYwA1N0S0HrjKsbbQkAna/UAV
         WEUdmjbLMgP+v/3JmEelllZR4w6NsGK7bm7RupUY1sVKQW718fVfoBFQM1rzxYKGtK6y
         qGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647636; x=1788252436;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTpkfInV+KzHo/KAHdT9LTZrdvGy13iGVgmGM9DUQIA=;
        b=jfvo/MaG5aQiOt1KHa+sD34CniKPKyfuOuQhYcALrKQd8d2xEyWzeUEDnqodqtkgMm
         pK2z7RMwW8mf9XmhFamuzippebJgFTCYcmJW/nJHYpVQ5lScjXWPRksgAOUslClcSvM6
         LLWF3zRzyN86MRnaqz8GL+sBBMsJ/4hw2I7dCdYQzQ4g8IEgKOvE0d4kPGhMiHdN2Ewn
         63bCxG2cqKIElyBfBlPpf8nArtkMjST0XQ6jBZZXx3PAWKQ0+sdaBGiFQpB5pjJ8/nP/
         FjLTDoX8HQ0lBj5GweSo6LJs0+zCSIdMn1NdU8ChcN/P2hCZPhcZuKQ4P6CoqPl7tK37
         gxzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAHj6Ssxi+YjaEXeWJ/fAqYl6DloDuxwySPE4QLu24o+yBJlxa+49qQzrFBLkN1ASlWlO/rz4=@vger.kernel.org
X-Gm-Message-State: AFuF++lNV6K7kCHG2CRH2d5FnChVbOI6MFdXuTKDMFfLFsGy6HcpzEFu
	tUS4gsf03qrVPWyxE2b+43NTbJCxzbhLxsdirHM4gIfgUqzWqw6KcaEq96BseDSD3zcZiacbufu
	MFHOVoNsKzk+1Oay2T3JgNaSl1QTX1JTR5EOEDdMSHuIEr4RFviF5PNPCzg==
X-Gm-Gg: AR+sD10t5Beadg8kUvM+lvofICvrHcT5HDUFEbQKxnlnu/axMnPdXQOMUPHt9VbGrqX
	kO3bnFp0ELU4TMkCpuH9xqy+eH1nRipTm+uw+u7bBuiI+FaxQKXyNERMRam7dyQp37Ls00PCNBk
	9FBc7sctpFOaX+k4+Hp7ba+VgiCzenYQp4j9yMOE12vvJPJnkbY2iNRnZrDYWKSqT7bsPyOykd5
	5gC7zVIKcOCq4B9L1FSls2+62LzLNXuMhoxWewNiu8l+cBv2yaDsyRvrcitLdGYcs7jpc2F5MjC
	7xOmujMOf5XEyjvAcxRou2a7obOaICcMLe3At86mTIFNRj9z/z5O7VC0LDZpjNDV+JzHiK+3F09
	S6MGSFXBrjuSgbje3yVUV0dVq5grlgEl1o3W1ir7dSbdjlLgYYnwlN+VfOTk2HKJO9wB24nn2
X-Received: by 2002:aa7:d60c:0:b0:6a1:f3b5:f7dc with SMTP id 4fb4d7f45d1cf-6a5c3e88bcbmr3787911a12.4.1787647635897;
        Tue, 25 Aug 2026 01:47:15 -0700 (PDT)
X-Received: by 2002:aa7:d60c:0:b0:6a1:f3b5:f7dc with SMTP id 4fb4d7f45d1cf-6a5c3e88bcbmr3787879a12.4.1787647635491;
        Tue, 25 Aug 2026 01:47:15 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2ddad2sm12297384a12.30.2026.08.25.01.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:47:14 -0700 (PDT)
Message-ID: <7aed7185-d48c-4013-9a85-a8b27cf7eae3@redhat.com>
Date: Tue, 25 Aug 2026 10:47:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix spurious TX timeout after dev_activate()
To: Nicolai Buchwitz <nb@tipi-net.de>, Breno Leitao <leitao@debian.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20260824-trans_start-v1-1-0419cc427ed9@debian.org>
 <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 5:13 PM, Nicolai Buchwitz wrote:
>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>> index ef2b4bf515641..4539dc2c6d380 100644
>> --- a/net/sched/sch_generic.c
>> +++ b/net/sched/sch_generic.c
>> @@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct 
>> net_device *dev,
>>
>>  	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
>>  	if (need_watchdog_p) {
>> -		WRITE_ONCE(dev_queue->trans_start, 0);
>> +		WRITE_ONCE(dev_queue->trans_start, jiffies);
>>  		*need_watchdog_p = 1;
>>  	}
>>  }
> 
> Follow up or v2: netif_trans_update() in dev_activate() now seems 
> redundant?

IMHO should be a follow-up.

/P

