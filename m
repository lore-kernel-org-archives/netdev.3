Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711292;
	b=DDqmsgoTG336R6TR5BaYKr8TcMi86z/mx58JhHJUBnAKDtw019bC115wFdB4bfSmGKrC
	 jFqL67WA2kWgnoqfo/4FR5APJ6ESHtnevZTanJA5lwVziqlJPUYkCTEfWSBDJVfNW6mgq
	 9RmTL4pk4UWDZ3FRdPMuTlq5DmTO0mjE8ddTvrz/w2+5/zZp4h0LhJUdLx5bzisEH5UKJ
	 zI0C6rl4BKfZPN6Y3vMR8GAXJsZ0cpy1E2Qw9r8MpNcFMuRq5myp0Bq3nlmHs2qkGK6cq
	 jOx7es8LItbY5s3obSdiLNc7VfTlbgU2b/9GxNZs0Sd10ugRXWwvT1eJP/96E33Y2SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711292;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9G2Juop9m4yYRvSwrC6ILNCsmsnKaKioHaaLbaf4ZaY=;
	b=rVg9ZYCbG1KJwEVHKP5rsg1LaT979xhET2jLv0758qdhFXNhat1failo8bjIdU6QN0l/
	 gh4IiLy796Uk0IoIse2yp22HuIrGvvnSpSY2/AwpNSEW6fLxN9UWPeDqRCGDVwBFklUMJ
	 HdEa9Ch/xS0tvxZ0v1H4qnSQzCU7wbOf1k/yyQoyo+RLmpXdQgMTQydy03u0h3O09KRBO
	 fAQwqGgIKqEAggMEl9t5gQSv1qVmTvTTgIzyHMWnFX+JXyaa/aXiVhUt2GSBS4iBCm+W3
	 RDk8MDC3+NG8JDY4+8eP1U0olRn7Z/dUCZNfcOyT1hCbWQ/s5xMEIWxy6Bn53KjwZ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiiSDd0d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452B60850AB
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiiSDd0d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E511F00A2E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711292;
	bh=9G2Juop9m4yYRvSwrC6ILNCsmsnKaKioHaaLbaf4ZaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fiiSDd0dNMWI2HxljcQ049PEevntMnzLhtPIAyW1iy8DiP9Hrhr8VMzahcZsuWy4u
	 jnSKcdKTgVA+YWEHeevmTy+aD3wyWGyV8yx5h9ABQO4CMZBXIQdDKWCIHbJY4ixXtn
	 BQtbaGpqpxcuqB4CeShIXKlJkgx00SnqWCb7Ppp5jJIdWscS/CqM9x723WEpBUqD9U
	 GlobWxbxr4SRHADSYNuNOSp7YhG8tvVNuYbdi2Mv1y/IlJK8vQNZ6i2TAGtPb0WJfz
	 IaHpwaCMFiE5M+exSs0mbxzpGdsGdzk8xxMHFqOEjiyHJCgEba6AYmmwKISh/PSwEX
	 Dg8VjJJqstLjg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-49e5f85ce89so1758102fac.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:08:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxiqu0L8LsWCI/2gTU+3rSj2b61Pj4+kfaSNmgP+aHJIXy7vWReTzXtl2RWt7yqXLkvzGi6FAA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WpTpZnc7BqfaVJV5bcZSkkA2sbnRO//8PNjcrRyCoWZGS36mh
	79bepVIeNPfpR0fIEhG6Kb//pe/+UhEjUP9cwJbgkU6Hc8j8sVp7mXGcNE4XeWHRvt6uqxfUfzn
	sFF7R8UwumutolhyNavGGab/iRnNlLg4=
X-Received: by 2002:a05:6870:9694:b0:485:d31b:7767 with SMTP id
 586e51a60fabf-4a9077462c9mr8289053fac.37.1793711291506; Tue, 03 Nov 2026
 05:08:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792838740.git.julius@bairaktaris.de> <7b6a12fbe0853f7faf2987610e25957d2017bd54.1792838740.git.julius@bairaktaris.de>
 <20261103124400.GK865646@horms.kernel.org>
In-Reply-To: <20261103124400.GK865646@horms.kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 14:08:00 +0100
X-Gmail-Original-Message-ID: <CAL4WiipAgQ06hBJ-bXQ-tj5XY595RWci+kf+Dd5+wJckY9O+Cw@mail.gmail.com>
X-Gm-Features: AclHuK8t-8Y9DTLhyYrs294XEo10Oog3RUVjzkCkQh2uqbx6hyfW-H1A0CmrDq4
Message-ID: <CAL4WiipAgQ06hBJ-bXQ-tj5XY595RWci+kf+Dd5+wJckY9O+Cw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/4] net: gso: count the inner UDP header of
 encapsulated UDP GSO packets
To: Simon Horman <horms@kernel.org>
Cc: Julius Bairaktaris <julius@bairaktaris.de>, netdev@vger.kernel.org, dsahern@kernel.org, 
	idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, willemb@google.com, jiayuan.chen@linux.dev, 
	mfleming@cloudflare.com, almasrymina@google.com, bigeasy@linutronix.de, 
	richardbgobert@gmail.com, ecree.xilinx@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 13:44, Simon Horman <horms@kernel.org> a =C3=A9c=
rit :
>
> On Sun, Nov 01, 2026 at 05:42:30PM +0100, Julius Bairaktaris wrote:
> > skb_gso_transport_seglen() adds the inner TCP header length for an
> > encapsulated GSO packet, but not the inner UDP header for
> > SKB_GSO_UDP_L4, whose gso_size covers the payload only. Every segment
> > of a UDP GSO packet in a UDP tunnel, built by UDP GRO behind a tunnel
> > socket or sent with UDP_SEGMENT over VXLAN, is counted 8 bytes short.
> > ip_forward() and ip_finish_output_gso() then let DF segments that
> > exceed the MTU by up to 8 bytes leave unfragmented.
> >
> > Add the inner UDP header as the unencapsulated branch does.
> >
> > Fixes: ee80d1ebe5ba ("udp: add udp gso")
> > Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
