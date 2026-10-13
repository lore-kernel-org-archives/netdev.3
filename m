Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6B39A806
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881528; cv=fail; b=nscd1wTsvQh3KAY0TEhD+2oTSzDiMqyo+w3ua2eIqYrf/CZQI9PkjyfPh+VeSPPeXUSp3tNgziHvAEhsrP/9Trp4LnK99KWBURA50PyLN39vuqhU9UHMA7PZyH13Ndogo3JqNjK2mZ6nNBGwQ+dnEZ60w54lIaiHZdyiTP+WH1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881528; c=relaxed/simple;
	bh=qLA2tKL2iIUr5Do8GRocZUYimQB28AiQW0ikFZ6dgsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChaDfLxgZsmX+YVBWGo6jE63Q8Vl65vnSUfv15e0akxE8zF4zoKXsKvPzmwXrXbl8tatdE4dCm3BmMidXZlGSs8RLGAbiXq/GHX9Ol5guJPxOL1gdFc7dp84UVWqZS2oKh+zEzs9HcLYeRu7sstgVeuIZDErW4CVcNj6wjErpaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=l/8eS3j3; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="l/8eS3j3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miiJRoSlF5k9hHBEOfhFQgzPzAWGlTpqCnaodAIUzJ2Ouc9KiyJ2RKbkImTo7NuGqtZ3cVeOfoUWBlnVGTQvk6gDi8++19EWlUuvTgD9WN4Fg0JXJt+bwBgudEa6x8BtkzU0Q7mLQb3RdfX1e2xJAxmOqm+HN5tAs1iq+YkSWN+D5NoUpsDS8p7MTc4Mp0YKE8ElGhOYRVppzxjMrzRl6tF8OZN8B+dxljZjAFJhHcCH0XzzlTMWXN1vI+tf/Jzmth+gdsCO08b9JBZQ0i7dpKINAlLEpplzRV7rSc240K/iF2YsbTc1wgNmrxJt0b3M/GsZ6jTZ6PF1e64ENQ4a7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCsyeDPA/yR+ahRem9+6ZsiSuE67BRuzB7+sJt/NkEI=;
 b=hhWK6dqmUlJoCneO/ri3/8W0EbjSm/2dUJ2vmMN4Ay3d0/+ncMaPUIyKrTuCcDBwyhUt9ZHbuYw/QkXQ8SmuhjvnJ/GmFUZJcKbF/9m1XDhSkrXZ9ffPesQViXTOvNDBkrlWgDW/xW3l5xF+D6rSm6efMH47fy+lbEvP7fezboENj900UDuTp7DxPdmPgQQC53kEuuPhy8xUhGqsn9br5V9A6LAyvAi3CwWVDituThvDDKaZeq/haYv5hrvcA9eOy6B+S6ArIBew/nuwaJ7qH+r8tKaV01T+mWGvCAYgzWW7Uog11Ise9nFrit8yorR+NjZx4ycEe4mjhk2rsL8wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCsyeDPA/yR+ahRem9+6ZsiSuE67BRuzB7+sJt/NkEI=;
 b=l/8eS3j3EEAc5Tw6dKWS/D/GzU2sDlloOQbOVVP6CWIlJ6eUWIVS8tf977i6ygvG4O4TU3IK2XcfIVTuDNi8gaKRXVMvrLTdCTFR6lOr8nINBSIxSlXlMWgjJyR3oy6k6/rWJBDCgjEOlQf+NkdHM7sL0AJ+8VtVD/43a7wwjhAEk+p4Ktz2m80VYr13zPkFU/rfojySdQjU4QQsJTz53W95U8GlO/PiJxB5Zipdkuf2tSKF3yd3PX2I/bcqSV6FBKTNAGsM0da+BGXpJI5oPpUihKJqBuaF5BR2PDRkl0K0kOZRfe09flVN+BVZ/85LWaiN0L+NLHCh/BOIlrJDcg==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by AM7P189MB0696.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 08:52:02 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 08:52:02 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "nicoyip.dev@gmail.com"
	<nicoyip.dev@gmail.com>, "lkp@intel.com" <lkp@intel.com>
