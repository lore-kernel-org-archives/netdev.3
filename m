Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792662116;
	b=16Q8d7pg02FB1XSCrhZ3N7IAGN097IjIZbbSvm4yJkvfFtQZxRGDfs+r4eYHrvIAMo4H
	 /WsPaQMpQdqJijLARJ3qKX8GnXoc25H+vpq0I71V6rH3tqLeSbHwOTGgSJk0CQR21h5P8
	 dw1PdTZhwU9VR9m4WRpAl7quugcSDTSUB21ejZSN4KHisj5sEqptRdYknLkOjzH1MPnT3
	 Oyx42meAjPGnNGqq3ut1lSswgUnqsA744DGm7nAYnr4aom2iJ161b06IftW3Nkz/wWHxj
	 V+nzVRgICIjYvYnaFVIvlMvjb23+Q6lDZWacVCOMev0N5zffMQEyf8L9Iyl3NDnBxTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662116;
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
	bh=rNy0ePWFsZzuwCqxvFmDCjHYvl+pIfKPcZmVwY+FnTI=;
	b=Mj1Aq81k6aJQxgh+ubIkVXi5YRbRLKSxqBlFpLy9CCtJ2Efp8qDSkZ/H+sMpPkXj0qYJ
	 uFMJ4EuDI8m98KAKsO60nZ+9THglTTP+PIwM2mYOXNzQpuuNNP2wuNwCQ+TerGm9yH+CL
	 c+s45ThiLZHyBvYY+JPkFJH4Az7XxMSzR8t7Hd14ESkC7s1JUqA8tyE3Zx8+jl0k9DPfg
	 ZZyDB7owrCg25HddaZOBosTqEQtKjRYvRmJiRJhd/7UhbpVxW2AB6xlnYCXy7Kptsajl+
	 ZtZtASqN2ffFNKiskzxMlbwqzwEGWp0tzb3PKdMFnzuv+w3Ec3vDDvfITOUhqBZZyrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=f8VnFEGq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.0
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8094606A322;
	Thu, 22 Oct 2026 09:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8094606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=f8VnFEGq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POj7JXnKm1356BHnlAanUAIipjo0jIij73tGVp+2KINC2wfocsI/7P6FhgEVPb1pEPE8WmC8PmYQEiU4Sh3RiCQJ96d67jJN/E+WTT36V97WnASZI1GZxbIJ8wYzJqshVc0gPzzbEEhU51PX/73R7v04mA49Y6AqccgZ95RyzFpq2hEVUh3FkNFCZdizi76VxxCIHr7yCviK+MruoEsG+BYbgCx10GNHe5MutVek8AxtFVXLmzTbBwn09cE09KHmi1XJAW31Z0dSuRLN/Pqnu2Cusbh4Sc+z01dnv27yGarwkKMy0EPO9OU4nMvasxXvDkspcctME0ZbtkAZaRT0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNy0ePWFsZzuwCqxvFmDCjHYvl+pIfKPcZmVwY+FnTI=;
 b=czbUUZcNQp1oNcljltKf4iiLWnPq1EuLYUKPqaki7uQEbeHtlUBbE/3yOojJK7kwvfswPcfSWbJeyRLgZYJyHIX0r6VWT3GPGA88PgJomP4KIZ5F1F9ebgxBfmU20qNB4sJe4B+uucfeQcPqWW5/qm9tSArKB0Px7rcrpH160GPRMqxksnJep4Ejxo02HJilrtzJtV99R6WOz3p0OivMJAjonhk9SQ97oGwKskX/DpSwXDoUn0SoGgmsGUXxsHpyu9lSPv6njyhhSMLKFvjhiUXiCuTI1cAdZbB5jjwkJZljVGMK4vUzQmf1g007UvJcTzYlJn+4dOGbJZG/2c2UUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNy0ePWFsZzuwCqxvFmDCjHYvl+pIfKPcZmVwY+FnTI=;
 b=f8VnFEGqloW1ETvG03TKZG4Jvso1XCmDOnfVkv1Z4Kq4jyYT1nrkuVwjW7JDTLXxuuYhVhxWbfO0qxJk7O0BrzjJk/X1Pp1/CQ9uAtRFbQvzekg7f/bkUxy/sBetaaWt5Zj2C3/n0WHvLkScDzzbFmAO0bcloKhoOC9KOWi9qLOSPsYFXPLZi5FHRUQs+2CKybEmqq0fU/+MiMr1hFc7nKPtrdPiNWXpZGhxTj3yeodbxS6CTpUbTHCLwofy4OlHZuabyu9iAY3mu6IBkD5EpuRBgX8vlj8+IFKveeFP9LAuByH1VudKxTXMUjSwCNfpcPkdMPoimw1/AxCCaA1TSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 09:41:52 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 09:41:52 +0000
Date: Thu, 22 Oct 2026 12:41:49 +0300
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
Message-ID: <euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
 <20261021145314.1435049-3-vladimir.oltean@nxp.com>
 <20261022093359.723c7e93@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022093359.723c7e93@pumpkin>
