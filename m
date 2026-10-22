Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792631343;
	b=ANZIwHVafZNgZwc38MgwXfltlHRNvldRBYSxubCysu/iIy8EgUdDwvfA5dHuSgmRO7bp
	 8/0dkY94AiYzmIj+5n/FDJzA81kDoBxHuPyFZh18mk7D0Dnv2oOtB3KP3czXf63v77FjN
	 sVH3LzcJmxou7UwfDYNj6I4M2lnadZQP201T0NiKWtg7Vw+2hmfE6D39YBNv3aqZ8oiq9
	 F9cbwObKfjm31C3edQnwxMt8MW35A3kQmkKVVvdE2fxz1Ei1nUqwd4nSPIsRm1aj1UBJl
	 N+Qwz4beGSFpuINpWaID9PdKkj2h5v4q/llciSmu7bXUbzbXjGpbtUNFCmwKG2C0sLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631343;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WBJglHFaL1QdHgGmbgSVASAbtSJ4w1jcjSZtErNF0S8=;
	b=IY+sTA8YTnX9cS04gSc65VNhTAAAKMY/EvHLfYybCWFkt793QWTntmLG/eowqgEnkD1N
	 pNxT58QO290UX94istltp7Sf97/PCv1ghh26eVLq+T5P0gu+jx/4Cca3/4pTXwN+rvFvJ
	 c0uVfoTjC367EDco+DBR58NElXP1+BVg5lfXfuB9IqN9av1TbwiDonCQvUTh4bOCOpw+M
	 kRfbJiH8lmHwsixGkeA2PMtFQL2GhrTF++Yr+n1udMAz0qwUQdb5E9WxAw9NQprbFioGc
	 5W44VUNf3wGkZSAZFzYs5GjMUJQZcHzLiCOnMoukPGPv6+tOZxiWD2tkbxPJHk2ZFbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Hu2MVBNh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.7
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BC606A319;
	Thu, 22 Oct 2026 01:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338BC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Hu2MVBNh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTuGmkqKe7s7hAbYvbr1P1pDzDVR0GGcQ1W6JRoULJTwc0HNeUD2CKKqVWQew576E32l/TqBKsbf4P8/DrU8VC3niPX1EwdrYLUhqENVl+Y/OHzVP9lAINo0KxeI17Ont2vEJ840XgkEdrpDEGC21o2qHm9l9yNyN/yMwW1QkfZarNdoSLVW0uvo71NvjGnCsFQ76VdeIvDK31YAdgunor8j8QqRriilsSCojDFGRJR6lRoAZh3dJKD+VRhQ5q2ocEX6pVCpg0Bf0buO8YH7V+S/uvAlhwXZUYgXuFHBRPUTm5HSRDukXqFhLZkTNP4Pb/rHtqHDxcBxMpN/B2a+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBJglHFaL1QdHgGmbgSVASAbtSJ4w1jcjSZtErNF0S8=;
 b=jra5i7U9abedNcoplPw2YnXukwY4iBTlp87AMHTKBSV+/nws85OCSWIHPNPa8QL5exbqto54lltTNLAfenruUrI/kMcuY8xa/z4v1Aawr87Z0atgHbFcukiP1ZGfnhCTfw0wkij4IgDp7YmCnMOP7/1p9bfqBF9SMRSJM6b+yaxxE08f4bKJip7GXPoMLw4OXJsn5Xl3A9kPpoJRlF29YNrIZRWst6+kpdBu+cBhZa/rZztR5XXuxoezkMDSwEA6qtR1JLJ1aOlWdubPZkJMmMzpPGazRcrBj9f70CtiKsmv1sgT4uRZ602GB9Guxcpm5guCEguzcD8tPXJPwm7OYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBJglHFaL1QdHgGmbgSVASAbtSJ4w1jcjSZtErNF0S8=;
 b=Hu2MVBNhirt3RMZ6ij07LkQ+Bs13kNDgjhwdzars29S1ufGntWgsXSeIcFsHWZe0qbJbeS8vwGCrpa2LDLu6TqbY4UUfwEEh+K1Wa4aVBohEt8ydipuEsoKAeNZgWM2qIusgAGJPtV90AhVR2pIPX6Bntq74UYAcEJHLOrYkhjuhah8+hiXNZAs3VeYDL+MGXt2rNResD335mgRLDS5HePHmuY5Ot0aJL4csvQdtmKEey88fd/LTWfDz4AXp5NqxNNCEqPylem+AhVl2QKYBY4xQnxkcixfkld+spGYGpptqwRGJk2T20sIHBSSzP3yQ8UxQxaDFUWZHhupitcXjmQ==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by DU0P189MB2114.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 01:08:59 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 01:08:58 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Binbin Deng <18983559317@163.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH net v2] tipc: fix use-after-free of broadcast reception
 link at node release
