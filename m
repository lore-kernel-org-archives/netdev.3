Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE43BB9E1
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121014; cv=none; b=b/EWlRYdYWzAJ+YMDVSriJBpz29uZuJH3P21YYb45+r4z+l4UjQ/rj46DjE4564fEEIUXgcf+XMTJJg1gblA6q5tH64heRxWt9OMfgosL2NuGuPi0dOMoZFyw/OqofYEytyMH9WZILcEXjeumNHNyH6a277RK4pa/C+dJ11i2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121014; c=relaxed/simple;
	bh=gHoevFlJ8f4J6mxGnrBN2ZcH7vECwqYOa+9ckLIRxGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngKc7nWhRWZY6LadZ1hmpEMzbYjJyofeTs8X0XYYwzlLM7fuPYk1uB97dUacDHb6FUt8iA95Vu43ts9hHq/NoMWDpBIG9269AeBMHb51lb/GqZGH6TIHFQFdBSyiXS/DD4VQt9TpKZkXDRN/OezXdvd4Q0+qs44VJ8XZO2C2ung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hp1/0zI/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BIbLUO/q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hp1/0zI/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BIbLUO/q"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G1Bvm61890484
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0/Zj0MYSFvI8JS+zbx1HrjkY5oDDcWhtrhbfmiCpKU=; b=hp1/0zI/ZJwcspzN
	MoC6M8AyyA6QbfgnN3gTLD/CdGcjDw8dQmbP3O5MH6z8LYUZPT9OkbagC05AHSQO
	Zr7irxieXeqMI93f1LPwprPuT+7F2LikPVKayeE0+eNT7VuGozLvWjOvygcFv+Hb
	dS3pPvD/CqVG/5dxf0KBYVskyYHh8owK8hiQKOxy3ancD4OB5Fq6BU9D983sqwDf
	u9Y0Rq6tLKrkzPO7UJq8VRhA9EWoQEEYfifePdaWRrBb7aMiRa3B8LKoyol6dzRl
	AbqKpAdt1TiHamPhZT44+PukZdviNvuwDIpKRJ7SmoQzaxFodP5pujUOlJE9gki2
	mM4yPA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hba260c2a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso8602881eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792121012; x=1792725812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0/Zj0MYSFvI8JS+zbx1HrjkY5oDDcWhtrhbfmiCpKU=;
        b=BIbLUO/qRLiiuQmWybvJ7lYLeYFLTpJ6K7N++cE7cZv3EoUBK17kJP3nQ+91Z+55pS
         WL/M0YOpsEWxUIWv7HTzP+mfpn83kCNXjTYozj51D4RTQT/MxaJYnJiMFlEmFSKHrEvq
         2vv+jb+tdZt2PtMyjfSXSzKPunzfqRxhUD1rYpGSZ+KAdu3oN1iOn/ji+LIj7S6F2F8r
         gjNQjk2fDLpLSr8uslBsYZhd4HpGsZQhTzD9jqtBa9hXpC1sbfVqU6gHZ6evhDWJg9pX
         poXGvtwcapq1AXdnwZhb2Hmn4JnR/oGg721B3LqrIZYlM1Dwt74itQb6eS1bv8OzZdYV
         8EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121012; x=1792725812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0/Zj0MYSFvI8JS+zbx1HrjkY5oDDcWhtrhbfmiCpKU=;
        b=STO/RhQMGev71om23pdal7Ze4q4xkwPxoZ2DPrv90iExoWMrjk3+KlAo8yxrV3Afoz
         xFHSyrEjcvA0893yBzJ++vZj2gE8T3Vq+siEvQ5vrEP6Cb89kxZ4RQany1CdGcTQiEYk
         tU+u8QE8t+QSkpg3j/Ve4IkYjpNN9+Fb1E0FHdF0s0JqzH8SdZDmgGya+i9OcH/vzee0
         aMEz9sTCT5/miMmzKiH3GGweh4J5E5ga0AGchL4IK8zhwg9ZbtR1UCoupa9mhg1forIV
         c5V8iraXMFiuWbufJ5GwzcYyQup0bGrmE0Zsf0Qm39qQNk2X5A2KOt4QlMeHX2S2gdDQ
         +2nQ==
X-Gm-Message-State: AFq9FYKEIIuVU7crQUWqlRubZMRISuHUJWA84FyB989tL4bCrf6qI/3k
	A+pPTy1nnisFC74t/QMUc+uafiLGcsljgrYgVUoxyz4ZOMIbuF1cWlv+nJv4RMdJHmD8hINSefr
	zNTr3uJUCY/kjz2teiYHctBKFCoWSy618fvz+GG6mxzTfKfXhiBB+lZL/f9g=
