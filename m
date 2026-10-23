Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792777312;
	b=Vasz/YZ7uTMP6ErrO4ye2LNRnZ7JZBaoohqiu/XxjCQTemLn1dmyZwdzvKT0PFrDAqPC
	 ARImKSZGBv2ZtyI5HTiyYlebvgDXkXE3QGFr1HZIzca1SwSxtgh8kXEwnqnU46/qeTdkv
	 MxV67UtyFv4oEvwMgaI9YApA86xurajdahzQgJSxDMvp+3UQhVNSXgm2D69QzzNQENmN4
	 UirwrtPUXptSlvv3q+2/7lJx2aQeH9HGYm+e4ShlZ3LdhbObfTUPGY1KrnY1yKkrp8gOK
	 Hf3R68/xysJsGz+VeuBj/9dl3PqK8HMEaHT5hfLua8mPBxneUlOw7Ueu4wPzeUIfe3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777312;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status;
	bh=JMLiuEXTyeRJRM8cfS/zqmP13JKkO3+A1ks6AbFobBE=;
	b=W+t1aoVgdFqOKogtAdubnQGaWtgfRKY+DROhOkZbxnCdnGDvJ/VF5vgTpA6PlUKWpQY+
	 uA5Stbuq7NF9+LqCmapSuWJpKXSi7dTxcl/Z9yynn0hVZWm04DlM9+uliu0nEaCPqhAmM
	 8u3GnrSX2LrQnT0xmUSUizcAqYQfhgVARx8yhg1+lwRvJuXv5qUO6AElWaEoXmnsb43M1
	 9P2KRsEH0Op0t0eJJjUytD44AFetKyaykQbeGW3yLTp/Cup4AyGgOx/NKG+E2DoUja3eq
	 kWCr1kzp4Rwcz/hLUsmmGbDp2wsL2D4gYL9pCz4kY/85Eqri14TDLWRpVVsZbvLZiZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=Y8Gz4V1Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.137
Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3B606A31B;
	Fri, 23 Oct 2026 17:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF3B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=Y8Gz4V1Q
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020138.outbound.protection.outlook.com [52.101.56.138]) by mx-outbound21-108.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 23 Oct 2026 17:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYvUjkNMBtcTCr4ibaylj1WOycOSjb7ek6kYBDg3lNB42lGJepHwQV1yaVgxDmiPKmJ88lYnbtNlfgIYW45+Oh6Px03iWEq9GkTSqWDlC2NpFhvKF+lAfU+fnUWV4kXZnNmQDaj2mLqsPldlvRFMz6UZDkY6BKPHrLfhJpuznsNhYbvgRKbGDqIoiLyhqEccjQJTDVyXlWbcliU/btoLMIdOAPvwsClYBWYIAZmWVXMR1+YMT2mU1GiVUKD8CFpSF6MfZHdANbBDRQfI1p66hKLtTMqBRuQ5C4MRe7yFhdH52RqKtw1DxxXmU0mOxYKez0ABUKV7BRkWUZDipvWuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMLiuEXTyeRJRM8cfS/zqmP13JKkO3+A1ks6AbFobBE=;
 b=QjUpXvSobfkmWnVvWdaNv2gZj6nZiHC8oNiW6CajgsIIGlG1YZTLium49HgsejqElh/1FjWBURgBpbf27C7j8ARV9yn8dWw5XENdse6TOLo8xduqZL8n9bbld9bFLPeDOSEjBpHBGX0m9KNFN900hLmAZN6k3AI/ZdBnuLxDAfQFBSHviCV/wJWb25L/d2UWS1+En2s8rGgoWms7Yu3nu2ja96knAXMhAUclZoZlQ1vc568sCS0BA7u6M1wbvQENhJ/+YIPlKgOp0sE/YcCx77wMz35FCWGsTXVhwxrQ0TcIZlvQtpaySCXAYfWMVwLRvfhMfQkt8s7gCcy4wbtqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMLiuEXTyeRJRM8cfS/zqmP13JKkO3+A1ks6AbFobBE=;
 b=Y8Gz4V1QcYi7xwQfyMJThs62SnrVnOu9afDPFwwJ7IShQmRW8iUR47fclWDGMeniF9Ky0T0i+5AQQZi6J8DDqA3+vmO9tb249YLVggHhFWKX8Ozt+4T+yiKFV0RqWT/viywBsn47MFqBfZInmzGiKTrqmEuinBT2ThUgSnnHON0fyFZV1N5ya0IAoAIUawAaCgyd1EovRdl1mFPQeJQxM3sTJaZPD3j4La2EEWSEnG01QYAmYuckuYUHeG/p2FuXNuHt9pmt+vB4XWwMsP12PWZMwGryylEt4yIcRpcMLZiivgXH53h5FS6J1/0YrFPZTBALZy6Jww5DysbBoX2OoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by DS7PR10MB5133.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 23 Oct
 2026 17:41:17 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 17:41:17 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniele Palmas <dnlplm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net] net: wwan: mhi_wwan_ctrl: keep DTR drops and resend state when IP_CTRL binds
