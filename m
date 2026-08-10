Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866331D74B
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322583; cv=none; b=EZ9Z26txYZFBYXvFX4nHmqkfl312z38IiTvQSWfKA1AGRCK8HDKGpbt01NBmgwMz75h7uiRx+eQDJLfQujlDCiKr9R3C/aD6TsxFyY+6WiHaXQD2eLuDAUKR5TCuXkeKWKSPkP5UiIMtEvp4yumk+MfIf2AgtlPtKN+yYikBhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322583; c=relaxed/simple;
	bh=zCCIQq+KrJFZtwfxH39V5+ooJIN09fl+sQ/FabMIwoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FU370DJ1ghFGgQWHrQmrmgYwAlKgpcn3LeJ1+5/H5ouQwJ02hIW+6cbu5Q73hCXAzgU7fYt/iVkArX3X6yyS5JCIjDpcKaQKhCDMUT+pMkCsvjbZ8dJHMREn+VuJdxVbUY7/eMM+oSaMSkRcCz9ZfCihMC05dy9xE/vmZtAclro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISeemduv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CXKoo7Y0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ISeemduv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CXKoo7Y0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679LCu5w4103018
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pj8QCJu20kF8a7wqUi/NbuM6XX7lyQobeVKElhOCGF0=; b=ISeemduvtK0tDdLY
	dHj7xqb+SYs7BBVULG07z/wxqOeDkvD0OtaKQtBXyLKEdnEs/Yyq2w+6615jOLcw
	8MpXjYafrkasv8VryjWgVDEgY0+LqOw1Pr1ozPCAKxt9D2GlNJSkXVGqtx8p4W3W
	ImocylISLmYgfuzZabyacE1GfPwQjdvRJSkt95+yKVKAfil8Gj0vfAL5v6iyzTZK
	pc1YLVpPpfkqcP2lwLMNFsiYdulQ9Yxeng7xydvDk+lZbE/m/YZkPKTDzV89D5Sh
	DdNexfUaPnb7+13STETzTvK1qSxtCypWHxJaF8Uo1F44r9WI9ZzjERNM/3dWAB44
	fkeWPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xr94g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:43:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c20762d21so18438141cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786322580; x=1786927380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pj8QCJu20kF8a7wqUi/NbuM6XX7lyQobeVKElhOCGF0=;
        b=CXKoo7Y0wx+x6TUBA4fGxGwN3mp0+O2HdWG4tx76zdc6bcmTup8UGN6mtQfBhiE1th
         vBQZPDpSRHv05XM3n3wC1NJH4Y5wYyc/DMnGiG1JcMnrM30eI79wJ7q9otkW8uenF3I9
         Bo40nyCucsGHLevlYhkqlrNYOWE9Ylz5320kuODk5BNRHEC+mVZP6+jziDDZ8BXFSmAq
         3SxnG6J+1rQwDJqD353ocxHYXRapZ9KPII28ZYWix7V4oVGSWtjQhVwjUT3n8u3u1oCP
         Rc59iY8ltSkZMNwD+MoY0nci/xt+xQhAp1z4pS7IjzVri+RylSCh31pC4OqcmLx3q7JD
         nm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786322580; x=1786927380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pj8QCJu20kF8a7wqUi/NbuM6XX7lyQobeVKElhOCGF0=;
        b=RFutLrKFk35SffA0w3JjksC1+KDv8KV0Oyw3XevYPrTnp9/rt/TgAkwViANQlzPdRA
         x83+h5lJdMxCqNyijjnNk7nC1geRVDUP58KX+PF128ptufhFR0tDspvbRpeXRYBtizew
         zV+S9rk58yjXnhaxCHc3N+K+MTE4vKawyxiRY2sMmqZOflR2ck4mnHcIheMZfobT05tZ
         EXfSAFzPrMDFPirNsRw+vpKiOiM0DeGWVEB0pyZaLCn/zSI8S4s2dtvWPstEqYGahaI7
         bAgtv+sDXY6RpvI9yS9TiQmyDFfFXvxXeQY7MTIr6EfxnylCrtMADdbfu6Ga+g33JyGG
         zzxg==