X-ClientProxiedBy: AM0PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::26) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 0586a67b-e41d-4753-d900-08df3020b3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|4143699003|11063799006|261021135927099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fRw4qcpMNm2uJ1+uBRUu/Qstyn7h3eCEasTaSTjt2sPkiDHBiDdN6zK6fOYIoXvIofjVw8EePKgz59AJiiUoJGVokZMfiWdF+VuvXhDF7JWiul6rtNm0toKhmWRS16MgYw9BBFV9gtS3HUAcK//kNvKGaKCpytIjHFLsw8c7QNYXGq/pW6qEMqxKS+S4EBaX6EKXn5Cvh1o0K7DeYD7f5TTOi/kxTEO+O3REnCH2AFp8yTWoMHBvz16X0Xcnh0Qf8Ozr4c6hBPegziOLtl6vB4tJp+8SxJCAU1v5qPxvH5m/U6BFGzRAFdx83l1JV924Sfv8r6ulozApJhJZGwfVuJPMuGbMZfyF5Gdn6UaSkI4tyMYrv7yxAdtN8YfCoJ5ZrEPuKLQjTPL6tmG5EmtWfNZSn7Ji66kocWvBCEJOzKJMLOttbh5v3ZGTKr6DuyT2R9yKY+JYYBdLXTCITz+76nICdpWEuV8lFBGcZKJwtDqYNdX7E9y0Fn9EP2TW2QbKFjEfOykzDtQN3zMLSh3EHmhhFc37nRyXm5rSKkMfxWaInD9ZwTOZnqO/Rr85UrExHzkLjd6tWLJXzS886r0pJyX948rO1WnGvwl3TdSSY4G3Fearzv+/N7dCrkLtOAVS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(261021135927099003)(261021121427099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpISqkJEqjh0XRMI1bojwJ025N85Gy6unMbsi3CU8dKkJnUAswmSekMnIIaC?=
 =?us-ascii?Q?8kAOl68UT1jO0EjqD9dNzGdNLUdnPTMHJO5z5wwtKyY9GbKSyPtZ9KkbkYdy?=
 =?us-ascii?Q?M7XNveu2FZ5Jvx86hz5sgNGpT/bkgSUVRHVeRWcQvU8jj0xRddRYWUMjEUXn?=
 =?us-ascii?Q?UBnDG321S4mmvn6zkYp5eeSlc8NjySfUZ14mv+ivku7q5BmEeAxq3PA4pCKQ?=
 =?us-ascii?Q?qa4nB/NMJfPhrpPUUS966txutDNu0u9A0uwb30UA1CwISOwQAQ7Luek19MW+?=
 =?us-ascii?Q?kM8sQXm79BXHsgpzFAxSrnL5jvWzxLGhJZDPxFi1E+UAvGG/fYJ9VAYk3Lvm?=
 =?us-ascii?Q?fxj2JdwEJgjXxwzryw5T8NO3Wb3zLSLK1qUYaLJwwWOoytrQqgdH67MleAEe?=
 =?us-ascii?Q?9j7pSpoKAxxEVoCx8LjKEdzZtFfwXNb6IOG0h0CAEPnPMe++mEcJ7Q7bEJRK?=
 =?us-ascii?Q?Lq0iXlizRbUMD1kDoMRt2RYma7dUFQxrfcIiRq1wCoyCAe8b2WKtE+Esx9L3?=
 =?us-ascii?Q?PL2BNO4EyV/nyiSYARh773a1J4g6pDnmAuSzCvg2zB9qDcsnOs4Vwp+vLcJz?=
 =?us-ascii?Q?OG+wEpGN5QjkPzDN67F7/nLD2ZsrZBdOVPEs2zMydajvJj17vAOizjwNFnYk?=
 =?us-ascii?Q?9LGyHdCG1k4cP7bOX9p5bWlmY4Nq8CSQyhblVKwpa7RZ73g/8ksKkmFH1i4Q?=
 =?us-ascii?Q?D2Wd+YlkdrzcATiKEkDLm1BcCdA39pJvQUAiXhbK+JDwXd5GZfw3HImw0nND?=
 =?us-ascii?Q?5dpOINAk+9UnrNu21LufoLfWyifP/K7+krOfiFUp/XUle3xo0BkgMMqzCcIE?=
 =?us-ascii?Q?NfeXf8n95OqLFyKkSro9TD5XfYrqmpXJ1g7snDUenGg84JsgmQiqWa87i3iG?=
 =?us-ascii?Q?xJB4g21Lml5+0zNgSPfydKUoX3gh+PpvaJYLkelIaWDyObeCoxyjWt/EJ2R7?=
 =?us-ascii?Q?Y7hwaDBpcIpqiS2aIlFrzxfT1ttKUcEXekDIJHodEB/asHN6kIrh8WF65liI?=
 =?us-ascii?Q?CFaAASIxmpJcL+WVlMMD/Wa0LkhGkTOANpSRNqBCw7oqZNlu/hxa07y5McZ1?=
 =?us-ascii?Q?dem6vov109SIxq2Et/aNDio962Rq0mdQ7HBPckp2ZCg7ACCpbAspwRVu4EwZ?=
 =?us-ascii?Q?2nQUMYvyfIipM81TkWTKdDu/bw8oXELwMiYeAR7ulG4hP+l3pxo+2+MhRQJK?=
 =?us-ascii?Q?tplsV+Jqg0BfGdtcCwa1lsoDuLnmNpApgjL9AaKNjwDqmXH29gUAJwGoOyIk?=
 =?us-ascii?Q?W82tzxuWjgbCT1WTyxAdiVFffwCJvnUCtH49/btLGVcNEMDXBE7cOSBjOg89?=
 =?us-ascii?Q?VJRT1oIVL/o9WuNkk1dFlIyQsntDQXfDwdEwwbEyfcBuUa8DdsCOZ7oq1ptC?=
 =?us-ascii?Q?wPDenbx0ASq+AU+nZAEfZKbLgMs47umNr5MUefRjUlsDnBv843bHMaLcSSlx?=
 =?us-ascii?Q?+/VLDgx4nS2Mvx9S80rtbNtOfZharXBg4aZtlTLzaU21S+mZtKE0uvOit+6e?=
 =?us-ascii?Q?Guy1DeMX7Ux9yOp8WidPrU3gmgOvhCdp9W8PXfgXEokrFARCm8o2as+2ZruN?=
 =?us-ascii?Q?zAzejJVZgvv7Fihs9CoBaryuBSK+W4bU9xEo+YJzAzBILjaGpbpAvik6YuZU?=
 =?us-ascii?Q?OBPFbl25T8IXee35o1d4ILWRccAS2dVAG5o5EuxEvvsXDuxh8NIqUUxIL6ea?=
 =?us-ascii?Q?zf1mPvSXKcYYfujnIw3y8iiYUSQDAoRxTBhyVaGtVfJM4w0nEH9ZmzbUSUqr?=
 =?us-ascii?Q?jeOjKIuMeAiqObD7jc4cCvKsD/dIEao=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0586a67b-e41d-4753-d900-08df3020b3bc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:41:52.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCfs8aCKzVccNAf13LEDMSB7FbS7Hu+hib+sbpNtz7Mh9yVu6V6nMYASbWhbi6zC+yg7Ab6MUmLohB2Dg96QxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256

