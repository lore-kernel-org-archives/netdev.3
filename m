Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BB1F94F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243187; cv=none; b=FJDjQsknsXkz+me/iFkf1JecBgBwVw4WKrLoz4Rn84izyW5E6u47w9zq4/3DdqThTr4XqCoJqPNPvZLAh6Ow7GRg7epnK2FcqsM98zMdbRWWyeQ3nTcRxJy4i+CCGvTXWIL0EjcPfWOvz5Ix+EfwgYPpWLqhjE3eZUVReMDIj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243187; c=relaxed/simple;
	bh=tmBDYtXEn7QF+P/Gffrerjt1xFVzGjsaADtgY4akAV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRGTfNbsaaAg8kXlwhSmkkm7ylDQb6ALp6z36ea8RPW0VBgRsCpasooe/Vp4Bdn0PR6PYTurY8UTsfYnSkTFIe01da4Qfko5gJbxW0lHNJpDJVEiTGCC27FuY5mnpA9ASCo45cQb6e85F3b0w6YwBzJ6vJq3+sci3jEmhMQoktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLBz4bve; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XSv7LmUN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PLBz4bve";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XSv7LmUN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68123KIS535420
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 06:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=64Fc6Cp8W9q95DTXHpfoWRnw1VvjCOGDPFU
	7ee1+j78=; b=PLBz4bve4E/wLQ/FJSCQ/yjd1/O5FqZheAHLmLdrATn3MekZH+o
	dAiQRvEB8KT/ZhuahE4O3GWNOHqePSaXZfaIpwuwcH1uJutOZdQYx/QuQ/4mW6Yp
	ahYvl7/Nwi71kkZrlmuRDlftfCkAjzszZajNcHM7u/Omv76hc3oOETAlcYSFivRr
	T51qkz+TlbjqUHcD9y0xeXg1kNK4zzaS6GNQ3Qh8tWVUTa65jQs4kikdherwoaiV
	yZL3Ovz3+yg3n+6YKFq/FwCk/gPcw/Y+yI03zS+TDWGr/NVw6Vuyn0b7m1A8lrl8
	0t8gj2zn3Yx8noHBwmZWVAjJw7+Ylx2nrBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8rw8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 06:13:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e820609d9so868091885a.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788243184; x=1788847984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=64Fc6Cp8W9q95DTXHpfoWRnw1VvjCOGDPFU7ee1+j78=;
        b=XSv7LmUN6NoRBFPo6m3i2l/ASXZSYeSu2tjXGLxMmvokraEH59QlqPhq+jxWoWaZSL
         /d0eJHWRLvwlw4Ic+xvBj08+k9/A+U+NaRv2snZTT+qtcGztECfEm7kJ5hhR3+G4PM4R
         TgGRAMWoeN6AMJZtnP0Wd3Y2u21cYLAEaw5i9JkHjDdbS9g9rs3IwMD/u/Y/BEpjzDRw
         WSiVAaRNsKyrvK/qAedSrPw6+yvn+eXrP9gSlYPwYCU9pTj1Jpst4WaiKK4Q39TIUNrn
         OceGijybxZm9nUJ2/CwYbhr9E7wk3OT/hUW1EmT4ZzxfvzBuHxkfR2fznCRY6nH6IAxu
         t0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788243184; x=1788847984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64Fc6Cp8W9q95DTXHpfoWRnw1VvjCOGDPFU7ee1+j78=;
        b=RfPrwnHlvEEtYCgCwlvM8lBJUxtzS4o6HoUgAKHyZOkoX7QEGw0XD2JLPd0ypXQKGt
         PUv1m5TBAiDC2V5VECwBy2d4FuBSqhSX5vb23V5erbsYzkOb+pdIszxelPPtNqk8vEYd
         EofwBCO8o3CFwPCVkYu/SspkdLQGuug+4FeAsWEx4h8DPUyNpykwKos+6uQM8B8A+I1P
         EWFCyICZxBvLYYy5y6EFA9M3jcSzchfHyjA8ADMDR3b/JP/KS/aa5VPljnEjjsr5M1F8
         AqtRHqXdCC/DitpJPuNeAsugAaBojLYtAkCd1tbG3CKYp4rjUR5QphSnthTvV7zifl9w
         neFA==
X-Forwarded-Encrypted: i=1; AHgh+RqNM/W017ZwuLGZDWdEj4t8CZI2qlK5bkkB4OBtrt2HVsNAZrxPMAY4OyZkgOeOl8jCYrFCVCM=@vger.kernel.org
X-Gm-Message-State: AFuF++lDyG6bAgQ0rFsufWf0HmxgtXL4VZSYzopr5oYKje4gdWdU8NbZ
	58k3QBQJKNsklw0+Iwq3O28/QlfNBOuj1fSuLaOJCCGKf8yOXmz34ATAzHEM09X0svJnn/heWsX
	Q93mFvafD9x+PcxNNqFXDhgU1cgaSMkhQyvDe5mE/25MnaAnEcms2dQGUzEM=
X-Gm-Gg: AR+sD1298bHbysspka27YRxwMxVCuX3zT7EI+bXIy/kpNMKtbqK2QAXYKzQmwq/VIvv
	Cfh3k1wv7JBqZJ5s+ePQECQjIE3890EQraWdOe8uKNwcOIeGHJp/oyr1dKTxmFu//EG5CD0Gprx
	LA0ssbGnXRauCvYtFnDmTW+rYd+jgikWx0BsQVQ4n/A8FRU4pp/c65fBgshmNXk+4Fd6STJ+fX/
	JTdxZaUHun5/tQ0n6uV64NVaGDY4uklQzfmvDWUfCn3Tem5kJEsPBTaXXWK5r6o0eAGsGXPRW9S
	XGBx7dGDy8XcKCAHQbAGWdPDoicj0JehBO6be/yVIRJo7U/cGR9BO6kIO3AolN11xVPSLxm6IRp
	6bJNCE9BgZo+nOeM=
