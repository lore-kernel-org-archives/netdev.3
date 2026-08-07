Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7B327204;
	Fri,  7 Aug 2026 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123982; cv=none; b=KVPyKLn+Mmv9lYlbmPIvJrGpRsbFf50tiOPaEJM+a4xqsTQSp82sZdSY636EDreHRTJwKY+zRyf5yc5rar/GyYXPrmVn1E0Kfk/idxpoZkoPb9oEpHWh27enqQCu2MT16NkKKQha+bKWXGnPipKbY2GMpFX69Iw3kaDZ7tBG8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123982; c=relaxed/simple;
	bh=NSZhbe6ejSfMnBwLzzkHfOYE4W5e29lSlQCRv3Ovilw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhCzotD7FOj8rJbxTc3aUilJ2DX1zzNqV1irq9pabrOkZ4sWP3bc5nuS4R/Un31NfHiErFApXPir11TYyaNgYvFNDTKzVhVwpWQnIGEhQDOZkFCDcBiGeR8lpGzoeroPCuFFtQTX/B/f6mqy0VyvmyRzl49R+i7eccuO/ee4d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHGielbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHGielbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1FE1F00A3A;
	Fri,  7 Aug 2026 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786123980;
	bh=9kjkJA42PSBCEmarSBVe226h5wEmPkcMzS2N7oKMk1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GHGielbMq3lxSYzhHlZiOQamIGEbFZWbp40+NjjoQDufFnUC2ZHrEVzyXNGemQj/b
	 VIGy1Rxb3VGbriFdNBXBAz99O+RoqN7rjNdDSbxR2MJ1j4KZIgG1pP6QmQqlfA7Oru
	 PDrdxmFako8mB0C6+iYcSjf3b6SFdMTSF1zlYNGK4TugwSu4Z7xtY4PxizDxiEwjJN
	 yYZttpkcbESog0pqQ4YA0mOp8kFWHsHVudaoMmdH1IlIaJd3+A3QgmpKWA9hTaCUnd
	 61hI5IBNmcmzRkf5knihwGKZEfnxw0EBh62NgT80b0RL1Ra22Z8QsDm1Rkhj5M++p5
	 EkLOROCbfZMWA==
Date: Fri, 7 Aug 2026 18:32:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, git@amd.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: macb: Add TSN CBS TC offload support
Message-ID: <20260807-kissing-liver-2ab4ec49c015@spud>
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-5-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fX/fMEqN3gnPpM0x"
Content-Disposition: inline
In-Reply-To: <20260807095012.640223-5-vineeth.karumanchi@amd.com>

