Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832063AC0F3
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222757; cv=none; b=qibkaH/eQQ7QbcC6sO0IbJl91Qn/ofyaaejsN9tbdsuPvy7oU3pxrFk6GjMmSXet0gqkuNXS0fEPUD6XCGbm1WrVnrOO9eWdhY/olC9xZNFPOwA6uik2vPeAHcA3ZExZNyUFc6OavMo0UNiNpLB/Adqz1yJsahha9s5BVgpTZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222757; c=relaxed/simple;
	bh=kUre8Wc1l+1ATIdAhMBNpQbWAMPotyhvO7C0v3jVOb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnHMoNDCyVjZmLr1Bkr3embBSkV2u/7sU7Stmv8BjwbWVYmKHYH7lyDIE7P6kiPoGKyc78nE9yoOXpWkcmsFeKqOPnJST+gy6sqF3ADLRYW97AdGkbx/6syEyJkCurIeDVZUWp7w4G6JQEImPPgbPLqGDoW3D6+27qpSYbvkk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1EoL7Sf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1EoL7Sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134BEC4CEF7;
	Fri,  3 Apr 2026 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775222757;
	bh=kUre8Wc1l+1ATIdAhMBNpQbWAMPotyhvO7C0v3jVOb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1EoL7SfAU1ZPP2RD62xUBpL1a9rB3bsJo5L88KvpMVTKRJ7Kn82zQBKJMiNcea2Q
	 DaNLMn9OpYnDi77XO7w7ayFglNgttAsLZBLATnyq5+J1zE2Bxg8xHP6BUCjZHtrAkH
	 ZpXTWVQ7EP4/QrM520BvY7HWvtFU6Jm8+99TEQAnIXJwQj3dLNWCRUSxn/efcb8u3P
	 rDLPY5HSFc8TlPWDodJi9HVzgl8KJcW1dNuxGVzx+U3O4UitGtMVpOwqHzFXEqg94q
	 8wEKdAxNBwWZLhWuC3P7uxaM29gbCwbSCMpAKHSKUbIhHa4LQmcsdL8b+aRG3vKWem
	 DD0XH4CTPJrXQ==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: remove ixgbe_ping_all_vfs() from watchdog link-up handler
Date: Fri,  3 Apr 2026 14:25:51 +0100
Message-ID: <20260403132551.124432-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327073046.134085-4-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-4-aleksandr.loktionov@intel.com>
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
ixgbe: remove ixgbe_ping_all_vfs() from watchdog link-up handler

This patch removes the ixgbe_ping_all_vfs() call from
ixgbe_watchdog_link_is_up() to fix a race condition where VFs receive
CTS (Clear To Send) mailbox messages instead of expected RESET|ACK
responses during initialization.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 0bc806aaed90..6996547a8084 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8151,9 +8151,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
>
>  	/* update the default user priority for VFs */
>  	ixgbe_update_default_up(adapter);
> -
> -	/* ping all the active vfs to let them know link has changed */
> -	ixgbe_ping_all_vfs(adapter);
>  }

The patch removes ixgbe_ping_all_vfs() from ixgbe_watchdog_link_is_up()
to prevent the race condition during VF initialization. However, the
identical call remains in ixgbe_watchdog_link_is_down().

Doesn't the same race condition apply to link-down events?

When a VF initiates reset and the physical link state changes to down,
the watchdog would trigger:

VF side:
- Sends IXGBE_VF_RESET message
- Waits for RESET|ACK response

PF side:
- ixgbe_vf_reset_msg() processes reset, sets clear_to_send=true
- Link goes down, triggers watchdog
- ixgbe_watchdog_link_is_down() calls ixgbe_ping_all_vfs()
- Sends gratuitous ping with CTS bit

VF receives CTS message instead of expected RESET response, causing the
same initialization failure described in the commit message.

Looking at the unchanged code in ixgbe_watchdog_link_is_down():

	e_info(drv, "NIC Link is Down\n");
	netif_carrier_off(netdev);

	/* ping all the active vfs to let them know link has changed */
	ixgbe_ping_all_vfs(adapter);

The commit message states "Link-state changes are already communicated
to VFs through the normal mailbox protocol; the extra ping here is
redundant and races with VF initialization."

Does this reasoning apply equally to the link-down case?
