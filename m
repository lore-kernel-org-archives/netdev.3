Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5443934D
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813207; cv=none; b=TvuQCNGq1jAuIbl31+7QaCjp6G4YYZ1Ro9rVYvrOxoRjnkT2HXASMMWuSYPCnD0lyM6t7/60Ajt437s4lzeAQUQBF0nihUtBiaCBtuvjNlLW6xt1X2e7+EPvbPoJQk+Gc2HK4NAaGv71BYfuuVUlZ5SC9ycRj1ANm8sT25yVn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813207; c=relaxed/simple;
	bh=BdDhSKqvE4bR6i94Z4PzJjpFNgCG9vS4dOfg0BJDMsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkFZcThU9kgVvnbdZQfBRAy0XVu+GGHp7HTvNM1V1RirGSUl6RcH2l5aZ7tLkNkb9YkgGUDZ20LbAPOF6Njzbopm1qSO2QzQEktgtxbzM3BmiZVDmrAUJ8qRlwY4KW71zJxbgZEdkIIne3IL76h5vZbw6DKoHBBFIfPqYGALE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iRY5eD/v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HeU7Y0/D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iRY5eD/v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HeU7Y0/D"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H7lGd1642059
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VQNR1mlZBEy+Xn7d0FfH0MwnsJQZNZ8utWBVHbu9Dpk=; b=iRY5eD/vXoH7sv8P
	k8JzvCxHSs9P+RfQUWcXUBDFagdmKTDSCzC4PTpuSp0UQXIgR+tINCzlXBWZAJvD
	9r5K3FQvYY7rJ+FmCl9Gxy5+6pDtaCMIx8aQc5780VQOi0HEUka/11YzUMKwCih5
	E6ZRNxwR5j5tGBIZqWfzzSKywD7HKs6CoG5fnwjEMpGSuATYrUOHmnnqLy1gbDpH
	IVwJ72CbXWr0Jgn76pcpqY0r8Dj1hWA6ZuW7s+B2UhJLkHd8hCJENRSyCRa0QViP
	EBmvQ9UnwaTZAA0Hc8MP0z6MZQIZ9K5Wqc5nmoIkxVyg+fQ6oBDB78WqDgU0oZZV
	ckUvrQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghruaaxbu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:33:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968dfff779so5337206a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788813205; x=1789418005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VQNR1mlZBEy+Xn7d0FfH0MwnsJQZNZ8utWBVHbu9Dpk=;
        b=HeU7Y0/DD2FGMiIVgdSdANn9SZ14Xvk+gZOg51XBt4TPfaULo4MwspvU7lxE5lMffH
         K8MXE62ziN5JGGondvpSoSbF60Tq4KLfLnoX3+tW4fNr8lWgbfJfEYpetmna+VgtDfEc
         tmVwo9bLhB9e2t7MyCBwor5CMPlG2fQQVbMUAbnG2n5TG4OxflFnOwsJ9Vn5epPLWnPQ
         xKFB2i0YxDIwYk0Ms6OwvA3IOsvWNUFxiNEiNbcIjV0NaVQLRIbByVw0LFeDV4bRtPGP
         0XukB6HsN/7bxPk0k4USxxCEFqbMGkGT/4OvZFg8gMeFlFqmKlsMhYqH/xghBIDENA1y
         RdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813205; x=1789418005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQNR1mlZBEy+Xn7d0FfH0MwnsJQZNZ8utWBVHbu9Dpk=;
        b=qwpxvXCJDiBQviNvPmwdfdbohodERxtE005RCP7gLa15b4f8j4OkU22doU9Ja9y2OB
         G0cfuBVheAR/noLK5GlDSpCuBr7Rav1ou+J+XKHJP3aiQ5hlvX7P/CW7km1IUeN6kX6l
         mKNHfWsdsFFEj3UbmrqU/HL8ngXDGtO61W8dtId1SP09BPfdX8zHF/tLax1PvqfrF+0u
         NNopwmD8OdQNg7NiG3ghdWCG+e7bwllbOfRCedienqU0OvZTyHu/zKyLWOdkGwQ0wPxi
         DlUcLFqFY4vzf45Pbf/GiV+223fxX7rgtEXMUN7rXBbqPzW2au43whhKLXAYKTbuIJHm
         f6Ig==
X-Forwarded-Encrypted: i=1; AKwUvByYZ/guBkFvV6fhKXT2seEKHMP0slh4WN5gE6THD8DjvsRGXC8UHrso08/oAV943vVnap0pWBs=@vger.kernel.org
X-Gm-Message-State: AFuF++mqnsZALKRz/9HvftOlYwgwpvszNvtAuloFcC3VFEL/yuhOAwAc
	Ur3HL9d2VxPcP7P7bX2L0agWGGQ5/r9QK0PvexcSbQz4rpKBNiQc+BFXS+zQXT65oEnrtDhiCpe
	vnyDlphCFgHVBta00sosIwuQealK661xB5IQDC66XDMgBkZrbtx2+oiv+tQ==
