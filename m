Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505404D17A8
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005688; cv=pass; b=QrqQtZFJMg3WGL+Lsxa0uoe44+2tWCXDOpSlptJKDUJfIbF/vB2w3YOtgeIRjgP3hl4kofRBJBgB/SHdYvRCO9knv6H7IaZ/ZhwZad8+I6eQlN/V62OuDj5cMPsEmcKXZq64cgpKvmXljKjb2y63r+pqgTpHLaPoaaM2ALa/H5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005688; c=relaxed/simple;
	bh=BEARvT16wBenWkVWVBYMGXHkkv0EPzDCZ521NVaAc/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czyHGj8TpVtU3jzEZFRSE65pBK/hvInqGeBGq6w8YZwt3dZfZKGO8S8NlEbP2e8U55+6XLD0pjEQfBDTC2Yrsx3wqeIAn/b9R247vQHKxf0cl3F4smk0asbE1SpuXqmzlHqOB9dZpoRtX5MmhOzOp/nUXKuXrvmNfRXnT6fZjdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzZUQZkM; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzZUQZkM"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d0d5ae11so33247551cf.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790005679; cv=none;
        d=google.com; s=arc-20260327;
        b=sWF5/99B4ABxJkMQcZy8zgRqOukLfaU4+jzA80wM0aAj8qPCkuW0WaNA4kPdU4O2Mh
         DtiaKZnOqI8qQt28T88E1RdQIUtLcPDaw7nuUD5sv7yVkzTkMHN867FDi8SpgpgDiWVx
         hOzhPy/NBpVmDK6gFt2yx6YcmgKJV++YDzxoC3cJRfypkBmtJQrjO83F3lN+rSAVTKdp
         l09fytlnjEl8Z1aZhQ7nTJKrNNYWs5MifKGhCe0rOAjxZZl/3swv0p4nqWKWb4F2Ks+U
         pwuykRfkwGdBz9r5J6oKZSqduUcGKxzjjhupWNjW1fRNj7BKoe6Vqcs1fnLYeChoYBH6
         1S0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iE6g1Ef0J2o/f5fbrn5anstK8qfgpZs8pToEEcpe7pw=;
        fh=zxJU1XFuZoXnBBS1/iohMXZnQlaQXTzvYV1ctVU4wu0=;
        b=cFZsHzws6XF6Kn8gp/Ic+fLe2LV5SEP7Yw8249cDSzSIG3QWPqp5cY08KYiiHn4BdT
         tQiT9ZNqAP++nxSux/15hGdgcwys0qFr6HLQsWUDRKZKSsNjQgv1srpsvJu3QIqfZ/qF
         1lEH4O4DsSZiuwMhEi1gjrde0W7sAG+nmjOLo5vNZ/GbR9d/PgiTZyN4IK0k1JTYSZ56
         4XtdzcKTwDh+CJjUPMILeu63D3v/oPgJaWFVm5JMZNgDnJd3xpEyoJvRusibpIbkFa+s
         Tncc3Y64RfALltPZRnGLIr48Yjj2GyyS8w0tCghshJSljjTQiO4n7bijNYGrGAbFpV7t
         8gOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790005679; x=1790610479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iE6g1Ef0J2o/f5fbrn5anstK8qfgpZs8pToEEcpe7pw=;
        b=LzZUQZkMwiB8mpdxHKXh/TPWPyGlBqWb6MmFEo1I/h3MqzaTkD9lvdwiwjbrAcfTQ+
         Ue52aozfb77hiegTEPTzvpVM0PI5JvQqzdVHOAbq5N6wgKCaLcwt5uNzzZDG+rf/dZtl
         mZQuiEb8AklSjfnb+OnxY+Gvg+GQUSI+af2MzwTMM9yOYhpOcQARFBV5S34MfdyrTxd6
         HzU7oPxhyI1W/PCOi9Awn3Xft+yypw8oQinkMce7evDShBDZZAjDGyzpNFrYFw8RtLU7
         Kq1efZ2frhZRKrwGP2oYzH7yxnXbDEIq8zN6nRDNFgF676kJ7A6Y1ryic+pp9jt6gAzD
         7q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005679; x=1790610479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iE6g1Ef0J2o/f5fbrn5anstK8qfgpZs8pToEEcpe7pw=;
        b=ZaMDrtxsJ4Fv3okMeP8dTCnqeJUq0jRPCliHD8Qh7MlLL7xa80D6KXbqeEgzia+AXB
         FVntoa4b3poHo+H298eLW2Ux/e2EEAUAzaL0T3k80xaTiJT3S3z8n/Gz1p2IevVAboev
         1kQIqzNoI2SjdmVR0ogTRVbzHlDj8F6ENJae2ISsmKPW/s5RtjrMpAbhNi9kiW/ZnOih
         Jp+Ge776mfdJQeFlw0hcMKONqiKZAUcFAX9RWZVP9lmD06RAp3NkjytiSMNEHONJXAx7
         Z9sDSiDCJ7I+7+Nbnh7lpBTqsXoWPSqkl4kKUSkfSZt4HdgiygyTwh5dzOwOenQ4fXER
         8iVg==
