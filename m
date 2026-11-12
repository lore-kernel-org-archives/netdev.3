Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491912;
	b=ZPqDvo/LfkJf8txAv5zTlcIWduycrSC4+vTxjLv1KGT6Z5IBId3OmplOscmodHAterCp
	 94Vp22tPylazFCfjVt8ilbwq46CL1kSWKuFe4SfuIu1PYxSMxrSKVfPT0ehF9VUQLp1cE
	 Mhh88Rn7R4vHJh1s3W/m/myxixWMt4LYP3TrmLCQc+I0PaywL7WonsJGnnSXil3YRivaT
	 UuG4vGleHHblfkzXpbGww9hHC+oypZZAZIZ8rinSwVx4YO/SBA9t/fTYapN87acreHRea
	 XtRCKw2NYmVKvw9cVAUnevpFMynV57AklcZNWH1Yi1gE1+irDDyfiCVtdgDWwrH36JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491912;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=1WFjlZ/A259pG4RFiOgrqZl0jkTLi1a/YpaoB+6ZJmk=;
	b=gzamO/3KEOAXmm8IghxL43P+99EEFUPvpdoelQPgwECBEZAjbqyrx3S5grBB0IrpZKnM
	 0PiRuTKF7lO2xWqcFO7yzOGDIXZD/3U07oSZO2zX+tnSqeyUNlkOPtsFpK76fGV/iwqUt
	 YgXTFySE/r55SC95loADFJ7cnpWCpI1GAYQvGwUSAflkw9zUnMaXiRvimHdXSjvSR5nTN
	 YI2ittunmAIw3cR20BD1UKScg5eqY4oI0sdgMljvEj6sxrqVq6sKmPoMZHhJW+agSxHQE
	 SeRwVEWq+FtaJy5ma2oFD04LS4b5iFJUWWqRm07Qe+4d3XLmhDJYX4F2H5sMrLXNG3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6OcDGJs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23D606A8A8;
	Thu, 12 Nov 2026 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6OcDGJs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF7A1F00A05;
	Thu, 12 Nov 2026 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491911;
	bh=1WFjlZ/A259pG4RFiOgrqZl0jkTLi1a/YpaoB+6ZJmk=;
	h=Date:From:To:Cc:Subject;
	b=T6OcDGJsjiO7qWEVr5fRS2QH6Liu4YHEOVgRB4YTdLSMbBjG4Nja/MgCBBnt1YSp5
	 LEp8YTge6uaPOATDreGjqhKN64UNmdx0EOk/DXHBrmkHxSlnZuqpw5DxuYfBnEofR8
	 sLVnU22SuEaLi9ZEv2fkeJnVvGDQp/5UsMt7PLyFxZhmcxYJ1iJ7oauH8d8+6o1Hmz
	 bL1mNn9ZNu+IbPrPrn9PCxqLaiGnP9Diq8fz8xq+UMypZNxsPED6o7Haogt/8Q+3tN
	 /9k8xDgJhyc7lYCwP17R22O/Eue6i1JmwWSQEz3MVP+ajOjpumjbctaTsyWN8akkiV
	 hTfBOxlKqmk3g==
Date: Thu, 12 Nov 2026 13:58:27 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the origin tree
Message-ID: <avXGA_FRXwZM7ExI@sirena.org.uk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OU8HZEtbhbcIIM6g"
Content-Disposition: inline


--OU8HZEtbhbcIIM6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/dsa/motorcomm/chip.c