X-Received: by 2002:a05:620a:bd6:b0:939:3626:558b with SMTP id af79cd13be357-93947f80627mr875347385a.5.1788243184197;
        Mon, 31 Aug 2026 23:13:04 -0700 (PDT)
X-Received: by 2002:a05:620a:bd6:b0:939:3626:558b with SMTP id af79cd13be357-93947f80627mr875342085a.5.1788243183663;
        Mon, 31 Aug 2026 23:13:03 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d6eafesm2397518f8f.24.2026.08.31.23.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:13:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Madalin Bucur <madalin.bucur@nxp.com>,
        Sean Anderson <sean.anderson@linux.dev>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next] dt-bindings: net: fsl,fman-dtsec: Drop redundant pcs-handle-names dependency
Date: Tue,  1 Sep 2026 08:12:56 +0200
Message-ID: <20260901061255.25734-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=tmBDYtXEn7QF+P/Gffrerjt1xFVzGjsaADtgY4akAV8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqlmznaSgRk4CJ3ULRxmcX4rpugQNhVnRWTGSNa
 E8A3T3lLLuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapZs5wAKCRDBN2bmhouD
 16GeD/96j4VBBsiOCxTl0vY/rbA8roLRwGZ3c3rpd19Ayf3xympShEh+TzwmkP2v7y6MVbhwXjC
 NruCPEIKt9sgo7pAbzEisogKgDe4AjgGt71y7CWmC5nUu0TknI37yYJ+aErbJFGqySI/xbwiRzX
 qRvSIRDqTGqcuiu0JqL6+36SCxwag183wGVEZu0Tb6HI5D/+npcQw8poWp1Zg92Xe8jMUQnTAR1
 z/BgaW6l7EM4/LgfkK1nejeDUvTfQZxwaAlwfYL8IDAhwZn34Jzq0OzLXX31piyJEku62dkx4qH
 Wn7/gUQSbcjZMk7RJF4Vq2tf8U6HNajurrddJ2drO5EGjtjiTYKS16CzINWK7ZPCrgzyQfq16I8
 gxHhkNgi6FipFRqcf5t7HHhohmanrHGPGs1HFqnesrcADbPPUJr76Rp5KpawPBIi2z0D6NxpouJ
 K2TaeA45YOs4a8rhtxn6BazAi77oTSJX27pWEkiT7PIkWByALos77eUJFTUN7TnnPah8OeupuMK
 wQIEkfKL65t2F2IK/ETONLL8lAkK73QRWWlr42CxwbXokanzE0a4slD+4G+HiKcAvM3FvL8OVj4
 EPYmAThrrKKv8uR/Z747XnjPTvFsv8Fpqu033laDwRl0EchA8obE7kUgXLWfxYMx31Eg/nUb/V3 m0OvCQKjvWRg21w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a966cf1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=kdWYA6eUZccx_msbsMkA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA1MyBTYWx0ZWRfX3ggie+WNX9sl
 AfkMTniJ9jdZTOZfeE3llnVVDM3nKS2f9Ie6VXzDYRm3zs/OyVayY1bFdP7i04JZKNXUvKchJF4
 SEJnmcIZROFcaOZGm8w+2QsqVFmRYNLyVud43UkmjuT+Hq4Tw/OCTFG1JUQFUEErGYaiIL1ZM1j
 zp2ZzSF7FvuQpntwLzFwL+LNLinGnQLWeEO9nQ1xPPer0205m+zw5ONjRR6LWvo8RbEE34A9OdX
 vFKHUGnwloiMo6W9aL8cteL416Oi7wIP79WU4qN3axHlNqQQGpZNmx+QH5Lx26ICRg3XZP/puZp
 ctGO9dTVseAG2CJLK9iUUxiCz7ER0J5vjNXv0yeGLsTi5gGjEQsuEGlmSTFiNwwY5ENPtX6woSy
 9kQRiS5RvktYebGSoD+t2ZLNxMqAeRX/vedb4HfsZabAKnzECHDzlC2sdMMx9K0AsJHHgI4xXcm
 VHBGunDzt70nv/Y8A0A==
X-Proofpoint-ORIG-GUID: TyJMlRE36gfqD7w0jSAeAotOM1UuhrJE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA1MyBTYWx0ZWRfX/nIeQiqvczG3
 BZ2iRrj9hsE56VPS5ulh15dDVA+tOsUKgnSE4ijWfIpQdbtIpwXPkxovSPHfdgCvbEw3enFwbmk
 jCSgJL9Y0ktQs8VpaFmwEfjBpkinS+U=
X-Proofpoint-GUID: TyJMlRE36gfqD7w0jSAeAotOM1UuhrJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010053

The binding references ethernet-controller.yaml schema, which already
defines a dependency of pcs-handle-names on pcs-handle, thus duplicating
it here is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
index ef1e30a48c91..5dcb49f2f3b1 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
@@ -125,10 +125,6 @@ required:
   - reg
   - fsl,fman-ports
 
-dependencies:
-  pcs-handle-names:
-    - pcs-handle
-
 allOf:
   - $ref: ethernet-controller.yaml#
   - if:
-- 
2.53.0

