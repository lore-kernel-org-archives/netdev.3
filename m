Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014201;
	b=uDXsKrDL/V/37/YG0G3Bvj7wgGbnKFfafckcA+NXaFbl99v6wZgcCCFZNqgFgVAZIOeV
	 4uhwFQdWcnw/wUYMHNNm7+R9tvkATpUG+K7dSTJhIfHkfCcopwFg2olw1IHMhP7Wd4483
	 qi0Njkl2IjEu16bxpWSOXNeK1Mt51dY+i2GPAuqjltfEQIHiU8pUy8mfz93KklTzaW8FU
	 Hidm8s7CDkMfFtH1Wa+aTHLnKbYoHOqcYRayXQcMqLSuR+wvOMkYczhA8Ru1z7DTbqghI
	 63wYhsXnDOmWrb3yS9aAq/di223sBMyntaXjH1KBFUew3vrEt3jOhXcNgFI7fuiYqTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014201;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5+hi2NlDZX5Pao7C4sGve2f68JIj+9H2GCXxUBBJ1EM=;
	b=L5TpBRmY5QVZYqDRX5RJ3VTnDRW9/LNcVWRU3Xq/IVuPHP5UOugghU4iGPc0KgO3VVmH
	 t7Nbo9s+LXZP3OK4uCGpY4hTa8UjvQDUaNujN/7A1NnWGDB8Hec/0lkUt+FPqOD3L6uCl
	 iaTbkm/ufZj9g2D+uggzHIQk3sx5IEu1OgpJGwKEraSb40QAZwlxmyGxouZ2nPPP/nbHC
	 BxxQCKVROTIVYABuMz1buGnvYZ5dDip/k+ic6/KKZA4sHJfLqgW0lIa9+irhiesxoq4xY
	 OOOlSeyTPDAOJ4YcxmBf6Z2IjU0eo/VjwQrMAMLCd3yS308GWHGK64pscQ942EAwRlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ov+GCi7x;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UZMoi31A;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCF606A32F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64BCF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ov+GCi7x;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UZMoi31A
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtNBk3050893
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5+hi2NlDZX5Pao7C4sGve2f68JIj+9H2GCXxUBBJ1EM=; b=ov+GCi7xKRd1I+Ri
	qOWyUO4k/s7FTg8ltD/EBkUtEUyOLqARivYn/syb03lEcSoPZq1RZq7egxrpPmQw
	5pa+pCMQaK+Bzyq6RUcPvCMN9ztlg+apmtkDmQeAChqKZYBsyAYIk1A4F4CYyP18
	t1VLapeJCnzxxa1BpVpe/ZHQ4NO4kJ8Vd+j4+ZKXc6YNtwSC5Q8du+WFBdLsz+Se
	MpAKVlwswpPPnKGB6TXf7M8lOFpJYx8w7lsor5ziMmE1H616MJem/tVgCGpq6uPb
	b9I5yw/ofHr8epUT/tbdK0wZbDRdVaT0XS80kNgOFmx4W2bnzXqDl+da0XCiq7aC
	4MOCSA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9wax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:29:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad704d4760so2742377a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793014198; x=1793618998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+hi2NlDZX5Pao7C4sGve2f68JIj+9H2GCXxUBBJ1EM=;
        b=UZMoi31A/E0lO4BOSjiu1c3mlFzL3ftR1fmozKnM1XzxsyBEYek7pbT4jR/gAnO10b
         7H++KCMdPhpYbZ0wItf4aMRnx2UodJA/PRqOzFlrwa4H/p8dlSgudcOwQ6ZoAr2o4Bzr
         Ff8hCE5AY7178akXxFkPKvyoTymBiJT6+1SpykJoD4BnvSiUlYHVAcWv2kCBZiy4rYys
         M3RabDJzpA9TYRssoh/Ncv7zUT8NwFFHEl86XYa3bR34Vc8hcDMNZzn+E1H47jcPByGh
         Q0sJotIbfbVVoC8T6Mgr63H2/HU0CMBaSxtDpHfd0gOeWTCQM12DRmaurxptJy0/pl9D
         FW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014198; x=1793618998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+hi2NlDZX5Pao7C4sGve2f68JIj+9H2GCXxUBBJ1EM=;
        b=Ti4szRXEThYx6akyael9Xtvi7X39Un3wrEUyNM6jcctiCpcN96ToBa3o2cuG8o/hQq
         /b2EKiLYcAlI1YcZIXZKj6N4JRWCvo5eaLgUT5lQBFGJySvpiMSsFWaKB3t5+FfDpemc
         I0ND54iTIxTyv7Gi23Qt8YW9PvmVL8rtvU1gWaoSd/ObWpLkVISEpFY46+dlNZfxkULF
         e0gtXo1WoA+QFjsJHTxT9jz6fcJGHJFaNR+FxGtqNHN+MulSkrBfzfSRmQUZ1tJi5whj
         1CLM8ceiifGdhTHJUQkfRd6vjrTct1JkznDqX0QMdlPgrNCjhWyAJnRc6QHgeeX7La46
         n+tQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuVCu7lZVF1eTSEsedSSndDWiDSU0rC/gNGHamKa52m1hViJyuNJGz6mMhM7JLV8QXi6/COa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1JG7qt3p/YHJ2Qijrisgn1EX37J2uTg0JafZkBOaQK6Y5Vn/u
	V3XoM4MiO9+HmCNYfjWwABfn/cq+eL2bTjZBGJz5EAMns8wlbOBqKu3jqX0FuQro7R5H2hvqdOc
	guStJgc4T1vm9EeIQYol92PnRuFKupHHzlsuHyOTloG9/1BlvXSbuIBbiNPg=
