Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329708;
	b=bbw0kRmZtDS+VV8fwTxW1kjfCK7kI5ckBprbexTwx/zVt13//vxiC2OShJt/soruNUl5
	 QIRVaU8Kt82C/XWaFF+Gn8ISG3WZ08eT38OTNaEufEW1fGYm0NrF8rmJwfgMXNmP4FQ5K
	 4HvCDvKcek1YqvKI4/UzZp0M9VTTTb8xsXTBQAEKVzRxaKisgepS8y2CEidQO2A9JznAR
	 4fP2qICBxDRySTbIYJdo0MimCA4Ww5Ckgi0o4/CYm1NBi7fzm7UdTSxnixu1wPHwT+qCQ
	 iTLDcZRUQQdwY0w3wqYzueSk6Acej1LyhiVDipIeEYwciOgNvUcBWB8q8ITQ1tanbTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329708;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iNupz0xaaxdVkmd+anzVuszGFqY4ZqIx7t/JpJhLpF4=;
	b=QDj8HxmgMmGjalCAzEno+bQ/rYzUhgZ3XYn+udEtGT8YTqYgeRg76kfS+wZC4AEPd1yn
	 LBBLP5Xe/wKwSgxNTryx/j5tixdNu4DB23y1BVZsJ7Jhcx/Y9249a7JvEKPYSYJHTGmUh
	 5RlRNbq+YXOU+3I49OjwMu0m5FH3s9w2dGZN6A/698rFmncDElyLFDlzCW+3wsLNluj0s
	 w0otLPGnJfufoHxARFOrbCtQJAMLjq8wzGJKDUa3nvuuXMpDWIzFCIY3bTthKQzFQuERG
	 ET+holJdsi8ju4n4trvQClrRlsKMGToIyitKTvFlFKhEswbnWC88ANb5QG+H2IXkV4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liRPfORr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8060A381A;
	Tue, 10 Nov 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liRPfORr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239AA1F0092A;
	Tue, 10 Nov 2026 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329707;
	bh=iNupz0xaaxdVkmd+anzVuszGFqY4ZqIx7t/JpJhLpF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=liRPfORrBr2t2pxwW+m6JN2kN06k7Bfkr0FI+ixTG8HnzAaqy8oGKWtujrNVqK1c+
	 SR5kOjLt+tHVnjQupX5tR04h9t9LLJrkXNe88/lxVVAaMjHjPglZD3KHjp8cR0AYK3
	 zyxStCyaeA7TzMV6rsU6pcHpj6KL5lUY7FlRh1bJBBdcGUaQgfTkGi2UDVfDg8oCl7
	 V1VO8z59aIcXR2Qadg4lVJEOnBqojz0bb+z0GcXRKEj9v1pLwxF8tCgrp4cabFi5ky
	 AYoAjlotma0ciED9cJk5BCQdbSexc8lEWJWnyuFacgA/2+cmODtVSU9LBHl3kPraVg
	 CgVsONMtl2ENQ==
Subject:
 Re: [PATCH net-next 5/5] net: rnpgbe: Add hardware and queue statistics
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, yaojun@mucse.com
Date: Tue, 10 Nov 2026 16:55:06 +0000
Message-ID: <179432970666.994134.9375673773924057046@kernel.org>
In-Reply-To: <07F76435DD841B31+20261106112556.44266-1-dong100@mucse.com>
References: <07F76435DD841B31+20261106112556.44266-1-dong100@mucse.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes the rtnl and qstats RX totals count different
  things, so after any RX drop they can never match again.
