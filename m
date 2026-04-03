Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FF3264C1
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223577; cv=none; b=PAtex3CdbiUfmCDCNia86kcwulEJFlamdQd50pIhWIqT5he7EYWL5Fw2X64f6cAPIYA0xoVXfoC3C/Ib8XePrTNXEB0MvRAEs45zFBWM4QETf4T7iN/1l25czNv5C5dUFA8bOK0PBaCsN2rYWiCN90xpcEKeRIcWb9Be3n8t9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223577; c=relaxed/simple;
	bh=gzgo4J0pUZ2NR/fbaMfQmlWY0aPaw+y93UYrHkmJXi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFUtMaXpuEltJmeKSIwe/tL7BmQJtja3VC1eQ+fDWit+9P6IwrGevqXehURX8eU9h150MR8OMd4WBPWBkUVFCr6j9RyCUhTZGo5rTLWeomDdaeDZ1PaN9IchSQYoEB6b88PKhbl8bF6CSUKRBTuH5vp9jdj4xnlxBSat4q0JV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWEg59c2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWEg59c2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA1EC19421;
	Fri,  3 Apr 2026 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223576;
	bh=gzgo4J0pUZ2NR/fbaMfQmlWY0aPaw+y93UYrHkmJXi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWEg59c2mZ0IOrx/OS73hj1Cgai8N7XixauJHLw7J0797WcGJn/9VOjVAL95G6Ocs
	 Sz8SCS0fZ+T5oDq1nqGHnD03PSvoUAzQB1Xnyr6iLAOO3OsfC73dp4kfI7Wq2diKON
	 3pGE7S34DW8GoDlRHHvYWfRdIPLM80OLICNK+frKoYm/KqROHBFFTsPavF30tC8x+n
	 Dv1TXeyQoZ4XW5rBPreO1h/3cwjLjp0OgzRJvNFSlLTbsiaw7yCFkoadsTBpRokFsa
	 XVFZpz1jNTVdC8rNgM36dFhlAda/UvU65lwS3G9NPYokXOYgeRAniWGsmLsCZAhoCl
	 +Ed6C0wzs/Yog==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
Date: Fri,  3 Apr 2026 14:39:30 +0100
Message-ID: <20260403133930.129514-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327073046.134085-6-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-6-aleksandr.loktionov@intel.com>
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
ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update

During an NVM update the PHY reset clears the Technology Ability Field
(IEEE 802.3 clause 37 register 7.10) back to hardware defaults. When
the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
register is recalculated from the stale autonegotiated capability bits,
which the MDD (Malicious Driver Detect) logic treats as an invalid
change and halts traffic on the PF.

Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
ixgbe_watchdog_update_link() so that flow-control autoneg and the
PHY registers are re-programmed in the correct order after any reset.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 0bc806aaed90..96e912371d9a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8029,6 +8029,12 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
>  	pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
>
>  	if (link_up && !((adapter->flags & IXGBE_FLAG_DCB_ENABLED) && pfc_en)) {
> +		if (hw->mac.ops.setup_fc) {
> +			int err = hw->mac.ops.setup_fc(hw);
> +
> +			if (err)
> +				e_warn(drv, "setup_fc failed: %d\n", err);
> +		}

What happens if setup_fc() fails here? The patch adds this call to fix
MDD issues caused by stale PHY autoneg state after NVM updates.

However, if setup_fc() returns an error, the code only logs a warning
and continues:

	if (hw->mac.ops.setup_fc) {
		int err = hw->mac.ops.setup_fc(hw);

		if (err)
			e_warn(drv, "setup_fc failed: %d\n", err);
	}
	hw->mac.ops.fc_enable(hw);

Since fc_enable() relies on hw->fc.current_mode being properly set by
the autoneg process initiated by setup_fc(), calling it after a
setup_fc failure means it operates on the same stale state the patch
was meant to fix.

Could this leave a residual bug where MDD can still trigger and halt
traffic if setup_fc fails?

>  		hw->mac.ops.fc_enable(hw);
>  		ixgbe_set_rx_drop_en(adapter);
>  	}
