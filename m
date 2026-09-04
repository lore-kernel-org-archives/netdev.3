Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBC3A0E99;
	Fri,  4 Sep 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506213; cv=fail; b=ItnbWXkzw7sswctU01lPQCsbjU96SK5X6YfVw4DkKNro+EnBuP+tOiN2nJvgBRlVfnKRwJ/nQsIjVll/gA+LgeHk6ZF/m1eSDLGh7WyvQIgmUGcKgIfRdNvbH2C/n2Fpz3CIw97s/4Epfl8L3hGxULsuNDSNGqSx3SJKEppQrsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506213; c=relaxed/simple;
	bh=EFq6rHmmU1laUXj/K+reJuGSIk/FIyiL6kfmct8jCc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KhVKe3ZDHrmumBeB7YrGgYbnhHrv/VfRqQoKgYvr+d+3xU8kwf8GwgImaY4bn2c8GdBCxszhr2l1ktzZ+uIPvJjgcPMp0x3ECiYZRJFjFuvHlGqa4vaPRam2fZxN28sF8cE67wV6unLo9B0lpnYG1yvH5wYy6v+CZmUYb6sIfa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Th79dsAZ; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Th79dsAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUxYPI0v2Lt+2WwtYx2siyZM+JR4wukaP2FJO/5pLkgySSJiC+qlrhlnwb59Z4d0zm+4dHcnaknAfYpnY6L1UrXhADgoq+sPKcjLPkmKFeVaENyHPcY6uuC11gj0/ZkD/+JgL5Fx6ttxliilmDukrZCfLC62WrGI+f1wvJx9yd94A3Xw19/LDjLizguAbB3XQyzGbwhPlgNtzp5/9vSdlP3Hy/PMQxbtnr1ba7UgEdSGIzcrJzmrUcFqy+WcNgRYChNV+GwVIatPT4HiUfMo4avmjPiFXBUEgo53xGbLZGC3LuM2W0wKJ/ELEAXxlExGwLLjggIVNXLNM/J8qo9Nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/OD+BxQEB2Zb1EH+d/xLWVmnCVRJtfZViHWNJiaq8E=;
 b=Kd9EDqDyEotdJZjMpVtGvbWpAhxGnaLwYY/2LJpZ2SOTmucU+C4sGJ8yizTqYPQPcmvlqDQL9pAlFZkyIa9IRYCFPiK+5E3Kl1RiPbXo4w5jeTTRHr1R3d3pJuYil0trNbXAcIDpRRwgOWy1uLUjavojkT1koRR3Kv5HtWY8ylxYOGLIsYRlcMHdN4F6VVZS0M3nK48vZaYRYDZQ6u3Tq7A+/7/JZrBSO/BKWNehyO6fMuUBmI4+q2L6haRezwTz5915qMiXt6LlZHStHNaoakbMDUYlC4P0zOkcjMt+gT+64j0lB5mCvbE9o0CI+UFLaQgJTQeBWvQUNpjeMqFB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/OD+BxQEB2Zb1EH+d/xLWVmnCVRJtfZViHWNJiaq8E=;
 b=Th79dsAZhHqI1KgCYw/fMZFmGYk3LxB4zXNHruAvF87vdef7UHwll+IOWsHGiBm/tPU//4kEWRtFpKcAg1TTuhej2HU2fJrPjmBxOfvRUsFEQpGl6gQIomV8oW8CAl8W50JStKobmWYFqbnC1QOPO+KdOA0a/lpuak4770+tyzQqdmnjsF+85q53pQwq94e/QgEaWM2jQf5kkbVW/PKrJCym1BWyJMGEYmKi573E7r3WGCeC87oQ58TkLARRa/PS9ZxPK/GsQUz0Wk0sVhtqHZ/HRZewRxGEqnBprZIShfqdleBndOjYpn9i4jUtujN5Z3Gzqx6fPbxR/L0oQPKL5g==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB8512.eurprd04.prod.outlook.com
 (2603:10a6:102:213::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:16:46 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:16:46 +0000
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
Subject: RE: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Topic: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Index: AQHdOPf5rPAr6++Cq0ud6wQBTmAapLa9iluAgAB1YfA=
Date: Fri, 4 Sep 2026 07:16:46 +0000
Message-ID:
 <GV2PR04MB117391CC7574CC43FD4744D3088B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-4-wei.fang@oss.nxp.com>
 <178847906345.4131868.5011473704889309213@kernel.org>
In-Reply-To: <178847906345.4131868.5011473704889309213@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB8512:EE_
x-ms-office365-filtering-correlation-id: cd744382-88e4-4ac5-6307-08df0a547af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|19092799006|376014|18002099003|22082099003|11063799006|5023799004|38070700021|10067099003|56012099006|4143699003;
x-microsoft-antispam-message-info:
 PwO/wLg/vR7090rt9IADtAOin+cGU/85AL6D5TeQoW+bMSh3x3Vs7cITF6oZG5CdhE4MP061GAYYggosyRW1a6sFqDgvrtE4GfHCuD06MnLIKH2qBU4/yyzIhVdWZbp5K/up/Z/epIrBekjC7ppl/Ud5UTaHLLfflyUobz/h5b3rDDEoCiOjK4JDyRvnQjvsZMitnAJ8hxuC5BLDPSIdmuMYXxV1aRmKb/jHN/E7PXFaI1YV+Iiie76zdg7lz2xfsJ3EFbjF6xoGPTqnHyN0UaQSwzzIASOXCeE8KxE8MgE5j8NkXjN5QTDQSUELJnaXjA3BMR/wtHV6G+N5UbUSM0U0YxgbB5VIYwzoTivDWDQWGJzPOeFUY1px1Jz3+2uYhw7xYKx+zaNHYeR5oOhAy9nSxpXvxIhbn4U0zgKxdyXoZjdJv6Ip78Uf7LIxq/iFiCsquo/NHpSSDDB+f6DxxNDWbCv01Mk4LJwNmtYKT+mMIivw5w5g+94OElLg8p60wwnG+Or0wk6GpQsZRWDxdXk+oVTJ3/zOnP3OUI5s+DRG0Qbkj5My1VicAt+B6SeSHC3tOFsHtKAPQVyti+ey8DpXmYtDT5FhMa93RdzlY/4jt54iWpyhKWZbXvH4uU60ZWoTyMOB5JPcES+cmL8vnKqhYCOu02EsteCtlCY79VAhujAI9hKycghSXi9fDQPG6q8QreOFtSNFrbDwB/jGMmtAfB1kJMglbeopF2gg/UI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(19092799006)(376014)(18002099003)(22082099003)(11063799006)(5023799004)(38070700021)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?042XkHn4pZb6WVQzf5PKHBXO61/SRY1lnfppSEUT4pIcUvQZuRCrfIrwKQRe?=
 =?us-ascii?Q?CmY7KpjmDYrzGm32E7e8eYSggHioHpRZZU5hY8bWtlYI7PUssRgNGDtUqOHG?=
 =?us-ascii?Q?yqrV5mTZEcXzB0xAD6e0P123d9JGXs7tE4QNyTyFTKWGhhh6WAu0BBKXeDte?=
 =?us-ascii?Q?VE+RMOO18U+c32TEUOud0f5mtVLfHGKB5nkrAo5VN88R5OK440UFWlpaSDPx?=
 =?us-ascii?Q?e8/aCV6iTGJC0Bdw0LDYWtlMDGcu9j5hdupFmydvmVFi4A2fufBTKjptCmWL?=
 =?us-ascii?Q?d8gMnrDQCB4DrCSi1HDIJKN/bWQ/xFqqiB41cgGkry4L4VEYhz3E2ANewv+H?=
 =?us-ascii?Q?3j/QGDSXn4USddeEdtDDK+bUEwjDA5cW1csdOPkBtIbd0j38kX1mlQNKx4KD?=
 =?us-ascii?Q?fypNfKMtuGXgHRglucTLmljOX6sw3JUVGyy5WHGepeo8+2bf4VqDypMTFd5L?=
 =?us-ascii?Q?LCY7gXEZO3EsfproJAX6ejzqqukBi3vjKXiFHfrRZkAJ5xD9wLuYeCC0QkVD?=
 =?us-ascii?Q?dcK9eNw0U7B3aJOK4E88M7TMhp4ko2UdgKNsqxO6VESex2JKpHeLg+2oD2DK?=
 =?us-ascii?Q?xqGCbZtwyc9jUo8DO4pPY+yP4w7UDBMB20ppMCEypkMik4Qb0oK4CQPLqmZX?=
 =?us-ascii?Q?YJtR5MnmF1KJAxNRXtsJKn0NYaE6pU0P9lVwSL6Xd0kH6XoepObIBt/gmxZ7?=
 =?us-ascii?Q?a2WIJHUmn2N2NA+MZ1h/F9HxMgUT/8v82+mPz5baIfvQQyv8mnXyKY6w1m7q?=
 =?us-ascii?Q?L5c06Vqw45IK0J5IQXpLgR78VZWTNPriA7FsDHOHWLdU63ZpTPrZMeUVtPOU?=
 =?us-ascii?Q?EfQCjSj/XEta9HDaU6JMoFAB7ICg5oOF+cP9flaXahqi60VenhzyBnGbc3Kf?=
 =?us-ascii?Q?a4TPjau90kSE+Z7Qm2zaF88qjvgJLVO55Co9QCBhId9+CoXVRSwhcCwo+cwN?=
 =?us-ascii?Q?M7bCzyEC56QSh/7UiTKW+7u21BbMmKPzxFax+CSCe9soGIXKYZsryOcduF9w?=
 =?us-ascii?Q?2/nuZj0bevGzkbuY3TSUPr3EnBSwJgKl76D+ixYMK58/vrsFZS1FXsidQ4nH?=
 =?us-ascii?Q?k2sShrYp/Os08R8oJq/VRhCDYEvPnapEhYxRVGJn4jfmXrlPq44av1OOE+Vw?=
 =?us-ascii?Q?+k2phc1rJvbHJEmX7X9ZWRA/t+OTMSMWSaRZZ6BAk4Akx9ZdcL4quZ9vGWdi?=
 =?us-ascii?Q?jh1EaMcMLU2cuqw+mzoKDodSMwRGGGOQi7Qkvj5ueZGcznyodV26DqOud1br?=
 =?us-ascii?Q?WCj28ge+1SV0VCs5N26g+4PcF4Gb/rDp26LSEuxjUGRY7F/WN4POqYcU918p?=
 =?us-ascii?Q?t7Y4qnSICXTj3uNX1aR8yF2GxAus1KWzlhwnliDHlF5inhIrzxr7lEKBzhmT?=
 =?us-ascii?Q?yl6PI49fo1AnzDxrTlf2sCb70sQv7XkgPziX51gLDV18BtrvmI8a6Up2DUiJ?=
 =?us-ascii?Q?iMK4fpDIxpeZCf+Go8gO5+f22MaMhCjPv0fSeh+3JPqqxuK0LSQ9YhLokQv6?=
 =?us-ascii?Q?p2ltm1GhX2pwn6XnkLlgCtG7+jjrl//NZPR14dMU7yF9DClROV0qHJ85XBen?=
 =?us-ascii?Q?NZcYtmvgvaTPyGynwJ6kYzah5nBuXG5XXeTR1qubRXmvvzw3JQPKWrno7pfF?=
 =?us-ascii?Q?18hW/2OPS6pldA2JIqLdZ+GbMHAQSgsWMdVsGHE+5UgKc890IMa2rA8dUBm9?=
 =?us-ascii?Q?OzdiluaOXN/y2w2hlqFryjQOH9mEBi41rXFMBXHZ8h1p4HhR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd744382-88e4-4ac5-6307-08df0a547af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:16:46.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdZOznaaYpesUG/HVmQwhYNyeyX0DuBQexdeiOryjaTe5CRz7bmoq0kMkIre1piFweHkagsM5nVNxmSqQwuH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8512

> > +static int enetc_pf_send_msg(struct enetc_pf *pf, u32 msg_code, u16
> ms_mask)
> > +{
> > +	struct enetc_hw *hw =3D &pf->si->hw;
> > +	u16 old_ms_mask =3D ms_mask;
> > +	u16 ms_status;
> > +	u32 val;
> > +
> > +	/* The MS bit is set, indicating that the corresponding VF has not
> > +	 * read the last message, PF cannot send new message to the VF. To
> > +	 * avoid sending messages to such a VF, the bit corresponding to VF
> > +	 * is cleared from ms_mask. Because the MS bit can only be written
> > +	 * as 1, writing a 0 has no effect. Writing a 1 when the bit is
> > +	 * already set is undefined.
> > +	 */
> > +	ms_status =3D enetc_rd(hw, ENETC_PSIMSGSR) & 0xffff;
> > +	ms_mask &=3D ~ms_status;
> > +	if (!ms_mask)
> > +		return -EIO;
>=20
> [Severity: High]
> Can a link state change be lost permanently here?
>=20
> The return happens before the enetc_wr(hw, ENETC_PSIMSGSR, ...) below, so
> when the target VF still has an unread message the new link state is neve=
r
> published, and enetc_msg_notify_vf_link_status() only prints
> "PF notifies link status failed". Nothing records that the VF is out of
> date, and notifications are generated only on the phylink transitions in
> enetc4_pl_mac_link_up()/enetc4_pl_mac_link_down().
>=20
> Single-VF sequence:
>=20
>   link up   -> PSIMSGSR written with "link up", the poll below times out
>                after 200 ms because the VF has not read VSIMSGRR yet
>   link down -> ms_status still has MS(0) set, ms_mask becomes 0,
>                -EIO is returned and "link down" is never written
>=20
> The VF then consumes the stale "link up" message and keeps carrier on plu=
s
> a stale TX PAUSE derived congestion-mode setting until the next PF link
> transition. The same drop can hit the initial notification issued from
> enetc_msg_register_link_status_notifier(), which has already replied
> ENETC_MSG_CLASS_ID_CMD_SUCCESS to the VF.
>=20
> Would it make sense to record a pending state and re-send it once the MS
> bit is observed clear, rather than dropping the transition?

The scenario is theoretically possible, but it does not require a fix.

To lose a transition, a VF would have to leave its previous PF message unre=
ad
for longer than the 200 ms send window, and a reverse link change would hav=
e
to occur within that same window. That does not happen in practice:

The PHY state machine polls link status once per second, so consecutive lin=
k
changes are at least ~1 s apart - more than enough time for the VF to consu=
me
the message and clear its MS bit. In real usage, link transitions are infre=
quent
to begin with.

The PF also waits up to 200 ms for the VF to read the message. A VF that fa=
ils
to read a single message within that window is already malfunctioning (e.g.=
 a
stalled), and I don't think the PF should compensate for a broken VF.

So no fix is needed. Recording a pending state to re-send later is possible=
, but
since every notification already carries the current state and the next tra=
nsition
corrects any stale value, the extra complexity is not justified.

>=20
> > +
> > +	if (ms_mask !=3D old_ms_mask)
> > +		dev_warn_ratelimited(&pf->si->pdev->dev,
> > +				     "PF cannot send message to VF(s) 0x%x\n",
> > +				     ms_mask ^ old_ms_mask);
>=20
> [Severity: Low]
> The printed value is a PSIMSGSR MS-bit mask, not a VF index mask, since
>=20
>   #define  PSIMSGSR_MS(n)		BIT((n) + 1)
>=20
> so a stuck VF0 is reported as 0x2 and VF1 as 0x4. Should the value be
> shifted back to VF numbering before printing, or should the message say
> that it is an MS mask?

No fix is needed; it stays consistent with the registers, making debugging
easier.

>=20
> > +
> > +	enetc_wr(hw, ENETC_PSIMSGSR,
> > +		 FIELD_PREP(PSIMSGSR_MC, msg_code) | ms_mask);
> > +
> > +	return read_poll_timeout(enetc_rd, val, !(val & ms_mask), 1000,
> > +				 200000, false, hw, ENETC_PSIMSGSR);
> > +}
>=20
> [Severity: High]
> This waits up to 200 ms for a bit that only the VF can clear, and every
> caller holds pf->msg_lock across it. Can an untrusted guest use that to
> stall the host?
>=20
> The VF-initiated path has no ENETC_VF_FLAG_TRUSTED check (unlike the MAC
> filter handlers) and no rate limiting:
>=20
>   enetc_msg_task()
>     enetc_msg_handle_rxmsg()
>       enetc_msg_handle_link_status()   /* cmd_id from the VF */
>         enetc_msg_register_link_status_notifier()
>           mutex_lock(&pf->msg_lock);
>           enetc_msg_notify_vf_link_status()
>             enetc_pf_send_msg()        /* sleeps up to 200 ms */
>=20
> enetc_msg_task() handles all VFs sequentially in one work item with the M=
R
> interrupts disabled, so a VF that registers, drains its mailbox and
> re-registers in a loop keeps pf->msg_lock and the mailbox work item busy
> and denies mailbox service to the sibling VFs.
>=20
> The same pf->msg_lock is taken by enetc_pf_notify_vf_link_status() from
> enetc4_pl_mac_link_up()/enetc4_pl_mac_link_down(), and phylink runs those
> from its resolve work, which is flushed synchronously from ndo_open/
> ndo_stop with rtnl_lock held:
>=20
> drivers/net/phy/phylink.c:phylink_run_resolve_and_disable() {
> 	...
> 	flush_work(&pl->resolve);
> 	...
> }
>=20
> so the guest-induced stall propagates into the host PF link handling and
> rtnl-held paths. In the other direction, one unresponsive registered VF
> adds up to 200 ms to every PF link transition, because the poll condition
> !(val & ms_mask) waits for all bits of the aggregate mask.
>=20
> Is the synchronous acknowledgement wait needed at all here? Link state is
> idempotent, so a fire-and-forget write with a deferred retry, or at least
> dropping pf->msg_lock before waiting, would keep the PF link state machin=
e
> independent of VF behaviour. The commit message does not mention that a P=
F
> link transition can now block on VF acknowledgement.

This is a potential issue, I will improve this.

>=20
> > +
> > +static void enetc_msg_notify_vf_link_status(struct enetc_pf *pf, u16
> ms_mask)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(pf->si->ndev);
> > +	u16 pf_msg;
> > +
> > +	pf_msg =3D enetc_build_link_status_msg(priv, pf->link_up);
> > +	if (enetc_pf_send_msg(pf, pf_msg, ms_mask))
> > +		dev_err_ratelimited(&pf->si->pdev->dev,
> > +				    "PF notifies link status failed\n");
> > +}
> > +
> > +static void enetc_msg_register_link_status_notifier(struct enetc_pf *p=
f,
> > +						    int vf_id)
> > +{
> > +	u16 pf_msg =3D FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> > +				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
> > +
> > +	mutex_lock(&pf->msg_lock);
> > +
> > +	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
> > +
> > +	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
> > +	 * need to set link_status_ms_mask and notify the link status.
> > +	 */
> > +	if (!pf->sriov_enabled)
> > +		goto msg_unlock;
> > +
> > +	pf->link_status_ms_mask |=3D PSIMSGSR_MS(vf_id);
>=20
> [Severity: Medium]
> What clears this bit if the VF goes away without unregistering?
>=20
> The bit is set here and cleared only by a cooperative
> ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER in
> enetc_msg_unregister_link_status_notifier(), or globally in
> enetc_sriov_configure() when SR-IOV is disabled. A VM destroy, a guest
> crash/reboot, or a killed DPDK application leaves the bit set.
>=20
> After that, every PF link transition reaches enetc_pf_send_msg() with the
> stale mask and either writes the MS bit for a VF that will never read it
> and then blocks the full 200 ms with pf->msg_lock held from the phylink
> callbacks, or, once the MS bit is stuck set, filters that VF out and (whe=
n
> it is the only registered VF) returns -EIO, logging "PF notifies link
> status failed" indefinitely. Since the poll waits for all bits of the mas=
k,
> one dead VF also delays notifications to the live ones.
>=20
> The FLR handler added later in the series, enetc4_pf_vf_flr_handler(),
> only restores the promiscuous mode bits and does not touch
> link_status_ms_mask, and enetc_sriov_configure() resets only the software
> mask without bringing PSIMSGSR back to a known state. Should the per-VF
> bit be cleared on FLR / VF teardown as well?

link_status_ms_mask is PF-side software state that records which VFs
have subscribed to link-status notifications. Its lifetime is tied to the V=
F
driver's register/unregister requests, not to the VF hardware.

FLR resets the VF hardware; it does not mean the VF has stopped wanting
link notifications. A VF can go through an FLR while still being a valid,
registered subscriber, without re-registering. Clearing its bit in the FLR
handler would silently stop delivering link updates to a VF that is still
alive and still subscribed - that would introduce a bug, not fix one.

So the FLR handler should only restore hardware-related state (e.g.
promiscuous filters), and must not touch link_status_ms_mask. Genuine
teardown (VM destroy / VF unbind / SR-IOV disable) already clears the
whole mask in enetc_sriov_configure(), and a graceful VF close sends
an explicit unregister. Clearing the bit on FLR is therefore neither correc=
t
nor necessary.

As for the "VF goes away without unregistering" case, a follow-up
improvement will remove the 200 ms synchronous wait in
enetc_pf_send_msg() (moving to a fire-and-forget notification). Once that
is in place, a dead VF that never reads its message can no longer block the
PF link state machine: the pre-send MS check simply skips that VF, and
notifications to the live VFs are unaffected. So this concern will be mitig=
ated
by that change.

>=20

--
pw-bot: cr

