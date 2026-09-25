Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4484D9F7F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351913; cv=none; b=kMP+/rOdM6U+AVbJudKxPn3PKvHt9m0SoVrnwheCm9mhaZNnCfxP2EraaIRx82PamVZY0OjXtMPuQx8/NUHcXlG3B8s1Lvi8SIUgYvcTNJ+TQgd2v5LZan93a1m44JjuDvv0927JoiyJkB5KCUJRCnou+2nhSwIgOba4Xe3xm+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351913; c=relaxed/simple;
	bh=GEWW6s2e1tbVayHxcvCEMGBUsyNeH1TC18r9wWPEPCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+qFHuwGc8rosuLLTXEZhsrRvg/vGh9qgHTjDV18qOVuEFIDscMera3Ombzo/YSKEP9pIXcd7KBDzHrdAW2i9MODZeqM8ptgH1HX0JYISJ6Av1eF/OUiqktKCHMZJjhBHkCKICR3/xwAip5to2F9eFfNj5yxuNmXgK2hGGSZAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTrbhiXu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ym22JwUu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTrbhiXu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ym22JwUu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDFJgn1055788
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EwWgdkmodUk
	wOcTt4ODaG1IRCHTJP6TRQlF7VVlOptQ=; b=RTrbhiXuprnEVvEXgCWrKWWbex9
	R2dTkucVuZzBnUe2kXl8Lru+KAJbJZt3UmL5bMjOmVHV9DUncg9b08tjjSa7QeaF
	Zcjfsj2Zmr+nq78ZOSGeYux5mr1J4exjxqtBGB0Z5MFxsNyYFsVlLUoomocIS8/W
	8zyu5t7eYDSLsLQPJ/8PBBdmeTkSs0x/OTLk2d5xLd1HEeKJI8S9Vc4XB7FrZvRd
	IjNITOrBSM0Lz8HUn4b+no7WADJnIFF0ctwxX2ATacLc61n+tRdi750Hkb6aBHZ2
	UWmv/z38bEWIeIhWoRCRsgTHAleAJcuDW/7kncTEmSI+K9uGwP815oJCcsg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7b5tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:58:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1112067a12.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790351900; x=1790956700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwWgdkmodUkwOcTt4ODaG1IRCHTJP6TRQlF7VVlOptQ=;
        b=Ym22JwUuH4ZwmoyMqgPEHJs0UQWjb/aOmTePwFD33sw4BlRZgDPD0aFEhovOc1d1Gi
         orXN35soSRzogU4Wv57MPSH1W7c5Gn5+onIF7iWuYRnaaacacsZ5S5I/s8cDuBvqTRyA
         qXBQRA7eU/d/FxydzpcAkpiOmjC6Q7VgxnrOUvA04ReAQz4/U5aCjJnOkrRAH7ma0cBo
         EDnQJVsSURxTjjun7e/4wxKR10st7UfE5IkQ1GR3U9rOHvH2107ACDeYGelEKZQihQGe
         vlyJtPzrqfIPbNedDjEDHN+5wXLbun2w3uXcMOVXhY8TMAsv8qjskHyjlyuf79e2GAYy
         aEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351900; x=1790956700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EwWgdkmodUkwOcTt4ODaG1IRCHTJP6TRQlF7VVlOptQ=;
        b=fwMVTW2rbtusEwoapNloIbZNxoJnaFeawHjG9LLDL8lwengRX0IPtNbFxSCuA1pVKl
         Cifz7763j5SNN21x/Exa/0UEoL/YwRvgX5wozdr4dIa41wtV98h1zNaOothNOLGGmBYL
         8pFFyL6/crcVqb8nalMZ5jRInPdeuiYEAqRfT/WVLm1TbPawiGCJ4IU7BVItp+VKMSHc
         Pv066N4vNPrxjlJZZaryO9ouRaNitUPiu74dZmmu5GeK2xXwv4J6VdT0s7QpbmRctloD
         XjscLI6NvnqQBfIevsnFVzbtEx491Bmbwm+V2YISJOxyIcWVLPyqzTMXnWIFumXVLATs
         5pjA==
X-Forwarded-Encrypted: i=1; AKwUvBxvCdLO+qZN+NGsCwRtoENMW8/dQBCy4DX9gVP8k71a1k2k9mdBO1rvlgKXR1PqT/cD+ZKCZlk=@vger.kernel.org
X-Gm-Message-State: AFuF++n8GY9AVxlKQGfylvqioEIQ6js9v2Sy8VLXy3hp1Cqm6dytVUhC
	Yn8h1Bs4/n46Mv3re0/Okp83u7uV5FOPzvGDMUv9PkYjmLpXvp8SGsCuow5FqwXWfpQSHjFkAnE
	cuxPa7I/R+I1JabxbeLvH/IrP3QdDkT2GhJE3JD+mcU3xitPwXuXAQqcIP/Q=
X-Gm-Gg: AYBFou0MEei+RRat7S51vGCt5n23pX88wWQRHnSP8QEDf+AxEPc6U3rtT//VK6EQ9kW
	XK6LqjIvciS9Bz3pP6u+c1LHfvnxzlDEqLFCCBgBo8zh6sNPmoetMw7gRPD5o1JkxZEewzNWSpu
	5A0q4A4ao7MbWzmm8poX/Orj7qlPDm+IHzqoDrol82L6/0gpk2vN7jl+mxX3lPPk/3pn7X1LOOS
	uPBkoxQlAxk9X4aX5Xv633RPJGOhhAHgl6bYZgiQdB3paDegvVnqJfFbQGPJZakWJFrR76LXJfw
	jMD0uxafHqeC44uy1PggGi+2zgB2OnxuetH+ma49t5iE2BgR0AwQWTtlk42mz38CJXijvdl/KIQ
	CdcDnBv2BMyd+4LCYkik6EJNyHbQ=
