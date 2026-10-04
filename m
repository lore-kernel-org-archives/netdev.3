Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC0418360;
	Sun,  4 Oct 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105161; cv=none; b=ZbHKq1d1PaFWQeYXy9w8cNnpZLkm8RN4gfzVdSfjiy6m3qmthsN1dJaWL4XIHPF+Bbx8v5B7JWYoy+kXJSm4q7X2bMCJuWxsTryrHNvNcRMV8X3wnr++QhTl8NN4LIFMhl4ZcRNZ9s0Tyr1tDgqEDTYXSWNuz7avlJ9Lr9Kth+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105161; c=relaxed/simple;
	bh=BeBghOodyGOIqnuBJtkmT75EfHHWe23pF5TXXOtJnEk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uA9tIzKA/PLD/EmzI39voJGnZ9F6Cwduy4JKrQfF9e8WdUei4YoDDBY8zTqFoeAtBbIvaL42Is+AHw3JkIQiQ1hm/pqupDa6oYtTY4Alf/5SmG8/SgXdcUOB5my9xJFm1sNWtLTORMUjUlle6IyTwYgRfZlFXVvjdAvc0Gcfznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR2wluDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR2wluDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB351F000FF;
	Sun,  4 Oct 2026 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791105158;
	bh=l6YKx75v1UHh5u3ecRBAiuJ8eUyaZ/IdvdwFVRz+vjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XR2wluDlOV9aGrmgD/K6q5O0gyOup2aG8H7yG5onXaPbwFmkuHG1SNKA/9jVPFAHx
	 C68GsnRZNqn28vSX5NrWqvl73jvSb1jT/E2I01Fv2sZwiXHdk+K9+6NBLc7RI9yEzO
	 XxGIEJEbIdX3KFLWpq9cGFPIw5I3thHgRzTRjeFVf8+u8qBNxf3JIKuxae2qNNQM6k
	 R58Xc+rp6czR3ZGwZ/elR/HeTVVjKrd1IKovpN92mQQ4ht6aWB0z5iDMXkOny6RRUl
	 /wULa+c37Z/EovZyo/XDmkdvtofLxv0ud2YCDKsCWs+CHjfqqL9EhWBOK+Mu0DHhE+
	 Z+zUgs/WMNMHg==
Subject: Re: [PATCH v9 4/6] net: wwan: t9xx: Add control port
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
Date: Sun, 04 Oct 2026 09:12:36 +0000
Message-ID: <179110515680.434549.14127316399726574616@kernel.org>
In-Reply-To: <20260930-t9xx_driver_v1-v9-4-3248b9256956@compal.com>
References: <20260930-t9xx_driver_v1-v9-4-3248b9256956@compal.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 20 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 17

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: core: skb_push() called without verifying headroom causes
  kernel panic
- [High] net: rcu: lockless radix tree lookup causes UAF in port search
- [Medium] mtk_port_ch_enable() treats `trb->status <= 0` as meaning the
  ENABLE completion has finished.
- [Low] The commit message leaves out two changes to existing code.
- [Low] Concern: at this commit nothing calls ->enable(),
  mtk_port_internal_open/write/recv_register or mtk_port_status_update,…
