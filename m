Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792548817;
	b=g5IN87CGD1HvnsM2aPqYcaWYl5exC0xv3Fmr2ks3/YkoB6nMo+3D2g4Hgrl1m7dxPxMc
	 3BkQ9Mp0sey0Vhc0QOhv7Q+TL7uPHWpgHElgfzCMgpW50l8ZAeD/h+htjg6lwQv9RO9TG
	 lV2FBsNfmqdgfvIwEGlpCJajAWaZlyx31Wyl4r9egmeFV4IalX/NX2nie1TbtJzQx5gRp
	 4xDJZzSGBd0hwVC/QjW3K/cYHRt/lVBDauPTQqEaX7fop8lE6+SQUUKbX2MbmbKalKU+W
	 kgKVAaPZLePsDP+NJSzZeQPdWbEYEHhtGKXBODcBF+XXT465IjX8ZRwYKl8YJvJFZow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548817;
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
	bh=XF+BLP57W9FohW1YdI7KSC08AbJ51q45O4BPRlRsHPM=;
	b=GuG+gRPgb3lEb3UQuyXTBTbCde8xwBsV1d3VNoRfJECWsBsynwCvIwmLBYnJ15WB+Ru5
	 CHomHPHbcLK1kT/2t2ONaAyc9CO4EvK1g/O9W8gQpTDD5bCecFZi7OsV/w6dU8unpf5ME
	 dRcCpSVgpiivD0xJYLZcpKt4ouj6K4A+EVhZIx+W4dv4zhk9FywVEra0aCKpz8IL1FJma
	 3PzVeVTGWqo7FN3CqBMnB54aiMzetuMWg25yD3AR3rmFW40qdybIY/jFYQz75zLdFtwsu
	 pS1YK6sPROPMzYz3NJn5sXWRrnzvcBsasyLhF1ynf2tr8qDPL4Y7B+XUZw/zdnHd/dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qpYUtsin;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.53
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6474606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6474606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qpYUtsin
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltKCffdJLuNtlXy/6FgdTq3bBDLhXUVa7skSEqjgOJSzhs17TvPsm3Ui40Eyb1Bfu0/fW9yjwqL7mfLUem5t4UGWsXoyKZtbVe19Evah5dbI0kdLrN0xgefXGT1G7/C0a0h9r6cempjQl7ABMLkbLcCa0NV8fqjj432yvzJRlrc3rBmu1K7q5vVzAuH9ezZmHmPhkZMILgATfesQ/tyEe9uujQTz3LCJ9AEcn+QvKmUTWgZ0uZmPCY0tIOYRoslwuKvmi8NVxBuCKQHg/X+oRU9p4dl8UfJNYbhmbG+F74kgzp/40r+fs+G51Zdibuov2Bx5Zxs64oWoRx8KwVe+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF+BLP57W9FohW1YdI7KSC08AbJ51q45O4BPRlRsHPM=;
 b=JIAjy62DyJ1UP0bkfmOLFZkiz0lMPTRcV4pPfpGVmEdFf07djSQz5umJm1QD8RmjV9InLmiNuC7Mk/rdiBVSXNJg119gabEh24Tf0enHVncJyqbnaU22lfxV4OOJTcyELCAzfR5uceiQLKnNtmkEuL7OjA46BfaQtJosjYBa2uzxPEt3FUrSv/Qxt5kYHX4SuMhHE5Oh1qCrI6pZ2BNErcSKVxz9skdnapZw9r2vP6RJK9Ool0q6rfnON4QOXnHLk9VUB3UrLrIup+ah5GwDMbStTkj9dM4mJdHIYGb4hfwjGExNq0NwPw1K9UbxS03wqfgyl26Rfzan8fIvZpEURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF+BLP57W9FohW1YdI7KSC08AbJ51q45O4BPRlRsHPM=;
 b=qpYUtsin8+bclwHNqUrA/PlwAzWID0FiA9uIBchm0B1TaVOmloi1ZW658Fn6+u2+qKsmfsMeLBMA3T0mdmfgzjxt6IeOSoUg2lBgKFW3n0qs2rMK6JgcwLKhwCEgLQaSpJzhL+URgkyprfitQvxoXRMyTJAM9P5oDo7NLtUSAC4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 02:13:34 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:13:34 +0000