X-Forwarded-Encrypted: i=1; AKwUvByQmR+NaP48USFCMHNReDPpXVCmo3pbssDjTbDBOej4KqBpB84xI+8nrQFFwYKQ48xcnuibA1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mHXtjBscrpE/ztPFv/3G2KXRWHqOOdpgLI+HKtCbNKvx1vmihA
	bAqA6TgOAvlYp1ymgLg6rAJKTLlgY4vpdN1QSeHncn/l8I/giZ8tDP0ndOEp4cewnIdt62qbPPn
	jhJYTdi/8K6orBaZfGl7IHRzZwP1RSdDlWP5UGyrM+zc8CwE73GMisIJ+j8U=
X-Gm-Gg: AYBFou35YidJ5UV5dpJT7RU/5Bi2hVLScBHvbBoh2p37d1a7/xyDYcT3/3VrqPRQy/7
	sAEB+X/6rQ46RRM6HnAsZHjTNlw/6pkMqqMoll+gp+xcLr33JTrtizb/iKnbCYNLiRcEZq+nh++
	KTTefKKkAlPtPWqCJHfEf94sKHSqtRI4kp8nvcSmoXZVwci536PGtJQOWvLd9wkX8FRsAcvnlj/
	StcPNcNv0hXTWCEMlECxF5S3/xAXMm+7ztBTHRMTWPKUs4RwR0xeIIyZLngQtg+6h78J7N0EilL
	gNCGz6t2wjCa1xVgbgQW02VRqKcdmvAxwLXh325ktyitmYoR8y/cAAP1wGqyO4NEBbfFsFNwHUe
	OfL5XkXNo0EkG48vraKfSM+MCuW4VdBrOaFmJAsywraMGTCT3p9YM/oKcMXdbZRzWq/c8kQ==
X-Received: by 2002:ac8:7d05:0:b0:532:9673:9e79 with SMTP id
 d75a77b69052e-532d8e3468cmr11664111cf.43.1790005678751; Mon, 21 Sep 2026
 08:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917132742.87117-1-kerneljasonxing@gmail.com> <179000485484.2160803.6557708738361294569@kernel.org>
