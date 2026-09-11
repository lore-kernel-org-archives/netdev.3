Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDFC463B68
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128643; cv=pass; b=pCTommxCS4uqkWIfxno7FxrAaHYF96pwdkKBVK2Ccq2gaCBEZBDjtnSE1LoV+U8HLfV1t261/ok9rlFTjA11i01EWfcwRiBbwehF+oGmILqqog0zpZk7Bn9AE11a6mDmKwNSDHwMUMFnmfrsFQcG/5VT7HlUneiqoFs5SYFcwWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128643; c=relaxed/simple;
	bh=W3eM561Xa6+Lgd8YVLA7luWmizb/f/oA8Br4qDHb8p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJfYiK2ztIdenqttWXK0SP/4PgQs8jlAKdbGfL2nphQQ5Xgx1evF3MkdfdTHEVx/0bqX/xYknj+qDmsDu1+wRETUO9gk1sBE1/UqxmzYQQrdbp/QbhlamV37xpjh6Gg1mAHZX2NQgtS5EiHBRSu9Puf8n9Q0B7jWkn4bSkwk7bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=uE7Ih1Rz; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="uE7Ih1Rz"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85e68bdbcc1so4866477b3.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 05:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789128639; cv=none;
        d=google.com; s=arc-20260327;
        b=H+qjg6wNJwO0plYqqlDdTWwr9DaaHKtl+riPsmgCNNnJN2O3mYWIBNWswtsfEDwaco
         WnhoXmYRcMKRX1LFi+CHEUZd5+UCim81JdQMpUVsy66QYmdNdAC4dYYKZqDVH9c4miVw
         GCudqSat8QN+/6FKSKXGHw9ug1IDTHsgSmA4JMzB/VDrZpEFAshnV0VyrHhuWFGWLbaz
         l2nQUP64M3h1Ivd19I9tOwyPwQjkZwUJe04+R1gKnOkjFLBgpAaHgUmBUzxVTacbjT3Z
         xYiRHMr8mJ2Efus62oV9Jlj8xW2JfEPWqct/xuIKblqTXhXy6XyrTwkPhIrWJ+IuKBap
         PPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2yiSONf4nomVr6QfyaMestn/+O3ewewFxytikh5fBKo=;
        fh=LYD7NB71C62Fe8deEZ6Vuwfs6jozZ4G+ZhejgGaFyeo=;
        b=WUf6nWCtnMZZ9f/IAHWgFDM7AidyhzCjTFgOwXb6TZEgLRNr9auq78SDQ9AG0iifB0
         LX/+sFi/GfdQ2wM8lLWJcasv1t0nuAfFH60Qh6EfYNR/I9OormFAI338NCtL8bbRx2zw
         37mlNKlI7UPvV8oyCO9/0NkzOgLTwJuZfoSrDUy2d0CGmv9kvnMwsNPNsx3XrXBi1zkJ
         WPMQOgbVuJAgBRiUkTl1LkPyIdMHnrLecDClfT5lI6YwIBBHmZvBp03gaOdVYnHtm7Mu
         idWWZtjIDQ1BUWWh1lM3cPdoAxanS6vDhhLz0nSLeQHhekFxRgsqJdqtlEYvinbXd5Zj
         4qgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789128639; x=1789733439; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2yiSONf4nomVr6QfyaMestn/+O3ewewFxytikh5fBKo=;
        b=uE7Ih1RzDZ3fCboQA2QzzenV2PDV72lb5SAU722vFb6TBoizIbJnEm44ZNUUBGz68f
         sMIDfh3DtDH7WgVsDTBZ4rRKtcTNvR2H4DznN2oLH9eLVHtA8Syv/S26syksBIYS1j4m
         DkGaUCg6C1dYn0I4pbY6ermV9SqxrjjTGpbyynZauEJW6w6XMtHSVC4ln/j6yfMSNqhw
         PVHcjvPFvrnHzu99zXny7THZGWgiM3uzTYDyq+9eyBWtVIo3CjCTvA2Nu+3+6RawkAuZ
         9dbZDn3wTif1qVIhZFOJq07fGdIYK/2GxbQGPOKCoicjdGMUHhRddhFBfKdmqjweGbq9
         +wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789128639; x=1789733439;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2yiSONf4nomVr6QfyaMestn/+O3ewewFxytikh5fBKo=;
        b=nYPuuWQPPv3dEwKWKFw+Vj430Pxkl26o45ZgJYdPq8t0+myQUO2qu/8nx/M4UzBZ9N
         X6tH6m273pDXQxGGawae9CRpK7YnzJTC83HmBwaKbWpxMxbJWp2TTmq8CC9hNS6iJO7i
         9L+KaxMWPRHZed3X2kZ11gJvXNYHOM8KYlTbV5f7Y3PO1gio8sNmXTL8QMHWziogYNi/
         2b+9XCbdlNpjeDp3WwJAiY0k4/2FTEjrwqd863rTGmwMQD8uBceC/H9Z92CEa0LdEWaO
         3x3aY7xPGUeLcfLawbp/6a+1t30hx+wBQY47sScrH58axbDjgiheiVCNRJxD6aTz7mFa
         06aA==
