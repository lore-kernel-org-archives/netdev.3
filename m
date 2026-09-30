Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA3345EDD
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773681; cv=none; b=M3Bb8uXRy3vhiy+vWTovbX9D3GB9e99+ajndajbx0HQizwYIGEp3wi7oxSELj3EgRIYZfjrvO64bte0A0MPXuhVSiGeEvh40B/OLrOgYWAZQxXxSRXejSfmP1DJe+6L5rn+t6wC2H54TpLjKepStszvjUX4VuriM+6hOYFaerIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773681; c=relaxed/simple;
	bh=8TLf8PVLz2YIjRF7AQY3b4rMaQPPA1wLFLlUcikbSFk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mQUZZZVY5rr/FWrhs9bq/df0NYLTsQt7FCqMy0f8r6c87FEFabhfUf2wQQgC/zEWyYLlzyZJx/MA/6U0KIMM+NU9dqRrG1YSmajRPCc3CQ40X8jvNQFkLxplcaOcwxR4FIa23DpeTdwC87IUsCVvh9d8my4/FmJAZa20Zocj2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HirIkXps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HirIkXps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4DE1F000FF;
	Wed, 30 Sep 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773670;
	bh=pW1lh1qNyurFASvrfcUUVr7aN8GTGNpjHlUqyZ7gqu0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HirIkXpsw8IQpDabtT9tJ8/oGR3obZfcFMdIajVW5AGY+h2U/KdNd7YUrTl0R5I1+
	 itovuHytyNk5N0M7isLzM7UOeI63d3f8bm7kDZlIhpx7fGNGdbn+xoUUMt1xFnCe9A
	 BPA+UiI14PiA9Nvrk/bYO8ozqzO1lC2OLdsTyXJS8WX8X6mHJjaAQuYYPEimPWU1VA
	 16C5t3Y743aTTdBBEKOcMRa4X1x5p9Ui5l02Q1KKi1KrMyXOvpiSeuvkApVy3TFTri
	 ZJkZN6Ml8LDOa+qBm4nXtuOGtFtLcBt8Ve/zGrQRfqLnp9q2VmJBbckSJgNkxTcCye
	 +kyd9pYfiIQ/g==
Subject: Re: [PATCH net 1/2] net/sched: sch_teql: fix shared headroom and
 header strip on slave retry
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hybris@mojatatu.ai, sashiko-bot@kernel.org
Date: Wed, 30 Sep 2026 13:07:49 +0000
Message-ID: <179077366943.434549.8458923511073715827@kernel.org>
In-Reply-To: <QDISC-6HS9.v1.20260928064754@mojatatu.com.1>
References: <QDISC-6HS9.v1.20260928064754@mojatatu.com.1>
X-sashiko-severity: Medium
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

Critical: 0 (1) · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message and the new code comment give the wrong
  reason for problem 1 and the wrong way to reproduce it.

