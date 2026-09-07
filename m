Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8AA52ED59
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813261; cv=none; b=Fxxwl4k66BXnblXuuiCCYGDAdufQh3NuVQXh9PjaLY2ygPtmITR7bzF1dxHgxIH/Ux4QyEeQGBBj/Rj7wNOpAGGK4Xt4LHJIgRKiaF0JQzf2VCbZmsq/x45eUpi61o4nxDUnbLKASxlA/K13NGvPP0nLOGFqnP3Anjr5EVFjyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813261; c=relaxed/simple;
	bh=1uMWzUWflebLiT0iHAY0034lgOkn4kH51Nlr0m2TKN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4wO8FH+iRz4uP/rkNKMGV1cB02hdC6n56JzLpXmgqUL7jGO/9ETkz4cQ5cA8e9TeiOUSSESErSNBLaW42A4ClhAt39DymF7kSxuenQ99qhRa6uJJy2wJ210PjS53CB42TwjI/X1vfNntJ2BLtaoRVDpG5l8vd9A/YjGtafsdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PDC31RPT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kptrbbyO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PDC31RPT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kptrbbyO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687HXDYc552607
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DAgmn3n8oR+1sTJOd89f91uGu1zJpklwZxV7NMQTcT0=; b=PDC31RPT4SMfGTS8
	4Wa6ZryAh/s1D4T4Ow6jnXw52Tlu4uUayey6XOYoSuWd1ylzc16uoOaink5GPVOX
	Doz2VE8380UFCw4ZRWgjln+/mnPzETFArWc5ZvkI1EgDPUxdS4zrK8QWusyHbXp6
	bs1ptYryQFxp4nMOmZAtj58PsDQdKp9gZ+fUeg6W8J0RdADU/CznaOw1++vQ8pXA
	D7HADFKbddx4T2y+nQ9bDlrnbpjLbjPrgqJpVUcJpnuPjP2fnLd0/x+DY50bDZIM
	LElQT78K5jn/P22qg0GsjLYanVe6cqY+kwt4u0z/J9B9g7Z26XM7myKQpt4zTXZb
	9zo1Dg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwgfk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:34:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so44550755ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788813256; x=1789418056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAgmn3n8oR+1sTJOd89f91uGu1zJpklwZxV7NMQTcT0=;
        b=kptrbbyOp2GBFb0fZz392DT6HOdLW6SxFNX+o5Nbm2C0Fh5t0wBcpCzyO3LjYRQwgJ
         +cfhYxofV9edkc5xrRXHa0MZxGKZyekCay2sMK1CoeyBpjK+8u1pBbdnB00hMk5PI6Hh
         m177CVUUKSrlP6zvQycMNB+IBLaw6rS+DlwY+qm7DLeKMRZxLtVbHD/tk9oB/cMEuvAe
         Vwm2KJLraPAn/jDZK0NwuxgLc/RLki9MtKda4ySIO2m73SW51RZ2+5VUuqvddlrElo4f
         OLNG63d9y1H5iwdIVHeDmvhgVOjE1OZ4k1s/0Jnq7Ie0SrwWfsJWfvPP2EvDggsM2Qra
         SqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813256; x=1789418056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAgmn3n8oR+1sTJOd89f91uGu1zJpklwZxV7NMQTcT0=;
        b=MiOeInIYB8hj5GABMeKs9sfznM9rxeB/sxCAJhMcDV9YCEb+QfF14W9sN+jYspVz+9
         5d78LQNPe9gBCSQkNcnpLRKgLdBOd9qRpd+K9DenYrI18oZTvwpRaHlo28lP4AS7Nu0L
         QH/a/s/5O8xz7lX28qSomvwqPkLAPvFuujTrzGdb8c3EcMvGe1ycnNrVbs5ZyCN5gtd2
         xVTo7jw5b5pE4HVvJt8waTPlsI6oJc3wXGJU5E7aW2P76qvNtJgv6QB89w1RnVNc9MYm
         IDbzu0SVotafoP9hZmDvx3MplrucqVlCGKolzgtbXytcN6SObaEPBdrccyBCvb4IXynq
         2//w==
X-Forwarded-Encrypted: i=1; AKwUvBxFOmnXcI0RgPLewS5smCWms8VYKF7vYjhi0BEhaqVXyqWdr/NR7WuXsM00SEO5qg34XSX8lLE=@vger.kernel.org
X-Gm-Message-State: AFuF++kMHQ4huYb4Z7eZ/VtphKN4Hpuu6fO6mJ2nzgrNAX8v2MhLNjhx
	OuoyP0DB/cAbwoD+zEcO1oThXCTwV/m0XpXwjGbfgoRH/PdvZiYNWO3xjMC+2aFNP1FJJEVwl3x
	2dst6xpJOgGTWe2/692yToqilj44JR9w0pTpsbn4K/fOieaRgona4/XydBg==
