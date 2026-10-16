Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DF3AFAF0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121012; cv=none; b=Lwz9/YlJyO4rt5CGQW0hiNoTWMMjh5qzCLC/Gf2P0BjZwIh7gSad6pYFchkZ2Lz6cnu9JGsCJm61HG+JnMfdInJnJvkrmhc0HG97mGt3TR+wi154UMYbZmPTBxW510ijMjRZR89FhISJv6Dw40Z8K9uMbJQ2Gyi3qhxGfa0uA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121012; c=relaxed/simple;
	bh=dCVz4tRFOyWoR4ZcmIINqf6/m07KUSZvSyeRUmMP9yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZDivdJzOd3A+tXWpA7WVm4aOTvXIMwriMT+z1rRSfpAEmYRAiMDpbtd0qEi04+V3fHm24IwDnvX4AxgkXLb0veggG1Zc97vHL1fn5ZU9dRS1wIVJ46t+wE+tyAE+tdN/ga2OipbxZ4CWw88MX1H93CLxG6f15s0gPP5eXFpuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G6vvUqle; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NphNWDMi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G6vvUqle";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NphNWDMi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G1BSwI1596369
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BCmuPilayv/kCdcfjdAzg70FmI02qggvwvydBTD4Kjs=; b=G6vvUqleMXNBvbQQ
	byUl9ljnn3pIDrHGkZNlRrkzAHN+cOs6L3QhlqAjW9Jef3TlOdG1Rip5StnXOJfL
	if9KanNQFE4u5cAxNu1wOHI5v2UpBsAVd5vygNCBgfWWjJOW4sW18jnSVcRa9UKZ
	Dlbq51g1ibYhqzY3U/0tYLTghDt2gJxP2hm2GiT3abB0+wME33y54PVP4dIleB5j
	ke9mOXa/S6D2jsnHCBTjjS/cCLn6Fng5+OnDLF8014c5TMCIIcUfH4hs52f6d2TT
	R8k6XfFk+udOQBX0rMbgi9RH8BJ4kT2UN9BrJTrLIjv0Gn6f2lYgJq5WI5bWpDO4
	xshWlQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2vbjsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so8212564eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792121009; x=1792725809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCmuPilayv/kCdcfjdAzg70FmI02qggvwvydBTD4Kjs=;
        b=NphNWDMiOa22FpqLCl4QlHHvWdU5ahC3scDdBFeBguq0Y7BpBaMotdnl4EUM5S+N4X
         xE6IcxSmu1q6QGKUTdCkaL70ysZUf8ySy4y1IJ600tRcuwTirHguMG0s6eh2rghfm22g
         V2mvohxc6FOlh6HJ4K3+wUkLqmdvJu+H/iDPQonD84TAAe9N0yjs4zot+av8vQJtAFt/
         7P8Gonx3BvRoJV2pqL2TlENGvQL+m1qiZrQ7E2gteHEtPgjeL0vZMoQfq4NsqUV8UJqK
         Tiwk9CXBzi4goVu2DK4sxX1dNR8ErpwSo8mz4oiJSXQjuU8DC+ifePEyGTv++ye36sFt
         FBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121009; x=1792725809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCmuPilayv/kCdcfjdAzg70FmI02qggvwvydBTD4Kjs=;
        b=vUctl4xz9/JQwRfepI5NxiAlwWvcSqszldsNbztkk/dIzuKOrpivLHIzZiZaESrV0y
         e6a0AZ1/Z7Az3mniVfSZ7bBsSwfp5+bDvMSVZTOCvkzJVwfvhGNfJaxPCCQ14/W+jE45
         wjgFEqgQHJCIhvl/RcjZnMn3dwfbRkvWMUEekfqAtzK3XzN/UwV2chnEbn3lqBb2/CCg
         zYa6SE8NKG964Fj9NYIwyVW8M6jbZgBfbn9vA2aQbnSSMrUDCbLC/Anl8ggCZ5feQaFM
         wB97sQ3pIuKIqH9UMfCoxVORjsklS4m8oFAzgH3ds0V8LzCqRmfhOlqlC+qPeMI05+U3
         wIcQ==
X-Gm-Message-State: AFq9FYL9HtIof2e8gXyQSOIgV39oiEeY+gPtlYz6ScdpPaIW95voxv1g
	ulV3AsvrhiiNIZLvfwN2Plptgr43HlC0n2lj64mx42Yb3RX6ZkuCSG5v7i31zVoJM8iIkI8KZZM
	gTi5ultUN3i6UL5hdNNxpkn5EpI18NbSAFX1WE9267t1PbIF9zlJE1f/JqFU=
X-Gm-Gg: AYBFou3pHMVsm3l1wIH4R+N888bvbBgFhtolVgosCXokkd8TvonGv6oRpk9CdpiHiW/
	iwb90jYuoUAKnqQqnaAJoB88dOOtriJy+RlTk4C40tVEmG/6AgWirCYf5xpDYo+K/+fjjyQV/jZ
	CP1oTkdWEp2FeiVwGafMsEpN4UGjS0LpNHJgV0/JYoAqhCCPcaoL3SoDWiInrCLJhbdZUqS0rl0
	4PynJwCjdGuCw3Yxkqfq1Y1WxFSdVXLhIUx8sAH3U6AAto0W+GHW76s/F3KmaO5VU+clIOFOy0L
	l2O8b1XDtXg6Ngt0DS5Yt3Rl2NFYzw7uq1L32u3PK8hRzCPM673n4G2Lq1CyoRwt6fxYu36zUFB
	wuVbpE7Eb5PQ+qI0KeU0RtBpvneBc11gAGFiIowlxMt9v3LBiVfuxxMWO+lc=
