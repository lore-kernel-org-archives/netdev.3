Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED33546EB
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491285; cv=none; b=m9x8Ju4FQaxPnThagPlSqpcbvsGBeeu36sH0UaTX1M26+ujf/ENU81owB0he9sG5theBcIYb++0buptwO+ryqlHB0EgjdTLE5zFcMyVocbniWiC+Q9B6ScSL/kRwZIK9LyKzxwleem6mCW83Im++0p4sA8gYOwhayrG2NMkRcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491285; c=relaxed/simple;
	bh=9tOyGx+etv2yaq0dGcic41/lu8YDIPVtokZuywdPI/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuirUGYggPhalZbbs10eQZZwvTV7Qtchcnsfz0fMCM3K4joNpCVrHphqk19NncQd3a3E72YBf8OT3r0nVYEZoPVUUEM+uYI9I6nXLCRRv12VFDGuSaWH0cdy5J9W91ivOafMfipMFWresEsK6rK24l8A0rmRKpafvObH1G1SmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncvxbuc2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncvxbuc2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d02b4c3601so1648795ad.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786491283; x=1787096083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Dpay1sIiiYW77CYXOtUwBN8IbxXb19H2Gtj90x2ubQ=;
        b=Ncvxbuc2Kg8qam+mn+duEsrQuLflNy10FWvoe1JU6SoN3br5wHRRrdZFm5RCkQw85n
         usbWCvUCQ4XTxWENlu7iFzYMFMmmobHYyuVs9zuNZ2V2oJTkoio7w/63i8OSHJinqQDs
         nDKZEwEFhws48gHfeWpza+MYDcaIO9Q7q6iVI7ZYBiJ7XLulb5Njks2uKSzzODNYxsOm
         UdoQh0vaJU8wQsz4gsYo9lFOopzDiTf2auoYGstBvvMY5zijxZpP/UbA8i725VOH1n0F
         KYgHCJtEELswiXQijvuX58wgA9wN7tRkHFMybyP1kpvUeork/12O2gNCcMXKmBkJwo9G
         5W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786491283; x=1787096083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Dpay1sIiiYW77CYXOtUwBN8IbxXb19H2Gtj90x2ubQ=;
        b=VDG4ZvU0MQrsFe4Ba0HpKnGPNq8ZVvNQqhW+p3y4Tejy82o6TcVkrJf5y7QGsMnhLJ
         pzZ4LYfM6HHcZyZsR9dBmt/gYcuG4rb4i5xULoBlI4wJ4ZkaBbrOBD5FXxRM56rYLZ6W
         Lna7dXggfDnSms9iBYPnIhX9WMD6EL/hafmfmrIvKz8BhnF73TuJ5PptT+BTxDyLGEmT
         T5Vmu6t8CHRO3ns68DcKE6lqjke4z7Y1b/XD35+geJ2XGqMXRmYjWzBvecqHlXZWA9qX
         3qhF70n3wq2zet/pV1d8i4c+UxjqzWGVON8MRzHM2aPfGk/nB+VQt2r1C0rXkwKQNBrM
         HA7A==
X-Forwarded-Encrypted: i=1; AHgh+Rp5XXaMtgySWPeBllKfB1HzTeCK0E3KuNZvxKF2mfuI1NIr8eBDZ+NwxAHCn3yZr9IR77AkzwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVDX5TArdA6eN7o1l6vJwKhqdp8GDntvvPhTSayVhLcesNpe2
	kQ0Oz8fvwV56YW18++vpKqpuE36Rk8tEdded3W6vjN4ftfQ0kLO5Aa/D
X-Gm-Gg: AR+sD13ToLGHsZ4np/dXTEvoBz6A0C7LyYBy15OS85wpx48FCQpIOspRHpHkFePHIBN
	HtYKgqME5FVOp9/rDZ/6a0wJNdPmKqjOhm+Or0UZ9V80sS7XHoixgQzsPRy/L0LB+zwN081IYSY
	OR0nr+BCCMJhJzChYanFKDgqp1o37T77g9e+4ahjuZ/d0GqpQLYnsMPH8iMXag9mGEzCvDC87Ru
	/ow/Pw+nN/RglwTDZ44U/SB9A+cB2YIGELN4s2IzklecWFOrpML88gGVbvsvyhAi7APsY0Kp/g0
	f23NNs+DlJ4uY3tKMIyywAYBeplW+nwngBZjArpP8vVYK/i5jPjeeUZKlSEwSRJBTIWgKadfkRe
	UrPOE8DNwqAwDaLMQGLEhPxz92UFpJZS+MF1f1888gUBT8AfzowelHotCQnIeQbFkom2Mgj2HQp
	oWDtIcQfBkxnsHhShg+1rXuM5vukHq96WxW1EY78rDwsKnzVejXbn4TK2QdJQp93pakyxGL7p0w
	vnrM4e4
X-Received: by 2002:a17:903:2306:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d34565d781mr11960475ad.13.1786491282874;
        Tue, 11 Aug 2026 16:34:42 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef024esm12931335ad.10.2026.08.11.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:34:42 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:34:38 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, fmancera@suse.de, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] tcp: fix use-after-free of the listener's ipv6_pinfo
 after IPV6_ADDRFORM