X-Gm-Gg: AYBFou1F5YaTema/s36gaKnmhfCCVzjrFMJsMomv+Dm4t+ig18JERlYsGrOUHhsbmVh
	7DEo/voIVMot7bdwaSnRsyLuzEk0SBU2irYKnQkOzTixFvmAVsk6eEI1XnAZkwyS5x6ZrHJIW6D
	07k/Gvy5slKUQ4ZkAhuSSgmHMdklh3H2poiab/ZgkO/2yqkLkkRhio79HO1+zo6FUwX5dzhRWpp
	82rh+8z+X1ccLA+aFMzdWdsCdaA+/SJJqGRWhopDkumv/u49+ma2RwEFAVwiuiUkusxpO6DV4TU
	NgicvQdMmI6GESpOqWz9pdg+fPYtu0C5VS5yvB+pZUExA4mxxAbxfZ4m22HbzChQD5VPIEEjFKc
	KyOxlyq3TDz4xNjLiQOx6hKpdOHMCq5SSvteIifTtih6AqiIXFjk8k2SwqHiszM3riW5op7teco
	yMlfhHJhWiWDAMtOhtkisvkQ==
X-Received: by 2002:a17:903:4b04:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2db124b1ae2mr338036215ad.6.1788813255583;
        Mon, 07 Sep 2026 13:34:15 -0700 (PDT)
X-Received: by 2002:a17:903:4b04:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2db124b1ae2mr338035425ad.6.1788813255020;
        Mon, 07 Sep 2026 13:34:15 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm47841297eec.16.2026.09.07.13.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:34:14 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:59:25 +0530
Subject: [PATCH wireless-next 16/18] wifi: mac80211: Add mac80211 support
 to handle NL80211_CMD_SET_SMD_CTX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-smd-v1-16-65ad4ab30fbd@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9f1fc8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zHDNONmbSdC_GOYWSZkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX0vCasGsSvd4Q
 ZQ4MNFqpW5oqquao1rJwxcmkr/wcAXtjzhD0wkmL57Krlsr3Fi6roEbvImT67MzOWJ09EVO2Chv
 wpNNXvPxivJbUJR5vZ1ToGH4g9VGz29Gd5FIntK9VBB5yuAAHiJbkmOvTNHuwApLRpdsPeInsgw
 qjGka8E2r+2TPZtgfO2XTc+d4CTNpLvqMkoRX8zQ+Nna6L7ythdrp8B05IyNC6NYzXmwPSInBJN
 4+1bbPWGk+E0h9eedwFMMYPLqC+tAjZDFKbQLERyShjJAdDs9r0uaWio2F2fb4gt8eT61hzHbaG
 fnQ40JQGESpED3nS3vOpXJWuk0CVuj7dNOstb0XWxiM6kmgX5LF/gdHyeWUKo7msi+B/5DUlXhn
 FtQhJTdkkXMRQkNycQuGZF0oxeUds7FPZpTDMZd8SJ8NvtsVE8E3j3RYK9ukvh+aNge5Lmgth7S
 aoWRIr3nZa1XUp/yr4g==
X-Proofpoint-ORIG-GUID: qcXDplCtZ3c-Wi1y8dDQyDEL48OSR4BP
X-Proofpoint-GUID: qcXDplCtZ3c-Wi1y8dDQyDEL48OSR4BP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX1eP8++0DFDar
 8qhE7/EvWnTh6YLECQAy0F5eXk0WsyTqFVmXvXlgkDylQ2e3DMS0tLpAK4IS+RaW9gsLZmSjH5K
 zwxrXvipRnHlsVTz90udcj3F/NCjmk0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070226

cfg80211 accepts NL80211_CMD_SET_SMD_CTX on the target AP MLD for
userspace to be able to program the station's dynamic context on the TX
and RX queues.

