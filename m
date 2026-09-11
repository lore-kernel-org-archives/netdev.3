Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF937B3FE;
	Fri, 11 Sep 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107202; cv=fail; b=tIkh09zF8TbKJtKyxPOXiRAKaXjtQuxPXGhjsUidPDAiSi9CCxwtyyJlNDxi9KpvRD8ao+PHfr4vvvsj/sm5OnkKDocl4EvdiQczKAf+aKjzZmmzlIIj6Ta0n5w3ip5VvdNCbj2Zj/ysmKSYf4K/3VCdHg50LS5SS5K8Sprjkb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107202; c=relaxed/simple;
	bh=T3/l0dylo6O1Ca4BF/BoLyBVoCfQtCQGlMHePZxGJ1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LJsWd+xmghBYNGNLLOacP7XplcWjRrb7SeLBuUdnENfz5yedL4TPmKE6hB9lyuHl1y2MufZyb68EHjrpmeVMcKVaZGO93Va8ROoGywT6Xb/g3H+7jLjvYbjY46hH+0EIeuPLl+QqbDzv/W5cbKf9AGfWHc53Kv0hfjVIl3kvLug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X3YLwaaZ; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X3YLwaaZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N17fdMf7ZPS6qPs51DrRjxBpjKsbxbdS7sEU7vF1DolHvB6nLsfudwn0rKZuiIzZY5dw3dgm6UdD7kPj2P35DTtJl5Iyt052RvFqcGyOvr94q3/eUZzYLifcFTGfy8F+uvPwyp20G4gUe+7vYPEi7ydfbXTlF09cfH0q2paMdqQ4Ao8CtTtbIL3z0gpWk8ivQZZbUlEWrUoL7TGBUDctJVZFSHnAzQosFJGWcP2BCYAr05GLvmryAknDZkHV0o/m32ucE/S3Ydbvk7dfus9lUShUT6rh434vAPtO8Dp6oUIliAcW3+GDoiiUmjFjzmM467vq4ZAS3teEfY3koW9Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2+bNwq+PyEXo21aBerAID8DzcHLlLEsB10Qm5cAqW8=;
 b=tIzzuHW8nOXvOx/+CW89AJpvtz9GF0tLX57EFrH/Y7BqL3AcyB8vXaO+FRvTpzq+PoI9vkcZ3rfX+39gTPm5vL/JvpyeM+og/TlVDG0gNXchG2Zg6mPqoJ29icsP3840EzgNA3GTnfMPfSGY65cv3a/nKn/qGIwD7Me3l/8tyg3yeuTzMP5z2+oLbxMtlevcIyhlaRzXXUaButM3NMXw26SZBHMEKdpDNqiGJ1f8m2Qdbk+QNUP+88YfMuSLo73/nDEZelaT0n2JyGNGerdBcIITHMxCXtw0vykgL2apWlOaB5hYFBiDXO0AH0c7ITI8bauajLYpJSFspqdTe3EU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2+bNwq+PyEXo21aBerAID8DzcHLlLEsB10Qm5cAqW8=;
 b=X3YLwaaZQEVn1aHwM/dIJ2RQDpj5Fb1SvskLYXn5EQlMEis5Rz9OUZON04H/uXw9hSqWHdGpDK0/E/RaOLlqdXz4GehiK2byON/2hicq+laX44UXDYi8Xdpt+C3GVfEbQwgTYqrlFn2YnIbdaaEBVJGeAGgKUZvc1wBIvZTM0xdh+luvcd4B3/tq+gSHOjiEvdDtfdXshbMt4063AV9xI17PWUFUo0iaaz20QfolH4EeR49vhJF9Y0xcoBiQDRaWR2OW52hSC4vGZgspSmsbz/jOZg6RuU0CcI4FheMxnGhEh1Q/znbgWlK279c6VEmIuPKmTluJhLzpWpmPdqeBxw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DU2PR04MB9084.eurprd04.prod.outlook.com
 (2603:10a6:10:2f3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:13:17 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 06:13:16 +0000
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
Subject: RE: [PATCH v4 net-next 09/15] net: enetc: add MAC address filtering
 support for VFs of ENETC v4
Thread-Topic: [PATCH v4 net-next 09/15] net: enetc: add MAC address filtering
 support for VFs of ENETC v4
Thread-Index: AQHdQEcVRFlkmDkDWkWAea/Sk77qa7bHrFsAgAE3u9A=
Date: Fri, 11 Sep 2026 06:13:16 +0000
Message-ID:
 <GV2PR04MB117396B403525D2FCD64B9F9288BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-10-wei.fang@oss.nxp.com>
 <178903926035.219967.18291576292215190234@kernel.org>
In-Reply-To: <178903926035.219967.18291576292215190234@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DU2PR04MB9084:EE_
x-ms-office365-filtering-correlation-id: e596465f-a3ee-4878-28a6-08df0fcbc516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|366016|23010399003|1800799024|38070700021|6133799003|3023799007|10067099003|11063799006|4143699003|56012099006|18092099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Nh2Jq3fcG7iXGKahmaLzayoVSe4lom6B656QsBAtS8k5ZvfbHwJ/D5qeTzzql51Fn/hLeFquWrr0j3D7BO6qtfOzCqDc3GQdd7/+fGKgtcZN8jYmv1rWVKmM+Yal46D2a7TnPbX1mx5jA39NnZqz0zQ5ZP0+W6zDx6s2i2ATd5Op1HRbn0zS1IzL4Czy4dVMUem7Wz9fvloRAUndsVZo/0hjhriFGBCbABWtGCVFLvST/w+G4VKz5KoEy87Vk1Ok6knI5mfSrP9/fDNlQ/5IoegpEff2tNzxbCKVLSYfAHwtPwdJXhiBl72ATGnDTw4k8r+0cc0h9pDJONp3FhUZKP9SCUBR4LkI4SPhgGrsj/kcftJ1AKWnXzQCcZ0U8RwTdbKPuBgmVzCv+My9NLWEjyr6XAw1nJ/f3gaKykFWhf7Nj2Xo727KRaAKrR3RAS67QDVugiYexsG7PIQWGmO7yNvu5x90gFvSTwwNXu6Yqi2M+vXn1Yu1KsmLLRHcVg06iGFZBaSweWiwMaIeZq0Amnu4AdUs+VHVOdWdjU9QuH+uXV1x9je4yMRS39UzycQz3jx2TQtn+8BN/Iz05u4OqZfXJLhNtS2HrHpCV5q/tWEieZ3ZM+9OWoLZ3n3x+agTbIKREfNhdI8CTkaRQ6t0mRv6LE9g/skNXpab9Kh0dTuvCUPgTrSNFCeYIenx6efgX16oyl1wcOEWyeEZ4iZx3zBGn57RBdIjI0EOWR+ybEA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(18092099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/0ayxDP02to9tvZyz4gio1i3h494Ehmo70F2ZijbwTDTZYICP/EtWYq8P16F?=
 =?us-ascii?Q?82cSVvVCXAw+KtyN5Omqx6VbruaR5FBOSeYAECrervSnLzckWoyec9HxnGgt?=
 =?us-ascii?Q?Rcw9u3X2qXbXDH/dl/Iyz7+Zekis2zdDSNeggD7KE9EaKgnoXzQCDwRWWBsc?=
 =?us-ascii?Q?ivK73FDqG5ltCSsBVmGpLN3JF5pZqVf4A5COYHZ7abcxa+9mCgREYvxPtJq5?=
 =?us-ascii?Q?vjIb4Og6mguu02fMtyZE/huzyhpsezDqkg158X5PZCkBsdlwGcWWe1zuqe/b?=
 =?us-ascii?Q?q59l7D1IdNIIBLpj7uIXDn6Mz7Vwx+ohHP+CG4emN/zT0vuKPfeDLQX+v4c8?=
 =?us-ascii?Q?r2i7EsBgQmXgefpW107UT6FVgvHwvPv7CCMnHQ5c5rJrJY+GJSU0cuCspD4r?=
 =?us-ascii?Q?0Qx636dw1LhiB2+27B5792Zqaa58PMASwnq/4zNAFRu/yeHvDrMVZweHnuBL?=
 =?us-ascii?Q?im38ZCMouDTmSMVF08L4r5LXPgVhWgpzwE7W2ru6Aguo+ENxe9pD8T6V3+js?=
 =?us-ascii?Q?gU0b/oOX0hzFr0q/OVygmjcDuQkaPZGScRvP3lcY4TMo/xfZl27jBvBpcesC?=
 =?us-ascii?Q?WrcqZEGbwIXk4LDFAxz71fTCbG4Ob2DNWOD4iZpaRsVMELv9t/Yai4Gh7pxz?=
 =?us-ascii?Q?I5ddwGx/ui2uKUudIZaMURHIFNvz08ZlKyZH/iorY/8lAPEcmlyFl/e892qk?=
 =?us-ascii?Q?4X76t0IMEQ2J++pVRJO4ASHtxvuVx2lT2lYUlqCdtkXmxrlgHSKFBs3qWAP8?=
 =?us-ascii?Q?Fa3tZyge85b5Q5oOlGiCTHIFjwSHq5S0afWn8ZJwLgKr8LOqyBfJzJ6Z++8a?=
 =?us-ascii?Q?jFNDV3PCeF8/BRSkn9MjpQlQG3zwsUdnDD24TFEvi8d/mF3uNaK8R6P5Eo3m?=
 =?us-ascii?Q?ZmNcqSJErMNGlEmaK69vQK3UWX4eIF6MoQ74WwMOcIDw14r0S0oq0Nh2aOBE?=
 =?us-ascii?Q?OdI68txKyEdvfz2VlmK22IZm/OBFcB3m4S7lmfe1ad9nyS/iqzYSZ3mQEK/P?=
 =?us-ascii?Q?gNf4mN59nfSWN9AJCHX9amcJBSlB40OcVrpvBs0eHq6xMJLTBLeMPWy5YcbV?=
 =?us-ascii?Q?gw96jGD+Xw+HQhX9Epvj9QVUXLPaP7elo72yz7slk4Aefalhl7kVWE2xIKvA?=
 =?us-ascii?Q?gntaqbN0Xf/hhMjT7+SrY9uN5ApBE7J64KWG/z7tRPd5t5N5lT0LSWyDtioj?=
 =?us-ascii?Q?ILD8US5GIEWvlsfMaKtooRUShz4jQt1AnXKaHSoowrEUeB1ciEDGf0tBeGug?=
 =?us-ascii?Q?W7jhwX1SnWKNgEIYwSO/WBbiH7eIJgmTfwzjJciln92rIGuo/JYqyBe+8N0y?=
 =?us-ascii?Q?aqf2GGGRGjBLkU4jskKKjoJfZt8wNdDQKAOaMFIc6ktMcwvwL/e97m3qFnIt?=
 =?us-ascii?Q?+6K9q3hM+QsQ6ivjDMKKL+BUkOewanEzPeMIiydB6CRKIWMqZtY2Q4MzUMq7?=
 =?us-ascii?Q?d362h/pO/NjU4sLmGcg8YYA0R2FcYhinvfbicyBaSDg6fWNGh3m10nr9Huwm?=
 =?us-ascii?Q?UJelCFBV7Ffj6JUQCEPmKzbIcnFu98u/Qwpx/Kd8jHB+96agrEP05y+wGPLM?=
 =?us-ascii?Q?ojjycDf0j+PjP2Mi2PfXsTDXYEDBwfk2OeUNqYKD7oK9nkUC2HFBKQ0bPhAJ?=
 =?us-ascii?Q?2cMYghGlimh0AYAY8EcM98Kg+oGjIDlc+gYg89r9UOHEl/fNaGAzxEv7DBQ4?=
 =?us-ascii?Q?WA0oRhQuqlvAVhnkl5B2lj+RyWs0Q6KmcyjYv6TWucdWLKJQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e596465f-a3ee-4878-28a6-08df0fcbc516
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 06:13:16.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1ETCo6LXx0JgvLBama6XegLKXUTJEHg2xzGpGp9Xca4pMq0QDBYRmGsfX/ygny1vNyn3ejCLhpD5+cYRaDf3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084

> > +/* message format of class_id 0x20 for hash MAC filter.
> > + * cmd_id 0x3: set MAC hash table
> > + */
> > +struct enetc_msg_mac_hash_filter {
> > +	struct enetc_msg_header hdr;
> > +	/* bit 0 ~ 5: ENETC_MSG_MAC_HASH_SIZE
> > +	 * bit 6~7: ENETC_MSG_MAC_TYPE
> > +	 */
> > +	u8 sz_type;
> > +	u8 resv[3];
> > +	u32 hash_tbl[];
> > +};
>=20
> [Severity: Low]
>=20
> Should hash_tbl[] carry an explicit endianness annotation?
>=20
> This struct describes a wire format: the message lives in a DMA buffer th=
at
> the mailbox hardware copies from the VSI buffer into the PSI buffer, and =
the
> header in this same file already declares the byte order of its multi-byt=
e
> field:
>=20
> 	struct enetc_msg_header {
> 		__be16 crc16;
> 		...
> 	};
>=20
> hash_tbl[] is the only other multi-byte payload field and it is plain u32=
,
> so both endpoints are implicitly required to have the same byte order. Th=
e
> producer fills it in host order and enetc_msg_set_vf_mac_hash_filter()
> recombines it in host order:
>=20
> 		uc_hash =3D (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
>=20
> If a big-endian VSI kernel ever talks to a little-endian PSI (or a
> non-Linux PSI implementing the documented protocol), would the hash bucke=
ts
> end up byte-swapped, so the SI filters on the wrong buckets while both
> sides report success? The CRC16 is computed byte-wise over the buffer, so
> it would not catch that.
>=20
> Would declaring the array as __le32 and converting with cpu_to_le32() /
> le32_to_cpu() on both ends be preferable now, while the format is being
> introduced?

This combination does not exist in practice for ENETC. Both PF(host) and VF=
(VM)
use the same endianness, so no need an explicit endianness annotation.

>=20
> > +
> > +/* message format of class_id 0x20 for MAC promiscuous mode.
> > + * cmd_id 0x5: set MAC promiscuous mode
> > + */
> > +struct enetc_msg_mac_promisc_mode {
> > +	struct enetc_msg_header hdr;
> > +	/* bit 0: ENETC_MSG_MAC_FLUSH_MACS
> > +	 * bit 1: ENETC_MSG_MAC_PROMISC_MODE
> > +	 * bit 6~7: ENETC_MSG_MAC_TYPE
> > +	 */
> > +	u8 config;
> > +	u8 resv[15];
> > +};
> > +
> >  /* The generic message format applies to the following messages:
> >   * Get IP revision message, class_id 0xf0.
> >   * cmd_id 1: get IP minor revision
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > index 08a9ffdd3eb0..22f5485e968a 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
>=20
> [ ... ]
>=20
> > @@ -116,6 +242,10 @@ static u16 enetc_msg_handle_mac_filter(struct
> enetc_pf *pf, int vf_id,
> >  	switch (msg_hdr->cmd_id) {
> >  	case ENETC_MSG_SET_PRIMARY_MAC:
> >  		return enetc_msg_set_vf_primary_mac_addr(pf, vf_id, vf_msg);
> > +	case ENETC_MSG_SET_MAC_HASH_TABLE:
> > +		return enetc_msg_set_vf_mac_hash_filter(pf, vf_id, vf_msg);
> > +	case ENETC_MSG_SET_MAC_PROMISC_MODE:
> > +		return enetc_msg_set_vf_mac_promisc_mode(pf, vf_id, vf_msg);
> >  	default:
> >  		return ENETC_PF_MSG_NOTSUPP;
> >  	}
>=20
> [Severity: Low]
>=20
> At this commit, is there anything in the tree that sends
> ENETC_MSG_SET_MAC_HASH_TABLE or
> ENETC_MSG_SET_MAC_PROMISC_MODE?
>=20
> Both new handlers here, and the UCF_DENY mapping added to
> enetc_msg_vsi_send() below, only become reachable with the later patch in
> the series ("net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF"=
),
> which adds enetc_vf_set_mac_hash_filter() and enetc_vf_set_mac_promisc()
> and wires .ndo_set_rx_mode_async =3D enetc_vf_set_rx_mode into
> enetc4_ndev_ops. So this is only a patch-ordering observation, the receiv=
er
> landing one patch before the sender, not a defect at the end of the serie=
s.

This is not an issue, no need fix.

