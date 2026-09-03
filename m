Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17039A06A;
	Thu,  3 Sep 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479068; cv=none; b=JkbpCvyecSnb8xWV/I4LAUSGoeFYukGyBIqNFWd0yh1qjsQWItcHBH81T7vmQCYaT/p+BO5CuSklwdrkjcUUUSrQIasRrodoqBJ3m6xedbB0SXQ6oxFp24uy9OtwbztDYrp36vGUdUXRrymZhSXH/Na9MGbh9hC9FdwwxGDykco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479068; c=relaxed/simple;
	bh=b3QES1dxdhvsaJHI+DG0X+7kmEnKrcJqI7ZZy70eIuA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1ZClU0/tP99MMFJWiWyR5kuXX/WQc74nV7sD9Np3aKLqKB6oActWRJGGfQS7cjebsAU6EY4Spar/ssiDIUBSfkhknH39r3mMGZyQ0lQLpVKn5P83qK6faYX1+iBIGo1exMJewPDzM9Z33+vqikP6FvnoA12sZ6PnOncioY1o3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4uBLq2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4uBLq2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDB81F000E9;
	Thu,  3 Sep 2026 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479066;
	bh=XSkr0hrHbEHlV6Vg2L0/yLSzbe1+9ozrU1bexhAhRKI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X4uBLq2ksOAWOXAsZmj8PfuEldLJdpNT+Jh6QroZHjlAqTBEsO6bJ67SZXwSYyyT3
	 ycUBS/YjcpfODZpSkdSP2+fawFMU9hIIpO6hkMwdxc4rPaHiPc4yAlqI+iWfSsjS0m
	 mFzLHIjwtDxSQIt04ciMkPhZ7HDV/ABihYCpmiSx7CwbTmtxWVbKURDhs+kV6fW+hY
	 LDsgyF2wUioUrpMwesCIgr/1OsK4+nqw9tU5PZNGH8pKqnO2X+1lVD2obn7zsC7WKG
	 R/4YrVB7h9mLy3kSqwU66VYd1UXua19UDlT6/Khnx4Sy2vAEb7Eh4jgUcPJxwS0kru
	 eUhoch/rHuU6Q==
Subject: Re: [PATCH v3 net-next 04/15] net: enetc: add link speed message
 support to PF driver
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:24 +0000
Message-ID: <178847906490.4131868.13521334026222207494@kernel.org>
In-Reply-To: <20260831025441.635045-5-wei.fang@oss.nxp.com>
References: <20260831025441.635045-5-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 1

- [High] Global rtnl_lock() is acquired from inside the PF mailbox work
  item to answer a VF-originated request.
- [Medium] The new link-speed query is silently restricted to trusted
  VFs, which neither the commit message nor the in-tree ABI description…
- [Medium] enetc_msg_get_link_speed() answers
  ENETC_MSG_GET_CURRENT_LINK_SPEED (documented in enetc_mailbox.h as…
- [Low] The patch contains a stray hunk in enetc_sriov_configure()
  (drivers/net/ethernet/freescale/enetc/enetc_msg.c) that only inserts a…

--

net: enetc: add link speed message support to PF driver

This adds a new PSI-to-VSI mailbox class (0x81) so a VF can ask the PF for
the current link speed, encoding speeds up to 5Gbps as explicit enum values
and higher speeds via a formula.  The PF answers the query from
phylink_ethtool_ksettings_get() and only for VFs marked trusted.

A few questions below.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
> index 846998f07989..bd669543e96c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h

[ ... ]

> @@ -181,6 +212,11 @@ struct enetc_msg_mac_exact_filter {
>   * cmd_id 0x0: get the current link status
>   * cmd_id 0x1: register link status change notification
>   * cmd_id 0x2: unregister link status change notification
> + *
> + * Link speed message, class_id 0x81.
> + * cmd_id 0x0: get the current link speed.
> + * cmd_id 0x1: register link speed change notification, not supported yet
> + * cmd_id 0x2: unregister link speed change notification, not supported yet
>   */

[Severity: Medium]

This documents cmd_id 0x0 as returning the current link speed, but can the
reply describe a speed the port is not running at?

enetc_msg_get_link_speed() takes the value straight from
phylink_ethtool_ksettings_get() with no link-state gating.  For a fixed
link, phylink copies the configured speed/duplex unconditionally:

drivers/net/phy/phylink.c:phylink_ethtool_ksettings_get() {
	...
	case MLO_AN_FIXED:
		phylink_get_fixed_state(pl, &link_state);
		phylink_get_ksettings(&link_state, kset);
		break;
	...
}

So with the carrier down, or before the PF netdev has ever been opened,
enetc_build_link_speed_msg() still encodes a valid speed class code rather
than ENETC_MSG_SPEED_UNKNOWN.  The MLO_AN_INBAND case reads the PCS live,
which also need not match what the MAC was last programmed with.

Would it be more consistent to derive the answer from the state the PF
already tracks, the way the sibling link-status message does?

drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_get_link_status() {
	...
	pf_msg = enetc_build_link_status_msg(priv, pf->link_up);
	...
}

priv->speed is written next to PCR_PSPEED in enetc4_set_port_speed()
(including the 10Mbps fallback on SPEED_UNKNOWN), so the programmed rate is
already recorded.  As written, a VF can be told 1G/2.5G while the same PF
reports the link as down over class 0x80.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index e21414acdc0d..c3ae4c024f34 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -280,6 +280,93 @@ static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
>  	return 0;
>  }
>  
> +static u16 enetc_build_link_speed_msg(int speed, int duplex)
> +{
> +	u32 speed_code = ENETC_MSG_SPEED_UNKNOWN;
> +
> +	switch (speed) {

[ ... ]

> +	return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> +			  ENETC_MSG_CLASS_ID_LINK_SPEED) |
> +	       FIELD_PREP(ENETC_PF_MSG_CLASS_CODE_U8, speed_code);
> +}
> +
> +static u16 enetc_msg_get_link_speed(struct enetc_pf *pf, int vf_id)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
> +	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
> +	struct ethtool_link_ksettings link_info = {};
> +
> +	/* A malicious or malfunctioning VM could potentially spam these
> +	 * messages in a tight loop causing global rtnl_lock contention,
> +	 * which may severely starve other processes on the host that
> +	 * require rtnl_lock for routine network configuration, resulting
> +	 * in a system-wide control-plane denial of service. Therefore,
> +	 * we expect the VF query for link speed to be trusted. There's no
> +	 * need to consider the transition from trusted to untrusted here,
> +	 * as this won't cause rtnl_lock() to be called frequently.
> +	 */
> +	mutex_lock(&vf_state->lock);
> +	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
> +		mutex_unlock(&vf_state->lock);
> +
> +		return ENETC_PF_MSG_PERM_DENY;
> +	}
> +	mutex_unlock(&vf_state->lock);

