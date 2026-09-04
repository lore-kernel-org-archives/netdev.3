Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A441442FC9;
	Fri,  4 Sep 2026 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515592; cv=fail; b=DDoFO7HjM8tYTeiVrJHTudEuFRHcCHv22P2FEgoDiU1kxJnUBNw78LbODMF4zangalv5Ut3je5EuL66KyW9+fYAK9dwHcClZ0sGmR/wQN2HZXgYWuPPeLb6xf0r84r7Y5DFF00s0mR2fFb2KAOZunGbxA31owzsue32sYvCTJQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515592; c=relaxed/simple;
	bh=S3KgD7L5tQlvQI4U25n8EorKDFpNPpoSfI5cuK4taIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QfSh0Ns+VT87sYkt1XZRH0htonhxEu0tfQtx7JLKYr6CX91m+Ii1IDgP86ZkNcX2DU6XkUuHPr3foigkqv4vKE/4jWxYk3mDHmfeT0fv/m9UKWf0o0VI0yPSYK+S65eQfiiZN1opK9MBJ+JaSP2jpKsle5RbTFtiGSNEhIrieF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NAjZ50wS; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NAjZ50wS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et5pQ6huL9Ibn9GaEeyQRn/bzTkNyX/fBglocMGWLFgXIs55J2BHup8gCLHNAn9vPRpT8hvKSKtkSnLnOZVbX86R9M1lMdhfd2TkCcc3iJXvlcdKqnHOJ+/vcaKe3QyS1/SKyCrsh9ydYbmJ2Z7lg25AgmlONsWU3K24x748+fbzk8m/u7eSZnZFjGDwJ+6LI2/VcAS++CXMrNTKhVNi4fizkwYBm+Jj2LAxKdMgl+za3QxcxxoUxo4Vg/Lbes3UlCazYx21DMqzw8gEsAbXRnNG2dsEvIDsRClEBZEWZuZD4INnNI1oeh23Ce7FP+ia7dZnfGFz73z4glkzNe4c7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfZKWLSNg4SRQUTMuWyl/sz8BVL37v4pAMZ8tvVSKqs=;
 b=UbunnO2rBP8xuW1j3FhpWLWB2jTwYo7nFXdgaVc9jSs1WbNg/8ddn2ddoq871UtIqM05FLU8aGXAmuM/ykjeqRqojsuR9UXqbUVk7JF8wm260T6Qu0L9vMWnzkYOt2jNjjORHuejMySF58tvKhx/CDCgMzEwMKbGHztVu4jV2WSUIkdGYuV1yuIEj8i0Zgw5cGC3HEG+Z7mp/zWO9eLjReFkluvHPPSxZfFMgy5TGPp8Tt0C5LML7hbSAn+HHJ6e+WkrxNWYqlDQQmwYUABb8Y0Ks2I/UrVbtK7A35hNmMSNS5Cq82Xj5azTwSAPbupgao1VjRaPgK7kmBGmVpY6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfZKWLSNg4SRQUTMuWyl/sz8BVL37v4pAMZ8tvVSKqs=;
 b=NAjZ50wSyDV9tFo8QHvhrfJPGB7kZO5ghoM51WZvFLnQ9pNn1Iyb6koKkMQZrwWeVmLlbDghYCkv04dQK2GrY6oDwWpFN8WXOin6sAFRoL6PQJifgDaF6v4gc+89eVe3/9SZOfju5xGl83XjvBp2caAX709BlmscPnpxY6v4f926VizRU9kbHZJ54v0tgtcUHXxwGKAIhydLYkIKHAAoWHjHtFr30EMhkpZetSbEVtGxAFbizUWHE7g0++o4msoiKxgVhqpHV8BJYsUNxX7AQ9WmPtRx8tODIhiJeFHiUhiPv6iOCyOkeoShb92ohr9XCf7rW2/5gYnq0DxCWXvtCw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by VE1PR04MB7438.eurprd04.prod.outlook.com
 (2603:10a6:800:1a0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 4 Sep
 2026 09:53:03 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:53:03 +0000
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
Subject: RE: [PATCH v3 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Topic: [PATCH v3 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Index: AQHdOPgc6qfQmSNghESO08UZZGj8Uba9imMAgAClKzA=
Date: Fri, 4 Sep 2026 09:53:03 +0000
Message-ID:
 <GV2PR04MB117395246319A21FB54172A5088B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-14-wei.fang@oss.nxp.com>
 <178847907053.4131868.14448615471105460167@kernel.org>
In-Reply-To: <178847907053.4131868.14448615471105460167@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|VE1PR04MB7438:EE_
x-ms-office365-filtering-correlation-id: 2c5bfc44-3e44-4c95-8490-08df0a6a4ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|19092799006|38070700021|6133799003|10067099003|56012099006|22082099003|11063799006|5023799004|18002099003|4143699003;
x-microsoft-antispam-message-info:
 F2i5jMMFqrT6gD4WAHo1Z2MyKYKXKTImYj6d3LktzxgOyx1FP3uSChwsUi5BT/NErGruJThoUCOWlewBRzgect9s8G6M4eGhXd2hvq41mXT3+yG5z8Vh/QLQTkZggalAMo6274xeNbVyvCLe6eCcE2awRXXgthD9++W4B4PEGIjvi5wFU8+J07cpNaQ0/jLMXVPqJq6JxETflw2JARXd3Ov2IKnR16E8+W68VEljxJ6zCf/s+J96E6pfZ2A7eGEHBAYw25Lmw+FOprm2twXoCCzPhWh0vZJBgIdf3pCdkQvEAF8z5E1EixFVfRafFnELUiOj48O0wJpTXhxpJRX2z1VfKszEy4E+oi5pEVppq6j1FhG6TkC/P2gNn2Qc/X6VhfcMTZ4Oz/2CYnnSFZm9KBsuIyOtTuJq7K/xy/VnCwf32RwRTIObVJVmxn9Tm7CF/M3VZy5GNpj7P/e5D0ksiWZpT/A4mNdn6eQJkclBKDowJj+w29cWbgT5JuGzW0lO+ITulifOHVIkxRcH/kip/05J5V0wZIJebIF5QGOr/XMlgyGAzepu+9fVWjFK5SFw1ZM6C/6TRLicsqsCeCPqTyKA+fN1LzJjBGSuYwUpVwnQulGewK0H2ijPoFoeYwzM/0zXHxswi1IFdCRDwErS2cEI/cKczAU3hrqJEWK3E1fDqQMG1NOxjzR/fbr1HECWcLpoWOyS8rmpypauAtiFRzgw69wCzpHMjsqCITEzhHA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(19092799006)(38070700021)(6133799003)(10067099003)(56012099006)(22082099003)(11063799006)(5023799004)(18002099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iSj9LTkh5m9zJPK3cuAXTg/DdSq5IBtClJj/A/7esT0/NBBi8lEbppAqEhsS?=
 =?us-ascii?Q?iDEuL/jPuSccnmFeqCzhJYfEfoMtp0B22PHQFGEWnMoLl4WQCwYtUwAmIYI4?=
 =?us-ascii?Q?FiPaMfSqIr1rxE+zwij5nzCo41eX23pR4tKPGj84UcCCTrLwcURw/UOmGD1o?=
 =?us-ascii?Q?riY7ziVYxOhzwMVyM7z2tGpd5l1sj1hQO7GDX0RGVxnMjJNk6fw+M7KD1Ie+?=
 =?us-ascii?Q?qThVeauTB3gJyniFcgUZ6TK6so6tpHKjYgPg2ReB2m0NVChaNdYmCK6v0mJx?=
 =?us-ascii?Q?peByQs0unjV/1XbL7pZTCWVF3b/JOiPq185H0xy/hrohgWkAeyQAQJUJYJFN?=
 =?us-ascii?Q?MlV2YAAZKmHVuo8rnQVrtzfUSgRFVU8JTX0e2P3Wi74s2gPQjDzqhJLXhsOI?=
 =?us-ascii?Q?sAteAjIlw/O70pwhS1x2KScNa6ydcIqQISlhpOgWUSE21TgGwNR2OKO3RRA8?=
 =?us-ascii?Q?yzyMvP74z+ixMLJhWEbRymY4Qv2xSs/Clz8GVM1VrXGMv8Xmqsj5Sj2OpNAG?=
 =?us-ascii?Q?qlKXWIHpOhoymkBGDyXIS0Jvlc5kg+9DxLzygzxRbBgFR/PMMkGS5/5NRvRk?=
 =?us-ascii?Q?W4xqOg/7L4SRR40zI6dPa8XyR/xXNjkVSBpmBgyN0c3a5yHH5VkeLAeaOabR?=
 =?us-ascii?Q?jY9k2XhXVovIq5RPVpXHSyIb/7a6JbUDb0S20ub+IxLQjEM6jdOQPuuUjNt0?=
 =?us-ascii?Q?hKy9jIOW+bwi/HjHRK9cl24QwOeaim6uP/klJZ6/oNZEGknoEDh+UgGN0nJW?=
 =?us-ascii?Q?ywXrU8edeDXaJmSsBSq3v2zaXDhbDu+XUC//LtjyNRc2LLhGFXs+PaTls8OZ?=
 =?us-ascii?Q?pLyRjPldkupmYHTtxdwGAC0joJ1W9IPQImKcUi1QWuYyVQ36RXF9+/raGpMR?=
 =?us-ascii?Q?4wA+Ti78I/JmhGg0HeIhAUDVVQm25z3TPnsoIZmOREi9orLz/T2pPzulWPa/?=
 =?us-ascii?Q?1k5xHP6BZ83CCxgmsordIdcdnV4/zCXmlCGcHgBePJAB2QKyduqySrHGro/r?=
 =?us-ascii?Q?LNa7LVTMqpFZeDo4d3Y4qqYSk3Rc4tXrzCqn0gD/82fe2SSnl/+7DuAhysLM?=
 =?us-ascii?Q?rTtmKCvNFHtI+hfjcqjdWqUlq7k5JSy/z5Y84llqGRwIoH+j+8/RJquitJss?=
 =?us-ascii?Q?uWSk6FO3hEFDTQi1CiNTLaW7Dm+YQPs0KaHccTnGVHN5xK4gzDNOUhQ7Ae3X?=
 =?us-ascii?Q?dum5HDJCdb6a+WeY5y6yCFYyCFCZZssiCqEqe98ZGCP34WUsuhZNf58u00Ds?=
 =?us-ascii?Q?ry4EDZc5UxoD6ZHVaDdy2Kelqayk3QRenJ988gN3pu3+Wdny6NfUIcsb4J9h?=
 =?us-ascii?Q?Ps8pzJUUrzrLgJywuMaDizeno9dJlv28IjzlUYYe1SHchgJmOOh3dgeQ1Bzy?=
 =?us-ascii?Q?mBHULeOF495Or0haa1x2E2kf0Zh+FPn4Nkcdz0GpwxSpL9qoOViS1F90JjoU?=
 =?us-ascii?Q?Bh6HlpSnKDn7XB2SC8+XtG2wmDs/rsDO/195mavjYD5ZNHzNQcBH2NuL7lG1?=
 =?us-ascii?Q?uvc2Zy9aTEPp1lPgmeP4ozEhoey/CWfBgsk/JfMZo4xOM601c2YhW2dT4BqY?=
 =?us-ascii?Q?20gQBKWPMi+oln/wU+fHlnDuWR5XVqUEc86pzSSvqo9d0XjV0pr0mluS5Dgk?=
 =?us-ascii?Q?yfZ4N3eMkYj/e05T7hnd/F9cYDFj8porpY/pY8Pw9mvrF0wRjP40ZGEITfxd?=
 =?us-ascii?Q?zgee4CGqd5q6bH1nFZMuwP3eaax+9Kv8gRSJrbkaaY+4mo7N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5bfc44-3e44-4c95-8490-08df0a6a4ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 09:53:03.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9DBs9wL2OqEuAhsw83/PGmBCiAHMgx8EHwixgbv8COv6Z5VBgk9VtYO84Dqk0keOHNpYPPIgBxhLiGZRY+dBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7438

> > +	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_UC) {
> > +		mac_filter =3D &si->mac_filter[UC];
> > +		enetc_reset_mac_addr_filter(mac_filter);
> > +		netdev_hw_addr_list_for_each(ha, uc)
> > +			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
> > +
> > +		bitmap_to_arr32(&msg->hash_tbl[i], mac_filter->mac_hash_table,
> > +				ENETC_MADDR_HASH_TBL_SZ);
> > +		i +=3D 2;
> > +	}
> > +
> > +	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_MC) {
> > +		mac_filter =3D &si->mac_filter[MC];
> > +		enetc_reset_mac_addr_filter(mac_filter);
> > +		netdev_hw_addr_list_for_each(ha, mc)
> > +			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
> > +
> > +		bitmap_to_arr32(&msg->hash_tbl[i], mac_filter->mac_hash_table,
> > +				ENETC_MADDR_HASH_TBL_SZ);
> > +	}
> > +
> > +	enetc_msg_fill_common_hdr(&msg_swbd,
> ENETC_MSG_CLASS_ID_MAC_FILTER,
> > +				  ENETC_MSG_SET_MAC_HASH_TABLE, 0, 0);
> > +
> > +	return enetc_msg_vsi_send(si, &msg_swbd);
> > +}
> > +
> > +static int enetc_vf_set_rx_mode(struct net_device *ndev,
> > +				struct netdev_hw_addr_list *uc,
> > +				struct netdev_hw_addr_list *mc)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct enetc_si *si =3D priv->si;
> > +	int err;
> > +
> > +	/* For ENETC v1, we cannot return -EOPNOTSUPP or any other error,
> > +	 * otherwise ndev->rx_mode_retry_timer will try to set rx_mode
> > +	 * multiple times, which is pointless.
> > +	 */
> > +	if (is_enetc_rev1(si))
> > +		return 0;
> > +
> > +	if (ndev->flags & IFF_PROMISC) {
> > +		err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> > +					       true);
> > +	} else if (ndev->flags & IFF_ALLMULTI) {
> > +		err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_UC,
> > +					       false);
> > +		if (err)
> > +			goto out;
> > +
> > +		err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_MC,
> > +					       true);
> > +	} else {
> > +		err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> > +					       false);
> > +	}
> > +
> > +	if (err)
> > +		goto out;
> > +
> > +	err =3D enetc_vf_set_mac_hash_filter(si, uc, mc);
> > +
>=20
> [Severity: Medium]
> Is the order of these two mailbox transactions the right way round?
>=20
> enetc_vf_set_mac_promisc() sends FLUSH_MACS together with en, and the PF
> handler zeroes both hash filter registers when FLUSH_MACS is set:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_mac_pr
> omisc_mode() {
> 	...
> 	if ((type & ENETC_MAC_FILTER_TYPE_UC) && flush_macs)
> 		enetc_set_si_uc_hash_filter(si, si_id, 0);
>=20
> 	if ((type & ENETC_MAC_FILTER_TYPE_MC) && flush_macs)
> 		enetc_set_si_mc_hash_filter(si, si_id, 0);
> 	...
> }
>=20
> So while promiscuous mode is active the SI hash filters are known to be
> empty (enetc_vf_set_mac_hash_filter() also returns early for IFF_PROMISC)=
.
> On the way out of promiscuous mode this function completes the
> promisc-disable round trip first and only then installs the replacement
> hash filters.
>=20
> Each enetc_msg_vsi_send() is a blocking round trip polled with
> read_poll_timeout(..., 1000, 200000, ...). Between the two sends the SI h=
as
> promiscuity cleared and empty hash filters - can that drop all multicast
> and secondary unicast frames for the duration, two round trips in the
> IFF_ALLMULTI branch?
>=20
> And if the hash filter send then fails (-EIO "VSI mailbox is busy", -ETIM=
E
> on mailbox timeout, -EBUSY for a busy PSI), the promisc-off write is
> already committed and is not undone; netif_rx_mode_schedule_retry() gives
> up after NETIF_RX_MODE_RETRY_MAX attempts:
>=20
> net/core/dev_addr_lists.c:netif_rx_mode_schedule_retry() {
> 	if (dev->rx_mode_retry_count >=3D NETIF_RX_MODE_RETRY_MAX) {
> 		netdev_err(dev, "rx_mode retry limit reached, giving up\n");
> 		return;
> 	}
> 	...
> }
>=20
> Would programming the new (superset) filters before narrowing the
> promiscuous bits avoid both the window and the stuck state? The PF side
> already does something similar in enetc4_pf_set_uc_exact_filter() with it=
s
> temporary unicast hash filter.
>=20

