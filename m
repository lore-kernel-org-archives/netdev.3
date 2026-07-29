Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF183CB2C7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357017; cv=none; b=hbfjdTEAUIP91jjNIuaNAH2l27bGjFF2zhavJShfu/9x4wh4a3nuH6T14Gy4tQBCNqajk7GqskjnBQK945rKH5xdO/9rGoCRKeVu2GEjmy2v+dDKlv8OfPwzrEwp5BvR6AbUqNWvZXd65VxTC6aulrv1GgyTjclchNQ9CNYZhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357017; c=relaxed/simple;
	bh=TIzvQ5yYUuwHOZxSzc2URBeJxr0Wj/Wxqs1MuDtXDC8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LI6S4OtXHAwFXErrzZu+UOnJZfZSM+ilNzZ3LYndUjO/Jl2DUohq70dBL45NwotmmKvmSuk0bJoO80E6awOxJb+MXnPfxVKetzW2VAXRYGt3B2ZAEiksnzk2U1NuKG/imUDK9w5jyx/TyPqXKF4diMDBzFKEWZ1oywy7qAMLHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ILueXSB7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ILueXSB7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2097490b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785357014; x=1785961814; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ShSGDIdvDY2A/E8agT8O3gUlL/J2ljN0bWMP2ClUyTQ=;
        b=ILueXSB7NLb5Z1aBP+Qf6+F5cgvclFLjwcELWyebY/DhPKlW1g8spxk6rKUYM3rRjG
         4KBLmwAr27KsxEu5z/bp3q4ozih7fv9syKSA03PhqklerNlm2hs01ct1/ourDeCgC4Xi
         cv+u9U/n/AGWOzuFeCiUGW3mrZ3uIhzKYcVPByN8m4k8be3VbWgar2B7YIx3MbuKbwwR
         qpgjkAClNZ2GJdv63DZyz9UzOnk8Ck92Rxw14sy5NaRkHVzeLfDuzWBiZnCQeIN80kRI
         4FMJnJ888kVYxPw/V3DUkXcK27zdj/P746M6NKm4UP6nfbXiy28SaXc5DNzwVvJXW97c
         /3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357014; x=1785961814;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ShSGDIdvDY2A/E8agT8O3gUlL/J2ljN0bWMP2ClUyTQ=;
        b=VaCbMYto46xxdu0fJiAMIIf9QiqABqlWqvmADGUytraO2AJToZXCLinuE6qFzOvcbt
         L8gWueqIB3tlPMSA6d8WwI+bBTbOzlRh36gUIkRH3cWFWpLKvwUA6Imo9c5mhblG393R
         N2tGxOpAhLkUAcs5erWZJg2EJOor8rRRNQqKCOFF5Y1UqkDuet02+NqO0ZxC3hXy7cHQ
         yKwmDHqA6NUK6BZV9+U86dj5g8P0T//ibcfr1/k1t3cMA3eDoQpfkTiTmENtElWDqT4d
         +pwFpBQMEwtv4MZgINmOL6NBlZyX5R6km8ZX0HOWGsfYm3pW6SprqUYKRR2Njz9wUmU1
         6GkQ==
X-Gm-Message-State: AOJu0YzmpwGLfd6jQwW+M4sQLJEedYNH6EMZhCSWKG/zo0k6QN+dvbhI
	I8/Wi/mRK/nMojH5aL7EfdOKb4XATAkVhFbDj04zDTKFO2syogKk0s6XCuNgtqNNZhM=
X-Gm-Gg: AR+sD13nMg6ftUvdmSAapX0SWdHU59sncI3UwdDITgi3f2Hy4tLJByw1Yqi0pGpMkAt
	SwkYTe7tIg32k9XeQYVyM/npVWmxKhDM27Di7c9yZbNSxJGY+kxqTz0E7bIKcftOPWwIjCfz1ac
	+09Hp2Lmku12ulxOokNVVCppQkiyVs5GsRWEEuZond4oLqPKXSftGjNDQEhMjDqBIgxX4c3A8Tt
	7r/Hi7NgGkkUsPExt/SiSuKf+ioyW3LoMO7Eit9RXZA17EX3eRmbSg3775Z3uzI+3Xj3m9r47js
	mVBi0TG+b9omnJQ+je9wyk5M/zn6092pQVvBH4AcoN0PAInxbKUUS2iHeaftc8c6FXhPCouUk7W
	vKjmQ6zQVY1NJAmM8YetUDR96xJjjDkNPcfqxY4loLSKDFQontgiIE0lL5gnRrcmmwdjqwac/Pr
	mdPlO5L41pLsAT1oTSN6EGNqtNts/1CILhJ1JrFQ+J69W1FxxGgqxqJ7k=
