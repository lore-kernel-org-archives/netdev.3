Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1482264A8;
	Thu, 23 Jul 2026 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779116; cv=fail; b=dYH3tUc3xTiOF4hufiEAz60UgECYt0DuBSbRaBHHBJR9mIYBAWIEnbslVBDoAUE5rwHZbfGvbQcTdrlnX1RZeP2RJAAp0wWHRgHjAWDjIHlusWln5kkp+hFCw8XuvCopvLUf6Jcwz4OjUakw3gc5JoBCOGL1HckltjUNf3ncyEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779116; c=relaxed/simple;
	bh=jWTRHhrYyJlyHxEbkdykDcF+1MuFWkr3J88LERCC9bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUvzNWeSNMrXsLZxGS812xYBW/UaaRd/XO8wfoDZYFvDYaP6ePwoIWoTRnK/B+8PkHkjDRRYhhTzQhq6JHJ34xOUA6FYCBlWHAiE8Bv+eeUtJIx9tdVkMqCBJrT0f2/Jc0opw/go2s0XnDj7vaRc/RJataOGgDVrgIC9KEYY7O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v4yLaOSY; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v4yLaOSY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTJNi7rHJH1o7DYWF1+TAVRt2gLsVsmNslU54xVRHdpVONjv+lt9FMGD5H6zGq5x5M3iN3MKWzrkYzL7KXlRFbQZOPvlOYIWvWinGRjaCTNN0IKLY0wsaSi6xcPcYa3cew6VzNc6OXLYpe115zV6I1ndGhzZCOhK2KVbXAxi0vnYEyt+lY/pljWvidjj6Swe+Jr3FKd+FcRrEY4eMXfAk91Shx5LTVkoufqGEat3E9dATLYQkrXtcGBFkoIMGqllrk4B89RARMisn1NivnEvpYnfkV4QeqpxYo5AMztatjVNbk8A9FQzrY0YJvTqgsSIJvgkHeUuXflCcCFnQy385A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dbFL0LHibMT487Fa8XiRyb87Ak88q/OiowmFSo3yt8=;
 b=g64wo7QjuzBBt7TuDj+Yeke71cl3HIZVtx02WhwvaOT6A/JDPA42JP3yTGR0KjVoIYJRZ2/3GiodmA0Cq3EtrmmtzWKI08xmLWFr6eEbHO2BfBASNnbZtU/mZrYRdRICBn5gu6ljBlJ8wxLiRzhHACx3OJCn6MCRqAGvZyjtFo72eGc+6ZZJrh6WQvUqZXDLlorH+hf0siV7hO+nPVjUY4vJ3dXq3pWEOn3erhD/WQhPpU5RbbdocN8lzA10eeLQr3XLeX9mZx2MC8mCceAnyW4KOQIxPenRs+ueCGGkO5BwpXpQ79slkCZof5Mume8/58oJ3o/uR8LKIelqVCKQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dbFL0LHibMT487Fa8XiRyb87Ak88q/OiowmFSo3yt8=;
 b=v4yLaOSYqgfcFIVjLiVpCC8CAS0lWRK2ALnrvEIL2ZkiO6xtlA+z4zXmFp1HFq3r0PvUw+ZhriuyF2YSi9LxtW3lyy7mdIB4c0onUTTvzZfYhau9bpuHdjJKFIRDd3ZW2qma8tgNFT3X+L6B2bA1AlUVMSQFiX4UI6Yn/OAvPES4fG+qGQ0BYfOqAcbqdQr4MIPe1PqzjyP7mjBya2TqDt0joS6P1ayPlYa3DrS1g5iayY8f4ohOKS0Z2qTWhQr0D/qLVnoOVWojC4eBUytHYKFBaYorDU0XS+Y7FGvd8ZqnytztRNRKP0SXoTeEZY/qLJzZoTx4+ww+/mXUWm+Z+g==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by IA4PR11MB9322.namprd11.prod.outlook.com (2603:10b6:208:562::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 03:58:30 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 03:58:29 +0000
From: <Thangaraj.S@microchip.com>
To: <nb@tipi-net.de>, <enrico.pozzobon@dissecto.com>
CC: <Rengarajan.S@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Woojung.Huh@microchip.com>,
	<netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v3] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
