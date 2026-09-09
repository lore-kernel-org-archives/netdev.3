Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C331B82B
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936690; cv=fail; b=TzMN1SM8f/sDMyhvM6qrmezUqehqDdTaN75xu5uYxHLo0IBV+LEWB1XMveubSsVQoptOTTrKquhn8f8wc0Q1JX7Asl6ATrZlUDD3GN319uCEwYRnCDfDPI/O1tIK2vCZIhhV/YyqtOnKpYeWq0Fc9WdWgt7O6cvtzNlOlC/2Mqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936690; c=relaxed/simple;
	bh=KoizdO4S/gxrf0r5QFArH87EitLRQDgItMwQV/n7+aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zb2Dd2G0KfNB4PjJQiEilIJBi2m0xUHqSJRCQS05rosWvPCzz1vcSo/D5tbF0/Cuwojl8JgaSyC+BAk8ZOx9oRyOEK4tRiY9oQ2M8z1MPG1FcBmHgt33POA+sVA0odfhWQCS929QWUFb7t9AnsihBRJmwB7LbtG7WJ8QND7j5Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pCDH2wck; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pCDH2wck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoIOucJglpvwtJs5kmM/I3jrKBKQbpiff3AlSTnytJYNp7tAATFDvBupLr0aqPM/2KYEGIbSlFI+GBqUz9cKOz7m+9OAcPJrfQH61eSsQjUn/pc/bt2kMJAIan1OS9GepbaPZrUzcGYW5cAb1e9EphtQs8BDvfnnHY4d0cL2YgmYG6/p62JAmXEs4Bosk/qRLnKIDAy2JO3DHwjklH8keFo6efcPJOBq7NLkd2HX+kIcHLhfbqUyVTZ93jcSpd1aMif91fTbRxib5z9amnDD77XmAmJo8Es89Ts8UPVkGdHnutov6JGKLoVQK7eApLgP1jo+OvUp2qQMyQE9B5N/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rnCCMyLDL9KCIyIjdv0v7ixlxXAUut6Mh+iM0owwIY=;
 b=UKZIHRhCk6et5Vw+lnR/kDzf8ZvZvpYsHBo79tlYHeoQBKsWO9SK4Elm0v57YcShq5uIz5/FaLxxClYTRH8VspDJcqAZGoRUrYGZbvD0UB5JdB1NZBOpwFuWU55zRnEHS/EZT/ExHr2mc+GqqT9zBgruM0+SkAN+XgAhWKu7x30FnffYJOyTGDmCXTrpaBtw0ER/wy/3Zo5JdtqMebgJJ6WS/sMdLK1FUuixhP8o2Wd4IukYVd2sJJ0C5Jb0fTv78RTucEUORhr5gdlkTTQICf2pGrA79jSitI/VLbJ1BYCHmgCyVrxbEoivv05eJYCF1AccVKmpg05urTX0hWGAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rnCCMyLDL9KCIyIjdv0v7ixlxXAUut6Mh+iM0owwIY=;
 b=pCDH2wckj3H49ypMjFQztseFKi6GpWF4xJ2aUahS3swV66Ey//KmgsYwG1giJXFkjbHYSPcEyemk1Jpr91ToNUnYqPEL5cJbIU6ApVmFIqMLWEQE7WQV4qbHwJfdJDHfHsHbC7lxtbqmhOHq3jW8lB6kf/EHdaSQpXG6tm4P7D5g9rl68PcaQXUF/qGoAm5ru3eBXxcTF0LOUSCJP6dBHwE0FxCmGLiR60VvWXwtIencx/9O4SabwBbf0OgfkLe4vDpQh/cI2tqPBXHoJFol7QWD6jQoFri7g/iCzo+Me3RILiI2iKXC1p24s1CMF7zWPhu8b41VFEZIj5bQ80NuOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 06:51:26 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:51:26 +0000
Date: Wed, 9 Sep 2026 09:51:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Yuwei Wang <wangyuweihx@gmail.com>
Subject: Re: [PATCH v2 net 2/4] neighbour: Enforce min/max to
 NDTPA_INTERVAL_PROBE_TIME_MS.
