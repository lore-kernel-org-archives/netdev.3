Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D943B1B3;
	Tue, 28 Jul 2026 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205742; cv=fail; b=ndKEFQvUWh5I3KMVn2FGTwO45H8HqdEUSqkqRoVhbC98fffhbZQuvhbdG3CZCeFggYVziug+PXW64PrXivq6q8TFemXUVIWDV+q0nD7VDS+YXSlfLXfFVoTITI4lB8a44kqFlmF3vkHTOGrGEpTocxXMFS6XAE+pTfodZqi5HNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205742; c=relaxed/simple;
	bh=7ku7vDCOqIbxnfgkambBt9gqYyWmd837y16Q/gD1aLI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KJsCVE75M4QnoGu4eJ6Q/eXcb/rnpjKj6jDP+oZdKFgfODS4ORxkWYxXi6UsTvEqWGqJxOVBXKXBkSWfcjawFEEgPVJbmVqcXQCK9PvZWbPnA2shHRtPXA7wx3HCNXYzvPqWIPNEHft5Ypr0r8rSwhO/FZRavRfC+UmZQeMF0m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rsuMul14; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rsuMul14"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qomJIJBF4Jj1kzunC4R3hEPM6PQ4cYdIceaedfI0R4oQKXU1ziZolF2RnaeRX5wX8Ybwueexom0rkFD6INxqIdn56s3VEbSs6K2pNuTKSbG8dHlPZBqyorfxXWHNe1+IPmKaVGHQKyCJQoFhDhpRZHgytnDSfia4wJhOHSE4rbZMfA3eazlBgw2oxFiQCIbaGiefsKh30Bd3DdiQRGbooAD/sZEXoG5//5dS3eUg/SFz6Q5LqG7DssOsC8k/q+PKGygd2BI1JiOFdbsWDO1zN1tlLkNH8O+8h/h18984LU7ThyNf+tj1hK4hkSknLslh3PNxioNktSVxle4RFIpMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmJXskdMWkIPMimpTmxRxToUlOeUzXC2emAYUCrDmDM=;
 b=sEc72bJPYpUXPdP3f9MS0ilRecmC+1bkgwyjRN2jOtIXO0x/599VGBy6T+roEoIqeLlu0p6wFpcWAHOTM0bP8tl8YGUqNtA0gZH97zT6gsJPosREq0yc0CtuuWY2+YkjUsJOw08o3NjKQbhzS3DaMVS0Me0VoG/PkNaVjvx6XDLZHorTs9+RhFLnOigVVZ5JwtZi5bftMrUd6HI5a7bAKYos6jY7LcOoM+y78UKzSeE3BUnV+lBKTMo4KsqEtulf1mzlaDPR/LyuxgelPthTQO0jtbFupApXOHsgEOG0teWrZkwdJKJ1/5+vuaDEUd34MesxqdDnkjBMp8eckOVhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmJXskdMWkIPMimpTmxRxToUlOeUzXC2emAYUCrDmDM=;
 b=rsuMul14bxuvDfoGxeln8pDF4Oy5P4RzvTf/D05XZ3K7WLM9WITIVSIBrtS4bHDAFYxb3OXpE+G91z5xSf1Uw08aaWYFFxiCiovShAouo82SafIYiSOfNg8J57iUmbillmaQmybLzdzTQCnLOjJ7bOAlod0ID3e0FZz0uagDNKbmD0gra9A38JxMdlYYkrqOeJcAxtbqL4B7AKXmXBKBWqQs4Db3hma/l2rlk7cgPZexC8EbdTPFKVS4n2+KUxCQ8R8q9gRS3KHDgFqD/cUFNmBuC1PjHA9nsB5xU1HXDUO2v0/qCiL1/LdLO7wVOCZXO2qNMe7ZKrKREqrKqVGL4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB12186.eurprd04.prod.outlook.com (2603:10a6:800:331::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 02:28:56 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 02:28:56 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: enetc: restore RX ring congestion mode after ring reconfiguration
Date: Tue, 28 Jul 2026 10:32:15 +0800
Message-Id: <20260728023217.2499420-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB12186:EE_
X-MS-Office365-Filtering-Correlation-Id: 731d3ddc-0308-407f-c30a-08deec4ff8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|19092799006|18002099003|56012099006|10067099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	fodI6+0LC+IWF6pQBIszTQ65QJU+RXN8XFba3S4QmP7f2yfPeYT76MlnbyVN3ICFsX2UJGsrtSeBfq4JH2BFkSUhYBHjkf4pKGUC53qtWIV0BiaZJbJH28dPKOiwKtvx1Y7Rlfv/3EMkNNkKiwNFLQxCNaqOPxqtN0tBurHEBU2NgR8pvijad2ceKEKYd4chlbz5akvP19LgVI3FZ8/Ze6PK9l8khdo+wNFmpm3ETyEVYqZwrJLfDIBfGfOndR0NcSV4Ambtf/BuMnRolMf5g7zefEShRYhBuxHIXB78iQYtQphiWpwXgLuIPTjxmOloKbwIuE0MX3QwOYlAq1+ge5yjpy17NFEj8HoFDKCeFsi0tdlBLnImIpXwze8vS1ePFpjhm4UIg1KiOwpZHmzzLLSqTlaPkP/H8QOcgvexwh09St6675/UCEpVArFQxETnD5U9UxIX8mVatMx5kXLa3uCyuA9KhG1RB7qGZ7gF9LTixdo0FceF1foMP9KXMsEwD9o906kRYjJMSzbU97wnavxQcDWSsnv89134xBSw0g8bJxaPBGAbUrgxTsgVp+IaKtfClw6YXJhIb2z7k5CkjlZnogyXIInjH3BAMpRLLnS1GqWH39sQfwJEh/S7mBNySKvYJrZGvH0V4IN2B7r72g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(18002099003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PaWs+L3N3/WMF7xw7+JbOCE4AZMRYyGP+s3OiW0kbRUe8DZySCNYAkycBtLI?=
 =?us-ascii?Q?89u3r9FxLkvn0tLtm7bAEyJ1kufGC4ZIJfGd84VHIk8TyNqYkDrIzqRsyJUI?=
 =?us-ascii?Q?PqAwqB4EnXvK72b6KSDyGNr9xTdreyg5LRMRT267gwlsyk+CAVnxQ3C+1R5V?=
 =?us-ascii?Q?nWfCfWPiWnGSdGLN8BPJ/uomzvCVgkbZ3Tgjum0++ANjg648NQKm9JQ353+C?=
 =?us-ascii?Q?XK/nbTDE4FsjGeGiDgtMRfVqPygrWNeWQ1piDeGVsQ3o3uSxZYk0BYuVvoT/?=
 =?us-ascii?Q?et6PZjEUMjIEt9w+JobX3kr8qITsPPqKN9s5VuqNRXuuRCCnNgTbqmDy9Cuq?=
 =?us-ascii?Q?quARaBgNVf4uyEJioTny7rsgltxeE/ENMOBC0T8c+GC0Xy9/NyYD/zm6h/I0?=
 =?us-ascii?Q?TdCt6TJXxSDOJdM5n5NwiAYAsJdWHJsHRloOp6GgMR3dKajUq9ZpJnIkqyNm?=
 =?us-ascii?Q?56aH5pa3ayeBN9ob1qdN+fI3SvIOdfwM4ESdElx8QDC9D1DfpHABzjKWE/+2?=
 =?us-ascii?Q?TftCUzP/R3hnrd9+owlsDy2GQZ04LRwekwrosSCnlTEEJyIP8O9wzUX/4BeO?=
 =?us-ascii?Q?XXM2uYRBtDNlAPmWXWgYadUjAKmrnof2RdQE9Mo2Ru1/LxwXWdN+0ZwTpR+M?=
 =?us-ascii?Q?/dqH69GQfoBYBhJkQoRvhdg+TKwQLRi38e27Chy7Se95lFJ6PStZPZa2jrlI?=
 =?us-ascii?Q?j3RNyGPwnz7QEaSG6buEpeO8o+LamXAhjQXVdqRQSMINfajGxtLr/XwV/S/T?=
 =?us-ascii?Q?jeir8q1LNU5fAh3v8CnRLSW9+DnrCnoIPV/PzwAWYLrj12cXZc9qUWkz+I1h?=
 =?us-ascii?Q?2KbU4AXw/hK5k4/r6PKl0Kt0GkYNilG5NnCc8D6P8ZH+29EdXZLj1o6kPKCb?=
 =?us-ascii?Q?ygohVkz7Asr7LTw+L+NIpWh3Bph1dSMprhFt/Z1mZnhCugmJezGeJ+9Ay9mE?=
 =?us-ascii?Q?68e7d/bbrJLGnfi26+altL3ndokQsDYN3N+VMiikh+J67dNakTMXV3EPxJc3?=
 =?us-ascii?Q?CPY19kFiCKOfs4RC8OKUr0CIO0sLTkrZ4wGhYyIKLVV8oYWFKecK7cpRMJEP?=
 =?us-ascii?Q?XWweXxaWFPUoNa4TUndPzyr44rN6IYRIYm6oI0VVSSysCVhSWZH2h98SnTcd?=
 =?us-ascii?Q?kL1mbwaQzLtlncShEBgPYFnqcRYVj9F+wEkm+xuwxbAUfyyTpV12TKSH4Wgt?=
 =?us-ascii?Q?g6L9o3uwv+FB5PSBq1pw/0ASog5TRGnCZgl90r8qKpC0e1YuvnYHaGs70NC4?=
 =?us-ascii?Q?ZtO7pbSAQHRj9JrYR9U2oG6K7mb9x/HpuP3kjHqZG2+wRr06PXxgbUyqvi75?=
 =?us-ascii?Q?19rPXo1gJlijJOtuwhQx76qhX+h6PvNqzDikNYwP0AtLCz1FtO05HEvF+1Kl?=
 =?us-ascii?Q?MdY3MSkHqM6IYGr9lfbVa25RKSfXAo73AIYRybKTb51LnRGMKCiRfIWVubPV?=
 =?us-ascii?Q?T13rBQOwmt9A/dLmWrdgrZPKslb5BShKLZASNKmvsETpkW80r7grnoP4KrRZ?=
 =?us-ascii?Q?KDHKICFSwnjPVFSbvAporQrtgrDrWcrYzfO8lP5coXzO9j7DwpLpIB18N68q?=
 =?us-ascii?Q?vC+BaOu6x124hZQKLjudTMbKiljbs1mziJeuiWLss24u7h4POELY7p8TXRul?=
 =?us-ascii?Q?HRYytkd8CQ3+y7Wf2QbZ1zv6CYOxr66m3uqMfhKLGwwEsgm2CfyXfH40VnF9?=
 =?us-ascii?Q?JGy+0UEggitqMlkK6UcKG9azxM6iU8muzAJ6uaHousC3+qtCg+9UITs4h5oo?=
 =?us-ascii?Q?QzkRATwq/D7rYLNCcz/yFNG4tvrtwHUbdIRVT7pCFXLHZKCTgbIE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731d3ddc-0308-407f-c30a-08deec4ff8d7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 02:28:55.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDKqvmorfqVU4edI1EHtkCxzBwT3x78b4AKAdxpkPsWFX9mDmwVSoNTUtYTcluSscULgcGATcV/nLUyrIHlxuSb5abiDIJRi86abgdSjqvRyfEwri5+9s6mqpTGmms24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12186

From: Wei Fang <wei.fang@nxp.com>

The RX BD ring congestion mode (CM) enables the ENETC MAC to generate
PAUSE frames when ingress congestion occurs. It is configured only in
the phylink .mac_link_up() callback, which is invoked when the link
status changes.

However, enetc_reconfigure() tears down and re-creates the RX BD rings
at runtime without any link status change, for example when enabling or
disabling PTP RX hardware timestamping. enetc_setup_rxbdr() rebuilds the
RBMR register from zero, which clears the CM bit, and since the link
status does not change, .mac_link_up() is not called again to restore
it. As a result, flow control silently stops working after such a
reconfiguration.

To solve this issue, track the desired CM state in a software flag
ENETC_RXBDR_CM, which is maintained by the .mac_link_up() /
.mac_link_down() callbacks and consulted by enetc_setup_rxbdr() when the
RX BD rings are (re)configured. Both ENETC v1 and ENETC v4 are affected
and are fixed in the same way.

Wei Fang (2):
  net: enetc: restore RX ring congestion mode after ring reconfiguration
  net: enetc: restore RX ring congestion mode for ENETC v4

 drivers/net/ethernet/freescale/enetc/enetc.c     | 4 ++++
 drivers/net/ethernet/freescale/enetc/enetc.h     | 1 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 8 ++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c  | 5 +++++
 4 files changed, 18 insertions(+)

-- 
2.34.1

