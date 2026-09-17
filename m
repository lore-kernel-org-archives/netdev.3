Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9074DEC07;
	Thu, 17 Sep 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666766; cv=fail; b=Je3H/i8gFIrEBevYfxY5C2a/kXIIDMJfxTuxTYEllaYJTpzOV3bAP2/R2Bv1iGbM0cricVUEOliDcPnB8deKAcCtfOsHHvUNI2eqjMeXqxykmcUFmJYzQtQrKcIbO0nTo6QvQA7OeLvvw2Oa08qIdcyX/ZEAiCzVTBK+cczzvcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666766; c=relaxed/simple;
	bh=iT5aGOOFMIvYTgYKTNfD/b7yHiYQsB1CxvKaAiH9oIo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=rUEiUn6K3K8LF2RZ2Fwn2geGG5Ngr72ZI8CQwSsbjh6YxyTz5yb2X2jRyLd7IEVXCWH2rYSf6lgxlnNQvT74wioYzYPSd1h79BBtZhVvJMRRBxRNAhJOUVlnw9P/e1H07k//PUa3muXgOXwBNzQhYlnHsdttrFpDzg2En6QW+OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAi+2yRD; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAi+2yRD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC49ztnMONJg4j14iA2h8hjlDr5eYrwxQqfKTADkUFM8k516YIDirgqW39USYw4Vo+7blhQ+frkQZvHZiZc+X2MmSJt41IgcPYgcpOqPg2DjcqrhpzfOey/U1orpV3XDh0YjWdYpAAvczJEsUwNeT6SanU0O821V5sPYCjEjwpW0iRoAojBNhNgSL20RzWj0xYUnNJY0gaAlA7q6WMQQP0nH2JQDA9my/8reIqzEcUkxHZTyVPUYQrjx2kHeDvj3wPc1jKZP35jfQsspJx0PbKOaG2/Hlkeb0Dbwk7y6wCnSeeERueFVXWBVC3RpIDa0udx222Z3+emyENEjPxqKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/tiNpGpGY77U46QjkdwR4+w32bfXoyCUJrTr1kYfDs=;
 b=B9DnsQrUGP/EqK1eqDKCjJwTa9REpyY3qczaaUPlMqvvnY1FtoHTiWGqDusxnCBBSibCFPJk8XonRyacxqDEQNri9H11FuWvFbteVeo57Ml6uoOKeZ0j82Lo6+pJIY2H4BXEQzkoQncevDi6LcT3Q8K9K2TI00hgsXN4zvZ38kbieNnCnU6g8y4LH5Eq4oGyhF00UBzmwyqveekfkW7zMzJilO2EfpvYFr09zd/O2tg1AYXDbJh0Ml1YX1as999RPdZOKaGi+nsLdzZgHx8SdHi1HPbOTD3gkbtusnnNOtJ7A7QLIXlDPjk9g8M1m17A41bGMQzuD+iDcAZn3fFYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/tiNpGpGY77U46QjkdwR4+w32bfXoyCUJrTr1kYfDs=;
 b=YAi+2yRDA2pCpLtDlpl/EX0Oh8gvF4sDwrrjsNeWyalIp5JR6fAnppbw3QXG5MZ/TQeoPMW3QTcYBX+SWtc7koMboXG4qopAopUXqdCpSsN2CSveXsVYxDMauxQbZW6iG08WBo0Uk/2vXp/u2MnOUGDdrKhJT/ZtOQVwMhFvJX5KR80AoqKyv6IJWodLmwyM+9qCNZ5U7ddxlk3b6NMpD1u7MUZL4NmYBFG5b+4Vw7JsaEDw5lLhFZf4cki7MkcDNN1HbHvsTIsfi+9Bn/5ssDGQEl6Ge2xofVwF+gO7OAGXw1t739tAtZ+zU56B3un3RVnvryWlTSMq/CmDTl5u+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH9PR12MB987669.namprd12.prod.outlook.com (2603:10b6:610:312::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 17:39:02 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 17:39:01 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 18:38:57 +0100
Message-Id: <DLHRWT47BKGI.26UCD7QUSW4ES@nvidia.com>
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
Subject: Re: [PATCH v2] rust: net: netlink: validate attribute length before
 casting to `c_int`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Sagar Taunk" <sagartaunk@proton.me>
Content-Transfer-Encoding: quoted-printable
References: <20260915164000.124340-1-sagartaunk@proton.me>
In-Reply-To: <20260915164000.124340-1-sagartaunk@proton.me>
X-ClientProxiedBy: AS4P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH9PR12MB987669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffd7b0c-01e7-4492-a59e-08df14e28f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GBKRhgetf3NnhlTE3VpObgn04P5ObKvUvfpa1jE/xr/hlJ3UNni0oEMdfxFdGmE24uqBQiwF4vdxDv/QpoUux8EcWv0sNYAxlILCWbcrlD/Bf/wTsMmH9YQiR0Abnk3xXsiY221+xqMdJ1c9eIB8UvAW3xwlhdoC+LHJOjUM7FNcmQ4/OFSSxAINTTnajEv8/LNXYU89opFlUoGw2lz2gZCsJhX98urpu8InYv4hCu8fa24XjCApvo3Bk0LO/klNVfw6JVwPz4hKbOVbhf8fBZuVwcq+iM+Btddwq6dSDvXCH92iYNdbdamH6G89iAJLtCrqjNifzqq6rbzbtnNm/q8vqz0sbfGCv6qPTAadgVjluTX/bsEz/GD8Iw9KGrfsJ2l0HElFe0yUPuR9AKZiO8eNjuuq68PacTxxgDh59cgwzhvPr7u6huJWkO4F78F5LHrfb22DT1KN9SwFm/IgeAL8zWO2na/kN9O61ENewMwoyijBPUozU+cuKYF2yw6yYSm3Q+1+WOsMNx8H3JX8Y7n0SCO+zXYUflmgrHyAr7Y6/USyQ3I3HqeAcdHRlVzqq3VUQE4/RtPniUBU4O4hIPLqzeZnYIini3I9slNzP5sVg874eWMNPDInQUFEFVpfAQpGlED3xSmDDlttQ6sMW37/AnCFZ9bJzewdg6Pk/dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC82ZXkrakRuVllJTXFReFgrU1BQSVFNeldLVzBpYzcvNXlaVVhhRFpJd0pV?=
 =?utf-8?B?MUx2Zi9xbHhpbkNuNUdKZlNCTzQxL1pESUNpM3NpNEp0dEt4MXhBYW9hS3Fs?=
 =?utf-8?B?UnViak53Wko2M2xld1htbC9Md2tiRGlKQy9iQ0pMZjFURURPRC8rd013QS9w?=
 =?utf-8?B?aWVJbnFhZjJzTDM0U2o4dnlWTmFpeXlBUFExcEcwTDZSeCtNUnU4eGRYN0hC?=
 =?utf-8?B?VHAyRi9raXU2VW9tYUc2dmZ2SUZ2OEZ5dmtIWVBxRHN3SVNZUXNRTUJOOXJM?=
 =?utf-8?B?VmdXdlFFZGNnZE5Bb0labGxoY1J6RnAzdFhmWktCd3NRRTlHK2hGR1pRMmRO?=
 =?utf-8?B?WHdlS1IwNjRPbWFLSmxQOGRpSlpwRWFYTVhRaGt5N0FEU3V2RGpRdzQ0QlNR?=
 =?utf-8?B?V3h3Q1JUNWJjNUx3cnFyUm1sK1JqM1JObUlSM2hzc3VITTZ5dEF3N21UNnYz?=
 =?utf-8?B?SzJ0aDNvbzRxOGV2cnZzZnVBdXJiM1YrZmVOaE5hcm03Z2pYdkNNWTBobnRr?=
 =?utf-8?B?aWp0bTNVN2p1QXpEQzVGamFCMTVhRHJoUnZ1MWlvVjNDbC9RandwekJZcDNx?=
 =?utf-8?B?SHFpRzB0Q2lYK0EzY2ZuYUVBTVRvMmFRK1huVUZIVkQ2UG56YVg2UHdUVnZH?=
 =?utf-8?B?Ni9mbkZvdW95dUlyUUxEbXoxdDd3UVhRUUhybG51am41L1JCODF5eFc0UlFQ?=
 =?utf-8?B?clVQWjRTSzJmcnRIN3NoeDVYT3dsMXFKUksxa0FkYk52aWh2eTdCS25VQmpU?=
 =?utf-8?B?QXdCU1RuY0pSdXZmclVCMkxUeHk3YlNONmN1L29WaG11QURiZGx2anhDT3RU?=
 =?utf-8?B?QXlVVGxrSkY5cVZQMWc2VUJiRXZUWkhCQjJteEJsMi8ydFFDMUFFUjdFVmRT?=
 =?utf-8?B?WnpZRDJOSWl6azdFZnR4a3BGNWZReCtKckNrZ0VDWXVkVEtaOUxuQWNZeW5r?=
 =?utf-8?B?MHRmelc4UmJUR3JWS2o2ZmwvY0VzVml2enU2RDl6dXhPbG1XdlRPbmRuNU11?=
 =?utf-8?B?T2RPRTlvQUw5dXE4Y3JPUnhPSWd6WlJkY2hRWjgzUk8yZ2FVVXZIaEtXNCtN?=
 =?utf-8?B?YkJTaEtQUVJZOTd3Wk8xcWJ4dXcyUlJqVm9uQVMxY0lIM3djdTdmaGFqc3Qy?=
 =?utf-8?B?UmhpMlNodnlrYTUvd0NQY29XME52REp5YWZ2eXBxOFZtRFFNckxRclFwRUV0?=
 =?utf-8?B?eVh4UEV1VkI4OVBVRFVzVXJId1Z4VEMwVW14TDNteW01WE1aeVVPd0RNVEdC?=
 =?utf-8?B?VHFQVnkrQStMcnRLTjhzdXppWmpLY3VRbGt1K0FMWGtZSWRhZk95bm5URkwr?=
 =?utf-8?B?OU1Kc1NodnRyUG85QUFNOFZLOW0vSzV6VzV3cHdBazA1WERDbHBCaGdaKzFP?=
 =?utf-8?B?cFl0WCt4Tmtqd0ZwemNWR2ZMdks1M2lqdmlJMEJjeVg2c2FtTnNuS3ZmSS9l?=
 =?utf-8?B?aFhGVVVnc3JwM1lwd0lWWFNPMFlkM1BWekRSTkc1d04rMHp6U2FZZTlqRmVu?=
 =?utf-8?B?N2N5bGFKRXpuZnZWc2F2aGYzeU9McGdKVmhiRDFJU1dxZ0JOVzFGOWRkTzRD?=
 =?utf-8?B?UU1ESTg3UzVSSTQ0bU5sK1J0NTlPcjVOeGphL0I4R09uUEovOTUrVTAxSEhh?=
 =?utf-8?B?S1ZqSitlTThBeVBpOXBzcnFzZytUUk9hUHNicUZBV2dYczhWWFNhTWxTd1p4?=
 =?utf-8?B?b1RBWE5KcVR0UTREQXdBZE9pTHNJVFFWMEtjTDBZa0Fza1dVcW5qaml0WGZR?=
 =?utf-8?B?TS9GcWF3NUd1ak5GMUVrK3dCMnhqVmF4cGcrZWlhMmMxd0h6YTIxVnNrV2xQ?=
 =?utf-8?B?eEErbW1haFJSQXFTOWdYcVNORjc3RXcxOHJ2Z0lscHFNNUR5S1BhZzRWSHBx?=
 =?utf-8?B?TGxjTjZSWHdEYUJ5Q1BJMDZZelJPMEwybEYrMy9HZHZCZGQ3czJOaThSNGNH?=
 =?utf-8?B?d2FRNG9laTZRTnE1c25NSW9BMUE0NzVpLzBlSFByYUNoZlVjOGlVVnVlbUNq?=
 =?utf-8?B?YTJYYXB3NUUrQlg5WEJFRXFjcm55aFQ1aURpMDhoRkNXRGtSQUFLUCsvY2Fm?=
 =?utf-8?B?R0xtZkxueFhtcGFZQTJTVFd6SExHd0t2NUNGR0ZzWDVUbjFYLzZZanR0ZkV1?=
 =?utf-8?B?MG9mMXMvc21DQWUxK0JrRkZmbzBOQTRkSjdoNGJIL1FQTGRrd0MwU1hnR3pa?=
 =?utf-8?B?Rks5UVVRWFdsanFNSGdXZWJMU2FpSEg1aUY0Ymp2LzlnMnZFRHpxOU82Znk1?=
 =?utf-8?B?ZmVZVWFseHNKYlNGVVlKVXBqbVNVWTJaU0s5aTZmeU1oZTllQzU4K25CTGFP?=
 =?utf-8?B?aTJCdE5TQWh3SmRLM0ZIUmhOT0xvaHljUTVYZXprbzZyeEF1bG1qUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffd7b0c-01e7-4492-a59e-08df14e28f87
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:39:01.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGdlnRVU2cXJwcCN3K9F1PsSKxQ1Eo6F0bPPlv3rzghX0moDuzqKNst863fNwSe/xnAla8WhrRFjHablaevaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB987669

On Tue Sep 15, 2026 at 5:40 PM BST, Sagar Taunk wrote:
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
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
> ---
> Changes Since V1:=20
> Tried to make the diff smaller as pointed out by Alexandre Courbot.
> Moreover, as pointed out by Sashiko,`nlattr` is stored in a 16-bit=20
> field which houses both the header and the payload, so make the check=20
> verify that there is enough space left for the header to fit with the=20
> payload.=20
>
>  rust/kernel/net/netlink.rs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
> index a2f4bd171dcf..667667346f96 100644
> --- a/rust/kernel/net/netlink.rs
> +++ b/rust/kernel/net/netlink.rs
> @@ -90,9 +90,14 @@ fn put<T>(&mut self, attrtype: c_int, value: &T) -> Re=
sult
>      where
>          T: ?Sized + IntoBytes + Immutable,
>      {
> +        let max_payload_len =3D u16::MAX as usize - size_of::<bindings::=
nlattr>();

This can be a const. Also we discourage the use of `as` which can
silently truncate data. Please use `u16_as_usize` from the `num::casts`
module for the conversion.

A reader of the code will also not have the commit message context and
might wonder why you are using `u16::MAX`, so I think a comment
justifying that choice (i.e. your point about `nlattr` is also
necessary).

> +
>          let skb =3D self.skb.skb.as_ptr();
>          let len =3D size_of_val(value);
>          let ptr =3D core::ptr::from_ref(value).cast::<c_void>();
> +        if len > max_payload_len {
> +            return Err(EMSGSIZE);
> +        }

This looks like a better fix indeed.
