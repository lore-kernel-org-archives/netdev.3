Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADF390986
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439335; cv=none; b=gTqBb+KlnMB5ZFHvXHcJQQaEaA39WjgXwgWUzcaPdnNo7E8zyeV6lSB2kkyLHHZqb6yknfZaw54VEBKEXkcB3IPnPV+s32a52QJ5pKVehx3eTSXX1oOQ54GRqI9b+yLp36xA94uror0p8I+VJW3HS0C5z1ChvVr1tqdHSFrfilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439335; c=relaxed/simple;
	bh=ccBGO/cGrocz2VKi8OBRMzHW6COI9Zn0ySrVOt3jJAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAnjgxelx/C9aOYVpnNGiCYMSTKZNKt0eThONBjvudJG5EgcsY0U+QSZcUoF+92R5tFgxqIUA00SaWBkyHTnvQ4no1irNjoderjma5JeSiscdZSkq79c7+JkN7j3FIuIzhXeuRchCD8wYkvnW9qdho5GN2V6EQ3aSk/PSjZiDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMdiWcUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMdiWcUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAF91F00A3D;
	Sat, 22 Aug 2026 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439332;
	bh=dDWIfouy2Fu1//RgTQu7HhT8ejYvwQbgr/kmWojt8n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMdiWcUalMLfAWC7XZazPaNRHtSGpcsIeTathWRysQRektAEIN7OxGTMGBU/zhgnh
	 aOqqyMod+REcW94ZV1H9iuXSfvXqt6z+cTnYeiHMZLY7eVgc8iiIutQhoHV5WjAI5P
	 3jhxeEXPYeQlYk4VP7n2AyetdNo/X8iyuahnEm+pUYuvR+lXDmIs7Ao7h0k0J3dHrV
	 d8oDxPwquF24LutVrgrMR319x/Lck1HYyuAg64aAfUNlrhNAQo1LpOY/uWYUmkWGwq
	 k6clVM1+4CRYvp9TB1DohIqnR5m0oCounYUcZh9kUdr8t/zPvCSZ51jKLaqUIV/em2
	 yKkC7hJ31TVTg==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com,
	cratiu@nvidia.com,
	borisp@nvidia.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 1/6] psp: steer Rx queues with the virtualization cookie
Date: Sat, 22 Aug 2026 15:55:19 -0700
Message-ID: <20260822225524.2328465-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822225524.2328465-1-kuba@kernel.org>
References: <20260822225524.2328465-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PSP leaves the 64b virtualization cookie undefined in transport mode.
Put it to use: let both ends of a connection tell each other which Rx
queue they want traffic on, so that a flow can be pinned to a queue
without the receiver having to install a per-flow steering rule, and
without the sender having to know anything about the receiver's queue
layout. The cookie holds a queue ID the sender is asking the peer to
send to ("req") and the queue ID the peer last asked for, granted
("dst"). Each ID gets a 32b word of the cookie to itself and uses only
the low half of it, so that either can grow to 32b later without the
fields moving.

The two directions are configured separately:

 * rx asks peers to send to the queue paired with the flow's Tx queue,
   so traffic this host receives gets steered. The receiver installs one
   low priority rule per Rx queue matching "dst", which wins over RSS,
   so this needs vc-steer-cap.
 * tx grants the requests peers make, so traffic this host sends gets
   steered at the far end. The queue is the peer's to pick and the rules
   are the peer's to install, so this needs nothing from the local
   device and can be turned on where vc-steer-cap is absent.

Splitting them is what makes one sided deployment work. Turn granting on
everywhere, cheaply, and asking wherever the NIC can actually do it.

The steering itself is entirely a device matter, the core only has
to move the two queue IDs around. That is why the Tx side hooks
psp_validate_xmit(): it is the one PSP-specific callback which runs
after netdev_core_pick_tx() has stamped the queue and still has the
netdev at hand.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/psp.yaml          | 42 +++++++++
 Documentation/networking/psp.rst              | 75 +++++++++++++++
 include/net/psp/types.h                       | 93 ++++++++++++++++++-
 include/net/psp/functions.h                   | 54 ++++++++++-
 include/uapi/linux/psp.h                      | 17 ++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |  2 +-
 drivers/net/netdevsim/psp.c                   |  2 +-
 net/psp/psp-nl-gen.c                          |  5 +-
 net/psp/psp_main.c                            | 53 +++++++----
 net/psp/psp_nl.c                              | 21 ++++-
 net/psp/psp_sock.c                            | 35 +++++++
 11 files changed, 373 insertions(+), 26 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index e9c2ee7e28e0..a65274920d21 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -11,6 +11,24 @@ name: psp
     name: version
     entries: [hdr0-aes-gcm-128, hdr0-aes-gcm-256,
               hdr0-aes-gmac-128, hdr0-aes-gmac-256]
