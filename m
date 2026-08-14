Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F970836
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786667035; cv=none; b=VzM+qfQzXg2Aj6zZOlgcGIrtI9Q9Xa6guGGNAJlaYBge8CipdwPA8y9P5e1jIVHb5cK6upsGrLnfcL4jWATowtl8a2Fh0TOgEwE5fm5YpNjz7u9GCG6DSroCFqes/mvMriIfzoWUTeSkYCEe0lLiBld/4FgqsCqrFpZgNJrk4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786667035; c=relaxed/simple;
	bh=d2M2ejmhiKRKibtMxV0u6DGfjPFFBSpzfugpFnWuutw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0qS0ulU/yyZhPk9+bbT3g3o5Ka/UZUqO1Zq0z5oS0rw8HzzRE3DjrU2NPMkbIBL/zdfA/z4hrLMuaZ1Z/2g+GLZeddJImyeOzF3Y+SCwanQ5aVPyyVsF7NSrPhDiYkdqoeEJ29afxX9k45vlgB2AndYpFqwK7daWL3EqTBPQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xxl2HBzp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxl2HBzp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e88b60121so346019a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786667033; x=1787271833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xLzPK09hHfb3mMLCM03SECQSQFR3ocDYmsdwrLfTIA=;
        b=Xxl2HBzpqiDf0H5OqC4PMHJO8HoDFPgmexjEVjDwWK1whIPSC15B62YVIm7ucmNK7S
         D82xE7fy8ZQLK2t7UPjNq8iz7wAH3ZFoUzLjB8Ug2U7MbKqscHvZZTrtq6iHhXmTh/fO
         cPDVPF+ew+1shuQSFohDRGEBl1BRBeqmcAzFhvQLya04V4HMOSSdqewGLKNgtUJ1ZP0N
         +Pf09VzEYYvEWG0nuyYy632dlu57MObzv5eVNltFFG1GigWmD9YLqW6rGvSK2dWjbm7r
         21JuvktwTRkyxSVOa74L02nElEOWy9JDPxJMbk1+m3kNnwEo3UAwVSC26EmZu9sBagJI
         XCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786667033; x=1787271833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7xLzPK09hHfb3mMLCM03SECQSQFR3ocDYmsdwrLfTIA=;
        b=XtStCGiefBs/MD+R6kWKgbiYhxanB0Jz7WgDXEMIbrbCGqBo0XcMmm156SReAZIl7w
         3vQyO1n5NnCuwwNR5HTgHkerF+Wst/fInXuc6lgkc5X8bV49kfId3Y+zskReEjmpMcJH
         cefpoPfcp2tNKZEOofmlBFMiR9rlWd7c/gm45322aXoKH3UY903aRf5Uwv2V5qVouYSj
         0XmnMggLrgqyaaF93/0ak5OgaNb9TPWsccQ30cpYPCbczTHKe556kAas43g48/yFgI60
         L2ifWKEh6TVMXB2B9katd9ZfCid7KATrPbmqYxgsBFjChraZyHSfqz9zonP60GqsZQ02
         YsZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvZtBxdgc9TuuvQCsc0cX0L0sSS72U0dv7ILtTcuVWl/VFuJZDmEmMh/11mqtm1vP2JP08THk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2j0gUvrCp1fugTREjjrsma+9kp9V4Jkb0aB+e9MrWq7ljMkDt
	hLJgsoNaP8LvJD5jIRn8lAXSGku3nJtl0oi7cdgmt4KOKH0KU2lOFJQ4
X-Gm-Gg: AR+sD11vHR/uTe4G7aTWt7TaDOuCffOVv3iy9t5JsTp0w/yW/HNd5HfUP3+TtGmVexd
	/H37HaRitKY3tYCXlMdH8PMMc8phQTzeGoT2M3+DUcSGBUi610tplxQQ1p/m4vNdNFZFDKHna+4
	+0zNGQq6AejOyaEvtNbQIDMljp84D9m4UQymbKDlJjHX6PXrXgrsrmfE5A1vlOyYH5csHaVF+PO
	olEv8OOImoDzvprtY3/1gKJdiPeFz2xaOwZb64hTHQ97Yx7Hf/Gu43jZL7AdrhimhQo8NAipdbN
	dypp6fv/JwY05vw3bnESKvkPDIbwhzSp5n3uzNVsS7ozPS/vULTCYv3wIXG7LG2uuHGkN5ONCPy
	zm0jDCHJcDA+OEVE+mTDTmfObh99tsgTTjBzTICMhcYnjlbVl14f3G13QqoJnh4XW6euH4agGXE
	1+VNiJdHSFN/XCCGZvoAnAmJXTjNKiMb0fN8l5iJw4VCDJZSGUd6LAjGP8Alc9YDQlQwpaJLftJ
	B8/UwkB
X-Received: by 2002:a17:90b:4a11:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-3933bcd866bmr1652811a91.21.1786667033230;
        Thu, 13 Aug 2026 17:23:53 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea972c79sm166839a91.4.2026.08.13.17.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 17:23:52 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:23:48 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, fmancera@suse.de, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] tcp: fix use-after-free of the listener's ipv6_pinfo
 after IPV6_ADDRFORM
Message-ID: <an5gFFT7VhxfQVSx@v4bel>
References: <antr7RCJAO578ZFW@v4bel>
 <CANn89iLN3DVs_SRrY1R7Eh1oZsSQqrgZdFSaaV3weCX3aFeR4g@mail.gmail.com>
 <anuxjgodjdFrD9Ud@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anuxjgodjdFrD9Ud@v4bel>

I dug into this further and ran into a few obstacles.

On Wed, Aug 12, 2026 at 08:34:38AM +0900, Hyunwoo Kim wrote:
> On Tue, Aug 11, 2026 at 08:57:12PM +0200, Eric Dumazet wrote:
> > On Tue, Aug 11, 2026 at 8:37 PM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > >
> > > IPV6_ADDRFORM moves an established AF_INET6 TCP socket over to tcp_prot
> > > and ipv4_specific. The socket is still a tcp6_sock though, so ->pinet6
> > > keeps pointing at the ipv6_pinfo inside it and sk_destruct stays the IPv6
> > > one; commit d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6
> > > sk->sk_destruct().") relies on that to release the IPv6 state.
> > >
> > > Once such a socket is disconnected and listen()ed again, its children are
> > > cloned from an IPv6 parent but allocated from tcp_prot, so they have no
> > > ipv6_pinfo of their own and inherit the listener's ->pinet6 and its IPv6
> > > destructor. The only thing that would fix that up is
> > > tcp_v6_mapped_child_init(), which is not passed to tcp_v4_syn_recv_sock()
> > > on this path. A child accepted from such a listener can outlive it, and
> > > its destructor then runs inet6_cleanup_sock() on the freed listener.
> > >
> > > Commit 858d2a4f67ff ("tcp: fix potential race in tcp_v6_syn_recv_sock()")
> > > added opt_child_init for the v4-mapped child; this is the same stale
> > > ->pinet6 on the path that never gets it.
> > >
> > > Clear the IPv6 fields on the child. The converted listener has to keep
> > > its own, so there is nothing to clear on the IPV6_ADDRFORM side.
> > >
> > > Fixes: d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6 sk->sk_destruct().")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > ---
> > >  net/ipv4/tcp_ipv4.c | 6 +++++-
> > >  net/ipv6/af_inet6.c | 3 +++
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 7f413f509d7dce..f830b212d38e49 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -1730,8 +1730,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
> > >         sk_setup_caps(newsk, dst);
> > >
> > >  #if IS_ENABLED(CONFIG_IPV6)
> > > -       if (opt_child_init)
> > > +       if (opt_child_init) {
> > >                 opt_child_init(newsk, sk);
> > > +       } else {
> > > +               newinet->pinet6 = NULL;
> > > +               newinet->ipv6_fl_list = NULL;
> > 
> > Instead of adding a new test in inet6_cleanup_sock(() I would add here :
> > 
> > newsk->sk_destruct = inet_sock_destruct;
> > 
> > 
> > 
> > > +       }
> > >  #endif
> > >         tcp_ca_openreq_child(newsk, dst);
> > >
> > > diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> > > index 282912a1199992..2090289408c035 100644
> > > --- a/net/ipv6/af_inet6.c
> > > +++ b/net/ipv6/af_inet6.c
> > > @@ -479,6 +479,9 @@ void inet6_cleanup_sock(struct sock *sk)
> > >         struct sk_buff *skb;
> > >         struct ipv6_txoptions *opt;
> > >
> > > +       if (!np)
> > > +               return;
> > > +
> > >         /* Release rx options */
> > >
> > >         skb = xchg(&np->pktoptions, NULL);
> > > --
> > > 2.43.0
> > 
> > 
> > Also, it seems weird that all these issues caused by tcp_disconnect()
> > are fixed by AI agents adding code in TCP fast paths.
> > 
> > What about adding code in tcp_disconnect() that only fuzzers are possibly using?

Not touching the fast path would be best, but a few things make it look
hard to fix by touching tcp_disconnect() alone:

1. The bad pointer is not created by tcp_disconnect(), it is created
when the child is cloned. The converted listener still has its own
ipv6_pinfo, but the child does not, and the child comes out pointing
at the listener's one. This is the same as what 858d2a4f67ff fixed
for the v4-mapped child, and here opt_child_init is NULL so that fix
does not apply.

2. Clearing it in tcp_disconnect() means clearing it on a socket that
is not closed yet and can still be entered through the IPv6 sockopt
paths. do_ipv6_setsockopt() has options that are handled before the
ADDRFORM recheck, and do_ipv6_getsockopt() has no such recheck, so a
thread that entered before the conversion accesses that pointer.

If I understand it correctly, tcp_v4_syn_recv_sock() has no such point.
The child is not in the hash yet, has no sk_socket, and already runs on
ipv4_specific, so nothing is using this socket while assuming that
pointer is valid. It looks like the only place where it can be cleared
safely.

> > 
> > Untested patch:
> > 
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 455441f1b694904172cfa1d8e7bac7076b60cb24..9dd44b0a31c4dc751b22558dc6b53ed49598e0b6
> > 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -3501,6 +3501,15 @@ int tcp_disconnect(struct sock *sk, int flags)
> >                 sk->sk_frag.page = NULL;
> >                 sk->sk_frag.offset = 0;
> >         }
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +       if (sk->sk_family == PF_INET &&
> > +           sk->sk_destruct == inet6_sock_destruct) {
> 
> I tested this, and it does not work when tcp_v6_init_sock() has installed
> tcp6_destruct_sock.
> 
> static int tcp_v6_init_sock(struct sock *sk)
> {
> 
> #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
>         tcp_sk(sk)->af_specific = &tcp_sock_ipv6_specific;
>         sk->sk_destruct = tcp6_destruct_sock;
> #endif
> 
> }
> 
> What about "if (sk->sk_family == PF_INET && inet->pinet6)" ?
> 
> > +               sk->sk_destruct = inet_sock_destruct;
> 
> IIRC overwriting sk_destruct here breaks things like ULPs? Not verified.

(after fixing the condition properly) I tested this, and with a socket
that had MD5 keys set, connected v4-mapped, then IPV6_ADDRFORM'ed and
disconnected, I saw the MD5 keys leak. tcp_md5_destruct_sock() is only
called from tcp4_destruct_sock and tcp6_destruct_sock, so replacing
sk_destruct with inet_sock_destruct leaves nothing that frees them.

> 
> > +               inet->pinet6 = NULL;
> > +       }
> > +#endif
> > +
> >         sk_error_report(sk);
> >         return 0;
> >  }
> 
> If sk_destruct is left alone the NULL check has to stay, so:
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b69490..bbdd5b08593061 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3501,6 +3501,14 @@ int tcp_disconnect(struct sock *sk, int flags)
>                 sk->sk_frag.page = NULL;
>                 sk->sk_frag.offset = 0;
>         }
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +       if (sk->sk_family == PF_INET && inet->pinet6) {
> +               inet->pinet6 = NULL;
> +               inet->ipv6_fl_list = NULL;
> +       }
> +#endif
> +
>         sk_error_report(sk);
>         return 0;
>  }
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
>         skb = xchg(&np->pktoptions, NULL);

