Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509839479F
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436901; cv=pass; b=pR+OCiA4FEuVVQ+XNL2GfsrQiUPHsU9qSb0otxhbSKsPlbFk5gHyaysfkZAjASP5OmzOnV713B6KYD5fXFpILCjpbrZboaz7SjIqTsF1YHnBkZCMyYFF7GtgsYeH7fcKNy2WDT8rQT2637z7nZ9/qp5liBQhYJUZjxea+TwIjtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436901; c=relaxed/simple;
	bh=Cr6SoVqAwbWoJGp6FUtdV4Ua2x9X0CDVbp/am3cRH2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNKp0YE7YrjgCjfE3pJdvh99sIZRMCbJt0EpVEa0cdX0OMy+wGdyAkiJ1JPVtLbLuKABu1PwnRW8ejTvb4peUdic9nfvGdvMnOtedFeVjb1Olsc3gD08otT2bidhgWJAOLDD/N42cby5R8uuupQ0d3StYVkLuGl7EXZkC9JdH04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyueVyI1; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyueVyI1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e041ea211so261228a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785436896; cv=none;
        d=google.com; s=arc-20260327;
        b=E/Mrul0ol/MpbAN0i9kpsXNS0/plRFaEJjRaMCqwGxUEVVk7faW68Stxz4wCfI6Fvx
         42C++HLmr19DFGTFiKTqbK8ycwg+I6vQjXNHqPrxwm+f3+2zTHfv5sTw0Z4+LnOot/i3
         eCSSCFqppzhBAYIXDvVH1NePuHVHcFAjAS3kaANFuD8VvvSbjbnnkIvAegtIZgw5hhg+
         c0x/vZyAC9qJCB75kTsMZ9If1aUka03s76b1vi+1A39MNQQd4IoCk+TvsQpbgRSlHbPX
         A2H1x2COhggdqg/NSuyWL75s0jU4XkkJ+3OOtHr7EJ8pbqFtWBw3MWZV9uLFB0gsZmAp
         kelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkoxyqZ2p2t6MX7nGCw2wXd+CLpsvZAqcArxWBtQlHM=;
        fh=11e9/xIwXsjdFXsgjxOaVuBkJSbZqr1e2p6EOM23ayQ=;
        b=KWeyz8N7wuyswsHG19fj87sS9c7LXp4AJ/jUIzIi7WXeNFx7BKctOwqbLLCd68OLKb
         Cra04wfnfbeQIjaCjJMMLjghRBUokHO3ttB/TGtUxppNHhDfWU0KIoQmH007R/m7rFi1
         jQsrGF5Xwzr/BHzrYPfW2vK08cc8eDTnKQYjwgS/4pb1yfD+QHisyjzAWgAQcrlkNcl2
         pjmn/bvUD3i/lvbUqKfeMF8guHj6v4HdTw+ol/vQNRqCHe9DtgVyu63t5+p3BtoE2khC
         xahzUbaYjiyuBD/J/l+yF5MVc9BDWOMYjRLV9O88+cq3aAOQsfNue0cNDVbrxi9ShBO2
         hcRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785436896; x=1786041696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SkoxyqZ2p2t6MX7nGCw2wXd+CLpsvZAqcArxWBtQlHM=;
        b=XyueVyI14BDW57L5ccEhV3XMf4gU7vi4gtl7wsFmu7LDzaAcZ99JBTVEAuoPkNH3V7
         C2VBeloD3CE9/dLSq4FSFbKB7tgX9A7eE+P6d3/SD6BEiahJVMlbKGgXq/5nYohxrTnp
         HvHxRNF2HTePJ/UQ0afdJmN2775edYjFwUErFwhOwvzNLUD92dLcvC5PAGFZpuIoBFn+
         jZX94e/uoQG0NxksKdEKXpU6VMWkwaanWNMxR2yVtU1uc20PmVmHA0Y+DYl8Z42LofEq
         RBjo2EvFyTFH9rUbVmmFxAC6q4lFhhkmrSl19lgSl1gGqjM4V98Nvjt9I7CXeSwH6B2m
         vdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436896; x=1786041696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkoxyqZ2p2t6MX7nGCw2wXd+CLpsvZAqcArxWBtQlHM=;
        b=nduWt+zCNHLOrvO51YKqXMi++8vcvT8yoEhyOG5ULr1YvXoY14pcCN8vY4tbLZ4BFu
         9HeCyhF1UFWug6hXwCv/wjzoAM0mgpPvc1fyfcmZ1QnAi45//EsBUlGeX5ZVr7RSpUM8
         +caNdsB44d0rUcYKbiAn1PwkgWsnnsitoVdzk4JKm0OZvzbbmCN2jTLThevvvWHwAAP7
         +imLMaQzU54Krmd8nkPyO4VGjN7z5KRVUIqCSP2NmVJ5gSoAsLMmqgZeyZjB2IYIilr7
         wEwsGRb7xATckcrNsauPqK1vdkBaollKj8Q5amCv4oEWTn5a+m5ABKfAtxD9fkgRiX0A
         RN6A==
X-Forwarded-Encrypted: i=1; AHgh+RrQXOQXMEBd8BI05NGF0egMDR3yyp1Fh+8QMaZQLKIg7skzEhzxjZrXoDqunFzOC8sKq5Wwo5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfaU+zTIUBculUCVFfIkrdl3Z24IHNSE+C1uL6qeN35wH6uHn
	/VDPHNyBL331vnudSn0fctnHYEv93wnO737MlQSWoZSETdC+seSJHDtZzKdPG56HS15qbiKppps
	3432CVLkMHQ8GxRQF60y3V9MdlJZIe3Ogxn7M5m9/