X-Forwarded-Encrypted: i=1; AKwUvByaZjDytUwliUzBpDXC5UCkHIxBB8rmLor3RCmu7K9tlyXxy3FIi+gunB4u1OrKu637t/QRfvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nnjkQ9Sa8LUF2VJvEE6K3dQzBhTZgrZvOTdxkyRLpwwQIKs0WM
	HQXmJYHI4pLqNOFZXnDdjNFrtgbSnmqVAOvSLllnh6CFc3/Cu54MTT8xHxtaUpX2eODWPCHQZTo
	+cjpeQ1ICfLPFTwgOiNRoeGrFqqA9cS5I3Yy2mBOt
X-Gm-Gg: AYBFou1/0L+tHweLGsQdqrITNleRbXOXXYsA4/m/RuHbpqDFJE//NnJz2gFUGsvK2nZ
	XEc7ZEd7BqYedNyvuq3EUoRrmc2QozTNddLVQVkMCWpSn0WQ1dXzdk0L2R7oTEkpNsQsKGR4RrN
	W4lm8Svbs9K91YeooaaRFyf3tdyDSccwLM3Q4zL6mU1Vddl1Fv92SV+z7VyNpQAkGFJpqcrObdt
	tpE8l6bBG2bxPvXPztDVQfGBimgIzJUVQmhVcD2Y9trV6EHqmMwFf996cg5ySRbmzpLKmQO33MS
	kqVAcsvGWOS6ml0erXYSOTqsjz1SE8TnPVdsNBwlMsO95Q/di0viEaygPHhSB0R50Gks/sBItUl
	GUd3DVUoS5l61CfwcRfZ/p7OV9twQG6A5/VenmTIiSVhbH/lYYrnVb6WQX3Zgyt4l+OXpamR/n/
	H+TPZyKCOc4Jbw28jMnUu5WlVG8REICFYvoK2W3XutLlp8z/BlWfggkmdHNi/7NfCOK5WIiYJAN
	n3m0hA7m7YKWfXJahQRALL4gGtU/K0wpT4uPNnX0nISjM6bRjtIzbf5vQoJMDoqsZ3fdj2+xsUR
	oGa/qtC0cndq
X-Received: by 2002:a05:690c:e0c4:20b0:836:ec3d:b5e6 with SMTP id
 00721157ae682-884b3b68092mr12455207b3.28.1789128639600; Fri, 11 Sep 2026
 05:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910090052.2034970-1-julius@bairaktaris.de> <aqPpBJvfTwKrxSGG@chamomile>
