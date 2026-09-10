Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA033F9F2D;
	Thu, 10 Sep 2026 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036328; cv=fail; b=SWtYkcQBXAPOrrVHVNwuY9613JVJChbupfznHQNHk445fm+wxFFF198fI0thcIYVaiKTBpyuOWzN4X0M5+6RUDfMSO7vkO1PHYUJp4x7RRS4OIcGXQKzFcRn6TpXjU92CQy6iscQFqxdBF7RQx3t7Xq7fcExCKH5K2hLpcPM2T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036328; c=relaxed/simple;
	bh=P2AWqyyuw32Pfbbxcduh6LVrcJAQJvOqsKzvZhI7eLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Abvqzh50g77UNEZSOAVdm2WjhFL9WN28V25OOaa/PdMvWfVpq+5DZ6qD2sEZVdQbU+kEnXKvOF6+YSUJLgiKuIMJB6Y4W3HNOiQFCj7XBdODa9WeD/4rkNufaBE37teoLbAjEjGrufgVHilHZeRGasy2PDWqFvash80U3M5tIYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcUgpJt9; arc=fail smtp.client-ip=52.101.52.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcUgpJt9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2o+gky4xmk6GQ0ZfPdscFAzIblpi7H/o6+lqjHILZfOalcyClA7TVCr8ArHT7tzcH4iNyxnrBUbBSCyQBdtafz4wJ0msk0OlvcdPfozshgOXtSHdyxV8JkQDlCM3h9wduUfeRa+WeUEqwPKP3v+RTAB7gVxA+NHmDi4N6GZzQ/h/ggM3cEFwvaZRSEBx4LqRs3vsvI1vNR9g8TlwTGyNK6iQp0qEZz5rZMhcMhjYIKzPSrR32gvNR+SVvn/TY1i0ea4JsxZ6VFPMeBP6yJhLS8xTOx3YaGyZy6/l4v+fkDaLHzb6Lf5mXGmPO7azXIo5aqWyiEw12oh09Fn33Xx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2AWqyyuw32Pfbbxcduh6LVrcJAQJvOqsKzvZhI7eLQ=;
 b=OYdiHLM4CFgRuvKr+FF9F6qGvbbqs+TNHk7fepugQgMQmPgtBhkn60geFeM2Z65oW12UWQWFFba7FKfG/Zp7JJuSrdOoqwEOXTyd6qZnTqjyZ0TyS4ZhC4i/ss0WLVOOECa5D7cX7/WJ9Tvm16xJCxxew5gPK+SKTdK1vIMGQPteHTNZn5CASbx2ERXzGxspPVrZhNjk8teCmoKJB1KRLsMLfVEuWfi8My4vrV7X8ozZoePmhpmzhZeJIveKT+iRBJ1/Bdey64ygGNlQWQvw5cJfSok9oFreg/W8P/nMxSuLD6uPa4d/n0NG5Q8cue0KbiE2OEI2sEwisYsZiAU5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2AWqyyuw32Pfbbxcduh6LVrcJAQJvOqsKzvZhI7eLQ=;
 b=rcUgpJt9PDXt2Q1Z0lPZvgxetfs+eI47KBNgHfoViDw0QZospe9dztZ4xy54av4LWJ/S5PPzdZvcLYlY/wqVUhkH2qrO+SJPVa9ob4ZeJLqUUyqwZFxmmaWttNKWeuqTI4TOdMypH1c4R6NEStOViRmgzG1lE15e+mGFXyg3k5Dwte+ssZQPKdxeP6SMwNP1MNHVUkivFpp/qdy3/77JK0IW3dZtIveZXjzbW7xoSCweQkmLaL4MnOLNH73jJHkaslej6Y2GFuNQ8PhKR4vgkIMUfez8aYrgMre2Yax7uW8DMX23S6onSvHZHzeIVBcw/PtJUK5SgZcU3axuK0JuHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 10:31:56 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 10:31:56 +0000
