Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8F3B47F5
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661800; cv=fail; b=eqe9Hl1UlnZMSEjBsAjFuy8bldY4m2CEsy+UmLPlzVuB/DEmRJvHleaJhndLDsnLIoxVToK7BYzuMTCtSDpfikckAdJQ83OLPsT5F5Vf3+utO37nsQkXmHFWWpfYU3FaE/84NDkwNvBesqUQyIT6ADhTYSIkWDgeljV9G1YW3uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661800; c=relaxed/simple;
	bh=R4AMCRoMhpn4bSci6Ek21E3/Wriyo2YK5FFxVNfMzBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BO4C+UxVosMW2DDmktT3lLKm1JFDKnS6y8FlojjTW3p+W/2hA4oopB2tGaB3D7mlbBlxvM1p7+CpJA9ENV1XxJSuGyz9Dxdme1W1MQGrvPE2hmihyryvtYRW0zt8mdNxzwzj0puf9KYHewK5Ekbszf/QHEoiv4kPTdXfE9ZhccI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oiTG8h6t; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oiTG8h6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPw+Jj0fawDSkJVG9MHHHmQDEaY4obSm3Z7OZ6XsuBpzLklzE8DruDs4TNogHxFcFeN7s7R9JH+4Lmuj3dhrx/6BYpqz9fluh4kH3hbzAqhMbw1Kk+TpBbyuTB50Z/LlDYrSXr6eqo5BGLtYZOVq9JOBpIc4gH4JUfgUj7N7Bj38IcNp+XQiHJlJr/vu1gyk/dUXrfBAj4usctKj/xQ4+ntEUYWU/5hoXXewjwBWdJnPZq2lVMH8aTDCXIOgzHDyBZT5XkbXS5l40zhuZFrDEq9A4ACkRxjIumeZhtKw39E4xlymHMG+IQbKQAnmctzpfC2BPNiiCqBB7/PiFRg95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbP3/tSLkEvktNoQBurSAAjgkHgJx6Jb3en13F2oByA=;
 b=CHaSl9vbWavCzSHBsiXnw2rt8X88pmD7eRbBaEltucKei6IWeyXjqjyygcgwT8Fo00GxFrg9Ir2GHchUCN+b+DMiS5kJaZIAHqf/r6bG1TEHlc5kJKZBuxvXUfJeM2M69aMhZrmyKQRVQPYGQIu86k1jZd13sDxjO9M6z59hYAbJ9nzJhrmASExF2zWjJ/xnf042vFgzS3x2oiKwk3JJleH7x7bSreKf4TY+/kA2OHWoXuXSiH4/e1JBYtjklkChJvgohvor6jqevg/vb/fMUnXNdUadgWPDpzzLUo5wJbPv4qhOhbHlKokWT3ZogQH5GcPW50pHZuiEW8hFlfkZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbP3/tSLkEvktNoQBurSAAjgkHgJx6Jb3en13F2oByA=;
 b=oiTG8h6tyQP8bvzY+cN/LlvBJWIwtABeWkwy24NOc81/pCGzBkWpktDESR3siGh21ezVqJldK0aLEvbulL5n7DN/dQDVHA0KJ+o062FRXzaa4glcJzE6ildKYwJHn8Ractjx7YCcSDHAmq8R2yuVkZPPue3Ez3AZ1Z3G6pXRPu//Ln/qm+/6x0APh6R0UM4LzcFy+0WCe1PM3fM755+/DW5awCehK4ii9RyztC/YCOPNBu045AF47MlWmFrTRxv3mzRNByU+XeNL8Yjf8to8ru4PRe9f5HmqrPFnq44pMSLY67FJvspf4seitDF8LEPcXvtFSeI3qXBLrleEyzcpag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 16:16:32 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:16:26 +0000
Date: Thu, 17 Sep 2026 19:16:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	William Tu <u9012063@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] ip6_gre: Call ip6erspan_tunnel_unlink_md() in
 ip6erspan_changelink().
