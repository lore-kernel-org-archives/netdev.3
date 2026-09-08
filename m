Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FC59650C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887434; cv=none; b=OogUJQ7dBa2nv8iY5sk5uutluqjcwyn9HiQ1+vivZFeRHAol2X2mm0+NHLnLxLS0btvcQpr5NOnZbj32EADuCHqmeX12LaY/5xePVW+4zsh2fgskabOzJHHLlAsxcaGhr5JJt4MgFrjSdneOnNs+NeI/nCLxw//W9KPWwhCO6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887434; c=relaxed/simple;
	bh=XxXeGyH8LowR4EFnJMlxM2wbsxxbipviiWhjmsnKVcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL9H8c5p8advarkmRAihoREUuqSftBnHOpskwNo2zJpSDuXGiLsyiC+WZHQFizOVnr1sLyOgHqQ50mnEP2l/4agQXOaBBZnhRN48gleyi9GmgpnNy1Se9U5zYL72YJ4NRVHEJGUeePVWl2sQ94fUSmrS2//Z5+jEPg/bqzSqXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bcGV4iSh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ewiXhf1X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcGV4iSh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ewiXhf1X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdsGT3613809
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C4KjAE1JwpT6DGpnh/CZZfax3IJ/HuYkECxZMwDBCSw=; b=bcGV4iShr1WjK6WU
	k+FPPVCh5GtbwDvxe1TVs+NZd4wXStEB+u1NnGQQq3qDjqD4/kJr9fteRDpohbeg
	3itsGYEIMFRlv4s7C9rsPZYCMN0S9wwCPd7Aq2CJLWBgOsr69ocDxFBQ6jgtRKgl
	CEDScjEXNTfPuHRcybvWm7QD7GUlgmIHTDcf0b4cCVeuxKfkoMp0//a4NTS99x9r
	SuM6ZMIRhD1ad8vcJKSq8jWUr4rNId003e7fu8KwuXiyi+MrZiAvDX4pHn6H9hLa
	92vrbd9P9/ywhb7ZrjJx4eqgmF4IS7sZfNiLn4xdVdB2NhlhojErOzaz45ao3d0B
	+AXVXg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjagukduy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d7e0f3b4so5806378a91.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887430; x=1789492230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4KjAE1JwpT6DGpnh/CZZfax3IJ/HuYkECxZMwDBCSw=;
        b=ewiXhf1XsDC+dlUHhlrs9tN6fcY7SVB7754HpIiV1d2cnnD/Fr1bb6puCZ/zVSEE2q
         b3PORGac+UhdhpEj+loTFnawut/LYG0KfzMDe0tIf31bGzj5mPygz6vuX+mgRYYKfXkH
         GotR9YmuBBgml4UGevQ4Yy7Op8vnhp482GF/63dPx1GICWwOzK3GeU+sC1HIx66OjkCQ
         96jMc088qRZ9LxsG0RPgIgh6hKgUl0NlAuevbx/YVgeQtXJrSM6cdStJik+cy4IAczBf
         KWw+wBoPsBBRZuYH32vb9nx1HTJXT7o34nyJ2yCmGHyWxr9wtyq+nc8rsyRJf30cd7l6
         zC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887430; x=1789492230;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4KjAE1JwpT6DGpnh/CZZfax3IJ/HuYkECxZMwDBCSw=;
        b=L9lGeCNTGdupL9ZRlEgy6zQR3NFFWWjDdXjeL2e3UDiUm7jVEaqdrKeXEg2+J4uiF3
         AYfUXCQtPlVBwCvz+5pQ3tjfn83SJHIcBQ16pWO6yC5mmROs7dHm9Nr6BDx2ByPHwtP/
         TXd0Ci9BAfGHfY2mecvDTGO54Wi0GKUNYRu3rePAU9mN6+DBBSev6zwkVOMUY8jv+xDv
         sCvDC3Fj7ErR0C1fEGvV7Dmn87IqOu/8n9GH2FjThXuO4QFvYRbQXzwgUNSE6gf81NkM
         BxXfwG/Uv//42/I1nVHi6v3dEiYrtQNB9L8iuS+c4+x2m7ggOkVGprripjlIeHxyz50P
         /P6g==
