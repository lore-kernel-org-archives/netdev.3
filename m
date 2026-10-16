Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7B396B9D;
	Fri, 16 Oct 2026 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184244; cv=fail; b=jLxzMqIdCRy6PlQ3t3esrcJs+wQzpLbVWCCCeHeQzjCI+F503hyZWrE13vcPtW/+gQl4HrZYWUl5WrchwDp4nH3VobEsobefYMehmb/VoeVH0NjMBeO6LMEyikPGyZZZNhNPibz4ddLxexAoi8V0idNeBtIT4wdjLPquQDv0las=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184244; c=relaxed/simple;
	bh=/k7ayY4gTeTmD13YyAEXOFUWj+iulilD0uDbPLgeTCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyoWWHADonnENqUXd6pyMYsCokssBnzB6GdFCTJkjRW/70MSQGtDiyQPMLRVN6lwpxpiZOBo9kB1/Nl9xnTRdpY+29WiqN6XmcXp7d2qs0R1Gyb/J4HjhGu85UmU22j0Gnrqy94GIVlZKSyECbGP0McRkvP+Ii0Cpt64T68w6lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=OYotVOsV; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="OYotVOsV"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022093.outbound.protection.outlook.com [52.101.53.93]) by mx-outbound13-188.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 16 Oct 2026 20:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdN9HzSAH2Yk/eRPh4cHpggZuAfSntgm+b6/OIKLoofgfAnz2+oLUuWc5jOnPBm3IiwM+BIp/Ck+QbzkLpNpbNclvsaacD8cucuT/SUAQbMZnKSJpbtKdKYg70Meu9I9r20DbEvFiYW4+wCfectrvIIE8BFk1L66iqJ+1QYbh7Cnnim9TfWvEwSjx9XTCaYm6T1nA1OqK3jKZ0ajND7CsaHisgquQ9RJJJsZlDjp/AKMPKu0hL2ZsTxMCRIpLe19+Tja8HUdyhN+jcaty6pmmJaugFjDaVOOMcb0cxalD4ZhFQQ42mYscEbS7P9x3pD17f5PQ61E4iBDAZGXt8vCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k7ayY4gTeTmD13YyAEXOFUWj+iulilD0uDbPLgeTCg=;
 b=NpkZ6+xpmW7glqf20Ncf3xJx3OnAx3pbwyzQadXOMfXvOwkMA4ofRKMHKX3XoIPG84nUuo4Bq1AbVJhNhF6QdN12ZUw332RbHfbK8VRkBRa6+mvtCdxpcPr9rJIxLCWihi6CszZQC+DW/JqllP0+1AEW4KE41EbE3E1EuXMudXh2Wsupr08T/IYV+XlLLxluKldnGBMBcCr1NF75HqD8sGQPEsBtzGz9mP/xEkX16jahDeKj/ri7QAMlcVYoyb9PRKRQkb2kC3I4naRNIhb7+eUuKYnmto7L51Yl9n6msBmh9jwGumLUIMSs9Rk4egb9zNOd8YZoyli/w5l+VwbKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k7ayY4gTeTmD13YyAEXOFUWj+iulilD0uDbPLgeTCg=;
 b=OYotVOsV2iYgr7mMWPDrXGTZ7HWwqZ5znjIYV2w68TLcAuWcpZGW5l/mEH46gYhvQU9OsMgMKWpmhpkoG/CcG2XBcJMrFCl+GgP3z5u9W0jxkDoxNcSts8jOvT1OEj1zTjibS4YUNELx3nDV3xWnLMh1Mhj1a3RO2JusqPhDIMJ2zrPkhcS+KdscHs6MkUGa11/SrNtMnfKzKA7QcryYAHIgcjpg/oH0EnV/M1zX9pvBXji+XyAKsi7bHjN+FpUiVj85Ubel3uzF3trpOXE37vJvFXGvCJMyGCS8q/FIFN3D+dUaiZNfXz37z84i4/fTlQ1cOXfK2cXHhyEs+6cZ/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SA1PR10MB7682.namprd10.prod.outlook.com
 (2603:10b6:806:375::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 20:56:53 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0546.006; Fri, 16 Oct 2026
 20:56:53 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev-bot+sashiko@kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	Daniele Palmas <dnlplm@gmail.com>,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	mani@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Fri, 16 Oct 2026 14:56:51 -0600
Message-ID: <20261016205651.502760-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179214346234.434549.2545307661462448073@kernel.org>
References: <20261013183500.261229-2-peter.hunt@opengear.com> <179214346234.434549.2545307661462448073@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::28) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SA1PR10MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 255c272d-285c-48ed-9b56-08df2bc801c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VWIprpDEGNyPKpahH9zF3HUEXI+f+6avkU8d7Jmrn8pzPo41LCFKjcfFjXTGwNZ939f2YQTcET4YRt/qnS3zGs/7dXC5K75arx9VcXz5FSZrfOk2TFw6OWRH3QJlQUJeuptHWOz/n7C5SEW9evEU5RZblaJznc9JdZEvDmTYuhXQmmDChF6PNB3Fsza/ABIU3oGZu5oKV4KimhmhtQdl4z0zIqbEEo2YVAZVtOe5X5Qe/OPHw8RJb8FTChBW2cXe6EHBoT4g1MvCqRR6n6Z3Idigzrd3SL/fr6DZGK6Uo9Q1uY+nWhYoJ5V9kBP1/1jLnh+73eYbjfZFEk9AlrAf3n8MtJtf982zDP0/fD7qlEAwQdp3YEykxGiH5VfKJnD0F+hysF5RnghOn0o+5gxJAxcjhCdHjOjDStqYuucNzYNs/4cxknc/ewZRU93ari09T2uDYi6tR6cV/LG6XjLjgAHnmBH5SPIK3HXA/6y3DUuwMHCJlx/JXwzIqZ9ByvEOvgjBW9d3hcj2pbbSTC5Cq8A7J+aF8TgU2WLijF2mBy8BA7K+zoHCEX/rSVYfC9W9u+eaH6KewTEz5+pyHgiDIxlEFYioS64qH2NwZs69uOJElTRhFGiG80ZnMfNiQmL/YN1RDc3ShVoJCrcOonqJ5O0WCK05HYon339cZ2aeOsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rs7tITeKD3KaOhSo+8OyTHiJrWbTqr2DgbH9aI85+6RJWPgU9fwUsng2rM+h?=
 =?us-ascii?Q?K+Rhh6qIRTblCZ1cltPSdc0HmGc6X8Xw1UUZuFoBWwm0dsu0oXqVm5ND8dfW?=
 =?us-ascii?Q?+lkgXLIWqadFQ0ArqnDPBWw4HIfri85k5Q5jshikLzfh7NSTC+/s6ZeGRaAa?=
 =?us-ascii?Q?fXFH+6zfDYjrA/1CM1OMxnayQW4yMqk/4pZjbI1RA+nVQkQ6lLH3Exozebd/?=
 =?us-ascii?Q?WZN1g1zTkKTRZJgNkfVo5dI48CHX92e60WiRaXklGspOjvFXOJrImwxdYudo?=
 =?us-ascii?Q?JdhdvMSnTQ0V6aYFqn7wkOJ9i/bmIXuZ8HTuXaWwb6OeScMZNIobVuOyDwij?=
 =?us-ascii?Q?+CbW2RG5CjyneJmrTVVHTCOnYHFK/QsnvhwFwhjCYlcSxyqdyip+SBBsSGM3?=
 =?us-ascii?Q?ZdyJYSImHsGFx0vwKWITnTLA4eG3r+mmC4JkQYKx0ecjp3u525MPY1vakkJI?=
 =?us-ascii?Q?yT5myXQ5po5OJcm/N/dh0smWSP+qCkdvB0lTJeS+Gqc4fMSMFGo/XCOj1YOL?=
 =?us-ascii?Q?+f1HkK+cX2ysh2coWXA/38jr9VmDmJmK5WNXGAq3n2Ar2cRKqeF834SrTPpm?=
 =?us-ascii?Q?m8hpGj7/GzZ8sdjaXgpabyr4lsgwiV2MYOkLEm8SR0K1h2FIrSSrhrdJYgwb?=
 =?us-ascii?Q?Pv/MmgO64KJh8OCZbdIEOmIQIYDuoHmop0xMudjSFvaBpZNtZ88MSJJ1F0XJ?=
 =?us-ascii?Q?97E+TL99pEmGUtK20FALvDx+c0qxMi/rM0C3ICVYixRhgtxMcugUB2NXyeDQ?=
 =?us-ascii?Q?lXCYalBOFxlK+4QNF23TQAOOlMukCGzJ7ummMXTfyothZOy1kQonchUaFH/N?=
 =?us-ascii?Q?hkc6QKfBTfIvB8kuIBopkSckdK085WCNfSwcd2I0qA7+3gLPzPlDAo+wSgbO?=
 =?us-ascii?Q?R9jDSXAU8GYVWToz9frA5/kYAH3iGJnFDaIoJmc12IIiN9AdgtO49AcfQWqh?=
 =?us-ascii?Q?v+IZvfdMhE0NCoFA3Ko3cLS4YYbk1q1ulvRRR2WsIXOEEiMX+KP0wBdOPRnJ?=
 =?us-ascii?Q?v2Z7pMym0/FNCSZUpGYRACNe0qXpAMUc4Hv3B3NYKowa4GDJyeZ0XIu4kiV+?=
 =?us-ascii?Q?0/naTBWeqdMsbc1sc6T8v/WDyTc8hxhkxStVesvT9olr1elYwn2M1emvYf83?=
 =?us-ascii?Q?lhW9Cgq0bb02z3nfqFl5uAY2nulWP5ea3a3nnoUCqq6rOWZv+r388jEnGBu3?=
 =?us-ascii?Q?ZJmxsj8NYmmfac+qSF/dmw2tr/AtN/++xXB9VGGY1JIZbzQGG8Ik2DRiv7jP?=
 =?us-ascii?Q?zj4FBn6rOFDdZD2c0HhdpWAV/u03MPd90fP8lAVJJC3pV4DHhfm5em5Jfjcw?=
 =?us-ascii?Q?XxP8TJAoFHk3kfHHz+6k9K8dP5Dkf4KRXkSr1IVCc8kM84PBeLr6Gf8F/HO5?=
 =?us-ascii?Q?UUbOFvtBwLqck4DcGtykBpRMNWYOmHY++F3rg/KOMTfKi3qvrQkBYI9t2ROL?=
 =?us-ascii?Q?ogtTDU7mDp9Xr/Gd9dllp7K/fuDleLgLnA2oDiA2gApCXfUcvW6q//wyB/f2?=
 =?us-ascii?Q?bocWQudIV4ndeFyKbvIz1C3ySwV77f2eGCN6bKMF+idineSJe2tMQxmdf7oG?=
 =?us-ascii?Q?1kDhnqpmdDsHXfcn3OQfIeVBKxUw4kq9CzBLLqou5hy+JYjEa4t5OI7JpS38?=
 =?us-ascii?Q?NWiw1uTHxk1eu89nLBQVM8dwndYMLGfYR4lYW5dWTlIYsBA9QrGUn9jIoBHC?=
 =?us-ascii?Q?NWwfClF2n1M5NKoScyTj19X8FMmJ9JVPmCD7N0ltp7k/NKrP?=
