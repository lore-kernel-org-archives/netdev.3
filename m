Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FF2F3600;
	Mon,  6 Jul 2026 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357698; cv=none; b=QrLxD8GDbh8LB1IG5jRe2oiwPWxhRRv8k45fqu963rzmpfwtslDrchfLJW4+T8STI6PHgHpkYf/ljhja+QmOQeORUTm9ET2uO6leUOtCHLewGWH7I9wVvYTneQkcWQRpc2Kd5Ch1/c05DtBiut5QKXNjTrGEtVl5eBkmHm0Wx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357698; c=relaxed/simple;
	bh=2rSZjEsp5OEHtcOzVRP/sLkWWKpSDMJBaA1fd7pebnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggN386BqgvJuu4YbVQWMLcDW1kmQI8rd2/OHFV8fZNh/BfP3QkKSJQ5d4wZDdOnNTEGEP5/PZDj1VRLMHqK7Su1fRNIf2MiE+iD0H9AIhSVJpKRa4BKwEDBKfq+wYKuicN76aO0tXMddO/V2joNK0pHA/P4weZI0A6+F0TsAAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nse05hhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nse05hhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA381F000E9;
	Mon,  6 Jul 2026 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357696;
	bh=2rSZjEsp5OEHtcOzVRP/sLkWWKpSDMJBaA1fd7pebnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nse05hhVOPrnhtSgBHOy7fISUS+1vnV3Ia17Z5+8niA2kZ6f8XlmYeDQ8DGuwFux8
	 LAhEihu7E6olPQ2FWfzdkrdUbyyVhrxw9JwzN+HPgOyde882KHtCUqAQVSD7uOPSIZ
	 dbrnl1aMuqleU7ZqRux37SRrUEaOtiWLzUIEHzqcVzt6GJR5Aja2FScnT/yNERIvEE
	 edEZZ4vK6mBz7WzmUDAHroCGBI1gkWg6F3Tpz/SSdW0EzEe6T44Hd1j9xFGs/C1LCi
	 VnoUX9/UkpBxU4frfxs2BiwkmH1/d/vUTWkm12ODYd8bGmxv38xh9GzCHFOjzVxygX
	 Sh9ZdGVbKoC9g==
Date: Mon, 6 Jul 2026 18:08:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, daniel@makrotopia.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/8] dt-bindings: net: realtek,rtl9301-mdio:
 Add RTL83xx series
Message-ID: <20260706-appetizer-take-344fa928d4f9@spud>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
 <20260705163532.2853959-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8HVq63c/bhncdKJl"
Content-Disposition: inline
In-Reply-To: <20260705163532.2853959-2-markus.stockhausen@gmx.de>

--8HVq63c/bhncdKJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--8HVq63c/bhncdKJl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakvg+wAKCRB4tDGHoIJi
0uO/AQCjwiRwYM34GZ9K9F08RCHRek4H5Zot8m3BX20UCRXMUwD9HIzy4luZK1Df
38k+i1KhEs4f1YvaY7LKnz+oPdi1WwI=
=rg/X
-----END PGP SIGNATURE-----

--8HVq63c/bhncdKJl--
