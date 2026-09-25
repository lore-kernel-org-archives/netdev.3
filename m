Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCA45C715
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342478; cv=pass; b=P9aJor6lFV49F6a/AH3Lz/qO8d/0gLRwcWEPHVzcfwbLw6yIC16U6q6hXH9hXaVxiW+csrKqstmrZzmzC4V0+mKcJ2PqXV8PGqDNCiKpHCp/1Vq67CwYUT2IVEgT4CGCjkBEjZmj8zZ9kn7EuTI/8RHvHv+06ByyCfuEPxz9o+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342478; c=relaxed/simple;
	bh=hxUXRoQZQS1dHriZurFJV/JaoHhrroxuYSIuUVhb3ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyB7vymmeazGElrifeR5Qj0PNi5IB7yQsyu46U3o5OadueZ/DXgzJioSOpHHQt1JWXubAImHC9/IGfPt/ZrK7YiTDTBw78IyCfCJuC/iXOR2KS/0BCbOjl6uNT3tkFVCjZaMcyTakcz4IG9/ysW/4y/TcNyxzqmESK8Vpff3AT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTEL9TbO; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTEL9TbO"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb76bcb1eso11672721cf.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790342474; cv=none;
        d=google.com; s=arc-20260327;
        b=GaP3wECDRoUpb7kho+BChWPIx3XMrJoN4SZO4t04A6cG0JHdBOKEN/+x5QhvBieHOd
         iiYu+tb95X/jfCxO0BlbLiubex94IIGc/9ypOUk4ybNcOJMNnEODZKlOv5W2wWSz4Nsl
         W8bAI+Sh3T7VR/zrAUhp40Fa4lI7kuMyeiql5/TOT81+EetbB1qFk9up64lbatCu5xrF
         YHaDShtmdyXzCyfcRmNBkzywHnKutFBldB0YKA32xTgGCt0e7U1Rzexl3S+88UcyEtmd
         kGgNb4zSwJfLJ78khX93IKgCu3x2L9cqCi2Ep4davows5kqcJzRGZoO9DeKXmJpFgGwx
         VYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gBCen2qbWk170V7Oslrk2K16X6AvRxhmlmHEZ2JWz7E=;
        fh=kzbgKdvM6K532NC1IgTBR8ZQWopB7wT4MxbC+R8mqzU=;
        b=Qg3Lenen/42OZkbZz8m4gmlq+Fun2Yj3vGn+AUUR5dJcnO3uW/22OOnk7NIal3b4LR
         Lms76vw/3vJ/YM0u6v2VQYOp+Fnd2fQvAvJa2OU8vX8unnoJc6xnln1+ZXHVpqiEqPRK
         rTffWBo4wypz6nIsFwaN/HrWN9x6PE53cf3v4LSP83IpPS/TEjq1wAcNoyzWd82NmC0x
         cfM58T44dRhZunsgnVT8BkegyrX6FYoSmi7GHWyllh0eVBKocxfmDANmb9iod5L5eSTR
         iD8Fkoc6ZH9tWflc3+/CQSH5C7jQzqYDt+SgkfZnFYGLy7R+VSUGO6WQ9pJH5jlTKBT7
         mQkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790342474; x=1790947274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gBCen2qbWk170V7Oslrk2K16X6AvRxhmlmHEZ2JWz7E=;
        b=pTEL9TbOkW28RHv5Zlg+lVmYe+05hG9otr1lZHgr6cUuaHedt12sue0JX7hqjCapjV
         epaM+0KxczF5S47ByYjk3b5gnuFXR9asfahtIKhF2YHxBkPH9901T4VjggTFP88gYbIU
         QNRi/0F2hw4eudXvukItro1MnuPOJPfqVE2/o4EIb8jzph7YO3d2pbzicXW4LxAzzE4u
         FMLfbmTz55KwoAhsHHG3oBy4zf2o8EslFsbrtOzqKU9pSYp3nQCEfXjKOz2vT8tVCh9F
         HWXp+mm/HCvADZv3w5QQb6dqBdw9nexa5WrKCrJ8IQoHkNSq+BMHp3uzJhauRAlK2w5k
         3ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790342474; x=1790947274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBCen2qbWk170V7Oslrk2K16X6AvRxhmlmHEZ2JWz7E=;
        b=Z4IvSRl2SrGMKZkT7aWCMh6lWso8OfA7ALWvVers496lrgp9Qrv+geQaczLMY0elMX
         O/vARyeGo9lSgLUX9mJykfRhclxjZ4wv+lVTE4E1eOh8wvurMWl5td366nzJD3gCi8R6
         itIUZ8lViaxdm4A9BNIYV4uNefvBWUGyPqCNTvtdAzMbOP53agwm8oZJv5V5MfXal+1g
         ayrHBVWrOTMpryRf9q/dSYB5UrZ3AqII4ZurQ0Z2A+xcK3KB6rwq3l3bOI8YUTngtgss
         /9JTWQtA3SK4MBEzomnTmd/6EsxckjoBI/bkM7KKo+rAYs56YUvUT4PwvGs1GQBmZ2gk
         0Ffg==
