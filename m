Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214916;
	b=gMQSJE1EntTNc/9dhbd6GOSsi/wMcJxvqvKvITyeEAjHYyzo7cFBM/LUUMDkWZELmV+4
	 1Pi74H8ElZW+nowlXlEdHsE0e38UsB/71Dq9gOLcGOf5/KLy357FqXvgR35qm3tUYfM1t
	 e1zzb6atpVbqn6JdRCQl+8RdgWZN54LKcC0qcaaM98xqeXGVu4AVbCN6z7oA/kGFN4JyF
	 apiScxl5cOsL1IjNd1b/i3g+tAeXN0WkfYuglT4mPrkdRW6GLA9BO+QqNn1dt9WpyIm1Z
	 vjfARplBN4WKKUubsZguhLl3epHyDZMCuh3kgij3BB8hnMhhp6Az6LTboZND84uA3vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214916;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qMDKi/oRskwwDnCu5JyvHQFwhSYOQZtVeWzuDpnJw6k=;
	b=I1MdqnstUtgewef6iGqY6bECmWSHixvIK21wLhzssoiOuEmukA0m7+y8qNHpW88hHCEb
	 TLp+7jsd37bNN+G7Am764jqyLl99IeNPR7Pu4yt8Jf9J2pDFChHJoRkGnRzz3Ov/CnaBw
	 WOBCfKnkEOMNB7KLCH3Ls4b8NCX6DDeok6hGdoYJ0brYDqSpZkdZ9eSEXOuPodF+tMKb7
	 9wlL47ClZdiMNF2RBxEXlQ333iRYeOMCVbJvnfZ1oT2CAs6aGpu69I6/2pqx3NIFDM97/
	 l0OPtWc+NCUHysQu+5GiPPK0liEsPJRxTb4Kr/P0qflm4gT4eUVZpwWlnyle4rlg7QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=cxqpnzXd;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Uztb2T4N;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1632606A323;
	Mon,  9 Nov 2026 09:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1632606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=cxqpnzXd;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Uztb2T4N
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96C22k2401933;
	Mon, 9 Nov 2026 04:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=qMDKi/oRskwwDnCu5JyvHQFwhSYOQZtVeWzuDpnJw6k=; b=cxqpnzX
	ddXrHxMkhG/UjrijOErnRFRl8/+8jgoGSupmYXZVG332agJalrSAjjv0y4KVnMZU
	j/9tcHidmeRV+4WgRV+GfsmUYgi5a8HjKTwpQxQrNqXPRW/0ftQnCAPb01bDU0RN
	DbVDheVOGWl8G/WSEZmCj+eUzCmGq18OqUJewh7t+uEW4NzNVFxQtsEt9m97r+Bl
	zMEdzsC6xiSb4LE2gS9PYpqlHZMoRMbaVVaBqgkrkm49XpZUIIXnrULpSs05nfoF
	q40XWutqsIS/XtXZEKEHL/YWsMvMq66/F02itZeRk8pxw7lyo+KdEBdVbPJCHKZI
	TkmkupORwLG6XEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qMDKi
	/oRskwwDnCu5JyvHQFwhSYOQZtVeWzuDpnJw6k=; b=Uztb2T4N4EiP/NNfLIAae
	GQ3Inlf56zPulRIQzUrqgzuSljXbwaowevRsi4F7LBqg+A4yP+2qkVq2NYSUXUbH
	/D6KeBKvjPanNswPdGJhpqdMSy9mx5Et+ps0BAuZPzsjVINzYZ1Qxs/3q09XzEIV
	TBXeUTgz2ONUayZr7BCUjfvJFG/Kk3PEdMfj6YVkLL7u7x0dmfUzVMevpqt/dkET
	MxaUR89ksJIgPeOUVKavX9DyUBu5uNRBn8CN5+kx/UYXc7Ui5vymwzIv60ONLh1d
	i0elTJfR296ioNkY+XBhci+FoIHMND0WgWo/SxCA/81BMGtXYUC0TFaITIqUOGjt
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4htk6je4c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:01:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A991idw032091
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:01:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 04:01:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:01:42 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreL024796;
	Mon, 9 Nov 2026 04:01:36 -0500
