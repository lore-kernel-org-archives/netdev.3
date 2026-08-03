Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212D377574
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752089; cv=pass; b=oW5/JvIzqhlKuSATdayqdXLac5AVDmshDafPd0dW+1DcVFPeQPly375mMwe2i5tDA/uh7y/HvI6zo+LSsrw8j+7mwz8hwwwHIMq6uhfMzBqhjoPXdQDV8cYkqtXaWHda5S5Uok50XCRjlpwtW8QYia7CZJxIg3qhU4Wjj8SU2Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752089; c=relaxed/simple;
	bh=gAGAUv0xZN3unMadQ+Q0yg6cGFB8E+F+y+wNougceUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7LvC5AwV43wTjHeaGHzmXrCVT0swnbFlzgQ3O1tHn9y/PLyb4hg9z60V4jKgMfZHdSuBbdQHyAE6RjdPPuBj0YHCaQid737QixfC1gYcMzJfocBGfqMGzuM/QmBz0KKmUqh84UcEIupr0ZQN1xPQX/WrO5eRqy5NrD+wrDlGKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJf/F4UL; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJf/F4UL"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66807ba2f0fso4562808d50.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 03:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785752086; cv=none;
        d=google.com; s=arc-20260327;
        b=g7iMyRwryKPYrG3OKHFwpOYy/v3O7RtluEDYWTcun2Qt8MLjE/MUApPMV1XHUhJoGp
         yXL4LdTCJLtLAzB9JooXqBEH+fGqT9Js0+iM2Hnurs6+5fEaofcPepR5joqftmkOqjIq
         TI1zVezXIlKTVsvaPA1OoVKyvnTIlNyfLGkUvnAq3Y6GGgWoGhhPvbNUYuqrP+muV9GI
         dDmMg0+pOxSMof3kcDaB/UVE6jAKuC9szS8fnKrkWCP5/mAqhOds2YfMIZvJWBlV7Z07
         wmTklABVspA7KN013W8gWIkLPijgD/GhW9hQUIv7buNPHBuDAWvwtvg0ukBA/9Os3tff
         Dtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BzmVrf3A5yS5pBlOOrTATRIeczmTdyqSxUxktv0y96U=;
        fh=ji24XnrXSvQIowberQ8dNbEj5FMOHR7Z7N1AVv7wHsg=;
        b=Du3Fe+Z9yaCA2NmVpBfpxgEaA3Cj0MRw77/4wvqvEJWB68Gz1m40GeTbzleHdi1kAT
         kHW3B2OdlbsCJhKCHCxwmTsWHzRpnLqd7nKIpnBJb0Rbyxn2TCXbpF66pi0ADKaq7ObC
         ymPZnbBIGEIfcVS8ul8UZgIpJrnBamJq1wViGWPTcOUNv22qfvar93XT93d4/33eQPcl
         cHQQc9GKSLXf/H8v2vOOg1+tz43S+h8cWU88f7if/AxEs4MVXrZPV6l5zR871pQtSgu1
         gXQZj+fCUrHpJIjSZlmJu4rserYr3ezfqkYWYK28LMwYBzXifF0oNAivReMdPdnVmWAK
         pICg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752086; x=1786356886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BzmVrf3A5yS5pBlOOrTATRIeczmTdyqSxUxktv0y96U=;
        b=eJf/F4ULf+4f76f8Q/NN/yD7rLBvEv6Zim1LMt8046dW/OeU1xjUtqrIZfVlSERmN1
         7Qd1Z4Z+KWEHVv7clMkcwonP6sygNbnTfNd31lx0Jbl1Qiav/Ldkf4kFXsyIrbI7foMk
         lFsWnV7XotIMAR/1rB7mU/0RcQ0PBWerMI4W+HVREg7CwIy+tXXtbD4S8IVMcr47/BIX
         2sBWNzQMWbnbYIUncUzhfCYnxWm9bxzba6xqwp65Qs676u78TUfgNNbED8WePG5DiaID
         nLdpMDWL9u77jl8sEubLn0dCZP9V3S7Sgkt5LQewzr4vDY/9fVZTcT42g+suUham/e07
         KJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752086; x=1786356886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzmVrf3A5yS5pBlOOrTATRIeczmTdyqSxUxktv0y96U=;
        b=EHWyg0wDps1NIdD87P/3Ipz8Ss4cSbyFhym9CtXPUpAP5QyBjAysnDJ5HR/ufEg2ar
         jmuqRIJUP3qK0oY5cqSpJhOQxk0q3ScqRuOwWAighbwUGYqOeY0nHLR3GRUt1fbVcqdG
         f6lWxMnq7GpGDzM6GBWM43qWT14t0A6hrXpVkNtURzcsW/AB9ot8CC83kXTB4ml+gvsq
         ow8EjjPZb4u3hGj3rQOePqgAnCwEDBhtN6IuOggVJn7BwM/wGTrXAevKg0s7iO5k8vEa
         4PGN4BqhFVE/vO7TMqpkZL723CdKnz+Kynbsux/sHXo6gb1ykjqLQtGGdt/QdyvigWnR
         LdmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMlklxvCRPuvQpN7jYR08SgK0smHjhuk79tUu0L6zpwTPQT6vs1v1LAkzu+iukqmtOWVN6q08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkYkyTA8WhH8j05UfEt37Xsoy9XsbArP6mzaFDLl1Ou8G0Qua
	BAvKj6SZe5/QQzrXHgy+0TV0mziLrbMMU+WF5CCYy3R2R4KCJFMJ5ZbtF5v5F/k6en4z3Be9Rtk
	sh0A1n5DIxAAj6kcu1IvEgNnAZpNCah8=
