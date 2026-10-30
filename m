Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371564;
	b=QyIFUOWLu6GCx2vqOP48DtpNSAJr2XkOdqzT3mH8XKAKhpva9GsbfRNBSwU+9vFhYYJ8
	 U7UwzmYTmQhyL5UzmgcHP+6/YgX1YXZQMTdTfNK69P/ZEeLMQ7Y1frqvYOZ28tKn+rDiF
	 sMtY9YI+tlsFJiDoUUbSqijFJhVmZnUf5sIJocbFSsVqGrqsr10NiKHpAvxZ9TwSX1n5M
	 ngta4m0HIOywoh7wHC+LR8TADtIzgXKz54JJz4kvku6ehSa4WrAYgLsTdtO/X0PbBqevc
	 57ritr0020S9vdF7RYNh0wc609oggLRl6JRaCjRNO1X0ykWoWRVh1FaLEva5Shlqxsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371564;
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
	bh=lk343fCuBMznOVWs8z661ylrW7LSI5XeU1TF5uxkhWw=;
	b=sCW0gTt9ApfwisIoU0lejNGlHYb0lhUPzjA9BUboClbi9OxDIXI19sQ/3gUcImVDoTSn
	 ANHxLnDVtuaGCRIR6HUUQpoza2DCowe9VEDGV5lG2ynrrMxiilTHaa4ZM800RQQJe7TCR
	 vFIUnDHb6N1/D5bS+ryDN/gsq9azRYDWpoUxITJxzYJ4le9+wX32J0Jes4ow1IgT39ASt
	 8A90kJ8VP0rgPCU7nOwqTkh1tVt6m9Dwk8TgDI3ljDRCpkrXQQIANVkhAPAf7mxs/OjYR
	 gscVZTqB25kB1lWGzatVhU8xPC87NDTyBfZpzdJAZryu1eo99EsU8HTVV+HBvZdZA6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KYajrmU+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6245606A31A;
	Fri, 30 Oct 2026 14:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6245606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KYajrmU+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhfCJ+uLVe3XxEMP22ZGuv4Af19Cm90CqwwoBTZSmkD5o3QoczYu9c/SN/4EQUoPAXh8UkvfeDUh6spM2P61FeAgEV/YxlbkAdSG6O5QUwmf9QZEy6SAG2Y172QscQ+Z9lsW2a0uN+qYA2MNyXlx8oSLPhc1aAOC5onBqLL66SedyFPt3oMlMNk+inw1PgQrsdSkH+6DV2/FP2GGp0mt8Xftb1Dl7YgB04c0nwp7SRTktM/8MCLd8S/ixnT/C5FPkOSbPKG5bxSE6gPxJp1VgyKMC9JgeWP/1ESNkF2bE/soky1AMK3h0yYoxVIgSmwRL+LFhpNzVnxzLf1by62o3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk343fCuBMznOVWs8z661ylrW7LSI5XeU1TF5uxkhWw=;
 b=tkSi7QsJe73J4ldVLKLXWfwqLk4wQ2ilee3zx1YxdK0CvC575Z5VdtBUncf3nb6Orukl42FRL6WzhGvTeuXe672ei/ldS3a5YnjI/gzfjrILyOb+zWCGjUErXqJOHslRdKM4RYNXIGt404ZK+a65cBWbTvl+ox6eTDtXs2Mga/+jmD97hE7wa+CEermzzbpS+tf3NRKXJbuAqDoOQJha6CGgOhh60S/Q4xyryN60J/CTwLv47HwrroggEjsPRqxt/ovLQb2q2lZN1OuWb2d8jbYZHSI/6tQyhE8fgYa5tUHB7i7SK9VuyAubLS/cg0telH2hk/DRZtw3nX+d78NsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk343fCuBMznOVWs8z661ylrW7LSI5XeU1TF5uxkhWw=;
 b=KYajrmU+A7oeEIwBYzGldkEOTedLQcuGkTPKmUd5H0FUdJdjOLsPzaLck10G/ZdspUtmF2dvDTu8nIWdtN6W0bsdBQaIPj7pSagzFSyhZDqKwohJd5tA2U4T0mW123NZVuL7VFckezDq3fSDV8djszEMzRCYpT8OSudVNHNlPP8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 14:45:59 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 14:45:59 +0000
Message-ID: <3d996b3d-c205-4bfd-963d-4698af571bff@amd.com>
Date: Fri, 30 Oct 2026 14:45:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/3] sfc: ptp: drop the stale frequency reset in
 efx_ptp_start()
