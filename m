Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010038.outbound.protection.outlook.com [52.101.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10663A872C;
	Thu, 13 Aug 2026 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625555; cv=fail; b=N32crDe3lokArIjQ3Bf6s8Xn0QCRbkgUo/z34BcFQnsrYHBzYqy0FNCRAsBAojz5SIWpBcNUedc71clboJnBX4sAN1MFrkufuoCK69xhT6EFn2zs7XMydfPO0AMPrlz5ZWg6CIipfpKPN6pGuaapFOj1OcAu1GaWG/0MLEtgVJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625555; c=relaxed/simple;
	bh=4cHiwtu3KSAvYWSIXlzQyBZ0J01yCAxiSLPOKJUFhIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W2vujirl9fM6ArdPUNC8HxDuNS+RAdn5C4ROAy6MNGmZ5rBLnhMOxIPnQuuWDgNg6YgCmHdpzKHIYMYwra9MQ0c1/sy0BGhIh9ITevPtkztM161lTfnsQ3da+JyEUaqkBhzR4sUqC2QDRtejdaDa1yWVnVV3yrGPO8j1cW2kY6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=MCkbTI8s; arc=fail smtp.client-ip=52.101.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="MCkbTI8s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtUDmlZBSadaJ+RS2SXIn9Aai0fktzmLaKUwcJhWR7k4i1ca5lFBWEjhOgeQpUzBwYMI2aAtOBr4rbq+rf1PQhU4eItVl/+NKmVzKR6tSobUIhKQDh96VWHg8vcOZRJ4zQubcyII0BVkbKSLPkmzgBO6jcBHTKnWzjIe00CgeqaOQoMPeM4nZF3xXfq0hvK5nd0nI0MBubxhzTL/qdS6qutkkx3wckIXoU9fVoQceaBc+we+1P1k1ttLDoNhHGSE2BpI2lV01Iis77oXzoIupUWrtGv2nSPCHx4HI2ssosVC7XjmSJmeZHp4vU1kRmy7pxyK0qISvGGpsofk5XnC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR1D0hwJIw+iXnMHIRB+UFNqWuArkC/LgssZgrGd+TU=;
 b=pHfi311uBUoDyK1yK15gZbdeQE8DcB4rOgSStaByjXsLWlnJMzuEI8ss9da01TE0g/NIwmfM4iDnYDZdFjD3Z8thrg80HS1kLhvjq8+FL0gUiDMXUX+08kySBtIWgAHIqBM6Lh+Gm3ujsEP9X861v4td190r+Mf0BleemGCsQWCuo39Wv0lkJ/SP65HPScbHiptzt/u3chFKel4+4D7JjPssPEFlHIxJtnZNFokw2Tn67WpJeYCmqKUGicxhZt7cWc1bSLM9A/m45CGLt3Rvq1eJEMhxi8vBgFxiPxx9IsnLrCXHXhofwcibvjoYoxrKXsawlFmDoSLQjImievZH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR1D0hwJIw+iXnMHIRB+UFNqWuArkC/LgssZgrGd+TU=;
 b=MCkbTI8sFwdh79+IVbRHHwtL1Bt6yBbsJ/e8nnM+Y8y/aFndbcvIgLl+3Vx4IG5gVAjQCYinV9QOWPrfml4SKDwT/Q3aWOAhEEp9utYGBZKnspne+tnIBPyBm1mZ+t+8B4dBiEt7cCIAf4pOf8FXZwqHYRrNrDp2zKuA6rINoMk=
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com (2603:1096:405:20d::9)
 by TY7PR01MB14890.jpnprd01.prod.outlook.com (2603:1096:405:257::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:52:30 +0000
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a]) by TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 12:52:30 +0000
From: Michael Dege <michael.dege@renesas.com>
To: Manush Prajwal <manushprajwal555@gmail.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] net: ethernet: renesas: rswitch: fix device_node refcount
 leak in rswitch_get_port_node()
Thread-Topic: [PATCH] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Thread-Index: AQHdKxVXWzFzcTFezkGi0WwAiSN8jbab7DKAgAAB9BA=
Date: Thu, 13 Aug 2026 12:52:30 +0000
Message-ID:
 <TY4PR01MB142827A7ECFF24868A008BAA182DB2@TY4PR01MB14282.jpnprd01.prod.outlook.com>
References: <20260813111121.1672-1-manushprajwal555@gmail.com>
 <TY4PR01MB14282B3217D649F712BAD67BB82DB2@TY4PR01MB14282.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY4PR01MB14282B3217D649F712BAD67BB82DB2@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB14282:EE_|TY7PR01MB14890:EE_
