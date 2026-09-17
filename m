Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C36440A19
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627571; cv=none; b=CT1P9IF4s8va31XYIW+9WqGAqwVpDZLq2jk8rd/TD2lc26y60rVgkr+bU6+BqBXrLaoM57X9ncWP7rShyqHr1F3p16DGNSGpDD9JrQ5ODvWchL1IgS5jBCWluKZXPz8FyiLOs2JC7EqY0vo2KNZxhaexS6aNcE0mQLO8ANI9Hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627571; c=relaxed/simple;
	bh=7CTJlmlkpUV75kzLCWq5iYzg6XYHKDImSoSt4OPBDWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVYk4WC2+OMxugBC5pCvo0qQ+r3erTOG4L8r0TbLfmB1vM6BZZ62P8Gp4o/D4JVhG9ZD0yG7KhxDgeQj3jVNt41jNx9afZjjc99MXNVIxmFRXTLyhbaFPKJdpsT2svF2kdLlvwlC8LPmy5GWz7APv7t6I3dI+rubQfxy+K6tfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a9d6kqpW; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a9d6kqpW"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2db710396ffso3331215ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627566; x=1790232366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SMSuN4WTt6I7qMCgUb4Qu38XrQnC03P67hyi5FUJGKw=;
        b=xploV8saogab6Eusy+YP2NO8iqp7Bnh12R2dmfMReiBrbwqZkj+sfA3O2lc+pSmgKC
         shByMHCJdqqXS0cV9raGAJi7ipKHXb/pkmH0kUeroX9uUiJ/2m3Lr3B8KDj9yduQ0Ahh
         Bml3IrTyjdmtTm1VyF/h9GaWNXwW/rM1oKvZJmM90Gooq1KbAzbrf+In6GQCj5/nSmhU
         5d7nF8CJfYZ6SiNI1QtLVka9U16hXKTytsXnsKHX0L6x8gyyzxAtNwS83dVXt9XQBGex
         kGT1MXBcxz0yDnnmRD2lUYeNnLHXA75I24S48mL+IJME/2yNQxO5jeLwqersSqrkIWQ3
         SF0w==
X-Gm-Message-State: AFuF++koSS4HbLY40DCWEWKn3YNr8diHQbuXfWJvBIX0Xm7NXglirD1G
	6cBMYI5ZWlFaeDFU2GcLzNeG6UC7NuD9ZPEcogdDGOST4ITLT8Qb3TAYydj57WHr6Ke3E/t1fDs
	HsEUjOB5iSVELyBJryzpamXvGGZACC80u8ZtGjPKUCzJlTsOzHUPyG6saEaKXcoiIgDA7/FiZdL
	vbnHiOlDOTCIShVL09pbL8k1HP8uEUXeEUeSI3bGJzkdy6rdvFGMxjDNnhthjP/c500fIGwlF76
	toyKVVGZw==
X-Gm-Gg: AYBFou1/cSKGrteVETF+9TC5LN9nvc+UmDMuMA4aZLFBwJ/bNm8rt8n7UUQEMXR1Px7
	QPOmMKQKKQhL40OMXaBtNwrhLLOB3to/9unScSqzkHipCzXSzoxxl1zVNYBIB0tg3jdy4g8CQJO
	wCT/nX4BObKDhX+1T2Rav04LQIcMImDOJbyMESlMREfhIIhF6Xtct81x1w3tGddulh3bSoHfDt2
	f5vAEiqLmqJQVs+JeA0VRJA0/esTJYmOzD4c4uxTLwRqUEaZD1RYDDtbCpWiDaXGN8gC0hXQZZK
	boCDLPD1Ta63REh1fAHmKAg5VlJobFkQMo1UThYuYKBB1imqHwzwNT9l7r+/sMsuXUNBV4FM2ml
	RVOMAYRWSd3IpM0/OaFq7MmWSDb4A064U8qN4DeO0LwWuUa7g5CX+zHC9SHxGCvJo6LTXwIdl1K
	uFnq9ZjRJuRod+/wHy+KO4RJMbIC88uGoxTQ==