X-Gm-Gg: AYBFou0uGQ+s9s2Au1nESgT3+BCNriJgEGlupHHHioTCyPQiVkTqMh5Ek5xtZljlpR+
	/b0oMErWdwaf/YU9zwby4iuWG9SAv89DAznbLWY+LLMp5kk1eBb9r+saL9vfxLsmlwd3D5JGdkO
	g6NlQvheIut3OkHgQ+yXHkP8gFXLfxT0twpq76HHASjcpjWdDuknXaw2FD26kB7AVeM44IuwRYo
	AyN9FJaIzrUIsWQ0MAV45cO/QlG4IQTDxnd9Jm5HurBA4tr9J7G7/P3LonoOPx00AG8JKI9Xw31
	7MNxphbuPGswWP+iv8GfOu2cSTiuIKTvUsoRNItGXivs3MJ4oo1paHnWx9cJuDUQslrKN39j+P4
	cUf/0W+z3mwpUPLJc2N8alOxQ3dQz6OL1yTE3IUnJh2/BHGHfAkXjy5XNwOM=
X-Received: by 2002:a05:7022:ef04:b0:183:c7c1:879 with SMTP id a92af1059eb24-183c7c10cf2mr199982c88.1.1792121012205;
        Thu, 15 Oct 2026 20:23:32 -0700 (PDT)
X-Received: by 2002:a05:7022:ef04:b0:183:c7c1:879 with SMTP id a92af1059eb24-183c7c10cf2mr199937c88.1.1792121011630;
        Thu, 15 Oct 2026 20:23:31 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831bd28789sm1674445c88.19.2026.10.15.20.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:23:31 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:23:19 +0800
Subject: [PATCH net-next v3 2/2] net: phy: aquantia: add get_features() for
 AQR113C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-net-phy-aqr113c-fix-pma-capability-v3-2-0bbb1b84035d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792121003; l=1800;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=gHoevFlJ8f4J6mxGnrBN2ZcH7vECwqYOa+9ckLIRxGE=;
 b=Y+qvEBYqzncCqEibtXBIX3e4JphkK77JDqakBLSvGUOtpbkUU9JXECxvjzLL36vfHdwRWFXyP
 xZW5ORm0x4aA64mUfUCWiNuuhixATTwJescTBU7W63bJ6Mb/J6sEKqt
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Authority-Analysis: v=2.4 cv=bsHZl0ai c=1 sm=1 tr=0 ts=6ad198b4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VC2PuVUzhp9AgKou7WYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAxMiBTYWx0ZWRfX0tVlvrj+pqnv
 0b/8HJoLe9isLMjiA6ksztQOnswrjIHKLXHej+Tls2F8tLike9CN7q+ohm+/Uyz2btFDcKjZlsH
 XZBdWcHGSB5lNr3TAhurtf/5eUl/E4I712DEBzYwz6+QXU6hs9C/gHwD++G3Z3aR4ADN0rnhZow
 N+Fyw8LhxkNds2/PSC5GstYA0KSjH7VWZv9us6GL5Xz+1uDoS934NYEPdQ10ALBF9agdSdS0tHi
 6VaPAN9hH8nYkNZ/aSlO4rE6yEMk++lSlXEzrqHz0Z2weTfYcm3TYO2IyYqkguBAMJUDY9XpCJ1
 Pe0wtssmsc50lmmuIdPhPnA5AX0Uf81w2JF7DmnH8TvV+CtDMpNSHNAFlm3EhMHbUCzqnxV0zAG
 18gTyAvYRD6jdXbE5d1VFIixYnjYyQQQbQlUW9M1zEAsUoWoLsB5gRLMW+4zdgDUmhaTteAwCCO
 OaVF8ks9rZKAULhcsUg==
X-Proofpoint-ORIG-GUID: uJMJsDtjiU-OuePx2r622ORzsvfFLFdA
X-Proofpoint-GUID: uJMJsDtjiU-OuePx2r622ORzsvfFLFdA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAxMiBTYWx0ZWRfX9vZXba88eXhW
 vci796vh1PqeVSJmUSd9Gl48w8ZyX7/CsEcjXHHQdXlWNWIS5GrE2kvGdVLhnQkZ2iTlRLbPg9t
 4Qwt2kIxeZoQMylGv0mM9CgeWbiJRIU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160012

AQR113c does not correctly report its supported PMA capabilities
which includes speeds like 10G/5G/2.5G. Add get_features() to
explicitly declare 10G/5G/2.5G/1G support instead of relying on
PMA register reads.

The AQR113 likely has the same issue since it is a closely related
variant, but this fix is limited to AQR113C as that is the only
hardware available for testing.

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index ed5631f2956e..8213d9a15b4f 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1096,6 +1096,23 @@ static int aqr111_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_get_features(struct phy_device *phydev)
+{
+	/* Generic C45 PMA abilities do not fully describe the PHY's copper
+	 * autonegotiation modes, so add the 10G mode explicitly.
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

