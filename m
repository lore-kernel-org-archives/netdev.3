Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DC3CA4A1
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789873393; cv=none; b=cNLOGYOutmWPpTx1J9HVzjxw045eaav9W766tC6wTd7jUAO859MZkrz9xQ31bcylILquEa6P3XX+9lSu+H8qK9/Z4k/pqe2C5Jthl8f9QEV7twEu1Fz6UWMOVttb2L1jrx/WFVehM8cxEblcFU6eD+tN+kIIG42+iJTlQAsvNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789873393; c=relaxed/simple;
	bh=Bq/8VmaQSvu+teA/tFUI171RAyxDvtCGGxirmcY7iUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntkyp3a25cXy+jJBBRc0BYdkVxjQ/NfkCXSA9rD7c/ZZBJFC3Pr1vGw28xBzo/KS2WPcuMHfVepEQb82S/1/YfS7QAiTWpftR0LtqgvkXUbQQDZbFFAlD5C3qmUWxvRE23rYGuYztszJGRo2g8zWZHJ9nip/dMRUVksoMSeOREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gEHbS9A8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eG93WmLV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gEHbS9A8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eG93WmLV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K1mlFT1548617
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 03:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wbay9s7L/3DjQbxdGg9nUGIW09JsDVO9pV2U2d9vUdU=; b=gEHbS9A86Urt70cp
	1zKXkUtcmPX67jITq/M8DsUMUzXG46Ui9JpqnvhiGVS1nymd7cvuMnCvb5SCPEJ+
	Tc2o/P/DZpZ7AGRIDVOxrHb/ctfk2l36GalBE0xhsSdQLdOEtaakuOXWF9tqNaX0
	GfVYeYlCbkKOKa2ekl15/JSxHSAdSqog28F1n7xPOJAShGyrwbUctioYVPh+rxmq
	ap+7jQKpOUnNTvJFenCDPuGPehvMP5ERZmSPppY5wsD/DYG4nkPLBOk6ZKMUPztm
	H334gI7fh7TFmafCXFamwkZcfOtM0O4V8PzLKh9WTNl71EwotMh3zt9eRxBDUtdL
	tVK9Uw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshd627ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 03:03:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so2638652a12.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 20:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789873389; x=1790478189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wbay9s7L/3DjQbxdGg9nUGIW09JsDVO9pV2U2d9vUdU=;
        b=eG93WmLVZqwGfMic0yMcoEMV3N7Lhb07VeQPaG/cCN2hhUzOcP1fo3iasPHvXUmNtc
         cDGOZHGHNl8foT2Bp74dIt5ItyEuqE2enmtU0nvvy32Pn+hl8k+dHWy/EIz0aGSIs0Cf
         E0ilwPdBsTupdQaYan/H31haeuZdj3vVMeZhapYrB+388DIwt+3yOvsPmkUFPmvzkGxZ
         QSjes5v9CfhPYfq90QZIav+Nf5kRH5HTwfupaMpiYqhciDi7vrNkjQFo4YNkQIq+rMCW
         jxpwDpmvcITCeSOGnzWXD4mpAE83rYN3rr2t7TLJkY76jpscr4Q41ySzGbqegNkSJ7RP
         rWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789873389; x=1790478189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wbay9s7L/3DjQbxdGg9nUGIW09JsDVO9pV2U2d9vUdU=;
        b=OdaDEY85IqB7M+KA7za24VlCoCY+CYb9/mJ3Y36BsKrxydCi9TzJwIzmoKo3phPFnm
         6QZWuS1HGFZsMaRg046A488KuUJ8xKaIRgyvKh8n0ThCuik+z4GML1Acv4p4mFu3jVJV
         VVkow6y/vYJfM7chSTTQnPpiaGPZXLYs0jGcnEWftJI5kKbLxNay7oGiPkME+Z1BQ/Ig
         +HZGN7PmNYBAFY2B1XnUENUuwUq2whAYq4U6MkEAkD30tQXbNHQ6Oeu8NHtwcAJ+6sCs
         XTwkuTbvJra4ihtPCN68CsWe/Kqq0ur8Y7d7dD9VL6PMX8Rx7wFbls871AWkjvsExUjG
         /1fA==
X-Forwarded-Encrypted: i=1; AKwUvBygz7o4Koy4BFOsglXMR0P6TXetIVZ6DjUfFA9eCbmM05dPgmrJormw8kxEgn+DVdvjUFSpDzU=@vger.kernel.org
X-Gm-Message-State: AFuF++nnRUuJAdIcerxF0X/XvKDPtemoMYiqPM6MH0c7q+8czacPSP6t
	v4VLxsdDEEKYccxVa6pyDeukFbrj0+uO7yMPkoFhJSXp9PhLRHwBih/Aon+GnfeAyU7GHDGeKBk
	a5e4mA8mDX2plgxpT7HWhqBAvSREZZQi4tf46RmElBrNXiZoyF2s2lneW1Ps=
