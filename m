Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792445955;
	b=h3IC4297YwkABgk8VscQNThtaf9WQc06qCoxsiAt/OqpwXVR6laq2HMNnb6xnyPr4/K8
	 WxdeX4ThV7vWXh8Dcmt2U/5mYHUp+pDoMyanpSbG3rEL+Y58MgNRJwYPu5QVlDDFkPR6P
	 WfkBKWP1TmqcfHXq2j6whRc+bYqf9j2jz8xlwxo6IYVkzdONlcV1WOZzSWUETAjqPk1lP
	 0PlaRQkz7Nai1Kmrx2JhklyiI0wyuQBs/g+s0XeGGmaf6limHbqHnVs0tb2W2g4QxgmYP
	 1aLaG5sDFCoSplBXXs6J4v9vnoFCoX+hzRK+zAGKNoNbn8FWCiZnLs1+jsWrlfjdoxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YdIEvH0szPm2mof3XdeDVOIQnMVjdWNpvjqDvVaEY5o=;
	b=DOLrEE6d/5Fg7Raq7BxXFouNVq6ZHwfNUolW0tpMJ6vxFc6czGg8xUlMjFDtQf8kYk/I
	 UTsyOBGnWza+2ZQnaGnLVODqf3WwvDAJ/5fqHfNY4g3rPCsYDG5UC9Cv/Q9gZJgLzNgj0
	 9Od/8+EHagtssmJcIkM3M1eVn1317cw4cpVuprZeKDXNoEeWtcAqHZum3uJTfVO02UiT0
	 VF+NCuJxGtDoxLMHNsDuWvaUtGpy8nwTnGsnzUOpH7nNRVR+R4ng7v2N5lmNCzZu1ZvqO
	 SjmXPqkbH+x52Lp0GM7PDr/h6+PxR95SY6ib1tlLfa80hopASlBQGpT4JxdU/vwIpVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Ix4y531f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE43606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE43606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Ix4y531f
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso794055b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445955; cv=none;
        d=google.com; s=arc-20260327;
        b=k1DM/TOXpn30XosvGe/L8e2kBJzEUFrzInkyPsTlbFEuOLLIZpcoC8HGsOTtwRfZfh
         DleLFa+xk6mIQvb86RjXunk0mkKtDbK2kU09jecHvd4Pp1dKk+PBFbxf1h+c03bVtkYg
         iTZyo0M3lkB7q2ktqwMFo4BvChP8ufuRBqvimEmjuLWJ2W4bQm6831YI62CgQWhOvOB9
         kk6GkMIWSYUkPpFq7xVZqoHVArwkr14I7Wj2ylXAgOwwKfMo2SFzy95mtzWkF656kF1l
         BLdRyPULPV/VT7iWsmWnmxEnQcvNQJi8xkbsXWBYRu5ihQ6sewiIZr5LvxUvSGGAxxvC
         XYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdIEvH0szPm2mof3XdeDVOIQnMVjdWNpvjqDvVaEY5o=;
        fh=G5bKGl6+lfI/PxYHu3+KEOMWWD1aYkUh794QPz27BSU=;
        b=i/WUvow2KT56APqIpzEHrk+qhf6scYCpvqM7ZeeRK2vHjgWT4EGBOL2KPzAcxUWqt9
         Hh3BZ3XLOrq1dIpw9t/uLg9TK+SWSCXFtFKQ9uJHJWy7VAjJHmoNGRjHmfIdR5W6yJtR
         B5SlKyFhpk5CGNuQE9I8qLzHhbsKeVtK2dWNFcWk+DXVrX4yKC1gRXR6/HRtV8tI3dh+
         RyDdEci9zVnbcW/zzwWhRwzz2rSQ8eOlWj8rI8yjCrbeNGgoyD1ZKtx11JNxXse5MW4x
         Kd9Pnf5FtykWpHAbAm9IdZ2zS7wYoBltwOmrlU+FeoKwvBPt+HZJh6ZRORRCalQxvo60
         AY7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792445955; x=1793050755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YdIEvH0szPm2mof3XdeDVOIQnMVjdWNpvjqDvVaEY5o=;
        b=Ix4y531fFH2LRlzr/qt2r0tTWy4UHbamabwB9nfj8hHvVXao3uSnn5SqW/tE891e22
         ythou1cf5/KMlbs8XQeUkONh0fWtFAJphjqWOaUppfK66qrnpkh/2teQO1jlVkRXWFVq
         63rdr5cDPba4k6d8nrX2MUtbx65RiHeQ3dzjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445955; x=1793050755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdIEvH0szPm2mof3XdeDVOIQnMVjdWNpvjqDvVaEY5o=;
        b=D6r9d+GjNZg8ROMcf2gmLnjNR+pTx+N23C4w9vnOWypd9+Ae3PhrdqesP6XcUYrELd
         ahMC40SfZmVyCsF9vwPuRJNUzDEHMppiYfeJNSOcBiai+scD/42icTPDOpntWVkjYxv6
         6iVNb+KGfJwYXmf+pJ1P8Yqloc9NcAXlcNY1RdLC4xfO4wEhuICwfyrqpWxo6Ih7lUHU
         1Hl8bM2BpGlGTnMM4t4P+a8WB/LzwzO/zThgb1i7WylxR6hW41bdI77E9ANniEeizDdf
         gjcbx7Avko2W+z6ggsJ9qGf2+2LL/eNpObe4EWyFJK3TOxcYBZu8hWD89Qt2zOzOBD8Q
         R3CQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSAxgcf3hAMHKvgp0SV/XVlgL/JxPqQL+dIn+uor/TobmXq0OSdsXPawQ0EVcetwdDVnY+BGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYImI3Ef2gCeIBCwY2POIMb+89qaU4LCJ18D9G/h+S/YiSxxPBF9
	eku7l7a3ctWbAN7NXvvVBuaSP3e9k5Bg1oiarIpjxll+BVLWTIEDl/wKvgDCsXlv+D3piWsZvw7
	n8PvZczCos6cRZIEk0H79m5dDV/TNOVQDVL7taQ06
