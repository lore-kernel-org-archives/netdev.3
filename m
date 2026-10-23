Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746156;
	b=j9p/OVlnGtp4CaC+MS8ka4eFV4NciqnqaSbO6jEoBA1tZ/Xv9p50Gw9wqABxfHdBa4YE
	 csr3HZsxIxKswtSjsIhPVFmDOiciUfGa6rTG3EaK8jIQxrXIY1fQo5HkZpB37OEKJeyP+
	 FoXoWM8xUCT6jVs6ETxqfjbAqKN9MXkF3an5lCfs+gC0OuntjSML8vOjFAisGpcQScAQH
	 bzWBpFNcJsl133mUfTiZsf1/6DS7fB/Pi/sW1wTsxDlATqlILNfVJarJIq7Sdjl8EhbED
	 gP9msRxFVAS3vVEVElZaww9RxMflbUubMIFXJIHoWeuSakFPVHU8t6PyUq1KrRIC6IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746156;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8W2Ztl1Ru6WUtOrWa2GjLbkwbA+l5960sGvM7MImZEc=;
	b=KPJqSWv/CZFd89PKVI3ajyobmqzCmOza8lpBljv4OEdIjU1b4o3fkogGYC6YZp3WWTDv
	 dJweDt5AXW39GzfBsuPtNkAKQXH5Dp0oJRpSehqUZJPat7D14TfwJi09ZRTC3I7v/ux+D
	 zaDlDuw1V5WARieeumi8EJ0OOi4mCRsiIdPX6C3lWc1tuiDkAQXTyPhOgE1P7ehqKRGzR
	 vNfCf5vtmEJnpk9ASUVWnaHtyrz96vjaAImcOgqWWQJElDQ0qwE9BQs0K7sU/obZq4IL0
	 l3984sJi/dzQuEw+qbVoQGWhgunnSVbXgMapP2W4mmi1BwdYev7Fz+BAxOaQovkl22w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MzHQAA5c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P3TLefwg;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12515606A327
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12515606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MzHQAA5c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P3TLefwg
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9Iq2112124
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8W2Ztl1Ru6WUtOrWa2GjLb
	kwbA+l5960sGvM7MImZEc=; b=MzHQAA5ceP4GBO1qmggP3nFzB+ZdpamOrGHLT5
	IdbTd5t46Bydl+X8p+ConErVYsa0eP/J74BJ2mJCB+EwqfGoWsaWbn21T27D6hzY
	fuOWMO/IPdzPVdp3rvcRpkC74/GHrvl0h19jiEgOdujiyxPfeEFUfOkE0ZI0HHRP
	we2x861tUwlDh2Zcm3YV1hpoj12xxQMl4dj/O1O6hNAAcDM6n2tDLvWDCTy5QgJQ
	4us5ufaX3trxKes7d00yokwxS8il6NfL6ARqKwnhcqAWFGgcDTTtOZhb9QiZJzOX
	iiVzVsr6XpUWgl8TZBf3lfuFF+o11kYwBd4kv8AzP9tY5pcw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykaa12-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:02:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91be1227fdeso16476296d6.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746153; x=1793350953; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8W2Ztl1Ru6WUtOrWa2GjLbkwbA+l5960sGvM7MImZEc=;
        b=P3TLefwgjSXyoWGfRoEAzqsuTwFiYeEzzk6aAWLRRhiya4HbJkiSuXXuAoD0yo32v0
         3AZuSb0ckj9Dhd0L6uEg9zzW2q+mKns8KVIrio6hOsxNuDkw9KIna3s2GGAhBGIdzf4W
         HKILBZl7VfokWLqYGKcE+E6F1GGE6PoILMfc3UxN2GWtPbaJ2KZy/fVFjEIMTge6fGMJ
         geO50sJmFieEhcOYCdbDcNpuuNhCswHEdZGXl9YLTWzwOtlXQUlo4ZoFW50yp4Yz9w9L
         WHzkzOvnoCE7lGR9sGouYOyTkDGb8gUCYo9vMUdBWEn38yHYqQ2wk2V/lD6ULpRsjduh
         Lqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746153; x=1793350953;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8W2Ztl1Ru6WUtOrWa2GjLbkwbA+l5960sGvM7MImZEc=;
        b=lxkxJAENhH4JHW8Nte3liI391oLY25uZ/RKo3+A1CAcrhnPXyBY4wp/w/zA/oD0l5b
         dKdLJp+JH4XTyztZ63XRdr0+qWWiv72DRD6JGxYbMfEKBDWIN1xHglRI1xEJ+7e1VraV
         Tgxyjvp1moeXMBk/bx7BdLzSzk/TN8dzWNVgc0Rm8obVVa0JTbacxSvoSy3uUijg+T8d
         bjtKgVwAF24A1d7D3d1r3CDSqsNm6cb4jotCHBAzaQiKsqHp7OSzPLEKaPDQ9ZlGTJoz
         ExvCLlLMP7oLcic+6t0neD/7i/ksyKSVMMWipBi+JLFFDAhv0S6F8GnBVfwZLR4sa1GF
         Q1gw==
