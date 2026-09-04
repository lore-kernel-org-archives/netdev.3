Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE83EBF02;
	Fri,  4 Sep 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521227; cv=none; b=VJ7VKRso355u6zk4ubtpdbimZVPF0z/h9v1Z/fFPG5NbsmZ3FkEd3ehAQC9GRZYT3ifcS/ABH0dr7epqbCXcs41URMlt+2B8vTJJyFfarbadmMSNy+ETZnS4rbQqCrazUPy4Weu4yU79AMptD4oMQcFEcZPJNZqg12ISLZxrcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521227; c=relaxed/simple;
	bh=UIsuz+ug/O0FJcTVWx3saM6ySkMqzmoot8Pvwjn+7p8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRhAUEjbtCatd0DNBDTdh4f4B0j0klGWieO25G7Q+6ZCSmminXXmmjepd0RgY2l9LMKd3DW98ZPej7eyG7gK2Vpu9f/bxYM7lqKBsbtCshUpj8zQxg86n3QuSFA5QrkXArzCWJFK7OJmtFjIhCLnvldX6TWM2z8GWLkdpHU9g9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE0EwpKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE0EwpKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6670F1F00A3D;
	Fri,  4 Sep 2026 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521225;
	bh=FDC1xQuXx40N/5vxVySrQd6eLxNg039Vvslk24n7SM0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CE0EwpKo3Nx10108sywqQiAQtT8MHMArMTvH//iqldF21Xoly+md7ROfLmoqbhKRo
	 I1DHQR0ucZr++cPWX9Y/j5q7+/feV1rFxunv2k8GZ05RPqxFL9ItPd0c/3H0g/Lb76
	 lAsatZgTTlYCpzo+970i4azfWTn0YsSLyAx8LLC3ZN4lI7jkm0QHkoLL2nwDIV4fa1
	 C2Yo6mfOpYNn57WPiuy/RY/WqA4cTqmG73t8TN29Jr4lcbcZx9EfG6BAawRPcAH9Uw
	 /H9KudZ34WPxyluhW+13gCktRGwlWtOwXQrMyHPg07vGBRcA8aveg1ndiELsR9GrMK
	 3Ot0DrCfb3nlg==
Subject: Re: [PATCH net-next] vxlan: add IFLA_VXLAN_IGNORE_DF
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 kuniyu@google.com, razor@blackwall.org, fmancera@suse.de, atenart@kernel.org,
 i.maximets@ovn.org, john@phrozen.org, nbd@nbd.name, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 11:27:03 +0000
Message-ID: <178852122391.4131868.5681821798424309159@kernel.org>
In-Reply-To: =?utf-8?q?=3Cc8add19a594ca2724ad97205c9cf3af387a2d6db=2E1788347?=
 =?utf-8?q?880=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cc8add19a594ca2724ad97205c9cf3af387a2d6db=2E17883478?=
 =?utf-8?q?80=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 1

- [High] vxlan_xmit_one() applies the new ignore_df knob to only half of
  the transmit decision in metadata (external / collect-metadata) mode.
- [Medium] IFLA_VXLAN_IGNORE_DF is declared as an unbounded `{ .type =
  NLA_U8 }` in vxlan_policy[] (drivers/net/vxlan/vxlan_core.c:3464), but…
- [Medium] Two statements in the commit message are not backed by the
  code.
