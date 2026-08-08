Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE723CB8F4;
	Sat,  8 Aug 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218518; cv=none; b=fP3J9s3IqpA/cy4CiCqdKoJ9RO6iqwEwH0MUsSdsEk8UegnRQx6QNUc9IgdINK3FZuIl1qiCOJtsScczCeNrD/SfCNvOBPpVBlzMegbpLm0WP+LYja43ElT8yPW4VSYtu9K4RWtqadue1bjnlK1SiOC/SpkpEI+J3A0kWkGmh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218518; c=relaxed/simple;
	bh=nJ9fYnwbAZ7hF3f/MZdUBUfrpzjj8c8sOhF74PcJDuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8hsoAB78k2j96HHY0e2Rsuc+QpgvgT1207WkcvYgprsrjgB3z8rZfnV/XIfp+zJ+wsJJE6KRDibeglxqyVJ5hNiV6gMlUZ3ToyT337kNAZ0OHWSFjbyp1NLBkU2N/SsvmUZ9zdiwMHbeFFQReBvHFye7ZQvtheDZYpF4R3gFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfSIkTH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfSIkTH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A131F00A3A;
	Sat,  8 Aug 2026 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218515;
	bh=xXp6ZoGK84MvvlJTzzaUN/dyQ7ZGLIkkY7rr+kNxwww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfSIkTH2l1trA5YIYqrihWyivek5E9qg0pvSi1t8/yJXoSdYc+Ii1MSE8kXgy15xt
	 5l2bgYMo/xbfK8tK/5Gd4Kf4w+/dgzyIC8R9ntykLpiqR3yn8c02/9PAES5CK4kghM
	 y1UCA46W3onuJNk4n4+gRtREZoEirQBqt9K5tUf/nfyF8w3v64yyIMA0E2eODnRI4B
	 YK70LFtielyqTh8KWN+Oq1oh6VHiaanU+mHrHU9+9OgdoZmhgOIiFRwKscm4IWVhVl
	 ThWE1RJUAhELoQMZq0ZaTLOKO7XV7pAtmsFQMpm+GW0emoouRagwhU1BuMlsdSFMCL
	 bf3dutJM/PBvA==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 16/20] net: dsa: xilinx: drive per-MAC PTP TX/RX hardware paths
Date: Sat,  8 Aug 2026 12:48:34 -0700
Message-ID: <20260808194834.133389-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-17-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-17-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    net: dsa: xilinx: drive per-MAC PTP TX/RX hardware paths

This adds the per-MAC PTP TX and RX hardware paths to the Xilinx TSN DSA
driver: the tag protocol diverts PTP frames into a per-MAC hardware TX
slot through a ds->tagger_data callback, and two new per-MAC interrupts
drive TX timestamp completion and direct RX delivery to the user port.
It also wires up port_hwtstamp_get/set and get_ts_info.

A few questions about the new paths below.

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index 318d8b332208..e48c81f18d6e 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c

[ ... ]

> @@ -692,7 +710,10 @@ static void xlnx_tsn_teardown(struct dsa_switch *ds)
>  {
>  	struct xlnx_tsn *sw = ds->priv;
>  	struct dsa_port *dp;
> +	int port;
>  
> +	for (port = XLNX_TSN_PORT_MAC1; port <= XLNX_TSN_PORT_MAC2; port++)
> +		xlnx_tsn_port_ptp_exit(sw, port);
>  	xlnx_tsn_ptp_exit(sw);
>  	unregister_netdevice_notifier(&sw->nb);
>  	xlnx_tsn_mdio_unregister_all(sw);

[ ... ]

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
> index 6063763b5c17..d46150535775 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.h
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.h

[ ... ]

> @@ -127,7 +131,44 @@ enum tsn_port_state {
>  #define TSN_TIMER_PULSES_PER_PPS	128
>  #define TSN_TIMER_GTX_CLK_FREQ		125000000U
>  
> +/* Per-MAC PTP TX / RX register windows, sitting inside each per-MAC
> + * reg space. Each PTP TX slot is 256 B wide; the first 8 B hold the
> + * cmd1/cmd2 header, leaving 248 B for frame data. HW provides 8 slots.
> + * The PTP RX buffer mirrors the layout with a 252 B usable area and
> + * an 8 B HW timestamp footer.
> + */

[ ... ]

> +#define TSN_PTP_TX_CMD_FIELD_LEN	8
> +#define TSN_PTP_TX_MAX_FRAME_SIZE	(TSN_PTP_TX_HWBUF_SIZE - \
> +					 TSN_PTP_TX_CMD_FIELD_LEN)

[ ... ]

> +#define TSN_PTP_HW_TSTAMP_SIZE		8
> +#define TSN_PTP_RX_HWBUF_SIZE		256
> +#define TSN_PTP_RX_FRAME_SIZE		252
> +#define TSN_PTP_HW_TSTAMP_OFFSET	(TSN_PTP_RX_HWBUF_SIZE - \
> +					 TSN_PTP_HW_TSTAMP_SIZE)

