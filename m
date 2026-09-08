Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A32559300
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879507; cv=none; b=SVYFWDbvSpnahN+46Os1yIrtaAn58AgS1+MfuroDPzmz61juYPz07A7loUGPPRu088K+UTy2soIHp4LO+wzzC2bskmgHa1Wm1hcYOujRPg/Ob0jgJq9KKAw/5597DXKqMy66WN09b6cElbhI9ToKQai1ou1+na9pI1ZdhdxnIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879507; c=relaxed/simple;
	bh=qHUlRmmCEFH0pekvHNTdxOkuBUAknchAtPGzvZSdAVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOEAJhe3SeKdqwbN+xPi+LwqMqzjpVf3Z2WiFaQJ02snMAnPiLN+8P02GPW9je4hXTA6W6LCdYfiPn7X6vpKT3G03pWNi2TCVYyHNgx1PUhf4xFxjeCQ/LKwM/K2H856/KVnH0sZLZVBB8tngibLUa3/VTbEBaoyQ0tAo8i2AEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OX8DgjxH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SLTU00xq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OX8DgjxH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SLTU00xq"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688EjCTS3192346
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 14:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	seUOJdBEpaaK2UmSYK4aVK9u6IT6FpqMeeYKLF/OBic=; b=OX8DgjxHIzM1T1JJ
	LsJn3a+0v6E1Nn3El6WzTEIPiTBZIkN1jiSzHXMW9puHwPTibwRHhohuK+IYB+L3
	6hv9Ffcv09Tj68PcK6t03UXQSUjZykW9D90A4CblNMe1iE9HbHzEle4CyEgKTqgF
	y1hHd0F1yJOCmbXBmIXBPjZw/vfKlNf4ivwmHP8BJ78BfABPUqVD8Kq9DhoT00dg
	tcvYusAFp4atnM829GtYqGVqz1/IEZnJVjvOudXDjsfiFaE0lbiZno87R3VS9o0o
	00ln7PbWBFjOrRtcL6125WMatVYXpoYO4Od3Yd0z5DEEqYJMocdHGmPUwFv2E0y+
	4UGCKg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjf1chjtb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:58:05 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-73858d44c8aso1004694137.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788879484; x=1789484284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seUOJdBEpaaK2UmSYK4aVK9u6IT6FpqMeeYKLF/OBic=;
        b=SLTU00xqNQy0/p36Ixryy14tzp5PycryUJ499T6zQskFccQQBEC2Pn/Ysq9ErK/+vr
         FxwFUB8qkMCI7wEWxDPWur1ipozJovLsG5OCSxLCnYvBD2hutX4GUSnhdt37D+aa7WLa
         MX0gTKIbNzspEDf6BkAG77+kFMcycp68EmOTv20TAwsjNp0ZPCALfXjAeFNao3mbRgeh
         7thPKrecZFNGjllKb48XFOXpwGU37vzk3xOkSSyZWP20ZT1iC3vd5effFrE+hhev2DDi
         LeugMf92UPvsHX26TstVmZDYNl7sJQst5K+AC4fcA3Jg4YXwYzeVGsHQctCcvSWtDrds
         Ym4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788879484; x=1789484284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seUOJdBEpaaK2UmSYK4aVK9u6IT6FpqMeeYKLF/OBic=;
        b=HYW9pmiCSNYvyXW3gpKLsA3wGiK776jheOFkSkAOaWnodI3Ygo/smNbkz4Bhcjpzfq
         PWQHcPs/p3ts2rvsTso4eAaa7jV76DhgsALtALwTjmbJfPaPNnc9sqatMuf6YRUN6IaQ
         NOqRvg4xiojRwm1/Xz2esjWN00IVjs2vJR5n1ZOXPip94FQE012xm2HWtX0wFQpg/b99
         lqCrsj6ecjPa352O4dM0Aaatm2c6hByLzg2UtUQ+3TA0mKSjj32oiGPEWdhBh2ZXeXcL
         839nK9lUm60zunSDIqVDHeOJcJ3F+Kphup10swYx3yfd5cRZGcoH48rW9KOPiaO4a3ho
         hlug==
