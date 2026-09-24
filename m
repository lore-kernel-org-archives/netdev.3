Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991913B5F63
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260449; cv=pass; b=T9Zt3F7I7xBj8LtmAqdp3fGxplMJw2PTjiysonRU3NtbRbSui8glOy4AjDV9IhxJjFyr3FCgmW8EUxs9QlfpNbv4pjBmf4xhPaPAEiJBinE30iocki5G1K9P4Np1oRyt5bICosvsq1ahIIbhWdMmfAdBb0Y6sHWikQEdBtKhTqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260449; c=relaxed/simple;
	bh=LHqcR054uboSIC6o9xzvFbLFJJTIvwYwHXLuCwpUV88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEcfZqy17ZuedOleBPetXwM29NhWWX/c5Hjn5nnAgp6ZtLitgxqPDc0DJ4MJgFqfS64kQ7Lv2LFC58QqciTvkmJMNOolKa5vr9mMw7YJukheaOOfw0VZ3LXeAcA7EL68AxWL6E18AsEW0LdVioHG//XO87wOzOUKy4cpc6uD8V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2XmC9U3; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2XmC9U3"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace19so45289eec.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790260445; cv=none;
        d=google.com; s=arc-20260327;
        b=frdfiHf26rV82QD8p6bEhlFTMaSIwTK/MCoCfVsIfMsT/mQulCbJ9Sw9xsbmzfMvnz
         lXFP+tSTwtWPMYhn/+ukINO6L6sYy5DYoQ1JlnN7WVthEHOGLN1PkS4T2qZwP7Zo8VWx
         g1+Zov+SIkRjiqScvli806qWHUhI+fj6gRBqNNKpZoPP8Ck2U9a1BWAIgv0aMtYPG+ZU
         m4rdaZMB6w0sCIf1wAAeq5/20zi9S5soiLO47o3br96U48HoOYKbpKN8P1x9eWjelm1j
         yMq8Cal/kvFZvha3+ih5tN0Av4RtQIkYq+peBCZzFSEkhlf8tS0EllLF9hJf/B5h14+x
         JWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nEdt7+BgCRNDApFMM1kd/DY8OswQ71s3JE27HkEeeg8=;
        fh=SHl4NO5zZLtB8QIIzKAHoI1Zz2VASe6tkPMF4Ns6qR8=;
        b=GjyAGCnyXbWWUJh15eaFfZZs5iLOJT8lFMcLpFIVgnMUxLu5vtCksAY9Fgad1C3xrQ
         /m3U9Is/teioPRDxyvpMb/yS4ViH8UQqKnAKIe3vfpebUxvyDkKyq0GGA4zvkuvBRtmD
         4ITwbcsMvai+n9U/PIKZ/T9qjsXCaP7qkT/kqgcu/VKdSUPzblIN8yTY8EQ71Zklw/pD
         akF7jdwo/6sLwYKLCVtSZMk6DOSdgA3H3HYnZTRNeFhm1W2Eqn4Pe3sTKfWNM8D42SK2
         iYtiz4xPI0U16duUDYD583cnOOanXbCYclOvRizYu5h72iH3MlTZ+BbXM135DJFNehlM
         8/JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790260445; x=1790865245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nEdt7+BgCRNDApFMM1kd/DY8OswQ71s3JE27HkEeeg8=;
        b=R2XmC9U3JKNl1JJrDJKWe4jvctt3jRtFjCko+ZQ54r6zRa2hDqaKLlRwoSC80Bd3k4
         6PAlFbk1ubrYDnn7GmyCYX+zQre5SGVUQpRnGpMP6Qq7kitll/49RyZRg2mrxJze1ROB
         5C6ot6zs0L0/bA9UmP0F7YcI/DTGWvdYz3+aEXCV9AfTe10y4d1Y16lCRpYRmi4qaOj3
         R9YmgSGtRXiAAIzrqGYP944fws1Zkm9kqkpbDZqKu7nOoFTri/fmt3aU3dhcenMHlwKM
         iKXH6HSwiQNjW246BhVP1OzoKH8FUbwGmq0m1YecRv5JyXurA6NLKfirB5HzYi52kzr/
         gtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790260445; x=1790865245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEdt7+BgCRNDApFMM1kd/DY8OswQ71s3JE27HkEeeg8=;
        b=gGvUf4EagXygivSWmNzS7gt+1sZ18z97HjwNv2RRoNyJLKMa4Sen0aAAjFp7MLElVk
         /lz+HDQ67lLMD0nI+IsPyrXmDQnWgX8Efp8PS+pV9joitN/5LBm+vCtt7hrK9ngxmbxD
         8LEvVn+1H4ZiPtDT46NisyFvVKwPh9+a7yYTaPxwGfZtrrc6hZEv1ksiA+bbd1ZDXYYJ
         A130F03yL6Uc3r+wry4TX1q9RDSdeWB1ll8vvuqUembBJWp/cauCbpbsfhfsZeGjFToW
         0unnFtxibFnfruRFuOu91gmNLA3gPTD+HYJYbnKeOC7ALoVa9tW41wSMf+1Hse7PtGhF
         AFLg==
