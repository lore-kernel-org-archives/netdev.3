Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875367;
	b=cdOad0dQRYEWpsKXzsXUnjqxfJnIiRL2pEYtZRlLxrDLTddVwBP7B05cPVOOKGWK4Mns
	 cfbycm1SLTkigJ6eJObaX2PDZ1S9ICWLiXGvRu7z17Ag2CWgmYhkHcZHg8fKgBrajw9m+
	 b9I4M+2Tzy19rtFR6ps9af0CQFNK+BFnpLaY8UNasPzeLYmF5kSRBLQeFDqreEjkd9LKg
	 VdUsMeBhxUyzrKh1aNZyXg3xboYTiCd1JMO/jYeMrlzupLWXwBCIR3TldXq8pBBNA0QFy
	 EN2hbcR2lnyPmL9icm/UQS1TammVJLCNKa2qmGPWqRARZPvhywXyBVFwdLeRfK993dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875367;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xnlIiT/rfVkZ5TORtokGoyofx/3bXHZA3Md9PXbjv8I=;
	b=M29L7wU114ZMqYDxEjIySeZD7IF7imJDNiIOmL7d1lu9BV7FngkinnFmUuCrS/Y5rMqX
	 1EPjaEzcppPo3VOGkxUxf/ESomSVxmPhm7jpXjh+zhqlRj8iqquJT9xcuYzgO/92ZHB+o
	 XBuQwcmGkl9H/4FnDJqaM3ATa3VI7LXywHrUBy1PP8vTqnmk9g9/ehe6F8TbiSg/oJDOF
	 PN1duHM5KY2uSFS3huYZkvonQ63eFNlpj3SKS8e3EHmz9Xz+ZsgIoMxWhYetSCcM5syF2
	 /H33tL9KfNtkf/gCS2/ZQYPEjFy3Tnf5FVnKNTCrnCKteGM+3Q/FwwkFBxs6RxKg+NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z76WYQ0f;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AcbanGyT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76A606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C76A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z76WYQ0f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AcbanGyT
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tFdV082962
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 10:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xnlIiT/rfVkZ5TORtokGoyofx/3bXHZA3Md9PXbjv8I=; b=Z76WYQ0fBdzKMnZ3
	EBZSU9pKtzCZFSskDI10CiRrou9s3Z6q/lP1Ix0YFRvUuSJkxOFB0ZenXrepQUxl
	WiZ31reclFnicFhH1/DzmqlhkA3/+XFw5vz+biznjvCAaLa7PhAsPWkJcQ4YqvtW
	X1iwXDRHLpT/aWq5uGrQRYAsnwXOoToltRVPPMW98LJJv/gpEoG46pe7urtU/uV4
	Jyy7svuk1fJx1popWTYavkFLVKFimLYmmUfp1AsUsIgbAklL6MR72PwbYf7QU8/K
	WSUpptp/Nw5JCyJUmZo7vjkaFrVlr7dfwTxVCnCDmYOCMp/ATTmCqilZt2VekW+e
	+7E4Gg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p0ayx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 10:42:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so3158703a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793875364; x=1794480164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnlIiT/rfVkZ5TORtokGoyofx/3bXHZA3Md9PXbjv8I=;
        b=AcbanGyTO8uea2hJ4ChGjABtXsFUuoG2Snp8/xDTaqdZ50ho2hBV+ZNKY6ILABr4Hw
         aSAEbyXtA03LX28u5jstp0WIlc6xxdJZkWLwYpkCGT/Svdx84BjcAgFU6+und1Bw/WC/
         0fuR14GF4C1eGMwS6pConu5C5gV6jolnY5NTjVpLyvfqbkYi3Jl0D1klVhjWx3fwMtXI
         00XHHOUZXqEhldSW+lkyCAv6w2w+D1GFB64Qz1RGj+AmoqJnzE8bPpJEJbOsaRZYbE3e
         Tq9pDAZ0ZdkqMcmUF1CecXUbAbQbk5BMuFyRqeQ2oLAzZlfTZ6sj2gd/D5SSy67FLbE7
         4EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875364; x=1794480164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnlIiT/rfVkZ5TORtokGoyofx/3bXHZA3Md9PXbjv8I=;
        b=HryDoffbtbGwRReyVGH/mV11QWaTcHrYPeMluunsX7UkpXNO8pE+FCqtL+hpF+39tL
         UEmcx7PD7CwGu/hq5CqmRA/hG0ZwFwzrLhONoYxrpI4Jnpi0rEEZV5rhYfmTkd/IQY1A
         q+1Vu0XRpxMc3RVf/p+PH44L7H991sN9BI7Tm2KKKmtgmzcLe5qG/5WtsAAyz/9DRxal
         oOCXuU1k8o1UUoJDs0ikWDJM5dJ4RZh9cYNjnsMRrG6yBWg8GftOYMh8/o8VPL+wx/oZ
         idEBZaC0HRBUG1++UicdWILoLvh23UifhLEeOlUpZeG1/mn5QtgZBe9UQS12Y+cQBf6n
         tfrg==
