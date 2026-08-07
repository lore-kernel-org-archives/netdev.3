Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5823D2B1;
	Fri,  7 Aug 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139712; cv=fail; b=OKQUjicg7Ywa85/7R4CB4d1QTed7QSgxCWUnXyY0xZUrvic9V2d3l6PBRtOKm4wRjzMJ56iY58Txp7g0IvjwpJ12qle4cadeOO5JXi7M3RrQwJp9f1qCyFM9vqwhe4ndkDgV7copzFH7ZikFM0xbkMCFSxX3m6YbijGuEjXccxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139712; c=relaxed/simple;
	bh=xYZ5umA2iT8nA/SFtlwr7DV0tbi3UusdH5KK4KPpKzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rldeWXLZkmuQrivaI3Tra/rDLw2y2AhFhtA5lEcpLneuyt6GmfTdzi4DNvCG+ajXJu8gNpVaVESe20Ub8MUQt96jGxvt9nLr6ymkTmTAxXSrpDrdHmEYFnpcexLai8mgqR5v98JIW6Rmr+RqrDHugeXOjQlzSgDD02pCWs8R0Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=eUn+/Grp; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="eUn+/Grp"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022095.outbound.protection.outlook.com [40.107.209.95]) by mx-outbound11-40.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Aug 2026 21:54:47 +0000
Received: from BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11)
 by IA4PR10MB8400.namprd10.prod.outlook.com (2603:10b6:208:567::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 21:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMg0YWu0acb1dJyxpUWKgcRbeYMQoDZ49LZSq++JUp7jFO3HotWKo4oNBGphAkVHkGo51a9UDb1D8ya80fqW/iDiNnHFEam0a/ulNpB0tuTF51qZMWMxFtJ7KvKMWI4RSNMyvhkokrKXx9S1hIeTwLN8pDhVJWuVC7khckXn7VSOj3T2vI//V9VT6vzx5cwrjaVTaeJe4Xn+oLV50yovzwRvCtyaakI0TF8UaET/E3dM2m3g8yx7OwSGyBErEAlW2Z5hoGgSY6ESOYAyA8ufdeM+6yRXcMdDmrPQbqnaiikdYtAtBdztSyL6xsOxWV4mRxvR2rBFyJmbRySbQKajyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA3KwFJ2JpgBk7SZ/ArWvOtUd00b1+2Jn/hNxx9zfUc=;
 b=h2CGSupSS8OvQBMD0olbhKCCBaUzBagNcYm02aRA19n1aLjF7OpDo/JnvlQLfraPLJ6zLOMrXTNT9nT7xwW1/C47sQCCh7zVjkx17vSha7WW/vZRhQO6bPXOkpC2j9dR/PjxnCQ0BuFwuT3Lc8DvD2R2W4HV0MVlSlMWZnSNDvfK0YY1adJY1zZyq94OFIK0WadETK+I9qsEc/l68ELdEqsxvBftPt6MVoOBbLAbtb0bbCrzvpBi2eO17isCb4WkCO7HCOmsixk5rjBp4IfTApJkLC1UHec95VjIVNFYyzEJC1AApc4yzMIXCE427EbyP8eN1GJd3MzdvWTYmPFMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA3KwFJ2JpgBk7SZ/ArWvOtUd00b1+2Jn/hNxx9zfUc=;
 b=eUn+/GrpujOa7eaz9pXNihpRxhUKAF/XheqvZGrRDfk1J5zpEeP+6SO84rFlyHpiM11djEPYsJA8HffwVYx502PTaOY/Pss5KbwqDlR7go4y96mvw+rjXMqT5bNBX3/9lMHjdp+SMF47iAEU47rSptT1TmrXZ3tP3T5zDcStoKgFYnb24VWRMQ6gMl8QBH8exfmq25N4DhyKfg54icU2ha90AAOFXGer1mQf/jyHM2H0EqTcCUpoEFIRVlcRdCo2zVLoXSEIfgnueH7QbdJKRqgAqSlrdc/T9S4tP/NdnxJ1i77vtzCY+vVLVPn7cXmpGii88/5C2nE3p71plA+zqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Fri, 7 Aug
 2026 21:50:47 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 21:50:47 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v3 1/3] net: wwan: core: propagate modem control signals to port drivers
