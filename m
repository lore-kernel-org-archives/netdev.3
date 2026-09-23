Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FD35E1BD;
	Wed, 23 Sep 2026 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129912; cv=fail; b=FNhFDdb6d0RXbzXaYjPMSub8wjbkk7vnb+KHwzb/hhcJPHACS9K+eJAGYCllm/V5UJ78hGsYSu50X+dsckfh37k5kS0wno3mrU91/vAwJbsZA4T/InGBgoGJ2ez+mivsZXjqnC8/kHvp5PEEzyLVwYSoi/Ckc7YwjgSaMIPHE38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129912; c=relaxed/simple;
	bh=/KgzCk1TzROHKFOL5M85O8zfuCMQ9R3gwR7WY3uxPsw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QgU//bl06Hsj4kI4W86dsrRHGP7ULAU2Fo1+aNQiFOJJ+qmwlLxsk2gC5F3/miN6cmkUsaEtiCNC8h/IHRrQ7qM3tKdEISKElNEAoo3q+QxjuGlW1ldBW5Cix+AonFnhtBrVRnWCoayFXXPWf82jJvw2Q234jc/rXCcl0kuy4mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YgLrBG5X; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YgLrBG5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvHVOoX6V7tZ5pFtezqs9MqMEh79qPSFYnHLiSkTKTuhr7wJMLd3ypbkeHnL7meLuYGdRyTDJDmutkF2C/pGHFTqmzUjfYSe3FCJaAET2WWchDbVl1I78Szib1S0ZPMkRpkryjf+VzWmSC9R88gnW6UAROcf4BZsryiqF4a768QsDY547GIUKjKmiZU9NDGPuvf7D8FqNI6RX4jlu2JdeOXoXXqTbYreJ+EthCvjsQZ3s+/J/OQMWHNuPmpUiJ9SdVwJloycnGCG9WtGHPtT36C+9adPvkYxvZ4CwJ4OvakHD3oCbLoqul+sYf8Yomxr+wRSrIcCVLa9HiQN4VgYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxVuqy7Ej6xFaLnHjGHZ9EHljZv9Z/etyuqD78MyEOk=;
 b=pim2fGZKx2WAGHTjv9nGxo0NFQwE0VCcKANzUr0w98cl6fg4NqqopxHKJv6xrH2BSEPrc78afMtz3a7jDmEXtWvKtYMuJqfEDZIpdT05lSv0iVkIy1jvPvutk6/HAwCVwyWe/1MTcTqRpUDzpAc/zeqI8PYchcda6jGryq4hT9yvUFJP08yl6xn9ksyL11iYXqj3ajRk9/vGyZGwcbQQpLEaTcpzsxvF+OfzoOybE33ij0ZKby0W8dEWwEXXIPfxYegieFJjKgVSRDjxpVekmaKJxxDzi6q2BiHayuPwsCxeFYD/QxJfg6ZdfO3imSQDXQp6fO4GS1ErFqiuN8dMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxVuqy7Ej6xFaLnHjGHZ9EHljZv9Z/etyuqD78MyEOk=;
 b=YgLrBG5XfAO06XFa64DA8ZUVqBEhLfYSa2Y7Z+fn2cKA5NBNY7kwEV94lbclUwjGQ87vH7HZmyInioLIo5Ho//crpsd4A9ef4egm0ZARic8D7ofYHvGkyRavaOCbxHiinkDpsCPkcyopgl8bsP3NSrpVNgIVgdHrm2gS5eo9GAcC/ca0aOw4SITaRF0ZJYurzRvbJyhXHjNGT/G5HC7yxDpBMBCsg8jwp41c7susgbj+Rra1VOqqsTb6XvOWSAeqZBoMcDAhYhR+qF2LYVKnbZKeicJkZDqGOHV4YFttYaGlgGGJDCtYCgV2vMoqi0+jFiVK9kFPyHTZKe8y93N9ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by IA3PR03MB8024.namprd03.prod.outlook.com (2603:10b6:208:50c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 02:18:27 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 02:18:26 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: stmmac: dwmac-socfpga: Add Agilex5 TSN GMAC support
