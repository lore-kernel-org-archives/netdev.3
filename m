Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA4423A9B;
	Thu,  3 Sep 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436476; cv=fail; b=D5azXxBcDb/nGyUW0GBNgEnIKxQIuThSxEoS9+RlMWDEsTc/EizDN2sOJxdP3GyMjUMhfYYl5n4G9KcJNJXeWcqLQ1PafSpY+8aG8dLEqjXubRaa+pxd2FUjIsHHPpyBcCdNROhSQCkTEe52KUWU/Iy4+wmxe0yGZUX3k6UNfhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436476; c=relaxed/simple;
	bh=LZ/oOAfWv3qfH86D6A2Zfpwe3bYCZFflySBalfVkLjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KgqOpU3XMfQJy3NLSB1nGx4EVOHPaETaOBIpm5+FGp/XGIN8ygd0DzeYiiFoYmds3fpqt+rDQ7Kgp2Xsgf7utlf42VkprS5bZvmcdbWvAnM4x3n6rmb8lDW1zJKVm6ZZnUFp/Q8COKSTDHb8ZrQk9rivquqvrBk6xiz5DtDUcRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=AFMncd0e; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="AFMncd0e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQTMT98ezeW6e9f/Fhqzqo1P1LfLrAGBlJYausuOAnUnGn+sDi+H55bYPaXHDbiMGfEPDbZUXv2F2vji5/zYVPaOwh0Q31mst1MokkotixKsjxGFnyTvmbY9WzLkQlEdi5aftNdvDG3CAf31rNz8OX6dMbEVOOZwwPJTLwcacXUtDR1pSjKbCDXoEI2tRnvMupvpXbZxdx5yELHZlmECgCXxZpfE1HCI3/qAUJJgbTcVclb/2DyCDwA7POrPFcRTq7PjVNoSPeoh8Cgx40I2rgtkVjukoVi7dqKgN8cEVVejo3xcsHLKYxYlZz4WrHbmU97cNcJ/wJ4fphRfmQfD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyjesXBFKcAdNEIbrl1beOzdjn+ExurT2wd9/szd9PM=;
 b=e3Js2tneRp3HSOh+2yVItMXs48l059HEsZf/3bLGUjBM6xjazyGTLPWmxKdm95mv84vsxCUwW+md+pJac5HjQtZ+BWapsGbx4eIQWEC+WjJFkxjVn32cmKf9zKBhidj6KET/1lRY76eoQFVfGHwM2IQKfdR+y+l2GH3hyUuJe4iCByh786C7PCIivEH/IthnFnbYh6OoHuwr6HNGc4eMe3MOFPJj/ACaSg9r5bwEP7uRGWh6COuWTSXg4msxQTkUUNfYxcca3H56NT/GDQpUVQIpHkSJjcIKDDvg77n0LMM9Sg+67QL0AfTCIheJrLllkj088yqDfPGD2q9NY73ecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyjesXBFKcAdNEIbrl1beOzdjn+ExurT2wd9/szd9PM=;
 b=AFMncd0e07TyeP6kGjS60jC9audD/C82XmXfyW3Jtt7KTE/Pl5mbCEV3IlaRN86sendt27XDj8xrPmaeQ7QSogimCNaJuG2jw+zkQwx9dzwNUXdWlwwhtfnAkq5FOyWiU8Zbs2qW5ANJykyHiO3IOS/yszHW3S4JEjspcgjcv5RnhFqE2OsnYVbzVO/BYQhhTyf+hQ6YdRNvpVyh0b5YIQQfrtozxl1L90C9gPU9ro25HVcyrV1tfyc4IyX18NLMPqYK35uXAk5ZYyO4BgxsfwS8CqNcEn4uWftUfdFXQMouvrW7PX9vlMdtIsFZW/vBUnRcJm4R7HsPQo6ZSvkYOg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB2725.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:236::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 11:54:27 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:54:26 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ajith P V <ajithpv.linux@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH net-next v4] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Topic: [PATCH net-next v4] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Index: AQHdOpxCFz9cdu5+c0CIi+PwW/t9iba8vdoQ
Date: Thu, 3 Sep 2026 11:54:26 +0000
Message-ID:
 <GV1P189MB1988D6E8CFCA2EA0A3BCB4EBC6B62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260902053043.1483895-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260902053043.1483895-1-ajithpv.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB2725:EE_
