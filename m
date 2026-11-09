Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794252934;
	b=TgU+ASza0Al0b0K4Hguc+9UJaadZmfJWLGm3uOfy8PyYqcdSRSzDAuS3GYXFzsI9WJvo
	 vZGcB0UV17h0oHw72i0l+F6CuBry57PAhPsdrzVeycOM+zAX9NV+tDmIfa89QmXEGTurT
	 opKDnIjflKxERxj51t72efBxlUo94XjtqQVNjEt76k+jvju1mHZQM4S3HlQyZ/98nitdg
	 B9qISr+9TuzqpiYUjrZZJSgS5+i8SLvqZwBHjCK6eVIBFWAIjdqzvIZX7VLwtLs1BrV6b
	 ydoQ4v4R+Ktw+9p3alF+dhPDUBO0EvxXTp2HR60uCG8vY9rjCuQSyjfkSROlrNpYh+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252934;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=XEFcPba+XfaAUJ4pRuoBM8mBFed6R8aVk6b40VstW0k=;
	b=2RRPg9P6532lHvl1F7LumksRGK8N1w/miVaN6Zjy4f2EEqU5qHqCPuPcFenzX4SWTDXc
	 brMCLKBz0EiU75nRmOvgdnMQTk1MGT8HN+wtCgmbBoj9bYZLDMdgiK4cTBVSTNXUo8V/H
	 IU8ceuYF6yVi5+mPHwAXzd8SmMfgfS+hmxC23XxYbvmOvMCLO+RRf8whlraO1PB2SgxU/
	 Rd8DJdUE4aIe3Z9VwLvUko+hmg2A8CTwbTlOKjt/XcoLkZsfAKIN/UdLifkC4CyxREGU6
	 nMm97dOaEumavMJsUxv64mIclkqNNzmiqhltoQV63wyNbqVuMbKTVHKY/q7gztN/RBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Upoi+H2O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.45
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A0606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Upoi+H2O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKpWGXMEYK5p7CopsZiCWS9v25m+r3bA3KSSVDyJa44oFWWZsV2SDgyOr1eN3ha0kqi51vcJd0tt/pM6t6JHtwOZIEPY79wNKeVZw2goHF1JWHIKggoXNrf3dNJOzuljWVa43kW8G71JaveQp3RYVGnrjhmHx9Wfh+2PtE3E5lETq4Ig1jIKf33wUYZfPepMPELwpScuZhJ10UzRuF/qmPo8oA2P/ayqyY03/zqKzjPaTj/pC0nQiRIjMfcvxYiTqEtT9g9JkaoZRF/F/MzW/lXJyb7ffQPefN6ZJOLm8p+4yerK78DlZ8I61s42UVcb78b3OOskU7pgF0rAqg36CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEFcPba+XfaAUJ4pRuoBM8mBFed6R8aVk6b40VstW0k=;
 b=t1RMsUsEx8q8AkafDkY7BU4JY5CHlIa+2bnkDeV7sH67IdzfM1H2+XvbbX5GITfOpF/ZXWcwDst0wO48WVaJBpttgJz0JEeD9D9Yr2QT4O3/Grp/SScPCpGsd1jIfg+XzwHI2E8sqIv3hnErAQd6x7YkICLwvOBiEka38G0kHBLugM6GAP4kDjIos3j6ztUTVA0NPtUzaY6g3XoGRyWdMLekUbpYMerDLsiKsEh4X4ROuagg5EP9SswM7xq8u9ESlq1iXU/y2NdqYuvSPVgsvyNlplbSteTxM+XVnSP+LhKOGzavTYGAoVH4jJ66u7JJ7iVM4lap906DUfrzJ3m2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEFcPba+XfaAUJ4pRuoBM8mBFed6R8aVk6b40VstW0k=;
 b=Upoi+H2OsT46HtderEUbvgxOMoOVuXLsfqN1dMq4RAuQZFEtPyJXXjU4/CqnI1Of4AueaH+/kc3FfAqHuPZbORHHzEoCVolXAQv6/UJcbggDVu8U4QmC8J1WNG+afIShGzexpVAghgGXMeuA73CZaPih5uYn7nrFeEN/Zf4a0LY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Mon, 9 Nov 2026 19:35:06 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%4]) with mapi id 15.21.0569.011; Mon, 9 Nov 2026
 19:35:05 +0000
