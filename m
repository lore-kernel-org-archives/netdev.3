Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755794ED1AC;
	Wed, 23 Sep 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178844; cv=fail; b=cpXLkSzU3cXl9sgFh6p98TCe90gUIoGsCVGCKyo3isU49oVdvR3EM/yKrOpZXpyYFNeEH12owVaVW5rqgUWuopPiXceE0jczx3ch6onndEkS7fY96E6SQAgTr2IR3uEjTlA6y+iBJEsJtvTVPW/beU4cSwxkW9xsHYV0rbPDQ4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178844; c=relaxed/simple;
	bh=GMisL7Yc8v8XEW+sDjP9fCc7wdHed9AYFOHIkqPjzmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u4ywKAJEKRInTH/6b3aJHjYt8B9Ihlh88Y0HATJOoLHbM+9nogLCoSX+Gapq3EeXMUdBXcG1m+Xo0MS2yHBS7nVbIJFhOyNTr34XcYf+1z4tfRNWTzg9w6VM1bc3cHAt6lEVMEDuyAWG45GeFBLdikHV4YY3ed+7v6tgQI2vVwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJv4o0tk; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fJv4o0tk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqybnJLVZ18mXAra2g68ZtcH/G6kKn541iOVZJ0Zjh/SBeL8hbnoey6o5iaXcHStraWG9hjKRb9WDi83jSSv00PKLygQZSnO1ibfjj6lXxnAHd4NkwbZnxcPp7K0bN3cItwGpD/DYyAELuQe3550tEwoh9iDC97U5wFIc3QCi26Fs6wMCwkzbJqqiJ5nRMmpyb2oX9YV73NEOWaxl1rvTkKmBt3jaz6qz0X1BXynIe+ub2mZAL7Yai97668XboDo+Lqqb8cMedywcUlli3geZ9r5cqaN86zNW/KVFuDesyfJr4/whoY/DumgglUEadKOWagh5WM14l2RXF80TozcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8v31aI80OBc+djKG+pb61PxJm+4H5xGR4pbmO3AOq4=;
 b=FRy2E24eL+BVa3fI/j5jHD6GIXEhxIIMpTr/83hn4km3jJSnUOUbpPMEjVxNcRBze5uTJ9rEmpw8jvHoevQCt07RzAV3BcwZKXBFnj8BT8Q1SAbjygcDUianjG1B7O0CTJFE5AaU9c6lR6wTN7JjUu17AXvt+ncYqCX/QmqMaKbqEXb8T4lRlsIin6DM5kNd5iyFhWToyhzsd7y+nSN0SlfBMkbZMPWSTgYxA9XXqiVH8xG1N8jv+z/szQRI6/gL30K/kaT5POhoTCIymb7uXAIwpI/eN66RGLdnbeKhheNVQYlZ5bIY23cRiJgCf3Om3vudpJ9ID8aPIfk4BCE5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8v31aI80OBc+djKG+pb61PxJm+4H5xGR4pbmO3AOq4=;
 b=fJv4o0tkNed3hpPL/lPrsEvzmnnylzQsdQy3WRqTR9YRFDrGeVrvWzAdUk+EQTT/ijSeh2RCxTRztZJJOIQizJ0GXkaIT5mVXD15Q4GPg4iiqg1cGNmuuXxehncnEntoydP44pTbTaC8Qe2rklim3f06t2nM36IVk9X6HWUR0keNeQb61Y6pPhVTdzySmKUoaz6Qa6gjOvPsLEu8Yipodl9cLeugzXZJDn3LiVjUvZpPP/glL79uD07qAfT0W7oDkpgSoCOXC4AqeQW6itE9m7v63sV0VBt+zB/NhqnF5zZd9HRTrRnbI0pi2envZwtS7ky0ooWlmxjGrPyr0EFQcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:53:50 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:53:48 +0000
Date: Wed, 23 Sep 2026 18:53:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/10] ip_tunnel: add drop reasons to the
 transmit path
