Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702536;
	b=N4Q6U98NAc89Xkk7HdXCiJuGNSH2mAS4rqLmiUs1jUzCcU3kzbi2+H6PqGCTf4pptMEd
	 +dSo0NT9EFON8yyEpRMIedG/6aaPxpJClUnidvHLt7aUfB8Pfrtns7WkqQxbo435+AJeh
	 65bVbOyKusTO9A2TwQiPSBLL1PJ3Vzs+9qKMCaoQ5ld+JPaO/OVc76FngCpyn9zn31kg7
	 mOLvNyKF3j4JdLvjTARo4OPxlpmQBrjWnbvlCuE2fH7mawFqkPRhHVkdcDMrMQNMkyNQ0
	 L23Fm3HiaBsaHv1bxbzWrC7oEHszZnuqmocNvbup3gPVQg+yJwz6AdH6hUCZuB9fxog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702536;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wUky4id+jp8YQ+y/i0f5IenruvHIfgyCfa+AfUKoCwU=;
	b=anu4k687IybBJFi8gx2AtDVnlHQgfsGZ3P9dSuvbjEzGOoipOH8qZ1iXL9bzI+aTX3X9
	 /Fq77lUyNTNRa7iO7aegjeedrqqIRv6iX6fDZOlCS2CeOWIJqyfSm+TWwP4s8UV1qkC8V
	 8zptpsZ08+kVTtGmcoEsdjl0Cn5UofxJ/wKHwmTm7xknJDzdjtGhF5zm4ApCm8Y6CYzOR
	 cCO+S2Mn1Y54kHawEgIZ6KmxCM2zymQQkhiohd0qmSEIt0kJzbO+NRZXd9U76zB7cUDXj
	 8eOWysxlfDXFlyGXo4Hss0+Alc0tjzaXdYctEyjo4e6rE3dUi/Z3juFlPDNE52nOSsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jV+jB2z0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QfRLDjEg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D957606D81A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D957606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jV+jB2z0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QfRLDjEg
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAMJo2552987
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 10:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wUky4id+jp8YQ+y/i0f5IenruvHIfgyCfa+AfUKoCwU=; b=jV+jB2z00pxoabHh
	SdiGwrQlLUNusuWkGYEQd5oksX4s5Tvz9qroCiq6rSWoWPPnNGRDgM4crPEVMaaS
	rLqwgkvvR8hgTfr/S3eypnQFlACByLQur3d9Z0JVTOvOY97talx8qasYYazGDf+n
	R/o4JuINZEtQkSjKCycLeEmybrG+JHBBanAAnU+2lTTQ8uQ87IBdMQ8ReudNuW4s
	O9GKEfrxVxrnT51T7PeKN9GmeiyrAD8pKXV5ez27PXyDw5TIfvEfrCHNEHU+U6my
	+gH6jh9emSmvAC+FKeBZ5kfpICJH0vQ484Ee9gKy9wKhJhEhfRN30no4NIUBPy5x
	lCXRIg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq08739xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:42:15 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ead43326a7so577476e0c.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793702534; x=1794307334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wUky4id+jp8YQ+y/i0f5IenruvHIfgyCfa+AfUKoCwU=;
        b=QfRLDjEgy6SqP5uymwxYKvTIVr4bflcMW1xqhuiTwKXlvm1wOEc3ME8c2EPCK/LVmf
         4X6kfNW54KTkfkWvG3KlvRVObozV6hZPcBQ7ZTjuNGCq3Ik+kRXqdFVN3cKXMVO4FHc2
         611lLqCTdmnNvne8GojKGFI0Y/zoHKtmbuKhwcQ7fTRgyBi/JmqopmE/v53l7oG7oHBv
         ZTQA90rOIBFmWRpsXEdLUEL1d+G/pxIzRFmqKvXWBx33BdDZn0hxkzlUxOkHGv72S0p8
         9VyaAVFTATfTZ7pGqjlL/bgOVu/qgtGjo5KnvrkMkZwxF7eVuSYqyOMgUis4Pr9HquB5
         xkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702534; x=1794307334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wUky4id+jp8YQ+y/i0f5IenruvHIfgyCfa+AfUKoCwU=;
        b=BFeKo2fbm1LGi5/H9XVH/F7x5OpVxVZVKimM68JzhvQKdeT1nzL28NYvNqaVhdIjmI
         pQZp6eHFyBNEbK9BWYz7AYEyxnOzZMTI2j97w8g+xBBjzIVkgAa5HVejYS7vQvtTIoU0
         sljAkBHGrVaoR5CA98KFGPjqGOEUfMwbepQy/A+qHafdWkco7rpbyrYbJ7Wd4QP3R4cI
         blPqXPyGFl1cjII/8oVABf0YfV73jqSuKO8FXu1aDCsQrZ7k3yDWnXClrbZGGKqTwlEN
         +rBXrENiQb+kGNFFrEHXhT9+n7gg0mcx7beBzrNB3HuRdv/laidZeZPnK3abDkq1iUfF
         8RWA==