Subject: RE: [PATCH net v2] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
Thread-Topic: [PATCH net v2] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
Thread-Index: AQHdVVLMcOq+qWZKzkyKZQTVV0xjPrbyVieAgAd+nfA=
Date: Tue, 13 Oct 2026 08:52:02 +0000
Message-ID:
 <AM7P189MB1137F3721F10B1582B4791CEC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
 <179139373734.434549.8409205365763100703@kernel.org>
In-Reply-To: <179139373734.434549.8409205365763100703@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|AM7P189MB0696:EE_
x-ms-office365-filtering-correlation-id: 9bb48cdc-28f9-4e88-5eab-08df29073ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|4022899009|366016|23010399003|7416014|376014|10070799003|6133799003|10067099003|22082099003|18002099003|5023799004|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 verbSNt9rZun+rp8CM3MdqTpzvPTeTN6cu4LOUi6xuLq18sb2VWnRQ6h5S4HbK859DMbnb4o5bLEgwQzzsksmpSnxUr5AXSJ0PTrmvZdFQ+rrvuNR83DUQ8VQyiz9hHo2IjcC/HxrmwXC/i0FuX92oC1Sf+KZE/YFa8rnSVOTnurK8o0WbseQOdW3ChP3Fp/HP8LkQhr/S+aOGtWtTsUdEGSVTEy0a/jZ7meyKfS05lP77un3vrUgzUMGNCfYEpfIO2HWgoqwt+/yzbruS6r3cQLTOxHVZrKF5Qc9loZORBd8/t3CdvdgX3a5DRmjo4Yw8gk5ns4cmwocVUG59ji1RPrfwvpXPYLy2t9pavVc5LlEyACWSNHLdFwWU8bfsb6t6EwfOlwu9PPEPBucsW47FLTrWyT79XnNHy/AsCkhKRl9DLDKTisseSa/Ocv0Jes0wIVlmTl3n6MLPCac2U2HqM4HYo3NDqRAnLwV25z3rPbgGzZ27alw8noy1vHZfB+nGDUrnQPEJyB+mQJWilOZFunEfT/dowgFGmCeihrDJqCbfspjZnpOgTfdQmnSukbjNAI1osWtUCeoKXguAQ3HT3roAsUyooa5G1xZFIUuiBeUsoIAJ+AvqTdpNfFHK8HIEenVsyNg65GO3WlN2nycjgFZMAgvGYAhsXyERJChQw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(23010399003)(7416014)(376014)(10070799003)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Lpv4u2xwOlLk/Eo9Vl0eWQT3dkYBwDcPRAkCl6l1pqb2Z7ohj5dTdPa9?=
 =?Windows-1252?Q?mbqmYfUlccF13tlk1S0TxpdB61HewMitHkwwLIhlazJQI0AdFaMS28WO?=
 =?Windows-1252?Q?ILgp70Gc45HNOE+3I7HUGI9yRInK9Y4Oy9W/k7Z1BAhxTnbvkM1VeDj1?=
 =?Windows-1252?Q?w6BuO+lLUkds794hGBHI8hfA6tVRVcY9S84hRt1qE0LbDQLjwQRaxFr3?=
 =?Windows-1252?Q?YAMsYqrOwBK+QgmEAJTnyLXLpnkLsxozouPdo+w0RExzUANkkkQGErf2?=
 =?Windows-1252?Q?X2Dp2IH82UNOXZB9hP9X+NhUPkzBw9fbcL81jbYubciI7P1SDGGvR0ea?=
 =?Windows-1252?Q?b9K47UBzhOBEUVJN9ke1oGn7CArWZEpm0j62cZua7Ozt36ub7N6vrAzF?=
 =?Windows-1252?Q?Khni13tw6kXJgsAxIhI6tvJ+sUGbT9hQeYC5RXfbVyMVMT2bkh3cscRp?=
 =?Windows-1252?Q?9EIB5NSNCJG43Edudzz9iZ/UBqlEWfAKLOg2R7gBdb3PoSGxAtYZWPyP?=
 =?Windows-1252?Q?Jr4LzHrexeczpsD4k2mRck9YVmH9J+gQEJHzTK+QdiHdNCnQUc75DN1m?=
 =?Windows-1252?Q?4DPBlhnjfto4jxhfWWwKEdYtC+Q61+PwzKM4eSVKbrOKSjAaOhpI6Wqm?=
 =?Windows-1252?Q?qEvYpANpEk8prha6lUMF/Fyz5GiNI04XzinmhhyAL+pRt7QCayykz0qe?=
 =?Windows-1252?Q?0bK6SsldVtUmDl27Z4kgmAZpH9JIjrV1bBq+U+leHJsjbQJP0U2MsgRv?=
 =?Windows-1252?Q?6dHgac18Axyj8c1e15xJEzvLgUPfIgy+BF6SPn41uTSqJEeTs2BWodNw?=
 =?Windows-1252?Q?KNq7zm+l2DQ4URJxBdElOB9wMx9tJYFchhaVgCMcaefcNmeKmjER7Rsz?=
 =?Windows-1252?Q?rplYo3+iYN1xeM04qrr0KPhk4XNnW1blcycMUP9NCN7fBh6FRr6NXVOR?=
 =?Windows-1252?Q?j0daHRzjjzMnnb2T2Cj8Oo3aAx6J7Ud8wbYHYRckW98hQdm9RL/HHUsj?=
 =?Windows-1252?Q?9aeNf3gzqnpbmYzUVVCOPu28HGkLrLujV/4SZNPMQPfREnu8aJ1UrSir?=
 =?Windows-1252?Q?3iTnb40cC108VlWNOT55f97mPdiRYYvdWXcHs2329r6ps9LiHPkoqVEU?=
 =?Windows-1252?Q?TTC4dI8KuDuqn+x8HXXA5gVevpLRks3tYo8JdbDO6GPRcpr01tsAasLT?=
 =?Windows-1252?Q?ccuF8XujdkHW/yzjPw1K4h2jMIF+Ws8htJiRThSVvn90jjiuVAUuL9VZ?=
 =?Windows-1252?Q?UEwkFSS0KiPhwXUKKJvmxeYlpn4ylfhJNo0vFA+TCLOltofz4cy9siFj?=
 =?Windows-1252?Q?hSVZxvSRPhEXrB/FwHQToQFn06YRUs/4Nv0rOTb6EgxZSUEzOQF7UnJi?=
 =?Windows-1252?Q?xMq2d71SlkiTxbFtuHaEaGY0seZTKRYWj4w/o6PohYATrliojph2ocjf?=
 =?Windows-1252?Q?EXXAyfHRmmAi5QWrMJcpHYWJkNiudFeUqc/jt3RluPyLezsjI4GvcwV5?=
 =?Windows-1252?Q?lOka123KBOU8S6gi0ZS1xlcQns4qmeTi8e6JeuGoUij5eMn7XrguOQ9l?=
 =?Windows-1252?Q?LTTCjZv9zP1TJZFxSQxgUT+DyCY4nwh4WXj700YUCUcvG6Z/Jtd7Mf0O?=
 =?Windows-1252?Q?Pm1qSqkA2ovO202hNRR0rW40cJMjjjP2FcGz3+hcFCNwRyLwb1vlrVCi?=
 =?Windows-1252?Q?saCrqTX4s3MsGaE1+gyx9Qzd+i/zAz58Rzcc0bIeKUWUoN2RjfAGf3eX?=
 =?Windows-1252?Q?TbLuptUA1L2zgP8w/xlL7MqK/qaBYCk3y0fWVTAnf+IlwVWtV7TMNfZF?=
 =?Windows-1252?Q?iYd/E4g+djoyXfIHGIjT2+zgeh42keWGzsglGWG4KYuhrbHG9kot5UXx?=
 =?Windows-1252?Q?zR4A9wEoAMMLAaumn2gOTPp8xA8023T2uks2vcgoqbboTWgmLZytaoH5?=
 =?Windows-1252?Q?o1OVXktj?=
