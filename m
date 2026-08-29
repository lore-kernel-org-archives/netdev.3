Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5521D4606
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997419; cv=none; b=XXRgLkXuxkwli6FyINaelG/Io32Qax5skIqCBRz/QFI1tAOhzl57ZqaA/eiEj6l+3ZFEQl9fSAx6aBbXwqeutXYx6PxmG/ouQ+GBRdnm+oYpgw/mp9oKjkBQWijja5kSLM73OHxlOn4Na80Rp/vzmwRwkGNcARkec8EXi/fCzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997419; c=relaxed/simple;
	bh=tiv1H7s/1GYn4T9yRyDeoJO06NVr7/tNVolqS/2JgTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ADtBsx06ZOu180Obi+viTOoxv4v8i4L/hN0k3Ty70Qn7lS5tYTlAo+ydIu4YbUbnEJ7T+54qlgTSaEUUnZma7hJn/0cqsmh8cye277nS5ePferraQR0gx1mbELfYXmDtU745bbZprnF7IHFHxWON24aSy/5SucMXcaDU8YLk0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UxwG/I2p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e691WoyA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxwG/I2p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e691WoyA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T802fL1353069
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 09:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=roPEVsoQUhFBjB1PneBAof
	XRNLn5gkvGNPkS1bJbndI=; b=UxwG/I2pScGjdD0Y/5Zg093L9A8xhOsplkZSfo
	yNQFBMcZcHx0Ca7zhYBRWs8eIqsqyBObC89oUZ6OqFT4QPu8uxER8HOZOTBUMrg4
	P8UlkH+e6mxqLUApyb/THHyq2VJiuLHw3vMEAbWjTS21rrRQLMUfYVoMAqnXas1E
	b0/qhuc9H1AEvFylW9jTpiFfbw1xAcHLLOJNaHe4lXC6kmXRUBRud2TxVEyPzJ8e
	UL9sOEk/3ds0jCZoWhVnPexw+zW9lM9GwPqh/wMAS4QFMcctLHISihBoCg01crlg
	yh4UkOCXPmGKf5k3CicoSacZmFUKCYq8TAZLz1RBrMxIop6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhw8nr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 09:56:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ffe24490bso4166331cf.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787997415; x=1788602215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=roPEVsoQUhFBjB1PneBAofXRNLn5gkvGNPkS1bJbndI=;
        b=e691WoyApgUs1Mwx9jC3nRALbu/1jsZG0nU1Ajs87fqWGOFoyZ9+41gadJQ8cHw9De
         VMIdTgMU9rz4wBCNNYlknhZ2AthKwXpcYBrpflJ8QyVCRpQMp81jgmOoC5MHnkTz+lhk
         ulOUQpvXQDCaXN92RoGeeLQTnKBwV5cMzBIanXvcDFHLQaVR4Q5ufEXlkKO9obH7S1e+
         P2kUtse3aLJeRItdQsmJGWVfcs9lyNsc2MVi6u5p3EjrFuKuoUE5NgZ9ZhDTstkSoG1/
         HgnKt/jOwyACNFARMAEIORG/esTDkc7HUT91egyCzzUH4HOoAAfMgVG2VX2HkTH78KKN
         Wvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997415; x=1788602215;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=roPEVsoQUhFBjB1PneBAofXRNLn5gkvGNPkS1bJbndI=;
        b=L3n4xDhqHSMGGazZ/hFIw36Ppe0TGKx/7xyaX4SescA27tE8AN1wuUQdpYQwEFOhSC
         XDEsVkk8nw9rRTTjX21hJ17a17dgHgMpxxb0yyPyygVOVm3pO1geJMoMAN4UB/ZcOKin
         ePVoWoEsyphPAo/As6nozKvSlLk0+k8P2egSuSQCcWxqutFvbGMAkd/NfqbQSz/NQ3hz
         1wOeRHz1IL35cnXUzDXyXrNVOih7u3eDGLEnso6obX04GwvkwURcZSmARh//Nckzr5qO
         39ghDbCFk9KwdEI6HpRUlBUsWZ01Yuopb64VPcXjtEX/tDazHLFyj+LuBIpHz96D9zwJ
         /Tgg==
