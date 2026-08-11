Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEA37DAAA
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473403; cv=pass; b=DOCo2kfp8n9Q2g6ozYBTJP1fwD4GHm51dcip/2G1OL8Z5pzeoQUE5X0jP/ktmp52R7KxshjsJAEq3Vkah3prcGa1fc5M6AnciJrkooWha13cUQj35EkcTHTwOxBKUrnVPewLtamr0xuoLW9zV67NYiPLh+hubCJ/I4HTvIUNTvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473403; c=relaxed/simple;
	bh=Ga3x7QU48MG6npSgZuy2UL0tPHEdVGKIbegpu/NQkmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoELUwGqUEvFX4Dw8BqOTllswDmWG4KGxY7kWOmMnfechKRmgUrzVdyF5dX0WEZh87nvpBW4g+SwgTBe3VJaDsfBGJoTTSY3f8nPjtwcF2f6c5Bb/kD6aIYiJVk/56VkrplNPw24hOAJPCAE1FPETyYdP5KV2elPISXr78R9oOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw72E2pe; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw72E2pe"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66b2dbef6afso326229d50.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786473401; cv=none;
        d=google.com; s=arc-20260327;
        b=HwoAAoL11aLV2UBiPkDbm9xHBNUZjdyEdox/q88siYGHeO3YUuDnM3TwD59nuFhtdJ
         ujz15ZxhONVlPXeprg19ch8UpCGZ/0iWIbNQ7Uz+gx6hi84jlvIpiVXT/qYzIQH6oXGX
         BdQc1sBImgNffv/ZikHhMadVuy5xVEySjqAxw1tW2aHh/5C9SknsN21fXEhsuQJmaGHh
         Y39UE04cHrN9PTf3A+7nSAO5kLqsREia8BNphFpZvAAiiZ9/nTTwe7reDv4GxSrYqFZO
         3sNhRV3lRUfgdicPEL84D6kxLBMBX5TTH6D2w0lhDx0cAov7P3Ntx4XmSjkzKqsrULi0
         hsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCNeSdua54llRcFvuGJVdgECZ7CCGafyUkX6QFDUHm4=;
        fh=aZ9z+NuKYGW/njwBX9/AxVwhkSfo1SA7FBqhDETgiEQ=;
        b=St9eDZJPLM4+w8sW7a5JoNJwM+2bhmqDf0SP1x6Svcr769zgy1DCeVZyrN4+TAIe8q
         6STBrygxZ22Hwe3QtjfGNucc0snVvhMWuaPt/S7i1C3HEgU+NswUIPl2M4/eSZQZVUel
         hlV0OcmPWy9O15I9SJqShC0W3AAS+vhzSHXVThIgabWTjlrknCjI0ikluuIrLpk46TF0
         Wk6da6furMup699I3iAi6nxU6JCxtyrFMypBsjO08OEkTvEzCvzO1aNL3tE9CMKwtBJC
         UUsTlYQikUIEi65cTZfr9dNxd6XFw90UQl0vJafo0DZkOhlu6fsZ23AOaJ/efNxiWBvi
         9IlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786473401; x=1787078201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tCNeSdua54llRcFvuGJVdgECZ7CCGafyUkX6QFDUHm4=;
        b=Rw72E2pe/q3j9E6TWxmA+x6PEaM0NDsvr8azrENiS6O7O048tJnHQRkfDqVbXeWSHF
         c8rTwjNvJ4FuYH+PxLIMjPXerAsXeQiO/7CvH/5iKWXSqcCwmPFCTkhV9dpCgjzunkTv
         TTSCNxp15501Lv4nUZEtwvCugvPCQBDO8RDaFjudyiTgqNzdCvjG6hbaa2HOAaH1IRAE
         obq0SYFaJ9QDB4fiioHpDGt1Urwp1JAecO5Nz1BaVrvA6JROG4PfFWQKTP3y8PELPsz3
         0IPw46TtwlL24iHWqdo7+EgD6Ug41u/YoAkduuIDQAW9Qm7CTTbJKse2AEXTipwHsqRk
         pbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473401; x=1787078201;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCNeSdua54llRcFvuGJVdgECZ7CCGafyUkX6QFDUHm4=;
        b=kPOJUrwN0+bYWKIQbP+08CVK4sx9+QJ122aE4UBzeuaObVYmsPqtNCgKP7wJEfU+GV
         +bBCh4qJRqoeiDg/t9mJ7mwtUCxTVnifyfnB8FcEVyrev7E5nIvXxZ/CuWFoV4wMJ2qh
         H7rKF2H3tvi2a4BD+LbmIIqNLRJ5zAn1Y5DOlf3QyBUJweWjgn2Qs+uNpWF8Vmu/mOWA
         HHN/TuhmGuNgW7G5tRvJQd1IRDmMJUjp45c2eREq11prxIUSUO53GOWfbNK9EavnOIFM
         kU8hp1fLp+VRLAS+P8ylRxGT7GGpJEahDgA6qi6d7j0PEshIy9JIZNtRjMDgM5aUsQI7
         KpvQ==
X-Gm-Message-State: AOJu0YxYhs9SeOqTMMUm42voL7I83/9qcKGq02Nnwyj0KzJ1A8rr6KlO
	G4Px7TC6LPpN0OriRfOJ5KssJv7AKJonXuuwkUG+qEIdHYPpo3+LTzmJSMW09EXzXrX8piEKjgN
	7v4/wnYSR79F01AA1CHx8W7QIRCBkMc8=
X-Gm-Gg: AR+sD10B6gNaTcRcgpI0WeGMjNqhi06RIUtnnNIPFTeWIJXH56r5ka3+I/HGH6UB7Rw
	oR2RuQw2FaFGy/e03igRRIFiH0VtzmAuyoDzni/0Oq/0qVj2v9zXnwjMyhp1tRrYAfFiaxBvi4K
	03sE2NEXImV218szxnIrI4jXRAV+rZiRQzR3RWf1151nGOwqxq06GCkb5pNVBnRBpnDFsh26MaT
	1GzeRKL0eD7fZAKHuZ9ceYmRtRWCIukmzRw72fR8+HcZyqqWn9GoFCy/eeRlVtPNXG+nHAg8DUW
	XG4+Lp3r4wMBoAtWcyyRQNaoyV0XqUQZKrvcgLwXDgLeMg1gRrVdkHsCmNbhZc0XsWbDOt2G7/0
	=
X-Received: by 2002:a53:e690:0:b0:668:9230:e268 with SMTP id
 956f58d0204a3-66b22ea39f3mr2598402d50.47.1786473400764; Tue, 11 Aug 2026
 11:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com>
 <20260810183118.32d5c06a@kernel.org> <CAF=yD-JsW3moq_xw+ZM5c8hxg77btODoBujMpNut3Nr04PYt4A@mail.gmail.com>
 <20260811082723.43a9af08@kernel.org>
In-Reply-To: <20260811082723.43a9af08@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 11 Aug 2026 14:36:02 -0400
X-Gm-Features: AUfX_mywdFntMkejyvZGY6wm8J1ms_WvvbdGuKJPk2EjpGYRxz0lElGJT1d09Zs
Message-ID: <CAF=yD-+DG1YMtgDh=9qTyLFdM5GwLFSp3f-WprtdtDAFn4Ac8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: drv-net: so_txtime: only send test
 traffic to sch_etf
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 11 Aug 2026 10:29:12 -0400 Willem de Bruijn wrote:
> > I can reproduce after
> >
> > tc qdisc replace dev eth0 root handle pfifo_fast
> > tc qdisc replace dev eth0 root handle 1: pfifo_fast
> >
> > It is not possible to replace tc qdisc replace with a del + add pair,
> > due to "Error: Cannot delete qdisc with handle of zero." on systems
> > with the default 0: qdisc, like my debian trixie.
> >
> > The simplest change, then, is to replace the qdisc twice, first for
> > the kind, then for the handle.
> >
> > @@ -45,17 +45,18 @@ def _qdisc_setup(ifname, qdisc, optargs=3D""):
> >      """
> >      orig =3D tc(f"qdisc show dev {ifname} root", json=3DTrue)[0].get("=
kind", None)
> >      defer(tc, f"qdisc replace dev {ifname} root {orig}")
> > +    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
> >      tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")
> >
> > It's an extra replace, so a bit ugly. But avoiding that requires
> > parsing the json for existing handle, branching on that.
> >
> > I'm testing the above some more, will send that if no concerns.
>
> If we are adding an extra command adding del would seem more intuitive?
> But no preference.

Agreed. It's a slightly bigger patch, because it has to be wrapped in a try
block. But its purpose is more obvious.

https://lore.kernel.org/netdev/20260811182856.2702163-1-willemdebruijn.kern=
el@gmail.com/T/#u

> The issue may be because the ring reconfig test now also sets up qdiscs.
> And we don't have a proper way to restore previous qdisc config in the
> tests. If another test needs to change qdiscs we should probably add
> better infra, but for now I think the simple workaround you suggest is
> best.

Interesting, and that also has special logic to work around default handle =
0:

"
    elif root is None or root["kind"] in ("mq", "noqueue"):
        # The auto-attached root mq has handle 0: on any device (real or si=
m),
        # which the kernel rejects as a qdisc parent. A 0: handle means the=
 mq
        # is the untouched kernel default - no custom child qdiscs can hang=
 off
        # an unaddressable parent - so installing a real handle and restori=
ng
        # the default mq on exit preserves the device's effective policy.
        mq_handle =3D "1:"
"

Again, sorry for needing an extra fix to what was already a fix :/ We hit a
corner case that even with my testing I just did not reach.
