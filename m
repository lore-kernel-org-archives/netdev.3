Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3E340260;
	Thu, 20 Aug 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235948; cv=fail; b=Jet4YM/77gmG6lK9mMt6TUfr1OZkr8T6hJWwZR2JrSQIEtBd+hSRbNcckWmYeqgyLFzvZaKV1byk/spaQkF6r4pMfQLOuiuk1kxKw8GbsGv+OYvC5bS7raDUKdfi1J7FR/5WfsvYO9CCpBpvDfwioP/Hc9s+Oof5TpclBHgD4TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235948; c=relaxed/simple;
	bh=5aXG619uyH9hPGrDtIUMWZqHOOqE+RbrxiqrFL2Xy7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GDlEgT6SG9TWQo/L1gpPaOemvjj5r7/7SuTC1iCuQoeOl7xNaERJ3tzVE6YFQBdSJ0uWXSqupfTf2Acvexo/BfkNLxyCCVB6K67aojTCMuwhhdvszVdz6pW5jFms3c5J3bW93UjKinxWOPXC3losMytYWI3GNcBuoQWMLnn6mgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=JgPRuqcm; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="JgPRuqcm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX5M8PmZo1knEHFunUprbyJHOaXwi1UovvhnHByzcqV/3N2NjpGZDgAa7J4GXNpP+B3w9R3CwsErAe1yYR8Q8xfdTnIlGdZmxHdiMPXCMyIxAIp11RMauBW6jgQyzvoRv+vwZCQb8HbnWEHTI+X4/dpldvDX6aL4enTEzvD8Fkqzk3yrN+3Z6n/Urqqxu5utm654AVj6VpQMH5T3srBOgDxFY0Sb9iNzV1iEZOn/HPNVJrw9c56Ufk2f3UrK9UybIEX4FYFN0jUl7zPxWtbYNTJWmXqYnqCFZXUWRWcRfyM9k/5Bhu0wb7bG3miQS3tkecCljWiHS5k5mLk3hEpfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMdZtsUkiUrAMFPasHn2Tk8zqqckvEdW8zr2JkKxwQw=;
 b=okzUBEqXH885Jz7T4I53/DFyPb10N/8DxhCu8WZqKYo42VnDMz+QaCLT2qwEYwdSXwJMjaX4fEUAcZm1+9AyCNsFa1xVKS9owfkvzF9ND+8ScNL+hWUenzS3x6XNItUloMgnHNuMOONGap/1rHjR9+C0RJnGKBwgI8tJad4W5WTW49s5whLFuasnHxgA96Fem1RDBiHdkaMhmeCd3dbNxyGCDR7KXg5yDqY2rC+Ypc8a5gYCRvkxTanwmX2HKJAZ5M5pTXUvvBEulv1H3XG7MWDaB8EZYz94/236U5siMcwj9eO39jO4XS/WOOQZfdW6UGToLCNTrE4mO0s0oeE+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMdZtsUkiUrAMFPasHn2Tk8zqqckvEdW8zr2JkKxwQw=;
 b=JgPRuqcmWvfORuYdgPaG68W87mhSPOKn90YEFt4DWl3GbJAzB4TS/Qx+CbwoI0GFZmmu2Fkfqr5N3BI68p+1+txXYQE7Uh6onzWXb1U9nLXaK43MbTKY5PujKyZKkapyCXiVuqVBkRMeuLHIhsrFS6H/A2llm2nObFkevrS37eZitGJP8NEHk5IolGoaUTm7pKt2LXvI1u4qJSNWRmByT5k2SBsJ5InfE4lMkI/MH8nptBeYmuMqRsnaWCkti1nXq75lVNMpx5kRoy5ep+aTKGFW8X7uO/3GV4IC1Jx4VYEyypxX2UFykAW65R/Lhrjg56AZN6VKPLeDt/HrtoiWcQ==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by VI1P189MB2600.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.3; Thu, 20 Aug
 2026 14:25:41 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:25:41 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Kyle Swenson <kyle.swenson@est.tech>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?Roland_Kov=E1cs?=
	<roland.kovacs@est.tech>, =?iso-8859-1?Q?David_Nystr=F6m?=
	<david.nystrom@est.tech>
Subject: [RFC PATCH net-next v2 1/2] dt-bindings: net: pse-pd: Add bindings
 for LTC4266 PSE Controller
Thread-Topic: [RFC PATCH net-next v2 1/2] dt-bindings: net: pse-pd: Add
 bindings for LTC4266 PSE Controller
