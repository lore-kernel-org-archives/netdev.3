Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3BC3DA5D5;
	Fri, 11 Sep 2026 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111089; cv=fail; b=mKWVUbXOdnz1+65bT6PTWs3X0KSMiWQOCVd3RMQzNgcUhovd15hvYQ6YjGo449utvi3N2bevgtbqju6FE3NdBpmTiz9goJp0vKvRQz1Rwt1elwp4az4r91xblK+OACmJf7JDHhqUI7i14BDclfpQuktyMx9//Ag4bqSC6kkjmdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111089; c=relaxed/simple;
	bh=71A2dvz7fQ8JTvF9sEC6bH1C2ienxfkS7noNl/gTaXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=owLrkssm6GGFVybd4jH2zqDv9OO1KDscT2EQ/ynCfTuYQSZkTTlzYyF2SfROyvN5lbt5zYqZ93x69qQ/AaNoigHsrBzoiGJIme4DbCym9/8jduP7EThwGDlBHEn8TVEniOt527X+ldonOWgHQCJYWrDidO3e+lTSIppk21T5iN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N71E1KyV; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N71E1KyV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCNZ+co2m8v+tvHvJ+717MGokx+DaTqYNMv/QN1s20Wif60KBZXboBPVYQrqyyPvBPOuMKpDwj1M1S/LZxnZ/qq2fhPiMOvQaWCD8dgPShxoZOm+oI9yTut6IROy4JoWMHhWPcE2BEvGQSeL52sun9Gpuwcxu5KKaLJ6cZMN53nI+5J0n9vFT10ZzKcZXy3FqRrwxJZueKO3l7MLBm9lL500OHr7bWSt9AJSSO4V/zpOHvWfJqqPk+hB5N8Dqevj1o9SmJTjNREmfiK39kxujtYb/IiJj9rOjItuxvUmZGajTPu7Q0F75dheVQIJOtzvrhVbS0lOLudfGDtqfeCLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM09mmFY4CKub0XMW1DYF444uznIKp0qAwIog7N0u1s=;
 b=GBZRy+yK2n2XJBteuT6DehzgqrZJwuTGQ8V/wBiHpfF3FddWJZie2pi5mhYDPkZrGwL68OuRPBuJqZmmhpGWtrYt/Dd6QZiNVOLAjJ2DUPWj0tgErhf7pKSUBuDEBqhKS6/JwsNgXjohz/9jQeCwIasSqL+J0oh5Y+2GeD3LEQQZhihkoWGTbpRLSVNxx3YuFm1XVrWMzIi+yutC9PbbBvLdimU65PYUPB/LoVmw/BOPL8cmgefXRv5HtMwJa2NZKLcypGnG/hQiVvVvxz3dew6WY6eqYAh3ibLPqpIkwkStTkDjU054GrD18bh9WQLfk5akXbRch858lFSmBxqJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM09mmFY4CKub0XMW1DYF444uznIKp0qAwIog7N0u1s=;
 b=N71E1KyVQ+XfK5mYQSf/hj9AcJbfPyz6Z4LUzkOANqB59wXALmdtf6gG9rdKOObyUw7OcCWUOCQjL7Ntj+poqe2UkwQRq3QkvhSN/572ZioiwEf9K6EFUNc+AKt3v10MfNm7sDWElZpO0AiClruByPlnoBG+IDBQA6766RlYQOnyPUgh2xFc4MdZGtR6dsd7flM6P22fgAAbUy6f1uzWO6E9gzFSTHQ15yqH2tHr/c58NGi0FZ0oIn7yu4yGZsRdjfVosEjGWDSclmN9MlBqtVSQOyv9UTzdcl1AsxTa3k/88bW+iSoUPpJndbE5UrHXzKeKyJYXhD0Vw8iCZP3VhA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GV2PR04MB11737.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 07:17:55 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 07:17:55 +0000
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
Subject: RE: [PATCH v4 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Topic: [PATCH v4 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Index: AQHdQEcm+ZA6TK/2NUaXUOXwDyCWibbHrF+AgAE/fWA=
Date: Fri, 11 Sep 2026 07:17:54 +0000
Message-ID:
 <GV2PR04MB11739799CBC5D16584E006A5288BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-14-wei.fang@oss.nxp.com>
 <178903926334.219967.16804647636083728904@kernel.org>
In-Reply-To: <178903926334.219967.16804647636083728904@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GV2PR04MB11737:EE_
x-ms-office365-filtering-correlation-id: 085ee338-d959-4a0d-3a42-08df0fd4cc97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|376014|7416014|6133799003|38070700021|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003|10067099003|3023799007;
x-microsoft-antispam-message-info:
 3xpoubKHeG/cW2ijzDEV+pLmYec4I1cHrqgCDfWQNHWGfuH4HdAGswjLCu9vkxs/C3YERxuliBwI/b/7x1KPx4tYcexOp3K8vx/RSWP0K+JyiJWyUg1rEUe5JoA0S69zDKi5cqPk0xBLy4b6E6b4pbNP1Yj1pEvEzDQ7zScqG00uDCvWW/uhddz3T4gAwlkz85xjadm+wEPCwXnQ07K3HJF0N2YFwJ+SIAye/5yws9RuXbZAz3uQuarOw6Mmw/Zunpbv0vjNHABrrx7rD1CM761bP4oggl/mz+Qfm2DLh+5M6U9v+4uQNFUZo9WGo7hYb+YaYf1FyRpGTDcGctAPwvYo60AS3FFRXQKAUj/D1Vh5jErYVi5fm4dX54g4xT7/kD9oGUgxdndN4WCTfGfUSG+bTSDAg7xOqpdz/TDEyjMcu55sTMViU0QauOKJT2IapfTe0eV6AwxeRRPxugPgHEW48IRSJQKVBEqMa2LP9TEaUxNME8QYp/nKm4+BEAwr6393rnCPukYHVpXSU12kUB3WGfdrH/Xkd5mmQsA1mGjcjfLiXtT4niT+e8rPxPDUYPAqmgGACFplfGSpykDGev9HOIq8dJBPlvKQjRsIHYtJognltq0ymD8z9AYE4ObUH5QubJJeYeeU/fiXAAHStRaNx6aoO7yhZtSLmfnVNWxP4FI5vqWDj8z0BzaW5hWUVc3UVgW6zkdJTikOaL3LK40BrPU6C6OX20H6sZkIVoI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(7416014)(6133799003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NlkkGMQIN8szQWYjPX5cCcYD69XwADLMAtdLBM4TDQOH2ianhx0k8mNumYh4?=
 =?us-ascii?Q?mVs6BiRqay7vizDNFrKCE11V4XTPPl6ZOdblLg8dr2mEs71tDFRpH16VLsxx?=
 =?us-ascii?Q?7d1mYYNp1MxECMLJ25idQoehkapWEK4Kmh18TBNXhbZVKC5NtHZg31VzPN6H?=
 =?us-ascii?Q?mg/ZhbsMbgw1FAqyMPeaWuTFPtRd/XlmjeVWuOgVODitI70amkoyRWNHUW64?=
 =?us-ascii?Q?Vi6iV9+72WSC/IO1KqWyuGFXwctWIeIUZvy0/oqLj7BTslxCXOpmB0H5wa+M?=
 =?us-ascii?Q?mIZ+/XBeRuxLkgc/XoD5No5azWdYE6nwYM74uZNAPO6LeoSEjNaJxVvzJGql?=
 =?us-ascii?Q?L8TCXNY+46s12RzGyG4hOIvYxDNjEn1PxVklZ1K7iQV/3h49W/hJlCtnqA6y?=
 =?us-ascii?Q?yipePjv5xzT+//4V1E6oZjkSMSkElyU4vZVNC9vv6XBmssYvMxbWnYsYyjAn?=
 =?us-ascii?Q?JrEHDM1P1MHyNKebcO39I59CSPjFy6qIDaBeTJtSb7oyXdGFdg8HV5AAGgc0?=
 =?us-ascii?Q?efiT8Cy1IR5+lw20V+s7Dh9PzmtitJoqe5MNXJeo4LyVXTR9fbeWIW2ojXFb?=
 =?us-ascii?Q?3LHxUffqX+g+++j3DM1j6geZYYf4G0HbZczJvzGBLCdHQnQiW/3KY6cm61Dl?=
 =?us-ascii?Q?YLeUAvvdxnq/ZNYxgbhSNdDrICVqIs0ri3UesAX2OeEp5jz1XJkU65jgc5zv?=
 =?us-ascii?Q?r7nMqOP8DZdANdXa31Aij9UEv2Npm1b9E6/EFF4lSBnTS5Q1s1cDi15/Lx9b?=
 =?us-ascii?Q?ShTqMDEXHJ05M0BmLIlue4GYM3+/OY6+zstjj/YSgD9euIV9QU9mkh9Iv4eO?=
 =?us-ascii?Q?1a39BWYEnrKU/O6ORTM4bSQ62hTLl/TGZBHRllOSLXguoybJNHf1t5DQ0j6g?=
 =?us-ascii?Q?GePz3ec7DKZPc8FOJm/c2ZfknJzgQWYfQ31u/Nv5AHeP193sI0SqHGbvPSuD?=
 =?us-ascii?Q?P9b9+KMAxSpZ3lzmz1bfdaqH+yZfqDyNYaOJ4oSmUaGrnZQ/Vs9x1omcWjZ5?=
 =?us-ascii?Q?0r6NMnWZ13WqCqYoXNzflTIjnifMLjd0jOTyFaDW3KXajflSFoJ9bIhHaJZP?=
 =?us-ascii?Q?u6EHC9pQIPD1F+2mPVprEop2YjZa03QPAJ2EvD6pgWCofdCclqCL4pMos4yR?=
 =?us-ascii?Q?SRgSw9oDoM4MycS2DS2mTeTCQI7Z44fv1kz524U8bQ8JVQtxq3lVeHP963YH?=
 =?us-ascii?Q?ILQTEFavmWFmpmd1Bu2rg07457t2J8kroJNFXMCcv1/gNlAa60nIDTSu8LNt?=
 =?us-ascii?Q?xw0eo3cQyuCiNSk7quETYoQMdu6FE/aTTi38+X4Wl0BT0VxYSO1aMhPaLfos?=
 =?us-ascii?Q?CA4d//NPw3EkoBwTbZxt3bnxgzvkC2+3gzHHREUXZm4irFzI7TGCHCK5DIU5?=
 =?us-ascii?Q?fVTEhehhLp716aA0rKjFjhKi4nhZmndeBk+qV4Yvyv0arm/oM1u0SpTo5HGY?=
 =?us-ascii?Q?6juK6jRv9X9ZLMkm4pUIp3VtjtkVCxemJM494frMX/22BkK5Qc6bLHps9XAu?=
 =?us-ascii?Q?LoI2kIXtsdFPI8aMupkT1YcNG2S/9R0cnqgho1+lmP5qICaeP1yHohikD9Zp?=
 =?us-ascii?Q?o+dTBsgUZu+YvrOn5/BZuAWtcAyWDqKiXthx+qyT5NxIvR2X+l39qP7FRfU4?=
 =?us-ascii?Q?oOieDN18IReio6CutDTdGeDbzcfQDbylbZEiBWBxwz0rlWktFhFveokPOxPO?=
 =?us-ascii?Q?j3ra4zMRu/lhX12yaDfLOYoiMQAYrHZLwWO4okqWi74XOLfV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 085ee338-d959-4a0d-3a42-08df0fd4cc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 07:17:54.9351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqya2HVACKdaRYDJxBg04GNDwRFbPOoIHvZnf998hjna/LmZ5DHN6B1vurbx3N5W4buHkuNO0cMmz5Jm45BWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11737

> > +static int enetc_vf_enable_iff_promisc(struct enetc_si *si) {
> > +	int err;
> > +
> > +	err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> > +				       true, true);
> > +	if (err)
> > +		dev_err(&si->pdev->dev,
> > +			"Failed to enable promiscuous mode, err: %pe\n",
> > +			ERR_PTR(err));
> > +
> > +	return err;
> > +}
> > +
> > +static int enetc_vf_disable_iff_promisc(struct enetc_si *si,
> > +					struct netdev_hw_addr_list *uc,
> > +					struct netdev_hw_addr_list *mc)
> > +{
> > +	int err;
> > +
> > +	err =3D enetc_vf_set_mac_hash_filter(si, uc, mc);
> > +	if (err) {
> > +		dev_err_once(&si->pdev->dev,
> > +			     "Failed to set MAC hash filters, err: %pe\n",
> > +			     ERR_PTR(err));
> > +		return err;
> > +	}
> > +
> > +	err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> > +				       false, false);
>=20
> [Severity: Medium]
> Is the early return above correct when the PF only denies the unicast par=
t of the
> request?
>=20
> enetc_vf_disable_iff_promisc() sends the combined hash filter first with =
type =3D
> UC | MC.  On the PF side, enetc_msg_set_vf_mac_hash_filter() handles
> ENETC_MAC_FILTER_TYPE_ALL like this:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:
> 	if (!trusted &&
> 	    (hweight64(mc_hash) <=3D ENETC_VF_MC_HASH_BITS_MAX)) {
> 		enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
> 		pf_msg =3D ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_UCF_DENY);
> 		goto vf_state_unlock;
> 	}
>=20
> so the multicast hash was applied and only unicast was refused, yet
> enetc_msg_vsi_send() maps UCF_DENY to -EACCES.  For the default untrusted
> VF that means the 'return err' path is always taken and the following
>=20
> 	enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL, false, false);
>=20
> message, the one that actually leaves promiscuous mode, is never sent.
> Would it be better to treat UCF_DENY as a partial success and continue, o=
r to
> send the promisc-off message before the hash filter?

