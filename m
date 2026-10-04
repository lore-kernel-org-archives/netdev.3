Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A896374170;
	Sun,  4 Oct 2026 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098842; cv=fail; b=Iu82DNQpJjGn36K2fLKsl7T3KdXcXNz8luA/fvizY/iWA9x5xwPsTBNcv44t7IX2967Uv8p8wyLyDbGGbtg7/UO1K6uv4FVsXhKoIDNkcgvuey8t+RUnTAYJSU9d6aVwvrNMB0Tx3PopDXc56di+NmTFBBoFYrqv1+LdUoKvoxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098842; c=relaxed/simple;
	bh=7AJcaoPuZOm64Y3U6ZWEcpFeP5mvt7rXnXws2+lBOWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NuEBruHTnfcW8llT5dtPLZ+f24pVHuAx+qiYqGsd0KwekZpMNhXXXjZiGEn96d+mov/uaBEvS2a5T6pP7ZYeFYjAwNhOeoCu00EjNd12o7H3N14v/pGILSLlPYPy5Mp1ym+6C9GoMMIRAc4zvGy9OkvHxYKLTVQWZjt5avCKWsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kv+pfx75; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kv+pfx75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g58lw+OBlVdvbHI8DgNI7ca1+Fcty4hZPWaq53DWGZ0qJidvLoLzLDD8ybW26dnsFrNeQnFKaPXXf76PLWpuPd2caEENECW7TztMg5k/M8xa8D/Ewuf8VoVWMcvNXoj6PaPZrQN2vYfba1VyLCkSfbjsybk+YmwcoiQUKjbXL7R6NBFri1tzZzs0ecMtib9XlrP2mQokfI6ltNJ5guyIG6k8dEe9nMrqqCw2k1MGJsx/pbe0q2JetxrQTo1yPF4owD/XgR5QpLMrQNYCEkcMXo0Os1L0emNKfFrG+THbW0RRLtCFVOBpcD75vFqOtVae2cpGjqEakH1lhWAkDeQDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPjJxVKDcrWpICV5DObJrxc0rbvieDCFtEyU3B53wKM=;
 b=FXAkX5cnKV1g8ceOl3hs4q94ENZ8H0bsGRjls0SLYlBThhUK74Jy1jcKddTeLFKLebH9tZYyfx/32/2smAEexHa6gHyXCqmaHOnbsUHWb2CpCrPI6PZSlxihgzjrdmy+Bvpd8DUfgNKm28usEAOuTpeEDxz9Q17uN2zdrEdy1EEJuXmUSmR6pSuTv+Nivl4SU+7Yo8CpMH+4lG20R7VPO/0Q9hDmq1ZtQ47hOqrHZoOt+zoWyS8B+Vrgkhu3d+TIam8MD+R8cbIZlVOX1WWW7KS2pRQmeh/1ypPYT6l8Ui8q76deknHV5nj7au/J9DYBSodUY4fiiBCHmqoAxtbd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPjJxVKDcrWpICV5DObJrxc0rbvieDCFtEyU3B53wKM=;
 b=kv+pfx75P1HkguP/LL9S0fD2yjyt6niOddFxczAUW+BiMW0LhE1YwUz+DBToMi0wyFgVtFOVrGJlmWhDtz9/2ZBoGSwDFLgYWNn6Bw50WJfzJVDWy3PCPZ/mmch0S5rExbCBj6g2gRdSb0eFMeVP57tJgBPBV8hzI8fZbWEapNZ9f+E/jyxFpzjVON4vAiynUj18ipcA5HdCEylSzzz+YxVO4z+A3UxMXPqMfHJyyK4NORVQq0g/ZFVhVmw6PiJTzAdKZn8oIXZtb9TGoZ9WEXLDktopIbiVfdXIFVNFjyLeJXkCQb4De/52wxWLXJmRVYxHq4PY0dFDT0ZbMMR07w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Sun, 4 Oct
 2026 07:27:18 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 07:27:17 +0000
