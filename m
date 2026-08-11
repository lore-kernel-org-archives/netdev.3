Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B452F25F3;
	Tue, 11 Aug 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449728; cv=fail; b=g+9RPiyegkm5v4TEgQcnXUhPp35T9HsVwQPWPIlq7bepgiYNsgE0CbBr4gH6wTrr/qRAKtd06TaXQ+UUOsiteSo8r06Htc4VNKnKFNp+mwK833YAlwsklYpD9A1GVgBuoDkmz4TTF3XaLAZMed42BEiiiFe1KlGOSk1Gse4esPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449728; c=relaxed/simple;
	bh=FPQfYXwDtlM92Vp8g5HXjiEpA30uYS0TeHJrjvdyqcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LFr1R97YMDd+tpBhAzZZH2aeTFfB4G0+QgrOKQFQOR81p8AkxElmkCCtkLn2nfs5tYJ1ABat1+iJp47E52f8QfFTWQU7I0OYJeRrn2nN7NxxZbncGNmABPk9uZpnh+3gIyzNydMheS6SpUSaoCVRObnKZh4CGFSJ/B1xWgbFbrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=HKQNS/sC; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="HKQNS/sC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzgEFs9NoEJumFu9xLcx5gZ1w5BdsRVgluvtHXz5g/4EQsf0MDpqoPgvySe2J0zAmIjkw6nDIXz1hTO5d7y79iXqIAfPtbvZKdNu2Xsi8ZdqlNMyPWu8GkDqGYe+LkU9San4qJpRjepipntL0/phU4bfHfTkvmn/jKwzOPVEmmZqj+cjiNq8HTvUa/jnoeCNeruz8X607p3nguSFWhrU37IAptuN9GqgZbeCUvGajDIlnO1Ffpy3ekGndngT4L0sl5xFkrYtC/kmuTfolxDZZdE9KHSASHFztRSBsBwCHd2r8WNmBgXBeYrb8ZFasdTU4mZCapN6I97RmTh52dhsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0DZs7RrSxKnyRjddEtGvS7Nlvwoisbq5N8kYI5PPe4=;
 b=KYko3IDymcEKuxJ7BY66/uKqEzb8mHXp2LnKPoz/UBnP/hsZLHyf70BFmXxCYMoQeaGCYq5CLfvGXBFDCRw+JJBS3lZtR8fEHma8VxYTQVNh+qotzumaRTycGjx/DUCvaVyiLjLDML7mKcF7Xs06Ien5OsY2PyUd2bKB1BKf6PY5SxsyCxUKjMKHdIShajIlQla3aq7BqzRJu75WNO2gnHBidnZXS4HTPpdvQ5HHiNMZwHBVKEFI92f6z7Waz9K1zrDxj8a9N9uoO/4HfHaGMkrdmAOVUE09XV/XIzlHLoWLfrDZzBXjzOG7Vm8+muG5vqHJZBMyOKPohbdWdCK6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0DZs7RrSxKnyRjddEtGvS7Nlvwoisbq5N8kYI5PPe4=;
 b=HKQNS/sCQeRHiP75IRxZ7+KBJBbSZ+JahE+GxhQsQ2FUx6Kbu2F6AZUHBEtLq5aHkNXUTJapogqzOD7MhfO5zwaO5gJ1EbrbMq/4VhA8uyy74IouFzDhXURHUsO66X8q+vimHtynQ4uwFYeQOJ/bVRQVM3JfbeYEyT3ctbA7+zsEvqiQoUiv/XFawom/gwFpN2+IqoZE27iYlX+TkQLNbdzFLwPRT67sSTKDvlWyMcovLb/zMAX+oIjic8pA0Nn3E9v6Y2O+r+k1iUgU4Uh+VYAakgD1ffFJ40KXsGpqCZy0BkqKkasfvGZEf2yVCCNNMI47iaJB0cGVhvt2ns04iw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV4P189MB3159.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:28c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Tue, 11 Aug 2026 12:02:00 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 12:01:59 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jun Yang <juny24602@gmail.com>
CC: Jun Yang <junvyyang@tencent.com>, "stable@kernel.org" <stable@kernel.org>,
	TencentOS Corvus AI <corvus@tencent.com>, Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: read le->link under the node lock in
 tipc_node_link_down()
Thread-Topic: [PATCH net v2] tipc: read le->link under the node lock in
 tipc_node_link_down()
Thread-Index: AQHdKLKcVs/UMqsVFEeFHzPIBeAQ/7aYwErw
Date: Tue, 11 Aug 2026 12:01:59 +0000
Message-ID:
 <GV1P189MB1988A045F145CE510D3BBA93C6DD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260810102147.48191-1-juny24602@gmail.com>