On Thu, Oct 22, 2026 at 09:33:59AM +0100, David Laight wrote:
> On Wed, 21 Oct 2026 17:53:12 +0300
> vladimir.oltean@nxp.com wrote:
> 
> > The driver sets the ENETC_PM0_CMD_TXP bit to pad short buffers.
> > This works, however sending short frames from user space and looking at
> > the padding bytes inserted by the MAC at the link partner, we notice on
> > LS1028A that the first octet of padding is sometimes not 0.
> > 
> > This is fine per 802.3, which does not require that the padding is zero.
> > 
> > However, there is an unproven suspicion that the padding bytes may
> > come from internal memories, and unfortunately I couldn't get sufficient
> > priority for this octet's origin to be investigated by hardware
> > engineers.
> > 
> > To be defensive and not leak any sensitive information from the SoC,
> > let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
> > have to do anything.
> > 
> > There are 2 distinct cases to handle, for GSO and non-GSO. For non-GSO
> > things are trivial; we need to call eth_skb_pad(). For GSO, things are
> > not simple, because user space may set gso_size to a very small value,
> > which could make the GSO super-skb smaller than ETH_ZLEN;
> 
> That isn't sensible.
> The minimum frame is 64 bytes (including FCS), subtract that, the MAC
> header (14 bytes), minimum IP header (20), minimum TCP (20) and that
> leaves 6 bytes for user data.
> I doubt it is sensible to do GSO for anything under the minimum mtu
> (128 bytes rings a bell somewhere).

My fault for not being clear and inviting this kind of objection.

Since we do GSO in software, we advertise NETIF_F_GSO_UDP_L4 too, and
there, Sashiko came on v3 with the observation that for UDP GSO, user
space can set gso_size to a small value using setsockopt(UDP_SEGMENT):
https://lore.kernel.org/netdev/178960175550.22033.10648880872141935672@kernel.org/

Sensible or not, it is possible, and I did generate a test program using
an LLM to confirm this.

Regardless of that, the last segment of a GSO super-skb would need
padding anyway, because even with a 'normal' TCP MSS, the skb->len
modulo gso_size could still result in a last frame < ETH_ZLEN. Padding
just the GSO super-skb, as I did in v3, would also not fix this.

> But does this code allow for the VLAN tag that you forgot about in the
> other patch?

Not sure I understand your concern here? Is it that with VLAN TX
insertion offload, we pad "too much" (i.e. to ETH_ZLEN, then the NIC
pushes an extra VLAN_HLEN)? I'm not sure that's a problem..

Anyway, with VLAN TX offload, the VLAN tag is not part of the frm_len.
It's part of the extension BD that we forgot to account for, when
determining whether the TX BD ring has enough space for the frame under
transmission.

> I also noticed that the code seems to dma map the fragments for each
> gso segment separately, just mapping each skb fragment would be better.
> (But that is for another patch series.) 

Noted, I can look into this separately.

Thanks for the review!
