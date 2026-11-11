Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391265;
	b=Xk6P4KmRmiDZdvkECF9Ge1JDUd1ySPwATgy8i0++PD+y08V62dDIMqRa3SxP4QgB6gAo
	 /vQq9d31sI6aokYja4b1xZ319ROru4Y+OKWgZBTxzDvoVONvN1T2G3l6MBd9FQo5i3kTU
	 XYmynAoRxK9WQiOrtQ6pZwRirpNNb5LVDy6SBlhEwkYlFpcXaKzTKrzYRz5dXBBianiQj
	 gYJ8Za8/ZsLzcyn36z1/mCvoWgMe4hSkZb9yKk0Z2b8X3XCOPl0ZZI8xZcgMh0tmIdGMQ
	 cW0rakgV7zGScxSwIf4cuG1GXDtiMaZnfe1TNKMfN09rtOm8ldtPVEn5Z/+RV2VgQGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391265;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v6371ZwO/zAJsKINRttU2qdrq8Z8ZGN1i9eIzeAJUqc=;
	b=d8e/PxexnZlSizUODE4HewrdxPQM7Iv6v0YQ46MLpv4xAfpWPBb8s6oEIbrm+fwaUlG0
	 Kuz8zniyOIcH3fluBGChhQHyS9Wk9WHYF5E2YfLx9v6qOw2HgyLQCVL7/ao8N50fay0CO
	 z+tKDC8JxxR6phGLxSKdiJNI2l3FVNhCUqzJ8W44Fh42Ee4JerFggnP7EVFp4a3mSJHQA
	 sYnxOKwgURtah+7LmxTjEihedC/1ARr9GuiBB97cE8Rnf3jU3rKftcqDcZXNZaHIbBpoX
	 y+LkBHG5vOItE4WCBXi/xsjwnyOalnu4adVNx+fNPclPe+5hAi09WOtzv97DIKR0rdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EgdJAR7y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cwFPhT6v;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B160A3809
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D94B160A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EgdJAR7y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cwFPhT6v
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KoP23959384
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=v6371ZwO/zAJsKINRttU2q
	drq8Z8ZGN1i9eIzeAJUqc=; b=EgdJAR7ymcJOO8bQxiHAAkLF5VE/0Uj+614Co5
	Ksv9ip7RStWBdziGphGa0SHGA/CdbszlhpNyMe8SnHFtNBA/wyQMsGuyMajfmkUL
	QOmje9t0zCebqIMXbT0fTUM2DszOoz9kd5Gw0W5E792O3JY80QOnfoxKQzem198T
	I+BeyxL13lqmyFRWPUjnhPE3Sl81V17QSKDckzbQmX432I0Iewx6i2UkWpE/Tlir
	Sx+SZn42oS1zDf4gbMSS/YlhcKLjkfbWypJ51DCvIgap4gGRn3uPC+xrijU7eros
	rR0W4/PBFFVItC5F80NiEpPlUp1McmUGvs04wuk7jVxSe4eA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b3310u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:00:59 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4f4612a1a5cso3245146b6e.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794391258; x=1794996058; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v6371ZwO/zAJsKINRttU2qdrq8Z8ZGN1i9eIzeAJUqc=;
        b=cwFPhT6vOfOE7I98cCiZw2WppVMNhRXpw2wvesNxhA3uJP9n8NirgTiarB8Dm8psCZ
         X8v7fpLJkhPJzy/sOctdSHQT1ZZsJ/HO3q6gW/e16r2BWhvL8mIMwtXT8dQpA9gkvv3H
         P5trDSCdUUau/msTwsOiwTW0YrgERW9saZKyN+/V9qEIlQiPbVYznVRDE/kXunVb2+BV
         DSl10jmOBra5AaUk2mAJOh988rx/AgWKx4xbtdImSlrR72fjyGx/MBsZt1nziyd1VImr
         /8ZWysZAAq4K1mzkeW9Qdo2J4Bswce8Do9oLOIU4i1oY44nGADH/27zljolXi0ILvYI5
         c3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391258; x=1794996058;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v6371ZwO/zAJsKINRttU2qdrq8Z8ZGN1i9eIzeAJUqc=;
        b=FJOU7UNnYMjqRKwakKnhRmtRIj3uh4YppuEKN+TiuZrosOgSWsRm/ULTvElMJp12D4
         0s65E1EW7DaWJtDBVp05mf3mZmG9iPFUkKweQUJBcKDwNOkigwXSLD5jDz5YUb9lb8xN
         0ly9O4HeDdGwkx13o4gihwawsnda8M432GqPWUyLCljVgmChnjyE2ReTu9SrqSEOmQfR
         ns8kfWuN1Endj9BlXVWXNdTHHE2eZRL1G60NRQn1AGk9Am2Oln4qbmoyToL5YNAnrt0l
         Ihr7x1MtvpH+OxjtNiUN86GBtns1ZIL7aUkEYdm5IsVSCOxlaKl+X4+2ythBY+I2+2To
         f/aA==
