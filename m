Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786F4C33F1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471124; cv=none; b=IQ5LjmjCA/tFMWknSn30fv3Mkki9T6ctXpBn80Q68TeGm98+sOVJLjXQkFeY6nOWZvcshjSAQdYGvqcCwCsC8NgThThLTQ67DkQXhvtT6e8bmUqUE668Yg5tpF9HNiAPMGd4u7aZUzlmRbGuSPeGD2MiFkSX6OhKIPk9PiH1pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471124; c=relaxed/simple;
	bh=WGkpfCN6Up9LleQnrV1JPYhqrbmq8We1WbCehLL66ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNEGSqemhwXeIAQpjZ40Yq4gW90jrGB5ecuGK/2f8aWs0WrHbqxK8egor8SFOpTQWp9h79KrePICyN+P0grYLP3KvAXtkkPyqYdJa3/h6KU4nApeGi6o18ELTaYUsr5P6rDbtcWyUzEOn/PZFrLFzPUKhnw0tCJLRh4IPM4ShPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkZ2TOip; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C9b5rINe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkZ2TOip";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C9b5rINe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVQw33121551
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 14:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9rO1/Za1A0DarcuqQ6a9H3IFa91AgUYHGA+PHZR++xU=; b=AkZ2TOipANPNhVY6
	nGZM3HQNID5znc37isRnMMCTWKW7Z/Es7XvMkQSAftEIR87MgOfqECFDWssNGyml
	eEl91JtJuzZqAnL/8EvZeRQO/A0il3na0+Afl1pz7AG2DHXV9pzNy3GerA3a+tlY
	Kx6E1z6e8NIDdhxVHMi4zB2WUKxAAnJyLsPMkFjbLIehg1ugC7xXx/XSU7iUmQev
	3RAomY60TVc1YJ5ivclq9R7prPqUofcDTXboRNOc+N72QzD3vDTqK06PWcLguef2
	ghULMB8eVyhpbJeZB3F/k8yMp3Ebk8K8yxVekQetfSxJZzWURr1R5+9ZRfOiwM0I
	E3U9cw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2ufxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:51:48 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-86e8abd7136so67062447b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791471108; x=1792075908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9rO1/Za1A0DarcuqQ6a9H3IFa91AgUYHGA+PHZR++xU=;
        b=C9b5rINesiZ/5WWsvkBsahDJsEB9cBLAcfqDAzF6Y1fs2EbvSetZAt2B7FuXgrPkfz
         52BMgRVGdzbfRmYSWSq9OD/iFCyZaFaxom678OlFeVzKpZ4l27pX7HGiPDEcr+/Dh/ny
         qdYvuzjSQmeaL2m4XTnG0sLx3MT1Y1e2HQYILE95ep8oZfcXwa/pNds05RTm2NoiVi0u
         HlaXTMWO5kjf93AERiaU6IFPtTGF70hWe9sUs/2RycnlfJRmVUm9Vk7IIhx9/T1h2bsU
         AY5pQGZJn6bqEOIoUD0XbdsFt5bZRwXNJhedCsfnOYUg/ADdNJ+tKdVuZVlJNwQRbsr0
         hl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471108; x=1792075908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rO1/Za1A0DarcuqQ6a9H3IFa91AgUYHGA+PHZR++xU=;
        b=wui2cohBgmKWVPoW4oCxIzZgVE9EDi1uXFuHj0FY1ooEaVH65xMuONRYKzOwVWVJho
         /pV5NYfLFGOsBW41kp6m5JLKgi49UDDz9+qBG3ZrW8CiVYVWMmQZLrm1CEYZQMzTF9ts
         4uQ97OFdBaYbqwz+Q6AL29nYPWG6AGjpS5sQQV7ho0dVIvN5UznynC8Gj9t540g5frx2
         7WzZb3II7cS/oKiS1EO3/FwjFOaSdnCO3yld9qBImca7pEUcZKqNNYDCzq5T/xlXWkEo
         B9hUheRCKPkpXJ1pV+Dh1IBM2HbKsv4Oxqe3EC+gj58BrA5xf3H/bqUppGKrAQf1kpcw
         bUmw==
X-Gm-Message-State: AFq9FYIXIQOkr7/+Vhyl7Vn+Opj28yriOJOuykQr+o0EI1e+wslGxJ2m
	F4gAZRkA29GbWB2snChtNCKldNZKnH9bclIqo85RW9ml00FofRFps9OFtv96QyrW24bmaiTgNX7
	pfPV7vvqdLftExGagA25BxamrT4oZjSYIG5QocRP57TZJeBK9OzNAlCXaA30=
