Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596002;
	b=a4wFGx84LAniFrDoKbYu01ANTgBVKRuCZ8cpIebuBzQ4ctVPYnpYdR4aLDJ6cKi2KLrQ
	 T5OO32enCVOCo9rCSAmUZ/4tsuqN60R7NvGTt1AC2r5EP0YF5JV3cUYjuLxyTmBjx4he7
	 nF6F71MPWFQ3b6rmrzNLb8GZzZugzC4Cf0smhJG2PytgeMBRVtpKa3jTDpmF8qUg7SQqw
	 RdzzGAgwMoZ5E3xRdcV6RMf2jivog1hcaI5B91x5wlIFoviY5MIQ/iRfqAo10lr+UbHzZ
	 UO/5T3CaKhFuFQneBjqSQDYzirOgyANxFKnlEQhxVhMrgRNuvRp6Kyj+w7YM94QSpAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596002;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Kz3mFGDHm3YL3jNa7eKBXnIcdFzL2ogUPI5D76TH/G0=;
	b=O7ShBvJHuhNrwCZ4+wBXn1AOQ0qVU/sRqJM+xPcifun/IR6NZ2LVx45tYCuukFjPVjkp
	 6zZUljt5EuLCXZOwolKWLHpn2/GpA2pKomyjauK3RB2N1zRCk8fx/gwO3xJh9openZ7UU
	 mVAxP6TG+3sKYmDBzx/il96B8LxB8+h7x9czBO6Ki02yipAUwJ7gF1vNzujaaTESRspj2
	 nk6lUOu6aVwMt+tUVMsk+LXobrFFDbk1Ec/HiJNXkPPmHs1pkpXFGmp6bc6Pa2dSkTJNu
	 +M0EqrPeXm4N6O8oTZvY0ykab8Qv7sSMd3wbZAOPZbRpwOnzIk6aKhCcG1sz+1QXhhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HkPJt1Mn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M1Yotvrw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193B606A889
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0193B606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HkPJt1Mn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M1Yotvrw
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADIrCbd1611645
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Kz3mFGDHm3Y
	L3jNa7eKBXnIcdFzL2ogUPI5D76TH/G0=; b=HkPJt1Mnex7OSeyub8dctliLFSn
	urMff/xho4+9KuVSN2Bo+BeIoscTfRbdl9rpqLpsaeHb+gQ6IvqcFvUOAdD9mM3S
	dQSIXqAfcnTtLccXZz63HzodmTRDoMvuLDElNxh25ME5na/vFTfEm+PiSDmMFXFl
	doT07fDHnAEC+0dUKnq4D/AFKZ46uJQis49y35PuJyDKpgtbuH5BhTfMcGXNHd+v
	lyDVfQky/EpgemZtLok45+BYeqfExpyEeP+UzDB45iogzvx5G53QzM6d3tD32bU6
	/aSkyLD3Qg0ZSPFwCt9jUDxnWL/nkGkd1bcHx/bN8LOPK31STXQiBacWdng==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx87dr03u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:53:20 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3ae17c536so1054823c88.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794596000; x=1795200800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kz3mFGDHm3YL3jNa7eKBXnIcdFzL2ogUPI5D76TH/G0=;
        b=M1YotvrwRcXXn5lG0hu2vE4y9GKAGb2unX+Q1MzgejgVfmF+2pjPXEEy6gb8QBpLcx
         YzrYd5Un1KZir8Nti1SodrFsG2i59julYXxvytoR2TpIQUqlVBzi2PFMr2T2nnIcofe2
         iU+VkmJJD4bxMpzCwrLh8rbehRIK5Ir0Fm4oixPjHK9Z9XA1LwSF96GlMJT9cm/EBrio
         TRArKjcf926wpmrwrwhfzs/n6w/h7Bx7BPx86fj71/kMTZ/fR5QbZpuisQbqx6clTM36
         yBuShsM5nelWernWuMkJLnf4pSmwVCklmQcEc7p7cl8I0IPiONLVqoxIczOSbRPxLIyD
         MG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596000; x=1795200800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kz3mFGDHm3YL3jNa7eKBXnIcdFzL2ogUPI5D76TH/G0=;
        b=JOzybBe4j6Vmrg8muVAksvC6vkhNEU3OJ8nLdqinc5t3zsK5kEK7/uG72o3ubkrr6F
         2PRbdw+iyo1YaaSIGftF9KOFCPWtov2EDoH2KV1PJUFhbAo6Zrk+m7qLBEFiBlncmsqI
         qCoN+Bka1JkE2+jM1rxtCD19BpQWpw8g5rQ1xmvPuqYyaGh/sr5kCVnozXvM7PF4rxLW
         SahlUFIrOR5DzwW/Ks6vsBdwELWgToQeVHTjO2valIjaLqfeQXx/CeVTERPcYTvavbQD
         jHFsLd9gobUu0ycRtrFJsjCpKa4aIcBHe1op68SCpgTIxetQuWVuOa35QDaGzk9M7Mi6
         mqrg==