+  -
+    type: enum
+    name: vc-steer
+    doc: Directions of traffic which take part in VC based queue steering.
+    entries:
+      -
+        name: tx
+        doc: |
+          Grant the requests peers make, so that traffic this device
+          sends is steered at the far end. Costs nothing but the room in
+          the header, the queue is the peer's to pick, so this does not
+          need vc-steer-cap.
+      -
+        name: rx
+        doc: |
+          Ask peers to send to the Rx queue paired with the flow's Tx
+          queue, so that traffic this device receives is steered. Needs
+          vc-steer-cap, the rules doing the steering are ours.
 
 attribute-sets:
   -
@@ -72,6 +90,27 @@ name: psp
           Present when in associated namespace, absent when in primary/host
           namespace.
         type: flag
+      -
+        name: vc-steer-cap
+        doc: |
+          Device can steer received traffic on the PSP virtualization
+          cookie (VC). The VC is split into a 32b reserved part, a 16b
+          queue ID the sender is asking the peer to send to, and a 16b
+          queue ID granting the peer's own request. Steering installs low
+          priority rules matching the latter, which win over the RSS table
+          result. Only needed for the rx direction; granting a peer's
+          request is just header generation and needs no device support.
+        type: flag
+      -
+        name: vc-steer-ena
+        doc: |
+          Directions taking part in VC based queue steering. Leave the
+          attribute out of a dev-set request to keep the current setting.
+          Applies to associations created from then on, existing ones keep
+          the setting they were created with.
+        type: u32
+        enum: vc-steer
+        enum-as-flags: true
 
   -
     name: assoc
@@ -207,6 +246,8 @@ name: psp
             - psp-versions-ena
             - assoc-list
             - by-association
+            - vc-steer-cap
+            - vc-steer-ena
         pre: psp-device-get-locked
         post: psp-device-unlock
       dump:
@@ -231,6 +272,7 @@ name: psp
           attributes:
             - id
             - psp-versions-ena
+            - vc-steer-ena
         reply:
           attributes: []
         pre: psp-device-get-locked-admin
diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
index 4ac09e64e95a..4ebb3853dc6e 100644
--- a/Documentation/networking/psp.rst
+++ b/Documentation/networking/psp.rst
@@ -132,6 +132,68 @@ numbers in a way that deletes a prefix of the PSP protected part of
 the TCP stream. If userspace cares to mitigate this type of attack, a
 special "start of PSP" message should be exchanged after ``tx-assoc``.
 
