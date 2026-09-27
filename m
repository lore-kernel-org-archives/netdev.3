Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE83C455B;
	Sun, 27 Sep 2026 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790544594; cv=fail; b=Dl7MALiWoEW5v5ZR/zrcNn+93HPDIcb2aCO4zr9DnDTEkLyBionDSUXF8YEaKNoD4hatKgC4c2dzgejZ2NOuP14iSfSOhBPB9fq6SoxmLJ7fmzCZgFtsX1ai7n+s9BJIMG+HzvjUBnEwucsRlk/dNVYYRDn/IDCSgAW+H4SMC0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790544594; c=relaxed/simple;
	bh=q/aGJzwGYsf9RO7TFR7EqcS8hVe0jyzkVFNXQk6PIio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJ4Z/SRbsvG75+hpkJapm6ovyRFThWs2oDgUUfElh5NahLfelWjYIAbt1Wrwc+I11jS1rQAzvZOl6di8I2UeYBP50N+YE+NZwt6+9QBRvNv50vnt6s+xvWrxlT8VTuBkE0vLmGCEgBpYMy7WWTgX9TJiFXORqC7QmFkeMK/qhjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=LR8SbpXt; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="LR8SbpXt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwk15VrcHUZOgwia5tlrZ0l0FwmreqEvL1qoP2JoxOey8MmxrVk+No1wqjCfHztMjHjV2Y5LTUy0n3Tf+3fKJl2vmm3bTie1bYJa2Bl8LADoDqmDYLfRQAVYmK9HLLh7nUxbsq+fzxGFOUoTD9Y+itrWG04jlDvfEfJCDW3jkw5zELQBaR+USCrId1Edx5I3mFRIcHUjuFPKBOGtupx1nVUtWF5d/DyAyC9UJZJ5fU5oHW8I150PJnZAGg5exvFushBY91+jkqVjTRIReQRQqoVydPVSKqkcFBtiH7YU0mJ53iG1FCszz+97o+sIOUNEJXsu4bQe+c2VT/7xjWUl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpMy0NiTCFlIoKUdsAhaP5jGJUkWBRUcfevbrp4XzqQ=;
 b=RuC2X4+dYLNmaMzEXvGpuJSWv2pw7dQGeYlLRg9VHlFtdYsaO1rD/Zn0DVNmvBbRAiriu+duqn0kByOrkMIo7Qkgr1TKT/y4wVoOpw8Q8Agl+eQtgeSJG13IqXYxCQs2EteePQFiGmcDfhPtf+R4AfRJuk15gG6aKt6Yb0wXUpfT9KWiDbDH4kUnaY245VWSSJgGIueZ4JvHIJOtz1c2zVDtz+EWMtJa39S+ltXDv8zjbD12QX5WrzWm8j3xLvRo9DvHHjtaQWumAt3fpa4m6izb/7cS1wRzc5Fkr1Iu7Ch4HGjGLlKrIXlSbUxPWAG4e+qh1CVRpYN0alZ8rJbqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpMy0NiTCFlIoKUdsAhaP5jGJUkWBRUcfevbrp4XzqQ=;
 b=LR8SbpXtZamd4sAC1/1Mc4LSVfnsMj3YALeSJdChq5RLFYdERNfbWA/Cd0kNYg2KzKCbKfyj5FxjNPuxNyaYRa269dK/uy504UtoxIpvs1jJr7CySsaQzgCV2jRfjvoLfQr1Xg9puDJ/3usbfzZH7OH9Jvt92nv6mp2hw0xsXch4Djnjho0stDffk1xzPXGY5pzZiNhMM4zwzNaHSDUzjHNLoAJE5h8fAafnAa7yXnfvo6LLYmk8nqj+I9qs1s8UeWlrxe+ERdtyi9lbmieHYbTBwa6RjVM1wHpmXlEyQ7EQmdzefGrIhZlySaPh2UpjGEEHUS+ekVvOaIPR20qidA==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AM8P189MB1282.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 21:29:48 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 21:29:48 +0000
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
Subject: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings for
 LTC4266 PSE Controller
