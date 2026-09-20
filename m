Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3543785D
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909243; cv=none; b=ix0sTfEF3mzcB9dYy27cUjkVU+JoQMrc2U+TlwUK/2OQ7hED3H9++OYh/a9Vv9MZZn2oC+sp143Yo6rLFS5TZKW2qC96ZCBNxc8uAu5/ZD4bljRkkgTN7lM7rCb2LjBt5mnPZSwgFmL9F5UnVss3yHrzDBEQxIo5osqOEAn2dQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909243; c=relaxed/simple;
	bh=QpgWIJVWNU99rwfafpIFZfIJLPDRLv+LsAbU9z/5504=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V3kelQpHbsebtaybbVGEXZETFKCVTuHp4HoGXFohd2mI7Hw1kxzlR6J9Y1j6ye1mN649M4yxK4Ctxfv9q2/crC0P8W/ReynTvQN6D3YNk/k1zPUyNf8qDm6dNERvQu033ZWshKSbqguduSI3teDReHHQW5wBsjtbR/GRJkJsjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FO3wYcFM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SIPAF9XU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FO3wYcFM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SIPAF9XU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBnmPX3444438
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Dv++Hwgz+611wPTlNPuNZg
	9gGp73vyEv5RaQpPZcNTQ=; b=FO3wYcFMrcX5P02v0oNSx90E8cM63zXbaurZeL
	AHmrY7LltNDFGq/R8JcrmxAC9Y0FHBU6+TXJeJNuwrLOD/ykOONzvmGcSf1rZc+a
	+sgvDxKrMJj40osgl0qJwjwjiTv1Si3IotQH3WbjoICmoXZkpvaw8CX6/8yzR2TL
	q06lBUk2+PAVV/Kn/1g/MjwI8KtqZv2NDQfNaJ6BjYlIBQ+dp+AYdRlqXGfqO9fc
	AQYbr3/Ykc6ZVUxZyn+0c92i7n0y/aBZF/Tb65MKhmjcZ4x1iSF02PNW6hWVqHXT
	sJVgCyKq6hTsN0FrBsbXnKeZ0hqMdiTUYOKf1F1Vb7rjsWMA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsg3f3bhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:00:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a0c7126e7so419389385a.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789909228; x=1790514028; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dv++Hwgz+611wPTlNPuNZg9gGp73vyEv5RaQpPZcNTQ=;
        b=SIPAF9XUl+38ZBmi602CbxASx9SWaDiRn5yoErOUDbIruuHa1SgjES78YLC92cI6oW
         EPzkD9ApzOUYwXlHoFkz6sCIfeh4S3iQmRUNWV9vKRAT6/2B/CdjsNzrea/4k99HGbVd
         cNi+YxaIz0jypl6tgeb7FfEQM/+Q1wQJIz3kz4tixcs3rA8QHuwb1YLwYTA+7piCDjEq
         C0zDCjQ5pMfRNf6s12B88ehQAtYf6hagZhgJgkpsh9pXBLIRlBJuGG7p0L3ZBIQD1Ad2
         Ij3CLSctx31u+FqqFDGlZZmsk5DpbsU1M+nbxyIWFUXgUzytJiW0CsveDIMzOFB/MH7x
         75sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789909228; x=1790514028;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dv++Hwgz+611wPTlNPuNZg9gGp73vyEv5RaQpPZcNTQ=;
        b=ikbMfGMvsi85CUpCFvOmPcQQHgw1O5LWGznVg56of0Le8sHubs3bDl/G5u43+ogI0Y
         Z5kKWL661vm7Fey4BS+vCaKyx1uSGcmH/AX3mirRqE0HWdlcED+zswESlohvskiiWsHM
         kxC6L7ysSmENqlButtQoUKuPhzpd5uPTPf48nKOQ6y4KbPV9fiM18HxtJztp35UAmY5a
         1wOIokl3bu/irKheAt2Y1EiwDMhUxz2ZbWF2cPHZ6lJB4oi2dtKhQ0i+FMAVGG6ZUbf0
         s9AtuIVxaWAZIMz+ULBxa5GnWHq+GsM7bz3mzzdMviuyeLiq1yS55wKEHen3M4NMYWF2
         gsNg==
X-Gm-Message-State: AFuF++mIGvK/Hwbq2/FTQH+88SZHLo2y+BBtHyJRaMOBLrcnsrfLWt68
	gSUVvWJW2NN/bUG39rL5SyKpn8tJTl76c/TkSBSnZ1g0lAp7vP3widvEmlkt9ikSBRihvEfcxZ5
	1XYZVI9FX1QMOyQM6CZEd/WIs3Szo07HQTY/ZdZCKaSaz1TMNue6mA4fkkkY=
