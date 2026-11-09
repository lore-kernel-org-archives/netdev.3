Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794209642;
	b=zqfsHio4VPO+T1Vp4m+7siOm/ZKOZLR/zaCjR4G46pvOIGOwHXypHimH47+Ut/2exJds
	 ad5j1+7PzPnXZwwJv28Nrtzpsc/PttnuAOSWWMIu3SJ9VV36+R5QXet/p1U1u6V8u0a+O
	 Iju3rCfbzD1nWo3TGUMvYIOfjX9WHGwSjEH94MUqUj3vlLWY/JcWvWPygcesTFKEikltY
	 7g5GiuxifffDLXMo3+dcd2gMys85TtIpJKjBeUc99rZ5rQ8ADFVYTge1m5oNkt5oPo2Dc
	 Dc7w6AHh2STpwiA/+qYC/Pab6E3MpznSRSpzW5qCXUGzgWqgK38gkGjN+F1QOrCs4FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209642;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=B3l+GDk6MeFYrAnRhVsWA6EIzPGUlkU1a9CHDfuLeDU=;
	b=G45e8QygBSNHZ6eyfToZKuMNUarh6sTpXsmezVHZwtZZkez+j/xTjjqFBlq10Jf04Ogs
	 RPPzIBBI0lhb8teX+L+y6nPJRWh99OuxpdZwOxTTFFUe19Qog0G/clUbRCUoCpuxlhex+
	 HqprKDmt+cdqwPenhz/NUUBPDB1mI5lY6B+hetgJR0QR/GX3/QHgohoqu3KByK26UW7eJ
	 Cplrjq7CgD2o6ZoVjSq2jHzTZCEFXBjlYjJhn/VSH0dGXIkCKxpEEZXXSs6pRc5gTsTRO
	 KaBNuO4WeceGLNDIaqYUxmSkKwyw8/sqBy/RI+6UfpEMV7nGz7tw5DTU7h/JJCxVCPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mlCzcOE6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.54
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928B606A321;
	Mon,  9 Nov 2026 07:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2928B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mlCzcOE6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXUuh5i1Sl7hF1KoyWFlfUjBLN95CRKbxa6MrFrCL7+PUzMbH/d2iSoid6Z2rQQJsIRFlpRsEjlL5JfUTOvtmj4fjQmrN95DH5bkc/8wY7ytVT8FZyhj1sK+nNIxY60WfUZQ61p+8q46xbIW7L8nSJgRDwmg6OXYmEchE3aWn06oNr+PRX9fReSbhUn2rXAwvabkEMEeeRouDRikZD1gftfpie+hNU6cPaJfYyV0r8vxV7LZDNL7WveJeO+ZUzo21Lby5pKlPVajktPrHlSKOzHFk3ugWJxbsLHEmM38J9pP/L3xo7zlDSWf9Ux+5URRBKKP7ZAHfjtFs2qQeEtOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3l+GDk6MeFYrAnRhVsWA6EIzPGUlkU1a9CHDfuLeDU=;
 b=KNBgsi+FQrEJ40mnx4XsEtVSzjG92CTmC2syG/xGLOKSf4wQ1c5Wd7NMFFg0IAPylvgCNvbb7myFv7LrAGVg4L0INQGrMzOykFtuTfjgec4hsj2pIRhxUDbUI/LTjhE89E8xfnmUZOs+gW0NYkdL0DA4iE6P5+qxtDa5pzvR3zpVRLh6oyhN/o4F2DDzPrvBZfw5XgbYUEXXSl86LInzRKAzINpAYZ/GlBf7xCCbC0i5W/myVeG27S++GxlyfMQzChK4Voa8P9s9bDq0Q5UlS5TCDW/Cx1n7dyVH0hiSGBl6estHiVMJ3zdgNVaQJo+UK36uWgqccCOtc+ze2xSXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3l+GDk6MeFYrAnRhVsWA6EIzPGUlkU1a9CHDfuLeDU=;
 b=mlCzcOE6DJdLlTH0UMRdx8repgg57hSs0KfP2B89RK2AdaQmoR0okAcnkyuuyvHCULEQzus+USe0nJ0BfDsqYWANtYgt1JkV/YAEhMFuBuG6IkkdJIUwd6i9D/z+Ifbfw+a0ef7wRhcxUgfJPfhEDpgjIrP72qm7/DYkvZ2Rd2k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 07:33:58 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 07:33:58 +0000
