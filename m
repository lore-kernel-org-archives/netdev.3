Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2602EDD40
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322570; cv=none; b=QuG7tlYnXcT2alBPzQJU/rRb0bSOU0+tVfU3JQI5ijdSfdJK90gKplU9HY8Gub8FjSix0w+aqwub0I6WrMrp/Y3nUgg1bDGhe1cBM8FQ4MqSjT7s3v6O/L9I3OEjbCB0uckWptnYyP3WXODX/QmoJ01PFUbFKmXPdx3NAow8Yig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322570; c=relaxed/simple;
	bh=xFuVI0jFiMJd7XBr9jnkGr32jATQaM3BkQNG2r2bzXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFCi1wYpvxW/VrOIyLPZi0tmRQ6zrX1JoxzEnwo60bLt5WLozCQJqc8nhtvAFVKuYu46Bp235QUjCm11ywEDBxsR70oCn1WCfeqvGIjtm4K+fcQICuBAoAmGNhN9T1UhyYWqmfLdzC0Lfw/IsCZUYcO9468Z+dDgX9Y29psOuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O6xEddKt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RnzfM4s/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6xEddKt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RnzfM4s/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679L74j93435743
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5u8DMFr94cK4iBN9tLFcCQlCsXfC6pnlHweQ4gSue8=; b=O6xEddKteI98DuhD
	a5ohL1wGxAiJyr42TDG6YY7rhzne7yGEF33a1oCd+1e974YNbWUr0YF8+bh15MhX
	uGxCq74WQk3U/EzCCylb3Iz5uV1xhu8izodaIatzWO4VX8oC3sSa/HhsRb44WoMx
	nazngcULQ4Kop811lIJ0S5zeO0ixO+kQz/zpe0Ec4fG8jkANkc+IdpjGGjHf9tzz
	2dSMVQUbfsK8Ap4lKIuewvu6tMVl3AtBkoFja+8hjb/4UhOqKdXSTfwVfGmKdbmf
	6+M3UTlRLTfo+GWcrHN/2pYx+M/qPhqdfvRrhfkBo0GZd+ggk1G7eoRSnQ0IGmHl
	XO7iRw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9kqda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef8249f871so13304606d6.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786322567; x=1786927367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5u8DMFr94cK4iBN9tLFcCQlCsXfC6pnlHweQ4gSue8=;
        b=RnzfM4s/RXdzm3fJXFwoONSqh8gHvUA7apWvgraUJ0R3eFklJwAkSzHPQKeJJJeN4q
         tIUef4I82RSDRdNDB9b0Smk3MDDc26o+TL5opuHYSal8QOH8nL/bBBulQkwpiPDRtkM1
         zcG3jwNMYwW/OHE6zNjpinmdN8FG60I5L4FxEa7vN21IFQqPdG8wYqHdqVP8K/jHIivt
         /GOsotwe9LwXfOpQiygyTTHvtwjF8Lb9LmZTnG6SpkcGQ3cSLSj5oG8avImpo7eaWyc7
         ox/6nch9/Rx6Laycvq1oXfRUhpD2SWndlgVRkegLYF+cSKbVMvqg5Eg9SRexS7LNrCED
         nUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786322567; x=1786927367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5u8DMFr94cK4iBN9tLFcCQlCsXfC6pnlHweQ4gSue8=;
        b=LJxIqmSSkhVevP28hpTPOpE243HWVecqcw9vvyiRarJRzMivrS65vqEfFEdf01Qf96
         btkc6ptRV1w1QnzyYHVMjLk7H4UHTgI6KDdtvSWy3mX9Tyv+I0psk+HVMj+OPU1jfCpt
         rZmTItkU0GU4+SUIFJQNflHR/+4jmP8iBlo9s6Si8vq4c2L7Khgr5S+QGkKtfzwe2lLR
         cW8rGERN+7cFYyxL88NzZKS0TDWav3D+jMnVSXJBcdaODOCRa6dY3ODj+o1F6yMRHDJZ
         OvZbSklxxmnwvFG9SfKVWIjynE5TDxTxTJ/f7J+rIpIIqbLzOmFa9RffGgXta/+Pu1Sp
         8/fw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9vgEzmXAe8bnn89CIVl6lpI2Db7Hp7yhKWr/5OCZ4UbRimqkH5+pN9GrfM8W1uAi39KlQ9Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxJzJQP7rkhsJHoqpFr0Mw5ZCGbUbfi3XUzUPw1oJE1lBjZjx
	2nOIMk/JbsrHL38mjnmBuwh1akyp6rmQZvyRImmf7dMDT8U/HL5VRDXf2Pmk43tY758fKVzrUJm
	lpOA+BQpBAunyr5Gy2GGb/LejyR/cm1RVuKXIsy53pbeRI6fcQg/BcEUMm9M=
X-Gm-Gg: AR+sD10Y4YptqlkVKMtmweAB4QR8c8Qz52U2KJRiXAtH+JxM5xw62d3hOzfiNUQf9Tf
	Jel+CXrrcOMpt6y2QVNXc7nIUwNt4N3BYGooVfO2NSmdHqCIYCxRzmqlyCB32lpebYQD42vQGsZ
	ScU7xQrMenPNGKLkLQYXA2BIetJjFY7BrcZe4tJB6JlAjEKLDvmii3pK+yyc5I++bghekMOBl7X
	7yjGBbYD2bbuKJNoUNxrbD6lLA+VKqYQf8CKmb+0maf8hnDmV40AUEe+STGjcV/ok90rzx3triy
	8f4NosU+fIDtoUEI6xjAL7EmqXVl8sXX4so+qGmi4hn/4sytBNcK9CKywptWYjwFXzPwuUjG0kH
	VznimjV0//Dz/0g5ro4LncR6pRZxKdpx66lIDIzFROEnv4ynpcYi/OZPCCWYa5wb6fkaGwZWd3n
	bo1MA0zy0Gej1s0w==
