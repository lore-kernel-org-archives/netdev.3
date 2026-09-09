Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6F582B8B
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972265; cv=pass; b=GeP8u0b3pEgwN/ZLaqSwkhMTfLzUMbeGkxPrM0KT7/gvfEyCuueRH9NhmNhucqCROr+6yEPKqPeAKi+K7WbuwizwY5Yt9rwRdrX3zQFjxPId3lHXiXSsrhlIgNUDSYEOQCNwSlYWB2kfPZopTpLgPTzFF5y2nYx5iQfBQhS09Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972265; c=relaxed/simple;
	bh=m6fk8JHYFEz30V0AHeoziaJO92c3GqRALMF2D5SW+MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfKh+W2/O/k7H2/AihnUy4pOYQyEw50SiDutj1tPVlWve13QQ0mQMFSFF8SgRyiRh7PBwqaSKEqT6QDGDRPcys7yGSz8307vuDUHdltkPsuRZbvmuQpiFn+J4SNSMPFeNE0EySlE1RuvIk3sbRxRkoUIWgyx/GpGc3IkZ7+/jJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIAc7kUf; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIAc7kUf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6f9e2f681so67950135ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788972262; cv=none;
        d=google.com; s=arc-20260327;
        b=sKiblpw/KIl+VWI9obkSqoqiPzQGCXs6fB84HmnC3tucZXGGc/juayVgaBSWuhL307
         Eb8QvlWrSL3Nab2bW2YLtcmlwAP/pJqIl+s9Nw2nBZSaExd0FUxmv6aJXPK2w/TAHRv+
         t5NHxHPFfj+tvsNZUl6p/fjdHDYLNuIKErKMpyG5+NkC+EJA2XKiTI2x3i1av0XlpqyM
         AMJvQGt9FSB8o1c/GDoJ3zuJMbCxlY7VJVYW0Duij6o8RDZ6t7w/rK7wxUVcTnSBCGRe
         09dHqQDp/uPFoAm0eDkQWcQbPkR6vcmXK3GLnl53XEbAw9fDm+/CXtk7lZCthpEVHA3C
         /4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GL83gaMOvXfff1Ob2HNVIqAEM9PbF7exA6Z8GJpPwHU=;
        fh=P10J6mjSg4/Ab8sk2cpTCtJAUefU64ttJjetxqAq0RE=;
        b=aDgj2+usKIGcuDmQNFKyRD3uZYCaovoq35vOsNvQcpbCHqIKwy0qtO70LyN+3YqkLv
         rChtSHAZe+ds5tkdTGb6djAYGiTARXVnxCjz5R4/qNwlgZ+Xyjo2W5gfT5HV/addVtmL
         qkctYxy8Qnkva+IVps2Nupn17Twg5F9GEB/gmA0OAMnEpY0ojFSU5oXQU0tdfhMUrgp+
         5ko4ehFx0mN2Y10qNnWpSpWb63DEEWQIbBVDzg8SxY9dxsiAFKU1fop+p8PqOHqTdG+n
         GEXv65OsPpgZ9evmZMVFNSjb0LoAlFnQHo94gmIYFg1hnbl1ehzMAE093kuPtqOMLp8E
         sLfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788972262; x=1789577062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GL83gaMOvXfff1Ob2HNVIqAEM9PbF7exA6Z8GJpPwHU=;
        b=HIAc7kUf2P7eK4BCUd3oTlqnbY3geQn2RcwceI3MuiHWsKBc9yrcOf08JHbB1hr210
         PKLkYYmiiiUSwv/cDkSgPM4sK0ysRSchuasZffsnM7FpzPcJ1NbdXmCedIhEku/6iv8u
         98beukwuloFTz+9pA80oMNvzQ4haWll/oKUCqYPN2XALxiZOnV1IstydJhQ0PmwMVH0d
         5tnUI6M30p2DZ8rWqe11kBU8ZKbarfTxxFvBADisx0DFGsPPwp55akqETi4k5JPU5TfE
         1DpM1ppO2OXMF9/aNnQw/vqvxBCq+MI/N6YeC6tLn3rvybkZHnCzx3XoSgiQkXNLP22w
         JFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788972262; x=1789577062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GL83gaMOvXfff1Ob2HNVIqAEM9PbF7exA6Z8GJpPwHU=;
        b=Hcsy1XZYmV+VLwyCdXzf3xVsdrLrD8vRmhSe/Uz8jNCx/MUuez7+WZKi1pU67XwQaP
         /g/JewTY8PzdvM+/IDbnDE/W+3l6KSRacEPCYzfY4pReru273I7kGErqQtcIVQo/JNQM
         Q2RFA1CsYYCDOa/rQXUteUbpFDtYnFw1uKX7wyK1MdKPwNypqF58gE4Vlj4IhcArhSyU
         DJg1rwuU3WxiHm7k6iDTv5YusK2mtMCJLDFGvxCbevyT0AsxmrMJFzIkbC9l0ms/WJ3Q
         8diLyEPBVrL14unbw4w292V0vURWQKJ0s4RFu6oaE82DJw1Yk3eJYbH+JdEG+sCyM9gU
         a8gg==
