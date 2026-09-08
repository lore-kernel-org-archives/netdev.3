Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2FF4E80B4;
	Tue,  8 Sep 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863347; cv=none; b=Zt3QDfa7auzshN64194g72V8Ai3gNL9sHtfRIz7dJwegU4EZmKPkE6Yf8M9YMDN8i9XbXH4hYx32KwWzWSZNs1y7cV6Rch6D7FXRQIL6iRN+NYZV5z97eBL55tbZHLQtFhhTSCpBpSHuOo9VtUJRbTGGEMYREphVU/hgrRCQpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863347; c=relaxed/simple;
	bh=ozom8fQ77lGgHCpwm21KGAj1xRs4nzphcZD390TyrSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NW43uUdk04LKXA7qt7l31lK1zCizviaHRCNdpCmIXqWJHlJDtlxyNlqK1P+y9L1aXQ6YXDb85b0mIcdYVDcz2dqvH4XYkwSiR7zlR1jC1s4iLHt4w++4+GKXWKx2unSW+D8N0Y/F6CODM5yA54/U4TyzEwKeTXzB4clnkTIKipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wu+jsMYk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0AEbMzJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wu+jsMYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0AEbMzJ"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788863343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFScFLRESnQ2NhYJSdgH/W//z7cYjaSf5Z0jWD/z1bU=;
	b=wu+jsMYk16SCctmm8QiraTHBm3crXmtHQN8jHn0KV/FvVbntZmOI4OuXIOTMMwlZJlkfFn
	3xchQwQYE/zmG49vTIfEL5s3diVZWUXHMR6neFhNMvYfJaaB8UxhIDQsr31sk1VdUEn47l
	Evf/1wqsafGMuczGiaLqUkLAJWn5oabAPyeBAvBYFwJo8Hy9VHI0hRzgiErZ0fyZDaBMNP
	gWJAYP+yZDkI8O/o3ttF0+AKmlrLFzVZXfSasJATcj2SqblZEzFejLhLLnjNq5qSBPaPmi
	DmQi32c6kq1Q0swguFnxvT4txIajQII1tUHnxIEflX3fGDXbrTaIsXS50I8uLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788863343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFScFLRESnQ2NhYJSdgH/W//z7cYjaSf5Z0jWD/z1bU=;
	b=L0AEbMzJgFgS9AbenRjHI/NwMYTLjsFWZHNwAk6Qvxb5EScYFY4Eq0sI/L1iNsL4meXYni
	/Edl8k91XgES10BQ==
To: Andrew Lunn <andrew@lunn.ch>, Vasilij Strassheim
 <v.strassheim@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>,
 Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
In-Reply-To: <85b4b052-e97c-40b8-b434-de1b6e3af1b5@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
 <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
 <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>
 <85b4b052-e97c-40b8-b434-de1b6e3af1b5@lunn.ch>
Date: Tue, 08 Sep 2026 12:29:01 +0200
Message-ID: <87fqzknij6.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon Sep 07 2026, Andrew Lunn wrote:
>> > ethernet-ports
>> >=20
>> > > +    patternProperties:
>> > > +      '^(ethernet-)?port@[0-9a-f]+$':
>> >=20
>> > ethernet-port
>> >=20
>>=20
>> Is there a reason for such a restriction?
>> The pattern intentionally follows the generic DSA binding in dsa.yaml,
>
> You need to be careful with the DSA binding. It is old, and uses some
> things which are not considered best practices today. But they cannot
> be removed because of backwards compatibility.

Yes, exactly. When we added the dsa.yaml binding, we've had a discussion
about 'port' vs. 'ethernet-port' and had to allow both [1].

Thanks,
Kurt

[1] - https://lore.kernel.org/netdev/20200710090618.28945-1-kurt@linutronix=
.de/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmqf420THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgu2kD/9m4gxfU3gSdA5w1V5WtBZ2pDpxlzyu
FR56m1jb4/3Du1/xlvPxnIlRknu4s2/gd2dyrPFsVr3BcKLkcswJaqt+luzTn7VO
eX9Tak9hZOzIrfzUNUh6ATHyG6/MKl8Nu2gOOOM21mxSw+dt5Owctt+vn/II1Nki
BfPh7QWiveyhViAr5yrgEfP8vi5YGZdRxQTnisQc8Acn2XoVfU4O7P6pgsQ/jmKX
42+gzVA0qulA/MGX7VFkhhOOWCocJhb+5VSHJRVaU49VhQVrvQNxa/HbYqjDU9AT
XMFbPtfiP4wr9A4SqnkmitHNxEeJAJDyjJmennRlTti/crlI0xDDIES1xdC7lAeF
rqEtNdB45OlHv1Eg67tqTZbuczuu9cAoZ7Ks5GPo53vMkmIAxpShQeGeMXVCAq2h
iGLtMvuLWw3zN5ig4fAubY5BQ5Z4irgcvakN1Eb4LluIBty6BaPnoIxYanzeaTOH
KC8WoS0qAVga1Q9+CwA21vViTOfeWl0z7y5+62VfJpYC5iH9t6oh+2je6rzLKbWu
7MEDopSZs4BI3DFeBVzxxDZwEDXdgetzS3GFejhDoQ6XLDNHg+RIefXdV/wCQQ/S
2xxMJm9La9A9FA4KI4s5WTVfZUywWwNPrybI0GintThndQtqAyNJUFHcthMgsD6K
3PfechJZKXkJpA==
=RDqN
-----END PGP SIGNATURE-----
--=-=-=--
