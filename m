Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E533BED59;
	Thu, 16 Jul 2026 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194124; cv=fail; b=FDcMOzWm2y4Ye/xtfWwojXvcZ4I53bDMkslAuKQPX9e04Qit7PaWHmMbnfM1L8H2/4vdaDV4JLS4ZOww6+XzoEba5Qd5lVxknortt2StMB2MWclQUJxMxz5fcwJc3JPb415ESlPUNrau861DCkagRdRNEmkiMYf53IP+Z6w5pl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194124; c=relaxed/simple;
	bh=wR5wMSsvfBUqTYyvap9wzPGGqRgJE9pHku0A3YhUEE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDRVrkCKsHc38+JOY9w0Npy0uI4TQqU6I/nKqqsKM9SYb/pcay5JClkSuM6zoAcqdisUUs1GKb+TLjd1ZYqALlgTOXp47Ynx6vE448iyYtlvivwgLkluVig+zaA6RC2TKpb7CrW0idBPfA1zXcWz/eFga0TdWmFKWaPh8qVkBrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=eVesY0+b; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="eVesY0+b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+wPBlWub2xbnBjAcPqdhRbPpsFvX0BaQ4LuSYmAtNyB4BDM8aOspHU4uyYpdFCCeJk5K5WKdbbg/x1RzMrVTFqrBS4HjLW7a3yqabQPxds0Y6v8bhHMmGEz2BrAoGNiYGoHyyDxuHMwT2v/LMH2guiWByf+jkt/NGzSo9ZgBaSGNwAQujiBavHEy29rkwUothovmLKhSMb5mI2R824VvmrbmbR5iwwW1RnwuZQERPbFWOLvY77Xb+lLYZgqXYV6xkW+BJU1a+SvSYoZCDbZAX6R2jLs5ut6+yn6Caz+FTxjZCEScCPFsZ+zTTdUpk18bHfq/qqUVkwZ8eclog4Hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfroHOs7fm+hBRbKyMIhxx3LXL6UcDk9LSAqyP9Jjtc=;
 b=osmrytnSXw1jeX2OLH8vwkaMuTjl6CDZn6DiY3UbGdp87UaDtBUboHAbokDVKKIPDNtI1ER7eZ4/36ybeRxkjc7qC/lDOs+bPizY41ffim4Yuk8r5PZmgk6yl02U84P6zE+K6jXTd6wBpEYmz9is64FFGU/W1bKGv6ee4bXDDRpsuI4upKt2v5JYhOkab0fUEiPmadweI26+PmLjosztepHernHerYO3nmxtTRBH3jNUTQBDF97xc60dFOdUtWAcKHkxiIYg6t8m49ZoTfKLsKCT47aBK7NcYFRUOOJMhLSeSlWejSY5FctGarAqgyX/TFpjfvco4qjSv7/tblMmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfroHOs7fm+hBRbKyMIhxx3LXL6UcDk9LSAqyP9Jjtc=;
 b=eVesY0+bqXhfrKuP5TNatUlglCIKybSWKEIfAgrRqcNJNTeuzeIVz6rCc8eLCTTu5CL9z/eQgaKxVx/9ZazLUb0PlrVmGUxmlsWXWzEnCd783DiCqLylRKU7Di7nGXsTCR3YlHVa3Cqlfyay1mop276q7tGsBzEY4DYxSKugyLat7TakkpcPyMhl7IqdhORjCTniPcTEq39q0dAiawuOr1FsN9HE9dHkIrR61BlNi1nWQ7ePpPyMVkPFV2zxC/hfIt0MWKJ183hgak90r6ggKmyxS2Wosq8cnbroKs2/vIDKjBfFXp/o3ynK4pWUbwU7/Yw9nmlrOLsazNxQd/fhtw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV2P189MB2981.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:267::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.4; Thu, 16 Jul 2026 09:28:35 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.003; Thu, 16 Jul 2026
 09:28:35 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Xiang Mei
	<xmei5@asu.edu>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net v3 2/2] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Topic: [PATCH net v3 2/2] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Index: AQHdE7f/Qg/mrV11ZEODMiwB1rIarLZv3yng
Date: Thu, 16 Jul 2026 09:28:34 +0000
Message-ID:
 <GV1P189MB1988239A710C4D42F6DCA15EC6C72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260714174110.1571033-1-bestswngs@gmail.com>
 <20260714174110.1571033-3-bestswngs@gmail.com>
