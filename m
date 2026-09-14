Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF831415F23
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380970; cv=fail; b=SJBQ1559IGk17apjUmiDebl4PhVsPfzJeBIfFrqqhhh3oMxAXAGoDEtCWrzALrN3LX5C/EbqZYcpEthh5dT11gLObFIc1+Iv3Yv2nD4U9CccVp6p1DIxuiatfs1nf2P6e7Nd+UyIYSwxsxFUPVCrGlx5P4TOJJrEH3TAKLOEAGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380970; c=relaxed/simple;
	bh=3teawMNX9gjKVCo+Qnr1OVA1TE9YYckectP8zq4vByA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gffaMVGQYEaWi3KUTBiK9BvlgIESoFXH84SUNKpaDpwyHPZbstYGWSSZV+aIb4pb0JuZ0Mg+yRrP19Ex+hZ601nPoWx5ye1NyTlcECoxFMDJ2/3he2+5gi2aLVBPNj4/2ys1m+n6Rmf0jDcsHgh2OG+Vwaqbx7KjbLan1IZ+EgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rqk32g4X; arc=fail smtp.client-ip=52.101.57.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rqk32g4X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxyYdXfEY3fD2u5qRd/mia0IwVH+U6xQatQU+IidyuPPvjq3z0mQ/tIOpNv0XJgeG93kSAHmQ7CPx0oy+OIBRCzibVB+AVYtgS12JaF84mUQzz4jdE7cvgOv1rXvEtVagVBdcyabiDxz3pJXAfW1LuEgkor7MTKmTwNpze/CEMJAG0QIwyQatuWXrAraq9qsFAYxfmFLSIYciJh0dAeUNvlJDCtM+c7J8u5v7QzRb1wXTIZV4lkO/IsK1LXRUK+FbGu7tBQ18TQxzbGYSouSMj7eokdVBIb4o+tdruSgTkzv8C1exMEbN1PKAs1nBO+YGBVauyN1PUHb8bBw8QC/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOvaVA0WZpPwu0qnypA3I4lLagSXlHVYBt7v/b6xF2A=;
 b=J2+9WOHaXIWx8RLN4iQuR3wSSMOyLOUI0PVPiKQ6AWwYH+Uw8Yj1fgIFjtpgBRbIVQmuMJbaw+G+KMPElGrBtlYTzwz+CalxsPyNziLymHKFdxOxWGwnKIwYZL1KssYs8CIXCu93KzvYmRpCFviPOvWogVGqh/ACmiQBQ2AuT6fmsLPRN7My6uk+ZxXL4sgb7v3N/BhuNKToD1sXyX0PBIHpWqHqjSAZbi0YhTkZQWHpWK9WV6GDnCJ4I6Rl38Heb87HvxMbA0mDMz74+XbNamxEQ6yz+7ZlHyuWB5LCRWYS5iu8zoKCGda9+4PMIwFgkrNZhMoTlMBkhkvTCfBeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOvaVA0WZpPwu0qnypA3I4lLagSXlHVYBt7v/b6xF2A=;
 b=Rqk32g4X0ybuo8Q0OptofULgulqagJgz1/6YifWKL25Ei8DikmyrS9uBQBBAlagDUzxkyueOBfDrVXrJ99KrMloqDy/NhxaRz7cUyfT82QU1glyZp/clE15t9hIjD2urdcCvQkcRE79GCU4LDjgc0Mm1gmFVochBDlhjIQZDW+L+f/ltzwNy6NE83OAs4cQk1fITBrRIxv/CPuqSadULDrkMI76iG5iIaXMqVaIkHnv9dz2al41HqaEMNup+CwRYZRUKM7cCcAqEli6Jlak2/QuTiisPUZDWs2wkJD0Xt9cR0JiIrJ4p7OMU9PHPDTkuackWj4KKSeXX/lAR6nESBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:16:03 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:16:03 +0000
Date: Mon, 14 Sep 2026 13:15:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/7] ip_tunnel: Support per-netns device
 unregistration.
