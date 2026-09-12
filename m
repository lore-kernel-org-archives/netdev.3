Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F533D505
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227247; cv=pass; b=OaRGE/gwQmzOyg8a10RVGzfB8TaObDTvhao6/udGsrsQiZ5xkdkHOcy3BKjG39vR+l138s7sthgDWU28rq7TgPCn5H3GDSifyOhz77HILQ/qJWjb+eY6IPTEdMIN//wEuVV/uPiS0iEhkE/GJOzjCXfxjBjVPTYSNh1XUFhV47g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227247; c=relaxed/simple;
	bh=HeRlbtaa7RT96LrQvRzCY+nytkRO6HIDsPBmGcgy6Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPulobmS8VGn1nBsOVb62AjYwaCx06tHEyXRT2HGHmz84Uw1yT0towW8I4qZC2ulAVJ6oNnbexIwrEZ/jHxHt3ClcrKKPNkBTGXw0NQ8Nsz1CfkjFALe5iiKtVIhYBDpAF+19rt/H7eq7+vgWPgWfChsVPp1e901DgkovORiFog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpsrE7ld; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpsrE7ld"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so87629985a.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789227244; cv=none;
        d=google.com; s=arc-20260327;
        b=ZyO85whJ4kOwdPgAO6ZtXB8Ec5GMCxgNsx8iRBPoBIObYnGSqnH97Mn7D9vmoPdTYe
         z+S/03Qk1l0/E35sRNW8N8n4inxk5CmfkxLmvwjDwHfqWfOffczEoRHOO4sz0yGb/x8V
         P7ils4nuM1ckIeGle7iN+YJxdGBDVnLUKYVRGGZGryGEK7HGCd87mXKQJhO+hfjw3HJz
         6PHFmJ591ifypY20q0AsM16e20fEbCHGRPPGCzHnIXisDEPlvvViNR2iUgYq++Mbf2pI
         v7W7OYU/lg61rvG1p+7S8BGfH/E9z0QD8ncBY4ukQ5P180QIQ1vfwFWQ0EyMIlCW8Ju9
         Z7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJZpGg2zN17avDLpvci8yq+q+6T2AZj1nj6oBFIJ8EI=;
        fh=vqWnWCy+RGCFOS3xFNUe08+cJ6fsfvMRca+PoTPQDE4=;
        b=rEUS8dlOM1x1breYuH6Vg2xuerbAI0f/Cc0ekkb2ozygRP1ta7s27436EqpHryYBvY
         XP0Y6x+pXTCWLGMZG85x+dVQ9dPu/V93au2ex0WhVgh5+HOYANKL5MPa/Wpx6mnkkDH7
         4JDTp57aNj49/SaMW7hnoaVplLF+T0VKBY4pu+YGk9evse3usuUdoLuGoINOUkjXalvs
         tr4TD0pnYbxU0pVAsdkRN86+DRW92T00NdykU4/whFi9FIAC93nvr9Y9WpApou4Tp67B
         uGvQ8qrgZiYp6QsHo0V4xrJQVTEd7s6r6P+gkinByi/4ziHISDiIhwqTj14C+NCVU9eb
         fI5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789227244; x=1789832044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QJZpGg2zN17avDLpvci8yq+q+6T2AZj1nj6oBFIJ8EI=;
        b=PpsrE7ldyGpcEWY446kJshLbUKFcgPws4FuSFRnRsx9nnfG+SXv4fML7VOWVsLRL7Y
         W+J7jTk744TOFMZNYKRMX/4kp7jPh9m9A4nb9n0xbXBIvtcu+mzB9TOQaOSFwjIYeodZ
         c6R/RenqUIy+f3LPZN9JZgB3PD2IsKmuVGPnRlkl6atgthqTO6ucruaEyjAeRWQgKaWI
         GEWRqj4q1PtvgtV5Q1YusD3cFlf9dR7QHVVhHmwT/uW+vXnUzHZGzNn0JVQ0VE64ww69
         MXOH/8NBXTDIOEZqj8cq4SdtC52L3J+d1wHnUX80zLQRcoAvKkgSMni8fPekKn0UA4ls
         M87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789227244; x=1789832044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJZpGg2zN17avDLpvci8yq+q+6T2AZj1nj6oBFIJ8EI=;
        b=VKuBqbpZXfcdgHSJ4mhcpcBsOG3F5+j442WY8iKo2camlSqRHUx/TnJMbXmBcu4WC5
         O1+o4MZbj1SIsFNgNTWPF0t9wt0NEFZcEu147NsKSeDXpEE7EfIz1iNuwpEfGS3cLJjP
         HlhO5xFKaDiB+dI9Ee0DAgSdXBYs4JdYHpNTC14qD2eL/YI+dBUOLqvmmIG2Vpfh2fuU
         ZcO0Y1BESNYpDvP+Kr6QtjvY9USXfxM5KgXASjqyl7qBmRbtQGxMq69qshH3c0kREby7
         lFWMwhksyw6n2d5CvLDUlg6tdn1P1lIxn/IJYIfVh0PgSUBSFdTmyvYqn3smRbkmFUzY
         GsFg==
