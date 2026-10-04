Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99C400995
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087201; cv=none; b=QXSXMFxD0cLHFeWAxHYZlEc8rox9hBtXRMw5UHjOuEXrOWX7GPu+iz+eYJ4EwHPy0NJ6uEhQtAGlrv/iGHWaOTOzfZnXGal3J5K+49bokVTJfcrGIEK/laex1lD5PRmoIq/X+hDav16AkAnVDivwPY/ufYyAEbjmKM0v6ruDbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087201; c=relaxed/simple;
	bh=cLyUZfUYFXIzbCAwyOKQyHx4QBFz0Lt+G5rOXM9O4bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7ToqnI02+dO3YDIA0iIjwdTvLkTibyMzG753/AENL8PKjAmrRcrxyKXrea2n6fWZVKd9Z5Qb5yAiw0P/zLbAi9HUM8C8kDkf1eo53DN75g8VUXllKpRb9Uf7gETPbPsoL1DkTba9Gy0DrkY+DYM5WGJPlRwgZOeKRfCUmsxvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCANRId7; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCANRId7"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so679702eec.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087197; x=1791691997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6M1WYVkDHa9ex64IkHqpsltatAPllWLtUA7ND2mm+I=;
        b=gCANRId7P8QCeqqXBvD7vzYyJU+JLGwCykFm6ew9Hz65twCLXxzbaJPxmzBBGmPEj1
         HOJsS6JTSE4n8nMy3zrY6qhjEfHbZbeuAaBj0XMziR6uxj0lxroldqr0YcWmjKVco4Pm
         wqYsBsB2b9SrPPcwnx9WnUHUDpMYNt9BL73sbzoulLVIQm7b9OgVLwyJhbVAfP8sy0p6
         N9drKAfYpm2htikO7y9GqSwPlG5eUTsq6P7AAwMTdQiQhcYasqXkvKV8Le//jgSw2Cxo
         Fl6VJjv2ObzIC/70EzTs9dcupxw0BV4Yw4GdK0VCCSDxrShtkIoIWWQE3+Yr3kH8DD6l
         bS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087197; x=1791691997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G6M1WYVkDHa9ex64IkHqpsltatAPllWLtUA7ND2mm+I=;
        b=GDIHaLRKoL/mRvLTR1xOjWwfO6to2c1KMIqmHovJRFPsjt9zQ8QFl8cCTzTMRZuM4w
         GCEGJGcYUTRjAAHrVGIhZwZ90srh68czr5831cdJvYIlMwnT5CMzKMrgkqFOMsviqron
         KAQIUoXlx4ynwqwByLJ0gsWVC7HblDIK/sfaWVoiJhQaGiuYwUYpKjMs/AbGu9jwZEuw
         ys/3oiXPevDGNN8CRTilTi6VxN4j78a6hqSH5lcpTRsOPgEimLQgUwWj+3AP23pXV6aJ
         gn1Km2zEqMPc85pp3A0Cd8o46KUk30Vg1VX2TKr00+KDUpcafi4TvsfB1/sowsxIgjKH
         uRQw==
X-Gm-Message-State: AFuF++nFdOPgLjMg49hxNk+C2+FQjRi3kWfh20xvSSqWNIhzZB0z2SUu
	JG7aquF9Z7nldLxZrvwAMosygVXFAWb77LaaxyZYz2mgV+/zynUu9OonDzNfvQ==
X-Gm-Gg: AYBFou13TJufhl45zDtA9W5YrPc56aoXfMwzwoOzDNWt6XBTwn9MPZkYjyPL3y3jSGa
	5fAD5owiE97GYm6UcmDDVNLbs1hcHwi4VOon/tK88ZMqNPnIqDCY8O3wfOu2D3lZoqhF3QVl58t
	PAaXTE5eG6PtXDHVjmBIakZJR1sOgufk7tLsr9A4ccBl8UhG3Woj1xXUzbIJ/pzAZeEsL+IPe8G
	o1DhNyCqpwDqVVrJcKHDRXbCXPRYUKISe7nzcVUDsxaxNraHXneXxFhuoMgCsbKRiuAfsum/fy/
	2HobbWhJd+fUFe7fIVfZDOzL6tG2y9AQkCyiGNaZjG84AzJYTwqpV51mAKEPKD75yufQzmKc27x
	BZ01K5m42Ku+3IQWt2Hk3dYd5WnQrRJowmlAlO+qOxXC4G30JiuBn078/0H9C+cljI23QrQOJc9
	v+cCk24e0kvTTlF9WTpxwFZUmijlLiAaTpX/J9A+9F7YsNlOzAQSs6VOQ+gNEddBj7MCYngWYyc
	E3W4vY=