I don't think this needs to be changed.

First, the window is acceptable. It lasts one mailbox round trip. rx_mode
changes are infrequent management events, so a brief loss during a
reconfiguration is tolerable.

Second, the retry mechanism exists precisely to cover a failed configuratio=
n.
The only errors the hash filter send can return here are -EIO (mailbox busy=
),
-ETIME (mailbox timeout) and -EBUSY (PSI busy) - all of which mean the PF
is not servicing mailbox messages. The core retries with backoff over rough=
ly
15 seconds before giving up. If the PF cannot process a single message in t=
hat
time, the PF side is already broken, and reordering the two sends would not
rescue the configuration either - it would just fail at a different point.

> > +out:
> > +	/* If the error code is -EOPNOTSUPP or -EACCES or -EPERM, return 0
> > +	 * directly to avoid meaningless retries.
> > +	 */
> > +	if (err =3D=3D -EOPNOTSUPP || err =3D=3D -EACCES || err =3D=3D -EPERM=
)
> > +		return 0;
> > +
> > +	return err;
> > +}
> > +
>=20
> [Severity: High]
> For an untrusted VF - the default, since pf->vf_state is allocated with
> devm_kcalloc() and ENETC_VF_FLAG_TRUSTED is only set by
> enetc_pf_set_vf_trust() - the PF handlers reject exactly the messages thi=
s
> callback sends.
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_mac_pr
> omisc_mode() {
> 	...
> 	promisc =3D !!(msg->config & ENETC_MSG_MAC_PROMISC_MODE);
> 	if (promisc && !(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
> 		pf_msg =3D ENETC_PF_MSG_PERM_DENY;
> 		goto vf_state_unlock;
> 	}
> 	...
> }
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_mac_ha
> sh_filter() {
> 	...
> 	case ENETC_MAC_FILTER_TYPE_UC:
> 		if (!trusted) {
> 			pf_msg =3D ENETC_PF_MSG_PERM_DENY;
> 			goto vf_state_unlock;
> 		}
> 	...
> 	case ENETC_MAC_FILTER_TYPE_ALL:
> 		...
> 		if (!trusted &&
> 		    (hweight64(mc_hash) <=3D ENETC_VF_MC_HASH_BITS_MAX)) {
> 			enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
> 			pf_msg =3D
> ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_UCF_DENY);
> 			goto vf_state_unlock;
> 		}
>=20
> 		if (!trusted) {
> 			pf_msg =3D ENETC_PF_MSG_PERM_DENY;
> 			goto vf_state_unlock;
> 		}
> 	...
> }
>=20
> enetc_msg_vsi_send() maps PERMISSION_DENY and UCF_DENY to -EACCES and
> returns before the dev_err(), so there is not even a log line.
>=20
> In the IFF_ALLMULTI branch, does the MC promisc-enable message therefore
> always fail on an untrusted VF, making "if (err) goto out;" skip
> enetc_vf_set_mac_hash_filter() completely?
>=20
> Even when it is reached, enetc_vf_set_mac_hash_filter() selects
> mac_filter_type =3D ENETC_MAC_FILTER_TYPE_UC under IFF_ALLMULTI, so the
> mc
> snapshot handed in by the core is never converted into an MC hash table.
> With MC promiscuous mode denied as well, does the multicast hash filter
> stay frozen at its previous contents - so groups joined after the VF is
> enslaved to a bridge or gets a macvlan on top (both call
> dev_set_allmulti()), such as IPv6 solicited-node addresses or mDNS, are
> silently dropped by hardware?
>=20
> In the default branch the TYPE_ALL message is refused outright once more
> than ENETC_VF_MC_HASH_BITS_MAX (8) multicast hash bits are set, so
> PSIMMHFR0/1 keeps its stale value. Would it be worth falling back to the
> MC-only message, which the PF does accept from an untrusted VF?
>=20
> The out: block then turns -EACCES, -EPERM and -EOPNOTSUPP into 0, and the
> core treats that as "installed":
>=20
> net/core/dev_addr_lists.c:netif_rx_mode_run() {
> 	...
> 		if (err)
> 			netif_rx_mode_schedule_retry(dev);
> 		else
> 			dev->rx_mode_retry_count =3D 0;
> 	...
> }
>=20
> Can this leave the SI hash filters permanently out of sync with the addre=
ss
> list the stack believes is programmed, with no retry and no message? Sinc=
e
> this patch also sets IFF_UNICAST_FLT, the core's unicast promiscuous
> fallback is suppressed too.
>=20
> Two related points: the promisc-disable message carries FLUSH_MACS =3D en=
 =3D
> false, so a denied hash filter update can also leave hardware more
> permissive than requested (removed multicast groups keep being received).
> And when trust is granted later, enetc_pf_set_vf_trust() only flips the
> PF-side flag - nothing replays or re-requests the receive mode
> configuration that the VF already reported as successfully installed, so
> does a configuration denied while untrusted stay unapplied indefinitely?

I think the current handling is fine for an untrusted VF.

First, an untrusted VF not getting allmulti is the security policy working =
as
intended. IFF_ALLMULTI means "receive all multicast", which is exactly
what we do not want to grant to an untrusted VF. If a VF genuinely needs
this (for example to be enslaved to a bridge or to carry a macvlan), the
administrator should mark it trusted with ip link set <pf> vf N trust on.

Second, returning 0 for a denied request is a limitation of the
ndo_set_rx_mode_async() interface. The interface only defines two
outcomes: return 0 for success, or a negative errno to request a retry
via the core backoff. There is no way to express "this was permanently
denied by policy, do not retry". A permission denial is a stable failure,
so returning an error would just make the core retry four times with
backoff and then log "rx_mode retry limit reached, giving up", which
is misleading and pointless. Returning 0 is the better of the two options
the interface offers.