--fX/fMEqN3gnPpM0x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026 at 03:20:12PM +0530, Vineeth Karumanchi wrote:
> +static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
> +				     u32 *enable_bit, bool *is_queue_a)
> +{
> +	/* Queue A is highest priority (num_queues - 1) */
> +	if (queue_num =3D=3D bp->num_queues - 1) {
> +		*enable_bit =3D GEM_BIT(CBS_ENABLE_QUEUE_A);
> +		*is_queue_a =3D true;
> +		return 0;
> +	}
> +
> +	/* Queue B is second highest priority (num_queues - 2) */
> +	if (queue_num =3D=3D bp->num_queues - 2) {
> +		*enable_bit =3D GEM_BIT(CBS_ENABLE_QUEUE_B);

What's the point of making enable_bit a parameter if everything you do
using it bounds a conditional section gated on is_queue_a?

> +		*is_queue_a =3D false;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int macb_cbs_add(struct net_device *ndev,
> +			struct tc_cbs_qopt_offload *qopt)
> +{
> +	u32 enable_bit, idleslope, speed_kbps, ctrl;
> +	struct macb *bp =3D netdev_priv(ndev);
> +	struct ethtool_link_ksettings kset;
> +	bool is_queue_a;
> +	int err;
> +
> +	err =3D macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &is_que=
ue_a);
> +	if (err) {
> +		netdev_err(ndev, "CBS: Queue %d not eligible (only top 2 queues suppor=
t CBS)\n",
> +			   qopt->queue);
> +		return -EINVAL;
> +	}
> +
> +	/* idleslope is calibrated for the current link speed; CBS is not
> +	 * reprogrammed on link-speed changes, so it must be reconfigured
> +	 * if the link speed changes.
> +	 */
> +	phylink_ethtool_ksettings_get(bp->phylink, &kset);
> +
> +	if (!kset.base.speed || kset.base.speed =3D=3D SPEED_UNKNOWN) {
> +		netdev_err(ndev, "CBS: Invalid link speed\n");
> +		return -EINVAL;
> +	}
> +
> +	speed_kbps =3D kset.base.speed * 1000;
> +
> +	if (qopt->idleslope <=3D 0 || (u32)qopt->idleslope > speed_kbps) {
> +		netdev_err(ndev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
> +			   qopt->idleslope, speed_kbps);
> +		return -EINVAL;
> +	}
> +
> +	/* Calculate idleslope for hardware register:
> +	 * - High-speed GEM: scale to full 32-bit register range

> +	 * - Standard MACB: multiply by port transmit rate factor

I think this comment should probably mention that the register expects
bytes/sec in 1G mode and nibbles/sec in 10/100.

This generally looks sane to my naive eyes otherwise.

Thanks,
Conor.

> +	 */
> +	if (bp->caps & MACB_CAPS_HIGH_SPEED)
> +		idleslope =3D DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_k=
bps);
> +	else
> +		idleslope =3D (u32)qopt->idleslope * (kset.base.speed >=3D 1000 ?
> +					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
> +
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		/* Disable CBS for the queue before updating idleslope */
> +		ctrl =3D gem_readl(bp, CBS_CONTROL) & ~enable_bit;
> +		gem_writel(bp, CBS_CONTROL, ctrl);
> +		/* Update idleslope for the queue */
> +		if (is_queue_a)
> +			gem_writel(bp, CBS_IDLESLOPE_Q_A, idleslope);
> +		else
> +			gem_writel(bp, CBS_IDLESLOPE_Q_B, idleslope);
> +
> +		/* Re-enable CBS for the queue with new idleslope */
> +		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
> +	}
> +
> +	netdev_dbg(ndev, "CBS: Configured queue %d with idleslope 0x%x\n",
> +		   qopt->queue, idleslope);
> +
> +	return 0;
> +}
> +
> +static void macb_cbs_destroy(struct net_device *ndev, u8 queue_num)
> +{
> +	struct macb *bp =3D netdev_priv(ndev);
> +	bool is_queue_a;
> +	u32 enable_bit;
> +
> +	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &is_queue_a))
> +		return;
> +
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
> +		if (is_queue_a)
> +			gem_writel(bp, CBS_IDLESLOPE_Q_A, 0);
> +		else
> +			gem_writel(bp, CBS_IDLESLOPE_Q_B, 0);
> +	}
> +
> +	netdev_dbg(ndev, "CBS: Disabled queue %d\n", queue_num);
> +}
> +
> +static int macb_setup_cbs(struct net_device *ndev,
> +			  struct tc_cbs_qopt_offload *qopt)
> +{
> +	if (qopt->enable)
> +		return macb_cbs_add(ndev, qopt);
> +
> +	macb_cbs_destroy(ndev, qopt->queue);
> +	return 0;
> +}
> +
>  static int macb_setup_mqprio(struct net_device *ndev,
>  			     struct tc_mqprio_qopt_offload *mqprio)
>  {
> @@ -4594,6 +4713,8 @@ static int macb_setup_tc(struct net_device *dev, en=
um tc_setup_type type,
>  	switch (type) {
>  	case TC_SETUP_QDISC_MQPRIO:
>  		return macb_setup_mqprio(dev, type_data);
> +	case TC_SETUP_QDISC_CBS:
> +		return macb_setup_cbs(dev, type_data);
>  	case TC_SETUP_QDISC_TAPRIO:
>  		return macb_setup_taprio(dev, type_data);
>  	default:
> --=20
> 2.44.4
>=20

--fX/fMEqN3gnPpM0x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCanYWyAAKCRB4tDGHoIJi
0h3YAQCBOqrOna4MoHC+W5U9BpDnV7+/U21C4RWIU37nYdNC1AEA1bVaguc3cT70
iZmlAgT2thu9/2x0ma7DM3iwV/3Z/A0=
=bg10
-----END PGP SIGNATURE-----

--fX/fMEqN3gnPpM0x--
