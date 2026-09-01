Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF4483819
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282067; cv=pass; b=ldxnbf4ZI4NKvR15SWrewsE8IevoB1BKvhwZewa7qAD70Dix9+7FU0iGsCQlIZbAFpqoXsY8wxuhxlF9Kr7Wa5vJXwzj3JqRvbvTIKrazgUsPv5w2SBZThEH9vO1U6WlT9GQIuGaLL2Io8+c6X+7YGJvsnpaDaZO1zpgjW3FclE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282067; c=relaxed/simple;
	bh=y60todv1bO1so6BNVLy65/9o5Kqk+jqBfE/zfJ6uepM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxWfrphaccrbTC4YJTWmHyKiwfxyM6LjQdnfH9fC5A5Nl4+q729NAtAOoFilKZAe+gqTeBNsjRZxaZIqJtItnX1nOLAUIefj9NuLbXAHtnO6TsTBbAd8WK5riU6vE2gC/p3StMkad2AEXmMEXlEzio9lDSN5owKX4fyCmeEMtT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emg0/8G3; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emg0/8G3"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c08df8513so8616111cf.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 10:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282064; cv=none;
        d=google.com; s=arc-20260327;
        b=HG9QbdR5jJnPOUfb2dzJxyHULu6Hi1NNutt/GHe8bPcPbtpcwAdbOTQy8QFmi+fKqe
         cDQKf1Jq+zl6jEmKtJS/2J3BtxZCk+GFAYwTIp/HN5Q6MFDY3WqNoKljV399+SLYm7j2
         Q3ojT/5YStFLhfiCJqbLfeBsXikjJkM4dxYLLnzR8r5zWZTD18AhNFjGtwl61jSbJ9mz
         TyHmE8S6nrpPRmTmrtJJVl7XXusQROFC0H8UlPbOJL9bE4vtPLXP+c7QHvUitG2+hjbc
         rlBmx8C9ru39squmuXYBMNzp6wWjGl0ZI3IvbU/bI2MVUPzNsqWWSY6u1KbEWyh4+Uqd
         F9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s1/ZCsdiTwCzEbMiJAh1gYFpMDR8nIewwVwolMyvY+8=;
        fh=152bV1FI1984ZceXvT9t5tdAfQ8TV1aKprItsSeimHo=;
        b=K/Ax8jVrTv8VlIJ2vZCMq0kjViEM8YsT4fLgG7oSc1KnW9nOen94QgxD1WW6EO3cyF
         AhSKng2jNOMzZQeYQF+k/xIU0cmLiF3zBihtUyXQ+WquRiUJRlwLBygEO/JPptGvsp12
         3KUFrGEoDg1tf3aNRGXGDWwWDoKoblOlF4tKYoh2Eo/0iLUfrjr3TARZzGKRbst4Pzni
         Y88nkJV9ke1D9rVHeb8pjpdPas9zxgb1YI15CXdyw6o6srJZ/DhYEmGLZ0IIjIrKPHKd
         QZO/eW4nd9thP9WZhfFcGURmEuQwd7Lw6Zw1ZrCc8EyvY4cgzmNJe7JustXG1Z78VI/F
         9E0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788282064; x=1788886864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s1/ZCsdiTwCzEbMiJAh1gYFpMDR8nIewwVwolMyvY+8=;
        b=emg0/8G3yTZqzln/7yMv9coA/UMS+cs9U+HlPqWJPak9LTi7VAHIP7ZiV2nQZeVezG
         Ii0hcR1xShA9mW/stfjXEBOZdGh3LmGEFVTwekxfCI8rDzlSwmpLaA33NT6WDOTe2KgP
         dXefND62x3Gc58IbYwDW/juuynTKPQopOUO0/bX2+bYQQwuuXq1yRtRjHMgOZ2pS6nZv
         WlTMdbRvMwW7/QCU7HgA9srgu44QjDfXRdlgnEitxj0wY9OM8/fyEu/W7TxrFaycKURJ
         OMDICMWuLocxYp9NA3h4Wa3W/RFaRNBSzWmPgOPCep4wsujypEzdWqlb2RcnXrYYBKTP
         07WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282064; x=1788886864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1/ZCsdiTwCzEbMiJAh1gYFpMDR8nIewwVwolMyvY+8=;
        b=nGlhLGrigRbpQRg5XqWIvaCbZ65O4aDQgxJOhrUm/P9JXNGCe0J1wD/QtkbD1VyXmY
         bG6FWqFs4WvxWCM23mbM+Y4YJ3qLD6e/s+c5LQTh7kXoc5mHDoMAfNe9vd16boMzZJ2f
         eyfAE4tBApTRB9zzWaNgzklYZrVF/wScarlMd1520ash4IhUNc6C+WkPVT0osihsPFNo
         9IBDZMjAcNbCFRxu4rm3PbgWA+rzqg3TQ3LNo6mbCnpA3yZqFsw3t/67DbbBRQ0kHKtw
         8slyPow7aHJGfwg2uhTdvd8SDoTYv9SaNqMOL2bj1/XXe+Z/wOR7GaHzHynwd51PWNKm
         RSpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRECZEr/z503RP476v6mn3d4n2CutsB0BCUZYg4nzG38V+QEQevrFL4756DgH4wltNHN3+poY=@vger.kernel.org
