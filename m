Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564801;
	b=5Vb2vz+1KvmEc/k44q0OOEq07X1owqQ3xdxJD7OWcLNEeSI3bGZEXhfYzrggWw/v1qs9
	 Nhn+T13/dTIuLtWhWCG96NkAX1IrIbMSiWUV2TEF+WftxWMkDr1Y5bOO8g8cVXwD1m/DO
	 FFHR6UevMIrV2BNYXCUPvXscgFAFuQmwmokp2hqqQADApqZeG3u50HwvKQ3IegM/RIgZq
	 hiZ1RxgexDBL1ict0c7p6YnCEjUnMxlh3sWlZU45yMOptN63cSZpOGuGHUziFO3CpnTK9
	 YjkNinKVATzkK+DW1esFY9dB4+Qf31Mf6Ib1SwUqyHXQov7ZTRIX7G537WpQ4BAoSQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564801;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Go5/h6FVonbcrlXkL4gMkuNu7d2LqHDLKl45lEDPQ6U=;
	b=vvPMJVUsedv2ZV2AmzjOxvzuiy4y7ImW6L2Sh22tMl4rQxANN4v0Vb/eXqzA82jpMdA/
	 8TLRbFrRUNKli8EXuGpMH/xUlGTXgjfgc3ZIq8teYkZAOPUd5OeFTsjKA75oaCP90YF7d
	 z5ctpBYCadTzBZ6SIuiduAWxFK88F9zmKkUwAMyXBXGIk+4+JXRffpvQQy1M//drC+IWB
	 hePWa0X0W7Ih/E2y8sLNm7dmfR8/Y5rCLexC/0fcU6y/dxPYaD/wbEkeeLnOYSuIGhLgf
	 JqhWdGDpT2nc+oGpLg3FTkIFef5Trl73CzxBy/Bfxm2oKhXDYo0wr+kuuM/rKlYdMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="IWNUfv/s";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FlDdU22W;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2A606A31C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E2A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IWNUfv/s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FlDdU22W
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L6XbTk357330
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Go5/h6FVonbcrlXkL4gMku
	Nu7d2LqHDLKl45lEDPQ6U=; b=IWNUfv/s7L0Xbv8mDtAt7iV0x60ZltrkcK0mRw
	ykwrWpYMfshPknfyU/05WonEVlWILfhh3m4sVpkM0DqPXGwCS4LVQzQV+a74yOjg
	K6uNtn38nVpu2be43MnhL3fTzmq2khnYHPelByNe9XSk//8B24UZ/YAPQyqs0F7S
	HvN/FvkozdilSF6Q3/ATqp8pHvAb+ALfZb+A5HlfmJGkYHXjyof1H88VmDVmX6I6
	BJYxW0c9mv84h1tQ0WzioTP04g0e0zT8GNAcpmwNO3yy59/Ai3bko9DHQ/Ge4EYI
	eLJYbABbI6flJ3m+7BS0YkS2etZWQQQQplnq/g4wlQg+9t4g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajjcdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:39:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so4534155ad.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792564798; x=1793169598; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Go5/h6FVonbcrlXkL4gMkuNu7d2LqHDLKl45lEDPQ6U=;
        b=FlDdU22WMSHx/t0NRsDkdDxsD/BAEpR7XcYRL1QEY+AJ88x2vV/9a9+7lSupyIXdzP
         jgMfwktu2P91t4xNhCqLlywA5bWhaEnWDENBmJDIR/PtgxwumFAOv+1OF/oI8OhRvLXg
         bSlXMOaTWAdZq7PA9utcXO//pg4E/xXwxSQwQzYfFxPM9ymvKjlVhPWmB9AvEuuemGW1
         pLXyafBLi5XV5yqkridZrV22X4fFVelG3D/HguRCcPHZQLqJFNFXTo4Okha/NWDYnuC/
         ftRfdrZD3HL7EXCpntO2mc9FmBTiM7H0jvX/IqqrZJKr1Keo1GN/P/udYehIBdOoRgkI
         ba2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564798; x=1793169598;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Go5/h6FVonbcrlXkL4gMkuNu7d2LqHDLKl45lEDPQ6U=;
        b=F7Ko6i2auNV2KInfbwh+XP8xuJz9v4Fh8f7dKtd2GdfNvvpCC95RBmXtrndh5Q15kv
         beoNitpBqYgALfTg0qWlqu7/WBOZV90xM15b9y8xabDD05Q8bdCLYJOez3wBbxCvEWWU
         4zg4jeptMf2TpT/UZRDrULdpyNCEJ7eEdmFdhQetIyyyoHD7H0fM7+94KeydoRKsWD3t
         0SlX+beAntEWTuIvEpdadXa8bEHuB06yPLlQbPL3NaDFXi+UTBeU1ww4qZK+Bq7ZBTiu
         ZC+DocsRG/oKlLSSriYWvkRo5dc+h7jEAZ3Z6Nd+FtdMCawfxEuR08WEBih5KHg36v28
         YJsw==
