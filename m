Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715547;
	b=z3/P+Ed23AXxMGyty7SmDyhV6NU58PGOm1m9Vl6Xy7HccCl3TbCW7HFsRNXpWIKv7LIL
	 cqbXjczhLzG8I+TP8q2+dVaP64wPaeZvzYUOxA4uHgfn4HAELt0faDIBmX6SW1+oj7CPP
	 jisrYO660FaJeSewx/uGf1fTIrM53S9gFs0WWR5ajmJGLWRjm3+DPJJBtk5gfiuqId4eo
	 ob2bW6+7n8k+VBByFynjWsJikAgkdHoP1nOFBAgWKsm0kKkrKQ7zvYQDxABbIl2Zk2blm
	 0axKMeFX0bXCgvT9g9G/Kb7w2vBXikQhT9wNT8E/MDq5LTOBnApOUvi4nczQiG7KvYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715547;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3S0r6B204EHHeKzI68P1lldrfNMyDu9t5rxXVOUyz+4=;
	b=Ik7/fpesKaCbkdF3mzMJAsQIXd6B32LsmR+zv9kCiWXYlm10S5sf4/vIoR9puBmhw0C2
	 HyXCODMRkh/6PJ2RyCbO/sgHMFEzrK9KaEzenvvxdUhwZzMjoOOjyCMki1yayYHLX9yyO
	 6YIJMUdDR7vpGzeO2OKfRsd+RlOb7H/GmnXg5t9VQEAX+iXpCxV6RtXY4MgZ3UW50OC7h
	 YE6to/0eO5k9zftdsXkmgc+zDnE+Fh3O0Hew9GKns0ZjAXOKHRLDvQZAD4gsGs5ck+CGj
	 Mrs2NkCNf68T2ufnYT+rmG+e5WsL3+xEZvbDXSxm3wCYynSGZ3ChhMkPFhLQh/Xvj+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbjsmXij;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LCCnl+JS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F5606A328
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB6F5606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbjsmXij;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LCCnl+JS
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9xhh2526854
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 14:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3S0r6B204EHHeKzI68P1ll
	drfNMyDu9t5rxXVOUyz+4=; b=IbjsmXijZsAVSSS5s1JovtdiZOPSJ34rLnLdvH
	rJGeFUyCqpXuvetCm3KjWpLAv7B7FbIjPuSWdTaVABNBz3Y8Oz5eIEL/NlUawPqr
	H2FLjF6qpBFLwFlMfKB9t8c2xuljzdiEktYDEa7z9bF64NNJWyCWZbOmc7QZMVH4
	sfYr8eQ1wC7dCziq1f5WSBGmwBKpL/ZsYFAERxgsvW7fFsQpAgPKlKhMqNgFZYNC
	BANtA2iAojHZWbPZjtqgqB5UTmNYnpmZrDTrzSUAuiBDc1Wp0tcXVkh+iVW/W56g
	5QfpfJ/KbYr17n00wmMtdJyJ3aHMBMfTljUBX5WsI88oUcvw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7yctdpa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:19:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd6532dbd7bso2604110a12.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793715544; x=1794320344; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3S0r6B204EHHeKzI68P1lldrfNMyDu9t5rxXVOUyz+4=;
        b=LCCnl+JSJQE8IKQe3S0PH4B1trnPt+2j3DidmTOHRhxfcpYzhf6lR6cs9xkIFuquVw
         uoGlb3STLrMUekKHBm38hQX/vSwaJnaTZdiU9RptaMLcB/BGTAS2RjKLZ7OlA5oED8pO
         3zWn7GW/S8mkzmuEmrGJ0yYMWuP5C4bTQgXk1bEyUEeGH3rUAYhHSi2JzlyLAEOC8WxH
         HxyMtFR4VtRykwJY8jLgQxP3UfyMdiL1/Eyztv9K+gVZTza/NiPIZiNxa3xJ+iyWc4kr
         Pu4V5lflwG9fnIc5Lm5AM0OzZ9kG1pE7egk/cCUU564HQ88RoUH6+t7ZKIekrrABDQAi
         sI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715544; x=1794320344;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3S0r6B204EHHeKzI68P1lldrfNMyDu9t5rxXVOUyz+4=;
        b=Ac/8jZjymKBbkRUaEWjoyoGCoMdcLoEksw/3mn+gE9ee2e+QQ4rj5QZAhMc6pKJajc
         X/00HDyXj0znW4EEVEaFdm4HVBqcXSQZTpPhavLgBtWe8nM7I20bwq2QrQGYMifHcK9A
         04oeAhbrZD9+ILs5UTW1aBUVeV2UFW2LJFG/MV3Jb6XXfE8sWPtShNNZ8HM0i1ydtL/s
         XvnBv4Tbcc9iqgHeSoIej/6IYiGJz78MoLkaEyS9KUI9RqsMRYcuK+gfFjDANJrDGrAa
         TUUuWV9hzrz0BTopCwTC6VjkpQpPaFrB+JjFjOhon0+FNv3ClDgyMKGMve4uBC/eqR3K
         ngRA==
X-Forwarded-Encrypted: i=1; AKwUvBzw0qmEvG1yAIxxg3HAw8HAQmnAxEtsu2U0lLCl8Raf/j3rY1sdo5xySJkjFC8f/bCxPcrAlIk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TydwIeQONT1jnxXn12ZIMQVrUu2S0YEJ5PtP2a2EqRLs3JGyw
	YShJoLJACbLksXwx4qVRPzjeenalbWdwAHTJji/WEryUdqx3dOhkpOpBlhA/Z0P/lE4ZE+G7gLL
	mqY26ESCd80PJqrB7s1o8OVwoxq8p1HsKhuQ0vxGTDT1F6NzKukA3jgHLopI=
