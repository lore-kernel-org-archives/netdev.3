Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5484AF665;
	Thu,  8 Oct 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470005; cv=none; b=Lv3tt0r3hHUSjykS0S/VllXeEzCLyX0fYVJPZ9SEEGelADjQwlqqGn/vl4yHWFbZWnj8deXLZ/B8a6IZjcCVP1dp0vZJqtc3PX4D8gyWu5UXjxgeL3JPLChzoXzEunbazatzle+mn6zvjFqQKkxD9h+cUW+4flhJ/sLcbuMr7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470005; c=relaxed/simple;
	bh=tb7LPVm64B0tRPXVoxNQfpxJdrtcmGRLsgEumauKuE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5zXihFEOBfEWtAjKJg9SXpTLj4okN4CArrNMBoRQWm21BdYVFgumTLikHQoH3KY01WxqBAPTaB2O6Pxl9KZ/ZPneJ+fWMFK2TFu7/KTbM/Knh+jYGtHF+lN/kuxD1AXUqVRuU8HKmztCEY2FuJjxAkLQxBYCJtheLLEiJ6L8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBD-000l4X-0L;
	Thu, 08 Oct 2026 16:33:07 +0200
From: John Crispin <john@phrozen.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [RFC net-next 07/12] net: pon: add the OMCI channel
Date: Thu,  8 Oct 2026 16:32:44 +0200
Message-Id: <20261008143249.3439762-8-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008143249.3439762-1-john@phrozen.org>
References: <20261008143249.3439762-1-john@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OMCI is the management protocol of ITU-T G.988. It is the job of
userspace. The kernel carries it over the pon netlink family, as nl80211
carries management frames. One socket registers for the OMCI PDUs of a
device, receives them as notifications and sends with omci-tx. The
registration ends when the socket closes.

A PDU crosses the boundary bare, without its integrity field. The core
checks the framing of a PDU to send against G.988 clause 11.2.3: 44
bytes in the baseline format, the header and the stated contents length
in the extended format. So every driver gets the same PDUs. A PDU that
the MAC passed up unchecked is verified by the driver, which holds the
OMCI integrity key. Received PDUs wait for the context of the instance
in one queue bounded at 512, in the order they arrived, checked or not.
A PDU that finds no owner or no room is dropped and counted.

The omci_xmit callback runs with bottom halves disabled, because it ends
in the transmit path of the conduit.

A MAC can check the integrity of a downstream OMCI PDU inline. A PDU
that it passes up unchecked goes to the omci_verify callback of the
driver, which checks it with the OMCI integrity key. The key stays in
the driver and the check can sleep, so the core defers the call to the
lent context. The core has no key and never checks a MIC itself.
Without omci_verify it drops an unchecked PDU.

Assisted-by: LLM
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/pon/pon_omci.c | 326 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 326 insertions(+)
 create mode 100644 net/pon/pon_omci.c

