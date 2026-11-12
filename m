Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474830;
	b=EKFiLz8EP+K5FAZU/pW74ybXMUh3rpu2GuFs7sLA+lysJpmyox/xwARtLzJmG/xgaiBM
	 5zbFUVlusBV4knAEdadVall31WpjZGw097YvIsTQZoKHhj91aYbGR/4hLxgYDhQyScXg5
	 H/ULPJokC32LieGyXn9RFsNMrdaufa3u9m6tGwZhmsCpQ+QrXVGCV+mwTBihXkKsGz5fm
	 /Sz+F2QyvBvMKWRXYdrh+w2r53akpv8odJHXaA55z8yAYFOiMz67/de2uOH101zvFHf5e
	 hUnlKmLkfyqzLxezgD2JfvHCkrtviW9HnJPk/9ZaScsavHk2y5OlfIFsWl6oS653ahA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474830;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cYmTZoPUYSFPWFNC0zeiwN04G1lik/3NZ56mk8EnAuE=;
	b=okj8g8khdxYDJmDTa/bbPTQcqBCC9/qPURqnfvz9N7D6r7OlEB/O2lxdGoZhAZVanVL7
	 Y8VilY3GjjnYCiRZbwLc9Ej88uuAcOq/oSRRfDSu0/jVLYKDywg4VpNQxJPa3b1af6X+L
	 BAriZq2/8CC2e8dYMqQKi3fD37C8ZNnJlNX9VZaILHhNy/WqO7vQTSKqfuSaMkOf3QL1v
	 g0zf/otZmcL2L+ESlxiBFYWytI5LlZUQOD3KA55ziS1ihEvpp9EXvkW5e4zVsyLs73YVR
	 bcQV5cxoJ3rg7/Fln8UCxNXrimZ/suY1BUFBTvWEJPNZyqANJiEWEblWuD2colfdvnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gGoSKcNV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aoQU8Zxt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733E606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2733E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gGoSKcNV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aoQU8Zxt
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZYOg4092560
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cYmTZoPUYSFPWFNC0zeiwN
	04G1lik/3NZ56mk8EnAuE=; b=gGoSKcNVu/SdEU0pH75Yf9LDuHrTPf0eLBqJyf
	4VXT+FXjUAurE9zf1w3E1MYLr1yZ8zW9IQ2mq8kgun9yCYoBUvvtcc24c78kluWy
	yygB9W1c3F6VcLOIUacjGCqCCLH6MZniFRVtJSVuwyredPMJCDfgDmN3tgE0wdiu
	249/yAGLW6KbvbTG2q7/plyWbcjL1bJJTXGqVRImd1lnYTpqkjedFuRxJK/t4CT4
	snw5IuUCnM3K3BtxRHnAX/+4ezm6CoLZsAmhVR2U26/boN6w6F3ijO5J2m7NThia
	jDyI+rzKbFMRSicyZxswXbjETFLHZrWKOUm8N8q5Nd6l2eyg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8j4d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:13:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b08364cdc7so3611045a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794474829; x=1795079629; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cYmTZoPUYSFPWFNC0zeiwN04G1lik/3NZ56mk8EnAuE=;
        b=aoQU8ZxtZwbY7DAhn57MuI92mdo5yzNQ4eav8NSAnlC7rVRbFvxadyj2zcgf2CAoh4
         6adBCJQ49sBlvZWwERE3oPHSvgbL/8JRsTf2eX1Qmznhj9vH0z+M311pfQ88gCjuieIy
         3oW+LJJ7AqKVAQUG4rKqExwNVfdeIEotLZXm8X/I6z/l4zQd4FnPdYF38nNspVsz7OhM
         QnGqSKdK+paL1RYiUXsh5Am75S9Wh4hvKMU7ko7AA4ZkV9EXmCOhXQQd8MwIlzvELVbt
         zZwit/5uWqJXpa3UBgMJqTP9DSJbhTcWPEXxsPoDQzODsM+2y6KAkzQDPnJ3zrjEEMXz
         W/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474829; x=1795079629;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cYmTZoPUYSFPWFNC0zeiwN04G1lik/3NZ56mk8EnAuE=;
        b=edTpiQmWtxYxH5wpAlhI1SaC6y2snuQ1nwCkf6vK5LznsWkJ1qWNoIUCtWSgBdUhgP
         d47QrDNfw7OJamRRdT0CIM+8BKDAqVhwyO1aCKYhS2O4goBuMku7ERojOiQ+NClR2dqH
         KI5FHbICOcoAYDpORlmcQbThhVVYNd4K0hoGu0qN/NQswjDMUChky0W6ws4MP8iX7rls
         dVoFj9vvaQz6/E+saoWT7fZc7rPzRZ30aoJAj2Sdx1ZLALHD3JlQXDRZozjXwxMmeIR0
         IN/81gqJyCRrZazsmXM48gGF4xNudWn+FPjYRb6f5zUd3Y4RO8EeeGtoiMz2GVYwEKef
         Ozcw==
