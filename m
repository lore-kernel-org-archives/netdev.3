Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB13328E6;
	Fri,  4 Sep 2026 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503396; cv=fail; b=PzbUypGE8kB07Nnkxidlpapa1AkXgXBe0o2bkzN/XlkcrjDGjwH/UciYwyhhbE1xcTcHWaHKJQIJyngqaQ6ft7/7lHoGKFfd26o5TdKQWzSAIOny3EDRiUsvCplOOW3kFcPBkcQgUOKS/K7/4j+0ttP2k5lKsNu4Rm/TkUFc67c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503396; c=relaxed/simple;
	bh=FxU3c2+RMkXDKOpIAIagY/wK1lStnT28ho7JJpGNKtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5paK38Ck0yLLv7Dmx1GjwOPdJLoP9i6hZmN02KnH7OVWGbeZgf74HNsccPl1x7li2ZJGM/Nr/S3Z8mJyvEogiIRxpB7IQaLcq+gR1VeDNOMDb5PWL6jXfT0IloEHmp4/Fsjop9gn02Ki/LwreQ87nr9BlgurRJDOfsBhY2mUYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BcUBd9KN; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BcUBd9KN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2paS4rygorc1M6Kj95Bf09fxQawtIAyKnAx9BzquSUuGqrgACsHM1kQGOaZlOHopbpFQnDyz3lRuGdGic9KGMO2EirrcNIDSourhBD9X5XgblYkwj1CbOWcRbDpsX+YZIxFgjSwJaQK/eznQddCXu1usmeM7ueYllLefuh6JNd+FO5Q8uIRWutlgRWq9SoxyK9KLtR/bnShMM5AZM4w2Jy1SIUNbrNNtDOk/8hUCUxwXW2Qe/plpL0AGNUplQMj1+Xx98hi+X7xdRFyZqjggdSYZ5a0681ZH5fWHBPRqkl5bCc/yWovxafZFIzGD7gHo9QaDjbz4FxAg/n0ls8cDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twZqxhEnsLYzUmQ4lP8qcsQe77BaaZ17YUv1onMZHQc=;
 b=Xvc0dc0Vr3a9eo6B9TLKA2Mj0xbp9lh2iAc+FWMmaktk8qry0eLkFGzwB6CAOLfgBIRma+A2jeUATlMDeBquXHEbOYyrR72cCRi8ahmk/XIuaOEYfNYqIyxZAIiKH8+viR/XSBGIaXT4wz8tuL+ho7R9Nw86oN2g2mYqQSRCPEHu48t6/Ac3S6MTUs9gQSGZHoyhDQtfJDGMuiSloPJVeFHlWJ3qGlsxt2jrQsg3BDPofCJOXT6y3LFKr5hi1qoCSfKjoO/AcV8a8QLfFCVANQuErNWHmNaM2NYDquQUQVz83K63RmzEYWvIvQGTrc3PgU1XYVAOP/FfGjIvjLyfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twZqxhEnsLYzUmQ4lP8qcsQe77BaaZ17YUv1onMZHQc=;
 b=BcUBd9KNBxUe7kDWCvEFxXewgMJG3XbLspVgp/asIxBp2gkrajXvs8WOrDPLF1utI8VWif8/Tv1IAWANFlKRyWzjnlryO7joQs2czw7nSrrM+t6rDQP8j3lE0Q7xGPzdepuFnDTHIFEiEmFjCpayC4ENNpcAAHoO1j9QaVmzrBwMoWQKhZ/aEiatR2XU2KpzHADXV+ur53C+xjF2xiBw8GZT2kZCIeKefSsq5o/N1hf1et2/40V0vekVBKhPJzBw2LR8JAJfwT0/hcOyMLT/0t2JzY36PHaW/vIkhzd/29aBRr9NACJ2tq4rUJcA5jIa0IgU4zM5vaA0m5hZMEPBOw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAWPR04MB11646.eurprd04.prod.outlook.com
 (2603:10a6:102:512::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:29:49 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 06:29:49 +0000
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
Subject: RE: [PATCH v3 net-next 01/15] net: enetc: add trusted VF support
Thread-Topic: [PATCH v3 net-next 01/15] net: enetc: add trusted VF support
Thread-Index: AQHdOPfy3iCZeXJSl0qmUwc4NIN8uLa9iloAgAA/uCA=
Date: Fri, 4 Sep 2026 06:29:49 +0000
Message-ID:
 <GV2PR04MB117395B3F207A16CA15DE8A2488B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-2-wei.fang@oss.nxp.com>
 <178847906205.4131868.13793476911269935039@kernel.org>
In-Reply-To: <178847906205.4131868.13793476911269935039@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAWPR04MB11646:EE_
x-ms-office365-filtering-correlation-id: e4f9d323-f670-4758-d176-08df0a4debae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|19092799006|376014|6133799003|18002099003|22082099003|38070700021|5023799004|56012099006|4143699003|11063799006|10067099003|3023799007;
x-microsoft-antispam-message-info:
 TDk1I0mTCsxkaLhn3qbeIYxshk8Pugoyo9+3jmRdMOfWJFAbISx1cYr6HhyGu9SS6j9xxK6fZYjs6SFcCIrChIvGdKJaJXJOKN0iQuJlFk247HAhMb3h12KAocS8srz6MUz2+N8elPuw0xZjPuNQP9r2oHRDpxx7NgwEoq9ilpwmg8KEhyJvS676AFNN35r6n3Ia859O2DfMPMNgApYcWBhFMVTtlPmCyld+VeGbZpxhmvdK/SbFdORc722L8V8duXVs48t81yeVnLcW1HQn7ZHMpcOc7YtgR1u6kwtWdxJesGyCl8d+dvnmlX9W9/B3NGv3Tw0+I092qpucPmm5Aginir/nEdUElepPXMTHrRBAvUeHtqfguKf+3tmGiPmRHiZsoUGzNgHZnZc05GWrLD66sq14o6YUPxG4L/6fuPSViequ0QAasriGqDDKXo267GioyRzuil0QubHevocEFuqEndfpP6y9Pect96mPYxdinqGVLzwBJjIkg5M9EPSfTo2sp3S/3QCgvhbzCdELb/1xmad25yKWdCiLdC7iBRQj33Afe/aMv9PbbhGUbYPnJVVrH3lew17fuuneXEf4TFT9ot81x0pltkh3Qgk18USFnllhEunfKhsy59XY9opBWScPNvtHtSoSw3qzzsiLtVEDopQxz7XZQZgbItceIBMIFO8t3xFmLZz4C94H/nwiM8fY6De+70zQCt22iT28r8O1p4q8FFF7DXFrrolyxNA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(19092799006)(376014)(6133799003)(18002099003)(22082099003)(38070700021)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JIocNPUCI1kWJEW743mR4TX2A6O9Q/y/6DPXq+UOdtTWjd6wP7uhjvm0qjlB?=
 =?us-ascii?Q?xAw3RDSsN9kaDKsrYKydBrTZ2TV13X9foSvdyzSjwYHJmS82Mct8SgXaiM5e?=
 =?us-ascii?Q?YSleaGE+L90fjuZyKT2zM370KBkROWLXI1mbWJdQ5Phwgr52fVTh8H6NdyaO?=
 =?us-ascii?Q?q4WFIjVvIMHX4On1LGTer2+KK/9jOW7qF/bRHZ8JyjD2hpN2+wBkYn0qs1/S?=
 =?us-ascii?Q?+7QqJPY4bkeYrp6BnZE/C8kCnFJPgWCmG/2OI0mZXSwgiBp7fmI/tzKgTqHK?=
 =?us-ascii?Q?1iVyioo83mCsHjyE4KVmbXydUKEs+hvp9HVvQRiOhZSAYfysSmOxPuhShvdU?=
 =?us-ascii?Q?ncEhELOzJZKt0hlV7p0zRZWp9cm8Rd3shhgCwm985qfjo+ufP3cRc3Obejrh?=
 =?us-ascii?Q?iSUp+vzt2FHo40BDAm1dQJY2rsMy+IR3pKMsYgYAibPA5AmGqBalKhjJVJIj?=
 =?us-ascii?Q?13+p44Q/4/SoyEs0KHIbZYcvotUSY/zZDOApBAn3si08SrR2ug8+jhXaYMQJ?=
 =?us-ascii?Q?WnVrYE80FppaJHoFcR7cZBdGYkothCK8meM0U6IXA52QXLka14Z+oqevb7rI?=
 =?us-ascii?Q?RlGu80YvwgEc1wyDPa4Av9bko8+XYXxQlU725ATgEvNlTwI6g6VLA9D5YQ//?=
 =?us-ascii?Q?C+2cqUQM9I0PZUny/Jl/P1LhgMtoyjsUgAxt2EJYUxn2cUhpTW1pT0+bdSjS?=
 =?us-ascii?Q?atSkeAn5i/jkrYR/iuU/wryDcs7D4X/95R5Z0soaR8DFDMFCSa7vfeu2eP7V?=
 =?us-ascii?Q?t0c+Cjjo76/+AuA7Iulcn8k33cw7vdI6mOx4eApCQ//p1c6atgQ2gEoAHHoS?=
 =?us-ascii?Q?/yC7Q+fEs+4dOR+2QQ7mhOQ1sEJJSyFVcLhaU9iaSxr/YRQ8/nRZ14nFYQim?=
 =?us-ascii?Q?DF/bqYISUOKG1j2ZlPcOWYO9wznxXMofp+VlbvrLQgWjyXw3MJd2nBmzN6Bq?=
 =?us-ascii?Q?xqYAOB5Uxmmi8JMqXoG9snRxd/EZ25nEy0PW0RNLlFYFspwtiuxxrh/BfwH1?=
 =?us-ascii?Q?6QCASlxAjRgA1qYIO09b5KT2wsIANA/TB6/6wLr3OtiIFwCPD/IfNjJft4vR?=
 =?us-ascii?Q?t86BbxElx4kQeEPsNRCZUuae7taPUwdV0lBQJe6s92akK7M+Q9AsL5RLMmSx?=
 =?us-ascii?Q?qV1YC8rUgRlfMMk/HsMSApzK5s+sMYcEiRBx7oNNQzc5UryAxmddKamNBf9b?=
 =?us-ascii?Q?CI64KwRWZeJvaX0vet+zCuJ5yxYsF+YimuB/4NeOiShWUViohiWqsRNtEZaG?=
 =?us-ascii?Q?laVNyjwzKzViTec5/b4tIP27oHn+i27nWJjtadlg5juFJQ4SK7qql+FXvSW6?=
 =?us-ascii?Q?76Ia2FUZK23EMYxoxt277t8L+XXwIG7UcNFqXtMw/Js1tNSbPglWaUCnTI6R?=
 =?us-ascii?Q?JQf3cUqnfN4WKs6FoEDWAgWOgWoeEFdGZA4zkU0s68HqMsDg6TUb7KrS4iia?=
 =?us-ascii?Q?5G9RIHfNY9OSO52CKOAs7b6KwDoEx1g2eRNI2/AjYHdIP0l6TYAAPdIgYuRX?=
 =?us-ascii?Q?M7MVK+q7dkzdgbeehHu4QcJk9vM2zvM2isJnxIzmfLk/hjoHHK50/pxMVWfy?=
 =?us-ascii?Q?2c6weTjkCK7gyZlwKAawHhXBXGVSvgeMENhk8ktJ/IhW4e/Uhgk1LU+DmIPm?=
 =?us-ascii?Q?qXle/KfDPCj7HffUIgAzcE1IWf4VCNbpH7HJmj6DkS2xSN5zfh21WYCaIQaN?=
 =?us-ascii?Q?2v+wjjO09B9gzjzAI+8ssLGttQgt1T1aYbJvhFuBKn55iycl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f9d323-f670-4758-d176-08df0a4debae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 06:29:49.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eDznfaSQsRujuo4PxA8xMPuubZuMgdDlfIjcPLPK3+Uczy/NeIqIgtHRBEnK1xBLIrRIkhqCmY9Vz3inL2b9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11646

> This adds a per-VF ENETC_VF_FLAG_TRUSTED flag stored in pf->vf_state[] an=
d
> wires up ndo_set_vf_trust through the new shared helper
> enetc_pf_set_vf_trust() for both the enetc and enetc4 PF drivers.  The VF
> primary MAC address mailbox message is the first message gated on that
> flag, and untrusted VFs now get ENETC_MSG_CLASS_ID_PERMISSION_DENY
> instead
> of having the hardware programmed.
>=20
> A couple of questions about the trust flag lifetime and about the
> changelog below.
>=20
> The changelog says:
>=20
>     An untrusted VF that attempts to set its own MAC address will receive=
 a
>     ENETC_MSG_CLASS_ID_PERMISSION_DENY response and the hardware
> will not
>     be programmed. To prevent a malicious VM from setting the VF address
> to
>     the MAC address of other VFs or PF, thereby eavesdropping on the traf=
fic
>     of other SIs.
>=20
> [Severity: Low]
> Before this patch any VF address that passed is_valid_ether_addr() and th=
e
> ENETC_VF_FLAG_PF_SET_MAC check was programmed into the SI primary
> MAC
> registers, so the description matches the pre-patch behaviour.  Was a Fix=
es
> tag considered here, given the wording describes an exploitable condition=
?

No need a fixes tag, the intention of ndo_set_vf_trust() is a new feature n=
ot a
bug fix. ENETC v1 is only used on LS1028A, but due to the hardware issue (M=
DIO
issue), the VFs must run on the same OS with PF, so for ENETC v1, VF cannot=
 be
assigned to VM.

> >  static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
> >  {
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
> >  	if (!is_valid_ether_addr(addr)) {
> >  		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
> >  				    vf_id);
>=20
> [Severity: High]
> This gate looks like it inverts the usual meaning of the trust
> attribute, and it changes behaviour for existing VF users.
>=20
> In ixgbe/i40e/ice the rule is: a VF may program its own MAC as long as
> the PF has not administratively assigned one, and "trusted" is exactly
> the knob that lets a VF go further and override the PF-assigned address.
> Here both halves are reversed. The new check in
> enetc_msg_set_vf_primary_mac_addr() returns ENETC_PF_MSG_PERM_DENY
> for
> any VF without ENETC_VF_FLAG_TRUSTED, even when no PF-assigned address
> exists (ENETC_VF_FLAG_PF_SET_MAC clear), and the following
> ENETC_VF_FLAG_PF_SET_MAC test still refuses the request for a trusted
> VF - the new comment states this explicitly ("even if it is trusted").
> So trust neither grants the override it is supposed to grant, nor is it
> irrelevant to the plain "VF picks its own MAC" case.
>=20
> Since vf_state[] is devm_kcalloc()'ed in enetc_init_sriov_resources()
> and flags starts at 0, every VF is untrusted at creation. That means
> after this patch a guest that generates its own address and calls
> ndo_set_mac_address on the VF gets the deny class back, which
> enetc_msg_vsi_send() turns into -EACCES, and interface bring-up fails
> unless the host has first run "ip link set ... vf N trust on". That is
> a visible change for setups that work today, and there is no Fixes tag
> or mention of the compatibility impact in the changelog.
>=20
> Was the ixgbe-style rule considered instead, i.e. allow the mailbox MAC
> change whenever ENETC_VF_FLAG_PF_SET_MAC is clear, and consult
> ENETC_VF_FLAG_TRUSTED only to decide whether a VF may override a
> PF-assigned address? If the stricter default-deny is deliberate for
> this hardware, could the changelog spell out that untrusted VFs can no
> longer set any MAC at all and that trust is now required for what used
> to work by default?

This behavior is intentional, and the compatibility impact is minimal. A fe=
w
points to clarify:

1. No bring-up regression. The PF driver assigns a MAC address to every VF
at probe time, so each VF reads a valid address from its own SIPMAR0/1
registers via enetc_load_primary_mac_addr(). Interface bring-up (.ndo_open)
does not send any set-MAC mailbox message, so it is unaffected. Only an
explicit ndo_set_mac_address (a VF trying to change its MAC via mailbox)
is now gated on trust.

2. The default-deny is deliberate, not an inverted trust rule. It prevents =
a
malicious VM from setting its MAC to that of another VF/PF to eavesdrop
on other SIs' traffic, or from spoofing a MAC to bypass security policies. =
So
the two gates are complementary: untrusted VFs cannot self-assign a MAC
at all, and even a trusted VF cannot override a PF-assigned MAC. This is a
stricter model than ixgbe/i40e/ice by design, which suits the ENETC SI
security model.

3. Impact on existing SoCs is negligible. Due to the ENETC v1 MDIO issue,
ENETC v1 VFs cannot be assigned to a VM, and the v1 mailbox path is
effectively unusable downstream. This change is primarily aimed at the
upcoming ENETC v4 VF support, so it does not change behavior for any
real existing deployment.

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
>=20
> [Severity: Low]
> At this commit neither enetc_ndev_ops nor enetc4_ndev_ops provides
> .ndo_get_vf_config, so rtnl_fill_vfinfo() emits no VF info and the trust
> bit set here cannot be read back with "ip link show".
>=20
> This does get resolved inside the same series: the later commit "net:
> enetc: add ndo_get_vf_config() support" adds enetc_pf_get_vf_config() wit=
h
>=20
> 	ivi->trusted =3D !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
>=20
> and registers it in both ops tables.  Would it be worth ordering the gett=
er
> before or together with the setter so that no intermediate commit has a
> write-only trust attribute?

Since these two patches are in the same series, there is no need to put the=
m
together.

>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > index d32a195a04c9..519fc90d2647 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > @@ -586,5 +586,28 @@ int enetc_init_sriov_resources(struct enetc_pf *pf=
)
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
> >
> > +int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool settin=
g)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct enetc_pf *pf =3D enetc_si_priv(priv->si);
> > +	struct enetc_vf_state *vf_state;
> > +
> > +	if (vf >=3D pf->total_vfs)
> > +		return -EINVAL;
> > +
> > +	vf_state =3D &pf->vf_state[vf];
> > +	mutex_lock(&vf_state->lock);
> > +
> > +	if (setting)
> > +		vf_state->flags |=3D ENETC_VF_FLAG_TRUSTED;
>=20
> [Severity: Medium]
> Can ENETC_VF_FLAG_TRUSTED survive an SR-IOV teardown and be inherited
> by a
> different VF instance later?
>=20
> pf->vf_state[] is devm_kcalloc()'ed once per PF in
> enetc_init_sriov_resources(), and the disable path in
> enetc_sriov_configure() does not touch it:
>=20
> 	if (!num_vfs) {
> 		pci_disable_sriov(pdev);
> 		enetc_msg_psi_free(pf);
> 		pf->num_vfs =3D 0;
> 	} else {
>=20
> So for:
>=20
> 	echo 2 > sriov_numvfs
> 	ip link set eth0 vf 0 trust on
> 	echo 0 > sriov_numvfs
> 	echo 2 > sriov_numvfs
>=20
> vf_state[0].flags still has ENETC_VF_FLAG_TRUSTED set, and the newly
> created VF0 (possibly assigned to a different guest) passes the new gate =
in
> enetc_msg_set_vf_primary_mac_addr() straight away and gets
> enetc_set_si_hw_addr(pf, vf_id + 1, addr) executed for whatever address i=
t
> asks for.
>=20
> Related: the bounds check here uses pf->total_vfs, the hardware maximum,
> rather than pf->num_vfs, so trust can also be recorded for VF slots that =
do
> not exist yet and takes effect as soon as they are created.  Was that
> intentional?
>=20
> Later in the series enetc_msg_clear_vf_config() clears only the UC/MC
> promiscuous bits and carries a comment saying TRUSTED and PF_SET_MAC are
> intentionally preserved, and it returns early for ENETC v1, so the
> carry-over is still present at the end of the series.  Would clearing the
> trust bit for all VFs on SR-IOV disable, as ixgbe and i40e effectively do
> by reallocating their per-VF state, be preferable?

This is intentional by design. The ENETC_VF_FLAG_TRUSTED flag is decoupled
from whether SR-IOV is enabled - it can be set even before SR-IOV is enable=
d.
This is deliberate: when SR-IOV is later enabled, a trusted VF can apply ce=
rtain
configurations right at init time, instead of having to wait for the user t=
o enable
the trust flag on the PF side first.

The persistence across teardown is therefore expected, not a leak. Trust is=
 a
PF/host-side administrative policy tied to the VF index, and the host alway=
s
remains in control. If an admin is concerned about a VF slot being reused b=
y
a different guest, the correct action is to explicitly set that VF back to =
untrusted
via "ip link set ... vf N trust off" after disabling SR-IOV.

The total_vfs bounds check is consistent with this model - it intentionally
allows trust to be pre-configured for VF slots before they are instantiated=
,
and the array is allocated for total_vfs, so there is no out-of-bounds acce=
ss.

So no fix is needed here.
>=20
> > +	else
> > +		vf_state->flags &=3D ~ENETC_VF_FLAG_TRUSTED;
> > +
> > +	mutex_unlock(&vf_state->lock);
>=20
> [Severity: Medium]
> Does revoking trust leave the hardware MAC filter behind?
>=20
> While trusted, the VF can install any valid unicast address, including th=
e
> PF's or another VSI's, through enetc_msg_set_vf_primary_mac_addr() ->
> enetc_set_si_hw_addr(pf, vf_id + 1, addr).  This path only clears softwar=
e
> flag bits, so after "ip link set ... vf N trust off" the SI primary MAC
> filter still holds the address the VF picked, and the now-untrusted VF ke=
eps
> receiving frames for it.
>=20
> There is also no saved copy of the address programmed at probe, so the
> original value cannot be restored.
>=20
> At the end of the series the untrust branch clears UC/MC promiscuous mode
> and the hash filters (and skips even that for ENETC v1), but still never
> re-programs or clears the primary MAC.  ixgbe_ndo_set_vf_trust() and
> i40e_ndo_set_vf_trust() force a VF reset on a trust change so the VF has =
to
> re-negotiate its filters; would something equivalent be appropriate here?
>=20

No fix is needed here. This follows the same intentional model as the trust
gate itself.

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

Unlike ixgbe/i40e, ENETC does not need a VF reset to regain control, becaus=
e
the primary MAC is a single per-SI register the PF owns directly, rather th=
an
something re-negotiated through a VF<->PF protocol. Clearing only the softw=
are
trust flag on trust off is therefore sufficient and intended.

