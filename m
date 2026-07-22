Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CC471406
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706819; cv=none; b=n77f+rROg/KuU3mJOh8/lhUR9mZEFcQ4VCX2Hg45nCSTfjaHB5pv4LIMWPEx2lzhFKZKZMC9faOCC2wvjphryaTiasaBJijabzQmX9Hl52M8uO9rQXLxfU1CwmRCO78owUmi64u9RSRtegtLCQVh/iGykvPZAH4tPw9SpCpye6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706819; c=relaxed/simple;
	bh=8YYWS86LIPghP/+a436pk1H+CMz/AtiTmrpw4vjYIWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idX4h9soFPwOUNmWM7Q6uAsY+aqnTCKuHPQJhfH1oMzmHRFRw1itKy8MCGH2Bo0mh+hroU9k8+h+w3Co44GIofxeRFztsq9tR2LEAbtWV80sVnaAPqS6CTbwkqChqekBrgrHg8eJdqtonKeHZM9Da0QUrFDhKgRskdPkCQs70BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO9hbLZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO9hbLZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDA51F000E9;
	Wed, 22 Jul 2026 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706817;
	bh=ldiOu0jvM93MMRBMUA4UclrG9S1elbpCXRNWkwb22Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VO9hbLZv0S99hl0Pnsd1SVCqf6RH/PMDbsVT2KnQW5J/yfkmBaTHXNir2RwRzAcpR
	 kujtgdHErUE23mJeeyMHKToKWo+XFjFV1MUylU2ULZF8LZK9esea2YiYmC2eVjUPvv
	 +lQJxsBkliXGCn3HCvkkGIKZ9qQ/ScBTV+uhNaO6GkVBgmI+cnnqCHIyPNkngZo2Qy
	 MCGIJc3rti7xJIa3u8oDaYn37PgmUUjizCgLJP2kHf8FKYFk1ykMtU2OBiThOLPhzH
	 75oYAGeqOmjCVnZdQXuqqW8wikIFURTCcgICGwWU1eqZQATkT3dGIclUv3nUI5qUTg
	 WxCEfMlNofLCQ==
Date: Wed, 22 Jul 2026 09:53:35 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v9 3/3] net: airoha: defer GDM3/GDM4 WAN mode
 and GDM2 loopback to QoS offload
Message-ID: <amB2_xbuRqlQ31Lt@lore-desk>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
 <20260721-airoha-ethtool-priv_flags-v9-3-9c15d8b71a56@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="baVNLPjPy5onMVn8"
Content-Disposition: inline
In-Reply-To: <20260721-airoha-ethtool-priv_flags-v9-3-9c15d8b71a56@kernel.org>

--baVNLPjPy5onMVn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 21, Lorenzo Bianconi wrote:
> GDM3 and GDM4 ports require GDM2 loopback to be enabled for hardware
> QoS offload to function. Without it, HTB and ETS offload on these ports
> do not work.
> Previously, GDM3/GDM4 ports were automatically configured as WAN with
> GDM2 loopback enabled during ndo_init(). Add the capability to configure
> GDM3/GDM4 as WAN/LAN on demand when QoS offload is created or destroyed.
> Hook airoha_enable_qos_for_gdm34() into TC_HTB_CREATE so that requesting
> HTB offload on a GDM3/GDM4 LAN port switches it to WAN mode and enables
> GDM2 loopback, with proper rollback on failure. Introduce the
> AIROHA_DEV_F_QOS flag to track whether a device has an active HTB
> qdisc; clear it on TC_HTB_DESTROY. The device keeps its WAN role after
> qdisc teardown so that its configuration is preserved until another
> device explicitly needs the WAN role for QoS offload.
> If another GDM3/GDM4 device already holds the WAN role without an active
> QoS qdisc, demote it to LAN before promoting the requesting device. Skip
> the demotion when the requesting device is itself already the WAN device.
> Since airoha_dev_set_qdma() can now be called on a running device to
> migrate between QDMA blocks, make dev->qdma an RCU pointer so the TX
> path can safely dereference it without holding RTNL.
> Hold flow_offload_mutex in airoha_enable_qos_for_gdm34() and
> airoha_disable_qos_for_gdm34() around the dev->flags update,
> airoha_dev_set_qdma() and GDM2 loopback configuration, serializing
> against concurrent airoha_ppe_hw_init() in the TC_SETUP_CLSFLOWER
> offload path.
> Introduce airoha_qdma_deref() helper that wraps rcu_dereference_protected=
()
> with a lockdep condition accepting either rtnl_lock or flow_offload_mutex,
> and use it across all control-path dereferences of the RCU-protected
> dev->qdma pointer.
> Add airoha_disable_gdm2_loopback() to disable GDM2 hw loopback.
>=20
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 233 ++++++++++++++++++++++++=
++----
>  drivers/net/ethernet/airoha/airoha_eth.h  |  13 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
>  drivers/net/ethernet/airoha/airoha_regs.h |   1 +
>  4 files changed, 227 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index aaf2a4717d12..fe2e2af67173 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[...]