+Queue steering
+--------------
+
+The PSP header may carry an optional 64 bit "virtualization cookie" (VC).
+The protocol assigns it no meaning in transport mode, so Linux uses it to
+let the two ends of a connection tell each other which Rx queue they want
+traffic delivered to. The cookie carries two queue IDs::
+
+   63           48 47           32 31           16 15            0
+  +---------------+---------------+---------------+---------------+
+  |    reserved   |    req qid    |    reserved   |    dst qid    |
+  +---------------+---------------+---------------+---------------+
+
+``req`` is the Rx queue the sender is asking the peer to send to, and
+``dst`` is the queue this packet is to be delivered to, which holds the
+``req`` the sender last saw from the peer. Each side's request is what
+becomes the other side's destination. ``0xffff`` means "no queue" and
+reserved bits must be zero.
+
+Each ID gets a 32 bit word to itself, of which only the low half is used.
+Queue counts fit in 16 bits today; should that stop being true, an ID can
+grow into the reserved half of its word without the fields moving.
+
+The two directions are enabled independently, with ``vc-steer-ena``:
+
+ * ``rx`` asks peers to send to the queue paired with the flow's Tx queue,
+   so traffic this host *receives* gets steered. This needs
+   ``vc-steer-cap``: the driver is required to arrange the appropriate Rx
+   steering, and whatever rules it uses to do so are implicit, not visible
+   to the user. They have lower priority than any explicitly configured
+   flow steering, but do take precedence over the RSS table.
+ * ``tx`` grants the requests peers make, so traffic this host *sends*
+   gets steered at the far end. The queue is the peer's to choose and the
+   rules are the peer's to install, so this needs no device support at
+   all, and can be turned on even where ``vc-steer-cap`` is absent.
+
+Enabling either direction grows the PSP header by the size of the cookie,
+and the MSS shrinks accordingly. The setting is therefore sampled when an
+association is created; changing it later applies to new associations
+only, and existing connections keep the header size they were set up
+with.
+
+The queue the local end asks for is refreshed from the Tx queue the stack
+picks for the flow, assuming that Rx and Tx queues are paired by index.
+
+Trust model
+~~~~~~~~~~~
+
+VC steering as implemented is not robust against queue DDoS attacks, that
+is a coordinated overload of a single Rx queue, because any peer can name
+any queue. The expectation is that PSP is not used to talk to untrusted
+peers while VC steering is enabled. Note that use of the cookie requires
+PSP, so the *machine* as a whole may still talk to untrusted peers, as
+long as it hands out no PSP keys to them.
+
+The intended way of handling a mix of trusted and untrusted peers is to
+extend the queue ID and stop using it as a direct index, making it a per
+queue cookie instead. An untrusted peer should then not be able to guess
+a tag which was never communicated to it, and the secrets can be rotated
+periodically and gradually, one queue at a time. It is important that
+changes to the implementation do not prevent this future extension.
+
 Rotation notifications
 ----------------------
 
@@ -172,6 +234,19 @@ Drivers must use ``psp_skb_get_assoc_rcu()`` to check if PSP Tx offload
 was requested for given skb. On Rx drivers should allocate and populate
 the ``SKB_EXT_PSP`` skb extension, and set the skb->decrypted bit to 1.
 
+Every driver has to carry the cookie, not just those which advertise
+``vc-steer-cap`` - granting a peer's request needs no help from the
+device, so the ``tx`` direction of ``vc-steer-ena`` may be turned on
+anywhere. Drivers must ask ``psp_assoc_vc_tx_get()`` for the cookie to
+place in the Tx header, and report the queue IDs a received cookie held
+in ``psp_skb_ext.vc_req`` and ``vc_dst`` (``psp_dev_rcv()`` does this for
+drivers which let the core strip the headers). Reporting is what allows
+the core to grant the peer's request. The steering itself is only
+expected of drivers which advertise ``vc-steer-cap``.
+
+When VC steering is enabled GRO implementations are allowed to ignore
+changes in the cookie for transport mode PSP.
+
 Kernel implementation notes
 ---------------------------
 
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 87991a1ea02d..87ceb16b1a82 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -3,9 +3,12 @@
 #ifndef __NET_PSP_H
 #define __NET_PSP_H
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <net/net_trackers.h>
+#include <uapi/linux/psp.h>
 
 struct netlink_ext_ack;
 
