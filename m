Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634836;
	b=ULKJWvkfUVpeaJkG+ia/POWPvb9ZPRq8hpHA0BM1mqZsIg0YdXcB3PGzv4dbbrS482jz
	 UIsXiur9rC9iuM8SdvxVixz9yrvHIw2CP/CCol2Yt7/7zutM0lJgPwRX7+a7n8o1mF4RP
	 R/1mohnFGEMkdbY3Cq71d6crw8J5R7TjXjAr4B2NOX6P1zJUoSTz2ho0NKvRPf1ITnheG
	 gb6BmjZT/vSRgQqUx6Vyf2Lkm7pTFDzlNG6keZqzvPRX50ZLR9LCdIlB0oNA7cF3tNUsB
	 8HNqOEEPW++jx0F0GlVQvZ2tCO1vpu36bEWFMM3pokd0u9XuhjRlVd4gTR8zRxpSl5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634836;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=772ZW7xwS5Lb6OoXbHUKU95CKNMFhT7w/NVTOJdJ/Iw=;
	b=QuAPTigzzdlK1xWgyy+r0Je+Ppxtl+Y/XdMDvuZh/JxQofbTCvd6dcxYmxqlfsVqE4pq
	 hSuRejS3W181FLFjzuhK1pdRHUQy9bYYabVa4+oW+daS5fLcTf+J3tF2CYlwXgwHDzIV0
	 sOcrIp8pbyh3Q/eUlPZF1OHKQ7sy5wLWa+9bTWjfIRg6KZ865oyl1/bDhvzS+JwARmlZ2
	 0crwrLmm8hTraHgWbBoL/R8vUDpHVFwkCEFCN8y7ZbBB9ADgVjtlGm9ViS3XCaTa+c/7+
	 q519B76jCNC1eHopMwP1rHy+4yqWRKTeU8AcV0uGZFBzai88Xxv6dIS+zMVgqWjtSWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kWw/Ia+Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6D607B786
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWw/Ia+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28481F00A1B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634835;
	bh=772ZW7xwS5Lb6OoXbHUKU95CKNMFhT7w/NVTOJdJ/Iw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kWw/Ia+QjBzhXnj5i8zWqJ7FJZCWcXqxeK6lp99YwbsXoRBZdVxV7Lm4RD9rVDjzI
	 YjDIEsgSi/dTSk7E18MHQk+ZXh8i6K59ZfzW8dNCSv8lVh0pqGPuWu1QsN6THQGdY/
	 FmM/xkCazevo7gxf4zKL1npDrSnNfypDsUytbOZt0ikdOHJJrVw0K6qdDdjJkt3i1y
	 9DEoIQo7Zg+FZdKHs22Tbmv+0MSWNGnzVFnXNyEF+wHOpAmo5rS3i38Zfj+E5ZZ0ME
	 EyTiRoTtAItHBuqrc4/FYw8hBLpkAPstO+gE8Ywe+n5XCmNLfTOzXv7m5FPe45+aF7
	 obbnVv88a8muQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-71528ede7b1so544162eaf.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzYldSM/VgMQzUnZ+FxFfK4zpwin4XV+suRh+Iop/tsIrmqOvgW6VUtS3EgYfoI4z5+lKX/ot0=@vger.kernel.org
X-Gm-Message-State: AFq9FYITv3fAMQfnBuOz6a1+Pb72vk66qbWqDciWqtGS62DvNZ127PTx
	2MpDQp9uo/Gj7O96gfkaSgpq+I4OTCdH4LpzjaEz5U/EVaTOPS6pLirxWtZBMlYRTmnMDp0B1qH
	x5rbfQ9cQqQ7+FogJ6PzneCjoE1TpqjA=
X-Received: by 2002:a05:6820:f033:b0:712:c751:22e4 with SMTP id
 006d021491bc7-714f29918demr6803097eaf.35.1793634834935; Mon, 02 Nov 2026
 07:53:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030081225.2575462-1-edumazet@kernel.org> <24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com>
In-Reply-To: <24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 16:53:44 +0100
X-Gmail-Original-Message-ID: <CAL4Wiio-LDx1Z4uWwmUmTP-Xs+Gt=gaM_9T054ZSdY=t3afQJw@mail.gmail.com>
X-Gm-Features: AclHuK_-XE5Vpi_c17l84qWtsRUvWrKeAkHo-16LCcc1h6-7Xgfi8MPFo7166qQ
Message-ID: <CAL4Wiio-LDx1Z4uWwmUmTP-Xs+Gt=gaM_9T054ZSdY=t3afQJw@mail.gmail.com>
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly queue
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	netdev@vger.kernel.org, stable@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 16:04, Paolo Abeni <pabeni@redhat.com> a =C3=A9c=
rit :
>
> On 10/30/26 09:12, Eric Dumazet wrote:
> > The truesize of fragments in a reassembly queue is only bounded by
> > the per netns ipfrag_high_thresh sysctl, which has no upper limit.
> >
> > inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> > If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> > adjustment of the socket owning the reassembled skb can cancel its own
> > reference, leading to a use-after-free of this socket.
> >
> > This can be triggered from an unprivileged user/network namespace,
> > raising ipfrag_high_thresh and using padded TUN packets, which keep
> > a large truesize after being trimmed by ip_rcv_core().
>
> Clasiko infers a similar scenario is still reachable using multiple
> concurrent frag queues:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030081225.257546=
2-1-edumazet@kernel.org
>
> I'm unsure if that should be dealt with separately?!?

Sashiko is right that this is still reachable, but it's a pre-existing
issue and the consequence differs:
the charge per reassembly is now positive and below INT_MAX/2, so
__refcount_add() saturates (WARN + leaked socket)
instead of wrapping, and the UAF is gone.

I'd like to keep v2 as the minimal stable fix and send a separate
patch bounding the sk_wmem_alloc
charge in inet_frag_reasm_prepare() against the socket's sndbuf.

Thanks.