X-Gm-Gg: AYBFou0VMcbvuH84+zApM3LEXX3o6a664IatwqGfHw2dQTS0u7fn2OFOWuaphdQHeRM
	+MY8s7y8o+rsuNySYtvjt3ZYjfI6mi+H/lKhe1JF/Y44iZ2qIh+0Vf+WPkao/Rkhcoe+URUx8a6
	ozyG1y00pM5cFt81gZnsDxueikpxZuQKgv7/gHgcbhOCSTAkSpbDnHFmFf69Ghw9ZD33dCo/ehj
	BYPwd5ARrvR4Fb7Kl4E0YlpSWKtjng+hz9qq9ORDcxJz24XZUXrgMhTCcbaWhXrt8g4jK6m1fh8
	te0v5hudbUQxTHLdKWFOM0/F43fAi+jCKXXTrb+6YUfdexw5PLfz2IIpv6BFyOE1UCwxVM57/ge
	i/EiDHjljRFnQpxMxbcYGVRc=
X-Received: by 2002:a17:90b:3c8a:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ade9b2c4a0mr5122122a91.6.1793014198098;
        Mon, 26 Oct 2026 04:29:58 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8a:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ade9b2c4a0mr5122090a91.6.1793014197529;
        Mon, 26 Oct 2026 04:29:57 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm8020388a91.17.2026.10.26.04.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:29:57 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:59:28 +0530
Subject: [PATCH v2 02/12] dt-bindings: clock: qcom: Add PDM XO4 divider
 clock IDs
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
Message-Id: <20261026-b4-pdm_clk_gp_mnd_v2-v2-2-ff8e4bc8d567@oss.qualcomm.com>
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
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-ORIG-GUID: 41QgCIA-k-p6Q_2mUiCyIP8cNxBvVXsX
X-Proofpoint-GUID: 41QgCIA-k-p6Q_2mUiCyIP8cNxBvVXsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX96Sqg2Ipk4Au
 BjPPKnyjQTHwyN1yaJ/Ai8ndRTBHHwk1MQZnPozvwH77ZE9gMNOm2c5qdAf1CCDAgNPh2Wk9BV4
 IiqswURiS/EYFqt4CLN7c+sOyj0r37XA652AMys/JPBSamm7usFpXZBS5MyVViiMyGCqvLz9Omh
 PS2Lk2YdQoOp/1u+pxJ/hBLdnAiCBcKIcgdqbaFamWOR+jNmidzQozdWvxVissvQHpey4l/abeT
 V9aLbM6YMJ7D6yl1Sm9/obW5s8Fi1cvXR52veQKSe8Mwyox7RCOMrngFw0MyPnex1AHHjmEKATt
 aa5GV16sesTgwzXoZEFoEDaNt9Mj/vjsjpEDW4aGhS1HcawgOjX9ScKhGhbNvPL75/0+wEE+IRQ
 9kw0AE+2xRS505qFE/f4JyD7sNJQ9CMGm/nGgEYwSEyCzVb3X/iFbt8ESFrs8kh+zIQkvcwcUZL
 lamkoWE6ejPVFIEa/Iw==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf39b7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JzXKva1iMknIiGK8KiYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX3WGFy1gyxTlA
 UJBFq5T5hiHC/4pyIjCFlB4X6AKFHsXwtKiX4R1k3XBdBM+u7ZtAaoUjKw75YcVFz4Z/08m0RVn
 OFDJ50ckwFoIupBmJQMgppPyYP3q2f8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Add clock IDs for the PDM XO4 divider sources on QCS615, QCS8300,
