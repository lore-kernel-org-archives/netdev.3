Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461608;
	b=EVLfW44GUHuYudpZ/87e6Yq2LF8k0j6GGLwahTm1JPdd+uHiLLNU4bP0QTpv9UQebvvk
	 fkCCQFagR2GyZXUnIUnvOxxIjoOSsQzEZfcLSwrO1BQ9s0k6mHZRM6/XINMZRPF45pBat
	 PXpXkO7MK3jjr/9P1rfp124Eemm+wNL0tF2UG1HYpR+kCJbd7J7O/H8sJvtO9JhIj/Nl1
	 IjgISAjW2Z7vCslZrHDLjh5++wVIBhq4inOB1V7AABXiL5z3M1SmdL+IqZ+pS+7MnX0Ot
	 c67gQO8gTBYBqf35gA7uRvImvobTk/EHpOirgsRaSlBL3a4P5qfeT85N9H1cYd31auw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461608;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LLmbqWZO0mRTKeUd9lANJFnW3ikWHUqtOO3KO+lCK04=;
	b=302Mg7ssMymVtP1nqQ6Zz2CfzAxuG2OHXfKvf6nR4okeh2foGp/lRXu3GSAh99boK9ZO
	 BDijR5IJF2zb6MlkT2WKRbWbwIcmUbiGFLdGcpAwon9cmQl46sa3yOMm3EYHTE6r0DXHZ
	 i8LYHa6goNtIcJmFq0K8eG07uScKE62bXbzepjveXOe0PKn0kYXpWkywqKFcSkjhj1rOu
	 jDT+hi9JSNsILQhrolMd2BQdkag2iAeBB7Waptr5Ibeb+AjGjh0UNKM5zSjDrq9jZkNuY
	 rwxtIq+ORDls1BOnLcz5ogPaVzDg1aHtp2Oio7qgws05T3MYfVHo4Ev2UTOX8IP6zGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AniveGl4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73969606A884;
	Thu, 12 Nov 2026 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AniveGl4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962BF1F00A08;
	Thu, 12 Nov 2026 05:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461608;
	bh=LLmbqWZO0mRTKeUd9lANJFnW3ikWHUqtOO3KO+lCK04=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AniveGl4W+SvU9/KZq3M8W5DrNc3U6Uvqo16/gxghZr3mw+3yllqIS6GIOJPyipqB
	 VySMLTixbbc46WYm8kMBclbH8XQaFe30W50dT89Bw0pM4azBEKacLegkmwsMY8bb55
	 f97e47Scm9OArYn8lNig+44UaE48D/wLxrBlR0vzoOUOhM4qWFIE7s80aFWurGOihr
	 x3Ihbme+URVx/zqOaBcPMBhrSxpPOKXGgbyD6Iq+0GaKWe4ofgRuIt6Bea1lohLDsl
	 LoULWMIFck6ygXnbD+8Fh0SfQNSBaGuqQc6o2dRbCCPNZN2Ax4zrnHa/HbqY/gcv+v
	 lzvponf8+5kFw==
Subject: Re: [PATCH net-next v1 3/3] r8169: add hardware timestamping support
 for RTL8127a
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 05:33:27 +0000
Message-ID: <179446160712.2199510.8409224902993653061@kernel.org>
In-Reply-To: <20261109023022.770-4-javen_xu@realsil.com.cn>
References: <20261109023022.770-4-javen_xu@realsil.com.cn>
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

Thank you for your contribution! Sashiko AI review found 15 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 4 · Low: 9

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Timestamping is not stopped or restored on suspend, runtime
  suspend, resume or shutdown.
- [High] TX hardware timestamps are not tied to the skb that requested
  them.
- [Medium] The polling scheme for TX and RX timestamps is CPU-intensive
  and runs with IRQs off.
- [Medium] rtl8169_ptp_rx_tstamp() reads the PHY's per-message-type 'last
  received' latch when NAPI processes the skb, which can be well after…
- [Medium] Failed or all-ones register reads are treated as valid
  timestamps.
- [Medium] rtl8169_ptp_get_ts_info() reads ptp->clock and calls
  ptp_clock_index(ptp->clock) without RTNL or any driver lock.
- [Low] rtl8169_ptp_get_ts_info() and rtl8169_ptp_hwtstamp_set() disagree
  on the supported RX filters.
