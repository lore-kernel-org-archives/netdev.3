Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FC4C8C5A;
	Mon, 28 Sep 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622491; cv=none; b=eMXgLwRDaT8ySzHDKds6o+SuVlCJ16hoLeakTksy0PUSMMaITzbUKHTc4F29diKP8OYagxKjOiCZJCefNwPNVYpcc1H1GpGvUy3JTSXjyvEm9NpsZAmTsj3CTSGVDMV2JnWJ9ym3JmCQ8owtsyyLZLGDDV3tTYBfIYwvRbaOHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622491; c=relaxed/simple;
	bh=acKlUaTTheZB4Chpj8cvnK2qMgMNwjQfdm7xLdZh8Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU5UABHhv9dZWxNWWmI33Jk35yNLCyG1dEpsNlaCsbaHRVZCgsbv5/wcd7ghl1obV4Sbyu67IBsF1+CU5EPQbmAiYbcos//KwiX7MOM/VvWZ2850+ky78qlCH1ZU3hWheU/3qeGjWRedd+gYpOEbdpfZVTrSBNA6Z2KMxhU7B0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/gYuX1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/gYuX1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4A31F0089C;
	Mon, 28 Sep 2026 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790622488;
	bh=7eeCUvCKGKfc/gYpW11DjnyAldaY6y2ZaVm2PUzgpxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d/gYuX1sPNr3jOkos4u41S637QkiTcPq25+XcL/xmM65a1Z+sCm7iz33huXz67b/D
	 1Ctm9AWq/MOfMAj/Kl1cFg6hBmnrFJHQjrzmde6SGo/21BINk+HImam9HCzs3Khj5A
	 Q6kUVsPc4MqmRh6aKSDwXlfBAj/cQXZ93h2CcWUUnLLw1JZ5gOmKcRt2KsdzstE1Er
	 LNhOYo20MBvNaA6uyxo0PrUaujVOdxwxl1lHZn+BXTyQYhtw/Or2ImIvjiai7me+Q4
	 joi3Dp5B0sSUhw83dYTTHsF8Vzej9Q2k9pzj4Uh4JpsYzvhf6A3Yw530vXC20jgdZO
	 Y63D+fRv6xYLg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	deller@gmx.de,
	razor@blackwall.org,
	idosch@nvidia.com,
	aconole@redhat.com,
	ardb@kernel.org,
	tim.bird@sony.com,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] llc: strip the leftovers of the llc2 removal
Date: Mon, 28 Sep 2026 12:07:59 -0700
Message-ID: <20260928190800.2521749-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928190800.2521749-1-kuba@kernel.org>
References: <20260928190800.2521749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing in tree registers the type 1 / type 2 packet handlers or the
station handler any more, and nothing looks at the socket hashes
hanging off struct llc_sap. The two SAPs opened in tree - SNAP, and STP
for the bridge's BPDUs and GARP's PDUs - receive through the per-SAP
rcv_func(), so llc_rcv() boils down to a SAP lookup and a call.
llc_sap_list becomes static and five exports go away with all this; the
llc2 module out of tree has been reworked to open its own SAPs.

Frames with a NULL DSAP used to be handed to the station handler
before the SAP lookup. They take the normal path now, meaning they get
dropped unless something registers SAP 0.

struct llc_sap is down to 48 bytes on 64-bit from over a kilobyte,
which also moves its GFP_ATOMIC allocation from kmalloc-2k to
kmalloc-64. The two 64-entry socket hashes are the bulk of it, and the
address it carried is now just the SAP number - nothing has read the
MAC half since the socket layer left.

llc_pdu.h keeps only what its remaining users need, plus LLC_PDU_RSP to
document the one argument which can take it. That takes out the type 2
(I and S format, FRMR) definitions, the XID and TEST builders with
their constants - the kernel neither sends nor answers either any more
- the SAP address defines, the field accessors, and the prototypes of
the llc_pdu.c helpers which went out of tree with the rest of LLC2.
With the I and S formats gone llc_pdu_header_init() has one PDU type
left, so drop the argument.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/llc.h        |  82 +--------
 include/net/llc_pdu.h    | 379 +--------------------------------------
 net/802/garp.c           |   4 +-
 net/802/psnap.c          |   2 +-
 net/bridge/br_stp_bpdu.c |   3 +-
 net/llc/llc_core.c       |  25 +--
 net/llc/llc_input.c      | 125 +------------
 net/llc/llc_output.c     |   3 +-
 8 files changed, 32 insertions(+), 591 deletions(-)

diff --git a/include/net/llc.h b/include/net/llc.h
index 8ea44ed98c4d..ce7db08e8355 100644
--- a/include/net/llc.h
+++ b/include/net/llc.h
@@ -6,112 +6,44 @@
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 
-#include <linux/if.h>
-#include <linux/if_ether.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/rculist_nulls.h>
-#include <linux/hash.h>
-#include <linux/jhash.h>
-
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 
 struct net_device;
 struct packet_type;
 struct sk_buff;
 
