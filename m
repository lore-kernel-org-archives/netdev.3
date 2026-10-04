Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067B413789
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100088; cv=fail; b=di3he6yNLEVqQfZIi8WviHj4awuIQHWjXcahjIQtJ63wIYwAnsG/m9y4D5zhqKd+hFjzqSzRMF6yASucVCo7Ew3Fp2bRMIKz5MsUb/5tccQ0jzkKghDKrJSyckzNOd7zFpN5JBoHwa9509ceqV9i22zEhe2sX3H2+eprBZqZvZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100088; c=relaxed/simple;
	bh=5aAf4KOOCsoYUqqZBqHH9Z0PzkbbvNpzUG5JKawrLV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SgJikSs65kt3ITEW6s3zLfIpQLRKGsay1eGX/hByViYozn5XOgEGLVWBkjETEuHzoSw6kkyEZzuYerihGJTFZxVlJ95CpaMDFRWoE0Ov7kHjbRDCjU/jZIr69iuB6S8Q6TxusyCNxRVHQSjWq/qBa7I14Yq7UBlyaFMhmC4eYSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8Qy+ZuD; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8Qy+ZuD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqNAsn8F6meDA/oQYB88HG+pUew+iy5kfin4z6y7c8Zxd7Is9VDyFbyycWDAbdYfO9rPR+vPfgbMEkSw8i6r2yztH3+yizZxIOR2RL8krCWV9tAPSCzqZw6q5smUmIVUatoyk9JTjOSxka2RR4gMtAY1rYGIN3comiXkHJvrXn9LhyILAL4juk9qMtJvrj04gmagntZglzjvCuSqcWDX8UEY4rGElVuvuqsYd5RD/jAwfuCUKiDv9hulLY9qMDEQpBq+gflXZIznlHqNLf9YBnyZHmSRz4N08QPV1gqiU70VW4djIJpRTu9Wt2EyP5b3Z4Be0Yicnnz90F9CzNmPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duby2YOERUiDyoi0QPjdWBnaTRUo2yAGAmeXVpKtab4=;
 b=rHddAcs4MdnS4z2WQEySM4UGp4OZ7sfSufN8isx3Lhx96zOLWuFWS1TF30PixZUk5evSSE1Xbq0Gaw7u8Jj2eBrtDqLE0ltvo7lIsaKDFwHoCkED8Y5mcLYI9rbtdjF5aKzFFjELZSCxnzqQWO5uf+FWBoRonOMvdxoCNuyP/SeWT54B0wdcb07z+WvTZPM9/Clw/FEa+yiBdVdEGGjFJfcOuMJ+Ez16UxjKWxxQbjPHV1br2d6A5sMqWhzJ5srISr2hNH/WBIQ2F4AocUbbA8CeVaBGSL/yD3zvYafmXVK9oHZiknN6H2DunmInDExesw7cDpK+TtXnE1Lsyp227w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duby2YOERUiDyoi0QPjdWBnaTRUo2yAGAmeXVpKtab4=;
 b=P8Qy+ZuDh1+thCL6H+dcQim+0VBy99R3cERghQ78Woojo2KDUT+XAdHkbbuUkwO3NNowXMYySTXs24NXw4csM2Fnws6dJJxoo4w4xpcoCmeWeW80NI9LFtRXli4jg9eAyE1JYyoHr9exIVrkbenWZx8Ig8mGhRc2p57dgEPtIU6iwK9adDkQjJFdOsBJ20hiS20zSXTYYk03A2nVf5xGGoHwmjoHsecvSedISLPKxISK7zmkfzMtxIGtRrHMSoJzxdwMkURAb2chehieOhHqc37WY94zwpYQrRuyU4OE9J5egVs0ivrSfQbaNFKkj+HlX1FJG436OtEej1zeaMIHig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 07:48:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 07:48:02 +0000
Date: Sun, 4 Oct 2026 10:47:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>, Changyul Lee <lcy8047@gmail.com>
Subject: Re: [PATCH net] mlxsw: spectrum_router: destroy FIB hash table on
 bind failure
