Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792748150;
	b=jU32U2UqTKVQzviGM3nMprpwl9fo5UT++5ry2aT4t/euYDtVEOIRNKvoRUT2+n4ukOkD
	 SkCn76lOQopD2LT6+H6np3drf7SQEkpPDkYY06ou4dPe6pq5dFM3X7SJuyrcSS6pJeVp4
	 ezoPdL8SNIJAdHV/kfaD5Z/QBv5y8vP133Kc8M94YaQUURLwbKnpw9OLhJnJmHVwvrinN
	 +uvFsbNBSuN1kCgD4zKJycjDgRnRCwemowF8gJv3tp0vDnUwX9arXHx/FdkeA2dNRJPAS
	 Zx2ruYk7Tur05LmhJwYytNrsvKcKtYWMYW0Z6zrHRNHnkCe7jZ4iXoxIIqFoHhP9VmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748150;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WV7/NHDftYVHNnoVCVsx/91S5ChQ6JzruA5rEEyF35c=;
	b=vRcJ7m0gtZASvlunIO4i3ljl6IYhW3xltBRv9iIle3K3UY6ynEoR405ABNSup6BTFdW/
	 x0iIBOjdozz8GpbcAPyO9jaYxjBjeVeoMLtCqUDHpYw3h0RIlG14w5jXUyjKCDmPvPunt
	 cdCENfnjbCqxMY0KKt9iGshilLgd4eI7NJO73vprzNc3sj7bbBh8aRpeqdDdvGeUhU8aI
	 9/X4XUEkGU+s3DnxdT/PXGKExc/jldrRWaloYVI3cfHhWFbtjAPQoqAMFYM6PQohP/xXr
	 bUJ+q7UyvdUAZIGIjQ4kCRO8PJIYSxzMEycLFX5eB6xDeqjFKCjcOqKiEWd350J8AIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mUSKHnFH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.70
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B7606A31A;
	Fri, 23 Oct 2026 09:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mUSKHnFH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spx+yZYzCIX+5oJ0wZDffLVO4IGTMr/MFhak0Giog7j6fwyBb7bf9XBfFcihKDcGqklQY4NY7pKvRMCi4LbzFNmC7duYWT5AlvlSaJis7xJQrzmjzakdorj82kiyc/Rg46so336XyRaECCC3c1+hMXsgTiTVi2za/MGIh8dt4awZfQEx9GGMf5BOj+hb9atucau7KNAzuonHoYYHHKb/oaEdJIxSwRV0iVGiy/WXwb6h8eeQahl1no31APqfKvVMAFgXG2YBZk9JzFa4cYt7Lm/kgOCbmtmJJSKHmvNY1/C56Us744BNjOX2WAVoSMr+8sZ5+Bz63DeaIQFSp3px8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV7/NHDftYVHNnoVCVsx/91S5ChQ6JzruA5rEEyF35c=;
 b=lxs+2REamTSQHw69uMglpKL1rUve7jOkzr6Vtr5H7fK/otTRQmEFrl32x22WoAHmHOKFStCtxMlblRJcTDFfYMFDmxxJU9jDHaamz9nA2wDAcidibbSLpZNRwjH8VarCscvTkqYAqgi+U+PO+PLnv/xffc8XYKnDi+JgEcqMosKxrT4Zbsi0MUmv/4136MnMU/XHyA7vHNARHWkuO/5QE87WJjgv6nH6xIwwbOfSp3JMbvIJSeQqT+A2I6zAuydy+CpcAOraFHdQ1l/l6ItXtQM6h6bOic5s89K/DySxmy+4vgb6zvjusUVt+QvjJCot6V/FRD9C0nowyfDM45JRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV7/NHDftYVHNnoVCVsx/91S5ChQ6JzruA5rEEyF35c=;
 b=mUSKHnFHeciJovUrkJ+8GCOz2eR08fHkV2mzX8aVGK3RnBsUuWaC1OdExlHlhDKEFJBUOff5vHUjl0JiHSxyPFLb6VljNHnAtQ9/zodHdcw24k80hay4kcvZ+O4omHi03F/jBiqKCAz+mFAdP/UPUQ1BLwHxO0ts/LLWlbrDP9p+WtUI1IU0y6OV6JFrx1XZsHJdpycKSDbmKdRMJSwp2dofG0Y8H4DNVbZdBNX+bK8VR/1WoHP9CFHufq4QY9M6RB179avTGyNapdwhfD/XBVMztGfNBa6u0mUFJ04UpN2zEQt3ajAJpnmiVcyeBN20xECjZpN5apXjFMHg7wDHcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM9PR04MB8147.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:35:46 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 09:35:46 +0000
