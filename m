Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C230C631
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792211913; cv=none; b=SSRUb8O4lvflY3LjMrOEuxtqxzr5Sbh1k4oh90Pkj9h2OqbqUo0Fbwn/kgPKKc3vNNngMD7T8e0tcVHLCvh+fDB6K7wol88MwHfwy/Ij4S8Es52455arXi05kX1WUDrrEUHUpkXUCcz4qNI8lRf+Lvpd4AeGwlq7vRCMMMfJh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792211913; c=relaxed/simple;
	bh=i7PLpxfEMC01qSXDVqKvEVCazBF+QnZNOmFYvwPNp78=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRzdKH8fjiQnmhy02y1oMP7sngs6AR9hfK0CEVPOkChQiHjv6gktvY+6zweDuatFrs0mJz5Ov7qhoOf2ErSMOtNIJzf5CCI//cIbw8W99Rr+DpVJRd/Nr6JbXBo1wZnBnxSPv9fPA+okHCNT4uaLU700xPRn8KRsV3cEygHA7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC59GU9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC59GU9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9718D1F000C4;
	Sat, 17 Oct 2026 04:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792211911;
	bh=9m2hLJw9ccxVMuWezdwdsp1UFP8rcLF2WaRreure+gU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NC59GU9Q/+vp3Q7QQGUzElGMaWzn/dudfmAp3XW6usFa7F3pOZVdN7smui0vhKMJN
	 9b2DUjEpuYhcKfTlyMz0bNhWNYLJD4getvFCTiNLqHTfgT41YMAWaHvWFrSRBzl8Zj
	 Bx18tz34/70eLgc42c+2gZIw0MYcFiQ2NC5blyB6xw3ZmQHI+vLzEndqp7c2tsRjbp
	 v2CnoQzDiq+sOvDTBlmsjlvidj5IvD9yWSZhq68AROHPbThsA3gr2jACC3ixugT6Rf
	 ldWZwIJ3/12C3GkO5sapNyf32N3L3xozwSaurHmWzaShtWYV/lNq3yB7uCoI5J0p7z
	 3IE0cj5Ro6hkA==
Subject: Re: [PATCH 2/2 net-next] net: openvswitch: drop IP fragments on SCTP
 set action
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, dev@openvswitch.org, jesse@nicira.com,
 aatteka@nicira.com, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, i.maximets@ovn.org,
 echaudro@redhat.com, aconole@redhat.com
Date: Sat, 17 Oct 2026 04:38:30 +0000
Message-ID: <179221191010.434549.8856124906041431590@kernel.org>
In-Reply-To: <20261015124749.4694-2-fmancera@suse.de>
References: <20261015124749.4694-2-fmancera@suse.de>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/openvswitch: set_sctp corrupts SCTP checksum for padded
  packets
- [Medium] In net/openvswitch/actions.c, set_sctp() now returns -EINVAL
  whenever `flow_key->ip.frag != OVS_FRAG_TYPE_NONE`.
- [Low] The commit message says first and later fragments failed the same
  way: the skb holds part of the SCTP packet and 'the CRC delta of a…
- [Low] set_tcp() and set_udp() (actions.c:644-645, 598-599) skip
  OVS_FRAG_TYPE_LATER packets: they return 0 and the action list…

--

net: openvswitch: drop IP fragments on SCTP set action

This patch makes set_sctp() return -EINVAL for any packet whose flow key
has ip.frag set to anything other than OVS_FRAG_TYPE_NONE. The goal is to
drop SCTP fragments with OVS_DROP_ACTION_ERROR instead of forwarding them
with rewritten ports and an invalid CRC32c checksum.

Link: https://lore.kernel.org/netdev/d4fc14f3-4308-4560-9012-43c09c1b3845@ovn.org/

> For a first fragment, and for
> a later fragment, it holds just a part of it, and the CRC delta of a
> change at the start of the packet depends on how many bytes follow, so
> the checksum written is wrong.

[Severity: Low]
Is this the right description of what happened to later fragments?

An IPv4 later fragment has no SCTP header. key_extract() in
net/openvswitch/flow.c sets OVS_FRAG_TYPE_LATER but leaves ip.proto as
IPPROTO_SCTP:

	offset = nh->frag_off & htons(IP_OFFSET);
	if (offset) {
		key->ip.frag = OVS_FRAG_TYPE_LATER;
		memset(&key->tp, 0, sizeof(key->tp));
		return 0;
	}