- [Medium] rnpgbe_read_stats()
  (drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c) adds (u32)(value -…
- [Low] In rnpgbe_get_strings()
  (drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c), the loop index is…

--

net: rnpgbe: Add hardware and queue statistics

This commit adds hardware RX CRC-error and multicast counters to
ndo_get_stats64. The service task accumulates them, and the totals are
kept across down/up cycles. It also reports per-queue RX/TX packet and
byte counters and rx-alloc-fail through netdev queue stats, and exposes
per-queue TX DMA mapping failures through ethtool statistics.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c
> new file mode 100644
> index 0000000000000..595faa16b7d0d
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c

[ ... ]

> +static void rnpgbe_get_queue_stats_rx(struct net_device *netdev, int idx,
> +				      struct netdev_queue_stats_rx *stats)
> +{
> +	struct mucse *mucse = netdev_priv(netdev);
> +	const struct mucse_queue_stats *queue;
> +	unsigned int start;
> +
> +	queue = &mucse->rx_stats[idx];
> +	do {
> +		start = u64_stats_fetch_begin(&queue->syncp);
> +		stats->packets = queue->delivered_packets;
> +		stats->bytes = queue->delivered_bytes;
> +	} while (u64_stats_fetch_retry(&queue->syncp, start));

[Severity: Medium]
After an RX drop, can the qstats rx-packets/rx-bytes totals ever match the
rtnl totals again?

rnpgbe_get_stats64() fills rx_packets/rx_bytes from rx_stats[i].packets
and rx_stats[i].bytes. rnpgbe_clean_rx_irq() also increments those for
packets the driver drops. One example is an skb build failure at EOP:

rnpgbe_clean_rx_irq() {
    ...
		if (!skb) {
			atomic64_inc(&rx_ring->stats->skb_alloc_failures);
			...
			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)) {
				total_rx_bytes += size;
				total_rx_packets++;
				total_rx_dropped++;
    ...
}

Resource drops at EOP (drop_bytes) and rnpgbe_cleanup_headers() drops with
size >= ETH_HLEN are counted the same way. delivered_packets and
delivered_bytes are only incremented just before napi_gro_receive().
rnpgbe_get_base_stats() also sums the inactive queues through this
callback.

The counters persist across down/up. So after a single drop, qstats stays
lower than rtnl for the life of the device.

pkt_byte_sum() in tools/testing/selftests/drivers/net/stats.py requires
the two to be equal:

        qstat = get_qstat(cfg)
        if stat_cmp(rtstat, qstat) > 0:
            raise KsftFailEx("Qstats are lower, fetched later")

Before this patch the device had no stat_ops, so this test was skipped.
With this patch the test runs, and it fails after any such drop, even on
an idle link.

Could both interfaces report the same values? Alternatively, could the
dropped packets be reported through matching qstats fields so the device
totals agree?

> +	stats->alloc_fail = atomic64_read(&queue->page_alloc_failures) +
> +			    atomic64_read(&queue->skb_alloc_failures);
> +}

[ ... ]

> +static void rnpgbe_read_stats(struct mucse *mucse)
> +{
> +	struct mucse_hw_stats *stats = &mucse->hw_stats;
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 value;
> +	int i;
> +
> +	/* These 32-bit counters do not clear on read. Unsigned differences
> +	 * extend them across wraparound; hardware reset clears them.
> +	 */
> +	value = mucse_hw_rd32(hw, RNPGBE_ETH_RX_FCS_ERRORS);
> +	stats->rx_crc_errors += (u32)(value - stats->rx_crc_errors_prev);
> +	stats->rx_crc_errors_prev = value;

[Severity: Medium]
What happens here if the counter goes backwards, or if the read returns
0xFFFFFFFF?

The comment says a hardware reset clears these counters. However, the
prev snapshots are only taken from known hardware state once, in
rnpgbe_init_stats() at probe time.

The driver has no pci_error_handlers and no reset_prepare/reset_done
hooks. A runtime reset can therefore clear the counters while the driver
is still bound. Examples are a PCI function reset through sysfs, or AER
recovery of the parent bus. readl() can also return all-ones during a
PCIe error or link-down window.

In either case (u32)(value - prev) wraps, and about 2^32 - prev bogus
events are added to rx_crc_errors, rx_errors and multicast. The totals
are kept across down/up and only reset when the driver is reloaded. One
bad sample from rnpgbe_service_task() or rnpgbe_down() would inflate the
ndo_get_stats64 output until then.

The driver already notes in mucse_check_for_msg_pf() that chip registers
go back to 0 after a reset:

	/* chip's register is reset to 0 when rc send reset
	 * mbx command. Return -EIO if in this state, others
	 * fw == hw->mbx.fw_req means no new msg.

Should rnpgbe_read_stats() reject all-ones reads, and take a new snapshot
when it sees that a counter has been reset?

> +
> +	for (i = 0; i < mucse->num_rx_queues; i++) {
> +		u32 index = mucse->rx_ring[i]->rnpgbe_queue_idx;
> +
> +		value = mucse_hw_rd32(hw, RNPGBE_DMA_RX_MULTICAST(index));
> +		stats->multicast += (u32)(value - stats->multicast_prev[i]);
> +		stats->multicast_prev[i] = value;

The same question applies to the per-ring multicast counters here.

> +	}
> +}

[ ... ]

> +void rnpgbe_get_strings(struct net_device *netdev, u32 sset, u8 *data)
> +{
> +	struct mucse *mucse = netdev_priv(netdev);
> +	int i, j;
> +
> +	if (sset != ETH_SS_STATS)
> +		return;
> +
> +	for (i = 0; i < mucse->num_tx_queues; i++)
> +		for (j = 0; j < ARRAY_SIZE(rnpgbe_tx_queue_stats); j++)
> +			ethtool_sprintf(&data, "tx_queue_%u_%s", i,
> +					rnpgbe_tx_queue_stats[j].name);

[Severity: Low]
This isn't a bug, but i is a signed int and it is passed to a %u format
in ethtool_sprintf(). The output is correct because i is never negative,
but -Wformat-signedness would flag it. Declaring i as unsigned int, or
using %d, would make the type and format match.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/FB722C2F25FE9005%2B20261106112420.43050-1-dong100%40mucse.com
