Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D789364049
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198950; cv=pass; b=kJfmJSWoq146ny1xdnp4lJhNSJjEv01EkK6Rr1yItHtRCuvrMA5M+kYsQChWLbQ9Szjx4PF6zOPObFV9wPQNiQ599n964Agzfh3spwAB/h4pwzcb/JJZis3xWVLUQLwZHKv5j4qRrP9JI8kXbybcRLChEYjiv7nOD3m8QFBqq9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198950; c=relaxed/simple;
	bh=WRqQjY0nqBY7Sg3i9roQRCJWKcirMX5AO+S0jXiSkBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2c137JIqYbDEIyEK/x9nO0ptUNoBpP7FqaqLcCajdzvEMiO8YvCAqMQCY/+H1RgFqpvV5hM4hKion0jhFvu2p7wbslkor35VjGS2GEZgXiQ/yAGIj23sJc55PojMbKlNZd9fhmnpwK/YDFQL93QZN9Tweuh5e+7abNNuVS/g4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=K2ha96Vg; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="K2ha96Vg"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so731559b3a.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789198948; cv=none;
        d=google.com; s=arc-20260327;
        b=PpfKo8mI2SY9Sn1RKqMiPnh9qNqbcCGJ1MkFQYZ2VlYJtlxbedFFoqSfmdvENxDZx+
         CSMCBPNjqvWn/VJoXbCbCrdID7+RYXLhBQ6s+/Y0En/OH8/RZigxAjdBp9752HP8A0TB
         pZlyZZxpCldBrBi/+yUfVp0i2qWj6scr4T0fN0gRQZFOR0iskHZ1zkURqpbbpjphtibA
         fz/Z7SrJAkS/a1Y4rArgVFZJb3nxxu9WjoicG52aI2WQebaU0Nm+e7lJOvQm2nZ5KEJD
         SkaUVXSd+RmZ/YxugKKao4Hxm37c8XSz39CH/fn5OkVf6iiTHIzp/b34BYchu1tS5ZpA
         agKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3tJuKuoSzWQ5ciLlrNmqFia+HpadVqWjy0A5pW8ADTg=;
        fh=hQCOL9rmwFBrW7Gm18PWl26jt1iTkvMePjZQjUWRtRQ=;
        b=RxOeCyLv+Mb3JCCKIZTmKH+ZYYtU524NYOKLNw/ADEKmpmXJ6zH/sscOy3LW0k71K+
         +EdMceExMQpGTD/a4mlg+o9huK2+ytUA9Ll2lVJ60qdM5mmE5lnLkOmMavoUqF3uA6O2
         YT6nbcfFpU8WJR70E33Lr08BsjLKwSpFeaZ+wx/t2Hsc+n8u9yX7Hha4G1Hlr6wnUxMD
         PJhEUYeXe4GKHkcBUm2dAdAe002Gvik5RmwCqqNDcZbOJBhTJTta75zzO/FurCecI4iw
         MJDs16+vEJj9OIFPkqwe0S582/HHCC2VnGjBzm8U8J14vOQOPi00VoB+MuuQzQlzECKC
         D8sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789198948; x=1789803748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3tJuKuoSzWQ5ciLlrNmqFia+HpadVqWjy0A5pW8ADTg=;
        b=K2ha96VgLBfj7USJ7QqRxz23DB91IQe7GzVSUzMTPVJ6B+Jj5kwmDCDk8EvJ8E/RWp
         EOBGd2Ql4GqP8upRk3W6RU79rjJsG5ZR8GFo8Aep8ZuebNMuYlVzEh7Ml1ZGoVL5Ran9
         TE7+H2o1gEFTlwpF3sQyvIxlWSolPfHdihJ5SfYKiFl/I4Z99W5LVDf5NaYsGEZIAL4J
         QZZV2s4SAV4VQqVk0NidAF7ELdZyc/v5VHCHERf7VDm96gv/LOrqqx+Q/v5q8PlZC7Nv
         F7OKsSVimmPYvcnpczF8Fbi8fehChZgiQUcCk1kS7eZOATARbNjM+PE6i2Hl7axckKf0
         LP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789198948; x=1789803748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tJuKuoSzWQ5ciLlrNmqFia+HpadVqWjy0A5pW8ADTg=;
        b=ix2NyvRk3effwSMJ739L9tZHxl9wVPwyTLuTcg2LKgCkt2wDnLR03A/yy4OqK86ffi
         klDTQP+S/y8crAoeDD9ZQdtnHUO6E1bO3+oiAggpuVTT6qrLubdeY9J+XP0Qitrt2TBn
         +Gc7EZYkFAW4ILhcsFcdcM4g+GQlnkj+RtdYklqxHyHjAP7wwTk3EcXNzrGAEfUrlPlM
         w2r/YKA0EqBfOtKZOC1z56i5MXWoPNtmfQpvNruVs5UEgjoQ3UqMwhA3aX3+3T5jGDm0
         ngLEjO6HB0llPVyHXhDRIwJo7zeivtjk8CDBEl78Cidkg4c4KkHJZkdUp2zXi1fJrDzh
         5MUg==