Message-ID: <98cabf4d-1088-4012-8636-7e26cd37d3ee@amd.com>
Date: Tue, 20 Oct 2026 19:13:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] ionic: free port_info when probe fails after
 the port is set up
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nikhil.rao@amd.com, vadim.fedorenko@linux.dev, edumazet@kernel.org
References: <20261015-ionic-port-info-lifetime-v2-2-57232013fd79@amd.com>
 <179245202451.3135.14858672804771242161@kernel.org>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <179245202451.3135.14858672804771242161@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To DS4PR12MB9708.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|DSVPR12MB999171:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b2f6ff-b08c-4caa-df67-08df2f18e8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fRWyQFuXaxGCva7MIxJQBF/UWmMMBnSmKl9RfXRlBvKVdO3WkFh3xYGEdHtH0f4Pl23edZ31SEkj30uDlK1I9FW6x8czmFYlfCAzT3BLTScQKb+cYzFU43vM9SSXTDf87lNKlox6ufYqazliPLvhqVuCMpH8uDEnbPL3KJqfI6fwzvxqNr5Ixu2lOVOchOSxt/k5tKcSAAxfInShd5lB8MdjdTKbSXVE69hP4ZMs3TdPT1cgpQDJZfzsQsn9dqJ3Ba8UXJLrH8Ugkw0E0Kgw/ANQON1/0g7tkwKtZuhwGAcQFZQ7yrgt8/WJ0L+WD3MvwUML1ESTCfl3p0uGSnJVq/upn/CL4M5/5i0f9phrtRSzy+MUpfseIDFi6f9HdUSgvMAAIEytEAJuCJppgCVn30VwRrmO42/Gn2EwHk25U/ZiCif/6UnVc83e4MTMqJs3B104HPrRWOEMfZ2c8quQhOn5V9xCAx9KG7srYDs5mG+ccob8TcV0f1RLJNgsFs+HD52pSveMgkMZSgGp0HLpEz3RFqpzQahsGTjLz97eSZKsM8bVUnfaiiTjvMFuiSiTw66uirNZxQA9fFnkGWE51BVgTRpqsGLJ1DOIY93peFTUM/OSiCNxncHn97aLNeC/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0ptVWxlK1ZWaUpJU3g4c1VQUkNWQURweE5BcjAyYUt0aE9HeEhtaTYyT2p1?=
 =?utf-8?B?NWhFc0RWS3dBMm96NWpPSzNRTC8zTWF6NmxrVUFaVVZPaTFHc0s4Um16VmNa?=
 =?utf-8?B?dk80dHFPalg0VEtYSlhFbXFUYy9LRG0yOHQzS2RuTlNkV2Y1OXVzNWpMS1NY?=
 =?utf-8?B?ZXBqblVuNXVvNGtkR3QrcTZlNnRJVWhtZGFDNkhEWE52VG10eUFqTFpPdVow?=
 =?utf-8?B?WWErb0J6eWJUYjBxaEgxdWlWd3BXYmllL3JwenpoVUIvZlJ1UmN3TVpXdzh1?=
 =?utf-8?B?TGlYQWUyYU5MempIVkFrMkVObDNraS9BQ08ycVU0V2dzOW1MYnNrckRRdit6?=
 =?utf-8?B?K004SDZienowM01jNTRUSFBUWXVMaThDdnBIcWlGZlJVM2tLaUNJQnFMb2pZ?=
 =?utf-8?B?YjNYZ25SNllPM2FnTGgvb05QeHhYQzJ3WVNVSWFDZW40dU1NakFwUzBLVjhD?=
 =?utf-8?B?Vyt2SmtCZm9xQmROejJVQndzc3ozTEphMk5jY2Fac0twaFJnUUZDTktUTHRZ?=
 =?utf-8?B?bk5yVHc4MlZNWlVPVVhyTVgwZEZ6VUdmemFLSXUrb0NldWFQaXJ3SHdaTDZh?=
 =?utf-8?B?RGZQbDlhQVIrdS9LOXB1MnlNallNZjBYemlITzBueEx3TkZCWGZJL3k1d082?=
 =?utf-8?B?SkJETm1MWVB5cDJ2ajdJMUV4MG9Ick45VHhqZ085Zno5NVNxTU1wVUZ0Z2Ix?=
 =?utf-8?B?TUsxc2FwUkVrRGROSDQwbTNRUXMzcjlYcWhYc1czUktwMHhpRDNINHdXWlZ6?=
 =?utf-8?B?Qm11TjRBU0t4NzJjZ2xRNVN4TjVpRldBOUFyY0tnZkdHcmZ5bG1yQm1ibDJ3?=
 =?utf-8?B?SU51NzFIQUZPd0t4cUlwMTBQSUh3OGc3Sjd2SHZKb0xXdUJraE8rck1BYVdu?=
 =?utf-8?B?WWREb3kxSFdtQTYxT0g1UkNlMGJjYXJmOSt0c0lweXo1ZktUNHkySDd5eXRY?=
 =?utf-8?B?MTZuQ2E5OVduUjltR0FDMldpd2tmSmFvUFFFQUFsZGFubTVsdGtqNytCRzZt?=
 =?utf-8?B?UG5Yc3hpR1EwbzdHK3JzN2FQcFowZ0VTczFsdXZycm5sYUcvT1NFRTJUS3lB?=
 =?utf-8?B?L0Qya3dQUXFJOGR2aTBTZ0tmL25nV3JVNzV1dWwxY0haVXR2ekFHQzRSeU5T?=
 =?utf-8?B?N0UvUi9OZWp6Nm13cVNSZHlVMDJySFEyTTluMjRvUSs0NEFsbDZNZTFDOVJZ?=
 =?utf-8?B?QS9ud3NMd05tTXdDU1lNUVFSVWlwcjBWTXNNVFc4TmtlcVZYeWl5ZUlmODgy?=
 =?utf-8?B?QnVJa3NaaEFmZHFTazJhMTlycVVRbmZNdGlJYjhBeGRob1pGMUtRRXZ3ODA1?=
 =?utf-8?B?aGZHVXh2UWRWM1VFWTlRa29HMC9aYXpmMktESUwrcVpSZ2gvakdqR2l3TCsy?=
 =?utf-8?B?Y01uYnJVZTVwdWJVcEM1UjBTTmhIdDBtT3dpZTZ2TEo0ZXNja2c2L1U0dzMv?=
 =?utf-8?B?bU5uRDBSL3dQc1IrbmU2NWZvZk1leDllSk96ZTZNZllHN09mS1RlVmh2NHdF?=
 =?utf-8?B?NzBNbnJPSHR3VjgzdEIrMlN3dHdqeklTY1kyRUU1d1BKcmJxN2c2dzlVMGRx?=
 =?utf-8?B?QkpCaVJwdmJCakUydUVDa1lwY3BuaEhHSWxGVjkrTVVNVDFXeForQWtONEpU?=
 =?utf-8?B?cUVXbXpxSVZBK29ER1laR085UzlpVWREL3BxR0pwOEVXQ3NibGZBaHZKOW41?=
 =?utf-8?B?UWZYcFdGUVdhYkFmOThpM2w3YUZRajhIQ0tqQTZvMDBUK1JJa0VvaW5MT3g5?=
 =?utf-8?B?aFVZSHFtQlc1b29jTVZ0R0J1OTcwNWM0K3R1V1R0eUkxSklWZkJod0RTZHkr?=
 =?utf-8?B?TDNWRlo2OGZUTWtrdTEzWXBxbmZyRU9ncEhEbGNvRzVsQlY2eVE1eTh1MUJn?=
 =?utf-8?B?bUNXNDFtcmF3a1NuWllSTGFlOVJmb0VaVmpEdjBWNjIrbUtFQVZiKzlHVHRM?=
 =?utf-8?B?Vkt6NFp6eVJ5QkhvWXRuV0JqV0FxQkVoSDhUQVlXUUtPU2VRT2xSWlBKK2pJ?=
 =?utf-8?B?UFYzeHBlbzc3d25RRk1JTWpQZ2RnSURiWjByMnQ2RTl5Vnk1a1FsR0dxY3pI?=
 =?utf-8?B?b0pVdm1CRWJoLzlLU2x6Yk1rb24yeDMzZWVVV2I3WXhhZzJ3NHp4YWIrL0tq?=
 =?utf-8?B?cUJjbmxmaDJySjdCNE5mMXVnNThlbFVrNFNBdEh4NkppTndOb2w3RVR1bzVB?=
 =?utf-8?B?T1EzSjRtM2ZkbkVQS290VjhTZ09vMUlGZVg4YlBnK0I1UmtjSlIvT0tkQjRM?=
 =?utf-8?B?bW9NemZIWk1vN3FpWXJ0R3FxWVdTNFBJOEF6ZFZYNnIxMEljWDNpVC90L2tS?=
 =?utf-8?Q?+tGVF1mFivikaLawfo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b2f6ff-b08c-4caa-df67-08df2f18e8a8
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:13:34.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGGfrTCb8EKtdVjtO3at2kBIsQPU0y9ZS//3zaB2zw1SWizuj/q5wO59p7dHvcdz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999171

