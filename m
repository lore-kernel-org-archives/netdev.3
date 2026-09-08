Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B856592203
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887413; cv=none; b=KGVuDJ4ClWfTWRu6CcTC/IxnUwKgrBpbVcQ8/Xeya7CxRlreECVkTPQjb1WQ1cFpDuKYeO2XoqsF6DxudKKESxZ3o2rBiCiCiT/sBI05iEQYx/3mnmVr0zUSdnTL8KXpg2xmHhCuaJWNj6tz9CORGJ4QySqHpRVqPCmA7PJDhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887413; c=relaxed/simple;
	bh=ODuW2nybW3REfD8SbUhi8QOhAYOU2HQqcQkaxRn64Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxyvyuRDFi+Z9z8jPXT+OGa090ulvStvmcYBbDkzbcXqonRC+ZQxooe3E/ANLzKDJeD3zKzDTgEatK2cSd/qLLlL6BcjcMgYDm7VBWWUBOpeOkTDBbl2R+Eb/60KjiiYVaCIHLLc4d76ZadKJOkk5n0QpahlpJt1/jurf7E4Jn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fmeleVvc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K/XnQMc9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fmeleVvc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/XnQMc9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdYtT3612188
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s4tTeUVXrP8PDX4fDGv3MD0jVy8bbBgnnC6+ayxYRRA=; b=fmeleVvcLmVg/F+L
	67ClZFMqSQOuWGLlkj0g/0Y2g6VTbZltqahkldxXSwRv7UPzf3qAsrroIYSmUONx
	sOYg5wntLKNSdlv0q3Kuf/f28AtfIY0m7OVMQ3QtsLJmSA2VovpoapJYcwFVHnFz
	EKiIWJeJLd/GDO5HJztDlN8YQQWNPssd8dPqIsz4YD0CJsU/6BK1+PdFWz28TePE
	meubVXNpG6YR7KKTgUjLrKXt37UPuUyryudKKk4HbLK1sCaM2o57AreZDtckJSe9
	Qw6TnzRoAAY4AjlpUa2jYo5KJS4EAFeft3NxvEjGcI0jamiW2DMYR0auwVPlk99m
	TdeJ3w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjagukdtc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc132709c76so6600062a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887409; x=1789492209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s4tTeUVXrP8PDX4fDGv3MD0jVy8bbBgnnC6+ayxYRRA=;
        b=K/XnQMc9rgRl7joP93ljiR2BWjB0GkD6ai+rkz3wBOGwONnx0OQAG27VYwNZ+18oMw
         x97MSTqn5mQvPLgsANJknRfEGk/1ov7Oek8Vx7PcSgVX3kH6bYJFiNBz4BshflIBZHvJ
         Teeq6/ClyB8Fj+TPMSqYyV8uZQgTMbBbbSuMV4Rtrkynpu16CddSDKeWQWWG9fSYnPem
         9OaInGJ3ohLJIQVsdNJReL90K+NJCgtUQXOiJxQRf1FChaaS5E5lMSohq1WTwzsrrk3b
         ZtoPZZxjaGao6cPAwAt8qYjtZEKJ3IDtqhCvKX1QfnAczyq6BLe5YZY6M+zLxNwylbNY
         uz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887409; x=1789492209;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4tTeUVXrP8PDX4fDGv3MD0jVy8bbBgnnC6+ayxYRRA=;
        b=kq0KM/AB7p8wjt2YO0GYEYU1YoLXkEVyF1NM3vxkGAvUGnbUbO/BYRcn1Crokr/V7u
         8qyAS3CtgJfkSPEqwaqIZKYV1f4e+CDrXwu84cAQc0y3YQhRPVWdNgG/lJdSyRJa99Jc
         oh0ntlTbKiYdc5/wArRf8k9Fy/RYo0zxwtTtd2EuYYe8sP1dOjSdj4hEyMzLFQDupfJm
         F1NDS7/KjClD5S8EdM44dwINxN1tHxnyjyCBH8HFbSYz7u2esu0fJZQsjYOhM4IdhDHf
         yRG4AHoAW/uqdw4PvoV45Krwz8VQG/Ej8PMMr0ss2ZIYG75icdx2BjEHjkvmqA/qT6c6
         jKPg==