X-Forwarded-Encrypted: i=1; AKwUvBwxR+7koIJtgyQ/dq/8dt9ZAUGPgzPWaoFd5i1ft/cSpn5haQ/PjwtjbiHxG10LWgsSJb8nK6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YGm6WoHGimvo/RFUoNzdxwPpH9svyt+i1Zpl7l7DE2Hfyhojy
	lORnBMuirF8PZ+eZpYXlQqxGTF8J1Ii9pgy4LJpRTTciLL/BD/ehien6/tzspbfTwEPXQXitA/3
	1ZPLwEDkF07fmgUGxUAs4+WG+nwGoZfs6wkAmqzHG5bIHN4wgszrZ5KNz10wLIaB4VZo=
X-Gm-Gg: AYBFou0lxDjJS3NPISvg6gd4tuyq7/sQ8JZwkiEC+s/w87aZ6qerovT31p+MTpTOCgx
	ZTTJs6SNPLSuj5IME+JyeXgdAsNnT5hLwHkF9AMC+S5z9I9kDU3JgQO5ISxsXE7zjQUp+iGehVP
	PnehIRSKRVcEJN2eaew0yznPz6oIoQDKTlzw/gXb2fqAbnLTId6hB/LSvV2z+bVtav89NYc9FXM
	nKaREfzrWEDVQ1Z3iW21swLzdsCe8GC0oOGdAWwM6Rtzcq5e8rS4BTm2bh4zdNQjs9nsmQ7VGpj
	UF9E3LBYmj1N7LJCCtepHrN07Zl1HdAjzsAmZ/EhyxB0T7smGYGnx1r+fjhMZNBrufFgrxOT02v
	4WP1PfJqSf+JD2XpLiTuHQyhZOGcdhI0TERUQGUVgEcstusWBtnNT6w86n2mob6Pzvou8it1s82
	DGrQ==
X-Received: by 2002:a05:6102:3eca:b0:7cc:2cd0:e73c with SMTP id ada2fe7eead31-7d072cb04f3mr4044823137.25.1793702528168;
        Tue, 03 Nov 2026 02:42:08 -0800 (PST)
X-Received: by 2002:a05:6102:3eca:b0:7cc:2cd0:e73c with SMTP id ada2fe7eead31-7d072cb04f3mr4044813137.25.1793702527720;
        Tue, 03 Nov 2026 02:42:07 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae0f4sm21625057f8f.58.2026.11.03.02.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:42:06 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 11:41:59 +0100
