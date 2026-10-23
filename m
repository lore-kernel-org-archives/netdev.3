Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746175;
	b=ZqhB4tsJtmMtr0PvQu5vswNEufSu+krgGC3E0vYCkqOab0Msb/NeI4C7cBPpYuaYw+4F
	 liWqgQmNzh0yL5saMXmfUGN6uiSH8BkDP9cx9kHgxDDIj5A/XfaW++CxqBPHzRiUCFxBZ
	 6dRZEYlOZ3G0z5x4c2NZjyVLVtsW4sZtMoMMEMZn6oHKjqAfpS7VsihD2BAd6gVu/iL7q
	 ZXAo3WcXHBInhtuWplCiiMRv5CRdZUM1BoJqLvxBdXoURl866aA/MyLcZ+E5UB/Hdu+w9
	 4NkXKBlXdAzWLq9tn9VL+PazxBYuFSwZSo/yJncpn0HMX+bYTMi5jxPFl2M2V3qQ5CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cYYMNDlDg+Fz3QZ1LcfnI+mFxsAjoUWk2Dj9tVMozDE=;
	b=Ifx2eQ91T7Q25d5ScNeHvYTOORLYtfYshMZXMBrZ20qR6GysWOFahv4XMcO8BLwzPQfS
	 f4IJLoV+pP0QxfTGLWJi8LdNg+pggk6FRVnwxfjN7ZSh0cvefBLfFbmBw3xFl/mVUAOWl
	 436pda/0Lb15IneCLzfwKwqQcR0y5eipEMCXTN2/WCMWu509L4VtuQmlS/oMXKF+ld9JD
	 T0lDW1W9W5y0kDqlB1wp0FVk3eELHLMSrnpGu077jUY04O0Q6AeVl+LFHPILTRTYdr+tx
	 lPe70OBWSyjjQ5Yscxx+2NrtolrMt7sfSKBBDEnckF3LXglW6xEc5JEVGxiLP1dLKFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OaiqGzmQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cGP8i1ni;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9306606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9306606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OaiqGzmQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cGP8i1ni
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F75m3153902
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cYYMNDlDg+Fz3QZ1LcfnI+mFxsAjoUWk2Dj9tVMozDE=; b=OaiqGzmQ+0jAiXs5
	RqeBVhafy44Ra/2HPtMN1nNzDuNV2JCaOzjCtKbPiqDtoRB+ntIk343NJKU/ne8Z
	UF3ECisAG1khTTwhpZ/C+514QWd9IkJSFICVVFYjkC7cNqIiPX9EDYdN3yFKQfGh
	UW74XVhZ4MJdBsQwn67bSD2zbdc+zbGBYHvxbscIXiojeSwXIaJcRvENxqgQG/ov
	vpAqMmyCXqEOXjLpXPmdckuGFCsAnXO23mJwjYSk+N2NReDIxuig+/tzDc3RRIUb
	j17kA1JJb925H2/CRCUF0uNA+EAj8OmxSTQLcmlj8EcsZW1QMM5tretlVdK76M0I
	Mk8FDg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmraukj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so147929985a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746159; x=1793350959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYYMNDlDg+Fz3QZ1LcfnI+mFxsAjoUWk2Dj9tVMozDE=;
        b=cGP8i1niyuBO19mfEWlUp7dKdRmBWiAFudJY/KscmlWAUc2ExK5dcCNo1C2/9tGW3I
         1Qt9MQGdrFHzGAoC8cWaAtuhUnpod+Z/VgJexehJyuTuoVRJ439SNtENAcoE3r/o94fd
         vmyrnDNBrwPHGA2m/bdreWBfGgD77vJbnXvR9wr+AS+nveNrwaDTMO13mnVIXG1f88P2
         I9koMojZ4gjF3N6l8ecW5xVA53Uw3ongCiXTm1QF+9xOzBuRtDBKMBzHQYS6otpapasc
         w1JcXdGN3uRMkIyb9luyFUJgcfY4c5QpmM2ACdcPkJ+uq6DLmuGVX94LWRtW8afCgJWi
         IMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746159; x=1793350959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYYMNDlDg+Fz3QZ1LcfnI+mFxsAjoUWk2Dj9tVMozDE=;
        b=dhf8fVmm1XDOHyeS5j0D3I9coPDrMIs4JkEiHEPq/oz9FYOMFg0Zlg1MMoPqXxTd72
         Pyg74GiGP8J4Ec+wxlJtppt4OOhM4qHYKEGwjAWE1jhpKGFThBXBq0guoSc+y/D8LMKV
         eMlahTzS6rFNyV1VGIxIr68rlsyqXh1GhbaM4k/OP9RChu4euZLPoWvAFwgNa3TRY0HX
         kzqm+kPsUb26K2AY2wlzWd7GZklUufDt29HINYwMn8NqjeH7R23fxr7H174nuKcj04X3
         j35Zoz0o6EgiI197c3+lpuIG5/EOh6IBU65jPu0qzenRu2nxa3K/mU63dzqlXID0BPAh
         fJKw==
