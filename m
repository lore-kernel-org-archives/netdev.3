Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27C3624A9
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262280; cv=none; b=uTUh8bxyBl/GAFhVxPIS/INZGng47rVSyB0OnRSDVUmqgz5dIFj4CdHFTmfqYQ9kqTUHc6VQsMc/2HXB75KgZzsHEfhfJFLPI/s8sma8EpO2M0A9DpOHBl+MZ8MbzgAO2xCaky+71dOuxFPN4VyFv8ysnrt7Rmn2txbeJoeWdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262280; c=relaxed/simple;
	bh=9R/vBouwUO8u0nOStlgtm23ViLcKL64MnKAowG/iy7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwf1Im4zCI6sfL/LuO9Uf9674Klhsj2QgqW5H8sOWKikS3cUxh7dQQOmwzqYVunFu81wqCXCw1WeWn9n2Nwt6mlsf1zB6JsQNe4brXDSEB+CVtOFpwB7VxLQROFbZSJyi70fWAdUhGQUx1WxjolPtCcDFeo0VKEdcoKXWtC/gGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQc2zl1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQc2zl1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7931F000E9;
	Fri, 12 Jun 2026 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781262279;
	bh=yvmn6l+5BfgeLBfn+hR7JuBkqOLGnAHxhwDj3KZ2joo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQc2zl1cfWGwAuhioyl2qL0r3TUFofpGr51Zk5trrnCIcTE/2B9U7PJRz4SzeTMUX
	 0TLGXbsTY9zjPwAeMvKmWc8awRavghfshHZdV6hVte9VeTn1sXdm+TSy/8uakDskPa
	 KSUgJZdU6TrBMh7rKpJRB5vVfnL9EGMyis8RSnepmbw6iEjtPRdaBd3QieZ7MPvd1J
	 RWtp9yzYRzn17YvsSQBehTmENpiOHFJX3KKsiHUHJZSFth8g8gW9VN87GdL6biEfy8
	 7LKrJ5wdxXN6Q6owAWVwwHXEen+EJskIXgg5A3P3hjucbc2YAldJ5vhQQUNtf+Ef3C
	 tyuxkNW3bGZ7Q==
Date: Fri, 12 Jun 2026 13:04:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next] net: airoha: better handle MIBs for GDM ports
 with multiple devs attached
Message-ID: <aivnxEi-5XOl3s5s@lore-desk>
References: <20260611-airoha-eth-multi-serdes-stats-v1-1-42442ae42064@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I8ORiQGe7MIiZoZD"
Content-Disposition: inline
In-Reply-To: <20260611-airoha-eth-multi-serdes-stats-v1-1-42442ae42064@kernel.org>


--I8ORiQGe7MIiZoZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In the context of a GDM port that can have multiple net_devices attached
> (GDM3 and GDM4), the HW counters (MIBs) are global for the GDM port.
> This cause duplicated stats reported to the kernel for the related
> net_device.
> The SoC supports a split MIB feature where each counter is tracked based
> on the relevant HW channel (NBQ) to account for this scenario and
> provide a way to select the related counter on accessing the MIB
> registers.
> Enable this feature for GDM3 and GDM4 and configure the relevant HW
> channel before updating the HW stats to report correct HW counter to the
> kernel for the related interface.
> Move the stats struct from port to dev since HW counter are now specific
> to the network device instead of the GDM port. Refactor
> airoha_update_hw_stats() to take airoha_eth and airoha_gdm_port
> parameters since the function operates on the entire port.
>=20
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260611-airoha-eth-multi-serdes-stats-v1-1-=
42442ae42064%40kernel.org

[...]

> =20
> -	/* reset mib counters */
> -	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
> +static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
> +{
> +	struct airoha_gdm_port *port =3D dev->port;
> +	int i;
> +
> +	spin_lock(&port->stats_lock);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(port->devs); i++) {
> +		if (port->devs[i])
> +			airoha_dev_get_hw_stats(port->devs[i]);
> +	}
> +
> +	/* Reset MIB counters */
> +	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
>  		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);

-  Does clearing the MIB counters outside the device loop cause issues with=
 the
   split MIB feature?
   airoha_dev_get_hw_stats() modifies REG_FE_GDM_MIB_CFG to select the spec=