Date: Fri, 23 Oct 2026 12:35:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Zefir Kurtisi <zefir.kurtisi@westermo.com>, 
	Zefir Kurtisi <zefir.kurtisi@gmail.com>, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net 2/4] net: enetc: do not rely on mEMAC hardware
 frame padding
Message-ID: <wknllpdfntsyho4ppw3jkh7ohazqdiiz4kl2lyyu6oyfjgar2e@nl7waqh7lg2m>
References: <euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
 <20261021145314.1435049-1-vladimir.oltean@nxp.com>
 <20261021145314.1435049-3-vladimir.oltean@nxp.com>
 <20261022093359.723c7e93@pumpkin>
 <euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
 <20261022112218.11a1faa8@pumpkin>
 <20261022112218.11a1faa8@pumpkin>
 <kaqeg262ql6mucqzn46axaniowt35eq3hd52nefev2uvvkbfkz@6onteyxyjypx>
 <20261022214803.40cb2aac@pumpkin>
 <20261022214803.40cb2aac@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022214803.40cb2aac@pumpkin>
 <20261022214803.40cb2aac@pumpkin>
X-ClientProxiedBy: AS4P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM9PR04MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: d84f6ead-480f-4436-50f1-08df30e903d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|4143699003|5023799004|11063799006|56012099006|261022105027099003|261022075727099003|261021135927099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9k/mBcsDQrQ1j6iQiB3q4HswQxwSJTlct7Wx+qYr/5Mchpz/sHhttIV7FH9BRanVV8xAuMMqYmZazbGNKx348q4hfiyX+vF0EkTTGaA/xb87AVQe1lJ/utZUJencgNns5dmxas/21PvsAUD9W1JGsmm1jIx7H5y+w40gy/IrG6PeAACGYZI+8cyjRgvQ4YvmLaRlqe4IS94s9bRUYAGJV9lreHp/7TTL5/Vryy88OtfllOtO6iOVcpeCUsaul9EElbOjACovxmHU7btfTD+5CNPKBCuEfM2/3q/r3CcS7YKHz0VGTdM8PopOa+mnyAxR9j97oJ59OF14FoX8gCZme0/eNzXMQLWQ1gEtF1ZzvrgM2N2ektCz2FlcB7UQeaJAT6Xoo4k6vFIkshMUA5mTr3OMblSBDwg5wxxzT35qm+N19ze20WP3eDxQpp5euVVHJVgwDyOcMjd0Ef74dD3atqe66utFeYAn6T2/53Qn0cmq/txEq3fxxpNHjDpYSlyYv83HRB+lM/2UuxOzc9RbHpnkqqDxHzb4n51x+KtMNAiFqgDNlvgdEh9C6lS7z10d82EEHopiYenohrBFukBTum6Y5u+RyvejkwMOFSHUlkP3Dvc1wIB5PQcqSejO65Ol
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8B1q5jjJtVlQpvlOMeqA524xLAIATMx61ABApaCOcap2WyAiQmgA+MjgSCYI?=
 =?us-ascii?Q?8nQz5O7THDcGKVVjbdhA2BSMNEg8rh1ni5kELA+KAUej48FdVCabIkahRls7?=
 =?us-ascii?Q?jK0mhH/FA6joxb0FO9zRtFZJH+D20GglAWGDLJLhEjZvK//T/6K9h7cfmXRG?=
 =?us-ascii?Q?Sxtve5sYCkJakDyDb4XOz1qiqC7VMW/6j+xU1CTw/lFprBBkdBgpK17fJPsz?=
 =?us-ascii?Q?SDjwC9CLtU8g1HLsciogYJYD26+PGAEC3fpUeJGZ4bVHcDqRuaKCQRlpElEZ?=
 =?us-ascii?Q?o2E9hPAFiZcPxk0D0ZqFtMwSkGjyD3TSenuc8S3pzMhGNM+jA1jljVZp0o6t?=
 =?us-ascii?Q?rK8e9Lzfbug/DwuOgUxkOEYuTnjNzdtVVKRzeseNsN4Xa9f/ybkCcO5xY8zu?=
 =?us-ascii?Q?3p0dZQsl6Gr4ZXRu9I2gnclyS4JCrIBOWRNbxul0kQjSwVuLmXXwIseK0CQC?=
 =?us-ascii?Q?zAtzWZVdEzy332WG9QfUXKfraP7ZebZmQYLs1zIspmqdKY3vvMBnr7o5pmTV?=
 =?us-ascii?Q?lDNyTpGIh4V3DtrK1jMmAOD8OlKNPnD63zTqHvWXgf+nHySkDBSXTIwyfnD6?=
 =?us-ascii?Q?DftUztdk8g5vBn5zIw7R9utIho6wXoyNMjO9R8SPiT94/k+qY5wV4e2PcDS2?=
 =?us-ascii?Q?mXnqqa5MQykEUorCgssmPRZZoBUiPmmJ5HjyFRVzo7fm6GxKpy+WaThGLlLm?=
 =?us-ascii?Q?XWPDKeL4IUNfTb2TCKZnG5l1MCHv+x3hVxEiqsgOueAB1WErov0Dh6H3Mmbp?=
 =?us-ascii?Q?bfBcR7gqOeVYZeoGO9E9SwiN8yrXmyvmo8nSYeBw2auMl5sZWt+JLhSOkFFB?=
 =?us-ascii?Q?DZeJ877hD6DeJv3tNCshuuhJ7YONhTp/GtnVNqp59TdGBZp3oad+GZY4JvgI?=
 =?us-ascii?Q?wDtX2kqYTtUu3W9cuu3YGeGnoIUDmwBjEMvcD2JxwdCYebbihFg64XCNMeWI?=
 =?us-ascii?Q?q37Taiyhq1cyzn4SCuBc+M2L6cZEKLcqSIvQ2cCaur1LN9cxXJ0ImVtgQgzx?=
 =?us-ascii?Q?/17hyXy4YvtNAvq3JLr6X5C5iS1CJaOkwBYUTEZwBkCGmkkYlMYAthLEYHHP?=
 =?us-ascii?Q?jUihZ9eZgG6dChQSb5OLxQgRyrCLL+5UnxxI96inKbJVVYi9fafS1XV7NS0D?=
 =?us-ascii?Q?z/MttxJ6xY1S85+29/8+CaMjKobefi9zPn2Lv3TDgxrne9meGQPn3C0WDW5s?=
 =?us-ascii?Q?uW+mdRtyEjor0fIrYTvsOAUru7VvD0Xmf/UFXdjqbhw10SAprCafH+N5yLIV?=
 =?us-ascii?Q?tZBSDdWVBm+oKuOA1Z8BZB7wdpJ7jMw0RjInPeaP8NI6OdEvVk4D0ECCVHzo?=
 =?us-ascii?Q?I3wiYo/pKc32yS/5HJJMzJc2k7HaiJFLHhHrtvfFQYLHV3NW5bhBBw+hUOvv?=
 =?us-ascii?Q?pj33qTAjnNydmqNFAHVYRGHgbtQR1uG3XNwIcuxKNMwRgzL8i2uFnXgW6PuU?=
 =?us-ascii?Q?r1aTSB0QtzJ0jKO6+XCk975tic0S0Hfy8MCRw35l/itMaBupWyiJE8flWw1T?=
 =?us-ascii?Q?UBiuo0iPAfnQ9E7WCcd+MXj4gjRRNatqDT+d4XpOaJiVcP8iEjidEt15S1h8?=
 =?us-ascii?Q?U9mlPyAPXV+LZ1Wwp6kGnfQKPFHYyb2oCfXRUBhyClzoIsQ4Wdv9sl5Ms3Tz?=
 =?us-ascii?Q?fe7nExQLbE4AcwLFKZGBLrSKC7mQm7AdZoHUl276dPFchIKIUhDXub0zCwvm?=
 =?us-ascii?Q?1+HrS0jfayRuWSL5lrVDAKhORRjQG239CT92WtO1DwenViVP0NwWOeONFXFy?=
 =?us-ascii?Q?ps+n7VhWog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84f6ead-480f-4436-50f1-08df30e903d9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:35:46.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nIQvwDMYKkhO+rmIdbEEKjvlA8AH+jZ0nIUVbMNlokv0/wRNVEIKD5czY3Jb7EsyTnOEifCJWbOizptheCcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8147

