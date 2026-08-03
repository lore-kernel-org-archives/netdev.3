Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EE42AB7
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745103; cv=none; b=AXks2Lr1y0tpwQ8tAud3cYAT6A+GpPpoId6wW+h2+D3CtgFyPcP2PVvM1sduXpMVih+/azXgEEz47ifoycFcJKS7af+lS0YVLVNbTp8pdeJY7nKv4vJjBiMHCNd791zoYO776HONKAjdSw5DevID9WzhWYxAzV7TahN++Nxw3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745103; c=relaxed/simple;
	bh=l51BPZrmcVPmY1ZAOvafMoj/ozAT+EEV4unz04OI394=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jjGTi6HqvGUbuFKu+azfxmC5iLKqxPN4RRSj+rk9QReV6lFrE8NQxtW2BlUW6tZC8/a9YIHiY9WafqByPn7lQGCezDBVifxU7MlBh+GNi9Q00JhYC+Sb+smh0E4QMLcA+zAY5RDO3LCLvavjClX/YRRpe3vHbxsK9VwNJtN2R88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZrfsmdf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJ2Rqpuv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZrfsmdf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ2Rqpuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785745099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8iKikqFO3zEFEsq/VazzrCGyVxKknjb3/NN6IXkpV4=;
	b=DZrfsmdff7dUo+/Qr30cUo0ZH9n+zRMdE0haJU7EHyxyXBRwbes9svkqtVPFxZ9P637EKY
	o3EcShD3QZg6o22ERkacehbp/VhPJPHOHLguY/ks0x5yKCf4P5U9qIAmZpYQea15N6dPWf
	zkdNkozR9iHpdZJFUXK/wAUk4n72Ek0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-gwRAdEUfNVmFQ5tFedlCQg-1; Mon, 03 Aug 2026 04:18:16 -0400
X-MC-Unique: gwRAdEUfNVmFQ5tFedlCQg-1
X-Mimecast-MFC-AGG-ID: gwRAdEUfNVmFQ5tFedlCQg_1785745095
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so21258985e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785745095; x=1786349895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k8iKikqFO3zEFEsq/VazzrCGyVxKknjb3/NN6IXkpV4=;
        b=FJ2RqpuvflL1PblY6ZtQrdAEa5hnZxBYvhZ//MYhs2dFOozNJ2lum79DQzHuF3put/
         NWtmDsKZRTqyFA/dIMAD0dWet/FBbbO8nyEWbhgSyftrHi5uIAlnR+Vk8tNQmc1lIWc3
         qauccbsss0pznHFBH2Nhv+gZGAae0gcVE9aadIODU0z34Vqo28Q5JeSeIygvxOOIE4BB
         u/itACFCt/nxKhVNCi1LS1fnNBqB3oWkwDfQ221dCrpmBX14u6HeIvtM2hzSwa3l6tXw
         eFQjVxbXwP5N3CONZIpgWT94wvOulWfCJ34vZ0xQJljja/Q8nYcPcD59wQS7VPzWAdO/
         orQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785745095; x=1786349895;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8iKikqFO3zEFEsq/VazzrCGyVxKknjb3/NN6IXkpV4=;
        b=KCjp1Zwnwp5+SMPO0N6TqnKYezabo2jJyJDylm1l8xSNYsSSwbYIi6H/ASdAgY1qew
         P/49LPXoFyWJGhFknBNMgwt1c+7zSQCZHPBWcjpxkDUvrG+UL5kxSUo9NtE29etV+TDK
         Rk8mo64aFDXpzJ/V7dMagukmme13FTfOq3I3EjecQojrJ5xW/bSSnDnd8in+E/IM6Hs6
         w/8F3Tfzplc9HPBOiwgQsHgw7CHU7DAimwfzr44xkHcBqE4F2HTzcRZ7HKyZvbdwPSus
         F4R4u/HPixVgsMrm+kVNhFzUrGkCHBwdjrzRPWlYZSy2acP/pX6xRNGr+D3Eg2lRRhuy
         uvmg==
X-Forwarded-Encrypted: i=1; AHgh+RphuBR6w/ZC1mRsGqnObMOoVU38GS1jFORG5uKkPa4h40a9L2hMBHF8OXsioOo8/wHtwkx1nWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iapdHH02U9cJpNFPDG9LHeD2WdwAmZf2zamaSd16edhVfmDJ
	w/4iPWFBeJ/Iauyk5yD1NcDOwgpor8klzgnFr4FCtD1hPkfMiY4w5UMljAjOuC8hxrNnN+59Bw/
	l/R7zLxbbx3N5GfRSVKzUf3561XLba3v4PMsRIjVRY5A9hoEETCd7OT6Tzm292nKK6Q==
