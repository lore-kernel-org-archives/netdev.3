Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AC59574E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887429; cv=none; b=hMfLCJMQVEGnkuq4r+o41umY7Ea0xBN/goputFiQB8TufPeDyMDRtas6idNsujgu95XOt/XHlpH6M9XuZX+dZvIIgTPBdyF9eEYQcMwy6boScp8bxFVgl0jhrIymEQbIBmSBc4NtAbfpUQxro1FzMm4a1HdA1m/nQFaYVPIjJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887429; c=relaxed/simple;
	bh=okDgO6J3Qp+rfKQOFHaR0Wyt8fws8ufD69oII3M+1Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seNaKEXKtILT1ttW8LiKwhlZxhZcaDQ/9/r+B7ddBkNeJgqNxc7tL7MpzRp1Y1XRHxrFgenXY++KiHHfCiwq0FUINgqVB+bkxGmPc5aQAVd1n0Fj4caNkZ2vSyInAGzPIPBK/MUk78Kuq+au6tpAPnbyXgtzir99zYPLqiPIfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WvFh2BoL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GeRWPd38; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WvFh2BoL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GeRWPd38"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688GLtj13502117
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nlCSODNKgYyiYLj0bQxf12brdADlE9sLW5aEHOCrxXQ=; b=WvFh2BoL9HIwJNts
	rU57dRzSbWn+0mHU9byhzVGTpgLSqm6fIKPTQ+OfZFeKGFP1BEsLGGOZ0AUPqoOF
	pLlTgvYaJ9Zq+dSYlzlsju2+HgPHTgHEJ3l2Pn//6HAw16Sn9AvAWtowJNaLQOw2
	kFggbH9C9eWZ510EOmw4XVMqQQ3qi2h8jLWYGBmRj7UdRFISpvocOApUFWb0MrwI
	DN1HrwTUoo69xLuoiCAJKntHjwfrEgkYYjYRv1xV4VXwd5JFJy9k8YjTGUoVtBj+
	l+8oeBTEWVzYAuODkDhGDyisNwEtGG8iqdpHQLccyC4O4P+nsJNl1n08R6wWeCmx
	PE9nmw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjntpg8rk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso6987283a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887422; x=1789492222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nlCSODNKgYyiYLj0bQxf12brdADlE9sLW5aEHOCrxXQ=;
        b=GeRWPd38Q2omTDPFsYuJuAwcsyk0vdGtW/f0eg5vW+TIBV+hguZuB/R119PIv4O0NX
         YXTP4ur9G8aBAXxZG4yZirA9HzdMgHfoJi6uIbauPdNYg7u5LjYe4d4/6RWzdtOuvMvG
         rk2OCnOnacl4yRJqXvrqL7Wa/NkzVJFj829Qt5vZhNtJyYsIG029YcTR9QHsfekAp2Un
         rB1MOhHHk17PkfbuTIZ5BpFtbCWIB4YXl52uYTy4KOWVBvvPUq+8C0ZnajAZ034pMyH0
         1nNvyodQdR39BIYuFjdytAtoSEZA2Thrq3mo0sWRvW/K62yHW6QG5NTunyDM8r3BFyPe
         kYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887422; x=1789492222;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlCSODNKgYyiYLj0bQxf12brdADlE9sLW5aEHOCrxXQ=;
        b=KlRQGh4XHzsotfn/VbJsx8XEcXnbFL1HCEAG6Arf+OLScd/xitn9PM2kp5APuWWj1l
         Qq153iiPs1LQrbCLPPcWz/ZB/VoAbNp6xIXn26MBda06MB1kwydSHmWlTFCTQMfRAD2s
         YSlvEl81bDJ1kHeMU8r14a13bKR0TNHs43nATyEq7S0sqAB2g787u+iNrDqNl85agccC
         QN8MeMGmNHg8KfIvW9ML4g6U9uTEN8c1oQ3hQ4CjckMtXP6llM3NTu1BG7SpZ39Q3A7q
         fUE13cc+5SYqKaheTvPTeUpNiF3KpISYQc5YiHAEJQ0gHSkcCrsi/ELaBUz6Mz+B64/e
         mobQ==
