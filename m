Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217372C11CA;
	Mon, 14 Sep 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348253; cv=fail; b=fTYTEcpHTimKmUhZLJhFlzub6z/EGvZrm6adEUphLXsWRja87dWVUjCEMUhD67R9YM5f2VLgTLzhwgaJeL2qRlS3FxJVUGkipuvWjnPjquSUxzBpgMKvdfQCZaosMqBZR6zdNT+cEB3nu0oM3saODrfPy0gIi77ZP78CtvedQA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348253; c=relaxed/simple;
	bh=73yrEgeuULsnnm3RnrhNKspeYf+iB0WvVwwPxeGgyxw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=sC5zcpHKxZ6TxgPyTXNVXYPvrLG8w0Tsr0CSQXp5yNKr+genoDSBv7XzWsinLLLqBqPtfetK87DhH5GaeEgpjqCKcHX3YLRp2UeD2nwM12yC6gMxQcXuCfvcXdYiOIU4+XoM5B9V9BRxPFnpOBTJbCGw1N2RKLr57DVnTlrnUhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GEVL9yIf; arc=fail smtp.client-ip=52.101.46.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GEVL9yIf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJTgQxJ5y8/EtzF9915aKDHTJcRW9sbv7IeGUfkXj65zB6c+ANzWPHhmsrxGnMClD4US3O3pGwR5U91UL6a5szxJME7Jq7rHKccDt9vVFtPd11jlTLmAwqhXUwvK8k/ZcrLQHLC8o9w570xnVf95W38xTtN+IQoGzYO3BbbXDTNsw4Du+2qRoWtpN7xxlAaqnVqaM4mfwxW4sz/ILYequAu1bAI8NSMXBUKQ/z6NCOx0vBfhzzmPn+DhYP3vyLIUyj1htDRXO7ZNrd7Mp745M4JYNJ75TX3vdbo89GfreAc8r9ymxWQEN/Li8CuMUr+0+AzhqkVUJjm1aDlFVuU36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuAxBe8i3zNxPxazxdP4qC1AGx4GwbC4lQRUEHvbits=;
 b=Yk9Xm97AoZ2HjpoI/TOkZCNGfrsIrtiHmcWIQj1yJGA9c4cjm63sn9tjRlqS/G5KR6jqDyEU7PLa2Zkck0NErAAQC2nu4N5N6Fz1Io3A+yS7+pefXzIFGlHkedFt0+gP/BDdDu0G5dxWtUmIMuMye8I0jBWKBDrXx5k6uSOKpOeTBuhGKb4Tfa1I+3S18hZ1LmsnEnJ/LzN1UssMzMuuSCxhEYKU0YF6RHkW5CVcJ5RfdM/AoVBU1fFc3t8o/wazct+XA6LdeHLGSedO3azR1yA/+oq8QBySY7XEcZ5aYY9L1HK0G/ffkVi7NNd8tXlqERONBQWOqMtL9wTd5sL5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuAxBe8i3zNxPxazxdP4qC1AGx4GwbC4lQRUEHvbits=;
 b=GEVL9yIftvTOZnFsalYQINWdzENauC5XRsXLDfpEnwyHJyHi+ockqgT/pI24z9YIUb9O9ArXQvA/lPaRrQXPHZWVOIH0VGTECw/YIlNyQMV+158GHs/vAipUIICVHU2RjeWQr/B6RpHnc6v3tUXiqLCBM7CYiMQBW8eSe9dncLhNS7UVl3qnokVDogPb9AkFY2RYntwkbkafBZSo/9cVf+FfnCtjzeSeY+EhW0Gik3b0STyPNoE5iVD88SPlpBeofHB/iaQMmgLSKY6pPg/zAnGzXdF/Ia4w8TFeNgGpc1/99kuUzjNsksbzO3kqhuYSV3aWzXz9hJL8nOpdiUqr9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 01:10:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 01:10:48 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 10:10:45 +0900
Message-Id: <DLEN0K4JVUB1.1G3JJZHEJXBBC@nvidia.com>
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
Subject: Re: [PATCH] rust: net: netlink: validate attribute length before
 casting to `c_int`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Sagar Taunk" <sagartaunk@proton.me>