Thread-Topic: [PATCH net v3] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
Thread-Index: AQHdCWiV89lCvz1/gUOsfpl7sDXfCbZgIcoAgBp6GwA=
Date: Thu, 23 Jul 2026 03:58:29 +0000
Message-ID:
 <DSWPR11MB9715DF2FA75211B9F2A6131AECC02@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260701-lan78xx-vlan-promisc-v3-1-232266d32743@dissecto.com>
 <71cdcc54320d7b44af327d9e5537b373@tipi-net.de>
In-Reply-To: <71cdcc54320d7b44af327d9e5537b373@tipi-net.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|IA4PR11MB9322:EE_
x-ms-office365-filtering-correlation-id: ae658caf-25ee-4824-658a-08dee86ea835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|10067099003|11063799006|4143699003|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 CtawefNjEXIhTjEreaV8JiRzklb056ecoL7SIXtyZf4NY97Rd4SyKshaOhxtE+VwSxbsxlyOhUIqSEFFNbQJI5bCVBJP2S3JZaZi5YM5tEjO6/T8zSG6TEWaLY5qPi6ygTynK/zeeR3erikc8YpzpNs18LWMiDm4FXUaNsXhIC1SkoL7eRINsgKr6470q4qOTyxXF9317OgVqYHPqzOQ2DRp3ZBiOYUqmMFl6q4sWqsqw/SqH/gHhO5buTKucT00yPzEQ/Fgqj/C0VNwdXb81HUY4CeAlTpadxz1knzVbW7LJW9vtNIVZqsQgsv30aQPc7Rmbx2PIGpdMYc2MRr/85/8bvWPlYfHMHuf8zMwunFXupsxiZq34rtR7Nb1qvSKvybtigreZhgdO+pd6vUQe7xHLKz7vLTQOXES9fihjmtVQAPWyS/TyWD7dagTY+OTyHfq+9GYzcpKdGaMfAFmSiW9Rd51NNYQ0HfVCTos+DFvf25UPRCCRA5mvSCTAM4gl4q623MJ30AuLLfm7LLmME+UfDhxusmp83reRlTU4VOzVVPE6b/edDaOnBTpXJPDRzi+sdfAxZ+oxRQNPdpqc94yzDefm/uOsSOIZSXUtjAT/8edwGYr4ygt4tViSmgDx/qq8SyqWYqhpJCxm5JEsB2kjdxIlrsDMwF949WOrkw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uI2ptCIKTS97CWKQCIhp6T7cmbr4FjrT7JiMnMcBOcRYblBmurBQvN8FVTgd?=
 =?us-ascii?Q?I259s90wpH64gt15IzfPsZlHSrRqHPaCbIoDw+ZHwroTBApOPB4hg4VK6Xz/?=
 =?us-ascii?Q?6ELDmf03HpsyNaOpX824Esk78MGaqXIT+MhDXiSNJPHChb4EVpg80eEI/GMe?=
 =?us-ascii?Q?f6SAtLWFVgl+dYnAs3Q3PRoL8cJUluxTsFUr/15SBO+HEnXU+QL8FMGRw1G6?=
 =?us-ascii?Q?yWQH29qfE9eTVMyakJRsuGEiS6eGGyLcPkF5JoMND5Gmn91qKIoR78hPBqYM?=
 =?us-ascii?Q?sPD233XqVGMOcNrTyp+aCr5AYCBRu0sLPGwZ8rCw7R0F7v/19p1pp1O/8uAE?=
 =?us-ascii?Q?Dh+7H3uKXC/lmRFw+JZychrEhcB+MfE/cVyJ/ctVDrQ2EAiHQ2ICJukb4OMr?=
 =?us-ascii?Q?99tUron8gLIQwmdEYac/qvKJLBDXBJuQBIWl8W5jzvZ5NWEYf04OuYUkZKa7?=
 =?us-ascii?Q?MdwdEazINed0sPPsvzuR4JhGmPvyM6ZTeQCrdvPx8nmQJHKmYaIOtN9Ehhzh?=
 =?us-ascii?Q?2dB801t5hnAWRQOTCnhLk+TcFwZ/tIQr4txehudVYNb6CTVAFqC2DAogKHMm?=
 =?us-ascii?Q?06dvZWnovtTx7rGnwT/a3U+5YxOGRJEs90LYB+NP3qoeBSSOMFNFFwyhxPnm?=
 =?us-ascii?Q?IK3LvVwDQ0RmB2G9ZExqVJmBbc4gwC0kMw64YOVudmk8TJDGW6BxJio+Kecw?=
 =?us-ascii?Q?A5GHSnrn5j3ZHO01FJaznbGWYk+X+B/lUHGgoEQFmnlkhp+evYb3SxoX2dC4?=
 =?us-ascii?Q?uTRhyFHqQW6BPLpqFLcPnrJBzTYoRh5nPHnoa7+5zDJte8sJNlbaio0S93Xr?=
 =?us-ascii?Q?3H2YYZ/jWvf9C5Qb4mW7ZxLCgCbgTjG7o0VQ+dy4EGnRRNEtZKS2EvaCGnc1?=
 =?us-ascii?Q?OaNcX/mk28DIWoGAo5TuzWFLq2Razw4wFYOfF1ph/lo6KMDLJfnnAMmHF1qC?=
 =?us-ascii?Q?GMABM7LMCJbqZRf0/LGSICEskRgzh4dlCmwqOrurbelxVf5r2YJXmdddZvcV?=
 =?us-ascii?Q?Zrv4xlD1bYH8tEVgJ70wEHcbph7MQtzQ+y7t15BtmCb15MtBSYpKiLXfrtXz?=
 =?us-ascii?Q?hC7qoGoN7xwzAKXtI6TbQojkPHKuaaL2iGe+XguU3QL1Kzi4iRMQixQhcgtS?=
 =?us-ascii?Q?v+KtWF170rOm6KXjdD6t+j9aIyOM5Ppg3UWGMEUKLj1FHtKRJ+DhYGbjxjlr?=
 =?us-ascii?Q?n5EzoWjx8uQVeINu+U2gijUDgEiJL3RXbDOsglMIH0nSUZFReh4SvYSPED6c?=
 =?us-ascii?Q?ZhMBaNCgy96V5Su+BWS7cV+A6C5jhv6F8dFH81IPHN2R9SavpndDhyQjm2/v?=
 =?us-ascii?Q?1fETeAVit+hDZfCcTw/kMsOoMZETRm1BSbWzyLlUnjSvPa3by2GgeJiZoeSw?=
 =?us-ascii?Q?pwvlggQ2ieQ1eKACM8abDmhVb76hWmcRgKt1fP/FToq9n0TfxDKj+BZYoTml?=
 =?us-ascii?Q?muQU5Epbov8hcXfhvJ+KvJnpf1NkmZSTNGpVwaWYg07XZaRlpL56eBmMJURx?=
 =?us-ascii?Q?WKoxB41a6yXa5yqoo4TzEGXbvp/mTcb2awNfyjUn41+Qa9+Z2FbE+JQmsRsP?=
 =?us-ascii?Q?p3EaCTpchYhh3itpNZ+LaXwWnOwfjz6JsvF2j7W8cs1zPbY0B+OgP13IEGkf?=
 =?us-ascii?Q?PSs6AqQivkJjDDq8os8uG7PvyRAq90SVojVhavRSAM6qThVxxY9eaeHd0/KZ?=
 =?us-ascii?Q?snQA1VUtdurm4v8GotTL1WsO05QB25YIovihabd6vM0H3CPNRwoWgZA4KgMS?=
 =?us-ascii?Q?MjBM8kafeg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae658caf-25ee-4824-658a-08dee86ea835
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 03:58:29.9166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddS/3jrRuhD/QbEyB0cmigw+k0liIFua0lLG7Be0lEaOBUhZwRbrE5fywNozdQO+hhLIWNpSvFlSfqeHOgbHY1cJ3HR0beAodt9hvJqGQGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9322


