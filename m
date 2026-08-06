Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8437440B0F7;
	Thu,  6 Aug 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005233; cv=fail; b=UbaCC6nii+7GMOPcND1Yuet8OWR8vVQounx3IimmlJZsYeNZhYRy8ls9UW+aJdK3EXAn326IAQfA54KZDhkspKoPOaVSnEr/g1k1Cg+fPkFB5o6Mxks0pYf5wTinjOCNywdIXB/V3rxXqfO2c0V0HgsGbSrFlu2dpDkuBTFP4Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005233; c=relaxed/simple;
	bh=R4AHITBDk3T9bznrQ7CdBZJgFOQgnU506E3y2+GVJ88=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jcVsZesT/DB/P1HOy8A0hN1CtvgrNbbc+FfGRGPp/Eq4preThfotQD+5DR+LG44Na6bXcD3/Pqp2rNMOKrtn7suq6KEO77RBQBTBAPb4VUHFXG/v8FxNem7PZInbKCqzV2Lsg3MTVF4ZPkZYJ+c4QSYyrSkN8ZIz/R6x0gWsVMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ofJAPjqx; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ofJAPjqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuryIJBH1uj2v0X1apeXa/GWbG0DL40sOtUxTZLjvacNrEIYFMvBo86ynJahFBGeA8AT1nN4G3ieWi6yWosvvM1bAu0HWBPtQ7TLzHHCfRqvpAXgKih0XGcoRNW+tHSEIel08K8Hb/lcazPasWgZ7jJpQJKUEbB/o5D0ZKFk05iy0eSGMcBWHsF+BOVD9jHg9s56bbaDNuxVoYe9+oP9lnkR6YHyyV5GuWD5QbWKZiR/dOAnZezk+OViQdXiaxAma0fCuOF5LoWEBkZnnQv8lPaNKGUsgQNuxlvQfiALVwBIGoMAo6YJMKfp/nPMC3HMk6VmWORfdaNM+G5lz/bcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+50bdZ9c6fyH7BMACpFc8nuXDZWNvPnLmsjyVFxXdq4=;
 b=S5ZLsKhUOaRHyzbMxxUqQXc3v5vZAXgbYdDpB/HjJo1MdHXEt+A4MWR9vNt1Dtnll40V3oHfUSgxbilvqLT4HIzdbfVS0YJau6SDNpRffHo529XERNsbZIehS9MDA54scxSWKuEweCxhk5amZdXbhj75IkUbVgBGx2e8lkI1Ri1LJ7NGGX7c7aKCmj3PloGL0oDfWcr/oXQOG8pB1/ZTl3K3igDIAfhGXbU9vUZFtyuvDaRPgDe1stfevde+rILOTMzJDB02lyKj0Sk5748CfqRAJEe3Le1+7P2ehS+Sz2dx9NX8ODUI42BgBFbyrHJdrjcCZYPJNhkSoUCkS2ANxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arri.de; dmarc=pass action=none header.from=arri.de; dkim=pass
 header.d=arri.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+50bdZ9c6fyH7BMACpFc8nuXDZWNvPnLmsjyVFxXdq4=;
 b=ofJAPjqxelTdNY+Msc4fv5ZWpA0HGk4AYBYGm0q3m4yR/US0x6aSvd/IlPMfNs+MI8cgVOF2V/Loef6uFsbP83vjIPMg/lXPe2bkFLdDyvC+24fMHWO51WBWGIhArG05sCqcvF7OEoSTZwatrpfHyJ3cYBU8Rsg9kmMqosyDEd4=
