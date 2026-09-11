Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791142BC31
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117132; cv=none; b=GicP8HASLFmQuzxCwXFpxzpIV62qoUN3VFXH6HX6smNxv1LkZ7S5Vlk5ll/qd9KN3kvgOsT/72e02x/kQxBUnb/LrXtpZdQT/FNJUBDv8KeoKrEI1d2TcXeqnh5B3934CI7E2C/Jpj9Z6EwkxV0weyj5vWVQ2/79lv1v2SNHRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117132; c=relaxed/simple;
	bh=DlQubEOkIDVPGDIBdRxfLkBUTl4fYiC5VtJ6o5opARs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYAIKaaaWoJ/lQtfNOdoru/MAmfy+xB0gd8hpfjfr3AKVJnt1lATU54eGUefp4gRKvH1/mZOJN8UyMyNWjJ9Ejm9C4YSlw6JrBdBQiGwYpGD7H+o2IuMmEANCSTqzFSA1zjJDxvGzd+fLSlaMuRff3azeS4Bi+cf/ieV0Z62zSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eC7qJIte; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SrS2h2dE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eC7qJIte";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SrS2h2dE"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kfHB3366283
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iNPx1Iwf446OIvz96wKGJfwiAph42NpcEbDD+XdjGQI=; b=eC7qJIteabQid4gH
	KjuhDbmfHgB79/NN2RHQ3WXZT0MHM/MYS/bIHjOIugZmlI67jrJtgS2eeyR55o1V
	pS2qAU7+1BYPHRIDb+EEvJ3kJX0/O+PkiQWMUJCn5jc3FvJIdUlUnvcA/Lf55BoZ
	ZoBIw8jf5n0B7JsjGwUzX2xLQ+N+Lce5wrCKwd+i4KBQywX7yQE49gfeRQKzjYvk
	nrufWJi3447ZKRxxP8HtvmPvAypi6wwRpWacP1AaBfThWOeI5hZ+PLW1W81my9K2
	bQ5+HhiahkS1cVHc0PY2Vt1g+48lGSjBAmiJqeIzwsO2neVfqCnCLykhqiYvRkm3
	B6E4IA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k2b09g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso91652985a.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789117129; x=1789721929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNPx1Iwf446OIvz96wKGJfwiAph42NpcEbDD+XdjGQI=;
        b=SrS2h2dES13CO0mBDq8sqRTwE23pcR9Zv4PVYUmbyRMmYllt+ADJMESNOu8fKO1oqj
         GNO+RM0jyQs8CdlyTCi1CmhCG5vkhFab/iIBKGa01XZJff4oFinLVYLsvT865AylSwYZ
         /s7pBWVfkRzj8RgSCZ6tWrMS/n//xzsrvVvve3/mlc0eN4r4qiK/POcp96VeVcX2/fSm
         +tiS0Y5VCdfNx+FddkNGVWI1BRSVAZ/i6P33xeXo6pTMDsFoUTmZe1p1R40ov+9INf9b
         zIToAHhkYzFuD1mmezUjZzcqSdTWiJ0DSSHIJiSjWuizD3isnq79k4kbNrKg2y9Qa57I
         n/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117129; x=1789721929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNPx1Iwf446OIvz96wKGJfwiAph42NpcEbDD+XdjGQI=;
        b=gnpJ9PeV2/5Y0gCBJCIfyVc8gtzSqug9GZLF85LDEvmJsr3KEdlX0T/jPeSwSH4paQ
         0WOsMjL0kD4jakjpbalMpJcQq0V2GCfjscJS3Ni/dlf2rXUfIQoc+YiB6rVseFrfmEKc
         GUeJr4w1GRxqHfmzvvdK3GPYoDGBrufjTc2Mp+W+i2t1Ai7rI0pP6AZsMET6rF0XJVWo
         CpMGz0UjCZfZszAJbnkEHmudab4g5FBfTgAoekS7MEL5JdIoRvg9Hyi1HvFYk4XjDus4
         pzYrjl/m+FqhrpCp98xuduRocYxTnQTjUGyFmuw4CGnvdl0LIRRTmtrCN7yddT5miklo
         SxhA==
