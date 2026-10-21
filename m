Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564806;
	b=hGP93ObOBPXwKV2b8kjhVYDd29x1hSb37zbTr6QIR694CK7M78+8vQ+n+g5ui+rh+Ja1
	 138rX1igrG+vKY5z2R7MB8cEeB9JKpzm0a8ha6wXN5SZ1JEnuhmumwfLsg2lYIfzglp75
	 RL3KjpJGzH4iROSSN37FkUWu7BlwMgzbAV8YDzCKuvg69XghI+veLA3DjYL0uwMjUhxEh
	 BR+QW6Y6e16Lyyd3/ZIZKksqYU2ivC3GOxbvROtLqOgtio+BuK6rsOg50bh+vcsG3qxIl
	 wFLEUk32hDwRV2O/47VvXg3kQbkGBaqIFiTRIl5HBTJutlcTzxATmVBfCAb9MX15rqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564806;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9xGaxJuBomS0ZcA/d6E32VSCGzfFIwUHw6NSEAEPgy4=;
	b=zbPb/e9Oz9WxZ/l4xYs5nWK8Zsu7jao36BN3gjMRCLNIt6/zQL/2RgKYh95X47JZlqlW
	 +I8UjAN8aAGiDKan1KX1v2jPG7lT1xv/zuAdN1m2EWnDhGxmSEKHZ5a4if6PXsM0Y27uz
	 /R/nLq8jS3Bt9biLvWmDb42PUBuUSjoJdtImAzINKaUd1wmeKjr4PQYFpcewHiEKCtMVA
	 1j94wWkx1WkiLsj08uKigvSLHN4NMD62XviBJF9Qr48WzMmxOY/jwLZhjlOORg5qz36LX
	 dEHSWlyiix1mlc04xV3fvpFxX7y5s8fsoRC/44fpK/PgjnHifqnHZwX1aPpoxZXzjnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GzQVn2af;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FsQluqQl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C27606A31C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C27606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GzQVn2af;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FsQluqQl
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j7sL2411465
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xGaxJuBomS0ZcA/d6E32VSCGzfFIwUHw6NSEAEPgy4=; b=GzQVn2af4SZ+1aG9
	YDNcPFj+QGm+2SeTuamJD9faEAL/7Qw4q7ddHKcXIFx2VCq4vQqu++2AKhn6gcHz
	HI0zgrwsPZTfPDdJmiYy1/xdfMhM3aMmZaipiPQMUZbIbclaAO3NkEnL8OUmHpZ3
	pXY3TcwW7/eFoDoJXeutKtMkD9NIpdjgQubDuMXqYSXGEwTTWdftjoW0v7/Zv1UD
	WQKMTyy1UczWCsHq4kY4se/4vyCblm6FppDfEQSQyNy7ny/VcB0NwQCyUiVWPgq9
	8URlvStwZuNqdio3TuJo+DitlsoLRF35DcU7pcF4pXg9iHy8AXe3EvoTe3MmR8IR
	9rPIDA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvbufs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:40:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so452197a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792564805; x=1793169605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xGaxJuBomS0ZcA/d6E32VSCGzfFIwUHw6NSEAEPgy4=;
        b=FsQluqQlUeMEkHAWlgJXuDZKemNUyHyJcq/5NYZ/64Jx2muUJ/PUe3rcTLxbCyGIpy
         kV87oFtH7trN9M9OE8ug/1lMz0MycDmoqnemTBm774fcte0/XoA4RKCOu/o+0dj798vX
         nZohtbeIrrL+LQbzTszv4Zqk09EoZfLxokrYZFKWE8T/8RH8MaxgiN1ST1AdxvCAnyAJ
         HiSUR6iZFKTYcT4YkSQGxGV2ntsvua68xesJhVebTVBMY54SHsKP+9EqtV9h1+WfB400
         /7WMNl3/fmsfEXWaEJimZ3PBCUYNlf2YARnx659SM2YKrWOvwHB5oTGCZIJ6I7wPzs7i
         DMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564805; x=1793169605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xGaxJuBomS0ZcA/d6E32VSCGzfFIwUHw6NSEAEPgy4=;
        b=dUM17uNpE7NkKHB+EQhOKAGiTD92mhb2SzBXjoLtYp9m4F+dcFRfzDDZ9FSo+P55xI
         UzBMiRGf7dkPdtpUAtMSWtTDVuptp3vII5VZdm18YNXyu6KJI2v4xZn6QWU3/7O9XYeX
         Z1ZoFVXdRIF1ZypfBSXHuwPmgx2B+nGSsBOeN4Aw8HppcOGi5MUGOl2ExiNcHMZHLHen
         EIeustbuOXTxPHYzbx7HL5HD+2NwLQmY/UjcliPKiUZLKrnvJUFNg+THKaXfNnrpl/N/
         iXvGOa0fianhCbXPT35BliazJkOTg2Bo/dIo1WG0GH8q/aEjlSBmXFSS6M+IHH5w3nTD
         Rqsw==