X-Received: by 2002:a05:6a21:112:b0:3c3:7bb9:c93 with SMTP id adf61e73a8af0-3c8ba61523bmr9792974637.53.1785357013468;
        Wed, 29 Jul 2026 13:30:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d447])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm19441406c88.5.2026.07.29.13.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 13:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 16:30:10 -0400
Message-Id: <DKBC8NVXBTW8.C20199U1ITBD@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 2/3] bpf: Extract shared reqsk-to-listener upgrade
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman"
 <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Joe Stringer" <joe@wand.net.nz>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-2-1bbdc58ce514@rbox.co>
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-2-1bbdc58ce514@rbox.co>

On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
> __bpf_sk_lookup() and bpf_sk_lookup() duplicate the same sk_to_full_sk()
> reqsk-to-listener upgrade. Extract it into a helper.
>
> Leave the currently unreachable WARN_ONCE as a defensive assert.
>
> No functional change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/core/filter.c | 57 ++++++++++++++++++++++++-------------------------=
------
>  1 file changed, 25 insertions(+), 32 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b446aa8be5c3..403aba3ce891 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7074,6 +7074,27 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_s=
ock_tuple *tuple, u32 len,
>  	return sk;
>  }
> =20
> +static struct sock *
> +bpf_sk_lookup_full_sk(struct sock *sk)
> +{
> +	struct sock *sk2 =3D sk_to_full_sk(sk);
> +
> +	/* sk_to_full_sk() may return sk->rsk_listener, make sure the original
> +	 * sk sock refcnt is decremented to prevent a request_sock leak.
> +	 */
> +	if (sk2 !=3D sk) {
> +		sock_gen_put(sk);
> +		/* Ensure there is no need to bump sk2 refcnt. */
> +		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
> +			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
> +			return NULL;
> +		}
> +		sk =3D sk2;
> +	}
> +
> +	return sk;
> +}
> +
>  static struct sock *
>  __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 l=
en,
>  		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
> @@ -7083,22 +7104,8 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_so=
ck_tuple *tuple, u32 len,
>  					   ifindex, proto, netns_id, flags,
>  					   sdif);
> =20
> -	if (sk) {
> -		struct sock *sk2 =3D sk_to_full_sk(sk);
> -
> -		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the ori=
ginal sk
> -		 * sock refcnt is decremented to prevent a request_sock leak.
> -		 */
> -		if (sk2 !=3D sk) {
> -			sock_gen_put(sk);
> -			/* Ensure there is no need to bump sk2 refcnt */
> -			if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
> -				WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
> -				return NULL;
> -			}
> -			sk =3D sk2;
> -		}
> -	}
> +	if (sk)
> +		sk =3D bpf_sk_lookup_full_sk(sk);
> =20
>  	return sk;
>  }
> @@ -7129,22 +7136,8 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock=
_tuple *tuple, u32 len,
>  	struct sock *sk =3D bpf_skc_lookup(skb, tuple, len, proto, netns_id,
>  					 flags);
> =20
> -	if (sk) {
> -		struct sock *sk2 =3D sk_to_full_sk(sk);
> -
> -		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the ori=
ginal sk
> -		 * sock refcnt is decremented to prevent a request_sock leak.
> -		 */
> -		if (sk2 !=3D sk) {
> -			sock_gen_put(sk);
> -			/* Ensure there is no need to bump sk2 refcnt */
> -			if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
> -				WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
> -				return NULL;
> -			}
> -			sk =3D sk2;
> -		}
> -	}
> +	if (sk)
> +		sk =3D bpf_sk_lookup_full_sk(sk);
> =20
>  	return sk;
>  }

