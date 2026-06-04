Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AB3CF04F;
	Thu,  4 Jun 2026 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559450; cv=none; b=M/abQuafEWrHoPtpLE7hKzSds8OzcRsGg7CQ7GLLMUK0g1pn53GJCQILRoPvPHAI7WM+XyIMlpVBExNRDziYnvOwDKlouXiFVzGuEaZ2gaoVAmhjf4fmzidOW18eFhKw2OYoSr65tNf3tYHmwRYEunml+XM4hoCX2oZa/glVWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559450; c=relaxed/simple;
	bh=W2oYleXACh7TurlO3lAhx+mXs0ax4vUBLyH+ZxHL3mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHeHh3CDHxWSg4I75u9g7+m9LmMvo9ko83GoM4jM8LVFqC68kzqrf/KQDOuQhSGh3GVn7oxSCv3V67VbTFEpy5jxlFHc3dZTZgq1kDCaZbH90POsyXa43uR/LAcIfkmDrWGqaPnUjbPtGdCAkKo1wktPCRHw0wzqDvbJuvtKyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmkMlDup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmkMlDup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FB1F00893;
	Thu,  4 Jun 2026 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559449;
	bh=eVkpopmXEjzkmtW+mdfdXA6VqhjM+b3ISZeK539v+kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SmkMlDupiqF8dHSJsGfq1EwOMIHu28niCfq6MAsZ+JPfbPMqjLe4KPsq6z0tH/cLU
	 UlQJFszadhv9rEztEJBT7QGdO4UJ6Cz8F44aD6c1zRpqISNce3qmEOpyRWpoyPva6+
	 Wy5Mg1FC952tTdN6DjwEqUxQ6UQ675WQDA1MzHBZzoVQfwSXV69LBIFrErm4xKRPy+
	 qi6Aolr35lX2wRcMbbLqfH2YxI55g2S7hM0ZJcKHOENT4Zs5frGRhqy4DmZb9jQ9lQ
	 ioxm4mo2xvDmflGvHgFRDb4RUoa2sxwWxQVgiD7WL6kAMVUbYhYH/4cWBGYO5FDXYB
	 mmmA1U9lKnQyA==
Date: Thu, 4 Jun 2026 09:50:46 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/6] net: airoha: Remove private net_device
 pointer in airoha_gdm_dev struct
Message-ID: <aiEuVrrgp9RjieOV@lore-desk>
References: <20260603-airoha-eth-multi-serdes-v9-2-5d476bc2f426@kernel.org>
 <20260604060124.ACAD11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h5pRc1ONNFQaQBzX"
Content-Disposition: inline
In-Reply-To: <20260604060124.ACAD11F00893@smtp.kernel.org>


--h5pRc1ONNFQaQBzX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Potential deadlock in airoha_update_hw_stats() due to use of spi=
n_lock() instead of spin_lock_bh().
> --
>=20
> commit d33fdec52e6f77bf6de4ab248729e1a868e78dc6
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Remove private net_device pointer in airoha_gdm_dev struct
>=20
> This commit removes the redundant net_device pointer from the
> airoha_gdm_dev struct. The code now relies on the netdev_from_priv()
> routine to retrieve the net_device pointer. This is a refactoring change
> with no logical modifications.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 6574901ebd19b..57a16de0a2ec7 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed a potential
> deadlock in airoha_update_hw_stats():
>=20
> drivers/net/ethernet/airoha/airoha_eth.c:airoha_update_hw_stats() {
> 	...
> 	spin_lock(&port->stats.lock);
> 	...
> }
>=20
> Does this code risk a deadlock? The ndo_get_stats64 callback
> (airoha_dev_get_stats64) can be executed in softirq context, while this
> lock is also acquired from process context (e.g., via ethtool) without
> disabling softirqs.
>=20
> If a softirq interrupts the process context reader holding the lock on the
> same CPU, wouldn't it spin forever trying to acquire the same lock? Should
> spin_lock_bh() be used here instead to prevent this?

As pointed out during previous iterations of the series, I do not think thi=
s is
a real issue since ndo_get_stats64() callback can't be run in softirq conte=
xt.
Moreover, the reported issue has not been introduced by this series.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260603-airoha-eth-=
multi-serdes-v9-0-5d476bc2f426@kernel.org?part=3D2

--h5pRc1ONNFQaQBzX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiEuVgAKCRA6cBh0uS2t
rO9MAP0cY5zQexQo1pHNxDD5B87+A/+WhoCaWvg8xGusiLH0cwD8DHaH6dGUBCoS
ElkTy4Vc38fkS90hcHDrqMSMY1HOKQA=
=hEBu
-----END PGP SIGNATURE-----

--h5pRc1ONNFQaQBzX--
