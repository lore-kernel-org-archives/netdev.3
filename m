Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792594474;
	b=JNVq/HLF8k0iphb9XEB1ugd3BG5kZ0JzbyJ1uQD8bt1/ssZBJbQqUG8UcX/I27payfkV
	 A4nKSFh20H4RQcoXd/Xb0XmRlm8qH9WeMaK1nWI/xWSnrL5DQHuCQ9gRokFcxd+S4wvVi
	 SX3NJ9Jkjrjp7f4UEng6ZzOwDWspNDPZ8BL7cHYpDgxmMsuClVq1ZXMaWtyDjwq4OUYt6
	 ZbUn1fNCWr5kD0ERX2dc+p9V1uhI87chE29OagU211EXmIeYzczBlFvviP0ws7XeiF4Ab
	 qo5GVAu8xDi1PiZD3JRyVUrRdkiuiD9e3vai1zWRa4n++RKq8EkZEp4I+p+T00WQbrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594474;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=q29L3qZKtox3gaO/zCeFJJk1w6etRai/X+GjfQgP3Po=;
	b=5mWkaKn4yEqIU+AYzaFs+7MMO+7gav190So91QhZaFt1eZQ3br6CtnCd0qnizeI7VPss
	 BWjQqZQLymXwaLiXpQYKz0HrUF06oLMj+2EjUJnB+0EzfWOXrg2WydqRi608E1wIyr8I2
	 w1/EG7r/UFchhHSg8pP/AY/yjJVoFH+9El+p76XnooEdTwFxtQCJf7V2nP2h19HkEVN19
	 2cjogxtFB+pTMDret2vgCJ3HnXQL3LlfczZAG5N3DEutwKpoYVyZap6CvDBRWFfEBMbNh
	 tBHA2uem6njIe46uD6GZhKgyerXWCcigv+mCq7/qainmiV4pnvqtFQ6jivn++GdVbog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aPA8jCOW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.10
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB2606A324;
	Wed, 21 Oct 2026 14:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98BB2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aPA8jCOW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfWqF6axm31D71RsMtevgan/+YcM0MdX2QVs7C31anE+/GVYwfaYodyYLM/FkBXDtdCwpsJJT3x1R85sJiyQek201wcQAusnEQaZJSf1udPX9fJv+WybvxwBCtnPTOwBNTM/oB1mxPXSkONa0h7MGlktvbInbrkECVdhlFgp0nH1cYpW3wFQdPrcozWoooVU/f4UWlYlHNi+mypFxS2lVSbdLq4FdVav7tzvHGCbfjWNTmooBnn47C6U1Ne0DVPnCm/6b/g0eMkKpRPEmgZIglQpEX8BpEV+1goX4iNkuE/EOt1evJWY+mR1EuFX+Ig0A8Yn8CnpPVKYwpxzhQkZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q29L3qZKtox3gaO/zCeFJJk1w6etRai/X+GjfQgP3Po=;
 b=YSEt2YW3gTlyrFcggLpmRctRcmz0PMASFh/5klT8gSGBGrtM06mxU2A8jyzEgGtpMeg6FQUvQFfQDboHz1EbJ9C6C3IjTu+C6T6x4eD4W6tTQOulvuUeY5g9/uHxKHHR+r2mPQlq8FA7tvpZ80GXtbAchwCSGC++C5cyTvK/ghFUy/O9vdRH2JD9ww4gO+8OQbDEGxEaWcBo2P6l8n31reGVRO4cK6DXk1G1YJf6qIByRB/7Oh8tIsrEvoD4tcPOMAzTpMV5QnrojzdqCx7FJ0muPu4M4hMZQ7HE8Cic0TeBsOhgzaeO3nA4efIW/p1DlWkjiAUhrUHdaSLtNOuZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q29L3qZKtox3gaO/zCeFJJk1w6etRai/X+GjfQgP3Po=;
 b=aPA8jCOWP+259MQoPGK35g8J/ySbNw184p9uDcfJrTCisidMY58GjYRKNI2LwHNa/cRCxEce3Q52Gs1yOvBfWInjw1pCWMBBwyD5Np/r9hZsCS57x1fX5Fvie95N+wV+czN5kBfsRKf2Bp34FWCbgqn4bGd6JqXU91XzhtwJcmBcR3TY+rjjNdS8GhHV0RWPWByS3ZZ3XryfpIcxeUE94jF2OCjsbDKbSYFxauCd3xCyKZnBICPPnQuoKpJCAC+bKXUZ2UWLQCdM1c8fvAeyuT9r+vgYqONdM9oAMpwOw2kIjG0CX3XFCVZLTTezuvz67E3BUBlkIC0wCJ21Mgn2hw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:54:31 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:54:31 +0000