@@ -35,13 +38,58 @@ struct psphdr {
 #define PSPHDR_VERFL_ONE	BIT(0)
 
 #define PSP_HDRLEN_NOOPT	((sizeof(struct psphdr) - 8) / 8)
+#define PSP_HDRLEN_VC		(PSP_HDRLEN_NOOPT + 1)
+
+/* Virtualization cookie (VC) based Rx queue steering.
+ *
+ * The VC is a 64b cookie which the PSP spec leaves to the implementation
+ * in transport mode. We use it to let the two ends of a connection tell
+ * each other which Rx queue they'd like traffic delivered to:
+ *
+ *  63           48 47           32 31           16 15            0
+ * +---------------+---------------+---------------+---------------+
+ * |    reserved   |    req qid    |    reserved   |    dst qid    |
+ * +---------------+---------------+---------------+---------------+
+ *
+ * @req is the Rx queue the sender is asking the peer to send to.
+ * @dst is the Rx queue this packet is to be delivered to, and holds the
+ * @req the sender most recently saw from the peer. Each side's request
+ * is what becomes the other side's destination.
+ *
+ * Each ID gets a 32b word to itself, of which only the low half is used
+ * today. Queue counts fit in 16b for now, but growing an ID to 32b later
+ * is then a matter of widening its mask, with no reshuffling of the
+ * cookie and no change to what an old peer puts on the wire.
+ *
+ * The two directions are enabled separately, see enum psp_vc_steer.
+ * %PSP_VC_STEER_RX fills in @req and needs the device to install low
+ * priority steering rules matching on @dst, which take precedence over
+ * the RSS table result - @dst sits in the low bits so that those rules
+ * only need to mask off the bottom 16b of the cookie. %PSP_VC_STEER_TX
+ * fills in @dst and needs nothing from the device, it only helps the
+ * peer.
+ *
+ * The wire is a two party structure, so it is named from the sender's
+ * side, and so are the queue IDs a received packet reports in
+ * psp_skb_ext. The association records the same two IDs from our own
+ * side instead: see psp_assoc.vc_loc and psp_assoc.vc_rem.
+ *
+ * %PSP_VC_QID_NONE means "no queue" and is what both fields hold before
+ * anything has been learned. Reserved bits are 0 on Tx, ignored on Rx.
+ */
+#define PSP_VC_REQ_QID		GENMASK_ULL(47, 32)
+#define PSP_VC_DST_QID		GENMASK_ULL(15, 0)
+
+#define PSP_VC_QID_NONE		0xffff
 
 /**
  * struct psp_dev_config - PSP device configuration
  * @versions: PSP versions enabled on the device
+ * @vc_steer: directions taking part in VC steering, mask of enum psp_vc_steer
  */
 struct psp_dev_config {
 	u32 versions;
+	u32 vc_steer;
 };
 
 /* Max number of devices that can be associated with a single PSP device.
@@ -133,25 +181,51 @@ struct psp_dev_caps {
 	 * Determines the size of struct psp_assoc::drv_data
 	 */
 	u32 assoc_drv_spc;
+
+	/**
+	 * @vc_steer: device can steer received traffic on the VC
+	 * Only gates PSP_VC_STEER_RX, granting a peer's request needs
+	 * nothing from the device.
+	 */
+	bool vc_steer;
 };
 
 #define PSP_MAX_KEY	32
 
-#define PSP_HDR_SIZE	16	/* We don't support optional fields, yet */
+#define PSP_HDR_SIZE	16	/* Fixed part of the PSP header */
+#define PSP_VC_SIZE	8	/* Optional virtualization cookie */
 #define PSP_TRL_SIZE	16	/* AES-GCM/GMAC trailer size */
 
+/* Keep free of padding, the whole struct gets memcmp()ed by GRO */
 struct psp_skb_ext {
 	__be32 spi;
 	u16 dev_id;
 	u8 generation;
 	u8 version;
+	u16 vc_req;	/* Queue the sender asked for, or PSP_VC_QID_NONE */
+	u16 vc_dst;	/* Queue the sender addressed, or PSP_VC_QID_NONE */
 };
 
+static_assert(sizeof(struct psp_skb_ext) == 12,
+	      "struct psp_skb_ext must not contain padding");
+
 struct psp_key_parsed {
 	__be32 spi;
 	u8 key[PSP_MAX_KEY];
 };
 
+/**
+ * enum psp_assoc_flags - flags of struct psp_assoc
+ * @PSP_ASSOC_VC_TX: grant the queue the peer asks for in the cookie
+ * @PSP_ASSOC_VC_RX: ask the peer for a queue in the cookie
+ */
+enum psp_assoc_flags {
+	PSP_ASSOC_VC_TX			= BIT(0),
+	PSP_ASSOC_VC_RX			= BIT(1),
+};
+
+#define PSP_ASSOC_VC_ANY	(PSP_ASSOC_VC_TX | PSP_ASSOC_VC_RX)
+
 struct psp_assoc {
 	struct psp_dev *psd;
 
@@ -159,6 +233,23 @@ struct psp_assoc {
 	u8 generation;
 	u8 version;
 	u8 peer_tx;
+	/* enum psp_assoc_flags. Written under psd->lock, additionally read
+	 * on the Tx fast path without it. A snapshot of the device config
+	 * taken when the association was created, so that the header size,
+	 * and with it the MSS, cannot change under an established
+	 * connection.
+	 */
+	u8 flags;
+
+	/* Queue IDs for the VC, ours and the peer's. @vc_loc is refreshed
+	 * from the Tx queue selection and goes out as the cookie's request,
+	 * @vc_rem is learned from the peer's requests and goes back out as
+	 * the destination. Both are PSP_VC_QID_NONE until something is
+	 * learned. Written without the socket lock, always use
+	 * READ_ONCE()/WRITE_ONCE().
+	 */
+	u16 vc_loc;
+	u16 vc_rem;
 
 	u32 upgrade_seq;
 
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index c5c23a54774e..cd123868aab3 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -18,7 +18,7 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 	       struct psp_dev_caps *psd_caps, void *priv_ptr);
 void psp_dev_unregister(struct psp_dev *psd);
 bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
-			 u8 ver, __be16 sport);
+			 u8 ver, __be16 sport, u64 vc);
 int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv);
 
 /* Kernel-facing API */
