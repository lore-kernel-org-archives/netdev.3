Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702529;
	b=T8ESbKwwEmHAq8CFBnzDMMYdKhfXlCeq/Z9VmApbmqxyf66EIP4PuN3h9kFAx2kNzHKa
	 7muL68Fsvs/B+VwKVd55PJFRovePVWpswD787bpleCWB5Q3KlyFzjVsN/VlMXY7ML9lDh
	 zQ81LmY8IDNilW2AwXiRrdLw89nh6kYomjO9PbDSxFu5jhPU0GDeaDYcsjXz3vXVAcvi0
	 Ugoo9daUWaJ7QsTHe0f3a8PrrSbSuZFdPRFSkWuet3uVoySiDeNLLFIA0ylDsSST1pbXA
	 iPOeQYq0nYhmkyW+tAmWYfig9c7ZmaM8WkBhfNvUT4DqwjGJJq0jfR4AJLGFiJtQybw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702529;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=x/CuCdz51DtCsa+8aM9q+5VicLisxnVBRFM4WxNQsyE=;
	b=QcREGSpthrS9uIRO2uR1VuHabTcfHfEsq0HKYuWi0GB9aTvd2AkMOLv88KYE5WuS1Q/D
	 HPmE/7SUJ47Wa7XZUwZVrcEl9d++AU0U8NNXAKK1vmNFx9QQXFucVhWbjVGJP2oM/Jx69
	 w4pveBYp2ZlyjZVRvmw9q3AoyRJ+7U3Vu0UpRm6J8lhWOMDT+cbTcz0dzkWpreIeesP9W
	 +C12LbjX8Vngba4gq29smOiVSykg0gFRkAGzjVCItySHJ6xCn4oiBgAsUjXMdki5XL1jZ
	 ayvu5zWRlTk1a6zKyzF/ccljsfb6ntdNNtpfydRixbJ0XJTTONXv+gz9eDeKCJKJvHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="AV6/dlEO";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dIlBRV1Q;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBF606BA64
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CBF606BA64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AV6/dlEO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dIlBRV1Q
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAUAJ2201872
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 10:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x/CuCdz51DtCsa+8aM9q+5
	VicLisxnVBRFM4WxNQsyE=; b=AV6/dlEO9GCg9ImgE9J0nx3rV0DM69hvJsVVN6
	I7+U2t77v2+8Yvqfq+TEQ+Xdcp3eJA41Ge8aGG22E+K8Cl7CBuX2xbfmYHcgs0mc
	AbCGwIbbLM02VU8EeeW7/lS+C2AixkKvsDddRNk37Iynb/SnOVI8az2aaf2eC3Ks
	ivy2ZtBrElUem097jV+TgM+08iZmb8G2hm6CKW/Hdco9jBs2Xix83JB1VTECzNAI
	rXkpGnjMI6+gOvfThAhsOJT0VjCEkk9oMcH1Vg4fkzoxbaNTOcsLwi/abzmkRoj+
	eq/PzPzGvGhNTt4yBo8DbBTrGsafbrMx4dUa8IplrnzbBxfA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r3art-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:42:07 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c96bf59c31so648431e0c.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793702526; x=1794307326; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x/CuCdz51DtCsa+8aM9q+5VicLisxnVBRFM4WxNQsyE=;
        b=dIlBRV1QkqB6alo4OZSYRirTl0Wy7nplfI1pXjQFtnhoFTWKgRA9Y59wqa1237aDb3
         vm9LW6BSir1mxS/Grsf7tT5Q+9MLFYMWI8U3ewky//8k9XHC4GV+WbHP5cLK07dA7fyx
         yWJMi2m2IWQAxQjw0ZkjnQaZL2qV5M5K2otK+XAkPxXxpCzlrIsh2a4V4t/tTjM9iUeb
         +beXYUoUyHqudodqMtqyU6SeT6CxdrS0u/IusQvr6VKkVaHAtJLNYwtR1pNXWUUpuVdw
         7E9T3xDBui1r2xkUBlH8kZU+UrlDo0Zf1dVg3Epkd5o07lLzy81P5abj6V5ovVEYwUK+
         I1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702526; x=1794307326;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x/CuCdz51DtCsa+8aM9q+5VicLisxnVBRFM4WxNQsyE=;
        b=k4G4Hl41SqmOiFWHwTF+a2sYolKcUZobaNUgiBcV+65wiAcptJw/jLSav+n+RVgHjB
         2Wo7dPHEkxm+yFoeVSOPAs+C1zsaSCmcVxX/wnL+qLWx2VAk+Yd2DciYVnQ0Q01GPqdZ
         cpoO+5KvZctpAX0rfjmttrk67v8ayr1+DBxe2SGztlo4QVVcVxJzlI0SoC4SKQlFLnwI
         mCxrj/NRuHfHN5Z2DBvcsP6SOvrB8d2WofvxREtCmm/AFzt+PfkNfgPPdE98TiTnvI3P
         knGrdlMcY0Doln9Zk5xOk8xhMyAu+MjiJbHDttR6XpUtf7dkVZOYakJcnSSBcpxFkPOz
         6sxw==
