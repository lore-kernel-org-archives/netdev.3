Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561184F55A4
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790226; cv=fail; b=A0xmKS7FZURiB81kxxMoWRPq/LW1QFZnEbG+kNL+k80YuSYCv/GdpEfIZhH3KWerCWCYvPHL/duzL3kUoI2cdisFjZcGgXdCE3vaRsd3dRQHNGRXvtnRXnHPZOk6s/Rzb/gRSPPtIbNWK0z0CeiiQu1ZxhUCVvGBykth4Y4UXoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790226; c=relaxed/simple;
	bh=c7gP3Eus7CSHcJgYe9erluw7m6vvROwzNO4syskfIjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PeEyaDw6ScN4DSwX+fQxMAKHARQqOd60GfjAbJhgFYG6i/OFA3sz/JuvazlHn311VEN0g6p+mjavPvbF9T7W7Y6dcUPK5dlWXA/GQC+yXiIxl722ND8pC/Exm3rgOeUE9AvjmbhT8SL3ldoExNZgzBe5vN+enK75daeGDPBATI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwvMdRS3; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwvMdRS3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liTEYwQ4BCgJIzZuwaOtBnm80+oxAjfr4isnglz6NnJd621v2o2JLFhQUJKCQgYc5qvlOS5u8SdiWLyQSiMEC+7v6QWHZINHLya68luWb6QbZsDYM52q0pYuR2sfcBYhTVIGwVKGrQ9xqUjLWtQaaIshsB3aq9sn2IVZ/mzpLJ6Qn42Jf60eUdR/4hGGFW5cil4Uioa2m+MPR5ul2hCcAFNccbojMD+Le3QH3N3flPxGtg1Sijsf42OrxiVz9wdzSQsIN2rQZgl9BvXJHRqWY0qt+yfJRcP8Q8uItmSlNnGS+XsGZsBy9X9JWopskUeTiUglZaUaovqn+E+IOURQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7gP3Eus7CSHcJgYe9erluw7m6vvROwzNO4syskfIjc=;
 b=gNP1ZN4tKFfT/yF6v2I4l9yZzd3AjUzVK5OQZyMwcAnT1yWsoTt/I5e316hAeptDvNIiE7dveNbhrL6DtkltPI5gBMihN3l05ccA2Rbc+0RpPwHBpBr3ug+OftCvru0+dq6QTj4aL37herIJ5yySUzNuxcZvGgIF/JQtgrysXlTwi+fvluQWZizhEFTZQkPI/BrwILhylK1IGJ0Dy4vmCAB4je2tbeF+6A1eBeTZbbWvqtmfynRDMot8t4gmWZ7Vv98ND4OQKriJyLXtSSI0LJBSQ7ae/1xoywfZ64WREho8TScm4s0r9jRodu392by7f0ujmfUYex+uOrwMqvdvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7gP3Eus7CSHcJgYe9erluw7m6vvROwzNO4syskfIjc=;
 b=VwvMdRS3wxX5oruxMjXNgWZta1KU2ozu25nj1g2BVOywv1Z0KfHAiDoMLDdkEygkPuUinOpYSdwkizN52st++IgXZMuK7XvPgNqWaSltLtBARD8euorCBZ7Pwp3kWT5txRZwPeHiXUbAjtKbAzzixy8VZG46YMmygOI1jVvwDNGiXfAwxFfECXimeBDZ0F1XghgNZ+gq0zN3BLWVleHtxGj1v/Hbo/Tgk2ARuFXgxFGkANSVboRaRWr1y+y40gQAyAHO/tQiIdzCEbKSiaY5inphtGiKf/nPely+tw7RatZ/lcbgzhLtMHYHQdHaIInw8hkZ+FUa3XR2RVBZhVoP9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:10:18 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:10:17 +0000
Date: Mon, 7 Sep 2026 17:10:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ali Firas <alishmery18@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net v2] vxlan: vnifilter: validate the VNI range in
 vni_filter_entry_policy
