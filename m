Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D348986C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856338; cv=none; b=mQPQxOo4LYCXDkVpj1kc/2egLOBddhsKnbuXI/Z6/Yxr1PUpmbhppqeRupVEOTdFJdCVe+rCBKcBqP2CBP9aBWj/gtbBZeGZa/p2rQuJoPXoYGy8KeT2QxZziWMXeiB08ZijdRtqpRYdDVG4Bc7YNQ7fM5AZ/7iWPxUNrB0PnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856338; c=relaxed/simple;
	bh=nwncsLLsAzGibFZBFyXEcpsmrS68Y10BIOtlk9Wa1wA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rziwmqBOy0B79jxrb1uGbAozbkKvyd4q3MEnSVJ0M+WRskYjX3TzdBTRE+MLADzuQJqetpnT+0m5VICcRhUXP1TJcZR7o6DlZp1M8Rbw3JFU7EUdiOQ4tRGqyoujpggkqXV7v9u50dAKKV6SNX1C0Ai93B9109rFsSrTygrH1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0IQR8+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0IQR8+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD281F000FF;
	Thu,  1 Oct 2026 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790856330;
	bh=/6o90xWvyuTnafzumQWl8YNm+jWn3/i8x6ED4Zivew8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M0IQR8+D08cV8OFoXEyrglICpDzo7if6NCIoXqbfUnLLRAESQQAkz98huCVyGVAaJ
	 11eRdoCUR2zcUynIS+3KL3KuP/a6WwHpHfBDziWHVLlfqmDbsHInaz0wTGLuJwdpM+
	 GAwd56tSdFu+gAgEgaUnXjB1Mnru+hua4AdJ8WGI4na/Rm1BmVzquHlIVP/zabPm2i
	 1Bj54c8hb7awVp1D6vKKemKlPYPCBBkqQMXZd7zg32DlUJPQH4NCmaWUqm87PLKa39
	 6TprZcgPRnmZQABQtBT+u+iLPa45RMVOR9LE1hsbng22hIxFMX5Mf9qr4GOWc3ANj3
	 Y6PK+Zk6YjASg==
Subject: Re: [PATCH] ipvlan: no longer rely on RTNL in ipvlan_nl_fillinfo()
From: netdev-bot+sashiko@kernel.org
To: kishorg@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, netdev@vger.kernel.org
Date: Thu, 01 Oct 2026 12:05:30 +0000
Message-ID: <179085633007.434549.15752145596334986681@kernel.org>
In-Reply-To: <20260928210508.2645800-1-kishorg@google.com>
References: <20260928210508.2645800-1-kishorg@google.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says the single WRITE_ONCE(port->flags, ...)
  in ipvlan_nl_changelink() stops concurrent readers from seeing an…

Pre-existing issues:
- [Medium] ipvlan_link_new() in drivers/net/ipvlan/ipvlan_main.c writes
  the requested IFLA_IPVLAN_FLAGS into the shared port with…

--

ipvlan: no longer rely on RTNL in ipvlan_nl_fillinfo()

This commit makes ipvlan_nl_fillinfo() and ipvlan_nl_changelink() use
ipvlan->port directly, instead of looking the port up under RTNL. It
annotates the lockless accesses to port->mode and port->flags with
READ_ONCE()/WRITE_ONCE(). It also replaces the separate mark/clear helpers
in ipvlan_nl_changelink() with a single store to port->flags.

> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index f29864db662aa..e8bd2f980d548 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c

[ ... ]

> @@ -516,17 +516,7 @@ static int ipvlan_nl_changelink(struct net_device *dev,
>  	}
>  
>  	if (!err && data[IFLA_IPVLAN_FLAGS]) {
> -		u16 flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
> -
> -		if (flags & IPVLAN_F_PRIVATE)
> -			ipvlan_mark_private(port);
> -		else
> -			ipvlan_clear_private(port);
> -
> -		if (flags & IPVLAN_F_VEPA)
> -			ipvlan_mark_vepa(port);
> -		else
> -			ipvlan_clear_vepa(port);
> +		WRITE_ONCE(port->flags, nla_get_u16(data[IFLA_IPVLAN_FLAGS]));
>  	}
>  
>  	return err;

