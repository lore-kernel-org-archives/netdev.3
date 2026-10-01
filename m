Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA251EDF9;
	Thu,  1 Oct 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865166; cv=none; b=uTpd/9lU4VkVOR6gPgcAPbaGbZZzVWPrFC6kvUVWoQqVeDOsF/L3U7vNaAd4hhDLqeM0eW9QxXHVTWItOoY11GEyROIem5Lmdn7NNMSzCqu0e8U05KzrxbN3+q20PQRAWy1Jr4XUjhXHKFcbOHMZNLzIfKRe8RvDSp992T7Dh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865166; c=relaxed/simple;
	bh=hTkMzCP7N3yWZdnvBdZNRxf/m0P5NJZuBQULtKGYaq8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQ/eW9/JKPvPpkLu1KMvAYEX5t/3i863oJZQ2qvQ3X/18czvTAIC9O8jWiXIcHcovs4JIXYW7jlu30wHJXZYnIB1o9lRMa6adxleGjPUIPQ1lQ2/WKNHR4il1lA2GkvitZB+Hb9LgEESsxAzOeWtHOX/tmZ4KH+UE/RFHVVVukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfsUvSEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfsUvSEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21AE1F000FF;
	Thu,  1 Oct 2026 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865159;
	bh=11s3mLiz/YlWUA+BT+O3/1et8R5ZgOv4/ERZ3CIkR4U=;
	h=Date:From:To:Cc:Subject;
	b=UfsUvSEkHmywCGbEFfK73C2KlQLVVmND4+teeTJA4Mp36x4xSsLQwxZUr4OX+FltC
	 lmtUtRxrh32rbcIcK4kGa5QXbDqGGHN/nvZ/DqIydbvnQcB5bN2xLVQYfX6iJB4/Zl
	 V6fXrLTQIZVcBluQJoeZ28LFejg/uqoRnCyCKSa9AD+KebGAzVlR3n+Ph4FIc8YVPJ
	 L3aE1FoJ3tFNYzd7KLQEDlpVubgdK89/GsJWwK83IxhXA+xvkb7DzPlImQSaUiL/4S
	 f9MbM2Zu4n15+0vew7Ufs/2f1IS13ZeSSw0hZPMFEuWOLlOyzpZYSYFEMORhou0MKZ
	 49e2Pvqt7eLUw==
Date: Thu, 1 Oct 2026 15:32:35 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Javen Xu <javen_xu@realsil.com.cn>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ar5vAxEqS8tO8aVT@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wum45fntmbhXntsB"
Content-Disposition: inline


--wum45fntmbhXntsB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/realtek/r8169_main.c

between commit:

  3cdeaef1754ab ("r8169: disable EEE on RTL8168h/8111h")

=66rom the net tree and commit:

  8a3c76523e449 ("r8169: add support for phylink")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/ethernet/realtek/r8169_main.c
index ee1bc9bd04470,1d06ddff98327..0000000000000
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@@ -5474,22 -5619,6 +5619,12 @@@ static int r8169_mdio_register(struct r
  		return -EUNATCH;
  	}
 =20
- 	tp->phydev->mac_managed_pm =3D true;
- 	if (rtl_supports_eee(tp))
- 		phy_support_eee(tp->phydev);
- 	phy_support_asym_pause(tp->phydev);
-=20
- 	/* mimic behavior of r8125/r8126 vendor drivers */
- 	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_61)
- 		phy_disable_eee_mode(tp->phydev,
- 				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
-=20
 +	/* Keep EEE off but the version stays EEE-capable so that link-up
 +	 * still clears the MAC TX-LPI bits.
 +	 */
 +	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46)
 +		phy_disable_eee(tp->phydev);
 +
  	/* PHY will be woken up in rtl_open() */
  	phy_suspend(tp->phydev);
 =20

--wum45fntmbhXntsB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq+bwIACgkQJNaLcl1U
h9D53Qf/WTonPTkf7N4JfjmSrKZq9D8sE0MRSg4DU9qKNlGvy3XhZ+/SrNl7YhFM
xJghPuXzbehIcXSr/IIZdpNiKR9c98XAh5PYoaqRThqL8MPgdjxkIVszpGw6SN8u
xqVOP997W2izDREwkMznhm8pYtatKiGoecF9aN6IE0aH8lUlHclIOjn/rx1YxTDE
hh3k3vACdhuG8ThEadyXLV0e5RtitB/C/A7TuPuTGr37KbnTkDUrf9w8gjO6+B0x
a1eAjyIfvUrQfZ9ETe9HZSxs1Sy1fXiLoFseGPG32vYnTssTvrJ31YwDUyuODn19
0adrraXBQrnGOe8doagARDtyw4nlng==
=vsIu
-----END PGP SIGNATURE-----

--wum45fntmbhXntsB--
