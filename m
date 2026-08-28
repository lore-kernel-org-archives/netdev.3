Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E63CB552
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904319; cv=pass; b=GAhluAKi/ridNVBLu2hsm7X7fJx7AQADPZJ1L52viYYozQa5DGJRdzJlqlMnUhr2b7qi9cXiAUGhCrBMmBYSLdnsvEUUtI1kLsh2UAzwIhGnAnmJn7m2G6iI6pewhV8fwI6oiFdYUtssIARpS2ANzh0DyuRJVGvdnyUsaOvUwHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904319; c=relaxed/simple;
	bh=wNKjtN+MdzP2+0PxnbbIkfIy4RRpZSunCNBJJz47CWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipd1gGpvaO/1y7U1r7mHr3lbGVYDCqF1OjJC3tfTDOURzZkQfbVZcdlINGAgrl+OFETZbX5v7plnoRkqv/r0m2fDMxStZ/tVHNqhMEJxBxLn+DYfs1xqKYiJ5ySfdgFlByxzBR8aR1aMskJoGE1F6ufGyJgORPmTfBl6mSsvIic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=GC1GJG8V; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="GC1GJG8V"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a151eda82dso6139961fa.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787904316; cv=none;
        d=google.com; s=arc-20260327;
        b=JGrC3vV3AxWkB6LdJKjQK11sQfyLr8NWOLPOt5AG64ncwe8DKBY9y68IQJ+mq0aBB0
         Id0Bm5Q6FARpP7tGCy2wDWhJal6FEto8X5axgzxssEzD30RhrhS5RePdnbV0Q2kJCj0e
         3YlMmX8O5GQ/l2AfuD6bFL7QMd5B14p/XsxWe3lIEY5tCS0s6lboXCAcn8DYHk4az9Vk
         HPCCJ+lYqdIxAC4iOQi27zxS67zzzlpYAI3A3+EVUgObUryTCCdmlL6iuYCvslXq27KK
         nTPV8fsZzJopWcCmoNkjCiYgx7Qfr6nRBYEmgbGKmBHI9prdCFbfTng2rMf2HxrTrp6d
         dRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7+GGXhNyLGMH/bPEz2IJgnBSX0Z9WNgkMR811qYVvJ4=;
        fh=0SX50+duOxFk/oY0V3OjfkKOY5H8IFCu5zr2Yn20bKg=;
        b=RUq6/FmkJ35Zpe2oeitwJHhMhL1ja+Ts6H/0IMBgmBGQzesasVRD4OojmlHlnidYbu
         3/Mf0uMRke5YhHmZoJTkWu4K5oYKuU6D2oWElG25Jmy27ClaCUJhzFJih/3mzhs58mw+
         qMjVEdht6eLpFvnaFjK8TAJRwVOLQ1qoQGBFrSYuB447Wdoi2+wtXYxAzpnB9g1NXBwC
         GQDZXOr23YfXldFBJOW/ZOaIR/mllletH9ijS7RM5lVG6y0ssPAdyNJgfcBjkEVgB6f6
         xbX6+otOxbGtRowYgkevkKk+wa1G7+X4MgFZZfCAD7L3Sy4IqVbDWFuKtE3oCXFZljzS
         5j7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787904316; x=1788509116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7+GGXhNyLGMH/bPEz2IJgnBSX0Z9WNgkMR811qYVvJ4=;
        b=GC1GJG8VdmcHq+lWgSjFKnm6iVdg3oFvOxhDTJGvOBY8MaosdTIH0a76JTIsB84pTr
         +GrsMcsIkxBLKamOiLdUSjLHymA5UDwzraYoXVU1FEJAB/s3AbBCpnR51rhIJtb4kVE6
         D0gSOi+WVEjjZ0gTw4gxlVt7HOEGP/pIynr1Bpp4o9nkyWvm3DUqABi/6e7sG3A8EL/e
         gaz21NbGLdQ20KsF3YpjXEDpy71GZ/fKIPTTdsB0dvmLjPlYsqiJSlqkeuta5uE9TcE+
         /euMgA7FSOY3r7HORr0fDi3So5jSEDXmRA/IJhv1gMYe2WCpO4YuWholAgJ68qZPz1nv
         dHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787904316; x=1788509116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+GGXhNyLGMH/bPEz2IJgnBSX0Z9WNgkMR811qYVvJ4=;
        b=OGKMcdZ9qye6Prhty8DRTIJoDzMzko3NJJeqcMMnmzvZ3fKWXU6Dql+iOD6vHhcV1e
         hNyTyUSfXfvLpz4VAKnY/QZjLuUllhN9aIVI27Soq9x13Fr/Bavl82/fF8LqEpg0OqFo
         IZB/dmoyROk5nPZFuavt0BYb85TdAvvV6WsErRyfon8lbMBBirNhGKGqqtOmwVUJ+upL
         ogDt2wNIwbG5eM4NpT6b8UWgZVX9TLCr9RtAX5CxD+VR/Cz4yLJnh3TyEeidiN7mOjlR
         SK06Bz0hbiKIP+NC5/HuzfetCgQNZm3QRVF1h2razB0OwWoQllRThCAkJ79pIsz7yvdQ
         nngg==
