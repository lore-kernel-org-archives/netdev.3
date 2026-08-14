Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A722ECD3A
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670094; cv=none; b=rL5/afhDrCEZz7NAq91gDcO4v4oqjfxktNDEwRtLbFv1JjvUrZrAEYJnHIAuxHFTy2+hOFW5Sbfzg3h7n1oCK278g4VOCCYmUFqzu20gDslScVuHq8dxxIsHRh4MnjarPHN23QW5wqN3sw4VPYbFrr7nONcQZDPdfJjzsC9C0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670094; c=relaxed/simple;
	bh=zcmVR3l7ahMlydcfRMN+yimigUnP6+v+XWW+V3r93/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1MnyhvTZ2HehpsyOa5qYmy4BLkeFb22Zu7M6ObyzB2HUOU3HiGj52LXKMv1KkWNhthB0aW5c/DlywwpT8wEn48jhjH+qfOoqlnE1yEPtWK6lL7Q4lt1IZa5WlTJSFguQVwNFizrrMjw1AQnsO7nbhKECA4wLfROOLPDMt9uBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NoUpOv4f; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NoUpOv4f"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so647826a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670093; x=1787274893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KXCfAs7P0Tud1PL6Pg08rfFWzncvU2RIhOfNbNzN5E=;
        b=ss047Z8g7Anvq2SJZ4Ga1AN5p2sQHLgkoAAaXKouaRHeFsi0oaqKypqxilbgzsiYWK
         ZUdC/1M4LlB/rpDY+Oq6+TI4R7Hf5T4gPMQPWm6JLZbSfoZvVTmWO/Czm79MlAZ/HcjS
         6twjJRv6R9NKfWuHpk3fEqBK6vxt5dTH1M+BoJTjb4Kx1cFrkKixHraTvXKE/bHT3zkQ
         9xxVZxvjYjzs5O7qBxTVspMnVdFTw73NN5ixWkvH/rRQprJzkmAMi8ppnrQDb5WSn3pt
         gbsrx1RFr3wcuJpY3Ab3/3tyGi1OsInGo2GKdREaBQVfAZS8J0J1KP0/msxoXrj57Ocw
         WQ6w==
X-Gm-Message-State: AOJu0Yx6xFUa3lasTTsub9p7z1TeLyqcF03POkQukJR2tU2hwjjm/GP8
	Lue5pBeYY1JzDlpKFVBGrMWVKOQLzL4OxqOjV4GnHr/2yo2QrEGdBuK+Gy8Z3x/TBxpFuG8UnLo
	tYwaP3dk5+tem3TI9RNkIsmXphfHZZn/zoeCN8+GiIQxcxgvAR+reKRKx0KW2McNPeYdjPXpiNo
	jspbPluHwelLrG2cEarq5Sbi9TtJCJqr+IPuWuDl8M8HXKpBdvaeev2HSYgb4eH0olbiKRiGiYl
	LgSnkj4/w==
X-Gm-Gg: AR+sD12Vr1B3kHNtvxYL/mUc37ilGaToUwpsB4pLLwuzVkkqv/erqBwcfcBV2DckfG+
	dpYr9ppzCM6dXT9hKPTjJHmAJoMbiHdiAxajd3aLlCrHubphWY21C3CQYb82Hp7ebZD24kGUuJy
	KP93lOm+fuznHoTfClblz4c3J49jg8fDOwDAtiIDUa9dmQNSWUjG8L6Rb4vfb0RsZsFUFT8ZqZa
	B48j32WzFLw9bsYV0eud5sQnc7JQOO0358Uqt/rr+5oJlcZNmq3Y3ZzBUNdLTcKEQRGaUbwQ3SG
	qqzoLkneN3lWLiHfZyknVs4Bo2mgtHgoPwW/BF8ANwq5xzTazP/DhS9vtUjCYCZK38QHQpSLZpg
	OO1dB5XX1X9TA2gdAtl7uc5yeFcgpxCOjTMSao6EavSeGoiqeH7m7HW1qJVEjQMRtRo3jk1JF2B
	tuGzW7LBMHFy9ClvJI3VUwky+i+E+XLKQ=
X-Received: by 2002:a17:90b:3d43:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3933b811e2dmr2252169a91.7.1786670092495;
        Thu, 13 Aug 2026 18:14:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394eb776e88sm107609a91.12.2026.08.13.18.14.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:14:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-392cf18db8eso705998a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670091; x=1787274891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KXCfAs7P0Tud1PL6Pg08rfFWzncvU2RIhOfNbNzN5E=;
        b=NoUpOv4fiTYBVu/7hzvMGPbK9nBG2l2XvZvWAexJKwOGB1jtGOgk8k9/JU5qEduMTB
         vZBn0FNEjg375nnqYs4C1PNmk5+h5j49vFVdpZbT4K//RPFsrt4t3lDzOlb3YeRHCnbu
         E+ciyf203eX+8DXxWiIzmS/RZo0PIIRwIDk7s=
X-Received: by 2002:a05:6a21:e8b:b0:3cb:eb06:ce09 with SMTP id adf61e73a8af0-3cc71de3b98mr2019232637.25.1786670090583;
        Thu, 13 Aug 2026 18:14:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8b:b0:3cb:eb06:ce09 with SMTP id adf61e73a8af0-3cc71de3b98mr2019169637.25.1786670090108;
        Thu, 13 Aug 2026 18:14:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:14:49 -0700 (PDT)
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
Subject: [PATCH net-next 01/11] bnge: update HSI
Date: Fri, 14 Aug 2026 06:44:25 +0530
Message-ID: <20260814011435.194631-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814011435.194631-1-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
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
2.47.1

