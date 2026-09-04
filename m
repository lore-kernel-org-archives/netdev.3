Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8847728A;
	Fri,  4 Sep 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518841; cv=fail; b=AacrYWIeSL8RdTWzH4Qc3FRBvZXML/wq2yWqUKvw5li1mAw5lsvBcLnjw2pX4EhtbMcJ7YNHSFp8/lsOeUTrOXX9NuHHRIUJYYyQu0ADzWVpfeAXQegqtHIDDgO2l9TM5sTR8/D64w2owY7d6/bf6vDgYvCwEj5XVqw7oun5khU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518841; c=relaxed/simple;
	bh=3yhPnmByl4N4Gjp+QQK7lXtSvt58iGZB81Ow1LPwsLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DqAG3aEpyQKkgEKMlZc5ibnIttAgD9HknWd0hFwr2RpMI8emrwrnzTsm1cqugtA/zfWGPnKGxP3t2mQfB7DotgNNlAgWyGoLqOUMq8WO0W9vBP376MXGoilBZlwW3SfU9QVPALES4sHaDT4BF+ltl4lrTXwJ+mCKLvVrbQ3yWSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MG0yfOfD; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MG0yfOfD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Rl5ZXlohF5hBnzjM4IK05x3XSB7SCmqtpIKFsvXbaSKQjPUtWX0+mMOUqAjJDL8ZEZ8UO/aDoYHw59LvS1LmxuzDQSGcN2Wowr05pdcv5XQcOl19BafKOkCXicJD3+ToVNs0RpOeQhkxZ+yhXzP6Ega/RgzzBiR4q1dm9OYY5TUv9SA+YhsS7x5oeANBpGdXq8DKGxBcnpBlS2Wu2aERM9DNLz1Jlvnbgfhs428AFOM2s8hZDLQEtnw4Bwo92A6Zy4G30PDdRTQQJTSfdLgrGuHgh1Ajm3upRx94P1SY0sYYxYgQ+R12XMlQJHYKyWWcccborLtf+lfrUS0CQSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C5s9lvCzjUlO1Qt2TXCKUwsd3fbCQdL1LceltyGcvw=;
 b=yXXCrQ4nb56Jfop2xzleO1e8wzwaMatBV9drLKHB8bu9RgG8J1Gze1qw5Pfw0cl/7HOABhkNvTA/8BCYnsFaH98WayFkiKzyyJb9jyduq1oDMBQN5+880MXkFXQW2FbEB7Wjqw5BpgNBY3n3a//MSGqrbrQPlRqlrzlCadOWHSqRRnlYqDs4DWYebHEfbOhWX5JE7I7eD5TU0ZtIzr9givcuzIraFpFUY/iIZJdTSh+A2jrr23rZmMddjBjbcEB76/TRXkthhqRpmPKcQcnFyilTgeutrWiaehqwNBZ5qhcl9jT3l5PsIvb5KYguN9ClH3XnWT09PlTcw3zzM7NgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C5s9lvCzjUlO1Qt2TXCKUwsd3fbCQdL1LceltyGcvw=;
 b=MG0yfOfDzuaZoHNRk83/rZwY9ZREOBBkxClaBBrjciEJLqpewwJmuxlYAIAbDqCkM0CtnFYoDbCZcOUmEy8vmTCKXJyS6demSWEIsDlPxXbzpC1ZMHkI27oIzgzRJn782Co+it9XV3B8VymNDKz2x3COLqqvZjj2Nycwp5uC2/XVachprHhpk/3y6deGGTpi9oxDrJSXn6gcV8XEXp49saW1t3g83VWsKlcPdDqhTZY511EMPmFpxkXItt+AMO46tJKpgOniqjLydmj838Nis89qkqxeIUnf5PtmcFd6hsI9e5ckdPYZ4+ODk+YrDiiAJHYZArsCivmKsKWzzBjzNA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS8PR04MB8820.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:47:13 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 10:47:13 +0000
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
Subject: RE: [PATCH v3 net-next 14/15] net: enetc: add PSI-to-VSI link status
 notification support for VF
Thread-Topic: [PATCH v3 net-next 14/15] net: enetc: add PSI-to-VSI link status
 notification support for VF