X-Gm-Gg: AYBFou0+gB6giAn5j6J0bmRLXWJBelp7Nm8UEQrykLXtqyw4eNbof7Z63ES/X1QdvIU
	ACw/f/1rlLP7Kyrs+ftmMhJI7xf7Y5FGHrANewxXx0ONpw2RItUxfZ6KAhZgctv6cPUIjt0gsRT
	6/vXHk8he7Z4uoG8/JNoahWTZQ74KZYLVcGw7Ny++OFjMdYKA1vHHAKYqaTMDG7QmZsiqSSd+iH
	IVLNtYdmzXb893kYZmJ6G22+B2/LkyXpuF/HF3WJtWw8DqEm/A+ZvpDqn/NMwpXUPze1BzAMT7R
	cerftkhEcFYp4vTbQrRmpjD23g3cY8/a5roEToEDYyRzB/dcmiQOVW9mwIkr+eiRsqPRxp2LceP
	pFg7BePQe0gSKE5FHc7FcHgGEQ6X+RXxPsiP+WPPCPN0feB00mojfxownL1Gtj8iKQWRBZPNZ1y
	EZVBUJ8fbd
X-Received: by 2002:a17:90a:c2d0:b0:3ae:533e:7e3c with SMTP id 98e67ed59e1d1-3ae8981bf57mr9838897a91.35.1793715543971;
        Tue, 03 Nov 2026 06:19:03 -0800 (PST)
X-Received: by 2002:a17:90a:c2d0:b0:3ae:533e:7e3c with SMTP id 98e67ed59e1d1-3ae8981bf57mr9838876a91.35.1793715543484;
        Tue, 03 Nov 2026 06:19:03 -0800 (PST)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb36468be4sm1442126a12.12.2026.11.03.06.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:19:03 -0800 (PST)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Subject: [PATCH net-next v4 0/2] net: wwan: qcom_bam_dmux: Add restricted
 DMA pool support
Date: Tue, 03 Nov 2026 19:48:40 +0530
Message-Id: <20261103-qcom-bam-dmux-vmid-ext-v4-0-3690cc5ca0fd@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAEHt6WoC/4XNwW7CMAwG4FdBOc8odljT7rT3QBxC4kKkpaVNi
 YpQ3x2rh+2yioulX/79+akyj5Gz+to91cgl5th3Eg4fO+WvrrswxCBZkaZKWzzA4PsEZ5cgpPs
 MJcUAPE8QGqqbcDaoPSo5vo3cxnmFj6rjCTppqZNsrjFP/fhYPxZc9+/wgqDBtNQEZ713tvruc
 94Pd/cj/bSXscqF/rSG9KZGonH76R2hrY2tNzTzq6Em3NSMaJ5DwLaqUZr/aMuyvADdv3StaQE
 AAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793715537; l=3232;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=6Zmq60a17c0joTxpTILutxl9UiqcuO9gfe8ueBT+e0E=;
 b=X19BQGEzJct/9OMvaulxhVdjSjIQqCoOboF9i5oQXxdSGvCZR3hw75w4JUB+/QRgxqhonFWBO
 AkAYajxC94eA14SZXEJxZ5ABN2WRYRdfK3Sqoas7KMYmgwPtWU23vhK
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9ed58 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=b6zUKPCi1xLaIh-VD8cA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: NAhS4IA8ZWedspBufmIQYHoTyvFCwdsm
X-Proofpoint-GUID: NAhS4IA8ZWedspBufmIQYHoTyvFCwdsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NiBTYWx0ZWRfX95HV9nWZKpX+
 Knzndhd7AX9jS+6EjXrdslZwTMZEwqIsDvrYcspO2l4v0/YTZAF+oz/pbOwtJLOlVrCZ633nVTd
 7KklumPHwzFIVBkjqjNKO+o4hnoR15CmX+i9O4j06tHinofCRhQyYhwGTHCCGhYUbPTMUGYnc1l
 DcRIRg/gxcj9ZpqMSB81f73QgHzSRjK7YzuYeUWTJmMjhCIRgkGsHMVQ2aVv062Cpbabixy+TMy
 CrRlYmpylEG2NiRA3layOAXbiUmmhIMY6C8Hy2xYb4NdwbFxKqL/4jqnCei5MvLkvBIrQCgLJ0P
 SFLHT/5aeKFiHCVQcM5B+NRo7IR47v0LyZNc6MBVsknC/PQo+jVH6okdAk9oGEV0Z8sf2fW1Hu1
 aiXeGkqx8DC9zaBs8mzZw+htTLM8WApXVHhYeXeakgWKpKLHXqqPwpvclynwtKQWZwFeJXuTaJ+
 oBZ6b9HkmUfVieElJxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NiBTYWx0ZWRfXzfAPuTNAx4ic
 lw5DNqVrirgTC7rWoshQwk5pEZfswF7RhJuOTVioMzM9Gmj2ExpaSfb8wlAUJLuVcLCs5xTSM7i
 C/Y8bCLvIlryvfbAv5L1ufOngv8vh4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030056

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
 drivers/net/wwan/qcom_bam_dmux.c                   | 114 ++++++++++++++++++++-
 3 files changed, 148 insertions(+), 3 deletions(-)
---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1

Best regards,
-- 
Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

