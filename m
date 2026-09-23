Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038C47DF98;
	Wed, 23 Sep 2026 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165975; cv=fail; b=EwpdNUslsTe4opzzST8IAJoL4ZDK0oUB1j9OFkawFagVi3SseQgWq9/7wxNRGir3VPjywQCKVjO2F/4D/3SwLsy/pCI4lHycS3Z9gt0UGyzUeKBkHBuUX8arM50yehbf+ugEuxn5ZegKNAAcBTpL+sJ9WQs9eeNyvQ9YhjyOut4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165975; c=relaxed/simple;
	bh=PrOrhVY0crhUjqF+Jucn9L04vqR+uC75nKDQra6BA24=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=jMVG4KBHgvSfIz71f+M8fNYx7ZXxOr3Sr94Ots3CxBwh/50cnFp7H+Uov5Qk2NdVeG0vRJ+iHKsSeiRauWRN2wvpd3mvO8JvWKLJiHSa1eKOY+NTVoXFBsg2N46tBexdit538AQifYViQIDljpPMWwB5nzOFuDeHD0CMlsHkNlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NvXZZ1r2; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NvXZZ1r2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTY+3G9ZoFOjwTANBaXPcuJvZV+c6hEAQR28kBsL7Kag1uSsMiyoA+ybJJbtS4nIY79gJ4eZH3M7S1wSNro/Goj+Dl5LjMnpeW0/R9vLpblS5rOv3H4ikd3I0mDgiFQLAF6UfyOLLX1kreJGPEQ53kQXcghikKvncb5eWmBY9R6W3MI7vxpRWc8NcTYVJlYhDhs0zmbqziYJbEWuAdyBnvG7hb0QRnQ0uCf0pBoTbJUJve7hmmRSpCcHp44/U9k4XHMlciYTyoXogirzeWzH0nnh0dHD5e20DL2vbRlkdUwb5ubUmJOj+gSibD+HOQpdvDmcm8yqld+8tcUkXecrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrOrhVY0crhUjqF+Jucn9L04vqR+uC75nKDQra6BA24=;
 b=Wx/Qai8QaVNixyz7NYVn6gZ6YcEWmLxxyXwc5C9c+/nlyuJE6EFnxYqFOhMmQFgj5KiRu914TIemBkuOijShqNchkwylc73dzf1ZPwcmwe8VCnm2d70Udd4cyXvZwpbiu4Y6MggQhEJx9U3kcZl16TuVXQ/3ZZBAP3ESOd26vDnpFRb/7AUnP3J3N+EISAppDBUk81jVG0aYe11gsmmujI7+aPAW4w1RV76ux7x4v2ZkhbRQPT5dLXkQxV2EAUuPpc98ZoCnd5UebDoPd4bCl6n9rS9nxK1vnVl4dShIX9KRGGJ3yW0dZW3XG4kinIQZVifHYpAfdgJuoz9QIhpW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrOrhVY0crhUjqF+Jucn9L04vqR+uC75nKDQra6BA24=;
 b=NvXZZ1r2Sjm3GNK6A3iBLjidyP0UyXwTum8yq8KItyTL9XX21bZga5Ol3Kj/80geW6dtclvoRQKoj03BQ/U3d2LSIWrrjYkvSVQor33mQ4DHLxWIsD4P91jzSHRMrfjU5WLkeD4sQnpj5jiu9gR/WqQCpQT1ZicqEEx1YEpFr4S9PdXb6ocib0H/MFP/yoiIeb57QLNI/Vd8xi1WUo6/Q3oRae88URExF5Kuien9ixnvoKCuWepNjKryJKRdCveUggRlkn+lbLO8BV6n5zIg7sRlb+we5Qx3iiVCtSAH4G96k/WzsXN4xPAasEMaq7jQdomWBq1mYLB4iOnGt6RUKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 by DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:19:28 +0000
Received: from PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d]) by PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:19:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 21:19:25 +0900
Message-Id: <DLMOVF58XV2X.38H3PP3MBTPO7@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Sagar Taunk" <sagartaunk@proton.me>
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
 "Matthew Maurer" <mmaurer@google.com>, "Carlos Llamas"
 <cmllamas@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <netdev@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4] rust: net: netlink: validate attribute
 length before casting to `c_int`
