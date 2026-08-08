Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824A31354F
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209744; cv=none; b=PvF7kx57g+bXEWyjwPJvHsuuywkbEtWIRXG7uf1MAM6LgihGZzvF2O9FSE8+jxRztCIIKQi82bMUxlCxYVI+pscjJapwSU+RhEFH+GWLmMGYDbpK18aXzvofWYbZN4n4o2EKJo4ZURYXMgk71qdVGuc3B//jrF4Db5Z2v91tIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209744; c=relaxed/simple;
	bh=Irv08KJc3a5XTqtTgwqEXWASPwgVWok15m91Q3AWcJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XMCEkpIQBCvaL8uIFeBXHEJO0Wo7qbGhwA7rSALBaJviXWs79gdz0gclqaQk7zKm0wedtEmL2xC2KttE31yzXDZuUwKFtcEgBp3Rfm+4kPbq/KDvlxGvSw+Bi7ZlA7cz45P3fOQM1Zvr7IWp21Q/PVNZ4LXQDQ+d0CkBaV3ejhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aK9wCVMJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EkAY9dMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aK9wCVMJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EkAY9dMY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678GmJgB668909
	for <netdev@vger.kernel.org>; Sat, 8 Aug 2026 17:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=akVGAgZib2CdSWpzF+niAL
	VDAdDMLrO8tnmr+N8zhn4=; b=aK9wCVMJ7GAy1foQFvWPl5DIEyhhOLeadNtvBe
	JSbMqaTiaddyGRn9rmM3d16CK4TOakauf7WwKtGqkkPXZmepQ1N0eqNtxfbFGFx+
	ZegjGv5vUYZyVlon0EBEbbtyBGBLCyTE1MwLRJHpSOMd7jebrYgIBsDajphkhRVw
	CUlWQiqtsoB1Zy4XsxcrdkD6e6xvgr58x36lIyoaYDatjC19cmVbw2R8ByuPXw0N
	t2ffbV+XOdmtQDnGTBRHasOi2g6qdCrCuKM1HAxuV28IXxvtFgDcPMl4mw1loIVm
	RF7N+WpsRK6kfli1az0AHTp8IgU2ai1GHzwXPlBb6Tomz7Eg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf79fss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 17:22:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930f5da3467so44753285a.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786209742; x=1786814542; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=akVGAgZib2CdSWpzF+niALVDAdDMLrO8tnmr+N8zhn4=;
        b=EkAY9dMYSMFMzH6I4k2jzOoBWc33EHdBLANMMyKoXY2KuM4N8FpvHYqLHgi+e4FV+v
         Q0jQifdH7L96A6Pxzi6YBIe4xE1Ei3rigtqReQhVhCL7MYdjfQ1tp28mnxsGlyvTJVBY
         2HvFnW/qfzbXks8VG5EP0vHQm3TDcw7PpjFXrGeJGHNXMlLVXXtunP/FRL01BNM1wbtO
         1SPlv8DP9+mkFWOAVf3+23/VdfezQ1QDwmYqaRo0hW2RLyHn3kr4Q5Q718lVWPP37LBx
         bN4D9yhIpWi3moataKqC87lXxRt7cgWpMveLXIn0XChUXv6iXHq6YMxusodIFW5Rbb3A
         qK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786209742; x=1786814542;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=akVGAgZib2CdSWpzF+niALVDAdDMLrO8tnmr+N8zhn4=;
        b=cUWG1b7KlEzqtX4f9fkj4hKCRRhJ107WSa6jRFQ0oi+ATIIpF8APNgShdRikImDHZK
         kaEKmIjoYAkekbgZxsoBxNyzkgvDSp9sR+ZJg7+KkPNTN6PbKnz2svoFfljbaxhyI35D
         Eo8fOasZhD5EGNVADheobbM32Vf+1XUs0gvQCELkQZ8JneyUcd1jDG0ZpQa6Yxq2fusv
         HK1Cf2/ou5j7ghrDN7IReJSC6WqP4R9TDg9HS4iJShsjAA6zUHe3EetksW8fGS9oc7Xr
         MZSVymcaRy69rmPuaVjyudgpP3XYuIqXvH7y7sjPEJ8JdoLoc8J4P7rG7psGy16w8FD3
         b5eA==
X-Gm-Message-State: AOJu0YxdF9S6nTzCzZhiu3QwZhi/l5tc19ha2NIuYLuMhptrU0eC7ZGm
	OUDmLcsPTyWItx886iTiKDC4PK7FGR0QzK2R6VgMbtrpTGOvIBfWwuD+Jxsrpju8lp67dCTFoaE
	cI6sNdOmyatlZjU07ogN77yorYC8++HwBKT2CwCu6t5I95XZaAoAE/DdUajTm76P16Hg=
X-Gm-Gg: AR+sD11JzYAeA//FONy41chmf1NhTUAhmHSDGgxjoQgBK7oYGPcU9OmfTWc1bCyWC8J
	zXSu2srpmHJijzqV183lJEZAtiCBCIEboC0YyGEHpNJL7JbN0dpCBTjtPTPYihpILp0MAFofDCI
	6ikDMK6HEOaMOCrGxAzowwLDaUGM5Ap4liOPDKg+kgHKCBUcleBt2l0+OEguTmloFRT489+Tj0H
	as5yeOC8L2DtW4nuXa/QJSBlgvZVMzWFQsc3aS3iWwTT/Wazti6N8KqftUndVvGEOcgSyPD6kto
	QnB2IgU/aZTAE28v6LSuQUYeel82RMIUvHarKsAw/rLV2j724TVu2kg5Wyibl2tuOFAW4ojcSih
	4f8gFMWqKrsWQjhw=