Hi David,

On Thu, Oct 22, 2026 at 09:48:03PM +0100, David Laight wrote:
> > > UDP segmentation has to use IP fragmentation and that is usually done because
> > > the interface/path mtu is too short.  
> > 
> > In my testing, UDP GSO does not generate IP fragments, but rather, each
> > UDP segment is its own datagram.
> 
> Hmmm....
> I wouldn't have thought that was generally useful.
> Losing data from random points in a connection is going to be hard
> to recover from.
> I guess that it why it is per-socket rather than system wide.
> I mean, you can run telnet over udp and just hope no packets get lost.

After a very quick search, I think the main use case for UDP GSO was QUIC:
https://lpc.events/event/2/contributions/106/

In turn, QUIC has its own loss detection and congestion control, though
I don't exactly know how they do it.

An interesting statement I found in that paper is:

"The gso size parameter communicates the length of the
payload without network or transport layer headers. A
gso_size all the way down to 1 is a valid choice. A value of 0
effectively disables GSO."

> > Are you thinking of UDP Fragmentation Offload instead? As per
> > https://docs.kernel.org/networking/segmentation-offloads.html#udp-fragmentation-offload
> > this is deprecated and AFAIU not what this is about.
> 
> That is the sort of UDP segmentation I thought made sense.
> OTOH I think the main user of it was NFS, but even then 8k datagrams
> were actually so unreliable it was often much better to tell UDP to fragment
> the 8k blocks into 1k chunks (IIRC that was a mount option).
> 
> > 
> > The docs do also explicitly say that UDP Segmentation Offload does not
> > generate IP fragments.
> > 
> > > But there is a minimum mtu for IPv4 of (something like) 128 bytes, and
> > > it may be invalid to fragment into smaller pieces.  
> > 
> > I have no idea what you are referring to, here, with the minimum MTU of
> > 128 bytes.
> 
> The correct number is probably 68 (min max size of an IPv4 fragment) rather
> than 576 (for a reassembled message) - I think both are from the start of
> the IP headers.
> That means there is no sane reason to fragment anything so small that
> ethernet frames get padded.
> 
> > 
> > > > Sensible or not, it is possible, and I did generate a test program using
> > > > an LLM to confirm this.
> > > > 
> > > > Regardless of that, the last segment of a GSO super-skb would need
> > > > padding anyway, because even with a 'normal' TCP MSS, the skb->len
> > > > modulo gso_size could still result in a last frame < ETH_ZLEN. Padding
> > > > just the GSO super-skb, as I did in v3, would also not fix this.  
> > > 
> > > True, but that is a different check to the one you did.  
> > 
> > So what is your suggestion for the driver to do?
> 
> Clearly you need to allow a BD for padding if the final fragment is short.
> That is one extra BD for the entire frame, that same as a non-GSO message.
> You could leave the hardware padding 'stupidly short' gso fragments.