X-Gm-Gg: AR+sD10lvOjbC4inIZm8spT/ve0tuxMK3a9q1KxdTPVkTq27X1qjRd1V49lywz3/zA+
	vhpiYMWCcbbpsUNffymIUQ9j5xZqyk0sn9ZMD9wm0UFrn0adMhMt0pEI4a/xnYQucmW4agg+lEM
	FZpQKtxQrQT6Fccod2sN6T73PLZ80zQGPMisMTZMilvYDUnBvMQgUHrroy+GePjLCc6uv6cHYgL
	j26Wzw2AH9+ID2gTGjtRSbTS6AURIzZSz/2/MLRSK6axM88JSH2y4369WCkJ2BtLQ7jf/QnaFdW
	oRj4I14EU92DT+qdPs/WnUszN3orwJVrGsTkkUKt2Km+JcqVGz2G5iyIMXG/hgvH0Xjz7tAI7k+
	ed9sOq89RNpIX61BojLJXcX8=
X-Received: by 2002:a05:690e:4810:b0:664:f064:f663 with SMTP id
 956f58d0204a3-6694f15a12cmr8115341d50.28.1785752085633; Mon, 03 Aug 2026
 03:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com> <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
 <CABFUUZGTJptpOKKAeU3ThibmPpXize4Eud2=EBX-vqaX3YH4pg@mail.gmail.com> <anBUWIxmURvbr04i@lore-desk>
In-Reply-To: <anBUWIxmURvbr04i@lore-desk>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 3 Aug 2026 18:14:34 +0800
X-Gm-Features: AUfX_mzdeHrInwG6bTPBGc0xnW3lweBnwEFe9T99a8tN3R763lJ6zfwZrV1QoDY
Message-ID: <CABFUUZGYauuj1EpwzfhwWrqQY8zaE7SFk-UAbwxy3qCbEDWKjg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP frag adjustment
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	maciej.fijalkowski@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 4:42=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> > On Sat, Aug 1, 2026 at 12:14=E2=80=AFAM Mohsin Bashir <mohsin.bashr@gma=
il.com> wrote:
> > >
> > >
> > >
> > > On 7/30/26 8:23 PM, Sun Jian wrote:
> > > > veth exposes non-linear skb fragments through an xdp_buff. If an XD=
P
> > > > program adjusts the fragment area, veth_xdp_rcv_skb() copies
> > > > xdp_frags_size back to skb->data_len but leaves skb->len containing=
 the
