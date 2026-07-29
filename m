Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5D2874E6
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 04:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299761; cv=pass; b=tm8K2KkwT67RFKnVADFHpZjGzFbws5lLvVjgSZMuq6wmPABlybNwdQVuK7PNFekcyoFZM9P9G0NDn3ALe+GeYevwpxuF/R1RAZ4ofKMN/6pK1G30mMxN7+kPTpQcpy/XgRpgUgGaS+HM/jjNjTYPnkUxa4fzt8zaLYzdc7hQWA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299761; c=relaxed/simple;
	bh=eXxuZZCRR4m1SNx9TqLOQOAWhfwaZChlZDGtoBJUfDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noEaQ6dyipoLt6Du6DMBzY/b2T7XH8omG9wNnxU2k839sZklA2ICTMTLBdwYcRlD00aymx0l8NiJ7WnGGBexE3FCjNrW3UoSw8TWO+P7QvjHb3S8c/loBPKlWTOXUyWLjgtK0ZfnnFGMNafXXvW2yqwHNAvOrVzhtnq7NXqlUO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6A+vyeC; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6A+vyeC"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80dc4a68e4aso8074837b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785299757; cv=none;
        d=google.com; s=arc-20260327;
        b=lb1oRdkjKrGdOJcLoQsc8lV7FZFB8OlrJ1I8WtQlIfYeroDQgGBN6MB+3mQHpcV5il
         MPTEAjDSXRSA4hqjwXOYoRUf6E/27ZicRfQlRfwo4qh2SIuh8HTKENjieDmNU0mJqaL5
         3veDbQdCQZyB3VJYEAlQCzjkfGhf7aTDrwLsftr/fnk/9nx8PRvUg8H5hsRKdVS6XUEk
         TLYndXqhwRGm0jGUb6EifaPM96IyXjwI9YuzJqqoYFsZqza1+bq7LG5leuBfavVLdrBa
         dQDm/Gx8Fygt7s55RWZJ1cuTht3cE2/bjd/pP4n7sMC+eZFGAKgEh6sKaj5nd9H3jtBe
         saDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        fh=8e+mqzgREIIIwgG+5CnFf1/5fr5/S3LxEcDzGH29ORk=;
        b=o9Ha7c3zTJdwZl/RrhYLzHRrPxiwbUrkx3Kmh+a5q+DkDnJGOF57FMog7k73UcFs4/
         AtnCkZa73bj/xt5s0UCYolfNHI4YuNHzGlrEVR7v62Sieic+ZwQpLnL6kRFT2K4366Gz
         7PUFnIMs3KEk8hRQOQ1gvESDT3f7eMvyjPWUKystzKGBDKZmO7GmoJYTKTnDxYh0MeI9
         1Sm9GGeElC22B+/9NvG5w8WLFilwOvArNRMhf4VYMWVHhzc082ZoJ8MGSUtWnQ+h3wLX
         d4BHqzr4G+rWxbqSEA+H94uPaonlNxaFHfxD39rMbvfpoAZ0Dg7OA5jOE+gFwx1N7jSx
         HFbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785299757; x=1785904557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        b=l6A+vyeCtZ5Vc77/EbmgNFgvlPrXl5+NoSac+IUW7nQV32Mrwgz0JzrO4BkFOQXYck
         EWHTwv76SqUcwVa3wgBQgFakN7DsD6l7pKqL3Yd/j2usjmHAKrPR7FGmrllYMd5dGi8a
         OyjSjAtKdwhHjQwiNVx56na6BJ5VlivPjvguFQSvcYQAVjNkmjBtO57kg/tXNrlb05PO
         GxDuINWPFEzyeniiv3Vsn/voZNYYgBKhWAKmQ+AolOYyGIlCaIR0ufxvIY2JRl2An6l9
         a14D6DXl6RZwtjkTdsJ/0Knpc8rQ0NFhRQ2Cjg6qPTyZyi9/wAejWC8FEnx87yPSro7+
         QQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785299757; x=1785904557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJnft9PmfWlLs1b4MKRuyLFvy1g2soCrYIGgLbTdANE=;
        b=BH0ebhjTIuy3NFdFPog/Lc0FtyNRZM0AST/jNZaYHgNpl+l6HtdGiH61KbEO/L4+yQ
         IC8/6BHuGwBXWnfOh1ONphjNpQ3DgAgmh1aeVWNz7BHLi5uwUo6t+S1aQ4stR+RFTk09
         YBwJTRDyVJ/fo631VPE9B/CVAbjDlZY0mzoNEDe7QkBmrYwGRBYYzxvqjW9wf4BfYUy1
         O476LdoBc4V0DuM7zw9SF9GXGlr2G/u5tb+9surcfoaT9SKnKOWgS05euGC/qjfo9iv+
         d4DIqz5Mwy1UI8Eid57lpM1JPSUUhqtIFaCFOOralzStM3Scb5e604VYkUEeLrdss0tA
         CdUg==
