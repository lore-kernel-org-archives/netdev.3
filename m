Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143946;
	b=Qr2m4sotO4jheX0daFr3t1C+8HbUAxFIgTsGqW20I8k9eQVh4wTvDfSTtuQK3P4MFMYk
	 OE1wniU9Vb1HOxZ936AHzxSnjT2S9pfFn1hGz6UF/kPKO6bG1OBUtn++boi2Y4gAznpX3
	 sTSa6l5lj0eZMO6TyOEaOQDI4vr5JbssdBuSg4NqdlKkD88bAinUKX3dBD31nSy9jygOQ
	 BQ3K8vOM6vzaF4SOdIVmlaoXEkSVmRcZryoL24qCkxEJdHfv6cl0L6lBNj1zODqNrjxXR
	 UPrY6zJW2l7BifSYfW3+srzJDlrJv7O2Peu7YdqzCb5MBTJdO5COwNdjkIg+dp2w14A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fkCARdSce3zQQOopd1LbuUPfMjM4xn/vBfRm72WuLrg=;
	b=HEU1VcNvDaErLgv31aJHK62DmyPNIfJX7XpAYdjz7t9GoNCkhiGdJ2/K+wYJhCnjLY90
	 w7g0T1DL975IvMen+tPxARJmumOUTG2AEa9QEoTAmcTTGUFmzXrXf1Vd7f3QtTwMx0hUf
	 jItNFp/8UJW7CAxxkCV3xfVhYSp59SjeTT2YpRNCHqrRAZI5ynFD5Xkru4kUqas7ukOyS
	 OMbD964d9O9w7JQTpvVlPHnK74zTUyb/BiWBkcwRG89RELMqV1QykPcZwZB5A1m6UONC2
	 G+qz0pH657sRmNMYBUssEYVTkhfq/E6ThgiAiVk+3V+6SGZU9UuByWWp69Nn5shDUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NmmGnEW0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B9uL2K1f;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF33606A333
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF33606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NmmGnEW0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B9uL2K1f
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8BtoQK430555
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fkCARdSce3zQQOopd1LbuUPfMjM4xn/vBfRm72WuLrg=; b=NmmGnEW04tWw0qBI
	EJsLz5EFuuhZ3VpfFMGJEy2Fh+TEpjk5Shk6VAZoxSVrcyoNbkamFkwYKcYHIIvj
	YAXXqjAMZKr1L36YT7G4fcA6ZpdyefMzqLSLngEQqQptzeNjhJ8IPMspATXiiJDv
	hP2CxEprfTMBTpWDH9foSVmuHpPHVc7nJx0wpKra3E8Kkg8w84KYGqWk7suOiOup
	wg8bR2yB+e1QWA9N/99MltZnMIJf+hpL3oNKZaCJKuLMsbNR+AZwlFlTJUmQnBuQ
	qA9r4GwgYKw5LYYxAqkpX6oEVzJg/H2G5NibaCbZDVLGTADhN3G9uaUpY+gJsKv1
	9DJLcg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99jsvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:19:05 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a71dd190b0so376972c88.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143944; x=1794748744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkCARdSce3zQQOopd1LbuUPfMjM4xn/vBfRm72WuLrg=;
        b=B9uL2K1fBoCxgmDlUamaLqDFYw18B8AP3wmJp1FNBP90gJ4gYkyg+DEylmf2ufgbXJ
         83PEMvJNY80pqtdbipvJPvlM8ewfldop3OdqgQwV20Py5r5qZg/wtpjqa/rVZ7cNvTpL
         CdsiHqltF4K1ODvF2Y6+gpy4UoSRuOe9wXJOJeZ2GVjNBWb95XEtheU5FI4U6Mbc4H9P
         rWCWSWCwifme6IprubbWsi85OCfadnyHIkywJs3dgd4dWhBqdv32UqwLzvSJS+oVF3lY
         KWKMr72mrJr3V48pYJ9kqZsH1X9JwJBAxVwRKqpFRHHA6LiUXUHeq2Jq0BisTJRl2+4u
         sJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143944; x=1794748744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkCARdSce3zQQOopd1LbuUPfMjM4xn/vBfRm72WuLrg=;
        b=jm1XNXBdqMym+zcd16Tch6zbs3bzKKukwjpOmoVQ/fHVsmpBP/zN9zKDFEN6/IvbXV
         a0WqwK4Pam/esn56fSHxRDXEz2HOrVDFxoLp+ixlHnJwZfdDhgrfqXBvCuEqkEX7KqsL
         SXHUGgaBaxtY4aqtXELyl9Q5AJXiHy5+B1p9DxTZjPG7GoIwFyVa3YWmYu9r6lUCy5Q8
         GOlk31cR/xBoHaM+M0ltMivjS5iGxCgGnSU9A0vywY5YPgGE97nfN6C+vrQjFn8jUvTK
         kBaHE+VAuUUgEC7VY8GV8fuDDN9t8WUCEPLhe1148UPWLVV3YfAO6KKCSSKkGqXxnI1Z
         7ZOg==