X-Forwarded-Encrypted: i=1; AKwUvByD9uVKNmWp1hAMWZNOXny/l6K1d0/kYQLx0nzkPudqhcykGJ8S8nqK1vP9IVDEN5EQfsB8eWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzAyS1Eq2DcsPYaYONB4p+k7u5PLk5SFNBoLCm6BJZz8jn70z/
	anUKf2cT9B1hhTilqlotZvJgtcCnc0L6gMHKcWQ53jWVJdFdOT4ikpMC5AhnGBp/H+JBAI4Rg0N
	AJ2g25Tq0t4ez3l6W51T00x/lmiHZKb65ZSX8MlFMHTB5z3T3xtOfwWCBg7A=
X-Gm-Gg: AYBFou2dzMi/wBpXyYnNLpui1Y/3QTsBh2INJ/lKKaKDt1f4VTTNIEv87DuXPmuE4/8
	uNBMokLB0Nfcm2pUy182O1x2ls8fRCxo4kwuStiPewENTSWgcUQKMTo6IB43eYbpGOy/RausqPf
	fyHbfGm8gsYlj0XOL1+8i8HKDbSiYsxLt98qXK+DFSwZgiMFfKgOA5JjqmPLOpBszAp2kwRCcZe
	3mDrnj25iS7CCJyVemi9PZFZCo5rQ0FPXCb2EVq+J2vD3opRHb6VzZTl5BMyT61VdEDMn5r4QZw
	9sxf8XBFQE9vtWsnbKuso3Y8wYsbFeaw1QjwnxhucgUeQ3VjGeNdwzeuVmsuHirPPrT2iNm5osz
	+kN+fnJ4tfBn4EbttE7PHkQkwlME9
X-Received: by 2002:a05:620a:450b:b0:93f:115:7338 with SMTP id af79cd13be357-93f6f8796d2mr286960385a.54.1792746153123;
        Fri, 23 Oct 2026 02:02:33 -0700 (PDT)
X-Received: by 2002:a05:620a:450b:b0:93f:115:7338 with SMTP id af79cd13be357-93f6f8796d2mr286957385a.54.1792746152617;
        Fri, 23 Oct 2026 02:02:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a215437d4asm23076245e9.3.2026.10.23.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:02:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: qcom: sa8255p: add ethernet nodes
Date: Fri, 23 Oct 2026 11:02:21 +0200
Message-Id: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJ4i22oC/3WP0YqDQAxFf0XmeSOT6KhIKfsfSx+mmurA6qgZS
 0vx3zutLPuy+xK4Cffk3ocSXhyLqpOHWvjqxPkxCvxIVNPbsWNwbdSKNBWoiUBsRcZMwINtoA0
 C7bkxhDkhlYWKtmnhi7u9kV+nXS88r5Ec9qU6W2Fo/DC4UCcj3wL80F/+gUXs+2+dHPYDGk1Zi
 ZiWhFVWAoL0PHYxoE+71X96kXRe7feLmcZx/I+T/8YPPUz9Ha5YgIYiQ32xsQdX5g/aadueBKn
 lCSkBAAA=
