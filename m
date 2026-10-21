Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595879;
	b=vQjA5o1e0Y3YLd+FYjtVqtJCnLiIuHI9FCk7eb7ttNd+RSXHR1TUEcrr5Ou1//YI0mDm
	 B+oPZvDTteGgyG2rZt9/3gEb0HTtaOZT7TRJgYuN8lYrOD4pSqZ1Ha0gIulXB7130MVus
	 a3dPSHJx6s0Phz1etDZL5jUHHfCHzxpvz59McQmawGzfkwi+Pwzm6rm0Lmo/6BT7AtbSV
	 W056zkQqhxcvEDdlt0t42Hvi8oSRBCw0zCUzI4Q7s0Pk55baYUwqz8pO6y1zvrQdmvZSL
	 YeEnFllnRmamTP9pr53LzA9vqlPGzaW6tUgLP/1KaVJ8hyyByHrZVHfERm1dq5dnAoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=al6Xaqlqe8HbpvxY2MxnJnvwLNXFlu9MoZN3ljeVL+A=;
	b=Pim2Ne7K63D0qRRkKacB+tBxDN/a6H3LRrq+dVTD3bV9Ld3JhcaCqASG/eIDbUKdfHeo
	 7z7xmS9NLzkGQmdIFBhe2SQTcXbFXTovoXhL6muPel2GCn0OhwSHp1SRp+jV1JhJrgQF3
	 07f6i5kj4YwfSUqFmPHJS+AAhAma9OJCouYO/oVsvhiVDQo3b0m6+bPNz8eqVDm8iaLff
	 +P8Ah68uUaHTvDE2QHxJbWNcb4qoVTNLkpFbn6sBwh0yoJ1p8eW0CDd4iQauX6qhjOwmN
	 j6yRYHeVcI+EmXf4W0hDde5ijeWHKVOSUzceax2rWXUy03GgeuyFcfyW1MMML08ApEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jeVfvrFo;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543160A2610
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D543160A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jeVfvrFo
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1355076f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792595877; x=1793200677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=al6Xaqlqe8HbpvxY2MxnJnvwLNXFlu9MoZN3ljeVL+A=;
        b=jeVfvrFox76iacof5DwlJOiGjsc5wKQ2ilcCG833j8D0APpb+yq+mW0Gjhig9eGXNA
         iYmH9QeuuzMv3C5yqN9F3GzTOiblWAAmaumif5ajn6r83RtauOtIrgdrbe5Yc/Pf7B/J
         Znna9SHaiBpgx1lmaMcZ7cZe1unLBIkjXdRgkt6OxQT2D7qaZ5oaGpW+6xbyRgM8ICqw
         LrZ+2vdGMIKRBC3pbJ/nmIrKzeqD82yRc5v8RW2Sd44FBW4r/pN/r9E6PksLKAHa4oJO
         l8lPn/JpbLl3tJr5IG0eyonCUWXudHVfrWbfnFxlMQNGsiCLmJ+fh9EpIU3JxWC/a/Vc
         gelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595877; x=1793200677;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=al6Xaqlqe8HbpvxY2MxnJnvwLNXFlu9MoZN3ljeVL+A=;
        b=B75/4v7ZX001SXr4skmor/NSHCMGLXHK745G73XVUQIA2FjiRl4UJIpm5UuabrDzIQ
         ZAPkXgr486TLySzIg1enQqXCqxwxJyrau+blj5qWQhR9xJ7GhrOYiQMtPRgmFw1LnezU
         LJf5RJV1O75rtpg6zShn8R5t64ZNsgO5+gT0awfsg6p9igPubuZ2ec/Ih1yvwByH8vD/
         0UUbppFAD12Zs4FtzSxRJ/asEbLt3m5Gih3Q3ocQzFRCizbK0fo2w46ej7o1iQ8hCve+
         rMQya+P0qaAJOiX00SKh21lxbtUs05IPj1kpH6Ci+714m6NiElGkvym90H/QrsFZgfta
         mjFw==
X-Forwarded-Encrypted: i=1; AKwUvBytUcjbxZpJ4/71jBbWdgBpMXBAwbGtHQVXE+jfd9dJdgDfhBWMefv0wmIvpYTGezct5E3qGJI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0Pw+l4ly76eTtmQqOQqtzGhsrSkL/XoeaFnDQef5Z8NHvqEvu
	b/0hvViv4ivwSNrQUhVFWlbU7HRPMsDc45SsLCzpM+obehB9PRu6+KyV
