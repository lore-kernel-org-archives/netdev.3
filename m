Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596022;
	b=2ClLHcBVAwWtwbW+CMW0bLnN1fPnTNc8xYqPz8o3r7+n+Ulw2skvSWVMWIMD3iMF60c1
	 DfTovxWAQogdR5s8ErQaCRYvfqT70XWeLrxuwIvc/0bR3Zl/IepT6gbhL8XpgRtyGIscm
	 OWECLVf5mc+pSWnWwjO8mkpkhPhjhRX/I3k6VQ8z9zAUfeV9dxLz3eRzYjjJmc7s95ylZ
	 QWMNY2j9K55x/jlc329kWiot01foGEuKUEPZr202wefaekjSKkBe9t/UgyW5Xp9VnOiql
	 jlTlBH6OcUXmgRHKRCl+1zqtkjtocDgwlxPdtgWwAfgrM1UOj1FzoHNq100IqyaD8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596022;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZiJ2cGdx8A1D88FHZg9zdVy/kI37kSxx0OtiuBRrPMQ=;
	b=t9PHQ2PbS6jUm+vyUg67k06qtXF1911NDqbC1yKW6adkjjqtGjpeamdd2RnM2CyoNk91
	 FZke5JuZ0YROXY2XHMmwjXTjR+15LPvE2QmmclkahNWxPZQOueOCrLdoZg8dZ0k8XAvH/
	 6sWJ76AJUicWSGaeIovmjMU/bxvJFhUQKJCnMvWdnAd+afZnbaxBPlz9uGLi9baGdaakV
	 W3ilCtWTfW5LBZEniyTJYRG8VVS5oQEOMPTVZZKD5/PBuLCdBVxAeNMqk1ezYzXSsl2IP
	 V6DrwXvEJU5fQVX91nuc2Ozr+9aVc/RO8NR6ex87VPf4AiOP6wtE1REHE5lnnxFgNBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FlQglaKa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRfFGhZz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3460A261A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C3460A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FlQglaKa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRfFGhZz
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR5O7551894
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZiJ2cGdx8A1
	D88FHZg9zdVy/kI37kSxx0OtiuBRrPMQ=; b=FlQglaKagUpZEUdwHsKRxWfwJTd
	uDYB+0aAyNZzPFH175mwxz3BJqPwv5s2jMDIFqyuCzk3yachMUCiXbgEJ8jtK8en
	njaYIweUasFR54cbpGpZQBUFocRLz5s8kh9dpZYuugDu/kcjgbAi+oQVJXzVSX10
	m3ep0d3TrgIe2Ztc+DhhBlZYS7NN/Eoxj5PGFiBZULVvCKa61/dejSnLQoxSXft0
	GG3q/5uQUXai64IwiZHQl+me8mZPlbGXgWhwqw6OT81Hbq+YIncYXXQrvet+58p2
	c2+dE+wG4tVng2F+RpmLExIqlyKqq/nP1sCVOfettrpnJ++qfwdiICCWSgA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwcc28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:41 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a5005fd0f8so443754c88.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794596020; x=1795200820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiJ2cGdx8A1D88FHZg9zdVy/kI37kSxx0OtiuBRrPMQ=;
        b=dRfFGhZzsFuA8d78CyJngAIpudligNoAZItTJImMyA0TuROlFHWhCdKDeoPSNn0Mhg
         aaPKLMDrmPgtykgBDqHxoiFp1sIZHSHzsh34f0pBOGv4ycnn9WxYxDUmm4MBeNJ7feLY
         vPxGvDePuK7AtI3WS2QwIay54HrUvCBa9hYAwFTYKw3yo0YS90GfkcoaUttKLfCdJiGJ
         6unUVF+lhL5IXsiAMAcoNjJj24VdH0R6UTQ2/SAupjKi7d+7Di3frDLeHCLwjJtK3rti
         UzB9Hwlhd672Qa8L7pTCnLDmgQVNq9TLRtbwlLLq7QbvzS8wy7IESTOQLN/uP0KXuJYa
         1d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596020; x=1795200820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZiJ2cGdx8A1D88FHZg9zdVy/kI37kSxx0OtiuBRrPMQ=;
        b=zR9foTgtkUaGo8sDEFGBYu5VhskV0SGu74BCdUWGC3u1foO6FmbXNohvdcELikRuqM
         stRtaU7gnFLnIsx8fTOkbPoSzTi+6YlUKMYmYaoNfdQbtO3Ff7VaipTeoej4pfJymZAQ
         alfNGGHJsY8W8DuoaRtXR6vOZvKazkH7RMSM+unPA8KljW+9XvEFI2sBfspA/xf7bwrP
         qQ77iXwXqg3x17P9B89fxaLs2BI7yNBj3psRzDYwvoyiXNhqijonkVzLfbisxSzzOqvY
         1zpipEeEckDvynCxRese4Ic1ZQJU6N3ebw/XR0Gqj9V6Qit1ybQDbBNiBfx8X6e748wC
         +y8g==
