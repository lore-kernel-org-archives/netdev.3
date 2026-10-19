Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973454DA9B6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405684; cv=none; b=p1xoxuZh/y+ppUGqj5/JSfmtWxRlM7xbo4jBjgiLNLJY/2lCfL0shjPV0QV29pHN81GxjnZFixM0DIxpIkcYR2gm4qtRnIDsKPUBKBsSFpaxg3XLyT61tWyZAFmMU0UJXYD1mkkTI2LbajYM5MqpTP1iokLFR6SCLNGstXv+iOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405684; c=relaxed/simple;
	bh=kh9tVQY45GrFiUF1ke5Gy15WoD3EZQssJNTVFnwj+Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFd67FtfgX20rn5u1AEK/qQOa7zZkRirM6uF5WlWxwPEh6EQYSwM1DWI4j6UbanYdO3mY2TSsYAd34ZdYxMitO70Z1XQApt4ppvtB2ZCM2fOTzX3t9Qs9SHRGv/dqfpW8i1hgkpZT/tlCkZIxN+6qwuU7c1BPFjuCQTNFUXzRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JnDWjQ4k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GLQkhLtv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JnDWjQ4k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GLQkhLtv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OvAf1168064
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wq6D0np2UJn8vl+gR/Dp8dr5QQvgLmXdT6JzLOTCLAk=; b=JnDWjQ4kO6XUsV/v
	5kM1gqbSRdE+yDtqxpwEk5PDtcGB87T7XauBrx5qwzkB74yNaAZGtBPgWu46gaBL
	yrX9dN+EVXy2UxDFzwCmnF3BDFXaPtk1amqrbtmgAYyPvSiAQW3Ub1Jr+jXcYHzO
	Z1QAZLp/fVbMvXw4xASG98RoQ54x7QwrhZakug22CD6RHsWSESrBbwZY943E27PL
	gUno98tIJtj3x2HMM5Gl3oSmara2n3xMsPMt+vJ03LH7b8qtYfkZ7v3A0cfu93Os
	2rbUvHYxTIQZ91vejt2WFFAhezTZtXDUIdRWS9WvJc4vXZRD1geKwO7a/qMpRfv0
	QCyGNQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8km2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a8ae5154e7so3120462a91.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792405681; x=1793010481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wq6D0np2UJn8vl+gR/Dp8dr5QQvgLmXdT6JzLOTCLAk=;
        b=GLQkhLtveshCNM4Mv8Vu+bQBRTeDZ++5QNnLTV3pEdEJocYZG6zEBvFyeVnuTaCRhQ
         14t0CEi2bj3G7xZ3Pzw3WJRwsn6Ns02Xd3CFzwDKPRHjmvae/on+AR06JpBEzfpP9xaK
         WgZ5OhFpLgCurFXbbSWAWG77B35+n1AwDZfTkD7Jczz+yFLGIl9eUoKxbRAMw+mv6m+n
         NRYl4cZMloGsp1miyz0TW8Cl2CJq+KRIgn9lv1LACkFXFIWLRQ96fPpUIG3c6OY223LJ
         q1uhDxJopL4EqUdvp/5fUGd0hHqBK5+X76C5G59XoTzbszK9QMQu1dQvHvOJgoMtlxTG
         sKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405681; x=1793010481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wq6D0np2UJn8vl+gR/Dp8dr5QQvgLmXdT6JzLOTCLAk=;
        b=b4j3rImCG0GS5jTqkAPy79T+LFARVzxPPwM5xRyQyafrYpWUyCUjXAMwVcWIq29OsQ
         EFyKuC7PJw60xed1ELXClnhVpwayeQfeTd+QFYkOJrNWC9J9UyagtgOwhLs0yy8uSqzz
         NehX2nM5TQDhHSHS1chF8Iq/zUSURdM69Dx2Ubumv9FtLbCD2hZKtpEhNjOBLPsFYnvR
         DxZWiQHeJax9UcWCIT2aR8s5zim/cfKpQJQ8ArofpBtITYFPRBxnZvhwH2NWzTZWmUJR
         v4csh46czWNeu5ABn/h5ey3z3N56g45u6js5v0iKQtRfg2q++MQLNd9RRsUPpGdXoCIF
         PxYA==
X-Forwarded-Encrypted: i=1; AKwUvBz2ctoMj+fwM1zChg2fgmMJFtm/nVikPboojgELKu4TmWLOedLf2jpLHTUo0UYtGGbkAA52yEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI05QTD2UxcW6vC+FKK/d19NQMojELgUftEdeTwBHfcRkp7uu1P
	xz3w7XiHWzZ1EQsTnpHFtCrvs8gtTCFX+V4HoFzYk8hcw51TvAwnrcEAK1B9Fg64XorXy0JGrOl
	GSAyV0vQPHPgJ/iKiI5PcHTCCHhvx53/AiAp723EDgWJuV7hYglTNOAEMBbM=
