Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4603403EA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651245; cv=pass; b=qVJZohnEvzKgZQo8AaVmH7leacfauFbJ8vEfwS91GYjE4OjApRACLoKUIIXBDGvTT+6GgGnMA9MDYvx0qJ4mqfAkn5HFFppQej4y0X1A9knoEAnz+28hc7XZY7dRaawlLU5Of/doFR1zPn++vme2U83uicHkc8BEi8VO5J9IpUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651245; c=relaxed/simple;
	bh=Ia+bKrjXeGYPCteoi4jCek23GChqPj+L4vJ36cWqR38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0UlNh2QFUlAoIPJFWIGjsYpUMtOrV+L+sDQ8s54Ia3pjF8GgI2AYs8EGrLLCFQEWtKG6AhrjvP0FRemMyBH8rmy63Y5vcnq5cSbZ4Cy2j5K0QB3/dIr0L6UZE/20b9i3Msmr72uyCpHT71dgYIMrQ9H/t1F0kcAaHRaQkeSXXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbaj2ibO; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbaj2ibO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51bfa429aa6so8911971cf.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786651243; cv=none;
        d=google.com; s=arc-20260327;
        b=nVrW4lBqq+e1JiXakke3CsdSTBD+rTo8w5h0uWYNNz284V36I9jVP1Ga7ReEA0krsJ
         +MXbg1fjxUeRTOfefIxrBSkLSPe6QVAYg/JWE1hOgzHWEcJ8DyiuNBePWoWxm31G2Fua
         Neo5Y35w8dTSGIfV6LLJYo/mcwn+F/fDr4X/7Q5AVOXWefQ7zlrsZB9H4MqYVyKWz3Uo
         ftc71jxToCOajZsn76AVEKGFP9Mlmn3eYvpEAuhrIJpQkopyq+71FPddJkXZt+IEqJi5
         dcPFTOmgBQjsxG/h9USn8dNykO5u9Q9MDTfZz0Dvd/7FgGNVD1YuxyPp/ENCjyjK7hdF
         KUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hq3NbrKLi+x52L0mZ4bb458U6sHqlrmTZ0Zo22FSgLI=;
        fh=iZXEk/A8JyqRUHuI/PV/fyImH8i9U9DIvw5Z7gPiVSU=;
        b=sTdJfDz+fDtPY3am7mzWwJHWbvk+nCXbs8BOFkdMmtie46cTGx07hzCN/qhzs1j/8m
         NrfU2XSxP/gFJiDm5d/Tyn4WTljFTU6PuQxwWbxzc5YBL54UhzZ3jz9aXdt0jMzRPeDw
         ejGjXqCuN9Ybii8NPlwKvfIydlEGnz1jnW4c3q51nM+FI/7T+5gT2EFftEM0UoF9cCX1
         IGGrTNXjv0HsmUR9JxK83Obd7oRL0WI56Pw3k3shRlSuGVjKHm0CA5l/fmCDAjKlfzId
         1yd8aiWgPwgBM1wjltIQnJEP1/icv4QHLp2/2qE5ngciKko3BWYKeOb5w1fA2N8rUHf4
         0/RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786651243; x=1787256043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hq3NbrKLi+x52L0mZ4bb458U6sHqlrmTZ0Zo22FSgLI=;
        b=kbaj2ibOYN4IZkEwQlKs3zTsq6rmdQlcLnLbYXXlSi2uD8qQmCftvz8PeVpvR9yJPr
         bAXGmAIw3UMyddWcDQVuF/AWFIXSngdoOskCHyKdI2eSgabaSf7cXuF2TWeAd6eaM41A
         bZlxa9LkLUoxWWb2GiC/S/rlTz7yVDVimFxAX+xFhzW6EzEt8hURDnpxELY0ZuNArBDn
         gJxBvPJaus5NFp0ADDlM/vj+YpCiirGA1hbx4tF9xQismcSlFP7wLzAWONIU8khvhyJK
         BgSJU5siG6LoYHI7pzmpchlNwI8Zps1xK4I2upR+xdPm/CQjng4fhSB7kZ877cSyn+FD
         lr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651243; x=1787256043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hq3NbrKLi+x52L0mZ4bb458U6sHqlrmTZ0Zo22FSgLI=;
        b=M1zMfY9tENBQtuxMty32W5mX1cHYNwUOtBitmUjrF1FcaC13NTLQ6JYGx4hxHBHd+6
         2q/zKS7iN1HVwiy4MwVLGzA41BgmPBxVZn1VqQdxXNboDCXhp3QLSZAWiZRiZpGd/KSf
         nK+2bixB5pwMjaKmJH/VYSNiiQPJsZ5g8MNt1tOPZEVVtJEY6tYc1oqAVHWKSZonGdH8
         hlNeULNGwJ0K+PbVcr6UvzxRpmUdLpSG+F5l3ebZVCam5MskVXDMTzAL+zWhFSgGpx7j
         DRN1f+G3pOA9RowFYvRH7cxj9jivkHE5G7CdMS69srJZK5zFU/JLGLBynPKx/vFl7u9C
         4RwQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9PF+t8F3vZV3JAKzp4ZIsW0/PWPqWQR9uX7i2dkjcPhnzZZSidAvxLXLvXVI9ijQ+Hk75pJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLarIYlADgpF73jSgwdj8yoBJBwcwa6kh2NoU24JNCaC/SZn+
	2NkYHs87mRtDU5om6gmcnWFGKjozNcUaAxmXhMalcDMWwZJZz4Nc9n3PTx37ZjtIzTT809wz7X+
	KnKdCR3QGIqgIkExkd4wnqD7w+q4lqi0i5VU2ceZIyXbHmS/qPoKOKdtHrKY=