To: netdev-bot+sashiko@kernel.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com,
 pieter.jansen-van-vuuren@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20261026123023.3566549-2-alex.austin@amd.com>
 <179336480940.3134.13795222150880092351@kernel.org>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <179336480940.3134.13795222150880092351@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0373.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::18) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eab799-3e22-481f-dc95-08df369482c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|261021135927099003|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|18002099003|22082099003|261028144727099003|4143699003|11063799006|261026140227099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	iC0Cec60J1puxT+n5WV4iMysFCW3MWurFErs977dKwgX49J2EDT88H7nu/LCnZA/T/RwHhqHuALlGaWA+O/1Ms7fdaTVPxnLmSwQ/GzoexrvINU0ErqPFwggATJZDzO2k8BJuvOCxrzWSpWRcJkFQQzFt0L97EG/dM+ekkFBRnJBwZUq2iFfm+sYKszKrkVspX+7e+KKg99nI3wdkkVNiS2BvtHPSI+drfuEfuGqscEnUK/BhCAkOHcNwWPiIc7Hl3uTZPTFQ8xSJOBPI8iaoMZNix7i2OlvaNZlm3EQbTjqSSjU4CSh8um+2AZ/UwAlMNyM1E/JgJQvJjt2IAHWKaS9ssHEOfB2qL9Si/s42+5VIpAn4J8wrknWHUPBJly5eeUFr8p8V/w8ewyAlxZ4afeGZydGSfPAhgqiTKeLa6/thwUuOm9Fwq0jW9SpjyMmNYDrmrqXKL85+BZOL0Dx7ERnGgvSVh/1CR/ac+zWRv0dmr71dMf0lLpuZDFTjYe5oAVsRxyiKeflADu6Sjbn4xiqoYVbivKQhorKZzz2D9D8Ko80FQp/V0KZRxfZOCeRbZiu06edG3kVMuLmis5MYHMmKdErnSSCNBhxRLPfSw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(261021135927099003)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(18002099003)(22082099003)(261028144727099003)(4143699003)(11063799006)(261026140227099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk41djNnZFN5SUN4MGlqeXdSeTRTMEtWeUcrK0VYSFpOYVJHSGZwdDMwYnNq?=
 =?utf-8?B?VlllUGViVkMrUUxCSURrS0tlQzM4cElML2RPVjJUQVhocFo5Nm5zMUFZWW9G?=
 =?utf-8?B?WDBrYTgyNkxyTlQrTi96cG16bmUrZUVvMUlIUnZ5eFRIK1gxZUlKdmc5RkZC?=
 =?utf-8?B?R0c0UDRWNjc5OVNBMGtLUm9QZGlDQmFweDdIYVBGUTB1cW83TEV2WjE1L0d6?=
 =?utf-8?B?cy9mVVJvRmVuU3NpNGk2YXdVRkNnd1daWWZIbkh0VTFMc0JJMzdvOC8ySVc0?=
 =?utf-8?B?SWtvZFIwRVFXMDNtaGRxc3Y3RmNLYjFFbEdDaHpSdDRvWXgyVll5d20rQnNz?=
 =?utf-8?B?M2lZTVNCV3NwZHpPS3N0cjJNZFZ6N3FWK2RDZUlCdUl6VXVld0tiU0I0M0Jh?=
 =?utf-8?B?bGQ3bkpycVo2SVRVMzIrTWhNaVdERE9DR1hZVEsyMjVmekpTNkpBeGRpalAw?=
 =?utf-8?B?V1pCcEtrVC93VEZITk5hNk9CaFlBUjBuYTdyYjRCbjBsQzJLZ2Z6aWtobUZz?=
 =?utf-8?B?bm92Q2xPNjE4Qm8ySy9JMUl0TmhuTzh6OHk1b0UrMnk4OTA0NVNOdXFlTDh3?=
 =?utf-8?B?bUdZNFVyTERvTlM3TU0yNDNxNEsvUExBUzlFNE5ycktIN21JS3dyaUJrUXpC?=
 =?utf-8?B?VnJmOVF4d2p3TS9lT1hoa0R5V2dVWlZkekRvTlk3RzVyMDVBWWFwQ3A4OWhj?=
 =?utf-8?B?a2J0d01venpzQTVlYjU3L01zZzJQWUNQcjk0TDdVS25CVzRPeDM5NGhkckVl?=
 =?utf-8?B?bWdUYytxTmZIS2IzMkd3ekNNUEE2RGlYcHJxbzQ5T0poOGx5Q3BROGFoS2Fj?=
 =?utf-8?B?TGgvZTRUbHFjWmVsS3ZHcTAvaUN5UERkNGVOejBCa2JPQUkwbEFFRVdQZHRs?=
 =?utf-8?B?TWFhZC9iWGZxZWNzNkVzbW1CM3NyY1IrUlNiT0Fsdkl0SnQwVjlOOG5MQW5H?=
 =?utf-8?B?TjJSeXYyNnljMjhmZm5VeERQS2lUM2F0WlBRL0R1L3dsMEpOVVR4N3cwKzZa?=
 =?utf-8?B?YXhUTXpzTnhjZXdYZklDd09uZTlML0V6Z2dPc05oYnE1bmIrMjBpSldTN3V5?=
 =?utf-8?B?N3JEbGMvOHFPTEx4NDVQZWorSmNZL21oMFhQSXM5RkpybFR4QUprbWdCV0pK?=
 =?utf-8?B?cVVnamdhOEJxR3AwY25TRmFCamsxdWlQUW9xL3E4LzRLb0JlWGo0UERJR3d5?=
 =?utf-8?B?cWZ6M1NTckxXN2FEMml3a1ZieTVSc2hKcWlEU3c1YllYQ203cGRYRnJjcVhN?=
 =?utf-8?B?TW9sYTlaSDJVMDFrOFg5Z09IeFlSTWVkQTRnemdqWFl2Mk5mUkRPRGRUMkZa?=
 =?utf-8?B?Mmc4UUlIRGZUQnUwYkZOR3RJWWw4U2RlNFN2Qkg2ekh3dzR6ZnR4d0IwZkc4?=
 =?utf-8?B?SmFJMkRFSS9CbnZJOXpuelM2d20vTVdXTHBrRDVhYUJqWFBIWlJZeExreDQr?=
 =?utf-8?B?STJheWJMREpDZmV0V3JCT3BySWRId0dZS3NOZjhqZzNSclZVRDcrbFJhQTI1?=
 =?utf-8?B?QktrbEdBMnlzVzRVSnNIbVMzRWphc3U3NjlmbnloSVJjOTh4ZUlnOGxSbzJv?=
 =?utf-8?B?ZnMvdEVzZnRlSFYyOGMzY2dPZ2FrQ3h5ZFY5ZThRby93TXU2MjcxZ2MyM2FJ?=
 =?utf-8?B?VTRZaFZoanBEZFZPdEIyRjZrbS8zR0RCK1dsTlA3dy9UM2ZGV25VdlB0amJj?=
 =?utf-8?B?dVdQMDMxa2ZUMkgxNzdFeFZURnpsZjV3L0dmWWYyc2Z1MG9iK3lXZDhwaUN6?=
 =?utf-8?B?S1NkcnRtRTdIUXJMbFNEVnUyZmlhWFIwdkdQdmNGSEpuTVFyTzRhYmFKQlMw?=
 =?utf-8?B?UUduTitiWjM5Ym03dDhSU2dyM2FuQ0YzUGFXYUtoZUdvTkZ0SVV4MFZwQ1Vw?=
 =?utf-8?B?TVFtcEQrMC9GZEIreGZoVlQ3VmR2VVBzaHRpMG54MkdzSWcrTWtDUmNrWVQx?=
 =?utf-8?B?bzlFMFZETUZCWUU2b2FmVTZYbVFpcG5XQnNpN2ZhSVA2b0VFMjJUL3ZzY2VZ?=
 =?utf-8?B?ajdaV1JPYk1uYThwUHRIVThtdXZ1UW4rRFNycDc5YUJ6Q3Qzc2x3MDZraUU5?=
 =?utf-8?B?WW9pakd2VS9vS1Ayb3J4UXJnVkd5dHFvenR3dTM0VldGb0dLZ3VrNTBLaEZD?=
 =?utf-8?B?S3FsRmtRbzlCTm0yMldPYmoxWmY5M0RqdFNHVGJtdi8xSWJNTlZ0dXpzSlFP?=
 =?utf-8?B?Rzk5YlVsUnNlc3ZlN3BvVjdqZkVReFNvMW4xUHk4OGZQYWhkSEFVa09xQ0h5?=
 =?utf-8?B?UXgrdEN1dmZaeXFRaXZRWWVSR2o0UlVCQ2MvTVVWU1BtODZjcGZ3cW5RV2Nv?=
 =?utf-8?Q?qwKPLJUvOfLV2GjcR5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eab799-3e22-481f-dc95-08df369482c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:45:59.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJy/hYL/ONhCpcUQJnfqeCQPUQLr4JV+OZgauS93IeXo2vyGtMRLodh9XzKlCX0oTdoDK4Iwa0DGmBPpNsFnhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644


On 30/10/2026 12:53, netdev-bot+sashiko@kernel.org wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The fix only changes the EF10/EF100 copy of efx_ptp_start() in
>   drivers/net/ethernet/sfc/ptp.c.
>
> Pre-existing issues:
> - [Medium] At this commit, efx_phc_adjtime() reads
>   ptp_data->current_adjfreq (drivers/net/ethernet/sfc/ptp.c:2129) and…
> - [Low] The kernel-doc for struct efx_ptp_data says `@current_adjfreq:
>   Current ppb adjustment.` (drivers/net/ethernet/sfc/ptp.c:272, and…
>
> --
>
> sfc: ptp: drop the stale frequency reset in efx_ptp_start()
>
> This commit stops efx_ptp_start() from clearing the cached
> current_adjfreq. Firmware keeps the clock frequency across PTP disable
> and enable. Clearing the cache made the next efx_phc_adjtime() set the
> NIC's frequency trim back to 0.
>
>> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
>> index 00cfd8d5b46ea..957ca08092e7f 100644
>> --- a/drivers/net/ethernet/sfc/ptp.c
>> +++ b/drivers/net/ethernet/sfc/ptp.c
>> @@ -1445,7 +1445,6 @@ static int efx_ptp_start(struct efx_nic *efx)
>>               goto fail;
>>
>>       ptp->evt_frag_idx = 0;
>> -     ptp->current_adjfreq = 0;
> [Severity: Medium]
> Should the Siena copy of efx_ptp_start() get the same change? The Siena
> version still clears the cache right after efx_ptp_enable() succeeds:
>
> drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_start() {
>     ...
>         rc = efx_ptp_enable(efx);
>         if (rc != 0)
>                 goto fail;
>
>         ptp->evt_frag_idx = 0;
>         ptp->current_adjfreq = 0;
>     ...
> }
>
> Siena's efx_phc_adjtime() also sends the cached value with every time
> step:
>
>         MCDI_SET_QWORD(inbuf, PTP_IN_ADJUST_FREQ, ptp_data->current_adjfreq);
>
> On Siena, all the paths named in the commit message still reach that
> reset:
>
>   efx_siena_ptp_change_mode() -> efx_ptp_start()    (SIOCSHWTSTAMP)
>   efx_ptp_restart() -> efx_ptp_start()              (ifup, reset recovery)
>   efx_ptp_worker() -> efx_ptp_start()               (reset_required)
>
> So the next adjtime or settime would set the Siena NIC's frequency trim to
> 0. Meanwhile the servo and the PTP core still hold the old value.
>
> The Fixes: tag points at 7c236c43b838, which added this code for Siena
> hardware. The later patches in the series ("sfc: ptp: serialize host and
> MC synchronization transactions" and "sfc: ptp: avoid racing PPS
> timestamp updates") don't touch siena/ptp.c either.
>
> This assumes Siena MC firmware also keeps the frequency across
> MC_CMD_PTP_OP_DISABLE and MC_CMD_PTP_OP_ENABLE. The commit message only
> says this for the firmware it targets. Does Siena firmware behave the
> same way? If so, should drivers/net/ethernet/sfc/siena/ptp.c be fixed as
> well?
>
From inspection, it looks like the same issue exists on Siena. I think we
should take care of Siena issues in a separate patchset. Additionally, I
don't have a Siena NIC handy to test on.

[...]
> [Severity: Medium]
> This is a pre-existing issue, but now that efx_phc_adjtime() relies only
> on the cached value, can a concurrent adjtime and adjfine leave the cache
> out of sync with firmware?
>
> At this commit, nothing serializes these two accesses:
>
> efx_phc_adjtime():
>         MCDI_SET_QWORD(inbuf, PTP_IN_ADJUST_FREQ, ptp_data->current_adjfreq);
>
> efx_phc_adjfine():
>         rc = efx_mcdi_rpc(efx, MC_CMD_PTP, inadj, sizeof(inadj),
>                           NULL, 0, NULL);
>         ...
>         ptp_data->current_adjfreq = adjustment_ns;
>
> posix_clock_adjtime() only takes the clock rwsem for read. So an adjtime
> can read the old frequency F0 before an adjfine programs F1. Its RPC then
> writes F0 back into firmware while the cache holds F1.
>
> The next patch in the series, "sfc: ptp: serialize host and MC
> synchronization transactions", appears to fix this. It adds
> ptp_data->phc_lock, holds it around the RPC and the cache update in
> efx_phc_adjfine(), and runs _efx_phc_adjtime() under the same lock.


Yes, this is fixed in the next patch.

>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026123023.3566549-1-alex.austin%40amd.com
