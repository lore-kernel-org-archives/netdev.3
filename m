Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417655;
	b=DFwMCYAgI7/tUkkO5FLnmC8AuQXX77ZvnZS0ymVvPvMtDxgjlDzR/7FPeFOYimFYOLP6
	 End9nsJw6g4ulq0dNdKAmejC3gFi75+hcltYY8yLJrXwszX+3HVfEP+xkYuKbrPeZUWGU
	 msQA/k16izE8sAjVBiR9hHE4a9z0TV21641nghB0A9dYnF8GLY3eaOSwLEAuCO0FLMNmz
	 QDTZXHPVR7r28aywaJmoz1I0GBGXuXBovV2ccuJKyrR8U+OZIB0EuuuQvP8+P0Y87CcyL
	 zITA2h5fXUDfiiqS73CqtCciKeg7FoUAwGgGfNgipNpslyFPtBULz1vkMaLbhvd6JZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417655;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XWVVqvD7fMQ6Y0wD2sTvw5ZDcE66+mGhZB5l5X1Cv9M=;
	b=LFayswPm6e06YDweH9KeE0boodE1RbWfjUMittpsGJvruXvB+dN0nkweCnTiJW4HisT1
	 CUqLrQZzhn2PADx6ghcu997dEvfB88EZ9eBP3q0qTF6j5ycCWWwvS2slynRKVUY4fJ1+8
	 S/qbjjPdoutEdQBKk/+bW2/CZxkZKphcmXDYv8hXjPfk20FWnTA8Bz+gRklm3klOa1Qel
	 hAeldQUR3JE8R/DcUy7icLks5uYJm5JwBsi86K4BY5NMm+nbewi+LS/eF+JnoQxYnWrmu
	 GZrjW57EvSimHIBMKkjB80xLOKI4LzF0G4Dl+4R+TXuRP3EvzBCcuUq+Svsfwdv5bWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kSlQ9jYu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.44
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F9606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A2F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kSlQ9jYu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQJ5JYcyjty6q+taGzcvEGNiS4rG2qzSCmZTBKcnhM6QnyX8nByAahBuS0156JST27ftVuAGNE//gKheXBT/E6mCEmlgxj9G2TlsFGX6zzV7khb8BiuSwpJXhU1VIAR445bcSpH2lHHDVQvfZvsKWO4RpBfNQGqXXJ31/zdKOPBi+R9LZGa8p0aN4dsAeUDCK2apH97g/T+VicQKEafbfclkTk4fgblRvbxlSSj87YkxtWOFJMrlhMSD23YyN8r2LVw1myzX1F6nLTQWKT82veW7qBa2eoBQCu7UnIRcJIAN8TnlZvoPofgAYL935WSDmdNuU4j9ymedU0kAUsj6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWVVqvD7fMQ6Y0wD2sTvw5ZDcE66+mGhZB5l5X1Cv9M=;
 b=FaKeUfjg1mJgvmCd3wwB4AXG6ORJyoRDNRHLf4QkXhxkg3hF25FHbMwHRLGSVaMKGL6qJahaYWlryQyiCR7hexuADCZy/ZaSOwc8QPyaddmSO5MGJmRTUMrWAKFrLTXfPP0oWqmjHyMXE3gp9pZQtuFhjL3N80bFtQyNdWalW0xGbBQOQQvMMbt6jRidPTHupuFWUThq2sP+xvwGZz6MJKjOsGn2zew1pmqpci78Chsgo8ZCHGdU6YfNtND7GrXF7xeMGycf6bzrwRw/tL9xjpZ1Tz8eflt6E1pB1fnJp0D0e0XBgRMDlMmCvKfO+RioaJH5u5Chjdo/WhGBR1rhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWVVqvD7fMQ6Y0wD2sTvw5ZDcE66+mGhZB5l5X1Cv9M=;
 b=kSlQ9jYu1+WUGoyewD0X0Df/Ff5CQ6B466nmaFznt3Yi0R3I5E4jwNfuRFAGhGX2B4cxw9ml1EeO8/3Vjk6n0tA2y0MtTKrTQrur7p3yRCslWhs5viCh8NdMp4m4e5owx5IRAzg89MokAayDlAfjtY4lZdlN5P85mE3d9bhNmAErZczO3tgEUFF4nd+843ou01J9WyAgwWHEt9yQYODshDAzK7ddtMVWRdtVrXZQBjJEZPdbptinq8rJXfb/KexjjgXw652DX5rlvVvLigzmyhN6ZewaKt4RA2ssKOVgeH8aFq3MHHFlDy3ahRXW+BOMPzE/HAjdOzFL7LMqYcCh5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 17:20:51 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 17:20:51 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	aahila@google.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad with coupled control disabled