X-Forwarded-Encrypted: i=1; AKwUvByud7qGvc8rs2CYUfyAlsjb5NmjYvimhANkA6GLsf1c5MuJNDKrcoBMKMX4f+BSWcIdbk7pzMI=@vger.kernel.org
X-Gm-Message-State: AFuF++kQONhK4z4ZbRC1fiy31DKsexHyPxidokDEV5wUTljxFeEG2d8d
	fGv06J4AfOGWnuwSCMTlXnnIPXfPrdNPujXwtnUn6OSAEBfvIhOk2fJ6QHuC9TQIucDIsIudjQx
	mxRY3rTkY0ACyL+97f72yblGzVn0Gtc60VJcg5dP2gOJGcHqlnddZ0FQ1aVqxmg==
X-Gm-Gg: AYBFou37Jv7iz58M4AbyOH1CpO7cwxJ2KdrPUJXnPkrGaY+od6Z4SpZTzjZpv2KnhID
	b5LZ+oS34LdGOBRbkeuKrJ5Itl0DEQ5sOMEccNXRlh+pDxCCJRpuD7fHw/o7iA/HTZeuxc9b8A4
	8I78sHcfC3aKB1CKZXs27KNw1+j5au9rjfR1HxYEf5UYZqYLYVr9NI4H20ttMFtt5Gh4NeCvsMV
	TN6mq1ISabLLngf2H9GpoufPO6p73oQ5oNhizi3FEe+1sZUaw61nHh0IFBXlOHpoEpTAs930eM1
	f80wEv+tEqD/iL7JBm1nogqWEPZn3IpdcefiZ1RBh9u+Btk4CF7SRyPUX+4YkK0/eDvTQDa3m2m
	USmwEbuIRLYwQyKKb8cfLlXrbK8bmXy5/k/jj/W/uT+OPzr4itSTzj+rmZsTJxGRLv53Z9GYAON
	E=
X-Received: by 2002:a05:6a21:6f88:b0:3d8:f78a:9349 with SMTP id
 adf61e73a8af0-3daed2e2f72mr16961102637.13.1789198947035; Sat, 12 Sep 2026
 00:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCj+Pd5owGH+51rA8-RDu9YFx5oYUv8bV0zOE72QgVfY0A@mail.gmail.com>
 <aqQOj8EHUb6ZzWjR@chamomile>
