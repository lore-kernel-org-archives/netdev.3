Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CC41BA8B
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200626; cv=none; b=e1KNAtOaoZFlmWtSow6GPMs9z9bKupgKzXN3MKSbjtEMaPvq+CJfWdqq5sl/alHcTJvjqw3+g6pQjw9aM+z25E17RRiVktFXj+spO/a3/PHJrXmfAtGBXtsz00xbFpySMDh80bX9sG0JqRQWRlJMZMeFvMsY+U3PNH/JR6s3/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200626; c=relaxed/simple;
	bh=yYXHVLqs+rjurrjfJyI5d7hC2XKFh//yrrm8cuj9IRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GoayRwQGWGOfp65GOhno/KqfBDrW3kQEc5pPX2N9XEZL52SfL02vexShsy6PfLr1brf8FC608tZcF2rwBklCvnkJBiL4mNb3x/Yw/BO5576zX1GxCBdbZt0zRf1NXHoyQ8CgZ6Y1yxMPIMlSfmdMYFDtLeRJx2clYf6arT/2AWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzbRFzjO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jPW/s6Ij; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzbRFzjO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jPW/s6Ij"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678Db5BH011507
	for <netdev@vger.kernel.org>; Sat, 8 Aug 2026 14:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0v8tuSKQe7B2ZFUqxN9wk4L1Itws0CWUrBu40hDizw=; b=OzbRFzjOzOMQlcuH
	YAQ8iMeLsmGxyB74W9Q6RUp7ZX/C2sKLECiEjOEh0Elr4XKCqJa4cCpyPJGnnNfc
	/jT4ozhoOUKCiwCdZ6ZmXksIX0I8IfGiyIj43yRzg/lgbR8WWiOYuUuvlkKQGISO
	KH7YbQTixQGElYB+Qi1dBQeh2x854UArux92kDCVbZUe4U47qS+olT1tbad7hN77
	OxBCysmPeK8O3Ck7A0MYtIQ/N2oxi3b3OG2M+GXRHmk/ZB9a/2rwIWQuf5JEZVP8
	/wwoDO3rOK4xkA/ASUhxOBq2yn34UBf/6kSeDy8VZBsdmjne9+/ySTRismy+0rIx
	xzh1mw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvp1h1mx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 14:50:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso5338591cf.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786200621; x=1786805421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0v8tuSKQe7B2ZFUqxN9wk4L1Itws0CWUrBu40hDizw=;
        b=jPW/s6IjSQe/AfFCxZV/nJBB+NW2/ZGTpwccHabX1e5wWesfO7Nfy3gguBXYzFAZpD
         ycAw0zAHMHydg1iq8PFTW9emRhRMXBFK1FsRT7ArN0ObUhh411af8xC4jAjYk4o9OjBr
         i7IUCsROSaY1KEY88WdXH/H8voE9C73MX1BpKmigS8nTmxOB8GVE84k7sVOuYeNsSMF/
         x5i+YRXIuZ5L9sdobIvrCKfM/o4vHT4JvEhxo6mA3gph6T/L5uIs8oSRUvfPPG2eOk/w
         od+QcFrRe2huD06Efv/XjMMQNUHNAkIcetYLoKOXCW6AgU9MsE7PDFD0P9dHKezDZ7is
         UDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200621; x=1786805421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n0v8tuSKQe7B2ZFUqxN9wk4L1Itws0CWUrBu40hDizw=;
        b=OeASM0moxSt1pmtJufQ5K0fIEqjEjR+4+nuWwVFRcO5jpJi+SS1E74fw3oGQEs2cpZ
         QGYyRUwAj0cbinrUSm1YMmMRZSbDjwzf2uzn3HaPmkh6DEaQlHgPboy4Leosuo9yDOwZ
         7S/qJLg2/ltTEaT6+Bqm0T9pwbHDkgoG0Z+1aI+Z/OlLTD08xQ/+bVD16gSBT2AFyvhT
         +mM5rU3NOPY+TVSI1EGviVymcFsGopeTLqZbnXqgdmFcSolXrrufWP8G5kGiN4AYyoAf
         e2jwqIJ6pCw3QbqqOO3hnju2X/RyYLaMRmP90tN5vLcLSzNHjgw1YYDRghVuiGUCyrvI
         d2zw==
X-Forwarded-Encrypted: i=1; AHgh+RqVse+/8qfZvuquEQpOhWErtCuqisy2yVP3npWISfJ0uadP+c0dqoCvByiLk2249PRRiYuT6BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzyHaJXkbCTgriWKD0Hi/LLVf4CpBr8w/zDp8/ZiljJCUpzyxv
	K/dARVty9/3Bd8m4TYWRCYq+rS47OlyUNdevuKdebUED2j+KaHcWdJxm/MoWxQWOuDHv+kj4nfr
	UcUGZYygTKsWnAcAZPD99fcZN83zEwE9cScr25QrO5Hw/pfkQtCG0lDu1ljY=
X-Gm-Gg: AR+sD12SGITWxELs0Nmh7SN7OpQ04uwe6urs/FrfQgDPuXAVz/epcGQJzld52tiCHid
	Pm32G6vRHh5vM9jczmakerlwVnIMtbNFHxKPVPzhwb4fCGm5jocYSpe5NkGvmkNYn7zK6cSyL7T
	DT+fNAzI474l83RUZWkhlRDA5bUOoz69QC75Tl03dwZBw6c+uax3QxpyZLg+znWHjRr2Aq0nvU3
	ig9ZmTU23etAkm0Zk8+zU/SDg51y801Zf+mbfFIVjn6zlPMS1TwQc1vmSzZubjF+5D8gTmaPe42
	Dp67Xb0L99i0x8HNCQhRNCUE6cZRvzImdtXD5UlI6sgqkuEe4sAhdWjYbFoxkWWJhRxSnNAqfEG
	r3wmuZN8IJMckvs0=
