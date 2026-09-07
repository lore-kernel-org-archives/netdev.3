Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843675293E3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813235; cv=none; b=n+3NY0V8arvixIJXTPO2mfRWI/81s5U+eustZ7O50MRnrEocAwY2AsP8v8xQGyUljEn+XOlzRc1rQcJY323TQ/zRlBeAzdJGm3cuG5Ad/mVDfZ5vwtVGU/Za86LK++jCkb67I03UxPnCfoBkzL/mt/zq91kD7lFmleVWOrZAYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813235; c=relaxed/simple;
	bh=3BIpCqgDAnBGrfpL4IV/b7aNMrM2UPJt17dMZbUsoWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJKuxDlnLC82L07dfkQXyIVzzoSUV1407ER3goB2/Y+aqZf6ZNXvcjwP4V8t8hUzsgkroo1e3b0gUW4GbPYinYPz08rSi8rBctIw+SnOtc7AGDShsowm7nxvXip9HTHwSmtig5MkgQ1SGZc0AmDDqmSfacPWKdpmPyP0XcEbGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LlrtBn7c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KM7AuC88; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LlrtBn7c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KM7AuC88"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687HWLst564976
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pCsImhyIeDGFUN5AVZ441p15WIFo4hf5osqfn8vGVMw=; b=LlrtBn7crFH9fRya
	+Tz8nCXmaT3mT3zrlwdfQea6bUmqNeO6gAhMt8StV0VlDY8FFQAPrZcIypg3XXFN
	uAXxln9FXmFPvMd9cHrIYPRtUa+ibLoagUN29PJt84BSWt6Nx1hXarkULNucziDv
	+zyruQb6FfRxxYh6UtM6g9s+BReQnt1OhUnx3CehvjCNr5U360068VUanAzY/U+J
	pDtBVvWc37dt4Ytd/o5Evz6Q1NQZ55jMTdkXswacSvS8WRi9F9kbKUeNyL7PjKgL
	RfIJf/V6Sh2ujv6xVjnvcPDLeD22RfDRKF6TyWo0ctSX9QAzvo8Ae4YwI+NuVwN8
	xPBkYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rrgfve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:33:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc44d708055so6746125a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788813232; x=1789418032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pCsImhyIeDGFUN5AVZ441p15WIFo4hf5osqfn8vGVMw=;
        b=KM7AuC88U0JzmfFkcOrqZR4xZUJx9qzxEGOdd5to6wJ49PlGuoi3xoLdvwz1VXaL1A
         aCES257UgbEa5QR8jaxnd8bYh6IIyCM8nTQ2EnuY7aN6YNqOZ8qd1kmkYFbe5acWQYyW
         HdT2oKmTw81hh0d5o5Ng2TUKgfErQCi8GB1pHdN5zAvR60PaGyZVvXIpAsu9bHNM6daA
         Hzj6YftX5BPmaemBaJeS7pHxFs9bqSUrpVJArgRXKxJ9NSVoIK9GEMdDCYuwiEsNBuHg
         HtJ21R+mWWtOL4+gR967P94GvPZQhRlow3qg1ViWDbMuabQ1X+v8PjfBCRVAfX09ODQz
         pZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813232; x=1789418032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pCsImhyIeDGFUN5AVZ441p15WIFo4hf5osqfn8vGVMw=;
        b=HS3hRLEAaUNF3x27dqJ7qMPLb95hnQVhda9UbN1oUyuPeUHGncYafgklQC2ClLloKd
         TBQXrub835T7V7k3mQ7GeYaG0sQoyW1I8esVJVSOKb+WNWcrXnTOZCc0zS+RJUg1SP2q
         ZAkIxJ7Ykzel3XQ8ldwuo3yFzT1COF2fQIqHh9dqU+vHp3vsEkiZ6vt+La35S2pePxOu
         ISlGGq0puqEv/4gdA9BdguXchJHaf1FfXYfqtAqzwuOEpSKG7Pm1TNKhWZw6WykwxPqG
         OwY5I4Rqa9JmxHd1JhdfS8yxaHbA9KB0Z7A8SrPNQ5CSi45EGtxeQdLU5JVzTHcaIm9x
         TbhA==
