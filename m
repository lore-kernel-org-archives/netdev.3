Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074815;
	b=h/1ZMrx6mPL6oOHSP+wlFzwZA9Kv3TXd3c3LnBh4JydIvjlqaE2XLufFeauiaK4iZB3p
	 z4V2ARMBLwFaQK5naiCH0/iMBj1IeFqjGmYeg2cBCK7LaN7MSvul2/R1iqODlPRpv0c8s
	 1wIxSDKg576K212czv5YZVuEyrqsHyQyHqT3xCmZ4s9HweCgVBehH0drKjWsprE3sE80U
	 TDuDQAKduv2PyOmHOAocQlN3CIQSFPDLrq8JJUqUGRY9G9Pc5sFgObbryzbPbSavkCgt0
	 +ljqKEBG42cVZ5qI1Ft52Yd5idBmid56dT69XKhnZHz4117uJ98GM4hRfwMUNcKJ3EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074815;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KtXcfDwP0OI37SAv9nafNaChy8uheMzqgS7OX1e7QEo=;
	b=3Q7ZoI1TrhqLgi4tckzDOsI0cdAiRthdNMteFPxtoG0Pd4stqpeHVkf2jOqM8ioLIoFq
	 8LffnUIMFEvmRfywZDse2DBf9EGsjGqceR5tJJv/MhNXYSHFJuJRv6rBOxhgiIMQ2jcCn
	 e2xx2OD1RuILiuudywaix7V6EkYF9/oSAiFrRKDhO1tZvsQiqYaJ1adNMRU8/STt6g1hy
	 ZKpRZPVxmQ2yhmuSn2tzohQgoFHS/i41sgAkduj9JK2GNbGOjenYRsqkEQxa3j/cclRCe
	 BywUWs1Opr5swlich2DSXsR3CMrnR4gFVdtG5wjR/2irjQ5W0ipm4xuZdDZGVm1U6xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SreeR8Pf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EJxR6hjE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E4606A32E
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 18:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9E4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SreeR8Pf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EJxR6hjE
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7HtoA8207078
	for <netdev@vger.kernel.org>; Sat, 7 Nov 2026 18:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KtXcfDwP0OI37SAv9nafNa
	Chy8uheMzqgS7OX1e7QEo=; b=SreeR8PfOUXFldSESQfVsX5Yqmkvp1ACbfBR5c
	nybxUPAOJHvDNI3VlvdU1kRKc/j2sMU/ae58GpQMhHw0pDCytxxWxAfoEqyEFTwa
	xxfp5J+c29n0rfMa+CwIAPxjsiv2+IuU+ZBtqHaKIPsSXWcYUM/0wT8lFk25e85G
	NrLe2cGzTBuWzH6gW5gZPpWS6tuHAGxlg9bw81b5gQ6cdK/VOhKEC7RXh6y2Dn8m
	cjP1hTRNLQxraD7/VgVwq7MpHeGG9X7Og0B4hHY2Gq2n8QF5d5EhjMvRuqK/cVFr
	O7zSqY3raS0lDW1ySkxUsCbT4/r3gZlS1ZDlhyHQ4J3ooQLw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf1s16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 18:06:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so3690101eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794074814; x=1794679614; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KtXcfDwP0OI37SAv9nafNaChy8uheMzqgS7OX1e7QEo=;
        b=EJxR6hjEpPTAq/Q9kFqBqHGQ99+GIL2Uc0vI+sLW2oXwwnbkZ8Gt7mx+ZHa1lLtro8
         izR0A5xatBt1crM9igbIjM8Msff0d/P5g3xFvHJsniuaA8XRM+Qjp29Sj60jCMLHdYra
         60Z2ZTC6a+lDScX/3kfKOeOhsZxABh2iC/hWSC/bAj0ql+IV7HruOMuZOvdlPT8D2oZy
         skuQNqI/V0lYxZQAHg2ULO5fYUadFi8u9/laFHsXUG5t8jfrMXxci2Ky5C6r0iJEdWJr
         BE1vnVN86FopAw/3sD/zRA00W4TLdCQO9X4X7QhpwOmbL+dnZU9LOIfHPrwruLkRy51h
         K5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794074814; x=1794679614;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KtXcfDwP0OI37SAv9nafNaChy8uheMzqgS7OX1e7QEo=;
        b=YYaEWGnGYIcRsSTXsOC36A3XFSIE06BJcUQJKxBuzIkQQ9royOjOz/tPWSgFvjq9Il
         nRBzaV83noe+RPvinOnPNmvlpu0JmgkMfrkt0h5NAPxe/RjA2pCcN9EKeiqxcg13O9Hf
         jphPqtoktsqr/nZiNifoW1O6MjWzKz65RtoUBGw8c0eMt198evLJPrGPdm6PkHW89ylA
         h5+++DNRnXLnffu7u25/H3K9U9VVLoXw+7QXmY65jESSZK3J1u6VLYh1ToC59R6op1Z3
         n4nQgjidHK1r2iVXYgrl9/TfMb9t/DyDh31cure5W60yvqN8jU+43XCg4LwJVjemKhov
         z1yA==
