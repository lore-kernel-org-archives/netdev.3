Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033786;
	b=uY7pCS2R7JVLHKmNY8bCWsXYqE43DptpNMzJLb0yx2+QjzNfF9gi6DjLHR+QGE7LWakZ
	 qkBXaQP5/C4mHl4n4n22gO3pTxtW9YPgjtTaizKhZUi9RYd3vqhIy3JplVPBTAu0G2Hol
	 sep4PKrod99u2O/JcIfOQ6ORBtiphothxMl70DC4IbDrxF+bl67V5Y/srseODUtRE01U6
	 1aB1YpQfQOIHbC9gaKoMkB4ytBRXdP5gUgEPqEruGwx1sfLQ61WE/kdwqGy05et5W2pK6
	 gtm9ixfdB49GTKHhk2P1+Q+XEeaBbRTJFdjdE8B2eD0gHC+F9LxsjUA8NgBiP5uoQQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033786;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1dbgIUcte8kMbY8XrCw2hxgZjhtzXlKiXSbaGDvMmP8=;
	b=pQzjO3CW1MPv7WWorQr62fvN582bP7mfZdwzMraBoFE0hUYHDdgASyMFyw9uJ/nfG2tO
	 a5JdJQAteVOZuwSPaQF0OjtKejFt4PO9NzZQHuNDWNShzQUVUZt5+8BfI4dKFj1T5w8RX
	 whJr5Z/YTST2C7lg7az/NmvlC/pQv/mO6cQR/Xn+ZkXVBFqKIEuC6zvpQOM5KP1XwkLLE
	 kklPFq/1fi9NvJHi6YkJgtaSW65Q7hchoiM8CwSg5e4fhlXbjlHQCWl5m0lDobk42olHZ
	 TVjB8red4ogczGd3XWWcft1MQEPcbQZBoSoHmmO7tepKv7PxgLnW5YvtWxmHJGBngsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TUdJxFiI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MKvPhGa1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A47606A321
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A47606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TUdJxFiI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MKvPhGa1
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEw73G3584388
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1dbgIUcte8kMbY8XrCw2hxgZjhtzXlKiXSbaGDvMmP8=; b=TUdJxFiIlAWsphgA
	uDvhoDgUIbWVj5fdbuc/2dkeH9LEzfXM9jDg2peJzXaHI5aKgJ5z0jfCQCO8N90g
	dzc7T4m7B4Bvt8WzQYqxIwj6wzbu5XfXTO4xJa7KUz+vf9L9dPhaEop0TZhPbDzk
	hHfbF1R2DNroE44AOrpbN6EKWaMZNMDRnDOVIBvzymnyAGsufoMpFA5W7D9y7OKF
	nFQOS2UzSitWkHP6qmpOIGkMAJqLiftTsnl3n5PCJHinBdfKqtB57i7DNoH8FQpj
	BI1C7vIGp6xux2yk/5kyh9544oIr4IiXekwMzLVTUCzazJWWSUDBYh8um6ehno7m
	9RVHnA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvddb6bj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f32050e72so720428285a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793033784; x=1793638584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dbgIUcte8kMbY8XrCw2hxgZjhtzXlKiXSbaGDvMmP8=;
        b=MKvPhGa1Ijh0RICduqfypUf8+vUxV5f59+d/d8MAA2OMoHDq9p+laSYq7jDoGJCkQo
         tdbrFu7ktgUzgsyZiLiLXu0VlJjhkKNm+fc2h2g+yxfC+wJU4SY0YwXj26oY6Ch/NKCI
         ebDuj1fs3g6rl+njLf3EFqW+5N4MUe7+Pqt/ujUJby93Tkl+x3SqAB7JilVOjzdT1Qty
         P5GWyXKo/CnH4bPDYy/XPjN+P0blRT7zreGRyjteRLEMND8ZrH5EshMvath1XrYobaZn
         c+o2qTpC6+St00HyYbl0pK1mJssAmBJ1apVFNmeU/jCq971dEKecOYn+DUJydqGo8usp
         FHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033784; x=1793638584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1dbgIUcte8kMbY8XrCw2hxgZjhtzXlKiXSbaGDvMmP8=;
        b=RwjYvxcTw/qTnNPQM1ZMDqXIIyXo4LDkh1vCvqqz4CuTiRBveCDwH+2Sv6pRKN09er
         hVop3oERqn66aa9/vDKBqlf20YPDUO1MPB7aIS0jCjS93n1i1pzIwEGyE0n67S5sBh5D
         N1XwhuFb+twO/5fdmeFNzQzmt4mmmyCZtXeyplDKDWd6gvTLgdUiwtQlewe43WwBRIYH
         Q6F77myUay6mOXU22lQCXul6hXeLVBwcfmGZAhKXQpNbwDaGONXwSRNmNKVtM3f7xf9/
         nDdzNSzHJyfnAVX5Qpfjahked88rtrpITC1VPhgLguR+Z6qgpzEImGWaR6BwWGfrxYbt
         5WaQ==