Date: Tue, 22 Sep 2026 19:18:21 -0700
Message-ID: <20260923021823.46649-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|IA3PR03MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 814e3d8f-4321-4353-69e0-08df1918f342
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	g5AwDpBKdu3WydFbS4921WLO1RJTAfJd8NIjZ9w2NHuUHc3gsQx9bhYvMXDh4hnkcGsxY8SF130gpwKUp2jK0rDyZ2NvhtVji4vbJKUI3krI4YQm/oAmuDrXo+caRq9/GJ7p+S7DO3ggZxeQpOjpbF4nFvwInv16Q5PM9hsZV/4mt1dBm+3Fw3lg9FPKhfNbXcny/6tudcFby8KsmYOxs0mDyY86BB2nPGmw4fOqvR6/q+6d+JXzjgtQ0NwI5ApbMcTz+WpdQj13vXJ9B8caiL2pAARTJBRuQLU9aO13W343UUCkWqP0mRqZOaBBnvpB5Y/6B7wOK46IWllS1Z46+CsjsUTZ4rTUER9/RO8BUR4dt6GyoYCZwwdxOVqd1nCb+qZmwFYZf/h5eeDqcBhy83VAVNfGYfDVJApexeZ3+hci0nWo0MvEINEDlX3YpVw6jQZI99hrTvvXrIvA9UaQrobebXSAmCITTmPbXkWrLJxPxppAME9DhUcoGhrNa6atkVfEhE7BqU2OD6R35MWlqqSphtZs7MhYwEs/1AKASiKPkCuXt3JBWFGxcPG6OZowpMZMtZ4hGdhjJTDYN3bHqk8BNK+TFSVbfNAAyJxWlWd0q461cBtt8v2GTfFxkIYjwVl9/W6cV5s2aLuVp5iLxivfzirxWqBDeuOnvduePvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?58HMZVphuSS0BP4SZ1aW267qWqy28aQZl3SvYtzjbzhUBauVg0wXy+ZjmPRP?=
 =?us-ascii?Q?2D34ViXvnWtYP4Cv2Sb7nKEXb/reeUyfXE/WgjADeNPLCPdSeogfZsbLglm6?=
 =?us-ascii?Q?f9WmdTEWrFsNqvDC5A3EExMcEGxVXKfYKlnFumb+/Zn1jCgbpzUXwROjQU0H?=
 =?us-ascii?Q?7oH2xbwYe/0jT58tHXa9XoV8YH2N3faIxfMuYyNW3VAKNpqaWKL9qDG8clHo?=
 =?us-ascii?Q?5Hprr6eXw1HJlOz5IDzbUDDkWSkFREspPZJxuyy+W5/1gHf9KIh6ntASAeHw?=
 =?us-ascii?Q?LKuqz5ps+7yvG56dTNLigD4UMpDnV78Z5lkIKixfeZm2NRs/6JpDGkXlxtfI?=
 =?us-ascii?Q?a0IwycMwNiDFkR4PfSk83DMTVmShJyQBeEro8Bfr9yakv5gbQ/3ZABvJlvXK?=
 =?us-ascii?Q?ig43QMx5ryCbIfH6b4DaLCr3jmUzHOfVKh4rpPtlYBEacwDXTpOlb75zxZyy?=
 =?us-ascii?Q?qb8E4jJtfUlftefNY4t8spBVwEJ7X3+XSBHbi5XDy8YE2vKlM9nrtWX4WeKQ?=
 =?us-ascii?Q?nymm04tRnJQjGlQ8DfNABZ4is7tW3i1bZJO75JxdK+n/dKui3Pwyu9yvvi4G?=
 =?us-ascii?Q?8Vwd1BDnNNYhB0HIb6zIdSYVwvHSKNjZuV0rtsZrL4Pm+07qhUgo55vCgia1?=
 =?us-ascii?Q?CGS6e/1nJf3nI/cbdUQgL5//+0V+CGS4JWkCbrnPuFeWVL0ZABQXLp7+Z92c?=
 =?us-ascii?Q?8TRP+aOvBXIlIImqrTRONGgCvXMHqzj6sLMkvFAiEuXLtWRVOWYEmOEIOrHC?=
 =?us-ascii?Q?hlttdY745juprctqEB3mazWXF31zPNHxeS0OCXP4nkb6QTbysBwZoh3pIYUm?=
 =?us-ascii?Q?AoBVThKHSThFzItp1JsEvkHaX9HwLI94dJH2H1g3/p2wFY9qtBI1qtwZHrOw?=
 =?us-ascii?Q?+ixGVnHkh3HNDBhzpInveKpiHcnmIiLGgRLFQv4lhwjqYwL3SJnn4qATrFK+?=
 =?us-ascii?Q?VT7XcAra2iW3+glPEGwJjm63WtTjZiGkAvNunCDPEr9vDLUkCTt0xiO+QqcH?=
 =?us-ascii?Q?CNbq+anh12I/RuFTe8l458e4TeBfOn2+G5YB2o+rcNhD4hrpZ25bS2+K//A1?=
 =?us-ascii?Q?vkmUQqXHuU8I00wy69i7gPvQLDO6bpMclDoJC5oW4JXo2dBQLPa0iMjxxzBJ?=
 =?us-ascii?Q?ibgMXj+BlAE7LSeKnQcWOQXCraOVfTJBZhOs2IRPPpQHEkYYxhBRpWQvxZbK?=
 =?us-ascii?Q?2mS7XMc6yePRblPt1HpRSCIPwJMRmJ7kfOkd1fDYQfwXGi9cwoq2gVOwMIBO?=
 =?us-ascii?Q?TlY54KbPLRsOS9H1KX6uHEh4qdzyXTBgugTt5EPd1VXtb7q6o5Ncyl8W/FQZ?=
 =?us-ascii?Q?yqIukNlkfPQ4UnnCusOy04EDxypwBUU4bmru1VOYLw0nxEJnJpH2Zvx+t8es?=
 =?us-ascii?Q?/j06mNpf/EjE63TgsATQERXh9UNEv6zN0UNPqkHvCnH9x16pIFfysrmRXMBC?=
 =?us-ascii?Q?cQ+MBhWHQRpPypcjIP5NbdfSIZ0lzKBdm8VywljBOm5hWM2/IumBpV7Ty+ha?=
 =?us-ascii?Q?vVMjJM6g9sn5YDvlNvg83QPyQwbdFzNNNNFr6dhmKH8+oGg4OYFGWnStK5v5?=
 =?us-ascii?Q?XijNUKWjiozaXDvyCSwYbM67VvLXbPQA6Mf+sSBW7EyVCpcnZK6fwbrEXP5u?=
 =?us-ascii?Q?kOCRhBRqcetyEAMSmDaXENTWzngz3CFCKhD7FhZWZrUo96tGrsmvxURhkgXi?=
 =?us-ascii?Q?ZXFffSs2sVn52imdoQoewUz1edC3tfjQl+/ew1fkLdHD2HOBLFLIPu+HOx4N?=
 =?us-ascii?Q?1ELB/OBNacj9yB/hqU+NgYZCdrVeFCcuf3t+/dBB4FeZZe3bxwKNL1Q/CFH9?=
