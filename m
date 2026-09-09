Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60A57267A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963995; cv=none; b=BnvOnEgFLFbkFLjo3XbL7RGSURc0es/hya5JKgkZcuvkszw0Nyuc21bcULWBVnAxclo+w2BPmNJHkMUyaKW4jCGiIxRmF6JdNETnFE0N2RzOvhVokXowF+JvZgFWz2/FoAa1l7dfANhi01AZWgwROlc8QCcYdsbwN93CY+5+Z5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963995; c=relaxed/simple;
	bh=DlQubEOkIDVPGDIBdRxfLkBUTl4fYiC5VtJ6o5opARs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZKU9hJChjmxoKwzCpuUt3zKOI4uRrMSYbWmi4JHAaC9Hi7b+DDUyxw1yAi6/05ukV5Gu7kR+FO0j8cMo90psioJwgeEgPMYYsq73lrb23VXBPiBQJ/6TueoF3Or/GQzmmOqO4onTxTVMI54XnWEcLih8SJIL/Us8rtQvCR6D2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eNaocI1Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YGDySsCq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNaocI1Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YGDySsCq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU7U02171738
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 14:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iNPx1Iwf446OIvz96wKGJfwiAph42NpcEbDD+XdjGQI=; b=eNaocI1QAzjNo97f
	LHIn63a6VUmXPt5ynwA2FMvHMc6uAj1rJmFVGomItFVezOKNdba9LiCQqbJj1TAx
	sbZdKrASy+M0+QlQtDQvabWYRnibrtxhd9qedrMIlo+09kzeNva0DyXtJ1lxm8OM
	DxQ8eOiINGkE3prbXfD819LZrNd589Bdt5kYLC6OIeiEJPwod/wBZXvc9/mu8thk
	vzoW+aCGGzB3JqumzrTgVsRT74OH7rVMJgb1lW1as3mZk/NI11HEfIfqgmWhrvP1
	ous50TwOeIHhgY5loh91vm3YmKEJH6YP+C8HEe2LjYqoMnWYzteCP08XHG64VcGj
	5FQb7g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5rggxfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 14:26:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93771aa0379so1171807485a.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788963992; x=1789568792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNPx1Iwf446OIvz96wKGJfwiAph42NpcEbDD+XdjGQI=;
        b=YGDySsCq8atnEiWVDN67cEYdMq0N6zFcmA1f6qDLYhKkRIj5tgitoA2GdEQSkIdh/q
         CYTox6oei4bVimkkjCTxeERB58qxVM/PxG2ufidek6lH2X7GCmUB1CfHNS2WZ2SEY/th
         P3wwfyLgxwJFwfooIbPJtsGK62vW0NWASHVL1hU/BCXuKPujBU0etXBiA0b8aNDhXP6u
         +Erijpge3OFN1JIO8AvL4+PkhrK5baCOM93LxGI4DCtCDlOy7o9CDjviq7i+FX3iLLAL
         PEauN/Q2Vn3alONg8TNMyH+MSBwuxyexvzVOABebUlObvDYYmwTQXdof7jlpCjmxfeYh
         YXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963992; x=1789568792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNPx1Iwf446OIvz96wKGJfwiAph42NpcEbDD+XdjGQI=;
        b=Bbpjs9QLYVd9UUoXWQHbNUYq9/ZOnfO9lz2sP3YVfp1elLe4ta30zOlQ90oIywpizN
         Fao6aQNa48p6J6D8EGoT0c4/nU8sMF5/rkYK2ayuGU6R3pQjz6lIBMMnUuCtN91vg0nG
         EBdblRxrV1aO90aP9Kck2hNisd1TYay+Nv3kVnej6Nbo3HJT4es5U7e8J9HP2HQBrkCG
         XpTyWuR6wGsj3SiCgl8WMVko1ryxMaQatlq2qWQok97ItAlQNJ6J7W8pfGFliJg2+vre
         AA69/290NQnM4h84gj3G6X3lOoP6shMdBeFJB6kI+O7ziMfxRHNfKim8d2cafulwwtvu
         pB0A==
X-Gm-Message-State: AFuF++mlwcdp9Wac6hio/awOOvNigCZELCZDOLtFfyQE5sh3jUvGD3cd
	/Tx5L4djiKmG506AFx5cLQ9ZbkcHMr8ENE239Xp8jlUHyFtqgF87yhew3rDOYLAxpyuRV3ZWQe8
	RcKW5q+SSNUYee5LL+GBUIOk9e+vgR7hU973j7HZIsmk0WJA+yo4P5vzPv78=
X-Gm-Gg: AYBFou3j4LcNXo1/6ffq7YGUutwmGQdJ8KpafKH5LmF8JM52eSNagu2uoMIzfI+IWqv
	xhzjAyzhCYbDfxRIkKHMgXXEC07LVtJxKfwjtf+Xr6AXjlyD+Ij3u/zYF1VexDcirtalwDrg/6E
	09DGuy8Fb0U/bgWf4uARhJldSxSsM9mXdCMDLmsO4oa7/+Ogmp/RAuzV86MTzJNPYSvTRauBKgM
	dZ5CSpdD2CDbdVqbsmooIjSHrk68LJ4RiZh2Lly1DLry8mZ3LN73XY+j4rZDHiCgxjjr5azjD+s
	dKXgyf1tCzMPWh2oSNE7H+2kb80Za2YFy71Q8zwdKzUcFsNoV4VUX29l9/widDrxqvCIB9RrbuA
	mTDKNwg7dohti1Q==
