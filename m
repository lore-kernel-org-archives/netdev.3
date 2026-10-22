Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661603;
	b=3bN+izNzgifAiYCgZqV1qu5N+Yhc5sY0XZNbNXIfxwaOB7HtyGiCOozvZAvBhxS2m7MY
	 YZVADgcip6SMxSXGcSq4Z1v4rR615ahou9Yb3m8cfnR2RbqvL8QbhOb2VDT41LvhGZOm3
	 UQTh80fVCp02KzozLRLLWQfrthFQFYF+dW+WLHbNacYSlpbdfDhZocQlUoMGKF6U/EwfW
	 gxn4v+RqM2RV3JVC83z3pfK+TD/pl0JWSnTbQEmn7wy7TgVtjwacqDT9b7qTHBQX4Spqs
	 nJTGtC9UYLNzMfjTO9IkqckrWDGTd3x9N4rznTjecCnoA4gJPyma8RXkl+XR6+4nOqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661603;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XnmgC1uie1ZJqlG2O5rrj/sc0p/1feL7elowaIlpspo=;
	b=W02Ye8aKkTxuS0SBDRvCtvgW4i3MlcOR4Pj6bi47L+WwVoexXBqd8YfHzj9RO3u16XBi
	 CvZRworI1AImdVtczySDhGs1cdOGwUIyKF7ZJyuqhgDIdnPqP11ZLB+ZqnMOPzBDe/+yQ
	 CqsRnQ/AwIqh9tVRqf+YheY/cQ0WLZj+XAf1iBx+dUsbtIWOWWAoZtquQZIJyoP6j7dbu
	 qFMMgu49VBp66doaSUxvbbD4tGvZQqon0x1eHfaxtUanKW19tbH7abqeMgFvp/Kd9g8bV
	 A0qRSApmdJmqDb3dGVJp48lArc4RvYQdS/ezeN01RYa8FfNjX69LvBNPTggWdPl/XTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mMyrfewt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VxxwYbZh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE9606A332
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94EE9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mMyrfewt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VxxwYbZh
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M701MR2714175
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XnmgC1uie1ZJqlG2O5rrj/sc0p/1feL7elowaIlpspo=; b=mMyrfewtZ8k6BYIE
	7ZBNP5SsAh+VMbOBoxKqCdD9Q7lm6oJDhZTtiIHTrOgP/mUpLg8UqUe6mt8HDEEw
	PXv6BadpKc/HWtvlCi2bGVj4XczODHhs8Av4LLyfLy50YNN39z4kD3z1jnTWVm+z
	eUUlW7qkQC9uQsd4tZNEBcY/t/NIj7cgb6TKBy4EIar9hW0i5P2Mrags/x9y4P+j
	cLPj+pt2AlYHqS7WAvO8e/Zf2hQApb0EvdjEoMPw03qjbMiESZw1OCrrpxbGiIOx
	rfIHGt4RIHhZoz1y6P/OSDp2xCv4G8TI5NmGmQ0140jj8LeAwo7rNC9dapyQCRXs
	/j5zsw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bspjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3698bd5392cso43774eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792661601; x=1793266401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnmgC1uie1ZJqlG2O5rrj/sc0p/1feL7elowaIlpspo=;
        b=VxxwYbZhNng5m9F0YY+h6sqhkVpV366vhOefDD657izbrbyPgsYVukPM3jDx1JP04Y
         9t6/IFv2zOhqBbUhb9XMjCSspy1S+Mc1DEjCTzufziHJYY4oiSG7sIuU7H0iHM4UE20h
         8Hp7PyAdQ8XLq1r75FrcydQYlt8Y80A3Dw23ultVUHdvzZLzJNjvypoKTlShogC7Ps4F
         G2BKN7vYb9vp/HSZoUyvwDfbTiYhhcRWUCaKxyAFNErYpkydJdrAOJjoWwp8Mkn0yaPE
         8D1G9N0nNn/WGGAr4f03+0QgfgOz6g5Qa1ZrD6pyZlDMD5TwDqkcc52L66oO12wvPjnN
         DOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661601; x=1793266401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnmgC1uie1ZJqlG2O5rrj/sc0p/1feL7elowaIlpspo=;
        b=s6LRSUm1t30Tst4GCKOVumxXT4XgS6ZQwh55J2DE1tzeqRjJ8p3EMmL24l3NAJ4b5I
         t58+S02I7pYZbqZYI+Qztj89cV5V7lxjMI4BF+5VOtwWmF7cnDGH61QGUdhlQyKdsD2I
         4QWKEhX9fQj36Nf/W7J2RDgy6Aodetkgo7qkmjZfrJ3e7vVJOhnm+pRNNrOYmrsSotXY
         v0crI1SbsvZ3eW9KMlQ941Tqp+162LzIrNv0G7GSl9mFh0hCkrTIKO7nGZTMyZHt7lH+
         LzNHn7PIhfqh50/8b1hPrcBBnbf4bcqHR9dEI8mB5GHbdrKKah7TSPkX0SsTIgFtZBzY
         EGMQ==
X-Gm-Message-State: AFq9FYKVapb9Esg5Hhd6jAzj2mwve6nm8pjSAeeAYIOIwC8U2ebpn0xH
	E4M+kB3ODUSousQ1X8sVjHpQt963VXf2T5MgsD/yAk4WAmmCbtaCgHLS3+DV1VxajUUv8cOcsZn
	hL+PCAkrBXNnIsKnTgNP7W1hvb+7YvxVtt2HxhXQ6svkWHd1lVtqdlCGkg+s=