X-Forwarded-Encrypted: i=1; AL+hErE9IMxF+slAR3Go+4qErme/wEIE8xiGkP7ouapw32Lf7mmcAyk5n5IsLJ343Sh+uhtDTDASGBE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+idw61/mLjdgz2FjrU3pm/qwsEA2LNCI/UtQmnCkG95ZPkG3OQ
	7snlqV8MT+oxYjXprc9ddwuftxv7bsDVaw8WlKPAvgboghITBDeL9NPT+Uvx1pqutPv2fC2z1TH
	TOQPc1OnMJ5EsXq8R4jdpDzwvACxnH9SowpasoNYFP2UfoBAEOuhTMUGPgbU=
X-Gm-Gg: AYBFou2FIkb0/EESPfV+CX3jmea4Aq0v5uqk99NSk9S6goMd3k+VfM/D4xIazTpssxr
	a40J27UFyhzQa927RUkNb6xPar0iL5Ys9YHPQTuePYWhRVGBQE03B3xvV+bAVBwJGhXKKhdyMyp
	w+DjFg7ssxJlAAzLE67al/iFKUXr3YSEHj9IC+ri7gw5Kqwkk+S1keMbKY5zFH7iJAjE4ot301a
	j6N2rfZi9sgCIBFe3r4OEDkrczKTNayTKXaJ1+V8/xfp+wuxkTQIc44M6x1vc+UBs4cKXmy0XdW
	PvBXPOVXBNQQnBi/nJNsFPDmLUL6+WMAfx7GmdWz/8u5o1P7Xo/znzoXd5o6TOqzTDtM8lVXQo1
	ivpSWIcgv1yudMxyQkO6HaPH+b0OD260Ehnhl20D1gCYUTE+aKMGsmBc1K5se3gCcy0Zyaenet4
	GTB+c=
X-Received: by 2002:a05:701b:2802:b0:1b2:6d5b:36bc with SMTP id a92af1059eb24-1b39feadb75mr2038246c88.23.1794143944471;
        Sun, 08 Nov 2026 05:19:04 -0800 (PST)
X-Received: by 2002:a05:701b:2802:b0:1b2:6d5b:36bc with SMTP id a92af1059eb24-1b39feadb75mr2038232c88.23.1794143943894;
        Sun, 08 Nov 2026 05:19:03 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:19:03 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 18:48:26 +0530
Subject: [PATCH v2 05/10] arm64: defconfig: Enable Qualcomm TSC driver
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
Message-Id: <20261108-tscss-v2-5-d5f575010427@oss.qualcomm.com>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
In-Reply-To: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: RxHNe4aO4AV4nAYJp6f5x9z4ieR3TaHS
X-Proofpoint-GUID: RxHNe4aO4AV4nAYJp6f5x9z4ieR3TaHS
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af076c9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwNPhHur-d9dQeroUnUA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfXyZii1q1zWH8A
 TIUixBBcXq6fIenvwQ02fYmeWo5MKAH3ZyvkWDS71JQ9AMmKb0XSMAo+2ySIL4fww6bIT8yipr3
 /B8VEaWYfENOgv/b213XRL8XiPlHs4jAjCBvLotXoHr+sXwtChiOFE7i9+WtGDOfedfyNKchQvX
 GaCGvWvDxZd/K5mKG3an2fyxjHfJfeVYNQobgGRhJNFrwKUURGAbZlNWxA2onAI9pUuOvzhWHCE
 LcljNWLTHvWLuURda0egpgO9aOaKkyYv2CHHmSAIK3duk8z6GNBeTLKIaG0i2onej2iImEdTZrY
 6o2yUjZnpt5MDtwz2WdpcbF2inw+xqWfFZI5OIPMRMId82rv+8qvG+xFJ3CA+VaaaNgYe1aeDVc
 5zzF58UClJJsEYav54vH9yJXLvs5DOBXtinx9I381uKxAOnIO0+sfEytS8wKlpKr5H6smexuSTO
 SqMp685bp/1ha9Dz2NQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfXzPqhwkoCkvM5
 rQsD5nOvaY1U+cYnqeXnvAKqao5OjWWVIsP82gsG4YF5Fmz7wAujs7ne+e4hdJtp8XP7ml6Aihv
 6Wp3ov7i5nzJuv8Dfb6+zrtwNdJYiTk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080052

Enable PTP_QCOM_TSC as a module to support the Timestamp Counter (TSC)
synchronization functionality on Qualcomm Lemans, Monaco and QDU1000
platforms.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21..9af55787b236 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -689,6 +689,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_SPMI_APPLE=m
 CONFIG_SPMI_MTK_PMIF=m
+CONFIG_PTP_QCOM_TSC=m
 CONFIG_PINCTRL_APPLE_GPIO=m
 CONFIG_PINCTRL_DA9062=m
 CONFIG_PINCTRL_MAX77620=y

-- 
2.34.1

