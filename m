Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D583A16BC
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813238; cv=none; b=nFBwDW3cjV0QHeW/wDaKo1OvRMphG5puUZ7pycX01pb0svTEUp3vn3O70RqFYiSSr0ob4YuFTzFmzAwaAZpFAK2incPwVokDidYkh77ddTeG/CUYizN+kHTNvf0I4Lq6x+KGThGsqwjvFdhC/Nxk3TwZfL7it/SZliV6i5XLDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813238; c=relaxed/simple;
	bh=slxYMd9pIzQAMKVqHjrMfdvbnPLm31GqOFhQsu0FO7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TF3WNZA2ZprCCS6coffyF/kii3yqv1gY1BRt7CRpI4uxvTLsryDicAG7ovidg1wNHiDUl8tPtA2V77v5LpOKZx5AUyUcXiYGru57bLrFlpqcpW3fflJ8gtNvkVsaGWTBr6xZm0mU4uVSYDvcirvUbehkifw/mVeZJj3GNOEKxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CBxFsh19; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AU0b1aXX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBxFsh19";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AU0b1aXX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687HWMLQ565403
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gYoBNxGLCxDZv4uAHMCNobIrbYmFXndZnMWIP9T37jE=; b=CBxFsh19AT4k+2gG
	A2A4/GcF7oPQGVdC7W3lsh/9k2PO2iwHkZUnds4FiZOnWGQ7gLqs3JwqAE5fJHWX
	BtxM3c6awmRbVNrnUXu8ieXFRQqncQDZ9aPL1DqJByNl0ve+c2Tvmn6A4Bz0vrXk
	CYPpsfQpDAN7LbCqLTUL6U7l+a28lZouMrXvTfrHo3pOnwp/YajuI2EjtjgYRgU5
	dQ3p1ACMP0sRam1P0yOrgY7pEuVRDPyPgWlWvD2CMbrdsZZVljVMsxB8h7dpv5vt
	MXV83PTCsxtulGTTCDi9T0vQZPFz9/2P1jEscPe4NVyuOBI2xH/gc/MdGJYm6kNi
	HaXkQQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rrgfvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:33:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088202so3434115a12.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788813236; x=1789418036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gYoBNxGLCxDZv4uAHMCNobIrbYmFXndZnMWIP9T37jE=;
        b=AU0b1aXXKf+e/V8FXF9/Ci2j7SCEmlBKdYtvsTWsgr3NrgATgHcJ+g/xDd7giMWILc
         M11gzawDUaIAu424MXQQLQzCsho5SBEtyMPvxboOxRxoQk3kJQRUxlRzXIB6qvW3V+em
         YbHW+bayY9Gh56/GXzkun+qThMBRfXERMg8xWoAnopLJX2XsVATaOEMNfhigycN1JGYc
         s/g5r+sAZyeRYkFU1jDNqlVFO5rq3T3IbgiLqWMrVqIm63POqlxjnf8+ds1RJogZRPTB
         /d7W8Mm7+mx5QuvySLIFT9UXqGecNBCY3p4awXSF46fGt50hLfEF//niwC551z/bfRgN
         pCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813236; x=1789418036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYoBNxGLCxDZv4uAHMCNobIrbYmFXndZnMWIP9T37jE=;
        b=O0gjBmS7FGyKE4BY44EpATSU8axWFhO7uRAaOryvHMvJWDZn18sDUW0+fS+DtfnrRs
         T56ad3avXuBgRLdt+9WNih145DM8CqeY3tjSRezwC74Po+6ov8k7D3Ru13LFvz8yEmQ9
         IpN7aS/Tc3/k8YhGLF2J1LAE7t+SnclhdkD0B4P+soRBac9YcHtdXzv7BJirW8Pe27gd
         UILxBoYtEMD9eAGxRWmypH7sNKo4koAbdauCRG77cLjR29tvpFlt24yYBaDiXbHp0BF8
         Sj3wSInxwjK/r0fpRsqEyVMdJaEZOoSGtdk7L7H3YNwrDxVSHxQV/mFi6JsQizHFqVR+
         rv7w==
X-Forwarded-Encrypted: i=1; AKwUvBznp9vrILmBw3Jf6DApdupkQRsc6Sxwy6Py77Q1v/JDduMEbNg1wCt26GnPGjLtilYDcRL1wnk=@vger.kernel.org
X-Gm-Message-State: AFuF++k5SpVc1kY5mjQ2FUIoVzbAxc94+OaE8F/+ElZL4VuyxExBniVb
	hFEKXsSyVULXQ1zcAGomCaLdymzOAlUcNWAu3+xdRDtiXgcRtWQmB4cT78UJXdKxV6Au3+pqWq8
	3EvUSvyut/gX0xkSo4OLtDm55d3+Rixxy5AcmZOO6/3fJbOj6WFvpS17pLQ==
