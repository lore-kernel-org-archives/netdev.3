Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124A2DCF6C
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207900; cv=fail; b=SL+BacQaOwk0Ne3pstBBG+tDlv3HEqbrP4l2iZC4QCIrwGBUZ8Wp5uYnsFZsQ5PfezyucdG0XWkM0TTRm+QMnWpk1v12Ds4APU8T/e0vSf9wRsGRI5mVsAe+itYFx2w+24f6n3voQ9eGoFZtaI9Dn2bI6Y6rCQSwA5kWF8Kg26M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207900; c=relaxed/simple;
	bh=if3jiDAkVsl5eozar278NyGHgvMdHp6Dz8ougWYzvBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ki+JhJvEvLD5MPBsAkHtRXrbDLGMf52kQt2++YQpFctuckEuqg53QF2hcDQ+tO+U0xXsQZtsRlWTXXqXELzzFKYLwtug3HTTC9kpj6rd3jqMkkzlnfsKMcCeXrt0BXkm5fkOJNrTk9Z3B2rOfaysbOwPLbkPoV/t2rKBCuovBiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=d6uw01PC; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="d6uw01PC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOU8nJu8pj87ORearar0WfRmWpZ6n920GJ2LXKkmJcOsNqtMjzZvcoeajgf2eTI6HrIb5GJP0qkWd2+jfxj27ieNhRxHEI8djvWqhyQPB9+77pTRhizFUAqJg43w7+fM9Qw216CyXEZHwEm5e2skr9uq4dACpKbls629t1XHeNTIC/ewjE3Wp3o3k6HIrkK+kl/j4zr5mWX92pfN+Try0xRMhHzesldKZwPhV8eWw5XxGzdMZmIJx1PkBOQhHdWCF72453+MQyl4sID4U98r2Z0VaOhk5B9FIC7ZupcJxzcy9mhSCYKB6vhQQt3iltV5ze5Lt38MtE8F8mDHHWL7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VorS/taKMGsauI7jNucgosJPHrgzTC/4xeJ6nBlNM8E=;
 b=ZVPC5WPugAp1eLodEFJ5NPWmG5kcbShHWZovP0HBRnTz7DZjX/lzsSnCw1/spuja7/ReiMu8/rEO5Yb0L4lOgO8eQ4UU7SKmfIrBDYqQwFbwRlLT6hESPWBCgSOvyICHGf/Mlvi/ZqhHxz0OFQiU9LGtsvINR1NwmOWFb64Jlo9eEenJb+puaJzakhg9sd75xvdd+Y6j4hUj2IpIsICNepa05xXbnU9jJsuWvoH8XlKbU+gbOHNhJ+bRr7ACYbgbBaxdoXeKBsDz59M2vUNfn0XhwpU5ShjqtYY2N4DIadibZGag0SlGQhsd89ZSo47CJWFm+gGuj2Y+qCAppv0xLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VorS/taKMGsauI7jNucgosJPHrgzTC/4xeJ6nBlNM8E=;
 b=d6uw01PCMuy6uNIb+TtgvxVmoeovTFno9Ve7RJdxehWB4gNyqEXdAij5sXc6EiU12VyTdbhsnQ2ac7cXeogkLm7hpUcw5RB4/rM8KnPkHZaHpqb6+YGUrZ4w1jvoiqSIPRfWNKVeEwrxIHR/zM7lGDKv3B1E42j4H2R3bIopNhyTHB/i5c4ZFXn/yUzX/RJeu6IamO3ElXis7qA3Pa3h9IEcA/HWE46eiFP3fHvcuftam2p29pFjGbGErCoWVKp06dl34sy3NBEIppudkR34nhyLgZ6Xga2PDpBXruV/B2ug/sByS6cbBCJzwWUxgxCxdkw33JqMarn9w/mVeJqq3g==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU4P189MB3373.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0; Thu, 20 Aug 2026 06:38:13 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.003; Thu, 20 Aug 2026
 06:38:13 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chuyf26 <Chuyf26@linux.alibaba.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>
Subject: RE: [PATCH] tipc: validate the size of discovery messages before
 parsing
Thread-Topic: [PATCH] tipc: validate the size of discovery messages before
 parsing