Thread-Index: AQHdMK/H4sHRpwAA2kaN6PafYQKwZQ==
Date: Thu, 20 Aug 2026 14:25:41 +0000
Message-ID: <20260820142429.2285172-2-kyle.swenson@est.tech>
References: <20260820142429.2285172-1-kyle.swenson@est.tech>
In-Reply-To: <20260820142429.2285172-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|VI1P189MB2600:EE_
x-ms-office365-filtering-correlation-id: c69c105a-481d-429c-c82a-08defec6e9e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 pdXpzK/x0as8tGED8rysy4J9q3Jvc3+7rD37ydikzHL+i1wSkQryrRwx2djs8dniKjZLLiNNRXsRjYqCHi7MlEI7hPABkV4Jbi/OOnWu+CGuEopSEqnDh3oTuo4lKAHYSBovUW4Kwgxwepa96Wluq7f0khJZ3hM9linQg/QR+/UmrdEhUaflISGkmxlcY7BHYUp/Lq6ap9xloHfrYa8kv5ssfLDtFTeul7JlyYKKn435Gn97skBgz/oEEeFy0YOB+LwaKoVdoV2neFEnyZswocSSkeYSTX4QOB0B9xcXB6jvNFVDHS5PXAzBQCFgnr//XLUAkTULAcoInYlwtsp7Br5kTvVEo/scOtqB/4D4JcubKgVPgmLkXpF7BVyQX7U114pLO7hkDr7L15BUqjfkozK8BOL3Q78ZFJpgg06YhyuPA8ljYjopXVNCJ1aZMGh7D5PcCMWS4Vx6oRrMfatDp5wSZnjbogfU36omPI1KjQNk/zfME3kaIetRnpbs9/b7XSLksfcah4zEx3gh8xfULmVJJHptbnId4CByBfNcUCRzs6fJqde9IOAYSJ0auazDnlvc2vJPw/btfbWlyybXnqM0pxYmqvTTQr40Jzgz8DktPiGXjdlbdAUIDexhQFrMInIXLky+qYsOnqvrSOfb+0s91RQTNljmoGs4iE3gMf9cr8qQSQB13jbwm+GcqVly
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HqxWGhYoAsdKNR4k7mzdxd762uaU69JPCjtKpZcODHTOeABsOvyWs5COoJ?=
 =?iso-8859-1?Q?g359bE/Kcu7STOlpY9L97cEBT60Cua6ne1/mviQ+nwzEhe3KglAJtU5ESk?=
 =?iso-8859-1?Q?3YNswj9LZw+qlBFJEARePNDy+0RCf90LfRJCS1dh/oynNROa9PC/qvRQ/c?=
 =?iso-8859-1?Q?or0S9OtWKmG++qVZ6eiMJEUDIVY5mvDAYjXzZIYiGM7y4+nk4mECTMqXRu?=
 =?iso-8859-1?Q?g/caiO4n2JlHHMAhuDPta+f6vAVLTNI7StOmrG3H80TkYFEvaJJxrfPm6f?=
 =?iso-8859-1?Q?xXsPBe7KQ++UCgubWxdq8+j1XeeHu/+llh1wTH8cqfWQERPCK3QwYmocb1?=
 =?iso-8859-1?Q?ebqIHttX2Y/kssbUDqcCS3rkBFeoW5/j9F02DcRlLJNJbudNRuLiOG5wzJ?=
 =?iso-8859-1?Q?uDjkOVcoCAAsCtb2h5dkRMr7iCt7nWZzN1PtS37dHKNR4dRUS5XznTTUdW?=
 =?iso-8859-1?Q?jYkLe+L6ouqW90KlyZGVfl4ps57n9li5SD4OjXPu/vX1h9dyIHIle9PHir?=
 =?iso-8859-1?Q?edgA+pYF9WVKpbi5ifoP71vzAeel2bBpfoKQCrTBGw6A3Os29xVc7y+N4m?=
 =?iso-8859-1?Q?AatviIC7egP6tOVSYOtmuszgCpLjmdkPGFg9IqUpKOmHhgOn/987uTgttf?=
 =?iso-8859-1?Q?X2FxyMFmNMMJg98FsWw8pzb99bG+ZjQ0kqbL66gcrmDW5u6XB1kR2SF5dJ?=
 =?iso-8859-1?Q?KmbPdSVLG/ZkcY4uDiuSPlY77gUkV2REY1Jss70wRlM9Eb0ilZFoJ8gHtz?=
 =?iso-8859-1?Q?9zgOE27WGoID58oZuvtsnRbWnAW6BUu75JokqcctR068iXI4XXGO6/BLQ6?=
 =?iso-8859-1?Q?8tvesSOyGF55y4f0IYw6wZOE2I57aUZg+XQBRT1W3p9CO0BawdEswuone3?=
 =?iso-8859-1?Q?aYT2oJuAReXAj/YVw62BnZhi00GwbNQSpSh0gAuE3js2pLhhSJLRHxW6Ti?=
 =?iso-8859-1?Q?Gq3zABmy/O2PIipkJZjn8IYlYPNmXGwhFIO8tmPPfUF521NMNUUTL0hmzk?=
 =?iso-8859-1?Q?QrcWXDEuHGjIsvf5p8W5xxrnXkCb3aVrmjLiwlQeKi7LQP2H+fVKyT39tn?=
 =?iso-8859-1?Q?JiA3i0SqK/dmW7EIseEVlHKh9le2oUyfA2mU8VPLNrkU8NFF2xjjT1SYsy?=
 =?iso-8859-1?Q?eqLFOFH4B5w489n8c12t+e9sHJd/SKy10N8HW83EtQqWaIBgmHKQJhVNW1?=
 =?iso-8859-1?Q?xIS0gz91sxbUzZ2EfRul471tEIPWiJxhfIBgBmEK67JifqKZGHyEnpGzk4?=
 =?iso-8859-1?Q?kwTMQIxeQDlUqFa1JmuQkfDf2TjlliBOzFO6ttFLj+sjuO6Zf8Gywp+71s?=
 =?iso-8859-1?Q?dlY2OpmNJWyxgoI2wryKUCB07W0Wz3ROUJeBBIn2ZnFLeLOVNKQPd2yMlN?=
 =?iso-8859-1?Q?WKFFtw+E7TGj+MsyhJpVQJn3/2MQVyaNFDoBueJBWoPIHbxWZsarTSt8Ht?=
 =?iso-8859-1?Q?CahETAWEM2n8LVbCsrxiL1DZNb8fcZkJH4ToieFuYOIWZL6mxc3FLRyXnZ?=
 =?iso-8859-1?Q?AacGgsXBhQl+iL1A18/+3CVtciz4/Q/TU2/IsVc6QATdNfnIXBx7yG+cLR?=
 =?iso-8859-1?Q?xWcuJBN0CQEinB4+4f2oPS3GyGxZDpQ4am/T5nZpf5s/Ax5mGeI43/vz5G?=
 =?iso-8859-1?Q?alBdwx+4zJthsYz/47do5VmGZbOHri1Zs1chCguI5/vho8H6N+JFinq1Bv?=
 =?iso-8859-1?Q?ymO0DPvgT/fjI2Xfw6nMRjIA3CQOLxIGXkB1COIFvvfUpEfB67DqD44+Bq?=
 =?iso-8859-1?Q?Pdlw/Bo4oeUG/lA77GpCG/adEzQkocOm5AsKGh2UWXZZinJ4Ai6cTF/gkL?=
 =?iso-8859-1?Q?SrTsSHC6ng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c105a-481d-429c-c82a-08defec6e9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 14:25:41.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oh7nP+sHNY9TeuDepPIl4LuWP5Q14ZMNsWHDfR75itUQgs4G++jDLLY9SjEBVcuwIrdPoy71W+10CATzbmIXyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P189MB2600