[Severity: Medium]
Do these numbers add up?  The comment says "a 252 B usable area and an 8 B
HW timestamp footer", but 252 + 8 is larger than the 256 B slot.

TSN_PTP_HW_TSTAMP_OFFSET is 256 - 8 = 248, so the footer sits at slot bytes
248..255, which leaves at most 248 usable bytes, not 252.

In xlnx_tsn_ptp_recv() both the copy length and the bound check use 252:

	memcpy_fromio_32(m, frame_base, skb->data, TSN_PTP_RX_FRAME_SIZE);
	...
	if (msg_len + ETH_HLEN > TSN_PTP_RX_FRAME_SIZE) {
	...
	skb_put(skb, msg_len + ETH_HLEN);

so for a frame where msg_len + ETH_HLEN lands in (248, 252] the skb ends up
carrying up to 4 bytes of the timestamp footer as payload.  Should
TSN_PTP_RX_FRAME_SIZE be 248?

The TX side has the mirror of this.  TSN_PTP_TX_MAX_FRAME_SIZE is 248 and
frame data starts at slot offset 8, so a maximum-length frame writes slot
bytes 8..255 - including the address xlnx_tsn_tx_tstamp_work() then reads
back as the transmit timestamp:

	ts_off = TSN_PTP_TX_BUFFER_OFFSET(index) +
		 TSN_PTP_HW_TSTAMP_OFFSET;

Should the accepted TX length be 240 for this layout?  As a side note,
TSN_PTP_HW_TSTAMP_OFFSET is derived from TSN_PTP_RX_HWBUF_SIZE but is also
applied to TX slots; it only works because both happen to be 256.

[ ... ]

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
> index 75c177f752f1..740d92e3e80d 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c

[ ... ]

> @@ -233,3 +241,350 @@ void xlnx_tsn_ptp_exit(struct xlnx_tsn *sw)
>  	ptp_clock_unregister(sw->ptp_clock);
>  	sw->ptp_clock = NULL;
>  }
> +
> +static void memcpy_toio_32(struct xlnx_tsn_mac *m, unsigned long off,
> +			   const u8 *data, size_t len)
> +{
> +	while (len >= 4) {
> +		mac_iow(m, off, get_unaligned((const u32 *)data));
> +		off += 4;
> +		data += 4;
> +		len -= 4;
> +	}
> +
> +	if (len) {
> +		u32 leftover = 0;
> +		u8 *dst = (u8 *)&leftover;
> +
> +		while (len--)
> +			*dst++ = *data++;
> +		mac_iow(m, off, leftover);
> +	}
> +}
> +
> +static void memcpy_fromio_32(struct xlnx_tsn_mac *m, unsigned long off,
> +			     u8 *data, size_t len)
> +{
> +	while (len >= 4) {
> +		put_unaligned(mac_ior(m, off), (u32 *)data);
> +		off += 4;
> +		data += 4;
> +		len -= 4;
> +	}

[Severity: Medium]
Is it intentional that frame data is moved with the byte-swapping register
accessors?  mac_iow()/mac_ior() in xilinx_tsn.h are iowrite32()/ioread32():

	static inline void mac_iow(struct xlnx_tsn_mac *m, u32 off, u32 val)
	{
		iowrite32(val, m->regs + off);
	}

	static inline u32 mac_ior(struct xlnx_tsn_mac *m, u32 off)
	{
		return ioread32(m->regs + off);
	}

Those apply cpu_to_le32()/le32_to_cpu(), which is right for control and
status registers but not for a frame byte stream.  On a big-endian host
memcpy_toio_32() assembles a host-order u32 out of four consecutive frame
bytes and writes it byte-reversed into the slot, so the MAC transmits a
corrupted frame; memcpy_fromio_32() has the mirrored effect on receive, so
eth_type_trans(), the messageType byte at ETH_HLEN and get_unaligned_be16()
all parse swapped bytes.

The Kconfig entry only depends on OF && HAS_IOMEM && NET_DSA &&
PTP_1588_CLOCK, so big-endian hosts of this soft IP are not excluded.  Would
raw/stream accessors (__raw_writel/__raw_readl, iowrite32_rep/ioread32_rep,
or memcpy_toio/memcpy_fromio) be more appropriate here?

[ ... ]

> +void xlnx_tsn_ptp_tx(struct dsa_port *dp, struct sk_buff *skb)
> +{
> +	struct xlnx_tsn *sw = dp->ds->priv;
> +	u32 frame_waiting, cmd1, cmd2 = 0;
> +	struct xlnx_tsn_mac *m;
> +	u8 free_index;
> +
> +	m = &sw->mac[dp->index];
> +
> +	if (unlikely(skb->len > TSN_PTP_TX_MAX_FRAME_SIZE)) {
> +		dev_kfree_skb_any(skb);
> +		return;
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &m->ptp_tx_lock) {
> +		frame_waiting = FIELD_GET(TSN_PTP_TX_FRAME_WAITING_MASK,
> +					  mac_ior(m, TSN_PTP_TX_CONTROL_OFFSET));
> +		if (frame_waiting & TSN_PTP_TX_BUFFERS_FULL_MASK) {
> +			dev_kfree_skb_any(skb);
> +			return;
> +		}
> +
> +		free_index = fls(frame_waiting);

[Severity: High]
Can this slot allocator hand out a slot that an skb still sitting in
m->ptp_txq owns?

free_index comes from the hardware "frames waiting to be transmitted"
bitmap, which clears when a frame departs, while ptp_txq holds frames that
have not yet been timestamped - the TX IRQ only calls schedule_work().  So:

	frame A: free_index = fls(0) = 0, queued with cb[0] = 0, departs
	         HW clears bit 0, TX IRQ schedules tx_tstamp_work
	frame B: reads frame_waiting == 0, free_index = fls(0) = 0 again,
	         queued with cb[0] = 0

xlnx_tsn_tx_tstamp_work() then reads tx_packet == 0 and drains both skbs,
handing frame B a timestamp read out of slot 0 that belongs to frame A.

The reverse ordering looks worse: if the queue head carries a high index
(say 5) and later frames get low indices, this test in
xlnx_tsn_tx_tstamp_work() never becomes true again:

	if (index > tx_packet) {
		__skb_queue_head(&m->ptp_txq, skb);
		break;
	}

so the head is requeued forever, no further TX timestamps are delivered for
that port, and skbs accumulate until the driver is unbound.

TSN_PTP_TX_PACKET_FIELD_MASK is GENMASK(18, 16), i.e. 3 bits, so the status
value wraps 0..7 - can it be used as a monotonic ordering key at all?
Would tracking slot ownership in software (a used-slot bitmap plus the
queued index) be more robust?

> +		cmd1 = skb->len;
> +
> +		mac_iow(m, TSN_PTP_TX_BUFFER_OFFSET(free_index), cmd1);
> +		mac_iow(m, TSN_PTP_TX_BUFFER_OFFSET(free_index) +
> +			TSN_PTP_TX_BUFFER_CMD2_FIELD, cmd2);
> +		memcpy_toio_32(m,
> +			       TSN_PTP_TX_BUFFER_OFFSET(free_index) +
> +			       TSN_PTP_TX_CMD_FIELD_LEN,
> +			       skb->data, skb->len);

[Severity: High]
Can this read past the end of the linear part of the skb?  memcpy_toio_32()
walks skb->len bytes linearly from skb->data, but nothing here checks
skb_headlen(skb) or calls skb_linearize(), so for a paged skb it reads
beyond the head buffer (into skb_shared_info and past the kmalloc'd area)
and pushes those bytes into the hardware slot, i.e. out onto the wire.

Non-linear skbs do not appear to be filtered out on the way in.  This
tagger sets no needed_tailroom, so dsa_user_setup_tagger() does not strip
the features:

	if (user->needed_tailroom)
		user->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);

and skb_ensure_writable_head_tail() only does pskb_expand_head(), it never
linearizes.  An AF_PACKET send with PACKET_VNET_HDR (attacker-chosen
hdr_len picking a small linear area) or a bridge-forwarded frame whose
ingress driver put payload in fragments would reach this copy.

The same assumption exists one layer up in xlnx_tsn_xmit(), which
dereferences eth_hdr(skb)->h_proto with no guarantee that the 14 byte MAC
header is in the linear area.

> +
> +		skb->cb[0] = free_index;
> +		__skb_queue_tail(&m->ptp_txq, skb);

[Severity: Medium]
What releases these skbs when the port or the link goes down?  The only
paths that dequeue ptp_txq are xlnx_tsn_tx_tstamp_work() (which requires the
completion match to succeed) and xlnx_tsn_port_ptp_exit() at unbind:

	scoped_guard(spinlock_irqsave, &m->ptp_tx_lock)
		while ((skb = __skb_dequeue(&m->ptp_txq)) != NULL)
			dev_kfree_skb_any(skb);

TSN_TC_TX_EN is only set in xlnx_tsn_mac_link_up(), so frames written into a
slot while the link is down never depart, never complete, and hold their
skbs - and with them the owning socket's sk_wmem_alloc charge via
skb->sk/sock_wfree - until the driver is unbound.  Stale skbs from a
previous link-up also stay queued while fls(frame_waiting) re-allocates the
same slot indices.  Would a drain on link down / port disable, or a
timeout, be worth adding?

> +
> +		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
> +			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

[Severity: Medium]
Is m->hwtstamp_tx_type ever consumed?  xlnx_tsn_port_hwtstamp_set() stores
it and xlnx_tsn_port_hwtstamp_get() reports it back, but the TX path gates
only on the skb flag here, and xlnx_tsn_tx_tstamp_work() then gates only on
SKBTX_IN_PROGRESS:

	if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) {
		xlnx_tsn_read_tstamp(m, &hwtstamps, ts_off);
		skb_tstamp_tx(skb, &hwtstamps);
	}

So a socket with SOF_TIMESTAMPING_TX_HARDWARE still gets hardware TX
timestamps on the error queue while the port is configured
HWTSTAMP_TX_OFF.  The RX half of the same ABI does honour its stored state
(READ_ONCE(m->hwtstamp_rx_filter) gates xlnx_tsn_read_tstamp()), so the two
halves disagree.

The commit message says "TX timestamping accepts HWTSTAMP_TX_OFF and
HWTSTAMP_TX_ON" and the kernel-doc calls @hwtstamp_tx_type the "current
SO_TIMESTAMPING TX type for this port", which both suggest the value has an
effect.

Separately, SKBTX_HW_TSTAMP is (SKBTX_HW_TSTAMP_NOBPF | SKBTX_BPF), so this
test also fires for BPF-only timestamping requests; the DSA core uses
SKBTX_HW_TSTAMP_NOBPF in dsa_skb_tx_timestamp().  Was
SKBTX_HW_TSTAMP_NOBPF intended here?

> +
> +		skb_tx_timestamp(skb);
> +		mac_iow(m, TSN_PTP_TX_CONTROL_OFFSET, BIT(free_index));
> +	}
> +}
> +
> +static void xlnx_tsn_ptp_recv(struct xlnx_tsn *sw, int port)
> +{
> +	struct net_device *user = dsa_to_port(&sw->ds, port)->user;
> +	struct xlnx_tsn_mac *m = &sw->mac[port];
> +	unsigned long frame_base;
> +	struct sk_buff *skb;
> +	u16 msg_len;
> +	u8 msg_type;
> +
> +	if (!user || !netif_running(user))
> +		return;

[Severity: High]
Can this dereference a freed net_device during teardown?  dp->user is read
here from hardirq context (xlnx_tsn_ptp_rx_isr() calls this directly) with
no RCU section, lock, or netdev reference, while the PTP RX interrupt is
only released much later, in xlnx_tsn_port_ptp_exit() from ds->ops->
teardown().

The DSA teardown order is ports first, switches second:

net/dsa/dsa.c:dsa_tree_teardown()
	dsa_tree_teardown_ports(dst);	-> dsa_port_teardown()
	dsa_tree_teardown_switches(dst);	-> ds->ops->teardown()

and dsa_port_teardown() frees the netdev before clearing the pointer:

	case DSA_PORT_TYPE_USER:
		if (dp->user) {
			dsa_user_destroy(dp->user);
			dp->user = NULL;
		}

So between dsa_user_destroy() and the dp->user = NULL store, a PTP RX
interrupt reads a non-NULL dangling pointer and runs netif_running(),
netdev_alloc_skb(), eth_type_trans(), dev_sw_netstats_rx_add() and
netif_rx() on it.  Should the PTP RX capture be masked in hardware and the
IRQ freed before the user netdevs go away (or the RX work moved out of
hardirq and synchronised against teardown)?

> +
> +	while ((m->ptp_rx_hw_pointer & 0xf) != (m->ptp_rx_sw_pointer & 0xf)) {

[ ... ]

> +		memcpy_fromio_32(m, frame_base, skb->data,
> +				 TSN_PTP_RX_FRAME_SIZE);
> +
> +		msg_type = *(u8 *)(skb->data + ETH_HLEN) & 0xf;
> +		msg_len = get_unaligned_be16(skb->data + ETH_HLEN + 2);
> +
> +		if (msg_len + ETH_HLEN > TSN_PTP_RX_FRAME_SIZE) {
> +			dev_kfree_skb_any(skb);
> +			DEV_STATS_INC(user, rx_length_errors);
> +			continue;
> +		}
> +
> +		skb_put(skb, msg_len + ETH_HLEN);

[Severity: High]
Does this leak stale slot contents to the network stack?  msg_len is the PTP
messageLength field taken from the wire, not a hardware-reported receive
length, and the only validation is the upper bound above.

memcpy_fromio_32() always copies the full slot, so if a peer sends a short
0x88f7 frame that declares a large messageLength, skb_put() hands up to
~238 bytes of whatever was previously in that per-MAC RX slot (earlier
frames from other hosts, or uninitialised FPGA buffer content - the slot is
never zeroed) to netif_rx(), and from there to any listener or bridge port.

There is also no lower bound: msg_len may be 0 or shorter than the PTP
common header, and nothing cross-checks it against the number of bytes the
hardware actually received.  Is there a hardware length field for the slot
that could be used instead?

> +		skb->protocol = eth_type_trans(skb, user);
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;

[ ... ]

> +		dev_sw_netstats_rx_add(user, skb->len);

[Severity: Medium]
Should this add ETH_HLEN back?  eth_type_trans() has already pulled the 14
byte MAC header, while the core DSA receive path feeds the same per-CPU
tstats counter on the same netdev in the other unit:

net/dsa/tag.c:dsa_switch_rcv()
	dev_sw_netstats_rx_add(skb->dev, skb->len + ETH_HLEN);

As it stands, rx_bytes reported through rtnl_link_stats64 under-counts PTP
frames by 14 bytes relative to every other frame on the same interface.

[Severity: Medium]
Is the non-irqsave u64_stats writer safe here?  This runs in hardirq
context (request_irq() with flags 0 and no threaded handler), and
dev_sw_netstats_rx_add() uses plain u64_stats_update_begin()/
u64_stats_update_end() on the DSA user device's per-CPU syncp, which is
also written from the transmit path:

net/dsa/user.c:dsa_user_xmit()
	dev_sw_netstats_tx_add(dev, 1, skb->len);

On 32-bit SMP those are real seqcount operations, so:

	dsa_user_xmit() -> u64_stats_update_begin()   (seq odd)
	  PTP RX hardirq on the same CPU
	    dev_sw_netstats_rx_add() -> begin()/end() (seq even again)
	  reader in dev_get_tstats64() sees an even seq mid-update

There is no _irqsave flavour of dev_sw_netstats_rx_add(), so would a
threaded IRQ / NAPI context for the RX path, or open-coded _irqsave
counter updates, be needed?

> +		netif_rx(skb);
> +	}
> +}

