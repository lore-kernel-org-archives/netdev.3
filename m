Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3E470117
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271173; cv=pass; b=nsT8VZh79XjOVjtzt5my44s7Izw2MafqoyBehTvLYvi0GTf/S/ZHtIFfB78vMlGwyBua0CJD8QdYFX5adz49adsVmcZpHtIqhuCRysWNGsG8kiIjw/ZbTYkNupzNmdSyA/1tvvF7jPRBGgzpfugw+n7jz3VA3bqyeEDG4PGOgw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271173; c=relaxed/simple;
	bh=4vw8WUaNVrezkaun6gH0185QpgYoJRcAGCeoCt8zW/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0WalJTS/nXXXg1ARCuWN02dvv+MK6UVeF/f/tljQLQhVlE1fUlq2GPOjBAyyJdOrXJ6Ui4kEmZDeIviyfuCXJ0Jm6+xzML6OioXFhbhq6Zpq6bus5lN7gxVofs3OtgbDBN5aaqthx8AhuZEsK58pOvz5a+je+zKNaec1UbEQWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVUq3U8s; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVUq3U8s"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52faa58bff5so19941cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790271171; cv=none;
        d=google.com; s=arc-20260327;
        b=BXjbTrCiMgln+T3DOlM7YUb24liHJPD4G9UEdxL1LipHzaTT2veU6WLIO1THp8ca+w
         srM+fwwV2wZ6Tkv2ktyZPH2OM3cFLK/Nhllx4jYOWShqqze9Jfdthg9OrwCQM/3WQj5i
         QsW4ssfZ5vsWGsEyYWyszutA5fg3XDDGpUME6E//GWZVnq0b0NlIHXPwwreNgfcVqDR2
         SwM6CMKgtjTR8i9W5Sdt5O9SnDf+R3vKQ4I/Ja5VxzebdbUzOxPogrSs2YkPWqc7FByi
         2ymH8YqoYBMszDMHQAGk+DTU0lsJo/y9XS2r0fTbRm6AMsuuhoZwnRxLlXE3uqx/Kd3y
         7I2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ckcM5jvc9cvA1Hjl+szrR9oRmjzSCgbrjKexhm0fHvo=;
        fh=yxHySWG82C3RwO+Ub1MUEHa4rW+DHXEF+KbTxJnCLZc=;
        b=TohKXF5qZeN120x8TVee3HBkqzSzcMCd/hh8GuytEmGQ4YOZ1BG5tMRFQDJv6XrCpC
         rPY7AqEGZiDeTlcJj9HR+bjDzV2MmqxxseqsmmA+u87wutjwryyjaFuMFn4aYcTEW4v/
         vNNyevuIAc+/S2OjSdIKPlQiotciHkMLQsSDZNDt4NgggsXVG2qBb2aLwELt+7SJpu5+
         Gpy4xuGWPN0WyQwH5lnHbYOSOM32xzJ4UUnzPlZCoibFDYzlm69/6ENnA8DaftC6klVS
         xT91r9ZQpmNijunHDjCaM9qtR+7rBNK+tga+9/iQ26foCH0M4LyNV69NLFGW5FiQc2Kb
         F7Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271171; x=1790875971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckcM5jvc9cvA1Hjl+szrR9oRmjzSCgbrjKexhm0fHvo=;
        b=eVUq3U8s13Zgk86vRJ6LospBhkWklukGoQIXse4z74kPVAfscBh9+q6TsX5k2sew9z
         /lHBiKueo22wjRbytIpFfo9BfeLOHMK3zQt0124XzdmjnXh9nyK7Dvr4y4aqElW5eUSf
         6vK/p1k0cMYkjdHvX5vbopSiwsEZ/cEJLP1+nyuS5L/nd7Wpn8edjAESQcfKiBIRYdNo
         KJ1065xlp5cMGu5IIzPCPC0rVrKnmmIbi/cV2Rg2K62g7zKQkH9hqLg7cS92+kBu4Ikt
         h5JJvpGSqs8LrkpX43OLCWWANmINrXzEdBKQfDRsKhgPuDluOtpUtBCKIfMwYCJ1/U9D
         +GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271171; x=1790875971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckcM5jvc9cvA1Hjl+szrR9oRmjzSCgbrjKexhm0fHvo=;
        b=uRxyBEjr/LzgHGURXN3TvR+R0OkEPxp0wyBmqKkWzjm2B8PSt19tGYh9nmXyVOMhFF
         3E48/+I5MYOeihsjZzQ8kBalEM0QEyfoaa8vIF5sQoCVp9kKFtlWmES1m80huY/NTVRt
         4bwtSKhgDgFxNdrZ68rLhMr6kPJ695cIfHKLAcX14Lgb9JOf6I7Y+8qgSwuvjSiO9H4Z
         9fhx40P4O4pjl6cWD5VHJ69zg6XRTaei7YwxYmkiKuAMiHulAInsSLHc8O2Q1pTe9z+6
         9mF6G89lpYb+LMoaGRb358ZX9kC5WqD3kaV5q1aBUYlkm5SaBxYtu6tOjE+Q/exmqIP6
         dtdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmIBZM4QE99epTcv9AetB+vBVE0sIX5oWls4gY8oi7QWkDPSZXNlVP6oBySvbOo38xQgOolIU=@vger.kernel.org
