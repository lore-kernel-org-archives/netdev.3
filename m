Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84A35C690
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649923; cv=none; b=ROwVvN6CKBADJVmPzrDH9gtVQCgiseRUnr3fzoyJKCGNUcN1UDt+mj3bG+vYXseCzyofSuwgOJaq4AGsSQmzXvmp/qp3B/G8TwwNcIVCtlZj10R4rcCj4to0pMHCWOGeWOwnKbO5RvL1dtDXv84Wk+hIdKWOE+b8kFuh4iib1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649923; c=relaxed/simple;
	bh=/rlQznmIecDQqWElo9v5bCG+v85dzz5/R12HC9qdMh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MeX+lKVD10AMEQsj1X5UB4QZrAyaXbp+qgMTZrUCr64Z40gwEgX9ws786iYrkpq1SrX9MRIADgoZO9lZQiF+Oiy37qbatg31dYnhzbxG8MhIzADI8MsMd544ko19m05DlVjMj9BcL/UykuvY+fdsnk73GLlyLXf2YEHYRJwhtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TsjMiogK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j2LXJP+8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TsjMiogK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j2LXJP+8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88R4x1359569
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M+zmB4FaBxQwRnntc4G0vf
	4U+IcSlAlvto72WrWto68=; b=TsjMiogKQTLeqCIy9ijYWYZxjByT/yky3VbR9s
	iFriS8DCHasxY6yx2+bYvzcUovO/5GfGUEZTYj31dIO7kcSqOJpk1jlyuiEpR2AO
	OZZUNbK1iziFoVzQotZWVtUatDZ7tTGbvRWRKyTNtMm1eZbT5KIOKEIMg+gfaYLM
	14EoM9StPukICt4D6YkElgXehVG8GRD89FrBwxT/FQEPSlgWOOKP9/tmtmZ33lRL
	Jj+M0j1xZB4Ki0T81M0oRKK4jg9NsYMRkB/lbWf4SKB9L/IXGZV1kf30iXJQYPnb
	xT3oXpSXLQLYtcQX6ldBqwYu2eq27FHSRfxn6dgWowvneZGA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8swy38b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:25:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1c7f135bso80126741cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787649920; x=1788254720; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M+zmB4FaBxQwRnntc4G0vf4U+IcSlAlvto72WrWto68=;
        b=j2LXJP+86cqGxZNYq2Oc3RzrNkGpp2mLoyGCqCT6Zql7W22tW/j2qGsuh57XugABgI
         OERG5JzxAHSsXUbWZw7Vn30ZETfweR0HX/faQaal/JGg8lq6vALPYv5t4aNw0RrQ2N1b
         4sG61R52rvKgcV11iE4H7no+Wdvk3HmQnqtclJUg31TVsQbZHJKB/VUKNYRdTZuMq/OX
         ouuA5UUhuBpj/Tyw8T+vKAttXfWNPiqSRZz+q/r+eo6ClTKcHAWYfW25JCj9FnnAOIgZ
         JcwaJssFJponylFSZJfSPWtvuwJEGJNBjlw4P2blqyvyiBgnvgKbaJW0y5SPduwhJ+3k
         GR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649920; x=1788254720;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M+zmB4FaBxQwRnntc4G0vf4U+IcSlAlvto72WrWto68=;
        b=QWESvjGVn5Z7Qsd7A+a8pPhhs32jpiwKLPN2Iyik2lfi2gTX8dqPKysSDsRDHQUdNP
         13aflCiZuF2AQLFqBWRiqO6oCzl7coXwxiIORbqvxRrKL2eCQ4uwYkVXLQAalnncjEmG
         DzVtKkmpJjkNAU24bMU1fg7uZ30VjYv9JW5pIyqSen7ctIxPy7wFFpQsrh2S9tRpJFDZ
         7JVFSjV9y8IsHoFwVzGjvv71p5jizo6VHbLYQjcWtP8cz9SSchxAsNYO9Rs7Gk3YVULF
         PEV0ZD/2ovikrQP0TLWGtq0B42V1lk+Ub7wY0g+hq6SmLi7TzOCd5XMMzjWwwbS3sv9Q
         lMdw==