Received: from PA1PR03MB11059.eurprd03.prod.outlook.com
 (2603:10a6:102:4fb::11) by DB3PR03MB10132.eurprd03.prod.outlook.com
 (2603:10a6:10:43c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:33:36 +0000
Received: from PA1PR03MB11059.eurprd03.prod.outlook.com
 ([fe80::a171:1d74:5b7d:edef]) by PA1PR03MB11059.eurprd03.prod.outlook.com
 ([fe80::a171:1d74:5b7d:edef%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 08:33:35 +0000
From: "Polak, Leszek" <LPolak@arri.de>
To: "theo.lebrun@bootlin.com" <theo.lebrun@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Conor Dooley <conor.dooley@microchip.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: macb: fix stale data returned by MDIO reads
Thread-Topic: [PATCH net v2] net: macb: fix stale data returned by MDIO reads
Thread-Index: AQHdJXuRwFoW/iinZUOuFR8jYzQV9Q==
Date: Thu, 6 Aug 2026 08:33:35 +0000
Message-ID:
 <PA1PR03MB110596D36E77DA32E1FBD9099C8D22@PA1PR03MB11059.eurprd03.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR03MB11059:EE_|DB3PR03MB10132:EE_
x-ms-office365-filtering-correlation-id: d30c1677-9f8e-4432-9c04-08def395680a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|3023799007;
x-microsoft-antispam-message-info:
 SBcOAiZEGJOHfFkSo+9r1nKQABsJ2DE3tRVUZ5r+3AA8ogtru+/NV+M13wTPORe4FKtVBbFRP+4Rrpw/Uu5aycqqLoPIYcYj+/PGIBDPlHbbf5AdlKsoQrrmQQ4KOkF9YOmVNZaexzf9L/P3w/QSNHnNnDMmJptfn8nwM11/QtoDJ4NxbmdWRsXJWwtDmeNQKG1DDn3rf/LrTdmcNMywYJVOBm7FDYr3+k8WS5X6UPa/zb3UBAfx0IVfu1kaEsWO1nufsGpyntTnsmxhH+OZKDvaHvZ4JDXjEvrV+FmDMc9xktIAbI1Q1v1q9vv1gczaZdKYixg2voXOSbk5MipEagL32nx50H5swVc3QZ5bC4Bx+s6YjXpzsv509SmlGy4qk37pjpDNVk4YRAeZydw62pvLA0/SRuodHhlDSXyYZCxVpJO2siPg1HIucVcNJtSsvd2p+vuwAwMoSIXjZI7B5W6Rb9kISEgHzVD4rTvuCfpSPl+AoZiMHPIE7oA/Zhy1YvjLGfgK0H1gV8TKZpQNYMT9+srCGCSQ7z0/69cp6wCYckNF/7GDOspFCWh5ekwFy/ruzd6tRVVs6w054GxhFBu1jKBJpp3qW7u62b8t8fLdrV/nUA/PhPXdIIxi8OCqWQucSSWe3WjgTbXEdjK0SK7fRSLLCJvofRUAxjWMohUG8xAt3q3oYHI6BayMrd3rsqTYRzhJeUs5Pffa5OQtxj/tksN1KZ76xmmsjS21Sys=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR03MB11059.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Gqgb31Ngvmas0JoOfa2bi/Sx9hmXd9Rv94yK9BHyt68MMzzR4vGkzas76i?=
 =?iso-8859-1?Q?hjR5eS/FhfSQfT81c/iPtpAWcL0yYPk9yzol2cNANxBKXRdDj2wuiq7+yX?=
 =?iso-8859-1?Q?vZ8/Ri29Yd3DH2EH3agjmcbgjSb7/L4KKHrpoJbob1KO2l9kgOWeq51cKH?=
 =?iso-8859-1?Q?ZBY/XzUdTEuNG4yYx+acqNueVlSpj7PvE5N7O0Whanoz5CEJ+qx4h1pW1n?=
 =?iso-8859-1?Q?nj2cyGqHCR+UH2Q3z5yJLw0WhNjbQMP0f6DBZKl6FSS/FHwK26Nm+rR51W?=
 =?iso-8859-1?Q?hizzWVPxq6DlKrbXvebNU7JzNMbaJsZPF3AdVsJ3tkLeqiXtvnQ5C+zgc0?=
 =?iso-8859-1?Q?9/iT1jLSvwT8O/HvLO2snjFMQuiX6wdJTUqetR5ZIvrXQl00fz0EtiQ/Ez?=
 =?iso-8859-1?Q?gdYafB6NOxxo4Ij7zDEKAp7FXQGcm/Dsbt03p0EVLdtjQct/d1g0W9BSYA?=
 =?iso-8859-1?Q?QENBSBhynBitmKig2yHILs11jQbNIVLgl7RIC68+PWr/XzFfUXhxmKm0Mq?=
 =?iso-8859-1?Q?/fNlFsfzwQ4YhSU74tN+oEacpejvdF4vI5rJBw8ZmS4oabg16l4dtwVoE8?=
 =?iso-8859-1?Q?HyPWcdOHVwBSij4M3Ce55Xpsf3bOvFQuIe98QiBe3HsKPHGLW12vzQ/jva?=
 =?iso-8859-1?Q?ZWgJaReHGxyR9FqYpooYKWHHQa6T5mesJzbY3TD+wqtct1YnC4vhtbVQKM?=
 =?iso-8859-1?Q?I0X+4DZJn8IHlWKGZd2PaPLRGyYEtEROdLXS1cp/tLnNC7ZU0hr/tjEkKY?=
 =?iso-8859-1?Q?rykeEg90oHbY64zikxubVpT+AqpZjTpMj4dLsL1JwrwqFf2X5JuwUSmTlw?=
 =?iso-8859-1?Q?sD0Zn3ctGuP2cVTE6LpjDcPykCL25TAOOM1SUZJF3FoOvX2JZ9Gmcnbc6N?=
 =?iso-8859-1?Q?rtP0QNFnPUNz+Zc/zMBvsstq/ErRuIdONcAOxAoTworZS8Md3X/1FJvn3w?=
 =?iso-8859-1?Q?KTf4xkKD6U6rPJRDliYowCVIZDQXhY1zsxPs3s6JRpQjqS2HgOkCW9ynm0?=
 =?iso-8859-1?Q?IWc7r3RKU8to2tBtbDL+DQ26VCwwbOS1QdB/J4N2elJr1Ln9kUVkcUPYir?=
 =?iso-8859-1?Q?G3GY8vSk+Za4XF/l0eop5tIwYgoKg78DHjOFnvYMccASahmBke9NBFcH5Z?=
 =?iso-8859-1?Q?z+TDQYljFxjtSgNesbUkU7HjKQu/rAFXQRDuXmTxNRFtyRm/E5AyCF9zqk?=
 =?iso-8859-1?Q?IFZ747nKCgRj74WX2rZcJLZD2mKTpUVjAphh/uyMz3btFyOnAc/PEC9/3F?=
 =?iso-8859-1?Q?Okyo8ewK/8JKeK3x1a35vsITH6P0448S5ht1MGbR2j5/03bQETs8wUmUoP?=
 =?iso-8859-1?Q?nFsMlqvGQVg/Mn8/7bQSr0R7pHykaWZV/E4iu60/n6hJ8mxngyTuZbzBK1?=
 =?iso-8859-1?Q?V5MzOPzeI27A+1XImhvhvRcy1BERsDuObYxwCZdGKqxSmSIPgqmLbWpuIR?=
 =?iso-8859-1?Q?oAKy9gGfTLI13HCfxrU/PiRjDiktDqRXactSjhBiBxs65oOvpmpYucPMo8?=
 =?iso-8859-1?Q?cNjLmRGZafCl4Akpgi6QbLy7eaEx38iqBQNUuQqLu71Xg7zYmNQ2CYiAzc?=
 =?iso-8859-1?Q?YDS2vgtRrZOs13Odwo2kk+D9sdrYO54vcAOk0MaPwNiU9q2V3gngIWPeU+?=
 =?iso-8859-1?Q?MaBsU/HI/CLylvF78A6svGy1UNxJ00BFwqE3KZcnqw9Y8icAI5kcfuOM24?=
 =?iso-8859-1?Q?PFGrtlFd/Fmwpmnz3Fv3FxxertQkSuc4VPdqofsLuG8eeddGUZdg6NLUFw?=
 =?iso-8859-1?Q?GNy8sGdYteUWqVNpbPEfozS6A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR03MB11059.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30c1677-9f8e-4432-9c04-08def395680a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 08:33:35.3593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +e5u95U2rFMXUkU6SHCsAWU24gm8FjVtHIZPkVZAeq8o9kW3UCfC22TnEC0bc5RH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR03MB10132

macb_mdio_wait_for_idle() serves two purposes: checking that the bus is=0A=
free before a management frame is issued, and waiting for that frame to=0A=
complete. In the second case it samples NSR.IDLE with no delay --=0A=
readx_poll_timeout() expands to read_poll_timeout() with=0A=
sleep_before_read =3D false, so the first NSR read is issued immediately=0A=
after the MAN write.=0A=
=0A=
The immediate sample dates back to the phylib conversion. Before it, the=0A=
driver did not look at IDLE at all: it enabled the MFD interrupt and did=0A=
wait_for_completion(&bp->mdio_complete), so the frame was known to be=0A=
finished before MAN was read back. That was replaced by=0A=
=0A=
	/* wait for end of transfer */=0A=
	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))=0A=
		cpu_relax();=0A=
=0A=
placed directly after the MAN write, and the later readx_poll_timeout()=0A=
conversion preserved the eager first read.=0A=
=0A=
On a Versal board (GEM1, Marvell 88Q1111 PHY) NSR.IDLE is still set at=0A=
that point, and only clears shortly afterwards. The documentation=0A=
presents NSR.IDLE purely as a completion indication and says nothing=0A=
about this, but the measured behaviour is consistent with IDLE following=0A=
the MDIO state machine, which cannot start driving the frame before the=0A=
next MDC edge. Neither macb_mdc_clk_div() nor gem_mdc_clk_div() selects=0A=
an MDC above 2.5 MHz, so one MDC period is at least 400 ns, far longer=0A=
than a back-to-back register access.=0A=
=0A=
The poll therefore matches the IDLE left over from the previous frame and=
=0A=
returns before the frame just issued has started. The caller goes on to=0A=
read a MAN DATA field still holding the previous result, so the read=0A=
returns the data of the previously accessed register. Clause 45 accesses=0A=
are hit twice per read, once for the address frame and once for the data=0A=
frame.=0A=
=0A=
Reading each MMD register twice showed the first read returning the value=
=0A=
of the register accessed just before it:=0A=
=0A=
  31.8002 -> 0x0149, then 0x002b   (0x0149 is the value of 31.8001)=0A=
  31.8004 -> 0x0b21, then 0x1401   (0x0b21 is the value of 31.8003)=0A=
  31.8011 -> 0x400e, then 0x6000   (0x400e is the value of 31.8010)=0A=
  31.8010 -> 0x6000, then 0x400e   (0x6000 is the value of 31.8011)=0A=
=0A=
Retrying does not recover latch-high, clear-on-read registers, because=0A=
the first read does reach the PHY and clears the latch.=0A=
=0A=
Sleep before the first NSR sample on the completion path, so the frame is=
=0A=
guaranteed to be underway when IDLE is read. 20 us covers MDC down to=0A=
50 kHz and is small against a frame, which takes over 25 us at 2.5 MHz=0A=
MDC. The bus-free check is left untouched: IDLE is legitimately set=0A=
there and must be reported without delay.=0A=
=0A=
Fixes: 6c36a7074436 ("macb: Use generic PHY layer")=0A=
Cc: stable@vger.kernel.org=0A=
Assisted-by: Claude:claude-opus-5=0A=
Signed-off-by: Polak, Leszek <LPolak@arri.de>=0A=
---=0A=
Changes in v2:=0A=
- Add the "net" tree to the subject prefix; target net rather than=0A=
  net-next.=0A=
- Add Fixes: and Cc: stable@vger.kernel.org trailers.=0A=
- Describe in the commit message where the eager IDLE sample came from:=0A=
  the driver waited on the MFD interrupt until 6c36a7074436.=0A=
- Keep the poll interval at 1 us. The delay is now a single fsleep()=0A=
  ahead of the poll instead of a raised sleep_us, so the polling=0A=
  behaviour after the first sample is unchanged:=0A=
    v1: usleep(20) -> readl(NSR) -> usleep(20) -> readl(NSR) -> ...=0A=
    v2: fsleep(20) -> readl(NSR) -> usleep(1)  -> readl(NSR) -> ...=0A=
- Apply the delay only on the completion path, via a separate helper, so=0A=
  the bus-free pre-check still returns immediately.=0A=
- Drop the start_delay_us variable.=0A=
- Reduce the comments to two lines.=0A=
- Reword the commit message: the IDLE behaviour is now presented as=0A=
  measured on this controller, with the state-machine explanation given=0A=
  as a hypothesis, rather than asserted as documented. The v1 wording=0A=
  also had "one MDC period is up to ~400 ns" backwards: 400 ns is the=0A=
  minimum period, at the maximum MDC rate, so the delay has to be sized=0A=
  for the slowest MDC, not the fastest.=0A=
- Link to v1:=0A=
  https://lore.kernel.org/netdev/970df4d9-6199-4148-840a-ed1897ff27eb=0A=
=0A=
Notes, not for the commit message:=0A=
=0A=
- Th=E9o, on your debug patch (the second version, with=0A=
  macb_mdio_wait_for_idle_busy()): results are quoted in the reply to=0A=
  your mail rather than here. The reproducer that produced the register=0A=
  dump above is there too.=0A=
=0A=
- On "wouldn't others have discovered it before": I went through every=0A=
  MDIO bus implementation under drivers/net that polls for completion,=0A=
  ~22 of them. Sixteen poll a BUSY/START/FIRE bit that the driver itself=0A=
  sets in the command write, so the bit necessarily reads back as set and=
=0A=
  the window cannot exist. Three poll a latched done event that is=0A=
  consumed per transfer (fec, adin1110, mdio-mux-bcm-iproc). Only macb=0A=
  and xilinx_axienet_mdio poll a level ready/idle bit that software never=
=0A=
  sets, which is the only shape where sampling too early can succeed on=0A=
  stale state. That is not evidence the bug is real, but it is why almost=
=0A=
  nobody else could have hit it.=0A=
=0A=
- On the documentation not mentioning it: drivers/net/mdio/mdio-aspeed.c=0A=
  carries an explicit workaround whose comment says the controller may=0A=
  return stale data when a read follows immediately after a write, fixed=0A=
  with a dummy read before the poll. So this class of behaviour does get=0A=
  acknowledged in-tree even when the datasheet is silent. Different=0A=
  mechanism from what I am claiming here -- register read pipeline rather=
=0A=
  than MDC clock domain -- so it is precedent for the category, not proof=
=0A=
  of my case.=0A=
=0A=
- Counter-evidence, in the interest of not only citing what helps me:=0A=
  xilinx_axienet_mdio.c has the same shape as macb, pre-check ready,=0A=
  write MCR with INITIATE, poll ready again with no delay, and nobody=0A=
  reports corruption there. Th=E9o's EyeQ measurement points the same way.=
=0A=
  If IDLE deasserts in the pclk domain rather than the MDC domain, my=0A=
  explanation is simply wrong and the Versal behaviour needs a different=0A=
  one.=0A=
=0A=
- On MFD, this may satisfy both of you. Andrew, the design you put in FEC=
=0A=
  is not interrupt-driven, but it does not poll a level bit either: it=0A=
  polls FEC_IEVENT & FEC_ENET_MII, the same latched event the interrupt=0A=
  used, clears it after each transfer, and fec_enet_collect_events() has=0A=
  "int_events &=3D ~FEC_ENET_MII;" with the comment "Don't clear MDIO=0A=
  events, we poll for those". Polling an event bit with the interrupt=0A=
  left masked gets the correctness without the interrupt overhead. macb=0A=
  has that bit -- ISR bit 0, MFD, "Management frame sent" -- and it is=0A=
  entirely unused today, two defines in macb.h and no reference in=0A=
  macb_main.c.=0A=
=0A=
  The blocker is that it does not port cleanly. macb_interrupt() opens=0A=
  with an unconditional queue_readl(queue, ISR), and macb_queue_isr_clear()=
=0A=
  only writes ISR when MACB_CAPS_ISR_CLEAR_ON_WRITE is set, i.e. ISR is=0A=
  read-to-clear on the parts without that cap. FEC can preserve one bit=0A=
  because IEVENT is write-one-to-clear; on read-to-clear macb parts there=
=0A=
  is no equivalent, so any RX/TX interrupt landing between the MAN write=0A=
  and the poll would eat MFD and the poll would run to timeout. Solvable=0A=
  on clear-on-write parts, not obviously on the others. I did not want to=
=0A=
  put that in this patch, but it looks like the right direction if=0A=
  someone wants it.=0A=
=0A=
- On bus throughput: smaller than I first thought. fsleep() in mainline=0A=
  is usleep_range(usecs, usecs + (usecs >> 2)), so fsleep(20) is=0A=
  usleep_range(20, 25), not (20, 40). A clause 22 frame is 64 bits, so=0A=
  25.6 us at 2.5 MHz MDC. Even at the upper bound the sleep finishes=0A=
  before the frame does, and slower MDC hides it completely, so the added=
=0A=
  latency is around zero rather than the ~14 us I would have guessed.=0A=
=0A=
- Worth noting for the v1 comparison: read_poll_timeout() with=0A=
  sleep_before_read sleeps usleep_range((sleep_us >> 2) + 1, sleep_us),=0A=
  so v1 guaranteed only 6 us before the first sample despite asking for=0A=
  20. The explicit fsleep() is the only one of the two that actually=0A=
  delivers the delay it claims.=0A=
=0A=
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++------=0A=
 1 file changed, 16 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c=0A=
--- a/drivers/net/ethernet/cadence/macb_main.c=0A=
+++ b/drivers/net/ethernet/cadence/macb_main.c=0A=
@@ -308,6 +308,16 @@ static int macb_mdio_wait_for_idle(struct macb *bp)=0A=
 				  1, MACB_MDIO_TIMEOUT);=0A=
 }=0A=
 =0A=
