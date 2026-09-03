Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2C383C99;
	Thu,  3 Sep 2026 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479088; cv=none; b=UeMBpRasi6Z1q1/WRdkSQ3uvvtcFIc1ISUGLu0FkVbClWzvsKtsIWvPx5roeeUoUKghb+0WKM1xIyUmscn3PRPcsiAVeuPY2FBKdTvuobwercC0q9TKgBGJAfvdxbow5BF/zBsXIsm6EXLSmfbu8mt/z9OXT1wHKqqYet/qTikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479088; c=relaxed/simple;
	bh=ks+3RDQTwyCQqrxXuIiqYqvI2nQDUSOsZcK+ne6zGQo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELJmKmp2Dr7LIw57JpCWMuN1VycfDqgxmVV4zjGPrL+BnNhgBE8chpxnQYiWWapFc40ranJoNLGK5GVqLsDAsC2QzvmVr6Qva8KcDDTz0tmoPdlIKZmoYDyhdvaJYQoNh+9LPoxrrTAKPzT6+qu5wELbVpBzMm33xZu8TAYZlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVq0ezPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVq0ezPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFA21F00A3E;
	Thu,  3 Sep 2026 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479074;
	bh=J3er4KbyP73/+5jh2cM1qspnTuX7WgPHOm82tUS+G2I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gVq0ezPadSLnsIDhlvshNLWqtaUnuZzt5NLytTWjC/QwzIsHKJcBEvpJJZc+5ivhA
	 jrEJWoPfF/oME7V8w8XkYfMNLBzJj5dXqiW64jP0GLVVHfYD3iC7Aae0Yc9mk171Et
	 xDpfRMYQe25C82KzMrAe1/QF3cwH2EDoM6JVOI+FZtdzKifNJOXcUs1JrLUK1WxIPC
	 cOC/SYWoW65xBpFN7KRUiMqS78as5J2dzFwBwr+W/1uRqFnAKulAAhwuDn+ZRQWXWr
	 Bin7kOa1A6RsMankSecdvBT3J1/gamH0wu44H03xMBwVDBcYvRXbrjj/4sQf9SL3P2
	 JVgpP9hE1s/Dg==
Subject:
 Re: [PATCH v3 net-next 15/15] net: enetc: add ndo_get_vf_config() support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:33 +0000
Message-ID: <178847907358.4131868.2244223357002724408@kernel.org>
In-Reply-To: <20260831025441.635045-16-wei.fang@oss.nxp.com>
References: <20260831025441.635045-16-wei.fang@oss.nxp.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] enetc4_ndev_ops
  (drivers/net/ethernet/freescale/enetc/enetc4_pf.c:600) registers…
- [Medium] enetc_pf_get_vf_config() reports the VF VLAN from the new
  software shadow (vf_state->vid/qos, enetc_pf_common.c:705-709) instead…

--

net: enetc: add ndo_get_vf_config() support

This adds enetc_pf_get_vf_config() so 'ip link show' can query the per-VF
MAC, VLAN, spoofchk and trust state from the PF.  struct enetc_vf_state
gains tpid/qos/vid fields plus an ENETC_VF_FLAG_SPOOFCHK flag, which the
existing VLAN and spoofchk setters now update, and the new callback is
registered in both the ENETC rev1 and the ENETC v4 ops tables.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index a945a120c553..b4d76505bc03 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -597,6 +597,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
>  	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
>  	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
>  	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
> +	.ndo_get_vf_config	= enetc_pf_get_vf_config,
>  };

[Severity: Medium]
Is registering enetc_pf_get_vf_config() in enetc4_ndev_ops correct given
that this table has neither .ndo_set_vf_spoofchk nor .ndo_set_vf_vlan?

Those two setters are the only writers of ENETC_VF_FLAG_SPOOFCHK and of
vf_state->vid/qos/tpid, and they are installed only in enetc_ndev_ops in
enetc_pf.c.  On an ENETC v4 PF the shadow state therefore stays at its
zero-initialized value forever.

rtnl_fill_vfinfo() presets the sentinel before calling the driver:

net/core/rtnetlink.c:rtnl_fill_vfinfo() {
	...
	ivi.spoofchk = -1;
	...
	/* The default value for VF link state is "auto"
	 * IFLA_VF_LINK_STATE_AUTO which equals zero
	 */
	ivi.linkstate = 0;
	...
	if (dev->netdev_ops->ndo_get_vf_config(dev, vfs_num, &ivi))
		return 0;
	...
}

enetc_pf_get_vf_config() then overwrites that with an affirmative value:

	ivi->spoofchk = !!(vf_state->flags & ENETC_VF_FLAG_SPOOFCHK);

