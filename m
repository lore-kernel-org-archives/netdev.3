Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014241;
	b=dexe36tg6C9IREYNQai7AxrqMTTXmbD9hqZKu5U4f6YN4cVub+Dzv1nPA8nwq9CDgAge
	 LwaojtEQHsgblGrT0ml7SV/UyGIIUZkWCb3aUqWraagow5RDVG+7DHxL2kR43w9G1UMiw
	 LvAKZS0FnY4MOh0cg2DfhnzCE8tQ4spSKrdXLpJJngOnkrWELxpVre731LKm8fT1n/HXe
	 Ht+xBNxijun1epZ55X4G8aDiNbo9HazPCV7cysivbvFNO73XGuiHYeFiZEyD+q2wATOuI
	 yx9Xad3IcL3Kd2xH6nXaI3Ns7tINOFlovEm3q/nn0d4oq0XkFQg3qZSqQg4d2hpqkDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014241;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=58lza+N58sloZR6E1LzFnfVustAf491GwYyn9ZqoTSk=;
	b=Cq5pjvrIsSXlxTir3q9G0rCPv0O5a3sUvikHfb4450mu/H7cquD4dI8DY1/8pf7MRHlB
	 BmBHlgE5TCSY7h9DIlMrNMbfKAsZMxS+36wxX87KPVcGC+F8GtPlzudscylr2ATKjaCNP
	 TJ01fL+N1FPemgZF/JW/JBbG30L6S6cQpu84egM04rZ81kf6hlOaWPqULl77OZQPNtzZq
	 uyBW3xtf5rWggwNGNrZCr3cWam4ubW2a6MaCo1nUBekD50RDwZ+dWCaLUoLJDxJ7nrORu
	 zM/avnWM6XUOBaAdZMoItlp27MFsu/6wYVTWR+m52JK0EVXO1Ozh97YWdy1W2lSphiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBVrqT7D;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U1Okux83;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89960A261F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C89960A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBVrqT7D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U1Okux83
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtItC3085620
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	58lza+N58sloZR6E1LzFnfVustAf491GwYyn9ZqoTSk=; b=kBVrqT7Do5kCKYQp
	Xr+mV8eG5A3PRn+t4jCykyOpI0aLy4kRLbT0eqYs5BGCTiFp0xi3RPAbywuU16Ec
	2GnRgzxKf2FQmmuMnzcza3axbUK9txw3KndVGyWSmvpoZ/eieS3gVwNhMeMTHlsx
	QiuJB7g2a8wqCqxuIiaKb+eclt7TDVPZYpEwkJv9CqrxNAzLh15CtS+X1kFcWmjt
	F1wlTRFtS0TQ/ejC14KuhLzbQNBnhaC0nBKuXBANScduph/+ABnNR8+2IOfBWJCQ
	A4Cosar1pPM5lxpHB78mEY9dHyg+/VN4ISyIyYZBd0aV+9T429kVr349GayZhym6
	LzHW2g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3p4ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd8b7226694so1305575a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014239; x=1793619039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58lza+N58sloZR6E1LzFnfVustAf491GwYyn9ZqoTSk=;
        b=U1Okux830LFf1hdHdIHVNty2/Z3B2F7hxKRv4jEbOJl8ePkAjiwpS6156Yib9PnHl8
         b/f2OwSW1Znkz+IJIgSpjsv+g/ChwW7n1zrMdAo6m2MlDkmPvAUfH48M9+SGD7AGW4rY
         TT4zVCPDshY1mmW1fo2C7IC1ebCc9oEGV/JfUZSg+t/s7bgIK/2f8VgDMQd2Q7CWVXGR
         3ed27hmUaGkwvVJqK0anOTg/1wRrlJf2I46zPMbe/R4qkLZz5v1IbcARRkpouFS07R0o
         TVrGgmWfkvk1ufkNPmf7bSLiLs9J+e7ceG0UsW7c2P3iZW8eUEIJKKV5jofZFPcr8AAn
         UhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014239; x=1793619039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58lza+N58sloZR6E1LzFnfVustAf491GwYyn9ZqoTSk=;
        b=BZBX6aOnTrMiybj5y2CXOkQMDtCh1QOeQK8uihjLgV+dV+tR11l4K160zaL20lmqJf
         /G6anXaL2qDBFeVWTpE3mZQLqKKjjhQ8ctH57+PhhXFz4b5w9LtER/wecHHw4NVh9GOp
         1tV6ZW4K1HJDu0Oya70Jb71Y0NHRa3/T2AKDTrBu57dlLBn301Ll4OBBJqDcE2ekNc0g
         FIDt3ZoEt3AzAYsQYC+dWFXEx/AAw/U28WMf+ps6mhGNZEmZI7rGQU8wj+7+17hgdSFI
         gW0gLJ+CBCw7CbTYMMDFOLY7AptEy+y7kQQ/7tmBpgqHBVOfIXBYluOIg4j6+Dlas5Kh
         GJzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwccSjty4wfpm3ubue53PqnI4A6mlK+vmhaY/HG9suNd283qJ0ZN2Ku3eQYAEY1X7HxjJ9KEj8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQFsQWJmdJ1PdYIuX2qapLrmFfbiFPUyvxUjLXQJ4Sikwg+Slb
	Cr6Z7EvmqtZf3pe/BeJa3FXIsKd1h5i5Ptf6bvrsaxMSEoTlut7HkQ8LKElZtHLcsdGnhgfCZoK
	M5FM4GkJIad1PNE7CjTGAwv0Ya4m4yffR1XQUIYxEKCBaJRvtxcwJd2gdEeE=
