Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEA1FD4
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621851; cv=none; b=CDk/BztmpZVAjUYOWECiB2DGMzyIKIg2RfGAWtyGwo/p3RA1PutEymhtllJWn/oY1m4SY/G+a4ss8VlFBg8t5PYoG+twzAamFLbhTEemGwOZmAW6uivgiWSEyPihBd5U7zTQlUT1AtimYaQM4WLMQBnfhvmEsH4EYXcvojlKEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621851; c=relaxed/simple;
	bh=99mfVU8GJDLtQ7RLKhF9hjWUyZLwCbQqY9BgFA2JdpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4wIsqQ2k0k8a+UmQeqzS7ZAaU66dU8/hOa2NyRvJnCThU4fLMJy7Sj0Nr3a7G8axpWlz4keyVG6fx08mSpOw2S9BsNxr6HB2WO1MGh/HxIyA2zdI3dvtM1rCZI26lrx6Z3oqLbZsgjdeAYDWDx7lLJiy2MxCTQ0m18H+A2bFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3V+yawT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3V+yawT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F70C2BCB4;
	Fri,  1 May 2026 07:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777621851;
	bh=99mfVU8GJDLtQ7RLKhF9hjWUyZLwCbQqY9BgFA2JdpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3V+yawTPhZL042qlbGUzinmn18ktVP0xV4OOQforGZOxKCVFcb1n3Wp3Lc7TpeZB
	 AofDRa/xwD+TsHMJQUcepYRr0nNbJ1sYi3upKtIn+etPQYp3yyhkWco6foqFTM4fPY
	 GlzCA4SR9bx2W76qiW5DZd7jqTEe3EyK3x6A+tI6Zc3QFYuFg/myArU3YdzFb58cR0
	 hzNQ/x301ZFqGY/wG7pTGCmZvomkbKXtvP/zeuZdeH5Buz8Rj8f9ak/+GVGvsb5+oA
	 aOxe+GjE46nZBWtzo5jbqeK2DOR8dqT2gTm0cP9IpXXCtl042TcHco1kLji6YIYyuC
	 LgOHOBrLWynzQ==
Date: Fri, 1 May 2026 09:50:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
Message-ID: <afRbWImEALZHM2B6@lore-desk>
References: <20260429-airoha_fe_get-airoha_qdma_get-v2-1-909e791f1dc0@kernel.org>
 <20260430181109.68c65940@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j9OAHKQ5ESftBzW2"
Content-Disposition: inline
In-Reply-To: <20260430181109.68c65940@kernel.org>


--j9OAHKQ5ESftBzW2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 29 Apr 2026 12:54:32 +0200 Lorenzo Bianconi wrote:
> > Add airoha_fe_get() and airoha_qdma_get() as utility routines for readi=
ng
> > a masked field from a specified register.
> > This is a non-functional refactor, no logical changes are introduced to
> > the existing codebase.
>=20
> Doesn't apply AFAICT.
> If this is because of the net -> net-next merge - please avoid posting
> patches which will cause a conflict on merge.

ack, sorry, I did not notice it. I will rebase and post v3.

Regards,
Lorenzo

--j9OAHKQ5ESftBzW2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCafRbWAAKCRA6cBh0uS2t
rGq8AQD24P/m6asGn19jQW+oItzO9GpJHVfVkH6iFqxlm19LcwEAs2hxRk3MCcw0
AmZfLn+VYekbqOqDJ0GINkhJUOYzKAQ=
=L5cR
-----END PGP SIGNATURE-----

--j9OAHKQ5ESftBzW2--