Thread-Topic: [PATCH net v2] tipc: fix use-after-free of broadcast reception
 link at node release
Thread-Index: AQHdX7bH/kxOkPJq4EOJaVKpB7G8l7cIw5pg
Date: Thu, 22 Oct 2026 01:08:58 +0000
Message-ID:
 <AM7P189MB1137878B37021286E2F5A553C6652@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261019104352.488347-1-18983559317@163.com>
In-Reply-To: <20261019104352.488347-1-18983559317@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|DU0P189MB2114:EE_
x-ms-office365-filtering-correlation-id: dd5969d8-fc67-4039-add0-08df2fd90d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|38070700021|56012099006|260925021311599003|261009223327099003|11063799006|5023799004|260925022911599003|261009221727099003|261009223027099003|261009220027099003|260925021911599003|10067099003|261009221227099003|18002099003|22082099003|6133799003|261021121427099003;
x-microsoft-antispam-message-info:
 KSbuLz9RkTqps93SMilvSBzzq2PLY5YQuIjGBdGyrcZMhUHO2YXqIoy22RygR1/iSBMNRSMQoDiqh1dSN4H4M6dCwQYjSraPdambc0DzHhbWaY883Rvw+BrHCMF8hnYB0BlECDmAUjIDTIVY1paE2HEU+hEGUzX1P1z2dobRovHKdBfvHgxAGZPpfjNFX/Kz3PauFMcV3yXBniE0gGTwI+ly94ODvK9bjQSbYmcBMfTm3yK31OObJNGZnimufDRa7Y5byuHlntCk3QryTvTifOD6KmaKTcbfEq9irVPAQQB9hQCtoBUPnY8aU1YAR+Fmc/PerwHt9jhZcl2mgI9i52lM+cYf/TV4ja7oT9p1z/Nxqb678a4rs9Bdz5tIuKMZ9kC5o4UNPCQ3L0NthBpmSK92vkc7UmNTUoTkq6abRXQwYxLLmt/XB3KLA9sp1CA8wnLzmnSq1QV+rT9tbkrkZJkl42IKWQDFntR0kDeE7DBG6zy69+yt2BaSBLaWRGUpe7rv5kkhTOKxLDFJ9Xbp9ThHW4hfGAD0cI9Wmc8rmCeVTlgcsjHGCnm9HnYwra/eUuT81Bqiw7VVbw+xDZU9dQVW/rq9fLutzCJ9YvAnUEFmiA/qwuyYXvxtmBsbLTmIaxQbz/5fITNzZsmkxwzlb67N3oSTRaTX9KMexRRLwnVwmqSqUx5jIdBHGjLCVR4rnR8e5IsDvhpr8eCgQuPZPg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(38070700021)(56012099006)(260925021311599003)(261009223327099003)(11063799006)(5023799004)(260925022911599003)(261009221727099003)(261009223027099003)(261009220027099003)(260925021911599003)(10067099003)(261009221227099003)(18002099003)(22082099003)(6133799003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2h7wOCIXKAIP77sEOXmKRq/P18LZGi1jzyJAqqsSLXzOcTR+UyhIRrgDj+tj?=
 =?us-ascii?Q?8jNgJ7HHgR7LMruInNhmdR/DIGbAPr1mhIay678347R8tMrMDBdraVTpaOOI?=
 =?us-ascii?Q?14x8sreVJFs4xRHeZlCTbB504FUtgcobxX/OeC8pUehES725ngNt0lgoImtS?=
 =?us-ascii?Q?M+ypUZ15ba5wCXHU8K0Z5xX8tvFS97M2Yr44QjEP63SkMUTYUBgdvKVz4hi7?=
 =?us-ascii?Q?2raQnF0uLxnZtaMI9sB8tzkqelleuY1ow3ASNgbX30qlDR4RmxHoaCS2L7yM?=
 =?us-ascii?Q?aK0bWtZeCJH0RbC8YybiXrDYajkPVUi4NatVBeZ3XQ2KTEJsTykSZGfBmS9g?=
 =?us-ascii?Q?aGmWM5+35nCkhPhZHuL99+5xj8AzIgmcb3Jl+y1lfkiMxmxezN2xgObr3jt6?=
 =?us-ascii?Q?LCcGCO3lblehGxJT/5Ov/dcCUZkd7QRQm2voVcs72WMXkBPOgbWAk7KlEKNq?=
 =?us-ascii?Q?zwbAfb/Xz1tD/AvexvPHPNRHXZAfD5zhXm6yGccNPDC0A3f4Q1iQ0uMd2oEs?=
 =?us-ascii?Q?XZ3IR/md38PxsLlEfFkEAGy/UjR5I3O+S95JtDL+6CMRMdLvAcxYQ2MPH2wR?=
 =?us-ascii?Q?hfIYHKx/no4rEyvCs61iwoXsKsZuMfQrahayDLHsfj2/F9IjN5VJrUKkvCIh?=
 =?us-ascii?Q?0j7Ff7ZV4uLzSvOZj67Tunu6oLUXPSdzXRCLBy47muHIYoX9SmbIqdmnJFLs?=
 =?us-ascii?Q?ytJY1lT4tipYYBMcS/jz+alkEm+StWap0BfF0K2MNAsynEJADWn9IiR4bpwe?=
 =?us-ascii?Q?8vUXHjlXlm4qmh6O8geG9xEjLKer7aY2xe/HG6bjobS152sNeCOIw+L+eHAn?=
 =?us-ascii?Q?0M8XGKkvFvouoYfqDbLC9XNUQKgkZzbcqnpZV2pJgPKRS4v+fupnDEoBoUgC?=
 =?us-ascii?Q?D0PYLKTzVDyFJ1WmC8lx8AWWmu41vKJHJdtxvogmS2sLliEjMinPT3P6NO9R?=
 =?us-ascii?Q?ABPHzIDHojzS8gh6cOXh4ZFeSgofMvlmFHWBgtzlZuOLbso1QS98bj6UDpgz?=
 =?us-ascii?Q?3qSanP/PjziTef3RMlTwTBnsCzAEOuzzW1F1+QdAj84SXMRlyknR2Pblxfe+?=
 =?us-ascii?Q?wmbKuB1SAP21t0j0Fj2+zFNJOuAqTRdOEAo51hyfp6La7uT0C96H+SdKZZtZ?=
 =?us-ascii?Q?T0OpZQmWkb9+KZeiw3Ske4li4WzFSqwwY6r6rFAq7JIkbqBDZ+OlGV1sGLcc?=
 =?us-ascii?Q?s+bGr/7tMNDLH3MEBdXbTYU4ZDFTbQK7uj3tZVuGikLOVLV4UwkeiDPdvaLM?=
 =?us-ascii?Q?kS+wRbcfpEYtBb901EWgyrUp/HQxPdAfsbTMQvfosHmUvABy9mzK2nvkbO3B?=
 =?us-ascii?Q?OZL6VLCT8B5P6bJC+gILO6g7u6H2xZ769CjLNoQJrrajqyDa8n5C3bsNL0s0?=
 =?us-ascii?Q?ISSC1JSJQ68UbGHCeRA8AgSqq958M6qeZ17v3fw/oifLOYLeaH2S0aY3j0w8?=
 =?us-ascii?Q?XQi9RteeITRpxu9lP2gk8gS40xI9JfkM9ntotD7vGngAcPWE1mGh55rCXorx?=
 =?us-ascii?Q?6efguM9ZP+GBYWD4S2dUxhSZ3NUS3ZEwKH2N5Ry0kdTx29EF4lzQrxYcVB8w?=
 =?us-ascii?Q?IpAabvCN0LlCMaUmxhAzOXyVCaRrcpbmrMfe0DVHKPBQnWQ/QcJExxBYwUMa?=
 =?us-ascii?Q?MwjvvxUcHDT4pKpHbMwqmz2pyMH4uX+oGukcg3n8ecejdl9zgBxpqlsUw5et?=
 =?us-ascii?Q?+2lxKKpjBDz/pp/WDgSBLGJB8NDWME1Or5346lg2FL0mxc5fy4SR27ciRc38?=
 =?us-ascii?Q?gW6BE9QxJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5969d8-fc67-4039-add0-08df2fd90d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 01:08:58.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmSs378ro832N4J5ukuVj/eRAlY+2+ix0RFU+/Te6uhPuaaSU/hdjBymjgugd7z928CQx+9FH9VTXLhBERR4iqpwf3ZOG4P5OzQMiljNuXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2114

>Subject: [PATCH net v2] tipc: fix use-after-free of broadcast reception li=
nk at
>node release
>
>When the last reference to a tipc_node is dropped, the node itself is defe=
rred
>to the RCU callback tipc_node_free(), but the nested broadcast reception l=
ink,
>n->bc_entry.link, is kfree()d synchronously in tipc_node_kref_release(), b=
efore
>call_rcu(), and the pointer is never cleared.  Readers that obtained the n=
ode
>from node_list and then dereference bc_entry.link deep into the link
>(tipc_link_name() in tipc_nl_node_reset_link_stats(), bcl->name/stats in
>tipc_nl_add_bc_link() on the link dump path) therefore touch freed memory
>although the enclosing node stays alive for a full grace period.
>The sibling per-bearer links get "kfree + NULL" under the node write lock =
in
>tipc_node_clear_links(); the broadcast entry was missed.
>
>The race is reachable through the node cleanup timer: once a peer has been
>unreachable for NODE_CLEANUP_AFTER (300 s), tipc_node_timeout() ->
>tipc_node_cleanup() unlinks the node under the write lock, and the final
>tipc_node_put() at the caller runs outside node_list_lock, so the kfree ex=
ecutes
>in timer softirq context, concurrently with genl dump/ reset walkers that =
hold
>only rcu_read_lock().  (A netlink "peer remove"
>cannot race those walkers itself: tipc_genl_family has no parallel_ops, so=
 all
>doit/dumpit calls serialize on the global genl lock.)
>
>Reproduced in a QEMU/KVM guest running v7.3.0 with KASAN and
>PREEMPT(full): 10 TIPC peer namespaces on veth bearers, bearer removal
>staggered so the 300 s node cleanup timers expire while other tasks loop l=
ink
>dumps with the broadcast filter and reset-link-stats lookups.
>KASAN hit within two cleanup cycles:
>
>  BUG: KASAN: slab-use-after-free in strlen+0x85/0xa0
>  Read of size 1 at addr ffff88800b54a004 by task poc_eth/371
>   strlen+0x85/0xa0
>   tipc_nl_add_bc_link+0x2f9/0xd40
>   __tipc_nl_add_node_links+0x10c/0x140
>   tipc_nl_node_dump_link+0x8d5/0xd50
>  Freed by task 0:
>   kfree+0x121/0x380
>   tipc_node_timeout+0xa33/0xcf0
>   run_timer_softirq+0x144/0x250
>   sysvec_apic_timer_interrupt
>
>with the freed object being the kmalloc-1k tipc_link allocated by
>tipc_link_bc_create() during peer discovery.  The same defect fires in
>strcmp() called from tipc_nl_node_reset_link_stats().
>
>Move the kfree of n->bc_entry.link into the tipc_node_free() RCU callback =
so
>the broadcast link lives exactly as long as the enclosing node.  All reade=
rs are
>covered: the netlink walkers are inside rcu_read_lock(), and the packet
>reception path reaches the node via tipc_node_find(), whose kref defers
>kref_release itself.
>
>Found during a static-analysis-assisted audit: candidate sites were surfac=
ed by
>a Coccinelle rule, and the reader/writer paths were confirmed by LLM-assis=
ted
>(GLM-5.3) code inspection.
>
>Fixes: d25a01257e42 ("tipc: fix crash during node removal")
>Assisted-by: GLM-5.3 coccinelle
>Signed-off-by: Binbin Deng <18983559317@163.com>

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