X-Received: by 2002:a05:701b:4546:20b0:14e:7162:2ab3 with SMTP id a92af1059eb24-16a5e49fd10mr26892038c88.8.1792121009307;
        Thu, 15 Oct 2026 20:23:29 -0700 (PDT)
X-Received: by 2002:a05:701b:4546:20b0:14e:7162:2ab3 with SMTP id a92af1059eb24-16a5e49fd10mr26892004c88.8.1792121008740;
        Thu, 15 Oct 2026 20:23:28 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831bd28789sm1674445c88.19.2026.10.15.20.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:23:28 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:23:18 +0800
Subject: [PATCH net-next v3 1/2] net: phy: aquantia: restore EEE discovery
 in get_features callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-net-phy-aqr113c-fix-pma-capability-v3-1-0bbb1b84035d@oss.qualcomm.com>
References: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
In-Reply-To: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792121003; l=2415;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=dCVz4tRFOyWoR4ZcmIINqf6/m07KUSZvSyeRUmMP9yM=;
 b=UkSI1HB7yIBOa6B/R+snmNgGSyETsxfh6nNuVHSsCz6Qg+qOFgISGwRHoLKn8nkXN4fw/9s58
 b9mVDD9PTTnAniia04ic050QLQ8skyp0IL0AQuGAcBBIly68l0jlegD
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAxMiBTYWx0ZWRfX4DypdlU6gmrD
 g8mT9Ho/CIfdi9jcOo03DdgPqRXVENJKEEvCyP6vy9Y4dEPN3FKhmrbn4TtoIdMAT3aeBr6NrHx
 2sl0rG1AOtVmFPRh0qELJ+H2MAi3u+8jIR9ifPNa9GZ0TmnPGxgX8IBAVicphsLAYkPyfrQyhI6
 rL+DU5ZT5iDbrDNfSQMir9tr6xqEfRv26oP1MHmYWAEXne2JukJmCkdSU5Ndol91f/e73X1iyF8
 7jrbVl4Mz5JJJEcswObPfpX1wyriMxFBHfbWd1ikpiVPwc0p+tdbpsTOakfs+4GDEodo4ZhtVWA
 Sa/6hc62+FzMEFVjBvfg5KHVhL8r0ggK5bUvKGG/TQE9DvgH/AQv6bGrrpbMru+jDELqxhjacXQ
 s7RGnhHv2a0JdTNshL/yIyx6IgvyX1fq0k8MevAFFseJaBojNEDltlLwbRWB4dGwEJ+SKyW9C3i
 /tJiJXTktwNG9hzzShw==
X-Proofpoint-ORIG-GUID: RI5M8hJx5OC-wOUMS6kWr1ItIpDND7Jb
X-Proofpoint-GUID: RI5M8hJx5OC-wOUMS6kWr1ItIpDND7Jb
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad198b2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=GcwMxrPt_GGS9spnd58A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAxMiBTYWx0ZWRfX3nBozaDIdHhx
 gfa661n2YYEIZZJ3ad+GI3P2uGw8EMZGsNbQWe4qSAVkuiGzgI53EIqSMZOgc/NkTcE/BFnjn8N
 7us8h+eo+MABB5t0Vyj1kp0I1kOaQtQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160012

aqr115c_get_features() populates phydev->supported by ORing in
phy_gbit_features and setting the 2.5G bit directly. This skips
genphy_c45_pma_read_abilities(), which is responsible for reading
EEE capabilities and filling phydev->supported_eee.

As a result, phy_probe() never populates supported_eee for AQR111,
AQR114C and AQR115C. The kernel then clears advertising_eee:

  linkmode_and(phydev->advertising_eee, phydev->supported_eee,
               phydev->advertising_eee);

This means EEE advertisement registers cannot be changed via ethtool
and ethtool --show-eee reports no supported modes.

Fix this by following the pattern used in aqr105_get_features(): call
genphy_c45_pma_read_abilities() as the base, then set the 2.5G bit
explicitly since the PHY does not report it correctly in PMA registers.

Also fix aqr111_get_features() to check and propagate the return value
of aqr115c_get_features(), which can now fail since it calls
genphy_c45_pma_read_abilities().

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..ed5631f2956e 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1071,23 +1071,25 @@ static int aqr_gen1_resume(struct phy_device *phydev)
 
 static int aqr115c_get_features(struct phy_device *phydev)
 {
-	unsigned long *supported = phydev->supported;
+	int ret;
 
-	/* PHY supports speeds up to 2.5G with autoneg. PMA capabilities
-	 * are not useful.
-	 */
-	linkmode_or(supported, supported, phy_gbit_features);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
 
 	return 0;
 }
 
 static int aqr111_get_features(struct phy_device *phydev)
 {
-	/* PHY supports speeds up to 5G with autoneg. PMA capabilities
-	 * are not useful.
-	 */
-	aqr115c_get_features(phydev);
+	int ret;
+
+	ret = aqr115c_get_features(phydev);
+	if (ret)
+		return ret;
+
 	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
 			 phydev->supported);
 

-- 
2.34.1