X-Gm-Gg: AYBFou1Ff58hx2iEo6a5fdpwzcHO7oP/19iyMH/qkVJ04NkewUtJ9Bckfy+lasLjwn6
	XX65jAXpfXqrNvHWgu23GZ6oIm7cKSZAbdQ4xkBDnAOeGM0Eoz2xDDPc9FgLfkgtvMeFbKKd5cZ
	E8I0aqTV4cYpsg2ARZYQUGdStQPFBjDjYS2cuh9Vta6mCYlQixUwfizaIhkNRXJO2v6NYniJwBc
	4sz/YLG3yFjuT+ctKliMEtLLmvyVIRWD8yw4nzrBDYuz1xU9dHwiIriVZrBTIVYdaWKyJsl1mdE
	QD0ytbd4j7KHDQJlB09/mzy92O2np2TSfzk2hqU+N9oeRDOFv9eKAuQDYGnZtYFbTlDElBpmug4
	38TwxOIof64D4z8hvoW/NC4Y=
X-Received: by 2002:a17:90b:528a:b0:3a7:da33:ff2d with SMTP id 98e67ed59e1d1-3adead62207mr4970112a91.48.1793014239285;
        Mon, 26 Oct 2026 04:30:39 -0700 (PDT)
X-Received: by 2002:a17:90b:528a:b0:3a7:da33:ff2d with SMTP id 98e67ed59e1d1-3adead62207mr4970084a91.48.1793014238806;
        Mon, 26 Oct 2026 04:30:38 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:30:38 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:33 +0530
