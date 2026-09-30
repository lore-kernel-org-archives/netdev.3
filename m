Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3664AA1F6;
	Wed, 30 Sep 2026 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811445; cv=fail; b=NzsmRVzFf1P371sKIA5xvNX3fUJJHpSNtaP1r4Nfw2HtXK5IP3ikIiZh3vjw9VIV7Jks62Gso7YC+ZRp5rDJNBO5p5EZIGKmoUwjCG2jLOCtlXViiIKTJW9m9Jxkt4wdbvjqlMe6tg2EgEB9XBVP4EvqDLnh6x7jPjqwzdR5CY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811445; c=relaxed/simple;
	bh=O/p0CcZtYwrrYJm6j18aP4KQL8V3rFzyPkltgFwQTZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mWXDnNnkFYmrIYStT/STitMGROaEOvKkshmLoXTZW9Yyo9hfoUJZXjI/pSXg2UrDKOis78tAiNm/m+oT9fSqJZRGeYg31TDdF5tNslEzIdSQjgviNasYAziHz2uftDyVUpzoG6jxh3k0cWfqTk5NnAnO2eaA8955I74chnTKC+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=BEi31spR; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=NH1Y/+kG; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="BEi31spR";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="NH1Y/+kG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=Me3hQ/ExA+OCzyRYai9eBc0+sTgA0YiPVxDBSoMo7Yw=;
 b=BEi31spRzeMg5f4Z0f4sknxh0j2aIKOa750fIbiSXWuNbLtL1XIn0TzldGWGYpvyF1CQe2ffdY1a567REjjwvu1FFDs9vA+oDCOXp9PBgeIBVW3Oezq9HmB9x7q2dg4+rrYVSnI8x5Cw+ce/NSEzEy191oSxGjCPeET9xI7ZFsgTLbhO33USuTo+4beb1/2b2ewtab0jxGZJh48auJI3LTQQHSymT01xLYjLNvpGFXwZGbVBpr7Ny2PfNVlXV9zxw79JSFzDufLD2Hs0ABQ7fcZIiAMKUc59gqugQglb1wTa8FZjzebMNn5Rxl1elWv8wQTSqzWCF+RvpxQ46okdxw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020134.outbound.protection.outlook.com [52.101.56.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D963C100061;
	Wed, 30 Sep 2026 23:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNYXjUw6qetZKtjU0JuMf4fv/mg0DwUpdGOnpDBrtEwfOGWKpDtoLRMhAdtVqaWmFnQ0mzUEhM9CP9TTLaJ+p6xgBcUf/yv6XR0az9jwXIEArgP2+CydGxb2sn2T7s5F6121hAG6Fs2CQZN0XsvBYYn84XtB1qN+CYRvWnKQU6xyJXSKSCtOGgNyZJExPNIipxheRm5djt1ruc0bmpfO4XclAFN7I4zaTZo0H9Xi1VcPB09azY2zffm4uO020FnDwOwGwSH6PimlZFlOOCGPte1Qy7pXOv/O6M8fAJOWcbXjqI4vl7znjJumOtsPH9uUgXaJiB6FPlPYbdmL2dovIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me3hQ/ExA+OCzyRYai9eBc0+sTgA0YiPVxDBSoMo7Yw=;
 b=PGrbS6b3rThAFLvv6LRI6i7aLeVh0wMQXyxWD6nMP9rMIiPbUuJ9r4DTckvTQMk4nqbZxXB8gIQCeAuiX+O6dJwYmqcHyy677Pm2jVcKc/ZbBpfAOwSscSgzCu5penLng9lxWBMZ5cBT23tZClypHH1HXQWrrNwNSaoa+LJueIAqWhq0ojfax3SbAVllfJ28LQ/7n6wtzM1YOYZRSomT6Ak+kNYfpcVv7AIPM9OR4ZFbpcyNBmpL6FKsTMdPC/o/AFFLZYKcC7rHUFLiCJ1S4CI3Ml3XUH0qxm/fqN85EC4nw2zXk/NDkFJwS7kio2CNrmNI3O0JRXjl19fgLOyEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me3hQ/ExA+OCzyRYai9eBc0+sTgA0YiPVxDBSoMo7Yw=;
 b=NH1Y/+kGm6dQ0yZ8MZbsyK5kOHBDpaQH2snj1X/796gAEHfRYjZb0lZiQIymhQviZcOPsUnx0AY585E4IYvoJxMSvBW5n7H3+a5si7OX+JVXyAEFqzwm67JG7WH31bKUpuJtWsAhAJbiKGF+1NRb6NldS4fxMAaKX4GohpmC9GWe8xZWFSoEn5+/MMzjmle9H3/jQ2upTbs0T/gEZuA2yEKu5ZxuxdUX5mOFcodwhnhWicgozSkk2BQGKQFZ3VsovWR3+PDvagPKKl+HWHgHaL0Or5QnPcB/04FqhnlRWVu79QU0DYS81UhgClKWqFaxKZ5c7UVr6OewBXSIsgCp1Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:37:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:18 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 05/13] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Topic: [PATCH net-next v11 05/13] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdUTSi2pzMpFO4ak+N/kx5A4KK6Q==
