Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06072DF3EA
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322576; cv=none; b=A609KtcG7eqt9immaVO1v4NHt18L3he1EhZsRietFneVbwaLklK3E6ZG7cycJVEiUAbHBADwu96RG6oYQxDiNQ4IZWWH2CHbihjUeEbE5h09vwctlrQVPzN6w8tVAPUIAyn/btzcXuX2B8r50c0tm+fFEtq04p26OE/3H1P0rAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322576; c=relaxed/simple;
	bh=XptlCVavFWjbhOJ6EIdHSSd50V8e0b3NzSBraOqTS6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wlvj+B5u/wL4GmOpxLt3e3bj5+XcNcNpnSg8NDu/uLMl+aIEHRFtp0Ieinren3DmxTfb5ZZhZb3UMQZYP8TV5tPTG0IvoheztFjy7FSFNrNryncfz0lxrMbPpDaUWDb/LZyALBH32WXKlIl0fmkVmFUjJ6yLwW4IGu+Hu5QQ8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwEWu6je; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fOk0ass9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwEWu6je";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fOk0ass9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679L716h4106377
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ql5B4LomMPp9M5uchPFpG37QNDDBQiNx5rGOXpW1SQw=; b=JwEWu6jeZGmgQaVx
	kDFf0qALkNvZeJ0pWXm/nJv8+kENveO2hBH6A0CLGhHABvY7DKNklU4N/NYejFrX
	gvvfihHWuVZCpeznU/ieUVcUGzmBduSQMGKehuDrUCUpWoeuscuXzQTux+i65M3d
	/4gJ0sDnrk1uc+mXQnQg87M/qFAEgvnJciezuFwGtqbDhQsLFFPc3l8jYbchwGe+
	EYZRxDug3TUj1NXrDjHIR/QpBpla3RtMW9YynaORFRVWRrfMkEz/l760u9IrWUph
	LfZEoVt2jsBYH3MiOFr8eZzGXobM8XVda2lvY/rTdpxc9TOpYBkDz+o1b716hOSI
	dmr7Ww==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bwgk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8efad04d884so24382356d6.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786322574; x=1786927374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ql5B4LomMPp9M5uchPFpG37QNDDBQiNx5rGOXpW1SQw=;
        b=fOk0ass9gH/qFywOb5s0DGm+dqz4CcxgqNt9i/U56gxjTVYZ63Ek90aQv+ZAAM/SAQ
         tY7QixZzUbe0Xf39Hvt1aSok3FyuqqFNMLUfcWiDOwJYvjA9yiG+U0ybYQrzdKsbGvU3
         2xPXYtiMd9iIyManoyqhRenGogcvOCzIA1HN4bttieGGrYXC6e+QUt3g5hMdAa2zT5zj
         HSOSJvfEoNI+jIGZC1F3SLDF2HEfpVUPNkTOALsNf3XCeVu6iaFgiu32N5MEPZHfzA7d
         1TVNA40ZdQ34f+BSBOiF2sesfiMOp3wkIePAk1OLXsfCbhHM4KFzPDhazpXCjJQhhed+
         F40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786322574; x=1786927374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ql5B4LomMPp9M5uchPFpG37QNDDBQiNx5rGOXpW1SQw=;
        b=pevA3nyT0meM91VRhacqM7goWW+G1iGTXKhIORTik3Uz7NOUC5p9DdazbZulPMUjnr
         FFxUOwGWVD0FrRMpiHJrit38mviYm28jsL3NKMQTOWnKyP6Sh9SeeisTauDTldqsPn86
         ZFZpmPl7bTkRcpiUhAKlI4FCeS4B7/LVIfA7O8ugDIPienzwRg7Z8qf7lwk/feVCcQMk
         RGnBCLWZDiVp+Sz7FYisD++h/p7AJ6UUQ8+2OHUhq7Y0Fwgs/tEMqV9ODlFcbIhvV7J8
         4PzL18xJekxypENLt17yjwgP2KUs4snfv8glPt+uXgQFMii5AdNiK8Dy8PrAogEc7l9c
         Z1sA==
X-Forwarded-Encrypted: i=1; AHgh+Rre0gtebR5LEn51PJtfwJR6D09LPvU8BGk0YKwzayKR/iVF8dl6+u8QrZnzb8kqmfrB4J+3Juo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4lo+g3zd1XUXYgUvytLTDnnqDWChmHlc4vJwZkXd4ns5RDqY
	JEIssvq4loweMw6iAvhUVPfv4104frQuWCbEvMRvnZodCcziRs7pIm0uqoVjwlUxUkhl1HTAgeg
	P4ztbE0uvGLjDdGsbj8j2mN8dWh9dKolVmFo2tAT8ASCF/jl8647ZYbsGLKw=
