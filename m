Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623F319601;
	Mon, 14 Sep 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352669; cv=fail; b=Y/LEx7XfGl9s7NE8cp8Fs9o0lOKmBefEEZN68qaY7qtWQl6oMk+y2VkBQEAWx+ukkCyitrJrg4NedqxHopbWyARRYr4VeFo/jxRIQ0rBECXOqS76RqbZAXGY2wYUkjkk2YtUtKRpW8GPsjtezoLxuQPwWNaHNAr8wNjFTD5EFbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352669; c=relaxed/simple;
	bh=YVqGFrHoN+NfDkQst7sXaT/4g3ZaX6tCfO0EXRkfpIM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DaQhCHNdQVyp8y0A8dovstaY3R8QebZV9vCVCsJDVdnx6W0h52j7bSzTcTfHz3RnE2cU1TN9nw8mRLUfF5BboF0/tUf0XzP9z7tRTbT4NDhNU6Vb6iO8RVV4/rMnN4vqMQX2nmFe/ozhz9poGSRkXi0SJHkSephL08+spq8Oi/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dQmVdvcg; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dQmVdvcg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUgK9VFUx0Neb1+g0XUkhZiQ27pG2SBo2n2yPGq+4K5rUJDupsEE/a1FnxSFiRCe9w4tiD30cxzdStr10ik2+dfUFZo8bVlJ+l6jfi2qsqF0Vwrx6Bl7oQAZY2dfEbuDt35LM75gPoJyhoUL/J4o76i4Konwp+++pSLQpG8Y5mGfrPHVIF7YeyT5QMLSadW1b8trvkwsAMMmikOhnFZfjPL9fEGYlGVI/c5JPtiJC49llcHPhN0b939pFSOWsMrVIJmy4zDcOzJ+0xi2d/iP+4KBUZ+l8XA18CUWepJ0dZUIFT7VPlUTwoc0JvEstmm3X7nPp9ClfnIKBMuWLbjz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVmXoIreCdsUiF1f+w3mRf9D7zvbwCXeYn4xnQon1Wk=;
 b=JSePUR9rmBbGNaEtsHE2ZoC5rRbZE2uHirx8bODvXq70ZRSOPkedyFhTdtMJrSrL0c2DBM4tKbyIf4DabrkIp7bOVGsjJpCl29m87b5RX+Y5N2wQzxw9ZJy0bDAPxC8jFHAoiMA8FQmNKzHgKpbpJXBlRH6le54hdjZ8cYeIqul637jGgYF9dX0tQqUIelVjrmS6SzA586hCHnpQ4NvMytwgbsNEdOnnByUYExxmmU4uxYlAsDpJS+eZ1de5anCfKTjK0AqHDX+tbWCbOV3FYYJvXnEBv2FTza2rGASj3yvO+3SBvd12grHr+xLCKTngtem0JD4+NDTUbcL9xF9SkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVmXoIreCdsUiF1f+w3mRf9D7zvbwCXeYn4xnQon1Wk=;
 b=dQmVdvcg5DlLKaGpyu/lY5JRRB4uAtDAnLWm4At7E7lE/KyP8IfoiE7oiKcdNjEiU8dHwqaAjBVc4Tbsts43xStfs4XOzRKkpIuGNfYJmJFHv0Jl/qT13J1hfp4xW4SiiY3AHYhdGTasLulY1tU4j7+FUnpAVLBvMTO2a8r/zC01Xe7nFQiLeuJmLMtpLlmh8mHINclFASyEF2UfiuTnmvr5em2sBYT/e3Tty80xLVSXxWcekx3n0RtVyol1AqIVJSwD4Iyz1iNPsniCb7lRr3mpOj3S6BIylBbyQe5Ykk/TL4p5/nPOoW0qxIErvK9FRlcMFAoEMDwVvfGtQUhGSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Mon, 14 Sep
 2026 02:24:24 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 02:24:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 11:24:21 +0900
