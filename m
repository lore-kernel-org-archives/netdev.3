Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB924D09FF
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023821; cv=none; b=XLXB2MDLXbBOccV1S9l/Id5wPZRRLHuer5ib4QNNUjNPVGqxD+B4zqpb6U09llqVJSCKQVuZvjw3IfbhG62Vlq3DgG6742OQpwhDJT6nU5t+Db402dXmVAcOxTfdPfa7eNgrewvdp0l1Vpa3wYzE3Zq+dspCHVZeQef4nW1lvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023821; c=relaxed/simple;
	bh=3K8Eb+I83CUdRxVGCXUQQ3WdhV4CTwASv1dj1hWjeMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxloSncmlR6ZFYHBdLZCcamX3+xb+dZs24U3oRaNxXQNzK+qLpK1uoIFHaIgvQkCupeXftpU+4m6dHlIUDZvGhbnAKThzpb5eeduJeZjYrmmIibP9YsWNthL9pe/HOrQKOc4V2X98maWbtt9sE/QDfwcMexFKVMoAKKFaeRnKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcYK3XM/; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcYK3XM/"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e37c430bbso1635668a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023813; x=1790628613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yyjdCKnMEmCaPdT+aCEi89L+hag448HkiD8Oh8/mPNU=;
        b=WcYK3XM/pcB1qgTp+4lpeqJuu7ezehURnD3j9xE7j6gc08oZfdi66hTvxXAg/Msphe
         5BjGI383ZRntYHjjcdGRiug9NB+mfjZsKPSrPITYNRh6GoM4d6PXM+ZSgqJoLSTPrI9L
         jE3Wz6gDv1w5+oKozJ3mv5C5PlkDHxGto9S8AxFA3GpuAb60MggRsFTfuGOfSULf2suB
         t0RExfEM6kNhIU8Zv9RG/WuVz3rW1AWHhjnSATTUyJ4TJWFPPzvCvdfw1neXOL5Z7NWq
         Sa/YJ4z4xDXV3dhry68jdxAHglBfzTdXPueXeywtfSDBxldt6HtiPnREJx58zEETARqg
         RSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023813; x=1790628613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyjdCKnMEmCaPdT+aCEi89L+hag448HkiD8Oh8/mPNU=;
        b=XGcpwvH4nFEWXwv9Jr1cA/cIU0r0BwYXE2458gNT5M6n3GHwE74sJ6X74NRLc8MFwS
         cMDE/YeSH6NmEu5GxcbFtwEqGenc5ocX2+ttjyOCYAwLg2XLl0DUgFgxk7e1b8J5SQ/K
         tms8c30RbGMWkYaXxqnSDoL20NOf+koKC2IqnIHy4HK8D9My7aXSPzztvUJFVEWKFOPL
         qv/wOsVu9HhPTl8nWFwh9FiEWMVo9quTEIbwjgOJm8BZNhfWWrM2YDviM7A/PFgqYpx3
         +wMfuzIvVm3zmK7rGOM2ZQiZ/qcKkrViPZwSKWvlLcRsXIkRM+K2KS+3ev5k3yVVnYlw
         pTNA==
X-Forwarded-Encrypted: i=1; AKwUvBydMok+aDWZoqumVlQZkkuzqZkRANBOO+4vosJVFfsYAn0UFuCUwoNpBgZcDmPXjwYOxewuK+s=@vger.kernel.org
X-Gm-Message-State: AFuF++mkuF3eYvarlhiR8BnRmzLGSTrgrITl32oAtjKmc3wALR7/nro4
	7Vg8CWct3UZHS6stAkx8UnYAcl1Bg5UepKPAFodsf+MkBbx+HHX0yW+K
X-Gm-Gg: AYBFou111a2D+9hVXb89lP4AfEv//o0BP06GvLve4MsCDCElGrSf5dSr9o2z4jaszCq
	C/S8S7eFWp8NYJ9f68SFYDiGfEZGSTrw6VSgmElMhQcZMVUQcNQqAS76MnxhgXaqVdb5e527L2K
	DSke1k5EQRYlza3us63++56UTMmvp4mnh4BWQEZhXqTpOfeVdcr7INhX5789FrZpgdF0YntbvhL
	g2VhjaTQtgB4rlmdPdssaUQgBYSzFL5Nq3abn2GgkA6mcF2wElMpIIIrxFr13JyyzYWX5qim/cP
	tqPLihWk7yDsk2/pkHJpu+ZGj549UcwZdQsIO8CIPMpPXARjKOI5fte5wFpjIul9coGgcm6S8jc
	HoGCgPXSPlFyjOyhyX6fZeR/RanlApFcMNzgLVa/jiEhG4FQwvth6A6xEM8HivxaCCqCexay+oY
	f29H5UQArd5F9hQMEt8iU5imRuayLof7x+pCmddSRovhejLU8SNd3f4QOM3ukUIG1u
X-Received: by 2002:a17:90b:17c1:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-39e54e3f526mr16896686a91.20.1790023813036;
        Mon, 21 Sep 2026 13:50:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069a0c7aesm477642a91.16.2026.09.21.13.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:12 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:49:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
Message-ID: <arGYSbQ97ORDvSBl@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-7-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
> 
> Let's add a new kfunc to set sk->sk_rcvlowat.
> 
> Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> 
> For enqueue_rcvq(), wakeup is set to false because:
> 
>   * tcp_data_ready() is always called after the hooks in
>     tcp_queue_rcv() and tcp_ofo_queue().
> 
>   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
>     not yet accept()ed, and when called for TFO SYN+ACK, the socket
>     is woken up by sk->sk_state_change() anyway.
> 
> For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> is not called in that path.
> 
> An alternative would be to support bpf_setsockopt() for these
> hooks.
> 
> However, that approach involves excessive conditionals and an
> unnecessary memcpy(), costs we do not want to pay for every skb
> in the TCP fast path.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/bpf_tcp_ops.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index b0e14b54917e..3768b1440eb7 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
> +					 const struct bpf_prog_aux *aux)
> +{
> +	u32 moff = aux->attach_st_ops_member_off;
> +	bool wakeup = false;
> +
> +	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> +		wakeup = true;

[..]

> +	if (rcvlowat < 0)
> +		rcvlowat = INT_MAX;

nit: the same check exists in setsockopt. Any reason not to move it
to your new __tcp_set_rcvlowat ?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
