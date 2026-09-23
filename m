Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08BBA34
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146162; cv=none; b=Libp4UXATfR8FMr8tCHDw14BatwBKz0mWTzF1eOUsQFGxaC8YW5AYu1bm9p3h98Zm5dAUGgC3NeAQivAvDnhTb4j0aQFo3baqzNEwdub+2t4OGzDLGa4IWGVwx1A3T1KMPoGVzmosB8RT0cMd9m41Wj+lQTB3loQqctCeYLJGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146162; c=relaxed/simple;
	bh=8I/93L4djOJx2RuuJpVohIbgIjj7EfNfoOD2xgCm1Cc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLkdNmvPfeb9yqzgD4V9zOHAHaYDG44uOd2AuH10w2mExwZBkVpCT2g2AoM09BnvK/Y+MHrxcWsvLLN5q3hUgnjcWXYhR2SAXhReBMBBhi0aHsoa2i0sNbFwT6xI8imkcv+2KuC31KqTXxu0hOkZ5oYO2BsFHZKAzI9NCeN5lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrqkWluc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrqkWluc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F251F00893;
	Wed, 23 Sep 2026 06:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790146157;
	bh=5OdetTwolXCBMiZbzreLlepQZHtFfCvUEUH7D3M1jmM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IrqkWlucDm9SHHiGoJW8QnXZ8Vqt1SPfRq4TNnqi/oxISE8GW3116JspCdBvDFpP2
	 h8CUnfEvdVW7OWJod7KkFYoYDIBqp9DlO55BgVo68H3PdmXyCauxOG8esaoniCw9Ph
	 nyMQqk3TDdVRMdCgIGKQF1jLuqLuvaD5NGaB46mWiA+7k5jzvPl12Y+aYdnnUINC4H
	 eWIfKvJ927G5yDxsJ/wYTvdcj9t7uSl2ibwx2Pa+p7ySe+mkeOFuu7A8h9f5+SGq2n
	 RCKpxP7NeJPvcT6t5xyf+DEzld+zSco+GIqlETZO5LG17MoqmBwazKMsiGas0+3DQ5
	 fJpBCZx+IXrCQ==
Subject:
 Re: [PATCH net-next 5/5] ovpn: send peer object along with PEER_DEL_NTF
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Date: Wed, 23 Sep 2026 06:49:17 +0000
Message-ID: <179014615707.2160803.3825106929817340578@kernel.org>
In-Reply-To: <20260922060852.2266148-6-antonio@openvpn.net>
References: <20260922060852.2266148-6-antonio@openvpn.net>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's premise is factually wrong: it states
  that final peer statistics are obtained "today ... by issuing a…
- [Medium] Information disclosure across a privilege boundary:
  PEER_DEL_NTF is multicast to the ovpn "peers" generic-netlink group,…
- [Low] The selftest does not exercise the behaviour the patch adds.

--

ovpn: send peer object along with PEER_DEL_NTF

This factors the peer serialization out of ovpn_nl_send_peer() into a new
ovpn_nl_fill_peer() helper and calls it from ovpn_nl_peer_del_notify(), so
PEER_DEL_NTF now carries the same peer object that PEER_GET returns. The
ovpn selftest notification fixtures are updated, and the jq filter
normalizes the timing-dependent traffic counters.

A few questions below.

> OpenVPN userspace needs the final statistics of a disconnecting peer.
> Today this is done by issuing a PEER_GET request after receiving
> PEER_DEL_NTF. When several peers disconnect at the same time, those
> extra request/reply transactions overlap with notification processing on
> the same netlink socket and can make userspace hit transient netlink
> errors such as NLE_BUSY or NLE_NOMEM.

[Severity: Medium]
Is the described existing workflow actually possible?  In
ovpn_peer_remove() the peer is unlinked from the lookup structures before
the notification is emitted:

drivers/net/ovpn/peer.c:ovpn_peer_remove() {
	...
		hlist_del_init_rcu(&peer->hash_entry_id);
	...
	peer->delete_reason = reason;
	ovpn_nl_peer_del_notify(peer);
}

A PEER_GET issued in response to the notification then goes through
ovpn_peer_get_by_id(), which walks exactly those structures:

