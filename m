Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BF3A3834
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791428939; cv=none; b=nSwpe6m2mkB/rFGYc0QX4d89vrF5vrbcAix8G8lHPhCGjeY0b66cs+yfoH5f2MM0O5bxbhgrYa7JRbUHcSU2ZEytlNVARXKBzoTaqrsPR8/9cmS+I4Lldqcubtlg5vHTA8+ARAsZu1+bnw5D4Gn3CdriY2T3dn3xJ9sb/ooG9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791428939; c=relaxed/simple;
	bh=PWG3y45TLq+2EYNDqKAkHqFFniV2/lumTNdn6fQ3iDo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSegCQXnNOHleqTCaQhPNDKNU1Q4C2Le7wZIhev+e5EndTkjIOW68ZLSgyHl1X+KsE9HndcKBRXyC/BcKVANkcFDEYlekzJxt+EcUCWMIWu5Nrt6T+89mrYi56PLZwyq6gJ7Vxa6sNw11QfBIUqlQtGOr9MNeqCo/vazE51eyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuelR3HU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuelR3HU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E400C1F000FF;
	Thu,  8 Oct 2026 03:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791428932;
	bh=aRMRej6BarypDXtxW8XVG8x7mXdI3gM8mqHy1rjFvZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EuelR3HUMH4wtbmV4sDywYfodTGxNKkC28SZe/gck+agGT9k6CEs0G0HRptBoWR/a
	 ibRGC9D8zDX5LbvuX9VF0w6f7W7wvy3CVy+rY7UkLtTrPhEfxORJI5UjykwIfVwbDJ
	 W48zd7BMMpWpbz/ZXnInLXg8uhyeANRCl10565m8YVQGsYhxkUpbs5XCAypUqX54Kc
	 PyNrYptCTEKg1cuHpydWKXHzj4QV4xpTFhbhlp0rt1NdllPoLpWDh7bHUTjFd9nz2+
	 pDPEXyPvrBaY4XU4aTA1XC7jhftTgEwT7YUtQnfTPQhavz0xiHKsruSHe/Jp50kvtJ
	 Vcf8v1luWySCA==
Subject: Re: [PATCH net-next v2] net: openvswitch: do not set transport header
 on later IPv4 fragments
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, dev@openvswitch.org, blp@nicira.com,
 joe@wand.net.nz, jesse@nicira.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net, i.maximets@ovn.org,
 echaudro@redhat.com, aconole@redhat.com
Date: Thu, 08 Oct 2026 03:08:51 +0000
Message-ID: <179142893147.434549.15118225602165856295@kernel.org>
In-Reply-To: <20261005150831.4831-1-fmancera@suse.de>
References: <20261005150831.4831-1-fmancera@suse.de>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch changes check_iphdr() (net/openvswitch/flow.c) so
  that it no longer sets skb->transport_header for IPv4 later fragments…

Pre-existing issues:
- [Medium] set_sctp() (net/openvswitch/actions.c) still runs on
  OVS_FRAG_TYPE_FIRST fragments of IPv4 and IPv6 SCTP packets.

--

net: openvswitch: do not set transport header on later IPv4 fragments

The patch stops check_iphdr() from setting the transport header on IPv4
later fragments. It also moves the fragment offset check in
update_ip_l4_checksum() before the transport offset is read. Finally, it
adds OVS_FRAG_TYPE_LATER guards to set_tcp(), set_udp() and set_sctp() so
these actions no longer corrupt fragment payloads.

Link: https://lore.kernel.org/netdev/59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org/

> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index dc5ff859f1145..8556a5a74ccd0 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c

[ ... ]