Thread-Index: AQHdOPgf8cz1GGeVZEqtLWc4Gbz+ira9imUAgACqZVA=
Date: Fri, 4 Sep 2026 10:47:13 +0000
Message-ID:
 <GV2PR04MB1173938E732772B851C2FF13488B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-15-wei.fang@oss.nxp.com>
 <178847907205.4131868.7015450810217454362@kernel.org>
In-Reply-To: <178847907205.4131868.7015450810217454362@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS8PR04MB8820:EE_
x-ms-office365-filtering-correlation-id: e45c15d2-e122-4ccf-d446-08df0a71e15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|18002099003|22082099003|56012099006|3023799007|38070700021|10067099003|5023799004|4143699003|11063799006;
x-microsoft-antispam-message-info:
 h3qhjvs377WPZj+p4+At5bNbiB8E/80mQfSQE9vVUqOcU7dTx449CRB9nQc103nnXnj7ZwP5z/+C7rkz7tZpP34Csve6ifs51wrFNbZ2F3qgz4mIkPXa9NC4HDs9upH6UgEgxOrAdZYU1oiZg5ZCxeBH0NiKBIwhrbqH2CqSbxWgDXOIccp0PIjRkKGdeUswQpfV8NafUFFe3FpfEzHKSgbkYyCz7Q5Py+ZJWrEXASJI1lWTye1Akbt/fBXvcLV6SR9Gp+Vq8by492vyHICBpp6/PU6ZNS4wdiAHcWfBOk7IrikaUbgv/6sDMpBiidN+aCDawyRNURox94M+rgUA+yuZ/NovsxjSatmrHZGXDUUeUdcVJL3SW40ygN2GqWuPII8TZF5w9rZnT7dJATq9FmCEly3hwUAEHzoyTXRmHClIBr7DK6cHmq57J34mN0GFBhACuaBPHSe251C5Hv1vGqq2AKAYpFX2SRGHVtvMk3CYDEV+rPquyyBjrlRzE3wJuqOysWUFEh+hOzXbws6WUlctqwfV+axwFU0kG11K5TcUE0HVcXCc1PM4hELnLkaSe4qTB1vupeNB+slUMHDW5W4SSPsV4Cdjd+GFCVfkqxkTrc0QvCH6FRx00DS0sr0dlgnF4ClnlkSLWW5x7sMDYz7QpMZNfCc3sz0DdcoB1e4rcnGt5dy0/wHAsL/XscHEVQ3FdPBxze44LFwsesWGkUTk8iN9VWwEAObPWawtbKE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(10067099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ci6xe4pL5TURmleaM07w5Hy/ufhFjPUl81gKUckL5xSpmWNbbYMbgP0362bx?=
 =?us-ascii?Q?dDypSj9szhiLkoRMTHoTs0c8VT0x7kl/18hQKg/kjOKKysWjcrfB2xUoGFm0?=
 =?us-ascii?Q?G4Le0hqc00ZQMMvZBe67eXnW4oXAhs7WyxRx4gY/pPuvXC7aRiGJOMfOPpVr?=
 =?us-ascii?Q?kJGy155Cvf38Qp6k577lp9kRzhiHHv7x/go4TT9HNk+cT+/POPX9vYH0Ok3Z?=
 =?us-ascii?Q?pucqB1g/2U9dJBtma60dtSQpEN57wUts0Fov/nPodztu4+gbotzT+M50tJaI?=
 =?us-ascii?Q?JiruqEOBHhY9FdDM89qQ8xcZHJnVaAdCPKh0Gjjs/qT0DT/icx11n4Oz5Cgf?=
 =?us-ascii?Q?0SzNWkYP29nZqU4654jU7T3U1WElofCoy7neBOo0GMJVAoTbXoj/lZjmOuTI?=
 =?us-ascii?Q?2SwKB0Jn/KYV4H3KuCY1vLEU5BzR1BWvxbqKE+t3wrhnELjg/YznjeUVku2K?=
 =?us-ascii?Q?UbMsYv6+iNM2P8DwheygIUkUS6kLGnD/sQh7oz/1nUUryC3wKW4ZJPuodVeE?=
 =?us-ascii?Q?CBmtdFMcsRXf45Z5Yo47SDqbXKyHrxFHUBgE7m9z3hmUrYyAwmIT9LrKh5YU?=
 =?us-ascii?Q?J1Cp5PUB3X76kLiacpOO14lIs8z2sYK70EiZMwezyjwFrkbbwQUQqHM5Xc8g?=
 =?us-ascii?Q?J471OWkQn1CX2wf4iDvHG3bnXizSeaPqGO/LudnmPoDLxuA8pr5DAIbUEO5p?=
 =?us-ascii?Q?gih6r3ebugGOAqWSPQJrwBNRmS8j+WcqgZA9LRoNjU4lazAUvd5QcYneW2OB?=
 =?us-ascii?Q?AfOpSHbyqYxdR3JFXaI8KETPyYhlWkUx9qeU4ss1wKydQgcUQfOMInkzHm4U?=
 =?us-ascii?Q?iKsQTx3SBU2BdemMezIXg2UBMVDBxwte/AqGJRnaw0ebEzmpLspBg4ZWZOJ3?=
 =?us-ascii?Q?WOHWNsucIPMRcFkRWKIHu4XBniX8a9/HrGFrhwR3XYZ18EhkEvA6ldVa2hiX?=
 =?us-ascii?Q?zhL0oD03X/ToO6QiNdlrtVNOajjhQV1jVUfY5jKTRRpOVkwN7a/dvobWqVf2?=
 =?us-ascii?Q?hERp6VycsxhcFIigwQVkSp7QewgB28Mx1fKQwD5bT8eXkcFLBcxGerTFjSYJ?=
 =?us-ascii?Q?+LQ0GdmFw5mDVeUjK2eHRAOHgBfE87C7f3XsV38bS6YZvQ9JFEF3c8oXn3ZI?=
 =?us-ascii?Q?FRzOFCI6RxWX8YPHN2rw9UFbe36yvv11zAXEvxpaqlCqBUuqNAmVtms5j0Jk?=
 =?us-ascii?Q?GAT88R1uKsy/eFDu1wzeL9JfRceeMoLqqdbbqv26hjSZeB1pAq6GLnd0Qg0M?=
 =?us-ascii?Q?CGlqFNyziRIFrAOVTt3ceby/U0aurpodnQhrguE3pyiHBj/Bt7/Xs3ZIEfCB?=
 =?us-ascii?Q?Dp/T6bsx4mVp1qXVuLi7f/P0ZeVnN0NcZ2362iWcmGQXxHEyOWSFbtGpraMG?=
 =?us-ascii?Q?REFRw1/fWJqyEo4ttPoi4bjqC2lTpvnEt56AqlSUXSTcmPu031WYrKm3Sb6q?=
 =?us-ascii?Q?LV0S1j318bqVjsgZwsRKNaA9ySRXW13M2pc7JGyg3JQCA2hP69CCJ2uNoIDC?=
 =?us-ascii?Q?RSOXD2lVYdR3jc1JumAu0ppp0bn/j2vXSw1CAqqFzn7Nps8zHyXeUqac7iUC?=
 =?us-ascii?Q?I+47yQcCk1EjTTaBVAvuSVdB3Mby3ZXJ8U2ZNz3fVA4x87RLeDu5NicIMF/1?=
 =?us-ascii?Q?c9rVgwVMHoidBCxpppje/d9u4dv508ToGZgF0eB3BZLOUtBJbSbfs5IunqA9?=
 =?us-ascii?Q?K/RCOcyZF28jr1dNwYoDQM9b7IvjNweiyulR/JH172rLPxjR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e45c15d2-e122-4ccf-d446-08df0a71e15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 10:47:13.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUwoArSLpnzY3s4SAjReQ+9Odq1sFDm7eEfclR6RZBV+8VmWfw++j8KKsf1rnME19jLUDVnFLQ/CHJV6iAm+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

> > @@ -2935,11 +2935,31 @@ static void enetc_clear_interrupts(struct
> enetc_ndev_priv *priv)
> >  static int enetc_phylink_connect(struct net_device *ndev)
> >  {
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct enetc_si *si =3D priv->si;
> >  	struct ethtool_keee edata;
> >  	int err;
> >
> >  	if (!priv->phylink) {
> >  		/* phy-less mode */
> > +		if (!si->ops->vf_reg_link_status_notifier)
> > +			goto carrier_on;
> > +
> > +		/* For phy-less VFs on ENETC v4, attempt to register a link
> > +		 * status notifier with the PF via the VSI-to-PSI messaging
> > +		 * channel. If registration succeeds, the PF will immediately
> > +		 * send the current link status and broadcast future link
> > +		 * transitions; carrier state is then managed in
> > +		 * enetc_vf_msg_handle_link_status(). If registration fails,
> > +		 * fall back to the LS1028A behaviour and assert carrier
> > +		 * unconditionally via netif_carrier_on().
> > +		 */
> > +		if (!si->ops->vf_reg_link_status_notifier(si))
> > +			return 0;
>=20
> [Severity: Medium]
>=20
> Here a CMD_SUCCESS reply to
> ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER is
> taken as a promise that the PF registered the VF and will push the curren=
t
> link status, so this path returns without calling netif_carrier_on() and
> without any timeout fallback.
>=20
> Does the PF side keep that promise? enetc_msg_register_link_status_notifi=
er()
> writes the SUCCESS reply first and only then checks sriov_enabled:
>=20
> 	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
>=20
> 	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
> 	 * need to set link_status_ms_mask and notify the link status.
> 	 */
> 	if (!pf->sriov_enabled)
> 		goto msg_unlock;
>=20
> so both pf->link_status_ms_mask |=3D PSIMSGSR_MS(vf_id) and the immediate
> enetc_msg_notify_vf_link_status() are skipped after the VF has already be=
en
> told SUCCESS.
>=20
> That window is entered by enetc_sriov_configure(pdev, 0) (echo 0 >
> sriov_numvfs) and by the pci_enable_sriov() error path, both before the V=
Fs
> are torn down.

The VF is being disabled, no need to notify the link status.

>=20
> Even with sriov_enabled true, the immediate notification can fail inside
> enetc_pf_send_msg() (-EIO when the VF MS bit is still set, or the 200 ms
> timeout) and is only reported with dev_err_ratelimited("PF notifies link
> status failed").
>=20
> In these cases, is the VF left administratively up with carrier off, with=
 no
> traffic, until a manual down/up?

For the -EIO and timeout cases, both can only mean the VF is not consuming
its mailbox messages.

-EIO is returned only when the VF's MS bit is still set, i.e. it has not re=
ad the
previous PSI-to-VSI message, and the 200 ms timeout means it did not read
the new one within that window. Note that at registration time the VF's MS
bit should be clear: the VF's bit is not in link_status_ms_mask before it
registers, so the PF has never sent it an asynchronous notification. A heal=
thy
VF therefore cannot hit -EIO on this path - a set MS bit at that point impl=
ies
either a stale unread message from a previous driver instance or a VF that =
is
stuck.

So in these cases the VF is already malfunctioning. If it does not process
mailbox messages at all, it cannot work correctly regardless of the carrier
state, and I don't think the PF should try to compensate for that. No chang=
e
is needed here.

>=20
> > +
> > +		dev_warn(&ndev->dev,
> > +			 "Link status notifier registration failed\n");
> > +
> > +carrier_on:
> >  		netif_carrier_on(ndev);
> >  		return 0;
> >  	}
>=20
> [ ... ]
> > @@ -3100,6 +3129,17 @@ int enetc_close(struct net_device *ndev)
> >  		phylink_stop(priv->phylink);
> >  		phylink_disconnect_phy(priv->phylink);
> >  	} else {
> > +		if (!si->ops->vf_unreg_link_status_notifier ||
> > +		    !test_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
> > +			      &priv->flags))
> > +			goto carrier_off;
> > +
> > +		if (!si->ops->vf_unreg_link_status_notifier(si))
> > +			goto carrier_off;
> > +
> > +		dev_warn(&ndev->dev,
> > +			 "Link status notifier unregistration failed\n");
> > +carrier_off:
> >  		netif_carrier_off(ndev);
> >  	}
>=20
> [Severity: Medium]
>=20
> Both new unregister call sites, here and in the enetc_open() unwind, are
> gated on ENETC_LINK_STATUS_NOTIFIER_REGISTERED, but that flag is only set
> when the whole mailbox round trip returned 0:
>=20
> enetc_vf_reg_link_status_notifier()
> 	err =3D enetc_msg_link_status_notifier(si, true);
> 	if (!err)
> 		set_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED, &priv->flags);
>=20
> On the PF side, enetc_msg_register_link_status_notifier() replies first a=
nd
> sets pf->link_status_ms_mask |=3D PSIMSGSR_MS(vf_id) afterwards.
>=20
> So if enetc_msg_vsi_send() hits its 200 ms read_poll_timeout (-ETIME) or
> -EIO, the PF is registered while the VF flag stays clear, and this code
> takes the goto carrier_off path so UNREGISTER is never sent. Can the
> PF-side subscription be leaked this way?
>=20
> A failed unregister is likewise only warned about and leaves the flag set=
,
> and enetc_vf_remove() relies solely on unregister_netdev() -> enetc_close=
(),
> so after close or unbind the PF keeps notifying a VF that can no longer
> acknowledge, paying the full 200 ms poll under pf->msg_lock which also
> serialises mailbox service for the other VFs.
>=20
> enetc4_pf_vf_flr_handler() restores promisc state but does not clear the
> reset VF's bit in link_status_ms_mask either. Would a forced unregister i=
n
> enetc_vf_remove(), plus clearing link_status_ms_mask on FLR, be appropria=
te?

