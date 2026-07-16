Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39E392814;
	Thu, 16 Jul 2026 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194465; cv=none; b=BriaMor2lGsO0Y5QQ5pZ/LhCeOlLW5E5lWB1gp6dSj0VkiM0cmSa3bNZN9c53wOrgKpvKHcHCVFSzyiE2C6Q4N3dTV5oCSUb/pma1mICSHBy1XxprAlA8O4uFwop2Y2UrxjZnlc9YowJl15j2ikX93dFucgnhIVIGq8LtQvyUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194465; c=relaxed/simple;
	bh=ZwEkCg6z6NeVLuKm1jj108KKQYdo7pqocaIckmMbsRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omAqNS62Can0B8zFnVgblMgYq61V6jOSn62/Du7r0+lpspZSzypMT2PEuFP8u8PffrEaMQjQWqYtm16dFCn3L007IplmGPHWU4rbp4e1O898Ao4eAbhyJM2+TSFBp+qziiPtdmbez8PDO63S+PLFemix9KVvAxcXKSv+k3dOeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4F8p16Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4F8p16Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1BA1F00AC4;
	Thu, 16 Jul 2026 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784194461;
	bh=5bOJ7hXck+yEwAc/J40tVbAfmzpN55nMr/sXBYljno0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4F8p16YXER5QUkvm4GJ2IvIV9M3NzajEkDWkjfcUHo3dsTKIMcZ5WdyfVFrDIwcZ
	 YuwKEKsvBNGIOyDDYcQkkuVVU1klOD1PKic5TErOv95OdK2LfcfquuPb1rqaoOM8TB
	 AzIrV+CQ149NBPv0kY8ltPrtY4VOBNtN8hw4FwRmIWunlXg3Ff4NYdgqAeRGPTpD7R
	 QMPPd6PtaxMe+FMpGWdexpJknC1ZgBMZ9P5SbR/W0RXgbR29MVPWHDIg2Vyff3w9QQ
	 tP2/2deagBbBHNpaclw1cHjAi9r6diOXCfW1xu+3SM7amzJggMVFNo3G2CnjjCsi8w
	 /Qtw6YIf8N3qA==
From: Simon Horman <horms@kernel.org>
To: jackbb_wu@compal.com
Cc: Simon Horman <horms@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wen-zhi.huang@mediatek.com,
	shi-wei.yeh@mediatek.com,
	Minano.tseng@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 4/7] net: wwan: t9xx: Add control port
Date: Thu, 16 Jul 2026 10:34:14 +0100
Message-ID: <20260716093414.231093-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709-t9xx_driver_v1-v4-4-a8c009d509c5@compal.com>
References: <20260709-t9xx_driver_v1-v4-4-a8c009d509c5@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [4]: [PATCH v4 4/7] net: wwan: t9xx: Add control port ---
commit 8d0ed42502a8e2e3fe15beabcf8bda318350f746
Author: Jack Wu <jackbb_wu@compal.com>
Date:   Thu Jul 9 10:53:26 2026 +0000

    net: wwan: t9xx: Add control port
    
    The control port consists of port I/O and port manager.
    Port I/O provides a common operation as defined by "struct port_ops",
    and the operation is managed by the "port manager". It provides
    interfaces to internal users, the implemented internal interfaces are
    open, close, write and recv_register.

