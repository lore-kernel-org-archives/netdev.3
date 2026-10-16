Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B34559CAC
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170912; cv=none; b=ce9ph/ylhbNF4vpovtnQ4tXqx+qmEVAEExeTk597FLy7toP6mIVZ0QhkLrgHFR5WWl++ppXjT1t3C/UFka51AgFIhqKORhbzBZM3Qpatup0wqo47AkpXxjNMpSjGm23CmnpdhlBrEG5M82KDupDNFmYZgQHan5NB1GV7pPN3CtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170912; c=relaxed/simple;
	bh=XAqAM94s1Jvjzv6bk28wxql1jd5OTzArOVTACBoHVzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCnCmoAXsizGLOeVst/yOGxP3S83YkarrlaMpx7Xi0ptLWGo2B3hRQtasWgmmxgSZIgLW/Zl7GuGUFwokHxfLSEN2OqTu+JWxh3W8+ryX/BPYbB2uHE6G98KlLaNKARjPGwYJ2bxXEexwoNCARWKEkhUcpEHHhpNs+uVa0izVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsyaxWd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsyaxWd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0561F000C8
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170911;
	bh=CeJwseVTKorSKTUuNpdGPBAJ6qYGS7qrkA5boTVbrv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UsyaxWd19zN8ASEQJT+sk2vw/YK/eAsLwySrOIz8Vka0b4OiXGmVg9bfpIX7vQiso
	 UZkdvjHsUtosngOrGkNXDhKTGfYRjMt9zido3CQ9GtWF+0cgXSlsptRGTaNCqrNUhi
	 Es2ZMKgylvCxs1X/i3CierLept5M7Ha7kCqtes5xehbbRqYanJJ1rK0bW5baRZzWSw
	 D+UWChoSm0cVPlGeUr+Ye5U9jo99RyVlEK5EnSLtSb57ZIXNfBFzVCSR+4S93p8GWz
	 TBzPqNAG3ItZiZiBhXlSE28dnETKX30kw0iKoY50V8M6fQmciJ7aSWHop0iC/3eB0k
	 l2OyObI+T5Kjg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a691d29614so107773fac.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:15:11 -0700 (PDT)
X-Gm-Message-State: AFq9FYJ34H+OHEEzNxq8UmcmMoowrBcBWn/KfNMxeiJjHyQ7xKGRtglR
	6OX1wUtEz9chJ+6GJWWZR7n/0edK9jdeqLorh9u5CTFXuY6i3pwxb5Xqgq3I4lwzmMSAXq6HtCr
	AM2mNTNEej0DXvUeJ+DIac6lRPzilcyo=
X-Received: by 2002:a05:6871:c301:b0:48f:e363:5cc6 with SMTP id
 586e51a60fabf-4a757aaeb6bmr574147fac.52.1792170910778; Fri, 16 Oct 2026
 10:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013130250.3643916-1-her@sorah.jp>
In-Reply-To: <20261013130250.3643916-1-her@sorah.jp>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 16 Oct 2026 19:14:59 +0200
X-Gmail-Original-Message-ID: <CAL4WiipGB3Ac_8sgncnf9H+JiVf5sp3074M70mGb=GjeK1gtyA@mail.gmail.com>
X-Gm-Features: AclHuK96SeQgxwsPsQUfnxDkKW643K333FhB2GrErwXMvRRoDPeGHWvPa1jOlHY
Message-ID: <CAL4WiipGB3Ac_8sgncnf9H+JiVf5sp3074M70mGb=GjeK1gtyA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: gro: don't chain linear parts larger than
 gso_size into frag_list
To: Sorah Fukumori <her@sorah.jp>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, lixiaoyan@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 13 oct. 2026 =C3=A0 15:03, Sorah Fukumori <her@sorah.jp> a =C3=A9cr=
it :
>
> skb_gro_receive() chains an skb into the frag_list of the held packet
> when its payload cannot be attached as page frags: when its head is
> not a page fragment and still holds payload, or when its head and
> frags would overflow the frags[] array of the last packet. Since commit
> 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack"), that
> skb may itself be a GSO packet whose linear part holds several
> gso_size segments. skb_segment() cannot split the linear part of a
> frag_list member across segments, so segmenting the aggregate in
> software, e.g. when forwarding it to a device without NETIF_F_FRAGLIST,
> hits
>
>   BUG_ON(skb_headlen(list_skb) > len);
>
> Fully linear GSO packets come from generic XDP. When the program does
> not support frags, netif_skb_check_for_xdp() linearizes any nonlinear
> skb with pskb_expand_head() and skb_linearize() and keeps its GSO
> metadata. GRO on the device runs before generic XDP, so each aggregate
> passed by the program carries all of its payload in a kmalloc'ed head.
> A tunnel that decapsulates these packets and runs GRO again through
> gro_cells then builds the bad frag_list. This was first seen on a
> router that forwards TCP received over VXLAN, with a non-frags XDP
> program attached in SKB mode to the underlying bond because one slave
> lacks native XDP:

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