X-Forwarded-Encrypted: i=1; AKwUvBwKYc0HLOMxBHP/ygHhGhF/2AZXp+HNg6V2kmHbqssiXMUWhQWuTYXkRss1wVQnbN3uutJyXEA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUtnVgr2Agvjr5vNWW/deJZB/lnDJzRkvVo72+Jglwyy35Ql8s
	nou1AkvlbfzXMoG1R2yiSh0LSzqZnZTJOyzzgVqtI3D8j6F8QKlEnYgeCmoWo9vIJNhAUvpL3vx
	XAqPE25EI5RBLXU+G+Qz4rStDwWuXKEkdwWBbcOmjNbt8Vd7wLFYE9v/hBH8=
X-Gm-Gg: AYBFou0kptZyMVAwEZ4Iz0pycdtQv9s5IxlmTAzO2IWhM4AYx+xZ/pV6Fbmx2549M3G
	Gkf0uNkDsal1tHvejnsOdhr24TgQaZHLwzFe4sWi36RZTg4MGlc8Rh0c1KBDrrxyzA6mlFJFl/Y
	lsj9yXrOAzikTFlrAXTyN0vHtPIgYMAxhGCkGEj7EI8lyX4Gq4ZzQpZ6zJwmMPIa+WstwzK01Rf
	7ivB1khLjM5k0HkoD1WFE0y8+JTK7DFmNzhCIZn4M6MBYK7rAWnREWXEPsn7nlzXRixvPcbwA/H
	Nmxp1NdDDAyF2mWZ350eRR8FY0v0y6Ym59HXF0absoI6Os6JWQbvT0G9Zraf0/Q4uWHsFIMsj3p
	9O62fKraLClUerA1JfhJKL3HedfcTqSH3J/8=
X-Received: by 2002:a17:90b:4d12:b0:3a0:c276:1ec0 with SMTP id 98e67ed59e1d1-3ad86d50c08mr1005120a91.28.1792564798353;
        Tue, 20 Oct 2026 23:39:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4d12:b0:3a0:c276:1ec0 with SMTP id 98e67ed59e1d1-3ad86d50c08mr1005109a91.28.1792564797759;
        Tue, 20 Oct 2026 23:39:57 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad82f0c0b1sm1163101a91.0.2026.10.20.23.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:39:57 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Subject: [PATCH net-next v3 0/2] net: wwan: qcom_bam_dmux: Add restricted
 DMA pool support
Date: Wed, 21 Oct 2026 12:09:42 +0530
Message-Id: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAC5e2GoC/4XNTQ7CIBAF4Ks0rJ2GHy2tK+9hXFCglkTAQktqm
 t5dwsaNxs0kL/Pmmw1FHYyO6FxtKOhkovEuB3aokByFu2swKmdEMW0wJ0eYpLfQCwvKLiskaxT
 odQbV0bZTPSNYEpSPn0EPZi3wFTk9g8stdMub0cTZh1f5mEjZ/8MTAQxsoJ0SXErBm4uPsZ4W8
 ch9W+dR5EQ/WkfxT41mTQ8nKSjhLePtF23f9zdNitNZGwEAAA==
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
        Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564791; l=3014;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=Wm437G/2TEyo8uw1Mal26euONCvxGzUjWUp+GjfVFiM=;
 b=M/CCaVJWr7jkoQByJ6f99qQqnw+PM+8ClscrF859MYpuCSFQk4sJdg8/ie3XKEiXGCeODGB/T
 AV44PtlB15lBJ6cIWOyHCONbd9BSecCHJuQeWKMkIxZTAWBhXey2229
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX7Wkd46KkTgxz
 7TC2fOehrmctmkE8xj2YX5HAUmuAAx4ChEPzwKfGlP4Z50HCWASMntiMm2BK0K2p1ZGLmYImUz1
 X6rkfmpCXmRhZXrtVn9SaV5CmpW+/eYE0xrYDwt+PswUYGcjGc3rHJpQxicF+j+2VUY7OVGoE2Q
 p4M3AbBQUg3YZHgyZ5w+gDxXQFITDHA5ZOUBeDSOlykICS9SGc92J9O0eWJjN+HQNVDru8aFQRK
 iuBtN4/XwWxj9rR3Vk8PxGHvfoF2buK+r0svPNYAtrGaSH+BiVUV9QRWUn5ZvjW7cO8a/2exgRy
 TVM+4guuckWu28TMHYOnICV8Ks0bGj4VrKwVNpBuRYUKI+46inE7M48MvlV85KG7yNSQsEseRNf
 GJIekTi9crawmTH2482UJEeqI0kXaw7N/b4KRitKcmhOG/8+eHR5m66VJ0PcWePDu/BLDpkvkUv
 5RprsJgivvRk/OXs6HQ==
X-Proofpoint-GUID: tGNPLLzvlfGsYYTAKE01ODTK04k8LPBZ
X-Proofpoint-ORIG-GUID: tGNPLLzvlfGsYYTAKE01ODTK04k8LPBZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX/KyIMGGPKowf
 WyxWQ4jQKT0XdHVgLXr5rRSLsX4iAwBslkJWkLk+78rbzMiJRzqOJYjbvGYZM5MukKAh5EFlx5p
 NsLUaO2wAVBcv4zx0iwOnqhTnI6NF+E=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad85e3f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tWlRu96VJg_J4rp9qAYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210026

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
 drivers/net/wwan/qcom_bam_dmux.c                   | 119 ++++++++++++++++++++-
 3 files changed, 152 insertions(+), 4 deletions(-)
---
base-commit: 78974bac98eb0581f85aab56ccc0377cdcedb964
change-id: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1

Best regards,
-- 
Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