X-Forwarded-Encrypted: i=1; AKwUvBw018J9o0aLBh7cJJKchU8MnTrqGo17JxyK1cB3ZquZ6AH0xDMOxWcEotbmhQ8yQgPI/HymLZo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/XdgB82rw8RIr4ULUn5OGXmJ3120KEXbq6EQL4dDUq2NeQIzz
	Pg20aOxW7ePTTItAdk9yHhEJKp6KFuW04toNsnwBusWPGLn7FP9tvLBsDidhul5IwF1OXLzcxy6
	CeNod3YyN9rcHeWDMPPUkDqnwcNO1Jer4Y4PtpJ+x8P130F88KFfFsghO7YY=
X-Gm-Gg: AYBFou0VdRQ97T8iS2arp+lhOxvMLBVAW1MMpzTP1uhaabGLLlNQRut5tOG9YT5z+Qi
	8X2M+Auac9xJYkS5d6jJKIoLvgdjzoDyrDcJ8FFCLlv5tMTZ4sC63px8HDTHU0cY3GlriFB7Iyq
	ahFfSPYq+IQYKAIGl0qv2a6oovpOU76fXAXf7V2X8GZ0EYW1m6+094ryC0JaMB+Y8UyNAsTVpsM
	1jsv89my2BO02CqFPkFXZ/CGloWAJVX2oGc4yIaOAdEcp55DncF+IMZMX6ItUwtnn/haVxjPFJS
	bTPg6ztJhrJHDIW0JgjRIxHuj4+N3ftVDIn4kn6q6mD9fqfDlWuAPtb6f4prlaKEwbkdKkfkQ5F
	oZbvuEuz6qrlXUxnNsNfpQA9PFzqL
