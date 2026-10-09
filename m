Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D044E36D2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554744; cv=pass; b=mhiSVri7dxLoQtQrKLLeaP12r0AFXY3PDWe8ODieNTcvU7Wy2ZK8gfwxDX/Gvh3667kG9AP54aLoCiKD5IFdlbbp72RatlT7PS/rMZHOVazcNcawHQ6bd25M9ZOHPiJXsSkzPNzzXs4BGwNL3Bd7cUMj6MOg9jCyfbIMzfo6Zgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554744; c=relaxed/simple;
	bh=g0eC2vaOEHw115QB3uMDWE8jYWwdFfWrEyilLWxNSGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GayJPd48/dGVZsGqPwOhmyy+hG/ns8THJV/zLMlyM2Jjps1qi3sDvhWbmpkI2qAHzD9gbhW8l47QiWha8JnIxpNzXdaNnt9rW74EEiJ0/Dievv6erX5yJB9WODcoSJXGJrwej7eeGmGnK5kRDFxuMCZmkfG6x54olTfPPYGksSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHsdiIj3; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHsdiIj3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8897e83332fso879541b3a.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554740; cv=none;
        d=google.com; s=arc-20260327;
        b=SEwYZ+KOrf+b1gFp99PoRkFk2IzB0dsECusvpFcv1cWpCayPbf81OVdim2Yl7iqAje
         X4CyERDLiAJw4pOYDl3FBXPLqsUO3WAGFbe2GYxj3ePVTl39L/j/BSRyzRV7UWyFjHMF
         FBgomJ56sMHux9f0sMPcNwBTB9MiXezmvspD0WcfWlQgn3/JHRH+njPPf87UjzOXdyO+
         UxURicXMQXxWUDk5x3YNCeyI+yac1WfyINyQeJyErTjR/8DSjgO0Ze8hV4oEVyY6uvGz
         BDGnZtya5sIm27rDC/53X8Bq8+FtmFQ20WlEI7GCjhXu1ieS+jSipL3RKSWDespvY0MD
         Tiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8HEugKgmPQjEw7nxK5HzNHe/6wrYnXYBTHzBEDvBLc=;
        fh=ElF0j8MYcUvMvGrv/ZQyUw6P9UDNqbFpKzPOTPV0XKk=;
        b=YOhSbPX3j9ZxScKmMy1VzW5UZJcHoXwDOLCdLHhziin9pxgpdoN9Qu5d/ObQehh7bR
         B5RPFGZusqtuOUxH5lsOzVBhel2l6z6IdpNY4Lep1tN6H3K8iRT/D9CV6od6ul390DUD
         PafzBh4iPFYXnuMz9PZcfUE464gLoA54cuoKOKyqeTN3l+2Y4IFlrMfViG6JFpH4apko
         ZZvwSsBH4n1IyZkBeVt3ReFesJ8YeDVKQqE4YTYOMSkzo3dk//L2HTi6k0qgZfp1Cs/C
         ADtOAGoJquayoHytKN8SPky01asXIiPxNgnPlrOn9ygsxxkl/e0hf4Dp457an1HUS7Tm
         iAiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554740; x=1792159540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M8HEugKgmPQjEw7nxK5HzNHe/6wrYnXYBTHzBEDvBLc=;
        b=AHsdiIj3cn9c6l4aaMwTVs4dVM6bcpqKOJFvFTTe5/16dh5OSv97U8kbrLkdp/I3mf
         wO587C16C1mbNYplObDoL8BF1d3jBBgWe73vNFrYb0f0d982siTQ3SVDzdKWMx7xvl0g
         l2elm/HaKDYcdaR9qPUQVauduQvL6oYykQB5jcjeyvbsd2x3PHwgYsFKv4XbQLVm8VkG
         yfbIqrEutXZ4Di5ka5KxKIhWZFjxnhReVX2PCMN9U7/qx8CqvgbR3qopM1a6oBQxUuV6
         AjNRxknNH573L8KG64p0PkwgjpmsIG0qHEQWY0ZccxVSnqp80jGFGh8eFnKxdr3IgRps
         kGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554740; x=1792159540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8HEugKgmPQjEw7nxK5HzNHe/6wrYnXYBTHzBEDvBLc=;
        b=VkI+P5dBi+iscUM/rdrXryd4eoBVxD+9zQD+0ryiTeKWbRfga4RXBcExgaFonNNwxh
         +1Z1vdNu6QlEcTqNEetPzFuMMkNYa4W1guEOalr6ZNlF2EO1md1qZ4LtO9Ugx8Z4XtRA
         +DG+D1f9hosyva38Rs5INi0oYEKZCHNKt4ki0ow9m5+AAIg10XsUj+z6KPjED0skVgZ3
         A/9JmiOBsobzsGkSvTrA4uazR8cgNaEZ3ccHTQBSfxKHr70F7fGvLTrdMLjlZmT7A5md
         7hsGxrOaL5y/tipWQZO5kj8taa82ggAYvVN0O8qcINxK7qyho3Eyl9xkpI0M6HJQMz6i
         4pzw==
