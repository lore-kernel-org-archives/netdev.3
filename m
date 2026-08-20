Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B6416867
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222947; cv=none; b=X6otCNRqfvCLfql9J8AgbK0c5ormY+vKlgCjMiiChFS5xjfchoSLB5GDhu9hvciSQ5cEc6rwRal90lkLkFd60RfqdbBdz+3U+2l8fy1UhiMOzp0OeLVPKTUNV4AlqljHXa/VrbjIOxEN1WIYYCPTqepoicdJtnt+zTggW/7Bas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222947; c=relaxed/simple;
	bh=84mHHqMwvxMmy73BDonNuADoTaMzOLO1VFEX69bFSoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffW3m5yu8j0a+Caxv/b0/yL3qTaMe78fIeVgKbXG3NdT7DUV7a68jtuJ//BtRhXkLUiwgEQlPbyyUOUbjw+kdYwhCtBAcntOOXU0FRYzGFmCE+j7mrsecWaFaIsYFGX6wwDWE4Ybj0WZ/AxYKmOHexf/RBgvLKcOiUMgncKtbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjlHI8u1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5FrPU5S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjlHI8u1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5FrPU5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787222945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE8kHQV95NiwWFSovR9/EVOgnngNW6ntDLlWpddRHWs=;
	b=VjlHI8u1gV3Nc0tU6YkfeziGRsworARsS/EJaE7tHJtyZlS55JpmAMxZiNq+ZB+tC/eNkK
	5hQWkYYBQX+SuSU1lQz0TDkxcU4t7yQIMsVsWanfe2apFVrYAUk8Q+y9Av9qacB3sePADC
	grn/ILNdEUP31shhqg8uMv3aGP7Gq74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-d7W4XFpWMGG3wkhRVAvX6Q-1; Thu, 20 Aug 2026 06:49:04 -0400
X-MC-Unique: d7W4XFpWMGG3wkhRVAvX6Q-1
X-Mimecast-MFC-AGG-ID: d7W4XFpWMGG3wkhRVAvX6Q_1787222943
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955d314945so11715415e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787222943; x=1787827743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HE8kHQV95NiwWFSovR9/EVOgnngNW6ntDLlWpddRHWs=;
        b=K5FrPU5SOVqGPPNwmfl0HqoXfPOEGWGCXDBZQ7YsUZlD4IZJRsdP3Ryz5j4BGtz3WZ
         vAJBzuBPDtmKgjh2jpeQzbCsGQdchiD1YAyooNqqY4kQqrfgRg7c8fRNzK+y9UXgwzN+
         LPSaXD50e3pqGkLxJqpSyM8M/ZSpfpDgOxQI9dpWlBeQMFtk95Ts356TvxRb3gV3F7t9
         rLxLZOdfBCtI0noq5nfISTIV9A+rkygOmH3Xh9D4o5BXTxoerVk10YS2VBUYi3fy75kU
         4+mNq6RscFG/PflGrM8lbo+nEkroA01somZXizlB37tIUbVbt00XQERjgJQELFyrTBOO
         3wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787222943; x=1787827743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HE8kHQV95NiwWFSovR9/EVOgnngNW6ntDLlWpddRHWs=;
        b=MCtr9rel3Qe9b/OGW4UWyOMIkcj4v/UIQ1xMmbXGuizA1Y9+Bxp3ttgo+3zFMJVINf
         W3A2omeILEUQTKIyQWFFR7g2oOGZEwwawFBVxX/SsMoy0Fua/8D/2T/f7TZumE1zt2AV
         bbE3a1t1Wk3DIVIvayqG8SYUIXyyd5zXp9swlgBpm5XheYZpAFiCRl7HDUUxUct9APsN
         9keqtJNjxrcokxCm3y0vZRPtgdf2iIGKDuOlUOcoasO255MXGt6tMD77807sR9rMH50S
         jSwzjAdtzeC550+I3yg+Ts9kMDjWEO4IDHBjFRUJtds0Y8D6YdjPSOZjTD0BVXcCAItt
         ly1A==
X-Gm-Message-State: AOJu0YxWWf/bV6F3sLwY9xmVySae4b2zXvWq7vbtWbfREz2oRyOJzZ67
	EYH6jKAKwvm/bmWjwvoRV/FACWlRjeFJUDnNpdGmoFoPMsZ4qFTTAN4XZnOFHraT/vigJIb04Ft
	6zLPuR6lmCsf2jfsoSTGRPyqxUIuqZfnKXO0vtFIh63lxDDiyEvOsDON8tg==