Message-ID: <20260914101554.GA245219@shredder>
References: <20260912230043.2586313-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 73502b3f-5ce3-4fd4-7e02-08df12492ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	olXsHnLOS0l+I9VMVtLc7/CPKnG6XxGzDk3fxgh2NeZ5y6akFXTYVS/eVmeoBNMtAVhQlwbw5NrewLGgbBBCNd8qpkBvodxEeT2qpnV7NiPXhjMslgc0qKcC7Wk3oRhfrYk/nh02b1mHvNGMZr1AsVLTFejoO7CuAe2Ga0F+cMj2wBduDFOYBhBrE7hZxcesioCrnTkiPGgku8mnjcrfS8KWBMl3O8hTRuEVfCcK8x5yRevM46E4RxaSxbRaWcr1g0IN6WYLlc0xym5Jek5oFJhF3Wabi4RlsslBTUX4McNpQaS9kMbbRN06vPKXt26uWMTAwoRH7fKqMxcO6lpAMgeqlyPhhxi1B6ctpUMxOPTsT2TUMk0SRhHR+0grT6JI8c25aEq2Hn5j2BFSRYPA1ZMwWNjAuubWglLnX5zVvcrspxK5VHFzf9a08bk1+7vVbxvhU+UP879EhlOraW6Eef7GFO47DkokZI4zr/UKJpi1DqP1pbMX5C1RTo+iyjzUHvG814uuzbNj+DvHs9wRPJXXGH901pdjNWfWMDfYfXvEpGKegEnc9swUS+dmP91lLtm7evOCt7OOD2Dnqt6KS09Syoh1FlfdNfoY/0J6xcMhsuN2kFDcy9iCbITYRUiLeLz+oxUMYWt5+2tbhmnRwhb6u1FqhJyhyCuR3lwZZlE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dv8HYIlVtOXPkgGJbZELupEWbysEjeWADc/00Q53I+ZcqQv7D2yv90GF8o0o?=
 =?us-ascii?Q?H8AWohpTFZRYSi37DY6QThq/3CjqsEV4eJoOlkeMI8Xd/I1SJaBD46JJrBme?=
 =?us-ascii?Q?9J6+wl0Ub+WxQ1JfLItO6K50ua5zLV8aJ884JMXgk3EgAzXQdhcfhcn+INDo?=
 =?us-ascii?Q?XL09M/G6FzwiqAxNfyd9q2aMBY7r72+fuBh28AFEi099YKvBmxvpdnfQVu4Y?=
 =?us-ascii?Q?BpFmg8FiVGreEyp9UPoJw6iKwsojG+K4x0TUVvSTU5EQYaif7cH6qDKuy7d7?=
 =?us-ascii?Q?wJeNLDSYZUShetAEPzeypQ+aMiW5y1DWa1ywemRLnAD6/2E7/l0C4CLCZhPO?=
 =?us-ascii?Q?C/zD6MhtFOigcKU2scHhtWSTy592cO62VIqhDNlnIjwttSfuMvt+CPEgjqA0?=
 =?us-ascii?Q?RlLiIiQ5TTnRst3pz0OR8O0zmeI5I/RI+3CLcmeh1czsxxcXnP1Fz9+EV6h8?=
 =?us-ascii?Q?NgbgaIJvtJ+g51wYuXkcITYGlP63Q4JmRsnFSoQYqylzZ6xehAdTqmD7/yEg?=
 =?us-ascii?Q?4NMyvbvQr4QKPEiiYMKyIZUABrT/tj2rC40OhGuPL9CvXelmjPfGVLriuvsy?=
 =?us-ascii?Q?9xSP6rj4ljmFMy1Y00V3z5ojWEaSR6iAWadNfoOGE6xFuWAZrccETjwuSB7f?=
 =?us-ascii?Q?dVpNk/6004O96QsytIa2yLzzp7OGP0dHOEgyIG1kmD3EKvwZ8WaYOg1IXvIt?=
 =?us-ascii?Q?L0p0DdFZpvPQyQH5xrDWdfhM31VEbT+1aebCJHJoPIApvN9UH/H+O8rC6kID?=
 =?us-ascii?Q?+RDft6LODPE4GmnU8eH75vNKR6J22dW2bz7Ksa89LsMBZmNI45VBS1FKmmWE?=
 =?us-ascii?Q?7uFB/uJUQf2/lzOFAYUcQg8tuvQ61nkQj+8XqHvl1asXCjNdVYLQoJY1YMrX?=
 =?us-ascii?Q?W+dh9sb5xtMiCGNleFsZAug/1BsxrBZKCkl13IQOE4DOYM1cD3GjqNE0yljI?=
 =?us-ascii?Q?XNENhEowwnk04VvL8MR13nu5EkfjOVkHkh9asC6h+Y8XhhlWLMp233gUfJfJ?=
 =?us-ascii?Q?INTzC6MY2aa37PlaqImqtggby31PknexWx9IoG7VkHqF1WmS5tcwoHt1/DhE?=
 =?us-ascii?Q?HB2oYyCvPY2PlA0eV46rCtDXi2Q0p/hD0zSkeY8csr2INASYvXGlX4K8x5YR?=
 =?us-ascii?Q?t0BQkFOKv8VM6KAb0b+DptbkED4VvMeiOTPI43EK287UfAQLaaQ+3k+8jk8a?=
 =?us-ascii?Q?0OZ477/epLcORiryX73t6Jqe1hJN1YIQWGJwrzkVcN5eyzpcKcaxoKsiVE5K?=
 =?us-ascii?Q?5uNlkxWGZQhCdQO79B8zsEy4U61x0aoWoG77lWM+M2EkrlQHY8LjcsyfLPa9?=
 =?us-ascii?Q?ure1WkpHHHn4S47UCqJAROoenNZa1jbLbRY8KeKaTUWLa/Fbsb9TLVmGpMa3?=
 =?us-ascii?Q?bzRSHu/GsYb5hrJicqGSD5pb7HqQ0mHMl9k8egldvReZKkl1/SUxqhXBgQRO?=
 =?us-ascii?Q?l0noVG4YJzrLFstxZllPVj6FrpzJrDtsoRLJd/LnEplAd6tGr0uuy81rQJtv?=
 =?us-ascii?Q?YUFtyfMGMIyBnBI8uRVthO+eLAzIiTwB2I9CylYBvi3Idkui9pTGb5wq/cCf?=
 =?us-ascii?Q?/05YPvDwqmbJu5ZJAnXnHCRUTsPopPJKKO4DrsRozDsqJi2/LeZkdUnIrv1A?=
 =?us-ascii?Q?hYD3IZYS1xKSBdxWRroVACrdXUMZbcH5f1TmpZ4KcMDzWud4dldf06STg66o?=
 =?us-ascii?Q?oZwZ0hY5k0B7bvTWJxefpT4TOTOU+xSfcg2nhfY7GL3nBw5+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73502b3f-5ce3-4fd4-7e02-08df12492ec4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:16:03.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbkylSZjkY65Ewo3liFAfb8X/E+noxwK4n1KZ07i3BpvQU7lST1ME5ynq02XmjM8Sx3E/AXMQ4mdFkY2U0bShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482

On Sat, Sep 12, 2026 at 11:00:26PM +0000, Kuniyuki Iwashima wrote:
> Patch 1 - 3 are prep patches to unlink ip_tunnel device from
> the hash table in ip_tunnel_dellink() only.
> 
> Patch 4 removes ip_tunnel_del() from ip_tunnel_uninit() to
> ip_tunnel_dellink().
> 
> Patch 5 & 6 adds mutex to protect the per-netns hash table.
> 
> Patch 7 uses unregister_netdevice_queue_net() to support
> cross-netns device unregistration.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> 
> 
> Changes:
>   v3:
>     * Patch 7
>       * Check check_net(t->net) in ip_tunnel_ctl().

Thanks!
