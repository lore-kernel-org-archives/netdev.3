Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C539FCCC;
	Tue, 18 Aug 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067740; cv=none; b=gjSmfG6/j/r3+xINX4gIkLzPy6jA9CjNGgTz+V8TnwSNFSggetwZjEIADgVCFOSSARoQlPY/xSuBK3i1eII0tq3elMgAHE1RYhTClnmYlgFsIe2QrwAcTnC/vNhX5jtpSaA/bioYXDhZRIJY/+z4HU2K3cH/qsY6OuhdQhprpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067740; c=relaxed/simple;
	bh=hC3xUW6k0/SOOjDVOKBHw5ydn6Tlu3NNxynTswHfjGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LJDVw1y6V7ZNDt6hMQMZetaYPCtqE2yZN+TLs73k7B5bvqQkVsSZobTGBYXcw9f8RFisC+IkzelEkkgmNTT+f42LoZc25pD5h4SkcqAzAcrWgL6kLQyOn9iQNbtcVI926dw7nu9mcTg0Q8KqpGGz4K59dXynS46r/QnX87njwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFre9z19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFre9z19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5BD1F000E9;
	Tue, 18 Aug 2026 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787067739;
	bh=RaDGdLiPv2EmQQbZt+T8bkbpyP7qc0zApNJocHZ9w2g=;
	h=Date:From:To:Cc:Subject;
	b=MFre9z19BFNJim+WjNBEHJvFYAvshcYf03qiv78r61igPgTl5YS7KlYk7lQG3/Ex3
	 YnecrIR6W5kMXE9Ajhs3XXAL5bh9LvhREP3PUctTzHbNiNg9LVw/3vaDWUiE0Cfvyq
	 gimgMMJaAqO6Ilxc8zCUwHW01ZiRokOOiI93FOovqUop1G3wN9zTwWp9tQwSOTnQzT
	 JIjORYKwMuWN/RQwzQ5ia5KycvPYNgGw7lwaDJ0knyo5HTx5LGXbMgveq4x1JtGEkM
	 4j5FfYadyXbH8f7vP4KhLY0ezQ1JSdswNSg3rq8lOicMoCQCBoGCsSTaXHQE8gkTFb
	 6EatDYpLdg9Xg==
Date: Tue, 18 Aug 2026 16:42:14 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Petr Oros <poros@redhat.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aoR9VmKllVGwmQn_@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J1djk/adf4QELX7h"
Content-Disposition: inline


--J1djk/adf4QELX7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/dpll/dpll_core.c

between commit:

  33f016b23a219 ("dpll: fix NULL deref in dpll_device_ops() during teardown=
 race")

=66rom the net tree and commit:

  b1d0c412088e3 ("dpll: add STATE_CONNECTED_OVERRIDE pin capability")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/dpll/dpll_core.c
index a320eeb829ad2,245f625f4b3b4..0000000000000
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@@ -882,7 -881,14 +882,11 @@@ dpll_pin_register(struct dpll_device *d
  	if (WARN_ON(!ops) ||
  	    WARN_ON(!ops->state_on_dpll_get) ||
  	    WARN_ON(!ops->direction_get) ||
- 	    WARN_ON(ops->supported_ffo && !ops->ffo_get))
 -	    WARN_ON(ops->measured_freq_get &&
 -		    (!dpll_device_ops(dpll)->freq_monitor_get ||
 -		     !dpll_device_ops(dpll)->freq_monitor_set)) ||
+ 	    WARN_ON(ops->supported_ffo && !ops->ffo_get) ||
+ 	    WARN_ON((pin->prop.capabilities &
+ 		     DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE) &&
+ 		    !(pin->prop.capabilities &
+ 		      DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)))
  		return -EINVAL;
 =20
  	mutex_lock(&dpll_lock);

--J1djk/adf4QELX7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEfVUACgkQJNaLcl1U
h9C1Cgf/Yz2C78TE2rYsN47V9qOLRpTAwd3Cn/jrcvhuDE01XTdh6/kjdntMJKYm
a+zhoPr5PGk27kJQuh2P2J98evWd/ST1f42jcD6Gnm95/j/b2vWsXyX0FZFgYrvd
NfnmA7BwREW0tGpHevJU56XmtIN5gyY8yIzceDIUsHdm/VVxKxkFl5dSTFSqUNe+
n1lyfgOc5pZPnjVOWA45cjdfw6/dfHBQAjACn3DFhAIcNAc8tbkMFb5JfwIFglSa
MngIytaWIDmOdIbD8MjMWYW92ibSkyOv2mFswwIxkCl27xQBVAJDLOFhLjd80OTq
OrlPDH7ugUPCfqCrnVLiYv7wWFD4fw==
=poR7
-----END PGP SIGNATURE-----

--J1djk/adf4QELX7h--