X-Gm-Gg: AYBFou1zEeQyu4w9ZF5zKVj3dsDc2DiWh6bwQhJNr1imeat5w+oeNye2mt9wK7+fYwd
	ZHDykGTpWHBGSTbI/95TlowQb6mFnZDYgS3Wv+iUAUA/7C+bp0d7AbNyRmTS3f3JNJJHLtpeoRo
	oM0PKn9pvZgzj2r9dT5A+4sPI8g2LWndbLNBinYOP6Vy9lWZRnFIVIXlelNEaHkJIR+YGPqllOb
	Sw0/NPNE1eixBUBKXnqhKg4BHJJLd9i7zuOISeXvHxpE2p1uqIWkbZK/4lJ7ZLiAmsiP/UpGfrs
	Oocu1Wv6E0OkOWsgD8Vuy3EyaYu+Ob8iIntKhY0yd+HDiVTWKUsUZxJjrIEG63ygz5nr3ov6Y/B
	zP+PQphkGVQ+hvRnBOlQrNI8zGUE7zlio684q
X-Received: by 2002:a05:6300:2208:b0:3dd:a197:cf1d with SMTP id adf61e73a8af0-3dda197d752mr5106229637.65.1789873389372;
        Sat, 19 Sep 2026 20:03:09 -0700 (PDT)
X-Received: by 2002:a05:6300:2208:b0:3dd:a197:cf1d with SMTP id adf61e73a8af0-3dda197d752mr5106187637.65.1789873388812;
        Sat, 19 Sep 2026 20:03:08 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144e14dd04dsm90012c88.7.2026.09.19.20.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 20:03:08 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 08:32:30 +0530
