Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504174;
	b=iauo7d9sIZgtcT8/Xvrc0nHXMQOaLxFetSKr6v1btouvmKdfKx2HmwzgD4lqACn2dme0
	 M1NYxNKDiiO9uZg7LUoNaKGeWkPUPZ7uTVzWeb/TqiWMhuuLQh1MJSaIh7guQt7acnvfL
	 u3QHOCrcHLIMLagYpED9ImLwMKm5vP5xYfRoZ8gphdbgIFAeI4itnBT31JE7egyt+9Dxb
	 zN2a9o8H4YNBq+r59Ovb8oX4TapBrcalB2/wjqNjlh2irKc4SFmcdv1Qq9E8EP62w1TTj
	 QfPmj8gvxYMTbD690Ej4xQRPtqTHV0nzTufc8ju5gxr1UpOzOLQJHHNTZHPDwZVJbvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504174;
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
	bh=8uqpFxHKWpDNpO7i4flc2aVx9aU+Bzab1jBS+sALouQ=;
	b=BEfLzedRHjWIjnttsgO09E8oVQIkm3zHOHYtoUTyqv7fOMmLp4/rJoYE2FaIoGgjpS8s
	 pwl33iEiyOq5smgoShw189YXHdJJKJe/l3ZdVaUUY9LpSyDtIir/otZm8EirqB5IY969z
	 4/GnCJ52A6jFNrDNHVE6uUEsZlv5DgxfhQ/9epaKqAj8sFq5SUlXF9RkAIG1glI3KWDXG
	 uyxDdPz8R48PUkgYL3f2vQlBmUXU89pDo16KxNdP4pXyuVTXpQdX0pqZCjiinXzv8+GEt
	 eCp5xi1ADfYJFD/3iX5QjQYgFrmNanYQIWH+lydUBPAuorLd6DPjpTP87rs40GtM5MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b="O/80zk1c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.65
Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493E606A321;
	Thu, 12 Nov 2026 17:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B493E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=O/80zk1c
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020113.outbound.protection.outlook.com [40.93.198.113]) by mx-outbound45-180.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 12 Nov 2026 17:22:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVUMFyTY2MAMQxB9NK+Vos0ffSVmFhlnkJGjU26UlHIgTAygqtV9Qtu9n6V1I+WTJhf2YqW1nwDL6KiGfs4yPiPblQwnwbfjs7h0cHgNLK0f+GUB3Hhnv/d7ojp+OKexOHz3bSXzhreQo/KuXNEZ71GmizzFO+y9rd0S3SEGu7/xu48KTkkPo4mbKLtebQSk298s/7j8YMe/UmCica22QGNnduL4G/XoCThikX00WQS561DKnDDnt5y1Y89JLRHrzPWNZ4zCddD9xEfOIh8PIx1IkYAW9cEv54nQyw8OZUnQPFx1/6IVOI2PnZb4oy8XqMjROqPeoyQdrCHlfBE/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uqpFxHKWpDNpO7i4flc2aVx9aU+Bzab1jBS+sALouQ=;
 b=Xc/EtUEYx59U+tTquoC7D1uj95oYyYcDU4cgfc2UMDvQc9+SGVLtuWYsmqQw/vBjAZCgzCwcLBX3oxVnvbofxkvWinOmm1QfYPUZQGGk5dsa65nd7BL1WWkIUwcQ0zAoy/owvIFw2sqD2tOmiJ++E118nz5rP5q98/UtpJR6vpqrMgpY+5eU8bUQTJctPe3yr4feaNVpqaTgAJqXgrr6/QK9c94tcp6cTYMhDSvTKmiFA19dYaXsg93DZTE3+TwQM+rmD32k59ROF4FF5Ji4sWCUygVOl5+bRqctoTe8T0VccfuE/HceE6zQc4f+HlvStjI/MPt+ysNpkCRbCBjA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uqpFxHKWpDNpO7i4flc2aVx9aU+Bzab1jBS+sALouQ=;
 b=O/80zk1c19DuxrVMz1+YbMg4/LBgtOnGmNc7OOTFBmetdKl8iKxEGf8+UO2TRPgwbqMZn8UPExiPg3CCLERFviHBIYhREUcVwlWeZKyLllGfACuSlrLo/pPMamTOm39EwJi6xloqHAOGMGgF0JfgI88Mk2y7ox0mUEeXT0SKaf1AI9Aw+IhF0y3j7jf8TJcYTFv48WXxbwDV/dE8I/Mk3BDQkPVqVxHjXvitjiVRwCvcT3DR1poHUWKBiqV8R1AUjyLDdaDbnYKXHnu2X/FjmfxS2oGoIQZ7AJWQLbKWi2HuFCYyFUwzdfxtjoIm94iXuj9G4W9Ztk2+NlxCXJ8f5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26) by PH5PR10MB753821.namprd10.prod.outlook.com
 (2603:10b6:510:500::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 17:22:21 +0000
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a]) by DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a%4]) with mapi id 15.21.0569.011; Thu, 12 Nov 2026
 17:22:21 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	dnlplm@gmail.com
