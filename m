Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC54921BC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921653; cv=none; b=PrrZV+Y3+/VqgAsgEzIr2U6CedygnjNwKYQguU6W9qQyE0ri+Tub5Fm2VOAtw+cCNHRkF3PZV24ip3gC4e2q2i9UEuH7Tbr0m3oN+CrOrRkMfYEkhWp3/QGMb0DY8DtZy2Xo2AzLkEMNu1qOJjZfoAgy7eaoD2qaII5kXxQvx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921653; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKi3pNRc3FDFRbXP1Be0CJGb3mTXuCfn0ThJyvM7eCz6fEDMVop7+m1qNWFQPNNbuz+eRAdaXgOJ0sQgTKKJiTiydsC9okhXYoLJFFMiR6ashpUbXMlqui3rA2S1u8WBCGnOYKcrQ0O0xh0ZULUFJhqvCP4PwqqlhbBTVe377/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nI3M/mnS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KNF8UZ4y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nI3M/mnS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KNF8UZ4y"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoE0S1570353
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 16:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=nI3M/mnSsplZXCvM
	E/yYWLSoIqVEdpGFBU5EwH/Gviv1hba+cB9tv/LWQc6yso+5yoIZl1/xERs98BVh
	sUlqRQWuUucfPwKyfl23pfghMzXqv9lYjjWJiAJlyLjAek/1pPn7EwsvDnP2KnMn
	aMGOlhKXkir+AMRgLkTzqcIl4N7QIjfUmZRiHs4qNQJZBFxExtThHLQ0YwH8Xc/8
	HseoertmTvfR5JrtSYZysP7IrkkfEcR6FYBk9RoiEfuCccjqN9ugmqnuryXBXknT
	oHIwJnvbojDg7qcYZGPfmki5GpS8DwHb7PMycCUrRljDrLi7zNo0MsCqNOVSHcH2
	K+DsXQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510ahede-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:00:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5e38fbc5so101087885a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921643; x=1783526443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=KNF8UZ4yz21iqacTWCeiLvELI05jhGwoBybPB8ER3Um1ddN210mQqnYgkuxRa0IdyM
         Pev1nq7qes9S05luk+cW1QYFOji3dTDS6zFsQdSeqvyQ/mLM87TR5b6J6ogWpDqVFaS1
         sfyZCeLBTFMIfLHA9T15LJqtfB45Fw8kBEbpmWQgg4WzenhUO5s+DxHFgpMfHPJyhCGs
         wQtFnQtcJHddk2mnDxY8k/boScAi8k++O2BDtdWRUiHlwF38+zgbIHB2fuU3tZu9z79T
         mZ4Tivqb8DZZfjOK9tE5LitA4808povgrD1hY6r2S+wcfbKQLcYTQKyUuxfXEoQMEHlQ
         b/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921643; x=1783526443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=QkuVG2jmUUY7ltPt+dsO9aqgi2YkSsrNk4CvTWQ0SS6RLKMSy1EjRRUolSepDYcYvq
         X33dKGg0y9oktkpkUSp72V5s0goIJ7F6huxe1fVwVch6k1LjmabowGmE3pxx32I4CDfs
         RjQkeZ/7ni9qqnVsxlrpVOKPrVwhUcuEqMnxj0pr30SjxlFtgUCIpXZmEzy4WrxtNp1r
         I2tdvx6UetMM1zFEnPYjP+9AgiwRoZmpKvLNH2mhiSoFs8vGQ7nRA6t5LMuv/q67dPA9
         +d4nuRZJLq2EvTXhOlsJzRKDaAu6CilQHEHlGJjSlD98oEnoKxdAT7FGbfEnFSUExCmt
         K8dA==
X-Forwarded-Encrypted: i=1; AFNElJ9MDJSAjbxAGO0pGY7BQ2slVwuo75nP3KFoNRAE+Hz49cb8fWRUz6yHdOTJST8foSjbv70fVW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgt5TbcXP0ihtjgL0W4bRssIYtz4Q8wQNhfJMCeVUBN4/ueat
	YXYiAas709IJgxu44vi+4/jVCoDvdCj04wyR8d0r3fX5ZUVeY/c5mzlYJ3hwkBihs6+ycqNe099
	ZCDUz2LYt5Su1SvFzvXNNE4jlOwSn/GkUh4CRgNZI4HRkSkdlrHELvv+bxJs=
X-Gm-Gg: AfdE7ckWEboVElPhOywBFL4oHX4FlXOXKKoyRV5DMg5kL+l+/gfDC0fq9lBoSHhtOiD
	G4G4Ugjz2SyiTP3o5waSaV3M7abyKV1o0c/tslQW0IcPgEhArrPclDrb9OP+0R67QK7JSaBCcbN
	sqV34c0KA5cDH5fYN+f8W0al8xNMWJVyntch1htAnUraVt5pTj4TeH+p1jnQhMGUSIjdH0MVdQr
	awu0+Oc5NSNCIUGt2ejAmNsuNBlfXGoEmLZyBLjTicl0XGW4Szs7hljvOHSakDrecSTqevDVE7q
	VzPYf9hHCtDBEa4GcIhb30Xj0TcOI4h74y5JXKeYFKF+9El7VukRlnrHpGw/8UBwW3+P8nLwaDi
	bB0mcL6w0DSyMMmKNVg5x2E01WGeUSe0s93X7mI71ND4QlyvgFCc7VXPWQZW1rTxtjOZpzm4mJQ
	2iLjv1wJ1h3XLAIXqRK6vd8F8zZrruIlTP9mHwEnBQoFBSIVXUurkOJqsf9ehbr18=
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323526585a.28.1782921643121;
        Wed, 01 Jul 2026 09:00:43 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323511985a.28.1782921642439;
        Wed, 01 Jul 2026 09:00:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:28 +0200
Subject: [PATCH v7 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-4-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: QsijHnI4rX5EMJyIh56PrzcEcO8r0NUx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX+T7u31rVhmHk
 PEk4FnPDRT5iZYlQSe+cNEbPQkHPchElVRN7Ky9+NAtq05msrZegN/JsRZ4grCar8OCzsHnPwKH
 QvKXSck+N8oHHVOBT37VJvrUogz+9Q05iDZMsaQfBZoMnIWgkZX4tMwM8mB68wzNU8O/352+c6d
 T/zw6iVxHzdcZXb2xAQwMhgaen05TwGc6mPzT2BdD/J+Vs8atcZaIrOn2zWiHbhs7GHKYR4J0/y
 rQginRVJmBWktpfpf5VjBVvrz64lHUU81KCmeNBKgnpYfLkzOyPoYqV3vWljdvcYAjKrLfwAbj1
 BxrPgsqfe/gU3MCrvCEKqB/6VjTmO9Rql7VZHIp7aVW3zzclfFC6cy5ru/d1cb9L22mRoUbvkLR
 4jC6rZqGwN6VMkfG5hSE26Qt/q4GFygolL4V2SWpAjbQ5aMKyJVTIr8uyQ5hWOMSUwV+XN2OO+C
 r8bwxSoSzzYqMxrS6wA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX0eRgylirGwe4
 H6F5xBpJuZc26w/22/T7zayiOAWocs1GhRkdWe/zr465BdxKJ5p37OFw26WbJcgVQJkdCP7kY35
 FJngQqk7XciXYhGg9dMM+zINCHwYV6A=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a4539ac cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: QsijHnI4rX5EMJyIh56PrzcEcO8r0NUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1

