Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9716132A;
	Thu,  7 May 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175393; cv=none; b=TbkR+Kr1RVTdhuVuOW75vj6sSZQIE5IxW0gTrk47oOLBgaHv7Fa0/Mf2v5vII40vhhGvQQWlZkG8Bj08KIbBOkfUueyjXyWGDMooWm/uD2EuIzc0ZvmbjwC9lufIKgAZ7+34cj3d4otOOCBw4ERAENigGSzE2S3LL/5mJWge39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175393; c=relaxed/simple;
	bh=CBnvdCtqio5x+rdzVpAUsZ+Yt1D0ifLS7GO/amKxu8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqxhlqGHhj8jwOAp4f/XFPshKwnUl+2QN0jb/SVSS1KjRcPRD05BcIg9OIon7qv491EYGIgCrrnoxlsALIxBdJWxudZAVIMwKvyaQEfZOWzr67rwSXT45EZRErMkC2rV0YNYROCWHVnoIyWI1sOyWp1kffOi5eZMNSUWUR4POsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFfZD6rD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFfZD6rD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D93C2BCB2;
	Thu,  7 May 2026 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778175393;
	bh=CBnvdCtqio5x+rdzVpAUsZ+Yt1D0ifLS7GO/amKxu8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFfZD6rDmPd2tof6tqbRKd0hSTLWkC8LhdTIO0WMsysIGVoeZayN4S/ovJ3G1uo6i
	 U0XCcKWYWhWBAACgBb8lVfxA6+6tbCh1soGZnIRMrAZRWezWMDeH28WB/G4/YxyjME
	 VRBw9MlMyYh3w53i2jXdOQN1UMp+53bJ+k6Hf5GcNKkXRplNAFuhzOt6u0fErVT0dr
	 D8OvS57hGFZ5BFOW4VCXKCUpyUQDpEFO0B1DggWcrOagCa1EHv+VadJ0HupsEHn7zX
	 v/NdJKrog8ePYi0A0Q1QXZS49QusjBcE3PqfwuT+GVTAZCmqVvwleQEUhhaEY+d95g
	 CgtmfexX0uwXg==
Date: Thu, 7 May 2026 18:36:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v3 1/5] dt-bindings: net: starfive,jh7110-dwmac:
 Remove jh8100
Message-ID: <20260507-jaywalker-saturday-5ca401263fd3@spud>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="As+pCEyLA+jvrCQl"
Content-Disposition: inline
In-Reply-To: <20260507094115.8355-2-minda.chen@starfivetech.com>


--As+pCEyLA+jvrCQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 05:41:11PM +0800, Minda Chen wrote:
> Remove jh8100 dt-bindings because do not support it now.
> StarFive have stopped jh8100 developing and will not release
> it outside.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--As+pCEyLA+jvrCQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzNnAAKCRB4tDGHoIJi
0haTAQCxSVP4Athw6UsIb0NxnwU825Gobm4uR69WLX1ltTsgYQEAw/p3/1aqt4Gw
dLzwT2Cwk81tMPivdKLTEbUXjSxwkQw=
=jfQR
-----END PGP SIGNATURE-----

--As+pCEyLA+jvrCQl--
