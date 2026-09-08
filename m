Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1059B685
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887463; cv=none; b=L7t5YOitoRmUot+TG/5YfIY9tBW7R26pTsGNUjUPwRi4SHtXJ7HGO8g3OsBtWy1W1cbisTfpQ2jJ6eYcR5a4g1XPKKFTWLAffxBlOMMDq2vDicvGm4p7cih1zx3MBefJQoEsoxxLse3gpPFB8BiYBUJCghEeHf0P8IWNtfe8hrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887463; c=relaxed/simple;
	bh=/xXrRGDv6Jszk0sj0UbOjDjGSuSuowHtjBK+vXW0/Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDgXVizj4ETBvNJtNNbBJAJZbAKQXqhu06coo70fPyX4psAjhmNT5EOI3GcmyCTjp5NKnLgN+UCqj/uH1d8o+5Xdym6qMqkHAVFNu765pTEyUng1VAYpwEWw3tjnHYq2AQuG/SjaXUnb4YScxMXYvyjqmo+M0F4A8bGp9Ab06FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZczlrHR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RlT71/t2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZczlrHR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RlT71/t2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Fe3Iw3614102
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2FTgMhgLWmf0Jq8fB7caGXnFJscVEgzrr/HiqFpuFaU=; b=AZczlrHRn0oTuvm+
	u9vjy/xyJi6Uxt8MLyUCkTP5Z3IcPfTj/QNTir7WU/x0d3FiRb/ntb0APho+hKW1
	nMJt9RFViqU97eU6ORox5bhwO8vukjNi7X2JBXmg3y5W20/B8LlzrvJwDMV3+Rxc
	Q6yeFz740o06bCv8OdhV8mbwAWoYGNUdQ40kzvtocQ79JRd4bpoz+GWe5fMAtP0e
	O1F2SyswjBkGDLBK3xwJqjYLrUmW76ivPDSaAUk+6nbLtyuS/BbZKY5UeqPIEyjH
	16ZcgPvylrThs0wlyupKqcm1Z4kRqJEAxgDaWrFosXsPJHpUqNsQSKxAIzm0g63D
	6LatCA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjagukdx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f75c1219so24438605ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887459; x=1789492259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2FTgMhgLWmf0Jq8fB7caGXnFJscVEgzrr/HiqFpuFaU=;
        b=RlT71/t2JMB9Vcmu2WQJOMbJOjIfyYOPp6otm1lQEkkVMN1Awoe5kUbar4HWauDTum
         dQL3EDHQSHeh9riSn4nO0dpytFwfjdNgqHnQ6nP/b7WMI2ucFxW/D09ALT5tlZ43Gp6a
         4mfZp8XLNgZ3EK7r6LLtuXzctaDtQkf8Rz0lleg3zSLDP3KY8lpit+4zRnmc6I6Wsf9p
         SuR5ir+CZrOuPRS7AB2VNSx2w2/OpyA7GkgvdO+rIlRwykNlujl0xKr24Qlnr5ASik4P
         xI/v0HqSurhQXH31rJg1ZFHP71HXsFcZf7Swp1cfLI/Fe+sJs5Iceuhm1cltDZ5J0G1g
         bzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887459; x=1789492259;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2FTgMhgLWmf0Jq8fB7caGXnFJscVEgzrr/HiqFpuFaU=;
        b=QH6QZws7gSxymOdaBX/LjObUKM9awTQgHrFYorsMd9H1lZgwnKvpjfUD6bAm2oRMPu
         esPBSyKz/fz3pmtj4lWUv1cqEAG6BrZ03+mabbhqrY9bfSmeLHg1g/ib9xinjwPpiYUE
         28IrWHilAtzaHE/VSNR1l3CvbBWVwalA6fZiBhXrXc6TzY6OvBvpxa4rJQlrEGL8MPjj
         lGk0Z4NW+gZsmOECGhcYaM8Sg8O7Wg9aIwJ9NN8/8JWTn5zWimbjxtlgg9SHmhInBaBM
         Fo5ru8ZcwAf9VKvR/9YZsUiRWstb6+cttcwzm5nUb406guA007ZUX8isQJDAHLgPJDKK
         oPsA==
X-Forwarded-Encrypted: i=1; AKwUvBzcTY8gJXt1ZLsg+1F2aghzVo7xVY6/adPsGBUz6ouyLZSGl5jccsH9q+KNjvvB8lwxKFSKz0s=@vger.kernel.org
X-Gm-Message-State: AFuF++nsJa5lcX559eQXfMsJQifLd3Yzu/KAEOrc/cFyewmR1P79dabi
	tQGYTFyOnloB5Pjl/kLB3ZFyVupDK95NUBzuZ2tiD6XNtl8yGG3PT+wknKMdexKQoEdGnuv9/P9
	37Ycv9lzrYBYzq2KdFsn6daV1gtXlJeqi+1XKNC9Tep49s6aJmcOK03T+uQ==