> +static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct airoha_gdm_dev *wan_dev, *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	int err =3D -EBUSY;
> +
> +	if (port->id !=3D AIROHA_GDM3_IDX &&
> +	    port->id !=3D AIROHA_GDM4_IDX) {
> +		/* HW QoS is always supported by GDM1 and GDM2 */
> +		return 0;
> +	}
> +
> +	if (!airoha_is_lan_gdm_dev(dev)) /* Already enabled */
> +		return 0;
> +
> +	mutex_lock(&flow_offload_mutex);
> +
> +	wan_dev =3D airoha_get_wan_gdm_dev(eth);
> +	if (wan_dev) {
> +		if ((wan_dev->flags & AIROHA_DEV_F_QOS) ||
> +		    wan_dev->port->id =3D=3D AIROHA_GDM2_IDX) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "QoS configured for WAN device");
> +			goto error_unlock;
> +		}
> +		airoha_disable_qos_for_gdm34(netdev_from_priv(wan_dev));
> +	}
> +
> +	dev->flags |=3D AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +	err =3D airoha_enable_gdm2_loopback(dev);
> +	if (err)
> +		goto error_disable_wan;
> +
> +	err =3D airoha_set_macaddr(dev, netdev->dev_addr);
> +	if (err)
> +		goto error_disable_loopback;
> +
> +	airoha_dev_set_xmit_frame_size(netdev);
> +	if (netif_running(netdev)) {
> +		u32 pse_port;
> +
> +		pse_port =3D airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
> +							 : FE_PSE_PORT_PPE1;
> +		airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(port->id),
> +					    pse_port);
> +	}
> +
> +	mutex_unlock(&flow_offload_mutex);
> +
> +	return 0;
> +
> +error_disable_loopback:
> +	airoha_disable_gdm2_loopback(dev);
> +error_disable_wan:
> +	dev->flags &=3D ~AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +error_unlock:
> +	mutex_unlock(&flow_offload_mutex);
> +
> +	return err;

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260721-airoha-ethtool=
-priv_flags-v9-0-9c15d8b71a56%40kernel.org

- When another GDM3/GDM4 device already holds the WAN role without an
  active QoS qdisc, the code above calls airoha_disable_qos_for_gdm34() on
  that wan_dev to demote it (clearing F_WAN, migrating dev->qdma to QDMA0,
  disabling GDM2 loopback, resetting its fwd cfg to PPE1) before promoting
  the requesting device.
  If airoha_enable_gdm2_loopback(dev) or airoha_set_macaddr(dev, ...)
  subsequently fails, the error paths only unwind the requesting dev:
  +error_disable_loopback:
  +	airoha_disable_gdm2_loopback(dev);
  +error_disable_wan:
  +	dev->flags &=3D ~AIROHA_DEV_F_WAN;
  +	airoha_dev_set_qdma(dev);
  +error_unlock:
  +	mutex_unlock(&flow_offload_mutex);
  +
  +	return err;
  None of those labels re-promote the previously demoted wan_dev. Is this
  consistent with the commit message's claim of "proper rollback on
  failure"?
  - This issue has been reported and discussed in previous iterations.
    If the promotion of the new device fails, the tc command returns an err=
or to userspace,
    the requested configuration was not applied. The system is still proces=
sing
    packets and the user can log and reapply the configuration.
    Re-promoting the old WAN device on error would add complexity for failu=
