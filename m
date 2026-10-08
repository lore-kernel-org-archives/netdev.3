Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60504B53E5;
	Thu,  8 Oct 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470011; cv=none; b=OlaVSvRPEz0c0hEBV9TFeL0zRtOJIK4A6Fp+Zc6ITgNZhnaKmOiSNtVziL1GxCzJVsnPWEc0YFWNHoKLPpBiKuHCCF7G+umZw9Qh2MAsx1qw5sb2JbMw1eumql2B6REgj2vT6pObdMf81OQ6b5KC7GCeuTsp5bmeCxNzHS8iyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470011; c=relaxed/simple;
	bh=9YVi8z0PxPMokEQ4Bu+S6gIDv+sDa6XWm6ml4UYsPDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLb2zSPVyQP9SbDSBGz7we8Rkud4/Dvc/B2tzOVYjTOq6p/JpafmqSwVr1c1o0tQceo+28iuch7o4MITVNO10odgPjfomVlWXtZK8aqrjTwXPLOCl7Zj47vjYSPzrGnYGmuZl0aFnGx0rG/ionHEorKpkuH6zvyR4QHDwXkc9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBC-000l4X-0L;
	Thu, 08 Oct 2026 16:33:06 +0200
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
Subject: [RFC net-next 03/12] net: pon: add the PLOAM vocabulary and message codec
Date: Thu,  8 Oct 2026 16:32:40 +0200
Message-Id: <20261008143249.3439762-4-john@phrozen.org>
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

PLOAM is the activation protocol of ITU-T G.9807.1. ploam.h holds the
values that the Recommendation defines rather than what one MAC encodes:
the message identifiers, the completion codes, the key indexes of Table
C.11.12, the Alloc-ID and XGEM Port-ID ranges of Tables C.6.5 and C.6.6,
the ONU-ID range of Table C.6.4, the field lengths and the timers. Every
value is a G.9807.1 value. Every PON driver needs them, so they belong
to the subsystem.

Four values of the key exchange that every XG(S)-PON MAC needs are in
ploam.h as well:

- PON_PLOAM_KEY_NAME_CONSTANT, the ASCII form of the constant that the
  Key_Name hashes after the key (Table C.11.26), with its length
- PON_PLOAM_KEY_FRAGMENT_FIRST, the fragment number of a single
  fragment Key_Report (Table C.11.26)
- PON_PLOAM_DEFAULT_PLOAM_IK_BYTE, the byte of the default PLOAM_IK
  (clause C.15.3.3)
- PON_PLOAM_DEFAULT_MSK, the MSK of the well-known default
  Registration_ID (formula C.15-2), as an initializer. A MAC that
  derives an MSK only from the Registration_ID programmed into it needs
  the value as a constant.

The core does not use them. A PON MAC driver does.

The codec parses the downstream messages that the ONU handles into
structures and builds the upstream ones. It holds no state, no timer and
no policy. The builder refuses an ONU-ID above ten bits. It sends
Serial_Number_ONU with ONU-ID 0x3FF and sequence number 0, as Table
C.11.24 fixes both fields. The control member of the parsed Key_Control
carries the Control flag of Table C.11.12, generate or confirm.

The core itself never calls the codec. The PLOAM state machine runs in
the MAC driver, because its timing and its registers are the MAC's. The
codec is in the subsystem so that every PON MAC driver parses and builds
the messages with one implementation instead of its own. The core uses a
few of the ploam.h values itself: the netlink handlers validate the
Alloc-ID and XGEM Port-ID ranges with them. The other values serve the
drivers.

The core does not call two helpers either. A PON MAC driver needs
pon_ploam_alloc_is_assignable() to refuse an Assign_Alloc-ID outside the
assignable range of Table C.6.5. pon_ploam_profile_is_broadcast() tells
a driver that a Burst_Profile addresses every ONU of its upstream rate:
Table C.11.4 uses ONU-ID 0x3FE for the 9.95328 Gbit/s ONUs beside the
broadcast ONU-ID 0x3FF.

Nothing builds it yet. The build is wired at the end of the series.

Assisted-by: LLM
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/pon/ploam.h     | 266 ++++++++++++++++++++++++++++++
 include/net/pon/ploam_msg.h | 306 +++++++++++++++++++++++++++++++++++
 net/pon/pon_ploam_msg.c     | 312 ++++++++++++++++++++++++++++++++++++
 3 files changed, 884 insertions(+)
 create mode 100644 include/net/pon/ploam.h
 create mode 100644 include/net/pon/ploam_msg.h
 create mode 100644 net/pon/pon_ploam_msg.c

