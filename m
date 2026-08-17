Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8C3F3286;
	Mon, 17 Aug 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006221; cv=none; b=DuOIbVrWtuBwYAA4hLxfBQ+hnQq1WBAPlp52LvWEqEAtU18DPSCaD6aepksIfhhK5OhsEEwaLPXKZ2FOs5YOgzYYpdYhqSxYyybzEKNaTyE/oPfE3wQYw59/t0cVXd5jM2LUGa1X9X9PTMFNQJUVk1jHcD3DixSVjkCD5BvgGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006221; c=relaxed/simple;
	bh=4pSoV0FedtNIWMbTNFj2vncEYQPb8RuB0wcWsn+xEgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIapIppE1F3XETeRTm0cUH9mg0dBwwfdaAJh1u/KTUheA4FnQ84r6TubmGHcDsLHuWyqHcyuoX+EAHFV4uQYvR++FR4VG2nmZAngUpLlNiP7968aUrh9fTPGbHqYbB4Dotdf/+U7HDZtkjO+sEPnMQqWwtcoAnIExOWX544ayZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKO6Ug6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKO6Ug6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AE61F00A3A;
	Mon, 17 Aug 2026 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006218;
	bh=7FTumWu8AG1C1gGJhkiC0lozjxpP0IrL7ixWnRMOeHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKO6Ug6udUYkrMBhWjjfaAo4kIgCxf+IV+2YU2czl9YvkwXAagBwKbs9cId/fBLDp
	 5TzV78BaRSit2M4XnFSgH2P0igb2YiEItSbcj8pvL3jAfsicQKq1hTrtFoyHEOjeix
	 3uMhyMzBVgc/BYOCyNH5ZskSgJkVoFL2n1kxTUoqi/yOXBReyjudFPoJGrDW58jqk1
	 iZgBDBSTVl0hOr0Vi1yuNwgDnBDwA4KfVuyNN7ZlzclKL44atRXlF+RxfyL+KOwECj
	 mdZlhUNIx1OTY+38E0oFvxS5QG3Rw3G8sv3eO08VeLhMLsjv9yTDqoWCQNl/b5+tny
	 UykBH77/prxqQ==
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
Subject: Re: [PATCH v6 5/7] net: wwan: t9xx: Add FSM thread
Date: Mon, 17 Aug 2026 15:36:57 -0700
Message-ID: <20260817223657.3688752-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-t9xx_driver_v1-v6-5-2c969fad57c6@compal.com>
References: <20260811-t9xx_driver_v1-v6-5-2c969fad57c6@compal.com>
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
net: wwan: t9xx: Add FSM thread

This adds a finite-state-machine kthread that serializes asynchronous
events from the device and the OS, plus a notifier mechanism so other
modules can react before and after each state transition.  It also wires
the FSM into the PCI probe/remove path and into the control plane and
CLDMA transport.

No Link: tags are present in the commit header.

> net: wwan: t9xx: Add FSM thread
>
> The FSM (Finite-state Machine) thread is responsible for
> synchronizing the actions of different modules. The
> asynchronous events from the device or the OS will trigger
> a state transition.
>
> The FSM thread will append it to the event queue when an
> event arrives. It handles the events sequentially. After
> processing the event, the FSM thread notifies other modules
> before and after the state transition.
>
> Seven FSM states are defined. They can transition from one
> state to another, self-transition in some states, and
> transition in some sub-states.

[Severity: Low]
Does the code match this description?  enum mtk_fsm_state in the new
mtk_fsm.h defines five states:

	FSM_STATE_INVALID, FSM_STATE_OFF, FSM_STATE_ON,
	FSM_STATE_BOOTUP, FSM_STATE_READY

There is also no sub-state anywhere: struct mtk_md_fsm and
struct mtk_fsm_param have no sub-state member, and mtk_fsm_switch_state()
only ever assigns fsm->state.  Should the count and the sub-state
sentence be updated?

