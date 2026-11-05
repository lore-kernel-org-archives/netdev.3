Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884071;
	b=UFfeaBqXSzHfIVqKZOWcCQHmEsoupeDHMWZF3c/QtwY/kJw+uP+JyOZn6p8rqAxcRnN7
	 +mrrY7NtoPSyVrntlEU7ZBVctIGGXvxM0KoZNBEjoVYMNplDevHIFemSrNWH43ZqKr5Gl
	 1wBuaSPlQPIwWoYNuu8DgUtEw2Qw1bViF5LKCpjJ7VTPFUQqJrP0SYrxbuTfwdlt4exvO
	 lQ5ZJZ3I9qyWOreGSjpaDODvNMmiM9vB3SEKf1AUzcWERSQuy+OVUFdo80+O4IBM5VqyK
	 RfXExGrdLtjbdJE/lskUHC+DSQIdoLZjKbf0VHN+oM5L53JYG6v/Z0lDJLBD5gM7Q+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0kaq2eX5JhBwGzI8FjgMD7kHw+EoZ1YtEVJNHdDTAco=;
	b=eqwIJLT0r6KAMdg2q/tmd2QMVNXck2YJwzmD7Gg2+z7tBqTXwGG/XLpmragD6T/Q2sB7
	 2xnITCH0BK2qVPKoPQ3TVbOnevPXFKk4cUymwOJLVZpTTUBCfRlOqQTjXohWNdC89WJ0x
	 K7OzjV2sZ9kB86Mfzx2K6E7nt3N3rOsulWHTdSVuok0kdk6CV3pP/Xk51WkmP95U4pKFP
	 dKSEtDokbIt+h4Nl53CgHtVAGoZjuubyKg+ItSJ9Ge/01dlIbE7WTtGgytk5KWkIGpyeg
	 vw9iDsnN77fUifajnBgMeisgR4oZqRvNCFKNsgn7uG7izIIU+wv9KFcSocVjuK5XDog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="n7HkO/LI";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wqjt+DRi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAE606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CBAE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7HkO/LI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wqjt+DRi
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59thiE3532014
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 13:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0kaq2eX5JhBwGzI8FjgMD7
	kHw+EoZ1YtEVJNHdDTAco=; b=n7HkO/LIWLbIooaXKMNlyOgDVocBx1Smgvx+Iu
	mcOk4BtfrroQoPPbbcbJi/PIDgYJH3tbDpBTE9jfLrWZ6yLUGyICUMAXg+sj9VMz
	wx/ctuLPp1ba88QcNfLbn2eaFrEbmkGIiAx86PjShv4aT+SCjCU1Jh6RQ2yBlFSA
	44MX5DzlWP35eP8ijX9J1qPWAkwe3i+Dmv/tiuxj0PNrpRkmft2tupfDMqSKLmBT
	DZ4uo5B7pb0LoCS3QtAT4R6yygrkAip5Z+EmgWIVbfWXvh+zNxZlgg8T+/w6CAo5
	TVgFd+rN95yyQ8wmjl9zh2iKcvyHBc+fkse2VU51h0z1cCNA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9rxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:07:50 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-679b648598bso1268307d50.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884070; x=1794488870; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0kaq2eX5JhBwGzI8FjgMD7kHw+EoZ1YtEVJNHdDTAco=;
        b=Wqjt+DRid1edpBwCvhFmiBZ1NV+2agKZn5xroDAu0syH6VmrCBKYZ2XlQLzbtyCqXp
         oe+JrU0XaHUM+AQhMb1/MiQZinZAgpoRktE35Y1O4TknNkuZlFoMVNob2whvdOcI99Jm
         LWLCqvBYsE6qQeTmqThaszdoWUlNDjpB/oczUSCWdC+B/YoUG8+zdGXDtJPRz3TC0tdY
         6+1/Mx5emugoCvmyo3h3qD3+DRlH4K5fDMson2m7+hogPqgrIQYqIxrlsSer4idjUQgw
         rdECnMXuFgSLfixkU1Bg6g7x/NtZ8mSAHmErNvABFkJG4EBYJiMxlzlthWpewB02J036
         AyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884070; x=1794488870;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0kaq2eX5JhBwGzI8FjgMD7kHw+EoZ1YtEVJNHdDTAco=;
        b=T2muxkUtG4XtGQ85cQD9lY6OVyTX8UpEj6xx9fWP1/rQCDO55nxfM6U2JwG0BGoKL3
         oZS8C9uj6J2Pp3ArCAhoQRDk0IVHAdPK43QGpZY5mq4oJyL7zMBdiyHNcsBd+ae43GEh
         2BccvnTTRNm7VcxOrlKoJdU+d7b5j3TGahlAyO8bV0v2KoOr5B5kSdBvRGYef2JWve+t
         2aE+nlv9FlvMLd5bBlRkkb1kwdSozk/cAWi7MgImEIWugQ2fzOw4vNpEw+r0HKKyyWvM
         m5XwWK3o5RGB6fs+nvlD4HeTKFsmvo8pal/q6dSevK9IFrpvnoON5MHsrUW1kOfAoq8c
         Oh1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwp4Dm+zGJvEekbxVHMcGiRf91gd2B1dKxX5k1PnIdhs7Ms4cL1Is3M5lbod090OP6MvBvbz0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z85wbRQRcC+kXzl3NZpUsXcn2SVg42HdpHr8pWs89e1pYMEFoBF
	TJSazZBIzKDzkoEGnZK4lmuK0Ou6hzT8oi69/DBo3hG4aBBFyW4LMsufWE7qX5tyzOsshuVN+Y4
	ZeEVB0LT/HKpx7ujpMzC1z9KxY8O3UVnpzMyjZYQEZVQgpP9ZdshHpIjM6iI=
