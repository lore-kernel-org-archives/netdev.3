Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72799598BFC
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887444; cv=none; b=PwtXtNlwKtgoB8oAZWMIaLsMSCytJXCpE1QVRx13HhTjQthh0JuwNmnXVLMG6e3YXQuz7cXikSLg16s9G7rUFg82gTI7V4/u1HZq04aU0JCds20o0bupCoIpWiOR8Xa2FNydmYZ1CSKpbyl4G2qNBuZTcllxFHp7O+YsbiFrKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887444; c=relaxed/simple;
	bh=86w9hu+WJ1z3hy9Or+mlRGtKjgaxVht0KJsSe0k3fEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLpZ4gkl3eBq3FEN9Ji/OCLReatgRBgmYk5RcscW4ImASwaib3CBuU+e6kewoMNewcunqlj81g82jnl3d/8J0TlekVM/msA7sV9QhQnOF5tOVV9gv/RQkFb3EaxY72WCt+0E1onR2VHPPWHwi4MeiNQG6Mzml/TaSYFqNyCQvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDmBDhD3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ijg5W9PL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDmBDhD3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ijg5W9PL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdfP7045945
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gofo4g5PMnVYPHJH99bL1SwGrtDr+P/qsI5BTGGqohw=; b=lDmBDhD3x1HVS0Ea
	WZzEzbmWoiNAAEd5vM2fLL603eQUaD4k1DVPUtcjwUgRn9afPjQZl1tZ4D90TXJm
	Q4JdEGhBaYqLy62kcdkUvlFNkuZP0Snhp6Fa3a8h54Qz26mpEKP/NLms28/XiOgk
	yEcHVcvu/veKn4/2KPYmNQgvMWc0iSvh/OfbhHlQwcoo8esRqah5F9QeekzlCqdi
	UmhK4aoGhf9vyzWg7JcPbPJXq8x/bfJV/q5UXtSgvypGxEH4j1lombyZIbTsyS3O
	f3n3ZmLvfp9UqnaPz+N4PlEmGt6c2V4Th6pXutIWwxL4CBGmfL79tWygPqvIAaH5
	W50shQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjg8xsy7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:41 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so6044518a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887441; x=1789492241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gofo4g5PMnVYPHJH99bL1SwGrtDr+P/qsI5BTGGqohw=;
        b=Ijg5W9PLW1LdS9M4s9DaQhIu+91t5XluqW24cLlsihLVVbT0YBkgTounCu1b7VROlF
         r5vxtwz7KLDbCOt7BTN1zY0XnV6UZgnQywKkgVOURw6Kiflr2uRPNgAMLYZ+vA1lj66c
         ZPMvODOL+txQ/XXvvvxIyKmRruuCua59o3w5a9JLYFHTWqBg50xW0nW6f4wC/Q3gpHmp
         OpUvVqAPOR5SvzxWN/5Z3Gswh2CNfhWtxsk0pQkb6bDaJUvX3SwBXWldlvWrs+6sHDGu
         4zuTKazY0J5vZi9YbuWbZBZfOPYGcaUaAyvSGv6WV30kje2jbyBHQu136QpdUEwSaeOR
         RRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887441; x=1789492241;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gofo4g5PMnVYPHJH99bL1SwGrtDr+P/qsI5BTGGqohw=;
        b=jqoWJjo2lcB08ySJ0WIku9Fov5fOrhGJjRAs1HiA+7KJs4DreLTTgCcHKkOazPsW2V
         va9iZRI2KHOuulHa5Uc/bJ9lI1/V7uG/jIVW1H+M7QGVxr5NvxkyayKNhxv29BCxU2N4
         lSuI2o5ZrMlRi/rhalxh0Ri8/SQhA1NA8W2R6Fp1apgwy9GlpyI1RWB0Utr9WCZWz5Ef
         3KHnHuZFtyec0FHEpTzpdiSddOS1RqIMpVB2OhLEH4Gm+zLcntl5JKm9mxHKB7T9NSqw
         pVwj3eS94rC7SS8Ax136JvosIIs9bA6O/aZ9gj5Tc5B1zvuO6wLsR4w6sUd5TUFprHpt
         jKgA==