Subject: [PATCH v2 07/12] pinctrl: qcom: sc7280: Add gp_mn mux function
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-7-ff8e4bc8d567@oss.qualcomm.com>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: 7hVSz_pMM07DdDN8WWnjDQDZr7edcuaA
X-Proofpoint-ORIG-GUID: 7hVSz_pMM07DdDN8WWnjDQDZr7edcuaA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX76mqHYWHaoZc
 mnTH04GbiQey54SGCs7tqrHafKQCIkiLc1pSta0NfC1352pfWUW5ynuZmq+dfmcQNFh8k86tJrr
 sH1TypVhGVPTiZu1Xqq/xncMeFu2RrU=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adf39df cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=kPUZkI3t5WzYvoQfP0wA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX64ZN+VOiAo9K
 Qg9KNxjai9hm2MsQl8V+VRRqtqteT3ERmkOPlF7KHQWt2nhPKBGGk6J/BJbXzlkiZMDSy2ZaOQs
 iHb33l+EvUpKNZAOT7i+aV+V6hdXoxOXWIPZNi4SSPwE3TsITaGxRBND8jTYBigeJ6GB+oOhFQK
 XI+WM9RhJkP2M8O0XmXNzCyZGdm+wfJoeklMtDdWN5g1XAz9O4ebppE7biR+vVJfBUSbrt/DBEX
 s9u2AsGg7nCP+N2EflBMSNwskVJiZw1bgVjn9m968qhy0Ix5ntaFO7tA9r6xHO8Yd7qc11rI1IJ
 tUGODCUx3mT2zxOcPFFdWww0ruhKhjvNJiwnUmEuiy+CU3O0ElGt2YOH02B1T99NWsLvhT2C85z
 md3L2HeXL2nOyKWuSgJ8eoyI1AFk5ke3zuWiWLnw/CRqAC/xmGomrrZTDPcpAz1jCG6F+nch2df
 DAfHw6q3GVIy6xQsURA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add the gp_mn pin mux function on gpio60 of SC7280. This exposes the
GP M/N divider clock output on the dedicated GPIO pin.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-sc7280.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280.c b/drivers/pinctrl/qcom/pinctrl-sc7280.c
index bb32a56649df6faf1aecd470435d74558c20db27..5e210b399f88f5beb68e511bca9c0dd93a1b75dc 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280.c
@@ -515,6 +515,7 @@ enum sc7280_functions {
 	msm_mux_gcc_gp1,
 	msm_mux_gcc_gp2,
 	msm_mux_gcc_gp3,
+	msm_mux_gp_mn,
 	msm_mux_gpio,
 	msm_mux_host2wlan_sol,
 	msm_mux_ibi_i3c,
@@ -788,6 +789,10 @@ static const char * const gcc_gp2_groups[] = {
 static const char * const gcc_gp3_groups[] = {
 	"gpio78", "gpio107",
 };
+
+static const char *const gp_mn_groups[] = {
+	"gpio60",
+};
 static const char * const host2wlan_sol_groups[] = {
 	"gpio26",
 };
@@ -1154,6 +1159,7 @@ static const struct pinfunction sc7280_functions[] = {
 	MSM_PIN_FUNCTION(gcc_gp1),
 	MSM_PIN_FUNCTION(gcc_gp2),
 	MSM_PIN_FUNCTION(gcc_gp3),
+	MSM_PIN_FUNCTION(gp_mn),
 	MSM_GPIO_PIN_FUNCTION(gpio),
 	MSM_PIN_FUNCTION(host2wlan_sol),
 	MSM_PIN_FUNCTION(ibi_i3c),
@@ -1325,7 +1331,7 @@ static const struct msm_pingroup sc7280_groups[] = {
 	[57] = PINGROUP(57, qup16, ddr_bist, phase_flag, _, _, _, _, _, _),
 	[58] = PINGROUP(58, qup16, ddr_bist, phase_flag, qdss, _, _, _, _, _),
 	[59] = PINGROUP(59, qup16, ddr_bist, phase_flag, qdss, _, _, _, _, _),
-	[60] = PINGROUP(60, qup17, edp_hot, _, phase_flag, _, _, _, _, _),
+	[60] = PINGROUP(60, qup17, edp_hot, gp_mn, phase_flag, _, _, _, _, _),
 	[61] = PINGROUP(61, qup17, sd_write, phase_flag, tsense_pwm1, tsense_pwm2, _, _, _, _),
 	[62] = PINGROUP(62, qup17, qup16, phase_flag, _, _, _, _, _, _),
 	[63] = PINGROUP(63, qup17, qup16, phase_flag, _, _, _, _, _, _),

-- 
2.34.1