In-Reply-To: <20260810102147.48191-1-juny24602@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV4P189MB3159:EE_
x-ms-office365-filtering-correlation-id: 0a778f11-d419-4f22-59e9-08def7a058f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 QdVI+8S/eO63zhJObGar9cdYhOyCK9woKnZucmOUQZc3EBeYUaxR4SGvD/VAFRPIHp6euiSSW0uDoTNsN+Kafn0Jqy1aZkzBmTfGpciwjX5ylBXQ6PVD8lCSUT7OGeE6f3fQe8g5oB0Ue+NmqlgCAm15EHbuPPzKpw1p6K3GeQTclng1yhxLfayBRXcFUW6cTx1TreUMkKkjks019wlzeto5ybOFn3m+vIn/a1glPWWIXu1oq7ybXpQNDrWQPWESduBQvFdwNb3q49/s4dXkOBsdwsjfmtRlYzJevQjdSbeNOkDJ0Msl7lQdesHzv0zWUJ9OsnMDmKTImLKa1m+CH0BawrP6XWDEYpFKLGbdquMEloVFBlQAi0wXUKVL6AjgKRwjmk9RE3JF5JrZuzvoX9gDdUbNcnI9uryFmMmhfbIBASvDMeL4EzoVf8b0Iig+UpJE2j4THuLnP9tbqQOS+6oUI7D6bsgSgJio+oGKDUXrjYy1OPQcTZT2l7QygiU6Mhsv9YDPJH6kOE0Fg96pOPgDwF3Sydqub61VYSaTmgfajG1CW/cVk6NlMH8WPldzEp/tGjL3F3XY2P+gzVC4NSGQhKOdZocbS80HNNb4DmT121kSYZo69NELDaQiEJtUiBBDY0rvC2d4pWYq5kjo453ScRSWslua2d4bVeR4D7PY1j1ZfPSJS5X1Ps2cjrCjT5uqnRoymjgGAT2CPWR0lkv++UkuyRA6hoJOQRfnn/I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E9hqT1MpHfdWd4r25HJ7qUMLVUn5aFV1sEkKH+FC+BD7Ev5qe1jedF/I+Lrg?=
 =?us-ascii?Q?Wv0PYed3NcwiW3sMZA+bMPwDJMLNUodsHGUVnshoOSeac0wC9WPbH6NehaNV?=
 =?us-ascii?Q?YzNy5gbus7M4F4oLS/EhZ0LUDiFds0GwvAb4J6FWP0izK9fHnSKKr00B3NCG?=
 =?us-ascii?Q?8n44Xu2a4Ahq8WhtxumDWm17OBPVFwl8g8mVroQJHSvjFNgKgWpC0sOrzGDI?=
 =?us-ascii?Q?d8beJYmU0IoyV4Ea0UQ6HO2xVMfeTFZgYUEfUM+U9HqvM8NQxDiDGSBdGUNC?=
 =?us-ascii?Q?Y3FpcZ4cZ3rV2bBHNGUte16Si6bYtL2Xl3TflhTzj7URx1/PWMfWE3Tp6SFN?=
 =?us-ascii?Q?A79eoOi+MVjwoQiM5I0XoI7SiSYxd72/zFmC2sktWBwfs1E0TDeyGHfabbh0?=
 =?us-ascii?Q?fkrI7N+onqh6oV2JL8AUerUbwDwn9ynSoY8U0ZKvG3vjZ3wJAmCeyPCm+s3N?=
 =?us-ascii?Q?Itdi/3pJh6SUPGrn3Ri/1YbNTMXoB5WF7B7pHFeobASbXr5Jui+wtOvA/cT1?=
 =?us-ascii?Q?34EwVrhxnopAXrgirVinCNh6nMt/3ILkCyMM961MOKQmzutZTsnZwd/yIUK5?=
 =?us-ascii?Q?j/z2kTSrv+Ahm3TDkeIT9Ri7VuR6mTVWprugQdmgO63b6YuW9Dq13vugfBwu?=
 =?us-ascii?Q?nXtp9k3hvqfvQrlNIbiea99ATxccWmm8JpivkAHRNX3lxKyY0JCM30FDPQEM?=
 =?us-ascii?Q?5BYhxdSr577sb1MDoNaXUQK9wQ8cN9MBCtJaaCLtZJ7HJ+v2TSCoDYq+RMoV?=
 =?us-ascii?Q?FkcZBbcZT7og+I5WY2M7Ws27QppT3NvMTi4QiIyyD6mnEOaT9ou7fX9lnYRu?=
 =?us-ascii?Q?fRsfB3+AgBJUAraSnZN9nOd8gHrT/YvHvLNSXV3jE1hZpvgj0130lwBwR5LM?=
 =?us-ascii?Q?8TzPi0IULq7HhaF+m3HeOBpHRsLhlPBQ9YgAFOAg0uhH+wQ9cgoT8n1Uk8gT?=
 =?us-ascii?Q?Ur6VMFAnABIRgnSrNzP9628o6jlh3awNmu74qdrjxXSZjxt1tDMfeUB4+rjr?=
 =?us-ascii?Q?PEWb+0RQN0ztditVndtg+9M4CCJ4Ev1WnNzyvIjKzQ30hd43KvqJlTtBxeSl?=
 =?us-ascii?Q?Rp/pLYwIFNFEEqQMfbXzqG9ESD+ujFxUkRbPU+oI/DREJvmqO5P5mx9vI1YK?=
 =?us-ascii?Q?yFUutmrPqPekH8upOpPhhGJHeexI9VR7Mcj8/986Ks3BHs95y4UKKJT6esCF?=
 =?us-ascii?Q?7q0L2LB/2+WDfn/Atoq/mvmn02gD7/1baRea6FLWsPkcKzlpH0cbnchtTY5d?=
 =?us-ascii?Q?xvMNCjWXru24yo+mg3kTpX0eUwn73V0KvpGI7+BuytffiKpOPoc0CzxwEL7D?=
 =?us-ascii?Q?QHjX2/v6NYlaOgq18QDCnAiHg7XOazBQnayEHpE+Gdniw1Nr4/BXsuQK8N8c?=
 =?us-ascii?Q?sFFI0fCa08xNRa0JQGU4A1jyqPJYrTzmVsMT1WNVm9SnAt1KAZB6H8KtrcvH?=
 =?us-ascii?Q?JyJ9w/sTNTDyFy1Qpnx3sOkOTOd4hFXBBx1r1OJBDy7PlinOQIzzvllFSfhl?=
 =?us-ascii?Q?NLY2PsvQ+71Tgjfq1g7C2MMYK/0QHVpk01tDP/MxLyletUN4IX3PEAng9iMH?=
 =?us-ascii?Q?a8xZheHscF+8jbqkEcWFShLXYdutLY3LxAviUcmWMUeWoXsM8wZ/FELysewu?=
 =?us-ascii?Q?hXDFDL9hvbfZAfG4G5Kxf0XcEuML6xOu9jL8rEuoNK1KC/BqmB8aXVgV/9kg?=
 =?us-ascii?Q?DVCssw//aWUI1megSDLDm4ToCp4c7Nda1w79k+9VfwjS62QL6okF4oKGBNnT?=
 =?us-ascii?Q?XQq6eDUkGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a778f11-d419-4f22-59e9-08def7a058f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 12:01:59.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiajuaHfxgaUmVpGBvvMcEq2tz3Ohm+VIAuBCor2L8XVTvOfVgX8ylY+tAnAG/sNysfpdjYw4d+5Ed2SV0+O58bV3IZYtN9qEVL4aHu25j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P189MB3159

