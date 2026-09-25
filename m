Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085A4D9F7A
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351888; cv=none; b=Fv0iScKdwz+O8a0mRIeno7QBNlj7SXZfYXgQKJSfN5L1gS4ViRUL7sdMPBPkeKUOKXPjnFkzOivkc53MZ675hsNIJfIGnUXOzqv/ZqDhJqK4jeZi0OM0S0St+6qfWH/nPaCOjvVWmIUF7OxOmB0QBBYmNTaO5yYAkYyF22Lo8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351888; c=relaxed/simple;
	bh=6/aq0wXwPIukqmyIpiHgBaMAEwS3rqhWHEw9Ijrs0kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9FXodjCluD5rVE1l8mCzfI00YvZgCrFHgDX4/XJ+u3I5glZ1HlFw7wVG9Tr6tXPMpWJw7jzIiscXwiVkbkkktf/3didni8HYZC/POl/nZXMWcMe9JnrreFbSL67/2hLRWgmqim/QAzYGuqfZfAFgrrSgG3K6ZQ9B0m6srET9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8AcaWl3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AfUUM5oa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8AcaWl3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AfUUM5oa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEFNJo756679
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EBl2dFsWiMsFSqUAN5NQylf+8ZNg8zQAaPd
	vj+WmO8o=; b=o8AcaWl3pzLm7MttTikh/ZzAMiyEqPkxid/F2lrgp/UB/VlvgSU
	LfEQW+w+JPZ6ufnUF6kbgpilPCbo8SGf6zf/4VN4jV6HYSTdHbDjzIt5tcOkou/n
	5z0aqkPkcHX2XuGrHSxzm2/dUpDduAet6l7J1aIYdU7kzbKuKYT2sMa9aAsKsqWa
	/9ZqppQitZ4ALWqInj/J9j3lIRpr1HP/vl4rUzOWwyf1AYkB8mhd4qxOqHakYv3N
	Ilon22rLMfQM8JUO1SzsSEvaicmV8JOLgGmeIcE/gC+tNJcwZsAbH/lLXJBlI6ST
	ZOsRheDYR7yKt7UFMw4ty3uhPa7ukGPUjAA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq0a3fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:57:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88078ca8725so259708b3a.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790351875; x=1790956675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBl2dFsWiMsFSqUAN5NQylf+8ZNg8zQAaPdvj+WmO8o=;
        b=AfUUM5oaFNZEkxJ2iLCsP32iY90zDDQw9OYdPABe9lhtfHzEOA3Ro9SjuWT/srLUGb
         xWi1sLyIE3NCNfp9bxXOQh9jASAHM4zvk8ysDkWAxe7bePXthAcKYIgrowK/wAI8M6eu
         o+EsIXvNnkXQ4A5oZ3PnlZlvMKKUMkebQ0kSr8Fa+/84EYfKuaPMlqPoM6xyucYm0Tk7
         /res64zv9GF6b+mKpl4GsBr8nWoZIpfGinsTIzO/Qio2SAUAwsFKnr/qvzgYNeXEBy33
         FN3hXccLzVtttwd9D+Ifu6spD3jq6NmAuTBSQEVbToOcy4GLMFpUC7bqFXx1sqjuyO9N
         iGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351875; x=1790956675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBl2dFsWiMsFSqUAN5NQylf+8ZNg8zQAaPdvj+WmO8o=;
        b=n7NolBTndvddhSqiCzFAhgFn3dSr5kQNIbBPEcbwbyzRRxir6XbFeCY00RE65edWq9
         srP1wM72vA8bg4ufpdBx6ZghNYlCUx80v7w2aorQlfaPUbY9lE7PqLMz7gMT7Wz8yPQe
         cTrHru2aXWlYtQnq9b0YwXzebEumSDhFITUC6+M2GJ5XXhn0VC0nhvZtBiRfPliZZ0zK
         y2Z4ZPh+zw/gUmEVcV2jj4ObUEmAo00lrkmOwGq/TODvM9bW3gmAxhzYVxBqU7EZiRah
         vYI6selpb0FLAu8zJuB7A+IoQxq8OmBRhgE6I0IuyZHLToaX69utx6P4EQ1dQXYAjjr7
         YGBg==
X-Forwarded-Encrypted: i=1; AKwUvBw+AbucDV4ruRhc9ufCTGJ/V52pMocoLLy4zoyTQ1C8/l7YcK4gvVYyjc+35eFcX48/36UocA8=@vger.kernel.org
X-Gm-Message-State: AFuF++m5u2XNi3h9Eue382lCeGPIvYBn/Bt5ArMuweIkSguhXmLuhS0Z
	Wvbha4/ppiijeP73oZMdC2xcOVd/4KU58Vkurg+A6UrGgJRLMHirQe38ZGtTmofTg31gpUcZlLh
	OgrPehFFluvlNjlLYztDbcRCDXa305GXsmEC50oSamUds6EsyHVDkfiKbFHQ=