X-Forwarded-Encrypted: i=1; AKwUvBzLAWXd11bGT6Q6PV3FGeMlJvW8c34fgsId5zTTvclFimDMf4jOiodD4bXbMqBof7VY0CkZr28=@vger.kernel.org
X-Gm-Message-State: AFuF++lxxwtWzx3tsCtksQ0jPfJK8BfcC5Vaa188+uzS9yN7qa38uOv8
	GQbQxcuitr1AVVp7zGupqo0dR0yak9viOxzbhDCZOoLLP/QmWqqHgvbVGuoOu7gO8e/hXre9YR7
	6QzgUwVVHucXwS06Od0Z/dCJc9hvExTcrAjpZ5R1GNA1RGVuJYPzB6HvqrMg=
X-Gm-Gg: AYBFou2AY0qRLWctsHL/Qj6aYIjn9g7B0HinsPiUjxZX6D58XA15j8GyVZEAvlO2g9A
	eXG9LiswY1vYRK0FY+gYTYJco4+ybbb1Qvgt9ikLIoZfZ/OPL6eTx/3HXfPLDDbnDRwkql9D/dr
	D+PIlg+/FGKvplhT3UTYLdlaJIyzYKlvhUT0VafX9GU9xUYcHC6mNMr8etfekqtuUtlVZNu1OQ8
	zFiHXwWJH9FHk/thGLw6PgiKyAIt+kZo6UZ9HzNSnW69hNyDqgPwlCvAyIjvpiASqOfrRRmWsCi
	24L+xVkJ9xNg4tG1km6UuOgm9uhPoEX8Qpbqh1ZCX3Gxpxshs6f8uTOHFuh5Wz+ykkCG2wnK4mO
	tEGYTOtu9nW8IEvnit7FtUS7dwNNW
X-Received: by 2002:a05:6102:f83:b0:784:94dd:5389 with SMTP id ada2fe7eead31-78a4a9ae110mr10773731137.13.1788879484415;
        Tue, 08 Sep 2026 07:58:04 -0700 (PDT)
X-Received: by 2002:a05:6102:f83:b0:784:94dd:5389 with SMTP id ada2fe7eead31-78a4a9ae110mr10773647137.13.1788879483779;
        Tue, 08 Sep 2026 07:58:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a2:f118:df09:fe51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm25191276f8f.37.2026.09.08.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:58:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 16:57:22 +0200