X-Forwarded-Encrypted: i=1; AKwUvBwn2A511cTlZb65R3VnWoiNd0wbuhdwJUz+YNQqG8pwvuGLAc/RBc/ucPNa2gPwEVdvDlxml5I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbFkgJ3wua5HFyzNtUbqXaieOiKm+g0B3xz0nNiVXD++MKiaoa
	aTqiesfqTk+aIohaL3qswiYNw3GmIcBVjV/Elmo8J9LQq3xATTwksvaDFsfldt4khM9S45fcWvO
	gf+XtK/AyyKQLPjyRyUNIbxHo69aumLfvN1bqma4QQV5u5Z3LBFneoI0dWjw=
X-Gm-Gg: AYBFou1+eiUKpQNE1TmgoHQkf1rbueQ+Qvuh/vGp515r3QCn6UDGu63uRs34xf1xY8m
	9Gzwl1YhDFNaCXXGxQcOFmsHpS94U84xaVfNgUjrC2P06V6xNt1pbl5VYcZoy2fumkyKO+g6qlv
	hl/jQ242iN2Tv7l8HQ5z4g2naqnjPesU4S+i7vMMzGAH0BogzobcDW5bpvyOOBDe5LLVXEDPvD5
	L5x6HpJgStZs9pMdB8FKGohs4v6zETc+iPRuImE/tNTGYRgPQbkRnwPJl7Gpl/iPPeD6Abc3CQy
	Mkrz/XdwoAQcymaZN5d8PCC7pHC+nCzUGn5NkSmI/amwQ6ZkclNbm/a1DTf3r6kSUzqJHq6PRsQ
	6h8hg5RJqzac84EnXCzZPYLebqyv3ksXoULw=
X-Received: by 2002:a17:90b:2886:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3ad86ed22e0mr880864a91.26.1792564804632;
        Tue, 20 Oct 2026 23:40:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2886:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3ad86ed22e0mr880851a91.26.1792564804142;
        Tue, 20 Oct 2026 23:40:04 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad82f0c0b1sm1163101a91.0.2026.10.20.23.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:40:03 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:09:43 +0530
