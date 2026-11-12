Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501524;
	b=rliSiWspK8is+34v+OP9QY46ndFQzRjXQF+gOCZHYmVf0C6ycYHHXwgQNcPJP51JDEJo
	 HY0pGnZByKH13XeBInf81SzWd+tQn9EOBRANYiIjtkpeb6EjyMVtffNSqXonaulwvrLfL
	 ai7L76Io2VydY6/VoFSEGdonve70l63aG+BlbXd1jvR2uSt5baSJe+jdQMAgKJ+Qps4zM
	 pTFPVPQxEjm7Pu0wjvDo/F4zVYZubzNKb/wE58HtpBggE1Nz6+KL81uMiTq4cDTZH9SEl
	 IipBY5Zzms72AvJKy1TVGcmUxaO+DASucCDHHefLJgzp9wGNvbrrJERRj59clj5EZ2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501524;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=bAc9CjhhF+EELx2unYcModdZ4oP7AcM9xtw6ND1+bRs=;
	b=FBYAYSATYe8afGDlOCQqWdVi1xzSoTnSDR0/tdDlk/btF4AznRWH/sQUVWBmo3q00W+F
	 3lesGDxEgo2jkq1vtmKAo23hY6HgIy0G/Pv3Y89sKqd15LiXEM1BPTj5614NDF1uNUB76
	 jEihZhZXVFLB04iMjIT1Oy3TWfwLjNcN/SEb4qyOq9NleRydzexj8qUXC4YwpkBr6trSQ
	 YXVfcQKpWlpSGx9EYO2APlqWRBUyRs5lq26d4Gg1UHdyWcm9fB6i4tOmqDCs4qfS6GtHk
	 ns6vpQFzpAQcm7GAdqyvuJfh2xrCtA5C7Qt8JeZ+ktx1/LjJQay+IPZV4/ZbD2e9ukg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b="Y/Gv+yAq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.31
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011031.outbound.protection.outlook.com [52.101.125.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1060A2628;
	Thu, 12 Nov 2026 16:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05C1060A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Y/Gv+yAq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdxBJQlCouU2ItctTFOSwkz+3bg0cfiN0J7/JJIl3PVwdnc6FaSOLgNk4FIK4t/MxaKDsDNCa0/gUgEnJBJP8i0t+wjDnmv3g+Wh1ArtzDWE9FSxYiNlBh+Be6oVkqB00mqFlAHuPRZ5AxvgCIw2q7u/6nmxpgA7R+Qr+wdTa6u1HwwNz0bSF3lzITmTmxoiNgN2cDzo4CSYeiVov9VydzXbpuS0wlW/jRonKFI1BFCeqRknmDkQL+xIjwXNamAE/8MWn7+yzbwPsKLlIdLKth/oLFNI2SYuV5qbeDrI530gLt3szKMl8H96HrLH+v/3P30CZZwG9G7mLGR4KzNf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAc9CjhhF+EELx2unYcModdZ4oP7AcM9xtw6ND1+bRs=;
 b=sriHG8Hy21MKzRxTV8PWJTFnQ5nLmj+uTtKsPyrcDDjJrLpLYH+6048oqOSY6J3TqfDcdQE+C4AMISJdZK9N1K3Yh07WI28p3rKdLaLRmGFYStjE4YZigNXOljavAvG/6XDaDXgWUQIG2+cUkOc3r5YzB5atgjMB0BRYN+PzUpVKUtILZO8t+igXEg6F7aEMRfJFmP74t25KFIGgyJWpaJcn+NRPQcXpfSi6edlftqo6XoPMIoHXZB6LEC3Cs+q+1C7fYys/CNFTgEO77Betep+h2IAmgW5ZLG439CGV8wtGkYzA6/GB3YPo2Vtn0E3CfT7uCYzVHXVkmiEbUYN/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAc9CjhhF+EELx2unYcModdZ4oP7AcM9xtw6ND1+bRs=;
 b=Y/Gv+yAqZzSPZNwgckd+rA9mjbqOuvEGZA4h/vFthnGwvDxlmKkMeSWLcm1gl5699zK8lsAoQ6UvEq/YELB7xQrsKod/E1cFgfu3leGg8IRFgpPSIYAxrZCKkr4GmI4612krepRT19r4RzJvtbUUro9al2q1Z/c7dJt7pHV6eqA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS7PR01MB14895.jpnprd01.prod.outlook.com
 (2603:1096:604:394::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:38:38 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 16:38:38 +0000
Date: Thu, 12 Nov 2026 17:38:17 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Ding Hui <dinghui1111@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, dinghui@lixiang.com,
	xiasanbo@lixiang.com, yangchen11@lixiang.com,
	liuxuanjun@lixiang.com, biju.das.jz@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [PATCH net v6 0/4] net: stmmac: fix RX descriptors and XSK TX on
 resume
Message-ID: <avXreY2EBUuQ2gpU@tom-desktop>
References: <cover.1794311618.git.dinghui@lixiang.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794311618.git.dinghui@lixiang.com>
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS7PR01MB14895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3216204b-1943-43db-e291-08df40db66c2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|18002099003|22082099003|6133799003|261009223027099003|261009221227099003|3023799007|11063799006|56012099006|261021135927099003|10067099003|261102123227099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|38350700014|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	PpfPMbqoDddaqWLU5VBZOXL7zD3/07R7UmbRIlJ3wNn9zwwrbBb6PmKwrgZOBHM4skPF0NT/O5MrE1eqFdDwh7L+rh7MJ794bg35XgKOR+95JvnMbCUKpKTLDqXHAEqBnESKxT9GCzGsWPO5mVRKNZZwMyphylpuO9ctvkDHaPPz7sPoLBgeXEwyXq3GmnrrEoT7ulEaWoExlx8g+VzcIgaDtK6PHOZ2vi1i4DuAMpG7OjhOQPRgwmDWDQSFH8fEytZJEA+dtxzgUK8b+a/GT/cBb6gICjMQiWuXAVRKhFidjOU+SCDcLZvTMFc0C7puUZ6K5KFoECi5tZsfhxOErJFPdbB9qlBsEEZU0jofbG5dCL25UeJUJ4LrjMildIS3NVk4tZHRKQ8vYwEbn7clbIw5rPY9qzFR+4RpdXB9/5Qf9lD0E5j8qEn/kYJlvfBS3Ab4kYvozMHboN5prjAehlmBIZPQiF2GAy5NAIJbdA5yL3U+1W97xIj4I4uBxUWF88pxaumi1l0TvTIF3mAH6o5md6uLsdFFIx2JhtlrMSSNaZpObuQkWRZt7blxoo0F+hnQnZh2VXtaSSMeC49q8r6PufcAviQc7CK/X89LRhmaHTWvK4gCTn5QIkj82glcbpUdv0nqJ1tgLYcxD3ISVZLq0XZ6jXBxj1Fhp//gF50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(261009221227099003)(3023799007)(11063799006)(56012099006)(261021135927099003)(10067099003)(261102123227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(38350700014)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCGdtWONZm+Nk4NXir1/MfnWMDEqSao7XNibFbT2ntgHryU4LmmFyvRTsJ/9?=
 =?us-ascii?Q?55ayzrmK/rt939ImUM6jnUhF/iNyg8vsZ2hySQXJhL45IklvxhTBMFNg60i+?=
 =?us-ascii?Q?rRZ2CJtSG54cI5heYD3WSlJqyYBVtVyRwRuHV/NaBG6dUCdZ2JX1GkcfA7oi?=
 =?us-ascii?Q?3jbZ5JAJmEpdZBSa6LFvx/OiAnF9MyAEN4YF/T3bAKki/MfaL9nh59CiohF9?=
 =?us-ascii?Q?J0fBSdWVb+y7JtQmEmGecUOT1duGZ+PbOHneQyCmWDfl11ljJNwOE+HWYWQT?=
 =?us-ascii?Q?5cIT2KXEqEdUKQRx5nm05qJxEyJ0N5IOBAxW4tGJ/wrpZbPoLNrYIaMHqAfv?=
 =?us-ascii?Q?MEpjTOPBaAgfWhugT5YisJKxdtUOcdLqtYHbUq04FLret0B78jiS9/SpCZhE?=
 =?us-ascii?Q?C+y9zEuJe0ACdUlMP//WhtDhB1282dVw19xX3XEUj07C2HRTSl+lMrlhACvv?=
 =?us-ascii?Q?KmT7qhcqaPigX7ITRueqii0zI9S2iQ+mvwBUvSt2Hj86DAiDCjycx51B5ZLP?=
 =?us-ascii?Q?5HjOXInmAPqJGucOsumVhYzDqi7+Q0epyb9k/5hlsljgECMJI8xj49WuOrcE?=
 =?us-ascii?Q?1N6D+nZxKMIVacNmWb8e4nx0r7lvOENc8GEuRk8gmiORL759efKYENg3wRCs?=
 =?us-ascii?Q?p6vGzBrEJ9RZX1e3ykVcBrcY+1VvOl4zuv0rRZCje74QFO8PWaiIzzQAMP5j?=
 =?us-ascii?Q?3AQxVAaHXfiU+y2BaGHLBbHfvpdFu+4PvOtS8n6vh8NKwBpP6pLWJdbuIBlD?=
 =?us-ascii?Q?qi5EyfnEuDNJ3EdwkX5DqdicszqJ7rqoEPScdwYCbapQgIO3cJW8Ki73aWoD?=
 =?us-ascii?Q?Bda/aYjq64a5IIvf0yo5x9oje2VdwYIW/OwGaSsLspoZChzGPmN0fJUtes4s?=
 =?us-ascii?Q?OBeFYkvznbnHofWkwo+Fbyoz6YzsPDx71viFfhQUmQGCy7Gb37R0JfDEv9c5?=
 =?us-ascii?Q?1OCGkcelwSwd8sAWb6280CxQeRegt+7ZDH+9nxVnrPzU0dbTXc0PWmqopl/w?=
 =?us-ascii?Q?gxZ1C75zOOpHxNEweNE57IwXUSpG7n9fRwRulCN7jtPSED0ch0zgXx1l6AO0?=
 =?us-ascii?Q?5h2gfzkmBTKGZ+t3l/pRHaZIJCv13JjxgrPYDo1ZzLeWLcTLbhzk7g12hgq4?=
 =?us-ascii?Q?dQa2FpgiFy654UArOBh5xk8XCdF15LazQrIzlM3mVQ+poLJnk2yHXthG/34Y?=
 =?us-ascii?Q?l5cYBtD8RcVYW64GiP4bS9+Ak9BkrSYrBMqvhxgg+3XCME+jR8euXRNTrE8q?=
 =?us-ascii?Q?QYPObDpGb0TYnGtV586bEzCByGTXvqAp+WIdDXY2XPNibUedYJ2vF3pG+EPE?=
 =?us-ascii?Q?/QuPTK7ggWGyeLaQzRxv8O/Y1dhkUJoh/sGhMhTQ1xgrY0YoqCkoJ2TSGJ3I?=
 =?us-ascii?Q?M6nzDSAHXz6jecy/YqnWECKpX7EISjM2fB0dLoleZou0ZS4kWuQ+FsJwdrfT?=
 =?us-ascii?Q?YqZ1RWbt1tRIXp3uQR/Ai4XmQLGdSwqpUwRlelkj7E1RRbiGc+GoIMsHAHsX?=
 =?us-ascii?Q?TwCJ8UhUYL8O0j9itGnk/JQOpz2AEWJDbgQsqDVwRyIGKhUKe2ncjvG6jTE2?=
 =?us-ascii?Q?cfGj70xBBULCCGUq7Tp9wtu1bXqmpnNvW+DoONMI/eZAaVn9BA+5J/Npq6na?=
 =?us-ascii?Q?olF+2hylsbIXmVadlr0t1AeSx1CV8S1dGbYQa7J0LFg8U7HIY4TH2iy5riSD?=
 =?us-ascii?Q?LXlvKIUsJeqlZN3YLewXlvBbtOhCk4WP1hjoE6u+9UPc5yIn/JRGCdbzt5dq?=
 =?us-ascii?Q?g1kiznQwRHx2CQkgLVdlxSyBNglKfVHZp9x/rCHwGFII8XQrR936?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3216204b-1943-43db-e291-08df40db66c2
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:38:37.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rzX7zHBKnC62mv73QItQsCI4u9tnPo0qLrF3gFobZI0JWMwQMqYK9Wn500Oy/ggzys/ORpWLco3R6ETvKY3JPwnUD2X2f4zIBrKkQMhecm0BMiS8/+3U7vByft2a69D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14895

Hi Ding Hui,
Thanks for your series.

On Tue, Nov 10, 2026 at 08:38:51PM +0800, Ding Hui wrote:
> From: Ding Hui <dinghui@lixiang.com>
> 
> This series restores RX descriptor addresses overwritten by hardware
> writeback between disabling NAPI and stopping RX DMA during suspend. It
> also fixes an AF_XDP TX-only resume stall found while testing the series.
> 
> Patch 1 honors RX allocation flags. Patch 2 keeps unfilled XSK slots
> CPU-owned and tracks pending refills explicitly, including an empty ring
> and short refills. Patch 3 restores RX addresses from retained buffers,
> rebuilds chain pointers and initializes descriptor control fields. It
> publishes a contiguous XSK prefix and recomputes the tail and pending
> region. Patch 4 restores the bound XSK TX pool after TX buffer cleanup;
> otherwise zero-copy transmission can stop after resume.
> 
> The earlier commit 9c63faaa931e ("net: stmmac: re-init rx buffers when mac
> resume back") was reverted by 00423969d806 after a Jetson TX2 suspend/resume
> regression. This series retains existing buffers and DMA mappings instead
> of recycling and reallocating every buffer. Jetson TX2 has not been tested.
> 
> Hardware validation used backports on our XGMAC platform with a vendor
> kernel based on Linux 6.12.41, not these upstream commits as-is:
> - Receiving iperf traffic from a PC while suspending and resuming caused a
>   fatal bus error after resume in almost every run without the RX fix.
>   The same test no longer showed that failure with the fix.


I'm testing this series on the Renesas RZ/G3E.
On my setup I'm receiving iperf traffic from a PC while suspending and
resuming (s2idle):

[ 46.745703] renesas-gbeth 15c30000.ethernet end0: Link is Up - 100Mbps/Full - flow control rx/tx

Before this patch I'm seeing (during resume phase):

[ 73.919151] rzv2h-icu: BUS error k=1 status=0x00000040

Which I don't see anymore applying your series.
But after some suspend/resume cycle I'm seeing the following:

[  262.878939] PM: suspend entry (s2idle)
[  262.883075] Filesystems sync: 0.000 seconds
[  262.888229] Freezing user space processes
[  262.894080] Freezing user space processes completed (elapsed 0.001 seconds)
[  262.901046] OOM killer disabled.
[  262.904275] Freezing remaining freezable tasks
[  262.910033] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  262.974153] renesas-gbeth 15c30000.ethernet end0: Link is Down
[  263.183095] SError Interrupt on CPU3, code 0x00000000be000011 -- SError
[  263.183154] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G   M                7.4.0-rc2-00101-g8c75c70989f1 #6 PREEMPT(full)
[  263.183204] Tainted: [M]=MACHINE_CHECK
[  263.183217] Hardware name: Renesas SMARC EVK version 2 based on r9a09g047e57 (DT)
[  263.183235] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  263.183271] pc : stmmac_tx_timer_arm+0x60/0xa4
[  263.183333] lr : stmmac_xmit+0xd4c/0x1650
[  263.183383] sp : ffff8000834435b0
[  263.183396] x29: ffff8000834435b0 x28: ffff0000c0298ac0 x27: ffff0000c1498ce0
[  263.183454] x26: 0000000000000001 x25: 00000000000021c0 x24: 0000000000000001
[  263.183501] x23: ffff0000c0298cc0 x22: 0000000000000280 x21: 000000000000010e
[  263.183549] x20: 0000000000001388 x19: ffff0000c0299648 x18: ffff0000ff7e01bc
[  263.183597] x17: 00000000000a03c8 x16: 003fffffffffffff x15: c15e9f4d40b0ba44
[  263.183644] x14: ffff800080c377c4 x13: f39e923bc472b73f x12: fbdb674df0d86e0f
[  263.183692] x11: 5a679e689a9836bb x10: 0ca385496fded8a0 x9 : 00000000200005ea
[  263.183739] x8 : 0000000000030000 x7 : 000000000000010f x6 : ffff800080c39340
[  263.183786] x5 : ffff0000c0298cc0 x4 : 0000000000000000 x3 : 00000000000013c0
[  263.183831] x2 : ffff0000c029ad00 x1 : ffff0000c029ab00 x0 : 000000000000203b
[  263.183885] Kernel panic - not syncing: Asynchronous SError Interrupt
[  263.183912] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G   M                7.4.0-rc2-00101-g8c75c70989f1 #6 PREEMPT(full)
[  263.183961] Tainted: [M]=MACHINE_CHECK
[  263.183973] Hardware name: Renesas SMARC EVK version 2 based on r9a09g047e57 (DT)
[  263.183990] Call trace:
[  263.184003]  show_stack+0x18/0x24 (C)
[  263.184048]  dump_stack_lvl+0x34/0x8c
[  263.184103]  dump_stack+0x18/0x24
[  263.184153]  vpanic+0x380/0x3ac
[  263.184204]  nmi_panic+0xf0/0x108
[  263.184252]  arm64_serror_panic+0x70/0x80
[  263.184294]  arm64_is_fatal_ras_serror+0x3c/0xac
[  263.184336]  do_serror+0x5c/0x70
[  263.184374]  el1h_64_error_handler+0x34/0x54
[  263.184433]  el1h_64_error+0x78/0x7c
[  263.184472]  stmmac_tx_timer_arm+0x60/0xa4 (P)
[  263.184526]  stmmac_xmit+0xd4c/0x1650
[  263.184580]  dev_hard_start_xmit+0x8c/0x104
[  263.184622]  sch_direct_xmit+0x8c/0x35c
[  263.184668]  __dev_queue_xmit+0x808/0xf2c
[  263.184706]  ip_finish_output2+0x458/0x5ac
[  263.184749]  __ip_finish_output+0x1dc/0x26c
[  263.184789]  ip_finish_output+0x34/0x148
[  263.184828]  ip_output+0x70/0x114
[  263.184866]  __ip_queue_xmit+0x164/0x410
[  263.184906]  ip_queue_xmit+0x14/0x20
[  263.184945]  __tcp_transmit_skb+0x548/0xe30
[  263.184993]  __tcp_retransmit_skb.part.0+0x2a4/0x950
[  263.185041]  tcp_retransmit_skb+0x50/0x104
[  263.185086]  tcp_retransmit_timer+0x430/0xb68
[  263.185135]  tcp_write_timer_handler+0x180/0x1f0
[  263.185185]  tcp_write_timer+0x130/0x17c
[  263.185232]  call_timer_fn.isra.0+0x24/0x80
[  263.185278]  __run_timers+0x228/0x270
[  263.185319]  timer_expire_remote+0x50/0x68
[  263.185365]  tmigr_handle_remote_up+0x1b4/0x280
[  263.185408]  __walk_groups_from+0x3c/0x9c
[  263.185449]  tmigr_handle_remote+0xd8/0xf8
[  263.185492]  run_timer_softirq+0xec/0xfc
[  263.185535]  handle_softirqs+0x128/0x2b4
[  263.185577]  __do_softirq+0x14/0x20
[  263.185614]  ____do_softirq+0x10/0x1c
[  263.185656]  call_on_irq_stack+0x30/0x48
[  263.185698]  do_softirq_own_stack+0x1c/0x28
[  263.185742]  __irq_exit_rcu+0xf0/0x11c
[  263.185782]  irq_exit_rcu+0x10/0x1c
[  263.185821]  el1_interrupt+0x40/0x60
[  263.185873]  el1h_64_irq_handler+0x18/0x24
[  263.185928]  el1h_64_irq+0x78/0x7c
[  263.185965]  default_idle_call+0x28/0x44 (P)
[  263.186008]  do_idle+0x240/0x2f0
[  263.186051]  cpu_startup_entry+0x34/0x3c
[  263.186093]  secondary_start_kernel+0x13c/0x15c
[  263.186148]  __secondary_switched+0xc0/0xc4
[  263.186203] SMP: stopping secondary CPUs
[  263.186233] Kernel Offset: disabled
[  263.186243] CPU features: 0x0,40000000,00400028,01180a02,0800e21b
[  263.186269] Memory Limit: none
[  263.544217] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

Which I was able to fix with:

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8606,6 +8606,9 @@ int stmmac_suspend(struct device *dev)

        stmmac_disable_all_queues(priv);

+       /* NAPI may have woken a TX queue after netif_device_detach() */
+       netif_tx_disable(ndev);
+
        for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
                hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);

