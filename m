Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F0287247;
	Wed,  7 Oct 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392140; cv=none; b=nK/Dlqi+U43PT+3LQzNcvpnfCP+opkZrkj6XV4X9oQdMCFi1lY1z3nIRnbv0d7BnPchU/Itr+79xnck4sJ1k+Q/669YAJWh6q5uFOC9WAeW/BAMB/Bi6jFh0vF5edH8Nmb2K/brzJK3yvRgLVpKSTTT+VlKjUX+Fg24roncSXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392140; c=relaxed/simple;
	bh=FDB+npaB7MhQozd7hd7WmSU1Tnruwbn+5BFVrdFZ950=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfyesdQBoaO/ej9WmC0pnri4pGbalRSt+nwH7sTswN5BNuEuLUkgNHLHcz3ZU9r0GE4rhKU4gu3Et4VRM9Z+nO3JqiXJMNuIZdFXGvsejJLNlsaQTJaTAy2nDE81/nwtWehcrr1btKZh/r5oDMJlMLnXeA9L27MskxYzrIJISIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=NpNzSqOa; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="NpNzSqOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1791392116; bh=FDB+npaB7MhQozd7hd7WmSU1Tnruwbn+5BFVrdFZ950=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NpNzSqOaMvIU/3oijVwXPJmQ/8v+SeOZnkQRLDbiXGKmdHhL31fRnWzwpCc/bfwfr
	 1JV2PCNwi+fDTC1Y6VnfUUl2JEx09XScHigXvXNuFBDrXbZYYbFtPpzuKh8r2OLWxB
	 iJQ8T2NXk6C8NnpIS5TZIPr4HtgE9Gv1YirPL4LWft6z52oQJYR6lLaRLQynII3hOO
	 v6tPZdzQ2XDT01CkvRJZ3xl2rgsR7PR/aWAXFyi4ezfHa2EU27r5kebY8ROKd6Ia0r
	 +vANOJJ5WoXPCyAT8lcVZipovnafy9tjHgRRxkaaTTPuzssYQRSHZTyd+8GZoIPghQ
	 deS1MyS4aYUJg==
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6ac67974-23c8-7f0000032729-7f0000019184-1
	for <multiple-recipients>; Wed, 07 Oct 2026 18:55:16 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 18:55:16 +0200 (CEST)
Message-ID: <f9780706-f0e5-41e6-b206-af0a5873aa88@fritz.com>
Date: Wed, 7 Oct 2026 18:55:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/1] macvlan: allow source mode devices along with
 passthru
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917101044.2654867-1-t.martitz@fritz.com>
 <20260921092359.91614-1-horms@kernel.org>
Content-Language: de-DE
From: Thomas Martitz <t.martitz@fritz.com>
In-Reply-To: <20260921092359.91614-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate-ID: 149429::1791392116-19FC3FA4-9C6B6684/0/0
X-purgate-type: clean
X-purgate-size: 19535
X-Notice: Whitelisted
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-03  mail-id: 9F25DA008E  external: no

Hello,

I took a few free slots during LPC 2026 to address
the concerns raised by AI review, almost all of which were
valid.

I also expanded my local test suite to catch all of these.

I'll post v6 in shortly.

