Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200937;
	b=d0Ch3Hd4hqqr8tQavx2n0lcUUDIQNo89+fmFL3I+Qix2QV2n13YVavQCjduzX7dMwx1E
	 ya+ILlIuJlqON74olycgc4KOsdY0rvyNx870xrRi4K88c8PQDTij914gRyM0gw/eZRkNZ
	 IIojBht/nqNjptyk6yueJFXTyAZsELfnnTWSRun1VtyZrdglAdbQVcx94zUb7XypVgeJ1
	 bwKcu1TXHyreqASW0jDizppWqTYkgq7+HMVYkhRpVgVvT5ixeLqJmGIefdNxfox80rpJl
	 d2WsdHeV9jqPcQbyqXebS9TazTaVPEU0hwAttlPD9bXPHuFzMttbWGlIPNAg1AKyiaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200937;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XUfjkFVr6InBR7gd063NhEYfgOlBDAIO5qaHg+umjqw=;
	b=S9slgHNIYwCvHLdw+W6ZY6YoyfhHlKmA9I7B53/HEsNfogmmUWoBSTkiziCvbKJ2Ei7t
	 Saf80rTsM/GMfckuS+F0mPN+ARiftYXWP2/6tdr+llxelLqar6DeZnhjFlwBiA1G5SIVL
	 iu5Qgw0Heino/hOyT3BQ9EDoUNh1vL74TlGIHVmsZA7Xt7adGWf9kkfUgoRdv7b6q0IoM
	 /e+WkOVM/DiGyL/roo/8NQfSfNSfS8QjXT1SWynGxY78qkC4P+45lCcZ+tDEulkHBT9fl
	 9YLNfpdv90Hyc1Rvkxva6XvZJgDP8XJqwuNCZS+Aj4GFrMKSDZquDelDtOhZK5YLmLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=n46f5XQa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.41
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF6606A320;
	Wed, 28 Oct 2026 15:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04BF6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=n46f5XQa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tsbcl5Fq7Pb0aARfyLqDjqquuRcVlX3BQK74eykqSxLJUr0uOfFLC/SWV4oqkaTZxyUzIfOxdI4HXsVHY5R+R7f2JkSRzjeJNUZcKLA51U/yBpiEABasZlqKNy9G1YBbszNSn+UsykoHPcG/C+t+8XRPTlbsPCz+Vu4asWht42byM76CXZbyH+2GiQRMGBoKm5n/ZB8lBjuZ1DldqcThs1usqFZjfoaKrsV9uyXpMqUw9811/ql/WKZppL4MoYoekX84lV8DexpJvS4QCnI5Gv0N66X1kgmjV/5tg4obkphDXyOz7lxClYdXRL0q0+aGdYV3+gYK1Sfz6nTPGtvcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUfjkFVr6InBR7gd063NhEYfgOlBDAIO5qaHg+umjqw=;
 b=eIU3XA782NUgJudVVJ7j/gxuyzJWc9BZGuaojA6X5oStPJOvi+hoO2O6H6ihCNXcsrVQehKz2kLCyJMyVBA+gWXdv0ODjvKzbPzMypcJ2YJnVRvmJ7Wrh8ILv9GDuVIheWT7Cbpg8oTB3KjwJxVVXsjiNSegb8DYu/GA3K3gxRFcmvCvjjmfvafP4Jz6KmgF6+bmKXZhocJ5ifFxtBmU5B9a37xLnQjfNDKLvj4nU95xrG1/p8t4ePFg2vJbKiKlLf6onwckizd+W3Ja8OiYpidGAt6Dp+g8ZtY2ytkSKhbAroeEIonaD4QCUbMQ73XyxLMH/OdkT1eueW3/pY1deQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUfjkFVr6InBR7gd063NhEYfgOlBDAIO5qaHg+umjqw=;
 b=n46f5XQaArQ5GvcnuPwITmTDpaPtMihLCl6r7B5B33f9x9zDgYA1B0kRZzMV75rPMXHlmQlxkN6UPnByYWrShk8/KDPU+gYQ6YusYfTMO8ZcY0fzDamc2uwDqog2M+MXxXUH4eIMqBtgkZtS1FzF282NEF/eSTDYrdHwF4sLNC0KVw/ho9NC+d02bPmyUQ7A7KGAui2SmCpoma+xRNdWn5kD82TyVyCBzk2uV3MLHOx4Djr0FfUY4gw5n64EEufVjTYwuSM+WWkH2Fj8VVpaoQumKxye6Xg9/GtakWCo7ayT+/Q5MQuqsfKFM/hphB6Pp+3LNg27K2WQG49vIo0WUA==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SA1PR11MB6920.namprd11.prod.outlook.com (2603:10b6:806:2bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:22:08 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:22:06 +0000
From: <Woojung.Huh@microchip.com>
To: <cbabroski@nvidia.com>
CC: <Bryan.Whitehead@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <davthompson@nvidia.com>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next v1 3/5] net: lan743x: quiesce TX before freeing
 the rings