X-Gm-Message-State: AFuF++kLVXaZoCPIigVSPN2jIgB6HhnhTNCe9LELUcGa7TRsIupyfCoZ
	hKuKsuGTSqNvSaPoTx7qZDinwag9NaXfcuHWLRwn9X3x+z8EV+pA51au0o0mg9sCHFaxBSFEN5s
	Q/GzGiL+yG0vdm93TVE5zPbpF2fYfpQJ1nHgY2TyA
X-Gm-Gg: AYBFou02No6pLT7EOSmYTZoVcA2T7bRFlP28+otlg5Oexy65KOIbJZjgtPXby8YOx9z
	XWwIPCYGQlmYtMLtYoE2kom7yHrJWBBRwXliZbsnlmdmx6XuMeJXK/Asam/EBnPbJCbBMFvrQyt
	ZXvbFK1hJv3gEaC0ZoUEkKaDaHgnv3OcnfNaQ57aZadMluC16vuIpFTbc1qJoK90N/CMnhc0O6k
	b90fS2t5ZP2B2LQM+7zrDpfL28fyfl/wGxXAxiJfXq9rHcmmRgK1GbSf4usMMaqz3L6WDV7ZPth
	CSgbvNnud/JgUYREfUdZULg0QtdGfP0HfxbpL+L+B/B0oiLI/6KRymfrl2+hpVdMf9LCFIwAvo8
	YXtjpD0LMFQ==
X-Received: by 2002:a05:622a:c7:b0:530:e335:4ef with SMTP id
 d75a77b69052e-5330ab0ee62mr349581cf.2.1790271169483; Thu, 24 Sep 2026
 10:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924123602.1979090-1-edumazet@google.com> <20260924123602.1979090-2-edumazet@google.com>
In-Reply-To: <20260924123602.1979090-2-edumazet@google.com>
From: Wei Wang <weiwan@google.com>
Date: Thu, 24 Sep 2026 10:32:38 -0700
X-Gm-Features: AclHuK-wB4f7peiyjJ46Fhk2bFtuq-JlRxBzV46itJgC2VAG0Sj10V06TyAyWbc
Message-ID: <CAEA6p_DT-fZxWLjaejMMo-8zOnMeDiiApq4Q3x85zQVjY-1DOw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: restrict SO_RESERVE_MEM to TCP sockets and
 cap max value
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Commit 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM") and
> commit d00c8ee31729 ("net: fix possible NULL deref in sock_reserve_memory=
")
> only checked sk_has_account(sk), which is true for both TCP and UDP
> sockets.
>
> However, SO_RESERVE_MEM and sk_unused_reserved_mem() are currently only
> supported by TCP:
> - On UDP sockets, sk->sk_forward_alloc is protected by
>   sk->sk_receive_queue.lock, whereas sock_reserve_memory() and
>   sock_release_reserved_memory() only acquire lock_sock(sk). Concurrent
>   UDP packet reception/release and setsockopt(SO_RESERVE_MEM) corrupt
>   sk_forward_alloc and memcg accounting.
> - udp_rmem_release() reclaims excess sk_forward_alloc without
>   accounting for sk_unused_reserved_mem(sk).
>
> Restrict sock_reserve_memory() to TCP sockets (sk_is_tcp(sk)) for now.
> Supporting SO_RESERVE_MEM for UDP (acquiring sk_receive_queue.lock and
> honoring sk_unused_reserved_mem() in udp_rmem_release()) can be done in
> a future net-next series if needed.
>
> In addition, reject val > INT_MAX >> 1 with -EINVAL in
> sk_setsockopt(SO_RESERVE_MEM). Without an upper bound, values near
> INT_MAX cause sk_mem_pages(delta) and (pages << PAGE_SHIFT) to overflow
> 32-bit signed int, corrupting sk->sk_forward_alloc and
> sk->sk_reserved_mem.
>
> Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
> Reported-by: Cai Xinchen <caixinchen1@huawei.com>
> Closes: https://lore.kernel.org/netdev/5a88421d-10ef-4fca-9acb-85a27a3c11=
73@huawei.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Wei Wang <weiwan@google.com>

> diff --git a/net/core/sock.c b/net/core/sock.c
> index d23333bb4f3fafa19f58095522ef10d918d92496..cfc6700a62e6fb904f4c83205=
09d7360c6223b1f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1034,7 +1034,7 @@ static int sock_reserve_memory(struct sock *sk, int=
 bytes)
>         bool charged;
>         int pages;
>
> -       if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
> +       if (!mem_cgroup_sk_enabled(sk) || !sk_is_tcp(sk))
>                 return -EOPNOTSUPP;
>
>         if (!bytes)
> @@ -1661,7 +1661,7 @@ int sk_setsockopt(struct sock *sk, int level, int o=
ptname,
>         {
>                 int delta;
>
> -               if (val < 0) {
> +               if (val < 0 || val > INT_MAX >> 1) {
>                         ret =3D -EINVAL;
>                         break;
>                 }
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
