Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796780;
	b=hEnX1VJOk5CmlVcAOcJ7+oA1iJFOWhULUrGCsfch11a8+0NkfIR1mBfNWPMEw58qTkTJ
	 qX0w9GUF65sMe7e46qosu6KAyUTB3o8iW8ZZtPkr4mG+HPxKCjZ0FbbyfxoBdsQggIPwg
	 sWnP5H184tKxxcDSk/Bf8B5SqgKnEgV77JwYBIyzdaBNFVhEuSNGuDFGL2gwIEr/NashF
	 MorFO33WHGeRX5cSXMA9OVz8R6TtJPkr29yMRfqGfi+ybpv14IA1YpY1eC79splH3SK1Z
	 6T6G4StzzEJttfJ5+7UdhCc+fTiwI9t6aH0jzsrR8ENe804pPWBVTKrSUuY6Ml6E0uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796780;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=Zb/cR5nUi8bjjrqeEtXEtrCTn+c+dWcoAbznSZCLh1Y=;
	b=5a11jC06QlD9Ox5Q7Ht6gk4UAA/fpPQVoNy9Efa3nng1oWuquj47O0tv3lp54wuYpGkp
	 a6bwNLG9X5w7zs83CGJlNs+7C8RQhcG0l33SueFfkCH/wdYFvgIOAqtGc/MKNU2J/bnb8
	 sj8sxwg4NXo8Pc6pvGzjx9Ut9OzlMwNatLvSEKVUCBopvCHigZVsR8SiPUao0XvqpLyuj
	 BrTgyn2n8ykcf9pk4jllsWJDTGcC/jYwuDRgWHw8rtUu4bVO/QunJ7kJhspa8YJYfskQa
	 4PinGAAI0oNCVA6hh54pfQXHfv6ksCGaBw0NQcGJuM5/xLOMeRBuDWw1KCrf1VsVuXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=tf+HOC1n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.134
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23F606A326;
	Wed,  4 Nov 2026 12:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD23F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=tf+HOC1n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL75pZr7o40aTraMe2S0ttHCqZneLaU7gRADTnwCHLdmJAQtuElzS4oZbKtH2jh+0NFpeQX901kSy+qQjYQs5UScvFd5XlZRGvI3qW38WbNKq1gMSpG8AARK6N+jBgjlK6YPpB/TAXv0FGGaskBOUr+hj5G68tlgdYt5KdsSGrTN0r2YcKw95m3CHNR1y2GckT13u3SxuSuOFs58S3PYW0xk2WfBOOUcHYWhNbi9Wx9qm+L4SiJ69L4qghDVTTZjkeZ/FMqODjZ5szTK3mFt1EQb9XhUtye/nqhlKU0LiSxqgLzAZ+av1EKw27bUAZnWTgcP+sWxTsVkXG1E78qO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb/cR5nUi8bjjrqeEtXEtrCTn+c+dWcoAbznSZCLh1Y=;
 b=FxRxJK+lenIjqRMto9u9hFXGaqMNSdS2MQvXoNK+AqxbrCiTX2uCkQj28MoyirqDL/3/JeIrO4EoAowf07wbmkkqikvGcSJBpL8YIuQbacFNZX1MS/VHZ/4248ysSS/ysxidLMeA/h9uErfbrf0qDB5xuer3mHR8XqNPt50ZT8nTdBbAFjKNz4s/z37KcUur0VC14DA+3Aq4OoUThCYjq3j36QfHEpsXnF3aJ14Ctx4OnUUnWPw3LcKqRDoCTdlbQmNsWlP5Lpq29Ii4fpRbeakeIWOsKXzoj4vQBd851F4xGI1wria7IT8eIOdgV+VWH0PU0/TZ94pKqMKwFfTwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb/cR5nUi8bjjrqeEtXEtrCTn+c+dWcoAbznSZCLh1Y=;
 b=tf+HOC1nu6equ33frkRulvJml7zoE/sIKME4vxabvMqiuSLob5jHkDexad6SQtUWmIksJxt+mloS7LvAzwo9fb7eWSjXim4saicMuVbwf93EwdU6i6ct+wkhaYU5vdmC/kXxxrnAgKddeThgHYdpz8uwu77VHJblD5Vhn5mKUtE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1075.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 12:52:47 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%6])
 with mapi id 15.21.0592.009; Wed, 4 Nov 2026 12:52:47 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH net v3 0/1] af_packet: avoid waiting for TPACKET_V3
 copies at retirement