X-Received: by 2002:a05:622a:407:b0:51c:1132:c80d with SMTP id d75a77b69052e-52d20a165b0mr103068071cf.28.1786209741659;
        Sat, 08 Aug 2026 10:22:21 -0700 (PDT)
X-Received: by 2002:a05:622a:407:b0:51c:1132:c80d with SMTP id d75a77b69052e-52d20a165b0mr103067391cf.28.1786209741119;
        Sat, 08 Aug 2026 10:22:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145a2bsm16299970f8f.4.2026.08.08.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 10:22:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 08 Aug 2026 19:22:01 +0200
Subject: [PATCH net-next v2] net: stmmac: improve TSO/GSO queue selection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NUQqDMBBEryL73ZUYrEq/eo8iEuO2Bkyi2SgW8
 e4NnqA/AzMD7x3AFAwxPLIDAm2GjXepyFsGelTuQ2iG1EEKWYlG1MjRWqU7pol07JaVVsLIHt9
 mR1FpfW+qoRRSQiLMgdJ80V/gKKKjPUKbntFw9OF7abfi+v8ybAUWWOqybupeDUL2T8+cL6uat
 Lc2TwHteZ4/7pLO0NcAAAA=
X-Change-ID: 20260807-stmmac_select_queue-tso-fix-06cc586d4022
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE0OSBTYWx0ZWRfX2lYE0In0ES7r
 LrXokRLp3+rCa3QV1j0QcBF92t8LTrw9JHCq6VSrRuNPXI5rWKcy/CjPpPV0ToXB5qnInzAGxn/
 QmFhepJ06cobwkfPHcNuHkBLNsW5oxI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE0OSBTYWx0ZWRfX6DZI722DRe89
 0XVnY/JTxeX6hNZ1x1h5iTigMVmrQqFwuyM0b9T8AjNbwQGyTQgLpqgii6vOIKxAsxH6KztPKyf
 c2GxjL0+v36dzOKj6LFSz4hGuMjuwrEMPwBO1UzOCFJaCq3vOiuxUKNyrQQLeuH442N1u7VI0yY
 a+bl7mMuoEhLq/Ne1EunsMJ4ljp3vPixUY2IWUU71e+YPJg4l4NVQxxN6nOKw6Bae1YuNLoxk0Y
 lkx7AkAtF+gDHiVOyY/uQckXdFRSWYlx9lvhMhOPOgqk9JmNTQkP7SSNEsyL3lf+bfumF4FQlMM
 ZxeT/kGpXXsqHsfyJerC3J+12iBoUG34UZOgPbhR54uG4YhajrvAqJi36O7NEiWi0M14jdCZPyM
 lqbl3YnPpDR3qGqqmDNeAYDnWHWx45sOSSxYWbQoE0/tTvhGnK0+i2/13tY+lzaGALGHi/hq1iD
 rB5C4Dakd1l9lHE4epw==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a7765ce cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OvAj1FvD3cEXO-Eea-MA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: rc-E-56_lkyKLq8KIAMuqF3Gc3lA9G6J
X-Proofpoint-GUID: rc-E-56_lkyKLq8KIAMuqF3Gc3lA9G6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080149

GSO (TSO/USO) frames are currently always sent through queue 0 since
the driver assumed there was no way to determine which queues are TSO
capable. This unconditionally pins all GSO traffic to queue 0, bypassing
the per-flow queue distribution and any XPS setup.

Instead, pick the queue through netdev_pick_tx() and fall back to queue 0
only when the selected queue cannot provide hardware checksumming (COE
disabled) or, for the GSO types offloaded by hardware, cannot run TSO
(TBS enabled), since TSO and TBS cannot coexist on the same channel (see
stmmac_tso_channel_permitted()).

While at it, base the TSO capability check on priv->gso_enabled_types
rather than a hardcoded GSO type mask, so it matches the TSO/USO
capability actually used by the transmit path (e.g. UDP segmentation is
only offloaded on GMAC4).

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Take into account when checksum offload is not supported.
- Link to v1: https://lore.kernel.org/r/20260807-stmmac_select_queue-tso-fix-v1-1-4c4787bad02b@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..7a4bd0292966 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6445,19 +6445,21 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,
 			       struct net_device *sb_dev)
 {
-	int gso = skb_shinfo(skb)->gso_type;
+	u32 queue = netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
+	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6 | SKB_GSO_UDP_L4)) {
-		/*
-		 * There is no way to determine the number of TSO/USO
-		 * capable Queues. Let's use always the Queue 0
-		 * because if TSO/USO is supported then at least this
-		 * one will be capable.
+	if (skb_is_gso(skb) &&
+	    (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
+	     ((skb_shinfo(skb)->gso_type & priv->gso_enabled_types) &&
+	      !stmmac_tso_channel_permitted(priv, queue)))) {
+		/* GSO frames need hardware checksumming. Moreover, hardware
+		 * TSO/USO can't run on COE-less or TBS queues. In this case
+		 * fall back to the queue reserved for TSO (queue 0).
 		 */
 		return 0;
 	}
 
-	return netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
+	return queue;
 }
 
 static int stmmac_set_mac_address(struct net_device *ndev, void *addr)

---
base-commit: 8ac4255c1e0c83d2e1559a18b8918673116fc8d6
change-id: 20260807-stmmac_select_queue-tso-fix-06cc586d4022

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