X-Gm-Gg: AYBFou38UKBOi3CjeJMwMEdevcx288LDBJRNGvQ2GsdPc9A+sGECSG4gCjrmPmRh6cE
	KvFJuioEWB7Px/ODoYjjVeP1xTGxLX5JAodzaJQwIjIq5S147RfhM83PRBP3dWbKMP5Zor8sRdi
	NUtUuExdQ5hZC6fiuVkBcqqxLGDUKaujPZlUd8+HcMUBLJKv6UTXgoiizJoblP1xw2GF+d02icy
	T3ML77yqg3Gl11+haovYN2CcT14M6I6YeVdLF3l6xBA0Y1o0nJiQSUAmTcWSAfIDtk3Ca+0tCGp
	5BPotyqIFOV5eN2ijTE25mTqcPPwsDZO9OHQMqRKnf4coqwWOh0dRjEsUNER2A2y+/Ae5HUT0xd
	UJ8WYTKnNc5CIPogoW4FXjmBZY5WMEp2s2VP0bM05R+pkGfkIa4oqutfSOyyx4LQEiXwE+vwYIq
	pRd/E6S8zzuFsIx0sk
X-Received: by 2002:a05:690e:4810:b0:679:cc49:55dc with SMTP id 956f58d0204a3-67ba50d5686mr9599083d50.92.1793884069730;
        Thu, 05 Nov 2026 05:07:49 -0800 (PST)
X-Received: by 2002:a05:690e:4810:b0:679:cc49:55dc with SMTP id 956f58d0204a3-67ba50d5686mr9599060d50.92.1793884069087;
        Thu, 05 Nov 2026 05:07:49 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bb4406sm38915937b3.40.2026.11.05.05.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:07:48 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Subject: [PATCH 0/5] clk: qcom: Add NSS clock controller support for
 IPQ5210 SoC
Date: Thu, 05 Nov 2026 05:07:11 -0800
Message-Id: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAH9/7GoC/yXMQQqDMBBA0avIrA1kQlrEq4hIMxnbKRg1Y0tBv
 HtTu3yL/3dQzsIKbbVD5reozKkA6wrocUt3NhKLwVl3RbTerDRPgyzrxaEdkiqRGdkHR030ERs
 o4ZJ5lM857fq/9RWeTNvvBMfxBaAEMQR2AAAA
