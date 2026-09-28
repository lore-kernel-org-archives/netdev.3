Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01C4F96C6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616234; cv=pass; b=Lqeccojx6VcvzDAWASotgqR5QsY6jDMgdXw/52A1T/RcUEEuuPgu6dE1HOc9gXRqWqhN9PnuCq0xV2EUpdf6LIs+RTNaebhFvyPNupeIX7HCmUNLS55I6MlVQ+nv5uCyPRtnzV4pUjU2RTeoIM+4WlAPG4HSsXFNKoIZdAvAMAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616234; c=relaxed/simple;
	bh=baEoNBgFzbqfywMSHz3HNl9nOlCtROqCrEUy4ioworM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw11OGS/IoMQOXapYi7fOqXj1mriHiUsombNaW2QNoJd6wSOQga4SG0oLO+augc9AFRiUrp6aTiEDuxUO5sdPxjvQ3tVslJrB6WGKGSMMGmXnDImpJ0XZhGUf91vMUg3aZ5c/tyA6bmiqXUZxEM4Bd3uLMDO1nPKfduWxaRIYP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzNfnmkk; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzNfnmkk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53328262efbso21681cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790616210; cv=none;
        d=google.com; s=arc-20260327;
        b=G1YGFvf+50ODMqN7aZrRi4wcetP9jLB58G/Kg0z+oEI7riB4EUusbExwSH6pWjIoe5
         +wat8c7+RbeqkBF66mTX2HojFRTitRfWchQzptwdL0wHtutKCf5/IQ477NC23UJ0gYFz
         fhBwiwJKbRiiKlF4KXKePSn9bVKlHOH/ELHqjsd4wskQuzDdnWs+rQf9QsI4FuW5HftX
         FXnnjdeqyYTLNOG45n8C6rWM/EbxPGJg83UKxJoDZgP1coobCI6KW4f+6niGPdLY+AZc
         dgfNyBKNDKm0uJItqxvA3koFKgsNooW7afFEr7BaiUSMqmbfAWEjdNHTMbXIPZ/KiHHr
         YeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cPo0YF7Va7CVijoS/jlD9MAoYPwOXID7b/jnLGim+H8=;
        fh=+SawGVyjt2lqwdVXG+a9XyN9xhaDsoeaAsTti7yCLVE=;
        b=CHwPF9B4/tA3Dga97ihC87UmkK9dLyXYEk7qLG1gH02nlGCzSz0uLpzn9a9oEIwq8B
         ngFihuNaNiDDW8bypavth2akINbZMH+5mDjdD/AU1CvX1lmGryF4SVchWRF7sUPoz2rQ
         PDJwjX8RwKu5lxZTthhev804ZpuYaggpN6juR1tWOZfCTQ6LtnkN2J5h5RVkSS88fqZ9
         q4Ct+iFugpWwm/vojZx2eqGKfMsKUQFoHvSWbQSb6IBVnXyQOazAow2ZmPoM6BlNqF8r
         UpVqSorytwRTFZO1oQ4lZWEKNeVInSQAVFVsoHrb/I5cT6+91oGOmmuZWDsOtp366g+y
         zN2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790616210; x=1791221010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPo0YF7Va7CVijoS/jlD9MAoYPwOXID7b/jnLGim+H8=;
        b=HzNfnmkkGqteRIKVnsKufpaXJHegJt9d4e1VJZiWYuVMx43Xs2uRZDsqGRzIzaI2Oh
         I+ZucgOPR9pKWMMCX3ZExxoPLz7vRsMlIjY0nnYG9O4ijk/hCglcvKPGoBzhiU1FRWf7
         STIg7SOyCYnAKG8zvEYXTnAsBsViHFvmCuzp3mcWo37VIedN3AFHrco9AV+uHO0aglco
         PRyX+zmjCTqHHXCLeLzzZZaY9YymOOIGXjvDN3tNvUeYbF2Y4D6yhGEwZjgnAYSN1who
         PC1IrzQmnOwctWQ17yRg7vGm4unNiISgmiB7llqheE8vVA9nCCemqpTPX2EBGzp6A4A7
         FM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616210; x=1791221010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPo0YF7Va7CVijoS/jlD9MAoYPwOXID7b/jnLGim+H8=;
        b=cjkXi9Lo0idDf4iNmJmzXObhpQ0lqpY3xoAgltOQXGptFJwCOb3cuNrtf0PeXQxwSp
         vxFyPXVQ8JMFXfRJmXNFRuK8dizofS5juWUJ1uU8rH2x6J/Ghf/UeQujh50xwuI90ZXR
         xsspOqpaVFg2ZxzlExKFr3YLKlbAbPZYwxPFbmmzW4l9uyyZ5JIpJ+oNp3YvvNWfqzJy
         Ugsylj9hm8wbhhG8SBbhzk4GEG11W/aZ11s8KaNypYpduBq+AQ7Ox3w+7uh2MaghcM5U
         GIgyc4yEkqzCHmWuVHfiXVposGJAsGTi+/c3ZoAVFxcB7aTTxCnAivvjCBNBeMw9FZV5
         Pwzw==
