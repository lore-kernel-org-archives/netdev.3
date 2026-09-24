Received: from mail-pj2-f32.google.com (mail-pj2-f32.google.com [74.125.227.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA33E5A03
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221703; cv=none; b=Y8Cr0bo8K8dgVdP4tF+iFpPlyoZUAv4vh9FogtRg64IPvpgbhkRgeaGQpaa9xIJWIpB9bWREtblv8NTI6dMA1RVH7+d0WtJJBItsg96merG0c4//0GSUWdLVlpXIcK6Y9eu4x0Ml+qer9hTsjej0TneNXHSKVy5wOq3Nul7zWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221703; c=relaxed/simple;
	bh=u7VfKm5rOaDl8d0G3ZndWq3QuUaMVh/vqQ+AIdsZlfc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pHSG0BAkCY6bREH/yo1KOsWkw1tS+rPI25ESz4CIqAwdUBG3YvguVmoB8sSeUkgPlmtSLYpPj//pfEAM6LshJGlA0eJPPM7h3OHVrUwgCyist5nqVpyJdOPktOFv0Y/PDK5H9rok0jUpYe4nTsAcsSs12n/CQWLIucVcHeHWa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qHcjRU7b; arc=none smtp.client-ip=74.125.227.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qHcjRU7b"
Received: by mail-pj2-f32.google.com with SMTP id d9443c01a7336-2d747f05ffdso7498895ad.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790221699; x=1790826499; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vyH+46wvVCG42WHP8ZLxeKrUMVBuwkf4fMiMhZ0rDTg=;
        b=qHcjRU7bbGiYDZYWVQtKUkV83qv8owh8mJxTgCs4rimyrFHNg0SfsjWzB0NxZyuj59
         VmW3tm1Kuf7XNt3r2saoVM1QVB6XSXCSgHY0TwhiIR+kDnQjxYvpoZ6mXxFduTc8g/ac
         ex10OZleEzSJkkN8bdQfND+qFw0+iOIeuoBLlXLcpMYD9S6vPPW4ewCSN8L4hHK0axqC
         xPawEIGL7LWzhINI2GH9TsfpZvUT9BSwDICnyAOumWFNJHWQkDfjjyTyxwr2d/MiKQjn
         qPmnUDb7RYQ6GoMfDUgU3IWDZXCYhwRgV+0MO0NfKIOKxiRmSwRmSHwl2W+cfCJYodCH
         3yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221699; x=1790826499;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyH+46wvVCG42WHP8ZLxeKrUMVBuwkf4fMiMhZ0rDTg=;
        b=j1XXdR4pUYZRgg32tWyySEDpu3InkBKcf45I0n/UCtMiCjXVBf6o61xW9fs/Oa5Jvr
         vzq2oC1LNNnT5pqzhJRqJAUZ7+/tuCGGsxeFPXkJVad6f96L1dBpnwfRujbK4GR+WRoU
         P6NaM4dEbwjmLWOWWD3I3py/WqpsmDMxaStcp12sCzxS631aBBDzPj+CpoopNIGxJJ+H
         nYHGuxpwxfz2Kul82J7rQCaK9i5eHtKt+aazESWSKAIGJkQ5c2sbFbRc0R3KMZAS6ZVb
         me1ZgCI09dn5sDxGSoyYVXam7vXPOiwTg5fvJDf14ZYl6+KyJD1bW2xdkNvqXXXOkssU
         C3xA==
X-Forwarded-Encrypted: i=1; AKwUvBx9uJ8iCDwA9ROqY+dBMxaJ1lTt6GId3RT/tOUl2T+Yl9aDgVPi3udAP/yZxs0XoZp5IGfIjr0=@vger.kernel.org
X-Gm-Message-State: AFuF++nipRYo5faJYm0bL7s2+fFtSp0eugNafBOGUioVXsRNf0HQYjxS
	4dxZUWmRmnCNtSqWPdjXn9V53YmhCgzu9CKWzyYOGUyKtsh/ZoFB/7yHa3KolXdNpPM=
X-Gm-Gg: AYBFou1SApTjNpl5s4YHeCObd2hXz733zixPyOt0XNx8NF/Uk8EdbbNBmuhR3l/jafD
	fhgF8xhqoqeSFyCncXy6BncPtZrvgwjm+cycfOfBbQd3wBgy7aDoGzP42Tmci5Z3yi7MWPs6KDr
	JaifdrGHU4dwZCuDTruFcww86H/oFAmtsKCibm97KlJ6HEv5myqjkWJLllJ1Oqhash7ewAa95Rg
	vSECJEJj7eY8sabaPqdUC7/63xboKzya4mfJeq10ZWSY4DziEhCHOfyC1NxBlOpd6Ca+h+32MiI
	xDhL7UAUXEKZgLfliyIs+LjkFheU6CPXt4GBVqc+mEBTFqfZ3hiqQBFtw9E2XCbGVVKpBfMhm+L
	dj5Tdli6oPNOeRMPZsgAjkLJJrxEtG/vXC6GFQUfPsrbdodbyygqs+7OXuOSjXe5B5owS4Lzthm
	xaAaP/iVN4fVZayGft2qOdGlAaBf12nIUcgtNaW4GtNlugyQGu89oGQ0+3vaZ3KG28LPneQ5ibr
	Op0rZbqMcjSZdx/K6NAksKIydl3QXDD
X-Received: by 2002:a17:902:ebc8:b0:2df:8226:4930 with SMTP id d9443c01a7336-2df82264b0emr3767795ad.37.1790221699268;
        Wed, 23 Sep 2026 20:48:19 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5dbc0fsm19242845ad.57.2026.09.23.20.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 20:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 03:48:17 +0000
Message-Id: <DLN8MMAY53A6.31EWYOHJ1YWLV@etsalapatis.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 6/8] bpf: mptcp: Don't support
 BPF_SOCK_OPS_RCVQ_CB_FLAG.
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-7-kuniyu@google.com>
In-Reply-To: <20260923213719.224838-7-kuniyu@google.com>

On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
> to bpf_tcp_ops.
>
> MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
> so we should not allow calling __tcp_set_rcvlowat() on MPTCP
> subflows.
>
> Let's disable BPF_SOCK_OPS_RCVQ_CB_FLAG for MPTCP for now.
>
> If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
> extended to properly support MPTCP.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/tcp.h      | 15 +++++++++++++++
>  net/core/filter.c      | 10 ++++++----
>  net/ipv4/bpf_tcp_ops.c |  5 ++++-
>  3 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 07426e8641b7..d3cf655da9ec 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2932,6 +2932,16 @@ static inline int tcp_call_bpf_3arg(struct sock *s=
k, int op, u32 arg1, u32 arg2,
>  	return tcp_call_bpf(sk, op, 3, args);
>  }
> =20
> +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> +{
> +	if (sk_is_mptcp(sk) &&
> +	    (val & BPF_SOCK_OPS_RCVQ_CB_FLAG))
> +		return -EOPNOTSUPP;
> +
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	return 0;
> +}
> +
>  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>  {
>  	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> @@ -2954,6 +2964,11 @@ static inline int tcp_call_bpf_3arg(struct sock *s=
k, int op, u32 arg1, u32 arg2,
>  	return -EPERM;
>  }
> =20
> +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>  {
>  }
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5feb99884682..f29c061bb066 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5588,8 +5588,7 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, =
int optname,
>  	case TCP_BPF_SOCK_OPS_CB_FLAGS:
>  		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
>  			return -EINVAL;
> -		tp->bpf_sock_ops_cb_flags =3D val;
> -		break;
> +		return tcp_set_sock_ops_cb_flags(sk, val);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -6178,8 +6177,9 @@ static const struct bpf_func_proto bpf_sock_ops_get=
sockopt_proto =3D {
>  BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_so=
ck,
>  	   int, argval)
>  {
> -	struct sock *sk =3D bpf_sock->sk;
>  	int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +	struct sock *sk =3D bpf_sock->sk;
> +	int err;
> =20
>  	if (!is_locked_tcp_sock_ops(bpf_sock))
>  		return -EOPNOTSUPP;
> @@ -6187,7 +6187,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_so=
ck_ops_kern *, bpf_sock,
>  	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
>  		return -EINVAL;
> =20
> -	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	err =3D tcp_set_sock_ops_cb_flags(sk, val);
> +	if (err)
> +		return err;

Afaict the tcp_set_sock_ops_cb_flags is inconsistent with the previous retu=
rn values,
in that it returns an errno instead of the flags it couldn't set (it also d=
oesn't
set the flags that we can set for MPTCP when BPF_SOCK_OPS_RCVQ_CB_FLAG is s=
et, which
is the convention of its callers). Would changing the error path to

	tp->bpf_sock_ops_cb_flags =3D val & BPF_SOCK_OPS_RCVQ_CB_FLAG;
	return (val & (~(BPF_SOCK_OPS_ALL_CB_FLAGS ^ BPF_SOCK_OPS_RCVQ_CB_FLAG);

work?


> =20
>  	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
>  }
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 4b48711d92a2..b0cade34cce6 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -223,8 +223,11 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_p=
roto =3D {
>  BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
>  {
>  	int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +	int err;
> =20
> -	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	err =3D tcp_set_sock_ops_cb_flags(sk, val);
> +	if (err)
> +		return err;
> =20
>  	return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
>  }