Message-ID: <20261004074754.GA89916@shredder>
References: <20261003.final104.6f67a6ed1c4476b7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003.final104.6f67a6ed1c4476b7@gmail.com>
X-ClientProxiedBy: FR4P281CA0325.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d150654-93a9-43ff-180e-08df21ebd18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aU9hAFZxliza/Iv/5VlwLjV/HHWQdBeETHYHCXrosx1/sJf0G6qP8v4HIz4IBq0MUFomhDNG84msIaNlN3pn2s4cH+OTa+OOwA/a0WUvUSGB7lBxp7RjhDndisjBb0cjDHNZmi5H4FiW/hKRXbs0V7RpVK4dJpyo35jGzlkyEPnxl1pe7gaXP8bc+0C9VqL/b7R6KXDBc6f0OuUR8iG+g3ZS+K0uvOTKegM/RslcULRTBhfRtzAZfvZKADJzgpgCHFovgm/r3qvWPMcfeWsiCjWFkhGHMp9BuyrMAokq3bgJ+bhfxGHv8E8NaBLnknEXxaOJNzIL6+fdboYxuwuzOSYcBTVYx/9oIYsypeDWiZlyjOfJQvT8I74PNl0yshET78XsuOuhtT7ErxU52uIJlvvwBFX9KqxU1tRUTt+GVe3nvjomS36vL4T1Q1JYmv3GA/Q//wyD6/+PD9sQ8IdNtVmlc+kSfxz21s9O6malKVBsLxirp00YKFZ/tcdUdX3HLOOwYh5S1gpdcI5/kafCpHTsXoCihne1j2roaVm3cJgokL8DWkP8zJt2Vrl5LJU/1kw9vcAPa/dBgau7qz5p5ycA7mEQ+qnL9S6NVeYjeXbbvcbQ/kAEDV2zQLu8elUPYNgSZkaZ2u4/i02pPcv7mYHg03Q+ZnGOSkAdcdwINUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BFF9hU1BKBs2b4DxZgbp4+FtsQb06qYHDYVHPmHk/4PNiYffQMlKIRr14sJ?=
 =?us-ascii?Q?ay0I7MRNu2kk96RDO9hvm7fWYICV8PlZ6xReQbmGe60O9X33jpc4f45rI5jG?=
 =?us-ascii?Q?R1sJX2z2ZlQmCcgVFUPEZfaofCtoDeGwNkkc3s/5vyMqO3m6Yp2B1VfGGd5g?=
 =?us-ascii?Q?5B7evjefhGjZNf19Led+OxTWsZXjPZta4YF4qKOqLmWDTSlg3kwT82byLPdm?=
 =?us-ascii?Q?Ssj9Fp0MYUu4TYD21crPGQf9vPUSVR8J6S6gZSEz9DWleyb2kYZHyEKStELn?=
 =?us-ascii?Q?0B2mZRkrtxeS/xkLshtoeuwYpU/JmcqmQ3KtDrBO7cS09COhxmDzLnxBMbXS?=
 =?us-ascii?Q?4xtiKoG3WOvkgtNz94eV3cwzTRJgbLESZW/lKEWPjm38NNh+EIj55wqRAmRO?=
 =?us-ascii?Q?dvs9JGFBx7gYXrf83AkyscfMEBOj3wKX0voEl/0ij1l/ZlHKIyY4AUypDqFu?=
 =?us-ascii?Q?eElsy6CAEw8Zd/No6DBLLeeKtSW7SOtnNZ6ZAi0++Xr+wDbsmKXMgVmn9TQw?=
 =?us-ascii?Q?Vjt9oEMtZDeC5rSM1+pL0ov+ka+DD9/mpleaN2wy/WWJyHpvdV0y6XaqlhHg?=
 =?us-ascii?Q?+O2nBi4HOu/tv/QHF/0vsiEcFS90rd6Pkx7jnOBE3yIwgonpTK+2xfvnTgA9?=
 =?us-ascii?Q?7VtAcFXXHuuIi7/DiueRpgdXpoFM+xk21RPQii8kNHs7N78lpm+8o9qqhlui?=
 =?us-ascii?Q?1d4G3rUHQ/Cr7S4Qial73XNJEf/uGQWoA83OkfkeuxK0HeDCwUgbPKMIREvC?=
 =?us-ascii?Q?F8ZTZ3wtC5SKmMrjFQruWIyrk7uQtirAwwvIqxkSfaWFOTCFNR6oK87pFElz?=
 =?us-ascii?Q?G8XuGfz6bKRxXeBXuF/0ovUnHI/nBxs0mFPBICO8lz1/93A6mt9SlF9OSTsG?=
 =?us-ascii?Q?myAABEeJAaAjvj1dtBnykii1AnrhznnnPykdklLE0bPssI6eW8h6jYIt8Z0v?=
 =?us-ascii?Q?2mWLFWW6VHxl7HqDkRKMw8tGsdKXcaAdAhE2TQtcORO6jHc7MfzKmYydFiz8?=
 =?us-ascii?Q?gxe5C1GhKEU4ncsCzUCkjvvVw7lsB1U3EQx38+NFR+exyNUkhMUTqjWTxwLQ?=
 =?us-ascii?Q?MwH/O8QQWdsGiwSeUExgRMsLCOyLNMXbnONqKNAKbTKZ8ER7nZHmb+XioxXi?=
 =?us-ascii?Q?BPC7rzWvO70HcPx3KHKtDavv8hDH6rriiFAMSbgAweENq1oiPp23Z8KvCW2A?=
 =?us-ascii?Q?wzrI4j5OQ6byPn3lwZtSS06zB/qqZiEYoPOXb7elK1xrjeOl4ie7NJXYeYqu?=
 =?us-ascii?Q?9+Mp7ohHooMOVivxY7WZ0tWuF2+RVvHO8DQXAeiXfpAQu6QPF2FAafFz+ZBE?=
 =?us-ascii?Q?WvEpiVgVgVAzEvJKwl8r/GcXzLhAd8JeKQ/tr911camFILkTSxUrlEjM7yEA?=
 =?us-ascii?Q?u5z26S01pl/Px/eziWY1IVfFAk1AHkaHKu0v4xOBx5IWvbpE9cICO1fl50HR?=
 =?us-ascii?Q?7BBNjwcYcd+em1WtDacV3PSMggzECvioMS09U7FFIeju1Nexr6M3hOp/BEo9?=
 =?us-ascii?Q?pGGEWRoneSZBjUsvW9wxoWfpIsuuGPS3p72hczOCP5uW8KrVg9lRvhaAw/+q?=
 =?us-ascii?Q?iYvhis4M2gJTf3pYPeJQn+UpvL1/68Fm6E3vEGDpDkj3wlLggR2TBxvkmdn/?=
 =?us-ascii?Q?0IQJTHokenraVHrkJPkd9uEF7vbyfAdFIGp2JEp41cO7Yyf7MUzz3Ycxo1hM?=
 =?us-ascii?Q?CpXUd3B29u6QxGNwBRyPhDWgKbAE69dp74QGwDo9aO9jRIzE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d150654-93a9-43ff-180e-08df21ebd18d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:48:02.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2zA8v5c529VyzjrxF485fkzS2VZ8B9nE92jt1BXDcdttFJdZtmsl3cDUNZzJtpJXYtK4zHwdAXtwIifApQSfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

On Fri, Oct 02, 2026 at 07:47:40PM +0000, Sang-Hoon Choi wrote:
> mlxsw_sp_fib_create() initializes fib->ht before binding the LPM tree.
> If the bind fails, the error path releases the tree and frees fib without
> destroying the initialized hash table, leaking its bucket allocation.
> 
> Destroy fib->ht on the post-initialization failure path.
> 
> Fixes: 2b52ce02e1d1 ("mlxsw: spectrum_router: Remove unnecessary prefix lengths from LPM tree")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