Thread-Topic: [PATCH net-next v1 3/5] net: lan743x: quiesce TX before freeing
 the rings
Thread-Index: AQHdXLZHoeFb/LnUBUqI+TLbogNxR7cIVwUAgAllHgCAAWgT0A==
Date: Wed, 28 Oct 2026 15:22:06 +0000
Message-ID:
 <BN7PR11MB28364979AE4BE3A7D422F5C8E76F2@BN7PR11MB2836.namprd11.prod.outlook.com>
References:
 <BN7PR11MB2836EB5375FADA5AAB831982E7662@BN7PR11MB2836.namprd11.prod.outlook.com>
 <20261027174414.578524-1-cbabroski@nvidia.com>
In-Reply-To: <20261027174414.578524-1-cbabroski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|SA1PR11MB6920:EE_
x-ms-office365-filtering-correlation-id: 2b22a00c-3b96-444c-efa8-08df35073a16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|261026121527099003|56012099006|11063799006|4143699003|10067099003|261021123027099003|261009223027099003|261022105027099003|261022075727099003|38070700021|261026140227099003;
x-microsoft-antispam-message-info:
 iOyB/ygaS34i6auqgiOVLriLTBSyfa0YV8zKjRwG5O3tPdO8ZN3RhMS/bDDVUF6dZOUHswjvieHkr2A2pqUqc+qsnSdgxGh+4/UOVqsz9lAkgGzUBDnJTEx/3TCWSBHR1vuRaMNF2PYskqlKbrnbV3xxCsxIipSdCXjCOjIW8eqetgKUjgWV+uOp/x6pmWNFajanEfOzfQpe/rnDBKnAbyrKka4rJlcK4FL90+hSMP1lk+h3w7yDHS/6JapFuptpWfq+Vu54j9ZKC9iSJyBnPmjV7UhIN5OISLoAb3pKT9FYX4yjlNBVPiAzlaKY2tLPnTA75UEMsOyjiWIb0LZgvGA1q8BRH35qyFX7Fp5rc0gnYTuNqVtm8ysN95RTdqgSCqfeskbPqvKGWEHr96B1zZcXt25w8aihVN7IUB7c3cZ0Ag85CUN1dJ6WQ03u4PQG2OZisH/CFIoybQZvR5WpPGWJznQ2IcUqrUzPPaTk7w/PL4QDP/kbp+uGeoqeHmXFjpZxGA59Mv9Q3jBNOCdcfJFeW4/7/Nr/8aQeJNHcpiipgYqDiVrSALwTnzxOY3aqfYJjqLx1syUm8VhWAOu0N0f/oE36Q7BuxS+QLIc0sVeD42s2bYI3da9QKSz0z5GYhFZyOWVwuLmJsCe2u5U5xr9hw5Z3H6TtZFlSg6SBMeU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021123027099003)(261009223027099003)(261022105027099003)(261022075727099003)(38070700021)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oqT9xOvPKxCWyDY8vxGBZK9FKRwteQawYcXaRMuT+o2oJ3MLUkzvON2pPXOO?=
 =?us-ascii?Q?NgUSGkyI6qzDG8Zw0vr0wFVH6OQLjr4MDhr31N81TLGMffSBbtjRSulReOIo?=
 =?us-ascii?Q?Ii5WR30Fzyx37Qshv5i6SaA3Zd+6oajMYNK1Znlm/DdeXIjy18gvfTAbxdyj?=
 =?us-ascii?Q?7skXPIkypBCn3Xw10cyhd3RQAhwzh6kKQyU2oFCcOHqsomcUm9f2wxMseXrz?=
 =?us-ascii?Q?7ej2eghfyBCKW8e5jMKmXdCxGgv3n9HfTR8xxZxXVxrA8PrbH5KvFtqE1+Cz?=
 =?us-ascii?Q?VVbr51lW9cnQMBcFTznEGmg/ffyrKdQmu5LD0kdJXzw/xZ0T3c+HbPW55991?=
 =?us-ascii?Q?KWjkVM+e/OoQHyItUKgo+XNakUkXkPwf8bQ5zdo1dOpRL52AR01kLpTmwzs/?=
 =?us-ascii?Q?53j351znD//F51E21XF4xx3VxytvCZ8aGxBBi7mQ+JrzgqXmsyP8ykUDEwMO?=
 =?us-ascii?Q?sKegXbX0q28WZlTOWneCMuufl4ntXHPjEX+Rf4DvbcxCQYX08OqqH+KNmoxs?=
 =?us-ascii?Q?IDXf4bO/DELw8P83kG78cs1VcHRVPMjSWgoIKoMoklooJLlJlZh5Bmx6DC6O?=
 =?us-ascii?Q?bXVBGG1RRJVjVX+mj0RXiE7fCf4Vm0iLDd1FvW0XdGyr1p8i2KtiOCVe4WyS?=
 =?us-ascii?Q?VFLUSOiVB8+ih1X/cdeFebAN4u3+j52bzW7KBJXaG8oelkdwcVsWBhVIYIsE?=
 =?us-ascii?Q?PEDAa/64PLyTCbEi+I++m0+1mvP6iUPRxCWQ+ks008brpSf8rvOh26Ce6hcq?=
 =?us-ascii?Q?aKm9oyyF9u2+Tv4VgyA1rQac0h9hOXRdYqvJ+MZ/19a+vK5MQiAApICcUhlT?=
 =?us-ascii?Q?RKZwXTLUaxu3NvatEgszNoTgX013DQNC6BfQdks9JTECh5BVLMGK+rn6zW/c?=
 =?us-ascii?Q?C5VkWu8HnUpwg9L6co9dEiHoG40IaI8UO7bUhUuzpEO7X0cwwFFDfMdoyFCg?=
 =?us-ascii?Q?Kvc3A11KcnrZ8RqpW4lGkwjxfDhiPL4at3deRvudhuFaLBe8GdxUogzqPG4M?=
 =?us-ascii?Q?mnZK7FzwC5zRag9/ul+/kA//UxGbb2mSkFdzp6gawlKY9jk3DEmjCbch4CPH?=
 =?us-ascii?Q?J8/oO3SuSnO0euqoBoMaeVP+SM3Cj3dtCD4T8aUT4PxfJ5mlbW006TZGw4l7?=
 =?us-ascii?Q?O4JO5UZ8kp+1TOBRIcPTeaImsW7L/Jqwh2ZD9Y90Nhv4QRVDQTvSS2iB9D1X?=
 =?us-ascii?Q?w5/Y6L/q8BY8JyKh87Z6erRY0mgpV7t2cMFMrpFu08GvuG8IcGj+rbj8ktne?=
 =?us-ascii?Q?yP8L1PgGasLzHZR4eUWWDIDmJzY2tQNwU8vnel6XhKNJ4bjNAgT1QBkRFgzt?=
 =?us-ascii?Q?JZw7QUPOKhYMHa25JIMDoLHg0HooU1eB0/lTl/gf4hxCt0xMa6mj3prBD7Sf?=
 =?us-ascii?Q?IJJ7axVK7xkuo2qAqKCQ+a5qscoJRzCbcAtaQmCebj2ZDt35oeYcU7fmv4bI?=
 =?us-ascii?Q?fc/z2/GppFw/R9FMT/3ll4la7F5fQ+yCNvhie5ofbs4TBIOnDPdxSkB1GApB?=
 =?us-ascii?Q?fj9V8lYVogPmvgmeeXZIGXCMvrULWTgg6DE87Fs8vy/XL4mAtC/cq903WAYh?=
 =?us-ascii?Q?M0JpTtcR6Fmw3DV8WYmeYkuBKLQZfziy85Xg8Z+BmHVOeSnPlDlS3OafPQI4?=
 =?us-ascii?Q?0uZnDgy7T7od0S46ntdtgaHH0YGGUJ/8Rg6Kw8/1jkecX8XPW0OTZBiHp6yM?=
 =?us-ascii?Q?hxY7BF82cEXpFjPikcrNgYeig0zL1l4ghB7AP4R8BsXoCLtajuzIOTPyjnDd?=
 =?us-ascii?Q?wWX5/0KUfA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b22a00c-3b96-444c-efa8-08df35073a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 15:22:06.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vVn2O0xXjh937agBUf5aaMIRtECVgdfyh7Y5x5QJO98KP62xISzTt7Bt9nyvc4idrg0l6INDbeUO8lQceBLYwnBiY42+5lYpIb9IV24vMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6920

