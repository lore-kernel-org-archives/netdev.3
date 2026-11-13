Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596032;
	b=ikAy3P+SNREfeqm/3YpE+wVQh1F1Ai2zKTTPfm7ulnKJKbPY+0iZsslzMvfl9ZVCB1jc
	 lw8Ue13i6kNfGaBIaQOiqjyM+pyZuZDgfwe2lVRGaSNxuFTO0kjfbHTR4LYFe8bSusd4m
	 Jr442E0KcuQbPPiwfqgIgDZgi9hPDjP/BFlyiT4JjDaGfvA62520gg3JL2Dq3MYXL3/jX
	 PQZQM/QE1yum2nMWcJLQ9dGijHHw6RiBvlvCj5l/NdzaViqwEX02qdjMEox7jMDsbQfpn
	 cJw3WGxr/PqCX1pQapPU3LP+KCVt36buJ5fYKUN/3Hydpj2+13K0I0IlAz9COyzmnHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7/5IBT6uyH8wqYvt8xbeed+YTnT5UfX4kyDmhIwv65c=;
	b=XQFBQ4n6NNmZ5Wcaf9HcFafOYFPAmwGXccvNMDZn/BhexIEaqu2smByqrr3yYprrB3lk
	 bpTr0F5wqnaXCqX6F+8m75lWNuDfegpZyp/XF0LBggRLh8nloMMjnoxWSnIwTrlw76W2h
	 bup4oqFMJMaVvET5qvwvH6UOyEaKAB+AOKcJTygAnsncY90+SnxMibn7sANCpRX1ya+7j
	 5Cyhin7AtBWV66OjpLkCxtww7HXABifYKj0RdCAZfm2tLGTfxlnvNu6zw53atq5gdjRI7
	 JaxikPJiZZsLhBG5ngG6mGtHIBIlIan+uEK1e0xpveJVsP6jVseIZAgJ+NRXuoZynVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=chlWtNlF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dPG4klm8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84580606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84580606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=chlWtNlF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dPG4klm8
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFQxWp2022396
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7/5IBT6uyH8
	wqYvt8xbeed+YTnT5UfX4kyDmhIwv65c=; b=chlWtNlFOsXFLmcefZtYaJNjW5x
	vy4O8EZdPf0zimj6RIz1A1D7MSx6iXjy7hDhXUfl/ad8fAVY2g3nyKLdbIsD/VO0
	fTeyNigeR9xlG2JaYFW3w5mG0fTreYlRb6BR27cUseLWXV8LlCIRgxiKYXva/twy
	xHBqPV6C+MiphHXqXgYfN/lr8EHponBTaA+2nxafx9I/h7OBHHbCxZfFSNyo8qi7
	HNGuwmxpZlhyr56WCuFDE9sBAmtjLV+/GacKnuXMQKi7vllonn0MUvQk7Tic9BLV
	gYqZb/a+S8yUTIGpcPVtN5NgfYidUal/f/dgNlvOCH0PEMi2kX7b8SQbfOQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g21vqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375f0fd31f4so1618686eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794596031; x=1795200831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/5IBT6uyH8wqYvt8xbeed+YTnT5UfX4kyDmhIwv65c=;
        b=dPG4klm8AlnyiSVqib7A3PX1VNCseKJ1gE4D4oLLNmJTnIKSiJ+ooTpcxBMjizsCMo
         /zXp1mJ/KRNL4tk8o0QX9Fi7Zxpgj/YcqIYag6gPVv9skLuyISFwYKMpRVKMVX6igKOp
         jSwDwXbLVuLY21vM+ZlmdR3KqMZm+urIq0GsYJHuCezAc+NPK2DhWG+Cj/Kw2QCubAzN
         oVl3GUVZ8gNtA3r/3yuosY9WYqB4wdnc1SkEBGAyFaDXeoEPniH5cIlx3bQlSy6XkLDt
         2nftTYSZ1E8yJ7+BJiHpCY2YiXCTOnMhTFUVdjhU0QhnoeRfB655fv9DNlg9NHarrRnB
         ofgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596031; x=1795200831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/5IBT6uyH8wqYvt8xbeed+YTnT5UfX4kyDmhIwv65c=;
        b=Hy61ZQOcCkZu6iF/fZd4NZaHYwHqjTr7klYM8tEfZj1B69R66QsHqdIS7La3QxsH0h
         TkGg42+gpPvaT7h6Ub0vGucJJzyznPt8du5vB/8jcZG8fnm5NsPAwoD5hc2T8YWvOCjy
         LlOCugAlABV2MLbLtqgwTAAqE3BZNbf9sKyP1559iNqIb+dKGmOJkJAgJGhUzMuiBR63
         OMkpyD8qAMXw7xpgwLrVu4to3qimLpjTdCJXjqL7SCT4GerrGlq4xMrTh//xGPavm9j5
         VdGoqFKhx2fO0p5Nvxc8bm7Q/QuZzcDr3Vup5+38MVyi134TytN9AV5J1NkiEcDsMJHF
         cAXg==
