Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794497524;
	b=dcEriE7EmPThboa1//8x4BHj1tPwdCjZZkqjLdhTewyiKAAwSMlLWxJat0Onqs2+hjnN
	 R7UEcVJ1n6gSGpOcxI+1yQCbg2gDrCovrji6oAl4I+l4AWPAq9VN4w8YNDyMpmQqoQYx0
	 jwAS6PGtfxZYIFpoAMmyLn6koZq+KkRfN0+BevVWl3wvhWVdjCuaMSgzxQi/Oa+mkEdKz
	 MKvBL3LwdYhQo+fQplb48kxAglmoSILnsEJ1+2ZP6pNrhTWrC2ekAC7WAsqVtDzv9gcOa
	 N3p3+li7mSHXeixBx7VYiRtBr9mySP314f1dXM81vwsouC5SaZI4Jw9YNSOGOWGDyCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497524;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=frOLO/q2Sja8pMDUHQmVRyTO6+lYxNf+rwwu98QehVw=;
	b=PhphJHL/R4avctWFfqPTaDVljonKLWv2LsZ5t4E7olFw3GpDb9udUEwDEQCHdyQbz4yi
	 pXODPwzJWjTq79VElsWqTc1qUVXwKs+ioV3HKY6xnLb08lXTWCvAJ/JIyeDdnFFao3DIy
	 5xZMPfkfSxzZYJUQrzZu9u+Qsq6zw/pwJ9YVPEoPIn7uPOADCFSSG2K4ZZgpjAX+KSldm
	 0ZCl02mCpeUxwclTiFLjOhz2aY+5CWz7pjSea6lUyvA4d62aBj3QtpbMRCyyXR9SXTK+g
	 N2go2k8jvs0uteKgzwKSotxAWvbRUhU/aebwv1lmMO4arLf9335bBfSOv+JmzwfxuLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="maQe/oMp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.5
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D26606A32D;
	Thu, 12 Nov 2026 15:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20D26606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=maQe/oMp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ6vfcd2KQ19mLY/uzVuwDyhMKI/HTQvOhslkYb8ddspVZS7W/MifKIU37btsAJmhEi2x1NjNDY/cUf/t6eTrP2w6by3T39p0/BlPWwcre7syH8OGAVtmQaiNZfWbafU/h5c6zC16KJRw+C5pzNnPZ4gLE38JrLyH1yWFD/6RbjWiKni0J+K23IedIR40eKRiYmUuRfB24FqlIh3svoxzWISCKWrUrEjKGLV7B1dUGkUyxpECqEtqG03yV2cmHTHT2s1Pp2bfmH5WGqZ3YbjlIPkdlRLOydzMTOXD46F9m05C/MGemzHPSyksjKRXQbejyyHM5ZdBXSGrmb9LxuKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frOLO/q2Sja8pMDUHQmVRyTO6+lYxNf+rwwu98QehVw=;
 b=SCJ8rV30R6rBfJumCfxPNZV1dUSrjA5Hd6j4Dmy+r25mQC7KywJDhUeFtpulnyXE0SJJLgTu6fnBn5g+b620CmU+XO0hXpQRu2aXUcKex8Lzo9I/AT3qOEWo1HGhvQKxqL+PJuAzCtRc9ggbNtMm1aJaU5k6uTnb0lWA6lCYhRfqbLlCCoyQdvPZ01d/4qsUhF84xrRk50pCpUrSrmMRZD9WLEl2uNPEiEiimrUlaqoRLwrPGqL1tshPEyzsrbU1BSXjk5Onh/ubAa2pqK01htbmHulBpTwxJ/hNIEHRtyVtSERU+u7phy63MTaEMjvcuT1B9eKLgBsQrHBKb1EvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frOLO/q2Sja8pMDUHQmVRyTO6+lYxNf+rwwu98QehVw=;
 b=maQe/oMpRSorNgPtY9AbqJ301WjxIfgqUuGlEPQq4dKnum0TQ9FWCeUQvHyrAN3zxM8rqdJ94HEkTR4OE1z49mpieVHG93RXE70ppLMmoO2tvICDiocuw1JFnKfjCfL0PoPp03ktKMSx5WGXzgTIIxJqtp8LtrhDq4SQ5Gawt8D8vX2elOfLII+/rL0SDalUAKmMosVmGMQahnl1WMuTjVsmSXsjpyQJs+bEQWTweiL8uk/ntiZZyRZuI+UAk9xrjr7VfcID/nzI3nxDuWI6l2vQVK/Q0ZWTAvQgAN+rIchqFcF4lMNmELhIRAz+rll6c9SIU1/o0UfQxvW34oF35w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:31:46 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:31:46 +0000
