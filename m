Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6E32C924
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161526; cv=none; b=HaxDETyulhcDf4IvAG+JwZbbDt85MRxeIvJiIdiu8gHxhn9p1bzduq6sHV0gTUkaYytqV9NDKwe4dkDf60pG9HOnqRib5cM4DwqMnpxjKo/pkkdzR/Ib7EMrUWfch/2hH3FhhKWRUsOwNh+Q7XL2QzHmHfiJBijVbSmBZF7r5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161526; c=relaxed/simple;
	bh=iSZUnfyH+DVrkesuf/BtMSvD5hwtwS5ZUa31xFlmYh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2Uo9XxzAV3Y7JJBxtvUj/0wx4+LZyzo6sTIG93F99ZA7YlOhHypHe0kjeP/RpXHYPMKns5nlgqon02xHdy6WvfWhUuKGljf35IoxXR+NnCQuxFRfJQeNj8R/cTXfKjiWxmml0R7lI/wr40cpg0qkEoCVc9hubwrOZHdGHW+23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RqnW/cnu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dniZN+YH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqnW/cnu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dniZN+YH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlhwI033222
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vKDjFX92LO1qwtn8nrc3KuBHe7b5GxwoJXERam2A4js=; b=RqnW/cnuhnfODFAo
	SGagn9k+UkIkOAnEvW2DlZqEX4MRMOzdi4WhHxMHuYyrhU+l09Yr+N3IWDU6rht6
	finiWOjY1ITOZwL9+wBevOPnTgfMSQ+ojXDbVcqdhHbze3Rpg/ckytG7N68O0rRg
	gw6dAJzVWVJIi9S/wkzIMSPG7oWsiBTkOXx7sqP64yIbYuiyRzw0CMA0djnFqFD2
	rT7tmI2VchODdlix3TjAMp+LNi8Hz7cF3Co0lMRL+yT7OC1NWADxI6LgZ1Mbpp6E
	cmCXxKxrR8GtsA9tRYaDoybMEx10Av/9EYKIze7L1nRaj5pOUSOvikmvRzqPlVYX
	3iUO1w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c615ke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:12:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8485d853b08so7214871b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785161523; x=1785766323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vKDjFX92LO1qwtn8nrc3KuBHe7b5GxwoJXERam2A4js=;
        b=dniZN+YHCRhclFIwbA/bFZC+Q8WmoNs4QkX+DOa7Jn4U7+4b0et8tfW62FsJAcweia
         2uhP8gqA9PSb3EvRnZpJZ7yAlTrrJ/AWxrJDESbgArojC0/Tkhdj65pYLEaYfvIwb0Yw
         /LYtklsTttr9tAzxx6SrBI6FiJXoFVx6jgWPOWtua6u56QQFkumF0crWLf+di4eKonvW
         G9Qn3YpKY6LtNKkpJw+To/wBdEfixWztHuiS9bwkUu1yRapDUtghgyzpk+JYGOAR8ExZ
         AvTFekiAidczczFij9cWFkv3nlDMKR9qIanbsCcn76/v2/TI7qKjGOTJkiQ1z1lgUrfd
         3azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161523; x=1785766323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vKDjFX92LO1qwtn8nrc3KuBHe7b5GxwoJXERam2A4js=;
        b=ick5LABALYSjPO5n4JiJkSSB+Jg/SYXKqPDGOvYkk0Y0Ids/cLwLlvpnMtDGNNu6Y8
         SLbNPf5mX7mCGJDIBjbEE91HWb78V2rFHlOwHExG22z/G7xsPVMKyTOFdLBpMJflN+sA
         aiDTFSADe8jAEl2LdLwkPltP+VliIKfeGCwI6tUz0f2UZTjAbCIpOdbGwHvZe+/TK89X
         TEGGx+hwKFAqPkLOcduIeL8ZuX1wt8pAv7OTcUIXe+C2+Ya9Ttr2H9lI9pvBSEkeb4uq
         5WcR6a1eGPrwYOagGVrmaNPXK73NvXkcJJlTWHn1kLBr7bv2GJh8E5CekKGYPq+Hlxw6
         6fdw==
X-Forwarded-Encrypted: i=1; AHgh+RpfFb9mjhgwWqFYGfFD6D6d7g3LkvAP7ZOaqt+QTbOwHG088cLPw2F15seKe0fvDCxB8Wb0hrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6ek0euPjOIlzhez1R4EvoAxhKzrShR1BQP+XMl6xv/H7Ei+9
	CHimsqDwK3M3ppeFIik1omIrR2Dqn9BMFQ4xyJhmomU+oNh0ejqSW1Uit3GAxZPBmlpEaSHjVlb
	j/rQGUlT97mZOx/lJgI1IGKEeubh2qrcijGxIvt/CRzasV3IgFuu+DoVyydU=
