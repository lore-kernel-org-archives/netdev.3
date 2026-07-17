Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A45377A9D
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295102; cv=pass; b=QYotOEjuTPKcP1X0WRmKu5FqTRTiqVuH6T8sXdG3QCBiPHjHKVIp4IFKpS1QpLddps8yQNuY5vLKOCrL0N4YV/URwi5p0cyPh4KSPEpF/qdlC5V+sxZ73I9syUux6ZMUaHj1LTu/Wm2xiTTajupj2qr3ikQG89Qo1GzndMXngiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295102; c=relaxed/simple;
	bh=w+dBJoXuJR+/v6n/aS8nD5sx9qZhJzcgLbU8KMn+Df8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akTjzblLlVJHECz4S1SO1gsC+qopnrD6kmPFIoQZUJCrZHbwyrZXcvrJU8m5rEXMQJNLA2PUB0WAEE/YHVQuVXLhVpVw+1AVScDa0VOPpmeKhDdSWHxK6z3zf0pSwcNHTVnM/zCfZFQ9vW/0ZEI7M1mu+B0gqtf0VhnisqDjtZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSdz+VjU; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSdz+VjU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeba09900bso3430666e87.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295099; cv=none;
        d=google.com; s=arc-20260327;
        b=fx71KY8AtpxcqAPtdX7cXMvTcF6l0wDpap8kbWesJu0aY10nkY7amywVDYVdX9Owhq
         cQFXKKOBf54JWMPj4f2LAjWZykBMhNLxqeuMKixe1KLiqgIOKlpPRAw9L1oDqd/iO7bd
         wyU4lzOzgeemTYKO4GKEoqAWJ9TnyKLUHlDNs0+wajcQOAbYzkGFbffBbm68Ig9C9xTx
         OmV5gSBqegP2JYI18aB1FZMOoiNx8Nhz0OLU37xBgehulynEEhRNgg1H7N9ve7KYAOmh
         HFrS/TUcQThb/RPH3dt6XLTJ+1k4PfBh17CRwjgWqFlZFME32LN9sxhE4Nc7Fa54fbjb
         z8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u39MMAPRg+9PZ9dmmKPFxaac8+2GTA2VmCK0dYzDWB0=;
        fh=zCXwXcitMxsu37PtRfQp3VckrZIA9qmsT4dVGmnez6Q=;
        b=ZaxJJyP2OMeU9u3Ov+WhHb736uP56tKq1irO4uq16Mbf8yOdYrFFJv1gupT9YjrjCx
         KJQuVWiyrmaPtp6WMXQDe73YUN8aXSHiXz775DtpPBEICtnfQ8PzT3OIzRA5MHzbnC7t
         /4PUhBlskjSwzYI8PaDgFchAyvhqzEIv92AL6/ygK0/7FU47bHSBqE7EXDVQLSz0yhKT
         mp5biN3PE3fNjZ0LuWy4APcMMGw3uI+rdShhFKZ9CGTS7EKqNSRsLnpoxuuYmLq2x2eg
         XzmdwOhyWByZXbB7KeWCRMeR8lIuxzD2Mtnjv6QV3g3PxVD79nO9N//N/uHPq31Kh/G2
         3IyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295099; x=1784899899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u39MMAPRg+9PZ9dmmKPFxaac8+2GTA2VmCK0dYzDWB0=;
        b=MSdz+VjUrvSE+bJo9lcspeh5m/9cwm4p9uOUVKjqeiGQziga2y6KfNzPXNts/x/pAN
         aQLPGM0fJlzDVfQbvJgas7r/IFsvFuFb24MaZ6tSv5fo4ctrGPSxE2Dw7+xZDwLYRntc
         Gf2cBEaa9Vszi7us4i44NoroO9Y19vdtzzuhSVf0tilWKQ6gmMZ5HSLJP9BmWapHgLYX
         fuqwtnKTS3iOV0Bv8/Eo6VuNOjDxV3T5V3MXSIGGdUHAjQFE+P/Iwx3d9yfD90NZQtGn
         B211b6oh1Ur9K2XgdNlU8SRpzmuhM2zE0fNVGxXy1RvDRcLtCo7gb9mJDi8oWW6NVbjj
         GRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295099; x=1784899899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u39MMAPRg+9PZ9dmmKPFxaac8+2GTA2VmCK0dYzDWB0=;
        b=lQ0v+LOXpARLPUOSJeSekLrrMKT2YIUfeXeFej99tEf+XkQW5ylqeqa/HxTHvS6OV0
         B3+Vz0sBW++tEwA53u+PBLasm20ERWS4CQ6++x+BjVjZ83DYMqfOOHw4Z78FgZw5SQlY
         NVODay6JUS8Q4uTh263UcCBwsEnuuUBdPp7VvkulEPMdO0nRNLz6BgXV3y7HAF2h+ZeD
         F9AbKk2Ws15jyGaeGaKgDJM4sPfhr4m+7uR8eY/BYdMei2f6ari0Rsen9QJyTP8Qc67z
         jOolh3xvo/Bj3Isn7EYhnQhHOltp7Oi1riIjEncd4wD06beBV/8ozLH0j7Bo+pz1h/Ga
         D6Ww==