In-Reply-To: <179000485484.2160803.6557708738361294569@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 17:47:47 +0200
X-Gm-Features: AcwNN1W53iwkYPE8X3tj8CG9XbjJiNh6XoUSsxjd_U6N3GmtSyuMJxE6DgPqnUs
Message-ID: <CANn89iKZiHhR3W2gm7Gy4GHBbK7ND+e9O8DYA1_xrwYvOPvGaQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: preserve timestamps across receive queue collapse
To: netdev-bot+sashiko@kernel.org
Cc: kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:34=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Incomplete fix: a fully-covered (zero-contribution) source skb
>   can still leave the collapsed skb with TCP_SKB_CB(nskb)->has_rxtstamp=
=E2=80=A6
> - [Low] Commit message does not describe the actual code placement or the
>   resulting user-visible semantics.
>
> --
>
> tcp: preserve timestamps across receive queue collapse
>
> When tcp_collapse() rebuilds receive queue skbs under memory pressure, th=
e
> cb memcpy carries has_rxtstamp over to the new skb but leaves nskb->tstam=
p
> and the hwtstamps at zero.  This patch copies tstamp and hwtstamp from th=
e
> source skb while data is being copied into the new skb.
>
> Link: https://lore.kernel.org/all/20260916124153.43457-1-kerneljasonxing@=
gmail.com/
>
> A couple of questions below.
>
> > tcp: preserve timestamps across receive queue collapse
> [ ... ]
> > Fix this by copying both tstamp and hwtstamp to the new skb right
> > after the initialization.
>
> [Severity: Low]
> Does this sentence match where the code actually landed?  The copy is not
> placed after the initialization block:
>
>         memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>         skb_copy_decrypted(nskb, skb);
>         TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(nskb)->end_seq =3D start;
>
> but instead inside the inner "while (copy > 0)" data copy loop, right aft=
er
> TCP_SKB_CB(nskb)->end_seq +=3D size.
>
> That difference is user visible: since the assignment runs once per sourc=
e
> skb merged into nskb, the collapsed skb reports the timestamp of the last
> contributing skb rather than the first.  That matches tcp_add_backlog() i=
n
> net/ipv4/tcp_ipv4.c and tcp_try_coalesce(), and the V2 note below the
> scissors says as much ("use the same semantic as tcp_add_backlog which is
> to sync the last skb"), but everything under "---" is dropped when the
> patch is applied.
>
> Could the changelog say that the timestamp of the last merged segment is
> the one kept, and drop the "right after the initialization" wording?
>
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 92bc60716f33d..bcb3861a38b9c 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5854,6 +5854,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_hea=
d *list, struct rb_root *root,
> >                               if (skb_copy_bits(skb, offset, skb_put(ns=
kb, size), size))
> >                                       BUG();
> >                               TCP_SKB_CB(nskb)->end_seq +=3D size;
> > +                             if (TCP_SKB_CB(skb)->has_rxtstamp) {
> > +                                     TCP_SKB_CB(nskb)->has_rxtstamp =
=3D true;
> > +                                     nskb->tstamp =3D skb->tstamp;
> > +                                     skb_hwtstamps(nskb)->hwtstamp =3D
> > +                                             skb_hwtstamps(skb)->hwtst=
amp;
> > +                             }
>
> [Severity: Medium]
> Can nskb still end up with has_rxtstamp set while both timestamps stay
> zero, which is the state the changelog says is being fixed?
>
> The new block only runs under "if (size > 0)", but the flag also arrives
> unconditionally through the earlier cb copy at the top of the outer loop:
>
>         memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>
> If the previous nskb filled up exactly at a source skb boundary, the inne=
r
> loop already advanced skb via tcp_collapse_one() before exiting, so the
> next outer iteration can seed nskb->cb from an skb whose
>
>         int size =3D TCP_SKB_CB(skb)->end_seq - start;
>
> is <=3D 0, i.e. a fully covered skb that contributes no bytes.  Its
> has_rxtstamp bit is inherited, the new copy is skipped, and if the skbs
> that actually supply the data have has_rxtstamp =3D=3D false, nskb keeps
> flag =3D true with tstamp and hwtstamp at zero.
>
> Fully covered skbs do stay in the ofo tree, which tcp_collapse() itself
> notes with "No new bits? It is possible on ofo queue."  One way to reach =
it
> is tcp_data_queue_ofo() coalescing into a non-last predecessor:
>
>         } else if (tcp_ooo_try_coalesce(sk, skb1,
>                                         skb, &fragstolen)) {
>                 goto coalesce_done;
>         }
>
> which extends skb1->end_seq and jumps past the merge_right loop that woul=
d
> otherwise drop the now covered successor.
>
> Downstream, tcp_recvmsg_locked() then acts on the inherited flag:
>
>         if (TCP_SKB_CB(skb)->has_rxtstamp) {
>                 tcp_update_recv_tstamps(skb, tss);
>                 *cmsg_flags |=3D TCP_CMSG_TS;
>         }
>
> and tcp_update_recv_tstamps() overwrites unconditionally:
>
>         tss->ts[0] =3D skb->tstamp;
>         tss->ts[2] =3D skb_hwtstamps(skb)->hwtstamp;
>
> so zeros replace timestamps already collected from earlier skbs in the sa=
me
> recvmsg(), and tcp_recv_timestamp() emits nothing because it is gated on
> "if (tss->ts[0] | tss->ts[2])".
>
> Would clearing TCP_SKB_CB(nskb)->has_rxtstamp right after the cb memcpy,
> so the new in-loop block is the only place that sets it, close this corne=
r
> too?
>
> >                               copy -=3D size;
> >                               start +=3D size;
> >                       }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260917132742.87117-1-kerneljasonxing%40gmail.com

The AI is right that the flag can still be inherited through the cb
memcpy from an skb
that contributes no bytes
(fully covered skb left in the ofo tree by the tcp_ooo_try_coalesce()
-> coalesce_done path).

Please add

TCP_SKB_CB(nskb)->has_rxtstamp =3D 0;
right after the memcpy(nskb->cb, ...) so that the new in-loop block is
the only place setting it,
and reword the changelog to say the timestamp of the last merged
segment is kept,
matching tcp_try_coalesce()/tcp_add_backlog().

pw-bot: cr

Thanks.