X-Gm-Gg: AYBFou24i3czkL802qruHJQALj0zCyBHvTasN6QLcL8oeZ/thtIKYEiWjGZZBU1qqXO
	f1S9+CwEFbtfbnaiANUigQLPYoe4R2sGeUrY9UEQtlcrqd+SgYr/iVCY0cWzfz6LEk/2MHnyNYw
	ZqOVGaMn5i5JPFSboT8gxBA8hYxXeCoPdEv3fEein96tkxeTPun7Xs2sKXhI5Ly7X3Baq9W3GE4
	55gW9wiXexambrfPlKwyR4sI3FdGQM+MC2UI2BPX+L2J+1T6tWAsAyT9wiH2qT60/eOP01QJ7iz
	8Rrt8vb8aL5mIgJliswJQ/41QuHS3uBKDPQ2sLdXQmDOCUeUXxbuGfexI1FStodhh1S7KqlDKJ1
	FEzJFJ34+e/p5wrIXxbY2Ws2wd2CUmZVK9OmTlhQTHg4VlTfuo0BVSpxWXKX+I3xYP5KX3L2A1N
	bRjZJERIHWjmE67clEr3VqKA==
X-Received: by 2002:a17:90b:35cf:b0:398:9beb:a2bc with SMTP id 98e67ed59e1d1-39b0881d765mr33799967a91.30.1788813204290;
        Mon, 07 Sep 2026 13:33:24 -0700 (PDT)
X-Received: by 2002:a17:90b:35cf:b0:398:9beb:a2bc with SMTP id 98e67ed59e1d1-39b0881d765mr33799937a91.30.1788813203786;
        Mon, 07 Sep 2026 13:33:23 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm47841297eec.16.2026.09.07.13.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:33:22 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:59:12 +0530
Subject: [PATCH wireless-next 03/18] wifi: nl80211: Add kernel interfaces
 for Seamless Mobility Domain setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-smd-v1-3-65ad4ab30fbd@oss.qualcomm.com>
References: <20260908-smd-v1-0-65ad4ab30fbd@oss.qualcomm.com>
In-Reply-To: <20260908-smd-v1-0-65ad4ab30fbd@oss.qualcomm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: iG46C4WMnKwaHcny49RdnPKrvNoFaVIT
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9f1f95 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=WqWJlBuMtEtNw8dGTc8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: iG46C4WMnKwaHcny49RdnPKrvNoFaVIT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX4Vvln6oYj/yj
 SwbZJc4uP/jyp4YETbWtC4DZHBdm+dedMppB6IPNuDoTCVjTRSwck5e5qHnOdiiPVj3jwQwBk+k
 GrVHj/UzSH2m7DC32oPhqGSsSt8CHqU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX3cmzYgGeWTEs
 RiVEW8jgSNlRAaKfBNMbLaK2JFM1ALm5tQoUKKhmE5QHTPHr0+CibiUFx3Ec3NhgC0rCwM2SbrU
 GvMFda1Z2uPt4NVDjpmNs03NK9ZcFEo3IV32sVip6zNgjhDZuUrOlxraAYqowK8KGUc2mYflt8q
 ZNNETiGYBZ8OAL8bsvMXUXf1t8X5b9iJSDqWoNI3gxuxkpXS8sHQsA2d5qbPWaGh/lhjWG/Wl/I
 NWtzme3zOBradv2s2LQTbhMGfgz+sBvvy9e0EGyQ5DfX3PQxLOLyi0Npt1z6Fe3HJum0qObeXF7
 9h+iI0RXWtX6Sz7DUBZWOlQ0lwm2zb63CMPy5UkkoPM5Er7wEQGKG64mdsmgZIkktIDbFbFf7Vi
 Dhez4MvffHDoGtxeji0N/QR93kR0uLI51lmYCK5ikBSyuasND3bub31uAGYPsCvDT2/1QobOipp
 JdSmt51HD5lTKXzqkRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070226

From: Aditya Sathish <asathish@qti.qualcomm.com>

An AP MLD managed by an SMD-ME must advertise its SMD parameters in
Beacon and Probe Response frames so that an SMD-capable non-AP MLD can
negotiate SMD during association and may choose to later perform SMD BSS
Transition. Add nl80211 kernel interfaces for userspace to configure
these parameters in nl80211_start_ap() so that the driver and lower
layers can be configured with appropriate parameters.

