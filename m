Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E36381B0A;
	Fri,  4 Sep 2026 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511260; cv=fail; b=BTUDoEK4KGnW31E6FJ2K5rLfEsBQnEVSAqgisO3rlp8uRkvyjJtOfH+Wz/p/EocN6Ixc9OCQK+9ZQV123n5TyDIOTJnDJQE1KWeiQAtN37Bc4bAuXr/XyKJbSSRF0yB+qvJRm4VMw5hHGuD9DV38oqrCaJD6ImK39sd63FX/KEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511260; c=relaxed/simple;
	bh=D5hBvGFZFSllJhbxp8W0RVgl10H5jG6KdbRNAnK+Uzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jk7i83MbmuhP3RBZP/I8ioqmDBsBvKULYeIy41W2LNVjzjRQQAAeCzJoUdmL5twWq71ehA+GjPKKXJnt35c+d7uIr2ErKYvLrUenUUyAU1rrJL1/+rnC2e3ZyKd7XM434jfO/pRyAlbOWrRRxXEWK8Tf0cTW8ez0KixitY6JeKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XRBn1HwV; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XRBn1HwV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcWWiRFxz0VHFM4McxZWISt8D9iDyMd1ooEM7t0UGX5GlwS8JAOS53fX9nU6LHaNgael0dAUVRabgsKHEBc0j96Eern5IpKS2+ilWHztzT78GspmCP7Y/9LN0FxpVSytQ7vYEOrVju1naUMi3KyNOGO0pSiePkUAamYCvk4FY8KyFd7iu3GatHsHD1WYE/lgCvmktD5+2xa5rpQB378QNsnpWjuHmqEywwUla4jZhlyzuh/NwbrueA9aBoOdUfnfIH25o8kLwxwFPyp5d2tBi+mBx+uuNhLbcPojXyGt3oN+T0ZDeonAIT2A3qYqr9WxgXuOfz2Za/GsNTxEdWdYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z2f2lgdjONADNFOVgAw4cv2eyq382exHxHXIBxbXmQ=;
 b=Icx3fF/E94cCGyet1WQuacZlaOHCLOJ2IMmoKKMqF5VLBorTfDb+pSHfg+FbsnI2zmiyxFMNJ7oAaIcg2zo8YkN+fYrq12xUFIMOBa0IzKDTJbUMmwQh2g0GUZUxbvcpVWrFXRZGaVrlDVe7zhQr0aKdh4VKcRDfpcRwZYMLIhqthLsfEXUn6ipFRVAE+do6esMNTH7AbsFCv/wsmKERbAPh+AF8SIulAdY3SvLZhnCbEyAGT6AmDzQUie6FugnRmmjro0NPpx+Uk4xd+J7PvHKLYJQZbJXUIiOX+TvcW5heZMjH/rPPCiZVgVG+aNE4FpvQBFvVCyjoy2U5GDXW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z2f2lgdjONADNFOVgAw4cv2eyq382exHxHXIBxbXmQ=;
 b=XRBn1HwV9jq2gzJjGR0a4hVo7Skt4J0K193Fvfe6N2zmqZRt1W/WqaVwlSk3C/l8uHhp5sjeZJHKT2mCFk5gOKxXtUXfhE6rO8VCrMTymeOKRkFPT9bKUw1rYtBN6Z717P3haoawnEqoh0PWdBWLWsKQEidJsrIvO578IEwiKMyFWCON6I+6kuYmNn4PNEt5Ym3/jhdhjOyb1KvzGdOBsOG4wU0whHFGfs5uDGm75XA15QP4l+ZQ9NlvpyER6I2yHnSLTRcs0ozgEZrqkQEM4r1DHFscX6YiSaMv0C1DTH+deT5EiGYLwrLfUphBjEiM0ttkp8gAP9lx9VKJ0yKEJA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM0PR04MB6836.eurprd04.prod.outlook.com
 (2603:10a6:208:187::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:40:54 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:40:54 +0000
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
Subject: RE: [PATCH v3 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
Thread-Topic: [PATCH v3 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
Thread-Index: AQHdOPgVsuQl559EyE6fqf/ntgAyQLa9il+AgACObwA=
Date: Fri, 4 Sep 2026 08:40:54 +0000
Message-ID:
 <GV2PR04MB11739045BEEE7C80FD95E119988B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-12-wei.fang@oss.nxp.com>
 <178847906763.4131868.15039580023572972267@kernel.org>
In-Reply-To: <178847906763.4131868.15039580023572972267@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM0PR04MB6836:EE_
x-ms-office365-filtering-correlation-id: 1b2eb3c7-7ed6-4fbd-339f-08df0a603bc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|19092799006|366016|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 /DldqJQ5ylOCe5rPv85hqUY74Q4sYVGZAZ2QR7i4xqL1yVOk/Z9lonWHbB2tnp+lvNlOoQxtozNrlHr1WEPUcf0k9QeLZinnIgrNBw1UW8PsBJmAJZY1s0374HPaZnktt94B+xuwRbiNMbTcW/vlY1hlv2dpErX5S38lfDYYqXE0W9ZVLB0p8IjHLqAtF5XBYDa74ZATvLuXnHde1hILmEGQSO3M6hdaSl8KslBzHfJFPBz5Zi1R84moSbMwwSrNZsSGqP/+htgLp0AQTX0nzDE1W9r2hGmz49ur2ORGugnPoydClRJhoqvjoCE3t3PADhh+1L84iHx4Ky5h6LyM69veq5999LTyh/XlUmkmFJt/FVdd+4Vv4CCBElpFlKSTfmt4kB4IMKLhmhArLhRyfEMyCQ5XrHPzLqxsCcPm8bhg5SfHMtdHSPUoICh6Mt/TbTfowydhQPxwqiLOvP8r/L6UZjbn1GVISyQd8mzSz1Fol3h9MET0+eRst9pYPZeVSTau9qA4QU7QGEtKIHCCagh4gpGsRcggy+mxXHKO9dXhfbKIEe5BeiaAHOENcNTg3dADJuriASWVfwWIc/CrB1q005EI5ApApQ2c09jAUaZFnLCBwgJusVqLpTKlXOvw1/uQKVDjAusWngvqZTTRkzUsNmcPd9RJVwnpvZUuYKMUn0XRckvUt5sERb4PdiFKJmr5g217VG+VdFgPDHB+OdqGYzfpesbhLT/sXax0DTQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(19092799006)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l6iIWAGfEjVs3K7q+vHN4xyDuMOk2zavu40Q/xIxUkVYuczPFvP8RYVUE8FE?=
 =?us-ascii?Q?J6raT4khOnJUgoIK/Azzxeu50X7MItmmfGlwxwU47K5xg6IDXGELg9G6mXMb?=
 =?us-ascii?Q?mg3xDw86Xgr+xyCKBVCPWDNV+geNVtW9yBYwcjJHCNspneiiPsgvdUwNpCC8?=
 =?us-ascii?Q?lSSECeHsWI0tYi1/r4Rb+d1i15MyorHna1lErzpGz2YJg2uDgF7csgBZ7M1k?=
 =?us-ascii?Q?5BEzpBiGaWSHMLRZe7CzGuVXvHuOkQXcLe8cpjX+FivZ+2ozGUSwlIcn87g1?=
 =?us-ascii?Q?gf1OxyD2QSkMmjZTd2eSOlM1EC+RgnyrrDklUI5vdGbcsoBictkd2fivhsRV?=
 =?us-ascii?Q?YEl1yOV2eHF5Uwe5cMOqsrn4fOpE8nkVt3o2mSLdrzBq1KAfc19vqzMDfP19?=
 =?us-ascii?Q?X9HSZnnkC0odnhLIzDOHZrImj7IOazHcOLt6RzIpIEOkN+9wWn8rHAE4I7HD?=
 =?us-ascii?Q?FFZpXLbgsVKQOd8/Nwm6RBQlag/O6lS8Jo0gYRN1AfG1dtMkKO+L7cu9RXZK?=
 =?us-ascii?Q?JcQlQV7B5xPWHbWHCgNrv/EtRkS6q+CjpvjBEx75H0tTcBYDuP2WD83ATg4H?=
 =?us-ascii?Q?Gzbl1Bl4y5Gd0v/XMWs/gBVOHnri35vrwsdWPcG1Ce4/b+2mltzRjG5Nvf2X?=
 =?us-ascii?Q?v5/s9L/pxyg1UQGdOuFZW2RvPzx9GCCyqUonagSB/NRnWxCYYeIM8l+h1DpL?=
 =?us-ascii?Q?0hC/aze7/SmUGmcLEwFoi05JIsNu/zvor5vUQZmX8UZgONS/KNuMahVomVBB?=
 =?us-ascii?Q?sdYovlpXf9VicCc55v0DKOJYSANebU2hLCuL11ja3cMAyFhVsdP4Shf2Ss5t?=
 =?us-ascii?Q?ZzXd1N/ujjjDGJW+fIkJOgIoIqs4bOMjYPcrzg3VJ2Ve9DSuUoFAqVYuQipd?=
 =?us-ascii?Q?yyaeS00TatieGzg40sICEqrN+UENO+tC8jMGIIzDyUMGAnZ39CnGRskal0Ke?=
 =?us-ascii?Q?eRSFa7Mb3uJ7nPT2neSZcJ3sC1S79LOBC1dorxJ6fr7ruoS/r/3MhD5hXKj4?=
 =?us-ascii?Q?eU0V7Njrcf9KGJD1/CaJIRPpvbYyjZb9OKNKcBnsuPIDHbrR8g9EueJ1rIkN?=
 =?us-ascii?Q?m0kXWOXq07XUyzyY8PDfeNaO7ZLu8prw6NT4g+tlP5iVjANrKRs/AgLL5qaW?=
 =?us-ascii?Q?4NdY7yInB98KzpM9Dzd24pu3Hs0Ki7jwSWweUFWoDzu0z6DwCvfQ9tfr39rJ?=
 =?us-ascii?Q?20KXic1NiT/hm5td3uz0kRf/ABSPrFmv2XO/wuQAe5DG3QboYnAsGarBBybr?=
 =?us-ascii?Q?Qt7w1v0KPpoQ91wjw22Dh7amqm8seFBHaf1koie/4mj5cr6yB3MYFxOK9oDY?=
 =?us-ascii?Q?I0XihwwMasRbTRx+JX6RQlG1sao4+iFvWdmEHlSkKXA6rBNNydLM3yVVy+8H?=
 =?us-ascii?Q?XIAb+U8g8hCBim1suz1qnb++dlAabyT2ESD0kNsvaGMl6HjVR3qMo8vRqIla?=
 =?us-ascii?Q?WyHuAUyWQOllHyw1tWKFMbMTlWJDY6r+znJIYw0LqGWTE6/nOEh+jxN0NB89?=
 =?us-ascii?Q?lwtVmMmNAP5EWhb3hN+1ytvc+eV1GvdOAi2HfN3WNzzJ7nEHvxAsqbeDKw4o?=
 =?us-ascii?Q?En1jS/kpb9s3dsr2M2BeTieYiC7VoZpw+cKxIzeXqa9P+3oWsPqNVhWNn2Sy?=
 =?us-ascii?Q?I3LcWBJap4mQ5V5XnDFd+s4xhNTf9f0Ag0RinPx8VU4MX3dcFxlogiHrWqql?=
 =?us-ascii?Q?4ghia+wdmOpLDg92ylyr0ZVmkkpUX9/UBQ7BQtdEu+iMHw4q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2eb3c7-7ed6-4fbd-339f-08df0a603bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 08:40:54.5653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meHNEA/jZUnSKBdpCXEaJSN/ap4h9D4gJkoDtg8gEBX59Hz+NJ8XcHoDnt4m4TMaDje1xI2+ZIOr5ANPZtsMYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6836

> >  static void enetc_msg_task(struct work_struct *work)
> >  {
> >  	struct enetc_si *si =3D container_of(work, struct enetc_si, msg_task)=
;
> > @@ -602,6 +642,8 @@ static void enetc_msg_task(struct work_struct *work=
)
> >  	u32 mr_status, mr_mask;
> >  	int i;
> >
> > +	enetc_vf_flr_handler(pf);
> > +
>=20
> [Severity: Medium]
> How long can the SI stay in the hardware promiscuous state before this
> restore runs?
>=20
> The hardware puts the SI into UC/MC promiscuous mode at the instant of th=
e
> FLR, but the policy is only re-applied from the work item:
>=20
> enetc_msg_psi_msix() {
> 	enetc_disable_psiier_interrupts(pf);
> 	schedule_work(&si->msg_task);
>=20
> 	return IRQ_HANDLED;
> }
>=20
> enetc_msg_task() -> enetc_vf_flr_handler() -> pf->ops->vf_flr_handler()
> 	-> enetc4_pf_vf_flr_handler()
>=20
> Since the guest owning the VF triggers the FLR itself (vfio-pci reset, or=
 a
> driver bind path reaching pcie_flr()), it knows exactly when that window
> opens and only needs to re-arm an Rx BD ring to receive frames destined f=
or
> other SIs until enetc4_pf_vf_flr_handler() clears the bits in PSIPMMR.
>=20
> The scan also happens once, at the top of enetc_msg_task():
>=20
> 	enetc_vf_flr_handler(pf);
>=20
> 	mr_mask =3D ENETC_PSIMR_MASK(pf->num_vfs);
>=20
> and enetc_vf_flr_handler() takes a single PSIIDR snapshot with an early
> return:
>=20
> 	flr_status =3D enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
> 	if (!flr_status)
> 		return;
>=20
> If an FLR lands while msg_task is already part-way through the VF message
> loop, is the restore then delayed until the whole in-flight batch finishe=
s
> and the re-queued work runs?  The FLR bits are not re-checked before
> enetc_enable_psiier_interrupts(pf) at the end of the work item.
>=20
> Would it be feasible to clear PSIPMMR[SIn_MAC_UP]/[SIn_MAC_MP] directly i=
n
> enetc_msg_psi_msix() for the VFs whose FLR bits are set, and leave the fu=
ll
> policy re-apply in the work item?  As written the handler sleeps on
> vf_state->lock and pf->msg_lock, so it cannot run from the hardirq.
>=20

I don't think this window is worth fixing - the risk is very low and the pr=
oposed
change adds complexity for little gain.

First, the exposure is theoretical rather than practically useful. A VF FLR=
 resets
the entire VF function, not just PSIPMMR - the Rx BD rings, SI enable state=
 and
DMA configuration are all reset too. So immediately after the FLR the VF ha=
s no
armed Rx ring and cannot receive any frame, promiscuous or not. Before it c=
an
capture anything it must first re-initialize and re-arm an Rx ring, which i=
s not
instantaneous. The promiscuous state is only the reset default and is corre=
cted
by the PF asynchronously; there is no guarantee the VF can bring up a ring =
and
line it up with that short window to actually sniff another SI's traffic. I=
t cannot
reliably exploit the timing.

Second, under normal conditions the detect-to-restore latency is very short
(interrupt latency plus a workqueue wakeup).

Third, moving the promiscuous-mode clear into enetc_msg_psi_msix() would
not give a real guarantee anyway: the guest owns the FLR trigger, so it can=
 simply
issue another FLR before the workqueue runs and return the SI to the reset-=
default
promiscuous state. So the hardirq clear does not close the window in any
meaningful sense.

Finally, it would add real complexity. enetc4_pf_vf_flr_handler() accesses
PSIPMMR under vf_state->lock and pf->msg_lock, which are mutexes and
cannot be taken in hardirq context. Doing the clear in the ISR would requir=
e
converting the PSIPMMR synchronization to an irq-safe spinlock, which touch=
es
every path that writes PSIPMMR (set_rx_mode, the promisc message handler,
trust-off, clear_vf_config). That is a non-trivial change to the locking mo=
del for
a window that is not practically exploitable.

So I'd keep the current design: clear/re-apply the policy from the work ite=
m.
No change needed.