From: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>
CC: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
        Ciprian Regus
	<ciprian.regus@analog.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iustin
 Stolniceanu <iustin.stolniceanu@analog.com>
Subject: [PATCH net-next v2 6/7] dt-bindings: net: adi,adin1110: Add adi,spi-oa-tc6
Date: Mon, 9 Nov 2026 10:59:51 +0200
Message-ID: <20261109085952.105331-7-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: x2rkBYXk8OJ5OBKwCuWOnuFS1azWHZg7
X-Proofpoint-GUID: x2rkBYXk8OJ5OBKwCuWOnuFS1azWHZg7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX6LU1IWXrVJ47
 zA/cP04NjaGNHroUVGaU1lqv8YmyKAp5P1ei2Ld9Wej+zzrYujgwwLNT9YXSIzG+daExNwlliVi
 osRjk/XFYMDoOhzvCKXlqoRYOvVHoAXH4Ppq5xuZF9/iOwOD3U5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX1C5761sFd8ef
 2GdrEKaqFqYCpoQlnthqGxmgjXApBCVNpkDIUBoTbXstFXLGSdUV0tKTNPqWnqgmoxLdmFDnXIW
 YbJZQA1exWRdBGLAoedWp1uuJTCSmkGWldLkovkuCQIfsqrqAXKAxi5Lam9H1veRq0wMIacRVKK
 dySSoC3kqr/oE4j7XHPJD9seMbz1X7XYirpJr9NwnfM4emmKGEXyRXDBY4n8aNZxMe71aBqAx6B
 k8t9loRgHz7qx6/J6Eykbli6jzg1Q3XLEANLqjLijC5z6wxm11BOu8lVZhfJVfVkS/I4bw5C4MY
 pprdMF/rXWL+6Xopp3S58cqH53G/8f8YSQQZxZunUB/mpr48drKVXBPheUTV+X+MbGBUlkoIeEc
 FrnKHrWF0zvGJsM9mNBQZzqlGTuD+t6M+LtWiAsaqNKrKUoE8leWF7P/rz3HzZd+I1x5sO/nZJU
 Z8YHvDsbrVisMyLAXyg==
X-Authority-Analysis: v=2.4 cv=O7+sLx9W c=1 sm=1 tr=0 ts=6af18bf9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=5jv5b5KtEm5ENIyIVKMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090035

From: Ciprian Regus <ciprian.regus@analog.com>

The ADIN1110 and ADIN2111 support two SPI host interface protocols:
the generic SPI protocol and the OPEN Alliance TC6 protocol. The
protocol is selected by the state of the SPI_CFG1 pin, which the device
latches when it comes out of reset, together with SPI_CFG0, which
selects CRC (generic SPI) or protection (OPEN Alliance) mode.

The protocol is set by the board hardware, so the driver must know it
in advance. Add a boolean property to describe a device configured for
the OPEN Alliance TC6 protocol. Without it, the generic SPI protocol is
assumed, as before.

adi,spi-crc enables the CRC of the generic SPI protocol, so it is not
allowed together with adi,spi-oa-tc6. The OPEN Alliance protection mode
needs no property, as the driver reads it from the PROTE bit in CONFIG0.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 .../devicetree/bindings/net/adi,adin1110.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
index 0a73e01d7f97..fa30787c663d 100644
--- a/Documentation/devicetree/bindings/net/adi,adin1110.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
@@ -28,6 +28,12 @@ description: |
 allOf:
   - $ref: ethernet-controller.yaml#
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      required:
+        - adi,spi-oa-tc6
+    then:
+      properties:
+        adi,spi-crc: false
 
 properties:
   compatible:
@@ -43,6 +49,12 @@ properties:
       Enable CRC8 checks on SPI read/writes.
     type: boolean
 
+  adi,spi-oa-tc6:
+    description: |
+      The device is configured, through the SPI_CFG1 pin, for the
+      OPEN Alliance TC6 protocol instead of the generic SPI one.
+    type: boolean
+
   interrupts:
     maxItems: 1
 
-- 
2.43.0

