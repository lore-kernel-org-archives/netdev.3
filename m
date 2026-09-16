Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B374A261D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565449; cv=none; b=ScOOFo1jIppxKww7SWUfCn79QSly6kgTCeQ4Wlyh+iwEXWwFOsllFfvD4dZy+z0GpIf6TWtCY6+rzGq5xz4CHhb4SSombGCkY0NVDmHPbTqxNiihUrvRzV2Xk4CP7m11Ip/QKgLsrTE2nEtOHjHZHHsgy0/wBpPGPQ60AZY6xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565449; c=relaxed/simple;
	bh=Dg+w6Ty+r9FIvvcbWwboScm3mBkwNtGOxOZrRurJG4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K7/SxRHMN6eNJP3SevEmlqanHAe3SRGgUOkhu6fUcRWtZ8a1peMJSJ10KgefCHtEyCmk39oTsOLziw9aZj54th57nMQQLAXAUUPiUD+bJu8EpXmmGEpOlueeaEupDKjrPcwenueiGQsCYbiin8kuklWPQqqHf+6OJ4FLpQYVYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gys/7DUh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EcDu72pd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gys/7DUh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EcDu72pd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCYYf32814390
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rLqupxzjXmzvfUPsB8zm1M
	ahn5C+EFV39FmCjpXtCPE=; b=Gys/7DUhcmYcSGG/8N80nL+MQLYqGttWhw+nxa
	2x7fiei3Qw+Vo1JQ1SEXrqJhTsPsvAelZ3DDOEMnHlysX7fi/C2vQAzDNH3PN/eD
	h2+bw+u+qt2MIw2JVaGUd/66bUCvA1mN6yW/TPI87C/Ij8kHq479GC3fWgr5Yepd
	+xxcp9XRpLcWkTL7EZDkdZi5rck7D5Y7/BI/UO1RaQiVoEkqlWssYYPt2/rEHHIo
	SOhlxdnjW7CK3ILTvhrhmQ3TWVPC3ntMyLYWGvsS+RE8L66yfFyOnwAudKYXPVsv
	XL2XqhGnKd5J1TUml6qNg3GDW2pFQGAZmmv66uUWBq2WUdCg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqdywbf8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:30:37 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-982fcdd9b01so430451241.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789565431; x=1790170231; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rLqupxzjXmzvfUPsB8zm1Mahn5C+EFV39FmCjpXtCPE=;
        b=EcDu72pdn+Uze44mdog+yniwzPhuvA/MEd5aIAjb2yCsmoBmN5E8e8N51/rGSL+s7t
         xcbfS4OMDfL0QOXFgwXSVexwFuSo8SHdvVTOeyn1PgBDEsGZWuwWpZpvkAn5aF58K/iw
         3Pq6acjtMqEy3nN6HHE/WxUPBs5PTr3OdB3KMJsQEXDGzACYIHecsI+46HMs1GhXIC+d
         2jWlFupRl5kOzbEsF5gdFO9pvRDIqvTSV10l//7/QEANHQcrUeeCzQZMia8yg7Pu2gsf
         rB8S4xTgI98NMot1WQsltcI03/Q39eAGpDirI6SG2+ccHsxf0gL8DJ3G0wV1a459q6Pv
         fyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565431; x=1790170231;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rLqupxzjXmzvfUPsB8zm1Mahn5C+EFV39FmCjpXtCPE=;
        b=IwJv/Tpmj6TeSjJ+C7xqdlmDXd3OqKMPTMnKXUGs81Hi1fUISZB/aTnntDqsN/nSc/
         VJIUrbg+ol5aAmz/i0mWQ5dx5L+DB8L+g7mjvkGivX9uVZMmF13qhdYPyUUTzb/bXO8A
         Awj8vxVxx6ir92WVzf8okIOdYo+bP31bpNexSLGyI+Jk8slkdRXa8JMbQhgVdcHhtb/S
         xABhZf+mRM4vgeJYcYbQggN+sjUnMgp++PFKtUrm2PqG51Od/u9z82ocnOS3oj7p5aDy
         cvRERcBFfhnOD6ne2P8QjsAX9FG0Vq3VIltCpP7AuHOIdw4svE48Z50qf9YYRcJqL4gW
         pBPg==
X-Gm-Message-State: AFuF++kM70oBWFh5mSIXXSD6WK+HA28pyhEARpVcPKzTO+HtJa5Toi9K
	ByFfdPEBA81FD162DdRdnYcEhJFmAmfSh6iIMT/17dZLYkIDVqNo6r/PF7GAjw73lHOkp+cWWwU
	3F+AlTeVrVdcyVIeCRsAnUzST05TflI9OIyrFuYf9wTaZej+78m/LiJrBktc=
X-Gm-Gg: AYBFou33vYOGEdlPOiNlFwzYeOzbmxYQiB2sj/DHFnHUHPNacd9zpRf6JdGm4KPVpJD
	i2V9eVGz3leivFo3XmUCXmYSk7DGi+Kba+UTZkHhdyvIvSLTfTRD3o4Jd9Rv8JTNN7ltTVwoNxL
	2ivTNV6kYtTawyhlXGgOOsxextPsE+WMhcMYi5HaUwp7Q5h9H5KiyoSA+q/p8vFx7hRb80aksEv
	uGU1wEEGDpAO6lE5IkXqg8OtxMk0sT6jxxngMBiUy8pOVZYWVRscPWhUfZXe21q9N8rDjxPRBje
	lngMdjUw+M869a1fB8h1T9iCpPP8LirTT56MuFnCnaGWV+gQWuqjDiBReKovm943nyFUKf/HqHL
	Wurj05K64aOFkOA==
