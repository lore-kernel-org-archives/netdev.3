Received: from mail-ua2-f15.google.com (mail-ua2-f15.google.com [74.125.226.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954124A2633
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.207
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685345; cv=pass; b=RhGxFQFlKVvbqxkZVirk+dgzrMmM6T0GzptbIQUtz48rJIzyhIL3h5Q2U1Xo4sVuE6Lhkm6j3tVaOfOO6X5dJe751mQIrcLbAOaspDSI2CuHUJaiiZoc9pt7uR5alzXODG1GLGB7sp1ohxoNylAeBNTuxP/C/8aFnp8HSAVyQxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685345; c=relaxed/simple;
	bh=xGox2TSbccGn0rU3WVlrmi/F7M1SnXxQfREwUPrWvZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chuRbltwT2jcovCnGIft430ThLPkYE9hEmInRofJQgjaqXbSstzpDAxbYHLazteqIB0NQ1C1SGBOFuXT+5UB4wBdedecSZleCPkU90OPNzstb4VtA7fq76rtH5DcYivELwXnB9vJA0YtOLbbCujUdF3MRACrfpEuviNQbpiZKlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=DR8P0SIK; arc=pass smtp.client-ip=74.125.226.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="DR8P0SIK"
Received: by mail-ua2-f15.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed2so46567241.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685342; cv=none;
        d=google.com; s=arc-20260327;
        b=gcUYtys/PMgtOorsKQ2wDfpDqo2y3RdU4ryfU3a2aTEgRA1Ui/Ry4Wv2VAd5ocA0y9
         Xw6kj1Aibbi566QkqwlYiMGA5ibLv82FYM4+9ikpIUU1ij0dSYW9I4Ufi6gt1LVqqdCF
         xG9xznVSAIX89jJ0sHCnZsZURnwD0MqAfP+tEypzq/RThTHudrC4Js9aTxWTou4I3RTe
         rqFQQ1UdnO8P5ajan3UlwJYhj0ucnbP6Ekq36BhmEaZw5cm4hb/kzfUcJOzlOK80rZXs
         oWpQA3gf153ts+HCFDqZlrffI9/c7gkT5mr7aPfYEQttPrn9DStHrM4+sVIJpA6wKpe9
         QaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VLdP63bUcDLsKLfapMeCNDEcc2sx3WP8LGQTKNs6yu8=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=gZtp2pEyi9P9v00hu98cN4XuHkr8i5drtmMM3iVM0yKceQ6Ehjl+6Q3v+Fl6T8pSxP
         1e17OwH8wxmJuuiUnpua0ThQ30nrjQpMfKNAvn/2HwsjfbWxQbypzUCFvi28C70jFqXa
         Fr8XkIgqO5ZJt/8mf/wyqCU86ljaWlL0RUathwwPUD6cTTKTbbpYnuF/C5Rn7REXRW8Y
         nyXFVa2EH23Y5r9YOeR0hdW+6FfLZRhbqhyffCYqjpNYYc0LKOyIVSAiq+KJB4fhCuSU
         1JjtTCwBevUFhuzyfaiW66vfXuRDb8XoHtZmX9Xl72lcjFBkBfSmeVcxCO97whbGJXJ7
         +IbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685342; x=1790290142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VLdP63bUcDLsKLfapMeCNDEcc2sx3WP8LGQTKNs6yu8=;
        b=DR8P0SIKsvvenehlOe3xtoUsI+/DC+TdB7Bx4GuyjsyRGTGTyzRHXzqcYzEeT85X8h
         gKgK7F6rUrZZcote9Ayi+dZZD/gDEuTW7hluY6LztOyKdrhmjhoIoivSXoUm55VXtg7V
         DFEtR0Zj7jbqsAB5Ycbr9fpDjdhQS0F3da0gxFUD4j3AcAI87SsR/CVdyDeoXCkREY90
         jginKIAe+dKsNXsq2Cc0Y9+lq/PopKrQPoN9n4wS8vxVY6DQpz3OFOrXNxFMsyBudLuJ
         +8f0ClGdnkFmj1b2ZAKgtPr3U1ZsfOG2IuM/N0KRDau6lWqXAR2nevv6LEYsrOpKYvTP
         GunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685342; x=1790290142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLdP63bUcDLsKLfapMeCNDEcc2sx3WP8LGQTKNs6yu8=;
        b=Z+TW6dV1Grwee47WgTUp0CUN6q28sfbzdMyxieaRaYN0Y0vtnlApi3/zeXACjOMVOc
         PKJ3AlfH5Jml33FmGxdBCggdn/5/LHPJ+e81ZTzSDzI+1VDOkgwqPzcgjBB3b7Gaxy2G
         XENGb1VGO1YYtJyc+rKKrRMMqNrhxhNsG0FMvkqvxPyAqV1x8Yb8dueS16d0TAzpqXaf
         57vW1YPg4s+c0PCdRkwSF+FYJWab0V3BWhZriCbRrhTyCstCfmH8JI9RSRZNxVNQpjbP
         XHAV2Mj2N6ZJoLiAarF2oade6nMYYllrQMUi/uuusewh5E/p8qKtYIZ8FCf96sOfai+K
         Ig3A==
X-Gm-Message-State: AFuF++m4xVYrBouw8NL6LB0yaEcFedHVF3UansmsidD/sMCUADxk+Wum
	9YliIQ19Ku30ztYVDBEjW6mXa0Z6ke79Y89tPkelBBTwe4hNrxXm9ztqSkfo2lfDehz6lFAmJ4Q
	nDgvPoVTm/AkDbqBU+xE9a+EZMX9VNtAKipJlpV10uQ==
X-Gm-Gg: AYBFou1PWp6EO9827XIv4KVQlhPl49+QOC2shYNA0Pz+4PTTipfngY5Jn+gBJBthjO4
	tBaSerlNDvs2Ol+c+ERzRqfJ2Urshc1sD+mC3fXnrpKxCsfOcr+bd7PAoz6MXq/PKM3oU2eMzo3
	yWw9j9LbI2EQJiroNUZ+YIbrz4vkTC48AerdJdcFCy58/8dav1BL3gtzGo5XDYJ2p6Q4MFGposQ
	DJaSNqFOlivYgKpsrmAIvaJde/0Kvf/RRIquOaWvxfHB6ROTafwZPX2uyFp4giWzCAWiVk6zN4d
	ag+1i7EbJTrwTb8scw7LtTQm7kJ5XZCqQW0yIs2FaCWrxS+t0wrzewIU09EwJ7+r4GscLlPycyI
	rHsrVRRpM0zOtpEVUfxQHi956sxqWe3W/fQBfFvur9qxTn2aNClEJRd/e1pN/fgr+hqhktN4IVL
	uumNlvIskQGQ94s+2FeXaf0y7tT+szmr8057k61s0E
X-Received: by 2002:a05:6102:370c:b0:7a2:568f:815d with SMTP id
 ada2fe7eead31-7a55c2891a3mr317777137.18.1789685342125; Thu, 17 Sep 2026
 15:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-5-rjethwani@purestorage.com> <20260817221128.3666336-1-kuba@kernel.org>
In-Reply-To: <20260817221128.3666336-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:48:50 -0700
X-Gm-Features: AcwNN1UofpS2qeV6grFcARfb7kApnfjOHa-hT6jMiORZuSa1M899a68RRLZ5OjY
Message-ID: <CAKaoeS2J_8BviCpkf2qoNKWkmiXUAfdwtPpqUsBhdy5zH7j2BQ@mail.gmail.com>
Subject: Re: [PATCH v16 04/10] tls: add TLS 1.3 hardware offload support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
>     tls: add TLS 1.3 hardware offload support
>
> This drops the TLS_1_2_VERSION gates in tls_set_device_offload() and
> tls_set_device_offload_rx(), teaches tls_device_record_close() to append
> the TLS 1.3 content_type byte along with the tag, and switches the
> device fallback encryption path to prot->prepend_size / prot->aad_size
> so the 1.3 layouts work.  tls_device_init() also pre-populates
> dummy_page with an identity byte map.
>
> A few questions below.
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 37bb06a8e8f5..bbb1aa733500 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -317,25 +317,34 @@ static void tls_device_record_close(struct sock *=
sk,
> >                                   unsigned char record_type)
> >  {
> >       struct tls_prot_info *prot =3D &ctx->prot_info;
> > -     struct page_frag dummy_tag_frag;
> > -
> > -     /* append tag
> > -      * device will fill in the tag, we just need to append a placehol=
der
> > -      * use socket memory to improve coalescing (re-using a single buf=
fer
> > -      * increases frag count)
> > -      * if we can't allocate memory now use the dummy page
> > +     int tail =3D prot->tag_size + prot->tail_size;
> > +
> > +     /* Append tail: tag for TLS 1.2, content_type + tag for TLS 1.3.
> > +      * Device fills in the tag, we just need to append a placeholder.
> > +      * Use socket memory to improve coalescing (re-using a single buf=
fer
> > +      * increases frag count); if allocation fails use dummy_page
> > +      * (offset =3D record_type gives correct content_type byte via
> > +      * identity mapping)
> >        */
> > -     if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
> > -         !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocatio=
n)) {
> > -             dummy_tag_frag.page =3D dummy_page;
> > -             dummy_tag_frag.offset =3D 0;
> > -             pfrag =3D &dummy_tag_frag;
> > +     if (unlikely(pfrag->size - pfrag->offset < tail) &&
> > +         !skb_page_frag_refill(tail, pfrag, sk->sk_allocation)) {
> > +             struct page_frag dummy_pfrag =3D {
> > +                     .page =3D dummy_page,
> > +                     .offset =3D record_type,
> > +             };
> > +             tls_append_frag(record, &dummy_pfrag, tail);
>
> [Severity: Medium]
> Here record_type is used directly as an offset into the shared global
> dummy_page, and tail =3D prot->tag_size + prot->tail_size bytes are appen=
ded
> starting from that offset.  tls_device_init() only writes the first 256
> bytes of the page, and the page comes from a plain alloc_page(GFP_KERNEL)=
,
> so the rest is not zeroed.
>
> With AES-GCM (tag_size 16) and TLS 1.3 (tail_size 1), a record_type of 24=
0
> or above makes the appended frag cover dummy_page bytes
> [256, record_type + 17), which are never initialized.
>
> record_type is taken verbatim from the user cmsg; tls_process_cmsg() in
> tls_main.c checks only cmsg_len and MSG_MORE:
>
>         case TLS_SET_RECORD_TYPE:
>                 if (cmsg->cmsg_len < CMSG_LEN(sizeof(*record_type)))
>                         return -EINVAL;
>                 if (msg->msg_flags & MSG_MORE)
>                         return -EINVAL;
>                 ...
>                 *record_type =3D *(unsigned char *)CMSG_DATA(cmsg);
>
> so all 256 offsets are reachable from an unprivileged process.  Can this
> put uninitialized page contents into the tag placeholder area of the
> record?  Would zeroing the page (__GFP_ZERO), initializing
> 256 + max tag bytes, or bounding the offset be preferable?
>
> Related to this, the comment added in tls_device_init() says "By populati=
ng
> all 256 values, we avoid needing to validate record_type at runtime", but
> the identity map only covers the content_type byte, not the tag portion o=
f
> the tail that follows it.
>
> > +     } else {
> > +             if (prot->tail_size) {
> > +                     char *content_type_addr =3D page_address(pfrag->p=
age) +
> > +                                               pfrag->offset;
> > +                     *content_type_addr =3D record_type;
> > +             }
> > +             tls_append_frag(record, pfrag, tail);
> >       }
> > -     tls_append_frag(record, pfrag, prot->tag_size);

I'll fix this by allocating the page with __GFP_ZERO, which keeps the
trailing placeholder
bytes defined for every reachable offset while the identity map still cover=
s the
content_type byte.

> [Severity: High]
> This isn't a bug introduced by this patch, but the else branch now
> dereferences pfrag->page one step earlier than before, and pfrag->page is
> never checked for NULL.
>
> Consider the state skb_page_frag_refill() leaves behind on failure in
> net/core/sock.c:
>
>         pfrag->offset =3D 0;
>         ...
>         pfrag->page =3D alloc_page(gfp);
>         if (likely(pfrag->page)) {
>                 pfrag->size =3D PAGE_SIZE;
>                 return true;
>         }
>         return false;
>
> offset is zeroed and page is NULL, but size keeps its previous non-zero
> value, so pfrag->size - pfrag->offset is at least PAGE_SIZE and the
> "< tail" guard here is false.  The dummy_page fallback is skipped and the
> else branch runs.
>
> Can tls_device_record_close() then be reached with that pfrag?  In
> tls_push_data(), with an already-open record (record->len >
> prot->prepend_size, e.g. after a previous MSG_MORE sendmsg),
> tls_do_allocation() takes the sk_page_frag_refill(sk, pfrag) path; on
> allocation failure it returns -ENOMEM, sk_stream_wait_memory() returns
> non-zero (immediately -EAGAIN for MSG_DONTWAIT), and control does:
>
>         } else if (record->len > prot->prepend_size) {
>                 goto last_record;
>         }
>
> which sets done =3D true and calls tls_device_record_close(sk, tls_ctx,
> record, pfrag, record_type).
>
> For TLS 1.3 (prot->tail_size =3D=3D 1) that computes page_address(NULL) +=
 0 and
> stores record_type through it, then tls_append_frag() does get_page(NULL)=
.
> The pre-patch code took the same false branch and crashed in
> tls_append_frag(), so the NULL deref itself is older, but should this tes=
t
> pfrag->page (or reset pfrag->size on refill failure) so the dummy_page
> fallback that exists for exactly this situation is actually used?
>
> >
> >       /* fill prepend */
> >       tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
> > -                      record->len - prot->overhead_size,
> > +                      record->len - prot->overhead_size + prot->tail_s=
ize,
> >                        record_type);
> >  }
> >
>
> [ ... ]
>
> > @@ -1091,11 +1100,6 @@ int tls_set_device_offload(struct sock *sk)
> >       }
> >
> >       crypto_info =3D &ctx->crypto_send.info;
> > -     if (crypto_info->version !=3D TLS_1_2_VERSION) {
> > -             rc =3D -EOPNOTSUPP;
> > -             goto release_netdev;
> > -     }
> > -
> >       cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
> >       if (!cipher_desc || !cipher_desc->offloadable) {
> >               rc =3D -EINVAL;

I'll fix this by adding !pfrag->page || guard

> [Severity: Low]
> Should Documentation/networking/tls-offload.rst be updated along with thi=
s?
> Its Rekey section still says:
>
>         Offload does not currently support TLS 1.3, therefore key rotatio=
n
>         is not a concern for offloaded connections at this point.
>
> Removing the version gates here and in tls_set_device_offload_rx() makes
> the first half untrue, and the later patches in the series ("tls: device:
> add TX KeyUpdate support", "tls: device: add RX KeyUpdate support") make
> the second half untrue.  No patch in the series touches that file, so the
> sentence is still there at the end of the series.
>
> >
> > @@ -1410,12 +1411,22 @@ static struct notifier_block tls_dev_notifier =
=3D {
> >
> >  int __init tls_device_init(void)
> >  {
> > -     int err;
> > +     unsigned char *page_addr;
> > +     int err, i;
> >
> >       dummy_page =3D alloc_page(GFP_KERNEL);
> >       if (!dummy_page)
> >               return -ENOMEM;
> >
> > +     /* Pre-populate dummy_page with identity mapping for all byte val=
ues.
> > +      * This is used as fallback for TLS 1.3 content type when memory
> > +      * allocation fails. By populating all 256 values, we avoid needi=
ng
> > +      * to validate record_type at runtime.
> > +      */
> > +     page_addr =3D page_address(dummy_page);
> > +     for (i =3D 0; i < 256; i++)
> > +             page_addr[i] =3D (unsigned char)i;
> > +
> >       destruct_wq =3D alloc_workqueue("ktls_device_destruct", WQ_PERCPU=
, 0);
> >       if (!destruct_wq) {
> >               err =3D -ENOMEM;
> --
> pw-bot: cr

I'll create a document commit
