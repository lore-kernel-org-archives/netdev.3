Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F842D531;
	Sun, 30 Aug 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788089245; cv=fail; b=agHJ0MRKrRvIMXCTMHpQWq1jxgu0cRHbQG7VwZTFzwsME+MAg8DB90W7ymT1DY7vFfIjoGiKoJkChG6fubkXtGqBBUdc02H2R5BW8gusYRXOdwEBcUbWNrG2D8E8EkgpRIU0np+33RU15pFRj0aapYvZSa8n0C6tyhvuQoD47Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788089245; c=relaxed/simple;
	bh=XbZdVycc0W2MIUByqhttHtw22nWTQtG9SYdKvDKy0Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iADNAIrmdULQs6SURImRQKf0Ii29eFnn4ZEL7jjWpL3zAcVPI3JpryzGEb3nzZ3EuwnVMsIlrGHqklM7b0otnWZtL8yfHp64ZEENRB9y7Dvq6aEfFUGv0xL43/tTp65uNdk8LrXk8HZ//4bSnRZL7QXdfTu6M0dNPuhTQ+DE2Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xp2c8GlD; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xp2c8GlD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lplCr1zSrYoxsmhZO3ZSVkZkhFbzA0KgFNgASVIE/uWBJMlzBToqwSiTEdNzY4uVMlnpIvcEwsfYffN9Bu76Bn/t9teqcs0er3MLvZ0MnRuiTkxIkqPMDxoek0atX9GEAjewpYKNsoNM0joc14PWlJzRwSNv9bbd2WV3lBRU2+M+Oy8pfcUELsVD54Ym2BC0cLs1SSXqAOj8lFHX7ADf4mjb7eFn41/peJ2vZvddXMyNP93hWlK5ynmySLv5pxtLdQZGZJZNCyQn93WI2zu+xxv07TcqQ97ygQ329bwn2Dw41Ns1oxs+JSHJ+6CIjtrBcRkr7Vh1AqV21cjlftbXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRoJg2HClmV5hOwWPY5CE3wJdBtjoW5HFyqEGtbxxv4=;
 b=pUwcRSTGlJchbeB7I3pi+6wO9mkr7aytjfATVlc+89T+3lRmlwkEzKJAM3COshjDad08xiqVWIDPMOlaMLR7wgjN+ZMmziSSpPUYnr5YN2sn52kctMjfitbOqGVuQWm7RKxJurBRD3G35uYkv+gt/OdV01Lk1ATu4A7pw4JujjpBC1BR2M+iQOpmDptE9s2wg8DxPF1sf7KdtD5uZVzXbymJMUZOX7fro0eavayTZFQVQ0OpZoBjKP4rL+C6g3MBa3bcGBNwXq9sUeluHyiArTPKWXJrfBFxwQJinL4P0zYqgBB9Y2wQ09zicbsiLw1ojuKaV1UDkZLYtSuOtts8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRoJg2HClmV5hOwWPY5CE3wJdBtjoW5HFyqEGtbxxv4=;
 b=Xp2c8GlDAOpo+xEk9RR/faTKVPJDfxnxM4/DyDFSOB/aB66lUFpkePZMs0/D5qLyQtWzX/osNuYAw3B+fIla784NJ0vXLZcJihEXUOZ4FWlBizLbHIIwXYg+uGwfsHUUeDQ4x03RgAFyV5vI0sfIzutVjDcNPDUwITAyfIcY0fmoInUSnR295iiJ0Fx+fSXwr/kLboXDMyMHPXuMp29+5JXi6isl2zGmlN016rPJLMoeTxtuNjEjV89VJ1CIv3KU7GTvS2508Z6l1OP9gEGwj0fI42SSp5eXjzoUm6dCN6em+fTUX2Zi/2LG+qUh+GCJgo91qSoNYtjpHBysuIxuPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Sun, 30 Aug
 2026 11:27:18 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 11:27:18 +0000
Date: Sun, 30 Aug 2026 14:27:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Lawrence Lee <lfqlee314@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Arun Ajith S <aajith@arista.com>,
	Roopa Prabhu <roopa@nvidia.com>, Jaehee Park <jhpark1013@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] ipv6: update NUD_FAILED neighbors from NA messages
