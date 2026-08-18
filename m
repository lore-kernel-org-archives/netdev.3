Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BAA2F691D;
	Tue, 18 Aug 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067752; cv=none; b=Q6ZK2rKNdUk+YFTxKAOBnDlTj9kVdWUykF8CBmICUsDTTmaknTF9OxP+DohLbz0NTZT0V3R2AE3YoqRpXHejT2Mk4OJ1+ajv4S+e6C0D0VdcWkmbGAlZoOJ5S76mIDA57vOk3FZesv3Bs4ddIUYY6kTXDIxl+MBxflfa//mu4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067752; c=relaxed/simple;
	bh=F7+lQrT5apLyyRZjVCxwV39tZyc81wl5EDijawRFx9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VDEsOK3cU6jzyY6ffdB/qjjvldfI/fkCkktD5C7r47mu9F89tkUvaVGq5HQMVY5Ep0kYNKVtJpm5HoHWWZUyVuRj9ZGD/PBVrsXM2DKARrEg6PItc4QVNI5ZgwEDYw8F5RiYL0nD/DZ4lfnfYy1TjNbE20jlMmZfJUcQNI70BGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekjmTDfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekjmTDfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AA11F000E9;
	Tue, 18 Aug 2026 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787067751;
	bh=40ggfh3fG/mPt9IPlqj4+DiYvnBnS73kkf2Sm0vhUW4=;
	h=Date:From:To:Cc:Subject;
	b=ekjmTDfMoUslwxOJNLHzC0VD9gkM6wMpDheLspEOxywots20vuY/qo5k4f3PG0CZ5
	 fE3Q/RmnQ/F6lWABBtHLSGxsK5H5OppgGxToTua4Sl+mD13jpzu1JomV0hABgHCnl5
	 EBt6B4mry82a1fL4Y+sFhyFV84fZNzYxfgUr8glUGzmQ/7pGf09bsp2foitPA+0BPe
	 vXxCVpQfg/0FvL66Nfl7mb6MtNRnbA9ffUeC2p+cWw06IpCE/lJ9C+gXj4jyzfl+fT
	 XW7NEN30mcU1gFwEWULAMZ38chH57R8Lz9ic4j/E35RRudDfPrq2GuU1aCYnQJRZbM
	 kkpK0+blrnDdw==
Date: Tue, 18 Aug 2026 16:42:25 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Petr Oros <poros@redhat.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aoR9YYY2P5--3x0N@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icLax083uWOnlGM9"
Content-Disposition: inline


--icLax083uWOnlGM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/dpll/dpll_netlink.c