X-Gm-Gg: AR+sD13t3whfS9upOOWva9eVlc5TUjhtAbpq3XEufm+23iK4B8+gfo1GIDJvnoBG8NH
	G15nw+S7o89wczPIioTSXzxWetLw+HCfSP+mpPLyml6T+vFL6AYqTrpG78vrhyCuWLGr6KhSV4m
	leBXdKMUFTmn0kZThad3pDnmr4wqgz0dEcVM2mJz/bOi/Wnk9L+RDpRQjQf/UtafBEEhfzDutwA
	wFjVTEzs4+TwalizotuHLfnpxapv3lpLGEPzP7/SpPt4uhRFDvLlA8o/rusIow4Tyh4SeVOlvbh
	1QTQPwBWkNaqmWUN1eFGUKFSgsVFl0HhrzQec5gP/O9N1NdAFFDQ8W/hWv5FjjcDiO9j9zIRuTS
	zSf5z1VvN4SNuuilrVNCCdOswP5pt+DXktc2J/bP5KEoub5iFA1myUQVvfeVspSDRC0cocFInzr
	LjSNcUlsoLpyR3Hg==
X-Received: by 2002:a05:6214:490a:b0:908:92e3:a06 with SMTP id 6a1803df08f44-9089b64fd30mr321860746d6.24.1786322574095;
        Sun, 09 Aug 2026 17:42:54 -0700 (PDT)
X-Received: by 2002:a05:6214:490a:b0:908:92e3:a06 with SMTP id 6a1803df08f44-9089b64fd30mr321860466d6.24.1786322573775;
        Sun, 09 Aug 2026 17:42:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3d56sm1679742e87.69.2026.08.09.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:42:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 03:42:35 +0300
Subject: [PATCH 4/8] dt-bindings: usb: microchip,usb2514: document the
 USB4604 hub
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-msm8974-onboard-usb-v1-4-08a805768328@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XptlCVavFWjbhOJ6EIdHSSd50V8e0b3NzSBraOqTS6c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeR57+i+Ru2tY0dFKsvnlPICq7rinDy2CP7emA
 jcrVs+e8OWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCankeewAKCRCLPIo+Aiko
 1Vo9B/0Wl79SNy5Ng0e5BY5wXB4TTDBopfW8pl/9mGotUFoExRTMrIaXcM/EWf6BhwKovwyUJR0
 pXweCJzRUZZKxr8Gx3XipIz5aQ2N/rR/FGvqpTcaKq40sfHpSTJdJVWywFFksZkDfE/CntkKUia
 rA3tuo1GomLZCbwGaDgqUdMllNAzN1hgfUVbr19BKTU222OWELvtQsM0ekjqMjnsR4Xz0MrmgTv
 oYHXydhnn7twm3IVfp+ulfYgnyKKubS23U2QE1PQ40tncLIJ4/Eb/b7KN9TPmFuYKNQ8hVsBgtm
 DoRentOpIzXk/HMOgFbashn2nfvueUf7t11tyJQgpb5YL7w1
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX8i4Vd1RlEHjT
 CX076GVmjgg+HsFTiCnmz9cbJjGg3yb1kdax5tWyMjOLzrjio9Qi6JAzZyEP/Z3B3oWGjKibt8B
 fq1s9QHpqa4PsEtgfOm47mJHbkijpW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX6Lgnc84ZVtXM
 P8T8VLZpMI9song+mK2LoPIPUH8SHAfojkU3BUlXjRD5dR/XqlwFjgugjvXqnVKA16PEoYCzLL3
 T+OSxX90E7Kx0D/utwXmnaWEo02y5x+IowH1VaysKpi/kOhZ2khhf8Z6nWY69KedC/lV4a//0vs
 jeXsXjGip3TyIxMzUw0T/uNam62XGGYjZUY2hVvDU6mwrPefuKyJ6k/x4bbCfmWiXJhUQ5Xl4zt
 5F5sBK2O9iqKV1co37bsgfx1SWkIyEwcwMSmi3FMD/UDhDiYu6Xj38OpSgiQ66zBNvNfjjHELpp
 6X2U0pHsJxydg4TncaGVV54xTYegqwnhltfQVF1p0mb9d2Q2gu6vsHT1pN1Ms7TaLAGCInzt2yJ
 Fe8vMgCNxNe7zHqBnqQeEcBjKPuqWDZYTmTjeg77hmUnYqul3H1qlJ9incnYD+fo1CzUhfTm/4X
 CSenh3x3FpuZPsYWmtQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a791e8e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VYvdqsobsaKPDSFeC5EA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: I0vNmRvPXKGCipQuty7gM9YFV3GYkI91
X-Proofpoint-GUID: I0vNmRvPXKGCipQuty7gM9YFV3GYkI91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100003

The SMSC/Microchip USB4604 HSIC hub on the APQ8074 Dragonboard has its
RESET_N pin wired to a PMIC GPIO. On this board the hub SMBus
configuration interface is not usable (the bus pull-ups are referenced
to 1.8V while the hub samples the strap against its 3.3V rail), so the
hub runs in standalone mode and only needs its reset released, which
has to be described in DT.

Document the USB4604 device ID (0424:4604, the ID used when the
upstream port operates in HSIC mode) in the onboard hub schema.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index 4e3901efed3f..cbff9a350857 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
@@ -17,6 +17,7 @@ properties:
           - usb424,2417
           - usb424,2514
           - usb424,2517
+          - usb424,4604
       - items:
           - enum:
               - usb424,2512

-- 
2.47.3

