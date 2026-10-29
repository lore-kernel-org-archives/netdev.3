Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266103;
	b=t7DK5NJCXVBsUSCVmyIrWB/GWC0wz9s9akcDYpJJMG3ICWTqqGWXBWFVtxE/4oLdaHFl
	 xuAm0rXq8EIvoBoryxOHmOkuwJN3dYdioJPgn0kusaHlLn8O0bVuKWR0ppmxvOp5EpvpO
	 LbZErQsM7RYDgTWSJy47bjLq4CtcWWHelmJDtrzOa6lyg1oxuzTQVPzAuwR4JoqoQp9gj
	 hdf5vaupRsGUA+sff2t6vGd5x5ZdzB54j/fIHG4kTOQXF2dtBfkiVNtOPPA68At6cdBI9
	 maGYdEU7Kn9McCBPDcWVIClD0JRHuGHpt85Ta4kSfyQA3cKZaOxI/HIsIbAV0MHgMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266103;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oKlw85osON+mVbqczkz1GEPgxIWaF4G95QcuqOdPsWs=;
	b=GqsL0vZOyUbgCbfVu0fGFsnOwufh64tW4TBQ7FzeqRleOyJTLzTBH01rjEn2rBQYne8p
	 xRxmdZYgtbpNN0eQVWEY23elZsVevUVZeXG4XjOW6UdI3GjzcYEot0G9bkJs0T/u3OtWc
	 pIOrf+TGGnzwiwf01o5t1viKDifvyQmwdSezSXxJmF4gPxinKuu6AzznUYrgxcLp49mZT
	 EHOD0zlkyYHWkXwfElheQnWpEymiOnkFIwzIYUhrPJ7Zpe9AWRXUlmzI/QuUzRABFTb7I
	 rgpKRIhan1LrKwCnGnUM9xFD7zdxkOxVJnoMoS0h+kymNdiicSxBGk2UqECc6fUXI9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YwP8PqdF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hyxgh1bP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFC606A329
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EFC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YwP8PqdF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hyxgh1bP
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8v8gB2273140
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oKlw85osON+mVbqczkz1GE
	PgxIWaF4G95QcuqOdPsWs=; b=YwP8PqdF3A2ToAjolo0z6jpEfLOqpfFkpoyfov
	QODVdZDfXcTe5HydzYqIjKqAFdV8GzC4qgAIi1fi+We4FdT2M/4f2OxNirTwx45Z
	tX2dhQx3VmIW1IbJnm58/vl7F7FMUA/qlJa+i9l9CiUm10gu7uqIAQbUt5QkOaIV
	otwFXKUwk2A9GjB6FrvhrgEkCbzRSskCRxzqR4MxZ4o5sHCPuNiv8TTtdY9QS81M
	o2E+oYM6I0dRaUSeOY+GE/+sIiR7ucDp7kYIVPIBQp7keZKRQoD0O3uHfrtWCb0z
	4ZlL+UUDiNjxQi9pAJBy62pRt3RgciwtpySDeBERKVk6FrUw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b04ps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:28:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eaae62796dso19963615ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793266098; x=1793870898; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oKlw85osON+mVbqczkz1GEPgxIWaF4G95QcuqOdPsWs=;
        b=Hyxgh1bPKcKnSDw7Cl8evTuoF0n3cgJLnYet+tDSqFgW7zzgz37E83Y+ZyF4ACG787
         hlxWfmp1VqlsobWeCvYDmwrbnC3s7rJqK90F6wG5TbYTLgLo39CoTtmNUSCEcEv2NzRF
         8Jz4rfJr8fzLYZ76bQwQZFmkdr7XNWzM4DPb254XIYDkMGBHbRro2qoLvxPLA1O7YWo+
         xYNppUA5UNaMMeAPotKxZfKY1GnMLuj5MPDPLe4aCwfqbMaR4rPipXx4YjAoRcrTjqZY
         HAH+yzlc57b02YrPWLdDsSeN3UJYIS0fdsbw3I08apOxhruU+5MaycDfed42KF+far6g
         SGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793266098; x=1793870898;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oKlw85osON+mVbqczkz1GEPgxIWaF4G95QcuqOdPsWs=;
        b=iQpr4hmUN4qSVIvXNaiL+PVglN9s6LpdY+OQTCjspJ0Vi1i0ZzeALWLN6RuZ/3usCc
         8xHav8s1grd3CZhscQj+60eAkeFTC0Q0XyfUB+FWCCJTnXAIfS7OpkwRVE2CvcNUjPY/
         5Cll2QWuKUP3i1JwllBfuPceagixs6XAFgzU34Os8AKRQUUK0k2hSxJ2wo/iA46MVUxl
         584p4ltazKVC7zmdLAiNKW26HfHy7X9nD6WQXGyYbobMdESC/n354pNIMeq6lp5dNEa0
         3ajGeoKXp9LXQBhgnYTyOAJMBGREvSs1crUR7rt4NUhgl5kzMIzYiiOuUTIxWrnOLqDE
         LwqA==