In-Reply-To: <aqPpBJvfTwKrxSGG@chamomile>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Fri, 11 Sep 2026 12:10:04 +0000
X-Gm-Features: AcwNN1WRxBFcaBBoN1hWkoSgCiY-vapNxoDiBMGxk2sFq0eOn9xkqWZYHCjex_4
Message-ID: <CAC1t37KDNB6+v7Xq51AGrPtYZ4U95kUEQ6HDJSKt5YYE6+0zdA@mail.gmail.com>
Subject: Re: [PATCH nf-next 0/4] netfilter: offload a TCP flow whose reply is
 never seen
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de, 
	coreteam@netfilter.org, netdev@vger.kernel.org, geldot@protonmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Pablo,

thanks for taking your time to review.

> conntrack needs to see packets in both directions, are you assuming a
> packet-based load balancer in front of it?

No, an asymmetric route is in front of it, with two subnets sharing one
L2 segment and the server answering over that link, so the router only
ever sees one direction.

Conntrack already picks such a connection up when it misses the
handshake entirely, and patch 1 routes the SYN-seen case into that same
path, under the same nf_conntrack_tcp_loose gate.

  net/netfilter/nf_conntrack_proto_tcp.c, tcp_new():

    } else if (tn->tcp_loose == 0) {
        /* Don't try to pick up connections. */
        return false;
    } else {
        ...
        ct->proto.tcp.seen[0].flags =
        ct->proto.tcp.seen[1].flags = IP_CT_TCP_FLAG_SACK_PERM |
                                      IP_CT_TCP_FLAG_BE_LIBERAL;

Julius



Am Fr., 11. Sept. 2026 um 11:42 Uhr schrieb Pablo Neira Ayuso
<pablo@netfilter.org>:

>
> On Thu, Sep 10, 2026 at 11:00:48AM +0200, Julius Bairaktaris wrote:
> > A host that forwards one direction of a TCP connection only sees the
> > client's SYN and then an ACK continuing from it; the answer took another
> > path. That ACK has no entry in the transition table, so it and every
> > packet after it are invalid, the conntrack entry stays in SYN_SENT
> > [UNREPLIED] with a single packet, and the connection reaches neither the
> > stateful part of a ruleset nor a flowtable.
>
> conntrack needs to see packets in both directions, are you assuming a
> packet-based load balancer in front of it?
>
> > Patch 1 takes such a connection over as the mid-stream pickup it is.
> > Patch 2 withholds the reply direction of a flow offloaded in one
> > direction until conntrack has seen a reply, and offloads it once
> > conntrack has. Patch 3 offers a connection whose reply was never seen to
> > the flowtable in the original direction. Patch 4 adds a selftest arm for
> > the path; without patches 1 to 3 it fails, with the router forwarding the
> > SYN of the connection and nothing else.
> >
> > Verified on an IPQ8074 router with hardware flow offload, iperf3 -P2
> > between two hosts on different subnets of one bridge with the reply
> > direction bypassing the router:
> >
> >                                   CPU port    switch port   throughput
> >   asymmetric, without the series   81k pps       81k pps    944-947 Mbit/s
> >   asymmetric, with the series      2-11 pps      81k pps    948-949 Mbit/s
> >   symmetric, with the series      11-38 pps      81k pps    926-948 Mbit/s
> >
> > I wrote this series with the help of an AI coding assistant, as the
> > Assisted-by tags record. I have reviewed and tested it myself.
> >
> > Gary Dotzler (2):
> >   netfilter: conntrack: pick up a TCP flow whose SYN was never answered
> >   netfilter: nft_flow_offload: offload a TCP flow that has no reply
> >
> > Julius Bairaktaris (2):
> >   netfilter: flowtable: promote a flow offloaded in one direction only
> >   selftests: netfilter: cover a TCP flow whose reply is never seen
> >
> >  include/net/netfilter/nf_conntrack_l4proto.h  |  7 ++
> >  net/netfilter/nf_conntrack_proto_tcp.c        | 19 +++++
> >  net/netfilter/nf_flow_table_ip.c              | 26 +++++++
> >  net/netfilter/nft_flow_offload.c              |  6 +-
> >  .../selftests/net/netfilter/nft_flowtable.sh  | 73 +++++++++++++++++++
> >  5 files changed, 129 insertions(+), 2 deletions(-)
> >
> > --
> > 2.53.0
> >
> >
