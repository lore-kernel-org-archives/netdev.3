Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F758F06C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887484; cv=none; b=sZD8aVjcBT6ra10By9oPCXE+1f+6jr7ZtxprUaggOU1tVUZB/ORFefS8wh8uKHcU2AUe5lGQ8VwtQDSBi2ODAMmJ7Qyc455xOUF1fDbrazyolcX+e1B9pRmJuGYqES+gWrJnqZwi0YAxkm4qIv1gITkVlDULjz82qrf12fLxrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887484; c=relaxed/simple;
	bh=FQBKNG1LQN+Or7ubGtjxhGSxqu1NLRi2ZcAg1jgnpUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vr875rdbndyA7+3YBEVECYe6kEbFssXlOuA6SjeYFZZF24k3DYHrWiWZSehX4hd9SJOWHK+apzjkkKYarugdPLYqmJmN+oSkHE1grXjtP7UgOFbRn3pQ/ZnDE0r0zVy8ff/63GbCzcyX7ptvML/OhB6webR4eoqRsqU6/uJF314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dL6dzzfA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTnKnzRU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dL6dzzfA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTnKnzRU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdXYQ2769571
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tJrfU3MojC9W8Hc4my3vk6BlrKJp8pREKh3Df4ly1FA=; b=dL6dzzfA1/3UOGHu
	lRKK87nUJ7FTy2n+c0YsbLF1tnsUGy0pbX7aTbb57yuKakuo9OBEGNTDhUuJ2kV4
	DdjFf8eBCTYoiiABkLrifRIlYwcH3OV8PE+bRVsLkpaeSOPsibvz7BRRAbY9BjNP
	ZNIrE3yR2/ZJDzddNPZxTHReJq6/g+FOm0wUdOwR1xFZ0T1/f3jGR3oJmJpKd6Bk
	8+70lXJb8o81s+RXcQY74r7HWnVxbLYpUSdwvc4Z52mBjRzxQhEeWMQ0kQjCQXpD
	TjTJiNsyCCQvs1G979Io3kqwdd4WSl4brDenEFlSn/PBhhw/divyVXu5b1/BUHHJ
	azwwHg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvuh977-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:11:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so7582320a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887480; x=1789492280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJrfU3MojC9W8Hc4my3vk6BlrKJp8pREKh3Df4ly1FA=;
        b=LTnKnzRUCYCmBwr84wZA3PKdWXzVNFLuDDjFzg7QwCRAwtLgRh19XxQCxGmiwt+p43
         cqhEnGQet/h5Sc5HH153Z09WsMAh8RMCSz2vMkPxOO3wqWw2gepeXn2+1QEnVmRb7OCi
         q5mfWljleOEKKB1eeVmneZKv/c+1+GmlYXFQtJNXn3vPgajzunQBanArgXJr85TmRrQ7
         scBHbtvEjo5qt5behS4CQiUQdhZKHOZ75Ap4zgHs0M2wWhxbg5HQTcbOVJplzj7vsfRh
         +Y3+kQJgeQt5n3XXx27ub7G7BuIAHljUih1swYqRRxH8dBorL/FqCFlahr+/Ikj8VXIV
         sR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887480; x=1789492280;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJrfU3MojC9W8Hc4my3vk6BlrKJp8pREKh3Df4ly1FA=;
        b=NaSELiHlBQfvG3VomXknhRpXsmScxYcjxj2K0ygJ2pAe/nPE9JAUUi8sXUTaMvB9y2
         7yzocECjwZzeJwExvTjqroumIGnxBXDB/HtU4YOgabBFUUOx+XDcEpR6lablYqzTLmD5
         2VRC+R1aXwomEQyG8tR/22fF7SE8g+lqdAI8651rZ90LR24ncamKfD1TKBAH6j7186Wu
         7magE0cJEdp55obnfsH9qbiqdLPtOJ9WEOsIxuI4dSAtNWsXqtZw6BG6XYCTbkw+2T/T
         atQ5Kip9jNgpgr3ZZpwdvke+MxDCeqaXSEkzyMZtk6yQfTh2jMoDbewJOq0Wzjbtzmig
         Az+w==
X-Forwarded-Encrypted: i=1; AKwUvBw6d9xJkCftYFRr3u68psx1Y8OwUkVeGgaRLQxR8fTTmrvUY1k1zKyVZW8vcFx1oKxdlXsDCHY=@vger.kernel.org
X-Gm-Message-State: AFuF++mxYmUEX02jprGUStbPMOGo6T/hQyruQgub8L2s9gA80bkJEB25
	WjOBa3UhpzlJ+7A7Ug2AOfox/3lyEpm4Dg2hvq7tzWJaGqyYc6ZWoNWhDH1FL5PU38cDptID3Oz
	bDd1ZIlWZhtqSh+OmILbUXwaDoQk1Hgn+4nqiTjQgS6mzYOJ3RBdqwHyDnw==