X-Forwarded-Encrypted: i=1; AKwUvByVswF1YZZRm9xGW4GGRmLGMTAaEIengiwPHoRSFQfqIgJ5/LJ6qXYPT6QC0iZG7Lc94ApL630=@vger.kernel.org
X-Gm-Message-State: AFuF++mb4KcdXDjWXyYbnUv3BEN32wHRNseJkBhc3TXM8MI37vUYo2Lu
	ahNGQiD/SpvyepW1baAqaiGt4vL/VA5Iu0se7oj1LXseBaccjUx7zM29eoJ5soaq82WisqX1LG8
	m5wo5HgLWrPwmKH3+TasYAU23RN96EJgj6XweOiaCup7n0gbepiela+45LQ==
X-Gm-Gg: AYBFou3zMmx/i6ogEv/ZPxap8VfHCfJ9NxSdV6EW3mBVFSRts+ASftqYm/0tS/7mhb0
	44+Vpy3iVreZGL+d3rOFgYWxojdxaMYn2O0FgpempLdMX+NwHjfD4FQoCxm2kLw8/L59rWjRqCl
	l0uTxKBkKuHsu7tGFngl7lXHW9L0p1hUsNJXlOFlh+UeTUFdvMkvHLwCIOZ59Y0l7t9wPGMpKBq
	fXeRIPDev886ecqGi6bg7mQoI6SXugKvj8zVfyq7Ds6OAOFZQJQg3NEgKolSe6HGKmrq0sJCLqL
	Hh1PrOLs75yRDtiDccI3cz9fAMJdNm3j6oOzA+6BB3LH2wtkBurS18kBFOS/sip8e07t7BVfXEO
	/QxfgPUn63j0hH58eT9LoFw5Xp3SNOOOJiz9C6JbzichtJOv1wx++7XJAbF6J5/DUXu2TIVgsBI
	fdBESWYUQhN2NqGB8v6ATbNQ==
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39b262aaf32mr46577649a91.19.1788887429937;
        Tue, 08 Sep 2026 10:10:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39b262aaf32mr46577563a91.19.1788887429279;
        Tue, 08 Sep 2026 10:10:29 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:28 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 07/18] wifi: nl80211/mac80211: Add SMD BSS Transition sub-state STA flags
Date: Tue,  8 Sep 2026 22:39:35 +0530
Message-Id: <20260908-smd-v1-7-9fd2d876a1fb@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6aa04187 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=olGzuFvk815fMYXliRYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: F474gvSjCPJI9CpMcxyC1jlKLdU9pO7s
X-Proofpoint-ORIG-GUID: F474gvSjCPJI9CpMcxyC1jlKLdU9pO7s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfX9ijp3Fvo5Jxh
 vop0nvx/vPQQyo8cCBaGeenWOgMVAGXhi9YbbJPEo6BRoBQVgM6egUNkFfm9ggiPSFoMvxx9DgU
 JEkd22yG2v++EfGH+gXM4vt4SzEfFWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfX8OHeHWS8OdcR
 tsgbA0Axb4mP8ToolLHq67jcw5p5KC/GxdFl99opvbQkrggkDAb+liiDfMcCn/OCamZ/s4osPTk
 IZeugDPvsLg9bvDphTiWeszWL1THFrhxArfjZoiZlATtCFJUPNd0lKarM72zd2pi7xAEgSyo3U2
 8Y+11sgmz5ImKTzV1kZliQSX5RzNSiIsErzAklsm6cgUPYcEjVtQeXS2m8AxqMBmcb/kni6GVlZ
 RSLlIF88EmSW0rJ4FARst+Q3zFF2bRCP0Vz+LS1fpMn3hkeixUAocDCLsrR6/BNkk0r3CkbHWjs
 qLBkFP/GoCpwASbo2xumWJEyuwsl9JSWKy9OWaWtk4W2S5Pbzid/kN9adXDXAO92fIxD+xpGN2h
 /80/5SoNpbMbbiz12LJu+ksqGv72kUcIKRG22Gs7y1j4xk7BsM/DUJs6xcqJx/gkeXDhBLf0Wvx
 bzuyOlOkRDorvamUIfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080185