diff --git a/net/pon/pon_omci.c b/net/pon/pon_omci.c
new file mode 100644
index 000000000000..c8093a9c3749
--- /dev/null
+++ b/net/pon/pon_omci.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#include <linux/atomic.h>
+#include <linux/bottom_half.h>
+#include <linux/netlink.h>
+#include <linux/notifier.h>
+#include <linux/skbuff.h>
+#include <linux/xarray.h>
+#include <linux/unaligned.h>
+#include <net/net_namespace.h>
+#include <net/pon.h>
+
+#include "pon.h"
+
+#define PON_OMCI_DEVID_OFF		3
+#define PON_OMCI_DEVID_BASELINE		0x0a
+#define PON_OMCI_DEVID_EXTENDED		0x0b
+#define PON_OMCI_CONTENTS_LEN_OFF	8
+#define PON_OMCI_EXTENDED_HDR_LEN	10
+#define PON_OMCI_BASELINE_LEN		44
+#define PON_OMCI_CB(skb)		((struct pon_omci_cb *)(skb)->cb)
+
+/**
+ * struct pon_omci_cb - what the receive queue keeps with a PDU
+ * @unverified: the MAC did not check the integrity of the PDU, which still
+ *		ends with its MIC
+ */
+struct pon_omci_cb {
+	bool unverified;
+};
+
+/**
+ * pon_omci_len_valid() - check the length of an OMCI PDU
+ * @len:	the length of the PDU in bytes
+ * @trailer:	the bytes the PDU carries after the message, PON_OMCI_MIC_LEN
+ *		when it still ends with its MIC, 0 otherwise
+ *
+ * The limits are those of the extended message format, ITU-T G.988 clause
+ * 11.2.5 and Table 11.2-2.
+ *
+ * Return: true when @len lies between PON_OMCI_MIN_LEN and PON_OMCI_MAX_LEN,
+ * both plus @trailer, false otherwise.
+ */
+static bool pon_omci_len_valid(unsigned int len, unsigned int trailer)
+{
+	return len >= PON_OMCI_MIN_LEN + trailer &&
+	       len <= PON_OMCI_MAX_LEN + trailer;
+}
+
+/**
+ * pon_omci_framing_valid() - check the framing of an OMCI PDU to send
+ * @pdu:	the PDU, without its MIC
+ * @len:	the length of @pdu in bytes, at least PON_OMCI_MIN_LEN
+ *
+ * The device identifier of ITU-T G.988 clause 11.2.3 selects the format. A
+ * baseline PDU (Table 11.2-1) is 44 bytes without the MIC. An extended PDU
+ * (Table 11.2-2) is the 10 byte header and as many bytes of contents as its
+ * message contents length states.
+ *
+ * Return: true when @len is the length the header of @pdu calls for, false
+ * otherwise.
+ */
+static bool pon_omci_framing_valid(const u8 *pdu, unsigned int len)
+{
+	unsigned int contents;
+
+	switch (pdu[PON_OMCI_DEVID_OFF]) {
+	case PON_OMCI_DEVID_BASELINE:
+		return len == PON_OMCI_BASELINE_LEN;
+	case PON_OMCI_DEVID_EXTENDED:
+		contents = get_unaligned_be16(pdu + PON_OMCI_CONTENTS_LEN_OFF);
+		return len == PON_OMCI_EXTENDED_HDR_LEN + contents;
+	default:
+		return false;
+	}
+}
+
+/**
+ * pon_omci_deliver() - hand one OMCI PDU to the owner of the OMCI channel
+ * @pdev:	PON device structure
+ * @skb:	the verified PDU, which is consumed
+ *
+ * A PDU that cannot be sent to the owner, or that arrives while no socket
+ * owns the channel, is dropped.
+ *
+ * Context: The instance's context, with @pdev->lock held.
+ */
+static void pon_omci_deliver(struct pon_dev *pdev, struct sk_buff *skb)
+{
+	if (pon_nl_omci_ntf(pdev, skb)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	consume_skb(skb);
+}
+
+/**
+ * pon_omci_rx_verify() - check a received OMCI PDU through the driver
+ * @pdev:	PON device structure
+ * @skb:	the PDU the MAC passed up unchecked, ending with its MIC
+ *
+ * The driver's omci_verify callback checks and strips the MIC (ITU-T
+ * G.9807.1 clause C.15.7.2). A PDU that fails is freed. A PDU that cannot be
+ * made linear is freed too, because its integrity was never checked.
+ *
+ * Context: The instance's context, with @pdev->lock held.
+ * Return: true when the PDU passed and is now bare, false when it is gone.
+ */
+static bool pon_omci_rx_verify(struct pon_dev *pdev, struct sk_buff *skb)
+{
+	if (skb_linearize(skb) || pdev->ops->omci_verify(pdev, skb)) {
+		kfree_skb(skb);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * pon_omci_rx_work() - verify and deliver the queued OMCI PDUs
+ * @pdev:	PON device structure
+ * @work:	the instance's @omci_rx_work
+ *
+ * Takes the PDUs in the order they arrived. One the MAC passed up unchecked
+ * goes through pon_omci_rx_verify() first. One the MAC verified goes to the
+ * owner as it is.
+ *
+ * Context: The instance's context, with @pdev->lock held.
+ */
+static void pon_omci_rx_work(struct pon_dev *pdev, struct pon_work *work)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&pdev->omci_rxq))) {
+		if (PON_OMCI_CB(skb)->unverified &&
+		    !pon_omci_rx_verify(pdev, skb))
+			continue;
+
+		pon_omci_deliver(pdev, skb);
+	}
+}
+
+/**
+ * pon_omci_conduit_rx() - take one OMCI PDU from the conduit
+ * @pdev:	PON device structure
+ * @skb:	the PDU, starting at the transaction correlation id and ending
+ *		with its 4 byte MIC when @unverified
+ * @unverified:	the MAC did not check the integrity of the PDU
+ *
+ * Runs in the conduit's NAPI context. The PDU waits for the instance's
+ * context, which verifies it through the driver when @unverified and hands
+ * it to the owner of the OMCI channel. Checked and unchecked PDUs share one
+ * queue, so the owner gets them in the order they arrived. A PDU is at most
+ * PON_OMCI_MAX_LEN bytes and PON_OMCI_MIC_LEN more when @unverified, because
+ * the driver strips the MIC only once it has checked it (ITU-T G.988 clause
+ * 11.2.5). A PDU that arrives while no socket owns the channel is dropped
+ * here.
+ *
+ * Return: 0, the skb is consumed.
+ */
+int pon_omci_conduit_rx(struct pon_dev *pdev, struct sk_buff *skb,
+			bool unverified)
+{
+	if (!pon_omci_len_valid(skb->len, unverified ? PON_OMCI_MIC_LEN : 0) ||
+	    !READ_ONCE(pdev->omci_portid) ||
+	    (unverified && !pdev->ops->omci_verify) ||
+	    skb_queue_len_lockless(&pdev->omci_rxq) >= PON_OMCI_QUEUE_MAX) {
+		kfree_skb(skb);
+		return 0;
+	}
+
+	PON_OMCI_CB(skb)->unverified = unverified;
+	skb_queue_tail(&pdev->omci_rxq, skb);
+	pon_work_queue(pdev, &pdev->omci_rx_work);
+
+	return 0;
+}
+
+/**
+ * pon_omci_xmit() - send one OMCI PDU to the OLT
+ * @pdev:	PON device structure
+ * @pdu:	the PDU, without its MIC
+ * @len:	the length of @pdu in bytes
+ * @extack:	netlink extended ack for the reason the core refuses the PDU,
+ *		or NULL
+ *
+ * Copies the PDU into an skb and hands it to the driver's omci_xmit
+ * callback with bottom halves disabled. The length must fit the extended
+ * message format, ITU-T G.988 clause 11.2.5 and Table 11.2-2, less the 4
+ * byte MIC, which @pdu does not carry. It must also be the length that the
+ * header of the PDU calls for, as pon_omci_framing_valid() checks, so the
+ * driver receives a bare PDU of a known format. Only that refusal sets
+ * @extack. An error of the driver leaves it alone.
+ *
+ * Context: Called with @pdev->lock held, from the omci-tx netlink handler.
+ * Return: 0, -EINVAL for a length out of range or a length that does not
+ * match the format, -ENOMEM, or the driver's errno.
+ */
+int pon_omci_xmit(struct pon_dev *pdev, const void *pdu, unsigned int len,
+		  struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+	int err;
+
+	lockdep_assert_held(&pdev->lock);
+
+	if (!pon_omci_len_valid(len, 0) || !pon_omci_framing_valid(pdu, len)) {
+		NL_SET_ERR_MSG(extack,
+			       "OMCI PDU length does not match its format");
+		return -EINVAL;
+	}
+
+	skb = alloc_skb(len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+	skb_put_data(skb, pdu, len);
+
+	local_bh_disable();
+	err = pdev->ops->omci_xmit(pdev, skb);
+	local_bh_enable();
+
+	return err;
+}
+
+/**
+ * pon_omci_register() - claim the OMCI channel of a PON device for a socket
+ * @pdev:	PON device structure
+ * @portid:	the netlink port id of the socket
+ *
+ * The first socket to claim the channel owns it until it closes, when
+ * pon_omci_netlink_notify() releases it. A second claim by the owner
+ * succeeds.
+ *
+ * Context: Called with @pdev->lock held.
+ * Return: 0 when @portid owns the channel, -EBUSY when another socket does.
+ */
+int pon_omci_register(struct pon_dev *pdev, u32 portid)
+{
+	u32 owner;
+
+	lockdep_assert_held(&pdev->lock);
+
+	owner = cmpxchg(&pdev->omci_portid, 0, portid);
+
+	return owner && owner != portid ? -EBUSY : 0;
+}
+
+/**
+ * pon_omci_netlink_notify() - release the OMCI channels of a closed socket
+ * @nb:		the notifier block
+ * @state:	what happened to the socket
+ * @data:	struct netlink_notify of the socket
+ *
+ * Runs when a netlink socket is released. Every device in the netns of the
+ * socket that it owned the OMCI channel of loses its owner.
+ *
+ * Return: NOTIFY_DONE.
+ */
+static int pon_omci_netlink_notify(struct notifier_block *nb,
+				   unsigned long state, void *data)
+{
+	struct netlink_notify *notify = data;
+	struct pon_dev *pdev;
+	unsigned long id;
+
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	xa_for_each(&pon_devs, id, pdev) {
+		if (!net_eq(dev_net(pdev->main_netdev), notify->net))
+			continue;
+		cmpxchg(&pdev->omci_portid, notify->portid, 0);
+	}
+	rcu_read_unlock();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pon_omci_netlink_notifier = {
+	.notifier_call = pon_omci_netlink_notify,
+};
+
+/**
+ * pon_omci_notifier_register() - watch for closed netlink sockets
+ *
+ * Return: 0, or the errno of netlink_register_notifier().
+ */
+int pon_omci_notifier_register(void)
+{
+	return netlink_register_notifier(&pon_omci_netlink_notifier);
+}
+
+/**
+ * pon_omci_notifier_unregister() - stop the watch for closed netlink sockets
+ */
+void pon_omci_notifier_unregister(void)
+{
+	netlink_unregister_notifier(&pon_omci_netlink_notifier);
+}
+
+/**
+ * pon_omci_init() - prepare the OMCI receive path of a new PON device
+ * @pdev:	PON device structure
+ *
+ * Context: From pon_dev_create(), before the device is published.
+ */
+void pon_omci_init(struct pon_dev *pdev)
+{
+	skb_queue_head_init(&pdev->omci_rxq);
+	pon_work_init(&pdev->omci_rx_work, pon_omci_rx_work);
+}
+
+/**
+ * pon_omci_destroy() - free the OMCI PDUs still queued
+ * @pdev:	PON device structure
+ *
+ * Context: From pon_dev_unregister(), after the conduit is detached and the
+ * instance's work is canceled.
+ */
+void pon_omci_destroy(struct pon_dev *pdev)
+{
+	skb_queue_purge(&pdev->omci_rxq);
+}
-- 
2.34.1