-struct llc_addr {
-	unsigned char lsap;
-	unsigned char mac[IFHWADDRLEN];
-};
-
-#define LLC_SAP_STATE_INACTIVE	1
-#define LLC_SAP_STATE_ACTIVE	2
-
-#define LLC_SK_DEV_HASH_BITS 6
-#define LLC_SK_DEV_HASH_ENTRIES (1<<LLC_SK_DEV_HASH_BITS)
-
-#define LLC_SK_LADDR_HASH_BITS 6
-#define LLC_SK_LADDR_HASH_ENTRIES (1<<LLC_SK_LADDR_HASH_BITS)
-
 /**
  * struct llc_sap - Defines the SAP component
  *
- * @station - station this sap belongs to
- * @state - sap state
- * @p_bit - only lowest-order bit used
- * @f_bit - only lowest-order bit used
- * @laddr - SAP value in this 'lsap'
- * @node - entry in station sap_list
- * @sk_list - LLC sockets this one manages
+ * @refcnt: reference count
+ * @lsap: SAP number
+ * @rcv_func: handler for the PDUs addressed to this SAP
+ * @node: entry in the SAP list
+ * @rcu: for deferred freeing
  */
 struct llc_sap {
-	unsigned char	 state;
-	unsigned char	 p_bit;
-	unsigned char	 f_bit;
 	refcount_t		 refcnt;
+	unsigned char	 lsap;
 	int		 (*rcv_func)(struct sk_buff *skb,
 				     struct net_device *dev,
 				     struct packet_type *pt,
 				     struct net_device *orig_dev);
-	struct llc_addr	 laddr;
 	struct list_head node;
-	spinlock_t sk_lock;
-	int sk_count;
-	struct hlist_nulls_head sk_laddr_hash[LLC_SK_LADDR_HASH_ENTRIES];
-	struct hlist_head sk_dev_hash[LLC_SK_DEV_HASH_ENTRIES];
 	struct rcu_head rcu;
 };
 
-static inline
-struct hlist_head *llc_sk_dev_hash(struct llc_sap *sap, int ifindex)
-{
-	u32 bucket = hash_32(ifindex, LLC_SK_DEV_HASH_BITS);
-
-	return &sap->sk_dev_hash[bucket];
-}
-
-static inline
-u32 llc_sk_laddr_hashfn(struct llc_sap *sap, const struct llc_addr *laddr)
-{
-	return hash_32(jhash(laddr->mac, sizeof(laddr->mac), 0),
-		       LLC_SK_LADDR_HASH_BITS);
-}
-
-static inline
-struct hlist_nulls_head *llc_sk_laddr_hash(struct llc_sap *sap,
-					   const struct llc_addr *laddr)
-{
-	return &sap->sk_laddr_hash[llc_sk_laddr_hashfn(sap, laddr)];
-}
-
-#define LLC_DEST_INVALID         0      /* Invalid LLC PDU type */
-#define LLC_DEST_SAP             1      /* Type 1 goes here */
-#define LLC_DEST_CONN            2      /* Type 2 goes here */
-
-extern struct list_head llc_sap_list;
-
 int llc_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt,
 	    struct net_device *orig_dev);
 
 int llc_mac_hdr_init(struct sk_buff *skb, const unsigned char *sa,
 		     const unsigned char *da);
 
-void llc_add_pack(int type,
-		  void (*handler)(struct llc_sap *sap, struct sk_buff *skb));
-void llc_remove_pack(int type);
-
-void llc_set_station_handler(void (*handler)(struct sk_buff *skb));
-
 struct llc_sap *llc_sap_open(unsigned char lsap,
 			     int (*rcv)(struct sk_buff *skb,
 					struct net_device *dev,
 					struct packet_type *pt,
 					struct net_device *orig_dev));
