Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF741D5AD4
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474647; cv=pass; b=r9u1wNrhRVA8JMcS9+BM8rVxIBvIpNg4t2GeFYfNVddAV0s49h8ykG/u0lot7OrA+lFU0gVAWATVsjw+OuHyMY3QQATKYjPZGMse5x0aEVDQNFmQ17g5YIzhA0sU5xt2jleoztfvT/Amuxeb1VHDQVEVC3Q6YquJPMu8XLd45kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474647; c=relaxed/simple;
	bh=ZHJ8OAAS11GvwqCX2X/+NHMjWMgx/zI423eMVPrpHyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsL/ipmbphr3/4r+V8yyACv43ckuVZ2s+RxAEx3waBwxhirGkf35GaMhxUAfijAz7UvSTni28z01Sudb9X5joyH2Pq8Nvgpe09UIuDqclUVZuIro0bwAxiOYhCWeb/LHROXO57ccXMaDRq3IORhSkXeUkqz8+AMEFM8rH3g/n5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKjrbCsR; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKjrbCsR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2a449c57so1990581cf.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786474645; cv=none;
        d=google.com; s=arc-20260327;
        b=i41F5Y6/QPRs4sjSiCP6fA48dJQfZRm6LSP0ciQNboXeEfB+lLzArIb0kPR+1VCP/f
         bDPCprq98kUtIv00RnulgKDS6FWTKNTWS6uy0qZB+y7JQVojc07dyVhMC3UIjzoCmT3X
         5wIZMftH97GoIrP/hQa72xakrjo6vFkGIxEmtCMsuz0nuxRc9hltH4RMqiJ6G5sQ5RhO
         M0PpoAU3aoplgz5wbz0v4JULzAsEMCfvOwgzSv/Q1b5KHutek6CMvlChu895OmvplWmT
         bdL4LkAw4urpAvKCs8spgsCvVETDEAwCycNlkjLY+sv3rIZ9IXhI7H6XHvSx5zwXE2UJ
         0AdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=usNn1nJwlk84kIrPdj9POHzME/3xfknMlc2Al6c/hoY=;
        fh=u0BCl6gMyS0Ver9T+PIu4lDTIyqUJjTwkCsUd+uRnfY=;
        b=J0udou9w8qEc2sxo7L/LjZD2wsrmqTh/ZRJy3u/7b5q6v1lsINejOVr/SsHWQbBz0W
         KzWAxOr7jQGOkbtnznNzCxgUIFi5ZHI3PVz7r15jX41Fe+G6eALs1viupC57AaGzlLeE
         N7fpz7VqAuj/p5u3Qt3Snmg0bqUBHfi5gVJmdq7pgvxd75S+6iCzjnnUQK7Ats/hwlp5
         nY5IFI0UgEO/FyYu4yNRuDeXjajjB2VZzxdQnms+AKH/IR9umDAhYTyozddvzZ9TB1ka
         uxjmFEBDRmQ/TTWKnoACJlgJwHJUWMU5fdlLdxwU4BoowU09+zwq6JmnN8eHQXzCkePK
         XWag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786474645; x=1787079445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=usNn1nJwlk84kIrPdj9POHzME/3xfknMlc2Al6c/hoY=;
        b=rKjrbCsRuPD15VS9GFOXR1zwP4kXTpHoFyQqIxFF2M9zmzrTCp07s1NPz6qNuIta1E
         eMoi9qRLUjFvOEbLQAZI/bkhLDDm0u0BMh4NUQzjVjbV2VIvIlFrOUQpsEzenLYG0hWp
         ccKdwQkw7/97/Q0tSVCjYHOZf88esQm80h4/MuwHul5BSRJT/l3IJmsHjxwYyr7m1/oi
         Az9KXlojGsHwqIwOaBKawbnY1mejL6I31zN7k7RyMIcEy+meb8v0mHsRoxh7mJFFX3wK
         3uzrZLo0lekLBW/mfax4yJDn7CbrlYBvAZb1fSeIqzDH5ltX+eeZmFC413HggA/vmzXO
         vwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474645; x=1787079445;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=usNn1nJwlk84kIrPdj9POHzME/3xfknMlc2Al6c/hoY=;
        b=EG6ijfXCAx93Qp6ARNnFhxdv4rqNLRookOSYIbZgZMMjY1dWBILf03tuOxT7ASBvJ/
         Bsqfb3hh/psWaaexE4WC31MLGg/SA+j4kIlSs5aENa6MsyqWk2LprDtOskqpF3TurMkK
         vpXIVQBXOXH5xIr3mMeAzUWcAlqU0hgfVhnVoYwxJzQfA42qivvydny3QgF0eDmXix2I
         Xcok6J2xqjEgbjrvWhBHVcvnLa8/tx5Bk3svcJMN2JWgIabhKwTEOJr6zYa+owmB2F8L
         LfqRYNiaZxyStnlgGZx9QvgS5NCVOBUYOilC6qHw3XzoNOH/masCYzREf5ZyakOpUol5
         3VBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpedu0hhzP9/e64CYrHe8g2ISuXiUZOsYA3w/oeC3JZ/HB0t/GZ+w7OqUvHlrhHpE7fQgUzMf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwB7AzhSb0WehS3fb/Snc9HVlUjtAYPK4cdlWI2WRVDBms3Gov
	3ACqjdUxxI/qotA8z3ndBEjkphZojhzWmv9Jh1AG+d9c0l6oUKOqLoQGXj2qzNGhaWemmLh12Dq
	5DNhmuI+CMouPnv00+txDmdXaqIxUfdJPZRF4A7Em
