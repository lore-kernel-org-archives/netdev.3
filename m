Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA727E049
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920856; cv=fail; b=fvu+UgFDej8o49piow4EGI06wInwqF9Po9IG57m5e19xorzUp/0e4fCdWvsBFJu0f9eLbXRQCKgje0hY+ugQrIsamwMKskfv6o/dpf6yM0BLKQo0Ll7L6i/V3djAght9faQapLOYu7jgl1yga5x914irtw1Jiru1TfeDvjTzJjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920856; c=relaxed/simple;
	bh=fe3Jqboqs2KOiLIDmntjZVAT/55F9bew/yISgzl8s7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OSQg+EmRRz6wYUEfj5d7wTUXeAs7YnFgbZltDV1d2UdJdrvuwQZNev/sB46GBVx/6kxE3LUOaoWeNBFnihqlijhdNfuttX1Pqcma/VS1Lw1BotnivcVLwxz4qJoALvo12AVqW3E0nXUJb02wqBRPhtQhSuSUKX1zeIwopaVqsZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tlrlPVOH; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tlrlPVOH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvAW+hV0BERe7Ry71FihO94bMCyNa97gWvTiD/EC4E8mrNbdW8FPcIv3JEwL8Tr/a66DvY/zaWExRcsBqwZRCd12tl4DgNBlBmSBz7NjDAtOArqtwGe15jI3WtWCUD+7S471rPJVe7eum9uPg+DBzJNJA0lYFuOHSHVZVWdvwavLd2qfrcecAFt6tS2I5tvD4SIItp2y75hQry/ixwvAVpCe6oWO66NbBYu3rB4jIoe1jIV+5yEGdVoDesBJ8zoqAs3737v2e3dizgiF9/l1upwdtunHP4bA1Ri8g9nM2ISLQ9uzL9xpaTLrsFv/yEvT4v1/kXVyS3Tl0NKrTojbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cGk3yVuq4aOSWSYXwH6c0qs90rZNWUO25NTFH+lu5I=;
 b=myFuL6EwgdSVfGmKtwr78Iwxgwoj/EMChOXGXL7KSFmVp2WJDwFpVHaY/I5279QFBG7c2DOWRvuWGcvjANLx7hMgY0JA4Nkac3XgXclO9qpQDRUffKxIdKHD5cRW2KP3SBWavvJ5/JzCQoPz2pf/LduVFgtHc6Ur+OQTrsLMmvVoxv+vGfWMRkqVxP+Nbw3xNBTZdcMrPCcKK8J1q/kq3MZcX3j5WECJm4gEtNbaAJjG7V9sZ6XiCiSaLgVIe8cIEGCMWhhOhggBs/xKJ40NYRssLAxcoMBuo27U8wJEN4NGKGSvYgsEp+QHsuxxafJRn0DNW7/LOShTJIUu4PtJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cGk3yVuq4aOSWSYXwH6c0qs90rZNWUO25NTFH+lu5I=;
 b=tlrlPVOHFNOhSB+Kn2Y5mQxHcfxMISA+7zYkn36fW76YHPrHu49TCKzs2a6sdHxp8XiNHCriEzoyqDd2YUTE4W/j+pNCpJZGDqxxfEyy6clejLS+WAkigNK09LSP5qH7DrbzYZcbHfMMK4nX0TSQq2pFlsprpSX3TbtXnL0y+zoZz4vbVUaH5ovW+8a9OLKDJGmbDX+kXtMbEcNHHk/0LWGaUPRWUZz4KBRXLs39MJAqOgwsezS4G3oRARYCHHb6tg++tJQKLdKUpSHE8asGk5e4MgQh5bKoh7IiJhAbJbXj1mzepn9mhTaz1eKL80dglSj2/B1PQHdD3VUR/f/6LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 09:07:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 09:07:30 +0000