-static inline void llc_sap_hold(struct llc_sap *sap)
-{
-	refcount_inc(&sap->refcnt);
-}
 
 static inline bool llc_sap_hold_safe(struct llc_sap *sap)
 {
diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index f165237a3723..14c76b0d9832 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -6,201 +6,17 @@
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 
-#include <linux/if_ether.h>
-
-/* Lengths of frame formats */
-#define LLC_PDU_LEN_I		4       /* header and 2 control bytes */
-#define LLC_PDU_LEN_S		4
-#define LLC_PDU_LEN_U		3       /* header and 1 control byte */
-/* header and 1 control byte and XID info */
-#define LLC_PDU_LEN_U_XID	(LLC_PDU_LEN_U + sizeof(struct llc_xid_info))
-/* Known SAP addresses */
-#define LLC_GLOBAL_SAP	0xFF
-#define LLC_NULL_SAP	0x00	/* not network-layer visible */
-#define LLC_MGMT_INDIV	0x02	/* station LLC mgmt indiv addr */
-#define LLC_MGMT_GRP	0x03	/* station LLC mgmt group addr */
-#define LLC_RDE_SAP	0xA6	/* route ... */
-
-/* SAP field bit masks */
-#define LLC_ISO_RESERVED_SAP	0x02
-#define LLC_SAP_GROUP_DSAP	0x01
-#define LLC_SAP_RESP_SSAP	0x01
-
-/* Group/individual DSAP indicator is DSAP field */
-#define LLC_PDU_GROUP_DSAP_MASK    0x01
-#define LLC_PDU_IS_GROUP_DSAP(pdu)      \
-	((pdu->dsap & LLC_PDU_GROUP_DSAP_MASK) ? 0 : 1)
-#define LLC_PDU_IS_INDIV_DSAP(pdu)      \
-	(!(pdu->dsap & LLC_PDU_GROUP_DSAP_MASK) ? 0 : 1)
+#include <linux/skbuff.h>
 
 /* Command/response PDU indicator in SSAP field */
-#define LLC_PDU_CMD_RSP_MASK	0x01
 #define LLC_PDU_CMD		0
 #define LLC_PDU_RSP		1
-#define LLC_PDU_IS_CMD(pdu)    ((pdu->ssap & LLC_PDU_RSP) ? 0 : 1)
-#define LLC_PDU_IS_RSP(pdu)    ((pdu->ssap & LLC_PDU_RSP) ? 1 : 0)
 
 /* Get PDU type from 2 lowest-order bits of control field first byte */
-#define LLC_PDU_TYPE_I_MASK    0x01	/* 16-bit control field */
-#define LLC_PDU_TYPE_S_MASK    0x03
-#define LLC_PDU_TYPE_U_MASK    0x03	/* 8-bit control field */
 #define LLC_PDU_TYPE_MASK      0x03
-
-#define LLC_PDU_TYPE_I		0	/* first bit */
-#define LLC_PDU_TYPE_S		1	/* first two bits */
 #define LLC_PDU_TYPE_U		3	/* first two bits */
-#define LLC_PDU_TYPE_U_XID	4	/* private type for detecting XID commands */
-
-#define LLC_PDU_TYPE_IS_I(pdu) \
-	((!(pdu->ctrl_1 & LLC_PDU_TYPE_I_MASK)) ? 1 : 0)
-
-#define LLC_PDU_TYPE_IS_U(pdu) \
-	(((pdu->ctrl_1 & LLC_PDU_TYPE_U_MASK) == LLC_PDU_TYPE_U) ? 1 : 0)
-
-#define LLC_PDU_TYPE_IS_S(pdu) \
-	(((pdu->ctrl_1 & LLC_PDU_TYPE_S_MASK) == LLC_PDU_TYPE_S) ? 1 : 0)
-
-/* U-format PDU control field masks */
-#define LLC_U_PF_BIT_MASK      0x10	/* P/F bit mask */
-#define LLC_U_PF_IS_1(pdu)     ((pdu->ctrl_1 & LLC_U_PF_BIT_MASK) ? 1 : 0)
-#define LLC_U_PF_IS_0(pdu)     ((!(pdu->ctrl_1 & LLC_U_PF_BIT_MASK)) ? 1 : 0)
-
-#define LLC_U_PDU_CMD_MASK     0xEC	/* cmd/rsp mask */
-#define LLC_U_PDU_CMD(pdu)     (pdu->ctrl_1 & LLC_U_PDU_CMD_MASK)
-#define LLC_U_PDU_RSP(pdu)     (pdu->ctrl_1 & LLC_U_PDU_CMD_MASK)
 
 #define LLC_1_PDU_CMD_UI       0x00	/* Type 1 cmds/rsps */
-#define LLC_1_PDU_CMD_XID      0xAC
-#define LLC_1_PDU_CMD_TEST     0xE0
-
-#define LLC_2_PDU_CMD_SABME    0x6C	/* Type 2 cmds/rsps */
-#define LLC_2_PDU_CMD_DISC     0x40
-#define LLC_2_PDU_RSP_UA       0x60
-#define LLC_2_PDU_RSP_DM       0x0C
-#define LLC_2_PDU_RSP_FRMR     0x84
-
-/* Type 1 operations */
-
-/* XID information field bit masks */
-
-/* LLC format identifier (byte 1) */
-#define LLC_XID_FMT_ID		0x81	/* first byte must be this */
-
-/* LLC types/classes identifier (byte 2) */
-#define LLC_XID_CLASS_ZEROS_MASK	0xE0	/* these must be zeros */
-#define LLC_XID_CLASS_MASK		0x1F	/* AND with byte to get below */
-
-#define LLC_XID_NULL_CLASS_1	0x01	/* if NULL LSAP...use these */
-#define LLC_XID_NULL_CLASS_2	0x03
-#define LLC_XID_NULL_CLASS_3	0x05
-#define LLC_XID_NULL_CLASS_4	0x07
-
-#define LLC_XID_NNULL_TYPE_1	0x01	/* if non-NULL LSAP...use these */
-#define LLC_XID_NNULL_TYPE_2	0x02
-#define LLC_XID_NNULL_TYPE_3	0x04
-#define LLC_XID_NNULL_TYPE_1_2	0x03
-#define LLC_XID_NNULL_TYPE_1_3	0x05
-#define LLC_XID_NNULL_TYPE_2_3	0x06
-#define LLC_XID_NNULL_ALL		0x07
-
-/* Sender Receive Window (byte 3) */
-#define LLC_XID_RW_MASK	0xFE	/* AND with value to get below */
-
-#define LLC_XID_MIN_RW	0x02	/* lowest-order bit always zero */
-
-/* Type 2 operations */
-
-#define LLC_2_SEQ_NBR_MODULO   ((u8) 128)
-
-/* I-PDU masks ('ctrl' is I-PDU control word) */
-#define LLC_I_GET_NS(pdu)     (u8)((pdu->ctrl_1 & 0xFE) >> 1)
-#define LLC_I_GET_NR(pdu)     (u8)((pdu->ctrl_2 & 0xFE) >> 1)
-
-#define LLC_I_PF_BIT_MASK      0x01
-
-#define LLC_I_PF_IS_0(pdu)     ((!(pdu->ctrl_2 & LLC_I_PF_BIT_MASK)) ? 1 : 0)
-#define LLC_I_PF_IS_1(pdu)     ((pdu->ctrl_2 & LLC_I_PF_BIT_MASK) ? 1 : 0)
-
-/* S-PDU supervisory commands and responses */
-
-#define LLC_S_PDU_CMD_MASK     0x0C
-#define LLC_S_PDU_CMD(pdu)     (pdu->ctrl_1 & LLC_S_PDU_CMD_MASK)
-#define LLC_S_PDU_RSP(pdu)     (pdu->ctrl_1 & LLC_S_PDU_CMD_MASK)
-
-#define LLC_2_PDU_CMD_RR       0x00	/* rx ready cmd */
-#define LLC_2_PDU_RSP_RR       0x00	/* rx ready rsp */
-#define LLC_2_PDU_CMD_REJ      0x08	/* reject PDU cmd */
-#define LLC_2_PDU_RSP_REJ      0x08	/* reject PDU rsp */
-#define LLC_2_PDU_CMD_RNR      0x04	/* rx not ready cmd */
-#define LLC_2_PDU_RSP_RNR      0x04	/* rx not ready rsp */
-
-#define LLC_S_PF_BIT_MASK      0x01
-#define LLC_S_PF_IS_0(pdu)     ((!(pdu->ctrl_2 & LLC_S_PF_BIT_MASK)) ? 1 : 0)
-#define LLC_S_PF_IS_1(pdu)     ((pdu->ctrl_2 & LLC_S_PF_BIT_MASK) ? 1 : 0)
-
-#define PDU_SUPV_GET_Nr(pdu)   ((pdu->ctrl_2 & 0xFE) >> 1)
-#define PDU_GET_NEXT_Vr(sn)    (((sn) + 1) & ~LLC_2_SEQ_NBR_MODULO)
-
-/* FRMR information field macros */
-
-#define FRMR_INFO_LENGTH       5	/* 5 bytes of information */
-
-/*
- * info is pointer to FRMR info field structure; 'rej_ctrl' is byte pointer
- * (if U-PDU) or word pointer to rejected PDU control field
- */
-#define FRMR_INFO_SET_REJ_CNTRL(info,rej_ctrl) \
-	info->rej_pdu_ctrl = ((*((u8 *) rej_ctrl) & \
-				LLC_PDU_TYPE_U) != LLC_PDU_TYPE_U ? \
-				(u16)*((u16 *) rej_ctrl) : \
-				(((u16) *((u8 *) rej_ctrl)) & 0x00FF))
-
-/*
- * Info is pointer to FRMR info field structure; 'vs' is a byte containing
- * send state variable value in low-order 7 bits (insure the lowest-order
- * bit remains zero (0))
- */
-#define FRMR_INFO_SET_Vs(info,vs) (info->curr_ssv = (((u8) vs) << 1))
-#define FRMR_INFO_SET_Vr(info,vr) (info->curr_rsv = (((u8) vr) << 1))
-
-/*
- * Info is pointer to FRMR info field structure; 'cr' is a byte containing
- * the C/R bit value in the low-order bit
- */
-#define FRMR_INFO_SET_C_R_BIT(info, cr)  (info->curr_rsv |= (((u8) cr) & 0x01))
-
-/*
- * In the remaining five macros, 'info' is pointer to FRMR info field
- * structure; 'ind' is a byte containing the bit value to set in the
- * lowest-order bit)
- */
-#define FRMR_INFO_SET_INVALID_PDU_CTRL_IND(info, ind) \
-       (info->ind_bits = ((info->ind_bits & 0xFE) | (((u8) ind) & 0x01)))
-
-#define FRMR_INFO_SET_INVALID_PDU_INFO_IND(info, ind) \
-       (info->ind_bits = ( (info->ind_bits & 0xFD) | (((u8) ind) & 0x02)))
-
-#define FRMR_INFO_SET_PDU_INFO_2LONG_IND(info, ind) \
-       (info->ind_bits = ( (info->ind_bits & 0xFB) | (((u8) ind) & 0x04)))
-
-#define FRMR_INFO_SET_PDU_INVALID_Nr_IND(info, ind) \
-       (info->ind_bits = ( (info->ind_bits & 0xF7) | (((u8) ind) & 0x08)))
-
-#define FRMR_INFO_SET_PDU_INVALID_Ns_IND(info, ind) \
-       (info->ind_bits = ( (info->ind_bits & 0xEF) | (((u8) ind) & 0x10)))
-
-/* Sequence-numbered PDU format (4 bytes in length) */
-struct llc_pdu_sn {
-	u8 dsap;
-	u8 ssap;
-	u8 ctrl_1;
-	u8 ctrl_2;
-} __packed;
-
-static inline struct llc_pdu_sn *llc_pdu_sn_hdr(struct sk_buff *skb)
-{
-	return (struct llc_pdu_sn *)skb_network_header(skb);
-}
 
 /* Un-numbered PDU format (3 bytes in length) */
 struct llc_pdu_un {
@@ -217,29 +33,18 @@ static inline struct llc_pdu_un *llc_pdu_un_hdr(struct sk_buff *skb)
 /**
  *	llc_pdu_header_init - initializes pdu header
  *	@skb: input skb that header must be set into it.
- *	@type: type of PDU (U, I or S).
  *	@ssap: source sap.
  *	@dsap: destination sap.
- *	@cr: command/response bit (0 or 1).
+ *	@cr: command/response bit (%LLC_PDU_CMD or %LLC_PDU_RSP).
  *
  *	This function sets DSAP, SSAP and command/Response bit in LLC header.
  */
-static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
-				       u8 ssap, u8 dsap, u8 cr)
+static inline void llc_pdu_header_init(struct sk_buff *skb, u8 ssap, u8 dsap,
+				       u8 cr)
 {
-	int hlen = 4; /* default value for I and S types */
 	struct llc_pdu_un *pdu;
 
-	switch (type) {
-	case LLC_PDU_TYPE_U:
-		hlen = 3;
-		break;
-	case LLC_PDU_TYPE_U_XID:
-		hlen = 6;
-		break;
-	}
-
-	skb_push(skb, hlen);
+	skb_push(skb, sizeof(*pdu));
 	skb_reset_network_header(skb);
 	pdu = llc_pdu_un_hdr(skb);
 	pdu->dsap = dsap;
@@ -247,56 +52,6 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
 	pdu->ssap |= cr;
 }
 
-/**
- *	llc_pdu_decode_sa - extracts, source address (MAC) of input frame
- *	@skb: input skb that source address must be extracted from it.
- *	@sa: pointer to source address (6 byte array).
- *
- *	This function extracts source address(MAC) of input frame.
- */
-static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
-{
-	memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
-}
-
-/**
- *	llc_pdu_decode_da - extracts dest address of input frame
- *	@skb: input skb that destination address must be extracted from it
- *	@da: pointer to destination address (6 byte array).
- *
- *	This function extracts destination address(MAC) of input frame.
- */
-static inline void llc_pdu_decode_da(struct sk_buff *skb, u8 *da)
-{
-	memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
-}
-
-/**
- *	llc_pdu_decode_ssap - extracts source SAP of input frame
- *	@skb: input skb that source SAP must be extracted from it.
- *	@ssap: source SAP (output argument).
- *
- *	This function extracts source SAP of input frame. Right bit of SSAP is
- *	command/response bit.
- */
-static inline void llc_pdu_decode_ssap(struct sk_buff *skb, u8 *ssap)
-{
-	*ssap = llc_pdu_un_hdr(skb)->ssap & 0xFE;
-}
-
-/**
- *	llc_pdu_decode_dsap - extracts dest SAP of input frame
- *	@skb: input skb that destination SAP must be extracted from it.
- *	@dsap: destination SAP (output argument).
- *
- *	This function extracts destination SAP of input frame. right bit of
- *	DSAP designates individual/group SAP.
- */
-static inline void llc_pdu_decode_dsap(struct sk_buff *skb, u8 *dsap)
-{
-	*dsap = llc_pdu_un_hdr(skb)->dsap & 0xFE;
-}
-
 /**
  *	llc_pdu_init_as_ui_cmd - sets LLC header as UI PDU
  *	@skb: input skb that header must be set into it.
@@ -311,128 +66,4 @@ static inline void llc_pdu_init_as_ui_cmd(struct sk_buff *skb)
 	pdu->ctrl_1 |= LLC_1_PDU_CMD_UI;
 }
 
-/**
- *	llc_pdu_init_as_test_cmd - sets PDU as TEST
- *	@skb: Address of the skb to build
- *
- * 	Sets a PDU as TEST
- */
-static inline void llc_pdu_init_as_test_cmd(struct sk_buff *skb)
-{
-	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
-
-	pdu->ctrl_1  = LLC_PDU_TYPE_U;
-	pdu->ctrl_1 |= LLC_1_PDU_CMD_TEST;
-	pdu->ctrl_1 |= LLC_U_PF_BIT_MASK;
-}
-
-/**
- *	llc_pdu_init_as_test_rsp - build TEST response PDU
- *	@skb: Address of the skb to build
- *	@ev_skb: The received TEST command PDU frame
- *
- *	Builds a pdu frame as a TEST response.
- */
-static inline void llc_pdu_init_as_test_rsp(struct sk_buff *skb,
-					    struct sk_buff *ev_skb)
-{
-	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
-
-	pdu->ctrl_1  = LLC_PDU_TYPE_U;
-	pdu->ctrl_1 |= LLC_1_PDU_CMD_TEST;
-	pdu->ctrl_1 |= LLC_U_PF_BIT_MASK;
-	if (ev_skb->protocol == htons(ETH_P_802_2)) {
-		struct llc_pdu_un *ev_pdu = llc_pdu_un_hdr(ev_skb);
-		int dsize;
-
-		dsize = ntohs(eth_hdr(ev_skb)->h_proto) - 3;
-		memcpy(((u8 *)pdu) + 3, ((u8 *)ev_pdu) + 3, dsize);
-		skb_put(skb, dsize);
-	}
-}
-
-/* LLC Type 1 XID command/response information fields format */
-struct llc_xid_info {
-	u8 fmt_id;	/* always 0x81 for LLC */
-	u8 type;	/* different if NULL/non-NULL LSAP */
-	u8 rw;		/* sender receive window */
-} __packed;
-
-/**
- *	llc_pdu_init_as_xid_cmd - sets bytes 3, 4 & 5 of LLC header as XID
- *	@skb: input skb that header must be set into it.
- *	@svcs_supported: The class of the LLC (I or II)
- *	@rx_window: The size of the receive window of the LLC
- *
- *	This function sets third,fourth,fifth and sixth bytes of LLC header as
- *	a XID PDU.
- */
-static inline void llc_pdu_init_as_xid_cmd(struct sk_buff *skb,
-					   u8 svcs_supported, u8 rx_window)
-{
-	struct llc_xid_info *xid_info;
-	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
-
-	pdu->ctrl_1	 = LLC_PDU_TYPE_U;
-	pdu->ctrl_1	|= LLC_1_PDU_CMD_XID;
-	pdu->ctrl_1	|= LLC_U_PF_BIT_MASK;
-	xid_info	 = (struct llc_xid_info *)(((u8 *)&pdu->ctrl_1) + 1);
-	xid_info->fmt_id = LLC_XID_FMT_ID;	/* 0x81 */
-	xid_info->type	 = svcs_supported;
-	xid_info->rw	 = rx_window << 1;	/* size of receive window */
-
-	/* no need to push/put since llc_pdu_header_init() has already
-	 * pushed 3 + 3 bytes
-	 */
-}
-
-/**
- *	llc_pdu_init_as_xid_rsp - builds XID response PDU
- *	@skb: Address of the skb to build
- *	@svcs_supported: The class of the LLC (I or II)
- *	@rx_window: The size of the receive window of the LLC
- *
- *	Builds a pdu frame as an XID response.
- */
-static inline void llc_pdu_init_as_xid_rsp(struct sk_buff *skb,
-					   u8 svcs_supported, u8 rx_window)
-{
-	struct llc_xid_info *xid_info;
-	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
-
-	pdu->ctrl_1	 = LLC_PDU_TYPE_U;
-	pdu->ctrl_1	|= LLC_1_PDU_CMD_XID;
-	pdu->ctrl_1	|= LLC_U_PF_BIT_MASK;
-
-	xid_info	 = (struct llc_xid_info *)(((u8 *)&pdu->ctrl_1) + 1);
-	xid_info->fmt_id = LLC_XID_FMT_ID;
-	xid_info->type	 = svcs_supported;
-	xid_info->rw	 = rx_window << 1;
-	skb_put(skb, sizeof(struct llc_xid_info));
-}
-
-/* LLC Type 2 FRMR response information field format */
-struct llc_frmr_info {
-	u16 rej_pdu_ctrl;	/* bits 1-8 if U-PDU */
-	u8  curr_ssv;		/* current send state variable val */
-	u8  curr_rsv;		/* current receive state variable */
-	u8  ind_bits;		/* indicator bits set with macro */
-} __packed;
-
-void llc_pdu_set_cmd_rsp(struct sk_buff *skb, u8 type);
-void llc_pdu_set_pf_bit(struct sk_buff *skb, u8 bit_value);
-void llc_pdu_decode_pf_bit(struct sk_buff *skb, u8 *pf_bit);
-void llc_pdu_init_as_disc_cmd(struct sk_buff *skb, u8 p_bit);
-void llc_pdu_init_as_i_cmd(struct sk_buff *skb, u8 p_bit, u8 ns, u8 nr);
-void llc_pdu_init_as_rej_cmd(struct sk_buff *skb, u8 p_bit, u8 nr);
-void llc_pdu_init_as_rnr_cmd(struct sk_buff *skb, u8 p_bit, u8 nr);
-void llc_pdu_init_as_rr_cmd(struct sk_buff *skb, u8 p_bit, u8 nr);
-void llc_pdu_init_as_sabme_cmd(struct sk_buff *skb, u8 p_bit);
-void llc_pdu_init_as_dm_rsp(struct sk_buff *skb, u8 f_bit);
-void llc_pdu_init_as_frmr_rsp(struct sk_buff *skb, struct llc_pdu_sn *prev_pdu,
-			      u8 f_bit, u8 vs, u8 vr, u8 vzyxw);
-void llc_pdu_init_as_rr_rsp(struct sk_buff *skb, u8 f_bit, u8 nr);
-void llc_pdu_init_as_rej_rsp(struct sk_buff *skb, u8 f_bit, u8 nr);
-void llc_pdu_init_as_rnr_rsp(struct sk_buff *skb, u8 f_bit, u8 nr);
-void llc_pdu_init_as_ua_rsp(struct sk_buff *skb, u8 f_bit);
 #endif /* LLC_PDU_H */
diff --git a/net/802/garp.c b/net/802/garp.c
index 56b934ec1aae..de6b96bd425a 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -255,8 +255,8 @@ static void garp_pdu_queue(struct garp_applicant *app)
 	garp_pdu_append_end_mark(app);
 	garp_pdu_append_end_mark(app);
 
-	llc_pdu_header_init(app->pdu, LLC_PDU_TYPE_U, LLC_SAP_BSPAN,
-			    LLC_SAP_BSPAN, LLC_PDU_CMD);
+	llc_pdu_header_init(app->pdu, LLC_SAP_BSPAN, LLC_SAP_BSPAN,
+			    LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(app->pdu);
 	llc_mac_hdr_init(app->pdu, app->dev->dev_addr,
 			 app->app->proto.group_address);
diff --git a/net/802/psnap.c b/net/802/psnap.c
index 8ae835e1cbae..c776c5f0041f 100644
--- a/net/802/psnap.c
+++ b/net/802/psnap.c
@@ -82,7 +82,7 @@ static int snap_request(struct datalink_proto *dl,
 			struct sk_buff *skb, const u8 *dest)
 {
 	memcpy(skb_push(skb, 5), dl->type, 5);
-	llc_build_and_send_ui_pkt(snap_sap, skb, dest, snap_sap->laddr.lsap);
+	llc_build_and_send_ui_pkt(snap_sap, skb, dest, snap_sap->lsap);
 	return 0;
 }
 
diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 21d092f5acbb..6cb2526c38f8 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -48,8 +48,7 @@ static void br_send_bpdu(struct net_bridge_port *p,
 	skb_reserve(skb, LLC_RESERVE);
 	__skb_put_data(skb, data, length);
 
-	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, LLC_SAP_BSPAN,
-			    LLC_SAP_BSPAN, LLC_PDU_CMD);
+	llc_pdu_header_init(skb, LLC_SAP_BSPAN, LLC_SAP_BSPAN, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
 
 	if (llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr)) {
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 5b0f1986bddc..cde6a0b1509e 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -16,7 +16,7 @@
 #include <net/net_namespace.h>
 #include <net/llc.h>
 
-LIST_HEAD(llc_sap_list);
+static LIST_HEAD(llc_sap_list);
 static DEFINE_SPINLOCK(llc_sap_list_lock);
 
 /**
@@ -27,16 +27,9 @@ static DEFINE_SPINLOCK(llc_sap_list_lock);
 static struct llc_sap *llc_sap_alloc(void)
 {
 	struct llc_sap *sap = kzalloc_obj(*sap, GFP_ATOMIC);
-	int i;
 
-	if (sap) {
-		/* sap->laddr.mac - leave as a null, it's filled by bind */
-		sap->state = LLC_SAP_STATE_ACTIVE;
-		spin_lock_init(&sap->sk_lock);
-		for (i = 0; i < LLC_SK_LADDR_HASH_ENTRIES; i++)
-			INIT_HLIST_NULLS_HEAD(&sap->sk_laddr_hash[i], i);
+	if (sap)
 		refcount_set(&sap->refcnt, 1);
-	}
 	return sap;
 }
 
@@ -45,7 +38,7 @@ static struct llc_sap *__llc_sap_find(unsigned char sap_value)
 	struct llc_sap *sap;
 
 	list_for_each_entry(sap, &llc_sap_list, node)
-		if (sap->laddr.lsap == sap_value)
+		if (sap->lsap == sap_value)
 			goto out;
 	sap = NULL;
 out:
@@ -53,10 +46,9 @@ static struct llc_sap *__llc_sap_find(unsigned char sap_value)
 }
 
 /**
- *	llc_sap_find - searches a SAP in station
+ *	llc_sap_find - searches for a SAP by its number
  *	@sap_value: sap to be found
  *
- *	Searches for a sap in the sap list of the LLC's station upon the sap ID.
  *	If the sap is found it will be refcounted and the user will have to do
  *	a llc_sap_put after use.
  *	Returns the sap or %NULL if not found.
@@ -96,7 +88,7 @@ struct llc_sap *llc_sap_open(unsigned char lsap,
 	sap = llc_sap_alloc();
 	if (!sap)
 		goto out;
-	sap->laddr.lsap = lsap;
+	sap->lsap	= lsap;
 	sap->rcv_func	= func;
 	list_add_tail_rcu(&sap->node, &llc_sap_list);
 out:
@@ -110,13 +102,10 @@ struct llc_sap *llc_sap_open(unsigned char lsap,
  *
  *	Close interface function to upper layer. Each one who wants to
  *	close an open SAP (for example NetBEUI) should call this function.
- * 	Removes this sap from the list of saps in the station and then
- * 	frees the memory for this sap.
+ *	Removes this sap from the SAP list and then frees the memory for it.
  */
 void llc_sap_close(struct llc_sap *sap)
 {
-	WARN_ON(sap->sk_count);
-
 	spin_lock_bh(&llc_sap_list_lock);
 	list_del_rcu(&sap->node);
 	spin_unlock_bh(&llc_sap_list_lock);
@@ -143,8 +132,6 @@ static void __exit llc_exit(void)
 module_init(llc_init);
 module_exit(llc_exit);
 
-EXPORT_SYMBOL(llc_sap_list);
-EXPORT_SYMBOL(llc_sap_find);
 EXPORT_SYMBOL(llc_sap_open);
 EXPORT_SYMBOL(llc_sap_close);
 
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 78426ae7c73f..a8730c54b5c2 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -7,7 +7,6 @@
  */
 #include <linux/netdevice.h>
 #include <linux/slab.h>
-#include <linux/export.h>
 #include <net/net_namespace.h>
 #include <net/llc.h>
 #include <net/llc_pdu.h>
@@ -18,80 +17,6 @@
 #define dprintk(args...)
 #endif
 
-/*
- * Packet handler for the station, registerable because in the minimal
- * LLC core that is taking shape only the very minimal subset of LLC that
- * is needed for things like IPX, Appletalk, etc will stay, with all the
- * rest in the llc1 and llc2 modules.
- */
-static void (*llc_station_handler)(struct sk_buff *skb);
-
-/*
- * Packet handlers for LLC_DEST_SAP and LLC_DEST_CONN.
- */
-static void (*llc_type_handlers[2])(struct llc_sap *sap,
-				    struct sk_buff *skb);
-
-void llc_add_pack(int type, void (*handler)(struct llc_sap *sap,
-					    struct sk_buff *skb))
-{
-	smp_wmb(); /* ensure initialisation is complete before it's called */
-	if (type == LLC_DEST_SAP || type == LLC_DEST_CONN)
-		llc_type_handlers[type - 1] = handler;
-}
-
-void llc_remove_pack(int type)
-{
-	if (type == LLC_DEST_SAP || type == LLC_DEST_CONN)
-		llc_type_handlers[type - 1] = NULL;
-	synchronize_net();
-}
-
-void llc_set_station_handler(void (*handler)(struct sk_buff *skb))
-{
-	/* Ensure initialisation is complete before it's called */
-	if (handler)
-		smp_wmb();
-
-	llc_station_handler = handler;
-
-	if (!handler)
-		synchronize_net();
-}
-
-/**
- *	llc_pdu_type - returns which LLC component must handle for PDU
- *	@skb: input skb
- *
- *	This function returns which LLC component must handle this PDU.
- */
-static __inline__ int llc_pdu_type(struct sk_buff *skb)
-{
-	int type = LLC_DEST_CONN; /* I-PDU or S-PDU type */
-	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
-
-	if ((pdu->ctrl_1 & LLC_PDU_TYPE_MASK) != LLC_PDU_TYPE_U)
-		goto out;
-	switch (LLC_U_PDU_CMD(pdu)) {
-	case LLC_1_PDU_CMD_XID:
-	case LLC_1_PDU_CMD_UI:
-	case LLC_1_PDU_CMD_TEST:
-		type = LLC_DEST_SAP;
-		break;
-	case LLC_2_PDU_CMD_SABME:
-	case LLC_2_PDU_CMD_DISC:
-	case LLC_2_PDU_RSP_UA:
-	case LLC_2_PDU_RSP_DM:
-	case LLC_2_PDU_RSP_FRMR:
-		break;
-	default:
-		type = LLC_DEST_INVALID;
-		break;
-	}
-out:
-	return type;
-}
-
 /**
  *	llc_fixup_skb - initializes skb pointers
  *	@skb: This argument points to incoming skb
@@ -146,21 +71,16 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
  *	@orig_dev: the original receive net device
  *
  *	When the system receives a 802.2 frame this function is called. It
- *	checks SAP and connection of received pdu and passes frame to
- *	llc_{station,sap,conn}_rcv for sending to proper state machine. If
- *	the frame is related to a busy connection (a connection is sending
- *	data now), it queues this frame in the connection's backlog.
+ *	looks up the SAP the pdu is addressed to and passes the frame to its
+ *	handler, dropping it if the SAP is unknown or has no handler.
  */
 int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	    struct packet_type *pt, struct net_device *orig_dev)
 {
-	struct llc_sap *sap;
-	struct llc_pdu_sn *pdu;
-	int dest;
 	int (*rcv)(struct sk_buff *, struct net_device *,
 		   struct packet_type *, struct net_device *);
-	void (*sta_handler)(struct sk_buff *skb);
-	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
+	struct llc_pdu_un *pdu;
+	struct llc_sap *sap;
 
 	/*
 	 * When the interface is in promisc. mode, drop all the crap that it
@@ -175,49 +95,22 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto out;
 	if (unlikely(!llc_fixup_skb(skb)))
 		goto drop;
-	pdu = llc_pdu_sn_hdr(skb);
-	if (unlikely(!pdu->dsap)) /* NULL DSAP, refer to station */
-	       goto handle_station;
+	pdu = llc_pdu_un_hdr(skb);
 	sap = llc_sap_find(pdu->dsap);
 	if (unlikely(!sap)) {/* unknown SAP */
 		dprintk("%s: llc_sap_find(%02X) failed!\n", __func__,
 			pdu->dsap);
 		goto drop;
 	}
-	/*
-	 * First the upper layer protocols that don't need the full
-	 * LLC functionality
-	 */
 	rcv = rcu_dereference(sap->rcv_func);
-	dest = llc_pdu_type(skb);
-	sap_handler = dest ? READ_ONCE(llc_type_handlers[dest - 1]) : NULL;
-	if (unlikely(!sap_handler)) {
-		if (rcv)
-			rcv(skb, dev, pt, orig_dev);
-		else
-			kfree_skb(skb);
-	} else {
-		if (rcv) {
-			struct sk_buff *cskb = skb_clone(skb, GFP_ATOMIC);
-			if (cskb)
-				rcv(cskb, dev, pt, orig_dev);
-		}
-		sap_handler(sap, skb);
-	}
+	if (likely(rcv))
+		rcv(skb, dev, pt, orig_dev);
+	else
+		kfree_skb(skb);
 	llc_sap_put(sap);
 out:
 	return 0;
 drop:
 	kfree_skb(skb);
 	goto out;
-handle_station:
-	sta_handler = READ_ONCE(llc_station_handler);
-	if (!sta_handler)
-		goto drop;
-	sta_handler(skb);
-	goto out;
 }
-
-EXPORT_SYMBOL(llc_add_pack);
-EXPORT_SYMBOL(llc_remove_pack);
-EXPORT_SYMBOL(llc_set_station_handler);
diff --git a/net/llc/llc_output.c b/net/llc/llc_output.c
index 5a6466fc626a..8324f1cad4ca 100644
--- a/net/llc/llc_output.c
+++ b/net/llc/llc_output.c
@@ -59,8 +59,7 @@ int llc_build_and_send_ui_pkt(struct llc_sap *sap, struct sk_buff *skb,
 			      const unsigned char *dmac, unsigned char dsap)
 {
 	int rc;
-	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, sap->laddr.lsap,
-			    dsap, LLC_PDU_CMD);
+	llc_pdu_header_init(skb, sap->lsap, dsap, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
 	rc = llc_mac_hdr_init(skb, skb->dev->dev_addr, dmac);
 	if (likely(!rc))
-- 
2.55.0

