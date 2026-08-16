Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D64182D6
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786884253; cv=fail; b=HfUozvv4vI7+oUye6+u4Ca1u3vsayecJoXdIlJ2BPFgPq9q0nSNtz72Ld7W4+8v1Gmh92zWAYSeJawi2/ssgGw4UkShtszNjXz8XT86vNm7Up4jSzsLjtyTjYRX1v3rbLitGJ//LNbzFx7luwK7FAc4wMoQCmVHS+ROyQ+tMltY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786884253; c=relaxed/simple;
	bh=CMDxtBwIQmbDtc0ZtfjrmqTxyeKdWtLZcRF/jebgIJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YfiBTN502VogXoVXK50LHcwJ4CVCJXkTUJQ0StAqRSHq5+VpGpLQP79c9WI0aXJdBnyUAzwURWyEyN3gEicEgZNMD6AvmKoHT5qzdH9JZsRoRjzKA1I1MDvluOVwJdyVHFsZ099nsocOyAsWTz8c8FWAVMaVqQop0ipslERxloE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oU38Cl49; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oU38Cl49"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWkxJsPb0rI/xBMnJ2cRzJitS+PzT+9o7ph0Rn9gbEb9zQjL1UXinmgKNiHPkhdHolIH07dUXzgqxDHrW68/KkzuSHih98uZXZCGg+VisN1fIkp7Zj12BOthhHYaFE7XjnEiFNgRhfMdS+9W1XkDcrSEKzNWp/6zW0llrgJJdkssMTcbnfab7XJBs+G5FKRcdvEha6V1rF1iMibA0T+GUojpRK5EYkw2UcTSwAG0yNXtqSZZuRJgbli8pQX/B47qLT/+yIldx9VCjaDsSfzsO0hzmJA6KwM7I83Zvh3yl1Jf39pvhdOLwP52ReqdJ1bhYRLoqTgUrleqYo8DaVgNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emKI0RDN+jhATYUwygbvwkI/F+XYRJ7qrmIuVbGfQjk=;
 b=OAO9lRtSOk0G/pW+zAn3zVc+j3dYWM5rVK9QpjZ+FmdafOJsP3Gs3j1eKrGPGESh6zzVObaXsVW8NkXntSZ6EJ21R7G8i/h2SpIrYfNs3OL9WesSd5gRBLwrDu47TmMg2bVualC9JaQowNfASZfouwuBKnlWx4iJjTv0bfU4vN/fkXmME82FdHd7qWW9ZIAxBdQf9mJ3J8GZHsp0DjjYz/ysJLjZxH2sXgSxoWCMzXjlR51dx+w3kU7DwzzQZDydG1RDfJfeVnDigoqZzAHN6RhtbjSKqhEK9vlOzdUJvr3328slCpcTGFqCTxQv9z31eqdvJuuU5tgUnx+zAyPMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emKI0RDN+jhATYUwygbvwkI/F+XYRJ7qrmIuVbGfQjk=;
 b=oU38Cl4970eWajScmOZoDQnQ1vS0ZTH0d4eev0MeQ5ixm2QX7XebTTbKsqmJPE/9187mnnPJkJ2ecBkKK51/bhYqDCiaSAc7SEFpFyo5qY5fEQBfdXm5D7K7EyGJ35ejnnVfo2rLDoEV6MnHTG9b04JUvZDEj77DPpBIsNr57qMWedDYmhRhNhg6d/n8hc455B1mUQigJP2nL0Soc8w5opFIBt2Uptk/NiYo/gPuAXVY02rbijUE4NBIxkVX6w6qQBjSCknce7x1KgWBbCljtYLUOosCUEq7aeNOQJKWhlMigsaK3DQmdb93F46NPI9eRfMsuaf703SMcDdP4w2rxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:44:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:44:08 +0000
Date: Sun, 16 Aug 2026 15:43:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Michael Blunt <michaelbblunt@gmail.com>
Subject: Re: [PATCH v2 net] inetpeer: randomize RB-tree node comparison using
 SipHash
