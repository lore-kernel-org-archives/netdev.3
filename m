Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07444C502
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967075; cv=none; b=XF1TfvUETz0/BiAPMw17qve+OAuSxAAuiZkoEhFmyvA07rJkzbXn8dSwT8jMjho8w/y0/owfCMk/dwuBGq43KDNVkamtyQ4M3/8m2ao75B1QbaaoOBBMzR0BejFrGlfa2KJdLlMMiMjyFnlMg7AnBfUskGD74jXCEQvUUf3eURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967075; c=relaxed/simple;
	bh=rTYRYWBOXkcbvVJmTjBW1O4FaQx40W0mT6XyWrElqU4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APAkfeqVVPHpN32kGoUjsmDKFqq112i/EFYO1SyBv8ulIXuT4biONsSzvUcMd0ZyNvr/lQ9eUeU+oRsfLaYxHd/c5dn1FkhTgoIdplfx78AJtX3FuETOuk8M0QWtzQ8K1zhqZ5Ase+4xR+JEud80bFaGOYBc66OXyol5VRURVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTvJj8N7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTvJj8N7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41AB1F000FF;
	Wed, 14 Oct 2026 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967073;
	bh=Xr6aEpQ9qGxSKTb9Cy60IrY/LRd4zjrKs8BZPCrXw5o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mTvJj8N7dOU3hgrwyetT720eKQTsqxXyE8zcrrJbhws9HwiarPUYT/1EYtMcJL1tT
	 tY0lYbyJOjube63kQYuAk3BH26iYCHL5/4oudWouq1wSjHS/aOcHVSUC/ftB0PxFBo
	 Y9FhanMw8GfM0Jmmo3zYFVTrPjkKHDRB8k87tO02zH1WZOwgXHlXQ/u/mEjx30pMj+
	 SGINOBQbCihQ9+nuvnHEw/udRSshLDbqcSH2jLA2opVOpvKnnPYU7DLGBl1p0xqIBT
	 kPxZuDygHc6RxWVAHfJWm7MXs1XTqbkL2+K0FmI9z/+EPPGcXZjx4OWFOGvrbm/P/x
	 skbMQ9g3lLZoA==
Subject:
 Re: [PATCH v3] team: reject CAN and IEEE 802.15.4 devices in team_port_add
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: jiri@resnulli.us, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 yaojiale02@163.com
Date: Wed, 14 Oct 2026 08:37:52 +0000
Message-ID: <179196707247.434549.3372737964220312421@kernel.org>
In-Reply-To: <20261013083523.4728-1-socketcan@hartkopp.net>
References: <20261013083523.4728-1-socketcan@hartkopp.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new denylist in team_port_add()
  (drivers/net/team/team_core.c:1228-1236) only rejects ARPHRD_CAN,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the bonding
  driver, which the commit message cites as the precedent being…

--

team: reject CAN and IEEE 802.15.4 devices in team_port_add

This patch makes team_port_add() reject ports of type ARPHRD_CAN,
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR. Team never sets up the
private mid-layer data these L2 types expect, so enslaving one leads to a
NULL pointer dereference. The check mirrors the CAN check bonding has had
since commit 8ba68464e478.

Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/

> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index ca75f08e3c593..5f1708c2a3445 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1225,6 +1225,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  		return -EINVAL;
>  	}
>  
> +	if (port_dev->type == ARPHRD_CAN ||
> +	    port_dev->type == ARPHRD_IEEE802154 ||
> +	    port_dev->type == ARPHRD_IEEE802154_MONITOR) {

[Severity: High]
Does this list cover the whole class of devices the commit message
describes? ARPHRD_6LOWPAN devices still seem to get through
team_port_add(). Examples are lowpan0 on top of wpan0, or a Bluetooth bt0.

For the first port of a different type, the call chain
team_port_add()->team_dev_type_check_change()->team_setup_by_port() copies
the port's type onto the team device:

drivers/net/team/team_core.c:team_setup_by_port() {
    ...
	dev->type = port_dev->type;
    ...
}

At that point netdev_priv() of the team device is still a struct team. None
of the NETDEV_PRE_TYPE_CHANGE notifiers seem to refuse the change here. The
team device's inet6_dev also survives it.

The global lowpan notifier checks only the type and the inet6_dev before it
writes through lowpan_dev(dev):

net/6lowpan/core.c:lowpan_event() {
	if (dev->type != ARPHRD_6LOWPAN)
		return NOTIFY_DONE;

	idev = __in6_dev_get(dev);
	if (!idev)
		return NOTIFY_DONE;
    ...
	case NETDEV_DOWN:
		for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
			clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE,
				  &lowpan_dev(dev)->ctx.table[i].flags);
    ...
}

When the team device is set down, would these 16 clear_bit() calls write
into struct team? The exact offsets depend on the config. On a typical
x86_64 config without spinlock debugging, they appear to hit:

- notify_peers.dw.work.data (the pending bit)
- notify_peers.dw.timer.flags
- mcast_rejoin.count_pending
- mode_priv[0]

The last write lands at about sizeof(struct team), which is just past the
private area.

On NETDEV_UP and NETDEV_CHANGE, lowpan_is_ll() also reads
lowpan_dev(dev)->lltype. That field overlaps team->pcpu_stats.

Would an allowlist of supported port types be more robust here than a
longer denylist?

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. The commit
message says this change mirrors a bonding check, but that check only
rejects CAN:

drivers/net/bonding/bond_main.c:bond_enslave() {
    ...
	if (slave_dev->type == ARPHRD_CAN) {
		BOND_NL_ERR(bond_dev, extack,
			    "CAN devices cannot be enslaved");
		return -EPERM;
	}
    ...
}

Does bonding have the same IEEE 802.15.4 hole? For a non-Ethernet first
slave, bond_enslave()->bond_setup_by_slave() copies slave_dev->type onto
the bond. A wpan device appears to pass all the remaining checks. The bond
then ends up as ARPHRD_IEEE802154 with a NULL ieee802154_ptr.

ieee802154_get_dev() filters only on the type before it dereferences that
pointer:

net/ieee802154/socket.c:ieee802154_get_dev() {
    ...
		for_each_netdev(net, tmp) {
			if (tmp->type != ARPHRD_IEEE802154)
				continue;

			pan_id = tmp->ieee802154_ptr->pan_id;
    ...
}

This path runs from bind() or connect() with a short address on an
AF_IEEE802154 SOCK_DGRAM socket. ieee802154_create() needs no capability
for SOCK_DGRAM.

Once a bond has a wpan slave, could an unprivileged user oops the kernel
this way? Should bond_enslave() get the same IEEE 802.15.4 checks in a
separate patch?

> +		NL_SET_ERR_MSG(extack,
> +			       "CAN and IEEE 802.15.4 devices can't be added as a team port");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013083523.4728-1-socketcan%40hartkopp.net
