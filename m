Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC31EF39E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928646; cv=pass; b=GDuUKbhfBeC4A8wJNrUZ0uiabjo7a6E3gCUkIseRqk6HEhV0E2h1kQ5rGSMLG6lkZU7LuoyxA1m7aZqlu+R4ofUurLDTKoviSBWe/6ajzzaxkBXjDXPizsf2AubgWDy//V9vfprRZ5YeQg5vhokmOt24xLoS7jPb3sdM6AQ7yik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928646; c=relaxed/simple;
	bh=pMLKLK3nq39gFcvHpxAl4HnbkxQ+9IlyYFibJ0T4x1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1wLzxJqmyjTVSwuoSr6ez8vU9uVfKWmBsjtGoJIO+2JiOjC/WGUE1QoC+5dRPXhw+LWAgsRe2s4x1FXc7Gb2qXhU14bhU1zKfGh6CRem+vaKGkN160U3m2iM2c8IVoMb1GBNg2GPZ/+5TZUHd6A3NklcRKIlmGCV0veg8XoY20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=f2YRI39k; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="f2YRI39k"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ecf499af9so73546107b3.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788928642; cv=none;
        d=google.com; s=arc-20260327;
        b=mURItU5XkInPrRt8tAhUTJ+NyhZd102efHudRVmsnAt6AM3YOPIVP5+tyHg9TTSZ2I
         OfuE6fYboOcHLhgx9wkl1LbDYQW/vBeiGf4//anrbBKuiprh+VhqEYPreek5EhbVxSht
         LKq0KkA5RswDezjIZy2PUVLuRQNYgbOPK3qD/zIUA63fcI1D/xQr1y6B9UHdw2V0Ta8c
         3yzzsdZeM8WYrh4nZ+LmChUf4dcU08CIxJeRooi1BMp1b9ricNDKsmOJupTeZSlZt2u7
         S+y2GgRn1EzvgrbrCbzaIUoMfxNKDuWBuKkWq16OxwTrJ2zDClxkK/kfee6FNZ7Rbg9X
         XS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K43nwTCuKB5R85lEVjD8dKcWwH128UtGJ64tWvb5aWU=;
        fh=gwtZ3ClLZ3IqJlJSJbHFY/IlzUdCn6POqo9SDLMZpBk=;
        b=TkpFamo278eJv79odKwDTWbbwXP6K+INrl+LZ1fiYRUTmcYuyxW8NbWKeFw49l5gIk
         gpm9xe/4Ewq+OjQYTOfoKVGDYQssArUbN2qk4ibGsSj//Z4jjblVC3rAAn5O8qSDpt0m
         9iqBq6xe2IePPlpB00vxIhGLtba0x0aLOYjr5T13m/3IkWoYtLbdJua7fCuqaPrI+CyE
         +3hH7Vt88cR4Vb5Vj6rKLD0zadWKGHQXWgVeFCWRKdNPdhwfKBRZnSJ6+gglgD9LhfD/
         LnEVM7YCmtju+TgJIo/LPJS5peGIFJQzDb/3CHJ1U4T9Fbt1dfWJw+rjw2IrvUhM/55W
         8DDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788928642; x=1789533442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K43nwTCuKB5R85lEVjD8dKcWwH128UtGJ64tWvb5aWU=;
        b=f2YRI39kffUJJeYkrAvr9ZNSn0YukvWryECgSyxlAbd1XfGCtqk0buz3YwNez+KgDl
         tds3RYTlR+d0jWGE/TSeOKyJAjb/k0R4iluCDbVHNNSg4Wui7z6RVSSIvdJFIdw14OT4
         5wvgPvlsMX01f+0zQvuiujEk+32hZMji5E10dKl3upzHW4sPKPxwdgG1ZaG7TJVmSJ4R
         zGB/Tlt3yLf2j+WLs0oe4jHi/4RHWEAvHvfoe0Jmhc2ToGt+F9z5FR4qnjsinK42px84
         Lw/OQcstN6E8BWzgO1riEtBz1hM++yEKn+b+mWfMF6GhMSWi+5VdkK4VtgahvL651rWC
         +oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788928642; x=1789533442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K43nwTCuKB5R85lEVjD8dKcWwH128UtGJ64tWvb5aWU=;
        b=Kxf8C/cgD/GlWe8e5at1fihhClnen3AC0i0FsbXMnsfzlXV9m/0hMAy6DXTbbCaO7v
         hTT/F1NL1IvVGrKEX13qykwKyv4xqw7VUosAkpHhLWdgllwxnlaabSGWKZq44U1SY55o
         jWkr1vg9gpKoBjRuZB+hCqM2HdnBiBqKLWlHKMohrI4oEjKrDsVMgeIWATrKUYNcYyeQ
         ka0KB7eEenjeydfgkxPh6MsiBCGs4litPx6EeTTwlxsm5Gxw4FwtHjDS/dCziFX4FYE/
         9o/g6cmqIXG63M9D1KZ9dR928Z0st5JYG4R1PiJM9A5KyJVOgilFtncLuwVCTOkvdsZL
         0qQg==