Date: Wed, 30 Sep 2026 23:37:18 +0000
Message-ID: <20260930233714.87679-6-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: 24e354b1-9af1-4556-f01e-08df1f4bc47e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|3023799007|6133799003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 6nOOE+nXb1xamWhqLok/foZreFnnUT2TrlTmmOfUDRiDjiX/SqvQA7IxH5qTHrA0pBh1pfWU7/Nx5NbcH9BRK6Ubwi8yfYubeQzDXznOSOYJtPbEAZnD4ZkVSg6XWNgZImRtP2q32FG+rxuRil6E0xEzfk58EIaFufZaIUvcLHPY9xXG4s5Agv39Za2/TSwRHyLc6XzXbCei0CIw+EgDpcJcmqT4FJcvREiuo2ABrpF+ohzIAszArG2KRL6/EMWTY+fyHXA8Bd1zmsIGdFxSznSwfHXbmxAc8SIRg2pt3pojlRZIkx177YIVVYbhWOLCOvVyfdI2Qyuy1GwcZl6X0bPrgfaN2+gHKfbIxLxGdhQLqW8rv9R0IIXw46RBSGpd/2ca0IWIt/ORSYNxvBu2oLtL49L+VzzkKqotR8sLDu7/N9jLWY2XLKQaL68kxd2yjJa1Hc0xX9yvuUuutXE42aL1EpcFOYQC3oNWnE6CFvNAqnFBiFr1gXNovIjMZvO1bpCGt9w/QpOTSLdFz0uaJSZg3oCEmXW/0ofn8RsdsR2On5pb9bFaW8I2JwyoieZiNGksAFzEaTcVdav6VZP7+1oQA41Jp1y0r0Qu5pKGnQ0N2kvd6FgjUxrzWd926RodSzguBVEXrHMrTXDZTNcwE8jBFED03vi4Jp/38GCjYjVweFBZ1aW9WzWBwAnlqlncFyI+im7yRQPVTp36/yrf4Zj+PCk2wyj98mLggsiSPlg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(3023799007)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x70jftOOux8n+vOOkA2jrASBnc2hSw9rI7qhI1YkC16HdguZplHIW0rB0l?=
 =?iso-8859-1?Q?iVeFq1+k3vcuyWL1Mak65HfvdOTfPShcaeKG492NwedmfSD1LEjD2oxjLL?=
 =?iso-8859-1?Q?JcI44QZly9WUpr78TvDqQAvJ1A8JJUNVWSBmBw3nJUvZdgc6HrRnuBg9tu?=
 =?iso-8859-1?Q?wPCahOu/UP639T/z+xUaLJSne8kPgZMZXdvCA9QtwKWaOtJ7VALZzy9+1Z?=
 =?iso-8859-1?Q?7+cvrmTkaYYLbrhJbPL4new12Ui6c4ohG/4h4xNRrsBaJR2psV4yKJ7wGw?=
 =?iso-8859-1?Q?NyTxScSBvpVzfdBDEz8Dn/wRajUxwLxqStHoLRQ7nJCtr+W7hfkdPIUNp6?=
 =?iso-8859-1?Q?NZfesE83iuatv2pZJJVtVCnXozWE3UD5S7eiEk8/6XFx8h0WDz3+Rvaqdy?=
 =?iso-8859-1?Q?OWRmRl8Ij2PKrs7K6Qn5C20tbRpdkQlvGmGLnRChOTWdLITPXT1bng8jbR?=
 =?iso-8859-1?Q?odpw9brEEJVNo/ONRZJjuYsiv08/fAyIdsmNqiCzbRKNdi9uKJnOCKiznL?=
 =?iso-8859-1?Q?d+gcKBArdO3rpNDd9huwxk/CdBgAXPEKfS8ql549i4IHgqctSWrqcCBkRE?=
 =?iso-8859-1?Q?7j3XWplLRb0IZTUJ7fgNb/SNuWNjgXs86sBnGH3u7vDACVs7Z0gs+7Asco?=
 =?iso-8859-1?Q?HhYhSDGuGonio90jKMUVHYq//lX2kjZI1iO2EqJYDIvrKs8SvM2OmQT46g?=
 =?iso-8859-1?Q?3KD3zkcWg3c3kk62nQRRlJ8NRs1/rUSji7ILoYKVk0pyB9vZ/PbUdi29rd?=
 =?iso-8859-1?Q?qX4tkaMQX/BbGXgfHijUSNCeDkVYbOPcBH26UYfJnIctSfACaHSMkiPcOR?=
 =?iso-8859-1?Q?7u2rrGReTfgZsBn1mMHDVWG/nHGXhCV1fb7LT0LtA3sNqPnmqpIi9mekgt?=
 =?iso-8859-1?Q?JDwsRFeu/2XA/E/Q86D9WJgPeDsoYdXxYJ4be2sENHgSJjYSkxZAjYnqOt?=
 =?iso-8859-1?Q?0GCYW3ZPTYBMwmcDKmHOttupFuBKmxTfGwdU8uZXBmpU7hrnvjLG7kTy4E?=
 =?iso-8859-1?Q?LWU7fUfwdpiknOSvhH0bWiLFcdo/uhWR00LTFzjbV1TDGdJPjDyQTU1EA9?=
 =?iso-8859-1?Q?3LhpDai7/e1GvjDvCBnE5fMJFsJ9cw5NpmvI9dSadHbEsEAVrLZmcVNIM0?=
 =?iso-8859-1?Q?PkV4XHp9Qcr+VmWGJTc6GJEspRafgIo1Vm6Cweqr62GMadKHWMThFOJoUs?=
 =?iso-8859-1?Q?BMkBDfBN4+ECzvhFURlRmZtdnhu6gFdrvOIb6+K4twBfLMM2QdXFJcLAPR?=
 =?iso-8859-1?Q?NztGuoAa3AoMaBk7LsCMpFsnhKLUOE4AHdTP5U9rvnhf1ZyVj9ywisHiZF?=
 =?iso-8859-1?Q?YpIvLwLzt6+i6sg4TMONXJYTv7Jky2CHNfZyBHekyqr0JoKUwSo62Y7w/P?=
 =?iso-8859-1?Q?A0BfK2TOpinFllNk0UlyY++jlkBZeUAPXUZ1DvfuR52vBOkYE51OlTViSA?=
 =?iso-8859-1?Q?himBa/sI8ygDP8lasCGc75/IdoCh+ojQW0WFZUdxAAjFrpRnTATIX6+Oe5?=
 =?iso-8859-1?Q?kLo9UFnDixbSyQBNiUVOhm9GIzH/e6CS84xMlqi9JP7ffx5blT9VPU1dHo?=
 =?iso-8859-1?Q?AiZDlPtID28j+NbciKWRi5BU2Ak0IucVIGN1j0d7TdsIykmJE+tDHQZ/sw?=
 =?iso-8859-1?Q?c3HNQCKxQMF1AuM1TXvBbVd/ehUMoiD1JJ0SIeZfKWsZIZIvnS+apJa/rl?=
 =?iso-8859-1?Q?RrxFxQciD5UKdGZeEiJIeSm22yhiicUaz+GtYp27chZ1how4Uzhz+Db7Se?=
 =?iso-8859-1?Q?RNIeZuj+7yIruFI/fsxADlbMTShyl62kack+hDkPFli57k?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	h7tz6lCP+s48lDddCN/x5RqwJt9e6QfmVwaNlNyRXQ4aeUMO09BvFb1BhnrFK/BnVgJdvFVqIWbdTpQWW3kmfcPkfkmShNjdxsYyfJEvlLbhTOTrus8J3uYZc0YXPa1Px9aGj7EIxptje5eM69mKam8gv4GD3Sm+XofruiS3CWPEjHvat78Y2SY81FCJYElIpBcZQzYbmSB+feElc9uNpJoPx9wIJGx9FN05NAdou46wK/6TY3KCdnJmUdWAn3yCVQlJgoidrUVdTEmS6oDa/vvJiW2k9grpY/Sru/AeuwEpkw+aGnNJc9JyWMRiS+pjxW3IGIL3WuIIAQ8geyJbvA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e354b1-9af1-4556-f01e-08df1f4bc47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:18.9375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eweb2ddZcGoXA9IK5uP6/qnxVT2kaE85tbyoFdSBijHNLawjJUgniMCKMFhHvdnqrpE8SORCO/eGOe4mflLGTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811441-3KLwU8POTt3x
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811441;3KLwU8POTt3x;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The DPLL core wants a type per device and a property set per pin: a=0A=
label, the direction, the capabilities, and the frequencies the pin=0A=
supports.  None of that can be read from the chip -- which frequencies a=0A=
board actually presents on a given input is a board fact -- so they come=0A=
from the firmware node, with defaults for a node that does not describe=0A=
them.=0A=
=0A=
Input pins are interleaved P and N lanes of four differential pairs, so a=
=0A=
logical index maps to a pair and a lane, and a pair configured=0A=
single-ended presents two independent inputs where a differential one=0A=
presents one.  The labels follow from that, and the two extra input=0A=
positions -- the crystal and the inter-PLL sync net -- are named=0A=
separately.=0A=
=0A=
One of the advertised properties is worth naming.  An output whose node=0A=
lists no supported frequencies is advertised as a continuous range rather=
=0A=
than nothing at all, since those pins do accept a frequency set; a=0A=
request inside the range that the integer output divider cannot produce=0A=
is refused when it is made.=0A=
=0A=
Kept in its own file, and introduced before anything is registered, so=0A=
the registration code that follows has nothing to say about firmware.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/Makefile |   2 +-=0A=
 drivers/dpll/sit9531x/core.h   |  68 ++++++=0A=
 drivers/dpll/sit9531x/prop.c   | 427 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/prop.h   |  37 +++=0A=
 4 files changed, 533 insertions(+), 1 deletion(-)=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
