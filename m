Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740451F5821;
	Sun, 13 Sep 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789263509; cv=fail; b=Z6hA7D1v8GnKMOmsDtl8EgI6gbbmz6ItfSWQ8E5JoWrUt9ksuadmoFtchp1a4uuTqJ/0isgdpWQFn277tMTiSKIwOiZj0BqGnhucqj+xnISGhfnr4IdY2wLymBpJyJ1TTC0v1P7EZ4mgJaoGikSCvPfQg9uuJGv6ZDB+KPeIAvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789263509; c=relaxed/simple;
	bh=yHvHbyD9A+mTyuHmePzTaeIz1KhV9RR9pcHqOvw5/RY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MJWnFfkiZsdUr9qJs5muIG7JN+WqK1Xrmz4ac3ThN0lC0WZsrFYayfykAYtUPeM9a+Zho0RHpAc3yOOGboR8z9TNWd2MX16VKMHkk7ZRNouehNClsdAkYDtHptK9zgDkc5Wn1B84VT7WH3XdnJrpz8esSzmK1as1mi/UPT7zavU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=arEBJuCr; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="arEBJuCr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0sCbD6s61eJnEGKgmwWQnOIFf2FYBi00cCX0c7YwvFOTz88UxJukCe7iphO94bLUTcXoNGzNenJjN0CRzgLsCQ5khmi0O0ukm3CqpSIdsXC956y0EEDFmtvfQae1uw3AEJSfiaZ8F7FyF6v34nD03n1rp2am+onpt+c2hFdwDjTraR0nBukTfa9DBn7vt7H4NoHzvH+dCSyQzoKyNaT1CxuwVFEHYM8yIWlE/TVHkWIsZEHtmbI5D/x9JHnFlO7WNR6hC3MzRmFKY92voRa8SZRkiH2qtx0ZEY6TGwrg3LU+XQBg3F7uOiSD4RaYAy/DOylA6BEMvY/XSlxfshhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHvHbyD9A+mTyuHmePzTaeIz1KhV9RR9pcHqOvw5/RY=;
 b=NYYq0vDjc1m8ko/d4WFU8OJokz6cIHV0FtqpKbCNYKpmnbt01HIi7Vu0a6rxhmZ/pcz2PKwGnZ44zdegibyceSmcxwcs0o0AZxU7zGaXweSfx674kPiV2XzljFyaqgw+zOk2fEfJ5Bf+G5I7Zcn3buCs9tdVQEG7MpPzcoD9BJxtgQS3UIpNaUlDOEs1G+Go6MNQNUPoKy6w5EeCebC2FeR1gy+XdI36Rs7GG4Ybsn5/w0cuAiopsOS1PdrR+XIAEuUbiQL9d5SeNJvatTS2VLLY0BxdsabUa68LfYMyQX04UM6IfOYwJYzEbUViMUXKrGE6PJ4fRWEeOO4viDx8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHvHbyD9A+mTyuHmePzTaeIz1KhV9RR9pcHqOvw5/RY=;
 b=arEBJuCrfM8kEqezutCdB+O5mgBLDuAPil0oLOna5mW8zAsqPk0t44aPrgzzYqV0CowWH9/02fDvtUMXvFcZhyWTOH2KKfPHy2wrGjHxG3paYKz6LmFr6tucX1QeOqRgOLRXbFngdSNpe/uxlZqeRmqy2heQFz3K8UCTLoBmEKeGcpWPq5sWqlD888P+lxtFi6HfAYwIxX0RHJyPWDfO5/wPgAMduiFczabmrDy6RR60RdH8unGuqrDcvtUuL4AVU7esLrETdxqE/EP0ixELCB86q09Z3bMsmVhbz6mwXiBXu+hgxbEQxlrDRLjDkLQm29om3AefE8T4R4D6zECG5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sun, 13 Sep
 2026 01:38:24 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 01:38:24 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Sep 2026 10:38:20 +0900