X-Gm-Gg: AYBFou1/tu0+Yffwp9KLsIBn4DbJCdlteRK36M1GTA0DadOKWFd+5yQcFeTKbjc/vMV
	c+mvDXJR7ajwyPOv0TqulaSIMBf8xRzDAofc1bAx4B+ImeEl+seA3y56sqxGQEu0fslCJKHXjIm
	XxLE7xvKefIPDJHUX+cdNdFph+Tqr+QPp6enh4ffj0wNd7+zERiWG7LVrtogIr9lPDh+Ah8WXZC
	QwLknZkEJn7GZvml5Gwrow6MsGj37p4Pe9goGHwbAqxbuD0ZOTxHJn6Zd9omz/hZJOHZ4uhU1Tm
	7jsoAuyLNCPa4hsamHKAkWtjBlNQz8z/pVD6Y3o40hy8cVCTtdevtxHhketxiGS7URKDVt9Dr7z
	7Lq54JkGJcd/M/1WURD0nr3Wy103IQFm8wpZB7tbU4KWXh9xIFzNdGdc1cN8=
X-Received: by 2002:a05:7301:df42:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-368b0753da1mr2384638eec.13.1792661600556;
        Thu, 22 Oct 2026 02:33:20 -0700 (PDT)
X-Received: by 2002:a05:7301:df42:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-368b0753da1mr2384606eec.13.1792661599983;
        Thu, 22 Oct 2026 02:33:19 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25904494eec.2.2026.10.22.02.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:33:19 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:33:09 +0800
Subject: [PATCH net-next v4 2/2] net: phy: aquantia: add get_features() for
 AQR113C
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
Message-Id: <20261022-net-phy-aqr113c-fix-pma-capability-v4-2-95a17f75dd7a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661591; l=2119;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=b8Znuju7BMGTwQ/NryWmQ5kkhAufqw6naOURVc0xIk4=;
 b=9b6Ny4fsafsYAJmkRal1YzpK5XJqHPt7/HKdGG4WDIS9W6vUiS8cPSEmaYlQ1u+7Mm5JvvxmK
 e0PC813HKWpDowvdRpJgmcJucsNsO/LEs2eG2D3jiRuvyJTKsPX/RUu
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-GUID: H0nET2B3eDAdh-wOf2SdJ_9wvjY-9ORw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX3EJSTnWfhACD
 Gq4KBX92evY1rE2scQkGHU/Kr+ira5FlAwV18MJUjP/qJeEEajCFThKlQUOJcUSTFAtZDOWI/uJ
 ygYnghteL2ZXjAhDvzbJ1h7Cf04ABJrr6U8bDTC87xZ2O/rQUccmMD0QDAy1bFk/YcCIWNO7VFG
 zFE3hwDNyrx5JDAqYWL1urRNP6/1VVqys3PIjCv16l0v+Hz/QKqenHL2IwZ2/bOvpcE+ek2AOHf
 veEVRPewSf0q1F0Rhzfkfp1dY1nRpLdxIDXzV1VvFp31high4wOhq3O5PXmO5xiT00iaDAUrYZe
 M/l7MjFnGky7vgGEfuhi8OCUaaahGIAA9Y2JcGjANhAG/3pTwQoo4D2405q/nxCGqUdGtgCZhxR
 sNeqeP1GI79Vi9xHF06U7m3jolPN95+4GJ6TbWzuE2AEztFsIyUvtdKJc6g+BOFtPIiHBvKH47V
 nv/jtD2sWb8W7tU26WA==
X-Authority-Analysis: v=2.4 cv=HJxWhYtv c=1 sm=1 tr=0 ts=6ad9d861 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BrG_cqSkCxsaaJcbJKwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX1ZkpqiwcY9hS
 goA5owxk7UYmaGf0TIMsBI+CL7F75u+5CDqRryTJgLOmA1xYIj2XD+lsc7JGO9SPCVvM5xXGfFS
 kVEWRMqqbEMO4Ib3oSn7GGMoegbRSFY=
X-Proofpoint-ORIG-GUID: H0nET2B3eDAdh-wOf2SdJ_9wvjY-9ORw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220037

AQR113C does not correctly report its supported speeds in the PMA
extended abilities registers. Without a get_features callback,
phy_probe() uses genphy_c45_pma_read_abilities() directly, which
produces an incorrect supported mask.

Add aqr113c_get_features() that calls aqr111_get_features() as a base
(which reads PMA abilities and forces 1G/5G/2.5G that the PHY misreports)
and sets 10000baseT_Full explicitly since the PHY also misreports 10G.

The AQR113 likely has the same issue since it is a closely related
variant, but this fix is limited to AQR113C as that is the only
hardware available for testing.

Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 099ee919de94..153adfbda53f 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1096,6 +1096,23 @@ static int aqr111_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_get_features(struct phy_device *phydev)
+{
+	/* AQR113C does not correctly report 10G in PMA extended abilities.
+	 * Build on aqr111_get_features() for 5G/2.5G and add 10G explicitly.
+	 */
+	int ret;
+
+	ret = aqr111_get_features(phydev);
+	if (ret)
+		return ret;
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported);
+
+	return 0;
+}
+
 static int aqr_gen4_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
@@ -1446,6 +1463,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr113c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,

-- 
2.34.1