IEEE P802.11bn/D2.0, Aug 2026, subclause 11.3.1, defines three new MLD
state sub-states (4a, 4b, 4c) that apply when a non-AP MLD and its
associated SMD-ME are in state 4 and an SMD BSS Transition is
in progress.

Add the corresponding nl80211 STA flags:
  NL80211_STA_FLAG_SMD_PREP_TARGET -- State 4a: target AP MLD prepared;
    Class 3 frames blocked except ST execution request/response.
  NL80211_STA_FLAG_SMD_EXEC_CURRENT -- State 4b: ST execution active on
    current AP MLD; UL Class 3 data blocked.
  NL80211_STA_FLAG_SMD_DL_DRAIN -- State 4c: DL draining period; only
    control frames and UHR Reconfiguration Notify permitted on current
    AP MLD.

Add three internal station flags to track the 802.11bn SMD BSS
Transition sub-states (4a/4b/4c) in mac80211:

  WLAN_STA_SMD_PREP_TARGET - State 4a
  WLAN_STA_SMD_EXEC_CURRENT - State 4b
  WLAN_STA_SMD_DL_DRAIN - State 4c

These are transient sub-states of WLAN_STA_AUTHORIZED with the SMD-ME.
The station remains authenticated, associated, and RSNA-established
throughout; only the frame-filtering rules change. At most one of the
three may be set at a time; mutual exclusion is enforced in
sta_apply_smd_state_flags().

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 10 ++++++++
 net/mac80211/cfg.c           | 60 ++++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c   |  3 +++
 net/mac80211/sta_info.h      |  8 ++++++
 net/wireless/nl80211.c       | 18 ++++++++++---
 5 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5e474fda2a49..65c7eefe9db5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3965,6 +3965,13 @@ enum nl80211_iftype {
  *	previously added station into associated state
  * @NL80211_STA_FLAG_SPP_AMSDU: station supports SPP A-MSDUs
  * @NL80211_STA_FLAG_SMD: station has negotiated SMD.
+ * @NL80211_STA_FLAG_SMD_PREP_TARGET: station is prepared at SMD target AP MLD
+ *	(State 4a). Class 3 frames blocked except ST execution req/resp.
+ * @NL80211_STA_FLAG_SMD_EXEC_CURRENT: current AP MLD is executing SMD BSS
+ *	Transition (State 4b). Uplink Class 3 data blocked after exec-req Tx.
+ * @NL80211_STA_FLAG_SMD_DL_DRAIN: current AP MLD is in DL draining period
+ *	(State 4c). Both directions restricted; only control and UHR Reconf
+ *	Notify frames are permitted.
  * @NL80211_STA_FLAG_MAX: highest station flag number currently defined
  * @__NL80211_STA_FLAG_AFTER_LAST: internal use
  */
@@ -3979,6 +3986,9 @@ enum nl80211_sta_flags {
 	NL80211_STA_FLAG_ASSOCIATED,
 	NL80211_STA_FLAG_SPP_AMSDU,
 	NL80211_STA_FLAG_SMD,
+	NL80211_STA_FLAG_SMD_PREP_TARGET,
+	NL80211_STA_FLAG_SMD_EXEC_CURRENT,
+	NL80211_STA_FLAG_SMD_DL_DRAIN,
 
 	/* keep last */
 	__NL80211_STA_FLAG_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 138b67f4bda4..69b3ac0b48f3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2452,6 +2452,55 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	return 0;
 }
 
+static int sta_apply_smd_state_flags(struct sta_info *sta,
+				     u32 mask, u32 set)
+{
+	bool smd_prep_target, smd_exec_current, smd_dl_drain;
+	u32 expected_mask = BIT(NL80211_STA_FLAG_SMD_PREP_TARGET) |
+			    BIT(NL80211_STA_FLAG_SMD_EXEC_CURRENT) |
+			    BIT(NL80211_STA_FLAG_SMD_DL_DRAIN);
+	u32 smd_flags;
+
+	if (!(mask & expected_mask))
+		return 0;
+
+	smd_flags = mask & expected_mask & set;
+	if (WARN_ON(hweight32(smd_flags) > 1))
+		return -EINVAL;
+
+	smd_prep_target =
+		!!(smd_flags & BIT(NL80211_STA_FLAG_SMD_PREP_TARGET));
+	smd_exec_current =
+		!!(smd_flags & BIT(NL80211_STA_FLAG_SMD_EXEC_CURRENT));
+	smd_dl_drain =
+		!!(smd_flags & BIT(NL80211_STA_FLAG_SMD_DL_DRAIN));
+
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) &&
+	    (smd_exec_current || smd_dl_drain))
+		return -EINVAL;
+
+	if (smd_prep_target) {
+		clear_sta_flag(sta, WLAN_STA_SMD_EXEC_CURRENT);
+		clear_sta_flag(sta, WLAN_STA_SMD_DL_DRAIN);
+		set_sta_flag(sta, WLAN_STA_SMD_PREP_TARGET);
+	} else if (smd_exec_current) {
+		clear_sta_flag(sta, WLAN_STA_SMD_PREP_TARGET);
+		clear_sta_flag(sta, WLAN_STA_SMD_DL_DRAIN);
+		set_sta_flag(sta, WLAN_STA_SMD_EXEC_CURRENT);
+	} else if (smd_dl_drain) {
+		clear_sta_flag(sta, WLAN_STA_SMD_PREP_TARGET);
+		clear_sta_flag(sta, WLAN_STA_SMD_EXEC_CURRENT);
+		set_sta_flag(sta, WLAN_STA_SMD_DL_DRAIN);
+	} else {
+		/* all flags revert back to none being set */
+		clear_sta_flag(sta, WLAN_STA_SMD_PREP_TARGET);
+		clear_sta_flag(sta, WLAN_STA_SMD_EXEC_CURRENT);
+		clear_sta_flag(sta, WLAN_STA_SMD_DL_DRAIN);
+	}
+
+	return 0;
+}
+
 static int sta_apply_parameters(struct ieee80211_local *local,
 				struct sta_info *sta,
 				struct station_parameters *params)
