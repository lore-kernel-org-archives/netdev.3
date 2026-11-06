Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958849;
	b=kj9mmSkhyzguSk3lJ+Wz/Hhcnvn5ibsboSwuBbZDohMX+vl4XBlWL4LG1LEK9FZynJdq
	 3TQsJkcZaGk8zT9zOAZ0abXiedpT+L1efkK6yoPXDJJmJtL6NNXAxafJ2AG35j/zGbC9G
	 zkJiiLtup3PNkRDTizJNMSpToL0pwSEapBf/wqzImRWdxD6+C63ftoV9NyAuwrm0zjU92
	 2y+dsAFPKqjYt5390/MVfdRKpzvxG1jzgcWoMuYfmQEwWhQcO2fIrlw72uB2vMcd6DSAO
	 Rs27hf6xez6p6IeWXIuifeX1kD3E0cDaOMz1BzROFYIsNeSFj3U0U+QfN6Tr27xR7xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958849;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=OHW0eRu14YLXtTFGzNUzbH4pGRiNRWp+OX4jLFLLYcs=;
	b=ZIshmc7e/d29ZU7DZzFTdj9iipPmnZl0uv/BFFARSX1QfDuqOV3UCZnAEa0jpitDaFpG
	 9it5FKvhsxalwUh2pPut78X3Mar3OmJpX1GtLWpXW1XsfXRBxC0GNjcfwWtLygYUQpYM+
	 CZteQHQ6crH3dBAgqwesR3x1RZDuu0BNkYS7hK8FkOtij9xt/TWnlo41XgnmQk0WXM0B8
	 Ii1iFRHuDJPsOoItLx1NtKwxPvXP89Z1ORefmuitHFrW3knf9U8E88Lp3VAML6BrOgJNg
	 m0LJj2hpqvF1mmZcIArGvdLj1OcCi4p3dQt+61nSHpckdeYGJmXoIAM7HG8ikSWlrzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JkYXoq2o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=YeGDIkvD;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B1606A329;
	Fri,  6 Nov 2026 09:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 299B1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JkYXoq2o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=YeGDIkvD
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793958847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHW0eRu14YLXtTFGzNUzbH4pGRiNRWp+OX4jLFLLYcs=;
	b=JkYXoq2onkgKI9rLLvEgw5aPN/hhfXmsQh3wJ04DTZrJpsMcXa95YEDRvUrJnQN8YzL+sR
	zTWm5zsXa9mM/+0OnSd0TEU8kfnOw5fCdrc5pq9lTI9ICif2TMdrREr3IKBcJusMxWhiiI
	WBk6c8TOOWvwSQm8lQsSF54JjecsikPedmmmm1OO/FmxTt6lmvqbZ7ISKoo2DcTq36c4Ze
	JlPFmAmqhoDyaw1VjhWhTaBoeoJwx65cSbG0f1mTICaLY3th7U+Go/jzKflg0HlYMniSkC
	uKtd5570EPl7T67SQOkacc3QmSXr5199J2W1BDX80Dx0FpTJohGEJGN1e7o6xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793958847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHW0eRu14YLXtTFGzNUzbH4pGRiNRWp+OX4jLFLLYcs=;
	b=YeGDIkvDsm3cRVKhZc2Xy63uhufijq9dsJ68dbLa1T273kkMM+laA+m1nGuIIWaxzGp8tu
	rPSUPfatcj5VA9Cw==
To: Xia Yan <yanxia@cmss.chinamobile.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Pavel
 Zhigulin <Pavel.Zhigulin@kaspersky.com>, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject: Re: [PATCH net-next] net: dsa: hellcreek: fix device_node leak in
 hellcreek_led_setup()
In-Reply-To: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
References: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
Date: Fri, 06 Nov 2026 10:54:04 +0100
Message-ID: <87mrrmz3nn.fsf@jax.kurt.home>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Fri Nov 06 2026, Xia Yan wrote:
> hellcreek_led_setup() walks the two LED child nodes of the "leds" node
> with of_get_next_available_child(). The helper drops the reference on
> the child passed to it and takes one on the child it returns. After
> the second call the caller holds a reference on the second LED node.
>
> That reference is never dropped. The out: label only releases the
> "leds" node itself. Boards with both LED child nodes leak one
> device_node reference per probe, on the registration failures as well
> as on the success path.
>
> Drop it at the out: label, before the parent node. The early exits,
> where the walk stopped before the second child, pass NULL, which
> of_node_put() ignores.
>
> Found during a code review of the OF node handling in DSA drivers.
>
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Looks correct to me. Thanks.

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrto7wTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgo41D/4gyOaQNDqjbzRLowk8LgGbkclsSn/v
5S7PCq6xlSWa7ckWoMIXJrwfczi0FJWbAIySym5RvEHyc0n8FVQAIJHexzhr2mgH
AIdHlhjKzfmpn5PLc76kMGKY7gyguBHzHs5Mo8fcPEmK44DUyK4KNcSKcV0WOzbn
66HKy63lx80ve/WL5nJo4J3S3725rsVOukQSO//mbd9N3ijeODW4yV3PwQmzkuJA
t0YQVrLU2sumn1z0DonSeAjasnUVbL3isCTYDTF1SrT6UAHrJ5jMlGMEOqF3iT5Z
xAV8bk8AwjdGpkHH1SFoSlYkBO5RAAJZ201nPbQhS6BMjuMS16cUoAesL2TVwEIB
047YTaUWkB9fgbR4ZLVHZWwKKeke9UMh5bc/ud40husZ+Zh+kqOvUawmhH4oP5GF
QShsAuwYauYRTIjxzEopg57nl8Chv6YEQzi4A0xI83QJ2nwh00BUHWwzMr3BqArl
C7H/F+nuZHMNpou/tnSRD/Bm6f2nzKs3iFTN3ZAsg2fbIhwnKjbyiyw6D3BSGDVX
6OGtSGQwv1gkY1xpXmy9kYZ45/I2Es9CuWhXhhi7p/4jqPtMFCqwzlPGM9amkCz1
KQMWOQPV8aoMqgXxB2RBLafQIzz/jcPhqdzzfHOmmiNFkRgKOjyTHJISBMxptnRo
Vsg7J1Zu31Twgg==
=uKOP
-----END PGP SIGNATURE-----
--=-=-=--
