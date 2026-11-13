Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595826;
	b=rAAq6tPJAphOU3bD/UqI9YA2Mqh6Y4NhAq6qmOdjlxI03qYVLB0nVlxjVyn8ngdKikXL
	 SIYo8frHzLtb0juTL1nMY4lvrW46e0FS8x7QUDV6/Dgs0Rt0c3ChJWz0IJcRDsyNFp0t+
	 T+wU8J9V9Q1zTMiedSMrefGsvLFxtFY7jYf9DSUY8TpGU83h2HgaHJBCigDOCa2HzFGxr
	 u4+P1SA5aztMhk35fOXY6R5lKJjGI9W+5KuYozEh4TlyJOnu3F6yUcZHc8YnlV68EFpXW
	 zxnB2L+10/OW6mTBmyxjyaom4YjRfp8GriwjTe2XKe1p1pblEXecDisOLB/IIEq8+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595826;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UOGbIgdMvNNbvF3rlYZmS8C4yu1k+1TFWuu8QXx7o+g=;
	b=TJ3vlJVjsm+4DUyAKsWF2Px1Rt99LLst/P+KSTGZhNXp5O2794GPPJ62E6gFwHYMp3Xc
	 0uPCg0t83R5OUYfMGyYxyPPq0hBSgbetWWUR45t4Qlflz8InATqTcQ+Tvo/aeOB3TFcez
	 cCmkZcGKcswHbCUThkapzLcXXbVtv/ZCLlyYWFNF7l1qt2wxMtBxlarj2mQAqzDUHtHcz
	 91PC256Bc/Nueh9IaB6CZEz8AuN2vWG+HjCqwhoOVzDuA7oHUEhqvbsIaXLWvo+Q77sXE
	 aeMm/MN3V4RPD9SW7o6XoViTaoRciNx5e584+cNn06ZC9rS6tKm38cq25oCWGSWwAXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pai7rOpH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XltLmC7h;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79ED606A331
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D79ED606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pai7rOpH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XltLmC7h
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR0gr1011372
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UOGbIgdMvNNbvF3rlYZmS8C4yu1k+1TFWuu
	8QXx7o+g=; b=Pai7rOpHvCid7pBso1KJQNmUP3ay4+209rkTRCGKrA1soVsInzz
	2+EI/9XiO0RAM/GnD/STisvs4OSF4TmMqSpaYOTZTy4YrfruHtbiexkEV8X+AKhJ
	6HObc71xpqBRTgvwxdC0xYCS8IOuPWw7fCvssyM7FIliP505dAw/b9KSorRfVPSt
	Hs1K6yoPpdFLUGK+7yQVE9fsj5oYSiZgP9Mx0gEp4TlIeIfax6HA+62qfOkZuIA5
	ZsXxXC5DTQR/MQQPUz2nG7Lr+6BZ/wsoDvBGC3M/nm9/vZt3UjBSw5X6aDlmZjaC
	IaQbELHasdMoTMISlwbVrivN0NT59bXZNNA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdmh3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:50:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36de26cb4b3so1591800eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794595824; x=1795200624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOGbIgdMvNNbvF3rlYZmS8C4yu1k+1TFWuu8QXx7o+g=;
        b=XltLmC7h+NXyy3oLGn6NsDLYzSSjVmqSyDRg4wL4qbJ8RYr3ysP6tLyNLtAP11iXfs
         uFZs8yyK8C+g9xwr4zT8IsKbJUI256iAmXy1y13NzfF3NbPp6NUioYpp8xhAFp4nqoJa
         GEmfPTHtw5lswFxkh+8G3Pi9iB+d7Q8nXNTzQfS2oH92FPIc8JAyzxJz7K+GnmWNtrG9
         KqDkKIDls9GRqEi3oWYxyFQeEUoIComjXN4quh/HRzQ7hREJ4oVpBIUpUwRR8xtPv6pL
         z8V3bS9bSrUS1cvJJWxHa7CPgMmipfHyLjX/D1rQ+evOCa3mYuUx29lapfHE/ACBYrv4
         7Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794595824; x=1795200624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOGbIgdMvNNbvF3rlYZmS8C4yu1k+1TFWuu8QXx7o+g=;
        b=kSGnY0lT2uNK2SXfx4jERnJyHL6jDSgfB/PF5TZ41zjCwvlz7uauQ3Jdnq0r+eAzRt
         iDmLyQj4leZNMrQrt66Y84h41HqEt9VNBw9/BYUrLj464kpAPb67IyGWrn4IEGfqbR9D
         oLUitsSu3aEwFuegXb3joxn2krZme1KVEMCUptOWZVfx4HnBI0tiFOjCI3CiavVbAyRZ
         8p2JsTum750h46xl9vYp0dtTLwqtGXiOwjsRe4aPh6qXXNBwFu5YZRfuQRFyD6GqEine
         L+XegGC0PDRxdv4e3HrofEk3Qj8+/evT8jYZmjBtcIPEMKlhIKI2KtBYHc74rMteJg3j
         Zghg==
X-Forwarded-Encrypted: i=1; AL+hErHrq7xmKuOD0eOTguZs/B5x9iJ1ulEy7PxxKC5Dy6bys+TtOz3M/Xa+ns/sV/xYJYW8vRdvEQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hj0KCZV4lXRgIHOgJuIyGgh05xyoEvnsnbBThVn3ThRlwsB6w
	RmP4VANv36FoCzbOW9tUEY8yxHx69H1s95QaE7Hx2oCZi5AmkNUgjcFOM2v06Du+EajRTUWe4wy
	bAvSMyfUpsGdtCC3rfqTAtaT7uDcKhSsBldrw0Jg2x9oCs/8bxO78U9gHVlI=
