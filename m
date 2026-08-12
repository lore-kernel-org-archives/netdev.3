Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE337204D
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563210; cv=pass; b=bDWPmWPSLO/IoBTrJQ/1+yV9I9gC3GDtdYiYw4fhr2dm/mFwpZX6BgPsa5VoIDSrcMXcq6Pu3odx1uNhaeNlRpcsY25uX0TvOWMOW9BOln1qdAV/KJBihqaNLa8VpBCx+Aua13jDR7UZcOhRLj0n74yf8UxjYzqBmjgtq7gEQp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563210; c=relaxed/simple;
	bh=zeQMQhCevsSoCgf44VdOpoULja3ZXK0NMgrRG0s69u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBXs2V0Rky2ZD2ycJ60Kc0xj4P6zeaA9pP1ZEUqeGA3mWQUAQdlgJZbjEE56IO2CGJOk++FhvVhv4Po4cDW8+KHOj+urZ10bvTlvZq72FBJvSYW19Izsj42IYFLHlXMqsw1ux7u/JVJMw5aiJbgBLzzyMWZh8dn4rNBhGyXPBt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJhIhfEW; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJhIhfEW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cede6375caso4375ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786563208; cv=none;
        d=google.com; s=arc-20260327;
        b=fQDQ9NCstZqqY+bF5wKAysX/tSEfzmEURn7eddkvBMmMf2o1qAAkzgw+8fxTUnmsST
         y14t3SuFLGHaPDiDpXNvdgFnUEtaPbytxsDsXZhCR5u8luON33DiieHO6Ez0MEEtRW0B
         2EPEYP1VtNvCexx98s6CejeeQ3IyAU7ieT5hAaMxzqERXS57hbexWaP4KWBOHx/mcAQ2
         FbCQ3iB22QNzNcTCqbbzRzajVN7Q0gkiPYYFqDWQE5F4on1mm8i3MtfgaQaYheMLzgNV
         3ZM5v/eBNPzizHPy1hbqGW594L6InvlnMWCrJw/kPlZp3tkrU9hVEs0R2eJSzFP9ZzGq
         OmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IP4zNC8eZ2UDiAZA4V+wHHB2fkAyZjLYeO9xLdKiPqk=;
        fh=tnJqr1Qy5WeN/CU+LGJe6AqfETGhNoto3atNveyPF4Y=;
        b=icDCJJvjv2n4klOWdcXmOnCxDZa9MALU5oght1bfCb9lT1VpGcq+Mbwh3ofELunx3l
         1dSF5/gw0DT0H1GoYo89z86ko7SLScujy7bJ/+88/JuWJWQZZHA3iI9LxcJeF2GjB4Bp
         OI8RB8zNfXJUEI4XxRn+283n2Iamh9sDUK4LDw+9j5p82V0PY7Dxv8t7s32EV1vPElDS
         QWH47qjKRYs4q4pESBUvB0yOmMBS4I7q7gLv6lUhU4KZJCMYb4qtdKg2MOrWU86dycRn
         cpW5Kcf9FI/es9YQdCu3KQkEILLkE8J6S8BA45qWov+JQn4PXQ7ksSDoOfVmy2Uvjwkh
         C0ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786563208; x=1787168008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IP4zNC8eZ2UDiAZA4V+wHHB2fkAyZjLYeO9xLdKiPqk=;
        b=MJhIhfEWZgDrGd0mAXBko/1JGb8BiEdxAZeNbfhgvG/NNyUV3XWzXqdagiW81AsZYK
         J406wFUQgvmPRzXsbUz5pnPqho/Yg9JVyioV/JhJQ+ZSDi157sxzfN3zxdlfbKTUW4pp
         ef0K4anE5f5jIqAygU8M7WK+0iZ+w0VDk1yX4qJeqDpu+w9E77WUgHQNCSYWnkzPEEan
         BqRSXdEBEB5F5miKrc6y2E/17ZUSUHkJ9xwIGvt/A85vkeptfVPijxl0BVUFNqRCsOHP
         1xQfY76OD3shy4+8u6MfUh52UYoUlDVfQeisG3okBw598IN4gBQPdtV86q2iD9Kr220X
         nJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563208; x=1787168008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IP4zNC8eZ2UDiAZA4V+wHHB2fkAyZjLYeO9xLdKiPqk=;
        b=glpCzJs7Z5fyphJrLddFrcVXeICKHQpwv047xofiX5FTzCA/LNffwOlv5OUSvROpoU
         YBrE2Kd1/cnuz7gmevPVjrNc5vAStlWxZJ8dhauHWVUyO6lwPdn9dyhJv0TblWZo1UCv
         hxJ/MpXL4PzaI/t8Dm1F7CWMLaeq6bYPLnWys3xvgbeVeBds/f+P6qIQZi2NMqDagl5o
         Kwb1kgIVl5luTjB70JTKketE50Gfr220F+PoKGbG4zWt+7GoWZTncgMcvN+diYhdWcfF
         PxvPxiJivwvxV9pUPoDCW9tmebRc9rXuxfDxhKDWMUAH6WAeWoo1tJtE55+YRGYMMisP
         3NGg==
