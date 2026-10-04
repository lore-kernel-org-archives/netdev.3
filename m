Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0724411691;
	Sun,  4 Oct 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105170; cv=none; b=hn33DPAEXjC07v5oRestWWQfa6blM22j48ahzVH2af3hajUXcGHRA8DQItCm1TGQ8pLsAPRViM83Pz4FGs3YnKfgs9wvrmfTrp+pEUmvgRsdnNzC/3LRL1dlS9eNH+26eyMSaoYQ0HKlYSum+b7RLZhMwutHVCk+YnjPpg93yCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105170; c=relaxed/simple;
	bh=/swsgyZ1EuBDwJDH30OCi9sbXyDWq1WF1QdgjfptEkA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VSEzed/vLbEto9zYKvZNcHWUsf+f9zmWsa2Rj+F0ee2wWmCStbX6XLqszLJVr3+XoS0bZ79OtjonsdkNhzz7YzoNoazCjpp3gzvgC96uFyo06mcDnsT5DMX6kHbK9b7+DEo9st3zJRCbuKSIFtk01U1BQy5Dgr4kjNY0k+ZAzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwZuvOkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwZuvOkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9171F0089D;
	Sun,  4 Oct 2026 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791105162;
	bh=gtIBa07DoESPsP8k+XISXoL6ZXY3gFInidC5f4c/IEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lwZuvOkwQEddRH74Kjmz8MGgNM17rkIQPDRl48p9FEcRvSO3PtMNmOyQY7+sI5oix
	 a93pEkhpjmFL0rQKuxDFtjXv/t4sdRILM4uxtP1akkDwTtG++KTEqqsUGuge6R3yCL
	 cU1MVgB13JctDdO11M5m3aBRVXmlTHKi4PqQPPsyLGW0h6IzPSTAUYExMB2TKIlT4q
	 AwvndJEmul4ZFHQYUnLYQuoEQxxX1KDtF4N+gFM+YLSIzFlQtu3qEM7YXVLHhupjQj
	 XiYVb68ziESOtiRX/3XZuV6UIPzXeJZyLKYi97q+FHpqUyoVct8v/HEkLX5n1x7Rmg
	 0SoWtKLzCGGoA==
Subject: Re: [PATCH v9 6/6] net: wwan: t9xx: Add AT & MBIM WWAN ports
From: netdev-bot+sashiko@kernel.org
To: jackbb_wu@compal.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wen-zhi.huang@mediatek.com, shi-wei.yeh@mediatek.com,
 Minano.tseng@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robert_yu@compal.com, Jeff_Chang@compal.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-doc@vger.kernel.org
Date: Sun, 04 Oct 2026 09:12:40 +0000
Message-ID: <179110516080.434549.13582624774464208224@kernel.org>
In-Reply-To: <20260930-t9xx_driver_v1-v9-6-3248b9256956@compal.com>
References: <20260930-t9xx_driver_v1-v9-6-3248b9256956@compal.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 7 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ABBA deadlock between port->w_priv.w_lock and
  trans->submit_lock.
- [Medium] A blocking write() to the new AT or MBIM WWAN port can fail
  with -EAGAIN even though the fd is blocking.
- [Medium] A blocking multi-packet write can report the whole write as
  failed after part of it has been sent.
- [Medium] mtk_port_wwan_enable() sets PORT_S_ENABLE and calls
  wwan_create_port(), which registers an openable char device, and only…
- [Medium] The new WWAN enable path reads port->tx_mtu straight after
  mtk_port_ch_enable() returns.
- [Medium] One write() to the AT or MBIM device can queue any number of
  CCCI packets on the CLDMA TX skb_list, far past SKB_LIST_MAX_LEN (16).
- [Medium] mtk_port_common_write() calls skb_copy_bits(src, cur_pos, ...)
  on the same non-linear source head for each 3440-byte packet.
- [Medium] The CCCI sequence counters for the new AT and MBIM ports
  (port->tx_seq, port->rx_seq) are reset only in mtk_port_struct_init(),…

--

net: wwan: t9xx: Add AT & MBIM WWAN ports

This commit adds AT and MBIM WWAN ports to the t9xx port infrastructure.
The ports are created on FSM_STATE_READY through a new
mtk_port_enable_by_type() hook. TX back-pressure is reported with
wwan_port_txon()/txoff() and a new per-port tx_complete hook.

> diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
> index 6cff0704b7fc8..0d8f63e2dbdaa 100644
> --- a/drivers/net/wwan/t9xx/mtk_port_io.c
> +++ b/drivers/net/wwan/t9xx/mtk_port_io.c

[ ... ]

