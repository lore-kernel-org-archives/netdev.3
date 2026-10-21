Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566676;
	b=0qfvxGaK4VL/BUbqEbXHX6xWMhddRVTtdf6AulH09Al79WVNSgWJDOKsPZ5grkaBXJq7
	 Op+nOouwRXSNWMou/x4yAszgwhWSMuaF3q8N5u48KMRqTMPKi/4jFSRDq+DDaNhvXo15g
	 kPaEBFrTwo+W2IP39hWqXgK8QGyfeGwZ3R54Bop6vjgvKv016OQew9K88fiNZPEbklgYD
	 SveFIz9DTCJhn4jT5CAz2omY9/gCRCcXMQY4GrkfbYWFckHSYNuOijeu/mcvySwmBHRBS
	 Cm8IVGuhFIg9bBdRolDKOOLfMZ7qN6knjdoA2gM8gmlDRRKPzjOEtKOQjM90yOnXLAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566676;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BN2F9s2PQf7tU6RRltR0YAnwJkqk291xnopYpp+Hfyg=;
	b=llNomyOMh89szge/o1oUlD2COKB287OvT1ekdS156lilBgxpplY9FbD7EYxtMRMo7Hfe
	 QMjsyk+kemlubuzRwayWwaI20OLwc7s3gwMtfhJ6B56VnOvrIkJPhLzxPKDqunLyGghf1
	 lev/FLKmcBaOlO27d9GBa1YqJKgYPGVQn+9myq80lr9QZbtetQ0xnIhcVzMXGTDepJKuJ
	 Y//G1IcRHt4iYhhrCvLWd6qNrrdIHpLMJjPc7Qu02Een+sq9Hnh2IoSIWef/cjpgvv41B
	 UQIwdy9wMK/GdQK2xwMX4I3GyC/9E/NYtoec8AsqU5w/bEVwASCFi1Q3J2vaUNHymgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BRe/PYyI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24A606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRe/PYyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0AA1F000CA
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566676;
	bh=BN2F9s2PQf7tU6RRltR0YAnwJkqk291xnopYpp+Hfyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BRe/PYyI/yoZt1u1HTXqkMKwn53SBdSNEWGEZXaqXNZRmgxSwtGDCDU3NLJNp4lLe
	 UQ7UUtY6CiIMJQEGhHfalMlnPMKDjR2awTM9X3t2rm/7+7CkfmcWPh+LdUUTdQKGkV
	 CoyN996FXe6EaDngUpMBPP9OFImd7wnahwzcTxqszYTcW9us7AH6STAZCY7cF6Lamj
	 y7flrENpCm/4ZQd8tFy7bOpKZACJyUfCd87EoIegqy++4B+OIjT0rYaUTtUlmGrf1h
	 AtPg0S888b7IhdWXUHOyp7uq3eM1Tm0QFkANgsDfzhr28XrftjqMCIHccr9X80Uv6Q
	 q/el+e913uPJw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so3434041fa.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:11:16 -0700 (PDT)
X-Gm-Message-State: AFq9FYKyH4ldsqvjTMATV3nkcJE8dRKxnL0pX6P7d8JPLZj+vsud10/z
	q9ID9oxID2J7OGd19LpaKXmM5+Yynog7TyqwlrTIqxArcytTEsemvYItb75wkaPYdmIYuHzOPMv
	077jDENnYK/Z1GQwXLhT8Cvrn1POH0WA=
X-Received: by 2002:a2e:be10:0:b0:3a6:692d:b7ed with SMTP id
 38308e7fff4ca-3ac441af820mr3582211fa.20.1792566674920; Wed, 21 Oct 2026
 00:11:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020230358.6649-1-dennylin0707@gmail.com>
In-Reply-To: <20261020230358.6649-1-dennylin0707@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 09:11:01 +0200
X-Gmail-Original-Message-ID: <CAL4WiipjUx57YcOPpeOXmwC-Pd-+S65cNzRgR15b1hXn5vX2fA@mail.gmail.com>
X-Gm-Features: AclHuK9XkTKE8LY4XXIySiR2Hxl3nqPuxbPFC__w9yVfrKZoEw8taewo9nbjSAk
Message-ID: <CAL4WiipjUx57YcOPpeOXmwC-Pd-+S65cNzRgR15b1hXn5vX2fA@mail.gmail.com>
Subject: Re: [PATCH net] dql: Reset the adjusted limit when resetting the queue
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 01:10, Hungyu Lin <dennylin0707@gmail.com> a =
=C3=A9crit :
>
> dql_reset() resets limit and clears the cumulative queue and completion
> counts, but leaves adj_limit from the previous queue lifetime. Since
> dql_avail() subtracts num_queued from adj_limit, BQL flow control and
> qdisc bulk dequeue can use stale credit after a network queue reset,
> until the next completion updates adj_limit.
>
> Reset adj_limit to the new limit as well. With num_completed reset to
> zero, this restores the documented adj_limit =3D limit + num_completed
> relationship and makes the configured minimum effective immediately.
>
> Fixes: 75957ba36c05 ("dql: Dynamic queue limits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---

This looks correct, but the stale adj_limit only lasts until the first
TX completion after the reset, and the =E2=80=9Cnegative=E2=80=9D case matc=
hes what a
freshly initialized queue already does.

I do not think this deserves net and stable; please resend for net-next.

This will have to wait for net-next being open after the merge window.

This looks like some LLM stuff to me, with absolutely no real world impact.

pw-bot: cr
