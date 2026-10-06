Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4813264D8;
	Tue,  6 Oct 2026 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259314; cv=fail; b=tP46l90qn4K131wJhGgH1Tj3evEZfRX3k7j4RviMHPbYTPdZJp0HHhlufc/nbjIZSD14DNt3/OyLgleas6J6/Fg37lnmRUtOYUcLKmQoFWzTuLrkDM2EIS0IQVKxBQhGhd+4FaXsC9OB+/VdsEHHzoS+uq39qYyQAclLuK3BDQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259314; c=relaxed/simple;
	bh=+WOXmi5BG3G4iGK1CGuLQt2+Xz0g0U9G8KkiIyjMWAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFPZVgJaCHZTgabqgExeBug5AfdttjXYn3Om1Q+D6KvevWlhbJKQI4KLLP8HDtfgkyXO6z68g8c1et5tZdXotZIOdd5X8REyHu/tGckmdy53atFPu/SeovYG22ERk5Afx07lS/kNCZsJ9JzY1qpdrkSlNVDS13fcekV3/7UIj20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=dOjFfZel; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="dOjFfZel"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022141.outbound.protection.outlook.com [40.107.209.141]) by mx-outbound44-182.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 06 Oct 2026 04:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moaTdwDfKNdNeFIoAhXp/a1CqpfQNqx0xDLNB5EwLLX2h74QMncCshWw+D7Ue/OLi7sdsyJ5WXFsTqM+iY9cp6c2RAGJmoD8E1fEz/hjFQbndKJ/ojBj1KmpuCVEuuTNpS8MmsWum9cKkJXyWSHDHaTYj/un8bGUuDgSYny1xuUopvphIgZ06x+bXSpAmbC/O44oX1s9KXLP38U6suxAKQEF8qP1hi33idCjx0sBaETN3riTBufo6BR7C0iJ5q6tJwNmie8QkBBgbndLr1FcPiJqjafkJ/nzpKRieCsaZYtMP+3Z2b9vaHsh+KoupSa1ubz7yfiB6l1wMh1Hy3T1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WOXmi5BG3G4iGK1CGuLQt2+Xz0g0U9G8KkiIyjMWAk=;
 b=Wf6n66g8Xwux4DdOH03mKuIwYhzd79vhYni+FmqpsaGiEDbxFogqZs2Qo7peAu9VL1PbfFUyAdiwobmrWvnsuhrGuoeBIJmjNnIECK2CXR+r+Iiw3OLE/y1lD3A0QaMasQwppcyTyqIdVAS/3J0f0e1sy2G9wYMMQCULHzuSgN9TeiQsZzJJElsmrKm8SqYpZ2SziZlB+fU5vW0fz07q5KPNdEGbl3K06x+o8hqRUD3mElZ/tWg7MaEPe0gnKLaeu6GQGrvtuFz+Tp6f+XA2c3Zmb48FkE7gjQEetjIrT5ctxuWXZt1O/7wQbH3DbVpRoU+E9q/VoXthXldfY0oVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WOXmi5BG3G4iGK1CGuLQt2+Xz0g0U9G8KkiIyjMWAk=;
 b=dOjFfZelZcPSPIXouT5LchZgFoDSngMea5kRwneHAuTOD/xDbzHlsewYeNjqtpl4cbSJnREZC8LuUYcpdetvvEqnFhyXKgdX7bMtKwZeYrq9SoXMKCOPo0kMEcJhxIMqxF+8GpWdtsNbT3oz6hWRPLE8g0SzvEQknUYq557ITlmvIJrnNv4T8sx5yFxjaK8idct3HjnNsmPtcorxteUciza68xetGomqAnBGL3Kj3tDpCTIgNFc/gMty5eHv4HCqzM6j2IV25aQf0TjzLnPfPLhpPNRSrOpsSlh29kGOqUa+IA8WZIqXvMMX1XPQrV82eZnNi0ACOYe0gfqTNWbzlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ5PPF1849371D1.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::78e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 03:59:02 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 03:59:02 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev-bot+sashiko@kernel.org
