Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561A2868A7;
	Tue, 17 Mar 2026 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791138; cv=none; b=MFTbDAFVPVcicsx2G448O1wZYzMSJk2/S1LKZkouafCp/CgZjrmNb7+JUxKOSzhG3PFINE0dgdgpE52Z4W4lcNe+XnKnjw7dbEwvO3Dauhgqq5VJs+/wYV4TaeNLVnBLglAEtCXBdrztawizKxrGcpkj/WJpfUqFKgTt1bPCn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791138; c=relaxed/simple;
	bh=fPQBaXgJRadgEQhuNyo+us6Ci9dMoEhV1h29NApwVlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekStbnMSxqQkI6duhDcXX8WwvxSD5GAp3RlTaQSwF4gugcd7hy6l/VPRUN1CG7jeSziGQLwz0UchGVMyuRcqx4QtIxY2uQLJRnsbSqXoWtstOvR/h7DKfXm9xnG4d691vtCxxDVcZwknkAHClBYlyClB42rw+hyYMRbGoqmQpJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO8UTuHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO8UTuHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F758C4CEF7;
	Tue, 17 Mar 2026 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773791137;
	bh=fPQBaXgJRadgEQhuNyo+us6Ci9dMoEhV1h29NApwVlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WO8UTuHV7gbsJuTnSvEgZfUxOJuLa1H/GCvpxxsV8owtHnqSA+QHCzMwzOwse60YF
	 raPG4Dqc/b95CXX7mU70xV6zoeXSpnU9WVckDtK2h2nIix6BuTAoHDyIXbNO6fzc6h
	 OoI9wgLfiYLysacfDRNxwyebYSoADA/5q4637vT6eKImN74BFp2cBPwlz3v3jk+Pe0
	 kgRvxNUkIALuEk3HEwvJNj9usa43cCvF7XCSbrK1lkOr9mqhnr0/QJPjLY91RfRdXu
	 VimEHcZiwKc7D95WVbeAKAIoPV3qrRxCE4ZGkju0n8xhronaAUsChiLuW3JkTTxTzv
	 o3oo4UMu0pH2g==
Date: Tue, 17 Mar 2026 23:45:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] regmap: mdio: make it depend on PHYLIB
Message-ID: <5786b938-7c7d-42a0-911a-6f84dca42cca@sirena.org.uk>
References: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
 <a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
 <20260317162843.4cc4b57a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zFQHDtCGpgHQXZep"
Content-Disposition: inline
In-Reply-To: <20260317162843.4cc4b57a@kernel.org>
X-Cookie: Who is John Galt?


--zFQHDtCGpgHQXZep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2026 at 04:28:43PM -0700, Jakub Kicinski wrote:
> On Sun, 15 Mar 2026 17:48:43 +0100 Heiner Kallweit wrote:

> >  config REGMAP_MDIO
> >  	tristate
> > -	select MDIO_BUS
> > +	depends on PHYLIB

> The REGMAP_MDIO symbol seems to have no user in the first place?
> I'd have expected any driver that practically needs it to select it.
> What am I missing?

Nothing, that's how it's supposed to work.  I don't tend to block new
buses on their users being added since it just makes merging a bit more
complicated (or possibly the user has been and gone).

--zFQHDtCGpgHQXZep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm555sACgkQJNaLcl1U
h9DPEAf/TXHo8zza9d1S38153+cimsyiMQi8wjOVWA/fpUspKDH8JVFq0i+rVwu5
tERn2BGsnIyaaPAXko/ZR4o6t1sOqwP4xKBhpA7jkgtsJCg68shRhFNZpdcnzJPQ
/6L4txYcvo9orwbwTqbtnZqwOERA9hPoanvW5EO5ACQS7k742KNRuX9DQCrz22he
XWKVQWoAdaxqCApp0NQdu7nmEwjaf/TQxU66Ws2WryADVS/1sQVXAlyRxe+WuSyO
LzGq0jm+xGbBV9u3zRNBxgFozsqbgVwvPyiJrVTNeYiKUhb8Ux4tHRZ9WgtzyrMV
is74QAgrqecVlxvbrSazHqG9pl4EQw==
=N6zc
-----END PGP SIGNATURE-----

--zFQHDtCGpgHQXZep--