Message-ID: <anuxjgodjdFrD9Ud@v4bel>
References: <antr7RCJAO578ZFW@v4bel>
 <CANn89iLN3DVs_SRrY1R7Eh1oZsSQqrgZdFSaaV3weCX3aFeR4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLN3DVs_SRrY1R7Eh1oZsSQqrgZdFSaaV3weCX3aFeR4g@mail.gmail.com>

On Tue, Aug 11, 2026 at 08:57:12PM +0200, Eric Dumazet wrote:
> On Tue, Aug 11, 2026 at 8:37 PM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > IPV6_ADDRFORM moves an established AF_INET6 TCP socket over to tcp_prot
> > and ipv4_specific. The socket is still a tcp6_sock though, so ->pinet6
> > keeps pointing at the ipv6_pinfo inside it and sk_destruct stays the IPv6
> > one; commit d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6
> > sk->sk_destruct().") relies on that to release the IPv6 state.
> >
> > Once such a socket is disconnected and listen()ed again, its children are
> > cloned from an IPv6 parent but allocated from tcp_prot, so they have no
> > ipv6_pinfo of their own and inherit the listener's ->pinet6 and its IPv6
> > destructor. The only thing that would fix that up is
> > tcp_v6_mapped_child_init(), which is not passed to tcp_v4_syn_recv_sock()
> > on this path. A child accepted from such a listener can outlive it, and
> > its destructor then runs inet6_cleanup_sock() on the freed listener.
> >
> > Commit 858d2a4f67ff ("tcp: fix potential race in tcp_v6_syn_recv_sock()")
> > added opt_child_init for the v4-mapped child; this is the same stale
> > ->pinet6 on the path that never gets it.
> >
> > Clear the IPv6 fields on the child. The converted listener has to keep
> > its own, so there is nothing to clear on the IPV6_ADDRFORM side.
> >
> > Fixes: d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6 sk->sk_destruct().")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/tcp_ipv4.c | 6 +++++-
> >  net/ipv6/af_inet6.c | 3 +++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 7f413f509d7dce..f830b212d38e49 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1730,8 +1730,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
> >         sk_setup_caps(newsk, dst);
> >
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -       if (opt_child_init)
> > +       if (opt_child_init) {
> >                 opt_child_init(newsk, sk);
> > +       } else {
> > +               newinet->pinet6 = NULL;
> > +               newinet->ipv6_fl_list = NULL;
> 
> Instead of adding a new test in inet6_cleanup_sock(() I would add here :
> 
> newsk->sk_destruct = inet_sock_destruct;
> 
> 
> 
> > +       }
> >  #endif
> >         tcp_ca_openreq_child(newsk, dst);
> >
> > diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> > index 282912a1199992..2090289408c035 100644
> > --- a/net/ipv6/af_inet6.c
> > +++ b/net/ipv6/af_inet6.c
> > @@ -479,6 +479,9 @@ void inet6_cleanup_sock(struct sock *sk)
> >         struct sk_buff *skb;
> >         struct ipv6_txoptions *opt;
> >
> > +       if (!np)
> > +               return;
> > +
> >         /* Release rx options */
> >
> >         skb = xchg(&np->pktoptions, NULL);
> > --
> > 2.43.0
> 
> 
> Also, it seems weird that all these issues caused by tcp_disconnect()
> are fixed by AI agents adding code in TCP fast paths.
> 
> What about adding code in tcp_disconnect() that only fuzzers are possibly using?
> 
> Untested patch:
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b694904172cfa1d8e7bac7076b60cb24..9dd44b0a31c4dc751b22558dc6b53ed49598e0b6
> 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3501,6 +3501,15 @@ int tcp_disconnect(struct sock *sk, int flags)
>                 sk->sk_frag.page = NULL;
>                 sk->sk_frag.offset = 0;
>         }
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +       if (sk->sk_family == PF_INET &&
> +           sk->sk_destruct == inet6_sock_destruct) {

I tested this, and it does not work when tcp_v6_init_sock() has installed
tcp6_destruct_sock.

static int tcp_v6_init_sock(struct sock *sk)
{

#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
        tcp_sk(sk)->af_specific = &tcp_sock_ipv6_specific;
        sk->sk_destruct = tcp6_destruct_sock;
#endif

}

What about "if (sk->sk_family == PF_INET && inet->pinet6)" ?

> +               sk->sk_destruct = inet_sock_destruct;

IIRC overwriting sk_destruct here breaks things like ULPs? Not verified.

> +               inet->pinet6 = NULL;
> +       }
> +#endif
> +
>         sk_error_report(sk);
>         return 0;
>  }

If sk_destruct is left alone the NULL check has to stay, so:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b69490..bbdd5b08593061 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3501,6 +3501,14 @@ int tcp_disconnect(struct sock *sk, int flags)
                sk->sk_frag.page = NULL;
                sk->sk_frag.offset = 0;
        }
+
+#if IS_ENABLED(CONFIG_IPV6)
+       if (sk->sk_family == PF_INET && inet->pinet6) {
+               inet->pinet6 = NULL;
+               inet->ipv6_fl_list = NULL;
+       }
+#endif
+
        sk_error_report(sk);
        return 0;
 }
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a1199992..2090289408c035 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -479,6 +479,9 @@ void inet6_cleanup_sock(struct sock *sk)
        struct sk_buff *skb;
        struct ipv6_txoptions *opt;

+       if (!np)
+               return;
+
        /* Release rx options */

        skb = xchg(&np->pktoptions, NULL);