Date: Wed, 04 Nov 2026 20:23:24 +0800
Message-ID: <179379500489.189393.11299513853625665657@deeproute.ai>
In-Reply-To: <179369815762.488859.15460471694371846273@kernel.org>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
 <179369815762.488859.15460471694371846273@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SH0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::21) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9)
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1075:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e5299c-8936-45a5-6434-08df3a728700
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|4143699003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021123027099003|261009223027099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	AyTN2T8ER+jCIr5FYoGPN/432GZd+4vr29qJluAGOls37mBbFz6BdiZ/M4pJkqVSQWqAGJHokMQolhIAPbqcYl+ZSl3j58Fal8Gb2w13QEXRlCAbAFGbRks6bQtYCa5e6E3BSxc95DIfjsu/yMFFKUa5oBiw/j9BJD+xwXNDmRp191FaaJfSMwrmKn3kXYYmXvP6HI2r4JMo5uTpmh6Q1L3DBziFvODs/geTdI5m/2TXuc5ZDxCOoVlRbMKdmLtZOtu3hduO0jTOHDcWj/cOExjawrxKbe3TARMbjE4QIJj5uFjxXOiOFkyQshwF42c88vqyP2SUqB6uDEiA3thodnfWxUk4JEwfQ5mmpuNOI5duu5JpwYV3/P86mBaKNwF/adMN7fgoQ2ErK9rQHKJCubChQFikv83ZzEhsZYXVlJPMIYRAV+AoYzz4rWvZ2w4PDeWC6G1VwMlEHgDy1CIV9hmwERtmzWpjBclHEoapTUj8MgXeLLzT/NozLfdSj7AZe5VVElFc1F81Y4wD6guv484t03CiwHsOaM72ZDzWDVeyma0EKM+A2rGEDwhoZqky
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(261009223027099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGlNNE5sSFhMVU0rdVJZc2xERGVrMURCUGUxYitEa3RCSFd5VDZmUDBqbzFy?=
 =?utf-8?B?NzNlMXM4WnZValJPNzJiWmhKUkN2QnZRZ29IM0JOQklxNFJBUWdiS0tlRWR3?=
 =?utf-8?B?UlAxQ3ZvNEtjZEQvKzhwM3EycmR0dk9RVCtCNzJabHdLcDV2NzZ0VUdjOHYy?=
 =?utf-8?B?UjFLU3I5S2kvb1NrRjY0STI3RERvai9DRjFTNWFwdWpNd2JDd3dld3llSWFi?=
 =?utf-8?B?eDZSeER1Ynk1NnZnVEdQT0pCRUNSODN6akVrQ1hzdFRaaVpKVUFhdzBnT29R?=
 =?utf-8?B?VW9iaTdEbE56Zld0TCtQekhTKzIxalVyWnlGbkJtOUlqNHIrZ0VTbnI1RmxD?=
 =?utf-8?B?cVlWVTJldzRndm5CTEpLdE0zRjZHUWZWWTlGVEdhbGhXZ3VBNndlZkUzQnpC?=
 =?utf-8?B?ckFiQU9SVzVqdWwvQXBCOGRtZHgvOXBKVHBRams2c1NObVEybEhqdSt4aDdX?=
 =?utf-8?B?Y2V0dVNuU29jbHNiRVZBQ3Y0KzE1OG9RLy8reEk5eEhsZ1FmWFo3Vk9JNzlK?=
 =?utf-8?B?ZzREcVhoSjRFY0wxQlRkVUNJbjNOLzgzRmRVN3Rhb1luQ2hKOXF4OEdBZWhL?=
 =?utf-8?B?SnE4QzFqcUFEdzJHNzZ5VmZRbURMeDlCVGw5VnZyRGZwcHE4K0hmTk9QTUZH?=
 =?utf-8?B?M2VLaEh2UWYyRWJDSWZqbXEwbGZ3QTQwSDYvTTJYSmdSTDg2STFhSkZ2eWVp?=
 =?utf-8?B?VTB2Z0x6Y0I0djVlUGdrM3dNL0xOb0tHSkJhajNjQitDR2g3MzJwRGNlck90?=
 =?utf-8?B?aVBTdmRZazN4VlM3SGxicXo0K0hEaXBkSW9DeDUxdm9vQmVuOWdEZnVhUHE2?=
 =?utf-8?B?bktxMmFuR2E2b1VYcEhVQVJXbWRsN0d2NFNldDI3bmdsb0QvclhaU1JNVmNh?=
 =?utf-8?B?T05sZTIwNUNJVkh0M2RHaUlKWEQyZVpIZncwemsxYVRlK1dHSlpHKyt0WEkr?=
 =?utf-8?B?TUlFQmNMR2NoZFRlMnU1U1lVTk9vRGtGV3JpRXBZSldQdWg2OFpxNloxNmQx?=
 =?utf-8?B?NDU3dWhac01CM2lvb1NXUnNFcm5FcHBlWHpqSXFsMjhMMDJUNzZnUHFIYXJJ?=
 =?utf-8?B?QlVDN0dackxQOHBpYnJIYVZDUVEwN3hBZnM4VVdoOFFIbk1oQnN6Y2NoSHBp?=
 =?utf-8?B?cE5UcnFiWHlpNS9iVk1RTWs4MnM4N3NkNUtuSkZ6My8rSHNkRE5VWnVIWTFH?=
 =?utf-8?B?Rmk5Yi9RZXJKd2VQNDdINkpPVGVENjRISHBYc3V5SUtyZXZka21LV0hYRHUw?=
 =?utf-8?B?SmtNczR0UFZiZngwMTdYRFdGaWpEd1YzVUJWSFczb1o2SzZqTW5EQ0ViRXhT?=
 =?utf-8?B?NUFvd28ybjR5VnR2OWVUdGJDR2VUeTM2Tk1aTVdZZE8wUDJlRGd1eC9PclVi?=
 =?utf-8?B?VEZ4dUZuL1pqWkl5TGdISXJETlhvYzhnVGdVTVlQUFMrY2svUSs2ZE5INytT?=
 =?utf-8?B?SDRSSUw1Tjk3YjFTeFB4NVJHRUIzNUJqNFlIdTZOS0lrM1ppZVNHV29yUm01?=
 =?utf-8?B?VEgyUVpiS3N1MXJUaGtnbE5WK245VlNzUWZBU2tLTUg5NythaWt5WHhJVXZG?=
 =?utf-8?B?UUpjaTloYzVtdU94a0hmRURaNjdTYTlXWlRrNHh4aCs4enplQmZOajNTeko5?=
 =?utf-8?B?NTB0bHYranNZVmRZbm5sWnFaZVBUaXVMY3gzdDBkekxMakZSRFFsMi9idGl3?=
 =?utf-8?B?TGtYdlJmS1NWalNRY2xITm5KM2U3VlhIRVJDUlVoYno5eWtCTHZCOEVmdjEv?=
 =?utf-8?B?ak1UU09sREFOVWdoT29zV3hBeFBXSm1IT2J3eUlQdDNwb1ZGd1UyRlV5TXNI?=
 =?utf-8?B?RFNwYldsWWdoYTc1RmVjWmJDQ3JyUndpaDlmUDZLclk0dnhZUkNFazJBTFdT?=
 =?utf-8?B?WVI0NmdrdDhiTmc5amxHaFloV0xETUxJV2xTdmN3QnlyVXl2RWxMQm1BMGR5?=
 =?utf-8?B?M0NSeUttR2lUQmVLK0hzSnAwVFoxNE9EUWw2VXpON2YveDFXeUsrRHMrQkRM?=
 =?utf-8?B?NEVITW5TeTRxMk84Qms3YitWWWxpV0grNmRpd3lEN09FRzRuNG9uT2NQS1Ju?=
 =?utf-8?B?SU1mc2J3ekpPanZmSFdQTEMzQU9wR05Xa2UzRjZDMlFzUTRVYWpPVW5kMkN3?=
 =?utf-8?B?SFExNG9YSE1VdnFBNk1VZDNJZllmM25BZEZGMXBGWGJwaUhjZ2dneHA5eVNG?=
 =?utf-8?B?cmZudzJGcGdlcnpTNGZJOUpad3I3MXNLTVFlTG1OT0lQam9PcS92T1BHUHlD?=
 =?utf-8?B?MVpYZVFjendLYWY4WXYxVWVuRWQrTjBYZFBXcUd3aWpYSHpMbDNpdWdiUlQv?=
 =?utf-8?B?SklKYTh5ZFVINytldHhrSmY2cENxNE9SME85U0ZHOFB3dU9jdy9tdz09?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e5299c-8936-45a5-6434-08df3a728700
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:52:47.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uf5BTD7NBUVWCjcZ7bvQBbWllp0XJqemTfZHv27GGa/SkEO04SBsLZtpawTyy5n+wU9x7Q0XL9Eb9N59+ecGY4AlQnop4rOxaco+BY0v98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1075

The issue was found from a field observation in a PREEMPT_RT
deployment: a receive path blocked for hundreds of milliseconds in
prb_retire_current_block() waiting for blk_fill_in_prog_lock, which was
held for read by a preempted packet copy. Manual code inspection found
the same unconditional write_lock() in both the full-block and timer
retirement paths.

I reproduced the ordering on QEMU ARM64 SMP PREEMPT_RT by delaying a
copier after frame reservation. Without the patch, the second send
blocks until the copier is released; with the patch, only that capture
record is dropped, and the block is published after release.

I will include this in the commit message if a v4 is needed for other
reasons.

Thanks,
Jingxuan