ific
   nbq channel. Since REG_FE_GDM_MIB_CLEAR is called after the loop, does i=
t only
   clear the hardware counters for the last selected nbq? If so, the unclea=
red
   counters for the other channels might accumulate in hardware, and adding=
 them
   repeatedly to the software stats (e.g., dev->stats.tx_ok_pkts +=3D val) =
could
   result in exponential growth.
   Alternatively, if REG_FE_GDM_MIB_CLEAR globally clears all nbq counters =
for
   the port, calling it here could drop packets that arrived for earlier de=
vices
   between their respective read operations and this clear.
   - REG_FE_GDM_MIB_CLEAR is global and it clears all nbq counters for the =
port.
     There's a tiny window where packets arriving for dev[0] between its re=
ad
     and the global clear are lost, but that's microseconds of register rea=
ds,
     so I guess that's negligible.

Regards,
Lorenzo

> =20
> -	u64_stats_update_end(&port->stats.syncp);
> -	spin_unlock(&port->stats.lock);
> +	spin_unlock(&port->stats_lock);
>  }
> =20
>  static int airoha_dev_open(struct net_device *netdev)
> @@ -2043,23 +2071,22 @@ static void airoha_dev_get_stats64(struct net_dev=
ice *netdev,
>  				   struct rtnl_link_stats64 *storage)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
>  	unsigned int start;
> =20
>  	airoha_update_hw_stats(dev);
>  	do {
> -		start =3D u64_stats_fetch_begin(&port->stats.syncp);
> -		storage->rx_packets =3D port->stats.rx_ok_pkts;
> -		storage->tx_packets =3D port->stats.tx_ok_pkts;
> -		storage->rx_bytes =3D port->stats.rx_ok_bytes;
> -		storage->tx_bytes =3D port->stats.tx_ok_bytes;
> -		storage->multicast =3D port->stats.rx_multicast;
> -		storage->rx_errors =3D port->stats.rx_errors;
> -		storage->rx_dropped =3D port->stats.rx_drops;
> -		storage->tx_dropped =3D port->stats.tx_drops;
> -		storage->rx_crc_errors =3D port->stats.rx_crc_error;
> -		storage->rx_over_errors =3D port->stats.rx_over_errors;
> -	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
> +		start =3D u64_stats_fetch_begin(&dev->stats.syncp);
> +		storage->rx_packets =3D dev->stats.rx_ok_pkts;
> +		storage->tx_packets =3D dev->stats.tx_ok_pkts;
> +		storage->rx_bytes =3D dev->stats.rx_ok_bytes;
> +		storage->tx_bytes =3D dev->stats.tx_ok_bytes;
> +		storage->multicast =3D dev->stats.rx_multicast;
> +		storage->rx_errors =3D dev->stats.rx_errors;
> +		storage->rx_dropped =3D dev->stats.rx_drops;
> +		storage->tx_dropped =3D dev->stats.tx_drops;
> +		storage->rx_crc_errors =3D dev->stats.rx_crc_error;
> +		storage->rx_over_errors =3D dev->stats.rx_over_errors;
> +	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
>  }
> =20
>  static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
> @@ -2310,20 +2337,19 @@ static void airoha_ethtool_get_mac_stats(struct n=
et_device *netdev,
>  					 struct ethtool_eth_mac_stats *stats)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
>  	unsigned int start;
> =20
>  	airoha_update_hw_stats(dev);
>  	do {
> -		start =3D u64_stats_fetch_begin(&port->stats.syncp);
> -		stats->FramesTransmittedOK =3D port->stats.tx_ok_pkts;
> -		stats->OctetsTransmittedOK =3D port->stats.tx_ok_bytes;
> -		stats->MulticastFramesXmittedOK =3D port->stats.tx_multicast;
> -		stats->BroadcastFramesXmittedOK =3D port->stats.tx_broadcast;
> -		stats->FramesReceivedOK =3D port->stats.rx_ok_pkts;
> -		stats->OctetsReceivedOK =3D port->stats.rx_ok_bytes;
> -		stats->BroadcastFramesReceivedOK =3D port->stats.rx_broadcast;
> -	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
> +		start =3D u64_stats_fetch_begin(&dev->stats.syncp);
> +		stats->FramesTransmittedOK =3D dev->stats.tx_ok_pkts;
> +		stats->OctetsTransmittedOK =3D dev->stats.tx_ok_bytes;
> +		stats->MulticastFramesXmittedOK =3D dev->stats.tx_multicast;
> +		stats->BroadcastFramesXmittedOK =3D dev->stats.tx_broadcast;
> +		stats->FramesReceivedOK =3D dev->stats.rx_ok_pkts;
> +		stats->OctetsReceivedOK =3D dev->stats.rx_ok_bytes;
> +		stats->BroadcastFramesReceivedOK =3D dev->stats.rx_broadcast;
> +	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
>  }
> =20
>  static const struct ethtool_rmon_hist_range airoha_ethtool_rmon_ranges[]=
 =3D {
> @@ -2343,8 +2369,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *ne=
tdev,
>  			      const struct ethtool_rmon_hist_range **ranges)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> -	struct airoha_hw_stats *hw_stats =3D &port->stats;
> +	struct airoha_hw_stats *hw_stats =3D &dev->stats;
>  	unsigned int start;
> =20
>  	BUILD_BUG_ON(ARRAY_SIZE(airoha_ethtool_rmon_ranges) !=3D
> @@ -2357,7 +2382,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *ne=
tdev,
>  	do {
>  		int i;
> =20
> -		start =3D u64_stats_fetch_begin(&port->stats.syncp);
> +		start =3D u64_stats_fetch_begin(&dev->stats.syncp);
>  		stats->fragments =3D hw_stats->rx_fragment;
>  		stats->jabbers =3D hw_stats->rx_jabber;
>  		for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_rmon_ranges) - 1;
> @@ -2365,7 +2390,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *ne=
tdev,
>  			stats->hist[i] =3D hw_stats->rx_len[i];
>  			stats->hist_tx[i] =3D hw_stats->tx_len[i];
>  		}
> -	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
> +	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
>  }
> =20
>  static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
> @@ -3205,6 +3230,7 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
> =20
>  	netdev->dev.of_node =3D of_node_get(np);
>  	dev =3D netdev_priv(netdev);
> +	u64_stats_init(&dev->stats.syncp);
>  	dev->port =3D port;
>  	dev->eth =3D eth;
>  	dev->nbq =3D nbq;
> @@ -3244,9 +3270,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth =
*eth,
>  	if (!port)
>  		return -ENOMEM;
> =20
> -	u64_stats_init(&port->stats.syncp);
> -	spin_lock_init(&port->stats.lock);
>  	port->id =3D id;
> +	spin_lock_init(&port->stats_lock);
>  	eth->ports[p] =3D port;
> =20
>  	err =3D airoha_metadata_dst_alloc(port);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8f42973f9cf5..46b1c31939de 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -215,8 +215,6 @@ struct airoha_tx_irq_queue {
>  };
> =20
>  struct airoha_hw_stats {
> -	/* protect concurrent hw_stats accesses */
> -	spinlock_t lock;
>  	struct u64_stats_sync syncp;
> =20
>  	/* get_stats64 */
> @@ -554,6 +552,8 @@ struct airoha_gdm_dev {
> =20
>  	u32 flags;
>  	int nbq;
> +
> +	struct airoha_hw_stats stats;
>  };
> =20
>  struct airoha_gdm_port {
> @@ -561,7 +561,8 @@ struct airoha_gdm_port {
>  	int id;
>  	int users;
> =20
> -	struct airoha_hw_stats stats;
> +	/* protect concurrent hw_stats accesses */
> +	spinlock_t stats_lock;
> =20
>  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
>  };
>=20
> ---
> base-commit: c8459ee2fef502d6ef6c063751c33d9ac7943eab
> change-id: 20260611-airoha-eth-multi-serdes-stats-df2dc16c2dd6
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--I8ORiQGe7MIiZoZD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaivnxAAKCRA6cBh0uS2t
rDDCAQCDSZtkkKAwKtExKS9kQ5EIq4izTOPt/msV8Da18y7ONQEAu9UNly6/ampk
ljg0ePyUwVk/54EdjY8l1e7DTUZHYws=
=sFY3
-----END PGP SIGNATURE-----

--I8ORiQGe7MIiZoZD--