X-Forwarded-Encrypted: i=1; AL+hErHJqMe+UKTcV2CF37vZWbmRgq7ivEy4OJpE1UEIC+qxXNlIjKLJnXCKiYV6zRNovkvnGgaE5tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rG+K9m5eysl9ktj0acDZOsEQ7MAjS3RRdLKFxZewgMG9kGQ+n
	H4mFmjXs8X+A09wwObZvhMwbSgBqZchRKcQP5OOuEVEV3TkmwmvKdrW3wL/6smyQqFTNdYnkHIH
	lzpquMwEg/SPLlynrq7Yc3E7LQeFVwhq6FJYalODub2RoaWA9EwhKNdeJY18=
X-Gm-Gg: AYBFou3QwuF1HZEY+TIadrXQeIe4xjgIv9JobW+7Iwk2jvRbUkhwJAfP8oNsY5NOJN6
	ODY3O0G5lGwHhrTyKtcUrgLi2PrmVCHaxBVtrHpRU4fMoU7Bk0rOaRufHl4HkYYmFYNSunUUqK4
	qedwevJoxnrG/Dz5kkMyz+5YyaoDvnhVo1mXSR38bx3hPkJs051R1UeM/PhKdYI2bDf1H8ngTcs
	NjBxWRRbIdl4HmACJztAAp0Mz3H4VTSbByMbXEFU+MUR1Jx7rhFFR8nXUwW/fnDpW8hqAWz4qek
	SK51/CiiWiketbjWrBdyeoaRYqrKK3Yb6ZYbD27dJO5Rogtt2j0dLAuXu8SOv4oesqMOveybKxv
	sVr4iS9SxJj0gJZ23CMHkEEWY3d1WlpXAQubVAkjjaBFHqiWTZhcouAd43ztuLQ5wEepU7Dmf5H
	8=
X-Received: by 2002:a05:7300:c00f:10b0:361:1dd6:531b with SMTP id 5a478bee46e88-37967600b2fmr3108377eec.26.1794596030334;
        Fri, 13 Nov 2026 10:53:50 -0800 (PST)
X-Received: by 2002:a05:7300:c00f:10b0:361:1dd6:531b with SMTP id 5a478bee46e88-37967600b2fmr3108341eec.26.1794596029602;
        Fri, 13 Nov 2026 10:53:49 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:53:49 -0800 (PST)
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
Subject: [PATCH v2 4/9] media: iris: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:04 +0530
Message-ID: <20261113185009.157893-5-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX6wSRX58Mw7Ue
 NIGtqDnUHOU+xDued4rxbrCEEC8ooWSytiSUR5FMGZ2LMECJqISUrFyqZ5MBkbSqjnP24Jo03cs
 HmeEe1Ml4XZ7hAGpJq0BxpDrQcMJfXCcvGwBYzmB+cueYivsbMRtlqD4Vn/qOi6Y0AmeYKTXFff
 3GNbxFr4sZMb4kQHeE2Ekm6O+hV1PQjIDDoXjPWx51gRQtCIaVIjVO5KpQe7O7h+kqHVC+xOH46
 i8GfW1cqvmIW0ZsQRI4JVvhAflWl+lOnVeLwptIiLWhdfOaukGitnkOdwXd0UAgXcalKdYNNbey
 7xenE78Tleg8uFI0RbF2LnWRUI4LT3tJ9dv0gwZxBm4mnUPsKVmaetJ1PVqteESwgjv7Ijl4HXV
 L4iv3srVdewXt3r1juJ4e8t1xq7CXDIoQCjd7wmrvAlN9Sl/Jem+bDokHaCAYZtysy9uqcukrNr
 szFsfqoPdfH5Ut7sujg==