This is a false positive. When a VF changes from trusted to untrusted, its
promiscuous mode is already disabled on the PF side. No need to send
the promisc-off message, its pointless.

>=20
> The same ordering concern applies to enetc_vf_enable_iff_allmulti() below=
:
> the hardware-changing step (enable MC promisc with flush_macs =3D true) r=
uns
> first and the restricting step (disable UC promisc) runs last, with no ro=
llback if a
> later mailbox transaction returns -EIO ("VSI mailbox is busy"), -ETIME ("=
VSI
> mailbox timeout") or -EBUSY from the PSI.  Can that leave a trusted VF wi=
th
> UC/MC promiscuity armed in the SI while the netdev has already left
> promiscuous mode?

This is also a false positive, the ndo_set_rx_mode_async function is called
within the workqueue. When these errors are returned, the work is
rescheduled, so the process will continue to attempt. If PF works without
faults, the setup will eventually complete successfully; if there are fault=
s,
moving the order will not solve the problem.

>=20
> Since the SI promiscuity bits live in PF register space indexed by si_id =
and are
> re-applied after FLR by enetc4_pf_vf_flr_handler(), a skipped promisc-off
> message appears to persist until the VF issues another one or the PF revo=
kes
> trust.
>=20
> > +	if (err)
> > +		dev_err_once(&si->pdev->dev,
> > +			     "Failed to disable promiscuous mode, err: %pe\n",
> > +			     ERR_PTR(err));
> > +
> > +	return err;
> > +}
> > +
> > +static int enetc_vf_enable_iff_allmulti(struct enetc_si *si,
> > +					struct netdev_hw_addr_list *uc)
> > +{
> > +	int err;
> > +
> > +	err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_MC,
> > +				       true, true);
> > +	if (err) {
> > +		dev_err(&si->pdev->dev,
> > +			"Failed to enable multicast promiscuous mode, err: %pe\n",
> > +			ERR_PTR(err));
> > +		return err;
> > +	}
>=20
> [Severity: High]
> For an untrusted VF, does this leave the IFF_ALLMULTI and IFF_PROMISC cas=
es
> with no MAC filter programmed at all?

