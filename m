Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C73AE19B;
	Fri, 11 Sep 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165598; cv=none; b=J4Dx5AaVJwlss3AY59q/Xdo2S+p5e+r2v840UAsfqSkJ8XqREHQ2zsYnmPUYdhLhKuII0UXGDEmcebNToVCAbz/SDkeLTZriGc/dhn4eEno2/O4tEQxlG+hke7jv0mNgJXqXGAZKnpYqcWnWIidZNwqkcjFE8x3Gzh/Hxj+RuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165598; c=relaxed/simple;
	bh=bkCcMAElNJPe2i4cdATB9LsB1/aDuH3G/dC8238rifE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4JD14IPeRvhv5SyrjU5qvcye85yxiG4jmMkK2ecF95RP7x4OSCLsuDbMi8rPWs+E0FxTPLXjCFzH7+lQuUMl3VHxAAf59jLkiOB/7SXcT8XvgUjU5+9E3QmTan40vppmpjH2kg8IqKoD7d+NUKxn+1fl8Kmk5O9f9INWuy1+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxPEEeTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxPEEeTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14451F000FF;
	Fri, 11 Sep 2026 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165590;
	bh=JNEUcT0p2QiXiiJMjYNy4qjTjJK6OqTijZzdMul2zlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VxPEEeTu9bkOmN7FuVheiDBKT4mq05/qsEgpCk4+Zj0qoD3uiv5GG4VR9qyrM5RlR
	 r2jksQWsFKr6db+czYZINXGpy9oHga8B2TmJeTguVhg/C3FwPQyCIXiHkx3CuMsOFJ
	 9srj1MtOLA2dl7LDdFkw+gbNtWM18M3PtzLRxORkvbDeXZ/FazlJOMwt9e2uUDICUo
	 +c2R1A++B/1fhJs8NJfpzAQb7GkOc8bFuGWhuKtdDDfyIUB5EGR6HGu8PtnlZsMWwr
	 j4GbTli4/FgrK2czH0Nw0D6hmiUjZLrHlp+iJxOIXqme8N8wC87IegOtAOeEjgEjKW
	 xU3vYzUfKjoFQ==
Date: Fri, 11 Sep 2026 15:26:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Danielle Ratson <danieller@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next 04/10] netlink: specs: rt-link: fix
 netkit-policy names
Message-ID: <20260911152629.490a47c7@kernel.org>
In-Reply-To: <20260911214148.1184806-5-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
	<20260911214148.1184806-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2026 21:41:30 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Correct the names of these `enum netkit_action` constants:
>=20
> - NETKIT_PASS is 0, so "pass", not "forward".
> - NETKIT_DROP is 2, so "drop", not "blackhole".
>=20
> Note, the other enum members are not used in netlink, and
> are not allowed by netkit_check_policy().

Looks right tho may be intentional, so the other option would be to add
#define aliases for the spec names.

CC: Nik and Daniel

> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/net=
link/specs/rt-link.yaml
> index ac2084d14f22..e8af962c8064 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -812,10 +812,10 @@ definitions:
>      enum-name:
>      entries:
>        -
> -        name: forward
> +        name: pass
>          value: 0
>        -
> -        name: blackhole
> +        name: drop
>          value: 2
>    -
>      name: netkit-mode

