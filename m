Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA845FFB8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390295; cv=pass; b=XDKaTHcEF8hGy1g6qbzn68iUm/gnNzPV5+Ax9q3sw9zxfPCqqD4xkg35G3bXCmFNQEPwEN9C0bWCuCqMEAYNEFssGHqXDDH9fd+S5yds8qeJU9OBFLqEbhX/d5dmRrQ61vSBWuTS/x4aEH7BcPZhioL7AOGN16QKMR52ZafgkaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390295; c=relaxed/simple;
	bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyADnik2vj6ZomGtQATPcEMrPnaWu8EEToTKO5fwQYPwpMQd7QRPi2yXV/nMnIgmXeeC54Ymkik52YgMDo+TBy5QqCEdU81eUkntoFC7OP707O4qsuQLsqTswNRnBIdrgRlOmqUuX1ViW0yt0Xz1t7p1zeIxicMIUJ7Ib620sZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+VK7vZR; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+VK7vZR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so1610884a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788390289; cv=none;
        d=google.com; s=arc-20260327;
        b=cWw7rS5uIzEvLLoXlghO1OE12VSsEjytOgO6Fkus77Dfb+/XtArcT8+ClfU3SAcnhc
         sm935C0uON7jhxK/rO7Rt0H9pJylUtgfnALEKxmsFrB811m+B33IcAAufnhsjMbUDZ4I
         c1+MAuofw3Rq3JUmfzUysAJbVnS+4ZH9YN5DOWskZgUpogHzk146LexLrnfNIi8yPe3s
         5AsoHMYlJ9pRwqZ+Jnw2YX/hKu8vZhNXXvCs6/V8xDBoSWjw++WSHPCzxwXuN+PHmyVG
         GV7PI8AYlvRFODBw/r9BKCHYVjq5+tWhsbDBKKn4wllVCWpnIXJmhjTBD9LTXTJ+m4CU
         siWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
        fh=NM5tCeMyKk2WAP4wzBEqscGBGkH96fA8kRfvwhr957w=;
        b=eJNvmuCDoqWEiDA2xhpnizo0Hlch5g6emwxjjZD7exKTnlvBwsVmTyLWmYW5F5RVj9
         vWJcfaCr2PO/2rQ57nuxoChACc5UE+HwpSZ02z87lKNAyibN0VbyU2/+Q9lMa//cKjtN
         OwD6Ue2fL/ym3Lbx5jHtQue+a7wrAM9N9uQ9pZmDw90zHYETvhZKxnpOzcagyYKxAbOp
         fJLl544AJp5ROzgJg6/JGuS9v9efnUjLaRIXRY4HDM6xS5YMp5tqAde0QDhhgbmpEW+U
         n6lgyBmy1XXRZ13F9t8+sg9NCIDGpg/kAbpfl/1f/z7NL2Wf9HSn2wQVd1OVPJiievK8
         mB1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788390289; x=1788995089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
        b=E+VK7vZRF+UAaweMQupmYJcDtfYBCXTmfbly6iB1bEIecnOxjhl3ZGTJP85kBzzba3
         BWfclCerpJFce0/ObOT0+5u57AMR/Ld9bNfttf5t/9uwIDH79+wsNfQx99uMrcmOf2Jy
         eNVS1dcHV0YsbgjWFwjiYQ+vhiQacebt0Y1RkeIwA7K9xYmQpAnK0T1k+hBuK4ROQzUu
         /0UR5SEGv192wGNrPfOX2R/ZLK9UPTjV0thLrPUbgArW2Uq97ld+4RwBGpp7rjRLxbsJ
         RoRuAKKT8D6TGBjkWFf4IHUUSb+ceyqI8uTKL/ns5wg/GZJORktsGcT13kZ+6ae7n/9C
         WaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390289; x=1788995089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
        b=jye3WBequ0uZeK44cnucE9iw0vBkv7eyTwD6BLA40clbq2owOyJROSShbEmbUiHAY1
         QHEp/DDLV5dmVv5sim7i5TGur6vT9/5VRbvW5X5Oe4RmDfHlzISYO0TpCBf9MWH9NSJ7
         +DPlI9sHzuWyzMw9RPLkhaIdz6TDsKOeOz0eWzesF6UWAIrF71fjPjR8fXSbO3z9E5yk
         mRs601DyXrKpZYzKUEVtb3t3KZopuyPP8uATf2mgNQiPOPb51XKkqUteEuXPtItRXRIC
         V+cBd6968kMgFOioql9fXnnJjOBdrR9KyX1/ZI0DwFfpkot711HvBEEAe9q2gYsC3Yfs
         GTCg==