Date: Fri,  7 Aug 2026 15:50:39 -0600
Message-ID: <20260807215042.2714442-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807215042.2714442-1-peter.hunt@opengear.com>
References: <20260807215042.2714442-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::9)
 To DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR10MB4139:EE_|BLAPR10MB4899:EE_|IA4PR10MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d0f814-f9dd-43da-420b-08def4cdf099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
 upeuypGMRMpjCK73QMahRH8/Pqrnvx2jlGmtCT4929/fr5RtniN7jEnifi+d45kfMy0c8F8OB4wLtVyaI5tC21Yw73yRfOkRUWuAePxIdEWvsOulQXBoCaayvJ+fQny0uxAjEOfnT8nV6E6uMOQ5t0SlQ+0bgPoez1vhyKXWE5ZpbHAOwAQNdGjlPA2cNt6LazzESuB+skLB1xhCOSqAoFvFTtRYm8q0EftPrfo/0qW62OFrB+H4G+BfHHjqfnPXG5dTDSafm0CX+cwNk2KQxqKDQJweZ7y9D0jF0tmLkVy3jLnnfqsFwDaqXjZ0/hgU4MnNDK7xACVyBOyqpnzr5GohWVbSv8+F/EQgE9T2MjPtVYXIBStzw1RFc1E4t+2S1tyIqnn74xL5F09cA+BwarQk4pGJtCVVG3mscGHEUuyXvyxE2wmZwbbOK+Zss9eISegeS2fUKwl2cAVurucaEZlojnFAG0o5IUh/maiwsWM3QYgA9wJ4GwXqpfYMaaIID/flFhyFd7JgZjwgbACFnDb4Oz5C/BP5z6z2/j+kfW2JjmVz1DMAxLNHGewLYHMTctV+wAqE/uZUYfpCLa0RYj6eg6JmtxBAOo1EO9IXJyjuFbh8quFmgK5IN71JT8MPQ8vkH5hNGnO8GDkTbzNw31YXneZWw8AdGyi6ar8i+zg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6Flsw/P0txKS4dKfVBs1blZAM6hXMVEs6sPJ27XXgEx7fxtGG5HziVD0/cqv?=
 =?us-ascii?Q?6jOS/HBbOAdoIW+JbVSNyf8wkLqTpb5Rqg6QvpuxXbZhsIafxwWUM8rk1Mmq?=
 =?us-ascii?Q?UT5daC+aI0r4zd2XFcIRAHg24x/qSSo5zGsp4Nt0g/cE/X/ZTm/RxVw1CnLY?=
 =?us-ascii?Q?WhehAthY+6ujxFTlnv15ZGdv294tBe5/IiEw+1KszTluh4C8lsCMi+tLKvnV?=
 =?us-ascii?Q?5J4gRxnL14rrVXDYotiqtp9DdPiE/D/TBMpfVMsehSaZNiYfWz4WDhycrkxO?=
 =?us-ascii?Q?6MAhaHfpubJvrx/JsMcUHuYu+O51pbwUitDSobPGdJl9mw8htTMYJVj7LZsm?=
 =?us-ascii?Q?Yar3YRv4gnOdGC9VRi0Ia8xEv7rFaNAq23N46f/1cmSjlK195JuYJ+DkHETj?=
 =?us-ascii?Q?UZgFJMSs/urOMeqHmbXPm7pDLTHlp2MwUpW+KKjnFjmyhxvV4GSFASmCFkI3?=
 =?us-ascii?Q?4fgFgPdxuz2jI04VfirKA4qXHZ5wOC856IBywqZZsvdmw2i+wx2I3bwi1gTJ?=
 =?us-ascii?Q?JCl3wmko1IrRMXXebakSqJKfIW/Vah5zK5SiPFv2P40y8qKYp3PxlmUryTtq?=
 =?us-ascii?Q?Em2w9JLwl9/IROKNBtGHq2CAEjnxIswSIXx6Tf8qG4JP+eE8z/AhuEO7Tddr?=
 =?us-ascii?Q?Jq4U5r6DGQS/AXwPW0F1rmpvRj9gIa3l76OgDHc30jPEBTdmR6IdPDx857yp?=
 =?us-ascii?Q?desOZBb6buugfkNJ10/Wp13JNqaQ7CSRhm75oKfqEydLkCZKQ+4iINrWmLSa?=
 =?us-ascii?Q?5wqUTjk8ZjNtvumjJLEyLmwyUgrYJ2DlO2AVQ39IH7wZrRMcAnNXVhgodMn9?=
 =?us-ascii?Q?+qkwa+f5RJlCKOH4JUS6+geeCCp4mInPKlR9Z4ZwbOq6xgAWGyu6Td9Q8Spo?=
 =?us-ascii?Q?n4Vj2vrxqjVBkr0KibrT5ZJoP/JbNW59ajFpohILjA5IkTlr/9YSH4C+bsNR?=
 =?us-ascii?Q?BJ/WEibH6BYt9QRAishZ+Xduf7taX+/n5YYkLYJ81ns5bAmfq/rO9vFgytKA?=
 =?us-ascii?Q?+PqclptPPZm+Zq6jsgv3zJh5tNV85i+/xDZ7aKcb2FwETJCOzddnxG6ludR9?=
 =?us-ascii?Q?nhcoiBcJBSsz/Dn+Ny10aaoR/Yj2jzcRZ6ImqBu7woywjmwU3P0N8SuA9EHy?=
 =?us-ascii?Q?1ywoJ7omMm2BoB3BnEGFTsQLx91lIjdcX6X+d9T3yS4/xqtKcs7nbORupQBa?=
 =?us-ascii?Q?r+z5cV2u8h+5iiMDWcEa8aC+sEyOauJ5qF/mjaaGiXUVQUVaGweydmACVrZP?=
 =?us-ascii?Q?evqHlw1Ash6UE2OHZ2/2VnJ/skk+lGWbK0hQRctalyLi1Qhr0v7AvzqW6w61?=
 =?us-ascii?Q?j+9IppPAdV2P+PxAKU8+xEdqGiCgUCDrQbxi1u1NLmu1g3CcR4HLuQ2cplcT?=
 =?us-ascii?Q?8bZx1lYcQcz8fSOfQwh84MP07+PAgpbnBbPQCTUyG1SL6NR+OIQYQfWv82UP?=
 =?us-ascii?Q?sX4RJ41OXfsymgICp9NWnLSbOjj5q2cmOu3VnOBzq3GxPrkpfqSIyvOw6NvU?=
 =?us-ascii?Q?Es2e1O9X3CJncTx5rH4WhystMBKDs7qwQikUbibNWgE4fK+KElGAhNgabhQ3?=
 =?us-ascii?Q?9s7c9gVWu2gStpPoaWygkSkprzn+ey6Bbvquc/lvtLBphqDqeIB5M04tWYWB?=
 =?us-ascii?Q?WbNRwoMDjYk8dCaB2E5Q7DkvORLf6jAVOlp/KZBDN5GpJj02ufL6kq4DUhkn?=
 =?us-ascii?Q?+IBwEpW4HVNnbYscI9gRFD8+Dm8owAJhkyZQDlbdfRZXLjXI?=