Add the LTC4266 Power Sourcing Equipment controller device tree bindings
documentation.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
---
 .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 ++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc42=
66.yaml

diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml=
 b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
new file mode 100644
index 000000000000..b3da8fea0b07
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology LTC4266 Power Sourcing Equipment controller
+
+maintainers:
+  - Kyle Swenson <kyle.swenson@est.tech>
+
+allOf:
+  - $ref: pse-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc4266
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  channels:
+    type: object
+    additionalProperties: false
+    description:
+      Defines the 4 physical delivery channels on the controller that can =
be
+      referenced by PSE PIs through their "pairsets" property. The actual =
port
+      matrix mapping is created when PSE PIs reference these channels in t=
heir
+      pairsets.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^channel@[0-3]$':
+        type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+          sense-resistor-micro-ohms:
+            description: Sense resistor connected to the channel's MOSFET,=
 used
+              for current measurement for overcurrent detection.
+            enum: [250000, 500000]
+
+        required:
+          - reg
+          - sense-resistor-micro-ohms
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+  pse-pis:
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^pse-pi@[0-3]$':
+        type: object
+        properties:
+          pairsets:
+            description: The LTC4266 delivers power to a PI over a single
+              pairset, driven by one of the controller's four channels. Th=
ere
+              is no 4-pair mode spreading a PI over two channels, so exact=
ly
+              one channel phandle is expected.
+            maxItems: 1
+          pairset-names:
+            maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - channels
+  - pse-pis
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      ethernet-pse@2f {
+        compatible =3D "lltc,ltc4266";
+        reg =3D <0x2f>;
+        interrupts =3D <8 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent =3D <&gpio>;
+
+        channels {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+
+          phys0: channel@0 {
+            reg =3D <0>;
+            sense-resistor-micro-ohms =3D <500000>;
+          };
+
+          phys1: channel@1 {
+            reg =3D <1>;
+            sense-resistor-micro-ohms =3D <500000>;
+          };
+
+          phys2: channel@2 {
+            reg =3D <2>;
+            sense-resistor-micro-ohms =3D <500000>;
+          };
+
+          phys3: channel@3 {
+            reg =3D <3>;
+            sense-resistor-micro-ohms =3D <500000>;
+          };
+        };
+
+        pse-pis {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+
+          pse_pi0: pse-pi@0 {
+            reg =3D <0>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys0>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse>;
+          };
+
+          pse_pi1: pse-pi@1 {
+            reg =3D <1>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys1>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse>;
+          };
+
+          pse_pi2: pse-pi@2 {
+            reg =3D <2>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys2>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse>;
+          };
+
+          pse_pi3: pse-pi@3 {
+            reg =3D <3>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys3>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse>;
+          };
+        };
+      };
+    };
--=20
2.55.0