Signed-off-by: Aditya Sathish <asathish@qti.qualcomm.com>
Co-developed-by: Rohan Dutta <drohan@qti.qualcomm.com>
Signed-off-by: Rohan Dutta <drohan@qti.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/linux/ieee80211-uhr.h |  4 ++
 include/uapi/linux/nl80211.h  | 95 +++++++++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c        | 17 ++++++++
 3 files changed, 116 insertions(+)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index 19e9260d0db8..c3f87d4c8bec 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -589,6 +589,10 @@ ieee80211_uhr_dbe_cap(const struct ieee80211_uhr_cap *cap)
 #define IEEE80211_SMD_INFO_CAPA_TYPE			0x10
 #define IEEE80211_SMD_INFO_CAPA_PTK_PER_AP_MLD		0x20
 
+/* IEEE P802.11bn/D2.0, Aug 2026, subclause 9.4.2.363 */
+#define IEEE80211_SMD_INFO_PREP_TIMEOUT_MIN		2 /* in 64 TUs */
+#define IEEE80211_SMD_INFO_NUM_PREP_AP_MAX		7
+
 struct ieee80211_smd_info {
 	u8 id[ETH_ALEN];
 	u8 capa;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d9ce185b0ef1..f5c8dbe5f26a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3185,6 +3185,12 @@ enum nl80211_commands {
  *	The aggregated message always precedes the per-link messages for the
  *	same station within a dump sequence.
  *
+ * @NL80211_ATTR_SMD_PARAMS: Nested attribute to indicate support for Seamless
+ *	Mobility Domain (SMD); it contains parameters to define capabilities of
+ *	an AP managed by an SMD-ME. Valid if the driver supports
+ *	%NL80211_EXT_FEATURE_SMD.
+ *	Used with %NL80211_CMD_START_AP. See &enum nl80211_smd_params_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3785,6 +3791,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_STA_DUMP_LINK_STATS,
 
+	NL80211_ATTR_SMD_PARAMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -9118,4 +9126,91 @@ enum nl80211_nan_peer_map_attrs {
 
 #define NL80211_NAN_SCHED_NOT_AVAIL_SLOT 0xff
 
+/**
+ * enum nl80211_smd_type - Type of the SMD
+ *
+ * @NL80211_SMD_TYPE_PER_AP_MLD_MAC_SAP: Separate MAC SAP is used per AP MLD.
+ * @NL80211_SMD_TYPE_PER_SMD_MAC_SAP: one MAC SAP is used in the SMD.
+ * @NUM_NL80211_SMD_TYPES: internal.
+ * @NL80211_SMD_TYPE_MAX: Max type of the SMD.
+ *
+ * This value represents the data path models between the non-AP MLD and DS.
+ * DS mapping for the non-AP MLD is updated if
+ * %NL80211_SMD_TYPE_PER_AP_MLD_MAC_SAP is used.
+ *
+ * All AP MLDs within an SMD shall indicate the same SMD type (refer
+ * IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16.1.2).
+ */
+enum nl80211_smd_type {
+	NL80211_SMD_TYPE_PER_AP_MLD_MAC_SAP,
+	NL80211_SMD_TYPE_PER_SMD_MAC_SAP,
+
+	NUM_NL80211_SMD_TYPES,
+	NL80211_SMD_TYPE_MAX = NUM_NL80211_SMD_TYPES - 1,
+};
+
+/**
+ * enum nl80211_smd_ptk_mode - PTK Mode used in the SMD
+ *
+ * @NL80211_SMD_PTK_MODE_PER_SMD_PTK: one PTK is used by all AP MLDs in the SMD.
+ * @NL80211_SMD_PTK_MODE_PER_AP_MLD_PTK: Separate PTK is used per AP MLD.
+ * @NUM_NL80211_SMD_PTK_MODES: internal.
+ * @NL80211_SMD_PTK_MODE_MAX: Max type of PTK mode.
+ *
+ * This value represents the security mode of the SMD that dictates the PTK used
+ * in current and target AP MLDs to protect communications with the non-AP MLD
+ * (refer IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16.1.3.2)
+ */
+enum nl80211_smd_ptk_mode {
+	NL80211_SMD_PTK_MODE_PER_SMD_PTK,
+	NL80211_SMD_PTK_MODE_PER_AP_MLD_PTK,
+
+	NUM_NL80211_SMD_PTK_MODES,
+	NL80211_SMD_PTK_MODE_MAX = NUM_NL80211_SMD_PTK_MODES - 1,
+};
+
+/**
+ * enum nl80211_smd_params_attrs - SMD Domain parameters
+ *
+ * @NL80211_SMD_PARAMS_ATTR_UNSPEC: Invalid attribute.
+ * @NL80211_SMD_PARAMS_ATTR_IDENTIFIER: Required (binary) attribute of ETH_ALEN
+ *	bytes used to define the unique identifier for the SMD.
+ * @NL80211_SMD_PARAMS_ATTR_TIMEOUT: Required (u16) attribute to define the SMD
+ *	Preparation timeout (in 64 TUs, values 0 and 1 are reserved) for
+ *	the target AP MLD.
+ * @NL80211_SMD_PARAMS_ATTR_DL_DATA_FORWARDING: Flag attribute to indicate that
+ *	the device supports forwarding of buffered DL data packets.
+ * @NL80211_SMD_PARAMS_ATTR_MAX_PEER_APMLDS: Required (u8) attribute to define
+ *	the maximum number of AP MLDs a non-AP MLD can prepare with. Value is
+ *	the maximum number of AP MLDs - 1. A value of 0 means that the non-AP
+ *	MLD can prepare with 1 AP MLD.
+ * @NL80211_SMD_PARAMS_ATTR_TYPE: Required (u8) attribute to indicate the
+ *	SMD Type (&enum nl80211_smd_type).
+ * @NL80211_SMD_PARAMS_ATTR_PTK_MODE: Required (u8) attribute to indicate the
+ *	PTK mode used for protection (&enum nl80211_smd_ptk_mode).
+ * @NL80211_SMD_PARAMS_ATTR_NEIGHBOR_PROBING: Flag attribute to indicate that
+ *	the device supports UHR Neighboring AP Probing.
+ * @__NL80211_SMD_PARAMS_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_PARAMS_ATTR_MAX: Max attribute.
+ *
+ * Nested attributes carried in %NL80211_ATTR_SMD_PARAMS to define
+ * device capabilities that is part of an SMD (refer IEEE P802.11bn/D2.0,
+ * Aug 2026, subclause 9.4.2.363, Figure 9-aa43 and Figure 9-aa44).
+ *
+ */
+enum nl80211_smd_params_attrs {
+	NL80211_SMD_PARAMS_ATTR_UNSPEC,
+	NL80211_SMD_PARAMS_ATTR_IDENTIFIER,
+	NL80211_SMD_PARAMS_ATTR_TIMEOUT,
+	NL80211_SMD_PARAMS_ATTR_DL_DATA_FORWARDING,
+	NL80211_SMD_PARAMS_ATTR_MAX_PEER_APMLDS,
+	NL80211_SMD_PARAMS_ATTR_TYPE,
+	NL80211_SMD_PARAMS_ATTR_PTK_MODE,
+	NL80211_SMD_PARAMS_ATTR_NEIGHBOR_PROBING,
+
+	/* keep last */
+	__NL80211_SMD_PARAMS_ATTR_LAST,
+	NL80211_SMD_PARAMS_ATTR_MAX = __NL80211_SMD_PARAMS_ATTR_LAST - 1
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e585da1d79c9..22d71f32815f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -689,6 +689,21 @@ nl80211_nan_conf_policy[NL80211_NAN_CONF_ATTR_MAX + 1] = {
 	[NL80211_NAN_CONF_NOTIFY_DW] = { .type = NLA_FLAG },
 };
 
+static const struct nla_policy
+nl80211_smd_params_policy[NL80211_SMD_PARAMS_ATTR_MAX + 1] = {
+	[NL80211_SMD_PARAMS_ATTR_IDENTIFIER] = NLA_POLICY_ETH_ADDR,
+	[NL80211_SMD_PARAMS_ATTR_TIMEOUT] =
+		NLA_POLICY_MIN(NLA_U16, IEEE80211_SMD_INFO_PREP_TIMEOUT_MIN),
+	[NL80211_SMD_PARAMS_ATTR_DL_DATA_FORWARDING] = { .type = NLA_FLAG },
+	[NL80211_SMD_PARAMS_ATTR_MAX_PEER_APMLDS] =
+		NLA_POLICY_MAX(NLA_U8, IEEE80211_SMD_INFO_NUM_PREP_AP_MAX),
+	[NL80211_SMD_PARAMS_ATTR_TYPE] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_SMD_TYPE_MAX),
+	[NL80211_SMD_PARAMS_ATTR_PTK_MODE] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_SMD_PTK_MODE_MAX),
+	[NL80211_SMD_PARAMS_ATTR_NEIGHBOR_PROBING] = { .type = NLA_FLAG },
+};
+
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
@@ -1097,6 +1112,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NPCA_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 	[NL80211_ATTR_STA_DUMP_LINK_STATS] = { .type = NLA_FLAG },
+	[NL80211_ATTR_SMD_PARAMS] =
+		NLA_POLICY_NESTED(nl80211_smd_params_policy),
 };
 
 /* policy for the key attributes */

-- 
2.34.1

