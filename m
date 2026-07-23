Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D354399E7
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815373; cv=pass; b=FTzQYMYZoga/nyq2n+klVgca8tQCViNy+OLqiRrOIzlljk7OmymnHVGFl8QxL/Iw/1e6fU98Biuw1fuG7KGmwA6i9KRwUNkdqqMUo/wzwIhfS9/wKF/c3nlU4U6WP8voSmKeDAqgeWbxA5Ali6cvGwC6cGSybvZMzX15iJkol60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815373; c=relaxed/simple;
	bh=aSnnUvI2mi0NCU23ygzDYKRZyp/HiDYy1Aw3/z9yIt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGlgwdDpMx6MByMNiFye0fT11fB9M2cv3K4nBvCgJhQmqI36U3a4OqdoujGLuiYj8c97SI3d5AEezrCN1oOLf1CqPjFamzi2ZqQR6r4YS4PkfU7yfuUbc9zb3m6Gj0B9lH5tMF5cgBa+1Q989RsrjN5AXey+wCyXSt9XBig7ps8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ix5CUWj1; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ix5CUWj1"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeba09900bso479982e87.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784815367; cv=none;
        d=google.com; s=arc-20260327;
        b=hGyEodCUlM3DZc2rvVSohEN9RRvdWk6ynR/ETuXlSVrJrOnvrMmkg8ocaZmVmJBxPn
         j8JKA7WUzcIu8TlzfBFfgDtWd8SnTPz7u8IP6Qs7hqyDgLnhyUBAj9cCB/P7phV4xhUA
         gi2rSu4ly3aZGZ437CVSctaqQ1sKE8Z27qF6A7jNdC8j4bGGUMN6ruu2ADrLvqTTczkq
         pkMAbbuJSXn/WmeoXghxbkipzqBqBFlKiXFTX7B4rKM3Vb9Pmv1RJwaCiR7Bz16cbc5a
         uEsggoOPVjZmzNW7/rDL+L25jQ6+5Cnms+5Kd1Ol43GeGZKnrj33Dx6D1Mmu10gnHfKA
         xZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aSnnUvI2mi0NCU23ygzDYKRZyp/HiDYy1Aw3/z9yIt0=;
        fh=UAgbJirQpvb0/zIGO9iQIhX9TOQQzx1zytJQTAohSMQ=;
        b=G51dJMvSRdfJrsfzitJwK7ZzTPTQAIrKprI1ihX5Kvjmz+dFX8gHnTVYqY+rEnyBwH
         ZsUwPRdpDFAmTKheaJbYqt0/2fBea/it9JWCcao7RoI+qiraQjeqDGisvqBQ+AyvIlxA
         idh+ZfWpJt6DZ23RnRI746WdvgHizk39bC622kcp7lQ2Zs+uX/tf+bmV13O7DH77RZ+8
         HEdV39jnFLLjsDseGKssJO3IYojC/Wmr1Z67LuMNGHJY3XX0Bbh/JZ1BnF7k525PEh/4
         isszjneL+n/dJKXNflZYEs7UMrDDNGIsIMnq+hTo4BSV/EpU7/Cc+a6JVrgPBtLMPH7B
         Jiyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784815367; x=1785420167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSnnUvI2mi0NCU23ygzDYKRZyp/HiDYy1Aw3/z9yIt0=;
        b=ix5CUWj17QGmaQIuQYs/zWYWgdcB7o5PZrJL7unVZXwlDM8EYrpv/K4GETrOFZygDW
         K4VSnEqQEw+jpIDHjNippbxFfHS9uA+BlYavxFJ5dXs8sD37itCILcY2yRedELn2XRVF
         tRx2pZjayj6nSWaHmA3ACOsdDJRegdmii05eOJJmdnUZQNOM/R8cQYUTEzOyQNrr3xlY
         d7LTlMgazZeVjKyqo8TRHFKltzFH06nCiGn7sqdksLpkntzDyVIQSts8cUbQKRCn88GK
         DOh+sf+YSKMn37S/ayUztaK6VUgyC1gihJJSA7sl/2Ffj1qt3NEADCNU+QiWTb7lNUUJ
         79Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815367; x=1785420167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSnnUvI2mi0NCU23ygzDYKRZyp/HiDYy1Aw3/z9yIt0=;
        b=J+uVfznkqAm8wUN9wrfeDmqEKzCi9jOx+3F3Je49QxFslkaPK9RkUoyBNxastL/tSY
         H4JHrXFQidyBS1zAln4709K4JwHkQMZE1YQ6s02OlZi7JefjV3UEPG1Y++4IdtOg8YmE
         c+baKv6x+pxazRobAYsyHcpXQ7/E3syVZofdadsFhPkwVXLwi4DMQetL6QhvEtXF6p6T
         OUA9dBL1cQV39Vh2x+mwC0ImGJSWPBrOrD5JYe4JZ3X4G8T5EDpJZMwpzwFLuYRwKdO7
         20KdZilT0DPJMMXdWdKsqiI4EVbygRLbuxlGy6x0RGoqfHy1+vTOKKGTl9yQpc4/2Wkv
         sVzg==
