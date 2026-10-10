Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BB31A556;
	Sat, 10 Oct 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624545; cv=none; b=gOEUl2UJ2y/CzRnqYje8EQaKGaginfSTvL6cZ7EPzfMU1IxlFyYhTbHELCGo283EPvdeFCYJGl+afus4jJosY7YYJN/ydKMgkxAmXo48aA0iCRO+hVfEs2nG+gzuGtzLsFboEn1OdVOFCvZwYZlbzG5/JrwlC5s/QTSdxiH95Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624545; c=relaxed/simple;
	bh=tyRu8FyRGW1S8C1uZMarnFX6oo7y0QTH1fHLS/pKG34=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bs2d/e26u8vN7wJ7TtcDNypU1TBgGuRaY+XJ7mf90Ja+A1SNX9it3HJRRc0D0o13IqDuuiNbUTRL+8/csI5pDXlssx5MwzTpU8Reyo7w1asJExNlDdfpwul3JkPsbgptsRa72N1OF1Jjrd/HXNeq6D+oTLAsVtQg6bS6v8sTkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzH6sS9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzH6sS9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D25B1F000FF;
	Sat, 10 Oct 2026 09:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791624543;
	bh=+7sgw5bnJ8g9rt/+cdapmcA0Dsoypu7snhxMqWzq1T8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZzH6sS9T1F/6GhdXvjazaof7d9etWLuLejm4ZpHrhwbcjbe0Ofn/1pXQQbm3Ue8zW
	 VlUHUjfIE7YTYdWQl23U1H3tDPXDhDgy0C/R1Ysj6Mr3TyV/xquztAm4ey4stuqMRY
	 +NjMcTW0wlRbm/WhRBRL2yuUulSsUzjJB79TzO1uGWHoAY/GoMAxr28BiJymJ3tzL0
	 sr0TLh2z1fEi5K8qghooJgvS5hladFRvmpylWs6kwiVZftuYpq0MvUAYhruvVpkSg8
	 2FCCq5Lusprb11ATZumrsjD47tMlF+rOQZKJYM71jEYM3TN6XUEogmSdHN0yjT/WZK
	 clS2RpTqBlmAA==
Subject: Re: [PATCH net-next v3 1/8] net: qualcomm: rmnet: Update MTU handling
 during format changes
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 sean.tranchetti@oss.qualcomm.com
Date: Sat, 10 Oct 2026 09:29:02 +0000
Message-ID: <179162454252.434549.16646515877983773959@kernel.org>
In-Reply-To:
 <20261009084351.317632-2-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261009084351.317632-2-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] rmnet_vnd_headroom(u32 data_format) in rmnet_vnd.c checks only
  RMNET_FLAGS_EGRESS_MAP_CKSUMV4.
- [Medium] rmnet_vnd_update_dev_mtu()
  (drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c) now returns -EINVAL…
- [Medium] rmnet_vnd_update_dev_mtu() shrinks registered endpoint devices
  with a bare `WRITE_ONCE(ep->egress_dev->mtu, new_mtu)`…