X-Exchange-RoutingPolicyChecked:
	rLE/ToBeMzaQ2EN/P+GFGKlcCe8Y19bHulbtS5c3xUuU/MvLJ+DtVwu36GWmhCp5efVIUwXjz2f0bWFv4xUjUTrIDJHU6vA5ClHvsPOkgp75WOe1K3rugDX2gPK7vTMhLPxPWkwLA1jHeh0gOY+DZI5GUj1D7f0Sz48klXNpAJxyN9ubdpovSBH0aJW+4GFYiIe9xy0gwAHRxfO76eMp6UTfNTU21NS6XoeDmem40wQBq+VdyTn8nbEAhyte+USlxAsrrI1L48dwEhYFv2oCvr65iimngW9hpD5pNoKW+e9q6VM8dabeuQQsnefbwrhYE5nBvHwZXzRhxXdii6B/SA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255c272d-285c-48ed-9b56-08df2bc801c9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:56:53.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apy+qlxrDrFZKHnoKxh2ZNiHzdviGWMlbt+3pFDPyQjtMQ5Top0E5phD/VDCFDCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7682
X-BESS-ID: 1792184215-103516-7712-12508-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.53.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbGJkBGBlDMyMzIIC0xMTXRwi
	wtxcjC0NjI0CLFxMjCxMAoNc0y0UCpNhYASXAsk0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276892 [from 
	cloudscan22-9.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review.

[Medium] termios/TIOCM ioctls waiting behind a blocking write: this is
a trade-off discussed on v8, where Loic chose a single ops_lock for now,
with finer-grained locking possibly later. In v10 the lock is only held
around the termios/TIOCM state, never across a user copy, the wait is
interruptible, and ioctls that don't touch that state don't take it.

No in-tree driver implements both ->tx_blocking and ->dtr_rts, so the
circular wait you describe can't happen today. If the maintainers would
rather keep the termios/TIOCM state under a lock the TX path doesn't
hold, I'm happy to do that as a follow-up.