x-ms-office365-filtering-correlation-id: 96bbdd3a-36d5-40fb-557f-08df09b21ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|56012099006|10067099003|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 dS4c5faq+QhfnmoozU2YBvnvmzEcnbIHHGD4ab8Lu711Qw8rNza1M43rug0VMqdER4K9J8c1anko1kpJSktpGT09EVzuMq++UUNMd7kxD5HwVjO4hvKayoVX9mfJcbcAFbrv46tbvxiJkIVQnUUa70zVdlMEGhXu3xkyBR69j9ha+eshj/T5O/z1F9WubhEyhxy0SoQlNihag1kmmC5mpmMU+LfH3VWYm5sl9fINa4pETBw9Gf3Ab9TJ+EZ263+wvpq6KgOue6Y2xi5XJD4EvSaBWLC/Q+ljhlZkxZj5ykhBz044H9+n5cM7ErvOMnFAj1hZzoLqjh/6BRHwaR4iRxZuf2G9jzALXUahoTsgf3c7hz7FyqQ/iOpax2nlPp9OQYqo8lV2r10MFFcD+Ye00pAD+gOtxMky+JQKO9DCn81CR50DlT+TJPGcyDiJ4Vuu2IAljZpqIxI0H+sVpCyLMND9RZh6qQGo+L6akYX4AWmEnLpvjQIqtR8edCJUV29q4uLlHPJiYoo3V0los6NNwSWt3uFcoFIC1v6e8bItzX8f2US615YddddAzs3X39LUiNGPNBpKMv5o2XS4Omol1l7TcEcY+qIFelioYPP5OWEBmZInFxSIWfvwJl5sx7zYnDzESgK5M9Oh4V20nYeEXuXM0NrHgxcQ1/ltxjugQQU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A6dZPOVNUYxGGEmx3xbzMO+vmOJzp2vslx9NyF5zq9LFD/SEvzFD67NV0wvV?=
 =?us-ascii?Q?SsoY5LZrUtDqdH+XM827SdlswhvnxTbBz0FgPSr+qwzTixCYFruuCUOWChS1?=
 =?us-ascii?Q?Md+9n8CeS0gMUH7x4N24QCsBgpxDsq+hqwPpE587ZAccBuUaBZ58LMCwHaX6?=
 =?us-ascii?Q?dnDGOMUYFSSLJ+Hiri2Ao49zeinOZaZsVn+0okHDYMevSdPcEFcJ0pyc6/jP?=
 =?us-ascii?Q?R2+nK7gvpZ+kvgLyxlsbkOrM6Sr6H+QUbhQI4D4VAoZfLc/rJX6lVuoXUtVt?=
 =?us-ascii?Q?DX1/OFquhvf3wHNnYVRM+4EUf81dILoF//V6+KWNe3pEGmxzdw+k7IUUk+8J?=
 =?us-ascii?Q?Av+/SkSGgn05SYy+1pR37H2gg2itK4jioS9eOP2KCHEsokYLhqgmPhiWozvH?=
 =?us-ascii?Q?mNlVysc1W0EsZ+C1/u5i2kPNiyAiJndbq/J6QG0wGKAaMTBD6GHYnxH5nZZI?=
 =?us-ascii?Q?UqEZStJsjJIot3dvKvNyUWY/npdhTphoVKrMNhPr1kiSoPYtoYB+BBg3aRQt?=
 =?us-ascii?Q?BzEBu2PUZsyZvwdYVRqfk2xROtR7/KDqJPoUADISYLW6T0w+ZowfMDy8Iizb?=
 =?us-ascii?Q?YSQTFN8lcfQDa/4E0YhDNo44BYEfy28ZcCtarokKiNvEOXg1OjmUsEVzlSDo?=
 =?us-ascii?Q?1qN2Nc2LF8ueNWjuJDeEz2C8M94EEk6HqfzIzb2E34kkQgokN8/X4tgesYmZ?=
 =?us-ascii?Q?2/jiLNiZR/AdT5sR1sbtutuXHs9HWEL4mZXT/HKj0pWRBVTwPz79XaZeOT6N?=
 =?us-ascii?Q?EW4fsoFiPVH50LTMfh4yM6jcnUMfK5a9+1KaCtXkLcLKvXBJzOHPAtwA4/l0?=
 =?us-ascii?Q?a5lCn6FvBr3Vso2Wjlyu3dLbmNLnAyjPaf/YXSNp83EOoo+B5G4UpIAIZE6k?=
 =?us-ascii?Q?jdNVoujTHOy0ueha5bVb1I3GdSfdteVZSNUhmcpb1zl3HcDr7faWmBG2VeBa?=
 =?us-ascii?Q?z/cz5KBesXySF2rGx1hepKpyNEWwMxQ3t4BWFrrDOJGJRLmQWp/aiPOwIHMI?=
 =?us-ascii?Q?Re4kB3DZ31zke9XoT4pUqoR1stbtBKjX6PDvEruDIte/ozvIucfDVTahV0QV?=
 =?us-ascii?Q?4Wm1YaUVEXmy3vewf2g6NraFQS4WZLVrQ/qctAR5clWwzKrHsAVU/fOx2Nd/?=
 =?us-ascii?Q?VtTAn0Ps/KUFw1BJN95E/Lm84SYojrrZPSTt7/qZY/LW7HgIyc+cmcijFMEQ?=
 =?us-ascii?Q?isE3/yaEhCSZkBFnB4HN8F6w1eVpOEpuauzCDgfoY9UIGKOcjUCwtaM+jXeU?=
 =?us-ascii?Q?YFahorPMggAo0xDDtDHKvMc3q4gwMXa7HtYfA2C+hEFZSlB0UG+oFGhVPwFl?=
 =?us-ascii?Q?VjhwZduz1SDeesvkzV8zRqu4nfaJoSO2bplHIGSCQG2YUgL6s373t8K7oUhd?=
 =?us-ascii?Q?0VrZyCDv+iK9FfiwIzoE4zymZXQKqTA8ZNLU6xBoRTnr2VZplIN5UAksKfYX?=
 =?us-ascii?Q?NxAOJ8ZxxILco5HaNPLhMw6fSs56EMIPuPom8g9mf3tVUA7fUdHh+0DK0rMS?=
 =?us-ascii?Q?mqaXNXAj1dGSRQfh3HlLo02foDBpIF44DLA2uCOwrwQcQHZp4NXHCPP/Q7kQ?=
 =?us-ascii?Q?PlDJPO2YvZESHbrFd+Ge+PANpppPnjVeUR5+Chyg9Pfqoqi7eBAglDnxCWbj?=
 =?us-ascii?Q?cDuwFKiqgpyyt9Wzf74S/TB3Il5lAC3Qjzjc5Sl/h4LsgpUstN+92PAJATOP?=
 =?us-ascii?Q?LzvTdidsXlosqLaTP/y7SiR7lMKQLKedQm5bQED+n/xsZXIVhMBx2Z7ZJmVz?=
 =?us-ascii?Q?m4wjzWjf0Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bbdd3a-36d5-40fb-557f-08df09b21ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 11:54:26.6353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bci8dbiiuAEqa7MhenGE9C7W74EsxjSMrC/BM/XUYWZXkHs5FTjl+r/fU0t4jxP/w+6KELB9EPMmnHpxBSs3t1CXOnQs9aexda6HiJ/xHNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2725

