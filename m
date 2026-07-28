Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A810F0
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197309; cv=pass; b=GPKVO+kUZdlUSvEh838JcYb+Ok2A2MDYTMXJJdXrsh3JDJsrgJ+gIaI+uS2MsKg67854btszkdarZPxC93QZZ3xK++r3Y42k/SZ2JM21i8uNrQNg9AYCq0TI/AwxSX0NSTfLUyKSgx3zXbEqawpYqZI1OjcCvjEte69J1L9btYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197309; c=relaxed/simple;
	bh=YNlF8a1o3epmZetRCjgDF5EO3Z7GUHs0IcIUsRJBabA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MguHURn0tPHVGEhfLo2hOpIVXYA3RjMZw9RWhYO9Jl0M0kB1rxms1qCjdVoR3NAE2+Z3TKqSarvpYK62wKvk4tcW07xV5uFuj20Q7jGU3AHk35NIYyjQ/CTVwgfJMuOCBiP+RhKwYdkviDZFXsa2blkI+4UWVInFAjUHJ1mYQNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2YAcAWo; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2YAcAWo"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c62764c7cso3402311fa.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197306; cv=none;
        d=google.com; s=arc-20260327;
        b=GIhkrtTYw7x+VcQYbWfAeWUVp0BTL8j4jXReRzxtn0Wez6jVoOVd8xORvh5YN/RzQz
         XInP8G5jzKgx+ZMALLllxWHkx6DckCaLo9EiDcGRuAqt+4Yl3xMCIwOcB75XHO9BQWRu
         NuACOgZa8QGkPYRDhjrCpAxALg8D/5aw71r+KMWR7xPB8rSmf0Y7+kR+HkJFtk7xrVgA
         aEAC7o3uCzKNGjetlW8Le60NHz7AvleJ3byJ8+aNdKTGBB3OmLuK7UCn2M50UkgJhflQ
         tpthQ8jmTc4g8hvnSqWy9Y5IY0NJqfG7qfhNBaFDrgfS31mrP4bZlCBKqsXIB/mX9sh8
         WQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OX5+Xiyuuua7ItSBWY1/1bwrYmd2boubaHGKa84wHQ0=;
        fh=bvcucw13I7OjsZopDXK/Hf2yt9Z195mxcEHlh9PSeVM=;
        b=BwhHjdtinU9QMscxVaklTrq9tAMY4PkiYGqrJPlDPpr0NXlEvxoThSGS8NODPhVbj6
         sv8DsPRDDnZluIGVFbYb+tzj7NV35Z3Pe3YJ6/UJfaHZt/gddRw6aQVNynU9kBol8aPU
         hNIhxiVITI/hxAMQ0Q1g0ltNXrT4CHyDSGDUoTNHSDkgbp8BAogteh5y+6DzDKeljOs/
         czj5qU5lypEJfPDseItnig87Q6sBYeNnMtn4tOfUaVlVwoUhjBnLIJamBHIrp8k4prn5
         zaxUbr8VNywBp2C6fLHWRvEYL06roumGRrQ0VFywWD8D0UnQ0FmHCJNrbRWonxeoIvtz
         k90w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785197306; x=1785802106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OX5+Xiyuuua7ItSBWY1/1bwrYmd2boubaHGKa84wHQ0=;
        b=g2YAcAWouoovhZFVFtWesBYYlsyWXZKVJcnQjR63aqShyrW0VVQWmPDHG5Oxpxv60G
         foUMe3AJ6VnlJYbQ6tMcQXGfd1ZUwS2axug86i5TD6t7RNgz+w7RQLy/xSKwt8hin+FX
         g+rM0fkqhZ46/SZVkZHBP6KUPftqgMlrIpgFP8wblq5i7FomicfwUoTp9dffX45bprWi
         iS4P6HD0XMsGUsSKanu6gmikpfJumyv3fec8PAQDIH9rnm9APN2GJjL0+WHQ6F/LEBif
         Xpms515PC7OART4z3tA0PhExW2fYn/TpWPOEv8fHHRoZZ6fK4pWjmSw/Ju/oZlpGwNNB
         SpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197306; x=1785802106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OX5+Xiyuuua7ItSBWY1/1bwrYmd2boubaHGKa84wHQ0=;
        b=O0Z7fsfkEvs/WE0EGIuuyr350VyLfGlIT4OftqwxS4p5/o8KAPwZtNm9xOyaau0a/v
         QjmWYvx5R9d+xv4pFzBsZp0lXWdHv8+5yTkfQi0l8hC7ObhR85WCVb2Ad2JNwOXzvh56
         aDgGEr6+dFfTjg+jIA5/UtPVnKCGInn6UIRx8HhtJDcYBPensXQr/uzXOps5YqxP0qIm
         TnEqy0+f+3aFp7nYFFGH/dmllfK+kTMhJb6FxdZuBWiZr7g9h9wxtrAfQpjSb40qBf1e
         1AfJ5XOqjDvgZjtOCz7LYK35mpJ7BNnCkQQt+dcWrMiYJA00eRKWJpuRnuj+W8QrWj0X
         Qa0A==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Klwt8XNR3UKVkg1+Fp9bziG/5UFJx0T8nIKDoPrKSCJTvvRjLZ0cztiK+Ju/EN5gC+Y+Lpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Bcvnw7Nsn4c0GEqIqQZG3P+f21jiKIXcrvRNdnx0692D8CFc
	dyMkdylDaHVRIVV/l6z6zGhnrpTobgd8r6VxpiHmI2xTKyi0/PAOfuaJ39wDkFNzQvMBh4QSaVp
	bPRwJxrKImeUozSjEzHcj34UT0pJups4=
