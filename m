Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8E3624A6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078178; cv=pass; b=IMBnts8+3EDmq/sArkxyQ1CT1cO6tcC/3ARUK1CrJRmSkkTGCfgpGLbPYgPl4D4QZSpTb3HXQUxxek+ItspTHOXVMogCk+0zUwFlTKQa3q6Adggjst80ZxZ0Qn4g8hLpus3PnF81jrkWgDxCbPeGLKUQHfJoAfnSRN/+REhA/EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078178; c=relaxed/simple;
	bh=40J6Y/G/E0nQBIQyAgMJqNgAj4YPAGt7/9BCsaCbZzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbKaLiTvGkfAD5mYzkwwlHlan5OLCOdAdgu6NyosHevUbPpFcpPfB6lB7EewvoKjX1wHE8SR6z46j29+T3hO6FnDtorT6b4K15LJoFNFWvRGh5qCnWtKsk9VJUrbT3MN0VTY1nuKsqruAWlAl9kn4jEPAxlPMbzsRWOCr1qdVW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcLNPp4P; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcLNPp4P"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so14983a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787078175; cv=none;
        d=google.com; s=arc-20260327;
        b=YQ1JlGLq2/YzEzI/DfIY83UaJNU325QWhEjhwwFUi54xPS+dnXlAE8GD444UBxrB2p
         pYuurQ/QgLmcf3c+saoyrQ2x5UQ9E7k9nIC3lGTDJPfVAUKAS/+99t1xxrofXspkCpE+
         QwjciIi6vANeT6jBR6hCv8pKdE9eMnyaTupEkwMawYQ7Y7h3KvgE2XCrghHdrtNs2aQu
         PhChZZcYgU86ru3HM8OqPZQap7CYPofFlnfndW1iUgoqefGWQWMZkcmJMiUqFVGIQlIe
         uWM73rO8r0uva2sWHF+LT48VRCnqoccEMohCUnukV/XtCBjyva6S9Pdfxa6coq7AJ839
         ejdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8SC86Mf6iq7+cEHlS3Ht4S20fkohhaFpOeyGlMyepjg=;
        fh=ocxBGXzy/OTeTpQrTbfb4GKJPDlulSaVaDJcL5XT/fA=;
        b=CBEnHK2yYP6TV56xuYtR+cFwhRlI/k8+e7yudk09OHxpwvuDv+ejlsTVxMTXkLXa+L
         bCVYmT2giZytSw74B0JHYYEHFhXy3lj3EVvb6d7LNJLNw7724yhUZ7vMS65KS5PcbV39
         8rySqt3/fPYp4pfVH3gnR2HB7Af3ApYP0EPQkAtHKgVAUpOLctdPaNrGMBWFtmKuyUgp
         90Uqf0/f+5/3iUHNmG46xzNwWUr8N9esfZcWzWyhupUy7/sJmO4zEJOdUOkTbPyqu+sG
         xxdNP7XDjZ7flexnQz2GT+pUFQKVy/+ZNNktLkpGH3+aeRzyI0o7RPYUbpgzNM+gIkNN
         8Faw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787078175; x=1787682975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8SC86Mf6iq7+cEHlS3Ht4S20fkohhaFpOeyGlMyepjg=;
        b=JcLNPp4PD1KcgL57gnbKtPpCHNYcIOThiAgqwaj1GVFlxytBOv5IYa6OMn/0D5RsXe
         dcWlQ6FePix8S+j1o/BqfowEBjNQXcHSjoq74UxC39aa7GrUIdXlLO3gZV+1QR6TXqtJ
         8ZoRkDLlYG1d1CLhcnFcSc4USwbI4aK0qrQCFhexSToSfBDATKD4knZhSwpE2mO7oOnR
         SU6/BVHHlieEs2yGaxQCwY8+l+M7TmZppMnNttmqWdtoUJLhOQCQQLg9CRGTa8YSb9Mm
         K0ZALLvehMfHkhAZ3XNuSN5BWLeLWlJbUplseXx2h5wMssD9dsLwyqtYfvnANr8RPGTy
         TasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078175; x=1787682975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8SC86Mf6iq7+cEHlS3Ht4S20fkohhaFpOeyGlMyepjg=;
        b=Cp4Jy9BO6rZlsqTJRVTGlAnodgG2KrmCh4/utJskuEcaHKQQkIsCAU+yyC53u3LNHH
         iY5Vtt3RSGt4NH79GVl6otEgMxM9ZfdRcAcyb5PjcxaH/8KQewG/yrjgQUJg8iuTy0Gi
         U20fc9/GY805QdBA+LpPIYVPdoa2cM4zQF08dHSob+/ou5B9noGMU6ZgIFmld1dzcXJS
         MQcYBb2RQ46OOx3SIKlxurSUjdYfmv0+at3YAY3FHHee2zEGKhEqf2c1CtU+C248PpUk
         rik8QLAS5yKYC+s1CwzPozQ1+9W3aiQw3gl8+mnweO/w6B11fOMrF16XfTmg31IUbZX8
         3ULQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAzGLdqKXP42hsHvy+2ubt0mOOabZBXW779Pg9+JDafSZqf1gFhXyeZ86yG89ky72CSYd8dRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZeydWFqgrUYMQhcADDrUL6Kr03cs/D1+dj/ErT4GTVIfk1Q9R
	IW4NIccZbar/9R3n+6tBH3h4rM7tR+kMwvn7eG/Kaa2fTPF50wL5F9eZ7IesSxNBPC1Iknxxaus
	Tq5xLyrGmySDMvEWB6hnJ4HTQyDyOC1fr26UoAwXx
