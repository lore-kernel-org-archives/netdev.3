Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC23F9265;
	Sun,  4 Oct 2026 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093958; cv=none; b=vAqweL0gB0iwSr0UoK6iHzmkhhKms6UHiw/jdoZqNBGOqLg5cbwiTuYL47YK6vL48B/Ge/kbSXk8ZwGVeRo8E77eTi6h2i1ou/tXTjZ2QxQx0Zd22QCv6EGum27WYFkH7/QfWksLZEyWouhtbbhv2FPXcjoD35+gVsfT74a8Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093958; c=relaxed/simple;
	bh=K35Yjlfovgrm+xN/Z4hTFmEffFeidCBkldhQzraiacg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHDDrQPQhqpn3W01GOtq1kwQTYb0cJ0WLvyIogq6nUaUCwH6xrr2b5myZo6HrL4axM5JHJiheflge34uV+bCoWZsB3S+6PXCjAGLyaJ04HRVVRZnvAfDE7QvPL5fCptRoDGlivEyBswoai9d/6bIV3lzNoMit8eoJSnBcGP86OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkH8wT8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkH8wT8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295381F0089D;
	Sun,  4 Oct 2026 06:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093954;
	bh=J7xXB7QnMVWHK/esqrChi4ZV/rDvjGwk67CUQOST7Ro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MkH8wT8bCTer3UfEJPQgbWVwSvdjZhTVqrGSCAo1M/0divvjv1nWD4ZC61R5ilaOv
	 u/bWqhofmxCCp6gXE7r92WnP3ztJNZv4GJQock0r3zTPDDxE4BVPLxX3HvKdXCc8dG
	 9hVMI6rD1Wn6MiF40W57sNAwbBmSX4b8L9wudgsDNZwReJIjPPTD+h7qLkYq4R6PoD
	 c/Y92s0nb8/8Cq/XT+SDtVI9PvjeSMBngFHm7lBU6y3UEhMcP7Enc60o77VE8tTGE9
	 blqA/Zdcn6iQxcDeGo/EXAwZoQ+yOx92C40pmIsG+pEbJ6eWhs9omUEhz5HaRHZIn9
	 S1eF8kPZ/qf3g==
Subject: Re: [PATCH net-next 6/7] net: qualcomm: rmnet: Add ethtool stats for
 DL coalescing
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 sean.tranchetti@oss.qualcomm.com
Date: Sun, 04 Oct 2026 06:05:53 +0000
Message-ID: <179109395371.434549.18417749929372500070@kernel.org>
In-Reply-To:
 <20260930051345.857443-7-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20260930051345.857443-7-subash.a.kasiviswanathan@oss.qualcomm.com>
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

- [High] A malformed IPv6 extension-header length can push the parsed
  header length (ip_len) past the end of the received packet.
- [Medium] In rmnet_map_data_check_coal_header()
  (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c), the per-NLO…
- [Medium] Some of the new ethtool -S counters duplicate statistics that
  already have a standard uAPI.
- [Medium] The 19 new coalescing counters are plain u64 fields in the
  single per-device `struct rmnet_priv_stats priv->stats`.
- [Low] Some ethtool counter labels do not match what the counters
  measure.

--

net: qualcomm: rmnet: Add ethtool stats for DL coalescing