X-Forwarded-Encrypted: i=1; AL+hErFowQScSoydxfloIns302wZRc5yJWkO8pN2S7/XkOZ4HcpB7xJJ5iS28WOX8RYx623/ThjCgIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PLneYDXWrIDuzg3QLs+DkVZVo/XDVxEYzwJxKoRSETK3/KybE
	7BjNFdoSPf3AqQHVO5fovwnVVWWK5N9RRj70jmTYCFLsrSnVPKcOLjpwm/Q0OwHp8JbKUVwhDCP
	8jNnPVgfMeU1EORg2Ehfix/vc8mn77L77kSDW9maYlcBA2OKIWu+pTXRAnzM=
X-Gm-Gg: AYBFou0BbX0r90JWG+HikLI5I1QfP1K5LZsSZSJbeshX5NNKSl66HulIlmfOGcWfjOX
	j5sIiDMwL/CARDEcsOByB301/Xj4fIEE5hTAC7imPIIVsvndctv22ZcE+TeAbMzZ1/ZFktkHZW9
	axBsQblX5sHn0ePYIKrZ/bexbh8ED9EdTq8rwJ4vH3VKTeGE5JzMI5hoonH3EyngpNPgw2dUMoj
	D4o4RgkCiW4A/2rD1X12ZkgAtOTvwaKLMCsOdbepLS4QpZYjhcEJWRTUGPu1tVYfCGsj7ILIYTG
	4q5tBwfdEv3iowPJhVZjXoCmqcP6V+WS8UbP8wHeGeintl1EScPQFjLo+Yxzy2f/o4zclyumC/+
	Mo1PdiFaf/LN1bqTSBMKG2OAEv98s6xEvRMX3Ys2GTUppJ+rQN9NUVPmq47V6FNoYhzMu+vrVe2
	U=
X-Received: by 2002:a05:7022:b054:20b0:1b3:b6d3:b91c with SMTP id a92af1059eb24-1b50314c8b1mr3584840c88.7.1794596020024;
        Fri, 13 Nov 2026 10:53:40 -0800 (PST)