X-Forwarded-Encrypted: i=1; AKwUvBxT3SbquFNQMTV4JAf1XBrsrQMJZAaxDyxPh5+28PHLAlwQaXujaf03H7yNc0+1+yL8kBwh/WU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QF6n2uFgEpLLvJl1oLqesfWo6ViEDn/xhIxhfe2CbjtGaRtbj
	XleQcFOLTlUX8IkCJDfNckIYWlCYpFUD6kNEFjvTdEF7ZAbWmLM5O88o0tzHEtG37qz8jl0wZvS
	1WuXIt97lzfs6awtI4VpEOyxqE3vpgq2/pN96Zg+P8jTyAFmAdPfp0Wzpf2E=
X-Gm-Gg: AYBFou3k6CGpr6BWfzLO7qgSRSrr+QMexwJTZrDneZblznlWwkOTSWWegEqsWtuobl7
	tPNj2sbJoRWDDrO8FCO+Sqr+xP0L9LQea3KMfyiM0/8Ucoa42DWOSNE79sS9GRF9Bx3GWmC0N6F
	tPlED6p4r/DZ7EGE/qNCPFgqAuRidglikAmMIRSH4mzsFqlf2CRcVoVviIGyHv4t3FulfnwMrhW
	8RFRN0NhPKBtIPZD/MerWChobXE6v+PypCIbou6q6KZay27Ei+sS2+a3eIT7EmDGtoSt5PREZ1U
	lE+KOFfCA5mIfL40HREoEE15pLI789FoBIdKLgw1Gc0In1xqu+BC9z57ufhIUDID86GuaEV7I9F
	VpwwTOhnOR2B6JHOaqGecEppN+riOOKOeTqUU2xaTbAhycLYvNk9+6yT4+/3eVNyL3fDJnyoDUo
	w7sg==
X-Received: by 2002:a05:6102:e0d:b0:7bd:b263:14c8 with SMTP id ada2fe7eead31-7d072784174mr3993097137.30.1793702526434;
        Tue, 03 Nov 2026 02:42:06 -0800 (PST)
X-Received: by 2002:a05:6102:e0d:b0:7bd:b263:14c8 with SMTP id ada2fe7eead31-7d072784174mr3993087137.30.1793702525834;
        Tue, 03 Nov 2026 02:42:05 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae0f4sm21625057f8f.58.2026.11.03.02.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:42:04 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/2] arm64: dts: qcom: sa8255p: add ethernet nodes
Date: Tue, 03 Nov 2026 11:41:58 +0100
Message-Id: <20261103-sa8255p-emac-dts-v2-0-05f9355df966@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAHa66WoC/22QzW6DMBCEXwX53EXexfwURVXfo8rBGCdYKph4A
 TWKePcaqNRDcllpVtpvZuch2AZnWdTJQwS7OHZ+iILeEmE6PVwtuDZqQZIKlETAuqI8H8H22kA
 7MbSNyQkVIZWFiGdjsBf3syO/zocO9jZH8nQsRaPZgvF976Y6WcpUQTC4nfaWWe+WdXI6HDPED
 KWiFEnKqiBA4M4O1xjOp9fZf3rm9Dbr742XxvHxGhRJ/9GnDsbuDgtWIKGR0hi6aKmkekHbXug
 cTz7c95IW3H/46yN77mPBCNWZasuyMvZdmyeoOK/r+gsUARkmegEAAA==
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZdaIaY+sd4qGxuq/WbkAkOLGBf/J2rZz+EkKC9nhEX4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6bp72I5JmVXxrE6f17TOQS8JP6VP3lTL1crqE
 GsxJ490vJGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaum6ewAKCRAFnS7L/zaE
 w1c9D/96XsH7XNBW7BcW1ZsIrpVb149F/gKcDNJQeoDxEWDym+A9MNZTuI54kLyu+fFSUiV88t9
 KYrLwFqk5PBLr9T56f2ZILS5v2bzJcP6iMf2mUfl/ZHBRqtTBw1ap6wtTGs13hSvQMzAEFR9ugS
 PzzVn3hz3bznQh68MQEM48lyZIC9zmS1HaiRBYhBM36CdMUQxbTT2jNYNuMgiq0e08KcETh7DWm
 5rmqn5tDobDHIdu35D+RTeFu/AQgmQR0hhqIb/HK7ts3+QX/4VL0ktphZGcsVFjbRsfrQnz0u/v
 +eUckZzMV/ro2iEp3Oz58X6VF4ID7xr29rryzQdtAMttyE4gOgPcrpKmY1901iAm8mIFIgI7Jjw
 ORcUmHi3L+NtvLAArpS9z9DieYzL45SbilKprATXjPV3L1Njlcm8iamFhOObno9XiKibjtC4Wzt
 3kD7VfsIQuGwCAAmC3RfB52981sQWfIuLBj77BgWHkD0eZaGxMDCLijbhZ2g6ZEUk0qVkrGUvha
 xdxyMRpNSv/+RMUfNu63ELkf9vMhEb4qGD7sQ1ZkFK7rFEZB8GnCIiiCXhKY7jUwLgZH2TZ4MDj
 3rKp7uk72nX6noX8P21Db4SPq4hBN6M0q3q/4Ys2w+JLiN+KcU6Lzc3/GIdVnzohb84lOraY0+4
 gW30q2TK/CofXsA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: cGpfV7V-odZVumeRPVh04fpn82t3WoYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MiBTYWx0ZWRfX8k+wwOcTG7oB
 AcMgkeUeapX8LGMQUfofD5ShR8Z3geZhK7nWmcFc2WSg9XFEUdIy8yJbDHKfZMN0Cu6ssh7Domb
 +vKrOlCFfWhtPp7wsQdYa9NONbOO0dAm49sL/z1L0uVL6W//PJgRcSMO7lVA0oA39Wo/VRYol8N
 6RTm1jVbBPC3N7bZU//N/q1k6WcSPLvz9kVzQvuK/0IKgZO6g3sD151dm3FGL0EtBDK/jM+V9C/
 WSFcTYJxeCRozfj8vlCA1SgTSeuqwlrDBlChekhFqtmtaf+LeRnG/Ahhj3JFpLK3ahQvw5SDNTi
 m7uRMg2uZMaPQbWykLnS3H4uLg9qIayOY1ZlLzpD49FpAxJdCEPVEaz5RyXGCJQJqe8k9q/dXEu
 9br0omqfBhjDX2UhlcXptIS+6Dl+friJ9+fuL6Vi3etEGBFr/6FIvua14PPCacjsx64iod/4Lia
 W0OCNVKbIOdwrftZqqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MiBTYWx0ZWRfX5TBES0mLiHes
 gD4jB0TXe0eTmqUSaDwQGB004tm+fAsyMgngojU2/YBqaEXy2GkQNkLCRVBovNnrnILykWAJIhh
 XO4fWvQ1DXFFVDRvx/uSixdzL5LUeRQ=