X-Forwarded-Encrypted: i=1; AKwUvBwpWy9zb1P/FtsBFjrjGy3OQM9PXTLL2Ydo0QXJn4jrWu/dzKF52u5LRDNymt6RbPXbhST06dA=@vger.kernel.org
X-Gm-Message-State: AFuF++l83t4u0KzLdDvswWr5Y+gRny6811OMCxzaJnWyYUuNx7T7ITgw
	xfA9jhJjOgtvfsVvyb0ek0KMGurErb/FSw/9CNXIe4NqfpvIzf87fh74ABlmBZdIUwP+aLZuk2y
	zVm0fNMQoPiEsUv8NK7sarMum6rX0SyQ=
X-Gm-Gg: AYBFou3o3n0pvLAOw+OHU+wVRr+y8qBD3kxX26/WP5WU0yn8QihngUThyT/lCZrElgb
	R8z6ZMYFeYrThdn8GobC5l0EaCY8hKdLre7bfI1xCQoOQak8sLlxLYkzmTlA/NGFPYFfJeqiBud
	GC6ZL0kH+0Yl4A/fuO5QwQGKFF9cZIMjKiFVjYjYHnRU354cyjSSzct3p59rs5/3r9quK0W74My
	SDTmWOLwukkDsJh6YWVaF3onga93XAHDiUs/WVFw/qvTnWr12bLF95TEJsm/APeQZVEc4jx48Vq
	OVDxWsS0+AIa+3I8CA5aCSFnaXAsfMn9xneqplnVmoOdzZvz+ZRIbjpq4VBCGNbeRW08ZFTM1sM
	JErzuq1MIfbh2HqGja4M58VW55RL8lH0jbQDlIg/8IYV3tMrFrv0KoXf5SS71Iclb8UFYMTW0me
	++3FfpFytlyzHK7RLSu0RGLcUYGPM3
X-Received: by 2002:a05:693c:37c3:b0:33b:afe4:fc63 with SMTP id
 5a478bee46e88-3400566dc79mr3240283eec.36.1790260444526; Thu, 24 Sep 2026
 07:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917132742.87117-1-kerneljasonxing@gmail.com>
 <179000485484.2160803.6557708738361294569@kernel.org> <CANn89iKZiHhR3W2gm7Gy4GHBbK7ND+e9O8DYA1_xrwYvOPvGaQ@mail.gmail.com>
In-Reply-To: <CANn89iKZiHhR3W2gm7Gy4GHBbK7ND+e9O8DYA1_xrwYvOPvGaQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 24 Sep 2026 22:33:23 +0800
X-Gm-Features: AclHuK8zk_QJ8E9oKEOYGate5ucNsrrv0gwTfIFYZqvOpetHjKRr86RER-v6128
Message-ID: <CAL+tcoCyiVYQhbEiv0y-4byvSLZn0iqwH5M7b0s1CP+G2pgpnQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: preserve timestamps across receive queue collapse
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:48=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Sep 21, 2026 at 5:34=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] Incomplete fix: a fully-covered (zero-contribution) source s=
kb
> >   can still leave the collapsed skb with TCP_SKB_CB(nskb)->has_rxtstamp=
=E2=80=A6
> > - [Low] Commit message does not describe the actual code placement or t=
he
> >   resulting user-visible semantics.
> >
> > --
> >
> > tcp: preserve timestamps across receive queue collapse
> >
> > When tcp_collapse() rebuilds receive queue skbs under memory pressure, =
the
> > cb memcpy carries has_rxtstamp over to the new skb but leaves nskb->tst=
amp
> > and the hwtstamps at zero.  This patch copies tstamp and hwtstamp from =
the
> > source skb while data is being copied into the new skb.
> >
> > Link: https://lore.kernel.org/all/20260916124153.43457-1-kerneljasonxin=
g@gmail.com/
> >
> > A couple of questions below.
> >
> > > tcp: preserve timestamps across receive queue collapse
> > [ ... ]
> > > Fix this by copying both tstamp and hwtstamp to the new skb right
> > > after the initialization.
> >
> > [Severity: Low]
> > Does this sentence match where the code actually landed?  The copy is n=
ot
> > placed after the initialization block:
> >
> >         memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
> >         skb_copy_decrypted(nskb, skb);
> >         TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(nskb)->end_seq =3D start;
> >
> > but instead inside the inner "while (copy > 0)" data copy loop, right a=
fter
> > TCP_SKB_CB(nskb)->end_seq +=3D size.
> >
> > That difference is user visible: since the assignment runs once per sou=
rce
> > skb merged into nskb, the collapsed skb reports the timestamp of the la=
st
> > contributing skb rather than the first.  That matches tcp_add_backlog()=
 in