Message-ID: <20260917161615.GA1391594@shredder>
References: <20260916230927.378957-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916230927.378957-1-kuniyu@google.com>
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c82179-7d6e-44d4-86b9-08df14d705dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ITuNaMDrEkZoVCCPZG8pDNk1DshET1Szz4YV9mSXql+AqdOwdwTVHQf6ekcj9Jql89E/Ci3iPQ74nhz5y/KefLR4CiXShhVXOjJ08e/X4hJIxsmzUsrrYzhbAsU63Ub9khlYJMhN5Zovb82KNjQQYlZyJPolFtDzPkQwlgZfBJFlxHzpg4QE4+OsDEg0djh/UEVtGCmaJ+zfa7nhI0H1booghG4tJBw9WfdwrxxlFLd3Q56YZhr8uWpvN3jMNWuJNa3QQ7BR/Wkjt9zJCn9nVjUGvr5yb60onkn0HeaiM9fRt3h8Ij0UrgAH1uR0jsm/BBsqhYzSYXXb6GYf9OyT1Xykd6kI2y8uYJnRlP9w3Q+AY4OEu/Nj+iupfkng1eHNEdpNzIkARj7wr5g/yUyvK4YfYp7lUwcNTELiXzpyKwWAsE7pOxkTe1/KXt2oTHJj2IrOPMULMHH+k1JlgUR7XF06ZpiNorVAC1PNjJKLt0trvKeYzco4K3KrWVlDkZd7FYRhw/T0raFnnZW8x9vlN+5q+hkuD6x+6mXNj/UlPlYiK00DuxGhNNiTHwLxHAx9pLOiUsJc0897ynykMLbkqiwQj4BH/cTEIchP2iZGes8iI2MTTQuhitQC/K0HjrHd2n9lLbNH1jtWTvvJq1ZL8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2ZBy5oIuhBSz14knQL694q21IJ84HwIA+MzM+DnS4ncgEineX1a5iw42UAj?=
 =?us-ascii?Q?0n1lab+4Yo9bQ2O80YirPDBwSJG8OH0cY5K0Lpvf+6fTQnugM6c4PL6iqPoI?=
 =?us-ascii?Q?iTxHiS5ZiOlGQPOnFkt5MRTbJOuxEGl15UFUjvE+ZUSh+lVvkLOUdrBwSCsa?=
 =?us-ascii?Q?qUeTtLMHPw9iwumiDUGLlddtxZ9t1Ms51dvdKnkhUUZhbR5GLqhuQ7/I5I1e?=
 =?us-ascii?Q?MAk4TDojbIeY7iS946k8eACCYMGHrFMG5f1KJYF1UaSghaqqkb0CE683nEmU?=
 =?us-ascii?Q?JLUkBvPPg8G/7GaQOe0/SGjG4QZse0MF0UlwE3i3VFEA5+QWwVIkDeE6G/n0?=
 =?us-ascii?Q?NUTMDtOt+BIPiMM68aJOr2i9TnOC3IcdkD8s3a63P57EFETFo8DeN5/5G+dG?=
 =?us-ascii?Q?uERf/+FWiKZPkNy0Wpt3eTAYz6dnUptSUmWsKa936EbvJSCSyJGghFP2+7Y7?=
 =?us-ascii?Q?Wvag6QTK4LAuIbcxMtufYA1GjpMp7UYGm9Tf1vqqbsnEswo1vzFQBwdrNzNH?=
 =?us-ascii?Q?96XXn2Yc8BFOEj3l9GcpwyQLHc/cU0IlLkRzOtxejqEa77+MUdVG/sAnwegh?=
 =?us-ascii?Q?GIGu+AEitVPiQMuKkKIE9vGPYW3e3PGW72lcs4GVzaf6TcJzNr0F3Uo4SVP9?=
 =?us-ascii?Q?zFuNCCuOFQF3zYfOxkGUkwpgMZieIldqAi4h2yqXFjPbuHilixxEzY0Ggw8Q?=
 =?us-ascii?Q?++dAtI7Osa/DaiPfh4S6dzJ8qG4VCPBKUxkzWmL5i/o/sIEl5xMbIce1Lrl6?=
 =?us-ascii?Q?VTOMPxuP8ggzlH5VwckHH3FOtDEVsdmuzSIXC1VpCDp2xHmWgROBJzZ6u+51?=
 =?us-ascii?Q?kUPVI7sGuPjqJjoQdyE9SzipIXuLlagyKqcBdnsrkStl11Ncj62U7tqGrcCK?=
 =?us-ascii?Q?TrgdMe8PO36hM1TfUihS2fF9+f7E6iJD0GFsNDOy6VNCv2D5/IAguQ5o003t?=
 =?us-ascii?Q?G5QKNjbeXDF6QW/9DxBHc2FDMKchBW1GTrt+2q+3M2fogI3AMiOGh/Ur9Irj?=
 =?us-ascii?Q?1GiDSRWS1qMCYyDJt5Manj2qy1eIByQgXtqC5sNdMzUm0ywoNs/PkM8u8LCW?=
 =?us-ascii?Q?5MF6rl9jufbC2lDmQ9WXMVg/NRHJ3AnVb+7o2sGXvizIr8zYqF4KjNf6XEkh?=
 =?us-ascii?Q?gf2ODQym4TY9NZPBrwK7xJfJ1jL9TI9XJVmmuVC8fJdUDb37QXEQFOjCAK6p?=
 =?us-ascii?Q?CKUFn0GqOx4v5f1B/oWSfkMSw8j1VJN2hB2+J3Q40fskPXEnDnG3Dyvlh7+v?=
 =?us-ascii?Q?J1O6lg6I1JA/tDsIPEx/z7YeFKjUNq4Bn75XpYcXiQRovExZ2D9BTJpmtonG?=
 =?us-ascii?Q?I9/T7C0KjudGrfyCrBk/aINg6P3pOamGzA/6aM+D9csItstXeSgUTTmFU6ga?=
 =?us-ascii?Q?gizKneGnft5zFdi68KU2jiS9MzOdRfo7fOXsWGjKQA6MbakX9oRP1xvgljj7?=
 =?us-ascii?Q?Rh+3kc8umn7cRo7yIoF5XneUFr8HvcV5lbh49V3S1OCSYI23DQQ9rlmliuAK?=
 =?us-ascii?Q?8njdOyWoTM9vVkQMZT7PCCezWn4tAcb3OAlr5L2qi1afEwdH+XMJGQtVBxP5?=
 =?us-ascii?Q?Es9NnVxyx447IhZ4+kkvwo66lyUvxGo3nI99Ig939c/QAiAQvIY1ptnDeuCW?=
 =?us-ascii?Q?m8brDnJQb7grkh1gqiK8DFeZs+j7FdD5ki/zGjNPNSPosCqYjI1THYIsL/yg?=
 =?us-ascii?Q?oCOzdgquH5dyOUScFXyY66oM8j4yet9YDk6/CBPDW8KQCjrVHEBk5nZVkIwK?=
 =?us-ascii?Q?YsV4QtX1vQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c82179-7d6e-44d4-86b9-08df14d705dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:16:25.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SR1bDMzDl4RK512A7sgSoowlVzTvfB00Uso4qHSh/gpqaFD/ULCjg3VGpIKfdR96iDCo7OMYOBQ1R1rmjgXFEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

On Wed, Sep 16, 2026 at 11:09:24PM +0000, Kuniyuki Iwashima wrote:
> The cited commit accidentally added ip6gre_tunnel_unlink_md()
> in ip6erspan_changelink().
> 
> Let's correct it to ip6erspan_tunnel_unlink_md().
> 
> Fixes: b80d0b93b991 ("net: ip6_gre: fix tunnel metadata device sharing.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
