Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED50D1B983F;
	Fri,  9 Oct 2026 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505102; cv=fail; b=NzkFhBjOlxIl0Ic0f2xq13Bofe+tzZtTzM72RGpOZQGcYLHxWwTeEG1FnhxIAXKkPOuASNiV86koIkZwQwiNgXUIXaB9jIUfNUICnN3GKjsDTgqWEUOCp/b2U+xdi7Tv+zMhLzBFsWoJfZbD3snnXTaroBCyfnk66ZKMfEhWZ7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505102; c=relaxed/simple;
	bh=bBWcEIKPUJDGk0LW0gLgm1CxirtruksLi0DZiLf26PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FV4Ic+9QGno9wXa23uroqfoSfbPTbfIYf3Y2EuqFH83MDzCNvewwBnAmpT14FIVIbXbQTtxlWRbDbSn+L9cfrRTGhzj6sqB+kWuxW71rKFIkOK571j1X0KahhKNSVlzapkSXWh/VTYcIEjfSyTwO2hbMXTLe0hXdm/OPXZrb/fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=RNjUjPp3; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="RNjUjPp3"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020110.outbound.protection.outlook.com [52.101.193.110]) by mx-outbound45-17.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 09 Oct 2026 00:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcwgoqiox9KlIo1366IfsHRTTm5hVOYyBxVNjAfyAgfRMm0gVBSolwfvZH4K9gdxXxKttwUrJLg3wal84OfVFaWqgt6tZVOgGPHvjyOKoLWW2dEaaj7T8VW4yyoe6k95fE+lLuTQKfxGy6iNkOg9osoFCzKPLeoyLpkeGNhakqPQPXwaf6WdQvQz9wKGAi3JWBpZ2hAiWFQ93vwrcVJirr/3qWjYVpP0x5mPymGbk9hNIlKiYFP2UeA8J+d1nSI66JfUQ8y31Nb0H8+O/AVZqeE5bQGcBEq5YCCECpbqTwtWXfGMKHv6fzpg+jW4/kVNiygrRDI32z/rQn9pYcB7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBWcEIKPUJDGk0LW0gLgm1CxirtruksLi0DZiLf26PQ=;
 b=J+sV6cIixYUgwwlTjhPJvsodkBZDGsJZabicnX9lF7FEmDietks4JHH6Zm0HLusr/L96GSETH1hGCjXD4erOBPunEdF0mjm4Dldp+Yi62x6JYm8E+6vY+lH39F+VBWhEzr5I+F8p3p2FGcOQvs0Clo5C9Dm+TmJ5utq0zELAlquULrb21GJxj6MBlwpulOWi5Ol/RrZqyr9Pw8KOu0YHGYNiG4oAx+m9Z/hBRJ3AF4pJIgVkLfdIYeecXWrUhyDU6oDw7hfExU0qdKPN1xWbj1Jp/nhOVFon5KfLElX8tzfyYBgDfNTBe+8Ab2PjQUrzDEb1FnRkUyz9CU/wNLyIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBWcEIKPUJDGk0LW0gLgm1CxirtruksLi0DZiLf26PQ=;
 b=RNjUjPp3It76Owa425VuSw2+ZY/hoSv96eVCF81OUeNRv7yDqnwE0pLis5PQrofn2NEqxtJYzsawtZZpMGDxAtGcCCMnl3dAnjx05yvk9/o4HZlxANN4GikmMSDk7JI/9xptxUrkJnIOcL835rnzfHISRNpxrI2wlZ6eouLfYHu7wvPwdKzqFhR7Q2QpPjDeee7QiEkrGkPUuQG+IzLzhO5Hgf74MOz3ul3RDwFRPvXwaKLgN6WZue2YSGkFQwdU41zuPCjGJjAMrTNj4ojPdRqZBaR0t8Rzlcd0SoO3YLLMAHn2vCHpSm9JIr4xCCfQj75D40IkapalXFKo7l4vKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by IA1PR10MB6100.namprd10.prod.outlook.com
 (2603:10b6:208:3ab::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 00:17:44 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 00:17:44 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: peter.hunt@opengear.com,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: ryazanov.s.a@gmail.com,
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
Subject: Re: [PATCH net-next v8 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Thu,  8 Oct 2026 18:17:41 -0600
Message-ID: <20261009001741.1081798-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFEp6-1gb5KgK5rtz4U80AGvs_g2ZPELUge9Q=bhy4+=coJ-GQ@mail.gmail.com>
References: <20261007182238.1154851-3-peter.hunt@opengear.com> <CAFEp6-1gb5KgK5rtz4U80AGvs_g2ZPELUge9Q=bhy4+=coJ-GQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::16) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|IA1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7928aef1-a5c7-43c1-06a3-08df259abd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MGeVwMr6CriJ6OnZE9Dr9U6S+j4BOXMFK2pEX+pC7hXXakGp8VI3aOp6wLYsBe/FpwhhYGiVpl2HE1iU68SqzbMCWAEShKkvOrMsrTj7fekgPNudq9JvyNpMr78aLY/cBPHezSA0voYeu6CdAXxFICrvzcoXc64xZLkqLmVfwFzxiucMLN+YUapXh3xEfcVcu7+phmh2GhKjAEBNzNCi3QewNfo4NxR4PWlTwx+dZTP51DVqJuiTtEL1Kfh60lueH6Eg9Pneb4jwVGWYQFH1RIz456aomNi8m/jnogMz25s7ss76Bs0oUa+l8kfBJkgxjf2693VHMg9ho0NmHSBrZNTh4fp1EWytnAXuD+d+i+estKoLnKqQ7LrLEw8+GhnNM/PlFu8JVW5UW/bP3KJKFRBg0LvAo6o+McDbWBCKrOLk6c9omZdJ16ZXlPqEwUYWoJXpM7+KBIXzYc0vA5JD1T+qyTZsJ1lTEhZzsnh+iXUmUv+Uo/gd/LPuZqwtQs6dmr9yOTc3fq6o1P3/jBkuIeHYqZU+kd0yBuvKTsh2omDOicwiw8gHrwOQYYlxX026BLf6FvlYZ4RByDPCYwWyUT276fitP94w0LXsn0/CuhnSkTsKg2h/K9njhwjeo1+YeLGObGrsFLybxeiHcpudGzlk7m6EL48MmuinzfcSmJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vaLa3WUz9McVnHSX4mKAjVceE8kdedbCyqaORkw5trhv9CaUha8wNOnckI+O?=
 =?us-ascii?Q?U3sOEbORVM5NviP+InEF5vRKRI/60EYTI04l2QcwdI+nwMoJrBn6FyWOytLs?=
 =?us-ascii?Q?MY5+Ud/ubja+flJbJ1WdVmhbSOQqW4VZtOD9hsoriRetu9pBdi5Ls4CITRZ7?=
 =?us-ascii?Q?asV3euKqRLxeJ3OJ4AvdNVsoIynObwjEMtw/T02WXT+7GalW60bcf8uvbmJw?=
 =?us-ascii?Q?ZiikCdyy8ckzgE9B3vMF0xGMpH7aR5MYufjqOo0uKjTE3dZmrqv6MSKFkQS/?=
 =?us-ascii?Q?MHHDAM/tw8z+8Ceob12AOX8sxE/nATif9oVFYOTJ/4p+SMNXTKwKh3EpqhlO?=
 =?us-ascii?Q?sR8DQARqr94aXKdcoerHYJzqWzgNYaPb2EpoyxxcLmx5RsVNoR/cSVVR1E4T?=
 =?us-ascii?Q?HCc4RssfmdH8uiXjV6PjS7vwx0t5ThdQmX6NABEkzDdydl7esLbE6DRjtu9y?=
 =?us-ascii?Q?blJPYjHxAGcXy3hsPNK8VVVOATU04NrtyKB6hWh9HnjrxfzAwrdl87MXIbGi?=
 =?us-ascii?Q?cLpZBDf3A3+3mTEFQLDz9K7Xr1YQ/hctfPekAvCHNHz925Zo0fVARAmPrtWk?=
 =?us-ascii?Q?b5uotq/MTDYdGbBxItxxa8KicLUCQFO5cPRGpNOquF9LHHuTmjdIQ3XwO1Cp?=
 =?us-ascii?Q?4kl8w3wRGM03KiExxVyOsYoLFgVwnx3VC29lykUXbJcudXAy0vH3CYWukjmT?=
 =?us-ascii?Q?nZAAxc17J+uHVBb9jfU85H5bq8qIPDHB9r4euqv46p2zTLfN/WzACGBEAeGS?=
 =?us-ascii?Q?6FfgQWdHgtoaYh/wBS1Vv/iUzAZnf8EaYuZxDEbwN04Efctg7PaP2Jv+Zkt1?=
 =?us-ascii?Q?M6/Z04HhVRxLu+M6VW1eTvKligkaqrRtxjOAW0kxznjEHhfli+9L+iIWo/53?=
 =?us-ascii?Q?Q7BHoev+65g+hxgQksXb/uUH027HLvr94wYxFQtgP3U1RfuOjAelRsdVeFSt?=
 =?us-ascii?Q?JpZGvtUY2dlSXoLVtnf8rUKPIlj0jYpXazTuflCGdRrE+LN44i5aGHIApngx?=
 =?us-ascii?Q?FNFzW7hbDk12hySmYL0OVQGsmzVPhGvPhoZ1Ja5m1qa3OCdKQ/wOd10plALs?=
 =?us-ascii?Q?uqIwWQiDzJw+2ydVI4fM8fVUXwgrYDvuJ7qzUbV0cweRy/0zy0w14rDI8kw7?=
 =?us-ascii?Q?VRVFtA8svkH2X9aURH+dFXekkc2HNHkqG0XLNWn04NvZCLVMbynKGv/pv5ZS?=
 =?us-ascii?Q?Wwlu3UJLp9HU5v7ve1J/DmIcxpMA8456iM7Q4moRZamByRdtRgqxOP4EukQY?=
 =?us-ascii?Q?Ocm8JFpjJXOEMqiGIaZOTMulY3Y1QrpLc9QypzOtUdb9bpBlEdcIveOfaBtg?=
 =?us-ascii?Q?yHPOS5G9nmrzWR8h8ZyutCeO4qkuF7zlIwJssNi1Ow46UuVPmKKK1saeRDq2?=
 =?us-ascii?Q?LgCbzodar39b+dyANNYRSQCx6B3VAsdLgOJM2J4GrDl67XOACPJE91wGt+Pu?=
 =?us-ascii?Q?13qj5vVkpU+7qzVskX5nmy2wBV46GhVIT9RtuyNoN1fycvsJYsbolbU3AW9I?=
 =?us-ascii?Q?Gm/aq/YMnpss9fE5X4creQRKQiaSBv+f6SFrqEDNvJerh+cofs55KfrpaTHn?=
 =?us-ascii?Q?yGf2rZD7mgzaxd+dIiks53Ui2QUnowsQapszKz4Y5MykfOy5TYax5cLD++04?=
 =?us-ascii?Q?8bPOI3DBRMCjP7RBMD4CqZZyEu6VBUQCaVezBuXnxTKsEgEhbEDNYx2esUly?=
 =?us-ascii?Q?S3cP/sHDiRAycEUJmW0gN0DZ2hyiBGzuNOcdpoOVKItmbbsC?=
X-Exchange-RoutingPolicyChecked:
	fy64TssHpyH/MogXYVP56hv1O89pqWPmMsoXQxX0JUuCC2M7aIBQwE8aOAs+qCGYHAfisLJf18/B9PcZFUyrfeVYkwyNNnyv/G2dFeBR/XeWzt4Mmi2Hxpin0Gh0dXmL2o4hl+hW/4HEpTolB/CciM6vpU9esIVZhk/xlBbTjl5vPL84d0cUwcR9WrNyybcbr3VeklahyDEGVsY9rj8hrRkxhU2nqA1RwruPLOx8AyMmcNJIyMma7I2W4T141Ut9URDa3j5OVxy3izH61chyeigLfOVUmLuZJA65Dy87G9ub3rEK0P/LKHaa9UuPJkVjfVQxVEoKHUGcanbX6+9ZFQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7928aef1-a5c7-43c1-06a3-08df259abd87
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 00:17:44.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6k3x5omLR1MMEJVUjhm+Ryv8c/QOUgtWuUoN2cebYO+F9hCIA0UaS3IfZ9jObUI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-BESS-ID: 1791505070-111537-10416-31452-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.193.110
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmFkBGBlDMONnEINHAyCTZMj
	nNMtnCLM001cLQ0szA0MTSyNLIxESpNhYA+V/ZnkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276703 [from 
	cloudscan19-182.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi Loic,

On Thu, Oct 8, 2026 at 5:30 PM Loic Poulain wrote:
> This function ensures that the work is either cancelled or has
> completed, but it does not prevent it from being requeued
> concurrently. That can happen when rx_refill is rescheduled from
> mhi_wwan_dtr_queue_rx(). Using disable_delayed_work_sync() here would
> be preferable.

Agreed, thanks. The automated review of v7 also pointed out that a
retry already inside mhi_queue_buf() could race with
mhi_unprepare_from_transfer(). In v9 the DL sink buffer is only ever
requeued from the refill work (the DL callback just schedules it), and
remove() calls disable_delayed_work_sync() before
mhi_unprepare_from_transfer(), the same order mhi_wwan_ctrl_stop()
already uses for the data ports.

Thanks,
Peter
