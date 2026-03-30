Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9A3BAD8D
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874413; cv=none; b=OR3E67SjntWI7eZSvMj9bHewc4eCKoc8F2p93SyMTYztPz69Fp6bepyQzfga8S1Y14xe13yTkvz5Vpk2Czt/vDKNch29VcYSWh0L0Sldi3pQKszUa57f/U5BiaBBZcFUdOIOrO65VLCxa/qkAdH3AyIbwmAjc9i6QkqFGeE4vaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874413; c=relaxed/simple;
	bh=PrWi3SJ7YN1tbSH7uE4jbhMQPWF3M7zVjTqKv40unvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUbgd4f8RMy7lvCr3MBCWqo67pxzm/MI5+WMiwN7Nu51WDl/o50AXjsqLsEv9B1rYcrfHEZbrc3HVjFOEpNTbVK7o3ZmQPupydmcYePJCdroPe4UKJG6AsG0zUiW++hyx2NqkldQ20vtSY2FbYkBQMUkNexgxsZkBBPK0dIk6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/zcASzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/zcASzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835E7C4CEF7;
	Mon, 30 Mar 2026 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874412;
	bh=PrWi3SJ7YN1tbSH7uE4jbhMQPWF3M7zVjTqKv40unvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/zcASzAjVSLyIFxxtAJMGnE7SqL71RS+OMg2r/6p3kd/ygNYMqliLvG0Zdq9MHfI
	 Z0UiDpr0QLOMaMPuPyX4Y8VUHJb0O8ks+JLTBSbZbrFYXTSRJReDu9syiHMaX+iOuR
	 iHCmJnsm4gl7CS0Z8vGwcnR1BCGAjtJ4HOK3Ftrvn2lwVIKaNCpUyF9RbN3H9Y+GYr
	 pmPMaMmc4deIPD6FsvidwqsYCsfidg41dx6CMRV0P6vPV0EVPqs3n6/KI+Wl9T3Cci
	 j+cnVStV8mQC59TGefVFvqCkN5LlinSZKEyh4W5uJczcLNb+jtBhaGtp9LBmmxN6iu
	 PshoMnoCk3EOA==
Date: Mon, 30 Mar 2026 13:40:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: Jiri Pirko <jiri@resnulli.us>, jiri@nvidia.com, netdev@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH net-next v4 13/15] net/mlx5: Add a shared devlink
 instance for PFs on same chip
Message-ID: <4cc597da-4742-4437-93b3-686124396517@sirena.org.uk>
References: <20260312100407.551173-14-jiri@resnulli.us>
 <20260324151014.860376-1-ben.copeland@linaro.org>
 <vms2w2ctvoojfqm25hkqapeq7gvn4bsybnrj5rxwsuvfbwutw7@4i5pbtckvlqn>
 <CAL0q8a6OXJ8qQYYYDCfAdujrsJ-QPt75kB=YQ3rwdZq5L=eO5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prCE34Ycx7PQdWPo"
Content-Disposition: inline
In-Reply-To: <CAL0q8a6OXJ8qQYYYDCfAdujrsJ-QPt75kB=YQ3rwdZq5L=eO5Q@mail.gmail.com>
X-Cookie: You will pass away very quickly.


--prCE34Ycx7PQdWPo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2026 at 03:37:20PM +0000, Ben Copeland wrote:
> On Tue, 24 Mar 2026 at 15:21, Jiri Pirko <jiri@resnulli.us> wrote:
> > Tue, Mar 24, 2026 at 04:10:14PM +0100, ben.copeland@linaro.org wrote:

> > >@@ -33,7 +33,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
> > >               start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> > >                                                    PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> > >               if (start < 0)
> > >-                      return -ENOENT;
> > >+                      return 0;

> > Okay. That is probably the best fall-back. Do you want to send the fix,
> > or should I?

> I will leave it with you.

Any news on this, the problem still seems to be showing up?

--prCE34Ycx7PQdWPo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnKbygACgkQJNaLcl1U
h9D5Pgf/d9qhzIJz/bvjeITD/ORTxQ86IIYLRMrbl+wIBy+jfQDA68KnAzrEY7MZ
anUr0qDwP+b/3wRn2kqqf92Mq511iRNRYTfIxUNyCcUP3pz90fyBiXhNfmd69fpJ
R/aJgCkdALvYW8DR8G+49n/gOiJGX0o3jUZCJOpYAFJyui6FSKnRpj/nb0gZmHib
6471yjNp69TeysQXkKmoQmwFxnZgPQ6+xFzLvSGWUTKWqaFtEaej/Fb8qdKnnIJk
04KAG0Aedgoni4lfSqhFv6PPGMmN8fM/BKL+y+M3ZvRg6bbYtYAW9vgFov8fiqxH
noJ+784fe5FphHechu+7T+iTJWC0wQ==
=IDT4
-----END PGP SIGNATURE-----

--prCE34Ycx7PQdWPo--