X-Gm-Message-State: AFuF++nkjqYb7VdcEjFrDVVc+qcFPhhRGHzxKV+bjdJNA/WvjK/sshzM
	/RDQ8qG/HTaOmeqr4vJKe7gneXLKt3MBPCjXPNk9ca+l5vsWd9IkKRjZXj+OEkPAid3Be1gcb5N
	oeHpi5/s4o9i7zdhuwqLxj5TI9E2yqfighwYY0QePxSVo64kmY2nkafbLL7A=
X-Gm-Gg: AR+sD13X/qFJiyYg/BB7weMy+VNTlqxUFmBS4P1HM/VJdqPnAdgvYuVc8lKn9RP6EbW
	Lb73Nvqkb4JMPmurNWAtSPBaFmmISySpbYXqJQDIiPs9S4+/pzJqL4DV665S6yQMRKgW30+EmL+
	gdXY81c8bcPtxashTWYPcdVK3I5WgCqaP318MDhTO/bJintUySbXO5MtGBeM7+ZundlRk5OCqhY
	bJEcuqTsNvdVr023OLcjGWYR7oqR0Pr5QDlQLg6fBBEac/0egeNEbTPPadPcHReBjIBn5Z3aQR0
	yohTXsKuuNFHhLOjPOs04wvmAjCgNqMGDdKBbdyLcFfS4vfO/FToY7qmLKhj16xxchQhEgPJ4wm
	mpni9quZyoUuvfg==
X-Received: by 2002:ac8:5cce:0:b0:51a:6feb:dc8f with SMTP id d75a77b69052e-52e2f05e946mr60063521cf.9.1787649919772;
        Tue, 25 Aug 2026 02:25:19 -0700 (PDT)
X-Received: by 2002:ac8:5cce:0:b0:51a:6feb:dc8f with SMTP id d75a77b69052e-52e2f05e946mr60063151cf.9.1787649919356;
        Tue, 25 Aug 2026 02:25:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm1781846466b.39.2026.08.25.02.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:25:18 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 11:24:57 +0200
Subject: [PATCH net] net: stmmac: re-apply taprio offload in
 __stmmac_open()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrCMBAF0KuUWTuQBK3Fq4iLsf3VAZuGmSBK6
 d0NLt/mbeQwhdOl28jwVtc1N8RDR+NT8gOsUzOlkPowpCN7XRYZGV7ZIKW8vixzhfFakDkOcTo
 HiSfce2pHMcz6+f9Xyqh02/cfrBRr1HQAAAA=
X-Change-ID: 20260824-stmmac-est-reapply-after-open-181d70a15eb6
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3OSBTYWx0ZWRfX4YnZ4iRT/2N+
 SjFSU3Xm2dxzyEeVtMIZeUxBaKpO/6C0n96AUGzylPPPN2O8dbvIC9Q6YeSQyHzbsPmYBXxONAk
 Onpz4kepTmMAs2Ss6bQxhQzkUvdGsLodCtRO2YhmszB0xYxK/3PYDQyuMf2YoAHPfBfWeafbYyF
 iPY/hvSkob64Ugl7sz4Nx6K0DuCQ+XiK8MFDqZMUXXbFUojz4Bs0CQx8ENnue358MkzEvJRrcKw
 njXJ23F4g1qkl6MqWXrazqpIujBa6nfwtKG/yfVUq60TesE0gvsRECHQnQ1ZcmufpAxtKubHYbo
 p07oaXmeafVHWHyOdKEL20bwtB06VUFR8pOfF92fsdN7puPgnJkT3ep028OYm7jgTZj3FWE93R8
 PvwTQMjoDvLo7jM2Q6KydfKDFoS5VTrvYr90iorN4NY2EPdwp+VQF1rlgpvLFkENhxEEauT6vpf
 upYyFD+CrwvXzEeoAzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3OSBTYWx0ZWRfX7qfK7ZDOJtie
 XNO+4dPmCvZvGML5tR9B9v/l7ovT1UsTYx7lE0Ys9OGpY0VJRmEG/WgDmZxu45SCZEImbkuFySe
 lfU+fME0eALcZq5+WkUfUxRtT0t7dqs=
X-Proofpoint-ORIG-GUID: Agob9ICCwCo6aGq768ho0W5_zCPZFEuR
X-Proofpoint-GUID: Agob9ICCwCo6aGq768ho0W5_zCPZFEuR
X-Authority-Analysis: v=2.4 cv=QIlYgALL c=1 sm=1 tr=0 ts=6a8d5f80 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JpBpa1p7AAAA:8 a=koEEtHZmf8gcZ7dLqiUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=YCh05so4W2E6r1tszMC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250079

