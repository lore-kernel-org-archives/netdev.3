Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B93033E6;
	Fri,  2 Oct 2026 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790943843; cv=none; b=Ds5CDlxHJl0CaUr8lzc5be0Et+zFMl6hqUNgTXDCcmZmVCTCiy/BllpYlKu1sAviOLQVwmDStTJn+E2eDBmY2ASQIVfPBCs99RVe0NLyoUQe/L04yFTeEacLIUGXzoaQp9xi+jSDTV1KXW+izcd0pvGNNPRn4QZvWIiTQjC1Ik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790943843; c=relaxed/simple;
	bh=BG5YkYtdu7qsFroJfjc2nkDu4aCw3+TctiEYfajLp3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nFvPPEA9VeXtOdJQvYvyETz7WWbMwGOt7ks7vsybyJlTNYTGsbfd2/GIMjTOxSQO9mKrpjtAaBnEUV/eSw2pIKMZcrCNXQJvgNqZOLoksMqnYxwAfeLR+EpINE99rOcIDnYFFP0C5HZov/39TYF0SXDtV+lCM3IMWcfIdPYnjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2Fg9YNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2Fg9YNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D61F000FF;
	Fri,  2 Oct 2026 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790943841;
	bh=2kXAhOPCMzlMdqEWd4IYXZO9v9pd7TkUmLCbLdb/Zi0=;
	h=Date:From:To:Cc:Subject;
	b=l2Fg9YNQEbcY7gh2Y6zVJbcmDHZ9u+Y8HYklbWuaRkJem2YsJM7k9p57P1RpW8+IV
	 61mnWYCjBzjKehRt6zMQa2n4f9q9zp2zeufeQnmQmEH+EWm8vL3AEBYw9v5IRufA+T
	 PTlAuUcdDN7bnkJ/KiTREik37+DDQ6Mzub93fdDxWzaO8+w3RXnP1ZU6IyALXHSB3A
	 Irxz5S6gQWjT5PKZph4GW7UvVsFmaxHFjbHowqfO6JIrJ31yKGZ1AF+rKaOc8dbVyW
	 jAuxTinZcgfQsvPeadOftLaGp8bd76UTPIf8sc8HZgjbNL2bo71pYHA/HZW5Ysul47
	 Ya+o54ZYJpL0g==
Date: Fri, 2 Oct 2026 13:23:57 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ar-iXZa3AIidNzsZ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="liBhtlqOQypdjWj6"
Content-Disposition: inline


--liBhtlqOQypdjWj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

between commit:

  232d49dd4b40a ("net: stmmac: propagate PTP addend and system time program=
ming errors")

=66rom the net tree and commit:

  8181678a92f01 ("net: stmmac: propagate PTP init failures in __stmmac_open=
() and stmmac_resume()")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9741f97fa37a2,0c381ae0d0ffa..0000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@@ -893,38 -862,38 +894,46 @@@ static int stmmac_hwtstamp_get(struct n
   * Will be rerun after resuming from suspend, case in which the timestamp=
ing
   * flags updated by stmmac_hwtstamp_set() also need to be restored.
   */
 -static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 -				      u32 systime_flags)
 +static int stmmac_init_tstamp_counter(struct stmmac_priv *priv)
  {
 +	u32 default_addend =3D priv->default_addend;
  	struct timespec64 now;
 +	int ret;
 =20
- 	if (!priv->plat->clk_ptp_rate) {
- 		netdev_err(priv->dev, "Invalid PTP clock rate");
- 		return -EINVAL;
- 	}
 -	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 -	priv->systime_flags =3D systime_flags;
--
 -	stmmac_update_subsecond_increment(priv);
 +	ret =3D stmmac_update_subsecond_increment(priv, priv->systime_flags);
 +	if (ret)
 +		return ret;
 =20
  	/* initialize system time */
  	ktime_get_real_ts64(&now);
 =20
  	/* lower 32 bits of tv_sec are safe until y2106 */
 -	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
 +	ret =3D stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
 +				  now.tv_nsec);
 +	if (ret)
 +		goto error;
 =20
  	return 0;
 +error:
 +	/* Restore previous configuration */
 +	stmmac_restore_subsecond_increment(priv, default_addend);
 +
 +	return ret;
  }
 =20
+ static int stmmac_init_ptp_clk_freq(struct stmmac_priv *priv)
+ {
+ 	if (priv->plat->ptp_clk_freq_config)
+ 		priv->plat->ptp_clk_freq_config(priv);
+=20
+ 	if (!priv->plat->clk_ptp_rate) {
+ 		netdev_info(priv->dev, "PTP clock rate not configured\n");
+ 		return -EINVAL;
+ 	}
+=20
+ 	return 0;
+ }
+=20
  /**
   * stmmac_init_timestamping - initialise timestamping
   * @priv: driver private structure
@@@ -937,22 -912,8 +952,14 @@@ static int stmmac_init_timestamping(str
  	bool xmac =3D dwmac_is_xmac(priv->plat->core_type);
  	int ret;
 =20
- 	if (priv->plat->ptp_clk_freq_config)
- 		priv->plat->ptp_clk_freq_config(priv);
-=20
- 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
- 		netdev_info(priv->dev, "PTP not supported by HW\n");
- 		return -EOPNOTSUPP;
- 	}
-=20
 -	ret =3D stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
 -					       PTP_TCR_TSCFUPDT);
 +	/* Reset hw ts configuration */
 +	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
 +	priv->systime_flags =3D STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
 +	priv->tsfupdt_coarse =3D false;
 +	priv->hwts_tx_en =3D 0;
 +	priv->hwts_rx_en =3D 0;
 +
 +	ret =3D stmmac_init_tstamp_counter(priv);
  	if (ret) {
  		netdev_warn(priv->dev, "PTP init failed\n");
  		return ret;

--liBhtlqOQypdjWj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq/olwACgkQJNaLcl1U
h9AMiwf9ETLvZZ/faIW1KY8KMjoGgZ7F01lGKApC2bkj+H7MblLDpPTJhDQ3KKRu
vKAYp81JAE3ZBwgKBmQ1urrxj6TBpsW0poLBzd7kjd/FttjLIHqW5fiStAxQRLNF
Dd07Ghn1FtQ4K/Sc1cW2DBYJfXte8TKPqTurK22QNYeLDtlhQJsJpwL5TYiB5Ewv
hqDcNOUytZHGYkf52NjTj7VI2vhV8dCo/eMunc1dTq6vHqiioOWPf5BnY35SEoh1
Emv/1dTdJt0oYZxpoal48AEj0VOdwpot0gT38D8Nniy90xwGmGWHUkREQ89hCGsb
IqyXS9uMtV9C0igUZHjUKOyz4iSJHA==
=idST
-----END PGP SIGNATURE-----

--liBhtlqOQypdjWj6--
