Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6F401A01;
	Fri, 11 Sep 2026 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107857; cv=fail; b=Ss1kApUgNhCuFOCXTZexW7wZTAcxt20Ovie5255+IMhoebSflhLiYHY3J+tBGO869dJGI5UN+IsYhPWNbOji1X0cT88a6W4MM8rNl3+wDVvb+iaH9pxmdrSe/6y/4fc1gU6JB8wtjCZNp+nZvPQ+nJ61airJxw/WT2eYjq0y+/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107857; c=relaxed/simple;
	bh=SLUuB+SGjxJKFhI1AUF1725GzzEd7pyuwv/vmmYmBz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tW/7fosXaz+7VZ8oiOOAHMxCRyJxDuVZL8aIP1ipRouf4u2d9vb3yuE6eZ/sBINXgQMK+lMIQe45cPUeCaDNXE7WrVbiRj1ZAbOtzHKyikV39qlm/817EtLvUtGYz/chi9Dt2EX56goNjJXFwBM6v2E35Nb6cqyhcEpGxg6VUqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n3x9evm3; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n3x9evm3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEyAG4Y1aEyoGe+4IAsukT2pWhVoVQad3w1obbmOuo95hyQAElbr3eAYwSiqN4IDJe0CwIBnnUYXZt6NfYMI1VmU42rD1rbOk7XOiowMRjEjjo53IKtJffvMoh1CoMjEjT3VaDiIHFOFvARJWJX32dY4Sz/y8/aevtYqYnG+KXV9fEayJTRBbdPfjAAq+9thYJh/M4J9NVbqWLGUm/NQyBAcGN6hDJMWuz9O9lrulzCxi6I6O0sw4qdOyMyDyuzJ2UKALBczLFQfmABb3V1kAZOpWLXZjgFqLp88SmGrEpzK+YbiprpkbSNlqSSVeAGyhaJeYF8ZQAfNyvfIf9aUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1pjiMgrgxHnhF+97IHymwBV7l7ZRs5WpqrAwM00lQw=;
 b=dHgQBGl7kCziQlwinIM2qZzR1Ff1IK6hF6/F96G7soTXsExJz09KdReubOvEkAl4q9W0T+wCqD4gb38oSFut7xPjg+aq4QxzawpBZ8q1I2EdJdy7sk6/zBBC2tQVASiyh0+SYSnZsPvlDgkP3uxZeuS2SlEK76J5aFFpOWqbfeK2K95cNMS8U1zCPkhHO3KGaf2Uc/+Mmmutb8xClI0Sqqd3sa4asgaa4Wu+l+dPxraYZM9ACPL9t/j3v9iK8CPDDkEV5yzCrKpQi8uAVsLMVqRvTa6uuutd3LtH98hNnK9FSmafbpyQhTqdQ8MIywp7immKixS6YmZuo0NzKyfx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1pjiMgrgxHnhF+97IHymwBV7l7ZRs5WpqrAwM00lQw=;
 b=n3x9evm3EcVGyZ/GDflDkzZXHq7JkpmdgMBfa0UaS4N9/VIRuZSEm0KhL3bNC+O6AbAyg7ZgsiT+rgY77L9mgRWgnVN6fR/FdTOQoPM6QDYER5HQogsjpqYpBheseO5X2bNUpoqmOHCz4hNfms0gVPY4vJbmTgw1g/FKRuIi0hzv0Nnkkkn122sn0TFnOQ9rYrpXGC79H8QW6HdJiB3IDhyZ/IaxQVdJPnwlZpZqp3PFUu0bc8s+nmU6lvsaGDRQKSLeCtIwzLo/254dbPBReiVz2moL15FQytGV+k9So4P0lvEG8VaIk+cx2gXUq/9xnftirlI0I3gzmNCzoxXSFw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DBAPR04MB7448.eurprd04.prod.outlook.com
 (2603:10a6:10:1a6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 06:23:58 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 06:23:58 +0000
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
Subject: RE: [PATCH v4 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
Thread-Topic: [PATCH v4 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
Thread-Index: AQHdQEcd/qxt76KPf0u5+YY0kYdX4bbHrF2AgAE8fbA=
Date: Fri, 11 Sep 2026 06:23:58 +0000
Message-ID:
 <GV2PR04MB11739CFF054979A7598EFE26688BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-12-wei.fang@oss.nxp.com>
 <178903926180.219967.4329633531157866810@kernel.org>
In-Reply-To: <178903926180.219967.4329633531157866810@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DBAPR04MB7448:EE_
x-ms-office365-filtering-correlation-id: 8ba3259a-d2c4-4042-adbd-08df0fcd433c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|10067099003|56012099006|11063799006|6133799003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 VfFTh6MuObMr+Pw/2lRB+bPxfRYREcvnmYgLXocaR8hrDUWe2ymHdy6X5116E4T2xan/A94Rbopbg1n/zHd1CdBkV0TqB530VS0yUz7WPLdNx5E7/Yek6Z14zbMsZflY90nKNmAKo7RSwqEUy1IL9t6szpFU2+hJ+kt+vcfn/cfoNkZ1RBBryw9L6Qsre3hsnWM/kd1ZKoF+4M2X7h2ywVlXygigSYxFuF15yDDyLu2Qk7eMtXUQ0xxwWDIvsQQTmj7tywa08O4kjdrP9FhfSlrRlX1Frt1aaEmHZwwA6aQ76JTGX0caTdcCtSEU5lGr8lNkcQ/eot635t9HtDmvC6CQklGq8damremp8B3uydn14JZBHfWiZBthoTGKihrt1l/NgWO2DR2VDHpLeNmuP2zIXQHlQfIx02iguBtWdlWgtvnoVZ3k+KbFuxPxaesFbFIL6GD7D+HzjdbF82tx0hzDg4wh3EtmtpeJ9JOShzwqrYgcqAjXf6skO0I9y7x8O6QSKlTnLAlZtBU9gP5QFkYF//gaQ3kpd0zE+DyKs4XaVckG3jYtjTiMFqv1v9LVoqH8Gx8RvUHcbwyiRPRqSBOYmpCeJ+tdyEGzFwI/iuNFmt75/7FWsZCmQKEUawJ1/e/+w5sbvwUvFsGOqMe6voaZYqA7K+4Mukv1GaxdSzkd10BlD18YN08eR4GS02pPOP3dqP6UkTlZMEtSTTPFNTZlbCN3c3B/dY729BpwgAA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0KXxE1uQBBT2EtW4AD1eIGwjjL1ifLfiAnaG9e4M6NODkCHh/oDwe5gldhWp?=
 =?us-ascii?Q?UkFjFmypL0St22CKzabTzOdHREVCOQ99a49jhnirt9+Vb8QW1VaQ390irt6W?=
 =?us-ascii?Q?WpnHmgzss8H0mrmK1twA5TBJckBtn/zX24rRxEdeszfOIFgz0hhkB5dnoAqN?=
 =?us-ascii?Q?6jOqby1ktTcwPaH0byDjq60nwBq/YbFDQljFSMrVm4h04ieZugwWezVQWzUl?=
 =?us-ascii?Q?CCpsbGyp9Od8w3A4Ta0epPoAEGkRGwh6pHACC7ugbkIfxzk3zo8lb03ZuKJZ?=
 =?us-ascii?Q?13d8GZ61P9I/fI91AMJIYQ5uYkw6ddMPtSoVj2E8PSUoEjfSEvB4I5n8kWD0?=
 =?us-ascii?Q?t5kGYUMTw92gyJljyWEHYzyGf01l11ozFcu2MTe/ITgmuMoRqiOtwjZ5DyhX?=
 =?us-ascii?Q?9XK8hTAm3XbzWQqF8OjgTTkj2hupLvMutgkoEU+pjfK82FgYOzqw2Hya8pjN?=
 =?us-ascii?Q?praCkPuqPmoHDmL/C9o73Ei0NpQWsu6idAm6uDTUdOs25qCU/8ppjZQ2cMxn?=
 =?us-ascii?Q?pyaWukmK7DgDKBDQsZzP2lJVvFwp3aSQ/cKLcjFZIce47FmbncKhAylSf1Az?=
 =?us-ascii?Q?6cWVEW9FGi5UCWVBfVoViui4X24zj6QL64Ce+2I/al6BB71qbDz41Q56i0m5?=
 =?us-ascii?Q?lIpEQ3Mr3cVnkQMDEK5A+XaBfw7JodEx7B97TVdTL5Chqq4KrxEg6Pp3WJzv?=
 =?us-ascii?Q?n3f0ivqnJZAZ4CDyHVg8vcRiD+iDP+f8gOAAcJCGwf1vOHLC1Oec+16fNJrz?=
 =?us-ascii?Q?eCeDezGjsVHoQWNyhLYCGugpYOXYi5AB81s69qdyVNDAgXWxX8CVMR5ynzjk?=
 =?us-ascii?Q?HRnLzC5InpcxyE+hYkmWPGY7rvWbJSO4NxRZTmag8T1m8+wOsmDstFNWY012?=
 =?us-ascii?Q?al0xGC0E+zcM4Hm7DwUqEHszGkMdhGYxktgOix4+bCX7NISWq9GT6FOhv3ns?=
 =?us-ascii?Q?0AVg+tjUsQrm84CkJuK1ZYNX/WL1YtH4nMAAAE1gkjDlAvk7tlmr9lH3ieg1?=
 =?us-ascii?Q?sqFGw/o4y3z4wkKWcK3Lf2qcqK65n/JXls40occFi4rpgs5ZH3m59Jbl3aJp?=
 =?us-ascii?Q?yXb//zoIgsQib9nTHDFjBKzAE+uc0X2FHEhNCl7xIH1LA+OR5CfcOIbsOeW7?=
 =?us-ascii?Q?3vG6CTfB63/xH9nllOTSmKeQTCB+KAg9blRVQEtyitoptT1Px50WqiZFLNud?=
 =?us-ascii?Q?aXnZTVNXRqrx9B6Uk6iCN85ODe+LPKaMc4NbNOvlTsz65WnQhmE0pTy5zGbr?=
 =?us-ascii?Q?zS4VerbfoBLMhZNBcflGP/Jb7qyMIpaWpk3n+4acOJ5yyoK4k0Wld0FmT7pN?=
 =?us-ascii?Q?kmSnnew24rcpT9tW24uZjcFvMc1dpsxw5LZbW+zaYEueROTwj0hRPYrv/Mfd?=
 =?us-ascii?Q?3i7+HZxH/bU6OwZTl4wlvb9zzg8bralaag4IrCqZEWWN9MxBQ/VBGFBLU5Fm?=
 =?us-ascii?Q?L3UuCMJzCzP3lpWXdWniZ5IYV5TTneXO/+sJd3XJSJt/gFms7UVaD0w8d8FY?=
 =?us-ascii?Q?Efc84tdWCcaSn7eM17svCWMQ3EdarOqSWkdOCJFtPkaIY7kt+4MCYnv8sOaR?=
 =?us-ascii?Q?E84vNZFyqsJxIwUjEoZtSaaSukksgKmxjMb9/8g5DDLhjvJ5VYDma29Jlcxk?=
 =?us-ascii?Q?HuH/3/NQT5mfaJjQeiW02h6C87FhfPZMg1BjYdTYH0MfvEUQfToFEQzFaf+h?=
 =?us-ascii?Q?syga4lHq/n3rZyWcTYUTRjhXxdMnM93Wz9lPh/gHNjHQeuI6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba3259a-d2c4-4042-adbd-08df0fcd433c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 06:23:58.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Vzu9Yv2LiC/MNSbvMz5QzwaK+E5bheDaOGMRQ32+27qW4QzZ8OJ6XOE0Pd8KBu20zU1a9r5p+tsGnEb1AEBpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

> > @@ -542,6 +559,29 @@ static void enetc_msg_handle_rxmsg(struct
> enetc_pf *pf, int vf_id,
> >  	kfree(msg);
> >  }
> >
> > +static void enetc_vf_flr_handler(struct enetc_pf *pf) {
> > +	u32 flr_mask =3D ENETC_VFFLR_MASK(pf->num_vfs);
> > +	struct enetc_hw *hw =3D &pf->si->hw;
> > +	u32 flr_status;
> > +
> > +	if (!pf->ops->vf_flr_handler)
> > +		return;
> > +
> > +	flr_status =3D enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
> > +	if (!flr_status)
> > +		return;
> > +
> > +	for (int i =3D 0; i < pf->num_vfs; i++) {
> > +		if (!(ENETC_VFFLR_BIT(i) & flr_status))
> > +			continue;
> > +
> > +		/* Clear FLR interrupt status, W1C */
> > +		enetc_wr(hw, ENETC_PSIIDR, ENETC_VFFLR_BIT(i));
> > +		pf->ops->vf_flr_handler(pf, i);
> > +	}
> > +}
> > +
> >  static void enetc_msg_task(struct work_struct *work)  {
> >  	struct enetc_si *si =3D container_of(work, struct enetc_si, msg_task)=
;
> > @@ -550,6 +590,8 @@ static void enetc_msg_task(struct work_struct *work=
)
> >  	u32 mr_status, mr_mask;
> >  	int i;
> >
> > +	enetc_vf_flr_handler(pf);
> > +
>=20
> [Severity: Medium]
> How long can the SI stay in the hardware promiscuous default before this
> restore runs?
>=20
> The interrupt handler only masks PSIIER and queues the work:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_psi_msix() {
> 	enetc_disable_psiier_interrupts(pf);
> 	schedule_work(&si->msg_task);
> }
>=20
> so between the FLR taking effect (PSIPMMR[SIn_MAC_UP]/[SIn_MAC_MP] back
> at their promiscuous reset values) and enetc_msg_task() ->
> enetc_vf_flr_handler() -> enetc4_pf_vf_flr_handler() running, the SI keep=
s
> receiving all port unicast and multicast traffic. Since the hardware defa=
ult
> ignores trust state, does this window also apply to an untrusted VF that =
has
> never been granted promiscuous mode?
>=20
> Is the window bounded here? PSIIER is only re-armed at the very end of
> enetc_msg_task():
>=20
> 	for (i =3D 0; i < pf->num_vfs; i++) {
> 		...
> 		enetc_msg_handle_rxmsg(pf, i, &msg_code);
> 		...
> 	}
>=20
> out:
> 	enetc_enable_psiier_interrupts(pf);
>=20
> so an FLR latched while the message loop is in progress is not serviced u=
ntil that
> loop finishes. For a trusted VF the loop can reach enetc_msg_get_link_spe=
ed(),
> which blocks on the global lock:
>=20
> 	rtnl_lock();
> 	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
> 	rtnl_unlock();
>=20
> Can a guest keep msg_task busy this way while another VF (or the same one=
) sits
> in the FLR-induced promiscuous state?
>=20
> Would it make sense to force UC/MC promiscuous off for the affected SI as=
 soon
> as the FLR event is observed, before the tracked policy is re-applied, an=
d to note
> the residual window in the commit message?
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
(interrupt latency plus a workqueue wakeup, between tens and hundreds of
microseconds).

Third, moving the promiscuous-mode clear into enetc_msg_psi_msix() would
not give a real guarantee anyway: the guest owns the FLR trigger, so it can=
 simply
issue another FLR before the workqueue runs and return the SI to the reset-=
default
promiscuous state. So the hardirq clear does not close the window in any
meaningful sense.

So I'd keep the current design: clear/re-apply the policy from the work ite=
m.
No change needed.