X-Forwarded-Encrypted: i=1; AHgh+Ro78pPxBcq5BOG61IQz92gww0jpYSMFqF2w5nCaeYabRNZTCdSJXhicj0j95URPHnfw3KVHTYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWS5w5URTZmqeKSuEl79nNew038K+436Wte/nEz2FqIGxAcHR
	vTZ/25Djmlkjz+gAYQdA0rCtXt8YGRyekPS8afWBHQVuNPdMi9AITc1ONgKHv5BiSkXuJwqU740
	6usPdl/dt7i6sHESlD1jeYRXIilZOhjLCXkZ+bm1t
X-Gm-Gg: AR+sD13WOzbNKH4FNsu9YnUtRXhU0+gG5jf65R45vxOHXQpWEP8j5qr6mAZIi15MIv2
	QOmZWYHTg+zWmZKHsV69fGv8rXCuV3cRMAC0eQyhCxRZtGMd1pXDxcYYJ/2bPaV1Q9wxX1DmVUV
	WMAvgHUWYFOTmytjYOVG9eAXRKf2USOU37610OjHhmNoD4ea1Q2S8UBSGDkdwD1kbYdCTsDrzR7
	Tu60n3DWhREV6ZgxAz56Wcdgifnex4faRYLHc4zahga0T1S2YO8Xu5fjrmtTjSJesczy2D8E7bS
	BnbPa4oABbBSa25XYfz84UcRorhr2GMYUtrKy//JdjYV3/A16CUIqpB39F02G7waXILCPw1XbPE
	=
X-Received: by 2002:a17:903:46c7:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d37cf60467mr1097325ad.1.1786563207665; Wed, 12 Aug 2026
 12:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811195405.3979177-1-almasrymina@google.com>
 <20260811195405.3979177-2-almasrymina@google.com> <CANn89iJ=CAaqT94xGWgaxcZHhcMVQmy7=0B3fmW4mjKUz1DjoQ@mail.gmail.com>
In-Reply-To: <CANn89iJ=CAaqT94xGWgaxcZHhcMVQmy7=0B3fmW4mjKUz1DjoQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 12 Aug 2026 12:33:14 -0700
X-Gm-Features: AUfX_mzHnR8Y2NfkfLbnDL3hpeJoKDejp304WnWm79N7ypzq17KD5bHSpos9Zo4
Message-ID: <CAHS8izPB7wEp-LnwyUioYCAEN4zgAoDJrz+phj9H8Mz5JwZ9=Q@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: tcp: block standard payload injection
 into devmem skbs
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 5:01=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 11, 2026 at 9:54=E2=80=AFPM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
> > page fragments to unreadable devmem skbs. Create a new segment instead.
> >
> > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> > Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> > Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >  net/ipv4/tcp.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 455441f1b6949..186a36c698798 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1278,6 +1278,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct m=
sghdr *msg, size_t size)
> >                 if (copy > msg_data_left(msg))
> >                         copy =3D msg_data_left(msg);
> >
> > +               if (zc !=3D MSG_ZEROCOPY && unlikely(!skb_frags_readabl=
e(skb))) {
>
> This seems wrong, as @binding could be NULL or not ?
> Also testing the condition right after a fresh skb was allocated is
> adding unecessary cost.
>

Ah, my bad. We were indeed checking zc only and assuming if zc =3D=3D
MSG_ZEROCOPY, then also binding is non-NULL and the send is devmem.
That is not correct.

> > +                       tcp_mark_push(tp, skb);
> > +                       goto new_segment;
> > +               }
> > +
> >                 if (zc =3D=3D 0) {
> >                         bool merge =3D true;
> >                         int i =3D skb_shinfo(skb)->nr_frags;
> > --
> > 2.55.0.679.g6767b8d81c-goog
> >
>
> What about instead:
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b694904172cfa1d8e7bac7076b60cb24..b4237d0e994d6f9d754d21670=
23e3981a40b58f4
> 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1240,7 +1240,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> msghdr *msg, size_t size)
>
>                 trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
>
> -               if (copy <=3D 0 || !tcp_skb_can_collapse_to(skb)) {
> +               if (copy <=3D 0 || !tcp_skb_can_collapse_to(skb) ||
> +                   unlikely(skb_frags_readable(skb) !=3D !binding)) {
>                         bool first_skb;
>
>  new_segment:


This fix is much better and looks like it will work. FWIW I also
checked other call sites of tcp_skb_can_collapse_to like
tcp_should_autocork and mptcp_skb_can_collapse_to and it seems both
work as-is and don't need any changes. I'll rev v4 after the cooldown.
Thanks!

--=20
Thanks,
Mina