X-Received: by 2002:a17:90b:3f87:b0:39e:252b:86c5 with SMTP id 98e67ed59e1d1-39e35daaabdmr3323501a91.1.1789627566205;
        Wed, 16 Sep 2026 23:46:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e35d7bc01sm1064978a91.1.2026.09.16.23.46.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 23:46:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so446557a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789627564; x=1790232364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMSuN4WTt6I7qMCgUb4Qu38XrQnC03P67hyi5FUJGKw=;
        b=a9d6kqpWtL8f3xL+pcNvBpp/Weaiqlufri4Yy8whZ6Nd2YUWHRkFDAYOtCs2zktuu6
         ub20IFHF7NNTWK3sgoLoM7E9zVjbAB+oc2UUM9igWP9nlWsPLCbSU1vXJk1wIpdJcrlR
         WQJqQDwOWUo8W/dLmi3sNZUzwilnFizQPbqkQ=
X-Received: by 2002:a05:6a21:e8a:b0:3dd:65a5:a33 with SMTP id adf61e73a8af0-3dd725dca83mr3849717637.10.1789627564511;
        Wed, 16 Sep 2026 23:46:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8a:b0:3dd:65a5:a33 with SMTP id adf61e73a8af0-3dd725dca83mr3849663637.10.1789627563900;
        Wed, 16 Sep 2026 23:46:03 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm2754293a12.20.2026.09.16.23.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:46:03 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v3 01/11] bnge: update HSI