X-Forwarded-Encrypted: i=1; AKwUvBysKiBksw7y76EB9zZ7gR9zaac7tAnePfvkaUzi04guoXIJw27aXQUqpeuW/M1v9dJvM7K8Sz8=@vger.kernel.org
X-Gm-Message-State: AFuF++kd98J0V0SSQjHMMdHVtY3QmcD/8IC71v2EKM1vzpsRifSCUvfM
	BmXY2IUzr79lZYs+GHoNgdh+a6NItfS3pb5xo0AonGsF6pU8YYi0tQdD4ZS7DW8RaCGGpKElc2H
	9Ch9QjqFHH/ZB2nH9YGHWds8spThMpOl+ejSDH5ajzHP24rzBbYw3LRRAtA==
X-Gm-Gg: AYBFou1hsYLRncntHQVNqDH7Vr3FTkZPWJ6fJkxBz1NKy41wgWDVaS5FUfxZG+sO2Ef
	pBNCCD/KouSVEYn2ypz+woc7TBWDWpmCDQ3B1Pkb2wtIqOXLbos6xxE0ndTpOLfGvbT+oOVA0k5
	BPVEgPH4AnX8gYLnhrqCz/FKMHB61VQgscsuQUuMDk3tI+kwbzkoE2F4O08NjjjlojzVcAKy5Sk
	PtS4g5UYXVP/iZOBwXxeX0TGqpzA1pvNXY+zvPgBqQMgbvzXzh7eIfOaj9mSC9yWDG7KfYtwRhZ
	hfr9ZWcWMl7L6/xpqkYijdufc9CPeuxI0zOC+uSFKzTKXV0Za/Y08VQvRVOGZnrAv5HwXe7aXq5
	SUR45A3RLqhJjMsZgKoygnSuuMkBBtYTkkITv9OPVZjgm8uTdbYqfLI3zeYp4bVjPN40a/wkKkV
	kicTlfhwsZZQZ6g9eisRCY+w==
X-Received: by 2002:a05:6a20:43a3:b0:3d3:afeb:880 with SMTP id adf61e73a8af0-3da3a223f79mr38439436637.28.1788813231895;
        Mon, 07 Sep 2026 13:33:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a3:b0:3d3:afeb:880 with SMTP id adf61e73a8af0-3da3a223f79mr38439400637.28.1788813231454;
        Mon, 07 Sep 2026 13:33:51 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm47841297eec.16.2026.09.07.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:33:51 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:59:19 +0530
Subject: [PATCH wireless-next 10/18] wifi: mac80211: Define SMD BSS
 Transition context for transport
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-smd-v1-10-65ad4ab30fbd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfXyNfQI3jqHSMf
 fV747DnZgIXmmam2vew/V0xqc5uk1Z0FM5/DlaTLEJbX2O/KU6qciLeVM+B2ZKRVknY/CebUkEj
 pVzwUglp2sTm+GkRNkAkXAnzOBHFDB8=
X-Proofpoint-GUID: 1-epdj4qIjC-eVKSvoRG1o4u__pa65vW
X-Authority-Analysis: v=2.4 cv=NsjhtcdJ c=1 sm=1 tr=0 ts=6a9f1fb0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=J9-iD1ZZfo0dXw_rko0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfXx8QCgiryNZ8u
 5KYLT0H0ZUvWMQmIRvv0ivCudf7sYha2d/kh7MbRlPOti34DeVSakxCNKSH/qc8FWoIS12A2xwC
 wk2oZF9cvn+1gGUE9Te6mcmRALJScNtqJSlNQ6m0/X9FK9HpVBA6JPFZ2mReGKpuOF/GV5Y8yJk
 k/c+7tXqvcaGeSf4g7bf0mABr0BWrqGZ0aeFufJXrJtEjakcLJ9Y2MTQRzQ2dnpxon4J3QrXS4x
 Ej3g+kXtuoGdzoY6NpkJqzF3KB/RuhzQyi98p7iJ1XEgcUvVM+RRtudCzkp3TcK3KoGZMIUxF/F
 YJjLr+NloRx8iBpaNMT53pOdctRWvNrtmo0txqBOkeFUY1Wo3QFrs7eJ2QzYpmDkvNqZNtUER4g
 rN0Xp6pabKa8PlClCH0ZTafqAf5BUwD8c7zOl5xEBAoupqMDNksa2GvPnrdjWhTHgkMJfLml01E
 bsRRVlfn5craqNgtbWg==
