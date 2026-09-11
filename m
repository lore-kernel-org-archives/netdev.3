Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958B343896;
	Fri, 11 Sep 2026 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095372; cv=fail; b=AjB4h/fjEuMPxDyoUEVdzbRasvQC3BCKhq8OjVS4j5Kumrn82IuHMmP/lfbOPI9UNHEQJ2wRN691cTsGST+Me+82SOy7tk/KaomGJ7zxpNpju9Y9z872lQ/ixn2bIXea6KEqw/E27Jz0aWxsLUF18phF8Jefn7e5UH+/B92ZEcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095372; c=relaxed/simple;
	bh=GEdNk0WxBe5urR+/pTyEeODlsnuGGlrdeImxxRPjPJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/STMDdSfYzavojPT6tFjxAezhB+YbEHHGDBoDFn5bF17LQcJ7WUI7MDNdFMv17odFTHkezpcnJJCjKT/h+1BjOuXAtfnkmfcTLFKB9fEe99rdacpvUsCVdVVgktyBKSpVd5u5SQq7Gziy3nnKKw68rio3tbgJgIQEFBvphqtlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z7elUtqM; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z7elUtqM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTKPkGHdcAFin61ucrEnpyTWt+SOzbE/RdJtTxZBbM1ik1weMBgZKqzCW2EQuphDVPaR6blaxmHI9l6s03GEV8i8jZ+h8ld+JH2hXyHwBiXL3oih3dJ3VbllfStGg/rQM6fiQ2J1psfKGvYU7YhEbwmG5MFfINZwWWomyRYDCLkPu0c6AvaNWTfifdpY5PRcgGzacbd0hIxK24lyHA79sMtCdpmE+mfdABm4b/O79uXOfTc6epsnIHieMRAtg2hBpLXV2C7XH6UPICwMwyUlV+LznyfMxDRRsstYvs8MLxBqlUmc1QARfRaqAKDKYcQrmYbrPGZnCzQnM8DxN/2SZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuCVuUeECdXvCvPnwYdrmUmjjZ0lGEvpZHECeYrNtRo=;
 b=Sxqp60ofbQMJ0yQcndI8+IqX3doPvCYhFqZS+PRiaKHhgmN+EYyiDcSMi4rVP6hWNDSfVF7VrkK7PV6Vrf0OZNGKvTNGuqhypwdufc3fdmYnGkA4bMTikOnqObg5G8tnD2rM7/QKLUAs0FhhUirax/0HasitI1NbdnfupTFtK3E9oE1uXWJoaTs2uyFUw9d5RJ/UAu+S5yVJ7vte+VBKS3hk/VL/APD6qAPEIQ0ANDfUFhZl7NvzFDa8igg7wST/2jiWMoWWEM5C29b8b9Ew3/F75fHHs0wIblM+M52GOpJWg7PE4HLC5wMdDotwlEQoOfJ1M+maeikzEXxxBflklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuCVuUeECdXvCvPnwYdrmUmjjZ0lGEvpZHECeYrNtRo=;
 b=Z7elUtqMvTrosyi4yH4ShL0BxTpfE1gFmnNIHdeUUQvKTBItCLIg2SoYDdDx/ww6rzLqOGqa1SwoY+J79Quyh2Er+V9TytubyCEXT7D6/BA+oxAWEluox//C/qVAFDQxTmqj2vmcn2oJkz2YvXA8X/8231NNLojZ+uu9mONLM55IjIHeWvObMIgeJWG6muTgdqYmGaR8c6tC5ZrwWIqWM0UKynw7xeR9WJHszVxRtliFNcaaEeRbtu9uaUBVQY5UbHBOVtVVlftssUc25NtpavFmVeM2tSsS4eVrLQrd3G6KY2NWNeQxEBvbb+CK1ikvxgpToPv6lXJDA32KmCGZLA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 02:56:06 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 02:56:06 +0000
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
Subject: RE: [PATCH v4 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Topic: [PATCH v4 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Index: AQHdQEb946ps4yxDZEeS4fSH9eLQa7bHrFkAgAD+OhA=
Date: Fri, 11 Sep 2026 02:56:06 +0000
Message-ID:
 <GV2PR04MB117399FA3E480878C17BF35A188BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-5-wei.fang@oss.nxp.com>
 <178903925887.219967.16074856500035860561@kernel.org>
In-Reply-To: <178903925887.219967.16074856500035860561@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA3PR04MB11153:EE_
x-ms-office365-filtering-correlation-id: da32cc0d-7a7f-479c-5d6d-08df0fb039af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|376014|7416014|38070700021|5023799004|6133799003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 7nLt4eB4lQBKXBUA9p+NQU0wydA3Of44tDkBcAMntoBcx3RcY8T4+RyzXhs99piAiS67S+JgifIEUUUOZDZSKuNMOAHQPhp2dG2UGEMXg6HZJdIyQt+2lDDh0jKUu4jt7dfcis9gOXnQcWSpfRMhTtor+5sbmRhLcybtXxE9x80DW1E9sRLpX1pXqh65OBXEcZQn5k5rk5a9MPWGfhb9PPfJHuE4YpKeaQ+XQaaak9tUJBltqHi0nSN88qc5P5EKCj6zk1nUxVvt4vPnmItz4u78iDkkn6o7azkvri3EAUHeaMy4HYaUI3LRlruER4oAVkYHxjxeZp6Zjj+ePSWUJaI1UtPRgSH26a+C0+vCdD50Wisdtj13BuFglmCckgqQaVTraTvni0gbwV+fqnopVVC0jwYuOr8xE+iHbtD9l9mWGe3JC0py+DJrDH121+SX5BwWnsttHmOkobX77LYhHw/0ML5sSqxXW3Vxwsma5ZEFHRS2bUid78W6fexiymLbwXTYbhXJqJS4HcyegPmSFXSZt8HE4l+Pvh6MyQjh9KHNUbM29IoMYA7+6sJNqAXxb+yUrhPMAGdw+7oj/euvyilc/7Y+F/UU4S9qfy7+7IbpizIwjoM4LeY6XH3p6LR5tDduJaWcOKE3uDoDA+a6xHIr+GpbkycLYg7mHn3Ddj5RLjyhbsIQHrp111wGPW2BL4UgRO2pxrnuXoCSuBV2LjV15IRpf6/7cj8Zgq1VkKY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(7416014)(38070700021)(5023799004)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cvjLsZbwmp3ExeboPdb0D5bUFGRNr4+2YpWMZ1QXK/LQ5Bhuidfqdpi0O+lf?=
 =?us-ascii?Q?RVU8QpHNehu2fHrfc+fOR2geD2yHbM6CRqBlXu9KDsPF5lH67fn4eJ7G4N0z?=
 =?us-ascii?Q?MaSh0ZsJu8Y5Yw3FQDK4WfNXBiVuqQFIrU8okCUMLmRsadhbJpSg5H2jGANX?=
 =?us-ascii?Q?ujg36G9AzM39QIgBLfCLvwIoZlOllwOfyFrmGWGuTyiRFykI0AnxLVDQ4tc5?=
 =?us-ascii?Q?qvwlOlZv8tvsnXscZShsuswg6Yo0IvxKQCtNqQ/SkBzTQSCKPe6XVecisX1v?=
 =?us-ascii?Q?RXucIwEVUQra8Acaj7nWjNsyRMbpWEW0d7kgVmNGbg1MAao1ywm+7Mro/OTa?=
 =?us-ascii?Q?qq7tUQVKOCsFTJwtNA8jVuQ5szHfxJK29NRQh4lYxyihHv20eY7z/9HozzV4?=
 =?us-ascii?Q?6qAIMGCpTTCi3OxdloqPCvH2hqVbO1n52MluD9hUu4j1FUy9oqYD7kIKLwgB?=
 =?us-ascii?Q?4B5pdAi4i32Lm2a6kOR2/cX3+wqYQBYUcmBp71/cV9HfD3t/PvgMhofcPxav?=
 =?us-ascii?Q?DZ/V13rOyDY4tkL+VZlX13ifwwfg2XUUWsgOs1UISGzpEY42uYAv445YGmmP?=
 =?us-ascii?Q?4hHQeneXRBhqLPcmNM34sCgm6XqTShUUTVww3ipFRqNIrYzqJVmYF8Js69Oz?=
 =?us-ascii?Q?ey0XeshsZ4ShiSzy+zOar5Qm9f9EeXaUxXUQOCGSO+2Jp7eRLjVrqXtp9Hko?=
 =?us-ascii?Q?ANrPrZhilIMd7dJwjTLr0cui6wUPhweuyzfZIaPltgKm+Gb6olHPt6ZMQp8A?=
 =?us-ascii?Q?cxKyD7Yhpag75xSpX7ynBhXIlhN9Nug2VBMaAtqzS+E7f+82eYOiFYGFWBN+?=
 =?us-ascii?Q?ZNAf3QRNk6BwVzjGGqcj/IKiGhnrW8FAQFqA+8AL6cDHQkEmFs46lARSRiOU?=
 =?us-ascii?Q?L7aoh5n3zoeBfgT5HIHVoEGeQizRhPZ957vojz47Ue2/SNXOHz92DPBdv90A?=
 =?us-ascii?Q?oFfJLk34RMXPKqn4m9ad3wvb0ba4j2i2xWKTVUoI+HYGd3QXH9uzwRD8nGED?=
 =?us-ascii?Q?RS5cGcCWZNowA1WlbH5Jqkso2v+1xsr44iCPMIJ6fznJJcTEaLUuXFAeD+cr?=
 =?us-ascii?Q?ea4TpS0eswu/347Ucq0bHdpSNzc2bfxdj3LIBVbY06CiFc6WT5x6hGbfY/dy?=
 =?us-ascii?Q?CvGE8b8s5FMcsP7c64TL/ZM8R8ZzoDFX+ZEvIPzM0hfnih3mvThkB+bUu87x?=
 =?us-ascii?Q?KnefbBJNqdxKSDPmXdgsFMq0vk9IPfsXU3g9NLtet5h0tlF0ngafXzaT6Dle?=
 =?us-ascii?Q?icLSFKek/gjt8cvWLgOf9JAyldIxc3qy12ZPE1Uj0fDKZM1mrZ0ZY5tgnPLT?=
 =?us-ascii?Q?wXIO8NiVybmvhdGMfLGvoYm/qveu2K6zbq6AusrRWGlXCNAxOxISdFu6raDu?=
 =?us-ascii?Q?4WjSETJnbBbWnG95yfPM2f26wByoveZ04ze+JhK3drhMxTqbF0PpaXMoNNKs?=
 =?us-ascii?Q?srmoTicVrBZ7CTyGp4+aOLPimM8jEMZxrp+F8GXEPQzKWYecxS9wdgYOG1C2?=
 =?us-ascii?Q?4Avc+4v6FCQF8SGOU391LMi/F4YV8rc8pyFScvVeCoU8VlXTyUZZu+/29Ri8?=
 =?us-ascii?Q?zmt7uTTkzm/kxBSD0pLetfTGcxgljLSADvdZDoLp2QSvnczQe+IwBiKtzjmX?=
 =?us-ascii?Q?CBsgSfvDIWsAAv5LDcAnE58Xq5pA7kCR37PAm8uADsomBef/1aKh0rJh0e4a?=
 =?us-ascii?Q?mPQZ0/7g7TYNrw2xMWdOVn1DsqymHugaCs/zz3VZILB48fVM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da32cc0d-7a7f-479c-5d6d-08df0fb039af
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 02:56:06.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CdSClSboGzVbphEOtsnf1JS47VnclrC5kmn8jWovmWFF1CIwkOhSKi6qlhRESnX0x/LQ0FNjBsuZROyf+Yljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11153

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
> > +
> > +	rtnl_lock();
> > +	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
> > +	rtnl_unlock();
>=20
> [Severity: Medium]
> Is it safe to block on rtnl_lock() inside the PSI mailbox service work
> item?  This looks like the first sleeping, host-global lock acquisition o=
n
> that path: enetc_msg_handle_link_status() only uses si->gen_lock and neve=
r
> sleeps.
>=20
> The completion code is only written back to the VF after the class handle=
r
> returns, in enetc_msg_task():
>=20
> 	for (i =3D 0; i < pf->num_vfs; i++) {
> 		...
> 		enetc_msg_handle_rxmsg(pf, i, &msg_code);
> 		...
> 		enetc_pf_reply_msg(hw, i, msg_code);
> 	}
>=20
> out:
> 	enetc_msg_enable_mr_int(pf);
>=20
> while the VF side waits with a fixed 200 ms bound in enetc_msg_vsi_send()=
:
>=20
> 	err =3D read_poll_timeout(enetc_rd, vsimsgsr,
> 				!(vsimsgsr & ENETC_VSIMSGSR_MB),
> 				1000, 200000, false, &si->hw, ENETC_VSIMSGSR);
> 	if (err) {
> 		dev_err(dev, "VSI mailbox timeout\n");
>=20
> 		return err;
> 	}
>=20
> If any unrelated host rtnl holder (for example 'ip link del' going throug=
h
> synchronize_net(), an ndo_open of another device, bonding/team
> reconfiguration or a module load) keeps rtnl for longer than ~200 ms, doe=
s
> the reply not arrive after the VF has already given up?  In that case the
> VF logs "VSI mailbox timeout" and returns -ETIMEDOUT, and because
> VSIMSGSR[MB] stays set until the PF finally replies, subsequent VF sends
> hit the earlier check and fail with -EIO ("VSI mailbox is busy").

In this particular case, it is expected that VF will obtain an error code, =
and I
don't think there is anything wrong with that. Furthermore, aside from the
IP revision being obtained during VF probes, which is not under RTNL lock
protection, all other mailbox messages are within the RTNL lock context, so
the situation you mentioned doesn't exist.

>=20
> There is a second effect from the same wait.  enetc_msg_task() services a=
ll
> VFs serially in one loop and only re-arms the PSIIER MR interrupt sources=
 at
> enetc_msg_enable_mr_int(pf) on exit, so while one VF's speed query sleeps=
 on
> rtnl, do the pending messages of the other VFs (set primary MAC, MAC hash
> filter, promisc mode) not get delayed and potentially time out too?

The VF side should handle these errors.

>=20
> Would a non-blocking source for the speed work here, or alternatively the
> deferred-reply mechanism (ENETC_MSG_CLASS_ID_CMD_DEFERRED) so the
> mailbox
> handshake is not held open across rtnl?

The commit message has explained why rntl_lock is used:
The speed is read via phylink_ethtool_ksettings_get() rather than the
speed passed to the mac_link_up() callback. When the MAC has a PCS
layer, mac_link_up() reports the PCS link speed, which may differ from
the external PHY link speed; phylink_ethtool_ksettings_get() returns the
actual external link speed.

>=20
> [Severity: Medium]
> On the trust gate itself: the comment above the mutex_lock(&vf_state->loc=
k)
> check describes the tight-loop spam scenario, but the check only narrows
> which VFs can reach rtnl_lock(), it does not bound the rate.  Nothing
> throttles inbound class 0x81 messages - the MR interrupt sources are simp=
ly
> re-armed at the end of enetc_msg_task(), and the only per-VF counter
> (msg_fail_cnt) tracks PF-to-VF send failures rather than inbound queries.
>=20
> Can a trusted VF still drive repeated rtnl acquire/release from the PF wo=
rk
> item at mailbox round-trip rate, i.e. is the primitive the comment warns
> about still reachable from guest-controlled code once an admin sets 'trus=
t
> on'?

The link speed query is a infrequent message. Normally, query speed is only
activated when the link status changes. A trusted VF means it will not perf=
orm
the abnormal behaviors; otherwise, the "trust" would be meaningless.