X-Forwarded-Encrypted: i=1; AHgh+Roub/4LVvcP/iYhe6ngf5mJLs/I4s/L4rzwHGFuzLJvTiWwnLvoqZIdvgobUY4w4V0jIy8BE44=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMpiUUB/o0Yy20DgGm/ENEAU6hFalJDiv/c8edxETa4hacGhj
	l0hOsCsmeDTzN/VAxA2CXhKbXzzef1YftYI0akOABxDlh5zI9CLdGydvr9iEkNcGw3v+4RCMiBj
	3w+B8bP+CpMxRZjI2oALFtpjlpUub90U=
X-Gm-Gg: AfdE7cl5olZAPVhTRVE7xF8zRGkA8vIKdryoXVwCV7ATE/g0idYbxwCjKqPedbF8+mD
	+oZi2+odIWgTeQbV2eM2ak+kNQ8ZmxdPXQjlmT4vrvS4j26ULoVBGKhSXA0skzANHVqGfEs9YWi
	db+WyHzIjTgcnmIjb1Bkp9/ALk+imtigo1Q3tvomZ+AkNxWWBDALydLnvH7Nk1j4Qy58pO4IRN+
	3zVnEgzsu40nzah48U7v8h4UcvYpwELaXHnBXGs5UbK/0DwvrKCa/zG88KBV16eslAorMmgkLWR
	8ni4m6iaVjeDhYT9MNX4fUUAFzULAPw4dG3S6kTCuvVUo80Q6XQfPY9EtWGtv8QPvW/Y0vtciK9
	b
X-Received: by 2002:a05:6512:2390:b0:5ae:ba93:9116 with SMTP id
 2adb3069b0e04-5b28f855105mr759222e87.2.1784295098503; Fri, 17 Jul 2026
 06:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709183315.965751-1-kuniyu@google.com> <20260709183315.965751-3-kuniyu@google.com>
In-Reply-To: <20260709183315.965751-3-kuniyu@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 15:30:59 +0200
X-Gm-Features: AUfX_mwQF2RdA26uo8EenLMqIB0oLsHOjIRSBxOf4gs9O0vtCbtXWPpeY6a0Y8I
Message-ID: <CAL+tcoCqxPo-pAF7ouFAsb-jTeNwGy4kowhwL3NJGvZhGCQ0Eg@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] net: Call net_enable_timestamp() before
 failure in sk_clone().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Octavian Purdila <tavip@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 8:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> When sk_clone() fails, sk_destruct() is called for the new socket.
>
> If the parent socket has SK_FLAGS_TIMESTAMP in sk->sk_flags,
> net_disable_timestamp() is called for the child socket even though
> net_enable_timestamp() is not called for it.
>
> Let's call net_enable_timestamp() before any failure path in
> sk_clone().
>
> Fixes: 704da560c0a0 ("tcp: update the netstamp_needed counter when clonin=
g sockets")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260709032007.9E4D61F000E9@smtp.kern=
el.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/core/sock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fc3ff0552d68..504d82a3aacd 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2546,6 +2546,9 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
>
>         RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
>
> +       if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTA=
MP)
> +               net_enable_timestamp();
> +
>         rcu_read_lock();
>         filter =3D rcu_dereference(sk->sk_filter);
>         if (filter !=3D NULL)
> @@ -2595,9 +2598,6 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
>
>         if (newsk->sk_prot->sockets_allocated)
>                 sk_sockets_allocated_inc(newsk);
> -
> -       if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTA=
MP)
> -               net_enable_timestamp();
>  out:
>         return newsk;
>  free:
> --
> 2.55.0.795.g602f6c329a-goog
>
>
