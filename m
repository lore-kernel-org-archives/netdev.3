Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717210;
	b=EKklKKRNQF/yGTXuvRhvwcsHcFg85JDaX9MOwMSB6kybXLiiR7c4NPY4BqxBoE4tu105
	 pVSLSfZK8UytnmNK22jyW1xVTrlC2AsMmI9oqRS5kPfGBpCfGA0Yptc4xo7iWWRFTh1uc
	 JZckujiopLeqZear1X7uoOzN1tNHps9jzEw4ks6aUMI5FfrlA4Ap6ycA35MUWlpBr5ql4
	 sM5DWxqRgQgIMJ8tO+lVbk0ZB7JmltInQlWsq7sFcUzh+4YryWfxHDqjEdtAtM9CflqaX
	 i6epkYadxLL4CqjRrWx1ob0kUS4M6IT01jmKN4RdHe1QeZCMCQLPJ/BPT6bETikqzSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717210;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Tjz9g6dlvmvCD0CXPiOmI6DhgTWluUgooEw5+wZVo1I=;
	b=cmsLsmpVKND4ATul19TuiBxlaNAtS9W+tBm/QVi1sjNCtucOkcGMpyZc/EfeBUgI3k3+
	 ex+V+peq5etnwA2VSi7ugqScCY3m24twdw8wCUwZ/aE2KHAbFTf6qMRNUS3E2uO4kx7zK
	 Gmz0V+6IkoQ4wBZqKdpZshI4wBSCbeoThK3pjGHYtq1c13VR72x7U+DWH2KVIp+B+ChCS
	 Ur3c7Bq0DY0dIcREb0zP3mB35GUZgc/X3Jmb8ez+ZUJ196N6B9dxP5FKRHQ2DlFiQU/mF
	 Wna5QdY4NkQqPGA13scyOsbGc79tTsbsw00YevlNQw2EZglzDKRdFycdipMgy6GF0yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avW3TzCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA831606A33F;
	Tue,  3 Nov 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avW3TzCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C1E1F0093A;
	Tue,  3 Nov 2026 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717209;
	bh=Tjz9g6dlvmvCD0CXPiOmI6DhgTWluUgooEw5+wZVo1I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=avW3TzCz3PAiG/+VWMT/vtQDlt+F3jZ61IUJRZGn6K9vA8tINxGWd0kCF/+pj3EEQ
	 DcLVANBDfujXQW3KTvUc7NpaSwnwY9GBaTdUoTRvF74TR5Gt1ToGOqyinC2iehazLt
	 DNc63w6+7VTK5+byLTuXGum7tBkE7b44Jyi+XGord3FYDGTeCp8lXuvwkNIzVgO7xj
	 6otk+7hXTSB5v5jQSDFxiVLWKM5u0+AzHBRHWuTcIn1OEc3klK4sdQg4mfFX4wGMHk
	 0Q3VYTDFX6l1fE3u4CS2BEJHXc63bVMriQ6haXkjw5tNGsraEEeYNTIk2w38m3bxly
	 bgQs/EdJpBEMg==
Subject:
 Re: [PATCH] net: validate checksum start before software fallback on transmit
From: netdev-bot+sashiko@kernel.org
To: zeil@nebius.com
Cc: linux-kernel@vger.kernel.org, NB-CoreTeam@nebius.com,
 netdev@vger.kernel.org, mst@redhat.com, davem@davemloft.net,
 willemb@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Tue, 03 Nov 2026 14:46:48 +0000
Message-ID: <179371720845.488856.8096850971861020807@kernel.org>
In-Reply-To: <20261102140633.42564-1-zeil@nebius.com>
References: <20261102140633.42564-1-zeil@nebius.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check reads the IPv4 header from a different place than
  the one it used to decide the packet is IPv4.
- [High] net: missing iph->ihl >= 5 check in skb_csum_hwoffload_help()
- [Medium] The patch is narrower than its subject.
- [Medium] On the PPP channel-bridge path, the new guard drops packets
  that used to be forwarded.

--

net: validate checksum start before software fallback on transmit

