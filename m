Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A49305E1F;
	Tue, 18 Aug 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035140; cv=fail; b=GEULBVPBPRbWTd40PMFBbi+yiQWlKgDh031zs/XpzWQZ9GBqDidE7PQKTTGhCF5ZbgsnQiKTgKp41IqGi5LC5pzPdQYthoNyu7ao3Cmxruz99AFXc25USjOptrrntvRDsXphzmxog2qEVypBre4PD9HFD38Ua4QH7wwQF8bc7m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035140; c=relaxed/simple;
	bh=4Q4xK6jXwRBkPWXEl3P7gmnRI4GGUC+qi81We6YaiN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ol1anVreo7A1awNOOJJ4mgCXc05B2v3upVlR/gy0VwuwG5WxEhVrD1Ln+1LCDu/biqmQePmAMsTyFuig8T2094CiOP/mFPV+odbiBkmOqX5RPIQUhsiU3T3IUyVVY9OwgIyGMPH+JOJgb5GqDYjDC03l4RucJkgv018V4vZTTTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=oFCdscQq; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="oFCdscQq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIE/65oqKkNfWPskg/wLdE/1GVjUTrLBR6fU9u0p5KzKBMNMYAPdOEJZa4Tz06+YRX7s5iql/b4K8iNikODlVaNLy3hgsVDLakCSanXemrBW3Vi5w7ou6RT+Tym8pQbhCIWICHz7ZU2doWZZAMjR7i1B3CbISeitjYPSU0IFxydYWRQRAz/3mZ0AGmKq4hiIsnM6uADDAhd0Tm32BtRuE8r++7mGVktH48+d+ySz88IbuVJhaBuJt0pPwSZP6Py2bpS223qPcXmO2e0RIxGhcRZAyE4YXqXxtJ6O70/ZIasHQ7hEXmv3H1ozVd9wMrt2I9Gkh1p0RlWyOLsSdpiZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJAMXCSc5omj3Mu2OIiw4d/K0Buo5IIG25NyuiP0W7U=;
 b=yZQY1k9Bv/Kv8UdS3KrpEQcOgxum8rgTZAp2vyHVSAI0TohU1hdc9HeXHEK7BmGWYG7N+ZdX9BxehN0loYYqv5sAhcQbmwV6gWH223rUX2QfPTZRWG+dtJRpog9btsCY1goxc9YootaQYe/uNByYQrgIQbsZ3busQH3rcIC6ORz4JR1tyT2X/sXAAlSSIh+D4AUCErWmqLsjDc4Ra7v3uB1RprZG6/XzSzjPYiZaTnmfzdwhbZhE84uD0++qbzqPrhRudSOY9SALpqeHxLaylN5XGjMo8ylXOARj7JjBb8cYgybh75RceO+7M1ZHpMF+YdN+zMRBBAin0agN+uYfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJAMXCSc5omj3Mu2OIiw4d/K0Buo5IIG25NyuiP0W7U=;
 b=oFCdscQqsNR6j3ga2B8bBBfve8dduOIdK9MoxKiSOL32G8A0UMgX91aHJQdjAWrO8JiBJzCTE7ye45eYY8QEOV/FxQAXgZKFiJn6RKTUcS3KJtAXIarN0UTF6jbkCVCBawpeNCwoP5v3/rRyVOinMpFvXTcSQWJZeeoc/zss4c0=
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com (2603:1096:405:20d::9)
 by TYWPR01MB8622.jpnprd01.prod.outlook.com (2603:1096:400:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 18 Aug
 2026 06:38:52 +0000
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a]) by TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:38:52 +0000
From: Michael Dege <michael.dege@renesas.com>
To: Michael Dege <michael.dege@renesas.com>, manushprajwal
	<manushprajwal555@gmail.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Thread-Topic: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Thread-Index: AQHdLCAiwvsD/tMOfESV4bKJu79G6LaiOb6wgAEmEeA=
