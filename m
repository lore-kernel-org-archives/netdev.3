Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFC31619C;
	Mon,  6 Jul 2026 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345738; cv=none; b=bILJsFGwlqAIW31r3+eX0+Xkpwt84069ermOfHikK0Q4xvNwE2fL1OiXqLh9kSRMy2qOxJ8vC68PftwBbgb5YgXTMgv7yLvk/lsw69qpndlfFkfB+ivBXD7NPLYswBBlqQg9rr+GhbVawR/csiqRngsruqBLonA4IkWZ1QbvdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345738; c=relaxed/simple;
	bh=XRZKJZ4/dXD7MfZQeO8CA/MSwruwfGfCBENJB88OinU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H96abq52lxIHPWF1gia6VYHn27rSG6zd823uB2eyhsvCH/xaOlJuuPkkq7E3DbgDgUIFnCuCudZxeP/vEvkjhgKrkb3wAHLAnplSxY/YydnZd3xN+esaXwno5IsDmS8ik5LjDIVm0mpVJCD9lWyqZZm+Jvmp6WcE8q8HKcMJmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMr6XcQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMr6XcQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7621F000E9;
	Mon,  6 Jul 2026 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783345736;
	bh=jVV7bp2HWv2rNP0PffEi0gwhgBaqZkkFggdogt0+07s=;
	h=Date:From:To:Cc:Subject;
	b=WMr6XcQ+IcKqrfRumAIcVd5dJ80KFPZKU8OZxTHj8egk1OudoX7hNDLLAZPzU3W8r
	 aCFZI5dkkVmJGBQlXkDcL/Ct5qw5oJJSceSaEYw6v2Oo6Rr9yov201tzpDg4B9R8EL
	 7Dc0Z9LkDF6EqB70NgeDZ6DNuPHNXd53Ph/cX7dp59YTsZDhVkB5rh+23XDaE4PSpb
	 CnKjuDqe3wheJvAToK+UeQTgf9fmR1RPRD64heFmfyNJd02yJxetfY1YHLmQXl7fFb
	 CP9ybTeSqNMaWr+KzGNuxvB/rzSL41BvX+bAjxkRqHATS/7q61dNiqxnaouLDkA6d3
	 maP3ZKEQisOzw==
Date: Mon, 6 Jul 2026 14:48:52 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Nirmoy Das <nirmoyd@nvidia.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <akuyRPMJsZkyJnx0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gy5knwxr8P5bZ+WD"
Content-Disposition: inline


--gy5knwxr8P5bZ+WD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/net/lib.sh

between commit:

  dd6a23bac306b ("selftests: net: make busywait timeout clock portable")

=66rom the net tree and commit:

  895bad9cc4cec ("selftests: net: make busywait timeout clock portable")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/testing/selftests/net/lib.sh
index d46d2cec89e45,d389a965d8f19..0000000000000
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@@ -93,10 -89,8 +89,9 @@@ loopy_wait(
  {
  	local sleep_cmd=3D$1; shift
  	local timeout_ms=3D$1; shift
- 	local start_time
 +	local current_time
 =20
- 	start_time=3D$(timestamp_ms) || return
+ 	local start_time=3D$(timestamp_ms)
  	while true
  	do
  		local out

--gy5knwxr8P5bZ+WD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpLskMACgkQJNaLcl1U
h9Bp7Af/RvykH3dJh4/vhScpTYl5MhyYOquAh8krSszLd0R3XSfeckxfkWIsQNO3
7FzeRE5dEerdD5n2dMPvDdfFkLtE2iiGZN2Pba17NLy3A5DpLG5TPOK3ap5NBYLO
z5d/wEiP1SfAYTB/tLqv01tRw+fsBeJmn+Y+YeWoH6UxFIJVyhp2LXHBBnH6r+H7
cBcifOcDyjhy4QPR601fz7Qtjhv69Gq/NDumseaMmk1U34IzNTFX8LyNZyYhNd7p
DIvDP3BSv5kja5HW39xgRd85UE+b8wVLgFNbiH28pfgTZl/tjOh9on24XPSnVqLb
s6H4t/9zL8qhEkKJifzgu1v1wsLxzQ==
=p66H
-----END PGP SIGNATURE-----

--gy5knwxr8P5bZ+WD--
