Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A33AFB1B;
	Thu,  3 Sep 2026 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479072; cv=none; b=VdqZaTNKjro4l9cR6EnK+s2cWtoGB9qLEX+y8CimZAJrRLOx35ITjPwcAQCmztI6tnk8qwR5fxOyNh1FmNiQxx44KWIZ4zNBHnbuxCX/SH6PaoCQqXZZR8Cl9sDA/+ZZAnYreITzSkOXGQAqngfDdQRJ+U/ICtooAkqBOrcI/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479072; c=relaxed/simple;
	bh=CXj7P21sTrfBoXNDFK/1cCqos45y+8tAxY95lOJQmUo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QoSymQ5oMAs1yHKVgzUj3wvAKyr6d2xnKliDymGZ5nfNWQ4Z14jfOa3ZWgpGemFtZDwDkDCWe91KMKeYZ2W7o/FWf5VqbryG8FFbt6czbRaMNIzlnmInstF2XN2P1hNCm5hnREVE8lu/LavrIK4tEL5dTf+t7IGByrVFvj8DGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og1u6gk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og1u6gk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECC31F00A3F;
	Thu,  3 Sep 2026 23:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479070;
	bh=kgcpFMXP7uCTpDvsHREPxMdK6e5qud0FLWYDKY3C2XE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Og1u6gk2xUTfFfj5iAgo3HwhRxEOPzFd5Z/f2I9TQOmtfmRn6y2hRLrwIxxKaFMTh
	 F1FjQ5BXKy+qKDRaUKdusiMDmeBPcWp20qCxXaQ7pyQRfY25c5/7ZMFRSSrymWkMMr
	 9OWnl/hQz9KiEaqFhe/4ueRrBDDzxhHgRnervHO33GcQIRxaeOyv5EDnAX67GeNVMe
	 PkNi4C0UEipr+gmVW+pq7Kopl7TfMdiTokXDStIjMEkjo8y7vlY7QzjyaHQ+nji/5U
	 pI3RFt3LYOtfc8gTKoaHI+O8nL0caQC460K3IMlbMxna1wt7N/MGoBqTc22YcF+BLx
	 T2cIz/n8vsKJw==
Subject: Re: [PATCH v3 net-next 12/15] net: enetc: add VF support for i.MX94
 and i.MX95
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:29 +0000
Message-ID: <178847906907.4131868.16287350987605757758@kernel.org>
In-Reply-To: <20260831025441.635045-13-wei.fang@oss.nxp.com>
References: <20260831025441.635045-13-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] An untrusted VF can repeatedly force the PF mailbox worker to
  wait up to 200 ms while holding pf->msg_lock.
- [Medium] Commit message claims driver-side recognition of per-instance
  VF capabilities that the patch does not implement, and is internally…
- [Medium] Blocking mailbox wait under rtnl_lock vs. a PF mailbox worker
  that itself takes rtnl_lock.

--

net: enetc: add VF support for i.MX94 and i.MX95

This adds the ENETC v4 VF PCI device ID 0xef00 to the VF driver, adds VF
driver data and enetc4 SI ops for revisions 4.1 and 4.3, and hooks
.sriov_configure into the enetc4 PF driver so VFs can be created on i.MX94
and i.MX95.  It also restricts the rxnfc ethtool callbacks to revision 1.

There are no Link: tags in the commit header.

A few questions below.

[Severity: Medium]
The commit message says:

> On i.MX95 (v4.1), each ENETC instance supports 2 VFs.
>
> The i.MX94 (v4.3) has two types of ENETC with different VF capabilities:
>  - standalone ENETC (same as i.MX95): does not support VFs

Are these two statements consistent?  The first says each i.MX95 instance
supports 2 VFs, the second says the i.MX94 standalone ENETC is the same as
i.MX95 and supports no VFs.

The message then says:

> The driver is updated to recognize these SoC-specific VF capabilities
> and handle each ENETC instance accordingly.

Where does that recognition happen?  The only PF-side change here is the
unconditional .sriov_configure in enetc4_pf_driver, which applies to every
entry of enetc4_pf_id_table (both the standalone PF 0xe101 and the PPM
0xe110), plus the VF teardown in enetc4_pf_remove().  There is no new field
in struct enetc_drvdata and no revision or device-ID test bounding the VF
count; enetc_init_sriov_resources() in enetc_pf_common.c still derives it
purely from the PCI capability:

	pf->total_vfs = pci_sriov_get_totalvfs(pf->si->pdev);

