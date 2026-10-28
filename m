Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204291;
	b=yD9e73iAyLUZbjFSVAug7cOg63fw1t68WRPAJJQMlWAwmdO9EPETMovj9q/YfvDHzxuy
	 2wV6WDISkwCdGfVZa7l236d8Nug1E9M6nYd3HxHUzhah8E26oOoSoAWPSApAk+9FYEiAP
	 e58pnLcib3n6eQDc/HLuM3EJ3OR+BG4ophDg+YZoAQyZz5uDhLQNwcjLNX2Ajue9U/Xtm
	 v/Kf2PRDqwDA+6d2OmXd+dSn82d7fhMqbytf1vxLbLiz9ysDPDptbv+S9l6JvutkL6JjP
	 Db7Vk+GIXg52gZnvhgoPuxQmVW7FkWxIpiVwnTe6wzxkUHfuu/y9SVrX/gjFK8G2kBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L5ogW7JhfAT5yK3R6hLg7JFkiEpuNvjKHA8xCwY8O74=;
	b=bH0kElaYk3i6PifMh7DQnCGsphpbrD7nD9Eh6+lNQIDPWa1+XZu94HuMhKOgYmklOD6g
	 A/tZDU19Ge6Hw8UcF5vpBHY8q0GsPfYgca7M7OXtJAuqSHXYDZfDbwu3xG+mqORnAK0YR
	 8u/LUMoTsuRH8pexYk8FphatWxByf4FetR6zYOmDVr42lLwRq3An83AxCiacFjYJm+obL
	 k2d9uGw1U2QPQOES1/cRZ/ih687jqrnLmuLgb7KM7OOYu5P8JUMQcY8o3ndO2j7erGzBJ
	 Ig9OwTs5KxG14cWWmSCx0YhYKZjEY6e9aY7G/0wRRM9CVjs5+BMpQPmTaDlhjhndgcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nhcyRhRU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD4606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1BD4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nhcyRhRU
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso16105a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793204289; cv=none;
        d=google.com; s=arc-20260327;
        b=PlBE99vu1zZhD8eO4A2FJXqU8Sxq4AoOlM+0S7ypO8VM4wAppHMwQ6zLkUsqkcD6q6
         1OoLynvPE+sorel7oc7VEvtRFbd0GVaYn9fTuLHX3UAsUVAvzlPd8FR/Mr4b/QrX0HHl
         kLuAa7lcEqZgW+FVCv6vhOyZbJnSeMFBjZycTqiwwsCVyEZTuV+UJ8QQQmYIm6Eh2swD
         fWd8zsfS78b4vNi4SHlu3ul869Y1DF5COX5A3Br3PVpt0/9+iI2uRQRh0RfO4B6fXa3y
         E9C7sLFU69pfEpnAdmuYmBWa7DU/0S12wsz3Kvv6H3htukdJp3nTY4A4GDSMYgIvUBgm
         /4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L5ogW7JhfAT5yK3R6hLg7JFkiEpuNvjKHA8xCwY8O74=;
        fh=HnRhjkazeMfsmfsA0i0VoS1OpoSxfKw1iDbv+cUFM8k=;
        b=hdVGh7Dq9Ee1Fah8h84f9RjTOLsutMZHWWrGJTvpQ1KMSX1cd9W6GX5lAanJzxnPAC
         tY7gHLzpomgMvrFkVK3Pg3DUJ9RTs3capuk5aqOBXPu7iWJGy/6bD66CU/v7RELSGSMo
         jII26GlFGg6Gifg9jxoPN1LfwEIKp2v4UfuimxaAZ73EzwmdE5P2MjRnOEa7Y5fM3Wmp
         Tr6j9qi6p7Ul88/0+UhoHu0fDlZcvvDARHZLTDKogZxwnr3NeihnzRxdWDMcmFJlgG4M
         najH9FC1XrdWFVXZ5K3cEXC2MnrRePOKM6aEoJW5jMwS3CqBsLqN74/MWAM7L6FoFN9s
         qqzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793204289; x=1793809089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L5ogW7JhfAT5yK3R6hLg7JFkiEpuNvjKHA8xCwY8O74=;
        b=nhcyRhRU/4RNzSMLzZT8e3LWTesK3fZyuVFJL1mpIE6Nw3t+DdqE3iRINLZRiiRe17
         2Y87u3lO3aIl39AqO+3cbBfoYWF7xbM1p/9jrzEk1iFcDqZSjzCh6v4BtWI+MQpjt8/n
         a9N2CnZOXZMDYD6cCzKQBiK1LbdmvghCVwzWoRzbQqCrVFDQU8njfQ5WSoSKKPDnlcH+
         pAnE7Nb8qgHILbh74wXmrh4vXUn+V97thRbE3NV4OIzAWlf/QxUpl8W2CuYKwlBvhcVQ
         5hjiEXtyz7U/vn+m24FpYbQVKesS+Holi3yILWVMKD4ia2PpNuHSgq03eFGpRgsR0hGb
         EhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204289; x=1793809089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5ogW7JhfAT5yK3R6hLg7JFkiEpuNvjKHA8xCwY8O74=;
        b=AR30PjfLPfg2PBoCQMKnXXrqto0GUz8vK8M3kL/4NxefgHZOo6WmShYznUUQYzW6Fp
         tre7dlz19CP79DZMWzBU/C+v/jWAm0uq3RMk9Pk8DITa1dcVKk3Lgozmn7xzdXuqeUqL
         bRu8VgwRm6lZ6w22BkB4Xia1zixFKXo9EBm2ZSkKP8yb6o7ta6I3pXwp49Q57vZjPnAG
         UBmA8FezISkWHubo1SV39H4H7wVvkVQ24G5Kq6ILROJMyzcfrRkanyNB+/aPrhG9Jy4m
         09EPYeIiTvqBiuUOa5Nhnf2a4786qsCDiHdmv9BEyaluH1mAv/hMBIDlWJ5w7+lePxgT
         mH1w==
