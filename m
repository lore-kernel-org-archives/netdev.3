Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792431459;
	b=Ggo6gO50zCqFQK408xCfK8SJCiKWutLLyQ9GjuWyat1f/oVWobYuEjtxklSL8zQU9mV4
	 q8tSfW7Tj0kxmN6WstImFxisqm2hb/uZNAmM3hPe/TlkbNZG8IX0BQpZlMezBEMRtY6nI
	 +cD8SK3pDHB31FDw4QzSCOnyPbiE6TJZCKYW/JAUvSuyjUvQ+lmwUrvQaGgzr2yyUUa6p
	 rc7cP+ToeaHGF1qIttGNmtnpU5coouvJSTDxplT1CQptYcjI85HMUc0XlsYqYSWmZSoXX
	 COANP2cW4BoDgAM1OqjRKuxPlj74t7YXA1wxerqM/Z2Kqr0kxSJGa2kipdWuGmfNLtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431459;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
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
	bh=e8ZtILKRZSohbCEmNEOQaS40KTDa+QMuBBjF5upVqjU=;
	b=ljPtg2jv3cOdRwO6ddnOCTCv31S+jisBuzQp9hOlwaTPM5ZmUUbco8FW4ggk4n8GZ1/P
	 XEEj9WmQGb4wmGojtSlhTdMlcZ3ER8Qw3YcQSmd8+tO75fGrbBE14sOwcNjRF1ujKlx1N
	 xot0VCGNkULMknabRT9F/yiJpbmjvX8H3cLtT/Tzkh0k1HDfmI7ciELgGZTVFXhVQF32F
	 OZfMokem3HoeK6Yqs5J5EVQYRzxtRuif5gVMiz20SBx/jEmdjqvZyb2slRBXZmaWTgtNI
	 pUMdIK9QqI2C2pW1CUkTFHq2ySJwhFNmIlS0ugaUXZMjMGsTnaf1+k13YflMw2fvJLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=visotia.com;
	spf=pass smtp.mailfrom=visotia.com;
	dkim=pass header.d=visotia.com header.i=@visotia.com header.a=rsa-sha256 header.s=selector1 header.b="T/JbZQ5Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.135
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020135.outbound.protection.outlook.com [52.101.69.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FE606A319;
	Mon, 19 Oct 2026 17:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661FE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=visotia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=visotia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=visotia.com header.i=@visotia.com header.a=rsa-sha256 header.s=selector1 header.b=T/JbZQ5Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrDowKrtFiFH8r9XxUo5X4yrGwqYlU0TUHjpqJC49Sg+oWSbF44JtKVdF72flz61QbYI/Wn4lZ5IqwxTQ9GJyfEzX3IoJ0qq8OStSPKpHZ6GppXtgEIxc6Bk/pkRjn0w3Wc0vJtimkwu8KwXA/QmYfcVtjM5evZ7lYyqBTmTQLl77FPTCYEF4PBr4BbQdYzvCFhbo2PwaSInuTtxcLSCRDiIZ73Eqmijrr/X1f7IsoZCMG2uuoWd8h5L4rgvNVNBKrXsl81VKF5wUpSD9lnboFk3Ck/k54MTCTfFmsgdcJ+JUYN/3Ei9KkbPv7I1VruzFb4/a9HgddswvxX1CNzX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8ZtILKRZSohbCEmNEOQaS40KTDa+QMuBBjF5upVqjU=;
 b=B/3idElTg966H242L5t2SLyruxwqIYthE+6JmeJMEalo+OuY/AOghFseKNk7TTs+JIqVc1L3evtM8CgT3aUzC+tgpRo46ijx8i0RFx1Fq4+CNd8LYnfT3EzawPRErHcxjmLZJljEGYmN8s8BOrSWDgnxrBDNAcENgYCgEpiUq9VKMtWeWIj0lWzCRsCesaJ0LY/qYs4iGPV+R0Xz4+5NUUcpdr78GsfLASYweQTBSyownrkfym1d7BBxmEd3TLangULeSASz5OZ4TN9q0GtFsauYTItiFWNIa9sT1iWohL5HSQPS8xRlkRCzATOqSbUQAx0zb4gfaw1aruwH/9SrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=visotia.com; dmarc=pass action=none header.from=visotia.com;
 dkim=pass header.d=visotia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=visotia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8ZtILKRZSohbCEmNEOQaS40KTDa+QMuBBjF5upVqjU=;
 b=T/JbZQ5QbbItNO8gq4q1b8W5qZm/e7dq+LiAKSgP4QTaYxk6loGOt0yB29aKSD/Qw7g9yYpCZtPMPMp/NFr03UlNPkZ899vMPQBSOyLpGjpOi6pqBqG8X26MjU30wu3dlj9Ha1Ul1KTNCzA7sY19TmT4eqnQstx1xJNKkXvGQ2OxVsxJ4nKdDEnCXwlzwV5sZCUmcmHHBTwtGgSp9+6+0Q4e1RyVlEfjX7lKxj22RNsT5csZdksLnG01+WKrknLQAlkjjrxHq95K4aWjhJMUxk9gAESieBZhUOvHAAKLrI6fVQK1ei0i8oV+zvA1C5reoWmyr4dIv2uo3uV3JnRhYQ==
Received: from PRAP189MB1850.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:27b::14)
 by DU7PPFD4DF0A467.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ae5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:37:34 +0000
