Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614457;
	b=R0ZmVMXCBrm5Xnr0ACaETWL0mhFDJS+sp+q1WQLWCS8pG0CWKjMgf5vbDELvhd9Guz0B
	 mw0Z5u+TOOZ7yP1CoASnxwQFzX7EUVmzhtY00NjglZ/7nbq4OtKOWa8jvQF/t8xSIdxBq
	 zYsVeFWV0ShIa6EHN1sLP5nYRevROVReLZtfqAzdEUcQThDcHgqHi9uh1vRFG0bMdSWAE
	 Na4z/bHct4AEZPzBS8/vQtShwGgGb3uKeC3JpDQfMl3D04jh+pA83idUlMLQuqejoKaO5
	 8pTBs8UIXPrPN9+LLYLpaQIwufXeicFO5elKpMY5Jce/V49yWXb/Lu3HFjf//2GjQCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614457;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=w1mbEAreR3UBzDQRa+1ve4a/EfnZcyjIxFDvxoa54xw=;
	b=FplwcV1BPsDs0GMW7pnPpSjBZ9OxtitA3FSyt7c7wAfbTYKsFzotp8NlP/i9Osz1X+7T
	 UqthXbGY/QS00lz8cpjLAuhr/K6HgKLvGgH8g8BTXbwo/08v32tn2A9s/6yxYGtH6a2eX
	 31j8ktkYezRHNb+AFfV/1Zlkpn4C/V7iBz7oTGINnI99jcH+RtU+Af+KUgpc1b1aJL+Mu
	 F3k3jtudzEicQhIf7FCUya7vNt+hW7PLTNMVyo5PprERkUOBpkXU3tLchOjXffZpWOXPw
	 Ar/C8RDsNDZXf+ezqWU+UeoZUmjoMdJuZjjtazxzyO0zZen0iYNBrVQVvuww9FobSGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Eaj/WAUj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A6606A326;
	Mon,  2 Nov 2026 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eaj/WAUj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D410C1F00919;
	Mon,  2 Nov 2026 10:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614456;
	bh=w1mbEAreR3UBzDQRa+1ve4a/EfnZcyjIxFDvxoa54xw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Eaj/WAUjZOsGHnRdH72Gi9lWg6Z2QOg7LNU2jI9xwBxtHtmuIcf5HKPxxhB6D6st6
	 EDMKkZqJaabMz7coJTRPfw7sWI0Zo4uUQiXtNDU6k+qrZF3mw2OhDv/pMQm0p8K4fh
	 xY8xOo/ajjKyOGknd06VEn7EZfOrQwzmM9575rhGIoXMMo9tUoHZZycPqYmM/k0jMu
	 ZGywC8fEMnV+F3pWdKc9z+YPRJmwIlmr2JK/gurMpcisl3H+IMqFWQj7n4AiqS2E11
	 v1SP/kGZABUV3LzrPKTs6s4SgVGyGWwMAhCGqH/c15RS8MlK3zm2/zWQ8uOJNvjfai
	 oa9Ra7Ysnmcpg==
Subject: Re: [PATCH net v3 1/2] genetlink: Reject joining multicast groups no
 family owns
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 fw@strlen.de, martineau@kernel.org, v3rdant.xiang@gmail.com,
 aliceryhl@google.com, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 10:14:15 +0000
Message-ID: <179361445541.3131.9666566156268285493@kernel.org>
In-Reply-To: <20261101101347.3910654-2-anilkaushikwireless@gmail.com>
References: <20261101101347.3910654-2-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Check-then-act race (TOCTOU) between genl_bind() and adding
  the socket to the group.

--

genetlink: Reject joining multicast groups no family owns

This commit makes genl_bind() return -ENOENT when no registered family
owns the requested multicast group ID. Before this change, any user could
join such an ID, and a family that got the ID later would inherit the
membership without any GENL_MCAST_CAP_* check.

Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/

> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 5cc1037d4917e..f038f04ef4ead 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1825,7 +1825,7 @@ static int genl_bind(struct net *net, int group)
>  {
>  	const struct genl_family *family;
>  	unsigned int id;
> -	int ret = 0;
> +	int ret = -ENOENT;
>  
>  	down_read(&cb_lock);
>  
> @@ -1841,6 +1841,7 @@ static int genl_bind(struct net *net, int group)
>  			continue;
>  
>  		grp = &family->mcgrps[i];
> +		ret = 0;
>  		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
>  		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
>  			ret = -EPERM;

[Severity: Medium]
Can a socket still end up as a member of an unowned group ID through a
race with genl_unregister_family()?

genl_bind() checks ownership and capabilities under down_read(&cb_lock),
then drops cb_lock and returns. The caller only sets the membership bit
later, under a different lock:

net/netlink/af_netlink.c:netlink_setsockopt() {
    ...
		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
			err = nlk->netlink_bind(sock_net(sk), val);
			if (err)
				return err;
		}
		netlink_table_grab();
		netlink_update_socket_mc(nlk, val,
					 optname == NETLINK_ADD_MEMBERSHIP);
    ...
}

netlink_bind() has the same gap. Its per-group loop calls
nlk->netlink_bind(net, group + 1), and the subscription update happens
afterwards under netlink_table_grab().

If genl_unregister_family() runs in that window, it only clears sockets
that are already members, and then frees the ID:

net/netlink/genetlink.c:genl_unregister_mc_groups() {
    ...
	netlink_table_grab();
	rcu_read_lock();
	for_each_net_rcu(net) {
		for (i = 0; i < family->n_mcgrps; i++)
			__netlink_clear_multicast_users(
				net->genl_sock, family->mcgrp_offset + i);
	}
	...
		if (grp_id != 1)
			clear_bit(grp_id, mc_groups);
    ...
}

The interleaving would look like this:

CPU1 (unprivileged)
netlink_setsockopt(NETLINK_ADD_MEMBERSHIP)
  genl_bind()       /* owner found, no caps needed, returns 0 */

CPU2
genl_unregister_family()
  genl_unregister_mc_groups()
    __netlink_clear_multicast_users()   /* CPU1 is not a member yet */
    clear_bit(grp_id, mc_groups)

CPU1
  netlink_table_grab()
  netlink_update_socket_mc()            /* now a member of a free ID */

A family registered later, for example one with GENL_MCAST_CAP_NET_ADMIN
or GENL_MCAST_CAP_SYS_ADMIN loaded via request_module(), could then get
that ID. The socket would receive its notifications without a capability
check. At this commit that is the same problem the patch is meant to fix,
although the window needs a family to be unregistered concurrently
(module unload, or module init failing after genl_register_family()).

A later patch in this series, "netlink: Check a group again if it was
released while joining it", appears to close this window. It adds a
per-group generation counter, tbl->mc_gen[], which
__netlink_clear_multicast_users() increments. netlink_setsockopt() and
netlink_bind() check the counter again under netlink_table_grab() and
retry genl_bind() if it changed.

Would it make sense to order that patch before this one, or fold the two
together, so that this commit does not leave the window open on its own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101101347.3910654-1-anilkaushikwireless%40gmail.com
