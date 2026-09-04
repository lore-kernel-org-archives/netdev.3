Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69763B2FE9;
	Fri,  4 Sep 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512738; cv=fail; b=WhKa+KPUT9g7iyVmTG9Tkvk8D3fC2pAAx161AgZaaH7Be0h35KmcGyulUhQ01/WjYkc4lGY3Tb5/lyHbc6yL4TR56GWzm9yd0T0PBdbc5PAjf2lHIGBVE2fhdsPwkMl6xM1vyUUUs2oYPxsAHH8tHbxjSqDn3YpzkkkLu5er/xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512738; c=relaxed/simple;
	bh=8qm0MxBdPuQPOh2MvA2wruwRFPaHUqSaY6WObNrf/Aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3Oplnf1YwhoTE8wmJ8b6FSAvxPiJgOwcT5FvfKHWkTTyKECwrG0H30EcXXa3sWbXqsUWRGsE0BtYCKvvKoIfXSJMwon+a5oNniZTUXwgMFqJuB8a7s3L7DHzKd0SG+v1m5sacOj+NdQ1pb3kwj37teHztW5DZbXxcWWdZVOgMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OtziiHYV; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OtziiHYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOeGFGjfwYC+RJ1d7lBc4HiMlYNgCPxfPSAdS1Kv+j+0zPAZ+U4HWmDIBhTQ36xZP1z2o9bjJRFbp1hCNnjSC189eOQqqPHdIclTmOvg3bk+Tlkr2ex5SnMcRg3dPBXXsrh5t1hVsGO50xbAsDsS8DYNyUTYUiInpG1PqlGkMUnTGl5eQpZD1vOQj9P3EYzlLoBrgOn31PmjJ93ofMaNGNrDqm5VpfpwzLS+6K5R+ufynfvUSwc/UnR0XqUL/8dzHk/pjT7/zNNjxobPgxCwdqRKtAG63liryUPVxwDaS3fefqVmki+AaHOkwFy+8J3zMVlR6J4BQ+6sjX2rjyL0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlQRyq1/vk3a8nhs5ZnTI3DtL5XYSpDY1r+uznbHz/U=;
 b=W+k9aePzxGcHzM3PL8BF8oCH39Yeg2TFQ62uq/9btciKqlKBh91VdYXhrkFL8qd9EnMdO+LGL1t9jtxnm7Q3QviElrJQRskTV1YFw90rHckPNC7WrBBHtINN0V27Xl445rpxtUoui5iUN4+R6fO588pSaaqL2tLqM/c8MG/TuGfXXwcPIKDpUdUisOgrUeCN1QsTtlCEHk4oa+petQwUA8cDMlTHBAls1BseOth0pZKFEk06ScRYcL8ViJBlKolBLtz/H8Oyf0y1d31LOOYVhyyHSpOTqWTwKIiY/gOaWIvGk02T2pVRXBNzWwSzWU4qGKV6k294FjZNQ2ZVSQl+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlQRyq1/vk3a8nhs5ZnTI3DtL5XYSpDY1r+uznbHz/U=;
 b=OtziiHYVSslQT2SOLiVXGd1hi/ubgHzDwatuarkTCMeQgVmbmzW55SbB0Ohp61/c9kYALyIdkhoFc7mK1wg6kUAZ1h5rh4R+z5B6P+kE33KHNfQeTV+mDwzjcjnlUfHBrLc7liXmltwoEBV/AfasiCTBj6g0X03oWpsUp/JyfZPAYhOEU6Wsy99FNmcM5aKXicVeLM1+AqIcT7l/9UQ0zPuwKfptaqneod3W6E8UeWkj1EQyhf1M/RZi4npeyzu26kaeeACIYCZ7WmVCXRkrp+oTRsmA9xLm/fEx2TyOxjmVp6PafpAw4ZZi/L7BQQuhQJrKrl603SM3mvQrDkz7zA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AMDPR04MB11583.eurprd04.prod.outlook.com
 (2603:10a6:20b:718::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:05:33 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:05:33 +0000
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
Subject: RE: [PATCH v3 net-next 12/15] net: enetc: add VF support for i.MX94
 and i.MX95
Thread-Topic: [PATCH v3 net-next 12/15] net: enetc: add VF support for i.MX94
 and i.MX95
Thread-Index: AQHdOPgYKcRkg1V3zkmASHckn+ikpra9imKAgACZrQA=
Date: Fri, 4 Sep 2026 09:05:33 +0000
Message-ID:
 <GV2PR04MB11739AB419B820470F30E0E7A88B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-13-wei.fang@oss.nxp.com>
 <178847906907.4131868.16287350987605757758@kernel.org>
In-Reply-To: <178847906907.4131868.16287350987605757758@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AMDPR04MB11583:EE_
x-ms-office365-filtering-correlation-id: 460120df-8f69-4345-1bb6-08df0a63ad23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|19092799006|4143699003|6133799003|18002099003|22082099003|56012099006|38070700021|11063799006|10067099003;
x-microsoft-antispam-message-info:
 X+T+3GM1OQmiZArkQNYsTEfv75Ocbmu0gXDtQP+//G/3zHgUlQkFxV74T4kzljv/jBPSgekf1ZneSVHXHt+9Sq2pV63bwg/a2awm41/ICAIRkzXhN1b0bLU6Meyo9ctau2pEBSitB+p8E6Q1YkUfDj3ePoiNf5PwxHPI0EhlzClvXAEXjQ5axYPZSLwmiE22lMcQJa6cgKIeghhRE8jP6GB8zQyKysfkXYdvU6EtLJoJpjswtoZ5JaObKf0LOr6BeyOQOQaocAQoDTJCYu0MHdcJRkZGoixLBD1Tonqy2IwkBxay+5H3cccV8gRNod9ocVSE6PUXuTfH4gWcvZD/5tm1ZVV6x13C0LgGE4maCQCem958p/fzsBryfESe6y2BHrEbHL1zT1opiaDnSiEj6f7QmlHyhxKe3BU0s0LmKdMqvRFEfoCds3/z6HChInY2ddY9ODkVvSh4qz7SEeuYG2mcZ4aiIMC3Gg6lx4CA1HEUTtJdGe3WkdrejzmbAfM6kGgUCuIe+f+BBdC2Y/cuCUWXqOSpQxxLvTh81I6NqxCeM5+ruTbXOA6yY9oceDgATI4d23e6EfH2WvWMjQB4XstEnnu+e3pbsipAt+TxRzyhFPW5xYw4eCfvPDhTOLfYnr6Izv86RdGDwByHWtsORv/dauWtK3KIQ9QORkeNg4EVWq6JXENO4z1prMQAgWuIOmH5a5hIV68CFYio6yx3ygf/U4xffXVZhhZdkSeAJuI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(19092799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GHkaZbLtc9iq/X2Lu2mQUx4MwgWIo8tcJhfFXUu4eQlZz0NycfbHAU8nhVVD?=
 =?us-ascii?Q?Fo7HYLON3y61RSBNq1MRf9/ttn6ENyx1m4vxg5P+hwjuWknOy0tTZs7Uc6rO?=
 =?us-ascii?Q?NDTfIwpoFJA4rrXhCPSCoNxnNDt/lckmJQDuDx1XdVGaoil2zlR0VyKVrgve?=
 =?us-ascii?Q?wpTF8ihoFN+QtkqD8emqHp3MBZKhloVPny8NNAjJ5F6ioTvfaDPl4Qen/sw+?=
 =?us-ascii?Q?91oMOQF2Y6RUJE5TbSNdzvn9CswX4ELofG9J4aMufTSzOJ9S01CGxKTRs1Gq?=
 =?us-ascii?Q?rnvQ+XzWMGNH4G/wDjooBg5GewCXt3membb48Oya3T8iQ6F990nDlKCrm7cf?=
 =?us-ascii?Q?0i8tULeiXemAogy6rQi10GAtvfRx2iYOrMzChHTDwRzCri1rELnarZaCZ4xR?=
 =?us-ascii?Q?uQqZBmAzfySLfAakUyWckL1jlSa/iWSYYIHAnBhDkgvgUnV1gnXujZe/lvgE?=
 =?us-ascii?Q?kUn7QaSHTQeX9sY+oEiddoQqcIUYe9HuwKQGohaXgSmei/16IIPuKLcGmLy8?=
 =?us-ascii?Q?MENyxthczhLCqRvFpQGI5tTUZnEkvSn5XNUpfxha1albMCUU63gmfI6oppE3?=
 =?us-ascii?Q?A9ZHjwAPEq89yphT09BUnal/vARQFKFFJeM4I8moFkz+wFDFw8U/y4mj7T/l?=
 =?us-ascii?Q?OVsHYpqfXOOPBcBiycJO3TvLuklujWPCKU4vCiyABcSjQunzXipG7CEY4KdR?=
 =?us-ascii?Q?pXLlUnwuHl8zgcv1tM1sXaKKPAMpBi+JyixKKPLpaKkkZRhqztgCicTy90Dv?=
 =?us-ascii?Q?1Ovc6jEvvqWpPd62LI6cd6PnB8Ra3iQ6Aw6QhpbQX0FqvV5ZSItiEqQlF2ax?=
 =?us-ascii?Q?iyKlYqDyWHcd5KQHiKihcPPXgYbRm+3/WZ6ew5FjhHLqmVEoJGzBCN/1SmNB?=
 =?us-ascii?Q?PlWjOgHiiE5N4lFmI06auPByq2+uuZftBtkZZpPrt8VcZkOMzbNVo9BaXDgx?=
 =?us-ascii?Q?gQmQbvp9kFDb68cfxs+7T22JrcF1lZzdkJZGANpOi1xP4bBldz/2JH6k4Rv+?=
 =?us-ascii?Q?T25RLibuQu8BvvWD3SSs+bFHY8O/GyXZH2gweFnT/Wy/LmHSG8NGJR1zhEG7?=
 =?us-ascii?Q?XSFHKkfZ51f3CUGOyv2kKrFIBM8KcNjT9qyWIkSw40m/tOY29CJpW1c2Xjva?=
 =?us-ascii?Q?OTpRmjJ4QdCuSsIh880lh5AWDvqg8qUnjRfOax94AK4nv3cGP9YRToY51Bni?=
 =?us-ascii?Q?F6HemXtJ7tzAP4Qu525XngxAWJyhw74x6K8ew15Oe8V51QDcaUoaSZWnWuaB?=
 =?us-ascii?Q?xVIjKrbL9och36UYaPBeqCiqA6SKl42bugFuGDCGmx22sZcZs1/WhgdnGfHW?=
 =?us-ascii?Q?zQWK4aoGmwKr3WZ3dsd0j06DbmPGmEiyPovV4JbXyKdgVcMzvhCWLgDTeKBz?=
 =?us-ascii?Q?O2FhetG/LcOkL5mlmogPAUZH/KHDEUqCaOTWt5oZA36xQ5ZY5mxAQ/ricx4s?=
 =?us-ascii?Q?JVUHaTXvCX5GGd3KbrhF87E8NPTqT19f9pvrFJ8H2zIAHrM+7mbCpgDTiwqZ?=
 =?us-ascii?Q?8i+F6ae28hMOk8l9TWwCDTdiQCgn8hBMUjXQyYEpy+nSWeuYaiWc6KErjqDy?=
 =?us-ascii?Q?wYHiT8a6/ZhnO53TnfMp4a8JozZcBq7Spnt1pnxtpYVgG7ebNwyCitmvhDzZ?=
 =?us-ascii?Q?3ADIHCLuNdeUlXWro83I8PexfXAham1zu9x4zvl2kWpFs+ND9G6I+UUOm+mo?=
 =?us-ascii?Q?55H7w1Z3j3NW8WtNiLUXxoTmEWRzXXJkvt2cvdYEHJRxH7EL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 460120df-8f69-4345-1bb6-08df0a63ad23
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 09:05:33.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znBGYnodp1ZzN7PgBHmqKIHYQ1mPo+EDYKnYCeXaDV2yZM4P9J2dhHnRzAXQxGo0yyFYceGN2Jz7ai3yMOXdRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

> > @@ -1138,6 +1141,7 @@ static struct pci_driver enetc4_pf_driver =3D {
> >  	.id_table =3D enetc4_pf_id_table,
> >  	.probe =3D enetc4_pf_probe,
> >  	.remove =3D enetc4_pf_remove,
> > +	.sriov_configure =3D enetc_sriov_configure,
> >  };
> >  module_pci_driver(enetc4_pf_driver);
>=20
> [Severity: Medium]
> Enabling .sriov_configure here, together with the new 0xef00 VF ID, makes
> the PSI/VSI mailbox path live on ENETC v4 for the first time.  Can the PF
> mailbox worker and a VF mailbox sender deadlock against each other on
> rtnl_lock until the poll times out?
>=20
> The PF worker path takes rtnl_lock while serving a VF request:
>=20
> enetc_msg_task() -> enetc_msg_handle_rxmsg() ->
> enetc_msg_handle_link_speed()
>   -> enetc_msg_get_link_speed() {
> 	rtnl_lock();
> 	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
> 	rtnl_unlock();
>   }
>=20
> The VF side runs from ndo_set_mac_address, so rtnl is already held, and i=
t
> then waits up to 200 ms for the PF to answer:
>=20
> enetc_vf_set_mac_addr() -> enetc_msg_vsi_set_primary_mac_addr()
>   -> enetc_msg_vsi_send() {
> 	err =3D read_poll_timeout(enetc_rd, vsimsgsr,
> 				!(vsimsgsr & ENETC_VSIMSGSR_MB),
> 				1000, 200000, false, &si->hw, ENETC_VSIMSGSR);
>   }
>=20
> If the single worker is servicing a trusted VF's link-speed request while=
 a
> kernel-bound VF issues its own request, the worker blocks in rtnl_lock()
> held by that VF's sender, so the VF's message cannot be consumed.  The VF
> operation then fails with "VSI mailbox timeout" after holding rtnl for
> 200 ms, and the still-unconsumed message makes the following VF sends fai=
l
> with "VSI mailbox is busy" (-EIO) until the worker drains it.
>=20
> The trigger needs a mixed configuration: one trusted VF issuing link-spee=
d
> queries (for example a vfio/DPDK-owned VF, since untrusted requests retur=
n
> PERM_DENY before rtnl_lock) plus a second kernel-bound ENETC v4 VF on the
> same host.  The later patch adding ndo_set_rx_mode_async for the ENETC v4
> VF introduces a second rtnl-held 200 ms mailbox waiter on the same path.
>=20

The rtnl_lock() in enetc_msg_get_link_speed() is intentional, as discussed
earlier: for a MAC sitting behind a PCS with rate matching, the speed cache=
d
at mac_link_up() is the PCS/interface rate, not the external PHY link speed=
,
so querying phylink is what gives the VF the correct value. In practice a D=
PDK
VF does not poll link speed in a tight loop, so the chance of this rtnl acq=
uisition
overlapping another VF's rtnl-held mailbox send is small.

If the concerned situation does occur, the worst case is that one of the tw=
o VFs
gets a mailbox timeout error and retries, which is acceptable. So no change=
 is
needed here.