On 10/19/2026 4:20 PM, netdev-bot+sashiko@kernel.org wrote:
> [Some people who received this message don't often get email from netdev-bot+sashiko@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new ionic_port_reset() call in ionic_probe()'s err_out_pci
>   frees the port_info buffer with dma_free_coherent() even when the…
> 
> --
> 
> ionic: free port_info when probe fails after the port is set up
> 
> This patch adds an ionic_port_reset() call at the err_out_pci label in
> ionic_probe(). The goal is to free the port_info DMA buffer that
> ionic_setup_one()->ionic_port_init() allocated when probe fails later.
> It follows the cleanup order already used in ionic_remove().
> 
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> index 05f19489ec5c8..68b3bceedd999 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> @@ -397,6 +397,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  err_out_free_irqs:
>>       ionic_bus_free_irq_vectors(ionic);
>>  err_out_pci:
>> +     ionic_port_reset(ionic);
> 
> [Severity: Medium]
> Is it safe to free port_info here if the PORT_RESET command never
> completes?
> 
> ionic_port_reset() sends the command, but the wait result does not
> decide whether the free happens:
> 
> drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_port_reset() {
>     ...
>         if (ionic_is_fw_running(idev)) {
>                 mutex_lock(&ionic->dev_cmd_lock);
>                 ionic_dev_cmd_port_reset(idev);
>                 err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
>                 mutex_unlock(&ionic->dev_cmd_lock);
>         }
> 
>         dma_free_coherent(ionic->dev, idev->port_info_sz,
>                           idev->port_info, idev->port_info_pa);
>     ...
> }
> 
> __ionic_dev_cmd_wait() can return -ETIMEDOUT while the firmware still
> reports that it is running:
> 
>         if (!done && !time_before(jiffies, max_wait)) {
>                 ionic_dev_cmd_clean(ionic);
>                 dev_warn(ionic->dev, "DEVCMD %s (%d) timeout after %ld secs\n",
>                          ionic_opcode_to_str(opcode), opcode, max_seconds);
>                 return -ETIMEDOUT;
>         }
> 
> ionic_dev_cmd_port_init() passed port_info_pa to the firmware through
> port_init.info_pa. The comment in ionic_get_link_ksettings() says the NIC
> updates this buffer by DMA on its own.
> 
> Bus mastering, enabled by pci_set_master() in ionic_setup_one(), stays on
> until pci_disable_device() in ionic_clear_pci(). That runs only after
> ionic_dev_teardown().
> 
> Take a probe failure like an adminq timeout in ionic_lif_init(). The
> firmware could be running but not answering dev-cmds. If it keeps writing
> port status into port_info during that window, can it DMA into pages that
> have already been freed and possibly reused?
> 
> Before this patch, the buffer was leaked on this path instead of freed.
> 
> The commit message says:
> 
>     the firmware gets a PORT_RESET before the buffer is freed, the same
>     order as in ionic_remove().
> 
> However, the command is only sent here, and its completion is never
> checked. ionic_remove() uses the same pattern, so this patch carries that
> convention over to the probe failure path.
> 
> Should the free be skipped when the PORT_RESET wait fails? Alternatively,
> could it be deferred until bus mastering has been disabled?
> 
>>       ionic_dev_teardown(ionic);
>>       ionic_clear_pci(ionic);
>>       ionic_debugfs_del_dev(ionic);
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-ionic-port-info-lifetime-v2-0-57232013fd79%40amd.com

Hi netdev's Sashiko Bot,

This finding is that this invites a change to cleanup handling in ionic that is
outside the scope of the patch; this patch does attempt to slightly clean up
things by changing a leak to a proper free while tearing down the driver after a
failure in probe, but it is valid that the device could still write into the
freed memory if that cleanup also has a failure.

I think a proper fix could be patterned after Nikhil's patch in 6443f4f20bda
("pds_core: quiesce DMA before freeing resources"), but that was applied to
net-next:
https://lore.kernel.org/all/178096501514.1726280.11716563786761485251.git-patchwork-notify@kernel.org/

- Eric