Message-ID: <20260816124359.GA62850@shredder>
References: <20260814060616.2164504-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814060616.2164504-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e580cb0-5e48-4ebb-44e6-08defb94103e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x5pDXzsf+NvltAGI2CwmAknCCYW9mwXcC9V2unqWWSBNc9Dn20U4k4OUyKpc9t1qG79hBURiGrzFWDoHs+zJOfg+YobGziZK3iynR2Q/iflWHaO3iycUXlKJio31Ax1sT49KP9I8VnHU+ci5QeXMFUvNK5MGVC1slgjWVAsK9jhVh6QW1qt2RHsotjEcXERghGleZRkwY2lauEoF5REcccbStgkGvY3zT1auqPCgRi8F8uRyY8+OwYtMaO3gbWIBWlhvOHa1eZAd1EiGN9XUSJo6I/RApnlAlPCMY4VQmzn7D5e46KfrM+rU7yf8nF6WJr8xwqzGyDknM+NhyfmFhSgtkMdjikVZZX2fcnM49/TrzKPEK7PlnPAqFJVpnwcewA7lsU4gO8ufb6xm0ahDjkOGJjGnxFFDmaGXxIco5CdlsneieXLUjgszlAik+OVZdQ7tZ7oUqFNdLG1Mmh6yFu6VRXbt5mlRzZh6ycHO1IyWWonA2UoOZ/FqAF2UsNmaZ4tatlwXBFYKb8jjbczWhUGHEcQUoMDDtf7VfttBb7bsTmDg9PjRQDCOr8qcfJDw6s7x70iU96wnWR4sQtybH6px2ssK62y9YhXpwoKNsxQu/zqGcSOqg+FRgNvtiMcfVOn6NGVCFrojm5ZodnaTbB+EUWwo7ZnBLOY2ATy+G3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j5FqGqFn9tImXHfEN/NsUn4HqxEsCRLEX9synHPxAlQaoXCLOu3tG/6gD6V6?=
 =?us-ascii?Q?rfyyFt7BnQF8nQfdB3rrw4ieluYGLXl4hiSUZxj+c6usZQ/3fjQ1+HX+Kmwr?=
 =?us-ascii?Q?Uqd58ydo/EujVN9CK1k5zK3ERm8hi5YwiYHbrV4W8DvRA5BjdSTebH8mNPzt?=
 =?us-ascii?Q?RJvF+6/MToQ20/VSAUDlElQRojsedl8pMfVt0Aiju+A5AoJW5LG3XB2IE3gc?=
 =?us-ascii?Q?VijyOaL7ETuVCtFNJ0MLC9ek6kh0byK3SIZhTCHHppFW5++SB/TERMa0nwQI?=
 =?us-ascii?Q?e8Z/B1/vvAyODsqBF88eOY7RJW2s8UHaOlUeBx2ddG0DFhwTPwcJR/Qxo3Pz?=
 =?us-ascii?Q?WK1INgsCH/k/84qBhVBPEseMe1s4G/e4FOchZ7IAfhgtVSbG4RAmTHHQxDda?=
 =?us-ascii?Q?EJTdznHcJI+r09cMyQB8odyK6/ycBQNRglf/M3m7J825bc3lE2l34sgsRX3G?=
 =?us-ascii?Q?xCJJ+0lcQUFD4/JZ3Mz5R9YesJX1yFnoTdw7AZS5ThU2xbZ1SV8lFkiIfrP2?=
 =?us-ascii?Q?VZcA6fwfyL5YTVRCHg4IJgen+s1fLMG/zyOp6m3VgYE1rN6eS6rthQRugr7P?=
 =?us-ascii?Q?LBU1m6wnXsCPko//mUnceOq4W78RoqLuNvvyV939xoeei5Ic2xTcvEhOSAtV?=
 =?us-ascii?Q?9Ys77jHkQlthkfUZtp1xQxHbVSWp6JuGPlw7A2/d/AUtEilLzbLfCAG5Gqyt?=
 =?us-ascii?Q?GwiKwTlzeeiMgdL9XBeb8xOZGWR4p1jw6v9BYqXNK8MdGI1WidYpTMpoWDLr?=
 =?us-ascii?Q?S1OOMWftcHpO4l4v0dNBzlrW0ZApII81wYjFTf5No9cN+iA+Gbh9lA69acqi?=
 =?us-ascii?Q?oPnPUAhQ0EuVTlHo+6O6zqhLTj/xkvH9GVmI3UFzSwL2hR5FrquObPDfntHt?=
 =?us-ascii?Q?pIUHvOoBSBAOYeeeYIABPb9QcbclpSxAqFJU6jPNzYWjdHARsfNRUVTyfD7I?=
 =?us-ascii?Q?ABDZNF9KDXw2kSZ/igYdoS6eJeH6DuAliZbgjV1OJKNL7eNG09SeU0SnUxCq?=
 =?us-ascii?Q?6eoswBIRIwpulIn4KYf8b5Kk7yo+WnwKFKD4OASyj655DAj1BhixPzogfnGW?=
 =?us-ascii?Q?2iFkFfgzshYjb7P4KAQeVZ2EHiSoT7vOFedfOqhP5uC2r4pQKohG1Padnk5d?=
 =?us-ascii?Q?ppcwJbwxiVZ5xK/aThLSYMG8wsDswLmtB0YpLbQcGPeWirjMDtUgMtD07FH0?=
 =?us-ascii?Q?iLfQ51D2tXy2F7RGI/ehlzEj65bgDAKKmTWK7HNGfDAcPpJoookM6VmxM6gG?=
 =?us-ascii?Q?2PAUhsewGVshZXksVUW8TwjtE5k3y2sILMKtI5xS6rmBKfZLHckatOmP2EmJ?=
 =?us-ascii?Q?oCfjQPaZDktuXO37vMpnk6qT1Zq8YY9LwucftUCfdV9AmennG9AaLlQyJtPS?=
 =?us-ascii?Q?7xK5AHq+2cdN05TdPxKjjZgn8atEv/Q+f1d2isBVBmKusPvj2ygJfp0D0tit?=
 =?us-ascii?Q?zLbAj3Q44f691mJdMNPbTVAoBfnOb+dVq4sXBDG67L0bbsNInnipdGWVUhuH?=
 =?us-ascii?Q?U8larprC4skoCrCvwH9MPimfyOQ03hRhpdonodxyY+RnUh61ZEFMyf762Qxt?=
 =?us-ascii?Q?wG7DRFAjHWw/ZSmIxWWXMkR6dUG9Z6Vcbme2S3IPb4vCLfCgS+ekeLXoQbji?=
 =?us-ascii?Q?lwOmtImvpWDOdsS5y0mVL0lHDiilu4tRooKydpFIg6e9sYPr62zVOMlwBc25?=
 =?us-ascii?Q?MG7x16dLyDLTIhzJzG1zENUO4Wp/atFNdTnSw5u2nhwte1lY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e580cb0-5e48-4ebb-44e6-08defb94103e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:44:08.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZJyt330Ur7JHsi/eABSKA/9fSCeau0LX3C6i1NEE2F6bnDugJoKKNqS3RtNui+WgP7RLoNDHs1jM9YfXNcwsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208

On Fri, Aug 14, 2026 at 06:06:16AM +0000, Eric Dumazet wrote:
> @@ -190,12 +221,13 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
>  	write_seqlock_bh(&base->lock);
>  
>  	gc_cnt = 0;
> -	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
> +	p = lookup(daddr, dhash, base, seq, gc_stack, &gc_cnt, &parent, &pp);
>  	if (!p) {
>  		if ((u64)base->total < 2ULL * READ_ONCE(inet_peer_threshold))
>  			p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);

Eric, this is a leftover from v1, so the patch doesn't apply :/

>  		if (p) {
>  			p->daddr = *daddr;
> +			p->hash = dhash;
>  			p->dtime = (__u32)jiffies;
>  			refcount_set(&p->refcnt, 1);
>  			atomic_set(&p->rid, 0);
