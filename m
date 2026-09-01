Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B834B1B0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239897; cv=fail; b=tKHBflTat0Dr41AZh5u4xtp1HV0Gn/xWe7nBXIWEfu53v4O7MGg27mK44PemDYLDBh7hhQul9wUQmmNv/Nva8vmJZ0K5d7BkCsiikOEtfHveuisKCRB0ZhXtO6SZEQYd15BWTDMBxQ8rMzVVpBkefJ+DWiLV/eIe0v1qTGrRT6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239897; c=relaxed/simple;
	bh=KEw+G8oGtMRtCxTmTHx9oI1DuRIUpvBsRi9s3uqb8Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LvRbmZqY/fKXcUOeXNRUhtgdP2nT4+IZsVk5cOEFgsDxbLfin+tPuNRyEzOHREOXBq/MSfjGGcts+i2TCLOf6JD6njpH4yhNy/t07SEQ9p82KgFeJegDsDL4P9MoUpS6G3Bx7U3skI2KM9NuKXSqpDyHXN4Z3BmQ/BdJOJQY1CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=UUJN7t79; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="UUJN7t79"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UO/sD9fqdSMx7jejK14LML9eMAS4nk5qU8P0SCH6OR79JDIs2EjZIHsxyTL6FDBAOHuvcBxJBamjIuldGQsKHXs0boeP8vaCi5Jl2/7bOHvL+RfGuL11R664rzI2vu03+aX/adDGKpSiE3t7Z2NGrEZGmsefui4nWfiSLtpdR8Y2OpWAt9UvBxgQO16lrdi+o9U59+wxk3+Bpg27+zB2g5khXm/JmWi09B6yR6CWMqP+z4e5gL+P+BDffzoCaBMUcZcqk9CJZm1tksd1diTdtGvz8M8D+AhXMBOT+A3XS7MNO+HZrMY/USXRoE1eJXwbqZLM2E1dXlb0P0l6TpZZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyCF29lOzi0C+/SwKgaJrdkJqh28OVU1fsfGsPv5ADo=;
 b=YucH4pHQy+BGcOccDibu6bexeaGShuJzeFO7SNN0CYndwYvc5ylwNyEnd+5JMo3tVhtcAcwjiPhjIcVSI1QDTyjd533XO/MSRLSZRSBZkPX8x5/Muzk/JgbG8qNyTNZUthhnc28NvjGHB9j8OChPEoTW4YV4COywX8GX1HMVnTJmicebDpuJbRAMzpA7vaccoOqnpsA/YFHxxXXOq344mkLLzuE/zPiwkpUZTidKvRjaQihonjgcVT3e6YvPDr0S2KYJyCJP+IMIAwFq1ff5png8kpN9zUo0aTh6jm8h9lOd0z3eeIM0IW1D+rB8IRxLKYPOQ+GiMBVEJ79Up1luzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyCF29lOzi0C+/SwKgaJrdkJqh28OVU1fsfGsPv5ADo=;
 b=UUJN7t79YHOrScl/nV2skuDNjhHrWgyvTu3m1EQKKtRl4P5vv8XUb4s0v2qcSTJtN3cGhhNE8OYMf021WAcBh7tgMrnbMnJK2gvSIa0OXkBc/CZc+epKOJh+WIICa2KVaigN9goMS7tuDQGYRMuReebOnWhTBCAWhHCLnrlXMOVuxyEmbsAHY9+BSE09zGHuksLZciacCqpiHUAifHjGfxqkWecPby3JRtxz74hTi9lw+FsammkNvwhd4NzGPeM5quieRtMMghuhsxGyXdAS4QsyhrGg6XtxGHCmzZ1zsRhm8Xn9DBei15m67BweHihv9ojOqz1JuZO5SBV9M0WWpQ==
