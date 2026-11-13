Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596064;
	b=mItH4606ToQ+WJyCXPDSZj3o35sMBzVAOOSKbP2QIosoHZOvbjsBvulFgRx8UHQwVmp0
	 qYRmqfgbvhlNFBAHnfWJafx4UzlQQwYCZFMYAf7fyR0jFkZ6zmACahea3uvZet8bg75O1
	 toWG1E8syKzqN/HlocEaP5PdyRoNxSg6k1aLZ9a+UW7dr2VdZVPOvM/OxYZfGt7w+X7hG
	 bFehV08eH0T6+1D9fGhLOhr6INBJrtowmIhl5Md1GcghI4cMnoK8um4HgON7c44PcSAlX
	 g7ZK8g51W27KLFhHQ4nJQ4M4QXWO/PiQb3loa2JIAzgfDWe0JnVz6y2cUAIhprzsBlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596064;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1pg51pe/31RdnPvnOyGiz66zvNpNhsnA7dx1wDRzP8k=;
	b=EiOyPEaZQYX8hpRkz2Bbq2YQveoyCFFVGRmZX6pO8ZL51BiMY+elWmbFW9W/WhdoxJau
	 5duwGo45mZ5Hs9FGBLq+rb/oDI5HGDGQNHJZj3Paz8HPpFYPlMarXT1zbUq9ADrMEWwwj
	 XwJIoZRWZrc2tOW9/NopFbgYtcFv45I2O8fXiHy2SAsADA8XSZi9/1LtFFEKF92DResbE
	 9c5DwgYtlPWRwhfKiQ09X4/Ib3iDX56rv4P6VLtfyqO5q6LI7EOHrX2ZNEH2m+Oir/3Ji
	 kvH4/rbbs/CcHmURGam7Z2p3wxfujlpTaiz0SnQBefutifBQAY1qVJnTT8BbbzgzB9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lDCGc4Da;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="NU/LF8dM";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA960A2628
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8FA960A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lDCGc4Da;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NU/LF8dM
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR5FT551880
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1pg51pe/31R
	dnPvnOyGiz66zvNpNhsnA7dx1wDRzP8k=; b=lDCGc4DanLItTTOu1ctUWq1jtJ1
	8Mcr4M/OWQsWRK74Oy0WG7wmQlJBJiSAv1+kcfVmGq/eLGeucU3XBnA4u2e8/PJ8
	1udRvJL4lLFj8n6/h43MI0v2u3v7C6IdV7XR4tIXuplhwdVVYWiTMdd/8pcjuRWT
	ucsf0Zj5k6lNsyZ000zx8HCiIczfeMe6KGW0SWvjGx2bqkTXSeTRyeRDRm8qBJUH
	TD11VyNs2XLxm3ag8IYy7VynBWFNiurEX0CJUXS5REBMps9HBhWbn7AdZqR8ckg1
	kA3NBuGaNMX+4JXUFOpX+sSHHEDFf7DY1+NzKNdx8vkDY+OIhBfUB3KWC3g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwcc6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:54:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so1568055eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794596062; x=1795200862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pg51pe/31RdnPvnOyGiz66zvNpNhsnA7dx1wDRzP8k=;
        b=NU/LF8dMjd9+LbaVrcWPEnRq0V0Ef+ikn170WdO2IYsdueRfDgQ7u8/fXpuJo75yie
         r/34p5X6HL71/YP6UwTNr7umk9zqTExeYlASEP7kPQ6q9tv5NcSeFlAI0UQDc5B1Q/wx
         Cme/S/SgtgoymxqPWMAurkBt83T8VjCSWcG0LJdvJZKxxWejv6Up6oVTe1lgFNp14NC8
         jZLdb667iYhtLvVNC/JpgcFLhTONkCyY9SjJkOboBRLrQYGOrvZFja2yQ/nv5QXwURbo
         os9xLk68GpGTlTOBt9C7ea21ZGjgbsOCBsAUJpigCdgMkgsgbvWGrVCgy+6m4uKq2Uaz
         zlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596062; x=1795200862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1pg51pe/31RdnPvnOyGiz66zvNpNhsnA7dx1wDRzP8k=;
        b=flDMtAzIaBWIIQD/d8nWd6FDwm8vps+DpeKObW0fAKnah7CQspNMvaeV0iC0z+F13G
         K11PGk0sF9rzuAjnYta/Fn7rSRo6UB5QirTrMbN81HsNOXybPNN3QQBfku/Dx/za3vlg
         I+6ykEN5bkFIvdVyn6vdru7c66ftWGU5+p0CfWF2ofTdueARnnKkazmxBZd8Drxo2DiN
         POx+0f7lB3ioQxU+zezXGLvRZhpL0tGo5ype2X371sZT25nxEAqM+mqy57HJjnbuPk9O
         OWggHJhDpZ2QwZFR9Jh6G3m1gDhkT2+fjHMaZqxyfbmtJS1HlPgjAG9HixC6IDKJx8X9
         FXpA==