X-Forwarded-Encrypted: i=1; AKwUvBynxxN2UvbLLUvctvuUOS/RnB3LVs9VQiCFreaH1DKivJGwweSn/cDjrbZnupGG7HzhJ+Lbm3s=@vger.kernel.org
X-Gm-Message-State: AFuF++mZvgrdYUwrgDoWwkYz0oxNGBi5GlGes7B2DUJfbGDrs8u+4fdc
	qwPk0/Dw5R+ajs7nffTCI4LDe13E4SqfY0JZrGGpmBCCfJVxIZnzKtgNvLIZuDTl0qpoTLkLpr6
	Lv0WgxUysOdh2clD8+Nh22mk1SyTgDMN7Cysr267du1IVZ229qr27/Wa+eQ==
X-Gm-Gg: AYBFou1B3UANLQV5xgjVEpsHd4DMHG5jASzt1zZ9LoVaV2WSt5vgF0lEygLbi00iBLn
	OeTvwH2NZ3dqQLASt0oP9vPd9d/7tanmqrsuscgWJHv2t8Qnq3Ses9VZIzvDZ/Uh4tLYUNotXSO
	4TEx8xMrifdttr6o3towd9ILWLL+gaVP3Jufqw8wC2n0J22iBklaT4+eiZUyliO50URAbJgH3J3
	UZvSDcmFlSXA17fGVwE5B9iiQj1lzNdM1Q3ihpV7x8VgQE++q1CM07fIF25lqPb8JK8EZmvEv4u
	+an6fHBH7TfE9OsnKqRL59IJ9iikha+Dps5KZisJ8xYp6TMcOnldyloQXuhbzaN9Ar0s/m6LAbE
	3lrWDLVlubcTa9M0SyH8yxUDf8CuiCQNoJSPnQP5FrRdY4rD7vIvP43MwhstriM9yWY6JLS2y7U
	ePkNZxA3niPy3IM+TWAj5cEQ==
X-Received: by 2002:a17:90a:1188:b0:39b:a8d8:985 with SMTP id 98e67ed59e1d1-39ba8d80b06mr1301933a91.12.1788887421412;
        Tue, 08 Sep 2026 10:10:21 -0700 (PDT)
X-Received: by 2002:a17:90a:1188:b0:39b:a8d8:985 with SMTP id 98e67ed59e1d1-39ba8d80b06mr1301889a91.12.1788887420741;
        Tue, 08 Sep 2026 10:10:20 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:19 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 05/18] wifi: cfg80211/mac80211: Parse SMD parameters in STA addition/modification
Date: Tue,  8 Sep 2026 22:39:33 +0530
Message-Id: <20260908-smd-v1-5-9fd2d876a1fb@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXyjyFdLKGsiCN
 hx/v7WeK66NhZOspvJsjho+v0y/GoaLNGV+yRDIMFtOHoOxp1OLYV6H4lHblbJECwXlIU1ssbkS
 2nFXBupwtor865VFky5Xiwsvj3MBwG7rwj6d72xvw1YnYo7qCxPMlRCQhAgEujK865qdud8/jCW
 nhyppxoDquaIPA/S25suCej73t8gYsUnouYH4vatKS5nYD5aF6e7IaTgFm95y6cogEChe6JaNYu
 5+/sKBKT9uxYTZErWRoCSOhnYSuscvHSRO7IiB98rY26VXl62CdrL0dHglsFxUCJUW48Le9nxLS
 MtstHVNCo8JAwz0ULKTY5heUScUSYMGjBRpSyjBnf9uefIvE7DK2oA38yzFgPaI77UyIrmx3I8J
 d9VqmozqFlFraaGY0zqogAfKDkVXWpyQ5xkxQwb8x7XAkrRmzbECsP+BR79jFudxY6jtTyFQbS2
 TcxrGjZI/ludCIlXHCA==
