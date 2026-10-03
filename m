Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F083D7D77
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791023204; cv=pass; b=ngoleHGG72pRwf3hxo4m8xIejmyildlM7GYmOoHKD94N09DtT4+kpWEkJKU3wLuaTAvOdmdaQyPMx6wEfhh9c7bu/Bt/BwibeAmbI8KbjAKP5AORF5eCHjGOVg5ZZ7rkto6JkvEPfCO+aayMi9sPa51/PSG0o3Ph/0oyEh3UEnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791023204; c=relaxed/simple;
	bh=OOyOVSI2lmpusRoc4ACoD6a8Vw8ZngqDW83JAjtyzPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ci8+LVnIh4b3M9ABK0k0d4vwExBromXw6rlErQFB4Fw+9mLL9yQYuSf4It1bzxycAKq/k0mg3Gfwg/HF+b8ctkREUENRrvjfoKqOEHfttlL+vf9UR6H2YIbqJ0U/J5DQtPayDs0AhxLYQwMJb1lGlmyagJhAnk2I3Xodst6eBnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8EYSGup; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8EYSGup"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a6124046f0so5769891fa.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 03:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791023199; cv=none;
        d=google.com; s=arc-20260327;
        b=eWsePhzcW3l2XQUNvGYQHn9gvVcZljlobrJzPUQryhbdUmZFWxGEGsyQtGgzMeaxSw
         4NHAtSkZ6Ri/c7Rv71gLFeLoupr4kBh6BeVJdMKdxJYEW+YZfVDhBvC3XMv54Gft4dJ0
         WQZNaIm39I4AZskPGYsk3HKRajFLQ/wjS5q6i4CO5HqmFe+XNPvokM8kXmPConsrlrd9
         7tLuR3pQi8u6S8M28kJMnPbDQoPbEFQT8n+b+IHDIqyUMQDYUYB6HfyqQWE+dM8XXbmN
         H4WlU7LS4x3AL6jI+I4TavEofrrrPiYQF3XvVSUWjZsIgLnWSXhR6pMOLMp2zKOxzGGb
         92nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gY868+4M+lbCixZez/Vxoe6E/ppXobjrz7C3ozhopI0=;
        fh=k3UlWcfOzAVgpMpV0+PEGMH+GbsGR+tjwSDZu4eC2C4=;
        b=m/apuY0wRWmlxc5a2GKxhSYMe89rKy9hWEBY9HocK8Cjk86gIodoTk9ocMfWK7N7FR
         rrDa2rwV85GqZzpNFOcHHwfwr8BtrVAlqzwZksT4b5Yx+Bx1KLbn0+isXJhnnnrRZjqL
         nVpSmSh5Jk8SSwJuVBuTUsM0SaB7U/CJ6+iuL2F27Zi+CqlVpzmoekJn4JdIsPIOueAK
         IaggUmkTlm2hxw3ACphW8trF30Fou8o5nDPXQ85pR0WqU9BnEOEaJw7CWIbu0oRARqCE
         W3sMxM8eQlP0I0RttLaO1U0T06uS4Jn0qzjtp6H8/A206nWf7IIER5DZETtZ9d48AJSa
         SLxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791023199; x=1791627999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gY868+4M+lbCixZez/Vxoe6E/ppXobjrz7C3ozhopI0=;
        b=n8EYSGupnUJrubtwo912l+4O9K4cwFcsfOItuuaVztbU8CCiAFV4pKJbHXZ9P5nX3O
         xcyYo661ucKyCbQfFSNQFDdmHz7cTuA1qRXR8RWnsjc1lXKR/2ZjgcHqh4QpCMq+mpGg
         eX8H3ALKKdhokhc3mw3t1YSFHhOtXW8EN2KFO19czYfiEslDowRWBDHhwiJmTfoPJ4G5
         6fBbwgyBFIsZGhtfamC8PNOIJXBup4pOImUf3DW5Svdksbvdg/YqFzPmr49szF+DMPLP
         h5ngGpLYGaDaxE5wd4PiS6W+2jAFT5yYpFfprToKAGjMcJdQPV7y86gUSDwn+66alyIY
         lZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791023199; x=1791627999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gY868+4M+lbCixZez/Vxoe6E/ppXobjrz7C3ozhopI0=;
        b=iMeERC2//oF2t6nNoGpoHBrIe3PHYCBxvOsqUUFZ+JecBfkvWjwYcnRVB4I4ngWG9m
         uLcVz7qod5dnkDhfoG3vxzyukguLs7KjEf80OhIxfo65oXVRvJ7/53Hks/HwQ+GBKQvR
         ZU+e3dYUDSwqI0IhZywpN+kWdJhDHlUlm2L9tpuIsuuDh4JeeP7gfXJ8K2XCRL9IZhPQ
         sRlekT3FtrjWxXbegIsEQ3tjbnvX1XSE6tMusF7nHf2ZskbAjRNri3D0nrQ6+TkUwP/a
         aHnWcfndAqIGTeTd7InQqGfVq0uRfr+xpE6xUJIPC9xb6vNZg7q+TL6Y4IaasDvnwl4l
         zKQg==