Received: from PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
 ([fe80::5cce:ff09:8d2f:9cad]) by PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
 ([fe80::5cce:ff09:8d2f:9cad%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 17:37:34 +0000
From: Mikkel Eskildsen <mke@visotia.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Oliver Neukum <oneukum@suse.com>, Breno Leitao <leitao@debian.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: [BUG] cdc_ncm: soft lockup with netconsole over an AX88179B dock
Thread-Topic: [BUG] cdc_ncm: soft lockup with netconsole over an AX88179B dock
Thread-Index: AQHdX9CKh0EMeyYVbkas70+IWBbMn7cE8GAAgAAxAa8=
Date: Mon, 19 Oct 2026 17:37:34 +0000
Message-ID:
 <PRAP189MB1850A57ACC325B53755381FBA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
References:
 <PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
 <6aaea20ede0bd16a5138bc126f3ec897@tipi-net.de>
In-Reply-To: <6aaea20ede0bd16a5138bc126f3ec897@tipi-net.de>
Accept-Language: en-US, en-DK
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=visotia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1850:EE_|DU7PPFD4DF0A467:EE_
x-ms-office365-filtering-correlation-id: 0d7eab84-4aec-4bd3-e17d-08df2e07a8d9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|55112099003|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info:
 v94sPoMHQdKf87dis8F+FrlU6PWpkdAxPXKsPSFvaA7u5wjdkR/YA25wg2bcchHRnGClF+Azx89PGSA79tY481puV0ZG4F84sk1H2Cg61MCxRTrxJNrRfv13xbDpEGUXws4xNvYThjy6GN5PQTUUnZKXtRZ1KRY7t6mK4Lg7h4MHt3W5+7b/OaC8b4aeZlORmR9PCs5gIp/kZNCHEZqDCj5CFiOt/BZc5bcxqhgc3+S0RDUSP8VeDkUufmMaEwCKLDGoZ1e+LpHo79+NzSWR0SQhqIPAQSPmNV4kM47p0qT1eNsZwluqSrpO6L0HdOTzLZTxT3fow7QZeXZFO/J9SbYWVSFacD+nWfay32tqAF6mPfPjlQeB9rRrIXjNJDvnx3VHRqy1cTP/7EXVAI5RvkDKgHLZvkqM9JmvMnCxjBNZpcrcrPMQGD/pCerflavAS9XVCAZky7uVV6AAZIq8/nQdAX7LAVgCDvU5h+ZWzjpXbXYNV9LUdNpO1EbAMOnI8PGO9X+iR3u42k32UHhXO4DCm5ofggsOMQw7TR3hOYVJQTmIR6S7SMOc9xBrWFJ0aI33IVHIt0af6ziXlvBFYPi1e+rDK387BfAf2qiK9ZKg7UQ5FWsqj93NHe9fyRo91xWosXT11VDVtsNrOr89tz5kr6kvlTqmOfyKbcPD0sTkynQj+rzN2ide9V5kmqO7WHWCSpT8oJINmmcu6flkRg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1850.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(55112099003)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R7QhmQgeTyqi6Gv9DaLTEZkZCxwO5hohpunCVcTXU69dW8WQgZ0nmzxY1Ez8?=
 =?us-ascii?Q?hCfvsyNXSPb/H22qMuwGsvezWiluzRjHBTo1E/7ONfZJQ9y98neL7YLAyH4a?=
 =?us-ascii?Q?k4zdEBl4p/lkjpAAwMLxVD/ZJSI9kHlX3erJyU6Pj5zzBvJ/PO0c/9XDkTVu?=
 =?us-ascii?Q?a+IttXcQ3N/sgw+7d303YPIVRs3EHS6LRnqkrxNFibJgfejeeJ0lXccJ6J4X?=
 =?us-ascii?Q?gX25WPF2N/UdxOM+s8TyjeWrHwNL6V01Zxqjqamiuv5BdLupxHP+ablkMTBT?=
 =?us-ascii?Q?m51YP9lUUyxEyMSoO88cytIx7K0UAR9bDFQWGsjL3tlQF21HqecbcqPRKMbs?=
 =?us-ascii?Q?TRWfKuQ7+u4m2oih47SYjah9v4VMM2xI+nuTxBfYL3nB9OWQyet1mKsIn5nH?=
 =?us-ascii?Q?RV7J4ZFSvozH/TrpfoR5lIeE5wSl48S5bpVnsSr0TmoKD5deaLzl5btSlRGR?=
 =?us-ascii?Q?aJeazAOp6acDYZiJJE1x9Fluzl3qViGx7xYHB9LJ/fquVhKZnI6kwisFbWZF?=
 =?us-ascii?Q?u6sskgHKf43k4hbQ3d3cPZcN+qKsQrXDlC5AV2ponDQM/4EQWXkxUOKmB+2c?=
 =?us-ascii?Q?GfGEpVW+tfYImfZ5x3N4Grl/CmVKbbO5DSimOwPXl1qdwEK1Sultgfy5a4tC?=
 =?us-ascii?Q?5qHYcDLN8TQVNYCwrIQ/oKUa2g31dDWeR/W/sDbXMsqrJ3ZBrlDq5Qa2X/K2?=
 =?us-ascii?Q?wdxpwTLBWQOlVPmkwLY81tdCqGfEflGMfQT2OZ03LrYeHFtbaPhgvdpTlCvu?=
 =?us-ascii?Q?ClKMVxTyrO8gwIM/9w/EPM+8jYc6PaFEY/dSQUmqogjdFQhFvPwoKiVe15io?=
 =?us-ascii?Q?ybKz62ZkrhaeyOXkxUxBvb1pM+K5k8wSlheCNf9XMEJv4M32qpR5hUMytL9P?=
 =?us-ascii?Q?9Nr9cINEMozlAWHzOJTnlJEbxzXMdHsx82k4zfIPVV6xEiTw5H0FgpGSHl21?=
 =?us-ascii?Q?o0Vcg2v46S0hmrgrAjnZ9LvKmH2X0kCCjGFU+3mTG5HqlJJJpXopS2KacgUj?=
 =?us-ascii?Q?dPHFl4TurJuVjmLsDqMq+tOLVNgupIDoQ2RQVnpr5NyO2QllvWmRVMzVd29W?=
 =?us-ascii?Q?2glUACVs20L0COy8SLt/iKcr07a4++38mtWaS3ajlaTTUpzptigSAzpIF2tq?=
 =?us-ascii?Q?FrA153U0ige47Sg5vp0EnvuxelwXLKD2mwmbOpiToU6LUgKlPXnWAPoViQz0?=
 =?us-ascii?Q?vIPYZH/UH9c7j6y7wlToRTkzBzxWDJHjFAnqfIFhNfM7DbZesgjVd6ZbhjfW?=
 =?us-ascii?Q?ygGs1Dkc4g6OFjueNuLXV+jzGjPoB5g9Ukd8c9opSth7Xaho+2Ys2fbp2QnD?=
 =?us-ascii?Q?gmyMug+xt0bRIExYeNmnxuiFFPJ4FeNyBu6AycSXEzY3Bnni87HjnPMooX+q?=
 =?us-ascii?Q?hiMtMN7fbW7yUMH33CVvC5HbQQKVFgpwnyXL0ZzR7nw006lbhdsjUk/6ofqB?=
 =?us-ascii?Q?9BMtAaJzc7ghRJ0JNI/fM0QnxdJaxnjtwmz3dTrV3DXVuzDVNCaM0jfIK4Cb?=
 =?us-ascii?Q?fTpg7wK6blhlsOBZ56lfaT7C1kuzJO7AB9G+eG2ll1FQCQQnRoqTKM3y+Qfy?=
 =?us-ascii?Q?nHe/LolDzZpIb9bsw1HDsmqYtneKNEMroD7ofV+zI1s9zQr1eyxAA1zktgRN?=
 =?us-ascii?Q?bxb2h6Hf04pUdH7aWxYBkeMXRf+vkggr7coWsJcQqH7p0BHvkIKBV1Pjgo+q?=
 =?us-ascii?Q?MW2UVqEpjama0dv4EwUwHZgkmgX6TIhBVAULzNaVqSSqPcpq?=
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
X-OriginatorOrg: visotia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7eab84-4aec-4bd3-e17d-08df2e07a8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 17:37:34.1773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0398e9f1-d93e-448d-9e92-963c448c9a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kU6BOur+GlDfaZzIzFP0hNzbFVomx3BIq3zR+Yzst5UwDF5dKY5L3YBCZXbWSPsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPFD4DF0A467

Hi Nicolai,=0A=
=0A=
On 19.10.2026 16:42, Nicolai Buchwitz wrote:=0A=
> Below is a patch which hopefully fixes the issue.=0A=
=0A=
Thanks, that was fast.=0A=
=0A=
I tested it in a VM on the same laptop with the dock NIC passed through (AX=
88179B, 0b95:1790, cdc_ncm), kernel 7.2.9-1-cachyos. netconsole on that NIC=
, a printk flood from /dev/kmsg and 4 TCP downloads on the same NIC.=0A=
=0A=
Without the patch it locked up 3 out of 3 times, within 30 to 100 seconds. =
Same trace as on the laptop:=0A=
=0A=
  pr/netcon0 -> netpoll_send_skb -> usbnet_start_xmit -> cdc_ncm_tx_fixup -=
> __local_bh_enable_ip -> ... -> sch_direct_xmit -> _raw_spin_lock=0A=
=0A=
With the patch it ran for 20 minutes under the same load (about 14 GB recei=
ved) with no lockup and no warnings in dmesg.=0A=
=0A=
Tested-by: Mikkel Eskildsen <mke@visotia.com>=0A=
=0A=
I only tested cdc_ncm, the cdc_mbim part is not exercised here.=0A=
=0A=
Mikkel=0A=