[Severity: Medium]

Should the trusted-VF requirement be described in the changelog and in the
mailbox ABI comment in enetc_mailbox.h?

ENETC_VF_FLAG_TRUSTED is only ever set from enetc_pf_set_vf_trust()
(ndo_set_vf_trust, i.e. "ip link set <pf> vf N trust on"), and pf->vf_state
is allocated with devm_kcalloc() in enetc_init_sriov_resources(), so flags
is zero by default.  A default setup therefore gets
ENETC_PF_MSG_PERM_DENY / -EACCES back from enetc_msg_vsi_send().

The commit message says without qualification:

  "The PF will reply the current link speed when it receives the get link
   speed message from VF."

  "VFs controlled by DPDK can obtain real-time link speed information from
   the PF"

The ABI comment added to struct enetc_msg_generic also describes class 0x81
cmd 0x0 with the same wording as the 0x80 status query, and
enetc_msg_get_link_status() answers any VF with no trust check.  Two paired
link-info queries with different permission models is surprising for a
DPDK VF implementer reading only the header.

> +
> +	rtnl_lock();
> +	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
> +	rtnl_unlock();

[Severity: High]

Can blocking on rtnl here stall mailbox service for the other VFs?

This runs from the single work item that services every VF with the PSIIER
MR interrupts masked:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_task() {
	...
	for (i = 0; i < pf->num_vfs; i++) {
		...
		enetc_msg_handle_rxmsg(pf, i, &msg_code);
		...
	}
out:
	enetc_enable_psiier_interrupts(pf);
}

rtnl hold times elsewhere (ndo_open with PCS/PHY negotiation, netdev
unregistration, another driver probing, netlink dumps) are unbounded, while
the VF side has a hard 200ms budget:

drivers/net/ethernet/freescale/enetc/enetc_vf.c:enetc_msg_vsi_send() {
	...
	err = read_poll_timeout(enetc_rd, vsimsgsr,
				!(vsimsgsr & ENETC_VSIMSGSR_MB),
				1000, 200000, false, &si->hw, ENETC_VSIMSGSR);
	if (err) {
		dev_err(dev, "VSI mailbox timeout\n");
	...
}

So one iteration waiting on rtnl can push unrelated requests from other VFs
past that timeout, with a hardware mailbox transaction left outstanding.
For a host-assigned VF, enetc_msg_vsi_set_primary_mac_addr() is issued from
ndo_set_mac_address with rtnl already held, i.e. the VF waits for a PF reply
that needs the very lock the VF holds.

There is a second effect on teardown: enetc_msg_psi_free() does
cancel_work_sync(&si->msg_task), and it is called from
enetc_sriov_configure() (pci_driver::sriov_configure, invoked from
sriov_numvfs_store() under the PCI device_lock) and from
enetc_pf_remove()/enetc4_pf_remove().  Does SR-IOV disable/removal now wait
for rtnl while holding device_lock, for a time a busy VF can extend?

Every other handler in this file avoids rtnl.  enetc_msg_get_link_status()
answers from the cached pf->link_up under pf->msg_lock, and speed/duplex are
already handed to enetc4_pl_mac_link_up() where they could be cached the
same way.  Would caching the speed there and replying from the cache work
instead?

[ ... ]

> @@ -546,6 +636,7 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
>  			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
>  			goto err_en_sriov;
>  		}
> +
>  	}

[Severity: Low]

This isn't a bug, but this hunk only adds a blank line before a close brace
in enetc_sriov_configure(), which is unrelated to link speed messages and
trips checkpatch ("Blank lines aren't necessary before a close brace").  It
is still present at the end of the series, so nothing later removes it.
Could it be dropped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