This commit adds per-device counters to struct rmnet_priv_stats. They
track DL coalescing decode activity, header and checksum errors, and
hardware close reasons, and are exposed through ethtool -S.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
> index 5adda0323dda7..2a34f8a7b5276 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
> @@ -80,6 +80,26 @@ struct rmnet_priv_stats {
>  	u64 csum_skipped;
>  	u64 csum_sw;
>  	u64 csum_hw;
> +	/* DL coalescing */
> +	u64 coal_rx;
> +	u64 coal_pkts;

[Severity: Medium]
These new counters are plain u64 fields in the single per-device
priv->stats. The RX softirq path updates them with non-atomic
read-modify-write operations, for example:

rmnet_map_process_next_hdr_packet()
    priv->stats.coal_rx++;

rmnet_map_data_check_coal_header()
    priv->stats.coal_pkts += pkts;

__rmnet_map_segment_coal_skb()
    priv->stats.coal_reconstruct++;

The reader in rmnet_get_ethtool_stats() copies them with a plain memcpy():

    memcpy(data, st, ARRAY_SIZE(rmnet_gstrings_stats) * sizeof(u64));

On 32-bit kernels, can ethtool -S see torn 64-bit values while RX softirq
on another CPU is updating them?

If the real device delivers frames for the same mux_id on more than one
CPU (multi-queue NAPI or RPS), can concurrent increments also be lost?

The existing csum_* counters use the same pattern, but this patch adds
more hot path counters to it. The driver already has struct
rmnet_pcpu_stats with a u64_stats_sync. Would per-CPU counters using
u64_stats_update_begin() and u64_stats_fetch_begin() fit better here?

> +	u64 coal_hdr_nlo_err;
> +	u64 coal_hdr_pkt_err;

[ ... ]

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 1f9e592e24b65..2e76bf5a5a90c 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c

[ ... ]

> @@ -756,25 +763,33 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,

[ ... ]

>  	} else if (iph->version == 6) {
> -		if (coal_skb->len < sizeof(*ip6h))
> +		if (coal_skb->len < sizeof(*ip6h)) {
> +			priv->stats.coal_ip_invalid++;
>  			return false;
> +		}
>  
>  		ip6h = (struct ipv6hdr *)iph;
>  		protocol = ip6h->nexthdr;
>  		meta->ip_proto = 6;
>  		ret = ipv6_skip_exthdr(coal_skb, sizeof(*ip6h), &protocol,
>  				       &frag_off);
> -		if (ret < 0 || frag_off)
> +		if (ret < 0 || frag_off) {
> +			priv->stats.coal_ip_invalid++;
>  			return false;
> +		}
>  
>  		meta->ip_len = (u16)ret;
>  		^^^^

[Severity: High]
This code came in with the earlier commit "net: qualcomm: rmnet: Add DL
packet coalescing support" in this series. It is still present at the
end of the series.

Is meta->ip_len ever checked against coal_skb->len on the IPv6 path in
rmnet_map_coal_parse_ip_hdr()?

ipv6_skip_exthdr() only reads the first two bytes of each extension header
through skb_header_pointer(). It then adds ipv6_optlen() (up to 2048) to
start and returns that value. It never checks that the last extension
header fits in the skb.

For example, take a 48 byte IPv6 packet with a Destination Options header
that has hdrlen=255 and nexthdr=UDP. That gives ip_len = 2088.

rmnet_map_coal_parse_trans_hdr() then does:

    base = (u8 *)meta->ip_header + meta->ip_len;
    avail = coal_skb->len - meta->ip_len;

Here avail wraps to a large u32, so the avail < sizeof(*th) and
avail < sizeof(*uh) checks pass. For TCP, th->doff would then be read
from about 2KB past the data.

rmnet_map_coal_validate_bounds() has the same underflow:

    if (total_data + nlo_len > coal_skb->len - hlen)
        return false;

So an NLO pkt_len just above hlen passes. Because ip_len > 40 sets
gro = false, the fast path is skipped. With a zero checksum error bitmap
and a close type that rmnet_map_v5_csum_fixup() does not catch (such as
NON_COAL), rmnet_map_coal_segment_loop() calls
__rmnet_map_segment_coal_skb(), which does:

    memcpy(skbn->data, coal_meta->ip_header, coal_meta->ip_len);

The earlier skb_put_data() and transport header copies there also read
past the buffer that rmnet_map_deaggregate() allocated.

Can this copy about 2KB of adjacent slab memory into an skb that is
marked CHECKSUM_PARTIAL and passed up the IPv6 stack? Could the stack
then send part of it back out, for example in an ICMPv6 parameter problem
error for unknown TLV options?

The full copy needs an NLO pkt_len larger than the real data, which means
buggy or compromised modem firmware. The out-of-bounds th->doff read in
rmnet_map_coal_parse_trans_hdr() only needs a truncated IPv6/TCP packet
inside a coalescing frame.

>  		meta->trans_proto = protocol;

[ ... ]

> @@ -1023,20 +1094,25 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
>  					    u64 *nlo_err_mask)
>  {
>  	struct rmnet_map_header *maph = (struct rmnet_map_header *)skb->data;
> +	struct rmnet_priv *priv = netdev_priv(skb->dev);
>  	struct rmnet_map_v5_coal_header *coal_hdr;
>  	u8 num_nlos, pkts = 0;

[ ... ]

> @@ -1044,10 +1120,19 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
>  
>  		mask |= ((u64)err) << (8 * i);
>  		pkts += pkt;
> -		if (pkts > RMNET_MAP_V5_MAX_PACKETS)
> +		if (pkts > RMNET_MAP_V5_MAX_PACKETS) {
> +			priv->stats.coal_hdr_pkt_err++;
>  			return -EINVAL;
> +		}
>  	}
>  
> +	priv->stats.coal_pkts += pkts;

