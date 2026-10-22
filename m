Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661600;
	b=RNEMOWZlmwkovN2856oMhJLv5+KccimV7SAnomJquTIxX5Iv7ym+0Q33Qy+DaA6GShG5
	 d7dUUUDdwSTZhJOjaq7KSP64IxYe8ijRgeezNnrz3rWH+apduprZcG83DlXHi3GyjFMST
	 CGKfDEcBzaAzTpLnY5Ste5p/gso8pBL4o1xO3Jq5B8uB8M9gsOYYEfD7OtEYls7JSI2E9
	 t0MWqrg2c1R30ZEPi4Z7MCW0Y4aXX7lQn2q/3XPYPAqD7o46S74KVwC8Qxzxe4F468GJJ
	 /yqLPyV5DJdWLLijSYEfAgMqDlwi6TS8FfsFQxjJksf5VhOoyGly9lgmw6x5AVSKm2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661600;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=it/icbLfuO7zXriCFppfnrdl0soBaT5iCjZVgkzuDBc=;
	b=ezpJh0+lP2SJS+NAYHr218tRthQRXlzvG9Xkm6o7umbwRJtSm5AFrK9rW3cpst5oVZ1w
	 7hM1V0PA/CnNXg++AfXqN0m3Uix34a4oZVfCNKBhPoaGqtmobnOPEXl8yeESnoSgSQKKK
	 FBIfj0CyaBTpKrq5Py/BLoesqIsHgBq31gZeIEH48RbvGq79IU/sfBmsfUuFtTfOArjnF
	 /0TG7pfAFmSIHabvxrQs3fc6ftGEt0bGmqnfqUxi/ZUB13lr/pHbsz/gJf9ebeecl5AWS
	 JdjY5ul69KL1bMO4K1I5SFbkm/CEfpg4JFxqxShogDPUVaiijguoZOGVqcHZwA4ftmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z2UWOBNV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hR5TD3Hk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1E606A33E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB1E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z2UWOBNV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hR5TD3Hk
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M7G4qL3061843
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	it/icbLfuO7zXriCFppfnrdl0soBaT5iCjZVgkzuDBc=; b=Z2UWOBNVKgkBTWvI
	1kRnqRU/Ndr0LmFB/OvodU9B5ZDAG509yDDtzwlorCEqwj2uTu15jZPTD4eMVWJL
	Jm2v8EXSiKRuvSB7fQUkJWEOvMlYiDPUYhBJ4UV/G14Z3LeqWI2nyWvW6HRU3nV+
	RTXYdFQunMfmlShUjeWWk5+dh1b+2/pFDSTV82vfOhY6Wn5WlPBoRzUvTrZ3uDun
	czHKrVoMTPKBQYkarrBEklSAKyC+6VtpKzoa5DsfkZ/CsRX/68jREOMJzg1NB4Ps
	MwafJp9m1DCNuJzWLZIcKHVUfdgoXzMG/A/CmZ7EWiGzgqsueamXx1pBlMOYCDRu
	17ggNw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93asnm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:18 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-151ba226e1bso2971756c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792661598; x=1793266398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=it/icbLfuO7zXriCFppfnrdl0soBaT5iCjZVgkzuDBc=;
        b=hR5TD3HkWMvhhDjMr81hpJDXkiGYneb2M/pp+3+rwKZuyePadDiuMmLKeMNF6ybjGr
         ePJAC+fF+M7eNTw9t/JNd4sa2hxrEumxZFS+D0WabBf/2TMxh+7cDnDS8x6f0kaMWu6A
         6DB+GmT3zbgiI+7F2pwIMJOggIMpZIVPJWN4cyOBiiTBdooW8S5NXjmjDdTf6+BEoqQy
         /66o8e4wi8TqNo+/1LjDY3IBCkjIGhQgUcwH/LkvvnbJ7dsWk+lelkdffW88XUohqBRr
         K2S98mLHf4Gwi6y3MuisFMGcS3O6uQKm+mh3evNqoFWvsAM6FWZpgD9NncliCRXbnnD7
         WF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661598; x=1793266398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=it/icbLfuO7zXriCFppfnrdl0soBaT5iCjZVgkzuDBc=;
        b=opyi732l88sT/l6e/rDCMy6Sl9xBeN7LI2ST7HrqWG9R1nDnp764cIbIfcOTO6yyD2
         OZPl2MdKKfrciGjNVSTWqy9e6jW3QGLFVPekXxEDlphd3AwwU0Yqi69vLwJdi1yk19U8
         mRpIFgMVO1UJ/vYehjA0b05WOrurDX34nyg6juptKHMBot48ZLu13nV1ZCYjJX2AY8YD
         VtJbdrNaTHIeMPl1Ls7VXwrsROQjp1DtUfpCXfIV8nFpty6ETPZnG2qHz3e/WO+DR2zf
         IQyqGWYcIzG5iYHbqbygPjuBBBgw+5ZIjpi/9jdmUwhQ+MSi/Ww6JE2td5JHOEOKZxsJ
         iZvg==
X-Gm-Message-State: AFq9FYLQiOok39EZtTZelaNwsIjdzYj9jvmS3ly+lvl4s7JBv39skrUc
	iHBwBkrzrUgFv/7OLybXsk5ws/mHjPP7SXfDm9E09HZe3TVPxcvxeo8dvejm8loTCMJh2aeCjeh
	oIM8cfnGxlRPRNfEYhIKTCkFtVP7m6FuObnsz2lnVZRVOzYH0pCndyQQsVDI=