X-Gm-Message-State: AFq9FYLUYjMxclNzAXaAJaTen4ZYleDZeP3mHsQlb9taE6V8ek5gfi6w
	8hm7MW4tDq148AIXCSttSHefbwlfhcaFWqCbxW8pX9CjPFFmXVoIzAjq904gAjQyxC6F0fZz61X
	cnDOi7K+galkgIzflhh9eS17U9W7rbYAINfOlBdcfW5q0cgVnPExJQ7Z2JEs=
X-Gm-Gg: AYBFou1GbhzivYGoZn1mdYdZmqVHkDQ2z/M4k9E3yrU7v4A1eG4x66WJbvRIXYQCy6U
	ycjRuabkizFj7W84ubKNJv8z6G1ukk5tl8Nbyn3pQ9fUBSYiQRIB/IStdhNvaJJTszGuN5brc5c
	uW7lDw25iE+ZaV1tb1S3AwPKpKbTUksZAo+XFHmWrslrWMm+B8x9h+GbdjOt6dPbD97xTMVlMt9
	x2+SHPoIv4JEgRvxvrQ64r1c80ZahNyhXOcg04dZ61QcXtRg5v0emovhag64FJpHWI3OZquBOdj
	v8KYjeIDeruVAxdDIXqAIqG7IFKmN1EeWo7BdqrAvW2dl6xb/TsH7vLZIiDYbf8y/kaIgniH3KG
	AN2mA+s1SaARUzKLYbnpaHjz4qtV0YGqabN1vVaTLWsxk12dMdme2jMqbq9dBYgbZP9I595VAEM
	6SP8QLixsLJvYUJJlW9+VeDeSSmLDyeEbt
X-Received: by 2002:a17:90a:ee94:b0:3ac:a203:e095 with SMTP id 98e67ed59e1d1-3ae57e07c44mr2508944a91.7.1793266097664;
        Thu, 29 Oct 2026 02:28:17 -0700 (PDT)
X-Received: by 2002:a17:90a:ee94:b0:3ac:a203:e095 with SMTP id 98e67ed59e1d1-3ae57e07c44mr2508928a91.7.1793266097195;
        Thu, 29 Oct 2026 02:28:17 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c59a6sm2884765a91.3.2026.10.29.02.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:28:16 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 17:28:10 +0800
Subject: [PATCH net-next] net: phy: aquantia: Poll global status register
 for provision ID
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
Message-Id: <20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKkR42oC/yWN0QrCMAwAf2Xk2cCsWpy/Ij5kW6yR0s4mk8HYv
 1v18Ti4W0G5CCtcmhUKv0Ulpwr7XQPDg1JglLEyuNb5tnMHpNdMyYRwyjFiiLmniGpks2LhIGp
 ccDx33tPR88mPUFNT4bssv80VEhsmXgxuf6Nz/+TBvhfYtg9l7LrPkgAAAA==
