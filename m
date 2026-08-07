Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9F38F64D;
	Fri,  7 Aug 2026 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077879; cv=none; b=q7yWQl/x5xPgvbI3m0XZFvBSAaNzs/+d1UJOMYAXoDfvpEjwFHSCD/vslKexhKCgXfRUDbSqdLRlW2Gp6QuRRO76edu54WWxi7lg11l62wF3lwX1S8xExbSUGbsKEq/pLtkIjRnKoOb/xSL4ZQwSHwB4qEdbKOiokXnjUsVaz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077879; c=relaxed/simple;
	bh=eQLW07cqTCfmxQhTCauzMBas5iAkR2wP9zLoIDcRXes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtMXyZITFDdfBhhkJDRKXzMxEWGdw7UqYZWClKytJUB7i+1CaTZlf7v1I+O7iOyQJmXxo6moEw6xSSD26CVtxs4y/IY3bOVl33POW4ZOeMDhFqtAq60OW8oohwb4S1nEct5wLDJh1+oqVNHQlzF4MHEvg+cf5J8BrAEWKcZK42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.142496-0.0169027-0.840601;FP=16316663584136904868|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.ig.C8v2_1786077868;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.ig.C8v2_1786077868 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 12:44:28 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v24 net-next 03/11] net/nebula-matrix: add channel wire opcode enum definitions
Date: Fri,  7 Aug 2026 12:44:07 +0800
Message-ID: <20260807044422.2356-4-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add enum nbl_chan_msg_type into nbl_def_channel.h, defining all
PF/VF/firmware channel wire opcodes used for inter-component mailbox
communication.

Each enumerator carries an explicit fixed numeric value, acting as stable
wire-format message ID shared between driver and firmware.

ABI constraint: New opcodes must only be appended before
NBL_CHAN_MSG_MAILBOX_MAX.
Reordering, inserting or deleting existing entries will break
cross-version driver-firmware interoperability. Any modification to
existing opcode assignments requires coordinated firmware ABI change.

