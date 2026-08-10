Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77443B3EE
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390791; cv=pass; b=THmXn4BRVWH8lHfpCUoLNIYPYB+zy8fLEnNA4ItuXx5rDp3YQhWb6dJpjIBB92IKc3tqTTccd6ajS4bz0lFBC5lxrPKmO9GJRg1YLb1CX9tof+njdOWl+BhmJEHWBLeZwu4MegwC2Z7W5AQ0d4tzUP6do6YOpCapRx2jYfDfO/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390791; c=relaxed/simple;
	bh=zhdQS7XPp9VZ1H76Y4geotDJLYL3RmF7weVlppNeOig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U65XXJKWhc/D5dIAyLru1Op2f0r5cb13+ImmYoy/dDhCUVDbzNMcvXgF1FNww+Q4L8Ck1xXN4JfirJLFBCAEDiwv1ZkiD40uMRAIC5VWyWcfce4dwnQI/poMaI48Ee1o4GCZtkCbxg3ZCgi6lJCJx2Sdxr1/lAG5IfvtVfsSwnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IsXm14BA; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IsXm14BA"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccdf36f63dso1545ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786390789; cv=none;
        d=google.com; s=arc-20260327;
        b=Xo6fMtPu7grDlyRUjMpt2oDndA6rxudwPY56AmXzp70ZI6nCKa/V4+iAnkwQbtrbBz
         FBkwV0odjs5kxUX1M/Xh70QxFeH5ULbb8fzOSSQOxZUWFYyhFQ9tJ0UoMsxe9TKzD+zh
         0z8IAsrpdNxqQnDyJ7mSLBPdbgY5Joizbms3J1DqESi+itrzSnlSuvNWvhanwQNftV7o
         Hxmq5zGJrdS009oHkzd9MOmHfKXzW3u1rQOqOy+mnNX8x9vHgyaSltphcZXwDbo4878A
         vGLT8dnBxYT2B+rh4inl7y5dx9xyH09maXW7ZDVGMaXNCLp5tAV/ZbBP/bNRLz76f1Dw
         Km2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkZ+v/6uQewpz8xhjKmBT4IBABIllan0Fgft5e2M+G4=;
        fh=/mWY6iOvXeiXSjfPff5WzqpHpkxo4CEemXSdc02n0BY=;
        b=lg3cspgfOw+M1eRcW/ZN/OVxsz/wmj9iqjEF2AaDUjK67sAWEEgc7t6ul9S0POHpFt
         laDlr5RPO74p/Nnwr0te5GtLZm6SD7xWvEjwnUT/+dJpX7urM2V2+4ZyjE4qf6k0ejOL
         AQ7jfF0s/ETQpyusWmVXk/9Eo1GYYhZQeU8JkEkbBLndk8UyvFKbaiyY4nquj8FeX9KB
         d26JvtYJ+WWek32X7zPk0r5L4SM4X1YE0VnwjFfYx0SyGVnPAsPkdvQts/W8x7SsjZh2
         X4eXAI1p1Y8sGHzdnMeNLOhRRj/ch1egdd8lRCJssmYawuXhk2vlDDQtJgGcyaL4Es0y
         s48w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786390789; x=1786995589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SkZ+v/6uQewpz8xhjKmBT4IBABIllan0Fgft5e2M+G4=;
        b=IsXm14BAoe3o2HIJeU3bv/oHdoCbMEhDw0tGvQXBaMZyJW8NR680uwGRwJ9/Yn43WN
         DiN8M/30L/A6BanGQuVHM+XBVTFe+ywHAWqYy0sATvJiYyburNRyDLKwUo98c3gLFBN/
         XKqWYz5d14/mtvOvBDNv97JPLj4vgUNUKEHMDBKFvYOAPZlcLYZTUR05jzbm45/Upqpb
         lMJIu7CWu3L6MprkFf7AezQaotOp+s//duKmjSsZeC1ZJhTTwbmgsnEzOHzRIxt4LEWp
         zgmHqfECZObJpvfObeCcXQNkOo1dYYkmQ+BazPg5AXwHUD7J1Aqwf7iiz45HIjkWscYj
         o64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390789; x=1786995589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkZ+v/6uQewpz8xhjKmBT4IBABIllan0Fgft5e2M+G4=;
        b=ByinkGINbmwNWFsoz1jIgyA8cFD+wDxdb4VfnFc4XaX0ZSjHLasDm+rwh7hzAlSUyq
         ES3huSJTsug0UxwUQy1DsM5IGg1soOK1QHq06dvlL0qtTizypN8krQa/OG+NxpC0h/6M
         86UrjUJo28Zjcs4m27dsZU6mDb1oFxWp+uYBWfPDpARRd9sFuv3dUud9TH1Z+IMyGSqd
         W5jWqw76plS8m8q8xWVGjUVihJ/fTtl/BrUqJHWoPrc8TE/RJ731kK1jjaW8Ji87niMm
         RMCpIl8Dj4YSibwT3gzN85zxaBwT+Fi6DcXR52dTEk4Ep1DU75QBcdNMwyTMRZhre+2Z
         bDwg==