X-Gm-Gg: AYBFou1l947Ah2gFnzL11kVD3+BwCfkwm77yBaZ7n2CuRPEc8lBvQLq+ynVP+CXbEZD
	riKqmqbO+ETmrOTZ50Sw2ztumfVVhdp23esSv2EY2yKPMbpkl7qQtAL9cyctlNX/u73DOs9eGAA
	btYXx1AgkHuJ7YbFFxP4UoROoH21L71TZAcqDSiyjoS6FNYhjRYrvOdlhDfV8QnAhjSRE21c2yx
	KifvWt5Nx4fF5R9VForEux+lT0l+RhoK+F4lpxxBC5HWVpbP4JsyMUqWw4K99nX7oGZsnp9zr+k
	eVLkRIOZscMlnSUnEF8NLKNDnS6Eo8a/3T3TNEazP95sCoWqaeMitpN4RcathcposdJwmGhw6nv
	59FF9mRZrR5RATYyOSuM0d1ZaHuxTSDoAX8YRtw==
X-Received: by 2002:a17:902:e948:b0:2e8:4f03:dbce with SMTP id d9443c01a7336-2e9a70585cfmr51669655ad.51.1792405681477;
        Mon, 19 Oct 2026 03:28:01 -0700 (PDT)
X-Received: by 2002:a17:902:e948:b0:2e8:4f03:dbce with SMTP id d9443c01a7336-2e9a70585cfmr51669195ad.51.1792405679717;
        Mon, 19 Oct 2026 03:27:59 -0700 (PDT)
Received: from hu-gthawre-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d7ef1sm36359785ad.3.2026.10.19.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:27:59 -0700 (PDT)
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:57:32 +0530
Subject: [PATCH 1/3] dt-bindings: arm: qcom: Add LeMans Draco EVK board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-lemans-draco-final-changes-bringup-v1-1-dcabe94f1074@oss.qualcomm.com>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
In-Reply-To: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792405669; l=848;
 i=gopikishan.thawre@oss.qualcomm.com; s=20261019; h=from:subject:message-id;
 bh=kh9tVQY45GrFiUF1ke5Gy15WoD3EZQssJNTVFnwj+Lo=;
 b=DwTof/h1vzH5Akmys70qASYAZ6TGtPsc+jfUBRIrmZF6EmdnbAhzunQNEldstBP86IJA/fEpf
 gLV3DFxYCH/CsQkwWG/EvQXeY93qQPg0Cjxf408hyXpWlzb+KXXWg1/
X-Developer-Key: i=gopikishan.thawre@oss.qualcomm.com; a=ed25519;
 pk=l7diN2ZWn/39T24vZixhPPrGDEUF6RKc19MsWZubM6s=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfXxkGi1kqTUdT3
 bv/sWO3mUcRuGcx40vp/gjPm98FSOnAo0hEPjlEf6aeks0dUuFsqNd3Xiiw1sY+0FD8a2O9B7Rz
 fnwZrutaFsM2gpDa+JB9ITFRbupgBlY=
X-Proofpoint-ORIG-GUID: Qar-E_2HmT-qRdx5NHj6QtDCUca0XUgS
X-Proofpoint-GUID: Qar-E_2HmT-qRdx5NHj6QtDCUca0XUgS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX7Fd0QQcQbSAr
 Us1tI3qX/bRSv2fxdfIZuPL05rYDquoC3m7SF9l4nIgOWEVdzGIsqyxhBJ4bpTmN07mCn5Ebu6B
 i2yH0ufLQi9ACW/tXXnMSTMl/3dg8vH1rq0AWBgIiQGBTMmQXuTEzLIypbsp7Qa4jQiegCyP2sB
 AlWOx/hqOfqGHG4hu+c613FxmfL1/x9H9NZhQENGVEt/9mLDsx0yyi136FwXbMkO70dlt9BtKhB
 z7+B5RaKkhX8X0B/YVZx6m792/5+zG+07PjqlPjRQyqKQ+GOX6AZ2n7j9qvZf4hxA/0moWvtKLa
 APUHj7lUgbEQ9L5ij+ggKyJb/7jza2ab4sOiZ3z2sMXHYydPmFE1uC7K9xnBi/Mn6WAraiSm65Z
 xS1TLbj6uStgH2T/cmSuNIJbjMWegJPs9Sb8Q5ugmg3xfnF6bAHQgmiIHMBLWFKlevk9BLKThay
 +Xs7CsnplFI4cnRZOJg==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5f0b2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ghiYM7v6OCwGtqAZdvUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041

Add the qcom,lemans-draco-evk compatible string for the LeMans Draco EVK
board, which pairs the LeMans Draco EVK SoM with a common carrier board.

Signed-off-by: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 07ef7988b068..1efd6ea34c3f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -498,6 +498,7 @@ properties:
       - items:
           - enum:
               - qcom,lemans-evk
+              - qcom,lemans-draco-evk
               - qcom,qcs9100-ride
               - qcom,qcs9100-ride-r3
           - const: qcom,qcs9100

-- 
2.43.0