X-Gm-Gg: AR+sD11vmng0Bp+TIGuXuzjBoT/pcNSSy958XmIFa5uIhlh2aHWkw/qCzg1Xw2ArrEt
	RTaEtfnPrQV0a3SGvyPq7Ql17TOHPHuIKXMdeI39mbqADMZpfc+DlVDn3V1SQJ9COA82bJ3JFTQ
	pNLKUVl1dX+/oSv/5dln7bqDCtPYCEyiRj5R443/nnTytbAbTNDTxtN97tew2MztRXlpek9n5rR
	L15Lxy+1O8k8XUEqpXAJRFZqEHxomGIZLJ6yxY9T2A0fnMb+AudtUSpyptg8NYBgrI9SYF95Sn4
	n01u2+QGdcU3EG6WMRxJfGGmaDyYBvjG1r20zFf7XxYZViukxggnNfhfyK+/b8HL/KaHqyPGH7Y
	=
X-Received: by 2002:a05:6512:b83:b0:5b0:1108:c58b with SMTP id
 2adb3069b0e04-5b2d0251425mr11802e87.15.1785197305751; Mon, 27 Jul 2026
 17:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725034246.192091-1-blbllhy@gmail.com> <amdJgi0V3YwWE7oL@boxer>
In-Reply-To: <amdJgi0V3YwWE7oL@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jul 2026 08:07:48 +0800
X-Gm-Features: AUfX_my7CVZAWJ_zY3gsLevRMQ883H5RL2tkawbZLRybomyRZyxwgSo7Orudwho
Message-ID: <CAL+tcoA8KPn7z3p7KymQLT4apwcaCy1Yi8P0S5KD-f91jxmwhw@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, magnus.karlsson@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Mon, Jul 27, 2026 at 8:09=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Jul 24, 2026 at 11:42:46PM -0400, Cen Zhang (Microsoft) wrote:
> > In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> > loop without checking its return value. xsk_buff_can_alloc() only
> > counts fill queue entries without validating their addresses, so it
> > can succeed while xsk_buff_alloc() rejects all remaining entries and
> > returns NULL.
> >
> >   Oops: general protection fault, probably for non-canonical address
> >    0xdffffc0000000000
> >   KASAN: null-ptr-deref in range
> >    [0x0000000000000000-0x0000000000000007]
> >   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
> >   Call Trace:
> >    xsk_generic_rcv+0x26d/0x5f0
> >    xdp_do_generic_redirect+0x3c5/0xcf0
> >    do_xdp_generic+0x92f/0xe70
> >    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> >
> > Fix this with a two-stage transaction. First allocate and stage all
> > buffers required for the packet, recycling all staged buffers with
> > xsk_buff_free() if any allocation fails. Only after this stage
> > succeeds, copy the data, reserve the RX descriptors, and release the
> > buffers in an error-free loop.
> >
> > Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx pa=
th")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> > ---
> > v2:
> >  - Allocate all packet buffers before reserving RX descriptors.
> >  - Recycle partially allocated buffers instead of only cancelling the
> >   RX producer reservations.
> > Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gma=
il.com
> >
> >  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f906d51b6699..383fc2b1de48 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct x=
dp_buff *xdp, u32 len)
> >       u32 frame_size =3D __xsk_pool_get_rx_frame_size(xs->pool);
> >       void *copy_from =3D xsk_copy_xdp_start(xdp), *copy_to;
> >       u32 from_len, meta_len, rem, num_desc;
> > -     struct xdp_buff_xsk *xskb;
> > +     struct xdp_buff_xsk *xskb, *tmp;
> >       struct xdp_buff *xsk_xdp;
> > +     LIST_HEAD(xsk_buffs);
> >       skb_frag_t *frag;
> > +     u32 i;
> >
> >       from_len =3D xdp->data_end - copy_from;
> >       meta_len =3D xdp->data - copy_from;
> > @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct =
xdp_buff *xdp, u32 len)
> >               frag =3D  &sinfo->frags[0];
> >       }
> >
> > +     for (i =3D 0; i < num_desc; i++) {
> > +             xsk_xdp =3D xsk_buff_alloc(xs->pool);
> > +             if (!xsk_xdp)
> > +                     goto err_alloc;
> > +
> > +             xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> > +             if (unlikely(!list_empty(&xskb->list_node)))
> > +                     goto err_alloc;
> > +             list_add_tail(&xskb->list_node, &xsk_buffs);
>
> could we use existing xsk_buff_add_frag() ?
> then I presume xsk_buff_free() would understand list and walk through
> xdp_buff's and free it ?

Good suggestion, but xsk_buff_add_frag() will add more irrelevant
stuff like nr_frags, xdp_frags_size, xdp_frags_truesize... They are
all happening in the softirq context. Refactoring the helper would
bring more work here.

Honestly, I like the local array which seems simpler/cleaner to understand =
:)