Date: Tue, 18 Aug 2026 06:38:52 +0000
Message-ID:
 <TY4PR01MB14282E215D9974C38AEE2078B82A62@TY4PR01MB14282.jpnprd01.prod.outlook.com>
References: <20260814190423.933-1-manushprajwal555@gmail.com>
 <TY4PR01MB14282E65E2588C32576740C5582A72@TY4PR01MB14282.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY4PR01MB14282E65E2588C32576740C5582A72@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB14282:EE_|TYWPR01MB8622:EE_
x-ms-office365-filtering-correlation-id: 0c5cd453-ed35-49d4-4bfd-08defcf35e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 HDNDr1TGikHdK4JssA4TO7EFWMp/3ebIyKWFa8Sagb6R0BJhUEXNuC2SocQAXOd/16ouK7u+CzOzAdZ87Qn3uJydRnZ38iseao0kseeJrA3sO+I/doHzE0Qi2F4RYN7JmfuuO4EG0VB+oseT9LCVeUYP4N25nvOaZQ+rFROKYLL7m7jt4oVieRbiYwDBudiwV3Av67E9fluAxlGkOqc3JMSPwyFspEjg8catCzpWoyYNrkJLPV+ceWtXSJgKaB/8nkncMYDSc4a29FTMyc9Or6UcP+vSU/P/XsawFl9U+fP7EpdcJLnKoPZoYIo9p6lH1NsISKvDVrOGPSDJco3QHh0cduLt2VqeX8/fzjbqTcMZ4R/3V4MuyPZFSTwmiz3pxMBViZiKlWFrrB1UwljrmBCfYn2zQARqUaMT1hcuNV0lrCIoTfM3BhEn+bI9jOuhDtFfFfVJEP3OuOgalJCeaOC7EXVD20BAfvFTkyPpMaaMJIopbnJjAqkr+uMzPqNtrHRLzjcGMLYN5CNWeEbPLggZj42dQ1L1NgEkKf0hJV9q+yqTR+54+VGwNn1uvo5g1OT4pAQ2GhsdhPximlU/rkreoKRTk0gt2sL3wKE7eKUZez3O9pPZUvqeoXANdUUsnmRzgclN+gAQ2CJROTxxQGX7sL8gXsiLS/EqN+mTNvdB4cf/0y9vlMTblf8lRmY/qwnD6azy2sfxhNJfBmZSNIRMVeGUKpM9YSiqspDI/6A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB14282.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wWco99TPNHgZ9Im1YQVI6env1v5GpbeOQlA0vbjPqviB0+U/2GZtf7CP0hvc?=
 =?us-ascii?Q?Je1tneYVbvngsbBawUyBBd2COwe4H87+a5pTtX1nFDiyXhbT91a17hJ3Hd0v?=
 =?us-ascii?Q?kSmybnvJf4jXAmNTXMeO2R1P7LgDq9yQTdjbuxEeeIWzP8JpKVPpre0BVFju?=
 =?us-ascii?Q?vtnbxcaiO6OE+kQUj4+fLLjnPv+2kMQgERoUHECwEYFJgLkNv1RfEvuewdss?=
 =?us-ascii?Q?nfAduAOK5UGNVaNhA2fpC5uIqFsOqyU9KYYcb3CSRLmB30YEpXCJdlnidFNw?=
 =?us-ascii?Q?M2y/c4NN0gcU4xyZnkc3Y+r3I8fu8RSJN11zbJSVCzku7qEoMZQyeVJC2aa+?=
 =?us-ascii?Q?Hg8/Mw0SNixwmqJe1Ne4Agsz2KwzOUviYHyFHS13qhAvbmIQ2jf69rRrCTEb?=
 =?us-ascii?Q?d+rTjZjPBB7WtYrk2K+k9weeT3I44Ry4xtcmPWo5dURJgMGw6G4kL4pYfRP1?=
 =?us-ascii?Q?jUB8s84TeaGM9ALSFpfD8NZJesWsPO2VPt8UD0b/NdtOqYCTKVDjH2qGt1uS?=
 =?us-ascii?Q?0R50M8eQQQBZge+3YmaepFONcLzqbI18WZ1E3IKbABnl2h/wM09wSZDRnLwY?=
 =?us-ascii?Q?kIHCLPAau6ZwR7c8SMigsAjATdHrnBB0gY2RcnSoCZO+E9uqTiMbHQJLZkdG?=
 =?us-ascii?Q?zxtkJgHLlV7OFe8yS9Ql6ZqScDQqd14QAnnAf1ny4Yb9o8UwI2ZpiZvYVEy5?=
 =?us-ascii?Q?6dwo2kmsLw1zhq9+WqX+MUcxfEFP8y15CDp7acvFuZ0SVADKMSJ4T3d//rlM?=
 =?us-ascii?Q?8qNprTrWGN2vDM//1dk2S6m4MltzM+epA5s3LoTHK7ZaD8VBlcpzL66MwpY8?=
 =?us-ascii?Q?GxpYzAA0pSziI+wy9ZhN+RgTmgGbpR3sNPAEJbZGZNHd5d1MWkBDXbGwB95j?=
 =?us-ascii?Q?qRfaKPphTULJrx12uhpiIrHCPUZRhVXIOBPJQQp7HkohxeKlWagk22y4NNiZ?=
 =?us-ascii?Q?7YWTM0GoC0wwEtcNjFsLyjp5/vJCbJlTZpZaGVztAwtLnlv7vCQXXUfBOfuJ?=
 =?us-ascii?Q?BXx46nbMFHpB7sWXJ2ioBc/4GuCvCuKk2/ZKeBC4VOgMvWQ43P2oC6QCVoAs?=
 =?us-ascii?Q?Qhne2JEz+l0d8Idj6cGtJxHreBPAOKJYc4h1TGobW5Jw2cTW3AgkBJcpD+iV?=
 =?us-ascii?Q?q4KFWHuQJfDYXbxZoQPvoSRCrHPg2ywAy//5sFRW3gR4BG2UrWccdlQlwVhK?=
 =?us-ascii?Q?aO3/I1yScolYpIqIUe/e/v2Jz7H7ptnBIC0yD9UGvSFDDqYjaiI9w7gQbc1l?=
 =?us-ascii?Q?cd3Ccfy2cjj8rgNRbRcPg/OjDNLdcnk8oQucjzGX0cvFFlqLa/0o6IMQWiUy?=
 =?us-ascii?Q?FodFTUbrtTsrCzGhrfKgPNt1Nu3LLcEDiMaJzivSUjzY0ccujynPVYyXE06D?=
 =?us-ascii?Q?0SPP0ZzmoTnApuGBvZeqrblOspBgXHWr1uv9yjWi0l6nXJHLJri5pitmd4nN?=
 =?us-ascii?Q?7oO7VwFVihwL3EA2EUKMUm8X3IRXyDdl05RTWWJIrZMPT5WubIlU6QgIIPON?=
 =?us-ascii?Q?UAGMFpIyOOHkrKwPVqvzd96ildFyO2TIdQ57mTvZG455uI9OLRiZl71rEd/1?=
 =?us-ascii?Q?UyNZxPQjb4pQVY1PVUKJY7FnN+3kIV0m2hNCbtuHOH0aTwvBzbixHgWP3prc?=
 =?us-ascii?Q?3USpHTAG1P70iL1i5eRVUSTUI1SmcuByva8bP4q/nq33VAR+2FKxC1x3dEzt?=
 =?us-ascii?Q?Q5G3N/1QgjEMB1Kb9NsnVedJvFrsmI6IUtAsBMydn0n/wBw5VewlQVc+eWVx?=
 =?us-ascii?Q?yBmT3sY6ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14282.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5cd453-ed35-49d4-4bfd-08defcf35e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 06:38:52.3561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7A0ImEAQWqDNVKNUBZhEFqn+TPgN9q7c/G0b5iD57Vg7t6D9hT+WX6JSPMO1VJNTg/q/qVA7xUe2cU79dr8YI+ul3ZJeTFLoU65mHlZMZZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8622