x-ms-exchange-antispam-messagedata-1: fG62WRitbA5Wdw==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb48cdc-28f9-4e88-5eab-08df29073ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 08:52:02.4490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+DcL7oa7I8p2+GBiJJHM0ZJSw4iH4e3cwD8DcKF4BTtcIcldPS084eyyP5yq/tqmDRDM89n8/8My9RSTF7xNTQHojVklSFQ+oj6zfvCbTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0696

>Subject: Re: [PATCH net v2] tipc: fix several race conditions caused by=0A=
>tipc_node_write_unlock()=0A=
>=0A=
>Thank you for your contribution! Sashiko AI review found 4 potential=0A=
>issue(s) to consider.=0A=
>=0A=
>Critical: 0 (1) =B7 High: 1 (1) =B7 Medium: 1 =B7 Low: 2=0A=
>=0A=
>If you believe none of the issues are legitimate, please reply to each iss=
ue of=0A=
>Medium severity or higher and explain why the AI is wrong.=0A=
>If any of them are legitimate and you plan to respin, please let patchwork=
=0A=
>know by including "pw-bot: cr" as a separate line at the end of your reply=
 (one=0A=
>such reply per series is enough).=0A=
>=0A=
>- [High] The patch changes which node's publ_list a remote publication=0A=
>  goes on, but does not check that the message's orignode matches that=85=
=0A=
>- [Medium] Moving tipc_node_xmit() out of tipc_named_node_up() means=0A=
>the=0A=
>  bulk snapshot for a new peer is no longer sent atomically with respect=
=85=0A=
>- [Low] The first race in the commit message does not match the code.=0A=
>- [Low] The patch edits the kernel-doc for tipc_update_nametbl() and=0A=
>  tipc_named_rcv() to add @publ_list but leaves the locking contract=85=0A=
>=0A=
>Pre-existing issues:=0A=
>- [Critical] This problem wasn't introduced by this patch, but the patch=
=0A=
>  rewrites the affected call and changes how it fails.=0A=
>- [High] named_distribute() dereferences NULL when nt->cluster_scope is=0A=
>  empty.=0A=
>=0A=
>--=0A=
>=0A=
>tipc: fix several race conditions caused by tipc_node_write_unlock()=0A=
>=0A=
>This commit keeps the node write lock held while tipc_node_write_unlock()=
=0A=
>handles link and node up/down events. It also moves publ_list locking out =
of=0A=
>tipc_node_subscribe()/tipc_node_unsubscribe() and into the callers of=0A=
>tipc_named_rcv(). Name distribution messages built under the lock are now=
=0A=
>sent after the lock is dropped.=0A=
>=0A=
>Closes: https://lore.kernel.org/netdev/20261001182924.3928331-2-=0A=
>nicoyip.dev@gmail.com/=0A=
>Closes: https://lore.kernel.org/netdev/20261001182924.3928331-3-=0A=
>nicoyip.dev@gmail.com/=0A=
>Closes: https://lore.kernel.org/oe-kbuild-all/202610060355.bPzTfoXZ-=0A=
>lkp@intel.com/=0A=
>=0A=
>> - A race between link-up and link-down events can occur when the=0A=
>> link-down thread is interrupted before removing a publication from=0A=
>> nt->cluster_scope, and the link-up event inserts a publication into=0A=
>> nt->cluster_scope.=0A=
>=0A=
>[Severity: Low]=0A=
>Is this description accurate? tipc_node_write_unlock() builds the link-sta=
te=0A=
>publication with node scope:=0A=
>=0A=
>	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_NODE_SCOPE,=0A=
>		   TIPC_LINK_STATE, n->addr, n->addr);=0A=
>=0A=
>tipc_named_publish() puts node scope publications on nt->node_scope, not=
=0A=
>on nt->cluster_scope:=0A=
>=0A=
>	if (p->scope =3D=3D TIPC_NODE_SCOPE) {=0A=
>		list_add_tail_rcu(&p->binding_node, &nt->node_scope);=0A=
>		return NULL;=0A=
>	}=0A=
>=0A=
>The insert in tipc_nametbl_publish() and the removal in=0A=
>tipc_nametbl_withdraw() also both run under tn->nametbl_lock.=0A=
>=0A=
>Releasing the node lock early could reorder link-up and link-down handling=
=0A=
>and leave a stale link-state entry in node_scope. That looks different fro=
m the=0A=
>cluster_scope use-after-free described here.=0A=
>=0A=
>Could the commit message describe the race that change 1 actually addresse=
s?=0A=
=0A=
OK. I will change it.=0A=
=0A=
>=0A=
>> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index=0A=
>> ba4f4906e13b7..dcb15de42a9ee 100644=0A=
>> --- a/net/tipc/name_distr.c=0A=
>> +++ b/net/tipc/name_distr.c=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> @@ -218,8 +218,7 @@ void tipc_named_node_up(struct net *net, u32=0A=
>dnode, u16 capabilities)=0A=
>>  	spin_unlock_bh(&tn->nametbl_lock);=0A=
>>=0A=
>>  	read_lock_bh(&nt->cluster_scope_lock);=0A=
>> -	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);=0A=
>> -	tipc_node_xmit(net, &head, dnode, 0);=0A=
>> +	named_distribute(net, xmitq, dnode, &nt->cluster_scope, seqno);=0A=
>>  	read_unlock_bh(&nt->cluster_scope_lock);=0A=
>>  }=0A=
>=0A=
>[Severity: Medium]=0A=
>Can a withdrawal now overtake the bulk that is sent to a newly up peer?=0A=
>=0A=
>Before this change, cluster_scope_lock was held for reading across both=0A=
>named_distribute() and tipc_node_xmit(). tipc_named_withdraw() needs the=
=0A=
>write side of that lock for list_del(&p->binding_node). So a withdrawal ei=
ther=0A=
>happened before the snapshot, or its WITHDRAWAL was built after the bulk=
=0A=
>was already queued on the link.=0A=
>=0A=
>Now the lock is dropped right after named_distribute(), and=0A=
>tipc_node_write_unlock() sends the bulk only after the node lock is=0A=
>released:=0A=
>=0A=
>	write_unlock_bh(&n->lock);=0A=
>=0A=
>	if (!skb_queue_empty(&xmitq))=0A=
>		tipc_node_xmit(net, &xmitq, node, 0);=0A=
>=0A=
>One possible ordering:=0A=
>=0A=
>CPU0 (link up)=0A=
>tipc_node_write_unlock()=0A=
>  tipc_named_node_up()=0A=
>    named_distribute()          <- publication P copied into bulk B=0A=
>    read_unlock_bh(&nt->cluster_scope_lock)=0A=
>=0A=
>CPU1 (unbind or close)=0A=
>tipc_sk_withdraw()=0A=
>  tipc_nametbl_withdraw()=0A=
>    tipc_named_withdraw()       <- P removed, WITHDRAWAL W built=0A=
>  tipc_node_broadcast()=0A=
>    tipc_node_xmit_skb()=0A=
>      tipc_node_xmit()          <- waits in tipc_node_read_lock(n)=0A=
>=0A=
>CPU0=0A=
>  write_unlock_bh(&n->lock)     <- CPU1 now enqueues W=0A=
>  tipc_node_xmit(&xmitq)        <- B enqueued after W=0A=
>=0A=
>In replicast mode, tipc_node_broadcast() already sends W to the new peer,=
=0A=
>because node_is_up(n) is already true. Replicast mode means rc_dests > 0,=
=0A=
>which tipc_named_node_up() itself sets for a peer without=0A=
>TIPC_NAMED_BCAST, or BCLINK_MODE_RCAST. Both messages use selector 0.=0A=
>=0A=
>The peer would treat W as a no-op and then install P from B. That leaves a=
=0A=
>stale binding to a port that no longer exists until this node goes down. A=
 peer=0A=
