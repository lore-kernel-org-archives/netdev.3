Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F93FD121;
	Wed,  5 Aug 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922808; cv=none; b=EWXByvWwV01B+a0NllzLYNo2sAMq8poW3xh7KH/JbmkVYG2f5GEQWc+zc1sjxlxX+Nmq6CiX8sGpzkwOelIZcesTvB7lHbfJkhMQZbUfrkgnT74Hg7SnD1RlaDYgwTtpm7IxvP/0uzhYdwes9UPms/pZim5K+C/n+6hJhSYd8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922808; c=relaxed/simple;
	bh=cAmlNGNa7jN+AQzzzqGHoqY/xITpNfx43IoK9Z/xKoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dilNtZAvToGghLXWOLJv8eHX4n0pgUiKduRbRhzFHoDIkY6Sl6OzY3Ghi+bSr93Q5cKtyANWrGRAJzo4bjqm30Qe1q9Uc/LjZB+TtZggreQNrlmmqmIomFtHRYauqKKyGSlsdfRRfvVhwA/yyGOlauT4TUZ/8lVygNKXQd5samk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZWFnMiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZWFnMiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBE31F00A3A;
	Wed,  5 Aug 2026 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922806;
	bh=3f76ioy+yDAIqerzduE+uznQc1AoPKEL1r79knAWZ/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZWFnMiRJ2ZIO1Yq/IlYInwFeHcByv6qz75SV2rc1uMB//F5vdnIqqSkmVAjvNn9C
	 CXjL4s9ow2792oqrbeq9OcdY3RWqK0lcCD4n6EfOXL5NzrmIswlEdQbw5aYyk5vCee
	 8SHfRcPwEc5RvoaAy7ietd6KyvBU1KVxNbmgxG0unzmXH9WUJmxOnKL2tr+3FQXTHc
	 dKpkgpURkXjgtq21qVO3elU0XL+FhMjhw7NawZHR8H8LT5qjX3Tv637UobwvDfyM/D
	 X/3Ooy4UK75RKGW277dnzGvZ2VXB8ScZXbOToekbkcvan+LDWZyvPWS8+gnRqIeoJD
	 +fZ9EBMYxzXUg==
From: Simon Horman <horms@kernel.org>
To: dong100@mucse.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v8 4/4] net: rnpgbe: Add link status handling support
Date: Wed,  5 Aug 2026 10:39:17 +0100
Message-ID: <20260805093917.547461-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731120322.895955-5-dong100@mucse.com>
References: <20260731120322.895955-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260731120322.895955-2-dong100@mucse.com?part=4
---
--- Patch [4]: [PATCH net-next v8 4/4] net: rnpgbe: Add link status handling support ---
commit aaed18098b5cbd048578a3cab86657b190d37796
Author: Dong Yibo <dong100@mucse.com>

net: rnpgbe: Add link status handling support

Add link status management infrastructure to the rnpgbe driver:
- Add link status related data structures (speed, duplex, link state)
- Implement firmware link event handling via mailbox
  (fw controls link states, does not support phylink)
- Add service task for periodic link status monitoring
- Implement carrier status management (netif_carrier_on/off)
- Add port up/down notification to firmware

This enables the driver to properly track and report link status changes.

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
[ ... ]
> +static int rnpgbe_process_link_event(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	unsigned long flags;
> +	bool link;
> +
> +	/* Only event consumption needs a consistent link-state snapshot. */
> +	if (!atomic_read(&mucse->link_pending) ||
> +	    !atomic_xchg(&mucse->link_pending, 0))
> +		return READ_ONCE(hw->link);
> +
> +	spin_lock_irqsave(&mucse->link_lock, flags);
> +
> +	link = hw->link;
> +	spin_unlock_irqrestore(&mucse->link_lock, flags);
> +
> +	return link;
> +}
> +
> +/**
> + * rnpgbe_link_is_up - Update netif_carrier status and
> + * print link up message
> + * @mucse: pointer to the device private structure
> + **/
> +static void rnpgbe_link_is_up(struct mucse *mucse)
> +{
> +	struct net_device *netdev = mucse->netdev;
> +	struct mucse_hw *hw = &mucse->hw;
> +	unsigned long flags;
> +	int speed;
> +	u8 duplex;
> +
> +	/* Only continue if link was previously down */
> +	if (netif_carrier_ok(netdev))
> +		return;
> +	spin_lock_irqsave(&mucse->link_lock, flags);
> +	speed = hw->speed;
> +	duplex = hw->duplex;
> +	spin_unlock_irqrestore(&mucse->link_lock, flags);

[Severity: Medium]
Could this cause a torn link state snapshot if an interrupt fires between
these critical sections?

In rnpgbe_process_link_subtask(), the worker thread first reads the link state
in rnpgbe_process_link_event() under the lock, and then drops the lock.
If the link is true, it calls rnpgbe_link_is_up(), which re-acquires the lock
to read the speed and duplex values.

If a link-down event triggers an interrupt between these two lock acquisitions,
could the worker thread end up reading newly zeroed speed and duplex values,
incorrectly reporting "NIC Link is Up 0 Mbps", and turning the netif carrier
ON while the physical link is actually DOWN?

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
[ ... ]
> @@ -243,6 +249,8 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>  	if (err)
>  		goto err_remove_mbx;
>  
> +	netif_carrier_off(netdev);
> +
>  	return 0;

[Severity: Medium]
Does calling netif_carrier_off() after register_netdev() expose a transient
carrier up state to userspace?

By default, the networking core assumes the carrier state is OK when a new
network device is created. When register_netdev() is called earlier in
rnpgbe_add_adapter(), the device is exposed to userspace and an RTM_NEWLINK
netlink event is broadcast indicating the link is UP.

Immediately calling netif_carrier_off() right after will emit another event
indicating the carrier is DOWN. Can this spurious UP-then-DOWN transition
confuse userspace network management daemons?
