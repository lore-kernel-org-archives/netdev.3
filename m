Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463B3F1073
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813205; cv=none; b=I8iAb0sFn/WV8zbdp5Y3mYrOFN+GBbnUd+Am7iktsrmARF1YsMmSlqDswegGGPj9RGisOAieM+ZOryWug5Jc/vGAf/AwxYCTDj97jYZE8DgpGqtg9VrroVRnSPn7XXGvQwGdhi9z+BzGf5P6taMDxmpM0Tufxv6gPMLZwXPqJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813205; c=relaxed/simple;
	bh=ODuW2nybW3REfD8SbUhi8QOhAYOU2HQqcQkaxRn64Q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVYvzI23NYPTLooeXVRCOGOlVRMv5geMrZp7+kKoaOu19Ocv+jc5nVWRHe10kTZBrpzBHHIm2phR+BIHvIqks5jATCWvnsbAdKF22uigPV8f8iNITU8b9YMTxP2n3cF5X0KpS4stEdgJSfFeQwCp8/4ejGmSPT1CVH4qfTZUJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c3xL5C26; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TtDh4qGL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c3xL5C26";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TtDh4qGL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687HXCbA552509
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s4tTeUVXrP8PDX4fDGv3MD0jVy8bbBgnnC6+ayxYRRA=; b=c3xL5C26/U1riqgx
	Uvn6EZppMDW6QU/3BUBxWZ8A62BeydPjaDc7d/II7QOqgJMpdk/Dy4VpjlEywTNh
	ohChqOUHGhvQ/uXIBkq3DUrBoAwT/++jyqsGhMEvRW8VWLty7WxZa8TsFGol4rXx
	GjG11RuC4DCIGVg6IO70ucPhzNGuRMi4b0D2HZPN9tf87OPlZXgAPtwBrXuCPv6E
	jI78W2EIEOUzSE2gZEt9jLDig/x8lZceO2WtNW1nRS3gaYuSDn0m0MBluse7gu1u
	qBh+tXpYPiVA9DHmUIbKKs/Jl+vtEu249+s8ygmLzieVMgQcT5LSqvbvcfExx5tN
	KRHdTA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwgff2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:33:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39512608fb1so8421809a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788813200; x=1789418000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4tTeUVXrP8PDX4fDGv3MD0jVy8bbBgnnC6+ayxYRRA=;
        b=TtDh4qGLadDdbGwJVzglotsoD41NBjNwsqOqQTaUbqn0rxwWXxDaoFsV/sdu1ikark
         ika6YcuE6UI9Wm7jlWZGrx2eqfz/6MrLa6jwPK7S0rMDTb6SRJ1xnsp/x05TZEb4U65N
         TDmx3/yhDoTMjhJHNE6Dgo7g0yDg9e/KTNGnjzX3bE4K/AYZABeTUbKiWytpE9LDiGXj
         qy0J4/qWnGtsF3Rv5V0a6PwG2BAnlbgPDwVhFzToD6z4ZIH0Sx7VLFiWegcfxrEzJo9r
         3BOSuWOmKOA6YxdtSnF9sehjTEIgu4i57ncaPGp0l/fqeVmymvqshP3QlC3lAaBVeu99
         74qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813200; x=1789418000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4tTeUVXrP8PDX4fDGv3MD0jVy8bbBgnnC6+ayxYRRA=;
        b=QReSItQeM4C+2jwXUZIg56xOexXCQ5BCssYcyxMfEbPCi/r8pbBGivLc1+hAjS3qs3
         TXtttuNRzJaP9WEXYLFsl8XjtkZX3UNMcgakW7IzpFFh86v9YA++v0bZ21oKM5zfQTqd
         UINCgg1jlhTbSqKaOa5CESGt9UAGeS9TyNx2C8dritE5AJn3y6u+Y0kA4y0iPCQqR+sp
         gsLX5U/WNbxRhy1T0XCb/tRzCIQ4HqsE76/V+1njZJj9aV67WF+wB0f3FrSpOZg0BA4k
         6alagNVQokA2eDodTZCtmMs4dbiMpZSEvV4ahcphwOFy4Hrp91GFtbye0znPCCGTn2Gq
         WJ1w==
X-Forwarded-Encrypted: i=1; AKwUvBxf/uJVg4Tr7MA4Raf2CDs+WC9wRWfA9GLO44odvz2rDMamBer3PEQQJMg5yUWCVS3c0vvhYDo=@vger.kernel.org
X-Gm-Message-State: AFuF++nCGF+xQVOhXQSzJBVz7Wj/FU7EoEHFLntHXRpwaBv2F8p2eJc5
	6SbGEvswhIZDO7d0+lZkMemNjUdf77gBjSuOjBHRwOkuGbdebYOoOk8fXx7QPMdWsP8gYTGJhPK
	jnPrBERnFR31Wx+GtvAiazHawJIo0K6yOOGxtNivqy1TCbNxosTij+Doeug==
