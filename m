Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF9450414
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427269; cv=none; b=tlTBQUmOKZqQcg46FS5y/4wHBuqEDH8QBlMCNmjoHfa9NcrUD3xyW/HlLoyNmS7IkiOiHtqdLcN/Xy+lWdSMn2H3Uh6z9XYaaZXV5yIKki15n/BKSb08L43BP0TngIr8tVZp5qJoh66drT82djO/gAG/t97hzcnvRZiE5GG/tVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427269; c=relaxed/simple;
	bh=8FCfjPBXOgeSOCE9oMNfyVBDBWfxZtU2M5HiiMnr1BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kp40zrLAgKLBDpRRPU4ymGQ0WA5S5WCoBCvry4Tbu7qAAEX5UAx1SzTDSHgkeVL+N5XPKK3qQ5Qsj1W0pzIjBsxJF0QuCCaU4X/aclWsPFHGb6bbiK46WRRaHXDy4VuCnwyIgkzlVI/vp6+t3FhvLNB/cp2SYoTvAG1Fr+NAEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CoQ+dBJ2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P003CaGp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CoQ+dBJ2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P003CaGp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQk5Z1023111
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=; b=CoQ+dBJ2w2OXWcV7
	89Yvmm28+CeLZyllRsKsEYx2lctJzjxebUPTXvnncMJYuuM8mG5FftOXEjE7Pbub
	i+c84ERsedV8jQDpkqL/kyr+aqqvCUcojbG6t4DKyuqLvEHA66yXRnE4TVQy22hC
	REpHvQ0DdAwnpUAwQdeUZU7fkLkcTHMeAy/Z10PpKMBKAamGTX9MaUwnXdH3/IBG
	MDiA7KkJal0svawJPgwTk88UazLOKDygNC0qYWI+dM9DoVjYo4aQaq6ZRdj7B3Qj
	8xdnU8MqzLJLaQiVSlkOSrRbL5SFX1RIrOoJFBUS1yoDaOd2WB0Px17lCZUOAVhY
	iGhUqA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n80e9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:01:06 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-73858d44c8aso3137137.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427266; x=1786032066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=;
        b=P003CaGp5yIvn8rIeobam26+rQXuygPLa3OrwhNG5B36x4Y3PbsMD3xTATAXqqpq84
         Y/GBuMp9mY/ExTlrPHaBox8FO2CWH9HHBZEZajA8P4dep+eNfhrVUQ6di5frHyWjHkXG
         49IXFmitsivjYcYDUZrSo7j5vdY1V2VkmBW0OlV/7MWNw2+M7mj4NG2rhngg9YeihY1m
         B4vbvvpjr3xwXb8ehtxFHGdrTyWPm1+Nqzwvn5FQrZHqEP0uo680Fs4ldhwzhtLrt0jV
         egK+zppz+y3phq6YlnxWoofnhPqiIv/R29YMjYluAST/65tFh9gR93Zb6Ne+ThuILZI5
         /nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427266; x=1786032066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=;
        b=qpoCMrBcPY85QzLSZV5yMArRJcuuR9bjyV5NdjP4q1HNwQDlD1Kqkjf0UlDuJNkKJu
         f/51ztOVFfG2pGhrs4Qz4jbZzggWcggl420wQMZ4EVRZQnHE86lv5jsI2Bszvy4S739f
         ublgweyyzqUi+WIM88fDIgfg9UciXd/wnnRPjhPx/MSM8GoHgAjJ9nNVzcokjy22WG1Y
         SMsqUG3EhHNtpARZPIT7p0CsnJa1oN3LMy3+Ns8tDNYcfVMLabPLtrEGm3rhGBinhBWK
         1nq1pQP3GSxZ9RsmXJQhj/rt2Efbx//9rp9oalfZvJqd4tPnnHJY/kBJ90dBuj+XmAmu
         Mu9Q==
