Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E64963B6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464044; cv=none; b=b6py7E1nkZ3UmyqNNQqM+gcVF/qrViFjU8dZG5HZ2M3OEHWHpiZPjgptDo1ModfsPg2hbeqDzonD3d5ZfpWGkROGOhJkZoRpqTX9kRgJkU9wM4xMgUmXV9OJTX0Rc79mugUny3Z58IwRwKnrkGC1BSEz1KoiF/kfm2ph/pISNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464044; c=relaxed/simple;
	bh=JeHG9pIy1UQJeD/81cUOb3EBRdHL9JOyJ6u+VtgVjwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCkcWEiuGaMjlAvtJafSsl4dgHuMBArP8Eo7DofxPMxJ9DV0wl900n26UTLHQUdEB7Dz2ctVrtFcNcLK1xQ4qb2tj4Es8VBpfHqdVe7m4/dn9loAXrccrf/HHw5dCVZCs4oTUyfOf9buLgSprI1wpEoyoUnlvWJdZHZleKBsAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2N6mnas; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2N6mnas"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2055573c8cso400805866b.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791464041; x=1792068841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZOOwNvd1LPWlNAalgBjKqL+DRKIx4sSQk3LcKBQLXIU=;
        b=Y2N6mnas+C7GFQW7uNyo8PktJDU+umDOsbdvPrw+so171d5enhf58pLFqj81zwbgpl
         yxyTRDQlvue/F9xBRZXGJbekme/+40A0EQ1Rbi/pA1Hx7iNgWhLlyh6c7vbxvTQY0qu2
         qp09tS+iq/C13zw/2gJvsFQaPboa/AV0Mxqk4X1hj54J5nTDRmfGT5j20M6efA3+Hgah
         /xhXalgsuy4/l/lQSnbxyd3GfvfaFAPZmsCKsFcnLB47t2myFSlcqw/iundf+kj+4dPI
         xs887GaoWdmreuXewswlSik+i66FMbuHIDBBzuNcoH6mzdKI6T7XhKWjKNCT7P3tuNhe
         N4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464041; x=1792068841;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOOwNvd1LPWlNAalgBjKqL+DRKIx4sSQk3LcKBQLXIU=;
        b=qXNrda55DT8no6GiR1ZiShBz90kv1DaD8HrgdJuh839BjpB0al6uCKM1mlyam1aDsn
         5TD75BTII7uYXibnIIJjOjlpdaR9Ahrz5gUmPKgqXG32l4zqRfXpGcex5/Vv0BGfIe0g
         7My116/gptOJDkUtyIvtjhp46d7rVlv8mQJ1hIoDEoOKGZ9CF2bg9q5xVOqT3uhkM1FN
         h1fa/axqslVqit4rrzN9QElWEfXUO5M7mgW+39Pj+Vo8/pV42D+785AO1fmuw+iHkibV
         uazXTVGW9gJ2A7A8O1klSaoRVtHm+CMjW/PZ5I4kXUEKMHlIteN255J0P3WsGdG/8kFQ
         Y1xQ==
X-Forwarded-Encrypted: i=1; AKwUvByr21CHukKYTLjOy4BGz8+4S0wZiTzVGm4cSaCzHfpV+NUoXl/xD3appB/dXdF6yx0OZ5JMSxg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJI7RGJPpQXxmCmuZwOlYxlitlWLwOvqgRLkSS8zbhF0BensY2Y
	mzd7yacmC36HemJdbGGskWtyvjoX/dwm7m9p9zBfc10sCfG14AQOVOyL
