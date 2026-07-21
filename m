Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBB46A616
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649800; cv=none; b=lDanu5HjA8Zis5lPTa4bfsK7PIcJA51suYMReRPqO3A5Gom/7+atvh1O7UlkCAWTBZ10ljcIf2rdO0Z5zZGeJMDYb/tlQ6DBJMnWWYJbyho/OiB7rq6xTDsH3GWFgF+2AytSOvhYw6r0bIpG0q0lJBpoSZ2bsBoZjgMaW9Wrcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649800; c=relaxed/simple;
	bh=c2ewRYXQ+Xw6aF2NE4gfaa+rkwXYCqzqT0g8wmMW7CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMlMq6tZkCrGYCFgbaapLtNuyk32EvofOOnisYN4ru1yloyKLUH6jXb5HXnjPoSjXxfHksH4SF657PgpurSv7BuRIpoIcBytqIcU0sqCL0zmXdcbxz48ajhzQr7dg7lWL4BrJlH17bUusINouqezZrymc1lEw4svtv2y6v5lqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkPrSVeD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GI1jll/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkPrSVeD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI1jll/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784649797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2SwOfNDWEpMwWAcjkHwIVtdWNZTFYw1ucBElhTmnHs=;
	b=LkPrSVeDJdcSQsnWBBO8HcEhYI4HNOERmFxK/TuIJItYDs0w2ho8yl5Jc3uJl9fB7mxNY/
	nfOLAoYG/Z4thBd3RLtlXTA/BqB7xd+RdQi9l53vrZNgSyXmNluGGyqi3AetOBb/7S1ugm
	xOXmgn/DkvtjPT47oNHaF2S+wgd6iaQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-ZtAPwApTMpOVBPenyhRwMg-1; Tue, 21 Jul 2026 12:03:14 -0400
X-MC-Unique: ZtAPwApTMpOVBPenyhRwMg-1
X-Mimecast-MFC-AGG-ID: ZtAPwApTMpOVBPenyhRwMg_1784649793
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e658363so2415372f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784649793; x=1785254593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2SwOfNDWEpMwWAcjkHwIVtdWNZTFYw1ucBElhTmnHs=;
        b=GI1jll/RR/ig383WJoJ4KrfOVoKQOXJx9L7gKbufzTODU8LHolRWAlDu3aURzhZxVM
         /t44cgQ/1dRkMv0vspX5FNE7pJ3E4bSEJoUF1EfBQVlnz+qw/7BIcZgcb4X24lxDNlPq
         95GRFEqe9AYKIdj+Lvx+t7gG5vTQiWCd9rJJotQgcDIfAM8nqXRTQyzCz78RQkDltkVy
         uS9M8FOSUylm01gwQPWjbpZfsuOBW4yjw76aw5gTWLGCl4NbjhM8ExP9jf9bloT1O3jD
         jrj70+sXu2wAFJ3KhI7pMFQfAffeulAN6yVKJI4Iv5FptjGXEeSYjHglTg+kKXBL+2Mp
         AE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649793; x=1785254593;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2SwOfNDWEpMwWAcjkHwIVtdWNZTFYw1ucBElhTmnHs=;
        b=H/+EmODG/2VsjQLtiAi9A6S21615byCBI7gb9VSk76dmL/wS51dOn+cvlBJOVDFss4
         d2nMzLxHBUd332Y4x5saIfouGxVUkC0wtnbUxgNK4soSDBa0qfI+gOFCZs5AZGaxB1Pl
         6NCDYSg8wYeK2kEYWLdGwi7nnOzKvrs4FQ+H7bZvzQK9EKhFBrjjUJzkCl5FCuJ0xxQn
         hOHy87DxLYtofUup+lNti/ilwV94IgNAX4ywz0mjUqIG/+tgGt2X77zWJE3NMpaG6k0b
         znoh4O0AUMhGoIcVfesdntiFg85Dej9hTJuPKFzIhVeW6FIdeNJAXJ7sFcx8QVtFr0Jg
         nvMw==