X-Gm-Gg: AR+sD13OJoZm2GThcFGeBfj2u9O3LceR++e+VWaFmbfu394B1foP8cMKQxXXsyVOkg4
	ctCPJA1ALizt5CT+2US/5zLnz8B/u43IBStLOZMiM2sQI3fj2a7AdKnmNrQQBKiyIP7rfkSVbTp
	2SyRztD8mK1OPD7Kb/C/P8Z2wKqiaVjjdxSGrdNsxJqd1f1T45ANl+L732UdsVmRO+zI9tdAUhq
	x66qOdbr5RONkUHzd64FPPLn+oUgCm5/wKBWRk4Hc+KEdl/jJSVn+ljW6pTRCb6jvtnXT/G+9EH
	+zMUdBNfoQ0HnrMW/gXlceEXWaYf9NWlN6KY8UMuEwtC+XGMdHdwJQNw9peYT2LhEHtgIcRqC/f
	ts0MRkJCXyRONNEovllpTD23yQkuuyJDyZZf+kpNw6WO2mlV6C2j3WB8DIGcik4j2vfnOsce3IH
	8=
X-Received: by 2002:a05:600c:2294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4980c67af97mr160439505e9.15.1785745095509;
        Mon, 03 Aug 2026 01:18:15 -0700 (PDT)
X-Received: by 2002:a05:600c:2294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4980c67af97mr160438935e9.15.1785745095069;
        Mon, 03 Aug 2026 01:18:15 -0700 (PDT)
Received: from [192.168.188.217] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f0adsm202152355e9.4.2026.08.03.01.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 01:18:14 -0700 (PDT)
Message-ID: <3b7ee98e-cdaa-4c53-b6d2-a1d4e1bab8e0@redhat.com>
Date: Mon, 3 Aug 2026 10:18:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: do not change rcv_ssthresh in
 tcp_measure_rcv_mss()
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Nathan Gao <zcgao@amazon.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 "David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260725030806.28135-1-zcgao@amazon.com>
 <20260731174644.02410e2d@kernel.org>
 <74f99014-d09e-46ca-9c02-d10570f62fe1@redhat.com>
Content-Language: en-US
In-Reply-To: <74f99014-d09e-46ca-9c02-d10570f62fe1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 10:09 AM, Paolo Abeni wrote:
> On 8/1/26 2:46 AM, Jakub Kicinski wrote:
>> On Fri, 24 Jul 2026 20:08:06 -0700 Nathan Gao wrote:
>>> Commit f5da7c45188e ("tcp: adjust rcvq_space after updating scaling
>>> ratio") replaced the direct window_clamp update in tcp_measure_rcv_mss()
>>> with a call to tcp_set_window_clamp(), a helper that implements the
>>> TCP_WINDOW_CLAMP setsockopt. As a side effect, the helper also shrinks
>>> rcv_ssthresh via __tcp_adjust_rcv_ssthresh().
>>>
>>> As a result, each scaling_ratio decrease detected by
>>> tcp_measure_rcv_mss() also cuts rcv_ssthresh. Elsewhere in TCP,
>>> rcv_ssthresh is usually cut under memory pressure and grows via
>>> tcp_grow_window().
>>>
>>> Flows whose segment sizes vary keep scaling_ratio oscillating, which
>>> leads to an unstable rcv_ssthresh: a dip of rcv_ssthresh only recovers
>>> via tcp_grow_window(), keeping the advertised window at a relatively
>>> low level even after the ratio itself has recovered, and can even stall
>>> the sender.
>>>
>>> Observed on a customer's proxy gateway after upgrading from kernel 6.1
>>> to 6.12: in the worst case, rcv_ssthresh was cut in half by a
>>> scaling_ratio dip. P99 latency jumped from <10ms on 6.1 to ~100ms on
>>> 6.12, and almost returned to the 6.1 level with this patch applied.
>>>
>>> Restore the plain WRITE_ONCE() update of window_clamp, as introduced
>>> in commit a2cbb1603943 ("tcp: Update window clamping condition"), and
>>> keep the rcvq_space.space adjustment. Now rcv_ssthresh is decoupled from
>>> scaling_ratio changes in tcp_measure_rcv_mss().
>>>
>>> Fixes: f5da7c45188e ("tcp: adjust rcvq_space after updating scaling ratio")
>>> Signed-off-by: Nathan Gao <zcgao@amazon.com>
>>
>> Not sure, I mean regression is a regression, but also the previous
>> behavior seems to have just been lucky rather than correct in principle?
>>
>> Looks like Eric and Neal are AFK, Kuniyuki, Paolo, any opinion on this
>> patch?
> A quick grep confirm that except for f5da7c45188e, only the control path
> calls tcp_set_window_clamp(), which IMHO supports this patch rationale.
> My understanding is also that this patch should not re-introduce the
> issue addressed by the blamed commit.
> 
> It would be great to have a pktdrill tests for at least one of the 2
> relevant scenarios (the one described here and the one relevant for
> f5da7c45188e). My totally uneducated impression is that writing a packet
> drill for the case described here should be slightly less difficult than
> the other option, as there is no MTU dependency.
> 
> TL;DR: I *think* this patch make sense, pktdrill would be helpful but
> not a blocker.
Uhm... Above I did not take in account how far we are in the current
release cycle. The issue has been unnoticed for a considerable amount of
time, and the chances the fix would introduce some other regressions are
not 0, so I think this patch would deserve at least another positive
review to be merged now.

Thanks,

Paolo

