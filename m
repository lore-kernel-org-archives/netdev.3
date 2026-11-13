Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596084;
	b=Y/jqdMrfKOpgaWInaU9Tq9lSXi7FvZCB1jp+FV8OhpEmo9g6u7tJrZ//qw+wUcCspM4p
	 lX7le0yx6c2+LbFPyBzVf+Xd7V4s1JhtPt3V6eb3bURR3pibUW+1MUZkIgbRNlYNlrUe5
	 1xj1OyZaXDzspoTJ1ds/GFx5z4iPeqmjw9I7UDofOhDd8vtWMAvhtFi8i/ls6kTgSb96g
	 Aai1Pb2c/CRrtnVWDF2oYoUnW4CGrLomIo+D9Ta7TZlpzSiQsEdzcKlwuOpAdrCNrjCZD
	 jzhVEa6b+UCVTmvA/GURuG7QgUH95ejkOmG5t0PqzEQlcc9zakmsStVGAPs7GgU+bmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596084;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sFBq9fRHwG6vJeIthGk0I4jMp83as5rl6WW7bRc8g/s=;
	b=vUI5wPs5vCqEoIiBlZ3nWiOyXXoyBravo3H+3Bh0rcSLSO4dRpXTHFsQkOX5rxbumXtY
	 rTKaUdzDv5SnzaAeJyyXmG8PWIqRiXNwo1EHo+vQeJplBcLZp34igvRqI6Ta9vdfGp0nI
	 A4dTmTAwUIinUksd3bbvo99JORsPCMhMpu0KgEinI6N+EtDbZSq5tI6XYHMPYu6S3cZOh
	 GLf3K6lttL8B/PamyPWgwZdSBdpkRULs5YRccyyr9y0Uvz4MdH0esBM4UQyw662Z+27JP
	 qb9/XMNaLa4doLxgiXlMqPO5r1qSb1+69c9Ge2wKwUj90O6EOY1r9Zu+LoGm+HpIqFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fURUUT0X;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xr7eWkSP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411C606B34F
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E411C606B34F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fURUUT0X;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xr7eWkSP
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR0dt074893
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sFBq9fRHwG6
	vJeIthGk0I4jMp83as5rl6WW7bRc8g/s=; b=fURUUT0XleKiE1C/Vux+befwt+/
	dPsCZuHNQAShw3zqmbbPvnkWmciAMOJmcPPjX/Ypz5i8xGx5igroHMccVx+b153T
	uIpQ7885fRsHjkWRYpoBVsESepqQQcYBw2TwRc+AQxQQzBPmipPxvz2QTuBrcg/U
	fxflhQRaD9AWLlT0VkEyW8xmO8xeOm7gg0EuYPIqqxROMDx8T0RNRi2GJT+72Zzf
	BRyN7VhBSQrTqV5w2Gbr8XxWutaOeSSTe4uIT86yAJhpD14B7KdLcqKJBttPaHBk
	Nu7PpBDZGbwJEUEyWxW2WkQw3GHZ29zfEI+9kF/mEEv+0sfWto/DrsKryPg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwu2mu45g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:54:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so1940918eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794596083; x=1795200883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFBq9fRHwG6vJeIthGk0I4jMp83as5rl6WW7bRc8g/s=;
        b=Xr7eWkSPhxjVpIYSoHEqbWrQpLZ3DxUBabQj491dqLflisNnb4VJb+8xE/GfYaI98E
         JmHgrqvK1yeJXibJ323mWl9WpL9eeQB0re8BhQmdCZPs8z4EVQtsdlJsy+PHYmfjDMai
         IsCl2GVWoJZm/xdEikQPKubSbcTxmMk0+VH70mK6DW0tvyRDVbs5+r5OZhlcNmDDXx7N
         1eoYMZ+Cy6nXHqGzcnOkpIv/YOars2hflxYxh+ACr/+XnT9dzwv6lGwi7HENM4yHetTu
         VQWVVQYwpYRIG4JvzUAhzQ0f2fUWgKIllXu46Ar3DIe8TnbmK+KCtEAyC8e7So+VJd5C
         Sdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596083; x=1795200883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFBq9fRHwG6vJeIthGk0I4jMp83as5rl6WW7bRc8g/s=;
        b=QFAo6h5EV2ajvzgQY9kclXzwjbCoASlEAt56XxwwunhVBn3t41YPRyGTlo52Tidx9O
         C9IHevBBTxJCY9fTP5FQd6Gx1bQ3Waju2KFb4HMPkEd0XcHNkuam+1WXvvh1Qbs08yMU
         dQMX0wdp4j/p5gYdz6DctPbWyWURx3Oc0sivhAG7tzq+dl4xjV6SdVZTlhbFbd331U2H
         V2XvYrn1mRa2Lf4aaxeU4/zkD1JvCrBVBG1iJOvrsHT8/csEhUVlNLBBCmajlV/YoaKN
         rUCvGWLVM4F/QQQ3oymXm8rnMWXqHeOGFHVwLvfGUiWjmF5B5k+7RDW0CU3NoFWUJY16
         l9Xw==
