Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5423CFF6F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133509; cv=none; b=sOQLQoc/1uXBL6oz1j54IkkbXC0yNS8xFvm5MNBsO855susFQgsRX0VE96XmXzD1dIZgslON1Ld+vs/3TlnAmRneT/OayinEQuzY5nPdlAqbY4+Qo6jAZPQ/opApmi5g3TCCnwWrbIcWu/LGKBozNSCFzQuGQoyHK8By9/0cPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133509; c=relaxed/simple;
	bh=yX0bQZxxxY2XQc1lCnSc7eKZDGiMMka7qkMCjFLINfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S45N0rn4gFsJ3djExC3EDhMkVGQhWZHZ1+ui6bw6tc1514VnEJtQUACkBYyt50KH4oltycBW7LwkU7h0yc/qNC76hQ+D24CRbEuUXYjXcsX4Q7fCpG5z9so9ilqWJ5d2wPF3FBIYpXphSe+oqsuCsXW7uP68jiBtxDnTE0TqW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWuBX3lS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWuBX3lS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFDD1F000E9;
	Mon, 27 Jul 2026 06:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785133505;
	bh=AxDTGNjl+A21oI8mx+eyFVoo/6K2zCypCJKaPp2Jkqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DWuBX3lSYwkOuism5YgEF4DtFHJTG9RrCl4sYRzFIRRe6ZmiXDSWK4VaTFuKU9FSz
	 Zw5N22FSFXwSn04OF/WFyBo1JkKfRIxx62AlI3IoLCA7QLnlMOHCFhlEtBe+sop16Q
	 xjclA7eNPdAYbX4hX2283Wb1xtlVG4KHpbOJL2JX7/Qigr1sivy8SU0LOpVhrIIdKL
	 V8j/DS4tCxPsd9LPZR92kMlmu9c98Si+MlmovrY7YQQEFpaGGLG9zj6KYsenBOhJip
	 fLDmwU6zPHAKSDzQvOt7iwkIEg1eSWXQIktyAf+Z3xUKWAY6UWGYkMZZ9WmOOuA5Dc
	 PRQ66z9mlgWIw==
Date: Mon, 27 Jul 2026 08:25:03 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agarwal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v12 3/3] net: airoha: defer GDM3/GDM4 WAN mode
 and GDM2 loopback to QoS offload
Message-ID: <amb5vuzkHP1dA1ok@lore-desk>
References: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
 <20260725-airoha-ethtool-priv_flags-v12-3-5136a30b2157@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZdqQZYG4LwtHA3we"
Content-Disposition: inline
In-Reply-To: <20260725-airoha-ethtool-priv_flags-v12-3-5136a30b2157@kernel.org>

--ZdqQZYG4LwtHA3we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 447a5a9552bb..fa9a8edce22f 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -572,11 +572,12 @@ struct airoha_qdma {
> =20
>  enum airoha_dev_flags {
>  	AIROHA_DEV_F_WAN,
> +	AIROHA_DEV_F_TX_QOS,
>  };
> =20
>  struct airoha_gdm_dev {
> +	struct airoha_qdma __rcu *qdma;
>  	struct airoha_gdm_port *port;
> -	struct airoha_qdma *qdma;
>  	struct airoha_eth *eth;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> @@ -589,6 +590,11 @@ struct airoha_gdm_dev {
>  	int nbq;
> =20
>  	struct airoha_hw_stats stats;
> +
> +	/* Serialize netdev_tx_completed_queue() calls per TX queue during
> +	 * QDMA migration.
> +	 */
> +	spinlock_t txq_lock[AIROHA_NUM_NETDEV_TX_RINGS];
>  };
> =20
>  struct airoha_gdm_port {
> @@ -712,6 +718,16 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> =20
> +extern struct mutex flow_offload_mutex;

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260725-airoha-ethtool-priv_flags-v12-0-513=
6a30b2157%40kernel.org

- Would it be safer to namespace this mutex here to prevent potential multi=
ple
  definition errors during the build?
  - I guess we can rename the mutex if required in a subsequent patch.

Regards,
Lorenzo

> +
> +static inline struct airoha_qdma *
> +airoha_qdma_deref(struct airoha_gdm_dev *dev)
> +{
> +	return rcu_dereference_protected(dev->qdma,
> +					 lockdep_rtnl_is_held() ||
> +					 lockdep_is_held(&flow_offload_mutex));
> +}
> +
>  void airoha_ppe_set_xmit_frame_size(struct airoha_gdm_dev *dev);
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port);
>  bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index e4c3644dd6ec..33ddf0d07855 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -15,7 +15,10 @@
>  #include "airoha_regs.h"
>  #include "airoha_eth.h"
> =20
> -static DEFINE_MUTEX(flow_offload_mutex);
> +/* Serialize airoha_gdm_dev flags, QDMA pointer and PPE CPU port
> + * configuration.
> + */
> +DEFINE_MUTEX(flow_offload_mutex);
>  static DEFINE_SPINLOCK(ppe_lock);
> =20
>  static const struct rhashtable_params airoha_flow_table_params =3D {
> @@ -86,8 +89,8 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *=
ppe)
> =20
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port)
>  {
> -	struct airoha_qdma *qdma =3D dev->qdma;
> -	struct airoha_eth *eth =3D qdma->eth;
> +	struct airoha_qdma *qdma =3D airoha_qdma_deref(dev);
> +	struct airoha_eth *eth =3D dev->eth;
>  	u8 qdma_id =3D qdma - &eth->qdma[0];
>  	u32 fe_cpu_port;
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 6fed63d013b4..442b48c9b991 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -375,6 +375,7 @@
> =20
>  #define REG_SRC_PORT_FC_MAP6		0x2298
>  #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
> +#define FC_MAP6_DEF_VALUE		0x1b1a1918
> =20
>  #define REG_WAN_MTU0			0x2300
>  #define WAN_MTU1_MASK			GENMASK(29, 16)
>=20
> --=20
> 2.55.0
>=20

--ZdqQZYG4LwtHA3we
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamb5vgAKCRA6cBh0uS2t
rPLhAQDmDXiXFow88TNz76pQK/GsGAztphnhJjrwi4BZ1g6ZpAD9EdiYgEKJ2qhs
blve37k2zfnuxM0ZG7K25L6g9k14rAg=
=iRur
-----END PGP SIGNATURE-----

--ZdqQZYG4LwtHA3we--