- [Low] The uAPI behaves inconsistently when no PHC is registered.
- [Low] The RX path stamps PTPv1 general messages, even though the driver
  only accepts PTPv2 filters and reports PTP_V2_EVENT.
- [Low] rtl8169_ptp_get_ts_stats() maps the driver counters onto
  ethtool_ts_stats fields in ways that contradict their kernel-doc.
- [Low] In rtl8169_start_xmit(), skb_tx_timestamp(skb) runs before
  rtl8169_ptp_tx_tstamp() sets SKBTX_IN_PROGRESS.
- [Low] rtl8169_ptp_tx_tstamp() runs in ndo_start_xmit with only the TX
  queue lock and reads ptp->config.tx_type with a plain load.
- [Low] ptp->tx_pkts and ptp->tx_timeouts are u64 counters incremented in
  rtl8169_ptp_tx_work(), and ptp->tx_skipped is incremented in…
- [Low] rtl8169_ptp_trx_ts_cmd() does a read-modify-write of
  PTP_TRX_TS_STA through rtl8169_ptp_modify().
- [Low] This patch makes rtl8169_ptp_hwtstamp_enable(true) reachable for
  the first time.

--

r8169: add hardware timestamping support for RTL8127a

This commit adds hardware timestamping of PTPv2 event messages on
RTL8127a. RX timestamps are read from per-message-type PHY latches in the
NAPI path. TX timestamps are handled one packet at a time and polled from
a work item with a 15 second timeout. The commit also wires up
ndo_hwtstamp_get/set, get_ts_info and get_ts_stats.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index fc3cfa09a57e7..2ffb877ac2b49 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5146,6 +5146,10 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>  
>  	skb_tx_timestamp(skb);
>  
> +	if (tp->ptp_support &&
> +	    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> +		rtl8169_ptp_tx_tstamp(&tp->ptp, skb);

[Severity: Low]
Should SKBTX_IN_PROGRESS be set before skb_tx_timestamp() runs here?

rtl8169_ptp_tx_tstamp() sets SKBTX_IN_PROGRESS only after
skb_tx_timestamp() has already produced the software timestamp. Because of
that, this check in __skb_tstamp_tx() can never suppress it:

    if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
        skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
        return;

A socket that asks for both software and hardware TX timestamps without
SOF_TIMESTAMPING_OPT_TX_SWHW gets an extra software timestamp.
Documentation/networking/timestamping.rst says skb_tx_timestamp() gives a
software timestamp only when SKBTX_IN_PROGRESS is not set.

> +
>  	/* Force memory writes to complete before releasing descriptor */
>  	dma_wmb();

[ ... ]

> diff --git a/drivers/net/ethernet/realtek/r8169_ptp.c b/drivers/net/ethernet/realtek/r8169_ptp.c
> index 6201170e0c83e..d318025837612 100644
> --- a/drivers/net/ethernet/realtek/r8169_ptp.c
> +++ b/drivers/net/ethernet/realtek/r8169_ptp.c

[ ... ]

> @@ -136,6 +155,48 @@ static void rtl8169_ptp_write_time(struct rtl8169_ptp *ptp,
>  	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_S_HI, sec >> 32);
>  }
>  
> +/* Latch the RX or TX timestamp of the given message type into the
> + * PTP_TRX_TS_TIME registers.
> + */
> +static void rtl8169_ptp_trx_ts_cmd(struct rtl8169_ptp *ptp, u16 cmd)
> +{
> +	rtl8169_ptp_modify(ptp, PTP_TRX_TS_STA,
> +			   PTP_TRX_TS_SEL_RX | PTP_TRX_TS_MSGTYPE,
> +			   PTP_TRX_TS_RD | cmd);

[Severity: Low]
This read-modify-write of PTP_TRX_TS_STA masks only SEL_RX and MSGTYPE.
The TX_RDY status bits 15:12 are written back exactly as they were read.
What is the access type of those bits?

If they are write-1-to-clear, an RX timestamp read from NAPI could clear a
pending TX ready bit. That happens when the read falls between a TX
timestamp event and rtl8169_ptp_tx_work() consuming it.
rtl8169_ptp_tx_work() would then see PTP_INSR.TX_TS with no TX_RDY bit. It
would poll for 1ms with interrupts off and fall back to the SYNC latch.

If they are sticky read/write bits, writing 1 back means they never clear.
Ready bits then pile up and rtl8169_ptp_egress_time() falls into the
multi-bit default case.

> +	rtl8169_ptp_poll(ptp, PTP_TRX_TS_STA, PTP_TRX_TS_RD, false);
> +}
> +
> +static void rtl8169_ptp_egress_time(struct rtl8169_ptp *ptp,
> +				    struct timespec64 *ts)
> +{
> +	u8 msgtype;
> +	int val;
> +
> +	val = rtl8169_ptp_poll(ptp, PTP_TRX_TS_STA, PTP_TRX_TS_TX_RDY, true);
> +	if (val < 0)
> +		val = 0;

[Severity: Medium]
Can a failed or all-ones register read be delivered as a valid timestamp
here?

If the TX_RDY poll times out, val is forced to 0. The switch then falls
through to the SYNC latch, which is read and delivered anyway.

rtl8169_ptp_read() returns u16, so an -ETIMEDOUT from
r8168_phy_ocp_read() becomes 0xff92. Bits 15:12 are set in that value, so
this poll for PTP_TRX_TS_TX_RDY succeeds at once on a failed read.

rtl8169_ptp_trx_ts_cmd() ignores the result of the poll that waits for
PTP_TRX_TS_RD to clear. If the latch command never completes,
PTP_TRX_TS_TIME still holds the old contents. Both
rtl8169_ptp_rx_tstamp() and rtl8169_ptp_tx_work() then report those as
this packet's timestamp, and tx_pkts counts it as a success.

If the device is in D3 or has been removed from the bus,
r8168_phy_ocp_read() returns 0xffff. rtl8169_ptp_read_time() then builds
nsec = 0x3fffffff, which is above NSEC_PER_SEC and never range checked,
and sec = 2^48 - 1. timespec64_to_ktime() turns that into KTIME_MAX.

Should these error paths drop the timestamp and count the request as lost
or err instead?

> +
> +	switch (val & PTP_TRX_TS_TX_RDY) {

[ ... ]

> @@ -243,6 +304,201 @@ static const struct ptp_clock_info rtl8169_ptp_info = {

[ ... ]

> +static void rtl8169_ptp_tx_work(struct work_struct *work)
> +{

[ ... ]

> +	spin_lock_irqsave(&ptp->lock, flags);
> +	ready = rtl8169_ptp_read(ptp, PTP_INSR) & PTP_INT_TX_TS;
> +	if (ready) {
> +		rtl8169_ptp_write(ptp, PTP_INSR, PTP_INT_TX_TS);
> +		rtl8169_ptp_egress_time(ptp, &ts);
> +	}
> +	spin_unlock_irqrestore(&ptp->lock, flags);
> +
> +	if (!ready) {
> +		schedule_work(&ptp->tx_work);
> +		return;
> +	}

[Severity: Medium]
When the timestamp is not ready, this requeues the work at once with no
delay, until tx_start + 15 * HZ. Doesn't that turn every unanswered
request into a 15 second busy loop?

Each pass takes ptp->lock with spin_lock_irqsave() and does a GPHY_OCP
transaction, which can busy-wait up to 250us in rtl_phy_ocp_wait(). Some
requests never get an answer from the hardware, for example a non-PTP skb
or a frame dropped on link down. For those, a kworker keeps spinning for
the whole timeout and floods the OCP mailbox it shares with phylib.

Would a delayed_work, or ptp_schedule_worker() with do_aux_work and a poll
interval, bound this? The commit message only says the timestamp "is
polled from a work item".

The RX side has a similar cost. rtl8169_ptp_rx_tstamp() runs from rtl_rx()
for every frame that ptp_classify_raw() accepts with msgtype <= 3. Under
spin_lock_irqsave() it does:

- a read-modify-write of PTP_TRX_TS_STA
- a read_poll_timeout_atomic() of up to 1000us
- five time register reads

A remote sender decides whether a frame takes this path (L2 0x88F7, or UDP
319/320 with the right messageType). A low rate flood of minimal PTP event
frames can therefore burn a lot of interrupts-off time in softirq context.

[ ... ]

> +void rtl8169_ptp_tx_tstamp(struct rtl8169_ptp *ptp, struct sk_buff *skb)
> +{
> +	if (ptp->config.tx_type != HWTSTAMP_TX_ON ||
> +	    test_and_set_bit_lock(RTL8169_PTP_TX_IN_PROGRESS, &ptp->state)) {
> +		ptp->tx_skipped++;
> +		return;
> +	}

[Severity: Low]
ptp->config.tx_type is read here with a plain load from ndo_start_xmit,
which holds only the TX queue lock. The writers run under RTNL and use
plain stores: rtl8169_ptp_hwtstamp_set() through
hwtstamp_config_from_kernel(), rtl8169_ptp_init() and rtl8169_ptp_stop().

rx_enabled uses READ_ONCE()/WRITE_ONCE() in the same situation. Should
tx_type be annotated the same way, so KCSAN does not report it?

> +
> +	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +	ptp->tx_skb = skb_get(skb);
> +	ptp->tx_start = jiffies;
> +	schedule_work(&ptp->tx_work);
> +}

[Severity: High]
Is the TX hardware timestamp actually tied to the skb that asked for it?

This function takes the single slot for any skb with SKBTX_HW_TSTAMP set.
It never calls ptp_classify_raw()/ptp_parse_header() and never records the
message type.

The hardware only has TX latches and ready bits for the four PTP event
types (PTP_TRX_TS_TX_{SYNC,DLYREQ,PDLYREQ,PDLYRSP}_RDY). An skb that is not
a PTP event never gets a timestamp, but it holds the slot for up to 15
seconds. Examples are NTP or any UDP sent with
SOF_TIMESTAMPING_TX_HARDWARE, PTP general messages, and PTPv1.

rtl8169_ptp_tx_work() treats any PTP_INSR.TX_TS as completion of the
tracked skb. So the next PTP event frame that goes out completes the wrong
request. That could be ptp4l's Sync, which was itself counted as
tx_skipped because the slot was busy. Its timestamp goes to the other
socket, and ptp4l never gets one.

rtl8169_ptp_egress_time() also picks the latch from whichever TX_RDY bits
are set, not from the requesting skb. Any value other than exactly one bit
falls into the default case and reads the SYNC latch. TX_RDY is never
cleared before a new request.

On a config change, rtl8169_ptp_hwtstamp_set() ->
rtl8169_ptp_hwtstamp_enable(true) writes 0xffff to PTP_INSR. That can wipe
the status of an in-flight request.

SO_TIMESTAMPING with SOF_TIMESTAMPING_TX_HARDWARE needs no privilege. Once
TX_ON is enabled, any local user can keep the slot busy, so ptp4l times
out waiting for TX timestamps and faults.

Should the request be classified, and matched against the message type the
hardware reports?

> +
> +void rtl8169_ptp_rx_tstamp(struct rtl8169_ptp *ptp, struct sk_buff *skb)
> +{

[ ... ]

> +	/* Only event messages are timestamped by the hardware */
> +	msgtype = ptp_get_msgtype(hdr, ptp_class);
> +	if (msgtype > PTP_MSGTYPE_PDELAY_RESP)
> +		return;

[Severity: Low]
Should this also check ptp_class & PTP_CLASS_V2?

For V1 classes, ptp_get_msgtype() returns hdr->control. V1 Follow_Up
(control = 2) and Delay_Resp (control = 3) are general messages. They
still pass this check and are fed to PTP_TRX_TS_MSGTYPE as PDELAY_REQ and
PDELAY_RESP.

They then get the PDELAY latch of some unrelated v2 frame. That
contradicts both the reported PTP_V2_EVENT filter and the comment above.

> +
> +	spin_lock_irqsave(&ptp->lock, flags);
> +	rtl8169_ptp_trx_ts_cmd(ptp, PTP_TRX_TS_SEL_RX |
> +				    FIELD_PREP(PTP_TRX_TS_MSGTYPE, msgtype) |
> +				    PTP_TRX_TS_EXEC);
> +	rtl8169_ptp_read_time(ptp, PTP_TRX_TS_TIME, &ts);
> +	spin_unlock_irqrestore(&ptp->lock, flags);
> +
> +	skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(ts);
> +}

[Severity: Medium]
Can this attach a timestamp that belongs to a different frame?

The latch holds the last received event message of each type. It is read
when NAPI processes the skb, which can be well after the frame arrived.
Nothing checks or acknowledges PTP_INSR.RX_TS. Nothing matches the latch
to this packet either, for example by sequenceId or sourcePortIdentity.

If two event messages of the same type arrive before NAPI handles the
first, the earlier skb gets the later frame's ingress time. That is normal
on a master or boundary clock receiving Delay_Req from several slaves, and
with P2P and several peers.

Frames the classifier accepts but the hardware did not stamp get whatever
stale value is in the latch, or zero right after enable. A network peer
can also send a same-type event message right after a legitimate one and
shift the timestamp attached to the legitimate frame.

The commit message says the PHY "latches the timestamp of the last
received event message per message type", but does not mention this
misattribution.

[ ... ]

> +int rtl8169_ptp_hwtstamp_set(struct rtl8169_ptp *ptp,
> +			     struct kernel_hwtstamp_config *config,
> +			     struct netlink_ext_ack *extack)
> +{
> +	bool enable = false;
> +	bool rx_enabled;
> +
> +	if (!ptp->clock)
> +		return -ENETDOWN;

[Severity: Low]
The PHC only exists between ndo_open and ndo_stop. It is also missing if
ptp_clock_register() failed in rtl8169_ptp_init(). In those cases this
returns -ENETDOWN.

Meanwhile rtl8169_get_ts_info() picks the hardware path based only on
tp->ptp_support. rtl8169_ptp_get_ts_info() then still advertises
SOF_TIMESTAMPING_{TX,RX,RAW}_HARDWARE, tx_types and rx_filters.

If registration failed while the interface is up, would -EOPNOTSUPP be the
better errno here?

rtl8169_ptp_stop() also resets ptp->config to HWTSTAMP_TX_OFF and
HWTSTAMP_FILTER_NONE on every close. That silently drops the timestamping
config across a down/up cycle. Is that intended? The commit message does
not mention it.

[ ... ]

> +	if (ptp->config.tx_type != config->tx_type ||
> +	    ptp->config.rx_filter != config->rx_filter) {
> +		hwtstamp_config_from_kernel(&ptp->config, config);
> +		rtl8169_ptp_hwtstamp_enable(ptp, enable);
> +	}

[Severity: Low]
This makes rtl8169_ptp_hwtstamp_enable(ptp, true) reachable for the first
time. In the parent commit, which added PHC support, it was only ever
called with false.

The enable branch sets PTP_INT_RX_TS and PTP_INT_TX_TS in PTP_INER and
sets PTP_GEN_CFG_INT_CLR_MODE, but nothing services those interrupts. The
MAC interrupt handlers only handle LinkChg -> phy_mac_interrupt().
PTP_INSR.RX_TS is never acknowledged; only TX_TS is ever written back.

If the internal PHY routes PTP_INSR into its interrupt output toward the
MAC, could an RX_TS that is never cleared cause spurious link change
interrupts and phylib state machine runs, or keep the line asserted? Since
the driver only polls, are these interrupt sources needed at all?

> +	WRITE_ONCE(ptp->rx_enabled, rx_enabled);
> +
> +	return 0;
> +}
> +
> +int rtl8169_ptp_get_ts_info(struct rtl8169_ptp *ptp,
> +			    struct kernel_ethtool_ts_info *info)
> +{
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_RX_HARDWARE |
> +				SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	if (ptp->clock)
> +		info->phc_index = ptp_clock_index(ptp->clock);

[Severity: Medium]
Can this race with rtl8169_ptp_stop() and read a freed ptp_clock?

get_ts_info can be reached without RTNL:

setsockopt(SO_TIMESTAMPING with SOF_TIMESTAMPING_BIND_PHC)
  sock_timestamping_bind_phc()
    ethtool_get_phc_vclocks()
      __ethtool_get_ts_info()
        rtl8169_get_ts_info()
          rtl8169_ptp_get_ts_info()

That path holds only rcu_read_lock() and a device reference. At the same
time, rtl8169_close() under RTNL can run rtl8169_ptp_stop():

	ptp_clock_unregister(ptp->clock);
	ptp->clock = NULL;

ptp_clock_unregister() can drop the last reference and free the ptp_clock
before the pointer is cleared with a plain store. A reader that has
already seen the non-NULL pointer would then read freed memory in
ptp_clock_index().

Before this patch the driver used ethtool_op_get_ts_info(), which never
touched ptp->clock.

> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ);

[Severity: Low]
Should the L2 filters be in this mask?

rtl8169_ptp_hwtstamp_set() accepts HWTSTAMP_FILTER_PTP_V2_L2_EVENT,
HWTSTAMP_FILTER_PTP_V2_L2_SYNC and HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ and
upgrades them to PTP_V2_EVENT. None of the three are advertised here, but
PTP_V2_EVENT, which covers both L2 and L4, is.

The RX path does stamp L2 PTP frames, since ptp_parse_header() handles
PTP_CLASS_L2. If PTP_CTL_TYPE_3 is in fact L4 only, should neither the L2
filters nor PTP_V2_EVENT be accepted or advertised?

> +
> +	return 0;
> +}
> +
> +void rtl8169_ptp_get_ts_stats(struct rtl8169_ptp *ptp,
> +			      struct ethtool_ts_stats *stats)
> +{
> +	stats->pkts = ptp->tx_pkts;
> +	stats->lost = ptp->tx_timeouts;
> +	stats->err = ptp->tx_skipped;
> +}

[Severity: Low]
Do these mappings match the ethtool_ts_stats kernel-doc?

@err is documented as timestamp generation error events that the hardware
encountered. But rtl8169_ptp_tx_tstamp() also increments tx_skipped when
ptp->config.tx_type != HWTSTAMP_TX_ON. That is a socket asking for a
hardware timestamp while TX timestamping is off, not a hardware error.

rtl8169_ptp_stop() can discard a pending request through
rtl8169_ptp_tx_complete(ptp, NULL). That fits the @lost definition
(timestamping information from the hardware never arrived), but
tx_timeouts is not incremented.

[Severity: Low]
tx_pkts and tx_timeouts are u64 counters incremented in
rtl8169_ptp_tx_work(). tx_skipped is incremented in
rtl8169_ptp_tx_tstamp() from ndo_start_xmit. All three are read here with
plain loads, without u64_stats_sync or a lock shared with the writers. Can
a reader see torn values on 32-bit architectures?

[ ... ]

> @@ -275,7 +533,13 @@ void rtl8169_ptp_stop(struct rtl8169_ptp *ptp)
>  	if (!ptp->clock)
>  		return;
>  
> +	ptp->config.tx_type = HWTSTAMP_TX_OFF;
> +	ptp->config.rx_filter = HWTSTAMP_FILTER_NONE;
> +	WRITE_ONCE(ptp->rx_enabled, false);
>  	rtl8169_ptp_hwtstamp_enable(ptp, false);
> +	cancel_work_sync(&ptp->tx_work);
> +	if (ptp->tx_skb)
> +		rtl8169_ptp_tx_complete(ptp, NULL);
>  
>  	ptp_clock_unregister(ptp->clock);
>  	ptp->clock = NULL;

[Severity: High]
This is the only place where tx_work is cancelled and a pending tx_skb is
released, and it is only reached from ndo_stop. What happens across
suspend, runtime suspend, resume and shutdown?

rtl8169_suspend(), rtl8169_runtime_suspend() and rtl_shutdown() all go
through rtl8169_net_suspend() -> rtl8169_down(), which does:

	disable_work_sync(&tp->wk.work);
	...
	pci_clear_master(tp->pci_dev);
	...
	rtl_prepare_power_down(tp);

That path never cancels ptp->tx_work and never frees ptp->tx_skb. tx_work
requeues itself on system_percpu_wq for up to 15 seconds, so it keeps
doing GPHY_OCP accesses after the device has been powered down.

With the interface up, carrier loss calls pm_runtime_idle(). Then
rtl8169_runtime_idle() schedules suspend 10 seconds later, which is inside
RTL8169_PTP_TX_TIMEOUT:

	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
		pm_schedule_suspend(device, 10000);

A request still pending at that point leaves tx_work polling a device in
D3hot. The reads return all-ones, so this sequence follows:

- PTP_INSR & PTP_INT_TX_TS looks ready
- the TX_RDY poll passes
- rtl8169_ptp_read_time() builds a KTIME_MAX timestamp
- skb_tstamp_tx() hands it to user space and tx_pkts counts it

On resume, rtl8169_up() goes through D3 -> D0, rtl8169_init_phy() (which
includes a PHY soft reset) and rtl8169_ptp_set_local_time(). It never
replays rtl8169_ptp_hwtstamp_enable() from ptp->config. If PTP_CTL and
PTP_INER do not survive that, ptp->config and rx_enabled still say
timestamping is on while the hardware has it off.

rtl8169_ptp_hwtstamp_set() only reprograms the hardware when the config
changes:

	if (ptp->config.tx_type != config->tx_type ||
	    ptp->config.rx_filter != config->rx_filter) {

So re-sending the same SIOCSHWTSTAMP config, as ptp4l does during fault
recovery, does nothing. Doesn't timestamping then stay broken until it is
switched off and back on, or the interface is cycled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109023022.770-1-javen_xu%40realsil.com.cn