Subject: [PATCH net-next v2 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-qcom-bam-dmux-vmid-ext-v2-2-ef5ca2178378@oss.qualcomm.com>
References: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
In-Reply-To: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
To: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789873371; l=6606;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=Bq/8VmaQSvu+teA/tFUI171RAyxDvtCGGxirmcY7iUY=;
 b=HrvaXyZvnGeDk3tyNWWY4NVpXJ7/rHHq6zd6/NwJ0v32xceEJfWIW/JOBDvxUeb+VZlh5g0xA
 1DmmrBf/7x8BFyzWgH7sWLr8HtZDXrsivnmykWP8d1GS1RMJLZ2OX4T
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDAzOSBTYWx0ZWRfX1fxO2pkEN3dX
 hBmZzNJRo2DpiMlFQ5eKh0mrbDXitZuY1+Nk9RpvcNAY6YPtTMw29wLKYRu8X1Hq5uNTycC0sSb
 W5P7lEPqbfRFua6hYOOeOW9JZFdQm1P2VNzsCydKRuK8BtAt/Q/tANDgT4J/rYzjZ7PEP07XTxf
 UN1Y2Xovmnzl2ZK6mNY/0ppV4jjdXrU4pC13a5QGHr9hNM83TwQ+e3tto8rUTKeU32g4Eoaphcz
 Xjvl8MlWxLEbdltfJRAGLXuXM1Xg87jZjKH4F3TFw1lx6DuIgSERzN03m3F6OcBTPAYJ7HJ+7Tp
 SvZ7l/E7gTcW1mG1f2cfMWZJpNU6Ga4RZp/65sxKndGYjWJp099CRFh+8+mqY30pW0kXboB92Ny
 EgpBZhEvmOdUMIZNZyENHKsbNNrT4RCCtZUF0pvElbp4kJxgpW0wqon+khSgQReD2EijcvDJICs
 B91PVtqk+u1Ln90WlFw==
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aaf4cee cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1SZFiLht8NXrNnb3tK8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: POPZ2Qee3nOD1FI4sERzfbM-bpA4OZ4e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDAzOSBTYWx0ZWRfX5NZ7kIDoq7Lx
 4/4R4/hUDKKHKAHtoTkiraLnpWzoxSYi69Td1vQn/E/vSH/9TsAGVeEKEAUYceCj9Uj9r68exZK
 HjPBEe7W0f9LPVt0G7VnLl46GEwiPAM=
X-Proofpoint-GUID: POPZ2Qee3nOD1FI4sERzfbM-bpA4OZ4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200039

Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
domain with restricted access to system memory. BAM-DMUX DMA mappings
and BAM descriptor FIFOs must therefore be constrained to a designated
memory region that can be shared with the modem. Accesses outside that
region can trigger an XPU violation.

When qcom,vmid is present, require a restricted DMA pool and assign the
entire pool to both the local and remote execution environments before
requesting the DMA channels.

This ensures that BAM-DMUX mappings are within the assigned region. When
the BAM DMA controller references the same pool, its descriptor FIFOs
are covered by the assignment as well.

Track the assigned execution environments explicitly and reclaim the
pool for the local environment after DMA channels and mappings are
released during remove or probe error cleanup.

Fail probing when restricted DMA pool support is unavailable, when the
VMID property is malformed, or when memory-region does not reference a
restricted DMA pool.

Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
 drivers/net/wwan/Kconfig         |  1 +
 drivers/net/wwan/qcom_bam_dmux.c | 95 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 958dbc7347fa84ee869439bf8b503037faab8bef..1b133c56231615269698140187ca3141dfe48dbf 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -65,6 +65,7 @@ config MHI_WWAN_MBIM
 config QCOM_BAM_DMUX
 	tristate "Qualcomm BAM-DMUX WWAN network driver"
 	depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  The BAM Data Multiplexer provides access to the network data channels
 	  of modems integrated into many older Qualcomm SoCs, e.g. Qualcomm
diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8d64371eb8d00c638a39b234ee540b83c9..c81e668d4e961a645f7e2d823c3136845f086b08 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -9,10 +9,12 @@
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/if_arp.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/smem_state.h>
@@ -75,6 +77,9 @@ struct bam_dmux {
 	struct completion pc_ack_completion;
 
 	struct dma_chan *rx, *tx;
+	phys_addr_t dma_pool_base;
+	size_t dma_pool_size;
+	u64 dma_pool_perms;
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
 	struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
 	spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
@@ -762,6 +767,90 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
+{
+	struct device *dev = dmux->dev;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+	struct qcom_scm_vmperm dst[2];
+	u64 src = BIT_ULL(QCOM_SCM_VMID_HLOS);
+	u32 vmid;
+	int ret;
+
+	if (!of_property_present(dev->of_node, "qcom,vmid"))
+		return 0;
+
+	ret = of_property_read_u32(dev->of_node, "qcom,vmid", &vmid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read qcom,vmid\n");
+	if (vmid == QCOM_SCM_VMID_HLOS || vmid >= BITS_PER_TYPE(u64))
+		return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid %u\n", vmid);
+
+	if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "qcom,vmid requires DMA_RESTRICTED_POOL\n");
+
+	rmem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!rmem_np)
+		return dev_err_probe(dev, -EINVAL,
+					     "qcom,vmid requires memory-region\n");
+
+	if (!of_device_is_compatible(rmem_np, "restricted-dma-pool")) {
+		of_node_put(rmem_np);
+		return dev_err_probe(dev, -EINVAL,
+				     "memory-region must reference a restricted DMA pool\n");
+	}
+
+	rmem = of_reserved_mem_lookup(rmem_np);
+	of_node_put(rmem_np);
+	if (!rmem)
+		return dev_err_probe(dev, -EINVAL,
+					     "Failed to look up restricted DMA pool\n");
+
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	dst[0].vmid = QCOM_SCM_VMID_HLOS;
+	dst[0].perm = QCOM_SCM_PERM_RW;
+	dst[1].vmid = vmid;
+	dst[1].perm = QCOM_SCM_PERM_RW;
+
+	ret = qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
+				  ARRAY_SIZE(dst));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "SCM assign restricted DMA pool failed\n");
+
+	dmux->dma_pool_base = rmem->base;
+	dmux->dma_pool_size = rmem->size;
+	/* Track the destination VMIDs explicitly for the reclaim operation. */
+	dmux->dma_pool_perms = BIT_ULL(QCOM_SCM_VMID_HLOS) | BIT_ULL(vmid);
+
+	return 0;
+}
+
+static void bam_dmux_reclaim_dma_pool(struct bam_dmux *dmux)
+{
+	struct qcom_scm_vmperm hlos = {
+		.vmid = QCOM_SCM_VMID_HLOS,
+		.perm = QCOM_SCM_PERM_RW,
+	};
+	u64 src = dmux->dma_pool_perms;
+	int ret;
+
+	if (!dmux->dma_pool_perms)
+		return;
+
+	ret = qcom_scm_assign_mem(dmux->dma_pool_base, dmux->dma_pool_size, &src,
+				  &hlos, 1);
+	if (ret) {
+		dev_err(dmux->dev, "SCM reclaim restricted DMA pool failed: %d\n", ret);
+		return;
+	}
+
+	dmux->dma_pool_perms = 0;
+}
+
 static int bam_dmux_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -796,6 +885,10 @@ static int bam_dmux_probe(struct platform_device *pdev)
 				     "Failed to get pc-ack state\n");
 	dmux->pc_ack_mask = BIT(bit);
 
+	ret = bam_dmux_assign_dma_pool(dmux);
+	if (ret)
+		return ret;
+
 	init_waitqueue_head(&dmux->pc_wait);
 	init_completion(&dmux->pc_ack_completion);
 	complete_all(&dmux->pc_ack_completion);
@@ -845,6 +938,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
 err_disable_pm:
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
+	bam_dmux_reclaim_dma_pool(dmux);
 	return ret;
 }
 
@@ -879,6 +973,7 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	disable_irq(dmux->pc_irq);
 	bam_dmux_power_off(dmux);
 	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
+	bam_dmux_reclaim_dma_pool(dmux);
 }
 
 static const struct dev_pm_ops bam_dmux_pm_ops = {

-- 
2.34.1