References: <20260923120504.9100-1-sagartaunk@proton.me>
In-Reply-To: <20260923120504.9100-1-sagartaunk@proton.me>
X-ClientProxiedBy: TYCP286CA0269.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::20) To PH7PR12MB6858.namprd12.prod.outlook.com
 (2603:10b6:510:1b4::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6858:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 926e6267-42a6-4206-3a13-08df196ce9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|10070799003|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	i9IU0enE+9WLaKUQCEh2eqC7xjsvg4pcFYhlnbJDNWzR2PiQ30WqmJbI6sRZnSa7CHzvKqn3QI5sEo2OsLv3u1vxFi4ymln4KVh2Mt4Yh6maZ9+AeRuel3DxOiW7vCD+b6Y2QDGVAo9PJpCByM0wU53Jgm9h0u5kdtwpxVzVBtRH7mHnM9Hn4vI6lwQnLu39byzF25rUFkByugOJUAhBF8whBzOsQH0LfImpXMipkeY5EAZg55o+ZQDIaX1Oy0zFpS5M9WA2vYsS/uXPJn430aFPPNLuGL02xVvhRa1K1oB33m8eKe4XP4tXqh5V9q/o9ujZ+b1Ju2vt3QqiA7yWh3m6U9jrfpF4LQrdqfIhmvVLV+jlLGihW0ylWLqm2kPjn04zc4iOYTuUz4tGHxW6a5sJTHQG+e6PhweTjCIzRDKr5BopLx2SsK2JRInKLIm/7GpHAKNCYzX+aykrfyjjIkLIJsgeFIqOdlqzbT1V05Sy8ZgaRSoPoTSH3+PhihMIt/gEdNoGwBP+6VzJNa+lSJAMxR69ro11cf8R2RhBNOtSU7qNf6W8r2CO7YkLf7avjiDvFGruEQQFabeY/brVSAZg8Cs3L9b+dwjbJiPo8EmIB6ArmeP/m0hMF5pPDxciWNvqfWqFE8wKB7GEMUW2SRz0UHmmuOavSA87o7uKQlA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(10070799003)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFFlV1Z5NytRVEdybjNKZ0VHRUp5MzZVN2JKbWROZE1DT0w5dFZMdlNjM2xl?=
 =?utf-8?B?eGlwZ1ZEMVlkcVR4RnFXYUo4cEJXdWV2aU8vWllBcTRIeFRiU2FWbUNTS1pE?=
 =?utf-8?B?ZjFCQllXYWVvUllyUzFKcGlnMzBIb2ZxU0RsZU5hQ0hoWlJ1Zy96WDhZUUNW?=
 =?utf-8?B?bEtRaUVtVi9nN0VaNThlMGM3YitGWHZhNTQvMnd3b2VVRmIwMThWZVFJRkNh?=
 =?utf-8?B?Vlk3T21aSEdZeWVJWi9KbTBEb2FzYWxkQ1o0TkJzZlNNT3B2UUZxdTBzN3ph?=
 =?utf-8?B?WWJYMWQzays2RWE1cnNleXplUXpiSmhRVnpmTWhCWjNvTnpDTnpwQXR1TjVG?=
 =?utf-8?B?UVhSZ0RVQnVWNGRVRmNWTkgyaWpCTjFwVG5MYmIyaE5FalJER2pVbm5OWkxE?=
 =?utf-8?B?Yi9BZWRMVGxLYklUNXlKaDVkWlB5V0FJZUlNYVVZNTZ4R0tPbmwvT0NqUmtk?=
 =?utf-8?B?VUNBaStGUk94T2Z0S0lTVDFQNjMvb3BDR21Xdkg0SW5BcFdZNkhxYlg0YWR2?=
 =?utf-8?B?SkxtZzZ4Qlgyb3lkOUhtaXJIODFsT0ZrTUFOcFd5VkxKWmdGajFsQ0hKRDBM?=
 =?utf-8?B?QUxjQkduanFEYUpCVitydVo5VmlZZUNnN2QzV0QwZzRSZEovNVR3eGZPWE5F?=
 =?utf-8?B?K2ZEdTJaMGpHSFdqM294MG8xQUdIYXdxQjhFTi9mTlJlbWhPeVFTYWlMVzNx?=
 =?utf-8?B?RGRRSDRucWhZR241dmFwc1hpbE9VZE5KeGR1Z3BIOTRIeFFRazhNN1FGcDBi?=
 =?utf-8?B?eDNrU1M4M0RBb0w2OE5JSVEzMW4rejhyRTVOMURsd1BZWWFqWVRja0dQMkFY?=
 =?utf-8?B?WEQ4QWpaRCtGUnVMWS81MGFPdTkyMnR0VzJuOGNHMCtFbWZueDkwK21vSkN0?=
 =?utf-8?B?amt0M0FTK2VCd0JPazhHSDN2aUNoYVllcTJySUwxWGZ6STJrdVBpcnZrZlhk?=
 =?utf-8?B?dW9FaEFFY1pTb1U2S3NuYWVUOEFLZlUvVUF0ZUthNHFPWFEvK2ZjSXpiZVpv?=
 =?utf-8?B?c09RVGZpV0lkNXR6L1lxd0xpVXk4dmxwYWUrY1QzUnh5dG5VYitBd01kT0gz?=
 =?utf-8?B?UXNnODBVZjhqbkxoRnZYQkdzOTRrdlorNUlFRnFlUStOTGo5UThpVTU4UzFJ?=
 =?utf-8?B?d1VFVmlzMk1tS3pWSkQ3R2taNWJjY21MYStNS2ZwQlY2dk5oUFB5eXNBdS9J?=
 =?utf-8?B?QSsxUnZFQ2V1YldUQlA1ZmcyZ0hXV3hHbmZOeno1VWFSM1Y3eWN5S0VBcU1G?=
 =?utf-8?B?MlZQVGdHQ1lINGNSTUdHUkt2TGM2Y0xHK3RvTFhxUXE5ZURqZ2Y0bmlSZ0Z3?=
 =?utf-8?B?b0lLTGhaN01HOEJPYnRwMWlVcTkxZUJETVpwQytPNm1kMHhtajBrM2RxQTc5?=
 =?utf-8?B?OHNUczY2eHdpRm4xZ0RoVGhad1FJSk0zRkw3V0hQWUl6N0FJUWExNWRpZ01z?=
 =?utf-8?B?Zm5seFlFcFh5WFJjckZOTGNZWU5MbXowUHJGR1FjQlhuL094SnFBeDhwTDlh?=
 =?utf-8?B?SEliZzlnckQ2Zk1ZVlU1Mk95cmRNR3RIY3BjQlQ2bXZKTGpVaWRhTERRRXM3?=
 =?utf-8?B?UUIxZ1U2ZHNFQ080TFFUeldpdncyL0VmR2V1MWhIVVBTM1JLa3Fyem1lQVgy?=
 =?utf-8?B?QTVlQTQ5d1d2aXp6RUJGOGtaMjBaTHRET3VOaXlxYit5d082d0RzcGlEQWtJ?=
 =?utf-8?B?RmkzMGJ1bzkwVE9PR2RoSW9jeUNMU2dpbzN6TEZUZjNVS08zdi93TjRKa2wy?=
 =?utf-8?B?dXkrNFdkd21STy9LVG5NNkFvRWJqa1JLL0lLTm1LK3hjS0JBVWxKKy9ydmJL?=
 =?utf-8?B?Mk5PR2VQSGY0Y2c2Qytra1NYSVdhUVZsVDlKSVI3UHNOcDZPVmxvSE9ibHpr?=
 =?utf-8?B?L0ovV0hLM3VyNUV4WDdrbmFUOHRLY2k4WTh2VmNiSVlSdzFYQldmSkdwemhR?=
 =?utf-8?B?NjhRRUdab1BZNjB6NDFUZ1F1K0tiY0ZCTHVPN0srZWd5WW1HejduRk1CZHdJ?=
 =?utf-8?B?QkZteGZ1MjUyVHJ0ajBHL2UvT01PTTYvS1hSZXBOdFZRSGRLRmJJWHl0V1pL?=
 =?utf-8?B?aGN5ckFvMzdybzZtcmxrUWpxK3dlU1lnS3FNc2IvTUhwaDZNNTltMDIxUlRE?=
 =?utf-8?B?Qmh5dEI4eGZPYklueWZLb3RGOGNWVTZKeHhxOHZSeEdjMFp5K1R1UnFVKzgr?=
 =?utf-8?B?dHFTTVp5M2RpSXVPaGd0cWR0cXlWcDZsRDZqSVZINGYxWXQyQjBPdzZMOXFI?=
 =?utf-8?B?djJscDBSR1FsZHlYUVZGVS9FZFBZZ2M2QmU2bEZ1c1IxRTJ6bzA4aFE0cVVv?=
 =?utf-8?B?SVIwYm5KQ1hhL3MwMS92WHFDNUdZZUhyV29kTEIvdkxROFBia3hrOXZNVEtV?=
 =?utf-8?Q?jK44zTGqp7pcpXeBF4WX/CFPrN4l43Jl+MS6mG2Sj86/9?=
X-MS-Exchange-AntiSpam-MessageData-1: RO7wBo9/v5eanQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926e6267-42a6-4206-3a13-08df196ce9b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:19:28.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtWEuQCpYrw7joS5bn87YXCHgDlXN+BvrJaMK9Mk1ppGEoK2oJS3IFcbhOGmElff+WNwdhVafeSZN5fIDR8MWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345

On Wed Sep 23, 2026 at 9:05 PM JST, Sagar Taunk wrote:
> `put()` trusted an unchecked `as` cast from `usize` to `c_int`.
> When the length exceeds `i32::MAX` that cast wraps around to a
> negative value.
>
> This ultimately resulted in a kernel panic when the reinterpreted
> value via `__nla_reserve()` and `skb_put()` became enormous.
>
> Validate payload and header both fit together in a `u16`, rejecting
> any payload that wouldn't leave room for `NLA_HDRLEN`.
>
> Fixes: 5eaa5fbb6e6c ("rust: netlink: add raw netlink abstraction")
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>

FWIW,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
