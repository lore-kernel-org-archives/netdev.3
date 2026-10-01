Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F7388890
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893674; cv=none; b=r7KZSd/M6jimiBzZ7M1q2XBdoUv5kcOC29rdQkED44gXC6fe4c7AKqznu6o9fGxv4W/iyfvgmOZI6feZX/LMxpPwzAFZ+QQ9EmGE6p849fRgoPSrNPuvOfwawvWD3V79N+jZ9lfe8dIbCyDVwxtO4ynkjFF/38iEQdZI+VSRzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893674; c=relaxed/simple;
	bh=kPdo22b0uBC0zyWh4OPJUriQucFp7eBYn+ErI8hMZNQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKsG0DJ4WIQmly29SBDOHwfSrbtwTyhrm8kQ1eHjKqaMkmPMnyMVEbzpbdPVh1LpI8ttsb9AY2JztxO06GfdEARjznaSSwNox1vrhGxeyHOHsnTBtgU0JrYxstCpuLT/leCGreVB8hAhT2LYQSDWSernXNFpd3Zaz2ix7sgh+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHUijO4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHUijO4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8441F00893;
	Thu,  1 Oct 2026 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790893673;
	bh=uyR+VMn8wjfjnmwYSALmkiEpER5FWGC1wht62QpNNTo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MHUijO4MBYxn5qv22n6rMkJjdbAP5Kp4gmAkCF7MRI/jdqPYNhJxXbjSflrDpHTWd
	 vTJAqp0hHwNsMCTL5JFejqayF1DAmc8mxo03mRWs8O7SCCOgzxQi85WpXyoDewrK3Q
	 ZlweQNl6rrPJrA8hiwl+SPYPhP2Mx1kngog6/ET1ZBcWGR4iBniZLSZGmuPfAiM/Cz
	 /iNjiQ55LWw7z7/8Imhn+ypwFDrBDvFQpjzra0NkkQts1r/pDc4rgObB0aRSULisZ4
	 sHBYCjvrDHk8gLHikzC4fGxmg2OGY60H3V3PvLw0Grp8Y0w18QXq36AGU3OslTxXEu
	 511meI9/iu9fQ==
Subject:
 Re: [PATCH net-next 6/7] ovpn: send peer object along with PEER_DEL_NTF
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Thu, 01 Oct 2026 22:27:52 +0000
Message-ID: <179089367219.434549.15440439887481062555@kernel.org>
In-Reply-To: <20260930222542.3839327-7-antonio@openvpn.net>
References: <20260930222542.3839327-7-antonio@openvpn.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Any unprivileged process can now read peer data that PEER_GET
  restricts to CAP_NET_ADMIN.
- [Medium] The commit message promises the peer's "final statistics", but
  the PEER_DEL_NTF snapshot can miss the last traffic.
- [Low] The updated selftest cannot detect wrong counter values in
  PEER_DEL_NTF.

--

ovpn: send peer object along with PEER_DEL_NTF

This commit moves the attribute filling from ovpn_nl_send_peer() into a
new helper, ovpn_nl_fill_peer(). ovpn_nl_peer_del_notify() now uses that
helper, so PEER_DEL_NTF carries the full PEER_GET peer object, including
the traffic counters. The ovpn selftest JSON fixtures and jq filter are
updated to match the new payload.

> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 5432bc2eb8e80..15b6d99474b99 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c

[ ... ]

> @@ -1273,7 +1286,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
>  	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
>  		goto err_cancel_msg;
>  
> -	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
> +	ret = ovpn_nl_fill_peer(msg, NULL, peer);
> +	if (ret < 0)
>  		goto err_cancel_msg;

[Severity: High]
Does this expose peer data that only CAP_NET_ADMIN can read to
unprivileged listeners?

With this change, PEER_DEL_NTF carries the full object built by
ovpn_nl_fill_peer(). That object has tx-id, VPN IPv4/IPv6, keepalive
interval and timeout, remote and local IP and port, and all eight
vpn/link rx/tx byte and packet counters.