Message-ID: <c45b46d9-4dca-4fef-9bf8-9ab2fbcd48b8@amd.com>
Date: Mon, 9 Nov 2026 11:35:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/5] ionic: FEC reporting fixes and
 .get_fec_stats handler
To: netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
 Eric Dumazet <edumazet@kernel.org>
References: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
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
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: c8935ecb-f879-4974-6037-08df3e988dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|261021123027099003|261021135927099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RChzMT0QEJf53gMubbxNEobbeud3qDV6HUWSHgl+G1zc9SwLvKqxsi2rmZghXu8S6KnD5MgCeRqMXT3Tg5ZhxScSzhmmU8u1PoVl0mRlZQDtPRRI2HrZtV+gmnf2Aw/4pgXyUlmeo8AMIZ3gbDmaZAUdXdaRYIbZ7gIX2LzpwcvuxTJzHoeoX4VfqxWVaPB/R2547OpmKCXy44cK9/QopHv8PcRe46xqn5+bRC7Qr7ms8cZEGrzDeSfEqJe0oWHsoL3BL7YuT1qcL+p0BVtPDQEip/rkTiYQi1gzearAvA4JZeQso0aRv8fqb3TpfbeERcfKXnxCVJFZzzmd22JRv2UF9gU/8N2I6WH2hmZfSDeE22qXQYYh1zNiK0Qo5xGaZXSXFvzzVDZf5vGlMpHrwwh3gAMxUNt3BDYInhTt5BkfZpoG4cCC4EjFyo/x5JMYrXFf0ps5j04BIIgWMac+1CUCX9Vb8P3vG2+63qTn7mJ8KTyP/xE11/zbUYFzKDKFO31mL22tuc+bTlZXYuU2vcmPKfp4+YjqdIQC+BD/DEmwT5OdO9hiRxJf10VJNqEfAA7illBsB96yDoiUxj/mEtv3wZ913IGD+ciIOYM5oUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDNuMnA1dSt3Q2d5TkdVck02OEFyQU1MdHc5NDdwcVhDYzl1SFhJb2tYWk1X?=
 =?utf-8?B?am1iQVcvalRTazVmRXNqaEFLbzZyREZLYmpKMUR3YmkrYmppRVVlOTRmZ2pF?=
 =?utf-8?B?cmRiVGlwOUR0cWwwWGowOVhaUWhHZTBhOVlBR3pOcTVSYlpGTmZTbzd6QVJw?=
 =?utf-8?B?L1oreXk3MDg2UlpqTnhpMk41ajRSNjNWWG55VExrYWNMcVpCeVNGZmsxQm5j?=
 =?utf-8?B?alNXVStqYXdUNCsyOFhJd0lwUTYzM3hLZXU0VkF5RWVSRjZhVzcwMHExK2FF?=
 =?utf-8?B?aWNRdHhkUWVnZWZkbGxIYXdxSlZNWHE5b1lSdHhmTzRpUHE1STFITTBwVWFs?=
 =?utf-8?B?bDVOQ3ZhSHlLMVFzQ3JSenFZTW0xeEZXbFhYVmNDVEdqN0tQVDBWTjFxbDJa?=
 =?utf-8?B?V1Jlc1JWVkcrT1pYWW1CUlZpSVU4Rk4reEpHNmtzcnhvUFBBZ1h5ZW9sSU8z?=
 =?utf-8?B?RUtaajBUWUZUOER2QzJPUFBIVFRsN1B0NVMwVmhMdVo3bnJGRVp6R3lPL0lr?=
 =?utf-8?B?VDhFVVdVbE1GYS9xNlk5dEJWdjF5UE85SG5iclIvMFM2WkdocGF6VFZrWENq?=
 =?utf-8?B?ZlkvdGx5dHVmZjVpNlRtamU4TjQxZUJpUXlIZ3pxbXM3bHF2aEFzZC9pWldz?=
 =?utf-8?B?UndtTEFpLzU3ZXBPWjVWV0p4V3U1TGd5Wmx1dCtrQzFYZlFjUFNMR2dlSG9o?=
 =?utf-8?B?T3pmL2FyWDVRYjBSWmMwS0g5S200d3dwWXc2WXI4RmhkcEVCeThrWWFuVWE1?=
 =?utf-8?B?U0VDMDJqdUZYSXhaa09MZUdrZzJSa2dET1BNOEp6b1VGdlV2NzBocytsUjE2?=
 =?utf-8?B?U0YxM2kzOWxKUDhHRS9kQUN6K0NVOUtlbCtPUm1icDdndWhyWXRFSkJ2clY2?=
 =?utf-8?B?WnB0am5qWFFwSEVRNnFGZUtlaHZXazR2TTFyVmNjeUhZZ256L3RJYy85RDMv?=
 =?utf-8?B?VFJLMk5aVzBxa3RkSlpkbDNWcGwzZktXa3l2S1QvejZpelEzV2c0cWY0WkQy?=
 =?utf-8?B?a2VIS3EzOGFUK0tNbkttcXp4ekIwZmRDVXdSQVR5UFNFdkh6cTBuV3hBN3Zo?=
 =?utf-8?B?bmJuS0pYUFN0S1haWUxtVld5UlRQNnNaVGF1NlZvb2dmVnNkdGQ5Y0lEaGl1?=
 =?utf-8?B?KzFsS0lTZFpIWkJjMGVoeUNZZUhBZG01K21XcEQ2SFQra1BLODhRa3RXOUVr?=
 =?utf-8?B?Tm9IemQ0K2VjMmJPTUFqckl1Z3pGKzEvNlZMNitranZISDBESnhyZXhFNGk0?=
 =?utf-8?B?Ny9KTlg5TnlLdk5McGFpclRuOTBkWldqZy9ncHAxUjlwZmZmeHAxVlFEZGFp?=
 =?utf-8?B?SGZaNzRkUXdZMno0VTRwL0dTbnB4Wm90Q01LaXhVVEVPUUVmczNIUjJNVXJo?=
 =?utf-8?B?S29DeW5KVzN6NXk3L2FpQnV4UHdCM3JRMEcreHhqOVZtL3BCVE0zbk1jTXo4?=
 =?utf-8?B?ODhvalBKOUVEbENRSUNpQVp6L2tzYVdmMTA0OFVnVjQwZVF3UWg4MkJxVTZ4?=
 =?utf-8?B?QS9LS3Qva3l0bXY1NWM3cVIvY0FjbXh5R09VbS8xT3VXSHJuWWFOZURNYm13?=
 =?utf-8?B?a00rVE1tYlRRbHdKbm9yMUtxa1VISTdqYjd2OGxPSVN3VHhqMzFwaFRNOUFZ?=
 =?utf-8?B?NlNpcDRqNkZaYWZNV0EwL0RabyttTGF5Z24vK3BzMU0yWTUvQ013L1k3aHNX?=
 =?utf-8?B?blhSUFo4aDBrQy9kNTZ4MXZhOWxEaW10Ly9MeVh5U3RxZXJDUitXZyt5dDR1?=
 =?utf-8?B?cVgzektBRW9pM0RUTm9QNUphYkZHOC9kYUEwL3hPQmxIVU42d0hWdlpDeDYy?=
 =?utf-8?B?RFY2dms5akVUMzFUZmdWMjlib2NyOGo2L2Vtc2JKdVk3a1JHVG5GUUZLR3Zi?=
 =?utf-8?B?c2tVcy84NkhRcEVHcnNJOFJhSE16dUFuYzhmUnEvVFNnb29pUUFtRUw5RnVO?=
 =?utf-8?B?ZW85MXY5NFpMakdBQWRGdWdkUEpjaWpwVWJwZVlud1NzbjJVRGhHd2w4eXpE?=
 =?utf-8?B?ZDFmbEl5aDZvZnVKYVpabHdHRmIxbEVmNWZBQkc5dVpadTNwNkZSdkQzQkto?=
 =?utf-8?B?a3JZNnIreUtGcTBFNTV6T1NrSllhdHJjeVBONDR1WDlTQmxoM1JUVVBMSk1B?=
 =?utf-8?B?UnFhRGYrdGg1aFRRVU1RblQyQ1I1ejFOZzFYckpFajN5RTlYY3YrL25tM2R4?=
 =?utf-8?B?WWZ0bGdNMElSL1BFUWZ2dElrajVlY0paQlhiTE9ycEI0R0J4MHd2bCtRSVBz?=
 =?utf-8?B?SXlYeHJyVGFSY0hnZS9JbSt2cEo5b25BcTE4T3BOM1hjNS9QQnhPTW1sMnpK?=
 =?utf-8?Q?JH9FAVSaVsTK34CsUB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8935ecb-f879-4974-6037-08df3e988dec
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:35:05.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O38Eaqqk0PsueqJSYQUQUi7s47KpkHKqQe0TJLdCW/3FW9Blh9JZWHQhzgK9bzRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387