Date: Sun, 4 Oct 2026 10:27:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, William Tu <u9012063@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ip6_gre: remove obsolete ERSPAN PMTU update
Message-ID: <20261004072707.GA72754@shredder>
References: <20261002033058.358137-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002033058.358137-1-4ncienth@gmail.com>
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: da36fe42-8b19-40e8-43b1-08df21e8eb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|10067099003|56012099006|6133799003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TdQt7d4+ul+UAj5W+mxuDMRDwUPI39dk+eQOkWErvewcbB6cTh58xuvzBtUG5Q/ug93XpWHCBiJD3sMkAe9MC5nQVdQElaQK7XRRuCRMf4b7wpYCYxLMFdGzobwVOYGsma3z130WOfvu3xG+yy0m+ou0mjLcdUtJHgo+372+696MSQ1NGAadYw59lJTi67o3B8Gxl4U+E5lx5dgfQNzY37/L+0l9QkERv7Pc0u+vb98TWIWM3FVTLv2Y0+j37Gyb2ms4ig4jl3nXmRlkXjvAT531ccW/np3i5sBpN4GNQ4Gw0wbs5uYMkVHvv8xwqIDugVcU5BtlYsuydRfz9/mamqImEEzZhTMKxIQi6l3hnc8CGf/CJHxob4Hhs6cR9k9O9r17xiGA9uYxDBmANvukpbKzXF86D+itJKKHRrlaN3OuqLYBY+c2u5Ds0IjMSijOgvotP4vOp0RXsSvZlDS8s21n5ueYQfHjJrx9PGNmN8+3W0qMnvsbOxPNyeVUyExp7MdQte9xI3h5SiddhuQbSpWifzkc4a2B5tPHNFoMUypitY2vZgK1pkZCFQHGsDk8/lQKsNpLC68CZWfXuuu25SPNKx1RbwIkVIJuFDTw7AHdgvyH34pgQX/DS/15YX9ak0khEa+ul/KgSlF7zB1B7/WnfxKsnat3HU/B7HdUCLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uk7CB0mr3sXwtBmcTSamYW85ZkJcVADrQTEGDiCsKZoMFk85PfNBG1BJ4LWy?=
 =?us-ascii?Q?XxJNl/WPUrnVea928LlEXoQ71B5f3tZMDHpuUNuPmCdZlrj8nmKX3Ls8D8ZS?=
 =?us-ascii?Q?y/tTqiOtMUX8WdMmvl632ZGBIwhBc95maDe/uJZtB0uXxbCCTMj2yO7kpwbB?=
 =?us-ascii?Q?UgAG3LyYcZbihcjh4Gpir57oBYOKL/xWYsA7HltwbhqiioF8kKIhW+w5DIDK?=
 =?us-ascii?Q?6Itb7S9xXhd2Fy0OPu8xizCNomPkYMFzVI4DTrQvudWOBlhRNtnJze4mM4kJ?=
 =?us-ascii?Q?s/gzrLabpzyGP1oA+cxafv+GlDpxJo6HLfK6kKuxeqwgKQacCk3l7axUD/W5?=
 =?us-ascii?Q?yhIAYtm7uUCEj7qgj3B8Vu/OIjEHB2zKLpW+rSaXn9j720iMc4Z60U+BUW/Z?=
 =?us-ascii?Q?CxPwr8+v8jLcUJTN0Bvk5rC80gR+acMqcMUVVGdtMaBYKWUo3/j8BviVd76A?=
 =?us-ascii?Q?1RHi0psrtGsMSFaylGFQcdGbDGFU12uT/Y2617V/mmCwKQrY5YQSVOrAT3IW?=
 =?us-ascii?Q?D8I5xyErSOJh61w5TltE8twZgpmTqvvdGqt/BoVDbDhMYvwSSceMLTQ5DwEQ?=
 =?us-ascii?Q?Bm9l3EG/Xuh2Z8ULPmGfyISqyI+SirFrPW+iI8aKK8PuBu2Gm8heMwV8tHfe?=
 =?us-ascii?Q?X/BaR68+Vls6jPROOminZitxyi78ATw7Ayr/gigFHAjqBfXe6jCptCFi9q2E?=
 =?us-ascii?Q?viZdm83wBdACu64/rOvPjYS0N4fVszTLQwylYpHH9Gcxx8YzYSpZ9NuVOx0i?=
 =?us-ascii?Q?YR9YqQsPWSISUywvIcdbm4RchBRUwVDXNyFpeS6DPE14uQJYw89RSQOoXKfK?=
 =?us-ascii?Q?j5cFAdltPMeQdpYI/HhJ8sKvjMtTayIqrPE/5EjB7TfEm0Lmr17CQWxsRPKj?=
 =?us-ascii?Q?6seH9CWQEavP3YH1ZPvAjOBrjBrQv6yvV642gQFC0kPjaWe2i8IplTgdKwiY?=
 =?us-ascii?Q?VtVKMC6/GGLiLILvCQxnP8V9xcVRlvbqrMQ8qUW8NDMhk4bV7lWASSDbYdDA?=
 =?us-ascii?Q?o17e+chu1Om6fTLDM4ZMtoYiTxnhO03BYMecHmbpkbv+RcTZkK8NksZRw0oM?=
 =?us-ascii?Q?tTomYZaBM7cJWf3zaS5t50ZwFvUyGTYnIHZtpBRlhWXOPDnBaxHgTaClep/G?=
 =?us-ascii?Q?rJ4iw4bKCxhmiY8hZWJppC2LRe4uiIJbGiMDLlYeqTqUXQwF8taxSCzV5tpe?=
 =?us-ascii?Q?37/LV412HNYp30MsVgesFLu3jwOfl1BdrnxcV4XFExkuAoBQzJgdaY371Yol?=
 =?us-ascii?Q?HrZtyr9w83D4gqo4zYvlT5cNPrG4TZ/ajNOEglGAS6t1s0gyZXwOONhPjqcm?=
 =?us-ascii?Q?4pP/jBR/hsUEnBklbmeT23oocTXdLdHDc4ERK3lYOrSGFTlhIUYLDrzLfKAy?=
 =?us-ascii?Q?wS3knV2a1JC0jTYHKAy7OfA0RjAJW8+4NffR5371lBSTtSVSXJ7j2VSkc9Tz?=
 =?us-ascii?Q?lwfIgbDe82oppwCRmGU3PogvfgN0ORXvrvlYNIhXup6yh0c0dYTPcG6KxNdb?=
 =?us-ascii?Q?f6yf0RrmB5AjOIdEtROeTOQRyWAOzBSN6cgvotZO+ZMKAApNcKUSTCL1XV2q?=
 =?us-ascii?Q?IJI+7+x8EH3qYag2bhqLqOkc9E9Ut4xzbXq5FzeZVMMDhx7OprjkCePDkLVX?=
 =?us-ascii?Q?mK8a4KgQ4SgvZckwiwtP6J+OpwG3cMECnOEE5FoVKQ6PnkpJcSBQjzs+/ZuN?=
 =?us-ascii?Q?IYPv3rPPqgbRp70i4+LRH2Cr8I0ph4BYl8GimrhpsJ3CQU1e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da36fe42-8b19-40e8-43b1-08df21e8eb2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:27:17.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3JX/0ewCA6w532daAOChY8OwpjgHQf5TpwW9f5qHKiqS2qaC3VAY6kBJ6L1XiuHoAFFzdTIQAFl4HmHF1KtlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

On Fri, Oct 02, 2026 at 12:30:58PM +0900, Daehyeon Ko wrote:
> A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
> and mirred can redirect it to a native ip6erspan device. The legacy PMTU
> update in ip6erspan_tunnel_xmit() treats that metadata dst as a route.
> Since it has no output device, dst_dev(dst)->mtu dereferences NULL.
> 
> On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0 used
> self-created user and network namespaces to trigger:
> 
>   KASAN: null-ptr-deref
>   RIP: ip6erspan_tunnel_xmit+0x10fc/0x2cc0
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> The update is obsolete. Commit fe1a4ca0a2b7 ("ip6_gre: process toobig
> in a better way") changed IPv6 GRE Too Big handling to update the
> underlay route and removed the equivalent block from __gre6_xmit().
> ip6_tnl_xmit() then propagates the underlay PMTU to the overlay route.
> 
> Remove the stale ERSPAN copy and its now-unused dst variable. This
> eliminates the metadata-dst dereference and keeps ERSPAN aligned with
> IPv6 GRE PMTU handling.
> 
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