Message-ID: <057778fb-e2da-4edf-aace-5ff96ae386ba@amd.com>
Date: Mon, 9 Nov 2026 13:03:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: xilinx: axienet: use
 dmaengine_prep_slave_sg_context()
To: Frank.Li@oss.nxp.com, Matt Porter <mporter@kernel.crashing.org>,
 Alexandre Bounine <alex.bou9@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Simek <michal.simek@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
References: <20261106-rio_sg-v1-0-bc54b4bd8c95@nxp.com>
 <20261106-rio_sg-v1-2-bc54b4bd8c95@nxp.com>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20261106-rio_sg-v1-2-bc54b4bd8c95@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::11) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: c7edd7a2-27fd-4ea1-6ada-08df3e33d13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|921020|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U1wsMF1FhUWprpAGuo/Ix4YWsEEo9dXoh9HIzhluqr7tD06kjM2ryV6ArFFU/t0p2+bx8UIYjoNjs81hARVlw2MSF8+dkKVWY9rKaa6C0VEocT8HVDN5ohQuXtckB0IIZW3ykc1lOI+3C8iDiV4r5e0L0cwPFapIG03xc3uN6eNTgnWXMG/qe26dJyihkckLEnFHYf2/ujoITEvjeEnubJMNHKcTy3ltTBQINjMY5A2vlUrtOW28LddyDsXwwW/2vAJijrmGyi7Eai8edep0Z3KmYj+xSBX6RwA1B31m6Y1ed6iK1wykEVkbAl8l6WvRmq6Wv2nFU4w1Ojrk10S6covXh4Q0qqa0g77Lv6MGgdR+u3vAUqqepJUwhA668q9wKPaWv1GGKDsOt2t77AuqbzH3wherWNYf+9MnlLR31uNpIv/29Vw/Iucj+q/3uDrE0RvjJxSJgxHgY/XmGDWlpHdXwcOeYY7bN2Cqw5FsgODwio5bPdqzgVqj3/QuhmivtgH3H4+BWBWgawqtozKao+7xuXVy8bj9MeXG6qlolZ0+dPQmSMXGlXhSWYgDbVhkq/K6jlbkCwxCM4ykjBEqPtGNuqXyulsobruGp4dp55TAGGZRpfxbSrs7m7Zx1gqKP0VhQXgERST6UasHfNTcbqK3MmJjurPBk6yOZwKWEiNLi0adpFCVJBLR3E9G4pF72jBhg8Y1V3vrsV9WqoV4JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(921020)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnVqb3c0WDdwUW9wdWs4dUxETnovYWNHYWkwdzV3eFYyYnRTK0dOdDVuWHVk?=
 =?utf-8?B?dFR1S25NYnN2V0ZmdFpIMWluRTd0RkUxdk9mdHNLTUM5K0NVRzNsYTBHZ2JY?=
 =?utf-8?B?WGorbWNDblZpaWtQcGVDQWNLNS83WXNXeGpNNDlrandRbGV4TmxnMjBrTm43?=
 =?utf-8?B?Z2ROcnNqa2luZmJzRUtZRWd2K1g5eE12QUJqQ2hueURXK0RMTENHR1loamdD?=
 =?utf-8?B?VElFQS9aWk5nUzNXeVJTQ20wZzZvVi81MVBhS2hCS21USkx6cHdUd1orM0ht?=
 =?utf-8?B?NkM3R05PaFN4ZVdTTDRKc1FRd0s4dkN3dDR5QW4wdHd1Z2R6SExWdHVrbU9u?=
 =?utf-8?B?QVRObHFhT3I4eEt0THVxUEdzSGdYOU5McERUY1lWVlFkMGRrb3RMeGpUYUVK?=
 =?utf-8?B?N3VlMHh0NkRDTWlKN05ZWDVvQU5jdW9DNXVyT1AxYk1RajNBNzNTWmZoK09X?=
 =?utf-8?B?TXU5SVppeld4OHRwcGV3cnQrcnVKOE5tZGJqNUtoL05EYS9FdjNXVUV5V0pH?=
 =?utf-8?B?MWhlUXlWeUtjdUJCT3Q2c0UrOEt2ci8yb3REL0dPTnRjUjFUTjFRbHRqeGtF?=
 =?utf-8?B?TENpSVNqbVQvNGpnWVVpZ0JGQnZ1ajVlaGFwRVluMHh0MWtVQ2k5QnlRbFho?=
 =?utf-8?B?WmdKT05tQllRY0VydGpFcjlHMmhLb1NQSnc5bXh3RFlPTkpHMnA5cm55dE52?=
 =?utf-8?B?Q1ZTZklBSHZYSC9kL1dMdGZVZitmVUtFamZ1cjJLN2xSYWZqa1daT3NDNVpV?=
 =?utf-8?B?L3h2Qi82K0ZPck5tQjFaMFR1MnZvSGNYZHZwaXdBN0xmNEFMYjRrOUdWMTJB?=
 =?utf-8?B?dHJ0TWhHcm92VkZYRW5wMEJTVnc5RFhXOTIwS2wyZXdLZWQvRlhIbWlnZDc5?=
 =?utf-8?B?QStOcWF2RkZVSzZyMEh4TkZ6YXBwSm9qZ25MTzBzZEZRMXU4cmhjcDEzU0Uv?=
 =?utf-8?B?eVoyOElhNkZtUVNsVCsrTHBsNDhVbmVrYkdNWGljVW1rZitEVkkxdlNnR3pC?=
 =?utf-8?B?ZXR5c0orMy81dnFHR1hNQkVpVko5TWdDZGdhVVhubWpka1JIMHF0emh0b21D?=
 =?utf-8?B?THZqbUl3NzdRSlpBOGxWWTdXeEdGNWsrZXZzZFF3RklEdzhIMTM1Y1phdzBC?=
 =?utf-8?B?cW9OTGRId1gzQlNCdnFBTy9xQ29NTG5wNjBoR1pXTVQvM25nQ1hYTkV6NU9L?=
 =?utf-8?B?UEp0RmluZU81Vkp5NzRmZFJobUFibE9ONDN1d3FUKzZxQ1kzeGlicEdtM1o4?=
 =?utf-8?B?cHRjV1VTamEzYnZ0YTczNGRaZWxVTlo4Tit0cDBCTUFpenVNaEQrMDF5UGJr?=
 =?utf-8?B?bzdGUHBGbXI3VlUwTkRTTWRCK3FSQXdTSm5ieXhCaVQwQzhPUnF6bWdNL0Vk?=
 =?utf-8?B?VC9jWmFVTmQ4bGRVbFl3alZuQ0V6bFUxZVpnd0I1a1M4NGVLOThRTVJrSUVa?=
 =?utf-8?B?dEdzbUZuYlB1cnI4TkdtaE1nYnFUQmRWcFBMYUFwTzFTcDVoejdLQkVhWjc1?=
 =?utf-8?B?MFZQK3AzTGFTVEFDOVBPbmJTVGxMdytZOG9zSmFzeHFINVFleTJPRHRweUV6?=
 =?utf-8?B?VytlV1pKR3Zyd0svQmF6MlBpUXIxdnM0T3ZCKzJuM0RuekFkM1dnRE1VK29x?=
 =?utf-8?B?OGFKMm1DZWZ6ekZ0R2RMcmhUWHZ3WGJGcHdqcWFFUzNLWHdkSlNvTTBUM1I1?=
 =?utf-8?B?a2RsZlNlNWFqYmF6aXdTRE55VEp2aFRpcGZNVUY1NHZmbGFqcnVvY2xmdUtz?=
 =?utf-8?B?SGRrd1QzR0d1bTIyK2JNRzYydHNWeUVMZWlNZ2xHSlBIOFpweEZqQTFqTmpZ?=
 =?utf-8?B?WHVJaVdxL0k4aXpWTlg0N05sK0RrMVFQY2NYM25NRS9wSFFVVTZaY0tqOVV6?=
 =?utf-8?B?dDB3YTJNVU5GOUF4ZEIycnhtTkMzU0dwMklZRks4ck1TYVl2MnZBZXBPdGlN?=
 =?utf-8?B?MndxazVRbTM2bCttQ2hXdkxUckJGY1dnNzNNc0FxbnZBekJidHlhN1d0TG5S?=
 =?utf-8?B?eHgzZkE2b29kR0pjbzZoS29SdUhNd1RZTjU1RGxtbGhrSGhkSTZIRkY4UlBN?=
 =?utf-8?B?SlVOdkN3czQvZ2w5ZGE0YmRsalBMMWI3U1lORlo0b1I4ZXNDSEkrajJHTkZa?=
 =?utf-8?B?MVI5VW9zeVFrUmdtM2tSNXJ5Y3I1azc4R0VwZEpxUnl2R1FDQmp0azA2MU56?=
 =?utf-8?B?L1gxVUhrQlQvY1AxOXFpRlRFZHVRWS81emVYMFNRNnVHblpKR2lZZ0ljcitP?=
 =?utf-8?B?LzQ4MldNcUJ1STg4SndvZHJpeGhTb0YvbTJaL0JHN2RWY1Q3ZHUwaEdpSXVN?=
 =?utf-8?B?QWpKRXJyWk53b1ZiaFV0M09mTStwSkFzMlFqSk9FQUJ6a2dtNlM2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7edd7a2-27fd-4ea1-6ada-08df3e33d13c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 07:33:58.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxK3nEjJ4iU5PZsQD0vkW2epSwcAgAjkXRRfo8EzWFASeV7Kj/7tdtN0iMREUpSlHOxSGu9g6wPIi+wmSNxyIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086