- [Low] The patch fixes a user-visible MTU bug, but the commit message
  calls it an 'update' and there is no Fixes: tag.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  rmnet_vnd_validate_mtu() (rmnet_vnd.c:399) computes `real_dev->mtu -…

--

net: qualcomm: rmnet: Update MTU handling during format changes

When an rmnet device is created, this patch computes the MTU headroom
from the requested data format. On newlink or changelink, it shrinks
existing endpoint MTUs when the new format needs more headroom. The new
shared data format is published only after the MTUs have been updated.

> Calculate the MTU headroom from the requested data format when creating
> an rmnet device. Resize existing endpoint MTUs when a newlink or changelink
> requests a format that requires a smaller MTU.

[Severity: Low]
This looks like a bug fix, but the commit message describes it as an update.

Before this patch, rmnet_newlink() called rmnet_vnd_newlink() before it
applied IFLA_RMNET_FLAGS. For the first device on a port, the headroom
therefore came from port->data_format == 0, which gives 4 bytes.

A device created with RMNET_FLAGS_EGRESS_MAP_CKSUMV4 got an MTU of
real_dev->mtu - 4 instead of real_dev->mtu - 8. Its egress frames were
then 4 bytes larger than the real device MTU.

Should the commit message describe that symptom and carry a tag like this?

Fixes: b7f5eb6ba21b ("net: qualcomm: rmnet: Update rmnet device MTU based on real device")

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index 5f921cddf82b4..d23f74b0aa471 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> @@ -66,27 +66,25 @@ static netdev_tx_t rmnet_vnd_start_xmit(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  }
>  
> -static int rmnet_vnd_headroom(struct rmnet_port *port)
> +static int rmnet_vnd_headroom(u32 data_format)
>  {
>  	u32 headroom;
>  
>  	headroom = sizeof(struct rmnet_map_header);
>  
> -	if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
> +	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4)
>  		headroom += sizeof(struct rmnet_map_ul_csum_header);
>  
>  	return headroom;
>  }

[Severity: High]
Should this headroom calculation also handle
RMNET_FLAGS_EGRESS_MAP_CKSUMV5?

rmnet_map_egress_handler() in rmnet_handlers.c reserves room for the V5
header:

	} else if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
		additional_header_len = sizeof(struct rmnet_map_v5_csum_header);
		csum_type = RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
	}

rmnet_map_v5_checksum_uplink_packet() always skb_push()es that header.
The 4 byte MAP header is added after it.

With egress MAPv5, rmnet_vnd_headroom() returns 4 instead of 8. So
rmnet_vnd_newlink() sets the default MTU to real_dev->mtu - 4, and
full-size uplink frames are 4 bytes larger than the real device MTU.

For the same reason, rmnet_vnd_update_dev_mtu() does not shrink existing
endpoints when a newlink or changelink switches to egress MAPv5.

The commit message says MTUs are resized "when a newlink or changelink
requests a format that requires a smaller MTU". Isn't egress MAPv5 one of
those formats? The later patches in the series don't seem to change
rmnet_vnd_headroom() either.

[ ... ]

> @@ -375,17 +385,15 @@ int rmnet_vnd_do_flow_control(struct net_device *rmnet_dev, int enable)
>  	return 0;
>  }
>  
> -int rmnet_vnd_validate_real_dev_mtu(struct net_device *real_dev)
> +static int rmnet_vnd_validate_mtu(struct rmnet_port *port,
> +				  struct net_device *real_dev, u32 data_format)
>  {

[ ... ]

> -	headroom = rmnet_vnd_headroom(port);
> +	headroom = rmnet_vnd_headroom(data_format);
>  
>  	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
>  		if (ep->egress_dev->mtu > (real_dev->mtu - headroom))

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
can real_dev->mtu - headroom wrap here?

Both operands are unsigned. dummy has min_mtu = 0, so its MTU can be set
below the headroom, for example to 1. The subtraction then wraps to a
very large value and this check never fires. As a result, the
NETDEV_CHANGEMTU veto in rmnet_config_notify_cb() accepts the invalid
lower MTU.

rmnet_vnd_change_mtu_with_format() has the same comparison:

	if (new_mtu < 0 || new_mtu > RMNET_MAX_PACKET_SIZE ||
	    new_mtu > (priv->real_dev->mtu - headroom))

After that, it accepts any endpoint MTU up to RMNET_MAX_PACKET_SIZE.

This patch adds the real_dev->mtu < headroom guard only to
rmnet_vnd_update_dev_mtu(). Would these two helpers need the same check?

> @@ -395,23 +403,39 @@ int rmnet_vnd_validate_real_dev_mtu(struct net_device *real_dev)

[ ... ]

>  int rmnet_vnd_update_dev_mtu(struct rmnet_port *port,
> -			     struct net_device *real_dev)
> +			     struct net_device *real_dev, u32 data_format)
>  {
>  	struct hlist_node *tmp_ep;
>  	struct rmnet_endpoint *ep;
>  	unsigned long bkt_ep;
>  	u32 headroom;
> +	int new_mtu;
>  
> -	headroom = rmnet_vnd_headroom(port);
> +	headroom = rmnet_vnd_headroom(data_format);
> +	if (real_dev->mtu < headroom)
> +		return -EINVAL;
> +
> +	new_mtu = real_dev->mtu - headroom;
> +	if (new_mtu > RMNET_MAX_PACKET_SIZE)
> +		return -EINVAL;

[Severity: Medium]
Does this new check reject format changes that used to succeed?

rmnet_vnd_change_mtu_with_format() already caps endpoint MTUs at
RMNET_MAX_PACKET_SIZE. So when real_dev->mtu - headroom was above 16384,
the old loop took the continue path for every endpoint and returned 0.

The real device MTU can be raised after rmnet devices exist, because this
call chain only rejects an MTU that becomes too small:

rmnet_config_notify_cb()->rmnet_vnd_validate_real_dev_mtu()->
rmnet_vnd_validate_mtu()

For example, dummy has max_mtu = 0.

Once that happens, every flags change through rmnet_changelink() fails
here:

		err = rmnet_vnd_update_dev_mtu(port, real_dev, data_format);
		if (err) {
			NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
			return err;
		}

By that point, any IFLA_RMNET_MUX_ID change in the same request has
already been applied. The newlink path is not affected, since
rmnet_vnd_newlink() already rejects this case.

Would it keep the old behavior to clamp the target to
min(real_dev->mtu - headroom, RMNET_MAX_PACKET_SIZE), or to return 0
when the target is above the cap?

>  
>  	hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
> -		if (ep->egress_dev->mtu <= (real_dev->mtu - headroom))
> +		if (ep->egress_dev->mtu <= new_mtu)
>  			continue;
>  
> -		if (rmnet_vnd_change_mtu(ep->egress_dev,
> -					 real_dev->mtu - headroom))
> -			return -1;
> +		/* The target MTU was validated before updating any endpoint. */
> +		WRITE_ONCE(ep->egress_dev->mtu, new_mtu);

[Severity: Medium]
Is it safe to change the MTU of a registered netdev with a bare
WRITE_ONCE() here?

This bypasses dev_set_mtu(), so:

  - the NETDEV_PRECHANGEMTU and NETDEV_CHANGEMTU notifiers don't run
  - min_mtu isn't checked
  - no RTM_NEWLINK is sent to userspace

The new call in rmnet_newlink() has a side effect. Creating a second
rmnet device that requests RMNET_FLAGS_EGRESS_MAP_CKSUMV4 now silently
lowers the MTU of existing sibling devices, which may be running. The
changelink path already behaved this way before this patch; the newlink
caller is new.

addrconf_notify() updates route MTUs and idev->cnf.mtu6 only on
NETDEV_CHANGEMTU, and ip6_dst_mtu_maybe_forward() reads cnf.mtu6.

For example, take an endpoint at 1496 on a 1500 byte real device. It is
shrunk to 1492, but IPv6 keeps sending 1496 byte packets, which become
1504 bytes after MAP encapsulation.

If the shrink takes the device below IPV6_MIN_MTU or 68, the
addrconf_ifdown() and inetdev teardown don't happen either.

Would calling dev_set_mtu() on each endpoint work instead? The target is
smaller than the current MTU, so it should still pass
rmnet_vnd_change_mtu() validation.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009084351.317632-1-subash.a.kasiviswanathan%40oss.qualcomm.com