X-Gm-Message-State: AFuF++l3TwuGDDnsMbTLjainR6bmI15uTlvQUy5vQbM9ksz04H11lgMB
	6D2dV7H4GrSpHEjLPETpkxujyrMJ4NCUcPDeR9Qt4ahcWwtlwBWHmvPf3Vqdq+WvxZ50Y/40V3/
	hysoK2xYNZ5VikOsl06GeOVBDi5ChnfjEUqKLriNVcgmYb0I469XG7G2pY8uRRybo9KM=
X-Gm-Gg: AR+sD121zY7bpYS09RGtwi+30nW48LQd4vpCd2znKPDLlO0fPI7xxxLqk/i7TEM0duY
	Ivb8oGORL3bVDzbFb45PodKMBbgNBtyh/hefCOVYEs0xgNTg9+MMsunNbENLVtsypspsVcR1chV
	JinWRXCwwapeczxpQDcLFGPNdcL6h863LZv8Gim4Xv1QKgVog1BtTBSZ0PtYWH6A2NHh85Lj1Uz
	TuRy7C3KMAupzfK4mdPUVJ3BgJrxGD/zZ9ZZpz+UjNJ2kgHzUv95w709rTxucGu72KYb7b0YE1B
	Asom7kSOeZhyCqt4N7h+pgDJg/I0+2BT2rjXllbxfI1Bwq2sGbbiE0XBLOOuWmK7ZmRosFkJASv
	DTc6kAs2fMMLYSw==
X-Received: by 2002:a05:622a:1e19:b0:52f:a196:79a6 with SMTP id d75a77b69052e-52fb9694badmr168692061cf.33.1787997415423;
        Sat, 29 Aug 2026 02:56:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1e19:b0:52f:a196:79a6 with SMTP id d75a77b69052e-52fb9694badmr168691661cf.33.1787997414807;
        Sat, 29 Aug 2026 02:56:54 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942298fsm201048045e9.1.2026.08.29.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:56:54 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 29 Aug 2026 11:56:33 +0200
Subject: [PATCH net v2] net: stmmac: re-apply taprio offload in
 __stmmac_open()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNywqDMBBFf0Vm3ZEkrQ+66n8UF6mONWAezaRSE
 f+9Qbrv5sK5F87dgCkaYrgWG0RaDBvvMqhTAf2k3ZPQDJlBCVWLVl2Qk7W6R+KEkXQI84p6TBT
 RB3IoWzk0QsuKHjVkR4g0ms/hv4OjBF0uJ8PJx/X4XOQx/fTVH/0iUeIw6lY054ryz80zl6+3n
 ntvbZkDun3fv5JVc8DWAAAA
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
X-Proofpoint-GUID: w3sTF7y7arzjTEY1yd-Ufxc9-Vf2P_rP
X-Proofpoint-ORIG-GUID: w3sTF7y7arzjTEY1yd-Ufxc9-Vf2P_rP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA4NSBTYWx0ZWRfX7oxKCVx0H1wW
 rzoxzMBo+8rEasFci9wE9rlBduhMMchRWzWYnZpQJjGNQMMwS7i34D5DTKclEHFnVI6DQDvn9gc
 HT2a7Gpc1bP9PiUtldm+NFwINgvL8rQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA4NSBTYWx0ZWRfXxB+126mB9L48
 nqP0JzJySK8wibOJU7l0Bi0pQZLLIUa1/gcw+wOtt89vhN3GzZx5scdXnFGqPae5e7rkYQL1Tn+
 kKYe58+qjcCqBAqSQJ6cKyWvRFrSAqd6hRndNRUw7CQrfFn2G6oXyeqWR8WGtqcv/3FUTrpAu27
 eRqxLEteg07DpHTlQzwl7gS4YgsIfwhl978K3ORIek6G927JyRXMPxGX1Z+Ug6rRRkDBwbwhtf1
 b/Wgxj+w7p+9MK0qXvUr+lYyI4UEuMZGXLHcsErVI7L8EAJviOnx5vqJbtHM5/69E+qDDXR1dYS
 XQSgTtmMMBQd6CSfgOD8ZJMWNgdH/BLLsQoV4Hirf6n5vO+PUT2UiYZnbFYWmCQ7wRy1BKqNnf3
 wlypsYaHSb28i/qabXL84MmLPBXT/AuqJGtcWe34Gx/bvXTVG0oFXV3SYFqlKSpp6fta4/PuJNm
 X6c2/g/Eb4kKoI2RHcA==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a92ace8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JpBpa1p7AAAA:8 a=mSazJyEt4tbewPo3ZqYA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=YCh05so4W2E6r1tszMC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290085

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
Introduce the stmmac_setup_est utility routine.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Rename stmmac_est_reconfigure() in stmmac_setup_est().
- Rely on stmmac_setup_est() in tc_taprio_configure().
- Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 33 +++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 16 +++++++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 26 ++----------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 27 ++++++-------------
 5 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index afc516059b89..bbebd33c8a88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -80,6 +80,39 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	return 0;
 }
 