> @@ -658,11 +666,16 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
>  		    const struct ovs_key_sctp *key,
>  		    const struct ovs_key_sctp *mask)
>  {
> -	unsigned int sctphoff = skb_transport_offset(skb);
> -	struct sctphdr *sh;
>  	__le32 old_correct_csum, new_csum, old_csum;
> +	unsigned int sctphoff;
> +	struct sctphdr *sh;
>  	int err;
>  
> +	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
> +		return 0;
> +

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Even
so, set_sctp() still runs on OVS_FRAG_TYPE_FIRST fragments of both IPv4
and IPv6 SCTP packets.

key_extract_l3l4() marks a fragment at offset 0 with IP_MF set as FIRST:

net/openvswitch/flow.c:key_extract_l3l4() {
    ...
		if (nh->frag_off & htons(IP_MF) ||
			skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
			key->ip.frag = OVS_FRAG_TYPE_FIRST;
    ...
}

For OVS_KEY_ATTR_SCTP, validate_set() checks only eth_type and
ip.proto == IPPROTO_SCTP, so it accepts the action for such a flow.

set_sctp() then computes old_correct_csum and new_csum with
sctp_compute_cksum(). That function covers only this fragment's bytes:

include/net/sctp/checksum.h:sctp_compute_cksum() {
    ...
	new = ~skb_crc32c(skb, offset, skb->len - offset, ~0);
    ...
}

How much a CRC32c changes depends on how many bytes follow the changed
bytes. Does that make this result wrong for the reassembled datagram?

	sh->checksum = old_csum ^ old_correct_csum ^ new_csum;

If so, the receiver would drop the reassembled packet. After this patch,
port rewrites on fragmented SCTP flows seem to remain broken end to end.
Only the corruption of later fragment payloads is fixed.

>  	err = skb_ensure_writable(skb, sctphoff + sizeof(struct sctphdr));
>  	if (unlikely(err))
>  		return err;
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 1c4f3a0790443..52cc63837445b 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c

[ ... ]

> @@ -201,7 +202,10 @@ static int check_iphdr(struct sk_buff *skb)
>  		     skb->len < nh_ofs + ip_len))
>  		return -EINVAL;
>  
> -	skb_set_transport_header(skb, nh_ofs + ip_len);
> +	nh = ip_hdr(skb);
> +	if (!(nh->frag_off & htons(IP_OFFSET)))
> +		skb_set_transport_header(skb, nh_ofs + ip_len);
> +

[Severity: Medium]
With this change, an IPv4 later fragment leaves the OVS datapath with
the transport_header it arrived with:

- On the normal RX path it is the network header, because
  __netif_receive_skb_core() resets it.
- With CONFIG_DEBUG_NET, or for packets built through
  OVS_PACKET_CMD_EXECUTE, it is unset (~0).

Before this patch it always pointed just past the IP header, as
ip_rcv_core() and ip_frag_next() do.

The commit message says:

    That is only safe if no later code relies on it.

Is there code that runs after OVS and does rely on it? One example is
mlx5e_skb_l3_header_offset() in
drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:

	if (skb_transport_header_was_set(skb))
		return skb_transport_offset(skb);
	else
		return mlx5e_skb_l2_header_offset(skb);

With tx_min_inline_mode == MLX5_INLINE_MODE_IP, mlx5e_calc_min_inline()
used to inline L2 and L3 for these fragments. It now seems to inline only
L2.

That mode is forced on a DSCP trust port by
mlx5e_trust_update_tx_min_inline_mode():

	if (trust_state == MLX5_QPTS_TRUST_DSCP &&
	    params->tx_min_inline_mode == MLX5_INLINE_MODE_L2)
		params->tx_min_inline_mode = MLX5_INLINE_MODE_IP;

Could later fragments then be classified into a different traffic class
than the first fragment of the same datagram?

The new OVS_FRAG_TYPE_LATER guards in set_tcp(), set_udp() and set_sctp()
appear to fix the payload corruption on their own. Only the reorder in
update_ip_l4_checksum() depends on this check_iphdr() change. Is the
change needed for the fix?

OVS already behaves this way for IPv6 later fragments since commit
41e4e2cd7534. Bridged IPv4 fragments also already arrive with
transport_header == network_header, so this matches existing behaviour.

If the change stays, could the commit message say why it is needed and
mention this effect on code that runs after OVS? The Fixes: tags will
carry it to stable together with the actual fix.

>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005150831.4831-1-fmancera%40suse.de
