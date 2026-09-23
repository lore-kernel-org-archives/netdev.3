Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641E3BBFD6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150016; cv=none; b=oCgJGxczp4fiaBHYxzmbIIbrcbPZtACWOyMSyMAHjnv8gFq5ZaqYeDQQh9A3Wiqgl8bu6jnRbUgepP6Eq1d7PZO81YpOadK8IKY06QUeDBhb/KcvSjwjgQramSvHF4FSBEpmVwDvpYo3VPGQDIJZlad73Zdh5MIJNddvIi8POR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150016; c=relaxed/simple;
	bh=kC5nBHhIYpfYl273YiwKYb4vyHfKZwnavGPb7zVYZfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pWdOJ6/5lkViGvSq8I5MHJYceGjgdNLyzk4b2gScC8dG1MWHEAYqGPaU9SNY5wAtAZ8JdyM7Y2ZmKj3L/4ws3nLx7oqTeE56YU6kX5Kb9X5YcQz/feVqgg5zZxqncIioclqxcjAqHWaz6OBCm93MXwESQnKbjp4Aju1He5GRPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCpXuHn+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C7TtKPzK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCpXuHn+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7TtKPzK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N79qas3697017
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2KPHHx4PZdaQ2zOBGc2hP+
	I7nXmGyEf2cHL3lSF1Jmo=; b=UCpXuHn+Q7jev4osXGtI5mfQnhCqjLIM5RDByK
	51h2o0svnhAfTiUvFHPxJKzsVDc5iPRQtKKfau7V57TjmyLxhggjEp/uh/x+gXNQ
	eMmU6d5ic62Ki1lZrtW6X6OyAoqFiuMqnhASytRww/yKCByHz3HrWVLFEpZT+x2i
	b4Aa885tpVcHiHRUeaxyfI/y3yazIYIgh+w3aX8Xgs1aPnd8UjxxVYAzxzhyNQnx
	tapyzjiQV6sFvfET2qKXl6dqHc04GutRbd4m3IDR2uTKkGbkiqNUQPC7Ky71awzm
	rSms8r7PLtIT+K8eMYknf90/zC4sEVXT+d9O/PRDmfiA6ZvQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c36kt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:53:34 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14371f7ba1eso985265c88.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790150014; x=1790754814; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2KPHHx4PZdaQ2zOBGc2hP+I7nXmGyEf2cHL3lSF1Jmo=;
        b=C7TtKPzKNKuh9i/OZik27aXv8jbHd7TVewCDoHugMbQgVRoBgb5GMQEamzb+uAdlbp
         YO0SkLVr5YVy2GCtHG0z4f+lQOryiQxOheSvGNbdm/Ju6rlKOaL1bXB26qCvJ/ALuNOX
         zA1vA4qxWI29am0P6adG0GbCR+LUY7U8PbBsrGmo3mHpxEo7oNH1pZ9dM5NsEgpCq34n
         k6Roxl2dhPRq6mWOuCmB8KNrfTYq9f/jdw8AFI9ZUyqm5ypLa6tRN2P2Nd2amgJWKGp+
         QLAiGXEEoaCKqmyAeCCY0uYCvAlusRHuyoE5qWh+UAjM0UicaQrMau5ddGdKyygL4MMv
         8WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150014; x=1790754814;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2KPHHx4PZdaQ2zOBGc2hP+I7nXmGyEf2cHL3lSF1Jmo=;
        b=rn/fqGdRpg9GkDJUZ7TMqb17oJogkx/O4/YqN1XK662tGWhQa/+4F0W879szfMwjHc
         E3/1Z0B7+HECjMsHpMM011PBqMikdJQk3YCS39phD6ctG4xEvyc0hgG0aa50VPzXUH5I
         Jki5NTSG3Dr6mmh1j8UgBHy0bnqJOECWi6+BojQYY0DxfFVoJRHIleRUp/2aGsDKEaoz
         4lH1Nvf/zi8j7nwQI7yiILKEQBmlz/+uhiNU9drfwLIfq8I4H32HScPIgjEr3o2pPV0y
         tYh0u38NbyL6hdGzUG+RVsabYNxVlyrNLkylTsETdqO+C89oQPPAiWftQHpddwYFKW7W
         QrQg==
X-Gm-Message-State: AFuF++k9Dnd6ZSWVDUGmz2bkH1KYTHPoTbJ5dn4YrGQAZ/ypnznj6sfw
	L9Zi/LdH+wwbncpurrS6a+u/bTX8D0uWX2zeq1in76xviTeE54YsoHpzyHBSz1tc5LTcqPi54ZA
	PLY29WdZ2YqeqDqHDA12PjszU1rp6y5jvI4RHelignEkZ6bgmGUPe/MAko3I=
X-Gm-Gg: AYBFou1eCXiUH9aTB6jIW4LJfDLFnvr5R5depX5MKIGzHuE/SuehCtor+I7/6Y9QrRI
	B8hJ+YhUTGNnLn3jpgXW48H/j2UOmC62D0PLpY7/wmeba3d5seqZP6RzJpYBTxzXgaVXKjA+9Z8
	ZuQeVf+FivinHmkPg83CQSOzm7jOL1R1VbKZ6bkAS1dVVtq4BOMClkk64eC/Cfjn9FaYOky7rkX
	OhpS+csfRAxpZhnVVUrMumL05M52PY/VRyeKCjccJueatPwRz+XFwLpAIEElPZ71gEt4mLFaEyX
	OIjHJWgTyffqdAJtkHpimEyvard2GkpGyiX74SirLKbGT1B6zCAQyXib6kD8QKzzgy39PVOZ5Yt
	g623TLIpo7tDdiUKYsISK45kxF/r6TsKRnVYqaIdFWHVT57uKkRNcdcBxFrU=
