Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E20547071
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058365; cv=none; b=TWYpZze+65CsY6pyvKxwSq14v4PM4JytTFmPEMUkz3VFwRprssKk8BDq9IWSXMJn4wjmlDJpJ70dOLYItYW0y5n/pXGMquHzMpDnsHxSof3PtCnjOyyPonv0VSDYcfYw0jf08erKmXfssN/37gk5Z6PZjETxoaZzfqan6VbWVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058365; c=relaxed/simple;
	bh=tuaK8cFfX8KirHx01CnwZwrBks61F0YZTy57kPFfSEQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2DZKOQVjOBoWwIQjEGb7oBNU8xSOky26QRjJa3JUcVdujZgtYEaY9K0lJzFtbZGR3abEUxTu5iv00rRZJGOfYICfl15QVcNFKeXt9t1Gi/9Xk+fHpF1MErQbAM84vDja/oAUngtrIQCaPCUMpDKQY8nZZ5D7U/TjunZHNvRqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYSh04Eo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYSh04Eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD31F0089B;
	Sat,  3 Oct 2026 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791058363;
	bh=f/Srug0ripxhrjP8zuXfyr30DPzL3PSP2pLijnaexbo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WYSh04EoyAk3S7NhWklqsKFWajLtKrvMna7IYWB2V5NCX2aEozDYiNzh5vGwZS9xL
	 Sq8VZFmfykEEpxvheM7f1aUCPDSSjKX0tP3P2qMpJnmfpQ8V+GhvzYjoknqUdoJdWk
	 tx03yfmDDghgf7rawdlH22lFZ9Eya/Nx6TRo6iONmcWEqWKSstGEEAhnK7hp+GE2Qt
	 Q3sTnY0f9QdQHCRjDeBefsOG2kbVGTunY9DiKWHfca3rsLsx/oJkJav/BdWKqK7znJ
	 EPVgrLiEYIb9wcyioxRMI2KhOCdvvmzrN441eIdtjF6/e+AllfmoazIgjp0HWlYKCw
	 92MY/LJP6CsLw==
Subject: Re: [PATCH net-next] net: openvswitch: do not set transport header on
 later IPv4 fragments
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aatteka@nicira.com,
 jesse@nicira.com, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, i.maximets@ovn.org,
 echaudro@redhat.com, aconole@redhat.com
Date: Sat, 03 Oct 2026 20:12:42 +0000
Message-ID: <179105836225.434549.3683022386264078751@kernel.org>
In-Reply-To: <20261002195436.8473-1-fmancera@suse.de>
References: <20261002195436.8473-1-fmancera@suse.de>
X-sashiko-severity: Critical
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

Critical: 1 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] After this patch, a stale transport header on IPv4 later
  fragments is used by set_tcp(), set_udp() and set_sctp().
- [High] The patch does not achieve its stated goal.
- [Low] The kernel-doc for key_extract() (net/openvswitch/flow.c:903-906)
  says that when key->eth.type is ETH_P_IP or ETH_P_IPV6,…
- [Low] The commit message is inaccurate and incomplete.

--

net: openvswitch: do not set transport header on later IPv4 fragments

This patch changes check_iphdr() so it no longer calls
skb_set_transport_header() for IPv4 packets with a non-zero fragment
offset. It also moves the transport_len calculation in
update_ip_l4_checksum() so it runs after the fragment check.

Link: https://lore.kernel.org/netdev/59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org/

> As discussed, let's not set the transport header for non-first IPv4
> fragments to prevent a future out-of-bounds memory access that can
> happen silently because the warning at skb_transport_header_offset()
> does not trigger.

[Severity: Low]
I can't find a function named skb_transport_header_offset() in the tree.
Is this about the following check in skb_transport_header() and
skb_network_header_len()?

	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));

Both checks are only built with CONFIG_DEBUG_NET.

Could the message also say that the change only matters when the
transport header was never set? Could it also mention the behavior change
for set_tcp(), set_udp() and set_sctp() on IPv4 later fragments?

[ ... ]

> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 1c4f3a0790443..d549a58180a73 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c

[ ... ]

> @@ -201,7 +202,11 @@ static int check_iphdr(struct sk_buff *skb)
>  		     skb->len < nh_ofs + ip_len))
>  		return -EINVAL;
>  
> -	skb_set_transport_header(skb, nh_ofs + ip_len);
> +	nh = ip_hdr(skb);
> +
> +	if (!(nh->frag_off & htons(IP_OFFSET)))
> +		skb_set_transport_header(skb, nh_ofs + ip_len);
> +

[Severity: Critical]
For a later fragment, skb->transport_header now keeps whatever value it
had when the packet entered OVS.

key_extract_l3l4() also returns early for these packets. It does not apply
the network_header fallback that its -EINVAL path uses:

net/openvswitch/flow.c:key_extract_l3l4() {
    ...
		offset = nh->frag_off & htons(IP_OFFSET);
		if (offset) {
			key->ip.frag = OVS_FRAG_TYPE_LATER;
			memset(&key->tp, 0, sizeof(key->tp));
			return 0;
		}
    ...
}