drivers/net/ovpn/netlink.c:ovpn_nl_peer_get_doit() {
	...
	peer = ovpn_peer_get_by_id(ovpn, peer_id);
	if (!peer) {
		NL_SET_ERR_MSG_FMT_MOD(info->extack,
				       "cannot find peer with id %u", peer_id);
		return -ENOENT;
	}
}

That looks like it fails with -ENOENT for every deleted peer, including a
single disconnect on an otherwise idle netlink socket, so socket contention
would not be what makes the sequence fail.  Would it be more accurate to
describe this patch as making the final counters available at all, rather
than as removing redundant request/reply traffic?

> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 4dad852941982..aaca0612d6f4c 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -546,27 +546,15 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	return 0;
>  }
>  
> -static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
> -			     const struct ovpn_peer *peer, u32 portid, u32 seq,
> -			     int flags)
> +static int ovpn_nl_fill_peer(struct sk_buff *skb, const struct genl_info *info,
> +			     const struct ovpn_peer *peer)
>  {

[ ... ]

> @@ -1193,7 +1206,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
>  	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
>  		goto err_cancel_msg;
>  
> -	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
> +	ret = ovpn_nl_fill_peer(msg, NULL, peer);
> +	if (ret < 0)
>  		goto err_cancel_msg;
>  
>  	nla_nest_end(msg, attr);

[Severity: Medium]
Does this widen what unprivileged readers can observe?
ovpn_nl_peer_del_notify() ends with:

	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg, 0,
				OVPN_NLGRP_PEERS, GFP_ATOMIC);

and the destination group is declared without any capability flag:

drivers/net/ovpn/netlink-gen.c:
	static const struct genl_multicast_group ovpn_nl_mcgrps[] = {
		[OVPN_NLGRP_PEERS] = { "peers", },
	};

genl_bind() only rejects the subscription when a flag is set:

net/netlink/genetlink.c:genl_bind() {
	...
		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
			ret = -EPERM;
}

So any process in the netns can join "peers".  Before this change the
notification carried ifindex, peer id and delete reason; with
ovpn_nl_fill_peer(msg, NULL, peer) it now also carries
OVPN_A_PEER_VPN_IPV4/IPV6, OVPN_A_PEER_LOCAL_IPV4/IPV6,
OVPN_A_PEER_LOCAL_PORT, the keepalive parameters and all eight VPN/link
byte and packet counters.  Every OVPN_CMD_PEER_* op, including both
PEER_GET do and dump, carries GENL_ADMIN_PERM in ovpn_nl_ops, so the same
object is gated on CAP_NET_ADMIN when fetched directly.

Since the notification layout becomes uAPI once released, would it make
sense to mark the group GENL_MCAST_CAP_NET_ADMIN while the family is still
new, or to emit only the subset userspace needs?

> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index de96d333ee2b3..611d528c7de88 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
> @@ -19,9 +19,42 @@ OVPN_VERBOSE=${OVPN_VERBOSE:-0}
>  
>  export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
>  
> -OVPN_JQ_FILTER='map(if type == "array" then .[] else . end) |
> -	map(select(.msg.peer | has("remote-ipv6") | not)) |
> -	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
> +# Peer delete notifications include traffic counters whose values depend on
> +# timing. zero_attr() sets a counter to zero only when that counter is present,
> +# so missing stats still fail the comparison. zero_peer_stats is just the list
> +# of counters to normalize. normalize_peer_del_ntf applies that to peer-del-ntf
> +# messages and drops transport endpoint details, while leaving other
> +# notifications unchanged.
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
This isn't a bug, but does the updated selftest still assert anything about
the counter values the patch adds?

zero_peer_stats rewrites all eight counters to 0, and ovpn_compare_ntfs()
applies OVPN_JQ_FILTER to both the fixture and the captured stream, while
the fixtures hard-code 0 for peers that exchanged ping and iperf traffic
earlier in test.sh:

tools/testing/selftests/net/ovpn/json/peer0.json:
	..."vpn-rx-bytes": 0, "vpn-rx-packets": 0, ..., "link-tx-packets": 0...

With the `if has(key)` guard the only property checked is that the
attributes are present, so a kernel emitting constant or bogus values from
ovpn_nl_fill_peer() would still pass.  Could a weaker value-level check be
added instead, for example requiring nonzero counters for the peers that
carried traffic, or comparing against a PEER_GET snapshot taken before the
deletion?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922060852.2266148-2-antonio%40openvpn.net