X-Forwarded-Encrypted: i=1; AKwUvBy1vXeVurDCMqEHMln45/dSfS9tJACezGKenPWP1CUBBQDj4I8lFKEh6Kuf5nuC8JrjRSRQFEI=@vger.kernel.org
X-Gm-Message-State: AFuF++nzDLsFYvkDLIq3aLIpAuX7JNMJBKHxTaXyGKXKZ6b62bS63gIc
	949J4w/8lrYHnePVlgX1StESdJEmiciJj/0LfaOkgRjQdpQhHkHurQviJ6xJLPV7WGv0RXTUv/a
	ecbqkrqCEr6wXHMIgabIpjCF4BF+H7oICYuG8QhjUMItFJTJ0ppPapeujPNLVSp9erw==
X-Gm-Gg: AYBFou2y1Axz+no904/SiCf8ZiZdJRFnkrTklZqOE6GBGxlVo1Ylt+w83JFZ60OzbkR
	CWLoke7VaJQXAbqIFjHzfXMQbAXWSHN54DLt4zGfjhGy42irHtjc05qM7S7iMpWh8g7yeczLOea
	vIUx6G2Lm2SywJsS1A7F35wKWJYTCbfCdPz0/Mfe+J/W4GUc6Lt5puBHUPUIA1/vgXPhFrtfUv1
	NnvZQao4NKOMaOFq7Z8ZunOcF4vBGcYENtcVE8sJ1x903usnycDXaB5ahV9MarA0D6lsUOYOt91
	QAm3PRIsgpbSyUZIg/mysr/SSKhQQPVCgwEWdtqmaHPZTZ5GXiJKXR2pzSDKoDmpqIq4cxush6j
	/OWKyApeGP4Zt29en53heptwey0g+VRupupYY9XpHuRUqAufo/bEQ+xC0RIY4pObNku1jpVtmzI
	DxPCf/6qax+zIolLBMegBYUA==
X-Received: by 2002:a05:6a21:2983:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3da3a03ccf1mr51872767637.17.1788887441226;
        Tue, 08 Sep 2026 10:10:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:2983:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3da3a03ccf1mr51872684637.17.1788887440767;
        Tue, 08 Sep 2026 10:10:40 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:38 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 09/18] wifi: mac80211: Send BlockAck policy in AMPDU action
Date: Tue,  8 Sep 2026 22:39:37 +0530
Message-Id: <20260908-smd-v1-9-9fd2d876a1fb@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=J7GaKgnS c=1 sm=1 tr=0 ts=6aa04191 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=poGJry9enlaRV4ryzAsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: pjOC8uFt-2RCo1DTveuXj-_KUnN_oKPV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXzc8UNVeXUgST
 3O5vMCi4ZqrmXJSBzPtaz3UDCI0O7UFRma+WoteE80/fSZgU4OMA1Cst+ThxE9Hi3mC9LgVfJGZ
 dffOEvrzLYgXlr99t6n0a+fSoLH7tgFNjSLfR6vfDJUQAJZhGYbYTsWvUQjzpKkN6ZBSuBDfJms
 UqrOITOnrY4jJItMsf42nIU2z+7sB00Hmm9cmJynHxAEi2v37m0mwd3hLjTbvI8cfD20t4cu16J
 9+NbJUHNeHDjHZvJecJG35omqaqBplXpBWxLEk3cTi5Y8B8v/6viOFMfa9s8PixdqG2lSG69ady
 zRknfQJb89vNNjN68ukLJ48EUS9hfeaAnJp5dlEIh/Tme1xkzlGTXsaj3Wkx8EqhNKyazOpxY+e
 43CyxqeIIatrp514PTFlFkYYRvEX0T0gVTjFtWv9WQSAlfsiUmznQtoYpM0MU0/kXo+9OO5nrnY
 0tgm5ION52txqfiP5BQ==
X-Proofpoint-GUID: pjOC8uFt-2RCo1DTveuXj-_KUnN_oKPV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfX4Qh2Y+Th9O69
 wviUxkNqR1FPOqL134Og+h7SFM3dLNCD3K3sAO8cJDKcTJr3jvOm4AGtPpIvYYasGDRexfgCy5e
 1Z3fHAK8Ke73f2UZobXxq8HHL2tTHXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080185