This issue IMHO looks similar to the one fixed by
commit 7e87508b5c4d ("net: bcmgenet: stop Tx NAPI before disabling the queues").

Are you getting the same? What do you think?
Thanks in advance.

Kind regards,
Tommaso

> - Native XDP/AF_XDP zero-copy RX continued after two suspend/resume cycles
>   with the receive socket kept open.
> - Zero-copy TX-only, with no RX fill buffers, is tested ok after one suspend/resume
>   cycle, with no fatal bus error.
> - Pausing the receive application with SIGSTOP and resuming it with SIGCONT
>   recovered RX without recreating the socket.
> - xdpsock is used for native XDP testing.
> 
> Additional testing would be welcome for RX sockets initially supplied with
> 0/1/8/15 fill buffers, replenishment in batches below 16, and those states
> across suspend/resume. These differ from TX-only with no RX fill buffers.
> Legacy descriptor cores, GMAC4, chain mode, timestamp-specific descriptor
> paths, multiple XSK queues and long suspend/resume runs remain untested.
> 
> Missing page_pool buffers are still allocated during resume. Allocation
> failure returns -ENOMEM without restarting DMA and leaves the device
> detached. This adds a trigger for existing resume error-recovery problems;
> full close/open recovery, including NAPI and platform power handling, is
> separate work. The Medium-severity AI review on failure recovery is not
> fully resolved by this revision.
> 
> Changes in v6:
> - Add a separate fix to restore the bound XSK TX pool after resume cleanup,
>   addressing TX-only stalls found during XGMAC validation.
> - Factor resume descriptor work into one TX queue loop and one RX loop,
>   following Thomas's review, and use common error cleanup.
> - Restore addresses and chain pointers before initializing RX control fields,
>   preserving legacy fields and RIWT/IOC policy without a separate OWN loop.
> - Add format-specific RX ownership clearing for unfilled XSK descriptors.
> - Track pending XSK refills independently of circular index equality; retry
>   short refills and prevent consumption of unfilled descriptors.
> - Restore a populated XSK prefix and retain later attached buffers for refill;
>   recompute the allocation count, initial tail and pending region.
> - Select XSK buffer size independently of the initial allocation count.
> - Discard any partially assembled RX frame before resetting the RX ring after resume.
> 
> Link to v5:
> https://lore.kernel.org/netdev/20261025100636.613670-1-dinghui1111@163.com/
> 
> Changes in v5:
> - Target net and add Fixes tags to both patches.
> - Split the allocation-flags fix into a separate patch, with a Fixes tag
>   identifying the page_pool conversion that stopped honoring the flags.
> - Share page_pool and XSK buffer preparation with the RX refill paths.
> - Allocate missing secondary pages even when the primary page exists,
>   using the current baseline's buffer2 capability check.
> - Condense the reinitialization kernel-doc to two paragraphs.
> - Restore descriptor addresses before the final dma_wmb()/OWN pass.
> - Clarify that unavailable XSK slots remain CPU-owned and may stop DMA
>   with RBU, rather than claiming that hardware skips them.
> - Power down legacy SerDes if RX descriptor restoration fails.
> 
> Link to v4:
> https://lore.kernel.org/netdev/20260627122533.1165324-1-dinghui1111@163.com/
> 
> Changes in v4:
> - Document the return value of stmmac_reinit_rx_descriptors().
> 
> Link to v3:
> https://lore.kernel.org/netdev/20260604144557.3175399-1-dinghui1111@163.com/
> 
> Changes in v3:
> - Allocate missing page_pool buffers with GFP_KERNEL and abort resume
>   on allocation failure.
> - Try to allocate missing XSK buffers and clear descriptors when the
>   fill ring cannot supply a buffer.
> - Restore OWN after programming addresses and rebuilding chain pointers.
> - Honor the flags argument of stmmac_init_rx_buffers().
> - Restore RX descriptors after stmmac_clear_descriptors().
> 
> Link to v2:
> https://lore.kernel.org/netdev/20260526022620.501229-1-dinghui1111@163.com/
> 
> Changes in v2:
> - Introduce a helper to restore addresses from existing RX buffers.
> - Update the commit message.
> 
> Link to v1:
> https://lore.kernel.org/netdev/20260515053856.2310369-1-dinghui1111@163.com/
> 
> Ding Hui (4):
>   net: stmmac: honor allocation flags when initializing RX buffers
>   net: stmmac: track unfilled XSK RX descriptors explicitly
>   net: stmmac: restore RX descriptor buffer addresses on resume
>   net: stmmac: restore the XSK TX pool on resume
> 
>  .../ethernet/stmicro/stmmac/dwmac4_descs.c    |   6 +
>  .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   6 +
>  .../net/ethernet/stmicro/stmmac/enh_desc.c    |   6 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   3 +
>  .../net/ethernet/stmicro/stmmac/norm_desc.c   |   6 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 277 +++++++++++++-----
>  7 files changed, 228 insertions(+), 78 deletions(-)
> 
> 
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
> -- 
> 2.34.1
> 
