Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2339CD0B;
	Sat, 19 Sep 2026 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789862098; cv=none; b=AZSULWl+MvyWis2JE2oi2GOsFp/4uETK7FIqVi6X1sNxYSk4qZTJcN3cTZwNOnmYME8oFA34TB3F9Gx7Cvb/XLsp5DU9U6Y3mx//QnQpHGmGrHOQ1nt8B2VQyZMmcjsQdGJ/QcJL9ccqCdh2NPnFMmTvr2EwKj7pXXtBZKlsWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789862098; c=relaxed/simple;
	bh=9uBnw0oifPqM+hutxo5Nx55V6ep1T8TAe/JXiXnxCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2XxboEUncrs1DEDZbaz23n4B+hYDsVDgKV4aKS+hJZIsamqTeH1vTTFq688DNDaftVENjUNixO2/H35GVSx328YHP/okbvgvZMkf7c//fLv0tNlCIGykAJO3nmBh+dBiRN0GBFaprNSWMaaZLjuxo0SyTMUDnfszB1m394LUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuxmojxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuxmojxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2A81F00898;
	Sat, 19 Sep 2026 23:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789862096;
	bh=PmkjYYsfUNf6piG6axY/LxZrcWIwU2r2rSgBbNY+KCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PuxmojxBkgiVOWnrQCl7D9SrHpxpCV+USArH2nND6CQGDrcp68KTU5mRfJygGrv56
	 cjyLC8scs8rjrvdk8DSTbnzGOBfrE7DtBgB6FvJPb9TimXV943780yhEc+FVfPSE6a
	 C7cZ1vgrhEh5RDKLFfijmV2bR83K2nBZfpmWUeFkB1w3scqK1wvGQ/WGvz/odtS/Dl
	 BK+JPlDspWPx35DKfm1w6QR2LKwxHIFvKNJCWi+1VVqPHCr55qPeI0h0tDTUI8p1nl
	 0qz0PL6ScZi6WH31dMDsTSToW0C1+joyG7qyBAmzTWHsZy/UTnQU57QyJKzcgwgdag
	 bsfVocMlGxsjg==
From: Jakub Kicinski <kuba@kernel.org>
To: jackbb_wu@compal.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	wen-zhi.huang@mediatek.com,
	shi-wei.yeh@mediatek.com,
	Minano.tseng@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	robert_yu@compal.com,
	Jeff_Chang@compal.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 6/6] net: wwan: t9xx: Add AT & MBIM WWAN ports
Date: Sat, 19 Sep 2026 16:54:55 -0700
Message-ID: <20260919235455.839820-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914-t9xx_driver_v1-v8-6-5206c2e6bea0@compal.com>
References: <20260914-t9xx_driver_v1-v8-6-5206c2e6bea0@compal.com>
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
net: wwan: t9xx: Add AT & MBIM WWAN ports

This adds two PORT_TYPE_WWAN ports (AT and MBIM) to the t9xx port
infrastructure, implementing the wwan_port_ops start/stop/tx/tx_blocking/
tx_poll callbacks, and wires the new CCCI UART2 and MBIM channels into the
m9xx queue and port configuration tables.

A few questions on the new code below.

> The WWAN initialization method is responsible for creating the
> corresponding ports using the WWAN framework infrastructure.

[Severity: Medium]
Is this description accurate?  mtk_port_wwan_init() only calls
mtk_port_struct_init(), mutex_init(&port->w_priv.w_lock) and picks
w_priv.w_type; the wwan_create_port() call is in mtk_port_wwan_enable(),
which is reached from the new FSM_STATE_READY case in
mtk_port_mngr_fsm_state_handler().

Two other changes also seem worth a mention in the log:

- the new mtk_port_enable_by_type(port_mngr, PORT_TBL_MD) hook runs
  ports_ops[...]->enable() for every MD-table port that has
  port->enable set, including PORT_TYPE_INTERNAL ports, so this changes
  behaviour on a shared code path rather than only adding two ports.

- two new CLDMA1 hardware queues (TXQ(5)/RXQ(5) and TXQ(2)/RXQ(2)) are
  added to mtk_queue_info_m9xx[].