x-ms-office365-filtering-correlation-id: 92e2e61c-b601-4cf9-373a-08def939bc6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 gDLGVVTBJzU91brkB/lHjcrMbvLVYjAjXaqT3Z2yZ6l0s3brpOieVo6mzkJ0Aiicx1EPki+VG4NMqiTzdk/jT6rHP2848BNqiPSQC/10hj83p+ObNvfysQEKPvuVl2NTelsR69r/bLbuDlYbbpwXQL99Zur/rTyphphOg9sDe6yzZ/vyTGYMDXI+6HLM8+VCS8itRsdohERTZE39X7gQlxHm6TG7vHCcF4YN3aaxe+UuwUb5iF7bXZC47HY+7H/bH5vNH8d9oBWnadgIC4ynB7IbTHrY+bZOdlg2oh11+kkCzbuaPHH1vz4+NzNby79/ETxoZxzb9zUaeWvDd1Nlk/ft8B4eSgDcEg5Hu9TWPYzy5gkjSV1W+sZnVTbAn7Oqz2TlwEl0u8iSbi4NcYuNIwcBtZ1yeT9YB4sTCL3su2bTptkF/dh3opEXbHcWp7yOjsAmZGK9gyojuT2qXBjonx8J6KU+6GpycSQ1pE8OydmHm1B3MiV95iUhWmJ+TCsYqcTFSBQNsvGHI/h3MIgOwm8Y6Kr7obK1Ua5KjagL2cn3ELQkw4w1ZOJVodpfZ3/Co9UWAGRDcurr2DqF2nO54sCADGoMMXm8vGFTX4brk8v4ZkzPPVmriIipgg601iFuxMLSCxkKlHhYvzE2Lfh6aTyJKxUkXYRWzoPFnnhHqs6MtlKp0Zz5MB/6bVYGok00sUzZ0f5qpM6y6Y+GH7Q1wg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB14282.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F8bS4y9BPFs1CjduWv2LVSN7TYJwYIxAMBuAJxO2Rq/MUB4L+PSh1m/v2beV?=
 =?us-ascii?Q?PGYV0lD1IX+VmGkiNwyiTr/qKYjhlC/yaMDpLHDUtK/VBWfYjEBBNgQHWT7I?=
 =?us-ascii?Q?WVaZ6X5L9BylnMSUj6UcQNdT8LJhOmPnkjNPnHwP+15mcyorSvI2jtX7euOV?=
 =?us-ascii?Q?N2+WKzCty68Gxq344Z6/GoeXClBh48EnDjQx6PaMniwUFQ0Ic8nw53AcVWoz?=
 =?us-ascii?Q?AH7XuJNzUf2zOaNkRKo+hRnqkncteFEToeZUTvHE0OJzZMcQ6tIcJeTaz2wl?=
 =?us-ascii?Q?3eCo/v6L6ghLqFPX1S/3l3PwifbO/7zVuBXdiX6k380ZYeXDQMDhktP6M91L?=
 =?us-ascii?Q?bATQhv3oLbTBxiGXcEiR2Muuu8j6c7sK1NwPAZ08TxuK9PLicNcD6BezRsX/?=
 =?us-ascii?Q?YwML0cbw6CLHwL6KwTXT6fnTrITy9XehJ1TRUy3huYluQawBqaYJ6mD2RDz8?=
 =?us-ascii?Q?51gD+KoRSX0JviaDD6CzlXB5rSdU8lawwuhb4kvi8E3HtFIqGN7ofRTt3n9g?=
 =?us-ascii?Q?K6xjCpt0h8x2TPhiA3yFYCb2osutS7jUuP1UfGZWR7tMH2Yda/87I43G+OW8?=
 =?us-ascii?Q?LuMkaIidnH25aIeBnrOqmlndEjssk16wWoZZ+zRSbkmCj3qwagoeCfB7DT/p?=
 =?us-ascii?Q?l0teLCgfC1xYeVxm34tJ4Ou/MV5QBFwPUfAALOTv4H2DbkTBsuqSDtTA6K4N?=
 =?us-ascii?Q?daZCcAw0JZvdi8+ZgWqCU3oEpQIEmA8vwN6zmxxXnNSUkJZzyGXGPNE/ngzp?=
 =?us-ascii?Q?g7a7C9+IC/BpR6Bz7DwOc6834tG9gocw7gLKgi5pHoww22YPPd7OtYco2voN?=
 =?us-ascii?Q?a43xj0ykVdF8c5ThGfThYZWJEoEF5t3Zm6egYTctj55n34mWovL+ps749OKC?=
 =?us-ascii?Q?J2a9PrSD+cENK3XBeFZwlU+ke1TuBEl+2xLIAX3okQTbduR6MBYKbDh81XsN?=
 =?us-ascii?Q?HbMoJvSO+80llw8nk//Oc3rNbyzCE/deopObTAl2MxGLoovh+uQl9Pm9lToF?=
 =?us-ascii?Q?NV4vMF9rY/xnHMfm5fLsET99BJ7mz+523RQM9bLMuw7FJ5p9hDJyrYwggEKy?=
 =?us-ascii?Q?cc74c9wiqbSlACumviHGluCANir8ah6Fq3jYZj8frp3HKq8m+A69qlPn+HHB?=
 =?us-ascii?Q?q1Aj2NCnjxg8ubdBS8ZKvzeOW63r80v/j3s8bltokGt0y7jbenzw2kaNFYG0?=
 =?us-ascii?Q?4Fw243ymqrXsTn3cmx7gVVux9NtVtXgRsgmnpUYJYk25BPXg4uA+nuNyjQLd?=
 =?us-ascii?Q?FZhjXGhTIhKhbqIoGZf73bmIJhLFAEMnaPCZfrLgpE+WzKCb7F8efnlzAMoe?=
 =?us-ascii?Q?k6NO6xOcbafvNq8wC8ylJxrVV+HFg3ffZ5kUJjopaJocjqhXHS3+PYu1XVrU?=
 =?us-ascii?Q?BUnZ9uTf7Jp93HQO2nZCTvjjQo5E2qD0186m3aX+9DyAOULmu+QDD/sFV7Dw?=
 =?us-ascii?Q?GX+L7hHcDZOrRagYEXXneeiQkvj8zxdykBXKCFoKOB2vm1hoSuL0N13oDta6?=
 =?us-ascii?Q?E5mumeQDrXHPEvl8dG3ov1ulSA3oktVhnTNgAKtnIlE4+n5T5//4xteR0AAv?=
 =?us-ascii?Q?iiKPYgw9sJ9V33UDfW6HLmtv8zvNhsLibIV8cZW3zz2Qj3tYBHzXBtB3GsDd?=
 =?us-ascii?Q?YP4dk6IrQ7Q80Hd1c7MLz6DB/V1Dagv8nX7VhE63nJ0yQnAl2JLpLgBQnI6l?=
 =?us-ascii?Q?qmxIZ1qzvEqFywGjC/Iag8Up5n/L7wiveVETsEr7df1G4V//5eUFfniz2Okx?=
 =?us-ascii?Q?ScD1U7ADiQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e2e61c-b601-4cf9-373a-08def939bc6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 12:52:30.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktod7MRw+Nasu0wv8cjXodwa841yMvFn7XvZq7NL5uPSXLLJaB149PxTnn+e6JUfaOHNDZvh4tpL+g6DTOHcb7BHTWILAKzYkmIICavzNts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14890