Received: from PA7P264CA0110.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::16)
 by PAXPR07MB7949.eurprd07.prod.outlook.com (2603:10a6:102:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 05:18:11 +0000
Received: from MI3PEPF00008490.eurprd03.prod.outlook.com
 (2603:10a6:102:34c:cafe::a6) by PA7P264CA0110.outlook.office365.com
 (2603:10a6:102:34c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 05:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 MI3PEPF00008490.mail.protection.outlook.com (10.167.240.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Tue, 1 Sep 2026 05:18:11 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 8AB7D20177;
	Tue,  1 Sep 2026 08:18:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Tue, 01 Sep 2026 08:17:36 +0300
Subject: [PATCH net-next] octeontx2: use dev_err_probe() for deferred probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-octeontx2-dev-err-probe-v1-1-1b5e1affb994@nokia.com>
X-B4-Tracking: v=1; b=H4sIAO9flmoC/yWMwQ6CMBAFf4Xs2U2gRkR/xXiw5RXXQ0u2hTQh/
 LtVjpPJzEYJKkh0bzZSrJIkhgrdqSH3foUJLGNlMq3p2+HccXQZMeRieMTKUOVZowXfvL9aDPa
 C3lGtZ4WX8j8/KCBzQMn0PExa7Acu/8a0719k7/xbhQAAAA==
X-Change-ID: 20260831-octeontx2-dev-err-probe-9ff7be8b5e6c
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788239890; l=2637;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=KEw+G8oGtMRtCxTmTHx9oI1DuRIUpvBsRi9s3uqb8Cs=;
 b=Psy4B9SF7mBNkBs/Iio5WJHw6KPOZdd9HfJ02QN2GO8xZ5WK2WNFHv63qzZnhTl3wJ6pp6TKU
 Zgc16nyl5qsAnOUuIoKY8i3QbrbpfeCWUEiYVqU9kv8rhq9gkMltcee
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008490:EE_|PAXPR07MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 510d8480-463a-4b37-d3da-08df07e86a8f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|10067099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
 eZQ0S8/76qtb7FrWaFAhZ5fbLgDY/vB7koq0tV2BvRgRt4Hk8oiqFoZZTkbJlYI3UrmPhta5gsmP4Ne9JGYCPEc555tfXQBa6cuW+nR/LexWL1yj2hBk7g+eaTn3jFrrhLnrqqWsZ6upuZ1jzuQAbWfWYw5L631THx31MBYbRc2FM1CREvvyly8NfB5eLCHIUnerAVufOiYYNI1BTJpGqIxctX8rwGYD5f4njUs3Cr+A3yFQZLECDfTsKfytjXkR039We30AuSLvtnLZZvJYEn9ooid35dspG61yXmq/m1HCnFFqOQjPCByHyHDghxr2Ovq/CuHGR7WSKD1GTRLQ/AUySsAfNwY7tuwMMaGsHSfE3RVJ8ftu4TN3bAVu/aVlkbO9xveX77aSaXL4jIpvns72BOPLtQUV6heyPdcnrQtgITHt99Iy4Is8qllWBBdpggoJ+PNzCxZ0lnC2dBdqeDUWiJhi//9BuOFYi1XDnaQupeWw8xzIn/Ns53RgbwqzXfQ0+tWbGBXdkNXTopf2L/j6QhS2hx7OztELWpcOuOUiBvMapvVgLjvAP+sQ5iNoYrKPrLzyPapD6W2JgA9AN8Fa1WsNJrKRe73p2xJops+Bk5CixnDkPpfNksWZD4eyxR0p2vVQZlg+LxcESxupeStnQ7sfpGGp1l6eDx2OSAcmi6BTQ/7f+38HVZ9AvG1OOzdshbhE0voCBA+KqgDg7qoCoDaMFny1cwf4Zmgec6AF6q5VC+deuPzcYYWTXZVH
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(10067099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 ICeqQ1Hoc0nIGl7ZosG1a58e5n54ZrgMjDvHHkuK6m0bQboZZ1XAVf8tWK0nSfo/VdspohgZ5siZ/Gsypl3iGQOSD41OA/PV68lFLqKgfhTM9yGt7HSdYzrnw311FL5DW9Ia6JVAxo2ruXykiGu7GbUaFVHBTVlvcsMMW0wmm9CERRSSwETexo3aFtJuDmbZ+YR4xrum1bilmpWe0GBMGavwQzLASE+kHHGLexaf7ALfzLp8g6DfK8X2N/XSCrphGeHDIz9AtTqQdMXwmMXYv6JnXjZvU738qhUSZ9mLvDS6O8ZwpUuwYHnxvnO7bg/TuJt7uPU5sr4Q3qxYnNBZKg1dvfTGZ8A9eBb5AxEPmdQhHtkm2j9Ts3UUFHadHbmrieWc5V1AbiroOB7uDwt3DAcTtyr4hjfkbRGCv7QAQUofZ7khDLxGXZ+ezI4Sm4ei
X-Exchange-RoutingPolicyChecked:
	1SUK9CHtyxr5bGofcNNfTZab2wEe3PuqF18uHC8LjPmmYFRjFDtR8lDbtCCRFwRKq6DQpRoq82X3hE1o78G8CJBhZn7/hPoIU7DsJqqbgizjCJaiMg8nM/UtAt4t41eoaWxHhdpyN3+as4B439vRBQs+9/KU2e0/DrDHmcC6qGu+E/B8a4jAK2lIe5a3ijOSjqJmdzC0RxKe1L/DtcAXxgYB+f9IKeZJBSaEO+l7Kd5MedPckr4fXP8dnGe9Xqd/Fp8qlsovzn/z0B2qK+SVTaL5+RufP+J0n2CdJCtXfs5vlzE+UHnw7U3WsXhQVlObEdVL3WKNHGuOhwmhEyhmLQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:18:11.0376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510d8480-463a-4b37-d3da-08df07e86a8f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MI3PEPF00008490.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7949

The PF and VF drivers warn and return -EPROBE_DEFER when the AF has
not programmed the RVUM revision or does not answer the mailbox READY
message. That is expected until rvu_af has finished initializing, so
the warning is repeated on every deferred retry.

Use dev_err_probe() instead of dev_warn() so the expected deferral is
not printed at warning level. -EPROBE_DEFER is logged at debug level
and the reason is recorded in devices_deferred.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 11 ++++-------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c |  5 ++---
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900..529040f3e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1167,10 +1167,9 @@ int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	}
 	err = otx2_sync_mbox_msg(&pf->mbox);
 	if (err) {
-		dev_warn(pf->dev,
-			 "AF not responding to mailbox, deferring probe\n");
 		otx2_disable_mbox_intr(pf);
-		return -EPROBE_DEFER;
+		return dev_err_probe(pf->dev, -EPROBE_DEFER,
+			 "AF not responding to mailbox, deferring probe\n");
 	}
 
 	return 0;
@@ -2993,11 +2992,9 @@ int otx2_check_pf_usable(struct otx2_nic *nic)
 	 * otherwise this driver probe should be deferred
 	 * until AF driver comes up.
 	 */
-	if (!rev) {
-		dev_warn(nic->dev,
+	if (!rev)
+		return dev_err_probe(nic->dev, -EPROBE_DEFER,
 			 "AF is not initialized, deferring probe\n");
-		return -EPROBE_DEFER;
-	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index fcdf891f9..a02267978 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -297,10 +297,9 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 
 	err = otx2_sync_mbox_msg(&vf->mbox);
 	if (err) {
-		dev_warn(vf->dev,
-			 "AF not responding to mailbox, deferring probe\n");
 		otx2vf_disable_mbox_intr(vf);
-		return -EPROBE_DEFER;
+		return dev_err_probe(vf->dev, -EPROBE_DEFER,
+			 "AF not responding to mailbox, deferring probe\n");
 	}
 	return 0;
 }

---
base-commit: 25c1f6111034aef7fc06cfbdcf1e4f0d6e5ee74b
change-id: 20260831-octeontx2-dev-err-probe-9ff7be8b5e6c

Best regards,
--  
Juuso Rinta <juuso.rinta@nokia.com>