[Severity: High]

The commit message says the old read-modify-write sequence "could publish
an intermediate value to concurrent readers". Does the single store here
fully close that window?

The TX readers still load port->flags twice per packet.
ipvlan_is_vepa() and ipvlan_is_private() each do their own
READ_ONCE(port->flags), and ipvlan_addr_lookup() runs between them:

drivers/net/ipvlan/ipvlan_core.c:ipvlan_xmit_mode_l3() {
    ...
	if (!ipvlan_is_vepa(ipvlan->port)) {
		addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
		if (addr) {
			if (ipvlan_is_private(ipvlan->port)) {
				consume_skb(skb);
				return NET_XMIT_DROP;
			}
			ipvlan_rcv_frame(addr, &skb, true);
    ...
}

ipvlan_xmit_mode_l2() uses the same pattern for local unicast.

Suppose the port changes from PRIVATE to VEPA while a packet is in flight:

TX CPU                                 RTNL
ipvlan_is_vepa() reads PRIVATE
  -> false, take the local branch
ipvlan_addr_lookup() finds addr
                                       ipvlan_nl_changelink()
                                         WRITE_ONCE(port->flags, VEPA)
ipvlan_is_private() reads VEPA
  -> false
ipvlan_rcv_frame()

Wouldn't the frame then go straight to another slave? That is bridge
behaviour (flags == 0), the same intermediate state the old
clear_private/mark_vepa sequence exposed. The old PRIVATE setting would
drop the frame, and the new VEPA setting would send it out via phy_dev.

Could the TX paths take one snapshot per packet, for example u16 flags =
READ_ONCE(port->flags), and test both bits on that value? Another option
is to have the helpers take a flags value instead of the port.

[ ... ]

> @@ -682,7 +662,7 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>  	 * to be consistent in setting it just like the mode attribute.
>  	 */
>  	if (data && data[IFLA_IPVLAN_FLAGS])
> -		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
> +		WRITE_ONCE(port->flags, nla_get_u16(data[IFLA_IPVLAN_FLAGS]));
>  
>  	if (data && data[IFLA_IPVLAN_MODE])
>  		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);

[Severity: Medium]

This isn't a bug introduced by this patch, but ipvlan_link_new() writes
port->flags to the shared port before it calls ipvlan_set_port_mode(),
which can fail. If that call fails, is the old flags value ever restored?

drivers/net/ipvlan/ipvlan_main.c:ipvlan_link_new() {
    ...
	err = ipvlan_set_port_mode(port, mode, extack);
	if (err)
		goto unlink_netdev;
    ...
unlink_netdev:
	netdev_upper_dev_unlink(phy_dev, dev);
remove_ida:
	ida_free(&port->ida, dev->dev_id);
unregister_netdev:
	unregister_netdevice(dev);
	return err;
}

ipvlan_set_port_mode() fails if dev_change_flags() fails on an existing
slave, or if ipvlan_l3s_register() fails. With CONFIG_IPVLAN_L3S=n it
always fails for L3S mode. The stub returns -ENOTSUPP, and
ipvlan_nl_validate() only checks mode < IPVLAN_MODE_MAX:

static inline int ipvlan_l3s_register(struct ipvl_port *port)
{
	return -ENOTSUPP;
}

On a port that already has slaves, RTM_NEWLINK would then return an
error, but the PRIVATE/VEPA setting has already changed for every
existing slave.

ipvlan_nl_changelink() avoids this because it writes flags only after
ipvlan_set_port_mode() returns 0. Could ipvlan_link_new() use the same
order?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928210508.2645800-1-kishorg%40google.com