X-Gm-Message-State: AOJu0Yz8QtPZQZeUAapNnWZWJetcUNFNrrnlgbDnxYPFT/isuf4PGLOS
	U2gU9TOJn8lso/aNJkyiDBli+UPjkKYnPafAnEwXh1boZTdp/HKtKRGy7cqMrRh8QKfX6f8syT+
	II/bs4pkNv+Qke63Q2Vc4auXH5zFZQVE=
X-Gm-Gg: AR+sD10BDh6Pc7WdZdb300maEB+87WyBPxNI5alCPiIPiRrsiYVV8FWVQfg2IiCnAE6
	ehDbT3ww30aJldcq9w3MmzB5or0vLeiTHlZMS7E0LWYC47RMln1vIFPowtld3NXQ6HhT7UgPotA
	ZGq2m0OOadv7tZnwQXyq+JzBud6SR9W0OBSX/K8Xx95aZuw22+9+I37Ni0/ByLS4qFpgQgEuZJj
	T5jAhg6mFcv/WUjWgi+qkCw4hWqM7dTyuwXWWTkdjLKRu4mXOFKvssKL5kqP/DH/REcIJLwy5js
	OtPiCa1L8XLweK+dSieqoaBACzAOWtSEBqQZ1xF0QdC0ogkpwcbd8tcbCS5kOM2gwAlJDNgoHRd
	RFDWvkUrtx09+B/8y16k=
X-Received: by 2002:a05:690c:4d41:b0:81d:5155:213b with SMTP id
 00721157ae682-81f990adcdbmr25491617b3.14.1785299757024; Tue, 28 Jul 2026
 21:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-2-sun.jian.kdev@gmail.com> <amesUgTjM+4WvTkJ@boxer>
In-Reply-To: <amesUgTjM+4WvTkJ@boxer>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 29 Jul 2026 12:35:46 +0800
X-Gm-Features: AUfX_myQ6iay0D6KuhMY71cOqlREpxPTZjbUcUBLGVWUwA3h0jnwU10zyOyJWrY
Message-ID: <CABFUUZFfE86j8QVZoR6HSs1PsgLjxOB0=_hqBRwBaFbXKJKxXg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: fix skb length accounting after generic XDP
 frag adjustment
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	lorenzo@kernel.org, toke@redhat.com, matt@readmodwrite.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:07=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jul 26, 2026 at 08:25:34PM -0700, Sun Jian wrote:
> > Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
> > XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copie=
s
> > xdp_frags_size back to skb->data_len but leaves skb->len containing the
> > old fragment contribution.
> >
> > After a fragment shrink, this makes skb_headlen() larger than the actua=
l
> > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > copied 1024 bytes past the actual linear tail to userspace, starting at
> > struct skb_shared_info. The copied bytes included the affected skb's
> > nr_frags, xdp_frags_size and a kernel pointer from
> > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > amount and truncated at the end.
> >
> > Subtract the old data_len before replacing it and add the new data_len
> > afterwards, keeping skb->len and skb->data_len synchronized.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in ge=
neric mode")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel=
.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  net/core/dev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 5933c5dab09e..94204702cb02 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5517,12 +5517,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *sk=
b, struct xdp_buff *xdp,
> >       }
> >
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> >        */
> > +     skb->len -=3D skb->data_len;
> >       if (xdp_buff_has_frags(xdp))
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> >       else
> >               skb->data_len =3D 0;
> > +     skb->len +=3D skb->data_len;
>
> hm that reads a bit weird to me. maybe we could follow the existing
> semantics and reuse @off ? that would be a nicer way to update ::len only
> by a delta.
>
> if we would stick with existing approach i would appreciate comment being
> more elaborative, where we could explain that it is simpler to wipe out
> data_len altogether from len and then just add it back.
>
> >
> >       /* check if XDP changed eth hdr such SKB needs update */
> >       eth =3D (struct ethhdr *)xdp->data;
> > --
> > 2.43.0
> >

Hi Maciej,

Thanks. I am reworking the length update around the delta and checking
whether the existing off can be reused. I am also validating the ordering
against the head/frag adjustment paths before sending v2.

Thanks,
Sun Jian