X-Forwarded-Encrypted: i=1; AL+hErGCO0nC0edJVVpJgVTzXRQqZVmwn/9ZvpNQ9J6zVqCw7pDd3hAlotc2QFt+y1NCgAXG6VE83yk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+evO6/cw0cFl5XEdx6ng/DWOGt933KLiSyN2fFDGuBpxC8kFdv
	Z6i/EqWLUYDRJmuCrAzdPs6rJ3zsyonCvEF4hQEERDgX47nE6iBt0eSZV3nObqyhaPWLH+qdsba
	Enp2oIPwzZQRLkXM8fC9ju1tJ1obKxv6MkxIJMF8KBMtuxarEdhRmEqtUgIM=
X-Gm-Gg: AYBFou35u1magrIEOoJMn9Fvf9QDeRnRkSunJTQgVE6uiTpm3oST8xeyqL1lObagPir
	PxeTHCNW7qpVNsIuEp9s6tt3alJ/WFPOtbGQxmVAg/EwCl/JBG8cZXmftrXCRYgLLeRFIZ76ES8
	oNDZU2vSmWHQpCBLAEcJYywYF+zpDo35k6TYcyGkH6DgERPVqngRIVXNpwpuCBDFGB+NdrJbDiT
	SPRcXOevU0xuXduPCdg6ZKV2DwMR3ZljravedOGmvxFIho7N4qxRX9F7LDvbDd0UTVEICZL+1J0
	nIRkr2qm+fKs5xW9WimzqibXscotTO7kNKVBUdd7sNpdO4X9wh69d2j5oUxcUzylG+XXw2nR0wL
	ncMUAJZxaSSRM/PtCW/ywqqnIpai57XMgzDw4BNagVnX19VG+N+soFtqml67nEl9xrJP8SlnUa9
	/KIuy0Bpvr
X-Received: by 2002:a17:90b:3b48:b0:3a8:495b:d64b with SMTP id 98e67ed59e1d1-3b182e127d1mr4373570a91.4.1794474828630;
        Thu, 12 Nov 2026 01:13:48 -0800 (PST)
X-Received: by 2002:a17:90b:3b48:b0:3a8:495b:d64b with SMTP id 98e67ed59e1d1-3b182e127d1mr4373555a91.4.1794474828108;
        Thu, 12 Nov 2026 01:13:48 -0800 (PST)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b19b533540sm3019826a91.8.2026.11.12.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:13:46 -0800 (PST)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Subject: [PATCH net-next v6 0/2] net: wwan: qcom_bam_dmux: Add restricted
 DMA pool support
Date: Thu, 12 Nov 2026 14:43:30 +0530
Message-Id: <20261112-qcom-bam-dmux-vmid-ext-v6-0-7a16bd3dff18@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIADuD9WoC/4XPS27DIBAG4KtErEvEgHl11XtUXWAeDVJtJ8ZBj
 iLfPVMvmi6KuhlpND/fDHdS4pxjIa+HO5ljzSVPIzbq5UD8yY2fkeaAPeGMK6ahoxc/DbR3Aw3
 DdaV1yIHGdaHBcmNDL4B5IPj4PMeU1x1+J2Nc6Igp8oGTUy7LNN/2jRX2+X94BcqoSNwGp713W
 r1NpRwvV/eF+eGIZZcrf2qWs6bGUYtJesdBG6FNQxM/GjAOTU2g5mMIkJQBTDa07qkBE02t+/6
 pssx7vI+l0NDkb002NYma9NoyIYzsu/4Pbdu2B3jbg8EFAgAA
X-Change-ID: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1
To: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794474821; l=3727;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=S282AAmO4qCH3Q7rBUN1j90iYOz+g1S2HGYvE2MxTzM=;
 b=Pv/8XW3bnfccuJZs6QMW4PkqbumjCKZjlOBGNwqXlKwIn1n+SjVPbKLw8YaOxKOt52RgPMOrK
 PgxfwJ1H+4mAYlfAcTj8CMiSgWgfy9mu3fGt8WCbYb4csvsmQYbGNZZ
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfXw6I9w1WxW/Mp
 5d5IPSqTQKBTDxrUfJ93I98JK/tIsYaV0X793Y/A4L05uB+SuwG3f5bkzaWLpvMB42z1TMEx4Ry
 ziBTDWBd+pAOPppSyu+6+1LpDkNJUA4=