Message-ID: <20260909065116.GC1183641@shredder>
References: <20260908211419.882954-1-kuniyu@google.com>
 <20260908211419.882954-3-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908211419.882954-3-kuniyu@google.com>
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 219f228f-ba60-471f-9626-08df0e3ec4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|3023799007|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+CUruDEF7SWyqs59KMx5DP8bhz6yzidUvt9x8K2vS24yClL1wdv4ffb2WIMpvX+ILdGqZVX3ZuQ+J9282JB8wIirt4cOZr6lMe45ymAkiJ4j+RuzOc/MgCmgEcBxsq4UAhpWsIdn4PEsnrTDCAlSkpx96i/LjRWvXQW8dF8bnzNKn9n5FgHR+n46U4OOHqlSkzDTR0cDdVbmEo+98HkNgMRUE+vTzr/QF3RHrDXAEXcrofKPxqPlEzLtMK0lSwONS8pS7gF2CqEeNgYcTvsr6BWsIgKlycixZWkrDD0zZvWnyappTTW/ISfGaoQAK0US8Yo9QkidPODSYT1uH+1A5E8kRwD5NZ+INqezTLUYTRexN/Hq3WMYmkRAM5tVvvTRJhdNvj/b8vxy+iZGeSSHTmr9xrNkHdumTS/Hacm4bNhTXyL+jYnWPZBACpn8hKV7U2NocqMMP+JGQW8w9tq5ba5D42V6v6WKST1lA7pWdwBRD7JP6j4hSo81ika4DzIUVoVA0s+rP60wOlfhs4JAJzwYBFCxJRvY25VGnPoooifl1ksOO5C3HiuXk36bMmt3RyrxKxhdSg0jS3e7ifu4v+fkPjTVZjczIuAZoeO69Rq+G00BHEglCfId305No82oUUu+NuLicxgv59DI30gZ79dTnwm1pdtclBTcCG6hG+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZiRHlxzmNIvHm5aA5Jy3t3VolbTM8ywDgY2yZUGo/1VTc3mJ5JCFVXDzgY5?=
 =?us-ascii?Q?ocyQ9LWjcpIKluxLRnVJU2DNAadPvbK0lIlEs4oCTnsL93TnH+bDBOwzptga?=
 =?us-ascii?Q?Op93JnhKYDX9cC8+lv3x/ZeUqsy2YLBUxZkCp1ZSqZJYPADaxLSWK8D27xkb?=
 =?us-ascii?Q?dDtxevzf3uftdSoFK7zUiw/c9jjHq+MADciNFQK3qpvi4YJTL3NnSGibxxRk?=
 =?us-ascii?Q?icURDfTnZ9BdsuP9MP8A4abEL3DCK9PpLPyN9594XDCK3gnk+a8cT4Q2tlxW?=
 =?us-ascii?Q?rGi2eaY+r9PPclVkZe3Ekddv4oO97fr2yZv69CZ80zwOPgmKLevw9pl64HLk?=
 =?us-ascii?Q?xT2F8xcCTL/DId7v5OqywLysoyn8HstuQYL51BQXKQ1aJK9k3QMQ/3szPnKf?=
 =?us-ascii?Q?fW2bEinPqfiL+tc89Ge6pQ62ruXlXY0BhR+rmgtuNwwGB6teVKwX5gb7/ecA?=
 =?us-ascii?Q?AbpcQGLTSM2k4bzxp55GbSfsh6aJcauVty8cX/zYaZ208+MOdOEsOnugVjQa?=
 =?us-ascii?Q?n3pgsiMejBOySRCIZkrLAs6x+qjOR06RcTBj20rzWwsGnQTuEE+4XYSiTY9e?=
 =?us-ascii?Q?dF6Ht3fVY0KDBitAw0M5bRSQdQ0ymNCZBn5U0wpEeg9G817FbPP6rUdOGMiM?=
 =?us-ascii?Q?4bQRELDYlzbGJaBYph/Fy2TfciMvEW278uoXI0U1NcVwRebgTDij4VGyTp/z?=
 =?us-ascii?Q?zylSKBWz4AU6j6lv9gphOqYblEvN8aJQWtsPb6xpgpXye7u0luyZoNMH+uLw?=
 =?us-ascii?Q?grbLlQI0v4AP1oitkX9qlPT6e36sR5MePwYRllro5NEEYbOMMmLZGPSAud84?=
 =?us-ascii?Q?DpJ+xBl62pPdHXZtQXfPooNZqH46PBb8LLrG53/OUrQvqYPt88QUPrs5aQv0?=
 =?us-ascii?Q?tbz4pG8huNTrGEED64oN7SpvNVXdblchbcFyemoYNz6YEwYbM3siCSpqzoaq?=
 =?us-ascii?Q?na2/Tas/7NfXTdfpjghDEiPubIeL9vsxeuy0muc7xowmgnRTnyp9NFsFgHZp?=
 =?us-ascii?Q?w3k1GAuyzqxk1ygf/1RET+DOlUCZ8+XMwO3zzftz0mLf5FEP9yxQBDsZpzvq?=
 =?us-ascii?Q?Keec6oigiLjGbeMZBhcEiUkFotELWnW0KBB250H6mjPpiAwc5fOlMgyW+/0M?=
 =?us-ascii?Q?kyyMgW9JWbdDtN+IGJetCnEIOFBbON88DZq5iHMwxVak5Ua9Va/7gk/iHbd6?=
 =?us-ascii?Q?lRe0lk076QfocLpUzFHtsEEL5s9YMGqGUJdwUVhHGKhpYnnCOHmSa5fjZW9K?=
 =?us-ascii?Q?GVokIWdQjKssUHH0bFiNKmR+wseuE/0kxgwPxj1j6q3lmGljOMbqu0QJoFsJ?=
 =?us-ascii?Q?sl9ZTjVTof0m6aWYVFZIkll6kajkF0fcktNruVwrjkEKs+GlIYez7TX52ZUQ?=
 =?us-ascii?Q?cFT5rJEPnv2T3wrz2Cz8SG/7v9dBsfX+oDF+A6SpmGlDkYI7yVCpcmtuAfpH?=
 =?us-ascii?Q?TCNMP7NIgzuz8qMvMIzPdRI1dIE/mSeB4iiXn07bOkJWdmkDiTXFGBTNVKVR?=
 =?us-ascii?Q?8UuOhDZhb/aMUiOyoBNGkTIZ+8AAXPGhuw1QsFMhYROZ89MNCs5BYuZdVPtB?=
 =?us-ascii?Q?5h4oC+RzXZvLLduNON7d0uMNx1MpD8E4gweFFrOTyYCFipeFWjePOtTEWNF/?=
 =?us-ascii?Q?8dFhVRmeJvmmBQHhH+fnaJvPiinTfmDqMeA06GakK72uSN1Tg3z2US61zf2R?=
 =?us-ascii?Q?RkTY0AYu1ZF6WORl7tp/ybhquoRHZWxvXYhJPIqNyTVGoDey?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219f228f-ba60-471f-9626-08df0e3ec4b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:51:26.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0by40MmmipgckLEtjVnMP9xLsT20XuHFwKSRE4avV6d0RztEFNFxIG7eC6PQpgOqnKpxmeGuyJw+ozvGEjxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

