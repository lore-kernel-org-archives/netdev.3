Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736F471CEA;
	Thu, 10 Sep 2026 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039259; cv=none; b=L5InLgOBJgCRu90gVXaShGF+ktq96Er+QJHWQNDKObRzWBJIshIfKr0v/rmf5H+yyiCzXOxUq6VpMXAhLs6ECiq04eKIQBFyHzDTjuaxAhL2uNAi9YZWubhuS5Ey83ZYhlqboNjTN8f+eHnaMjzp0h8q3ognXYBmMDhp5zwTJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039259; c=relaxed/simple;
	bh=PN5/kxQ5FBNlmtI6XspR7H230X/tKGY2AeXsytHlQjw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrhH6ToPoHpQsNYzVMyR24zFVL88ZjLC63HD0x23L5tQfUCapxUbylZk1RJQkZn2EhLcnWUvtOeREXoBVOZUYJZ712Ll5xDKrGwdAR742C+QuW0DCNAXn9VuyCtNbVd345aoOda0w7HsccbuXh3Lklnvujsu6FeVNxCeHanYvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTP7CugY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTP7CugY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0851F00893;
	Thu, 10 Sep 2026 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039257;
	bh=4YoZZmaKA2iVAEQYVxLLU72x9KnrYSEBBkocKbLOQtA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GTP7CugYZJ9zXzjq5a2CZB+LeZk5Ghv+IXggKhEDVSy/F8N9qnX9YeG1AYeXTjNWK
	 c6qq1Zm12WSDHTwDqGI0x2B9IsObvy3gxF810U7m+ykcM1i9/n42CiMYNYmq3JIHCA
	 nk0rBtZ/xTL3w2oLs+XMbMlAzh5uFRrqTVaTc0evUlckXjwfY9WCoORCRKrw3qH5t6
	 c76CFZOlarGYuY1FsWr0JoEQKG12ych9IFWZ7l66TvtfBVRo1dCHxnxN1i2HrMjsQ5
	 fz6aKm+ODXDfFNv1QTIlxL/gGhXxJW3ZDDT3o+bQ6nP8IFs3nUbPe7xr3/B+fzALPU
	 5eyhqXWKWWBkw==
Subject: Re: [PATCH v4 net-next 01/15] net: enetc: add trusted VF support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 11:20:55 +0000
Message-ID: <178903925585.219967.18067064676940135635@kernel.org>
In-Reply-To: <20260909100733.1139689-2-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-2-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 3

- [High] Trust revocation ("ip link set <dev> vf <N> trust off") clears
  only the software bit in pf->vf_state[vf].flags; it never reprograms…
- [Medium] Default-deny of the VF primary-MAC mailbox message is a user-
  visible behaviour change that the commit message understates, and the…
- [Low] Reported for completeness and marked as resolved within the
  series: at this commit both enetc_ndev_ops (enetc_pf.c:482-503) and…
- [Low] Reported for completeness and marked as resolved within the
  series: at this commit enetc4_ndev_ops advertises .ndo_set_vf_trust…
- [Low] Reported for completeness and assessed as intended, documented
  behaviour: ENETC_VF_FLAG_TRUSTED lives in pf->vf_state[] which is…

--

net: enetc: add trusted VF support

This adds an ENETC_VF_FLAG_TRUSTED per-VF flag and wires up
ndo_set_vf_trust through the new shared enetc_pf_set_vf_trust() helper for
both the enetc and enetc4 PF drivers.  The first mailbox message gated on
the flag is the VF primary MAC address change, which now returns
ENETC_MSG_CLASS_ID_PERMISSION_DENY for untrusted VFs.