@@ -29,6 +29,22 @@ static inline void *psp_assoc_drv_data(struct psp_assoc *pas)
 	return pas->drv_data;
 }
 
+/**
+ * psp_assoc_vc_tx_get() - build the virtualization cookie for an association
+ * @pas: association the packet belongs to
+ *
+ * Return: cookie to place in the PSP header, or 0 if the association does
+ *	   not use VC steering and the header should carry no cookie.
+ */
+static inline u64 psp_assoc_vc_tx_get(const struct psp_assoc *pas)
+{
+	if (likely(!(pas->flags & PSP_ASSOC_VC_ANY)))
+		return 0;
+
+	return FIELD_PREP(PSP_VC_REQ_QID, READ_ONCE(pas->vc_loc)) |
+	       FIELD_PREP(PSP_VC_DST_QID, READ_ONCE(pas->vc_rem));
+}
+
 #if IS_ENABLED(CONFIG_INET_PSP)
 unsigned int psp_key_size(u32 version);
 void psp_sk_assoc_free(struct sock *sk);
@@ -88,6 +104,31 @@ psp_pse_matches_pas(struct psp_skb_ext *pse, struct psp_assoc *pas)
 	       pas->dev_id == pse->dev_id;
 }
 
+/**
+ * psp_assoc_vc_rx_update() - note the queue the peer is asking for
+ * @pas: association the packet arrived on
+ * @pse: PSP info extracted from the packet
+ *
+ * The peer's request becomes the destination in the cookies we send it,
+ * which is what makes its device steer our traffic. Only tracked if we
+ * are going to grant it. Called for every PSP packet, so the common
+ * cases have to be cheap: a peer which sends no cookie leaves @vc_req
+ * at %PSP_VC_QID_NONE, which is also what @vc_rem was initialised to,
+ * so both "no cookie" and "request unchanged" cost a single compare and
+ * no store.
+ */
+static inline void
+psp_assoc_vc_rx_update(struct psp_assoc *pas, const struct psp_skb_ext *pse)
+{
+	if (likely(!(pas->flags & PSP_ASSOC_VC_TX)))
+		return;
+
+	if (likely(pse->vc_req == READ_ONCE(pas->vc_rem)))
+		return;
+
+	WRITE_ONCE(pas->vc_rem, pse->vc_req);
+}
+
 static inline enum skb_drop_reason
 __psp_sk_rx_policy_check(struct sk_buff *skb, struct psp_assoc *pas)
 {
@@ -100,6 +141,8 @@ __psp_sk_rx_policy_check(struct sk_buff *skb, struct psp_assoc *pas)
 		if (unlikely(!pas->peer_tx))
 			pas->peer_tx = 1;
 
+		psp_assoc_vc_rx_update(pas, pse);
+
 		return 0;
 	}
 
@@ -150,9 +193,14 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 static inline unsigned int psp_sk_overhead(const struct sock *sk)
 {
 	int psp_encap = sizeof(struct udphdr) + PSP_HDR_SIZE + PSP_TRL_SIZE;
-	bool has_psp = rcu_access_pointer(sk->psp_assoc);
+	struct psp_assoc *pas = psp_sk_assoc(sk);
 
-	return has_psp ? psp_encap : 0;
+	if (!pas)
+		return 0;
+	if (pas->flags & PSP_ASSOC_VC_ANY)
+		psp_encap += PSP_VC_SIZE;
+
+	return psp_encap;
 }
 #else
 static inline void psp_sk_assoc_free(struct sock *sk) { }
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index 1c8899cd4da5..15e276ea84fb 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -17,6 +17,21 @@ enum psp_version {
 	PSP_VERSION_HDR0_AES_GMAC_256,
 };
 