Yes, for untrusted VFs, attempting to enable IFF_ALLMULTI or IFF_PROMISC wi=
ll
return directly without configuring any MAC filter. Configuring a restricte=
d
multicast filter is only permitted in the third case (IFF_ALLMULTI and IFF_=
PROMISC
flags are not set).

>=20
> Both enetc_vf_enable_iff_allmulti() and enetc_vf_enable_iff_promisc() sta=
rt by
> requesting promiscuous mode, and the PF rejects that unconditionally befo=
re
> touching any register:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:
> enetc_msg_set_vf_mac_promisc_mode() {
> 	promisc =3D !!(msg->config & ENETC_MSG_MAC_PROMISC_MODE);
> 	if (promisc && !(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
> 		pf_msg =3D ENETC_PF_MSG_PERM_DENY;
> 		goto vf_state_unlock;
> 	}
>=20
> That becomes -EACCES and both helpers return immediately, so the unicast =
hash
> filter, the unicast-promisc-off message and any multicast hash filter are=
 never
> sent.
>=20
> Note also that the multicast snapshot is not passed into either of these =
two
> branches, and enetc_vf_set_mac_hash_filter(si, NULL, mc) has no caller in=
 the
> patch.  The PF does permit a bounded multicast-only hash filter for an
> untrusted VF:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:
> enetc_msg_set_vf_mac_hash_filter() {
> 	case ENETC_MAC_FILTER_TYPE_MC:
> 		mc_hash =3D (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
> 		if (!trusted &&
> 		    hweight64(mc_hash) > ENETC_VF_MC_HASH_BITS_MAX) {
> 			pf_msg =3D ENETC_PF_MSG_PERM_DENY;
> 			goto vf_state_unlock;
> 		}
>=20
> 		enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
>=20
> so multicast groups joined while the interface is in allmulti or promisc =
mode
> appear to be silently dropped, with the SI keeping whatever hash filter t=
he last
> non-allmulti update left behind.  IFF_ALLMULTI and IFF_PROMISC are entere=
d
> by ordinary operations (bridge/bond/macvlan enslavement, 'ip link set ...
> allmulticast on', tcpdump), including from a guest owning the VF.
>=20
> This also seems to contradict the commit message:
>=20
> 	For an untrusted VF (the default) the PF denies promiscuous mode and
> 	unicast hash filtering, so only the multicast hash filter is
> 	applied, limited to ENETC_VF_MC_HASH_BITS_MAX buckets.
>=20
> That only holds for the third (non-promisc, non-allmulti) branch, not for=
 these
> two.

The original intention of the commit message is to indicate that multicast
filtering with configuration restrictions is only allowed in the third case=
.

>=20
> One more thing: unlike enetc_vf_disable_iff_promisc(), which uses
> dev_err_once(), these two helpers use plain dev_err().  Since the denial =
is
> guaranteed for an untrusted VF, wouldn't that print an error line on ever=
y
> rx_mode update, i.e. on every multicast join/leave and every bridge or bo=
nd
> membership change?

This is intentional. Compared to other interfaces, ndo_set_rx_mode_async()
is called relatively frequently. If the VF is not trusted, printing an erro=
r log
every time it is called would annoy users, so printing it only once is suff=
icient.

>=20
> > +
> > +	err =3D enetc_vf_set_mac_hash_filter(si, uc, NULL);
> > +	if (err) {
> > +		dev_err(&si->pdev->dev,
> > +			"Failed to set unicast filter, err: %pe\n",
> > +		ERR_PTR(err));
> > +		return err;
> > +	}
> > +
> > +	err =3D enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_UC,
> > +				       false, false);
> > +	if (err)
> > +		dev_err(&si->pdev->dev,
> > +			"Failed to disable unicast promiscuous mode, err: %pe\n",
> > +		ERR_PTR(err));
> > +
> > +	return err;
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
> > +	if (ndev->flags & IFF_PROMISC)
> > +		err =3D enetc_vf_enable_iff_promisc(si);
> > +	else if (ndev->flags & IFF_ALLMULTI)
> > +		err =3D enetc_vf_enable_iff_allmulti(si, uc);
> > +	else
> > +		err =3D enetc_vf_disable_iff_promisc(si, uc, mc);
> > +
> > +	/* If the error code is -EOPNOTSUPP or -EACCES or -EPERM, return 0
> > +	 * directly to avoid meaningless retries.
> > +	 */
> > +	if (err =3D=3D -EOPNOTSUPP || err =3D=3D -EACCES || err =3D=3D -EPERM=
)
> > +		return 0;
> > +
> > +	return err;
> > +}
>=20
> [Severity: Medium]
> Is the premise behind this mapping accurate?  The comment, and the commit
> message wording
>=20
> 	Since a denied request always fails, map -EOPNOTSUPP, -EACCES and
> 	-EPERM to 0 so the core does not retry an operation that can never
> 	succeed.
>=20
> assume the denial is permanent, but PF trust is runtime-mutable:

"The denial is permanent" is not true, enetc_vf_set_rx_mode() will
not return -EACCES or -EPERM when VF is changed to trusted.

>=20
> drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:
> enetc_pf_set_vf_trust() {
> 	if (setting) {
> 		vf_state->flags |=3D ENETC_VF_FLAG_TRUSTED;
> 	} else {
>=20
> That path only flips the flag; it neither notifies the VF nor replays the=
 previously
> rejected configuration.  So does
>=20
> 	ip link set <pf> vf N trust on
>=20
> as suggested in the commit message actually take effect before some unrel=
ated
> flag or address-list change happens to re-trigger the callback?
>=20
> Also, ndo_set_rx_mode_async is documented in include/linux/netdevice.h as
> returning 0 on success and a negative errno to request a core retry, and
> netif_rx_mode_run() in net/core/dev_addr_lists.c treats 0 as installed:
>=20
> 	if (err)
> 		netif_rx_mode_schedule_retry(dev);
> 	else
> 		dev->rx_mode_retry_count =3D 0;
>=20
> Reporting 0 for a rejected or partially applied configuration means the c=
ore and
> userspace believe the filter is in hardware with no diagnostic emitted.
> The -EOPNOTSUPP case looks similar: a PF or firmware that does not implem=
ent
> the MAC filter message class returns it, and the VF would then report suc=
cess
> with nothing programmed.

Mapping -EOPNOTSUPP, -EACCES and -EPERM to 0 is an intentional design
trade-off, and I'd keep it as is.

The core's retry is exponential backoff meant for transient failures that m=
ay heal
on retry. A trust-based or capability denial is not transient in that sense=
 - until an
admin changes trust, every retry is guaranteed to fail, so it just makes th=
e core
spin for ~15s and log "retry limit reached" on every address-list change. F=
or a
default-untrusted VF this is recurring dmesg noise with no benefit, since t=
he core
can only retry and retrying cannot succeed.