X-Received: by 2002:a05:7022:b054:20b0:1b3:b6d3:b91c with SMTP id a92af1059eb24-1b50314c8b1mr3584783c88.7.1794596019294;
        Fri, 13 Nov 2026 10:53:39 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:53:38 -0800 (PST)
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
Subject: [PATCH v2 3/9] drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:03 +0530
Message-ID: <20261113185009.157893-4-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af75cb5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=zg618T-2U28-L6wfSYIA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 9ALGF1biWArw8_K0s1-ysG7ROhAZ_ZtA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX4yrsF7UxVULl
 748G4vnQE6hdJr0vUyum4K7NnCma5uoE9UjBwKN1500iCmKX7lF3OHzAAv7s15R/b5DW6EGDB/j
 ze2xqkCwkTgeIUqqM0u/wMuS7yaKzhCD+AXeDn/sJM90gII+u6HFBjyMrKWyc22JOzjl4thCOUe
 5UKULUJvQZkUw9dIhahhNkiOI58+ydQVbFw+yA9fCkJyGezl+NdRZrwsMPVJ5s3nNV4OFvuuwz9
 WGlYGzgQFn1pIkpA6oN5lhx3luu4Q1PepuRTbh8QrxS6e0ts0o7nSrh0GLFyuVzJ+cU4bTQHC/F
 a/NIUaUFveEtnRSQwYBoI9wXbaCodniFCWRAvW+rS1VuD8jv51iS/T5dMu0KdS6V2js+16Zp8eU
 IXhZER18DC9rzhBJm4tMMCiJqo/DVrt8dFxm7nJja5zG69OHccq6UfCqqiPgpki5U5ywtTq9Fsv
 KpdbhS4Wcu0zcOzeIDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX3bmUG3W1IZyl
 QqrJV2u6e9YSjj/sMeRJYXyk/cJbmKLW18XH9UBM18QuR0iis/dmg1TC84y0p76FynEXY+/5rMU
 /uWrcHSUjBfXsHRxBLXX4DIf8AfGdUA=
X-Proofpoint-GUID: 9ALGF1biWArw8_K0s1-ysG7ROhAZ_ZtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075

zap_shader_load_mdt() calls qcom_mdt_load(), which bundles metadata
initialization, memory setup, and segment loading into a single API that
does not expose a PAS context.  zap_shader_load_mdt() also calls
qcom_pas_auth_and_reset() for TrustZone authentication, which is the
intended behaviour.  However, a new qcom_mdt_pas_load() has recently been
introduced that works with a PAS context and can handle everything
qcom_mdt_load() provides, along with additional functionality such as
shmbridge creation and retrieving memory from the shmbridge buffer when the
same remote processor needs to run while Linux runs at EL2.

Replace both with qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
using a stack-allocated struct qcom_pas_context initialized by
qcom_pas_context_init().  zap_shader_load_mdt() is guarded by a
'static bool loaded' flag so it only runs once; the stack allocation is
sufficient and avoids any heap overhead.  The manual memremap/memunmap
pair is removed because qcom_mdt_pas_load() handles memory mapping
internally.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 54f337475231..8e4aa8e22108 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -34,11 +34,11 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 	struct device *dev = &gpu->pdev->dev;
 	const struct firmware *fw;
 	const char *signed_fwname = NULL;
+	struct qcom_pas_context ctx;
 	struct device_node *np;
 	struct resource r;
 	phys_addr_t mem_phys;
 	ssize_t mem_size;
-	void *mem_region = NULL;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ARCH_QCOM)) {
@@ -121,39 +121,32 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		goto out;
 	}
 
-	/* Allocate memory for the firmware image */
-	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
-	if (!mem_region) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	qcom_pas_context_init(&ctx, dev, pasid, mem_phys, mem_size);
 
 	/*
 	 * Load the rest of the MDT
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
+		ret = qcom_mdt_pas_load(&ctx, fw, fwname, NULL);
 	} else {
 		char *newname;
 
 		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
 
-		ret = qcom_mdt_load(dev, fw, newname, pasid,
-				mem_region, mem_phys, mem_size, NULL);
+		ret = qcom_mdt_pas_load(&ctx, fw, newname, NULL);
 		kfree(newname);
 	}
 	if (ret)
 		goto out;
 
 	/* Send the image to the secure world */
-	ret = qcom_pas_auth_and_reset(pasid);
+	ret = qcom_pas_prepare_and_auth_reset(&ctx);
 
 	/*
 	 * If the pas call returns -EOPNOTSUPP we assume that this target
@@ -165,9 +158,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
 
 out:
-	if (mem_region)
-		memunmap(mem_region);
-
 	release_firmware(fw);
 
 	return ret;
-- 
2.55.0