- [Medium] IFLA_VXLAN_IGNORE_DF silently overrides IFLA_VXLAN_DF in the
  datapath — vxlan_xmit_one() evaluates `if (vxlan->cfg.ignore_df) { df…
- [Low] vxlan->cfg.ignore_df is re-read two (IPv4) or two (IPv6) separate
  times per transmitted packet in vxlan_xmit_one() without being…

--

vxlan: add IFLA_VXLAN_IGNORE_DF

Adds a new per-device netlink attribute that stops a vxlan device from
reporting a path MTU and dropping oversized frames, letting the outer IP
packet be fragmented instead. On IPv4 the DF bit is never set, on IPv6
skb->ignore_df is set so ip6_fragment() will fragment the encapsulated
frame.

A few questions below, plus two about the changelog itself.

> It also fails outright where the path forwards whole datagrams but
> discards IP fragments, which is common on carrier NAT. There the
> fragmenting has to happen inside the encapsulation to survive, and the
> tunnel refuses to do it.

[Severity: Medium]
Does the patch actually address this second scenario?  The mechanism added
here is outer-IP fragmentation only: df = 0 on IPv4 and skb->ignore_df = 1
on IPv6 so that ip6_fragment() proceeds.  Both produce IP fragments of the
encapsulating datagram, which a path that discards IP fragments drops the
same way it did before.  There is no inner-side fragmentation anywhere in
the change.

> Add IFLA_VXLAN_IGNORE_DF, off by default, mirroring IFLA_GRE_IGNORE_DF:
> carry the frame and let IP fragment the outer packet rather than report
> the path MTU and drop it.

Is "mirroring IFLA_GRE_IGNORE_DF" an accurate description of the scope?
In ip_tunnel_xmit(), GRE's ignore_df only suppresses inheriting the inner
DF bit, and the PMTU bookkeeping still runs right after:

net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
	if (payload_protocol == htons(ETH_P_IP) && !tunnel->ignore_df)
		df |= (inner_iph->frag_off & htons(IP_DF));

	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
	...
}

This patch instead replaces the whole skb_tunnel_check_pmtu() call with a
constant 0, so neither skb_dst_update_pmtu_no_confirm() nor the
iptunnel_pmtud_check_icmp()/iptunnel_pmtud_check_icmpv6() reply used for
bridge and OVS ports runs any more.  Could the changelog mention that
difference?

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 459f19f7071e5..21cb7fbfb6e63 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2510,7 +2510,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  			if (err)
>  				goto out_unlock;
>  
> -			if (vxlan->cfg.df == VXLAN_DF_SET) {
> +			if (vxlan->cfg.ignore_df) {
> +				df = 0;
> +			} else if (vxlan->cfg.df == VXLAN_DF_SET) {
>  				df = htons(IP_DF);
>  			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
>  				struct ethhdr *eth = eth_hdr(skb);

[Severity: Medium]
Should the combination of df and ignore_df be rejected instead of letting
one silently win?  With ignore_df set, cfg.df becomes dead configuration
here, but vxlan_nl2conf() accepts both without extack or -EINVAL and
vxlan_fill_info() keeps reporting nla_put_u8(skb, IFLA_VXLAN_DF,
vxlan->cfg.df).  So after

	ip link add vx0 type vxlan id 1 remote <ip> df set ignore_df 1

a dump says IFLA_VXLAN_DF = VXLAN_DF_SET while DF is never set on the wire.

GRE rejects the equivalent conflict:

net/ipv4/ip_gre.c:ipgre_netlink_parms() {
	if (data[IFLA_GRE_IGNORE_DF]) {
		if (nla_get_u8(data[IFLA_GRE_IGNORE_DF])
		  && (parms->iph.frag_off & htons(IP_DF)))
			return -EINVAL;
	...
}

> @@ -2526,7 +2528,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  		}
>  
>  		ndst = &rt->dst;
> -		err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
> +		err = vxlan->cfg.ignore_df ? 0 :
> +		      skb_tunnel_check_pmtu(skb, ndst,
> +					    vxlan_headroom(flags & VXLAN_F_GPE),
>  					    netif_is_any_bridge_port(dev));
>  		if (err < 0) {
>  			goto tx_error;

[Severity: High]
Can this drop packets silently in collect-metadata (external) mode?

The df computation above sits inside the "if (!info)" arm, while its
sibling arm in vxlan_xmit_one() still forces DF for metadata-driven
transmits:

drivers/net/vxlan/vxlan_core.c:vxlan_xmit_one() {
	} else if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT,
			    info->key.tun_flags)) {
		df = htons(IP_DF);
	}
}

The new PMTU bypass, however, applies to both cases.  So for an
ignore_df=1 device in external mode carrying a tunnel key with
DONT_FRAGMENT set, the outer header has DF, the dst PMTU is not updated,
and no tunnel ICMP is sent back to the inner sender.  The packet then hits

net/ipv4/ip_output.c:ip_fragment() {
	if (unlikely(!skb->ignore_df ||
		     (IPCB(skb)->frag_max_size &&
		      IPCB(skb)->frag_max_size > mtu))) {
		IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
			  htonl(mtu));
		kfree_skb(skb);
	...
}

and skb->ignore_df cannot help on IPv4 because iptunnel_xmit() calls
skb_scrub_packet(), which clears it.  Before this patch the same packet at
least got skb_dst_update_pmtu_no_confirm(), and iptunnel_pmtud_check_icmp()
for bridge/OVS ports.

The configuration is reachable because vxlan_nl2conf() accepts ignore_df
with no relation to VXLAN_F_COLLECT_METADATA, and OVS, act_tunnel_key,
nft_tunnel and lwtunnel can all set IP_TUNNEL_DONT_FRAGMENT_BIT.  Would it
make sense to keep the bypass in the same "if (!info)" scope as the df
computation, or to also clear DF on the metadata path?

[Severity: Low]
On a related note, vxlan->cfg.ignore_df is re-read here and again in the
df computation above without a local snapshot, while the changelink path
publishes a whole new config with

drivers/net/vxlan/vxlan_core.c:vxlan_config_apply() {
	memcpy(&vxlan->cfg, conf, sizeof(*conf));
}

under RTNL only, with no exclusion against the transmit path.  Would a
single "bool ignore_df = READ_ONCE(vxlan->cfg.ignore_df);" at the top of
vxlan_xmit_one() be tidier?  The other cfg fields on this path (cfg.df,
cfg.flags, cfg.ttl, cfg.tos, cfg.label_policy) are read the same way today,
so this is following existing convention rather than introducing something
new.

> @@ -2598,7 +2602,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  				goto out_unlock;
>  		}
>  
> -		err = skb_tunnel_check_pmtu(skb, ndst,
> +		err = vxlan->cfg.ignore_df ? 0 :
> +		      skb_tunnel_check_pmtu(skb, ndst,
>  					    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
>  					    netif_is_any_bridge_port(dev));
>  		if (err < 0) {
> @@ -2630,6 +2635,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  			goto tx_error;
>  		}
>  
> +		if (vxlan->cfg.ignore_df)
> +			skb->ignore_df = 1;
> +

[Severity: High]
Is the precedence relative to the tunnel key intended to differ between
the two address families?  This assignment is outside the "if (!info)"
scope, so on IPv6 an ignore_df device overrides an explicit per-packet
DONT_FRAGMENT request from the external controller, whereas on IPv4 the
tunnel key wins and DF stays set.

[Severity: Low]
These two IPv6 reads of vxlan->cfg.ignore_df are coupled: the PMTU check
is skipped based on the first one, and skb->ignore_df is set based on this
one.  If the flag flips from 1 to 0 in between, the frame gets neither PMTU
handling nor permission to fragment:

net/ipv6/ip6_output.c:ip6_fragment() {
	if (unlikely(!skb->ignore_df && skb->len > mtu))
		goto fail_toobig;
}

and it is dropped with no packet-too-big generated by the tunnel.

>  		udp_tunnel6_xmit_skb(ndst, sock6->sk, skb, dev,
>  				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
>  				     pkey->label, src_port, dst_port, !udp_sum,
> @@ -3453,6 +3461,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
>  	[IFLA_VXLAN_REMCSUM_NOPARTIAL]	= { .type = NLA_FLAG },
>  	[IFLA_VXLAN_TTL_INHERIT]	= { .type = NLA_FLAG },
>  	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
> +	[IFLA_VXLAN_IGNORE_DF]	= { .type = NLA_U8 },
>  	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
>  	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
>  	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),

[Severity: Medium]
Should this use NLA_POLICY_MAX(NLA_U8, 1) like the two neighbouring
boolean-style attributes in the same table (IFLA_VXLAN_LOCALBYPASS and
IFLA_VXLAN_MC_ROUTE)?  As written the full u8 range is accepted while the
value is stored in a bool, so "ignore_df 2" is taken, coerced to 1, and
read back as 1 by vxlan_fill_info().  Once released, the accepted range is
frozen and cannot be narrowed.

> @@ -4391,6 +4400,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  	if (data[IFLA_VXLAN_DF])
>  		conf->df = nla_get_u8(data[IFLA_VXLAN_DF]);
>  
> +	if (data[IFLA_VXLAN_IGNORE_DF])
> +		conf->ignore_df = nla_get_u8(data[IFLA_VXLAN_IGNORE_DF]);
> +

[Severity: Medium]
The GRE attribute this mirrors canonicalises the value in
ipgre_netlink_parms():

net/ipv4/ip_gre.c:ipgre_netlink_parms() {
	t->ignore_df = !!nla_get_u8(data[IFLA_GRE_IGNORE_DF]);
}

Would either a !! here or a range-limited policy entry be preferable to a
plain assignment into a bool?

[ ... ]

> @@ -4623,6 +4636,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
> +	    nla_put_u8(skb, IFLA_VXLAN_IGNORE_DF, vxlan->cfg.ignore_df) ||
>  	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
>  	    nla_put_u32(skb, IFLA_VXLAN_LABEL_POLICY, vxlan->cfg.label_policy) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 7b82075055237..85690b817e0ea 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -228,6 +228,7 @@ struct vxlan_config {
>  	unsigned int			addrmax;
>  	bool				no_share;
>  	enum ifla_vxlan_df		df;
> +	bool				ignore_df;
>  	struct vxlanhdr			reserved_bits;
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/c8add19a594ca2724ad97205c9cf3af387a2d6db.1788347880.git.daniel%40makrotopia.org