X-Forwarded-Encrypted: i=1; AL+hErFeX7aICxyphw9oIUKGm5Rpz3g0qrFxalPuPehgdPU67ghDwhwXP+6PSG50IHwIRfdgGCuzNns=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H9lWEie13c4DWRA77p6Vx9RRDjOtSpIuEKqKrP6Ka/Tj742+4
	liEFifwIp9aHEaDi+gEVSrVz1v/VGVjv05IDw9pgeghs/lCB+1ByKUqIHbYYuQSvrW7sxZhky8n
	Z32QyFOK547xabKQvGsWqNu4b6nGI4jNmpIhjJUQV+tUW6168kyTAb6XJs+0=
X-Gm-Gg: AYBFou1nkJ2oUB975D6e9Yt1q8hedsE4/jB+cifMkk0t78OaiOfjHkrih92rFKHOgB7
	qKRBcdAjBTKJN2RowAHVyPUexL/3CMJ5YqdCOTvf2vU1BIzFOfeWz8R3YAGST8e0zlQijpiVGbA
	PZ3itno9c93iHQBC3GdG7AzDoIleIWOxGQ8nbNOQ46t3ORh43xaARaSjqesBNeEHRglZMJ+qkO9
	/uqF7CgzJqPb/scH4bDPZjC3mpoLPmKDpbGdDqwnTJm0lTcfFcEdSm/maZF4YVVDCSZmt2f8YvC
	naGAj4ChT/9C+EJIeJ7Kbpf3ooiGmikSQAa/fJuvhLgxG9wxwAVBwMHPrdrlhjKkLQZGHNLc6HJ
	DEKPOAP/t3w/LQo8smqWGcGQDXlHdsTVEbmcTsS2RbOr1PEsSFyh6OOX2anbcisQsG99Spa5Dae
	Q=
X-Received: by 2002:a05:7300:c7c3:b0:377:ee18:c290 with SMTP id 5a478bee46e88-3796676b12amr2938736eec.21.1794596082061;
        Fri, 13 Nov 2026 10:54:42 -0800 (PST)
X-Received: by 2002:a05:7300:c7c3:b0:377:ee18:c290 with SMTP id 5a478bee46e88-3796676b12amr2938703eec.21.1794596081228;
        Fri, 13 Nov 2026 10:54:41 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:54:40 -0800 (PST)
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
Subject: [PATCH v2 9/9] firmware: qcom: pas: remove qcom_pas_auth_and_reset()
Date: Sat, 14 Nov 2026 00:20:09 +0530
Message-ID: <20261113185009.157893-10-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: X9DfLBSoAH1XbvoB5A4qiUW0VYLm_wf_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX3A7YhN2amtiZ
 Lgdeiqw+q0wb2BrxzGh1sdt+0s5hmOhbMarQu8C3xyoooKksjyPvOLKbJYjQP+A08aO72ARR+WU
 qH8cZA6Z13075YMUmm612xCvRnNmotadVuYRgEnOvnnMKAQf0o7Ok1RgsnkgqircO16C3+742Xj
 JmzUe901UHNlBJHqO+bGCLDjnsvgTLQ2o7DrGx7vZ2fHDb8ArIV88QfCy7SfGV2M3yPDyfyY9FY
 FAWOE2AHxZlS+Ca9W9MAaw+Jt3uatp6EMcoQxfkBdSQP3iDr0bQCQDu3up+u8HfXOEEMYBln/l9
 8Qppzvi8ZNirpyUq32lba3mF+TSYo6+WmpMsODoS3EKw3HRUNcdzJlgkiwnfYCh9uuED1xIPtPm
 58SgUhH59/g8Idd5aCg3m4vNK+sDYZddTv3ls1KMDrC9uyJvZrjjJhZca13wIjcK+YyI1Z7ktmQ
 STeXXLeOWeiPAHHVl6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX+hQGyX3eusBG
 uwznOgjqll2oUVP7gIh4qlIAQclLD6rs/p7Y0U4XtzDGFlguaz7izsBUReScXQuriEM9MQTs+nG
 Y6Nec0CCCMG5inZkedkVqgcRTHuZjsM=
X-Authority-Analysis: v=2.4 cv=ddQVTnXe c=1 sm=1 tr=0 ts=6af75cf3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=sV0Ut8U-cAKt8JUqj3YA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: X9DfLBSoAH1XbvoB5A4qiUW0VYLm_wf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075

All callers have been migrated to qcom_pas_prepare_and_auth_reset(),
which additionally sets up a shmbridge over firmware memory before
TrustZone authentication.  Remove the bare pas_id-only wrapper, its
EXPORT_SYMBOL_GPL, the header declaration, the auth_and_reset ops slot
from struct qcom_pas_ops and both backend implementations.