X-Forwarded-Encrypted: i=1; AKwUvBzKSINTmdIg2ssCen6NXLey+jg0iaa8/V0pYutEuQ9pwmQpx4aoI8jeE+EP82jVjLsTRzluwfQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nf16J6AwzM8Ik324qdPdzdULipVNIDaQCqesE0tisvgL47jSLt
	Z2XjjPSHQLskWVHYO4enzhu8ww4XppYaYtGL3TaTUjLS1MulhmfvTtbun3E3bdUsNpE6y8TN+nR
	VD4UzN6Lu81H7HV2SMBrmSy5TacDClCOaXQHwzCAu
X-Gm-Gg: AYBFou2BVYIIY7M2x3Q3PqK3mpumxbqkPi+wlTlUb3cqt9pRz2EGHRm+9daN6f4tDo9
	25ljG2I8U8urVWRgjuKpIe7VfkyVoQ6p8nyvx+WHFZqTmEKqbZ2geRIekLF4tOHDh8y9nKuV2Vm
	MpdCZm03QE+6/vNwcdeh9qzzCqs+FYk9ECdDfedptiyYWwUm46/1W330Tsbtaw0zM0pX7OC51mf
	wgUf0nxsF9yn0yZA/b0l5uUnR5HDHOIASJ+DiqT7Q9TfHRkDss0db1wKgQuQD5DVyF/5oJXkoFi
	xh54Ia3J5lLWmkj+T+MDzQNafsUBLcsvmN+akWfpHl7yyEXAf7V5gu6iptrpDkTyvHWhGnKY/Bb
	rRAhJxVRzHXz7itw8Q3fCx5qs9jtPzbMGIcrk5ejM0f1k1TyO8pQIjPipzvLP47rbIKdVMLHxOx
	Jw6vifRACsdQbLJ2PDR2foUhR+
X-Received: by 2002:a05:6a21:6016:b0:3d3:ae0f:526c with SMTP id
 adf61e73a8af0-3da3a15cf74mr59737523637.24.1788972261832; Wed, 09 Sep 2026
 09:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908211419.882954-1-kuniyu@google.com> <20260908211419.882954-3-kuniyu@google.com>
 <20260909065116.GC1183641@shredder> <20260909065546.GA1205208@shredder>
In-Reply-To: <20260909065546.GA1205208@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 09:44:10 -0700
X-Gm-Features: AcwNN1UpwKIWGXx1FisIsHLo6zEbNqF_OWRnXdGXOmfbsCcx5bZfMebBSgO-IJQ
Message-ID: <CAAVpQUALW_LA=-M8_Eb2CYR16DNyrrSYQYM8zFASGwuJ8j=W3A@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/4] neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Yuwei Wang <wangyuweihx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 11:56=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Sep 09, 2026 at 09:51:16AM +0300, Ido Schimmel wrote:
> > On Tue, Sep 08, 2026 at 09:12:46PM +0000, Kuniyuki Iwashima wrote:
> > > diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentatio=
n/netlink/specs/rt-neigh.yaml
> > > index 0f46ef313590..5ec57d95d7f6 100644
> > > --- a/Documentation/netlink/specs/rt-neigh.yaml
> > > +++ b/Documentation/netlink/specs/rt-neigh.yaml
> > > @@ -341,6 +341,8 @@ attribute-sets:
> > >        -
> > >          name: interval-probe-time-ms
> > >          type: u64
> > > +        min: 1
> > > +        max: 86400000
> >
> > This differs from what I suggested [1] and fails validation:

Oh sorry, I completely overlooked "check:" !

> >
> > $ tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt-neig=
h.yaml \
> >       --schema Documentation/netlink/netlink-raw.yaml --validate

TIL : --validate

I was wondering how it could be used after seeing strace
showed recvmsg() with -ERANGE from kernel.

> > [...]
> > jsonschema.exceptions.ValidationError: Additional properties are not al=
lowed ('max', 'min' were unexpected)
> > [...]
> > On instance['attribute-sets'][2]['attributes'][18]:
> >     {'name': 'interval-probe-time-ms',
> >      'type': 'u64',
> >      'min': 1,
> >      'max': 86400000}
> >
> > Works fine with this diff [2]:
> >
> > $ tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt-neig=
h.yaml \
> >       --schema Documentation/netlink/netlink-raw.yaml --validate
> > $ echo $?
> > 0
>
> BTW, patch LGTM otherwise, so you can add my tag to v3. Thanks!

Will fix "check:" in v3 and add your tag.

Thank you !
