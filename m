Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69339BFED;
	Sat, 19 Sep 2026 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789862095; cv=none; b=dK61+NgvXjpeoVP6JkUHFishUe7V+4RoGx/E7HqZBb+qJSMF6pyK2Lubaqu2JA5Yw1CvKxxfCGxPKLIpqejxuVEhsMMWQ33tYvwN0x4w8Re1n8jiwa0VCHTn4y1ZgsJW6kW3IvvaQ8vrnCjQFfdYP2nnVkpTkbkj3zhkSSg9oiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789862095; c=relaxed/simple;
	bh=pgob9BG6pjlGkfDSml2C3jTe5dmh7RRvVXW2hZ2tA6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMdI4giW7RDugtlGP+KLUcTcXZ4P86ejJXGooAv0vl9I3637yiort4Qu4ujnciguc0PLB+ETn0IWY9gEGm0Ksy0lxlGs2yUreaSa/7AKAibHWdHcMUmODttwjYydrEAXYn7sSC0W4uKRiJj9oe5FURRo520dToRajy0LWaWEjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXfGH2RA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXfGH2RA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4D91F000FF;
	Sat, 19 Sep 2026 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789862093;
	bh=eQCqGG9Fza6Jic+ROJWwegFMOT6jRABBQZzOA5Yx8gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXfGH2RAOTk3Hw8qQzpecaiAXDxfP3VMZ6/WUfsJjjKV4v4OVQ3oEuDfGLQUr3w9z
	 6sd+DroMXWjtwXL3Pd7WqV6jUYeKiAlqM5hzI6G35zzWuON8mt49kmyfpvGFCWbuWH
	 oc8ICbRsGyA76vwMZLxUOw56yqM7VbHfLPdp8pH+CZJKcZjWJ4fPbMICx7wVKdSv4+
	 HrPcvb4Bjadztv8Vf36OEY9HEAHKwfbvQdbrwBZB2kFDULFo5SXrNQ0OoRmLn2Ui1T
	 5p4GBxCx3IDMfHUHPPFKvRFCSbZj7lljD1HtSGJ1qTYumSddIfp1z9sMdOGEkXSIeL
	 8sDmoUdlDR01Q==
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
Subject: Re: [PATCH v8 4/6] net: wwan: t9xx: Add control port
Date: Sat, 19 Sep 2026 16:54:51 -0700
Message-ID: <20260919235451.839752-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914-t9xx_driver_v1-v8-4-5206c2e6bea0@compal.com>
References: <20260914-t9xx_driver_v1-v8-4-5206c2e6bea0@compal.com>
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
net: wwan: t9xx: Add control port

This adds the t9xx control port layer: a port manager that creates and
destroys ports, keeps them in a global "stale list" across driver
re-creation, and moves data between port I/O and CLDMA via TRBs. It also
adds the internal port operations (open, close, write, recv_register) and
wires the port configuration into the control plane init path.

A few questions about the new code below.

> diff --git a/drivers/net/wwan/t9xx/mtk_port.c b/drivers/net/wwan/t9xx/mtk_port.c
> new file mode 100644
> index 0000000000000..d2a5db11afd6b
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_port.c
> @@ -0,0 +1,873 @@

[ ... ]