X-Gm-Gg: AYBFou1BjTHVkbC1KhQUPYkgSnf1COyBEBuHlOljigQMWjok307TIVNKOi8pZjca47M
	12Pud50ZULodYe6mjhw/Zdk0aOjeZMjPxNMQ6oiQMHDkKdiQ2/qRfRAP3cORzs51pOsjDolL2Nn
	VGj392LKhrKjruQJbx8fPHZpTahbkriso8fRGBN/UyvwhqATm/u7v/rfl5lPnB83In3Y7WcKMyv
	oiaPBNZ/qW5fWhVumvf5aSR55zODKOGj3GM4JXNqLp+kopEF1Xs4q5EEyDBEKPQBGBZ494ohBos
	2CGdkkknMVfktYzAWuJmpkKN9aFDVtXcj7ORGns0DGaa7/o2u+HtlrLfy18ZtPF8KPLteQkDtuA
	ZORPN8PLYZxfGsT9PAs0aJGsAb6fX9NDJLbRApdQzn/pWh84P50piz6y/lwOIa3RmLBizu9IvoO
	dgcHsbHCnhb7wF2UhY+PmUiw==
X-Received: by 2002:a17:90a:dfd0:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-39b260de667mr45062835a91.4.1788887458466;
        Tue, 08 Sep 2026 10:10:58 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-39b260de667mr45062771a91.4.1788887457864;
        Tue, 08 Sep 2026 10:10:57 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:57 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 13/18] wifi: cfg80211/mac80211: Handle UHR Link Reconfiguration frame
Date: Tue,  8 Sep 2026 22:39:41 +0530
Message-Id: <20260908-smd-v1-13-9fd2d876a1fb@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
References: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6aa041a3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LQFPhaWwRXareCLbuGQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: VnCvB3Qf-10c26Y-Iblk7WLLOxv2DBWN
X-Proofpoint-ORIG-GUID: VnCvB3Qf-10c26Y-Iblk7WLLOxv2DBWN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXyR/ZxEiupk8h
 CUgkKnFxm4ubzEUpjz4EXQkWBx00228mmVJ0ueTGLUJKiRr+dkRJ6RULErx9NkJLWtzwY2TWB9K
 OTsgKuCNeGAB9SBqn1EJzQPOSXTnq/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfX27o4rXb8sWYL
 ZoRntqEK7VxmFI97m4/CbBMYRfRdCYTcmD/BZfQNjpxLuAJUNZIhv9TVO3rCpAElKCjW27OBVWA
 jTz6iYjxy+99o6PKkZKYKm0VihUjgRGukIvDZiWmVr9B/h+PGtFXjM1wygCW1GlkLXbIaCLpmVa
 6Z2ytsdjRGdi/dlG4/V8sSIjW2XtC6n2D9CsdHqf7PPL90k+gKPFytRYbxK0Edi3uzY3B2ZuPKX
 MIqgk9wmhaPhxzHIG0Qc7Blo5/6Xlo30r2kbzcQXHF3stxh9C0WjQO5rhyycyyWpveUQGi9EKg7
 Wk+GhLWk1RotQcx95zfyqbHQ4sWeIGhM8LkBTjbzQsi7GEN9aTmRmE4HEALeZapPTdxNhJph9En
 41J8hmlUSraSuISoJX7xqWr0zbYX+/iM0eRkoy5cqwTpNTDjyJDQN7O9VJE+dnub+S9qpQEBwK3
 p3i+H0UWHq0fmBm8n7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080185

The UHR Link Reconfiguration Request frame triggers SMD BSS Transition
on the current AP MLD. At the point where mac80211 forwards this
frame to userspace via nl80211_send_mgmt(), the driver has already
collected the STA's dynamic context (SN, PN, BlockAck state) and
attached it to the SKB via the SKB_EXT_WIRELESS extension. But this
information is not known by nl80211 to pack the context with the frame
sent to userspace.

Add handling for the UHR ST Preparation and Execution request frames
in ieee80211_rx_h_userspace_mgmt() to pull the ieee80211_smd_ctx
pointer from the SKB extension and store it in cfg80211_rx_info, so
that nl80211_send_mgmt() can include it in the NL80211_CMD_FRAME event.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/linux/ieee80211-uhr.h | 59 +++++++++++++++++++++++++++++++++++++++++++
 include/net/cfg80211.h        | 13 ++++++++++
 net/mac80211/rx.c             | 22 ++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index f904b1e65f10..cda8251a1a9a 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -743,6 +743,65 @@ ieee80211_uhr_mode_change_tuple_size(const struct ieee80211_uhr_mode_change_tupl
 			     IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_LENGTH);
 }
 