Hi Chris,

> > > @@ -3336,6 +3337,9 @@ static int lan743x_netdev_close(struct net_devi=
ce
>=20
> > > *netdev)
>=20
> > >
>=20
> > >         lan743x_phylink_disconnect(adapter);
>=20
> > >
>=20
> > > +       synchronize_net();
>=20
> > > +       netif_tx_disable(netdev);
>=20
> >
>=20
> > synchronize_net() is called inside of lan743x_tx_close() and
> lan743x_rx_close()
>=20
> > via netif_napi_del(). Do you see current order of calling is an issue?
>=20
> >
>=20
> > > +
>=20
> > >         for (index =3D 0; index < adapter->used_tx_channels; index++)
>=20
> > >                 lan743x_tx_close(&adapter->tx[index]);
>=20
>=20
>=20
> This was a change introduced after AI review flagged a potential race
>=20
> condition:
>=20
> 1. On CPU A, the TX NAPI poll now checks netif_device_present() and gets
>=20
>    true.
>=20
> 2. On CPU B, netif_device_detach() runs, then lan743x_netdev_close()
>=20
>    calls netif_tx_disable() and the queue is stopped.
>=20
> 3. CPU A calls netif_tx_wake_queue() and the queue is running again.
>=20
> 4. The qdisc is still attached in the suspend and reset paths, so the
>=20
>    stack transmits into the ring while lan743x_tx_close() frees it.
>=20
>=20
>=20
> So the synchronize_net() called via lan743x_tx_close() can't prevent
>=20
> NAPI poll from waking the queue again.
>=20
>=20
>=20
> The fix is to wait for NAPI poll to complete with synchronize_net()
>=20
> first to prevent unexpected queue wake before netif_tx_disable() stops
>=20
> the queue and waits for transmits to complete.
>=20
>=20
>=20
> This is unlikely to happen as part of the TX hang scenario because the
>=20
> reset in that case comes after TX has stopped. The pre-existing
>=20
> conditions that could see this would be suspend, reboot, or kexec on a
>=20
> multi-core system under TX load.
>=20
>=20
>=20
> Given that this is not directly related to TX hang recovery I could
>=20
> drop it from this patch series if you prefer.
>=20

Thanks for detail explanation.
IMHO, it is from Ai review than reproducible and/or failure during tests
I would suggest making as separate net-next patch than net fix[1] if others=
 are ok.

[1] https://lore.kernel.org/all/20261020180757.0d08b6cb@kernel.org/

Thanks
Woojung
