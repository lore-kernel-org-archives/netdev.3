Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF337C933;
	Thu, 30 Jul 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435079; cv=none; b=LGkw1YJwBMSilfCMG777dyLE9bbbm8z68uJl8mfxOPAXZ4Fb0yfvahITDJYUA/yf99zLaD0XYwLvnuN+ZakX44R7Z8AgyoP9qQN1n96Z0rLp/C66KyOFSYF3KdTjzIOFhXjGr41VwgIwKc6juJtIKWFGuB4AHdPjZAvUDX5olIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435079; c=relaxed/simple;
	bh=sBv3VR9CRsNEK5jNvW9AjciatL7QeoY2g0y0bsHs4jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8CtRAO2Y7l8XLk0mYJmJmic3MEZXoSH2AVLOuSLktogpKeQatDWqeyGa572VptftnHFq2JQgGX0iSMwv3JF6nekKapqq6HQZTEG+zMIUDXqHm3hk/NZzE9aGHnH+fcEl+ZhyJDl4iUmR/oLzrZtvPjaSj7X1/QB+v9+n/uUVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U23d2qld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U23d2qld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273B91F000E9;
	Thu, 30 Jul 2026 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785435069;
	bh=sBv3VR9CRsNEK5jNvW9AjciatL7QeoY2g0y0bsHs4jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U23d2qld+qR2KQzcJDQEIl4sYPXRI4iFYh93DLtnewjvPZt5dhlezzdw35fSlOB7f
	 zWttJHUVjpkbjkaWn7PAPguxvuvtH/q9LRLCiNRwBFfgOQ2pyX2te891vd5o3Apljq
	 inkShbU0VcoTBOR5t6U9RbAKyQP6YVMwKO30CxbZzyiVvAgGzLY9s//MADiO0uETZ/
	 ZwCZ5OjJZy0kFeA+Uq/Maz6xhlCdKjrOaacnzJoopzrsHn/GlT2q7nqhDUSIfW3Mly
	 bEm0S/t3JpzZf6f4ZS0kxCKiw7OrFr2Dls1HbW1Wysq/XGeGLU5SjtlM5nsf6J31v9
	 H+VP1rz6psWyQ==
Date: Thu, 30 Jul 2026 19:11:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dpll: zl3073x: ZL30643 is compatible
Message-ID: <20260730-fiftieth-unknown-adbe797ccf1e@spud>
References: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
 <20260730-for-upstream-zl30643-v2-1-0ea0bbd03755@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FD31+yUB1cpSMfRK"
Content-Disposition: inline
In-Reply-To: <20260730-for-upstream-zl30643-v2-1-0ea0bbd03755@free.fr>

--FD31+yUB1cpSMfRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 07:35:35PM +0200, Vincent Jardin wrote:
> The Microchip ZL30643 (chip ID 0x0E3B) is a member of the ZL3064x
> line card timing family. It is register compatible with the 3-channel
> ZL30733 (chip ID 0x0E95) of the ZL3073x family: both datasheets
> describe the same register map and use the same chip-ID encoding.
>=20
> Describe it with a fallback to microchip,zl30733 rather than a new
> standalone compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--FD31+yUB1cpSMfRK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamuTuQAKCRB4tDGHoIJi
0mxpAP0aVge6CptrKQGRsRMo+AnqEKoxrpEuYUIFF6FnLdWH6gD/WvWiDBoJlbn6
zcLvNISSwOGiC+kBoX9rTo9EMHPikgY=
=4/5T
-----END PGP SIGNATURE-----

--FD31+yUB1cpSMfRK--