> @@ -41,6 +46,73 @@ static void mtk_port_struct_init(struct mtk_port *port)

[ ... ]

> +static int mtk_port_common_write(struct mtk_port *port, struct sk_buff *src, bool blocking)
> +{
> +	u32 packet_size, left_cnt = src->len, cur_pos;
> +	struct sk_buff_head list;
> +	bool force_send = false;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	ret = mtk_port_status_check(port);
> +	if (ret)
> +		return ret;
> +
> +	__skb_queue_head_init(&list);
> +
> +	while (left_cnt) {
> +		skb = __dev_alloc_skb(port->tx_mtu, GFP_KERNEL);
> +		if (!skb) {
> +			ret = -ENOMEM;
> +			goto err_purge;
> +		}
> +
> +		skb_reserve(skb, sizeof(struct mtk_ccci_header));
> +
> +		packet_size = min_t(u32, left_cnt,
> +				    port->tx_mtu - sizeof(struct mtk_ccci_header));
> +		cur_pos = src->len - left_cnt;
> +		ret = skb_copy_bits(src, cur_pos, skb_put(skb, packet_size), packet_size);

[Severity: Medium]
Does this make large writes quadratic in the number of fragments?

On every call, skb_copy_bits() starts at the head of src's frag_list
(skb_walk_frags()) and adds up the lengths of the earlier fragments before
it reaches cur_pos. Here it is called once per 3440-byte packet on the same
source head. A 1 GiB write is about 312k fragments, which works out to
about 5e10 list-node visits.

The loop doesn't check for signals and has no size cap. It also runs under
the core's ops_lock in wwan_port_op_tx(), so other users of the port and
wwan_remove_port() are blocked while it runs.

> +		if (ret) {
> +			dev_err(port->port_mngr->ctrl_blk->mdev->dev,
> +				"Failed to copy data for port(%s)\n", port->info.name);
> +			dev_kfree_skb_any(skb);
> +			goto err_purge;
> +		}
> +
> +		__skb_queue_tail(&list, skb);
> +		left_cnt -= packet_size;
> +	}
> +
> +	while ((skb = __skb_dequeue(&list))) {
> +		ret = mtk_port_send_data(port, skb, blocking, force_send);
> +		if (ret < 0 && ret != -EINTR)
> +			goto err_purge;

[Severity: Medium]
Can a later packet fail here for some reason other than the channel going
away?

In the blocking case, packet 1 has already completed on the wire before
packet 2 is submitted. Suppose packet 2 then fails DMA mapping in
mtk_cldma_txbuf_set():

    dev_err_ratelimited(mdev->dev, "Failed to map dma! error:%d\n", ret);
    return -ENOMEM;

mtk_ctrl_trb_handler() completes the trb with that status, and
mtk_port_send_data() returns it:

    ret = (!trb->status) ? len : trb->status;

This loop then returns -ENOMEM for the whole write. wwan_port_fops_write()
can't report a partial count, so userspace sees a failed write. If it
resends, the prefix that was already sent is duplicated.

The comment above the function says only failures that mean the channel
itself is going away can happen after the first submit. Doesn't a
transient DMA mapping failure, with the channel still enabled afterwards,
contradict that?

> +
> +		force_send = true;

[Severity: Medium]
Is there anything that limits how many packets one write() can queue here?

Every packet after the first is submitted with force_send set. The only
depth check in mtk_pcie_hif_submit_skb() is skipped in that case:

    if (mtk_queue_list_is_full(trans, que) && !force_send) {

Take an O_NONBLOCK write close to MAX_RW_COUNT. The whole second copy built
above stays on the CLDMA TX skb_list, far past SKB_LIST_MAX_LEN, until the
modem drains it. At peak the kernel holds about twice the write size (the
core's skbs plus these copies), and none of it is charged to a memcg.

A blocking write can end up the same way. After a signal, each later
wait_event_interruptible_timeout() in mtk_port_send_data() returns
-ERESTARTSYS at once. The resulting -EINTR is treated as accepted, so the
remaining packets are force-queued without waiting.

> +	}
> +
> +	return 0;
> +
> +err_purge:
> +	__skb_queue_purge(&list);
> +	return ret;
> +}

[ ... ]

> @@ -253,6 +325,289 @@ static const struct port_ops port_internal_ops = {

[ ... ]

> +static void mtk_port_wwan_tx_pause(struct mtk_port *port)
> +{
> +	union ctrl_hif_cmd_data hif_cmd;
> +	struct mtk_ctrl_blk *ctrl_blk;
> +	int ret;
> +
> +	ctrl_blk = port->port_mngr->ctrl_blk;
> +
> +	mutex_lock(&port->w_priv.w_lock);
> +	if (!port->w_priv.w_port)
> +		goto unlock;
> +
> +	wwan_port_txoff(port->w_priv.w_port);
> +
> +	hif_cmd.rx_ch = port->info.rx_ch;
> +	ret = mtk_pcie_hif_cmd_func(ctrl_blk->mdev, HIF_CTRL_CMD_CHECK_TX_FULL,
> +				    &hif_cmd);

[Severity: High]
Can this deadlock against mtk_pcie_hif_exit()?

This path takes w_lock, then takes submit_lock inside
mtk_pcie_hif_cmd_func(). mtk_pcie_hif_exit() holds submit_lock for the
whole teardown, and during that teardown it completes this port's trbs:

mtk_pcie_hif_exit()
  mutex_lock(&trans->submit_lock)
  mtk_ctrl_trb_srv_exit()
    kthread_stop() -> mtk_ctrl_chs_flush() -> mtk_ctrl_ch_flush()
      trb->trb_complete() -> mtk_port_tx_complete()
        mtk_port_wwan_tx_complete()
          mutex_lock(&port->w_priv.w_lock)
  mtk_cldma_exit()
    mtk_cldma_txq_free()
      flush_work(&txq->tx_done_work), then trb_complete(-EPIPE)
    mtk_cldma_rxq_free()
      rxq->rx_done() -> ... -> mtk_port_wwan_recv()
        mutex_lock(&port->w_priv.w_lock)

That is submit_lock -> w_lock, the reverse of the order used here.

On removal, mtk_pci_dev_exit() carries on with "forcing cleanup" when
FSM_EVT_DEV_RM fails, for example when the event allocation fails. That
means mtk_trans_ctrl_exit() -> mtk_pcie_hif_exit() can run while the WWAN
ports are still registered and open.

Consider a writer that got -EAGAIN and is in this function. It holds
w_lock and the core's ops_lock, and blocks on submit_lock. Meanwhile
hif_exit waits in kthread_stop() or flush_work() for a completion that is
itself blocked on w_lock.

The comment added in mtk_port_tx_complete() says:

    /* Runs in the trb_srv kthread, so the hook may sleep on a mutex. */

However, the hook also runs under submit_lock during HIF teardown.

In the normal FSM_STATE_OFF path the ports are disabled before the trans
handler runs, so that path should not deadlock. It can still record the
submit_lock -> w_lock edge whenever a WWAN channel disable fails, which
would give a lockdep circular dependency report.

> +	if (ret <= 0)
> +		wwan_port_txon(port->w_priv.w_port);
> +unlock:
> +	mutex_unlock(&port->w_priv.w_lock);
> +}

[ ... ]

> +static int mtk_port_wwan_tx(struct wwan_port *w_port, struct sk_buff *skb, bool blocking)
> +{
> +	struct mtk_port *port = wwan_port_get_drvdata(w_port);
> +	int ret;
> +
> +	if (unlikely(!skb->len)) {
> +		consume_skb(skb);
> +		return 0;
> +	}
> +
> +	ret = mtk_port_common_write(port, skb, blocking);
> +	if (ret < 0) {
> +		if (ret == -EAGAIN)
> +			mtk_port_wwan_tx_pause(port);
> +		return ret;
> +	}

[Severity: Medium]
Can a blocking write() get -EAGAIN here?

Without O_NONBLOCK, the core calls ops->tx_blocking, which reaches this
function with blocking=true. However, mtk_port_common_write() always
submits the first packet with force_send=false:

    bool force_send = false;

If the queue's skb_list already holds SKB_LIST_MAX_LEN entries,
mtk_pcie_hif_submit_skb() returns -EAGAIN at once, and tx_blocking returns
it unchanged. wwan_port_fops_write() passes it straight back to the
blocking caller:

    ret = wwan_port_op_tx(port, head, !!(filp->f_flags & O_NONBLOCK));

The wait on WWAN_PORT_TX_OFF in wwan_wait_tx() only runs at the start of
the next write.

The queue can already be full when a blocking write starts. An earlier
non-blocking write (on another fd, or on the same fd before fcntl) or an
interrupted blocking write can leave it that way, because every packet
after the first skips the limit.

Should the blocking path wait for space and retry instead?

[ ... ]

> +static void mtk_port_wwan_enable(struct mtk_port *port)
> +{
> +	struct mtk_port_mngr *port_mngr;
> +	struct wwan_port_caps caps;
> +	struct wwan_port *wp;
> +	int ret;
> +
> +	port_mngr = port->port_mngr;
> +
> +	if (test_bit(PORT_S_ENABLE, &port->status))
> +		return;
> +
> +	ret = mtk_port_ch_enable(port);

[Severity: Medium]
Should tx_seq and rx_seq be reset for each modem session?

They are only reset in mtk_port_struct_init(), which runs once from
mtk_port_wwan_init(). Neither mtk_port_wwan_enable() (run on every
FSM_STATE_READY) nor mtk_port_wwan_disable() resets them.

After an OFF -> READY cycle without a driver reload, rx_seq still holds the
previous session's value. Suppose the modem restarts its sequence numbers
at 0. Its first frame with the assert bit set would then fail this check
in mtk_port_check_rx_seq():

    if (assert_bit && port->rx_seq &&
        ((seq_num - port->rx_seq) & MTK_CHECK_RX_SEQ_MASK) != 1) {

and be dropped with -EPROTO. In the other direction, mtk_port_add_header()
stamps host packets with the stale tx_seq and AST=1.

This depends on the modem firmware resetting its CCCI sequence numbers
across the cycle. The initial rx_seq = -1 suggests it does, but the host
code can't confirm it. The internal port enable path has the same gap.

> +	if (ret && ret != -EBUSY) {

[ ... ]

> +	/* tx_mtu is only valid once the channel open trb has completed. A zero
> +	 * frag_len would make wwan_port_fops_write() loop forever.
> +	 */
> +	if (!port->tx_mtu) {
> +		dev_err(port_mngr->ctrl_blk->mdev->dev,
> +			"Invalid tx_mtu for port(%s)\n", port->info.name);
> +		mtk_port_ch_disable(port);
> +		return;
> +	}

[Severity: Medium]
Is tx_mtu guaranteed to be visible at this point?

mtk_port_ch_enable() only waits for trb->status <= 0. In mtk_cldma_open(),
the trb_srv kthread publishes the status before it runs the completion
callback:

    trb->status = ret;
    trb->trb_complete(skb);

It is mtk_port_open_trb_complete() that writes port->tx_mtu:

    if (!trb->status) {
        port->tx_mtu = trb_open_priv->tx_mtu;

There is no barrier or separate completion between the two stores. A waiter
that checks the condition while the kthread is between them can see status
0 with tx_mtu still 0. That can happen on the first check after being
preempted after submit, or on a timeout recheck. On weakly ordered CPUs the
two stores can also become visible out of order.

On the first enable, this would log "Invalid tx_mtu", disable a channel
that opened successfully, and never create the AT or MBIM device for that
session.

> +
> +	/* The core allocates frag_len + headroom_len and skb_put()s frag_len,
> +	 * so frag_len is the payload budget: subtract the CCCI header to make
> +	 * one core fragment exactly one CCCI packet.
> +	 */
> +	caps.frag_len = port->tx_mtu - sizeof(struct mtk_ccci_header);
> +	caps.headroom_len = sizeof(struct mtk_ccci_header);
> +
> +	/* These bits must be set before wwan_create_port(): the device node
> +	 * becomes openable inside it and mtk_port_common_open() rejects a
> +	 * port without PORT_S_ENABLE.  w_port cannot be published first - it is
> +	 * this call's return value - so an RX frame arriving in between is
> +	 * dropped with -ENXIO by design.
> +	 */
> +	set_bit(PORT_S_WR, &port->status);
> +	set_bit(PORT_S_ENABLE, &port->status);
> +
> +	wp = wwan_create_port(port_mngr->ctrl_blk->mdev->dev,
> +			      port->w_priv.w_type,
> +			      &wwan_ops, &caps, port);
> +	if (IS_ERR(wp)) {

[ ... ]

> +	mutex_lock(&port->w_priv.w_lock);
> +	port->w_priv.w_port = wp;
> +	mutex_unlock(&port->w_priv.w_lock);
> +}

[Severity: Medium]
Can a reply to a legitimate command be dropped in this window?

Once wwan_create_port() returns, the char device can be opened, and
mtk_port_wwan_open() only requires PORT_S_ENABLE. Userspace (udev or
ModemManager reacting to the new node) can open the port and send a
command, since the TX path doesn't use w_port.

If the modem's reply arrives before the assignment above,
mtk_port_wwan_recv() sees PORT_S_OPEN set while w_port is still NULL:

    if (!test_bit(PORT_S_OPEN, &port->status) || !port->w_priv.w_port) {

and drops the reply with -ENXIO. The comment before wwan_create_port()
covers unsolicited RX arriving in between. It does not cover a reply to a
command sent after a successful open.

The start() callback is passed the wwan_port. Could it publish w_port
itself?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-t9xx_driver_v1-v9-0-3248b9256956%40compal.com
