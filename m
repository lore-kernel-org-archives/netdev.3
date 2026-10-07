Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E563290D1
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791414399; cv=pass; b=oOhwFevIxMdNEC0zrL1Qtuy2kHFgvr4Q0W5KHhgvJ1XrGM9iwwAfic6mduyjkNqiVOChHjmWQCMFpNJEOsQ98/DBFTS3vZKc/WS9OAgfGeeQZxmSP2Q0GnZ9jGwV36nFBG7bcJCkEK53rPOQBgnWYSNlL7IE98DBvOzUgQzBfpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791414399; c=relaxed/simple;
	bh=EnvvshmgbGSgmvOAQQYj95OI1ypuk+0YI22QHqVZUZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSI/knNvnqoqQnmbwtsAqUbNe3Q09Hny8HTyTnAQ3RNBiC1/j4HDyo5Q1i4KP5S2kbYFOsYAIjKyv6NJDFuInp7ZuEeyjGJbnqXYoMBkmKq14Dd2rdhTwu/GX25m2ry1UYg75piSyYVQsFETCUasRNhDcU07dHVLecZzk859TvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUyyrPcG; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUyyrPcG"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4f59e61f295so1606555b6e.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 16:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791414397; cv=none;
        d=google.com; s=arc-20260327;
        b=eWGGxRe7FVuiV8sJIPKhMxkJ2jWwcD85T7qCb3+2abMemwAOUhxzAbHJCunM9gSZNC
         8C5pJcN3dSKHPV8WPoF6zZqi8J75tAl2wbd+VAfK0Z26uX1JHHPOjHCBJ36mxscDZLhn
         yh9f/V+zAJty/+cz49XkNEROtn6Y45yCwejcm+mTbOo1m6xbq+cmsdzocbsC9pbO2k0x
         13QuHcLOgETdvX6BfSCaFXeamkAeqStZdaYURGIswMMtLMYQheanlWx/SLLuZdA7Dhx9
         1C5V95cx42lcmWWTA/ymM3m3GOn8qPAh0fmY8doMMZi9U0Kb4UQHL7C4h7iksPGbBEAY
         YMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bFgc6Xa0HunmUOCklAqPECBS03DSMGCin3KVDvL2wI0=;
        fh=bA9KlzdNihZdOAI21B51cNIPVjjyvpIBQLga7luG/R4=;
        b=NxQGe4Q8p9tOqQR1RxjGjyVwBSuApkUmEehhlcP6LRKk9fbx6jOpEQBy4EnFkhNMZr
         o11WQHUzsYX0tLhadgXmY4lcxk10P9UbjLBc8TIeVf2Cybx/eUej0PksgDICf1XPmcj5
         BY1m5vnkCSuSCUARMW3oya5nwc6A9lWvcYMjGRZeEWs9dWbYycAPGYK/ZAXh79s9tHkc
         WLCgy0THehyyDjZFc5aJCN4CO6AQq/q3ns7Kw13bWYoX70OjZ9HtzApPDlAIdJTWhPYv
         i3sQ0ajxOVlpBBL6wz2zd1YKKUHbEQ02U/C+dabCwtmCmt9nnlV6Q9uUOzsodn+8srvP
         vYQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791414397; x=1792019197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bFgc6Xa0HunmUOCklAqPECBS03DSMGCin3KVDvL2wI0=;
        b=PUyyrPcGsmGngBy6k64QNb63RefIMBfG6zIc4s3O7MlIlsewNXO3rCLbKjWi3NZqyt
         oM9no60NswYdJEaNLzI3II/geq8yH4RKuO0SocnfLhYiz5wsL4f39YVTM5xrofpzM6L9
         2J9zxfAzAFX2qegN3qWYvZBlWe61OajX7CUzKT7FgL7zCZs91KKJuQhDVnKDljzaHc5N
         3nR+MN57QiPLw1TORAc2wC267HqEn9vcMOoMbMisIKMOLh4idcxJnSmqOM9jx/CkaeXs
         X7S4taCeXFkasMr8MhuNPi8f+NGBEvmXAmRq1/HkRua6DOc2EZUZOUMY4eRLDV2yc5gn
         Yerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791414397; x=1792019197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFgc6Xa0HunmUOCklAqPECBS03DSMGCin3KVDvL2wI0=;
        b=SUv3fA/7joDZktPyVKEH0kR+r7zZreupPYRs+lM+RWKZWmaNH/aPNiFvVB7xgfbPYb
         kdSRV2jfwtFBdxQl7I/1D5rGszHa33kbrE4YmPakROAiKObhRxPN5URRttKCklwAfe2W
         GmZGLHZ+YkXFTChucfxHIx21+tArudaAldcAXmIttln+nbN+FbRsCFYdFNQhLcrrQV8a
         iYbOTLPudcqlU2e+G0zHVvjzqjK8SrKN2l8WZDKblmuPZ6e1aa9xqpC2Zrsr7Pe4DqL6
         LSBjuQhfXl6EOMFMFhPLWYu4wajMtuhi+tJtgl4xx98FOebtcDJBbRV3p6ElkmSDDm6P
         rqnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxK50kUR9YdCumaf+BhtJfQbVS/l2J/abcULJau63u29ewr8uxbjuKfp5bnOXQy9bBS16j4wLk=@vger.kernel.org
X-Gm-Message-State: AFuF++kMyndxPe4jiTYkxvppX5W9YHj4yZaCe7t71xexSFX5ivaK4Wu0
	oOPyUiZrMKk/8SyuLjFNPyi+MEvi5UqRbXuqV41NwxHsmLJMJGYUiw/L2xGdmfuFLZ/StAg94dX
	xXgBZzvMKLuXoDVOWVIZAx95VCeM9qcs=
X-Gm-Gg: AYBFou1+njzOYCazNmUEkrFxQ+JTRw4MMXL2k/FOaJ7cRz5sT9SSUazZy/jPPm7IaYt
	dk6RnEQKaHW2fiIhyhtXdSKAghDVR4C9+wq5h0Mbm85z+/q14/nlBCdRzo4w3EzjbAshA87XEa/
	lwKIdhd+2C4ljTB0nWYPa5GSqVIu+yHpzkNx/bSKo2atxYgBc/YXxCvm/9xr4AFLUTbJcKX0TPB
	hlb/Z+KONUBmPvHBdKBv9RbGrLzWrWgec2665DM8djrC5Db6Db78QDlL2insuTORfFtLjmYbJPz
	NAQHzNHMSpADKZuE7TJeyqsYaVwlP2yXGUrPDMnQhwLczPPUyz1rxkI=
X-Received: by 2002:a05:6808:e85:b0:4d6:93c3:1af4 with SMTP id
 5614622812f47-4fc47fbb12dmr3546235b6e.63.1791414397006; Wed, 07 Oct 2026
 16:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-10-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-10-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 16:06:26 -0700
X-Gm-Features: AclHuK8EIBBvyKTE1JSHvVhz8LqGQYZ8HmQ0k4B7XhTAoNdBmoS0E8pU-kNmXGQ
Message-ID: <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
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
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  net/ipv4/bpf_tcp_ops.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 8182037c4269..2ba73dd6c52c 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_so=
ck *tp, u32 enable, u32 disab
>         return 0;
>  }
>
> +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
> +                                        const struct bpf_prog_aux *aux)
> +{

Is there a reason this takes struct sock * instead of struct tcp_sock
*, like bpf_tcp_ops_set_flags() in patch 2?
