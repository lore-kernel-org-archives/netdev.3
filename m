Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663927;
	b=Q56b8n482yvt4RfsQU7vrcdZtDm1+/g3XaTwlqVOsmkRUdc5ohaReaB+6yXyhCBBJxvr
	 eKRDs6wbCi71WgoRlEpcI8f1r+j3El/AuC4C6j0HVqED7lGuTYG7lieFYwVTudMhPCAHF
	 dmYXh3ESKkZ59FuhdGgHrQDU+vlAprsiJI/VZVVBIPpJnS8O9jy4KJDh5/EV1bnKt4SzQ
	 +tzhFrO17UAD85FkpopvGfp/jxj62nQql6xFS5vnvEZwikFXc/PpH1Lr9RDOqqB++S6j7
	 XMQKPQUxFMxR3/jEf9VKFytyjR+yVIfbnkjGaYjZj+kJvMnGH6FemMdMeU3mxBKUv5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663927;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uq3FodfMAH0vjxCPou71TJyKsd6xAfsc55pRZ33hoQk=;
	b=bKCuGvsab7zLOswZuK0upUsMvXyxpiiZ2w1OvZEd90I5idln5tTDprpbXIFZc0QBTlnW
	 DhVHkBkZ1LcM1jNjdHi8iqEebJfMRCxHD+XBNP1vn2Lj1SAsglZf1wGNXnpm6EuCCnMmY
	 AcK2KPIjXjcY+rdXoFy1FJPHb7WEK7+89TPL6DcCt6HeJS4wyP04CVBBzlrmPhVTZjmBH
	 8mMGvuHVtXpgNm0xy4GkAa2XyfU7N0eHWR8c4FfzNNItWjWNlC46J9y+h7vaWQcvutaPs
	 oC5kR+Ookogx3A1IT4QFFDEs9IJ+cI5bU8FQjA1ZhCft8qJdy/ZwpjW26f9bbmdPvWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RJo+UB/n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72617606A320;
	Thu, 22 Oct 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJo+UB/n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613211F000C2;
	Thu, 22 Oct 2026 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663926;
	bh=uq3FodfMAH0vjxCPou71TJyKsd6xAfsc55pRZ33hoQk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RJo+UB/np8wZnrh/S7g7QIBAgkILmQQwjayPp74zvgMMDFFT74pSzeyeuC/z6DLCP
	 s5ji7RUlc+sjqj8VP8OHRVcyGyAkKBrC3QE+3mPAfqryXiHYws0lkrN5YTdVTn3Y+N
	 2WltLm2/1AJQG7W4T52kv8aA0M0LIsiQsR6plXtMx0GN2SPT9m2N7oc4obVDsZ4WFD
	 /Z7ALzDVfJ0R4LXYNtJZRJWOwc01w8MTOn2gTQG3hnSA9vYrjvKMCQVpt2ol+V21vE
	 NhwQzfTDlPdR1pvz76Z/YloD5+Q6aN2q8P/hyKYLSQ0r9lcKY0fc8EjMO7Mu3AY9Vo
	 aL3ojNnHOVdSQ==
Subject: Re: [PATCH net-next v2 2/2] net: dsa: qca8k: report port statistics
 from the MIB
From: netdev-bot+sashiko@kernel.org
To: kuncy7@gmail.com
Cc: ansuelsmth@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 10:12:04 +0000
Message-ID: <179266392495.3135.7190444843649344817@kernel.org>
In-Reply-To: <20261019191137.307514-3-kuncy7@gmail.com>
References: <20261019191137.307514-3-kuncy7@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] With the new QCA8K_MIB_ALL_PORTS mode,
  qca8k_mib_autocast_handler() (qca8k-8xxx.c:1685-1691) uses…
- [High] qca8k_mib_autocast() leaves mib_eth_data->data and req_port set
  after wait_for_completion_timeout() times out, and nothing marks the…
- [Medium] qca8k_mib_delta() (drivers/net/dsa/qca/qca8k-8xxx.c:1869-1888)
  handles a backwards step differently by counter width.
- [Medium] Nothing resets or re-baselines mib_stats.last[] or stats[]
  when the hardware MIB is reset.
- [Medium] On the register fallback path, qca8k_mib_stats_poll() skips
  any port whose link_map bit is clear (qca8k-8xxx.c:1968-1969).
- [Medium] Arming and cancelling the work are not symmetric.
- [Medium] ms->raw[][] has no common lock between its writers and
  readers.
- [Low] qca8k_mib_bytes() (qca8k-8xxx.c:1891-1897) clamps each poll's
  FCS-corrected byte delta to zero.

Pre-existing issues:
- [Medium] Not introduced by this patch.

--

