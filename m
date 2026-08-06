Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83147AF49
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027157; cv=none; b=Wl/To+lYxHyY32nWjdRJ9Jb9GpBZvIcSoJKtCEj5U/fTv46B1D+Lv24xQCLmimDRGho6TnayEyBbhngovoqOS8F6xI7+4VPbtvhb6MCUFNwBKpkfeiCckXkSiqvXYaxRwxXMMUCt4GAU0IB4R4foz4A0B4N3SKEIttuQMq3DNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027157; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQEwx/9nLR5TxOvmx9dz6gBoLaq//T5pqnpK4eHMqcxWUKW7UrswI3O9dA+FSC1zkQCTXRRveO1QZEnGJCzU1CKq7VB86KFXxcUjw/wpX1QlR3TTbX+C6awKlTwHpDhncoT5s9XSh7W6q0urJ8chq46bBJFophLIqtXx5xag+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dMUkAwfR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tnr+iYDY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dMUkAwfR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tnr+iYDY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nhhJ1871324
	for <netdev@vger.kernel.org>; Thu, 6 Aug 2026 14:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=dMUkAwfRDd94ITcJ
	ThymBVvr/uAsEmhYltnLdBgOLtGCsM13SpU7I1R+KHqilUROU9paqQKO7XtDhetg
	PVBuBjYCGdqam8jYXxy5T/qiV040YQCsxhS8V8vB3mRVIEMRFD1a7zWxDwFDd5m+
	sK9D1RK+Tyo5YQvG5VFtoS6aqFxRUjKyQhEIRIt9fVHW/zuCOoXKxpJmtDhgBncg
	ePMBEnGgV1mGvbRdQysHF6yLqNCKv6W3k/MIW5i/HPTF0aoWIZzQvwUrhJ9K5FnQ
	+qqM8x4p5DhndF1jJL0mKHQ+9Nw7DYmRDAS7S1GVjh2lH9CSBrg2cKAH4yoL/jNy
	CLLUpw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjud2pxd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 14:39:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso25153601cf.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027154; x=1786631954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=Tnr+iYDYkzUXcH3Gg/w4Yw928wlkOdJHjzUauMzjBEsa6NSoewCsOfDzQiGnNNQdA+
         /78cPEVZafgfuaAh+Rb89r3gxmO6Ftr6Or/mrHHC951Z3H4646+yxiLg5BgDnNRB6f9i
         D7GOhSehre+ReyV5/gWEnjxm3/I5pRuAUkwGHsn1+AG2YzWT2LBB/1yZaZFDYcaqS4xs
         K1k1qHFRMxNFUNRN/FEZiTno5t3BZXQRnM5f6PCIqa7xkCV/k8w13wsY5mPqI5a/qW+9
         1iFhIpge+ucLbh2pdhV0oDU7WdHUrpPTttWE+Oilhb62uzM6L8XCxYtZ7zU9hVGTcihw
         Ix0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027154; x=1786631954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=SyaPaORGU51xHxH/vjGcTdb0n/KipWvkfSjZLHWtXDsF43d9HJY5IbLheLqVmfzP+T
         /ayUunx4qRbDpJ/B+/9PjFBv9+wlVWWTyMO67iKya8uoquOcOd6m8wzhHWuY8fjJQk8R
         kBD3FjVzQ7QXrkjQZ7yD6w1C7QmeaILOqvS8FI4cvWgDQE3xZAL6XLQzcE4Vr2N9hJna
         ocpy7kGD/bmzsYBthAst6gwWCW9DBGAeIkGt5SMZQyyUqxrj49WEIYQBf3rLx7CeuxgP
         3SdpLy2jYOIOHpLXW+eqYmJ4SEhR7fqUsZgpSB/3nV0YtoqoGqTkNJh4vG9DGnuhbBYN
         +cfw==