Date: Thu, 12 Nov 2026 17:31:35 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/3] rtnetlink: return EMSGSIZE when first dump
 entry does not fit
Message-ID: <20261112153135.GB3255418@shredder>
References: <20261110172925.3293312-1-stephen@networkplumber.org>
 <20261110172925.3293312-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110172925.3293312-2-stephen@networkplumber.org>
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: dacaf81a-34e1-495f-40b5-08df40d20f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|4143699003|5023799004|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	+OgmUU6uBLwzWM/r13FSpGG7UqF1wzmo0+e4wrBuG5+tZoI7bAQMdkkPvmEXTJsT/zZ+6f9uStZGBgFwu9Xv0GaIbuphyKP8GtaClBdVwStw7YzDEO63P6A9LhId40o2Ap2drB3GdV40ysx0XnwqcZzJGwmXNdUIIWnQen1xW7Gl494tg/EGcg1Q1xcAcKb3/T/xIMyFbKW0i70UPuHRHojktphxyKt7zfRypnysdo/NPXG0jKzRBV1audR4Yam8VYwoQ4AbSgOcsfbEHPAFUF3RBWVet7u7DAM4I/rZ4KdVSTDUC4mlB0XDudWGtt3MOwuuzz2rammv+cKV4ydsNoXPNn1F10MOV15tP7vL/EL41OlW0oFQfOXAAv9tXS05jukKpfSG70osev6eQLPhkTWFGxl6gUVRfVQoeWsiCtxr03JGJ7KEoiWrJ+3K8IxjENExZxHrFx+8xq27qmBUNmJQ0qvgTDwI1OV8Tz1A2CeFNjwDTzCxxsMUmCQBY27M5KCubl7OdcBzuW9Qo/J7vBsOlj8DGn7t3PaC0QZn/VGOCtIjlHxxCa/hQk/FxAA0+4jTNLN4xGhk/cRefgw95769qR14njCVz5VnOi4YOuu532HIY9Rw/RH9F24lgBGupbfV7mcZbUcShRa55u2SXktM7+HS44EQiG/kxxasoC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O/4Z5yvwr2Fkoa0ZY1O8dCikBd/p4KmZIhTIGeM3f6xXFaM26s3OcGuQ60on?=
 =?us-ascii?Q?5ir/R0ptfNznKw60dr8NixV/ttQQTEhQhAH5UpGaZeNR0MmU9FY3nKzDFh6k?=
 =?us-ascii?Q?KxRigCql6E4Cew2MalWVBjjQhc0lMfPdeNSnPmgughNa/5R+AG5q9/Kp4xSg?=
 =?us-ascii?Q?5JJKAsbSN9/qscjBBD/vPq6gWnhfAm+w2x76qpTLMJnrJEdZjruzCAAueyeL?=
 =?us-ascii?Q?L3OfXJBsyPI+9gwgCBRHH2s8nBTTWSrZ1ERhW/CXaLIdyIL6lJq6Hic0DpHM?=
 =?us-ascii?Q?Lyyifu/9R9fN63SRU7tV4/wFFR0TUnm+4n4VQnh8Ahs7//fSiMzZ/hrSi7+H?=
 =?us-ascii?Q?zxzIiKaA/iV0tqB+6lqS5AFd4gSYWE3qVRg1yftt5ugu32GB1vl25sA1l+fS?=
 =?us-ascii?Q?mEh0/TFjpz6hNU6R3FdXELO2yLtECbhGTa/nGj5TR5Q0g36A9aCKtuxv9tSw?=
 =?us-ascii?Q?Wzneg2QKu1UGtYlySq6NW1Mp+qvD3WeL99Z7sBVxTTmC3QYz+uHkdq6H9ZXT?=
 =?us-ascii?Q?bn8OO4GhP1uNX+nn03BIsIXpZB4v1Vu6EFkJESYHyqmxbYu6bo2vCy1pAkzA?=
 =?us-ascii?Q?TGcgAKoVkZe+0cZwDip0PSuN15CZv0P1L2MmfQsSzO5P4DxuymQrJ1XmdKwT?=
 =?us-ascii?Q?VuhdtSO+kb1hNLr4dgwg8eTymAc58eP7ir0s16gdFk6Cs1L4R9I/Fj7/IvAW?=
 =?us-ascii?Q?RmFvGRwqnKngdTxAJiJQbHn69WeMRFhYAHNaYDnp+fmPxxrhZHJBjF+lUw4/?=
 =?us-ascii?Q?wXkdTnXdmPYSl7Ef4tD1exWJ8tA6e27y4p5D8O5rcqA6lghyi8moIvoYXGaH?=
 =?us-ascii?Q?1K+uR4oWH1FbM8FJ/q6Y5nxTaBnR5NUG/W6QJMp0bWJ/tFq4f+pKn3udrleX?=
 =?us-ascii?Q?xpnTPUJ4Ii7m6PayLhK6F2clFqxtRj8qcAk+TxzuGtiy9wdqxjJw/TRF6MsQ?=
 =?us-ascii?Q?avwgCntAL9FomTxIavueCO4mx5uQkldvWJp/+tsQgYxjggo6t+2E5ooojvwd?=
 =?us-ascii?Q?jGAxlao8w61x5wGNEvC45QiG6cZPpmgGYNC+U/jzzKYwtE02ObpagK1kIzuN?=
 =?us-ascii?Q?HQZxvBh2NEFxG2o8C/rNyP8SW3iD5McmJlJ/bmpBGOIPjKL1kFIcK8MHvain?=
 =?us-ascii?Q?WsmycVjKBMHdXQboug3uSNO9tAlsFAqrZT8GU72PbRvvA1ZnS9goodWBHo7N?=
 =?us-ascii?Q?Gj4+hddMnLEEC8EpUVKbq95jwAp6JfmZg4Fo93Z6JgD7VhiWgJlbRuCXqTh8?=
 =?us-ascii?Q?HPnoXjiQYBQ4U1Li10dFD+TMZwLZX7Z4rq2oyYf/U2gav4MRkBHtdLExYzod?=
 =?us-ascii?Q?azF2YfVteum8I+q2BEk/kgX8pNXqDivzOpjANY9NIJJ4KfJYvKZIhdnOMMGZ?=
 =?us-ascii?Q?uaPPaU7zkgLE5VdKk4iYeVU+63PLc6fQj6xpZW/b/brYGI7ae34GX6FXzcTk?=
 =?us-ascii?Q?zhG5xni73mhgB/5/qsZy2ooGPl7i64/jcSrUOgS3UxnuIWBQQSiPnmE0D5W3?=
 =?us-ascii?Q?p/XPP3aFfTe4yIdWoIVqQNUTWth+KHFpszV8+ciUAgAjfzJ93gD21I8fLMb+?=
 =?us-ascii?Q?99MbC3DZn5DtFxunQ8bpwal+0RRZ02iyXOOBQJAjgEW1NFg9tDNMJLCSDocR?=
 =?us-ascii?Q?pWEdIDe+GII3AvWFzANHAdrO8Jqo6T8bFfXUMG40ACl2lcoICS3xXBHBv/EK?=
 =?us-ascii?Q?I2lTj1f5ZVYQwBEbZG+6MDhgrjq64VX7i7uzTQJzMhbF5gYW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacaf81a-34e1-495f-40b5-08df40d20f8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:31:46.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wyh9UC24ioFe+aDc24urTxzFv8O7rsf6QjjeUYe8YYuH80r6+nb3JwHl/NuEuyJWUO47nYlEgn0z81IulAnjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923

On Tue, Nov 10, 2026 at 09:26:16AM -0800, Stephen Hemminger wrote:
> If a route entry is too large for the dump skb, the dump is silently
> truncated and no error is returned.
> 
> For handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE, rtnl_dumpit() drops
> -EMSGSIZE and returns skb->len. With an empty skb this is 0, so the
> dump ends with NLMSG_DONE and status 0, and the remaining entries are
> lost.
> 
> The first dump skb is allocated from __netlink_dump_start() while
> max_recvmsg_len is still 0, so it is only NLMSG_GOODSIZE. On a 4K page
> kernel that is under 4000 bytes, and a 500 way multipath route does not
> fit:
> 
>   ip link add dummy0 type dummy
>   ip link set dummy0 up
>   ip route add 198.51.100.0/24 table 100 \
> 	$(for i in $(seq 500); do echo -n "nexthop dev dummy0 "; done)
>   ip route show table 100
> 
> The dump prints nothing and exits 0
> 
> Only ignore -EMSGSIZE when the skb has data, so that an entry which
> does not fit in an empty skb reports the error to user space.
> 
> Fixes: 5b4b62a169e1 ("rtnetlink: make the "split" NLM_DONE handling generic")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