X-Proofpoint-ORIG-GUID: 1-epdj4qIjC-eVKSvoRG1o4u__pa65vW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070226

IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16.9, defines the context
data to be transported during SMD BSS Transition (ST) laid out in
subclause 37.16. The station's context data is attached to the ST
Preparation or Execution management frame using SKB extensions so that
userspace receives the context along with the relevant frame.

Define the context data - per-TID sequence numbers in downlink (DL) and
uplink (UL) directions, packet number in DL, per-TID packet numbers in
UL, and per-TID BlockAck session parameters in DL and UL, plus a
variable-length driver context - to be used by the driver to attach the
context to the frame SKB. Additionally, define a helper that attaches
the SMD context to the SKB extension so that the initialization
operations (container allocation, reference tracking, and context
linking) are properly handled.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/linux/ieee80211-uhr.h | 86 +++++++++++++++++++++++++++++++++++++++++++
 include/net/mac80211.h        | 50 +++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index c3f87d4c8bec..f904b1e65f10 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -649,6 +649,92 @@ struct ieee80211_uhr_mode_change_tuple {
 	u8 variable[];
 } __packed;
 
+/*
+ * Context information carried in SMD BSS Transition (refer IEEE P802.11bn/D2.0,
+ * Aug 2026, subclause 37.16.9.
+ */
+#define IEEE80211_SMD_CTX_NUM_VALID_CTX    8
+
+#define IEEE80211_SMD_CTX_VALID_DL_SN      0
+#define IEEE80211_SMD_CTX_VALID_UL_SN      1
+#define IEEE80211_SMD_CTX_VALID_PN         2
+#define IEEE80211_SMD_CTX_VALID_BA_PARAMS  3
+/* Positions 4 to 7 are reserved */
+
+/*
+ * Data TIDs transported in the context, IEEE P802.11bn/D2.0, Aug 2026,
+ * subclause 9.4.2.364.
+ */
+#define IEEE80211_SMD_CTX_NUM_TIDS 8
+
+#define IEEE80211_SMD_CTX_MAX_PN_LEN 16
+
+/**
+ * struct ieee80211_smd_ctx_ba - BlockAck parameters for DL and UL
+ *
+ * @amsdu_supported: Peer's capability to support A-MSDU within A-MPDU.
+ * @ba_policy: BlockAck policy (0 = delayed BlockAck, 1 = immediate BlockAck)
+ * @buffer_size: Reorder buffer size from ADDBA Request (10-bit, max 1023)
+ * @timeout: BlockAck session timeout
+ * @ext_no_frag: ADDBA Extension fragmentation support
+ * @extfrag_level: ADDBA Extension HE fragmentation level
+ * @ext_buffer_size: ADDBA Extension buffer size; combined with @buffer_size as
+ *	(@ext_buffer_size << 10 | @buffer_size) to get the full reorder
+ *	buffer size
+ */
+struct ieee80211_smd_ctx_ba {
+	bool amsdu_supported;
+	u8 ba_policy;
+	u16 buffer_size;
+	u16 timeout;
+	bool ext_no_frag;
+	u8 extfrag_level;
+	u16 ext_buffer_size;
+};
+
+/**
+ * struct ieee80211_smd_ctx - IEEE 802.11bn SMD Roaming Context (refer
+ *	IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16.9)
+ *
+ * @valid_ctx_bmap: Bitmap indicating which context fields are valid;
+ *	bit positions defined by IEEE80211_SMD_CTX_VALID_* constants
+ * @pn_len: Length of PN in bytes; varies by cipher type
+ *	(e.g. CCMP (6), GCMP-256 (16))
+ * @dl: Down-link context data
+ * @dl.valid_tid_bmap: valid DL TIDs for which context is present
+ * @dl.sn: DL SN per-TID to be assigned next
+ * @dl.pn: DL PN to be assigned next
+ * @dl.ba: DL BlockAck parameters per-TID for the BlockAck session
+ * @ul: Up-link context data
+ * @ul.valid_tid_bmap: valid UL TIDs for which context is present
+ * @ul.sn: UL SN per-TID to be checked next
+ * @ul.pn: UL PN per-TID to be checked next
+ * @ul.ba: UL BlockAck parameters per-TID for the BlockAck session
+ * @drv_ctx_size: Number of valid bytes in @drv_ctx.
+ * @drv_ctx: Variable-sized array of driver-specific context, counted by
+ *	@drv_ctx_size. Opaque to the wireless core; interpreted by the drivers.
+ */
+struct ieee80211_smd_ctx {
+	DECLARE_BITMAP(valid_ctx_bmap, IEEE80211_SMD_CTX_NUM_VALID_CTX);
+	u8 pn_len;
+
+	struct {
+		DECLARE_BITMAP(valid_tid_bmap, IEEE80211_SMD_CTX_NUM_TIDS);
+		u16 sn[IEEE80211_SMD_CTX_NUM_TIDS];
+		u8 pn[IEEE80211_SMD_CTX_MAX_PN_LEN];
+		struct ieee80211_smd_ctx_ba ba[IEEE80211_SMD_CTX_NUM_TIDS];
+	} dl;
+	struct {
+		DECLARE_BITMAP(valid_tid_bmap, IEEE80211_SMD_CTX_NUM_TIDS);
+		u16 sn[IEEE80211_SMD_CTX_NUM_TIDS];
+		u8 pn[IEEE80211_SMD_CTX_NUM_TIDS][IEEE80211_SMD_CTX_MAX_PN_LEN];
+		struct ieee80211_smd_ctx_ba ba[IEEE80211_SMD_CTX_NUM_TIDS];
+	} ul;
+
+	size_t drv_ctx_size;
+	u8 drv_ctx[] ____cacheline_aligned __counted_by(drv_ctx_size);
+};
+
 static inline int
 ieee80211_uhr_mode_change_tuple_size(const struct ieee80211_uhr_mode_change_tuple *tuple)
 {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 32b9b7cd1685..b4b1d3db9b19 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/if_ether.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_wireless.h>
 #include <linux/ieee80211.h>
 #include <linux/lockdep.h>
 #include <net/cfg80211.h>
@@ -8246,4 +8247,53 @@ bool ieee80211_vif_nan_started(struct ieee80211_vif *vif);
  * Return: 0 if success and non-zero on error
  */
 int ieee80211_encrypt_tx_skb(struct sk_buff *skb);
+
+/**
+ * ieee80211_skb_ext_add_uhr - attach or replace a UHR SMD context on
+ *	SKB_EXT_WIRELESS
+ * @skb: the SKB to attach the extension to
+ * @ctx: the SMD context; must be a kmalloc-ed buffer by the caller
+ *
+ * Allocates a &struct wireless_skb_ext_smd_ctx container, sets @ctx to it with
+ * @refcnt initialized to 1, and attaches it to @skb on SKB_EXT_WIRELESS.
+ * If SKB_EXT_WIRELESS is already active, the existing @container is released
+ * before the new one is attached.
+ *
+ * Ownership of @ctx transfers to @container on success - the core will
+ * kfree() both when the last reference is released.
+ * Upon error, @ctx ownership is not transferred from the caller; old @container
+ * may get freed.
+ *
+ * Drivers must use this helper to attach SKB_EXT_WIRELESS extension to
+ * properly handle clone and COW copies.
+ *
+ * Returns 0 on success; -ENOMEM on allocation failure.
+ */
+static inline int ieee80211_skb_ext_add_uhr(struct sk_buff *skb,
+					    struct ieee80211_smd_ctx *ctx)
+{
+	struct wireless_skb_ext_smd_ctx *container;
+	struct wireless_skb_ext *ext;
+
+	container = kzalloc_obj(*container, GFP_ATOMIC);
+	if (!container)
+		return -ENOMEM;
+
+	refcount_set(&container->refcnt, 1);
+	container->smd_ctx = ctx;
+
+	skb_ext_del(skb, SKB_EXT_WIRELESS);
+
+	ext = skb_ext_add(skb, SKB_EXT_WIRELESS);
+	if (!ext) {
+		kfree(container);
+		return -ENOMEM;
+	}
+
+	ext->uhr_smd_ctx = container;
+	ext->type = WIRELESS_SKB_EXT_UHR_SMD;
+
+	return 0;
+}
+
 #endif /* MAC80211_H */

-- 
2.34.1

