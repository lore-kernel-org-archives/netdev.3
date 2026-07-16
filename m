Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02D3F823E;
	Thu, 16 Jul 2026 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194474; cv=none; b=OP5Qf6rD6hOVuPZKhvOzQUbUF6y9Y87gg1zGphcKgl0aNqGZIEgdzARuphSF4q39bkhVDVAoOAhgsiKA09qWiGgnlZVJ0cpuw5MFDDbSUarEmCBYhQydoTs1XKNCNny8vIhubc8YT0bKtDOCSWCeNTMde6FViv6GE0ROTyG540g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194474; c=relaxed/simple;
	bh=kCwuM3rAaySCNKkLr0V4uuSCp+pvs+fIA4+hqLGFZwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgPQsJstY+5VetwVcxkRpOeYFiO3ofaG2O5kVzteOi96X8AxDn8Xi3bvVnjT9q3G5vvwF0b4MKuyLUlI3Qm7Z21+zF/5GdLCt+KPhBIPfBtTEDbMWEGcx6VvRdYvcftbFBx83UJgcj0awcKAXySRjimJcbbwN6ZsORmhnONma6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpXG433r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpXG433r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75EE1F000E9;
	Thu, 16 Jul 2026 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784194468;
	bh=XXSHjxq91CcW9IwWl8dloQaOhno2LuxnJvN3+jcprls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fpXG433rnfcNLScmNL5cL5X0tDpp8zpZ5AT7eSd8b8HbYjOozeIcvr1h7DjT7sBEf
	 N0KvuXyDt/BRO/7SGuWnghULGcpGti8vqQNw3lCnW+0bh6oaCPJ1bdwzw4Wa55vQtm
	 2azFIzVR/mQMgRxEKeM1lz3hkydhTSMykI3Wf4u6l9MRlmVN05cT7k32cic6JM7PZL
	 eRE0HC/RQGrUBVaCwazKoTeJprDfEHR1jHrHukEm8QJ5A3ZiNVKsNsQshGUFzdUTdW
	 dTwh6br5TQd/Z/7ExLHMo/c3SEHBQ6UnK2S66gPkKIidb9RG7W0jeQ1sbKNYLrZ8jU
	 kJDXWO6xRKyMQ==
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
Subject: Re: [PATCH v4 5/7] net: wwan: t9xx: Add FSM thread
Date: Thu, 16 Jul 2026 10:34:22 +0100
Message-ID: <20260716093422.231112-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709-t9xx_driver_v1-v4-5-a8c009d509c5@compal.com>
References: <20260709-t9xx_driver_v1-v4-5-a8c009d509c5@compal.com>
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
--- Patch [5]: [PATCH v4 5/7] net: wwan: t9xx: Add FSM thread ---
commit 8cf81b126e77414e72ef40886e0728c165b2e588
Author: Jack Wu <jackbb_wu@compal.com>

net: wwan: t9xx: Add FSM thread

This commit introduces a finite-state machine (FSM) thread for the MTK WWAN
driver to synchronize module actions. It handles events sequentially from a
queue and notifies other modules before and after state transitions.