Subject: [PATCH net-next v3 1/2] dt-bindings: net: qcom,bam-dmux: Add
 memory-region and qcom,vmid properties
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
Message-Id: <20261021-qcom-bam-dmux-vmid-ext-v3-1-cedd1f681102@oss.qualcomm.com>
References: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
In-Reply-To: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564791; l=2584;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=+H88cOWbCsr1Tojb6ZNHvvkjVXxKmA9tV/JYivC1jLI=;
 b=jvqnU06bPNXWGokvta/iNg5fJLjcazoX8uHlm/aUb/z/8bSBNChDA7YL3K1sf7iMBoDvfgFk4
 V3alficaPAhDo9Al8/f3faCfBrepXb06z+NeHUJUwuRMx7KtAcwJSqO
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX4TARnCMhKp6i
 Qy7PeYeEbrLysUb/FZg29E1HcxDKQ/MDrsSabfc3qtJayJ0ngirJQzonVkhqBlBc0fiYSoLx0/f
 rVi34QZGOyRfjPBFeAJjKfz7E/76UNdjAM9JRgRZMmLAHFdIgXzFMEY7kSUn2gYTUSqP346L36Z
 L46Ud+NNTcMxfT5jhyzpqh2kPXvX0TDCyNen1MbDCpYb3FlDfDyYZFRrYciBxW0vuosPVYO1j6k
 w1f2PSovPPS4kM2/rNumAdB6VLfSADv/sHVaPi/UB1wyTteXRWDHqlyeA69VwR2/bfiKYZH3c6S
 mNvPLX56PbSqJTHdntIcpOH91Hd0BbPFZJfj095h/NBSis9WSUZodmU5Oa0DClARWtWUSt60wqg
 snq7QhPaGc6J+dXbar3h6q5LKAVoSiPRdu/ezW8k0Vnd2duNvySQ6zW5qCxMfa6RwaJyoEMt/6y
 CzyPrphy3PKIyHxgKqA==
X-Proofpoint-ORIG-GUID: y6PdMXwNXl3Q-K6MESE2921WNjEXharh
X-Proofpoint-GUID: y6PdMXwNXl3Q-K6MESE2921WNjEXharh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX3IQgZSr4NmA5
 75F12s0jFNp+EPgpa6DbdgF9CgFQraMJ2IxoWvpcfMcNqIMsk7Unj5gWFSJMBvlZRRTk1RgxlbZ
 nRu5TE6oa6tSqbI/eO0+l+yxxWhNSjY=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad85e45 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=t_mNxi-BVxZHgpyDufwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210026

Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
domain with restricted access to system memory. BAM-DMUX DMA mappings
must therefore be constrained to a designated region that can be shared
with the modem.

Add an optional memory-region property to reference a restricted DMA
pool used for BAM-DMUX mappings, and a qcom,vmid property to identify the
remote execution environment that is granted access to the pool through
SCM.

Require memory-region whenever qcom,vmid is specified.

Add the qcom,shikra-bam-dmux compatible, with qcom,bam-dmux as fallback,
and require both properties for it.

Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
 .../devicetree/bindings/net/qcom,bam-dmux.yaml     | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
index 33746c238513d72366bc52359fb10f275475b331..f7388d24c8612b5a99d5d0e66cfbe2de3b1c9e0d 100644
--- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
@@ -22,7 +22,11 @@ description: |
 
 properties:
   compatible:
-    const: qcom,bam-dmux
+    oneOf:
+      - const: qcom,bam-dmux
+      - items:
+          - const: qcom,shikra-bam-dmux
+          - const: qcom,bam-dmux
 
   interrupts:
     description:
@@ -72,6 +76,22 @@ properties:
       - const: tx
       - const: rx
 
+  memory-region:
+    maxItems: 1
+    description:
+      Phandle to a reserved-memory node compatible with restricted-dma-pool.
+      The BAM-DMUX device uses the pool for DMA mappings.
+
+  qcom,vmid:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
+    items:
+      minimum: 1
+      maximum: 63
+    description:
+      VMID of the remote execution environment that is granted access to the
+      restricted DMA pool through SCM.
+
 required:
   - compatible
   - interrupts
@@ -81,6 +101,20 @@ required:
   - dmas
   - dma-names
 
+dependencies:
+  qcom,vmid: [ memory-region ]
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,shikra-bam-dmux
+    then:
+      required:
+        - memory-region
+        - qcom,vmid
+
 additionalProperties: false
 
 examples:

-- 
2.34.1