SA8775P, and SC7280. The corresponding GCC drivers use these IDs to
register the divider clocks.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 include/dt-bindings/clock/qcom,gcc-sc7280.h  | 1 +
 include/dt-bindings/clock/qcom,qcs615-gcc.h  | 2 ++
 include/dt-bindings/clock/qcom,qcs8300-gcc.h | 1 +
 include/dt-bindings/clock/qcom,sa8775p-gcc.h | 1 +
 4 files changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sc7280.h b/include/dt-bindings/clock/qcom,gcc-sc7280.h
index 3d5724b79bff18a858bdbb5c1654c5174e8cb23b..68dfd6616ce4b1c1e41f11603be639685301129f 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc7280.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc7280.h
@@ -192,6 +192,7 @@
 #define GCC_WPSS_RSCP_CLK				182
 #define GCC_EDP_CLKREF_EN				183
 #define GCC_SEC_CTRL_CLK_SRC				184
+#define GCC_PDM_XO4_DIV_CLK_SRC				185
 
 /* GCC power domains */
 #define GCC_PCIE_0_GDSC					0
diff --git a/include/dt-bindings/clock/qcom,qcs615-gcc.h b/include/dt-bindings/clock/qcom,qcs615-gcc.h
index 9704091636b87108a2a8c5ccc4a6b293829d8272..cddf21466a96a2990f1aaaf7c655fa6a4369ccbd 100644
--- a/include/dt-bindings/clock/qcom,qcs615-gcc.h
+++ b/include/dt-bindings/clock/qcom,qcs615-gcc.h
@@ -175,6 +175,8 @@
 #define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				165
 #define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			166
 
+#define GCC_PDM_XO4_DIV_CLK_SRC					167
+
 /* GCC Resets */
 #define GCC_EMAC_BCR                                            0
 #define GCC_QUSB2PHY_PRIM_BCR                                   1
diff --git a/include/dt-bindings/clock/qcom,qcs8300-gcc.h b/include/dt-bindings/clock/qcom,qcs8300-gcc.h
index 3c674c7baaba91815b13450e647b41053bd7330d..cee26f50092044f4a0b4cead6f669f0ccf7343c0 100644
--- a/include/dt-bindings/clock/qcom,qcs8300-gcc.h
+++ b/include/dt-bindings/clock/qcom,qcs8300-gcc.h
@@ -196,6 +196,7 @@
 #define GCC_TSCSS_CNTR_CLK_SRC					186
 #define GCC_TSCSS_ETU_CLK					187
 #define GCC_TSCSS_GLOBAL_CNTR_CLK				188
+#define GCC_PDM_XO4_DIV_CLK_SRC				189
 
 /* GCC power domains */
 #define GCC_EMAC0_GDSC						0
diff --git a/include/dt-bindings/clock/qcom,sa8775p-gcc.h b/include/dt-bindings/clock/qcom,sa8775p-gcc.h
index 01f54234963d6a531926103f8658307d4e0662f2..e101c9b565d650495e63f5f97b3458375d0e85ec 100644
--- a/include/dt-bindings/clock/qcom,sa8775p-gcc.h
+++ b/include/dt-bindings/clock/qcom,sa8775p-gcc.h
@@ -257,6 +257,7 @@
 #define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK			246
 #define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK			247
 #define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK		248
+#define GCC_PDM_XO4_DIV_CLK_SRC				249
 
 /* GCC resets */
 #define GCC_CAMERA_BCR					0

-- 
2.34.1

