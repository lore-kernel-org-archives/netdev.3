Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C003AB285;
	Wed,  3 Jun 2026 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520983; cv=fail; b=OsskqeOOC8+w6OjFHSGDiRm08DF5ilsZqrGBtW3ayxjeY6x5haQDuPdSNb9uxcMs7twZRHYeEvBTQfHcuXkl1nkyxzaIcx2I/dAkheNyqB7osqQwJkGWt/fcjb9srMTwzcuFv3adjIrnhxyjSSpWQ7unVEOKaWu97vUwaqIW8Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520983; c=relaxed/simple;
	bh=UygMzDndGp/pbHJ7x255/ChWtC3MDi+6I3TIUFNHtGs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ASkkVUqmtSIbj41UMD0rtKai4cixyCV1fpTbAeY7S1FSyo9GaM2nP9LKbgC7FBhCpEw07KLNubTZcCGJFnWOUtQKazVU1bB6h2VRKKVg4NPqzzumuTPdkriHNnLpnKS8TTNMpZxixhGekG4JENamLgSfMzZfaq1JLJ2mmJauXb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SugxWgbd; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SugxWgbd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3SemDrjqp9iWHyIUJLT5pErtHHRHl6Im+NIUDk9yAAjgguoY6YPoSyIezwHzkvwEECq3OYcG3HkT6VQhz9kBKiHmL0xUHqSHB4vyhMsL9s2RS7oEsB0KwG0ShPXKRDNVnlQn3DfzkWVO4FKzwQU2rm9RBRAx5FBDH8gs/KmlucsdwvZn2f3rChCe7LCn4zDRFUOAVTmMNmoI+R+9U50+iOJTzmfmInRiSjltfAqdSeiEAS3Voyv4SZBzbWdFkc16KQH9gFZha/iN/m14FYgEBtk1Iv5y+yhqFERL0rT7npmBmDDKYwzNg58i2DZSSDp/+FZ06VTLvrypztXP9Z5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTHG+1YanwOe3GBHTQGXgVtvXSLS2uEFZy5djXv87zY=;
 b=hXSY/p7yOuLHlAqLRigkqrRgd9DRWt0C1vPbyqP9uvylH9AlMwqLf7H91bbnrl97fyTNj14TTHgGdklFsYoA//c9jln/nE6guqoVAMz6E3CH69WBmXbA6WcgxOtedXjLfhs0qTQinyM8SrQdUTjekc78AemZZanjhppzYuV2UnGDUNTh7cyooW1Z9Gh/M2ue1UrjklR5Hchiply4oZgUXouz2k4B5dbBDqDEpJ4rMnunsy0OMOpGJaKmkN/cvnRV0A+mXNl4uQCuij2jAd0GpzePZfj8870dCdct72ns1E/odHRdE8XipDcMiC892/1I2BEo2TvMxldw0fcgbFi33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTHG+1YanwOe3GBHTQGXgVtvXSLS2uEFZy5djXv87zY=;
 b=SugxWgbdRN8I+2RQACZWM5OVffiJN7xPie3NSChbcmV2BNHZ7LKsLuEP8AbHATtzInC6RSbtzdCeRb4wrYo+8BjJ61xVJCCQmBB1rU28ayvyeu/DNFO55DE7TfIF0QRmmVFmgjzgPECW87V21WKaIgFaUXF7TZRDY5UThlheBl235blKM6gs5v0PDRRFP004qZYKZE12gclT4iUXaX0TYa18bH2Xcvy1tqVoc4ena/8u67x0eNGPKtp6q+tCeb5wOEAJaAwQ3+FUqtnNgtxcyQJxX6o8jP4niCjPJah7CJlTIGhqsSyIytKaoNWRDVMut2cAC6mQab/ujYUVgIk1PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:09:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 21:09:36 +0000