Cc: loic.poulain@oss.qualcomm.com,
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
Subject: Re: [PATCH net-next v6 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Mon,  5 Oct 2026 21:58:59 -0600
Message-ID: <20261006035859.3207852-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179123419887.434549.1077103528647935423@kernel.org>
References: <20261001204614.3481089-3-peter.hunt@opengear.com> <179123419887.434549.1077103528647935423@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:a03:114::16) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: b6975540-e844-4137-9227-08df235e2892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	kgYHQOUZNsvWgsMfbpFBYD2z+Fm4zscSG+lliQ5Hym91QFdYYWdYFJKZcBa9U0NipooCxD1H5439/w9nG0IIsRW7rUNM118gkUDoKoYsEDqngZGSkPxaE2MY8fQAC+EeSk8BWvhX7xUfUp/kLP8KPj/W0WyOZpTw8/9JLHCUSXGjE3lPhSOfhkwny6bVF4RnPMW/b5ir9f0V0CtyHm2ken5qkv7izIpfprcx3h46PHbCTNEMrdJng6bFoGzXHATGbHmMtLGnNAaNMRDd9onVPt6CASERYW2lwGcpdIqIqhMKNDDYtEmFe4wruzlRCbx0fyBbfwDoFep7jdNlCJ+jAovMM1I8x+2cAXFo5BeW+uYnyCYSRfrRaN403sfcrKkJDtIOd6PvOvIPmuWurkvv49m/5ylX0D4Z5HGhALY6WZPyErlM4C4dyDwoU6LSPsLDOhPvDtWrztS0qfpEqTEBFk7fPP2Dg8X/zA8W7xSQg6Q8mAMcUCbOxuV+YrAj9HwbE9BoeKYYhXUiTzzhP9adoOFOoGg73Rzc4O6i1BdWMdxalN465eVH0YQ/rTWdfI/KHyeqQVpNIOuWzOJbRgg3jJwLdADIB6ovDkU7tJCDpTjPxMAbKbiEtzX4LyqSuEzkKtWW/GvnpHDYWTAfK6PazE4DOGiF6NItTVrOEESPDHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iyLnboGPImrCUB9rSaPoy+lZ+UTcKpP0aS76acRgIJYSO/u4r+M4k63JP+ud?=
 =?us-ascii?Q?HBFqhhHXqU6qr+JPYlCb7MhkeLmrHieJyOVut23KegZiWwVwiVp4Co1qf1xW?=
 =?us-ascii?Q?9oWe0XplSuWK5iVuuHckpwZkeKU6HS3No/+Jv7mTF0S5zgIYNTD7mcY4uVlc?=
 =?us-ascii?Q?hqXezOk2DcZQzuObH3I57iwARyzx7WWwPLryAjZ0Gou3s2g41drRPrDLfewY?=
 =?us-ascii?Q?G8EsgibYBZ/NSgcqsAV+AI7oYfS74WzvVZfkWl0HJHSVM2AEKKt3QpqLpElK?=
 =?us-ascii?Q?fewGGC54lNB0DqlXqEHN3DomHtGObXVhtmYc3gqRHJQa0IzWgMZzwuOroT1f?=
 =?us-ascii?Q?4gPQX0nyod3o7hFRuiCK0Oh36WvYGFiziXakQiBYdVIdF4V0fzZmpTVTn1RE?=
 =?us-ascii?Q?j1tLjEFz1xEl1tyPOUyd1koUuDPHP1pes/B9aOLmgInyMnXpq39VlL46jl04?=
 =?us-ascii?Q?wqwzz58u7tLoD6TyGax0SZ+q8BuRU0QJc4Jix64yUHBT+7ImiU1VmZBqHq1q?=
 =?us-ascii?Q?HcwgmjI2d5duFhTIUCWGcZpPg51RgRRjm9+B/AipgZT2NeDK0TTUBhQ/FDRc?=
 =?us-ascii?Q?1+G54QwyyABJiWHlJCLCv0h3QGUhxOXulEcDxYvQ5+kb4ckz0mU0vVQi96Lh?=
 =?us-ascii?Q?G5hIuUh71158hd3MFyAFVzaP9e41HFMvt3G495GJQ7w1QyqOKhVQVEbpAF6f?=
 =?us-ascii?Q?6LQ0weqhYSa5KLnz4D3XHNFrgNQfrKg8Nm8EbCBieq2LyKF1+d2R9KrB5sut?=
 =?us-ascii?Q?QIJLk9T7+IXSbkJUu0xnY4zJ53+/arnBUFLjJ40zIe83xeWoiL3+eeDm/Ims?=
 =?us-ascii?Q?6NAatU+RZ41+DbE5elqwdy6RX1uE2KnU26vTLAXkqeqHXVUi3615hewZa2gT?=
 =?us-ascii?Q?2nVY/mb4olGY68xob5nU33TBUOAQlatHltiSzlXjHQBx2uMh1y6ebNZYiqye?=
 =?us-ascii?Q?tjZAwtd85facD9aQrrMw146qmhbS6As1my/jChVRWgJIttqxbVgCPtjjvccR?=
 =?us-ascii?Q?YPdeqdWREluqdi81dgbijRLESLJ3eyytFdls0tzouA8hWVy6eMarGmtGUKmU?=
 =?us-ascii?Q?OXkq0st7hxbljgK2CwfXNpB61LytOwDxbXNh/GyefaUlvncm2x3+sLLZkZPp?=
 =?us-ascii?Q?S7idFNtOEKsseHvNfYgbjShk+1fIuPpkqbm/WNsgltZvm/I69XWSshG6EAu7?=
 =?us-ascii?Q?F/tkKuY/w1p+4stiuBRpHPxPrQ8f6Llj2caI+qv6CuPK6oB+yUANBY+KzD+e?=
 =?us-ascii?Q?Sfr8TZh0ibVepkm2F8hG2ejLK85YqYJgxZXbbuhtBPhCCktMJpeXm7NTGU6V?=
 =?us-ascii?Q?kbWx06A5aLdIo8juYEBWfzdl8tRideqwide0cPqqYDBVIQFDGo+NeOutulOt?=
 =?us-ascii?Q?BtV/hu2aZcVJ63L4mOTeUwxfFWurZOJfSOH4N0C9dkhNew0PzglhoLKzA6MV?=
 =?us-ascii?Q?plaRBmDWkhf3+Hb4p7vYS+5d16lI6azWcZJtYA67dt/2cl4VNPVV5rWAM/uH?=
 =?us-ascii?Q?ERHH1hH9XTM78ewyCmgH/Lc/S1iSNgFc/adYB6r7QkTzEtPnF9JmDIe0d8WU?=
 =?us-ascii?Q?3PdkiX/nsJ8284AVfJ35XEzB1PIaF6W5Cvhw3nMfmyH9tT2f6VT48NynCujc?=
 =?us-ascii?Q?OMfwAbpZ+q4Wb9Dw+AH5hK+ZKZlv6d0hT7xkChMX/w5Ky1+EE9W6hFUfD3LM?=
 =?us-ascii?Q?80EafQf0dzf9XaCBs9jndFf7I2Vlm3tGFXa/r2o/Qo4Ket1A?=