X-Gm-Gg: AYBFou0JPWwz/el62yyPZVEfCabpyHgN3r/CGCv4KYTuZRDyPssc/5jr1/SU8wPaDx0
	S/jIqBw57G2H7w7YuIrUwSfBPKpbsNESJ/plHSirzFEnLrFZ9JNashIqhohO8V/7O2GIxlqR3MJ
	RR28MhsOd4a0PWqDVza7txpVuS2ulsu8D3fWG7nVZ5/yq6vZx2Gto/L39Mhz0Def3ZwIRdbsVbv
	OxGyKelMq9nzNQR+RbgiFmZFOy3hyzUe8pknJEyiClHYGljBNfsVP79xOAx2etXG4CLu6YoiNLz
	qS8D9v8ZXN+nQYFWF5IqZ9Um8ai2lhm3J5XSj05PYoEy+p2dM02EmDRw5gxeCU6EbHfwq+I7ul+
	oGErNPH2k4TXpF4cDziGHLIXsjT3TnF5r7cL48ePA/Rm/5Upx2/q7yhEOKTfoH5m82dKHvppoy5
	tho2Z+VFKE/j+aFYbCET+79g==
X-Received: by 2002:a05:6a20:c786:b0:3da:9f19:bf2 with SMTP id adf61e73a8af0-3dabb1e8e8dmr1278157637.18.1788887479600;
        Tue, 08 Sep 2026 10:11:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:c786:b0:3da:9f19:bf2 with SMTP id adf61e73a8af0-3dabb1e8e8dmr1278073637.18.1788887479002;
        Tue, 08 Sep 2026 10:11:19 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:11:18 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 18/18] wifi: mac80211: Add mac80211 support to handle NL80211_CMD_GET_SMD_CTX
Date: Tue,  8 Sep 2026 22:39:46 +0530
Message-Id: <20260908-smd-v1-18-9fd2d876a1fb@oss.qualcomm.com>
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
X-Proofpoint-GUID: 7D9TQtzARq8eIq4z-r_uQVqm831UnM2v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NiBTYWx0ZWRfX8vx4zm87fhxL
 krJhzecijHt5pxxhM8EAgfQemj0L2S4+c5+YuFuoi6GX6qnVW2V0G5EhXeq7hohJRw7rdSTNRkb
 OywRVthB2o4siJk+Zwpn2xo1jbMJgWGxJb4m/aCa+lVEgmH+v497xV7vFUhDC+dCfRAeRld1w3Z
 XwVrAdhFLFthDJQihBbGeeZWpq6bnuBtJ8ItrcGNz0JaUwCrptSRMtnvT0MGc2SnjVtFbVQEoGp
 brheHWfSAdOLlQYcnwgRXZLnoOAc3DEyySODUD5l2+b9n+EafMd+0JX5JKnFhKZJdggeL8vT2tj
 ClHLvyhlzvFALER30mokxc00JBOa77mtojVg0n+TDjAVsTHoiu2DAtUoWNulrUy2u52D7iLKFG4
 xQ+U0Uxjr3LDyiguDt/KtY5hfKk4tgxbQOF1HqoGQoQhRv0Y+qt5VjZF6YwkJpfNZFtOLRrBLKS
 2KUdqjXwQe2UUz5rjXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NiBTYWx0ZWRfXxa9t+AQFTOR+
 1Xh7yLswyWr0BWPBOHx+9UkUGK5jPwBZBdmKOj8vabyqHyTl9Qr1+qY7UZTAxlCRyLSVXeaaE/p
 z4XDmftAhmKFElNPCKDvnUrMrKYtXUw=
X-Proofpoint-ORIG-GUID: 7D9TQtzARq8eIq4z-r_uQVqm831UnM2v
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa041b8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=c93CP5vvwBK-QZUl55wA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080186

cfg80211 supports NL80211_CMD_GET_SMD_CTX from userspace on the current
AP MLD to collect the station's context on the target AP MLD's behalf;
this context is used by the target AP MLD to program its TX and RX
queues to support seamless roaming of the non-AP MLD.

Implement the get_smd_ctx cfg80211_op in mac80211 to invoke the driver
to collect the requested station context. Because context collection is
asynchronous, the driver signals completion later via
ieee80211_get_smd_ctx_done(), which packs the collected context into
NL80211_CMD_SMD_CTX_EVENT and delivers it to userspace as a multicast
event.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/mac80211.h    | 23 +++++++++++++++++++++++
 net/mac80211/cfg.c        | 34 ++++++++++++++++++++++++++++++++++
 net/mac80211/driver-ops.h | 24 ++++++++++++++++++++++++
 net/mac80211/sta_info.c   |  6 ++++++
 net/mac80211/trace.h      | 27 +++++++++++++++++++++++++++
 5 files changed, 114 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e0e13f0ed31f..f16112e41594 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2528,6 +2528,21 @@ enum ieee80211_sta_state {
 	IEEE80211_STA_AUTHORIZED,
 };
 
