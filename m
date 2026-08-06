Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A442D76C
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007716; cv=none; b=vDafws/uITuAapQyC4xieFPEZCvi/qhd1Mb9R/PaGx+45O1ULEI+iQ0Nt3R8xhAzaXgPUUMBDKwYPB8d2QzAtZUFmJRrWwNto1FemeMcSkqIRl4GKd9AwHrpPPGSRykf+LZA8MvilBFrKljMq3h8SQ0LdQVpHsxu1Tkv4FnH9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007716; c=relaxed/simple;
	bh=qzNuBPozfFIkdZOuS/fLxMETJ0Kd83A2UR9sybGyKyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq7Exr5M+tOqh2gMPO3RP8N9GMitvi0pVkvOf6Xd5FiSHFGtyh8t9i4038Q7dsaFl3Dj9T3XeEe8TrNKHW5w7avSH94D3EIayPtaNtImLGshKWPvtv7fYFTZB8gpaO/ds58ZUrK//iTuty2H6XRWR9M8pyJy2FiB+Cdi1nxl2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIgIczcV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p8LoH9m3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIgIczcV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p8LoH9m3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786007713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1p/WqP5zNmyTteiVasVWjR72E6WFiVRU2GjHHBSa5c=;
	b=HIgIczcVznM/PvVO3WSanKAnsj07yqxutA+c0qD6W7KLAX8sbER67wo9jFQsXuofoJp0/B
	HSBivg8cl1+otxci0Ww/V/gbi+/7g4SukEv3JNqh5UMv90cICz6R9+Bvj6/5P+xXsCnIPy
	CE6BpTG9rTiqqWxmwEluDWBUS6gIoZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-aXBBmUc1Oay2qh2WU0DJHw-1; Thu, 06 Aug 2026 05:15:11 -0400
X-MC-Unique: aXBBmUc1Oay2qh2WU0DJHw-1
X-Mimecast-MFC-AGG-ID: aXBBmUc1Oay2qh2WU0DJHw_1786007711
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f83999cceso1545730f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786007710; x=1786612510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1p/WqP5zNmyTteiVasVWjR72E6WFiVRU2GjHHBSa5c=;
        b=p8LoH9m3PlBbDyLiRikbCDnVkgf5LtyEyJ3k8iwsv1aOFM+kvlqB6SWiwQi/MQpu86
         oEh5cON/hAGUqAPHUYOfbxCngxCvxeoY3MF6RFdzt3gBytqLanxrXQnOxktyVuajftX7
         yv6djLmFwtWpHJu5pmV2LpiRqWlyzHpH8z5c6uGnFTiH+Fpj0B4F6rNQ2ob1yq9sb+CZ
         u/Q2ySogarVUkmggljGKWjDEX9aTHd9qs/LaIgAGlQBTsIIO+9zUMbr3AP9MH09HpcsP
         bq4TtB+BS/a8MwV5B6PqT79mk5at9BINp9L/+P+KZ2UvdtKKjjYiqU1Rwy2qX3nYmwQX
         AKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007710; x=1786612510;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1p/WqP5zNmyTteiVasVWjR72E6WFiVRU2GjHHBSa5c=;
        b=Lonaw7ayD+sN8upoDnN5823HSvSsrUqrrJCW+7ds1qI2AMXO+qwGdL/1G/o0ALUR3j
         UHt7x/s8TftJefcNt39LM0m9EyrvJWuQz4S+S3gFVi9wFkr0pZFIbTD/goSarjthkFVU
         8j2h9ladj8yFbi2kdbeuFzfUB0hLn/E2odBrSwI3P7DhGT+lFW0L8qSkHVBffFDCytT0
         6L2LJ85bB1m2QJUyyCNV1fdJaKjOFH6TzqDTsEhHh08nq3v2n+6nyi/zHoRxUMNjlYx2
         gQudRqgfjs0ecVh0tU8PWjWXj1eCBCmuh1lVq0bzKtSdyiZaQJohORDPWjysRLOijgGG
         3SdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqtkxv2wAkujinKx48FgGToQXZ5H/NrLAfeC8D9bbJWV4k4a5QIic0k59KpX9XPh1xh37C32Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSoEm5l53fatlfi5im2LE3yTJ0ZrG8MSheIUGLun+PtJejgRg9
	eDoSlbPp/temP6XhgJEN/IXeVGrx9bUWbIxZXVfpqqStfKqnBd29Ux7nUWM/wWw80mTJFjCNFcc
	u9pRCgHXSnJNlWMT6VVV3d4RnqH8QDCOjwwERSAq3JOYBFAL4QoifgFPSVA==
