Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9703EEAE5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807227; cv=pass; b=eW9/empqu/fo/v1T4fRkDTmvLurSaHizEICp6hEZN9+3b9/fb6ONH73JPgUOb+rzgo8+Y8XutvgveVfv+zzbIj1GkIwTNyibVPgd06zWTkSGRLbAs0Untj8LGO+ONDK0vajVI/F5ifUMx/WAEvbA9vC/HwImH2MIV340S8JpSMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807227; c=relaxed/simple;
	bh=w40/FtxbZKULczyR4WoaPfSxD5dnnbbWaC2hbVxN7g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV6JOXk54dXzAAlf2N3PWoIKw0m7/nbyyn7kAYBGe3qRcbwOM+gU/591z0lYLp1vY/pSaH6TvsLXc1H+LovIItb/dTu9N9H5lxJzuDD/mhku5vEXNq7kWRAO75taUkPHElMld+Q+JaGZ7RIGXsjPujmJ01GdhCHwyQDfh5Lx0m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=nQytcoGB; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="nQytcoGB"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8819033dbadso1149465b3a.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791807225; cv=none;
        d=google.com; s=arc-20260327;
        b=hONLz2xMhfEk4+K0XF0qSdyuLdaL4qLoJa/rPtaDRc/Nt6/TVfLaWuXBGssVu5qXG5
         9DNgzgZCY5Rw3f392iLxaZO0lJwbeqIyD9h9D1x/M2pESBdOaTW/2XB9ZDIkt19mE7jS
         Vx9dzfIrjpq284rILlldHLuQaj9jCON+GySQQo8+7Jq4ZsG/tSqLXaZ4szbxIw8FTZkp
         uaxFeN0bkEBLRO/lvjW/qdA6yr8eFDNdFwaotPIdBfffNuL47C5iFt3l4dtlUHUxaX77
         AnB9XLNe416fLhHdkwbw9wGDxaGjGb9P/gEFxAU5OJ4ZQZlFfXUBqRjGT4siC4EsYFhr
         Kn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lhz4yNVZlZ4J584+wRDJNy7AXolyBCyVhPIFPEmIHvg=;
        fh=tN+LnJZiSPxndCoJFUukjfq9LhyBnVv+kmvn4m946ac=;
        b=OOa72mTXrxEGSo+ILrcIPQZ8QFG2U2grfhHK/FR7DPbKe50NQuF7/GF28SDWIHMnVX
         LOzvFQ/quHvMH22Cv6fiofYOva5LgsE76XpNfrCY4wTUFHpkP4y+jpqJdflDGo9AeuAD
         ExbqRXNv55C87qFfK0o3UunNQ9+BZcwXeCpDHEz+IUU5oJOWWesJFGNOWKUec/cD2U/p
         JNSYOyfvmgnOa3q0qdwrnUbGfpdYs3jafym6hGYw5R4G5s7ziHupiqcov4WxlbNik+5r
         0tURXmUFMRO0CqcwG9bw+b5YjWxHZnSZtz+IObVaOvTDjAhdNW5MLlPe6Jfbl54jhG3E
         E1uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791807225; x=1792412025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lhz4yNVZlZ4J584+wRDJNy7AXolyBCyVhPIFPEmIHvg=;
        b=nQytcoGBOcTjUNWwAmMopSInE2EXpF7+EMAj09i5+IQaf/Ic4rbc5bq/0iZfDxxWj0
         0DszEyrCqMkkkAcbkv1yZOX6spMn//fgLn1pLP+isnmtIqRxSLdm/4IqseQqePigac/f
         IiGH+BlB9KQ7xX0RnNtLye5dFomWZzha8/mIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791807225; x=1792412025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lhz4yNVZlZ4J584+wRDJNy7AXolyBCyVhPIFPEmIHvg=;
        b=UyVtAoXgJhz07Y+t9+xV3xinlwsfnvMeKqNnCGp2KHDmVA9ugdvWerdJ8NfB95DVj6
         6WzcO+YUCLMqPl6flG7yah2iQ+d+KCnHvHwGYf8m1ZUcH5QVXrLWxXqbLQLx1QF1suvO
         xC9ZfasnaSIICx5qbztjAJVqSZkfyZeXXBC/ufH1Wr3B3F2CjCz+CIMD0s/bwD8HkB4U
         9XeIUTiCd6wuU1/1Xb/CSWqjkbwxo2AgV7SOnKfymY3ywM8jRa2zo4/Mv8zzYU9M0MHp
         tHeQTFxeavcJcYmBK1SagmlsIBZroQlIm+0JVZRSwmqAB9QIVHyYuYGYjoa6unHr8Iyd
         5Taw==
X-Forwarded-Encrypted: i=1; AKwUvBzgVxivJTunrUmfIHtJlTgNKpGXya0DUKx09gTeEhPzDklkQEssllJC3Hb9OnK39Edd/44XVbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg6Hbr+Jdcgb83XWH9XfmEvXA5SV/c2iDQgmAAqeLb2osypCaH
	bRh+5Nb9SWmb8T0tXEi6DFn8ygTTpbjLwI6P4tkOEpWEXSmenqBD8HKR5C6Vv7XzlN09tyGCvGy
	W/RLJsE/gHVYqKvI7Plik7Ij0FZrh01xjgITJZ49u