The core soft reset issued in stmmac_init_dma_engine() clears the
MTL_EST registers, but nothing re-applies the taprio offload after it:
priv->est->enable stays true while the hardware EST block is left
disabled. The TX/XDP paths then keep dropping frames larger than
priv->est->max_sdu[] and taprio is reported as offloaded, although the
EST block is not programmed.

Re-apply the taprio offload in __stmmac_open() after PTP is up. The
base time is recomputed from the reserved base time and the current PTP
time, since the timestamp counter has been re-initialized and the
previously programmed base time is stale.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 28 +++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 26 ++-------------------
 4 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index afc516059b89..594f61c07dbb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -80,6 +80,34 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	return 0;
 }
 
+void stmmac_est_reconfigure(struct stmmac_priv *priv)
+{
+	struct timespec64 current_time, time;
+	ktime_t current_time_ns, basetime;
+	u64 cycle_time;
+
+	mutex_lock(&priv->est_lock);
+
+	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+	current_time_ns = timespec64_to_ktime(current_time);
+
+	time.tv_nsec = priv->est->btr_reserve[0];
+	time.tv_sec = priv->est->btr_reserve[1];
+	basetime = timespec64_to_ktime(time);
+
+	cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC + priv->est->ctr[0];
+
+	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);
+	priv->est->btr[0] = (u32)time.tv_nsec;
+	priv->est->btr[1] = (u32)time.tv_sec;
+
+	if (stmmac_est_configure(priv, priv, priv->est,
+				 priv->plat->clk_ptp_rate))
+		netdev_err(priv->dev, "failed to re-configure EST\n");
+
+	mutex_unlock(&priv->est_lock);
+}
+
 static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index f70221c9c84a..fcbee673f2e7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -65,3 +65,5 @@
 #define EST_GCL_DATA			0x00000034
 
 extern const struct stmmac_est_ops dwmac510_est_ops;
+
+void stmmac_est_reconfigure(struct stmmac_priv *priv);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efa35cfecc4f..d71d430519d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -48,6 +48,7 @@
 #include "stmmac_ptp.h"
 #include "stmmac_fpe.h"
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_pcs.h"
 #include "stmmac_xdp.h"
 #include <linux/reset.h>
@@ -4158,6 +4159,12 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_setup_ptp(priv);
 
+	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
+	 * registers, so re-apply the taprio offload after PTP is up.
+	 */
+	if (priv->est && priv->est->enable)
+		stmmac_est_reconfigure(priv);
+
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 960249960004..3682c9d3f3ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -8,6 +8,7 @@
   Author: Rayagond Kokatanur <rayagond@vayavyalabs.com>
 *******************************************************************************/
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_ptp.h"
 
 #define PTP_SAFE_TIME_OFFSET_NS	500000
@@ -55,7 +56,6 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	u32 quotient, reminder;
 	int neg_adj = 0;
 	bool xmac, est_rst = false;
-	int ret;
 
 	xmac = dwmac_is_xmac(priv->plat->core_type);
 
@@ -84,30 +84,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 
 	/* Calculate new basetime and re-configured EST after PTP time adjust. */
 	if (est_rst) {
-		struct timespec64 current_time, time;
-		ktime_t current_time_ns, basetime;
-		u64 cycle_time;
-
-		mutex_lock(&priv->est_lock);
-		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
-		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->est->btr_reserve[0];
-		time.tv_sec = priv->est->btr_reserve[1];
-		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
-			     priv->est->ctr[0];
-		time = stmmac_calc_tas_basetime(basetime,
-						current_time_ns,
-						cycle_time);
-
-		priv->est->btr[0] = (u32)time.tv_nsec;
-		priv->est->btr[1] = (u32)time.tv_sec;
 		priv->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->est,
-					   priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->est_lock);
-		if (ret)
-			netdev_err(priv->dev, "failed to configure EST\n");
+		stmmac_est_reconfigure(priv);
 	}
 
 	return 0;

---
base-commit: 2db9bfa3e27bdea15e05ea70b56bad3d21e570ec
change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