Date: Wed, 5 Aug 2026 12:07:21 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tom@herbertland.com, vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
Message-ID: <20260805090721.GA1364862@shredder>
References: <cover.1785734738.git.zhilinz@nebusec.ai>
 <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: db4e92e6-5967-4b65-0eb0-08def2d0fa80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|10067099003|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KH3cCVEl/j6dOGJXmF3wSBc+Rr/KylDbsPEgLm+6d+U8MtziFnWoB2TGmWZOSXb+uQnwD53yk63eNG3B2cluP4vXit49Y+X+bAxYLccmqpjlE0hy/vxAujs7S4B0c4j5vDPpHhN1VU/1ZiZ7jGuk6V/JKsRS3Ucu3w06AwJMRKH4FHmGMZzv/dQ0UIyWWAVGeOKzLFXyR5D+gLcxAQEtGLp1bFKdFI9ZxYWe2CPI9B3dHK4mfADdFmFy3B+4IyGU1kGgSTvnWd+WdRoXHWe+ClBRB9ITYovH1lsQD3xEaiyu1A+hjcgtJVJs+JiaLL8WfdnA9CjI7BTdp0E63a1c/YRJYW8pS2tNSYoZpmx5s7SBKuUtjBPg2twoj3XUyGu11FXoNcDBTZF+vwRHpzSLtexlWGmDmvqdQGnRZ7xhABjEjAWZjfp8SkPjjir+W4VKAzDAkwY3DAYNnnOmVHBOuMhcbtYDZf2l5LUEOZfnFcxJfz0AH+b1DKvbmEWc0t7QUmZ/xE77BjxdficMOphTMCGjvQKfk/ucTSLHJfu29YstErCWhVuElXWFmfDprBybashoFaFqh4fEmIp4DbGMVz2hHqTiDw85Gd3iuFgMEf8frojC0cSMXzgA8VZruosSjjFMmr6RqJwSHPNfjoT9ActZrnHhdSlBCbrfurOLcXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBukZh48TyHrct0SNl2zutJ8PAM4Dpsf6i4/ynYxS9QeEYeUTGE5MDXYzwuY?=
 =?us-ascii?Q?/Gx0qUIStgZb4y1UmiymTPtPINsy2ICGygofdfVQ1VzJYOrR5qtWC9CKgO9d?=
 =?us-ascii?Q?0LCyXPxn9j6q0H3k+ho65u298YQW8RFH8i77S2eJtav4eEK6YwUe5FAown1P?=
 =?us-ascii?Q?SJQcRcGB5gP/OHH5+bQfU0T35k6EqK+51F7OL4u5V69vPBLnlCWIFVl9OTNW?=
 =?us-ascii?Q?KM+WNeokKY298zkVFE7YwWdsRmq8qK43ZbwTxOAjQCtGkGwLSE5iZDI+CO0P?=
 =?us-ascii?Q?UDLgxbvUU3ECv7mvJ5I3XFIAfJaEo//y8o3id0hcO6OD7tXioyB3ehGW62xG?=
 =?us-ascii?Q?fhhEyqBSMiQx1NlFG4CwF9hgv5ZFOy8uZgckPwqgNU3QyLL/s3NhJCM6dFA7?=
 =?us-ascii?Q?1S2cLUMjecY/A9SYm9M1OkVgLJ3Trxh8HYVC4+IerQszNd8xSEu0GpZoxsvF?=
 =?us-ascii?Q?HC2RXdxWh9VrN5ZLkwvaaVGj9t8IS+V7GoU1Q0DjFW/aUMDP+zdpvgIZ88I+?=
 =?us-ascii?Q?YMVR3jJcn2LgALIhKgSMwjxctTBZ9gK4HxqMAER+ssxd9F51hWLinJytMG8F?=
 =?us-ascii?Q?ek9XQbixh8a6JfzGW3E2n8o5XyX8/VpgD+pMC5HU/ssY5rfDj2uN7OKj5cSa?=
 =?us-ascii?Q?NOm6gsWJoaojqQvhwJyvV4p1E3MJ9blt/5g3IFNHqL8s7L40E9//e5AbOadA?=
 =?us-ascii?Q?+PbKXJkSjxPmiCj0vLm733woXXp5eE992Yobfab4VbeVu/drjE15veN8ALDa?=
 =?us-ascii?Q?qRjlWum+pXuTh2UQoCWQK0Zdy7hGQe23yqaJPSa/o12aQpcKFT7GmT8Tyi5m?=
 =?us-ascii?Q?R7GXdgrIziUEpa8BCKgctuX6q4lF75LyLFq5OfOeN0vb3WjL2oTqKvYIEeFw?=
 =?us-ascii?Q?YDqtBB5RyFCuU1YFBAjfTl9OjERjYAUxZHeyhp/Yfe6vdRiGbfV7+WMQYi7e?=
 =?us-ascii?Q?KaszXev/k54CCavAtEFxYUIFMTOH371SW0aYzag5ajXsANn8BjZGzTpQBrOt?=
 =?us-ascii?Q?nOnhj9yL/niDlkxDHI12kuDAN7y1got5SJCUHcI9iP+ktG35T7ZRJwPACnir?=
 =?us-ascii?Q?lulIlowV4N2DHbCxOKc8G2fFwoVszaAiQTnBGDfUw7BpidW2xL6vmiZ9dM41?=
 =?us-ascii?Q?541NvLFi8r+Oczs4pne/ryVL0ASn1uegKksR/ntYlEMWIeAewyMzjNNBfxzs?=
 =?us-ascii?Q?efr3XidI07OPPvHjYsi8HoJkU6j/E6ecwNJ7HChRlO6Xxfb2MFq1puShGcrs?=
 =?us-ascii?Q?Rgo2d+u4r+y3u0gH8+U84rRz6jpMwJm1QlMETsiMeuRFUxh1juLCzeFKLU8l?=
 =?us-ascii?Q?9D+8zRmTVM/FhhGdQx/2uXMdZVpeDisRSlUUD74EZ7Sp6vdzOLO2UF3diFkH?=
 =?us-ascii?Q?X+XGED3jW2vE+jur1G5i6oXhi5SJ1/2xCj90z96/Q/+xur7AlCf/0zDen6Zm?=
 =?us-ascii?Q?SxGntYhs/06uMqgi6GjlrVVoJnJhqBZwMeKQa7jtf9k2qEnIFfi5IKVAulBr?=
 =?us-ascii?Q?pN+B0bl6qMv2FLZtEtoEQfxQk6KXThZu+bN57ZTjsIWP79c8jNIPggfpLL3b?=
 =?us-ascii?Q?jMjnF0I9a0haIK/K2MX/FGAjIWeeDWJkFNlvftTYmZc7dNPCCHWnQemCdMmc?=
 =?us-ascii?Q?coNbuSsX3rEywk+EHZomZGyjNZaMuoo9fliIqnP+I8OaflmS4c10xr3QE4Pp?=
 =?us-ascii?Q?IoFsUS9Wu3qceHFVN/2EvAum2ZGR/49bwN0IA0S/ARh5kRJsR6Eukm6nlKzK?=
 =?us-ascii?Q?IePNLzMlVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4e92e6-5967-4b65-0eb0-08def2d0fa80
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:07:30.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdTHIgxRRotKzpzWScXsGOmmPJMT4Ii+jH+rYsfhvdhUMdz1O2h7pO22kUARU+G5E7OpbLCvrTVdFH7KFrHvgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On Mon, Aug 03, 2026 at 01:34:46PM +0800, Zhiling Zou wrote:
> ip6_tnl_xmit() may need to expand headroom before it can push the
> outer IPv6 and optional encap headers. It currently does that with
> skb_realloc_headroom(), copies skb->sk ownership, consumes the original
> skb, and then continues processing with the replacement skb kept only in
> its local variable.
> 
> That is safe only if the helper cannot fail afterwards. But this helper
> still has post-reallocation error exits. collect_md tunnels reject
> non-NONE encap after the replacement, and ip6_tnl_encap() can also fail
> later. In those cases the helper returns an error to its callers while
> the caller still only has the original skb pointer.
> 
> Both ip6_tnl_start_xmit() and the IPv6 GRE paths free the caller skb on
> error, so they can end up freeing an skb that ip6_tnl_xmit() already
> consumed.
> 
> Use skb_cow_head() instead. It provides the required headroom and
> writability without privately replacing the caller-owned skb, so later
> error returns cannot leave callers with a stale pointer.
> 
> Fixes: 058214a4d1df ("ip6_tun: Add infrastructure for doing encapsulation")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

I read the feedback from Sashiko [1], but nothing there seems actionable
other than adding a note to the commit message about the removal of the
skb_shared() handling, but I think we can live without it.

__gre6_xmit() and ip6erspan_tunnel_xmit() already call skb_cow_head()
before calling ip6_tnl_xmit().

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz%40nebusec.ai