X-Gm-Gg: AR+sD12E7g5hPu56AcjPL5lFs78EfZICEwo6i3MjDG1YOcFgN6WgPwPMsoVdwupoyX6
	688hEhbRuuU10j2G4CwjWMI1wWFUxtJlNox5FXCxb+RnyG0EX1TNcieSjqLw2JIYNacd5hNoA8A
	u0pNcfYi85QvAO14e4a/aHxSMgGHAIMX3HGzyafS2sZsBTEk/rB+J9RwxNQIZ6vUzV3pFW98ty3
	Tns3m35DF3lBHyLMGdJMgD/a/ZJDn1kH0ufFJHAdbfQwqqlcMHyO/h+/Dnsjb6LIm8JQzVPsNqa
	LHypvLexLztEoHm+W3Tv4BqSn1wCEdSTWFGbWAsTq5RcJqBKsyZ5MWRtaoQjR/klGCJCHlzgzNE
	GrIV1tT+wExk7Llm4SbSnfB2d4QQsx0+R5KbTF+5cNg8dMKPlzDHbDs3iRSa1fhF2jjOFhPbfG2
	Y=
X-Received: by 2002:a05:600c:468d:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-499aa17d5a2mr187920715e9.8.1787222942700;
        Thu, 20 Aug 2026 03:49:02 -0700 (PDT)
X-Received: by 2002:a05:600c:468d:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-499aa17d5a2mr187920035e9.8.1787222942228;
        Thu, 20 Aug 2026 03:49:02 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd3c9sm139412805e9.12.2026.08.20.03.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:49:01 -0700 (PDT)
Message-ID: <77e147e1-b183-46ae-a9de-dc5d2cfd2f06@redhat.com>
Date: Thu, 20 Aug 2026 12:49:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/tcp-ao: fix use-after-free of current_key on
 reconnect to another peer
To: Hyunwoo Kim <imv4bel@gmail.com>, edumazet@google.com,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, dsahern@kernel.org, 0x7f454c46@gmail.com,
 fruggeri@arista.com, noureddine@arista.com
Cc: netdev@vger.kernel.org
References: <aoIriv3pHDgII2YR@v4bel>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aoIriv3pHDgII2YR@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/26 11:28 PM, Hyunwoo Kim wrote:
> tcp_inbound_ao_hash() is called before bh_lock_sock_nested() is taken,
> with only rcu_read_lock() held. On the fast path for established
> sockets, if the rnext_keyid sent by the peer differs from
> current_key->sndid, the key the peer asked for is looked up and stored
> in current_key. The lookup is inside the RCU read side, but current_key
> outlives it.
> 
> When the socket is disconnected and connect() is called again for
> another peer, tcp_ao_connect_init() unlinks every key that does not
> match the new peer and frees it with call_rcu(). If current_key points
> at such a key, it is cleared to NULL.
> 
> The fast path reads sk_state only once on entry, so a softirq that got
> into it while the socket was still established can update current_key
> after that loop has already run. The update is inside the RCU read side,
> so it comes before the call_rcu() callback, and once the callback frees
> the key, current_key is left pointing at freed memory.
> 
> The next transmission picks that pointer up in tcp_get_current_key().
> tcp_ao_transmit_skb() then reads the traffic key from the freed object,
> which is the use-after-free.
> 
> Wait for one grace period before unlinking, and only if a key is going
> to be removed. By the time tcp_connect() runs the socket is already in
> TCP_SYN_SENT, and TCP_AO_ESTABLISHED does not contain TCPF_SYN_SENT, so
> a softirq entering after the wait cannot reach the fast path, and the
> ones already in it have finished. The existing NULL handling in the loop
> is then enough.
> 
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/tcp_ao.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index e4ec60a3349635..5094267447aee5 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1160,6 +1160,15 @@ void tcp_ao_connect_init(struct sock *sk)
>  	l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
>  						 sk->sk_bound_dev_if);
>  
> +	hlist_for_each_entry(key, &ao_info->head, node) {
> +		if (tcp_ao_key_cmp(key, l3index, addr, key->prefixlen,
> +				   family, -1, -1)) {
> +			/* pairs with tcp_inbound_ao_hash() */
> +			synchronize_rcu();

My understanding is that the above will rate-limit _only_
disconnect()/connect() sequences. Since the former op is basically evil,
I think that the extremely severe constraint on it is acceptable.

Acked-by: Paolo Abeni <pabeni@redhat.com>

> +			break;
> +		}
> +	}
> +
>  	hlist_for_each_entry_safe(key, next, &ao_info->head, node) {
>  		if (!tcp_ao_key_cmp(key, l3index, addr, key->prefixlen, family, -1, -1))
>  			continue;

