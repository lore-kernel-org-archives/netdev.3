Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB0478870;
	Tue,  1 Sep 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254458; cv=fail; b=NTc0PTd5vDr4FhfDcfgTp5rm4rN4/A2gtuBAE6fFNrkmy9LxTzr9LPGfMNrodGat/wHZaCFDMUeHaMyreV5RJ0FzN7stq2lSgK06jfFbhZYXi64SdbThNrcYHn9prji36uqxjDiwNRbHrYvozxgAfrV70zBPrczkub8qJLzinoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254458; c=relaxed/simple;
	bh=a0ZRDCNx7n2SCDVOJ/E1WyLBeovdOc46jrN0Y/VidK4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LAM2w5GgxlsZsVupccfbt7Wk/hMMglg6MU0GpnDNRo7uXjcXDXEvMzxeadNcJ3lx9ULN7jUHcbsuKRM0PCO/HB0+oz2jMQBC4tO+rKRx6j9hlzfXxPoo84dfAc6NPg/+FLxEU8a0RwWCKDA18TCMLzVE//floCx4x9PG8Flihcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=38Qf7VB9; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="38Qf7VB9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk0hUKljhA4wS/m68wgDFIOCyZJtXhALSVZtAxZ40TlQamsRxkb8H9u9eaY+tspB3ymMK0L76ZL81qn8sgVTwBoiAw/ffW/ubr60fz8LgMTi3Yt8zhl5kVU9eykPelq3mC0XUN73sVWnOQhi4DR1yHgOIEB8n7IPevsLn3fdcdUPIGiV/evS4n6PjpnYn3k0r6QA715r9JQlqQtoSDjiiVlTicsEMdB2pE/g5opDq1gdpHI9yNavoCOGhZieRMTPoJgpVZNldf2Xog3dNAkx1kQq/5pC6sDwlZ9CZ2M+nX+YHeI5Er04N6lLSapBBGVIl7eVG10f8thSk7NAJxDxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n2jox2C+QbFk6/+hVEzvyjpozm3mVY8PUqGIpo1H5E=;
 b=JLHQMz5g2FNqj3jzboRmx7HNs3/7x6eslm8kDwg8Va+e4UEGSoG7hRpy9Yykn+/FE85QMTBj02icy24BX7Ed267I3zzvx+smT0+MBfnlLdsYcVJxRLqBgJfloqHyBLhK/4PQlmvl/0W3OlR28PjUnmqXow0057NG4YkKsc1W5kRqkbKu85G65aR6yMJ35n6kxLKhO1DJVEgVzx/tQb9UE++I7eZ226M8OhVD+0kFTAsWHrFe14TsgoK0NCkLoZwU3VDSVKT4IVEVj1DeTlC8sG8tZWMmXyYaksxbXyhfzNh1GAsW6JAMNDwdiAaj5F2AS/KH8jT6wAwx96WaUpH7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n2jox2C+QbFk6/+hVEzvyjpozm3mVY8PUqGIpo1H5E=;
 b=38Qf7VB9+k8KTJi7TO3HIdvq/TwQRfhqAAL4UMH89tOXrS9g4yOgqT2H/HfSN5B+rQl+ipYRLLLhCfneoOcdmNIFSV1Ty4ysoTecthcxKuonyQGaRtOSQnEegYWHIJ8naiZPXI3Ne0qoFBSAQWwgDK6jwii4cEZa2rvBSjilK38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 09:20:44 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:20:44 +0000
Message-ID: <97659f05-eb58-4c90-96b2-59d8d8c9830b@amd.com>
Date: Tue, 1 Sep 2026 14:50:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: macb: configure ENST registers for all queues
From: "Karumanchi, Vineeth" <vineeth@amd.com>
To: Jakub Kicinski <kuba@kernel.org>, vineeth.karumanchi@amd.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
 <20260806162557.2762166-1-kuba@kernel.org>
 <20260810181813.0d1fe0f6@kernel.org>
 <4c719349-132b-4dcd-b332-a84d3a92b7df@amd.com>