X-Gm-Gg: AR+sD1380ssnHTt2JCTb08ByNNN3Rj4PLVFhnWIRMFL8JlC+LirYYFjycY4SyCTd/cU
	jE9ApzfDOV+EKtaDj8J1deGAchjQrRCpXdaTOfAr+O5jAVwsAmSlBL59CdL2muk0V1GtlQqhWAR
	mREnr1aC7fPE27aaJ/Zj07/8lOPAGIG/fZr72qnEw4szoDUBI41GOLYPxU6lv1YBV+nHcX5gcaM
	WZLq6hhPjbK/Z/x7MwIfwyuxMUdKQfgRL8YMWEjiJLngWRqMcWknalTQJwsGzXzJgOqTwVoRcUk
	seoQEfDoPO5Fz4Y9iSm6GZt7pmaU+PibsYD4xkQUV2PKdGUooRsqCbCeJ5JuC8UT2lvbf9OCXFX
	rcPbXXyyGwyPunvu5N+bJs0u2AdQyg/wwXbRm3RjldrekVUzcdwWueShzkA==
X-Received: by 2002:a17:90b:2c88:b0:38e:2c8f:a01a with SMTP id
 98e67ed59e1d1-38f9bda173amr3196062a91.11.1785436895411; Thu, 30 Jul 2026
 11:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl> <20260712192958.1631672-2-jkoolstra@xs4all.nl>
 <CAAVpQUCD27YphUQ=aL3PyPtWwTo0tEtaFt-hvyoyCnepGAmYCQ@mail.gmail.com>
 <2048838556.1496380.1784464286664@kpc.webmail.kpnmail.nl> <64825400.394146.1785247552949@kpc.webmail.kpnmail.nl>
In-Reply-To: <64825400.394146.1785247552949@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 20:41:21 +0200
X-Gm-Features: AUfX_myDaFrtN39vm4RE1HtRDrhRWnMGXyf5-hg5kxSxtlkZvyA8zSGnbs1K5ho
Message-ID: <CAAVpQUCxyR3VDtkJQxG4HQF5HGzo-g=oG1rpKW8hCGUgVobBtQ@mail.gmail.com>
Subject: Re: [net-next v5 1/4] net: af_unix: enable custom setsockopt for all
 socket types
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:05=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> @Kuniyuki,
>
> Could you take a look at this if you have time? Would like to move this
> along if we can.

Sorry for the delay, I was on vacation for two weeks.

>
> Thanks,
> Jori.
>
> > Op 19-07-2026 14:31 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> >
> >
> > > Op 14-07-2026 11:19 CEST schreef Kuniyuki Iwashima <kuniyu@google.com=
>:
> > >
> > >
> > > On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4a=
ll.nl> wrote:
> > > >
> > > > unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired =
up
> > > > for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> > > > Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM a=
nd
> > > > SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() a=
nd
> > > > fall through to the generic sock_setsockopt(), failing with
> > > > -ENOPROTOOPT.
> > > >
> > > > Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_creat=
e(), and
> > > > also for accepted sockets in unix_accept() (reachable for stream an=
d
> > > > seqpacket).
> > > >
> > > > This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all=
 AF_UNIX
> > > > socket types.
> > > >
> > > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > > ---
> > > >  net/unix/af_unix.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > > index f7a9d55eee8a..3d256255085b 100644
> > > > --- a/net/unix/af_unix.c
> > > > +++ b/net/unix/af_unix.c
> > > > @@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock,=
 int level, int optname,
> > > >         switch (optname) {
> > > >         case SO_INQ:
> > > >                 if (sk->sk_type !=3D SOCK_STREAM)
> > > > -                       return -EINVAL;
> > > > +                       return -ENOPROTOOPT;
> > > >
> > > >                 if (val > 1 || val < 0)
> > > >                         return -EINVAL;
> > > > @@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops =
=3D {
> > > >  #endif
> > > >         .listen =3D       sock_no_listen,
> > > >         .shutdown =3D     unix_shutdown,
> > > > +       .setsockopt =3D   unix_setsockopt,
> > > >         .sendmsg =3D      unix_dgram_sendmsg,
> > > >         .read_skb =3D     unix_read_skb,
> > > >         .recvmsg =3D      unix_dgram_recvmsg,
> > > > @@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_=
ops =3D {
> > > >  #endif
> > > >         .listen =3D       unix_listen,
> > > >         .shutdown =3D     unix_shutdown,
> > > > +       .setsockopt =3D   unix_setsockopt,
> > > >         .sendmsg =3D      unix_seqpacket_sendmsg,
> > > >         .recvmsg =3D      unix_seqpacket_recvmsg,
> > > >         .mmap =3D         sock_no_mmap,
> > > > @@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, stru=
ct socket *sock, int protocol,
> > > >         if (protocol && protocol !=3D PF_UNIX)
> > > >                 return -EPROTONOSUPPORT;
> > > >
> > > > +       set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
> > >
> > > Please move this to unix_create1(), then we don't need the chunk belo=
w.
> > >
> > >
> >
> > I don't understand how this helps. The accept() path gets its struct so=
cket from
> > sock_alloc() not via unix_create() afaict. Also, unix_create1() is call=
ed with
> > sock =3D=3D NULL on connect(), so now you have to guard against that to=
o.

It seems I misread sk/sock.  Please keep set_bit() as is.

Thanks !

> >
> > But maybe I misunderstand you?
> >
> > I do agree with you other comment, accept() should probably inherit the=
 truncate
> > behavior from the listen() socket.
> >
> > Thanks,
> > Jori.
