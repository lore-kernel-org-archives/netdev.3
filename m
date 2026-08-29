Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC43264C7
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787992163; cv=none; b=reKSwUcQYBHWdthaGhTAqnWo31ciWD8vxVxgD1QjHccJl6GAscV1K/nYbsokqMMgHIcFGHU7ueVkMN8lqkAhyxlVc7/16vb4Ycx+9yyRE14QGgi3ud6zxwJS9HM0kVVzMnI3V0lN6gFG6i47CHziTtSKT1AhvCIqd9jgbxKkhKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787992163; c=relaxed/simple;
	bh=fCnEKfTVRniiOfxxYKad8TupXuFCxkMEyP0UlXn6M/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ux+cVmRnYkjQmXnjVeFl7sZXBGmalIV8aCKeNNIdCq5OlV0Xo3rJ1up4v+k9ybFp3cuioJgyCG5p0RGtbcl1SiPMLyE9W1EfcpCsxIfjjikRmZPJGueNAXdnlc4TeOi+onmFlqZrirjHFKVQ5keqPH4Q0/oLEoxuy3+gCDRaMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l6B/P2VV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DjgxzQdt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l6B/P2VV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DjgxzQdt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T802ax1353069
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BdfDsmhndmGDUsGcNyFXNm
	18FkaVS/nttiWoZOC0wt8=; b=l6B/P2VVuKZDlj4RHslFK4PzRy7HiznGq7me+/
	nZB3HLGWacUCWlRiNq3p+xrosx7O0h1y140hSbwngEP8TM/n/bm5Qb0FBaTqCZGY
	9aaQGjqL+7DTvEr5Dcg4C4fOWLrypDZjXXRr6r8fk2DMXt0DULwjyBl+FAn9fsdV
	2hz1YmoAaMrTCy0PrHk/dszj3h2N6aMZNdKf/cD00cRooJRc7R9QTdFKf6HmbdaM
	nhWzWJzD/EMcNuVj0HnOt3wBGEIT0vPXQWHekzPkX0A2ocOU/eVu+HvDiyD6uh3M
	pdC82Z1uHqtnYZCUYA8YymnT9cDDG6uIPeF9YHFT975e0E0A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhw8h2d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ffe24490bso2995241cf.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787992161; x=1788596961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BdfDsmhndmGDUsGcNyFXNm18FkaVS/nttiWoZOC0wt8=;
        b=DjgxzQdtGkA69OsrzLSjsxqurhqzXmnrnlL3fRvGxK1TUNncyWD0bxHB++yDnvvcnQ
         DWPgDTDzEk+NlmHrunEFIYvo2X+XhUXHltVaN+n3M75KdHLemE9l2I2iXD0f72n3hurI
         kJC05Hs4/hcPmi+Of4aXofBqU9omFjxNslHp7AdpKYTWZ0sIH6P7XaNgmuGoB4fEQWi4
         E+bm1f/uSSTDZL2KFjH/AOShuG7Pzrz0udR0pNs/8VvjJUwLau/v1iuopeOXx0BLv3qv
         dhh6MFk8R0L6MzaCxkwmSyyxzWUl5l7n4Yu7DuE5JDa9nrqqP2tUMjkXKBqhxBvSupPD
         tPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787992161; x=1788596961;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BdfDsmhndmGDUsGcNyFXNm18FkaVS/nttiWoZOC0wt8=;
        b=HaW3QHtXLoO4OMFSvSBzmD7WRMW3TwiG47mfgFlFwe52uevMuDmz/6jLjqcIzcPDGc
         +Q7Aq9FidV1e/9tVrVcjg6HBCJXEYxmB2AvTaHVyGMjTrvTrYuqteKnKHa8C3c8O6/9K
         /3TXQ2lRJmMj+IUFVGsI0VBWZY7s3wG/Uc4jdsq75DX+aIhlM5cM8LwwwyYwMtmALQOf
         nq8IL34Qdvt/HPZfdu9U4UjTydbd+zvYBLqgKs+Md5I3n1Q9t9n0gf1KO27rPAD3Dpat
         R7z5BJ/mI25U/uLoa7YOw2GZj2Lj99thuJy2QkGl6WHtxx04RuvLSw012t6oNz1htU75
         Ajtg==
X-Gm-Message-State: AFuF++k6Df6X9lFQL2m4/05u5xkhtgX1lzWa50FLcIWUNc61//Tt42Xx
	1i124ZC+DGZETcrnR9yc81e2Vt8qP0riwm5EeX6Sua7WYlTUCY0IdlBBbCM9k2osSsb0u7XCX5I
	MYGmQ7HegOG/G4LJOUf68NNQcJlKD8JYG0PpqmSM6WNL/VvscmKIs9/vDeCI=