From: vladimir.oltean@nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Zefir Kurtisi <zefir.kurtisi@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net 3/4] net: enetc: ensure head buffer has at least 16 octets
Date: Wed, 21 Oct 2026 17:53:13 +0300
Message-ID: <20261021145314.1435049-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::10) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cbb89d-9e33-449a-83d8-08df2f833677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|7416014|376014|1800799024|6133799003|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	y2o37pYusd10FgFNxRMemWg7nYpTZyzjen2V09IpJWcx7EVkgF+hFcSPMiIP4z41Kf2IBb45LzeF/UtH6qKlNNb3ooaOK8FkxIBiAOaO4LC7UfkIBy8IMhSQf9cktIHJtCVOvIGPuiGUqQDqL2oJZ/8LTYEuDvFTfXjE3rQnAlnWf7ieoom+IS0+Hmm15kcv+cdairygpsEmUdT0YqchcOM5yMMfCf5JgEHe43BQnSsyKGOR4Gn7EPlu0i4HsJoKlmDAuIDLA62Mi0RvjJPa6Eb8OGTN1kq0HDffBtcAHztwdqG3h5I8CsPDbLiUbK9BC9WKhiUJgZo1ccr/rSvPsmkguvW/biwrYDEcJ2P9SaTxjVA3rIkZ+RphBX4b9ytkwPRHdrXqp4QHIIygtQbd67F64SQODIO5msEIIyvitWtzIoDREnR4bn/sioC9tbq20A2OaPrCPuHDbGZtmeCQnPpdrp4CCkocKch0uKDF6Pbwcj7i0AqicL21lg0E8NyFY7dtvpmclPq4kYqZrbN4APKRt8J3WHNLxx8yKDFLeMx7XDoyTuUbuu5yftlQoJX/5AJkDlJmRyNPbEhmF5gSHnTXdOX0RR4pcqfiqvehnOh0mc7XQtPkXmi2M6sS4hsY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ylOYMX7ZrtE6ZEhOOxuIH6fC0iMcPignhTl9RMWbZgle12r+0U13m7aJkXPk?=
 =?us-ascii?Q?Td27NgYvqZRsq0pm6ksm+U6EhHbgH1ehlPeGbJFA15FilaxTQFg6gub5vwCc?=
 =?us-ascii?Q?04TBKzJlvP63/lzupMqdjAtomkcXbkp9ppQtnQgeH4FqzJWjctdPOGYomCy4?=
 =?us-ascii?Q?ZqoxpdAhwSDIYhmX2K9ylqG94VRonQmcipUjEArqKBO05uAdzNmawA0aUDW4?=
 =?us-ascii?Q?SJApBzFdKVyfBMWJEg/TNFNKGWmub7zIgyWkk3ImHzaahGFe43VQcXaBfGQk?=
 =?us-ascii?Q?S/V2cb2bq/0QnuIkgXp91vHh7xWJeZwE+/OwGkSb+w5oKmF24Dd8Wtf+Dm/T?=
 =?us-ascii?Q?Nj+CAPjgwlPUJAcwXa5LmwyL36zFe7i9Vt8cX+c4GMFjhCHqMGZA4djYbYNY?=
 =?us-ascii?Q?/cDnHHiYJLGsa6P5ZiBXAYQpmqSz4sQOm0JKM3gfUC7es9l6MZKOlnl+1QqD?=
 =?us-ascii?Q?Ybh0R5FOoW1QoRiTIKuYxJJ/K6ZBg0c8EVOm9qu1oZ4q7jytrYBtA8P1Qcqp?=
 =?us-ascii?Q?ihVj9/3cvdJdmEVuPW1SpGUr8/N6BqHejK0Dr8X0IhvEDpCFR3HpyzIGOlzd?=
 =?us-ascii?Q?2wT7JDSzTqh1lYyOhZY67HNilkxg89oqoRTqVG/I16AyxgpUNhFjCYX6cO3K?=
 =?us-ascii?Q?0KooK63NIJR3tmTNoGY+1tuXgTxjtmIYnwraw+FIa5JuHqOTT/qig+XERt3P?=
 =?us-ascii?Q?uPaRmhzjYfDg79ms6BBy4vavkUPGMjaT957kA9DYIIimPUcncFfEVdTOKmQT?=
 =?us-ascii?Q?sumG8HZiRZDvH4uJMUgHzgTbwzPf0K8W6+FvIV+DjGufB0Bg+uBcxAI08fZ2?=
 =?us-ascii?Q?oBNLSsB3mZqTqEwSoR13wPkFKscRv4MdBLC/6tPDyL0PYUS1zCTmZ1ud75cN?=
 =?us-ascii?Q?ZCr7Fa7+xtWcdZYgr3c1IOgaFrz19+DB9lUspvS9j1CLAFqPsOK5FVWCXIyG?=
 =?us-ascii?Q?hFECk074gPnuMmD8x6d9yI84bJ6J+mkYgqiwKzpLZ4z2Wi+koKsZzW7+JmKg?=
 =?us-ascii?Q?KMfhMr0Ap1iwgCyECJvHMec7YTGBiv/MumVaNFgpx3IXBmueDnSI9qAJosRX?=
 =?us-ascii?Q?xyzdnGU1A8FdAbmKlJTO2EWcaZTC3/ylUGatl+lSRF9ItuKQ5t44BYj0TD5i?=
 =?us-ascii?Q?+2fNqg7dzCfuJZ5gZxerFIFauob2zynZmW29JEz26Gl91AK6MWG9bRQXWHEy?=
 =?us-ascii?Q?4QvVlJCdMKjGIaIqEmKkEXy6LaSggEOcoRTDnvkIzyfp+4wvBM774n65NdH2?=
 =?us-ascii?Q?2vMoaBcWZxhjo0IMmrqQzSrfDef1JJFvBwSHwTZuGnCazTujtFka70sHp3Ks?=
 =?us-ascii?Q?lTAYyT9hknJRVR19YH6VVNSwdxrAADPY5ZUHIAlXKmzfZwW4/IBcpFP+7uJh?=
 =?us-ascii?Q?oHXGSzt4IGHmkAMRiYSUz1S2F+7rnyyYxC5t1zeE+onrrP/VYp88/oNjMxK+?=
 =?us-ascii?Q?INgdPbOp5+TBqFCOAkt8znuJABvtrX85FWQc7hJ1PgqPgU1nNhBTjX3BGd94?=
 =?us-ascii?Q?vM9OcAxuETMn4t1rh/fvXIxsLB6HiZeyN4v0YBKNNh6OMdtwMI78LOoDGOwD?=
 =?us-ascii?Q?2glwtBQzyaHrXodOf5pUS0fYfBKbd8mZsssh6AauDzu6jgUfl+eHqDZS3v71?=
 =?us-ascii?Q?Y5fLWa9HEsYHeTS/Zkt7zjD5jwExT3lUmhd9A7uYdkrX20k0OA07SQHdg2/H?=
 =?us-ascii?Q?THBXtdbTZvzYFyPpnGQcCXemrKy6XHHJp4FqHIDvazja/87K8tukT/3T63Ni?=
 =?us-ascii?Q?ahppgxl5WQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cbb89d-9e33-449a-83d8-08df2f833677
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:54:31.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Q6bv7G4Td4ojHd2DZArbhLaqfycjUiuQaHCm/YgpiiD7B3A+WS2qWlaNXXImx9EangbhZkrHm/Oqo0Wh8gMTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912