[Severity: Medium]
pkts is a u8, and each nl_pairs[i].num_packets is a u8 supplied by the
device. Can the running sum in pkts += pkt wrap and bypass the
RMNET_MAP_V5_MAX_PACKETS check?

For example, num_packets values of 48, 255, 255, 255, 255, 255 give
running sums of 48, 47, 46, 45, 44 and 43. The check never fires, but the
frame claims 1323 packets.

rmnet_map_coal_validate_bounds() only limits (plen - hlen) * num_packets,
and that is zero when plen == hlen. So it doesn't catch this either.

rmnet_map_coal_segment_loop() then walks every claimed packet. In the
non-GRO path it allocates a GFP_ATOMIC skb for each one. The u8 total_pkt
used for the IPv4 ID adjustment wraps as well.

The new coal_pkts counter above also records the wrapped value.

The u8 accumulator came in with the earlier commit "net: qualcomm: rmnet:
Add DL packet coalescing support" in this series. It is still present at
the end of the series.

[ ... ]

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index e1e319683a558..a21d6543c014f 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> @@ -183,6 +183,26 @@ static const char rmnet_gstrings_stats[][ETH_GSTRING_LEN] = {
>  	"Checksum skipped",
>  	"Checksum computed in software",
>  	"Checksum computed in hardware",
> +	/* DL coalescing */
> +	"Coal frames received",
> +	"Packets in coal frames",
> +	"Coal hdr NLO errors",
> +	"Coal hdr pkt count errors",
> +	"Coal checksum errors",
> +	"Coal packets dropped on csum err",

[Severity: Medium]
Do some of these duplicate counters that already have a standard uAPI?

"Coal frames received" (coal_rx) and "Packets in coal frames" (coal_pkts)
look like the qstats rx-hw-gro-packets and rx-hw-gro-wire-packets
counters (hw_gro_packets and hw_gro_wire_packets in struct
netdev_queue_stats_rx). rmnet advertises NETIF_F_GRO_HW and uses it to
gate the coalesced delivery path in rmnet_map_segment_coal_skb().

"Coal packets dropped on csum err" (coal_csum_drop) is an RX drop, which
the standard drop counters already cover. "Coal checksum errors"
(coal_csum_err) partly overlaps rx-csum-bad.

The networking driver guidance limits ethtool -S to counters that have no
standard representation, such as the close reasons and the header NLO and
packet count errors here.

Could these be reported through netdev qstats and the standard drop
counters instead?

> +	"Coal segments reconstructed",
> +	"Coal invalid IP version",

[Severity: Low]
Does this label match what coal_ip_invalid counts?
rmnet_map_coal_parse_ip_hdr() increments it for:

- a truncated IPv4 or IPv6 header
- a bad IHL
- an IPv4 fragment
- an ipv6_skip_exthdr() failure or an IPv6 fragment
- an unknown version

Only the last one is an invalid IP version.

Similarly, rmnet_map_data_check_coal_header() also bumps "Coal hdr NLO
errors" when the MAP pkt_len is too short:

    if (ntohs(maph->pkt_len) < sizeof(*coal_hdr)) {
        priv->stats.coal_hdr_nlo_err++;

That is a length error, not an NLO count error.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930051345.857443-1-subash.a.kasiviswanathan%40oss.qualcomm.com