X-Gm-Message-State: AFuF++mCZqo4Pq63iUt6BP+4PfBYnMmS9cAGRDdZoYhVExZV3uf+Nmhq
	vO1erimbH9+GPqd6sK9JfH7yCZ+Yp0K699UyWIXUIKO+s1wtoZVFXz6U+oyEk4MHJaUMI+m/WUb
	VCKpivTQiWqHCAtTsGM4CoI++q+LLqIygcgpkodTWg8uSCQPhctQBi1STdWg=
X-Gm-Gg: AR+sD10v29sPQD4BTl/QDe3EbbmzUIGFEJhiIqo9aYhJxtY9Pcpi8JmUOELxJqajImi
	zoU5mP1Q5fitLm1+ndncXBNaQGDJOD60yllGruyyjqrBVwcgrtON9mfrAbRT7LCpUEW8QYKR46Y
	JHOVQsfcm4276Nt2uYRbSu/0Q+PePvGtoXPp1QZn/1DKRVW89bZAeER8eeXOJ9bE4DncR4dymTI
	WDBISqpWYZOVjn2Z7S0uf7O4KaMPkaLGIZOF6AhvLXsuuS+USAUyOImB26ZVZzFvmCEUGkfkTky
	rcfL/pcbjVLV+qc0leTfx+7iGDJNwDVlmg25jnTDwf6K0iHkj0xMG3WJRGfLlt+gb77ypuqqseV
	/az6PKBdiDTzWmrTeOfRkOD4ApaBcJSEn1uPEMiCWHAq3HwswKrVZOjv58w==
X-Received: by 2002:a05:622a:4815:b0:52e:22f3:80cf with SMTP id
 d75a77b69052e-52fb96924d5mr502871961cf.32.1788282063163; Tue, 01 Sep 2026
 10:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831095952.3385596-1-edumazet@google.com> <55aad0c8-6409-4c4a-846a-141ba12add4d@redhat.com>
In-Reply-To: <55aad0c8-6409-4c4a-846a-141ba12add4d@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Sep 2026 19:00:51 +0200
X-Gm-Features: AcwNN1Wneq8f33W8xh6e9_6ReqEtXDeaBgb6Tzr1BOzE4k8AembZBBM5KNFGlH4
Message-ID: <CANn89iK+RvAVvARfJChV-AgKtF2KVTd-MRGBfRCy24N3GBCAzw@mail.gmail.com>
Subject: Re: [PATCH net] net: fix use-after-free in pskb_expand_head()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com, 
	syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 3:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 8/31/26 11:59 AM, Eric Dumazet wrote:
