Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084825;
	b=smpZyhnqgJNPSHX18xaLtLNl035WfN+ZxzLxE4YkUmZtpdn5qJ6APbOIdO2RFwLMdCuk
	 IBMScPBBFJ7Ochagk2G4eNtlhy4QnxB/qU0O/yf4e86d33nLrRHnPyJzglmaYG1Y3KiU8
	 GU315r8BfawjtVa9rgoWSAPQc0uyXwE32wJ5/VWrxHKhvm+VdOLAsQ5LK2JkT2WbFLdnM
	 +mYImzR/AFizIsbp1siRCgKhG2NwlOM3sWag8o/9b0KJhwi+W2w0dbpQQBLCd9H4EURer
	 nrgCfkf+YO0zwUYEmcYnx8ehij9WB6CFf3jClBtPNjIbe/XM2JG6Zd3Vet091QURrHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084825;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Haij1UMGI31cJqxu2zopCZgwJAF8QICo8mOxt+3rrII=;
	b=fFCr8R24fuM5ZxUa0++UVkAw45PDRS/6awZEc+OqyGCWcuLZS4u7ws1oM0M+Vi2qaMwJ
	 n3WebbIRxD2/buMcWIu7JG+n6RyyWw2l+ulZNYapZ5z/sBc3IPKo2BF2xyCwKeBnmNrJ3
	 cy3R4Cvjl2RCJQgXCsPS0tNvBFMRAzgpZkx3CmFskImz+YrFiHcP9ftY8EBddtOZab/ho
	 i36uV/8FkqZMhh3nE7dorhWUwv88AWDdhuJDzAjARpDG3uIlQn01eCj2LwbmPvDLCyfVp
	 A0Fq3JZUShagPMgnP4Qo/MDvKxGJUbPjNtcCJsXGF/88L6PnSe2qWmBNR+58DFyzA9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fT0F8iCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE53606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fT0F8iCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666B41F01825
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793084824;
	bh=Haij1UMGI31cJqxu2zopCZgwJAF8QICo8mOxt+3rrII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fT0F8iCoZMuj8/wjSjb0BHVbhQV1zhGjDM5Hz/rdImckfkHN0Zdf/dcmjUHswKHf3
	 9iFeHMtT3t2F1LWeUm5k8g5W4rG37JDhwuVsy3SoF4KUH6NTYXwYh7oJcX7lXLDp1P
	 TJUTpHxP+bJ5g1eoCJxUV92G4xTkzV3T63L0yrgphrY3V4UsCummnirAXWNr/PGPux
	 lJ2QQo8pUm03ri9UpY1Fgp6AaSeMSN25tAe0bBHNePHWge20FEIW3I3SfnHAHuods1
	 Wx5pE/K2PoYHgf95+kDqs9/GPmxnLn4FY8eHp6hLsh78fKz/CCQNWqB8UoqzDz98ae
	 s6T6gEHnPIxEg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-483a66818edso1885496fac.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:07:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwxbJr3GzHH15rj1bN3NbLLhq0tGL7i/diQe0uomsfaeuee6i3bgB4Sa2d9d+tap2jE//NQbTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5zU4N6LhvbKy+pIA1VV59TCX61Lb2dgC7qXaHt9Gn6cW8KWq8
	W3JpFtkLFPkYtVH7Ia9aSTrfn+xs4J6rtLRuwBYcI1/yqwaYQHgIz+kypL1KOrMwjj+R0DuBaXP
	Oyk6LM63DM6m2Y5R3Fl7xMmcRx/5DPXQ=
X-Received: by 2002:a05:6870:1641:b0:497:4b0a:61fa with SMTP id
 586e51a60fabf-4a83f48b0b9mr5659905fac.28.1793084823789; Tue, 27 Oct 2026
 00:07:03 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024004835.17862-1-user148783812897@gmail.com> <auAA6ww0o6W07hGF@google.com>
In-Reply-To: <auAA6ww0o6W07hGF@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 08:06:52 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqu-tO8pVaLpGeeKneuSY+6X-1OchyXf6zNG9mfq=CQXg@mail.gmail.com>
X-Gm-Features: AclHuK9tZmdKALCq4z_lDeF2v4rWTvmmDPqjsb821Np52nbuDnodqoxjrRygB3U
Message-ID: <CAL4Wiiqu-tO8pVaLpGeeKneuSY+6X-1OchyXf6zNG9mfq=CQXg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: limit priority VLAN untag depth
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kamil Sawicki <user148783812897@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 02:40, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> On Fri, 23 Oct 2026 20:48:35 -0400, Kamil Sawicki wrote:
> > The priority VLAN receive path can repeatedly remove VID 0 tags and ret=
ry
> > packet processing. Unlike the read-only VLAN protocol parser, this path=
 has
> > no limit on the number of nested tags it consumes.
> >
> > Each skb_vlan_untag() advances skb->data and resets header offsets. The
> > offsets are stored in 16-bit fields. With enough nested tags, the netwo=
rk
> > or transport offset can wrap. A later protocol handler can then derive =
a
> > large pull length from the wrapped offsets and access memory outside th=
e
> > skb allocation.
> >
> > Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
> > Count the tag already stored in skb VLAN metadata as the first level, t=
hen
> > stop before untagging a ninth level. Keep the accounting inside this
> > uncommon branch so the regular VLAN receive path is unaffected.
> >
> > A single VID 0 priority tag before a real VLAN tag is valid. No normal
> > deployment was found that intentionally emits multiple consecutive VID =
0
> > tags; permitting eight levels is therefore conservative.
> >
> > The issue was found while researching the Linux network receive path fo=
r
> > Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. =
The
> > affected path, reproducer and fix were manually reviewed and tested.
> >
> > Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
