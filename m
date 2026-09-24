Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6E399D08
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228519; cv=none; b=XL3g3VYB0wIvUpwEMXDw2DWrxV5N03oRjYAVZtgiF1KPBSmMsFNJcg4j9fdMjcaBTrH/l7/lToU0/zmMp7lErB/uxRTzmxJwu9ei5OIviQyOZ0D+LbjvikY+mv7Yr727i0ttgyxqxY236bLGuYrh2dHD6TbzpKW7QMWqCYhW+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228519; c=relaxed/simple;
	bh=jL1bIUxxRSZJ6V6CnW3qOphETdPw6dEs4IQ27mziE5w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgTZb//E2DKFsimwv8wtIzEBb7As1cEvWmwOhKFT1YtSjZ0GrUEtvDAW55rxRSeCyghQRM+57bAMHVGcJ7LTrsi6Uf7IsFZMs9r+C6UPUkz+1yngmqZo50B7GwgFsWo+JUaS/r0AKEnev76/ULLCxzIh2Cl/bUWgQxuiKWTSF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwq9iqqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwq9iqqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDDF1F000FF;
	Thu, 24 Sep 2026 05:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228517;
	bh=g/oCu7IkHtpYeJfhvO2VehPoRIqe7P3+rR4muCsoCe4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rwq9iqqKLX5K0IV5pZitb02mprvdX2lQzsAvdCtP7DgO3Pt4zgUBXNUvu5wzy6aId
	 hDx+y/AkcWh4lyrKfx3T9wdUuKjY7y7ZTvC/y8/FPuBOUXFJ03MppKC93raoM2dZfP
	 Eaw6Oj1XYRaJJeoJTu72J1Ov/hGayApt02O4qKuQPwbZUK/djEJ29caW4XPN3sVJ37
	 fGwdTNt9Q9JzFMWHBrxQSxTFH03kTOXeN302pySWQvI/ctdjPGAKDrH3IXKEDr97XE
	 njYZy0m1/HwwDJ6+XEl5S8QxhZidgZHmJzseZcuutV1hSC++UJfM9JcRAu8xn6qqtD
	 7zJu/uYRrVONQ==
Subject:
 Re: [PATCH net] vlan: ensure sufficient headroom in vlan_dev_hard_header()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, petalzu987@gmail.com
Date: Thu, 24 Sep 2026 05:41:56 +0000
Message-ID: <179022851638.2160803.1808206741379444999@kernel.org>
In-Reply-To: <20260922113924.3165190-1-edumazet@google.com>
References: <20260922113924.3165190-1-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch makes vlan_dev_hard_header() return -ENOMEM for
  ARPHRD_ETHER-backed VLAN devices for the first time, which activates a…
- [Medium] vlan_dev_hard_header() (net/8021q/vlan_dev.c:58-60) now
  returns -ENOMEM *before* pushing anything, making…
- [Medium] sch_teql swallows the newly introduced VLAN header-
  construction failure and selects its 'transmit' branch.
- [Medium] The new -ENOMEM return from vlan_dev_hard_header() makes two
  LLC SAP response builders leak their response skb.
- [Low] The new headroom computation in vlan_dev_hard_header()
  (net/8021q/vlan_dev.c:58-59) reads dev->needed_headroom with a plain…

--

vlan: ensure sufficient headroom in vlan_dev_hard_header()

This adds an skb_cow_head() call to vlan_dev_hard_header() when
VLAN_FLAG_REORDER_HDR is clear, so that callers which reserved only
ETH_HLEN (or skbs allocated before a headroom change) no longer hit
skb_under_panic() when the VLAN header is pushed.

Closes: https://lore.kernel.org/netdev/cover.1789987105.git.petalzu987@gmail.com/

> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index 2859cbac3f266..3598ad0779f05 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -55,6 +55,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
>  	int rc;
>  
>  	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
> +		if (skb_cow_head(skb,
> +				 dev->hard_header_len + dev->needed_headroom) < 0)
> +			return -ENOMEM;

[Severity: High]
Can this new -ENOMEM return wake up the error path in
llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr() in net/llc/llc_c_ac.c?

That action frees the wrong skb when llc_mac_hdr_init() fails:

net/llc/llc_c_ac.c:llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr() {
	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
	...
	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U, 0);

	if (nskb) {
		...
		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
		if (likely(!rc))
			llc_conn_send_pdu(sk, nskb);
		else
			kfree_skb(skb);
	}
	if (rc) {
		nr = LLC_I_GET_NR(pdu);
	...
}

The sibling actions in the same file use kfree_skb(nskb) here. With
kfree_skb(skb), does nskb leak while the caller-owned event skb is put
twice, given that llc_conn_state_process() documents "This function
always consumes a reference to the skb" and does kfree_skb(skb) at
out_skb_put?  And is the following LLC_I_GET_NR(pdu) then a read of the
freed skb, since pdu points into it?