+/**
+ * enum psp_vc_steer - Directions of traffic which take part in VC based queue
+ *   steering.
+ * @PSP_VC_STEER_TX: Grant the requests peers make, so that traffic this device
+ *   sends is steered at the far end. Costs nothing but the room in the header,
+ *   the queue is the peer's to pick, so this does not need vc-steer-cap.
+ * @PSP_VC_STEER_RX: Ask peers to send to the Rx queue paired with the flow's
+ *   Tx queue, so that traffic this device receives is steered. Needs
+ *   vc-steer-cap, the rules doing the steering are ours.
+ */
+enum psp_vc_steer {
+	PSP_VC_STEER_TX,
+	PSP_VC_STEER_RX,
+};
+
 enum {
 	PSP_A_ASSOC_DEV_INFO_IFINDEX = 1,
 	PSP_A_ASSOC_DEV_INFO_NSID,
@@ -33,6 +48,8 @@ enum {
 	PSP_A_DEV_ASSOC_LIST,
 	PSP_A_DEV_NSID,
 	PSP_A_DEV_BY_ASSOCIATION,
+	PSP_A_DEV_VC_STEER_CAP,
+	PSP_A_DEV_VC_STEER_ENA,
 
 	__PSP_A_DEV_MAX,
 	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index 348fd7a96261..5df17efae127 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -171,7 +171,7 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 		return true;
 
 	/* psp_encap of the packet */
-	if (!psp_dev_encapsulate(net, skb, psp_st->spi, psp_st->ver, 0)) {
+	if (!psp_dev_encapsulate(net, skb, psp_st->spi, psp_st->ver, 0, 0)) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_PSP_OUTPUT);
 		atomic_inc(&priv->psp->tx_drop);
 		return false;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6b3532b5e360..32d95205a8cc 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -44,7 +44,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	}
 
 	net = sock_net(skb->sk);
-	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0)) {
+	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0, 0)) {
 		rc = SKB_DROP_REASON_PSP_OUTPUT;
 		goto out_unlock;
 	}
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 0e426ffac398..743de854aca5 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -23,9 +23,10 @@ static const struct nla_policy psp_dev_get_nl_policy[PSP_A_DEV_ID + 1] = {
 };
 
 /* PSP_CMD_DEV_SET - do */
-static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_PSP_VERSIONS_ENA + 1] = {
+static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_VC_STEER_ENA + 1] = {
 	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
 	[PSP_A_DEV_PSP_VERSIONS_ENA] = NLA_POLICY_MASK(NLA_U32, 0xf),
+	[PSP_A_DEV_VC_STEER_ENA] = NLA_POLICY_MASK(NLA_U32, 0x3),
 };
 
 /* PSP_CMD_KEY_ROTATE - do */
@@ -89,7 +90,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.doit		= psp_nl_dev_set_doit,
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_dev_set_nl_policy,
-		.maxattr	= PSP_A_DEV_PSP_VERSIONS_ENA,
+		.maxattr	= PSP_A_DEV_VC_STEER_ENA,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index c9c1a8826b7f..cf4bb4e44c55 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -186,7 +186,8 @@ unsigned int psp_key_size(u32 version)
 EXPORT_SYMBOL(psp_key_size);
 
 static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
-			      u8 ver, unsigned int udp_len, __be16 sport)
+			      u8 ver, unsigned int udp_len, __be16 sport,
+			      u64 vc)
 {
 	struct udphdr *uh = udp_hdr(skb);
 	struct psphdr *psph = (struct psphdr *)(uh + 1);
@@ -234,54 +235,62 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 	udp_set_len(uh, udp_len);
 
 	psph->nexthdr = IPPROTO_TCP;
-	psph->hdrlen = PSP_HDRLEN_NOOPT;
+	psph->hdrlen = vc ? PSP_HDRLEN_VC : PSP_HDRLEN_NOOPT;
 	psph->crypt_offset = 0;
 	psph->verfl = FIELD_PREP(PSPHDR_VERFL_VERSION, ver) |
+		      FIELD_PREP(PSPHDR_VERFL_VIRT, !!vc) |
 		      FIELD_PREP(PSPHDR_VERFL_ONE, 1);
 	psph->spi = spi;
 	memset(&psph->iv, 0, sizeof(psph->iv));
+	if (vc)
+		psph->vc[0] = cpu_to_be64(vc);
 }
 
 /* Encapsulate a TCP packet with PSP by adding the UDP+PSP headers and filling
- * them in.
+ * them in. @vc is the virtualization cookie to place in the header, 0 for
+ * a header with no optional fields.
  */
 bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
