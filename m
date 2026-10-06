Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416653033FD
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302228; cv=fail; b=BbOp1dnLg2aKHQllLCtyiMl7WlArRXR+13i/lE2Ur8y2R4is/8NJOxmXezr39gkTU2TWmcu1nfRxS/ZWsLchOw5SqTNwNyZL5pi/NLMVGMnQ0nigv3LLzVcp9kZ8CyJftzlC9q11oqfIPJYP/SVK16CbzT7dsXd5rYZIKdUhkBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302228; c=relaxed/simple;
	bh=DqHnQKSRN6MkAPg9lhmc3UvFkx2/E4Qf/w0LgReIQ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpPY3r6mkoxpYL5sFt/jGstqdrGFMbFoBE3hrD/NYAdcWMWEt07pKPiM8D1r7MF4VB/MadVBUOx7252ALhZv6jocNXabOIdSr4k/PyncDfSVVqtbqCYXgcfOSViX28W3O4mOHbgUhe5TkiZHbqon8J+t+S6dmpLViJj+QhPhARk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzkb9dqc; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzkb9dqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnXHqsxHTH2HMgdVp4QHPrHUyEVBlvB4nkDbQbMCL0OJSSeUcs59dKNU242ULGOXIj/dcw/b4T5p60uNp6FejNLpW2/V7lmEZhvu5MV64m4Hu8AyCKkbEsl4USZlFg3W/uCQFX5CWzgvtsD4tsqSo6lHBOg3HptVB3pnEiSIz/002dJXPzJm8zGa8g9HbhXWIREtczJrm5pq+x1/UViT6YswN2wvvVFNVTxsVzO7Hix67u39obdY6DE/fWQsdX9DWnhajME0wsD73xdDPvekqqVhkAZnT4c5GeF15Nr/43upbgHqJGEhC+2uaW7Y+rdMIxtGisKoss5MjShqJGtq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiE09jU6jduAcG86SxAbkruj6B2Q9yzC1ScceAQXZXE=;
 b=TfiahiKhCDHA1TVF/+klMRGefybVgDT6eWao5Dfo06BcW80dlkdB5FZ9lPoLu51W2GLo5Bf6PCA/uB/D4AcXl2repR4PMYVXMHd30J3CZhiaEDhgFIEdRuakM2zY6kTfo6oi19/X6KxzO4fTnOBDV/hc3OSk3jm9EO1DGQ0/wWLwMQ93/OlpBSKSL1/eiSLpYBCjV49u9bf4bFKTsrayRqDpIVHvhQoz+33NBPB36OQOyQ380rEFJ+dMNPbPn1J+uwnHyBtoE4y1J9Qov8xlo+0SLbO+lXqlHdb4Qc0Nkxs7nYi6sSitItkIVJWvCmfCCpMW3p86bi/7B0wrNNVQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiE09jU6jduAcG86SxAbkruj6B2Q9yzC1ScceAQXZXE=;
 b=pzkb9dqcEH1lXEHpzjjU8drINy9xIM66/WK1yOjXR7aGK5+KY58yLmCDpxJ6fdqF7zsSvpioAkZo6KhUfuQUIdgVFj7HWa8Hv7STlx1Zsao6GcbEhqzrSDHlG223+l56A5ZzTyvu+WeHi8kHdK0AmTMENG65oU/DDGfNXbPeUTlAm9BQKiLSOuNnIOk5uvUAgOeSDQBYvOkU9JuEmNf22ghWobyJpMNepmuKRG7V3n8rEadap2gXl/UxQE4knvjqKdgXLmfOc2wV0nI0AH+XcZ8YXvANmt9g+Vb/IlfgJwagNNGnv8HXGHwkGs+DkefZClVH9OuxrjwBdKJE1hjAEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 15:57:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 15:57:02 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	rostedt@goodmis.org,
	daniel@iogearbox.net,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/3] ipv4: Report netns cookie in fib_table_lookup tracepoint