X-Gm-Gg: AYBFou0qygwhE6oD6raxZJvJmo7GhUJUguU8O9Vrvkmce1j3kSkkpEYgPHEWNHK6oLI
	7DPaVi5geEH4VbAY1YMRm4OoKLzZU5v/hQu0uJwlbXLd1pdQoonZCYzvd3ZCypKvv7LRIGXL52C
	lovpNgp+vtIjPZAn4yOtw4NnQs4lW7Bg9cvz+3CKoZt1mOA2xcpvRVeklA0/sRf+ZErzYCHcRj/
	y2nwxoZORZoKIxV+373U4h7liKlZLcJOh/VG4w9P0u00MOBfcD2IfnwLXn1XvHPgj6dqtaV5YoO
	7EaYO+y9gdcLQxQ2ZxLl1Iz2jkFywd5xVY5oLhErCic0RuKLljao2Y3/tQmz0BAb5J9EmyvlL0M
	gX2raG91tw0q7xuwGciZbpIxOVJ5UsDQbSodaeOnTT3CQiA==
X-Received: by 2002:a05:6a00:f8a:b0:880:740c:927c with SMTP id
 d2e1a72fcca58-897c41e8cf0mr7288954b3a.8.1791807225108; Mon, 12 Oct 2026
 05:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-H19Z.v2.20261007062551-3@mojatatu.com> <179171627521.434549.2707902365679392275@kernel.org>
 <vPFrhbkwAui8zFPcGQTUDazQfsFDlr5GYuaYQ5BxJcrDiT6x1EljEze4cYadHqbeUW2ivLdpa8eC_cXC6ceACswgb-lW47aSVkHvHjhn_X8=@1g4.org>
 <CAM0EoMmWDYmJjTGq8t7bdS9-rzd-3o0qQvsw4OKMwPCD2JAsFQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmWDYmJjTGq8t7bdS9-rzd-3o0qQvsw4OKMwPCD2JAsFQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 12 Oct 2026 08:13:33 -0400
X-Gm-Features: AclHuK-v-78kRE5HpvXTDxHZ6upKfnCA0XEdJRj9Gw3IqG4O9aUepCtyG0vfvyQ
Message-ID: <CAM0EoMnkWc3wcNE9WpiDyWxk9fw_2+m8zR+7KrNV2oG_FthGoQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: act_gate: cap the number of
 scheduling entries
To: Paul Moses <p@1g4.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, olteanv@gmail.com, 
	vladimir.oltean@nxp.com, eadavis@qq.com, dcaratti@redhat.com, 
	dsahern@kernel.org, stephen@networkplumber.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Oct 11, 2026 at 2:56=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
> >
> > > [Severity: Medium]
> > > This sizes the cap against the u16 nla_len of the nest. Should it als=
o be
> > > sized against the largest dump skb?
> > >
> > > netlink_recvmsg() limits the dump buffer size:
> > >
> > > net/netlink/af_netlink.c:netlink_recvmsg() {
> > >     ...
> > >       max_recvmsg_len =3D min_t(size_t, max_recvmsg_len,
> > >                               SKB_WITH_OVERHEAD(32768));
> > >     ...
> > > }
> > >
> > > For RTM_GETACTION dumps, netlink_dump() allocates at most about 32.4 =
KB.
> > > dumping_entry() emits 36 or 40 bytes per entry. A gate with more than=
 about
> > > 810-900 entries therefore cannot be dumped, and the new cap still acc=
epts
> > > it.
> > >
> > > When this happens, tcf_dump_walker() trims the action and returns wit=
hout
> > > an error:
> > >
> > > net/sched/act_api.c:tcf_dump_walker() {
> > >     ...
> > >               if (err < 0) {
> > >                       index--;
> > >                       nlmsg_trim(skb, nest);
> > >                       goto done;
> > >               }
> > >     ...
> > > }
> > >
> > > If the gate is the first action in the skb, n_i is 0. tc_dump_action(=
)
> > > then returns a skb->len of 0, and netlink_dump() sends NLMSG_DONE wit=
h
> > > success. If earlier actions fit, the next callback restarts at the ga=
te's
> > > index and ends the same way.
> > >
> > > The result is that the gate and every later action in the IDR are mis=
sing
> > > from "tc actions ls", and userspace gets no error.
> > >
> > > The commit message lists this truncation first under "The bugs:". The
> > > Caveat Emptor section then says the cap does not prevent it.
> > >
> > > Should the cap be small enough that a single gate fits in a dump skb?=
 If
> > > not, should the commit message stop listing this truncation as someth=
ing
> > > the cap fixes?
> > >
> >
> > This is the one I encountered, not that the cap should be smaller or th=
at
> > this type of dump needs to work, it's confusing that it returns 0 and s=
tops.
> >
>
> I will look closely tommorow - if i can reproduce it i will add an
> extra patch to address this (already adding one for taprio with
> similar issue i caught earlier today).
>

I have reproduced it. TBH, this is something we already captured as a
followup from sashiko and planned to submit separately later. I will
make an exception this time since i started looking at fixing it
(starting with what you suggested).
The problem with sashiko is you get punished every time you submit a
patch, so it may look like tc is submitting a lot of fixes but that is
because it is a recursion: every time.
To put it in scripture terms: no good deed goes unpunished and woe
unto them who are not fixing the "pre-existing" issues for the
secondeth flood wave is coming unto them real sooneth when the kiddies
start poking at sashiko suggestions.

So by adding this one more patch (since I am working on it) it will
increase the sashiko attack surface and we are going to send one more
revision, but like i said will make an exception this time.

cheers,
jamal