m 21.09.26 um 11:23 schrieb Simon Horman:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917101044.2654867-1-t.martitz@fritz.com?part=1
> ---
> macvlan: allow source mode devices along with passthru
> 
> This allows one passthru macvlan to coexist with source mode macvlans on
> the same lower device, by converting several per-device decisions from the
> port wide MACVLAN_F_PASSTHRU flag to vlan->mode and by moving the lower
> device MAC restore from macvlan_port_destroy() into macvlan_uninit().
> 
> A few questions about the conversion below.
> 
>> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
>> index afad90b9222a2..76c11e5260334 100644
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
>>  static inline bool macvlan_addr_change(const struct macvlan_port *port)
>>  {
>>  	return port->flags & MACVLAN_F_ADDRCHANGE;
>> @@ -217,8 +222,7 @@ static bool macvlan_addr_busy(const struct macvlan_port *port,
>>  	 * currently in use by the underlying device or
>>  	 * another macvlan.
>>  	 */
>> -	if (!macvlan_passthru(port) && !macvlan_addr_change(port) &&
>> -	    ether_addr_equal_64bits(port->dev->dev_addr, addr))
>> +	if (ether_addr_equal_64bits(port->dev->dev_addr, addr))
>>  		return true;
>>  
>>  	if (macvlan_hash_lookup(port, addr))
>> @@ -637,7 +641,7 @@ static int macvlan_open(struct net_device *dev)
>>  	struct net_device *lowerdev = vlan->lowerdev;
>>  	int err;
>>  
>> -	if (macvlan_passthru(vlan->port)) {
>> +	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
>>  		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC)) {
>>  			err = dev_set_promiscuity(lowerdev, 1);
>>  			if (err < 0)
> 
> [Severity: High]
> 
> macvlan_open() and macvlan_stop() are converted to the per-device
> vlan->mode test here, but macvlan_change_rx_flags() still keys off the
> port flag:
> 
> drivers/net/macvlan.c:macvlan_change_rx_flags() {
> 	if (dev->flags & IFF_UP) {
> 		if (change & IFF_ALLMULTI)
> 			dev_set_allmulti(lowerdev, dev->flags & IFF_ALLMULTI ? 1 : -1);
> 		if (!macvlan_passthru(vlan->port) && change & IFF_PROMISC)
> 			dev_set_promiscuity(lowerdev,
> 					    dev->flags & IFF_PROMISC ? 1 : -1);
> 	}
> }
> 
> Once a passthru device exists the port flag is set for every sibling, so
> live IFF_PROMISC transitions of a source mode macvlan are dropped, while
> macvlan_open() and macvlan_stop() still take and release the lower device
> promiscuity reference based on dev->flags.
> 
> Can this unbalance lowerdev->promiscuity?
> 
>   ip link add pt link eth0 type macvlan mode passthru
>   ip link add src0 link eth0 type macvlan mode source
>   ip link set src0 promisc on
>   ip link set src0 up	  macvlan_open() -> dev_set_promiscuity(lowerdev, 1)
>   ip link set src0 promisc off	  macvlan_change_rx_flags() skips the -1
>   ip link set src0 down	  macvlan_stop() sees IFF_PROMISC clear, no -1
> 
> That leaks a +1 on the physical device. The reverse order (up without
> promisc, promisc on while up, then down) issues an unmatched
> dev_set_promiscuity(lowerdev, -1), and __dev_set_promiscuity() computes
> 0 + (-1) as 0xFFFFFFFF, takes the "flags = old_flags | IFF_PROMISC"
> branch and returns 0, so the device stays pinned promiscuous with no
> error reported. If the passthru device held the only reference, the count
> instead reaches 0, IFF_PROMISC is cleared and the hardware filter is
> reprogrammed while the passthru macvlan still needs it.
> 
> Before this patch a passthru port could hold no other device, so the port
> wide test in macvlan_change_rx_flags() was equivalent to the per-device
> one. Should that call site be converted too?

Makes sense, I'll follow up with that change.

> 
>> @@ -712,7 +716,7 @@ static int macvlan_stop(struct net_device *dev)
>>  	dev_uc_unsync(lowerdev, dev);
>>  	dev_mc_unsync(lowerdev, dev);
>>  
>> -	if (macvlan_passthru(vlan->port)) {
>> +	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
>>  		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
>>  			dev_set_promiscuity(lowerdev, -1);
>>  		goto hash_del;
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
>>  
>> -		if (!macvlan_passthru(port)) {
>>  			err = dev_uc_add(lowerdev, addr);
>>  			if (err)
>>  				return err;
> 
> [Severity: Medium]
> 
> The macvlan_addr_busy() call used to run for the passthru device as well,
> and its macvlan_hash_lookup() half caught collisions with siblings on the
> same port. Moving it inside "if (!passthru_dev)" drops that check for the
> passthru device.
> 
> Can a passthru device now take the address of a live source mode sibling?
> macvlan_set_mac_address() returns before its own busy check:
> 
> drivers/net/macvlan.c:macvlan_set_mac_address() {
> 	if (READ_ONCE(vlan->mode) == MACVLAN_MODE_PASSTHRU) {
> 		macvlan_set_addr_change(vlan->port);
> 		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
> 	}
> 
> 	if (macvlan_addr_busy(vlan->port, addr->__data))
> 		return -EADDRINUSE;
> 
> so with pt (passthru) and src0 (source) both up, "ip link set pt address
> <src0 mac>" reprograms the lower device and comes back through
> macvlan_device_event() -> macvlan_sync_address() with passthru_dev true,
> where nothing validates it anymore.
> 
> Both macvlans then end up hashed under the same address, and src0 can no
> longer be brought up because macvlan_addr_busy() now compares against
> port->dev->dev_addr unconditionally:

I'll move the macvlan_addr_busy() check in macvlan_set_mac_address() up 
so that passthru devices are covered as well. That should catch if 
a passthru interface (and consequently the lower device) is assigned the same
mac as one of the existing source interfaces.


> 
> drivers/net/macvlan.c:macvlan_open() {
> 	err = -EADDRINUSE;
> 	if (macvlan_addr_busy(vlan->port, dev->dev_addr))
> 		goto out;
> 
>> @@ -757,7 +762,7 @@ static int macvlan_sync_address(struct net_device *dev,
>>  
>>  		macvlan_hash_change_addr(vlan, addr);
>>  	}
>> -	if (macvlan_passthru(port) && !macvlan_addr_change(port)) {
>> +	if (passthru_dev && !macvlan_addr_change(port)) {
>>  		/* Since addr_change isn't set, we are here due to lower
>>  		 * device change.  Save the lower-dev address so we can
>>  		 * restore it later.
>> @@ -979,7 +984,26 @@ static void macvlan_uninit(struct net_device *dev)
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
>> +		if(!ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
>> +			struct sockaddr_storage ss;
>> +
>> +			ss.ss_family = port->dev->type;
>> +			memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
>> +			dev_set_mac_address(port->dev, &ss, NULL);
>> +		}
>> +		macvlan_clear_passthru(port);
>> +	}
>> +
>> +	if (port->count == 0)
>>  		macvlan_port_destroy(port->dev);
>>  }
> 
> [Severity: High]
> 
> The restore now runs at passthru device lifetime, but the matching save
> into port->perm_addr is still done once at port creation:
> 
> drivers/net/macvlan.c:macvlan_port_create() {
> 	ether_addr_copy(port->perm_addr, dev->dev_addr);
> 
> and it is only refreshed while a passthru device already exists:
> 
> drivers/net/macvlan.c:macvlan_device_event() {
> 	case NETDEV_CHANGEADDR:
> 		if (!macvlan_passthru(port))
> 			return NOTIFY_DONE;
> 
> Since a port can now be created by, and outlive, source mode only devices,
> can this write a stale address onto the lower device?
> 
>   ip link add src0 link eth0 type macvlan mode source
> 	  macvlan_port_create() saves eth0 mac A into port->perm_addr
>   ip link set eth0 address B
> 	  macvlan_device_event() returns NOTIFY_DONE, perm_addr stays A
>   ip link add pt link eth0 type macvlan mode passthru
> 	  accepted now, eth_hw_addr_inherit() gives pt mac B
>   ip link del pt
> 	  macvlan_uninit() sees B != A and sets eth0 back to A
> 
> eth0 ends up with an address the macvlan never installed. Should
> port->perm_addr be re-captured next to the eth_hw_addr_inherit() call in
> macvlan_common_newlink() when the passthru device is created?

The suggestion is spot-on, I think. I came to the same conclusion.

Actually the remembering the lowerdev mac in port->perm_addr
can be moved as it's only needed once there is a passthru interface,
and never for regular vepa/source/bridge combinations.

> 
> Two related questions on the same block:
> 
> macvlan_uninit() is also reached from the register_netdevice() and
> netdev_upper_dev_link() failure paths in macvlan_common_newlink(), for a
> passthru device that never touched the lower MAC. Does the restore fire
> there too?

With the above change the the MAC addresses are in sync within
macvlan_common_newlink().

> 
> macvlan_clear_passthru() clears MACVLAN_F_PASSTHRU but not
> MACVLAN_F_ADDRCHANGE. In a port that now survives the passthru device, can
> a stale addr change bit be observed by the next passthru device created on
> that port?

The MACVLAN_F_ADDRCHANGE is cleared eagerly by macvlan_sync_address().
It is only set during the chain
set_mac_address(passthrough, addr)
-> dev_set_mac_address(lowerdev, addr)
-> macvlan_device_event()
-> macvlan_sync_address()

It is always clear in macvlan_unit().


> 
> [Severity: Low]
> 
> These are not bugs, but checkpatch will complain about a few things
> introduced here:
> 
>   if(!ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
> 
> missing space after if.
> 
> In macvlan_sync_address() the return is indented by two extra tabs:
> 
> 		if (macvlan_addr_busy(vlan->port, addr))
> 				return -EADDRINUSE;
> 
> In macvlan_common_newlink() the if branch has braces and the else branch
> does not. There is also a typo, "passhtrough", in the new
> macvlan_changelink() comment, and some of the new comment lines run past
> 80 columns.
> 

Will be fixed.

> [ ... ]
> 
>> @@ -1310,18 +1334,6 @@ static void macvlan_port_destroy(struct net_device *dev)
>>  		kfree_skb(skb);
>>  	}
>>  
>> -	/* If the lower device address has been changed by passthru
>> -	 * macvlan, put it back.
>> -	 */
>> -	if (macvlan_passthru(port) &&
>> -	    !ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
>> -		struct sockaddr_storage ss;
>> -
>> -		ss.ss_family = port->dev->type;
>> -		memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
>> -		dev_set_mac_address(port->dev, &ss, NULL);
>> -	}
>> -
>>  	kfree(port);
>>  }
>>  
>> @@ -1523,15 +1535,6 @@ int macvlan_common_newlink(struct net_device *dev,
>>  	}
>>  	port = macvlan_port_get_rtnl(lowerdev);
>>  
>> -	/* Only 1 macvlan device can be created in passthru mode */
>> -	if (macvlan_passthru(port)) {
>> -		/* The macvlan port must be not created this time,
>> -		 * still goto destroy_macvlan_port for readability.
>> -		 */
>> -		err = -EINVAL;
>> -		goto destroy_macvlan_port;
>> -	}
>> -
>>  	vlan->lowerdev = lowerdev;
>>  	vlan->dev      = dev;
>>  	vlan->port     = port;
>> @@ -1544,12 +1547,31 @@ int macvlan_common_newlink(struct net_device *dev,
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
>> +
>> +	/* Now check if adding a passthru device to an existing set of source mode
>> +	 * devices.
>> +	 */
>>  	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
>> -		if (port->count) {
>> -			err = -EINVAL;
>> -			goto destroy_macvlan_port;
>> +		struct macvlan_dev *p;
>> +
>> +		list_for_each_entry(p, &port->vlans, list) {
>> +			if (p->mode != MACVLAN_MODE_SOURCE) {
>> +				err = -EINVAL;
>> +				goto destroy_macvlan_port;
>> +			}
>>  		}
>> -		macvlan_set_passthru(port);
>>  		eth_hw_addr_inherit(dev, lowerdev);
>>  	}
>>  
>> @@ -1581,7 +1603,12 @@ int macvlan_common_newlink(struct net_device *dev,
>>  	if (err)
>>  		goto unregister_netdev;
>>  
>> -	list_add_tail_rcu(&vlan->list, &port->vlans);
>> +	/* macvlan_handle_frame expects the (one and only) passthru device first. */
>> +	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
>> +		macvlan_set_passthru(port);
>> +		list_add_rcu(&vlan->list, &port->vlans);
>> +	} else
>> +		list_add_tail_rcu(&vlan->list, &port->vlans);
> 
> [Severity: Low]
> 
> This isn't a bug as far as I can tell, but the ordering here is the
> reverse of initialise-then-publish: macvlan_set_passthru() makes
> macvlan_handle_frame() take the passthru branch before the device is on
> port->vlans. On teardown the mirror window exists too, since
> macvlan_dellink() does list_del_rcu() while the flag is only cleared later
> in macvlan_uninit().
> 
> I could not find a functional consequence, because the reader bails out in
> both windows:
> 
> drivers/net/macvlan.c:macvlan_handle_frame() {
> 	if (macvlan_passthru(port))
> 		vlan = list_first_or_null_rcu(&port->vlans,
> 					      struct macvlan_dev, list);
> 	else
> 		vlan = macvlan_hash_lookup(port, eth->h_dest);
> 	if (!vlan || READ_ONCE(vlan->mode) == MACVLAN_MODE_SOURCE)
> 		return RX_HANDLER_PASS;
> 
> and rtnl is held across register_netdevice() and this list_add_rcu(), so
> the device cannot be up in the creation window. Would publishing the list
> entry before setting the flag, and using READ_ONCE()/WRITE_ONCE() on
> port->flags which macvlan_handle_frame() reads from softirq context, be
> preferable anyway?
> 
>>  	update_port_bc_queue_len(vlan->port);
>>  	netif_stacked_transfer_operstate(lowerdev, dev);
>>  	linkwatch_fire_event(dev);
>> @@ -1652,19 +1679,23 @@ static int macvlan_changelink(struct net_device *dev,
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
>> +			if (vlan->mode == MACVLAN_MODE_PASSTHRU ||
>> +			    macvlan_passthru(vlan->port))
>> +				return -EINVAL;
>> +			if (vlan->mode == MACVLAN_MODE_SOURCE)
>> +				macvlan_flush_sources(vlan->port, vlan);
>> +		}
>>  	}

I think the change makes sense anyway, to ensure
the passthru interface is first in the list once the passthru
flag is set port-wide.


> 
> [Severity: High]
> 
> The old condition rejected both directions of a passthru transition. The
> new one only rejects leaving passthru (vlan->mode == MACVLAN_MODE_PASSTHRU)
> and any mode change inside an already-passthru port
> (macvlan_passthru(vlan->port)). On a port that has no passthru device, is
> switching a device into passthru still rejected?
> 
>   ip link add m0 link eth0 type macvlan mode vepa
>   ip link set m0 up
>   ip link set m0 type macvlan mode passthru
> 
> macvlan_validate() accepts MACVLAN_MODE_PASSTHRU, neither arm of the new
> test matches, and the tail of macvlan_changelink() commits it:
> 
> 	if (set_mode)
> 		WRITE_ONCE(vlan->mode, mode);
> 
> MACVLAN_F_PASSTHRU is never set and the device is never moved to the list
> head, so the comment right above the check ("Passthrough mode can't be set
> or cleared dynamically") and the invariant documented at the list_add_rcu()
> above no longer hold. Since this patch keys the per-device paths off
> vlan->mode, that device now behaves as passthru where it matters:
> 
>   ip link set m0 address <x>	macvlan_set_mac_address() takes the
> 				passthru branch and calls
> 				dev_set_mac_address(vlan->lowerdev, ...)
> 
> IFLA_MACVLAN_MODE has no rtnl_dev_link_net_capable() check on the lower
> device netns, unlike IFLA_MACVLAN_BC_QUEUE_LEN and IFLA_MACVLAN_BC_CUTOFF,
> and netif_set_mac_address() performs no namespace capability check, so can
> CAP_NET_ADMIN in the netns owning a delegated macvlan rewrite the lower
> device MAC this way?
> 
>   ip link set m0 down		macvlan_stop() takes the passthru branch,
> 				skipping dev_uc_del() and the allmulti
> 				release, and issues an unmatched
> 				dev_set_promiscuity(lowerdev, -1)
> 
> macvlan_uninit() would then also rewrite the lower MAC from
> port->perm_addr, and macvlan_fdb_add()/macvlan_fdb_del() start accepting
> unicast filters. Meanwhile macvlan_handle_frame() still uses the hash path
> because the port flag stayed clear, so the device reports passthru but does
> not receive as passthru.
> 
> Should the "mode == MACVLAN_MODE_PASSTHRU" half of the old test be kept?
> 

Yes, indeed.


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
> [ ... ]


-- 
Thomas Martitz <t.martitz@fritz.com>
FRITZ! Technology GmbH, Berlin (Germany)
