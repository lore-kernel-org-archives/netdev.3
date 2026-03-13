Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922ED33A039;
	Fri, 13 Mar 2026 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368286; cv=none; b=oK1mpnQF36QBdRTHdrPwO8iYKc57O/qRWiU/B7VbgwNEOJLp1148Q3qUoPfTm1TVClQiCm1pYvGMxitPnJFM4WDsV1i3b7lByqAN0W5HQ3krvXhnFldsf+1s+TR5qHY9+bkyDsSB9WQhYfrdFXaSTn6GkWzYXKmdTgPl5Wr+w9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368286; c=relaxed/simple;
	bh=pMX8ns367KAe/DECqpzeywg4bF/jQ8/m+yCCjoFZ/8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqhjd0tMJbcw4ndhWCimH7BZSdx2h7v34ljI32IIEVMtpQ2YCuXNyAErGkMta+EeQGInxa4ESJhgxvwrFkupNB1ukXzODqyYK1lZR0+CGSZNLAOBGwY/1hneRSTcO5+vHc39h96rYtiM5OH5v2QN2mxakHzEe9J9KCfKjXwSpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9YU44i9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9YU44i9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6B0C2BC87;
	Fri, 13 Mar 2026 02:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773368286;
	bh=pMX8ns367KAe/DECqpzeywg4bF/jQ8/m+yCCjoFZ/8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9YU44i9P00C4NUIQRwwuG4r0caWI1FFtQiKwTGuWGEgp7/TUnak68X3lPRjKm/MT
	 YwyytH5CZfrzmpZ9ZQ5Jm7VxaBO55V5rZzzHtxtTSYsLWZjlrIKeMb3YsMacrpwnjf
	 MvrenhHCuRGo2KTXm++YOXbhkE7jLaIb4/2WuFzWoQW+AljJLsXL6D4TZ9sBbbNzmi
	 5Bz1ByH5Sx8EKa3joxIRE3A9dRAw79rU1u7D5Ok05+3X0PzGjxxrnaFFTX5sLp4LoZ
	 nfZICtZrmJntUEV+JvLRQdVTeUP0s7Zlz8QTSNUaCoLU2CK7vXVua42JNHNJqddt2U
	 TPZ+P2HbeLh9w==
From: Jakub Kicinski <kuba@kernel.org>
To: bhargava.marreddy@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	ajit.khaparde@broadcom.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	rajashekar.hudumula@broadcom.com,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	rahul-rg.gupta@broadcom.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	vikas.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: Re: [net-next,v6,02/10] bng_en: query PHY capabilities and report link status
Date: Thu, 12 Mar 2026 19:18:00 -0700
Message-ID: <20260313021800.1546107-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310144044.21672-3-bhargava.marreddy@broadcom.com>
References: <20260310144044.21672-3-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: query PHY capabilities and report link status

This commit queries PHY capabilities and supported speeds from firmware,
retrieves current link state (speed, duplex, pause, FEC), logs the
information, and seeds initial link state during probe.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> new file mode 100644
> index 000000000000..0c76cbc794f7
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c

[ ... ]

> +void bnge_init_ethtool_link_settings(struct bnge_net *bn)
> +{
> +	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
> +	struct bnge_link_info *link_info;
> +	struct bnge_dev *bd = bn->bd;
> +
> +	link_info = &bd->link_info;
> +
> +	if (BNGE_AUTO_MODE(link_info->auto_mode)) {
> +		elink_info->autoneg = BNGE_AUTONEG_SPEED;
> +		if (link_info->auto_pause_setting &
> +		    PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE)
> +			elink_info->autoneg |= BNGE_AUTONEG_FLOW_CTRL;
> +		bnge_set_auto_speed(bn);
> +	} else {
> +		bnge_set_force_speed(bn);
> +		elink_info->req_duplex = link_info->duplex_setting;
> +	}

Does the forced-speed (else) branch need to clear elink_info->autoneg?

When called only at probe time on a zero-initialized struct, leaving
autoneg uninitialized is harmless. However, commit f833dbb3f7ab
('bng_en: add support for link async events') in this same series adds
a re-init call path from bnge_sp_task() in response to
BNGE_LINK_CFG_CHANGE_SP_EVENT async firmware events.

If the PHY transitions from auto-negotiation to forced-speed mode (e.g.,
via BMC/management configuration change), the stale BNGE_AUTONEG_SPEED
and BNGE_AUTONEG_FLOW_CTRL bits in elink_info->autoneg persist. This
causes:

bnge_hwrm_set_link_common() to send auto-negotiation configuration to
firmware instead of forced-speed:

    if (elink_info->autoneg & BNGE_AUTONEG_SPEED) {
        req->auto_mode |= PORT_PHY_CFG_REQ_AUTO_MODE_SPEED_MASK;
        ...

bnge_hwrm_set_pause_common() to configure auto-negotiation pause
instead of forced pause:

    if (bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL) {
        req->auto_pause = PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE;
        ...

bnge_update_phy_setting() to make incorrect speed-change decisions:

    if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED)) {
        if (BNGE_AUTO_MODE(link_info->auto_mode))
            update_link = true;

The bnxt reference driver (bnxt_init_ethtool_link_settings) has the same
pattern, but this doesn't excuse introducing it in a new driver.

No fix was found later in the series (checked through 2d7643a78ddb).

> +	if (elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
> +		elink_info->req_flow_ctrl =
> +			link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH;
> +	else
> +		elink_info->req_flow_ctrl = link_info->force_pause_setting;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index edbb42efb70b..db3a19bbf75a 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2532,6 +2562,14 @@ static int bnge_open_core(struct bnge_net *bn)
>
> 	bnge_enable_napi(bn);
>
> +	rc = bnge_update_phy_setting(bn);
> +	if (rc) {
> +		netdev_warn(bn->netdev, "failed to update PHY settings (rc: %d)\n",
> +			    rc);
> +		bd->link_info.phy_retry = true;
> +		bd->link_info.phy_retry_expires = jiffies + 5 * HZ;
> +	}
> +

Does stale phy_retry state from a previous open/close cycle cause spurious
warnings?

When bnge_update_phy_setting() fails during bnge_open_core(),
bd->link_info.phy_retry is set to true and phy_retry_expires is set to
jiffies + 5*HZ. Neither bnge_close_core() nor bnge_close() clears
phy_retry.

If the interface is closed and then reopened with a successful
bnge_update_phy_setting() call (rc=0), the stale phy_retry remains true
with an expired phy_retry_expires. On the next timer tick, bnge_timer()
sees:

    if (bd->link_info.phy_retry) {
        if (time_after(jiffies, bd->link_info.phy_retry_expires)) {
            bd->link_info.phy_retry = false;
            netdev_warn(bn->netdev, "failed to update PHY settings after maximum retries.\n");

and logs a spurious warning even though the PHY update succeeded on reopen.

No later fix was found in the series (searched git range
f342d5af0695..2d7643a78ddb).

> 	set_bit(BNGE_STATE_OPEN, &bd->state);
>
> 	bnge_enable_int(bn);

[ ... ]
-- 
pw-bot: cr