> diff --git a/drivers/net/wwan/t9xx/mtk_port.c b/drivers/net/wwan/t9xx/mtk_port.c
> index bddb8523d1201..88a0cb5fa78dc 100644
> --- a/drivers/net/wwan/t9xx/mtk_port.c
> +++ b/drivers/net/wwan/t9xx/mtk_port.c
> @@ -820,6 +820,29 @@ int mtk_port_ch_disable(struct mtk_port *port)
>  	return ret;
>  }
>  
> +static int mtk_port_enable_by_type(struct mtk_port_mngr *port_mngr, int tbl_type)
> +{
> +	struct mtk_port **ports;
> +	int ret, idx;
> +
> +	if (tbl_type < 0 || tbl_type >= PORT_TBL_MAX)
> +		return -EINVAL;
> +
> +	ports = kcalloc(port_mngr->port_cnt, sizeof(struct mtk_port *), GFP_KERNEL);
> +	if (!ports)
> +		return -ENOMEM;
> +
> +	ret = radix_tree_gang_lookup(&port_mngr->port_tbl[tbl_type],
> +				     (void **)ports, 0, port_mngr->port_cnt);
> +	for (idx = 0; idx < ret; idx++) {
> +		if (ports[idx]->enable)
> +			ports_ops[ports[idx]->info.type]->enable(ports[idx]);
> +	}
> +
> +	kfree(ports);
> +	return 0;
> +}
> +

[ ... ]

> @@ -851,6 +875,12 @@ void mtk_port_mngr_fsm_state_handler(struct mtk_fsm_param *fsm_param, void *arg)
>  	case FSM_STATE_OFF:
>  		mtk_port_disable(port_mngr);
>  		break;
> +	case FSM_STATE_READY:
> +		ret = mtk_port_enable_by_type(port_mngr, PORT_TBL_MD);
> +		if (ret)
> +			dev_err(port_mngr->ctrl_blk->mdev->dev,
> +				"Failed to enable MD ports: %d\n", ret);
> +		break;
>  	default:
>  		break;
>  	}

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
> index 27b490fde40f2..b1c1aa6009d64 100644
> --- a/drivers/net/wwan/t9xx/mtk_port_io.c
> +++ b/drivers/net/wwan/t9xx/mtk_port_io.c

[ ... ]