X-Received: by 2002:a05:6a21:7484:b0:3dd:cc61:c0df with SMTP id adf61e73a8af0-3de26c83b92mr2661238637.25.1790351899749;
        Fri, 25 Sep 2026 08:58:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:7484:b0:3dd:cc61:c0df with SMTP id adf61e73a8af0-3de26c83b92mr2661193637.25.1790351899240;
        Fri, 25 Sep 2026 08:58:19 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:58:15 -0700 (PDT)
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
Subject: [PATCH 2/8] drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:31 +0530
Message-ID: <20260925155737.4161358-3-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: iEi-GZt5ny1lGJt4-XLfaPM3SRkDB6sz
X-Proofpoint-ORIG-GUID: iEi-GZt5ny1lGJt4-XLfaPM3SRkDB6sz
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab69a1c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=heNUI75aw_s-mFou8AwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX4ircKzujFEpi
 S2f0Tlklvup6IPghYunvO8oOVyGyTT51qYZyBWcOnLbo0Q5MxsqfMsofpFWwEXwTKQG/HkoYG39
 8CU7vtLXlb/o0rZ7czg3aV9cBRnTT6TMUVV0gs6CnwMAwQhDylSngRzuIknbyLuC+Vim0RQ9Uqx
 a8cezC0iEAjfW3Y4PWbhFQ9d00DIyw8yDcypqVVbU15khKrXIBlS18qyM0VfelLiVD0dehIuGt4
 00IVoHSvI85ZPe8KJ3KlPUkjkTQErjX8yciQk6UvFzAtYcSE5x3x80ezT0XiL/mjCNZ4Nn03GzY
 xDyM3xYs6RPhLx4nIXHiEgydt4Z5+kF7VAsbt4PHiLxNfYSXHu2YGBO2sCWXRmKjJT1kNwboLV/
 Q7lUTasi9OGaRQq33LEpw4Dt2SkiTTecCKMkYZiWy0wkqKcPVwtjdmGsYksfLaJJ9YqJ454S0Oi
 J25pIOUauFNMFEMd2ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX+RBa9jFhI20g
 xqxbXLD8oY9HIwO2hepsjSmVCSptjDutmbmlv3nvAywOfrjqXttdjXqLbp2ZK3vBkNd4uP2i/Wl
 YGmxTX3mBnn92Qk8k6QHQO/sKdnFF3g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063

zap_shader_load_mdt() uses qcom_mdt_load() which bundles metadata init,
memory setup, and segment loading but exposes no PAS context, and then
calls qcom_pas_auth_and_reset() which skips the shmbridge prepare step
required before TrustZone authentication.

Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence
with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), then pass
the same context to qcom_pas_prepare_and_auth_reset().  The -EOPNOTSUPP
handling for targets without zap shader support is preserved.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5832dc25d6bf..d3e843220b73 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -34,11 +34,11 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	struct device *dev = &gpu->pdev->dev;
 	const struct firmware *fw;
 	const char *signed_fwname = NULL;
+	struct qcom_pas_context *ctx;
 	struct device_node *np;
 	struct resource r;
 	phys_addr_t mem_phys;
 	ssize_t mem_size;
-	void *mem_region = NULL;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ARCH_QCOM)) {
@@ -122,9 +122,9 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	}
 
 	/* Allocate memory for the firmware image */
-	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
-	if (!mem_region) {
-		ret = -ENOMEM;
+	ctx = devm_qcom_pas_context_alloc(dev, pasid, mem_phys, resource_size(&r));
+	if (IS_ERR(ctx)) {
+		ret = PTR_ERR(ctx);
 		goto out;
 	}
 
@@ -133,27 +133,25 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	 *
 	 * Note that we could be dealing with two different paths, since
 	 * with upstream linux-firmware it would be in a qcom/ subdir..
-	 * adreno_request_fw() handles this, but qcom_mdt_load() does
+	 * adreno_request_fw() handles this, but qcom_mdt_pas_load() does
 	 * not.  But since we've already gotten through adreno_request_fw()
 	 * we know which of the two cases it is:
 	 */
 	if (signed_fwname || (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY)) {
-		ret = qcom_mdt_load(dev, fw, fwname, pasid,
-				mem_region, mem_phys, mem_size, NULL);
+		ret = qcom_mdt_pas_load(ctx, fw, fwname, NULL);
 	} else {
 		char *newname;
 
 		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
 
-		ret = qcom_mdt_load(dev, fw, newname, pasid,
-				mem_region, mem_phys, mem_size, NULL);
+		ret = qcom_mdt_pas_load(ctx, fw, newname, NULL);
 		kfree(newname);
 	}
 	if (ret)
 		goto out;
 
 	/* Send the image to the secure world */
-	ret = qcom_pas_auth_and_reset(pasid);
+	ret = qcom_pas_prepare_and_auth_reset(ctx);
 
 	/*
 	 * If the pas call returns -EOPNOTSUPP we assume that this target
@@ -165,9 +163,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
 
 out:
-	if (mem_region)
-		memunmap(mem_region);
-
 	release_firmware(fw);
 
 	return ret;
-- 
2.55.0