Subject: [PATCH net-next v2] net: wwan: mhi_wwan_ctrl: say the DTR drop flush is best effort
Date: Thu, 12 Nov 2026 10:22:16 -0700
Message-ID: <20261112172216.31216-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26)
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
X-MS-TrafficTypeDiagnostic: DS4PPF6C5A39D55:EE_|PH5PR10MB753821:EE_
X-MS-Office365-Filtering-Correlation-Id: 65852f54-4579-4fd3-c779-08df40e18256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	A9U5m9bwK7AeTaQEoIxiI/JxriarTNLHIoGHvxHeVlT5LBVZufRCPHzb8y2cDmx3V/JMiTTc8qVgkcHolZGuZOFpmP3hIhAZhvyw4M+dmBEorFD94qOzV4RmDCU5CwrpbaPyAxTCt5ky4ayOVRJPTkMzHu8dawKgZNoGsDajc+lHIfEqrbFCB15nOcLdcP+/U5nfndri6xNdK09SB5a3f0USBGB79AzeJaD3qmO64Zwr8wtgUPsOB7LP5RQix+hEnAZbPOD9rTi6ODdSFf708ddg61yOmhWLAyI0HRrLKzAfS65R0N69aSt5NSmgJ0+TucrAhz953keKhCTMNlufwUjeEaZO4xcZ368ojmKaR/C3ThuMSnqa9F9Hda9CFWAqZeRX33B4wlHJQhy89349pFlXNDTgLJxxtTaW7bPScRTzx9KsY4CwaGRmOhJmrPBX50Remz9aTFSbT4YA8EF3khCrWXnBQ9cnH5k9+otBvDch/5lqAAI7GxLCI6azr9j7SZ/zf29Oasy6dW06zT/R9Oigl1MbcVSR6KvYMpetLpZ8R2nWKVKllHqZaqmlSRMsBm9QuI2IfC57MeEqevXY/jOo5qbYPRCkpuXIXZbkIuSiSRRFeZVCn/stBzLGwu/7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF6C5A39D55.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2QO5gGUiYsqvgzJm14HGaDL6EGgtSXzBlpJ6CkiZHhmRog1/rriiQ1GifR/?=
 =?us-ascii?Q?aCaJUeNEIOW9sPSW7iGX8dnogIf9ABnG3xvnQL03teIeiIaaz4/iJXK3p9/F?=
 =?us-ascii?Q?m4xaYfDnvZF3XaVSeYrEiUgNCJxddiWUvGg1F+zhXZkx28W+rb3XiPTkJvkF?=
 =?us-ascii?Q?2dCNG84JyyxgGXBnxaKn2LXy7kmEdS9bL+nUaolOMAz9t2Issn+JKtzHP6ce?=
 =?us-ascii?Q?4vxAB/invc19KB6eJatlz9q/bqfVxtsCVSa+9tAVnJoqbNOsH49vbENegRDd?=
 =?us-ascii?Q?ZqsZND+mb14u6UxDOc0LQPDdURDVTh+JaWOaGx+Gi9EwJGJrbPbHcvQjbceu?=
 =?us-ascii?Q?TV3Y9hubHI1XS57v4OyndVvnY07PnnjYsPA6dKwqG7ZLHyn/k0vZZ+Xr+Jpj?=
 =?us-ascii?Q?rLK30nArI5Mj/TTKoSsvBqdn6LDEbRW0o/MVhhsJ5BS6nqEEaJuZ4hyujGiP?=
 =?us-ascii?Q?srVt8fdoJrxYyQSUc8c26oUB58+UN1tAFJ6ee+4j1SxaWk6an3efptjUH4EK?=
 =?us-ascii?Q?2/5I5qcOg43r7VPId+3u+TTuyKCrnK7By4mSd8GYJ48Y5j0XoPukoCHjEisT?=
 =?us-ascii?Q?SBE1Nj7Hgb6+Mg4g8KDuk6gPAJm9XjqHArQsU5trIp7+rMC0icxXLn7zGb/5?=
 =?us-ascii?Q?JdcUWW40IZou5tSpwpvxm/yU2iWzYMkjdi34TMKfWse1mYL6HWN7GwP21QB3?=
 =?us-ascii?Q?KvZChR6bTtn8/ZYz4ZU+cjGwA/qja/q3q3ebZalUzoChaKFDlcMc3lca8cKy?=
 =?us-ascii?Q?7e3KQSW6753WObTjIpZN03H89V680uRGS4copGLPbWzbq6evdy5hSZcut2E+?=
 =?us-ascii?Q?SRLvRstKH5cNQmyMQao+P9eP8FY91LJCrSFlpgppcw9xKgUBmkV4jvBbEIL/?=
 =?us-ascii?Q?rRGI08lMeR0faZzFMBDCnlaCw2ZenQNXwZKUGDfiEW5xYxaSBd0C3yPW0Tzj?=
 =?us-ascii?Q?OTPvkQghZSK/s/N7Co/IreguvNbBkj4KoJzTf1LiOvt9bqQq1j0K3LPyJf/B?=
 =?us-ascii?Q?gfSUuMOwAt1IEELEywkquAPoUILpOcSi3TYZNB08G3hoJXb7K3rf5mr6XcT/?=
 =?us-ascii?Q?wj+T/vyWHpKXWEISixY3+QEFQKhN7yqtLiXukxQgRSFWaKGmx7/G7Q3sDS48?=
 =?us-ascii?Q?1rKjZ8W+ggf1A30Jyvt77ReWQvo3CJ4uD+ymSiTas46DO1ZdbpN/bUpUam8G?=
 =?us-ascii?Q?9G2NlKt3cpfMu81PdLiOQDl+PIOng3TAY9rR5R0cr+lSn+xslgEgiN6BA0iz?=
 =?us-ascii?Q?nmDPzbnh3UDoq5VpCc8bVAK6frVTJbXaMD6b6/pTzQMiTw5tqCg/XliuUtM1?=
 =?us-ascii?Q?uD0QsNxAP2jf39nFz3VR0WyyB0WHHszCOU3sscxMiTrBVrP2/rl0i7nuS5BJ?=
 =?us-ascii?Q?pLBNefIfrDVe5k49p8N1+Qc18eaTaTsa/aIocnUmvlQkB798KoVWtnhYGUaJ?=
 =?us-ascii?Q?uPMNnOM1jEA+FEbGvw5ohn75J1qAaDZd5Tg6V8U6O8KU9ttdRiR6Me9ZWA2m?=
 =?us-ascii?Q?OnMZJJgH/+0fNzMzUZiD8AefsavGekQWK6fKco6BQyEQwYG6GepgiZVm9I5b?=
 =?us-ascii?Q?7qjJbQxk6Q2afM9JBtVX121/KXUHT66d3qVaagd5Klx2Q8wK43/S8UTZ6Ot8?=
 =?us-ascii?Q?SxsLNkN2x2iI0+EOdAz0HsfeUQDhJp6lxjxRAoQxBvmuVU+tz5Di4/yrv4gt?=
 =?us-ascii?Q?FECDJWPZ8msNpbJHLKaw6XBNsXIEALjr/dQYCgsTsfnI0yP9?=