+/* IDLE clears only once the frame has started, up to one MDC period after=
=0A=
+ * MAN is written.=0A=
+ */=0A=
+static int macb_mdio_wait_for_frame_done(struct macb *bp)=0A=
+{=0A=
+	fsleep(20);=0A=
+=0A=
+	return macb_mdio_wait_for_idle(bp);=0A=
+}=0A=
+=0A=
 static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)=
=0A=
 {=0A=
 	struct macb *bp =3D bus->priv;=0A=
@@ -327,7 +337,7 @@ static int macb_mdio_read_c22(struct mii_bus *bus, int =
mii_id, int regnum)=0A=
 			      | MACB_BF(REGA, regnum)=0A=
 			      | MACB_BF(CODE, MACB_MAN_C22_CODE)));=0A=
 =0A=
-	status =3D macb_mdio_wait_for_idle(bp);=0A=
+	status =3D macb_mdio_wait_for_frame_done(bp);=0A=
 	if (status < 0)=0A=
 		goto mdio_read_exit;=0A=
 =0A=
@@ -362,7 +372,7 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int =
mii_id, int devad,=0A=
 			      | MACB_BF(DATA, regnum & 0xFFFF)=0A=
 			      | MACB_BF(CODE, MACB_MAN_C45_CODE)));=0A=
 =0A=