>Subject: [PATCH net-next v4] tipc: replace deprecated strcpy with strscpy =
in
>tipc_bearer_get_name()
>
>The `strcpy()` function is deprecated and moving towards code-tree
>elimination. Replacing it with `strscpy()` fixes potential buffer overflow=
 vectors
>by ensuring safe NULL-termination based on the destination buffer size lim=
it
>[1][2].
>
>To make the interface safer and more robust for future callers, refactor
>`tipc_bearer_get_name()` to accept a destination buffer length parameter.
>Replace `strcpy()` with `strscpy()` and pass through any potential `-E2BIG=
`
>truncation error code up to the caller. Update the existing caller in
>`net/tipc/monitor.c` to pass its array size.
>
>Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcp=
y
>[1]
>Link: https://github.com/KSPP/linux/issues/88 [2]
>
>Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
>---
>v4:
>  - Avoid hard-coding TIPC_MAX_BEARER_NAME in the function body.
>  - Pass size_t len from the caller down to strscpy().
>  - Forward strscpy()'s -E2BIG error up through the existing int return ty=
pe.
>  - Updated function documentation comment block.
>v3:
>  - Fix patch title as suggested by Tung Quang Nguyen.
>  - No code changes from v2.
>v2:
>  - Target net-next tree instead of standard net tree as requested by Tung
>Quang Nguyen.
>  - No code changes from v1.
>
> net/tipc/bearer.c  | 8 ++++++--
> net/tipc/bearer.h  | 2 +-
> net/tipc/monitor.c | 2 +-
> 3 files changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index
>05dcd2f9e887..abd90e6bde09 100644
>--- a/net/tipc/bearer.c
>+++ b/net/tipc/bearer.c
>@@ -195,12 +195,14 @@ struct tipc_bearer *tipc_bearer_find(struct net *net=
,
>const char *name)
> /*     tipc_bearer_get_name - get the bearer name from its id.
>  *     @net: network namespace
>  *     @name: a pointer to the buffer where the name will be stored.
>+ *     @len: size of the destination buffer
>  *     @bearer_id: the id to get the name from.
>  */
>-int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
>+int tipc_bearer_get_name(struct net *net, char *name, size_t len, u32
>+bearer_id)
> {
> 	struct tipc_net *tn =3D tipc_net(net);
> 	struct tipc_bearer *b;
>+	int ret;
>
> 	if (bearer_id >=3D MAX_BEARERS)
> 		return -EINVAL;
>@@ -209,7 +211,9 @@ int tipc_bearer_get_name(struct net *net, char *name,
>u32 bearer_id)
> 	if (!b)
> 		return -EINVAL;
>
>-	strcpy(name, b->name);
>+	ret =3D strscpy(name, b->name, len);
>+	if (ret < 0)
>+		return ret; /* Returns -E2BIG if destination buffer is too small
>*/
Line length exceeds 80 columns as reported at:
https://netdev-ctrl.bots.linux.dev/logview.html?f=3D/logs/build/1155826/147=
83036/checkpatch/stdout

Also, the changes can be made simpler as follows (I help you fix all warnin=
gs):

---
 net/tipc/bearer.c  | 6 ++++--
 net/tipc/bearer.h  | 3 ++-
 net/tipc/monitor.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..65fa18928fe3 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -195,9 +195,10 @@ struct tipc_bearer *tipc_bearer_find(struct net *net, =
const char *name)
 /*     tipc_bearer_get_name - get the bearer name from its id.
  *     @net: network namespace
  *     @name: a pointer to the buffer where the name will be stored.
+ *     @len: size of the destination buffer
  *     @bearer_id: the id to get the name from.
  */
-int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
+int tipc_bearer_get_name(struct net *net, char *name, size_t len, u32 bear=
er_id)
 {
        struct tipc_net *tn =3D tipc_net(net);
        struct tipc_bearer *b;
@@ -209,7 +210,8 @@ int tipc_bearer_get_name(struct net *net, char *name, u=
32 bearer_id)
        if (!b)
                return -EINVAL;

-       strcpy(name, b->name);
+       if (strscpy(name, b->name, len) < 0)
+               return -E2BIG;
        return 0;
 }

diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 41eac1ee0c09..9ccc9ffa925a 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -226,7 +226,8 @@ int tipc_l2_send_msg(struct net *net, struct sk_buff *b=
uf,
 void tipc_bearer_add_dest(struct net *net, u32 bearer_id, u32 dest);
 void tipc_bearer_remove_dest(struct net *net, u32 bearer_id, u32 dest);
 struct tipc_bearer *tipc_bearer_find(struct net *net, const char *name);
-int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id);
+int tipc_bearer_get_name(struct net *net, char *name,
+                        size_t len, u32 bearer_id);
 struct tipc_media *tipc_media_find(const char *name);
 int tipc_bearer_setup(void);
 void tipc_bearer_cleanup(void);
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index a94b9b36a700..a8a088fc2a2c 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -829,11 +829,12 @@ int __tipc_nl_add_monitor(struct net *net, struct tip=
c_nl_msg *msg,
 {
        struct tipc_monitor *mon =3D tipc_monitor(net, bearer_id);
        char bearer_name[TIPC_MAX_BEARER_NAME];
+       size_t name_len =3D sizeof(bearer_name);
        struct nlattr *attrs;
        void *hdr;
        int ret;

-       ret =3D tipc_bearer_get_name(net, bearer_name, bearer_id);
+       ret =3D tipc_bearer_get_name(net, bearer_name, name_len, bearer_id)=
;
        if (ret || !mon)
                return 0;
