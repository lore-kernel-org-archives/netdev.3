Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.42.244.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705887;
	b=LRmawa62ZbQ2lkA4qhEY9UnArTls5cCmEK/Kc/8+Um23bZAD5HNDnn3Uct3dUa5tLPfL
	 UtAti7QHceCJnSmyQQ5MuIgpmKYU3tVmi4SBdctA8eWJIwKyx91fygOOnDEGzefci9sH5
	 t+XMWSlyOsHCZzf/ZrM9T6l2RwD/PARPo3vmI1XvmnudkGHA0RjV95SgJY8oeDw7FMobX
	 CWBGZoOGUGH11+swbEz1oVIFuOdJSIVFlZsDOiW9cvVitqFkwS9h+o3dASHYcTujld3Fz
	 3xcrppmWjs0JgCh6ld5qjfHAypijCEAHPO9mlxdOMlYtWEXazrZKCuLfSOkgnprJlFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705887;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-purgate-ID:
	 X-purgate-type:X-purgate-size:X-purgate:X-purgate:X-pfmilter;
	bh=nXzMJK6dSzoDCsNUszuhoOVlPN4xWvrqNWODWAqVYGo=;
	b=ThsJb0hmgHuvpYixFTH5YKdOiIMyUCG+CCwfpdhRQFCgbQrgk4cqGmhpW0WxSJPfuXNH
	 UxluSV51pGR9qWIHNMaAyHsonzFBG7DqgI/2gYNZodeyBSHo/HOUsSMqf0yIICSWm2yGL
	 zlVKJUYkjwwypRhNBwzgfuO/udqMIdKOTubZwDbZXnkr0ym9uY47UvKcm+QTLEnGIB9sa
	 zAvDuT0/kNtrziC3jWDWgMb42E/0J3XWvs8ZrDaOgY40VXlDA2MZ2I2jCoPk9PY0u14C/
	 y70HsanxD52USNWV6Xo+6cVtDf5/gayzwPxgzSVJQwgqyiLAgxPdwEEH+wSpdMAERGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fritz.com;
	spf=pass smtp.mailfrom=fritz.com;
	arc=none smtp.remote-ip=212.42.244.120
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9B606D82F;
	Tue,  3 Nov 2026 11:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC9B606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1793705876; bh=p56zWYEpp3KkOFyMXbSJKtmED3slGYSWKjtBy8biIJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H5qBkszb6pDsTTDWTRA7sn9qSMps5N7jdooYJnNVahKd7W4CwoaCqXg3NlR+VgMSZ
	 DmYx/JI4i5OdqHuj63eDpPIuyYQ46h1nGdjIFyQ31bNHU7fyHf1BU26B3KNRD1hahd
	 dTLACHjUSazAk1IcR9MCD8STxh9kCWR+CASmf8cX47TC0ixv4XK6LDTJCUVEAAjbSj
	 JOVOAXCwXPpM6uKN73L+eavkEg0w/Qgj0wxmgGFn0u5wcMMwAB1Hs9Fc4vQoqOAFV/
	 AtzbfZcKXU1nMvqg5lwI4bjBfcd09fHhBF6t74THedfjkc+AbCj5dOAGL2Rl0CPRH6
	 qDsaG3cUad1/Q==
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6ae9c794-045a-7f0000032729-7f0000019820-1
	for <multiple-recipients>; Tue, 03 Nov 2026 12:37:56 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  3 Nov 2026 12:37:56 +0100 (CET)
Message-ID: <0559500f-e89c-4ddc-941d-c98f2b1d55f1@fritz.com>
Date: Tue, 3 Nov 2026 12:37:56 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v6 1/1] macvlan: allow source mode devices along with
 passthru
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007170638.2086790-3-t.martitz@fritz.com>
 <20261016003009.2692872-1-kuba@kernel.org>
Content-Language: en-US
From: Thomas Martitz <t.martitz@fritz.com>
In-Reply-To: <20261016003009.2692872-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate-ID: 149429::1793705876-6CFF7836-FE1FF761/0/0
X-purgate-type: clean
X-purgate-size: 28819
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-01  mail-id: 86452A02E3  external: no

