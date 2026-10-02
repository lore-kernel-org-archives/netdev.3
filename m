Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50647C0E6;
	Fri,  2 Oct 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934607; cv=fail; b=eMi8z6S8jqY3ksBteMOuc2RogZx4uCVmTyQLXAwDIcULA7E86K3X4YD7ByI1/ZrRWpmS/8GIE9j9XyyXTE1EyzohTQR4Y7a02Ki2NS0c0b1NWOHYTaPAQMVFIx9s+f3oWBVEbzuHZvj5AIpW81Y3fS42n+lrB4WirDuYLakGtZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934607; c=relaxed/simple;
	bh=O4OYzrLUHR3XKfrGLmbLlcKxXPtlvie5eO34l8oD16U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fVDNZr/4SJA5OLidoP6109gLigmU6E107YDAIhyEqbtle6m29V7M4EywNWAWdn61IbftTBmMBGoLhUYOz2a3mwHzCBnJ5M57anJnvsSVZMbTU8EaE4BqSkICUziYHJAOVMbYMulzrbmgbqPqJ3UMannfSVCX6ME9hzuc6453sGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=T6ZbaKBH; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="T6ZbaKBH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf+ogmnDJniEbE3xzDSBEFc5J6HJ2Op7N9knKfgDJfvDx+ttWIDLrhm0stKOG7NJoSAs9+llCTUa4wDdHR3+ib8e81cpd8K+w6AGjMc0+HBY8AburEy3xf1DIPcFTTDof2onmRQYQjjVaaieJjR1e8v3cbTshaI8pf+6IxqcRtxjNgN3IQpWGERhxz96d8ZSXPr5uYe28cS4rMU9qc7gwOrrWYgpjMjEFlVLBACbW9jguXq43Q+g97dhfgEBS+E37EZbLcQU8Pbpdc5Bzu4Jbxa2t00S0XCT5xNq4MvwMIRQ5FPpGhQU8ICca3RHNKH2CcNw+lYrp2OIhR21nksn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxWK9pAHPRnmuxCLh7sNJgHUQpZ7VE352k0o11jqZU8=;
 b=GQOapUCgQMRESRxwmg4rTnF9LRlLS5rUeM5oFdsfG19LjiW2tDeNV8hz7EUmBuRr+fCCdlSI+yH8a8BMADs3W7yayEinFOP2/bN9QGilvJmdVPxCBwpWhkmtyLSy+7WkfwcQT0wlQ930cIYR6dqdIfE8VLhmaTZuWU2Zk2ksZDeGjnPcoe1g1qYAIGdTWwZNyUPnfu/dAZax9NZrjngo8GM2DbFRQYJJyu+k8et9uVfkbtg0WsK6/SIK/U10uH8KHAEdGGnyhW0CfAeMkcrBK+rUDal5jQUfrW+jR0EWCH+pLoAU4zl8bflo//Yd9zeyqrDG3eIaDgrLv7FjM/wuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxWK9pAHPRnmuxCLh7sNJgHUQpZ7VE352k0o11jqZU8=;
 b=T6ZbaKBHWUsZwoWOFiYaRt26Q4haRABEq5Dr7N0SY/b8a366eDmjpSixzcFdpL5OnTKeUIIk/h7VSJVrX/3E4ba0/qoRbdzzCyJ0C8zwkKwUdPZScOOw9E5Ze46ibHOO3ls0Qd/BW5rXXpBnmXj0+mi2zZz2BKstdrjyD+42gUA=