> > > > old fragment contribution.
> > > >
> > > > After a fragment shrink, this makes skb_headlen() larger than the a=
ctual
> > > > linear area. In the reproduced UDP receive path, __skb_datagram_ite=
r()
> > > > copied 1024 bytes past the actual linear tail to userspace, startin=
g at
> > > > struct skb_shared_info. The copied bytes included the affected skb'=
s
> > > > nr_frags, xdp_frags_size and a kernel pointer from
> > > > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the sa=
me
> > > > amount and truncated at the end.
> > > >
> > > > Subtract the old data_len before replacing it and add the new data_=
len
> > > > afterwards, keeping skb->len and skb->data_len synchronized.
> > > >
> > > > The fragment accounting must run before the linear tail adjustment:
> > > > when bpf_xdp_adjust_tail() shrinks the packet into the linear area =
it
> > > > releases all fragments, and __skb_put() requires skb->data_len =3D=
=3D 0
> > > > by that point.
> > > >
> > > > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shorten=
ed by
> > > > 1024 bytes from its fragment area. Before the fix, all 10 runs prod=
uced
> > > > corrupted payloads. After the fix, all 10 runs matched the expected
> > > > payload exactly.
> > > >
> > > > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to acc=
ept non-linear skb")
> > > > Cc: stable@vger.kernel.org
> > > > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > > > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > > > ---
> > > >   drivers/net/veth.c | 23 +++++++++++++++--------
> > > >   1 file changed, 15 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > > index 00e34afd858e..348391e87e14 100644
> > > > --- a/drivers/net/veth.c
> > > > +++ b/drivers/net/veth.c
> > > > @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struc=
t veth_rq *rq,
> > > >
> > > >       skb_reset_mac_header(skb);
> > > >
> > > > -     /* check if bpf_xdp_adjust_tail was used */
> > > > -     off =3D xdp->data_end - orig_data_end;
> > > > -     if (off !=3D 0)
> > > > -             __skb_put(skb, off); /* positive on grow, negative on=
 shrink */
> > > > -
> > > >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF help=
ers
> > > > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len her=
e.
> > > > +      * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contri=
bution
> > > > +      * from skb->len before updating data_len, then add the new o=
ne back.
> > > > +      * This must precede the linear tail adjustment below: a chan=
ged
> > > > +      * data_end implies that no fragments remain, and __skb_put()=
 requires
> > > > +      * a linear skb.
> > > >        */
> > > > -     if (xdp_buff_has_frags(xdp))
> > > > +     skb->len -=3D skb->data_len;
> > > > +     if (xdp_buff_has_frags(xdp)) {
> > > >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > > > -     else
> > > > +             skb->len +=3D skb->data_len;
> > > > +     } else {
> > > >               skb->data_len =3D 0;
> > > > +     }
> > > > +
> > > > +     /* check if bpf_xdp_adjust_tail was used */
> > > > +     off =3D xdp->data_end - orig_data_end;
> > > > +     if (off !=3D 0)
> > > > +             __skb_put(skb, off); /* positive on grow, negative on=
 shrink */
> > > >
> > > >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> > > >
> > >
> > > I am most likely missing something here but what happens if we have
> > > frags and we attempt to advance data_end while leaving some frags
> > > present (e.g., bpf_xdp_pull_data())? Looks like, in that case we woul=
d
> > > issue __skb_put(skb, off) with off > 0 and we would hit
> > > SKB_LINEAR_ASSERT() because skb is still non-linear?
> >
> > Hi Mohsin,
> >
> > Thanks for catching this. You're right that bpf_xdp_pull_data() can adv=
ance
> > data_end while leaving frags present. I'll investigate this path and fo=
llow up.
> >
> > Thanks,
> > Sun Jian
>
Hi Lorenzo,

> I guess we should implement the same approach used in
> bpf_prog_run_generic_xdp(), something like:
>
>         if (off) {
>                 skb_set_tail_pointer();
>                 skb->len +=3D off;
>         }
Yes, that makes sense. I confirmed Mohsin's case: bpf_xdp_pull_data()
can advance data_end while keeping frags, so the current v2 can hit
SKB_LINEAR_ASSERT() through __skb_put() on a non-linear skb.

I tested the skb_set_tail_pointer() + skb->len update approach locally
with a forced-tailroom reproducer, and it fixes that path. I will fold
this into v3.

Thanks,
Sun Jian
>
> Regards,
> Lorenzo