Hello Manush,

Here is an update on v2. I tested it on S4 hardware and it is working fine.

Best regards,

Michael

> -----Original Message-----
> From: Michael Dege <michael.dege@renesas.com>
> Sent: Monday, August 17, 2026 3:12 PM
> To: manushprajwal <manushprajwal555@gmail.com>; Yoshihiro Shimoda <yoshih=
iro.shimoda.uh@renesas.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; davem@davemloft.net; Eric Dumaze=
t <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev=
@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org
> Subject: RE: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node =
refcount leak in
> rswitch_get_port_node()
>=20
> Hello Manush,
>=20
> Besides the problem mentioned previously. The links on the interfaces do =
not come up.
>=20
> > -----Original Message-----
> > From: manushprajwal <manushprajwal555@gmail.com>
> > Sent: Friday, August 14, 2026 9:04 PM
> > To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>; davem@davemloft.net; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> > renesas-soc@vger.kernel.org; Manush Prajwal
> > <manushprajwal555@gmail.com>
> > Subject: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node
> > refcount leak in
> > rswitch_get_port_node()
> >
> > From: Manush Prajwal <manushprajwal555@gmail.com>
> >
> > On an of_property_read_u32() failure, rswitch_get_port_node() set port
> > to NULL and jumped to the out label before releasing the reference the
> > for_each_available_child_of_node() iterator was holding on it. Once
> > port was overwritten with NULL, that reference could never be released =
since out: only put "ports",
> the parent node.
> >
> > Rework the function around for_each_available_child_of_node_scoped()
> > instead of adding a manual of_node_put(), so the iterator's reference
> > is dropped automatically on every exit path. Since port is the
> > function's return value, take an explicit reference with
> > of_node_get() on the match before breaking out of the loop.
> >
> > Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> > ---
> > v2: Rework using for_each_available_child_of_node_scoped() instead of
> >     a manual of_node_put(), per Andrew Lunn's review.
> >
> >  drivers/net/ethernet/renesas/rswitch_main.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/renesas/rswitch_main.c
> > b/drivers/net/ethernet/renesas/rswitch_main.c
> > index 6fe9648163..ffdc42f430 100644
> > --- a/drivers/net/ethernet/renesas/rswitch_main.c
> > +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> > @@ -1303,8 +1303,8 @@
> >  /* Call of_node_put(port) after done */  static struct device_node
> > *rswitch_get_port_node(struct rswitch_device *rdev)  {
> > -	struct device_node *ports, *port;
> > -	int err =3D 0;
> > +	struct device_node *ports;
> > +	struct device_node *port =3D NULL;
>=20
> Here you declare "port"
> >  	u32 index;
> >
> >  	ports =3D of_get_child_by_name(rdev->ndev->dev.parent->of_node,
> > @@ -1312,17 +1312,15 @@ static struct device_node *rswitch_get_port_nod=
e(struct rswitch_device
> *rdev)
> >  	if (!ports)
> >  		return NULL;
> >
> > -	for_each_available_child_of_node(ports, port) {
> > -		err =3D of_property_read_u32(port, "reg", &index);
> > -		if (err < 0) {
> > -			port =3D NULL;
> > -			goto out;
> > -		}
> > -		if (index =3D=3D rdev->etha->index)
> > +	for_each_available_child_of_node_scoped(ports, child) {
> But here you  use child.
>=20
> > +		if (of_property_read_u32(child, "reg", &index))
>=20
> Same as above
>=20
> > +			break;
> > +		if (index =3D=3D rdev->etha->index) {
> > +			port =3D of_node_get(child);
>=20
> Here too.
>=20
> Best regards,
>=20
> Michael
>=20
> >  			break;
> > +		}
> >  	}
> >
> > -out:
> >  	of_node_put(ports);
> >
> >  	return port;
> > --
> > 2.46.2.windows.1
>=20