X-Forwarded-Encrypted: i=1; AKwUvBzIZUsHj7uM39AZT1cpBq01/6A2+XuhjKuej2k99AlktRe6/jcImlJTpLbLrr1CoFXN1LVSOQg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nZv34+X4oILRopftp9WR1DjfXAXdflvS3szHt5YY0gzMoNQrd
	4Vn6RMeRm3/mZtgw1C/JNXDVpkxWiF+Cpl/xUCwPlWwKaUV2t4qKGPd7Wj8Z9Ctc42kqrkfUK3+
	QzuVCPAersRS+nc63++N/HeATFsXAd/GkfusgYBXUxvcBUfDq/peH8pMWllwg8M/s97g=
X-Gm-Gg: AYBFou0treptpfsTksogG9OwAAcfSMC4/a0yN5qEsdcZLQHi6rgDC41F5lvdacIm35A
	HDln/nY+ufkY/GssyvJLzv1bH6esD2mwa/2/M6A8Hr7GBAyWva8ABL6/Q2GukFLJnqqZYC+AiX3
	qn1zPs+C3UJ/L1NWuMWKYp3UgoNwI8MoBjTQHVpNu5SEFt8P4+6OqihiV/XGK43UUpBF5u7Rvv1
	ViPUIIK/+cDlr/VKMp7ZpKm86CTITxHQ+xFWYe47yD25uJ5QiZWTUuWKH8ntEhtdIRkviMPwP5O
	ReDnItEp/QAw/PKoJK7K6CFA5EdNMCnY6KsmrD/+n5jzoqztfc/GZ63AQXqfUR56jhiPuJOAf+i
	lM/GZUz0TQtuPYjXjsgSKSItrYmzPGJdPcgX5Afl0PzLNuOVpjQW9OjmjZgbNmS+32ohzjvscsC
	lQnsFEDdGs8g==
X-Received: by 2002:a17:90b:2549:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3ae89847e94mr14658809a91.46.1793875363993;
        Thu, 05 Nov 2026 02:42:43 -0800 (PST)
X-Received: by 2002:a17:90b:2549:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3ae89847e94mr14658781a91.46.1793875363347;
        Thu, 05 Nov 2026 02:42:43 -0800 (PST)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31601b7sm3266934a91.5.2026.11.05.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:42:42 -0800 (PST)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:12:28 +0530
Subject: [PATCH net-next v5 1/2] dt-bindings: net: qcom,bam-dmux: Add
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
Message-Id: <20261105-qcom-bam-dmux-vmid-ext-v5-1-5c7903385b4b@oss.qualcomm.com>
References: <20261105-qcom-bam-dmux-vmid-ext-v5-0-5c7903385b4b@oss.qualcomm.com>
In-Reply-To: <20261105-qcom-bam-dmux-vmid-ext-v5-0-5c7903385b4b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793875351; l=2657;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=wycrMmj1886KQq8u+EMdY4E91b1IT2gBezsXLoyMxGA=;
 b=++srHVGYAxsuO8yRzG17Spf6XaKyDo1uiCMYn50ssudGPTYszu4ot+UelVTn8sKq+HlijIzHC
 mwZMxar2BKND5RA3RABcE3kd4/L3OOp8Ov3BJlM/DaqlZzMNjWLnhuu
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aec5da5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=t_mNxi-BVxZHgpyDufwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfX9Vf8hNyIqWu9
 X4QJtppuFRSwhUrfoIuHrrZtFmcvYwNEcefFiUapFHxKicm06e/zYX5K+AL1P1U8wEXxuT92AV7
 sEsXl1AF2/oSaIthE8jhLLyQoCWeitPY+8FRiZDeYK7TnVzwBeB65AH/aQY4T1ybrcyLMuZldct
 d+lOI+TSSp9ewfFPAimlzAynr+rUl7xO46j18BFEs2Ux9j+coQnsgLcHi/pBHDn3pCrProPzRIQ
 p66xfQwr1GeUIYd8u2r5YOC838Y4YXrEOGXiY0GasMdrUt8EHBvHr1AdfTUdM+NvMPsnp85dIu7
 ggTRbjpatpEYrRVUFSAZ9fupZhHAHH4vPvx7A2nA/oYkzCHUwsMeyrhaTyPe1uP4ZHta606fU8S
 1eZDHsfbzGts+03S4uPRAvSA+AEO56CIQtriXgiAdo7O4P6KVYKK+5n204xVMEjXetjbc7Fy2/o
 Fs0HK6nj3zewyTkrluA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfXxmEya4tpAL3J
 34WPKBWNtPVr7TF1zC44Q80cW9TR68SROPh771WaA/oShVUYRlU93Cr0viHZBWvDI2FdKY0hP7h
 pfgWSJ2aeriwNvwKeL1iyA5FQZY+oeI=
X-Proofpoint-ORIG-GUID: HizP24GHAFCW3zgidh3222XLGFb8oByg
X-Proofpoint-GUID: HizP24GHAFCW3zgidh3222XLGFb8oByg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050042

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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