X-Forwarded-Encrypted: i=1; AL+hErGPmeQ7jli9b0JFOzmp0BZsYXjFt3GgF6KePRYfZFN/ymPtvWyVaZ+MH3B5s6kblzR/84fU2H8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KSx5n4OWrDy6FfUu1ZA0CMeqLkFB7CaW+d2dWiLbGlRk3PjFM
	jr1EypgzydrjFKdt2rCLp2hit0MYqvpHZi6uDWy934P6sQjbAZWBCmawOyJxH7LpMcHE6AL2Iso
	E5AYBO+tlB0x4uS2amiGfU6y/43b0jZEb7QSCl5HOvO0a4UifiRnvQ0Nodbc=
X-Gm-Gg: AYBFou2PIvdPDx4u3E/XNz4j3bMfEilHVTHGwBb7hPVpaju0BaoLnymlBENTS382isS
	wxegzcdqspCy4ShtSLLZwiJN8DvGvZOuGmLPnE7euGEyCNNO//4G5tAZ2qfFHQlnkwj/z/QqHFJ
	ckYbgnXYya3F+oHRWnjhly202H82tp06USW5uVKW1BiZL6j5lNkNlA52NDWPlfHQDlLcLiOBxkm
	MTa7Y02SivKz80wQjuUA8nNg7WMzCePizYVPgv0IBwtH9l8xetNx36sKzqMlMs54PjbzSEMvYNQ
	PygsAHTO+FIKj9DhHe38eJPkS2TZIc3F8JCrx0e8j6YWFadj1P1G2Kccdb6IKRnAaGEIDfb6MvQ
	1ypV8E1eEtCQcsRW+GhiKyTc0GiyvPWFZ+gOuwrSMAntBOYSOR57qtWh10HvMNkc9J7Bv/AkBOI
	E=
X-Received: by 2002:a05:701b:4504:10b0:15c:1679:1cc7 with SMTP id a92af1059eb24-1b50313d80bmr2955482c88.37.1794595999675;
        Fri, 13 Nov 2026 10:53:19 -0800 (PST)
X-Received: by 2002:a05:701b:4504:10b0:15c:1679:1cc7 with SMTP id a92af1059eb24-1b50313d80bmr2955427c88.37.1794595998965;
        Fri, 13 Nov 2026 10:53:18 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:53:18 -0800 (PST)
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
Subject: [PATCH v2 1/9] firmware: qcom: pas: add qcom_pas_context_init() for pre-allocated context
Date: Sat, 14 Nov 2026 00:20:01 +0530
Message-ID: <20261113185009.157893-2-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfXxaPEclZqDd0E
 qoeqqTF9H+Nfk1hgxymKEPNI+Q6TzDOVUy3g+68CdI7ilkgN+AsaAl2OKiUzkgmRWx36X4ptMVa
 n9XUkJrSBkY5APtMsmuBQoUYrLDHnEET1X0IbWwxPpaRi6QOxlwNKpULWue3ZBQ+JfGjzPx9OhQ
 IE9+bmQUdxAT/Eaj/0YmTkR/SJ+BMOblwcWSFVRSoPGs+69R7Wj0O+6MKnwAW0UU8nbWju+QiTg
 37AKMgmb/y7nJrQ0j/tqTp/S33/xj8NSP1Dv6y2R2zTpkweP3tPirTCukocJDuyBz/Xp7KixDiW
 mpgdbLdA5EMasGo9qH3OJwQpzKb/4GMReXQJ6JKMCswlW1t/Y66+TFDspfm2lFMFyLfqzeIM8La
 SLsFHqsVOlCHa9YV0Zjk4V2WBEhfco89VIhyUja9JeuVFO8pJ7ecCKEyrbUX130alRmKimm8faN
 35fyxksGcAufiyTOShw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX2bak5KltseyZ
 8LEWQ34sNKdnmfDHlnB4fN2ojtzgkm9QlYRle0FTZSA4LgNP2vimbQmuflbjIYq6xaYHeHRhSZb
 EtpHeFhGVlWqa8Y1sp2rUyVlW3+Cmrw=
