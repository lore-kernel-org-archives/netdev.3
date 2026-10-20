Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792534766;
	b=A9YdCsE0tJhU3kDggY3+x1j22qy7F4ZjP6LJmD9r/Hrh9Bgv3jP+Dp2sBp/bIZiKUxxj
	 xXQjbZG58eEYeb2m6lq/4G4a/nUyIHZA9vBRF+vLx387uUAVvDaMpF32iuPiignG3gxfX
	 TJM+FgYfuAfM8BR+oK7fsqbmfjJKkCrzKiXM+0GdK2Ep64XTclM/8PiJkuQ/dsm7ELGIo
	 NG2J2erJG3LiXEFR6PE05ne2kYGNgVI4kt9iTpuvzEq11ZmaszkJjBQPSLNTSOWZGwGV8
	 DUvSDQ54s3qla8PrL92LPZ+jzuN92bbhtC6zdgdRqz7ugGNpc4+X2FM50RykS2sYCOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534766;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=txnx7PIhC3EgAqV7GUHYMv76bzFYtKuAOGW3BbDl5Gs=;
	b=G2ZWJcWmYFLqeCYI5hIY5hTcWJyMnwCi4Tn35LM4PvkDZmI/0KKmlfM2VOZmPovxGCkI
	 m8hFORrwPD25xCLXaWXxFhGKTUbdjU+mLrOdrwzg/LTcldI2gbk212GXKccdBDFsnr8Yd
	 FZiiGI5F06BZ0goPhnCg9IV09+o8mgqqMQmPSoybbmfVn6Z/uLhkke72qmRPWRZGosfhn
	 yaFDXQdsYnApMt5cdNZaPvpzR/tvGocGu8rBXeAEIJ3ALIjZ3gmS973q3R0CI+U7svvXO
	 dURTT9Pf03byM1rTEu0bZKcDjZLhoe8ZT0PjBPyVN01UtdUI17o1Q3ZKSlJI1gk+nSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrkxBC7r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062A606A319;
	Tue, 20 Oct 2026 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrkxBC7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229E61F000C9;
	Tue, 20 Oct 2026 22:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792534765;
	bh=txnx7PIhC3EgAqV7GUHYMv76bzFYtKuAOGW3BbDl5Gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TrkxBC7rsozS8XAQDw8v+k9+czCVSWF2em4vHgIO8WOkV6LIMQ/T+QHKQdrkKqvS9
	 efIyh3z9GghObw+fSNzpRkjIKWBJ5KR/CM4834V30SzhrSCvfnDDr6fObhCXkTVsAG
	 qScn8M5h7T0W7SKeVY+3e0XujWg1s16qfC9j1wOR7V03lYiDexnGPswLbpWlDzRn75
	 rdr8F3K38zeNGhHMTXDLGRKJ68U4arnVbpK7PRLe6j4st2M5yjBWKIZ6YhcEa8Somx
	 s0wlJlS6xjstfDcJKbJmZl9tjKyNabTz3/FsrY6kszU4ZVVhiV5tpvkbvhAihpGwaS
	 zqs7pxB2eMQYQ==
Date: Tue, 20 Oct 2026 15:19:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@everpuredata.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tls: keep TX and RX hardware offload on the same device
Message-ID: <20261020151924.41e22eac@kernel.org>
In-Reply-To: <CAKaoeS2WHQ6QH5XJ+T0RLuxVDJAOtzdfVz0V6gSoZ7n5GJkFdA@mail.gmail.com>
References: <20261013202647.2206263-1-rjethwani@purestorage.com>
	<20261020133601.2081ab1f@kernel.org>
	<CAKaoeS2WHQ6QH5XJ+T0RLuxVDJAOtzdfVz0V6gSoZ7n5GJkFdA@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2026 14:01:23 -0700 Rishikesh Jethwani wrote:
> On Tue, Oct 20, 2026 at 1:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 13 Oct 2026 14:26:47 -0600 Rishikesh Jethwani wrote: =20
> > > +            rcu_dereference_protected(ctx->netdev,
> > > +                                      lockdep_is_held(&device_offloa=
d_lock)) =3D=3D netdev; =20
> >
> > Too ugly, add temp variable, pls =20
>=20
> Thanks, I'll use a ctx_netdev temporary and send v2.

Is that a name you've seen anywhere else in this file? :/