X-Forwarded-Encrypted: i=1; AKwUvByhGSmnPg7S20xFe0bi607Bf9xHzoyiO/00uKPUlZ4IYVYSfCUN5u/Wxwq2l5Jl0Z498bT1xBM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVZUIiTSYueIxGJ45Spg2xzU0DVu8gPa4nVpWydYTfe0I5gLLR
	qm7uDpUMXWEmL5CoOrtsilkCdgmAx6/c+wA6rWaLxm7JBBqI31F3NKw58hx60eG9JqM9vEXi4bF
	JeVPynqqgkzvdkzQRC1Ho5mPkMAQAicNW2ONU0Xuj
X-Gm-Gg: AYBFou3EWNsgElAs/p988HgZsO26roWLrlihk+a0iPW3W8Lk9ADo4HcorsB2g5C+8Hi
	12uOdoPQMcMlmb1qlGytMC+gVcJ0FfORFwYD4XzS92G3v430cyrLmmw+VYPOvSMLENzAb1nRbNO
	abqmo5hwcmbE67OenLl38p33wUAzNnmJnwuxHa0tzxZgLVelg2xkWT12JHv6WGZBJlBSWyeBAml
	ng6KJLjPcdS/80BlQ/orb1y/vaTfCz6j0zS1JTAcOUGHn0lqm/gm/GdQz+IQbr5Y5emq4ZYRxIQ
	GlMLb7zKx/uuhyzFAT7jhtr2dpnz63CD5kH8HV9Q7r4AH9eUZH5vnKg9VCDcrPr/MWNzTzYrXGf
	uVRIZY5gWdwsOdgxOFwaWRGK4vqzLc1ili7nPQabTX8LolYZzjlm9Cj1TpHUrbtQIpmGtJaY=
X-Received: by 2002:aa7:d516:0:b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b49b872a5fmr89061a12.8.1793204288568; Wed, 28 Oct 2026
 09:18:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026032216.1145201-1-tavip@google.com> <20261026032216.1145201-2-tavip@google.com>
 <CAL4WiiqQ3cychvCccpNW+WOU2SYCfNt6L=wgPkNmfTLHLy605Q@mail.gmail.com>
 <auALgSUuoYmfKSz3@google.com> <CAL4Wiirpss0inrC7gKhsNfwUO-KGZ-nnF5h7N8jXS9qziiSW4A@mail.gmail.com>