X-Change-ID: 20261104-qcom_ipq5210_nsscc-fe4b2c8d4d18
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884066; l=2682;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=FwCPPd43C9+UFSP0VeeVecOu7OTjX3+26VD0c618IqY=;
 b=SCD5tZUyjWGsUIgi3dbLM6Hphh2nWi8p4z9NkYkuElvybRF31+EhpUuN0eDq9i/1HpT9fBEac
 xn0MMm22K2lD6Cir3JolbsuwxGvtY00njX2xbn1QaYW9yk3A1bVZJJc
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX/OU0++xhTBNr
 Lrvvd8DHdbtp9oFZaczpQAdOlil8q4qikzvvRHspILqXSEg7xB26USgNlg1qBG46dDPNE6ErROG
 V6wYAJx36c1BAg/yv/szA28/tSpwuxdeZITedYML2Jc50+Qnz09yqic+lwl2sf720ZwqNWpmBhQ
 eaG3kYhOsuzBSo++RHw+pu6knSdrfq6VUoBWKNz7OWQKAmhvSgoR4rrAQ16TNrNVAApj0E/9viw
 9CcKMchUlFWwwB25lmYxbx+9axbFo+b+SwGS2InVWNLjh2fZyofvlu8WL4m488w3xwtFEOk97oz
 +R3amH/ZCUzzsdzPDRHrDVAD+p2L3CTWfhLR2HCH2opAoSh20HgdwfragND7Mxe5gXL/DzFt6pc
 sFuBsw9FRimpD9mSmre45Qofze49PIJmSI7hViaN040yN1xPpcb4pUncOY2O8wilzmUn1ytQK8P
 AAQvqz285AlhoJhCj2w==
X-Proofpoint-ORIG-GUID: JQrUrgeTL_Dvd6L8QFI70kig1uzuqTJz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfXzQyd4UCmrXzw
 4S1FF/LKrhp7zHqwgkP3CXHfp5b7Vt/9oDqSbIqxq66MM07qsj2Ybp0z72E2PBYCar18TeDpaED
 vnk8CmbrwD6anEYmFWGRDFW7J0bImnY=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec7fa6 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8DxjrM3GApEK5qXUAGkA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: JQrUrgeTL_Dvd6L8QFI70kig1uzuqTJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052

The NSS (Network Subsystem) clock controller on the IPQ5210 SoC provides
clocks and resets to the networking related hardware blocks such as the
Packet Process Engine (PPE), the six ports, XGMAC PTP reference clocks,
PON, EIP crypto engine, and the SoC-integrated EPHY (2.5G Ethernet PHY).
Its parent clocks are sourced from the GCC and CMN PLL blocks.

The NSS NoC clocks are also enabled to use the icc-clk framework, enabling
the creation of interconnect paths for the network subsystem's connections
with these NoCs.

The patch series is organised as follows:

1/5  dt-bindings + clock/reset/interconnect ID headers for IPQ5210 NSSCC
2/5  NSS clock controller driver for IPQ5210
3/5  DTS: add CMN PLL node (carried from the CMN PLL series, see below)
4/5  DTS: switch xo_board to fixed-factor clock (carried from the CMN PLL series)
5/5  DTS: add NSS clock controller node in ipq5210.dtsi

Dependency:
The NSSCC DTS node (patch 5) consumes CMN PLL output clocks, so it depends
on the IPQ5210 CMN PLL DTS node. The CMN PLL bindings and driver have been
merged in v7.4-rc1, but its DTS patches are still under review in:
https://lore.kernel.org/all/20260906-qcom_ipq5210_cmnpll-v4-0-aec5ed642f4f@oss.qualcomm.com/

Patches 3 and 4 are included unchanged from that series (v4 11/12 and
12/12) so this series builds and passes dtbs_check on its own. If the
CMN PLL series lands first, patches 3 and 4 can be dropped. Patches 1-2
(clk) have no dependency and can be applied independently.

---
Luo Jie (5):
      dt-bindings: clock: qcom: Add NSS clock controller for IPQ5210 SoC
      clk: qcom: Add NSS clock controller driver for IPQ5210 SoC
      arm64: dts: qcom: ipq5210: Add CMN PLL device node
      arm64: dts: qcom: Update IPQ5210 xo_board to use fixed factor clock
      arm64: dts: qcom: ipq5210: Add NSS clock controller node

 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |   47 +-
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts        |   22 +-
 arch/arm64/boot/dts/qcom/ipq5210.dtsi              |   67 +-
 drivers/clk/qcom/Kconfig                           |   12 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/nsscc-ipq5210.c                   | 2203 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5210-nsscc.h     |  106 +
 include/dt-bindings/interconnect/qcom,ipq5210.h    |   18 +
 include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |   60 +
 9 files changed, 2531 insertions(+), 5 deletions(-)
---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261104-qcom_ipq5210_nsscc-fe4b2c8d4d18

Best regards,
--  
Luo Jie <jie.luo@oss.qualcomm.com>

