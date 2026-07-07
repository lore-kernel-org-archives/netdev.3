Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF73F39E9
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433241; cv=none; b=FXh9knnPQsldtlhCUrMViDY0fI6FJfd9/DJJKZlDmvwJ7XcYfIIE44RH6o8xeAAQ+ck2UyZVUcVb+OWHrmSMZH5JrpvHYLJ/0b2CK/KDQfvX/oyvWjRzv4NAw7EzYuUzrYGBTTmGDyuq8+TVaN3ZJLyn8q+HWquJhbOlmw7Zfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433241; c=relaxed/simple;
	bh=VNOthrWDgMe51DaLNmRvGOgBRJChgBG+zoxmQTB7two=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyovHuyTUkYE5lUcehSLlTWAQLCHqVF4Fbl9SKzFaE0uyAAWkOMeUzQ6mC1zc1pytoCh1ljiHKZQtRH8oJJWxn6RJuPRzUnq5phdsZ07eevEN7IVGQ0ueAjwxFs0U5T0bH9/LPobeLZ7m/GxqAX3njydb/pa7dpqgQ80uf///5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM6PGvot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM6PGvot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C91D1F000E9;
	Tue,  7 Jul 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433240;
	bh=TbDjUFQ8y2cf3ZfvpIyeJwcBu1+jogsuvp+HURk7B1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CM6PGvotwp6h5fdyxBXyxflZVxqRIjdiRW2OXD33cNNVC0zMekKtrZxd+aaTv7QId
	 xbWCGpMiIbAeXCmuCjzhTD9CHSjXRhIUJ+6cFbcXwWC5hHYRdM/F67ewYtDOkQtBCZ
	 Fi0BBIS4wBxYrYtbowP0d8Em/2klHQOz+4sHlqU7GRBbmEDEySHfqfVp2cvR15/OM2
	 3pMoF8UGBXlwy2rsSKDGYkU0fG91ecWQFAQ7DblX99E9OFVHBU1+oFpoZJrpsOG5K9
	 QXoK5s2k5V07JapW6vJcvQFIp56Lqp+O+zSt3JkKjBUB+V1SzHvJyPkZJkunl7ULmT
	 rUVGbkSw1T6FQ==
Date: Tue, 7 Jul 2026 16:07:17 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Aniket Negi <aniket.negi03@gmail.com>
Cc: netdev@vger.kernel.org, aniket.negi@airoha.com
Subject: Re: [PATCH net v4] net: airoha: fix MIB stats collection to be
 lossless
Message-ID: <ak0IFdwz1rDEekOO@lore-desk>
References: <akwczc23LOGbKfMl@lore-desk>
 <20260707132117.94902-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9OSNfM+DRPhE0WS3"
Content-Disposition: inline
In-Reply-To: <20260707132117.94902-1-aniket.negi03@gmail.com>


--9OSNfM+DRPhE0WS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
> Thanks for the review.
>=20
> > > +	for (i =3D AIROHA_GDM1_IDX; i <=3D AIROHA_GDM4_IDX; i++)
> > > +		airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(i),
> > > +			      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
> >
> > This configuration is not needed since we reset FE at module load.
>=20
> Agreed. The SCU FE reset clears MIB counters, so the explicit loop
> is redundant. Will drop it in v5.
>=20
> On Mon, 2 Jul 2026 22:59:32 +0000, Sashiko <sashiko@kernel.org> wrote:
> > With this patch the driver no longer has any users of
> > REG_FE_GDM_MIB_CLEAR, FE_GDM_MIB_RX_CLEAR_MASK or
> > FE_GDM_MIB_TX_CLEAR_MASK; grep in drivers/net/ethernet/airoha/
> > matches only the definitions in airoha_regs.h. Should these macros
> > be removed in the same patch that eliminates their only caller?
>=20
> What is your suggestions here, I prefer that definitions should=20
> be retained in airoha_regs.h as register documentation for future=20
> reference. Only the loop will be dropped.

correct.

Regards,
Lorenzo

>=20
> > nit: tmp is not so meaningful, maybe better something like data?
> > nit: I would prefer "+" instead of "|"
> > nit: please drop prev and just do:
> >       dev->stats.tx_ok_pkts =3D max(data, dev->stats.tx_ok_pkts);
> > please redo it for all the occurrences.
>=20
> Understood. Will rename tmp to data, and use '+' instead of '|' in v5.
>=20
> Thanks,
> Aniket

--9OSNfM+DRPhE0WS3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCak0IFQAKCRA6cBh0uS2t
rPZ6AP9X0jB9HpK99S27kDxkKP1oUt6TrTSfLBDGruyoe2yvWgEApoZ/M6U5vY9k
s1nkiMUPTYtBH0R5qY9C0At6wy1ubAE=
=asqu
-----END PGP SIGNATURE-----

--9OSNfM+DRPhE0WS3--
