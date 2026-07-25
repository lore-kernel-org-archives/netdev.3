Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72931E848
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937610; cv=none; b=Y7dCK+Ryc6VQ2PlWd19xiZf0kKTUjNjpMZ2jfucE1Ic8knS7Sf+geKCtUoMIN1KUaMJ2C/V2Iv01rb/rJSSgZhYTWwPvOQDwK2FjqvFmU4lY02qfTo5ehUbjradmP+JOJEzAlwMUUmSY7JDi0inAXiPt0+nk5ahM5VoiD7BQ5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937610; c=relaxed/simple;
	bh=wqzcR2Vb3YK2LAiR+yOwfa+Qq5E5XeCpf8ZN6x3EZZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XALzwBO4nnYbIdfy0AQiqFqqFkYSuTD3GiKCN/5ZhWORzJbE6ktDz1RTf3ubPNAAYerTqe3tIMcLVdHoh5TQyRnO7Yq/r3fJgjypjUzbd+emrQjROmjKpT6yO4tdhE7FRkHY/nU9suWRBgsMj+gxkCaA6tOb7FJJNL/n4+O6xpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqvmOCDB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqvmOCDB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485b358552so1056343b3a.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784937608; x=1785542408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcfP1cCpEbGNIQWuA4I35j/s62A27Am7wlHhwJwCgdA=;
        b=SqvmOCDBUFNxIXmlz55nKwKkV8F7azt4a2KqNZyFDCJCxz4Vm3yalP4T/tLmah9Fqr
         xNjmRhUE52Ri50JePHkkHqKGEKFpdrX+RT0BHje6e0gN3WviacvC7Q5WLMrqSsVhIcow
         o0+097TyCt+/0D5iAmvCSgpy+TSS8CUEc4HBxwtUFHlXm8OLdjzVHQoxlTtqYr0R0HlC
         34vRbCtsWNDf8ratET2IjRPziFNNXN5HEsLiz90NKIjmBKHmjF9s/qJ0wZwTTW0XqaB5
         kdms7R07w8MmZ2+RWPAdWPFU9fioxVNW2oWvqjoG5hPQRbUg1hkPVrOAItd5wlXWETdF
         nRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784937608; x=1785542408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcfP1cCpEbGNIQWuA4I35j/s62A27Am7wlHhwJwCgdA=;
        b=iEg/R2RYhz7AZpuIUFQsejbEyc3BMcYX1ipWEX+JQhMux9gN1goDhog+hBMhbGT6HY
         cROoii7H/6V+WNAhF7v5uI771hG6vgvgtFmOwR07XpbCYAJClbH0uNg5qqyBAyWBf95t
         RV7W3b99kCSpRrgueChBTxwD/ICyRKgagZDOQ/99/TCJpU22q7uziw4eLkoWQCkUBhdH
         d3s/GSo9R/J/aZ4LTrb3JwkMdcfti1xSNv5cyp0ySEBDssUymTSAe1Ny3ePnJ2v6odAp
         P8VI1koJ1KeoDjKGzbunlnbPzSt53N+gr5OOv1QamWHczmzmav1rCHyPUax5IrPVw1+E
         z99w==
X-Forwarded-Encrypted: i=1; AHgh+RrHZuvPAHXO5EYLyMsZfaNhHsw8bmmBR4KeZyUvcU4QWxMciUSBtvK7q64/YI+cpTZkvJY3zpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWEwLCVAQoZq1Ko9e81sIcMN9ai8RQvZhowml8LSgw11KvEsL
	789khcdzcE2MiSCWk1vnigxJUONcUzhwCkZx13tINZVzKJszXrElA07g
X-Gm-Gg: AR+sD13TPhaG74TVIpIxxrJZShcQnlAtJ9AqRJPP0UuqUOIJ0hqtty/ElW/AQ9eAzV/
	qSQ2hTaQXK6KrB+8qqJC3/qpF1OlInxN0hH4tHz6PdztRpZHSIfrAkKmE4ikYQhLMPgrVoA/7vB
	DYDG0LtRGRNHy8o666wutzlJqvgu7t4x4uUHA+KPLvqhYh5qYij5vRdqffemrqxZfHRLs9D7L1w
	gX4eUx1opmyc03XbJgjz0OvQFkiHVNmeZ9zTG2iXd6pZXhJCulu5KnKemctOHYd/tNZxqZqro1N
	TntQr+i8QfGOG2AL+CIXJ+JNCftlOrOU0HLTGArGHdRyvoChHMtNIkPEg/yp/t+VgahXKw7LfuX
	oh4mcGFT2B6TBoWr14cHaTiw/vaDQLwpuzJfnfZSedSe3x8LV9KkUayy1ZqbFupyGJuGZynIYC/
	Ct
X-Received: by 2002:aa7:8896:0:b0:847:9745:2f83 with SMTP id d2e1a72fcca58-84e59435becmr296556b3a.18.1784937608025;
        Fri, 24 Jul 2026 17:00:08 -0700 (PDT)
Received: from john-p8 ([98.97.42.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f22fsm535936b3a.13.2026.07.24.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:00:07 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:00:05 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Joe Stringer <joe@wand.net.nz>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/3] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
Message-ID: <amP8aYwtxo5qJUEb@john-p8>
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>

On Thu, Jul 23, 2026 at 01:33:27PM +0200, Michal Luczaj wrote:
>psock's hold on the looked up socket isn't dropped until sk_psock_drop() ->
>queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
>entry is unlinked and an RCU grace period elapses. Since the lookup runs
>under RCU, a non-NULL result guarantees sk_refcnt >= 1:
>refcount_inc_not_zero() can never fail here. Use sock_hold() instead.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---

Should bpf-next right? this is an optimization not a fix?

> net/core/sock_map.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>index 9efbd8ca7db8..ca49bc7f8687 100644
>--- a/net/core/sock_map.c
>+++ b/net/core/sock_map.c
>@@ -392,8 +392,8 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
> 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
> 	if (!sk)
> 		return NULL;
>-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
>-		return NULL;
>+	if (sk_is_refcounted(sk))
>+		sock_hold(sk);
> 	return sk;
> }
>
>@@ -1218,8 +1218,8 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
> 	sk = __sock_hash_lookup_elem(map, key);
> 	if (!sk)
> 		return NULL;
>-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
>-		return NULL;
>+	if (sk_is_refcounted(sk))
>+		sock_hold(sk);
> 	return sk;
> }
>
>
>-- 
>2.55.0
>