X-Exchange-RoutingPolicyChecked:
	VeapbbmXaw+BmMoIkYLIZySrql+TN0PYcreQQh4XKk4PnXIM2q0IDF6A0QfWR+dyNmDwUEm+Y0rE6bmU49WUnEwnkhvlZDuDT9SasVU3nrffWroiy1xZBv9HjFhqXCUk0gFBvdqs7oLJay5MQvxw4jcZ0WksYD1uEvkCDrHQKvn90C06B3k97u2MPe0TbzJ9+1p9TsEk2YrYGRB3qA7TvcQpxKVxnK2KKKUa6l8jjAB5YvdxqHR1sZcIctCRhzqrooVTXc2kMrhmyZieV2OcPerTREEplpdUr5nd72x/Y1RDi5wWwFl40OkMOQBhuMJnzMqqrW7mKCMTO0RiMQ+ilA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6975540-e844-4137-9227-08df235e2892
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 03:59:02.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08KZtfqlf9PK7vJkFGtNL8b14frJyWc0/wMqj2/jJVkv6LnnPm9f/5QAe25io4bH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-BESS-ID: 1791259267-111446-28307-34412-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.107.209.141
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaG5gZAVgZQ0Dwx0TTNyDwxyS
	IlzdLAwNw40TLFMsnUJNksKTU12TxFqTYWADDSWC5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276636 [from 
	cloudscan15-97.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review. I'll send a v7 addressing these.

[High] No in-tree controller declares IP_CTRL: the IP_CTRL channel entry
for the Sierra EM919x/EM929x is commit 83c29a55b89e ("bus: mhi: host:
pci_generic: Add IP_CTRL channel for Sierra EM919x/EM929x"), applied to
mhi-next from v5 of this series, so it isn't in net-next yet. The cover
letter mentions it, but the commit message didn't, so v7 notes the
dependency in patch 2.

[Medium] Ignored mhi_queue_buf() failure in mhi_wwan_dtr_dl_xfer_cb():
agreed. v7 retries a failed requeue from a delayed work item on -ENOMEM
and logs other failures. -EIO and -ENODEV mean the channel is going away,
and the next probe queues a fresh buffer.

[Medium] DTR dropped on last close regardless of HUPCL (patch 1/2):
agreed. v7 only drops DTR/RTS on last close if HUPCL is set, and defaults
HUPCL on for AT ports, since port->at_data.termios is otherwise zeroed.
Close behaviour is unchanged by default, and userspace can clear HUPCL
with TCSETS to keep DTR asserted, as on a TTY.

[Low] wwan_remove_port() passing 0 (patch 1/2): agreed, v7 passes the
masked mdmbits through a helper shared with the close path.

pw-bot: cr