X-Gm-Gg: AYBFou2VvLuFyPvGLiS5PD7Q94JPEZiQqg0k2RNRzH6b8tbKfrYwpHGQpEWnsJOu7MJ
	O/GNaRyZTywC5R4GIrI8wAqGYH7WeHVXsUPce3rvQLTbY7sdIPwCmRkcavbSSWRIGSDCUTnCxZR
	bGAW5ILV/lr1GKGafOhU4NTc2OTx0fsBRs/ux/Nzjq0sZWkFXKtDisnzLIIUyqZpKfmyEmJmuMi
	+kZoiERE8ud/XsH85UfTnzRpi2CBdoP2azelNCTE7HcJO35mG6Ndh5giWG7ZH82NySLAICIgG9M
	sem8PDbOOkwNVYY+C5Lt5PamjUbHOuryt1W8u+d9aMVa1693292KOgE91e/7UgIYuPEZpixxmzN
	tpa53GZ8i1o2I/jzN5T/LbyRu2I4=
X-Received: by 2002:a05:6a00:2d96:b0:880:d0d9:fece with SMTP id d2e1a72fcca58-880d0da1e8fmr852033b3a.36.1790351874741;
        Fri, 25 Sep 2026 08:57:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d96:b0:880:d0d9:fece with SMTP id d2e1a72fcca58-880d0da1e8fmr852010b3a.36.1790351874126;
        Fri, 25 Sep 2026 08:57:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:57:53 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:29 +0530
Message-ID: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX59CTWx5sXEoi
 kymu3Pk3lrtGYrB0a1z2XA+PVT2k806Nbqo/X0/YoTwJJRpKbzvZteu79cWVVo5VrQLzmHnpYag
 194re5GsHNqVD6xhUO2fyTVmH+jT7JE=
X-Proofpoint-GUID: Rt9VOBaeYOJwUZDxQI_hZ-IKtLGbjINR
X-Proofpoint-ORIG-GUID: Rt9VOBaeYOJwUZDxQI_hZ-IKtLGbjINR
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab69a03 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=zG7KPAmT95cOeVn0dqYA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX1UN+iYcgp73c
 8bCsIUxILUzEn4CL8sPG1YzAB/+9M9PtyjvlkdfOrJAfmPnMB/C4eqwSXK09Or3brLLrRGfVAMg
 m7SOdaHxJE4eKBY36ACBxLC+8lvFiZYN322G8ydyiwf0vVs2gRa4gJoXvpjvrJ/np1YMsv5g5E0
 XxfwTWglu9MBY8xREtPI1estJsEMT/ICHa/LxMFOsku/Ty6609phE92714PaYi/dAxuNd2DTl8y
 HK8q+4lOM6xXGGVzjnK65MRMdKIm/AlSAzLvG/P07ciul4CX/V4v9peNGC7Tqz4yzvSVE723xrf
 tcEEZDRbWID3zjcPduT54qdTtTbIWlM9kM/1gsK0bWWrQrqF31JDUHGkw623VwGAj4F2WGfj9Sh
 4/yCxFCFTUbYH4agHQUnBuyVSoHZhc4Ej/x4MwkHsN0E7571vHSWd67FJGwRCvqvAP75NFcgiys
 n+vn9PfC36DVCnf2Kvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063

In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
public function, migrate every user to the new PAS context-aware API
qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().

This series migrates every remaining caller of the deprecated APIs
(qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.

This series is based on top of although no dependency as such.
  firmware: qcom: pas: Make MDT buffer retention explicit


Mukesh Ojha (8):
  remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  media: iris: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  media: venus: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  net: ipa: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  wifi: ath12k: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  soc: qcom: mdt_loader: remove qcom_mdt_load()
  firmware: qcom: pas: remove qcom_pas_auth_and_reset()

 drivers/firmware/qcom/qcom_pas.c              | 16 -----
 drivers/firmware/qcom/qcom_pas.h              |  3 -
 drivers/firmware/qcom/qcom_pas_tee.c          |  6 --
 drivers/firmware/qcom/qcom_scm.c              |  7 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       | 21 +++----
 drivers/media/platform/qcom/iris/iris_core.h  |  2 +
 .../media/platform/qcom/iris/iris_firmware.c  | 20 +++----
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/firmware.c  | 29 ++++-----
 drivers/net/ipa/ipa_main.c                    | 24 ++++----
 drivers/net/wireless/ath/ath12k/ahb.c         | 31 +++++++---
 drivers/remoteproc/qcom_wcnss.c               | 12 ++--
 drivers/soc/qcom/mdt_loader.c                 | 59 ++++++-------------
 include/linux/firmware/qcom/qcom_pas.h        |  1 -
 include/linux/soc/qcom/mdt_loader.h           | 12 ----
 15 files changed, 96 insertions(+), 149 deletions(-)

-- 
2.55.0

