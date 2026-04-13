Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B23B774B;
	Mon, 13 Apr 2026 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092392; cv=none; b=D0c8yZL3CssYhH0cmvTSK3zNT4x32qFztswh4UT/Ltjj6CMQOlK0uuRU8GuoB0bg2FgnRoldX4T3Z1n/GsYn3oUEV4YV9XQWkri//d/kdlM4Lp3JpJgkOUHZNJ+OV6BgMLwKO4/Zpcght19YIGKeW9gh6ZCnKGlWDJwe4g1thcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092392; c=relaxed/simple;
	bh=ToPQhf+AU4et7lLAuA4KTwzfff0wXqHPucAzwkwJ6sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq5OBJh0dDDo5JYAlbhlIM8cWIAxzqsY6CTwogLshz52aUZjmZM/wbPT+XUVF2aEjrAbtfDStIWynb4BCb5ttrgFst+qttuXIr3hGxf1/V98ldfVgnv43Zsbjx0PPuWUxV89wyoN1309FUY6H8U33UIyjsyglqCodfysF1/KGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtW2TBS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtW2TBS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAB6C2BCAF;
	Mon, 13 Apr 2026 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092391;
	bh=ToPQhf+AU4et7lLAuA4KTwzfff0wXqHPucAzwkwJ6sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtW2TBS94vcUa9a4Ed7PcWrPV/FRaksQw2+2uT/VDXjTU7nqgp+KFWLTPRee+0gc5
	 yvB4DOLk5RSddrYhq5YKFaGo4kGO4evnX4vGCfhrv6oe1ANV9EgFE6AQWFbm3ltNqT
	 DabilfO/qj7VbMqv+W8TUF5tErjALJQHK4YRAuOvnhA84nSKkuo/fcBVMSI1srjBz1
	 aGIV2+tIoq0GbZHnAALd64Wvj5n+Vat6IsDlxWFiYEmr2INVAkwbTYvN+PtBOLP2Gu
	 f3nC/Ipd3gjo2civxcJrK0lYbr/IZLJJc4ipzTpiEJnbLf2IMo6q/ppcI27eKjL6aD
	 keL1vs1jXFWOw==
From: Simon Horman <horms@kernel.org>
To: khai.wen.tan@linux.intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com,
	hector.blanco.alcaine@intel.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	faizal.abdul.rahim@linux.intel.com
Subject: Re: [PATCH iwl-next 1/1] igc: add support for forcing link speed without autonegotiation
Date: Mon, 13 Apr 2026 15:52:15 +0100
Message-ID: <20260413145215.718532-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409072747.217836-1-khai.wen.tan@linux.intel.com>
References: <20260409072747.217836-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
igc: add support for forcing link speed without autonegotiation

This commit allows forcing 10/100 Mb/s link speed and duplex settings via
ethtool when autonegotiation is disabled. It configures the MAC CTRL and
PHY registers to bypass autonegotiation and apply the requested settings.

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 0122009bedd03..e14771532dad8 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
[ ... ]
> +static int igc_handle_autoneg_disabled(struct net_device *netdev, u32 speed,
> +				       u8 duplex)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct igc_mac_info *mac = &adapter->hw.mac;
> +	enum igc_forced_speed_duplex forced_speed_duplex;
>  
> +	switch (speed) {
> +	case SPEED_10:
> +		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_10F : IGC_FORCED_10H;
> +		break;
> +	case SPEED_100:
> +		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_100F : IGC_FORCED_100H;
> +		break;

Does forcing a half-duplex configuration here also require setting flow
control to none (e.g., hw->fc.requested_mode = igc_fc_none)?

> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
> index 7ac6637f8db73..16b0f2db06896 100644
> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
> @@ -452,7 +452,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>  	 * so we had to force link.  In this case, we need to force the
>  	 * configuration of the MAC to match the "fc" parameter.
>  	 */
> -	if (mac->autoneg_failed)
> +	if (mac->autoneg_failed || !mac->autoneg_enabled)
>  		ret_val = igc_force_mac_fc(hw);

If mac->autoneg_enabled is false, igc_force_mac_fc() will configure the MAC
using the existing hw->fc.current_mode. If current_mode defaults to full flow
control, this will enable PAUSE frames.

Since autonegotiation is disabled, the MII status check further down in this
same function will fail and return early:

drivers/net/ethernet/intel/igc/igc_mac.c:igc_config_fc_after_link_up() {
    ...
    if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
        hw_dbg("Copper PHY and Auto Neg has not completed.\n");
        goto out;
    }
    ...
}

This early return skips the half-duplex safety check at the end of
igc_config_fc_after_link_up() which would normally clear the flow control
settings:

drivers/net/ethernet/intel/igc/igc_mac.c:igc_config_fc_after_link_up() {
    ...
    if (duplex == HALF_DUPLEX)
        hw->fc.current_mode = igc_fc_none;

    ret_val = igc_force_mac_fc(hw);
    ...
}

Does this leave the MAC incorrectly configured to send and receive PAUSE
frames on a half-duplex link, violating the IEEE 802.3 specification?