X-Forwarded-Encrypted: i=1; AKwUvBwNe1dbu2cZ935uZDI9ndkv6YxB7EZueNqdYK+CCqb1yUxMwlS6h3XH1UZktPf1NkQKLSGSaWk=@vger.kernel.org
X-Gm-Message-State: AFuF++lr8qycbg6DGlY9bQNeUYzNExQFHT1nZtmUaCbgoIKWmg6ieI7I
	/KcFqEjIFpNFqj6dP7k9JwbVxioAjXH9lxpi0rReUUWAApxtyinbMCSHER33UuN64Sz723SWS7o
	LMI+UtCn1594+TT4CEW4NeLH/Ylj8W94VjQFJsf8Y
X-Gm-Gg: AYBFou2iXqE7Fvr8gswRMXEIOErcQrzfJwmn9wFxoUWCh8dkykYbxTXTAdOFo/u/mUr
	vRDuaiwfTPfC6lzJhU1fKvxYFonm1WTLrs1SSuXbik/n/au7FYHVZHWdGjAHmiuP5PXUQxrauS7
	8jBuKLNdundDcQGCmwnVxFlxEXj53hpy5HImjgyKkAWKtyCMdKPpBHS/9il3CL/LxrSXz8BK774
	JGBJOngrVXOhKTYz1qSu7x2wB8N+wWGKtfD2KPs/jTNU6KZVyOLgC89CkR6MqbIDMk7LX9oVvpt
	4gmWRb+by1dBfFsiHlPWk5aA3eh649AbVAOFrozWjdEQy5FaZ3W452nKQ3M5h5aamqZyNIDpZjm
	kDGYE8K5mZQ==
X-Received: by 2002:a05:622a:514d:b0:530:e335:4ef with SMTP id
 d75a77b69052e-53320076e0bmr27364431cf.2.1790616208912; Mon, 28 Sep 2026
 10:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925135244.3715196-1-edumazet@google.com> <20260925135244.3715196-2-edumazet@google.com>
In-Reply-To: <20260925135244.3715196-2-edumazet@google.com>
From: Wei Wang <weiwan@google.com>
Date: Mon, 28 Sep 2026 10:23:18 -0700
X-Gm-Features: AclHuK8xdsShSv3HRtdVr2Wm5x0BkXsFf5tWJ7cAhQHORhL5JRwHrn_nawAgudU
Message-ID: <CAEA6p_BZrnrrQqMmh+fsxG=wd1V_yKqgYGCsJnjs_yG9mezEwg@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] net: restrict SO_RESERVE_MEM to TCP sockets
 and cap max value
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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
> In addition, reject val > SZ_1G with -EINVAL in
> sk_setsockopt(SO_RESERVE_MEM). Without an upper bound, values near
> INT_MAX cause sk_mem_pages(delta) and (pages << PAGE_SHIFT) to overflow
> 32-bit signed int, corrupting sk->sk_forward_alloc and
> sk->sk_reserved_mem. Using a page-aligned cap (SZ_1G) ensures that the
> page-rounded sk->sk_reserved_mem reported by getsockopt(SO_RESERVE_MEM)
> can always be passed back to setsockopt(SO_RESERVE_MEM).
>
> Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
> Reported-by: Cai Xinchen <caixinchen1@huawei.com>
> Closes: https://lore.kernel.org/netdev/5a88421d-10ef-4fca-9acb-85a27a3c11=
73@huawei.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> ---

Reviewed-by: Wei Wang <weiwan@google.com> for v2. :)

>  net/core/sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index d23333bb4f3fafa19f58095522ef10d918d92496..e8551df8330ff4b1d662b0d01=
33e20d1f74eb728 100644
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
> +               if (val < 0 || val > SZ_1G) {
>                         ret =3D -EINVAL;
>                         break;
>                 }
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