Date: Fri, 23 Oct 2026 11:41:13 -0600
Message-ID: <20261023174113.2388353-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
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
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f36141-1cf0-4615-244d-08df312cd750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|10067099003|261021123027099003|261021121427099003|11063799006|261022105027099003|261009223027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	fxZDS5sRnx/V0Z2i+016n7kBDiwqnjlFpAE5aca+d593FT023KYNkxUkT3HtwG2emYu7vOUSqiUvLqSEHZJ6vE1hd1vOW/ASE7TaqTMopH+CuXl9aU7BrCZlHHlmSpgKOLZoTtc+3DhV2UdyAWmhsjwrnsGOQB5OUbieEdE6y2Zc5tsEi74Qn/61/31rD8HS9tXK06O88jxaBwC0UkWRmLkvuDL7COmIiF1icSOpLSt4rOrBM41DqG7fb6IIH1eyDvYQqYxJuFiNat94VFFtcUF6a+zWc3+pmRSQYE2pjy46AXpJef0UNC8q77WeO6gZTWOSbo4VVemKwvRfKj9cMR9nKipzwYbOmyTVTcLtR5Xog14wrY0iPPzdzR2FUN+rF4qWIDJT8/tVsnr2Tr6jI280xYubpzLrMt2hXRWC0m1hjzs5eo0gU2nqP2e6k2ioYByM8kUxzbldnYCN54RDxrE3OWWRRqy4wNhEBsTR7jmYo7VHwYC33O3z1Uk6dy4B6hoj0ow5mjo/EjioSX7OeJI6XtlsvT7ln99ek3fEB84StdVqGzOBXfT1nIsmaT3KgGogvMo7m4OUDBrqDqiSL8NzcywoPNchjm91Bol+tiXe8uISMnV5rYmD8PaFlWBI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(10067099003)(261021123027099003)(261021121427099003)(11063799006)(261022105027099003)(261009223027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2D5zxMeu65Fxyit62HfamtGAtaXIwuUfmMlnq5q02m+6UB59qDdNn5uWd4uz?=
 =?us-ascii?Q?juiHNTwjnxzbruARKkgNGbjo07raWtx3kpMsoaKAs1cChZbIJ40ajawDScUd?=
 =?us-ascii?Q?KvoIu3Aau87xZL+o1J9gkWYcwe7YxHrPrf/zG2tK/m7rrgeE+GTMd1pv5NzG?=
 =?us-ascii?Q?IMfmmnnRMPBIqqoFLPqq1xO4Vzra3UoeB30OmjueHBxeHWvRZaAQcwLjruvY?=
 =?us-ascii?Q?g0hVVLW/3CetlsZwEJaVb3vSUKETXQtMAd6tS4Glef9PwFWr9m3JJ+W7UjAZ?=
 =?us-ascii?Q?tVzt/jZvR6QxWNA5ytgESn+RSlzieTvn8zjYayOoEAGzRpqjn42t5adt+2+t?=
 =?us-ascii?Q?bwjCNGEr+KWOYBo22DOuoRwXnFvBEGsMpv7/t0VICdgOinNN8wtNFTWhm9cb?=
 =?us-ascii?Q?iXy2/KxXoRJiA1U7toCy3QOg3tDdeIQbnCAJvlxQUl1LOvGtiW0a8u16wpJH?=
 =?us-ascii?Q?A1b36KVzjrz/Qg4zEQ2VMaDvu36C91wDM1t3pv2AvA8ISeS4I1/cZYgsOcEv?=
 =?us-ascii?Q?zVTL098CLvzUe4PR1hL4qxmraozt+9mi+tyzbxAW6/UzAEOBwzRSK+tnP7Ri?=
 =?us-ascii?Q?7kHZIYlZizM56mx0boh+eq58eLAJuNejpiZJl2lQ13cZTq2VqsW+mYEjJ3UX?=
 =?us-ascii?Q?VdpNss29Q9ZKFt25oCGLjYjgwLj8V4Z/Eesyqb1LNJ/SmhSuvWb46wT659K2?=
 =?us-ascii?Q?73ODypTe68rP371ZLGjbqR/OsfbPwSfJl9DZYQj8xELDwwvJfez85jeYOhEg?=
 =?us-ascii?Q?/v+ruC+L/uAW3e/36eVCx+2wgjf73kb9rcOUdXrqqXvb0mVmWlDl6UqcTCm8?=
 =?us-ascii?Q?pr0c8T8ZvElXNNQTBO7T/oBFRnUjqEoaehiaEo9vB7zrOvOj4626aszreLwp?=
 =?us-ascii?Q?nwRnCsm1VmkP7aQh/Locl8qCVtgef2aLNPEPHxOOe00/A1IUQjCrcVu1SDy5?=
 =?us-ascii?Q?U+KV3BSvhrOBG7Rls3OFhsqdSmgg/ZfuCFnUxaqkSylJLuINZGyeACowOWX6?=
 =?us-ascii?Q?MmvEFoTUISw3u7M86XFQqaXohDh9IoBjylfpbg9KO9+r2zoeJxBBWN5Kfrjf?=
 =?us-ascii?Q?HWIoUg9q9aaSMVI22af8WcJoxyL80q6LI2T5biAlZnw+KnBIk05koCJsDmvz?=
 =?us-ascii?Q?GSuC3b/t3nPzBxaTWTLBlZ3vHN1Qbu6mgVJp37teb38QjxqKuYjthngDa56t?=
 =?us-ascii?Q?rZLgVOZ7tGGjUkn5S/jEcDZAetj8N400juJ/iWhaPlERD7LDhxeQWOkLW62i?=
 =?us-ascii?Q?u2Wos5+/ulZSqj6JIoI9Mp9V8uFRGMM7oxy6zOT0QqdVrvJvOE1oYLXHb1S/?=
 =?us-ascii?Q?VZWFiwMHa1i14hKeWialUhhBssvHbmC5nVYmIjIdqQWXoOnk9J1gw3N5ZSUI?=
 =?us-ascii?Q?ObKQnqj0r2/82w46li4s59e6o5ks16JM0liiK1oMqCbl4UEzJJw3QUGpsI1L?=
 =?us-ascii?Q?6ZVnCfZl9Fm2BCA1FHlWnj2NwU5StkrUsIaaspJsuq1WZrD9gP02rxCxHfCW?=
 =?us-ascii?Q?7gj3l5tyS6/Z88yyRvQe2dwf1MiqIN+xe/HcxtCpDh6DDe497gwnVJf40ZtO?=
 =?us-ascii?Q?6kYG87Vn/S6sbo1R3zLjBNEkhTSVYRD7o7qhEJfzBhDVBJKF9409Ty+hrRBG?=
 =?us-ascii?Q?hy5ZoBLVdts3rbo0+NJMm/FbckjipUsvoom0z2H8hjXNy0Ltuy1AOpXwnZOF?=
 =?us-ascii?Q?Q9Bm3sptMFMIQSGy8CBj0Ztg7D2y0uQtPLM3V0Q3Fe05Jxmp?=
X-Exchange-RoutingPolicyChecked:
	A2cUBtoSPQY2V7mES3Z2vzVRRJKpPnSOtcnj9pY5JJ85F1wiHQgXHYJyViEOUnOVhs+qF0/mxu0ta8whXrTr88pFQPRy6g9UdFRIXBH+reoaPR0omZyBD1rTe1KFMH1hY+PhrZA7ra8NYvPl2O8j9q3qmqf3unaGxykhBWqwFAB9Aa4yFkRlOMce0dVCQyAYzy+u9cm8+cJTFONh4pDRhhYlb90DCD3XbhooTVGQbgQWUYDDY5J3XX5CflTb3Gg02B+3qrsa52GhXdQ8Z2jrDEj4bWGpw5IvkpOYc5GUxZNbxSd7mGYMzIEy/BQuAqbccp3IoqBNSpIDnDtg8Tgg7Q==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f36141-1cf0-4615-244d-08df312cd750
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 17:41:17.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbUzCBONLIw5/vEj6PzMR8VSOklIFiYIoocQE5OSPICcMLT5D6Ej1oM8LAoF5Nca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-BESS-ID: 1792777279-105484-20662-31829-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.56.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaWxuZAVgZQ0NTIyCDJ0DjVKD
	XNMsUyNTHNMsnA0DzNwtjQJMnY1MhMqTYWACCHntpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277056 [from 
	cloudscan21-188.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Two corner cases in the DTR/RTS coalescing, found by the Sashiko review
of the series that added it.

If the IP_CTRL channel binds after an AT port has already signalled
DTR/RTS, for example after a sysfs unbind and rebind of mhi_wwan_dtr or
a failed IP_CTRL probe that is retried, the state requested while it was
unbound never reaches the modem, and the wwan core does not send it
again unless DTR or RTS changes. Keep a list of the driver's ports and,
when IP_CTRL binds, resend the current state of every port on that
controller that has signalled DTR/RTS.

Coalescing could also let a DTR drop be overtaken by a later raise, for
example on a quick close and reopen while a retry was pending, so the
modem never saw DTR go low. A drop matters on its own, a modem set to
AT&D2 hangs up on it, so remember a pending drop and send it before the
latest state. Also run the work straight away on a new request instead
of waiting for a pending retry.

Fixes: d509edf90bc6 ("net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel")
Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
Follow-up to the v10 review, as Jakub asked:
https://lore.kernel.org/all/20261020114405.38a06826@kernel.org/

Tested on a Sierra EM9291 (CM8100): IP_CTRL unbind/rebind with DTR
cleared and set while unbound, back-to-back DTR drop+raise pairs, bursts
of 10,000 DTR changes, plus the HUPCL, teardown and lock stress tests
used for v10.

 drivers/net/wwan/mhi_wwan_ctrl.c | 50 +++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index e3c207588956..52b6d3677558 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -15,6 +15,8 @@ enum mhi_wwan_flags {
 	MHI_WWAN_DL_CAP,
 	MHI_WWAN_UL_CAP,
 	MHI_WWAN_RX_REFILL,
+	MHI_WWAN_DTR_SET,	/* ->dtr_rts has been called for this port */
+	MHI_WWAN_DTR_DROP,	/* a DTR drop is still to be sent */
 };
 
 #define MHI_WWAN_MAX_MTU	0x8000
@@ -43,6 +45,9 @@ struct mhi_wwan_dtr {
 };
 
 static LIST_HEAD(mhi_wwan_dtr_list);
+/* All ports, so an IP_CTRL channel that binds late can resend their state */
+static LIST_HEAD(mhi_wwan_port_list);
+/* Protects mhi_wwan_dtr_list and mhi_wwan_port_list */
 static DEFINE_MUTEX(mhi_wwan_dtr_lock);
 
 struct mhi_wwan_dev {
@@ -71,7 +76,10 @@ struct mhi_wwan_dev {
 	 * changes is coalesced and only the final state has to get through
 	 */
 	unsigned int dtr_mdmbits;
+	/* State to send for a DTR drop that a later raise would otherwise hide */
+	unsigned int dtr_drop_mdmbits;
 	struct delayed_work dtr_work;
+	struct list_head port_node;
 };
 
 /* Increment RX budget and schedule RX refill if necessary */
@@ -197,6 +205,21 @@ static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
 						    struct mhi_wwan_dev, dtr_work);
 	int ret;
 
+	/* A DTR drop matters on its own, e.g. to hang up a modem set to AT&D2,
+	 * so send it before the latest state if DTR has been raised again
+	 */
+	if (test_and_clear_bit(MHI_WWAN_DTR_DROP, &mhiwwan->flags) &&
+	    READ_ONCE(mhiwwan->dtr_mdmbits) & TIOCM_DTR) {
+		ret = mhi_wwan_ctrl_send_dtr(mhiwwan,
+					     READ_ONCE(mhiwwan->dtr_drop_mdmbits));
+		if (ret == -EAGAIN || ret == -ENOMEM) {
+			set_bit(MHI_WWAN_DTR_DROP, &mhiwwan->flags);
+			schedule_delayed_work(&mhiwwan->dtr_work,
+					      msecs_to_jiffies(10));
+			return;
+		}
+	}
+
 	ret = mhi_wwan_ctrl_send_dtr(mhiwwan, READ_ONCE(mhiwwan->dtr_mdmbits));
 	if (ret == -EAGAIN || ret == -ENOMEM)
 		schedule_delayed_work(&mhiwwan->dtr_work, msecs_to_jiffies(10));
@@ -209,9 +232,19 @@ static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
 static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
+	bool drop = (READ_ONCE(mhiwwan->dtr_mdmbits) & TIOCM_DTR) &&
+		    !(mdmbits & TIOCM_DTR);
 
+	if (drop)
+		WRITE_ONCE(mhiwwan->dtr_drop_mdmbits, mdmbits);
 	WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
-	schedule_delayed_work(&mhiwwan->dtr_work, 0);
+	/* Publish the state before the flags the work tests */
+	smp_mb__before_atomic();
+	if (drop)
+		set_bit(MHI_WWAN_DTR_DROP, &mhiwwan->flags);
+	set_bit(MHI_WWAN_DTR_SET, &mhiwwan->flags);
+	/* Run now, even if a retry is already pending */
+	mod_delayed_work(system_wq, &mhiwwan->dtr_work, 0);
 }
 
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
@@ -357,6 +390,10 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi_dev,
 
 	mhiwwan->wwan_port = port;
 
+	mutex_lock(&mhi_wwan_dtr_lock);
+	list_add(&mhiwwan->port_node, &mhi_wwan_port_list);
+	mutex_unlock(&mhi_wwan_dtr_lock);
+
 	return 0;
 };
 