X-Gm-Gg: AYBFou1JBqJpGbGhn2CcerxEHLlVO8j9EoXOmNTWstFvwX0Ewwl0MFDKzephL520l81
	6lSrwiroEf6+dxtKIvVsgQtSoG2bMXV4DhN3QbKZayTmvJA9aej4B3Y0/mNHBfpBKCFVc7kRACt
	bbwbupc9h9FXoP41j9m1y6rq4CBT10ulffMZFioNS84cAvrbb4rQ4aOAG77AC9j5WePjPIXj8Zx
	Ow6lVkd5qc0bw9aIYtM/fEoPzocejWZM9e9IjZvM/DxLg7HDJG4nsAml9ctmlvx7vjWDg1jUAPV
	omCP4Ead/dTkaKRLWK8gBCGy9bk4BvfOEqYb/MDamyicrsR5cy82F8BAy/dOENFviaXmbw1mrSn
	cOTU4t0o4YLZyBbFO/uwrTy5T+MX9VqSWSSUk0+NKOzydQbWiugfW6eB0Dig=
X-Received: by 2002:a05:7023:907:b0:184:992:c9ec with SMTP id a92af1059eb24-190a6eb59efmr6039507c88.38.1792661597595;
        Thu, 22 Oct 2026 02:33:17 -0700 (PDT)
X-Received: by 2002:a05:7023:907:b0:184:992:c9ec with SMTP id a92af1059eb24-190a6eb59efmr6039476c88.38.1792661596987;
        Thu, 22 Oct 2026 02:33:16 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25904494eec.2.2026.10.22.02.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:33:16 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:33:08 +0800
Subject: [PATCH net-next v4 1/2] net: phy: aquantia: restore EEE discovery
 in get_features callbacks
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
Message-Id: <20261022-net-phy-aqr113c-fix-pma-capability-v4-1-95a17f75dd7a@oss.qualcomm.com>
References: <20261022-net-phy-aqr113c-fix-pma-capability-v4-0-95a17f75dd7a@oss.qualcomm.com>
In-Reply-To: <20261022-net-phy-aqr113c-fix-pma-capability-v4-0-95a17f75dd7a@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661591; l=2347;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=metYIqaXeyP43pnJ0wLjM99u+BeRf05eZ9uzQ0wdxpM=;
 b=YO7QeiFzRlKNfsw1jWiZHldtFnLd4IhgxZlWvygOT1kRqrKPXyC+cRAhaz742iPwVDDBM7lRD
 JVfjm0g2GK9B9ir/N31WdG1YtsHpynaRMb195YbMlI6YRdSCeGyE6qw
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX7F/CYDwraQwV
 zm6yGg4bX0AFzziGVlXnCmTwPZP/9QbCqtNQ8KgEhtkCDnU2ntzwGJTTvHYT5GTjlR8sTwVbYzI
 TZzwztk8t5IqDo8prPUcgpal0s2ns9+TixFblSWVBOkm04Ba2wCgYnyPedvTSQnhuQP8FysNZmU
 MdKWqBiNvgvaxU90nUreNn66QSudm7aTivzs1wliEvRBhYK53677nhrNxsG7OHEUpypV+D0x4kL
 cddwJO5XDBBAkETGN9SqIQgl+ZPjtXnKg/TEbuf0kQFU0y9dbo1z5i2/2va9NVBDzl6uP5iSHDL
 jleSRH17XRiSVG9EdbkAVtatECyOlffkQt2pi+hlbFQ1vm36Vpm96TKbg2VsP1lsa/ksKtvOvY8
 ys3PfGaR37j5FQetEsHt+Tymxc9XbVC3Kp47sY4fAPKC2DUb1bo5fuzFdiqSSND9rdqUBTziPpB
 FMFnIDL6AuXn0ibExZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX5LngWbKmCcvu
 w8xyY+noULwOH5xC45tZT5uc+/I2OWi5sw4DcAi5HnxargkLHMr8YCUz30lmwDTbn84REq7uUie
 h9mZCVQbQPNAe/sJ/J3lTO/eFv36pcY=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ad9d85e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dClg1jYS9o94HfY0LlEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 4T6PgTvZTewHjrh0-mvHf7Vi9y2LygTa
X-Proofpoint-ORIG-GUID: 4T6PgTvZTewHjrh0-mvHf7Vi9y2LygTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220037

aqr115c_get_features() populates phydev->supported by ORing in
phy_gbit_features and setting the 2.5G bit directly. This skips
genphy_c45_read_eee_abilities(), which fills phydev->supported_eee.

As a result, phy_probe() never populates supported_eee for AQR111,
AQR111B0, AQR114C, AQR115, AQCS109 and AQR115C. The kernel then
clears advertising_eee:

  linkmode_and(phydev->advertising_eee, phydev->supported_eee,
               phydev->advertising_eee);

This means EEE advertisement registers cannot be changed via ethtool
and ethtool --show-eee reports no supported modes.

genphy_c45_pma_read_abilities() is not used to build the supported mask
because these PHYs misreport PMA capabilities. The supported and
advertised link modes are intentionally unchanged; only EEE discovery
is restored.

Fix this by calling genphy_c45_read_eee_abilities() at the end of
aqr115c_get_features(), after the final supported mask is built so that
2500baseT_Full is already set when the EEE cap2 register is read.

Also fix aqr111_get_features() to propagate the return value of
aqr115c_get_features().

Fixes: 17cbfcdd85f6 ("net: phy: aquantia: AQR115c fix up PMA capabilities")
Fixes: 8f61d73306c6 ("net: phy: aquantia: remove usage of phy_set_max_speed")
Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..099ee919de94 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1079,15 +1079,17 @@ static int aqr115c_get_features(struct phy_device *phydev)
 	linkmode_or(supported, supported, phy_gbit_features);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
 
-	return 0;
+	return genphy_c45_read_eee_abilities(phydev);
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

