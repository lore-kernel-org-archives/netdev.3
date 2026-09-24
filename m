Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD93EB815;
	Thu, 24 Sep 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269065; cv=none; b=il2BcwepytLH/xXNQ170A3Yo2Zrolebq5o1xoBHCRExETQS26bWDa/eM362yRQO0UKZaiU0vfizPC6mnRAjoDWqkDuD/Yn2LZofCmE9UuM3g2NxqFpNKFof/RUAShteSED4KvubkMIBntecDxGj9b9+cC6bGFjPyIl5QeThYkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269065; c=relaxed/simple;
	bh=4V4BDFsXbEB+ePKn1yzWbTUywZsaTwyKCNi6fRC7wjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6l353CP/CK8JifxzX+nDb27TTA9PNa0gTSARaG5fWZbjtM//tN+/4plV1MyL7WaXnarxeAiEBo9JTZTMLVja9dbvlV5ytw+4h3NZYQqI/GreNr32IHH708de5GJs0dhZqoMOC5sE592YuR4Y9ZGgR0EV2niAhcPvacPzjTQ08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVRoLyjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVRoLyjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6177C1F000FF;
	Thu, 24 Sep 2026 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269063;
	bh=4V4BDFsXbEB+ePKn1yzWbTUywZsaTwyKCNi6fRC7wjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVRoLyjUh8MH90p4hL4NdWuJhlYjdsiYiWJMZM2ludCZfLQWLBHZpx6tcyElzxPSp
	 K6y3STZ3OpfLfiPceQnRyVvVPDIQaJwdC3bph4yfODa6X6nrrmz3LOg18XdIzG+K1m
	 gO7WAfWKebxNFxeNBcZOQFRKVleBjUHQRaUJVl4jsUTayGMQWbJTAreTawxGG2mdS+
	 cjlQTAzGNkznPBraakLIVNgAgWoPiitLj17rJ1jLrsuEfMZmN8nCgiDo6GjIH6S950
	 hXKRUNr3ItTZ4tDMJE90NRIfKJrpZ+OBPbv4zx5hyEWfohrV1AuExXaC882aFg5vQl
	 o8pj9cCfX7oiw==
Date: Thu, 24 Sep 2026 17:57:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Arthur Crepin Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 2/3] dt-bindings: net: wiznet,w5100: add
 link status interrupt
Message-ID: <20260924-clothing-eggshell-53bbf1f99802@spud>
References: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
 <20260924-wiznet-link-gpio-v11-2-42a332517b30@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LvFBeGzzjRwWAouD"
Content-Disposition: inline
In-Reply-To: <20260924-wiznet-link-gpio-v11-2-42a332517b30@marmottus.net>

--LvFBeGzzjRwWAouD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--LvFBeGzzjRwWAouD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVWgwAKCRB4tDGHoIJi
0mn/AQCqQyoD4d4WnEQ1RKyXr1n0QkTi449rlUoLmkbCoszkkAD8CnTsaQBrrRwd
ahrFhwSvgaGZUcCED+szBmesMbjUkAQ=
=GGnR
-----END PGP SIGNATURE-----

--LvFBeGzzjRwWAouD--