Message-Id: <DLDSZ4IJEJTV.2YTCU4XVVV190@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <netdev@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: net: netlink: Migrate to zerocopy's `IntoBytes`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Sagar Taunk" <sagartaunk@proton.me>
Content-Transfer-Encoding: quoted-printable
References: <20260912062536.363720-1-sagartaunk@proton.me>
In-Reply-To: <20260912062536.363720-1-sagartaunk@proton.me>
X-ClientProxiedBy: OS0PR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:604:25::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d39513-c060-4e36-73a6-08df1137b383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|7416014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k6GiQk4iuL+MydBL68o0bP+wEoNBOyoRCFWKeSG9LhAHB9BlTcsPKiehM2Zusl4Wool0kxkPqGfN6NPvMWvAcaHX6eD8XSVIsyJNyrdLFzOlcYD3rC9n1owdOxN/psHbX5Q0WBQpzCYHhlTtLac8581IGnqAwa18enF4gNWT3Nqlu82gI4N4ZumeAUWYgCduHYLgayImOvIg4fOj7ZUW7VlaOJBNZHvZb6MZEfI8cjzXIb9XXjDMOIlTtglOIeoXwdYiIjPRR5WQU04Edr+qIx+8mRP8WH+KHZ3YGvzcINXlrfL608Z2hE18C43mxmmf75Q5o7T4HhF+g76gcScL0XT34HU4YYYO3+iiWM4Og1t/8uxuONl1byx5jOObeZCmLahf0++cLrguaS0stHPEQ9qUZJyDpEicU7x6UEG8n1ULti5jro5gcPiYV8i7tRgn8Mv7J0saUd2BlvV13T6z8N1bB1FkskWNUgxxb03eAY89mN0sp8k/xu7zZGHI3BCDs2MdY+daHXTMI7IIWo98wnqVQAimrZolPZQGe83Pu2Uetp83pEBc+aIaqUqNRXD1AK1c+3nW0cu1Jwo9B/VIsRC25hOzSkPik7HFDTqgHiodYXXQ68XS1FDQcvfSG7Tvp3eICnUXZ6CENYpr7UB0zhpxIU8/SWj2zQ89DXId54Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(7416014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVpiWFZNVTJzQ2dtNW5ZRm5aMWNvQ3cyWXdGQU4rM3FBVkg1VHM1cU90SVhx?=
 =?utf-8?B?WFdham53eTMvaTU4eGFDMzJ6UDhuUWJRbjZJaHJiQlhQaUFoNzc1empTT1Bj?=
 =?utf-8?B?RDZBVmozZmk0bENqNnVIbyt5OExUZzJQb2pUNDBkVkN3Y04zV3g5R3R5SEFl?=
 =?utf-8?B?S2JPSU9pSGxJeWpRUDJKQU9ZdmhNeWU4NGVXQmhoWXNwU0VmZ1pYclNQckY0?=
 =?utf-8?B?Y3BvMFpHTUxrdHIwUWFQNjduTktqUUU2UFY1N2I0VHIyZHNLS0V4M0MzK2Fj?=
 =?utf-8?B?VmVOMWNUUUMxM3RNdHJKUTYzN2JJN1Qxc2RiUmxZQmVvQm5YVzJxQ0h2S2Z2?=
 =?utf-8?B?SHpORjc1Ty9uVWZ5V28xMVhhKzVodmMvVUVWdm1tQTYrWHp3Tnl3OU1WbS9t?=
 =?utf-8?B?ZzJMR0dRUGJnUmJFMmtRYlRZeUZIVVNlbzBFaS9rSFM3NU5IUTRIcS81SWtx?=
 =?utf-8?B?bGl4dWZ6NXBlR2xRNFBwdzIzM1Nsc3BNVGZ6elAvSitXRzB3U3p6K1VsbjRU?=
 =?utf-8?B?YUJxMERVZ0tmQzRIa1lrdnIyVWQ3cEpYcHRGcUIyTmJrRnBaUUduK2I4alIr?=
 =?utf-8?B?RkRTKzlwcnZESkdidUk3YmcwKytkekZRS00zNHBSL2VMYVJnb3dMUG9VTitT?=
 =?utf-8?B?cnVxZW9FeGVQZytHTXRjalpQZlhiZTlDckkyQzBNRk1KMURyQ2FMZ3VRYWE4?=
 =?utf-8?B?RGVrM3pSWEtxVGtjVEUzQUdSR3JZUUlzS3VzRHBpYXJhTWF4YzNJcW4xOElx?=
 =?utf-8?B?dnUzZlNCU3IxeFBmbzdSK3czdkNIYytRZW1QcEEveXZzTkFvMmtSd1lwUXYr?=
 =?utf-8?B?a280S2wwN1BTaWQ1aGNUQ3hORklvVU9NUXdsaUFaUFQvWEwyNmtNa01kL3Fo?=
 =?utf-8?B?NkF4ZHFKMVcwczJmTENPZ2t4UGhJODhDbzNLR2luSzQ4aHBCTGxYaUlVRFV3?=
 =?utf-8?B?NFVrck8rdzJ2dkhFUXdrWTFUVG55eGdEMjJNUXU3T29iS0JOcStiSmVoSStN?=
 =?utf-8?B?dEhIR1lOcHlSYVZzNUNDNVIxVkN4emZna3ZlR2I2STJPRk1FSWkralU2TitP?=
 =?utf-8?B?ODVjMDZlRWIyTExVdFN0T0F4b2pDZHhLZHBIU3RIWnB3WUZBUWZWMUdWZUY5?=
 =?utf-8?B?SUxUcENIckZLTk9lN1FvOTV2L3hhSVovSjVPdEh1NmNzcno1U0UyQWZjQXZk?=
 =?utf-8?B?c05tVUxSZjJzUENIRE5uUlllM2N3UlpnWVUwRWlKdWUrRFI0ZFh4U2N0N3dJ?=
 =?utf-8?B?M29NR0JrQklqaTBoVHJsdmwzYmZXbVh4c3N6WEhGMVptNHl2aXFPWmRkOVhE?=
 =?utf-8?B?UHh5WE56V0tjVlF3dlZNTTh6WGpCWEpHNjZudDU1K1FTTk1uOElUS3lOZnk4?=
 =?utf-8?B?eEpWd2lSL1FtOUxtU2N5ZWl6Y2dhdEYrdGgvM1dzNmJyWlI5Z250MEtOMkRp?=
 =?utf-8?B?bHFFQzRFMXhLcWJhOEFXUXc1Z2NiVmdlME5nYlA0aWYwcWd5dVRoZkh1bEJH?=
 =?utf-8?B?Rm9ZSHlaRk1aaVdtaG9yTHZwdGVwcmdqOWEreG9mV2VVa2xLTklURHgwcHZp?=
 =?utf-8?B?ekY4U29IVDRqSnZiOEVmQjNTTjJ0ZWZlNThOeWNvOUhIU0VrSE9Lai8yaVZI?=
 =?utf-8?B?dGdJTk5HajlzRHRpZXdvWWhKMXZMVWNubW0rdUo1T2EyVzZJNTJ5OVF4RnI4?=
 =?utf-8?B?aGdHNjZUUSsrTHNyRmx2L0l5TUgwbVlZYWtkU2ZQa3orc1YzWlZNYmxiYnJH?=
 =?utf-8?B?YytZYzExMVk4SVJNaUNtczhWODFKUytHNWplc2tKcXg2cWg1MjdJKytLQTcv?=
 =?utf-8?B?Y1habTNPTXpjSm9IRFAwbU04N0VXTnNLZmFCUENpREVVaTNMWW9WUWcvMTlL?=
 =?utf-8?B?ZnhzaHdsRUdENTJsRVVzYTBmUWsva1dtRGhmbkM3UjF4czArRXVBWUNmUDQ2?=
 =?utf-8?B?NEVybzkyV0M1NzJyMVdMZFJJTHVCQzVqWEtSbDVKMEVkbnNLWlZ1eDA1a3B5?=
 =?utf-8?B?Rll6azRzdURvazJnR0owSHlGd0VmYlVqZitiNFpqVmd4VlFjSUJjdld0N3pX?=
 =?utf-8?B?NktrZEZJYkRoU2JOaTNqWVpCemZBVWNORWRpMW91UmN4SFBqZFc4S3VOdDk4?=
 =?utf-8?B?REFER0hmK3RtMHU1UXVFb2VnVE94NnUwMUFweGlxcmhiR3lCUDJBQTBrZWtZ?=
 =?utf-8?B?Q0NTYWhTdE9TWHlzS0FaNlNWQ0IxRU1XTDZoWGlHUTlIWXJ6cy90b2FzSHNs?=
 =?utf-8?B?bzBhMUpEZVFRajlzVWprZWxMa2NhejZhUjNOY0Y1YmlOZkdyblVDQnNOdUJS?=
 =?utf-8?B?MlJzb1hxdU9qSjVDUzRDVnpGblNLTlRQUm02bWJ2OFpTMmdtL2VrUWJ2dFhV?=
 =?utf-8?Q?RdUvYb35e2fDICsuIELJXcLdOmvxyc+l3/gJZYYWJDGlo?=
X-MS-Exchange-AntiSpam-MessageData-1: f+kYqVlM6iq9ew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d39513-c060-4e36-73a6-08df1137b383
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 01:38:24.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehiJmkqDwfaXXrNMIrrIa3mLavCnmn6WBGVOVtoLOfVAYpfpMt3SX3XTTIVX2mPW5BVVccbt8MjCalfEsGC5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142

On Sat Sep 12, 2026 at 3:25 PM JST, Sagar Taunk wrote:
> Replace the kernel's own `transmute::FromBytes` and `AsBytes` traits
> with their zerocopy equivalents. Specifically, this updates
> `GenlMsg::put` to rely on `IntoBytes` for converting attributes into
> byte slices.
>
> Also, add `Immutable` trait bound on `GenlMsg::put` as zerocopy
> splits the `no interior mutability` guarantee that `AsBytes` bundled
> together.
>
> Moreover, shashiko pointed out `put()` trusted an unchecked `as` cast
> from `usize` to `c_int` for the attribute length. A length larger than
> `i32::MAX` wraps to a negative value in that cast, which can pass
> `nla_put()`'s own signed `skb_tailroom()` check and then be reinterpreted
> as an enormous unsigned length via `__nla_reserve()`/`skb_put()`, leading
> to a kernel panic via `skb_over_panic()`. Validate the length with
> `c_int::try_from()` and reject it with `EMSGSIZE` instead.

The conversion and length validation are two different things and should
be split into their own patches.
