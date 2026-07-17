Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D02C11E6
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295063; cv=pass; b=CIBOrzqoQ5Gc4lRUhR1KajJt+22BGdwxDRcrf3NyIA4La0JqngKMk9B+NzrqSDgl3uIqF2U9sv9JFLfZoBmIie4YLaLpm4fWesGsbXlDE1NpDG93EYgzEHNqkG3emWNeuIKAYu29CEzFr3uRYDp4teiLch1vikaITGHTtTH507g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295063; c=relaxed/simple;
	bh=RRLI7KlRvPX3yfldOobrjtb0p/DKENKEE5YH/HQoL1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGzOJpD0u3j1ZZvjC4K2zs3CoBMqtDx51IJe/s0zgIhJUy2vPwEFbEo1plTo1FOAChaSAlJIwx6F/NM+9yLLZQH5+PIDZxNRIF1hXKet40zs2KdoJU5Ydo9K/vqeyXKZBhD093ew0BKBU/P7QVMFdnDmckcYXgBkHMRaaWn5A2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiUGEuzI; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiUGEuzI"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39db07589caso36518891fa.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295060; cv=none;
        d=google.com; s=arc-20260327;
        b=Y8dCGzNkrKAW8lV7jPsmuLAEfDbbOOwcE52z+RstUx7t/m1gO6bfSN3B4vjtgaJcEP
         mYg30aXDUrYcUFz++mmmUoiE19xbMUGmGfLkvb4ScLbcR3V+g1ruk6QpKWR8FhqXYbeF
         Sg5hgyHrGzQTKzgBKqoKCxlTdtJZG9Zap+F/L9iEC/w7UJ0FBPQO7SxTR0FuvIGcHW73
         Ih76boRzTUQKPf8KiI6BVxFvQlh5OGSE4LYMYu+WvOuO3jiLpgUhcQA2YIry8K2Mq3rd
         TRNNSHt908iXJIs5UTBKEJASTV8cXq1/pi3qFlCrba6zpiZUEPftRYzsbXghG5z0qT/k
         e9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g7QwVfvFz/S45RPny+Pq/gNJUncM1gpAnDsplPMwBuc=;
        fh=JSSb6g9oAefabynFxWXvG+8U9PRl/aeQkXvdAjEcTaQ=;
        b=kVJAksYK6ajyZ3F6h2PcUIdxLL95VoQHtebLm/XXmj0cHyjI65n1TaKueBl7XP6B/Z
         CMAy8N7b4nDwOx6is55zy2U1IPWCxzUhLkeG49+JQwUKCS4C2v1jHpSHLHx0oDwIWADV
         61ZUNCyFj/iNLmKnMNj2CuvpQLZoDnOACGGk1QPaaQn4XbFh4a26mQK4guq5+bzqGRhs
         UgYYodHsIFzpcLQK64kyayyR+sZlJwrlxqGlzjmfkKd0IYBaQMLZD6Xi4U8lRzpgOpvS
         LNCX6YhtcrNpDIFrC83LCWk1ve+RBUGsEZgwJL0lvYmiJept9l05vBqPN60TacuQrDV1
         zQwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295060; x=1784899860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g7QwVfvFz/S45RPny+Pq/gNJUncM1gpAnDsplPMwBuc=;
        b=YiUGEuzIefIfqcCaZ94n/hvrUHZo2ZucMXTwC0uBjIBeV/dkx4ojCOwuyn6Vjkg3D8
         oWdnM5L9vklWPO+mD4+S4RppwzGtcYWpQfIgMjpR6q4S44ekqSGyuk/du34ldBveh2+9
         nhjJf5Yil89YmKcxWEE5SoVZdapaw7enIuQ9EhIzmKMQjatO/Xx+RRbvYCSzbS+8v8Kp
         zZuE69JLuEfG52bnbQL8qfMiIAUiAZ+alPqdApy1hQ0iBZNmfP8DzNqPkgJ3xOhKBuiK
         jWqfPn6uUqEtKi0WIul5JYon+2z2LAAZQ8aqtHT8LZBvkM74eEhwxbp6yku5IuHHdAre
         JvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295060; x=1784899860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7QwVfvFz/S45RPny+Pq/gNJUncM1gpAnDsplPMwBuc=;
        b=DM0e7hiieqg1gcfXPTMVX8UxIExdvgvgbn00Rlrozf+O+E+VcH6N8rRv6wGfWGGsSu
         qqGGYeWHe/5j7xme4MJV6qE7MEUdLF8AfihqrWSsiu2aqF110CShLBmvla/7LCT6OMFz
         XUleFLVCT8LMdvf5ZG+gYAKjMR6e+8l+BLN8Sd0mMt61KQ7xtEHddOA4BpxLRwhRCXVn
         G3WofzF0USwEbGVGeEPnOQRXRoN1cAcHXMObr1yJbUW/3OxlgZ/xaoxvjtsdJdImU0wg
         o2S1sosKVU0vIRRcncVr1/ZM9pOkbaqBj7sReu8Mr0847VxAZEvVhoUCBdhmwbhBYHqf
         /h7w==