Date: Thu, 17 Sep 2026 12:15:38 +0530
Message-ID: <20260917064548.773334-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917064548.773334-1-vikas.gupta@broadcom.com>
References: <20260917064548.773334-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Update HSI to support future patches implementing multi-RSS and
NTUPLE-related features.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 include/linux/bnge/hsi.h | 136 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/include/linux/bnge/hsi.h b/include/linux/bnge/hsi.h
index 1f7bd96415a5..d4fe662d60b1 100644
--- a/include/linux/bnge/hsi.h
+++ b/include/linux/bnge/hsi.h
@@ -8607,6 +8607,7 @@ struct hwrm_cfa_l2_filter_alloc_input {
 	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_MIRROR_VNIC_ID      0x10000UL
 	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_NUM_VLANS           0x20000UL
 	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_T_NUM_VLANS         0x40000UL
+	#define CFA_L2_FILTER_ALLOC_REQ_ENABLES_RFS_RING_TBL_IDX    0x80000UL
 	u8	l2_addr[6];
 	u8	num_vlans;
 	u8	t_num_vlans;
@@ -8663,7 +8664,8 @@ struct hwrm_cfa_l2_filter_alloc_input {
 	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_MIN          0x4UL
 	#define CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_LAST        CFA_L2_FILTER_ALLOC_REQ_PRI_HINT_MIN
 	u8	unused_5;
-	__le32	unused_6;
+	__le16	rfs_ring_tbl_idx;
+	__le16	unused_6;
 	__le64	l2_filter_id_hint;
 };
 
@@ -8900,6 +8902,95 @@ struct hwrm_cfa_tunnel_filter_free_output {
 	u8	valid;
 };
 
+/* hwrm_cfa_ntuple_filter_alloc_input (size:1024b/128B) */
+struct hwrm_cfa_ntuple_filter_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_LOOPBACK              0x1UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DROP                  0x2UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_METER                 0x4UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DEST_FID              0x8UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_ARP_REPLY             0x10UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DEST_RFS_RING_IDX     0x20UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_NO_L2_CONTEXT         0x40UL
+	__le32	enables;
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_L2_FILTER_ID         0x1UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_ETHERTYPE            0x2UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_TUNNEL_TYPE          0x4UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_MACADDR          0x8UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_IPADDR_TYPE          0x10UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_IPADDR           0x20UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_IPADDR_MASK      0x40UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_IPADDR           0x80UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_IPADDR_MASK      0x100UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_IP_PROTOCOL          0x200UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_PORT             0x400UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_PORT_MASK        0x800UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_PORT             0x1000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_PORT_MASK        0x2000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_PRI_HINT             0x4000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_NTUPLE_FILTER_ID     0x8000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_ID               0x10000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_MIRROR_VNIC_ID       0x20000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_MACADDR          0x40000UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_RFS_RING_TBL_IDX     0x80000UL
+	__le64	l2_filter_id;
+	u8	src_macaddr[6];
+	__be16	ethertype;
+	u8	ip_addr_type;
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_UNKNOWN 0x0UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV4    0x4UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV6    0x6UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_LAST   CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV6
+	u8	ip_protocol;
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_UNKNOWN 0x0UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_TCP     0x6UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_UDP     0x11UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_ICMP    0x1UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_ICMPV6  0x3aUL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_RSVD    0xffUL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_LAST   CFA_NTUPLE_FILTER_ALLOC_REQ_IP_PROTOCOL_RSVD
+	__le16	dst_id;
+	__le16	rfs_ring_tbl_idx;
+	u8	tunnel_type;
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_NONTUNNEL    0x0UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN        0x1UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_NVGRE        0x2UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2GRE        0x3UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPIP         0x4UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_GENEVE       0x5UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_MPLS         0x6UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_STT          0x7UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE        0x8UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_V4     0x9UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL    0xffUL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_LAST        CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL
+	u8	pri_hint;
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_PRI_HINT_NO_PREFER 0x0UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_PRI_HINT_ABOVE     0x1UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_PRI_HINT_BELOW     0x2UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_PRI_HINT_HIGHEST   0x3UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_PRI_HINT_LOWEST    0x4UL
+	#define CFA_NTUPLE_FILTER_ALLOC_REQ_PRI_HINT_LAST     CFA_NTUPLE_FILTER_ALLOC_REQ_PRI_HINT_LOWEST
+	__be32	src_ipaddr[4];
+	__be32	src_ipaddr_mask[4];
+	__be32	dst_ipaddr[4];
+	__be32	dst_ipaddr_mask[4];
+	__be16	src_port;
+	__be16	src_port_mask;
+	__be16	dst_port;
+	__be16	dst_port_mask;
+	__le64	ntuple_filter_id_hint;
+};
+
 /* hwrm_cfa_ntuple_filter_alloc_output (size:192b/24B) */
 struct hwrm_cfa_ntuple_filter_alloc_output {
 	__le16	error_code;
@@ -9014,6 +9105,49 @@ struct hwrm_cfa_ntuple_filter_cfg_output {
 	u8	valid;
 };
 
+/* hwrm_cfa_adv_flow_mgnt_qcaps_input (size:256b/32B) */
+struct hwrm_cfa_adv_flow_mgnt_qcaps_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	unused_0[4];
+};
+
+/* hwrm_cfa_adv_flow_mgnt_qcaps_output (size:128b/16B) */
+struct hwrm_cfa_adv_flow_mgnt_qcaps_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	flags;
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_FLOW_HND_16BIT_SUPPORTED                     0x1UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_FLOW_HND_64BIT_SUPPORTED                     0x2UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_FLOW_BATCH_DELETE_SUPPORTED                  0x4UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_FLOW_RESET_ALL_SUPPORTED                     0x8UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_DEST_FUNC_SUPPORTED              0x10UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_TX_EEM_FLOW_SUPPORTED                        0x20UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RX_EEM_FLOW_SUPPORTED                        0x40UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_FLOW_COUNTER_ALLOC_SUPPORTED                 0x80UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RFS_RING_TBL_IDX_SUPPORTED                   0x100UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_UNTAGGED_VLAN_SUPPORTED                      0x200UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_XDP_SUPPORTED                                0x400UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_L2_HEADER_SOURCE_FIELDS_SUPPORTED            0x800UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_RX_ARP_SUPPORTED                 0x1000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RFS_RING_TBL_IDX_V2_SUPPORTED                0x2000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_RX_ETHERTYPE_IP_SUPPORTED        0x4000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_TRUFLOW_CAPABLE                              0x8000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_L2_FILTER_TRAFFIC_TYPE_L2_ROCE_SUPPORTED     0x10000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_LAG_SUPPORTED                                0x20000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_NO_L2CTX_SUPPORTED               0x40000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NIC_FLOW_STATS_SUPPORTED                     0x80000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_RX_EXT_IP_PROTO_SUPPORTED        0x100000UL
+	#define CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RFS_RING_TBL_IDX_V3_SUPPORTED                0x200000UL
+	u8	unused_0[3];
+	u8	valid;
+};
+
 /* hwrm_tunnel_dst_port_alloc_input (size:192b/24B) */
 struct hwrm_tunnel_dst_port_alloc_input {
 	__le16	req_type;
-- 
2.52.0