X-Proofpoint-GUID: SGypLd7CfJQJTKMEzMsRAEATAiMp8k1Y
X-Authority-Analysis: v=2.4 cv=BusIUoX5 c=1 sm=1 tr=0 ts=6af75ca0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=O747SXQATtv6IwqlEkcA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: SGypLd7CfJQJTKMEzMsRAEATAiMp8k1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075

devm_qcom_pas_context_alloc() allocates and initializes a struct
qcom_pas_context using devres.  Several callers, however, either live
entirely on the stack (short-lived helper functions) or embed the
context in a larger structure that is already managed by other means.
Forcing those callers through the devm allocation path is wasteful and,
in the case of functions called on every power cycle, causes a devres
entry to accumulate on every invocation.

Add qcom_pas_context_init() that initializes a caller-supplied struct
qcom_pas_context in place using memset + field assignment, with no
allocation at all.  Rework devm_qcom_pas_context_alloc() to delegate
to qcom_pas_context_init() after the kzalloc, so both helpers share
the same initialization logic.

Update the kernel-doc for qcom_mdt_pas_load() to reflect that the PAS
context may now be initialized by either qcom_pas_context_init() or
devm_qcom_pas_context_alloc().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_pas.c       | 26 ++++++++++++++++++++++----
 drivers/soc/qcom/mdt_loader.c          |  4 ++--
 include/linux/firmware/qcom/qcom_pas.h |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
index d74dd7b4f332..fdf62003fbf1 100644
--- a/drivers/firmware/qcom/qcom_pas.c
+++ b/drivers/firmware/qcom/qcom_pas.c
@@ -14,6 +14,27 @@
 
 static struct qcom_pas_ops *ops_ptr;
 
+/**
+ * qcom_pas_context_init() - Initialize a peripheral authentication service
+ *			     context for a given peripheral
+ *
+ * @ctx:	  Caller-provided PAS context to initialize
+ * @dev:	  PAS firmware device
+ * @pas_id:	  peripheral authentication service id
+ * @mem_phys:	  Subsystem reserve memory start address
+ * @mem_size:	  Subsystem reserve memory size
+ */
+void qcom_pas_context_init(struct qcom_pas_context *ctx, struct device *dev,
+			   u32 pas_id, phys_addr_t mem_phys, size_t mem_size)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dev = dev;
+	ctx->pas_id = pas_id;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_context_init);
+
 /**
  * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
  *				   context for a given peripheral
@@ -39,10 +60,7 @@ struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	ctx->dev = dev;
-	ctx->pas_id = pas_id;
-	ctx->mem_phys = mem_phys;
-	ctx->mem_size = mem_size;
+	qcom_pas_context_init(ctx, dev, pas_id, mem_phys, mem_size);
 
 	return ctx;
 }
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0d55e9e0af3f..c6ec67e1da09 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -476,8 +476,8 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
  * firmware segments (e.g., .bXX files). Authentication of the segments done
  * by a separate call.
  *
- * The PAS context must be initialized using devm_qcom_pas_context_alloc()
- * prior to invoking this function.
+ * The PAS context must be initialized using qcom_pas_context_init() or
+ * devm_qcom_pas_context_alloc() prior to invoking this function.
  *
  * @ctx:        Pointer to the PAS (Peripheral Authentication Service) context
  * @fw:         Firmware object representing the .mdt file
diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
index 1d132e89536e..458075868bf5 100644
--- a/include/linux/firmware/qcom/qcom_pas.h
+++ b/include/linux/firmware/qcom/qcom_pas.h
@@ -36,6 +36,8 @@ static inline void __iomem *qcom_pas_ctx_map(struct qcom_pas_context *ctx)
 }
 
 bool qcom_pas_is_available(void);
+void qcom_pas_context_init(struct qcom_pas_context *ctx, struct device *dev,
+			   u32 pas_id, phys_addr_t mem_phys, size_t mem_size);
 struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
 						     u32 pas_id,
 						     phys_addr_t mem_phys,
-- 
2.55.0

