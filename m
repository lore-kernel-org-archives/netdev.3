Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3262C21D8;
	Fri, 11 Sep 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106112; cv=fail; b=ozoGvTa2dgflqpjURWX5+VT+Qx/rOH5KwRpBQg8IcVYM6SBNPa+B1ThQI4+vGT92lY4HLUx6NR0zGYSGJWP7b9L3PLXMswORzUSVUovgU4q4J8K+BJ4qQfNMEXOt4+qMbEpltcf52BPMLEj0TRq+xWl8JH0BRiDd1za6EOGcI9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106112; c=relaxed/simple;
	bh=GCAr5MXseSUHVL6RDjpIqlEBepp5Fn13jV8Ybf0V6OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QGX3t6ZJ+P3ew40HoRWHFrY1CcApYvuxNtaXAnEwL/4XcisdCeGg/92zZv9LNv+3z27rpEz4qstNbXDsO19HtDLs0SzL4NPwI6kyrkA1Cg7r3XKMUas7/d93VrXhR9FPdayB4PbCNtwKkCK61ddGgvHACAaC1SvorB5l9xpAp6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hgGtAd/V; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hgGtAd/V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sL9Nyh+ddOGm5hkknoEw71vA577thLVrawxkbtMIadrqfuurOboXvikOJMK4gxaeyCH1RynOfA0MTIr+NYluzCkN+E9ctq1etFvtXMznjw7tX4IMJKRjXAMW6ZpkhPfu4Q2HRjTUp0d7ZpocySnc2f72QbAeCekh/3St3WQDC8UOqrRbWjIZ4cOl3db94q4kdqAKKSGRtAFm1GeaN4IBT7a+0i+w7733Jjlo8LHoisYDhOl2hr29L1k+KQBvaaVz3fD6sADFCdT4bcGxF3NLqsyrU0+Vqysr8N9ziE6dX5Np+oLllIxbUMfuiQBcQ/1BTZYDVlr2vZV8YVjHg3c8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W00olGEQOTjN6BZkYn/QpNm0qVcn8OYJJDy+v7m52/U=;
 b=Rd16RS2/jKx0YkN83WiZNXw2B1AjQ/sZZ+Sp1FsGfEHdhYLyIvJexZIOA83ftvIVUQ2VCEUg1a8yMCrwlZ9lCbuzK1rt+Y8QgNlTyrEfUapOfWL3uJYxlCbFgROEyKWStIorTq3FQFi1eL7NHg76zeuBLUZSO0IvPojtrDKUptSDKc0aUvcfsmchiOjT+E1BTZMUVJJ35CgJemZWhYouhax36di9j2bDomCLsjSELcOUM//KrBuV2mh6rEvYo6km+WvnWFXSgmqws1iHJB0YPOS6IwoO1q4rzdTzUbdwIOyQ03sjM3WT3/v6Dj2918MfbHSj/YPEY3RCxVynb+h8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W00olGEQOTjN6BZkYn/QpNm0qVcn8OYJJDy+v7m52/U=;
 b=hgGtAd/VLSQPHOwI1wsWpeqeXsE2vB3DRe/ModePyxKkhvsKT3J74XZY9fEx5dX4l/jgwopJsOdTe0GELfYbmmzBhyPm9/WFYN/9BD+zoreSwYFVzCf5Sp4LQqwNYL8v0wjU6CA+OQgO9tQZhBkma8dGROLLSJXDeYal2W0KlM0yTTnFS4i8Qh4KHLyhg2JKRhn7G/7ZhHLTxxHVaHNGJ+mEPRskvltbETaOAqXZ9cZi2xRtD9RMkv+TMp/uAcYW/+Hhy/RYh1IeKXlpKN9gstazMGe6zNTGv5/W3q0baOga33Tv0GvgIvqoat7hCDToEbgrjwCIWP5UTA9Q9F/WxA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GV2PR04MB12582.eurprd04.prod.outlook.com
 (2603:10a6:150:36f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:55:07 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:55:06 +0000
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
Subject: RE: [PATCH v4 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Topic: [PATCH v4 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Index: AQHdQEb6xjs22HKbP0S2BAvlX7IefLbHrFiAgAEFaDA=
Date: Fri, 11 Sep 2026 05:55:06 +0000
Message-ID:
 <GV2PR04MB117399C55C893D201E9B1A08088BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-4-wei.fang@oss.nxp.com>
 <178903925739.219967.16127084543279135513@kernel.org>
In-Reply-To: <178903925739.219967.16127084543279135513@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GV2PR04MB12582:EE_
x-ms-office365-filtering-correlation-id: 3c41936b-8529-43e7-4f6a-08df0fc93b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021|5023799004|3023799007|10067099003;
x-microsoft-antispam-message-info:
 EtWeC2zvTXZ4P7QK1vfGzTXdnsKqLTlwkxyA3Z9u/mEgV9cdoBZWx4Whi9qkLsKW7Z4NELT9kxxQgiSx4Qf9msiFbYNTYa/Ca/qkYPtCXJyGBX9gi5Ha9ha51IyvR91Xd73f7zjwXFV42TfiW56ZRNLKqkzNJ9hmEQi1ZuFEtSroF1j71eTStbHPY4sNEpC/qG4cUJNtDWoHldcCJ0JYcJ4vtLVjehjkL34MDu29gDW8wRAUpSgOgN1tLgNNFNNjSX87JA7Lo3HZ4akDXlrw44gnxHoq2SmurOM/gwMjiniW7JEZPyJGA72oPvcEr7INu1sVqIRvMB/EfBZvFDtnIJ9Lxa5ZlxicDVCD/0KCtfQTZ3DaLkKsr5v46J1GJpI3XxDnwbAZukpLtPAueMqjLdrQ3GN+lBigf3Dq/NQX+6h5bY0F6JAOTtBlZtB7P1adWXaGufeYSNHuckpySGMQgJzHgLv5CAWvw+PVZW/U8UOjJ8ih5oHYxNLqD9Prhdxb23MFtlDzWWNAnlffhJxEOJb/pPHn9Lfl+X3duX6Y/uzy6/kxwJ+4v+sDgejj35dXNpEV/twia+T9kqi23bHH7y3B8yKRZp8kFA2HQGOAN4Iv5e+j+kPEvIU4FEK21j/nekoOfscFUZOVzyYBrzDsEXYc7mrtvjq7+c4VhOHqBg1thQjpaDNbGrLFIE6B3Mjx/EiETjBOIIe7V3QZ5eRYVi+MJCMZeDMHtPOVigCWHMI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021)(5023799004)(3023799007)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G04b35VXV/fFr5+QCMf9+MOEX6YE1uh6bYmsCocTb2P4F/FCF7mlZgnZIm33?=
 =?us-ascii?Q?BDhnceTgT1abhaP46HyVm/xec87Z2SR3mv+f7phocZrztjr8AKKdU+Pb+h70?=
 =?us-ascii?Q?pkZNE2xBaK8kC1XGTndNoswSucCzuhESFqYUKmtxzWzCd+OlE6cdkZgRtB/i?=
 =?us-ascii?Q?wUWz2wAEoTjMm7zzEJstE8R4LlpH/dtBfz44209NoSW2YiBecAhqW4j/g2ry?=
 =?us-ascii?Q?j+X6GX3ePOqQOG90jxVg3VY0ct84ABrTAcSqgzcY+kUedxkZd1xxUOILw/bt?=
 =?us-ascii?Q?grDqBRgtiqp4kisUMiZwlgxoloDheX/kJG2JVMdCqYRkIBYVO1/ai0mufvmI?=
 =?us-ascii?Q?flUFLR+2ym0bUXaNU4ue9lVICKilDdStD5uLB6iZqsLOr087FVfxEaQ2VxGy?=
 =?us-ascii?Q?MMKeYkkDxZ2bi0qDHZ3sVeJoMo3FF9oOqI3xwrXqShh6vtBWiYyzm0ZLtG2f?=
 =?us-ascii?Q?ywO8jso8lp4CepztsMLDT6l4V8hJjj8nb/MTE9+fr6qANz5NfwDbKNM/qHnI?=
 =?us-ascii?Q?nZr+p80ZE9wOtpezHVc45lWVf4xrZbTEPC0+GPTQfTflF2cK0vavuV2pptjk?=
 =?us-ascii?Q?BSQdvW3k+VCpKvA6fshwJADhi7dNhSyD8y/gMzjyTjMBfHC1XlnBK+uzg4OL?=
 =?us-ascii?Q?3Q6auLHsxQ4x52Wh2Y8ddiulWrVE2yNkZZmv4a5ZercRUpUJgygD0H0p5aI+?=
 =?us-ascii?Q?jumjZmBHKqma3xVuVN5ef9R01BsVfdaPrCLilrjtYCjc4PgUpa595RAy0yeM?=
 =?us-ascii?Q?HEdnS7XVeEMPu1UnWSNrN+hqdAOCUL7K0inEn1tU00ujbEcq7VX2UQyiXmfL?=
 =?us-ascii?Q?6ec1HBUiQ+wUyldNnNcYJY1Eu2sHTZQJmM2B3K+g3pgNEvdVhXLgnVOU0t7X?=
 =?us-ascii?Q?3dsLh1xbe7i4Eqg7OFhSt8AjMBGmBSDoOCIxV/qv7lfssuhccn2FK++T0K30?=
 =?us-ascii?Q?7pHD825jhAdiQ29k0Ggezx03695rp7splo22TVuyQD2UKQd4790hJjxHGrW3?=
 =?us-ascii?Q?7/x9uWsjS3A2nnt83TRwr1qVGkBGdsef7aXzkBycmGD+bj2IKLu8Hv3xAHqk?=
 =?us-ascii?Q?GK1jMOqY0AVIvXM2++hA4wcOqunxZeyKAtp6eeMXe89S0QXIZMZfJC8uzScf?=
 =?us-ascii?Q?65V4aXcU9C+7GvM1H8g7l7g4WRrplVVw/Q7Dt0GOdVaoUvovfhN8XrYYFw63?=
 =?us-ascii?Q?mgvLGsnZtNG/rLIU0DVc1Va8rxFYtrUyw9UD+3Iiai7ogn2Hhb5hBzQRag3M?=
 =?us-ascii?Q?0G0eltqKh2jxp0/kfUcxpWc4+eNQHYccGx0ICQGN5LjubH2e28ICMabAUgFv?=
 =?us-ascii?Q?sWyaWKngBGdQ8C/4DS5Z3TIjrOYLsU+dcnLmLrNyL5UrePduhBLn2HssFaAw?=
 =?us-ascii?Q?mSwyHbFc/Gn6/TLIUuEGrdh789XOE+/8i/pos/RgWHYAc6H8nlGOXwwEZYKC?=
 =?us-ascii?Q?C3Kj+SpAs1VmC6pn/DmAiwP8O1OYOcREbzBw1odbSS8DfEYgYRT+sPDucBX3?=
 =?us-ascii?Q?tzUwzfynSLT3dXRmugTS9Rzi1Bbc4hDLdtoLX4mvqJ2SLP7Gk7PNiDzABKiB?=
 =?us-ascii?Q?3ML0sHNiaEoLVQxRFFfv0JxI1VXzo9MNKdXi0VeHegLKK39hChp0VW/kjJL/?=
 =?us-ascii?Q?xehbB/qCiXc0d9ttetxt8dEeKXPFqnr4nIAgN5eaUe4lVXuJhYxFgadeZ8Ad?=
 =?us-ascii?Q?qxpuc8t2yhoyyyS0m+ap69skg4WhGyz9bA7O9s5lDt3vI9Al?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c41936b-8529-43e7-4f6a-08df0fc93b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 05:55:06.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlIyT5KTflqqk+vH5au0ZawJ5XoqdiH4JULR2qFPI5K0Q/IwGjnPkSef3p6LoxlQT4X0BRwhmjPjVob0IS2hSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12582

> > +static void enetc_msg_register_link_status_notifier(struct enetc_pf *p=
f,
> > +						    int vf_id)
> > +{
> > +	struct enetc_si *si =3D pf->si;
> > +
> > +	spin_lock(&si->gen_lock);
> > +	enetc_pf_reply_msg(&si->hw, vf_id, ENETC_PF_MSG_SUCCESS);
> > +
> > +	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
> > +	 * need to set link_status_ms_mask and notify the link status.
> > +	 */
> > +	if (!pf->sriov_enabled) {
> > +		spin_unlock(&si->gen_lock);
> > +		return;
> > +	}
> > +
> > +	pf->link_status_ms_mask |=3D PSIMSGSR_MS(vf_id);
> > +	spin_unlock(&si->gen_lock);
> > +
> > +	/* Notify VF the current link status */
> > +	queue_work(si->workqueue, &pf->link_status_task);
> > +}
>=20
> [Severity: Medium]
> This queues the shared, VF-agnostic link_status_task in order to deliver =
one
> VF's initial status. Does that mean a single VF registering re-sends the
> notification to every VF currently set in link_status_ms_mask?

For a VF that has already obtained the link status, obtaining the same mess=
age
again will not have any impact, and the VF should ignore consecutive identi=
cal
link status messages.

>=20
> The retry decision in enetc_pf_send_link_status_msg() is made on the
> aggregate mask rather than per VF:
>=20
> 	ms_status =3D enetc_rd(&si->hw, ENETC_PSIMSGSR) & 0xfffe;
> 	if ((ms_mask & ms_status) && retry_num++ < 200) {
> 		spin_unlock(&si->gen_lock);
> 		usleep_range(1000, 1020);
> 		goto retry;
> 	}
>=20
> Can one VF that never reads its mailbox therefore add up to roughly 200 m=
s
> of sleeping to every registration and every link transition seen by all t=
he
> other registered VFs?

This situation will not have any impact; it will still send message notific=
ations
to the normally functioning VF after the timeout.

>=20
> The ms_status_check loop also advances vf_state->msg_fail_cnt for every V=
F
> in ms_mask. Can a VF that happened to be busy during a notification
> triggered by some other VF's registration accumulate failures it did not
> cause, and eventually be evicted from link_status_ms_mask?

We set the failure count to 10, and the device will only be removed after t=
en
consecutive failures. If this happens, it means that the VF is abnormal, an=
d
removal is the correct procedure.

>=20
> > +
> > +static void enetc_msg_unregister_link_status_notifier(struct enetc_pf =
*pf,
> > +						      int vf_id)
> > +{
> > +	spin_lock(&pf->si->gen_lock);
> > +	pf->link_status_ms_mask &=3D ~PSIMSGSR_MS(vf_id);
> > +	enetc_pf_reply_msg(&pf->si->hw, vf_id, ENETC_PF_MSG_SUCCESS);
> > +	spin_unlock(&pf->si->gen_lock);
> > +}
>=20
> [Severity: Low]
> Neither this function nor enetc_msg_register_link_status_notifier() reset=
s
> vf_state->msg_fail_cnt.
>=20
> If a VF accumulated up to 10 consecutive delivery failures under a previo=
us
> registration, does the first busy notification after it re-registers
> immediately clear its bit from link_status_ms_mask?

Yes, this is intentional. A normal VF can definitely process mailbox messag=
es
within 200ms; otherwise, it's an abnormal VF deliberately creating a timeou=
t.

>=20
> Later in the series the Linux VF driver unregisters on ndo_close and
> registers again on ndo_open, so the counter survives an ifdown/ifup cycle=
.
> Would clearing vf_state->msg_fail_cnt in the register path be preferable?

No, see above.

>=20
> > +
> > +static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id=
,
> > +					void *vf_msg)
> > +{
> > +	struct enetc_msg_header *msg_hdr =3D vf_msg;
> > +
> > +	switch (msg_hdr->cmd_id) {
> > +	case ENETC_MSG_GET_CURRENT_LINK_STATUS:
> > +		/* Currently, this message is intended only for
> > +		 * DPDK-owned VFs.
> > +		 */
> > +		enetc_msg_get_link_status(pf, vf_id);
> > +		break;
> > +	case ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER:
> > +		enetc_msg_register_link_status_notifier(pf, vf_id);
> > +		break;
>=20
> [Severity: Medium]
> This dispatch has no ENETC_VF_FLAG_TRUSTED check and no rate limiting,
> unlike enetc_msg_set_vf_primary_mac_addr() and the other MAC filter
> handlers in this file. The link speed handler added later in the series
> documents exactly this abuse class in its own comment ("A malicious or
> malfunctioning VM could potentially spam these messages in a tight
> loop...").
>=20
> The registration handler replies ENETC_PF_MSG_SUCCESS first, which clears
> the VF's MR bit and lets the VF post the next message right away, then
> calls queue_work() unconditionally.
>=20
> Can a VF assigned to an untrusted guest register, never consume its
> mailbox, and keep re-sending
> ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER so
> that the PF's single ordered workqueue spends 200 x ~1 ms sleeping on eac=
h
> invocation, delaying carrier notifications for the co-tenant VFs?
>=20
> The 10-failure eviction does not appear to bound this, since the VF can
> simply register again and restore its bit in link_status_ms_mask.

Link status is a basic, read-only, non-privileged capability that every VF
needs to report carrier state to its guest stack/containers/VMs. Gating
it behind trusted would break the common untrusted-VF use case without
closing any real attack surface, since mailbox spam is already bounded by
the idempotent work, busy-VF exclusion, the 10-failure eviction, and
rate-limited logging.

Furthermore, on the PF side, the PHY driver itself checks the link status
once per second, so the interval between two link status updates is at
least greater than 1 second, thus it will not affect the link status notifi=
cations
of other VFs.

>=20
> > +	case ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER:
> > +		enetc_msg_unregister_link_status_notifier(pf, vf_id);
> > +		break;
> > +	default:
> > +		return ENETC_PF_MSG_NOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> [ ... ]
>=20
> > @@ -340,6 +442,22 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
> >  	return err;
> >  }
> >
> > +static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
> > +{
> > +	struct enetc_vf_state *vf_state =3D &pf->vf_state[vf_id];
> > +	struct enetc_si *si =3D pf->si;
> > +
> > +	/* For ENETC v1, we only support setting the VF's MAC address via
> > +	 * VSI-to-PSI messages, so there is no configuration to clear.
> > +	 */
> > +	if (is_enetc_rev1(si))
> > +		return;
> > +
> > +	spin_lock(&si->gen_lock);
> > +	vf_state->msg_fail_cnt =3D 0;
> > +	spin_unlock(&si->gen_lock);
> > +}
>=20
> [Severity: Medium]
> This resets software state only; the hardware PSIMSGSR[MS] bit for that V=
SI
> is left set. The comment in enetc_pf_send_link_status_msg() states that t=
he
> PF cannot write the MS bit as 0, so only the VSI can clear it by reading
> VSIMSGRR.
>=20
> Is there any path that disarms an MS bit left set by a VF that stopped
> consuming messages, for example a crashed or paused guest, a VF FLR, a VF=
IO
> release, or a killed DPDK application?

Usually, the VF driver will perform FLR at probe, the FLR will clear the st=
ate.

>=20
> The commit message says:
>=20
>   "The link_status_ms_mask tracks the VFs registered for notification and
>    is cleared when SR-IOV is disabled."
>=20
> but a VF FLR clears neither link_status_ms_mask nor msg_fail_cnt: the
> enetc4_pf_vf_flr_handler() added later in the series restores only the
> promiscuous state. Does a re-created VF at the same index then look
> registered to the PF while the notification channel to it is blocked?

As clarified above, the VF FLR will clear hardware state, so the notificati=
on
will not be blocked.

>=20
> Two follow-on effects in enetc_pf_send_link_status_msg(): every later PF
> link transition burns up to 200 x ~1 ms of polling because the retry gate
> is keyed on the aggregate mask, and after 11 such events the VF's bit is
> dropped from link_status_ms_mask with only a dev_warn_ratelimited(), whil=
e
> the VF still considers itself registered because it was acked with
> ENETC_PF_MSG_SUCCESS. Should there be an error reply, a re-arm, or a
> periodic retry so the VF's carrier state and its RX BD congestion mode
> decision (driven by the TX PAUSE bit) do not stay stale until an
> administrative ifdown/ifup?

The link status message is sent proactively by the PF to the VF, not by the
VF actively querying the link status. Therefore, it's impossible for the PF
to send an error response to the VF. Furthermore, since the VF is no longer
able to respond to link status messages at this point, it also won't receiv=
e
error notifications proactively sent by the PF.

Recovery is possible if the VF actively performs an ifup/down operation.

>=20
> The later VF patch does drain VSIMSGRR in enetc_vf_wq_task_destroy(), but
> that covers only the clean Linux VF unbind case, not FLR or guest death.
>=20
> >  static void enetc_msg_psi_free(struct enetc_pf *pf)
> >  {
> >  	struct enetc_si *si =3D pf->si;
>=20
> [ ... ]
>=20
> > @@ -367,6 +487,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, in=
t
> num_vfs)
> >  	int err;
> >
> >  	if (!num_vfs) {
> > +		spin_lock(&si->gen_lock);
> > +		pf->sriov_enabled =3D false;
> > +		pf->link_status_ms_mask =3D 0;
> > +		spin_unlock(&si->gen_lock);
> > +
> >  		pci_disable_sriov(pdev);
> >  		enetc_msg_psi_free(pf);
> >  		pf->num_vfs =3D 0;
>=20
> [ ... ]
>=20
> > @@ -396,3 +535,114 @@ int enetc_sriov_configure(struct pci_dev *pdev, i=
nt
> num_vfs)
> >  	return err;
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_sriov_configure);
> > +
> > +void enetc_pf_send_link_status_msg(struct enetc_pf *pf)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(pf->si->ndev);
> > +	u16 pf_msg, ms_mask, new_ms_msk, ms_status;
> > +	struct enetc_si *si =3D pf->si;
> > +	int retry_num =3D 0;
> > +
> > +retry:
> > +	spin_lock(&si->gen_lock);
> > +	ms_mask =3D pf->link_status_ms_mask;
> > +	/* VFs have unregistered link status notification, return directly  *=
/
> > +	if (!ms_mask)
> > +		goto unlock;
> > +
> > +	/* The MS bit is set, indicating that the corresponding VF has not
> > +	 * read the last message, PF cannot send new message to the VF. To
> > +	 * avoid sending messages to such a VF, the bit corresponding to VF
> > +	 * is cleared from ms_mask. Because the MS bit can only be written
> > +	 * as 1, writing a 0 has no effect. Writing a 1 when the bit is
> > +	 * already set is undefined.
> > +	 */
> > +	ms_status =3D enetc_rd(&si->hw, ENETC_PSIMSGSR) & 0xfffe;
> > +	if ((ms_mask & ms_status) && retry_num++ < 200) {
> > +		spin_unlock(&si->gen_lock);
> > +		/* Wait VFs to handle the last message */
> > +		usleep_range(1000, 1020);
> > +		goto retry;
> > +	}
> > +
> > +	/* None of the relevant VFs have processed the previous message, and
> > +	 * the PF has tried 200 times. This situation indicates that VF has
> > +	 * malfunctioned.
> > +	 */
> > +	new_ms_msk =3D ms_mask & (~ms_status);
> > +	if (!new_ms_msk) {
> > +		dev_err_ratelimited(&si->pdev->dev,
> > +				    "All registered VFs (MS: 0x%x) are busy\n",
> > +				    ms_mask);
> > +		goto ms_status_check;
> > +	}
> > +
> > +	if (new_ms_msk !=3D ms_mask)
> > +		dev_warn_ratelimited(&si->pdev->dev,
> > +				     "Failed to notify link status to VFs (MS: 0x%x)\n",
> > +				     ms_mask ^ new_ms_msk);
> > +
> > +	pf_msg =3D enetc_build_link_status_msg(priv, pf->link_up);
> > +	enetc_wr(&si->hw, ENETC_PSIMSGSR,
> > +		 FIELD_PREP(PSIMSGSR_MC, pf_msg) | new_ms_msk);
>=20
> [Severity: Medium]
> Delivery here looks one-shot. Both the "All registered VFs ... are busy"
> path and the new_ms_msk !=3D ms_mask path abandon the pending notificatio=
n:
> link_status_task is not re-queued and nothing records that the excluded V=
Fs
> still owe a message, only a rate-limited log line is emitted.
>=20
> Is the ms_status snapshot also racy? A VSI clears its own MS bit
> asynchronously and outside si->gen_lock, so if a VF clears its bit betwee=
n:
>=20
> 	ms_status =3D enetc_rd(&si->hw, ENETC_PSIMSGSR) & 0xfffe;
>=20
> and:
>=20
> 	enetc_wr(&si->hw, ENETC_PSIMSGSR,
> 		 FIELD_PREP(PSIMSGSR_MC, pf_msg) | new_ms_msk);
>=20
> does that VF consume the previous message content and never receive the
> current link state? gen_lock cannot close this window because the MS bit =
is
> mutated by a peer PCI function.

This is a limitation; the software cannot guarantee that the VF will not cl=
ear
the MS bit during this window. However, this is only a theoretical issue. B=
efore
the operation, the PF has already waited for 200ms, which is more than enou=
gh
time for a normally functioning VF to process the previous message. Therefo=
re,
I don't think it's necessary to eliminate this theoretical issue.

>=20
> With the VF side added later in the series, a phy-less v4 VF relies
> entirely on this notification for its carrier: enetc_phylink_connect()
> returns without calling netif_carrier_on() when
> vf_reg_link_status_notifier() succeeds. Does a dropped initial notificati=
on
> then leave the VF netdev with no carrier until some later PF link change =
or
> an administrative ifdown/ifup?

When PF sends a message, VF will generate an interrupt for processing. Firs=
t,
I don't think the interrupt will be lost. Second, normal interrupt processi=
ng is
usually in the microsecond range. We have set the timeout to 200ms, so a
normal VF won't lose the notification. For a VF that malfunctions, we do no=
t
expect it to process notifications correctly. If it subsequently recovers, =
the link
message notification can be resumed using ifdown/ifup.

