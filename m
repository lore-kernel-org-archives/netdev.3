Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569354;
	b=ws2pjt45mHQCzPV9amxt4MNrNOSz7UzcEZA+E3sYqABJkc0vFhn0p4rKIxStkvT6KGuL
	 2fR2MrOcGeJH3Zw2PkrKT7Qf1yoyl4EqC+iQy2NMAARS0tPYZny3jPSwhAN3HGtIkBZf8
	 yNh5HcM6KrZV3uNy/h28/LNJXSS+WmSvMWVMDzdjyX3uLY1Bo3xuFHuuJFQ0qKtHcykwb
	 6FMSwo0xwObgWJmUJ6utzACP/ban+1uEE/gVMRCp5kRAtoC0DypbD4WOI8XT9bWhasPR7
	 1Of3LCOHKIkntqE7QUqY/RpsHuOJOGO4JDOu6RfUzg4NNXJBIvlNUuoydnv+NvGIFfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569354;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sPacS5uKz5JBbuz3gbxJw12erSXij4kzMnxn038/KzM=;
	b=MS1cMNFDl6tXlqNzM3eOahdd/Nc5UcDk7yFII7l1rRKpgs6WlFMbxq/gkWJNGVIohOjY
	 URmy1Hy9xr1/sJI1je6Csj7ywVPiR/iNvCkjH5hL4ukJs7UJKgpNgY+2ECkVSvbW8/3Hw
	 z9EMWZDexsHlRGv0PKP1CmjM1c3p69wTKDKXuPpFSPa3APtUJVwFUbOjJvYh9wOnwbQVs
	 hUetsgX9jRhmYC41lSVsfBfDrz9GH8j86048sYHsk9VPr9LADWyhkdEMwq1IYLEhe3X+M
	 +8nDJ4PJjjU5/M/xvm/OnnLg/wH1gjSxVnAl8RlA7KgjB8iGkwRcEHsx1bT6TkJ2nbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Of89bIrr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RQWqqHYs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83981606A889
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83981606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Of89bIrr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RQWqqHYs
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADA5G6n1163504
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sPacS5uKz5JBbuz3gbxJw12erSXij4kzMnxn038/KzM=; b=Of89bIrrlsR8brhi
	xNAe+TFPRCIQIYnNTaUaweKZ8zsj8nfy3lyhWatEEdhd1Txt9wikq3jq8Yh+nD64
	oR2Oi4GVJzcrecjUkPo9HpDCngNQpNkqtwwUuVsSgaF9ioJMELgDR+N8VGRe0JiA
	iNUTjE2D4GMI+J5mcN6Rwd4vkESaRYnlzfCZylKUgkOOKSw8MA3GOJGeqv4Dfhlb
	CBEGHaG7UklB/SfqoYUzdpsHtTUQX1E5Wyz+fQngc6paUgNxe5jy8d4iMCGC4MOW
	+pp35vv+4IUZKV2eqSSBIEGmrqPqfZY4tO9Ef7ucAf1xheVk85l32vGqdc+2NpH+
	9Vk55g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g207v8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:29:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-37549877380so1120979eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794569352; x=1795174152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPacS5uKz5JBbuz3gbxJw12erSXij4kzMnxn038/KzM=;
        b=RQWqqHYsKoMt8SOPgGKvCGr4tHTrvsZ8DqcI7/1P+/QzKkGhvm9Yp0RuMfp/tYB5Ih
         VAonQcWrsd7EmzHJbiRb3PY/ZyrjImVts8zjOILb07sfmfjNqbKHT7EO7nKh+nLaEwJK
         ViS/uCdJbpjaFMY6tWasvXd/O534fUqqVjHySh+p8+aXQ8u2nw82mEMLtgqqVD0bRHh0
         o6gQH3wkO1cmEzFqUiHCj/+BLNEiAYEdmvvCyrkfvoPoi5EgFZuGhTYhtKyIP1BzTlwJ
         /jgaDrb78E0NLan2+Pbrlk5Ho3Hr/vZeJC5pAOsWW8q2Yb5KvjjZ/ovf9V5sGmZJVJHM
         vIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569352; x=1795174152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPacS5uKz5JBbuz3gbxJw12erSXij4kzMnxn038/KzM=;
        b=c/2BObkaPURZL4+TEIAMOekb6Xi+nKZPB0i9FbzSicOIA8RN8XxmRXA2w6LSPhFxJv
         68IXsxJkCw3hcGidz0BSBp+X8Tlla4EWVVAh3vLcXMhzgKns7WVUF6ZFk/7oo93T5DV/
         XhltdIXnVn1Pghp+e2yfIOh/NqjQIZn8cvuEm526RNBjuz7vrIdI0PXWmDMPDcuYPf0p
         JoFf+0XSzFgUhdmE1CwlSHcNhYNEJzNu6UD9KoYxXfyXODEdBCA8lJUCzoczLoP0szZ+
         /EgxUSG/plBzq7iC4TJ3mFJ7FFd0FZ62E7JQY4yYNvp3/wgd4ILu5EjcB0EaUelnxNAs
         uhgQ==
