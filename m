Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F432EEE62;
	Fri, 16 Oct 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110612; cv=none; b=ZJr3I5a7QVGs6XOL+Si41LuJ/1A4AIG3nYNQNtaplCp06LDckYehKzZl3V8Dt+wbX/DwM5LlltillAc3dIh/pEYbmBXRaMjUtJN3qJwrUVECJXtump470nqLKBDy++/xTmbF34h21ZN0CHV7RR0DE4lZB9G5jjYHOZE4v5KVTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110612; c=relaxed/simple;
	bh=QCx0onh6yxRSqDatmlicYohZfY9LhizqvP13hNSVvvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL4oCLfBH/2PsTy+9VVrIyt5xdM9v+/C9CHRtL9ZnVoNKNb1KWCnd1mO+LPuFi2xUxqR5pMP6KhoWqSWOdzN6shDidUPlU+vamRsIXLvyCviCp58LFAvrSx2NGtG6t+Wrou0aPw2bjxViaZ6gJ+XvtVA0IPQe7+DJvje6tW0+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzP8AiJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzP8AiJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A031F000C8;
	Fri, 16 Oct 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110611;
	bh=ptn/D1mSizJD1JNhTOgU/mFb99HHjOMYwn6uJHNO6Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JzP8AiJcgVDTup/MaLrVVtYpNLP2QEjUC1iSasZm/WUbA97arMpdOnXroyIw0KcYp
	 Ereem1dBtB0EvYyzJrpjIQ88L+Km03nbHVMelPcxThab0R2dppUxtzca3sbUJlTWpr
	 ncLz28KtQO0TkRsIXcPOlBzLjjkqk24dvhm0Rkn5p7Is1IhyDMuVSSpMdpQZjTUiGT
	 xG5M1csKNtYtBDEcYNlaPisk6WKwJ284Q8wAnp9dF9690WUgGkPZrJYC0fEeWJJWii
	 cS9/YHPfrCSXKw2P5xW+jUR/bmsVUSwR4/zBzXrR4Y1irentQizVhbySHiA+qM/g1I
	 XAxudBkyVjjpw==
From: Jakub Kicinski <kuba@kernel.org>
To: t.martitz@fritz.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] macvlan: allow source mode devices along with passthru
Date: Thu, 15 Oct 2026 17:30:09 -0700
Message-ID: <20261016003009.2692872-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007170638.2086790-3-t.martitz@fritz.com>
References: <20261007170638.2086790-3-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
macvlan: allow source mode devices along with passthru

This patch lets source-mode macvlan devices share a port with a single
passthru macvlan. Known senders end on the source devices and all other
traffic goes to the passthru device. The lower MAC restore moves from
macvlan_port_destroy() to macvlan_uninit() of the passthru device, and
several macvlan_passthru(port) checks become per-device vlan->mode checks.

> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index afad90b9222a2..4af10cc517993 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -83,6 +83,11 @@ static inline void macvlan_set_passthru(struct macvlan_port *port)
>  	port->flags |= MACVLAN_F_PASSTHRU;
>  }
>  
> +static inline void macvlan_clear_passthru(struct macvlan_port *port)
> +{
> +	port->flags &= ~MACVLAN_F_PASSTHRU;
> +}
> +

[Severity: Low]
With this patch, MACVLAN_F_PASSTHRU is set and cleared at runtime while
the rx_handler stays registered for the remaining source devices.
macvlan_set_passthru() and macvlan_clear_passthru() are both plain
read-modify-writes under RTNL. macvlan_handle_frame() reads the flag with
a plain load in softirq:

	if (macvlan_passthru(port))
		vlan = list_first_or_null_rcu(&port->vlans,
					      struct macvlan_dev, list);

Nothing orders the flag against the port->vlans update. The reader seems
to handle both transient states, because the next check passes the frame
when the list head is NULL or a source device:

	if (!vlan || READ_ONCE(vlan->mode) == MACVLAN_MODE_SOURCE)
		return RX_HANDLER_PASS;

The plain-access race on port->flags already existed through
MACVLAN_F_ADDRCHANGE. Would READ_ONCE()/WRITE_ONCE() on port->flags be a
reasonable cleanup now that there is another runtime writer?

[ ... ]