X-Gm-Message-State: AFq9FYI+Zca2HWJWjH/i28a8uNZXKCs+0WLjrqxQS3Ue/suLjfOH4I5A
	pDbdPcHd//F4RFiNfHjYVS2TY7kB7ifs/yM8I+PxXghytBYE78PyfNyFNdeXEEz+XH/oAy6irAZ
	e79EjhPtIasF9g4DFRqti+iWwAFdV1tQYtYghnZ574C63307U0qmzgn9W6Bw=
X-Gm-Gg: AYBFou3wKIj68m76/e5dnmVE1t42N/VjOPl931nHvAhcF8+tUx6OwESsOyn72JYcP6b
	zmnsX7f0qyon1BpTA4bwiPi75YWgmyTVnERH8Ka7G3E6BMouBgohgouMYR0ndz5gdjOObRhUQ/G
	OAtA12N0tjZXgEc8D0Dcizn8RcNadW4kKNcYLrEwygVq/hsGALP50U+brCvjXF3yR4ju6U5VE0E
	fwiELULtfnYWEMgRNBCpmFZBlAwjmXWDowZAa/ZHt37Zg+0jVYleuGT2a+t9yvXotTzKxd/o/Ub
	WZcsTPNrwTc3MP5Aap+YeYDN3/NGokwI0BIcHWTBclHjZMUuiZmJZ1vbPBRxjZs0YJenrs+kaFT
	Dzuk1ABlvPgA=
X-Received: by 2002:a05:620a:4150:b0:93c:5bfb:9a80 with SMTP id af79cd13be357-940ef7aad70mr1111741285a.3.1793033784236;
        Mon, 26 Oct 2026 09:56:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4150:b0:93c:5bfb:9a80 with SMTP id af79cd13be357-940ef7aad70mr1111734785a.3.1793033783581;
        Mon, 26 Oct 2026 09:56:23 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3c32sm17839839f8f.47.2026.10.26.09.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:56:22 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 17:55:58 +0100
Subject: [PATCH net v4 3/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-stmmac-est-fixes-v4-3-999dac4de44f@oss.qualcomm.com>
References: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
In-Reply-To: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: jAFxRPgmlxmDaZ0m5jsf8wytU7fR6oy3
X-Proofpoint-GUID: jAFxRPgmlxmDaZ0m5jsf8wytU7fR6oy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX9PIMxbubosxL
 BtS8Xeid6KT0Zc1Y89H6uAq7CxY/dvyUZROVhhROdw4EPw8wNnCMKZojeLnrpowB/GLDWKISPAP
 KaV6zGhaRuHCu0Zp8O3tSAvH9uBSKXV9So0aSW5SIcgOMGXe/+jxTnTfw+LLyDf26xvrujg71aY
 quHRZMNIY4ilqe0tTT9wiF+tzV0a0hETs4gY+Pr9xgzz4EI3YWVelGyOWZvptD6U5Go4M3tV54/
 Xje76k0O3fho+gJTymo12Rnz59x06SXy22yXN2bMiN/qwk4ZDc1OwMaZ0NeRQmLB1xfz9yHzFuW
 A9gBQOxz3rT9htRete92uZga9dJd7xjD2ljRCzCYKo62UiC7om6iyWFEo+d+m50iRzMEosnIRad
 HzYeZmOQ4PSRFqMTA5PC5DAvfDL+4HckxwHvHF0S5Jd1QealdTUGoI/RWGNjaGYg+ebBlPZz1Tq
 TeQHfTp1PL9A3buKeqQ==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf8639 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JpBpa1p7AAAA:8 a=DNwXZpNFxi9TDD9oO0cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=YCh05so4W2E6r1tszMC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX7aAiJzTqGji7
 6EQibb+85F5oIjMubX3H8QeFIwSFm70Zks42TQQqweSnGT833jLV1lQnsrEBYIz/b2u5qW17jyS
 pDMEMU0stNthkCs+IYeJ3GJPDvGAfpo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260067

The core soft reset issued by stmmac_init_dma_engine(), called from
stmmac_hw_setup(), clears the MTL_EST registers. Nothing re-applies the
taprio offload afterwards, so priv->est->enable stays true while the
hardware EST block is left disabled: taprio keeps being reported as
offloaded, the TX/XDP paths keep dropping frames larger than
priv->est->max_sdu[], and the programmed base time is stale.

Re-apply the offload from __stmmac_open() and stmmac_resume() after PTP
has been brought up. The base time is recomputed from the reserved base
time and the current PTP time, because the timestamp counter has been
re-initialised and the previously programmed base time cannot be reused.

Factor the recompute-and-program sequence into __stmmac_setup_est(),
which must be called with est_lock held and only marks the offload
enabled once the hardware programming succeeds, and into
stmmac_setup_est(), which takes the lock and re-applies the offload only
when it is currently enabled. Use the same helper in
stmmac_adjust_time() so the PTP adjust path shares the base time
computation.

Since __stmmac_open() and stmmac_resume() now trust priv->est->enable,
also make tc_taprio_configure() consistent: hold est_lock across the
whole validate-and-program sequence, build the gate list in a temporary
buffer, and only commit it and enable EST after validation and hardware
programming succeed. A rejected REPLACE then leaves the currently
installed schedule intact in both software and hardware, while a
hardware or FPE mapping failure disables EST instead of leaving a stale
enable flag behind. Reject cycle times whose seconds field would not fit
in priv->est->ctr[1].

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 35 +++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  | 18 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 30 ++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 87 ++++++++++++++---------
 5 files changed, 122 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index f15d4d046aa7..1a89f12f997f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -80,6 +80,41 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	return 0;
 }
 