X-Change-ID: 20260923-aquantia-poll-global-status-register-d8966a46e56d
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793266093; l=1877;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=BJjWrToh5ToA7lfILPWUlVKQppN23gW151TWVDpJEbQ=;
 b=1av6qqk7OUfjzHOhis1zXHoExN/HY6UvN1AjvZd8acRb9zQpeJ+W3ClE/3alDHNO7+g6lwcgb
 okCpuo6ujL/AaM0Pq0SxM3gCJTaO+aWJ52B+Eqbdy9UoZtvz6cBA3PB
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNiBTYWx0ZWRfXxPNV3lPr527+
 3nMyRZcf1+NNDQY3/Pz5TUroYMOTX9nCQBDpvBCHtuiiJOW62vBSPeczKYIDZsP++hJIrqMSjZu
 uH5f9dmG5+vQgFINMCBoyEYYMIiT/vA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNiBTYWx0ZWRfXzDQNiuwXia9s
 2kbKpD+qC282cao++82QGuCpLNSj2H9yLJw0yN0njfqpt+WV3RA82UkEqgrAh/Iv9m0Q6CdhJfX
 AnK0ix/83Y4Slkbd4QLYg4MFwdWm0m903UnaxyZrtp+LArQUHhH4LhgtpUHBtSL0sBWZz7ll2bT
 PXpxBEm/UHg8q5eKZncOBE00mfEm+JTcCafeVIkDrLFcZggI4LcVsXJnToQnLlqSqle8HyFdBuJ
 Cb73x+dvaX4lhBogmZnasFa/0SziAUX/J/bSGf4B5wIEwamrmM/nTLB9OlCflfO+l+OKrM4rlAh
 PfdidpQn+2+oFsJtoCi9qoExmm14Gs4VpghdyMe3mrztdECx6C7kfSMSD3NMTvFMv+kyedv1EC/
 0dHDxYRyfXazKPUeCJ3B4mYBE7LqjuLPWoiUuPsBCdZYTp92e6KYocHzB0leXZEQtFS/w/ZhG1r
 uX9eFf0NY4eZBbjJetw==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae311b6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=lkaxqyAuq-rsphcg5LYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: awPALidQw6LR0yV64vaxUx2RvXBYHG4v
X-Proofpoint-ORIG-GUID: awPALidQw6LR0yV64vaxUx2RvXBYHG4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290036

After the firmware reset sequence completes, the global reserved status
register (VEND1_GLOBAL_RSVD_STAT1) may not yet contain a valid provision
ID. This can cause subsequent firmware operations to proceed with stale
state.

Poll VEND1_GLOBAL_RSVD_STAT1 until the provision ID field is non-zero
before returning from aqr_wait_reset_complete(). A timeout is treated as
a non-fatal warning since the PHY can still function without a valid
provision ID.

Co-developed-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Signed-off-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..1d8429a9abbc 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -702,7 +702,22 @@ int aqr_wait_reset_complete(struct phy_device *phydev)
 		return val;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(phy_read_mmd, val,
+				val < 0 ||
+				FIELD_GET(VEND1_GLOBAL_RSVD_STAT1_PROV_ID, val),
+				AQR_FW_WAIT_SLEEP_US, AQR_FW_WAIT_TIMEOUT_US,
+				false, phydev, MDIO_MMD_VEND1,
+				VEND1_GLOBAL_RSVD_STAT1);
+	if (val < 0)
+		phydev_warn(phydev, "Failed to read VEND1_GLOBAL_RSVD_STAT1: %pe\n",
+			    ERR_PTR(val));
+	else if (ret)
+		phydev_warn(phydev, "Provision ID not ready\n");
+
+	return 0;
 }
 
 static int aqr_build_fingerprint(struct phy_device *phydev)

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260923-aquantia-poll-global-status-register-d8966a46e56d

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