Add mac80211 support to handle NL80211_CMD_SET_SMD_CTX in the driver and
lower layers so that the context is installed and the target AP MLD is
ready to continue data transfer with the non-AP MLD from where it may
have left off at the current AP MLD. This enables the seamless roaming
facilitation of the SMD BSS Transition procedure.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/mac80211.h    |  5 +++++
 net/mac80211/cfg.c        | 24 +++++++++++++++++++++++
 net/mac80211/driver-ops.h | 24 +++++++++++++++++++++++
 net/mac80211/trace.h      | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b4b1d3db9b19..e0e13f0ed31f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4780,6 +4780,8 @@ enum ieee80211_sta_smd_state {
  * @sta_smd_state: Notifies low level driver about IEEE 802.11bn SMD substate
  *	transition of a station. It must not fail while transitioning down.
  *	The callback can sleep.
+ * @set_smd_ctx: Set the UHR SMD context for the non-AP MLD. This is used on
+ *	the target AP MLD side to program dynamic context.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -5186,6 +5188,9 @@ struct ieee80211_ops {
 			     struct ieee80211_sta *sta,
 			     enum ieee80211_sta_smd_state old_state,
 			     enum ieee80211_sta_smd_state new_state);
+	int (*set_smd_ctx)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta,
+			   struct cfg80211_smd_transition_info *st_info);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0ea8b610a771..268d5f42293a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -6081,6 +6081,29 @@ ieee80211_set_peer_nan_sched(struct wiphy *wiphy,
 	return ieee80211_nan_set_peer_sched(sdata, sched);
 }
 
+static int ieee80211_set_smd_ctx(struct wiphy *wiphy, struct wireless_dev *wdev,
+				 const u8 *addr,
+				 struct cfg80211_smd_transition_info *st_info)
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
+	return drv_set_smd_ctx(local, sdata, &sta->sta, st_info);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -6199,4 +6222,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_epcs = ieee80211_set_epcs,
 	.nan_set_local_sched = ieee80211_set_local_nan_sched,
 	.nan_set_peer_sched = ieee80211_set_peer_nan_sched,
+	.set_smd_ctx = ieee80211_set_smd_ctx,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index ce11a723ec36..e764dd394de2 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1820,4 +1820,28 @@ int drv_sta_smd_state(struct ieee80211_local *local,
 		      enum ieee80211_sta_smd_state old_state,
 		      enum ieee80211_sta_smd_state new_state);
 
+static inline int drv_set_smd_ctx(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *sdata,
+				  struct ieee80211_sta *sta,
+				  struct cfg80211_smd_transition_info *st_info)
+{
+	int ret;
+
+	if (!local->ops->set_smd_ctx)
+		return -EOPNOTSUPP;
+
+	sdata = get_bss_sdata(sdata);
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	trace_drv_set_smd_ctx(local, sdata, sta, st_info);
+	ret = local->ops->set_smd_ctx(&local->hw, &sdata->vif, sta, st_info);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 63838a6d5d07..7aba79e441cf 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3438,6 +3438,55 @@ TRACE_EVENT(drv_sta_smd_state,
 	)
 );
 
+TRACE_EVENT(drv_set_smd_ctx,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta,
+		 struct cfg80211_smd_transition_info *st_info),
+
+	TP_ARGS(local, sdata, sta, st_info),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__field(u8, st_type)
+		__field(unsigned int, num_tids)
+		__dynamic_array(unsigned long, dl_tid_bitmap,
+				BITS_TO_LONGS(IEEE80211_SMD_CTX_NUM_TIDS))
+		__dynamic_array(unsigned long, ul_tid_bitmap,
+				BITS_TO_LONGS(IEEE80211_SMD_CTX_NUM_TIDS))
+	),
+
+	TP_fast_assign(
+		struct ieee80211_smd_ctx *ctx = st_info->ctx;
+		unsigned long sz;
+
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_ASSIGN;
+		__entry->st_type = st_info->type;
+
+		__entry->num_tids = IEEE80211_SMD_CTX_NUM_TIDS;
+		sz = BITS_TO_LONGS(__entry->num_tids) * sizeof(unsigned long);
+
+		memcpy(__get_dynamic_array(dl_tid_bitmap),
+		       ctx->dl.valid_tid_bmap, sz);
+		memcpy(__get_dynamic_array(ul_tid_bitmap),
+		       ctx->ul.valid_tid_bmap, sz);
+	),
+
+	TP_printk(LOCAL_PR_FMT VIF_PR_FMT STA_PR_FMT
+		  ", ST type=%u DL TIDs: %*pb, UL TIDs: %*pb",
+		  LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG,
+		  __entry->st_type,
+		  __entry->num_tids,
+		  (unsigned long *)__get_dynamic_array(dl_tid_bitmap),
+		  __entry->num_tids,
+		  (unsigned long *)__get_dynamic_array(ul_tid_bitmap)
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.34.1