X-Forwarded-Encrypted: i=1; AL+hErHFXLq+2VV/d1pc6fMLrEc8T7FbNDagP1dHt59lulX10OQ+NEopHAb8pj2AGg61kOLB6ThGhRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z88et966tHQS05zK+0f3ed4Xbmz+B+DFbC/icZsowY7aRm8ngve
	30ycWECAQOFjkvBRPnaWuxG2vg0bU0HMLwLbH313Atsj4RzHNvZfb8tJQSr6Jq38oTMY/vlePbn
	/120QLqRwJBoZzsT5iy3VpWI0TaNYai8UZZCeFx3UB8kd6f0APvUq0+BMNDQ=
X-Gm-Gg: AYBFou2VBflnOUuza8jWBK+fnniX5KGtKcRHRrGGhDAohyewio4Y7kxkSDzWzK86HgQ
	wT4sm1pCdSbJJmBXLzI7/lolYW0B4eKrRG4ANbdGKh1rJUyUg6+LLKRPlgU0sTmMi4uwmJgbnYs
	gTc0qW9K3SsLc6R/ducdF+2gXxSTMBwnC0OkLWrC7chSyUlc71ftKDI9Q5DIl4J3T392nrSoqFY
	KtTTqxuiv0Y8yUnTIBdx3aUpqeOyoJ6VOrF2I4Xfs6S8ous5q3WGlkL1qLUjqwkLP5YARH+8l0o
	UN7HKkcv6TY8sCNCLlSmwoAMjLt4c7zhkNZ8tQAdsdx1AIbjjeS3HfgUzTQ/yMVim+To3T911SJ
	CEL2uILJ/0hhmlY3vR44TfT/KceLJ+L9w81GxxpCYo7xL0ycfUPpidgmPf+VQTueLyTsntHHCqZ
	bVB8mMSqwDeKyKZrbC
X-Received: by 2002:a05:6808:c126:b0:546:306d:45eb with SMTP id 5614622812f47-5688134bac2mr2879932b6e.35.1794391258160;
        Wed, 11 Nov 2026 02:00:58 -0800 (PST)
X-Received: by 2002:a05:6808:c126:b0:546:306d:45eb with SMTP id 5614622812f47-5688134bac2mr2879910b6e.35.1794391257731;
        Wed, 11 Nov 2026 02:00:57 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm4686111b6e.4.2026.11.11.02.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:00:56 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Subject: [PATCH v2 0/3] clk: qcom: Add NSS clock controller support for
 IPQ5210 SoC
Date: Wed, 11 Nov 2026 02:00:54 -0800
Message-Id: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANY89GoC/22NQQ6CMBBFr0K6tqStrSGuvIchhE6LjFEKHSAaw
 t0tGHduJnnJm/8WRj6iJ3bOFhb9jIShS6AOGYO27m6eo0vMlFAnKYXmA4Rnhf1glBRVRwTAG6+
 tgsJpJwuWHvvoG3zto9fyyzTZu4dxW9qMFmkM8b1XZ7l5v4D5F5glF9zpBqyBo7JGXgJRPkz1I
 7nPPB1Wruv6ASoesijNAAAA