X-Forwarded-Encrypted: i=1; AHgh+RoyaHtZkrkEYBOy+YAyeES5WHy6R11qqHaYgBPfE/b68qH0Xcnmagv9HXOu615pRqVGTG6QAPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyX7au6oCovmzD/CqO8oOqvau/rm19rN4nhSZx9sC7hTrl8Ivq
	YxU5E32U1bPlAOgzIbsAKAE4+UDGu/nZNMIkMo2bYZ8R0QUq7S3KAQUfTvpmlYIvBiXvxN54SQ9
	ym5IBrXMwqBFaCS2sieUQCsAMvo9/pOTiq07LKgs4MQS4yohp59MAEHGcLiQ=
X-Gm-Gg: AR+sD11pZcq0kKspJScksDcGNB3P9QuO+eymSPecJQ0K4q9Hkdt4EcOeZQt2iCzsQYg
	+2zrRaIKPCWyfowRXEjfO4hoKZHc/auYzb7CPzvGkfFORd+tHp1aV68Nt1hdR8bmd4b5SM6KqeT
	auepjrN0oa6XW8EOpHABd5wWkYI18frYkVvNC9LjjBVBoxoi29AQgGr9ebOo9JvH/ab+OJvGOz8
	B6JgTrmRoFGbAneXWIO0N5IYA9XoXXHkz7TsjgnWwS/nzLF7iYTb3Zk5cJXBfBNPtvPXtf8zRbQ
	b5hhLn5KFXQS8bXFosDDwHDg7jm705yD0NkeZvoChdNMoiiIO0LPAWbOLOKu8RKhtN53KaCpsGC
	9qdskUE9Ylra+9J7D+UTVYvfxOAm5l0+nZv97DGhFzrY5yBX7uphr6o0mWxnYeoEFbbWWHmoLRX
	mHOU7LqYmqOubQdD9y/N0DXfAxtzOM6A49C1k42EUIXVAJrXForUmA
X-Received: by 2002:a05:6102:1484:b0:74a:b5e3:e96f with SMTP id ada2fe7eead31-7574dfce200mr1067386137.7.1785427264719;
        Thu, 30 Jul 2026 09:01:04 -0700 (PDT)
X-Received: by 2002:a05:6102:1484:b0:74a:b5e3:e96f with SMTP id ada2fe7eead31-7574dfce200mr1067275137.7.1785427263969;
        Thu, 30 Jul 2026 09:01:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:01:03 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:39 +0200
Subject: [PATCH v9 09/10] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-9-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX57fhYDpolEac
 P1HAKBFjjmelfAizymRjo3gXzbH4jdlNE/j8GTLj1u4bp/1oPUTHevFCtcKXFbIBJbEusxApfnV
 D/u38DTBG3Ovh9Q6Bj5R0YMbXMFJMPv7jmCKmLYf4GhZAC8elpYZASX+Za8D93EaGaGxJs4wvWh
 292KcZDTdAOejbCQyAiVXVk7T7fX22W195uKtgvxkbHS7aO3Lo8HBoG05YxnEln0KkSL1Ubr27o
 ycjRMo6rKjLQgl0SDyGMNcqorF2xJj+X8SFqgNPoFBQOPoiMupVRYWGo5NEoZu/+IO53pfVeaSF
 N8v1fOUtMzUpgbHJO/uwFeLv38exPgsfqAB9XmZrX98J9qfn5Do7x9XTCfISCVZTv8EQW6V3FQJ
 N2vO05lE8Yjf2QGUkNLnFEUEuDDZtR15W5sLZyg2uYN53uFFf2CeC/jY4iCGruT8r3fUsEnJIpY
 WCGiFtHAkPGfKgLc4aA==
X-Authority-Analysis: v=2.4 cv=DNq/JSNb c=1 sm=1 tr=0 ts=6a6b7542 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: DUohGF4FRI5qkLz4oA7JOdLwZGGLAbZD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX65Oifd4gwR4M
 hGuJq3Fqtr64Nkol0jX2mOyYL1fgVAo9UXHGxjbQNIRFl5dicFqqjF1YI6ecVpqxLXEjpSFPG+m
 I3acw7e+eAFkPLnGp+Z3AyIWGeViAb0=
X-Proofpoint-GUID: DUohGF4FRI5qkLz4oA7JOdLwZGGLAbZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 04ebe290bc784ea854ec7743bc753c3e41f556d3..06cb787b0559f3d712ec2b88d9e25a7d46fb00b3 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -723,8 +723,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