+int stmmac_setup_est(struct stmmac_priv *priv)
+{
+	struct timespec64 current_time, time;
+	ktime_t current_time_ns, basetime;
+	u64 cycle_time;
+	int err;
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
+	err = stmmac_est_configure(priv, priv, priv->est,
+				   priv->plat->clk_ptp_rate);
+
+	mutex_unlock(&priv->est_lock);
+
+	if (err)
+		netdev_err(priv->dev, "failed to re-configure EST\n");
+
+	return err;
+}
+
 static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index f70221c9c84a..f620d3331c2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -65,3 +65,5 @@
 #define EST_GCL_DATA			0x00000034
 
 extern const struct stmmac_est_ops dwmac510_est_ops;
+
+int stmmac_setup_est(struct stmmac_priv *priv);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d576059c04df..b30036428188 100644
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
@@ -4153,11 +4154,22 @@ static int __stmmac_open(struct net_device *dev,
 	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		goto init_error;
+		return ret;
 	}
 
 	stmmac_setup_ptp(priv);
 
+	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
+	 * registers, so re-apply the taprio offload after PTP is up.
+	 */
+	if (priv->est && priv->est->enable) {
+		ret = stmmac_setup_est(priv);
+		if (ret < 0) {
+			priv->est->enable = false;
+			return ret;
+		}
+	}
+
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
@@ -4181,7 +4193,7 @@ static int __stmmac_open(struct net_device *dev,
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
 	stmmac_release_ptp(priv);
-init_error:
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 960249960004..917ef7ddcae6 100644
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
+		stmmac_setup_est(priv);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..b41df317d73c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -10,6 +10,7 @@
 #include "dwmac4.h"
 #include "dwmac5.h"
 #include "stmmac.h"
+#include "stmmac_est.h"
 
 static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
 {
@@ -968,8 +969,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
-	struct timespec64 time, current_time, qopt_time;
-	ktime_t current_time_ns;
+	struct timespec64 time;
 	int i, ret = 0;
 	u64 ctr;
 
@@ -1069,34 +1069,23 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	}
 
 	mutex_lock(&priv->est_lock);
-	/* Adjust for real system time */
-	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
-	current_time_ns = timespec64_to_ktime(current_time);
-	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
-					qopt->cycle_time);
-
-	priv->est->btr[0] = (u32)time.tv_nsec;
-	priv->est->btr[1] = (u32)time.tv_sec;
 
-	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	time = ktime_to_timespec64(qopt->base_time);
+	priv->est->btr_reserve[0] = (u32)time.tv_nsec;
+	priv->est->btr_reserve[1] = (u32)time.tv_sec;
 
 	ctr = qopt->cycle_time;
 	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
 	priv->est->ctr[1] = (u32)ctr;
 
 	priv->est->ter = qopt->cycle_time_extension;
-
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	ret = stmmac_est_configure(priv, priv, priv->est,
-				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
-	if (ret) {
-		netdev_err(priv->dev, "failed to configure EST\n");
+
+	ret = stmmac_setup_est(priv);
+	if (ret)
 		goto disable;
-	}
 
 	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
 					      qopt->mqprio.preemptible_tcs);

---
base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

