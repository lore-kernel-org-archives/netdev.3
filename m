Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5036197D
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560050; cv=none; b=fLZBqsf09gOCIk0CV+i9b6sEThIUnWGobYFGsKKmE4g5JQK4StX08hViy+ujW3Me9j5sRhkIf4xpeDVwrBwNxQgRMkq7D0rlCFTQblxGS71gJwLhQh+xk7DVHGjPIiDQ7a00jo5BbxKGan0z5MA4+JklRf894Wty9zIQzwbvY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560050; c=relaxed/simple;
	bh=piVN0vdcGV6FXrgEDztXaMIKO5TM8jHJZPuqr+UKDPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGwomOpI9AqqP0R7RBpK+aVQOVMHe4FqtzWlkaMnnjs5TfgRP4Q8ziQ+S/NkWo4mkaNFWWBye3ZKpb/k/b9j9Fct35ZlLRVBc0ofA91U84/WKfV/PiKRwfBc10l+AOs3ud+ShjefuQkS/zGtiVI1Zs92dWbvJCqxTpDHZMWquiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0OUWFBU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0OUWFBU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47362928f65so1461753f8f.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560047; x=1788164847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FtuRlJn+ZrLHnX35qATcjzadl2jMeleh8fW+A4zJiD0=;
        b=N0OUWFBUHTMHBCoZduWa5IRLaPto/ME6zte0hupn0sQUa1GXRdg37DLg5QZKT7jpAl
         ANfCkvUlFgl8kn4YxbIZiVFSnQdmvmzyL1IMSAVm9Zcfo+z75c1kcDHkO84+O9xhISSw
         FL4S8OholcfVgLnLVhxMfhyyk1skfPWj/+LDA3Oo3nT8vh0l4jNewTKG7TU6j+IbJ3Mg
         NattPuC5270gqG79Xn6S4M+DFHGWR0WXBXZi+KC2UkHZhW5i9FDyWQJjWmSUPYllBmSo
         MMsUkzJhiKo0Y/Yun9bphgZrPwEkKNGGEC/tTBt+2MFCTR0p0Jj4grh1s63kxBQHzvhb
         clwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560047; x=1788164847;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FtuRlJn+ZrLHnX35qATcjzadl2jMeleh8fW+A4zJiD0=;
        b=WNfjxShDf7BwjWNyvxF9f9He/xkqzyqffBIp8bwuXzT/gUYJI0JGHws3zHXOf8QFdr
         XO4xt567S1G0obN1OBz32QYrS60oe61dv0kWK3iKG8tZrMfuPquUbj4xTo7kBa9WWiWh
         wITWLOQBMCXksTkvDsiy81Kb/SYm2HdiRSac3QBwEFlA5hlq13bs7ESf+POeR29Y272t
         H/PR6CJS3O1MhId/Lwoe07C4+4Mzmn8YKqztjfPgpf7nEDOQyDljOTjCCIPcPTOt+yq7
         axYegLAba9SKl+mJzbx1KBfcVVHH8k1WZWt+OrzXTu7Bdp8UmywCSwWx1wNvtDjO1fOk
         U6nQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1cntDBi+4vG12LtX8F5QcQoZFLH83xdsztoXqAHD+W343nMoSghetZ7mxGBir8ivC2lFlFk0=@vger.kernel.org
X-Gm-Message-State: AFuF++lC9q2Chbb0nDU3oh4wj5ttcoAasqgZqGHpHLEMAC8+TfoEA2C7
	/1FQxG2NVobcnrzj2s4t4qbzyGUXS2fClGHxpt+ZYZwu56f8gFDQX2co