between commit:

  33f016b23a219 ("dpll: fix NULL deref in dpll_device_ops() during teardown=
 race")

=66rom the net tree and commit:

  84e85c325e5ed ("dpll: use pin owner's dpll ref for pin-level attribute se=
tting")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/dpll/dpll_netlink.c
index 9e55745e33e4f,a909cd4451b00..0000000000000
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@@ -1109,20 -1089,8 +1108,8 @@@ dpll_pin_freq_set(struct dpll_pin *pin
  		return -EINVAL;
  	}
 =20
- 	xa_for_each(&pin->dpll_refs, i, ref) {
- 		if (!dpll_device_registered(ref->dpll))
- 			continue;
- 		ops =3D dpll_pin_ops(ref);
- 		if ((!ops->frequency_set || !ops->frequency_get) &&
- 		    ref->dpll->module =3D=3D pin->module &&
- 		    ref->dpll->clock_id =3D=3D pin->clock_id) {
- 			NL_SET_ERR_MSG(extack,
- 				       "frequency set not supported by the device");
- 			return -EOPNOTSUPP;
- 		}
- 	}
  	ref =3D dpll_pin_own_dpll_ref_first(pin);
 -	if (!ref) {
 +	if (!ref || !dpll_device_registered(ref->dpll)) {
  		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
  		return -ENODEV;
  	}
@@@ -1181,26 -1130,13 +1149,13 @@@ dpll_pin_esync_set(struct dpll_pin *pin
  	const struct dpll_pin_ops *ops;
  	struct dpll_pin_esync esync;
  	u64 freq =3D nla_get_u64(a);
+ 	struct dpll_pin_ref *ref;
  	struct dpll_device *dpll;
  	bool supported =3D false;
- 	unsigned long i;
- 	int ret;
+ 	int ret, i;
 =20
- 	xa_for_each(&pin->dpll_refs, i, ref) {
- 		if (!dpll_device_registered(ref->dpll))
- 			continue;
- 		ops =3D dpll_pin_ops(ref);
- 		if ((!ops->esync_set || !ops->esync_get) &&
- 		    ref->dpll->module =3D=3D pin->module &&
- 		    ref->dpll->clock_id =3D=3D pin->clock_id) {
- 			NL_SET_ERR_MSG(extack,
- 				       "embedded sync feature is not supported by this device");
- 			return -EOPNOTSUPP;
- 		}
- 	}
  	ref =3D dpll_pin_own_dpll_ref_first(pin);
 -	if (!ref) {
 +	if (!ref || !dpll_device_registered(ref->dpll)) {
  		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
  		return -ENODEV;
  	}
@@@ -1313,24 -1221,16 +1240,15 @@@ dpll_pin_ref_sync_state_set(struct dpll
  	}
  	if (state =3D=3D old_state)
  		return 0;
- 	xa_for_each(&pin->dpll_refs, i, ref) {
- 		if (!dpll_device_registered(ref->dpll))
- 			continue;
- 		ops =3D dpll_pin_ops(ref);
- 		if (!ops->ref_sync_set)
- 			continue;
- 		dpll =3D ref->dpll;
- 		ret =3D ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
- 					ref_sync_pin,
- 					dpll_pin_on_dpll_priv(dpll,
- 							      ref_sync_pin),
- 					state, extack);
- 		if (ret) {
- 			failed =3D ref;
- 			NL_SET_ERR_MSG_FMT(extack, "reference sync set failed for dpll_id:%u",
- 					   dpll->id);
- 			goto rollback;
- 		}
 -
+ 	ret =3D ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+ 				ref_sync_pin,
+ 				dpll_pin_on_dpll_priv(dpll, ref_sync_pin),
+ 				state, extack);
+ 	if (ret) {
+ 		NL_SET_ERR_MSG_FMT(extack,
+ 				   "reference sync set failed for dpll_id:%u",
+ 				   dpll->id);
+ 		return ret;
  	}
  	__dpll_pin_change_ntf(pin);
 =20
@@@ -1534,19 -1415,8 +1433,8 @@@ dpll_pin_phase_adj_set(struct dpll_pin=20
  		return -EINVAL;
  	}
 =20
- 	xa_for_each(&pin->dpll_refs, i, ref) {
- 		if (!dpll_device_registered(ref->dpll))
- 			continue;
- 		ops =3D dpll_pin_ops(ref);
- 		if ((!ops->phase_adjust_set || !ops->phase_adjust_get) &&
- 		    ref->dpll->module =3D=3D pin->module &&
- 		    ref->dpll->clock_id =3D=3D pin->clock_id) {
- 			NL_SET_ERR_MSG(extack, "phase adjust not supported");
- 			return -EOPNOTSUPP;
- 		}
- 	}
  	ref =3D dpll_pin_own_dpll_ref_first(pin);
 -	if (!ref) {
 +	if (!ref || !dpll_device_registered(ref->dpll)) {
  		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
  		return -ENODEV;
  	}

--icLax083uWOnlGM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEfWEACgkQJNaLcl1U
h9BtAwf/XMJMeF/Vc6pQQR5uwk1BpDMVdi/bPOLSq8B+uX5qDIJ7k4WBbLLLIvZe
tfhHzh2vKhIvgeAOgLI4HmIjcOZoqT4kt+m5VCz9rAapALiowGcFcb+84HOuMxi+
i8Ptl77Py9/jvV08VH7ERlRhhX8Ykq097ZYu6/leKFUHxjLC2k1jo1mDX7TC2PqX
50QkBRl0Co/nwIiLm8eB9YOXYDwTTZ433pBj4aS7G1v/lZQqgjyFaLnKRB2Xjcyl
b0wxao4X8bsYYHU29yAhDsRowReSZZs4waeGesEI86Sius8Y+cYznVvV5E2Jsk4P
kbMhtOSclD4LJXNGnF1DIJ4dFvzAgw==
=lU8x
-----END PGP SIGNATURE-----

--icLax083uWOnlGM9--
