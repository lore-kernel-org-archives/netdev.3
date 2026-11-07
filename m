Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794058883;
	b=UvCl7XkAY1UBImD0xfHN+PALut2e5HnD3tOT4T+BieIVExwnZTrg1+oZuCll0UH677na
	 cKwgYqJJYn+sbXA5Vm9zoabE1XRusnKfcHLWeSAiN0l88FVhACNETkL0Wu6WxlE6ypgal
	 XnCX+P6OULVPDzTFhuy7GsZAKiHQiou5lAcWbCbdT1Iv09iVDIit/E5gILo/i6P66/LQq
	 nORM+Ok758qrZB/TtmTyJlACtJpVOKqTuAldb/9ypmdDRfj/D9sUBvX339U458rTfhmCi
	 6q9bZWTPAPkQmWiVWaou5+LfLelCRhUAIz5c3TrA6ST8fRnboPLjS5ivr0CUYZSkVqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gFu9cBDaata/nEmYtOPDFMK1VmLefD8wqznSXlq1hIo=;
	b=Rf+JI6mCdzaz/qwD78lCA8jIrNmNzqEzVLB1vd9DXhqPhTsLmcpEi8fXEkUp2d+kU7F9
	 PHROpHqvKHIThRoVDnYlwl8GtjbzNLDMYh8bxkLPe5GAw0S0W/Z1jquxlneNv605wLdFM
	 epqXP2B/PeHTLbtOxFh3y96z0Ba5DAWnQRDXcKSFw9pLavMntv9ZCJy6yOfEhNKvekqoP
	 VCCyuKGrGSjXiF0T/JsKMF1Zs/24gsPWqcZhMyLs0nbFnZzdwFiBssvi0D8t3iYLyt/de
	 4yoC/cj0jFibvjoS2YCCMZxARoa1n5d8rLAUgQdeUrU13bl6BU7cw54hyKHhY1zUbrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cwIJWBVz;
	arc=fail smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A3606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 13:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 512A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cwIJWBVz
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso4900a12.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 05:41:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794058881; cv=none;
        d=google.com; s=arc-20260327;
        b=ooF1UP4xH//Snbh3C8qOZu/z4+5FBTD2QFFTMSRoGNsHGXfD0NzEVNPelCrXbjW6q4
         YCVmYOPEBF8VEkFprrxm06vUxRGsca99O0gs/5cX2EiRYgYP4oBi2QM2s8zStJv3eBBB
         7sUd7BHBL7QZA7nzpUPykrxWSZP9dVkIM3QJpXxcJdh/nxLEgGY74sCyhVhWcI8Ce2sa
         xgbNmXgQj6JN+imDHOJV8YzG/MDrgKVDMgYyIZEoPlcL+4fNx8B14pPEMKvR6enz7TCY
         86HtOu52R+yPQoSHpAeF10m0Zar+a0U6fscy71B+ofAj+BztXC/KnyuIjD2GWYmI0bbv
         merg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gFu9cBDaata/nEmYtOPDFMK1VmLefD8wqznSXlq1hIo=;
        fh=dmg5RplInHVIem2Q1PFQ8KOGqwCBKEG5zDSHnT3OHks=;
        b=AqYX61IO5DY2VVi7xpv7TBkI/XtFjpuRYk4M8yyXtjmcXW/pNJkFZmNUjb3bpNUSUg
         5IkBidotR1rKQyjWNOPJ+lvJQ+HNB4wjrbJ8ckiM4dctOBW3/1JaZL6HF2yIaCrKfyfu
         sEmNAQTl0pBUqxhovVUPwwcrCUc0/bJ7W99L5zwgUP3yP+z5niO2vy+yQTR7u1ZyDj0T
         ThhZJgcH4AZjcjg426sJO5qkj5iWG8ZoGhntCbkI4Jtar2LGIiL0JfcmlpS+RDhsm5Ky
         C+2s2D2jA705To5VbTf3qhsMlPNC4J4TSjWqwWi/ZTLhZAEz6hKzyMYkAwFePQhiUI5j
         lKfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794058881; x=1794663681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gFu9cBDaata/nEmYtOPDFMK1VmLefD8wqznSXlq1hIo=;
        b=cwIJWBVzaVjDEO7O/K1WAOpL7ECtiOwC9amY11IPTmJ3vrwDqBIODUc6/YmcE/tn+k
         3gSlQHEmA989m//74xxI8oZQf8Jo0QcEENBedwFceU0d/p1uUMNFJ26qG2Xj5WkPN6dO
         VENEbTGNed08YETICjDtiv8RqcrbaDpllc7yhn3IlZpL7cZVHzrWywFlUBkYIxxYyWWS
         kO4gy37wBkrcZVUVPsFBFkybb18gQ7Kcy7scihDsw6nEAKCcZOcAZRqYpbUqMHXGFg3s
         j9I+/SdNxTdMlnVuWF+iGwBHN44gmXK2NtaRk2crQr+B9rOCnWFs9y2REZYGxhrEeJCN
         0DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794058881; x=1794663681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFu9cBDaata/nEmYtOPDFMK1VmLefD8wqznSXlq1hIo=;
        b=gmFKvkRv0nNCyYsuavmmxCa/x4+pPEIwyE2vGEOwNeDSOQaSOjUTnF7lJHbFSSWki/
         rjpVM6OV//dxasQrrTRjPke4eojpsvS5Z3Say5XthZc5HLTD4v3hQAbgHfArtnJ5kSte
         nlO+rwct/AM93qh6HCNHWNHZnsVAR1me0AHU0Rd152TOkNGsnQkhgcsVJsNA1kBNJZ/O
         Z1da3KJQKKLywYl+wHtsOtpdMBfO9SWS38Lx/DBN2KBBnYRz/WHKqTWmubw/F6onDLsM
         FoK0Ic3wzt7C5nkgMBk6EAWbz+3dI71qIh3f+L0D8OG7vuXzEb6TKTQB3pNMx/y1wB3L
         9MVw==