X-Received: by 2002:a05:693c:6391:10b0:34e:7f9a:c722 with SMTP id 5a478bee46e88-34f218665camr8553111eec.34.1791087196666;
        Sat, 03 Oct 2026 21:13:16 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm1366253eec.6.2026.10.03.21.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:13:16 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: [PATCH iproute2-next 1/2] uapi: import cfm_bridge.h
Date: Sun,  4 Oct 2026 04:13:06 +0000
Message-ID: <20261004041307.2683990-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004041307.2683990-1-w453y.me@gmail.com>
References: <20261004041307.2683990-1-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge CFM netlink attributes use the MEP domain, MEP direction and
CCM interval enums from cfm_bridge.h, but the header was never imported.
The bridge cfm command in the next patch needs it. Copied as is from
net-next.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 include/uapi/linux/cfm_bridge.h | 64 +++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/uapi/linux/cfm_bridge.h

diff --git a/include/uapi/linux/cfm_bridge.h b/include/uapi/linux/cfm_bridge.h
new file mode 100644
index 00000000..3c1cbd1d
--- /dev/null
+++ b/include/uapi/linux/cfm_bridge.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_CFM_BRIDGE_H_
+#define _UAPI_LINUX_CFM_BRIDGE_H_
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define ETHER_HEADER_LENGTH		(6+6+4+2)
+#define CFM_MAID_LENGTH			48
+#define CFM_CCM_PDU_LENGTH		75
+#define CFM_PORT_STATUS_TLV_LENGTH	4
+#define CFM_IF_STATUS_TLV_LENGTH	4
+#define CFM_IF_STATUS_TLV_TYPE		4
+#define CFM_PORT_STATUS_TLV_TYPE	2
+#define CFM_ENDE_TLV_TYPE		0
+#define CFM_CCM_MAX_FRAME_LENGTH	(ETHER_HEADER_LENGTH+\
+					 CFM_CCM_PDU_LENGTH+\
+					 CFM_PORT_STATUS_TLV_LENGTH+\
+					 CFM_IF_STATUS_TLV_LENGTH)
+#define CFM_FRAME_PRIO			7
+#define CFM_CCM_TLV_OFFSET		70
+#define CFM_CCM_PDU_MAID_OFFSET		10
+#define CFM_CCM_PDU_MEPID_OFFSET	8
+#define CFM_CCM_PDU_SEQNR_OFFSET	4
+#define CFM_CCM_PDU_TLV_OFFSET		74
+#define CFM_CCM_ITU_RESERVED_SIZE	16
+
+struct br_cfm_common_hdr {
+	__u8 mdlevel_version;
+	__u8 opcode;
+	__u8 flags;
+	__u8 tlv_offset;
+};
+
+enum br_cfm_opcodes {
+	BR_CFM_OPCODE_CCM = 0x1,
+};
+
+/* MEP domain */
+enum br_cfm_domain {
+	BR_CFM_PORT,
+	BR_CFM_VLAN,
+};
+
+/* MEP direction */
+enum br_cfm_mep_direction {
+	BR_CFM_MEP_DIRECTION_DOWN,
+	BR_CFM_MEP_DIRECTION_UP,
+};
+
+/* CCM interval supported. */
+enum br_cfm_ccm_interval {
+	BR_CFM_CCM_INTERVAL_NONE,
+	BR_CFM_CCM_INTERVAL_3_3_MS,
+	BR_CFM_CCM_INTERVAL_10_MS,
+	BR_CFM_CCM_INTERVAL_100_MS,
+	BR_CFM_CCM_INTERVAL_1_SEC,
+	BR_CFM_CCM_INTERVAL_10_SEC,
+	BR_CFM_CCM_INTERVAL_1_MIN,
+	BR_CFM_CCM_INTERVAL_10_MIN,
+};
+
+#endif
-- 
2.53.0

