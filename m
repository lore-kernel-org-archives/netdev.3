Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388D1F1932;
	Thu,  3 Sep 2026 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479065; cv=none; b=jEgCp8YfBp1vvWAf7/QNxe4QdUpdleMnKjOTAKh657orgyYw49C+VFdGpLLGx+1gbaMiQG5FmW5pJos0Ljo9rU7Ew4j7tQvTu2fk1UZXt/qwViU0yhkvl30eIDy/EvmubZF9rXnhuPhW1R6x1wf3fEpPZy4Yb2GHdjsIk/3traE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479065; c=relaxed/simple;
	bh=SA5jcp3uo/fG6zBYWJy8H8xGXXQTpAA4sNxw8Nq9v8g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqGu06SLjQfCuTj0tCCgWQhUaORbzza/u3b+c9LoodGSdd0wEreMsMd8/16IWBJMWMXWDTYJH7LsNa2Ff79iVDJ6ET9cW9Z8k5xUOwbQqXre8D927uECe3Iacbvjvco2FYMpPbBaLSUKxfy1zGieGv3eCVm/pEnAOJUVOgX2j9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqLgMXF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqLgMXF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB371F000E9;
	Thu,  3 Sep 2026 23:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479063;
	bh=GjC+/ci33df+FSTl7ILK+WFX2k9Yyxw6Ei29xTwhQps=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BqLgMXF9dAVxIzRKVuQ+jL/ZvmFXszqmkCbD6JW145Yd1i80o5/TY88t03E8zQ5PM
	 qm+oNMwRjBHpzbWNMkktaLfRtDmHQ/0SYUcgRwcNtMJGF9/QNUNU/Jz/yI90nDOtaK
	 L4PlUmpB+ecUPLD6LwQ0w4URfT89yutqbSDx3nHt4kqnWRpMSAiS0wpL82PkDWbGaM
	 78sAX6NezNtaMeYPnqCUGhjrQZuemjH3YNAo3bb5cjLLAMccVnswTPID7psVuPPLiQ
	 VQi1TQJ9KbYotv0WKnSivBGVvfym7yQrI3sXgb/uxY9t+iUO/cbPr8OqNTIwELh4l+
	 2+mA+6c9Z9z6A==
Subject: Re: [PATCH v3 net-next 01/15] net: enetc: add trusted VF support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:22 +0000
Message-ID: <178847906205.4131868.13793476911269935039@kernel.org>
In-Reply-To: <20260831025441.635045-2-wei.fang@oss.nxp.com>
References: <20260831025441.635045-2-wei.fang@oss.nxp.com>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 2

- [High] The patch breaks standard Linux SR-IOV semantics by
  unconditionally preventing untrusted VFs from setting their MAC…
- [Medium] ENETC_VF_FLAG_TRUSTED is stored in pf->vf_state[], which is
  devm_kcalloc()'ed once per PF at probe (enetc_init_sriov_resources(),…
- [Medium] Trust revocation leaves hardware state behind:
  enetc_pf_set_vf_trust() clears only software flag bits.
- [Low] (Baseline verdict: false positive - retained only because the
  concern is flagged requires_validation.) Claim: the commit describes a…
- [Low] (Baseline verdict: false positive - retained only because the
  concern is flagged requires_validation.) Claim: both PF ops tables…

--

net: enetc: add trusted VF support

This adds a per-VF ENETC_VF_FLAG_TRUSTED flag stored in pf->vf_state[] and
wires up ndo_set_vf_trust through the new shared helper
enetc_pf_set_vf_trust() for both the enetc and enetc4 PF drivers.  The VF
primary MAC address mailbox message is the first message gated on that
flag, and untrusted VFs now get ENETC_MSG_CLASS_ID_PERMISSION_DENY instead
of having the hardware programmed.

A couple of questions about the trust flag lifetime and about the
changelog below.

The changelog says:

    An untrusted VF that attempts to set its own MAC address will receive a
    ENETC_MSG_CLASS_ID_PERMISSION_DENY response and the hardware will not
    be programmed. To prevent a malicious VM from setting the VF address to
    the MAC address of other VFs or PF, thereby eavesdropping on the traffic
    of other SIs.

[Severity: Low]
Before this patch any VF address that passed is_valid_ether_addr() and the
ENETC_VF_FLAG_PF_SET_MAC check was programmed into the SI primary MAC
registers, so the description matches the pre-patch behaviour.  Was a Fixes
tag considered here, given the wording describes an exploitable condition?

This is likely just a maintainer judgement call rather than a code problem:
the default-deny change is documented in the changelog itself, and the VF
side already maps the deny class to -EACCES in enetc_msg_vsi_send() with an
explicit comment, so the deny path looks like a coordinated design point.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 9bb1004548ab..935a6a03b14f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

[ ... ]

