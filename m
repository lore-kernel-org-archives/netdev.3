Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699465;
	b=t4AMRSO/3qxaqQvEaeNAtTUw/T2KbG15Hzzz8R75Tr54xgOEa4fDa6PQhne/rYqpmLcr
	 UeFibwUESKstk1SEaGyuwOevm8C0IE9eGM2JHMDgqy3SZiPSpMubtj6CvxmXhxLaJgfDa
	 cbaFXgGn+Ptk7D71cAu9emPlXjV5DWtO8YgJpSHjaz9wwAhp5/opbywB2WjQTur7b/pEB
	 2M2tV8zKOw4DtgMjQlXvfDBoltJ1ug5TXKeqGeudORN40Ets+NM5s3MoTnL81rTwCk0sZ
	 qpKbhuP9mwEmHfZ+QEIR5KLZTIotytAaK2aTP4qjyMhkF74BzdhGEflxQSKQP+9/ljg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699465;
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
	bh=vQCgwWsBg5geSaWLcXaTaDAVClZ5cpNu17l4SLNHbW4=;
	b=wlb7Gbnm3iktKPh4DKzvXjEPKSQCxto659JJ6NAqQ6rA9GiARrfKj6V9dw4jx/deE2m/
	 zCOByOBni9nDBht+pn8/eXAZuJTd5AWRhfK8DobMcoq1JCiccTsY2iKNmfmEKWZrFCsTZ
	 DEmOeDa7Ny97RmA+PSzULxP4v9CNs4H3My+/cUrzWbpRADQhRNOlJfEP1zyHAi6/TmfXs
	 pgN7aLIdsHhVTL+A9JsS0lvtT+C7Hw5h7zdcuQPqXpAq2j6CXZy+kshxeH5VbTLP47kuU
	 7EqqHEetQOCNi33zNFHpvwxMms7PhBF/1jH+rqkL8T72Aj3p25TR28CMxpEuueZ6EYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=dAuOVPzi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.11
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6A606D804;
	Tue,  3 Nov 2026 09:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B6A606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=dAuOVPzi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwxjF8FLlH6C/wZpHVXTXeuwAxqwDZ4eKiMjR8H+DhxOKUz/kKLfqQ6VbkneXBfNqV3IwumNb2ZDhXSXlH2iFDcT+LgKIGGkG0UKPWwHwWUJSJGQILtnIFqNdTe/iuJN2uefhhngBLg4Y0GKN5UGeK6XvSya4lCs+i2bJoek/YzQK/wmoN8RwOxIq0ubCbb4lWBzR9lZcPfoIOo7o6oLLgv0+QyVakJyV+7zuYB9MwqSkl+JfENLrKo7NJB8ohvLoOIauUVeJhvjczeZNpbPRgoRpD7gKein1Hj1xG4oU2LTQeNeYF4Et4/QSKVhl+i8TWgyfQCSajk0e9R6ZusQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQCgwWsBg5geSaWLcXaTaDAVClZ5cpNu17l4SLNHbW4=;
 b=LAH7gkmVDdiRsfLaRepspuZze6KjPG9ayIsEKtoLtzO6fs75/0fg5ZxCGRny9EF94Oig81EdmVrgXvwbdeuH0Q2UEoDZdvMxAQkgSdxNfvTb+5nhu3yTrDc1e0xD3b1p3S7dDLeiZlLfznZodMJ5gMy+5jacVJQCGZzRS9hTRVr5WDJSOPjrAy66zcGbTWLADdH8XNwymqC4+U8jLuUuBPV5EMOjC2TFAVO4FhOFKH6orwYL0tj3i8SizoFucxnvMKb3iz8WpjJkuunoA4ozIEZvS2G1PvsG0eh1o7RF6o1l3UWjWy9gIcXXBW3YP2I+Pv75a43oN1yu2Hzr7yz/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQCgwWsBg5geSaWLcXaTaDAVClZ5cpNu17l4SLNHbW4=;
 b=dAuOVPziXzzTChvfFkpkzUSXdunqTl69jt5CcM4+atvHk7RaJZMYBnsAyC0E8BoMQqImOZ2pWVFCJNcHkj/ucJ9sgzLFEth2jdAlkObTFb79ukIr13tEoMcjrlpgliaRf9XhZLriRnqPksTT+Qc0uDr/SjWSb6Cywg9zQ2SmqbbObjBgdxxuvEdRKirFjDhiCzpFYRSGAFoA2ERlnvZb9HH7vRsrgdW6+dGVx7gLKJTzc30x80nBXvOkV1f9Qu67aDLZTEg4hdCnP0u1o2jZQa9tTpjuDEC4eac//vQjsp54Sh1mWsMr3Kg8ADJb+6ffTq8V3MPte1O+v9PWMtWG7A==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by DB9P189MB3646.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:51:00 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:51:00 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Bart Chronowski <immersa.bartosz.chronowski@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v2] tipc: defer local Nagle backlog receive processing