X-Gm-Message-State: AFuF++lpLU3ufe7MIWAe40SHSpue2Q5GqDpRc+kB3CYn9uUKEmMfnplX
	jZAVz0QelM2ghGNFdSRMJnx5b32HDm3jjC/N8wag8yc4JO+o3+wP6MGqWGLYEFQo6OQCcM08MyS
	Ao3rdMvqn5kLZaFYy5Okbayd4DRXXxlazThhfUCz6a5xvPg6Jt1JgTN+LwBk=
X-Gm-Gg: AYBFou1ereagfMH5+O6e24cmqHqh8LEuvTXj+fuq3WHv8E7CvyRFNM4XHFBu0SXuI/D
	f6IFp21kOjqYsJjFxWWrDR0NwYnKHQJuWOYV2Sqfn7feFwoncvokFQbL25m4YElZT3kwGiRUH4t
	WsCGtLeoYq/R/p3NczijkYzWyi1UiskS++uSx+XS7+mtkjbPG8jtb9h50wnSFR2qpvHL13RUbAj
	ca1e1Vq0Xq5WR9Y/mJTx5gCZ+4EUpapTnItHASpb+6WEh/TGVaKIeHKf3qEf4elOrodfls8X1VD
	QDk9FJRQj47Hj9tpfcPM3NOrkF8CJkKWXmEbUzQNuqukSRxFh8r8CnUqjkuh02z8NUHASfbkTu/
	AnnkRzXFQL5c6dQ==
X-Received: by 2002:a05:620a:2243:20b0:939:f49c:1b29 with SMTP id af79cd13be357-939f49c2c10mr69663585a.46.1789117129531;
        Fri, 11 Sep 2026 01:58:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2243:20b0:939:f49c:1b29 with SMTP id af79cd13be357-939f49c2c10mr69660185a.46.1789117129096;
        Fri, 11 Sep 2026 01:58:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a7a686sm40481645e9.1.2026.09.11.01.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:58:48 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 10:58:29 +0200
Subject: [PATCH net v3 1/2] net: stmmac: propagate FPE preemption-class
 mapping errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-1-a76b1e2547c1@oss.qualcomm.com>
References: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
In-Reply-To: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa3c2ca cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BTyLBLs5qSdJAr6D0oQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: GwZVW_m5qRgNi5_oLWCl5lmshYDBnJIY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfX/C0JWGqhPyaT
 PJFUpPuZYRIKaxxfd0QAb7s9EqAqG0Eih/nNp74zxOo1acD+djFN/oMBAIfys8KuS9jq2piM9b/
 i/AM6yojY1/L/GVIdgXtqt//HKxVOis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfX/ItoLp8QA7kh
 9prKSoh1TgzAeffkjEcvNwhzhyKyLEKwGUizFSpaNW3k9yddl6AvZGn5yoVp68gAm7Pp430yiXK
 NKwqdbIdunDbjf2rn3UHlr8xE341ttbmBgflUKvWKbDGrPBeQYqeuwtzI+h/d/0FmAuh4hAI6cT
 PDP/QWxA/BYQqB3WArBwEz0Q7egZhDunCnwHCchN4PaFI1xLpS/WkBGVuyP284Msfl3Q0Z5D0KJ
 hxorprfrYPx/g8V1cLUteR2j2b8l2e/m/ajMZkmk7n4X9NbynQStx8ggzOodm3gwm5pNBvhSzLf
 2V+xzP9HdReCNf7xGsvw5IrxL4xBqsoKyoUeYU1LVDyB4SRFQS8ULtxn+CkWVqtViPZwEdaAuMw
 QgcYf+gK6TtkToNer7lLmK86zT35c0aYDcGBrwEcfA9Ibw6mDW4pNDo1h3IV2rjWcRkH1o5Z/vh
 jRMRdBoRFG7XLieG3Kg==
X-Proofpoint-ORIG-GUID: GwZVW_m5qRgNi5_oLWCl5lmshYDBnJIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110123

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