[ ... ]

> +static irqreturn_t xlnx_tsn_ptp_tx_isr(int irq, void *data)
> +{
> +	struct xlnx_tsn_mac *m = data;
> +
> +	mac_ior(m, TSN_PTP_TX_CONTROL_OFFSET);
> +	schedule_work(&m->tx_tstamp_work);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
How are these two interrupts acknowledged?  This handler reads
TSN_PTP_TX_CONTROL_OFFSET and throws the value away, and
xlnx_tsn_ptp_rx_isr() only samples the RX packet pointer without ever
writing TSN_PTP_RX_PACKET_CLEAR, while the PPS handler in the same file
does an explicit write to clear:

	mac_iow(&sw->mac[XLNX_TSN_PORT_MAC1], TSN_TIMER_INTERRUPT,
		TSN_TIMER_INT_CLEAR);

If the discarded read is a read-to-clear acknowledge, then the
TSN_PTP_TX_PACKET_FIELD_MASK status has already been consumed by the time
xlnx_tsn_tx_tstamp_work() re-reads the register for tx_packet.  If it is
not an acknowledge, does the line stay asserted until genirq's spurious
interrupt detector disables it?  Either way, a bare register read with no
comment is hard to follow.

> +
> +int xlnx_tsn_port_ptp_init(struct xlnx_tsn *sw, int port,
> +			   const char *rx_name, const char *tx_name)
> +{

[ ... ]

> +	mac_iow(m, TSN_PTP_RX_CONTROL_OFFSET, TSN_PTP_RX_PACKET_CLEAR);
> +
> +	ret = request_irq(m->ptp_rx_irq, xlnx_tsn_ptp_rx_isr, 0, rx_name, m);

[Severity: Medium]
Why is the RX pointer reset here but the TX block left untouched?  The
first transmit consumes TSN_PTP_TX_FRAME_WAITING_MASK and the first
completion pass consumes TSN_PTP_TX_PACKET_FIELD_MASK exactly as the
hardware left them.

After a rebind, or a warm reset, or a boot stage that already used the PTP
TX block, those fields can be non-zero:

  - a stale bit 7 makes xlnx_tsn_ptp_tx() take the "buffers full" branch and
    free every PTP frame from then on
  - other stale bits make fls(frame_waiting) pick a slot while ptp_txq is
    empty
  - a stale TX_PACKET makes the first xlnx_tsn_tx_tstamp_work() pass read a
    timestamp footer out of a slot that never transmitted and report it to
    userspace

xlnx_tsn_port_ptp_exit() also frees the IRQs and drains ptp_txq but leaves
the PTP TX/RX paths armed and any waiting bit set, so the next bind starts
from that state.  Should init clear the TX control fields (and exit quiesce
the hardware)?  Also, both this write and mac_iow(m,
TSN_PTP_TX_CONTROL_OFFSET, BIT(free_index)) are full-register writes to
registers that carry other fields - is a read-modify-write needed?

[ ... ]

> diff --git a/net/dsa/tag_xlnx_tsn.c b/net/dsa/tag_xlnx_tsn.c
> index de352aa3d9a8..6f487ad7bcf9 100644
> --- a/net/dsa/tag_xlnx_tsn.c
> +++ b/net/dsa/tag_xlnx_tsn.c
> @@ -3,14 +3,41 @@
>   * AMD/Xilinx TSN Endpoint Ethernet MAC tag protocol.
>   */
>  

[ ... ]

>  static struct sk_buff *xlnx_tsn_xmit(struct sk_buff *skb,
>  				     struct net_device *dev)
>  {
> -	return skb;
> +	struct xlnx_tsn_tagger_data *tagger_data;
> +	struct dsa_port *dp;
> +
> +	dp = dsa_user_to_port(dev);
> +	tagger_data = dp->ds->tagger_data;
> +
> +	if (!tagger_data || !tagger_data->ptp_tx)
> +		return skb;
> +
> +	if (eth_hdr(skb)->h_proto != htons(ETH_P_1588) ||
> +	    skb_vlan_tag_present(skb))
> +		return skb;
> +
> +	tagger_data->ptp_tx(dp, skb);

[Severity: Medium]
This matches on the ethertype only, so every non-VLAN 0x88f7 frame is
diverted into the 248 byte hardware slot, not just the PTP event frames the
commit message describes ("PTP event frames bypass the switch fabric").
Announce, signalling and management messages carrying TLVs can exceed 248
bytes.

xlnx_tsn_ptp_tx() then drops such a frame with no accounting:

	if (unlikely(skb->len > TSN_PTP_TX_MAX_FRAME_SIZE)) {
		dev_kfree_skb_any(skb);
		return;
	}
	...
		if (frame_waiting & TSN_PTP_TX_BUFFERS_FULL_MASK) {
			dev_kfree_skb_any(skb);
			return;
		}

Before this patch xlnx_tsn_xmit() returned the skb and it egressed through
the conduit, so this turns those frames into a silent black hole.
dsa_user_xmit() has already counted the frame as transmitted
(dev_sw_netstats_tx_add(dev, 1, skb->len)) before calling the tagger, so
nothing shows up in tx_dropped or tx_errors either.  Should oversized
frames fall back to the normal path, and should the drops bump a counter?

> +
> +	return NULL;
>  }