X-Received: by 2002:a05:6214:800d:b0:908:951f:41f with SMTP id 6a1803df08f44-908951f061fmr344317956d6.13.1786322566928;
        Sun, 09 Aug 2026 17:42:46 -0700 (PDT)
X-Received: by 2002:a05:6214:800d:b0:908:951f:41f with SMTP id 6a1803df08f44-908951f061fmr344317596d6.13.1786322566526;
        Sun, 09 Aug 2026 17:42:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3d56sm1679742e87.69.2026.08.09.17.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:42:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 03:42:33 +0300
Subject: [PATCH 2/8] dt-bindings: net: asix,ax88178: document the AX88179
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-msm8974-onboard-usb-v1-2-08a805768328@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xFuVI0jFiMJd7XBr9jnkGr32jATQaM3BkQNG2r2bzXw=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1alXHWiEeOKI8cvyLlfnLEyp7Bvv53j1MjSmwb9PM0LV
 MJ607d3MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiHlIcDFP7uL8JTNtmx9q8
 vzZ9xaoi3f+b71ourp79cLn81JbQJ1t6bZ3TFGRtQ2YrVF9Mcbh5ueXOuckpCx5nh6pHTc/09V7
 zPSPtuYd4X8CBjtbZq7aHB69qP35ik+219a4uXU5Hklj3GvR/VmneEu10Myarc/nD68ZViZn9X+
 azKGgsiN76KPDkqtVl0sEPvAOmzDvAFyN00Hhrp5+TT+zrD0fXCfgv+nyM78Llz8uN29Yln6/y4
 ro1uennhmB/5cQNu9OzHtSF/WJgesF0OH6jxEeurRFMy5O5V/dNZn5pEsXomr9TT0UlzlSXufto
 53lWkcNtPS9YGD64pkwtqeRlvcl8/6fp0x3KDFLbesKDAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a791e87 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=Q_VPykkBEetrjVTKX1IA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: DiycsmpzdoqeIM4N-uBHxhw4C4p-DN0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX4i3DI4y83wls
 Z/63Kh5lUhYPLjYVA+wzTvsa6bnQSKUR6wJLYA1Itv5RmdAm3LjuTL8HdauZDMWZgCHesmuLLx6
 WIAn7IweRkr6w6EVReJCGGrLLpoXRNpp3m4Q2SQrdPErYr5PmRJkPmkk/uerLpaTuM/co2s8n7y
 3l3H5NLUzWoaGHweOfurWJ9KWCkhbr8HkzCmXKZV3WY1r78YirqMvNUn6epqy7VotZDVwPDJGlE
 4JL0f7i/stNNdkbXGGXq1ij3VVquPcp5s8Y5nTLcgbUWHQfWJ4igzftyI5EuSrHH9QswlWxhG+2
 vDg1xCnDea2m2vEV1iVfkEM6tUy9DxzybSoCX7/PEWvJ5Ok2ZboGHp49DFFMqYeE0+yFLEaAklS
 +1DQqs1ZeQIl2nXh0TKVnhKqI8BTnrf9prjCVuInx0o2EYtYTQC5aw9ufJPt0vCJQ26FCs7VHj5
 x2azVVSXQ5MnB0eqaJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX8XU1qy2mZQpD
 VOpaju4rHUbT6hWS0Xwdw50uDg6BxxLts7rOQwRth/C2tkmQ2AIFmyqnYfNNGzog0BzTN6FzwRL
 s0vwxtbzc7PZxAG4dEtBwJUdQX9SX40=
X-Proofpoint-GUID: DiycsmpzdoqeIM4N-uBHxhw4C4p-DN0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100003

The APQ8074 Dragonboard has an onboard ASIX AX88179 USB 3.0 Gigabit
Ethernet controller whose RESET_N pin is wired to a PMIC GPIO, so the
device has to be described in DT for the OS to release it from reset.

Add the AX88179 device ID (0b95:1790) to the ASIX USB Ethernet schema,
together with the reset-gpios and vdd-supply properties used by
hard-wired onboard devices.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/asix,ax88178.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/asix,ax88178.yaml b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
index 03341b7438d5..48a2ee883c15 100644
--- a/Documentation/devicetree/bindings/net/asix,ax88178.yaml
+++ b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/asix,ax88178.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ASIX AX88172/AX88772 USB Ethernet Controllers
+title: ASIX AX88172/AX88772/AX88179 USB Ethernet Controllers
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
@@ -22,6 +22,7 @@ properties:
           - usbb95,1720   # ASIX AX88172
           - usbb95,172a   # ASIX AX88172A
           - usbb95,1780   # ASIX AX88178
+          - usbb95,1790   # ASIX AX88179
           - usbb95,7720   # ASIX AX88772
           - usbb95,772a   # ASIX AX88772A
           - usbb95,772b   # ASIX AX88772B
@@ -30,6 +31,13 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description: GPIO connected to the RESET_N pin.
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply of the controller.
+
   local-mac-address: true
   mac-address: true
 

-- 
2.47.3