X-MS-Exchange-AntiSpam-MessageData-1: BbIJuvgTao/aJw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814e3d8f-4321-4353-69e0-08df1918f342
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 02:18:26.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5O67sMLI3u7DNH+4m1rcKHARDdgr6LnGk3f25yZGtcfYZyoOaLFnKsuXB76L+aUzbq0MXUzP+cuEU2NxdDk40ell3K8qX/rfKknLBee3AmH4E3IC1j5LVgQI+g9JDVFwvkQ3fQmb2heK8ZmxYVf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8024

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series adds support for the gmac1 TSN port on the Intel SoCFPGA
Agilex5 SoCDK TSN Config2 board.

The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII converter
implemented as FPGA soft IP. This converter provides the RGMII TX/RX clock
delays, requiring the MAC interface selector to be configured for GMII while
the PHY-facing interface is configured as RGMII without delay duplication.

Patch 1 documents the altr,socfpga-stmmac-agilex5-tsn compatible. Patch 2
adds dedicated match .data ops for the required interface setup.

These two patches were previously posted as patches 3 and 4 of the
"Add Agilex5 SoCDK TSN Config2 board support" series (up to v6). Per
Jakub Kicinski's request, they are reposted here as a separate series
for net-next. The board-level binding and DTS patches will be sent
separately to the SoCFPGA tree.

Changes since the v6 board series:
  - Split out the networking patches, rebased onto latest net-next.
  - Add Reviewed-by from Maxime Chevallier on patch 2.

History from the board series:

v6:
  - Put altr,socfpga-stmmac-agilex5-tsn in the same compatible enum as
    altr,socfpga-stmmac-agilex5 in the net binding, per Krzysztof Kozlowski.

v5:
  - Replace of_device_is_compatible() probe check with dedicated
    socfpga_agilex5_tsn_gmac_ops via match .data, per Krzysztof Kozlowski
    and Dinh Nguyen.
  - Drop altr,socfpga-stmmac-agilex5 fallback from the TSN compatible list
    and rewrite the net binding commit message to explain the hardware
    difference, per Krzysztof Kozlowski.

v4:
  - Add Reviewed-by from Andrew Lunn on the driver patch.

v2:
  - Replace mac-mode DT property with compatible string-based detection per
    Andrew Lunn's feedback.
  - Use phy-mode = "rgmii-id" to correctly reflect MAC-side delay handling.
  - Rename compatible string to altr,socfpga-stmmac-agilex5-tsn for
    consistency with existing altr,socfpga-stmmac-* compatibles.
  - Add DT binding documentation for new net compatible string (new patch).

Nazim Amirul (2):
  dt-bindings: net: altr,socfpga-stmmac: Add
    altr,socfpga-stmmac-agilex5-tsn compatible
  net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA
    converter

 .../bindings/net/altr,socfpga-stmmac.yaml     |  5 +++-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 23 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.43.7