The ordering mismatch is real: if enetc_msg_vsi_send() hits -ETIME or -EIO,=
 the
PF may have registered the VF while the VF-side
ENETC_LINK_STATUS_NOTIFIER_REGISTERED flag stays clear, so no UNREGISTER
is sent. But the consequences are much smaller than described.

After enetc_close() the VF still consumes and acknowledges PF messages. The
MR interrupt is enabled in enetc_vf_probe() and only disabled in enetc_vf_r=
emove(),
not on close, and enetc_vf_msg_task() does not check the REGISTERED flag
- it always reads VSIMSGRR, which acknowledges the message and clears the
MS bit. So the PF's enetc_pf_send_msg() gets its acknowledgement promptly
and does not pay the 200 ms poll, and mailbox service for the other VFs is =
not
affected. enetc_vf_msg_handle_link_status() also bails out early when the n=
etdev
is not running, so a stale subscription after close is harmless.

A leftover subscription only matters after enetc_vf_remove(), once the MR
interrupt is disabled and the VF no longer reads its mailbox. That is the s=
ame
situation as the earlier "VF goes away without unregistering" case, and it =
will
be mitigated by the follow-up change that removes the 200 ms synchronous
wait in enetc_pf_send_msg(): with a fire-and-forget notification, a VF that
never reads its message can no longer block the PF, since the pre-send MS
check simply skips it.