X-Gm-Gg: AR+sD10mTj5p1DXYKFKsgctIfewVI2BCe6Qp/XySU6OnfrjJouR2StDAg1A0j5iiYFn
	9J6cmrsHE+cG3m/3WR3YOxCtyo8jjmK8JfUI7IL38r4BCpyqBj0M7eBfE9Ixg5ENc+ii2Hw1jLS
	/SDorp8VnP5uxqBC3eiEd6N1t2TR77ADw473AEbxxHnSSesn2NsS5qpeamJpqmf3au0WW52PIb9
	OuSsFGi1G8dq6PyWf40l/cmAWy15ce5JsDa36tz4hO9n2CuHdcuVNoys40gBMOT0VQQPJwNlADV
	HoLsyZ7G5HPnrzZME0oPEiLklGnR9XEDo7QTYXbvl7ovtGNlg+EfDiQIKGYDRMrRigdGeYVcJRg
	=
X-Received: by 2002:a05:6402:501e:b0:6a0:6679:be47 with SMTP id
 4fb4d7f45d1cf-6a3eb336806mr86010a12.1.1787078173801; Tue, 18 Aug 2026
 11:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191336.187243-1-almasrymina@google.com> <20260818102557.132214-1-pabeni@redhat.com>
In-Reply-To: <20260818102557.132214-1-pabeni@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 18 Aug 2026 11:36:02 -0700
X-Gm-Features: AcwNN1XUtE0XgmjvDa-H-FkMjQtIsUVl-z77zsM10Mzp_A0gAb4N3k5dU6YKmKg
Message-ID: <CAHS8izPb1HH3=AGrsUBKTh1TLQvutt6g144CAHwMUQd4vREgdA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net: core: propagate unreadable flag in skb_zerocopy
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, kaiyuanz@google.com, willemb@google.com, 
	edumazet@google.com, sdf@fomichev.me, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dev@openvswitch.org, davem@davemloft.net, 
	horms@kernel.org, ncardwell@google.com, kuniyu@google.com, aconole@redhat.com, 
	echaudro@redhat.com, i.maximets@ovn.org, kerneljasonxing@gmail.com, 
	asml.silence@gmail.com, bobbyeshleman@gmail.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Thanks Paolo. Responding to the specific feedback inline, but in
general, clashiko is pointing out pre-existing issues. They should be
fixed absolutely but I'd prefer to submit separate fixes for them. I'm
a bit worried about going down this rabbit hole forever. Let me know
what you think.

> ---
> net: core: propagate unreadable flag in skb_zerocopy
>
> The patch makes skb_zerocopy() propagate the unreadable flag to the
> destination skb, returns -EFAULT when a readable head payload would be
> mixed with unreadable frags, and rejects unreadable skbs in openvswitch
> queue_userspace_packet().
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index ba3dbac80fb49..d21af68156950 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
>
> [ ... ]
>
> > @@ -3905,10 +3906,17 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff=
 *from, int len, int hlen)