X-Forwarded-Encrypted: i=1; AKwUvByQri4jxdcaYDfU+NnUqIPB5zxetiP2npWI6scbClx66uFAfLiAb6V9y+DXv9vbAaKMZCvfatg=@vger.kernel.org
X-Gm-Message-State: AFuF++kdq5wZPcceREPfdGDd/jFoFmftVu8egqhCLNa2LbTB284XKFkS
	5bO230u0/ABt6CG2BXYPcCOPkVBM29HMCjZx8+ONiI8YZsc5uTY/huZ3wWS/NhBydGU4cQbUwhX
	xorpR57NUTBH8GXxtbcc0xoKfknLsYXRN3QMnT7J+
X-Gm-Gg: AYBFou1nngbbONzD8azZD3La+UxqmSAILWlkWKXehpvh6NQJWS+TYpYgv5e7CT8BhBw
	Stgj6EjVc13RDuTcIf4ncK8GqyE4/fTMa34pR3o9n5/soWeAJgwirMe0CCA0Q/FqjXBG2zNmeRB
	vGhfvtJN5EVkUM5TuAeqiknzclVj7doQETknBnGsoJiOwlisL5L9aXMvUkrB7/lZ7FQGnDXaNGP
	E/uIE/DvWzkWYHsIeg/CTb08P4hJv0qA15gChtN1cFU/sztj/bgF/b0da3d2f6EBKmxnGweFauX
	24poxpxliNEUxWklDFQkF+17q93pPTKEnVGvJMwukO9y/EuRY0AyjZoJut+W7VWC38HvYQf3SUK
	rjdUbdSk0kHa9olLsok8gO1zg9SdCdJ0htZRTlB2E7Fkerx8auG6xybpSjbqQFa7QhPNt
X-Received: by 2002:ac8:5f0a:0:b0:532:d744:6125 with SMTP id
 d75a77b69052e-5330dc187e9mr36642451cf.14.1790342472844; Fri, 25 Sep 2026
 06:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924123602.1979090-3-edumazet@google.com> <179034054266.2160803.16187930067723490774@kernel.org>
 <CANn89iKOKtJVOm-24cyEUTta8VUsiw47VF9_h-73XX_YiqmBaA@mail.gmail.com>
In-Reply-To: <CANn89iKOKtJVOm-24cyEUTta8VUsiw47VF9_h-73XX_YiqmBaA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 15:21:01 +0200
X-Gm-Features: AclHuK-Z7RCtp6GmJ_gWe4sR2L1q57XYzTPQaGR8bPj6dlDQSzQLWTaPeMLVqtg
Message-ID: <CANn89iL5coSt9K85AF3a1F6T--DRPz03T3ApmoiDOBrZ+J3GgA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/net: add SO_RESERVE_MEM test
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, weiwan@google.com, 
	horms@kernel.org, caixinchen1@huawei.com, netdev@vger.kernel.org, 
	edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 3:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Sep 25, 2026 at 2:49=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 6 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 4 =C2=B7 Low: 2
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The new SO_RESERVE_MEM selftest needs memcg socket accountin=
g
> >   but never checks for it, so on systems without it the tests fail=E2=
=80=A6
> > - [Medium] When socket() fails, check_non_tcp_rejected() only accepts
> >   EAFNOSUPPORT or EPROTONOSUPPORT.
> > - [Medium] cgroup_memory_max opens memory.max with plain O_WRONLY (line
> >   217) and writes an 8-page limit (line 225) to the cgroup that holds=
=E2=80=A6
> > - [Medium] preserved_after_traffic checks `get_fwd_alloc(cfd) >=3D 16*p=
s`
> >   (line 325) right after recv(sfd, MSG_WAITALL) returns (line 323).
> > - [Low] The fallback `#define SO_RESERVE_MEM 73` in so_reserve_mem.c
> >   (line 21) is right only for the asm-generic, alpha and mips ABIs.
> > - [Low] FIXTURE_SETUP writes "+memory" to <cgroup2
> >   mount>/cgroup.subtree_control (line 80), and FIXTURE_TEARDOWN (lines=
=E2=80=A6
>
> I have no intention to work more  on this test, which was really a first =
step.
>
> This is going to be 10 versions of AI agents trying to talk to each other=
.

I will try a V2, but this will be the last version.

pw-bot: cr
