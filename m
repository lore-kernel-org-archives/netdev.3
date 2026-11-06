Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794005018;
	b=t2vWb65trQfd8gJkhh6NUav88B6oLhswFFobjqFdXEAGKov4v2bi3EoOHEwYrz0d+oi1
	 iq/hrxrWkAQ3ZhLd08d/hYxeWL8dtiNqQo46oUDaFY2kloCiJfbqspJm9y3cc5ef1oGNF
	 EwLXu1z8eiKmw3nN34BDaT+qEX2/bkPX3IkOwHR47CHyKgHoo9U1+vhYDoxBFG6Pw+YuD
	 U2+tYBvFD2P8Dz51huKRH/0y2Iyqn1B4Xez6XdQcQHE9hJRnlXEnwCpOKlYAIQMPDixCh
	 GqhnN/mBc5mnvmVDcxlAsz5n0rLu0b3LxtSEw3P0jotZ1hSAtnF9C1H49a/tPygrAfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005018;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=V+NxTgG/Dg/uBowYyCP6sYSEbii5o64ppP9tiR0RYy4=;
	b=ze3xEOG2D4p3iIriX8OuFS2hkQwbx4rrd/WW+33meSrmIaQgV8kgszPBfOOqepsCR4pA
	 POAe6LUVrhVX3DmVmwQgO5ZCnnfFyoDfNTR4ZOWWl5REXnORt/afE9Mjr5k9muRWClH6F
	 BZWFT0OHctvmtU3HzuGX7UZ+96a8rQz6q4srLugC/coSslnQtb4FQYF/PDROLlPtllPEo
	 lgnzpqPSaJfaTGnLkD3w80LqdlDWunA6EZeIyZ5ERB2GfAaUnyAZbcKgeV8AnjKJMOLXQ
	 ADKGsfLGLJgfSrinGPS30xhPwR7fcf3O4cv+aeAl9nUykSZzsbAm9P+d0gAa756ILAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hcedw4Jh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.57
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FC606D80B;
	Fri,  6 Nov 2026 22:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA4FC606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hcedw4Jh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfP+o66zW6gn31YEC/XW6wKZDaXsurzRL4YlRIiXZj9c0P6AqcEOwOzBfKLXUt/2t4lVzulYCqEU6K3cbjRpQt4QATyi4dXGgexvxl63GtWbTebMWBMrGfG4RYhD7eV4CAAKjlXIdLy1DIHK29m8lCWp/5xWnKy03unqXlcb/dFIBJeyv3ZHYBCafnnQBJ0KhnesddAMBIvlC8emcSVCLw6Pga65s5+KopINmH2N8R9Zp4MaPQuYO/BfU+rjGBhlkg3cQWFeeC/ofadDpGVrMlp0WQLPX87pom1iG0fVJxfD8/f9X+9lepHtGoFppIn4ShPyFC7fFOdJFE2avDqafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+NxTgG/Dg/uBowYyCP6sYSEbii5o64ppP9tiR0RYy4=;
 b=pXC0K2xbCB+1E2lnbv/ZWlymXdI5jvX86cZZj8nOIhs7RB9H77JgN3irv0J+e9Jf0UBKPzwmgXftunO1zgSv+feX1jZZ726jBb06It3xfJdsrACb7xpUC4b505S+asr6sD6h8/KTVlBwQmTjZzG1pFDjZ3XDO+aPYZ4qIvHooegmcxUy7ZaMLm/abBD7UraeclWKgs/WmQPR6TwjvE6dvEjAxuf9EZUymAE3jXqV4ZRaphdKxTfSJF+f2EWt7GkgKEfWhvAeqXglp1iKMxHzg/SxttrZVYf4rhKjUaHgCS9ninemHP8acKBQz6QBCF2TO+tQGUO+ljHp8aCKusL7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+NxTgG/Dg/uBowYyCP6sYSEbii5o64ppP9tiR0RYy4=;
 b=hcedw4Jh6lmTe/9AY/MnFvb2lYXVwjoOsG76mO6Y/3cvh7xtHyho25qTzVnumgiX67Eh69mk6UuyqZCYyR52VMM88pZqfosk9YDC2cPZhtOdNDSQ/hLKQz3t03IjBjPscwOlgVMfRgIuhuE4HcYeZnAdaDwkNIo8VTSGZwRPXt/vxfnzlrq0mM7BCuo3RfEedguVROg6Z+Okcd45wLguN8nR1k5a9CTl2tSrwakUryyarYQrbebSsZUZc6kzv6c1h/G+opwFY5QlI0xZX3mHzl2lN0EJ11j/q15OxAQCWYUJ9UQzuc4mpYjTRd0WbTj/WdSINheLGCke5C7LFky6BQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10731.eurprd04.prod.outlook.com (2603:10a6:150:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:43:32 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 22:43:32 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 06 Nov 2026 17:43:10 -0500
Subject: [PATCH 3/3] ASoC: sprd: use dmaengine_prep_slave_sg_context()
 instead of device_prep_slave_sg()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rio_sg-v1-3-bc54b4bd8c95@nxp.com>
References: <20261106-rio_sg-v1-0-bc54b4bd8c95@nxp.com>
In-Reply-To: <20261106-rio_sg-v1-0-bc54b4bd8c95@nxp.com>
To: Matt Porter <mporter@kernel.crashing.org>, 
 Alexandre Bounine <alex.bou9@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Simek <michal.simek@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794004992; l=2064;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IwXts/1+LZKRnlqQdW6bwf8OAC6tU+GWZrBJRzMYiEQ=;
 b=rkuvsGbQXTfPFvlMTuIm1AadnJTbXZfo0n6BrfvXcs+LvVVgCBmWy7LUYwJ+xA8s63z3uP5VU
 wH627PUBTyRAXlhKHBqhgtqw7Fw+1BDB/xMI6RoUxzRu1jyOvealmvO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::31) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB10731:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8e6b05-9589-4fd4-14a3-08df3c576260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|19092799006|1800799024|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261102123227099003|261022105027099003|10067099003|11063799006|261009223027099003|6133799003|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	CjEsbT0gYvRN3bWT/EuU2DK49p8PyJgIw2t0csuAbwt1VxBzUgnhTmUST3Q9LStv2901ga/2pGrcVWju7aqcTkPTzeC7jsO3IEbuxHI4CyK+hChR+nicahs/pTVekDb3udjMs8r5HB61Zr2WjxPDy1xr1dnw7JuM7ZOeg4FVXVIpa8/ylE8sRDk1aX+z6ee4FaQr2ZTXkZi9XqbvG6YcOc3aWqkiNMnxCtyVapr9x2UIkFRAW0LveEW9+SCaf1oeblj2qQhOY7fVUdcVzALM0/mmYtQ3WKXU6j6RfMaieIQTUXwSxjHnob2wxaFH7nzJBiex4jnppHv/S4U9Yt5sESVe3H/Ij/wSB0Lsbhb+vt+x97dtmAKtPviwBSQ3asHqjtwXB/NjctAgo5jkQUr8re4vfy/He7M3x/vLJQOgWsrLE+bzTtLWe0w6Fok5XPJH6xgfKD0wJGD41DJIqSsC5xjo5DHmSR3FpEzI4kSKHtv3JUg89vpTFFgiRKQhKYaMRSOK0czXBDclm0wl2zkcpyPd/3KYWO3s+mHbUkpCqg4gssXeONNN1cF6Urm0C86vo/bxJzh0GkZsKQA3REFmCYDUb7eeh0tWg4QsrmXlLFUoy84lFvJM1JPQ5bdC7O+LDIBHVxLuN4g1j+U+I49djM7+I4FsjaIA1mnhcLQdyHggHhpFfkuiYBbReaBTLdGaA9vTV03f47e7wpADSuJchQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(19092799006)(1800799024)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261102123227099003)(261022105027099003)(10067099003)(11063799006)(261009223027099003)(6133799003)(22082099003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZYOUFDVXMzZTBpYWZSVVR6Z3REWFVRQldZTXJmYnRuYkhDbWRuZnl0NTZw?=
 =?utf-8?B?a0NjcHVIQk1kcWdYMElnWXAzdm8rZnJURTlmbHNvVWFnNTlXN1VLOEJqT1JP?=
 =?utf-8?B?N08yZUF0Zmp6QSttS29xY1VFa3ozdEs2UFNCQXE2SWJDeUc1ZCtGSDNMUkZB?=
 =?utf-8?B?R0RvczhlSUdESGcvbnFHY244cno2Q3dnK2VIaFNOOVpmemVrK0hnYUVjMjIv?=
 =?utf-8?B?a1R6amwvVExoYStJR3hERElqYzhMMjhLcjVvRi9ma1k3ZWNZQnI1SDZta21z?=
 =?utf-8?B?MGpvdXBiaUdiZWRnNWI2ZVBnQXFEMTIxU1Y4RlkwV0NRZlhCS0JZM3BCTHBW?=
 =?utf-8?B?dGVEZU04WGdZeHVBY3RIWWV5ek4vK2Evbnk4N0Y0aitDTEtNckROcnpHYlFO?=
 =?utf-8?B?TVo5NE94ejZDRHlTcjB0UXIyZ0FXMThjRE54UEZxNWZIbVJwUHQrS092L0dz?=
 =?utf-8?B?Y2FnYis0ZmN6dldPOHdBbTRtRmh1WG1ydm45NHJCd0dtc0wxL3BKMzhLdWps?=
 =?utf-8?B?TXlXSiswR0I4RTBpTGc0NXMzWHg5Yi9GdTBSSEJzeHI0Ynpwb2wrSXoyVWVt?=
 =?utf-8?B?ZGRJM1N0RnNDV3NpT3dVaVJXcFlJL2gzeHE0SEhNWDlMb1h2M214dTZ6MTNX?=
 =?utf-8?B?cGVyZFBhTlJPR1Jmd210R1dvaUJnN0NGQkk2Nmw2WDlaY2hHc3hlL21YRVZC?=
 =?utf-8?B?aWFwb3lsN2ZpTTJ0Z0ZjT3dnZ0M0WWVvMHJrQm44cWs2U2FWb0RiaDBlODg3?=
 =?utf-8?B?SXdGZG40SlV5bDN0b05rTzcvSWkwSlZaWTNEZGtQcEgrL2pqcElPeFBmekpW?=
 =?utf-8?B?dFYvT2k3TmRIRUpCTGw2NVU4UkxwL0hTaUltVjlBbk1sL0tWckJUajJzVkdZ?=
 =?utf-8?B?RDJHbjlwUitJazZtbE5jMmJ5VHM4QXEyZFZvOWhtckpKb1FEMjF6SFVzdldB?=
 =?utf-8?B?dVZ6Y0M0MTVmd0pwMzRuVDB2OG1wck9TN0hqYUVxV0ltK1BIcy9KMUtOcWVG?=
 =?utf-8?B?eExJSUVYVkVmelZBUURoWDVPU2hMdlYrQW9Dd0hXWWJYRG5kb1F3bUlBLzRZ?=
 =?utf-8?B?YWNGTU9aM1ZsdVF3bXNJdXNPcjg0SXdjaHhBZCtoWDdUSk8xV0NYMm4zQmVJ?=
 =?utf-8?B?K0lCWE82VDNrcnFUS3V6bDZLNHB6cWlwc0ZBZTBZOG5KWlpmOVc2MEFhdzFG?=
 =?utf-8?B?VVJsM0pDS2pHaG15d3UvaTZTTEpFWmVzRnIzNnVJcW9PSTdUYzNoVmloUi9E?=
 =?utf-8?B?cUNXaStuNi82K3JzSmVwWGdOSGJhZ2t5bTRVbXYySkxXTlRodWlGT0J1by9v?=
 =?utf-8?B?cDFpMmlTMzRVTUtVRW80S0xxVjE5anlYcFdjQnRYN2twYVJPTlQzU2IrYU03?=
 =?utf-8?B?YWRZdXhYNlJta0JkQWM1N2JoaWhzYXp3OUd4MU83RUF6bitiZ1A3eVJncWpr?=
 =?utf-8?B?TW5JNjJBcDVIL3FPTmlWTG5PeVhaSXljTWwwNnZkSnhWMS9sNUZXWmIwL2NB?=
 =?utf-8?B?eWpJVXJ6dndtVmFOU2ZKWGJOMGQvaFg5ZDZKSk1nZW1DNi9OZS9reHBBcTZN?=
 =?utf-8?B?UHNZdElzR1R3VGQ1WXJWaWFmUk0xZW80cit5ZmkxS2FXbXRqR0cvSjNtcEhk?=
 =?utf-8?B?SnNqR1dsQjBYejQweGZTVjlLSTBSczYvMWtIcFBrMDR2MWwxTEVMYmpRRUJw?=
 =?utf-8?B?L0tvb3dSSDNrQVF3d0JUNW9KT3ZveHZWa2ZkV2dESE9oNDFFanU3Q2tMZmt0?=
 =?utf-8?B?TUN3Q2cwVlpKSVV2SUp0OWZnY3ZNR3BzQnlHNVJjU0NOaHVVMW9LdE1uR1Nt?=
 =?utf-8?B?NmVvTW1TaUVMU1RRcDBPWVJqcjdNcXd4NTdFVGZtOHRxeFdKWWFPOEY4QTJM?=
 =?utf-8?B?SkFOMmpPenBZc2NBWjVlSStlUmxJQlM4Sk5FdCtJellSbnIvTkVEZXRBQU5i?=
 =?utf-8?B?YVJ1OVNhV0o1UXZSNFlvSlZuV0VQQ0VzdVhpdmJtTTVVRWo2dWgyc1BNVThM?=
 =?utf-8?B?OUlwYmYrc2FFZklvWUNTK1M0dC9XK25tdGQySDhCVmxRdFdPckI0TDd6bHhm?=
 =?utf-8?B?dm05ejNPQTB5cm9RbHRtWSs2K2hKWkU1TVZtT0U1V01aeDNKeVErL291ajI1?=
 =?utf-8?B?UCtUdUlGeGRLdHNFcVRraGlUcVNLdURsTmErMmt0UE5FUnA1Z3VneWZjdWNX?=
 =?utf-8?B?OXE5NmFOZDBBbmRvRkJoblowTmJTY0UySjJFR0Q2R0FwbkpNbTBZTWg2VmR4?=
 =?utf-8?B?UDV1RkcrOVV2U1NlT1poV3RjNnY5UmtwMm9GZGpYcmN3MmowLzV4ZSt3ajRs?=
 =?utf-8?B?ZTBFN3BIWlBGbDdSUWluMWZkWlhDQ0NoSCtwSlUxNnB0SnpRTk9yUTdObExF?=
 =?utf-8?Q?io6s+ICSSvisNoDPDrZjg/UQK9VnJ4Cg6X52Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8e6b05-9589-4fd4-14a3-08df3c576260
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:43:32.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suVhoPcraoAk5eB6f5dChGNwbwY7UGczvCgm2lRLUD1HFhIJrqsPASk5dJmlxRGPuyvWXZj9pHmLSg262ZkfuxhtptE5/m/6DZnvJR+tc207vPxeXyuO8PMvOcSkfb45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10731

From: Frank Li <Frank.Li@nxp.com>

Replace direct calls to chan->device->device_prep_slave_sg() with the
dmaengine_prep_slave_sg_context() helper in both sprd-pcm-dma.c and
sprd-pcm-compress.c.

No functional change. Prepare to make struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Last user use prep_sg with context argument. Suggest go through DMA Engine
tree directly.
---
 sound/soc/sprd/sprd-pcm-compress.c | 6 +++---
 sound/soc/sprd/sprd-pcm-dma.c      | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index a810c9c8a0b5b..228cb8741c438 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -236,9 +236,9 @@ static int sprd_platform_compr_dma_config(struct snd_soc_component *component,
 	 * We configure the DMA request mode, interrupt mode, channel
 	 * mode and channel trigger mode by the flags.
 	 */
-	dma->desc = dma->chan->device->device_prep_slave_sg(dma->chan, sg,
-							    sg_num, dir,
-							    flags, &link);
+	dma->desc = dmaengine_prep_slave_sg_context(dma->chan, sg,
+						    sg_num, dir,
+						    flags, &link);
 	if (!dma->desc) {
 		dev_err(dev, "failed to prepare slave sg\n");
 		ret = -ENOMEM;
diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index 968901ae4c335..bb72cb272d4b3 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -277,9 +277,9 @@ static int sprd_pcm_hw_params(struct snd_soc_component *component,
 		 */
 		flags = SPRD_DMA_FLAGS(SPRD_DMA_CHN_MODE_NONE, SPRD_DMA_NO_TRG,
 				       SPRD_DMA_FRAG_REQ, SPRD_DMA_TRANS_INT);
-		data->desc = chan->device->device_prep_slave_sg(chan, sg,
-								sg_num, dir,
-								flags, &link);
+		data->desc = dmaengine_prep_slave_sg_context(chan, sg,
+							     sg_num, dir,
+							     flags, &link);
 		if (!data->desc) {
 			dev_err(component->dev, "failed to prepare slave sg\n");
 			ret = -ENOMEM;

-- 
2.43.0