This patch extends the IPv4 csum_start validation from 6785011f8b16 to the
sw_checksum path of skb_csum_hwoffload_help(). For IPv4 packets it pulls
the fixed IPv4 header and calls ip_check_csum_start(). On failure it
returns -EINVAL so the caller drops the packet.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f32353b0467cd..3e737ba094968 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4130,6 +4130,11 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  	}
>  
>  sw_checksum:
> +	if (vlan_get_protocol(skb) == htons(ETH_P_IP)) {

[Severity: High]

Can the protocol check and the header read disagree here?

vlan_get_protocol() walks every in-band 802.1Q/802.1AD tag and returns the
innermost EtherType. pskb_network_may_pull() and ip_check_csum_start()
both read at skb->network_header instead:

include/net/ip.h:ip_check_csum_start() {
	if (unlikely(skb->csum_start < skb->network_header + ip_hdrlen(skb)))
		return -EINVAL;
	...
}

The sites added by 6785011f8b16 gate on skb->protocol or on the netfilter
family. For example, nf_queue_checksum_help() checks
entskb->protocol == htons(ETH_P_IP). With those checks, the protocol and
network_header always agree.

They seem to diverge for a QinQ frame that arrives with CHECKSUM_PARTIAL
(from a tap/virtio guest with NEEDS_CSUM, or from a veth peer) and is then
redirected by tc mirred or bpf_redirect:

__netif_receive_skb_core()
  skb_vlan_untag()
    pops only the outer tag
    skb_reset_network_header()   <- now points at the inner vlan_hdr
  sch_handle_ingress()
    tcf_mirred_to_dev() or bpf_redirect   <- pushes mac_len only
      __dev_queue_xmit()
        validate_xmit_skb()
          vlan_features_check()   <- drops NETIF_F_IP_CSUM, multi-tagged
          skb_csum_hwoffload_help()
            sw_checksum:
              vlan_get_protocol() == ETH_P_IP
              ip_check_csum_start()   <- ihl read from the inner TCI

At that point ip_hdr(skb)->ihl is the low nibble of the first byte of the
inner TCI, which is VID bits 11..8.

Take a correctly formed TCP packet with csum_start == network_header + 24.
If the inner VID is 0x700 or higher, ihl is 7 or more. ip_check_csum_start()
then fails and validate_xmit_skb() drops a packet that skb_checksum_help()
used to complete correctly. Was this drop intended?

The reverse also seems possible. With an inner VID that gives ihl 0 or 1,
a csum_start pointing into the real IPv4 header passes the check, and the
header overwrite still happens.

The bridge path looks unaffected, because br_dev_queue_push_xmit() resets
network_header to the VLAN depth for CHECKSUM_PARTIAL frames. The tc and
bpf redirect paths have no such fix-up.

Would it help to gate on skb->protocol like the other sites? Another
option is to locate the IPv4 header at the depth returned by
vlan_get_protocol_and_depth().

> +		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)) ||

[Severity: Medium]

What happens here when skb_network_offset() is negative?

Take L2TP over UDP/IPv4 on the PPP channel-bridge path. ip_rcv() sets
skb->protocol to ETH_P_IP and points network_header at the outer IPv4
header. The outer IPv4, UDP and L2TP headers (and optionally FF03) are
then pulled, and nothing resets network_header or protocol:

l2tp_udp_encap_recv()
  __skb_pull(skb, sizeof(struct udphdr))
  l2tp_recv_common()
    pppol2tp_recv()
      ppp_input()
        ppp_channel_bridge_input()   <- keeps CHECKSUM_PARTIAL when
                                        csum_start >= skb->data
          ppp_bridge_xmit()
            skb_csum_hwoffload_help(skb, 0)   <- !chan->xmit_offload

With features set to 0 this reaches sw_checksum, and vlan_get_protocol()
returns ETH_P_IP.

pskb_network_may_pull_reason() then does:

	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);

With an offset of -34 or less and len of 20, the unsigned sum wraps to
about 0xFFFFFFF2. On CONFIG_DEBUG_NET kernels this trips
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason(). The
function returns PKT_TOO_SMALL either way, so this path returns -EINVAL
and ppp_bridge_xmit() frees the skb.

Before this patch, skb_checksum_help() completed the inner checksum and
the packet was forwarded. Is dropping these packets expected?