X-Forwarded-Encrypted: i=1; AKwUvBxhmXz7s+tIqYKsH34qecADwhGvWI5i+pK9uYC4jD1G6K66BDyzeu5YRCYDkVLXWjUOwG9JOuk=@vger.kernel.org
X-Gm-Message-State: AFuF++nlVxyYe1yWzMEEQL5xtWgN8FiE/BL+BGGzuse4hAhU4sfhAxi3
	q9SFFLDkbS6Uyo/ELUHkdCTBCIMksswXghmg/QBGlRsbkfRY1RpuXtvtxl5K2kkN3NXjY/gkxtP
	PfC4SOBpzTnB8o0LE5XrqRTkNEK/wGaYk6iskshYhdw==
X-Gm-Gg: AYBFou2+sW4yXkVlGjCJPiRaVbTMc1qOyyz5Exqv/nC4ofNzrlFzOxVaeQndrvSROCP
	rJjqX4j9IjJt7pUxuAeOPrEvumh9atb2iRFygOxyC26eQrlt92P6ChYwDfdxVxHjD36QN8KL7SD
	0bnnBgbUUif7HrRQlFjEGnZCaSjA1vHHN/TeTUeSm4cGkuZ4jl6jQINwA9WLMKXXQdz6jQyIiUh
	lklEVkve6zP+7SmC0MJH7tjPvIipmkBo7kdSKAG26PIT9hfAK0Wl8QBasKlZdXQnVxFqtbVY7rh
	cItLc+WfPhiFIey0fFIQ6WB9fe5O4tNbMiXaDhhMNP/lSIskyCuBS1U=
X-Received: by 2002:a05:690c:4b04:b0:873:5c7b:c0fe with SMTP id
 00721157ae682-8735c7bc5bemr95111457b3.54.1788928642020; Tue, 08 Sep 2026
 21:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
In-Reply-To: <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Wed, 9 Sep 2026 00:37:10 -0400
X-Gm-Features: AcwNN1WgdNZqq0OGcQo1SC2KhlxqeXSqZYjx_8cGpWBBKPeJQarIS9HxT_HCEUM
Message-ID: <CABFh=a7TJzKd2bU3L0FtSh0gQjqTCCrd57W-bDs+ZFCJZ96vdA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf, sockmap: Fix self-redirect copied_seq double-counting
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:20=E2=80=AFAM Geliang Tang <geliang@kernel.org> wr=
ote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> When a BPF stream_verdict program redirects an skb back to the same
> socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
> calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
> skb is then delivered to the socket's psock ingress queue and later
> read by tcp_bpf_recvmsg_parser(), which also advances copied_seq via
> the copied_from_self accounting path. This double-counting causes
> copied_seq to advance by 2x the actual data length, triggering:
>
>   TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
>                            rcvnxt BF2E806, fl 0
>   WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x72b/0x2640
>   Call Trace:
>    tcp_recvmsg+0x10a/0x500
>    sock_recvmsg+0x168/0x1d0
>    __sys_recvfrom+0x19a/0x2a0
>    __x64_sys_recvfrom+0xe4/0x1f0
>    do_syscall_64+0xf7/0x530
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
>   WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
>   Call Trace:
>    tcp_recvmsg_locked+0x8d1/0x2640
>    tcp_recvmsg+0x10a/0x500
>    sock_recvmsg+0x168/0x1d0
>    __sys_recvfrom+0x19a/0x2a0
>    __x64_sys_recvfrom+0xe4/0x1f0
>    do_syscall_64+0xf7/0x530
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fix this by converting self-redirect verdict to __SK_PASS at the
> beginning of sk_psock_verdict_apply(). This bypasses the
> __SK_REDIRECT case entirely (which calls sk_psock_eat_skb), letting
> the __SK_PASS path queue the skb to the psock ingress queue. The
> data is then read via tcp_bpf_recvmsg_parser(), which advances
> copied_seq exactly once through copied_from_self. Cross-socket
> redirects continue through __SK_REDIRECT with sk_psock_eat_skb()
> unchanged.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Bot is wrong, in the sync path the whole ingress_bytes adjustment is so tha=
t
a later recvmsg will advance copied_seq by the amount of bytes we have in
psock after reading it. In the async path we just account for the data
immediately
in copied_seq and do not try to delay the accounting.

> ---
> v3:
> - add "bpf" prefix.
>
> v2:
>  - fixup the verdict as Jakub and Jiayuan suggested.
>  - https://patchwork.kernel.org/project/netdevbpf/patch/1d2370f4c81f10834=
b8dd77524924575c629a464.1788591198.git.tanggeliang@kylinos.cn/
>
> v1:
>  - https://patchwork.kernel.org/project/netdevbpf/patch/b840c35fdfdf36e9f=
ddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn/
> ---
>  net/core/skmsg.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05..df385a5a961e 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1000,6 +1000,10 @@ static int sk_psock_verdict_apply(struct sk_psock =
*psock, struct sk_buff *skb,
>         int err =3D 0;
>         u32 len, off;
>
> +       if (verdict =3D=3D __SK_REDIRECT && skb_bpf_ingress(skb) &&
> +           skb_bpf_redirect_fetch(skb) =3D=3D psock->sk)
> +               verdict =3D __SK_PASS;
> +
>         switch (verdict) {
>         case __SK_PASS:
>                 err =3D -EIO;
> --
> 2.53.0
>
>