In-Reply-To: <CAL4Wiirpss0inrC7gKhsNfwUO-KGZ-nnF5h7N8jXS9qziiSW4A@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Wed, 28 Oct 2026 09:17:55 -0700
X-Gm-Features: AclHuK8w5lO8If8x36ZOhT6j7gK1cagODxrbPfh_JsvNFfuijHGsG2Hl4-fDuR4
Message-ID: <CAGWr4cSmbe7nuobWAZ9A2yV3BT0OT3CKhaBS5o++b+10srvjHA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] tcp: clamp return value of tcp_wmem_schedule()
 to non-negative
To: Eric Dumazet <edumazet@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 8:20=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mar. 27 oct. 2026 =C3=A0 03:28, Kuniyuki Iwashima <kuniyu@google.com> =
a =C3=A9crit :
> >
> > On Mon, 26 Oct 2026 13:06:56 +0100, Eric Dumazet wrote:
> > > Le lun. 26 oct. 2026 =C3=A0 04:22, Octavian Purdila <tavip@google.com=
> a =C3=A9crit :
> > > >
> > > > When sk_wmem_schedule(sk, copy) fails under TCP memory pressure and
> > > > sk->sk_wmem_queued already reaches or exceeds sysctl_tcp_wmem[0],
> > > > tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc).
> > > >
> > > > However, sk->sk_forward_alloc is a signed int that can transiently
> > > > become negative when tcp_collapse() re-packs partially read or high
> > > > payload-to-truesize SKBs in the receive queue and charges newly
> > > > allocated SKBs via sk_mem_charge() before freeing the original SKB.
> > > >
> > > > If tcp_wmem_schedule() returns a negative value, tcp_sendmsg_locked=
()
> > > > passes that negative copy length to skb_copy_to_page_nocache() ->
> > > > copy_from_iter_full() -> check_copy_size(), where it is converted t=
o an
> > > > unsigned size_t > INT_MAX, triggering a WARN_ON_ONCE(bytes > INT_MA=
X)
> > > > in production and returning -EFAULT instead of waiting for memory o=
r
> > > > returning -EAGAIN:
> > > >
> > > >   WARNING: CPU: 1 PID: 939331 at include/linux/thread_info.h:249 tc=
p_sendmsg+0x10c1/0x1530
> > > >   Call Trace:
> > > >    <TASK>
> > > >    __sys_sendmsg+0x292/0x490
> > > >    do_syscall_64+0x88/0x340
> > > >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >
> > > > Clamp the return value of tcp_wmem_schedule() to [0, copy] so calle=
rs
> > > > treat negative sk_forward_alloc as 0 available bytes.
> > > >
> > > > Fixes: 849b425cd091 ("tcp: fix possible freeze in tx path under mem=
ory pressure")
> > > > Assisted-by: LLM
> > > > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> > > > Signed-off-by: Octavian Purdila <tavip@google.com>
> > > > ---
> > > >  net/ipv4/tcp.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 87ef6d5cbfeba..0e062fcd94a6c 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -1037,7 +1037,7 @@ int tcp_wmem_schedule(struct sock *sk, int co=
py)
> > > >         left =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) -=
 sk->sk_wmem_queued;
> > > >         if (left > 0)
> > > >                 sk_forced_mem_schedule(sk, min(left, copy));
> > > > -       return min(copy, sk->sk_forward_alloc);
> > > > +       return clamp(sk->sk_forward_alloc, 0, copy);
> > > >  }
> > > >
> > > >  void tcp_free_fastopen_req(struct tcp_sock *tp)
> > >
> > > I do wonder if the following fix could be better (no change in the fa=
st path)
> >
> > Exactly, this looks better too, we can avoid negative
> > sk_forward_alloc and clamp().
> >
> > The packetdrill will need to be adjusted as it triggers cgroup
> > OOM with this approach, or we could defer the test to net-next too.
> >
>
> Let's defer the test. We also have an upcoming fix for tcp_collapse() any=
way.
>
> Octavian, could you resend a v5 (sorry for that) ?
>

OK, no worries. I'll post your version as v5.