> >               }
> >       }
> >
> > +     if (!skb_frags_readable(from) && j > 0 && len) {
> > +             put_page(virt_to_head_page(from->head));
> > +             return -EFAULT;
> > +     }
> > +
> >       skb_len_add(to, len + plen);
> >
> >       if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
> >               skb_tx_error(from);
> > +             if (j > 0)
> > +                     put_page(virt_to_head_page(from->head));
> >               return -ENOMEM;
> >       }
>
> [Severity: Medium]
> On this -ENOMEM path, is it safe to re-derive the head page from
> from->head after skb_orphan_frags() has already run?
>

Probably not. I think this is a pre-existing issue in skb_orphan_frags
though. I think skb_orphan_frags should check !skb_frags_readable()
before doing anything so that it doens't modify the skb and then
return -EFAULT on a modified skb.

> skb_orphan_frags() -> skb_copy_ubufs() drops the clone first:
>
> net/core/skbuff.c:skb_copy_ubufs() {
>         ...
>         if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
>                 return -EINVAL;
>         ...
>                 page =3D alloc_pages(gfp_mask | __GFP_COMP, order);
>                 if (!page) {
>                         ...
>                         return -ENOMEM;
>                 }
> }
>
> and skb_unclone() -> pskb_expand_head() replaces the buffer:
>
> net/core/skbuff.c:pskb_expand_head() {
>         ...
>         skb->head     =3D data;
>         skb->head_frag =3D 0;
>         ...
> }
>
> So when the -ENOMEM comes from the alloc_pages() loop, from->head can
> already point at a different (freshly allocated) buffer than the page tha=
t
> was get_page()'d earlier in the hlen =3D=3D 0 branch:
>
>         page =3D virt_to_head_page(from->head);
>         offset =3D from->data - (unsigned char *)page_address(page);
>         __skb_fill_netmem_desc(to, 0, page_to_netmem(page), offset, plen)=
;
>         get_page(page);
>         j =3D 1;
>
> Does that leak the reference on the original head-fragment page, and appl=
y
> the put_page() to an unrelated buffer? Today the misdirected put_page() i=
s
> quiet because pskb_expand_head() installs slab/kmalloc memory and put_pag=
e()
> early-returns for folio_test_slab()/folio_test_large_kmalloc() folios, bu=
t
> the reference on the page that was actually taken is never returned.
>
> Would it be more robust to keep the page pointer captured before get_page=
()
> in a local and use put_page(page) in both new error paths?
>
> I was not able to find an in-tree producer that combines head_frag =3D=3D=
 1 with
> skb_zcopy() set, so this path may not be reachable today.
>
> [Severity: Low]
> This hunk looks like it also fixes an older, unrelated head-page referenc=
e
> leak. __skb_fill_netmem_desc() does not bump skb_shinfo(to)->nr_frags:
>
> include/linux/skbuff.h:__skb_fill_netmem_desc() {
>         __skb_fill_netmem_desc_noacc(skb_shinfo(skb), i, netmem, off, siz=
e);
>         ...
> }
>
> and skb_zerocopy() only sets it at the very end with
> skb_shinfo(to)->nr_frags =3D j;. So before this patch, returning -ENOMEM =
here
> left @to with nr_frags =3D=3D 0 and the extra head-page reference was nev=
er
> dropped when the caller freed it (consume_skb(user_skb) in
> queue_userspace_packet(), kfree_skb() in nfqnl_build_packet_message()).
>
> That leak dates back to 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan
> frags in skb_zerocopy and handle errors") and is unrelated to unreadable
> frags, while the changelog only mentions unreadable-flag propagation and =
the
> new -EFAULT returns, and the Fixes: tag points at 65249feb6b3d.
>
> Could this hunk be split into its own patch with Fixes: 36d5fe6a0007, or =
at
> least described in the commit message, so that stable backports reach the
> pre-6.12 kernels that also contain the leak?
>

Right, I added this hunk because sashkio reported this pre-existing
issue in a previous iteration. I could fork it into its own fix, but
for the follow up pre-existing issues it's reporting now, it maybe
makes sense to also fix those in follow up fixes.

--
Thanks,
Mina