X-Forwarded-Encrypted: i=1; AHgh+RqqhwOhwYIisqSsOxf0GAZ1xt1NMf6lbpagprvqXVcW4u75v9VnBj3f6Ll9wMeFjpzLNm912lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3HCbCX2vZvZSUJIQWd99w8YOrwOdymOcwg7J7LUP+InHhIqk
	dpoPEwlbsgXp8xyoCI2f2d5AgdWhns1syQAooJxDDw9QOc46FaJBcUjhZNK6c2v7s4EywXoi3bj
	PKo+zW5VUieQeBajuNVhISvmums2chRoqJvzAxDcOyQ1W/xEbTh4Q40IxJA==
X-Gm-Gg: AR+sD109FeYkWbvSwJm4cKL8qQQsW8ftNiRKJ6eJPVSYfMrfifIQ7gAzjpjKIjgMwCW
	Kgr50klxXaG8vvO+egMtXRF6sogQIjQyvHa2O+lTIHMtM89ziY7iu8UEk6GM9iCK508q3NqV0yO
	iDSRRUcTCoHhoFA3wrcG2bIRHDYzYMxFN/fJ3cdlNXhsQLVduj9iInlCqtq+ocuNEORJOLaq1Xc
	rKzNmwMR+S1VBumdsILp+zj03OiZ0LR6f3gY1UirQ356UqqaujgpEk2M8VP7vh9NM2WRTPOs/sj
	pLTWvMV7YLqdu0awfW7Oq7FxvKY0naTsskHNdZi05Z2VAuRiQTunq7rCwDs/MSLQfPFy4rU6lsE
	RQ9VQJ4477HXzIM/KvE86nhtg6Glm6ZwqOyFsyWYMptz9SY8ufeIhXHBkKOBTEXIcS0xl+tAlVz
	YAVA==
X-Received: by 2002:a5d:5d0e:0:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-47f62328198mr22722711f8f.36.1784649793217;
        Tue, 21 Jul 2026 09:03:13 -0700 (PDT)
X-Received: by 2002:a5d:5d0e:0:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-47f62328198mr22722641f8f.36.1784649792662;
        Tue, 21 Jul 2026 09:03:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm43781736f8f.21.2026.07.21.09.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:03:10 -0700 (PDT)
Message-ID: <79cdf453-1569-4ae5-b317-2aace4258ecc@redhat.com>
Date: Tue, 21 Jul 2026 18:03:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/tcp: Prevent inlining tcp_syn_ack_timeout()
To: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com
Cc: Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net
References: <20260708180837.9507-1-emil@etsalapatis.com>
 <6c01c713-14a8-43c2-aaaf-2fcf622f7e4f@redhat.com>
 <20260721081240.1b88db50@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260721081240.1b88db50@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 5:12 PM, Jakub Kicinski wrote:
> On Tue, 21 Jul 2026 15:24:52 +0200 Paolo Abeni wrote:
>> On 7/8/26 8:08 PM, Emil Tsalapatis wrote:
>>> The tcp_syn_ack_timeout() function gets inlined by Clang,
>>> preventing tracing. Since the call is not in the fast
>>> path, prevent it from being inlined.
>>>
>>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>>> ---
>>>  net/ipv4/tcp_timer.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>>> index bf171b5e1eb3..f7215d53bbda 100644
>>> --- a/net/ipv4/tcp_timer.c
>>> +++ b/net/ipv4/tcp_timer.c
>>> @@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
>>>  	sock_put(sk);
>>>  }
>>>  
>>> -void tcp_syn_ack_timeout(const struct request_sock *req)
>>> +noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock *req)
>>>  {
>>>  	struct net *net = read_pnet(&inet_rsk(req)->ireq_net);
>>>    
>>
>> What's the point of tracing such function? It just increment a mib. If
>> you want to discriminate between TFO and non TFO syn ack timeout,
>> possibly adding another MIB counter and incrementing it in
>> tcp_fastopen_synack_timer() would be better???
> 
> FWIW we seem to capture the 5 tuple when it happens, not just mib
> counter. Internal commit (form 2019) just says we want to know when 
> syn-ack is blackholed, unclear under what conditions this happens.
Thanks for the context infos. I'm fine with the patch as-is.

/P

