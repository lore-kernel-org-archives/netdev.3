Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3793C4B79;
	Fri, 11 Sep 2026 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093753; cv=fail; b=cWVIbXQvFiZIoVlOuH322SNiL82aQohoQqQDCH0OMpbJNIOqHrdXpWWqVBMA3vXoC8MRU51Edjjn5IPYj4UpKI1FMjz2B4Lo3+Ubb5xXq/lmZytYpotglsKA/OEdip0pQoMgd5hLOy00Shc95GH3/WhvcDt52WxGk1sbsYHF4VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093753; c=relaxed/simple;
	bh=8BGs2Fbv1MNPtZ9Bag4q1K2bU/8FbGSh71p8DYmCbSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFyRLKXFDtFAeo9mMuKMx6nbrwwk3XElDNSNjk2DPzno51tusE5SnkHzF9e1OzaFVMp2/c9STfeDl71RlpyxvZOHIbLtxuGPsCz4sm9FCAG5NQBsEhXvUW6JmLEcJ+vowLBL6awhns7CxG5WYdIAND5cCQPxPiNMlt6o5aMOU1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n1qreHNG; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1qreHNG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIrXEbvPQ39gdunZ7vIf5I0hYIC05iFkvYpfI44IwmsXOP7kqZbuH4G931P2FBM5gquWeQdLo/6XIUkGxQl+0bfT4HlXHHgi2IEygbdNvJAH/7KFpedfgo73op1Thcjqu0E7rKoT3nB6tNF/8Nfz8N+gJzsVo3LVDXX2ZW0/btT3I8CCmoKo3eS4mRdbvx3vBk2psyZqo0wSSWkZrPe6ojFmq9ndu9GO1dVtsOGa4BeDS+rFQLWSOyGNNL5YdDD6tfYSFwIdV4nj9P4eBfC3zfbBrg7I/BKA88d6YXEu6PoDJ5mjZBmdxvrtE70jv10rSSO606o9uJQES+AIIc0tKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6udfd7DTRfMEj7Ytgc/BNAewHJ7mLlPpeq66DjNgk9U=;
 b=E/LZEAamATrzQQp0HWGTn93QXp0ThxTRHHl4QI1T0XmBTlR3DB5F6JZLsiDrqbZVVk7fvMI8fXRodBP1iIgNZKuuMocV5gQS4+ApXpGVZpZMtZ8fsCkL+wemDlY4ya34Q/LPRVHjd2RpNvlufq/dCcMd/CLZDn2daGcV318dh2n9w/uc0la3cfubcJ2tUOTftl2iVjopUz9o+Toi4bFXC+a+qMTIT33rX35HvPhncf384QmNsEg9X0jyj3tMioUFQrEYem6eQa/igHfuMHglgRanAaFJB+F8VAjcu2ypNPFlM+i32BFiz5HI+mTFqg7VV9jz4GwOLLlpXEf0kI2eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6udfd7DTRfMEj7Ytgc/BNAewHJ7mLlPpeq66DjNgk9U=;
 b=n1qreHNGmK1pDjwigEtZnDTkS+xrt8BirEZTRxZmWD4chIDWp741Ltja7KYcajgG9kFcUd6N8eUFZzXGFVDb1fxhmuxqq6mOeDcPJbrKxNsQQfukb5q7duTAc4PdeGmA8ga/d3ojBshkqIMckn9ZzTw3SPzCBqHatCDgwTHGOVNvOAMKVt3WxPeLDei8pZ3vYvMT3DwtXEwBhB5OK4ovEKfsMVVgNK0A1o6CciCFijrLtsrTjz4bj3CQZH4qqRggnjN1x6AgNnaE4mzeKn/umIaYtqIRLXXxOTQ+Gn6JH93UDXu8nqqttCCpjW2uhZGeCH8m/IWG6rwR2Tq83pQYxw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA4PR04MB9295.eurprd04.prod.outlook.com
 (2603:10a6:102:2a6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 02:29:06 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 02:29:06 +0000
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
Subject: RE: [PATCH v4 net-next 01/15] net: enetc: add trusted VF support
Thread-Topic: [PATCH v4 net-next 01/15] net: enetc: add trusted VF support
Thread-Index: AQHdQEbzOtxqREnqqkSgZxhP+/EdmbbHrFaAgAD4iPA=
Date: Fri, 11 Sep 2026 02:29:06 +0000
Message-ID:
 <GV2PR04MB11739DD052A1E514B40A6E4F888BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-2-wei.fang@oss.nxp.com>
 <178903925585.219967.18067064676940135635@kernel.org>
In-Reply-To: <178903925585.219967.18067064676940135635@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA4PR04MB9295:EE_
x-ms-office365-filtering-correlation-id: 74c3568c-b024-4b56-7e11-08df0fac7431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|19092799006|1800799024|376014|7416014|4143699003|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 BTnMEdFQrOevBt4ZhR3s6+yaC3Kd9m4hMKQCCLXp+DOLExYdLdcSwOuTpegV4aJo8AMByVkmzZ0WFwTrCj5wGVSS84SebebMXMGIjjk+6aaUKywi0a2s8toI7ocej2jRom+HfeWJzMJSiVJSFKKCEhn3CjJrRvp16P/c8o0BstwEKsZaPnPxRyC6w4f72mZRTcwxFL6vC9/l2X4jGLzYWrgw0ZOANhNTKt+t40FSM9DoyXRGaVWnew1JZQvTITs89pRu4uFya4UcMLtbjHMsog2BsJlLNaoDPIDeKdB6wxYqbSPbSTpeNneA/vrjrNa43tR2AAv5SDWoWj8Hg9sv4x+SRtEzDCFedZZHtQx7qrO9vvuxQEk3jovnVB2Qt9jebng7LO2WGKI7nghnh451wtH94mcomC6nC+88KA7iLXZOAc0SmImS3ilhlkqPhhYsO29kTLm2sNcUuLFNE/YUr1N9J7O6n3htb8J3OV5kHVHftZX/2GJgYVPKhs/wBMlh6joYW59VAlHFrWJm8pjoBkZfPoagLLtnLtGiq/FrVxNWHu2e4QJbtF359sV5I/ucMQJqnKs8CGJYRfkxjUY4EOT+etQr/1QD2xbI8sxV+mM+fA3RQM4LerhuuHUKRfTRUYsvEMlQSowqMvGPTWXFrrkCUfcEQL8D9ucuhi2FTztfdF+vkZNiv3Ipxq1t5IoD6ZR9uZSg2XjNK582jgA888i0C02TCvhs3xouxlADeEA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(1800799024)(376014)(7416014)(4143699003)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zTyehUGx1ClRLR0C+VrmBhH2NrcRXOA8CzhhQBKE3LHqwqOAlVEHbqwF/K0o?=
 =?us-ascii?Q?NbX5u6m/0vN53J1++ae5OL+2dotzrDJhTuu0nQ/cdcKDtROnwKLzO02R+ZxC?=
 =?us-ascii?Q?SVoBgOOdKkcsz6xdHIh01V3jciHR95bC4NRuyuvy1RRhARV+I5odU3/fWfkT?=
 =?us-ascii?Q?68ACqp7DHGA90Pfvazg5weoL5ZCalM+di84UdYJaX7ALQvfQUr/Xk0AASzHm?=
 =?us-ascii?Q?C4mM4gcotcH7JkwI0Qu7yTjtvRfGXGI7fxS2ly/bB+29eowHnDPjXE2kDKJ/?=
 =?us-ascii?Q?VtbkrDCmvXGPpZ6EFAmYucyqRMRSpg6BnCAU3zOCBI8q4rmywHWVR6cNML9s?=
 =?us-ascii?Q?z3cN+VpEz4JzA6Gl6YIdM8bPMWxnYUmJVr7NBh5c6ePOQBofFGpGHyJ7w/f0?=
 =?us-ascii?Q?8dKaYZhgrVr7nAgOQqq2nZtMuDRP9qhrQn+sltUjohdapNi/7xVPEtmIxLHb?=
 =?us-ascii?Q?kTHmXbwRCWYuW1OwT3z/0JxIrslER56Vg9Jqj0ID7mp2zeqZiWKhq1SzBVTN?=
 =?us-ascii?Q?dLc4X3LuJVT/Dwp7fMU5hQj5AV+7YePyl0fZFbPDKlsc9WiZAB3GxgH9N5sw?=
 =?us-ascii?Q?6HdARUnz+jAMAUKa15OxQLczMLGOcSzdepHABX4RkKZTqCYsPFM9Top4EG3n?=
 =?us-ascii?Q?H0/RwDHCujFZD+Hp2Oycmyze2gGvSrbp+mlTivzTr4TptweG66Mu7/Ug3gAh?=
 =?us-ascii?Q?pwdVlwv3lkSlNjATr7Dbtd0g687Qk7xjFTBgcXsAa0TlWwYc9mfRZBhYOkQP?=
 =?us-ascii?Q?rkd4bXZU/YsjBnntW8SAq35qYf3yl4LW0JpLYxJQbpGvjajrYhKpY/a90IH5?=
 =?us-ascii?Q?72/5U3+o3sdW6bRo3B+jDbU3YN74Z0F84IIYFKdoGg0SUF0GRiomIBa7PoUw?=
 =?us-ascii?Q?Ip752HClGBi+ODhm0CQbZ5gi6R4Of6OLs7T5/Sj5it1TUBO4vkUB5N3yLl8b?=
 =?us-ascii?Q?9bCUN8e+TpcdzeD0cAC2JarzSyV3ZFRQ1Yv/v48PDExtsvd/aAG6qOjCiDz6?=
 =?us-ascii?Q?g9LOldBXQYgOvtzAZ5q8oJPublOLqZVkstXySOht/fuLjCpdrCemXbzrxSCT?=
 =?us-ascii?Q?kta7B4KOP4g5Cbc/E4Rf03hJMOuLtJTjqYR112FK1FC076lYLvTaClWXPIvr?=
 =?us-ascii?Q?4XcHc3FFvOuHsKc1uB05C2ars80yc/df7kMLVv85N3bwKt+wVqzpu7fzGy6e?=
 =?us-ascii?Q?SvN1izpRJV14LtI34F/p7FtJRqh+7h8ajoxzTa7XoV0NLnc2/2ig7HkNwOmM?=
 =?us-ascii?Q?oZId5eFp2U/ZErkLMqIBoq//tnTmDJi9qog3C8N/UT5vbG2+vgpPRMx6pE78?=
 =?us-ascii?Q?jIddBO3QsOYIZ9mabl5Fe1+phT6Ll9VzIWoEjwmdNvOBGYj0jBrb/YOxxCll?=
 =?us-ascii?Q?CzfwLO/9h7RMa402izWXdEtgzIh+rUfM3qiNRtV+yEDagjatumsBpBfgqxRL?=
 =?us-ascii?Q?/hr+n3e4EHYfuK1wdIkxHnnosIVCdz2jSoMtqHRfhL+vLzbV+siOtl7hs5Pp?=
 =?us-ascii?Q?ogUCLWLLuJis85NdUuZ/qgFjHNTYRFBhSdnr0NQUPABlKwLC7t2oBFrR9GDu?=
 =?us-ascii?Q?Toni8drf4zxpp/5ojZqvn/M+s6iDzXnLxW/1UPsoLqJ0icjV9Cq33AazCB62?=
 =?us-ascii?Q?G3FXENrTFAge0t461qt5ennJ8qM2gsJ1viuWYDIb9Lnl/KVNfY47JYYfJOlJ?=
 =?us-ascii?Q?XeZPKY2G43C3ZPjsqWirPRqshC+qSCnT8ZsgwYngItyakom0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c3568c-b024-4b56-7e11-08df0fac7431
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 02:29:06.7515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL5djw8cdQT6AuGC6tkbE7gVr+TMZjvjFhGknposG5lbXYKeWi+w8V5mXDOqkkJ6e2cukx4y+YRXQ/7RBka9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9295

> > @@ -574,6 +578,7 @@ static const struct net_device_ops enetc4_ndev_ops
> =3D {
> >  	.ndo_eth_ioctl		=3D enetc_ioctl,
> >  	.ndo_hwtstamp_get	=3D enetc_hwtstamp_get,
> >  	.ndo_hwtstamp_set	=3D enetc_hwtstamp_set,
> > +	.ndo_set_vf_trust	=3D enetc_pf_set_vf_trust,
> >  };
>=20
> [Severity: Low]
> At this commit enetc4_pf_driver has no .sriov_configure member and enetc4
> never calls enetc_msg_psi_init(), so VFs cannot be instantiated on ENETC =
v4
> and the mailbox worker is never armed.
>=20
> The only reader of ENETC_VF_FLAG_TRUSTED is
> enetc_msg_set_vf_primary_mac_addr(), reached via enetc_msg_task() which i=
s
> only set up by enetc_sriov_configure().  Does that mean
>=20
>   ip link set <enetc4 pf> vf N trust on
>=20
> returns 0 here with no observable effect, and that the new
> enetc_init_sriov_resources() call allocates rxmsg/vf_state plus total_vfs
> mutexes for slots that cannot exist yet?
>=20
> This is resolved later in the same series: the patch adding VF support fo=
r
> i.MX94 and i.MX95 adds .sriov_configure =3D enetc_sriov_configure to
> enetc4_pf_driver, and enetc_msg.c then gates several ENETC v4 mailbox
> operations on the trust flag.  Noting it only because the knob is adverti=
sed
> one patch before it can do anything.

No need fix, this patch is a preparatory step for ENETC v4 VF to support
MAC filters.

>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > index edc1277bb586..78114ab3e482 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > @@ -61,31 +63,49 @@ static u16
> enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
> >  	struct enetc_vf_state *vf_state =3D &pf->vf_state[vf_id];
> >  	struct enetc_msg_mac_exact_filter *msg =3D vf_msg;
> >  	struct device *dev =3D &pf->si->pdev->dev;
> > +	u16 pf_msg =3D ENETC_PF_MSG_SUCCESS;
> >  	char *addr =3D msg->mac[0].addr;
> >
> > +	mutex_lock(&vf_state->lock);
> > +
> > +	/* Untrusted VFs cannot set their MAC addresses by the mailbox
> > +	 * messages.
> > +	 */
> > +	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
> > +		pf_msg =3D ENETC_PF_MSG_PERM_DENY;
> > +		goto vf_state_unlock;
> > +	}
> > +
>=20
> [Severity: Medium]
> Is this a user-visible behaviour change for existing SR-IOV deployments?