X-Gm-Gg: AYBFou3eiCnDhPUFRpslaM+jBky2DBQWJvcEQhyLcDj6NAZ5hp9x+H8l/a1W3wHqAM3
	bHJ1vlmkFIAqZACd3qcOz/WlWkxeDJeQgjYZ2ymv0KQpkMeeBVTvvWoqTpKbGyBMSxCtL9Qnaz0
	8GasqNEoB4Lrx5mJDB8/+lQE1LKsLeRa2FtHYRFFbJiM6BnBb74jvElpGD/g3++tZMJzFoD8Qqs
	OpGshEJHY8Pbmg2nnqE5tiPAC560zV2/VUhUIeDbsNUw9MBnikCz1eVBCkvtPTREcdPp/Fw2Mne
	ipfoL0fr3AHsOaJBVJIGdXdDwO6y3SeHwQ7d2SCFhthKefwIx7J9GGabDZCuMH1lSOBoPy8AT6B
	2hx8PyYQK0o77kwF5aj4MqZCCJBdr7vUlFn8XlBcn3vX5sxhezepPOrpYcqJGbu1AnEKXLBh7dY
	fTV3ZOjyKiFuG9yMUvJ/Oe2h7JDMpqc2oycGTWrtECt5MmuMpt+xPgWzTTs1Tn1chRbOfU4EkSq
	EdfPtd0h3tHlCKv3MP1jjW0Fgu45s0uynZ8y4iqybYaDuxt8PJEXFsSbhK6bi5/Dw1Gvh6KKIvE
	xCyA0iIzfKL/dDoG5dnqIiCsoC6LhZpsxEELkthjYM2FFlLm0D+Y6EL3UocX880Iq59DEFL0fcB
	Q+xcXkOeO4bHJql6lXHi8kHOe2uK8
X-Received: by 2002:adf:e010:0:20b0:48a:fff3:f9c1 with SMTP id ffacd0b85a97d-48e1e7d24afmr9521204f8f.20.1792595877202;
        Wed, 21 Oct 2026 08:17:57 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-19.dab.02.net. [82.132.213.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25841b5bsm6169600f8f.47.2026.10.21.08.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:17:53 -0700 (PDT)
Message-ID: <4d5e00b9-5081-4530-ade5-41570e4a5b2f@gmail.com>
Date: Wed, 21 Oct 2026 16:17:55 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: reject devmem tx with fastopen and repair
To: Kaifeng Wang <kaifengw@google.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com, willemb@google.com, kaiyuanz@google.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org
References: <20261019174522.55644-1-kaifengw@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261019174522.55644-1-kaifengw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 18:45, Kaifeng Wang wrote:
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
>     misinterprets offsets as user pointers and copies the caller's memory
>     at those addresses into the SYN packet.
> 
> 2. TCP repair mode:
>     If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() similarly
>     calls skb_copy_datagram_from_iter(), byte-copying from the iterator.
> 
> Neither path supports or makes sense for devmem transmission. Reject
> devmem sends inside the Fast Open and TCP repair branches when a devmem
> binding is present. Checking inside the tp->repair branch also covers
> the case where repair mode is enabled while sk_stream_wait_connect()
> drops the socket lock.
> 
> Additionally, drop the !sockc_err gate from the devmem validation check
> and return sockc_err if set. Otherwise, if a valid SCM_DEVMEM_DMABUF is
> followed by a failing cmsg, sockc.dmabuf_id remains set while binding is
> not acquired, allowing the Fast Open and TCP_RECV_QUEUE repair paths to
> proceed and return before sockc_err is checked.
> 
> This pre-existing issue was identified by Sashiko AI review on commit
> 125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
> hit in production.
> 
> Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Kaifeng Wang <kaifengw@google.com>
> ---
> v1 -> v2:
> - Move the devmem rejection checks into the Fast Open and TCP repair
>    branches directly, also covering the case where tp->repair is enabled
>    while sk_stream_wait_connect() drops the socket lock.
> - Drop the !sockc_err gate from the devmem validation check and return
>    sockc_err if set, preventing a valid SCM_DEVMEM_DMABUF followed by a
>    failing cmsg from bypassing the check.
> 
>   net/ipv4/tcp.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 87ef6d5cbfeb..2792923f0748 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1169,14 +1169,18 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   			zc = MSG_SPLICE_PAGES;
>   	}
>   
> -	if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
> -		err = -EINVAL;
> +	if (sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {

I wonder why it does sockc_err checks like that for devmem, e.g. instead of
failing earlier. Maybe Mina remembers?

> +		err = sockc_err ?: -EINVAL;
>   		goto out_err;
>   	}
>   
>   	if (unlikely(flags & MSG_FASTOPEN ||
>   		     inet_test_bit(DEFER_CONNECT, sk)) &&
>   	    !tp->repair) {
> +		if (binding) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
>   		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, uarg);
>   		if (err == -EINPROGRESS && copied_syn > 0)
>   			goto out;
> @@ -1200,6 +1204,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   	}
>   
>   	if (unlikely(tp->repair)) {
> +		if (binding) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
>   		if (tp->repair_queue == TCP_RECV_QUEUE) {
>   			copied = tcp_send_rcvq(sk, msg, size);
>   			goto out_nopush;

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