Subject: [PATCH v2 1/2] arm64: dts: qcom: lemans: fix iommus SID mask for
 ethernet nodes
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
Message-Id: <20261103-sa8255p-emac-dts-v2-1-05f9355df966@oss.qualcomm.com>
References: <20261103-sa8255p-emac-dts-v2-0-05f9355df966@oss.qualcomm.com>
In-Reply-To: <20261103-sa8255p-emac-dts-v2-0-05f9355df966@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Jb7Uu8eDKmxeuPJ+cG/Fp+9EJ1Cb1pVCLeiG3jtX670=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6bp7mxuNVqXHR04a520lmNEQ/flnPb2mkrOMu
 7B9m8qjWgSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaum6ewAKCRAFnS7L/zaE
 w5/BD/oCRiPXuFwoeQm1Ic4o4j3gx5oJdO6UGAruazfnh5oiBQDqaBIw4zUI/mYpzrM8DGupgsi
 RtHcYtr9xsYKDLSB/Zhwlmm3Fahigrb2KqxRajOO+K1GqUIxdovKp+wXsr/LP/PZLOgNVyLWXt4
 Ju+YlFTQxZQ88cWyKnCzC/Iq68tO7twu9U9OJ36f/P34QQ+kH9f6Dd58DuQ+7mmc22Zb/EEnDIK
 LSWd2dNXH5kTq/18KrkBzIpJy+pSowCz7+eHvfVIQC3ixE7lbRyzvwJVkMaK17VeEN/JppFjVP5
 73R5HIX/cfXrZyT0Ttsr3UBS8ARu0dcJ+HWN+N+3SzL4WGkmBOxO90ZY153VbIFxbQQl2FvRujA
 FmXiRJGpA/tSOB7vAzICIt70aoaro1Wue64EbqYqCQLL8zZBRfduhzRDQpQTXCPkNRvto/gZdzf
 073oboRNCJ/zsl0rGKtOYSIz/Km8xsgJFYmfWKRHH6OwFWvq4Y6iUmoeYSQrWqKlA5t/2DBu8SO
 1b/XMdZvKvVip0oqdWuDH2MOpCF2z5GvOw1PTFTFJa/372BxvSJkyLxX5IXbdDQGKpq1Ea19d1f
 MRuO08OYQQeBZa1XvnTxjltzb4DhsRbsbphBZrf+mlYz1X5mirU8uIaP5Py+Rix2gGqMfMtiti4
 o6csCIpWeCH99HA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MiBTYWx0ZWRfX5RU4BMnVFekb
 yOxk3dVcB2K4qH8akSuE03zaUmzA7U2HOwOSfg3WSONx4PyPEThxIX2g4bIbEJ07DbWby26+gnn
 GNFAll60/QBUPUglwKF+A6bkbnQoa3U=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae9ba87 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=jHMX-OgH2kBFWhD5V08A:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MiBTYWx0ZWRfX8SZx0mojAYLU
 Ksn0kWzwoMqI+CWviZj+w+LQ3cjO5/agCQAOAkC9aRDilf8NsUTHrz4r6fRlAJ9vYkiiXgweJlV
 KFTDhuQNtmhjTYTKrjvaA5hP4tJzN2EgXYZPXlFbulf7VfqoF1xupMbuYf++SgVK/l036I+sqUk
 jWM5bxAbfUyxR2mVns2gA/a7/7gMkCrmuMDbXwXcCDd+P/31QK7aofs7x3U7jxzFPQNMpH+GJji
 6VMLoS4x+IWFxsWKM48NbGDF3p/ESVQWg04P6rrKG8fbPKbxBi7DOf7lvG+BVI9dQGOAMlf2hCr
 eJQhLEjDmj/mWsROGHwYOPLDJWVELZC30vfxe118laz1Hc7hf+XQxNHFrrrYY2j7oyMm78R50Vy
 XnGyoXn/DwfKA5UA6Ng7dxYzFeerK8ZygUb4F9he/2xcTSLyyPWApWoTFoU+3YvdK/onVZq3ZN0
 5z1qoLVvo5A/j2wnO0A==
X-Proofpoint-ORIG-GUID: 3cD5g3lWvKLEL5N2tnDe6MGQk0yTOHJl
X-Proofpoint-GUID: 3cD5g3lWvKLEL5N2tnDe6MGQk0yTOHJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030042

The iommus mask for ethernet nodes is wrong, it makes the SMMU mask 16
stream IDs per MAC. We should actually only use 8 SIDs. This has
triggered a crash on sa8255p after a boot firmware update. Use the
correct value of 0x7.

Fixes: e952348a7cc7 ("arm64: dts: qcom: sa8775p: add a node for EMAC1")
Fixes: ff499a0fbb23 ("arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 5284030fe69da9323571cf64db218ee2c7169509..915b3be65ff1302e2b05dd2034e73ec4a0970a6e 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4395,7 +4395,7 @@ ethernet1: ethernet@23000000 {
 				     <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "sfty";
 
-			iommus = <&apps_smmu 0x140 0xf>;
+			iommus = <&apps_smmu 0x140 0x7>;
 			dma-coherent;
 
 			snps,tso;
@@ -4416,7 +4416,7 @@ ethernet0: ethernet@23040000 {
 				     <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "sfty";
 
-			iommus = <&apps_smmu 0x120 0xf>;
+			iommus = <&apps_smmu 0x120 0x7>;
 			dma-coherent;
 
 			snps,tso;

-- 
2.47.3

