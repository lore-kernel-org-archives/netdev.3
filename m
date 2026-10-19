Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792425789;
	b=S4ep4zll7Y/ERATzC7cVMK+eW6WgfpC9GZ5gvDnAkRbZB50FpCXwShtt8reH1TVQ0V6r
	 EtDA+8MpHfjpCdEXVINsRVQYK5DDmIiTGutFBivcyz03GdRw/NvY8npBwsUWx0GY88tVM
	 bSOnNP34WSzIDL3JR10B0rsSQvVIuLSgWwHRGL3xCNqw1/LJuZ5fbPhz68IhC0BfhzJBX
	 wSQ9+9ZZWdOfFYAzRCNW7IJbb0AeRB5JgsV/YDM8cJuyLKUBmuxdbQ4w3HBaOH0b3Fad1
	 e43gTxGs4l3MwWSvVDict8rR6JTWE1XE5YVjFvoWg15G/O2Gmt7Eo2o54tsNYXSJEFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RbLiIfPw2q80htvwYCithB+heGpaY2y+RO++XY5n8fo=;
	b=LfQzF7Z8NKQ5I6yfIv+W7rVyGMYc+f8AK8FyTXCTeLItqLrY/l5Z0lxLtUYCVZCHaNHS
	 A5xIMHt4UfMJCB/7/qTAcybLj948kNIKglgQ5IF7m3ogtC4FX8abynB0s+Z3GfcNeOgOK
	 sPcfVihS5hB02HZx2J4ULuSMrXQMSJh8JAIdsgdFjCOGPyHhNv0OKR7CKFwt5Q/tuqHON
	 LN9H5DXcvk/kNr1339E7YSvUR8Y05k0ZTnLp0ZmBLhCCjfB2NzOnqOqBn4aXSFWLyInJE
	 nNmsG59SKw1fem2QAFivGUtlOmv/bSfINYzQ2nkURMPEF7pOlyUvBCs7J/hXNTJ2Ezw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=diFMVrnN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96006606C930
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96006606C930
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=diFMVrnN
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05b210703so677245b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792425789; cv=none;
        d=google.com; s=arc-20260327;
        b=iCgjQ0dnvB1Q4c5kCxj8fl1ObuHkPBMBH2jriQAW3QmoUWBQZjDVkcjH9J0MmV1qaW
         sksB/P2OyjLo9YJXRsugEHWJJmYFEpAnFgyl+JD1HikubYMm9IssrbZlAlPB/TSn4HVr
         yeyikkCOBLNbwDw0PRUDwFf+L2LfTkI3hRXokHoEZjSqpcu8q1mpFPbNsP5bjHzhFybw
         3jFKkZR4/vwif1zFg0pTt535UFUU/1QQXDX5rJzbECgUCrJnH8pbkx6AGwiLkmiVpeCQ
         jOLKU7iMzns8cJJBtmc5mGNYJDhBeKKas3+QPb5L9DtAgX+O8wXqKr8r9T2hkdQPaWS6
         5tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RbLiIfPw2q80htvwYCithB+heGpaY2y+RO++XY5n8fo=;
        fh=v1ruOtZGuvETx+98FBJCDsA/4QOspvRxhalQUISItZ0=;
        b=Ex26YjZCrVPxelcfATqkZTrSVA10llWyBFD0kMGdr2ixnRQHcczWl9sBp8dg1Gj1mM
         Q1zvofRIs3c91NYhfEFswiI24SSIV3bKZxmmhLF9ctBpNHnnEIDlk3NVKreZpRIgSlsX
         UgS2O2td85+81FRM8SUYv4oBou14cnie4rlkLRfwpnexRFSShucudH8LW+pcxKG57kBv
         AnkBU9fdLw48dxu+9wt12JX3G72nb4/JUcNYZjogLEjETnxVmPeS7zpZ48IFA4SCy7xF
         MCv5gOJo0dnF5z1x8nPPrSfZ1o+Us05mj5rYPbRgdYf0dILsEfTngWNncnzzKe4CT1p4
         xYsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792425789; x=1793030589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RbLiIfPw2q80htvwYCithB+heGpaY2y+RO++XY5n8fo=;
        b=diFMVrnNwJmXFPGw+lfVLg3hTqKQ2UVWN2cS4YMS3K9Rmy5ENUX+H1zkypNM/Q1PDd
         hTalqnuawtpIXDwTxHIS02gCo0S2XQboXofeS0gazsRrh7WV5rkEmRcLDRXtTXyAQ/XK
         qTkX0e0UYQRWiMYvtTeNTr22rnwgpvlMv9XGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425789; x=1793030589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbLiIfPw2q80htvwYCithB+heGpaY2y+RO++XY5n8fo=;
        b=b0oemNrAkGLYcnXUGTKO+zb0a90igERfn36vPo5okDsX9Yx255gNR7FmBCefBhq6rl
         iRCpS++/vV4XSXC0+hm/RvRi9pNASQJS90eXtxbwtyswWKIdrqYaWJJvf8Aow6HxkyTM
         7N36nz+Ars1YG3L/XDOSvYWNPYz0Q4d8wtTvruombv2vX9sJeYaTFzdwDnjyOMEEF7me
         oDlOdqwAB6RaHmtBZy/GTTlvAHK9khKJGY24M0HMzhr4qfrU3mXJUpIYfSeE9kwy6hiP
         QuUepOYiABgtWB1mtSXpdl+aVyc+sPZsDbMC10pqKychlw4DIKmms4iwvyUGrSW6bB4I
         SFtA==