X-Forwarded-Encrypted: i=1; AL+hErHNiyhy7nS/EHCF9fvsxQVIPHdogcqV+dQXzcwaKRj6NpHRJRrSoDpi6SHb93Ub3aSeMLKzRJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KmMDjXwgC5mYjeQWMZgP66NDGzZMuEOdj0NtjUd2/QbAPQHvZ
	pMK/pXrqZR/2+G8xhwNqTnoo2vSgUgaA0SU5eCP01Br3MdByUFcdF3GNnIj7HiTOL49jtpXKz/R
	0dz15l5AEf4efaVptoXo1Oh97K9GPN02V1htYU9PMHD8PaJ2w2ET6f2QlQtQ=
X-Gm-Gg: AYBFou3upfLT+tXBBpnp0y4ckkT8dNZhoDvhdKJqTOCuL5JptI28ULDBeTEXR3cYvtc
	RuyTR8kaOxihoofuEqmYTNe62sAfEfmsF/de8FcYW80lopzHpZUuCvzn6iAn7e/L2N2V7PdnDSX
	wUCg5e5cg6pelZ5q3jwi3eBlB2PL4MPG4df55XqB86c0qEmKVO6ZGzGXEkbyERoPU5y+e3JTPbY
	O7x1TDOfe2AT58MHj724bNfGjJBReiTvqpyRGzCqLxYADccnNKJdRFj7l/Y5ia4F/9iSMKv31Gg
	/a4E4yRzJxBZ3ydOgijYlaCSO9oQ0i3EGoQCoKZ7bEewq3kAPei/0CaH2VcJCPDAPAUGR+e5HWi
	Zz5U4O8amV97HN4QGwuR+3uhRU6l57HFYlchSRkAmVRGoQWtvKGkaXN/w9Yskvmdy7+LewL1OF4
	73HGn1Ig1gzw==
X-Received: by 2002:a05:7300:c386:b0:36d:e4c8:8f04 with SMTP id 5a478bee46e88-37967506f25mr2157621eec.17.1794569351760;
        Fri, 13 Nov 2026 03:29:11 -0800 (PST)
X-Received: by 2002:a05:7300:c386:b0:36d:e4c8:8f04 with SMTP id 5a478bee46e88-37967506f25mr2157604eec.17.1794569351198;
        Fri, 13 Nov 2026 03:29:11 -0800 (PST)