Date: Tue,  6 Oct 2026 18:54:54 +0300
Message-ID: <20261006155454.853588-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006155454.853588-1-idosch@nvidia.com>
References: <20261006155454.853588-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: d776583b-0fe1-421d-5be1-08df23c275e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jByWAgAp1dJpiSxjpGwgBvVC5ioH7iBi5AtzO6DUX8vfLU2P1488fSLcw8szvYvVqxW6fMJob7HB64PhUNCbyVBPX9tq7txQmVAviuRY9J3hXurLuY4xO3avBIHwQMcpQyS/aN3gGrNWpP8t4t3WIsFoFTNBLqJTcc9glQ5BbiHm4wS5SGy5+cVuzNHg4HP36sQbRZoDiCXVkYD2fRd8t8acnqo54p2R4wSZq+jzPrPcE/Vr5JyEcKWs294B8gFzEGGJ5A62etfduesxsmiqpbvbxnYYAiy68WOwFzBjSG4k5QlodW4zJVfnn3p59kCFtWum0pMrgnmYl66FnuwXG6k9jrRcinnYr6OOQMPfJb55cpLrq6/XiESAqaA4v5mUcV4tSwUNV+PUiUEkzliB7leOdS172GTU/QOz0zUnbyNLIBHqq/GOs3g8CIE5pfGRpXvkcKCo1P33I1Zps6VxrHj784IhzeNSEQXbUztLo6et679KC7TyTn+orXZtXJc0Ip1nnIQVJZ9gWc7oSNhuOo9S1s1URs2yprAMlv13KY2CxwpK49zUualwniTmdshBFeSgRwUiY/odaYu+xoBmXJKptoS/26ekIGgt0eYAccohltCZ4ELQ5p0/F7WLsN+RpEmrtWh1GN82H1c7ONzNjnWp1eegv+IrCkXh+MQOtZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6qr8C7JqZ6qsgtSEu3eJtwuQBiRlE9au+WegvBdIjfsualJY+HT1m/DvXcLc?=
 =?us-ascii?Q?B7FnE0UUSP1VZCfJOdTz36uH7Hz0ysaB4AQSP7K23xQqG6GLwrZEcJJNVoII?=
 =?us-ascii?Q?zhfgyXCsVWDnHwAejp05ig15NMIiptayO+VHnvZP8GmFZxbbyGr6FPAyVQ17?=
 =?us-ascii?Q?6rnNWtOvedTBYThXpU1a/pBgyoADbcWAl3hemYUA4IOGT4qUGQZr8Mu06yq6?=
 =?us-ascii?Q?Udkcz5hxVlSJEos/nTPnGZ/yKsskJiEmUQhXWLEQ8xJ5diGqOsiF8/haanMk?=
 =?us-ascii?Q?PrSNiG3IVAIkqpwR3CQh4ERXGbgHl0ozPuTpCCHXk2Hi1WvxAo3v73nzVcJw?=
 =?us-ascii?Q?yOVw+wIqGpEkjW/nS7YL7Rbm+Ct/3aQmR56naANj1ba0+RCXTwEfzYc7nASg?=
 =?us-ascii?Q?WgoHKix/6QtBtED5jYrB1EqitPHc8DSuOLYVCC8G7W7nogRRe4wPPBndolvV?=
 =?us-ascii?Q?kuTe6oLAyPC6kfPhZfWKPfYS/65kr6iLeObJPmSuSVCP5pqAWwPwtbCGgLPo?=
 =?us-ascii?Q?x2BJQ4A6OreoEsluyfCp2lL7q7pm3WH/wyCYEY5/Qi/K6z71il+V8ZdTxICG?=
 =?us-ascii?Q?wOktV5ocQeRPR6ANb/3JqMvg2gGQB1PzsNNLUEweb9vlFX0Iu/RFR84Sh16e?=
 =?us-ascii?Q?BIu3Q134l6/AL1wiG2z8Mw5OyWcCEzyp5xq5MccUcLcrCRQhwt80aumvphdf?=
 =?us-ascii?Q?XjBCGXEIu1yRWJMyKsBe18sB/tA9MNytlL7BlrIkUt+9gw7Z+3dZ0d/fD+Xb?=
 =?us-ascii?Q?ci1zLG5LBNnp+8ffrKHXDe54ZtdowKzlIn8c8hE4mzZ1UxSoxYCnhUZB/vl5?=
 =?us-ascii?Q?y460y7JqV77i++H6fVc78W+KxYVFvs2j8QxIf3MvFgYjKoMco7fHlrTzohev?=
 =?us-ascii?Q?0EvCzwHNVwxzvU6rg3IxMsovkKjduWb89CxgZnzVLYupIensGs1eGxFOHc5w?=
 =?us-ascii?Q?oNYn+pSZgSlBwBsQkgobfND1U/XCV0qPw60RDicgZvSPKChpiX0pqZRpvoyk?=
 =?us-ascii?Q?pZtQ9M3qNEDOgA8jey+z8pLkEwhz+BwPsEwXJexms5/Zq/XNIoHG+3HtE2+J?=
 =?us-ascii?Q?HuW3wkrco9Jh/rmtzmK82v7OdXZ6ppg8WP7VxBcrGWBRLFSqZmCHIxjySQfG?=
 =?us-ascii?Q?h3ktnw2/DFn1JGPFQxfT2O3LYd53+65VKli7niwleQEuM0craXD0MKQY3eDv?=
 =?us-ascii?Q?7OeG8Zazx5b0ipb7tOZb0P95YR39q9V+jaqC1C0CSvMa+iEAf+Kv5N9kN7lt?=
 =?us-ascii?Q?dldF2W+zOfXYMNXo6iPmAItMm8B+FGnviPDEHdXfIYZ8Lp475sEMGHeVOY55?=
 =?us-ascii?Q?Yt/wCNe8HUanmTk6uAIuNWm/qOh2JL1FiGdcCVv04gbYnqqvHoeOG7y6d23W?=
 =?us-ascii?Q?z0p8cpC1zxrym80kF9nVD/TySjdZPouIo5nGpZweRpt3cZ0wkoG990BO+3QX?=
 =?us-ascii?Q?mlIzYpw1ingoUI3tXquLsrWoXvigoiKOgbofazEc8bdCkJruZWPdTpKaqN6R?=
 =?us-ascii?Q?8ExlpGS84lweP7ME2zQSwKJztrcxJ1ZlISuhDX8vJxCmRXj/uR22bzYRKidM?=
 =?us-ascii?Q?MZbvs9baWThyNk551/zNvlLIH+wbNXvqJ82HSpCeHMhVQhxBFVSRZm0MWEJ5?=
 =?us-ascii?Q?dCyx17MS/lHr9gOcb7OPLF2v4F/9mPDE72ZjnKBUYWNUQk3pK4bfcb+M/U9M?=
 =?us-ascii?Q?l241LrHEu2n+cLhCH4K+iqP4KQfIhRW55tY+9TjdUojEMuQm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d776583b-0fe1-421d-5be1-08df23c275e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:57:01.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJNJxQx2Bmrnx4fC/C2QNwE+daEBqykJmTyE9jen03794/3qwAC5n2Okr3gb6lGe3aCe2NyFe/yPRq2+7z10zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