X-Gm-Gg: AR+sD12rp29bMx8hoJvj7lRVzB3QPCHdcIG1wmBAdTBWLdR0qoZrpkrVeUpI4w0LWpn
	vB1cvgMHwIpoIWeO40uLGT1lBFBts6kbmQbi2phOmfKqFAWvimZW75f5pVgKGiGdqQ3vLBDh64B
	QZPN3mDXzk7BZfrGH0XX7g/aLYLqd5dbIR+uu460YHBan6hDL991iIzOz518dQR1UFIdZFDcxlW
	hlnY9SpRIG3wdCeEr04vlK12+zw6cOC0hh7YHIp5vV+VEDCAUeO4pIbiwx6pnQOPcOtvPGj/gpR
	GcDdAOsGkp/eAYf+lFE4wHr0IkRtssSbHzVKntZdwltaVxmipf2sIyzEtafNAOow1oQRZ3gpfVq
	x6IdLjxk01kSitwBMedB7GYsroHUXthlyS+7Kz/F2HuBM7WSkydpd4NU=
X-Received: by 2002:a05:622a:5a14:b0:527:8770:8fd6 with SMTP id
 d75a77b69052e-52d6023366fmr25852671cf.35.1786474644111; Tue, 11 Aug 2026
 11:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <antr7RCJAO578ZFW@v4bel>
In-Reply-To: <antr7RCJAO578ZFW@v4bel>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Aug 2026 20:57:12 +0200
X-Gm-Features: AUfX_mz5_AsAOB_yLaxonkdkndPZvbb2-I4YN4d2VdZRdqrV8SE2l-BKQCiZrIg
Message-ID: <CANn89iLN3DVs_SRrY1R7Eh1oZsSQqrgZdFSaaV3weCX3aFeR4g@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix use-after-free of the listener's ipv6_pinfo
 after IPV6_ADDRFORM
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	fmancera@suse.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:37=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> IPV6_ADDRFORM moves an established AF_INET6 TCP socket over to tcp_prot
> and ipv4_specific. The socket is still a tcp6_sock though, so ->pinet6
> keeps pointing at the ipv6_pinfo inside it and sk_destruct stays the IPv6
> one; commit d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6
> sk->sk_destruct().") relies on that to release the IPv6 state.
>
> Once such a socket is disconnected and listen()ed again, its children are
> cloned from an IPv6 parent but allocated from tcp_prot, so they have no
> ipv6_pinfo of their own and inherit the listener's ->pinet6 and its IPv6
> destructor. The only thing that would fix that up is
> tcp_v6_mapped_child_init(), which is not passed to tcp_v4_syn_recv_sock()
> on this path. A child accepted from such a listener can outlive it, and
> its destructor then runs inet6_cleanup_sock() on the freed listener.
>
> Commit 858d2a4f67ff ("tcp: fix potential race in tcp_v6_syn_recv_sock()")
> added opt_child_init for the v4-mapped child; this is the same stale
> ->pinet6 on the path that never gets it.
>
> Clear the IPv6 fields on the child. The converted listener has to keep
> its own, so there is nothing to clear on the IPV6_ADDRFORM side.
>
> Fixes: d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6 sk->sk_d=
estruct().")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/tcp_ipv4.c | 6 +++++-
>  net/ipv6/af_inet6.c | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 7f413f509d7dce..f830b212d38e49 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1730,8 +1730,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>         sk_setup_caps(newsk, dst);
>
>  #if IS_ENABLED(CONFIG_IPV6)
> -       if (opt_child_init)
> +       if (opt_child_init) {
>                 opt_child_init(newsk, sk);
> +       } else {
> +               newinet->pinet6 =3D NULL;
> +               newinet->ipv6_fl_list =3D NULL;

Instead of adding a new test in inet6_cleanup_sock(() I would add here :

newsk->sk_destruct =3D inet_sock_destruct;



> +       }
>  #endif
>         tcp_ca_openreq_child(newsk, dst);
>
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 282912a1199992..2090289408c035 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -479,6 +479,9 @@ void inet6_cleanup_sock(struct sock *sk)
>         struct sk_buff *skb;
>         struct ipv6_txoptions *opt;
>
> +       if (!np)
> +               return;
> +
>         /* Release rx options */
>
>         skb =3D xchg(&np->pktoptions, NULL);
> --
> 2.43.0


Also, it seems weird that all these issues caused by tcp_disconnect()
are fixed by AI agents adding code in TCP fast paths.

What about adding code in tcp_disconnect() that only fuzzers are possibly u=
sing?

Untested patch:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694904172cfa1d8e7bac7076b60cb24..9dd44b0a31c4dc751b22558dc6b=
53ed49598e0b6
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3501,6 +3501,15 @@ int tcp_disconnect(struct sock *sk, int flags)
                sk->sk_frag.page =3D NULL;
                sk->sk_frag.offset =3D 0;
        }
+
+#if IS_ENABLED(CONFIG_IPV6)
+       if (sk->sk_family =3D=3D PF_INET &&
+           sk->sk_destruct =3D=3D inet6_sock_destruct) {
+               sk->sk_destruct =3D inet_sock_destruct;
+               inet->pinet6 =3D NULL;
+       }
+#endif
+
        sk_error_report(sk);
        return 0;
 }