Received: from hu-gthawre-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm7342924eec.2.2026.11.13.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:29:10 -0800 (PST)
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:58:57 +0530
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: Add LeMans Draco EVK board
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
Message-Id: <20261113-lemans-draco-final-changes-bringup-v2-1-3ae8cd1c9932@oss.qualcomm.com>
References: <20261113-lemans-draco-final-changes-bringup-v2-0-3ae8cd1c9932@oss.qualcomm.com>
In-Reply-To: <20261113-lemans-draco-final-changes-bringup-v2-0-3ae8cd1c9932@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794569340; l=1436;
 i=gopikishan.thawre@oss.qualcomm.com; s=20261019; h=from:subject:message-id;
 bh=7rKXgq1NKJQpUYaFuu5Z+2iP4kdS+cscX2k+ha48s8Q=;
 b=m+NC7zNqcRvbwVTdgWAyA9AI+iJ7VY1OaPtEx2KM3BqndbnV8kJ9tLtyyN9MUG54CA8GMfvPa
 BYiL7Xgn6vUB/beXsS12D/P4SrBbSQVEp1AeSmlhBfv7lS3YFaBMbXB
X-Developer-Key: i=gopikishan.thawre@oss.qualcomm.com; a=ed25519;
 pk=l7diN2ZWn/39T24vZixhPPrGDEUF6RKc19MsWZubM6s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0NSBTYWx0ZWRfX+UiQ5Jl5/TNR
 d6K+P90dCgr8HCDZ3nQiX8gbALSS3p6a7ZW0EnsngNyD435/5c8zv/SqffG+cb+O/ZE10r8Rhho
 njchA8z7yFMXXqa8lf98LxmAOzYdCUcX0MbNZacs/0GfiDmWSbpg6UPVTFHpiFavjBQcMHSbYQ1
 7mzwg1M6rwFydoTYaBJuSEfDwK+FPB05XkIld6t58Q7gU64BaE4IOZ8SEmug3UxYLojH9eYDYLi
 +GEsXDIVGTBTUDKcJCDWGuAEenpLpK9WXtyRMLnOY/l1L6HYfNVsSzkw1cAFslhdXNdtD4nQC6P
 1a8HISVSoWmekw+fcEayd3ImNDXHFO4Y0PvGteiOW2yxINZGqP/0Hp1oiqrfZYUIeFticMtCPz3
 K3DDow5zFxtMEL7R2ZqBcSJiPWivPGshKJiMde7rwzcUSMiK0qAvjlWH2JSjkYl2Hef2To59jkP
 vZ/3MOh1DzAYWJY9qSQ==
X-Proofpoint-ORIG-GUID: fgGUcGXjAd25AUXE-NvP2ySMs9eTmixs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0NSBTYWx0ZWRfX0hqoTjZ14uOY
 qxpAdaubB+z3dj0l3pb2s9QD3KpCeDmuEvghDP2UnOiUAaHWy1SVTqvPkeXgb/qhiaRr0KvqtyM
 WdXFy87vrRfpdew/K9YEW7wGsKxpTXE=
X-Proofpoint-GUID: fgGUcGXjAd25AUXE-NvP2ySMs9eTmixs
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af6f488 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1iP3MDFSonxPIfbD6BcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130045

Add compatible strings for the LeMans Draco EVK, an evaluation board
based on the SA8775P/QCS9100 SoC family.

The platform uses a two-board design: the LeMans Draco SoM carrying
the SA8775P/QCS9100 SoC and core connectivity, paired with the Draco
carrier board providing application-specific peripherals.

Add two compatibles to model this hierarchy:
  - qcom,lemans-draco-som: identifies the SoM layer, allowing the
    SoM device tree to be shared with a common carrier board.
  - qcom,lemans-draco-evk: identifies the complete board (SoM + Draco
    carrier), used in the board DTS.

Signed-off-by: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 07ef7988b068..86edf4df2d96 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -503,6 +503,13 @@ properties:
           - const: qcom,qcs9100
           - const: qcom,sa8775p
 
+      - items:
+          - enum:
+              - qcom,lemans-draco-evk
+          - const: qcom,lemans-draco-som
+          - const: qcom,qcs9100
+          - const: qcom,sa8775p
+
       - description: Qualcomm AR2 Gen1 platform
         items:
           - enum:

-- 
2.43.0

