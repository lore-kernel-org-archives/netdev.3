Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D79401A0B
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786650857; cv=pass; b=ail0k6EJAbv2sHI/YrHQJFdn5/vGarhVEm04f9WwJ6Wi/jh1NwNikbVSKk8bewDtSblNbo5JPAHkh4DOxk+cwz8C3btLk8g76YN65I5NMTOZ8cI8Wf+ADp3eQ8zS8ug91XvXP1Q4tJQFTfxICperdCHwT03BWbWwmi2oOSJC2OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786650857; c=relaxed/simple;
	bh=ZN9KPsqgIwye5ERfJERXbVME+BGvhntK+ESJ9K0f8SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK3HhVD64xWl8RF70N0ebq6jIxu8xO70GFXCM/BB+UbI0NrcLWqIBi3dRSzaTkmVz7rJmMFa/P4XL0Mh5JWcAQTo/deKZHM85IIkkmT5xyoCTSpDQFTu8MJwwSsj0goNKGCNGw17TT1FkGm0aP00ZH5Hgz57QkBRozsUEv0TjEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyftqS3O; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyftqS3O"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c1372f84dso2471661cf.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786650854; cv=none;
        d=google.com; s=arc-20260327;
        b=rTdoG1FuW1D4LXsvVMZ4/zLCfSnh9r4yY30/miP+qWkorK/SpolM7C6Tgt3xcUQ5qL
         91QDkkYFWH5SzfY9r9Zo1rnwyygdo4Pn/K+yc91uiyCUCWKboAQwj2w+TdhAfOPps2kN
         ny37KAlw6R+Gw6NFeC/yodHtx2oVIKu2eHT1lFiOhUHCknaT0QPuew+MWNCD7vk3gUBS
         nfu01Z81OWFNc7m49ASJBf1b5PPb980biTQm/XZU0duOWQaAPXdx+AO+RConN7z/m6R5
         GENRAfjagfU4ORtXiNtPBsVF/oYB3dJdirL/EMLtSUAJ5gdrXqvsx6NA+u/eKF6qklIu
         eiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3EaD04p3QXuzUOByvDF34Mu19wcoxpmtDCQd9QY+Q3A=;
        fh=1NaL5oEch7li336mjw5jssNxwAZxl83RQB3ZouXHJCY=;
        b=mbpUBkBBs/4URohHKS/hLprl5ae6XeiabsdStmTZ6Jhb88A4a/q3hZ/jH+UCz9Uklb
         ZbWYT6pJAYu0W1gvwriqsC734e3b0xb2dQ/OSlPp7miPJV/uiHanzO4Eun+BfTn82KIo
         +tfJORyrgI9dkFNKWA80BCuSoGcOZHEnqHF4MPbYxA59cj/0a4D1xIjjeL9heSOG7UkR
         X+Y3ZwtENriuZ2asIDmSpAxmMpc8ba//LzIZOFJ+CBEeuKx+XaFHWY7hwnMapRhHk7xT
         jvGQBsxQhc8mHxGuYpwe3uAJOunp/UNBB7HlHuAxmvoRaaFkHQiKyEJLsLuA7pc+/CSa
         tlzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786650854; x=1787255654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3EaD04p3QXuzUOByvDF34Mu19wcoxpmtDCQd9QY+Q3A=;
        b=dyftqS3OE5SCNhXJ7hFuzoooGF6Td9xW86PLJ097Ssyx9zg6X3qrjAsXf7wOL54LYz
         fTt8bOEPG5CuBVLePzgaBBvioo+X1jlWPb41rGWNqkbIklPoZC3hfv+wupcLIEYwIng+
         nBYeeU3uITRd3t8eJT4iKilAZis7AhHgVrRdr8Ehz0lgzcBO/wtlUCi/3MGqZ3UgEwqU
         JJhcSmVPKTh8NYz+7vYho8B1HP1UEAsmMxwSA74IUac0RZqMEvfezpTQ93SPS23HFhwp
         QkeE76xUGkcDbYOogQtM/DDATtEuCD05/nsMtXx8rbK0Q35POOTLv5xjBb8p1lypDufR
         ND9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786650854; x=1787255654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EaD04p3QXuzUOByvDF34Mu19wcoxpmtDCQd9QY+Q3A=;
        b=sctIYBGB/Mh6LoOVqpmh3wJSw04yNoUoxI/KDByFgUkL98TQelu2FtrKlp24FlD7WA
         ArK1hLmmb7CtEi8csWV/GVlLThV+zMHLM6QFBrGBB6w5MemiXyhy4N1Mxi0p9PvuNog2
         bjCvlAxtlEwlCqDAX5osiSMeobpyGIx/lQ47vhY6SX4B5XZhOsCTLLaKYEupPXz8p7IG
         XNCZJPLCotB+g5HVC+ngaCfpH+Ll8flPTBiAtUtMVVfPEoXBVHKaghK3te88J+GFu7Ck
         nvzh/8whgQ10Qhkju+3EzHxfC/7bKHcrmTpFunOVPHa+6FuDe4vH0IVaNd9xqxkvgxxC
         4R0g==