> diff --git a/drivers/net/wwan/t9xx/mtk_fsm.c b/drivers/net/wwan/t9xx/mtk_fsm.c
> new file mode 100644
> index 0000000000000..daefb7581ce0f
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_fsm.c
[ ... ]
> +static int mtk_fsm_parse_hs2_msg(struct fsm_hs_info *hs_info)
> +{
> +	struct mtk_md_fsm *fsm = container_of(hs_info, struct mtk_md_fsm, hs_info[hs_info->id]);
> +	char *rt_data = ((struct sk_buff *)hs_info->rt_data)->data;

[Severity: High]
Does this iterate over the SKB payload assuming the entire payload is linearly
accessible? Networking core guidelines usually require checking boundaries
using pskb_may_pull() before direct dereferencing, as packets might be
fragmented.

[ ... ]
> +		if (cur_ft_spt == RTFT_TYPE_MUST_SUPPORT)
> +			if (query_rtft_action[ft_id])
> +				ret = query_rtft_action[ft_id](fsm->mdev, rtft_entry->data);
> +		if (ret < 0)
> +			break;
> +
> +		data_len = le32_to_cpu(rtft_entry->data_len);
> +		if (data_len > hs_info->rt_data_len - offset - sizeof(*rtft_entry))
> +			break;

[Severity: High]
Is the rtft_entry->data passed to the action callback (like
mtk_port_status_update) before data_len is checked against the remaining
buffer bounds? This appears to allow an out-of-bounds heap read if a
crafted message has a large port_cnt and truncated payload.

[ ... ]
> +static int mtk_fsm_send_hs3_msg(struct fsm_hs_info *hs_info)
> +{
> +	struct mtk_md_fsm *fsm = container_of(hs_info, struct mtk_md_fsm, hs_info[hs_info->id]);
> +	unsigned int data_len, msg_size = 0;
> +	struct ctrl_msg_header *ctrl_msg_h;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	skb = __dev_alloc_skb(RTFT_DATA_SIZE, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;

[Severity: High]
Does this leak uninitialized kernel heap memory to the WWAN device?
__dev_alloc_skb() does not zero the buffer, and when the structure is
populated in mtk_fsm_append_rtft_entries(), the 2-byte reserved field
(and potentially support_info if the switch falls through) appear to be
left uninitialized.

[ ... ]
> +static int mtk_fsm_sap_ctrl_msg_handler(void *__fsm, struct sk_buff *skb)
> +{
> +	struct ctrl_msg_header *ctrl_msg_h;
> +	struct mtk_md_fsm *fsm = __fsm;
> +	struct fsm_hs_info *hs_info;
> +	int ret;
> +
> +	if (skb->len < sizeof(*ctrl_msg_h)) {
> +		dev_kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
> +	ctrl_msg_h = (struct ctrl_msg_header *)skb->data;
> +	skb_pull(skb, sizeof(*ctrl_msg_h));

[Severity: High]
Can skb_pull() trigger a BUG() here if the SKB is fragmented? It seems the
payload is directly accessed and pulled without calling pskb_may_pull()
to guarantee the required bytes are in the linear data region.

[ ... ]
> +	hs_info = &fsm->hs_info[HS_ID_SAP];
> +	if (le32_to_cpu(ctrl_msg_h->id) != CTRL_MSG_HS2) {
> +		dev_kfree_skb(skb);
> +		return -EPROTO;
> +	}
> +
> +	hs_info->rt_data = skb;
> +	hs_info->rt_data_len = skb->len;
> +	ret = mtk_fsm_evt_submit(fsm->mdev, FSM_EVT_STARTUP,
> +				 hs_info->fsm_flag_hs2, hs_info, sizeof(*hs_info), 0);
> +	if (ret == FSM_EVT_RET_FAIL)
> +		dev_kfree_skb(skb);

[Severity: High]
If mtk_fsm_evt_submit() fails, the SKB is freed, but hs_info->rt_data
is not set to NULL. Could this dangling pointer cause a double-free later in
the error path of mtk_fsm_startup_act()?

Also, hs_info->rt_data is assigned without locking here. If consecutive
messages arrive, could this overwrite the pointer and leak the previous SKB?
When the FSM thread eventually parses the first event, it sets the pointer to
NULL, which would cause subsequent queued events to dereference NULL in
mtk_fsm_parse_hs2_msg().

[ ... ]
> +static void mtk_fsm_evt_cleanup(struct mtk_md_fsm *fsm, struct list_head *evtq)
> +{
> +	struct mtk_fsm_evt *event, *tmp;
> +
> +	list_for_each_entry_safe(event, tmp, evtq, entry) {
> +		list_del(&event->entry);
> +		mtk_fsm_evt_finish(fsm, event, FSM_EVT_RET_FAIL);
> +	}
> +}

[Severity: Medium]
When flushing the event queue on device removal, does this cleanup miss
freeing the SKB currently stored in the shared fsm->hs_info[].rt_data if an
HS2 message was pending?

[ ... ]
> +int mtk_fsm_notifier_register(struct mtk_md_dev *mdev, enum mtk_user_id id,
> +			      void (*cb)(struct mtk_fsm_param *, void *data),
> +			      void *data, enum mtk_fsm_prio prio, bool is_pre)
> +{
[ ... ]
> +	if (is_pre)
> +		mtk_fsm_notifier_insert(notifier, &fsm->pre_notifiers);
> +	else
> +		mtk_fsm_notifier_insert(notifier, &fsm->post_notifiers);

[Severity: Medium]
Is it safe to modify these notifier lists globally without spinlock or mutex
protection? The FSM kthread traverses these lists in mtk_fsm_switch_state()
and could race with registration or unregistration.

[ ... ]
> +int mtk_fsm_evt_submit(struct mtk_md_dev *mdev,
> +		       enum mtk_fsm_evt_id id, enum mtk_fsm_flag flag,
> +		       void *data, unsigned int len, unsigned char mode)
> +{
[ ... ]
> +	spin_unlock_irqrestore(&fsm->evtq_lock, flags);
> +
> +	wake_up_process(fsm->fsm_handler);

[Severity: High]
Could a race condition occur here during teardown? If this thread is
preempted right after releasing the lock, mtk_fsm_exit() could execute,
stopping the kthread and setting fsm->fsm_handler = NULL. When this thread
resumes, calling wake_up_process(NULL) would trigger a kernel panic.

> diff --git a/drivers/net/wwan/t9xx/mtk_port.c b/drivers/net/wwan/t9xx/mtk_port.c
> --- a/drivers/net/wwan/t9xx/mtk_port.c
> +++ b/drivers/net/wwan/t9xx/mtk_port.c
[ ... ]
>  int mtk_port_ch_disable(struct mtk_port *port)
>  {
[ ... ]
>  start_wait:
>  	ret = wait_event_interruptible_timeout(port->trb_wq, trb->status <= 0,
>  					       MTK_DFLT_TRB_TIMEOUT);
>  	if (ret == -ERESTARTSYS)
>  		goto start_wait;

[Severity: High]
If a signal is pending (e.g., SIGKILL), wait_event_interruptible_timeout()
immediately returns -ERESTARTSYS. Won't this retry loop cause an infinite
busy loop (100% CPU lockup) because the signal remains pending without
sleeping?

[ ... ]
> +static void mtk_port_disable(struct mtk_port_mngr *port_mngr)
> +{
> +	struct mtk_port **ports;
> +	int tbl_type;
> +	int ret, idx;
> +
> +	ports = kcalloc(port_mngr->port_cnt, sizeof(struct mtk_port *), GFP_KERNEL);
> +	if (!ports)
> +		return;

[Severity: High]
If kcalloc() fails under memory pressure, this aborts the disable sequence
silently. Would this leave hardware channels active during device teardown
and cause use-after-free crashes? It might be safer to iterate via
radix_tree_for_each_slot() without dynamic allocation.