>Subject: [PATCH net v2] tipc: read le->link under the node lock in
>tipc_node_link_down()
>
>From: Jun Yang <junvyyang@tencent.com>
>
>tipc_node_link_down() caches the link pointer before taking n->lock:
>
>	struct tipc_link *l =3D le->link;		/* unlocked */
>
>	if (!l)
>		return;
>	tipc_node_write_lock(n);
>	if (!tipc_link_is_establishing(l)) {	/* deref l */
>	...
>		tipc_link_reset(l);		/* write into l */
>	if (delete) {
>		kfree(l);
>		le->link =3D NULL;
>
>The delete=3Dtrue caller frees that very object under n->lock, so the lock=
 does
>not protect the cached pointer against it:
>
> - CPU A, delete=3Dfalse: tipc_rcv() on TIPC_LINK_DOWN_EVT, or the link
>   supervision timer via tipc_node_timeout(), reads l unlocked and then
>   dereferences it under n->lock;
> - CPU B, delete=3Dtrue: netlink TIPC_NL_BEARER_DISABLE -> bearer_disable(=
)
>   -> tipc_node_delete_links() -> tipc_node_link_down(n, bearer_id, true)
>   -> kfree(l).
>
>The link is freed with plain kfree(), not kfree_rcu(), and for UDP bearers
>disable_media() only schedules the asynchronous cleanup_bearer() work, so
>its synchronize_net() runs after the links are already gone.  An in-flight=
 CPU A
>that has read l therefore dereferences freed memory once B frees it:
>a use-after-free read in tipc_link_is_establishing(), and a use-after-free=
 write
>via tipc_link_reset() on the establishing branch.
>
>The following trace was captured on 7.2.0-rc5-00284-gaf39eb111ce6:
>
>  BUG: KASAN: slab-use-after-free in tipc_link_is_establishing
>(net/tipc/link.c:285)
>  Read of size 4 at addr ffff88802e2aa068 by task swapper/2/0
>   tipc_link_is_establishing (net/tipc/link.c:285)
>   tipc_node_link_down (net/tipc/node.c:1076)
>   tipc_node_timeout (net/tipc/node.c:843)
>  Allocated by task 9549:
>   tipc_link_create (net/tipc/link.c:490)
>   tipc_node_check_dest (net/tipc/node.c:1279)
>   tipc_disc_rcv (net/tipc/discover.c:252)
>   tipc_udp_recv (net/tipc/udp_media.c:389)
>  Freed by task 9549:
>   tipc_node_link_down (net/tipc/node.c:1084)
>   tipc_node_delete_links (net/tipc/node.c:1320)
>   bearer_disable (net/tipc/bearer.c:414)
>   __tipc_nl_bearer_disable (net/tipc/bearer.c:992)
>
>Move the le->link read inside tipc_node_write_lock(), so it is serialised =
against
>the kfree() in the delete path.  A racing teardown now either has not run =
yet,
>and we see a valid link, or has already run, and we see NULL.
>

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