Message-Id: <DLEOKWJ6LV2W.ENFFV78U068J@nvidia.com>
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
Subject: Re: [PATCH v2] rust: net: netlink: Migrate to zerocopy's IntoBytes
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Sagar Taunk" <sagartaunk@proton.me>
References: <20260913021805.19062-1-sagartaunk@proton.me>
In-Reply-To: <20260913021805.19062-1-sagartaunk@proton.me>
X-ClientProxiedBy: TY4P301CA0124.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 24067e8a-69d9-4973-d90d-08df12074ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|7416014|1800799024|5023799004|11063799006|10067099003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	I2EnFZVz7GX283K7LdIjk1z/fQghJhpVu6QKWsZcDWs3Ff8Kb4yzoWIzhZTAEV/N4F1eo+tdyuE5rsJaWE/Q46fZfiR5WuVv1SffFQ5NyZGXdWzlNnSUUT3TL3rp9SmQcrburF8UUngYZq5rx7hgU0PzhvlSkYn7J65C25i4hmbL83XAb5m5NpnTp+tQhxZxlq4XTCkwsrkprEELv6V34vuPu1pXCQBKNbVUhloan5OPxjpJqHAgMbZIyuo3Ct5uKSC9iaeyul8spNOr3yLf9cRT846i7n2XI3a/KTrl1CjYej0PUaTialOJwsK+syutuPvbgBxt1AkHeI1vFdy8/Wgyr/AjjyxmsOjwveDshJva7ZZQTRDUqjWB+OCiXsT1W7HrKb5aA8WS4UsLGsjyElDu9PY2sdsI9Y6allQY1xyP/+aw/zj97dHAzhKErrm48iVMVKCzjWputNNg2KnfzIWXz0oQnlM5bnehdXor0WZ4expji+uX027EINxeE45BNaOSOu2aAn2bZJ5W8SgzZcvxA63AUe9cpOCJ31NCRS1wgnKcHU63BT1V3f+xY10HCUrEZAIOA34R39EgpjCJPorAkpEMzkI6d7pH+DrJfF7x/eVcGPZoHMtISgMJ/gfbiTOUAAYZOMDoXQGZrTU/4ADFNjgzdUU3hu0pvIJfEU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(7416014)(1800799024)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTFmaTdzV3dvZWJ2aHVzQ1VzUzhwT0c3VWo1bUFNYWlEU3d6ckE2bDc2OVZM?=
 =?utf-8?B?a2dyV2docjlFOUZtNGpXVEJHZ01rYVVrdkpHU1U1TU1uVitRaVNtU0JDNzgx?=
 =?utf-8?B?UnRsb0F5OEt1VjdBMkVsc04zenRJMVZDVWtXNjNhcEtwbmZjRzNGcjV0NEt5?=
 =?utf-8?B?bTlvUkFFbFlidmhxaFRsMkVVNUIwa1BaUmNPMmVSeENacVh0aHhlNmJkSlli?=
 =?utf-8?B?TE4vcnhhMGpYK25rejlEb242LzZkWFpkM0tpbkc3bksvRjBmMjdCc3loRk9j?=
 =?utf-8?B?NHVSSHJXS2hKM3dXYk9YMThLUVJKTDBlNlVoUTY2bDVHUCtJaDBDb0h3Z250?=
 =?utf-8?B?QTMydm54dExZbVpkUUlQdzNHUGJRWlBCOWl2VkI2anJsNVVxKzFpZ0poaFlW?=
 =?utf-8?B?eDVyRUwzeFRFemRmTmcwWjF4aEM1SjBRVUtmSDJSN2tXVFk5ZmhLUnRVRXZN?=
 =?utf-8?B?YTJsa1p1NXl5NEd3ZWR1NnRlT0lLY21QNkhqOVU5Z2tJYks5S2dOSUtzY2NL?=
 =?utf-8?B?K0VqcWVqWTc3UGJJWThOVVNjTnF1a2FHSFNNYWpyb3oxOWloOWRoSEtEeVUw?=
 =?utf-8?B?K0dsQldqdUhlelg0RTlzY0RZMDlSS3FyM0xveUFxbzVqWXZ0SEhnWUNlcTFS?=
 =?utf-8?B?VXExdnlJWkRFT3JsOXhlRFVNNE45bW1QRXQzSDd2cmdqUzJ1R3MxalNiZzdO?=
 =?utf-8?B?SnFKVDlMYVBjbndoNlA5Z1F2ZjcyL3YrWFkzcTZ0MTlDekRBRXMyb2FBdVFP?=
 =?utf-8?B?UkZoNVFRVG5ReWc5bms1amNkREdZcklRd2NNL1VvVWtwVkxlV1lDWWgzM3BT?=
 =?utf-8?B?cWphMkRseDRNV3hiQjhtSXJQS0VFZFByKzM2cUk2THVEazVwb0VJSzJvN0J5?=
 =?utf-8?B?SkZxNHhnZTB5OUM0cThRYUlBTG50anI2QXVabitUbDRmLzlqd2VCR08vRGdW?=
 =?utf-8?B?anhvbk42djBad2theDIyWEJTc3hVZlhlT1pMYVo5dU5peWZuRlM1RlBqdThC?=
 =?utf-8?B?MzFsUVRwTmpRc3FnVXN4aHNLU1BMeFpyNEtxQzBYQnlEVHlQYXMxS2tBMlBI?=
 =?utf-8?B?bVdSTHJHb2NCQ2FJcW9qL25RRVRQL1ZRank0MGNUdms2aWtVRHhrUzJxTFpK?=
 =?utf-8?B?TWlzTFFXc1lzS2dub0w5SGFPd1IydktSeDIyKzZvUlhudG0yMmJTdm9vVWZ2?=
 =?utf-8?B?Y2VUdjB3dEVBTjNrR1FRemJuTkY5aUZiSFhCRXp0aTlHZURrSjdrVFBlZkFH?=
 =?utf-8?B?eDZTYkhDOWRqNXBySjhMaFl2U0hRUzFLVnU5VjRBWjBlS2Q5Sll4TTk2TDha?=
 =?utf-8?B?UzZyaTM0VnF3V3ZOTGY2OUpneHJWN1VkQU93cEMyMGwvZG0wVmUrZVRXNWhv?=
 =?utf-8?B?blZiMWhNUlZRdWF4dUl2NXF4TmkrYUZCNldGUGYrbEM0ck03NmtyUTIwNTho?=
 =?utf-8?B?WFN1My95WHpSd3FlRXdmT1Zhd1MxaWp2S09paXNjMTZRM0FyeXp3SURPQ3N2?=
 =?utf-8?B?TzVTLzRlNisrQ1VoNGVFc2ZScS9maDBFdWlwZTdIY1MzVE1CWnM1Mk1LbnVP?=
 =?utf-8?B?NndRRjgzaktYQXZnSGRaTC9TQ2lwc3UxWkxndm8xQnphYWhxOHRHblNnQm8r?=
 =?utf-8?B?ajNmanRibGtheXE3S0N3R0t6UWtCdWUzbFlEMnhwR2FaOENrSzlvV1hTSFdE?=
 =?utf-8?B?WGo5T04yanlUV252U0tWTlhGSVhYKzBoSmdrWDdXSmdBZFhtZWphSWxmZ09u?=
 =?utf-8?B?blJWY3pMSXF3WGJmOXZvY3FUbGExRStUTmNUSCtUNng5S0NZb0pCdW5hemFD?=
 =?utf-8?B?QitIa1ZVWFZiMTd2dzdVRlBCK01JZjRmcUdWazVTeVNGcERLSUFFWU9KdU1Q?=
 =?utf-8?B?a1pyQjVUTzNSbjA2Y2pNaS9jZEp2WWcxdFEzY3grUDhxelNoY3ErRUNFeE5w?=
 =?utf-8?B?YWtRSlAyL1pUbGtmL1FHdVhJTWplZEh0bW5XbWxVbEVZenVWYmh5c205YjRp?=
 =?utf-8?B?ZXkzOWVrUk1Wa0JUSTN4aXlNU3pZdjZYVmlRTFBNUS9ZQkxqeE00OU5RYU5i?=
 =?utf-8?B?ZW5RVXNCWllBb1VSUzdPb215Q1dmQm1Rc3dDREN4ZlVMYSt6bzc2Y3dxL0gy?=
 =?utf-8?B?YVFGYm90QTZObXVtREZ3QnhFQTRQNGpGd0lEUTZ6L3NLVWpRaTh2UTh3bTRN?=
 =?utf-8?B?clNSS2lDbVByb3lKSWRFV2FHWkYvYXdUQUg3SGdvUzVmcCtmK1Y5RVErMjlZ?=
 =?utf-8?B?UGRsbGw4Qzh6azdFUmpIYzE3SUsyUStIb3F6TVlCdmN6MTUrRkw2SFRJMWFV?=
 =?utf-8?B?akNkdlYwaUl2SHlHNG5zYUo3UkFraTJlK2t2OFpDYTRjNzg4RVpldHo4N0E4?=
 =?utf-8?Q?K/sfkWuet4xp5POIxCmq9aP87fCSo7FH4EHGCTYS5Ro/E?=