X-Forwarded-Encrypted: i=1; AKwUvBw7C83GL1yGwjO6/nVPFLkdnNi3yF7QT/LJX4T83BYf1eL1cILjqViwPBo/wPIZo4mvNtYjXVE=@vger.kernel.org
X-Gm-Message-State: AFuF++nBHYqitJMdaofBWss05aGhN01/wC0eowZF41G9Tb0wbrU20g2L
	Dr0qxiJ/Ny2dtyA56+iXDLOX43v2UYkLJ5TYag/S60J3MjuHbV2C4KusCHvdsyJHgD1PWpBb9m/
	+QpZMnEGmo2pdOqHCQUL4lzY3t4TTiiLaCK/1rtg3
X-Gm-Gg: AYBFou3ckTrhpHsu6ioxsaPIJz3I7MEkSGM1ggToO/Ur9A4TXLMGl4AWXGQ0Ajx4nPO
	j4i2HIoCAvUZSQnhs75VQiYHbZD57Z0xxzomVcz29QFkCJPrLlX2GCJl5jOoQLvKPSfp5PC4IPP
	phUyqe5NDKoFtLamZak53qGEpoQ96WWEtfVjCUFQS7QebARRoGhgL/mYjX8xXY6FZcBKNN61dpN
	MION/2xnUl6HEgYIVgOismPeozawLsHNvK6d++jgvyHZ4jEV+gyyKsIS0tG3l45VQ7dQVjfS6fn
	G+wixlP8xK7xgSxG1xMyn5klJfFG/RX70HAtEp2rX1CE66hAMSt+pfo0dYPF8gdm2IpGLJJUcA2
	c32h+6rSSARIKbldqCvWl90/TizR2zVnhZqVAihxwgQw/XGA+benISav7HgVQloCZn4JcubwThw
	tJYcs0g50OmmuN
X-Received: by 2002:a17:90b:2649:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39aee249be6mr12032469a91.25.1788390288724; Wed, 02 Sep 2026
 16:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <CAAVpQUC==6KEBs3XgFjZ536mJ23cbHma8HuiWMu1DRc_=YYOHg@mail.gmail.com> <20260902155216.4fa23444@kernel.org>
In-Reply-To: <20260902155216.4fa23444@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 16:04:36 -0700
X-Gm-Features: AcwNN1UkbVzkWQ8FDXuwY9XPS95VYwqDS1NMCf7kWqvgYjJkEoK_LkIEshdICok
Message-ID: <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix socket leaks around connect(AF_UNSPEC)+listen()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 2 Sep 2026 11:58:49 -0700 Kuniyuki Iwashima wrote:
> > > Several BPF socket helpers acquire a socket reference only when
> > > sk_is_refcounted() =3D=3D true, and release it, independently, by
> > > re-evaluating sk_is_refcounted() again at the time the release runs. =
TCP
> > > connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established sock=
et.
> >
> > Due to several bug reports, we are now inclined to forbid the
> > buggy transformation.
> > https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=3DuHxGj3s-WueguRo1Z_=
4FxO=3D02KLmwmQ@mail.gmail.com/
>
> Kuniyuki, would you be willing to send a patch to do that?
> Not sure if anyone else is planning to, I wasn't..

Sure, I'll post one like this with s/synchronize_rcu()/-EINVAL/g
https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.com/
