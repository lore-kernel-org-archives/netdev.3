Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700B37F8DC;
	Fri, 17 Jul 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279624; cv=fail; b=VrLugRjHz4A3ZVW4T/ILXqkFXtQlHqcfZZOl+ygp5AFremP6yNiaVa6BsoJ6qwEivkN3J3PuOSLy6T6sGXC4U7B/bJ5HEs5CTgdKrjjiy8WMEj6KieLyERthfg4Cumep9tYLFQNWHzfjQmweIWckL9kfy2IWtCs0IOx5c0ROWwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279624; c=relaxed/simple;
	bh=6ds4xhzPOvceDeW+k96MYK3RbL5dJVULVbF4rLx5zYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rG9aLhfjqaX1M+SCNMPFdNK/pywy9+beTTnrHM15kA3dzSjsnwvk6wad3yt3PkAQewgw8CFuokLec/HFooTjHuKTyS5QAhucGUmsESdluAA8fneaiLLK8iSM7MOu1Hr+6Y2RHo5ePDNiI0QW2wdHyUamWe7SdWSIBlj1FKl3ulE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=jsnSYMG8; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="jsnSYMG8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5Q/mi+i07dUyHIaan+a1ZDM8jaOPpTDHL4FdqEdIKOyFlgMT4H4bNdK4JAcIrP4ZTJwmDepu2eGL2H58pM4a+HarDZDz4PSUpa9Lt2Lf2JcHzFp8XFe0mGxBcmRUINWAxkxyPydUBPjbEbsY576kt1KN6lW7M5SKxb++CN4raeG/NUOveOOCIVeWUwPkcE1pTLMQkv4j6GQaZfWw8/OMpGon1qSb7DjBo0e2CTIPcm3MbAZk9wbrL6dhRDMTf7ZKKdWe/W2qz2ZRcGqjO/ehh69etN/+kqjtkrJ4gV2PGd2+mgqix6JbUcqYY8TcKts0RfU6VRBu+gdPK5bp+JxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xlQ+EdpimH5AN5ww2jmnbYw/H4RYeEKnfp/QD89+js=;
 b=KBn+gDteyatgvIuDNbRCRvi137/E2j5pqKMHSapOwQcwF95RPT/ngulxENv2PUfRrzDJdOSn4JuCPXvMdm2tH3jYBqfmVBVvexiTM8k0WT1RTkKnw+Ejpig59Tki9Zh/y7vaGR/HLoz5wOoSDUZSOwB8lKzGtQmPtNYslXscglVFclAzOKbSdx26IDT5BiuL8hZqEqdSy/Qpts8IYHFJHotV7Z5aPA23+WyZwekOJbV4lKll/vTPFF7QTNmeR99h4vO03Vvyt9PyfHAg1FQBFpeh4JrN38G412F9KCSCOXoljfoDBHs/E7UWNsDl2WRIUDHYWVyF9claXswYW9RRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xlQ+EdpimH5AN5ww2jmnbYw/H4RYeEKnfp/QD89+js=;
 b=jsnSYMG82Wxx5KcjVo6NI5+JA7qo8Cj+epv6vJWowt97dlXtv9qDTPQ/AVc6X5KNL56716bYlGIm1SYvzZ/OckaXBcUYwZjPYv3/01YBx4T/HQnc3auSeZB2UELM1dykr4kJWFN5QkqI1uAigJlRidS7fcknuKi2JFboZyxFLo1gBrLUY6I0eDlc9uMV2RP6R9VNt38cmRzy5cEz8RXFYo+zfTieEFEcqJBIJOUcGvFH8AhZ7tOiX6KzVwgtvyvP3LSk1v9VcP4J0XL7dxnMA38TX8+r/TqULvXPMif7aVyAiaoRmkov3u7G6QPeQlGlAoKeJZoXYUhb43fmmoIEvA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV1P189MB2266.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:9a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5; Fri, 17 Jul 2026 09:13:30 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.003; Fri, 17 Jul 2026
 09:13:30 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xmei5@asu.edu" <xmei5@asu.edu>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net v6] tipc: serialize udp bearer replicast list updates
Thread-Topic: [PATCH net v6] tipc: serialize udp bearer replicast list updates
Thread-Index: AQHdFM4hO+O+GRnC1UeP0nWooc56mLZxbv0Q
Date: Fri, 17 Jul 2026 09:13:30 +0000
Message-ID:
 <GV1P189MB19884D4B38E8C3999DB10F2BC6C62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260716025203.9332-2-bestswngs@gmail.com>
