Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022129.outbound.protection.outlook.com [52.101.101.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5C5208B1;
	Wed, 23 Sep 2026 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188431; cv=fail; b=a9hjMplkDSo8dPjbTpExTB2YjA5xd3zFvpeBILlY2CGb8WCAq8KOgSBCzObgw3Ue0xzgKMvg57w0Znx9AP/1BBgJwjy397l5IVQrynBjw3c+bRlmEI/KJ5tpX5zkO5SbOrLRZzg2mI6vvCW9Quc91M6Rd2zVM8j/TFQnguvPc7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188431; c=relaxed/simple;
	bh=/EQw9qyo/DVxI3/BKWSf+TeK1cNkQn9hHp9WByK/dEg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ulNIXXQNIRaeyD6emIXd0LogHF7b2JbvNoFRvSeSyWlugicnj3WShdl/kPqPzc6RpysE99g6NBfE8qM2/W7RVREsCMXK9NX1t3vz4C1J+7N8lhZr3KIs+BI3N/yvdg6tkgz/vc6Y/2mrwzV22pfVCiO9E93S1blIFUvQFfTBQdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Bh0KDi7e; arc=fail smtp.client-ip=52.101.101.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Bh0KDi7e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlMJeUQxzQ6PAPO0lXLsheUItmm6zdhds9AB7buoJaoLiQKjCh4Q5//AkooyJNn0ATo90zbUMd3Qqj+2PyBowr/KXKSDWiht7Ccep24zQTa3EYXlJgLW+2XZbMRdda7mS9LYC/wznCyb1jxxYOjZbihIMRvl3oquOLbDUM/RbPDCZiSg64M8pmJ4fCiXjWp2pPSwhoceOuTzVUYr7cAOSX6RZ00tgLmGD24sRG/j70NZ3SEtQqAaIaoW4oIWIsmnE969rYOPLfSMvK2Z110OKJMU9NzCiH+nqEaJec+DinhzN4DG4NbdODMy5uLGMEgxOR3HRT8EqhFSbnbASl6uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp5Jb3Ej+WK8k79Epx1J36WqH3vm+USebdc2i6k3GkA=;
 b=biEjtnatbaBJOk05HzENL2j62u+VaA/8j7a1lAz+WMRj9aYvfP9mYzu0bSBrmblRIdeix72NiVckUQS2sllKnn49enzXKfbTBLBKx4wmNnOmiaLgy1CvdOJhGKvTa0UD89+r2414wIWOBe5HPjnT4j3J1gDCg9LG2Uyyl3QSvxyaK+fVoGH8i8q1i1jf6Slt6Rdc4S3ib35VQ3DwwHf1QQoaTOmNqlJUbaP+0J+rpLriQLC3NuQsoO5P4kXr9ZSIZcI9PhernxtoE43LwQStStzBVFvsz1dbuaOcjxWTYxvcjYchqKjmU0MCnAaolsX/B+D03ONP/GPj/px5z/yOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp5Jb3Ej+WK8k79Epx1J36WqH3vm+USebdc2i6k3GkA=;
 b=Bh0KDi7e5ROkigUcOO/h6yeX3xwrkcPD72M86ZH9BG6fzT/TyNMC/dz2H+v86oKWoJdEnnwYJp0UI3C/GrVMhLC6LZ/XBeEdN9D5QxZDWcvYgjZYUGYX95cRaWichj90i++MReKAw5KmnXm/q9WZxpjgm7ioTfNNJ88a9tuAsvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO9P265MB7724.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:33:45 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:33:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 19:33:44 +0100
Message-Id: <DLMWU0SL8U5T.ERZRZTLXNRGO@garyguo.net>
Cc: "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4] rust: net: netlink: validate attribute
 length before casting to `c_int`
From: "Gary Guo" <gary@garyguo.net>
To: "Sagar Taunk" <sagartaunk@proton.me>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Matthew Maurer" <mmaurer@google.com>, "Carlos
 Llamas" <cmllamas@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260923120504.9100-1-sagartaunk@proton.me>
In-Reply-To: <20260923120504.9100-1-sagartaunk@proton.me>
X-ClientProxiedBy: LO4P123CA0393.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO9P265MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6837c077-e417-491b-be34-08df19a13354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|7416014|366016|376014|1800799024|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ryvuqIE0F9fwb/XWGo3S/1MNCJIE11wowCT9VHdZP+U2l45buo7R9fRPVt6GKhdokhKP/bwKlJefHKzoWBVD8Q77IKtd1xKXtoOSzyAYyv9RrE9R8/4OsA69zAzMEa8E89OxiZm4CiHqWjAxyFJKWI84LHwROxRrhhEsDSBhWF0doK9AkmFm14rrZcrIxqzHcpkhoxIpBx56xY+ZoZoKg9uQ5Po270Dvbg53fJ/jYZnBjBtbE6oQCg2fzD7+B2vY/GOxJr/qs8dPWL2vdBRfgBD2lL2nGJzGtzQZlIHD7IiQ5BDQP4nQ+yNP8WjDlCNekb0K/EcSC0ZTTX7oFwSGD2QcHJvGDMqPh3ZlRwlV64ef8Hpo/hbVne0gkPU5Gm1llByWHd43tKLj9AdI/uzZakWcZzRhVukoyoryzNpMjxZ+/nIHpA6ozWigdE9YdViWG0JpFObjxnMyz5wpx+Tp7HexFigLuKcFXrTexdlYa/uj5hyVdIHeLdV42QD7xMn0779lo+5Lv9Jkgr/AwDa7WRnhaCoFMeGeUHEPyL22TPd45E6vTLykAlcl+KNOKWmYM0XZqgUD6YD2mTiv81TXK+CnDWgvPUchOT3gsM0K9srKV2jHbDVHuaENNdpSPwm3vzu+CHIRBaFEL8+veN+qnWdVP1y5WkbACDXtNrVxaaJvYZhfLyR3eeDqbFWciap20WIpeoV5JVeSmsrtCRcFsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(366016)(376014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGlRS2lSMVZHd00ybDFMcmtRak56ZE8ydDV1MWpDNjI0RFN2V3JEWEZBVXla?=
 =?utf-8?B?bTBvYUFhaVZxM2R1VjdvWWlRdU5qbzh4VmJVRmZ0N2w3ZXB3S2crQkgwQTQv?=
 =?utf-8?B?SlViWXllZkYrSklVRmJtMjRuM2tzUzVYVFpmbkowc2lKL0hwUjAwNTllQzFm?=
 =?utf-8?B?U3hGV3VITnFSQ3ZMdWJkOWVCU2NxT0ZERHpxNUZ2Y1lhZm41Qk9JVnNDTEdr?=
 =?utf-8?B?MXZ4RVloSEdYYzNzbUxTYm92M0FNSC9rRk1Tb1NKWjJuMENGaW1WR2FWb2tB?=
 =?utf-8?B?d21lNFZ5Z3pvbXRvT2phTVp5UEdXMGlZWnhxWFMrdkRSdm1NZExKZkxNaklI?=
 =?utf-8?B?WWJndTAwRWx0aUxvd3JtaEM1bUQ1VC8wZDBWeUF0SHB0ZHZwdEpMT0JrVGVl?=
 =?utf-8?B?a1VaUnJOQUR6LzVuQndTYjJuaHpDNmtHeW1yZlBGbGh3MWxxbzRZcW5hak9i?=
 =?utf-8?B?eXc0eXZsM1pTVzcxOU9hQ3FOWkZVbjZyNEdLYXFtMjRRaWIrZ2tyZ2pOSFdr?=
 =?utf-8?B?SDgwd2hpZHRLeTFiNzVFenIwUXcra01uN2Zub1lNZ2VNTmJQaHNPeFJISXFG?=
 =?utf-8?B?RU9jcW1pYW5kc0RRTmZ6bzJRRjhUUkVIVkFoZjUwS2pESlVSUVlXZzZvRVBa?=
 =?utf-8?B?eXVXd1poNjNPdmpOckV1ZW4vQmNVM3loM2pYVmlPSGZFRTdFS21LY3RrWm50?=
 =?utf-8?B?eWU5dlMweFRzL29DMnFlRXp6Q0JzMlFva2pJZFZydmM4Vmh0b3I5eHllOXlJ?=
 =?utf-8?B?NEY2WU5aTHh5RVBKalRwRE1oU2lMZ0JhZlluU0lOdm5vdVZEdmI0QzJyMlJw?=
 =?utf-8?B?QVYwL2g2SjJwSWZzcmlUcjhRQlNVU0gveTdyaUt4SG5Xb2cyNFZqMU9uL0ZB?=
 =?utf-8?B?bm9kWkU1WG0vbnhkdUVHM3NkS1ZWbmJmUjJBU04yQ0J5cWlpSEdJVkpZcnF4?=
 =?utf-8?B?ZSswNnlnWG15cEJTL2NtVTQvbzduZE40TlYyaEpOK296UUhZMWZiYUV5YmdC?=
 =?utf-8?B?UU45K3N0OHl4WW5RYlJhbVJlVC9ESmRXbEZPM3hkZnl0WU1RVFRSUncvcUVF?=
 =?utf-8?B?TGpZR002QzZOOGFFYTlKblpIb2Ztc0duK1NPRTRRb1BrY2RhaS8vZkxheXQ5?=
 =?utf-8?B?NG9YNE5rWW8rbmtnM3A1QjNkaDg3T3dqOWh6dWZRUVBoVHpnZTR2dWtxb0k0?=
 =?utf-8?B?enBwdGsrUWl0TWNwMndPSlVUa1JmZUcyOW1UVm9nVkxXM0xKSFJvRWtFNTVE?=
 =?utf-8?B?LzFLYzRlY244R0hDOXpoWHg0U0JVY09OTXdPY0dnMk1icjBCY2paRTdhTlI4?=
 =?utf-8?B?b0I3aGlIT1BFOWQzZkVJa2FlOGhLUHpYVXgySXY3ZU9RSVlYMlc5YTc0SjBR?=
 =?utf-8?B?SzVoS3l4Lyt3SjZEZlg0OW5abngzWkRlWS9ScS96bzBYYmREYU5nZVdsVzdm?=
 =?utf-8?B?c3NQelg1MlRVZFVCNzBoQnNKZkpvN25VbVEyb0RBbm9Ybkw2YUFjY2VxSStS?=
 =?utf-8?B?OG1KMVlhWDF2Wm95THR3SURENGxGZXdaWktITUZ1TUxyd1JKUzYrT25DTkhZ?=
 =?utf-8?B?NndkcjQrYVBEMnArMWtiL0puV3pqTjFlclltcytnK0UrTnpTUmU0TkJiRzd3?=
 =?utf-8?B?dW9xSDRwT1VKcGNEbEdYSkxoU3Z1WjYzbFJYYlJoS0g2VUZqSWpacHZiT0dw?=
 =?utf-8?B?TEh0dzlFN01sdnNtbWg1SlJyRTBMWjZxU2U0c2ZnT2pCNnNnSlVWTkI5VkJU?=
 =?utf-8?B?QnVlTGo4NXpZZ3U2YzJZNVRVaERMazhZaldER2IvNnJqL3plckYxVmFYKzVM?=
 =?utf-8?B?enpZT05BUlNJenoyZFRhZkxUWWlDMTBUc3VZNW5ROENhUEJjR2tobXVucS9t?=
 =?utf-8?B?Yi9MUjRvMTBBTzFUVXJiQWV1SkJFSjdGQUNhR09EL01zZmdGMlpLSEJFeUNP?=
 =?utf-8?B?M1VaZ2wyZCtlN2lGV25mRDRqTlZvSlBuam1kaUtkTzBST2NOQkh0REhmT0gy?=
 =?utf-8?B?V0hCeUxQQ2NHc1NaK0puWWtCdU1rWktlUkEwTHdUVWd2aWxES3lWK3R3aXJa?=
 =?utf-8?B?dGVSYysyMC9qQ3p3S3BlRFNZcmJveVNJZG8zdW05cmw1N25yTjdSdnEwQ042?=
 =?utf-8?B?Z2RVUjhrU0RyREJLcS9UK3JQd2JVbURKZXVkeCtxRDlRRm1aeVM5SksvVkVP?=
 =?utf-8?B?SUQvNFkrUE15R0pEbzk2Z2J3eHZjazBBNlJmNkJPeGxEY3hoYWxIMDF2UWww?=
 =?utf-8?B?NEZkR2Z1a1pUS2U3Ull5emxtdEhWQXFweG5aandGOWVVUStEWmtQZ3FiUHds?=
 =?utf-8?B?Y2dHWi9JNEpGMjBOZEl4eWI5cnlUTnlPSjdCNU42RlFBTEprQWg2UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6837c077-e417-491b-be34-08df19a13354
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:33:45.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp36Mx29unL4Zmwo1I2woCxeB4rI14N0KcNK1g/AL+KtOxhpgHdqpBlb1pilrXts/5rVcaJXTtsIde+D4ZBKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7724

On Wed Sep 23, 2026 at 1:05 PM BST, Sagar Taunk wrote:
> `put()` trusted an unchecked `as` cast from `usize` to `c_int`.
> When the length exceeds `i32::MAX` that cast wraps around to a
> negative value.
>=20
> This ultimately resulted in a kernel panic when the reinterpreted
> value via `__nla_reserve()` and `skb_put()` became enormous.
>=20
> Validate payload and header both fit together in a `u16`, rejecting
> any payload that wouldn't leave room for `NLA_HDRLEN`.
>=20
> Fixes: 5eaa5fbb6e6c ("rust: netlink: add raw netlink abstraction")
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Changes Since V3:=20
> Rebased on the upstream rust-next tree.=20
> No functional changes.=20
>=20
>  rust/kernel/net/netlink.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)