X-Gm-Gg: AR+sD11J872jglodbUBJ8sinSle7elodWGvSe9qDRw9k0qhGTD8JHhOEoesfp1a1bpM
	tPV55kyk1D3aUH+AfXGjBi4g08okiCg8bY96VfOhOU2tvyssRnDtYSOL/P2YhwBDr6AlD6MGNF0
	Y9NQR0A9/lTU4PV7kyQqcAcMXneDAd+L9wsVfSCGnlPdmk4s11L1wFB41j9XXlnLzrUWLGYxC3t
	uEywN6zYutTkR8f135OM6/a7uEjWduO6evrIjEd5ZumO4LSuTSayViQNStIdQZxuOzjtJUPUcaL
	982wzA4zI/0A+9DWmmY0Ypt7lmVKRSCVM5VQf0DMdDH+9mWvfZVkR0+GF5J7Py9oPSAyOv7Wf/d
	w/kGbP11uvoIOGfWmdANxd3dR884Cen14q+7uBrj96UMpnm8PsmCcEjscsHPV/Vq07SgvV/+7U9
	kFeEMDKrIUuei4l8k=
X-Received: by 2002:ac8:5d01:0:b0:51c:885:3225 with SMTP id
 d75a77b69052e-52d84ff2bc9mr7360541cf.12.1786651241776; Thu, 13 Aug 2026
 13:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731185431.2777685-1-gmj@meta.com> <CANn89i+wCHgSr3i7T_q6XL=n_JOSLF92LeWicy+_jJG3Lz4dAg@mail.gmail.com>
In-Reply-To: <CANn89i+wCHgSr3i7T_q6XL=n_JOSLF92LeWicy+_jJG3Lz4dAg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Aug 2026 22:00:30 +0200
X-Gm-Features: AUfX_mxT8cQbDvGem19ISZ3_gw6VmclLuRamJmBhE9xcLHgPI761Sa-Whb2ckOA
Message-ID: <CANn89iLC3dQdqnQmMkv6mMvfvhsrcHqxfWqawYa=H=ZVxDR_XA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: gro: coalesce padded small IPv4 TCP segments
To: Glenn Judd <gmj@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Richard Gobert <richardbgobert@gmail.com>, Kees Cook <kees@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:54=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jul 31, 2026 at 8:54=E2=80=AFPM Glenn Judd <gmj@meta.com> wrote:
> >
> > Software GRO fails to coalesce small IPv4/TCP segment that was
> > padded up to the 60-byte minimum Ethernet frame.
> >
> > The selftest tools/testing/selftests/drivers/net/hw/gro.py subtest
> > sw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
> > In current code, it receives {100, 1} (no coalescing) instead.
> >
> > Cause: inet_gro_receive() computes its flush term from
> > tot_len ^ skb_gro_len() before skb_gro_pull(), while skb_gro_len()
> > still includes trailing Ethernet padding. A small IPv4/TCP segment
> > padded up to the 60-byte minimum frame has tot_len !=3D skb_gro_len(),
> > so flush is set and the runt never coalesces.
> >
> > Assisted-by: Claude:claude-opus-4-8
> > Assisted-by: Codex:gpt-5.6
> > Assisted-by: Meta:internal-AI-tooling
> > Signed-off-by: Glenn Judd <gmj@meta.com>
> > ---
> >
> > Notes:
> >     RFC notes
> >     ---------
> >     Per Jakub Kicinski, the open question is fast-path cost: this adds =
two
> >     operations to the common IPv4 GRO path for every packet -- reading
> >     iph->tot_len and the skb_gro_len() comparison.  Everything expensiv=
e
> >     (linear check, trim, pointer refresh, csum recompute) is behind unl=
ikely()
> >     on the slow path.  Is that per-packet cost worth the coalescing win=
 for