In-Reply-To: <20260714174110.1571033-3-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV2P189MB2981:EE_
x-ms-office365-filtering-correlation-id: b38d4aa2-83b8-4ab0-314e-08dee31c9c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|38070700021|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info:
 uBtTBE599rkZfdJBefdBL+6DbCG4SgTB2xrLbDq7MLmTyFtjzTD3UwJqUUPzVC7uSH9KX0Ssmzd4rpntyHYSffDyEOg4LQpEyMhhu8cE4dgckBtwKmmKcLalfvoT6D+RIz0PDQ3Toph0//14X92P/xvr5+BE6QTJycrqYrqdbVfMtm/YW/iJhGd/H6q01oyx2samfx2obhXVwNDvvQSuf3V7+4XQSX3BH134vuhqTTmHwm/n1xVTW4VL5gO4qya8XB+RwCmL7rg5U7Hd4ona7xbTTFLiKGUEv5ejGR9LX1VXNmn1CbdTPGPegohpPsmoKRmwUEJJSONmuN20b4Nu6dP0iEg/uZomq8RdgJvNxWk2uH/svZ6Dk2XvVtuwkEUJlaiMTP9r0EDrE88v/SGssNHvTMWdvkgA6eyFctc1yWyiG1d4fyrAhftUVsWJ/OphWGwASaBSpzSyeZqex1r/yBXbh2q4ljpCEPxK4pMUnh01QQu/MMJHRoRTeSx2LmKhl5F0N3+IsCYUoq4KZS7o7q5VGw4y3KNlmgTGv3/RHSh0PNVcF3GarTISFLhXVUMC9aiXZJK3g0ryBGuWMRXmmvTTug/G393s1j0GHq/QyK9p7MV9+K9PlnYD5zxlmy7/JPgv8C2vdX1xQGLUcxcWj4Tgb3CXchXotqDQtJLPZS9TRu+UIQSe4d8Trl0dUhKxC78W9yvYWUYnYlydrtP9O6RHCBsfApmA43jBFO1wKqQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MG9xpN2vAEhuUyJaaRyJvx7FCEouPAmYXpasE3msKyuJzaXcaET0F2fGji64?=
 =?us-ascii?Q?meHr8SJu8j0GsoYdJIxWEjETaFN7b5M/YdnJSpBQgcBATNtatsC8Rjv8RQWd?=
 =?us-ascii?Q?ntB4RTKw22a1wmuT/FzPAT+eWrxVePUQpqHzRhGUT6gVJ9urHWFvgDqV+Xb+?=
 =?us-ascii?Q?zz+pHRjiDggLHYkv/d2fLg1ZdXZoKUf40d2bcxLyuCAaVWgiaXT6Mk6IRSbJ?=
 =?us-ascii?Q?rNAiK/ofoHimO41Xq3DbVbJvEuLiKIDAsz4aogdFCpZHqIoDu9e9ZIbs4je4?=
 =?us-ascii?Q?SjajgN/82xEREo+xb9AAW3dtdh1LQGE+GmXzFkaLt/RvypNGNuplV6mnrIxA?=
 =?us-ascii?Q?HTSxSlITGJrb+kF30lXzCtVRFfcEwhL8jhQa3MGYgoqEZhQnfBIFDe7ASlD9?=
 =?us-ascii?Q?6GfuiWJ1TgoSIAZSj8k2I57Iqr6vQuTt2xK7SUTxNlvyFEEw31RNVIw+heCb?=
 =?us-ascii?Q?4IhHgx/xxzIXXY6IugYvLU+DmAoJVrmD1MRyTIpNXb22VQD9LdD3ihBVMZJo?=
 =?us-ascii?Q?Qeuo9+lVbQVnkUOdCXLXhrn8zBjKipL3bIQUpoHK9GHEBLs0FvoHC2X9XSg9?=
 =?us-ascii?Q?H+6iuRqzJEMnuDaI2kdI5fLpH6cHFbcxJl8IwlQdT0rhSwOEXYaEEOduk455?=
 =?us-ascii?Q?vMOXMsdAvYcKx3XDzbBgLjSWk2rI36dbJC+O/2aMZTrtFSpV6GjDO5oTJx5W?=
 =?us-ascii?Q?RycB3V7GjCkE7IlrtKttJG1v2Gn4QgGSE3Y0yPlxkqY/MBHd1mA6JVzeEIMV?=
 =?us-ascii?Q?wM2FeAI//SSYDB5rzO10Vo10h4GZrNkurMQuaR2JAkjexNgdQu9fchXVYubv?=
 =?us-ascii?Q?FrrtiCrTTyanvyrLhtwUqXhZy4s4KI+VoNGUkDrCqUh9fltBQY74aVX/CrAm?=
 =?us-ascii?Q?M7rFiU0AepWsBY23JxkWQXRvuqn0NWrhcdUGi25IdjegdOJwizd+tidSaX1h?=
 =?us-ascii?Q?Wz/SJ8pUIFIt9ptDykgIK2HAgTdVeRiKpEHNUOata1XjV9XJuzEXJl7GwyrU?=
 =?us-ascii?Q?TfCXiQZpbFlgQdjRFGtil1BnlBjdFfXQF7y+Kgb58ptYcjg+VpslAR/Nen8Y?=
 =?us-ascii?Q?A0PmJlF0c7RbdgDK5tvlDQeKK2358C4eBapUQKRLVSSezsIUvVKWcHLCMTdi?=
 =?us-ascii?Q?4NdMkIzYzVJY2W/0wHflV6sXGDhBPJds7C8d798stsaeyB1WvLCnBiP4nrjX?=
 =?us-ascii?Q?4XZGVlRE4Qq/9iQA7cSMk6tpcVBtQ+zQaYEoHv6emfKQNFUV6yHKbeWF2/Tn?=
 =?us-ascii?Q?W64I916e7dmT0tRomVkE6RRxOmHuqc7rWqz6s78ocKF9ZTvwPc/fSUck4v8J?=
 =?us-ascii?Q?BmXFJ6JN7US5FI0UAvC26MOQPQrWet8gP2dofiua5DChlrp5NAuUCKNuYWm/?=
 =?us-ascii?Q?2r76dxHFdfPrpUh0UBEycw331mxkmAvHyHGQRY50ni91qA7ynJZQk93MK3MW?=
 =?us-ascii?Q?eSg2qRCVbvJxo9cnkpYap1pyyBle6Z0Znoe5L1uNwMMvbDd6wg6BAINT38MA?=
 =?us-ascii?Q?uRyOMZdtMYU4T8QKDtBV5fyKq5kA7+o/0+WGVjQnUi/Zoh8PlljqoBDwx0bK?=
 =?us-ascii?Q?PT5fZ5/22omyWEm3W3XoZLg3QZYVFB2IabJHoOoEwwYJRpRWPD72x9DfPpMA?=
 =?us-ascii?Q?ji1GUU3RgkfO7VZXytf0G0TUhqw2dKKnHnRXATJoxEdOvZ/nHAwyp2ZUexTG?=
 =?us-ascii?Q?NBBp9GAHO/hkWGJCZqGXr47lloD5KypY4Y79HHI/hqIhyHbiVy5qhRdLuPZv?=
 =?us-ascii?Q?DZqRX4Sx0A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d4aa2-83b8-4ab0-314e-08dee31c9c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:28:34.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkWQYOz5NFZff4GQviJ6CN9fmemDYs0oKpUeI+jHAA286wcNbhnZXGwVxYNpK4mc2W7WiN1CqjQeTwDVP7f0rVJWZJi9hZK51a09JVZIQbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2981