X-Received: by 2002:a05:620a:4449:b0:939:3626:558b with SMTP id af79cd13be357-939d4924cdamr229058185a.5.1788963990646;
        Wed, 09 Sep 2026 07:26:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:939:3626:558b with SMTP id af79cd13be357-939d4924cdamr229018485a.5.1788963988272;
        Wed, 09 Sep 2026 07:26:28 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fc23fcsm54890715e9.3.2026.09.09.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:26:27 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 16:26:09 +0200
Subject: [PATCH net v2 1/2] net: stmmac: propagate FPE preemption-class
 mapping errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-1-8158b8333b3d@oss.qualcomm.com>
References: <20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-0-8158b8333b3d@oss.qualcomm.com>
In-Reply-To: <20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-0-8158b8333b3d@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2MCBTYWx0ZWRfX1DQKRp43texI
 0oHf3TZwhuALZKaNCFYaCVrp9Pc5G/Ckkzv7leONy+6eDPxBhD581dxGqjWMi49lYFYparln+qT
 GsRDkkqhkR7ny1/oQw44nbsr32oRpOI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2MCBTYWx0ZWRfX5nZ1IXzgW+0k
 Fx5wI8B4Y4r8u3ovAL6bfEIkS2juVeLtU9pDhMeYtuJuodEWsz2xv1jRXulQgJjSvDbrOcdqApR
 nHHptTG3bfg32yk4l1bTVi5h769Fsrlg6wMWaGjXqqMSbqAdwiFYjmaK9lCzZRpg9uJypXR6BRV
 C/Wa7wxA+wklGcyiADZ00MsuPDyG4HYvRG33GQ6BeLCDYCxtNjUwXbgCm+NSo47hBAqKFDJNq+d
 CXZSSiN1KcZFzRrqjHUzDZGTAOdQ6VNrQX1APIutXRDtbzyY6iMeI4Swk7FFzMiDMxcmEgpIpDO
 ig4UskQMR1MygOLYd8Rax/adcinHy6puF8wTVhPXZqUGA7p4aiJwseJOyuEY9rT1x/Q/1vEH5e1
 73PxDA0hTzPWsZZQEu97XzIk6NUbcVyOe+c/ckjZfVRqn6+VNKXX6N65XKG9NabrAzEc+UAuPlv
 EIJJTJrjZAZy3wV5uuQ==
X-Authority-Analysis: v=2.4 cv=B6qJFutM c=1 sm=1 tr=0 ts=6aa16c98 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=BTyLBLs5qSdJAr6D0oQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: JbCjBTXN3Y0uB_bvdpIQ1qcrND1ojNjU
X-Proofpoint-ORIG-GUID: JbCjBTXN3Y0uB_bvdpIQ1qcrND1ojNjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090160

stmmac_fpe_map_preemption_class() dispatches through the
stmmac_do_void_callback() helper, which forces the callback's return
value to 0 whenever the op pointer is populated. As a result the
-EINVAL returned by dwmac5_fpe_map_preemption_class() (e.g. when a
preemptible TC owns more than one TXQ under SP scheduling) is silently
swallowed by every caller.

Switch the dispatch macro to stmmac_do_callback() so the callback's real
result is propagated, and honour it in the taprio and mqprio qdisc
offload.

Note that the taprio "if (ret)" check in tc_taprio_configure() used to
be dead code and now becomes live: a preemptible TC spanning more than
one TXQ under SP scheduling cannot be programmed in hardware, so a
taprio or mqprio configuration that previously returned success while
leaving the preemption-class register unprogrammed now fails with
-EINVAL. For taprio, the failure also runs the disable path, tearing
down the schedule that was just installed; this is the intended
behaviour.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 04dafec021b4..9314bcb85c22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -494,7 +494,7 @@ struct stmmac_ops {
 #define stmmac_set_arp_offload(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
 #define stmmac_fpe_map_preemption_class(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
+	stmmac_do_callback(__priv, mac, fpe_map_preemption_class, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..5398616fcdfe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -970,7 +970,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
-	int i, ret = 0;
+	int err, i, ret = 0;
 	u64 ctr;
 
 	if (qopt->base_time < 0)
@@ -1120,9 +1120,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+	err = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
 
-	return ret;
+	return qopt->cmd == TAPRIO_CMD_DESTROY ? err : ret;
 }
 
 static void tc_taprio_stats(struct stmmac_priv *priv,
@@ -1237,14 +1237,15 @@ static int tc_query_caps(struct stmmac_priv *priv,
 	}
 }
 
-static void stmmac_reset_tc_mqprio(struct net_device *ndev,
-				   struct netlink_ext_ack *extack)
+static int stmmac_reset_tc_mqprio(struct net_device *ndev,
+				  struct netlink_ext_ack *extack)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
-	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+
+	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
 }
 
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
@@ -1257,10 +1258,8 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	u32 num_tc = qopt->num_tc;
 	int err;
 
-	if (!num_tc) {
-		stmmac_reset_tc_mqprio(ndev, extack);
-		return 0;
-	}
+	if (!num_tc)
+		return stmmac_reset_tc_mqprio(ndev, extack);
 
 	err = netdev_set_num_tc(ndev, num_tc);
 	if (err)

-- 
2.55.0