net: dsa: qca8k: report port statistics from the MIB

This adds a .get_stats64 implementation for qca8k that reports per-port
counters from the switch MIB. A delayed work polls the MIB every 3 s. It
uses one autocast request covering all ports when the Ethernet management
path is up, or register reads otherwise, and adds the deltas into a cached
rtnl_link_stats64. The autocast handler gains a QCA8K_MIB_ALL_PORTS mode,
and the register read loop is split out into qca8k_mib_read().

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 9a8b9e34a27c..c95df298988c 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1450,6 +1450,7 @@ qca8k_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
>  	struct dsa_port *dp = dsa_phylink_to_port(config);
>  	struct qca8k_priv *priv = dp->ds->priv;
>  
> +	clear_bit(dp->index, &priv->mib_stats.link_map);
>  	qca8k_port_set_status(priv, dp->index, 0);
>  }

[Severity: Medium]
On the register fallback path, does clearing the bit here lose the last
poll interval of traffic for this port?

qca8k_mib_stats_poll() skips ports whose link_map bit is clear:

    if (!test_bit(port, &ms->link_map))
        continue;

Nothing reads the port's MIB one last time before the bit is cleared. Up
to 3 s of frames that the MAC counted before the link dropped stay in the
hardware MIB. They are missing from stats64 until the link comes back up.

The fallback is the only path when mgmt_conduit is NULL. That includes
every setup with the CPU on port 6, because qca8k_conduit_change() returns
early for dp->index != 0. The fallback is also used whenever the autocast
request times out.

[ ... ]

> @@ -1669,17 +1671,23 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
>  	const struct qca8k_mib_desc *mib;
>  	struct mib_ethhdr *mib_ethhdr;
>  	__le32 *data2;
> +	u64 *data;
>  	u8 port;
>  	int i;
>  
>  	mib_ethhdr = (struct mib_ethhdr *)skb_mac_header(skb);
>  	mib_eth_data = &priv->mib_eth_data;
>  
> -	/* The switch autocast every port. Ignore other packet and
> -	 * parse only the requested one.
> +	/* The switch autocast every port. Parse only the requested one, or
> +	 * every port into its own row for QCA8K_MIB_ALL_PORTS.
>  	 */
>  	port = FIELD_GET(QCA_HDR_RECV_SOURCE_PORT, ntohs(mib_ethhdr->hdr));
> -	if (port != mib_eth_data->req_port)
> +	if (mib_eth_data->req_port == QCA8K_MIB_ALL_PORTS &&
> +	    port < QCA8K_NUM_PORTS)
> +		data = mib_eth_data->data + port * QCA8K_QCA833X_MIB_COUNT;
> +	else if (port == mib_eth_data->req_port)
> +		data = mib_eth_data->data;
> +	else
>  		goto exit;

[Severity: High]
Can the row offset come from one request and the base pointer from
another?

The handler loads req_port and data separately, with no lock, barrier or
request generation check. qca8k_mib_autocast() publishes them with two
plain stores, under a mutex that the RX handler never takes:

    mib_eth_data->req_port = req_port;
    mib_eth_data->data = data;

After a timeout the pair is left in place, so late frames from the
previous request keep using it. The poll now sends ALL_PORTS requests
every 3 s outside rtnl, and these interleave with single-port
ETHTOOL_GSTATS requests. ETHTOOL_GSTATS does not need CAP_NET_ADMIN. A
late frame could then see:

  req_port == QCA8K_MIB_ALL_PORTS   (from the poll)
  data     == the ethtool buffer    (from the new request)

It would then write rows 1 through 6 past the 41 entries that
dsa_user_get_ethtool_stats() reserves at data + 4 in the vzalloc'd buffer
from ethtool_get_stats().

The reverse case also seems possible: req_port comes from a new ALL_PORTS
request while data still points at a timed-out ethtool buffer that
ethtool_get_stats() has already vfree'd. That would write seven rows into
freed memory from softirq.

Before this patch, req_port only decided whether a single row was written.
It never scaled the offset.

>  
>  	data2 = (__le32 *)skb->data;

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch.
qca_tag_rcv() only makes QCA_HDR_LEN bytes linear before it calls
mib_autocast_handler. The loop below then reads up to 164 bytes of
counters straight from skb->data. It never checks skb->len or calls
pskb_may_pull().

Could a truncated or non-linear MIB frame make this read past the packet
data? With this patch those values would also reach stats64.

MIB frames are generated by the switch itself, not by traffic on the
ports.

[ ... ]