ovpn_nl_peer_del_notify() then sends the message to the peers group:

	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg, 0,
				OVPN_NLGRP_PEERS, GFP_ATOMIC);

That group has no capability flag in drivers/net/ovpn/netlink-gen.c:

static const struct genl_multicast_group ovpn_nl_mcgrps[] = {
	[OVPN_NLGRP_PEERS] = { "peers", },
};

The genetlink kernel socket is created with NL_CFG_F_NONROOT_RECV.
genl_bind() only returns -EPERM for groups that have
GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN set. So any process
in the transport socket's netns can join "peers".

The same data through OVPN_CMD_PEER_GET (do and dump) requires
GENL_ADMIN_PERM.

Before this patch, PEER_DEL_NTF only carried del-reason and id.
PEER_FLOAT_NTF only carries id plus the remote address and port. Now
every peer removal sends the tunnel IP to public IP mapping and the
per-peer traffic counters to unprivileged subscribers. This covers
userspace delete, keepalive expiry and socket close.

Should the "peers" group get GENL_MCAST_CAP_NET_ADMIN in the ovpn YAML
spec, with netlink-gen.c regenerated? Or should the sensitive attributes
be left out of the multicast payload? Once this payload ships to
unprivileged listeners it becomes uAPI, which would make it harder to
restrict later.

[Severity: Medium]
Are these counters really the final statistics? The commit message
says:

  OpenVPN userspace needs the final statistics of a disconnecting peer,

ovpn_peer_remove() calls ovpn_nl_peer_del_notify() right after it
unhashes the peer under ovpn->lock:

drivers/net/ovpn/peer.c:ovpn_peer_remove() {
    ...
	peer->delete_reason = reason;
	ovpn_nl_peer_del_notify(peer);

	/* append to provided list for later socket release and ref drop */
	llist_add(&peer->release_entry, release_list);
}

Unhashing only stops new lookups. The datapath is quiesced later, in
unlock_ovpn()->ovpn_socket_release(). That runs after the lock is
dropped and after this notification has been built.

In TCP mode, ovpn_tcp_rcv() gets the peer from the strparser through
container_of() and calls ovpn_recv(). That keeps incrementing
link_stats.rx, and ovpn_netdev_write() increments vpn_stats.rx. Async
crypto completions and TX paths that already hold a peer reference can
also keep incrementing link_stats.tx.

Increments that land after the atomic64_read() calls in
ovpn_nl_fill_peer() are lost for good, because the peer cannot be
queried afterwards.

Could the notification be sent after the datapath has quiesced, for
example after the socket release or TCP wait? Alternatively, the values
could be documented as a best-effort snapshot.

[ ... ]

> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index 96b40742eddfe..623a990045016 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
> @@ -19,9 +19,42 @@ OVPN_VERBOSE=${OVPN_VERBOSE:-0}

[ ... ]

> +OVPN_JQ_FILTER='
> +	def zero_attr(key):
> +		if has(key) then .[key] = 0 else . end;
> +
> +	def zero_peer_stats:
> +		zero_attr("vpn-rx-bytes") |
> +		zero_attr("vpn-rx-packets") |
> +		zero_attr("vpn-tx-bytes") |
> +		zero_attr("vpn-tx-packets") |
> +		zero_attr("link-rx-bytes") |
> +		zero_attr("link-rx-packets") |
> +		zero_attr("link-tx-bytes") |
> +		zero_attr("link-tx-packets");

[Severity: Low]
This isn't a bug, but can the selftest catch wrong counter values in
PEER_DEL_NTF?

zero_peer_stats sets all eight counters to 0 on both sides of the
comparison:

	if diff <(jq -s "${OVPN_JQ_FILTER}" ${expected}) \
		<(jq -s "${OVPN_JQ_FILTER}" ${received}) \

All the json/peer*.json fixtures also contain 0. So the test only checks
that the counter attributes are present. Zero, stale or reset counters
would still pass, even though test.sh sends ping and iperf traffic
through every peer before deleting it.

Could the test check something stronger, such as counters greater than
zero after the deterministic ping -c 100 traffic?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930222542.3839327-2-antonio%40openvpn.net