X-Gm-Gg: AR+sD10kbm6JUVJVC/xtsPrza1UtXkvQUJiMvYP4KmyyU5J9a/7QatzqmJ4uqec9hOx
	JBu2aHbrOmL0brKETCy/sKIxIDjXbYorwYJCR1PNv7x8Zi8ZqN1CBMrgwrYgDzlFEMy8P5mQeMf
	1OXM+r/q0I80tT6n+B36blpaChsyt0YSk+NZ6c4vR5t0C+MwdyXMfL7QWLMxo3HQ2Px4SpdR8w/
	SLeX27I9G9TNjCHl7J93FiNMs5YmsU9c6YVyVZQliCBxvXDxyqEjNBFg03rv+wqcavYr1P3eS/T
	HQaf1NW4lbAsQYVA7BIl2EuCPSdHhIQzDPCH7+2dgoVDBr2r+uqI2BrjH9WDWWyfQuDquEA0PSj
	qNNG/S1A3MJFZj7JGF7aZpzxFz/ZlBaFoUt4G86LVc+I8gyFHZDFTZuW0wwz/K4Wsl6XEFdzdh3
	yHRjS8+2QhCOBILiONCewmSXPoE2QSG4DimDrD97a4/aEo2bkxEZHgcWcioT1AgUt/WWTRzx09p
	k44FuAn6d/oF0HosyJLDZVSFA==
X-Received: by 2002:a05:6000:4608:b0:47d:ee9d:90c8 with SMTP id ffacd0b85a97d-482c0b44af7mr31766089f8f.3.1787560047226;
        Mon, 24 Aug 2026 01:27:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9bfd2c6sm7438382f8f.24.2026.08.24.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:27:25 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:27:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/1] tcp: reject non zerocopy devmem tx
Message-ID: <20260824092724.1b62af12@pumpkin>
In-Reply-To: <CAHS8izMLw5EwR8Fr-0F6S8V0dYgyGe6UW0dmy0EurfHU5TswoA@mail.gmail.com>
References: <ddb2d77e49974232b7f379851dc9809c953a6649.1787396169.git.asml.silence@gmail.com>
	<CAHS8izMLw5EwR8Fr-0F6S8V0dYgyGe6UW0dmy0EurfHU5TswoA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Aug 2026 08:58:32 -0700
Mina Almasry <almasrymina@google.com> wrote:

> On Sat, Aug 22, 2026 at 3:57=E2=80=AFAM Pavel Begunkov <asml.silence@gmai=
l.com> wrote:
> >
> > Device memory send doesn't work without zero copy, prevent
> > tcp_sendmsg_locked() from falling back to the copy mode for devmem in
> > case there is no NETIF_F_SG. Currently, it'd try to copy from iovec
> > filled with dma-buf offsets, which would normally fail with EFAULT, but
> > it's still better to handle it more explicitly. A recent net-iov / page
> > mixing fix also needs this patch.
> >
> > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > ---
> >  net/ipv4/tcp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 455441f1b694..f403830af65f 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1162,6 +1162,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct m=
sghdr *msg, size_t size)
> >                                         binding =3D NULL;
> >                                         goto out_err;
> >                                 }
> > +                               if (zc !=3D MSG_ZEROCOPY) {
> > +                                       err =3D -EOPNOTSUPP;
> > +                                       goto out_err;
> > +                               }
> >                         }
> >                 }
> >         } else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size)=
 {
> > --
> > 2.54.0
> > =20
>=20
> Thanks, I was indeed putting together patches to fix all the
> pre-existing issues. I think the code assumes devmem send means
> binding is not NULL, and the fact that we efault on copying is lucky,
> we should not even attempt copying.
>=20
> How about we reduce the complexity of an already-long
> tcp_sendmsg_locked function by combining this check with the other
> ones? I was thinking this:
>=20
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b4237d0e994d6..1e34f50770446 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1170,7 +1170,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> msghdr *msg, size_t size)
>         }
>=20
>         if (!sockc_err && sockc.dmabuf_id &&
> -           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
> +           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY) ||
> +            zc !=3D MSG_ZEROCOPY)) {

That might be more readable with the ! moved outside the ():
> +           !((flags & MSG_ZEROCOPY) && sock_flag(sk, SOCK_ZEROCOPY) &&
> +            zc =3D=3D MSG_ZEROCOPY)) {

David

>                 err =3D -EINVAL;
>                 goto out_err;
>         }
>=20
> It will return EINVAL instead of EOPNOTSUPP but I think that is OK.
>=20