In-Reply-To: <20260716025203.9332-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV1P189MB2266:EE_
x-ms-office365-filtering-correlation-id: 3d9a72b6-4eeb-4446-ef9b-08dee3e3ab43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 BFBjXnBSyHbYqoVWCfAsU8dBRBDqTeb+GdKo8MNxMun2n8RzEUaNIKfxZr2QekP1eP2Xs6UieDqdqV5cH3qyvwuqr9vF8wKzyJSRFQfDGERUtWgbWnOsCo2MayKJl6Lb9PNVtzAnOXNU2vEetaNygbpSFI6FGcRTFXHPj/zd84F3Dd0v4Nj3hclYOyTsvbZXww3pwdRVToHLbJu169N21u5YTo0r0i+KMLq0aHgEfAlGX6fqDMyLMOMbRj9gtMsnggmzV1A94VvfbIw10ElCKv2Z1YBeJefJ9uMTrpSHSOmgWQmygSPMSv6GFd4OCQ2bvA+ukbyMlCvphKOp4MF9hCjzl/jRyB23cVI9w2WLTzw0sidDkUTnppEwefyRjrDpvzp59vH0gwdWToMNaYX3EZzo/FXe43yojTxwEyhEWU2G6bQRLC5l3bMty4xX6AJIXRrBnUECizA4MUrGELbtJRDQfqg66GY+oQeXS1BeKdyu7QLwE2m/dnFocU/u7r+9tnrIISnsVqCUWPwlRNN2z7qh8d/2CyfsgYDfKZuR2sZaOajU+U4PTbZPxlu+PKJgjOANcwmWsmxmaXdTA0XCyVRhqzuON0hGWEghEdqRdl9BcN06lM96y7Nu6HWbT1RDGEpc1m4LVB6M45VwU4rOIzQ2c7m8UC53v/PjtrPQLaJGrUbkP8hSd1ePxjabXBWjSqkVW6zWU8EzGnwSyCZs0d/kX5LgBZnV4DiNRDjdTcA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qfyFhRo7Nnsshp7tf774mRMQAgxmvvY+cUOSl3uP6wRN9MkXYho4h9lr7w1f?=
 =?us-ascii?Q?vw+ZmGYrvmrx2Juve6K7ED52T9MxF8bLwourWRmbYHcMSJ1XW1pr/tsEcisX?=
 =?us-ascii?Q?CaECdWtCW+qjcx4tQ2Oef468ov9Qci9TZwkJJ87oPkT+drYAosnqXOyF9nQu?=
 =?us-ascii?Q?1KNLL9vNqYpIE0/wJA03R8q1okqCafwgnuNbXf+ZJaoJD5GJS0SlQQC89XKx?=
 =?us-ascii?Q?1hQN50sbITtsLh6Zgr+aFY0vurSpTNPc5TwbncDMjFe3+ZrQXB/eJcg5XgvB?=
 =?us-ascii?Q?gObBx3I2yPwAVWXHqP3AZS/tUb3Stw7sv07oY6WzNoLKLqBqp5WiJXN2ng65?=
 =?us-ascii?Q?fb74HXNdMQZtosLfPjAaRlgoZvELLrW2q2epx8LFhwgdEXfNbgJP3VHp0csK?=
 =?us-ascii?Q?Y8CPTBr//UA+lxolzvDIYYN7YxOYT5CnFfVZLPqRceyfpHKnbHNcICsAjAjI?=
 =?us-ascii?Q?vLyFr7NGLJnxW2QY23KEKT9dfwGtFvgIcHHwfgiXMJ7ml0M2GnWumCHC7rJs?=
 =?us-ascii?Q?axGXamXPwTD+Vgkd5Tw/MW3AKzZRU9vhNvzVBWLW0ZXycWPUu16epziAb0Ro?=
 =?us-ascii?Q?fkQ2EzK8IKid4OEESQtPX2Qpfq+DFqF9/MPcosg+RK++PZ3qSvU7HyXAoUpC?=
 =?us-ascii?Q?VoIkJgqwMVhHKiwyqnOg9MRNfLjJD44CQ8hf4Hc5zCILW8XBsLKNxtRdZFrG?=
 =?us-ascii?Q?w1S1imUhz6X80qr4LhoGXxrD6DL1cNBapMALtEtEb4Zs7n9dnPzXL4hffhj0?=
 =?us-ascii?Q?JJaWaRGRQV7vBUNJX7D4jq4tI+IeW7ceAoG210spji92DhcCa32kmMAYvi0i?=
 =?us-ascii?Q?xY2MBQPN9qWwv7JZ1vQRv7a1NutkqsBJfT6fcSiXRhtvRgcTjKoeAQbpo3K8?=
 =?us-ascii?Q?K+nnd6gPSPkEytOuckrEVYFfd21VPubJJCanKBWCNSrq7soL/85az4vzRbJ5?=
 =?us-ascii?Q?8MgxciRxJQE0LedqYjJJpe2kW6aK0yokj09Dv3t/sLJE4+akpIiFMjvPkiVQ?=
 =?us-ascii?Q?qtniPbSEFeGMFDdWWWG70LxzwRB2vJW7V377+GSFZo/sUswONcsZ1c5MaC5t?=
 =?us-ascii?Q?h/+0dgNGsFLePb73f8eX0pEJg8lijPGxsqm6xwQUKNSzSdqwppU+r9rFnLE9?=
 =?us-ascii?Q?o/bJcm7NgAhilRGGiB04V8cWiyUmTNOtiI/5xNxBUa97I4cvxrq95ZGYblyk?=
 =?us-ascii?Q?YG6AvQzes96J1iiqfHxn5OR7gxldoJb+cpnmwACeN5KDpi7ua90HSC0vip/4?=
 =?us-ascii?Q?UPk3obelo4HKR1nFLgJYJHuhvzL4ZdnBFrVQfkPlRNl8IIQwsokE0lu4rHcE?=
 =?us-ascii?Q?VJEvVdvsHx1CJ1qnScmsoPgBI4SM0dSLAE3aAWiflt47djKdHw20OmDjO98w?=
 =?us-ascii?Q?oHpALGaqKr2CBfIh7iTvFR3IZPpV09TygZHmCIniqRhjNo+zVRtpZ7WS1Se/?=
 =?us-ascii?Q?YR15s6qAeqvMt7nbMA5Ok34a4TsHR1VyMSF/8hio7FigwXu/UYRlSveVzXsW?=
 =?us-ascii?Q?a0DC/WgpcCuRQYVQvFMWgZthJlbSLbI7HmPMD5dxm+yjx58FlkDoTmUeIy0j?=
 =?us-ascii?Q?cTNHfGSOIsqLr9l3Tff7rdKSYToejQnpojSyWVwGoct1uZCV0uUJjrOYhGoD?=
 =?us-ascii?Q?7r7xTZwrKHFx0qITQP2PtPVMiU0VDC+sudLRYz5wJSyHNv/FIb8JF8GOS/Bf?=
 =?us-ascii?Q?M/OomlG5KeHdYpFimhEA80Z0UdhsPi8HCtGo2P3zwZgBRJ/YHzHpsBDac5g6?=
 =?us-ascii?Q?i9RZgYE9BQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9a72b6-4eeb-4446-ef9b-08dee3e3ab43
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 09:13:30.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKd/+BnLZm7XWJFpT7p2osDBElN8GnOxQJGm0HyxbC2fuZvthYnVyG3nirSFjikSwQ0mY6Rmg4YvwLaVoB0PoKbB7MOW7mPeABDCMeH5gUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2266