X-Gm-Message-State: AFq9FYJfZ/cQ28BZU38F6aCOL2WxPT5KhA85ztjZ3r1pVVFa7n3Pv5t8
	RVKKpWkTqFHmEgbOBv9fHJYRY9fPD9Nckn7QS6+L4IUmQXxRR4Vq/KzKSmiaCBBNRsL9Wj5U1em
	6iemEDBtpqQTXz/VlpfSSSQm0p325hOHNYcAmWeUS
X-Gm-Gg: AYBFou20AokmKjDOrm0hOYjEFz9qDR6QBc60O1Ls4jGe0jRQrVedLvqhiB51yyEgWD2
	unf7LNlCDHPmB/EmmGuByc5yFrVpOsqhxjMul/BP3W/cpeRmjOH+tvQjN1It+Dd4be8MsJWN1mc
	gVdjNyIB9X38kHOaU5lXm0r9x7nCwCwKaVzrS4OT/v7i7I9oRC7BXq8ZqjT4MOMgMGBk39P/IdG
	LmK9NUNszcwLw0mn11aFEVf4n4XV8lCSqCE5P39Pqv0KRh2Vksl6q7CvcizlxNzqFEc2VTYYKTT
	boN/pQKpsSB40is+omCWpkGh2BtuypfHlyiMP4RhMHL9/PQhoPFGGLj+AaEyFBMbPnKanGeRp9G
	DOqTpEqeHgniuleFyXCWpcRTpe17i+2bHyZZ4+I2ILAQxL2r532QTXNKR78wLeURm/1x0h0LnLB
	S2FOts7dY1+s6vE3S0HAUD7x9IZU08VYl3t16Z
X-Received: by 2002:a05:6a00:2da4:b0:8a0:2914:5d27 with SMTP id
 d2e1a72fcca58-8a04c43653emr5859750b3a.44.1792425788967; Mon, 19 Oct 2026
 09:03:08 -0700 (PDT)
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
In-Reply-To: <CAJ+HfNigAQTJ37tx_74jqPcCCwsk1XR5-reOo7i-u0xCKqF--Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 19 Oct 2026 12:02:57 -0400
X-Gm-Features: AclHuK98yjpUr4du6cnGnVd5CFRnSyfIIWkx7bK1GtpKEViD0x2r6Mmpiqnmitw
Message-ID: <CAM0EoMnToUnKv9gSm=fxTj=t3BMXzu3=NDDFY3OvysnbdjCubw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cake@lists.bufferbloat.net, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:53=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Jamal!
>
> On Mon, 19 Oct 2026 at 15:47, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > Hey Bj=C3=B6rn,
> >
> > On Mon, Oct 19, 2026 at 9:07=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> > >
> > > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> > >
> > > > This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: f=
ix
> > > > autorate reconfiguration throttling").  That change only stored
> > > > last_reconfig_time; it did not address the concurrency between the
> > > > autorate rate update in cake_enqueue() and the netlink reconfigurat=
ion
> > > > path, which the original review flagged.
> > > >
> >
> > You are reviewing a very old version - the last one was a v6[1], most
> > of these fixes are in the "no good deed goes unpunished" from sashiko
> > ;->
> > I am about to post a v7. Maybe review that one?
>
> OMG... sorry for the noise.
>

Not noise at all - with all these AI dump it is overwhelming. Always
great to have someone review. Sashiko will always find something to
whine about - the bikeshedding it engages in is shameless sometimes;->
I just sent an update.

cheers,
jamal


> Bj=C3=B6rn
