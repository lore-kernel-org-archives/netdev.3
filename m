Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857E471423;
	Thu, 10 Sep 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039261; cv=none; b=OD2Lk+05PtrP1CngDjNikXb1dPQJ4486d53ZCP6f0DMkFLPdKPKaOPiVbQ5DjypmJOeM6wCgi3cFE+EeeD8zeCcf48+K6redwGWEwqQ0nTLnmg423/zhLHc29dP4SoiFf3p4uDJFYjPket1wzrqmm/c0singTBe+EsZQRulh4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039261; c=relaxed/simple;
	bh=0jXxV16bUabUcgn3GUJoNnCauJFQ07Mhult1S7bhT08=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+MhUUYiT/48pb8FIT6o3d1xp4Mn5wjnLiX4/fJDyZPu7aKvuY2leetSw5bV5u6DWspTIMksW2A1+2KN5mRmZq0cuRlqHM0FwV+84Vl3xa1umat0LcK3u1m0gSxD2ITGjlcWj/Q9LgSoZk5bo8XD+ADATA53x5My3UMvADXdrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8aiFm3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8aiFm3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505FD1F00893;
	Thu, 10 Sep 2026 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039260;
	bh=mf8Hg/bYAJZ1z1asUw1OzijhUTTr2LkD+3g7Rrzmquo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B8aiFm3VVpzr6ICRxY+R6sLXC6KgOTt+w3VS8hhqBj1ulOAhLS+ab0omgSJ34k/9Z
	 /I00TSovNwIA7Ov5Po0dxKId5N4sNHvzDt+5HMRVKKCFk2ZBmE8iuqyEg9bf6Ausyq
	 FzjzAsSmVsFv+izb9MhueDhLwXtH2dbCLNkB+ejCDIkOJzSknu8tIPoCkeC6FfDtJv
	 fesSH3BirOPvKGCl68r94VTY0fOLK7CzQP6ShvM478oWLNgCh0I+wxYjP75MaKONdd
	 SdHtf7oLeJ0JYHTIlza+8sIRb7SQGiTAVyEnb5g+AsXsIARntg8yBfvPP/skIsn07+
	 jzLHFOi8rM+Zg==
Subject: Re: [PATCH v4 net-next 04/15] net: enetc: add link speed message
 support to PF driver
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 11:20:58 +0000
Message-ID: <178903925887.219967.16074856500035860561@kernel.org>
In-Reply-To: <20260909100733.1139689-5-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-5-wei.fang@oss.nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] enetc_msg_get_link_speed()
  (drivers/net/ethernet/freescale/enetc/enetc_msg.c:274) introduces an…

--

Verified the relevant code paths. Report below.

net: enetc: add link speed message support to PF driver

Adds a new mailbox message class 0x81 so a VF can query the current link
speed from the PF.  The PF reads the speed with
phylink_ethtool_ksettings_get() under rtnl_lock() and encodes it into the
8-bit class code of the reply, restricting the query to trusted VFs.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index 79dbaf72fcff..08a9ffdd3eb0 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -230,6 +230,93 @@ static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
>  	return 0;
>  }
>  

[ ... ]

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
> +
> +	rtnl_lock();
> +	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
> +	rtnl_unlock();

[Severity: Medium]
Is it safe to block on rtnl_lock() inside the PSI mailbox service work
item?  This looks like the first sleeping, host-global lock acquisition on
that path: enetc_msg_handle_link_status() only uses si->gen_lock and never
sleeps.

The completion code is only written back to the VF after the class handler
returns, in enetc_msg_task():

	for (i = 0; i < pf->num_vfs; i++) {
		...
		enetc_msg_handle_rxmsg(pf, i, &msg_code);
		...
		enetc_pf_reply_msg(hw, i, msg_code);
	}

out:
	enetc_msg_enable_mr_int(pf);

while the VF side waits with a fixed 200 ms bound in enetc_msg_vsi_send():

	err = read_poll_timeout(enetc_rd, vsimsgsr,
				!(vsimsgsr & ENETC_VSIMSGSR_MB),
				1000, 200000, false, &si->hw, ENETC_VSIMSGSR);
	if (err) {
		dev_err(dev, "VSI mailbox timeout\n");

		return err;
	}

If any unrelated host rtnl holder (for example 'ip link del' going through
synchronize_net(), an ndo_open of another device, bonding/team
reconfiguration or a module load) keeps rtnl for longer than ~200 ms, does
the reply not arrive after the VF has already given up?  In that case the
VF logs "VSI mailbox timeout" and returns -ETIMEDOUT, and because
VSIMSGSR[MB] stays set until the PF finally replies, subsequent VF sends
hit the earlier check and fail with -EIO ("VSI mailbox is busy").

There is a second effect from the same wait.  enetc_msg_task() services all
VFs serially in one loop and only re-arms the PSIIER MR interrupt sources at
enetc_msg_enable_mr_int(pf) on exit, so while one VF's speed query sleeps on
rtnl, do the pending messages of the other VFs (set primary MAC, MAC hash
filter, promisc mode) not get delayed and potentially time out too?

Would a non-blocking source for the speed work here, or alternatively the
deferred-reply mechanism (ENETC_MSG_CLASS_ID_CMD_DEFERRED) so the mailbox
handshake is not held open across rtnl?

[Severity: Medium]
On the trust gate itself: the comment above the mutex_lock(&vf_state->lock)
check describes the tight-loop spam scenario, but the check only narrows
which VFs can reach rtnl_lock(), it does not bound the rate.  Nothing
throttles inbound class 0x81 messages - the MR interrupt sources are simply
re-armed at the end of enetc_msg_task(), and the only per-VF counter
(msg_fail_cnt) tracks PF-to-VF send failures rather than inbound queries.

Can a trusted VF still drive repeated rtnl acquire/release from the PF work
item at mailbox round-trip rate, i.e. is the primitive the comment warns
about still reachable from guest-controlled code once an admin sets 'trust
on'?

For reference, a couple of related concerns were checked and do not appear
to be problems: vf_state->lock is dropped before rtnl_lock() so there is no
ordering issue against ndo_set_vf_trust, and enetc_msg_psi_free() (and its
cancel_work_sync()) is only reached from enetc_sriov_configure(), which does
not hold rtnl.

> +
> +	return enetc_build_link_speed_msg(link_info.base.speed,
> +					  link_info.base.duplex);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909100733.1139689-1-wei.fang%40oss.nxp.com