From: Frank.Li@oss.nxp.com
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml format
Date: Wed,  3 Jun 2026 17:09:24 -0400
Message-ID: <20260603210929.3099363-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0034.namprd11.prod.outlook.com
 (2603:10b6:806:d0::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f23c23-f60b-4b9e-766f-08dec1b46ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|56012099006|11063799006|6133799003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	NB7ezXZ84U19yyyU8Rw+cdJFbSyWNE2Z6ABMKQqQ+F/GrzwMd3WRmi0LLVh3ETlvBJFoMcClY35A5qFVyG3LWXKJQHNphPmW5P+HOAjQSY2ciCbZfAnL8plSeHhxTf4Yk8JttZcrA9sH+vQ63yKZ7v3McyxwRCOENxpGq64ovUJnLfT2N9yw3xR/1/U2dVQyJ4Eu0jyTJ566+jBWqBcW1fMMtghY2njEXFBeoSWHP86w1yvh6MajotOpAGq2k8DG19O9bCC00D8qbYzkwJe4KORLKP+4pf6vWnSVOrsrKnBfnJAv/aNHM8jZ+AcHgUkEIwtfDR1/4Iyk6no0X8dhrpqIoCj8LzMWl92PxqRgw1gBeqByRSiB6+Sb3MTnv57uQztPgjCpFaW9PIUZ3P9MsFClRQlpmLp0nYhm15hALObFm03WTCXmsPMPeDJ36yYsMD3Yqo2KhRM/CAXgp6vMpFEsbgvK4ReceVR7TqIgsd2T1sP1kO+wc5eBJyiuD0Nx/eS99bIhlJ/Dmj9y1LwrtmQp3nO6c/PaUoWpAlSL+8X/fbunu1a10iqou0QV7k5wofd6YnJrr82yseCi0fnhcm6gvGJKIkIvL3/NVIobjgEenjXXENSfOf3Fpo2hrcjdQoSb1aKknIXlAN4PNELYlxbb/GLFG1F4KLks8JPYu3kXTe/3A9wVnKsaAFB3X+zp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kOB0XCkwHDsWv6zyVWPZ+ZoMDhsh0LksPfGTshB4tOO+pFRImKicmlTuVes3?=
 =?us-ascii?Q?KHt76C6j4I8KSrxgX+yqrkilv+kSXxrES3Lql4YiN+BkAAG2Dka89F21YEtj?=
 =?us-ascii?Q?37GE2xRWibHeYOUMA7zdY/BjUwPG0TcxtyVe1N+FkDe9oyW+kHOB/mzXfsaL?=
 =?us-ascii?Q?fWJMoON/IUTHvoixwhs9XdnrCTr/Mt4LzGS/RP5RzvuYJEjK00ty0XtuZLbl?=
 =?us-ascii?Q?upnXhreZ2qdFLPRJEl66ej2aN7ORolKDZ1bKgKWF7OPgili2cd3NJrdJMQtS?=
 =?us-ascii?Q?6vI/FEjIQnQ6E323oWxznsmJV5lk7lOO5n1nADfOuToKwwyDbiBPLiqbcj5d?=
 =?us-ascii?Q?p7cEsz56SiNdk6K2g4jSJRAWk0XONc0Hz0qUGonhJo8KtjG2pG+sJe37ps/x?=
 =?us-ascii?Q?V+3ObXmtT2dGgQ25Ubz4KDIOF5/vyCVjmnX+sKtSoqJHMzFCAZHzUBZ7hKgq?=
 =?us-ascii?Q?3l2Tn2TaVz4m7GAKzo2RJcSCY3i8WG3J/BYWlx+B2Cvv8/NQ/lc5rGSY4F/Z?=
 =?us-ascii?Q?uXa7xNT/FrRSFb3lqwoeQA6E/Dtb+ptCfX3TVhLO4ToFiqcOoBx5/67sHh7X?=
 =?us-ascii?Q?C1VmLDWR8p6wqsjKVzGUDjo/0KwaIX3vYbmQ2KqY4slMwGppTRAOYbVfQhHI?=
 =?us-ascii?Q?+DA1BUSP2aqC8fmlFj+gu8gDBwxys7Sq5FicMkkNHefdhZQnyVN5hlhSvMzi?=
 =?us-ascii?Q?YcVqL0WarqFNixGhB1wkwNlNTlFeHmuSFXgQdgjjYqZ+3yOwat0oVUv2IFfj?=
 =?us-ascii?Q?FK/lbatJ6PstZLRnIv0LiPIppBYel6iJK72u5ThPF8ovZjDIBeDsOlBVqnQE?=
 =?us-ascii?Q?JZxyya+foPqAbgcL+3aBQ4qDNTtaWw3zg43ajifN/CbKxYLrrO7N22D3AV3N?=
 =?us-ascii?Q?ArFkqpYL25QbUUDHAkGjWgSiI5KtNhCQpruC5mlGCCYKXG5CRQPb9nW2r3yj?=
 =?us-ascii?Q?m0a7U6/uuvnDeUQX/mOoQA+fDqWb0ZkTk2WFYd/cBFSjG+QSPz2SZD+u4Ddo?=
 =?us-ascii?Q?heCnQbaWs6lMs6mXc1eY/K+nbvlx22ExuHlQjWnKyUo9+flSZ1ooH2Ly0yAh?=
 =?us-ascii?Q?OneZbF3HUOFZQVuF6EPaVhJbKSAonIhmFhbgL74d9s1fFa22xo/4QNOkcmQX?=
 =?us-ascii?Q?EZtLzDxx7R/+J1qPqyWTbUFmeK4dFOsVvthZNIZbs5I8LmW8ExcoLC6hf3Ra?=
 =?us-ascii?Q?47t3bH442gJvF/ItTVy/T1xvInrDaR8W5X+ynh6ew5hqSIAiRs95TBGT8JUU?=
 =?us-ascii?Q?eEZi7sXgev7u7KN+WcoBtPznzffXSBqfL80CMQVIKqVeQiC41JBXHiLMXd2k?=
 =?us-ascii?Q?zFKDi6SaoGn5oJ+8ejrV4agqkQ450OO0qK0iqsolx16FJkYduOLF2amZcupv?=
 =?us-ascii?Q?+6f+nIyPhrW2e1xm41vB2J6deIxXd5m6HK1/bUB/Gb9mHOaUC65WFJtVAKC3?=
 =?us-ascii?Q?wuowg1U0IdE3gvr9Ffnbl9aBkJvuglCKZsa5+DPdHEKI7fUJuQgkoDc+nxZm?=
 =?us-ascii?Q?a/VFR4SqyJ18eJlXqhzd+9CYNN235Suql3L6TilCso0S/mMeGaltfmAm9WKc?=
 =?us-ascii?Q?R2JBC5aTkYxFTX8pEWNMN2S1NHrBLwZrMa5sYdRD6Q5nEB3jz7JJOKmBnjO4?=
 =?us-ascii?Q?OUmS5IJbm0h/Fu8mBEawgI8JvFZLnVsDXnaXWwj8Y33G+we/7G4EFDkuDjmd?=
 =?us-ascii?Q?+kfm76XrJkVhyaMYzqlBdJuqQoPdfAZrqSeooWVjV+yzEZ8oQFtr78GeryGv?=
 =?us-ascii?Q?77apua7F2336lohL/U7wPLEuiFoSaaVQDIfx5JtDHTbm/jMcU81O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f23c23-f60b-4b9e-766f-08dec1b46ade
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:09:36.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qdd5YFMjwxHd7Ew4rb/KpkOgMWWtAUmel8wQYlOxDdiougYxoLkgQxichdM+B3C5RR4bsD+3gN6ep9A8rGqhffaoSw9ba7pAwru1nVz2OXWsBORH0oQAMlhogr/jzrhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9071

From: Frank Li <Frank.Li@nxp.com>

Convert lan9303.txt to yaml format to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: /soc/bus@50000000/i2c@53fec000/switch@a: failed to match any schema with compatible: ['smsc,lan9303-i2c']

Additional changes:
  - rename switch-phy to switch in example.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2:
- fix typo Additional in commit message
- add rob's reviewed-by tags
- fix doc ref problem
---
 .../devicetree/bindings/net/dsa/lan9303.txt   | 100 --------------
 .../bindings/net/dsa/smsc,lan9303.yaml        | 123 ++++++++++++++++++
 Documentation/networking/dsa/lan9303.rst      |   2 +-
 3 files changed, 124 insertions(+), 101 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lan9303.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
deleted file mode 100644
index 46a732087f5ca..0000000000000
--- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-SMSC/MicroChip LAN9303 three port ethernet switch
--------------------------------------------------
-
-Required properties:
-
-- compatible: should be
-  - "smsc,lan9303-i2c" for I2C managed mode
-    or
-  - "smsc,lan9303-mdio" for mdio managed mode
-
-Optional properties:
-
-- reset-gpios: GPIO to be used to reset the whole device
-- reset-duration: reset duration in milliseconds, defaults to 200 ms
-
-Subnodes:
-
-The integrated switch subnode should be specified according to the binding
-described in dsa/dsa.txt. The CPU port of this switch is always port 0.
-
-Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
-configured to use 1/2/3 instead. This hardware configuration will be
-auto-detected and mapped accordingly.
-
-Example:
-
-I2C managed mode:
-
-	master: masterdevice@X {
-
-		fixed-link { /* RMII fixed link to LAN9303 */
-			speed = <100>;
-			full-duplex;
-		};
-	};
-
-	switch: switch@a {
-		compatible = "smsc,lan9303-i2c";
-		reg = <0xa>;
-		reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-		reset-duration = <200>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 { /* RMII fixed link to master */
-				reg = <0>;
-				ethernet = <&master>;
-			};
-
-			port@1 { /* external port 1 */
-				reg = <1>;
-				label = "lan1";
-			};
-
-			port@2 { /* external port 2 */
-				reg = <2>;
-				label = "lan2";
-			};
-		};
-	};
-
-MDIO managed mode:
-
-	master: masterdevice@X {
-		phy-handle = <&switch>;
-
-		mdio {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			switch: switch-phy@0 {
-				compatible = "smsc,lan9303-mdio";
-				reg = <0>;
-				reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-				reset-duration = <100>;
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-						ethernet = <&master>;
-					};
-
-					port@1 { /* external port 1 */
-						reg = <1>;
-						label = "lan1";
-					};
-
-					port@2 { /* external port 2 */
-						reg = <2>;
-						label = "lan2";
-					};
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml b/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml
new file mode 100644
index 0000000000000..42f8473538a07
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/smsc,lan9303.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SMSC/MicroChip LAN9303 three port ethernet switch
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  The LAN9303 is a three port ethernet switch with integrated PHYs for the
+  two external ports. The third port is an RMII/MII interface to a host
+  processor. The device can be managed via I2C or MDIO.
+
+  Note - always use 'reg = <0/1/2>;' for the three DSA ports, even if the
+  device is configured to use 1/2/3 instead. This hardware configuration
+  will be auto-detected and mapped accordingly.
+
+properties:
+  compatible:
+    enum:
+      - smsc,lan9303-i2c
+      - smsc,lan9303-mdio
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+  reset-duration:
+    description:
+      Reset duration in milliseconds
+    default: 200
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: dsa.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* I2C managed mode */
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@a {
+            compatible = "smsc,lan9303-i2c";
+            reg = <0xa>;
+            reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+            reset-duration = <200>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "cpu";
+                    ethernet = <&master>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan1";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan2";
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* MDIO managed mode */
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@0 {
+            compatible = "smsc,lan9303-mdio";
+            reg = <0>;
+            reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+            reset-duration = <100>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "cpu";
+                    ethernet = <&master>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan1";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan2";
+                };
+            };
+        };
+    };
diff --git a/Documentation/networking/dsa/lan9303.rst b/Documentation/networking/dsa/lan9303.rst
index ab81b4e0139e3..776572be265e1 100644
--- a/Documentation/networking/dsa/lan9303.rst
+++ b/Documentation/networking/dsa/lan9303.rst
@@ -12,7 +12,7 @@ Driver details
 
 The driver is implemented as a DSA driver, see ``Documentation/networking/dsa/dsa.rst``.
 
-See ``Documentation/devicetree/bindings/net/dsa/lan9303.txt`` for device tree
+See ``Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml`` for device tree
 binding.
 
 The LAN9303 can be managed both via MDIO and I2C, both supported by this driver.
-- 
2.43.0