- [Low] The patch adds non-static globals with no driver prefix:
  `DEFINE_MUTEX(port_mngr_grp_mtx)` in mtk_port.c and `const struct…
- [Low] Two small quality problems.
- [Low] Concern: mtk_cldma_rx_done_work() retries rx_done() with the same
  skb when it returns -EAGAIN.
- [Low] The port layer handles an ENABLE that completes with -EBUSY
  inconsistently.
- [Low] Concern: the comment in mtk_port_internal_disable() refers to
  FSM_STATE_ON and to usr_cnt being rebuilt there, but neither exists at…
- [Low] mtk_port_send_data() can return the in-flight sentinel
  MTK_TRB_HEADER_ADDED (0xADDED = 712173) as if it were a byte count.
- [Low] Concern: rx_seq and tx_seq are initialised only once, in
  mtk_port_struct_init(), so the first packet after a modem reset or…
- [Low] Concern: mtk_port_status_update() reads the 12-byte enumeration
  header before checking data_len >= sizeof(*msg).
- [Low] Concern: in the scatter-gather RX path, -EIO means both 'partial
  dispatch' and a raw head-skb recv() failure.
- [Low] Concern: TRBs hold `trb->priv = port` without a port reference.
- [Low] Concern: mtk_port_internal_open() looks up the port by name
  without holding a lock, and only then takes kref_get() under…
- [Low] Concern: mtk_port_common_open()/mtk_port_internal_close() do a
  non-atomic test_bit+set_bit/clear_bit on PORT_S_OPEN, so concurrent…
- [Low] Concern: recv_cb/arg are published with plain stores and read
  without ordering, and close does not synchronise with in-flight…
- [Low] Concern: port->tx_seq++ and tx_seq-- are not protected, so
  concurrent writers could duplicate or reorder sequence numbers.
- [Low] Concern: the port layer's SG predicate (rx_mtu - 128 >
  rx_frag_size) differs from CLDMA's BD-mode predicate (rx_mtu >…

--

net: wwan: t9xx: Add control port

This commit adds a port manager and a port I/O layer to the t9xx WWAN
driver. Two internal control ports (MDCTRL, SAPCTRL) submit TRBs to CLDMA
and receive dispatched data. The port manager is hooked into
mtk_ctrl_init()/mtk_ctrl_exit(), and module_pci_driver() is replaced with
explicit module init/exit functions.

> diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> index fa2ab8c3e7577..10f0d3267b3b1 100644
> --- a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> +++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c

[ ... ]

> @@ -28,7 +31,15 @@ int mtk_ctrl_init(struct mtk_md_dev *mdev)
>  	ctrl_blk->mdev = mdev;
>  	mdev->ctrl_blk = ctrl_blk;
>  
> +	err = mtk_port_mngr_init(ctrl_blk, port_layer_cfg->port_cfg,
> +				 port_layer_cfg->port_cnt);
> +	if (err)
> +		goto err_free_mem;
> +
>  	return 0;
> +
> +err_free_mem:
> +	return err;
>  }

[Severity: Low]
This isn't a bug, but the err_free_mem label frees nothing, because
ctrl_blk comes from devm_kzalloc(). Also, mdev->ctrl_blk still points at
ctrl_blk after the failure. Could this just return err, or clear
mdev->ctrl_blk and use a label name that matches what it does?

Similarly, mtk_trans_ctrl.c casts away const:

	.port_cfg = (struct mtk_port_cfg *)mtk_port_cfg_tbl,

mtk_port_mngr_init() and mtk_port_tbl_create() only read the table (via
memcpy() in mtk_port_alloc_and_add()). Could they take a
const struct mtk_port_cfg * so the cast isn't needed?

> diff --git a/drivers/net/wwan/t9xx/mtk_port.c b/drivers/net/wwan/t9xx/mtk_port.c
> new file mode 100644
> index 0000000000000..a8ff06ab4de4e
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_port.c
> @@ -0,0 +1,693 @@

[ ... ]

> +/* mutex lock for the port refcount */
> +DEFINE_MUTEX(port_mngr_grp_mtx);

[Severity: Low]
This isn't a bug, but port_mngr_grp_mtx, ports_ops[] (in mtk_port_io.c)
and struct port_ops are all global and have no driver prefix. With
CONFIG_MTK_T9XX=y they become kernel-wide symbols. The single mutex is
also shared by every device instance.

Could they get an mtk_ prefix, or be made static where possible?

[ ... ]

> +start_wait:
> +
> +	/* wait trb done, and no timeout in tx blocking mode */
> +	ret = wait_event_interruptible_timeout(port->trb_wq,
> +					       trb->status <= 0 ||
> +					       test_bit(PORT_S_FLUSH, &port->status) ||
> +					       !test_bit(PORT_S_WR, &port->status),
> +					       MTK_DFLT_TRB_TIMEOUT);
> +	if (!ret) {
> +		goto start_wait;
> +	} else if (ret == -ERESTARTSYS) {
> +		ret = -EINTR;
> +	} else if (ret > 0) {
> +		if (test_bit(PORT_S_FLUSH, &port->status))
> +			ret = len;
> +		else
> +			ret = (!trb->status) ? len : trb->status;

[Severity: Low]
Can this return MTK_TRB_HEADER_ADDED as a byte count?

mtk_port_add_header() sets trb->status = MTK_TRB_HEADER_ADDED (0xADDED)
before the skb is submitted. The wait also ends when PORT_S_WR is
cleared, and mtk_port_internal_disable() clears it before the DISABLE
TRB is even queued:

	clear_bit(PORT_S_WR, &port->status);
	wake_up_all(&port->trb_wq);

In that case PORT_S_FLUSH is clear and the TX TRB has not completed yet.
The code then returns trb->status, 712173, as if that many bytes had
been written.

mtk_ctrl_ch_flush() later completes the TX TRB with -EIO. The data is
dropped, but the blocking write has already reported success.

Later in the series this can happen for a blocking WWAN write during
mtk_port_wwan_disable(). Should the !PORT_S_WR case return an error
instead?

[ ... ]

> +int mtk_port_ch_enable(struct mtk_port *port)
> +{

[ ... ]

> +	ret = wait_event_timeout(port->trb_wq, trb->status <= 0,
> +				 MTK_DFLT_TRB_TIMEOUT);
> +	if (!ret)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = trb->status;

[Severity: Medium]
Can mtk_port_ch_enable() return 0 before mtk_port_open_trb_complete()
has filled in the port geometry?

The transport stores the status before it calls the completion callback.
For example, in mtk_cldma_open():

	trb->status = ret;
	trb->trb_complete(skb);

The MTU and fragment sizes are only written inside the callback:

	if (!trb->status) {
		port->tx_mtu = trb_open_priv->tx_mtu;
		...

wait_event_timeout() checks trb->status <= 0 before it sleeps. A waiter
that checks between those two points, or while the trb_srv thread is
preempted inside the callback, returns 0 with port->tx_mtu still 0.
There is also no acquire/release pairing, so on weakly ordered CPUs the
MTU stores may not be visible yet.

Later in the series, mtk_port_wwan_enable() checks port->tx_mtu right
after this returns:

	if (!port->tx_mtu) {
		dev_err(port_mngr->ctrl_blk->mdev->dev,
			"Invalid tx_mtu for port(%s)\n", port->info.name);

It then disables the channel, so the AT or MBIM port would not be
created for the rest of that device's lifetime.

Would it be better to signal completion from
mtk_port_open_trb_complete() after its last store? A struct completion,
or a separate done flag using smp_store_release()/smp_load_acquire(),
would do that.

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
> new file mode 100644
> index 0000000000000..6cff0704b7fc8
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_port_io.c
> @@ -0,0 +1,258 @@

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

[ ... ]

> +	set_bit(PORT_S_WR, &port->status);
> +	set_bit(PORT_S_ENABLE, &port->status);
> +}

[Severity: Low]
If the ENABLE TRB completes with -EBUSY, does the port end up enabled
with zero MTU and fragment sizes?

Two paths fill trb_open_priv->tx_mtu, rx_mtu, tx_frag_size and
rx_frag_size and then complete with -EBUSY:

  - mtk_ch_status_check(), when usr_cnt is already non-zero
  - mtk_cldma_open(), when the txq/rxq already exist

mtk_port_open_trb_complete() copies those values only when the status
is 0:

	if (!trb->status) {
		port->tx_mtu = trb_open_priv->tx_mtu;

This function treats -EBUSY as success, so it sets PORT_S_WR and
PORT_S_ENABLE. If this port never had a successful ENABLE, tx_mtu,
rx_mtu and the frag sizes stay 0.

The mtk_cldma_open() -EBUSY path also rolls back usr_cnt:

	if (ret)
		cd->trans->usr_cnt[que->hif_id][que->txqno]--;

The port still believes it owns the channel, so its later DISABLE would
also complete with -EBUSY.

Should the geometry also be copied on -EBUSY, or should -EBUSY not
count as a successful enable?

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> index 6c31a5d80693d..84b7fb3c82fd0 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c

[ ... ]

> @@ -1069,7 +1071,28 @@ static struct pci_driver mtk_pci_drv = {
>  	.err_handler = &mtk_pci_err_handler
>  };
>  
> -module_pci_driver(mtk_pci_drv);
> +static int __init mtk_drv_init(void)
> +{
> +	int ret;
> +
> +	ret = mtk_port_io_init();
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_register_driver(&mtk_pci_drv);
> +	if (ret)
> +		mtk_port_io_exit();
> +
> +	return ret;
> +}
> +module_init(mtk_drv_init);

[Severity: Low]
The commit message leaves out two changes to existing code.

First, mtk_drv_init()/mtk_drv_exit() replace module_pci_driver() only to
call mtk_port_io_init() and mtk_port_io_exit(), and both are empty:

	int mtk_port_io_init(void)
	{
		return 0;
	}

They are still empty at the end of the series. Could module_pci_driver()
stay and the stubs be dropped?

Second, mtk_ctrl_trb_handler() in mtk_trans_ctrl.c now takes and drops a
reference around every TRB, including on the -EAGAIN early return:

	kref_get(&trb->kref);
	...
	kref_put(&trb->kref, mtk_port_trb_free);

This makes the transport layer depend on the port layer's release
function. Could the commit message describe this change to TRB
ownership?

[ ... ]

> @@ -0,0 +1,693 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, MediaTek Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
> +#include "mtk_port.h"
> +#include "mtk_port_io.h"
> +#include "mtk_trans_ctrl.h"
> +
> +#define MTK_DFLT_TRB_TIMEOUT		(5 * HZ)
> +#define MTK_DFLT_TRB_STATUS		(0x1)
> +#define MTK_TRB_HEADER_ADDED		(0xADDED)
> +#define MTK_CHECK_RX_SEQ_MASK		(0x7fff)
> +
> +#define MTK_PORT_ENUM_VER		(0)
> +#define MTK_PORT_ENUM_HEAD_PATTERN	(0x5a5a5a5a)
> +#define MTK_PORT_ENUM_TAIL_PATTERN	(0xa5a5a5a5)
> +
> +#define MTK_PORT_SEARCH_FROM_RADIX_TREE(p, s) ({\
> +	struct mtk_port *_p;			\
> +	_p = rcu_dereference_raw(*(s));		\
> +	if (!_p)				\
> +		continue;			\
> +	p = _p;					\
> +})
> +
> +#define MTK_PORT_INTERNAL_NODE_CHECK(p, s, i) ({\
> +	if (radix_tree_is_internal_node(p)) {	\
> +		s = radix_tree_iter_retry(&(i));\
> +		continue;			\
> +	}					\
> +})
> +
> +struct mtk_port_info {
> +	__le16 channel;
> +	__le16 reserved;
> +} __packed;
> +
> +struct mtk_port_enum_msg {
> +	__le32 head_pattern;
> +	__le16 port_cnt;
> +	__le16 version;
> +	__le32 tail_pattern;
> +	u8 data[];
> +} __packed;
> +
> +/* mutex lock for the port refcount */
> +DEFINE_MUTEX(port_mngr_grp_mtx);
> +
> +/* This function working always under mutex lock port_mngr_grp_mtx */
> +void mtk_port_release(struct kref *port_kref)
> +{
> +	struct mtk_port *port;
> +
> +	port = container_of(port_kref, struct mtk_port, kref);
> +	ports_ops[port->info.type]->exit(port);
> +	kfree_rcu(port, rcu);
> +}
> +
> +static int mtk_port_tbl_add(struct mtk_port_mngr *port_mngr, struct mtk_port *port)
> +{
> +	int ret;
> +
> +	mutex_lock(&port_mngr->port_tbl_mtx);
> +	ret = radix_tree_insert(&port_mngr->port_tbl[MTK_PORT_TBL_TYPE(port->info.rx_ch)],
> +				port->info.rx_ch & 0xFFF, port);
> +	if (!ret)
> +		port_mngr->port_cnt++;
> +	mutex_unlock(&port_mngr->port_tbl_mtx);
> +
> +	if (ret)
> +		dev_err(port_mngr->ctrl_blk->mdev->dev,
> +			"port(%s) add to port_tbl failed, return %d\n",
> +			port->info.name, ret);
> +
> +	return ret;
> +}
> +
> +static void mtk_port_tbl_del(struct mtk_port_mngr *port_mngr, struct mtk_port *port)
> +{
> +	mutex_lock(&port_mngr->port_tbl_mtx);
> +	radix_tree_delete(&port_mngr->port_tbl[MTK_PORT_TBL_TYPE(port->info.rx_ch)],
> +			  port->info.rx_ch & 0xFFF);
> +	port_mngr->port_cnt--;
> +	mutex_unlock(&port_mngr->port_tbl_mtx);
> +}
> +
> +static struct mtk_port *mtk_port_alloc_and_add(struct mtk_port_mngr *port_mngr,
> +					       struct mtk_port_cfg *dflt_info)
> +{
> +	struct mtk_port *port;
> +	int ret;
> +
> +	port = kzalloc_obj(*port, GFP_KERNEL);
> +	if (!port) {
> +		ret = -ENOMEM;
> +		goto err_alloc_port;
> +	}
> +	memcpy(&port->info, dflt_info, sizeof(*dflt_info));
> +
> +	ret = mtk_port_tbl_add(port_mngr, port);
> +	if (ret < 0) {
> +		dev_err(port_mngr->ctrl_blk->mdev->dev,
> +			"Failed to add port(%s) to port tbl\n", dflt_info->name);
> +		goto err_free_port;
> +	}
> +
> +	port->port_mngr = port_mngr;
> +	ret = ports_ops[port->info.type]->init(port);
> +	if (ret < 0) {
> +		mtk_port_tbl_del(port_mngr, port);
> +		goto err_free_port;
> +	}
> +
> +	return port;
> +
> +err_free_port:
> +	kfree(port);
> +err_alloc_port:
> +	return ERR_PTR(ret);
> +}
> +
> +static void mtk_port_free(struct mtk_port_mngr *port_mngr, struct mtk_port *port)
> +{
> +	mutex_lock(&port_mngr_grp_mtx);
> +	mtk_port_tbl_del(port_mngr, port);
> +	kref_put(&port->kref, mtk_port_release);
> +	mutex_unlock(&port_mngr_grp_mtx);
> +}
> +
> +static struct mtk_port *mtk_port_search_by_id(struct mtk_port_mngr *port_mngr, int rx_ch)

[Severity: High]
Does anything keep the port returned here alive until
mtk_port_get_locked() takes its reference?

mtk_port_search_by_name() walks port_tbl[] without rcu_read_lock(),
port_tbl_mtx or port_mngr_grp_mtx, and returns a bare pointer.
mtk_port_get_locked() only takes port_mngr_grp_mtx afterwards. Its
!port check tests the pointer value, not whether the port is still in
the table.

On the mtk_ctrl_exit() path, mtk_port_tbl_destroy() calls
mtk_port_free(). That takes port_mngr_grp_mtx, deletes the port from
the radix tree and drops the last reference, so mtk_port_release()
queues the port with kfree_rcu(). The reader is not inside an RCU
read-side critical section, so the grace period does not wait for it.

If the free runs between the lookup and the mutex_lock() in
mtk_port_get_locked(), then kref_get() and mtk_port_common_open() use
freed memory. The tree walk itself can also see nodes that a
concurrent radix_tree_delete() is freeing.

mtk_port_search_by_id() has the same problem. That includes the RX
path in mtk_port_rx_dispatch(), which uses the port without taking any
reference.

Could the lookup and kref_get() be done inside one port_mngr_grp_mtx
section? Another option is rcu_read_lock() with
kref_get_unless_zero(). Also, the rcu_dereference_raw() in
MTK_PORT_SEARCH_FROM_RADIX_TREE hides this from lockdep.

> +{
> +	int tbl_type = MTK_PORT_TBL_TYPE(rx_ch);
> +
> +	if (tbl_type < PORT_TBL_SAP || tbl_type >= PORT_TBL_MAX)
> +		return NULL;
> +
> +	return radix_tree_lookup(&port_mngr->port_tbl[tbl_type], MTK_CH_ID(rx_ch));
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
> +
> +static int mtk_port_tbl_create(struct mtk_port_mngr *port_mngr, struct mtk_port_cfg *cfg,
> +			       const int port_cnt)
> +{
> +	struct mtk_port_cfg *dflt_port;
> +	struct mtk_port *port;
> +	int i;
> +
> +	INIT_RADIX_TREE(&port_mngr->port_tbl[PORT_TBL_SAP], GFP_KERNEL);
> +	INIT_RADIX_TREE(&port_mngr->port_tbl[PORT_TBL_MD], GFP_KERNEL);
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
> +static void mtk_port_tbl_destroy(struct mtk_port_mngr *port_mngr)
> +{
> +	struct radix_tree_iter iter;
> +	struct mtk_port *port;
> +	void __rcu **slot;
> +	int tbl_type;
> +
> +	tbl_type = PORT_TBL_SAP;
> +	do {
> +		radix_tree_for_each_slot(slot, &port_mngr->port_tbl[tbl_type], &iter, 0) {
> +			MTK_PORT_SEARCH_FROM_RADIX_TREE(port, slot);
> +			MTK_PORT_INTERNAL_NODE_CHECK(port, slot, iter);
> +			ports_ops[port->info.type]->disable(port);
> +		}
> +
> +		while (radix_tree_gang_lookup(&port_mngr->port_tbl[tbl_type],
> +					      (void **)&port, 0, 1))
> +			mtk_port_free(port_mngr, port);
> +	} while (++tbl_type < PORT_TBL_MAX);
> +}
> +
> +void mtk_port_trb_init(struct mtk_port *port, struct trb *trb, enum mtk_trb_cmd_type cmd,
> +		       int (*trb_complete)(struct sk_buff *skb))
> +{
> +	kref_init(&trb->kref);
> +	trb->channel_id = port->info.rx_ch;
> +	trb->status = MTK_DFLT_TRB_STATUS;
> +	trb->priv = port;
> +	trb->cmd = cmd;
> +	trb->trb_complete = trb_complete;
> +}
> +
> +void mtk_port_trb_free(struct kref *trb_kref)
> +{
> +	struct trb *trb = container_of(trb_kref, struct trb, kref);
> +	struct sk_buff *skb, *frag_skb, *next_skb;
> +
> +	skb = container_of((char *)trb, struct sk_buff, cb[0]);
> +	/* Free frag_list for scatter gather TX */
> +	if (trb->cmd == TRB_CMD_TX && skb_has_frag_list(skb)) {
> +		frag_skb = skb_shinfo(skb)->frag_list;
> +		while (frag_skb) {
> +			next_skb = frag_skb->next;
> +			frag_skb->next = NULL;
> +			dev_kfree_skb_any(frag_skb);
> +			frag_skb = next_skb;
> +		}
> +		skb_shinfo(skb)->frag_list = NULL;
> +		skb->data_len = 0;
> +	}
> +	dev_kfree_skb_any(skb);
> +}
> +
> +static int mtk_port_open_trb_complete(struct sk_buff *skb)
> +{
> +	struct trb_open_priv *trb_open_priv = (struct trb_open_priv *)skb->data;
> +	struct trb *trb = (struct trb *)skb->cb;
> +	struct mtk_port *port = trb->priv;
> +
> +	if (!trb->status) {
> +		port->tx_mtu = trb_open_priv->tx_mtu;
> +		port->rx_mtu = trb_open_priv->rx_mtu;
> +		port->tx_frag_size = trb_open_priv->tx_frag_size;
> +		port->rx_frag_size = trb_open_priv->rx_frag_size;
> +		port->tx_mtu -= MTK_CCCI_H_ELEN;
> +		port->rx_mtu -= MTK_CCCI_H_ELEN;
> +	}
> +
> +	wake_up_all(&port->trb_wq);
> +
> +	kref_put(&trb->kref, mtk_port_trb_free);
> +	return 0;
> +}
> +
> +static int mtk_port_close_trb_complete(struct sk_buff *skb)
> +{
> +	struct trb *trb = (struct trb *)skb->cb;
> +	struct mtk_port *port = trb->priv;
> +
> +	wake_up_all(&port->trb_wq);
> +	wake_up_all(&port->rx_wq);
> +	kref_put(&trb->kref, mtk_port_trb_free);
> +
> +	return 0;
> +}
> +
> +static int mtk_port_tx_complete(struct sk_buff *skb)
> +{
> +	struct trb *trb = (struct trb *)skb->cb;
> +	struct mtk_port *port = trb->priv;
> +
> +	if (trb->status < 0)
> +		dev_warn(port->port_mngr->ctrl_blk->mdev->dev,
> +			 "Failed to send data: status:%d, port:%s\n",
> +			 trb->status, port->info.name);
> +
> +	wake_up_all(&port->trb_wq);
> +	kref_put(&trb->kref, mtk_port_trb_free);
> +
> +	return 0;
> +}
> +
> +int mtk_port_status_check(struct mtk_port *port)
> +{
> +	if (!test_bit(PORT_S_ENABLE, &port->status))
> +		return -ENODEV;
> +
> +	if (!test_bit(PORT_S_OPEN, &port->status) || test_bit(PORT_S_FLUSH, &port->status) ||
> +	    !test_bit(PORT_S_WR, &port->status))
> +		return -EBADF;
> +
> +	return 0;
> +}
> +
> +int mtk_port_send_data(struct mtk_port *port, void *data, bool blocking, bool force_send)
> +{
> +	struct mtk_port_mngr *port_mngr;
> +	struct sk_buff *skb = data;
> +	struct trb *trb;
> +	int ret, len;
> +
> +	port_mngr = port->port_mngr;
> +
> +	trb = (struct trb *)skb->cb;
> +	mtk_port_trb_init(port, trb, TRB_CMD_TX, mtk_port_tx_complete);
> +	len = skb->len;
> +	kref_get(&trb->kref); /* kref count 1->2 */
> +
> +	/* add ccci header */
> +	mtk_port_add_header(skb);
> +	ret = mtk_port_status_check(port);
> +	if (!ret)
> +		ret = mtk_pcie_hif_submit_skb(port_mngr->ctrl_blk->mdev, skb,
> +					      force_send);
> +
> +	if (ret < 0) {
> +		kref_put(&trb->kref, mtk_port_trb_free); /* kref count 2->1 */
> +		kref_put(&trb->kref, mtk_port_trb_free); /* kref count 1->0 */
> +		port->tx_seq--;
> +		goto out;
> +	}
> +
> +	if (!blocking) {
> +		kref_put(&trb->kref, mtk_port_trb_free);
> +		ret = len;
> +		goto out;
> +	}
> +start_wait:
> +
> +	/* wait trb done, and no timeout in tx blocking mode */
> +	ret = wait_event_interruptible_timeout(port->trb_wq,
> +					       trb->status <= 0 ||
> +					       test_bit(PORT_S_FLUSH, &port->status) ||
> +					       !test_bit(PORT_S_WR, &port->status),
> +					       MTK_DFLT_TRB_TIMEOUT);
> +	if (!ret) {
> +		goto start_wait;
> +	} else if (ret == -ERESTARTSYS) {
> +		ret = -EINTR;
> +	} else if (ret > 0) {
> +		if (test_bit(PORT_S_FLUSH, &port->status))
> +			ret = len;
> +		else
> +			ret = (!trb->status) ? len : trb->status;
> +	}
> +	kref_put(&trb->kref, mtk_port_trb_free);
> +
> +out:
> +	return ret;
> +}
> +
> +static int mtk_port_check_rx_seq(struct mtk_port *port, struct mtk_ccci_header *ccci_h)
> +{
> +	u16 seq_num, assert_bit, channel;
> +	struct mtk_md_dev *mdev;
> +
> +	seq_num = FIELD_GET(MTK_HDR_FLD_SEQ, le32_to_cpu(ccci_h->status));
> +	assert_bit = FIELD_GET(MTK_HDR_FLD_AST, le32_to_cpu(ccci_h->status));
> +	if (assert_bit && port->rx_seq &&
> +	    ((seq_num - port->rx_seq) & MTK_CHECK_RX_SEQ_MASK) != 1) {
> +		mdev = port->port_mngr->ctrl_blk->mdev;
> +		channel = FIELD_GET(MTK_HDR_FLD_CHN, le32_to_cpu(ccci_h->status));
> +		dev_warn(mdev->dev,
> +			 "<ch: %04x> seq num out-of-order %d->%d, len(%u)\n",
> +			 channel, seq_num, port->rx_seq,
> +			 le32_to_cpu(ccci_h->packet_len));
> +
> +		port->rx_seq = seq_num;
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
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
> +		return ret;
> +	}
> +
> +	while (frag_skb) {
> +		frag_next = frag_skb->next;
> +		if (!frag_skb->len) {
> +			frag_skb->next = NULL;
> +			dev_kfree_skb_any(frag_skb);
> +			frag_skb = frag_next;
> +			continue;
> +		}
> +		frag_skb->next = NULL;
> +		ret = ports_ops[port->info.type]->recv(port, frag_skb);
> +		if (ret < 0) {
> +			frag_skb->next = frag_next;
> +			while (frag_skb) {
> +				frag_next = frag_skb->next;
> +				frag_skb->next = NULL;
> +				dev_kfree_skb_any(frag_skb);
> +				frag_skb = frag_next;
> +			}
> +			return -EIO;
> +		}
> +		frag_skb = frag_next;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_port_rx_dispatch(struct sk_buff *skb, void *priv, bool force_recv)
> +{
> +	struct mtk_port_mngr *port_mngr;
> +	struct mtk_ccci_header *ccci_h;
> +	struct mtk_port *port = priv;
> +	int ret = -EPROTO;
> +	u16 channel;
> +
> +	if (!skb || !priv) {
> +		pr_err("Invalid input value in rx dispatch\n");
> +		return -EINVAL;
> +	}
> +
> +	port_mngr = port->port_mngr;
> +
> +	ccci_h = mtk_port_strip_header(skb);
> +	if (unlikely(!ccci_h)) {
> +		dev_warn(port_mngr->ctrl_blk->mdev->dev,
> +			 "Unsupported: skb length(%d) is less than ccci header\n",
> +			 skb->len);
> +		goto drop_data;
> +	}
> +
> +	channel = FIELD_GET(MTK_HDR_FLD_CHN, le32_to_cpu(ccci_h->status));
> +	port = mtk_port_search_by_id(port_mngr, channel);
> +	if (unlikely(!port)) {
> +		dev_warn(port_mngr->ctrl_blk->mdev->dev,
> +			 "Failed to find port by channel:%d\n", channel);
> +		goto drop_data;
> +	}
> +
> +	ret = mtk_port_check_rx_seq(port, ccci_h);
> +	if (unlikely(ret))
> +		goto drop_data;
> +
> +	port->rx_seq = FIELD_GET(MTK_HDR_FLD_SEQ, le32_to_cpu(ccci_h->status));
> +	skb_pull(skb, sizeof(*ccci_h));
> +
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
> +	return ret;
> +}
> +
> +int mtk_port_add_header(struct sk_buff *skb)
> +{
> +	struct mtk_ccci_header *ccci_h;
> +	struct mtk_port *port;
> +	struct trb *trb;
> +
> +	trb = (struct trb *)skb->cb;
> +	if (trb->status == MTK_TRB_HEADER_ADDED)
> +		return 0;
> +
> +	port = trb->priv;
> +	if (!port)
> +		return -EINVAL;
> +
> +	ccci_h = skb_push(skb, sizeof(*ccci_h));
> +
> +	ccci_h->packet_header = cpu_to_le32(0);
> +	ccci_h->packet_len = cpu_to_le32(skb->len);
> +	ccci_h->ex_msg = cpu_to_le32(0);
> +	ccci_h->status = cpu_to_le32(FIELD_PREP(MTK_HDR_FLD_CHN, port->info.tx_ch) |
> +				     FIELD_PREP(MTK_HDR_FLD_SEQ, port->tx_seq++) |
> +				     FIELD_PREP(MTK_HDR_FLD_AST, 1));
> +
> +	trb->status = MTK_TRB_HEADER_ADDED;
> +
> +	return 0;
> +}
> +
> +struct mtk_ccci_header *mtk_port_strip_header(struct sk_buff *skb)
> +{
> +	struct mtk_ccci_header *ccci_h;
> +
> +	if (skb->len < sizeof(*ccci_h)) {
> +		pr_err("Invalid input value\n");
> +		return NULL;
> +	}
> +
> +	ccci_h = (struct mtk_ccci_header *)skb->data;
> +
> +	return ccci_h;
> +}
> +
> +int mtk_port_status_update(struct mtk_md_dev *mdev, void *data, u32 data_len)
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
> +	if (data_len < sizeof(*msg) +
> +	    le16_to_cpu(msg->port_cnt) * sizeof(*port_info))
> +		return -EPROTO;
> +
> +	for (port_id = 0; port_id < le16_to_cpu(msg->port_cnt); port_id++) {
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
> +	struct mtk_port_mngr *port_mngr = port->port_mngr;
> +	struct trb_open_priv *trb_open_priv;
> +	struct sk_buff *skb;
> +	struct trb *trb;
> +	int ret;
> +
> +	skb = __dev_alloc_skb(Q_MTU_3_5K, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	trb_open_priv = (struct trb_open_priv *)skb->data;
> +	trb_open_priv->rx_done = mtk_port_rx_dispatch;
> +
> +	skb_put(skb, sizeof(struct trb_open_priv));
> +	trb = (struct trb *)skb->cb;
> +	mtk_port_trb_init(port, trb, TRB_CMD_ENABLE, mtk_port_open_trb_complete);
> +	kref_get(&trb->kref);
> +
> +	ret = mtk_pcie_hif_submit_skb(port_mngr->ctrl_blk->mdev, skb, true);
> +	if (ret) {
> +		dev_err(port_mngr->ctrl_blk->mdev->dev,
> +			"Failed to submit trb for port(%s), ret=%d\n",
> +			port->info.name, ret);
> +		kref_put(&trb->kref, mtk_port_trb_free);
> +		kref_put(&trb->kref, mtk_port_trb_free);
> +		return ret;
> +	}
> +
> +	ret = wait_event_timeout(port->trb_wq, trb->status <= 0,
> +				 MTK_DFLT_TRB_TIMEOUT);
> +	if (!ret)
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
> +	struct mtk_port_mngr *port_mngr = port->port_mngr;
> +	struct sk_buff *skb;
> +	struct trb *trb;
> +	int ret;
> +
> +	skb = __dev_alloc_skb(Q_MTU_3_5K, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	trb = (struct trb *)skb->cb;
> +	mtk_port_trb_init(port, trb, TRB_CMD_DISABLE, mtk_port_close_trb_complete);
> +	kref_get(&trb->kref);
> +
> +	ret = mtk_pcie_hif_submit_skb(port_mngr->ctrl_blk->mdev, skb, true);
> +	if (ret) {
> +		dev_warn(port_mngr->ctrl_blk->mdev->dev,
> +			 "Failed to submit trb for port(%s), ret=%d\n",
> +			 port->info.name, ret);
> +		kref_put(&trb->kref, mtk_port_trb_free);
> +		kref_put(&trb->kref, mtk_port_trb_free);
> +		return ret;
> +	}
> +
> +	ret = wait_event_timeout(port->trb_wq, trb->status <= 0,
> +				 MTK_DFLT_TRB_TIMEOUT);
> +	if (!ret)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = trb->status;
> +
> +	kref_put(&trb->kref, mtk_port_trb_free);
> +
> +	return ret;
> +}
> +
> +int mtk_port_mngr_init(struct mtk_ctrl_blk *ctrl_blk, struct mtk_port_cfg *port_cfg, int port_cnt)
> +{
> +	struct mtk_port_mngr *port_mngr;
> +	int ret = -ENOMEM;
> +
> +	port_mngr = devm_kzalloc(ctrl_blk->mdev->dev, sizeof(*port_mngr), GFP_KERNEL);
> +	if (unlikely(!port_mngr)) {
> +		dev_err((ctrl_blk->mdev)->dev, "Failed to alloc memory for port_mngr\n");
> +		goto err_out;
> +	}
> +
> +	port_mngr->ctrl_blk = ctrl_blk;
> +	mutex_init(&port_mngr->port_tbl_mtx);
> +
> +	ret = mtk_port_tbl_create(port_mngr, port_cfg, port_cnt);
> +	if (unlikely(ret)) {
> +		dev_err((ctrl_blk->mdev)->dev, "Failed to create port_tbl\n");
> +		goto err_free_port_mngr;
> +	}
> +
> +	ctrl_blk->port_mngr = port_mngr;
> +
> +	return ret;
> +
> +err_free_port_mngr:
> +	mtk_port_tbl_destroy(port_mngr);
> +err_out:
> +	return ret;
> +}
> +
> +void mtk_port_mngr_exit(struct mtk_ctrl_blk *ctrl_blk)
> +{
> +	struct mtk_port_mngr *port_mngr = ctrl_blk->port_mngr;
> +
> +	mtk_port_tbl_destroy(port_mngr);
> +
> +	ctrl_blk->port_mngr = NULL;
> +}

[Severity: High]
Can mtk_port_add_header() hit skb_under_panic() here?

The skb comes straight from the caller of mtk_port_internal_write().
Nothing on the way to this skb_push() checks skb_headroom(skb) against
sizeof(struct mtk_ccci_header).

An internal user might allocate its skb with alloc_skb() and no
skb_reserve(), or pass in an skb whose headroom is already used up.
In that case skb_push() calls BUG() instead of failing the write.

If the skb is cloned, the header is also written into data that is
shared with the clone.

Should this call skb_cow_head(skb, sizeof(*ccci_h)) and return an
error on failure? If so, mtk_port_send_data() would need to stop
ignoring the return value of mtk_port_add_header(). The port->tx_seq--
in its error path would also have to be skipped when no sequence
number was consumed.

Or, if the API requires callers to reserve the headroom, could that be
documented and checked here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-t9xx_driver_v1-v9-0-3248b9256956%40compal.com