On 11/7/2026 4:13 AM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace the direct call to dma_dev->device_prep_slave_sg() with the
> dmaengine_prep_slave_sg_context() helper, which handles NULL checks and
> passes the context pointer cleanly.
> 
> No functional change. Prepare to make struct dma_device private to the DMA
> engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Suggest go through DMA engine tree. this is only one of 3 user, which
> use context at prep sg.
> ---
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 7e83c4b5f1931..55d1b39caf7ed 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1006,9 +1006,10 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>   		app_metadata[0] |= 2; /* Tx Full Checksum Offload Enabled */
>   	}
>   
> -	dma_tx_desc = dma_dev->device_prep_slave_sg(lp->tx_chan, skbuf_dma->sgl,
> -			sg_len, DMA_MEM_TO_DEV,
> -			DMA_PREP_INTERRUPT, (void *)app_metadata);
> +	dma_tx_desc = dmaengine_prep_slave_sg_context(lp->tx_chan, skbuf_dma->sgl,
> +						      sg_len, DMA_MEM_TO_DEV,
> +						      DMA_PREP_INTERRUPT,
> +						      (void *)app_metadata);

After this change, dma_dev looks unused & can be removed. Shashiko bot 
also pointed same.

Thanks,
Suraj


>   	if (!dma_tx_desc)
>   		goto xmit_error_unmap_sg;
>   
> 