X-Gm-Message-State: AFuF++nSMH2OzkNyO9Dc8jPmKhZHBDxp+zDyreMEhqNFtPEYxVE2JJEy
	tGDXeV2txVOT7pDz+QCczPOI7yzcf2RpVIsgUGVvaits5/xtfUGv3ql1i6nUFXZDjvTYvt/jmQ4
	chbr6bPOGoCEiqg9TeZObTnuXi+pQeGPS1Z/9cd37KYg=
X-Gm-Gg: AR+sD134Wu9CRFBo135b6z+a3+2b23XUKNyBsUmQx+85/0q+HQfQvxm5M3xgA18IPXF
	XdRb1pMreiFAu4G3j3jTr97qvwN8WXIuqz5thxoxIFZO2vYxN6kZXCBFlu8SwMZD593SNZ91L2k
	p4kUv1L04djUIcmNoCCfTBHHJ/qU4fQhZGD6wYBY7ghBoqFr0sqvNOr6Kes+kQus/065+P/le8b
	9uvnbxxefCuHjIaA2usAQvlc+Va9jIUXkMcxUkTcpCg+SvY75jb9vOFqu/MaVbGNXrbJvj6jS88
	OZ9FkkLpqNeeNUVaPX69Puc+DG0PwtEKg9h/rB+SwbJFmi3eAza2CYE9HqEu0rx/4DrbbAUbtkK
	5dQ==
X-Received: by 2002:a05:651c:2224:b0:3a1:980f:5907 with SMTP id
 38308e7fff4ca-3a301b3c0f6mr7257361fa.8.1787904315593; Fri, 28 Aug 2026
 01:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786962220.git.zihanx@nebusec.ai> <ao1QMuGwSzhtlmo5@katalix.com>
 <CAANe3eR857ZyGa_2PdBOVaehCoHr+6qH1J0jid66-z_0nCEgMw@mail.gmail.com> <apE_bzlcmIK1FOs1@katalix.com>
In-Reply-To: <apE_bzlcmIK1FOs1@katalix.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 28 Aug 2026 16:05:01 +0800
X-Gm-Features: AcwNN1XTmmPxj7tQJkNiRC_RdZzTSoOlxQ_xDSWXXRwyJ4KxPdUxne8uge797HA
Message-ID: <CAANe3eQZB4v3ymhcuPNdC29r+b3TurO-K34KQ9u4kc2BniGYug@mail.gmail.com>
Subject: Re: [PATCH net 0/1] net: l2tp: ignore multicast notification errors
 in netlink commands
To: Tom Parkin <tparkin@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bhong@brocade.com, 
	stephen@networkplumber.org, sven@brocade.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:57=E2=80=AFPM Tom Parkin <tparkin@katalix.com> wr=
ote:
>
> On  Tue, Aug 25, 2026 at 18:35:21 +0800, zihan xi wrote:
> > On Tue, Aug 25, 2026 at 4:20=E2=80=AFPM Tom Parkin <tparkin@katalix.com=
> wrote:
> > >
> > > On  Mon, Aug 17, 2026 at 16:53:17 +0000, Zihan Xi wrote:
> > > > Hi Linux kernel maintainers,
> > > >
> > > > We found and validated a issue in net/l2tp/l2tp_netlink.c. The bug =
is reachable by a
> > > > non-root user via user and net namespace.
> > > > Here, that reachability statement refers to the finite state-commit=
 trigger;