X-Gm-Gg: AYBFou2Qpcy9C094izaxWYYM7ZZD6RQvJ1OMfOm0txMsAeXBYLt0bR0YbzqEQfpR3uv
	HluJJwPI3tE9IQ6d1di4Hn0wxrODAAFghi669I+MfDMvLaNnzdRpigslTbXag9qgERewLcH7P0N
	yJ/6iPV1PVGpnLJ2iD2lJRee5gJ2yKGicm7aqPNDm5IZ3+KdSzpCPWDzf0VxUS4kHJ1X1tyeQxR
	/0822HfkZS9PbLBEe+hox4f6406PS5lHDgZIk/w/5JiWJ8k494+fcY0r1c54Fa3c4EdtVQ58agD
	fA4lIx9y/MCIAakW3RxOpv46i45qSEIUvoATq6oUC46GmLNnhfoi/JOByYUHZ0LUvoXVN050vpI
	Quk5fvyjDpkPAhUHKwfLz0Fp8LrbWcF99fydfOAVdru4UpZeb7EOc3oaqhJfuAgsmEVDuOJOqDh
	uTGflQ6LaL4wQQP+1yRCDY3Q==
X-Received: by 2002:a17:90b:2f46:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-39b260de5c6mr40578525a91.2.1788813199910;
        Mon, 07 Sep 2026 13:33:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2f46:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-39b260de5c6mr40578476a91.2.1788813199447;
        Mon, 07 Sep 2026 13:33:19 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm47841297eec.16.2026.09.07.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:33:19 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:59:11 +0530
Subject: [PATCH wireless-next 02/18] wifi: nl80211: Define Seamless
 Mobility Domain (SMD) device capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-smd-v1-2-65ad4ab30fbd@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9f1f92 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-9rhnhb8Ej--qkh-m00A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX9ekCk+lJf0Dn
 73XcJqSJZ/x3CSFnn2wKc1zx8c2xhDbWS/A3ZRmvgBgC1HebADstvhAmPt0DiA4pMg+vAL197w4
 vz5+wNOi8sxYAAQei3GrW9oyfIlMvY/5xh4BBpo9jRvW91gF/qKSgplujjr6mCpEPen8PPgxowX
 mCsk1Utth0V9LJ1dAJFPXW7oGuYqfw9GMiaDQ8Ck+KCjH5mE9kJYBDD9x4FtYzaGLjT1pZXZVyI
 YKUwNojhAU5j/C2QZXTW4F2WRva3vX/BrUgNREwrjAcstzNYLgGT1mXIguI7dS6Gf9b6l+PB/eB
 IWn1TJmK8hOPwMjJV6v6tNT9uBaGVEjBAmMjPZm1ijZ/I2A3jnLqj3P4SL4iigd0Uk5B65RYu/F
 UjWLTDz1h0jX/3lvUWX7p0jFR77ivqOqvoL3LWG9Myr4isdAJJQLk1xrsNqFR2PQj8Yno9IM002
 IUfLBre9WTlEcuTkRQw==
X-Proofpoint-ORIG-GUID: eU1q_1zddsk47jO0oGGnfu4SPyC2tgY8
X-Proofpoint-GUID: eU1q_1zddsk47jO0oGGnfu4SPyC2tgY8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX7aT6gLk0LLEL
 RpjgsLI992ozn/YVemPyCEqaLg5fOp+oXhngQl9hP8NsKAhUcBp37v/+GA9zzvpBBx3Q1YzR5Cb
 KPYit2e9pTT/xzoEAZOMKPDBQcYvf+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070226

From: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>

Per IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16, an AP MLD can be
managed by a Seamless Mobility Domain Management Entity (SMD-ME) along
with partner AP MLDs to enable seamless transition of an associated
non-AP MLD from the current AP MLD to a target AP MLD. A non-AP MLD
advertising SMD supports association to an SMD-ME and SMD BSS
Transition between AP MLDs within an SMD.

Subclause 37.16.11 defines an optional capability for the current AP
MLD to forward buffered downlink (DL) data frames for the non-AP MLD to
the target AP MLD.

Userspace needs a way to be aware of the driver's SMD capabilities so that
it can enable SMD configuration and operation only on capable devices.

Define two extended feature flags
 - NL80211_EXT_FEATURE_SMD for SMD management and BSS Transition
   capability
 - NL80211_EXT_FEATURE_SMD_DL_PKT_FORWARDING for DL data forwarding
   capability

so that userspace can gate SMD setup and data forwarding configuration
on driver support.

Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d8fefefc11a9..d9ce185b0ef1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7114,6 +7114,15 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_PROBE_AP: Driver supports probing the associated AP
  *	in STA mode using @NL80211_CMD_PROBE_PEER.
  *
+ * @NL80211_EXT_FEATURE_SMD: Driver supports Seamless Mobility Domain (SMD)
+ *	and is managed by an SMD-ME to support SMD BSS Transition in AP mode
+ *	and supports association to an SMD-ME and SMD BSS transition in
+ *	non-AP STA mode.
+ *
+ * @NL80211_EXT_FEATURE_SMD_DL_PKT_FORWARDING: Driver supports forwarding of
+ *	buffered downlink (DL) data packets in AP mode to the non-AP STA during
+ *	SMD BSS Transition.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -7196,6 +7205,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
 	NL80211_EXT_FEATURE_SET_KEY_LTF_SEED,
 	NL80211_EXT_FEATURE_PROBE_AP,
+	NL80211_EXT_FEATURE_SMD,
+	NL80211_EXT_FEATURE_SMD_DL_PKT_FORWARDING,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,

-- 
2.34.1