@@ -365,6 +402,11 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
 	struct mhi_wwan_dev *mhiwwan = dev_get_drvdata(&mhi_dev->dev);
 
 	wwan_remove_port(mhiwwan->wwan_port);
+
+	mutex_lock(&mhi_wwan_dtr_lock);
+	list_del(&mhiwwan->port_node);
+	mutex_unlock(&mhi_wwan_dtr_lock);
+
 	/* Give the DTR/RTS drop from removal one attempt, then stop the work */
 	flush_delayed_work(&mhiwwan->dtr_work);
 	disable_delayed_work_sync(&mhiwwan->dtr_work);
@@ -419,6 +461,7 @@ static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
 static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
 			      const struct mhi_device_id *id)
 {
+	struct mhi_wwan_dev *mhiwwan;
 	struct mhi_wwan_dtr *dtr;
 	int ret;
 
@@ -449,6 +492,11 @@ static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
 
 	mutex_lock(&mhi_wwan_dtr_lock);
 	list_add(&dtr->node, &mhi_wwan_dtr_list);
+	/* Resend the state of ports that signalled DTR/RTS before IP_CTRL bound */
+	list_for_each_entry(mhiwwan, &mhi_wwan_port_list, port_node)
+		if (mhiwwan->mhi_dev->mhi_cntrl == dtr->cntrl &&
+		    test_bit(MHI_WWAN_DTR_SET, &mhiwwan->flags))
+			mod_delayed_work(system_wq, &mhiwwan->dtr_work, 0);
 	mutex_unlock(&mhi_wwan_dtr_lock);
 
 	return 0;
-- 
2.43.0

