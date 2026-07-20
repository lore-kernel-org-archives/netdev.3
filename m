Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496C437871;
	Mon, 20 Jul 2026 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562735; cv=none; b=uQV19wLsgH4a0XtDJphJs1IeSlfuYH6kAjnxHoLjvlD7Hqc1k4lJncH0dXDK+umVK00+3Fsxcp4ZgrTuMjI3wmRLzDjUAjwbSt4ny5TZKOhEqkaSBUIzIgF0XOwntjmdN/uSG/8tPtvpfF7YDGSFbdgaG7h6e7gMX57dRqs9MQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562735; c=relaxed/simple;
	bh=z7duEXev4BeJts1N8N5j8ORe5MGARFm4Br3XDAxzKTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnjRc14diNSRA4W01dO1K/TZeEDJviuPPst29EpOavLOAPr47P9MbyBlVCFHJ1jGQ12QjYhqnzD6NxGDj54YFS8R5bSj1Q/YWSnUXfxvWRVuPb/rQo8nAlE4PAYDsXDLFGCpCvedlSjzFI6g+3HQYMaTX5GqxyWktvnqznR50PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5eHLBhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5eHLBhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B511F00A3A;
	Mon, 20 Jul 2026 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562734;
	bh=eMdCD4co6SAqVSvd9e/VRRqocIVxpd+B/tKA9ZH5TQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5eHLBhld/y7I/8Z985913VppILeYBqFRkjCuCO9TIfXW39VB2yQQmiHfxvECUVVX
	 ZnVXQb5zgzgh1WDf9oALVxN1E2RYtTwKiR9RUN3RJl0WkawbvldURlrygg5BDsNVko
	 YBH3tyyAz5d+fJ3JKCfcP/sP/ekZsTIVWG3kWBXBZYSmUwjRg96QBcp66TFZ4ervAB
	 LcIjpFHj1pIm1wzyha8SdXOS0JlBYjoxSFF4OaKA5OhxKl2+VIOvEL3pRTIrzk9d39
	 EQOTte2JbQ97vNi4mEciSYtSUaHhkNq6ZD8foLtJe3dC3sfqHKSxk0QYL8KNwo8MMe
	 HaHd3VIIvlTcA==
From: Simon Horman <horms@kernel.org>
To: t.martitz@fritz.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] macvlan: allow source mode devices along with passthru
Date: Mon, 20 Jul 2026 16:49:22 +0100
Message-ID: <20260720154921.222504-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713112414.2842803-2-t.martitz@fritz.com>
References: <20260713112414.2842803-2-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260713112414.2842803-2-t.martitz@fritz.com?part=1
---
macvlan: allow source mode devices along with passthru

This change permits combining one passthru macvlan with one or more
source-mode macvlans on the same lower device, so that an rx_handler can
be attached to the passthru device while source-mode devices continue to
represent known senders.

> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index c40fa331836b..635ed01abeb6 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c

[ ... ]