X-Forwarded-Encrypted: i=1; AL+hErG4omomRwOeevWw5q0yxn/jZf080grd4qEMmtl/lp05y5WFpTwnAYfjE6cz/5v52IHkcl0aZ00=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CvW7bG5FZhk/DK5RAPPkUTRdJrqk8CRJwIqGp7TKale3I5/z4
	9FwEOeP9R8CYoem8gwVG2V3qJDfqoXwyo9GkpT9mrl72E18hVjrnHBvkUooFgpYW4UbIwf/8peS
	LeQUzg9coI/UUxZ7Vf6dwhVgfylRlkb2aRVQ2TKTCSa6kDQ5BPD8dge4qU0k=
X-Gm-Gg: AYBFou1FGvPRPIHiw6yjl3X4UN0XY3Ym+7k1t5ddnHL+P3gk7/+ugsJ3b3+k2q+iuSL
	JFJRCs09Q4VaLXsAyIEFoF0XwjpjFy75VEyD6TzUR9GVa9nSRxGd1PIlaz8UP5SknvNu4zNWerz
	CCpIpp85hV0fjmPkv8S/0r21NRvZdhXQhCYrfCDLhA7LJ62Jih5g5NkGMjTdjiyCtVUb15mREKk
	SDYT/rrgWAKp86YFDF49vZaiX3iTqYsGOBeHcTzMDcnaGobSN21zaaGUMkDmsl1zEvlIi84bzGq
	LTwA3Z7clJPLSSuCcHZoZT/LJhKJDpaBzHjiZN5a7QD15KbAtHkljHiz0dVwuiZ4Fr9spo19QE5
	Yz1TGsl1knw/V2UC3lciC3F5VM0WrmnEtdIhMo3mmtLJBIDYuVcYVNCBAD0NxdUeiXFHm/GJHui
	4=
X-Received: by 2002:a05:693c:41cf:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-37967506841mr2876453eec.29.1794596061544;
        Fri, 13 Nov 2026 10:54:21 -0800 (PST)
X-Received: by 2002:a05:693c:41cf:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-37967506841mr2876388eec.29.1794596060847;
        Fri, 13 Nov 2026 10:54:20 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:54:20 -0800 (PST)
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
Subject: [PATCH v2 7/9] wifi: ath12k: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:07 +0530
Message-ID: <20261113185009.157893-8-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af75cde cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=tFPd4D2tFowRDCwbfnIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: GwkDa9O0V82X4UkzSz5xD3tYtivbfZSJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfXwSbS+LxPf7fj
 ft/cKfgbyNf5oxw/+OZl7u8Eo/B4itg3RI1waRiQ3h4dioflJ49MBnH3P9dXkNk9ti14BmBjJgH
 I3kOAHLw5uiaSvKqsGUyZar8kYjJkZhwbAPYnytoCtKAwiPK11OUvVaKP5XLfWfDck0t6MwWxgl
 HoRWznUdx8f9mlOIBuorINz0ZEOXfEXnm+asmjKg3EOcjgVr15h4Ilaqayk71vLI7Y+ppSwEJkP
 AaTbI7gPiOS+JjzpomTOyvEhM231RSufHp/nScOrVc7fBhZWIzy6MukgIWYOVyTKS4h2sXI4pr/
 5gCOiWLieDmSXCwSeTgoTl0ugUvo4jVvW6k98wKI3YLZgcMszFaYhxnoayQIeWfEgtZIi0IJoWS
 sm6iwL6hbpBzetKvr1Qf/b6mj3V3+JpyQQm93FxLVAcO/eKs6Ur97zAm5I/A4EJwQSW2HWh+XBl
 cFJNzbYCjxs737PD4Ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX93CEaDlm7OCw
 AYJ/5pjTDp+XL5tOUiFZmTVLVqPe67NpihpKKLR1WXWwvLI/or6nmTScKmHJsn7Nw3100a2Oiq0
 nw7nMgfjA1vhKzQXPpUSmMueihyLa14=