diff --git a/include/net/pon/ploam.h b/include/net/pon/ploam.h
new file mode 100644
index 000000000000..2fc27be3f1cc
--- /dev/null
+++ b/include/net/pon/ploam.h
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#ifndef __NET_PON_PLOAM_H
+#define __NET_PON_PLOAM_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/**
+ * DOC: The PLOAM vocabulary
+ *
+ * What ITU-T G.9807.1 defines, rather than what any one MAC's registers
+ * encode. Every PON driver needs these, so they belong to the subsystem. The
+ * header holds no value of another ITU-T PON system, although the mode
+ * enumeration of the uapi names them.
+ *
+ * It holds the message identifiers, the completion codes, the Alloc-ID and
+ * XGEM Port-ID ranges of Tables C.6.5 and C.6.6, the ONU-ID range of
+ * Table C.6.4, the key indexes of Table C.11.12, the field lengths and the
+ * timers.
+ *
+ * This header is kernel internal. Only the handful of enumerations userspace
+ * reads are uapi, in <uapi/linux/pon.h>.
+ *
+ * A value that is a vendor's recovery policy or a register layout stays in
+ * that vendor's driver even when it sits next to a PLOAM field.
+ *
+ */
+
+/**
+ * enum pon_ploam_down_id - downstream PLOAM message identifiers
+ * @PON_PLOAM_DOWN_BURST_PROFILE: Burst_Profile
+ * @PON_PLOAM_DOWN_ASSIGN_ONU_ID: Assign_ONU-ID
+ * @PON_PLOAM_DOWN_RANGING_TIME: Ranging_Time
+ * @PON_PLOAM_DOWN_DEACTIVATE: Deactivate_ONU-ID
+ * @PON_PLOAM_DOWN_DISABLE_SN: Disable_Serial_Number
+ * @PON_PLOAM_DOWN_REQUEST_REG: Request_Registration
+ * @PON_PLOAM_DOWN_ASSIGN_ALLOC_ID: Assign_Alloc-ID
+ * @PON_PLOAM_DOWN_KEY_CONTROL: Key_Control
+ * @PON_PLOAM_DOWN_SLEEP_ALLOW: Sleep_Allow
+ * @PON_PLOAM_DOWN_REBOOT_ONU: Reboot_ONU
+ * @PON_PLOAM_DOWN_MAX: one above the highest identifier listed here, the
+ *	size of an array indexed by the identifier, not a wire value
+ *
+ * ITU-T G.9807.1 Table C.11.2.
+ */
+enum pon_ploam_down_id {
+	PON_PLOAM_DOWN_BURST_PROFILE	= 0x01,
+	PON_PLOAM_DOWN_ASSIGN_ONU_ID	= 0x03,
+	PON_PLOAM_DOWN_RANGING_TIME	= 0x04,
+	PON_PLOAM_DOWN_DEACTIVATE	= 0x05,
+	PON_PLOAM_DOWN_DISABLE_SN	= 0x06,
+	PON_PLOAM_DOWN_REQUEST_REG	= 0x09,
+	PON_PLOAM_DOWN_ASSIGN_ALLOC_ID	= 0x0a,
+	PON_PLOAM_DOWN_KEY_CONTROL	= 0x0d,
+	PON_PLOAM_DOWN_SLEEP_ALLOW	= 0x12,
+	PON_PLOAM_DOWN_REBOOT_ONU	= 0x1d,
+	PON_PLOAM_DOWN_MAX		= 0x1e,
+};
+
+/**
+ * enum pon_ploam_up_id - upstream PLOAM message identifiers
+ * @PON_PLOAM_UP_SERIAL_NUMBER: Serial_Number_ONU
+ * @PON_PLOAM_UP_REGISTRATION: Registration
+ * @PON_PLOAM_UP_KEY_REPORT: Key_Report
+ * @PON_PLOAM_UP_ACKNOWLEDGE: Acknowledgment
+ * @PON_PLOAM_UP_SLEEP_REQUEST: Sleep_Request
+ * @PON_PLOAM_UP_MAX: one above the highest identifier listed here, the size
+ *	of an array indexed by the identifier, not a wire value
+ *
+ * ITU-T G.9807.1 Table C.11.3.
+ */
+enum pon_ploam_up_id {
+	PON_PLOAM_UP_SERIAL_NUMBER	= 0x01,
+	PON_PLOAM_UP_REGISTRATION	= 0x02,
+	PON_PLOAM_UP_KEY_REPORT		= 0x05,
+	PON_PLOAM_UP_ACKNOWLEDGE	= 0x09,
+	PON_PLOAM_UP_SLEEP_REQUEST	= 0x10,
+	PON_PLOAM_UP_MAX		= 0x11,
+};
+
+/**
+ * enum pon_ploam_ack - completion codes of the upstream Acknowledgment message
+ * @PON_PLOAM_ACK_OK: OK
+ * @PON_PLOAM_ACK_NO_MESSAGE: no message to send
+ * @PON_PLOAM_ACK_BUSY: busy, preparing a response
+ * @PON_PLOAM_ACK_UNKNOWN_TYPE: unknown message type
+ * @PON_PLOAM_ACK_PARAM_ERR: parameter error
+ * @PON_PLOAM_ACK_PROCESS_ERR: processing error
+ *
+ * ITU-T G.9807.1 Table C.11.27, the Completion_code field.
+ */
+enum pon_ploam_ack {
+	PON_PLOAM_ACK_OK		= 0,
+	PON_PLOAM_ACK_NO_MESSAGE	= 1,
+	PON_PLOAM_ACK_BUSY		= 2,
+	PON_PLOAM_ACK_UNKNOWN_TYPE	= 3,
+	PON_PLOAM_ACK_PARAM_ERR		= 4,
+	PON_PLOAM_ACK_PROCESS_ERR	= 5,
+};
+
+/**
+ * enum pon_ploam_disable_mode - the Mode field of Disable_Serial_Number
+ * @PON_PLOAM_DISABLE_ALLOW_ONE: the ONU with this serial number is allowed
+ *	upstream access
+ * @PON_PLOAM_DISABLE_DENY_ALL: all ONUs are denied upstream access. The
+ *	serial number is ignored
+ * @PON_PLOAM_DISABLE_ALLOW_ALL: all ONUs are allowed upstream access
+ * @PON_PLOAM_DISABLE_DENY_ONE: the ONU with this serial number is denied
+ *	upstream access
+ *
+ * ITU-T G.9807.1 Table C.11.9, the Disable/enable field.
+ */
+enum pon_ploam_disable_mode {
+	PON_PLOAM_DISABLE_ALLOW_ONE	= 0x00,
+	PON_PLOAM_DISABLE_DENY_ALL	= 0x0f,
+	PON_PLOAM_DISABLE_ALLOW_ALL	= 0xf0,
+	PON_PLOAM_DISABLE_DENY_ONE	= 0xff,
+};
+
+/* The equalization delay encoding of Ranging_Time, G.9807.1 Table C.11.7. */
+#define PON_PLOAM_EQD_RELATIVE		0
+#define PON_PLOAM_EQD_ABSOLUTE		1
+#define PON_PLOAM_EQD_POSITIVE		0
+
+/* The Alloc-ID type field of Assign_Alloc-ID, G.9807.1 Table C.11.11. */
+#define PON_PLOAM_ALLOC_ASSIGN		0x01
+#define PON_PLOAM_ALLOC_DEALLOCATE	0xff
+
+/* Alloc-ID values, G.9807.1 Table C.6.5. The default alloc-id equals the
+ * ONU-ID, the three above the default range are serial number grants that
+ * are never assigned to an ONU and the rest are assignable. 1022 is the
+ * serial number grant for the 9.95328 Gbit/s upstream rate, 1023 the one
+ * for 2.48832 Gbit/s.
+ */
+#define PON_PLOAM_ALLOC_ID_DEFAULT_MAX	1020
+#define PON_PLOAM_ALLOC_ID_SN_GRANT_MIN	1021
+#define PON_PLOAM_ALLOC_ID_SN_GRANT_10G	1022
+#define PON_PLOAM_ALLOC_ID_SN_GRANT_2G5	1023
+#define PON_PLOAM_ALLOC_ID_MAX		16383
+
+/* XGEM Port-ID values, G.9807.1 Table C.6.6. 0 to 1020 is the default
+ * Port-ID, which equals the ONU-ID and carries only the OMCC. The OLT
+ * assigns every other GEM port of the ONU over the OMCC from 1021 to 65534
+ * and 65535 is the idle Port-ID.
+ */
+#define PON_GEM_PORT_ID_ASSIGNABLE_MIN	1021
+#define PON_GEM_PORT_ID_ASSIGNABLE_MAX	65534
+
+/* The Reboot_ONU fields, G.9807.1 Table C.11.23A. */
+#define PON_PLOAM_REBOOT_DEPTH_MAX		3
+#define PON_PLOAM_REBOOT_IMAGE_MAX		1
+#define PON_PLOAM_REBOOT_STATE_INACTIVE_ONLY	1
+#define PON_PLOAM_REBOOT_CALLS_MASK		0x3
+
+/* The Key_Length a Key_Control carries for the AES-128 cipher,
+ * G.9807.1 Table C.11.12.
+ */
+#define PON_PLOAM_KEY_LEN_AES128	16
+
+/* The Key index of Key_Control and Key_Report, the two low bits of the
+ * field. Values 00 and 11 are not defined. G.9807.1 Table C.11.12 and
+ * Table C.11.26.
+ */
+#define PON_PLOAM_KEY_INDEX_FIRST	1
+#define PON_PLOAM_KEY_INDEX_SECOND	2
+
+/* The Control flag of Key_Control (G.9807.1 Table C.11.12) and the Report
+ * type of Key_Report (Table C.11.26).
+ */
+#define PON_PLOAM_KEY_CONTROL_GENERATE		0
+#define PON_PLOAM_KEY_CONTROL_CONFIRM		1
+#define PON_PLOAM_KEY_REPORT_TYPE_NEW		0
+#define PON_PLOAM_KEY_REPORT_TYPE_EXISTING	1
+
+/* The Key_Name of a Key_Report on an existing key is AES-CMAC(KEK,
+ * encryption_key | 0x33313431353932363533353839373933, 128), G.9807.1
+ * Table C.11.26. The constant is the ASCII string below, without its NUL.
+ * The key fragment number of a single fragment report is 0.
+ */
+#define PON_PLOAM_KEY_NAME_CONSTANT		"3141592653589793"
+#define PON_PLOAM_KEY_NAME_CONSTANT_LEN		16
+#define PON_PLOAM_KEY_FRAGMENT_FIRST		0
+
+/* The default PLOAM_IK is this byte repeated sixteen times, G.9807.1
+ * clause C.15.3.3. The MSK of the well-known default Registration_ID
+ * (thirty-six zero bytes, Table C.11.25) is formula C.15-2 under that key,
+ * clause C.15.3.2. PON_PLOAM_DEFAULT_MSK holds it as an initializer. A MAC
+ * that derives an MSK only from the Registration_ID programmed into it
+ * needs the value as a constant.
+ */
+#define PON_PLOAM_DEFAULT_PLOAM_IK_BYTE		0x55
+#define PON_PLOAM_DEFAULT_MSK	{			\
+	0x24, 0x37, 0xbe, 0x54, 0xe9, 0x5e, 0x6e, 0xe3,	\
+	0x53, 0x8b, 0xb1, 0xb4, 0xb5, 0xd4, 0x32, 0xeb,	\
+}
+
+/* The delimiter and preamble lengths of the burst profile, in octets,
+ * G.9807.1 Table C.11.4.
+ */
+#define PON_PLOAM_BURST_DELIMITER_LEN_MAX	8
+#define PON_PLOAM_BURST_PREAMBLE_LEN_MIN	1
+#define PON_PLOAM_BURST_PREAMBLE_LEN_MAX	8
+
+/* The upstream line rate bit: R of the burst profile (G.9807.1
+ * Table C.11.4) and U of Assign_ONU-ID (Table C.11.6). Then the widths of the
+ * preamble repeat count of the burst profile, Table C.11.4.
+ */
+#define PON_PLOAM_LINE_RATE_XGPON	0
+#define PON_PLOAM_LINE_RATE_XGSPON	1
+#define PON_PLOAM_PREAMBLE_MASK_XGPON	0x1f
+#define PON_PLOAM_PREAMBLE_MASK_XGSPON	0xff
+
+/* The upstream line rate capability of Serial_Number_ONU, a bitmap of the
+ * form 0000 00HL, G.9807.1 Table C.11.24. H set: the ONU supports the
+ * 9.95328 Gbit/s upstream rate. L set: the ONU does not support the
+ * 2.48832 Gbit/s upstream rate.
+ */
+#define PON_PLOAM_SN_RATE_10G		BIT(1)
+#define PON_PLOAM_SN_RATE_NO_2G5	BIT(0)
+
+/* The ONU-ID is ten bits, G.9807.1 clause C.11.2.1. The OLT assigns 0 to
+ * 1020, Table C.6.4. 0x3ff is both the broadcast destination and the value
+ * an ONU carries before the OLT assigns it one. 0x3fe appears only in a
+ * Burst_Profile, as the broadcast destination of a profile for the
+ * 9.95328 Gbit/s upstream rate.
+ */
+#define PON_PLOAM_ONU_ID_MASK			GENMASK(9, 0)
+#define PON_PLOAM_ONU_ID_MAX			1020
+#define PON_PLOAM_ONU_ID_BROADCAST		0x3ff
+#define PON_PLOAM_ONU_ID_UNASSIGNED		0x3ff
+#define PON_PLOAM_ONU_ID_PROFILE_BCAST_10G	0x3fe
+
+/* Fields of the standard message, in bytes. The serial number is the
+ * Vendor_ID and the VSSN, G.9807.1 clauses C.11.2.6.1 and C.11.2.6.2. The
+ * Registration_ID is Table C.11.25 and the key fragment Table C.11.26.
+ */
+#define PON_PLOAM_SN_LEN		8
+#define PON_PLOAM_REG_ID_LEN		36
+#define PON_PLOAM_KEY_FRAGMENT_LEN	32
+
+/* The recommended initial value of TO1, in milliseconds, Table C.12.2. */
+#define PON_PLOAM_TO1_MS		10000
+
+/* The key exchange timers, in milliseconds, G.9807.1 clause C.15.5.3.3. */
+#define PON_PLOAM_TK4_MS		100
+#define PON_PLOAM_TK5_MS		20
+
+/**
+ * pon_ploam_alloc_is_assignable() - whether the OLT can assign an Alloc-ID
+ * @alloc_id: the fourteen bit Alloc-ID
+ *
+ * ITU-T G.9807.1 Table C.6.5. The core does not call it. A PON MAC driver
+ * needs it to refuse an Assign_Alloc-ID outside that range.
+ *
+ * Return: true for the values above PON_PLOAM_ALLOC_ID_SN_GRANT_2G5 up to
+ * PON_PLOAM_ALLOC_ID_MAX, 1024 to 16383.
+ */
+static inline bool pon_ploam_alloc_is_assignable(u16 alloc_id)
+{
+	return alloc_id > PON_PLOAM_ALLOC_ID_SN_GRANT_2G5 &&
+	       alloc_id <= PON_PLOAM_ALLOC_ID_MAX;
+}
+
+#endif /* __NET_PON_PLOAM_H */
diff --git a/include/net/pon/ploam_msg.h b/include/net/pon/ploam_msg.h
new file mode 100644
index 000000000000..fe25da8af12c
--- /dev/null
+++ b/include/net/pon/ploam_msg.h
@@ -0,0 +1,306 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#ifndef __NET_PON_PLOAM_MSG_H
+#define __NET_PON_PLOAM_MSG_H
+
+#include <linux/types.h>
+#include <net/pon/ploam.h>
+
+/**
+ * DOC: The PLOAM message codec
+ *
+ * Lays out and reads the standard message body. It is a pure function of an
+ * ITU-T wire format: no state, no timer, no register and no policy. A driver
+ * decides what a message means and when to send one. This decides where the
+ * bytes go.
+ *
+ * The body is what the standard defines and nothing else: the ONU-ID, the
+ * message identifier, the sequence number and 36 bytes of content. Whatever a
+ * MAC wraps around that, a prefix, a trailer, a FIFO word order or a message
+ * integrity check, stays in that MAC's driver.
+ */
+
+/* The generic PLOAM message structure, G.9807.1 Table C.11.1. */
+#define PON_PLOAM_CONTENT_LEN	36
+#define PON_PLOAM_BODY_LEN	(2 + 1 + 1 + PON_PLOAM_CONTENT_LEN)
+
+/**
+ * struct pon_ploam_sn - Serial_Number_ONU
+ * @sn: the eight byte serial number
+ * @random_delay: the response delay the ONU applies, in bit periods at
+ *	2.48832 Gbit/s whatever the upstream rate of the ONU
+ *
+ * ITU-T G.9807.1 Table C.11.24.
+ */
+struct pon_ploam_sn {
+	u8 sn[PON_PLOAM_SN_LEN];
+	u32 random_delay;
+};
+
+/**
+ * struct pon_ploam_registration - Registration
+ * @reg_id: the registration id
+ *
+ * ITU-T G.9807.1 Table C.11.25.
+ */
+struct pon_ploam_registration {
+	u8 reg_id[PON_PLOAM_REG_ID_LEN];
+};
+
+/**
+ * struct pon_ploam_key_report - Key_Report
+ * @key: the key fragment
+ * @len: its length, at most PON_PLOAM_KEY_FRAGMENT_LEN
+ * @type: new key or existing key, PON_PLOAM_KEY_REPORT_TYPE_*
+ * @index: the reported key index
+ * @num: the fragment number
+ *
+ * ITU-T G.9807.1 Table C.11.26.
+ */
+struct pon_ploam_key_report {
+	u8 key[PON_PLOAM_KEY_FRAGMENT_LEN];
+	u8 len;
+	u8 type;
+	u8 index;
+	u8 num;
+};
+
+/**
+ * struct pon_ploam_ack_msg - Acknowledgment
+ * @code: the completion code, enum pon_ploam_ack
+ *
+ * ITU-T G.9807.1 Table C.11.27.
+ */
+struct pon_ploam_ack_msg {
+	u8 code;
+};
+
+/**
+ * struct pon_ploam_up - one upstream message to lay out
+ * @onu_id: the ONU-ID to send it from, at most PON_PLOAM_ONU_ID_MASK
+ * @msg_id: which message, enum pon_ploam_up_id
+ * @seq_no: the downstream sequence number to echo, or 0
+ * @sn: Serial_Number_ONU content
+ * @registration: Registration content
+ * @key_report: Key_Report content
+ * @ack: Acknowledgment content
+ *
+ * ITU-T G.9807.1 Table C.11.3, the upstream message summary.
+ */
+struct pon_ploam_up {
+	u16 onu_id;
+	u8 msg_id;
+	u8 seq_no;
+	union {
+		struct pon_ploam_sn sn;
+		struct pon_ploam_registration registration;
+		struct pon_ploam_key_report key_report;
+		struct pon_ploam_ack_msg ack;
+	};
+};
+
+int pon_ploam_up_build(void *buf, size_t len, const struct pon_ploam_up *msg);
+
+/* The Burst_Profile field sizes, G.9807.1 Table C.11.4. */
+#define PON_PLOAM_BURST_PATTERN_LEN	8
+#define PON_PLOAM_PON_TAG_LEN		8
+
+/**
+ * struct pon_ploam_burst_profile - Burst_Profile
+ * @delimiter: the burst delimiter pattern
+ * @preamble: the burst preamble pattern
+ * @pon_tag: the PON tag the OLT assigns
+ * @index: which of the profiles this one is
+ * @version: the profile version
+ * @line_rate: the upstream line rate, PON_PLOAM_LINE_RATE_*
+ * @fec: upstream FEC is on
+ * @delimiter_len: significant bytes of @delimiter
+ * @preamble_len: significant bytes of @preamble
+ * @preamble_repeat: how many times the preamble repeats, masked to the width
+ *	that @line_rate gives the field: five bits for
+ *	PON_PLOAM_LINE_RATE_XGPON, eight for PON_PLOAM_LINE_RATE_XGSPON
+ *
+ * ITU-T G.9807.1 Table C.11.4.
+ */
+struct pon_ploam_burst_profile {
+	u8 delimiter[PON_PLOAM_BURST_PATTERN_LEN];
+	u8 preamble[PON_PLOAM_BURST_PATTERN_LEN];
+	u8 pon_tag[PON_PLOAM_PON_TAG_LEN];
+	u8 index;
+	u8 version;
+	u8 line_rate;
+	u8 fec;
+	u8 delimiter_len;
+	u8 preamble_len;
+	u8 preamble_repeat;
+};
+
+/**
+ * struct pon_ploam_assign_onu_id - Assign_ONU-ID
+ * @sn: the serial number the assignment is for
+ * @onu_id: the ONU-ID being assigned
+ * @line_rate: the upstream nominal line rate the OLT selects,
+ *	PON_PLOAM_LINE_RATE_*. It applies only to an ONU that supports both
+ *	upstream rates
+ *
+ * ITU-T G.9807.1 Table C.11.6.
+ */
+struct pon_ploam_assign_onu_id {
+	u8 sn[PON_PLOAM_SN_LEN];
+	u16 onu_id;
+	u8 line_rate;
+};
+
+/**
+ * struct pon_ploam_ranging_time - Ranging_Time
+ * @eqd: the equalization delay, in bit periods at 2.48832 Gbit/s whatever
+ *	the upstream rate of the ONU
+ * @absolute: @eqd replaces the current value rather than adjusting it
+ * @positive: an adjustment adds rather than subtracts
+ *
+ * ITU-T G.9807.1 Table C.11.7.
+ */
+struct pon_ploam_ranging_time {
+	u32 eqd;
+	bool absolute;
+	bool positive;
+};
+
+/**
+ * struct pon_ploam_disable_sn - Disable_Serial_Number
+ * @sn: the serial number the mode applies to
+ * @mode: enum pon_ploam_disable_mode
+ *
+ * ITU-T G.9807.1 Table C.11.9.
+ */
+struct pon_ploam_disable_sn {
+	u8 sn[PON_PLOAM_SN_LEN];
+	u8 mode;
+};
+
+/**
+ * struct pon_ploam_assign_alloc_id - Assign_Alloc-ID
+ * @alloc_id: the alloc-id
+ * @type: assign or deallocate, PON_PLOAM_ALLOC_*
+ *
+ * ITU-T G.9807.1 Table C.11.11.
+ */
+struct pon_ploam_assign_alloc_id {
+	u16 alloc_id;
+	u8 type;
+};
+
+/**
+ * struct pon_ploam_key_control - Key_Control
+ * @key_index: the key index to report
+ * @control: the Control flag, generate a new key or confirm a key,
+ *	PON_PLOAM_KEY_CONTROL_*
+ * @key_length: the key length the OLT asks for, in bytes, where 0 means 256
+ *
+ * ITU-T G.9807.1 Table C.11.12.
+ */
+struct pon_ploam_key_control {
+	u8 key_index;
+	u8 control;
+	u8 key_length;
+};
+
+/**
+ * struct pon_ploam_reboot - Reboot_ONU
+ * @sn: the serial number a broadcast message names, all zero for every ONU
+ * @depth: the reboot depth, where 0 is an OMCI MIB reset
+ * @image: which software image to load
+ * @state: the activation states the reboot applies in
+ * @flags: the call-in-progress conditions
+ *
+ * ITU-T G.9807.1 Table C.11.23A.
+ */
+struct pon_ploam_reboot {
+	u8 sn[PON_PLOAM_SN_LEN];
+	u8 depth;
+	u8 image;
+	u8 state;
+	u8 flags;
+};
+
+/**
+ * struct pon_ploam_down - one downstream message, parsed
+ * @onu_id: the destination, the ten bits the standard defines
+ * @msg_id: which message, enum pon_ploam_down_id
+ * @seq_no: the sequence number to echo in an acknowledgment
+ * @burst_profile: Burst_Profile content
+ * @assign_onu_id: Assign_ONU-ID content
+ * @ranging_time: Ranging_Time content
+ * @disable_sn: Disable_Serial_Number content
+ * @assign_alloc_id: Assign_Alloc-ID content
+ * @key_control: Key_Control content
+ * @reboot: Reboot_ONU content
+ *
+ * ITU-T G.9807.1 Table C.11.2, the downstream message summary.
+ */
+struct pon_ploam_down {
+	u16 onu_id;
+	u8 msg_id;
+	u8 seq_no;
+	union {
+		struct pon_ploam_burst_profile burst_profile;
+		struct pon_ploam_assign_onu_id assign_onu_id;
+		struct pon_ploam_ranging_time ranging_time;
+		struct pon_ploam_disable_sn disable_sn;
+		struct pon_ploam_assign_alloc_id assign_alloc_id;
+		struct pon_ploam_key_control key_control;
+		struct pon_ploam_reboot reboot;
+	};
+};
+
+int pon_ploam_down_parse(const void *buf, size_t len,
+			 struct pon_ploam_down *msg);
+
+/**
+ * pon_ploam_is_broadcast() - whether an ONU-ID is the broadcast destination
+ * @onu_id: the ten bit ONU-ID of a downstream message
+ *
+ * Only 0x3ff counts. 0x3fe, the broadcast of a Burst_Profile for the
+ * 9.95328 Gbit/s upstream rate, does not. ITU-T G.9807.1 clause C.11.2.1.
+ * A Burst_Profile tests its destination with
+ * pon_ploam_profile_is_broadcast().
+ *
+ * Return: true for PON_PLOAM_ONU_ID_BROADCAST.
+ */
+static inline bool pon_ploam_is_broadcast(u16 onu_id)
+{
+	return onu_id == PON_PLOAM_ONU_ID_BROADCAST;
+}
+
+/**
+ * pon_ploam_profile_is_broadcast() - whether a Burst_Profile is broadcast
+ * @onu_id: the ten bit ONU-ID of a downstream Burst_Profile
+ *
+ * A Burst_Profile goes to 0x3ff for every ONU or to 0x3fe for the ONUs that
+ * support the 9.95328 Gbit/s upstream rate. An XGS-PON ONU takes both alike.
+ * ITU-T G.9807.1 Table C.11.4 and Appendix II.
+ *
+ * Return: true for PON_PLOAM_ONU_ID_BROADCAST and
+ * PON_PLOAM_ONU_ID_PROFILE_BCAST_10G.
+ */
+static inline bool pon_ploam_profile_is_broadcast(u16 onu_id)
+{
+	return pon_ploam_is_broadcast(onu_id) ||
+	       onu_id == PON_PLOAM_ONU_ID_PROFILE_BCAST_10G;
+}
+
+/**
+ * pon_ploam_is_assignable() - whether the OLT can assign an ONU-ID
+ * @onu_id: the ten bit ONU-ID
+ *
+ * ITU-T G.9807.1 Table C.6.4.
+ *
+ * Return: true for 0 to PON_PLOAM_ONU_ID_MAX.
+ */
+static inline bool pon_ploam_is_assignable(u16 onu_id)
+{
+	return onu_id <= PON_PLOAM_ONU_ID_MAX;
+}
+
+#endif /* __NET_PON_PLOAM_MSG_H */
diff --git a/net/pon/pon_ploam_msg.c b/net/pon/pon_ploam_msg.c
new file mode 100644
index 000000000000..27b3285629f2
--- /dev/null
+++ b/net/pon/pon_ploam_msg.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 John Crispin <john@phrozen.org> */
+
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <net/pon/ploam_msg.h>
+
+/* Offsets within the standard body. The ONU-ID is big endian and the content
+ * follows the four byte header. G.9807.1 Table C.11.1.
+ */
+#define PON_PLOAM_OFF_ONU_ID	0
+#define PON_PLOAM_OFF_MSG_ID	2
+#define PON_PLOAM_OFF_SEQ_NO	3
+#define PON_PLOAM_OFF_CONTENT	4
+
+/* Serial_Number_ONU content, G.9807.1 Table C.11.24. */
+#define PON_PLOAM_SN_OFF_SN		0
+#define PON_PLOAM_SN_OFF_DELAY		8
+#define PON_PLOAM_SN_OFF_CAPABILITY	32
+#define PON_PLOAM_SN_CAPABILITY		(PON_PLOAM_SN_RATE_10G | \
+					 PON_PLOAM_SN_RATE_NO_2G5)
+
+/* Registration content, G.9807.1 Table C.11.25. */
+#define PON_PLOAM_REG_OFF_ID		0
+
+/* Key_Report content, G.9807.1 Table C.11.26. */
+#define PON_PLOAM_KR_OFF_TYPE		0
+#define PON_PLOAM_KR_OFF_INDEX		1
+#define PON_PLOAM_KR_OFF_NUM		2
+#define PON_PLOAM_KR_OFF_FRAGMENT	4
+
+/* Acknowledgment content, G.9807.1 Table C.11.27. */
+#define PON_PLOAM_ACK_OFF_CODE		0
+
+/* Downstream content offsets, checked against the message tables of
+ * G.9807.1 clause C.11.3.3: Key_Control is Table C.11.12 and Reboot_ONU is
+ * Table C.11.23A.
+ */
+/* Burst_Profile, G.9807.1 Table C.11.4. */
+#define PON_PLOAM_BP_OFF_FLAGS		0
+#define PON_PLOAM_BP_OFF_FEC		1
+#define PON_PLOAM_BP_OFF_DELIM_LEN	2
+#define PON_PLOAM_BP_OFF_DELIM		3
+#define PON_PLOAM_BP_OFF_PRE_LEN	11
+#define PON_PLOAM_BP_OFF_PRE_REPEAT	12
+#define PON_PLOAM_BP_OFF_PRE		13
+#define PON_PLOAM_BP_OFF_PON_TAG	21
+
+/* Assign_ONU-ID, G.9807.1 Table C.11.6. */
+#define PON_PLOAM_AOI_OFF_ID		0
+#define PON_PLOAM_AOI_OFF_SN		2
+#define PON_PLOAM_AOI_OFF_RATE		10
+
+/* Ranging_Time, G.9807.1 Table C.11.7. */
+#define PON_PLOAM_RT_OFF_FLAGS		0
+#define PON_PLOAM_RT_OFF_EQD		1
+
+/* Disable_Serial_Number, G.9807.1 Table C.11.9. */
+#define PON_PLOAM_DSN_OFF_MODE		0
+#define PON_PLOAM_DSN_OFF_SN		1
+
+/* Assign_Alloc-ID, G.9807.1 Table C.11.11. */
+#define PON_PLOAM_AAI_OFF_ID		0
+#define PON_PLOAM_AAI_OFF_TYPE		2
+
+/* Key_Control, G.9807.1 Table C.11.12. */
+#define PON_PLOAM_KC_OFF_TYPE		1
+#define PON_PLOAM_KC_OFF_INDEX		2
+#define PON_PLOAM_KC_OFF_LENGTH		3
+
+/* Reboot_ONU, G.9807.1 Table C.11.23A. */
+#define PON_PLOAM_RB_OFF_SN		0
+#define PON_PLOAM_RB_OFF_DEPTH		8
+#define PON_PLOAM_RB_OFF_IMAGE		9
+#define PON_PLOAM_RB_OFF_STATE		10
+#define PON_PLOAM_RB_OFF_FLAGS		11
+
+/**
+ * pon_ploam_up_build() - lay out one upstream PLOAM message
+ * @buf:	where to write the standard body, at least PON_PLOAM_BODY_LEN
+ * @len:	the space available
+ * @msg:	what to send
+ *
+ * Writes the ONU-ID, the message identifier, the sequence number and the
+ * content. The caller owns everything around the body: any vendor prefix or
+ * trailer, the message integrity check and the order the bytes reach the
+ * hardware.
+ *
+ * The whole 36 byte content is cleared before the fields are written, so
+ * every octet a message does not use goes out as 0x00. The key report's type,
+ * index and fragment number are masked to their field widths.
+ *
+ * Serial_Number_ONU reports an ONU that supports the 9.95328 Gbit/s upstream
+ * rate only: PON_PLOAM_SN_RATE_10G and PON_PLOAM_SN_RATE_NO_2G5 are set. It
+ * always goes out with ONU-ID PON_PLOAM_ONU_ID_UNASSIGNED and sequence number
+ * 0, as Table C.11.24 fixes both. @msg->onu_id and @msg->seq_no are not used
+ * for it.
+ *
+ * The layouts are ITU-T G.9807.1 Table C.11.24 for Serial_Number_ONU,
+ * Table C.11.25 for Registration, Table C.11.26 for Key_Report and
+ * Table C.11.27 for Acknowledgment.
+ *
+ * Return: the number of bytes written, -EINVAL for a message identifier the
+ * codec does not build or an ONU-ID above PON_PLOAM_ONU_ID_MASK, -ENOSPC for
+ * a buffer that is too small, or -ERANGE for a key fragment longer than
+ * PON_PLOAM_KEY_FRAGMENT_LEN.
+ */
+int pon_ploam_up_build(void *buf, size_t len, const struct pon_ploam_up *msg)
+{
+	u8 *body = buf;
+	u8 *content = body + PON_PLOAM_OFF_CONTENT;
+	u16 onu_id = msg->onu_id;
+	u8 seq_no = msg->seq_no;
+
+	if (len < PON_PLOAM_BODY_LEN)
+		return -ENOSPC;
+
+	if (msg->onu_id > PON_PLOAM_ONU_ID_MASK)
+		return -EINVAL;
+
+	switch (msg->msg_id) {
+	case PON_PLOAM_UP_SERIAL_NUMBER:
+		onu_id = PON_PLOAM_ONU_ID_UNASSIGNED;
+		seq_no = 0;
+		break;
+	case PON_PLOAM_UP_REGISTRATION:
+	case PON_PLOAM_UP_ACKNOWLEDGE:
+		break;
+	case PON_PLOAM_UP_KEY_REPORT:
+		if (msg->key_report.len > PON_PLOAM_KEY_FRAGMENT_LEN)
+			return -ERANGE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	put_unaligned_be16(onu_id, &body[PON_PLOAM_OFF_ONU_ID]);
+	body[PON_PLOAM_OFF_MSG_ID] = msg->msg_id;
+	body[PON_PLOAM_OFF_SEQ_NO] = seq_no;
+	memset(content, 0, PON_PLOAM_CONTENT_LEN);
+
+	switch (msg->msg_id) {
+	case PON_PLOAM_UP_SERIAL_NUMBER:
+		memcpy(&content[PON_PLOAM_SN_OFF_SN], msg->sn.sn,
+		       PON_PLOAM_SN_LEN);
+		put_unaligned_be32(msg->sn.random_delay,
+				   &content[PON_PLOAM_SN_OFF_DELAY]);
+		content[PON_PLOAM_SN_OFF_CAPABILITY] = PON_PLOAM_SN_CAPABILITY;
+		break;
+
+	case PON_PLOAM_UP_REGISTRATION:
+		memcpy(&content[PON_PLOAM_REG_OFF_ID], msg->registration.reg_id,
+		       PON_PLOAM_REG_ID_LEN);
+		break;
+
+	case PON_PLOAM_UP_KEY_REPORT:
+		content[PON_PLOAM_KR_OFF_TYPE] = msg->key_report.type & 1;
+		content[PON_PLOAM_KR_OFF_INDEX] = msg->key_report.index & 3;
+		content[PON_PLOAM_KR_OFF_NUM] = msg->key_report.num & 7;
+		memcpy(&content[PON_PLOAM_KR_OFF_FRAGMENT], msg->key_report.key,
+		       msg->key_report.len);
+		break;
+
+	case PON_PLOAM_UP_ACKNOWLEDGE:
+		content[PON_PLOAM_ACK_OFF_CODE] = msg->ack.code;
+		break;
+	}
+
+	return PON_PLOAM_BODY_LEN;
+}
+EXPORT_SYMBOL_GPL(pon_ploam_up_build);
+
+/**
+ * pon_ploam_down_parse() - read one downstream PLOAM message
+ * @buf:	the standard body, at least PON_PLOAM_BODY_LEN bytes
+ * @len:	how much is there
+ * @msg:	filled in on success
+ *
+ * Reads the header and, for the messages it knows, the content into the
+ * matching member. It decides nothing: whether the message is addressed to
+ * this ONU, whether the current state allows it and whether to acknowledge
+ * it are all the caller's.
+ *
+ * The layouts are ITU-T G.9807.1 Table C.11.4 for Burst_Profile, Table C.11.6
+ * for Assign_ONU-ID, Table C.11.7 for Ranging_Time, Table C.11.8 for
+ * Deactivate_ONU-ID, Table C.11.9 for Disable_Serial_Number, Table C.11.10 for
+ * Request_Registration, Table C.11.11 for Assign_Alloc-ID, Table C.11.12 for
+ * Key_Control and Table C.11.23A for Reboot_ONU.
+ *
+ * The codec checks one range only: the delimiter and preamble lengths of
+ * Burst_Profile. Every other field with a range in the Recommendation, such
+ * as the Reboot_ONU depth or the key index, is the caller's to check.
+ *
+ * Return: 0, -ENOSPC for a short buffer, -EINVAL for a Burst_Profile whose
+ * delimiter or preamble length is outside Table C.11.4, or -EOPNOTSUPP for a
+ * message the codec does not decode, which a caller may count and ignore.
+ * After -EINVAL and -EOPNOTSUPP, @msg->onu_id, @msg->msg_id and
+ * @msg->seq_no are valid, so that the caller can acknowledge the message.
+ * After -ENOSPC, @msg is not written.
+ */
+int pon_ploam_down_parse(const void *buf, size_t len,
+			 struct pon_ploam_down *msg)
+{
+	const u8 *body = buf;
+	const u8 *content = body + PON_PLOAM_OFF_CONTENT;
+
+	if (len < PON_PLOAM_BODY_LEN)
+		return -ENOSPC;
+
+	memset(msg, 0, sizeof(*msg));
+	msg->onu_id = get_unaligned_be16(&body[PON_PLOAM_OFF_ONU_ID]) &
+		      PON_PLOAM_ONU_ID_MASK;
+	msg->msg_id = body[PON_PLOAM_OFF_MSG_ID];
+	msg->seq_no = body[PON_PLOAM_OFF_SEQ_NO];
+
+	switch (msg->msg_id) {
+	case PON_PLOAM_DOWN_BURST_PROFILE: {
+		struct pon_ploam_burst_profile *profile = &msg->burst_profile;
+		u8 flags = content[PON_PLOAM_BP_OFF_FLAGS];
+		u8 repeat_mask;
+
+		profile->index = flags & 3;
+		profile->line_rate = (flags >> 2) & 1;
+		if (profile->line_rate == PON_PLOAM_LINE_RATE_XGSPON)
+			repeat_mask = PON_PLOAM_PREAMBLE_MASK_XGSPON;
+		else
+			repeat_mask = PON_PLOAM_PREAMBLE_MASK_XGPON;
+		profile->version = flags >> 4;
+		profile->fec = content[PON_PLOAM_BP_OFF_FEC] & 1;
+		profile->delimiter_len =
+			content[PON_PLOAM_BP_OFF_DELIM_LEN] & 0xf;
+		memcpy(profile->delimiter, &content[PON_PLOAM_BP_OFF_DELIM],
+		       PON_PLOAM_BURST_PATTERN_LEN);
+		profile->preamble_len = content[PON_PLOAM_BP_OFF_PRE_LEN] & 0xf;
+		profile->preamble_repeat =
+			content[PON_PLOAM_BP_OFF_PRE_REPEAT] & repeat_mask;
+		memcpy(profile->preamble, &content[PON_PLOAM_BP_OFF_PRE],
+		       PON_PLOAM_BURST_PATTERN_LEN);
+		memcpy(profile->pon_tag, &content[PON_PLOAM_BP_OFF_PON_TAG],
+		       PON_PLOAM_PON_TAG_LEN);
+		if (profile->delimiter_len > PON_PLOAM_BURST_DELIMITER_LEN_MAX)
+			return -EINVAL;
+		if (profile->preamble_len < PON_PLOAM_BURST_PREAMBLE_LEN_MIN ||
+		    profile->preamble_len > PON_PLOAM_BURST_PREAMBLE_LEN_MAX)
+			return -EINVAL;
+		return 0;
+	}
+
+	case PON_PLOAM_DOWN_ASSIGN_ONU_ID:
+		msg->assign_onu_id.onu_id =
+			get_unaligned_be16(&content[PON_PLOAM_AOI_OFF_ID]) &
+			PON_PLOAM_ONU_ID_MASK;
+		memcpy(msg->assign_onu_id.sn, &content[PON_PLOAM_AOI_OFF_SN],
+		       PON_PLOAM_SN_LEN);
+		msg->assign_onu_id.line_rate =
+			content[PON_PLOAM_AOI_OFF_RATE] & 1;
+		return 0;
+
+	case PON_PLOAM_DOWN_RANGING_TIME: {
+		u8 flags = content[PON_PLOAM_RT_OFF_FLAGS];
+
+		msg->ranging_time.absolute =
+			(flags & 1) == PON_PLOAM_EQD_ABSOLUTE;
+		msg->ranging_time.positive =
+			((flags >> 1) & 1) == PON_PLOAM_EQD_POSITIVE;
+		msg->ranging_time.eqd =
+			get_unaligned_be32(&content[PON_PLOAM_RT_OFF_EQD]);
+		return 0;
+	}
+
+	case PON_PLOAM_DOWN_DEACTIVATE:
+		return 0;
+
+	case PON_PLOAM_DOWN_DISABLE_SN:
+		msg->disable_sn.mode = content[PON_PLOAM_DSN_OFF_MODE];
+		memcpy(msg->disable_sn.sn, &content[PON_PLOAM_DSN_OFF_SN],
+		       PON_PLOAM_SN_LEN);
+		return 0;
+
+	case PON_PLOAM_DOWN_REQUEST_REG:
+		return 0;
+
+	case PON_PLOAM_DOWN_ASSIGN_ALLOC_ID:
+		msg->assign_alloc_id.alloc_id =
+			get_unaligned_be16(&content[PON_PLOAM_AAI_OFF_ID]) &
+			0x3fff;
+		msg->assign_alloc_id.type = content[PON_PLOAM_AAI_OFF_TYPE];
+		return 0;
+
+	case PON_PLOAM_DOWN_KEY_CONTROL:
+		msg->key_control.control = content[PON_PLOAM_KC_OFF_TYPE] & 1;
+		msg->key_control.key_index =
+			content[PON_PLOAM_KC_OFF_INDEX] & 3;
+		msg->key_control.key_length = content[PON_PLOAM_KC_OFF_LENGTH];
+		return 0;
+
+	case PON_PLOAM_DOWN_REBOOT_ONU:
+		memcpy(msg->reboot.sn, &content[PON_PLOAM_RB_OFF_SN],
+		       PON_PLOAM_SN_LEN);
+		msg->reboot.depth = content[PON_PLOAM_RB_OFF_DEPTH];
+		msg->reboot.image = content[PON_PLOAM_RB_OFF_IMAGE];
+		msg->reboot.state = content[PON_PLOAM_RB_OFF_STATE];
+		msg->reboot.flags = content[PON_PLOAM_RB_OFF_FLAGS];
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(pon_ploam_down_parse);
-- 
2.34.1