and that function is not touched by this patch.  So if the i.MX94
standalone instance advertises a non-zero TotalVFs, a write to
sysfs sriov_numvfs would still be accepted on the instance the message
declares unsupported.  Is the gating code missing from the patch, or should
the message be reworded?

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index c421c0e7355b..a945a120c553 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

[ ... ]

> @@ -1138,6 +1141,7 @@ static struct pci_driver enetc4_pf_driver = {
>  	.id_table = enetc4_pf_id_table,
>  	.probe = enetc4_pf_probe,
>  	.remove = enetc4_pf_remove,
> +	.sriov_configure = enetc_sriov_configure,
>  };
>  module_pci_driver(enetc4_pf_driver);

[Severity: Medium]
Enabling .sriov_configure here, together with the new 0xef00 VF ID, makes
the PSI/VSI mailbox path live on ENETC v4 for the first time.  Can the PF
mailbox worker and a VF mailbox sender deadlock against each other on
rtnl_lock until the poll times out?

The PF worker path takes rtnl_lock while serving a VF request:

enetc_msg_task() -> enetc_msg_handle_rxmsg() -> enetc_msg_handle_link_speed()
  -> enetc_msg_get_link_speed() {
	rtnl_lock();
	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
	rtnl_unlock();
  }

The VF side runs from ndo_set_mac_address, so rtnl is already held, and it
then waits up to 200 ms for the PF to answer:

enetc_vf_set_mac_addr() -> enetc_msg_vsi_set_primary_mac_addr()
  -> enetc_msg_vsi_send() {
	err = read_poll_timeout(enetc_rd, vsimsgsr,
				!(vsimsgsr & ENETC_VSIMSGSR_MB),
				1000, 200000, false, &si->hw, ENETC_VSIMSGSR);
  }

If the single worker is servicing a trusted VF's link-speed request while a
kernel-bound VF issues its own request, the worker blocks in rtnl_lock()
held by that VF's sender, so the VF's message cannot be consumed.  The VF
operation then fails with "VSI mailbox timeout" after holding rtnl for
200 ms, and the still-unconsumed message makes the following VF sends fail
with "VSI mailbox is busy" (-EIO) until the worker drains it.

The trigger needs a mixed configuration: one trusted VF issuing link-speed
queries (for example a vfio/DPDK-owned VF, since untrusted requests return
PERM_DENY before rtnl_lock) plus a second kernel-bound ENETC v4 VF on the
same host.  The later patch adding ndo_set_rx_mode_async for the ENETC v4
VF introduces a second rtnl-held 200 ms mailbox waiter on the same path.

[Severity: High]
With SR-IOV now available on ENETC v4, can an untrusted VF repeatedly stall
the PF mailbox worker for 200 ms at a time while pf->msg_lock is held?

enetc_msg_handle_link_status() dispatches
ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER to
enetc_msg_register_link_status_notifier() with no ENETC_VF_FLAG_TRUSTED
check, unlike enetc_msg_get_link_speed() which does test the flag.  That
function holds pf->msg_lock across the send:

enetc_msg_register_link_status_notifier() {
	mutex_lock(&pf->msg_lock);
	...
	enetc_msg_notify_vf_link_status(pf, PSIMSGSR_MS(vf_id));
msg_unlock:
	mutex_unlock(&pf->msg_lock);
}

and the send waits for the VF to consume the notification:

enetc_pf_send_msg() {
	...
	return read_poll_timeout(enetc_rd, val, !(val & ms_mask), 1000,
				 200000, false, hw, ENETC_PSIMSGSR);
}

A guest can loop: acknowledge the previous notification so its MS bit is
clear (otherwise the next enetc_pf_send_msg() short-circuits with -EIO),
re-register, and then never read the new notification.  Each iteration
occupies the single VF mailbox work item enetc_msg_task() for 200 ms with
PSIIER interrupts disabled and pf->msg_lock held.

Does that starve the other VFs?  Their enetc_msg_vsi_send() has the same
200 ms timeout, so their ndo_set_mac_address and rx-mode requests would
fail, and the PF link path enetc4_pl_mac_link_up()/enetc4_pl_mac_link_down()
-> enetc_pf_notify_vf_link_up()/_down() -> mutex_lock(&pf->msg_lock) would
stall for up to 200 ms per transition.  Would a trust check on the
registration path, or a non-blocking notification, be preferable here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