X-Received: by 2002:a05:620a:1a0c:b0:93c:89a0:bf82 with SMTP id af79cd13be357-93f6f796dafmr309360185a.43.1792746158714;
        Fri, 23 Oct 2026 02:02:38 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0c:b0:93c:89a0:bf82 with SMTP id af79cd13be357-93f6f796dafmr309354985a.43.1792746158132;
        Fri, 23 Oct 2026 02:02:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a215437d4asm23076245e9.3.2026.10.23.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:02:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 11:02:24 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: lemans-sa8255p: add ethernet nodes
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
Message-Id: <20261023-sa8255p-emac-dts-v1-3-a34d778ce9ac@oss.qualcomm.com>
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
In-Reply-To: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6781;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=777rO2fg3kwhzi5ZahF5WsYMYfIWw/p0ISPkHmagl3A=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2yKm5xoMVWgIFDWv+HR+baScVfhyZYFPXTRDE
 OBDxp3mvomJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatsipgAKCRAFnS7L/zaE
 w9atEACJ1W28mDMvQs8ArmQHlVOxvHnO2LQfrEn6TtV7ktRJsABcX0UKy0Vf3FJvOjPWGFmaSdO
 htkM4NrF7y1GpwIFYetD/ySjdEl6QTEzQIemk3Ct9B9U/mMWhH1XWWd8XjXf+A/pN1IG7vchCEL
 79G5piTiC0JgpFOTsGsM9UxSKqKB0U8gASZCEexFJvfe4kba2Nk6wd8neHgPx+joXqp1sd2lk5o
 8zKqxknWjJtDKunJJlie2a006pBySMmjZYcpqqT7W9/NkcYU6tneZZT8RP3Ki3dMo1jhROXzCrv
 6D6X4IDnZvXGqJ4BzpdMKNcJ8W6vDlg/eQCzdPFHa91AiBUovQ9sDXEvT9dMRJeev42vtEV86wb
 0oYRGW+La3SKr6DrCml1oukN5fw0WBntXrOUYh/UkemyZ0d7Zz+JYSKPYS2bL/8ZFV107RRnIlZ
 K29clMro2TEr6pva2kpVTLNr1cBIZ7oBrMBEpDCXhnFdUKjtISlvaTpk+q2sM0qSz9+KuNqCzui
 pp4ckSK5M9IJdxe5kJ6vSpj1bsSTnxYwKLJ7SDc28+HQ0siSlVyjWhaZsUPQRgaokZxUj5H5EIM
 /HEgnMv97OWbv0GmM5w40KrVLNuEUvjq0YA+OQnMUnXTw86hMy8w3YY8YlS77mbdiAhVuEUI3+F
 eG716X8uqltC7Lw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Z98qKHX8BhcQO_lcuQNfvd-UyML45vw0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX2GjAcbMWDvEw
 erYC29tpKzaOeDrWIP2YTYplVnCcDVOm2HajhurJ0ChkIvA+YWHUq9kKadHgNbHC8UtAUuH/qCz
 FD23fEKpTiRr3yTfO4gJ2cy0pPmrszk=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb22af cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rwyBkAqmBo9_f1Gw9VQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX/QfVfGekeakj
 t/yDW/z8C0bPSW2njThJciTgvfNN7Y6WJt9oI6j/8xwItU2lIKXSDlA8MKezJyntqVSEsI8hIzo
 KcKgkYf1WVu/VlkcyoNdoIihxEpC6UJDoxca4gao2j+GTCYAJ0aobctkXMWLaAGMgKarHSAMUXl
 u8eUxpPRIJ3A8RowFc8qFgWXnqTa1IbpEVNvJW9f2Z3J80PcaJNYCeiImEweZILppzV5Qgjlpz4
 E/eok/Qd2xr2ZsuslUk35EvtaO9AOQIHKlHxSd9HCGaL3Fw8dPwYUBNL7fVbDYozKP4K2R0rf03
 e8wBkL+72DeSSq9C9h1iknAfrS6vRMXimv84YwRHGz3cIbge8GLq6J/gCdV4PHrQYPyCJfNeNXt
 HPbyEe0ontwhD/CweryMFxbA+lSfI2R0CCW/sQ7+ZwsZt82e1GMdkjal/7mo47ZYGW18wIbDYzV
 qtmctVOmAD/q/o53u+A==
X-Proofpoint-ORIG-GUID: Z98qKHX8BhcQO_lcuQNfvd-UyML45vw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

Add the ethernet nodes along with their serdes PHY nodes for the gearvm
variant of the lemans ride board. Enable scmi7 and scmi8 to serve the
EMACs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi      |  28 +++
 arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts | 213 +++++++++++++++++++++++
 2 files changed, 241 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
index 4c155cbc79754af632848cd55b738e3ef0511cb5..c64cfd279af458e24fb48083ae549c96cfc07485 100644
--- a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
@@ -58,6 +58,14 @@ &cpufreq_hw {
 	clock-names = "xo", "alternate";
 };
 