[Severity: Low]
The changelog only mentions the FSM thread, but the patch carries several
other functional changes.  Would it help reviewers to split them out or at
least mention them?

 - the HS1/HS2/HS3 handshake and runtime-feature protocol
   (mtk_fsm_send_hs1_msg(), mtk_fsm_parse_hs2_msg(),
   mtk_fsm_send_hs3_msg() and the two ctrl-msg handlers)

 - the whole operational CLDMA bring-up and teardown path
   (cldma_drv_info_tbl, mtk_cldma_get_drv_info(), mtk_cldma_isr(),
   mtk_cldma_dev_init(), mtk_cldma_dev_exit(), including DMA pools,
   a workqueue and MSI-X registration)

 - an skb leak fix in mtk_cldma_rxq_free(), adding
   dev_kfree_skb_any(req->skb) in the rxq->nr_bds branch to code added
   by the earlier CLDMA patch of this series, with no Fixes: tag

 - removal of all declared CLDMA4 support (CLDMA4 from enum mtk_hif_id,
   which shrinks NR_CLDMA from 3 to 2, plus CLDMA4_HW_ID,
   CLDMA4_BASE_ADDR, REG_CLDMA_INT_WF_MASK, the cldma4_base_addr and
   reg_cldma4_int_mask fields, and the CLDMA4 branch of
   mtk_cldma_drv_init_m9xx())

> diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> index 6ed47d0745565..1d9dc53482405 100644
> --- a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> +++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> @@ -5,10 +5,46 @@
> +static void mtk_ctrl_trans_fsm_state_handler(struct mtk_fsm_param *param,
> +					     struct mtk_ctrl_blk *ctrl_blk)
> +{
> +	struct mtk_md_dev *mdev = ctrl_blk->mdev;
> +
> +	switch (param->to) {
> +	case FSM_STATE_OFF:
> +		ctrl_blk->ops->fsm_indication(mdev, param);
> +		ctrl_blk->ops->exit(mdev);
> +		break;
> +	case FSM_STATE_ON:
> +		ctrl_blk->ops->init(mdev);
> +		fallthrough;

[Severity: High]
Can a failing ops->init() here lead to a NULL dereference on removal?

ops->init is mtk_pcie_hif_init(), which has several failure exits (kmemdup
ENOMEM, queue-info validation, radix_tree_insert(), mtk_cldma_init(),
mtk_ctrl_trb_srv_init()).  In all of them trans->trb_srv[] is left
all-NULL, but the return value is discarded here and the FSM commits
FSM_STATE_ON anyway.

On removal the FSM_STATE_OFF arm above calls ops->exit()
unconditionally:

mtk_pci_dev_exit() -> FSM_EVT_DEV_RM -> mtk_fsm_dev_rm_act()
  -> mtk_fsm_enter_off_state() (guard passes, state == ON)
  -> mtk_fsm_switch_state(FSM_STATE_OFF)
  -> mtk_ctrl_trans_fsm_state_handler() case FSM_STATE_OFF
  -> mtk_pcie_hif_exit() -> mtk_ctrl_trb_srv_exit()

and mtk_ctrl_trb_srv_exit() does:

	for (i = 0; i < trans->trb_srv_num; i++) {
		srv = trans->trb_srv[i];
		kthread_stop(srv->trb_thread);

with no NULL check.  The same unchecked-return pattern repeats one level
down, where the void mtk_cldma_fsm_state_listener() discards
mtk_cldma_dev_init() errors.

> +	default:
> +		ctrl_blk->ops->fsm_indication(mdev, param);
> +		break;
> +	}
> +}
> +
> +static void mtk_ctrl_fsm_state_listener(struct mtk_fsm_param *param, void *data)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = data;
> +
> +	mtk_port_mngr_fsm_state_handler(param, ctrl_blk->port_mngr);
> +	mtk_ctrl_trans_fsm_state_handler(param, ctrl_blk);
> +	mtk_port_mngr_fsm_state_handler_late(param, ctrl_blk->port_mngr);
> +}

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/mtk_fsm.c b/drivers/net/wwan/t9xx/mtk_fsm.c
> new file mode 100644
> index 0000000000000..8cf9b239caeaf
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_fsm.c

[ ... ]