> @@ -964,6 +969,21 @@ static int macvlan_init(struct net_device *dev)
>  	return 0;
>  }
>  
> +static void macvlan_restore_mac(struct macvlan_port *port)
> +{
> +	/* If the lower device address has been changed by passthru
> +	 * macvlan, put it back.
> +	 */
> +	if (macvlan_passthru(port) &&
> +	    !ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
> +		struct sockaddr_storage ss;
> +
> +		ss.ss_family = port->dev->type;
> +		memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
> +		dev_set_mac_address(port->dev, &ss, NULL);
> +	}
> +}
> +
>  static void macvlan_uninit(struct net_device *dev)
>  {
>  	struct macvlan_dev *vlan = netdev_priv(dev);
> @@ -973,8 +993,19 @@ static void macvlan_uninit(struct net_device *dev)
>  
>  	macvlan_flush_sources(port, vlan);
>  	port->count -= 1;
> -	if (!port->count)
> -		macvlan_port_destroy(port->dev);
> +	if (port->count) {
> +		/* In case of remaining source interfaces undo
> +		 * passthru-specific properties.
> +		 */
> +		if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
> +			/* Order is important, do not trigger macvlan_device_event(). */
> +			macvlan_clear_passthru(port);
> +			macvlan_restore_mac(port);

[High]
When the last passthru macvlan is removed while source-mode siblings
remain, does macvlan_restore_mac() actually restore the lower device's
MAC in this ordering?

macvlan_clear_passthru() is called first, which drops MACVLAN_F_PASSTHRU:

    static inline void macvlan_clear_passthru(struct macvlan_port *port)
    {
        port->flags &= ~MACVLAN_F_PASSTHRU;
    }

Then macvlan_restore_mac() runs, but its body is gated on
macvlan_passthru(port):

    static void macvlan_restore_mac(struct macvlan_port *port)
    {
        if (macvlan_passthru(port) &&
            !ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
            ...
            dev_set_mac_address(port->dev, &ss, NULL);
        }
    }

Since the flag has just been cleared, does the guard evaluate to false
here, causing dev_set_mac_address() to be skipped and the lower device
to retain the passthru MAC instead of port->perm_addr?

The pre-patch macvlan_port_destroy() path did not clear the flag first,
so the restore actually took effect there.

>  		}
> +		return;
> +	}
> +
> +	macvlan_port_destroy(port->dev);
>  }
>  
>  static void macvlan_dev_get_stats64(struct net_device *dev,

[ ... ]

> @@ -1623,19 +1659,23 @@ static int macvlan_changelink(struct net_device *dev,
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
> +			if (vlan->mode == MACVLAN_MODE_PASSTHRU ||
> +			    macvlan_passthru(vlan->port))
> +				return -EINVAL;
> +			if (vlan->mode == MACVLAN_MODE_SOURCE)
> +				macvlan_flush_sources(vlan->port, vlan);
> +		}
>  	}

[High]
Does this new check still reject setting an existing non-passthru vlan
to MACVLAN_MODE_PASSTHRU when the port has no passthru vlan yet?

The comment still says "Passthrough mode can't be set or cleared
dynamically", but the condition:

    if (vlan->mode == MACVLAN_MODE_PASSTHRU ||
        macvlan_passthru(vlan->port))
        return -EINVAL;

only catches clearing passthru on a passthru vlan, and any mode change
on a vlan whose port already has passthru.

If vlan->mode is one of VEPA/BRIDGE/PRIVATE/SOURCE and the request is
mode == MACVLAN_MODE_PASSTHRU on a port that has no passthru vlan yet,
does execution fall through? Later in the same function:

    if (set_mode)
        vlan->mode = mode;

promotes vlan->mode to PASSTHRU, but nothing calls
macvlan_set_passthru(port), nothing performs eth_hw_addr_inherit(dev,
lowerdev), and no passthru promiscuity accounting is done.

After this, does the vlan report mode == PASSTHRU while the port flag
MACVLAN_F_PASSTHRU stays clear? Downstream code splits between the two
predicates:

  - macvlan_open, macvlan_stop, macvlan_fdb_add, macvlan_fdb_del, and
    the IFLA_MACVLAN_FLAGS branch here read vlan->mode ==
    MACVLAN_MODE_PASSTHRU.

  - macvlan_device_event NETDEV_CHANGEADDR, macvlan_addr_busy,
    macvlan_change_rx_flags, macvlan_sync_address and
    macvlan_handle_frame read macvlan_passthru(port).

Does this then produce visible symptoms such as:

  - macvlan_open calling dev_set_promiscuity(lowerdev, 1) while the
    lower device's MAC was never inherited to the vlan;
  - macvlan_addr_busy no longer treating the port as passthru, allowing
    a sibling with the lowerdev's address;
  - macvlan_handle_frame not delivering to this vlan via
    list_first_or_null_rcu(&port->vlans) because the port flag is
    clear?

Would a condition that also rejects the direction into passthru be more
consistent with the comment, e.g.:

    if (vlan->mode == MACVLAN_MODE_PASSTHRU ||
        mode == MACVLAN_MODE_PASSTHRU ||
        macvlan_passthru(vlan->port))
        return -EINVAL;

>  
>  	if (data && data[IFLA_MACVLAN_FLAGS]) {
>  		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>  		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
> -		if (macvlan_passthru(vlan->port) && promisc) {
> +		if (vlan->mode == MACVLAN_MODE_PASSTHRU && promisc) {
>  			int err;
>  
>  			if (flags & MACVLAN_FLAG_NOPROMISC)