X-Forwarded-Encrypted: i=1; AHgh+RqgSGWWYAjZQ6dMEmMA/3oi+UlJJF41dU5N5/Rlf7f81Xi5hHBr5JuDef5MEj4rpybKIZTxffI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfTp5vIxe0tVtWU9p2yppM2PMuengNFVkGpAnmP4dSvnAyJy+
	nA9/u13mP4EZPq6if4OSgosoteV+ypFMY4CU85LHLp07NL6H0Bf0zgJR9WSgH14umY8usY1eRyf
	4uP8qHEZlW2/INtnyunLU+NTe1urAayBQiTQ6q20dj3t8BoEU6Yw7NOv1IY8=
X-Gm-Gg: AR+sD13DEhAv15AbtfR049H3BtJuubt3Gp2E28euHCR9UmeyEu68e5SljY40id8zr5h
	XYL0QgyZQzdf8Hx+FL2OqduRsUPPz5QIDwcY0NrLocKuCpYvF7HvUSwsRLOD+I4agjTtVZpRH0d
	EgXU8/yKGaDDkQfRqi/SUQUy9XyjwyBwqst/dtgIrpWWcckvh+CtROu5sFlybg/PccGGAUSN2rC
	mcd5tt/az7ZQ9UbpAmyCqRlVDobsaz8NGSmomAO6w3zAF1dSSE2Tm2X8+Hrm6gYoH9wR8a2dn3M
	8kFF0LqPn9CG9XvSy2uu4LT9i4w9PPs21HOJObrPn4W4Z2FXxONKzWPerYjfNeVovHTbk9mYF3P
	oqkktKM6xb5FvkPtMZlaxBApvYl8B4m/ONCwQuc3cD9So4vZqioaPJie62JhlIuONB+fgBnY8b2
	r3LYhbjFtqOdEQS3Q=
X-Received: by 2002:ac8:5a08:0:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-52d853ba508mr5250601cf.2.1786650853656; Thu, 13 Aug 2026
 12:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731185431.2777685-1-gmj@meta.com>