X-Gm-Gg: AYBFou2jLXZ4SqnbVk2TiyKf2xLXvQDenX14z6daqKPKDAunI6cHBR08B4zfxx6SG60
	B0zIkGTGg5sh51sAFgJS/ZTz5ZKbtjohrZGT5zfZLjP2E96Uz++bsGMsHRhJ+LE3fDkm8NNvZFI
	Zmh34MZwjVCeWNk/0UDe90AVOQwDkOgr4ouV1n6BhbFi8ozhTeJ/NTtJtYwbbyuas4qzee8SVVQ
	NgS9KhxlwqgLiqjQCL9I4ntboqHTyB+xVsy2Pe+EBi24DEZFNdcfZl10JTELLwG5uo19O+MYFBA
	fGBz0O7YiflTduT79DnrMUpKyKIaNg5N9wQOHQ1gVCaWDlt3rhxWl6/Ah9LplZdfvnNz4qs0aQs
	SBncvPA4tm1TiD15a06qmypSYrwDXAJfXFSUE2rjf1kvZI+2VfhxN8mObAEevUKpL6OUb76a2/i
	kIRv8nbRmijk2NHLwqqmq2kRIiKcYqIzE554Uzru7RYOMIC3llpuoxJ8K1ZUyuFwnnGyqLJzAyq
	uIx3MOHgN83xT00mA+uk0nEq6UAd0DQnPvpdpWDBzeAsjolfdMeqJlRi5lD+tSJoCwoq0rETJle
	uGXtYJH9g8m9KEfWjqoawYMNiRo+SodZ0KAK6Bjk9w42Z/Gb
X-Received: by 2002:a17:907:3d51:b0:c29:4490:50d6 with SMTP id a640c23a62f3a-c317c0e090emr525786166b.47.1791464040879;
        Thu, 08 Oct 2026 05:54:00 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c1c4f7csm220428966b.35.2026.10.08.05.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 05:54:00 -0700 (PDT)
Message-ID: <7f377853-ae56-450b-889b-688ec335e81c@gmail.com>
Date: Thu, 8 Oct 2026 13:53:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: reject devmem tx with fastopen and repair
To: Kaifeng Wang <kaifengw@google.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com, willemb@google.com, kaiyuanz@google.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org
References: <20261005214002.3226574-1-kaifengw@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005214002.3226574-1-kaifengw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 22:40, Kaifeng Wang wrote:
> tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
> zero-copy path is active and a valid dmabuf binding exists. However,
> subsequent branches in tcp_sendmsg_locked() can still intercept the
> message before it reaches the devmem zero-copy loop:
> 
> 1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
>     If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst with
>     NETIF_F_SG (so zc == MSG_ZEROCOPY and binding is present), but
>     tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
>     copy_page_from_iter() to byte-copy from the iterator. Since iov_base
>     represents dma-buf offsets rather than user virtual addresses, this
>     misinterprets offsets as user pointers and copies arbitrary user memory
>     into the SYN packet.
> 
> 2. TCP repair mode:
>     If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() similarly
>     calls skb_copy_datagram_from_iter(), byte-copying from the iterator.
> 
> Neither path supports or makes sense for devmem transmission. Reject devmem
> sends if Fast Open or repair mode is active.
> 
> This pre-existing issue was identified by Sashiko AI review on commit
> 125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
> hit in production.
> 
> Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Kaifeng Wang <kaifengw@google.com>
> ---
>   net/ipv4/tcp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 87ef6d5cbfeb..225e758c194a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1169,7 +1169,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   			zc = MSG_SPLICE_PAGES;
>   	}
>   
> -	if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
> +	if (!sockc_err && sockc.dmabuf_id &&
> +	    (zc != MSG_ZEROCOPY || !binding || tp->repair ||
> +	     (flags & MSG_FASTOPEN) || inet_test_bit(DEFER_CONNECT, sk))) {

It becomes unhandy, and taking into account the issue Stan commented
about, I think it'd make sense to do the checks under the repair and
fast open "ifs".

if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
     !tcp_passive_fastopen(sk)) {
	if (binding) // fail;
}

if (unlikely(tp->repair)) {
	if (binding) // fail;	
}

-- 
Pavel Begunkov