X-Proofpoint-GUID: cGpfV7V-odZVumeRPVh04fpn82t3WoYD
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9ba7f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=fPA-ziiZiZqd26ch_5EA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030042

This series adds the ethernet nodes for the gearvm variant of lemans and
enables them on the ride development board.

The first patch is a fix to the iommu SID mask - it was wrong all along
but only triggered a crash with recent firmware. This should be queued
for v7.4 and backported to stable branches.

The second adds the ethernet nodes for the sa8255p SoC and enables them
for the Ride platform.

This series is rebased on top of v7.4-rc1 with the necessary EMAC
changes already upstream. It depends on the series adding base support
for sa8255p and the SGMII PHY series that's pending on the list but has
been positively reviewed. Links are in the b4 tracking part.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Fix node extension ordering
- Move hard-wired serdes phy references to the gearvm .dtsi
- Rebase on top of v7.4-rc1 and v3 of Shawn's series reworking the dts
  layout for lemans
- Adjust dt nodes for dropped power-domain-names property
- Drop patch 2/3 in favor of overwriting the compatible property for
  the sa8255p variant
- Link to v1: https://patch.msgid.link/20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com

---
Bartosz Golaszewski (2):
      arm64: dts: qcom: lemans: fix iommus SID mask for ethernet nodes
      arm64: dts: qcom: lemans-sa8255p: add ethernet nodes

 arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi      |  30 ++++
 arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts | 207 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi             |   4 +-
 3 files changed, 239 insertions(+), 2 deletions(-)
---
base-commit: bc71431221f5ba8bb33918399552636e059c2c45
change-id: 20261022-sa8255p-emac-dts-dbc521421276
prerequisite-message-id: <20261031131042.1200862-1-shengchao.guo@oss.qualcomm.com>
prerequisite-patch-id: dc952656b431f0bf8e2411ee14f50e7884cabfa1
prerequisite-patch-id: 27868f2a4c4ab6fcc455b250f3cda1cf1c7801c9
prerequisite-patch-id: cbdb11686213f2fd1c6542194976468ca9fe3ae6
prerequisite-patch-id: a7c4d89544f217b2cf75c5350b838d55a066fa1b
prerequisite-patch-id: 7391f02c4b57ae6afb088fae3150ea215bfa594c
prerequisite-patch-id: e6683111e3daed49ad3edd4ed960fb1c47959056
prerequisite-message-id: <20261103-sa8255p-eth-phy-v18-0-b00cc2fa0404@oss.qualcomm.com>
prerequisite-patch-id: 9d06b06a2f6c91c7d71b965b8c7fcb33d5e2bcdc
prerequisite-patch-id: 0a76ec6a2e4431d679f4918b3d469c9644dd660f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