X-Authority-Analysis: v=2.4 cv=N+AZ0W9B c=1 sm=1 tr=0 ts=6aa04181 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Y27KnQjsX7IjzuVWbagA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: NYwTn32x9ZzvB9kfD3t5ISXPBii785LR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXxyiUsHyAq94A
 pwR4MtRQiurUiKois8nRHEzCWl71WifYdT9IGXvDYAIdKodHjw6p7qFAVcJFiROe+X3YfzMlVks
 2V/U46XESOzA12ai3sZbpiEztPw2L0I=
X-Proofpoint-GUID: NYwTn32x9ZzvB9kfD3t5ISXPBii785LR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080185

From: Aditya Sathish <asathish@qti.qualcomm.com>

When a non-AP MLD is getting added or having its capabilities updated,
handle the SMD parameters passed from userspace. Otherwise, drivers will
not be able to identify that the non-AP MLD has negotiated SMD with this
AP MLD during association nor can they support SMD BSS Transition if it
has been requested later by the non-AP MLD.

Signed-off-by: Aditya Sathish <asathish@qti.qualcomm.com>
Co-developed-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Co-developed-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 15 +++++++++++++
 include/net/mac80211.h       |  3 +++
 include/uapi/linux/nl80211.h | 17 ++++++++++++++
 net/mac80211/cfg.c           | 10 +++++++++
 net/mac80211/debugfs_sta.c   |  1 +
 net/mac80211/sta_info.h      |  2 ++
 net/wireless/nl80211.c       | 53 ++++++++++++++++++++++++++++++++++++++------
 7 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d0a269f4c711..bf33cf5366ef 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1897,6 +1897,19 @@ struct cfg80211_ttlm_params {
 	u16 ulink[8];
 };
 