Thread-Topic: [PATCH net v2] tipc: defer local Nagle backlog receive
 processing
Thread-Index: AQHdZ7qWhmAGkZhoekWFonG4NjjV/LccH8Gw
Date: Tue, 3 Nov 2026 09:51:00 +0000
Message-ID:
 <AM7P189MB11371C08E424CE428ED28E71C6692@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <657t6njsrgnpnfs2mc2lv776442fhv5zsosg3vxya5vqrtpag7@nq3uxt6ymw7s>
In-Reply-To: <657t6njsrgnpnfs2mc2lv776442fhv5zsosg3vxya5vqrtpag7@nq3uxt6ymw7s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|DB9P189MB3646:EE_
x-ms-office365-filtering-correlation-id: 8d95113d-0876-421f-1e48-08df398ff795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|11063799006|261022105027099003|56012099006|261009223027099003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|261102123227099003|261022115727099003|261021135927099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 wiZxvAmsrcuVbRtMlYgIWff+JNoA6dk9ow2zOScI5r+J4PVrRt2ipQ5DMjf3Ha8VG/BGMrs4YgYkeuoVufQC1GWj9QrbsZBblbHPcnmj1Cj54iGHF7Q87hVsdAnj0WqYcDCTWA3vUfSAzVUZKlHY2KWF8mhTHa/+4TD1jJwr6UQjqRCxoyHj8Cw6Z7c7DSX08PCB25zCGmganEnqoofxvZ0BXLYgj05cQ2VM8Q+WV9LXLh2UVsyUsF+qDTlBlrKZBmfdHK73JynlC5x2lTl4rJFTQYibq/49lc5Yp3oqjaQ6dRSpO1zrAd6bUP2tb6BOnvQy6schxy9Nzo4bWwWlfab7EbKiTs29D9FtmzvVp7yn2+kjcUBOIvUrArVjRK/Y4woUP3B9Iv1BYsU8ccuQ3P8ZCyO5L/jAqu/ZkBO4RnKOCgeV3fJizkNbbULDRMDwhT9Le5+EgEyb+gnzTT2467o9/yQklVGU76n64dJsNahhz0uTD03jmJudHzRBg1Tm1AxRsrw3J8swcCNeWQ+WFeA7VepHz4aBat8AYGA1pcugOP70nH4/QbRN2ihKmiAgUqoFTdCvN046b+oSUZ7xJXtty3w70YDNG2K1H8gZaseJ9LuIQVNWkwqM9xQyIJTb/Tq2lykNmlOxfwsbzWS8PJbgrCI6fG5F8dFPXCSbFd0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(11063799006)(261022105027099003)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261022115727099003)(261021135927099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i3wPJmZVMaknQSJjibLmNqY2b/J5t0RPDsFxW2ex1suKN/V4XOfKXqA4Kjrm?=
 =?us-ascii?Q?htfPG7R+421HgV6CX9Y/VTlG8W+lLSo8QzTtLQ/s6aDP5i8KGMWm4RblkwkI?=
 =?us-ascii?Q?S+BrzV3hPCvVHrSUBmyc/lSqrL7i0QRNfOIlTcjJZWVnN/CjGf5Zl65KCZkG?=
 =?us-ascii?Q?fklz1WE5mumDO7RTQGDZUzTVAUGaG+jnwIupCIBf6smOMh8ywf3Jm+2/izeC?=
 =?us-ascii?Q?rrBvAImvmpQFRlrQRO8gST1n1DV8D5YaL8vVANSsasjBC3xAeccCa2s9ramW?=
 =?us-ascii?Q?HmseweurHi4Je+xzQJQo1XZKUoGiKnqrj9wJmjo74j4w9ooSwmpBgIQCDRBB?=
 =?us-ascii?Q?ReAcl9+ln1Y9d026fAbrH2tk689gwyA5TGrF4dGiHeiIlsIoI6Qz30yzXcsg?=
 =?us-ascii?Q?i5Ybn/rV2lNJcdKzBcfLkNcEO7PYbMBLJx5toxG4iNCxSC68ltbHeraX1CgF?=
 =?us-ascii?Q?eQzWtn9UmtYBbgP6Tczk2eGe3fYKMIf2YpIxW90E/kqdzy2mhsbdUF6L0gvG?=
 =?us-ascii?Q?JoPvSShGZmp+uQHyj0SIfdL6s9XD7cyriyxDO8YkMvFO+DQPJQ/EyNtucKYw?=
 =?us-ascii?Q?ChZaqUcfUUmFwA4WHgOpbFl26RisMcjP01jl25+CYaHouTJ44N5smytqckpY?=
 =?us-ascii?Q?ccPYVW0LeV2fCKNAPkjvYzzhXZjYKz5KOsBMXTtcDAbqsKRfcVsox40s9z7s?=
 =?us-ascii?Q?kHopGTtPAouR0cu5SkQP3WjO5F4Nfyk19KarZWioFDiWdnME9dWhvNjyBXkM?=
 =?us-ascii?Q?CrngjapmgmMwcEUdhyGEmeG38WaagBIqkEkIo76wGFk8Oixn56gV/r9tRqoy?=
 =?us-ascii?Q?YqSovwn5uPOUtAuxtyDWLKVBs+I7HdfEh7D7hq3FOgFxGOOhqnsPxPcMMuN6?=
 =?us-ascii?Q?p4DpR1O3mb5Q3K5PQmGSK2h0fUKteWvVpXDqe7xCajJSIjr5uRUXU+KTKgIh?=
 =?us-ascii?Q?yvLJl0e5gD7lOQ6t4Jr2ZGWZj4lvy6uYqfzMgqXJcUFtRVF15qQSUaaLXdm8?=
 =?us-ascii?Q?BgCVu4hDJVZTvpOgBB0yKBYOhcOAeA9unfDuOVCCzn8UGjA3SXb5/iereczg?=
 =?us-ascii?Q?8CgfYnuo4Kem/Zu+9VJaa/IyqHuPBCh4Zc5/y+lmC+bLoEOya051FPZNTXRN?=
 =?us-ascii?Q?mvRdhYxHhbECaOn/AgtitSLQiyXtN9xGIo2MOxo8JgecfbFOj4MIKDKOQajg?=
 =?us-ascii?Q?4IefL0QH3l47ev1n17wS5uYZjPnyxZ+XE+FGOWc/XxIf7PhyFnjbdH92EHW8?=
 =?us-ascii?Q?lCi6n5uDF8ZAsHGJmRu5T/sbc0UWzUvhjgRZqeu1CFTswAKSjYWFvMn7SMtl?=
 =?us-ascii?Q?r4JkjmnNBLWJDCCkxlKH/u3oBHg7R2509hdsfnDQjrZEuPNeY5MPWREqxMlh?=
 =?us-ascii?Q?6hdf7x0Ebor2vj8VO3K8eN2BrsOyydQmAUiFIMJI4U+fnvyXI8xQm0G3SwIv?=
 =?us-ascii?Q?OgBgflf7IChdCuJ/1zouHQJqIevNC0jT2Mua+R1AR7YTMKTfq3Mwh4TBMG+y?=
 =?us-ascii?Q?eUnxaldU15bey+vXP0K6DRTlCS0kwuIwkPgVqlvif2AgiEPGhoCCDAZgwiYg?=
 =?us-ascii?Q?wsX3tULh/aKdFlkakc+yU7wr4hqb7MkCZLH2yoR/ktrPx2e4qoGUgTdtgf5Z?=
 =?us-ascii?Q?CeLEYHIasyFTdfezXHvOExV2iqc53Kp1s7uAJnJ01LiXWUm82QvGZZ9IKp9a?=
 =?us-ascii?Q?fInJ5+LsiLKC2Sb/UTuhCN1tE2SCkn/1mxaquWI62zfyM2P1oew2ysWWYdxy?=
 =?us-ascii?Q?pNpwAGJzGg=3D=3D?=
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
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d95113d-0876-421f-1e48-08df398ff795
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 09:51:00.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnMQYloS4QN6Blh98vIcZX0cODcuxxB4OPTEIAd6SV1tH6jmUsHHlgStSoEnMudKTiJHCWj3k+8Si/wEFrAmC69Okxl94QzXyuyelQzFmws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB3646


>Subject: [PATCH net v2] tipc: defer local Nagle backlog receive processing
>
>A local TIPC stream can soft-lock a CPU when receiving a packet sends queu=
ed
>Nagle data while the socket's spinlock is held. Local delivery enters the =
receive
>path again before that lock is released. The nested call cannot take the l=
ock, so
>it retries the input queue without making progress.
>
>When an unowned socket has queued data for a local peer, put the incoming
>packet on sk_backlog. Queue work to take socket ownership and drain the
>backlog through release_sock(). Leave the older data on sk_write_queue,
>where later send and shutdown cannot overtake it.
>
>The owned-socket path already puts incoming packets on the backlog.
>Only inspect sk_write_queue and the peer node when no user owns the
>socket. tipc_sk_enqueue() holds sk_lock.slock at that point, so a user can=
not
>take ownership and change those fields during the check.
>
>Hold a socket reference for the work, and drop the extra reference if it i=
s
>already pending. Queue the work after leaving the receive loop, even when =
the
>loop stops at its time limit or finds no matching packet. Set up the work =
before
>publishing the socket in the TIPC port hash.
>
>Fixes: c0bceb97db9e ("tipc: add smart nagle feature")
>Reported-by: syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com
>Link:
>https://lore.kernel.org/r/GV1P189MB1988F6301FA670CA9818F7FCC6DB2@GV
>1P189MB1988.EURP189.PROD.OUTLOOK.COM
>Signed-off-by: Bart Chronowski <immersa.bartosz.chronowski@gmail.com>
>---
>Changes in v2 (since the posted v1):
>  - Ordering update: keep older output on
>    sk_write_queue, where later sends append and shutdown pushes the
>    queue before FIN. Defer incoming local packets to sk_backlog
>    instead of detaching queued output into a separate TX queue.
>  - Initialize the backlog work before publishing the socket, and
>    inspect the TX queue and peer node only when no user owns the socket.
>
>v1: https://lore.kernel.org/r/631b75b4-d1e3-40ea-a129-
>5ed090f914bf@mail.kernel.org
>
>Validation:
>  For the reported soft lockup, the C reproducer stalled all eight
>  unpatched guests. None of the eight patched guests crashed during
>  the 270-second run, with the same base and config.
>
>  For send/close ordering, a framed AF_TIPC stream test kept accepted
>  data in order in 300 later-send, 300 shutdown, and 300 last-close
>  cases on the patched image.
>
>  A complete workqueue trace recorded 547 balanced callbacks and
>  four requeues while work was active, with no overlapping callbacks.
>
> net/tipc/socket.c | 42 ++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 38 insertions(+), 4 deletions(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>65cc0c4964b31..b03dd4a3d3ea2 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -94,6 +94,7 @@ struct sockaddr_pair {
>  * @peer: 'connected' peer for dgram/rdm
>  * @node: hash table node
>  * @mc_method: cookie for use between socket and broadcast layer
>+ * @backlog_work: processes receive backlog under socket ownership
>  * @rcu: rcu struct for tipc_sock
>  * @group: TIPC communications group
>  * @oneway: message count in one direction (FIXME) @@ -128,6 +129,7 @@
>struct tipc_sock {
> 	struct sockaddr_tipc peer;
> 	struct rhash_head node;
> 	struct tipc_mc_method mc_method;
>+	struct work_struct backlog_work;
> 	struct rcu_head rcu;
> 	struct tipc_group *group;
> 	u32 oneway;
>@@ -143,6 +145,7 @@ struct tipc_sock {
> };
>
> static int tipc_sk_backlog_rcv(struct sock *sk, struct sk_buff *skb);
>+static void tipc_sk_backlog_work(struct work_struct *work);
> static void tipc_data_ready(struct sock *sk);  static void tipc_write_spa=
ce(struct
>sock *sk);  static void tipc_sock_destruct(struct sock *sk); @@ -499,6 +50=
2,7
>@@ static int tipc_sk_create(struct net *net, struct socket *sock,
> 	/* Finish initializing socket data structures */
> 	sock->ops =3D ops;
> 	sock_init_data(sock, sk);
>+	INIT_WORK(&tsk->backlog_work, tipc_sk_backlog_work);
> 	tipc_set_sk_state(sk, TIPC_OPEN);
> 	if (tipc_sk_insert(tsk)) {
> 		sk_free(sk);
>@@ -2428,6 +2432,17 @@ static int tipc_sk_backlog_rcv(struct sock *sk, str=
uct
>sk_buff *skb)
> 	return 0;
> }
>
>+static void tipc_sk_backlog_work(struct work_struct *work) {
>+	struct tipc_sock *tsk =3D container_of(work, struct tipc_sock,
>+					     backlog_work);
>+	struct sock *sk =3D &tsk->sk;
>+
>+	lock_sock(sk);
>+	release_sock(sk);
>+	sock_put(sk);
>+}
>+
> /**
>  * tipc_sk_enqueue - extract all buffers with destination 'dport' from
>  *                   inputq and try adding them to socket or backlog queu=
e
>@@ -2445,18 +2460,30 @@ static void tipc_sk_enqueue(struct sk_buff_head
>*inputq, struct sock *sk,
> 	struct sk_buff *skb;
> 	unsigned int lim;
> 	atomic_t *dcnt;
>+	bool deferred =3D false;
>+	bool owned;
>+	bool local_backlog;
> 	u32 onode;
>
> 	while (skb_queue_len(inputq)) {
> 		if (unlikely(time_after_eq(jiffies, time_limit)))
>-			return;
>+			break;
>
> 		skb =3D tipc_skb_dequeue(inputq, dport);
> 		if (unlikely(!skb))
>-			return;
>+			break;
>
>-		/* Add message directly to receive queue if possible */
>-		if (!sock_owned_by_user(sk)) {
>+		/*
>+		 * A local Nagle backlog may loop back into this socket while its
>+		 * spinlock is held.  Queue the triggering input for processing
>under
>+		 * socket ownership, which keeps a concurrent sender from
>overtaking
>+		 * the already queued output.
>+		 */
>+		owned =3D sock_owned_by_user(sk);
>+		local_backlog =3D !owned && !skb_queue_empty(&sk-
>>sk_write_queue) &&
>+				in_own_node(sock_net(sk),
>+					    tsk_peer_node(tipc_sk(sk)));
>+		if (!owned && !local_backlog) {
> 			tipc_sk_filter_rcv(sk, skb, xmitq);
> 			continue;
> 		}

Bypassing tipc_sk_filter_rcv () and adding many skb to the backlog queue wi=
ll quickly overload it and cause packet drop.

>@@ -2467,6 +2494,7 @@ static void tipc_sk_enqueue(struct sk_buff_head
>*inputq, struct sock *sk,
> 			atomic_set(dcnt, 0);
> 		lim =3D rcvbuf_limit(sk, skb) + atomic_read(dcnt);
> 		if (likely(!sk_add_backlog(sk, skb, lim))) {
>+			deferred |=3D !owned;
> 			trace_tipc_sk_overlimit1(sk, skb,
>TIPC_DUMP_SK_BKLGQ,
> 						 "bklg & rcvq >90%
>allocated!");
> 			continue;
>@@ -2483,6 +2511,12 @@ static void tipc_sk_enqueue(struct sk_buff_head
>*inputq, struct sock *sk,
> 		}
> 		break;
> 	}
>+
>+	if (deferred) {
>+		sock_hold(sk);
>+		if (!schedule_work(&tipc_sk(sk)->backlog_work))
>+			sock_put(sk);
>+	}

This approach is not good. It creates many work queues and could impact the=
 performance.
Further more, as reported by sashiko, it does not cover the net namespace's=
 communications via tipc_lxc_xmit().

--
pw-bot: cr