X-Forwarded-Encrypted: i=1; AL+hErELMlwwgbVubScpIjCokO21gi8+t6/GGBbHXh+CTOfCdFt2sss/UKEuz5fymlIoup+4okbk8Zg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UbLOJsi/pBpM7ZN3arWD+tU1GuncZqS7BozxGoV5vML/EtxI0
	qOVmwcRyyojdpRaTWz69k+dcVNVqmA1Gn+9Ff30zjO04ANvxclZamCJXm5bvFiGKRFYiy40KR6g
	WWao77JwN/WPiUTfl+bRucqRVjxHsgOWDJHFrAHtt
X-Gm-Gg: AYBFou1uPIRXnfsqicH+rh3/thAZJRBTsDNGeeeBa4HgFqhkqz+KLxALZ9VuOeAh9Is
	2iwaC5QElNy0X2ABf1mQuNbidoc+1ieQtM5eLW5rzLGykgnXNvwQcQ4nNwipXx9eyg0iappB0Id
	zmEs9Slj2j07voyvpMalMYR2wEb8UepJuFCjhK7bj9QeFzFZ1/BtR4d+ADa3Mh8nkm+4iymrbNk
	EDMEChwAcnVq0IM3MrL3zn8JGuVjQPSL2TIztgyn2aR2BBIJ3Uf3GE6QRt2Bxqh1Dlk5e7Xb5y4
	HdRjypq5gU+RWuq1LmPTkNTQdNSTIeHgvF+Y9PpoxxbBvwxVfC+fK/CFyc4RG8GYswigGWc6Uds
	FMPxCMmdrNLbYe4TnurSepj5seqkJJC7b0n6I
X-Received: by 2002:a05:6402:52c5:b0:6b5:70c1:650c with SMTP id
 4fb4d7f45d1cf-6b6fad0aa01mr52745a12.4.1794058880853; Sat, 07 Nov 2026
 05:41:20 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104042521.3979880-1-almasrymina@google.com>
 <20261104042521.3979880-3-almasrymina@google.com> <auy0aaY0-g32aYi9@devvm16445.scu0.facebook.com>
 <CAHS8izNrM+iaT6OOJVoZdVp00TkNRhFe9ucCVrwaUWL0oQS7Ow@mail.gmail.com> <au5SPWdVCuso8Esq@devvm16445.scu0.facebook.com>
