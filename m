Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FA30D406
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285516; cv=pass; b=QC4VND7noGABiV5nHGJZpJCDPyA23EkiI75ADHIkPGHVxxhJPHDIvLt+H0EWZElW3iwpssh56gWPdAP5tXWu9gmM1HlJ8b4AbmSmqmCeNcHwBhSBVELoR7ZM8eE0IGaVy5n5xrsZTWJJMh2qgRASrjS64zdNaG2hzELtt/T402s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285516; c=relaxed/simple;
	bh=R8vIX/Z1NY1DlwRJGpSZ8SxWKDUiLCaYuvuQmzoTLIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGp0e2acLqqSATMDWacBZKZfWrczLt/jYv1T3WrLhUOBc0hl369bA4DUkqHX3H2KgvJxJ/YzX+zZqfstaJrTaqdBfL9f2FcHgbuIEM2iO/7nRPMUPV+Ki1wOR3WZ0tD4Pgm2saUtkHw//OhdHfX66DnZScQk6WFd7G52knVHTnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM8LJ/oT; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM8LJ/oT"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so2968201fa.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 17:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785285513; cv=none;
        d=google.com; s=arc-20260327;
        b=M7N7NGer82f4euqlblezuoxpAZY1SRzAs9NXXuaC1//bLAGZaApmFTJdLPZe1kCr9A
         RLUzm3i0LKDlSG+qNuHRJB25DIw6TSVbSxig9YdnBV2p88xsYu3ifyJhAhWRRb+wVnS7
         BXDgHMxxwUPw9fB1hjw2UJcviZh2C1kufcM65MCaZC26EWOJyCkf+hbo8m8v1SBTqYr+
         +Vq26NVX+1GA5KsEmjkNwjVZzWH5RKjp7VNeQBj+PC6GNei6nYTwLjgVf7N4jnMzomlm
         5NxLmtt1RWtkcHNaSoaExZzHKjwPUXPA4wXtqOtiD2+2CfI1BoD95PSATmJKepTpZHMw
         Wl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4grsxtv+TIextceZxAsoUmosB6zZxLcgcMyGKRmfnRI=;
        fh=GMFX+cYl8tyUEimnLIFhnO/0ZwtpmlrY3iQZmLR+p64=;
        b=rjMS28NiW2pYXZp00SOa55D21L3Z5//Mep1G6/LlBbDDidg2/wKnKJUMj8IXKe9oMV
         WRFs8NJALLV3blKNyxIyYYM2UhIuaznzPmNqkCQvW0MIeSOBHRA5MFXCo544QOp1fZok
         DtIgoa8b4uQ+fZCBjB2qKYkV9WCjXBvTRgv2T8y2ZDcEGNFLupnkHZWXP5P0aAmTqS4w
         Z5GlMVSNtscthod/EVghBgEfNjiA0UdOy6+whBgBRqkZBI2jtksSZAQ1lIFi/nQ9VYA+
         tUEJ9FEyRYh8GvZyT3tAvGXEqyfa1udjfAeayVNZiuNTBz2Iw4m3z0EdoXdq/OyJS7+k
         A1cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785285513; x=1785890313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4grsxtv+TIextceZxAsoUmosB6zZxLcgcMyGKRmfnRI=;
        b=kM8LJ/oTy9wsR6Bqy4qKnnYbNvjEl92FZcjvrX4d1nTMBRp28KflRXMoomEhZaMBGH
         f4Ednt5Kewym3/hDNQfD8W89hGo6VPiL9tqAj4y2AzABKUzWHXGEB1auGjxOGmQej8RQ
         uLhLr1AeUiNuccWcoSCIUzML755msuwkufk52GiVkn8WzO9SS6+TQl41alpclVc+pYTK
         SGejwM8J4+pgdw4fKA43clZunEHK5lL7c6AlIkPPDsVBlySTJBiq6tExpsR4lmBG1Pq/
         2nrdOCzkVO+qTKLlII6s6W1EhthpTIbtbTNc/oa0XQHl3wiROnIdqjBf3mjqxCA/EYDa
         qswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785285513; x=1785890313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4grsxtv+TIextceZxAsoUmosB6zZxLcgcMyGKRmfnRI=;
        b=e8cAsh1996E/CI1lJkupRqaK09LmCvTfIbmkwmK3kYqbGVEHFWfSy+fqbjp9FX88E2
         HxIZGjJxwF8QLH8z+nCZfhdkvf4EnLGLQASuNTSTJ+TmIIeGzrHGMVMtREErpC++qech
         68RHg2TjorQQZfKGflMT9RtI9LhGaZMAjGZ3jm8Dm/O5yDi24lRhSERxdS1kcnXinQrV
         ntho97/APzGEGBhWMnFdPo6V2LEHL9eLr4Td6V0Q5SWf+7CNVxSpBJE1whovwrcvNC0n
         vYDj3io7V3L05ggwO6Zg3NdzgYU33lz8YVtaH5ZVpFyD7T22YZtFKwg18Hhmp/tCSj2J
         hpKw==