X-Gm-Gg: AYBFou05sJ+MIev1MpFCfm0JwWaq7EtzitxL1qeBaOrWaGht40eLjZw1lUxRSXCQLuv
	4sE7YNzVaADiNjASyhVOhSmy0A6KLHfvHgb7YfTxxN218B/SLWH3k1LZchTV5UWzwt2qCiWB+B5
	8HpFxp2Ii5E329vyyvAViQMPhUrWyRil5g+Z5TDdRrZ7MUgk9oOrzOrZaimfEZTVzZzmO/l96x/
	aPAD2ovwQAQpeuN85aPRT1dY8dW9ZYyfSXLG1ZpuZKxKHZ7HDAXpO9DLoaWT93E6h1plyeDgP7X
	F0EaBw/WDJ/Tb57DVKgO/Hq37RBNaP6dFBiJc5sY/32Sr2zd+IcUHak0MVlNvOYZInyiSo27i1v
	6WdyGxJtqUJvUbGasODPjPfDDJSR6XhiCHBNTbkKBBzyx
X-Received: by 2002:a05:6a00:408c:b0:89e:2154:befe with SMTP id
 d2e1a72fcca58-8a04aa2a249mr6685409b3a.8.1792445954768; Mon, 19 Oct 2026
 14:39:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com> <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
 <87ld7t3kl3.fsf@all.your.base.are.belong.to.us> <CAM0EoMmL1Yjo67wOmOwWtfYLNrVFH7zSbgDtx2Rg+k3-Nu4QOQ@mail.gmail.com>
 <CAJ+HfNigAQTJ37tx_74jqPcCCwsk1XR5-reOo7i-u0xCKqF--Q@mail.gmail.com>
 <CAM0EoMnToUnKv9gSm=fxTj=t3BMXzu3=NDDFY3OvysnbdjCubw@mail.gmail.com> <87ld7twn5c.fsf@toke.dk>
In-Reply-To: <87ld7twn5c.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 19 Oct 2026 17:39:03 -0400
X-Gm-Features: AclHuK_v_qThEpQTS0k4SvxRYLmwbCwYIgn59ELw6lEuRTWz8aDuR5OJLtdOoCA
Message-ID: <CAM0EoMm-uaKGGtvGLYiq_b22d+CNq4zFOD--y5hQ34tdnzv3rw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	cake@lists.bufferbloat.net, Victor Nogueira <victor@mojatatu.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:39=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Mon, Oct 19, 2026 at 10:53=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
> >>
> >> Jamal!
> >>
> >> On Mon, 19 Oct 2026 at 15:47, Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> >> >
> >> > Hey Bj=C3=B6rn,
> >> >
> >> > On Mon, Oct 19, 2026 at 9:07=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn=
@kernel.org> wrote:
> >> > >
> >> > > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >> > >
> >> > > > This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake=
: fix
> >> > > > autorate reconfiguration throttling").  That change only stored
> >> > > > last_reconfig_time; it did not address the concurrency between t=
he
> >> > > > autorate rate update in cake_enqueue() and the netlink reconfigu=
ration
> >> > > > path, which the original review flagged.
> >> > > >
> >> >
> >> > You are reviewing a very old version - the last one was a v6[1], mos=
t
> >> > of these fixes are in the "no good deed goes unpunished" from sashik=
o
> >> > ;->
> >> > I am about to post a v7. Maybe review that one?
> >>
> >> OMG... sorry for the noise.
> >>
> >
> > Not noise at all - with all these AI dump it is overwhelming. Always
> > great to have someone review. Sashiko will always find something to
> > whine about - the bikeshedding it engages in is shameless sometimes;->
> > I just sent an update.
>
> Erm, I think you're confusing patch series? This one is not the one
> you're at v7 on, Bj=C3=B6rn did review the latest version AFAICT (and I a=
gree
> with his comments FWIW) :)

Sigh. You are correct - too many patches in flight (in this case both
were 4 patch series and had "cake" in the subject).
Sorry Bj=C3=B6rn - i will send with your suggestions in place (I notice
that both sashikos have responded and bizare with all their
bikeshedding skills they both missed reverse xmas;->)

cheers,
jamal

> -Toke