The VF will return error code when it has no privilege.

>=20
> ENETC_VF_FLAG_TRUSTED is zero for every slot, since vf_state is
> devm_kcalloc()'d in enetc_init_sriov_resources() and only
> "ip link set <pf> vf N trust on" sets the bit.  On the VF side
> enetc_msg_vsi_send() maps the new response to an errno:
>=20
>   case ENETC_MSG_CLASS_ID_PERMISSION_DENY:
> 	return -EACCES;
>=20
> So after this patch enetc_vf_set_mac_addr() -> enetc_msg_vsi_send() fails
> with -EACCES, and an in-guest "ip link set <vf> address ..." or enslaving
> the VF into a bond/macvlan stops working after a kernel upgrade with no
> configuration change.
>=20
> The commit message says:
>=20
>     This does not regress VF bring-up. The PF programs a valid
>     primary MAC into every VF slot at probe, and the VF loads it from its
>     own SIPMAR0/1 registers.
>=20
> Bring-up is indeed unaffected, but could the message also state that gues=
ts
> which previously changed their own VF MAC now need the host to mark the s=
lot
> trusted first?
>=20
> Related question on tags: the message describes this as preventing a
> malicious VM from eavesdropping on other SIs and from spoofing MAC
> addresses, and the VF-set-MAC path has existed since commit beb74ac878c8
> ("enetc: Add vf to pf messaging support").  Should this carry a Fixes: ta=
g
> or stable guidance for backporters?

