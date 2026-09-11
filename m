Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B58387346;
	Fri, 11 Sep 2026 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165753; cv=none; b=HW6SeiBTxmCkip35vjshpb8dLufZ/Ot3cj+gLlfwka0oTUdD0qUgx5YK+wPEiE/HDNhvgS7FxJTgPsFKs8hn6sF2pQF1wUMJ+eopQB4MUMMO7g5ykxc95gdQRhZkYoGTejFkUSRV9I6tSpe/R69oll9sDm9+5FI5BDke5wKjx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165753; c=relaxed/simple;
	bh=zcRE/exkkFnY8AWxLGvhRKmnSQfHdOpY9Abhi23U7Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1aByFkOw3FP+VMH4T6EmnZYPhNMbj3RXg38r7Pnw2GtOc3UtCkxbsV+eNv3hSVREqiMHU9N3bNczEeIlOqQbZZFlC1ui+8Ie47h/oSkYowgU345Gf7eZG78D/1SNI3Nr7Ai5djbYuFXQ7iXHimNavEejvGw74AcKebXj33hNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERr0Qk7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERr0Qk7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC601F000FF;
	Fri, 11 Sep 2026 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165751;
	bh=zcRE/exkkFnY8AWxLGvhRKmnSQfHdOpY9Abhi23U7Z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ERr0Qk7YZrWPS64ACvcKFQ0KMkacDHvj6pWJVwzURHHjn3S7MfGXnjd7GrHTm4ADC
	 mTwNoFwE33UTA3lVjWmFkWrK9VL1zOU0ZXvN65G2/KExxyxnlYeOnyikudwFqSkvoM
	 eTvQDilTsI5dwwJsYNCa87cqy08VeNV7hTZWT34ooA8epXXVPn+dIQdfxdEGC1HZDS
	 M7/U0Lsg/MqvYawJd7c7Ot64cxZPwkduvtu3k3J5HCTkq3v7pXGUU/VP8oUvqVomNF
	 tSwimf9aitnMhLb+PGdrxe/HT0zDzDlhIPwkIa6jRWmFE40MLf/zvMQC6sXrDus7Ug
	 +A+OQBqvBhJHA==
Date: Fri, 11 Sep 2026 15:29:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Danielle Ratson <danieller@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] netlink: specs: enum alignment fixes
Message-ID: <20260911152910.413b62b6@kernel.org>
In-Reply-To: <20260911214148.1184806-1-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2026 21:41:26 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This series fixes misalignment issues in YNL-defined enums or flags.
>=20
> While this is not a direct continuation, the rt-link changes was
> previously posted as part of another RFC:
> https://lore.kernel.org/netdev/20260910221733.1021864-1-ast@fiberby.net/

We can take the netkit patch out when applying, and either way:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!