The IPv6 path sets key->ip.proto = NEXTHDR_FRAGMENT. An IPv4 later
fragment instead keeps key->ip.proto = nh->protocol.

validate_set() accepts OVS_KEY_ATTR_TCP, OVS_KEY_ATTR_UDP and
OVS_KEY_ATTR_SCTP after checking only eth_type and ip.proto. So a flow
matching ipv4(proto=132) with frag wildcarded can apply set(sctp(...)) to
these packets.

set_tcp(), set_udp() and set_sctp() have no fragment check of their own.
The patch adds one only to update_ip_l4_checksum(). Can these actions now
use a stale transport offset?

A GRE vport is one way to get a stale value:

  ip_rcv_core()
    sets transport_header to the outer GRE header
  __iptunnel_pull_header()
    pulls the tunnel header without resetting it
  inet_gro_receive()
    jumps out on ip_is_fragment() before resetting it
  __netif_receive_skb_core()
    resets the header only if it was never set

This leaves an offset of about -4 or -8 relative to the inner Ethernet
header.

nsh_pop() followed by recirculation gives a similar offset of -8. On
!CONFIG_DEBUG_NET, plain netdev rx leaves the offset at the IPv4 header.

In set_sctp(), sctphoff would be (unsigned int)-8:

net/openvswitch/actions.c:set_sctp() {
	unsigned int sctphoff = skb_transport_offset(skb);
	...
	err = skb_ensure_writable(skb, sctphoff + sizeof(struct sctphdr));
	...
	old_correct_csum = sctp_compute_cksum(skb, sctphoff);
    ...
}

As a size_t, sctphoff + sizeof(struct sctphdr) is 0x100000004. Passed to
skb_ensure_writable(), whose write_len is an unsigned int, this becomes 4,
so the check passes. Any offset from -12 to -1 passes the same way.

sctp_compute_cksum() then reads, zeroes and restores sh->checksum at
skb->data + 0xfffffff8. On 64-bit, isn't that about 4 GiB past the
packet?

In set_tcp(), both -8 + 20 and -4 + 20 pass skb_ensure_writable(). Do the
port writes then land in headroom, and the th->check update in the inner
Ethernet or IPv4 header?

In the plain rx case, set_tcp() and set_udp() would write into the IPv4
header itself (tot_len, and frag_off as uh->check). The IP header
checksum is not fixed up afterwards.

With CONFIG_DEBUG_NET and a header that was never set, the warning fires
and the packet is dropped.

Before this patch the offset was always nh_ofs + ip_len, which is inside
the packet.

The fragment can come from a remote peer. The OVS genl ops use
GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN over a netns owned by a user
namespace is enough to install such a flow. ovs-vswitchd may never
generate these flows, but the kernel accepts them.

Should later fragments get a defined value here, such as
transport_header = network_header as the -EINVAL path does? Separately,
should set_tcp(), set_udp() and set_sctp() get later-fragment guards, or
should validate_set() reject these set actions when the flow can match
later fragments?

[Severity: High]
Does this do what the commit message describes? Skipping
skb_set_transport_header() doesn't invalidate the field.

The warning in skb_transport_header() fires only when the field holds the
~0 sentinel, and only with CONFIG_DEBUG_NET:

include/linux/skbuff.h:skb_transport_header() {
	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
    ...
}

On the common paths the field is already set when OVS gets the packet:

- on !CONFIG_DEBUG_NET, __netif_receive_skb_core() resets an unset header
  to the network header
- on GRE and other tunnel paths, ip_rcv_core() leaves it at the outer
  header
- ip_frag_next() sets it on every locally generated fragment, and those
  can enter OVS through internal_dev_xmit()
- recirculated packets keep the value from an earlier pass

In all of these cases skb_transport_header_was_set() is true, so the
warning can't fire, even on debug kernels. The value is also stale now,
where before it was always an offset inside the packet.

The warning can fire only for skbs whose header was never set. That means
netdev rx on CONFIG_DEBUG_NET kernels, or skbs built for
OVS_PACKET_CMD_EXECUTE.

Would it be closer to the intent to call skb_unset_transport_header() for
later fragments? Another option is to set
transport_header = network_header, as the -EINVAL path in
key_extract_l3l4() does.

[Severity: Low]
This isn't a bug on its own, but the kernel-doc for key_extract() in
flow.c still says:

 *    - skb->transport_header: If key->eth.type is ETH_P_IP or ETH_P_IPV6
 *      on output, then just past the IP header, if one is present and
 *      of a correct length, otherwise the same as skb->network_header.

For IPv4 later fragments, neither case is true after this change.
check_iphdr() skips the set, and key_extract_l3l4() returns early without
the network_header fallback.

The IPv6 later-fragment path already behaved this way. Should the comment
or the code be updated so they agree?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002195436.8473-1-fmancera%40suse.de
