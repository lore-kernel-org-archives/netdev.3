Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667E43C074;
	Mon, 11 May 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517048; cv=none; b=P64gDic41FQTZ3oFp+gi/jUkQm5D2QaS4xitmON5WCfUJPsWsLaN6T1GZj91Xl0gfK8eTAFI6AcWP+30VmF6SwRt2aH7HYCsgLT2sT1Az817sqjWL8B+PxETwns+/UlDCG/mAR5QH83S5F4kp8XZDNAykmj7FwU0dxpVjbPcXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517048; c=relaxed/simple;
	bh=YTRU0QzceM5GN/zCwgxklC12bklq+nXMEZMLiB/6JqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FInKcjYqbHMw/Acrmvt3m0SFiyQWlZVWPyL2HI5GA4gAZkHCl/UtV0Xi7awvuy7NbsGHLLnhDJ6xBsZDdy4IFUpkKS9JJWv37ntGdLHW3KUxmmzSAnGTzTNHnfGWHvPd4XfUbUvYXeCMIEzW6BNPLZW9cWvLRrxWE3Byy8vhWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJmqDb7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJmqDb7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0914BC2BCC9;
	Mon, 11 May 2026 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517048;
	bh=YTRU0QzceM5GN/zCwgxklC12bklq+nXMEZMLiB/6JqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJmqDb7gz4VP8rgBw0PjA4gnd68l2YaczhY2DbmG5aKqwrBFCWYZCXWNMwCmaMGKD
	 Bxo3HqhrV/vhFOZHfIUfspQbwXMO+J/CPgVCky1nRCX2FlTkmntSv8u6KlfKjM98Wc
	 MM4yE5YpiToacIo6UhZL7FZ3bkYygdlQpqXfWRFk/eqFh/A2ee7NjmAw0wlTPU90cd
	 eG6zzv4hNt3P+Lk+2rHVgyortDcfxiHln3ui9rA5u3QsoK6Uo2wNm1G98KdZEgDfjS
	 PWwW0mR7K+xhgAXuT/oyiQSme4uQYGWfrXSSWSY11CvehpGNV/PdyWjBLDH696nA3d
	 ybgRpdUEa1UIw==
Date: Mon, 11 May 2026 17:30:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH phy-next 2/5] dt-bindings: phy: lynx-28g: add constraint
 on LX2162A lane indices
Message-ID: <20260511-email-acuteness-19bf37f7ab6b@spud>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pG0Rwq2w5ThK7a69"
Content-Disposition: inline
In-Reply-To: <20260511150023.1903577-3-vladimir.oltean@nxp.com>


--pG0Rwq2w5ThK7a69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 06:00:20PM +0300, Vladimir Oltean wrote:
> The SerDes 1 of LX2162A has fewer lanes than all other instances, and
> strangely, their indices are not 0-3, but 4-7.
>=20
> This is a best-effort constraint, since we can only impose it when using
> per-SoC compatible string and per-lane OF nodes.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--pG0Rwq2w5ThK7a69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagIEMwAKCRB4tDGHoIJi
0v29AP4nagTZqyC0G4SrA+vnXDfh3QKP4eYpdEK6fbB0K0xuOwD/UCZR/LgmDCTj
pIpzEGg7++UBUrtPWMHwj2M3yHH8Nww=
=jWbI
-----END PGP SIGNATURE-----

--pG0Rwq2w5ThK7a69--