X-Proofpoint-GUID: ItXb-vyAhoJouFG-XjH4A5MGsym15uJX
X-Proofpoint-ORIG-GUID: ItXb-vyAhoJouFG-XjH4A5MGsym15uJX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfX1No8Fan4pCgr
 +yzQvYDINSXNkGq6JnMErmjRvFOLUAGgbIJaOAb4nK9UqNwIb5dLR211hFEREEHMtm80PsBfD5k
 68LtRfJGfoC3kVsMoYWljeprcDEbsGEhb/22KYRxWuuTTfwYz9QJqOK2dYxUYk4w8/8zQXRNZ+k
 q/HdXIGU1DLCr+dsmLnVMw+MDqBQKe66gtKcHUfz/51KyGtbCeQTHExXnKlpJTujxG6zhkpv0eD
 eUTC/sLg9vHa9khLxdqRRr7dTSKBV9HprQnnOHXPqh2Iclkt6B5TEipfN9jVyVkPji2sQ7SxMST
 F/9gwat2EOKjopzayvpZYJQ/kYfmorRV/B5170UqiuEC/GEC7a0Xgkkzstc2Q6l9YPX2bDON79E
 kdgsXwGvFhlvc1K/JdpPl6xcPRwnj4tb3rDRFkkXOmFtonf9Pce2LYRXtG/9CiF0dweuQKTuFh2
 LqcfmObQ89vPQgJsDCA==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af5834d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u9u05p8RAF7SMS7wY-sA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120036

Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
domain with restricted access to system memory. BAM-DMUX DMA mappings
and BAM descriptor FIFOs must therefore be constrained to a designated
memory region that can be shared with the modem. Accesses outside that
region can trigger an XPU violation.

Add memory-region and qcom,vmid properties to the BAM-DMUX binding, and
a qcom,shikra-bam-dmux compatible that requires them. When qcom,vmid is
present, the driver SCM-assigns the entire restricted DMA pool to the
local and remote execution environments before requesting the DMA
channels.

The restricted pool then contains the BAM-DMUX mappings. When the BAM DMA
controller references the same pool, its descriptor FIFOs are covered by
the assignment as well.

A related binding change allows the BAM DMA controller to use the same
restricted pool for descriptor FIFO allocations:

https://lore.kernel.org/all/20261021-qcom-bam-dma-vmid-ext-v3-1-299355e8dd3b@oss.qualcomm.com/
("dt-bindings: dma: qcom,bam-dma: Allow memory-region property")

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
Changes in v6:
- Request the PC IRQ disabled and enable it at the end of probe, instead
  of reusing remove() on late probe failure (Loic)
- Link to v5: https://lore.kernel.org/r/20261105-qcom-bam-dmux-vmid-ext-v5-0-5c7903385b4b@oss.qualcomm.com

Changes in v5:
- Drop the redundant restricted-dma-pool compatible check, since
  is_swiotlb_for_alloc() already covers it (Loic)
- Link to v4: https://lore.kernel.org/r/20261103-qcom-bam-dmux-vmid-ext-v4-0-3690cc5ca0fd@oss.qualcomm.com

Changes in v4:
- Decide the pool reclaim on the remote power vote after disabling the
  PC IRQ (Sashiko)
- Link to v3: https://lore.kernel.org/r/20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com

Changes in v3:
- dt-bindings: Add qcom,shikra-bam-dmux, with qcom,bam-dmux as fallback,
  and require memory-region and qcom,vmid for it (Krzysztof)
- dt-bindings: Drop minItems from qcom,vmid (Krzysztof)
- dt-bindings: Drop the example changes (Krzysztof)
- dt-bindings: Drop the statement about the local VMID from the
  qcom,vmid description (Sashiko)
- Reuse remove() on late probe failure, since the PC IRQ may already
  have powered up the RX path (Sashiko)
- Skip the pool reclaim when the remote did not acknowledge the
  power-down (Sashiko)
- Fail probe if the restricted pool is not attached to the device
  (Sashiko)
- Link to v2: https://lore.kernel.org/r/20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com

Changes in v2:
- Replace the Shikra-specific compatible and coherent RX allocation with
  memory-region and qcom,vmid properties.
- Use a restricted DMA pool for BAM-DMUX mappings and BAM descriptor FIFOs.
- SCM-assign the complete pool before requesting the DMA channels.
- Validate the remote VMID and restricted DMA pool configuration.
- Link to v1: https://lore.kernel.org/r/20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com

---
Vishnu Santhosh (2):
      dt-bindings: net: qcom,bam-dmux: Add memory-region and qcom,vmid properties
      net: wwan: qcom_bam_dmux: Assign restricted DMA pool to remote processor

 .../devicetree/bindings/net/qcom,bam-dmux.yaml     |  36 ++++++-
 drivers/net/wwan/Kconfig                           |   1 +
 drivers/net/wwan/qcom_bam_dmux.c                   | 103 ++++++++++++++++++++-
 3 files changed, 138 insertions(+), 2 deletions(-)
---
base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b
change-id: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1

Best regards,
-- 
Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