X-Forwarded-Encrypted: i=1; AHgh+Rr90U8nGwyF2kN3+rQGqpyyuGlbYIQn2grp4HGbH9xw2BqiJDA/kS6a1I3U5FR9FkeULHZ3Dxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdhWxoF0tnl4t7joq0MR/0QkJkiugm3zXcMO9YgP09F+cvgA/
	6oIjnygeBDN5QX7cDf4Xw7o1nIj3STNIqZ8NeLhmqz8Chd5Pfzlz7a5wS55e//aXUDuuzeul8XV
	F4eCN4P/AgMBJ8JsTOSWRdblHA6uG+U20Rn2u+2Q1l0+cajioC2p+QgeI0pw=
X-Gm-Gg: AR+sD11KPewJm4yek+TkBMz64Yl6Axm4TBSDbFIo14nEAFdZ0MdlN4a1UkS/i6ymiD0
	aCEYm+1zJrcV+7NSX6SqqzZ8xxDVrLW+4fZuhP/dXKoZMewE8sih0Oshbn8OH8S25i9qktLp6nU
	ZfqKBH8MUTyFNbUOX8g+sU8JodczXrxTFzXtLykUNisXmZ/v4w8IldoNH3U/RARy5RX1U5qKhMY
	htRpZc5VbTTrn+GED9PEIwC41eN75ffKpCo2fQeFxegu+kT5b3mZhYakW5aVikSCAXqevqisFXc
	J+novfH547HH5B66UP+cuGtaCsq2VOgDjkwOUm+/Y5NvwKdPvri03RCikMb3fePo6MkIheyv9Du
	yExgOMYIjR6bhuwyzthBXzoXLsXV5wLw9w13d6pgQi2l4TuDkBfXVU2LFGfxlgZ5PXezUqmiRf8
	Gc/34WVdukYB0UVQ==
X-Received: by 2002:a05:622a:3ce:b0:521:934c:bcf with SMTP id d75a77b69052e-52d191d3fffmr200361961cf.41.1786322580265;
        Sun, 09 Aug 2026 17:43:00 -0700 (PDT)
X-Received: by 2002:a05:622a:3ce:b0:521:934c:bcf with SMTP id d75a77b69052e-52d191d3fffmr200361611cf.41.1786322579794;
        Sun, 09 Aug 2026 17:42:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3d56sm1679742e87.69.2026.08.09.17.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:42:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 03:42:37 +0300
Subject: [PATCH 6/8] usb: misc: onboard_usb_dev: add support for the ASIX
 AX88179
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-msm8974-onboard-usb-v1-6-08a805768328@oss.qualcomm.com>
References: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
In-Reply-To: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zCCIQq+KrJFZtwfxH39V5+ooJIN09fl+sQ/FabMIwoM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeR5881yVPlx8qQw0wLkeHljDPsnAhnsCHOHVH
 45LuWk+xouJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCankefAAKCRCLPIo+Aiko
 1b5qB/45bfH/8xyr43I9Xap/gQNQxjP7QH/zbGyLTk+bzRIVIoC+q7JFwG8HU3/BA0BlXeycU1l
 Pq/B8T+OMILv7b6mh3D3UFucQoWi3UFrZVd8H+R7RehtaOav56BOmfNzFvBmhCxbfv+ifNF3Z48
 ghuUWPW9P2/E4EddDN7PFOnAS7a7mzFUDVUppNBXohRKnIGLP9jL+9+Lg68G/odRFm7VPv4YkhN
 4aWLfDTgF3Q+ZEYT7ajR9eiSpSxP12iHmPYn0Bef4f2ASnoOZd7yhCIPOm1itLRNvg/A9unW3/3
 WRvUtbjZxtPL37+PgfXWwrZHCB86nZFbUDPhXtCdwQr7rDwx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX02va8Z8fsnvU
 X3XS7qHRHc0qSFyHG1+zuXMYaPa1J64uBeNePOawmMv4M1AKpnIW0QaxIAhiTKtWG8Gm6zpjTBE
 5yMDjbEMZS5O/wG9VAvmhcCOHpNxbkA=