As for clearing link_status_ms_mask on FLR, I don't think that is right, fo=
r the
same reason as before: it is PF-side software state tracking which VFs
subscribed, and a VF can legitimately go through an FLR while remaining a
registered subscriber. Clearing it there would stop delivering link updates=
 to
a VF that is still alive and still subscribed.

> > +static void enetc_vf_msg_handle_link_status(struct enetc_si *si, u8 st=
atus)
> > +{
> > +	bool tx_pause =3D !!(status & ENETC_CLASS_CODE_TX_PAUSE_EN);
> > +	bool link_down =3D !!(status & ENETC_CLASS_CODE_LINK_DOWN);
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(si->ndev);
> > +	struct net_device *ndev =3D si->ndev;
> > +
> > +	rtnl_lock();
>=20
> [Severity: Medium]
>=20
> Is rtnl_lock() needed here? netif_carrier_on()/netif_carrier_off() do not
> require it, and enetc_set_congestion_mode() already serialises on
> si->gen_lock.

rtnl_lock() is not redundant here - it protects the netif_running() check.

> > +static void enetc_vf_msg_task(struct work_struct *work)
> > +{
> > +	struct enetc_si *si =3D container_of(work, struct enetc_si, msg_task)=
;
> > +	struct enetc_hw *hw =3D &si->hw;
> > +	u8 class_id, class_code;
> > +	u16 pf_msg;
> > +
> > +	/* W1C to clear the message received interrupt event */
> > +	enetc_wr(hw, ENETC_VSIIDR, VSIIDR_MR);
> > +
> > +	/* Reading VSIMSGRR retrieves the message data and acknowledges to
> > +	 * the PF that the message was received and another message can be
> > +	 * sent.
> > +	 */
> > +	pf_msg =3D FIELD_GET(VSIMSGRR_MC, enetc_rd(hw, ENETC_VSIMSGRR));
>=20
> [Severity: Medium]
>=20
> Only the single 16-bit value VSIMSGRR currently holds is ever consumed, a=
nd
> the VF never sends ENETC_MSG_GET_CURRENT_LINK_STATUS even though the
> protocol defines it and the PF already handles it.
>=20
> On the PF side, enetc_pf_send_msg() drops every VF whose MS bit is still
> set:
>=20
> 	ms_status =3D enetc_rd(hw, ENETC_PSIMSGSR) & 0xffff;
> 	ms_mask &=3D ~ms_status;
> 	if (!ms_mask)
> 		return -EIO;
>=20
> and enetc_msg_notify_vf_link_status() only logs "PF notifies link status
> failed" without storing the pending state or retrying once the MS bit
> clears.
>=20
> If the VF has not read VSIMSGRR within the PF's 200 ms poll, the ack bein=
g
> deferred to this work item with MRIE masked meanwhile, and the link then
> changes again, the second transition is skipped for that VF and never
> resent.
>=20
> Does the VF carrier then stay at the older state, including carrier off
> which blocks all VF transmit, until some later PF transition happens to
> succeed?

This is the same underlying situation as the earlier link-status notificati=
on
question, and I don't think it needs a fix.

To lose a transition, the VF must fail to read VSIMSGRR within the PF's 200
ms poll window. On receiving the MR interrupt the VF only masks MRIE and
queues a work item, so under normal scheduling the acknowledgement
happens far sooner than 200 ms. A VF that cannot complete that within
200 ms is already malfunctioning - for example a stalled or suspended
guest - and I don't think the PF should be expected to compensate for that.

The link change cadence also makes this hard to hit: the PHY state machine
polls link status once per second, so consecutive transitions are normally =
at
least ~1 s apart, which is ample time for a healthy VF to consume the previ=
ous
message and clear its MS bit. In real usage link transitions are infrequent=
 to
begin with.

So no change is needed here.

> >  static int enetc_vf_probe(struct pci_dev *pdev,
> >  			  const struct pci_device_id *ent)
> >  {
> > @@ -520,15 +718,33 @@ static int enetc_vf_probe(struct pci_dev *pdev,
> >  		goto err_alloc_msix;
> >  	}
> >
> > +	err =3D enetc_vf_wq_task_init(si);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Failed to init workqueue\n");
> > +		goto err_wq_init;
> > +	}
> > +
> > +	err =3D enetc_vf_register_msg_msix(si);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Failed to register msg irq\n");
> > +		goto err_register_msg_msix;
> > +	}
> > +
> >  	err =3D register_netdev(ndev);
> >  	if (err)
> >  		goto err_reg_netdev;
> >
> > +	/* Enable message received interrupt */
> > +	enetc_vf_enable_mr_int(si);
> >  	netif_carrier_off(ndev);
>=20
> [Severity: Medium]
>=20
> This netif_carrier_off() runs after register_netdev() has published the
> interface and dropped rtnl, with no lock held, while the new work item
> writes the same carrier bit under rtnl. If the probe thread is preempted
> after register_netdev(), can this happen?
>=20
>   probe                            udev / ifup
>   register_netdev()
>                                    enetc_open()
>                                      enetc_phylink_connect()
>                                        vf_reg_link_status_notifier()
>                                    PF sends current link status
>                                    enetc_vf_msg_task()
>                                      netif_carrier_on()  (rtnl held)
>   netif_carrier_off()   <- reverts it
>=20
> Since the carrier is now driven only by PF transition notifications, with=
 no
> periodic refresh and no VF-side status query, the interface would stay up
> with carrier off until the next physical PF link change.
>=20
> Would moving netif_carrier_off() and enetc_vf_enable_mr_int() before
> register_netdev() avoid this? The netif_running() check in
> enetc_vf_msg_handle_link_status() should make the earlier interrupt enabl=
e
> harmless.

I think this is a theoretical concern rather than a practical one.

enetc_vf_enable_mr_int() and netif_carrier_off() are adjacent
statements in the same execution path, so the interval between
them is just a register write returning. The interrupt handler, on
the other hand, only masks MRIE and calls queue_work() - the
carrier is not touched there. Before netif_carrier_on() can run,
the work item has to be woken and scheduled, read VSIMSGRR,
acquire rtnl_lock and pass the netif_running() check. That chain
is considerably longer than the gap between those two adjacent
statements.