>with TIPC_NAMED_BCAST could be affected the same way when its=0A=
>bc_entry.named_open is stale.=0A=
>=0A=
>[ ... ]=0A=
=0A=
Yes. Additional queue would be needed to address this. I will make the chan=
ge in next version.=0A=
=0A=
>=0A=
>> @@ -272,12 +270,14 @@ void tipc_publ_notify(struct net *net, struct=0A=
>list_head *nsub_list,=0A=
>>   * @i: location of item in the message=0A=
>>   * @node: node address=0A=
>>   * @dtype: name distributor message type=0A=
>> + * @publ_list: list of remote publications of a specific node=0A=
>>   *=0A=
>>   * tipc_nametbl_lock must be held.=0A=
>>   * Return: the publication item if successful, otherwise NULL.=0A=
>>   */=0A=
>>  static bool tipc_update_nametbl(struct net *net, struct distr_item *i,=
=0A=
>> -				u32 node, u32 dtype)=0A=
>> +				u32 node, u32 dtype,=0A=
>> +				struct list_head *publ_list)=0A=
>=0A=
>[Severity: Low]=0A=
>This isn't a bug, but tipc_node_subscribe() and tipc_node_unsubscribe() ar=
e=0A=
>now just list_add_tail() and list_del_init(). The only thing protecting pu=
bl_list is=0A=
>the caller holding the owning node's write lock.=0A=
>=0A=
>Should this comment, and the new @publ_list text for tipc_named_rcv(), sta=
te=0A=
>that requirement as well as tipc_nametbl_lock?=0A=
>=0A=
>The Return: line in this block also describes a publication pointer, but=
=0A=
>tipc_update_nametbl() is declared bool.=0A=
>=0A=
=0A=
Yes. This should be rewritten.=0A=
=0A=
>>  {=0A=
>>  	struct publication *p =3D NULL;=0A=
>>  	u32 lower =3D ntohl(i->lower);=0A=
>> @@ -301,13 +301,13 @@ static bool tipc_update_nametbl(struct net *net,=
=0A=
>struct distr_item *i,=0A=
>>  	if (dtype =3D=3D PUBLICATION) {=0A=
>>  		p =3D tipc_nametbl_insert_publ(net, &ua, &sk, key);=0A=
>>  		if (p) {=0A=
>> -			tipc_node_subscribe(net, &p->binding_node, node);=0A=
>> +			tipc_node_subscribe(&p->binding_node, publ_list);=0A=
>>  			return true;=0A=
>>  		}=0A=
>>  	} else if (dtype =3D=3D WITHDRAWAL) {=0A=
>>  		p =3D tipc_nametbl_remove_publ(net, &ua, &sk, key);=0A=
>>  		if (p) {=0A=
>> -			tipc_node_unsubscribe(net, &p->binding_node,=0A=
>node);=0A=
>> +			tipc_node_unsubscribe(&p->binding_node);=0A=
>>  			kfree_rcu(p, rcu);=0A=
>>  			return true;=0A=
>>  		}=0A=
>=0A=
>[Severity: High]=0A=
>Is publ_list guaranteed to belong to the node that the item names?=0A=
>=0A=
>tipc_named_rcv() takes node from the message header:=0A=
>=0A=
>	node =3D msg_orignode(hdr);=0A=
>=0A=
>But publ_list is &n->publ_list of the node that tipc_rcv() or=0A=
>tipc_node_bc_rcv() found via msg_prevnode() (or destnode). That is also th=
e=0A=
>node whose lock is held:=0A=
>=0A=
>	tipc_node_write_lock(n);=0A=
>	tipc_named_rcv(net, &n->bc_entry.namedq,=0A=
>		       &n->publ_list,=0A=
>		       ...=0A=
>=0A=
>Nothing compares orignode with n->addr. tipc_data_input() also queues=0A=
>NAME_DISTRIBUTOR messages to namedq without checking it.=0A=
>=0A=
>Before this patch, tipc_node_subscribe() and tipc_node_unsubscribe() looke=
d=0A=
>up the node by orignode and took that node's lock. A publication with sk.n=
ode=0A=
>=3D=3D Y was therefore always on Y->publ_list and only changed under=0A=
>Y->lock.=0A=
>=0A=
>Now a peer N can send a WITHDRAWAL with orignode =3D=3D Y. It can learn th=
e=0A=
>type, range, port and key of Y's publications from normal name distributio=
n.=0A=
>tipc_nametbl_remove_publ() then matches Y's publication, and list_del_init=
()=0A=
>unlinks it from Y->publ_list while only N->lock and nametbl_lock are held.=
=0A=
>=0A=
>Can that race with a node-down walk of Y->publ_list?=0A=
>=0A=
>CPU0=0A=
>tipc_node_write_unlock(Y)          <- holds Y->lock, NODE_DOWN set=0A=
>  tipc_publ_notify(&Y->publ_list)=0A=
>    list_for_each_entry_safe(publ, tmp, ...)=0A=
>      tipc_publ_purge(publ)        <- nametbl_lock per entry only=0A=
>=0A=
>CPU1=0A=
>tipc_rcv(N)                        <- holds N->lock only=0A=
>  tipc_named_rcv(&N->publ_list)=0A=
>    tipc_update_nametbl(WITHDRAWAL, node =3D Y)=0A=
>      list_del_init(&tmp->binding_node)=0A=
>=0A=
>If the unlinked entry is CPU0's saved tmp, it now points to itself. Then=
=0A=
>tipc_publ_purge(tmp) finds nothing and the loop never ends, with BH disabl=
ed=0A=
>and Y->lock held for write.=0A=
>=0A=
>This looks like the same publ_list race that the commit message says is fi=
xed.=0A=
>=0A=
>With in_own_node() removed, a PUBLICATION whose orignode is the local=0A=
>address or 0 is also linked onto the peer's publ_list now.=0A=
>=0A=
>Could n->addr be passed down so that items whose orignode does not match=
=0A=
>it are dropped?=0A=
=0A=
Yes. I will address it in new version.=0A=
=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> diff --git a/net/tipc/net.c b/net/tipc/net.c index=0A=
>> 7e65d0b0c4a8d..1e445c5abc0f5 100644=0A=
>> --- a/net/tipc/net.c=0A=
>> +++ b/net/tipc/net.c=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> @@ -138,7 +140,9 @@ static void tipc_net_finalize(struct net *net, u32 a=
ddr)=0A=
>>  	tipc_named_reinit(net);=0A=
>>  	tipc_sk_reinit(net);=0A=
>>  	tipc_mon_reinit_self(net);=0A=
>> -	tipc_nametbl_publish(net, &ua, &sk, addr);=0A=
>> +	tipc_nametbl_publish(net, &ua, &sk, addr, &skb, &rc_dests);=0A=
>> +	if (skb)=0A=
>> +		tipc_node_broadcast(net, skb, rc_dests);=0A=
>>  }=0A=
>=0A=
>[Severity: High]=0A=
>This is a pre-existing issue, but what happens if tipc_nametbl_publish() r=
eturns=0A=
>NULL here? That can happen when the GFP_ATOMIC allocation in=0A=
>tipc_publ_create() fails.=0A=
=0A=
This is known issue. I will address via another patch.=0A=
=0A=
>=0A=
>At that point the node address has already been set by cmpxchg() and=0A=
>tipc_set_node_addr(). The cluster scope TIPC_NODE_STATE binding is what=0A=
>normally keeps nt->cluster_scope non-empty.=0A=
>=0A=
>If there are no user cluster scope bindings, named_distribute() then runs =
on an=0A=
>empty list when the first peer comes up:=0A=
>=0A=
>tipc_node_write_unlock()=0A=
>  tipc_named_node_up()=0A=
>    named_distribute()=0A=
>=0A=
>It still does this unconditionally:=0A=
>=0A=
>	hdr =3D buf_msg(skb_peek_tail(list));=0A=
>=0A=
>skb_peek_tail() returns NULL for an empty queue, so buf_msg() would=0A=
>dereference NULL. The new skb_queue_empty(&xmitq) check in=0A=
>tipc_node_write_unlock() runs after this point and does not help.=0A=
>=0A=
>> diff --git a/net/tipc/node.c b/net/tipc/node.c index=0A=
>> d7cbfa786c132..182c6dbfa49d2 100644=0A=
>> --- a/net/tipc/node.c=0A=
>> +++ b/net/tipc/node.c=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> @@ -653,40 +659,14 @@ void tipc_node_stop(struct net *net)=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> -void tipc_node_unsubscribe(struct net *net, struct list_head *subscr,=
=0A=
>> u32 addr)=0A=
>> +void tipc_node_unsubscribe(struct list_head *subscr)=0A=
>>  {=0A=
>> -	struct tipc_node *n;=0A=
>> -=0A=
>> -	if (in_own_node(net, addr))=0A=
>> -		return;=0A=
>> -=0A=
>> -	n =3D tipc_node_find(net, addr);=0A=
>> -	if (!n) {=0A=
>> -		pr_warn("Node unsubscribe rejected, unknown node 0x%x\n",=0A=
>addr);=0A=
>> -		return;=0A=
>> -	}=0A=
>> -	tipc_node_write_lock(n);=0A=
>>  	list_del_init(subscr);=0A=
>> -	tipc_node_write_unlock_fast(n);=0A=
>> -	tipc_node_put(n);=0A=
>>  }=0A=
>=0A=
>[Severity: Critical]=0A=
>This isn't a bug introduced by this patch, but removing in_own_node() chan=
ges=0A=
>how it plays out. Can a peer free a local publication by sending a=0A=
>WITHDRAWAL with orignode set to 0 or to our own address?=0A=
>=0A=
=0A=
No, the peer cannot send WITHDRAWAL with orignode set to 0 or to our own ad=
dress.=0A=
=0A=
>tipc_service_remove_publ() treats node 0 as a wildcard and does not check=
=0A=
>scope:=0A=
>=0A=
>	if (p->key !=3D key || p->sk.ref !=3D sk->ref ||=0A=
>	    (node && node !=3D p->sk.node))=0A=
>		continue;=0A=
>=0A=
>The type, range, port and key of cluster scope publications are known from=
=0A=
>normal name distribution. So tipc_update_nametbl() can kfree_rcu() a=0A=
>publication owned by a local socket. Its p->binding_sock stays on=0A=
>tsk->publications, and nt->local_publ_count is not decremented.=0A=
>=0A=
>After the grace period, tipc_sk_withdraw() on unbind or close walks=0A=
>tsk->publications and reads the freed p->scope and p->sr. In addition,=0A=
>list_add(&p->binding_sock, &tsk->publications) in tipc_sk_publish() writes=
 into=0A=
>the freed neighbour.=0A=
>=0A=
>Before this patch, in_own_node() made tipc_node_unsubscribe() return early=
,=0A=
>so p->binding_node stayed on nt->cluster_scope after the free.=0A=
>Without that check, list_del_init() now removes it from nt->cluster_scope =
(or=0A=
>from the RCU list nt->node_scope) without cluster_scope_lock and without=
=0A=
>list_del_rcu(). That races with named_distribute() and with=0A=
>tipc_named_publish()/tipc_named_withdraw().=0A=
>=0A=
>Should orignode be validated before these items are applied to the name=0A=
>table?=0A=
>=0A=
>--=0A=
>Sashiko AI review =B7 https://netdev-=0A=
>ai.bots.linux.dev/sashiko/#/patchset/20261006052312.30382-1-=0A=
>tung.quang.nguyen%40est.tech=0A=
=0A=
--=0A=
pw-bot: cr=
