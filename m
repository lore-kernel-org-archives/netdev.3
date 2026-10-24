Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792830176;
	b=WGjd/GCpAr6nhm0WuRrCzWLCEPYaWp8Gcw1eP9Y1An8qUrqajV7ZyUJjW7hsRflvav/j
	 3lL9hrD5dYd4nZ8UW9JtYB4KNnlXlIvEeLhQD6vkC8QayHuC2R1eUyT+ack2SpYjG6xCL
	 sRiHZA0A2Y5TaBtlrkahXLiRLSDR24THerCw8ZmbjFLNe8X0PGqbxM8RLD1AgngwK4hZn
	 t1+qTjPFEr1CXskv640KX5lIfCkWfPT5kJkzcET1gw67YA6R9yQpg8R2tDJLriwJn6asf
	 q+yaoAglVmDpAKW31Bux/6rhzN4SqG+abkOb6kWkKvhGtR0m7NS1Yvu1Spor6K7Yqiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792830176;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Pf9LCz6OljNAat3cS0OtJ2Vbp0Q0oJbVMd/1ym7N+sI=;
	b=km9Z8NtOGAZYfMg4mZQdW10U6TU24njolq6CuCViaEXe3bVb5q7RRQrH006qybHjP1yr
	 /JlsXN5KMjKdny13DS68iDvL1g9ovXIRTkgA0B+nUUTnjR5OrHstkBni26IYvTofFqnb0
	 DgjUz6dezRBJ7xwF8xnqnbObvjeE0qr6IykTvTeqYSA4Ukai6aE70oJ3W2F8F9RIOBrex
	 j0qaeMIngmcnd9NNlivC2Dp/9G2hqSQVwB+sKp3wo0Fo4Ob0U/mwub7RF/Lx0nB9jAay4
	 DyUYQRawsdofHGjRAEbnFqmyLtq3W6bjQ+teNHBoGPcrgNQVZ99HYjz+xxfCWKSMF9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUj0GwNH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98832606A32D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUj0GwNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F4A1F01825
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792830176;
	bh=Pf9LCz6OljNAat3cS0OtJ2Vbp0Q0oJbVMd/1ym7N+sI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NUj0GwNHiilp3mi4pm0JKQ6caF/pYBln0+rOAi4unFZn1RnqYjrneOoz/Sy46m3y4
	 kugGNCwtM5j8Uip/zHgr1rYJ2HVueZEMbWrZO0MDQwH2r01IPOW+kifUlco5dwcpuh
	 Iio2QH6nFG0g7O2Ei6dhCwkQOYvbknSQAT/gE+QBzqv/y/3gko7TMzIgfKOF9oACTB
	 EpPvAA6cbd+MIEom5IrMCdf7mF+CDxodaxOUF5zMdCC8YY92d/MmClaqxBKZYE7FLz
	 Jpdhk1n8fhLQtRN9NGQnTglhS/cUaJ4h3bthistMfdwTW4Z4Ek+fP+cVjbOmiEYpR+
	 +b0daNoIIAOfw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6de1fd5f572so786127eaf.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 01:22:56 -0700 (PDT)
X-Gm-Message-State: AFq9FYJG1+FzzWThrbx39dVwBlVeLvQu189eLXfEqo8MnagQlvPpCSGf
	Gb7nv9eJTKVb5nC1v30xnFRbk/Qlmr8Z9Bj1zfw+Mj8SG1eeLctCQGgd6+7h+AWvoARVVfOVZzn
	qs7GF4nU9K2K9IMWKlKj9PyenlUlZH6U=
X-Received: by 2002:a05:6820:351a:20b0:70a:4053:52d2 with SMTP id
 006d021491bc7-70ba0f0e13fmr382361eaf.72.1792830175840; Sat, 24 Oct 2026
 01:22:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024004835.17862-1-user148783812897@gmail.com>
In-Reply-To: <20261024004835.17862-1-user148783812897@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 24 Oct 2026 10:22:45 +0200
X-Gmail-Original-Message-ID: <CAL4WiiosFWCD1Eh2KqepZupiZm0de7bUs72fBgh1AOQkL=BCzw@mail.gmail.com>
X-Gm-Features: AclHuK-oQLgWnV9Q5oHz0rKQ-UF_EVKTiTNU1RJpEcLfw7kcKwftdg32nKc4AEs
Message-ID: <CAL4WiiosFWCD1Eh2KqepZupiZm0de7bUs72fBgh1AOQkL=BCzw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: limit priority VLAN untag depth
To: Kamil Sawicki <user148783812897@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 24 oct. 2026 =C3=A0 02:49, Kamil Sawicki
<user148783812897@gmail.com> a =C3=A9crit :
>
> The priority VLAN receive path can repeatedly remove VID 0 tags and retry
> packet processing. Unlike the read-only VLAN protocol parser, this path h=
as
> no limit on the number of nested tags it consumes.
>
> Each skb_vlan_untag() advances skb->data and resets header offsets. The
> offsets are stored in 16-bit fields. With enough nested tags, the network
> or transport offset can wrap. A later protocol handler can then derive a
> large pull length from the wrapped offsets and access memory outside the
> skb allocation.
>
> Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
> Count the tag already stored in skb VLAN metadata as the first level, the=
n
> stop before untagging a ninth level. Keep the accounting inside this
> uncommon branch so the regular VLAN receive path is unaffected.
>
> A single VID 0 priority tag before a real VLAN tag is valid. No normal
> deployment was found that intentionally emits multiple consecutive VID 0
> tags; permitting eight levels is therefore conservative.
>
> The issue was found while researching the Linux network receive path for
> Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. Th=
e
> affected path, reproducer and fix were manually reviewed and tested.
>
> Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