Message-ID: <20260830112709.GA2879069@shredder>
References: <20260813233344.445265-1-lfqlee314@gmail.com>
 <20260825115226.GA1338930@shredder>
 <DKY84BEFKL1S.1BZWGQTGRZLMU@gmail.com>
 <20260827090516.GA2014023@shredder>
 <DL0QFI20UBL6.3BM3CZWLDS1K3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL0QFI20UBL6.3BM3CZWLDS1K3@gmail.com>
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: bad8da0f-04c9-46bc-66fb-08df0689a6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n+e3/NI4sCKlBw0LZz4WqXJ4WMWJUD7X6fv574MLyaE5NkYJL0EZ6KIzCrTp6XGxmEmq699oPFSQ7F4DoCn9Cxsk2xT/rRvbE6wty5CpH5Imx8osVT17YckSVkI6G3u7HFa9A27o0Gsy/0sHHzSpzEBvzrLn6kBj8+WJJk906cw/2WjyBGwanH53hnzi65IxsentriaRfk6bM3XP6IUzsRORCEI3YGpW5pqe9VnARpBNDAX/oVshKZsx4N5nb0Ewv5Pj9Y7eY97WrwD+VkTig8IyAzI3QoODktKMnu1nsjRRi3DO13Qr34qXb2Fm4SofRqj++jINF+yijSqhp+Vu44s92oMOcLH97HMlIefyLnRdTqzwGw4lCJeYNhCYu2AvlHKT0FYWZ/5OkQ9bLiz9NwvZPFKmRSCQ2SCXnADBYgopOH8zmjD1OgsoEAvzhk5AzmPkpytxQXc2YA/GrKbIkM6DpJyumyUxGvFcOnSK6Y3Mt0EMDDYCKOv0tR+CXGOeVOGmbcdp7KpWE5EFTPosTjD3jQETBUp8c2DfYaZRqZtvC3+SrRscGVZScZC0ruM0WHz5isJ/FShwvYrNmne4ghgryC4gONOWlcHsmbJLrnPH4WQIHi5tGG2bnnb9J43eNFru8dVESMuqWh57Rb48R9eQD4NbXcETSW1EinEqga4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ohLR98yRY5a8PHl4wekhBPNO8jQe3nksXZ+JKVk/8yt2Mw7hDhLAZCV0sbPB?=
 =?us-ascii?Q?SjO/h8J4KcrG1nAYAm9w2CC+DoLS/N5kFt4vVv43kURVGJpAHfKsIjs44iMr?=
 =?us-ascii?Q?uPBsuEb2rRtdKqOPuFbRcSCbPi4IIKml78ReQVEVmRZspbSToZasaOFZHFuz?=
 =?us-ascii?Q?j7Qp7LjStOg8w1sVeqpeEVpBnLmzm9hcp/a0G2rYK3hbxQAN+x8NNn6mRSKu?=
 =?us-ascii?Q?24uiaR1RmFOloY6AGri+AQlCsp3RsqWWfIeL30hLeaISnHL46btLxc84Dv6T?=
 =?us-ascii?Q?+jsW8H6JCODfbimHoF7e2eAhqVqOBMeDm8ANdihjY7IRxPmJipFHxhTlLYKi?=
 =?us-ascii?Q?NZPNo7GHb72kBLdAI3+smjg04Fmb2ZE3AbCjhAGYDtI9qQoywds2UHCZm76y?=
 =?us-ascii?Q?9g+rMvfAn64qfBld9g6MzJGzyoCqgggIpuEag2Uc6VKf/2Iez9duyxnYf3vq?=
 =?us-ascii?Q?4xPUWW9DMrI1NOhI1XXUULWQfZG3HPTa3PNXiTjcDmTD19PWFMIU0Z9/F0No?=
 =?us-ascii?Q?8JMk1J7wJ47vKXUO7XWLAAod7odl0BN+j2IV1kUUsv79ugZsHO9atCqGCFMH?=
 =?us-ascii?Q?pfyrw1uPdn8lzBQWfh0WK/XBsQZTWvFjWHJm63PJUd/RyLph4iVbzI2xZ200?=
 =?us-ascii?Q?gwj5MT79eaQWVZAsPm/ONq5HPoAoQzAKDHogMJKvxwN7NR7N+7IXbsq5XNhj?=
 =?us-ascii?Q?8grAA0I2J3aOKMuaT8lyauX3UhtgyjZgxrgxMWqV4E5MDQUL5h0SYX+jhoji?=
 =?us-ascii?Q?hAgEcAbsvL+ZeMnLE+NyYSK7z7GEXFebANs7oIV7eq+5cq2XgEgLZ5sZw7xl?=
 =?us-ascii?Q?GtP1ikU4B+NqMkFaL0HPJIvW/i6/fbfFHSTfIRfYk8sOZBfzyEj4R1I5gdLX?=
 =?us-ascii?Q?iH5xwqzwbkbJOfisqtixGTDuyjLufODv8p/jg/6eXglUOEMx7SdfCzyJ5mQh?=
 =?us-ascii?Q?boFq0CA5v+LnevnvwrUxdqyZX1RakMx7J2HEKrt9T62isbjhOsGyi+eAzLEo?=
 =?us-ascii?Q?Sxptfniy0Fg+SEB/sir+d0n+TAFlo79MWCLyxj5GzY0CWMDqpl5zGfPWIbuY?=
 =?us-ascii?Q?vJgSC2Yqdedb/DTuhnnIudlGRGubll/X+E5QxIQb9iVjZc8DqUwTuruL2ub/?=
 =?us-ascii?Q?PNjcE4S/Hil3foZuPZRh4b64OO2H2iyTyKNfEWSv1RTRA2aWQQtRfsXG57Jy?=
 =?us-ascii?Q?bAWQM9n919id7xeiv+fUmKjm/mpwdHbN+ci8wfeGIAMYcw/+ijt6DMa2/kI9?=
 =?us-ascii?Q?8D+hww6/1gN6NbdIofW8nKt2er26kYz2IGksG9RkYaWLnhAp6rYDoSPvtGb1?=
 =?us-ascii?Q?I7nXqJ3UdM/8mWzG/ZZNCAjvBOpeOEz26AGOLWWMcXwNpTPqq+pV69fjUOmU?=
 =?us-ascii?Q?Cb5eHgK3nXwHswE2zs2I23sHHmElml5hAgyCS0PrzcOIbxtpXTU3ty5VWdpJ?=
 =?us-ascii?Q?pcW9IZDLGDr9bdhvHlD4IceGMlNmPxejTCatMlZBr7LkNMjNEnLFF8rAFjNj?=
 =?us-ascii?Q?mBsT8aJVYGlp+gFXZfRnf9rW4evNMdZ0tVz0D3dJMREGrcdvvT+AxEoqv+qa?=
 =?us-ascii?Q?LQiJb9RUyEFEAGlk9Pbhb0zeDKErXwbcBfIrgBFvDQ6P7KtP6Qaso2cmyqB9?=
 =?us-ascii?Q?4LuAM9CUXOd2vZp+RIIz620/JlpYjgxgz7Wu7SGTNKQNQODUNofbn6CbUd5N?=
 =?us-ascii?Q?GGmsWxYD5aIL6ffovyPgj7OO74A213MfLvectHQ/R5G30RuG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad8da0f-04c9-46bc-66fb-08df0689a6a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 11:27:18.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5ZSow2qmb7ius9OTtSfLzHps6eV34FHQNWqIW8EYCjlQA/dKCfcMOtKsy0GppSbca8VYz7to8IirLHF0GoGww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125

On Fri, Aug 28, 2026 at 04:54:00PM +0000, Lawrence Lee wrote:
> I will be sure to mention these points in the message. Is it appropriate 
> to credit you with a 'Suggested-By' tag in the commit messages as well?  

Not really: "A Suggested-by: tag indicates that the patch idea is
suggested by the person named and ensures credit to the person for the
idea" [1].

[1] Documentation/process/submitting-patches.rst

> I'm not sure what the proper attribution convention is here for commit 
> message content.

No need for attribution. Simply copy me on v2 and I will review it.
