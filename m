Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E24DF4D5
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351916; cv=none; b=pxENpHpl5AGWGmUKpa3pQH1R4EotWKBktLIHV0apShlAGjOoYYCslBejUzirJzAklzPxNknTUOU8XeFVHr+yqcWg9WzJ126cH6dawEgt64uynHQBx+dCts2pxgO68ziOUAXLUqDJw1TdOI+jf64nhR/iQxJ4/VBzyNZFC+lthME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351916; c=relaxed/simple;
	bh=snaS/I4Hb8yCdgn5ECyoCKvWNHrkWAmTGwXoXARznGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUUOdJZ5ZDRkceMH2PEDtuDx8MkI90tYLt0Xw/8fwItGEcqvWCLoOhi+uUAdZGW2uQV5mggI2kC1UtgH5+DaGwihNV/1hk5zJFNlbmWaPGxpbPuoOItqKdhVmbZUsU2QhCshRAxtVPZqZoSsTuuKUTbJceRoXnvqEyjCyhA4bac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bxg0wKFs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GaN456T7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bxg0wKFs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GaN456T7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PBVGot427364
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ySc0a6RXUPc
	52wNB5/s9LfTmLDyBrV82ex9cPFNjiSc=; b=bxg0wKFsHNjDYHIiEqmTvQWvwMV
	5Nifc4KXUahwyZDMhJ/Uuv5GKjp8sFZ8QKLFvqvDfE4Jr6/hNahGwU4YFgOgkcJL
	RmHMUOfwVKkFGKgiVKweDgJ6OGD6x3Wxb/PlEvoB9uEGmlJ7FU/UtNjegP9Bmxu8
	TANC9W6tQ+pigu6YmdqkRDDgAUrCwATF1hLkBu+CeP+CwZ6CmL0bDzxqLJGrAv6b
	teICyY4UVEPGmxSLnAjq/s6PUZ52w/fcExzJie8VlICxt7Vtmiebx+VtmrN1XiPH
	3hYl6njSsDCk4We8i6S+Q1t0x3tzNMkcQ4YvwE0eG0EmKym71sZBEd8euvw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5e8y29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:58:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86917d18a02so947788b3a.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790351910; x=1790956710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ySc0a6RXUPc52wNB5/s9LfTmLDyBrV82ex9cPFNjiSc=;
        b=GaN456T77RCBmPIgeuN1bJHsC9/SOV2FeP826CMEgZjhUdSoLjNGIJ4hjx/mjSeC9Q
         66zRyaOu1zCNxrKYskMkrmpjnAXy1DDjvIzaQZK8W17OHH850VFzem6g00BdEu4K8cN+
         FYHsPFFxpUfxSVBMbH9oXPeY4u6gpTYwhkx4/hHtDg8qwhsasbsLS2qyn2xOUK59KsOy
         eur0QUgJ7rNVHMBOvvk3MaU46Y5x/VPhgcGvukSzhvkneaBNEJR7Q3ngYRLDVbWgwIG5
         vKahEunchpUjpHNsrwOM8qHjQ3bEtbn3eEz8mJPH5TbDO7Yr/z0vwsxf2+WozmBdFkjU
         IXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351910; x=1790956710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ySc0a6RXUPc52wNB5/s9LfTmLDyBrV82ex9cPFNjiSc=;
        b=LX2fkkpiG76QpauOH+YVbFbBOhqsqMHR1d6/yDEh2BxIqH3yS55tAWeZoFsYaNGsij
         Iv56S9jhFa3o49j5/5ShSL50U+/LZf9mZGQnNHW9cvIeTI6AaGIIxhCno5SlzBuJ/gZ5
         AtS73TP8VvDk+6D/jh1gtQWHpN+FytM5a9dJMbIbBxV8NCRrtsL5+b1ujg8NZ+PegY32
         6Fs4lL49SuFkoO43WMtp/NhatwIMcC/QzICKtqBS9AB1R5Yg9m/ceDN+u4JSxDDfAgdF
         ZbssOhrNHa5hg7d212AZqyatK6nOYLaYwa2BbaoUpFOckOeu/OnS6NEDh8+kXAx6eaa0
         qV2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwePcnDBc3N4jIYNXkveFQolM9g5plij22AGrlDqyPkmD/yR9cMcXPSBVNutDsTfUMbYTN/ttQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m1d1R1cexB+ukXem6BjmeAtxFQbpDzbIH7rzh3J9aSSZoqZkcj
	JgO2Cwl/PXeTghk4YcNE24N6VLVVNbcKT3DcBZMvZvaSdQmC0uPP8w6nlRCMBEDlgd1lYAaKvMp
	0Ae1R2V2ZR2kuc149J/5GG4rKV8k66qItN57WFfQxiF9B9W9pmewohJ9IS/g=
X-Gm-Gg: AYBFou1t+XFmKnf+fhrxAGA1In8kfLjYGDT/vhzLO+AhVQt/g3+3OTEAfcAHYELUiLD
	x2ybDUMH7RhV4VCLk9d2M0cmLhQShPPRVyXcJOb7pySntG0LX203JkRjiA6rcg9Bn+uxf9eZhhv
	OVyTwAx3bUKG2P2eGTArlC6iJrvigIBkoI52FXmRkjtZ5Abvvax7HHg3dxZr/jxfvtkftrzrIOn
	CKfLqRARIFJAN6AZmFMsE6TCufuPJ3DFbb9Vzpt1d2JBwL9uOw+e3J4Ap7idA9FEsm6cfC3KxD3
	SRzjCmHPJA5AIoJrDokV0fvOnNbCfXCavA00DWJEO4OmeNJaMY5zz4NM/ngkd+vtvwnu4fDYz3u
	ekqitBTHPAghZTbs7BWjkv4ffqN4=