The internal helper functions (__qcom_scm_pas_auth_and_reset,
__qcom_pas_tee_auth_and_reset) remain as they are called directly by
their respective prepare_and_auth_reset implementations.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_pas.c       | 16 ----------------
 drivers/firmware/qcom/qcom_pas.h       |  3 ---
 drivers/firmware/qcom/qcom_pas_tee.c   |  6 ------
 drivers/firmware/qcom/qcom_scm.c       |  7 +++----
 include/linux/firmware/qcom/qcom_pas.h |  1 -
 5 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
index fdf62003fbf1..08bf3a8d3bf6 100644
--- a/drivers/firmware/qcom/qcom_pas.c
+++ b/drivers/firmware/qcom/qcom_pas.c
@@ -184,22 +184,6 @@ struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
 }
 EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
 
-/**
- * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
- *			       and reset the remote processor
- * @pas_id:	peripheral authentication service id
- *
- * Return: 0 on success.
- */
-int qcom_pas_auth_and_reset(u32 pas_id)
-{
-	if (!ops_ptr)
-		return -ENODEV;
-
-	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
-
 /**
  * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
  *				       remote processor
diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
index 8643e2760602..a296be2be8c0 100644
--- a/drivers/firmware/qcom/qcom_pas.h
+++ b/drivers/firmware/qcom/qcom_pas.h
@@ -18,8 +18,6 @@ struct device;
  * @get_rsc_table:		Peripheral get resource table callback.
  * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
  *				reset callback.
- * @auth_and_reset:		Peripheral firmware authentication and reset
- *				callback.
  * @set_remote_state:		Peripheral set remote state callback.
  * @shutdown:			Peripheral shutdown callback.
  * @metadata_release:		Image metadata release callback.
@@ -37,7 +35,6 @@ struct qcom_pas_ops {
 			       size_t *output_rt_size);
 	int (*prepare_and_auth_reset)(struct device *dev,
 				      struct qcom_pas_context *ctx);
-	int (*auth_and_reset)(struct device *dev, u32 pas_id);
 	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
 	int (*shutdown)(struct device *dev, u32 pas_id);
 	void (*metadata_release)(struct device *dev,
diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
index 1fca2712d791..525b8a02ae82 100644
--- a/drivers/firmware/qcom/qcom_pas_tee.c
+++ b/drivers/firmware/qcom/qcom_pas_tee.c
@@ -331,11 +331,6 @@ static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
 	return ret;
 }
 
-static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
-{
-	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
-}
-
 static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
 					       struct qcom_pas_context *ctx)
 {
@@ -412,7 +407,6 @@ static struct qcom_pas_ops qcom_pas_ops_tee = {
 	.init_image		= qcom_pas_tee_init_image,
 	.mem_setup		= qcom_pas_tee_mem_setup,
 	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
-	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
 	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
 	.set_remote_state	= qcom_pas_tee_set_remote_state,
 	.shutdown		= qcom_pas_tee_shutdown,
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 030e4ba90812..b0f96e751167 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -855,7 +855,7 @@ static void *qcom_scm_pas_get_rsc_table(struct device *dev,
 	return ret ? ERR_PTR(ret) : tbl_ptr;
 }
 
-static int qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
+static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -896,7 +896,7 @@ static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	 * memory region and then invokes a call to TrustZone to authenticate.
 	 */
 	if (!ctx->use_tzmem)
-		return qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+		return __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 
 	/*
 	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
@@ -906,7 +906,7 @@ static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+	ret = __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 	qcom_tzmem_shm_bridge_delete(handle);
 
 	return ret;
@@ -987,7 +987,6 @@ static struct qcom_pas_ops qcom_pas_ops_scm = {
 	.init_image		= qcom_scm_pas_init_image,
 	.mem_setup		= qcom_scm_pas_mem_setup,
 	.get_rsc_table		= qcom_scm_pas_get_rsc_table,
-	.auth_and_reset		= qcom_scm_pas_auth_and_reset,
 	.prepare_and_auth_reset	= qcom_scm_pas_prepare_and_auth_reset,
 	.set_remote_state	= qcom_scm_pas_set_remote_state,
 	.shutdown		= qcom_scm_pas_shutdown,
diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
index 458075868bf5..53b8d9631f22 100644
--- a/include/linux/firmware/qcom/qcom_pas.h
+++ b/include/linux/firmware/qcom/qcom_pas.h
@@ -48,7 +48,6 @@ struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
 					      void *input_rt, size_t input_rt_size,
 					      size_t *output_rt_size);
 int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
-int qcom_pas_auth_and_reset(u32 pas_id);
 int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
 int qcom_pas_set_remote_state(u32 state, u32 pas_id);
 int qcom_pas_shutdown(u32 pas_id);
-- 
2.55.0

