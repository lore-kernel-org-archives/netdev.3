Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09C348C67
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108606; cv=fail; b=p3IfnkkCmZs1fBHdND/fTRT7kKPQPcL/fUFkQcy3VeMDuv64JltNOEo3EGyMC+Q0YDpuMpdrGK8wBEW9VE1i0dgeoiz77srhatkjq8gdfrIUnR6PQHBPRot7gw/QYBRd3t4qNV7sl0PIMk94/7DKwQf7mgedeMSh9CRZ797BSls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108606; c=relaxed/simple;
	bh=2fiwnfu/tJgcbvXTSXLKvhIrcx2WGJtwQkyOqkOV8bU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N8mXb+jnsTu+gQYC5/hS4e3hDLhPk+eDU+HyJxsY5NyTBj+kWeJKax8QUL+HiubB6Igyuhv83B5O/Rmq24FlLFkYa0JqqJeeaxCBwNc7zhYHzOhqD/lV5PNiAaaswRgw/IORvv6aUGQG0s6lheiRyoOFAczD1PZYJO0VF0EqvFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a+PVGky9; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a+PVGky9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0yyPf9OOr0b3TbGlKIKp/q5YonojfUitJwF1oLOraqcmjQDbxfegXGn5F5ibHeDJNW6NBeMY7dfzMabT8kIY3wsWiB6WJbfk5A4TZsx3mpGFmfZcnwDaKmfeyawrfSs/C5hKHZwnNCqH72VDSlK2IrdfiI2Z1qPchgB4n20HaMS2TvN6lNWbvZ/lYL4XJQmU/mhB++Fx9VIZzXbKn20HCHiTMM8WhNelOW87VDEJiiXBHdzZRcl9lKLbmjiermcMW6mWYUYCWwit4Er/Uy3ZE9eg1GGZWAHhEjDUJqcCeVnNow5Za6Z97qkl3kiphiRF1GXlTtkbxUMltD4fRnPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr2sKvAyESeuvgzKJPe+RIWdT0redL9Gb55KkBBuSL0=;
 b=Td1SqdxLzCbhkTct+d3Bd+Idum3Uwtd7v1LJTD+fKS7ZoiLHAywi81ZvwjbtC9+60KcBkoT4nfggWKq6v0fU58cDvG9ClQM94MRfJ/cTFsz2nnPhnFjDt6AYRioj+nSwkuDa0Y9+OQfrxZPhGPoH8hLWTja0JX81agRH93C6G/dCkXOhYcq7qHRJRb1klqBCCfMhs4SmY8vJ4wPbGDbQJoXoss61aEOvA1tqZIwM8fWPpDY0VJAWmESQ3bD9sQA4QLO8By/jX8Tc74ySMuHSJU+kVfsGYhTC4oq35J7xwNJzFokmeY7GNng0k6CPWZfTAPtc/6Gltw37ZmNxpi5dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr2sKvAyESeuvgzKJPe+RIWdT0redL9Gb55KkBBuSL0=;
 b=a+PVGky9brBkAGVbsuM2XN+wXG6l6ral8Zo+hE/aTIu+A+ohPzHlozhJ/rj+NlGGfcfyZLQbKnXL0QguwuuPwihivHXA3bsQnxUXlIBzl8na20qftvIshQqKHYLDv56fnZuLU7ABrjts3wctPCzUKqzro518xcApNuVY/WZOHwo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 23:56:41 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 23:56:40 +0000