-	status =3D macb_mdio_wait_for_idle(bp);=0A=
+	status =3D macb_mdio_wait_for_frame_done(bp);=0A=
 	if (status < 0)=0A=
 		goto mdio_read_exit;=0A=
 =0A=
@@ -372,7 +382,7 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int =
mii_id, int devad,=0A=
 			      | MACB_BF(REGA, devad & 0x1F)=0A=
 			      | MACB_BF(CODE, MACB_MAN_C45_CODE)));=0A=
 =0A=
-	status =3D macb_mdio_wait_for_idle(bp);=0A=
+	status =3D macb_mdio_wait_for_frame_done(bp);=0A=
 	if (status < 0)=0A=
 		goto mdio_read_exit;=0A=
 =0A=
@@ -405,7 +415,7 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int=
 mii_id, int regnum,=0A=
 			      | MACB_BF(CODE, MACB_MAN_C22_CODE)=0A=
 			      | MACB_BF(DATA, value)));=0A=
 =0A=
-	status =3D macb_mdio_wait_for_idle(bp);=0A=
+	status =3D macb_mdio_wait_for_frame_done(bp);=0A=
 	if (status < 0)=0A=
 		goto mdio_write_exit;=0A=
 =0A=
@@ -439,7 +449,7 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int=
 mii_id,=0A=
 			      | MACB_BF(DATA, regnum & 0xFFFF)=0A=
 			      | MACB_BF(CODE, MACB_MAN_C45_CODE)));=0A=
 =0A=
-	status =3D macb_mdio_wait_for_idle(bp);=0A=
+	status =3D macb_mdio_wait_for_frame_done(bp);=0A=
 	if (status < 0)=0A=
 		goto mdio_write_exit;=0A=
 =0A=
@@ -450,7 +460,7 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int=
 mii_id,=0A=
 			      | MACB_BF(CODE, MACB_MAN_C45_CODE)=0A=
 			      | MACB_BF(DATA, value)));=0A=
 =0A=
-	status =3D macb_mdio_wait_for_idle(bp);=0A=
+	status =3D macb_mdio_wait_for_frame_done(bp);=0A=
 	if (status < 0)=0A=
 		goto mdio_write_exit;=0A=
 =0A=
-- =0A=
2.43.0=0A=