> > pskb_expand_head() and pskb_carve_inside_header() decide whether to dro=
p
> > the old head gracefully via skb_release_data() or directly free it via
> > skb_free_head().
> >
> > Blamed commit replaced the check against dataref =3D=3D delta with skb_=
cloned(skb).
> >
> > However, skb_cloned(skb) masks out the upper 16 bits (SKB_DATAREF_SHIFT=
)
> > of dataref using SKB_DATAREF_MASK. For an skb with nohdr =3D=3D 1 or a =
clone
> > referencing a shared buffer where only one regular reference exists,
> > skb_cloned(skb) evaluates to false even when dataref is shared with oth=
er
> > skbs.
> >
> > When pskb_expand_head() is called on such a buffer (e.g. during bridge
> > flooding, generic XDP, or VLAN tag insertion), it falsely assumes the h=
ead
> > is unshared and calls skb_free_head(skb) directly. This drops the under=
lying
> > head/frag reference immediately, while other clones or references still
> > point to it, causing a use-after-free in subsequent packet processing.
> >
> > Introduce skb_dataref_bias() and skb_data_is_shared() to accurately tes=
t
> > if dataref is shared by checking atomic_read(&skb_shinfo(skb)->dataref)=
 !=3D bias.
> >
> > Use skb_dataref_bias() in skb_data_unref() and skb_data_is_shared() in
> > pskb_expand_head() and pskb_carve_inside_header().
> >
> > Fixes: 3e24591a19bb ("skb: Drop "fastpath" variable for skb_cloned chec=
k in pskb_expand_head")
> > Reported-by: syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6a954e27.4d659fcc.734b4.0046.GAE=
@google.com/
> > Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D128e9f5a0f85a51215b1
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/skbuff.h | 13 ++++++++++++-
> >  net/core/skbuff.c      |  4 ++--
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 421f6fc454511ea6c7b83d5227481840a7c4bcc0..efeef148e1ba50cbb0d4809=
75dc6c3c59acb98c7 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1295,6 +1295,11 @@ static inline bool skb_unref(struct sk_buff *skb=
)
> >       return true;
> >  }
> >
> > +static inline int skb_dataref_bias(const struct sk_buff *skb)
> > +{
> > +     return skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
> > +}
> > +
> >  static inline bool skb_data_unref(const struct sk_buff *skb,
> >                                 struct skb_shared_info *shinfo)
> >  {
> > @@ -1303,7 +1308,7 @@ static inline bool skb_data_unref(const struct sk=
_buff *skb,
> >       if (!skb->cloned)
> >               return true;
> >
> > -     bias =3D skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
> > +     bias =3D skb_dataref_bias(skb);
> >
> >       if (atomic_read(&shinfo->dataref) =3D=3D bias)
> >               smp_rmb();
> > @@ -2019,6 +2024,12 @@ static inline struct sk_buff *skb_get(struct sk_=
buff *skb)
> >   * If users =3D=3D 1, we are the only owner and can avoid redundant at=
omic changes.
> >   */
> >
> > +static inline bool skb_data_is_shared(const struct sk_buff *skb)
> > +{
> > +     return skb->cloned &&
> > +            atomic_read(&skb_shinfo(skb)->dataref) !=3D skb_dataref_bi=
as(skb);
> > +}
> > +
> >  /**
> >   *   skb_cloned - is the buffer a clone
> >   *   @skb: buffer to check
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 966af3beed94d0a9f0387cec70b5297eccfcf19f..f4c0645f98d3f2f0c876540=
3e0184769e928d7b0 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -2331,7 +2331,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhe=
ad, int ntail,
> >        * is not we can just drop the old head and let the existing refc=
ount
> >        * be since all we did is relocate the values
> >        */
> > -     if (skb_cloned(skb)) {
> > +     if (skb_data_is_shared(skb)) {
>
> I'm sorry, I can't wrap my head around the above change; I have similar d=
oubt WRT
> the sashiko reported one:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831095952.338559=
6-1-edumazet%40google.com
>
> that is: I can't see when the new condition yield different results from =
the
> old one. Could you please describe exactly the bad layout and were/how it=
 is
> obtained?

Hi Paolo,

Here is the exact state layout and sequence where the old and new
conditions differ:

1. The Layout and Values

Suppose an sk_buff is marked with __skb_header_release(skb) (e.g. in TCP
or skb_gro_receive()):
- skb->nohdr =3D 1
- dataref is set to 1 + (1 << 16) =3D 0x00010001

Now a clone is created (e.g. in br_flood() via deliver_clone(), packet
socket tap, or veth):
- __skb_clone(clone, skb) sets:
  - clone->nohdr =3D 0 (clones always have nohdr =3D 0)
  - clone->cloned =3D 1
  - skb->cloned =3D 1
  - dataref becomes 0x00010002 (or remains 0x00010001 if
    __skb_header_release() was called during GRO on an already-referenced
    buffer).

If a clone or sibling drops a reference via skb_data_unref() (subtracting
bias =3D 1), dataref returns to 0x00010001.

Now we have a clone "clone" still referencing this buffer with:
- clone->cloned =3D=3D 1
- clone->nohdr =3D=3D 0
- dataref =3D=3D 0x00010001 (1 TCP/GRO payload ref + 1 clone ref)


2. How Old vs. New Checks Differ on this "clone"

When pskb_expand_head(clone) is called (e.g. pushing a VLAN tag in
validate_xmit_vlan or in generic XDP):

* Old condition (skb_cloned(clone)):
    skb->cloned &&
    (atomic_read(&skb_shinfo(skb)->dataref) & SKB_DATAREF_MASK) !=3D 1

  Evaluates:
    0x00010001 & 0xffff =3D 1 -> (1 !=3D 1) -> false

  Because it evaluates to false, pskb_expand_head() took the else branch
  and called:
    skb_free_head(clone);

  skb_free_head() immediately called put_page() / kfree(), freeing the
  shared head buffer memory. Meanwhile, the original skb (in GRO / TCP /
  bridge) was still referencing that buffer. When that skb was
  subsequently accessed or cloned, KASAN reported a use-after-free.

* New condition (skb_data_is_shared(clone)):
    skb->cloned &&
    atomic_read(&skb_shinfo(skb)->dataref) !=3D (skb->nohdr ? (1 << 16) + 1=
 : 1)

  On clone, clone->nohdr =3D=3D 0, so bias =3D 1.
  Evaluates:
    0x00010001 !=3D 1 -> true

  Because it evaluates to true, pskb_expand_head() takes the if branch
  and calls:
    skb_release_data(clone, SKB_CONSUMED);

  skb_data_unref() subtracts bias =3D 1 from dataref, leaving the memory
  intact for the other SKB.


Summary:
For an SKB with nohdr =3D=3D 1, both old and new checks return false when
dataref =3D=3D 0x00010001 (the TCP fast path). The difference occurs on
clones (nohdr =3D=3D 0) sharing a nohdr buffer, where SKB_DATAREF_MASK
previously masked out the upper 16 bits and caused skb_cloned() to
falsely report false.

I can send a V2 with more details, or perhaps this reworded version:


pskb_expand_head() and pskb_carve_inside_header() decide whether to drop
the old head gracefully via skb_release_data() or directly free it via
skb_free_head().

Blamed commit replaced the check against dataref =3D=3D delta with skb_clon=
ed(skb).

However, skb_cloned(skb) masks out the upper 16 bits (SKB_DATAREF_SHIFT)
of dataref using SKB_DATAREF_MASK. When an skb is headerless (nohdr =3D=3D =
1),
its dataref is initialized to 1 + (1 << SKB_DATAREF_SHIFT). For a clone
created from such a buffer (where clone->nohdr =3D=3D 0), if dataref is
1 + (1 << SKB_DATAREF_SHIFT), skb_cloned(clone) checks:
  (dataref & SKB_DATAREF_MASK) !=3D 1 -> (1 !=3D 1) -> false

Because skb_cloned(clone) evaluates to false, pskb_expand_head(clone)
falsely assumes the head is unshared and calls skb_free_head(clone) directl=
y.
This frees the underlying head/frag memory while the original nohdr skb
still references it, causing a use-after-free in subsequent packet processi=
ng.
Introduce skb_dataref_bias() and skb_data_is_shared() to accurately test
if dataref is shared by checking atomic_read(&skb_shinfo(skb)->dataref) !=
=3D bias.
For the clone, bias is 1, so (0x10001 !=3D 1) correctly evaluates to true.

Use skb_dataref_bias() in skb_data_unref() and skb_data_is_shared() in
pskb_expand_head() and pskb_carve_inside_header().