X-MS-Exchange-AntiSpam-MessageData-1: le5wb6pWKF98jA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24067e8a-69d9-4973-d90d-08df12074ace
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:24:24.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjUmsF4ZGsBQlc5XQxqQC7doGZajIkB4I/tBW/poqIJdcTLy0gU/NhLQDmy62DkHMsQITcHID3nPgcNb7e0oXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

On Sun Sep 13, 2026 at 11:18 AM JST, Sagar Taunk wrote:
> Replace the kernel's own `transmute::FromBytes` and `AsBytes` traits
> with their zerocopy equivalents. Specifically, this updates
> `GenlMsg::put` to rely on `IntoBytes` for converting attributes into
> byte slices.
>
> Also, add `Immutable` trait bound on `GenlMsg::put` as zerocopy
> splits the `no interior mutability` guarantee that `AsBytes` bundled
> together.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1241
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
> ---
> v2: Split into a separate patch per Shashiko's review; validates the
>     attribute length with c_int::try_from() instead of casting with `as`.
>
>  rust/kernel/net/netlink.rs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
> index 22ef3dde36fa..3c2b142a7402 100644
> --- a/rust/kernel/net/netlink.rs
> +++ b/rust/kernel/net/netlink.rs
> @@ -12,11 +12,12 @@
>      alloc::{self, AllocError},
>      error::to_result,
>      prelude::*,
> -    transmute::AsBytes,
>      types::Opaque,
>      ThisModule,
>  };
> =20
> +use zerocopy::{Immutable, IntoBytes};

Please use the vertical import style as per the guidelines [1].

With that,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

[1] https://docs.kernel.org/rust/coding-guidelines.html#imports