> >     padded runts?
> >
> >     Testing: netdevsim cannot reproduce this -- it never pads short fra=
mes to
> >     ETH_ZLEN -- so sw_ipv4_data_lrg_1byte passes trivially there.  Repr=
oduced
> >     and fixed on a real NIC (cx7): baseline FAIL -> patched PASS.  Also
> >     validated locally under KASAN + CONFIG_FAIL_SKB_REALLOC (no UAF).
> >
> >  net/ipv4/af_inet.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index 32d006c1a8ee..998ff77fd7b9 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -1470,6 +1470,7 @@ struct sk_buff *inet_gro_receive(struct list_head=
 *head, struct sk_buff *skb)
> >         const struct net_offload *ops;
> >         struct sk_buff *pp =3D NULL;
> >         const struct iphdr *iph;
> > +       unsigned int tot_len;
> >         struct sk_buff *p;
> >         unsigned int hlen;
> >         unsigned int off;
> > @@ -1498,6 +1499,25 @@ struct sk_buff *inet_gro_receive(struct list_hea=
d *head, struct sk_buff *skb)
> >                 goto out;
> >
> >         NAPI_GRO_CB(skb)->proto =3D proto;
> > +
> > +       tot_len =3D ntohs(iph->tot_len);
> > +       if (unlikely(skb_gro_len(skb) > tot_len)) {
> > +               if (!skb_is_nonlinear(skb)) {
> > +                       if (tot_len < sizeof(*iph) ||
> > +                           pskb_trim_rcsum(skb, off + tot_len))
> > +                               goto out;
> > +
> > +                       NAPI_GRO_CB(skb)->frag0 =3D skb->data;
> > +                       NAPI_GRO_CB(skb)->frag0_len =3D skb->len;

Also do not change frag0 and frag0_len: In GRO, frag0 is strictly
reserved for page-fragmented skbs (napi_gro_frags(), where
!skb_headlen(skb)).
For linear skbs, frag0 must remain NULL.
Calling iph =3D skb_gro_header(skb, hlen, off) is sufficient to refresh
iph in case pskb_trim_rcsum() reallocated the head.

> > +                       iph =3D skb_gro_header(skb, hlen, off);
> > +                       if (unlikely(!iph))
> > +                               goto out;
> > +                       if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE)
> > +                               NAPI_GRO_CB(skb)->csum =3D
> > +                                       skb_checksum(skb, off, tot_len,=
 0);
>
> This seems potentially expensive in a malicious network environment.
> An attacker could force the host to recompute checksums by adding one
> extra byte to the frames.
>
> We can infer what adjustment needs to be done on  NAPI_GRO_CB(skb)->csum
> based on the skb->csum changes done by  pskb_trim_rcsum()
>
>   __wsum csum =3D skb->csum;
>
>   if (tot_len < sizeof(*iph) ||
>       pskb_trim_rcsum(skb, off + tot_len))
>           goto out;
>
>   NAPI_GRO_CB(skb)->csum =3D csum_add(NAPI_GRO_CB(skb)->csum,
>                                                csum_sub(skb->csum, csum))=
;
>
>
> > +               }
> > +       }
> > +
> >         flush =3D (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (n=
tohl(*(__be32 *)&iph->id) & ~IP_DF));
> >
> >         list_for_each_entry(p, head, list) {
> >
> > base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
> > --
> > 2.53.0-Meta
> >