X-Change-ID: 20261104-qcom_ipq5210_nsscc-fe4b2c8d4d18
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Luo Jie <jie.luo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391255; l=1980;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=ssQwJ0NVkXEo1RNZ7AhR+p1xjTksM72Hbr1MyGjEOHo=;
 b=ELfTtgQHmQKAVD+I8fcjmKdoSmQ63d3HgGAPghBonQAWNbJzX2cwn6xE89AK6bbrIHcF97a/R
 n1K7+DMC6nEAdr74VE+WswAMjq8sxzA0eAfb0UaHCo88wp1qmqZt3ig
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af43cdb cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=cYQ6PdjOCuHZ1sjPTfwA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX9ItbHde6XD5K
 rABxh4zDSRUb2GSEw5kPC+uH8xo1JE5AV6SaRb7O60mrFuB8bJNgnl1q3XEz6qHRXmBrQfP4tV8
 6usOkv4cUkGcBLHLsQTFEMFKt8W2t03H2qWtkMg49egfp5coqjGn4M9px8a9D71fLjYrVygcZMy
 1bEOwl5Dqed6KxJzF0yMYGoEOkrJMpV838Ty+2ZFwK2qxElj02tiP351Edecphavo6bY+4zaVVT
 8u8kIKVtNHNof23HHeyZ5IKG5JYr5V1e26V/3tqxI3Eixef2ZLJOiytipFvsps45ZAojbasi+XE
 O6se6K6LZjrXV2pGygEHPXXMxvB1+Gt2ysKIjiewCkGcQGVp1Rwv5duGdOhg2ePXNMrOrFK8Bxk
 cGqRcihOAiiVp6w3U6N/GXHtxahI2/Q+YwsGn1i1k457kUng5IuB62PzSTKBr7GwPxsYjZdFUT8
 3hlybr5h5ijsW97bimw==
X-Proofpoint-GUID: 5DqtusQFffbWKihr4gyu5Vq3G8pgAMRW
X-Proofpoint-ORIG-GUID: 5DqtusQFffbWKihr4gyu5Vq3G8pgAMRW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX/kq4s3MgZxEo
 TL2+eHEOrWseAHPg0ev5j2N4Xq8JQayNQpwsy6fvBP0dgRO3fdkS5fCm5J1lmuxch9K5QbpP/jj
 ULXo+l5AxXRUff8Arm3a7ii11AhSQTI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110039

The NSS (Network Subsystem) clock controller on the IPQ5210 SoC provides
clocks and resets to the networking related hardware blocks such as the
Packet Process Engine (PPE), the six ports, XGMAC PTP reference clocks,
PON, EIP crypto engine, and the SoC-integrated EPHY (2.5G Ethernet PHY).
Its parent clocks are sourced from the GCC and CMN PLL blocks.

The NSS NoC clocks are also enabled to use the icc-clk framework, enabling
the creation of interconnect paths for the network subsystem's connections
with these NoCs.

The patch series is organised as follows:

1/3  dt-bindings + clock/reset/interconnect ID headers for IPQ5210 NSSCC
2/3  NSS clock controller driver for IPQ5210
3/3  DTS: add NSS clock controller node in ipq5210.dtsi

Changes in v2:
- Use RUNTIME_PM_OPS() and pm_ptr() for dev_pm_ops.
- Rebase on next-20261110; drop the CMN PLL DTS patches, which are now
  merged.
- Link to v1: https://patch.msgid.link/20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com

---
Luo Jie (3):
      dt-bindings: clock: qcom: Add NSS clock controller for IPQ5210 SoC
      clk: qcom: Add NSS clock controller driver for IPQ5210 SoC
      arm64: dts: qcom: ipq5210: Add NSS clock controller node

 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |   47 +-
 arch/arm64/boot/dts/qcom/ipq5210.dtsi              |   40 +
 drivers/clk/qcom/Kconfig                           |   12 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/nsscc-ipq5210.c                   | 2202 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5210-nsscc.h     |  106 +
 include/dt-bindings/interconnect/qcom,ipq5210.h    |   18 +
 include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |   60 +
 8 files changed, 2483 insertions(+), 3 deletions(-)
---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261104-qcom_ipq5210_nsscc-fe4b2c8d4d18

Best regards,
--  
Luo Jie <jie.luo@oss.qualcomm.com>