> @@ -574,6 +578,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
>  	.ndo_eth_ioctl		= enetc_ioctl,
>  	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
>  	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
> +	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
>  };

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index edc1277bb586..78114ab3e482 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -7,6 +7,8 @@
>  					   ENETC_MSG_CLASS_ID_CMD_SUCCESS)
>  #define ENETC_PF_MSG_NOTSUPP	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
>  					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
> +#define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
> +					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
>  
>  static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
>  {
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
>  	if (!is_valid_ether_addr(addr)) {
>  		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
>  				    vf_id);

[Severity: High]
This gate looks like it inverts the usual meaning of the trust
attribute, and it changes behaviour for existing VF users.

In ixgbe/i40e/ice the rule is: a VF may program its own MAC as long as
the PF has not administratively assigned one, and "trusted" is exactly
the knob that lets a VF go further and override the PF-assigned address.
Here both halves are reversed. The new check in
enetc_msg_set_vf_primary_mac_addr() returns ENETC_PF_MSG_PERM_DENY for
any VF without ENETC_VF_FLAG_TRUSTED, even when no PF-assigned address
exists (ENETC_VF_FLAG_PF_SET_MAC clear), and the following
ENETC_VF_FLAG_PF_SET_MAC test still refuses the request for a trusted
VF - the new comment states this explicitly ("even if it is trusted").
So trust neither grants the override it is supposed to grant, nor is it
irrelevant to the plain "VF picks its own MAC" case.

Since vf_state[] is devm_kcalloc()'ed in enetc_init_sriov_resources()
and flags starts at 0, every VF is untrusted at creation. That means
after this patch a guest that generates its own address and calls
ndo_set_mac_address on the VF gets the deny class back, which
enetc_msg_vsi_send() turns into -EACCES, and interface bring-up fails
unless the host has first run "ip link set ... vf N trust on". That is
a visible change for setups that work today, and there is no Fixes tag
or mention of the compatibility impact in the changelog.

Was the ixgbe-style rule considered instead, i.e. allow the mailbox MAC
change whenever ENETC_VF_FLAG_PF_SET_MAC is clear, and consult
ENETC_VF_FLAG_TRUSTED only to decide whether a VF may override a
PF-assigned address? If the stricter default-deny is deliberate for
this hardware, could the changelog spell out that untrusted VFs can no
longer set any MAC at all and that trust is now required for what used
to work by default?

[ ... ]

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
                ^^^^^^^^^^^^^^^^^^^^^^

Note for the two questions further down: this is where the trusted VF's
chosen address is committed to the per-SI primary MAC registers, and the
driver keeps no copy of the address that was there before.

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

[Severity: Low]
At this commit neither enetc_ndev_ops nor enetc4_ndev_ops provides
.ndo_get_vf_config, so rtnl_fill_vfinfo() emits no VF info and the trust
bit set here cannot be read back with "ip link show".

This does get resolved inside the same series: the later commit "net:
enetc: add ndo_get_vf_config() support" adds enetc_pf_get_vf_config() with

	ivi->trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);

and registers it in both ops tables.  Would it be worth ordering the getter
before or together with the setter so that no intermediate commit has a
write-only trust attribute?

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
> +
> +	vf_state = &pf->vf_state[vf];
> +	mutex_lock(&vf_state->lock);
> +
> +	if (setting)
> +		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;

[Severity: Medium]
Can ENETC_VF_FLAG_TRUSTED survive an SR-IOV teardown and be inherited by a
different VF instance later?

pf->vf_state[] is devm_kcalloc()'ed once per PF in
enetc_init_sriov_resources(), and the disable path in
enetc_sriov_configure() does not touch it:

	if (!num_vfs) {
		pci_disable_sriov(pdev);
		enetc_msg_psi_free(pf);
		pf->num_vfs = 0;
	} else {

So for:

	echo 2 > sriov_numvfs
	ip link set eth0 vf 0 trust on
	echo 0 > sriov_numvfs
	echo 2 > sriov_numvfs

vf_state[0].flags still has ENETC_VF_FLAG_TRUSTED set, and the newly
created VF0 (possibly assigned to a different guest) passes the new gate in
enetc_msg_set_vf_primary_mac_addr() straight away and gets
enetc_set_si_hw_addr(pf, vf_id + 1, addr) executed for whatever address it
asks for.

Related: the bounds check here uses pf->total_vfs, the hardware maximum,
rather than pf->num_vfs, so trust can also be recorded for VF slots that do
not exist yet and takes effect as soon as they are created.  Was that
intentional?

Later in the series enetc_msg_clear_vf_config() clears only the UC/MC
promiscuous bits and carries a comment saying TRUSTED and PF_SET_MAC are
intentionally preserved, and it returns early for ENETC v1, so the
carry-over is still present at the end of the series.  Would clearing the
trust bit for all VFs on SR-IOV disable, as ixgbe and i40e effectively do
by reallocating their per-VF state, be preferable?

> +	else
> +		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
> +
> +	mutex_unlock(&vf_state->lock);

[Severity: Medium]
Does revoking trust leave the hardware MAC filter behind?

While trusted, the VF can install any valid unicast address, including the
PF's or another VSI's, through enetc_msg_set_vf_primary_mac_addr() ->
enetc_set_si_hw_addr(pf, vf_id + 1, addr).  This path only clears software
flag bits, so after "ip link set ... vf N trust off" the SI primary MAC
filter still holds the address the VF picked, and the now-untrusted VF keeps
receiving frames for it.

There is also no saved copy of the address programmed at probe, so the
original value cannot be restored.

At the end of the series the untrust branch clears UC/MC promiscuous mode
and the hash filters (and skips even that for ENETC v1), but still never
re-programs or clears the primary MAC.  ixgbe_ndo_set_vf_trust() and
i40e_ndo_set_vf_trust() force a VF reset on a trust change so the VF has to
re-negotiate its filters; would something equivalent be appropriate here?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
> +
>  MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
>  MODULE_LICENSE("Dual BSD/GPL");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