X-Exchange-RoutingPolicyChecked:
	Bq13qyaMDusRzbCKms5G47injs1X/udk91/0PCNAU6YrcPNnrTtBDhr21dh31vzUlvOCgnKDhCNeu5QdzSeuypnUI/VM5h3eC4XhmAQHFf8W8tD8mHySRVe9h2PP5UeeMnYDVzy2iUjBLLkjDhQxhItPB4pjJRqR6mbLgTIDYsHSapf4lYvH4m0IbhagfigZ6CGZVPaujulQw82zi9hPD58zyY+nEBXm7+vdA4Vko+7OODCmzmVXbt0wvnSe7AUaLdH9kHJwmxCKVDDRA4tcFjXXRkIAUuaHaItLfcI8yFapVKbDDEASkVxRvbbGWO9DmWugY0RyPSxOF1XrSEvACw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65852f54-4579-4fd3-c779-08df40e18256
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6C5A39D55.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:22:21.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9c+A1xjcG0x8Vr8pk/NSIo1GirfVwZhOtnbEBsus+zaCFNlzuv6eLErAsj9IIjKx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB753821
X-BESS-ID: 1794504144-111700-9363-2168-1
X-BESS-VER: 2019.1_20261104.2126
X-BESS-Apparent-Source-IP: 40.93.198.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGxiZAVgZQ0MDA1NzUyNTIIi
	nJ2CQ1zcjS0tzM0CjV0sQAKGZqZKJUGwsAmaiG2kEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277535 [from 
	cloudscan20-242.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Four comments around the DTR/RTS work don't match the code since
commit 10f51f4fb99d ("net: wwan: mhi_wwan_ctrl: send a DTR drop before
it can be coalesced"):

- the ->dtr_rts() comment says the drop is sent now, but a drop that
  hits a full UL ring or a failed allocation is retried with whatever
  state is latest by then,
- the stop() comment says pending state is sent before the channel
  stops, but the flush there makes one attempt as well, and a retry
  goes out from dtr_work after the channel has stopped,
- the dtr_mdmbits comment only describes coalescing,
- the remove() comment says the removal drop gets one attempt, but the
  drop and stop() paths now flush the work as well.

Update them. No functional change.

Link: https://lore.kernel.org/all/179340002701.3131.15535297427661129303@kernel.org/
Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
Changes in v2:
- Also update the stop() comment, its flush makes one attempt too.
- Name a failed allocation as well as a full UL ring as a retry cause.
- v1: https://lore.kernel.org/all/20261109185731.182990-1-peter.hunt@opengear.com/

 drivers/net/wwan/mhi_wwan_ctrl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index 772319927867..387ab1bb0c41 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -68,7 +68,8 @@ struct mhi_wwan_dev {
 	unsigned int rx_budget;
 
 	/* Latest DTR/RTS state for the modem, sent from dtr_work so a burst of
-	 * changes is coalesced and only the final state has to get through
+	 * changes is coalesced and only the final state has to get through.
+	 * A DTR drop is flushed out on its own, see mhi_wwan_ctrl_dtr_rts().
 	 */
 	unsigned int dtr_mdmbits;
 	struct delayed_work dtr_work;
@@ -216,7 +217,9 @@ static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
 	schedule_delayed_work(&mhiwwan->dtr_work, 0);
 
 	/* A DTR drop matters on its own, e.g. to hang up a modem set to AT&D2,
-	 * so send it now rather than let a following raise coalesce it away
+	 * so try to send it now rather than let a following raise coalesce it
+	 * away. This is best effort, a drop that hits a full UL ring or a failed
+	 * allocation is retried with whatever state is latest by then.
 	 */
 	if (drop)
 		flush_delayed_work(&mhiwwan->dtr_work);
@@ -254,7 +257,10 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *port)
 
 	cancel_work_sync(&mhiwwan->rx_refill);
 
-	/* Send any pending DTR/RTS state before the channel stops */
+	/* Try to send any pending DTR/RTS state before the channel stops. This
+	 * is best effort too, a send that has to be retried goes out from
+	 * dtr_work after the channel has stopped.
+	 */
 	flush_delayed_work(&mhiwwan->dtr_work);
 
 	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
@@ -376,7 +382,7 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
 	struct mhi_wwan_dev *mhiwwan = dev_get_drvdata(&mhi_dev->dev);
 
 	wwan_remove_port(mhiwwan->wwan_port);
-	/* Give the DTR/RTS drop from removal one attempt, then stop the work */
+	/* Give any pending DTR/RTS state a last attempt, then stop the work */
 	flush_delayed_work(&mhiwwan->dtr_work);
 	disable_delayed_work_sync(&mhiwwan->dtr_work);
 	kfree(mhiwwan);
-- 
2.43.0

