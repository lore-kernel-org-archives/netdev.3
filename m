Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4903DA5C5;
	Fri,  4 Sep 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508375; cv=fail; b=EfEEaaZUkBcnCEo7K7KPHCE8HDhxoh725LwbBoT6XbeIvrWMKSYQJCSL7XL9AunsQoEr6xwA4nNw4wLRjYjLWzlkH6/YUCLTFO4BHYmMe/Pwq0AdNTUU+VE7iHeU+sFPmb3vdXJGRL1egBlHTkhg6SALEjXoA+ArhB7ZJ+oqYdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508375; c=relaxed/simple;
	bh=owuFfi6C8xcvXOhNNmeOGKTOVYLuKaxYvOykfMvAGgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=axSfNEkW6WKnkD1N9XviZn4rDxivnfJX1aAnHWFTnCurlt/YtOZpOxqIBNahPBf1iP3tOItB/fta0etAvKjpnUutFn6xsw6cbS5gVJuWAX60p5yFxYt7WEwr3c8K9tf5k6gRICiogBPhCPiBw5U95nRiCqHnHDUyMvS/jO5+uRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KOLGQ1tQ; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KOLGQ1tQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wah344f5PItfQPY+upxhDZBdCnNJjHzAvtaXjV3sl3CWR3Or68AdCFYoSQmCQrwfuxGUlvybS/9+KqEBEAtF/0XAQbbeI8aW3o31LgCcPKVmcEi/SWrBIuCx57lweckQ9o6s4sXDP9Fo0Nd1vLjY5f/7FvqoK92Z842P4nBxwqZMrTJBJ0ixPqz11H7QqjNIdgQ5C0S4t29axAZ/7TJ0vsH0ZAxCjM/ytqXDPX9lAY4h91dvyJjsMzFOOzBlgr3UiyH150FG82eSFiBXE73bKu7LQYo2XAYPLSLc2OL5p3MB2TnSJiMyWoecQBUyVN2EtF27TUfrVzkIO6Puh4y6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp4NL4aWJADVd8FxHqUZhUjzPLecTE9Td/j1Jgjr93c=;
 b=PjLiDv/VYdOLrXTD4PByR0pks6MW/UrV9wRnlSFCPCWXHnvNWBhigCtm9A0YZZLOIVe2HdnxTjNidkdV8xmAb2/GEoSNzmtj72tD3c4EXP0xaxSrg7dwetzOg9Z2PiXdwXx6rtB1TW4bPlgaqVcWGd0G8/MJzilyfPTmNjmTrrl2C1W2X4eUplCCjzAFp9ewiCKhTMXrm7+Mhmv8auNaT51GASbvEjA5bcWZg74ce/KDWyu20zKI6CI7BvOdtoCcX44qWZ1zFWvGPJFUmSupfPBOdM7sswM8SUMOgWVL1Tu4WSI4EFJVALIZghTt69j5m8P6RN+y0OczSeuDrfYwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp4NL4aWJADVd8FxHqUZhUjzPLecTE9Td/j1Jgjr93c=;
 b=KOLGQ1tQbuf/xUm17fkxcXdWK1+Yj64fpQdNLxaCwbUkSKjtfZ06P6sEBdcJcDDOzCF+w+arvU8Nc3ZndO2IanOPn1bLnrtkgPTnFkl1IDfDKKI10rMlFRIKqE9M2kr5ghVlDpwcxX6Axw3Q083NtZHs8PFJ5QXONNswREeEcGFWmFGk7MqVxkHTk8c0wZrOBEf38udmcLDqvJmUUcefrFBO1a+/xvkqVpezeQu2v9JcNh2Ks2/ldJ4I8D2yiWzXyhUR/JEPz1ZxP+6rSUxUTIGRjdtNRmEbEmy+axbRGDwhDJLcQL31FBD9sAUW2Op3Qf184vMmh058U9sMOWLOWA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by VI1PR04MB6973.eurprd04.prod.outlook.com
 (2603:10a6:803:13d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:52:47 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:52:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>, "Wei Fang
 (OSS)" <wei.fang@oss.nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Topic: [PATCH v3 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Index: AQHdOPf8zvCP2zR37UmwwM82nYY157a9ilwAgACBLWA=
Date: Fri, 4 Sep 2026 07:52:47 +0000
Message-ID:
 <GV2PR04MB117399C0557AA16C12279AB0588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-5-wei.fang@oss.nxp.com>
 <178847906490.4131868.13521334026222207494@kernel.org>
In-Reply-To: <178847906490.4131868.13521334026222207494@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|VI1PR04MB6973:EE_
x-ms-office365-filtering-correlation-id: c7970a74-4fb8-4d29-71cb-08df0a5982b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|38070700021|11063799006|6133799003|10067099003|5023799004|4143699003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 2LV1vUCOS3MJXJc3SsuNqapmKz/0KuGwvMq41QjztnEAwN9kW65/UiKqFYVoRIdKdiB4FTXmGvdECGDiaXgHgybD2ftmt66YLFkFmNNu7j8crwVckNg6G2UtJqa1tRMDAXk/Wb80KfAWGN4QfsobWdnoo+va8oZXr+qhM/qtCIi8/usH9whY0q55rCcw+ZSUxC5j2Q35T0BdO4qv1naH+eq+aVqR7nEnlKXfJIyuUKTB6ljci7HXMCWzW05zhBu4qjTHjgDkEds3q1oG/xpxyZa7FFSo180MYN5ggJ77yy/8vNEdzVJI33xlB3EfqOveQONFn/7NuzpO18nGrr+EnieLaGmO8aUO46xxl9bB67kmgH1HTy5ddC9KbeuJqLDrloiOHAGKcXLdzDay/5h0yKe2N4RQg+YlkcJLn2L3imzaNf+yHsQrx+jhKpPVYo8BRuLmhrg4Hv/AMZ6dvqzNuAtQqO/0UyTAYzuRmiSTm+WG1Ri+P3oMI/M8YUpBFGhGPW2IyULzkmTc6FQnlvmmrJTkBCq+/UH1P2v+2qSF9Fktj/d82FzS+hez1rQBqWuN1PgRN0qf1BAJJxte0+TrsAiCuT655eRtV3skXaGIoLGk9/TaV9MYn/PBDZ39eEW9RFgi3OlVe9x1EmZ4iQWlBct2NREvKnDdvRcNAy/w/ABG0DTVoLtK7mDGsv4WlnnnlvvoSmlf/qiJkKejnV0GzKK7+r9B2YWg9IUx+6izzp4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(6133799003)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MfnKJ1kocFM6bCCbp2tSw1iPkiVUhIKv8itsZ5hC65ocqxXoeWbqemsVRCWQ?=
 =?us-ascii?Q?4d0e6OeKS+hp+xvFvPNUNjnflDmvzpPHlu3Iq5q4BkMt42XVQuWf1CD1qRf1?=
 =?us-ascii?Q?P0ryFGBiQ6pG0H6qA4NK287NCCXwQ+Tzrhh6Rq3vj7PfvBq9W5v5jYuF/Wnt?=
 =?us-ascii?Q?/AAOB3y37oUYcXIxByfEfqtT54XI/T1TlooLfWrW1vpz+kvacGgUpOidvFhW?=
 =?us-ascii?Q?MWN6+XJuzamWM0AnVR64zIHEYOtl38GK429ta5Bl6HoT8Uun+ojOcqR2gDf7?=
 =?us-ascii?Q?r/FVtBi1uL5pGOaucnQ+8/IAgkI8kkz4wkWbS9qYPw2CWusMmpFFrcBdDhZd?=
 =?us-ascii?Q?X12RdrFG7oov9JU5YUDqz8i0FdAAuOte7zVXklOKyC9wc1HIzUjqSGe+i/eP?=
 =?us-ascii?Q?oDUUxKeJBCspklMm+NIDGUDYAh8wDOpW9pP4CYnrebI1TstXQXP0RChBfZlO?=
 =?us-ascii?Q?OtDNWLOenU4th90resIHbFfrosAJEbLpYqadNuEnQZTJJe7Mk95ZF3Ht/zw8?=
 =?us-ascii?Q?SAA9Qzvyz33cqo+VH922cV2IhzjkIHRvZU3fBrq43pyCxTVQwqqPaYNdgToU?=
 =?us-ascii?Q?2p9m87pTV8ZFENTv81heQbdgxjHZbPjohfJDXltjl7+7dLQdybRrgvTxI6v+?=
 =?us-ascii?Q?3dA+JOu7xE0jdjfcBDJEYk4pw3+3frp/7V5SeFgX9EoSy4VsCi3FLigfVKtE?=
 =?us-ascii?Q?JwD3aHxrQm/9ETXmlVOQzLJ44bzfRxZQeCWUCSApflmh3BNEZmeVW4v1Fj9t?=
 =?us-ascii?Q?mBL6/PQ9OKArJvfD5R7Al1K50mnSyJIuPok11xfmJxVpcZaSsUWwKpkX3u4Q?=
 =?us-ascii?Q?LcoCp5tsjcN4WnyKXod4yyIHJijunO1M/i2S7rW+PilwSy1hWFnX1kPG9+5Z?=
 =?us-ascii?Q?AoSs6CFbBoNsRouPoLJ+WtMN9CB70MI68VpS9IbxVvodfsTKR28yuay2R4KX?=
 =?us-ascii?Q?I32bhS7D2qcM+8tE+1NKVTfcq5vgOaGx5n3b6R7pfEKBX+Qk2yeHZQeIcneO?=
 =?us-ascii?Q?5dC1a48gmfMyFEG+wccLSqCil623XT2GMDQ8AOAk2qUNdB78pFIvoTM8yAct?=
 =?us-ascii?Q?3S0IEW3x0P3TjykThtC9wNG+Wdcu6NMAbukJKxsshtCvMjEwm1Rco2XLgwOF?=
 =?us-ascii?Q?IgRSSKShl4hvga6dPkhQrqHJVWjQbSS7j7LjoJy/8LtePxpYeisicnBJgT9M?=
 =?us-ascii?Q?3SfoMsZ8lNdlvVUPlKPgaPOsOJYzX03CcCcHW9GP77w0CjG0ObqmTb8ZYQPP?=
 =?us-ascii?Q?Lrw8z1zsgg5L+3pNuGgIJNUBvnwbqaMsK7ZLYMdTUIHXmqNOKLgZZ22DOgNq?=
 =?us-ascii?Q?72aWdOHLQkjjgEArwP4Ckc5bbP+BVjBvj3MgzHeMmFC25Pgr1aRz6WbRW31v?=
 =?us-ascii?Q?qZQdctd0SYaAwoFVgs1Xc8CKPIttwXJIVunmDa8Y0XOaiGMKvqwKgc3nKOk/?=
 =?us-ascii?Q?uJjCu88w5HDeQdScLWaAaZZsuQJ++sSLtwK+PJd7XPNswPUY2P8GbwIGzIcZ?=
 =?us-ascii?Q?gg6YWSQfhqsAjnETgYQuD3JXx6z6IcNGoEtLheHSIrKHIxh1E6AEhnoEYGXg?=
 =?us-ascii?Q?08X86IuNqJOi1F+4a3zX9iXJJBBNRfyG9dsdpODR9ccXVI0+q9hrIHCuV86f?=
 =?us-ascii?Q?fadlR7AFGpcppHPycBEmniV6GCFLzmbvIWbBtTiK61tL0IajeOL8apqVx3AA?=
 =?us-ascii?Q?sOlkuQUl1fozRA8OAXXXKn9XirYO+Hc0L+NU1MvqiHXdQ6Po?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7970a74-4fb8-4d29-71cb-08df0a5982b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:52:47.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQFOtLJcm8Wh3Jo71NK+zb8mjygp8ptQmeKkDvKQm0LvfWMX/4jrHFkqk/K1PmyqKgEPjvCSyp/QC8ZF/MQhgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6973

> > @@ -181,6 +212,11 @@ struct enetc_msg_mac_exact_filter {
> >   * cmd_id 0x0: get the current link status
> >   * cmd_id 0x1: register link status change notification
> >   * cmd_id 0x2: unregister link status change notification
> > + *
> > + * Link speed message, class_id 0x81.
> > + * cmd_id 0x0: get the current link speed.
> > + * cmd_id 0x1: register link speed change notification, not supported =
yet
> > + * cmd_id 0x2: unregister link speed change notification, not supporte=
d yet
> >   */
>=20
> [Severity: Medium]
>=20
> This documents cmd_id 0x0 as returning the current link speed, but can th=
e
> reply describe a speed the port is not running at?
>=20
> enetc_msg_get_link_speed() takes the value straight from
> phylink_ethtool_ksettings_get() with no link-state gating.  For a fixed
> link, phylink copies the configured speed/duplex unconditionally:
>=20
> drivers/net/phy/phylink.c:phylink_ethtool_ksettings_get() {
> 	...
> 	case MLO_AN_FIXED:
> 		phylink_get_fixed_state(pl, &link_state);
> 		phylink_get_ksettings(&link_state, kset);
> 		break;
> 	...
> }
>=20
> So with the carrier down, or before the PF netdev has ever been opened,
> enetc_build_link_speed_msg() still encodes a valid speed class code rathe=
r
> than ENETC_MSG_SPEED_UNKNOWN.  The MLO_AN_INBAND case reads the
> PCS live,
> which also need not match what the MAC was last programmed with.
>=20
> Would it be more consistent to derive the answer from the state the PF
> already tracks, the way the sibling link-status message does?

No fix is needed here. Message class 0x81 (link speed) and class 0x80 (link
status) are intentionally separate, and each returns the correct thing.
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_get_link_statu=
s()
> {
> 	...
> 	pf_msg =3D enetc_build_link_status_msg(priv, pf->link_up);
> 	...
> }
>=20
> priv->speed is written next to PCR_PSPEED in enetc4_set_port_speed()
> (including the 10Mbps fallback on SPEED_UNKNOWN), so the programmed rate
> is
> already recorded.  As written, a VF can be told 1G/2.5G while the same PF
> reports the link as down over class 0x80.

GET_CURRENT_LINK_SPEED is meant to expose the same value userspace
would see via ethtool - the port's configured/negotiated speed/duplex. That
is a property that remains meaningful even when the carrier is down (for a
fixed link, ethtool likewise reports the configured speed regardless of lin=
k state).
This message never claims the link is currently up; whether the link is up =
is
answered by class 0x80, which the DPDK VF is expected to query separately

>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > index e21414acdc0d..c3ae4c024f34 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > @@ -280,6 +280,93 @@ static u16 enetc_msg_handle_link_status(struct
> enetc_pf *pf, int vf_id,
> >  	return 0;
> >  }
> >
> > +static u16 enetc_build_link_speed_msg(int speed, int duplex)
> > +{
> > +	u32 speed_code =3D ENETC_MSG_SPEED_UNKNOWN;
> > +
> > +	switch (speed) {
>=20
> [ ... ]
>=20
> > +	return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> > +			  ENETC_MSG_CLASS_ID_LINK_SPEED) |
> > +	       FIELD_PREP(ENETC_PF_MSG_CLASS_CODE_U8, speed_code);
> > +}
> > +
> > +static u16 enetc_msg_get_link_speed(struct enetc_pf *pf, int vf_id)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(pf->si->ndev);
> > +	struct enetc_vf_state *vf_state =3D &pf->vf_state[vf_id];
> > +	struct ethtool_link_ksettings link_info =3D {};
> > +
> > +	/* A malicious or malfunctioning VM could potentially spam these
> > +	 * messages in a tight loop causing global rtnl_lock contention,
> > +	 * which may severely starve other processes on the host that
> > +	 * require rtnl_lock for routine network configuration, resulting
> > +	 * in a system-wide control-plane denial of service. Therefore,
> > +	 * we expect the VF query for link speed to be trusted. There's no
> > +	 * need to consider the transition from trusted to untrusted here,
> > +	 * as this won't cause rtnl_lock() to be called frequently.
> > +	 */
> > +	mutex_lock(&vf_state->lock);
> > +	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
> > +		mutex_unlock(&vf_state->lock);
> > +
> > +		return ENETC_PF_MSG_PERM_DENY;
> > +	}
> > +	mutex_unlock(&vf_state->lock);
>=20
> [Severity: Medium]
>=20
> Should the trusted-VF requirement be described in the changelog and in th=
e
> mailbox ABI comment in enetc_mailbox.h?
>=20
> ENETC_VF_FLAG_TRUSTED is only ever set from enetc_pf_set_vf_trust()
> (ndo_set_vf_trust, i.e. "ip link set <pf> vf N trust on"), and pf->vf_sta=
te
> is allocated with devm_kcalloc() in enetc_init_sriov_resources(), so flag=
s
> is zero by default.  A default setup therefore gets
> ENETC_PF_MSG_PERM_DENY / -EACCES back from enetc_msg_vsi_send().
>=20
> The commit message says without qualification:
>=20
>   "The PF will reply the current link speed when it receives the get link
>    speed message from VF."
>=20
>   "VFs controlled by DPDK can obtain real-time link speed information fro=
m
>    the PF"
>=20
> The ABI comment added to struct enetc_msg_generic also describes class 0x=
81
> cmd 0x0 with the same wording as the 0x80 status query, and
> enetc_msg_get_link_status() answers any VF with no trust check.  Two pair=
ed
> link-info queries with different permission models is surprising for a
> DPDK VF implementer reading only the header.

The asymmetry is intentional and technically justified, but you're right th=
at it
should be documented. I'll update the changelog to state that the get-link-=
speed
query requires the VF to be trusted, and annotate the class 0x81 cmd 0x0 en=
try
in enetc_mailbox.h to note the trusted-VF requirement, distinguishing it fr=
om the
ungated 0x80 status query.

>=20
> > +
> > +	rtnl_lock();
> > +	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
> > +	rtnl_unlock();
>=20
> [Severity: High]
>=20
> Can blocking on rtnl here stall mailbox service for the other VFs?
>=20
> This runs from the single work item that services every VF with the PSIIE=
R
> MR interrupts masked:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_task() {
> 	...
> 	for (i =3D 0; i < pf->num_vfs; i++) {
> 		...
> 		enetc_msg_handle_rxmsg(pf, i, &msg_code);
> 		...
> 	}
> out:
> 	enetc_enable_psiier_interrupts(pf);
> }
>=20
> rtnl hold times elsewhere (ndo_open with PCS/PHY negotiation, netdev
> unregistration, another driver probing, netlink dumps) are unbounded, whi=
le
> the VF side has a hard 200ms budget:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_vf.c:enetc_msg_vsi_send() {
> 	...
> 	err =3D read_poll_timeout(enetc_rd, vsimsgsr,
> 				!(vsimsgsr & ENETC_VSIMSGSR_MB),
> 				1000, 200000, false, &si->hw, ENETC_VSIMSGSR);
> 	if (err) {
> 		dev_err(dev, "VSI mailbox timeout\n");
> 	...
> }
>=20
> So one iteration waiting on rtnl can push unrelated requests from other V=
Fs
> past that timeout, with a hardware mailbox transaction left outstanding.
> For a host-assigned VF, enetc_msg_vsi_set_primary_mac_addr() is issued fr=
om
> ndo_set_mac_address with rtnl already held, i.e. the VF waits for a PF re=
ply
> that needs the very lock the VF holds.
>=20
> There is a second effect on teardown: enetc_msg_psi_free() does
> cancel_work_sync(&si->msg_task), and it is called from
> enetc_sriov_configure() (pci_driver::sriov_configure, invoked from
> sriov_numvfs_store() under the PCI device_lock) and from
> enetc_pf_remove()/enetc4_pf_remove().  Does SR-IOV disable/removal now
> wait
> for rtnl while holding device_lock, for a time a busy VF can extend?
>=20
> Every other handler in this file avoids rtnl.  enetc_msg_get_link_status(=
)
> answers from the cached pf->link_up under pf->msg_lock, and speed/duplex =
are
> already handed to enetc4_pl_mac_link_up() where they could be cached the
> same way.  Would caching the speed there and replying from the cache work
> instead?

this does not need a fix. Using phylink_ethtool_ksettings_get() here is del=
iberate
rather than an oversight, and the practical impact is negligible.

The speed passed into enetc4_pl_mac_link_up() is not always the actual link=
 speed.
When there is a PCS after the MAC and rate matching is in effect, the speed=
 given
to the callback is the PCS/interface rate, not the external PHY link speed.=
 Only
phylink_ethtool_ksettings_get() reflects the real media/PHY link speed. So =
caching
the callback speed and replying from it could hand the VF the PCS rate inst=
ead of
the actual PHY link speed - exactly what DPDK needs to get right. Querying =
phylink
guarantees the VF sees the same link speed that ethtool reports on the PF.

In real usage a DPDK VF does not poll link speed in a tight loop - it queri=
es it
occasionally (typically around link-change events), not on a hot path. Comb=
ined
with the existing trusted-VF gate, the chance of this rtnl_lock() acquisiti=
on
meaningfully contending with host control-plane operations is negligible.
There is no measurable stall in practice.

Given that the cached value can be semantically wrong for PCS/rate-matching
setups, and the rtnl acquisition is rare and already restricted to trusted =
VFs,
keeping the phylink query is the correct trade-off. No change is needed.