The fib_table_lookup tracepoint does not report the network namespace in
which the lookup was performed, making it impossible to tell apart
lookups performed in different namespaces.

Report the network namespace cookie now that the namespace is passed to
the tracepoint.

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/trace/events/fib.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
index 9a88060aa92e..7852e9ba3861 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -35,6 +35,7 @@ TRACE_EVENT(fib_table_lookup,
 		__field(	u16,	sport		)
 		__field(	u16,	dport		)
 		__array(char,  name,   IFNAMSIZ )
+		__field(	u64,	net_cookie	)
 	),
 
 	TP_fast_assign(
@@ -90,13 +91,16 @@ TRACE_EVENT(fib_table_lookup,
 			in6 = (struct in6_addr *)__entry->gw6;
 			*in6 = in6addr_any;
 		}
+
+		__entry->net_cookie = net->net_cookie;
 	),
 
-	TP_printk("table %u oif %d iif %d proto %u %pI4/%u -> %pI4/%u tos %d scope %d flags %x ==> dev %s gw %pI4/%pI6c err %d",
+	TP_printk("table %u oif %d iif %d proto %u %pI4/%u -> %pI4/%u tos %d scope %d flags %x ==> dev %s gw %pI4/%pI6c err %d net_cookie %llu",
 		  __entry->tb_id, __entry->oif, __entry->iif, __entry->proto,
 		  __entry->src, __entry->sport, __entry->dst, __entry->dport,
 		  __entry->tos, __entry->scope, __entry->flags,
-		  __entry->name, __entry->gw4, __entry->gw6, __entry->err)
+		  __entry->name, __entry->gw4, __entry->gw6, __entry->err,
+		  __entry->net_cookie)
 );
 #endif /* _TRACE_FIB_H */
 
-- 
2.55.0