> @@ -41,6 +45,59 @@ static void mtk_port_struct_init(struct mtk_port *port)
>  	init_waitqueue_head(&port->rx_wq);
>  }
>  
> +/* Splits the source skb into CCCI packets and submits them, all or
> + * nothing.  The source may be non-linear: the WWAN core hands the tx ops
> + * a head skb whose linear area is one fragment (caps.frag_len bytes) with
> + * the rest chained on frag_list, so every read goes through
> + * skb_copy_bits(), which walks that chain and is bounded by src->len by
> + * construction.
> + *
> + * Returns 0 or a negative errno.  Only the first packet may fail with
> + * -EAGAIN; every later packet is submitted with force_send so a message
> + * partially handed to the transaction layer cannot be truncated by a full
> + * queue.  -EINTR from a blocking wait arrives after the skb was
> + * submitted, so the packet counts as accepted and the loop continues.
> + */
> +static int mtk_port_common_write(struct mtk_port *port, struct sk_buff *src, bool blocking)
> +{
> +	u32 packet_size, left_cnt = src->len, cur_pos;
> +	bool force_send = false;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	while (left_cnt) {
> +		ret = mtk_port_status_check(port);
> +		if (ret)
> +			return ret;
> +
> +		skb = __dev_alloc_skb(port->tx_mtu, GFP_KERNEL);
> +		if (!skb)
> +			return -ENOMEM;

[Severity: Medium]
Is the "all or nothing" claim in this comment true beyond the queue-full
case?  force_send only suppresses the -EAGAIN branch in
mtk_pcie_hif_submit_skb():

	if (mtk_queue_list_is_full(trans, que) && !force_send) {
		ret = -EAGAIN;

On the second and later iterations these paths still return early after
previous packets of the same message were already submitted:

- mtk_port_status_check() returning -ENODEV/-EBADF if a concurrent
  close or disable clears PORT_S_OPEN/PORT_S_WR or sets PORT_S_FLUSH
- __dev_alloc_skb(port->tx_mtu, GFP_KERNEL) returning NULL (-ENOMEM)
- mtk_port_send_data() returning -EIO when
  !atomic_read(&trans->available), or -EINVAL on queue lookup failure,
  or a negative trb->status in blocking mode

> +
> +		skb_reserve(skb, sizeof(struct mtk_ccci_header));
> +
> +		packet_size = min_t(u32, left_cnt,
> +				    port->tx_mtu - sizeof(struct mtk_ccci_header));
> +		cur_pos = src->len - left_cnt;
> +		ret = skb_copy_bits(src, cur_pos, skb_put(skb, packet_size), packet_size);
> +		if (ret) {
> +			dev_err(port->port_mngr->ctrl_blk->mdev->dev,
> +				"Failed to copy data for port(%s)\n", port->info.name);
> +			dev_kfree_skb_any(skb);
> +			return ret;
> +		}
> +
> +		ret = mtk_port_send_data(port, skb, blocking, force_send);
> +		if (ret < 0 && ret != -EINTR)
> +			return ret;

[Severity: Medium]
Can this truncate an AT or MBIM message on the wire?  For any write
larger than tx_mtu - sizeof(struct mtk_ccci_header) (about 3440 bytes
with Q_MTU_3_5K), the leading packets are already submitted when this
returns.  mtk_port_wwan_tx() forwards the errno and the core does:

net/wwan/wwan_core.c:wwan_port_fops_write() {
	...
	ret = wwan_port_op_tx(port, head, ...);
	if (!ret)
		return count;

freeskb:
	kfree_skb(head);
	return ret;
}

so userspace is told the whole write failed and will normally re-send
the entire message, duplicating the prefix the modem already received.
Would it make sense to keep going until the message is complete, or to
build and submit the fragments only after all of them are allocated?

> +
> +		left_cnt -= packet_size;
> +		force_send = true;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -242,6 +299,224 @@ static const struct port_ops port_internal_ops = {
>  	.recv = mtk_port_internal_recv,
>  };
>  

[ ... ]

> +static void mtk_port_wwan_close(struct wwan_port *w_port)
> +{
> +	struct mtk_port *port = wwan_port_get_drvdata(w_port);
> +
> +	mtk_port_common_close(port);
> +	mtk_port_put_locked(port);
> +}
> +
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
> +	if (ret < 0)
> +		return ret;
> +
> +	consume_skb(skb);
> +	return 0;
> +}
> +

[ ... ]

> +static __poll_t mtk_port_wwan_poll(struct wwan_port *w_port, struct file *file,
> +				   struct poll_table_struct *poll)
> +{
> +	struct mtk_port *port = wwan_port_get_drvdata(w_port);
> +	union ctrl_hif_cmd_data hif_cmd;
> +	struct mtk_ctrl_blk *ctrl_blk;
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &port->trb_wq, poll);

[Severity: High]
Can this leave a wait entry pointing into freed memory?  port->trb_wq is
embedded in struct mtk_port, but struct mtk_port is freed while the
userspace fd (and the poll/epoll entry registered here) is still alive.

On device removal:

mtk_pci_dev_exit() -> mtk_port_mngr_exit() -> mtk_port_tbl_destroy() {
	...
	ports_ops[port->info.type]->disable(port);
	...
	mtk_port_free_or_backup(port_mngr, port, s_list);
}

mtk_port_wwan_disable() calls wwan_remove_port(), which forces stop()
even with an open fd:

net/wwan/wwan_core.c:wwan_remove_port() {
	mutex_lock(&port->ops_lock);
	if (port->start_count) {
		port->ops->stop(port);
		port->start_count = 0;
	}
	port->ops = NULL;
	...
}

stop() is mtk_port_wwan_close(), so mtk_port_common_close() clears
PORT_S_OPEN and mtk_port_put_locked() drops the open-time kref.  The
stale-list guard in mtk_port_free_or_backup() is then already false:

	if (port->info.type != PORT_TYPE_INTERNAL) {
		if (test_bit(PORT_S_OPEN, &port->status)) {
			list_add_tail(&port->stale_entry, &s_list->ports);
		...
		kref_put(&port->kref, mtk_port_release);

so mtk_port_release() -> kfree(port) frees the waitqueue head.  The fd
stays valid because the core only NULLs port->ops, and nothing calls
wake_up_pollfree() on trb_wq.  When the entry is torn down later
(poll_freewait() -> free_poll_entry() -> remove_wait_queue(), or
ep_remove_wait_queue() at EPOLL_CTL_DEL/close) the spin_lock and
list_del operate on freed memory.  With epoll the dangling entry
persists until the fd is closed.

> +	if (mtk_port_status_check(port))
> +		return EPOLLERR | EPOLLHUP;
> +
> +	ctrl_blk = port->port_mngr->ctrl_blk;
> +	hif_cmd.rx_ch = port->info.rx_ch;
> +	if (!ctrl_blk->ops->send_cmd(ctrl_blk->mdev, HIF_CTRL_CMD_CHECK_TX_FULL, &hif_cmd))
> +		mask |= EPOLLOUT | EPOLLWRNORM;
> +
> +	return mask;
> +}

[Severity: Low]
Should negative returns be distinguished from "queue full" here?  The
callee mixes a boolean with error codes on the same int:

drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c:mtk_pcie_hif_cmd_func() {
	case HIF_CTRL_CMD_CHECK_TX_FULL:
		...
		if (!atomic_read(&trans->available)) {
			ret = -EIO;
			break;
		}
		...
		ret = mtk_queue_list_is_full(trans, que);
}

If the transport becomes unavailable before the FSM disables the port,
mtk_port_status_check() still passes, send_cmd() returns -EIO and the
mask stays 0, so a poll()ing writer is told the port is neither
writable nor in error.  Would testing for > 0 as full and mapping < 0
to EPOLLERR be more accurate?

> +
> +static const struct wwan_port_ops wwan_ops = {
> +	.start = mtk_port_wwan_open,
> +	.stop = mtk_port_wwan_close,
> +	.tx = mtk_port_wwan_write,
> +	.tx_blocking = mtk_port_wwan_write_blocking,
> +	.tx_poll = mtk_port_wwan_poll,
> +};
> +

[ ... ]

> +static void mtk_port_wwan_enable(struct mtk_port *port)
> +{

[ ... ]

> +	caps.frag_len = port->tx_mtu;
> +	caps.headroom_len = sizeof(struct mtk_ccci_header);
> +
> +	/* These bits must be set before wwan_create_port(): the device node
> +	 * becomes openable inside it and mtk_port_common_open() rejects a
> +	 * port without PORT_S_ENABLE.
> +	 */
> +	set_bit(PORT_S_WR, &port->status);
> +	set_bit(PORT_S_ENABLE, &port->status);
> +
> +	wp = wwan_create_port(port_mngr->ctrl_blk->mdev->dev,
> +			      port->w_priv.w_type,
> +			      &wwan_ops, &caps, port);

[ ... ]

> +	mutex_lock(&port->w_priv.w_lock);
> +	port->w_priv.w_port = wp;
> +	mutex_unlock(&port->w_priv.w_lock);
> +}

[Severity: Low]
This isn't a bug today, but the state bits and the w_port pointer are
published in the opposite order from how the consumers read them.
wwan_create_port() registers the char device, so userspace can open the
node and set PORT_S_OPEN while w_priv.w_port is still NULL; an RX frame
arriving in that window is dropped with -ENXIO by mtk_port_wwan_recv().
mtk_port_wwan_disable() also relies on PORT_S_ENABLE alone as proof
that w_port is valid and passes it to wwan_remove_port() unchecked,
which holds only because both enable and disable run from the single
FSM kthread (mtk_fsm_evt_handler() -> mtk_fsm_switch_state() ->
mtk_ctrl_fsm_state_listener()).  Would it be more robust to store
w_port before setting PORT_S_ENABLE/PORT_S_WR, and to NULL-check
w_port in the disable path?

> +
> +static void mtk_port_wwan_disable(struct mtk_port *port)
> +{
> +	struct wwan_port *w_port;
> +
> +	if (!test_and_clear_bit(PORT_S_ENABLE, &port->status))
> +		return;
> +
> +	clear_bit(PORT_S_WR, &port->status);

[Severity: Low]
Should this clear be followed by a wake_up_all(&port->trb_wq)?
PORT_S_WR is part of the blocking TX wait condition:

drivers/net/wwan/t9xx/mtk_port.c:mtk_port_send_data() {
	ret = wait_event_interruptible_timeout(port->trb_wq,
					       trb->status <= 0 ||
					       test_bit(PORT_S_FLUSH, &port->status) ||
					       !test_bit(PORT_S_WR, &port->status),
					       MTK_DFLT_TRB_TIMEOUT);
}

mtk_port_common_close() wakes both queues when it sets PORT_S_FLUSH,
but here the flag change is silent.  If mtk_port_ch_disable() fails
early (for example its __dev_alloc_skb() returns NULL) and no TRB
completion wakes the queue, the sleeper only re-evaluates after
MTK_DFLT_TRB_TIMEOUT, while wwan_remove_port() below waits on the same
port->ops_lock the writer holds via wwan_port_op_tx().

> +	mutex_lock(&port->w_priv.w_lock);
> +	w_port = port->w_priv.w_port;
> +	port->w_priv.w_port = NULL;
> +	mutex_unlock(&port->w_priv.w_lock);
> +
> +	mtk_port_ch_disable(port);
> +	wwan_remove_port(w_port);
> +}
> +
> +static int mtk_port_wwan_recv(struct mtk_port *port, struct sk_buff *skb)
> +{
> +	/* Drop frames when nobody has the device open: wwan_port_rx() queues
> +	 * without bound and only a reader drains the queue, so accepting
> +	 * unsolicited traffic here would grow the rxq indefinitely.
> +	 */
> +	if (!test_bit(PORT_S_OPEN, &port->status)) {
> +		dev_dbg_ratelimited(port->port_mngr->ctrl_blk->mdev->dev,
> +				    "Drop RX for unopened port(%s)\n", port->info.name);
> +		return -ENXIO;
> +	}
> +
> +	mutex_lock(&port->w_priv.w_lock);
> +	if (!port->w_priv.w_port) {
> +		mutex_unlock(&port->w_priv.w_lock);
> +		return -ENXIO;
> +	}
> +
> +	wwan_port_rx(port->w_priv.w_port, skb);
> +	mutex_unlock(&port->w_priv.w_lock);
> +	return 0;
> +}

[Severity: Medium]
Can a frame be queued after the core has purged the rx queue, and then
be read by the next opener?  PORT_S_OPEN is tested outside w_lock here,
and the close path clears it without taking w_lock:

mtk_port_wwan_close() -> mtk_port_common_close() {
	clear_bit(PORT_S_OPEN, &port->status);
	...
}

net/wwan/wwan_core.c:wwan_port_op_stop() {
	if (!port->start_count) {
		if (port->ops)
			port->ops->stop(port);
		skb_queue_purge(&port->rxq);
	}
}

The CLDMA rx context never takes ops_lock, so this interleaving looks
possible:

  rx: test_bit(PORT_S_OPEN) -> true
  close: mtk_port_common_close() clears PORT_S_OPEN
  close: wwan_port_op_stop() does skb_queue_purge(&port->rxq)
  rx: mutex_lock(&w_lock), w_port still non-NULL, wwan_port_rx()

The skb then stays on w_port->rxq, and mtk_port_common_open() only
purges the driver-side list:

	skb_queue_purge(&port->rx_skb_list);
	set_bit(PORT_S_OPEN, &port->status);

so the next opener of the AT or MBIM node reads a response belonging to
the previous session.  Would checking PORT_S_OPEN under w_lock (and
clearing it under the same lock) close this?

> +

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c b/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
> index 050416e0b914d..761a068b859b2 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
> @@ -16,6 +16,10 @@ static const int mtk_srv_cfg_m9xx[NR_CLDMA][HW_QUE_NUM] = {
>  
>  /* the number of RX GPDs should be at least two */
>  static const struct queue_info mtk_queue_info_m9xx[] = {
> +	{CCCI_UART2_TX, CCCI_UART2_RX, CLDMA1, TXQ(5), RXQ(5),
> +	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},
> +	{CCCI_MBIM_TX, CCCI_MBIM_RX, CLDMA1, TXQ(2), RXQ(2),
> +	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},

[ ... ]