between commit:

  4dd10fbbeb9c3 ("treewide: Convert devm_kmalloc() family to the devm_kmall=
oc_obj() family")

=66rom the origin tree and commit:

  a9a173f81c83e ("net: dsa: motorcomm: Free the MIB block on port teardown")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/net/dsa/motorcomm/chip.c
index c753c746490a1,a1d0ce35f4f3f..0000000000000
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@@ -1405,9 -1405,6 +1405,9 @@@ yt921x_dsa_port_bridge_join(struct dsa_
  			    struct netlink_ext_ack *extack)
  {
  	struct yt921x_priv *priv =3D dsa_to_yt921x_priv(ds);
 +	struct yt921x_port *pp =3D &priv->ports[port];
 +	struct net_device *brport_dev;
 +	struct dsa_port *dp;
  	u16 ports_mask;
  	int res;
 =20
@@@ -1417,12 -1414,7 +1417,12 @@@
  	ports_mask =3D dsa_bridge_ports(ds, bridge.dev);
  	ports_mask |=3D priv->cpu_ports_mask;
 =20
 +	dp =3D dsa_to_port(ds, port);
 +	brport_dev =3D dsa_port_to_bridge_port(dp);
 +
  	mutex_lock(&priv->reg_lock);
 +	pp->isolated =3D br_port_flag_is_set(brport_dev, BR_ISOLATED);
 +	pp->hairpin =3D br_port_flag_is_set(brport_dev, BR_HAIRPIN_MODE);
  	res =3D yt921x_bridge_join(priv, port, ports_mask);
  	mutex_unlock(&priv->reg_lock);
 =20
@@@ -1845,10 -1837,9 +1845,9 @@@ yt921x_phylink_mac_link_down(struct phy
  	int port =3D dp->index;
  	int res;
 =20
- 	/* No need to sync; port control block is hold until device remove */
  	pm =3D priv->ports[port].mib;
  	if (pm)
- 		cancel_delayed_work(&pm->work);
+ 		cancel_delayed_work_sync(&pm->work);
 =20
  	mutex_lock(&priv->reg_lock);
  	res =3D yt921x_port_down(priv, port);
@@@ -2002,11 -1993,11 +2001,11 @@@ static void yt921x_dsa_port_teardown(st
  	struct yt921x_port *pp =3D &priv->ports[port];
  	struct yt921x_mib *pm =3D pp->mib;
 =20
- 	/* get_stats64() might not be synchronized with port_teardown(), hold
- 	 * the MIB block till the device teardown
- 	 */
- 	if (pm)
+ 	if (pm) {
  		disable_delayed_work_sync(&pm->work);
+ 		pp->mib =3D NULL;
+ 		kvfree(pm);
+ 	}
  }
 =20
  static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
@@@ -2014,12 -2005,11 +2013,11 @@@
  	struct yt921x_priv *priv =3D dsa_to_yt921x_priv(ds);
  	struct yt921x_port *pp =3D &priv->ports[port];
  	const struct yt921x_info *info =3D priv->info;
- 	struct device *dev =3D yt921x_priv_to_device(priv);
- 	struct yt921x_mib *pm =3D pp->mib;
+ 	struct yt921x_mib *pm;
  	int res;
 =20
- 	if (!pm && (BIT(port) & yt921x_info_ports_mask(info))) {
- 		pm =3D devm_kzalloc_obj(dev, *pm);
+ 	if (BIT(port) & yt921x_info_ports_mask(info)) {
+ 		pm =3D kvzalloc_obj(*pm);
  		if (!pm)
  			return -ENOMEM;
  		pp->mib =3D pm;
@@@ -2027,20 -2017,15 +2025,15 @@@
  		pm->port =3D pp;
  		u64_stats_init(&pm->syncp);
  		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
- 		/* Start disabled, so that the enable below always pairs with
- 		 * either this disable or the one from a previous teardown
- 		 */
- 		disable_delayed_work_sync(&pm->work);
  	}
 =20
  	mutex_lock(&priv->reg_lock);
  	res =3D yt921x_port_setup(priv, port);
  	mutex_unlock(&priv->reg_lock);
- 	if (res)
+ 	if (res) {
+ 		yt921x_dsa_port_teardown(ds, port);
  		return res;
-=20
- 	if (pm)
- 		enable_delayed_work(&pm->work);
+ 	}
 =20
  	return 0;
  }
@@@ -2625,11 -2610,11 +2618,11 @@@ static int yt921x_mdio_probe(struct mdi
  	struct yt921x_priv *priv;
  	struct dsa_switch *ds;
 =20
 -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 +	priv =3D devm_kzalloc_obj(dev, *priv);
  	if (!priv)
  		return -ENOMEM;
 =20
 -	mdio =3D devm_kzalloc(dev, sizeof(*mdio), GFP_KERNEL);
 +	mdio =3D devm_kzalloc_obj(dev, *mdio);
  	if (!mdio)
  		return -ENOMEM;
 =20

--OU8HZEtbhbcIIM6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr1xgIACgkQJNaLcl1U
h9Dz+wf/WjVsj1JlTDn8w9piCTafKl7f17Bok+ZllEi/4xN7rMchGtmhNT+PtcM2
Brv2C9DbjEiItqZhKqX8Os9KF03EWbAqkSi11GNLY9RF/s7qRCytvXzJ0f+Tzbmv
Sw7o/vlYcaLiSYYrnT0D95lNNxUAO1ZD0ITi6Btjmss7r4OSJV54LUYBg9vn7oZV
8jGa+wmpUxbrGFTiioJXQzFQUhzBrR/TUoErr6OQsdHenHx/NtY9X/9SGsufZ1A4
CFcB75ybakEgd94jQyxOXgkNIR+v/vuDqo3MOk0ZSmG+wlky8Ev5gYIgAXJD82wo
YOi9n680nYBkYhTWgumcKSN8T+bvhg==
=06us
-----END PGP SIGNATURE-----

--OU8HZEtbhbcIIM6g--