X-Forwarded-Encrypted: i=1; AHgh+RotDjr3vl8aqlAL1bCcJ9iRc35NJB8Iv6SNZpP2yZqAH5b8GMRjTPPP1/J4+Wo9v8oJZ1jNRJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GKEaRGic2zbZh1Usl4vf/BvfQAI5emn0gVY5vlY9bZME5v6E
	AIQ/zP/2C09qpq1RKZB5MWPAjunlwC79z8mPBQJH9xY3kOEeNfIhbUQDG+29mCA+gEkIwKXukEj
	oeeDum3sJvErJZRP5YOoNBW0k9kYAAiw=
X-Gm-Gg: AR+sD11E5dalGuJ+B9eE+axZl9De/LJ5KP7WamUTFLNejeWYas0uDq6wgrcSNyy7X8k
	LlRjcvluyAZktzFSSqT+d+G6SQGKl9nBZ8EFnbrtVgMc3tnlDp/Xehg8g62QuRK9uP7GKB1S4GT
	ZUzscLUr50zqKNBp3a+LWtScikvANOrLNadIZrEbjzAud/A/hMLL6vjsRcelanAHqVCj/caUyzC
	6dYPOzbJqt8ZC36766NpZJZZXMZ6NLeEp3R9NZTTYcLzc2VXNFFCcBtHHHUvvJBA0b4dsavxvuU
	3LcfdXdx03MbkuPZUzWuAzRYZfbpX3/31gbnpapgqJk9JzNzNf8PvIrrEp+4OrC4k91TlsbcUDR
	rjvE9/cHXLB1VHbysmHFEoW5d2oeNsbosD9EjrQbPCQ4EJvhkpaxP4hkk4Q==
X-Received: by 2002:a2e:a589:0:b0:39b:da8:cc3d with SMTP id
 38308e7fff4ca-39f51e67e26mr8711691fa.22.1785285512823; Tue, 28 Jul 2026
 17:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725034246.192091-1-blbllhy@gmail.com> <amdJgi0V3YwWE7oL@boxer>
 <CAL+tcoA8KPn7z3p7KymQLT4apwcaCy1Yi8P0S5KD-f91jxmwhw@mail.gmail.com> <amiTZFpTTx7jHurQ@boxer>
In-Reply-To: <amiTZFpTTx7jHurQ@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Jul 2026 08:37:54 +0800
X-Gm-Features: AUfX_mwbM_fosJ66ZUtgkY2kxJaMAIfKN35cjTfxijqyZduCi_Z7AAyJm0iJpzY
Message-ID: <CAL+tcoA5BV4kbvU5drKD8N4Hwg=gQ9z0oSa4UQtN=FaOtM3KRA@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, magnus.karlsson@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 7:33=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Jul 28, 2026 at 08:07:48AM +0800, Jason Xing wrote:
> > Hi Maciej,
> >
> > On Mon, Jul 27, 2026 at 8:09=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Fri, Jul 24, 2026 at 11:42:46PM -0400, Cen Zhang (Microsoft) wrote=
:
> > > > In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in=
 a
