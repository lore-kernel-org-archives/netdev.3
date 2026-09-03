Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23194316905;
	Thu,  3 Sep 2026 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400708; cv=fail; b=Bb45C31UFAGlZnfCg7nGChl0fIKCCSEhNTKgExRTHRZZdCuzI2N8Lbj2gmmgYSVQSTJ1rEXMlNxqmxUWiSu/mmTKJ64GKrBsRe8jkpI0Z2VhF99GtKjf2HPaSvWvwAXTrJafA6GxkelQCzGKkhVZCRG6Vq01qq7c8+a4NH6jwc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400708; c=relaxed/simple;
	bh=0QPIXnWoLGsr8OEyPcjX23F7kDMcqE9c0jBj1Kg2LRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=owQruAW4+HlVqWA8UmYoc7/FoMI6hI4XA7MF624T7N+hZHmximPmHEbWTqQe8IRtPOXA0Pk9qvpxl5x7mPJE2nOIdvxerulee6E5XGJhUxBDji9r/jGLR7Xu1PRMljzYapVljJy5L+6ELngirVguhiAkHIOUIG4rwtmG4hm/150=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GCQdc4jm; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GCQdc4jm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA653+W2ZoWmZWOPELpcoUiMVcaODKQMNcSTU9sKzWFL1ig+rEeTxBRg+gLU+7fJArmDEdFrvF2VRQ+lxabzvNa2LcdXNkZ3mgylXz5kV+LxUDGNomlbn+q3nNpSb4KmodK/8VpjcN6qYM/LU6x6TKp05wOdqcX6h0TKUpiRzHwyfl0nA+V0XGPKDm01D+iDE3YZ9d2UtJlEFO0kgq+d2b2k/eA9jFzWPR4LlI9HletJkRlcJs49dOQtTVvrWkKYYKx/Yzv1pAkPfvOw6/O93t6ouvpMQVGit5yBrVav06O4ERWV/tGRH22ce2IzItITVVvh1sfCX/zAaGu/xiaOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ48aXEsCZS/AmhfcmFnlNQQlhwfd1I5UG2+EM2rQ+Y=;
 b=eB/HhnVRHop54lFrwBOiDd7XptnfgDpbBOImXignp4TgUOg2nDKs7CQq/IgiwIxoGX7YsBzYbupq0HRcM9HuDhjUZz15Q/MS4cHQNkNKYo1+Cv3yYR/rzoWAUZPckkijuJlKSjrPkeSBu+GNIiCHx9X4Hu6d8SlTPznAhL37PwNTxKhkHl2eRpV2HyzJylA4ldMHhJOEBOKdPyUfqLbt6xk+ngjQj5pPE3X+BNPQJfpfMkBXcpRLkVv4nPmGmaMIAlbxnFODD3i+5eZs5kqp+GyNafkZ49VMdu1eZuiePhRo0zwhFUg3DMVgv4+Aa0Rar3dLcA8RR42EmLJep8INSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ48aXEsCZS/AmhfcmFnlNQQlhwfd1I5UG2+EM2rQ+Y=;
 b=GCQdc4jm0WNTMAlAt1Pn38zAuE4tvSJb8MpavINHmqxXd8iN8R3KO4Oc0Io6wf2Z6kTyBKxCOHhkXbDszkfXFm2l2LubzBHeDi4a0ALRQkZPdD78iX1ATASNLBpQ1nIUumNXgx3FR3zBxyC7mRN2kGNeS+WfLGhCv0ka9yc8UgVQfns/6MWhLWcy0dpozBLhyzdDgoZHYylfnS1+iT57cs2tiXNNKXpcLx8papUxoBiYpm0obypme/M2gqRfB+BOgjN1qoGfK0NWlIK3kqy0Fxre42qyflhdmDf/35X8rDBEGSEiuYu/HMeh3/WJidPQXJxTlIMT6+NOYA7MyNO/JQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM8PR04MB7971.eurprd04.prod.outlook.com
 (2603:10a6:20b:234::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:58:24 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 01:58:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: fec: support RX flushing via an ethtool
 private flag
Thread-Topic: [PATCH net-next v2] net: fec: support RX flushing via an ethtool
 private flag
Thread-Index: AQHdOeYpTnr+hxg33UK6MQYtuSHI7ra8GMhg
Date: Thu, 3 Sep 2026 01:58:23 +0000
Message-ID:
 <GV2PR04MB11739A239A2926E73FE8B994188B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM8PR04MB7971:EE_
x-ms-office365-filtering-correlation-id: 2f156e39-99ea-4cab-265f-08df095ed656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 sI+81Liw5cog8yJ8HG5Fkl5gAQMkBdtUpW5GXFxIblLHHwdcQkAo4/MRJcFB0Aaw/BITUI7KF4qS37fZbl01Zf/IMajld7r5Vi+zwin8XQPOFAJUtCia9EedyrcQE4Rbr+hYbZw/R67VMvBeg770xufSFxkH1ACmHAOrWqaiiVN/9o7xiCb90o+erSK1a1qKxuIq5Z/a7nMaT0Bk8gVJArq+5YlfJBjUu2ZSo7gVv9cvUce+70W/Qzq2yzRi2/nWZRNG1s3rYB28LmJQkyoijkTdvef4PCS+4aI/13BrAm/tihpsEGOH6RQ5Tp4eNh099iO+rBeHWQZBgure8TcEELWPNIFVC1rKXAheitapnNgA9SKXUWXj7GOwSZL8dKFCB6X4L16e5Ikxws8PYCBSk52nFajtLYCBSkk647H0jfZQ7UsSbonk5HFVGxbpDGjrGcnD3xBvHHEOmanFmP6AY3aldAocW0aZukH8Gkvc+38qXs5YuVkuFUaaYNiEGD6iS4pwRo5MrS3Y7CV+nNGYzHq3nxe1AxSiKzdSvzMAVySn0Y9UU04u9yHohjEbIqdlRbcL2ag/fiW+mwxMoVeS8lXkiqo3RRZEs+wZJY+O0lsENhEpRJMnox9/XLUGPM/jfMVvrigC2LbM41CcFjMw8EyJJqJuJB+gYpx56ifwStuKpkxsptM/8jhldGmbzn6t8z8/JKR6BQqlwkal+heL2rn6bUhmXeYJghbiDVh3G5U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F3fiMo4W7fSi/O4f5pFl0J7X494+k65f0K8ChS8odxgYaSnCt3pQeoLDqAY5?=
 =?us-ascii?Q?ZtD+kgVmcvOGcYzQYikneQQLOP3ju8YTU2jtuWghEDrCq/lD1n3K9FEQSRC/?=
 =?us-ascii?Q?/HuZ3Xt9t3DlZnvVfLwWDC5DnDte9uKRGMpRVNukTvRb/iW3KTDe/CR1w1L/?=
 =?us-ascii?Q?s2R+jJ0Yvzi6LooHpjkauPxfiqbhVH1geRitflEsjLw/2R0ZCJFhndbmo27n?=
 =?us-ascii?Q?l+2MTyYUpBapkaH28hUb7sV2opdiFp/weMeH/9Al7oQ9gkL2vFGtYr/DFQJz?=
 =?us-ascii?Q?4LzeGtrn8bHm9usoQB0dF0I6vOZQ7NfIGWzw8A+JZlSmGxXUhEtOsoBaqYhx?=
 =?us-ascii?Q?40z+fkwla67kUVjgEIJ6EPZ4/R1ZM2IgnN4U0guqch9lGl/vzkl3kCuxy1K4?=
 =?us-ascii?Q?0czttPFZ43jZWBFputubkqBZvExgsT2efiZ2ELUJ0Az68rKIQy4NfrlfhM4f?=
 =?us-ascii?Q?EFnEiXZkdQ+GrZsXG6V4hWIjx+lkCbRHpfYQfwzUkK95YsJkTEVuDeZSjcJO?=
 =?us-ascii?Q?qsCQjBhx3lj/6qY1w191eput3qLzKV93y5VsHjMWOeZg+xI4Fvdc36zsirN1?=
 =?us-ascii?Q?uDuUiUVSA9QJaPrG5dsZHTpCHKsIMHasNj4xKRUtJLOO6a2STn8xKj3R4l79?=
 =?us-ascii?Q?IN4wedt7C9d/uoPx/1KxBqxz1UTgOEnXgTY/9KyfCK21oxi2D1RKVLMfj+VA?=
 =?us-ascii?Q?UvaG4GqyJFdBSTCctn/DxtCFYvyXMk0W8SkciuFDKbDfk6m9ecU0cw8IQluf?=
 =?us-ascii?Q?WIcGpeCDcGng7Rts/5TcyA185n150KAaEOSxRSsZzu7EBlx4e0c6Xn3iLI1h?=
 =?us-ascii?Q?TpH/QiNnveKB3l/ILxL1FZT+0O6q5Q5YR1vAPbwWyu9KpHTc4a0S0e01wY6c?=
 =?us-ascii?Q?Uvlpg5WVncpma+qSC4uhmBv4U22p9KfsVfr74gD/3Sm7YbzPC2HGg7NzfRw5?=
 =?us-ascii?Q?x410lLD7W0mwxZb62KJ+eC6Ba+jRGOO7l6afv6sIl+B6jYoNnCrTUSgYQ1JV?=
 =?us-ascii?Q?i9HxHq+ygd42J1hw9l5F42bzxViWn2m3thxWtfG0fEroDPQUSmmfQLv2GXN/?=
 =?us-ascii?Q?rNTom2TbVARDWF/nexIA2yiWS7vhn7Z1AoUEII0YmFflKTrepoxKqomnao/q?=
 =?us-ascii?Q?UeYkTDtMo0pP3j2FI9RU6qTHZ+r7mhb5kGxdfb0oZTBi01XO2vqs6uF9nNqg?=
 =?us-ascii?Q?6wf5ES8bEc4ZQcLu+SFZ/dpo68z5Egfj23zJcys1tobXG5NhPC+ry9L+nEpn?=
 =?us-ascii?Q?xdD0z4sCH6RIfoW39roat4fDfM/HxKJiWPmB1RFl7CziqyOJqCQpobHO1UGN?=
 =?us-ascii?Q?hQMb9QJUmCF09CXA8lbKmE3rr9Xlw5va/14VuLyboskzFSMbBgMRHpKD0fl6?=
 =?us-ascii?Q?ftn24vrrTq/zyWrRxM4s7xgfYiQm3wNO6Kj90eS073U3uMnRI496BpIxxzGF?=
 =?us-ascii?Q?yxh2dfnuJpU+OB9IhX/4ECGIeAUazcs9D7CAY4lUq99Jcvh9qAUj74e1prLm?=
 =?us-ascii?Q?m30q//sRVvcJ0KHUunwd6lwNnj7p9B/WuA3EWMuNwKts3QzRDMkc8uxK21Gu?=
 =?us-ascii?Q?mrY5UyU7nE1FbCPSPqdMV2dUwDY3cOtg6eXIK1MCzNr7vFCaWgSNvwv2XuDm?=
 =?us-ascii?Q?8Rz/l3zQT5UQpSDcFWKNDtLvApWYkG7eZMu0MtbTHenp7RHNwkSdPCprdPvH?=
 =?us-ascii?Q?1bF/R37EtHo6SRa6u97P9IKGt2UMYWpXo+ON6JLkWfeZVcCa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f156e39-99ea-4cab-265f-08df095ed656
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:58:23.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFvpsZgBufblIWtv2qU7BkrDJQyKJoKtbwAO4wTSjU1lm4dxoLZTfzDzCXIO/Q2OmFQNFeJErF3rexw6oqGW8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7971

> @@ -3546,6 +3565,7 @@ static void fec_enet_get_ethtool_stats(struct
> net_device *dev,
>  static void fec_enet_get_strings(struct net_device *netdev,
>  	u32 stringset, u8 *data)
>  {
> +	struct fec_enet_private *fep =3D netdev_priv(netdev);
>  	int i;

I noticed that Sashiko reported an issue with the implementation of
fec_enet_get_sset_count(), and I believe this issue needs to be addressed.
When you post the next version, please help add a blank line after "int i;"=
,
as there is missing a blank line after declarations. Although this was not
introduced by this patch, hopefully you can fix this minor issue while you
are at it. Thanks.

>  	switch (stringset) {
>  	case ETH_SS_STATS:
=20
