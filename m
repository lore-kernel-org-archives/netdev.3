Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021097.outbound.protection.outlook.com [52.101.62.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE7CA4E;
	Sun,  2 Aug 2026 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642437; cv=fail; b=PwW2OpZHRSM/c0SnEMzemns0Jsn2hr0DiqkNbDnpS32zg453leisq7EQDuyW/g1bnshMnsoftw+obOJvhbVqXGzVC3vSv8iXCDVKA2/DjrqvgFjTcEBlfyN7opxri0LT8wDBLy+cdzrSzWKyyToyFxQsxr766P3Y90c0zh0l8VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642437; c=relaxed/simple;
	bh=3L0Sp9mkkq9ac1vyAdR55O4XZf1tlgSwDejP7hzRsd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUtImc9KXR+aHSepFBVHh5IbVN1Vfj0WcOHokowyF38UiaR1o4kvQ15/M2bzQD2axmd3UuCJnqPQrYXxWf5vkVt7BPA7BSYGhSd1+HMVOjrsWgPJxAZ31uC5RIN4SQKrnFucNnniFyNISUelvOn/VYwr+VDfxNwcV96mLkI+39E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=KrDfpbNV; arc=fail smtp.client-ip=52.101.62.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="KrDfpbNV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh6f5xPtg9P69II0YKLAHRpdOBwdhJXBbp8B/1izca4LhFQ+kb2/igrwpFUBp9jrRe60w+z2KrIWdqHQpM3le0cMOjTjRV2JFfjYWFMNGqTmoJpu8Kvt84TIThdasU71bFKigIJROfTvFY8wSXQ00veCnHffER8sR7Z3aisK57O87UNITD+Omn7mEro216MtAyG7ck9qD/wrJR5FwxbcfBvDcYtAv6//NqAhEuXl1AcH9YP8xsSxga7bozLKfPGW0jvkXvxLlk/ic/gbBe47FhGKtJCVP9mb3Xv44JrfOqNefoSo8r0gFJ9t9gESZTDUOYIEyDJpsHdTjSoEjuyeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyUku7UnvStC+jClZd5vnS+ca5yGBt5OfSH5Qx9TCG4=;
 b=JOI1hCLb/Npkbog8eZpiMQ+f5KrUGBCkW0rinUnTHXFofz9ui1latPhuXYhejHcG0rQQNYcXAvckhlZkqcmgJbMspn2bZhEZERdIK7RI/9K+RIsbFIgZBAjgVUwAVihwTSq/Gw6KRE+cD8ZOiHEcC4w6Y63leJhYd5gnd+zMIQMJlx1w7JLqcypCF9lkkug10m6A8LfinZhZzFZymX3x2hVu/jnnpQ5v/O4DyzThszsHUni+jVb7WoV+E5oU6Ez9TOV2Ne75Aby/Er1RKjWsYo697Wx8IQF1qL98yBjvB+PRx0n1/l22Jr8pesvZU+lGdefFu68r4RR1LV9hdgL5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyUku7UnvStC+jClZd5vnS+ca5yGBt5OfSH5Qx9TCG4=;
 b=KrDfpbNVYtAlhXc0Q0Br8hXsIXHngLtHIm5C9mm1NMuO0BpZXLm13MyOILazWHO8Qd0Fm9DsfU8UdPvSUiy1q/r1iStIrzQi5MWvFQlDoHWkBKpbJWvTIOYyiZ3+iNXSXtoD0vb6CVnq7eTaVEDRlMFJYuL1Dpkag+hmcqgg2pzCgHqR0SqHH6d7gAsQ8yh4W7ZjP6Hk9zaAljkx7Ujz0sJ3zOfKurpXfJ1clXLv1EfDHFoftBNvdnRH2uVsRCMp6PWzZu34VSKvJffmLEBM7xvMWPeZvqOJM7HiXAOj28TG1mlxjzssse5PtcX2joGFY0yIkPaGCgmTDdv4HHjPAw==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by SA1PR20MB4298.namprd20.prod.outlook.com
 (2603:10b6:806:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 03:47:11 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 03:47:11 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "hzyitc@outlook.com"
	<hzyitc@outlook.com>, "lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next v2 0/6] net: dsa: qca8k: support multiple CPU
 conduits
Thread-Topic: [RFC PATCH net-next v2 0/6] net: dsa: qca8k: support multiple
 CPU conduits
Thread-Index: AQHdIjGZXbDTPeALAEexVKCKhbSWqQ==
Date: Sun, 2 Aug 2026 03:47:10 +0000
Message-ID: <20260802034701.3339052-1-brandon.mahdavi@mahcom.com>
References: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
In-Reply-To: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Mahcom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF42224DB53:EE_|SA1PR20MB4298:EE_
x-ms-office365-filtering-correlation-id: 4089e99d-fe88-4345-2ca9-08def048bbae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|10067099003|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info:
 wvnnDzhCX4XQNBeuQFBSt+6/hejRbBtwWJDgbXhvF8JdpkXaehYnqbFKiDPoTHoK6HqjB+Eg/O9y5Xh/Xizv3wN6LB6Fx4SpCKjHJlNswXg/xAXAOfcVDyVtw4f2oLNEjdV9HGjtS4Y6ZxHFXqU8zve8LNfNXwFrxFMt6ym47vDeR6onzLfFdi1m6wR5Xcd66O9P/jJSfzYHP5tTy96kqhv8kdLSFldhFonifvOqJVyGA5kA9opJLie2EmyTwRYT+1aTJFTZHXGFyufxNTGR3FPvjDyvcPngCS1O45o8STQyIIFpF4/ZZgBZglBCFppkBodpGlbGq2IPXjrYouplLLQgdcpBDt+05L9kfv/rEnRwIRFw1nb1DU0b6Vr5Vqi3bLi/3+nnZd/vX0vSTT8hymYUqKWvQwo3x7QIy6K8ez4ADlgL8Nffnk8bJ7e7lRzfQkIwQLoajspsoE1zRdPtexFm3kFTvSd1H4fyChF350YMUl/25kr1iQOYBWMz2cfxewWSovlE8yMnESm46ZNL2Ul/ehztt3VEI5gc12PnuoFDWEFHB6IHB4TBJH935TXZXmh/nX26/1XnujIbNQC7cz891Qx0MQ1M4SH1G3cZ8tWOop08qbNK0B5deoQ+jR1x9UCWJ4K4d+WpeUb7QOBERXiH8N/0oEb0mtOUKayKIPJRtj6pjyyOGOX6Y2IvzGhWE+CJbqFmzCerd0W+qKYEHDekerxvSLID9O+YSH0VWq4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?boDeFx4GWAooFotnP18eR0wWaUh0tY2Hg03C5hcV7giMvYlXo1aZYah6Ll?=
 =?iso-8859-1?Q?9l7zYJLyADJbRh61IsgFiHwyO/da2+AO0ZRtjUE5nnmYKuSZIggG8avsrC?=
 =?iso-8859-1?Q?o+OxcjYNhykOdIS9c+2/2sCBveNdqT+uRmKFEKyJz8xfzQtwhd0jW32xkD?=
 =?iso-8859-1?Q?vyQLP6gACfoqhZ435ZdVgEtt/ef02q2LS+nFklS5lMshcbKqWbVzBEEJiS?=
 =?iso-8859-1?Q?FHxqRxL0iT8cDPXOZdMpD7yHnRVNR6F+WFdoAMJxn6YuVtX+saFQzgi/xV?=
 =?iso-8859-1?Q?hzRF5Pzls2Uhybyry2F8tQ6oe3iTM/iHkvN+MldBuOZUsU39Ior/ugnvNv?=
 =?iso-8859-1?Q?R0b7W8H0XOWjGEpsm6R4Sx7MpcwEqTqvJDlCgQ9frXDkJwCtJHSBzlufT0?=
 =?iso-8859-1?Q?N4sdXIZ61mZg9Uunf7v69CjDo22tztm01H9kDcKmWx+0FlSVs02o9x0Im8?=
 =?iso-8859-1?Q?Hn6IOQ6V8UwZWOttj4vfuoqF9Qz8F4ofGXOwxw6y/Y8ak/OEkNxUe1Yd26?=
 =?iso-8859-1?Q?boXDtTnOJOBTEkXJYwnO+frUmlDYRpKonFm9fpsvAXskb7bVq37eK89v3D?=
 =?iso-8859-1?Q?ct/OdSU3Ys8Z1TN0KDynw2EDN8anFo25QMyPx40y3SVfnL0s0CqGJ6Cgk1?=
 =?iso-8859-1?Q?Dmjhzy/CPaZZvzPMwDeciNd/OYPQgosDuKlD0a+hnG4Dhkmm++U2n+Yrir?=
 =?iso-8859-1?Q?DYufL+1h3k+9JtiqpUkLSqTPi/ixdaU/3ChTJycl/CSNKV4eO8zViJSJwk?=
 =?iso-8859-1?Q?iBvSmMAFGlewKUDO9Jn3ejffiuWaZqKxT8nHR8OclnJZrtyKnPUAqTCNx6?=
 =?iso-8859-1?Q?o+OIRTFHW6abt8ZMp5XKYxonPEZkSC/Fw8kTkcbh7AxYmchWEJu8G5WskQ?=
 =?iso-8859-1?Q?tafAFiD4DhtnHoPlIsIVsPZNqGi14TjU+zzQ7ENufqov/VxLpSRiWFxWPR?=
 =?iso-8859-1?Q?SdzWQoBBaTsewIbg0JkgoDS3/VtwL8AlJfImK3qCvMWffVguEOpA3FnEye?=
 =?iso-8859-1?Q?nZHF4idNZdq5PriK0M4JOQfKYi1uo+LgnSE8peEUwDMUfIWLg5snZ0dllh?=
 =?iso-8859-1?Q?H4fbRQjuixpQ8hNt/FhOv3HFCYv67gIX12MVz+JzjkvphCWUUyYdBMiZ2x?=
 =?iso-8859-1?Q?8B4eRbkr+6L946YETPLwlg/OauGlnItGOGj5qROHVgmC3GK04Bpf0I703c?=
 =?iso-8859-1?Q?pKYAoNituPdxoxLSU7IBkFboSNRL3qg3Mbpwzj8UekTXdd/t02iNx8qre7?=
 =?iso-8859-1?Q?HBSjlOjIl22XEbrKjoisANt/crQb7mv/29euq+OeSjPFIPE/kHteabrqQj?=
 =?iso-8859-1?Q?XKSk7DFtHRXMFiHDsamkHzNVJFd8Qpy2hF48hKNz+k2qd6LwiWC/mvSEcL?=
 =?iso-8859-1?Q?qiuf9Fef54NKa2ArVpnnNTCV41ODfQJTLG5HsPAWoZlHIlToxTAmxOU+jf?=
 =?iso-8859-1?Q?cTJO+nIhcWbHooyH7Due3d6UvKDNIyCGbClJsA3sRT2QlsLCaLdWQVLRCR?=
 =?iso-8859-1?Q?LLkEHmEcMcGtmGk/RgUDayKjKSjCAx1wIiCnKp9GRllNpozUu2SPJ56aYc?=
 =?iso-8859-1?Q?vFfoz15EC8IyzaZQiFfVRWrl1K3nmdmACvpp5rh9UkvwihJ0P9K12zwxYE?=
 =?iso-8859-1?Q?QCqgY/vfXJo0bHw4JFqDC4Fq3idMPGiBQJgcuX+Hbe3Lvu03ac48kM94AV?=
 =?iso-8859-1?Q?UPtalC42O+5jN9P58+/nV2GSWNIVhu2aLsgxDdV+Ja+GCJnJ+0QFXBhhUI?=
 =?iso-8859-1?Q?LCvibfAgvzKwrNChyx4O6PB2vII5mEBYt8sA1Rwlev82zqkWoYXu1q6SzY?=
 =?iso-8859-1?Q?YBAgohv2TA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Mahcom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF42224DB53.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4089e99d-fe88-4345-2ca9-08def048bbae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 03:47:10.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KI4aeJz8s3JWMTpWQ0K1rIGeTLaf3RHGY0vzlPgqQ5Bx4FA1VsGn2P80rFyuO19NeevE8XH60/08BzF2sDNpymo6bNWQ0MeRwtB5cpJYdmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4298

The v1 RFC contained only the host FDB handling change. Andrew noted=0A=
that it had no mainline user without the QCA8K multi-conduit work and=0A=
asked that it be submitted together with those prerequisites. This v2=0A=
brings the minimal dependency chain to current net-next.=0A=
=0A=
QCA8K can use ports 0 and 6 as CPU ports, but the current setup path=0A=
selects one port for the hardware topology even when DSA assigns user=0A=
ports to different CPU conduits. Host FDB entries are also unsuitable=0A=
for that topology because the ATU has only one destination mask per=0A=
{MAC, VID}: successive CPU-port entries overwrite each other, while a=0A=
combined mask duplicates host-bound traffic.=0A=
=0A=
The series first supplies LAG FDB callbacks and makes the host FDB path=0A=
safe. It then floods unknown traffic to every CPU port, honors each user=0A=
port's DSA conduit assignment, supports live conduit changes including=0A=
a CPU-port LAG, and enables assisted learning. Live changes snapshot and=0A=
restore both directions of lookup membership on register errors, and=0A=
bridge reconfiguration preserves the complete CPU-LAG mask.=0A=
=0A=
This is a current-mainline rework of QCA8K patches carried by OpenWrt,=0A=
principally from Christian Marangi and Ziyang Huang, together with the=0A=
host FDB handling developed by Brandon Mahdavi from an approach suggested=
=0A=
by Olaf Marzocchi.=0A=
=0A=
The scope is intentionally limited to the two CPU-capable ports already=0A=
supported by mainline QCA8K, ports 0 and 6. It does not include OpenWrt's=
=0A=
PHY-to-PHY CPU links, DT node-name fallback, preferred-CPU selection, or=0A=
unrelated LED changes.=0A=
=0A=
The complete series and every intermediate commit were compile-tested=0A=
with GCC 13.3 using a focused ARM64 configuration. The build linked a=0A=
minimal vmlinux and the bridge, bonding, DSA core, QCA tagger, QCA8K,=0A=
phylink, PHYLIB and MDIO modules with W=3D1.=0A=
=0A=
The non-LAG host FDB purge path was tested on a downstream IPQ4019=0A=
qca8k-common user with assisted learning enabled. A stale entry was=0A=
removed when a wireless station associated and downstream traffic=0A=
recovered immediately. The multiple-conduit and CPU-conduit-LAG paths=0A=
have not yet been tested on hardware.=0A=
=0A=
Changes in v2:=0A=
- expand the host FDB RFC into the complete six-patch prerequisite series=
=0A=
- add LAG FDB operations and CPU-conduit-LAG host handling=0A=
- configure and change multiple CPU conduits using current DSA APIs=0A=
- preserve bridge membership for a CPU LAG and roll back failed changes=0A=
- enable assisted learning on CPU ports=0A=
- limit the host FDB exception to CPU ports=0A=
- rebase onto current net-next=0A=
=0A=
Link: https://lore.kernel.org/netdev/20260725032159.421627-1-brandon.mahdav=
i@mahcom.com/=0A=
=0A=
Brandon Mahdavi (1):=0A=
  net: dsa: qca8k: skip host FDB entries on CPU conduits=0A=
=0A=
Christian Marangi (4):=0A=
  net: dsa: qca8k: implement LAG FDB operations=0A=
  net: dsa: qca8k: flood unknown frames to all CPU ports=0A=
  net: dsa: qca8k: support changing the CPU conduit=0A=
  net: dsa: qca8k: enable assisted learning on CPU ports=0A=
=0A=
Ziyang Huang (1):=0A=
  net: dsa: qca8k: use each user port's CPU conduit=0A=
=0A=
 drivers/net/dsa/qca/qca8k-8xxx.c   | 203 ++++++++++++++++++++++-------=0A=
 drivers/net/dsa/qca/qca8k-common.c | 157 +++++++++++++++++++++-=0A=
 drivers/net/dsa/qca/qca8k.h        |  10 ++=0A=
 3 files changed, 325 insertions(+), 45 deletions(-)=0A=
=0A=
=0A=
base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce=0A=
-- =0A=
2.43.0=0A=
