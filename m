Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793541671;
	b=s4DHTKa/8ycZVDU93CwPJW2ZLG96pg6E7B8NVvybeKQS9X7O8bz3WZFd/RZAWNCGGHpK
	 1z/niu+v6t9VeBDPWZwOmmRae6uAEig0Pws7aH9I5Bm692G86rc9vqocg2snhe1s+XouC
	 Fuq7QL/ww0Mj/GF5XmM8RqCBxKDaoIj0JJqXnvKXe8Bm+A0fE68vudB6D4PJPBh1LTChh
	 oZEBYFQ+dY1exoTplf3wniyP2S2XvFpXS+Vkfn1QsXlgot3OY5h1JZrLtBl0SUmYimYx3
	 OXyYzcpespqnI/TB7QkJ2mjPWHckUNNPGwmVEEJKnRJ0g2WsDC+lmtwp6OXWnVjirMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541671;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TbKaMzBpYRYTjd4ya2VmiEvOHH15Pa5kX8JfwHMy+5M=;
	b=cIKW1erobgUVvj7aojC8lwG4Imr3QVGgXrtbel/SG93Ulkfzh3HSiH4KUUSUhquNlUh8
	 eg2OGnqbsG0DXr0ZGzrY9jCZIPMZzv+6lCB6AaCdORiyc8bVwse890cFiX0ISOFvPs3SN
	 rxJalFCMhH07j68O28CiJXygV66WyifVBxh2FGKyajCmXbRSylHAkiLf39aj4L37MIYK8
	 DOmrIwSH0muolIwDwuSrxn70YQj0QaC6Nwyqhh8C2VgG183m8yCX2p07xquZ3fq/jkuwm
	 9SfCn3dmqMsxx7s++chXiw9TBz7z1CJer2IuFL7nNvhkjBOCg7qiEtptGyIjtup5TYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=axiado.com;
	spf=pass smtp.mailfrom=axiado.com;
	dkim=pass header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=rdpqnWPZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.72
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020072.outbound.protection.outlook.com [52.101.56.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F5606A324;
	Sun,  1 Nov 2026 14:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B71F5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=rdpqnWPZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm1gAQN17S5hys6cYNpQoJbSInDe49pk/C4/Qi7QoIhZkfzU9I07OLMGIGARKd4zhmOSGyCLw6Bt7znU404vB1QCOmWRaMtOglWW3qs2UpTE2nH09dw3athXhAdosF2on8kDpMPrICLUPoWk/He7Nv6AonXA+pMqgrOIz0YBjjIkFmv+Bb27L7dEID7dzj2hCOtoQzhtlTqmbT0NAlGT2HG47mTrKeMMa6PK+AH2GNB0O+22a6b11iGG4fzIhzp+minRdEyyS13VJPjtHfOExeidLk762q6/AbAob7plH9M9Tj2hoO5eCKlCd1EofaTwvHMT+nr4p238beEQcBis9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbKaMzBpYRYTjd4ya2VmiEvOHH15Pa5kX8JfwHMy+5M=;
 b=cflI9u5bvrCYqHF9PpIiWrs6MiO/nK/XkchZ/pKUKdy5yxgC3HEnJEuBViu8VwTeQxjoln4YM8tpVHXN7Eh2fHu6mdQNej8nIZiKRdzaP+DmPrx9EktGWBNcZPoU3gSO816x6qWQtfnLIvGVJUzw3BIeTBwZzbelx8W5dPZ5ZKNr2a+KCs56fIzLirIhVzbB+Wu7O++Kr0DSCDuPkjga2tlptxv+Ql8TcD2ZTR6h/tLzH0nwRmOToAjbBpWcliAWMj2hWZN9ok191beQu/Owg14mpiPjWltKF5/LkzLLbYXrH33zyQ+8zchFfUBMju+gtoo84Yf+3t+yR0EVF9fQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbKaMzBpYRYTjd4ya2VmiEvOHH15Pa5kX8JfwHMy+5M=;
 b=rdpqnWPZYOPLUwv0YXn4c2i7KsdOoDaNMGOASsOT/u5EOfs1OKs78CPIziCuEskZVBBigXBdiQEo8i+UBBsGuhDSiT9E/W+pUAsU2O0GEyGxhrseuA491Z6lUUrMZDLsSlXmzFH0pvhmeLBoNkey4NXbINJTtMsLWt7NTJO0m0JSeuXdejHdLkRjHeMmiIUQOOjsO8aAOuWPmnVrfVVKTOwY5l0m/N2vWRRUxpz331lZw/78pPa2Zpj0oyNg1CekPRMwxdUx21R6jpnfdqNrXDjEP40A7uT2VncnLYoIXahib0Fp8a149v++THHr2eUKOo4tCIwJaQ3kRegjqxqbGA==
Received: from MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28)
 by SA6PR18MB6150.namprd18.prod.outlook.com (2603:10b6:806:414::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sun, 1 Nov
 2026 14:01:07 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::4) by MW4P222CA0023.outlook.office365.com
 (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Sun, 1
 Nov 2026 14:01:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Sun, 1 Nov 2026 14:01:06 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id A15A24186B58;
	Sun,  1 Nov 2026 06:01:06 -0800 (PST)
From: Akhila Kavi <akavi@axiado.com>
Date: Sun, 01 Nov 2026 06:00:57 -0800
Subject: [PATCH net-next 1/2] dt-bindings: net: Add Axiado AX3005 IRoT MCTP
 transport
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-mctp-transport-irot-ax3005-v1-1-36ceb822f01e@axiado.com>
References: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
In-Reply-To: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
To: Sammai Chakravarthy <schakravarthy@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tzu-Hao Wei <twei@axiado.com>, 
 Karthikeyan Mitran <kmitran@axiado.com>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Akhila Kavi <akavi@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3629; i=akavi@axiado.com;
 h=from:subject:message-id; bh=P0qovBVjx/IH6h3UP1OG3u9hfQiCFlamMEyG5D7j8ww=;
 b=owEB7QES/pANAwAKAaZBpzlrM+NgAcsmYgBq50YhA6Oq4d7UMMUKwN0qICz2v/kqzxettq+wU
 IWSD71pUf2JAbMEAAEKAB0WIQQZuAZ2jpLwmauYGXqmQac5azPjYAUCaudGIQAKCRCmQac5azPj
 YGTcC/0eRZxP/e1ay5ftqdv4dYbNgPeXyjEiVe+EbA0zCb9+46IazOy2kbl7xIVCXNEKLB6fDQF
 qRnbbsmwm9aRzu8O9iugiBoC2IsufButr3a3eHRMnIa18+FJprjo24uC89cjLtRtStp9JO193PE
 FrU/Q1abzuKZTN9nqTfoTukAUEn/OFsMOHbNhvj7tAw4x3reC+/UK8hDsha0F+XkScp4x561rhs
 EwZEzYeCymvfMtLS9gLukRJHBzk8E15ujmEYG5+5U0IkzwauFxdkrxFZzv+mqqUkH4giIT+qaiK
 TFU1okTLS00oaS3iIQ6e4/9SrGpnHzF+KF0lVPnwrg7MjZrDxCsShwOZgUwNm2PItaqvHlTC4w9
 Avtp4fk96/IBb5BkKmqGQMrJEGrhYu4OKh3Ez2uCHVxexo/7Us16ZwK3ODvafb5g82wu65s7GUd
 UMkdTH8p3/4eJ3eiP1Iv2yHIT3JCWUf2UuM3B6MQDwZLTfNQ1x2p53r77pcjfnxhlOMQ8=
X-Developer-Key: i=akavi@axiado.com; a=openpgp;
 fpr=19B806768E92F099AB98197AA641A7396B33E360
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SA6PR18MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 84846bbb-3b77-4b41-e544-08df3820933a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|34020700016|7416014|376014|1800799024|36860700016|82310400026|921020|260925022911599003|260925021311599003|260925021911599003|56012099006|261009223027099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6mj4jz1tPqKKGy3/9LxEGkGDYVCr4xjLRuIkPxdEpmzgKW+tEVT3U6bGMFJvWp+qSNYUJJbshkcnMzHWOvKBaOOd9FKy/Z8MYouOdcCY6KMrvPuHYSEozfxG89DxZdIWhpKuOFYb8sCxvQpo7c9KMBybQrZzRyJzcYnFlrj8e+sVoehxuP2/zl49K9e0S/m7W1MVaNWcqvScAd0LN8nO5ttexRTqwh8FIpYOp7Bbg737BjDgdtC56fKW/SSfpwpqNiekIe8qYExmnr+ZxQofNtg9LNj29YTM+EW8Qtt+PFj2zjbVfUTBH7HBlICmtVX2u+c0maEGG5hKjMbS930yi1MJW/eM9uZl5XLOPhCzhAmCsErSQpPJQ5XNS74fd8gMPnV8z97yFxmWWGpSx+duXdcIJB6jef/JK1KLAXHPr2SrheTh4ihBg+fOSzwLwQWlKnslQ02BNmDCNaTj/mSCuBlvFsAz9OVSzBdmt7LugBjxMN+KW65BlJ+MG9ZUsggNebOFncvoLVPErjf11I0AWgCQNjqE0PHkswA9anTLWKWKzlwPnsGm4kUEdg0QCXA1Sq9wp+VWZmakCUTs5/WPULRhePiQeqb/XRcCA0vu6CKkk42Yacv9ZgUzON2ziHfv336z1HWjXWOCG40exRWWWToQXePb0LVIdfLoOB4k24eSUjIAEBW1ubeAzkVc7nxvH5VfZ4JEILB1B/yticYisw==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(34020700016)(7416014)(376014)(1800799024)(36860700016)(82310400026)(921020)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4RTJM15kFGI7QbMPHb2vOTChrUeNNIBt0H0eH0vamaTYF0QrUp2JY6kHL/OqJl2bHUV9UaUQJgFRUDaK5NAMMqETlinDUBYSKp51Iz3V8efn14CLyU6DXFQAZrIbd3fTrocNP0PaXnYGi1GPwYR7Snum4PS0G0+UjmCEn6hr28H52xd3Awyo5iPHvv+lJEvpkC0nv9/uiStRykcEMjNETTgijZ8HhgTUXjaTyIL3JMlg0KuzBlAGgCvMULsHTkzbMRzB49RGG8GW/W25z9IX5zCCNCtM6XG/wnFx1CCV4mvMMvZuzpkvFnOJA2uXNNPsDNS+XCyqssiEzF/a+VJovia7zKvQFhGPWrQage/k0KaPoFuUAhB5+P+L9UUCIluJkgZeB7ME4c/9oaLpJRvoo8Fkz3TR5ihndc5vdt3WuAQUSzn7rJrNv8aPNtv/kkMb
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 14:01:06.9471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84846bbb-3b77-4b41-e544-08df3820933a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6150

The Axiado AX3005 SoC has an integrated root-of-trust (IRoT)
co-processor next to the application processor. The two exchange MCTP
packets through a no-map carve-out in DRAM, and use one channel in each
direction of the AX3005 mailbox controller as doorbells.

Add a binding for this link. The node has no registers of its own. It
describes the fixed pairing of a TX and an RX mailbox channel with the
reserved-memory carve-out that the IRoT places its packet windows in.
The IRoT firmware chooses the window addresses inside the carve-out and
reports them at runtime, so they are not described in the devicetree.

Also add a MAINTAINERS entry covering the binding.

Signed-off-by: Akhila Kavi <akavi@axiado.com>
---
 .../bindings/net/axiado,ax3005-mctp-irot.yaml      | 60 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/axiado,ax3005-mctp-irot.yaml b/Documentation/devicetree/bindings/net/axiado,ax3005-mctp-irot.yaml
new file mode 100644
index 000000000000..795949a4444f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/axiado,ax3005-mctp-irot.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/axiado,ax3005-mctp-irot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axiado AX3005 IRoT MCTP Transport
+
+maintainers:
+  - Akhila Kavi <akavi@axiado.com>
+  - Sammai Chakravarthy <schakravarthy@axiado.com>
+  - Prasad Bolisetty <pbolisetty@axiado.com>
+
+description: |
+  MCTP transport between the AX3005 application processor and its
+  root-of-trust (IRoT) co-processor. MCTP packets are carried in two
+  shared-memory windows, one per direction, and a pair of mailbox channels
+  act as doorbells: "tx" (processor to co-processor) and "rx" (co-processor
+  to processor).
+
+  The co-processor allocates both windows from the carve-out referenced by
+  memory-region and reports their addresses at runtime.
+
+properties:
+  compatible:
+    const: axiado,ax3005-mctp-irot
+
+  mboxes:
+    items:
+      - description: TX doorbell channel (Processor to Co-Processor)
+      - description: RX doorbell channel (Co-Processor to Processor)
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+    description:
+      No-map carve-out that the co-processor allocates both MCTP windows
+      from.
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    mctp {
+        compatible = "axiado,ax3005-mctp-irot";
+        /* AX3005 mailbox channels 0-7 are TX, 8-15 are RX */
+        mboxes = <&mailbox0 0>, <&mailbox0 8>;
+        mbox-names = "tx", "rx";
+        memory-region = <&irot_mctp_mem>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 360977678f70..b16248974044 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4477,6 +4477,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mailbox/axiado,ax3005-mailbox.yaml
 F:	drivers/mailbox/axiado-mailbox.c
 
+AXIADO MCTP IROT DRIVER
+M:	Akhila Kavi <akavi@axiado.com>
+M:	Sammai Chakravarthy <schakravarthy@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/axiado,ax3005-mctp-irot.yaml
+
 AXI SPI ENGINE
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>

-- 
2.34.1

