Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2393D0BE9;
	Sun,  6 Sep 2026 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788668118; cv=none; b=uzzB9vJG4K1DazvXPD+kQv3i8RKbt+Al3kBfdL82ztf4pF70d+ecAG89e1HbOKINu/6k98MFTMPY2DysVmcCUeTeK/97DzMuK+PEsv1scim4YVQrIxgMjW55rUa55mXMIaFluAXqHN/VQJlAjx5JuYin/sT6vgu91ydORJ6ZeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788668118; c=relaxed/simple;
	bh=LzE2QxQvFjOldemw1joETAp+rAIqtzG30VTeIavs1H0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqv8QfeuiSeqNWD8u7I//L+8FvG4PdpABezQtDbTjfCVIaVyt5EYKymoJyGcZ8S3c/jX9naLf/jxKXVMWtlF0YYPOYB4HvUfdKxvP84UHgfHwqwjYLhehfpTok9VdARUpFkOWEGMZVPwEy8SQH23iVWYIwRXPHNcToqR05g7gSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPFEZz7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPFEZz7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D7D1F00A3A;
	Sun,  6 Sep 2026 04:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788668115;
	bh=/ODEmOVaZNoe3SxxEirFhhdAgUoxNU8vfhBnBIpL+O8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NPFEZz7GDr7bRSnPMRBBJeRnSut+OwmxDf0yhEt9FQq0ZsVLw4BIul2SkiZlJCaOr
	 VMKesvogHMC1dJzLQ4GttEVR2CC3JBUgC7TasyEr2yZDFz7TXVuGP+XIWr90Eic4QR
	 7Rgpua5slSAVSjUNoB2ta232qEXnxDrdYdfl3DTx3uVJjA4KbYhVXecEHKaavBmZDN
	 fpPmRfjmxe2HyOFcotvorfVqgwI4GYXUu7lltXK/gR8+DXzT2YIMx+dgFTKqrHETnJ
	 2AVSvIZS0UitBzusdNOIvkIZgecE5q9foitDojl36+Y+c9+0xweJlt0RGEUtRDa2up
	 +zdbWrNCeBiqQ==
Subject: Re: [PATCH net-next v2] net: fec: support RX flushing via an ethtool
 private flag
From: netdev-bot+sashiko@kernel.org
To: alexander.sverdlin@siemens.com
Cc: netdev@vger.kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
 shenwei.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Sun, 06 Sep 2026 04:15:14 +0000
Message-ID: <178866811459.219967.2326693241215437513@kernel.org>
In-Reply-To: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
References: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] fec_enet_get_sset_count() returns 0 (not a negative error) for
  ETH_SS_PRIV_FLAGS on every FEC variant lacking…
- [Low] The new fec.rst documentation contradicts the implementation it
  ships with.

--

net: fec: support RX flushing via an ethtool private flag

This adds per-queue RX FIFO flushing support for the FEC controller by
exposing the RX_FLUSHn bits of FEC_QOS_SCHEME as runtime ethtool private
flags named rx-flush-qN.  A new fec.rst document describing the flags is
added along with the driver changes.

> diff --git a/Documentation/networking/device_drivers/ethernet/freescale/fec.rst b/Documentation/networking/device_drivers/ethernet/freescale/fec.rst
> new file mode 100644
> index 0000000000000..502261f517e05
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/freescale/fec.rst
> @@ -0,0 +1,55 @@

[ ... ]

> +Some hardware features that are specific to the FEC and have no generic ethtool
> +control are exposed as ethtool private flags. The set of available flags depends
> +on the SoC and on the driver configuration (for example, the number of receive
> +queues), so the flags are enumerated at runtime::
> +
> +	$ ethtool --show-priv-flags ethX
> +
> +	$ ethtool --set-priv-flags ethX <flag> on|off
> +
> +rx-flush-qN
> +-----------
> +
> +On multi-queue capable controllers the driver exposes one ``rx-flush-qN``
> +private flag per receive queue (``rx-flush-q0``, ``rx-flush-q1``, ...), which
> +enables RX flushing for that queue. RX flushing is disabled by default.

[Severity: Low]
Does this description match the code that ships in the same patch?  The
document says one flag is exposed "per receive queue" and that the flag set
depends on "the number of receive queues", but fec_enet_get_sset_count() and
fec_enet_get_strings() enumerate min(fep->num_rx_queues,
fep->num_tx_queues) flags, and fec_enet_set_priv_flags() rejects anything
above that minimum with -EINVAL.