+/**
+ * ieee80211_is_uhr_link_reconf_req - check if frame is UHR Link Reconf Request
+ * @skb: the SKB to check
+ * Return: whether or not the frame is a UHR Link Reconf Request frame
+ */
+static inline bool ieee80211_is_uhr_link_reconf_req(struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	u8 category, action;
+
+	if (!ieee80211_is_action(mgmt->frame_control))
+		return false;
+
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE(uhr_link_reconf_req))
+		return false;
+
+	category = mgmt->u.action.category;
+	action = mgmt->u.action.action_code;
+
+	return category == WLAN_CATEGORY_PROTECTED_UHR &&
+	       action == IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_REQUEST;
+}
+
+/**
+ * ieee80211_is_st_prep_req - check if frame is ST Preparation Request
+ * @skb: the SKB to check
+ * Return: whether or not the frame is an ST Prep request frame
+ */
+static inline bool ieee80211_is_st_prep_req(struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	u8 type;
+
+	if (!ieee80211_is_uhr_link_reconf_req(skb))
+		return false;
+
+	type = mgmt->u.action.uhr_link_reconf_req.type;
+
+	return type == IEEE80211_UHR_LINK_RECONFIG_REQUEST_ST_PREP;
+}
+
+/**
+ * ieee80211_is_st_exec_req - check if frame is ST Execution Request
+ * @skb: the SKB to check
+ * Return: whether or not the frame is an ST Exec request frame
+ */
+static inline bool ieee80211_is_st_exec_req(struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	u8 type;
+
+	if (!ieee80211_is_uhr_link_reconf_req(skb))
+		return false;
+
+	type = mgmt->u.action.uhr_link_reconf_req.type;
+
+	return type == IEEE80211_UHR_LINK_RECONFIG_REQUEST_ST_EXEC;
+}
+
 #define for_each_uhr_mode_change_tuple(data, len, tuple)		\
 	for (tuple = (const void *)(data);				\
 	     (len) - ((const u8 *)tuple - (data)) >= sizeof(*tuple) &&	\
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 75d0123fbb5d..7b0f328fec79 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4887,6 +4887,17 @@ struct mgmt_frame_regs {
 	u32 global_mcast_stypes, interface_mcast_stypes;
 };
 
+/**
+ * struct cfg80211_smd_transition_info - SMD BSS Transition info
+ *
+ * @ctx: Dynamic context to be transferred as part of ST
+ * @type: Type of ST indication
+ */
+struct cfg80211_smd_transition_info {
+	struct ieee80211_smd_ctx *ctx;
+	enum nl80211_smd_ctx_type type;
+};
+
 /**
  * struct cfg80211_ops - backend description for wireless configuration
  *
@@ -9543,6 +9554,7 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
  * @flags: flags, as defined in &enum nl80211_rxmgmt_flags
  * @rx_tstamp: Hardware timestamp of frame RX in nanoseconds
  * @ack_tstamp: Hardware timestamp of ack TX in nanoseconds
+ * @st_info: SMD BSS Transition data in skb extension
  */
 struct cfg80211_rx_info {
 	int freq;
@@ -9554,6 +9566,7 @@ struct cfg80211_rx_info {
 	u32 flags;
 	u64 rx_tstamp;
 	u64 ack_tstamp;
+	struct cfg80211_smd_transition_info st_info;
 };
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 40ed03a775ba..156a4c0d55ac 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3993,6 +3993,24 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	return RX_QUEUED;
 }
 
+static void
+ieee80211_rx_h_userspace_mgmt_st_frame(struct cfg80211_rx_info *info,
+				       struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)info->buf;
+	struct wireless_skb_ext *ext;
+	u8 type;
+
+	type = mgmt->u.action.uhr_link_reconf_req.type;
+
+	ext = skb_ext_find(skb, SKB_EXT_WIRELESS);
+	if (!ext || ext->type != WIRELESS_SKB_EXT_UHR_SMD)
+		return;
+
+	info->st_info.type = type;
+	info->st_info.ctx = ext->uhr_smd_ctx->smd_ctx;
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 {
@@ -4003,6 +4021,7 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 		.len = rx->skb->len,
 		.link_id = rx->link_id,
 		.have_link_id = rx->link_id >= 0,
+		.st_info.ctx = NULL,
 	};
 
 	/* skip known-bad action frames and return them in the next handler */
@@ -4024,6 +4043,9 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 	    ieee80211_is_ftm(rx->skb)) {
 		info.rx_tstamp = ktime_to_ns(skb_hwtstamps(rx->skb)->hwtstamp);
 		info.ack_tstamp = ktime_to_ns(status->ack_tx_hwtstamp);
+	} else if (ieee80211_is_st_prep_req(rx->skb) ||
+		   ieee80211_is_st_exec_req(rx->skb)) {
+		ieee80211_rx_h_userspace_mgmt_st_frame(&info, rx->skb);
 	}
 
 	if (cfg80211_rx_mgmt_ext(&rx->sdata->wdev, &info)) {

-- 
2.34.1