The failure branch looks genuinely reachable now: llc_alloc_frame()
reserves 3 + llc_mac_header_len(ARPHRD_ETHER) = 17 bytes, the LLC PDU
push leaves 14 bytes of headroom, so on a VLAN device with
VLAN_FLAG_REORDER_HDR clear skb_cow_head(skb, 14 + 18) always calls
pskb_expand_head(GFP_ATOMIC) and can fail under memory pressure.

Before this change the branch appears to have been dead code for
Ethernet-backed devices: eth_header() pushes first and only returns a
negative value when daddr is NULL, and dev_hard_header() returns 0 when
there are no header_ops.

[Severity: Medium]
Along the same lines, do llc_sap_action_send_xid_r() and
llc_sap_action_send_test_r() in net/llc/llc_s_ac.c leak their response
skb now?

net/llc/llc_s_ac.c:llc_sap_action_send_xid_r() {
	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U,
			       sizeof(struct llc_xid_info));
	...
	rc = llc_mac_hdr_init(nskb, mac_sa, mac_da);
	if (likely(!rc))
		rc = dev_queue_xmit(nskb);
out:
	return rc;
}

On the new -ENOMEM, nskb is neither queued nor freed, and the pointer is
local so no caller can release it.  Both actions run on received XID and
TEST command PDUs, and the skb from llc_alloc_frame() has only 14 bytes
of headroom, so the cow is always attempted.

[Severity: Medium]
A related question about the new failure mode in general: this is the
first time dev_hard_header() can return a negative value for an
ARPHRD_ETHER-backed VLAN device with a non-NULL daddr, and it now means
"nothing was pushed" rather than "header pushed, but tell me something".
Several callers discard the return and transmit immediately:

net/bridge/br_stp_bpdu.c:br_send_bpdu()
	llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
	skb_reset_mac_header(skb);
	NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, ... br_send_bpdu_finish);

net/tipc/bearer.c:tipc_l2_send_msg()
	dev_hard_header(skb, dev, ETH_P_TIPC, dest->value, dev->dev_addr, skb->len);
	dev_queue_xmit(skb);

net/netfilter/nft_reject_netdev.c
	dev_hard_header(nskb, nskb->dev, ntohs(oldskb->protocol), ...);
	dev_queue_xmit(nskb);

Same pattern in the direct-xmit path of net/netfilter/nf_flow_table_ip.c
and in drivers/net/ppp/pppoe.c, where the skb is reserved with only
dev->hard_header_len so the cow is always attempted.

When skb_cow_head() fails, is the skb handed to dev_queue_xmit() with
skb->data still at the payload and no VLAN or Ethernet header, so that
vlan_dev_hard_start_xmit() reads payload bytes as struct vlan_ethhdr and
a frame with a garbage link header goes on the wire?  br_send_bpdu() is
one of the two callers named in the commit message.

[Severity: Medium]
Is the sch_teql path also affected?  __teql_resolve() in
net/sched/sch_teql.c shadows its return variable:

net/sched/sch_teql.c:__teql_resolve() {
	int err = 0;
	...
	if (neigh_event_send(n, skb_res) == 0) {
		int err;
		char haddr[MAX_ADDR_LEN];

		neigh_ha_snapshot(haddr, n, dev);
		err = dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
				      haddr, NULL, skb->len);

		if (err < 0)
			err = -EINVAL;
	} else {
	...
	return err;
}

The inner err holds the failure, so 0 is returned and teql_master_xmit()
takes "case 0" and calls netdev_start_xmit() on the slave.  For the
negative returns that existed before (for example ipgre_header(), which
returns negative after pushing its header) that was harmless, but with
the new -ENOMEM nothing has been pushed.  Should the inner declaration
be dropped, or the return checked by the caller?

[Severity: Low]
This isn't a bug, but should dev->needed_headroom be read with
READ_ONCE() here?  Every other in-tree reader annotates it, for example:

include/linux/netdevice.h
	#define LL_RESERVED_SPACE_EX(dev, hlen) \
		((((hlen) + READ_ONCE((dev)->needed_headroom)) \
		  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)

The writer is vlan_transfer_features(), which runs from the VLAN work
item under RTNL:

net/8021q/vlan_dev.c:vlan_transfer_features()
	vlandev->needed_headroom = dev->needed_headroom + VLAN_HLEN;
	...
	vlandev->hard_header_len = dev->hard_header_len;

while vlan_dev_hard_header() runs from the transmit path without RTNL.

>  		vhdr = skb_push(skb, VLAN_HLEN);
>  
>  		vlan_tci = vlan->vlan_id;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922113924.3165190-1-edumazet%40google.com