re cases that
    do not really occur in practice since airoha_set_macaddr() and
    airoha_enable_gdm2_loopback() fail only if the device is misconfigured.

- airoha_set_macaddr() failing with -EINVAL is reachable in practice
  because it validates the new WAN device's MAC MSBs against other WAN
  devices, and GDM2 is always WAN by design in airoha_dev_init(). If GDM2
  and the requesting GDM3/GDM4 device have different MAC MSBs, TC HTB
  CREATE returns -EINVAL, but wan_dev has already lost its WAN role, its
  qdma pointer has been reassigned to QDMA0, GDM2 loopback has been torn
  down, and its forwarding config has been reset to PPE1.
  - This issue can't occur since we can't have just a single net_device
    configured as WAN.

Regards,
Lorenzo

> +}
> +
>  static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> @@ -3048,6 +3220,8 @@ static int airoha_tc_htb_destroy(struct net_device =
*netdev)
>  	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>  		airoha_tc_remove_htb_queue(netdev, q);
> =20
> +	dev->flags &=3D ~AIROHA_DEV_F_QOS;
> +
>  	return 0;
>  }
> =20
> @@ -3067,24 +3241,33 @@ static int airoha_tc_get_htb_get_leaf_queue(struc=
t net_device *netdev,
>  	return 0;
>  }
> =20
> -static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
> +static int airoha_tc_setup_qdisc_htb(struct net_device *netdev,
>  				     struct tc_htb_qopt_offload *opt)
>  {
>  	switch (opt->command) {
> -	case TC_HTB_CREATE:
> +	case TC_HTB_CREATE: {
> +		struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +		int err;
> +
> +		err =3D airoha_enable_qos_for_gdm34(netdev, opt->extack);
> +		if (err)
> +			return err;
> +
> +		dev->flags |=3D AIROHA_DEV_F_QOS;
>  		break;
> +	}
>  	case TC_HTB_DESTROY:
> -		return airoha_tc_htb_destroy(dev);
> +		return airoha_tc_htb_destroy(netdev);
>  	case TC_HTB_NODE_MODIFY:
> -		return airoha_tc_htb_modify_queue(dev, opt);
> +		return airoha_tc_htb_modify_queue(netdev, opt);
>  	case TC_HTB_LEAF_ALLOC_QUEUE:
> -		return airoha_tc_htb_alloc_leaf_queue(dev, opt);
> +		return airoha_tc_htb_alloc_leaf_queue(netdev, opt);
>  	case TC_HTB_LEAF_DEL:
>  	case TC_HTB_LEAF_DEL_LAST:
>  	case TC_HTB_LEAF_DEL_LAST_FORCE:
> -		return airoha_tc_htb_delete_leaf_queue(dev, opt);
> +		return airoha_tc_htb_delete_leaf_queue(netdev, opt);
>  	case TC_HTB_LEAF_QUERY_QUEUE:
> -		return airoha_tc_get_htb_get_leaf_queue(dev, opt);
> +		return airoha_tc_get_htb_get_leaf_queue(netdev, opt);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index bf44be9f0954..4d03ebae1a2d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -545,11 +545,12 @@ struct airoha_qdma {
> =20
>  enum airoha_dev_flags {
>  	AIROHA_DEV_F_WAN =3D BIT(0),
> +	AIROHA_DEV_F_QOS =3D BIT(1),
>  };
> =20
>  struct airoha_gdm_dev {
> +	struct airoha_qdma __rcu *qdma;
>  	struct airoha_gdm_port *port;
> -	struct airoha_qdma *qdma;
>  	struct airoha_eth *eth;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> @@ -685,6 +686,16 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> =20
> +extern struct mutex flow_offload_mutex;
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
> index fdb973fc779c..3ccdf9fccb4a 100644
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

--baVNLPjPy5onMVn8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamB2/wAKCRA6cBh0uS2t
rPjzAP0YsUy0p8VCTUaUnMbwLebEOvEHZDKvPxiypTYu9UBxvAEAwX8ShMcrdqYm
lQtt2pYQSdYvCzAYvBC/mxkVqJgyZg4=
=AVMa
-----END PGP SIGNATURE-----

--baVNLPjPy5onMVn8--