Leaving the hardware to pad 'stupidly short' GSO segments is definitely
not an option. Given my context: the hardware adds some non-zero padding
bytes, and customers suspect the MAC is leaking device-internal memories,
this is exactly the kind of attack vector user space could use to
exfiltrate data (even if not practically useful, this is a valid API).
The request has been explicit to avoid this if we can't prove the origin
of the non-zero padding bytes.

Now, having that said, I noticed that Joe Damato had this exact problem
a few weeks ago in bnxt:
https://lore.kernel.org/netdev/20261009215426.2377946-1-joe@dama.to/

It looks like he did something there in ndo_features_check() to simply
clear NETIF_F_GSO_MASK for the 'stupidly short' gso_size, so that
they're segmented in the stack and appear as non-GSO during driver xmit.
But this is just a superficial analysis. I'll have to see how much
complexity it adds to do something similar in enetc, vs just adding a
padding BD for each GSO segment/datagram myself.

> I assume the driver is building the ethernet/IP/UDP/TDP header so that
> will be one buffer and not hit the 'fragmented after 14 bytes' issue.

Yes, the header buffer < ENETC_MIN_BUFF_SIZE is not the problem here,
just general MAC padding contents. This is why I split the patches the
way I did: first never allow the MAC to pad by itself, then address the
remaining buffer geometry issues that ENETC doesn't tolerate (this
causes a separate, unrelated problem, that the software padding partly
fixes and partly doesn't).

> > > > > But does this code allow for the VLAN tag that you forgot about in the
> > > > > other patch?    
> > > > 
> > > > Not sure I understand your concern here? Is it that with VLAN TX
> > > > insertion offload, we pad "too much" (i.e. to ETH_ZLEN, then the NIC
> > > > pushes an extra VLAN_HLEN)? I'm not sure that's a problem..  
> > > 
> > > That is a problem, VLAN packets should only be padded to 64 bytes
> > > including the VLAN header and CRC.
> > > However such overlong packets are likely to be tolerated because
> > > an ethernet switch can add a VLAN header before forwarding a packet
> > > and it can't know whether a short packet is padded.  
> > 
> > Well, if it's a theoretical problem but it's not a practical problem,
> > I'd prefer leaving it as is.
> > 
> > Since eth_skb_pad() itself is unaware of VLAN TX offloads, I'd be
> > opening myself up to an endless rabbit hole ("why didn't you fix this
> > in eth_skb_pad()? It's a generic problem." followed by
> > "changing eth_skb_pad() broke 20 drivers!")...
> > 
> > Unless it's very clear why I'd be doing this, I'd very much prefer not to.
> 
> VLAN headers came in after I stopped writing ethernet drivers!
> I think systems have to tolerate extra padding when a VLAN header is present.
> 
> David
> 
>