The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
less than 16. This is written in the reference manual of all SoCs
supported by the driver: LS1028A, i.MX943, i.MX95 etc.

  Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
  0-15 bytes are not supported.
  (...)
  The first descriptor in a chain must not have a BUFF_LEN that is less
  than 16 bytes.

I don't think proper attention was paid to this during development, we
found the text at the end of a bug investigation. Therefore, the driver
does not enforce this.

But the frame length and geometry is out of the driver's control, and
the network stack can actually send packets that ENETC doesn't like.

Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
through ENETC would soft-lockup the host through an IRQ storm. He later
distilled this into a small enetc-killer.c user space program which
sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
length) through an AF_PACKET raw socket. Note that this particular case
was already closed by the previous commit, but an identical situation
still happens when the first buffer of a multi-buffer frame is < 16
bytes.

The IRQ storm is actually a curious effect of a chain of events.

The hardware behaviour, when an invalid BD is put in its TX ring, is
that it would transmit the packet as normal, update counters, raise
completion interrupt as normal, but it would just not advance the
consumer index of the ring (TBaCIR) to signify that the BD has been
consumed and is available for software to free. The ring will also get
its TBaSR[BUSY] bit persistently set to 1 afterwards.

It deserves an explanation why the behaviour above would lead to an
IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
unhandled interrupt would typically just be lost rather than retrigger
itself as a wired interrupt would.