While sending AMPDU action hints to wireless drivers, mac80211 does not
currently send the BlockAck policy extracted from ADDBA frames. Send the
BlockAck policy as well so that drivers have complete information about
the negotiation. Policy is valid only for IEEE80211_AMPDU_RX_START.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/mac80211.h | 15 +++++++++++++++
 net/mac80211/agg-rx.c  |  1 +
 net/mac80211/trace.h   |  8 +++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9b5fa6d6281b..32b9b7cd1685 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3964,6 +3964,19 @@ enum ieee80211_ampdu_mlme_action {
 #define IEEE80211_AMPDU_TX_START_IMMEDIATE 1
 #define IEEE80211_AMPDU_TX_START_DELAY_ADDBA 2
 
+/**
+ * enum ieee80211_ba_policy - BlockAck Policy
+ *
+ * @IEEE80211_BLOCKACK_DELAYED: Block ACK sent to the BAR sender in next TXOP
+ * @IEEE80211_BLOCKACK_IMMEDIATE: Block ACK sent to the BAR sender immediately
+ *
+ * This field is valid only for %IEEE80211_AMPDU_RX_START.
+ */
+enum ieee80211_ba_policy {
+	IEEE80211_BLOCKACK_DELAYED,
+	IEEE80211_BLOCKACK_IMMEDIATE,
+};
+
 /**
  * struct ieee80211_ampdu_params - AMPDU action parameters
  *
@@ -3976,6 +3989,7 @@ enum ieee80211_ampdu_mlme_action {
  * @buf_size: reorder buffer size  (number of subframes). Valid only when the
  *	action is set to %IEEE80211_AMPDU_RX_START or
  *	%IEEE80211_AMPDU_TX_OPERATIONAL
+ * @policy: BlockAck policy of type &enum ieee80211_ba_policy
  * @amsdu: indicates the peer's ability to receive A-MSDU within A-MPDU.
  *	valid when the action is set to %IEEE80211_AMPDU_TX_OPERATIONAL
  * @timeout: BA session timeout. Valid only when the action is set to
@@ -3987,6 +4001,7 @@ struct ieee80211_ampdu_params {
 	u16 tid;
 	u16 ssn;
 	u16 buf_size;
+	enum ieee80211_ba_policy policy;
 	bool amsdu;
 	u16 timeout;
 };
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 9629e00069a1..2d67fd883146 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -289,6 +289,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 		.amsdu = false,
 		.timeout = timeout,
 		.ssn = start_seq_num,
+		.policy = ba_policy,
 	};
 	int i, ret = -EOPNOTSUPP;
 	u16 status = WLAN_STATUS_REQUEST_DECLINED;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 294a8a44a125..63838a6d5d07 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -116,6 +116,7 @@
 				__field(u16, ssn)					\
 				__field(u16, buf_size)					\
 				__field(bool, amsdu)					\
+				__field(u8, policy)					\
 				__field(u16, timeout)					\
 				__field(u16, action)
 #define AMPDU_ACTION_ASSIGN	STA_NAMED_ASSIGN(params->sta);				\
@@ -123,12 +124,13 @@
 				__entry->ssn = params->ssn;				\
 				__entry->buf_size = params->buf_size;			\
 				__entry->amsdu = params->amsdu;				\
+				__entry->policy = params->policy;			\
 				__entry->timeout = params->timeout;			\
 				__entry->action = params->action;
-#define AMPDU_ACTION_PR_FMT	STA_PR_FMT " tid %d, ssn %d, buf_size %u, amsdu %d, timeout %d action %d"
+#define AMPDU_ACTION_PR_FMT	STA_PR_FMT " tid %d, ssn %d, buf_size %u, amsdu %d, policy=%u, timeout %d action %d"
 #define AMPDU_ACTION_PR_ARG	STA_PR_ARG, __entry->tid, __entry->ssn,			\
-				__entry->buf_size, __entry->amsdu, __entry->timeout,	\
-				__entry->action
+				__entry->buf_size, __entry->amsdu, __entry->policy,	\
+				__entry->timeout, __entry->action
 
 /*
  * Tracing for driver callbacks.

-- 
2.34.1