@@ -2538,6 +2587,17 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->smd_params.smd_sta)
 		sta->sta.smd_params = params->smd_params;
 
+	/*
+	 * SMD BSS Transition sub-states (IEEE P802.11bn/D2.0, Aug 2026,
+	 * subclause 11.3.1).
+	 * Only meaningful for SMD-capable stations (WLAN_STA_SMD set).
+	 */
+	if (test_sta_flag(sta, WLAN_STA_SMD)) {
+		ret = sta_apply_smd_state_flags(sta, mask, set);
+		if (ret)
+			return ret;
+	}
+
 	/* mark TDLS channel switch support, if the AP allows it */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
 	    !sdata->deflink.u.mgd.tdls_chan_switch_prohibited &&
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index d7e7c9c578e4..24c985687bd2 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -79,6 +79,9 @@ static const char * const sta_flag_names[] = {
 	FLAG(USES_ENCRYPTION),
 	FLAG(DECAP_OFFLOAD),
 	FLAG(SMD),
+	FLAG(SMD_PREP_TARGET),
+	FLAG(SMD_EXEC_CURRENT),
+	FLAG(SMD_DL_DRAIN),
 #undef FLAG
 };
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 506aeb241a6d..89137b18a862 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -73,6 +73,11 @@
  *	so drop all packets without a key later.
  * @WLAN_STA_DECAP_OFFLOAD: This station uses rx decap offload
  * @WLAN_STA_SMD: this station is associated to an SMD-ME.