NAPI processing in ENETC has 3 steps:

I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
   softirq processing to the 'pending' state.

II. the enetc_poll() softirq handler for the IRQ vector walks through
    the TX rings affine to that vector, checks which ones have a TBCIR
    updated since last time - enetc_bd_ready_count() - processes those
    completed frames, and clears pending interrupts in these updated TX
    rings by writing to TBaIDR. (I've excluded RX processing due to it
    being irrelevant).

III. After the softirq handler does its round of checking all RX and TX
     rings for updates, it re-enables all interrupts in RBaIER and
     TBaIER that were previously disabled by the hardirq handler, and
     exits.

Because the TX ring with the short frame is skipped at step II (TBCIR
wasn't updated as part of HW malfunction), its pending IRQ is not
cleared in TBaIDR by enetc_clean_tx_ring().

But because enetc_msix() disables TBaIER at step I and re-enables it at
step III, another MSI will be fired upon re-enabling it. This is what
completes the cycle and the driver goes back to step I.

So the driver misinterprets the mixed signals it's getting from the
hardware, and ends up causing a software-amplified IRQ storm.

Because the driver now pads linear skbs to ETH_ZLEN for other reasons
too, we just need to ensure the head buffer has at least 16 bytes.
This can be done using pskb_may_pull(), which moves that number of bytes
from the paged area into the head. This is case 5 below.

  skb_headlen (H) | skb->len (L) | linear? | handled by
  ----------------+--------------+---------+---------------------------------------
   H == L         | L < 60       |  yes    | eth_skb_pad() (pads head to 60)
   H == L         | L >= 60      |  yes    | already valid, no-op
   H < 16         | L < 60       |  no     | eth_skb_pad() (linearizes + pads to 60)
   H < 16         | L >= 60      |  no     | pskb_may_pull() (pulls frags into head)
   H >= 16        | L >= 60      |  no     | already valid, no-op

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: none
v3->v4:
- rename from "net: enetc: pad short frames in software". The padding
  to ETH_ZLEN is now done by "net: enetc: do not rely on mEMAC hardware
  frame padding", so this patch only deals with the 16 octet minimum
  head buffer length
- move the check from enetc_xmit() to enetc_start_xmit(), after
  eth_skb_pad()
- use pskb_may_pull() instead of skb_linearize()
- drop the code comment above the head buffer length check, it is
  redundant with the commit message
- rework the commit message, add a table of the handled cases
- drop Reviewed-by from Wei Fang and Tested-by from Zefir Kurtisi due to
  the change of approach
v1->v3: part of "pad short frames in software"
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 6 ++++++
 drivers/net/ethernet/freescale/enetc/enetc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a9ea124f7835..58a88f15fa5d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1088,6 +1088,12 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		if (eth_skb_pad(skb))
 			return NETDEV_TX_OK;
 
+		if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
+			     !pskb_may_pull(skb, ENETC_MIN_BUFF_SIZE))) {
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index db3b3bad0f59..6fc7001c025c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -22,6 +22,8 @@
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
 				(ETH_FCS_LEN + ETH_HLEN + VLAN_HLEN))
 
+#define ENETC_MIN_BUFF_SIZE	16
+
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
-- 
2.43.0