> @@ -1708,12 +1716,9 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
>  		complete(&mib_eth_data->rw_done);
>  }
>  
> -static int
> -qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
> +static int qca8k_mib_autocast(struct qca8k_priv *priv, u8 req_port, u64 *data)
>  {

[ ... ]

> @@ -1722,7 +1727,7 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
>  
>  	reinit_completion(&mib_eth_data->rw_done);
>  
> -	mib_eth_data->req_port = dp->index;
> +	mib_eth_data->req_port = req_port;
>  	mib_eth_data->data = data;
>  	refcount_set(&mib_eth_data->port_parsed, QCA8K_NUM_PORTS);
>  

[Severity: High]
What happens to late frames from a request that timed out?

Later in this function:

    ret = wait_for_completion_timeout(&mib_eth_data->rw_done, QCA8K_ETHERNET_TIMEOUT);

exit:
    mutex_unlock(&mib_eth_data->mutex);

On timeout, the function returns with data and req_port still set.
port_parsed is still shared with the next request.
qca8k_mib_autocast_handler() runs from qca_tag_rcv() without the mutex.

Before this patch, every request came from ETHTOOL_GSTATS under rtnl. The
new poll sends requests outside rtnl, so this sequence looks possible:

  1. The poll's ALL_PORTS request times out under conduit load, and its
     7 frames are still queued.
  2. An unprivileged ethtool -S starts a request for port N
     (req_port = N, data = buf, port_parsed = 7).
  3. The poll's stale frames bring port_parsed to 0 and complete the
     request early. The stale port N frame fills buf.
  4. qca8k_get_ethtool_stats() returns, and ethtool_get_stats() copies
     buf to user space and vfree()s it.
  5. The ethtool request's own port N frame arrives and writes 41 u64
     into the freed buffer. refcount_dec_and_test() also underflows.

Could this write into a vfree'd buffer from softirq? Would it help to
clear data under a lock on timeout, or to tag each request so that stale
frames are ignored?

[ ... ]

> @@ -1853,6 +1866,141 @@ static void qca8k_setup_hol_fixup(struct qca8k_priv *priv, int port)
>  			   mask);
>  }
>  
> +static u64 qca8k_mib_delta(struct qca8k_priv *priv, int port, int i)
> +{
> +	struct qca8k_mib_stats *ms = &priv->mib_stats;
> +	u64 now = ms->raw[port][i];
> +	u64 last = ms->last[port][i];
> +
> +	/* A 32-bit counter may wrap between two reads. A 64-bit one does
> +	 * not, and nothing flushes the MIB after setup: a sample below the
> +	 * previous one is a bad read, keep the previous one.
> +	 */
> +	if (ar8327_mib[i].size == 2 && now < last)
> +		return 0;
> +
> +	ms->last[port][i] = now;
> +
> +	if (ar8327_mib[i].size == 1)
> +		return (u32)(now - last);

[Severity: Medium]
Is it safe to treat every backwards 32-bit sample as a wrap?

A 32-bit sample below last[] returns (u32)(now - last), which is close to
2^32. That value is added permanently to rx_packets and tx_packets (seven
buckets each), to multicast and to the error counters.

A 64-bit sample that comes in too high is stored in last[]. Every correct
sample after it is then dropped until the hardware counter catches up.

A real wrap cannot happen twice in 3 s, but non-monotonic samples can come
from other sources.

On the register path, qca8k_mii_read32() reads each 32-bit MIB register
over MDIO as two 16-bit transfers, low then high. The hi/lo/hi handling in
qca8k_mib_read() suggests the halves are not latched.

On the autocast path, a late frame from a timed-out ALL_PORTS request can
write an older snapshot into raw[p] after the fallback qca8k_mib_read()
has already advanced last[p]. port_parsed is shared, so stale frames can
complete the next poll's request early. That older row is then used, and
every 32-bit counter of the port jumps by about 2^32.

Would it be more robust to treat implausibly large 32-bit deltas as bad
reads as well?

> +
> +	return now - last;
> +}
> +
> +/* The byte counters include the FCS, as the size buckets do */
> +static u64 qca8k_mib_bytes(u64 bytes, u64 packets)
> +{
> +	u64 fcs = packets * ETH_FCS_LEN;
> +
> +	/* bytes is 0 when its sample was dropped as a bad read */
> +	return bytes > fcs ? bytes - fcs : 0;

[Severity: Low]
Does clamping to 0 here lose the FCS correction for good?

The byte and packet baselines in last[] have both moved on already, so a
negative correction is not carried into the next poll.

On the register path, qca8k_mib_read() reads the size buckets before
RxGoodByte and TxByte. A frame that arrives between those reads can show
up as bytes=64, packets=0 in one poll and bytes=0, packets=1 in the next.
The total is 64 bytes where 60 is correct.

The dropped 64-bit sample path in qca8k_mib_delta() causes the same kind
of error. The packet baselines advance but the byte baseline does not, so
the bytes recovered later are corrected only for the latest interval's
packets.

> +}
> +