X-Forwarded-Encrypted: i=1; AL+hErEgB+ZaWQBxfMWxKGronfkHToTUPz56oKOqZq6s4UhzTXoBYHdz8IQgn9F7uqc5brfaRBihWK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9k/D1p54yjf6VaFU+wNB8F+VDdNoUMvGSs5rpI6PR4HwvCx9nw
	zZOf3VRNfRVSeY/4MdkRW2dzUSJ7jEGlEiw4OGX8Y1+z86MQbzVzk4Eygf9ADso8/RXTYOHvOlj
	j+ALQK76lvW8gGvkugmBRNsHzQxlPaxkTWcD4MK/GxcwLRiSGJNCGMMNYRk8=
X-Gm-Gg: AYBFou1eo28vX2lONsWoqWfkDtcFxuwRIEQI90beHDARTW3IKxoVQMmYQ/BYIPqc/5P
	D4wqj0fWlXVez/Osw+JJxv8JXfwczVgPPU/KSlC3jF3u74uMZohg0D9afhFaOULAWIngIgn5m9w
	5oYQ7cOHH86s56ncAjj8ApYGS1j2+8cK4WQ071vS0CViSLqSzcs01sLReqLuV46Qu46JAMW5bpW
	aGPj2wSBBWZKYV7rYSViQwNTaZdlEVwpujJLIoQzJ3F3NZxbr/heC1lCQHDR/f0qmpVx6phWTAe
	WbVD+Bmq7KUNr/fAcvdIRsDh+PxTQjj/LWJ1/Uzi7L/OJenNbJZn8BcsDnrBrICku26vO9u887a
	hiMyU2dyH2ymaYmtohqz71NSwDzRHhzOT5Ob4gkh7YkzAWoPjLkRsb/lFUhfvdqTQIwQjKhAy
X-Received: by 2002:a05:7301:4d0d:b0:36e:ff7e:e57f with SMTP id 5a478bee46e88-36f75e28a16mr8095921eec.19.1794074813447;
        Sat, 07 Nov 2026 10:06:53 -0800 (PST)
X-Received: by 2002:a05:7301:4d0d:b0:36e:ff7e:e57f with SMTP id 5a478bee46e88-36f75e28a16mr8095877eec.19.1794074812701;
        Sat, 07 Nov 2026 10:06:52 -0800 (PST)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a47esm24710212eec.6.2026.11.07.10.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:06:52 -0800 (PST)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH 0/2] clk: qcom: Add I2C and TSC clock support for Nord
Date: Sat, 07 Nov 2026 23:36:35 +0530
Message-Id: <20261107-gcc_i2c_tsc_support-v1-0-433d02972d7e@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKto72oC/x3MTQqAIBBA4avErBNS+4GuEiE2TjWbEqciiO6et
 PwW7z0glJgE+uKBRBcL71uGLgvA1W8LKQ7ZYCrTal11akF0bNAdgk7OGPd0qLb23jYm2EkHyGV
 MNPP9X4fxfT86/JO8ZQAAAA==
X-Change-ID: 20261107-gcc_i2c_tsc_support-64aa352d3b1d
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA3MiBTYWx0ZWRfXycsKJppNB7qU
 34h1K4nxX3ROx6Hsu7QgdifG8FzkP40yLJvOavL2C+PXV1FptZGSThqOXhfrAIBPe8rqly3vsrB
 26p5N8V6oMx1CbuKXWZqnI6hOZAgWlo=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6aef68be cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=L8zgO8z3qB8kSUkvw_kA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: HwqAaUITk7VbPvtx7kO1Kp0RZmuFmS_V
X-Proofpoint-ORIG-GUID: HwqAaUITk7VbPvtx7kO1Kp0RZmuFmS_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA3MiBTYWx0ZWRfX9IUL5drp9mxH
 Djz4VlW+RJSHWDNiR57WraLo5hPkQHpVgkzppKj9WfhLwkvBR6YDXJEHRBdmJrn9CsuvAqYGkBu
 e3ZToBlFahSdei9DAhhSJPFxGJNy1lKWHPFnAu+OVCL3jQJARD6Q8IuEL8ydaJgxVaP/NKsmEvK
 YJQS/6J9E8vSY1+B7Hl4NLlcYwYKkfS/+cTpml41aLoqfWfSwSE86XCAqSipLp3JjbvGfbGLWbK
 N542NEfp0zyhZgo6o7k0KOmnsAEN7PqNyB7EZyUOkTzLLhlVOCGuxogH1YAbO7TlkA/MHYvdNcr
 D2af2sQmyHyBHXsMbBl5x7KJI84jPMXFUPZif3g5tRM12364f1kkDxurkiVs+f8nRnB6x5/6gUe
 vGBk0x4oSlevUc2TpsU9GopOEraJ8ujjRdEqWYhC4YcIUNORpl8T2C2Ps48Xt+nW383SYh5DL4a
 FMpGZ8/VrwwRqMxxWsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070072

The Nord SE GCC provides clocks and reset controls for its I2C slave and
TSC subsystem. The clock IDs for those resources are not currently
exported, preventing device-tree consumers from referencing them.

Add the binding IDs, then describe the I2C slave and TSC clocks, resets,
and TSC parent PLL in the Nord SE GCC driver.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (2):
      dt-bindings: clock: qcom: Add I2C and TSC clocks for Nord
      clk: qcom: segcc-nord: Add I2C and TSC clock support

 drivers/clk/qcom/segcc-nord.c               | 187 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,nord-segcc.h |  11 ++
 2 files changed, 198 insertions(+)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261107-gcc_i2c_tsc_support-64aa352d3b1d

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>