X-Proofpoint-GUID: GwkDa9O0V82X4UkzSz5xD3tYtivbfZSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075

ath12k_ahb_power_up() calls qcom_mdt_load(), which bundles metadata
initialization, memory setup, and segment loading into a single API that
does not expose a PAS context. Later it calls qcom_pas_auth_and_reset() for
TrustZone authentication, which is the intended behaviour. However, a new
qcom_mdt_pas_load() has recently been introduced that works with a PAS
context and can handle everything qcom_mdt_load() provides, along with
additional functionality such as shmbridge creation and retrieving memory
from the shmbridge buffer when the same remote processor needs to run while
Linux runs at EL2.

Replace qcom_mdt_load() with qcom_pas_context_init() +
qcom_mdt_pas_load() and replace qcom_pas_auth_and_reset() with
qcom_pas_prepare_and_auth_reset(), using a stack-allocated struct
qcom_pas_context in ath12k_ahb_power_up(). The non-scm_auth path
retains qcom_mdt_load_no_init() with the caller-provided mem_region.

Apply the same pattern to ath12k_ahb_load_auth_shared_fw() for
consistency.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 8a3919675134..75d3141f968f 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -418,6 +418,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	struct ath12k_ahb_rproc_info *rproc_info = ab_ahb->rproc_info;
 	char fw_name[ATH12K_USERPD_FW_NAME_LEN];
 	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
+	struct qcom_pas_context ctx;
 	struct device *dev = ab->dev;
 	const struct firmware *fw, *fw2;
 	unsigned long time_left;
@@ -451,14 +452,15 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		ATH12K_AHB_UPD_SWID;
 
 	/* Load FW image to a reserved memory location */
-	if (ab_ahb->scm_auth_enabled)
-		ret = qcom_mdt_load(dev, fw, fw_name, pasid, rproc_info->mem_region,
-				    rproc_info->mem_phys, rproc_info->mem_size,
-				    NULL);
-	else
+	if (ab_ahb->scm_auth_enabled) {
+		qcom_pas_context_init(&ctx, dev, pasid,
+				      rproc_info->mem_phys, rproc_info->mem_size);
+		ret = qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
+	} else {
 		ret = qcom_mdt_load_no_init(dev, fw, fw_name, rproc_info->mem_region,
 					    rproc_info->mem_phys, rproc_info->mem_size,
 					    NULL);
+	}
 	if (ret) {
 		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
 		goto err_fw;
@@ -492,7 +494,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 
 	if (ab_ahb->scm_auth_enabled) {
 		/* Authenticate FW image using peripheral ID */
-		ret = qcom_pas_auth_and_reset(pasid);
+		ret = qcom_pas_prepare_and_auth_reset(&ctx);
 		if (ret) {
 			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
 			goto err_fw2;
@@ -1056,6 +1058,7 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
 					  struct ath12k_ahb_rproc_info *rproc_info,
 					  const char *fw_name, u32 pasid)
 {
+	struct qcom_pas_context ctx;
 	int ret;
 
 	const struct firmware *fw __free(firmware) = NULL;
@@ -1074,14 +1077,16 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
 	ath12k_dbg(ab, ATH12K_DBG_AHB, "loading firmware %s, size %zd\n", fw_name,
 		   fw->size);
 
-	ret = qcom_mdt_load(ab->dev, fw, fw_name, pasid, rproc_info->mem_region,
-			    rproc_info->mem_phys, rproc_info->mem_size, NULL);
+	qcom_pas_context_init(&ctx, ab->dev, pasid,
+			      rproc_info->mem_phys, rproc_info->mem_size);
+
+	ret = qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
 	if (ret) {
 		ath12k_err(ab, "failed to load RO firmware %s: %d\n", fw_name, ret);
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(pasid);
+	ret = qcom_pas_prepare_and_auth_reset(&ctx);
 	if (ret)
 		ath12k_err(ab, "failed to authenticate and boot shared firmware: %d\n",
 			   ret);
-- 
2.55.0