Hello Manush,

I am sorry I missed the difference between ports and port.

Please disregard my last message.=20

Best regards,

Michael

Reviewed-by: Michael Dege <Michael.dege@renesas.com>

> -----Original Message-----
> From: Michael Dege
> Sent: Thursday, August 13, 2026 2:45 PM
> To: Manush Prajwal <manushprajwal555@gmail.com>; Yoshihiro Shimoda <yoshi=
hiro.shimoda.uh@renesas.com>
> Cc: netdev@vger.kernel.org; linux-renesas-soc@vger.kernel.org
> Subject: RE: [PATCH] net: ethernet: renesas: rswitch: fix device_node ref=
count leak in
> rswitch_get_port_node()
>=20
> Hello Manush,
>=20
> Thank you for your patch.
>=20
> > -----Original Message-----
> > From: Manush Prajwal <manushprajwal555@gmail.com>
> > Sent: Thursday, August 13, 2026 1:11 PM
> > To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: netdev@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Manush
> > Prajwal <manushprajwal555@gmail.com>
> > Subject: [PATCH] net: ethernet: renesas: rswitch: fix device_node
> > refcount leak in
> > rswitch_get_port_node()
> >
> > [You don't often get email from manushprajwal555@gmail.com. Learn why
> > this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On an of_property_read_u32() failure, rswitch_get_port_node() sets
> > port to NULL and jumps to the out label before releasing the reference
> > the for_each_available_child_of_node() iterator was holding on it.
> > Once port is overwritten with NULL, that reference can never be
> > released since out: only puts "ports", the parent node. Call
> > of_node_put(port) before clearing it.
> >
> > Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> > ---
> >  drivers/net/ethernet/renesas/rswitch_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/renesas/rswitch_main.c
> > b/drivers/net/ethernet/renesas/rswitch_main.c
> > index 6fe9648163..ffdc42f430 100644
> > --- a/drivers/net/ethernet/renesas/rswitch_main.c
> > +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> > @@ -1315,6 +1315,7 @@ static struct device_node *rswitch_get_port_node(=
struct rswitch_device *rdev)
> >         for_each_available_child_of_node(ports, port) {
> >                 err =3D of_property_read_u32(port, "reg", &index);
> >                 if (err < 0) {
> > +                       of_node_put(port);
>=20
> I am not sure why you are adding this here. The code jumps to the label "=
out" and that is where
> "of_node_put(port)" is called. Is there a reason why you want to call thi=
s twice in a row?
>=20
> Best regards,
>=20
> Michael
>=20
>=20
> >                         port =3D NULL;
> >                         goto out;
> >                 }
> > --
> > 2.46.2.windows.1
> >