X-Gm-Gg: AR+sD13ICPmY4TBSotSGzl7tSe5ydHHKIcFnx6llfyRxDtooTQblIX2buIL/PbdcHYN
	oK9NoeP2weX3yk6nKTQHmaQiHkDIulP5ScF7KKutaPg0QyTB3iIAtBh1d8VpsilxNrhsXG7HYb1
	028Wg2ju/XtgnVA7HR2PDazXoQfDI+NSHWzdJfCKpVPSBgLJFtC37DGqb45pFRVQp62sotDwEcy
	GtQbepDmz/IwxfXvIifb0Rj6UPFkp0FHi232JJUzet4rXt6aAUasgeZpB+dw04BAIfV/NHouDxP
	zMCzwi/KUULEI/Igi1Rt1afYBV1Kl4z19G+wQRlbWXrnaHmweO8gv4BFSFJTGGp0Y26YHf4zt5L
	vZyD9TtsFghrlgA==
X-Received: by 2002:a05:622a:1308:b0:52d:844c:b0c2 with SMTP id d75a77b69052e-52fb9429883mr141020511cf.12.1787992160585;
        Sat, 29 Aug 2026 01:29:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1308:b0:52d:844c:b0c2 with SMTP id d75a77b69052e-52fb9429883mr141020171cf.12.1787992160140;
        Sat, 29 Aug 2026 01:29:20 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cc9497b3esm72533635e9.5.2026.08.29.01.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:29:18 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net 0/2] net: stmmac: fix qdisc configuration overwrite
 during qdisc_graft().
Date: Sat, 29 Aug 2026 10:28:48 +0200
Message-Id: <20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDsQR6jVq0gXIfm1szDKJNiCe
 HdDlx883kkZpsg0NicZDs26pYr20VD4+LSANVaTOHm6l/Scy7r6wLP+eDE/F94O2Ne0gGOHIOg
 lDq6lOtgNNfvPJ0oo9L6uG1FlpjxxAAAA
X-Change-ID: 20260827-stmmac-fix-graft-overwrite-d3ec2e72d901
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: oM9NB4fF1qLDbLlEifpyvkjmHJ-SfogC
X-Proofpoint-ORIG-GUID: oM9NB4fF1qLDbLlEifpyvkjmHJ-SfogC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA3MiBTYWx0ZWRfX/nBrPSj2UI0U
 oo20jpw8w2q2cbtCLeRbenDyUduwS+hfG0nscXYAqGQxmx0/yOMb+4qkHApQJT4AgI3tdGAoIbX
 SOcigbO7q/PYwFYkJrTKnnluoumCoro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA3MiBTYWx0ZWRfXwdT6pwhy+AEa
 M2+z4/ZfhgIP/WqCguftSaA0PH/Eq5h7wbgyOrlnOOsqnQDwMK7cqFiDpSSDk2Qvz9dNHwmNypy
 ere/02WZY9uMuS3R9yKDcOZsZKL32P9qb42fXnDBr5HLQ4mW7pwqy6skXj4/wzQgrGWEulKcL1e
 5oGeBL5ZqP2FM02ae6eDRXQfMmTqFoO02LfkUvGey1O+x7ZZ0Ll4LbRwoVPYKd4lAmKhkkYmk9h
 dnBof4Itcf/MX76zY8atrc7z85OeREVSsont2CcBFOEe7GdqLEyR0q1DEOLiI1XP6Z/zJDGJTl5
 V8LmWl/94J8PvBTPNf2clejBXqIlJIbWMC82wLWjr8UDldFi5Wwo49j4pLFP7mOzTZXkAQ4uwj0
 KX8IPy8SZS+ppUbbkPTSTqocBBJcPqzpVEr4TMflFuB2bLMTfBxj4nKAjgaGaDmQidFZf2P34L3
 qXCKacyLKtZLuQB27IQ==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a929861 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-Jc-lYBnnr43QceUbrAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290072


---
Lorenzo Bianconi (2):
      net: stmmac: preserve real_num_tx_queues on mqprio setup failure
      net: stmmac: preserve FPE preemption class across qdisc replacement

 drivers/net/ethernet/stmicro/stmmac/stmmac.h    |  7 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 97 +++++++++++++++++++------
 2 files changed, 80 insertions(+), 24 deletions(-)
---
base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
change-id: 20260827-stmmac-fix-graft-overwrite-d3ec2e72d901

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

