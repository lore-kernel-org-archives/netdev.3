Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793962484;
	b=kZOT9+c1PJCXhMPK40b2DM3QZ8LfhPe0E6Uxrb7Yc/Oet4bXGGxxmykrhMz0ED5DWWYW
	 XzqB78/W9FQgQbwHbvYhLvPshzOSoB2lKvUv1LHgnbl9FXRgzyQVwKZjv9kXmtyhAaRpD
	 UUG2/bZt3TwBe9btaBGEUlnVRCPoRyLbmDiJ1TKnDqlTiAvC2CE+SclE9/nKHumzpu3t1
	 7MaXAIzYKKs2iWmS1tTgGjUaDxjUgcXI+ASW/VLOpmtP+1xhtG8oKw9Ueb2VFaAf/O/bJ
	 Vh3KD2kKFVGWPdl7MHCr7ZuO576mVfanrXs/BvTyzj8FwR87QJWK9RNtvHFWZnDougA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962484;
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
	bh=9DaJ7iAacLCN90iq+IfAZgw6OksfHcubyfMWp6hmTPw=;
	b=BgQgILkVKYPUj7DGW8xs4QpNrnY7PaQtdmuKeC06IR4eaXiTYkX/njNwEchDxOP5o72R
	 tFEuqZQL1nWPomB6UQwBYH5U9wn1CYDMGQU+bH2bp3OCt2Fe6ZQRlDSgEGdNSDcnJ1Hff
	 FWk42u+hnTBPgfeW+ywdYhe5dVkgkA4CYkpLeupazW3i/5xd/lgemZM/TyCOuUMF9SUHh
	 ve/fPW1biPQHrBANABamqv3ek33tGsScAM3qhJvCpzfyKHy85oTzSeUGJ1vOQfkz9adQS
	 FGT+mf3iZvS2gQeZkapeNyLy/+hTTkFv/KFMO/mB27wjDTE/RypRZtvFVRGpdORYrsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s4jLfXuw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.32
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62915606A33A;
	Fri,  6 Nov 2026 10:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62915606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s4jLfXuw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz44eFJD6yKkRmYhkFw5PHYcE84sWvQVROH+PcMVsmliEpLsFg/vsg2lsHTIaWvK9FKggUdifGOiurrdappa4SffO6WlsUPy5aDWPfJOOHWybFaehPMqfMMiqdg1el1GEjbe4/t2OKkRO4zG+NQOwqAUZJ0MgEy5/IF5qN7XWMejKlxXYaPTqhJo0CrldMyTucsZ99MxPxqKUeTZ2tUf5cUSG1XdhkwIsdTivllBEIaULX7HktDyooKtLstSbAN++fzc3im9MRNboUJTfovdjZxPCrHPvrjlD9IcZd0xle9OMfWlCFxWopuIG9yJEAINJ7OiVdCD7ZhXfr9iZGfAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DaJ7iAacLCN90iq+IfAZgw6OksfHcubyfMWp6hmTPw=;
 b=yKAeGP1gduk2ReF7Yg2eRwqUMge/SnAQOjdzHbrGG8AWg8k4USCbTYjfgcNsl+fTrZInSSU/+W/ZUJMYH+TMwhEJX1kAhsH9jFbnVQky36yCKLUsJC03GDJtrFuymoAOR14egcZbYBIAIZpJJse/o7+Sk7XGl70o5siEa+cFfKKIe82QCWD+jsqqNarPjdJRr68p3mhDK/S3/vfL1LUznOzo4g94zpwpYM65O2MJAKt3+6VaWrWebIm5Ev0pbEVcXGToGf72TdpKhvCpKNN1gZA7iW9avbwhBEzutEJbNjsTN8Nlg6yYVjQaHCZ4ZcoX57OnxkxAkM5jOkMv7qxavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DaJ7iAacLCN90iq+IfAZgw6OksfHcubyfMWp6hmTPw=;
 b=s4jLfXuwBBs6gOsqh7YkHNfLQdSO5zstUQ+8a53yo8T59xGQn/+SWSdz2PZ2nkTEzPfHvhlP+Fsi2r0FlLHrb3noGiV1wts9vF8A2IAg1hw1keSA7h1jvK1HNw6m/ls8FC7T2Qt/jZ3Rp5wVbf/b9XtmE9pSP8DluFFv0HZiM3XSupsqlOAUeRp9svpmPsxYMmQ+ZMHh2OWykfx1twtpvDOH0MFLlygPAyJt+MBRtXTtvVamQ5K1rh8w6/K9DE7YlKQsgg04Nk7xXtWb+2oTUtEC3imcPsqBzIeWprMQRtRnaZFl1IKQ8QeynbTN2qXplMwJMiLoAPrrqdREo0hccw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by CH8PR12MB999204.namprd12.prod.outlook.com
 (2603:10b6:610:35a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 10:54:41 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 10:54:41 +0000
Message-ID: <d02ac013-0ac5-4e91-a2de-796224a42693@nvidia.com>
Date: Fri, 6 Nov 2026 11:54:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: SHAMPO, Disable end padding when relaxed
 ordering is supported
To: Jiabin Deng <dengjiabin2023@gmail.com>, netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20261106083719.22798-1-dengjiabin2023@gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261106083719.22798-1-dengjiabin2023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|CH8PR12MB999204:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f814ac-e2b0-494f-44c0-08df3bf45c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261021135927099003|261022075727099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QD0Z21pN8bgJxhpZrLc3kde4n+nDVUVecwhGq6yWBj3LkYCyfnAFQerKJqkrU9ccX3C0iaoU4oHphU10KYa70Yh04vprYtgyukcUHsUNU21Yt0u1QWrj82Nf9hS0UMQCGRg3tu8FH2uhaPJ2B3MWNo/xbJwJp05Zq5Y2taHN3aUVfNYX6n/GNfnrP+15ftyqOdVIsICEH0bQT3gEuuQtJaMG6ewle4tIut4d5HX3fn7DzR/G1ASLcGSygHAZQq6tlP7sv8lJTehfyaO6KvSDD8YdmsUeoluWi9CQSSO784mSnfTTrPe+o9q5bvt5RSdT2gOLhrS8WUG+TWP4FyuSGRYuStg5JRyhXmz43dImbLV69Bvu5Lm5AfR6Eb77Ewa5Gclllj+VUu/PwtMKQlNlM7Rr1FUKuqH8CjkTP0BlcvoBaKPOE3J08eMdMmDrKAdMBX+8V1BSegYHzOrG78q79q13uTRKsz2LQryfliAjTrKuQSkZcCWdC3Be/rr/tD4J4gylkrWAw8Vknanw3tcditx21UJMsSYNbC0fgvppxRN0ohOBIvFehMOtLRvs0oLUv4LsOQpx8NDpR9M2q+9BZOQgH8UkIgw2jHvo7EJncyySAKpq6taEZOZK+E5cwtBuFw2wEobozEFj39VP+MhyWkmBsv1tq2KVg/XWLCqpm/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022105027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGovaFh2b3p1MnpOeVJvQnNuVU03eDhCRVJ3V0xsSDR4U0tpMmhXbkpTZUN5?=
 =?utf-8?B?TkhKbjBqNnl2bkh1TElFUkg2b3JsL25PdEhucTVxaXN1ZE9sTnR5N0krcDZw?=
 =?utf-8?B?MVA0OE9NNjVWT0V4bGJ4SUNmOHJHZ2Z5Rk5DVmNNaWpPTEdUc0pIRDltTSsx?=
 =?utf-8?B?K2xGVE0xVjNVM1RNWnFleW5NZjJaL0JqVTh5WXZCQmZYRmdCUTNXUjBqanlB?=
 =?utf-8?B?ZVorU0poYWVERDdKNndsTnVmK25MQUphL2xWb3loTXF6U09OWXkxenkrYkFr?=
 =?utf-8?B?TUZreXc1RFZnQ1pLVHhGUWJSd3pEM1NkRndwMER6KzJIV2hoY1QzdHZkZTZY?=
 =?utf-8?B?b3RQOTFrSFNJV3Vyd1VrSmJuOVkxY1FBSmxybCtEbllHeno1WUs3MTJxWmZS?=
 =?utf-8?B?NDVNRzczWkd2UWhZeG1nS0JRVDA1T2ZCazBKaWQyN1MxS2VHbmNNNnZQaTAw?=
 =?utf-8?B?RzZWVU5EdVk0cGI0S0Jib2o5aHFtZnVWTnpmdEN5V1JhZUNpUUdWWms0ZjBP?=
 =?utf-8?B?clloMll1SWhDaEN1RG54Mkg0THJ6VU1RUkcrRVR6Ymg3M01HVGJuZ3B4V3RF?=
 =?utf-8?B?ajZaTTJ4OUdkUjd2aVJCK1JxZURvcC9IVnpBTGVSVWxTQWpCYUxuRjViZFJu?=
 =?utf-8?B?T3piOUxoT1hqckVSV01BeWduNjRHangzNitMWElMRmF6SjdoSWRhTDdFMkpI?=
 =?utf-8?B?N1k4d25za1JlcnB3VklrdlBTNVpxVHh5a25xTUJ6TnV1Q29FZUtjbW01eEIw?=
 =?utf-8?B?WDROTmdZMnZ1S1R0ZmVYK2dmSi9YOWxNN0o0U08vR2pRRFVhdSs3eldZWDJS?=
 =?utf-8?B?cmtEV3p0VUR0WTlSaWtEWnpCUWdlS2RyU21sT29iNXJXSWFtZ3R0TmlUWjFP?=
 =?utf-8?B?dFJJOUUrYm9vbFVCWDBKdDl2UXJsTC8veW4zcHpzeW0zdkd3VDg0Z2g5a1RZ?=
 =?utf-8?B?dVRyRUkwVnJhRWtoam5uNlh1d3NGVWo1dXJPVDU2SVBHeEFQZ3VqMlFFZ3JU?=
 =?utf-8?B?T0ttenI4Z2ZrWlhtaktwSU52QmRjTnZRYks3REtoM2dtdkIwTkMxS1Q5aTAw?=
 =?utf-8?B?aytwV3ZPYmxaNlZpY2Jkc01taGs3cGIxby81NUlKR2dtRDdudlV2MTh5MURN?=
 =?utf-8?B?N0tnb054b2NZQ0lURDdYVG81K2Z6ckZJMjFXd1pNQllSK244ZjN2b2I1eTU1?=
 =?utf-8?B?dThlRExCb1IwV3ZXMWdrSkhsN3ZOOXU3YnFZaDNVWG0raGFDS280OFdYclBj?=
 =?utf-8?B?K2tpNnBMV2ttalNRbDMxWFhURUR5M3djVG03UXFpZ3VBd2tlbStPRG9iRTVB?=
 =?utf-8?B?elVrWC9NVkM2UDZpck1mMmFLbmMyWFlqajVhQkRESThNZjZhakdXaHprSTcx?=
 =?utf-8?B?d3oyNHZvdWliNzFhZys4bHMzeTVYeDk0V2JPK2J5bDc0VmNKSjA0NFJLdGZR?=
 =?utf-8?B?aCs4ekFuQWVLK0tMN0JFUHdrNVRmb3JJSTdmYkZDbXhWU3AyR2tCTG1LNGsr?=
 =?utf-8?B?VG9XTW1GL3Rpc3RDRFVxaENVQjUvaXdEdG1rMEEweW9PdlZtbHhXSVNWK1px?=
 =?utf-8?B?YlZPWFEyYWRVejlKbmRIcHdjMURaSFpmZWN1SW1NL2k2ODFxeEVrVU9RTVZN?=
 =?utf-8?B?L3V5YzFhend2S2ZLS1dpVkpwc25QZmJUMDFudWlicFlxM001VVhXblpPUVAx?=
 =?utf-8?B?R2FKSVhtMzhFTlFXS1Rac2Q3enFjZG85MmlDdnIrWDIrMGtCaG9USnJndFJh?=
 =?utf-8?B?TzJjU3VQNWVuWHIxV2pGMS9vWHZjMDRtc0dYRjExU0p2S1V4TXhMVFN6YlNG?=
 =?utf-8?B?THhVUlVFM2JnUWE2dlJoM2prd2JFTUppa2hkNnRyYXJTL0Y0NnVjODM3bUJa?=
 =?utf-8?B?K3FqOEJKZkZ5YjFXdjlHZWJVWEY3bExzQjFxVnd4eERLV3RmL3JVKzF6MTVV?=
 =?utf-8?B?by9lYllia0c1YUMyQkoyN0MxUkFzWStkaFlmZ1JsbnBCWnowMlM4QTIxbDU4?=
 =?utf-8?B?RHc4K0RHNXBsejNneng1cmllakdaSGZRZTJuUVNvNExCR29wRFV4Z1FEMVV0?=
 =?utf-8?B?M250RkFoRmJhMkh4M2xPNUlFOGhGOXpuTDBQRFNvZFUvQ0ZxUnRZUVFtVW9S?=
 =?utf-8?B?SEFZUWxMUzNnMWc0VEtmUE9udUZKNDFQVGRHcDYxWlJrZEwwVWZCZkM5U2VH?=
 =?utf-8?B?MjFuVnBQSGNiMjdpV1BsZVhsV3ZpQ2FnQlZVYkJFMERDb1QwQmZEU29DM3Rn?=
 =?utf-8?B?Y2tCbklTM1ExYTY4M0dpYzU2enhWTnFmU1h2UWNnamF0ZWZtL2JIRVljTjJw?=
 =?utf-8?B?ZktIajB1ZXM1Ti9acHgwNEltd2hGNlhoaGFMa2ZIMVJDeTA2dXIrdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f814ac-e2b0-494f-44c0-08df3bf45c4f
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:54:41.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMOFuqoHiPM9mb2jLF2erK5jKZi45PQnvM0kAnF0HolrW7SxNJu8wBcWnEDhiH1EJkQ6IJcUEKz2hlYfHlOxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999204

Hi,

Thanks for sending the patch!

On 06.11.26 09:37, Jiabin Deng wrote:
> When SHAMPO and relaxed ordering writes are enabled, aligned RQ end
> padding can corrupt TCP data received directly into GPU DMA-BUF memory.
This is a generic issue, not just for GPU memory or DMA-BUF. Why not
just say: can corrupt received TCP data.

> The receiver gets the expected number of bytes, but some payload
> prefixes are zero-filled, with the corrupted ranges ending at 64-byte
> boundaries.
> 
This is a bit confusing. Prefix sounds like the first bytes in the next
packet's data are padded. Why not just say that due to reordering,
the alignment padding bytes from the end of one packet are overwriting
data from the next packet.

> The current RQ end padding selection avoids alignment padding for LRO,
> but not for SHAMPO. Extend the condition to SHAMPO to prevent this
> corruption.
> 
> The issue was observed in a two-host test using a BlueField-3 NIC and
> an NVIDIA H20 GPU. In the original test with MTU 1500, 354 of 400
> transfers contained corrupted data before the fix. After applying this
> change, all 400 transfers across eight message sizes from 32 KiB to
> 4 MiB, with 50 transfers per size, completed successfully, with no
> incorrect bytes or corrupted intervals.
> 
> Fixes: e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
> Closes: https://lists.openwall.net/linux-kernel/2026/09/15/154
> Link: https://lists.openwall.net/linux-kernel/2026/10/20/1322
> Suggested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiabin Deng <dengjiabin2023@gmail.com>

Once you do the small fixes in the commit, you can add:
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos
