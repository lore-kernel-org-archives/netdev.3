Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C053E5EDB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221875; cv=none; b=V2yWxTtKTbROydmkJ47ZgK2h/h6urta3ln4gB1If20iFPueqHYqpKpFnAFKb5FmfGFQpgMdJt2PT0gl5PZMEWSD1Cb8zhNfmgIaXFNSkujpCncMf/vWcKQkeEfaYWApjCYG6do07w13jnKRSj9spNRVkVlcQWGNXIsvqNzWyBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221875; c=relaxed/simple;
	bh=GE8ZkhRwV24xHlwC0qbSLSkJ3Bio+MkFwAz83/yB1qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kJjnJhF+rCEkRz49nF2EtROEWRwal+Ptx+w1jTVOHsd+9U0bvcyHb1TYR3vFvcTVXRENwsihc7VQRod9apW/ZYBOmZCbEdhsd6RoTDFL25XDf1GXQ00nViYbHajsTjHo8cyAmkeIOBZDK5gaNY7crJO9W5hCNUlOmZMsti33AkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NV0EoJ5r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YT2JEtjG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NV0EoJ5r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YT2JEtjG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O36oD7446064
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yJo6jcQVPLmut2XdLpFl9S
	iOwZ0AKuJ7wiJvSKV5kQU=; b=NV0EoJ5rHnU7LPn86te8d1ZgwVaAOBTIn8f25R
	6Wz6NpF+A/lBongMQ6jw2hsopZHoIv+TyhAUVMeWs9+boeICuiajV2Mh9HDUO7e1
	CuDq5tpAwjkYaJAX5sSmkuN3tW69dAAQUiEBZHZ4U0WHx6RtRvfA4+i+96gbDYMI
	pWJMP+gDoHvfuVY0D7eu13pOeCxHe+HGBb+2bArLtuyACYXuKJaXbIGb5sd6nOLN
	pKB/gVSBfG0VhVxOaTivkoMksTYDn0613/jvUWSLTiITeFV9ILbrCCFDuBLAUvTL
	GNY8YGsB+Yr5v8Tgy7GHbyx9LaGuVDcrP/PiHSC+1Q4hmO8g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr908syv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:51:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso506441eec.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790221872; x=1790826672; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yJo6jcQVPLmut2XdLpFl9SiOwZ0AKuJ7wiJvSKV5kQU=;
        b=YT2JEtjGSquL+H2LckIeoIcZTey6jJgaG1dOTlxUO+ntpt16eu4KGSEmWc1x3wX475
         SNpjAHwc3Mbmirfcb3VHS9T87P5bMIZo9dnpTDLVhWlmIRf8ks6xBcZUpR94Ct8NLxql
         kdp7vKXwMI2SIsD1DQWYO1rSE3ZL0ee/P6QyjtIF8ispX+jUwZ4dlBoD0iVIsmQABOXK
         21jt57PBmdxGVI9EPdFJBVCnTxk66SeWnPObY8dbnxR2LF2Y0260P9haztzrihr1iRni
         /iVQfV5o/GViSZ0+/d7oi96xk873LlbU1PobVN8gbkQGRYrhHryIrJVm2vB/UzC3Hbyy
         Ij6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221872; x=1790826672;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yJo6jcQVPLmut2XdLpFl9SiOwZ0AKuJ7wiJvSKV5kQU=;
        b=rGGWcJF2A8VTYpmEQSkA+NMpekU5263/0y6KXr4Va0mQRNHcF/8GikOUy+2UGzOFrM
         Cnmxo6fNA3DpraakDJ3qi1fSltS22uQ5rGmfEAAZNMdfDiy9RXgy5doqyKWDs3MKhKvo
         KZvMMP/b5wYC+UgpzkeCWeJSMh78by68hnI/MTkgxpmkyQUx8C2t2c/heD8EYKpmd2hL
         cukRVGsofgtUz8NcZcaYVHZsNs83gLycb00FHbi0tE3Xf65Iwc90fS1QJWQEaRYKpN53
         hnhfv6Sj9nV1XnMkjhUPMIWyZY2Lc4lqiLGC81OmkatL38d1NdXzRLuF9qNqxxczPWW/
         /4ew==
X-Gm-Message-State: AFuF++m282kgXhVBgjwJOxAddTqrzktW3K7ulA+UXCXhiS+TJyqL9C+e
	zLiP1/VR1Z//ic1g3JE3jl0WdMiMmMKpoTOsAFZYLBTDIfQC+lc0LlU4XIdOPcE6UI++1Jx3ZLh
	BQXns0rWxjI7RDL5Ix4S//VBqlgNP7gSm5qRA8cOSdAYms5+pbg1WvaAFlZs=
X-Gm-Gg: AYBFou1+PnTdi3MxPnnZ0N27RcVKwpAitwqnrrVZU9OiFdukAxrVbBh6BMcH0UBt79f
	91kUO1lHolZ8sIilFoQkmghamcdk48gRTusFz3IlCwcLHo+jkzKTvJfGDNpZl4sbWKI1FfgywqJ
	+R2QHKVf+BWR207Qt51v9rHrD8J8lQg3aR8EXjDKkjw0Op1JTiumk3TYR0pJsxFKdrtNMcKGXnw
	Lt10s6WwHhql5JT1IhU2i3F0BBvxPWzrZ5QaZI1EDBaC/gNVikpFVluHwQkOkuQcd2QKtVBgmI0
	6AETZ4zhQr83hz18Ig1bLLyoCz2SqQsX2zEdIbHMQKAzfiQlh2qk4OxPKRlA8Sqo49+FjOZYEV7
	4aWidHixXtS2S4+Pv2yUxWhuF6b/fqwjg/Qgd7MMIqAAckz9wXQR6HRbxDG8=