Date: Thu, 10 Sep 2026 13:31:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipconfig: use ifreq field aliases
Message-ID: <20260910103144.GA1678418@shredder>
References: <20260909144417.28871-1-lalitshankarch@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909144417.28871-1-lalitshankarch@gmail.com>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa1039f-d88f-409e-de40-08df0f26bcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LfazlH3H4c3aTvXyD2YK/izCixrIY+ID7eO8d4i0HZEEHF9geuuak/5I5M6DBKBYTuu1aSNQ34CYGTcVKUhGZkLLoSL4Xn5NnSqOoZ06UUxnwl6E+Qqlk2Ni7BC0aqW8E1GMkOzs89ThwAP6wxZ6ZyQsW/jlr2GJg42mi7Nf1M2KboQkXMRmQANwVjhnXO6Vs1PtWXnRwt3ag0gtl4aKuthXOn+dmLDfhTh8Is6BJBsAph8CmMqq21+8rcoEqpCr8mGZF9jT1SbFSgoaOo74FgG3sxm6D0Fgu1+ZkpHYKQE3vWmw0Y9SiSLf4lHoxELOIZ57HNfqF5poHSMBw76E8Trj2Plj3tE9iaf7QmULlmC19RhYFfh9qRT4BtvwsoLYBuyJMJMsvN7mEOlGJ3iceLR+ePEheNAvrytU9Lb+vTH1Gay/YL6TTVCZRPG/+I9rjX1EYSsnNhz3z7SK+/s0C5El56/tpJYpa4uJ1D7Oj2ZRphrQMrjm3CexTw366KIhRxArEX43rh7ubo7yS+M/UbrAtamPWSjl/CetUMsB+lgCTC+3ODn+KHT+BWVE2nGLOji/DAWJEgqdtlcoy5nKXXp7E9ZTXwE0ukrLQZAKwyhyn7HqpBETkVt9bDoNeumngp21Ofva+d/clja5jZYBIUD5Mw1ttK6vN0mEdmZlDps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Np6AVwf8IloiFGiwU3r6H/MG4chAfw/B+QvgOg4AB6yhejF4A/VuPRp97Glg?=
 =?us-ascii?Q?hdzv2BX9195AB1zuu0NpYhTJa5aZNahLQbc2poOM/9y6qY7vAzymEue3YSdU?=
 =?us-ascii?Q?SjPyTWPnlYNzy8YlWA/RQRhN/ScQWBZqpC7CGSCX5Vo24y2Z6Mcw0hyARG05?=
 =?us-ascii?Q?pd6HwH5+nq5SYwYnvi4n3PjkciQe5f7wSoJ7uSseL+GeKkTNEAnOQj7vJrro?=
 =?us-ascii?Q?/kd/j5cwQkSMpESCzoA1HO+JJsRXF6DdBC29qThvHEtehMnhoepgK/G0Qafg?=
 =?us-ascii?Q?GK1UlyOzDtyNYL6IQEUmwSV0nAxi38CYCMDC1r6KY7LJO4SobDtdO6sFZ/Uw?=
 =?us-ascii?Q?9Y59va5CccPxWUwN7zy/mO+PGtMHv4l/+Ab5w61mAnaWpXb9TA+xl/kAms1s?=
 =?us-ascii?Q?zQHGKHvlRYgkUMvHOUYgJ3t+9XghnJxdZs2aIKKfKw3NK126+mOaKsZthGxR?=
 =?us-ascii?Q?oDZPVSiOQ5Eg8603cpxvF0DwWJ2CmRS1aY3/9lJtHUA5amh1dYrZ61X/bvmq?=
 =?us-ascii?Q?/3alP1zcW9gRkjrZd4k70PFdCIfx9DPQBKhl1EXWcV+Gc6xh7rx3oxQD5XGs?=
 =?us-ascii?Q?F565jowKDKdBjdt8Rw+C8gmlp+ewBVWTsf8yXJnPtU/1zV1RViUHd569+/wr?=
 =?us-ascii?Q?EjK2Z+hqJQHML5ZWH2fcXu8iXquPMddbiWbQRJqnFmSwRsfiuDJ6WN2l0jCr?=
 =?us-ascii?Q?1N7PmOOGd6nFMdhNnB5d+CbcCEg+rsRAe5s8U9kTfv0exBJKJAEUdQOCPMnn?=
 =?us-ascii?Q?oVinXgPAD8hronorV67VFoGcsl4ACzP/L7eonkft6+acQpHwPC2909AUZyIb?=
 =?us-ascii?Q?IbT9xEjgUyUHDSHdpuzD7gmbGTVf11mUgzeCVA5WaprSlBbi6uOaS+FFXk1I?=
 =?us-ascii?Q?VUrTgK6/iGU1aoA8x74uUO7U7hIgGAMkGLwNYzefSQ/bLswCflyaAcHqJctj?=
 =?us-ascii?Q?6aSRUILjQdZ2nCkRRHBw0gYlnQJa0WkX6TeoiiLzsranmx12HGQJ0y3akwG5?=
 =?us-ascii?Q?VWN9WY6/oad8MDOj9PZA6E4L0AR1YGO6NMe1X/AqFnavFzl8Eg+YdMrD+YCo?=
 =?us-ascii?Q?lVdSYesX/th8Z0AEiqcQKWIicas+lwMKg6YxgMbHoWyBGt3F65vtxaW3+HIt?=
 =?us-ascii?Q?ciokRldKx532mNjXbqWnVOZl2s9uA7Z6y92ybn4x1HQAARf1PJts2X7vt2+Q?=
 =?us-ascii?Q?4WrLCpeigR9lpjBuZuEJy9YXRsQUs5ebwSfh0wP722dEps72ErMR33nsTRWK?=
 =?us-ascii?Q?/KGkJjRI8Ix3wmTWCvI6J2DuhVKkb640s6h6o8JokzuMtIiIUYH/UtuFfcTv?=
 =?us-ascii?Q?pKxWqTDl7fiGgvuUD0kEYj0YeuxpRaJP7VWYJOMP6C2NqELWqmLAwRHyi0tB?=
 =?us-ascii?Q?WYQV6c77vVKUQt3qb56dxT6NgTagx8MQtadOX7KazqDIVknpxp5R4ItAIqkT?=
 =?us-ascii?Q?mIMPnTVr+5pf2b8OP/O6ZJb/TdhhuWGGg22qZ5FHMdHlGHDMv8OqNZj5Vagz?=
 =?us-ascii?Q?f88ZRS0GXfrCnLteUeWBLBCgjiPhOU7fSlOK2Ngj3JaEgHNeq/v1nIUAY6fn?=
 =?us-ascii?Q?oOlabIvCbX3dE/0zkCnlmL6OYgb7mERcZheYVr5NCMUNcN1qLzJ84H4CrDtz?=
 =?us-ascii?Q?u7i6uUOxC3QHR7T9BlAq9qfojr2L8DCEU2C800Ti9Dl+etN/Oh6GglIdaKIY?=
 =?us-ascii?Q?KXs5A3FzmfRJ2v/osHc+imM/0qX7aSQ90ktvJw7NGefqCVR/qnZcebrfcvL1?=
 =?us-ascii?Q?u8SgltkxRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa1039f-d88f-409e-de40-08df0f26bcbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 10:31:56.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ol9qGzzqDZebXq91qvOFhkipTXxxpC7UZScyrdIfbtsfyt+ec612g600hSc7TqadjC80nTJmM9IvePNWpbmEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A

On Wed, Sep 09, 2026 at 02:44:16PM +0000, Lalit Shankar Chowdhury wrote:
> Use the ifr_addr and ifr_name macros instead of the lengthier versions.

Please read the following document before submitting more networking
patches:

https://docs.kernel.org/next/process/maintainer-netdev.html

In particular:

https://docs.kernel.org/next/process/maintainer-netdev.html#clean-up-patches

Thanks