Message-ID: <03de28a9-ba9a-4502-83f6-7029149a29fa@amd.com>
Date: Thu, 15 Oct 2026 16:56:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] ionic: fix port_info lifetime bugs
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Eric Dumazet <edumazet@kernel.org>
References: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
 <179210571254.408196.9199301625371086933@kernel.org>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <179210571254.408196.9199301625371086933@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f13c91d-a2cf-4fb7-1b72-08df2b17f4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	I49j/u1d8xq6VOzuVljeWtD7M6RLuE3Lf1d7jIYI7q65SoXzkkGlymvku8neDGK2AybI2BNzYuJEjfFO1TEaGqfwtfW5E9L1YPtY8lhsdr9+koEwk0fwZefzdKEFLcjikrRN8eH27tuZDiBUPTC3/MjLyd43b1u+x3OMaefZOYy9jzmJHWMi2VloiK0D0dfJP0gEffapJSgUgK41tHRju+BIQ5hVcjF+wTWN6WLpVpBcI9WAd3jF+nLEHbBe9loUi6eDil8UY1VREore7MxouN0VktIVZT2s13qshzR2P1gj2RwqJ4VnPXtYusU0F28XVoYxiWDUSnAu9vlVRRTyKRiKE5A32j2xOBslQyvkilNRu/dMXpcJl3fmYVHauQ+kctI/dAaz2bVomFHEdDw+ApkRRPvvAunTOcV3LwPe5+52kK1LjMWbylDVGPVzDgF83f53EprP8UeFqmaeifXIwlc0icc12imCrYBxCA9Zf9pWsKPJfdDwBfu9KteHMfGo72WcY3NIp796hN2s+qAx/ji6Lj7CKJS53ROISm7CZJ6JgkOPOlT3yG5Qi0hOhI2ZSy1mbmZgsN7g7S+QeTcQiNdBcplHR+Sm06PnB5V0LZEeYATjzDVglD336n0wl43bYQWNK6d2pAAhS1ZrHECfoXZUD4Cw4xBj+uwntFKxq9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2h3SXB3dkZOSUJVbTdJaHM4a28veEtrK2lHaUhNZ3VneGJ6WkZnYWtVYnpz?=
 =?utf-8?B?N3oxeCtyc3AxRlpFZ2paZjVEazdhV0JWc0dHREszeTBWTXRQS3BVUURUNHlr?=
 =?utf-8?B?Z2R2emRyTHo0eWFQa1NPYVBlTWIvK0EvMjh0dlNpaTJYUVN5VnhMRkNwT0Nn?=
 =?utf-8?B?ZVJOR0lMd1ZHOWV1eVErWFpUVnZoVGNGV1lqZUg5MEd2NTc3NE12M3dpdms0?=
 =?utf-8?B?MHA2QnZ5T1VwcEJFK1duTGhyU0NKUHFHMEZjWU0zcnkvQTJIZVd0ekdMTXN0?=
 =?utf-8?B?MmlPaDByU25Kb3NHaFhKVEwyQVZkQy91bm9XaWRuWkVXK2ViZkkrazZrOXpK?=
 =?utf-8?B?M3ZQTUl1dXZaTEV6WXdhNEVmMFltS2dXY25MenpvejJIWkIvV2ZwVlBXSjhC?=
 =?utf-8?B?WS9iTVRUNWFwejU3dEUzdS80d2kzaEhpTW93OHZBci83cDhrVkRhVDJXL3Bz?=
 =?utf-8?B?V0RtY2YxUjloK1laTGFVYXFGRjhzdGtoTENsTkVDVlJFejl3SFBFSVY0SFcv?=
 =?utf-8?B?eGF0YU16MC9qSndHVGJoWlA4c01YRklwZ280RXUzdFRST3Z2TE5SVXRwbXBO?=
 =?utf-8?B?TzFsOXVveGRIeDhGNDdhMldPRldnMyt0cXBRMnkwYVhtcVpNblBnTTJraS9U?=
 =?utf-8?B?MnhpYkhqbk9yWjNhUFZKNGZGZDdETWRaNUFaUXN1UHNIeU9UL2gxbGNCb0hS?=
 =?utf-8?B?L3VOVmFJNktXWUdvL1Fmd2h4QW5BMHI4bUo4bHliTlNYSzZkZjJjbEloeXM2?=
 =?utf-8?B?NmZUanRDUU1PWk1SLzNuNUpRVEFiTTZZWXZBdkFseC81UVhjb055TnlDaXVj?=
 =?utf-8?B?bXhURHZmK3IvU3RKcFdBNitTLytjUWtVTldGSVNMbVdxbHQzVlorbFVJRkR6?=
 =?utf-8?B?U2I4Y0lMbUZYZUtaRHpKOE1GZGlaTlJSd0I4ZlR4di9CT1FJRXN6cGhkd0wx?=
 =?utf-8?B?a3c5dno2TnIzMGNpaGU4bTZkU1FJU1hsWEZSL0FpSkI3a0lmRE55djB6SjJo?=
 =?utf-8?B?bldlVFBac3EzRVlKNEdWd1Jhb2ZJSFVWWE5ZaGl3dnJ2ajBib1F1UFh4UDBu?=
 =?utf-8?B?SHFpTjE5UndUbXdBVHdHTEQvOVRISjc4clZGNEg4UmRQb0ZYQllONWJoNkE1?=
 =?utf-8?B?SG9CakJkSytiOFRqR2xyVW9yZnB3Q05XcnVkZlozNytrbDRoMDgyRE9MbmFY?=
 =?utf-8?B?S1JHZlZNQzFGaG9TWFVUV1ZVL0hTbEZvY1lZMmpaWGhBOHR5cXAweWs4RCtD?=
 =?utf-8?B?Mjd6QlRwSUFVZnVWZnpPOGdQL1ZlWTlrR0dnK3RzdE9VRzNhU1lnRzVUVk5m?=
 =?utf-8?B?bGxoVU53TTZaSkE2UkVxTGlKWFpnTG5jNDJxSjBsTGpvcXRWb1AzVDNUc2Jn?=
 =?utf-8?B?djNtaWxCWUZPeXo5bS9YOXpzeTI5YmNWZ0ZvdktjbVg1RkxBdC81dlBHbUlv?=
 =?utf-8?B?YXk1ZHdCQmx3S3p6akliaENlcG1XcmRKRVZReVVScW95QUVCNXA4aWhCTVNO?=
 =?utf-8?B?SGp5MzVhMjhEOEhuVnVkVWlOVERpU2FOWkNrQW92VDJpb0FTS1pmNVZPYUQx?=
 =?utf-8?B?NmoweCtkcWtUb0RaY3NiaVhJZytod1lqSnZBNW8rNEJLcW5yZjZsdHVSRUtx?=
 =?utf-8?B?ZVJBM2xrN2hTRmd0ZUVwQnE1QXlDWUU2bXJDWjFndFJxUWJvVjJzdFE0Yk1P?=
 =?utf-8?B?RVNVSGlsbUR1QnVZcWZUT0sxdUpEcXdud1RCVTJxWFE2ZkZ3T2xCTExqQXhO?=
 =?utf-8?B?V1VJZVJIWm1qdHpkN0NRUlU0WXhXaENpUjJUZENjQ1gzRGxjSEYxZ2RzdXdF?=
 =?utf-8?B?WHpBSXNKVUt5aGRjUGdkQXJLVnRJSUdPRVFaekZJWG9DS2pYQVBCak9xV0ph?=
 =?utf-8?B?empXZ0lNaGpSbzNZVm1zN0RWdWx3VWxrTjI2ZUtFNTF6QnlVbUx0VncrVy9j?=
 =?utf-8?B?d1Ywb3dZSFRkSzkxYTh6MTUySWdJbit6OWltQ0FCQ3VuQ2taZ3hwYXBUTy9j?=
 =?utf-8?B?SHVDcDVVNTJSY0FnQTIzYzY0eHF3Wng5NUZVdDFXcjEybHVRSjJ5L29sSHdS?=
 =?utf-8?B?QlA4SC9DRFJyeld4Wk1rSk0rdG42ZHdlWS9iOFhrVzBOdThPOUxlMXYvS28r?=
 =?utf-8?B?TDNndno5OE1tWmFQRkhzSHpMVDVXandDWmg0TDVCTWxaMDRCZlFXQ29GUVF0?=
 =?utf-8?B?ZXRqWFJuUTZXVlJ2d3lqUXNoZTRXY1hqa2ZDY29IVnk0bEVPZnBOSnQwdzc2?=
 =?utf-8?B?QVlMTkl0dGd2Wm1KbTdIb3JoZW84ZnJCUzhyZFRHMU90cW15amRSZ1lLdFRz?=
 =?utf-8?Q?wESv2jspOwF/KZMfep?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f13c91d-a2cf-4fb7-1b72-08df2b17f4e6
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:56:40.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssMRLbuOFj2Rsu/i10Y30Un+tsuzpbx2iQZq3dwjC3rwDSUAg2HGrJqc/QZA9JSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433

On 10/15/2026 4:08 PM, netdev-bot+sinfo@kernel.org wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Ok:

- This was discovered by a Sashiko review for v1 of a different patchset;
we evaluated the discovery internally and it looked like something that
should be fixed.

- It's theoretical by finding, but...

- I tested it on an actual DSC3 "Pollara" with a hacked driver and test kernel
to cause both issues:
  - Had PORT_INIT fail during PCI reset recovery and saw that the port_info
buffer was freed while the netdev was still registered, meaning that the netdev
ethtool ops could get a NULL pointer for port_info
  - Made probe fail on purpose at ionic_setup_one() to verify that port_info
memory and DMA allocation was being leaked

  and then checked that the patched one did not have these issues.

- Eric
