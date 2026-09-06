Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021118.outbound.protection.outlook.com [52.101.100.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D83C3450;
	Sun,  6 Sep 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788698851; cv=fail; b=eeF3AiCJi0zgtWt0GOSVE75l+6y5mXeylLyrOAve+RVhO7+7gzmeJGmCbRDv2wWaQ6Gl9dxNNZUGVyUQbWBLzP5QmM/4ITptFhXT6T/FXQcLycDIzGwvpTHTKFa5F4n7QQxhAfa+sC2XzaM1S+HY6bIx10Z8nZzNy8LK/nkzXzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788698851; c=relaxed/simple;
	bh=A4GduGi15pFvlBTG6S6pclxk106qBd6c/tOJD9yAre8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=rGtYzXOBQ1hvNejRhfEcq/6jlqttSEZPG2PzJ2FFDX6RzxFZCzoobd5LJBxmo99mX5Xb1zFyIwbA12VNgi1l+CBPR1laqp4joB1vuiAN6jn9LUPsUWl1zDKdJ3d5qv7lYl3aZHc+mRFAK/La6pBogw3M5AbtCXC6RjePGGf8sJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RF1obnN8; arc=fail smtp.client-ip=52.101.100.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RF1obnN8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIE2dhDBw8LsigCIRvEikRuttfekXSX70LHnL9biP+TcAfM1ULTQlhjZGbvz6NXb6RG83YWHDC8tQ2SuWp04unpmu0SADlJeRyCm+pe9kq3MG+/fahUs9CpLbJ4KwlfRqL+MhX3lt5+Ao5w4KNCldTmXrS/rdhJspdM4jKKCuGPgTnJlfDo4NfSNH4NAyJdRLk3r4fqZPExQG52s1Kfkor2GgOSXkFyR/YKF8V/fOBGZDbBeEJeEDJJRJfqUhN3PEjUIqi2HP64ep9W72leb62i/5KQ7H0YQ4/R9Lkrgff8sd578b57OiTNVS/3KGbeZQGRx5vPx0nT4hX0vQ7kLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCp5reJ2K3BUiQkpmo+qE/Q37qua5/0eUOYy1DVorw0=;
 b=Dq2dcd622a3AU5VJwVhp2pFEEc+cS3DiW8ENusy/bYwPUTt6a2/WBVLrHN1Q/vS45QQ4WUTjPXCaj2pEDWix6K3MANWyLIdY+6wgrVHo2K2gg7aZ5O54QXLi/UAPcphAy2j8SZOluOPj/97yHo/89g4yRAYB2hz1k2THbEQ0ZMpiqnD9IJ4OPrvEu8p+m7wwjxkjlj4Dv/7i+Pd4e8KTPihOJabXdCVn39sHFoI5Zp45mz7307qNGUSU760r7Crj3hfahSS+6vIJDvsi8nlJDph7BldKlI+CLj21jxbq7LyW0gpsKR9oB3uRo/HcqFt8JgrtpjEOM69/baLc3iWSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCp5reJ2K3BUiQkpmo+qE/Q37qua5/0eUOYy1DVorw0=;
 b=RF1obnN8lCI9TFQubjTyQSmtLnPBvzdojOT3j+27X7mZszQBZAMafY5WGkk/aPQ6Oj8Md3pSf+IyWlssDX0JSNFRSc1ztNCKA2xnN3qpz0D1brdJt9nipbaJ0w0sV5CY+gsXJEri9i6J3oxD2M8sAyu5xWwcxW3KZOs/hIlSTl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB2699.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 12:47:26 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 12:47:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 13:47:25 +0100
Message-Id: <DL88TLWYE8H8.1FP5GCIYUL1BN@garyguo.net>
To: "Sagar Taunk" <sagartaunk@proton.me>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Simon Horman" <horms@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rust: dma.rs: Migrate to zerocopy's
 `Frombytes/IntoBytes`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260906102826.202874-1-sagartaunk@proton.me>
 <20260906102826.202874-4-sagartaunk@proton.me>
In-Reply-To: <20260906102826.202874-4-sagartaunk@proton.me>
X-ClientProxiedBy: LO4P123CA0308.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d9344c-790e-46a3-c059-08df0c150160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|1800799024|23010399003|366016|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HeO9KnO4mjAkWRbK/ZRlFjkgveb0jDwjbuxjFgtu7HF9DMUY78UstcY/fKqhkcL3IreQggLBBqKjV8QYFbTbnjdq3yfyCbYzGiP+mvhSdo9hvaSR2UbNBNvMtPQV1h7mNee2BLqzPJDZppFVQGwCthfCh1pH6t7LxD12fqsBoZ6xFN0UrFs5AUpyHrd8yQT8LRXOsYfZxAeZQB86lD7+0kgxEsKyiJfzJRdU9GakCsksuEbXvIHCX0NhyBJwMK0xGUlk0ndnGzkRUIocmmqMe5OD12XUP7JgAsLbo7REsdfO4XjamaTrk6Hcd/VOD+MOllDoZ2zBETcVXKpU1Iayzt2Kfu4sdjOW3AzIK6Rbsb0EGBjHrQ9HGAX7pu5NNX4DY/QwGElBUc3Znv2O+hzXKW+kjGWOR5LkWgwqUqj66eCevLN0+VL6bcpiURh2CGkao5e8y/6kohjh3O+Ge3H4tEo7JOugExngMMir8zv7Qd+7eaJM1rAz/GT6lLZEY7U1D5xEDkxTjawO3Wcf+Oe0L+JRRA6H9pH+bD6gkmmlwCli/e5Fl6jH2gEJnvqL9vnTOj+ogkqLvGCWZh3FC0zqg7SaBpRWAQvW0ETw5Rz9Vqz9GEnsCiYHP7ED76uC0FD9Mnr7C33KFUgpqfz3p0eDru+FNJ7ifSVyHM+2fT6aBCU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhGdGtoclV4SElON2xvdlNERElpUDU0eFIwREF6RU1BY1lwNUFrNW01c3I2?=
 =?utf-8?B?emFRUlp0cnQvNWFtY2JNcHg4NnZLbDVQeXljT3oxTThCU3loVGlJNjE5elFO?=
 =?utf-8?B?KzlRRFJ5ZWoxamtXVlZlQmJDaGk4QjBlT09iby94amVraTFwejhNU2NJQWYx?=
 =?utf-8?B?NGJDcml5NnVIZTh3ay9UV3lnVVBHYlJUbUlVQkNaeWNFaStiOW16bVBMNzNq?=
 =?utf-8?B?Q1RhbFM4VW1jNXFTemNtU2pZOU4xWGVkeGJuc0xzV1ZCUGNrL3RwbFNhQ09H?=
 =?utf-8?B?Z3lhZlFJZ3NOTG82a3VpOWdhZ0V2bDV4SWFVa0RoTFF2ako3TXcyRWZUZ2Vx?=
 =?utf-8?B?MmZaYk5rbE0yeFcyTUhIU0lFUHJZRWlsN2VobWRndmJTU21EaDViY3RkK2JN?=
 =?utf-8?B?akovQWVPSVdaU05DcG1CZXhHNlNOb2ZmUGphdnc2VHoxV0NQbC9MSXdKQnhK?=
 =?utf-8?B?NUdWMk1nb2N0SWRsTjcrUnMxYlJaWGlmeFVKRlRiUDRzUmxQcGFPMzdKV0NM?=
 =?utf-8?B?c01Bb2VsOVBtTHUzTUkzV2tHRVR6OUJIWW92Skw5dXh1RG91cjBMNkM1ZDZ4?=
 =?utf-8?B?ZFZRMHhuMkR1TlRZazFnQnNLaEVRRTBwWnlSLzBuWDFwRm5CVE81Z3lVT1dT?=
 =?utf-8?B?K3R4MGpuK3JGWGxsWVNaT1FkeW9VL0xXL0NQWmdmZjNYa1pOZnd6NFl3VWlG?=
 =?utf-8?B?OERzb2dHQ3hXTnNtTkxLODNZdkFrc1BMVHFocUlBbjR0NHRuS2U3ZzBUdFV0?=
 =?utf-8?B?emQ5bEhhTFMzaWoydkpUNTFpV2x5ejkzRU5yaUhGblYwQnltcDdRb1l6Mkxr?=
 =?utf-8?B?bm1aNkhhM3gzbDVBUlhOM3J6S1BmUncxL1V0eHBSc1NUSFpLNGdQaGdhZG5l?=
 =?utf-8?B?VTBLY0RIN3Naelo0K29GWFB6WnZNbXFQdW1nVUY5VW82bEkxMFhnV0J2ZkVB?=
 =?utf-8?B?bHBnNGtDaC9pNEg2T2Z2OFU1QTZjZnV3SFZvRVRua21GY25DSlVzRkpIQ1c4?=
 =?utf-8?B?YXhMYXVUYXRoaTBObXRuQUFKV2kyRVRsbXJvZWtwUmpHMHBqMlg0bU1NZXlV?=
 =?utf-8?B?MTcrSUo1a292YkRvK1liSWF3eE5FamM5MFkyY3dNQTNCOThYTXFiOVFZNVRR?=
 =?utf-8?B?Y0V6VjJjL0k0dnk2enBwbHVFSExQOXNvL3pjTk5QRUo3cXFvU0lscFRTYjk2?=
 =?utf-8?B?Tk4xU2VXUGRhQk9nSURvZWI0TjgwTDRFSkQwRnZMYldJVW5vREdkc3A4L2lN?=
 =?utf-8?B?ZjR6c0trK0tMNkVhcnpxbmxTOXpIY1hPVGh0amtheVhocHlvUG5xS3JxRkM1?=
 =?utf-8?B?T0NtcTR6L1kzeENLMk9sNEI1KzV5ZjJJREsrMHFVaVl3MlFMWjU5OUFiYmRF?=
 =?utf-8?B?dVR4d2FlQWszVEF5WHJ5d2hZWHBMajlCN3ZSalVtck45VC9qRS9acFZwZFpr?=
 =?utf-8?B?VzVyMVZKbG9aSWpiSjl5VmxpdGg4UHpMb2hqRTB4T3dZYTRlYjNBWlNHUThR?=
 =?utf-8?B?VDNUSzM3TmJCQzVXeWpHUEdVaEdyOG9FU3JLdkdGbXNtRVgvWjBpVEl0UVRz?=
 =?utf-8?B?aXk0M1llMDFScXZ0YkVkcTNEa1JPaUN1bWprd3I4WWUwb1Y2SjBYRkVXRmE0?=
 =?utf-8?B?V3E4b3NWMVd1UXNyRVlCeHpDVXZWdEVDckpFUDNkM2tiRm44dDJUam1WM0o1?=
 =?utf-8?B?RXNOeklGYWZQZ2t1b0hoQlhKVUJzQUl4ckFZUlhEV3oyK1orSm5leUMrOXhN?=
 =?utf-8?B?TGMzeFJNVk5qU0pjMVRsSUZhbUxmYTF6SWNCdi9qQ1FyVWQ2bkF4V0R2eHVo?=
 =?utf-8?B?NGJkVC9yTDFmdGx6dkY4VWdrbEF6d1BDNzhxeTNmSDVhNCtiQzNQVWxhT2Vh?=
 =?utf-8?B?aHcwS2E1UkhXWkQ2ditKTjUyRTdINEwxbmJrWFE3REtxMm1JWk1sNyt4V01D?=
 =?utf-8?B?NTVPSGhZVllwQmNCVnRxUURLcy9Kc0RRcDlYcFNLbkxMb1RvME4zUkw3SURS?=
 =?utf-8?B?SUtIR2lLZXdaelk0SDdZYTc0VlcrUUtyRE1NU2Z5TVRpWHFqM1NleThRTG5S?=
 =?utf-8?B?YUZER1ZWOWxqRXlrNFEvRVNmZndzN3FLVzFlUC9ZSmhUdnAzRUdMbkhocm92?=
 =?utf-8?B?c0J5aklxUkhzNTQwSkFhQXRyczlubEtwL3NsS2lPK3J1MjNnblFBTG84ZVFG?=
 =?utf-8?B?dVRJMy9WUk4vQUE3Nkd6eG1xeU90THlWV200TThPYTBsMHlVb0FSSFZkQzRI?=
 =?utf-8?B?eDMvZXZyS0RBTjdvQmNNUWpFcWo1QkUwOWc5VDhpeTFBTHJTRGlKYkJVWi9y?=
 =?utf-8?B?TjhKSWhqditGQXI3SWFzVStLNzA3SCt5eGtEZnlYVDhxN1czMzZJQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d9344c-790e-46a3-c059-08df0c150160
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 12:47:26.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0P812FUNZXnzyeZ0roYYIr+n/3QgexVGyN0Xd6K9mAhFDUFxFP0OBJEAfksvhs6u1yke9Acr5rdSSvLjhoOnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2699

On Sun Sep 6, 2026 at 11:29 AM BST, Sagar Taunk wrote:
> Replace explicit imports of `transmute::FromBytes`/`AsBytes` with
> zerocopy's equivalents.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1241
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>

I am surprised that just changing this is sufficient. Are all users of
`CoherentBox` already have the both zerocopy and kernel traits implemented?

Best,
Gary

> ---
>  rust/kernel/dma.rs | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 2ce09f8e90c6..9bd47f20c784 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -25,10 +25,6 @@
>      prelude::*,
>      ptr::KnownSize,
>      sync::aref::ARef,
> -    transmute::{
> -        AsBytes,
> -        FromBytes, //
> -    },
>      uaccess::UserSliceWriter, //
>  };
>  use core::{
> @@ -417,7 +413,7 @@ fn from(direction: DataDirection) -> Self {
>  /// ```
>  pub struct CoherentBox<T: KnownSize + ?Sized>(Coherent<T>);
> =20
> -impl<T: AsBytes + FromBytes> CoherentBox<[T]> {
> +impl<T: IntoBytes + FromBytes> CoherentBox<[T]> {
>      /// [`CoherentBox`] variant of [`Coherent::zeroed_slice_with_attrs`]=
.
>      #[inline]
>      pub fn zeroed_slice_with_attrs(
> @@ -454,7 +450,7 @@ pub fn init_at<E>(&mut self, i: usize, init: impl Ini=
t<T, E>) -> Result
> =20
>          // SAFETY:
>          // - `ptr` is valid, properly aligned, and within this allocatio=
n.
> -        // - `T: AsBytes + FromBytes` guarantees all bit patterns are va=
lid, so partial writes on
> +        // - `T: IntoBytes + FromBytes` guarantees all bit patterns are =
valid, so partial writes on
>          //   error cannot leave the element in an invalid state.
>          // - The DMA address has not been exposed yet, so there is no co=
ncurrent device access.
>          unsafe { pin_init::raw_try_init(ptr, init)? };
> @@ -523,7 +519,7 @@ pub fn from_slice(
>      }
>  }
> =20
> -impl<T: AsBytes + FromBytes> CoherentBox<T> {
> +impl<T: IntoBytes + FromBytes> CoherentBox<T> {
>      /// Same as [`CoherentBox::zeroed_slice_with_attrs`], but for a sing=
le element.
>      #[inline]
>      pub fn zeroed_with_attrs(
> @@ -554,7 +550,7 @@ fn deref(&self) -> &Self::Target {
>      }
>  }
> =20
> -impl<T: AsBytes + FromBytes + KnownSize + ?Sized> DerefMut for CoherentB=
ox<T> {
> +impl<T: IntoBytes + FromBytes + KnownSize + ?Sized> DerefMut for Coheren=
tBox<T> {
>      #[inline]
>      fn deref_mut(&mut self) -> &mut Self::Target {
>          // SAFETY:
> @@ -565,7 +561,7 @@ fn deref_mut(&mut self) -> &mut Self::Target {
>      }
>  }
> =20
> -impl<T: AsBytes + FromBytes + KnownSize + ?Sized> From<CoherentBox<T>> f=
or Coherent<T> {
> +impl<T: IntoBytes + FromBytes + KnownSize + ?Sized> From<CoherentBox<T>>=
 for Coherent<T> {
>      #[inline]
>      fn from(value: CoherentBox<T>) -> Self {
>          value.0
> @@ -663,7 +659,7 @@ pub unsafe fn as_mut(&self) -> &mut T {
>      }
>  }
> =20
> -impl<T: AsBytes + FromBytes> Coherent<T> {
> +impl<T: IntoBytes + FromBytes> Coherent<T> {
>      /// Allocates a region of `T` of coherent memory.
>      fn alloc_with_attrs(
>          dev: &device::Device<Bound>,
> @@ -753,7 +749,7 @@ pub fn init_with_attrs<E>(
>          // SAFETY:
>          // - `ptr` is valid, properly aligned, and points to exclusively=
 owned memory.
>          // - If `raw_try_init` fails, `self` is dropped, which safely fr=
ees the underlying
> -        //   `Coherent`'s DMA memory. `T: AsBytes + FromBytes` ensures t=
here are no complex `Drop`
> +        //   `Coherent`'s DMA memory. `T: IntoBytes + FromBytes` ensures=
 there are no complex `Drop`
>          //   requirements we are bypassing.
>          unsafe { pin_init::raw_try_init(ptr, init)? };
> =20
> @@ -948,9 +944,9 @@ unsafe impl<T: KnownSize + Send + ?Sized> Send for Co=
herent<T> {}
>  // methods that access the buffer contents (`field_read`, `field_write`,=
 `as_slice`,
>  // `as_slice_mut`) are `unsafe`, and callers are responsible for ensurin=
g no data races occur.
>  // The safe methods only return metadata or raw pointers whose use requi=
res `unsafe`.
> -unsafe impl<T: KnownSize + ?Sized + AsBytes + FromBytes + Sync> Sync for=
 Coherent<T> {}
> +unsafe impl<T: KnownSize + ?Sized + IntoBytes + FromBytes + Sync> Sync f=
or Coherent<T> {}
> =20
> -impl<T: KnownSize + AsBytes + ?Sized> debugfs::BinaryWriter for Coherent=
<T> {
> +impl<T: KnownSize + IntoBytes + ?Sized> debugfs::BinaryWriter for Cohere=
nt<T> {
>      fn write_to_slice(
>          &self,
>          writer: &mut UserSliceWriter,