Hi,

> -----Original Message-----
> From: Nicolai Buchwitz <nb@tipi-net.de>
> Sent: Monday, July 6, 2026 1:08 PM
> To: enrico.pozzobon@dissecto.com
> Cc: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>;
> Rengarajan Sundararajan <Rengarajan.S@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Woojung Huh - C21699
> <Woojung.Huh@microchip.com>; netdev@vger.kernel.org; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net v3] net: usb: lan78xx: disable VLAN filter in
> promiscuous mode
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On 1.7.2026 16:47, Enrico Pozzobon via B4 Relay wrote:
> > From: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> >
> > The hardware VLAN filter (RFE_CTL_VLAN_FILTER_) drops VLAN-tagged
> > frames whose VID has not been registered via
> > lan78xx_vlan_rx_add_vid(). It is left enabled in promiscuous mode, so
> > packet capture (e.g. tcpdump or
> > Wireshark) does not see tagged frames for unregistered VIDs.
> >
> > Clear the filter while the interface is promiscuous and restore it
> > from NETIF_F_HW_VLAN_CTAG_FILTER otherwise. Enforce the same
> condition
> > in
> > lan78xx_set_features() so netdev_update_features() cannot re-enable
> > the filter while promiscuous.
> >
> > Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to
> > 10/100/1000 Ethernet device driver")
> > Signed-off-by: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> > ---
> > Currently, on microchip lan7801, enabling promiscuous mode does not
> > result in VLAN tagged packets being captured. This patch fixes this,
> > forcing the RFE_CTL_VLAN_FILTER_ flag to be off when promiscuous mode
> > is enabled.
> > ---
> > Changes in v3:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v2:
> > https://patch.msgid.link/20260701-lan78xx-vlan-promisc-v2-1-fe3b180667
> > 28@dissecto.com
> >
> > Changes in v2:
> > - moved VLAN filter logic into lan78xx_update_vlan_filter()
> > - Link to v1:
> > https://patch.msgid.link/20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd
> > 8f@dissecto.com
> >
> > To: Thangaraj Samynathan <Thangaraj.S@microchip.com>
> > To: Rengarajan Sundararajan <Rengarajan.S@microchip.com>
> > To: UNGLinuxDriver@microchip.com
> > To: Andrew Lunn <andrew+netdev@lunn.ch>
> > To: "David S. Miller" <davem@davemloft.net>
> > To: Eric Dumazet <edumazet@google.com>
> > To: Jakub Kicinski <kuba@kernel.org>
> > To: Paolo Abeni <pabeni@redhat.com>
> > To: Woojung.Huh@microchip.com
> > Cc: netdev@vger.kernel.org
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/net/usb/lan78xx.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index c4cebacabcb5..cb782d81d84f 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
> > @@ -1499,6 +1499,17 @@ static void
> > lan78xx_deferred_multicast_write(struct work_struct *param)
> >       return;
> >  }
> >
> > +static void lan78xx_update_vlan_filter(struct lan78xx_priv *pdata,
> > +                                    struct net_device *netdev,
> > +                                    netdev_features_t features) {
> > +     if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> > +         !(netdev->flags & IFF_PROMISC))
> > +             pdata->rfe_ctl |=3D RFE_CTL_VLAN_FILTER_;
> > +     else
> > +             pdata->rfe_ctl &=3D ~RFE_CTL_VLAN_FILTER_; }
> > +
> >  static void lan78xx_set_multicast(struct net_device *netdev)  {
> >       struct lan78xx_net *dev =3D netdev_priv(netdev); @@ -1533,6
> > +1544,8 @@ static void lan78xx_set_multicast(struct net_device
> > *netdev)
> >               }
> >       }
> >
> > +     lan78xx_update_vlan_filter(pdata, dev->net, dev->net->features);
> > +
> >       if (netdev_mc_count(dev->net)) {
> >               struct netdev_hw_addr *ha;
> >               int i;
> > @@ -3074,10 +3087,7 @@ static int lan78xx_set_features(struct
> > net_device *netdev,
> >       else
> >               pdata->rfe_ctl &=3D ~RFE_CTL_VLAN_STRIP_;
> >
> > -     if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
> > -             pdata->rfe_ctl |=3D RFE_CTL_VLAN_FILTER_;
> > -     else
> > -             pdata->rfe_ctl &=3D ~RFE_CTL_VLAN_FILTER_;
> > +     lan78xx_update_vlan_filter(pdata, netdev, features);
> >
> >       spin_unlock_irqrestore(&pdata->rfe_ctl_lock, flags);
> >
> >
> > ---
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > change-id: 20260623-lan78xx-vlan-promisc-83af8a48a7ec
> >
> > Best regards,
> > --
> > Enrico Pozzobon <enrico.pozzobon@dissecto.com>
>=20
> v2 is marked superseded in patchwork, so FWIW
>=20
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
>=20
> Thanks
> Nicolai
Reviewed-by: Thangaraj Samynathan<Thangaraj.s@microchip.com>=20