+/**
+ * ieee80211_get_smd_ctx_done - Deliver async get_smd_ctx result to nl80211
+ * @vif: virtual interface
+ * @sta_addr: non-AP MLD address the context was collected for
+ * @st_info: SMD BSS Transition Info (@st_info or @st_info->ctx may be NULL to
+ *	indicate failure). @st_info is owned by the driver.
+ *
+ * Called by the driver after the %NL80211_CMD_GET_SMD_CTX context collection
+ * is complete. mac80211 forwards the result to cfg80211 which finds the pending
+ * nl80211 request and sends reply to userspace.
+ */
+void ieee80211_get_smd_ctx_done(struct ieee80211_vif *vif,
+				const u8 *sta_addr,
+				struct cfg80211_smd_transition_info *st_info);
+
 /**
  * enum ieee80211_sta_rx_bandwidth - station RX bandwidth
  * @IEEE80211_STA_RX_BW_20: station can only receive 20 MHz
@@ -4782,6 +4797,11 @@ enum ieee80211_sta_smd_state {
  *	The callback can sleep.
  * @set_smd_ctx: Set the UHR SMD context for the non-AP MLD. This is used on
  *	the target AP MLD side to program dynamic context.
+ * @get_smd_ctx: Get the UHR SMD context for the non-AP MLD. This is used in
+ *	the current AP MLD side on behalf of the target AP MLD to collect
+ *	dynamic context, when the non-AP MLD sends ST Execute frame directly
+ *	to the target. Since the response is asynchronous, the drivers that
+ *	implement this should not store reference to @sta.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -5191,6 +5211,9 @@ struct ieee80211_ops {
 	int (*set_smd_ctx)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta,
 			   struct cfg80211_smd_transition_info *st_info);
+	int (*get_smd_ctx)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta,
+			   enum nl80211_smd_ctx_type type);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 268d5f42293a..a33ce96a4752 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -6104,6 +6104,39 @@ static int ieee80211_set_smd_ctx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	return drv_set_smd_ctx(local, sdata, &sta->sta, st_info);
 }
 
+static int ieee80211_get_smd_ctx(struct wiphy *wiphy, struct wireless_dev *wdev,
+				 const u8 *addr,
+				 enum nl80211_smd_ctx_type type)
+{
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+	struct ieee80211_sub_if_data *sdata;
+	struct sta_info *sta;
+
+	lockdep_assert_wiphy(wiphy);
+
+	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP &&
+	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
+		return -EOPNOTSUPP;
+
+	sta = sta_info_get_bss(sdata, addr);
+	if (!sta || !sta->sta.smd_params.smd_sta)
+		return -EINVAL;
+
+	return drv_get_smd_ctx(local, sdata, &sta->sta, type);
+}
+
+void ieee80211_get_smd_ctx_done(struct ieee80211_vif *vif,
+				const u8 *sta_addr,
+				struct cfg80211_smd_transition_info *st_info)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	cfg80211_get_smd_ctx_done(&sdata->wdev, sta_addr, st_info);
+}
+EXPORT_SYMBOL(ieee80211_get_smd_ctx_done);
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -6223,4 +6256,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.nan_set_local_sched = ieee80211_set_local_nan_sched,
 	.nan_set_peer_sched = ieee80211_set_peer_nan_sched,
 	.set_smd_ctx = ieee80211_set_smd_ctx,
+	.get_smd_ctx = ieee80211_get_smd_ctx,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index e764dd394de2..0339ff71cd4a 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1844,4 +1844,28 @@ static inline int drv_set_smd_ctx(struct ieee80211_local *local,
 	return ret;
 }
 
+static inline int drv_get_smd_ctx(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *sdata,
+				  struct ieee80211_sta *sta,
+				  enum nl80211_smd_ctx_type type)
+{
+	int ret;
+
+	if (!sdata || !local->ops->get_smd_ctx)
+		return -EOPNOTSUPP;
+
+	sdata = get_bss_sdata(sdata);
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	trace_drv_get_smd_ctx(local, sdata, sta, type);
+	ret = local->ops->get_smd_ctx(&local->hw, &sdata->vif, sta, type);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 5aa6f5b481e3..9ea0a8791289 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1312,6 +1312,7 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 {
 	struct ieee80211_local *local;
 	struct ieee80211_sub_if_data *sdata;
+	struct wireless_dev *wdev;
 	int ret, i;
 
 	might_sleep();
@@ -1321,6 +1322,7 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 
 	local = sta->local;
 	sdata = sta->sdata;
+	wdev = &sdata->wdev;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1390,6 +1392,10 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 	    rcu_access_pointer(sdata->u.vlan.sta) == sta)
 		RCU_INIT_POINTER(sdata->u.vlan.sta, NULL);
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP ||
+	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		cfg80211_free_pending_smd_ctx_req(wdev, sta->addr);
+
 	return 0;
 }
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 7aba79e441cf..38ad5076232d 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3487,6 +3487,33 @@ TRACE_EVENT(drv_set_smd_ctx,
 	)
 );
 
+TRACE_EVENT(drv_get_smd_ctx,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta,
+		 enum nl80211_smd_ctx_type type),
+
+	TP_ARGS(local, sdata, sta, type),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__field(u8, st_type)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_ASSIGN;
+		__entry->st_type = type;
+	),
+
+	TP_printk(LOCAL_PR_FMT VIF_PR_FMT STA_PR_FMT ", ST type=%u",
+		  LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->st_type
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.34.1