> +static int mtk_port_tbl_add(struct mtk_port_mngr *port_mngr, struct mtk_port *port)
> +{
> +	int ret;
> +
> +	ret = radix_tree_insert(&port_mngr->port_tbl[MTK_PORT_TBL_TYPE(port->info.rx_ch)],
> +				port->info.rx_ch & 0xFFF, port);
> +	if (ret)
> +		dev_err(port_mngr->ctrl_blk->mdev->dev,
> +			"port(%s) add to port_tbl failed, return %d\n",
> +			port->info.name, ret);
> +	else
> +		port_mngr->port_cnt++;
> +
> +	return ret;
> +}
> +
> +static void mtk_port_tbl_del(struct mtk_port_mngr *port_mngr, struct mtk_port *port)
> +{
> +	radix_tree_delete(&port_mngr->port_tbl[MTK_PORT_TBL_TYPE(port->info.rx_ch)],
> +			  port->info.rx_ch & 0xFFF);
> +	port_mngr->port_cnt--;
> +}
> +
> +static struct mtk_port *mtk_port_restore_from_stale_list(struct mtk_port_mngr *port_mngr,
> +							 struct mtk_stale_list *s_list)
> +{
> +	struct mtk_port *port, *next_port;
> +	int ret;
> +
> +	mutex_lock(&port_mngr_grp_mtx);
> +	list_for_each_entry_safe(port, next_port, &s_list->ports, stale_entry) {
> +		kref_get(&port->kref);
> +		list_del(&port->stale_entry);
> +		ret = mtk_port_tbl_add(port_mngr, port);
> +		if (ret) {
> +			list_add_tail(&port->stale_entry, &s_list->ports);
> +			kref_put(&port->kref, mtk_port_release);
> +			mutex_unlock(&port_mngr_grp_mtx);
> +			dev_err(port_mngr->ctrl_blk->mdev->dev,
> +				"Failed when adding (%s) to port mngr\n",
> +				port->info.name);
> +			return ERR_PTR(ret);
> +		}

[ ... ]

> +static int mtk_port_tbl_create(struct mtk_port_mngr *port_mngr, struct mtk_port_cfg *cfg,
> +			       const int port_cnt, struct mtk_stale_list *s_list)
> +{
> +	struct mtk_port_cfg *dflt_port;
> +	struct mtk_port *port;
> +	int i;
> +
> +	INIT_RADIX_TREE(&port_mngr->port_tbl[PORT_TBL_SAP], GFP_KERNEL);
> +	INIT_RADIX_TREE(&port_mngr->port_tbl[PORT_TBL_MD], GFP_KERNEL);
> +
> +	mtk_port_restore_from_stale_list(port_mngr, s_list);

[Severity: Medium]

mtk_port_restore_from_stale_list() reports failure through ERR_PTR(), but
mtk_port_tbl_create() discards the result. Should this be checked with
IS_ERR(), keeping in mind the success return is NULL rather than a port?

When mtk_port_tbl_add() -> radix_tree_insert() fails (-ENOMEM for a tree
node, or -EEXIST), the helper re-queues the current port, drops the extra
kref and returns early, so the remaining stale ports are never restored:
they keep PORT_S_ON_STALE_LIST set and port->port_mngr == NULL.

Since the error is swallowed, the loop below then finds nothing for those
rx_ch values:

	if (!mtk_port_search_by_id(port_mngr, dflt_port->rx_ch)) {
		port = mtk_port_alloc_and_add(port_mngr, dflt_port);

and creates a second port object for the same channel, while
mtk_port_mngr_init() still returns 0.

Does the user still holding the stale handle then end up with a port whose
port_mngr is NULL and PORT_S_ENABLE clear, so every mtk_port_send_data()
on it fails in mtk_port_status_check() with -ENODEV?

> +
> +	/* copy ports from static port cfg table */
> +	for (i = 0; i < port_cnt; i++) {
> +		dflt_port = cfg + i;
> +		if (!mtk_port_search_by_id(port_mngr, dflt_port->rx_ch)) {
> +			port = mtk_port_alloc_and_add(port_mngr, dflt_port);
> +			if (IS_ERR(port))
> +				return PTR_ERR(port);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtk_port_tbl_destroy(struct mtk_port_mngr *port_mngr, struct mtk_stale_list *s_list)
> +{
> +	struct radix_tree_iter iter;
> +	struct mtk_port *port;
> +	void __rcu **slot;
> +	int tbl_type;
> +
> +	tbl_type = PORT_TBL_SAP;
> +	do {
> +		radix_tree_for_each_slot(slot, &port_mngr->port_tbl[tbl_type], &iter, 0) {
> +			port = radix_tree_deref_slot(slot);
> +			if (!port)
> +				continue;
> +			ports_ops[port->info.type]->disable(port);
> +		}

[Severity: Medium]

radix_tree_deref_slot() is rcu_dereference(*slot), and this loop runs in
plain process context (driver removal and the mtk_port_mngr_init() error
path) with no rcu_read_lock() held. With CONFIG_PROVE_RCU=y, does this
produce a "suspicious rcu_dereference_check() usage" splat on every
teardown?

Wrapping the loop in rcu_read_lock() would not work either, since
ports_ops[]->disable() sleeps: mtk_port_ch_disable() does a GFP_KERNEL
skb allocation and then wait_event_timeout() for up to
MTK_DFLT_TRB_TIMEOUT.

More generally, the synchronisation the radix-tree API asks callers to
provide looks incomplete here. The mutators run under port_mngr_grp_mtx
from mtk_port_restore_from_stale_list() and mtk_port_free_or_backup(), but
with no lock at all from mtk_port_tbl_create() -> mtk_port_alloc_and_add()
-> mtk_port_tbl_add(); the readers mtk_port_search_by_id() and
mtk_port_search_by_name() hold neither the mutex nor rcu_read_lock(), and
mtk_port_release() frees a tree-published object with a plain kfree():

	ports_ops[port->info.type]->exit(port);
	kfree(port);

Would a single writer lock covering all mutators (including the port_cnt
updates) plus RCU-deferred freeing be more appropriate?

[ ... ]

> +static struct mtk_stale_list *mtk_port_stale_list_init(struct mtk_ctrl_blk *ctrl_blk, int *dev_id)
> +{
> +	struct mtk_stale_list *s_list;
> +
> +	s_list = mtk_port_stale_list_search(ctrl_blk->mdev->dev_str);
> +	if (!s_list) {
> +		s_list = mtk_port_stale_list_create(ctrl_blk);
> +		if (unlikely(!s_list))
> +			return NULL;
> +	}
> +
> +	mutex_lock(&port_mngr_grp_mtx);
> +	if (s_list->dev_id < 0) {
> +		*dev_id = ida_alloc_range(&ccci_dev_ids, 0, MTK_DFLT_MAX_DEV_CNT - 1, GFP_KERNEL);

[Severity: Low]

The ida_alloc_range() return value is stored in *dev_id without being
tested, and mtk_port_stale_list_init() still reports success. On -ENOMEM,
or -ENOSPC once MTK_DFLT_MAX_DEV_CNT (10) devices are bound, does an errno
end up in port_mngr->dev_id while mtk_port_mngr_init() returns 0?

That value is later passed to ida_free() unconditionally in
mtk_port_stale_list_exit() below, while the other two ida_free() call
sites in this file guard it, in mtk_port_release():

	list_empty(&s_list->ports) && s_list->dev_id >= 0) {
		ida_free(&ccci_dev_ids, s_list->dev_id);

and in mtk_port_stale_list_grp_cleanup():

	if (s_list->dev_id >= 0)
		ida_free(&ccci_dev_ids, s_list->dev_id);

The bogus free itself is harmless, since ida_free() starts with
"if ((int)id < 0) return;", so this is about the unchecked allocation and
the inconsistency with the guarded call sites.

> +	} else {
> +		*dev_id = s_list->dev_id;
> +		s_list->dev_id = -1;
> +	}
> +	mutex_unlock(&port_mngr_grp_mtx);
> +
> +	return s_list;
> +}
> +
> +static void mtk_port_stale_list_exit(struct mtk_ctrl_blk *ctrl_blk,
> +				     struct mtk_stale_list *s_list, int dev_id)
> +{
> +	if (!s_list)
> +		return;
> +	mutex_lock(&port_mngr_grp_mtx);
> +	if (list_empty(&s_list->ports)) {
> +		ida_free(&ccci_dev_ids, dev_id);

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/mtk_port.h b/drivers/net/wwan/t9xx/mtk_port.h
> new file mode 100644
> index 0000000000000..a0248d7f939ae
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_port.h
> @@ -0,0 +1,150 @@

[ ... ]

> +enum mtk_port_flag {
> +	PORT_F_DFLT = 0,
> +	PORT_F_BLOCKING = BIT(1),
> +	PORT_F_ALLOW_DROP = BIT(2),

[Severity: Low]

This isn't a bug, but PORT_F_ALLOW_DROP has no reader anywhere. It is set
on every entry of port_cfg_m9xx[], yet the only runtime consumer of
port->info.flags is mtk_port_internal_write():

	return mtk_port_send_data(port, skb,
				  !!(port->info.flags & PORT_F_BLOCKING),
				  !!(port->info.flags &
				     (PORT_F_BLOCKING | PORT_F_FORCE_SEND)));

Ports with and without the flag behave identically. Could it be dropped
until the code that honours it is added?

> +	PORT_F_FORCE_SEND = BIT(6),
> +};

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
> new file mode 100644
> index 0000000000000..27b490fde40f2
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_port_io.c
> @@ -0,0 +1,247 @@

[ ... ]

> +static void mtk_port_internal_enable(struct mtk_port *port)
> +{
> +	int ret;
> +
> +	if (test_bit(PORT_S_ENABLE, &port->status))
> +		return;
> +
> +	ret = mtk_port_ch_enable(port);
> +	if (ret && ret != -EBUSY) {
> +		/* On -ETIMEDOUT the ENABLE trb may still be queued; queue a
> +		 * DISABLE behind it so the channel does not end up armed with
> +		 * no software owner.
> +		 */
> +		mtk_port_ch_disable(port);
> +		return;
> +	}
> +
> +	set_bit(PORT_S_WR, &port->status);
> +	set_bit(PORT_S_ENABLE, &port->status);
> +}
> +
> +static void mtk_port_internal_disable(struct mtk_port *port)
> +{
> +	if (!test_and_clear_bit(PORT_S_ENABLE, &port->status))
> +		return;
> +
> +	clear_bit(PORT_S_WR, &port->status);
> +	mtk_port_ch_disable(port);
> +}

[Severity: High]

mtk_port_internal_disable() clears PORT_S_ENABLE and then discards the
return value of mtk_port_ch_disable(), which can fail with -ENOMEM (skb
allocation), -EIO (mtk_pcie_hif_submit_skb() whenever
atomic_read(&trans->available) == 0) or -ETIMEDOUT after
MTK_DFLT_TRB_TIMEOUT. Can this leave the software state claiming the
channel is down while trans->usr_cnt[hif_id][txqno] still counts a user?

The only decrement is in mtk_ch_status_check():

	case TRB_CMD_DISABLE:
		if (trans->usr_cnt[que->hif_id][que->txqno] > 0) {
			trans->usr_cnt[que->hif_id][que->txqno]--;
			if (!trans->usr_cnt[que->hif_id][que->txqno])
				break;
		}
		trb->status = -EBUSY;

and mtk_ctrl_ch_flush() / mtk_ctrl_chs_flush() complete queued
ENABLE/DISABLE TRBs with

	trb->status = -EIO;
	trb->trb_complete(skb);

without passing through mtk_ch_status_check() at all.

For a modem that stops responding during teardown:

FSM_STATE_OFF
  mtk_port_disable() -> mtk_port_ch_disable() returns -ETIMEDOUT, the
  DISABLE skb is still queued
  mtk_port_internal_disable() ignores it and clears PORT_S_ENABLE
ops->exit() -> mtk_pcie_hif_exit()
  mtk_cldma_exit() frees drv_info->txq[]/rxq[]
  mtk_ctrl_trb_srv_exit() -> kthread_stop() -> mtk_ctrl_chs_flush()
  completes the queued DISABLE with -EIO, usr_cnt stays at 1

On the next bootup the ENABLE raises usr_cnt to 2, so
mtk_ch_status_check() takes the "already open" branch,
mtk_cldma_check_ch_cfg() finds drv_info->txq/rxq == NULL and returns
-EINVAL, and mtk_port_ch_enable() fails. The compensating
mtk_port_ch_disable() in mtk_port_internal_enable() then only takes
usr_cnt from 2 back to 1, never to 0.

Does that make the control channel unusable for the rest of the probe, so
the MD/SAP handshake never completes and the modem never reaches
FSM_STATE_READY, with every later boot cycle repeating it?

Related question on the same function: is -EBUSY safe to treat as a
successful enable without distinguishing where it came from?
mtk_cldma_open() rolls the usr_cnt reference back at its out: label when
it returns -EBUSY, while mtk_ch_status_check() keeps it.

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c b/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
> index 0019b64b037af..050416e0b914d 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
> @@ -21,7 +22,24 @@ static const struct queue_info mtk_queue_info_m9xx[] = {
>  	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},
>  };
>  
> +static const struct mtk_port_cfg port_cfg_m9xx[] = {
> +	{CCCI_CONTROL_TX, CCCI_CONTROL_RX, PORT_TYPE_INTERNAL, "MDCTRL",
> +		PORT_F_ALLOW_DROP},
> +	{CCCI_SAP_CONTROL_TX, CCCI_SAP_CONTROL_RX, PORT_TYPE_INTERNAL, "SAPCTRL",
> +		PORT_F_ALLOW_DROP},
> +};

These are the two descriptors that request the PORT_F_ALLOW_DROP behaviour
mentioned above.

[ ... ]
