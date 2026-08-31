Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444C3D9556
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167966; cv=none; b=hL05R2s9WzbHBkQuUXBGUGzJ0HqA+ObbJStTHkkizSGtgFSFvol3KvdAbMIH452oE8ugqLKceVDn0m6Kn1YKDR98oe2W/HzUBy8D8+pK3O/cIsIgd1S6kF0kOmrDzQpYIsQoVgo47UYYTSV46+RDaWGH4dFBODjrqfOxiEoEjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167966; c=relaxed/simple;
	bh=E1e0hg1H5fMorHAldMkmDymt5mTHqS8xmOxdbeCy7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rkw6MY4NvpDnYq8e/uFhTxZBV+xbO8eSB2aol7+cQ9UwbpmUpuITdS+9DWRvM8Ji3lvT3hry5FfsPB2S9w/IyqTh9U6WtAW7+u3vTO5/9nkKHhce6bAly2NWvMjywWADOGOeVNrD9AUE9wzB9gK62jbADjc1ua5XQSmhSmas5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfeDZDMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfeDZDMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC291F00A3D;
	Mon, 31 Aug 2026 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167964;
	bh=Tj04fvi2E9vDYkLt2iG70EVyew0GgZIT1y9l4Vhwsj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XfeDZDMpVlfGeT3fAyEUgM1X63HAIOrt1JdZUKTdMJuozahtdq68jBk0ZMRReizgF
	 q4JohsLUojXb9HEMdGwuzcLHOekE/BOkD03uYAhEmfkonwqsa1TtkWHoqxeAbyrsQO
	 8ezBNMoigpFrA/ZapbxaHwM5BZkxIZxfhjLndds0ykvw39uSEFb123X2+y5Z8CU6pi
	 QrmZ1mBSSCDf5qgTBVaqwW8vg9yQfyHKl78KudAY9GJVIKsY5hXCvREe4eO7wYGnY9
	 iOdN/vdlMNVjqqJfgpEcr/N10w4vFgdvx4z6DvpS/WJfqCv7Y4/VBF78LukQWB/EMo
	 fZv7IrOlQDrNw==
Date: Mon, 31 Aug 2026 11:19:22 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mailmap: add entries for Lorenzo Bianconi
Message-ID: <apVHGkCnGxCK5HNv@lore-desk>
References: <20260831-lorenzo-mailmap-v1-1-c6361ef1eeb3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2V40DLTBJpuCyev"
Content-Disposition: inline
In-Reply-To: <20260831-lorenzo-mailmap-v1-1-c6361ef1eeb3@kernel.org>

--d2V40DLTBJpuCyev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add the active email address for Lorenzo Bianconi and map the old,
> no-longer-used addresses to it, so that git can attribute his
> contributions to a single identity.
> This is done to avoid bouncing emails sent to email addresses that are
> no longer active.
>=20
> ---
>  .mailmap | 3 +++
>  1 file changed, 3 insertions(+)
>=20

Ops I missed the SoB. I will add it in v2.

Regards,
Lorenzo

> diff --git a/.mailmap b/.mailmap
> index 8fb9f3898d7a..39b77eb2db87 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -546,6 +546,9 @@ Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
>  Lior David <quic_liord@quicinc.com> <liord@codeaurora.org>
>  Loic Poulain <loic.poulain@oss.qualcomm.com> <loic.poulain@linaro.org>
>  Loic Poulain <loic.poulain@oss.qualcomm.com> <loic.poulain@intel.com>
> +Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi@redhat.com>
> +Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi@st.com>
> +Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi83@gmail.com>
>  Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
>  Lorenzo Stoakes <ljs@kernel.org> <lstoakes@gmail.com>
>  Lorenzo Stoakes <ljs@kernel.org> <lorenzo.stoakes@oracle.com>
>=20
> ---
> base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
> change-id: 20260831-lorenzo-mailmap-e717ef03f29f
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--d2V40DLTBJpuCyev
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapVHGgAKCRA6cBh0uS2t
rF1IAQCjV/jqE9Yy9ZlfMpyTT/9zEYwTeA2U9D8Yy9sQPaDHuwD+PPRBbw3H+dNp
bamVUBAxPaAwTOkoB0smlAHvGDl9Xgk=
=MnvM
-----END PGP SIGNATURE-----

--d2V40DLTBJpuCyev--