+ * @WLAN_STA_SMD_PREP_TARGET: this SMD station is prepared at the target AP MLD.
+ * @WLAN_STA_SMD_EXEC_CURRENT: this SMD station has started execution at
+ *	the current AP MLD.
+ * @WLAN_STA_SMD_DL_DRAIN: this SMD station has started draining at
+ *	the current AP MLD.
  *
  * @NUM_WLAN_STA_FLAGS: number of defined flags
  */
@@ -106,6 +111,9 @@ enum ieee80211_sta_info_flags {
 	WLAN_STA_USES_ENCRYPTION,
 	WLAN_STA_DECAP_OFFLOAD,
 	WLAN_STA_SMD,
+	WLAN_STA_SMD_PREP_TARGET,
+	WLAN_STA_SMD_EXEC_CURRENT,
+	WLAN_STA_SMD_DL_DRAIN,
 
 	NUM_WLAN_STA_FLAGS,
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7577eb31ff65..282d3c82dce8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7707,6 +7707,9 @@ static const struct nla_policy sta_flags_policy[NL80211_STA_FLAG_MAX + 1] = {
 	[NL80211_STA_FLAG_AUTHENTICATED] = { .type = NLA_FLAG },
 	[NL80211_STA_FLAG_TDLS_PEER] = { .type = NLA_FLAG },
 	[NL80211_STA_FLAG_SMD] = { .type = NLA_FLAG },
+	[NL80211_STA_FLAG_SMD_PREP_TARGET] = { .type = NLA_FLAG },
+	[NL80211_STA_FLAG_SMD_EXEC_CURRENT] = { .type = NLA_FLAG },
+	[NL80211_STA_FLAG_SMD_DL_DRAIN] = { .type = NLA_FLAG },
 };
 
 static int parse_station_flags(struct genl_info *info,
@@ -7773,7 +7776,11 @@ static int parse_station_flags(struct genl_info *info,
 	switch (iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
-		params->sta_flags_mask = BIT(NL80211_STA_FLAG_SMD);
+		params->sta_flags_mask =
+			BIT(NL80211_STA_FLAG_SMD) |
+			BIT(NL80211_STA_FLAG_SMD_PREP_TARGET) |
+			BIT(NL80211_STA_FLAG_SMD_EXEC_CURRENT) |
+			BIT(NL80211_STA_FLAG_SMD_DL_DRAIN);
 		fallthrough;
 	case NL80211_IFTYPE_P2P_GO:
 		params->sta_flags_mask |= BIT(NL80211_STA_FLAG_AUTHORIZED) |
@@ -8920,7 +8927,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 9);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 12);
 
 	switch (statype) {
 	case CFG80211_STA_MESH_PEER_KERNEL:
@@ -9015,7 +9022,10 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 				  BIT(NL80211_STA_FLAG_WME) |
 				  BIT(NL80211_STA_FLAG_MFP) |
 				  BIT(NL80211_STA_FLAG_SPP_AMSDU) |
-				  BIT(NL80211_STA_FLAG_SMD)))
+				  BIT(NL80211_STA_FLAG_SMD) |
+				  BIT(NL80211_STA_FLAG_SMD_PREP_TARGET) |
+				  BIT(NL80211_STA_FLAG_SMD_EXEC_CURRENT) |
+				  BIT(NL80211_STA_FLAG_SMD_DL_DRAIN)))
 			return -EINVAL;
 
 		/* but authenticated/associated only if driver handles it */
@@ -9702,7 +9712,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 9);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 12);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:

-- 
2.34.1