-			 u8 ver, __be16 sport)
+			 u8 ver, __be16 sport, u64 vc)
 {
 	u32 network_len = skb_network_header_len(skb);
 	u32 ethr_len = skb_mac_header_len(skb);
 	u32 bufflen = ethr_len + network_len;
+	u32 encap_len = PSP_ENCAP_HLEN;
 
 	if (skb->protocol != htons(ETH_P_IP) &&
 	    skb->protocol != htons(ETH_P_IPV6))
 		return false;
 
-	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
+	if (vc)
+		encap_len += PSP_VC_SIZE;
+
+	if (skb_cow_head(skb, encap_len))
 		return false;
 
-	skb_push(skb, PSP_ENCAP_HLEN);
-	skb->mac_header		-= PSP_ENCAP_HLEN;
-	skb->network_header	-= PSP_ENCAP_HLEN;
-	skb->transport_header	-= PSP_ENCAP_HLEN;
-	memmove(skb->data, skb->data + PSP_ENCAP_HLEN, bufflen);
+	skb_push(skb, encap_len);
+	skb->mac_header		-= encap_len;
+	skb->network_header	-= encap_len;
+	skb->transport_header	-= encap_len;
+	memmove(skb->data, skb->data + encap_len, bufflen);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
 		ip_hdr(skb)->protocol = IPPROTO_UDP;
-		be16_add_cpu(&ip_hdr(skb)->tot_len, PSP_ENCAP_HLEN);
+		be16_add_cpu(&ip_hdr(skb)->tot_len, encap_len);
 		ip_hdr(skb)->check = 0;
 		ip_hdr(skb)->check =
 			ip_fast_csum((u8 *)ip_hdr(skb), ip_hdr(skb)->ihl);
 	} else {
 		ipv6_hdr(skb)->nexthdr = IPPROTO_UDP;
-		be16_add_cpu(&ipv6_hdr(skb)->payload_len, PSP_ENCAP_HLEN);
+		be16_add_cpu(&ipv6_hdr(skb)->payload_len, encap_len);
 	}
 
 	skb_set_inner_ipproto(skb, IPPROTO_TCP);
 	skb_set_inner_transport_header(skb, skb_transport_offset(skb) +
-						    PSP_ENCAP_HLEN);
+						    encap_len);
 	skb->encapsulation = 1;
 	psp_write_headers(net, skb, spi, ver,
-			  skb->len - skb_transport_offset(skb), sport);
+			  skb->len - skb_transport_offset(skb), sport, vc);
 
 	return true;
 }
@@ -290,9 +299,10 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
 /* Receive handler for PSP packets.
  *
  * Accepts only already-authenticated packets. The full PSP header is
- * stripped according to psph->hdrlen; any optional fields it advertises
- * (virtualization cookies, etc.) are ignored and discarded along with the
- * rest of the header. The caller should ensure that skb->data is pointing
+ * stripped according to psph->hdrlen; the virtualization cookie is recorded
+ * in the skb extension, any other optional fields are ignored and discarded
+ * along with the rest of the header. The caller should ensure that skb->data
+ * is pointing
  * to the mac header, and that skb->mac_len is set. This function does not
  * currently adjust skb->csum (CHECKSUM_COMPLETE is not supported).
  */
@@ -370,6 +380,15 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	pse->dev_id = dev_id;
 	pse->generation = generation;
 	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
+	pse->vc_req = PSP_VC_QID_NONE;
+	pse->vc_dst = PSP_VC_QID_NONE;
+	if (unlikely(psph->verfl & PSPHDR_VERFL_VIRT) &&
+	    psp_hlen >= sizeof(*psph) + PSP_VC_SIZE) {
+		u64 vc = be64_to_cpu(psph->vc[0]);
+
+		pse->vc_req = FIELD_GET(PSP_VC_REQ_QID, vc);
+		pse->vc_dst = FIELD_GET(PSP_VC_DST_QID, vc);
+	}
 
 	encap = sizeof(struct udphdr) + psp_hlen;
 	encap += strip_icv ? PSP_TRL_SIZE : 0;
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index f91665748dde..b5f1bfd8bdcf 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -299,6 +299,11 @@ psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
 	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions))
 		goto err_cancel_msg;
 