X-Gm-Message-State: AOJu0YxBNidFIGDQrAPYVvH3pey+sZOK6mhjW5MByWOJl/z2uArwTeAr
	7Z0uh5z/NxLoqeqhbo+HAo7NVDVIkI8cmw8pR1RR0zfueLFF50ZPjlOGGeFo1+nWpzMocCLUvru
	nvZ6/XR89AA5k6D2MXdka/3TYQVO1SnNl7zEqwzkS
X-Gm-Gg: AR+sD116teGPMqo2pKV0G0Txcyqqvlp63L+jyAti5gBrhEIQdKKMczI/kWqz2GWG3k5
	MuuSG4VxO1dT9wKFA4hvQxHqYGBJwJpLe4j+LPwGYtx10aVuV3PYZv+FHLgEj4whKL/NEGydd5v
	dDNQrF609GmxZ+J9bhC0DmdJ9X/RASgMleWC+YsJlOoBRhcdx5QTukxIsqNM9TXJahMCWJAaNGk
	a7TS1h48RuVhD6aloF7r6oCUamky5wyoAJTMIGi+gY/hpcSLGuPHrnPlNq6FMD2vVV52Agvv+pi
	zam+dlrYJmwd0SYEoj55sNVhK/H36Sp3VZFygX8GSg3ZaJwkXc/bj75j+XTxhTTLja+41Hincaj
	MpNxFhTHsaA==
X-Received: by 2002:a17:903:19c3:b0:2ca:e0ff:eaa0 with SMTP id
 d9443c01a7336-2d310480f06mr2350435ad.2.1786390788188; Mon, 10 Aug 2026
 12:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810180956.2348280-1-almasrymina@google.com> <eea5d4c1-af06-4210-b7ac-b783dc44a819@ovn.org>
In-Reply-To: <eea5d4c1-af06-4210-b7ac-b783dc44a819@ovn.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 10 Aug 2026 12:39:33 -0700
X-Gm-Features: AUfX_mzVVWg6LNEjY9uq1pS9xgYMCNK6qwbmNzBSX2Zyn2zqzRODYppEujF76Ag
Message-ID: <CAHS8izMYMurSBRmyZhE9U12YC1vgRHj4X2Q2PfAwh1anKB4OAQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: core: propagate unreadable flag in skb_zerocopy
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 11:55=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> On 8/10/26 8:09 PM, Mina Almasry wrote:
> > skb_zerocopy() fails to propagate the unreadable flag when copying
> > devmem fragments, causing target skbs to appear as readable memory.
> >
> > This patch fixes the flag propagation. Additionally, it returns -EFAULT
> > if standard payload is mixed with unreadable devmem fragments during
> > extraction, and clamps unreadable skb lengths in openvswitch
> > queue_userspace_packet() to avert truncated invalid payloads.
> >
> > Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> > Cc: Florian Westphal <fw@strlen.de>
> > Cc: Aaron Conole <aconole@redhat.com>
> > Cc: Eelco Chaudron <echaudro@redhat.com>
> > Cc: Ilya Maximets <i.maximets@ovn.org>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> >
> > ---
> > v2:
> > - Return -EFAULT when mixing unreadable and readable frags (Pavel).
> > - Clamp unreadable skb lengths for openvswitch queue drops (sashiko).
> > v1: https://lore.kernel.org/r/20260801125308.1342897-1-almasrymina@goog=
le.com
> >
> > Openvswitch maintainers: PTAL at the openvswitch changes closely. They
> > are reported by sashiko as an also-need part of this fix:
> > https://sashiko.dev/#/patchset/20260706155219.23757-1-fw%40strlen.de
>
> Hmm.  FWIW, I do not see anything about openvswitch at that page.
>
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index ae69b2cabab9e..7c663d7846174 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -480,6 +480,8 @@ static int queue_userspace_packet(struct datapath *=
dp, struct sk_buff *skb,
> >       }
> >
> >       skb_len =3D min(skb->len, cutlen);
> > +     if (!skb_frags_readable(skb))
> > +             skb_len =3D min_t(size_t, skb_len, skb_headlen(skb));
>
> I'm not very familiar with the devmem and the unreadable frags, but if
> there is really no way to read 'skb_len' bytes of the packet, it must not
> be delivered to userspace.  Delivering truncated packet will confuse
> ovs-vswitchd and the packet will be dropped or delivered truncated to the
> destination.  We should return something like -EFAULT here and the caller
> will drop the packet (MISS upcall) or continue processing if the failure
> is not fatal (ACTION upcall).
>
> This practically makes devmem incompatible with OVS, I suppose, as upcall=
s
> are the primary mechanism for initial packet processing, before the datap=
ath
> flows are installed.
>
> If there is a way to read this memory, we should make a full copy here.

There is indeed 'no way' to read this memory. That's the short version
at least. The long version is that they can read it on the GPU but
this requires the userspace/caller to understand it's in the GPU.

OK, sounds like the right thing to do is return -EFAULT here. In the
future someone may see value in making openvswitch unreadable skb
compatible I guess.

I'll rev after 24hrs, and see if there is any other feedback.


--=20
Thanks,
Mina