X-Gm-Gg: AYBFou01W9jHwzA1e/cXAvoio6+OyyaCCTgU2pc/6bDItaaPtY4rUq3EzU3luBWMNje
	DUXuEEoDLP3XAIY1uBxpdSdgePqT1kY0x4XGF1c4QLYD5p3kWHntJNDMytgqXRw/OODc1IH6ODf
	892lPNi6AWAvSnEh6lt4E+FMjzz8yn7HLJJz0Gbg1cQaE38zzrWewsQo8/WvEMz+8Z2ULUl+UbY
	M6cjf6i/7ykc9Lhf0Mbi+P2EWvMvU4aQRDf7riDLtp+xZrVXPLkeWLtjZhhJZZQmZ5R52bt+meE
	UulPiX76MwzhMm9XpqHIiGbUXqixnuWUItSzyPDWV+02wPn3LelVxa6CuOIiOOwPwEjaU+LJmFI
	9SuU5kRBEDmiBbtGjaIdkDz9nWJ7TmANBPHnzfMdjK5A=
X-Received: by 2002:a05:690c:c510:b0:8ab:41a5:648 with SMTP id 00721157ae682-8b05af828f3mr40462777b3.11.1791471107655;
        Thu, 08 Oct 2026 07:51:47 -0700 (PDT)
X-Received: by 2002:a05:690c:c510:b0:8ab:41a5:648 with SMTP id 00721157ae682-8b05af828f3mr40462467b3.11.1791471106920;
        Thu, 08 Oct 2026 07:51:46 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05ab62607sm20903407b3.22.2026.10.08.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:51:46 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 07:51:36 -0700
Subject: [PATCH net-next 04/11] docs: networking: Document IPQ5424 as a
 supported SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-qcom_ipq5424_ppe-v1-4-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791471094; l=1613;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=WGkpfCN6Up9LleQnrV1JPYhqrbmq8We1WbCehLL66ko=;
 b=if3FUP57wO4vhQ6UCGTPsFbJyPrCYrEceA4rd/zYEg64iZCcjrsQDD3svxr+j8HFbj6LOxn68
 QhxjTo0AMGrCBtiALSKuwswLWa1qbrwns+pPefmI3Cc5yjlLWTQDWAp
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac7ae04 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=U071OhrquwQVcrAs3WcA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: diq5Xzo4ASXDnRFmDFPrVzdVRBs38gMP
X-Proofpoint-ORIG-GUID: diq5Xzo4ASXDnRFmDFPrVzdVRBs38gMP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX0zPyevl8KCjq
 O1m1Tvf072encgLjDpaeMuzEVsBsJuIzJJM2vXDkvm1J/elOTdmESkw23M6I+bS3i4w4itLvxfL
 Du81Qd9f648zhu0nQUZZnrD62/Lih8s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX/Oii8ksdRZdI
 oce6pPF3+pP23n58boz/Ta04YXjTAsVhJiuhwUH8F0lxzZjr5RPZ0W2i54v1uCQ+eZfv+rCZFFf
 qF01JSTpBqfoFhNcfWP3VBooXqKWZP9iYb8DOR4lGOuFvDgsKALHmFRn9S1aiC2vlj80KaeINFn
 aw5JrhQRg+je9spC1ELxKSqs8ghajb6vwGCOrPsHdbBOcA51VF1dWAn8pk5QzWxkEmvyVrKPkcM
 rVMBqhHEo6adYEs1mfaerU7G902FealPTS25NwQjfp13wlldsig0LlTVHSOP1wvPP23uiIu03Fv
 ZyjeuLFitgJ/tKxbL+dw9yYTgmb5jHG4tSFPlQhU6ghHJBtb4SyYcjyKkrRsF1D31oVJOLce8fr
 G3BcG8biThT9vwMGnKWIjwxxtkF9rHJgD2ZkwdMJAML+Olt8lUgEihcHsQxjAouq+uVg8TA8Q+e
 yu4osGhG5JAvDEq6W5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080059

Update the qualcomm PPE driver documentation to list IPQ5424 among the
supported SoCs, and describe the per-SoC PPE hardware differences.

The IPQ5424 PPE reuses the same switch core as IPQ9574, but runs at a clock
rate of 375 MHz and supports only 3 front panel ports along with the EDMA
FIFO port for host CPU communication. The EIP FIFO port is not available on
IPQ5424.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 .../networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst b/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
index 4ab299a28969..04c48cec66d5 100644
--- a/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
+++ b/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
@@ -167,6 +167,14 @@ PPE Driver Supported SoCs
 The PPE driver supports the following IPQ SoC:
 
 - IPQ9574
+    The PPE runs at a clock rate of 353 MHz. The switch core has 6 front panel
+    ports (port1 to port6) and two FIFO interfaces: the EDMA FIFO (port0) for
+    the host CPU communication and the EIP FIFO (port7) for the EIP engine.
+- IPQ5424
+    The PPE reuses the same switch core as IPQ9574 and runs at a clock rate of
+    375 MHz. It supports 3 front panel ports (port1 to port3) with MAC0 to MAC2,
+    and only the EDMA FIFO interface (port0) for the host CPU communication. The
+    EIP FIFO and port4 to port6 are not available.
 
 
 Enabling the Driver

-- 
2.43.0