Content-Transfer-Encoding: quoted-printable
References: <20260913021730.18926-1-sagartaunk@proton.me>
In-Reply-To: <20260913021730.18926-1-sagartaunk@proton.me>
X-ClientProxiedBy: TY6P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbd6990-5474-442e-8f65-08df11fd02fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|7416014|1800799024|366016|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HDlQAyWCrJOXFCszLL677JIRgeCx06F7eTUrr83Gq9wJXIm8ecAhtpTfqZwBUxQwtOkVVE5+Oz9gxXBkVAGlfiU5rcPtV6SDnbPamgWH9jBHAvGyvhsAXORy4tsDlzEaaSc1EYJ51y9BeQqQMpVGD3/SyQg7ZCBim9J1dMo4X7s8UpcCiz5TxfKXMEcEjphYKxXU898xQufta1BtIGLBu/BejhZVzu3ctQmrmaV7ZvDyFwrw1xMzNPAUOIgenB9TMwT7HzJpFvpLg64niPs8T0t2FXx7e5f2J8LabVDjxTuv1OsWuJs45eAJHhK2leZlHJTHw8cwCml437UuWyFbRqSfGt4JlkHJtAJI1wsittLk4qkct9lkuEjMH5klNoW35JS5637M1KLbyE/X5/vJsCKSB+RvslfUc42Ua6vnWBE9KroH7Y2+GSyEhtHZ99OQxszXWQr6reh2CBrvL/zo3Jxr8zZblAejl27K2/+zA1JDfmGjLYkMaH5jTtqt6bmSQsgWPpHLffNNJINFp2nFZf1AQ0wCqXkQZ5Wup2jRqlEbq77M0c6p1YUTHmMzkKQS9MMV2C9SyLTunSFo1w0E/GKvC+fDxsAZWnXUXQer7PCaz+ewaj5w0HfY+9JxVKiOXq8CMp6KZmOQwPdtOmG2XnxxsQ85jeCVFyM6KCwphA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRnN0t1TXQrczgxQVJkeWVyblpOemcxb2hMNFJoaHJycVdjcGFtSGZVQnhx?=
 =?utf-8?B?WGRUSkZpb2xRcmpBVjkzM1dGblQxU0hmY0FSVGI3UkVvK25xeGdNa3Y4Wkpw?=
 =?utf-8?B?dkE4SU5kNGFPS01VSm5JbjJVV2xPY2lYYVNvYlB2cTZWYkw4OThuOEw5MklF?=
 =?utf-8?B?Yk9ZamZpaDV1eEN2YU9iQmIwSzdMbDg3QUIxMXVHQU1YZnVCUFY0Y1NRUm91?=
 =?utf-8?B?YzJ1bjlIeFJDeVVqakFFSE0xQVphM3pRTVR0eGlDQ3BDWWc4L2QyeUVLZk85?=
 =?utf-8?B?RmE3QXpKeDIrNVhPWnRYb1pIa0ROQVk5dmVpaTZ6Rm42aFFQZVNPWlkyeWxW?=
 =?utf-8?B?Q0V4RTRBRkt6c0hSTk05M1BaeHJyR2VwYVNyd0Z6S3NOTzdqWUJiTG9wU3Zo?=
 =?utf-8?B?ZWRyM2I3blFkampiOFV2SkZPTmJwZHhYQThzZ2prdXlJa1JKMk01SU02UWpU?=
 =?utf-8?B?K1c2eWd3NmV0emZtZm52MlpCWlNwVXhDd3QyQmhiamNMdHhkWXJQZVVGTVZI?=
 =?utf-8?B?bFZYRjdzY0kzUDVxYWVIdnZnZXo5OXR5Skp4eWNxVjc2SG5XNGZSZ3hOVzVN?=
 =?utf-8?B?R3NyemlOVEhnZGpCRGNmUDN3R0NMZjUxd0U2YmlPbll1dU11ZWNJSFIvdEpo?=
 =?utf-8?B?SkJKSEdYOTZYYlZpQ3BBckVOaXA5aEJEanRydzBDUkFrbDgvRFdIajVSelZa?=
 =?utf-8?B?MWtuU1J3SzJpYlVlSE91bmt4bHhQR2k4a1VFQlowODZRSEhuMy9SVkd1S09W?=
 =?utf-8?B?Mm9tNVc3TWFCNmZIZXlJbG90T1FwM3ZmK1NLb09NdG1RM0F1dWZsTElhZ3lw?=
 =?utf-8?B?Si9BL0FtdzZGdFNyWmRsRUx1WkxYRmp5cVA4VW5XTHdIdTkzUzJjU0t2M2VI?=
 =?utf-8?B?S2ErTStLbmh4eFFiK0pvb05wWFJXMUIwOTFBSGdOMVJpaVdSNXlKMzZnd2c2?=
 =?utf-8?B?bG5kWDhNNGlMVE83bmUwMFptcFRCd2prV3NQTnBGQzRwNEtseVRRTE9rUHh4?=
 =?utf-8?B?T01YNFZnaUVBWEx3QVdOcnArWlprRzNUa0UxSGhTV25VT0VMVmVKcVNEcmZH?=
 =?utf-8?B?eFU4T1RGLzVNU0JqTEQ0UHNkdkN1ZFVXMWg3WWdhd0xRQVY1aEFBd3A0dFF5?=
 =?utf-8?B?MDlhRlFRdmxkVjEvSHdjRWdnbEcydlNNWjFDT2ZyVzdBS2QvVkJJaSszTkpP?=
 =?utf-8?B?UUM0MjdNZ3lGc3lyaWVsSXJ1U3JPaDMreW1VbSs4V1B2Nzh0WnNmbU9qc2hH?=
 =?utf-8?B?VzB0QXdWSnRJM20yaVppWWtwaklsREprUTRJYXBmeEh6dUdxQXpqZlR2MmhF?=
 =?utf-8?B?UlVWVTBXb2luWkNLR0ZHYk1LRDZHYWtmd3dYa3I0MmxuMFVDaStqK3R5V1Uz?=
 =?utf-8?B?WWZmKzR0WkJkbjFxd2ttSWl0cFAxSk5UMk0wQldrRkQ1ejk3bDNwR3JqU2Nw?=
 =?utf-8?B?UFdSRUt6anBmeC9VS2NoSGE3bmRDWjNQdlFyNmZ2UGZHQml0OGxjVVMzRWlw?=
 =?utf-8?B?L0w0V1I0bytMVGJxV2swSGpZd2xiWFpja3cvbXU2dkhJMUxrOEFwbHhybmNZ?=
 =?utf-8?B?ZUhObXAxR0RIWmlsQTJkK3h4cFJ2cWREKzBTb0RlQlNuTEMxTktTSm8rblMw?=
 =?utf-8?B?cmY4WEVFeUlSQzlROE9RRE1PeUwxOGlHenZXWlZSVWhMaDFObFZ5RUltc0dN?=
 =?utf-8?B?WkZCOGJ5ZWFCZlRyWWltOEdMZHRTY0JFaEZCOUphbnBOb0RYanBMdTU3a08y?=
 =?utf-8?B?UHY0bEd0MGQ5YkUvWE1vVUE1RTE0UUVNMlgwK21Rck1wbEdjLzByWHUvK3Qz?=
 =?utf-8?B?aldZVE9HNTlUSWxDZm8zUURleTdsOC9RRVU4bXRmRWIxVUwreGdwdGtjc2s1?=
 =?utf-8?B?bWdjU2E4VllJdHF2c05XMFlhalFVbnJHcTFwOE0wY2ZhMzB0aTV4S3o2NmlW?=
 =?utf-8?B?UHIwTHhKR29wNThUWFJMSHFha3QyYmFZZWdDSjJRald4alpwRE1rMFV4YlRW?=
 =?utf-8?B?dHVHSU9JdWRFVzhvejZ0TWFMV2FVQ1BxdjVlbjZOMHpYL3YzWkg0K1ZVd1Vy?=
 =?utf-8?B?U21jSjFWQU5VR1NvcGNhc0NmQXZpQ3U2V2NwWWVTcmg1V3Uyb2QxY0o0ZWVW?=
 =?utf-8?B?YWZtdE9YdjgvZDRubXp5cUVlVUtvMkNDeGIza29KajU4N0JsRldkS2tJelVV?=
 =?utf-8?B?UHhmUTM2Rk1FcDBEVWN0NVJRYndNOU1tTThhU1R5VjNtTGNQV2I4R2wyOSs1?=
 =?utf-8?B?TEhkOFBCbCtscm15NkN1aHYrMmxUNXNTdy9GdmR2bEE4QTR5OFRoTUYzMS9B?=
 =?utf-8?B?bkk1eVo5TTgvSUpaeEIwb2NTRGpPMEhYeFp0cGN3dStaNndEd0crTFR2cWdj?=
 =?utf-8?Q?GqSHsbpwr/Q7WzzGL9KsSL4eJaSIWZCqd5WRsTMa3gCN3?=