> diff --git a/drivers/net/wwan/t9xx/mtk_port.c b/drivers/net/wwan/t9xx/mtk_port.c
> new file mode 100644
> index 0000000000000..06436422133ba
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_port.c
> @@ -0,0 +1,875 @@
[ ... ]
> +static void mtk_port_free_or_backup(struct mtk_port_mngr *port_mngr,
> +				    struct mtk_port *port, struct mtk_stale_list *s_list)
> +{
> +	mutex_lock(&port_mngr_grp_mtx);
> +	mtk_port_tbl_del(port_mngr, port);
> +	if (port->info.type != PORT_TYPE_INTERNAL) {
> +		if (test_bit(PORT_S_OPEN, &port->status)) {
> +			list_add_tail(&port->stale_entry, &s_list->ports);
> +			set_bit(PORT_S_ON_STALE_LIST, &port->status);
> +			memcpy(port->dev_str, port_mngr->ctrl_blk->mdev->dev_str,
> +			       MTK_DEV_STR_LEN);
> +			port->port_mngr = NULL;
> +		}
> +		kref_put(&port->kref, mtk_port_release);
> +	} else {
> +		mtk_port_release(&port->kref);

[Severity: High]
Does this directly bypass the kref API? By explicitly calling
mtk_port_release() rather than kref_put(), this forces the port to be freed
immediately, ignoring any active references internal clients might still hold.
Could this lead to a use-after-free during device removal or module unload?

> +	}
> +	mutex_unlock(&port_mngr_grp_mtx);
> +}
> +
> +static struct mtk_port *mtk_port_search_by_id(struct mtk_port_mngr *port_mngr, int rx_ch)
> +{
> +	int tbl_type = MTK_PORT_TBL_TYPE(rx_ch);
> +
> +	if (tbl_type < PORT_TBL_SAP || tbl_type >= PORT_TBL_MAX)
> +		return NULL;
> +
> +	return radix_tree_lookup(&port_mngr->port_tbl[tbl_type], MTK_CH_ID(rx_ch));

[Severity: High]
Is it safe to perform radix tree lookups without an RCU read-side critical
section?

Since mtk_port_release() uses a synchronous kfree() instead of kfree_rcu(),
if a port closure or device removal occurs concurrently, the traversal here
might access freed radix tree nodes or port structures.

> +}
> +
> +struct mtk_port *mtk_port_search_by_name(struct mtk_port_mngr *port_mngr, char *name)
> +{
> +	int tbl_type = PORT_TBL_SAP;
> +	struct radix_tree_iter iter;
> +	struct mtk_port *port;
> +	void __rcu **slot;
> +
> +	do {
> +		radix_tree_for_each_slot(slot, &port_mngr->port_tbl[tbl_type], &iter, 0) {

[Severity: High]
Similarly, does this radix tree iteration require rcu_read_lock() protection
to prevent traversing into memory that has been concurrently freed?

> +			MTK_PORT_SEARCH_FROM_RADIX_TREE(port, slot);
> +			MTK_PORT_INTERNAL_NODE_CHECK(port, slot, iter);
> +			if (!strncmp(port->info.name, name, MTK_DFLT_PORT_NAME_LEN))
> +				return port;
> +		}
> +		tbl_type++;
> +	} while (tbl_type < PORT_TBL_MAX);
> +
> +	return NULL;
> +}
[ ... ]
> +void mtk_port_stale_list_grp_cleanup(void)
> +{
> +	struct mtk_stale_list *s_list, *next_s_list;
> +	struct mtk_port *port, *next_port;
> +
> +	mutex_lock(&port_mngr_grp_mtx);
> +	list_for_each_entry_safe(s_list, next_s_list, &stale_list_grp, entry) {
> +		list_del(&s_list->entry);
> +
> +		list_for_each_entry_safe(port, next_port, &s_list->ports, stale_entry) {
> +			clear_bit(PORT_S_ON_STALE_LIST, &port->status);
> +			mtk_port_release(&port->kref);

[Severity: High]
This appears to be another instance of bypassing the kref API by calling
mtk_port_release() directly instead of kref_put().

> +		}
> +
> +		kfree(s_list);

[Severity: Medium]
Does this leak the s_list->dev_id? The list entries are freed here during
module unload, but there doesn't appear to be a corresponding call to
ida_free() to return the dev_id to the allocator.

> +	}
> +	mutex_unlock(&port_mngr_grp_mtx);
> +}
[ ... ]
> +void mtk_port_trb_init(struct mtk_port *port, struct trb *trb, enum mtk_trb_cmd_type cmd,
> +		       int (*trb_complete)(struct sk_buff *skb))
> +{
> +	kref_init(&trb->kref);
> +	trb->channel_id = port->info.rx_ch;
> +	trb->status = MTK_DFLT_TRB_STATUS;
> +	trb->priv = port;

[Severity: High]
Does this assignment need to take a reference to the port with kref_get()?

If a non-blocking transmission is submitted, the port could be closed and
freed while the TRB is still in the hardware DMA ring. When the DMA
interrupt finally fires, the async completion handler mtk_port_tx_complete()
will access trb->priv, potentially dereferencing a freed port pointer.

> +	trb->cmd = cmd;
> +	trb->trb_complete = trb_complete;
> +}
[ ... ]
> +int mtk_port_send_data(struct mtk_port *port, void *data)
> +{
> +	struct mtk_port_mngr *port_mngr;
> +	struct sk_buff *skb = data;
> +	bool force_send;
> +	struct trb *trb;
> +	int ret, len;
> +
> +	port_mngr = port->port_mngr;
> +
> +	force_send = !!(port->info.flags & (PORT_F_BLOCKING | PORT_F_FORCE_SEND));
> +	trb = (struct trb *)skb->cb;
> +	mtk_port_trb_init(port, trb, TRB_CMD_TX, mtk_port_tx_complete);
> +	len = skb->len;
> +	kref_get(&trb->kref); /* kref count 1->2 */
> +
> +	/* add ccci header */
> +	mtk_port_add_header(skb);
> +	ret = mtk_port_status_check(port);
> +	if (!ret)
> +		ret = port_mngr->ctrl_blk->ops->submit_skb(port_mngr->ctrl_blk->mdev,
> +							   skb, force_send);
> +
> +	if (ret < 0) {
> +		kref_put(&trb->kref, mtk_port_trb_free); /* kref count 2->1 */
> +		kref_put(&trb->kref, mtk_port_trb_free); /* kref count 1->0 */
> +		port->tx_seq--;

[Severity: Medium]
Can concurrent writers corrupt the tx_seq variable?

Because the mtk_port_internal_write() API doesn't seem to enforce locking,
multiple threads transmitting on the same port can induce a read-modify-write
race on this variable here and in mtk_port_add_header(). This could result in
duplicate or out-of-order sequence numbers being sent to the WWAN modem.

> +		goto out;
> +	}
[ ... ]
> +static int mtk_port_rx_dispatch_frag_skb(struct mtk_port *port, struct sk_buff *skb)
> +{
> +	struct sk_buff *frag_skb, *frag_next;
> +	int ret;
> +
> +	frag_skb = skb_shinfo(skb)->frag_list;
> +	skb->len -= skb->data_len;
> +	skb->data_len = 0;
> +	skb_shinfo(skb)->frag_list = NULL;
> +
> +	ret = ports_ops[port->info.type]->recv(port, skb);
> +	if (ret < 0) {
> +		skb_shinfo(skb)->frag_list = frag_skb;

[Severity: High]
Can this lead to a use-after-free and a double-free on the skb?

If the port is not in an open state, mtk_port_internal_recv() explicitly calls
dev_kfree_skb_any(skb) and returns -ENXIO:

mtk_port_internal_recv() {
    if (!test_bit(PORT_S_OPEN, &port->status))
        goto drop_data;
    ...
drop_data:
    dev_kfree_skb_any(skb);
    return ret;
}

When the error returns here to mtk_port_rx_dispatch_frag_skb(), it accesses
the freed skb to update frag_list. It then propagates the error up to
mtk_port_rx_dispatch(), which jumps to the drop_data label and frees the skb
a second time.

> +		return ret;
> +	}
[ ... ]
> +static int mtk_port_rx_dispatch(struct sk_buff *skb, void *priv, bool force_recv)
> +{
[ ... ]
> +	/* Support scatter gather transmission */
> +	if (port->rx_mtu > port->rx_frag_size) {
> +		ret = mtk_port_rx_dispatch_frag_skb(port, skb);
> +		/* -EIO means partial data dispatch complete, does not goto drop flow */
> +		if (ret < 0 && ret != -EIO)
> +			goto drop_frag_skb;
> +	} else {
> +		ret = ports_ops[port->info.type]->recv(port, skb);
> +		if (ret < 0)
> +			goto drop_data;
> +	}
> +
> +	return ret;
> +
> +drop_frag_skb:
> +	{
> +		struct sk_buff *frag_skb, *tmp;
> +
> +		frag_skb = skb_shinfo(skb)->frag_list;
> +		while (frag_skb) {
> +			tmp = frag_skb->next;
> +			frag_skb->next = NULL;
> +			dev_kfree_skb_any(frag_skb);
> +			frag_skb = tmp;
> +		}
> +		skb_shinfo(skb)->frag_list = NULL;
> +	}
> +drop_data:
> +	dev_kfree_skb_any(skb);

[Severity: High]
This is where the second free of the skb occurs when propagating the error
from the recv callback.

> +	return ret;
> +}
> +
> +int mtk_port_add_header(struct sk_buff *skb)
> +{
[ ... ]
> +	ccci_h->packet_header = cpu_to_le32(0);
> +	ccci_h->packet_len = cpu_to_le32(skb->len);
> +	ccci_h->ex_msg = cpu_to_le32(0);
> +	ccci_h->status = cpu_to_le32(FIELD_PREP(MTK_HDR_FLD_CHN, port->info.tx_ch) |
> +				     FIELD_PREP(MTK_HDR_FLD_SEQ, port->tx_seq++) |

[Severity: Medium]
This is the other side of the tx_seq data race where concurrent writers will
corrupt the sequence tracking.

> +				     FIELD_PREP(MTK_HDR_FLD_AST, 1));
> +
> +	trb->status = MTK_TRB_HEADER_ADDED;
> +
> +	return 0;
> +}
[ ... ]
> +int mtk_port_status_update(struct mtk_md_dev *mdev, void *data)
> +{
> +	struct mtk_port_enum_msg *msg = data;
> +	struct mtk_port_info *port_info;
> +	struct mtk_port_mngr *port_mngr;
> +	struct mtk_ctrl_blk *ctrl_blk;
> +	struct mtk_port *port;
> +	int port_id;
> +	u16 ch_id;
> +
> +	if (unlikely(!mdev || !msg))
> +		return -EINVAL;
> +
> +	ctrl_blk = mdev->ctrl_blk;
> +	port_mngr = ctrl_blk->port_mngr;
> +	if (le16_to_cpu(msg->version) != MTK_PORT_ENUM_VER ||
> +	    le32_to_cpu(msg->head_pattern) != MTK_PORT_ENUM_HEAD_PATTERN ||
> +	    le32_to_cpu(msg->tail_pattern) != MTK_PORT_ENUM_TAIL_PATTERN)
> +		return -EPROTO;
> +
> +	for (port_id = 0; port_id < le16_to_cpu(msg->port_cnt); port_id++) {

[Severity: High]
Is there a missing bounds check on msg->port_cnt here?

This loop relies strictly on the device-provided port_cnt value without
validating it against the actual size of the received msg->data payload.
A malformed or maliciously large count from the WWAN firmware could cause an
out-of-bounds memory read.

> +		port_info = (struct mtk_port_info *)(msg->data +
> +						   (sizeof(*port_info) * port_id));
> +		ch_id = FIELD_GET(MTK_INFO_FLD_CHID, le16_to_cpu(port_info->channel));
> +		port = mtk_port_search_by_id(port_mngr, ch_id);
> +		if (!port)
> +			continue;
> +		port->enable = FIELD_GET(MTK_INFO_FLD_EN, le16_to_cpu(port_info->channel));
> +	}
> +
> +	return 0;
> +}
> +
> +int mtk_port_ch_enable(struct mtk_port *port)
> +{
[ ... ]
> +start_wait:
> +	ret = wait_event_interruptible_timeout(port->trb_wq, trb->status <= 0,
> +					       MTK_DFLT_TRB_TIMEOUT);
> +	if (ret == -ERESTARTSYS)
> +		goto start_wait;

[Severity: High]
Could this create an infinite loop in kernel space?

If a process executing this function has a pending signal (such as being
killed), wait_event_interruptible_timeout() returns -ERESTARTSYS immediately
without sleeping. The unconditional goto forces a tight loop that never
returns to userspace to process the signal.

> +	else if (!ret)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = trb->status;
> +
> +	kref_put(&trb->kref, mtk_port_trb_free);
> +
> +	return ret;
> +}
> +
> +int mtk_port_ch_disable(struct mtk_port *port)
> +{
[ ... ]
> +start_wait:
> +	ret = wait_event_interruptible_timeout(port->trb_wq, trb->status <= 0,
> +					       MTK_DFLT_TRB_TIMEOUT);
> +	if (ret == -ERESTARTSYS)
> +		goto start_wait;

[Severity: High]
This appears to have the same infinite loop risk as mtk_port_ch_enable() when
a signal is pending.

> +	else if (!ret)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = trb->status;
> +
> +	kref_put(&trb->kref, mtk_port_trb_free);
> +
> +	return ret;
> +}

> diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
> new file mode 100644
> index 0000000000000..e3a2de6d2f297
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_port_io.c
> @@ -0,0 +1,239 @@
[ ... ]
> +static int mtk_port_internal_recv(struct mtk_port *port, struct sk_buff *skb)
> +{
> +	struct mtk_internal_port *priv;
> +	int ret = -ENXIO;
> +
> +	if (!test_bit(PORT_S_OPEN, &port->status))
> +		goto drop_data;
> +
> +	priv = &port->i_priv;
> +	if (!priv->recv_cb || !priv->arg)
> +		goto drop_data;
> +
> +	ret = priv->recv_cb(priv->arg, skb);
> +	return ret;
> +
> +drop_data:
> +	dev_kfree_skb_any(skb);

[Severity: High]
This is where the skb is freed on the error path before returning -ENXIO,
leading to the use-after-free and double-free in the caller.

> +	return ret;
> +}
> +
> +static int mtk_port_common_open(struct mtk_port *port)
> +{
> +	int ret = 0;
> +
> +	if (!test_bit(PORT_S_ENABLE, &port->status))
> +		return -ENODEV;
> +
> +	if (test_bit(PORT_S_OPEN, &port->status))
> +		return -EBUSY;
> +
> +	skb_queue_purge(&port->rx_skb_list);
> +	set_bit(PORT_S_OPEN, &port->status);

[Severity: High]
Is this test_bit() and set_bit() sequence intended to provide mutual
exclusion?

Since this is not an atomic test-and-set operation, two threads could
concurrently observe PORT_S_OPEN as unset, simultaneously execute
skb_queue_purge() which corrupts the queue, and both proceed believing
they have successfully opened the port.

> +	clear_bit(PORT_S_FLUSH, &port->status);
> +
> +	return ret;
> +}
[ ... ]