X-Gm-Gg: AR+sD121oVxUgQIQMlYmgndX9s5Is/zt6p5Vw+XuZez/4SCwwT+sbZ2MXh/FqWKR41c
	hFsppB3XkFcht7IWzQv7AOYwUv5Zu1ADtItT+KzG24ehSluV0bBIiO3LPzYz51MaMguebEtk5q2
	p6WkZ0WJAIUp3fm6GdqysuMD1X2xPNxp0NexIK+p20i4Z1F3dYfzyFkFPjZhnaOsk4yUQ7Vn9ND
	EJkJwTrC1OwTSxN34hBo1yryPipoTYZZar36kZ+SZnIzfV5u110TWoHorup0zUAWvODhmC+EcZZ
	Ty6bCgRQPqJz1beeskLd3S1uwnnNEwQXoYj0LqK30MGd7RIsOWtxXseqRbd+8Y/aOzq8v8OiYRK
	BIIKH4x9gICfAM+7JmlLUVzkV9ikxM18=
X-Received: by 2002:a05:6a20:12d0:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3c67dae9754mr7826596637.3.1785161523565;
        Mon, 27 Jul 2026 07:12:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d0:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3c67dae9754mr7826562637.3.1785161523181;
        Mon, 27 Jul 2026 07:12:03 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm53438677eec.13.2026.07.27.07.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:12:02 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:41:01 +0530
Subject: [PATCH 5/6] arm64: dts: qcom: lemans: Add support for TSCSS node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tscss-v1-5-beed14e72510@oss.qualcomm.com>
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
In-Reply-To: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a676734 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=cV2z5tzyjUHL2YBgtoMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfX1LEQZqrd7RQc
 cl2tIbs0e3Svt+vBG82jx/ofNGQdJs+RTmTActTStiD4D5I819byoww2Ld1B0QXxNSYxyNUI4qV
 +oHqnKL1ig7dkHVLO6A8mdLqX81PAYU=
X-Proofpoint-ORIG-GUID: 1NAxNv6blHH4VxCTewwpFOnbdO1_qpmV
X-Proofpoint-GUID: 1NAxNv6blHH4VxCTewwpFOnbdO1_qpmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNSBTYWx0ZWRfXzK5A7LhS4xEf
 Gn3kJ39ku5KzWhBEuc+/EmAU2aZtSyiVUE75LbYK/gEW9beWkeSCAlWXSrkDjzrJFp8BTX+a/7k
 z5kUTIJz0uHCpC35/ZVxBWy0/f9SvuYllMznqxJUSQjava8pLZ+/VGuE4Ra3VL5vsEgUUg/hQFp
 yDFBqhH58dhWoi7k7Iv2VT13JdB1SG/FD6yk86PEX3+B/kDzDqm5Zxv+gcW3zqA5+Vlnh8VNHOA
 6eOg+0zFnu944sq8LU+W8yveI7nt/jBzi1v0Y3R1pz/7jvRLV0CA6gzuF7INOB43ZLUFRsHhyeh
 wxIAv1OgbGlx0lMspHwCGhG8nQ+r/Ivbfq8YkFUkTj07iOdJ5fKI+f0/T5RXKedY34LxixZsX46
 Dwq2iQMeDCpcAIwu/w9s/ukY0Mo8yFMZk6VeQUsyoppPFTumnv7oqIpvfCikbQCn23/ZYEfUSVG
 M4RH0/MtCiY1TU6tAug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270135

Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Lemans
SoCs.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 3b0539e27b5192582e0bc9ea248f1c0382e05030..e225292a1e41a5a313aca188ca04bb12474995e8 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3023,6 +3023,17 @@ pcie1_phy: phy@1c14000 {
 			status = "disabled";
 		};
 
+		tscss@1c80000 {
+			compatible = "qcom,lemans-tscss";
+			reg = <0x0 0x01c80000 0x0 0x2000>;
+			reg-names = "tsc";
+			clocks = <&gcc GCC_TSCSS_AHB_CLK>,
+				 <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
+			clock-names = "ahb", "cntr";
+			assigned-clocks = <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
+			assigned-clock-rates = <15625000>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;

-- 
2.34.1