Received: from PR3P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::7) by
 MA9PR02MB114865.eurprd02.prod.outlook.com (2603:10a6:250:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 09:49:58 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::72) by PR3P192CA0002.outlook.office365.com
 (2603:10a6:102:56::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Fri, 2
 Oct 2026 09:49:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 09:49:57 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 11:49:49 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 11:49:49 +0200
Received: from pc67698-2615.sto.se.axis.com (pc67698-2615.sto.se.axis.com [10.133.4.43])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E7D6113A6;
	Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
Received: by pc67698-2615.sto.se.axis.com (Postfix, from userid 22105)
	id DA9F058E28F1; Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Subject: [PATCH v2 0/5] ARM: dts: artpec: cleanup with the help of
 dt-check-style
Date: Fri, 2 Oct 2026 11:49:11 +0200
Message-ID: <20261002-b4-artpec6-cleanup-v2-0-8452b5d045ad@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABd+v2oC/32NQQ6CMBBFr0Jm7ZhStAor72FYtMMgY5SSFgiGc
 HcB9y5f8v77M0QOwhGKZIbAo0Tx7Qr6kAA1tn0wSrUyaKWNyvUV3Qlt6Dsmg/Ri2w4dZlXtMmW
 1cXkF67ALXMu0R+/lj+Pgnkz9VtqMRmLvw2d/HdPN+3swpqiQM3c5c6oskbnZSeKR/BvKZVm+o
 I/M8MUAAAA=
To: Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson
	<lars.persson@axis.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>
CC: <linux-arm-kernel@axis.com>, <kernel@axis.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Henrik Grimler <henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3374;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=O4OYzrLUHR3XKfrGLmbLlcKxXPtlvie5eO34l8oD16U=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqv34p0OsVQqOeKAZNnsNQl43gjT/zWTcsGxggm
 R/n4BpQhryJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCar9+KQAKCRCwB25JC3Fh
 a8lRCACw7D0mEH79gZUImlGEx7d798xkG4y/IXbSLQi7blkq9DZDb2AyyBRx3NS1ts3ZsmABhXn
 4SF85hfeg3QcD2gPR6n3UfREyRIs/QCfryJ6cdoQ8toOdgftDheOeuPkTUa/KI1f2XVrOmvO71a
 qD/pqpFRMQ0YevQKvOZmhx7qc912b9iw+k80hYznM21tn/9mbK0iytxn9LWzmjldPOgJzw8iJO5
 zb8A0beoPjpr1c1jANGCTVoMFe7N+Io117+JErhyG8pnKG/1rQvKHBen8j+97BmEpEaOumnxHNZ
 LLuFOZ+XPZOtfKdtJCwfAU6rUyawQpEGP9TMGuYYxtdWxLWi
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000849B:EE_|MA9PR02MB114865:EE_
X-MS-Office365-Filtering-Correlation-Id: ad22f10d-829c-4c9c-b036-08df206a84fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|18002099003|13003099007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tRJM1uZtUDoqhhlcIV4z4HrAeWIMySG1SvdEBhnPNChbLKfVkJW9JD7aWPY7d1V8VKoH8UU3ciNRCF6mx3wR5UOCyCpgK682SN4H14PqV8hy/VyHWwsecjmyaMNkzXDAJpuNBF9lS/Z9lwiIdQFniWrj1lMObkUF8fECQhVFxd8/B58+7TscD+p3mWUEGbed20F+cfYe6Wb9+e/dnCf/XkTHmYUAlmOWNu89v80oYcgI3CndNPCm5cSDW8L4pVj6lELLPcV0IyU5xX/vEjzW4Rn14lKSh/EBsvPS6SHiYS/6S6UpPbMClxeRG3mSWH4swkHUAoCnkAuPBeL3Io5kjQnnxIPVNyYnpmeK0Q+4nFAHY0KFhKgio0fxBzpZN8efFR6liyldY68n/045wNr41/uBgrdxEUdd5sFFjwOS4pgbVqXDrEjrZ5rUJSE/+Gp4kFpOiuZIbZQnbngnT98ZX1TCfooofqkizF42UKA8ux96zbY+zvGLVW1svBDllmO2S7JaSLTtqtwUjbVZwuUp/oB4rnEdeJMP02bzD9DrueJG5qBefccV3lBekOy8NEEbXT/ud3s6KTnXbzMkLeXb+rW06wSWoy3VFEEUgdiXnQcYO3hgLkv6Biyhk1PFBKkIPvDu1tKACevbPgNHpHhxSQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kCdGgjhTi7n/+IdBnQpIg3rWowGHb0FcZWqfSqcBZXNH73X0ZBDrlHR42PPZTY1MV8xXpelMQSKSAQlNeVNQfpsU3ToYbg/EIsSar2RNxvCnysIAZhlJp7IE7Se7ZXme7Bcqj4vF8G/xkkyw8usYlYkFeBMM899FC1AIojrkwZwt298ZQ7eY7/H/5FdE8hOZTd2xb1XvdBonFsLXwzyBc22fh3h9ugJPpKpa7pYtYxF7kc9oONI2C/oMcw1ZFXw1R4zLIJ1c4R572XNMSJfgLb7uNn0gtb7maG/oEN39S64qaAh+fs5KohvGHBjDxH2ypjdKesC+TIOVoYRiWpO6Jy3fCDFuAM2Jr4PIJoIEqwryVoxylLX7nSTXfi6pM62OJycdix+1H/QhLNJUvt2l0VtCQj17TGWdPzl22wFrYxoWPh0mdcB+LJIoAP94wVG8
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:49:57.9073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad22f10d-829c-4c9c-b036-08df206a84fc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR02MB114865

Fix most of the warnings that are reported by
scripts/dtc/dt-check-style, to make the files use the preferred
style. By doing so the files become easier to read and maintain.

I envision these patches to go in through the ARM SOC tree.

Sorting of nodes have been left out from this patchset, as that
creates a huge, un-reviewable, patch. After the patches some warnings
remain when dt-check-style (with Krzysztof's recent fixes [1]) is run
in strict mode:

  axis/artpec6.dtsi:77: [child-name-order] child node 'psci' out of name order
  axis/artpec6.dtsi:80: [property-name] property name "psci_version" is using discouraged style
  axis/artpec6.dtsi:82: [property-name] property name "system_reset" is using discouraged style
  axis/artpec6.dtsi:91: [child-name-order] child node 'ext-clk' out of name order
  axis/artpec6.dtsi:97: [child-name-order] child node 'eth-phy-ref-clk' out of name order
  axis/artpec6.dtsi:103: [child-name-order] child node 'clkctrl' out of name order
  axis/artpec6.dtsi:127: [child-name-order] child node 'interrupt-controller' out of name order
  axis/artpec6.dtsi:134: [child-name-order] child node 'cache-controller' out of name order
  axis/artpec6.dtsi:163: [child-name-order] child node 'pcie' out of name order
  axis/artpec6.dtsi:233: [child-name-order] child node 'amba' out of name order
  axis/artpec6.dtsi:292: [child-address-order] child node @f8010000 out of address order
  axis/artpec6.dtsi:314: [property-name] property name "snps,wr_osr_lmt" is using discouraged style
  axis/artpec6.dtsi:315: [property-name] property name "snps,rd_osr_lmt" is using discouraged style
  axis/artpec6.dtsi:324: [child-name-order] child node 'rx-queues-config' out of name order

Fixing these are left for the future.

[1] https://github.com/krzk/linux/tree/b4/dts-style-checker-blank-lines

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
Changes in v2:
- Squash two patches and drop patch fixing false-positives (@krzk)
- Clarify that node re-naming has been tested and found to not break
  driver's dt parsing (@krzk)
- Use uppercase for ARTPEC-6 in commit messages, as it is an
  abbrevation, and that is how we stylise it
- Link to v1: https://patch.msgid.link/20260928-b4-artpec6-cleanup-v1-0-e3b75e10acc6@axis.com

To: Jesper Nilsson <jesper.nilsson@axis.com>
To: Lars Persson <lars.persson@axis.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@axis.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Henrik Grimler (5):
      ARM: dts: axis: artpec6: avoid _ in node names
      ARM: dts: axis: artpec6: align all continued lines
      ARM: dts: axis: artpec6: use multiple tuples in regs and ranges
      ARM: dts: axis: artpec6: sort all properties
      ARM: dts: axis: artpec6: add more blank lines

 arch/arm/boot/dts/axis/artpec6-devboard.dts |  9 +--
 arch/arm/boot/dts/axis/artpec6.dtsi         | 88 ++++++++++++++++-------------
 2 files changed, 55 insertions(+), 42 deletions(-)
---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260928-b4-artpec6-cleanup-3dfb30a26b9d

Best regards,
-- 
Henrik Grimler <henrik.grimler@axis.com>