Date: Wed, 11 Nov 2026 19:19:47 +0200
Message-ID: <20261111171947.2816258-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111171947.2816258-1-idosch@nvidia.com>
References: <20261111171947.2816258-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce797fc-9a43-4066-dc9f-08df40182248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|261026121527099003|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261026140227099003|261022075727099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nOjhFcG49/VBW+uZmX+knF8zIlaZhsx2sGxTgJ6e8Sjm9oapsK1Yf1AaSLyzReLSMQ5AO35JsPEtVFMgCat4Vlq6hIkk5dcBZ2hrD8HT9ALIqN8Cy52JfVJlg06bUcfWNqQq7R3+sGhv3HzVUru4Tf9tajpat2Afxb+3PN79iFxPe0gJTpHSfiSdEgwlJky1NNNLBBBm/YS2UiKw6fLpwkDuWQIGxTOSuo6r6NKd84UEZNKsX3Rk1/OXx+319FZO/3wgvLPdPd2s9Z6fjSGwQ9OX/BThQSpTNSpOghOizUyG6cI4uWhTlg7XxhBnyuFLQEc5OlKIgt3+WseVC6ZQntUFX8JXstPnDPexKqKBn5hNkFNKw0jIM+FG5XY7xVnxTMD64bFq+iSjXRsyN8+SH5cV4BOO4qUM9R7+7HwbXSYE+SUsfNePDXTa7gnywTPqB1b2TPpoLwHQXjedPx9Ob7xfUpuljqiYsIgvavOqJH2a+bWiIqx2+7M9JH/kqTODheJEAVMElgqVqMgR09RLXT1ar1RwEkD1tBMEBuVXAvDHK6xmpItgIzHu9Bsp7w3u6/RUKUcAc/VoaKeKmN1ZUDtPPp7T8r5LZYAoLV55OyOhzEx6BMl/Oa9AAE5PDSvgvlt4r55RezODEfc5b5LZ89UEbcCupsshoOfFOZNhe+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(261026121527099003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7APVXneQLlfvUheN2+kJ5ayLjDbeX0qYLJ77moGN/FIEkrtoUiF0NkHOaz85?=
 =?us-ascii?Q?stJHRR7HG4l6Dc1Hr7XLv8Av8NLrXTW0JCOoMILE/pB3NMwj+PS3RQLJWOxn?=
 =?us-ascii?Q?OJ2FAJj4f+46GpGBwcPPlH8s/9seQ/egghYXHB2AUA+eGumo/DKyM+EgLkvs?=
 =?us-ascii?Q?YkIKII6znLxWHKEZctRn93JaLyOJ082LXLkzLuT+JxiH1R5KHuMTgmUgTftF?=
 =?us-ascii?Q?ApOtHcNPLZDJwZ5Zd4a4Z5Ehrf1DXyMETx/DnMIoym+poYsgsTgkghMFX12G?=
 =?us-ascii?Q?XA3FuG96HFWtz1Y2zTyOLD8ewSHBTS+43K4OWLkRCLNgJmu4XtgVyrRAfDBy?=
 =?us-ascii?Q?IlaqxJSTlaw2IYNAUAnc829TDHPV/456yuKGeT74lOMelqZF2aSoknMkOPLE?=
 =?us-ascii?Q?QddiFnf//toeqIc/5Y4OIZxDLaTQXAhhiAgT0p371JnlhUmMbvaAMUmABnGh?=
 =?us-ascii?Q?0QrSULSShI8EWjdCthnnyxIjtj9slJByapjwIYNK8CDdErANcXZqu5qC1Xu0?=
 =?us-ascii?Q?ofwsEcnaY/oxrl2GnHqVRB3WrBu3LOqC5M5F/9sBnsRNAD5wPVljs3WdAcdg?=
 =?us-ascii?Q?+MSeNNZZ4S8t2jZT0/NIi2C73rriZNO5zHI+sEwx+WBTYgfMGBfd1mxmnlIT?=
 =?us-ascii?Q?ufp2HE/ekDhNPTrX38bdfxbyya1AVgVvbQOU0LBTvMiqBH2oXXPs0qiLODws?=
 =?us-ascii?Q?k3kJUBuevCnP6xTuS0q3t2h9t4FenxxGKLppsRBgY40z+TYkAVnEufmcfZ8L?=
 =?us-ascii?Q?0SL8jyiMEI1pojIU79EWnxgdWqcoJHrNyxlKumUKlKmuqdbtDbNugM1Eio0g?=
 =?us-ascii?Q?WpEJGFQOEFD25T4T9Fr1LaA8DOlxGwbCTEtkpoGCQTwIQoSL5jvrBnCC4YK0?=
 =?us-ascii?Q?dIHlRe9IDyjpmrWM3m5jDgY3R0pmR8hAaE7YPABmKtI2MLCrRbJO1N/W8C0k?=
 =?us-ascii?Q?66pa2QEGIPZrZONEAvfo5P57CPWtCHmdgkbvRA37I3YvsY9dZje8IUB65k72?=
 =?us-ascii?Q?An/AwUqoQYluxSRaTI9rjwaPHIjOkfJ8nAbw/3xXZ1rLeDjs8QR/RFgMx/Az?=
 =?us-ascii?Q?kEDEDJNGkCZkbzVwT365jxbqV9nmTsHbJvEr4dv5jA6wUlC4IPx95OIxPfKe?=
 =?us-ascii?Q?HIRk2U1TiVWTH4/N10fZaujDaOGjm8wCn/N7nPHkosIJleqn/C5/j8rAkBUZ?=
 =?us-ascii?Q?f3mOOwjfm7hT8Gb0pbgcRnPv1w+eVFXYhSWCuSDWkiWWS3gQULXXyo4hS6vC?=
 =?us-ascii?Q?e01J+3i2A0UOw+KX2F9X0WQ1EFlb5aqaGEjceGL6jFhaooYfI0GPJtp92sCY?=
 =?us-ascii?Q?PwcoHMFRMMS1yCsA50SuVNDFnHz4731PNOZw8vHJg7/AlHMstzDSkyYIr7Yz?=
 =?us-ascii?Q?pTk39k3i9jL9Un8+oE1fsGlDImkwK7Aa9plSnT11WCU+1qxFmDNsWzq/ewNS?=
 =?us-ascii?Q?43PyPmG3TZ5gqiVrFhRrEjVcb3otDOzEXSqcyh59Yz1uo4Jyyd9dk6MdRXBD?=
 =?us-ascii?Q?kI9hlpD8Ff6kb0SzFEFc9KaNfqrdrfy7VS67UU/cE4aZcBHmhjAhUoBrRESF?=
 =?us-ascii?Q?UVn01IwQsbmnNdV0xVB7IV7ctGT++K6yLlECOuA9uUvWDxTtyXtC7ziEeCEp?=
 =?us-ascii?Q?rBRYu1JhM4P8INWHW3yOsWf3gTRqNTnpIAaBGAbUP1fFlccswLF2Rmq92wtu?=
 =?us-ascii?Q?Fwe36lf685HJ8Z2CsTI94i9YummfGUnW4J9H4Yg89VZ2yZH2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce797fc-9a43-4066-dc9f-08df40182248
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:20:51.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVaWxby7ITM6QGZaEmj5mFKA99mUovOMRNF81AbivLcNSfca1Fvg/K/pX/EpWaX/OLuxMiqM5uM1wVDRN+jRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

Test that with coupled control disabled, a port in COLLECTING state
receives packets.

In this mode, a port only transitions from COLLECTING to DISTRIBUTING
state if its partner sets the Collecting bit in its LACPDUs. Therefore,
keep the port in COLLECTING state by clearing the Collecting bit in
received LACPDUs.

Also test that ping works once the port moves to DISTRIBUTING state.

Use VRFs rather than network namespaces so that the test could be run
with a veth pair or a pair of physically connected ports.

Output without "bonding: 3ad: Receive packets in COLLECTING state":

 # ./bond_lacp_independent_control.sh
 TEST: Receive in COLLECTING state                                   [FAIL]
         Packets not received in COLLECTING state
 TEST: Ping in DISTRIBUTING state                                    [ OK ]

Output with the fix:

 # ./bond_lacp_independent_control.sh
 TEST: Receive in COLLECTING state                                   [ OK ]
 TEST: Ping in DISTRIBUTING state                                    [ OK ]

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../bonding/bond_lacp_independent_control.sh  | 144 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   6 +
 3 files changed, 151 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index e337c099fb40..46d9fede5918 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -7,6 +7,7 @@ TEST_PROGS := \
 	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
+	bond_lacp_independent_control.sh \
 	bond_lacp_prio.sh \
 	bond_lacp_strict.sh \
 	bond_macvlan_ipvlan.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
new file mode 100755
index 000000000000..c29712e01e49
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
@@ -0,0 +1,144 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-------------------------+ +-------------------------+
+# | H1 (vrf)                | | H2 (vrf)                |
+# |  + bond1 (802.3ad)      | |  + bond2 (802.3ad)      |
+# |  | coupled_control off  | |  |                      |
+# |  | 192.0.2.1/28         | |  | 192.0.2.2/28         |
+# |  |                      | |  |                      |
+# |  + $h1                  | |  + $h2                  |
+# +--|----------------------+ +--|----------------------+
+#    |                           |
+#    +---------------------------+
+
+# shellcheck disable=SC2034,SC2329
+ALL_TESTS="
+	collecting
+	distributing
+"
+NUM_NETIFS=2
+REQUIRE_MZ=no
+lib_dir=$(dirname "$0")
+# shellcheck disable=SC1091
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+lacp_state_get()
+{
+	local dev=$1; shift
+
+	ip -d -j link show dev "$dev" | \
+		jq '.[].linkinfo.info_slave_data.ad_actor_oper_port_state'
+}
+
+# The actor state of a port in ATTACHED state is 0x0f: Activity (0x01),
+# Timeout (0x02), Aggregation (0x04) and Synchronization (0x08). The
+# Collecting (0x10) bit is added in COLLECTING state (0x1f) and the
+# Distributing (0x20) bit in DISTRIBUTING state (0x3f).
+lacp_state_wait()
+{
+	local dev=$1; shift
+	local state=$1; shift
+
+	slowwait "$WAIT_TIMEOUT" until_counter_is "== $state" \
+		lacp_state_get "$dev" > /dev/null
+}
+
+partner_state_clear()
+{
+	local bits=$1; shift
+
+	tc filter replace dev "$h1" ingress pref 1 handle 101 protocol 0x8809 \
+		flower skip_hw action pedit munge offset 18 u8 set 0 \
+		retain "$bits"
+}
+
+h1_create()
+{
+	adf_ip_link_add bond1 type bond mode 802.3ad lacp_rate fast \
+		coupled_control off
+	adf_ip_link_set_master "$h1" bond1
+	adf_simple_if_init bond1 192.0.2.1/28
+
+	tc qdisc add dev "$h1" clsact
+	defer tc qdisc del dev "$h1" clsact
+
+	tc qdisc add dev bond1 clsact
+	defer tc qdisc del dev bond1 clsact
+
+	tc filter add dev bond1 ingress pref 1 handle 101 proto ip \
+		flower skip_hw src_ip 192.0.2.2 dst_ip 192.0.2.1 \
+		ip_proto icmp type 8 action pass
+	defer tc filter del dev bond1 ingress pref 1 handle 101 flower
+}
+
+h2_create()
+{
+	adf_ip_link_add bond2 type bond mode 802.3ad lacp_rate fast
+	adf_ip_link_set_master "$h2" bond2
+	adf_simple_if_init bond2 192.0.2.2/28
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	adf_vrf_prepare
+
+	h1_create
+	h2_create
+}
+
+collecting()
+{
+	local pkts
+
+	RET=0
+
+	# Clear the Synchronization (0x08) and Collecting (0x10) bits in the
+	# partner's state to move $h1 to ATTACHED state and then only clear
+	# the Collecting bit to move it to COLLECTING state.
+	partner_state_clear 0x18
+	defer tc filter del dev "$h1" ingress pref 1 handle 101 flower
+	lacp_state_wait "$h1" 0x0f
+	check_err $? "Port did not reach ATTACHED state"
+
+	partner_state_clear 0x10
+	lacp_state_wait "$h1" 0x1f
+	check_err $? "Port did not reach COLLECTING state"
+
+	# $h1 cannot reply to ARP requests in COLLECTING state.
+	ip neigh add 192.0.2.1 lladdr "$(mac_get bond1)" dev bond2 \
+		nud permanent
+	defer ip neigh del 192.0.2.1 dev bond2
+
+	ping_do bond2 192.0.2.1
+	pkts=$(tc_rule_handle_stats_get "dev bond1 ingress" 101)
+	((pkts >= PING_COUNT))
+	check_err $? "Packets not received in COLLECTING state"
+
+	log_test "Receive in COLLECTING state"
+}
+
+distributing()
+{
+	RET=0
+
+	lacp_state_wait "$h1" 0x3f
+	check_err $? "Port did not reach DISTRIBUTING state"
+
+	ping_do bond2 192.0.2.1
+	check_err $? "Ping failed"
+
+	log_test "Ping in DISTRIBUTING state"
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index b62c70715293..71c6d69d98a1 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,13 +1,17 @@
 CONFIG_BONDING=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_BRIDGE=y
+CONFIG_CGROUP_BPF=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_DUMMY=y
 CONFIG_INET_ESP=y
 CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_IPV6=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPVLAN=y
 CONFIG_MACVLAN=y
 CONFIG_NET_ACT_GACT=y
+CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NETCONSOLE=m
@@ -15,7 +19,9 @@ CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_IPGRE=y
+CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_NET_VRF=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=m
-- 
2.56.0