X-Gm-Gg: AYBFou2KGze+/f2LsE8eLSVaIxMRbbymhQbVXQudt5Btw7PfK5WO7GBHx4EoK4Y5661
	9nc4gpta+9INjgui0A3aVr0mNQNAA6KwNh0hihh1oBHcuDmIQD5P/3J37W3jJgdbV9mrQV47PUI
	n3xYIj1/GqS9ipAVUUCW2t2h0xZLiq0J9DxJ4viOw/0gd8CfbgwqaNIzHjhrvqDyOH7O6kBJ4tr
	4cV7sZsUTb7C4Na3IqEfZhLWVFbHbKaSszVc78KnpFOp+oZRvR9K4HUkBiaI060iS2sWTgZEPGn
	GeF4NYQTURGIB+o8E8If5xqrh12wTbvkn3AwCmNphU1XQJRXp6K/IcF0HfycejFCo58zrKBME7/
	hN2yDiZq+/Ht/vBd3vPjEBwiiBK68k1y0OPfaqscWEGicAoNCwDwvjvwMx4wnT9sGfKrDM4O92R
	Q=
X-Received: by 2002:a05:7301:90b:b0:34d:755b:d60b with SMTP id 5a478bee46e88-37968b8a031mr2753161eec.34.1794595824139;
        Fri, 13 Nov 2026 10:50:24 -0800 (PST)
X-Received: by 2002:a05:7301:90b:b0:34d:755b:d60b with SMTP id 5a478bee46e88-37968b8a031mr2753127eec.34.1794595823416;
        Fri, 13 Nov 2026 10:50:23 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:50:22 -0800 (PST)
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
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH v2 0/9] Migrate PAS clients to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:00 +0530
Message-ID: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX7wAgBmxptLxG
 ZWOWk89CRc1PkDYAwbDGsxcdMtR/WO+WNR3UTIq3u8pXCfdIhi4jdlZW0pKfbxqc75od1EOv/bL
 p9eoFeWL+2+Wc6lo+MWHzNb5sSz2174=
X-Proofpoint-ORIG-GUID: lC90z6l1YYXnCfIBloBeyxze8VJ95wSR
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af75bf0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zG7KPAmT95cOeVn0dqYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX7P295BtoA5qd
 4JJ8hM7dJXuJvbaIgkOUcidrJbtYUmD8YKCoIB+n3RcDMhCvu2QTCUHgLeuMS00fCOLSMZNwmn2
 FwuprtW8hSW3G8vhCNhlOuXp2tiI1eYVfWevZHAOLegUTbTq9Y3oesWmXwwIrvJmdAZGn+DCAZy
 WEdWzSnKLTimSzTWttdj3UZx238kauElvxw4kmSmrZY3HPsUmKr3fuAgTmvQDboGHrwymnjPMhv
 OnwbJr/mgjB6CTGu8kMsHSrRFQFXLOOFZFtzPknTMlqe1PpzdWhti3anwYAVUc+fUHFsSMNOVJX
 vPi5+K0jkDEUe3sgitrsJch6/OY4KaePHOL+L08/N/NGQHLxDcqj4Cq2TwosGJMrht2axMpEoEm
 peqFNLtBtBllTI+vS9kBxIElLJdDigTROYv2yhyR23H/dB8tv30G+XAkV4A+BvjdDUZubybUiKr
 GIBxRAlDjaAzmFXEgSg==
X-Proofpoint-GUID: lC90z6l1YYXnCfIBloBeyxze8VJ95wSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075

In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
public function, migrate every user to the new PAS context-aware API
qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().

This series migrates every remaining caller of the deprecated APIs
(qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.

Requesting the Ack from subsystem owners to get this merge
through Bjorn's tree.

Changes in v2:
 - Addressed Sasiko comments.
 - Addressed Alex comment and added 1/9 as new patch in this
   series and use the  API to other patches.
 - Commit description change.
 - Link to v1: https://lore.kernel.org/lkml/20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com/


Mukesh Ojha (9):
  firmware: qcom: pas: add qcom_pas_context_init() for pre-allocated
    context
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

 drivers/firmware/qcom/qcom_pas.c              | 42 +++++++------
 drivers/firmware/qcom/qcom_pas.h              |  3 -
 drivers/firmware/qcom/qcom_pas_tee.c          |  6 --
 drivers/firmware/qcom/qcom_scm.c              |  7 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       | 22 ++-----
 drivers/media/platform/qcom/iris/iris_core.h  |  2 +
 .../media/platform/qcom/iris/iris_firmware.c  | 27 ++++----
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/firmware.c  | 29 ++++-----
 drivers/net/ipa/ipa_main.c                    | 23 +++----
 drivers/net/wireless/ath/ath12k/ahb.c         | 23 ++++---
 drivers/remoteproc/qcom_wcnss.c               | 12 ++--
 drivers/soc/qcom/mdt_loader.c                 | 63 +++++++------------
 include/linux/firmware/qcom/qcom_pas.h        |  3 +-
 include/linux/soc/qcom/mdt_loader.h           | 12 ----
 15 files changed, 116 insertions(+), 160 deletions(-)

-- 
2.55.0