Message-ID: <20260923155339.GB2880695@shredder>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
 <20260922221507.3268127-8-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922221507.3268127-8-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: d6390eb3-1189-46ab-a5a2-08df198adb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	irHIbs0oxTAv8L1hoE2VunXePVsOZZbrvuHiKYSWX+qf8E41h9RPlhrqoxT/4hyjCtGplzdndC8Q7lc6nUIxCjFR5RU0a8y0Wn38XwI8Uv8/Y0METe9jARJnzdSfNhgGL4SkSBc+KWLpO4tr0ao3XrKCrZX0tTW2suK+pFErqAfkpZeZw3DCxkP942u1bbBt9q+LT0LQVwtzUkARHZf/Qr+DPgtqjrB/+S2QHP0qZNqXIig7/GKRFzjzdhSz3UKd8PbywNqtYSmSgXDup6wz7KIL7GvfXnyd8WORpULzqQ1Nz2iaV5Q78vAwEpeQKiBypxw6r7GUB3DJc600dTSyf+fV/C+e2o0C8nsUzgVnxcF8cr7Tq3FLbdZm5O7ScUY2JhsJOJsmL3duj24xlJEyxSTKm68P3Uq9bRZq7cGVGqP1bw9N+MsAkYHGyAWPoifJg3lroUpu508dsWy+zV8I9yPjUBAdU7E4IaIHnGiJIMm+pDQtIh0vW9Xio6lHwR1IPKiJqjQ1L5OlHevANGvmSu/Gh+c130oZHopjSDZsP0dENRSNIbpbtQelNkoG0QqzFvKhKUH/wSfxeAiBiiiBBSVClYMR+0QxF/gbunIlz1h2H4lMWNGoD9kkOKWtVp1qk04x0UwJJJbBt6r+t2+VWLo6sOvAeBglkcDEDrB/eRY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdKkpEAWLGWuJPI5dlN3dzvyPcRrmUmFL+IUfO2REgPqZkc+qO5VSDwE2dpp?=
 =?us-ascii?Q?8T6jaG/U5FSXlBO8srJn55/tGRFdWB3gf6glqy2+ym2mU+C+YEcl17Ve0DXX?=
 =?us-ascii?Q?FalP6QrGoj+IPyooIFFktn3uE/iCfEfbMZsbKyk9LrX3bc7tRWknK0CC1aw4?=
 =?us-ascii?Q?RCGGiNRjSEDTE1FlLbQK5wua4aS9FYYXNR4PadV42TasxaZvz9g2gbVuoGg9?=
 =?us-ascii?Q?aOoLQnROZ37GPL0OqtkwpEIMDkXQT2MST37ql3nr8ms60QfR5Io9jyZpGicO?=
 =?us-ascii?Q?u6BB5NWT9uUcqXd2KMJLISB1xGe6ojIRjgqczBLoOLlArijYkRkVFrv5LnBQ?=
 =?us-ascii?Q?yd9eStOkZeZzm896lK+i56RnK8RnlgGW2jvwdiV2P38HYnikSyMuItu3eAW3?=
 =?us-ascii?Q?IYy9gRIrMCXJF8KAuTcC7PeR2EpNbSOiRQpMEBBctrDLUfVGBqEP9kiuRBv8?=
 =?us-ascii?Q?84Qxi0gic4QhQ6vqjYBHSgfwcR2HDTUergzekG3MOnO/DNc5fKILSS5s/lqt?=
 =?us-ascii?Q?kbzpL9zfukeURit8om9fEav3A9u5lMVejwwHyC+rhVHzjmF8c/ztA9D+KuQe?=
 =?us-ascii?Q?YgrEC0lR+SYQl5C6kfW9lISE5ElHLoFTNvvS3WITdNAU2vETZmNJEI5ugK9o?=
 =?us-ascii?Q?RMMUAQTCkHU7RmIFint3K9n1Mb6wEDFxnpi+0lYunSU07Lm49XETSvaFsk4U?=
 =?us-ascii?Q?rdDGTLuUArNX9mNEgEnG0IJZsyDdn9Kvn/WNBomw3Tzkjtj80HhFlI7KAWpu?=
 =?us-ascii?Q?7iEJOj3idRg7tMrFTuK7dr6QJGJEIyTYFH/XOkETMkTcPG/Z04XwALheNyR1?=
 =?us-ascii?Q?/evWn7V9MKMjITH7ouUz4xL44WLR7JVEmoG0d/fsuXnPSBZuZAEK98YwOXuR?=
 =?us-ascii?Q?yVjSOq9IHkdxQD4x4jzVz24u7eaVUI5yvshMy/nwMse48J8xXewfHPto76rb?=
 =?us-ascii?Q?MCEj3keuzsSt83ws4UKCF9yhRjVNwhbMm4b19bwXa9dZVSeqFquMCor45vM5?=
 =?us-ascii?Q?6LIJAjGrduEZzXatJ7tAzr7Ih887J4avneAt7gsJlU6E41lrYl/zq3f08EBJ?=
 =?us-ascii?Q?4+bQclyUDU52kY0TZx58tDxQU2x8wkv+byL3CJNGHerN2NTCBgdrht3fdHyi?=
 =?us-ascii?Q?NwZkRXSH593pkuHP5KO3/Wkhasntkv5TVXEegWgzqEUwe9aDuLxnXGoVqcL1?=
 =?us-ascii?Q?5ea0GL5bbYuTjlHw1I4lR+LJel4cgTO1Lpondewn5dcuXszcnGlbSM48UuIU?=
 =?us-ascii?Q?PfK7XJXDozXdMSvyQH4wgUidGM6ski16C1TH1qf1Ua4RvaScNX3PTJKYswju?=
 =?us-ascii?Q?4cOk2izSktDwrwRUyBPF2KB+TKX4B7g7KGcw+Mr3IQKdWJzeTIMWslyLv39c?=
 =?us-ascii?Q?9E56zNpgVsuswswrrnBIFU3BaLQtmPJGrabeVr7nUJSwIJCQ60Lp2KujTsjD?=
 =?us-ascii?Q?2DgZHvcHhSm8BxeIzat83UHo9mnt59IrE6M/R03z237yHuWWnz3OBobxXGDd?=
 =?us-ascii?Q?e2cO4Qb23aK7fjkeajgtIBiELpqOU77rh/2iasz98Vba//1pwdz7mAZD1kPo?=
 =?us-ascii?Q?b/2y3I6C5IfjJD0dkCfYTuCFmSB4t7h3gxE9HyUA3Mfoj8K6giZWsGtBocF4?=
 =?us-ascii?Q?At7TjquHqlVeUpuF1C989G/65M9DAosE4V9T0kDT18zCzQD+cEKork63QVnQ?=
 =?us-ascii?Q?9SoNsKOAQk84xdvBxLSAvcd6G52/+x+5ogwHtNgYqHBTM5wp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6390eb3-1189-46ab-a5a2-08df198adb1d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:53:48.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3W6rl+j7iYFF1e6gaLN74NzbDQTsREoFIOg7Cri76CKQuuGKKO2fTe/ywlJ0RzQ7DSjGsAk9FT3ZUqS4oVsEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC

On Wed, Sep 23, 2026 at 01:15:04AM +0300, Anton Danilov wrote:
> @@ -711,9 +721,15 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  
>  		if (!skb_dst(skb)) {
>  			DEV_STATS_INC(dev, tx_fifo_errors);
> +			reason = SKB_DROP_REASON_NO_TX_TARGET;
>  			goto tx_error;
>  		}
>  
> +		/* Only the branches below can derive a destination.  If
> +		 * none of them matches, the payload protocol is not one
> +		 * this tunnel can carry.
> +		 */
> +		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
>  		tun_info = skb_tunnel_info(skb);
>  		if (tun_info && (tun_info->mode & IP_TUNNEL_INFO_TX) &&
>  		    ip_tunnel_info_af(tun_info) == AF_INET &&
> @@ -734,8 +750,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  
>  			neigh = dst_neigh_lookup(skb_dst(skb),
>  						 &ipv6_hdr(skb)->daddr);
> -			if (!neigh)
> +			if (!neigh) {
> +				reason = SKB_DROP_REASON_NEIGH_CREATEFAIL;
>  				goto tx_error;
> +			}
>  
>  			addr6 = (const struct in6_addr *)&neigh->primary_key;
>  			addr_type = ipv6_addr_type(addr6);
> @@ -752,8 +770,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  				dst = addr6->s6_addr32[3];
>  			}
>  			neigh_release(neigh);
> -			if (do_tx_error_icmp)
> +			if (do_tx_error_icmp) {
> +				reason = SKB_DROP_REASON_NO_TX_TARGET;
>  				goto tx_error_icmp;
> +			}
>  		}
>  #endif
>  		else

Makes more sense:

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 66cb0b86fa79..20b666fcca9a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -725,11 +725,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
-		/* Only the branches below can derive a destination.  If
-		 * none of them matches, the payload protocol is not one
-		 * this tunnel can carry.
-		 */
-		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 		tun_info = skb_tunnel_info(skb);
 		if (tun_info && (tun_info->mode & IP_TUNNEL_INFO_TX) &&
 		    ip_tunnel_info_af(tun_info) == AF_INET &&
@@ -776,8 +771,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			}
 		}
 #endif
-		else
+		else {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto tx_error;
+		}
 
 		if (!md)
 			connected = false;