X-Forwarded-Encrypted: i=1; AHgh+Rrn/iE7wblVo5WKCPCJvWsWuJLx2zbB0UM3MXXUkTixj5+Ls46rBvDrBFNij2kZ9ONiK14BZvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoULzir1TtFjeWHuyCLEB9KNhmnzQZcZaHfXNId3ouNiVKc8vc
	+dEikuUmkV6EfyN2WuhnbM6Vuic32O4Wsp9vhw2eHfONyOvEzpb6F5E/BB4HXIJ2y2OADG6vKha
	XHJFhnuHxWnBtXFG0DvGWkrZdFzmAwRA=
X-Gm-Gg: AfdE7clWoKTvxY9w4//zVlvRLmGVcLZiHTECwoJ+SdDLrqGhP7cpboxhwbzxvmrpK8A
	orqOMPUWfhii/ENSxkXb2mZeeEubbQG/cSBa0M1rX9lgDwi4cwyi0QRfd5XZl0bcUa0a6ZiScaE
	2p/3XiLRI/LIvC56YJ8XK3x755DlXKzvXOpNT/X+PLMBN32e7YGwGL4UMQ0FzS6XB9rwuOvAbd9
	EEOUAtemcgnYgD7YEw8AAMnHW70iQXX68KPfPOBIFlXzXPGZ/kEgqS9kJTz1N+Uh/YOh8lxAd8G
	VRHOVfcQOVhmyPhQFmaZOyoJtzCwh3bnWvXoHQEBjbQUtRV7SW4hOYg6HHzJMmp5jEsZiKPo1u4
	d
X-Received: by 2002:a2e:a888:0:b0:39a:e29b:9a26 with SMTP id
 38308e7fff4ca-39eb291fde0mr7275761fa.32.1784295059449; Fri, 17 Jul 2026
 06:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709183315.965751-1-kuniyu@google.com> <20260709183315.965751-2-kuniyu@google.com>
In-Reply-To: <20260709183315.965751-2-kuniyu@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 15:30:21 +0200
X-Gm-Features: AUfX_mwFOR-BiKYpI121eOqUXxvlIiJFKnTA7lwrL0cLhD8oJNKhQ-XIVy5c6fs
Message-ID: <CAL+tcoBSRoKFsv=R8=_9n_N+Csb0c93UUv_z0bkqXpNvhhof1Q@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] soreuseport: Clear sk_reuseport_cb before
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

On Thu, Jul 9, 2026 at 8:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> When sk_clone() fails, sk_destruct() is called for the new socket.
>
> If the parent socket has sk->sk_reuseport_cb, the child will call
> reuseport_detach_sock() for the reuseport group.
>
> Let's clear sk->sk_reuseport_cb before any failure path in sk_clone().
>
> Note that this was not a problem before the cited commit because
> reuseport_detach_sock() did nothing if the socket was not found in
> the reuseport array.
>
> Fixes: 5dc4c4b7d4e8 ("bpf: Introduce BPF_MAP_TYPE_REUSEPORT_SOCKARRAY")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260709032007.9E4D61F000E9@smtp.kern=
el.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/core/sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8a59bfaa8096..fc3ff0552d68 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2544,6 +2544,8 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
>
>         cgroup_sk_clone(&newsk->sk_cgrp_data);
>
> +       RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
> +
>         rcu_read_lock();
>         filter =3D rcu_dereference(sk->sk_filter);
>         if (filter !=3D NULL)
> @@ -2566,8 +2568,6 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
>                 goto free;
>         }
>
> -       RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
> -
>         if (bpf_sk_storage_clone(sk, newsk))
>                 goto free;
>
> --
> 2.55.0.795.g602f6c329a-goog
>
>