Content-Language: en-US
In-Reply-To: <4c719349-132b-4dcd-b332-a84d3a92b7df@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0232.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::16) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a04198-8fd3-4c04-95c8-08df080a4cbe
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	p2N3P8uASbIZrKWOd4lcRldqh8qExZwhBXUPCo/r4As3hiR6GC7k18T1yiZRTOYkqYnMi169GEbb+1LsvZJ7FYypnjy0uDZsAhp5xkl0q8vvN3efxLy4iD9j0ZyV5PRDh+bhZjc3xZZMIVmUTlGkTdOS7pqi8c/d72ulBizD/bW+JXzE47urv3kBEI7o88cO82C9woiC6zNvvZjvli5a7KWHGTWGKrrhoyzJ2ESvZ6NkVDSvpYimzNFOV4oHwMnaVizTNY8umHkleelMYvRm1GmViDHJrFRjbkbPD/xWMKu9wiIiKaMKlEgL0+bqEj3vG/gz8bI2WvhHxcXd34302yPc/tdvPxA7EP6LCZOor4DKNB9oCldwuV3r/L20sOJuNk3D2U3pwf/B5kflpNZ9Hx1CvGUE7rN8d+PwPiuam4Fe1k5mWPTtQa2qZ5oVyH/rg4iDo+zTEVa6tPCczsXkVSBLC/O9DNUooYWUyITRBN0YSoPZP4ypPmND+QUOpSN6jryMdsnqMuSbVGy+sbGaTSSNW5yC3/d5T3dW6t4ouXAci0TjnoaUAnpJqLnlShhaJTpzSuKchN3IEwkTd4OO1tyQdaO3m4kLHPWRaiAUiImleCTpJWPDPnBA0nH79taqOzY0IpaRN47qJNvqU16aNHkwrMHGPxLpn8wcHmNWwLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnBJQ3ZYZTkwQUc4bEE2c3ZtbEFsZGh0MngyWW5iOWJCd1pNOUl1Z20zbWxa?=
 =?utf-8?B?QWVRMWc2WEdtWnNkekptb1EzQXVaTTE4dlhtRTJUWk8xcEhlYmNqNHBPMzFP?=
 =?utf-8?B?eTYzT04rNCtXNjJBVUdhVXI3b3pjZHRlVWlZY0lTZi8xTFI0UVFvbm5VTXpN?=
 =?utf-8?B?R2xmVU1mc1lnelN3WTVNT01zTHV2RThvRWZ5aDl5OWVLNGNSMEVpN3lWcnA4?=
 =?utf-8?B?R3oyeE8rKzJXRytHUS92dUVwVlNWcmVzTVVQNllFelBUUFRvdHJUSzBVSURY?=
 =?utf-8?B?UmpNMUVIeUprMUtMSGZaWUdabFI5YkdDaEl2L2VMMXA1ZHdwVXMzNDZsRTJV?=
 =?utf-8?B?dUVXd29RTzRpRW9KRWNtbXMzc2NIUXJlbnFrOFFlUDBzeURGRHZVaEt0OWhu?=
 =?utf-8?B?eFpOV3E0MU5tRmpCMDFJOTdJVUlObjg4bnIyVkFBc3Y0dkozcWluaHdUcmR0?=
 =?utf-8?B?bmVsQjJCTnRZNE9sUVpDL1lVeWFlRWpZcUFpM2xRbnhIZVVGelAwRjlrS1lT?=
 =?utf-8?B?Rm11Q1VVQW1SRDVVTUtIWUxpRlRjcjZRWURPNEJsaHB0ek9oUjY1aTVuWGhD?=
 =?utf-8?B?cGIwcVNERHh0eDFFT0x4aThzeWJMc3gwc09uNktTWUJIUmppT1dBdGtjZ3VG?=
 =?utf-8?B?TkNuNTd5a0RlNWVLblRQQjFpVytiU3lKRi95a2FBbmdkNkNOcFpLUGo5ajVR?=
 =?utf-8?B?ZmIveTNvOE9SaWwvTmNGOERyaUgxdXkxdUp3MjhiaTdFK0FJYStHUUV1c2Z3?=
 =?utf-8?B?QzMzUVNEalZxTmVHeWxDeDlDOWo4OVk4UzZBYmsvNXNBWTRhVTBBdHR0VHhK?=
 =?utf-8?B?MzEydlU1OFo1TE1jejc0cnloVWptcGo1NExlRlZRNnhTMTBtMDQ4bmRQZ2hX?=
 =?utf-8?B?OUlLdjM1MHlKT1JPeUlVZXA1SkJRdGxESHpuZXpIZGNPVWZxUklVcFVJaURl?=
 =?utf-8?B?cERyeEJwOS9VeUdNRkpyQyttZXR6bjN0V2MyeitaTzVVd2orR3ZXc3EzUDFT?=
 =?utf-8?B?UWQ0MTBFcWwrL2Z0V1gxK3pwODV3NllOUlNYS2dqZGREY2syR2lmbnV3UDQ4?=
 =?utf-8?B?NmNoWktRb1VtZitHQVpCYlRhUTZRRWR6NHl4bjJOeDhOU1BOSkJHdXdLU0I1?=
 =?utf-8?B?cVE5ZTdHdElXU040WkhHc2w3amdneGVydFMxbWdUSDlNYzNFODNESlpkalJQ?=
 =?utf-8?B?UmtQemU2S0syNkkvdE5zUTNnVGtaelhERU1hQWxXNFN1cjN3TzYvczl4MWth?=
 =?utf-8?B?bXRiU1ZscTZHdjBQazNEZFZnOHQ1V1dEaHlGMklTSE5meUVLRzgzT3NIM2ty?=
 =?utf-8?B?VE13b3hnNVZCNk9qc3lkT3REWWxMNHRKRGV3Y0E4S2xmUXNJdUNiYU1hZlc1?=
 =?utf-8?B?ci9ndjZWV0xBT3NOT2llOHpPbDhVcTV6cUk3cmtucnlQczR6U1NXd2Foa2hR?=
 =?utf-8?B?d2JtUjF3cEdhSzFSbUFLMXZwOEtCZm5RMUVvU1luMmF2ekFPRTQyVTdIOVdn?=
 =?utf-8?B?NGt4c2JiZ0J5cXhSanJFNEE2RlhDbFArSDh3eWRFMHVCeTR3Y2lCOG1YNkhM?=
 =?utf-8?B?YnpVZGw5bFU1MjNrMXh3bGN6NFpYT3BJZStFOS8rVWp2YU1JM2ZKMEsyYmJP?=
 =?utf-8?B?aWpCYjJYVCt6bXZmZmxyOGlnb0F1UGhjU3QvZ3FKTytmNHpEWGUzeERMbjgv?=
 =?utf-8?B?YzhhY3JVcFg0Mm9oM1JNZlRObmdDQTNDS01zYUk4OHRTcHhQSmg2QWdxR2x6?=
 =?utf-8?B?amJZSWNXNzRPa0txaERINEJDalZHU1hoelNyeXE5NUp5c1lLenZ2ZFBIc3pG?=
 =?utf-8?B?ajlKUzRQcGlGU0dmWVYwVnpwWERqRzlGRnVxaW11czdkMVBXU3RnYkM5MEpX?=
 =?utf-8?B?RGNzOW1uSFowTzJzeExYcDhsOFAya2RBWTBoa2MzV2hMdHZQUk1MT0JIWmpP?=
 =?utf-8?B?Qk5HMjhIS0JLT2llRHloV05oellGNWRPbU4yVVlnR1pQK3dpTnZ3cTJrbXRw?=
 =?utf-8?B?SjFIMnNCaVNtcUNNV3RPVnV1bU9yK1ZzMmJwejlWZVlaQzlacFRDL29NQmNN?=
 =?utf-8?B?RU1CNTk1VGhGck9JTVU3N21XTlI1THhxMzN6RmdXdlZzWlljTU9QbXBXZ2hK?=
 =?utf-8?B?amV3ZndZSGVTanFKc2FuZGlkT1pOL2FrNURxaThHY3VKM2VqMUVadWN0NGx3?=
 =?utf-8?B?MGxJWXAxdytCOHVMbmlKWU5FTkJLc0podW1XTGlGRW1TaVdvNUdSUXA0Zytx?=
 =?utf-8?B?eldqTUM1NXVmL0dObElKOVVLaUdQNm5qN0tKN2p5bUxEMVBpckxQczBtUUJn?=
 =?utf-8?Q?KUWbB2quDfsVtkjzMp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a04198-8fd3-4c04-95c8-08df080a4cbe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:20:44.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoOsADDSucFr+Kanb3m+SWdMNcmF0bXS8r9oypIIquoIM+QwkZmO0AU7K3phzciC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

Hi Jakub,

On 8/11/2026 3:47 PM, Karumanchi, Vineeth wrote:
> Hi Jakub,
> 
> On 8/11/2026 6:48 AM, Jakub Kicinski wrote:
>> On Thu,  6 Aug 2026 09:25:57 -0700 Jakub Kicinski wrote:
>>> This is an AI-generated review of your patch. The human sending this
>>> email says "What's the expectation for the other queues?"
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Highlighting this (human) question in case it was missed in the wall 
>> of (AI) text.
> 
> Sorry, I missed your comment.
> 
> I verified the behavior both with and without this patch. In both cases,
> the other queues remain disabled, and all traffic is transmitted only
> through the ENST enabled queues. which is the expected behavior.
>

Just following up on this patch. I hope the explanation above clarifies
the expected behavior. Please let me know if anything else needs to be
addressed.


Thanks,
-- 
🙏 Vineeth