> +static int mtk_fsm_parse_hs2_msg(struct fsm_hs_info *hs_info)
> +{
> +	struct mtk_md_fsm *fsm = container_of(hs_info, struct mtk_md_fsm, hs_info[hs_info->id]);
> +	char *rt_data = ((struct sk_buff *)hs_info->rt_data)->data;
> +	enum runtime_feature_support_type cur_ft_spt;
> +	struct runtime_feature_entry *rtft_entry;
> +	unsigned int ft_id, offset, data_len;
> +	int ret = 0;
> +
> +	offset = sizeof(struct feature_query);
> +	for (ft_id = 0; ft_id < FEATURE_CNT; ft_id++) {
> +		if (offset + sizeof(*rtft_entry) > hs_info->rt_data_len)
> +			break;
> +
> +		rtft_entry = (struct runtime_feature_entry *)(rt_data + offset);
> +		ret = mtk_fsm_feature_set_match(&cur_ft_spt,
> +						rtft_entry->support_info,
> +						hs_info->query_ft_set[ft_id]);

[Severity: Low]
Should this loop key off rtft_entry->feature_id instead of the loop index?

The wire structure carries an explicit id:

	struct runtime_feature_entry {
		u8 feature_id;
		struct runtime_feature_info support_info;

and the host's own emitter fills it in mtk_fsm_append_rtft_entries():

	rtft_entry->feature_id = ft_id;

Here the received entry's feature_id is never read, so the parser assumes
the device returns exactly FEATURE_CNT entries in dense ascending order.
If entries are omitted or reordered, one feature's payload is handed to
another feature's handler, or mtk_fsm_feature_set_match() returns -EPROTO
for a feature the device did answer.

> +		if (ret < 0)
> +			break;
> +
> +		data_len = le32_to_cpu(rtft_entry->data_len);
> +		if (data_len > hs_info->rt_data_len - offset - sizeof(*rtft_entry))
> +			break;
> +
> +		if (cur_ft_spt == RTFT_TYPE_MUST_SUPPORT)
> +			if (query_rtft_action[ft_id])
> +				ret = query_rtft_action[ft_id](fsm->mdev,
> +							       rtft_entry->data,
> +							       data_len);

[Severity: Medium]
Is a minimum length check missing here?  Only an upper bound on data_len
is applied, so data_len == 0 is accepted and passed to
mtk_port_status_update(), which dereferences the 12-byte
struct mtk_port_enum_msg header before validating the length:

drivers/net/wwan/t9xx/mtk_port.c:mtk_port_status_update() {
	if (le16_to_cpu(msg->version) != MTK_PORT_ENUM_VER ||
	    le32_to_cpu(msg->head_pattern) != MTK_PORT_ENUM_HEAD_PATTERN ||
	    le32_to_cpu(msg->tail_pattern) != MTK_PORT_ENUM_TAIL_PATTERN)
		return -EPROTO;

	if (data_len < sizeof(*msg) + ...
}

With data_len == 0 for QUERY_RTFT_ID_MD_PORT_ENUM or
QUERY_RTFT_ID_SAP_PORT_ENUM (both declared MUST-support by the host, so
cur_ft_spt == RTFT_TYPE_MUST_SUPPORT is reachable), rtft_entry->data
equals rt_data + rt_data_len and the read goes past the received message
into skb tailroom / skb_shared_info.  Can the handler be given a
guaranteed-minimum length instead?

> +		if (ret < 0)
> +			break;
> +
> +		offset += sizeof(*rtft_entry) + data_len;
> +	}

[ ... ]

> +static int mtk_fsm_sap_ctrl_msg_handler(void *__fsm, struct sk_buff *skb)
> +{

[ ... ]

> +	hs_info->rt_data = skb;
> +	hs_info->rt_data_len = skb->len;
> +	ret = mtk_fsm_evt_submit(fsm->mdev, FSM_EVT_STARTUP,
> +				 hs_info->fsm_flag_hs2, hs_info, sizeof(*hs_info), 0);
> +	if (ret == FSM_EVT_RET_FAIL) {
> +		dev_kfree_skb(skb);
> +		hs_info->rt_data = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_fsm_md_ctrl_msg_handler(void *__fsm, struct sk_buff *skb)
> +{

[ ... ]

> +	switch (le32_to_cpu(ctrl_msg_h->id)) {
> +	case CTRL_MSG_HS2:
> +		skb_pull(skb, sizeof(*ctrl_msg_h));
> +		hs_info->rt_data = skb;
> +		hs_info->rt_data_len = skb->len;
> +		ret = mtk_fsm_evt_submit(fsm->mdev, FSM_EVT_STARTUP,
> +					 hs_info->fsm_flag_hs2, hs_info, sizeof(*hs_info), 0);
> +		if (ret != FSM_EVT_RET_FAIL)
> +			consumed_skb = true;
> +		break;

[Severity: High]
Can two HS2 messages race on the single hs_info->rt_data slot?

The queued event carries only the hs_info pointer (event->data = hs_info),
never the skb, so no event owns its buffer.  The writer here runs in the
CLDMA rx_done work while the reader/freer runs in the FSM kthread, and
neither takes a lock or checks whether a buffer is already pending.

If the modem sends a second CTRL_MSG_HS2 while the FSM thread is still in
mtk_fsm_startup_act() for the first one:

rx work					FSM kthread
hs_info->rt_data = skb2			mtk_fsm_parse_hs2_msg()  /* skb1 */
submit event B
					dev_kfree_skb(hs_info->rt_data);
					hs_info->rt_data = NULL;

skb1 is leaked, skb2 is freed early, and event B then reaches:

	char *rt_data = ((struct sk_buff *)hs_info->rt_data)->data;

on a NULL pointer.  In the failure branches above, dev_kfree_skb(skb) can
also free a buffer the FSM thread is parsing right now, and a torn
rt_data / rt_data_len pair makes the parser bound the wrong buffer.
Should the skb be handed to the event itself rather than stored in the
shared hs_info?

> +	default:
> +		dev_err(fsm->mdev->dev, "Invalid ctrl msg id\n");
> +	}

[ ... ]

> +static void mtk_fsm_switch_state(struct mtk_md_fsm *fsm,
> +				 enum mtk_fsm_state to_state, struct mtk_fsm_evt *event)
> +{

[ ... ]

> +	list_for_each_entry(nt, &fsm->pre_notifiers, entry)
> +		nt->cb(&param, nt->data);
> +
> +	fsm->state = to_state;
> +	fsm->fsm_flag |= event ? event->fsm_flag : FSM_F_DFLT;

[ ... ]

> +	list_for_each_entry(nt, &fsm->post_notifiers, entry)
> +		nt->cb(&param, nt->data);
> +}

[Severity: High]
What protects these two list walks against concurrent unregistration?

The traversal runs in the FSM kthread with plain list_for_each_entry() and
calls nt->cb(), while mtk_fsm_notifier_register() /
mtk_fsm_notifier_unregister() do list_add()/list_add_tail()/list_del() and
kfree() from other threads.  There is no mutex, no _rcu list variant, no
synchronize_rcu() before the kfree, and no barrier.

The removal path is ordered against the FSM thread only by the blocking
FSM_EVT_DEV_RM event, whose result mtk_pci_dev_exit() ignores and which
can also time out.  When that happens:

mtk_trans_ctrl_exit() -> mtk_ctrl_exit()
  -> mtk_fsm_notifier_unregister(mdev, MTK_USER_CTRL)   /* list_del + kfree */
  -> mtk_port_mngr_exit(ctrl_blk)                       /* frees port_mngr */

while the FSM thread may still be iterating post_notifiers and about to
call nt->cb() on the freed notifier with the freed port_mngr as data.
Since both register and unregister are exported, any future runtime
register/unregister races with every state transition too.

> +static int mtk_fsm_startup_act(struct mtk_md_fsm *fsm, struct mtk_fsm_evt *event)
> +{

[ ... ]

> +	} else if (event->fsm_flag & FSM_HS2_DONE_MASK) {
> +		ret = mtk_fsm_parse_hs2_msg(hs_info);
> +		if (!ret) {
> +			mtk_fsm_switch_state(fsm, to_state, event);
> +			ret = mtk_fsm_send_hs3_msg(hs_info);
> +		}
> +		dev_kfree_skb(hs_info->rt_data);
> +		hs_info->rt_data = NULL;
> +		if (ret)
> +			goto hs_err;
> +	}
> +
> +	if (((fsm->fsm_flag | event->fsm_flag) & fsm->hs_done_flag) == fsm->hs_done_flag) {
> +		to_state = FSM_STATE_READY;
> +		mtk_fsm_switch_state(fsm, to_state, NULL);
> +	}

[Severity: Medium]
Can the FSM reach FSM_STATE_READY when HS3 was never delivered?

mtk_fsm_switch_state() is called before mtk_fsm_send_hs3_msg(), and it
permanently ORs the event flag in:

	fsm->fsm_flag |= event ? event->fsm_flag : FSM_F_DFLT;

If mtk_fsm_send_hs3_msg() then fails (-ENOMEM from
__dev_alloc_skb(RTFT_DATA_SIZE), -EPROTO from
mtk_fsm_append_rtft_entries(), or a failed mtk_port_internal_write()), the
hs_err exit does not clear the already-committed FSM_F_*_HS2_DONE bit.
In the dual-handshake configuration the other side can then complete, and
the hs_done_flag test above sees every HS_START/HS2_DONE bit set and moves
to FSM_STATE_READY.

[ ... ]

> +static int mtk_fsm_hs1_handler(u32 status, void *__hs_info)
> +{
> +	struct fsm_hs_info *hs_info = __hs_info;
> +	struct mtk_md_dev *mdev;
> +	struct mtk_md_fsm *fsm;
> +
> +	fsm = container_of(hs_info, struct mtk_md_fsm, hs_info[hs_info->id]);
> +	mdev = fsm->mdev;
> +	mtk_fsm_evt_submit(mdev, FSM_EVT_STARTUP,
> +			   hs_info->fsm_flag_hs1, hs_info, sizeof(*hs_info), 0);
> +	mtk_dev_mask_dev_evt(mdev, hs_info->mhccif_ch);
> +	mtk_dev_clear_dev_evt(mdev, hs_info->mhccif_ch);
> +
> +	return 0;
> +}

[Severity: Medium]
Is there a way back if the queued startup action later fails?

The HS1 notification is masked and cleared here, before the asynchronous
event result is known.  In mtk_fsm_startup_act():

	ret = mtk_fsm_ctrl_ch_start(fsm, hs_info, O_NONBLOCK);
	if (!ret)
		ret = mtk_fsm_send_hs1_msg(hs_info);
	if (ret)
		goto hs_err;

mtk_fsm_ctrl_ch_start() returns -ENODEV when the control port is not
enabled (which is what happens when mtk_cldma_dev_init() failed, since
mtk_cldma_fsm_state_listener() drops that error), and
mtk_fsm_send_hs1_msg() can return -ENOMEM or a write error.  The hs_err
path only logs; the channel stays masked and no retry is scheduled, so the
FSM stays in FSM_STATE_BOOTUP.  The only mtk_dev_unmask_dev_evt() calls
for hs_info->mhccif_ch are in mtk_fsm_idle_evt_handler(), which is not
re-entered because the boot-flow-sync channel is masked as well.

[ ... ]

> +static void mtk_fsm_notifier_insert(struct mtk_fsm_notifier *notifier, struct list_head *head)
> +{
> +	struct mtk_fsm_notifier *nt;
> +
> +	list_for_each_entry(nt, head, entry) {
> +		if (notifier->prio > nt->prio) {
> +			list_add(&notifier->entry, nt->entry.prev);
> +			return;
> +		}
> +	}
> +	list_add_tail(&notifier->entry, head);
> +}

[ ... ]

> +	spin_lock_irqsave(&fsm->evtq_lock, flags);
> +	if (test_bit(EVT_TF_GATECLOSED, &fsm->t_flag)) {
> +		spin_unlock_irqrestore(&fsm->evtq_lock, flags);
> +		mtk_fsm_evt_put(event);
> +		dev_err(mdev->dev, "Failed to add event, fsm dev has been removed!\n");
> +		return FSM_EVT_RET_FAIL;
> +	}
> +
> +	kref_get(&event->kref);
> +	if (mode & EVT_MODE_TOHEAD)
> +		list_add(&event->entry, &fsm->evtq);
> +	else
> +		list_add_tail(&event->entry, &fsm->evtq);
> +	wake_up_process(fsm->fsm_handler);
> +	spin_unlock_irqrestore(&fsm->evtq_lock, flags);

[Severity: High]
Can fsm->fsm_handler be NULL at this wake_up_process()?

mtk_fsm_exit() clears it under the same lock:

	spin_lock_irqsave(&fsm->evtq_lock, flags);
	handler = fsm->fsm_handler;
	fsm->fsm_handler = NULL;
	spin_unlock_irqrestore(&fsm->evtq_lock, flags);

	if (handler)
		kthread_stop(handler);

and only unregisters mtk_fsm_early_bootup_handler() /
mtk_fsm_hs1_handler() at the very end, after a kthread_stop() that can
block while the FSM thread finishes an event.  The only thing stopping a
submit in that window is EVT_TF_GATECLOSED, which is set exclusively in
mtk_fsm_dev_rm_act(), i.e. only if a FSM_EVT_DEV_RM was queued and
processed.  On the probe error path (mtk_pci_dev_init() -> goto free_fsm
-> mtk_fsm_exit()) no DEV_RM is ever submitted, so the gate is open, and
on removal mtk_pci_dev_exit() ignores the DEV_RM result.

Any device event arriving then (mtk_mhccif_isr_work() ->
mtk_fsm_early_bootup_handler() -> mtk_fsm_idle_evt_handler() ->
mtk_fsm_evt_submit(), or mtk_fsm_hs1_handler()) passes a NULL task_struct
into try_to_wake_up().  mtk_fsm_start() already has the check this path is
missing:

	if (!fsm->fsm_handler)
		return -EFAULT;

mtk_fsm_exit() also never clears mdev->fsm, so the torn-down (devm-freed)
fsm stays reachable from those callbacks.

[ ... ]

> +int mtk_fsm_init(struct mtk_md_dev *mdev)
> +{

[ ... ]

> +	mtk_fsm_hs_info_init(fsm);
> +	mtk_dev_register_dev_evt(mdev, DEV_EVT_D2H_BOOT_FLOW_SYNC,
> +				 mtk_fsm_early_bootup_handler, fsm);
> +	mdev->fsm = fsm;
> +	return 0;
> +exit:
> +	return ret;
> +}

[Severity: Medium]
Should these registrations be checked?  mtk_dev_register_dev_evt() reaches
mtk_pci_register_ext_evt(), which returns -EINVAL for bad arguments,
-EFAULT when the channel bitmask intersects an existing registration, and
-ENOMEM from:

	cb = kzalloc(sizeof(*cb), GFP_ATOMIC);
	if (!cb) {
		ret = -ENOMEM;
		goto err_spin_unlock;
	}

Here the return value is dropped, and the two per-handshake-channel
registrations inside the void mtk_fsm_hs_info_init() cannot report failure
at all.  If the BOOT_FLOW_SYNC registration fails,
mtk_fsm_early_bootup_handler() never runs, so
mtk_fsm_idle_evt_handler() never sets fsm->hs_done_flag and never submits
the STARTUP event: probe succeeds, the FSM never leaves FSM_STATE_ON, no
CLDMA is initialized, no port is created, and nothing is logged.

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> index 097b20d8fbd38..1431c2797eb5d 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> @@ -34,12 +34,172 @@

[ ... ]

> +static int mtk_cldma_isr(int irq_id, void *param)
> +{
> +	struct cldma_drv_info *drv_info = param;
> +	struct mtk_md_dev *mdev;
> +	u32 tx_done, rx_done;
> +	u32 tx_sta, rx_sta;
> +	struct txq *txq;
> +	struct rxq *rxq;
> +	int i;
> +
> +	mdev = drv_info->mdev;
> +	drv_info->drv_ops->cldma_get_intr_status(drv_info, &tx_sta, &rx_sta);
> +	tx_done = (tx_sta >> QUEUE_XFER_DONE) & 0xFF;
> +	rx_done = (rx_sta >> QUEUE_XFER_DONE) & 0xFF;

[Severity: Medium]
What happens to the QUEUE_ERROR bits that get masked but never handled?

mtk_cldma_get_intr_status() masks every asserted bit but clears only the
XFER_DONE byte:

drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.c:mtk_cldma_get_intr_status() {
	if (*tx_sta) {
		/* TX XFER_DONE and QUEUE_ERROR mask */
		mtk_pci_write32(mdev, base + hw_regs->reg_cldma_l2timsr0, *tx_sta);
		/* TX XFER_DONE clear */
		mtk_pci_write32(mdev, base + hw_regs->reg_cldma_l2tisar0,
				(*tx_sta) & (0xFF << QUEUE_XFER_DONE));
	}
}

The two shifts above then drop QUEUE_ERROR and QUEUE_ACTIVE_START
entirely.  QUEUE_ERROR is unmasked only once, in mtk_cldma_txq_alloc() /
mtk_cldma_rxq_alloc(); the done workers re-unmask only QUEUE_XFER_DONE.
So the first queue error permanently disarms error reporting, leaves the
bit latched in L2TISAR0/L2RISAR0, and leaves the halted queue with no log,
no queue reset and no GPD/HWO recovery.

> +
> +	if (tx_done) {
> +		for (i = 0; i < HW_QUEUE_NUM; i++) {
> +			txq = drv_info->txq[i];
> +			if (!(tx_done & BIT(i)) || !txq)
> +				continue;
> +			queue_work(drv_info->wq, &txq->tx_done_work);
> +		}
> +	}

[ ... ]

> +	mtk_pci_clear_irq(mdev, drv_info->pci_ext_irq_id);
> +	mtk_pci_unmask_irq(mdev, drv_info->pci_ext_irq_id);
> +
> +	return IRQ_HANDLED;
> +}

[ ... ]

> @@ -885,6 +1046,44 @@ static void mtk_cldma_rxq_free(struct cldma_drv_info *drv_info, u32 rxqno)
> +static int mtk_cldma_dev_exit(struct cldma_dev *cd, int hif_id)
> +{

[ ... ]

> +	virq_id = mtk_pci_get_virq_id(mdev, drv_info->pci_ext_irq_id);
> +	mtk_pci_mask_irq(mdev, drv_info->pci_ext_irq_id);
> +	synchronize_irq(virq_id);
> +	for (i = 0; i < HW_QUEUE_NUM; i++) {
> +		if (drv_info->txq[i])
> +			mtk_cldma_txq_free(drv_info, drv_info->txq[i]->txqno);
> +		if (drv_info->rxq[i])
> +			mtk_cldma_rxq_free(drv_info, drv_info->rxq[i]->rxqno);
> +	}
> +
> +	flush_workqueue(drv_info->wq);
> +	destroy_workqueue(drv_info->wq);
> +	dma_pool_destroy(drv_info->bd_dma_pool);
> +	dma_pool_destroy(drv_info->gpd_dma_pool);
> +	mtk_pci_unregister_irq(mdev, drv_info->pci_ext_irq_id);
> +
> +	kfree(drv_info);
> +	cd->cldma_drv_info[hif_id] = NULL;
> +
> +	return 0;
> +}

[Severity: High]
Is the initial mask plus synchronize_irq() enough to keep the ISR away
from the freed drv_info?

mtk_cldma_isr() re-arms its own vector on every exit:

	mtk_pci_clear_irq(mdev, drv_info->pci_ext_irq_id);
	mtk_pci_unmask_irq(mdev, drv_info->pci_ext_irq_id);

so an ISR that was already running when the vector was masked unmasks it
again before returning, and synchronize_irq() only waits for that ISR to
finish.  QUEUE_ERROR stays armed in hardware, so a later interrupt can
call mtk_cldma_isr() after the workqueue is destroyed (queue_work() on
freed workqueue memory) or after kfree(drv_info)
(drv_info->drv_ops->cldma_get_intr_status(), drv_info->txq[]).

mtk_pci_unregister_irq() only clears the callback pointer:

	priv->irq_cb_list[irq_id] = NULL;
	priv->irq_cb_data[irq_id] = NULL;

and is not followed by a synchronize_irq(), while mtk_pci_irq_handler()
invokes priv->irq_cb_list[irq_id] directly from hardirq with no lock or
RCU.  Should the callback be unregistered and synchronized before the
workqueue, pools and drv_info are released?

[ ... ]

> @@ -1195,6 +1394,27 @@ int mtk_cldma_trb_process(void *dev, struct sk_buff *skb)
> +void mtk_cldma_fsm_state_listener(struct mtk_fsm_param *param, struct mtk_ctrl_trans *trans)
> +{
> +	struct cldma_dev *cd = trans->dev;
> +	int i;
> +
> +	switch (param->to) {
> +	case FSM_STATE_BOOTUP:
> +		if (param->fsm_flag & FSM_F_SAP_HS_START)
> +			mtk_cldma_dev_init(cd, CLDMA0);
> +		else if (param->fsm_flag & FSM_F_MD_HS_START)
> +			mtk_cldma_dev_init(cd, CLDMA1);
> +		break;
> +	case FSM_STATE_OFF:
> +		for (i = 0; i < NR_CLDMA; i++)
> +			mtk_cldma_dev_exit(cd, i);
> +		break;

[Severity: High]
Are the TRB service threads guaranteed to be stopped before this runs?

In mtk_ctrl_trans_fsm_state_handler(), the FSM_STATE_OFF arm calls
fsm_indication() (which lands here and tears down every CLDMA hif)
before ops->exit(), and it is ops->exit() -> mtk_pcie_hif_exit() that
clears trans->available and stops the TRB kthreads.  Meanwhile
mtk_cldma_submit_tx() reads the published pointers locklessly:

	drv_info = cd->cldma_drv_info[que->hif_id];
	if (unlikely(!drv_info))
		return -EINVAL;

	txq = drv_info->txq[que->txqno];

and mtk_cldma_dev_exit() does kfree(drv_info) before clearing
cd->cldma_drv_info[hif_id], so the pointer is dangling across the free.
One way to have work still in flight: mtk_port_ch_disable()'s
wait_event_timeout() can expire, leaving the DISABLE TRB queued for the
service thread to pick up later.

> +	default:
> +		break;
> +	}
> +}

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> index dbc17da590bc0..bf4e110b485c8 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> @@ -883,22 +883,34 @@ static int mtk_pci_dev_init(struct mtk_md_dev *mdev)

[ ... ]

>  static void mtk_pci_dev_exit(struct mtk_md_dev *mdev)
>  {
> +	mtk_fsm_evt_submit(mdev, FSM_EVT_DEV_RM, 0, NULL, 0,
> +			   EVT_MODE_BLOCKING | EVT_MODE_TOHEAD);
>  	mtk_trans_ctrl_exit(mdev);
> +	mtk_fsm_exit(mdev);
>  }

[Severity: High]
What happens here when the blocking removal event does not complete?

mtk_fsm_evt_submit() returns FSM_EVT_RET_FAIL if its kzalloc() fails, and
the result is discarded.  In that case the FSM_STATE_OFF notifier chain
never runs, so ctrl_blk->ops->exit() = mtk_pcie_hif_exit() is never
called: the CLDMA IRQ callback stays registered, the CLDMA workqueue and
DMA pools stay alive, the TRB service kthreads keep running and
trans->available stays 1.  mtk_trans_ctrl_exit() does not compensate:

drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c:mtk_trans_ctrl_exit() {
	mtk_ctrl_exit(mdev);

	return 0;
}

and the devm-allocated trans/ctrl_blk/fsm are released once remove()
finishes, leaving those kthreads and the IRQ callback pointing at freed
memory.  The wait can also expire (BLOCKING_EVT_TIMEOUT is 60s) without
dequeuing or cancelling the event:

	ret = wait_event_timeout(fsm->evt_waitq,
				 (event->status != 0), BLOCKING_EVT_TIMEOUT);

so teardown then races with an FSM thread still using ctrl_blk/trans.

>  static int mtk_pci_dev_start(struct mtk_md_dev *mdev)
>  {
> +	mtk_fsm_evt_submit(mdev, FSM_EVT_DEV_ADD, 0, NULL, 0, 0);
> +	mtk_fsm_start(mdev);
>  	return 0;
>  }

[Severity: Medium]
Should these two return values be propagated?  mtk_pci_dev_start() is
declared int and mtk_pci_probe() already has an if (ret) handler for it,
but both calls are discarded and 0 is returned unconditionally.

mtk_fsm_evt_submit() returns FSM_EVT_RET_FAIL when its
kzalloc(sizeof(*event), ...) fails, so probe can succeed while the FSM
never leaves FSM_STATE_INVALID.  Every later handshake event is then
rejected by mtk_fsm_startup_act():

	if (fsm->state != FSM_STATE_ON && fsm->state != FSM_STATE_BOOTUP) {
		ret = -EPROTO;
		goto free_rt_data;
	}

leaving the device unusable with only a generic error log.

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
> index a3ff56ddf86fc..4b9c9db6ad715 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
> @@ -29,7 +29,6 @@
>  enum mtk_hif_id {
>  	CLDMA0,
>  	CLDMA1,
> -	CLDMA4,
>  	NR_CLDMA
>  };