>named_distribute() ends by stamping the last_bulk flag on the tail skb via
>buf_msg(skb_peek_tail(list)). When the publication list is empty no skb is
>enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is dereferenced.
>
>tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
>configuration cluster_scope is populated only later by tipc_net_finalize()=
, so a
>peer link that comes up first reaches named_distribute() with an empty lis=
t. It
>is reachable by an unprivileged user (TIPC genl ops use
>GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:
>
> KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
>  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
>  tipc_node_write_unlock (net/tipc/node.c:428)
>  tipc_rcv (net/tipc/node.c:2185)
>  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not syncing: Fa=
tal
>exception in interrupt
>
>The peer holds back this node's later name updates until it sees a bulk wi=
th the
>last_bulk flag, so simply skipping the empty bulk would stall it.
>Emit an item-less bulk when the list is empty, and break out of the build =
loop
>on allocation failure instead of returning, so the last_bulk flag is appli=
ed to the
>last queued skb.
>
>Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/tipc/name_distr.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>ba4f4906e13b..dbcfa965de34 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -165,7 +165,7 @@ static void named_distribute(struct net *net, struct
>sk_buff_head *list,
> 						dnode);
> 			if (!skb) {
> 				pr_warn("Bulk publication failure\n");
>-				return;
>+				break;
> 			}
> 			hdr =3D buf_msg(skb);
> 			msg_set_bc_ack_invalid(hdr, true);
>@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, struct
>sk_buff_head *list,
> 		skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> 		__skb_queue_tail(list, skb);
> 	}
>+
>+	if (skb_queue_empty(list)) {
>+		skb =3D named_prepare_buf(net, PUBLICATION, 0, dnode);
>+		if (!skb) {
>+			pr_warn("Bulk publication failure\n");
>+			return;
>+		}

This approach is wrong because:
1. When 'list' is empty, it is caused by memory allocation failure before. =
So, it is likely that 'skb' could be NULL again because of memory allocatio=
n failure.
2. Even if 'skb' is not NULL, allocation of non-data (zero-in-size) message=
 will break the receiving peer when it handles this message.

>+		hdr =3D buf_msg(skb);
>+		msg_set_bc_ack_invalid(hdr, true);
>+		msg_set_bulk(hdr);
>+		msg_set_non_legacy(hdr);
>+		__skb_queue_tail(list, skb);
>+	}
>+
> 	hdr =3D buf_msg(skb_peek_tail(list));
> 	msg_set_last_bulk(hdr);
> 	msg_set_named_seqno(hdr, seqno);
>--
>2.43.0