> @@ -737,17 +741,18 @@ static int macvlan_sync_address(struct net_device *dev,
>  	struct macvlan_dev *vlan = netdev_priv(dev);
>  	struct net_device *lowerdev = vlan->lowerdev;
>  	struct macvlan_port *port = vlan->port;
> +	bool passthru_dev = vlan->mode == MACVLAN_MODE_PASSTHRU;
>  	int err;
>  
>  	if (!(dev->flags & IFF_UP)) {
>  		/* Just copy in the new address */
>  		eth_hw_addr_set(dev, addr);
>  	} else {
> -		/* Rehash and update the device filters */
> -		if (macvlan_addr_busy(vlan->port, addr))
> -			return -EADDRINUSE;
> +		if (!passthru_dev) {
> +			/* Rehash and update the device filters */
> +			if (macvlan_addr_busy(vlan->port, addr))
> +					return -EADDRINUSE;

[Severity: Low]
For the passthru device, this now skips macvlan_addr_busy() entirely. That
includes the vlan_hash lookup the old code still did on passthru ports.
The new check in macvlan_set_mac_address() only covers changes made
through the passthru device.

What happens when the change starts on the lower device? For example,
setting eth0's MAC to the MAC of a source-mode macvlan that is up:

netif_set_mac_address()
  NETDEV_CHANGEADDR
    macvlan_device_event()
      macvlan_sync_address()
        macvlan_hash_change_addr()

Wouldn't this put the passthru device into port->vlan_hash with the same
MAC the source device already has there?

The same seems to happen when the passthru device is down.
eth_hw_addr_set() copies the address, and macvlan_open() later hashes it
with no busy check.

After that, lookups through macvlan_hash_lookup(), such as the h_source
lookup on the multicast rx path, depend on hash order. The source device
also can't be reopened, because its address now equals the lower's.

netif_set_mac_address() ignores the NETDEV_CHANGEADDR notifier return
value, so the old NOTIFY_BAD path would not have vetoed this either. Would
a NETDEV_PRE_CHANGEADDR check be the right place to reject it?

[ ... ]

> @@ -781,14 +786,17 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
>  	if (ether_addr_equal(dev->dev_addr, addr->__data))
>  		return 0;
>  
> +	if (macvlan_addr_busy(vlan->port, addr->__data))
> +		return -EADDRINUSE;
> +
>  	if (READ_ONCE(vlan->mode) == MACVLAN_MODE_PASSTHRU) {
>  		macvlan_set_addr_change(vlan->port);
> +		/* macvlan_sync_address() via netdev notifier,
> +		 * to keep passthru and lower in sync.
> +		 */
>  		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
>  	}

[Severity: Medium]
macvlan_set_addr_change() is called before
dev_set_mac_address(vlan->lowerdev, ...). That call can fail, for example
with -EBUSY from eth_prepare_mac_addr_change() on a running lower device
without IFF_LIVE_ADDR_CHANGE, or through a NETDEV_PRE_CHANGEADDR veto. In
that case netif_set_mac_address() returns before NETDEV_CHANGEADDR, and
nothing clears MACVLAN_F_ADDRCHANGE.

Before this patch, the port and the flag went away together with the only
passthru device. Now source devices keep the port alive.
macvlan_uninit() only calls macvlan_clear_passthru().
macvlan_common_newlink() resets port->perm_addr for a new passthru device,
but not the flag.

Can the following sequence restore an outdated MAC on the lower device?

1. ip link set <passthru> address X fails, leaving ADDRCHANGE set.
2. The passthru device is deleted while source devices still exist.
3. A new passthru device is created, which copies the current lower MAC
   into perm_addr.
4. The lower MAC is changed directly. macvlan_sync_address() sees the
   stale flag and does not save the new address:

	if (passthru_dev && !macvlan_addr_change(port)) {

5. The passthru device is deleted. macvlan_uninit() sees
   dev_addr != perm_addr and writes the old MAC back.

Should the flag be cleared when dev_set_mac_address() fails, or when the
passthru device goes away?

[ ... ]

> @@ -979,7 +987,26 @@ static void macvlan_uninit(struct net_device *dev)
>  
>  	macvlan_flush_sources(port, vlan);
>  	port->count -= 1;
> -	if (!port->count)
> +
> +	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
> +		/* If the lower device address has been changed by passthru
> +		 * macvlan, put it back.
> +		 *
> +		 * Caution: This triggers NETDEV_CHANGEADDR on
> +		 * the lower device. But we're in the green because
> +		 * the passthru interface is already off the list.
> +		 */
> +		if (!ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
> +			struct sockaddr_storage ss;
> +
> +			ss.ss_family = port->dev->type;
> +			memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
> +			dev_set_mac_address(port->dev, &ss, NULL);
> +		}

[Severity: Medium]
Can this put a MAC on the lower device that a remaining source-mode
macvlan already uses? Consider this sequence:

1. The lower device has address A. A passthru device is created, so
   perm_addr = A.
2. The passthru address is set to B. The lower device changes to B, and
   perm_addr stays A because ADDRCHANGE is set.
3. A source-mode macvlan is created with IFLA_ADDRESS = A.
   macvlan_common_newlink() does no busy check.
4. The source device is brought up. In macvlan_open(),
   macvlan_addr_busy(A) only compares against the current lower address
   (B) and vlan_hash, so it succeeds and calls dev_uc_add(lower, A).
5. The passthru device is deleted. This code calls
   dev_set_mac_address(lower, A) without checking the macvlans that are
   left.

The lower device and the source device now share A. The next down/up of
the source device then fails in macvlan_open() with -EADDRINUSE, because
macvlan_addr_busy() hits this check:

	if (ether_addr_equal_64bits(port->dev->dev_addr, addr))
		return true;

[ ... ]

> @@ -1544,12 +1549,32 @@ int macvlan_common_newlink(struct net_device *dev,
>  	if (data && data[IFLA_MACVLAN_FLAGS])
>  		vlan->flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>  
> +	/* Only 1 macvlan device can be created in passthru mode. There may be
> +	 * additional source mode devices but nothing else at the moment.
> +	 *
> +	 * First check if adding a source mode device to an existing passthru vlan.
> +	 */
> +	if (macvlan_passthru(port) && vlan->mode != MACVLAN_MODE_SOURCE) {
> +		/* The macvlan port must be not created this time,
> +		 * still goto destroy_macvlan_port for readability.
> +		 */
> +		err = -EINVAL;
> +		goto destroy_macvlan_port;
> +	}

[Severity: Medium]
Source-mode devices are now allowed on a passthru port, so the passthru
device no longer gets all traffic on the lower device. Are there places
outside macvlan.c that still assume it does?

In drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c,
mlx5e_rep_check_indr_block_supported() offloads tc ingress filters bound
to a macvlan onto the real lower representor whenever this returns true:

mlx5e_rep_macvlan_mode_supported() {
	...
	return macvlan->mode == MACVLAN_MODE_PASSTHRU;
}

In software, macvlan_handle_frame() calls macvlan_forward_source() before
the passthru lookup. With MACVLAN_FLAG_NODST, known-sender frames are
consumed there and never reach the passthru device.

A hardware filter installed for the passthru macvlan could still match
frames entering the representor, including the inter-SoC ones. It could
then drop or redirect them before the source devices see them. I could
not confirm from the mlx5 flow steering code that the offloaded rule
matches every packet from the vport. If it does, hardware and software
would behave differently here. Is that a concern?

Also, the uAPI comment in include/uapi/linux/if_link.h still says:

	MACVLAN_MODE_PASSTHRU = 8,/* take over the underlying device */

Should that be updated as well?

[ ... ]

> @@ -1652,19 +1682,23 @@ static int macvlan_changelink(struct net_device *dev,
>  	if (data && data[IFLA_MACVLAN_MODE]) {
>  		set_mode = true;
>  		mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
> -		/* Passthrough mode can't be set or cleared dynamically */
> -		if ((mode == MACVLAN_MODE_PASSTHRU) !=
> -		    (vlan->mode == MACVLAN_MODE_PASSTHRU))
> -			return -EINVAL;
> -		if (vlan->mode == MACVLAN_MODE_SOURCE &&
> -		    vlan->mode != mode)
> -			macvlan_flush_sources(vlan->port, vlan);
> +		if (mode != vlan->mode) {
> +			/* Passthrough mode can't be set or cleared dynamically,
> +			 * regardless of existing source interfaces. Furthermore, source
> +			 * interfaces can't switch modes within a passhtrough port.
> +			 */
> +			if (mode == MACVLAN_MODE_PASSTHRU ||
> +			    macvlan_passthru(vlan->port))
> +				return -EINVAL;

[Severity: Low]
This adds a new restriction: while the port is in passthru, any mode
change of a source-mode device returns -EINVAL. The commit message does
not mention this or a few other user-visible changes:

- The lower MAC restore moved from macvlan_port_destroy() to
  macvlan_uninit() of the passthru device. It now runs even while source
  devices stay on the port.

- macvlan_forward_source() only consumes the frame when
  MACVLAN_FLAG_NODST is set. Without it, known-sender frames are cloned to
  the source device and also delivered to the passthru device.

The commit message says:

  "The source mode devices represent the known senders while
  all external senders terminate on passthru device."

That split seems to depend on NODST being set.

Documentation/networking/device_drivers/ethernet/intel/ice.rst also still
says:

  "In passthru mode, you can only set up one MACVLAN device."

Could the commit message and that document be updated to describe these
changes?

> +			if (vlan->mode == MACVLAN_MODE_SOURCE)
> +				macvlan_flush_sources(vlan->port, vlan);
> +		}
>  	}
>  
>  	if (data && data[IFLA_MACVLAN_FLAGS]) {
>  		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>  		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
> -		if (macvlan_passthru(vlan->port) && promisc) {
> +		if (vlan->mode == MACVLAN_MODE_PASSTHRU && promisc) {
>  			int err;
>  
>  			if (flags & MACVLAN_FLAG_NOPROMISC)

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
macvlan_changelink() changes the lower device's promiscuity count whenever
MACVLAN_FLAG_NOPROMISC flips on the passthru device. It does not check
dev->flags & IFF_UP. macvlan_open() and macvlan_stop() only take or drop
that reference while the device is up.

Setting nopromisc on a passthru device that is down calls
dev_set_promiscuity(lowerdev, -1) with no matching +1. That either drops a
reference owned by another user, or wraps dev->promiscuity from 0 in
__dev_set_promiscuity() and leaves IFF_PROMISC set. Clearing nopromisc
while down takes a +1 that is never released.

Should this be gated on IFF_UP? For the passthru device, the patch's
change from macvlan_passthru(vlan->port) to
vlan->mode == MACVLAN_MODE_PASSTHRU is equivalent, so the behavior is
unchanged.

[ ... ]
-- 
pw-bot: cr