X-Forwarded-Encrypted: i=1; AKwUvBwQHmYzC7pYRSolyS423Bf91OChDbU4j/uHeiMxvk/fBHf2vCihA7H4z4mwUzrRaV152HMEPYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJptmT+n7nwXzKXkSrOeucylLBJarvVNgJI5yo4nAllSKIaUD9M
	xJIhBZgF8sxcn/tMhJxSp+/98EMVb+NPEzRiRHkbxatgkMdxmSsSBZM1RtTMKWN+gVx5t+l3Rpn
	fpcx5YA0olnbJ027bdMG4eYDO2Rm6GSpN+eks
X-Gm-Gg: AYBFou33dOdiUnvEHWRabNws9QPkdIHfAysC6rRvcQpR06We8kB6ONlp28QT63B8O8V
	v02G/GL+meBVLfYfl+ZT7Ej6lc+0ip/+KDB8rB+Pel6oYtM+gppZTQRRhI/BaJvVs5LAj1+x6Tq
	VejMYQS3g2NJtpWL5KW5Ube/ynTjPFnEUpuIoJi2fQIKzg1q/C+AQvrpJOPqUfSo7/Y+S1iWyUJ
	PI7oC07lsIa6jfTVyh6HxKpldusgEGA1p6P6/hSIcdN+KXC5rCOg/HzssZKfp0IaOxnppxDmeOp
	uFVz3KwtBXhS9pPe/npC0gQpDmSnaNEmCPnW7uJjFzc+O+ZHROtSwrTz
X-Received: by 2002:a05:651c:2121:b0:3a8:7b84:be9b with SMTP id
 38308e7fff4ca-3a8877b73a8mr14050001fa.5.1791023198622; Sat, 03 Oct 2026
 03:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002134002.3529706-1-anilkaushikwireless@gmail.com> <asCZbsGo90ROQIS6@nataraja>
In-Reply-To: <asCZbsGo90ROQIS6@nataraja>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Sat, 3 Oct 2026 15:56:26 +0530
X-Gm-Features: AclHuK8WVRfk01Lj4d_M_ZGlNvs22AY2y5eNniQyIhAFU9irojUfOuqgrxKAe24
Message-ID: <CAG0Mgm-DQVSDpdBZiJp=asPU__zZJ+iDm-H+oD7htaTbzYdahw@mail.gmail.com>
Subject: Re: [RFC] gtp: add 5G PDU Session Container (QFI) support?
To: Harald Welte <laforge@gnumonks.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald,

Thanks for the quick, clear feedback =E2=80=94 and for the skb->mark steer.

On the use case: honestly, I don't have one that would drive this in
mainline. My own 5G user plane is Magma, which does GTP-U in OVS
(OpenFlow) =E2=80=94 not via the kernel GTP driver / libgtpnl =E2=80=94 so =
it wouldn't
be a consumer of a GTPA_QFI attribute. So at this moment it will
remain futuristic and for completeness.

Separately, I sent a small patch that stands on its own, independent of
QFI =E2=80=94 a ynl (genetlink-legacy) spec for the existing gtp family:

  [RFC net-next] netlink: specs: add genetlink-legacy spec for GTP
  (netdev, 2026-10-01)

It just describes the current NEWPDP/DELPDP/GETPDP/ECHOREQ family so it
can be used with the ynl tooling/docs =E2=80=94 no datapath or uapi change.=
 If
that's useful I'm happy to respin it as a proper [PATCH net-next];
feedback welcome.

No rush at all =E2=80=94 enjoy the ride, and safe travels.

Thanks again,
Anil


On Sat, Oct 3, 2026 at 11:28=E2=80=AFAM Harald Welte <laforge@gnumonks.org>=
 wrote:
>
> Hi Anil,
>
> On Fri, Oct 02, 2026 at 01:40:02PM +0000, Anil Kaushik wrote:
> > 1) Is this something you'd welcome in mainline gtp.c?  I'm aware a lot =
of
> >    5G user-plane work lives in out-of-tree datapaths (gtp5g, the eBPF
> >    eUPF), so I don't want to add datapath complexity you'd rather not
> >    carry here.
>
> I think the big question is about the use case.  Do you yourself have a u=
se case
> for this? Which userspace programs (ideally open source ones) will be usi=
ng your
> proposed mechanism? For the existing GTPv0/v1 code we have a couple of di=
fferent
> FOSS applications (osmo-ggsn and ergw) as well as know of a number of pro=
prietary
> applications using it.
>
> So I'm wondering if this proposed enhancement is "just for the sake of co=
mpleteness",
> or if you have any application (or will contribute patches to existing ap=
plications) so
> they will make use of this feature.
>
> > 2) If yes: on RX, once the QFI has been parsed out of the PSC, what wou=
ld
> >    you like the driver to do with it?  The options I see are:
> >      - stash it in skb->mark, so tc/nftables can classify uplink traffi=
c
> >        by QoS flow;
> >      - attach it as skb metadata (tc_skb_ext / metadata_dst); or
> >      - just validate it and otherwise ignore it.
> >    The shape of the RX patch depends on this, so I'd rather ask than
> >    guess.
>
> I would say skb->mark would make sense to me.
>
> Regards,
>         Harald
>
> p.s.: Answers might be slow, I'm just about to go on a motorbike tour in =
remote
> mountainous areas with limited connectivity and/or time for e-mails
>
> --
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.o=
rg/
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. =
A6)