X-Exchange-RoutingPolicyChecked:
 OBbQykbNorkrGcEcYSClpGC4XDJLkkj60wNOaKj6rKI4CLSZydGOFFGbsBrq6v6o0yhPQZyoimXLFuUqY9E8vZqH16fygTAgqxpUzbubxmmCsqfpV8FxgKO29/gOA3BbNChHiLCGUTnatHHuVU4xq8KV75Ik+/iIlTVqeJ6q7yuSCOhGPf7ZFFeOVWMJ7WAjOAlK+iqxJnWvM3h3vT2nHG3ERyYE+mL+td2ARTf+XtDfrMeAvMeTZnjmRWP3iWBfJyIEk1z1fzWBLJof8QaKS9gSTJ0tofyOM9ah7l+dPDFDCsZPHF8u6l2q3piO+mzLcXGhLOA6TdqnIEzhGv3QXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d0f814-f9dd-43da-420b-08def4cdf099
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:50:47.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oza9TNAwgbGSus4DrZa1otfKKOKk5F2P1AtqxOR8f/Hul5h2ww4UzttNKXPSR72q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-OriginatorOrg: opengear.com
X-BESS-ID: 1786139687-102856-9795-4923-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 40.107.209.95
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYWFuZAVgZQMNXIMi3ZPNnI2M
	TQzMg8xcws1dI0zdzc2NwsxSLVJNFIqTYWAPsg4jJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275221 [from 
	cloudscan16-198.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The WWAN character device emulates the TTY modem-control ioctls
(TIOCMGET/TIOCMSET/TIOCMBIC/TIOCMBIS) for AT and QCDM ports, but the
result is only stored in port->at_data.mdmbits and never reaches the port
driver. A driver therefore cannot act on the host raising or dropping
DTR/RTS, even though some modems depend on it (e.g. they withhold
unsolicited AT result codes until the host asserts DTR).

Add an optional ->dtr_rts(port, on) operation to struct wwan_port_ops,
mirroring tty_port_operations.dtr_rts. Drivers that implement it receive
a simple assert/de-assert signal while the TIOCM bitmask state is tracked
by the wwan core. TIOCMSET/TIOCMBIC/TIOCMBIS resolve the new bitmask and
call ->dtr_rts when the driver implements it.

Also raise DTR/RTS in wwan_port_op_start on first open of an AT port when
the driver implements ->dtr_rts, and drop them in wwan_port_op_stop on
last close. This mirrors TTY semantics (DTR is asserted on open) and means
individual drivers do not need to implement this themselves.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v3: Replace ->tiocmget/->tiocmset with ->dtr_rts(port, bool on) modelled
    on tty_port_operations.dtr_rts; raise/drop DTR/RTS in
    wwan_port_op_start/stop rather than in the driver (Loic Poulain)

 drivers/net/wwan/wwan_core.c | 18 +++++++++++++++++-
 include/linux/wwan.h         |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..f8ca9cda3c9a 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -759,8 +759,15 @@ static int wwan_port_op_start(struct wwan_port *port)
 	if (!port->start_count)
 		ret = port->ops->start(port);
 
-	if (!ret)
+	if (!ret) {
 		port->start_count++;
+		/* Mirror TTY semantics: raise DTR/RTS on first open of an AT port */
+		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
+		    port->ops->dtr_rts) {
+			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
+			port->ops->dtr_rts(port, true);
+		}
+	}
 
 out_unlock:
 	mutex_unlock(&port->ops_lock);
@@ -773,6 +780,11 @@ static void wwan_port_op_stop(struct wwan_port *port)
 	mutex_lock(&port->ops_lock);
 	port->start_count--;
 	if (!port->start_count) {
+		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT port */
+		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
+			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+			port->ops->dtr_rts(port, false);
+		}
 		if (port->ops)
 			port->ops->stop(port);
 		skb_queue_purge(&port->rxq);
@@ -1036,6 +1048,10 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		if (port->ops->dtr_rts)
+			port->ops->dtr_rts(port,
+					   !!(port->at_data.mdmbits &
+					      (TIOCM_DTR | TIOCM_RTS)));
 		break;
 	}
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..a7684950d73b 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,8 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @dtr_rts: Optional routine that asserts (on=true) or de-asserts (on=false)
+ *           the DTR and RTS modem control lines.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +72,7 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	void (*dtr_rts)(struct wwan_port *port, bool on);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