Am 16.10.26 um 02:30 schrieb Jakub Kicinski:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> macvlan: allow source mode devices along with passthru
> 
> This patch lets source-mode macvlan devices share a port with a single
> passthru macvlan. Known senders end on the source devices and all other
> traffic goes to the passthru device. The lower MAC restore moves from
> macvlan_port_destroy() to macvlan_uninit() of the passthru device, and
> several macvlan_passthru(port) checks become per-device vlan->mode checks.


Hello Jakub,

thanks for taking time to deal with my patch. I replied inline to sasihikos
findings.

Besides being busy with other daily business I finally managed set up
sashiko locally. I will probably come up with v7 but this time run sashiko
locally before submitting.

Best regards.

> 
>> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
>> index afad90b9222a2..4af10cc517993 100644
>> --- a/drivers/net/macvlan.c
>> +++ b/drivers/net/macvlan.c
>> @@ -83,6 +83,11 @@ static inline void macvlan_set_passthru(struct macvlan_port *port)
>>  	port->flags |= MACVLAN_F_PASSTHRU;
>>  }
>>  
>> +static inline void macvlan_clear_passthru(struct macvlan_port *port)
>> +{
>> +	port->flags &= ~MACVLAN_F_PASSTHRU;
>> +}
>> +
> 
> [Severity: Low]
> With this patch, MACVLAN_F_PASSTHRU is set and cleared at runtime while
> the rx_handler stays registered for the remaining source devices.
> macvlan_set_passthru() and macvlan_clear_passthru() are both plain
> read-modify-writes under RTNL. macvlan_handle_frame() reads the flag with
> a plain load in softirq:
> 
> 	if (macvlan_passthru(port))
> 		vlan = list_first_or_null_rcu(&port->vlans,
> 					      struct macvlan_dev, list);
> 
> Nothing orders the flag against the port->vlans update. The reader seems
> to handle both transient states, because the next check passes the frame
> when the list head is NULL or a source device:
> 
> 	if (!vlan || READ_ONCE(vlan->mode) == MAm 16.10.26 um 02:30 schrieb Jakub Kicinski:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> macvlan: allow source mode devices along with passthru
> 
> This patch lets source-mode macvlan devices share a port with a single
> passthru macvlan. Known senders end on the source devices and all other
> traffic goes to the passthru device. The lower MAC restore moves from
> macvlan_port_destroy() to macvlan_uninit() of the passthru device, and
> several macvlan_passthru(port) checks become per-device vlan->mode checks.

Hello Jakub,

thanks for taking time to deal with my patch.

Besides being busy with other daily business I finally managed set up
sashiko locally. I will probably come up with v7 but this time run sashiko
locally before submitting.

Best regards.

> 
>> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
>> index afad90b9222a2..4af10cc517993 100644
>> --- a/drivers/net/macvlan.c
>> +++ b/drivers/net/macvlan.c
>> @@ -83,6 +83,11 @@ static inline void macvlan_set_passthru(struct macvlan_port *port)
>>  	port->flags |= MACVLAN_F_PASSTHRU;
>>  }
>>  
>> +static inline void macvlan_clear_passthru(struct macvlan_port *port)
>> +{
>> +	port->flags &= ~MACVLAN_F_PASSTHRU;
>> +}
>> +
> 
> [Severity: Low]
> With this patch, MACVLAN_F_PASSTHRU is set and cleared at runtime while
> the rx_handler stays registered for the remaining source devices.
> macvlan_set_passthru() and macvlan_clear_passthru() are both plain
> read-modify-writes under RTNL. macvlan_handle_frame() reads the flag with
> a plain load in softirq:
> 
> 	if (macvlan_passthru(port))
> 		vlan = list_first_or_null_rcu(&port->vlans,
> 					      struct macvlan_dev, list);
> 
> Nothing orders the flag against the port->vlans update. The reader seems
> to handle both transient states, because the next check passes the frame
> when the list head is NULL or a source device:
> 
> 	if (!vlan || READ_ONCE(vlan->mode) == MACVLAN_MODE_SOURCE)
> 		return RX_HANDLER_PASS;
> 
> The plain-access race on port->flags already existed through
> MACVLAN_F_ADDRCHANGE. Would READ_ONCE()/WRITE_ONCE() on port->flags be a
> reasonable cleanup now that there is another runtime writer?
> 
> [ ... ]
> 
>> @@ -737,17 +741,18 @@ static int macvlan_sync_address(struct net_device *dev,
>>  	struct macvlan_dev *vlan = netdev_priv(dev);
>>  	struct net_device *lowerdev = vlan->lowerdev;
>>  	struct macvlan_port *port = vlan->port;
>> +	bool passthru_dev = vlan->mode == MACVLAN_MODE_PASSTHRU;
>>  	int err;
>>  
>>  	if (!(dev->flags & IFF_UP)) {
>>  		/* Just copy in the new address */
>>  		eth_hw_addr_set(dev, addr);
>>  	} else {
>> -		/* Rehash and update the device filters */
>> -		if (macvlan_addr_busy(vlan->port, addr))
>> -			return -EADDRINUSE;
>> +		if (!passthru_dev) {
>> +			/* Rehash and update the device filters */
>> +			if (macvlan_addr_busy(vlan->port, addr))
>> +					return -EADDRINUSE;
> 
> [Severity: Low]
> For the passthru device, this now skips macvlan_addr_busy() entirely. That
> includes the vlan_hash lookup the old code still did on passthru ports.
> The new check in macvlan_set_mac_address() only covers changes made
> through the passthru device.
> 
> What happens when the change starts on the lower device? For example,
> setting eth0's MAC to the MAC of a source-mode macvlan that is up:
> 
> netif_set_mac_address()
>   NETDEV_CHANGEADDR
>     macvlan_device_event()
>       macvlan_sync_address()
>         macvlan_hash_change_addr()
> 
> Wouldn't this put the passthru device into port->vlan_hash with the same
> MAC the source device already has there?
> 
> The same seems to happen when the passthru device is down.
> eth_hw_addr_set() copies the address, and macvlan_open() later hashes it
> with no busy check.
> 
> After that, lookups through macvlan_hash_lookup(), such as the h_source
> lookup on the multicast rx path, depend on hash order. The source device
> also can't be reopened, because its address now equals the lower's.
> 
> netif_set_mac_address() ignores the NETDEV_CHANGEADDR notifier return
> value, so the old NOTIFY_BAD path would not have vetoed this either. Would
> a NETDEV_PRE_CHANGEADDR check be the right place to reject it?
I will look at this in more detail.

> 
> [ ... ]
> 
>> @@ -781,14 +786,17 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
>>  	if (ether_addr_equal(dev->dev_addr, addr->__data))
>>  		return 0;
>>  
>> +	if (macvlan_addr_busy(vlan->port, addr->__data))
>> +		return -EADDRINUSE;
>> +
>>  	if (READ_ONCE(vlan->mode) == MACVLAN_MODE_PASSTHRU) {
>>  		macvlan_set_addr_change(vlan->port);
>> +		/* macvlan_sync_address() via netdev notifier,
>> +		 * to keep passthru and lower in sync.
>> +		 */
>>  		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
>>  	}
> 
> [Severity: Medium]
> macvlan_set_addr_change() is called before
> dev_set_mac_address(vlan->lowerdev, ...). That call can fail, for example
> with -EBUSY from eth_prepare_mac_addr_change() on a running lower device
> without IFF_LIVE_ADDR_CHANGE, or through a NETDEV_PRE_CHANGEADDR veto. In
> that case netif_set_mac_address() returns before NETDEV_CHANGEADDR, and
> nothing clears MACVLAN_F_ADDRCHANGE.
> 
> Before this patch, the port and the flag went away together with the only
> passthru device. Now source devices keep the port alive.
> macvlan_uninit() only calls macvlan_clear_passthru().
> macvlan_common_newlink() resets port->perm_addr for a new passthru device,
> but not the flag.
> 
> Can the following sequence restore an outdated MAC on the lower device?
> 
> 1. ip link set <passthru> address X fails, leaving ADDRCHANGE set.
> 2. The passthru device is deleted while source devices still exist.
> 3. A new passthru device is created, which copies the current lower MAC
>    into perm_addr.
> 4. The lower MAC is changed directly. macvlan_sync_address() sees the
>    stale flag and does not save the new address:
> 
> 	if (passthru_dev && !macvlan_addr_change(port)) {
> 
> 5. The passthru device is deleted. macvlan_uninit() sees
>    dev_addr != perm_addr and writes the old MAC back.
> 
> Should the flag be cleared when dev_set_mac_address() fails, or when the
> passthru device goes away?
> 
Seems valid, I will try to reproduce this and fix this in a follow up.

> [ ... ]
> 
>> @@ -979,7 +987,26 @@ static void macvlan_uninit(struct net_device *dev)
>>  
>>  	macvlan_flush_sources(port, vlan);
>>  	port->count -= 1;
>> -	if (!port->count)
>> +
>> +	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
>> +		/* If the lower device address has been changed by passthru
>> +		 * macvlan, put it back.
>> +		 *
>> +		 * Caution: This triggers NETDEV_CHANGEADDR on
>> +		 * the lower device. But we're in the green because
>> +		 * the passthru interface is already off the list.
>> +		 */
>> +		if (!ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
>> +			struct sockaddr_storage ss;
>> +
>> +			ss.ss_family = port->dev->type;
>> +			memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
>> +			dev_set_mac_address(port->dev, &ss, NULL);
>> +		}
> 
> [Severity: Medium]
> Can this put a MAC on the lower device that a remaining source-mode
> macvlan already uses? Consider this sequence:
> 
> 1. The lower device has address A. A passthru device is created, so
>    perm_addr = A.
> 2. The passthru address is set to B. The lower device changes to B, and
>    perm_addr stays A because ADDRCHANGE is set.
> 3. A source-mode macvlan is created with IFLA_ADDRESS = A.
>    macvlan_common_newlink() does no busy check.
> 4. The source device is brought up. In macvlan_open(),
>    macvlan_addr_busy(A) only compares against the current lower address
>    (B) and vlan_hash, so it succeeds and calls dev_uc_add(lower, A).
> 5. The passthru device is deleted. This code calls
>    dev_set_mac_address(lower, A) without checking the macvlans that are
>    left.
> 
> The lower device and the source device now share A. The next down/up of
> the source device then fails in macvlan_open() with -EADDRINUSE, because
> macvlan_addr_busy() hits this check:
> 
> 	if (ether_addr_equal_64bits(port->dev->dev_addr, addr))
> 		return true;
> 

Like above, I will try to reproduce this and fix this in a follow up.

> [ ... ]
> 
>> @@ -1544,12 +1549,32 @@ int macvlan_common_newlink(struct net_device *dev,
>>  	if (data && data[IFLA_MACVLAN_FLAGS])
>>  		vlan->flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>>  
>> +	/* Only 1 macvlan device can be created in passthru mode. There may be
>> +	 * additional source mode devices but nothing else at the moment.
>> +	 *
>> +	 * First check if adding a source mode device to an existing passthru vlan.
>> +	 */
>> +	if (macvlan_passthru(port) && vlan->mode != MACVLAN_MODE_SOURCE) {
>> +		/* The macvlan port must be not created this time,
>> +		 * still goto destroy_macvlan_port for readability.
>> +		 */
>> +		err = -EINVAL;
>> +		goto destroy_macvlan_port;
>> +	}
> 
> [Severity: Medium]
> Source-mode devices are now allowed on a passthru port, so the passthru
> device no longer gets all traffic on the lower device. Are there places
> outside macvlan.c that still assume it does?
> 
> In drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c,
> mlx5e_rep_check_indr_block_supported() offloads tc ingress filters bound
> to a macvlan onto the real lower representor whenever this returns true:
> 
> mlx5e_rep_macvlan_mode_supported() {
> 	...
> 	return macvlan->mode == MACVLAN_MODE_PASSTHRU;
> }
> 
> In software, macvlan_handle_frame() calls macvlan_forward_source() before
> the passthru lookup. With MACVLAN_FLAG_NODST, known-sender frames are
> consumed there and never reach the passthru device.
> 
> A hardware filter installed for the passthru macvlan could still match
> frames entering the representor, including the inter-SoC ones. It could
> then drop or redirect them before the source devices see them. I could
> not confirm from the mlx5 flow steering code that the offloaded rule
> matches every packet from the vport. If it does, hardware and software
> would behave differently here. Is that a concern?
Hmm, I didn't consider HW offloading. Offloading should probably be
avoided in this configuration. But drivers would probably need some
assistance here.

Do you have an opinion how to deal best with this?

> 
> Also, the uAPI comment in include/uapi/linux/if_link.h still says:
> 
> 	MACVLAN_MODE_PASSTHRU = 8,/* take over the underlying device */
> 
> Should that be updated as well?
Good idea.

> 
> [ ... ]
> 
>> @@ -1652,19 +1682,23 @@ static int macvlan_changelink(struct net_device *dev,
>>  	if (data && data[IFLA_MACVLAN_MODE]) {
>>  		set_mode = true;
>>  		mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
>> -		/* Passthrough mode can't be set or cleared dynamically */
>> -		if ((mode == MACVLAN_MODE_PASSTHRU) !=
>> -		    (vlan->mode == MACVLAN_MODE_PASSTHRU))
>> -			return -EINVAL;
>> -		if (vlan->mode == MACVLAN_MODE_SOURCE &&
>> -		    vlan->mode != mode)
>> -			macvlan_flush_sources(vlan->port, vlan);
>> +		if (mode != vlan->mode) {
>> +			/* Passthrough mode can't be set or cleared dynamically,
>> +			 * regardless of existing source interfaces. Furthermore, source
>> +			 * interfaces can't switch modes within a passhtrough port.
>> +			 */
>> +			if (mode == MACVLAN_MODE_PASSTHRU ||
>> +			    macvlan_passthru(vlan->port))
>> +				return -EINVAL;
> 
> [Severity: Low]
> This adds a new restriction: while the port is in passthru, any mode
> change of a source-mode device returns -EINVAL. The commit message does
> not mention this or a few other user-visible changes:
> 
> - The lower MAC restore moved from macvlan_port_destroy() to
>   macvlan_uninit() of the passthru device. It now runs even while source
>   devices stay on the port.
> 
> - macvlan_forward_source() only consumes the frame when
>   MACVLAN_FLAG_NODST is set. Without it, known-sender frames are cloned to
>   the source device and also delivered to the passthru device.
> 
> The commit message says:
> 
>   "The source mode devices represent the known senders while
>   all external senders terminate on passthru device."
> 
> That split seems to depend on NODST being set.
> 
> Documentation/networking/device_drivers/ethernet/intel/ice.rst also still
> says:
> 
>   "In passthru mode, you can only set up one MACVLAN device."
> 
> Could the commit message and that document be updated to describe these
> changes?

Okay.

> 
>> +			if (vlan->mode == MACVLAN_MODE_SOURCE)
>> +				macvlan_flush_sources(vlan->port, vlan);
>> +		}
>>  	}
>>  
>>  	if (data && data[IFLA_MACVLAN_FLAGS]) {
>>  		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>>  		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
>> -		if (macvlan_passthru(vlan->port) && promisc) {
>> +		if (vlan->mode == MACVLAN_MODE_PASSTHRU && promisc) {
>>  			int err;
>>  
>>  			if (flags & MACVLAN_FLAG_NOPROMISC)
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch.
> macvlan_changelink() changes the lower device's promiscuity count whenever
> MACVLAN_FLAG_NOPROMISC flips on the passthru device. It does not check
> dev->flags & IFF_UP. macvlan_open() and macvlan_stop() only take or drop
> that reference while the device is up.
> 
> Setting nopromisc on a passthru device that is down calls
> dev_set_promiscuity(lowerdev, -1) with no matching +1. That either drops a
> reference owned by another user, or wraps dev->promiscuity from 0 in
> __dev_set_promiscuity() and leaves IFF_PROMISC set. Clearing nopromisc
> while down takes a +1 that is never released.
> 
> Should this be gated on IFF_UP? For the passthru device, the patch's
> change from macvlan_passthru(vlan->port) to
> vlan->mode == MACVLAN_MODE_PASSTHRU is equivalent, so the behavior is
> unchanged.
> 
> [ ... ]
Do you want me to send a fix for this in a separate thread?

Best regards


-- 
Thomas Martitz <t.martitz@fritz.com>
FRITZ! Technology GmbH, Berlin (Germany)ACVLAN_MODE_SOURCE)
> 		return RX_HANDLER_PASS;
> 
> The plain-access race on port->flags already existed through
> MACVLAN_F_ADDRCHANGE. Would READ_ONCE()/WRITE_ONCE() on port->flags be a
> reasonable cleanup now that there is another runtime writer?
> 
> [ ... ]
> 
>> @@ -737,17 +741,18 @@ static int macvlan_sync_address(struct net_device *dev,
>>  	struct macvlan_dev *vlan = netdev_priv(dev);
>>  	struct net_device *lowerdev = vlan->lowerdev;
>>  	struct macvlan_port *port = vlan->port;
>> +	bool passthru_dev = vlan->mode == MACVLAN_MODE_PASSTHRU;
>>  	int err;
>>  
>>  	if (!(dev->flags & IFF_UP)) {
>>  		/* Just copy in the new address */
>>  		eth_hw_addr_set(dev, addr);
>>  	} else {
>> -		/* Rehash and update the device filters */
>> -		if (macvlan_addr_busy(vlan->port, addr))
>> -			return -EADDRINUSE;
>> +		if (!passthru_dev) {
>> +			/* Rehash and update the device filters */
>> +			if (macvlan_addr_busy(vlan->port, addr))
>> +					return -EADDRINUSE;
> 
> [Severity: Low]
> For the passthru device, this now skips macvlan_addr_busy() entirely. That
> includes the vlan_hash lookup the old code still did on passthru ports.
> The new check in macvlan_set_mac_address() only covers changes made
> through the passthru device.
> 
> What happens when the change starts on the lower device? For example,
> setting eth0's MAC to the MAC of a source-mode macvlan that is up:
> 
> netif_set_mac_address()
>   NETDEV_CHANGEADDR
>     macvlan_device_event()
>       macvlan_sync_address()
>         macvlan_hash_change_addr()
> 
> Wouldn't this put the passthru device into port->vlan_hash with the same
> MAC the source device already has there?
> 
> The same seems to happen when the passthru device is down.
> eth_hw_addr_set() copies the address, and macvlan_open() later hashes it
> with no busy check.
> 
> After that, lookups through macvlan_hash_lookup(), such as the h_source
> lookup on the multicast rx path, depend on hash order. The source device
> also can't be reopened, because its address now equals the lower's.
> 
> netif_set_mac_address() ignores the NETDEV_CHANGEADDR notifier return
> value, so the old NOTIFY_BAD path would not have vetoed this either. Would
> a NETDEV_PRE_CHANGEADDR check be the right place to reject it?

I will look at this in more detail.

> 
> [ ... ]
> 
>> @@ -781,14 +786,17 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
>>  	if (ether_addr_equal(dev->dev_addr, addr->__data))
>>  		return 0;
>>  
>> +	if (macvlan_addr_busy(vlan->port, addr->__data))
>> +		return -EADDRINUSE;
>> +
>>  	if (READ_ONCE(vlan->mode) == MACVLAN_MODE_PASSTHRU) {
>>  		macvlan_set_addr_change(vlan->port);
>> +		/* macvlan_sync_address() via netdev notifier,
>> +		 * to keep passthru and lower in sync.
>> +		 */
>>  		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
>>  	}
> 
> [Severity: Medium]
> macvlan_set_addr_change() is called before
> dev_set_mac_address(vlan->lowerdev, ...). That call can fail, for example
> with -EBUSY from eth_prepare_mac_addr_change() on a running lower device
> without IFF_LIVE_ADDR_CHANGE, or through a NETDEV_PRE_CHANGEADDR veto. In
> that case netif_set_mac_address() returns before NETDEV_CHANGEADDR, and
> nothing clears MACVLAN_F_ADDRCHANGE.
> 
> Before this patch, the port and the flag went away together with the only
> passthru device. Now source devices keep the port alive.
> macvlan_uninit() only calls macvlan_clear_passthru().
> macvlan_common_newlink() resets port->perm_addr for a new passthru device,
> but not the flag.
> 
> Can the following sequence restore an outdated MAC on the lower device?
> 
> 1. ip link set <passthru> address X fails, leaving ADDRCHANGE set.
> 2. The passthru device is deleted while source devices still exist.
> 3. A new passthru device is created, which copies the current lower MAC
>    into perm_addr.
> 4. The lower MAC is changed directly. macvlan_sync_address() sees the
>    stale flag and does not save the new address:
> 
> 	if (passthru_dev && !macvlan_addr_change(port)) {
> 
> 5. The passthru device is deleted. macvlan_uninit() sees
>    dev_addr != perm_addr and writes the old MAC back.
> 
> Should the flag be cleared when dev_set_mac_address() fails, or when the
> passthru device goes away?
> 

Seems valid, I will try to reproduce this and fix this in a follow up.

> [ ... ]
> 
>> @@ -979,7 +987,26 @@ static void macvlan_uninit(struct net_device *dev)
>>  
>>  	macvlan_flush_sources(port, vlan);
>>  	port->count -= 1;
>> -	if (!port->count)
>> +
>> +	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
>> +		/* If the lower device address has been changed by passthru
>> +		 * macvlan, put it back.
>> +		 *
>> +		 * Caution: This triggers NETDEV_CHANGEADDR on
>> +		 * the lower device. But we're in the green because
>> +		 * the passthru interface is already off the list.
>> +		 */
>> +		if (!ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
>> +			struct sockaddr_storage ss;
>> +
>> +			ss.ss_family = port->dev->type;
>> +			memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
>> +			dev_set_mac_address(port->dev, &ss, NULL);
>> +		}
> 
> [Severity: Medium]
> Can this put a MAC on the lower device that a remaining source-mode
> macvlan already uses? Consider this sequence:
> 
> 1. The lower device has address A. A passthru device is created, so
>    perm_addr = A.
> 2. The passthru address is set to B. The lower device changes to B, and
>    perm_addr stays A because ADDRCHANGE is set.
> 3. A source-mode macvlan is created with IFLA_ADDRESS = A.
>    macvlan_common_newlink() does no busy check.
> 4. The source device is brought up. In macvlan_open(),
>    macvlan_addr_busy(A) only compares against the current lower address
>    (B) and vlan_hash, so it succeeds and calls dev_uc_add(lower, A).
> 5. The passthru device is deleted. This code calls
>    dev_set_mac_address(lower, A) without checking the macvlans that are
>    left.
> 
> The lower device and the source device now share A. The next down/up of
> the source device then fails in macvlan_open() with -EADDRINUSE, because
> macvlan_addr_busy() hits this check:
> 
> 	if (ether_addr_equal_64bits(port->dev->dev_addr, addr))
> 		return true;
> 


Like above, I will try to reproduce this and fix this in a follow up.

> [ ... ]
> 
>> @@ -1544,12 +1549,32 @@ int macvlan_common_newlink(struct net_device *dev,
>>  	if (data && data[IFLA_MACVLAN_FLAGS])
>>  		vlan->flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>>  
>> +	/* Only 1 macvlan device can be created in passthru mode. There may be
>> +	 * additional source mode devices but nothing else at the moment.
>> +	 *
>> +	 * First check if adding a source mode device to an existing passthru vlan.
>> +	 */
>> +	if (macvlan_passthru(port) && vlan->mode != MACVLAN_MODE_SOURCE) {
>> +		/* The macvlan port must be not created this time,
>> +		 * still goto destroy_macvlan_port for readability.
>> +		 */
>> +		err = -EINVAL;
>> +		goto destroy_macvlan_port;
>> +	}
> 
> [Severity: Medium]
> Source-mode devices are now allowed on a passthru port, so the passthru
> device no longer gets all traffic on the lower device. Are there places
> outside macvlan.c that still assume it does?
> 
> In drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c,
> mlx5e_rep_check_indr_block_supported() offloads tc ingress filters bound
> to a macvlan onto the real lower representor whenever this returns true:
> 
> mlx5e_rep_macvlan_mode_supported() {
> 	...
> 	return macvlan->mode == MACVLAN_MODE_PASSTHRU;
> }
> 
> In software, macvlan_handle_frame() calls macvlan_forward_source() before
> the passthru lookup. With MACVLAN_FLAG_NODST, known-sender frames are
> consumed there and never reach the passthru device.
> 
> A hardware filter installed for the passthru macvlan could still match
> frames entering the representor, including the inter-SoC ones. It could
> then drop or redirect them before the source devices see them. I could
> not confirm from the mlx5 flow steering code that the offloaded rule
> matches every packet from the vport. If it does, hardware and software
> would behave differently here. Is that a concern?

Hmm, I didn't consider HW offloading. Offloading should probably be
avoided in this configuration. But drivers would probably need some
assistance here.

Do you have an opinion how to deal best with this?

> 
> Also, the uAPI comment in include/uapi/linux/if_link.h still says:
> 
> 	MACVLAN_MODE_PASSTHRU = 8,/* take over the underlying device */
> 
> Should that be updated as well?

Good idea.

> 
> [ ... ]
> 
>> @@ -1652,19 +1682,23 @@ static int macvlan_changelink(struct net_device *dev,
>>  	if (data && data[IFLA_MACVLAN_MODE]) {
>>  		set_mode = true;
>>  		mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
>> -		/* Passthrough mode can't be set or cleared dynamically */
>> -		if ((mode == MACVLAN_MODE_PASSTHRU) !=
>> -		    (vlan->mode == MACVLAN_MODE_PASSTHRU))
>> -			return -EINVAL;
>> -		if (vlan->mode == MACVLAN_MODE_SOURCE &&
>> -		    vlan->mode != mode)
>> -			macvlan_flush_sources(vlan->port, vlan);
>> +		if (mode != vlan->mode) {
>> +			/* Passthrough mode can't be set or cleared dynamically,
>> +			 * regardless of existing source interfaces. Furthermore, source
>> +			 * interfaces can't switch modes within a passhtrough port.
>> +			 */
>> +			if (mode == MACVLAN_MODE_PASSTHRU ||
>> +			    macvlan_passthru(vlan->port))
>> +				return -EINVAL;
> 
> [Severity: Low]
> This adds a new restriction: while the port is in passthru, any mode
> change of a source-mode device returns -EINVAL. The commit message does
> not mention this or a few other user-visible changes:
> 
> - The lower MAC restore moved from macvlan_port_destroy() to
>   macvlan_uninit() of the passthru device. It now runs even while source
>   devices stay on the port.
> 
> - macvlan_forward_source() only consumes the frame when
>   MACVLAN_FLAG_NODST is set. Without it, known-sender frames are cloned to
>   the source device and also delivered to the passthru device.
> 
> The commit message says:
> 
>   "The source mode devices represent the known senders while
>   all external senders terminate on passthru device."
> 
> That split seems to depend on NODST being set.
> 
> Documentation/networking/device_drivers/ethernet/intel/ice.rst also still
> says:
> 
>   "In passthru mode, you can only set up one MACVLAN device."
> 
> Could the commit message and that document be updated to describe these
> changes?


Okay.

> 
>> +			if (vlan->mode == MACVLAN_MODE_SOURCE)
>> +				macvlan_flush_sources(vlan->port, vlan);
>> +		}
>>  	}
>>  
>>  	if (data && data[IFLA_MACVLAN_FLAGS]) {
>>  		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>>  		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
>> -		if (macvlan_passthru(vlan->port) && promisc) {
>> +		if (vlan->mode == MACVLAN_MODE_PASSTHRU && promisc) {
>>  			int err;
>>  
>>  			if (flags & MACVLAN_FLAG_NOPROMISC)
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch.
> macvlan_changelink() changes the lower device's promiscuity count whenever
> MACVLAN_FLAG_NOPROMISC flips on the passthru device. It does not check
> dev->flags & IFF_UP. macvlan_open() and macvlan_stop() only take or drop
> that reference while the device is up.
> 
> Setting nopromisc on a passthru device that is down calls
> dev_set_promiscuity(lowerdev, -1) with no matching +1. That either drops a
> reference owned by another user, or wraps dev->promiscuity from 0 in
> __dev_set_promiscuity() and leaves IFF_PROMISC set. Clearing nopromisc
> while down takes a +1 that is never released.
> 
> Should this be gated on IFF_UP? For the passthru device, the patch's
> change from macvlan_passthru(vlan->port) to
> vlan->mode == MACVLAN_MODE_PASSTHRU is equivalent, so the behavior is
> unchanged.
> 
> [ ... ]

Do you want me to send a fix for this in a separate thread?

Best regards


-- 
Thomas Martitz <t.martitz@fritz.com>
FRITZ! Technology GmbH, Berlin (Germany)