+&ethernet1 {
+	compatible = "qcom,sa8255p-ethqos";
+};
+
+&ethernet0 {
+	compatible = "qcom,sa8255p-ethqos";
+};
+
 &firmware {
 	scm {
 		memory-region = <&tz_ffi_mem>;
@@ -3226,6 +3234,26 @@ cma: linux,cma {
 	};
 };
 
+&soc {
+	serdes0: phy@8901000 {
+		compatible = "qcom,sa8255p-dwmac-sgmii-phy";
+		reg = <0x0 0x08901000 0x0 0xe10>;
+		#phy-cells = <0>;
+		power-domains = <&scmi7_dvfs 0>;
+		power-domain-names = "serdes";
+		status = "disabled";
+	};
+
+	serdes1: phy@8902000 {
+		compatible = "qcom,sa8255p-dwmac-sgmii-phy";
+		reg = <0x0 0x08902000 0x0 0xe10>;
+		#phy-cells = <0>;
+		power-domains = <&scmi8_dvfs 0>;
+		power-domain-names = "serdes";
+		status = "disabled";
+	};
+};
+
 &ufs_mem_hc {
 	compatible = "qcom,sa8255p-ufshc";
 	power-domains = <&scmi3_pd 0>;
diff --git a/arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts b/arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts
index 4273f47c3dffc4244ba7fd7cf10b06054c8c8001..99d014ffd07701ffde255df01a67cf808cff213e 100644
--- a/arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts
@@ -14,6 +14,8 @@ / {
 	compatible = "qcom,sa8255p-ride", "qcom,sa8255p";
 
 	aliases {
+		ethernet0 = &ethernet0;
+		ethernet1 = &ethernet1;
 		serial0 = &uart10;
 		serial1 = &uart4;
 	};
@@ -101,6 +103,185 @@ trip1 {
 	};
 };
 
+&ethernet0 {
+	phy-handle = <&sgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+	snps,ps-speed = <2500>;
+
+	power-domains = <&scmi7_pd 0>, <&scmi7_pd 1>;
+	power-domain-names = "core", "mdio";
+
+	phys = <&serdes0>;
+	phy-names = "serdes";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sgmii_phy0: phy@8 {
+			compatible = "ethernet-phy-id31c3.1c33";
+			reg = <0x8>;
+			device_type = "ethernet-phy";
+			resets = <&scmi7_rst 0>;
+			reset-names = "phy";
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+
+		sgmii_phy1: phy@0 {
+			compatible = "ethernet-phy-id31c3.1c33";
+			reg = <0x0>;
+			device_type = "ethernet-phy";
+			resets = <&scmi8_rst 0>;
+			reset-names = "phy";
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
+&ethernet1 {
+	phy-mode = "2500base-x";
+	phy-handle = <&sgmii_phy1>;
+
+	snps,mtl-rx-config = <&mtl_rx_setup1>;
+	snps,mtl-tx-config = <&mtl_tx_setup1>;
+	snps,ps-speed = <2500>;
+
+	power-domains = <&scmi8_pd 0>, <&scmi8_pd 1>;
+	power-domain-names = "core", "mdio";
+
+	phys = <&serdes1>;
+	phy-names = "serdes";
+
+	status = "okay";
+
+	mtl_rx_setup1: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup1: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &gpll0_board_clk {
 	clock-frequency = <300000000>;
 };
@@ -145,6 +326,14 @@ &scmi6 {
 	status = "okay";
 };
 
+&scmi7 {
+	status = "okay";
+};
+
+&scmi8 {
+	status = "okay";
+};
+
 &scmi11 {
 	status = "okay";
 };
@@ -170,6 +359,22 @@ &uart10 {
 };
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_ep_clkreq_default: pcie0-ep-clkreq-default-state {
 		pins = "gpio1";
 		function = "pcie0_clkreq";
@@ -213,6 +418,14 @@ pcie1_ep_wake_default: pcie1-ep-wake-default-state {
 	};
 };
 
+&serdes0 {
+	status = "okay";
+};
+
+&serdes1 {
+	status = "okay";
+};
+
 &ufs_mem_hc {
 	status = "okay";
 };

-- 
2.47.3