[ ... ]

> +static void qca8k_mib_stats_poll(struct work_struct *work)
> +{
> +	struct qca8k_priv *priv = container_of(work, struct qca8k_priv,
> +					       mib_stats.work.work);
> +	struct qca8k_mib_stats *ms = &priv->mib_stats;
> +	bool autocast = false;
> +	struct dsa_port *dp;
> +	int port;
> +
> +	/* One autocast request returns the MIB of every port */
> +	if (priv->mgmt_conduit)
> +		autocast = qca8k_mib_autocast(priv, QCA8K_MIB_ALL_PORTS,
> +					      &ms->raw[0][0]) > 0;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds) {
> +		port = dp->index;
> +
> +		if (!autocast) {
> +			/* Register reads are slow, skip ports without link.
> +			 * Their counters keep their value, so the next read
> +			 * still adds everything since the previous one.
> +			 */
> +			if (!test_bit(port, &ms->link_map))
> +				continue;
> +			if (qca8k_mib_read(priv, port, ms->raw[port]))
> +				continue;

[Severity: Medium]
Can late autocast frames and this fallback write ms->raw[] at the same
time?

When the ALL_PORTS request times out, mib_eth_data->data still points at
&ms->raw[0][0]. Late frames from that request keep writing rows from
softirq. Meanwhile qca8k_mib_read() fills the same rows and
qca8k_mib_stats_update() computes deltas from process context. No lock is
common to both sides.

On 32-bit SMP (for example IPQ806x with a QCA8337), the u64 load of
RxGoodByte or TxByte in qca8k_mib_delta() could tear between an older and
a newer value. If a carry into the high word happened in between, the
value is about 4 GiB too high. last[] takes it, every later 64-bit sample
is dropped as below last, and rx_bytes and tx_bytes freeze.

Older late rows can also trigger the 32-bit wrap issue in
qca8k_mib_delta() described above.

> +		}
> +
> +		qca8k_mib_stats_update(priv, port);
> +	}
> +
> +	schedule_delayed_work(&ms->work, QCA8K_MIB_STATS_INTERVAL);
> +}
> +

[ ... ]

> +static void qca8k_teardown(struct dsa_switch *ds)
> +{
> +	struct qca8k_priv *priv = ds->priv;
> +
> +	cancel_delayed_work_sync(&priv->mib_stats.work);
> +}

[Severity: Medium]
Should teardown also clear mib_stats.enabled, or should qca8k_sw_remove()
cancel the work itself?

qca8k_resume() re-arms the work whenever enabled is set. It does not check
whether the switch is still set up. The tree can be torn down while qca8k
stays bound, for example when another member switch of the same tree is
unregistered. A later system resume then restarts the self-rescheduling
work.

qca8k_sw_remove() relies on dsa_unregister_switch() -> dsa_tree_teardown()
to reach ops->teardown. dsa_tree_teardown() returns early in that state:

    if (!dst->setup)
        return;

So nothing cancels the work, and devm frees priv while the work is still
queued. Could this be a use-after-free of priv in qca8k_mib_stats_poll()?

If the tree is set up again instead, qca8k_mib_init() flushes the MIB
while last[] keeps its old values. That leads to the reset issue below.

[ ... ]

> @@ -2193,6 +2354,9 @@ static int qca8k_resume(struct device *dev)
>  	struct qca8k_priv *priv = dev_get_drvdata(dev);
>  
>  	qca8k_set_pm(priv, 1);
> +	if (priv->mib_stats.enabled)
> +		schedule_delayed_work(&priv->mib_stats.work,
> +				      QCA8K_MIB_STATS_INTERVAL);
>  
>  	return dsa_switch_resume(priv->ds);
>  }

[Severity: Medium]
Does anything reset last[] when the hardware counters may have been
reset?

SIMPLE_DEV_PM_OPS() also uses qca8k_resume() as the hibernation .restore
callback. Before the image is restored, the boot kernel's qca8k_setup() ->
qca8k_mib_init() has flushed the MIB with QCA8K_MIB_FLUSH, or the switch
was power cycled. The restored image still has its old last[] and
stats[].

On the first poll, every 32-bit counter with now < last returns
(u32)(now - last) in qca8k_mib_delta(). That adds about 2^32 to
rx_packets, tx_packets, multicast and the error counters.

RxGoodByte and TxByte are also below last[]. They return 0 without
updating last[], so rx_bytes and tx_bytes stay frozen until the hardware
counters pass their pre-hibernation values.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019191137.307514-1-kuncy7%40gmail.com
