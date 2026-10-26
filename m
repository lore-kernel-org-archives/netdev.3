Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.107
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029414;
	b=fNy6XhuKlcHZBZQ4CTHY1jgkV1UxqliXH2bHanfB7rJXokOmjBgQHSj6gzgo53n7FBFx
	 5dNUhTXyJjZZp4hUH95gNfKtcydEJdrLrVN6rCJJ0Sm0BNqeJgOF4YMXMqu2/j+wZc8Q2
	 EGWGj79tKc8/Y0vDqTn5HVJfs3+LCQiCy5BDe8NuUccQyDBpIzDxr7+5sfW/E2ZkVWIM+
	 rD9fydPCA+dHFYRWViqpvle9W9NnMOVJvF4LtyEuJYTOSW9bEtHXLQs3SKW6D8bBWicD7
	 ndz1dou4OlPURuIoPq1wKhU2HGgfi4pW8fhanmSXvjYEYLs1dKB7Y1/JZZOEYFQ0qBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029414;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=EafIaDZM68hwCQJeP5g/J9b/YTrOo1UlT6rRzZqNfvQ=;
	b=3COTtTLc48GPd4g/RFzFguGHP2kaeGn+wr/pkrTWwNrlLok/7s8bbKCj+Rr6m6a9NBoW
	 ebYQRfR5QhpcH+xCSUFFCK5pPpnPJTbyHfVWxI4EwjvbKo3JDNHB4BeHjaBC7cH4tck4j
	 +vnYKaMaZa98OZJoTj4pBTPaGrASw8Cj0Ll6urVsrSR9bsXjmh9qqYxmhThfST9EGLwXr
	 YKUnEcVGLdXG9OhnEkXYK6NPDfmmI6gbm5kDPULCmmdCOamwi1o5yKujjwITXHWDY1xE4
	 2JVnDfGdjgS7yq4Rl/PENOjlyUhQ+DQc72egD1L9t6Cqnfip8Iy6l9FsApt6RLBKing==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b="rf0XdEx/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.107
Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E3606A31B;
	Mon, 26 Oct 2026 15:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=rf0XdEx/
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022087.outbound.protection.outlook.com [52.101.43.87]) by mx-outbound23-3.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 26 Oct 2026 15:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PekYsV8NvL8sBAdDxOsVMfIpzpzylAcfby1LrzMQmf8+QgYUWqbcF2uW6+gNhN056b0l/pYMz/fSGbkwD10B98/G5ilqJpQf3k8M5JwBQPeqqoLow/zstDyyI0vDlXEyc3rHKzeGmIUNek4dfyjjcS90ssE9FruO/jIZbTd9TH8w0ud7dI1n9+6fYVMLeuInaDXjz8cCRpZ0yi3FAeOjvAC/glMYf+xmYJ9yKoSXtB1Bq8Pb4C03+OZjBChb/wIa5nj6y/lysbFlZ09AdYIEr6n6qs3AjgZQikKg2KAx7aG/qAssYGAmg3l3Yx6IWSgCfmIsXAoMTPx94dhq8lCwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EafIaDZM68hwCQJeP5g/J9b/YTrOo1UlT6rRzZqNfvQ=;
 b=OaWxJdpyy0CEBMuPEPmhSeHvUfBcE1OdykmTL5Wyzme/p7GHtjzOqR16rPB8gI5fqcHi0qF+Sd9bQfgvT6vJsXqaXmK99SdicVmtfabFmON2B7RUljxvJrrsQ2NMuG4fJIzw+cRWySWELgWAj+tPaQVTqimLcHN0fG2CQaQlH7nCNml78SUuzFztoPXWoHBMmPgWhXvQK/oxFdBY3cihxwcw+1XpXHoG8xChzL9yVZE7HJvI65Bv5BOHZSlmzg5KtNiWNRAVv9BuDAiR2r4ODrYGkRSwRhr4ro/NTZ6d6mLqVazXif1bMRYNd5bqHJfEUZQQ79HuXg20bAbWLTDzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EafIaDZM68hwCQJeP5g/J9b/YTrOo1UlT6rRzZqNfvQ=;
 b=rf0XdEx/HGq1HfLkaNL2O57lyb9q09wxfn/0Sc+jMkcx/LDS3POVDbTHeD6rgDovh0U1o0kxZUcgPkE+sF81mf8HaTNyLYeYkA5SAvtSGgFNhMPIJhFZ7ZuoWzvWWsIz8ib9MGe8pKklxtVsDDrpGf/CQ5W/Y7nWcmVqKk9o/RvIj2z8AISsPKzypBF3kiD5ZMxk7d15vftjd6y+mQQGXr/kc7Zt9Zk5HEb2N/SdKhlmfn3plgDJ4H0q7Ofl20obIV4LW+IapI4NpKubNhJ3dpcjGMSn7OwyAH2+HeTC8KGUJ5VCU2itKuG+MpkSV6qetTtYOwhXIZTuyOvLSSu+mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by DM6PR10MB4170.namprd10.prod.outlook.com
 (2603:10b6:5:213::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:41:00 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:41:00 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: netdev@vger.kernel.org,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniele Palmas <dnlplm@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: mhi_wwan_ctrl: keep DTR drops and resend state when IP_CTRL binds
Date: Mon, 26 Oct 2026 09:40:56 -0600
Message-ID: <20261026154056.4037990-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFEp6-1brLBvgkaNK7bnXfGwHJkF_sqK4mdc2zaVuLw3_4+djA@mail.gmail.com>
References: <20261023174113.2388353-1-peter.hunt@opengear.com> <CAFEp6-1brLBvgkaNK7bnXfGwHJkF_sqK4mdc2zaVuLw3_4+djA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To MWHPR1001MB2095.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: d380cf01-4c7d-4988-b39f-08df3377882e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|4143699003|11063799006|56012099006|261026140227099003|22082099003|18002099003|10067099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	F7Fhs+qrx2UnHovT6f9jP4FL9MA8GLFK7opj8TS2M/CIDV21Le5fDSzSOZ11wo2gxRm+vQ4ZWkDE3RoSH9pgE+EWwmwmHoytjYlFC/b2z1QsBKKwblYOsHDNXp9aIYul9Qv4sXHCRg6zhoQBtm0ys0RSegzchE6qwTqb5H+mhUVOona0f1YbjUnr6V6zU+GJQjY6ohheggEb6q+/lQSGGdjo6miAsRX1Q19XD5hZ56leDuxziSY6MWDuNkkl505gcTk606hdsTSEuo+Y6oiIXbuR5OoaueD5OsdZsjSy0j/qavBzAnpynkYL5yu1D/v9+bKJqm9uY18cuzhinLJVKXeAzFxnLxEseKSqf9FmnHuKcMrdkDCAlLVIcc8aoXawtF5rd3UM/qO+bTIBLrKzjoDGaIknZy5FTMjeaAapFp710kc50p7ZO3BI5iRbKKKOZ+S3UHVh6NDXHU4uRwBMvnzIZ/8ymKAIxeack6IlbHnmFQpwHWXyaaPJ5pZq0rapVETZJ2Ri+vFGq3gGwJyyJe4L/q8pPL8sWIZOj+zxjLUcfiwxKTQue1YBVrDmMX4fAAQPi69nD2byNpW9C8OtPbWPqZIjpugVADZcBfL/dwvCmqNclYr1/COWFe8Mmb0LnDP+0YfrKO21FWc2yUzeZW8wdgILJfQQ4fNLPPepciA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(4143699003)(11063799006)(56012099006)(261026140227099003)(22082099003)(18002099003)(10067099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pli6ouaJqXxZ2695njeLfDwsTh3ZB9x3ACYTwJqKJ3e1Ye1FTqQmF9fgc1LV?=
 =?us-ascii?Q?9bOVEBat2zQF7IrkAyQm5d8pUibhspGBdxj4fa8ekCT6/QIsK+ZAOObku9GH?=
 =?us-ascii?Q?ozm+3GcABs9KAy6RE81TL9X+J6B2dSGG+5ZtxqtJKChetWToDLuM9DbNNtP5?=
 =?us-ascii?Q?qd/YQGbCMyIvENjI2ypjgWrfNUORSPKjQNH3aWWoFBjlLDYl4cLyNY7kAtHk?=
 =?us-ascii?Q?HkCQmqi2vc+v9H9CuRRDjt5IRDLfO1ODimRoxB0XyeG5xrOiK+BfHeRAVcGb?=
 =?us-ascii?Q?iPZbX2KN5buKAdDUsnUkzO1RJ/GOh3pJn6kg+ld2hb1Cx6xErJtE9CXXFPUT?=
 =?us-ascii?Q?4lpzUUHJ1uYfK6UzbmPC3FgoGQBPrwRYuFCWUVSMuXKHUr6IPkW6+EhnfzQa?=
 =?us-ascii?Q?1yBU6rS7LTbFYWPIFcGstLnijreBxHM5f5BNuluV27hifY07GgBBu6bmtg7B?=
 =?us-ascii?Q?EH0BYrYmnQJ3nIWk+pz67xAFNln4L/PabpmbvcoOrQ0b8J1yk9XTEoJqHPHk?=
 =?us-ascii?Q?nMCd03DU2GKjT6lAnUYKWdXzT86KCwtJYJshKHRX7spGqwWmCjM2zJmu54/u?=
 =?us-ascii?Q?JMQBA6AlAtWoyDLzRX5kRp8XtMs2eH+4N3xidcbwFOiTOhpV9waXHIYUyth8?=
 =?us-ascii?Q?RaY5w7YyVc+HfrIkAGfMdAOffzRi+3eXlSUSlylp2T9LJtbKj0zd/lah8dhw?=
 =?us-ascii?Q?yV95ab+vUrg7z02v3Tez/YgzkKm29QAFZKZ8ogcvKzxw7iVC+PfnBhsWZGys?=
 =?us-ascii?Q?dK2ZrV9M8w/3GMp0aNjomuItYMkqhzPRQCT5cGeXgxjksqVWvtU5iRTaDbNk?=
 =?us-ascii?Q?tUfxMY6lzLqn5Hw/c86D8NKkn6XUUCIuk7NBPFvTp/FoXYmiqCzhZWSnd1tp?=
 =?us-ascii?Q?ScGYGdFQuOVrvZa7go1Q9UwxviDwV9u/p6Tvjyc79fKgLa+qzxKiFIrdqvfe?=
 =?us-ascii?Q?SL8a3YABJjJO7KW1x/WRnt4PFiObUXYFB1cXwHMLNigBrF6gchPYRvXSpQaj?=
 =?us-ascii?Q?o09RUxs/zS3QNuzHdKrGZE2XPO4uF4JSzoyAJ9XAW7DyL31uoEGhRlsZuaej?=
 =?us-ascii?Q?JtKvlePCNdHg/P/PCWITd4JPtsqeRxuxDLV5MsTOoiNYp/MRYfXuw8N+WF5W?=
 =?us-ascii?Q?e/Jwv6AmnmcHvi3B33noNY51FxTSZKRGGn8c2SSBrGuBw+9iX+w2q0y6zt1K?=
 =?us-ascii?Q?N4cRrX19lBNBU3/NkFPndFhmMrFf0A59QtyiDn3fUha/XPjGGtwViRHUjZXZ?=
 =?us-ascii?Q?Sj5Ne/CCyCqOP4a9/lhrGuGQ4SnVlmW8vgzS0FqJEcHU2wjKumyUhvf0737+?=
 =?us-ascii?Q?cAaTD6bDayITsBMgda3YJK8YqaiZHYwHtvr/xqGOlOIyk1IynH3Sluv7iwpF?=
 =?us-ascii?Q?e3yBp2MLoJe5WCKKavjIwe6aa1htNMsj3K3Gf8l38OnmNOPe/OEYfN8u7YtQ?=
 =?us-ascii?Q?2g0hJdp5B98N/YB+WutiXysPnAeU0f1zBsc0Mg++vtRvo1Isy23L6VqmXnn8?=
 =?us-ascii?Q?vEYokLqdikH6lvRNB1zP1NmKRYYedEORph3M5HGvu29YeHxphFRoDQEPiTRh?=
 =?us-ascii?Q?UpImco2HdIzQr3YEoyIjA/Y6hFlUfxfPlAGPEB22PG2lhK1kkg+YBV2WM+W4?=
 =?us-ascii?Q?gnTxSdWEcvpGPmm6ROWqox4+8WVLpNlQvq6jVb3wUulD+6csaevy8Y/S9SWc?=
 =?us-ascii?Q?OG+USwkpAS2oAMbRwu1BghOpaObWu+6EeqVHghvJQT3qTc7H?=
X-Exchange-RoutingPolicyChecked:
	itiIaqJjhY3J3kHGYkFcK0vv/sLpazuJ3TeJz6Hi+Ktc9/v21B6UmfivFUz8K2JW8lkkdvawaCAC2NaOqAuGm9zwUgLkxtHljMMHmwv7mNh4AE91fiv2hDrPkDIl05o8n+nz7jJVCvYUqI7ARbyewEofYRZN31LXXIlxnyqYWcaM+aWNUdD+ChpTTTH9iWYZfRRdWfPoBHWDx2skqSilz7khxD7JunxLPkVTmIY7SrnXRqu1B0TVXPFptFyrNS7neKaD/lkDvk8JaAV8Ni0re42C6jRjKBWsogIsJoslhZg4aYmncjtr2ERzIUZEWGlaFogt3SbbE3uzUwnP3LMbQA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d380cf01-4c7d-4988-b39f-08df3377882e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:41:00.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYem/cwzWCGODr7YzgejJn8dsirelUwDd9jfomdOZl1ltpVK+yplMb59VNFe+kWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-BESS-ID: 1793029384-105891-7638-7396-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.43.87
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZm5mZAVgZQ0DzR2MLIyNIkyS
	LFyNLI2NjcMCnJ0sDE3CDJxMLYyDBNqTYWAGtq2gNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277126 [from 
	cloudscan15-41.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi Loic,

On Sun, Oct 25, 2026 at 3:27 PM Loic Poulain <loic.poulain@oss.qualcomm.com> wrote:
> This looks a bit over-engineered for the reported Sashiko corner
> cases, and adds quite a bit of complexity. You'll also need to handle
> the lifetime of dtr_work and ensure it cannot run after/during device
> removal.

Thanks for looking at it. On the lifetime, I think it's covered, but
please tell me if I've missed a path. dtr_work can only be queued from:

- ->dtr_rts(), which the wwan core stops calling once wwan_remove_port()
  has cleared port->ops under ops_lock,
- dtr_work itself, re-arming on -EAGAIN/-ENOMEM,
- mhi_wwan_dtr_probe() (new in this patch), which only walks the port
  list under mhi_wwan_dtr_lock, and remove() takes the port off that
  list under the same lock first.

After that, remove() flushes the work once and calls
disable_delayed_work_sync(), which cancels a pending retry and stops it
re-arming, before the kfree(). On the IP_CTRL side, the work only finds
the channel through mhi_wwan_dtr_list under mhi_wwan_dtr_lock, and
mhi_wwan_dtr_remove() unlists it under that lock before unpreparing.

> I don't have a better solution to propose at the moment, but this
> problem suggests that we should enforce some level of ordering between
> the MHI devices (channels), or introduce an explicit dependency/link
> between them.

On ordering, here's what I found. On the EM919x/EM929x IP_CTRL is
channels 18/19 and DUN is 32/33, mhi_create_devices() adds the devices
in channel order, and module init registers mhi_wwan_dtr before
mhi_wwan_ctrl. So whether the controller powers up with the module
loaded or the module loads afterwards, IP_CTRL already binds before the
AT port. As far as I can tell the late bind case is only reachable by
unbinding and rebinding mhi_wwan_dtr through sysfs. What I don't know is
whether that's worth an explicit device link, or whether other modems
would declare IP_CTRL after their AT channels.

The DTR drop case is different, it doesn't need any unusual setup. With
v10, a back-to-back drop and raise from userspace (TIOCMBIC then
TIOCMBIS, or a quick close and reopen) was mostly coalesced into just
the raise in my tests, so the modem never saw DTR go low.

So I see three options:

a) Drop this patch and leave both cases as known limitations.
b) A much smaller v2 that only handles the drop: when DTR goes low,
   ->dtr_rts() flushes dtr_work so the drop is sent before it returns
   and a following raise can't overtake it. No new list, flag or
   field, and the late bind case is left to the existing ordering.
c) Keep this patch as it is.

I'd lean towards b), but which would you prefer?

Thanks,
Peter