Subject: [PATCH net-next v14 03/10] phy: qcom: add the SGMII SerDes PHY
 driver for SCMI systems
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-qcom-sa8255p-emac-v14-3-ec212b747a7d@oss.qualcomm.com>
References: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
In-Reply-To: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5706;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=qHUlRmmCEFH0pekvHNTdxOkuBUAknchAtPGzvZSdAVA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoCJpUSAwXwYqyImVUA8IHz/qZBphfJZmEFMBI
 m2ZW2y5mMiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqAiaQAKCRAFnS7L/zaE
 w2PhD/0as5tliI1sEyOitt3o+EQ4kh5yKkHvigZwetzwKxwOQu6f+gUa12Gh+Ov7edkBjpD8a3W
 iMbZlHnG5eKnGJphgRMMitIfM6T1OqsPv3r/O8N1svmU7Rnjt9BKaKy2gFDaSMZlQaDjydAgS6j
 JYGoCCNyQ+zCdEngS0hE6Zvmnr4rSRrbfCDwvRzmtSBQdHIb+EObCBfDhDX7BBvh62DlJ72wZ4L
 yvB9fnZW6tAxBufOOQHqH/V5a/dNykdyNGGZAUrx282uTWyK3n1U0h6I6D+/arZmPVEcA+0xZsc
 7IZ/11r8niZPcNCiTmwZYaDEPtMje17Lje0Mr60FjT/v2RDxI2BBrbqbN6/TRLvZUiOTtPevFNZ
 Z/W6AynG1j/kuo+oHLCYJ8lAKTu/qO1pMySExNkmWs9WffnDG6MjTRvOkZbuYPf+aJS8SFURcwO
 8k5H7KcrHhWLZUEC5iJR7ISWqq4mzZKosEGkxYHgjeN92zl1TGoaUT3PcrxO7mEmwRB1CGLPGQI
 nmnOTQGLAg/g6kGs8U2xA4zsmXCtvgWv8GpJu0oyKlpfr4r7Q3fR9j93fekRA0I/CXonYf69tsW
 3YOfCWEAIgWWJ0OkY1gq6xWcUoMPC/21vMVDfEHSUNAZrZUct1D9thR41qNiPt5fNoLohNF1w0y
 HAXMirb7OBtMCBQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=VN3tWdPX c=1 sm=1 tr=0 ts=6aa0227d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=_Lfrdvl5uC9KR1EAoRcA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: t3QBW2FyPJOuXyvzzcAHetgrQWSuXJX9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MSBTYWx0ZWRfXxSSAU/XMsqGt
 RaxEv5ptELVyF05r548TQ48XcCcm4OgUXBM1B1rt8Itc0RQE4UEaxzKNnKmEoZ0zkN6Zvm+H6Be
 5vRhYQROeXMI6SMyby4JsNFg2xGzQ3E=
X-Proofpoint-GUID: t3QBW2FyPJOuXyvzzcAHetgrQWSuXJX9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MSBTYWx0ZWRfX94MPsaCqlQRa
 BiFP1LFHT0yJUmrOTIKbwZGS2+Ondxw5O1tJ/W7lrE89LzbHQK2c/3liHfvSHfRGE03l0cbUpuo
 ruJOSyPG6ylJcvKRCAhQDbfy+Q75JuYtZyXnKOl/S+FGJjbtCOGYaTNyvHGSSkzJ0DQ4WRkvgmN
 Nr9cS/XzXHHFlntno+kERWnuGhuOGdxsy2UlSdRFfv53+6g68uiC8jtfmm3YPRn+0pNWb7gimDe
 klKCIrpTqQP+13AuwPojb5BZbHrH6wXRWcGopesiCtPILMg+xS3k14WvWjIG3/MdvzZ1Geo+aQK
 BM7Wkaj+/lwR4/z5is6hjLizApLvJKRLRVJAQNBUpaCczaxLhg9aUIsuzemhuD6PyGa5IPhPuK5
 QRFfIE2SJHlVyGEpgyncPY473xQeA9HZK9xIPSOXSRuZO9pAqxEc1mqmrnYjkj7vLEykGXgyEHI
 PnRzVokS1B3AE1cpPbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080161

Implement support for the firmware-managed SGMII/SerDes PHY present on
Qualcomm platforms. Do this as a separate driver from the HLOS-managed
variant as they don't share almost any code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/phy/qualcomm/Kconfig                   |  11 +++
 drivers/phy/qualcomm/Makefile                  |   1 +
 drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c | 115 +++++++++++++++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index d910a5d1a1ac3ad77599e72c3f4a3b2aebd02dbf..677662f642e42f6ed969fa281d161ff185be9ae4 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -242,3 +242,14 @@ config PHY_QCOM_SGMII_ETH
 	help
 	  Enable this to support the internal SerDes/SGMII PHY on various
 	  Qualcomm chipsets.