So validate_set() accepts the action. The old set_sctp() then wrote the
"ports" over payload bytes 0-3, wrote a computed "checksum" over payload
bytes 8-11, and copied payload bytes into flow_key->tp. That reads as
silent payload corruption rather than just a wrong CRC. It is the same
problem the earlier patch in this series ("net: openvswitch: skip IPv4
later fragments on TCP/UDP set actions") describes for TCP/UDP.

IPv6 later fragments never reach set_sctp(), because parse_ipv6hdr() sets
ip.proto to NEXTHDR_FRAGMENT:

		if (frag_off) {
			key->ip.frag = OVS_FRAG_TYPE_LATER;
			key->ip.proto = NEXTHDR_FRAGMENT;
			return 0;
		}

validate_set() then rejects SCTP set actions on flows that could match
them.

> fail the action for packets that are IP fragments of either
> family

In practice this covers IPv4 first and later fragments plus IPv6 first
fragments. The code does handle the IPv4 later fragment case. Could the
commit message describe the old behaviour for each case, to help anyone
judging impact or backporting?

> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 4aade471afc45..12e339cbf7912 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -674,6 +674,9 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
>  	__le32 old_correct_csum, new_csum, old_csum;
>  	int err;
>  
> +	if (flow_key->ip.frag != OVS_FRAG_TYPE_NONE)
> +		return -EINVAL;

[Severity: High]
This patch doesn't introduce it, but does the same CRC delta problem
also hit unfragmented packets that carry trailing link layer padding?

sctp_compute_cksum() covers skb->len - sctphoff bytes. As far as I can
see, nothing on the OVS receive path trims skb->len down to the IPv4
total length or the IPv6 payload length before actions run. The only
trim I can find is ovs_skb_network_trim() in
net/openvswitch/conntrack.c, and that only runs for ct actions. So a
small SCTP packet that was padded to the 60 byte Ethernet minimum
reaches set_sctp() with the pad bytes still in the skb.

In that case old_correct_csum and new_csum are both computed over the
SCTP packet plus the padding. As the commit message says, the CRC delta
of a change at the start of the packet depends on how many bytes follow
it. That makes old_correct_csum ^ new_csum the wrong delta for the
receiver, and old_correct_csum also no longer matches a correct
old_csum. The value written to sh->checksum is wrong even for a packet
that arrived with a valid checksum. ip_rcv() or ipv6_rcv() on the
receiver trims the padding, sctp_rcv() then sees a CRC32c mismatch, and
the packet is dropped.

This looks easy to hit. Over IPv4, an SCTP packet that carries only a
COOKIE ACK, SHUTDOWN ACK or SHUTDOWN COMPLETE chunk is 36 bytes of IP,
well under the Ethernet minimum. A flow that rewrites SCTP ports, for
example for NAT, would then corrupt those chunks. I think losing COOKIE
ACK would keep an association from ever being established.

Could set_sctp() limit the CRC computation to the length taken from the
IP header? Another option would be to trim the skb first, the way
ovs_skb_network_trim() does. Do you want to handle this in this series,
or as a separate fix?

[Severity: Medium]
Does this also drop IPv6 atomic fragments? These are packets with a
Fragment header whose offset is 0 and whose M bit is clear, so the skb
holds the complete SCTP packet.

parse_ipv6hdr() in net/openvswitch/flow.c marks any Fragment header with
a zero offset as OVS_FRAG_TYPE_FIRST:

	nexthdr = ipv6_find_hdr(skb, &payload_ofs, -1, &frag_off, &flags);
	if (flags & IP6_FH_F_FRAG) {
		if (frag_off) {
			...
		}
		key->ip.frag = OVS_FRAG_TYPE_FIRST;

ipv6_find_hdr() in net/ipv6/exthdrs_core.c sets IP6_FH_F_FRAG whenever a
Fragment header is present, and it masks off the M bit:

	_frag_off = ntohs(*fp) & ~0x7;

As a result, set_sctp() cannot tell an atomic fragment from a real first
fragment.

Before this patch, sctp_compute_cksum() covered the whole SCTP packet in
this case, so the old_csum ^ old_correct_csum ^ new_csum update was
correct and the packet was forwarded with its ports rewritten. Now
do_execute_actions() frees it with OVS_DROP_ACTION_ERROR and skips the
rest of the action list.

RFC 8021 deprecates generating atomic fragments, but RFC 6946 still says
receivers must process them.

Could the check look at the M bit, or confirm that the skb covers the
full IPv6 payload, rather than rejecting every OVS_FRAG_TYPE_FIRST packet?
IPv4 SCTP looks fine here, because key_extract() only sets
OVS_FRAG_TYPE_FIRST for it when IP_MF is set.

[Severity: Low]
This isn't a bug, but should later fragments be handled the same way here
as in set_tcp() and set_udp()? Both of those treat OVS_FRAG_TYPE_LATER as
a successful no-op:

	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
		return 0;

This check returns -EINVAL for both FIRST and LATER. Take a flow that
wildcards ip.frag and rewrites L4 ports. IPv4 TCP/UDP later fragments are
forwarded unchanged and the action list continues. IPv4 SCTP later
fragments are dropped with OVS_DROP_ACTION_ERROR, and any actions after
the set are skipped.

The commit message says the drop is intended. The same flow drops the
first fragment anyway, so the visible difference is mostly drop
accounting and whether later actions run.

The uAPI description of OVS_ACTION_ATTR_SET in
include/uapi/linux/openvswitch.h also doesn't mention that a validated
SCTP set can fail at runtime on fragments while TCP/UDP sets are skipped.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015124749.4694-1-fmancera%40suse.de