> > > > loop without checking its return value. xsk_buff_can_alloc() only
> > > > counts fill queue entries without validating their addresses, so it
> > > > can succeed while xsk_buff_alloc() rejects all remaining entries an=
d
> > > > returns NULL.
> > > >
> > > >   Oops: general protection fault, probably for non-canonical addres=
s
> > > >    0xdffffc0000000000
> > > >   KASAN: null-ptr-deref in range
> > > >    [0x0000000000000000-0x0000000000000007]
> > > >   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
> > > >   Call Trace:
> > > >    xsk_generic_rcv+0x26d/0x5f0
> > > >    xdp_do_generic_redirect+0x3c5/0xcf0
> > > >    do_xdp_generic+0x92f/0xe70
> > > >    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> > > >
> > > > Fix this with a two-stage transaction. First allocate and stage all
> > > > buffers required for the packet, recycling all staged buffers with
> > > > xsk_buff_free() if any allocation fails. Only after this stage
> > > > succeeds, copy the data, reserve the RX descriptors, and release th=
e
> > > > buffers in an error-free loop.
> > > >
> > > > Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on R=
x path")
> > > > Reported-by: AutonomousCodeSecurity@microsoft.com
> > > > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > > > ---
> > > > v2:
> > > >  - Allocate all packet buffers before reserving RX descriptors.
> > > >  - Recycle partially allocated buffers instead of only cancelling t=
he
> > > >   RX producer reservations.
> > > > Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy=
@gmail.com
> > > >
> > > >  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
> > > >  1 file changed, 26 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index f906d51b6699..383fc2b1de48 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, stru=
ct xdp_buff *xdp, u32 len)
> > > >       u32 frame_size =3D __xsk_pool_get_rx_frame_size(xs->pool);
> > > >       void *copy_from =3D xsk_copy_xdp_start(xdp), *copy_to;
> > > >       u32 from_len, meta_len, rem, num_desc;
> > > > -     struct xdp_buff_xsk *xskb;
> > > > +     struct xdp_buff_xsk *xskb, *tmp;
> > > >       struct xdp_buff *xsk_xdp;
> > > > +     LIST_HEAD(xsk_buffs);
> > > >       skb_frag_t *frag;
> > > > +     u32 i;
> > > >
> > > >       from_len =3D xdp->data_end - copy_from;
> > > >       meta_len =3D xdp->data - copy_from;
> > > > @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, str=
uct xdp_buff *xdp, u32 len)
> > > >               frag =3D  &sinfo->frags[0];
> > > >       }
> > > >
> > > > +     for (i =3D 0; i < num_desc; i++) {
> > > > +             xsk_xdp =3D xsk_buff_alloc(xs->pool);
> > > > +             if (!xsk_xdp)
> > > > +                     goto err_alloc;
> > > > +
> > > > +             xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, x=
dp);
> > > > +             if (unlikely(!list_empty(&xskb->list_node)))
> > > > +                     goto err_alloc;
> > > > +             list_add_tail(&xskb->list_node, &xsk_buffs);
> > >
> > > could we use existing xsk_buff_add_frag() ?
> > > then I presume xsk_buff_free() would understand list and walk through
> > > xdp_buff's and free it ?
> >
> > Good suggestion, but xsk_buff_add_frag() will add more irrelevant
> > stuff like nr_frags, xdp_frags_size, xdp_frags_truesize... They are
> > all happening in the softirq context. Refactoring the helper would
> > bring more work here.
>
> Fair enough, how about we meet in the halfway?
>
> Don't use xxx_add_frag but reuse pool's list. Reason I'm pushing for it i=
s
> xsk_buff_free() has been thought to consume multi-buffer xskb's, so all
> the list-walking would be hidden and error path would only consist of a
> single free() call.

It does make sense (reusing/developing common helpers is always a good
way to go). Side note: maybe Cen needs to handle
xdp_buff_set_frags_flag() to allow xsk_buff_free() freeing a list of
nodes.

>
> then the do/while loop while iterating could be using xsk_buff_add_frag()

But I don't get it. Sorry. Are you saying we still need to call
xsk_buff_add_frag()?

Thanks,
Jason

>
> >
> > Honestly, I like the local array which seems simpler/cleaner to underst=
and :)
> >
> > Thanks,
> > Jason
> >
> > >
> > > I believe we could reuse pool's xskb_list instead of fabricating the
> > > on-stack variant here.
> > >
> > > > +     }
> > > > +
> > > >       do {
> > > >               u32 to_len =3D frame_size + meta_len;
> > > >               u32 copied;
> > > >
> > > > -             xsk_xdp =3D xsk_buff_alloc(xs->pool);
> > > > +             xskb =3D list_first_entry(&xsk_buffs, struct xdp_buff=
_xsk,
> > > > +                                     list_node);
> > > > +             list_del_init(&xskb->list_node);
> > > > +             xsk_xdp =3D &xskb->xdp;
> > > >               copy_to =3D xsk_xdp->data - meta_len;
> > > >
> > > >               copied =3D xsk_copy_xdp(copy_to, &copy_from, to_len, =
&from_len, &frag, rem);
> > > >               rem -=3D copied;
> > > >
> > > > -             xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, x=
dp);
> > > >               __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> > > >                                 rem ? XDP_PKT_CONTD : 0);
> > > >               meta_len =3D 0;
> > > >       } while (rem);
> > > >
> > > >       return 0;
> > > > +
> > > > +err_alloc:
> > > > +     list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> > > > +             list_del_init(&xskb->list_node);
> > > > +             xsk_buff_free(&xskb->xdp);
> > > > +     }
> > > > +     xs->rx_dropped++;
> > > > +     return -ENOMEM;
> > > >  }
> > > >
> > > >  static bool xsk_tx_writeable(struct xdp_sock *xs)
> > > > --
> > > > 2.53.0
> > > >
> > >