In-Reply-To: <20260731185431.2777685-1-gmj@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Aug 2026 21:54:01 +0200
X-Gm-Features: AUfX_mxnImwOH7kIhnMzOb375t5MrtKhjQlbJsZyt6LWxfhRKT_-IbwGqCzsAF8
Message-ID: <CANn89i+wCHgSr3i7T_q6XL=n_JOSLF92LeWicy+_jJG3Lz4dAg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: gro: coalesce padded small IPv4 TCP segments
To: Glenn Judd <gmj@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Richard Gobert <richardbgobert@gmail.com>, Kees Cook <kees@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 8:54=E2=80=AFPM Glenn Judd <gmj@meta.com> wrote:
>
> Software GRO fails to coalesce small IPv4/TCP segment that was
> padded up to the 60-byte minimum Ethernet frame.
>
> The selftest tools/testing/selftests/drivers/net/hw/gro.py subtest
> sw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
> In current code, it receives {100, 1} (no coalescing) instead.
>
> Cause: inet_gro_receive() computes its flush term from
> tot_len ^ skb_gro_len() before skb_gro_pull(), while skb_gro_len()
> still includes trailing Ethernet padding. A small IPv4/TCP segment
> padded up to the 60-byte minimum frame has tot_len !=3D skb_gro_len(),
> so flush is set and the runt never coalesces.
>
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5.6
> Assisted-by: Meta:internal-AI-tooling
> Signed-off-by: Glenn Judd <gmj@meta.com>
> ---
>
> Notes:
>     RFC notes
>     ---------
>     Per Jakub Kicinski, the open question is fast-path cost: this adds tw=
o
>     operations to the common IPv4 GRO path for every packet -- reading
>     iph->tot_len and the skb_gro_len() comparison.  Everything expensive
>     (linear check, trim, pointer refresh, csum recompute) is behind unlik=
ely()
>     on the slow path.  Is that per-packet cost worth the coalescing win f=
or
>     padded runts?
>
>     Testing: netdevsim cannot reproduce this -- it never pads short frame=
s to
>     ETH_ZLEN -- so sw_ipv4_data_lrg_1byte passes trivially there.  Reprod=
uced
>     and fixed on a real NIC (cx7): baseline FAIL -> patched PASS.  Also
>     validated locally under KASAN + CONFIG_FAIL_SKB_REALLOC (no UAF).
>
>  net/ipv4/af_inet.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 32d006c1a8ee..998ff77fd7b9 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1470,6 +1470,7 @@ struct sk_buff *inet_gro_receive(struct list_head *=
head, struct sk_buff *skb)
>         const struct net_offload *ops;
>         struct sk_buff *pp =3D NULL;
>         const struct iphdr *iph;
> +       unsigned int tot_len;
>         struct sk_buff *p;
>         unsigned int hlen;
>         unsigned int off;
> @@ -1498,6 +1499,25 @@ struct sk_buff *inet_gro_receive(struct list_head =
*head, struct sk_buff *skb)
>                 goto out;
>
>         NAPI_GRO_CB(skb)->proto =3D proto;
> +
> +       tot_len =3D ntohs(iph->tot_len);
> +       if (unlikely(skb_gro_len(skb) > tot_len)) {
> +               if (!skb_is_nonlinear(skb)) {
> +                       if (tot_len < sizeof(*iph) ||
> +                           pskb_trim_rcsum(skb, off + tot_len))
> +                               goto out;
> +
> +                       NAPI_GRO_CB(skb)->frag0 =3D skb->data;
> +                       NAPI_GRO_CB(skb)->frag0_len =3D skb->len;
> +                       iph =3D skb_gro_header(skb, hlen, off);
> +                       if (unlikely(!iph))
> +                               goto out;
> +                       if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE)
> +                               NAPI_GRO_CB(skb)->csum =3D
> +                                       skb_checksum(skb, off, tot_len, 0=
);

This seems potentially expensive in a malicious network environment.
An attacker could force the host to recompute checksums by adding one
extra byte to the frames.

We can infer what adjustment needs to be done on  NAPI_GRO_CB(skb)->csum
based on the skb->csum changes done by  pskb_trim_rcsum()

  __wsum csum =3D skb->csum;

  if (tot_len < sizeof(*iph) ||
      pskb_trim_rcsum(skb, off + tot_len))
          goto out;

  NAPI_GRO_CB(skb)->csum =3D csum_add(NAPI_GRO_CB(skb)->csum,
                                               csum_sub(skb->csum, csum));


> +               }
> +       }
> +
>         flush =3D (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (nto=
hl(*(__be32 *)&iph->id) & ~IP_DF));
>
>         list_for_each_entry(p, head, list) {
>
> base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
> --
> 2.53.0-Meta
>