A few questions below.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 9bb1004548ab..935a6a03b14f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -225,11 +225,15 @@ static const struct enetc_pf_ops enetc4_pf_ops = {
>  static int enetc4_pf_struct_init(struct enetc_si *si)
>  {
>  	struct enetc_pf *pf = enetc_si_priv(si);
> +	int err;
>  
>  	pf->si = si;
> -	pf->total_vfs = pci_sriov_get_totalvfs(si->pdev);
>  	pf->ops = &enetc4_pf_ops;
>  
> +	err = enetc_init_sriov_resources(pf);
> +	if (err)
> +		return err;
> +
>  	enetc4_get_port_caps(pf);
>  	enetc4_get_psi_hw_features(si);
>  
> @@ -574,6 +578,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
>  	.ndo_eth_ioctl		= enetc_ioctl,
>  	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
>  	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
> +	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
>  };

[Severity: Low]
At this commit enetc4_pf_driver has no .sriov_configure member and enetc4
never calls enetc_msg_psi_init(), so VFs cannot be instantiated on ENETC v4
and the mailbox worker is never armed.

The only reader of ENETC_VF_FLAG_TRUSTED is
enetc_msg_set_vf_primary_mac_addr(), reached via enetc_msg_task() which is
only set up by enetc_sriov_configure().  Does that mean

  ip link set <enetc4 pf> vf N trust on

returns 0 here with no observable effect, and that the new
enetc_init_sriov_resources() call allocates rxmsg/vf_state plus total_vfs
mutexes for slots that cannot exist yet?

This is resolved later in the same series: the patch adding VF support for
i.MX94 and i.MX95 adds .sriov_configure = enetc_sriov_configure to
enetc4_pf_driver, and enetc_msg.c then gates several ENETC v4 mailbox
operations on the trust flag.  Noting it only because the knob is advertised
one patch before it can do anything.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index edc1277bb586..78114ab3e482 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -61,31 +63,49 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
>  	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
>  	struct enetc_msg_mac_exact_filter *msg = vf_msg;
>  	struct device *dev = &pf->si->pdev->dev;
> +	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
>  	char *addr = msg->mac[0].addr;
>  
> +	mutex_lock(&vf_state->lock);
> +
> +	/* Untrusted VFs cannot set their MAC addresses by the mailbox
> +	 * messages.
> +	 */
> +	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
> +		pf_msg = ENETC_PF_MSG_PERM_DENY;
> +		goto vf_state_unlock;
> +	}
> +

[Severity: Medium]
Is this a user-visible behaviour change for existing SR-IOV deployments?

ENETC_VF_FLAG_TRUSTED is zero for every slot, since vf_state is
devm_kcalloc()'d in enetc_init_sriov_resources() and only
"ip link set <pf> vf N trust on" sets the bit.  On the VF side
enetc_msg_vsi_send() maps the new response to an errno:

  case ENETC_MSG_CLASS_ID_PERMISSION_DENY:
	return -EACCES;

So after this patch enetc_vf_set_mac_addr() -> enetc_msg_vsi_send() fails
with -EACCES, and an in-guest "ip link set <vf> address ..." or enslaving
the VF into a bond/macvlan stops working after a kernel upgrade with no
configuration change.

The commit message says:

    This does not regress VF bring-up. The PF programs a valid
    primary MAC into every VF slot at probe, and the VF loads it from its
    own SIPMAR0/1 registers.

Bring-up is indeed unaffected, but could the message also state that guests
which previously changed their own VF MAC now need the host to mark the slot
trusted first?

Related question on tags: the message describes this as preventing a
malicious VM from eavesdropping on other SIs and from spoofing MAC
addresses, and the VF-set-MAC path has existed since commit beb74ac878c8
("enetc: Add vf to pf messaging support").  Should this carry a Fixes: tag
or stable guidance for backporters?