Thanks,
Jason

>
> I believe we could reuse pool's xskb_list instead of fabricating the
> on-stack variant here.
>
> > +     }
> > +
> >       do {
> >               u32 to_len =3D frame_size + meta_len;
> >               u32 copied;
> >
> > -             xsk_xdp =3D xsk_buff_alloc(xs->pool);
> > +             xskb =3D list_first_entry(&xsk_buffs, struct xdp_buff_xsk=
,
> > +                                     list_node);
> > +             list_del_init(&xskb->list_node);
> > +             xsk_xdp =3D &xskb->xdp;
> >               copy_to =3D xsk_xdp->data - meta_len;
> >
> >               copied =3D xsk_copy_xdp(copy_to, &copy_from, to_len, &fro=
m_len, &frag, rem);
> >               rem -=3D copied;
> >
> > -             xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> >               __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> >                                 rem ? XDP_PKT_CONTD : 0);
> >               meta_len =3D 0;
> >       } while (rem);
> >
> >       return 0;
> > +
> > +err_alloc:
> > +     list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> > +             list_del_init(&xskb->list_node);
> > +             xsk_buff_free(&xskb->xdp);
> > +     }
> > +     xs->rx_dropped++;
> > +     return -ENOMEM;
> >  }
> >
> >  static bool xsk_tx_writeable(struct xdp_sock *xs)
> > --
> > 2.53.0
> >
>