On 11/4/2026 1:19 PM, Eric Joyner wrote:
> Add a .get_fec_stats ethtool handler, and fix the FEC reporting it
> depends on.
> 
> Patch 1 writes the IONIC_STAT_INVALID markers in extra_stats one
> counter at a time, so a reader that tests a single counter cannot see a
> torn value.
> 
> Patches 2-4 fix ionic_get_fecparam(). fec->fec reported the constant
> set of supported modes instead of the configured mode, and
> fec->active_fec reported the requested mode instead of the operational
> one. Patch 2 has a Fixes: tag, but patches 3 and 4 rework the lines it
> changes, so it is sent to net-next with them rather than to net. The
> bug only affects what ethtool reports.
> 
> Patch 5 adds the handler. It reports statistics only while the
> operational FEC mode is RS.
> 
> The netdev AI review of v2, which Simon forwarded, asked whether the
> per-bin local really guarantees a single read of each counter. It does
> not, so v3 reads every counter with READ_ONCE() and drops the struct
> copy. The port_info lifetime problem that the AI review raised on v1
> and v2 is fixed in net-next by commit d90d1a768b3b ("ionic: fix
> port_info use-after-free on firmware recovery").
> 
> Claude was used while developing this series: to investigate the v2
> review questions, and to help write the code changes and commit
> messages. The authors reviewed every change. The series was tested on
> Pollara and Vulcano NICs.
> 
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
> Changes in v3:
> - Read each counter with READ_ONCE() and drop the struct copy of
>   extra_stats (netdev AI review of v2).
> - Report statistics based on status.fec_type, the operational FEC mode,
>   instead of config.fec_type, matching the active FEC mode that patch 4
>   reports.
> - Add patches 1-4, which fix the FEC reporting the handler depends on.
>   Patches 1-4 are by Nikhil, who is also a Co-developed-by on patch 5.
> - Drop Vadim's Reviewed-by from v1, since the code has changed.
> - Rebase onto current net-next.
> - Link to v2: https://lore.kernel.org/r/20260814-ionic-get-fec-stats-v2-1-13f0e7d2e702@amd.com
> 
> Changes in v2:
> - Latch each histogram bin into a local before testing it against
>   IONIC_STAT_INVALID, so the sentinel check and the store cannot be
>   folded into two separate reads of the firmware-updated DMA buffer.
> - Explain in the commit message why the RS FEC check gates every
>   reported counter rather than just the histogram: they all come from
>   the RS decoder, including fec_corrected_bits_total despite its name.
> - Rebased onto current net-next.
> - Link to v1: https://lore.kernel.org/r/20260731214021.15279-1-eric.joyner@amd.com
> 
> ---
> Eric Joyner (1):
>       ionic: Add .get_fec_stats ethtool handler
> 
> Nikhil P. Rao (4):
>       ionic: write the extra_stats invalid markers one counter at a time
>       ionic: report the configured FEC mode in ethtool_fecparam.fec
>       ionic: map the FEC type through a helper in ionic_get_fecparam()
>       ionic: report the operational FEC mode from ethtool --show-fec
> 
>  .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 116 ++++++++++++++++++---
>  drivers/net/ethernet/pensando/ionic/ionic_main.c   |   8 +-
>  drivers/net/ethernet/pensando/ionic/ionic_stats.h  |   2 +
>  3 files changed, 112 insertions(+), 14 deletions(-)
> ---
> base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
> change-id: 20260814-ionic-get-fec-stats-990736964908
> 
> Best regards,

The Sashiko review from sashiko.dev says no regressions:
https://sashiko.dev/#/patchset/20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7%40amd.com

But I don't see an entry for this patchset in
https://netdev-ai.bots.linux.dev/sashiko/#/ after searching for it; does it need
a manual submission there?

- Eric