IMHO, the original patch that touches the fast path still looks like the
right approach:

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7f413f509d7dce..f830b212d38e49 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1730,8 +1730,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
        sk_setup_caps(newsk, dst);

 #if IS_ENABLED(CONFIG_IPV6)
-       if (opt_child_init)
+       if (opt_child_init) {
                opt_child_init(newsk, sk);
+       } else {
+               newinet->pinet6 = NULL;
+               newinet->ipv6_fl_list = NULL;
+       }
 #endif
        tcp_ca_openreq_child(newsk, dst);

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

What do you think? Maybe there is a better way that does not touch the
fast path.

---

While working on tcp_v4_syn_recv_sock() I also found a separate bug: if
the route lookup for the child fails, the child is destroyed at
put_and_exit before tcp_v6_mapped_child_init() has run, and it frees the
listener's flow label list. This is probably better fixed by a separate
patch...

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7f413f509d7dce..52eaaae27b6006 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1720,6 +1720,11 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
        if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos))
                newinet->tos = tcp_rsk(req)->syn_tos & ~INET_ECN_MASK;

+#if IS_ENABLED(CONFIG_IPV6)
+       if (opt_child_init)
+               opt_child_init(newsk, sk);
+#endif
+
        if (!dst) {
                dst = inet_csk_route_child_sock(sk, newsk, req);
                if (!dst)
@@ -1728,11 +1733,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
                /* syncookie case : see end of cookie_v4_check() */
        }
        sk_setup_caps(newsk, dst);
-
-#if IS_ENABLED(CONFIG_IPV6)
-       if (opt_child_init)
-               opt_child_init(newsk, sk);
-#endif
        tcp_ca_openreq_child(newsk, dst);

        tcp_sync_mss(newsk, dst4_mtu(dst));


Best regards,
Hyunwoo Kim