X-Received: by 2002:a05:7023:906:b0:143:2973:c08d with SMTP id a92af1059eb24-144f913828dmr2409279c88.28.1790150013725;
        Wed, 23 Sep 2026 00:53:33 -0700 (PDT)
X-Received: by 2002:a05:7023:906:b0:143:2973:c08d with SMTP id a92af1059eb24-144f913828dmr2409245c88.28.1790150013251;
        Wed, 23 Sep 2026 00:53:33 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98bf501sm4316714c88.14.2026.09.23.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:53:32 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:53:27 +0800
Subject: [PATCH] net: phy: aquantia: Add support for 5GbaseR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-aquantia-support-5gbaser-v1-1-537d39bb8c35@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHaFs2oC/yXMQQ6CMBBA0auQWTsJlCiWqxgWUxhwXJTSaYkJ4
 e5WXb7F/wcoR2GFvjog8i4qqy9oLhWMT/ILo0zFYGpzq61pkbZMPgmh5hDWmPC6OCoT5M50jZv
 YzncLJQ+RZ3n/1o/hb83uxWP6/uA8P3FNNzt8AAAA
X-Change-ID: 20260923-aquantia-support-5gbaser-e7271bde9f89
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790150010; l=2203;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=kC5nBHhIYpfYl273YiwKYb4vyHfKZwnavGPb7zVYZfI=;
 b=Gegeag8v9ekNzP9AtpcThDMKFEE3Jd+ayzAl6rzKl1hw5RMbQi/UPqLnOG+G230N15PtS0xPN
 QB9sn5+NlY4A7ivQ82DYZhgXlm2pgWhfOnsZE3fgB+ge8/qEoZcwTC2
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX8EQXE5lEkRnC
 hsj+chUQKbp0jqC1gTxOomcEQBajq/rTJWsFz4VOnudd7Ltu6wAm2DOc2rrhinb2TdicPfhhmVz
 jLDP+i3pKXqN06twmY/Cq9iQ/ECUODOUQvrI1ZflLKsdmp9RUXW57qPB9ARgd2j4+vwNN75zgsx
 Wa/8RZK8P4vv9ms6b85Xv7l4oAKb1FV9TKcKsmDMV7suF9+dPdokhqOEg11HOwGPuZGuwVlmy1S
 cfFGkHjhzIGzkxFAn+x+blKV2Cod1YZ+C4UYYGg22DVwOmwtgqqfvFF+9j44C1eZnQQKZyPEQ+U
 PJi1PZdbX5blfP/1kEDjGbLm85Yu7BRdoeCH0B/ppL4glvI6JrHGUfpGwob/Ehnn0epoj/XmpME
 eCt9ita3vBRnZhIJSbhv1L2+fuox+zTIRx5DpAp7lDhXHJoTSXTWeNLITR35dgpnBQ6DAeg919G
 PYPgdxNbcj0CkklviBw==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab3857e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JMcY5lylPf_IzVq4k34A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: xgOCGZ9oomNGbb1_0uw9FxoO1wkoTaX1
X-Proofpoint-GUID: xgOCGZ9oomNGbb1_0uw9FxoO1wkoTaX1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfXx+vpfQYjLG3r
 XEOfp8kvpIQjIGbYu3XFe77dF5kJfMSH/0/a0mQ1RS/z42ohYdIO9CpHZHNJDuNMXLvfisHHpSO
 i53KtBoO+XAbP70yutbQiMFJKFx0ucM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230031

Add support for 5GbaseR within Aquantia phy driver.

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..e5689dea24ef 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -49,6 +49,7 @@
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF	9
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
+#define MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G   12
 
 #define MDIO_AN_VEND_PROV			0xc400
 #define MDIO_AN_VEND_PROV_1000BASET_FULL	BIT(15)
@@ -585,6 +586,9 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
 		interface = PHY_INTERFACE_MODE_2500BASEX;
 		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G:
+		phydev->interface = PHY_INTERFACE_MODE_5GBASER;
+		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF:
 	default:
 		phydev->link = false;
@@ -786,7 +790,8 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GBASER &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
-	    phydev->interface != PHY_INTERFACE_MODE_RXAUI)
+	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
+	    phydev->interface != PHY_INTERFACE_MODE_5GBASER)
 		return -ENODEV;
 
 	WARN(phydev->interface == PHY_INTERFACE_MODE_XGMII,
@@ -1040,7 +1045,8 @@ static int aqr_gen2_get_rate_matching(struct phy_device *phydev,
 				      phy_interface_t iface)
 {
 	if (iface == PHY_INTERFACE_MODE_10GBASER ||
-	    iface == PHY_INTERFACE_MODE_2500BASEX)
+	    iface == PHY_INTERFACE_MODE_2500BASEX ||
+	    iface == PHY_INTERFACE_MODE_5GBASER)
 		return RATE_MATCH_PAUSE;
 	return RATE_MATCH_NONE;
 }

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260923-aquantia-support-5gbaser-e7271bde9f89

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