In-Reply-To: <au5SPWdVCuso8Esq@devvm16445.scu0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 7 Nov 2026 05:41:08 -0800
X-Gm-Features: AclHuK8cj889GX7mHOiPklNdo7pHPkUF0C-SJejhfCxDe2De9Vg3dflK0Ya2AKE
Message-ID: <CAHS8izNXwhTybUHk3Zkh-cmp9CXz2m9kXt-NoB2huu5co1rGAg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: prevent mixing frags from different
 memory providers or bindings
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 2:22=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 11/06, Mina Almasry wrote:
> > On Thu, Nov 5, 2026 at 8:59=E2=80=AFAM Stanislav Fomichev <sdf.kernel@g=
mail.com> wrote:
> > > > +static inline void *skb_net_iov_provider(const struct sk_buff *skb=
)
> > > > +{
> > > > +     struct net_iov *niov;
> > > > +
> > >
> > > [..]
> > >
> > > > +     if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
> > > > +             return NULL;
> > >
> > > (a few nits/questions)
> > >
> > > Why !skb_has_net_iovs is not enough? (and if !nr_frags is required,
> > > maybe fold it into skb_has_net_iovs?)
> > >
> >
> > Well skb_has_net_iovs only checks skb->unreadable, which is not
> > actually enough. The skb doesn't necessarily have net_iovs if it's
> > unreadable, it technically could be that it has no frags, right?
> >
> > Technically we should never have the edge case where
> > skb->unreadable=3D=3Dtrue && skb_shinfo->nr_frags=3D=3D0, but I don't t=
hink
> > the code is careful about that today, and I don't know that I want to
> > do a global refactor everywhere we remove frags, which skb-> flags
> > need to be updated.
> >
> > but you're right that it can be folded.
>
> Not sure I'm buying that, but happy to look again if you disagree. I thin=
k
> the only way to make an skb unreadable right now is to add at least
> one niov frag? Don't think this is (ever?) gonna change? What does
> and unreadable skb without frags even means?

I have no doubt that we set skb->unreadable correctly when we add an
unreadable frag. I have doubt that we unset it correctly when we
remove the last unreadable frag (or we do it correctly for other skb
flags like pfmemalloc). If you can trust it, my LLM confirmed my
suspicion:

```
  1. skb->pfmemalloc is NEVER cleared (or recomputed) when nr_frags
becomes 0 on an sk_buff=E2=80=94and isn't even propagated in skb_split() /
skb_shift():
      =E2=80=A2 None of ___pskb_trim(), __pskb_pull_tail(), skb_split(),
skb_shift(), skb_condense(), gro_pull_from_frag0(), or
__pskb_trim_head() touch skb->pfmemalloc.
      =E2=80=A2 Why it's fundamentally broken to just clear skb->pfmemalloc=
 =3D
0 on nr_frags =3D=3D 0: Unlike struct xdp_buff (which has a separate
XDP_FLAGS_FRAGS_PF_MEMALLOC flag that BPF helpers clear via
      xdp_buff_clear_frag_pfmemalloc() in filter.c:4441-4444 and
filter.c:12740-12743 when !sinfo->nr_frags), struct sk_buff has a
single sticky skb->pfmemalloc:1 bit shared by both linear skb->head
      (skbuff.c:515-885) and frags[] (skbuff.h:2631-2632). Clearing
skb->pfmemalloc when nr_frags =3D=3D 0 would wrongly clear pfmemalloc when
skb->head itself was allocated from PFMEMALLOC reserves.
  2. skb->unreadable is cleared in some nr_frags -> 0 paths, but still
missed in a few others:
      =E2=80=A2 Unlike pfmemalloc, skb->unreadable only applies to frags[] =
/
frag_list (linear skb->head is always CPU-readable).
      =E2=80=A2 Where we DO clear skb->unreadable when nr_frags =3D=3D 0:
          =E2=80=A2 ___pskb_trim() (skbuff.c:2810-2811): if
(!skb_shinfo(skb)->nr_frags && !skb_has_frag_list(skb))
skb->unreadable =3D 0;
          =E2=80=A2 skb_split_inside_header(), skb_split_no_header(), and
skb_shift() (skbuff.c:4228-4454): cleared by Patch 1/2 in this series.
      =E2=80=A2 Where nr_frags can drop to 0 and skb->unreadable is NOT cle=
ared:
          =E2=80=A2 pskb_carve_inside_nonlinear() (skbuff.c:7139-7167): if
pskb_extract() carves past all frags[] (k =3D=3D 0, e.g., into frag_list),
shinfo->nr_frags =3D 0 on the clone without clearing skb->unreadable (if
          !skb_has_frag_list(skb) or if the remaining frag_list is readable=
).
          =E2=80=A2 __pskb_trim_head() (tcp_output.c:2020): sets
shinfo->nr_frags =3D k without checking !k (in practice tcp_trim_head()
is only called when len < skb->len and skb_headlen(skb) =3D=3D 0, so k > 0
unless a
          frag_list is present).
          =E2=80=A2 skb_try_coalesce() (skbuff.c:6365) and skb_gro_receive(=
)
(gro.c:131): zero from_shinfo->nr_frags =3D 0 when stealing frags
without clearing from->unreadable (benign because from is immediately
freed
          via stolen-head free).
          =E2=80=A2 __pskb_pull_tail() (skbuff.c:2894) and
gro_pull_from_frag0() (gro.c:416): cannot be entered with
skb->unreadable =3D=3D 1 (__pskb_pull_tail() bails on
!skb_frags_readable(skb), and
          skb_gro_reset_offset() requires skb_frag_page(frag0) !=3D NULL).
```

I already have 1 ambitious refactor on list to try to remove
pp_recycle. I think maybe I want to do the nr_frags checks in this
patch rather than do a global cleanup of setting skb flags correctly
so that skb->unread is 100% accurate. WDTY?

--=20
Thanks,
Mina