Even if the pull succeeded, ip_hdr() would point at the outer header that
was already stripped, not at the header of the packet being checksummed.
PPTP-received packets bridged to L2TP or PPTP channels look affected in
the same way.

> +		    ip_check_csum_start(skb))
> +			return -EINVAL;
> +	}
>  	return skb_checksum_help(skb);
>  }
>  EXPORT_SYMBOL(skb_csum_hwoffload_help);

[Severity: High]
Does ip_check_csum_start() protect the header here when ihl itself has
not been validated?

ip_check_csum_start() takes its lower bound from the packet:

	skb->csum_start < skb->network_header + ip_hdrlen(skb)

ip_hdrlen() is ip_hdr(skb)->ihl * 4. The sites added by 6785011f8b16,
ip_do_fragment() and xfrm_output(), only see headers that ip_rcv_core()
or the IPv4 output path already checked for ihl >= 5. Nothing on the
paths into skb_csum_hwoffload_help() does that. pskb_network_may_pull()
only makes 20 bytes readable and does not look at ihl.

Packets built by AF_PACKET with PACKET_VNET_HDR (packet_snd(),
tpacket_snd()) or by tap_get_user() with VIRTIO_NET_HDR_F_NEEDS_CSUM
reach this helper with an ihl chosen by the sender. They can arrive via
validate_xmit_skb(), ieee80211_tx_skb_fixup() or the openvswitch
queue_userspace_packet() path.

For VIRTIO_NET_HDR_GSO_NONE, __virtio_net_hdr_to_skb() only requires

	skb_transport_offset(skb) >= sizeof(struct iphdr)

That is measured from skb->data, which still points at the L2 header.
The lowest accepted csum_start therefore depends on the tagging:

  - untagged Ethernet: 6 bytes into the IPv4 header
  - one 802.1Q tag: 2 bytes in
  - QinQ: the network header itself

With ihl between 0 and 4, ip_hdrlen() is 0 to 16. A csum_start inside
the fixed 20-byte header then passes ip_check_csum_start().
skb_checksum_help() writes the folded checksum at
csum_start + csum_offset, which still lands inside struct iphdr.

In the QinQ case, csum_start == network_header with csum_offset == 0
overwrites the version/ihl byte itself. That is the header overwrite
the commit message says this change prevents.

Should this path reject ihl < 5 the way ip_rcv_core() does? Another
option is to compare against max(ip_hdrlen(skb), sizeof(struct iphdr)).
If the helper in include/net/ip.h were changed instead, the existing
callers should not notice, since they already guarantee ihl >= 5.

[Severity: Medium]

The subject says:

  net: validate checksum start before software fallback on transmit

However, the only new check is at the sw_checksum label of
skb_csum_hwoffload_help(). Are the other transmit-side software
completion sites meant to stay unvalidated?

skb_csum_hwoffload_help() returns 0 before sw_checksum, without looking
at csum_start, when the device has NETIF_F_HW_CSUM:

	if (features & NETIF_F_HW_CSUM)
		return 0;

The same early return happens when the device has NETIF_F_IP_CSUM and
csum_offset is 16 or 6.

Several drivers then fall back to software anyway:

  - wireguard encrypt_packet() calls skb_checksum_help() for
    CHECKSUM_PARTIAL skbs.
  - igb_tx_csum() calls skb_checksum_help() in its default case. Other
    Intel drivers follow the same pattern.
  - tg3_start_xmit() calls skb_checksum_help() for frames whose
    skb->protocol is ETH_P_8021Q or ETH_P_8021AD. That is the in-band
    VLAN case this patch handles with vlan_get_protocol().

Some core-stack callers also complete the checksum directly and set
CHECKSUM_NONE, so the skb never reaches this helper afterwards:

  - xsk_skb_metadata() with tx_sw_csum only checks
    csum_start + csum_offset + 2 <= desc->len, which is an upper bound.
  - netem_enqueue() on the corruption path.

On each of these paths, skb_checksum_help() can still write the folded
checksum into the IPv4 header when csum_start points inside it.
6785011f8b16 itself names input-side validation as the eventual complete
fix.

Should these sites be covered too? Otherwise, could the subject and commit
message say the change only covers skb_csum_hwoffload_help()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102140633.42564-1-zeil%40nebius.com