X-Change-ID: 20261022-sa8255p-emac-dts-dbc521421276
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=RCKtRuKFrR7tGXSvR+VOJ0TS+wAcLe2hylKIV4cNKmM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2yKjD+FzEB0z7TSHAVjvTmQXHm2qerhgN6dXd
 AbTbbAZ5U6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatsiowAKCRAFnS7L/zaE
 w8d2D/wNDEtZzRy7jn6lzojLtaiBXzd5mY3y1IqsxfoY+aadKSLVvBgphSOaPhb80fkLhOXTz2T
 lHehHjK2hkHa0QW9uz+H43bvogsUBwmCnV+NCwNYOKHUxkcsdGrhoDgeuO1mGdCAIiIFLB0BShF
 y//KtdPrHndS3Qk2sO0ZoFIe2r5JM+iwUIoTaOD0JdMV1H59v72lB1p53xGVP3+kUz+gfhmBdpA
 3p4ZN98H79GldtdbTFP211uA8NhWS4MnjXftDuyJVf013TeoQ65WIWMgXo8tO852cw3iO1PgfA4
 yFWVTWAEvOHFFEy88DQKWyFDkkwf2j7elXx//bHcFZ/zhXqozNY7ZXVJL/d/2FLZ3nLIxhjjcuy
 jWnAIV11UWdtBtyZtVLAO8j10eD+blQOQku0+NZBwIYW/UoiJunenREBCOwd68yoD39GU2CgMIu
 cbUq13y13O+aL1Znt8bdUfq7tqPX5UtiS/ykHmyXbv53ViRvm8iAlzLBI5Pvzg2ZQfBEumNGq62
 BWQiP5ClSsS2+atiNE4PO4zG1HqIHCoIf1/n/iUQHT5L7Xz38DkhCL+Msm4b8ts414cFFUb6BMz
 CUtPzW0MPBkKrsqyVhioh9JACmliAjXpVqFyiiinBogccPOHyXvOr5lDfTj0FzX5etvoHJsOiqW
 vUKZM8efPUgOsmA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX3S1DOXeDjprB
 MMQfRdkilUbohF6EoSAcENG9kAkKH31Jzmg/mRWanbL7E0TrhKz6GMziLdjckT387WrXpAWIs57
 zx4MXgEB7qiu95EKyLD8xL7pEZGdSSQlPXRshwSAF7MCN06d7fRNVsFGRF/8ghgKsMelW17UGG+
 TEeLK6lhqU5dCxLyXye5w1QbHpyzAcqNDzoXoTIbj7nckJ1NoAs9NAZEJ8076CojbQi0dbeGWGW
 94XQLo6lcQ1CL2Sb6lvEL0mv0CeIWsYkqZOMSiqMvzvUVlj9Q25OiT5HHwubR7nWK5GH2mJDX1Q
 vJ8hYNzOcfZCmBm5EvDslchDtSfJv99B9b0L0Sdjho1Tu5VUCddCrc8OdWnjoaAcUrgNF4fIZv+
 B/wYde7MHaWpMejsOvk39w0lwlOVtcuZrdWf3ME/CrcZvgHGnCD+XO68MEWR7OQEAStzdv86VvI
 B/R9Oe8adw2S89WL7jQ==
X-Proofpoint-ORIG-GUID: MX1TcZkI1lUScc0w7EeP8RAJffo4bjC4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX2+c+APKKeTym
 aaJQjeNyKHBK6IA73B7axSDGMGe0PYpEzK0EHPuMIlSlmx2xHxadHQMJYFenmvMbHwlwE4nLcrm
 67IQYHIIjLlVrxRsrzHdGp694onsEek=
X-Proofpoint-GUID: MX1TcZkI1lUScc0w7EeP8RAJffo4bjC4
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb22aa cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fcLLu9nwmMbFcDYE2AgA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

This series adds the ethernet nodes for the gearvm variant of lemans and
enables them on the ride development board.

The first patch is a fix to the iommu SID mask - it was wrong all along
but only triggered a crash with recent firmware. This should be queued
for v7.4 and backported to stable branches. The second patch should be
squashed with Shaun's series. The third adds the ethernet nodes.

This series is rebased on top of linux-next with the necessary EMAC
changes already queued for upstream. It depends on the series adding
base support for sa8255p[1] and the SGMII PHY series that's pending on
the list but has been positively reviewed[2].

[1] https://lore.kernel.org/all/20261015023711.721837-1-shengchao.guo@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20261014-sa8255p-eth-phy-v16-0-6310fac52e85@oss.qualcomm.com/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (3):
      arm64: dts: qcom: lemans: fix iommus SID mask for ethernet nodes
      arm64: dts: qcom: lemans: make the emac compatible specific to the embedded variant
      arm64: dts: qcom: lemans-sa8255p: add ethernet nodes

 arch/arm64/boot/dts/qcom/lemans-embedded.dtsi    |   2 +
 arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi      |  28 +++
 arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts | 213 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi             |   6 +-
 4 files changed, 245 insertions(+), 4 deletions(-)
---
base-commit: db4ba5d3b1ed0db55a16ce32764f8c9855013db8
change-id: 20261022-sa8255p-emac-dts-dbc521421276
prerequisite-message-id: <20261015023711.721837-1-shengchao.guo@oss.qualcomm.com>
prerequisite-patch-id: dc952656b431f0bf8e2411ee14f50e7884cabfa1
prerequisite-patch-id: 27868f2a4c4ab6fcc455b250f3cda1cf1c7801c9
prerequisite-patch-id: 341b5a589bd5eb68854ad203e1facd93e1b74192
prerequisite-patch-id: 18b6ae4d5a6da83554473326a956fd03c7571b7b
prerequisite-patch-id: 5293d5db8a1231f0c1d4ebc0e9aad6862e8c06d0
prerequisite-patch-id: 7391f02c4b57ae6afb088fae3150ea215bfa594c
prerequisite-patch-id: 5666ecb900181a3877c902983bb1c3ec3c3058a2
prerequisite-message-id: <20261014-sa8255p-eth-phy-v16-0-6310fac52e85@oss.qualcomm.com>
prerequisite-patch-id: 16cabeddf5ca2469ab9eddf6acfe1b86c625d11f
prerequisite-patch-id: 0a76ec6a2e4431d679f4918b3d469c9644dd660f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