+	if (psd->caps->vc_steer && nla_put_flag(rsp, PSP_A_DEV_VC_STEER_CAP))
+		goto err_cancel_msg;
+	if (nla_put_u32(rsp, PSP_A_DEV_VC_STEER_ENA, psd->config.vc_steer))
+		goto err_cancel_msg;
+
 	if (cur_net == dev_net(psd->main_netdev)) {
 		/* Primary device - dump assoc list */
 		err = psp_nl_fill_assoc_dev_list(psd, rsp, cur_net, NULL);
@@ -418,11 +423,25 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
 			NL_SET_ERR_MSG(info->extack, "Requested PSP versions not supported by the device");
 			return -EINVAL;
 		}
-	} else {
+	} else if (!info->attrs[PSP_A_DEV_VC_STEER_ENA]) {
 		NL_SET_ERR_MSG(info->extack, "No settings present");
 		return -EINVAL;
 	}
 
+	if (info->attrs[PSP_A_DEV_VC_STEER_ENA]) {
+		new_config.vc_steer =
+			nla_get_u32(info->attrs[PSP_A_DEV_VC_STEER_ENA]);
+		/* Granting a peer's request is just header generation,
+		 * only steering our own Rx needs the device to help.
+		 */
+		if (new_config.vc_steer & (1 << PSP_VC_STEER_RX) &&
+		    !psd->caps->vc_steer) {
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[PSP_A_DEV_VC_STEER_ENA]);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	rsp = psp_nl_reply_new(info);
 	if (!rsp)
 		return -ENOMEM;
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 1a2a6b7516b0..1594767e5184 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -26,6 +26,32 @@ struct psp_dev *psp_dev_get_for_sock(struct sock *sk)
 	return psd;
 }
 
+/* Refresh the local queue ID we ask the peer to send to.
+ *
+ * Rx and Tx queues are assumed to be paired by index, so the Tx queue the
+ * stack has just picked for this flow doubles as the Rx queue we expect
+ * the flow's replies to land on. This is the Tx side counterpart of an
+ * aRFS update, and runs for every skb of a steered PSP socket, so the
+ * unchanged case has to stay down to a load and a compare.
+ */
+static void psp_assoc_vc_tx_update(struct psp_assoc *pas,
+				   struct net_device *dev,
+				   struct sk_buff *skb)
+{
+	u16 qid = skb_get_queue_mapping(skb);
+
+	/* A device may have more Tx than Rx queues, in which case the top
+	 * Tx queues have no Rx queue to pair with.
+	 */
+	if (unlikely(qid >= READ_ONCE(dev->real_num_rx_queues)))
+		qid = PSP_VC_QID_NONE;
+
+	if (likely(qid == READ_ONCE(pas->vc_loc)))
+		return;
+
+	WRITE_ONCE(pas->vc_loc, qid);
+}
+
 static struct sk_buff *
 psp_validate_xmit(struct sock *sk, struct net_device *dev, struct sk_buff *skb)
 {
@@ -35,6 +61,8 @@ psp_validate_xmit(struct sock *sk, struct net_device *dev, struct sk_buff *skb)
 	rcu_read_lock();
 	pas = psp_skb_get_assoc_rcu(skb);
 	good = !pas || rcu_access_pointer(dev->psp_dev) == pas->psd;
+	if (good && pas && pas->flags & PSP_ASSOC_VC_RX)
+		psp_assoc_vc_tx_update(pas, dev, skb);
 	rcu_read_unlock();
 	if (!good) {
 		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PSP_OUTPUT);
@@ -58,6 +86,13 @@ struct psp_assoc *psp_assoc_create(struct psp_dev *psd)
 	pas->psd = psd;
 	pas->dev_id = psd->id;
 	pas->generation = psd->generation;
+	pas->vc_loc = PSP_VC_QID_NONE;
+	pas->vc_rem = PSP_VC_QID_NONE;
+	/* Snapshot the config, the header size may not change later on */
+	if (psd->config.vc_steer & (1 << PSP_VC_STEER_TX))
+		pas->flags |= PSP_ASSOC_VC_TX;
+	if (psd->config.vc_steer & (1 << PSP_VC_STEER_RX))
+		pas->flags |= PSP_ASSOC_VC_RX;
 	psp_dev_get(psd);
 	refcount_set(&pas->refcnt, 1);
 
-- 
2.55.0