X-Gm-Gg: AYBFou0wlb1JBbGs6RC0SqibZYmlfgl2itqXdoyRTwzNvSTEggWY8GkjAczf2yjdYy/
	6El9bgkW9hJx6tJAYrDWSGq+y3IngzI0U8+aBWdSS3phtTyegB7uxhvzq5qMdI36h2SHwHT5LLk
	pYPYOcCDajGOumN/B5Imfeq6FuND77RjBm1WjEFIp/co96CPqnN5IiGlCtWLQBiWML8k2//aw5E
	MtcPKE3ljWre4tKDUimanuD64UEYafK7MLZ3izY5jW9N6E6VMaJv5kp3uqMF6hpa3Sw6ojxW2z0
	DxdCY5pbYkAc5+Hw2v5lHqkFHvMV+jaHOPcOX7s51yvcGvU5ergGH1n4CMNP8P+zshyZviLnzM5
	9geYFg7UbiPYr5Q==
X-Received: by 2002:a05:620a:6891:b0:93b:d7a3:45d7 with SMTP id af79cd13be357-93bf57b75afmr544586485a.64.1789909226336;
        Sun, 20 Sep 2026 06:00:26 -0700 (PDT)
X-Received: by 2002:a05:620a:6891:b0:93b:d7a3:45d7 with SMTP id af79cd13be357-93bf57b75afmr544577285a.64.1789909225736;
        Sun, 20 Sep 2026 06:00:25 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcda2140bsm147988155e9.1.2026.09.20.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:00:23 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 15:00:02 +0200
Subject: [PATCH net] net: stmmac: propagate PTP addend and system time
 programming errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-stmmac-ptp-added-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NMQrDMAxA0asEzRW4ghqSq4QOri23GuwYyYSUk
 LvXdHzL/ycYq7DBMp2gvIvJVgfutwniJ9Q3o6RhIEfezeTQeikhYusNQ0qc0L7WpTCy6qb4ivP
 De/KUKcOINOUsx3+wQuUOz+v6AR3RqGN1AAAA
X-Change-ID: 20260920-stmmac-ptp-added-systime-error-bc9566262f2f
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE4OSBTYWx0ZWRfX3vA7fIhzFiuE
 sFFGKBs7XbP2Zh/mYD1rPuQhmhwL/oIOejs2r5EW4+USVTQKh63YSTFrz1DxRPbszsysNa6ZD2i
 fdpJ3YoO36eVNDIryHzByZvHoj4KZwc=
X-Proofpoint-ORIG-GUID: 1I06kBnxrM1FczO7WFyAhKzlalRc6g2S
X-Proofpoint-GUID: 1I06kBnxrM1FczO7WFyAhKzlalRc6g2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE4OSBTYWx0ZWRfXwVgUGJ2Hm7fk
 LU3Ozmf2KQwGvB7bI0Rv++xqDYxTYgg+Zmr6BUate9WQKC4a4Hm5kvJoPm8bG81H3OLod66VaJc
 IRcHPkIUr0UFw3xjvEFz0D3v+rYsnxaZr16C0o5591jF9LK12M1xKe4PU9EUgYp+m50hfHJMzmo
 Jrk9Vr6nq0Mq6sVTJltOw9+FeQo0pWggTz+WLxFbMEQwZtyoaBw8rsNHmAplfgyalBc1hFQcvU5
 gkpo2jdCYMpxwn0JdbqO9mBIpemBe/fbVGpDWdGjl6DY40xzU0tNLGa7a0QdDjO+D7qGleUTKE9
 Xu9S5MhsN0RZmpis5Qk0BWSOGGBCje/VYS/mPXpnDXmgN+lfdmQ/K99lawl/Ca/8jcM67/Blh2I
 G1k8dqAj3FlSqXLJDaUlRdZATVBtClYEMerF1bRR6ORIRxHqimkzrphSnkMl7g7SqLvTFA+IeIa
 KRMgHekGjqOuPgWkjfg==
X-Authority-Analysis: v=2.4 cv=N6S8hG9B c=1 sm=1 tr=0 ts=6aafd8ec cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9VuKQwgGOwxQ2f590fkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609200189

stmmac_update_subsecond_increment() ignores the error returned by
stmmac_config_addend(), and stmmac_init_tstamp_counter() discards the
addend and system time programming errors, always returning success. A
failure to program the addend (PTP_TCR_TSADDREG) or to initialize the
system time counter (PTP_TCR_TSINIT) is therefore silently swallowed,
leaving the hardware timestamp counter in a non-running or partially
configured state while the driver keeps operating as if timestamping
were up. This matters for TAPRIO/EST offloading, which derives the gate
base time from the hardware timestamp counter.