This is a new feature for both ENETC v1 and v4, I do not think we need a
Fixes tag for new feature.

> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > index 55c07c528f22..a7bf4bfc25b7 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > @@ -488,6 +488,7 @@ static const struct net_device_ops enetc_ndev_ops =
=3D
> {
> >  	.ndo_set_rx_mode	=3D enetc_pf_set_rx_mode,
> >  	.ndo_vlan_rx_add_vid	=3D enetc_vlan_rx_add_vid,
> >  	.ndo_vlan_rx_kill_vid	=3D enetc_vlan_rx_del_vid,
> > +	.ndo_set_vf_trust	=3D enetc_pf_set_vf_trust,
> >  	.ndo_set_vf_mac		=3D enetc_pf_set_vf_mac,
> >  	.ndo_set_vf_vlan	=3D enetc_pf_set_vf_vlan,
> >  	.ndo_set_vf_spoofchk	=3D enetc_pf_set_vf_spoofchk,
>=20
> [Severity: Low]
> At this commit neither enetc_ndev_ops nor enetc4_ndev_ops implements
> .ndo_get_vf_config, and rtnl_fill_vf() returns early when
> ndo_get_vf_config is NULL, so IFLA_VF_TRUST is never emitted and
> "ip link show <pf>" prints no VF block.
>=20
> Since the remediation the commit message recommends is
> "ip link set <dev> vf <N> trust off", would it be worth making the trust
> state readable in the same patch that makes it settable?
>=20
> This is closed later in the series by the patch adding ndo_get_vf_config(=
)
> support, which reports ivi->trusted from the same flag.

No need fix, the subsequent patch in this series adds ndo_get_vf_config()
support.

> > +	vf_state =3D &pf->vf_state[vf];
> > +	mutex_lock(&vf_state->lock);
> > +
> > +	if (setting)
> > +		vf_state->flags |=3D ENETC_VF_FLAG_TRUSTED;
> > +	else
> > +		vf_state->flags &=3D ~ENETC_VF_FLAG_TRUSTED;
>=20
> [Severity: High]
> Does clearing trust here leave the hardware MAC filter that the VF
> programmed while it was trusted?
>=20
> While trusted, the guest can put any valid unicast address into the SI
> primary MAC registers, including the PF's or another VF's:

A trusted host means it should not change its MAC address to a PF or other
VF address. If it needs to sniff traffic from other VFs or PFs, it can enab=
le
promiscuous mode. So this is not an expected behavior of a trusted VF.

>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_primary
> _mac_addr() {
> 	...
> 	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
> 	...
> }
>=20
> The trust-off branch above only clears the software bit, so ENETC_PSIPMAR=
0/1
> (ENETC4_PSIPMAR0/1 on v4) for that SI keep the guest-chosen address.
>=20
> The other paths that could restore it do not.  enetc_setup_mac_addresses(=
)
> is the only place a PF-chosen MAC is written into every VF slot, and it r=
uns
> at probe:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:enetc_setup_mac_
> addresses() {
> 	...
> 	for (i =3D 0; i < pf->total_vfs; i++) {
> 		err =3D enetc_setup_mac_address(NULL, pf, i + 1);
> 	...
> }
>=20
> enetc4_pf_vf_flr_handler() re-applies only promiscuous state, so the addr=
ess
> also survives a VF FLR (guest reboot or driver reload), and the SR-IOV
> disable path does not touch it either.
>=20
> So after the documented "ip link set <dev> vf <N> trust off", frames for =
the
> spoofed address still hit that SI's exact-match filter, and a slot later
> reassigned to a different guest inherits the address, because the VF driv=
er
> reads its MAC out of SIPMAR0/1.
>=20
> At the end of the series the trust-off branch grows scrubbing of
> promiscuous mode and of the UC/MC hash filters, but still does not restor=
e
> the SI primary MAC.  Should this branch reprogram the PF-assigned primary
> MAC for the slot as well?

This follows the same intentional model as the trust gate itself.

Once a VF is set to untrusted, it can no longer change its MAC at all - any
subsequent ndo_set_mac_address from the VF is immediately rejected with
PERM_DENY. So the MAC left in the SI primary filter is simply the address t=
he
host authorized while the VF was trusted; it is not something the now-untru=
sted
VF can keep modifying.

The host also retains a definitive way to reclaim or reset that address:
ip link set ... vf N mac <addr> (ndo_set_vf_mac) reprograms PSIPMAR0/1 and
sets ENETC_VF_FLAG_PF_SET_MAC, after which even a trusted VF can no longer
override it. So there is no need to save the probe-time address or to force=
 a VF
reset - the host can deterministically take over the primary MAC through th=
e
existing PF interface.