Thread-Index: AQHdLy59T9Xt14R8LUylboeo/JaS8bamd+1w
Date: Thu, 20 Aug 2026 06:38:13 +0000
Message-ID:
 <GV1P189MB1988184D653C8EB7E92D9DE1C6A42@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260818162254.E55A1478E57@smtp.subspace.kernel.org>
In-Reply-To: <20260818162254.E55A1478E57@smtp.subspace.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU4P189MB3373:EE_
x-ms-office365-filtering-correlation-id: fbbf2e31-c062-4fc6-a42a-08defe859bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|3023799007|6133799003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 hnmnMRWP5dm5K32A5q+Vxk2ReHfL+JW8yvMamhhprRqjFbK6cKTjkbl0WyJb4l+tHZICPRurSOnYfqLrj9VeEqU2k65ST6N6InzTIaCZQEmzQvU0WOmRCU74ZV41a8U+le4eZdXd9WZR8Smrwx6CwYshO7Ud9BLSkIgtUJ//2Dm3jV/6OrNTEMXzCR2EN+vn3H3YlFzG6jv6KPMS2BMkOyCGGXfrBwci1vIruOJSoAQYNBOBP3Tm4IzXHsT5gQ+Z7x6MTnmrkqb5dy0W/i9uiPLqbUh7oFKLqLIx821GIwTfus49d2sLLTNQ5qeyHoncc+H7/tExlcQcGU6o23YVLmk2FpnhW+Bw4ZGXWKh2FZCi8uNzGxHU5IYIZhuOLfkUoLuAAUBaQm4uYTOIuqWlIQt4dq5kfy/0XM1edYYyheDoPkmNY6+wui0sS3RC2msql+u/RWaV4npobFrKLzVZlvxWK+MrLexX5kVwWSzR0sVySqcLO79ny63lLQ6JUzFosvT3VDAPqssi/9a5YLAA4Flr6d5QtTEQ579SSbL64gJ2blYNmSQPPONTAW/vuJE8pRi2sN8+/HZGYN45vnZ7KnPnFkVfasa0dNMIe+FapiavgktAk2XlM3iE+DZV1l16ydwWx8dgOXjjTSIRr6PROfvd33Hng+zcfkE8l+Uw4tkinYsYZFgvjKEdDJJX7Ujk7pkVwua4qyOH1BfHPxkaqSCrGNbqY1OQByv0qFBYRwM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L9OZewp2UrQN0DQsKW5E6dhY/qN3PiuvMgWLtQmWepWCK+YcORSrplgRyFKX?=
 =?us-ascii?Q?1YVpK/PAKu+nZ+Hyubnq8eBf+2Ukc3X1DUUoWt9DVhN7xGdGVW53jrGatNEc?=
 =?us-ascii?Q?rkco5l1iwYd01i+AQtKIuiJ5RKryXPCIxClc7N3smJstIy7hrBvEzr8Z5Egg?=
 =?us-ascii?Q?9O/cwB2GUrapXHIPDO8EaFNaZbEeXHvc9vXomqcpMwK9prTakmUzDfS3RjvT?=
 =?us-ascii?Q?fVw0X0vxvYZmixe0rNS7ZE9jyCdpD0VN09X52dmf/mbvYQHxB343/d+N4UBm?=
 =?us-ascii?Q?CxFEg8MDE/G3a1F9ZB6360sBQBm5Ix7F/0UXe8iy7wId65eY0H0LrQx230hJ?=
 =?us-ascii?Q?J2Li07Sg5RfW41pJvdoz3kPE6HbY/CoQfGFVyxvDNLunHacFC+KPjfYRV/ed?=
 =?us-ascii?Q?Vu59s2u8HMZ1ejb2mzigtir33kFT8y1+tgQUKC14Kk7zF4zoAuI9PMUDvHyI?=
 =?us-ascii?Q?BGoSb1Ale08qXORLuX3/gppEBMTT215gSyeYq4v5LOElBjkpUOc9KGIYJO5+?=
 =?us-ascii?Q?qj2Qm5goB8YD1x/JAeA5yotFoW/llMhpeSWrppLz/6TzivRnoSqYOXF6xZRo?=
 =?us-ascii?Q?brPgdYauqzKKZnEY0DZNIkRcFgAnu1BbuaKhAl6WBatUHUFUdJPSbX8FgHJD?=
 =?us-ascii?Q?BudUe8El2wutnW7jxOyKxdvb0pDj/DMTZNTdCesqD++jtF+zfXWBQXaxYglf?=
 =?us-ascii?Q?0cffPIyn9v0IUQu5CLXjRuQIzTBEvX8/hGTu1Q1N20GszHuqK20bHVup2r+Q?=
 =?us-ascii?Q?iLkSdMYgL6oU/yw0ldbxs5TfwfJQbmM/gSyRSyd3KXS+ZTr7H433KHEMnd9v?=
 =?us-ascii?Q?zqz7znlZPCwdzk63tlM/VRmHyz84DfV5zeaV8rWwoj0hBuxKmQh849DHUlG7?=
 =?us-ascii?Q?km/vfNwCMWrTDzIg2/eHoqqse2hJ5ni5Y5GeTBTMfjRPrgXGgPmWf67OJPm/?=
 =?us-ascii?Q?ap1GmKY9ir3JCRmKEC9AgoRFP14UAeCbyQhIX3sWUk6tp2FbZne9gzMPn9ww?=
 =?us-ascii?Q?JbFi3TbpBFunhwkt3NTb5AMXx7QyJ38eZS063dCclYNW8D4r+LIP8rSL3PCa?=
 =?us-ascii?Q?nZ6/4N8llwO4qCcrpeWOpusHIUIlGOSPPH5M+LHUmD/9PYuQ71GtaUt5KSyR?=
 =?us-ascii?Q?TQhvaVrER+biu/F+yijrUgOzd38R2E0BRWZJa8+pXa4B0kteAxUCuaJ+v7uT?=
 =?us-ascii?Q?gajE6hSjeIqGiS4r2WyZlG6wf1Zij6+yu1qIStVgWaFmFj26WoSz68RkYPpH?=
 =?us-ascii?Q?DRCuRW1m7kuu4DATKU4rrSGlZ2irpS2v8rnloTW0Evwq7rySXTZLjMDu7tYs?=
 =?us-ascii?Q?MzId3nbWYa3JjZ/6E/3ForATtj+Um6UWj51Izj1585qTTTI2KNN4sTdV3X/0?=
 =?us-ascii?Q?HZho2U4mS36Zyyn2jJKKvXCegiiNFUt7Buq2VK7ELWdErZO6ENspXK7VHuHg?=
 =?us-ascii?Q?OawqLiylaXyMDZnaS2pmlkqBXBaSf7NQE8pLYbOSMy/jsPXsd+/LdNUrFdu2?=
 =?us-ascii?Q?l+3YlD74rAa7BkNHAGPmSB/DTS8d5DYpFbFx2Np1Fc5YBisx0PtRKelDOcih?=
 =?us-ascii?Q?Mp1L2ABaaoD9txmUTKW2DwZ/mnJJkAzVSDjjkNRNwyf56rbSo1rFruxAjHMH?=
 =?us-ascii?Q?2KHSG9nMG78omQylMIVimlexhrM2YaLvdK26zqFQZqY8T8K6gHmBEzTFbD2g?=
 =?us-ascii?Q?Ngfe7c2Oc8EhsbZLDVy5Gn/7t5zeG57gQjsYbbKLWad9NNtShy19Gs9hXmk9?=
 =?us-ascii?Q?p/60bHr8nA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbf2e31-c062-4fc6-a42a-08defe859bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 06:38:13.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dS4MOfG431+Iuk7s4WFH1whV4X0GuVwc/W8hT4TveRi5pBePXy91p3O/lmu8ScJ8Xt6yYKWUcTL1YHmLJxneoQO8CK1rK7KsjOJ/vtu1u08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB3373