Return error codes from stmmac_update_subsecond_increment(),
stmmac_init_tstamp_counter() and stmmac_dl_ts_coarse_set() instead of
silently returning success.

Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to generic HW Interface Helpers")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 89 ++++++++++++++++++-----
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fb5f804ea23..52587ecb1a54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -601,31 +601,63 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 	}
 }
 
-static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
+static void stmmac_restore_subsecond_increment(struct stmmac_priv *priv,
+					       u32 default_addend,
+					       u32 systime_flags)
 {
 	bool xmac = dwmac_is_xmac(priv->plat->core_type);
-	u32 sec_inc = 0;
+	u32 sec_inc;
+
+	stmmac_config_addend(priv, priv->ptpaddr, default_addend);
+	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
+	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
+					   priv->plat->clk_ptp_rate,
+					   xmac, &sec_inc);
+	priv->default_addend = default_addend;
+	priv->sub_second_inc = sec_inc;
+}
+
+static int stmmac_update_subsecond_increment(struct stmmac_priv *priv,
+					     u32 systime_flags)
+{
+	bool xmac = dwmac_is_xmac(priv->plat->core_type);
+	u32 sec_inc = 0, val;
 	u64 temp = 0;
+	int ret;
 
-	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
+	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 
 	/* program Sub Second Increment reg */
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
 					   xmac, &sec_inc);
-	temp = div_u64(1000000000ULL, sec_inc);
-
-	/* Store sub second increment for later use */
-	priv->sub_second_inc = sec_inc;
+	if (!sec_inc) {
+		ret = -EINVAL;
+		goto error;
+	}
 
 	/* calculate default added value:
 	 * formula is :
 	 * addend = (2^32)/freq_div_ratio;
 	 * where, freq_div_ratio = 1e9ns/sec_inc
 	 */
+	temp = div_u64(1000000000ULL, sec_inc);
 	temp = (u64)(temp << 32);
-	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
-	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+	val = div_u64(temp, priv->plat->clk_ptp_rate);
+
+	ret = stmmac_config_addend(priv, priv->ptpaddr, val);
+	if (ret)
+		goto error;
+
+	priv->sub_second_inc = sec_inc;
+	priv->default_addend = val;
+
+	return 0;
+error:
+	/* Restore previous configuration */
+	stmmac_restore_subsecond_increment(priv, priv->default_addend,
+					   priv->systime_flags);
+	return ret;
 }
 
 /**
@@ -864,25 +896,37 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
 static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 				      u32 systime_flags)
 {
+	u32 default_addend = priv->default_addend;
 	struct timespec64 now;
+	int ret;
 
 	if (!priv->plat->clk_ptp_rate) {
 		netdev_err(priv->dev, "Invalid PTP clock rate");
 		return -EINVAL;
 	}
 
-	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
-	priv->systime_flags = systime_flags;
-
-	stmmac_update_subsecond_increment(priv);
+	ret = stmmac_update_subsecond_increment(priv, systime_flags);
+	if (ret)
+		return ret;
 
 	/* initialize system time */
 	ktime_get_real_ts64(&now);
 
 	/* lower 32 bits of tv_sec are safe until y2106 */
-	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
+	ret = stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
+				  now.tv_nsec);
+	if (ret)
+		goto error;
+
+	priv->systime_flags = systime_flags;
 
 	return 0;
+error:
+	/* Restore previous configuration */
+	stmmac_restore_subsecond_increment(priv, default_addend,
+					   priv->systime_flags);
+
+	return ret;
 }
 
 /**
@@ -7693,18 +7737,23 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 {
 	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
 	struct stmmac_priv *priv = dl_priv->stmmac_priv;
+	u32 systime_flags = priv->systime_flags;
+	int ret;
 
-	priv->tsfupdt_coarse = ctx->val.vbool;
-
-	if (priv->tsfupdt_coarse)
-		priv->systime_flags &= ~PTP_TCR_TSCFUPDT;
+	if (ctx->val.vbool)
+		systime_flags &= ~PTP_TCR_TSCFUPDT;
 	else
-		priv->systime_flags |= PTP_TCR_TSCFUPDT;
+		systime_flags |= PTP_TCR_TSCFUPDT;
 
 	/* In Coarse mode, we can use a smaller subsecond increment, let's
 	 * reconfigure the systime, subsecond increment and addend.
 	 */
-	stmmac_update_subsecond_increment(priv);
+	ret = stmmac_update_subsecond_increment(priv, systime_flags);
+	if (ret)
+		return ret;
+
+	priv->tsfupdt_coarse = ctx->val.vbool;
+	priv->systime_flags = systime_flags;
 
 	return 0;
 }

---
base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
change-id: 20260920-stmmac-ptp-added-systime-error-bc9566262f2f

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