X-Received: by 2002:a05:693c:6392:20b0:33e:643c:91fb with SMTP id 5a478bee46e88-34002ee1e78mr831254eec.5.1790221872270;
        Wed, 23 Sep 2026 20:51:12 -0700 (PDT)
X-Received: by 2002:a05:693c:6392:20b0:33e:643c:91fb with SMTP id 5a478bee46e88-34002ee1e78mr831233eec.5.1790221871690;
        Wed, 23 Sep 2026 20:51:11 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm10484986eec.4.2026.09.23.20.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:51:11 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 11:51:06 +0800
Subject: [PATCH net-next v2] net: phy: aquantia: add get_features() for
 AQR113C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-net-phy-aqr113c-fix-pma-capability-v2-1-29b06283b0f3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACmetGoC/42OQQ6DIBREr2L+ut+AtiJd9R6NC0SsNIoKaDTGu
 xf1At1MMpmZ//4GTlmtHDyjDayatdO9CSa5RSAbYT4KdRU8JCTJCKcMjfI4NCuK0VKaSqz1gkM
 nUIpBlLrVfsWKVSSXpeQ54xAODVaF1gl5w7E3avFQXImbyq+S/mAc3UY739v1/Gem5+JCJ+k/6
 JkixTtn6YOnlNQke/XOxeMkWtl3XRwEin3ffwu7d0j3AAAA
X-Change-ID: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790221868; l=1990;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=GE8ZkhRwV24xHlwC0qbSLSkJ3Bio+MkFwAz83/yB1qo=;
 b=o6bRVCk722XWv2o/v8uOp+tjnwXCMezNXPpXbQ05E0t0xfM5j32V+IWvXNg4uCnsxEVh0DGaN
 C3Uqr8W2CI0DoovOy+6oqJxkTDmWApVA1TIqXCPNCzsm7AzH/a128Bz
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxNyBTYWx0ZWRfX7QJDxO0Ed+LT
 eqGggJod4Pd2qx1F8jtWBYkDAkIOkNWORfm/AyAIq0Dnt3IPrqunkSqJGQ+kwJfPGbzrIp8sGNF
 oo/sQXGznmyz/63RyQPHeLa9PuCcRIU=
X-Proofpoint-GUID: snEUw6jzIXFXkTw2pHCxS11WN26nzPQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxNyBTYWx0ZWRfX8JLAPwMhDU7L
 cy4KMyDzzd8UNrjuEtflCvlg7El+tIBoBam4TF/L5EKaqHHZJlmDsUfs2CJ0EhdDbMzhjh1BRO6
 XP06+TTO1j0nKO2I8njtBtIfKzo0cUOvnSwZ5hUPtGdNJQRv0rzdSe8Lju64oiDEMyoUKe1SGx8
 p4ElYMO5sqp5Mgms2KEKA9DgIHzltASwwckPA4XlmW3NXWCoJmJgVvP8+5TT55CYK66saKwy2uj
 uyGmDoVCdoZYRu+Nex1j6prZOlD9aJRnJunreomP2RwJfUTyvh5Rg7DHN7MlN4gxo/XSjyRJebT
 Y5I3vxVQYNT2/1HNxI9+A1g+ZxdOf0KNj1hD9/M/Vsb8nuwVxIoIO/80eqYi+aBD14+xJYGzi8+
 9zJOH7yuGAEwuHZz1s1zq6QFOCSHsWoFxXkgek0dXVfo7EGjHTI3/etJbYzQAmauSPiWKy9+XLs
 HhhfGpLz8o6KPdsXzGA==
X-Proofpoint-ORIG-GUID: snEUw6jzIXFXkTw2pHCxS11WN26nzPQr
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab49e31 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=QBdX5yE6mgm-jzqMP40A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240017

AQR113c does not correctly report its supported PMA
capabilities which includes speeds like 10G/5G/2.5G.
Add get_features() to explicitly declare 10G/5G/2.5G/1G
support instead of relying on PMA register reads.

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
Changes in v2:
- Fix subject prefix to [PATCH net-next]
- Limit scope to AQR113C only as AQR113 not tested
- Link to v1: https://patch.msgid.link/20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com
---
 drivers/net/phy/aquantia/aquantia_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..604f5492515d 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1094,6 +1094,18 @@ static int aqr111_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_get_features(struct phy_device *phydev)
+{
+	/* Generic C45 PMA abilities do not fully describe the PHY's copper
+	 * autonegotiation modes, so add the 10G mode explicitly.
+	 */
+	aqr111_get_features(phydev);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported);
+
+	return 0;
+}
+
 static int aqr_gen4_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
@@ -1444,6 +1456,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr113c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,

---
base-commit: 063510768490d85454a99b27be303aad5efdf624
change-id: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