X-Received: by 2002:a05:622a:4016:b0:517:76b7:7b3e with SMTP id d75a77b69052e-52d1919afcdmr128838641cf.38.1786200621495;
        Sat, 08 Aug 2026 07:50:21 -0700 (PDT)
X-Received: by 2002:a05:622a:4016:b0:517:76b7:7b3e with SMTP id d75a77b69052e-52d1919afcdmr128838241cf.38.1786200621074;
        Sat, 08 Aug 2026 07:50:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145679sm14986482f8f.3.2026.08.08.07.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:50:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 08 Aug 2026 16:49:59 +0200
Subject: [PATCH net-next v3 3/3] net: stmmac: hold runtime PM reference in
 setup_tc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-stmmac-ets-offload-v3-3-b714466142b9@oss.qualcomm.com>
References: <20260808-stmmac-ets-offload-v3-0-b714466142b9@oss.qualcomm.com>
In-Reply-To: <20260808-stmmac-ets-offload-v3-0-b714466142b9@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
        Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEyNyBTYWx0ZWRfX0nAmDrYKApSG
 xYcOfbykG7b5/EOvRz2bl6cewyyy0Cve1PANQW4kLJQhGKsErnQ71NSMzBU+kbpI85EgpGNs3Pv
 Dx8VuJBMDKZ/QoLvPSu/ktLdY0/5sp+RjhsE6Q38U/ctN135t/faPfOPs5eeP/SEaV2iTieucgp
 8QK+UFUB3qfXNpLajC/IMwVuSrkvdozHViKrOdBUc3v6BjcT/0D3DMkvCND3p7vFvpEG/TKI8F5
 HttrYcm1sd9ci4FawH1GguuIVbyzcsQKlonHskN1xe+9tcSnV393Qy1c81XQ0fOogt4m8gIfswz
 hlbMxteak7RBo8aKGAbEq38McE84z4szBRkrqaj1KVUbbYjD1qG5XAfYn/sLmT/Ckvi2dfgPdIJ
 +lcK4am/AHU4rMmjxWSrONPPT8Z9255ClRtLHv/wjr63Ecx01bzbNmB6HwlOxu9FNI5OCRN6Z2r
 iMsjrC8oTOd51s5u0VA==
X-Proofpoint-GUID: veLX36RhlmUeDQinRz8-_04WMB63rRrI
X-Proofpoint-ORIG-GUID: veLX36RhlmUeDQinRz8-_04WMB63rRrI
X-Authority-Analysis: v=2.4 cv=ebgNubEH c=1 sm=1 tr=0 ts=6a77422e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jmEaOccbwSVQIUL4fOcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEyNyBTYWx0ZWRfX0+hSDOGBL103
 daDV8ZlXEgnO2m8HqqQb8E5mlZWDoPkteDbhlCbWYRQX0fAbPtsnJOH5y8cKT0yFO7i3dqQvNli
 Yq6lCLpEApXeiRewX0drjol3cRrSUEs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080127

The qdisc offload callbacks invoked by stmmac_setup_tc() program
MTL/MAC registers, but they can be reached while the interface is down,
when stmmac_release() has dropped the runtime PM usage counter and the
device may be suspended with its clocks gated. Accessing the registers
in that state can trigger a bus error.

Hold a runtime PM reference for the whole setup_tc() call so the device
is active, and its clocks enabled, whenever a qdisc offload is
configured or torn down. This covers all qdisc offloads, including the
pre-existing CBS/TAPRIO paths that had the same issue.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 39 ++++++++++++++++-------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e19f75d8c393..5aee03ebe131 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6443,28 +6443,45 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
+		return ret;
 
 	switch (type) {
 	case TC_QUERY_CAPS:
-		return stmmac_tc_query_caps(priv, priv, type_data);
+		ret = stmmac_tc_query_caps(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_MQPRIO:
-		return stmmac_tc_setup_mqprio(priv, priv, type_data);
+		ret = stmmac_tc_setup_mqprio(priv, priv, type_data);
+		break;
 	case TC_SETUP_BLOCK:
-		return flow_block_cb_setup_simple(type_data,
-						  &stmmac_block_cb_list,
-						  stmmac_setup_tc_block_cb,
-						  priv, priv, true);
+		ret = flow_block_cb_setup_simple(type_data,
+						 &stmmac_block_cb_list,
+						 stmmac_setup_tc_block_cb,
+						 priv, priv, true);
+		break;
 	case TC_SETUP_QDISC_CBS:
-		return stmmac_tc_setup_cbs(priv, priv, type_data);
+		ret = stmmac_tc_setup_cbs(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_TAPRIO:
-		return stmmac_tc_setup_taprio(priv, priv, type_data);
+		ret = stmmac_tc_setup_taprio(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_ETF:
-		return stmmac_tc_setup_etf(priv, priv, type_data);
+		ret = stmmac_tc_setup_etf(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_ETS:
-		return stmmac_tc_setup_ets(priv, priv, type_data);
+		ret = stmmac_tc_setup_ets(priv, priv, type_data);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+
+	pm_runtime_put(priv->device);
+
+	return ret;
 }
 
 static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,

-- 
2.55.0