X-Forwarded-Encrypted: i=1; AHgh+Rpat+EM9Spun/wSjqiPej8OdpLl/TYKQVpj9f8C1VXPk0EfcuHGMj1qMEm0KppIp2iw+YFDZcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbV0fxLS5IDO0PSeht7RmaNUy+tuTagbn7s4BugxKfGgW8qWe
	av1o+YOVVdgVJ80HQWarHtTy6ylY6Tst8S69/b1e/4hdwKEKXURm72v2zNGNTy+5JYTE/ilMn4m
	FT2jTk8wqbc0fE6u4mZODVVorHkbtThzNJ278XRd0
X-Gm-Gg: AR+sD10mNrQyajY/vKS8UC7STOgDVn9OH6XQXFctPJvUUbrXFxcVX5QXU9CYEDBoSjT
	WTmr+0bo5eg/B7uC/akqHyuMc+W62YrLsEp1Pzmopgf6tj+jL/L8ncxhvh9Tsyu86X12j1rmfiW
	UfDVZxAwad3eKmnpcua64ivmF5cVr0F3NQrIzFzQlZg9ecycu155CJWWSrV08LRY6Qu3UP/wUZf
	genQrazmAVLa+Vg7oy8+jasinUQK+JhQ4Qh57N9KqnL+Nc1rv6b+xaomzVokIADrq6utJn6ogVp
	v+YP1a412TbYX8AxjZlL2UvMt61JxGUmSFOa6e2I5vN9AhY=
X-Received: by 2002:a05:6512:6c9:b0:5b0:1dd0:f20b with SMTP id
 2adb3069b0e04-5b2b2e4b2d4mr696890e87.6.1784815366922; Thu, 23 Jul 2026
 07:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723091601.72103-1-zhaoping.shu@mediatek.com> <20260723063935.75bf55e3@kernel.org>
In-Reply-To: <20260723063935.75bf55e3@kernel.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 23 Jul 2026 16:02:09 +0200
X-Gm-Features: AUfX_mzhMSefwo5xw0q7T6LspWMg8-GnaTmUAQUYLYyQ56qOjHskx1_zLVTsEoY
Message-ID: <CA+FuTSfgBbPkdLanqEgbDq-jLVQJax4fUxQ-tuzTuFwQANwxBA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in skb_gro_receive_list()
To: Jakub Kicinski <kuba@kernel.org>
Cc: zhaoping.shu@mediatek.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	alice@isovalent.com, sd@queasysnail.net, eilaimemedsnaimel@gmail.com, 
	imv4bel@gmail.com, hw.he@mediatek.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com, 
	xiayu.zhang@mediatek.com, lambert.wang@mediatek.com, Iven.Yang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 23 Jul 2026 17:16:01 +0800 zhaoping.shu@mediatek.com wrote:
> > From: HW He <hw.he@mediatek.com>
> >
> > On devices that support both NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST,
>
> "devices that support FRAGLIST"? Isn't it a software feature?
>
> > the hardware or driver may deliver packets that have already been
>
> If you have a driver in mind please name it.
>
> > aggregated into a TCP GSO skb with frags[]. GRO may then
> > aggregate the skb again in skb_gro_receive_list().
> >
> > This can create a nested GSO skb, which is not handled correctly by the
> > later GSO segmentation paths. When the skb is segmented by
> > skb_segment_list(), it not be fully restored to the original packets.
> >
> > Avoid this by setting NAPI_GRO_CB(skb)->flush for GSO skbs before
> > aggregation.
>
> I don't think we can do this. For GRO_HW devices re-aggregating
> in SW is quite helpful, HW often runs out of contexts or times
> out too soon, generating skbs with 16kB..32kB of data, the SW
> can help bring it up to full TSO.

Also, after e751256486d0 ("net: gro: fix double aggregation of
flush-marked skbs"), it's not clear an another bug remains.

If it is: as said "nested GRO" of hw + sw GRO is intentional, e.g., for BIG=
-TCP.

But it may not be anticipated for skb_gro_receive_list. One option
would be to skip the fraglist GSO optimization for such packets.

First I'd like to understand better what exact bug remains.