>Subject: [PATCH net v6] tipc: serialize udp bearer replicast list updates
>
>tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
>list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs=
 from
>the encap receive softirq (via tipc_udp_rcast_disc()) without rtnl_lock(),=
 so it
>can race the cleanup delete and corrupt the list:
>
>  list_del corruption. prev->next should be ffff8880298d7ab8,
>    but was ffff88802449ad38. (prev=3Dffff888027e3ec98)
>  kernel BUG at lib/list_debug.c:62!
>  RIP: __list_del_entry_valid_or_report+0x17a/0x200
>  Workqueue: events cleanup_bearer
>  Call Trace:
>   cleanup_bearer (net/tipc/udp_media.c:811)
>   process_one_work (kernel/workqueue.c:3302)
>   worker_thread (kernel/workqueue.c:3466)
>
>The bearer can be enabled from an unprivileged user namespace, as the
>TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.
>
>Add a spinlock to struct udp_bearer and take it around the list_add_rcu() =
in
>tipc_udp_rcast_add() and the list_del_rcu() loop in cleanup_bearer() so th=
e
>two writers can no longer corrupt the list.
>
>Reject a duplicate peer under the same lock before allocating, and remove
>tipc_udp_is_known_peer(). The old lockless pre-check in
>tipc_udp_rcast_disc() was racy: two softirqs discovering the same peer cou=
ld
>both find it absent and add it twice.
>
>cleanup_bearer() runs from a workqueue after tipc_udp_disable() clears the
>bearer's up bit, so an encap softirq can still reach tipc_udp_rcast_add() =
and
>add a peer after cleanup_bearer() has already emptied the list, leaking th=
at
>entry when the bearer is freed. Mark the bearer disabled under rcast_lock
>once the list is emptied and refuse further additions.
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