X-Received: by 2002:a05:6102:1495:b0:79d:dab6:66c5 with SMTP id ada2fe7eead31-7a024dcd3a9mr2963932137.2.1789565431464;
        Wed, 16 Sep 2026 06:30:31 -0700 (PDT)
X-Received: by 2002:a05:6102:1495:b0:79d:dab6:66c5 with SMTP id ada2fe7eead31-7a024dcd3a9mr2963772137.2.1789565430895;
        Wed, 16 Sep 2026 06:30:30 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5b22b2sm136121366b.36.2026.09.16.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:30:30 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 15:30:13 +0200
Subject: [PATCH net] net: ethernet: mtk_eth_soc: unregister net_devices in
 case of probe failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mtk_eth_soc-netdev-fix-v1-1-5dac50eb65b1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MUQqDMBAFryL73YUkVqG9ipQg+lKX0kSSIIJ4d
 xc/5zFvDirIgkLv5qCMTYqkqGAfDU3LGL9gmZXJGdebl+35X38edfElTRxRZ2wcZOfRdQgtume
 AIT2vGTrf4YHUo895XppOe8ZtAAAA
X-Change-ID: 20260916-mtk_eth_soc-netdev-fix-a25ef3e54fe0
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Af4mc6kEWPQ_1r-X31cv7tjZXZP-Pisz
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6aaa99fd cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=q-zEs5IEZV_uNfpMk_gA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfXzK0MQnUmdM7B
 +Q4H4fmIX9GZ2VNnh8AZhWl7vceHc48jYXks4BCjlpFNpN09n6FIiNYusgrVBfiswv4st3YWWlX
 eMD4OJW25aC5Bl0Gu6tX3Tr+ENvP6wxZRtkf4UPqsAsLyUaX8SgN6uat4NPscMsfJ0dD0Md1W5R
 mrjjm1d8Y/GLverDHvrU4S8nBTohCvTeS+Hs1ZGhVmsHQdf/Vzc6DB4tjoTZEppJZvBrCyITIqT
 XDWMKybx5EwGBXb/FiXd8wlkNlN9RokQLyCqcmntUAoCKnqFVT9Mm4PQIIy/tlpv8CjOUvBboJM
 4/t0MBd07l+3kHULM9ccEZ5OPyonQuNZHIZGwWd0Fp5La1FVvx1z+wWNiya0J9suRt94HaQoNw3
 Dmp/eDAywI1yg7GqAIp1GOgz6KUlG+W4XewL/QV/F/+CLq9q3PR0YDCr1EBZWMQNlp0I+ZhoHSZ
 fhIsvFEczuFCtMjG1Ng==
X-Proofpoint-ORIG-GUID: Af4mc6kEWPQ_1r-X31cv7tjZXZP-Pisz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfXxVRly7oSKm9F
 vMnUNiLo+NqjIBqq1tQbyFYTwIPmHV0fclHIDgKrElgUJ7W8qEr37fAA+ttc3qy4ztmbZo4t8fm
 k80FqdU0dW4ntw6HN9N6b1bqiSCAQms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160181

If register_netdev() fails for one of the MTK_MAX_DEVS devices in
mtk_probe(), the error path jumps to err_deinit_ppe, skipping
mtk_unreg_dev(). The previously registered net_devices are then freed by
mtk_free_dev() while still in NETREG_REGISTERED state, hitting the
BUG_ON(dev->reg_state != NETREG_UNREGISTERED).

Route the register_netdev() failure to err_unreg_netdev so the net_devices
registered so far are properly unregistered before being freed.

Fixes: 8a8a9e89f801 ("net: ethernet: mediatek: cleanup error path inside mtk_hw_init")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index fd7a49ae88d0..2ea5dfe85539 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4509,6 +4509,10 @@ static int mtk_unreg_dev(struct mtk_eth *eth)
 		mac = netdev_priv(eth->netdev[i]);
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
 			unregister_netdevice_notifier(&mac->device_notifier);
+
+		if (eth->netdev[i]->reg_state != NETREG_REGISTERED)
+			continue;
+
 		unregister_netdev(eth->netdev[i]);
 	}
 
@@ -5344,7 +5348,7 @@ static int mtk_probe(struct platform_device *pdev)
 		err = register_netdev(eth->netdev[i]);
 		if (err) {
 			dev_err(eth->dev, "error bringing up device\n");
-			goto err_deinit_ppe;
+			goto err_unreg_netdev;
 		} else
 			netif_info(eth, probe, eth->netdev[i],
 				   "mediatek frame engine at 0x%08lx, irq %d\n",

---
base-commit: ceac0de741bfb47ca255eee075257b3bb31f0651
change-id: 20260916-mtk_eth_soc-netdev-fix-a25ef3e54fe0

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