X-Forwarded-Encrypted: i=1; AKwUvBwUJCrDtSsWtOY9j851pMHd67l1Ytfd7qqQ1iHP8liPQyZV+AIXGjlbTrQGFIE8q156LYIoFvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSAmF+ZDwGkaz71xZ4/opZj6wilMGkZQvOVLDJlrOwJvqfPnKT
	/DMWjn/lyUYqOqGLGcGvJo1Wn2LHc2Hpmfw8rwughqa4dLdxlcbKtLlnr8W8SlRK4jhafxDPQ6N
	sy1r6lRlZFz3xLZrVnjdf0DicWv3OPiXq861MXAE=
X-Gm-Gg: AYBFou3oKxxyOkyYCdAEgDihT6xSjX9eT6XSTvJb6c6LjbfZ8ezd/z2JXiuiSNMmMQ1
	0p9o45Wa8hB2xARY2m44wGIFD9usVz+jGhlvgokwOBsluKn1ZVMktaImrIY+2c8oeVKY7AdAOPR
	PfdbRRpKzWVi8HmnZcetAb9n+jlZLfsJZDWA47iXMQqZUWvXJGW5uC47C/voMoM+hpGqRlrMYCR
	su07G/ik4cTGWSMQuevSg3Axp+h8bm5Gw+vB7dvkQJRKlwMeOmV6QDMyuI2p+eqZBQ9p0CNB4LD
	L7WOC8Fpa5Rd//hgfcxVNIIc+Sr9dEIWrXfADiYsTQ332cK0sWhu/w==
X-Received: by 2002:a05:6a00:2da4:b0:891:7c71:de8 with SMTP id
 d2e1a72fcca58-896a4bbf46amr1808697b3a.46.1791554739638; Fri, 09 Oct 2026
 07:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008133252.3750-1-nashuiliang@gmail.com> <CADVnQy==0Vor90buiY8U+DNYKjxyWRQ94zAq9=aKhyAezsB9Vw@mail.gmail.com>
In-Reply-To: <CADVnQy==0Vor90buiY8U+DNYKjxyWRQ94zAq9=aKhyAezsB9Vw@mail.gmail.com>
From: chuang <nashuiliang@gmail.com>
Date: Fri, 9 Oct 2026 22:05:26 +0800
X-Gm-Features: AclHuK8p1oAeDJ7ugEFlpvHfyJ-pHlTg_f0wedjvM2AkCjxB0FHx6nsfLO2wzEM
Message-ID: <CACueBy4VT9WzCnseKEnYUA9U2YGZBxY-CLxrZpRnXWHcUdMZwA@mail.gmail.com>
Subject: Re: [PATCH net-next v10] net: reduce ARFS flow updates by checking
 LLC affinity
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 10:14=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Thu, Oct 8, 2026 at 9:33=E2=80=AFAM Chuang Wang <nashuiliang@gmail.com=
> wrote:
> >
> ...
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] =3D {
> >                 .mode           =3D 0644,
> >                 .proc_handler   =3D rps_sock_flow_sysctl
> >         },
> > +       {
> > +               .procname       =3D "rps_feat_llc_affinity",
> > +               .data           =3D &rps_feat_llc_affinity.key,
> > +               .maxlen         =3D sizeof(rps_feat_llc_affinity.key),
> > +               .mode           =3D 0644,
> > +               .proc_handler   =3D proc_do_static_key
> > +       },
>
> Having "feat_" in the name of a sysctl seems redundant, since most
> sysctls are features.
>
> Also, the name seems overly broad, as it could also apply to other
> RPS/RFS mechanisms leveraging LLC affinity, for which we might want
> separate sysctl control knobs. I'd suggest perhaps something more
> specific, like "rps_llc_affinity_for_set_cpu".

How about arfs_llc_affinity or rfs_accel_llc_affinity or
rfs_accel_llc_affinity_steer?

The knob only gates the aRFS (CONFIG_RFS_ACCEL) hardware steering
update in set_rps_cpu(), so scoping the name to aRFS describes exactly
what it controls.

>
> neal