X-Forwarded-Encrypted: i=1; AKwUvByv8PQ06gIWIZvs8CAfsj+fJs97joM+nstUrf6J1Lg4E8+X6d9Re1x8/Z623VL1mzhBG50JASM=@vger.kernel.org
X-Gm-Message-State: AFuF++n/0x4FpePSx4Q17LHc0IsZPB0RH1UycizdRRftFfLWY3rgyGBf
	Z/NI+rn/xYYLbE7Se8XHIwlSRMP4790WNaNmlc8Bweu17KL5ibxrwJyenxFl7AV1p6SYvtNqt/3
	90r08YkAPK72kH+IRrV/QKmIu1GXd2/Y4HbfIF9do
X-Gm-Gg: AYBFou3ZavSwiE1UNHpRSPjoPPlrPn8usfPk1iFYfO8YFfIBS8uJdTcINrh69w0a/hy
	Rt+RHN1wt3cI99H3lQc1NJittD/c0SZKZ5rKa6L6sHQctszJTHk+7wyWQTpSU/ZKR6mFWP2bdRy
	AHLkLrndjG+4U2P6wdAZ0ZpgjyX8xDt/0n4BWz0v0mmb5Mn0Z0OH7R4rUNMbySCM27qEtg+ZyLz
	fyd7sU7B79tbUpcYvM9ODSCIcWh2/yLrz9h84KFFTGW8uMwVFpoKGvngJylt80/laYtsxLSQX0/
	wIqdf1aAgeRjlTZfKTpTsp1InJnerAqvRzbBxZzNaDOdD0cGraTYCFI1TLBHIsu9NZuG2Itr446
	HwtoT4AY5yThQuF0Rut2nUUbRV6XPlgA93ZaT32WwH7/oJfbEjNyviUX8Gy2Ft6ax+zI=
X-Received: by 2002:a05:620a:2592:b0:939:91ab:8f0a with SMTP id
 af79cd13be357-939ea0a9dadmr1306701585a.19.1789227243694; Sat, 12 Sep 2026
 08:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908090519.339696-1-edumazet@google.com> <178898805913.219967.13489586928492348974@kernel.org>
In-Reply-To: <178898805913.219967.13489586928492348974@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 08:33:51 -0700
X-Gm-Features: AcwNN1UZD3eh2e41dnz3YmWVqn7hqrIovlJYiAZdo3DI-1v8r9R6w51u6RStqRQ
Message-ID: <CANn89iJM8pYXLwnuv8MiujsHtqYrTdb2e_i=S21kKMXPJD9n3w@mail.gmail.com>
Subject: Re: [PATCH net] pppoatm: ensure a writable skb header
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, mitch@sfgoth.com, 3chas3@gmail.com, 
	qingfang.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 2:07=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] net/atm/pppoatm.c:pppoatm_send() =E2=80=94 the SC_COMP_PROT "u=
ndo"
>   heuristic on the `nospace` path now makes its decision based on=E2=80=
=A6
>
> --
>
> pppoatm: ensure a writable skb header
>
> This replaces the open-coded skb_realloc_headroom() dance in pppoatm_send=
()
> with skb_cow_head(), so the LLC header is pushed into headroom that is bo=
th
> large enough and writable.  It also removes the temporary skb allocation
> that used to happen when the ATM socket buffer was full.
>
> > diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> > index 6da52d12df68e..4ce7fa6e493e9 100644
> > --- a/net/atm/pppoatm.c
> > +++ b/net/atm/pppoatm.c
> > @@ -317,21 +317,12 @@ static int pppoatm_send(struct ppp_channel *chan,=
 struct sk_buff *skb)