X-Forwarded-Encrypted: i=1; AHgh+RojCWNCmfXUrC9RgGSsURn0mglzcQh1z5DQ6a7RaGqYP59rb2dmpdU6I7P0eP3aGqypdyNu2mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAl89QRvRB+cWyThD1Z63cnSDQYE5Xrry5z/izDYqyfs9Gp2I7
	18e2hWgG+xXAzbSoGCkJF3B+0JC5uUIHLgXxZXc9nrXIeWJRTWG6v02hcACWrDW340GMmJ0R9MA
	oCpbz/g8PIYrgsKS3XIze0Kp6BetLrEJKHcLDRThc3RgGfOsP4cdObvhF0eE=
X-Gm-Gg: AR+sD132rfc/zsOKIZssokwn+qDZCdscPy4xkNyjFbBjkjj0NhCfx7cx9c2Dv8be/lE
	UOI398+RE3hVPXrUDkwIUtMkbAVkMoFVBATF5ZiqcWDZIK43uMbiE8opTTFeGPE51wV5LlWNIkG
	+cquIbL+ZwiC7+U0/KC5qaEb3i1ojbeM2/ZbZ47iXZ+cUq3QssLKqNa6BGBqJ8d1aPX4s2zY0+9
	WEzJcUSjLjq4pbaoTxY9HqQMridYd5jd96KzBKwkTf7jzUlDVZXcHx7dFuoBHQoh+00qP3ID3uK
	oobc7/F4eKgahm0NZSpiPTCo51/U5FmRDesJCOmTcgandr+nwaQB9g8+HpeY4GopJloDGI4T0cg
	vzoWk5mWTGfGD1qKUfyY1v3sYF+IIUWEIgf8G+3NMdET/fDW1cSRqokHnhF+nP6gDdDBNo6Amme
	ShxHF8oONdOcHAMBJzGJDgFVOgFicNprwrXdjaBIV+D4h/I5q8Uw==
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id d75a77b69052e-52ce60c07dcmr146322041cf.22.1786027154022;
        Thu, 06 Aug 2026 07:39:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id d75a77b69052e-52ce60c07dcmr146320971cf.22.1786027153456;
        Thu, 06 Aug 2026 07:39:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:43 +0200
Subject: [PATCH v10 10/10] arm64: dts: qcom: arduino-imola: Add NVMEM
 layout for WiFi/BT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-10-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX4uNnuo2EHX5/
 EPon2WN5J7YLk1taB0PINgmcZobQoxk7JvlaSOdeIgScVPqj8wjkjfCNDqqwXRcRayJ7eM3acEt
 VLV0LstHN8Y8tUfQc/lQXN+Hk0DWB6oyEAm0q52XA9+40sDOUaDUOT4iGaGfZq0ZGIrvHfUK8bW
 AEe0jdyJrJ19KKJxCseRqPoYGHNYZaqnygDBwcbCj0sswp/vBDyykBlkemUv0dcBahQ0EVCSYD6
 1nOZcqLpQoBwVmOllxUDH7BMvfqWrZnmB+wr+Z/QXwUYTFClIVXBeCnQ7ws3VB5tJ6UNHDXtaO9
 QkghkphnK89/LEViFQpeuWYjAsCM/TAgaif2/W/jAzPiGgKKwc92is1jIlz3Mnd8S5UC14U0HDT
 AIIUb6AWl+96DicRj3lZHMFa63/HptxfdaCrMaMixKWkYFXFMlnd/lMjdgbfmp4Cz7oapfeZdD9
 vjE9WQ7ba9KjYa1Qxsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX63076uiEMW97
 HnTaZRjrYjFnGmT47KroCuKq63+8zC50dbVAN5PXwUANKdv+fuzAXKEBaYkW62u08EupQvnkose
 fwO0DLPJIAoqW8/UyUgj/dvnY9SeyG8=
X-Proofpoint-GUID: pPREQJczOP5ap-v7fSrEm-TxAvA0ZSnK
X-Proofpoint-ORIG-GUID: pPREQJczOP5ap-v7fSrEm-TxAvA0ZSnK
X-Authority-Analysis: v=2.4 cv=DeInbPtW c=1 sm=1 tr=0 ts=6a749c92 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1

