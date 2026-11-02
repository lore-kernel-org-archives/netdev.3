Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793628399;
	b=ljSuWpLNyuE8kUq7zLc9WCuNALlMGjW2VhBpNGlHoR36zsMm3CZXI1KXNBw/9MYGn9Wt
	 DP1pv27x2Y2yQVtCGa+ZJcdxU6HNh4icUtn7tWPkGz0r9GBYwuRCnxHREohAIcIIMCvD+
	 nt4MqpaCqyKhdUErkg0ttzJ8U6+AbGBE0GCyOxMzJJKr/OK6E9EYL1M0f/1SFh+xPL4iV
	 fqE+K+ZL/AkT+eS/MjcoO/4uENxIBZOSN/1EnNDwbW7p+iOYqWvEih/xuCLM+tA6ZXUwv
	 AQo//HYgyBJjX6Yimu4BEGBi6Xi0DVOBiu+SmckGENsk/tpj1UEXy4k5mIWCkOgSRNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628399;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=STi1dURiLDpmQuJKua5I+XP0b/+PquzEtJ3USDC9Uek=;
	b=w/28+W8a/tOLpfzo9lExhIvUlPblO3db/LobR115DKid3mpPAn944WZC4RAPEw75Tlm7
	 pxcyKEZRwTLma/f4vpqfB6Gun/l/ZxNLgJjNW0daiYtYWD7ul+AQKP94VFGezH06JwZP6
	 hARF4H88VIjR/uXJeBF0KvrsLAKOUy+Mf5Dsyjt3WNQxCEh7vwbRK++K08ghjPU18RYD+
	 OgV278z2vw1qqRzWs/JCbxRVFCAS4zodfsgbmo+qDGIcv6CyBU2gCd1x6xu5HSD9s4VGX
	 GmHZ4Py3EezT0r/Z2AFLd1KuQAevb7nlusFxAn0za+wtCqYGEsNlMV3WIp2Vpmm0EPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebius.com;
	spf=pass smtp.mailfrom=nebius.com;
	dkim=pass header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=KXsrNr27;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.128
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023128.outbound.protection.outlook.com [40.107.159.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE45606A326;
	Mon,  2 Nov 2026 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE45606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebius.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=KXsrNr27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYN7fWr7JczTh68XUnQJPUItpkJ4RzzFkQHTsXe89OGLMq23Ztcp6EIQW+Uz7HNjdHrsIV8nEnE7xV7Yq8gejtRCrhxy1C3AvJkyu6ZxCv7Lz4Ozf9U/Zcn4FYvh2yd1wFOX4MC8K51A+7EA5VA7kBc9cRX6GAva98IYMK/mrrzZZLw2z3EFcnDmQV43eZiRDe+xVSx0oE5nVR+wFxr/qxmRTYDA+NQDcaRIPpd7o/zq0bDcwEaGVBtn2VPKAIx63iIf6lowl+42+QBHViuPpblnXTJqELrEhmfXEG80HnYr+Go3QfXYWcZbqcoaoXG6K7HxvwL0kVy9FnsuS/7+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STi1dURiLDpmQuJKua5I+XP0b/+PquzEtJ3USDC9Uek=;
 b=Lfj3CcxjwAjtWmialmd0lJT5QHKzstWpn5ace+N6Zaad/UJW+cAFvG3UNXxz8E5XH6sBtBAA+CvMJP1U2r2gxCp98jkeo3zzfYXIDZr7TqzGKC4O8s6EahF7Iu2ejiyEQU2RFCxMEqdAz2bkuwmsxMAouLvUAjR6gHQzDwA8oX9pPcgV+T/XHrwuhBlec/nwvV+JHOSYczDzqzk1SVeshBjPsSLqO7cSANs3iOMyT7F373aNjTBGyHTNPFrMZvHvp8bWb4jCosJaa6WPSk685sQW9pYB5qA2dGgDpx6iIlwaB1lx1LZxU0L49ilrV+kjeeVcgs0jzJNbmvPaP2XkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STi1dURiLDpmQuJKua5I+XP0b/+PquzEtJ3USDC9Uek=;
 b=KXsrNr27dJvWYkcV6gA5N54wffoAGDUp8lwPXdE0T8qc9AjMZ4bd0CaWfOlk4ZsNDYJw5L5djlysbKFIwEbhOpM1tTHkbDJRB+i9QEzN0zhJjYhzHNRy0IGeL+dRViJr/lGXnzq5m8A+BToArAzkw51SOy4eJ951WX2UXm9239qTGxKBQJtAXNDUC4ojRFMuF0nOqt/qn/RdixZ/KuTlhSpEDUn/iu2K6yG6bgo56o3uxhl1Ug8ahIesq9Pqxr0wqYs9HfvDfo/Ea2ktQ5RpkhSY/fS4V84uOiGHU73HSBWKzREg4RF3TFeUihB+aM+ZaZZ5Xdj+9NcSmK73dMQKlw==
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 FRZP190MB2213.EURP190.PROD.OUTLOOK.COM (2603:10a6:d10:13d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Mon, 2 Nov 2026 14:06:35 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::dd36:a393:54ee:b1d8]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::dd36:a393:54ee:b1d8%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:06:34 +0000
From: Dmitrii Iakunin <zeil@nebius.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: NB-Core Team <NB-CoreTeam@nebius.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: validate checksum start before software fallback on
 transmit
Thread-Topic: [PATCH] net: validate checksum start before software fallback on
 transmit
Thread-Index: AQHdatNemQ1SbYubA0qfqSZtuDXfwA==
Date: Mon, 2 Nov 2026 14:06:34 +0000
Message-ID: <20261102140633.42564-1-zeil@nebius.com>
Accept-Language: en-NL, ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB1860:EE_|FRZP190MB2213:EE_
x-ms-office365-filtering-correlation-id: 44e4c996-cba4-4fc8-625a-08df38ea80a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|3023799007|56012099006|11063799006|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 byshVxjUOhCaSjZhKIVCVdu0UW0hLSuqFXtt0b1pypKvEJXKhAHvaAET9E2zleRvzltAl8KaVFOWlbtrkQQinHpWmG6dFV+N+wOvHLIjpHiZZQkMAaWm1w21mQXxgrCBWdW30xVKvSa6oRrjvEGr55snyROLWdGCmHQ4LHewWIm6iwLegJ9koz/pzMVFhtKGRrIJ8WjBs3tIY4LyLqTS2xppxeGDJExCaCmuwo/alvydgdv4FqxF6XPdOOXeOw1IzJSOwxSpVzz5SA9E7gQzUCsEBkpFONMvOhMemjSH+3nGoW6eQs9X1SdRy5lPLHO/V2K2hGhmiFAUiH2pKGbkzhwhkTncJt326Gh7gwrnB7TLUNeLPNjCKKKFg9OHfOj4VLKKYaE2LigVKQbGET/2HGZuQ58xPfaW8Zv5G/TY4fbiYxngKPrA+9bTiG4iloBAf+YWIrP0aZxdZYOtVzYEe3/gA987C76BUNIdqD7QXyzrAk3kUaUAcFvSCZPTr2NWpM4j0vOmUp0l2MbGfPcgXEWjvj9SFIgRQKGkAKHNvmTRQ8WOpH/bb+MdcMwE+v34pIxILoZBTPLiF1ofDLEdJJ4uDtjl6c+hzUdq6V/3XSYUnFhS/QIm00fGyQYpvDFgPHPdurWjtewth5vHjwfx4lw7T86AKzq4fdTfd5HFgktslIyzznd45dNEPfOe4DAG/Yzdp32rUhZoJG1eiGp1ooiZq4drTGBkWPwi1vqtI04=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(3023799007)(56012099006)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?u0k6LrnQCGIkjjaGoFC1I622nxjyh1GjUgzCmF1gn+GwbE7F/N2jDOqtSz?=
 =?iso-8859-1?Q?joGp4sXvVZQHnIzpLDPL1QLCyrMAqcXbkrpyTMkEJTg8061Ik62YNYN7xt?=
 =?iso-8859-1?Q?r48967sjA/VhkBq9+ha5QlUhn4UpJ4JfEgr91bQ7NHSYBiPMB3H7cAnbv5?=
 =?iso-8859-1?Q?ueaDR6XLE8F/PoTjxutvMc0uMmGHPZAV2sSEl0xL78s0YmdcSvDXKF5OmN?=
 =?iso-8859-1?Q?QJ17UkX9rlO06cECT9GPW5ZRiVRO3ep4dzGB+4dByjM/1A3MBYw0tYTRKU?=
 =?iso-8859-1?Q?kbUR8JwbG9VsrB8oDXDInbkb+NaoxAHQmO2tEGNGx2OSF7My/9md71IjRr?=
 =?iso-8859-1?Q?V4fwxOfYaKIvjVyX13jlFIdXSxVvNp3oxP0vsOP+FMALK9VJHGUyBhhSMW?=
 =?iso-8859-1?Q?t/kt8WNEiqfCYipM4rPXINUa1ImN7EyEP3+qWLoFddjOBbCswgxxE4Zkjg?=
 =?iso-8859-1?Q?EZqC9Jp4EyWnxPPmvbOzYoPsm/bTn1LEyma3vUsk2LVf9ZB8s2nsrKUiod?=
 =?iso-8859-1?Q?RvEdW8K8lloI75MUT+OT26XhwLk7Ihz07RTS1KOUarovLFHnuyjHtqeZqG?=
 =?iso-8859-1?Q?z3lEKUr9SeTPWZ5333BC8Ano4lM1J+clJfUFYu9kEBucRS/cRvBIVkMWje?=
 =?iso-8859-1?Q?mm9WAz206wRGIimn4mbPE8fP2YwsVfno4wML/a0BYM6cDuBPMnlpZmxUy3?=
 =?iso-8859-1?Q?C56gbUMZDaZZ4tFxXb7PZTyrPWnoVIJzzcu1u3GF1lqWUYdbXq3Nz6Ky0i?=
 =?iso-8859-1?Q?FXjmL/GOR7bXEzns6Vv55xeApUZScTXAJQxII7qQvA0UgtoESL/Y+V7YYl?=
 =?iso-8859-1?Q?tjLLGEEXLMiJ++Nm62zTLGRqx1Ds5DpmOuAG8s5cz+YyNDyhzWpzwRdme0?=
 =?iso-8859-1?Q?zcnCUcqdLsRxfy2RbP+R7BN56Axyk1mkk1w0gs0XPXCCmxlI3GWsoiHLt8?=
 =?iso-8859-1?Q?H+YZZiKKRD9UmzvkKw5NaXQFnGpjiLSYyUqlaxeJ5VW6wgo1YW+YrA/+TZ?=
 =?iso-8859-1?Q?9x+VUpXkhbjYzzWpNPIY3Ojq9amgiCaH9yszdC/BtZFqpqviodH+IygxNN?=
 =?iso-8859-1?Q?sPxf9H3ptXJFxcv5RVhVpFpFm5Mw/erateUKahKa5m9P2x/Na8sCqY3SO9?=
 =?iso-8859-1?Q?S46zvGrzi0z76rqcoH9xkQCt6re5DfKKayZLXdKQNJkTl1m0OR2e9qQI5B?=
 =?iso-8859-1?Q?VBhZQo2MNLPxAEzGed+w5yZmwFg2ovs9csfifLCylltzEpaQvH2xi1h0+F?=
 =?iso-8859-1?Q?08m892fE2/4bP5AJnvGJizTNi0+ILZBDUydgvogvvTkoLO6jueOtYuzO5l?=
 =?iso-8859-1?Q?jkWKMCrp4vtYR20n0GBr8ilvJ0LEsKDnyrWAor8WbVgq+WmSwnJgUgaWTz?=
 =?iso-8859-1?Q?G22+osPpCfJ1ObTNEreA09720O1Ze6xVY4LnXpqlpdKNRY4GKlXYbQvPoX?=
 =?iso-8859-1?Q?AlIDX9It1yEQKbPeTGEQyMn6Zro60gIN9SSAVSSiyOej+PmOH/Sr0dsV5o?=
 =?iso-8859-1?Q?oHLwn1KzZ9JjJgQ9AvS1WwyAHtURd7qCrOQpQ7nrpP8RQoEJl96/vrQWDK?=
 =?iso-8859-1?Q?iMgfc3zNQhJtFmNZ6bZihCkgZJkiIgAq7vy2YN7ex3r8iGWZvIvn3cp1dS?=
 =?iso-8859-1?Q?6MGojMHCXGzY4gCUo0W6dUjU+Tgg/59I/s1HENrvMD167XYgA+7a/DFzYz?=
 =?iso-8859-1?Q?hj5dDKBF/m5LY9f3Bsw5/TnQkpHQuR8noJxbHRnWmwMcfEIIWxSbXmv6hp?=
 =?iso-8859-1?Q?+xRhcucasG5t1ktA5StX2WFNIB0RpT+lCQAjlLEKPkd7Dc?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e4c996-cba4-4fc8-625a-08df38ea80a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 14:06:34.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZjD6pyuZeujIMNKqmlK9mfDmlFmD8DcTQjvAhnc6ZSuaTRr+hYiP6cGcEdwk92z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZP190MB2213

Commit 6785011f8b16 ("ipv4: validate checksum_start before completing=0A=
checksum") added checks to prevent malformed checksum metadata from=0A=
causing software checksum completion to corrupt the IPv4 header.=0A=
=0A=
skb_csum_hwoffload_help() can also complete checksums in software when=0A=
the available device features cannot satisfy the checksum request.=0A=
This path was not covered by the earlier validation.=0A=
=0A=
For IPv4 packets, ensure that the fixed network header is accessible=0A=
and validate the checksum start before calling skb_checksum_help().=0A=
Return -EINVAL on failure so callers discard the packet rather than=0A=
complete the checksum using invalid metadata.=0A=
=0A=
Leave hardware-offloaded checksums and SCTP CRC handling unchanged.=0A=
=0A=
Fixes: 6785011f8b16 ("ipv4: validate checksum_start before completing check=
sum")=0A=
Signed-off-by: Dmitrii Iakunin <zeil@nebius.com>=0A=
---=0A=
 net/core/dev.c | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/net/core/dev.c b/net/core/dev.c=0A=
index 3ac700d37e59..77c40e914e5f 100644=0A=
--- a/net/core/dev.c=0A=
+++ b/net/core/dev.c=0A=
@@ -4130,6 +4130,11 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,=0A=
 	}=0A=
 =0A=
 sw_checksum:=0A=
+	if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IP)) {=0A=
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)) ||=0A=
+		    ip_check_csum_start(skb))=0A=
+			return -EINVAL;=0A=
+	}=0A=
 	return skb_checksum_help(skb);=0A=
 }=0A=
 EXPORT_SYMBOL(skb_csum_hwoffload_help);=0A=
-- =0A=
2.52.0=0A=
=0A=