In-Reply-To: <aqQOj8EHUb6ZzWjR@chamomile>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Sat, 12 Sep 2026 00:42:16 -0700
X-Gm-Features: AcwNN1XLN5elLlT8PdL_Nzk9pxZ6_ooMYs8Rf-40WoQTVCImUG3ej9Qw_PbxJGY
Message-ID: <CA+0ovCg74Rj-rvV1kcLDj4nftRaX356-g4oc02kQSk3O7b_Mog@mail.gmail.com>
Subject: Re: [PATCH net] net: reject a forward path that loops back to the tunnel
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Xuanqiang and Pablo, many thanks for the helpful hints. I=E2=80=99ve sent o=
ut
a v2 addressing the comments above. Please let me know if any further
modifications are needed. Thanks!

On Fri, Sep 11, 2026 at 7:22=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> Hi,
>
> On Fri, Sep 11, 2026 at 12:17:08AM +0000, Farhad Alemi wrote:
> > ipip_fill_forward_path() and ip6_tnl_fill_forward_path() assign the out=
er
> > route's device to ctx->dev without checking that it differs from the tu=
nnel
> > device itself.  When a tunnel's outer route resolves back to that same
> > tunnel, the walk in dev_fill_forward_path() makes no progress and trips=
 its
> > loop check WARN_ON_ONCE(last_dev =3D=3D ctx->dev). Release the route an=
d
> > return -EOPNOTSUPP when the resolved dst device equals ctx->dev, so the
> > path walk either advances to a different device or fails cleanly.
>
> I think we can remove this WARN_ON_ONCE() from dev_fill_forward_path(), i=
e.
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ecfbd72d5d1a..c67900354fa6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -789,7 +789,7 @@ int dev_fill_forward_path(struct net_device_path_ctx =
*ctx,
>                         goto err_out;
>
>                 stack->num_paths++;
> -               if (WARN_ON_ONCE(last_dev =3D=3D ctx->dev))
> +               if (last_dev =3D=3D ctx->dev)
>                         goto err_out;
>         }
>
> > Closes: https://lore.kernel.org/all/CA+0ovCgaRvbd0Udj70b2xxG8Cx3CaCpNhn=
f1V4RWQuDveZYZhA@mail.gmail.com/
> > Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > ---
> > --- a/net/ipv4/ipip.c
> > +++ b/net/ipv4/ipip.c
> > @@ -375,6 +375,12 @@ static int ipip_fill_forward_path(struct
> > net_device_path_ctx *ctx,
> >       if (IS_ERR(rt))
> >               return PTR_ERR(rt);
> >
> > +     /* The path walk must advance: a route back into the tunnel is a =
loop. */
> > +     if (rt->dst.dev =3D=3D ctx->dev) {
> > +             ip_rt_put(rt);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       path->type =3D DEV_PATH_TUN;
> >       path->tun.src_v4.s_addr =3D tiph->saddr;
> >       path->tun.dst_v4.s_addr =3D tiph->daddr;
> > --- a/net/ipv6/ip6_tunnel.c
> > +++ b/net/ipv6/ip6_tunnel.c
> > @@ -1863,7 +1863,12 @@ static int ip6_tnl_fill_forward_path(struct
> > net_device_path_ctx *ctx,
> >       fl6.flowi6_proto =3D 0;
> >
> >       dst =3D ip6_route_output(dev_net(ctx->dev), NULL, &fl6);
> > -     if (!dst->error) {
> > +     err =3D dst->error;
> > +     /* The path walk must advance: a route back into the tunnel is a =
loop. */
> > +     if (!err && dst->dev =3D=3D ctx->dev)
> > +             err =3D -EOPNOTSUPP;
> > +
> > +     if (!err) {
> >               path->type =3D DEV_PATH_TUN;
> >               path->tun.src_v6 =3D fl6.saddr;
> >               path->tun.dst_v6 =3D fl6.daddr;
> > @@ -1873,7 +1878,6 @@ static int ip6_tnl_fill_forward_path(struct
> > net_device_path_ctx *ctx,
> >               ctx->dev =3D dst->dev;
> >       }
> >
> > -     err =3D dst->error;
> >       if (err)
> >               dst_release(dst);