index a221fe55386a..819af61123f5 100644=0A=
--- a/drivers/dpll/sit9531x/Makefile=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -1,4 +1,4 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-only=0A=
 =0A=
 obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
-sit9531x-y :=3D core.o=0A=
+sit9531x-y :=3D core.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 76a2632f0ce4..4b4f72c8622b 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -23,7 +23,17 @@=0A=
 =0A=
 #define SIT9531X_NUM_PLLS		4=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/*=0A=
+ * INTSYNC (the inter-PLL sync net) is modeled as two pins.  The=0A=
+ * destination PLL that locks to INTSYNC sees an input pin=0A=
+ * (SIT9531X_INTSYNC_PIN_ID, in the input id namespace after the physical=
=0A=
+ * inputs and the xtal); the source PLL that drives INTSYNC sees an output=
=0A=
+ * pin (SIT9531X_INTSYNC_OUT_PIN_ID, appended after the physical outputs).=
=0A=
+ */=0A=
+#define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
+#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
 =0A=
 /*=0A=
  * struct sit9531x_chip_info - chip variant identification=0A=
@@ -41,6 +51,35 @@ struct sit9531x_chip_info {=0A=
 	const u8	*clkout_map;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * enum sit9531x_signal_mode - input signal electrical mode=0A=
+ * @SIT9531X_MODE_SE: single-ended=0A=
+ * @SIT9531X_MODE_DE: differential=0A=
+ */=0A=
+enum sit9531x_signal_mode {=0A=
+	SIT9531X_MODE_SE =3D 0,=0A=
+	SIT9531X_MODE_DE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_ref - input reference state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ * @sig_mode:		signal mode of the pair this lane belongs to=0A=
+ *			(detected from CLKINx_INPUT_MODE at probe)=0A=
+ */=0A=
+struct sit9531x_ref {=0A=
+	u64		freq;=0A=
+	enum sit9531x_signal_mode	sig_mode;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_out - output state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ */=0A=
+struct sit9531x_out {=0A=
+	u64		freq;=0A=
+};=0A=
+=0A=
 /*=0A=
  * struct sit9531x_dev - SiT9531x device instance=0A=
  * @dev:		parent device=0A=
@@ -48,6 +87,8 @@ struct sit9531x_chip_info {=0A=
  * @regmap:		paged register map=0A=
  * @info:		detected chip variant info=0A=
  * @multiop_lock:	serializes multi-register sequences=0A=
+ * @ref:		array of input reference states=0A=
+ * @out:		array of output states=0A=
  * @xtal_freq:		crystal oscillator frequency in Hz=0A=
  * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
  */=0A=
@@ -59,11 +100,38 @@ struct sit9531x_dev {=0A=
 	/* Serializes multi-step register sequences */=0A=
 	struct mutex			multiop_lock;=0A=
 =0A=
+	/* Hardware state */=0A=
+	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
+	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
 	u32			xtal_freq;=0A=
 =0A=
 	struct gpio_desc	*reset_gpio;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Logical input pins are interleaved: even index =3D P lane, odd=0A=
+ * index =3D N lane of pair index/2 (IN0P, IN0N, IN1P, IN1N, ...).=0A=
+ * Index SIT9531X_MAX_INPUTS is the XO input.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pair - get input pair number for a logical input index=
=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline u8 sit9531x_input_pair(u8 index)=0A=
+{=0A=
+	return index >> 1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_is_n - check if a logical input index is an N lane=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline bool sit9531x_input_is_n(u8 index)=0A=
+{=0A=
+	return index & 1;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_pll_page - get register page for PLL index=0A=
  * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
new file mode 100644=0A=
index 000000000000..3635ea497e41=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -0,0 +1,427 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Retrieves pin properties from Device Tree firmware nodes (or=0A=
+ * applies defaults when no firmware node exists).=0A=
+ */=0A=
+=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/fwnode.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "prop.h"=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pin_label - fill the package label for an input pin=0A=
+ *=0A=
+ * Split out so input-naming changes stay local to this helper.=0A=
+ */=0A=
+static void sit9531x_input_pin_label(struct sit9531x_dev *sitdev,=0A=
+				     struct sit9531x_pin_props *props, u8 id)=0A=
+{=0A=
+	u8 pair =3D sit9531x_input_pair(id);=0A=
+=0A=
+	if (sitdev->ref[id].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u", pair);=0A=
+	else=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u%c", pair,=0A=
+			 sit9531x_input_is_n(id) ? 'N' : 'P');=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_package_label_set - generate package label=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Generates a package label string.  Output pins are named "OUT0",=0A=
+ * "OUT1", ...  Input pins are named after the physical pair and lane:=0A=
+ * "IN0P", "IN0N", "IN1P", ... for single-ended lanes, or "IN0",=0A=
+ * "IN1", ... when the pair is configured differential (the N lane is=0A=
+ * not registered in that case).=0A=
+ */=0A=
+static void=0A=
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,=0A=
+				    struct sit9531x_pin_props *props,=0A=
+				    enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	/* The internal INTSYNC pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		strscpy(props->package_label, "INTSYNC",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal XO reference has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT && id =3D=3D SIT9531X_MAX_INPUTS)=
 {=0A=
+		strscpy(props->package_label, "XO",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal INTSYNC source (output) pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		strscpy(props->package_label, "SYNCOUT",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		sit9531x_input_pin_label(sitdev, props, id);=0A=
+	else=0A=
+		/*=0A=
+		 * Name the chip pin, not the driver's index for it.  The=0A=
+		 * two differ on the variant whose outputs are bonded out=0A=
+		 * from a subset of the twelve slots, and a package label=0A=
+		 * that named the index would point at a pin that is not=0A=
+		 * the one being driven.=0A=
+		 */=0A=
+		snprintf(props->package_label, sizeof(props->package_label),=0A=
+			 "OUT%u", sitdev->info->clkout_map[id]);=0A=
+=0A=
+	props->dpll_props.package_label =3D props->package_label;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_fwnode_get - find firmware node for a pin=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Searches for input-pins/output-pins child nodes in DT, looking for a=0A=
+ * child whose "reg" property matches the pin.  The binding describes reg=
=0A=
+ * as the hardware index, so an output is matched by the chip slot it=0A=
+ * drives rather than by the driver's index for it: on the variant where=
=0A=
+ * the two differ, a board describing the pin it wired would otherwise=0A=
+ * have its properties applied to a different one.=0A=
+ *=0A=
+ * Return: 0 on success, -ENOENT if no firmware node exists=0A=
+ */=0A=
+static int=0A=
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,=0A=
+			     struct sit9531x_pin_props *props,=0A=
+			     enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct fwnode_handle *pins_node, *pin_node;=0A=
+	const char *node_name;=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		node_name =3D "input-pins";=0A=
+	} else {=0A=
+		node_name =3D "output-pins";=0A=
+		if (id < sitdev->info->num_outputs)=0A=
+			id =3D sitdev->info->clkout_map[id];=0A=
+	}=0A=
+=0A=
+	pins_node =3D device_get_named_child_node(sitdev->dev, node_name);=0A=
+	if (!pins_node) {=0A=
+		dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_name);=0A=
+		return -ENOENT;=0A=
+	}=0A=
+=0A=
+	/* Enumerate child pin nodes and find the requested one */=0A=
+	fwnode_for_each_child_node(pins_node, pin_node) {=0A=
+		u32 reg;=0A=
+=0A=
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))=0A=
+			continue;=0A=
+=0A=
+		if (id =3D=3D reg)=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	fwnode_handle_put(pins_node);=0A=
+=0A=
+	props->fwnode =3D pin_node;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",=0A=
+		props->package_label, pin_node ? "" : "NOT ");=0A=
+=0A=
+	return pin_node ? 0 : -ENOENT;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_get - get pin properties for a given pin=0A=
+ * @dir:	pin direction (INPUT or OUTPUT)=0A=
+ * @index:	pin index=0A=
+ *=0A=
+ * Allocates a pin properties structure, generates a package label,=0A=
+ * looks up the firmware node if available, and reads optional=0A=
+ * properties (label, connection-type, supported-frequencies-hz).=0A=
+ *=0A=
+ * Call sit9531x_pin_props_put() to free the returned structure.=0A=
+ *=0A=
+ * Return: pointer to pin properties on success, error pointer on error=0A=
+ */=0A=
+struct sit9531x_pin_props *=0A=
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
+		       enum dpll_pin_direction dir, u8 index)=0A=
+{=0A=
+	struct dpll_pin_frequency *ranges;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	int i, j, num_freqs =3D 0, rc;=0A=
+	u64 *freqs =3D NULL;=0A=
+	const char *type;=0A=
+	u64 curr_freq;=0A=
+=0A=
+	props =3D kzalloc_obj(*props, GFP_KERNEL);=0A=
+	if (!props)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
+		 * reference, so it can be connected.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+		   index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC source pin: a PLL drives the INTSYNC net.  It can be=0A=
+		 * connected/disconnected but carries no priority (driving the=0A=
+		 * net is not a reference selection) and no frequency.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+		   index =3D=3D SIT9531X_MAX_INPUTS) {=0A=
+		/* The XO reference is fixed: no state or priority control. */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D 0;=0A=
+		sitdev->ref[index].freq =3D sitdev->xtal_freq;=0A=
+		curr_freq =3D sitdev->xtal_freq;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->ref[index].freq;=0A=
+	} else {=0A=
+		/*=0A=
+		 * A synthesized clock output is an external connection with=0A=
+		 * no more specific meaning; a board that knows better says=0A=
+		 * so through the pin's connection-type property below.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->out[index].freq;=0A=
+	}=0A=
+=0A=
+	/* Generate package label */=0A=
+	sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);=0A=
+=0A=
+	/*=0A=
+	 * Both INTSYNC pins are internal to the chip and have no board-level=0A=
+	 * wiring, so they take no properties from the firmware node.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    (index =3D=3D SIT9531X_INTSYNC_PIN_ID ||=0A=
+	     index =3D=3D SIT9531X_MAX_INPUTS))=0A=
+		goto skip_fwnode_props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	rc =3D sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);=0A=
+	if (rc)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	/* Look for "label" property -> board label */=0A=
+	fwnode_property_read_string(props->fwnode, "label",=0A=
+				    &props->dpll_props.board_label);=0A=
+=0A=
+	/* Look for "connection-type" property -> pin type enum */=0A=
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",=0A=
+					 &type)) {=0A=
+		if (!strcmp(type, "ext"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		else if (!strcmp(type, "gnss"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;=0A=
+		else if (!strcmp(type, "int"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		else if (!strcmp(type, "synce"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;=0A=
+		else if (!strcmp(type, "mux"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Unknown pin type '%s'\n", type);=0A=
+	}=0A=
+=0A=
+	num_freqs =3D fwnode_property_count_u64(props->fwnode,=0A=
+					      "supported-frequencies-hz");=0A=
+	if (num_freqs <=3D 0) {=0A=
+		num_freqs =3D 0;=0A=
+		goto skip_fwnode_props;=0A=
+	}=0A=
+=0A=
+	freqs =3D kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);=0A=
+	if (!freqs) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_freqs;=0A=
+	}=0A=
+=0A=
+	rc =3D fwnode_property_read_u64_array(props->fwnode,=0A=
+					    "supported-frequencies-hz",=0A=
+					    freqs, num_freqs);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "failed to parse supported-frequencies-hz for %s: %d\n",=0A=
+			 props->package_label, rc);=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Seed an input's runtime ref->freq with the first DT-listed=0A=
+	 * supported frequency: for an input the board lists the rate that is=0A=
+	 * physically wired to it first.  An output's current rate is what its=0A=
+	 * divider produces, not an entry of the list it may be set to.=0A=
+	 */=0A=
+	if (num_freqs > 0 && dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index !=3D SIT9531X_MAX_INPUTS)=0A=
+		curr_freq =3D freqs[0];=0A=
+=0A=
+skip_fwnode_props:=0A=
+	/* Neither INTSYNC pin carries a frequency attribute */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		return props;=0A=
+=0A=
+	/*=0A=
+	 * Advertise only concrete values from firmware plus current runtime=0A=
+	 * value. For outputs without a firmware list, publish one wide range as=
=0A=
+	 * an explicit fallback because those pins do support frequency_set.=0A=
+	 */=0A=
+	ranges =3D kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);=0A=
+	if (!ranges) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Publish the seeded rate only once the pin is certain to be built.=0A=
+	 * The allocation above is the last thing that can fail, and a call=0A=
+	 * that reports failure must not leave the device's cached rate=0A=
+	 * changed behind it.=0A=
+	 */=0A=
+	if (curr_freq) {=0A=
+		if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+			sitdev->ref[index].freq =3D curr_freq;=0A=
+		else=0A=
+			sitdev->out[index].freq =3D curr_freq;=0A=
+	}=0A=
+=0A=
+	j =3D 0;=0A=
+=0A=
+	/* Current frequency first, when known. */=0A=
+	if (curr_freq) {=0A=
+		struct dpll_pin_frequency f =3D DPLL_PIN_FREQUENCY(curr_freq);=0A=
+=0A=
+		ranges[j++] =3D f;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < num_freqs; i++) {=0A=
+		struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs[i]);=0A=
+=0A=
+		if (freqs[i] =3D=3D curr_freq)=0A=
+			continue;=0A=
+		ranges[j++] =3D freq;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT && num_freqs =3D=3D 0) {=0A=
+		ranges[j].min =3D 1;=0A=
+		ranges[j].max =3D 1000000000ULL; /* 1 GHz */=0A=
+		j++;=0A=
+	}=0A=
+=0A=
+	if (j > 0) {=0A=
+		props->dpll_props.freq_supported =3D ranges;=0A=
+		props->dpll_props.freq_supported_num =3D j;=0A=
+	} else {=0A=
+		kfree(ranges);=0A=
+		props->dpll_props.freq_supported =3D NULL;=0A=
+		props->dpll_props.freq_supported_num =3D 0;=0A=
+	}=0A=
+=0A=
+	kfree(freqs);=0A=
+=0A=
+	return props;=0A=
+=0A=
+err_alloc_ranges:=0A=
+	kfree(freqs);=0A=
+err_alloc_freqs:=0A=
+	fwnode_handle_put(props->fwnode);=0A=
+	kfree(props);=0A=
+=0A=
+	return ERR_PTR(rc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_put - release pin properties=0A=
+ * @props:	pin properties to free=0A=
+ */=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)=0A=
+{=0A=
+	kfree(props->dpll_props.freq_supported);=0A=
+=0A=
+	if (props->fwnode)=0A=
+		fwnode_handle_put(props->fwnode);=0A=
+=0A=
+	kfree(props);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_dpll_type_get - get DPLL channel type from firmware=0A=
+ * @index:	DPLL channel index (0-3)=0A=
+ *=0A=
+ * Reads the "dpll-types" string array property from the firmware node=0A=
+ * and returns the corresponding DPLL type enum.=0A=
+ *=0A=
+ * Return: DPLL type for the given channel (default: DPLL_TYPE_PPS)=0A=
+ */=0A=
+enum dpll_type=0A=
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const char *types[SIT9531X_NUM_PLLS];=0A=
+	int count;=0A=
+=0A=
+	count =3D device_property_read_string_array(sitdev->dev, "dpll-types",=0A=
+						  types, ARRAY_SIZE(types));=0A=
+=0A=
+	if (index >=3D count)=0A=
+		return DPLL_TYPE_PPS;=0A=
+=0A=
+	if (!strcmp(types[index], "pps"))=0A=
+		return DPLL_TYPE_PPS;=0A=
+	else if (!strcmp(types[index], "eec"))=0A=
+		return DPLL_TYPE_EEC;=0A=
+=0A=
+	dev_warn(sitdev->dev, "Unknown DPLL type '%s', using default\n",=0A=
+		 types[index]);=0A=
+=0A=
+	return DPLL_TYPE_PPS;=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h=0A=
new file mode 100644=0A=
index 000000000000..a65efdfd9ef8=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.h=0A=
@@ -0,0 +1,37 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_PROP_H=0A=
+#define _SIT9531X_PROP_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/fwnode.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_pin_props - pin properties from firmware=0A=
+ * @fwnode:		firmware node handle (NULL if no DT node)=0A=
+ * @dpll_props:		DPLL core pin properties=0A=
+ * @package_label:	pin package label (e.g. "IN0", "OUT3")=0A=
+ */=0A=
+struct sit9531x_pin_props {=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	struct dpll_pin_properties	dpll_props;=0A=
+	char				package_label[8];=0A=
+};=0A=
+=0A=
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,=0A=
+					   u8 index);=0A=
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sit=
dev,=0A=
+						  enum dpll_pin_direction dir,=0A=
+						  u8 index);=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);=0A=
+=0A=
+#endif /* _SIT9531X_PROP_H */=0A=
-- =0A=
2.43.0=0A=
=0A=