On Tue, Sep 08, 2026 at 09:12:46PM +0000, Kuniyuki Iwashima wrote:
> diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
> index 0f46ef313590..5ec57d95d7f6 100644
> --- a/Documentation/netlink/specs/rt-neigh.yaml
> +++ b/Documentation/netlink/specs/rt-neigh.yaml
> @@ -341,6 +341,8 @@ attribute-sets:
>        -
>          name: interval-probe-time-ms
>          type: u64
> +        min: 1
> +        max: 86400000

This differs from what I suggested [1] and fails validation:

$ tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt-neigh.yaml \
	--schema Documentation/netlink/netlink-raw.yaml --validate
[...]
jsonschema.exceptions.ValidationError: Additional properties are not allowed ('max', 'min' were unexpected)
[...]
On instance['attribute-sets'][2]['attributes'][18]:
    {'name': 'interval-probe-time-ms',
     'type': 'u64',
     'min': 1,
     'max': 86400000}

Works fine with this diff [2]:

$ tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt-neigh.yaml \
	--schema Documentation/netlink/netlink-raw.yaml --validate
$ echo $?
0

[1] https://lore.kernel.org/netdev/20260908100548.GB903218@shredder/
[2]
diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 5ec57d95d7f6..c8e55c98d564 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -341,8 +341,9 @@ attribute-sets:
       -
         name: interval-probe-time-ms
         type: u64
-        min: 1
-        max: 86400000
+        checks:
+          min: 1
+          max: 86400000
 
 operations:
   enum-model: directional