> > net/ipv4/tcp_ipv4.c and tcp_try_coalesce(), and the V2 note below the
> > scissors says as much ("use the same semantic as tcp_add_backlog which =
is
> > to sync the last skb"), but everything under "---" is dropped when the
> > patch is applied.
> >
> > Could the changelog say that the timestamp of the last merged segment i=
s
> > the one kept, and drop the "right after the initialization" wording?
> >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 92bc60716f33d..bcb3861a38b9c 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -5854,6 +5854,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_h=
ead *list, struct rb_root *root,
> > >                               if (skb_copy_bits(skb, offset, skb_put(=
nskb, size), size))
> > >                                       BUG();
> > >                               TCP_SKB_CB(nskb)->end_seq +=3D size;
> > > +                             if (TCP_SKB_CB(skb)->has_rxtstamp) {
> > > +                                     TCP_SKB_CB(nskb)->has_rxtstamp =
=3D true;
> > > +                                     nskb->tstamp =3D skb->tstamp;
> > > +                                     skb_hwtstamps(nskb)->hwtstamp =
=3D
> > > +                                             skb_hwtstamps(skb)->hwt=
stamp;
> > > +                             }
> >
> > [Severity: Medium]
> > Can nskb still end up with has_rxtstamp set while both timestamps stay
> > zero, which is the state the changelog says is being fixed?
> >
> > The new block only runs under "if (size > 0)", but the flag also arrive=
s
> > unconditionally through the earlier cb copy at the top of the outer loo=
p:
> >
> >         memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
> >
> > If the previous nskb filled up exactly at a source skb boundary, the in=
ner
> > loop already advanced skb via tcp_collapse_one() before exiting, so the
> > next outer iteration can seed nskb->cb from an skb whose
> >
> >         int size =3D TCP_SKB_CB(skb)->end_seq - start;
> >
> > is <=3D 0, i.e. a fully covered skb that contributes no bytes.  Its
> > has_rxtstamp bit is inherited, the new copy is skipped, and if the skbs
> > that actually supply the data have has_rxtstamp =3D=3D false, nskb keep=
s
> > flag =3D true with tstamp and hwtstamp at zero.
> >
> > Fully covered skbs do stay in the ofo tree, which tcp_collapse() itself
> > notes with "No new bits? It is possible on ofo queue."  One way to reac=
h it
> > is tcp_data_queue_ofo() coalescing into a non-last predecessor:
> >
> >         } else if (tcp_ooo_try_coalesce(sk, skb1,
> >                                         skb, &fragstolen)) {
> >                 goto coalesce_done;
> >         }
> >
> > which extends skb1->end_seq and jumps past the merge_right loop that wo=
uld
> > otherwise drop the now covered successor.
> >
> > Downstream, tcp_recvmsg_locked() then acts on the inherited flag:
> >
> >         if (TCP_SKB_CB(skb)->has_rxtstamp) {
> >                 tcp_update_recv_tstamps(skb, tss);
> >                 *cmsg_flags |=3D TCP_CMSG_TS;
> >         }
> >
> > and tcp_update_recv_tstamps() overwrites unconditionally:
> >
> >         tss->ts[0] =3D skb->tstamp;
> >         tss->ts[2] =3D skb_hwtstamps(skb)->hwtstamp;
> >
> > so zeros replace timestamps already collected from earlier skbs in the =
same
> > recvmsg(), and tcp_recv_timestamp() emits nothing because it is gated o=
n
> > "if (tss->ts[0] | tss->ts[2])".
> >
> > Would clearing TCP_SKB_CB(nskb)->has_rxtstamp right after the cb memcpy=
,
> > so the new in-loop block is the only place that sets it, close this cor=
ner
> > too?
> >
> > >                               copy -=3D size;
> > >                               start +=3D size;
> > >                       }
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260917132742.87117-1-kerneljasonxing%40gmail.com
>
> The AI is right that the flag can still be inherited through the cb
> memcpy from an skb
> that contributes no bytes
> (fully covered skb left in the ofo tree by the tcp_ooo_try_coalesce()
> -> coalesce_done path).

Thanks for the hit!

>
> Please add
>
> TCP_SKB_CB(nskb)->has_rxtstamp =3D 0;
> right after the memcpy(nskb->cb, ...) so that the new in-loop block is
> the only place setting it,
> and reword the changelog to say the timestamp of the last merged
> segment is kept,
> matching tcp_try_coalesce()/tcp_add_backlog().

Will adjust it. V3 is coming.

Thanks,
Jason