>  	if (!is_valid_ether_addr(addr)) {
>  		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
>  				    vf_id);
> -		return (FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> -				   ENETC_MSG_CLASS_ID_MAC_FILTER) |
> -			FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
> -				   ENETC_MF_CLASS_CODE_INVALID_MAC));
> +		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> +				    ENETC_MSG_CLASS_ID_MAC_FILTER) |
> +			 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
> +				    ENETC_MF_CLASS_CODE_INVALID_MAC);
> +		goto vf_state_unlock;
>  	}
>  
> -	mutex_lock(&vf_state->lock);
> +	/* PF has higher privileges. If PF has already modified the MAC
> +	 * address for VF through .ndo_set_vf_mac() interface, VF is not
> +	 * allowed to set its MAC address via mailbox messages, even if
> +	 * it is trusted.
> +	 */
>  	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
> -		mutex_unlock(&vf_state->lock);
>  		dev_err_ratelimited(dev,
>  				    "VF%d attempted to override PF set MAC\n",
>  				    vf_id);
> -		return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> -				  ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
> +		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> +				    ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
> +		goto vf_state_unlock;
>  	}
>  
>  	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
> +
> +vf_state_unlock:
>  	mutex_unlock(&vf_state->lock);
>  
> -	return ENETC_PF_MSG_SUCCESS;
> +	return pf_msg;
>  }

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 55c07c528f22..a7bf4bfc25b7 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -488,6 +488,7 @@ static const struct net_device_ops enetc_ndev_ops = {
>  	.ndo_set_rx_mode	= enetc_pf_set_rx_mode,
>  	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
> +	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
>  	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
>  	.ndo_set_vf_vlan	= enetc_pf_set_vf_vlan,
>  	.ndo_set_vf_spoofchk	= enetc_pf_set_vf_spoofchk,

[Severity: Low]
At this commit neither enetc_ndev_ops nor enetc4_ndev_ops implements
.ndo_get_vf_config, and rtnl_fill_vf() returns early when
ndo_get_vf_config is NULL, so IFLA_VF_TRUST is never emitted and
"ip link show <pf>" prints no VF block.

Since the remediation the commit message recommends is
"ip link set <dev> vf <N> trust off", would it be worth making the trust
state readable in the same patch that makes it settable?

This is closed later in the series by the patch adding ndo_get_vf_config()
support, which reports ivi->trusted from the same flag.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index d32a195a04c9..519fc90d2647 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -586,5 +586,28 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
>  }
>  EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
>  
> +int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(priv->si);
> +	struct enetc_vf_state *vf_state;
> +
> +	if (vf >= pf->total_vfs)
> +		return -EINVAL;

[Severity: Low]
Trust lives in pf->vf_state[], which is allocated once at PF probe, and the
bound here is pf->total_vfs rather than pf->num_vfs.  It is not cleared by
enetc_sriov_configure(pdev, 0), by pci_disable_sriov(), or by VF FLR, so a
slot trusted for one guest stays trusted when the VF is destroyed and
re-created for another guest.

The commit message states this is deliberate:

    it is intentionally preserved across an SR-IOV disable/enable
    cycle. The bounds check uses pf->total_vfs, the hardware maximum and
    the size of pf->vf_state[], so pre-configuring an uninstantiated slot
    is in-bounds. If a slot may be reassigned to another guest, the admin
    clears trust with "ip link set <dev> vf <N> trust off".

Later in the series enetc_msg_clear_vf_config() encodes the same rationale
in a comment, so this looks intended and is mentioned only for the record.

> +
> +	vf_state = &pf->vf_state[vf];
> +	mutex_lock(&vf_state->lock);
> +
> +	if (setting)
> +		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
> +	else
> +		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;

[Severity: High]
Does clearing trust here leave the hardware MAC filter that the VF
programmed while it was trusted?

While trusted, the guest can put any valid unicast address into the SI
primary MAC registers, including the PF's or another VF's:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_primary_mac_addr() {
	...
	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
	...
}

The trust-off branch above only clears the software bit, so ENETC_PSIPMAR0/1
(ENETC4_PSIPMAR0/1 on v4) for that SI keep the guest-chosen address.

The other paths that could restore it do not.  enetc_setup_mac_addresses()
is the only place a PF-chosen MAC is written into every VF slot, and it runs
at probe:

drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:enetc_setup_mac_addresses() {
	...
	for (i = 0; i < pf->total_vfs; i++) {
		err = enetc_setup_mac_address(NULL, pf, i + 1);
	...
}

enetc4_pf_vf_flr_handler() re-applies only promiscuous state, so the address
also survives a VF FLR (guest reboot or driver reload), and the SR-IOV
disable path does not touch it either.

So after the documented "ip link set <dev> vf <N> trust off", frames for the
spoofed address still hit that SI's exact-match filter, and a slot later
reassigned to a different guest inherits the address, because the VF driver
reads its MAC out of SIPMAR0/1.

At the end of the series the trust-off branch grows scrubbing of
promiscuous mode and of the UC/MC hash filters, but still does not restore
the SI primary MAC.  Should this branch reprogram the PF-assigned primary
MAC for the slot as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909100733.1139689-1-wei.fang%40oss.nxp.com