X-Proofpoint-ORIG-GUID: dVl7OljjmfMlj5kSEaA5Rs0zn11vsx_-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX1BPKNzf6H+KK
 ZSh3CfN6SGv1kYNKjWPf75ou3CtfwObZEbPFXanHhg9jhvgNT6ylatRQ4PPnGwWyKeBJcin23q6
 t3hT+innivRUbcPzDsqLEiHK3BlmYfA=
X-Proofpoint-GUID: dVl7OljjmfMlj5kSEaA5Rs0zn11vsx_-
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af75cbf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=0taKFLn-hLWpjNWZEgwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130075

iris_load_fw_to_memory() calls qcom_mdt_load(), which bundles
metadata initialization, memory setup, and segment loading into a
single API that does not expose a PAS context.  iris_fw_load()
calls qcom_pas_auth_and_reset() for TrustZone authentication,
which is the intended behaviour. However, a new
qcom_mdt_pas_load() has recently been introduced that works with
a PAS context and can handle everything qcom_mdt_load() provides,
along with additional functionality such as shmbridge creation
and retrieving memory from the shmbridge buffer when the same
remote processor needs to run while Linux runs at EL2.

Embed a struct qcom_pas_context directly in struct iris_core and
initialize it with qcom_pas_context_init() inside
iris_load_fw_to_memory() on each call.  Replace qcom_mdt_load()
with qcom_mdt_pas_load() and replace qcom_pas_auth_and_reset()
with qcom_pas_prepare_and_auth_reset().  The
iris_detect_firmware() scan retains a separate memremap window
after qcom_mdt_pas_load() completes, since it needs to read back
the loaded image data.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  2 ++
 .../media/platform/qcom/iris/iris_firmware.c  | 27 +++++++++----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 3e4cf652bf39..ac73bda072f8 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_domain.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <media/v4l2-device.h>
 
 #include "iris_hfi_common.h"
@@ -129,6 +130,7 @@ struct iris_core {
 	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
 	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
 	struct dma_iova_state			*iova_state;
+	struct qcom_pas_context			pas_ctx;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 21f57d37da18..b701a7f43514 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -201,21 +201,20 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 		goto err_release_fw;
 	}
 
-	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
-	if (!mem_virt) {
-		ret = -ENOMEM;
-		goto err_release_fw;
-	}
-
-	memset(mem_virt, 0, res_size);
-
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
+	qcom_pas_context_init(&core->pas_ctx, dev, IRIS_PAS_ID, mem_phys,
+			      res_size);
+
+	ret = qcom_mdt_pas_load(&core->pas_ctx, firmware, fw_name, NULL);
+	if (!ret) {
+		mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
+		if (!mem_virt) {
+			ret = -ENOMEM;
+			goto err_release_fw;
+		}
 
-	if (!ret)
 		iris_detect_firmware(core, fw_name, mem_virt, res_size, desc);
-
-	memunmap(mem_virt);
+		memunmap(mem_virt);
+	}
 err_release_fw:
 	release_firmware(firmware);
 
@@ -233,7 +232,7 @@ int iris_fw_load(struct iris_core *core)
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
+	ret = qcom_pas_prepare_and_auth_reset(&core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
 		return ret;
-- 
2.55.0