This commit introduces the opcode ID enumeration. Message payload
structures and complete channel layer logic will be added in subsequent
separate patches.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nbl/nbl_include/nbl_def_channel.h         | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
new file mode 100644
index 000000000000..be374667c338
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -0,0 +1,242 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_CHANNEL_H_
+#define _NBL_DEF_CHANNEL_H_
+
+/*
+ * Mailbox wire opcodes
+ * Every opcode is assigned explicit fixed numeric value, stable wire ABI
+ * shared between driver and firmware.
+ * Firmware/driver wire compatibility rule:
+ * New entries must only be appended before NBL_CHAN_MSG_MAILBOX_MAX.
+ * Reordering / inserting / deleting existing items will break cross-version
+ * interoperability. Any change to existing enumerators requires matching
+ * firmware ABI adjustment.
+ */
+enum nbl_chan_msg_type {
+	NBL_CHAN_MSG_ACK = 0,
+	NBL_CHAN_MSG_ADD_MACVLAN = 1,
+	NBL_CHAN_MSG_DEL_MACVLAN = 2,
+	NBL_CHAN_MSG_ADD_MULTI_RULE = 3,
+	NBL_CHAN_MSG_DEL_MULTI_RULE = 4,
+	NBL_CHAN_MSG_SETUP_MULTI_GROUP = 5,
+	NBL_CHAN_MSG_REMOVE_MULTI_GROUP = 6,
+	NBL_CHAN_MSG_REGISTER_NET = 7,
+	NBL_CHAN_MSG_UNREGISTER_NET = 8,
+	NBL_CHAN_MSG_ALLOC_TXRX_QUEUES = 9,
+	NBL_CHAN_MSG_FREE_TXRX_QUEUES = 10,
+	NBL_CHAN_MSG_SETUP_QUEUE = 11,
+	NBL_CHAN_MSG_REMOVE_ALL_QUEUES = 12,
+	NBL_CHAN_MSG_CFG_DSCH = 13,
+	NBL_CHAN_MSG_SETUP_CQS = 14,
+	NBL_CHAN_MSG_REMOVE_CQS = 15,
+	NBL_CHAN_MSG_CFG_QDISC_MQPRIO = 16,
+	NBL_CHAN_MSG_CONFIGURE_MSIX_MAP = 17,
+	NBL_CHAN_MSG_DESTROY_MSIX_MAP = 18,
+	NBL_CHAN_MSG_MAILBOX_SET_IRQ = 19,
+	NBL_CHAN_MSG_GET_GLOBAL_VECTOR = 20,
+	NBL_CHAN_MSG_GET_VSI_ID = 21,
+	NBL_CHAN_MSG_SET_PROMISC_MODE = 22,
+	NBL_CHAN_MSG_GET_FIRMWARE_VERSION = 23,
+	NBL_CHAN_MSG_GET_QUEUE_ERR_STATS = 24,
+	NBL_CHAN_MSG_GET_COALESCE = 25,
+	NBL_CHAN_MSG_SET_COALESCE = 26,
+	NBL_CHAN_MSG_SET_SPOOF_CHECK_ADDR = 27,
+	NBL_CHAN_MSG_SET_VF_SPOOF_CHECK = 28,
+	NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE = 29,
+	NBL_CHAN_MSG_GET_RXFH_INDIR = 30,
+	NBL_CHAN_MSG_GET_RXFH_RSS_KEY = 31,
+	NBL_CHAN_MSG_GET_RXFH_RSS_ALG_SEL = 32,
+	NBL_CHAN_MSG_GET_HW_CAPS = 33,
+	NBL_CHAN_MSG_GET_HW_STATE = 34,
+	NBL_CHAN_MSG_REGISTER_RDMA = 35,
+	NBL_CHAN_MSG_UNREGISTER_RDMA = 36,
+	NBL_CHAN_MSG_GET_REAL_HW_ADDR = 37,
+	NBL_CHAN_MSG_GET_REAL_BDF = 38,
+	NBL_CHAN_MSG_GRC_PROCESS = 39,
+	NBL_CHAN_MSG_SET_SFP_STATE = 40,
+	NBL_CHAN_MSG_SET_ETH_LOOPBACK = 41,
+	NBL_CHAN_MSG_CHECK_ACTIVE_VF = 42,
+	NBL_CHAN_MSG_GET_PRODUCT_FLEX_CAP = 43,
+	NBL_CHAN_MSG_ALLOC_KTLS_TX_INDEX = 44,
+	NBL_CHAN_MSG_FREE_KTLS_TX_INDEX = 45,
+	NBL_CHAN_MSG_CFG_KTLS_TX_KEYMAT = 46,
+	NBL_CHAN_MSG_ALLOC_KTLS_RX_INDEX = 47,
+	NBL_CHAN_MSG_FREE_KTLS_RX_INDEX = 48,
+	NBL_CHAN_MSG_CFG_KTLS_RX_KEYMAT = 49,
+	NBL_CHAN_MSG_CFG_KTLS_RX_RECORD = 50,
+	NBL_CHAN_MSG_ADD_KTLS_RX_FLOW = 51,
+	NBL_CHAN_MSG_DEL_KTLS_RX_FLOW = 52,
+	NBL_CHAN_MSG_ALLOC_IPSEC_TX_INDEX = 53,
+	NBL_CHAN_MSG_FREE_IPSEC_TX_INDEX = 54,
+	NBL_CHAN_MSG_ALLOC_IPSEC_RX_INDEX = 55,
+	NBL_CHAN_MSG_FREE_IPSEC_RX_INDEX = 56,
+	NBL_CHAN_MSG_CFG_IPSEC_TX_SAD = 57,
+	NBL_CHAN_MSG_CFG_IPSEC_RX_SAD = 58,
+	NBL_CHAN_MSG_ADD_IPSEC_TX_FLOW = 59,
+	NBL_CHAN_MSG_DEL_IPSEC_TX_FLOW = 60,
+	NBL_CHAN_MSG_ADD_IPSEC_RX_FLOW = 61,
+	NBL_CHAN_MSG_DEL_IPSEC_RX_FLOW = 62,
+	NBL_CHAN_MSG_NOTIFY_IPSEC_HARD_EXPIRE = 63,
+	NBL_CHAN_MSG_GET_MBX_IRQ_NUM = 64,
+	NBL_CHAN_MSG_CLEAR_FLOW = 65,
+	NBL_CHAN_MSG_CLEAR_QUEUE = 66,
+	NBL_CHAN_MSG_GET_ETH_ID = 67,
+	NBL_CHAN_MSG_SET_OFFLOAD_STATUS = 68,
+	NBL_CHAN_MSG_INIT_OFLD = 69,
+	NBL_CHAN_MSG_INIT_CMDQ = 70,
+	NBL_CHAN_MSG_DESTROY_CMDQ = 71,
+	NBL_CHAN_MSG_RESET_CMDQ = 72,
+	NBL_CHAN_MSG_INIT_FLOW = 73,
+	NBL_CHAN_MSG_DEINIT_FLOW = 74,
+	NBL_CHAN_MSG_OFFLOAD_FLOW_RULE = 75,
+	NBL_CHAN_MSG_GET_ACL_SWITCH = 76,
+	NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID = 77,
+	NBL_CHAN_MSG_INIT_REP = 78,
+	NBL_CHAN_MSG_GET_LINE_RATE_INFO = 79,
+	NBL_CHAN_MSG_REGISTER_NET_REP = 80,
+	NBL_CHAN_MSG_UNREGISTER_NET_REP = 81,
+	NBL_CHAN_MSG_REGISTER_ETH_REP = 82,
+	NBL_CHAN_MSG_UNREGISTER_ETH_REP = 83,
+	NBL_CHAN_MSG_REGISTER_UPCALL_PORT = 84,
+	NBL_CHAN_MSG_UNREGISTER_UPCALL_PORT = 85,
+	NBL_CHAN_MSG_GET_PORT_STATE = 86,
+	NBL_CHAN_MSG_SET_PORT_ADVERTISING = 87,
+	NBL_CHAN_MSG_GET_MODULE_INFO = 88,
+	NBL_CHAN_MSG_GET_MODULE_EEPROM = 89,
+	NBL_CHAN_MSG_GET_LINK_STATE = 90,
+	NBL_CHAN_MSG_NOTIFY_LINK_STATE = 91,
+	NBL_CHAN_MSG_GET_QUEUE_CXT = 92,
+	NBL_CHAN_MSG_CFG_LOG = 93,
+	NBL_CHAN_MSG_INIT_VDPAQ = 94,
+	NBL_CHAN_MSG_DESTROY_VDPAQ = 95,
+	NBL_CHAN_MSG_GET_UPCALL_PORT = 96,
+	NBL_CHAN_MSG_NOTIFY_ETH_REP_LINK_STATE = 97,
+	NBL_CHAN_MSG_SET_ETH_MAC_ADDR = 98,
+	NBL_CHAN_MSG_GET_FUNCTION_ID = 99,
+	NBL_CHAN_MSG_GET_CHIP_TEMPERATURE = 100,
+	NBL_CHAN_MSG_DISABLE_HW_FLOW = 101,
+	NBL_CHAN_MSG_ENABLE_HW_FLOW = 102,
+	NBL_CHAN_MSG_SET_UPCALL_RULE = 103,
+	NBL_CHAN_MSG_UNSET_UPCALL_RULE = 104,
+	NBL_CHAN_MSG_GET_REG_DUMP = 105,
+	NBL_CHAN_MSG_GET_REG_DUMP_LEN = 106,
+	NBL_CHAN_MSG_CFG_LAG_HASH_ALGORITHM = 107,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_FWD = 108,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_LIST = 109,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_UP_ATTR = 110,
+	NBL_CHAN_MSG_ADD_LAG_FLOW = 111,
+	NBL_CHAN_MSG_DEL_LAG_FLOW = 112,
+	NBL_CHAN_MSG_SWITCHDEV_INIT_CMDQ = 113,
+	NBL_CHAN_MSG_SWITCHDEV_DEINIT_CMDQ = 114,
+	NBL_CHAN_MSG_SET_TC_FLOW_INFO = 115,
+	NBL_CHAN_MSG_UNSET_TC_FLOW_INFO = 116,
+	NBL_CHAN_MSG_INIT_ACL = 117,
+	NBL_CHAN_MSG_UNINIT_ACL = 118,
+	NBL_CHAN_MSG_CFG_LAG_MCC = 119,
+	NBL_CHAN_MSG_REGISTER_VSI2Q = 120,
+	NBL_CHAN_MSG_SETUP_Q2VSI = 121,
+	NBL_CHAN_MSG_REMOVE_Q2VSI = 122,
+	NBL_CHAN_MSG_SETUP_RSS = 123,
+	NBL_CHAN_MSG_REMOVE_RSS = 124,
+	NBL_CHAN_MSG_GET_REP_QUEUE_INFO = 125,
+	NBL_CHAN_MSG_CTRL_PORT_LED = 126,
+	NBL_CHAN_MSG_NWAY_RESET = 127,
+	NBL_CHAN_MSG_SET_INTL_SUPPRESS_LEVEL = 128,
+	NBL_CHAN_MSG_GET_ETH_STATS = 129,
+	NBL_CHAN_MSG_GET_MODULE_TEMPERATURE = 130,
+	NBL_CHAN_MSG_GET_BOARD_INFO = 131,
+	NBL_CHAN_MSG_GET_P4_USED = 132,
+	NBL_CHAN_MSG_GET_VF_BASE_VSI_ID = 133,
+	NBL_CHAN_MSG_ADD_LLDP_FLOW = 134,
+	NBL_CHAN_MSG_DEL_LLDP_FLOW = 135,
+	NBL_CHAN_MSG_CFG_ETH_BOND_INFO = 136,
+	NBL_CHAN_MSG_CFG_DUPPKT_MCC = 137,
+	NBL_CHAN_MSG_ADD_ND_UPCALL_FLOW = 138,
+	NBL_CHAN_MSG_DEL_ND_UPCALL_FLOW = 139,
+	NBL_CHAN_MSG_GET_BOARD_ID = 140,
+	NBL_CHAN_MSG_SET_SHAPING_DPORT_VLD = 141,
+	NBL_CHAN_MSG_SET_DPORT_FC_TH_VLD = 142,
+	NBL_CHAN_MSG_REGISTER_RDMA_BOND = 143,
+	NBL_CHAN_MSG_UNREGISTER_RDMA_BOND = 144,
+	NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE = 145,
+	NBL_CHAN_MSG_RESTART_NETDEV_QUEUE = 146,
+	NBL_CHAN_MSG_RESTORE_HW_QUEUE = 147,
+	NBL_CHAN_MSG_KEEP_ALIVE = 148,
+	NBL_CHAN_MSG_GET_BASE_MAC_ADDR = 149,
+	NBL_CHAN_MSG_CFG_BOND_SHAPING = 150,
+	NBL_CHAN_MSG_CFG_BGID_BACK_PRESSURE = 151,
+	NBL_CHAN_MSG_ALLOC_KT_BLOCK = 152,
+	NBL_CHAN_MSG_FREE_KT_BLOCK = 153,
+	NBL_CHAN_MSG_GET_USER_QUEUE_INFO = 154,
+	NBL_CHAN_MSG_GET_ETH_BOND_INFO = 155,
+	NBL_CHAN_MSG_CLEAR_ACCEL_FLOW = 156,
+	NBL_CHAN_MSG_SET_BRIDGE_MODE = 157,
+	NBL_CHAN_MSG_GET_VF_FUNCTION_ID = 158,
+	NBL_CHAN_MSG_NOTIFY_LINK_FORCED = 159,
+	NBL_CHAN_MSG_SET_PMD_DEBUG = 160,
+	NBL_CHAN_MSG_REGISTER_FUNC_MAC = 161,
+	NBL_CHAN_MSG_SET_TX_RATE = 162,
+	NBL_CHAN_MSG_REGISTER_FUNC_LINK_FORCED = 163,
+	NBL_CHAN_MSG_GET_LINK_FORCED = 164,
+	NBL_CHAN_MSG_REGISTER_FUNC_VLAN = 165,
+	NBL_CHAN_MSG_GET_FD_FLOW = 166,
+	NBL_CHAN_MSG_GET_FD_FLOW_CNT = 167,
+	NBL_CHAN_MSG_GET_FD_FLOW_ALL = 168,
+	NBL_CHAN_MSG_GET_FD_FLOW_MAX = 169,
+	NBL_CHAN_MSG_REPLACE_FD_FLOW = 170,
+	NBL_CHAN_MSG_REMOVE_FD_FLOW = 171,
+	NBL_CHAN_MSG_CFG_FD_FLOW_STATE = 172,
+	NBL_CHAN_MSG_REGISTER_FUNC_RATE = 173,
+	NBL_CHAN_MSG_NOTIFY_VLAN = 174,
+	NBL_CHAN_MSG_GET_XDP_QUEUE_INFO = 175,
+	NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE = 176,
+	NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE = 177,
+	NBL_CHAN_MSG_NOTIFY_RESET_EVENT = 178,
+	NBL_CHAN_MSG_ACK_RESET_EVENT = 179,
+	NBL_CHAN_MSG_GET_VF_VSI_ID = 180,
+	NBL_CHAN_MSG_CONFIGURE_QOS = 181,
+	NBL_CHAN_MSG_GET_PFC_BUFFER_SIZE = 182,
+	NBL_CHAN_MSG_SET_PFC_BUFFER_SIZE = 183,
+	NBL_CHAN_MSG_GET_VF_STATS = 184,
+	NBL_CHAN_MSG_REGISTER_FUNC_TRUST = 185,
+	NBL_CHAN_MSG_NOTIFY_TRUST = 186,
+	NBL_CHAN_MSG_CHECK_VF_IS_ACTIVE = 187,
+	NBL_CHAN_MSG_GET_ETH_ABNORMAL_STATS = 188,
+	NBL_CHAN_MSG_GET_ETH_CTRL_STATS = 189,
+	NBL_CHAN_MSG_GET_PAUSE_STATS = 190,
+	NBL_CHAN_MSG_GET_ETH_MAC_STATS = 191,
+	NBL_CHAN_MSG_GET_FEC_STATS = 192,
+	NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE = 193,
+	NBL_CHAN_MSG_GET_LINK_DOWN_COUNT = 194,
+	NBL_CHAN_MSG_GET_LINK_STATUS_OPCODE = 195,
+	NBL_CHAN_MSG_GET_RMON_STATS = 196,
+	NBL_CHAN_MSG_REGISTER_PF_NAME = 197,
+	NBL_CHAN_MSG_GET_PF_NAME = 198,
+	NBL_CHAN_MSG_CONFIGURE_RDMA_BW = 199,
+	NBL_CHAN_MSG_SET_RATE_LIMIT = 200,
+	NBL_CHAN_MSG_SET_TC_WGT = 201,
+	NBL_CHAN_MSG_REMOVE_QUEUE = 202,
+	NBL_CHAN_MSG_GET_MIRROR_TABLE_ID = 203,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR = 204,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR_TABLE = 205,
+	NBL_CHAN_MSG_CLEAR_MIRROR_CFG = 206,
+	NBL_CHAN_MSG_MIRROR_OUTPUTPORT_NOTIFY = 207,
+	NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC = 208,
+	NBL_CHAN_MSG_CHECK_VF_IS_VDPA = 209,
+	NBL_CHAN_MSG_GET_VDPA_VF_STATS = 210,
+	NBL_CHAN_MSG_SET_RX_RATE = 211,
+	NBL_CHAN_MSG_GET_UVN_PKT_DROP_STATS = 212,
+	NBL_CHAN_MSG_GET_USTORE_PKT_DROP_STATS = 213,
+	NBL_CHAN_MSG_GET_USTORE_TOTAL_PKT_DROP_STATS = 214,
+	NBL_CHAN_MSG_SET_WOL = 215,
+	NBL_CHAN_MSG_INIT_VF_MSIX_MAP = 216,
+	NBL_CHAN_MSG_GET_ST_NAME = 217,
+	/* mailbox msg end */
+	NBL_CHAN_MSG_MAILBOX_MAX,
+};
+
+#endif
-- 
2.47.3