so 'ip link show' on an ENETC v4 PF prints "spoof checking off" instead of
omitting the value, for a feature this revision cannot control: attempts to
change it return -EOPNOTSUPP because no ndo_set_vf_spoofchk is installed,
and the enetc4 anti-spoofing bits PSICFGR0_VASE/PSICFGR0_ASE (via
PSICFGR0_ANTI_SPOOFING in enetc4_hw.h) have no users at all -
enetc4_psicfgr0_val_construct() never touches them.

Would it make sense to only report spoofchk/VLAN where the matching
setters exist, e.g. by leaving ivi->spoofchk untouched when the revision
has no spoofchk support?

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 523c71324780..d77a07cece28 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -207,6 +208,17 @@ static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
>  		return -EPROTONOSUPPORT;
>  
>  	enetc_set_isol_vlan(&priv->si->hw, vf + 1, vlan, qos);
> +
> +	vf_state = &pf->vf_state[vf];
> +	mutex_lock(&vf_state->lock);
> +	/* Currently only C-tags is supported, so tpid is always 0,
> +	 * which indicates ETH_P_8021Q.
> +	 */
> +	vf_state->tpid = 0;
> +	vf_state->qos = qos;
> +	vf_state->vid = vlan;
> +	mutex_unlock(&vf_state->lock);
> +
>  	return 0;
>  }

[ ... ]

> @@ -223,6 +236,16 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
>  	cfgr = (cfgr & ~ENETC_PSICFGR0_ASE) | (en ? ENETC_PSICFGR0_ASE : 0);
>  	enetc_port_wr(&priv->si->hw, ENETC_PSICFGR0(vf + 1), cfgr);
>  
> +	vf_state = &pf->vf_state[vf];
> +	mutex_lock(&vf_state->lock);
> +
> +	if (en)
> +		vf_state->flags |= ENETC_VF_FLAG_SPOOFCHK;
> +	else
> +		vf_state->flags &= ~ENETC_VF_FLAG_SPOOFCHK;
> +
> +	mutex_unlock(&vf_state->lock);
> +
>  	return 0;
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 10134d7a1f70..264294a0cc23 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -684,5 +684,36 @@ int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
>  }
>  EXPORT_SYMBOL_GPL(enetc_pf_set_vf_mac);
>  
> +int enetc_pf_get_vf_config(struct net_device *ndev, int vf,
> +			   struct ifla_vf_info *ivi)
> +{
[ ... ]
> +	ivi->vf = vf;
> +	ivi->spoofchk = !!(vf_state->flags & ENETC_VF_FLAG_SPOOFCHK);
> +	ivi->trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
> +	enetc_get_si_hw_addr(pf, vf + 1, ivi->mac);
> +
> +	if (vf_state->vid) {
> +		ivi->vlan = vf_state->vid;
> +		ivi->qos = vf_state->qos;
> +		ivi->vlan_proto = vf_state->tpid ? htons(ETH_P_8021AD) :
> +						   htons(ETH_P_8021Q);
> +	}

[Severity: Medium]
Can this report a stale VLAN configuration after a PF driver unbind and
rebind?

The MAC is read back from hardware via enetc_get_si_hw_addr(), but the VLAN
comes from the new software shadow instead of ENETC_PSIVLANR(vf + 1), which
is where EN/QOS/VID actually live.  enetc_set_isol_vlan() is the only writer
of that register:

drivers/net/ethernet/freescale/enetc/enetc_pf.c:enetc_set_isol_vlan() {
	u32 val = 0;

	if (vlan)
		val = ENETC_PSIVLAN_EN | ENETC_PSIVLAN_SET_QOS(qos) | vlan;

	enetc_port_wr(hw, ENETC_PSIVLANR(si), val);
}

Probe-time port setup rewrites PSICFGR0 for every VF, but nothing clears
PSIVLANR:

drivers/net/ethernet/freescale/enetc/enetc_pf.c:enetc_port_si_configure() {
	...
	for (i = 0; i < pf->total_vfs; i++)
		enetc_port_wr(hw, ENETC_PSICFGR0(i + 1), val);
	...
}

So after 'ip link set <pf> vf N vlan 100' followed by unbind/rebind of the
PF driver, pf->vf_state is freshly zeroed while the hardware still holds
ENETC_PSIVLAN_EN | vid | qos for that VF SI, and this getter reports vlan 0.

Would reading PSIVLANR (and the ASE bit in PSICFGR0) directly in the getter
avoid the divergence and also remove the need for the new shadow fields?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