X-Gm-Gg: AYBFou0Wc2E+xg4Lzzxp8+ZM7Ufs7Fyo5igOptYhOsvFBygbRqPYchiQO5cZAtLuxLL
	AdxKaPo4sMPLx0r98ETztTv+PPbgXyziJeLVCcw6Ivlp7TdlAOm+exNTPyyUsLWzrQlsHkFSyxR
	sfb1MSSJ14Qu6GBi5g2rpweNvGFLuYwAg0pYLEAKr9DsSLULzBg84qrKihHKkdbw0bpAAmiyAmT
	rFL19n1CFHQaEZBE5m+JEYRyC4dG0GKqMGXBVf+eixP/y21VgaUD/Imbt1cN0NqiB2lYCgExSOg
	DiL0p7WmaZbFfWmn6oo8aESnUMwE9tafFi+eL2PFEMkLdykCwWc/Y62/DaEw695OYo/TsUQEyz7
	mrL6wdQXSfSgBUkHLVI+ZfY2yFxaB2TP9fWBJmi7uIVXvtP09bZ3mK8DlPLXmK0KvBT72Qg3hPG
	t0EdVRx+BC+C0BO4uJrbWSgw==
X-Received: by 2002:a05:6a20:4321:b0:3d3:b02a:61a5 with SMTP id adf61e73a8af0-3da3a217599mr37266732637.28.1788813235703;
        Mon, 07 Sep 2026 13:33:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:4321:b0:3d3:b02a:61a5 with SMTP id adf61e73a8af0-3da3a217599mr37266691637.28.1788813235300;
        Mon, 07 Sep 2026 13:33:55 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm47841297eec.16.2026.09.07.13.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:33:54 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:59:20 +0530
Subject: [PATCH wireless-next 11/18] wifi: mac80211: Enable skb extensions
 along with mac80211
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-smd-v1-11-65ad4ab30fbd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfXyhosJXVmoQk7
 39kMjAgSt43Mpq449pyPW7LegdoGq5OSMrjbdQjPljl3Yc8x4HT+oR6E/h/62ZZjC6Bl95UP+kG
 LA/YD7lQ34EwQ8WrNJnqhM1+QqJjib0=
X-Proofpoint-GUID: pfWzriJsPm3qbBVAy-zcfdFXooNK6GJ4
X-Authority-Analysis: v=2.4 cv=NsjhtcdJ c=1 sm=1 tr=0 ts=6a9f1fb4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iJey_kD_w1PlP-9owF4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX63eAUb5mDxm3
 CZ4HE6BY4IB5V2fsZV/Kct/nFgZbDH6OJSoCeaKjPCOCoElXDzd4qqDjUk8drBsXCbL+1BYFoB1
 bm32Hy4jQdX+I8Gj8ssHy5yNlhH2jGtF9gSN3ve8/ZtWt+vQglpHQpRGUGOBeTH1FKe/8+AjXIW
 uMA0CN8ZGaywLuQVqCWrKjZ5kfXGtBp/UuS7DSIzST1MfcnggnAAivem92KDW+LsJelau7b19XB
 VTUBAO3AbtEzc9QV7QfNjd0+eOnYrLeuHGgnnWbWAF36m7jLSq1uxo3jxYakiiE7ef4i5RFNvEL
 E0d60MZcySA2L+Ho+EfDW8aIMI331K3VFxVmd76eUiCDVnkFJ17sXaqeE2iZn/VUl1PpZL9v+Cg
 np2m4dt7bV9phKikI8lHbhH0PthvS3niUtRhPnwoT1vswJwUcsL/rItP/kTwjtesWMoQRMvoBEC
 z2mTSIit6qiXpDbrUkw==
X-Proofpoint-ORIG-GUID: pfWzriJsPm3qbBVAy-zcfdFXooNK6GJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070226

When mac80211 module is selected in build configs, enable SKB_EXTENSIONS
as a dependency since mac80211 has started using SKB extensions with SMD
as its first user.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 net/mac80211/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index d6bc295e23a1..10d28985a1ce 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -9,6 +9,7 @@ config MAC80211
 	select CRYPTO_CCM
 	select CRYPTO_GCM
 	select CRC32
+	select SKB_EXTENSIONS
 	help
 	  This option enables the hardware independent IEEE 802.11
 	  networking stack.

-- 
2.34.1