> >
> >       switch (pvcc->encaps) {         /* LLC encapsulation needed */
> >       case e_llc:
> > -             if (skb_headroom(skb) < LLC_LEN) {
> > -                     struct sk_buff *n;
> > -                     n =3D skb_realloc_headroom(skb, LLC_LEN);
> > -                     if (n !=3D NULL &&
> > -                         !pppoatm_may_send(pvcc, n->truesize)) {
> > -                             kfree_skb(n);
> > -                             goto nospace;
> > -                     }
> > -                     consume_skb(skb);
> > -                     skb =3D n;
> > -                     if (skb =3D=3D NULL) {
> > -                             bh_unlock_sock(sk_atm(vcc));
> > -                             return DROP_PACKET;
> > -                     }
> > -             } else if (!pppoatm_may_send(pvcc, skb->truesize))
> > +             if (skb_cow_head(skb, LLC_LEN)) {
> > +                     bh_unlock_sock(sk_atm(vcc));
> > +                     kfree_skb(skb);
> > +                     return DROP_PACKET;
> > +             }
> > +             if (!pppoatm_may_send(pvcc, skb->truesize))
> >                       goto nospace;
>
> [Severity: Medium]
> Does this change how the SC_COMP_PROT undo heuristic behaves at the nospa=
ce
> label for skbs that arrive with less than LLC_LEN headroom?
>
> The head expansion now happens on the original skb, before the
> pppoatm_may_send() admission check, so when admission fails we reach:
>
> net/atm/pppoatm.c:pppoatm_send() {
>         ...
> nospace:
>         bh_unlock_sock(sk_atm(vcc));
>         if ((pvcc->flags & SC_COMP_PROT) && skb_headroom(skb) > 0 &&
>             skb->data[-1] =3D=3D '\0')
>                 (void) skb_push(skb, 1);
>         return 0;
> }
>
> For an skb that entered with zero headroom, skb_cow_head() goes through
> pskb_expand_head(), which allocates with kmalloc_reserve() (no __GFP_ZERO=
)
> and only copies the old data:
>
> net/core/skbuff.c:pskb_expand_head() {
>         ...
>         data =3D kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
>         if (!data)
>                 goto nodata;
>         size =3D SKB_WITH_OVERHEAD(size);
>         memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head=
);
>         ...
> }
>
> The new bytes in front of the copied data are never initialized, so is
> skb->data[-1] here reading stale slab content rather than a byte this
> function pulled?  If that byte happens to be 0x00, the skb_push(skb, 1)
> prepends a spurious zero to a frame from which nothing was ever pulled at=
:
>
>         if (skb->data[0] =3D=3D '\0' && (pvcc->flags & SC_COMP_PROT))
>                 (void) skb_pull(skb, 1);
>
> Before this change the same case took the skb_realloc_headroom() branch,
> freed the copy and jumped to nospace with the original zero-headroom skb,=
 so
> the skb_headroom(skb) > 0 test suppressed the push.
>
> Frames written to /dev/ppp look like they can hit this: ppp_write() does
>
> drivers/net/ppp/ppp_generic.c:ppp_write() {
>         ...
>         skb =3D alloc_skb(count + pf->hdrlen, GFP_KERNEL);
>         if (!skb)
>                 goto out;
>         skb_reserve(skb, pf->hdrlen);
>         ...
> }
>
> and pppoatm never assigns chan.hdrlen, so pf->hdrlen is 0 and control fra=
mes
> with a non-zero first protocol byte (LCP 0xc021, IPCP 0x8021, PAP 0xc023)
> arrive with no headroom and no entry-time pull.  With the VCC queue full,
> pppoatm_may_send() returns 0 and the goto nospace path runs.
>
> Would it be more robust to record whether the entry-time skb_pull(skb, 1)
> actually happened in a local bool, and test that at nospace, instead of
> inferring it from skb->data[-1]?

Good idea, I will add this to V2.

pw-bot: cr