Message-ID: <20260907141001.GA708129@shredder>
References: <20260902154609.594009-1-alishmery18@gmail.com>
 <20260906231609.2995559-1-alishmery18@gmail.com>
 <20260907105223.3960496-1-alishmery18@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907105223.3960496-1-alishmery18@gmail.com>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: df2a93c1-2667-4bc5-9e28-08df0ce9bec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PCjkPUfM3q76SFoPDVmIkAO2EEQ/l+im0QB7GYW5CJ8S7WfeoeEMrDnaE8YNIOPWekDPY8ERz+68R4uqiWA1oivE7J7aDrPQWa89ktY+46xJQ4E62YVZLmcmgpZrUztGXA3Ii79BuoPXMpuCz4ARFjGH3zweLsbFA6H/dpu6CGa/UIlOQyzPamHya8g+MIpjMLjhTS4AXTTQetqECxf/y6omSeK5UWzsgJ7EVzSqdn/UkFKxBV75P5JsS+q+iV5oXvpsfxSdQ7kMB5BKwc2T73QX2dYbzIwn1o8TTCAQ3K9F8PyYFi2X2GxOp2J/kJgtyLJnookI2MaQggbTedVnZ7k2vzbObtzMlGMGOthNFnFTGDM5+UGRgb5jqHXbOq2/AVfwI4mrpOoGIqI3EEoUBuof0I31PabUvm+AlI+tBWBnkvhqPKbrSOksSoQ8SZBpf0zp+4jrjEyL09DDG/oW50Dt2d+p0mNl5fYJv00hmObDFmNnHYdMNga3LeX9N7BVAra4KmHLDK3v7rk26DSNUpGqAGEyCL1sy8VoTRoekS+MM7LluhMbIKbzV2dtUN6uYXZ2wMlJTcLPoHd8r2IsV7TvQv0T/BdnjP8vuIt59TzvZmz0p3hOp4u5ZmiibqDnsDi+me3rAnfo+JpuUxvEgdMbTTOj8Vrs4Q097tIBIwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57jCRHViIGPk/LYlKBhr90twYxHRqjg40ShXhqSYdGtj2XJn6/P4okWlHp4h?=
 =?us-ascii?Q?UJpc+nf7AYCPxD6/mCo4CLnFez4QMe3nHKFSte9xEEgkq+Qvbr9r+RABAH3S?=
 =?us-ascii?Q?YvXzjmTwCXaCZjbe+gy9s0KKHfgcYSbd+PKdr1RNi9SdmRaO2kSphqj0dHW7?=
 =?us-ascii?Q?jrH7jP4WUDU958tpXE2HSNlqsNajRHNr2nbsOwj5JzpvVgAsKh3zlM5l4W0z?=
 =?us-ascii?Q?zXNLmwJhJREXPBeGRZhtgu/4A0eAJAM54kPbS4CPeRoFi5B4HSdG8vM/AM8s?=
 =?us-ascii?Q?TDbzJ8I4dSaOTxTlr4zRCeUyxP9dTSnbrFwaDd4MtA4APd4hxYoxnzscWV1X?=
 =?us-ascii?Q?9Zo3PoRvv8hnpzkuP0JVOW+BlIXudwUQ9O6nKFGL4gfpP3No2zJKD3uCRFFH?=
 =?us-ascii?Q?gK+h1MuIauBsIf1dtB0JFCTgtPGvK32x/KpwsdDd3Gcx9XLwrDw+c8edKITR?=
 =?us-ascii?Q?3iHDXnBJ6iMCXf2xHT/S+gQZeROMO8k02bRI6sm9GUhYR+6B0kk+/jfc7pLM?=
 =?us-ascii?Q?h/puvl8omgMsG7skVsl+4rcePjc1RuD0E//ggdtzZMz2rW8uxlvldKAhvKuf?=
 =?us-ascii?Q?FaF11uGOy5aEzmNjeimaWDCI7rGoVnsTiz6Oa3E295TKf3IBAHmK141kNIYm?=
 =?us-ascii?Q?V+nYoovsHYIyKwTrnRFvt2LihfBkk+l4YS/OSbwP+My/wr6vZz7rE4LDEZzs?=
 =?us-ascii?Q?xKDc+NIjg+EibXPv1NSLnUlaw77enht3PWBL+r0Z0/K0zRTvb0m5MzqWq7YJ?=
 =?us-ascii?Q?hu2wbLF5xyg5Qa740uvJZBKim3HFRpV1Kw27erulr9DFzrzpc1nStk/QKCrh?=
 =?us-ascii?Q?MhQAznWaCSuxZbovBXzDLqbl4Qto9SDnBjLL7RvCE4pfcgYKvB5bjk7f7Mqi?=
 =?us-ascii?Q?LavwoXLdVd29zL5jA+UUqxmJ8HFAZ2kqiF918i1P2QP0IPg5NjWKncqc2zhR?=
 =?us-ascii?Q?dXqrtLNx45cN6kg3KZ27THwmxnbmVop2etJLszJhjRzNQKYR43SfpEirCI5e?=
 =?us-ascii?Q?JjRURwcbxSjOCK1AzCoBbqssWOkWOAm4Z/UaKeqf9csfv+7KYkAoPIUMt3Wc?=
 =?us-ascii?Q?cdsaJWWhJWf9O1Sp4EljNbcf1yk60eg+lwgXNwiwbxmY+XREe4P3DAm5o4GE?=
 =?us-ascii?Q?b8kV+uVoltkAbo9vI78xV1PCSVziAgCDXoQh6CJgtTznCH0zJgohXOnDwQy7?=
 =?us-ascii?Q?cHrc5jvwvnKqSEgv9YCqCkLWwMfCk0euod08xjJ8GTKLwRp5TX+G8G6NQCm/?=
 =?us-ascii?Q?EQFA1VdljFqtmeRBsZ8KNXrpxTgKolntn5WSvgK4iG2nEn9AVK7eu0BtW9oQ?=
 =?us-ascii?Q?WApvNXIjIAp3HueDRg7OcTK8NcoJdFy8lUVcmfrSXpVCprXTtugM1Ix7sQCp?=
 =?us-ascii?Q?Ykv+HPhdAzl1pFmeB4jp9X2rhrKvgGDLg52iQhcjcRXUS9oNSPAUvKuRBLHP?=
 =?us-ascii?Q?VhzVwTcoHHS23roHeCaT6DRgvHlWmPQkjhM6lwj6+TfW5lRHpBTEyx3eR9K4?=
 =?us-ascii?Q?0NKNLBa1ZUaKxyEK0K9l0fEwtbfB0uwnoGlRp1zegeqdUrSFSeyaDqwOUzuX?=
 =?us-ascii?Q?52c2MseQKIhczLO378eymlqEu5+fLNqQee1WAswaCwW7HlIOe2+M04+ZLokm?=
 =?us-ascii?Q?pNVJtiZrxHE5P7qiJjcvOgsLZONIApkiTJ6jSwOpH7yUoTlgnEJ4KZsq+bhO?=
 =?us-ascii?Q?PJWDC4LbbncMh5OUXpai/bur91iHbNMZ7M3w7koJb3FVDFPW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2a93c1-2667-4bc5-9e28-08df0ce9bec0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:10:17.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lixOsmOEDLn4BW1DJauCTdg3YYM2m1lNUZ59+RtOlZ8AKt6Ng4DldRamXPP9BfEBJhBsvQVdUYmeRQJ7gp035g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

On Mon, Sep 07, 2026 at 01:52:23PM +0300, Ali Firas wrote:
> So I have the accounting patch ready, but I would rather not send it as
> if it closed the problem when it closes half of it. Would you prefer the
> accounting patch on its own with the rtnl stall described as a known
> remaining issue, or is the stall something you would want addressed
> first, in which case I would need guidance on whether a cap is
> acceptable at all?

Limiting the VNI range to 4k at a time is unlikely to break anyone given
that "vnifilter" is mainly used on bridged VXLAN devices where the VNI
is derived from the VLAN (max 4094).

There are no selftests for the range functionality, so as part of this
work please add some in test_vxlan_vnifiltering.sh. At the very least we
should make sure that the max range is accepted and 'max + 1' is
rejected (for both add and delete).