> > > > the OOM transcript below is a separate root initramfs leak-mode run=
 (UID 0,
> > > > PID 1) used to make the leak and panic deterministic.
> > > > We've tested it, and it should not affect any other functionality.
> > > > Regression coverage includes the root namespace and an unprivileged=
 user/net
> > > > namespace, with notification-queue pressure and successful ACK path=
s for all
> > > > three commands; no broader regression suite was run.
> > > > The finite fixed-kernel runs returned ACK success for all three com=
mands in
> > > > both namespaces. The leak run returned ENOBUFS and reached OOM afte=
r 41984
> > > > hidden Ethernet sessions.
> > >
> > > I think the underlying point about allowing l2tp_tunnel_notify and
> > > l2tp_session_notify to impact the return from l2tp_nl_cmd_tunnel_crea=
te
> > > and l2tp_nl_cmd_tunnel_create is not unreasonable.
> > >
> > > IMO it seems relatively silly to allow the notification to cause an e=
rror
> > > response to be indicated to userspace for the create command when in
> > > fact the instance creation was otherwise successful.
> > >
> > > That said, I think it would be worth clarifying the behaviour around
> > > the "hidden" tunnel and session.  From my reading of the code, at the
> > > point that the nl notification function is called in both tunnel and
> > > session instantiation, the kernel has already performed checks on
> > > input arguments, allocated the instance, and registered it.  Even if
> > > the l2tp code then returns an error to userspace, the instance is
> > > present in the kernel's tracking structures.  I would expect that if
> > > one then listed tunnel and session instances the new instance would
> > > show up.
> > >
> > Hi Tom,
> >
> > Thanks for taking the time to review this.
> >
> > > That being the case, it's not accurate IMO to say that the tunnel or
> > > session instance is leaked, and the fact that you can cause OOM by
> > > continuing to allocate new tunnel and session instances with new IDs
> > > isn't surprising.
> >
> > Agreed. =E2=80=9CLeaked=E2=80=9D was too broad a term here. The tunnel =
and session are
> > already committed and remain present in the kernel after the notificati=
on
> > returns -ENOBUFS.
> >
> > The PoC does not use `ip l2tp show`; it sends generic-netlink GET reque=
sts
> > for the newly created objects. On the unpatched kernel, the relevant ou=
tput
> > was:
> >
> >     tunnel_create returned ENOBUFS at tunnel_id=3D1040
> >     hidden tunnel is live: tunnel_id=3D1040 ...
> >     session_create returned ENOBUFS at session_id=3D1000032 ...
> >     hidden session is live: tunnel=3D1040 session=3D1000032 ...
> >     session_modify returned ENOBUFS as expected
> >     post-modify session state: recv_seq=3D1 send_seq=3D1 lns_mode=3D1
> >
> > So the OOM result comes from continuing to create new live Ethernet ses=
sions
> > after userspace has received failure responses, rather than from an obj=
ect
> > being lost in the kernel's tracking structures.
> >
> > The more precise description is therefore that a best-effort notificati=
on
> > error overwrites the result of an already committed operation. This can
> > cause userspace to retry and accumulate live L2TP objects.
> >
> > The v2 wording was updated accordingly, and v2 has since been applied t=
o
> > netdev/net.git.
> >
> > - v2 Link: https://lore.kernel.org/all/cover.1787247008.git.zihanx@nebu=
sec.ai/
>
> Hi Zihan,
>
> Sorry my review was late (I saw the v2 was applied right after I'd
> responded to the v1!) -- but thank you for taking the time to expand
> on the above.
>
> Your explanation makes sense and aligns with what I was expecting, and
> I'm glad the underlying issue is fixed which I agree is an improvement
> on the previous state :-)
>
> All the best,
> Tom
> --
> Tom Parkin
> Katalix Systems Ltd
> https://katalix.com
> Catalysts for your Embedded Linux software development

Hi Tom,

No problem, and thank you for taking the time to follow up and review the
clarification.

All the best,
Zihan