+/**
+ * struct cfg80211_sta_smd_params - SMD parameters for an added station
+ *
+ * @smd_sta: SMD-negotiated STA
+ * @smd_identifier: SMD Identifier
+ * @dl_data_fwd: MSDU forwarding supported
+ */
+struct cfg80211_sta_smd_params {
+	bool smd_sta;
+	u8 smd_identifier[ETH_ALEN];
+	bool dl_data_fwd;
+};
+
 /**
  * struct station_parameters - station parameters
  *
@@ -1937,6 +1950,7 @@ struct cfg80211_ttlm_params {
  * @link_sta_params: link related params.
  * @epp_peer: EPP peer indication
  * @nmi_mac: MAC address of the NMI station of the NAN peer
+ * @smd_params: SMD params for this station
  */
 struct station_parameters {
 	struct net_device *vlan;
@@ -1965,6 +1979,7 @@ struct station_parameters {
 	struct link_station_parameters link_sta_params;
 	bool epp_peer;
 	const u8 *nmi_mac;
+	struct cfg80211_sta_smd_params smd_params;
 };
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6b82ca07fbf0..d8f5e5d8a021 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2727,6 +2727,7 @@ struct ieee80211_link_sta {
  * @nan_sched: NAN peer schedule for this station. Valid only for NMI stations.
  * @ext_mld_capa_ops: the MLD's extended MLD capabilities and operations
  *	NOTE: currently only tracked for AP STAs
+ * @smd_params: SMD parameters of the STA
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2761,6 +2762,8 @@ struct ieee80211_sta {
 	/* should only be accessed with the wiphy mutex held */
 	struct ieee80211_nan_peer_sched *nan_sched;
 
+	struct cfg80211_sta_smd_params smd_params;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f5c8dbe5f26a..f1d8db31f17e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3191,6 +3191,17 @@ enum nl80211_commands {
  *	%NL80211_EXT_FEATURE_SMD.
  *	Used with %NL80211_CMD_START_AP. See &enum nl80211_smd_params_attrs.
  *
+ * @NL80211_ATTR_PEER_SMD_ENABLED: Flag indicating a peer STA has SMD enabled.
+ *	Used with %NL80211_CMD_NEW_STATION.
+ *
+ * @NL80211_ATTR_PEER_SMD_MAC_ADDR: Binary attribute with the 6-byte MAC
+ *	address of the SMD-capable peer STA.
+ *	Used with %NL80211_CMD_NEW_STATION.
+ *
+ * @NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING: Flag indicating the peer STA
+ *	supports DL data forwarding within the SMD domain.
+ *	Used with %NL80211_CMD_NEW_STATION.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3793,6 +3804,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SMD_PARAMS,
 
+	NL80211_ATTR_PEER_SMD_ENABLED,
+	NL80211_ATTR_PEER_SMD_MAC_ADDR,
+	NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3942,6 +3957,7 @@ enum nl80211_iftype {
  *	that support %NL80211_FEATURE_FULL_AP_CLIENT_STATE to transition a
  *	previously added station into associated state
  * @NL80211_STA_FLAG_SPP_AMSDU: station supports SPP A-MSDUs
+ * @NL80211_STA_FLAG_SMD: station has negotiated SMD.
  * @NL80211_STA_FLAG_MAX: highest station flag number currently defined
  * @__NL80211_STA_FLAG_AFTER_LAST: internal use
  */
@@ -3955,6 +3971,7 @@ enum nl80211_sta_flags {
 	NL80211_STA_FLAG_TDLS_PEER,
 	NL80211_STA_FLAG_ASSOCIATED,
 	NL80211_STA_FLAG_SPP_AMSDU,
+	NL80211_STA_FLAG_SMD,
 
 	/* keep last */
 	__NL80211_STA_FLAG_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4b42790c5d7..138b67f4bda4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2528,6 +2528,16 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
 		sta->sta.spp_amsdu = set & BIT(NL80211_STA_FLAG_SPP_AMSDU);
 
+	if (mask & BIT(NL80211_STA_FLAG_SMD)) {
+		if (set & BIT(NL80211_STA_FLAG_SMD))
+			set_sta_flag(sta, WLAN_STA_SMD);
+		else if (test_sta_flag(sta, WLAN_STA_SMD))
+			clear_sta_flag(sta, WLAN_STA_SMD);
+	}
+
+	if (params->smd_params.smd_sta)
+		sta->sta.smd_params = params->smd_params;
+
 	/* mark TDLS channel switch support, if the AP allows it */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
 	    !sdata->deflink.u.mgd.tdls_chan_switch_prohibited &&
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index ef75255d47d5..d7e7c9c578e4 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -78,6 +78,7 @@ static const char * const sta_flag_names[] = {
 	FLAG(PS_DELIVER),
 	FLAG(USES_ENCRYPTION),
 	FLAG(DECAP_OFFLOAD),
+	FLAG(SMD),
 #undef FLAG
 };
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index ee0d32877c5b..506aeb241a6d 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -72,6 +72,7 @@
  * @WLAN_STA_USES_ENCRYPTION: This station was configured for encryption,
  *	so drop all packets without a key later.
  * @WLAN_STA_DECAP_OFFLOAD: This station uses rx decap offload
+ * @WLAN_STA_SMD: this station is associated to an SMD-ME.
  *
  * @NUM_WLAN_STA_FLAGS: number of defined flags
  */
@@ -104,6 +105,7 @@ enum ieee80211_sta_info_flags {
 	WLAN_STA_PS_DELIVER,
 	WLAN_STA_USES_ENCRYPTION,
 	WLAN_STA_DECAP_OFFLOAD,
+	WLAN_STA_SMD,
 
 	NUM_WLAN_STA_FLAGS,
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index aa7aa70a5b41..0d20c2ab3d5e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1114,6 +1114,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_STA_DUMP_LINK_STATS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_SMD_PARAMS] =
 		NLA_POLICY_NESTED(nl80211_smd_params_policy),
+	[NL80211_ATTR_PEER_SMD_ENABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_PEER_SMD_MAC_ADDR] = NLA_POLICY_ETH_ADDR,
+	[NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -7702,6 +7705,7 @@ static const struct nla_policy sta_flags_policy[NL80211_STA_FLAG_MAX + 1] = {
 	[NL80211_STA_FLAG_MFP] = { .type = NLA_FLAG },
 	[NL80211_STA_FLAG_AUTHENTICATED] = { .type = NLA_FLAG },
 	[NL80211_STA_FLAG_TDLS_PEER] = { .type = NLA_FLAG },
+	[NL80211_STA_FLAG_SMD] = { .type = NLA_FLAG },
 };
 
 static int parse_station_flags(struct genl_info *info,
@@ -7768,11 +7772,13 @@ static int parse_station_flags(struct genl_info *info,
 	switch (iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
+		params->sta_flags_mask = BIT(NL80211_STA_FLAG_SMD);
+		fallthrough;
 	case NL80211_IFTYPE_P2P_GO:
-		params->sta_flags_mask = BIT(NL80211_STA_FLAG_AUTHORIZED) |
-					 BIT(NL80211_STA_FLAG_SHORT_PREAMBLE) |
-					 BIT(NL80211_STA_FLAG_WME) |
-					 BIT(NL80211_STA_FLAG_MFP);
+		params->sta_flags_mask |= BIT(NL80211_STA_FLAG_AUTHORIZED) |
+					  BIT(NL80211_STA_FLAG_SHORT_PREAMBLE) |
+					  BIT(NL80211_STA_FLAG_WME) |
+					  BIT(NL80211_STA_FLAG_MFP);
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_STATION:
@@ -8913,7 +8919,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 8);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 9);
 
 	switch (statype) {
 	case CFG80211_STA_MESH_PEER_KERNEL:
@@ -9007,7 +9013,8 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 				  BIT(NL80211_STA_FLAG_SHORT_PREAMBLE) |
 				  BIT(NL80211_STA_FLAG_WME) |
 				  BIT(NL80211_STA_FLAG_MFP) |
-				  BIT(NL80211_STA_FLAG_SPP_AMSDU)))
+				  BIT(NL80211_STA_FLAG_SPP_AMSDU) |
+				  BIT(NL80211_STA_FLAG_SMD)))
 			return -EINVAL;
 
 		/* but authenticated/associated only if driver handles it */
@@ -9261,6 +9268,30 @@ static int nl80211_parse_sta_txpower_setting(struct genl_info *info,
 	return 0;
 }
 
+static int nl80211_set_station_smd(struct genl_info *info,
+				   struct station_parameters *params)
+{
+	struct nlattr *smd_mac;
+
+	params->smd_params.smd_sta =
+		!!info->attrs[NL80211_ATTR_PEER_SMD_ENABLED];
+
+	if (!params->smd_params.smd_sta)
+		return 0;
+
+	smd_mac = info->attrs[NL80211_ATTR_PEER_SMD_MAC_ADDR];
+
+	if (!info->attrs[NL80211_ATTR_MLD_ADDR] || !smd_mac)
+		return -EINVAL;
+
+	nla_memcpy(params->smd_params.smd_identifier, smd_mac, ETH_ALEN);
+
+	params->smd_params.dl_data_fwd =
+		!!info->attrs[NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING];
+
+	return 0;
+}
+
 static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -9399,6 +9430,10 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	err = nl80211_set_station_smd(info, &params);
+	if (err)
+		return err;
+
 	/* Include parameters for TDLS peer (will check later) */
 	err = nl80211_set_station_tdls(info, &params);
 	if (err)
@@ -9627,6 +9662,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	if (parse_station_flags(info, wdev->iftype, &params))
 		return -EINVAL;
 
+	err = nl80211_set_station_smd(info, &params);
+	if (err)
+		return err;
+
 	/* HT/VHT requires QoS, but if we don't have that just ignore HT/VHT
 	 * as userspace might just pass through the capabilities from the IEs
 	 * directly, rather than enforcing this restriction and returning an
@@ -9660,7 +9699,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 8);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 9);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:

-- 
2.34.1