Thread-Topic: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for LTC4266 PSE Controller
Thread-Index: AQHdTsdSZejWFg7FL0SFdqli66xuKw==
Date: Sun, 27 Sep 2026 21:29:48 +0000
Message-ID: <20260927212929.593366-2-kyle.swenson@est.tech>
References: <20260927212929.593366-1-kyle.swenson@est.tech>
In-Reply-To: <20260927212929.593366-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AM8P189MB1282:EE_
x-ms-office365-filtering-correlation-id: fffaa411-2e84-41bb-4f00-08df1cde754d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|11063799006|56012099006|3023799007|10067099003|921020|18002099003|22082099003;
x-microsoft-antispam-message-info:
 CeVxH+jKPFoQB0RXIoW7iF+8oyyeAK6JlE5Mm5nyZL0QSn7Bx3GAQyZezphKErS9OroqMC1yeyVFnKmzUX/nvOglXHfnoy27QkfYYllT5pMTlzQIU+CfWspTiW533NqT/aLiIZqvMhcUCXZiwUKR66MVBAE0Y48Mio6/Sn5XfzhRsOcm82S758opx7HhGadDWLra3QK4eTRdisgb2jApeL/AOCDFmE2Q1ynu3MKLYLonzfCFlFU3Lc8Y79BGQI5dbcVe0baxcQM84nttXWJOMZ2YgYfCYrW9hY/ZurncWrg66ZJLgHAJcAwIWd/mNcWkiWjawJmLY69DM+pF22RVOYEG7cBcMu+FWs9lzciHbePE0F+lFYkXl541QFjUTzibhL7eFr2cLWDMaVt/G9Oe9ctLKyPWJsK303GCK6Gtu/zkfzs/TgIyFefO4GWk1LYmvo+M2Q2jkbR4Z28XEjrxAkPgkCTXGIGFayfDOgAIUTSkrWeoRc6m7etcQFEgdMZn79/4WQEDBAJH0JkG8/YfyM4MHhDLqm+N+mF4rYnkLcaXm1OKei8N8Il+DVHsp9u6+xU0BZ/VtS9bwIeU3hKV82Gfd5GDogw71j9Hph6UPXUVFIND8IysVydVBmQi1oKDY5cIsb8EpeIZqwlxvazOzccetsdzCVTB7hFUIyuG+nhXSfZZSFsUBLHAU8ePJL7B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(11063799006)(56012099006)(3023799007)(10067099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vCoEbboILmtyN4rXiZsrQhq0NaJe8u2a+QYniR2B49bHfchR3wOYF3hsp3?=
 =?iso-8859-1?Q?MgawIUFOYSf0Cupfh+sPswKrb8voDJgx7B28ZXtiQsebRGruPPTU0LTrZY?=
 =?iso-8859-1?Q?Yre6NcMzb/j3Omx6FisR13dZQT9eSEsXXCLOfleA/cFXKyy7T8aS9F/b7H?=
 =?iso-8859-1?Q?FjJSoGwS3KkoSAB1AVqJqAZO4qqJgGowiONOkYyRe6a/76pHIO0lRm+HC0?=
 =?iso-8859-1?Q?Uw2JazHI6QKPkRDqGGJcRPAiVQQNGs4Kz0Wjqxth7Dks8UfGLcjEnMocu5?=
 =?iso-8859-1?Q?sygMOhPWNwnAxwg6iH4XyX4Xnov95clhtRkI1H31BCVebmXZRVWfBOcss7?=
 =?iso-8859-1?Q?rV9jS8RAUA72zSoodPJWLiTGSYZIRgvdJMvWEh6Wb1duJB9rsSPRh8haTj?=
 =?iso-8859-1?Q?wjd+hMr+SVXa3mCWpYviPc/PzZOjE6dW7tQV71usoicBXEv1mcELFIZAiU?=
 =?iso-8859-1?Q?CFn/mPLziNABsZcjFIvZjDlAwtsLedDFc0vSTO0bhPu8e7EOMmPFFOV1Xh?=
 =?iso-8859-1?Q?aenrgsDW5ImNy5Te/qzpvouoVST/WO7FwnzH9DZ/z33NvH530+gVFgphhB?=
 =?iso-8859-1?Q?z2BZzgXEhBWWnCyR16OAaUYUOMw1H2z31vvt121WbKSd0E89TZJ8JxcogG?=
 =?iso-8859-1?Q?JgoHAzRms38UTDIt18H2F0kNRmXbpBX2aFbX7Td+jCOYkJOFITWfR7a0y2?=
 =?iso-8859-1?Q?A5T0lO7stA42KSGUNEzhxJfaJ4cybhsBdJmBlnRodG1/UYRkD4WwWyMOZ3?=
 =?iso-8859-1?Q?q7B+f83XNEMlhDY+g2f/buMe+5mC8sVd1rbeMYIFuGjAQaH796XDfHoPmW?=
 =?iso-8859-1?Q?TgrVzMK0912UKwmZeZ4/YpkBC1Nobf4DUF6hp+lHQ1ESgUDCjbZvk9bqJE?=
 =?iso-8859-1?Q?LMMTKsGgIkfKgkhW8/LP5dlLgqGw++/qAfSpmzXmLs0ByteWquP/6QHif3?=
 =?iso-8859-1?Q?FKU3aCSyROJFg4Vp1s42kPzTOYm4DTqBU/tYmkRJS7Jd0FzsYihD6BjavS?=
 =?iso-8859-1?Q?B5Jf6N5CiIBTcuT7DwkXQS32v5T1Bg5A8N0xZ82dzk3n3X6SlJ9zM4q6G8?=
 =?iso-8859-1?Q?c2POuKTN+1HyyhoAee6PWywfznXQRIiZA98sKMNhfagOVNzbfvCBAHoyHQ?=
 =?iso-8859-1?Q?/C4MePaEcmWbue51afLBNHz5eCJALVSSyaFoxdlSIEChBDbSxEePxq+c50?=
 =?iso-8859-1?Q?AcXKTAUhcjXC42ls/zC/xBMrS9t82F6bf6FiiTDxNadMcgeWCKu0Z9HJxg?=
 =?iso-8859-1?Q?1tbL8gn0o8DaLMyrZ/q93QGRzzoo33L6jDlHK0028zh6gc8XpWvjBXj1hp?=
 =?iso-8859-1?Q?lPtUTk66vZI75B1y30XieIOI5XWw1iQa5/3ThiNqY/MoD1gO+52wZW4sMB?=
 =?iso-8859-1?Q?bH0ubschBNWkZATeLCSX286g4hnScZ8el70y5R1Uh+q+eNiSHp//9JdDKa?=
 =?iso-8859-1?Q?ZITknxxjKQkDEBM9S0O3UgWyBQQhbF9zVpoLs80O5B3tOiXoNNPtVUVKeK?=
 =?iso-8859-1?Q?KbFK7PhbVzT3GUrViImnjtRtoDAUpZ0CkRMD7aDqRUukS4r+gkXf8PJUx2?=
 =?iso-8859-1?Q?qE3NH9SryMVa1mYkfpS6AdlIre9VCmBSWpiJesfBFFM66KJYDYQYNYVa3c?=
 =?iso-8859-1?Q?dDGSyppKuns1YMnpeHM+mzWALp9+rZz1DJ6ih59CUDhyvDTvUaSLOYfISe?=
 =?iso-8859-1?Q?BV89WGDPLL1O8rxMFcpkLvY6HQXzGN/cetiSCRXr+g+UFRCKKyNQMsugKz?=
 =?iso-8859-1?Q?2xe/mFYhwal2S4rowKdtbwDCXoVyErI/op4XiSHtpcXrH2icVZsrl/PYzf?=
 =?iso-8859-1?Q?LaanFKz5YA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fffaa411-2e84-41bb-4f00-08df1cde754d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2026 21:29:48.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed70YNLKsFdtjgfkCb0MePXWhI5UEXXHPm490Wx2krjmjGiAc5URYJ+RPDdo6TmaYJssP5YlFQX8VyXvTLpEoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1282

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
index 000000000000..e11c9d601eee
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
+              for current measurement and for overcurrent detection. The I=
_CUT
+              and I_LIM register encodings depend on which value is fitted=
, so
+              a wrong value programs the wrong thresholds.
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
+        additionalProperties: true
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