X-Gm-Gg: AR+sD111oOFLAejFL9tjFx/d/SfBDg4wty+Fr8Fe0ZxBoBq8KeavBLrCCFy5guC6KUY
	CiAcDJoTWbIj9j9t1sf6CgK0sXiwaqoPDVkilh673MBNUoVA3cZh925R9us5/3VNc/E5T7uFdNb
	hX9L4YRWEFd5rFb42cuOezWvKUYMf4Rc3ufbIrD51TcQfJDZwyvpWx9T+4qMu/Dsa0WneQaTP+l
	vNsVtB6zLGCGfjRqwhLpzIJtuAgZ0+EIrwSAIMe9oE0gDPoHmXa2Q+Wj68zlwxVv4w8uf9t98NH
	fGx+G6SrNPnG5HT2MMEwlD9k4gSL/1Q+2r8qzv5k1Kb1gfFFdIBvEjACl+wfn3Pji3yBWCfPCB2
	oLP+7HOdwCGfNMwgzwcnZkWWt0B869JBLy5uq8tWlk6mfeJPNds8fqWUlNWLECITvwKv2oDqI7Q
	U=
X-Received: by 2002:a05:6000:29d5:b0:47f:90df:4ec6 with SMTP id ffacd0b85a97d-47fec4e761bmr17445727f8f.6.1786007710474;
        Thu, 06 Aug 2026 02:15:10 -0700 (PDT)
X-Received: by 2002:a05:6000:29d5:b0:47f:90df:4ec6 with SMTP id ffacd0b85a97d-47fec4e761bmr17445663f8f.6.1786007710038;
        Thu, 06 Aug 2026 02:15:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b26879sm4650653f8f.30.2026.08.06.02.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:15:09 -0700 (PDT)
Message-ID: <1f36d5be-906a-4ba5-8679-24cbcf899254@redhat.com>
Date: Thu, 6 Aug 2026 11:15:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
To: Tejas Birajdar <tejasbirajdar@meta.com>,
 Eric Dumazet <edumazet@google.com>
Cc: bpf@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 sashiko-reviews@lists.linux.dev
References: <20260730220055.2946171-1-tejasbirajdar@meta.com>
 <20260731220124.B0C621F00AC4@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260731220124.B0C621F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 12:01 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The `SOCK_RCVBUF_LOCK` check executes before the BPF program runs and before `full_space` is inflated, silently defeating BPF-requested windows and bypassing dynamic `SO_RCVBUF` adjustments.
> --
> 
> --- Patch [1]: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path ---
> commit 2cf5d1d17ae1c7488533ecaa0fcbb83ae4591ec8
> Author: Tejas Birajdar <tejasbirajdar@meta.com>
> 
> tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
> 
> This commit updates tcp_connect_init() to honor the initial TCP receive
> window requested by a BPF_SOCK_OPS_RWND_INIT program on the active connect
> path. It inflates full_space if the program returns a non-zero window,
> matching the listener path's behavior, and uses u64 arithmetic to prevent
> overflows.
> 
> Link: https://lore.kernel.org/netdev/20260723214208.3655474-1-tejasbirajdar@meta.com/
> Link: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbirajdar@meta.com/
> 
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index d7c1444b5e304..fcaa04e65189b 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
> 
> [ ... ]
> 
>> @@ -4137,10 +4138,13 @@ static void tcp_connect_init(struct sock *sk)
>>  		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
>>  
>>  	rcv_wnd = tcp_rwnd_init_bpf(sk);
>> +	full_space = tcp_full_space(sk);
>>  	if (rcv_wnd == 0)
>>  		rcv_wnd = dst_metric(dst, RTAX_INITRWND);
>> +	else if (full_space < (u64)rcv_wnd * tp->advmss)
>> +		full_space = min_t(u64, (u64)rcv_wnd * tp->advmss, INT_MAX);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does the SOCK_RCVBUF_LOCK check happening
> before the BPF program runs defeat the purpose of allowing BPF to adjust
> the receive window?
> 
> If an application sets SO_RCVBUF prior to connect(), SOCK_RCVBUF_LOCK is
> set. In tcp_connect_init(), this caps tp->window_clamp to the old
> tcp_full_space() before tcp_rwnd_init_bpf() is invoked.
> 
> When the BPF program returns a large requested window and full_space is
> inflated, tcp_select_initial_window() bounds space by
> min(window_clamp, space).
> 
> This caps it right back to the pre-BPF full_space and discards the BPF
> request.
> 
> Conversely, if the application did not set SO_RCVBUF but the BPF program
> adjusts it dynamically (which sets SOCK_RCVBUF_LOCK), 

I read the above alike: 'a badly written bpf program could be
ineffective'; not much relevant.

This version LGTM; Eric do you have some comments?

Thanks,

Paolo