+int __stmmac_setup_est(struct stmmac_priv *priv)
+{
+	struct timespec64 current_time, time;
+	ktime_t current_time_ns, basetime;
+	u64 cycle_time;
+	int err;
+
+	lockdep_assert_held(&priv->est_lock);
+
+	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
+				       NULL);
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
+				   priv->plat->clk_ptp_rate, true);
+	if (err) {
+		netdev_err(priv->dev, "failed to re-configure EST\n");
+		return err;
+	}
+
+	priv->est->enable = true;
+
+	return 0;
+}
+
 static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index f70221c9c84a..0f0f162794c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -4,6 +4,9 @@
  * stmmac EST(802.3 Qbv) handling
  */
 
+#ifndef __STMMAC_EST_H__
+#define __STMMAC_EST_H__
+
 #define EST_GMAC4_OFFSET		0x00000c50
 #define EST_XGMAC_OFFSET		0x00001050
 
@@ -65,3 +68,18 @@
 #define EST_GCL_DATA			0x00000034
 
 extern const struct stmmac_est_ops dwmac510_est_ops;
+
+int __stmmac_setup_est(struct stmmac_priv *priv);
+static inline int stmmac_setup_est(struct stmmac_priv *priv)
+{
+	int ret = 0;
+
+	mutex_lock(&priv->est_lock);
+	if (priv->est && priv->est->enable)
+		ret = __stmmac_setup_est(priv);
+	mutex_unlock(&priv->est_lock);
+
+	return ret;
+}
+
+#endif /* __STMMAC_EST_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9e09e11cc35e..a13a3790207d 100644
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
@@ -4201,6 +4202,10 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret)
 		goto ptp_error;
 
+	ret = stmmac_setup_est(priv);
+	if (ret)
+		goto est_error;
+
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
@@ -4224,7 +4229,7 @@ static int __stmmac_open(struct net_device *dev,
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
-
+est_error:
 	stmmac_release_ptp(priv);
 ptp_error:
 	stmmac_stop_all_dma(priv);
@@ -8518,6 +8523,10 @@ int stmmac_resume(struct device *dev)
 		ret = stmmac_init_timestamping(priv);
 		if (ret)
 			goto error_stop_dma;
+
+		ret = stmmac_setup_est(priv);
+		if (ret)
+			goto error_stop_dma;
 	}
 
 init_coalesce:
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 9a32af00d7d2..81ee89669865 100644
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
 
@@ -69,14 +69,14 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
+	mutex_lock(&priv->est_lock);
 	if (priv->est && priv->est->enable) {
 		est_rst = true;
-		mutex_lock(&priv->est_lock);
 		priv->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate, false);
-		mutex_unlock(&priv->est_lock);
 	}
+	mutex_unlock(&priv->est_lock);
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
 	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