X-Forwarded-Encrypted: i=1; AKwUvBz3hDDDlg+B0dgeJ5uCexow5c5FiGD6DMKmkKY4hNwGKZVTpleTKIidc0MkQRiBfZ1UqBGuZGk=@vger.kernel.org
X-Gm-Message-State: AFuF++lnLLLI7D0Z1J/qZn8T8VwGzFSWgSlxWsFOo2URuiyEzaCmpQ44
	bGF1gPqe509gVeIJfW6MRpbLtsZoj2H/4Zgz9+Jwc5dOoQtEU7RXSc6asItj5fjrtxO30nB5Jge
	wGX8IT5hXGOeZE0cE4GCYCU+BdROsCP8KxhqxOc50QfSRDGe6UE3KHNNG0g==
X-Gm-Gg: AYBFou2Ptsmpca0Vv9YcktQDoOs75em1oT0MfTlZpRrLHe3hcdrvEXz+z0/f5Op/0Aw
	d/9KRqHXM3IvHPV3n7VyA5AyZ4wsnXZDsCq6EOeH1eu8DWQcVA+6pmf+K9sCjX6zuaC8GN9sfCZ
	3D+0WdweJ+Esrd2yUYlY7u71azQjGUV9t0HfBRxkV0JQzGIHkQ5ip5tKO6Oj8qBYsP/Rzz5YY5l
	JnyqAWt+Z49c0jdG6iRSeoSMqt+aFFa8We4sRjlW6/JHrcYxG1dHJLb0FOE3fBHNYooxEuVzOJU
	tR9FIO29dW6C6Efdu9uosfWLAQT8npMnO++vCMY+XdVxoCMop/Kj8qAbMNzzY5E4KeEOcZlKxkJ
	CAlQuadYuukTCV9uL4ykllNJPF7t4XrmcSbuX6LO9a7mfqsN2Jp9Q/OvAlyJxMG+ibXDkWmVRHt
	aVFI0sxlgyAhUkGE5bhBGYKQ==
X-Received: by 2002:a05:6a21:2983:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3da3a03ccf1mr51867750637.17.1788887408423;
        Tue, 08 Sep 2026 10:10:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:2983:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3da3a03ccf1mr51867662637.17.1788887407858;
        Tue, 08 Sep 2026 10:10:07 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:07 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 02/18] wifi: nl80211: Define Seamless Mobility Domain (SMD) device capability
Date: Tue,  8 Sep 2026 22:39:30 +0530
Message-Id: <20260908-smd-v1-2-9fd2d876a1fb@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6aa04171 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-9rhnhb8Ej--qkh-m00A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: tl3108sUdcfZuuCwVYTIQ4aTDtJ5qArS
X-Proofpoint-ORIG-GUID: tl3108sUdcfZuuCwVYTIQ4aTDtJ5qArS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXxWnIXb7ZDBJq
 9fHZ+iz7lSWLl+DQ86hfKET74scTfKqfUxiB2TZTs8+UT/gLhCpnJFWL8KhRh9xjafJAMPEIDR3
 2mIfNfX7XVeFaMZjzb3GuXbrDCYAWJk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXxIMoSiFF/YnQ
 Fic5vYDcKwQyciNn1z0W6h2+sIIH510xUuW46LcupTYCNtv8O0x9lferiHQZ/B4ZLIMEbZcW7gC
 o7f0Ygo7bJ+GJ+5gnkBQgshXjVg5/rhCilGicPpW4etg75TNLRX+GlHVkNPYqtoa0Kh+qZtobX/
 UtkQqGjfJsT4HHZBIOkneHxf/wwhuu3rbVKkY876RyyzzKF4G0YxqHrBAJL7NTEDLnzbdY+zKMv
 LppknRcG56Em8tH+2NyfuQcjppoIFEoLRsHSvaqdBhAMnn88Ah9z01A1u5sx3ULxGm9pfHQyEmh
 O2UgpHwUA6yu9lmGv69NJ79mlWAU/dl0Ap9hXpr2GSx/lW1aok6W7NZXNIhAZJQMUuaKVodkQYB
 gktpjXJckbshKEss3RJNU43BHhcKVyeTYoV4EZ6Kh3t1DJXjm1QcJQul/BHpqmJvc4jkPJocmAk
 q+5wNwhCiwRigBpvMhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080185

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

