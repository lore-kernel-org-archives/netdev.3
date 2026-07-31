Received: from mail-lr2-f6.google.com (mail-lr2-f6.google.com [74.125.230.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27339183A
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507249; cv=pass; b=Ah18X3ORH8bGBlfiZ0CCxZE2/O9pD9owY3b234ztcPa8OcpbmHAveC2d50DVxOEIVUbteezkdUKDnph1xg0luBzhtgykY6o7fdb+eUFdD1vqqrCMAGC4VppClwjyxunJEfRwddgp70g4dGPT1d+ZUgu7aEWZmcmiBtY/+QDdUQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507249; c=relaxed/simple;
	bh=QWbHsyomC+Vt6jnGtH1PeKdDc6IM2MGfTFAKr4TDcVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKv93A9tV5k3qVU5oyOlXsUf7WWixsDsOyNKrwK77yslk3NC+1TUalGcXG252MutRifkgfojJuIOS5Bp5xB7hUzwJwiK6eLRIceWfhwQmMUZF3cSuiryqGKla5dWgNeun1dTRDiFhhfM+rO5IN4e5/6Dqw5U1c/zPrpicfk9kCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eNB8dyqb; arc=pass smtp.client-ip=74.125.230.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eNB8dyqb"
Received: by mail-lr2-f6.google.com with SMTP id 38308e7fff4ca-39f75e1eaacso5131801fa.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785507246; cv=none;
        d=google.com; s=arc-20260327;
        b=NWrFoReq72eNzPqfkCv1bg6D8Bw51PUgw3lRaUM92GZ99d3PAsZGET1+RSdxBXR1Rq
         AbPdXgb+E3ptJw3jlWITHonygseJiCP/onQZ+Zkw8mv+pibIwmNbzOKaG7fU3UJ9/DWJ
         RGnh0VG6NQLWofZTpZHg+ilwyK4W9quOUDbhMtr1ZXmWjytLUc71lg+e+ak0wH+HFzDJ
         x3do9cCQg+tY3M5RKXT5ZYr3KBbxQESPS2jAPb8dbIMjXQwOeFljAsowHK7TmeeubGt3
         gGmwzNuTO4YL+JqFw+BdSJG7okY7hXhl+SW2DnBNQsFhO91aW2nJ7d/U9VhkdK21axcd
         OLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mRQJ/X+SGTzv15Q7duaiiJabgAZzBpXySieJ8L7TpTc=;
        fh=rVtzb7ZQL8GCwN+azDR9ciMnosWv8d86BB0OjYxfvN0=;
        b=m+i4HyCjFaZnmoCFEKInTfn9+gqs7GdTU4SDEitW+jNozQQFBUNSn24eoDcIuiBl4L
         T3QjFHItbgaSriR+2pqebvgNK3jjcfXjDS2I9A1J9sp7S9bWCeMDiWp6fK2iRStY+R1B
         vgmd0KlvPYnGXFE4fAMeH9XOs08Ti22Q+A1MqN7maUBbrAUmDz+xs+YxPPli1Hkxfr3c
         hMRLOU/EVqXv0Xke/GjVBQynBGRpyTbruhou3GQLN4ff80+DBTpNJtKgo/vW8MVObwnr
         c8M3Ijm7X7mj/9+peW9pvj1I0X32aZSCxt2Jo8a5fSqcOQVsGrBYg9atS6B7wTMBMYvX
         pqhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785507246; x=1786112046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mRQJ/X+SGTzv15Q7duaiiJabgAZzBpXySieJ8L7TpTc=;
        b=eNB8dyqbKpvu0UCJpHvF8rm2XA3eyIfz+oJt+9gOy0aIitfaZ7Uf44Mc2QnEVxvABq
         y0ywy5N67CIVbWDttcR3Hc7GNCktCYYarr34QWsnvFtl2KOnxdMzVf9o0aTs8XeQNqdJ
         nPQnVWYJinh66B033mHxhh5rCDNotCcPFRezlbzcJyG+UlNWOanubb5AfV6DJV2xQVJK
         BLU9OQvRzjhQtT9V/xW4Ji9SXGPTbp1VDMqpGpLhZ1S4S44tsfN/Dl1zHyGlTh/Hq8N0
         /kTsSY4nCq3P5Vt+kNcavqQO7daaBaQlczO5HR3jD3EErHPqBPZHjglWGjARNwoEus+T
         SC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507246; x=1786112046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRQJ/X+SGTzv15Q7duaiiJabgAZzBpXySieJ8L7TpTc=;
        b=KfZFQ5Q4CvRX80oFAFazIbNxJiXmPe5OeMadOTCctIGK0CGPqwGLwMjrIEiZbXXQgH
         xU/Z1MoUXANRiruFCoiE7MdSJ0FAfhUJ4gIdXBytmWZUTMyn8Kpdnlj5FyDYD659t/YA
         v+8+pD4nGUch9x08altA7rTvo14v6IoI4yZDAT7HSQS2OSWx80lskEHGIaeZJjgarKSQ
         f+IULgPKfriojSrbnPgWOmKA4b0abL9uL8CYEsos9rJPpGhLxIJP11HRspc1wJDJ422H
         NKu1Mig/ZW8q6B1cSWcV6cfzw8IUQGIOoYd7nZT9sQ3cl+/iDQf229eS7dqW1diK1N50
         TQYw==
X-Gm-Message-State: AOJu0Yzg9OAt9zFHfObeHI1i7KzqPLEOGiWitlqBR5DkTzFeD4sFNbZQ
	7sDcL2yTn+gJ0l3h++P3/m4Kg0BmH7Dh/gee1pVQ2RQNhR8qSaDMYm8DTZy9Qd+O58vSYY0S2vX
	CElbY8Q91Xqm+eB77dFn1j1ehm/DJpEwAaoYwOvbyHtM=
X-Gm-Gg: AR+sD1004X54Y1A3368tK0pkgmYI4tLqSeugPL3EGIb+rxR8Vrf5t2wHl/yoeysPPSR
	ci7Z8/kXgyApPwmgBHyszrN6vkAU2czMxlYuLoD//rhRZ2ydTfqQ1dkEijBAM34ZbrwOYHlHmo1
	n61gvND7VSryYF8rvRuyXgV2qcQgNNHP8l9su3gHidFYHpsURqWT5ZAjNduW6kRSFDnqxbhwmhc
	ac2HPCY9NXOdg23RQHAGbU9cty4PvZgHLHM+kkDJ6TGFl0Iq5QIWMpUsWAIwwL7BGY71NE5vpUQ
	TIPSppfRaThTTtS3TrpNeqfbQoXBTCDr/3M/+F3/FgYXwbg=
X-Received: by 2002:a05:651c:19a1:b0:396:9cbb:673e with SMTP id
 38308e7fff4ca-39f7e430c12mr4282241fa.24.1785507245441; Fri, 31 Jul 2026
 07:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c773b2726dda8d90eed6d42b2f9741810a7a46e1.1785288876.git.zhilinz@nebusec.ai>
 <82d57a4c-297e-42e4-baac-5ea431c32447@ovn.org>
In-Reply-To: <82d57a4c-297e-42e4-baac-5ea431c32447@ovn.org>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Fri, 31 Jul 2026 22:13:52 +0800
X-Gm-Features: AUfX_mydAqE65LKw88oRWOYkN-mn63hey5KFK2qkDqtyvuOXQQ1eWW9KyePd6bw
Message-ID: <CANB6i5ysfmVnQV=RG5nwgJM0iOH=hmY5AnufNYRgLXmBRqgE0w@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net: openvswitch: reallocate update replies
 for mismatched IDs
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com, 
	echaudro@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 9:43=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 7/29/26 3:53 PM, Zhiling Zou wrote:
> > ovs_flow_cmd_new() preallocates the optional reply skb before it takes
> > ovs_mutex and before it knows which existing flow will be updated.
> >
> > That is normally fine because the skb is sized from the request flow
> > identifier.  That identifier also becomes the inserted flow's identifie=
r.
> > For updates, however, a request with a UFID may miss the UFID lookup an=
d
> > then fall back to the flow key lookup.  That lookup can legitimately fi=
nd
> > an existing key-identified flow.  UFIDs are optional and the flow key i=
s
> > the primary identifier.
> >
> > For echoed replies, ovs_flow_cmd_fill_info() writes the matched flow's
> > identifier, not the request identifier used for the preallocation.  A s=
hort
> > request UFID can therefore leave too little room for the key identifier=
.
> > The fill can then fail with -EMSGSIZE and hit the BUG_ON(error < 0) in =
the
> > update path.
> >
> > Once the update target has been resolved, reallocate the reply skb if t=
he
> > matched flow needs a larger reply than the request identifier allowed. =
 Do
> > this before replacing the actions so the request can still fail cleanly=
 if
> > the rare extra allocation fails.
> >
> > Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> > ---
> > changes in v3:
> > - Compare computed reply sizes instead of UFID contents.
> > - Inline the rare reallocation check and add spacing around the update =
checks.
> > - v2 Link: https://lore.kernel.org/all/71380bcfbf3aed9a6a8a9daeef6592fa=
5a4fb245.1785211788.git.zhilinz@nebusec.ai/
> >
> > changes in v2:
> > - Preserve valid key/UFID mixed flow updates as requested by Ilya Maxim=
ets.
> > - Reallocate the echoed reply skb with the matched flow identifier befo=
re replacing actions.
> > - v1 Link: https://lore.kernel.org/all/fa4f85fe7becb164a8a1849aa77ceeb1=
c08b078c.1784881178.git.zhilinz@nebusec.ai/
> >
> >  net/openvswitch/datapath.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index eaf332b156d73..3007d75b42145 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -1113,9 +1113,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, =
struct genl_info *info)
> >                       error =3D -EEXIST;
> >                       goto err_unlock_ovs;
> >               }
> > -             /* The flow identifier has to be the same for flow update=
s.
> > -              * Look for any overlapping flow.
> > -              */
> > +
> > +             /* Look for any overlapping flow. */
> >               if (unlikely(!ovs_flow_cmp(flow, &match))) {
> >                       if (ovs_identifier_is_key(&flow->id))
> >                               flow =3D ovs_flow_tbl_lookup_exact(&dp->t=
able,
> > @@ -1127,6 +1126,25 @@ static int ovs_flow_cmd_new(struct sk_buff *skb,=
 struct genl_info *info)
> >                               goto err_unlock_ovs;
> >                       }
> >               }
> > +
> > +             if (unlikely(reply &&
> > +                          ovs_flow_cmd_msg_size(acts, &new_flow->id,
> > +                                                ufid_flags) <
> > +                          ovs_flow_cmd_msg_size(acts, &flow->id,
> > +                                                ufid_flags))) {
>
> This version seems fine too me code-wise, but this construct is hard to
> read.  There isn't a particularly good way to format this, but maybe
> something like the following will be easier on the eyes:
>
>                 if (unlikely(reply)) {
>                         size_t current, desired;
>
>                         current =3D ovs_flow_cmd_msg_size(acts, &new_flow=
->id,
>                                                         ufid_flags);
>                         desired =3D ovs_flow_cmd_msg_size(acts, &flow->id=
,
>                                                         ufid_flags);
>                         if (current < desired) {
>                                 struct sk_buff *resized;
>
>                                 resized =3D ovs_flow_cmd_alloc_info(acts,
>                                                                   &flow->=
id,
>                                                                   info, f=
alse,
>                                                                   ufid_fl=
ags);
>                                 if (IS_ERR(resized)) {
>                                         error =3D PTR_ERR(resized);
>                                         goto err_unlock_ovs;
>                                 }
>                                 kfree_skb(reply);
>                                 reply =3D resized;
>                         }
>                 }
>
> Best regards, Ilya Maximets.
>

Thanks, I agree this is easier to read. I will send v4 with the
reallocation check split as suggested.

> > +                     struct sk_buff *new_reply;
> > +
> > +                     new_reply =3D ovs_flow_cmd_alloc_info(acts, &flow=
->id,
> > +                                                         info, false,
> > +                                                         ufid_flags);
> > +                     if (IS_ERR(new_reply)) {
> > +                             error =3D PTR_ERR(new_reply);
> > +                             goto err_unlock_ovs;
> > +                     }
> > +                     kfree_skb(reply);
> > +                     reply =3D new_reply;
> > +             }
> > +
> >               /* Update actions. */
> >               old_acts =3D ovsl_dereference(flow->sf_acts);
> >               rcu_assign_pointer(flow->sf_acts, acts);
>