+
+config PHY_QCOM_SGMII_ETH_SCMI
+	tristate "Qualcomm DWMAC SGMII SerDes/PHY driver (firmware managed)"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	select PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Enable this to support the internal SerDes/SGMII PHY on Qualcomm
+	  chipsets where the SerDes hardware (clocks and registers) is owned
+	  by the firmware.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index 8bf887d58ee4a65687216dd91a6592da7941ace2..4972009b217e39ad3d19300e5b7dede4e88feca4 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)	+= phy-qcom-ipq806x-usb.o
 obj-$(CONFIG_PHY_QCOM_SGMII_ETH)	+= phy-qcom-sgmii-eth.o
+obj-$(CONFIG_PHY_QCOM_SGMII_ETH_SCMI)	+= phy-qcom-sgmii-eth-scmi.o
diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..ae961975dcd87555d458ca491092622366e58127
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Firmware-managed variant of the Qualcomm DWMAC SGMII SerDes/PHY driver.
+ */
+
+#include <linux/device-id/of.h>
+#include <linux/ethtool.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+static int qcom_dwmac_sgmii_phy_scmi_validate(struct phy *phy, enum phy_mode mode,
+					      int submode,
+					      union phy_configure_opts *opts)
+{
+	if (mode != PHY_MODE_ETHERNET)
+		return -EINVAL;
+
+	switch (submode) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int qcom_dwmac_sgmii_phy_scmi_set_mode(struct phy *phy, enum phy_mode mode,
+					      int submode)
+{
+	struct device *dev = phy->dev.parent;
+	unsigned int perf_state;
+	int ret;
+
+	ret = qcom_dwmac_sgmii_phy_scmi_validate(phy, mode, submode, NULL);
+	if (ret)
+		return ret;
+
+	perf_state = (submode == PHY_INTERFACE_MODE_2500BASEX) ?
+		     SPEED_2500 : SPEED_1000;
+
+	return dev_pm_genpd_set_performance_state(dev, perf_state);
+}
+
+static const struct phy_ops qcom_dwmac_sgmii_phy_scmi_ops = {
+	.set_mode	= qcom_dwmac_sgmii_phy_scmi_set_mode,
+	.validate	= qcom_dwmac_sgmii_phy_scmi_validate,
+	.owner		= THIS_MODULE,
+};
+
+static void qcom_dwmac_sgmii_phy_scmi_runtime_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_disable(dev);
+}
+
+static int qcom_dwmac_sgmii_phy_scmi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct phy *phy;
+	int ret;
+
+	/*
+	 * Enable runtime PM on the provider before creating the PHY so that the
+	 * PHY core enables runtime PM on the PHY device too. The single SCMI
+	 * power domain has already been attached to this device by the driver
+	 * core, so runtime PM votes propagate to firmware through the genpd
+	 * device link. No register or clock access is done here - firmware owns
+	 * the SerDes.
+	 */
+	pm_runtime_enable(dev);
+
+	ret = devm_add_action_or_reset(dev, qcom_dwmac_sgmii_phy_scmi_runtime_disable, dev);
+	if (ret)
+		return ret;
+
+	phy = devm_phy_create(dev, NULL, &qcom_dwmac_sgmii_phy_scmi_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy), "failed to create the phy\n");
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider))
+		return dev_err_probe(dev, PTR_ERR(provider),
+				     "failed to register the PHY provider\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_dwmac_sgmii_phy_scmi_of_match[] = {
+	{ .compatible = "qcom,sa8255p-dwmac-sgmii-phy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_dwmac_sgmii_phy_scmi_of_match);
+
+static struct platform_driver qcom_dwmac_sgmii_phy_scmi_driver = {
+	.probe	= qcom_dwmac_sgmii_phy_scmi_probe,
+	.driver = {
+		.name = "qcom-dwmac-sgmii-phy-scmi",
+		.of_match_table = qcom_dwmac_sgmii_phy_scmi_of_match,
+	},
+};
+module_platform_driver(qcom_dwmac_sgmii_phy_scmi_driver);
+
+MODULE_DESCRIPTION("Qualcomm DWMAC SGMII PHY driver (firmware managed)");
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");

-- 
2.47.3