X-Received: by 2002:a05:6a00:3d4c:b0:86b:b06a:d3ad with SMTP id d2e1a72fcca58-87e99568559mr5209959b3a.23.1790351909918;
        Fri, 25 Sep 2026 08:58:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4c:b0:86b:b06a:d3ad with SMTP id d2e1a72fcca58-87e99568559mr5209932b3a.23.1790351909300;
        Fri, 25 Sep 2026 08:58:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:58:28 -0700 (PDT)
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
Subject: [PATCH 3/8] media: iris: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:32 +0530
Message-ID: <20260925155737.4161358-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX7qiIhCelIXjL
 88LlzXGLSRDoGg7FJQJvQ1/JH2k7eWIy5GbWKxfuWYiPQ87UfqRXLfJMnZSbytthuN2a73OeSJ+
 bDAVsz7+8K4Y0QCwWIufT5UHeVj2uyg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX1l8/ObET3xBZ
 yd64n8TLbiumvH9svhpFuIee8OrnJadOHU+Ihm1NJFTHMuiq+nq4uHbyGQLpciUXUmCA1dujVNc
 hUTSVf74WOmr1QRlqq23/Oy4VA1tJYzYa4VDoV6jUdmH8fzPsf58Q6vpvKhGirg1u/j3ViES+pc
 uJBy//difrRuuRlrcp8hqj/MK4wukEJQgczEeBmalwK/aykBNGx8OD2ItrDvO7hQND4inP+8WSg
 3IUmuRjfXDaT2oj9D4tVpZYEGWDCt2yhsZ4Vn7WD8jif6IZPvm6kJqx+S9L9D3hQenWoGHWWCH3
 Fqc0otZR9IGgIAGVBeukFCo5MwWnOcRYysGF9ZhAeHPv+PCA4uD+2SNYJtu/4sipZajJc1lnO+X
 a9CxYNakZOBsjU8bPvAvcCl54ssEFxC4T9lgalN63kWd9U4ckc13d6JZgSix2g50NjYg+v+cJdf
 +t/0TBR4hNNKDqSiEbA==
X-Proofpoint-GUID: d6Xiy3geQ2Bmyc7Dh_rc-QlN-ALSui1b
X-Proofpoint-ORIG-GUID: d6Xiy3geQ2Bmyc7Dh_rc-QlN-ALSui1b
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab69a26 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Wu4PtPgZBy_53pNpwMMA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063

iris_load_fw_to_memory() calls qcom_mdt_load() which bundles metadata
init, memory setup, and segment loading with no PAS context, and
iris_fw_load() calls qcom_pas_auth_and_reset() which skips the shmbridge
prepare step required before TrustZone authentication.

Since the auth call is in a different function from where the PAS context
is allocated, add a pas_ctx pointer to struct iris_core so it can be
threaded between the two call sites.  Replace qcom_mdt_load() with
devm_qcom_pas_context_alloc() and qcom_mdt_pas_load() in
iris_load_fw_to_memory(), storing the context in core->pas_ctx, then
pass it to qcom_pas_prepare_and_auth_reset() in iris_fw_load().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  2 ++
 .../media/platform/qcom/iris/iris_firmware.c  | 20 ++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf2..68e6adcc1dfd 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/pm_domain.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <media/v4l2-device.h>
 
 #include "iris_hfi_common.h"
@@ -123,6 +124,7 @@ struct iris_core {
 	/* encoder and decoder have overlapping caps, so two different arrays are required */
 	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
 	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
+	struct qcom_pas_context			*pas_ctx;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 21cdf1c39835..e73a5dd98b88 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -115,9 +115,7 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 	struct resource res;
 	phys_addr_t mem_phys;
 	const char *fw_name;
-	size_t res_size;
 	ssize_t fw_size;
-	void *mem_virt;
 	int ret;
 
 	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
@@ -125,7 +123,6 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 		return ret;
 
 	mem_phys = res.start;
-	res_size = resource_size(&res);
 
 	firmware = iris_detect_firmware(core, &fw_name);
 	if (IS_ERR(firmware))
@@ -134,21 +131,20 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 	core->iris_firmware_data = core->iris_firmware_desc->firmware_data;
 
 	fw_size = qcom_mdt_get_size(firmware);
-	if (fw_size < 0 || res_size < (size_t)fw_size) {
+	if (fw_size < 0 || resource_size(&res) < (size_t)fw_size) {
 		ret = -EINVAL;
 		goto err_release_fw;
 	}
 
-	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
-	if (!mem_virt) {
-		ret = -ENOMEM;
+	core->pas_ctx = devm_qcom_pas_context_alloc(dev, IRIS_PAS_ID, mem_phys,
+						    resource_size(&res));
+	if (IS_ERR(core->pas_ctx)) {
+		ret = PTR_ERR(core->pas_ctx);
+		core->pas_ctx = NULL;
 		goto err_release_fw;
 	}
 
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
-
-	memunmap(mem_virt);
+	ret = qcom_mdt_pas_load(core->pas_ctx, firmware, fw_name, NULL);
 err_release_fw:
 	release_firmware(firmware);
 
@@ -166,7 +162,7 @@ int iris_fw_load(struct iris_core *core)
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
+	ret = qcom_pas_prepare_and_auth_reset(core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
 		return ret;
-- 
2.55.0