X-MS-Exchange-AntiSpam-MessageData-1: gWo+URcUheK3Vg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbd6990-5474-442e-8f65-08df11fd02fc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 01:10:48.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PU5DNoIeSxdMMwom7Kv4c2p1OdOsjPpuKaYh2Cwymx8evUMXLRYtVl7FcPoxISUVd7fVRHqmbzxU6VjKK6JMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

On Sun Sep 13, 2026 at 11:17 AM JST, Sagar Taunk wrote:
> As pointed out by Sashiko, `put()` trusted an unchecked `as` cast from
> `usize` to `c_int`. When the length exceeds `i32::MAX`, that cast
> wraps around to a negative value.
>
> `nla_put()`'s `skb_tailroom()` check treats the length as signed, so
> the wrapped negative value slips past it. Further down, `__nla_reserve()`
> and `skb_put` reinterpret the same value as unsigned, turning it into an
> enormous length and triggering a kernel panic via `skb_over_panic()`.
>
> So, validate the cast with `c_int::try_from()` instead, and return
> `EMSGSIZE` when the length doesn't fit.
>
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
> ---
>  rust/kernel/net/netlink.rs | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
> index 3c2b142a7402..f929f63b32c1 100644
> --- a/rust/kernel/net/netlink.rs
> +++ b/rust/kernel/net/netlink.rs
> @@ -88,11 +88,19 @@ fn put<T>(&mut self, attrtype: c_int, value: &T) -> R=
esult
>          T: ?Sized + IntoBytes + Immutable,
>      {
>          let skb =3D self.skb.skb.as_ptr();
> -        let len =3D size_of_val(value);
> -        let ptr =3D core::ptr::from_ref(value).cast::<c_void>();
> -        // SAFETY: `skb` is valid by `NetlinkSkBuff` type invariants, an=
d the provided value is
> -        // readable and initialized for its `size_of` bytes.
> -        to_result(unsafe { bindings::nla_put(skb, attrtype, len as c_int=
, ptr) })
> +        let bytes =3D value.as_bytes();
> +        // `nla_put()` takes attrlen as a plain `c_int`. If `bytes.len()=
`
> +        // doesn't fit, an `as` cast would wrap around a negative value.
> +        // Which then, would feed a huge unsigned length to `__nla_reser=
ve()`
> +        // and `skb_put()` causing it to panic via `skb_over_panic()`. S=
o,
> +        // the following check will reject it instead.
> +        let len =3D c_int::try_from(bytes.len()).map_err(|_| EMSGSIZE)?;

I understand that you wanted to reuse `bytes` here, but the original use
of `size_of_val` is clearer and keeping it would also reduce the diff,
so let's call `c_int::try_from` on that.

Also the comment is unneeded. The change of type is justified by the
fact that `nla_put` requires a `c_int`. Any further explanation adds
confusion, and the mentioned `__nla_reserve` doesn't even appear in the
chunk. This reads like what an LLM would produce, i.e. tediously.

> +        let ptr =3D bytes.as_ptr().cast::<c_void>();

Same here, the original line was fine so no need to change it. So it
looks like `bytes` is not needed at all.

As a general rule, and to make reviewing easier, it is a good idea to
keep the diffs are small as possible. Here the commit message says this
patch validates a value, so it should limit itself to that.