@@ -84,31 +84,9 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 
 	/* Calculate new basetime and re-configured EST after PTP time adjust. */
 	if (est_rst) {
-		struct timespec64 current_time, time;
-		ktime_t current_time_ns, basetime;
-		u64 cycle_time;
-
 		mutex_lock(&priv->est_lock);
-		priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops,
-					       &current_time, NULL);
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
-		priv->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->est,
-					   priv->plat->clk_ptp_rate, true);
+		__stmmac_setup_est(priv);
 		mutex_unlock(&priv->est_lock);
-		if (ret)
-			netdev_err(priv->dev, "failed to configure EST\n");
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index ac926c60f9f9..95c5f6100c66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -966,11 +966,12 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 static int tc_taprio_configure(struct stmmac_priv *priv,
 			       struct tc_taprio_qopt_offload *qopt)
 {
-	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
+	u32 wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
 	int err, i, ret = 0;
+	u32 *gcl = NULL;
 	u64 ctr;
 
 	if (qopt->base_time < 0)
@@ -1013,42 +1014,46 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	mutex_lock(&priv->est_lock);
+
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
 
-	if (qopt->num_entries > dep)
-		return -EINVAL;
-	if (!qopt->cycle_time)
-		return -ERANGE;
-	if (qopt->cycle_time_extension >= BIT(wid + 7))
-		return -ERANGE;
+	if (qopt->num_entries > dep) {
+		ret = -EINVAL;
+		goto error_unlock;
+	}
 
-	if (!priv->est) {
-		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
-					 GFP_KERNEL);
-		if (!priv->est)
-			return -ENOMEM;
-	} else {
-		mutex_lock(&priv->est_lock);
-		memset(priv->est, 0, sizeof(*priv->est));
-		mutex_unlock(&priv->est_lock);
+	if (!qopt->cycle_time ||
+	    qopt->cycle_time > (u64)U32_MAX * NSEC_PER_SEC) {
+		ret = -ERANGE;
+		goto error_unlock;
 	}
 
-	size = qopt->num_entries;
+	if (qopt->cycle_time_extension >= BIT(wid + 7)) {
+		ret = -ERANGE;
+		goto error_unlock;
+	}
 
-	mutex_lock(&priv->est_lock);
-	priv->est->gcl_size = size;
-	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->est_lock);
+	gcl = kcalloc(qopt->num_entries, sizeof(*gcl), GFP_KERNEL);
+	if (!gcl) {
+		ret = -ENOMEM;
+		goto error_unlock;
+	}
 
-	for (i = 0; i < size; i++) {
+	for (i = 0; i < qopt->num_entries; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid - 1, 0))
-			return -ERANGE;
-		if (gates > GENMASK(31 - wid, 0))
-			return -ERANGE;
+		if (delta_ns > GENMASK(wid - 1, 0)) {
+			ret = -ERANGE;
+			goto error_unlock;
+		}
+
+		if (gates > GENMASK(31 - wid, 0)) {
+			ret = -ERANGE;
+			goto error_unlock;
+		}
 
 		switch (qopt->entries[i].command) {
 		case TC_TAPRIO_CMD_SET_GATES:
@@ -1060,13 +1065,26 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			gates &= ~BIT(0);
 			break;
 		default:
-			return -EOPNOTSUPP;
+			ret = -EOPNOTSUPP;
+			goto error_unlock;
 		}
 
-		priv->est->gcl[i] = delta_ns | (gates << wid);
+		gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->est_lock);
+	if (!priv->est) {
+		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
+					 GFP_KERNEL);
+		if (!priv->est) {
+			ret = -ENOMEM;
+			goto error_unlock;
+		}
+	} else {
+		memset(priv->est, 0, sizeof(*priv->est));
+	}
+	memcpy(priv->est->gcl, gcl, sizeof(*gcl) * qopt->num_entries);
+	priv->est->gcl_size = qopt->num_entries;
+
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
 				       NULL);
@@ -1091,7 +1109,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate, true);
-	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1102,11 +1119,15 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (ret)
 		goto disable;
 
+	priv->est->enable = true;
+
+	mutex_unlock(&priv->est_lock);
+	kfree(gcl);
+
 	return 0;
 
 disable:
 	if (priv->est) {
-		mutex_lock(&priv->est_lock);
 		priv->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate, false);
@@ -1116,10 +1137,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			priv->xstats.mtl_est_txq_hlbf[i] = 0;
 			priv->xstats.mtl_est_txq_hlbs[i] = 0;
 		}
-		mutex_unlock(&priv->est_lock);
 	}
 
 	err = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+error_unlock:
+	mutex_unlock(&priv->est_lock);
+	kfree(gcl);
 
 	return qopt->cmd == TAPRIO_CMD_DESTROY ? err : ret;
 }

-- 
2.56.0