X-Proofpoint-ORIG-GUID: DZ7S8tPncB7ULAU1pZObC-dHEG2FoIFZ
X-Proofpoint-GUID: DZ7S8tPncB7ULAU1pZObC-dHEG2FoIFZ
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a791e94 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=GVYUdSXVY4KBhG55bxAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfXzT6NKxkEn24y
 lR0nsySeBBT/TKRZ/tR5QvPwAZ2nVEBtWvYqJHAxqvs8TVSixG5qKeDZjZxAz3ov/d2Ti0yLjUy
 QSudSp98PttCELaGoSpwGKdVueXbYQAKYViBtwcmL0wnzi6wmerx8PaD5GwjRYffAKEf7+spR11
 VhA4+98D7gyGhrMTaYQ/zazpf0tTakRxHCoBrqw+FgFjihkWmnXCWdEaHjv8MK6nD9XN6SU5yum
 YLnF2Y1R2gehg/ZexyuokjC/XHDJa3CSHNo5cDPEVrHw6IjpkM+sXdLgqaL8/954/s1M1hRBb7K
 gs7ANkKq6PV08cCmCzaeUFTslFHGhIWgDTLH/RYRMxFUhD3R+bvt72E8sHxwaIChsPAkhd28k7C
 d9a6uH8Lpfq8BJe3q+pn0aKzEbKduFoU2V386850Vz8yh3g81NfaxTbZgk4UwZwowC26k9vqI/n
 zOvSf22Kf8j2G+jUHwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100003

The ASIX AX88179 USB 3.0 Gigabit Ethernet controller on the APQ8074
Dragonboard has its RESET_N pin wired to a PMIC GPIO, so it stays in
reset until the OS releases it and the device never enumerates.

Add the AX88179 (0b95:1790) to the onboard USB device driver as a
non-hub device with a single vdd supply and a conservative 1 ms reset
pulse.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/usb/misc/onboard_usb_dev.c | 2 ++
 drivers/usb/misc/onboard_usb_dev.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 37ebbccce35b..8139fe3f2cf5 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -564,6 +564,7 @@ static struct platform_driver onboard_dev_driver = {
 
 /************************** USB driver **************************/
 
+#define VENDOR_ID_ASIX		0x0b95
 #define VENDOR_ID_BISON		0x5986
 #define VENDOR_ID_CORECHIPS	0x3431
 #define VENDOR_ID_CYPRESS	0x04b4
@@ -650,6 +651,7 @@ static void onboard_dev_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_dev_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_ASIX, 0x1790) }, /* AX88179 USB 3.0 Gigabit Ethernet */
 	{ USB_DEVICE(VENDOR_ID_BISON, 0x1198) }, /* Bison Electronics Inc. Integrated Camera */
 	{ USB_DEVICE(VENDOR_ID_CORECHIPS, 0x6241) }, /* SL6341 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_CORECHIPS, 0x6341) }, /* SL6341 3.0 HUB */
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index 7961b9ffa99e..27efccbe2286 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -59,6 +59,13 @@ static const struct onboard_dev_pdata realtek_rtl8188etv_data = {
 	.is_hub = false,
 };
 
+static const struct onboard_dev_pdata asix_ax88179_data = {
+	.reset_us = 1000,
+	.num_supplies = 1,
+	.supply_names = { "vdd" },
+	.is_hub = false,
+};
+
 static const struct onboard_dev_pdata ti_tusb8020b_data = {
 	.reset_us = 3000,
 	.num_supplies = 1,
@@ -159,6 +166,7 @@ static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usb5e3,620", .data = &genesys_gl852g_data, },
 	{ .compatible = "usb5e3,625", .data = &genesys_gl3590_data, },
 	{ .compatible = "usb5e3,626", .data = &genesys_gl852g_data, },
+	{ .compatible = "usbb95,1790", .data = &asix_ax88179_data, },
 	{ .compatible = "usbbda,179", .data = &realtek_rtl8188etv_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },

-- 
2.47.3