>Subject: [PATCH] tipc: validate the size of discovery messages before pars=
ing
>
>tipc_disc_rcv() reads the peer net hash, suggested node address and the
>media address area from header words that live beyond the minimum TIPC
>header size, and copies a 16 byte node identity from the message data.
>tipc_msg_validate() only guarantees the minimum header size, so a discover=
y
>message (LINK_CONFIG user) with a smaller declared header or without data
>makes these accesses read past the end of the message.
>
>The path is: a frame received on a TIPC bearer is delivered to tipc_rcv(),=
 which
>calls tipc_msg_validate() and then dispatches non-sequential LINK_CONFIG
>messages to tipc_disc_rcv(). Discovery traffic needs no established link, =
so any
>node on the bearer media can send such a message. The accesses can read up
>to 52 bytes past the end of the validated message but remain inside the sk=
b
>data allocation, where KASAN does not report them, and the values read are
>used as the peer's node identity and media address.
>
>Discovery messages are always built with the maximum size header plus a
>node identity, see tipc_disc_init_msg(). Discard discovery messages that d=
o not
>carry both before accessing the fields.

As mentioned in the changelog, discovery message's  header size is stated i=
n
tipc_disc_init_msg() and it is a protocol message. So, checking for discard=
ing
discovery messages that do not meet the header size is redundant.
Note that it is not recommended to create fake discovery messages to exploi=
t TIPC
in insecure environment. In such environment, ipsec or encryption must be u=
sed
(https://datatracker.ietf.org/doc/html/draft-maloy-tipc-01.txt#section-6).

>
>Fixes: 948fa2d115c5 ("tipc: increase size of tipc discovery messages")
>Reported-by: Abaci <abaci@linux.alibaba.com>
>Assisted-by: abaci:qwen3.8-max
>Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
>---
> net/tipc/discover.c | 36 ++++++++++++++++++++++++++++--------
> 1 file changed, 28 insertions(+), 8 deletions(-)
>
>diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
>685389d4b245..74673ca1f2d5 100644
>--- a/net/tipc/discover.c
>+++ b/net/tipc/discover.c
>@@ -195,27 +195,47 @@ void tipc_disc_rcv(struct net *net, struct sk_buff
>*skb,  {
> 	struct tipc_net *tn =3D tipc_net(net);
> 	struct tipc_msg *hdr =3D buf_msg(skb);
>-	u32 pnet_hash =3D msg_peer_net_hash(hdr);
>-	u16 caps =3D msg_node_capabilities(hdr);
>+	u32 pnet_hash;
>+	u16 caps;
> 	bool legacy =3D tn->legacy_addr_format;
>-	u32 sugg =3D msg_sugg_node_addr(hdr);
>-	u32 signature =3D msg_node_sig(hdr);
>+	u32 sugg;
>+	u32 signature;
> 	u8 peer_id[NODE_ID_LEN] =3D {0,};
>-	u32 dst =3D msg_dest_domain(hdr);
>-	u32 net_id =3D msg_bc_netid(hdr);
>+	u32 dst;
>+	u32 net_id;
> 	struct tipc_media_addr maddr;
>-	u32 src =3D msg_prevnode(hdr);
>-	u32 mtyp =3D msg_type(hdr);
>+	u32 src;
>+	u32 mtyp;
> 	bool dupl_addr =3D false;
> 	bool respond =3D false;
> 	u32 self;
> 	int err;
>
>+	/* Discovery messages always carry the maximum size TIPC header
>+	 * plus a node identity, see tipc_disc_init_msg(). The header
>+	 * fields and the media address area accessed below live beyond
>+	 * the minimum header size, so discard shorter messages before
>+	 * reading them.
>+	 */
>+	if (msg_hdr_sz(hdr) < MAX_H_SIZE ||
>+	    msg_size(hdr) < MAX_H_SIZE + NODE_ID_LEN) {

The second check breaks legacy TIPC (which does not support node identity) =
as found by sashiko:
" A peer that builds its discovery message the way tipc_disc_init_msg() did
before 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash
values", v4.17) declares exactly that:
net/tipc/msg.c:tipc_msg_init() {
	...
	msg_set_hdr_sz(m, hsize);
	msg_set_size(m, hsize);
	...
}"

>+		kfree_skb(skb);
>+		return;
>+	}
>+
> 	if (skb_linearize(skb)) {
> 		kfree_skb(skb);
> 		return;
> 	}
> 	hdr =3D buf_msg(skb);
>+	pnet_hash =3D msg_peer_net_hash(hdr);
>+	caps =3D msg_node_capabilities(hdr);
>+	sugg =3D msg_sugg_node_addr(hdr);
>+	signature =3D msg_node_sig(hdr);
>+	dst =3D msg_dest_domain(hdr);
>+	net_id =3D msg_bc_netid(hdr);
>+	src =3D msg_prevnode(hdr);
>+	mtyp =3D msg_type(hdr);
>
> 	if (caps & TIPC_NODE_ID128)
> 		memcpy(peer_id, msg_node_id(hdr), NODE_ID_LEN);
>--
>2.43.5