Pre-existing issues:
- [Critical] teql_master_xmit() in net/sched/sch_teql.c treats a slave
  transmit as successful only when `netdev_start_xmit(skb, slave,…

--

net/sched: sch_teql: fix shared headroom and header strip on slave retry

The patch adds a skb_cow_head() call before dev_hard_header() in
__teql_resolve(). It also changes teql_master_xmit() so that, when a
slave attempt fails, it pulls back only the header length that
teql_resolve() pushed for that slave. It no longer pulls
skb_network_offset() bytes.

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 409ce50cc0dbc..acd03f9afc6b8 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c

[ ... ]

> @@ -265,15 +265,28 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
>  	}
>  
>  	if (neigh_event_send(n, skb_res) == 0) {
> +		int off = skb_network_offset(skb);
>  		char haddr[MAX_ADDR_LEN];
>  
>  		neigh_ha_snapshot(haddr, n, dev);
> +		/* The skb may be shared (e.g. a packet tap clone); make the
> +		 * headroom private before dev_hard_header() writes into it.
> +		 */
> +		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {

[Severity: Medium]

The skb_cow_head() call looks right. Are this comment and the commit
message accurate about why it is needed?

The commit message says:

    1. When the skb is shared (for example a packet tap installed on the
       master makes xmit_one() clone it before teql_master_xmit()),

and later:

    and a shared skb is unshared before it is modified.

skb_cow_head() only handles skb_header_cloned(). It does nothing when
skb_shared() is true (users > 1). If it has to expand the head,
pskb_expand_head() has:

    BUG_ON(skb_shared(skb));

Would "header-cloned" be a more accurate term than "shared" in both
places?

Can the packet tap reproducer actually show corruption?
teql_master_setup() never sets header_ops and uses ARPHRD_VOID, so
dev_has_header() is false for the master. packet_rcv() and tpacket_rcv()
only push back to the mac header when it is true:

    if (dev_has_header(dev)) {
        if (sk->sk_type != SOCK_DGRAM)
            skb_push(skb, skb->data - skb_mac_header(skb));

So the tap only sees bytes from skb->data onward. __teql_resolve()
writes the slave header into [data - hlen, data), which the tap never
reads.

A trigger that does seem to cause visible corruption is a tc mirred
mirror on a physical device's clsact egress, with the teql master as
the target.

sch_handle_egress() runs before skb_dst_drop(), so the clone keeps its
dst. ARPHRD_VOID is not a mac-header-xmit type, so tcf_mirred_to_dev()
pulls mac_len off the clone:

    expects_nh = want_ingress || !m_mac_header_xmit;
    at_nh = skb->data == skb_network_header(skb);
    if (at_nh != expects_nh) {
        ...
            skb_pull_rcsum(skb_to_send, mac_len);

The original skb's Ethernet header then sits in the clone's shared
headroom, and dev_hard_header() in teql overwrites it.

Should the reproduction steps in the commit message describe this case
instead?

The subject and body also say both problems happen "on slave retry".
The header write, and now the COW, happens on every slave attempt,
including a first attempt that succeeds. Could the wording reflect
that?

[ ... ]

> @@ -374,8 +390,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			nores = 1;
>  			break;
>  		}
> +		/* Undo only the header teql_resolve() pushed for this slave.
> +		 * Pulling skb_network_offset() instead would strip a
> +		 * userspace-supplied header when the slave added none, e.g.
> +		 * an AF_PACKET/SOCK_RAW frame with no dst entry.
> +		 */
> +		if (hlen > 0)
> +			__skb_pull(skb, hlen);
>  		skb->dev = dev;

[Severity: Critical]

This isn't a bug introduced by this patch, but can this __skb_pull()
and the skb->dev write touch an skb that the slave has already
consumed?

teql_master_xmit() counts a slave transmit as successful only when it
returns NETDEV_TX_OK:

    if (!netif_xmit_frozen_or_stopped(slave_txq) &&
        netdev_start_xmit(skb, slave, slave_txq, false) ==
        NETDEV_TX_OK) {

Stacked slaves such as 8021q, and macvlan through macvlan_start_xmit(),
return the lower device's dev_queue_xmit() result unchanged:

net/8021q/vlan_dev.c:vlan_dev_hard_start_xmit() {
    ...
    ret = dev_queue_xmit(skb);
    ...
    return ret;
}

That result can be NET_XMIT_DROP, NET_XMIT_CN or a negative errno.
dev_xmit_complete() treats all of these as consumed:

    if (likely(rc < NET_XMIT_MASK))
        return true;

For NET_XMIT_DROP the skb is already freed, for example in
__dev_xmit_skb():

    kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_BURST_DROP);
    return NET_XMIT_DROP;

For NET_XMIT_CN it may still be queued on the lower qdisc.

In both cases teql falls through to this block. For a VLAN slave with a
resolved neighbour, hlen is ETH_HLEN + VLAN_HLEN, so __skb_pull() and
skb->dev = dev write to the consumed skb.

The loop then calls teql_resolve(), skb_cow_head(), dev_hard_header()
and netdev_start_xmit() again on it, or it reaches the drop label:

    master->tx_dropped++;
    rcu_read_unlock();
    dev_kfree_skb(skb);

Would that be a double free? The function can also return
NETDEV_TX_BUSY, and the core would then requeue a freed skb.

The setup needs CAP_NET_ADMIN to attach teql as root on a VLAN or
macvlan device. After that, ordinary congestion on the lower device is
enough to hit this path. The rest of the series does not seem to fix it
either; the final state still compares against NETDEV_TX_OK.

Since this patch already reworks the post-failure skb handling on this
path, would it make sense to check dev_xmit_complete() on the return
value instead of comparing it with NETDEV_TX_OK?

>  	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
>  
>  	if (nores && skb_res == NULL) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v1.20260928064754%40mojatatu.com