fec_enet_get_queue_num() reads the two counts from independent properties:

	of_property_read_u32(np, "fsl,num-tx-queues", num_tx);

	of_property_read_u32(np, "fsl,num-rx-queues", num_rx);

each clamped separately to 1..3, and nothing in the driver or the binding
forces them to be equal.  So with fsl,num-rx-queues=3 and
fsl,num-tx-queues=1, the documented rx-flush-q1 and rx-flush-q2 do not exist
and cannot be set, and the document gives no hint why.

The commit message does explain the TX dependency ("RX flushing code just
takes min() of the both values for now"), and the -EOPNOTSUPP path for
controllers without FEC_QUIRK_HAS_MULTI_QUEUES is also not mentioned in the
new .rst.  Could both be spelled out in the document as well?

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 794ec427b0ee6..e5c1d04a665c4 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c

[ ... ]

> @@ -3561,11 +3581,18 @@ static void fec_enet_get_strings(struct net_device *netdev,
>  	case ETH_SS_TEST:
>  		net_selftest_get_strings(data);
>  		break;
> +	case ETH_SS_PRIV_FLAGS:
> +		if (!(fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES))
> +			break;
> +		for (i = 0; i < min(fep->num_rx_queues, fep->num_tx_queues); i++)
> +			ethtool_sprintf(&data, "rx-flush-q%d", i);
> +		break;
>  	}
>  }
>  
>  static int fec_enet_get_sset_count(struct net_device *dev, int sset)
>  {
> +	struct fec_enet_private *fep = netdev_priv(dev);
>  	int count;
>  
>  	switch (sset) {
> @@ -3576,11 +3603,67 @@ static int fec_enet_get_sset_count(struct net_device *dev, int sset)
>  
>  	case ETH_SS_TEST:
>  		return net_selftest_get_count();
> +	case ETH_SS_PRIV_FLAGS:
> +		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES)
> +			return min(fep->num_rx_queues, fep->num_tx_queues);
> +		return 0;

[Severity: Medium]
Should this return a negative error instead of 0 when the quirk is absent?

On the FEC variants without FEC_QUIRK_HAS_MULTI_QUEUES (i.MX25/27/28/6Q/6UL,
mvf600, s32v234) this reports a private flag count of 0, while the patch
installs .get_priv_flags/.set_priv_flags unconditionally, so
privflags_prepare_data() no longer takes its early exit:

net/ethtool/privflags.c:privflags_prepare_data() {
	ops = dev->ethtool_ops;
	if (!ops->get_priv_flags || !ops->get_sset_count || !ops->get_strings)
		return -EOPNOTSUPP;

ethnl_get_priv_flags_info() only errors on nflags < 0, so n_priv_flags stays
0 and both reply helpers then evaluate a 32-bit shift by 32:

net/ethtool/privflags.c:privflags_reply_size() {
	const u32 all_flags = ~(u32)0 >> (32 - data->n_priv_flags);

The same expression appears in privflags_fill_reply().  Can this produce an
UBSAN shift-out-of-bounds report (or a trap with CONFIG_UBSAN_TRAP) for any
local user running "ethtool --show-priv-flags eth0" on those SoCs?  Before
this patch every FEC took the -EOPNOTSUPP path because ops->get_priv_flags
was NULL.

Returning -EOPNOTSUPP for ETH_SS_PRIV_FLAGS when the quirk is not present
would be propagated unchanged by ethnl_get_priv_flags_info() and keeps the
old behaviour.

>  	default:
>  		return -EOPNOTSUPP;
>  	}
>  }
>  

[ ... ]

> +static int fec_enet_set_priv_flags(struct net_device *ndev, u32 flags)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	u32 mask = 0;
> +	int i;
> +
> +	if (!(fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES))
> +		return -EOPNOTSUPP;
> +
> +	/* According to i.MX8QXP Reference Manual, "when both class 1 and
> +	 * class 2 are disabled, RX flushing for these rings must also be
> +	 * disabled".
> +	 */
> +	if (flags & ~(BIT(min(fep->num_rx_queues, fep->num_tx_queues)) - 1))
> +		return -EINVAL;

[ ... ]

> @@ -3800,6 +3883,8 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
>  	.get_strings		= fec_enet_get_strings,
>  	.get_ethtool_stats	= fec_enet_get_ethtool_stats,
>  	.get_sset_count		= fec_enet_get_sset_count,
> +	.get_priv_flags		= fec_enet_get_priv_flags,
> +	.set_priv_flags		= fec_enet_set_priv_flags,
>  #endif

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901074732.113791-1-alexander.sverdlin%40siemens.com
