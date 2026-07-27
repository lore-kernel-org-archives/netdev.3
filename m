Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D172D97B9
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117555; cv=fail; b=MMHRiDEI8K/aomiF5GwJJFBiu38W/vw9691zNVYbH4v99XACDuV20wQZ3U4tvXvYiJ36bfrxE1LM5nlmDJNOYVt5jz4yB1R17mSuKZJeTTX9QRrZuuYLOROuaDU9SduZyt86iiAr6a8GyZpJ1SOVpMTyqEMS+WcHpCoJw8chtnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117555; c=relaxed/simple;
	bh=f2MTjVsHY5Xk8OFnGKu2VwWGVtwE/Pny2/simrFUQaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xu4FxyZ42bOVfCkV9m6lgrxtlSswtkSrdHGEyBMKB6KiOEyk9FQuB/6aGrA6hwFFekLgwFBMwpYGzLZv4vsGgL8uFU5uXv8gXwpeHNWjC1DppRgPyxtI0gmA+FBzFdL7AJ3QIByRDMxIcNBkJU8GTT9Al5w8VAYsa6fQtoEfbv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=VIe5t/9s; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="VIe5t/9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOkHHHUhZ+h2i8EoRxTlb3myIsA7IT3PhQg8hFGKLFaLoo2MgBt3NCaIUUArRQrYd20QME7+GeMgNEy813Ix6rezdxLA2Fe+0B7BeJ+yDSCqP7itKXgIY/AosY/+FZDB2jLeL8IQEOHkFxek+0VPc12L2wD+n8qWco7y8QuIPnBtGOxdtnOCCwiQZzHQ3bEMJ747hwV0JLtXc2O5frnbT63KYh6juL6ROQpHxAWt9QDs1uKIX9teS9Mf9G8M+kgGuszt1OVNFG9BCOXXG4AhNp4cZUBlDn6avB0xmRGFsps2iAkogsN0jpP9qkiCOWRp1B6chOEOuthIWZ+by0f/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X45+CcZ1Lzv/MSg6e9WDHjowTNrx1H5FIGbTyloPs0=;
 b=BnLPl848Tnj5643BScS8m9Kvu62e4CPBGnlZXN0NI11JBY42toNbz731AyU3S79IUwIpB3tRSZ0NJm5UFgvfzr4zvhzbN0ipJBtNfnVJv201Ow4Qn5m7dYnKSzTg6PWX4MOWe3hrpVdCO4zrXUJrQlRlRw/avP15kblcAXP/SRJ2/GgoZHtg5M5CUX0q+5uht3TwGLgGgApfbQ2KZmF2tJI0YekXN56EsdGsVRNlaKLEGaOLrR/0F8evDnd+wgYMR25K/Wykp9YauRRNzLCNwCu6nITpRrm7m6K47VtJ40RE+geHvgqL18z1QS+ekyqsNp6KX2fTp1ArPgCmbs+YoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X45+CcZ1Lzv/MSg6e9WDHjowTNrx1H5FIGbTyloPs0=;
 b=VIe5t/9sWf4eafyW1RqoiNQyvy630nYxT4CBWmrrPLacu+anNvlUkR8K74csibG6V+zBLMF3/PGKYTzU51euEStCfcH11heE8f53GpRFprUq/pSiZpvngGKHYS28Pawbom1g2m6xAZcere2Efh1LPS7lRXYH2Akyy6fUUe8OmyUciA6DcHzbCumhALMwseT3UqqTXXsLrCTNAPi6c++zRujH5Wthoxp54LikFEO1AZTiaowQXuuLiO0sG1NrdAzY3ki/8BKlkBuEtVc7E0dov2l4/8n0kCSAlnYU6BjApG0p8ajqBTclWZ7o5/kPKodczFn2s6anTxwciMC8QrQUHQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS4P189MB1917.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.9; Mon, 27 Jul 2026 01:59:09 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0270.006; Mon, 27 Jul 2026
 01:59:09 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ren Wei <enjou1224z@gmail.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "vega@nebusec.ai" <vega@nebusec.ai>, "zihanx@nebusec.ai"
	<zihanx@nebusec.ai>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [PATCH net v3 1/1] tipc: avoid use-after-free in poll trace queue
 dumps
Thread-Topic: [PATCH net v3 1/1] tipc: avoid use-after-free in poll trace
 queue dumps
Thread-Index: AQHdGsOrh/khYgqerkCyNjwo9cZ0GLaAoIeQ
Date: Mon, 27 Jul 2026 01:59:08 +0000
Message-ID:
 <GV1P189MB1988F2F08456BF7E7885B36DC6CC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1784794294.git.zihanx@nebusec.ai>
 <f8119abd5e5ecc400597de667ae9d39656de56d0.1784794294.git.zihanx@nebusec.ai>
In-Reply-To:
 <f8119abd5e5ecc400597de667ae9d39656de56d0.1784794294.git.zihanx@nebusec.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS4P189MB1917:EE_
x-ms-office365-filtering-correlation-id: 777604f9-4622-4f7c-1ce7-08deeb82a5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|11063799006|4143699003|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 /hU9RDAf0VOEb+WoMOZtK0vLlo2hwvjEcilaF8slJ6vZAeyuvAtJEWAlYbvb5x1XBT1EckAXuL7+USCZgToZCX05JJAurvTcYqaCULkXyceP64C7TswYT6Lf7/qN/3u/tT73rEpK5o8Aa5D+oXmYqoslJ/MfSiYy6XLiW9B5TAcCCoJWs/2lMAkMKjQyBCw73dYqtn+KArtFMtYqd5FswXLe+lPIzPl8N+u6VjSms7hmu2HyWfM5yv3pyhciZV66H7solUCIvKAmWE/IK7w14bn3lslZoZncF9mlPoB7oHPslRNHAobYIQVRi5AO7dizUCFjOUSYu5dnujb3nV074EB5suOxaRdFSqNugVaUOjXKNW0i4xkilOh+FL8Fhhdaa6QNt9c+PTwsAsh29mX10bfXdgyHu4aGymF5i+ewc3lSbV+EOKNfQAIJC/8r7k1lWJYE4m4Z4pqwfZkcZfzEjsLH+ouyCCEMgv2u+WHhc/DGsI8rqeKyefPvV9srxogcbQy/EPtVhZvfSZ8S8WNY52a1+fHGeBFb5fMrD8UUmuNheW+AfKIWmOlphbcEoSyjtno5wIclk8m4AuGQmgejYx4hcsuRsy08x5qwd4mebkelCRrlzL2v/FpOO9PCKXThKBoTCdulxVq8YoIdLXjpOShVXVwiah5GUc6h7LmaV43xYFGwhnADwWxS64eJpNh9P8IIXzPkKHrtT2rwLZs3dg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(11063799006)(4143699003)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lvXIwIE0r0dzeD/bhv24mIbLUtNef5G3o1XJrXCURE1sRifDcuIOOzlL5LIH?=
 =?us-ascii?Q?VIoDER2/GjDLEi1KJlD2U1hJXu65jzaDPH+hZCpFRGWYsVKf9cFfQVbehuru?=
 =?us-ascii?Q?I+GobuhrvVA+BmMcpJsgaNJmamNDIA2k+OsGBXhP7Xe1RO8aOjr03MFlznS3?=
 =?us-ascii?Q?cNapwRjqj+/lzwHldfV1jirw6MzII2YQP1CjY9im5FiTwn5SKNGbAoFeAXFN?=
 =?us-ascii?Q?zMu3AU1cfHTTm/9C+cwiUXnI+cYcqSZyxomzrVda3qgz3oWVcrf07o3ThjHP?=
 =?us-ascii?Q?DQ3/jgXeFnWpx3+2FUJxq694v+5Hq4uQ9MpLnEjUhzofJ/OUqkE5nuw9Voio?=
 =?us-ascii?Q?fYkc3Vs/2lLDUB6KqwS0B/ZW6I9860AVetPW3YzxNzbbVegkh9aRBkxJOUJ6?=
 =?us-ascii?Q?MZTdjpK6FB/Y16Dp+DJisxNUk3ZgMmvsEMku8fna0XRP1W1R6KKobENfp6/j?=
 =?us-ascii?Q?XZUvCipRw/bf97g1Jz7agzUraIxMpRidjDqa+8GXa6dEedjknKVbuRYRtC4w?=
 =?us-ascii?Q?56r9BAr7cDHWUbAw9rf5ZJOrMgWxPNzlzC245sYnD6AAZw9kLDxD8V32kIj1?=
 =?us-ascii?Q?3zOqUKtPMDmZBU38w+ekv/cb4hRsNDJFbWiDVVitAFcU3JJlmgzdtHIiOJF3?=
 =?us-ascii?Q?WcJkuQCfTP0hAAUiYiIXg30wLEKUrNs66/6H412YVlFRpBxZX27CVcGUHcNS?=
 =?us-ascii?Q?Mw8DSO6rs+qFyyBpiNXNWk8UhUzi/biS7qmSR+md0IHItiOvfJzWwl/+Y6gA?=
 =?us-ascii?Q?Bv2uKxR2RYsqcy3CbO5+OjKhVPmcuz6muYxZSBkUFm8g5F6/ZIqMjrFfqGIP?=
 =?us-ascii?Q?+wvT05dJYF8svCaUsy6vBUiw5TUtltHGj3RoNCPIziV2cd0K5oDi/VFj4ejz?=
 =?us-ascii?Q?OeY1EyurJndOaJ2ddgoA8ZsfKzJPN3JjDXmafTEIcp8p71jHwRevvguvZb8k?=
 =?us-ascii?Q?1dTRmUkRwPG/NgFUSMvGMsECY0r5/YPC5mm+CMF+zKl7yBt0NMZSrJ8N+Cnf?=
 =?us-ascii?Q?HS+6Q+8ruIKGBJ8mmOEWmPlG1sUXHEhyzyS8ogefRsjrmx6JUbjVcP/O/eqw?=
 =?us-ascii?Q?+UrU0qhaDhAIFfn1Cs+UM4qqU4gNL5GMcFD55iRrV98pZW/l8kfSooE4k9lL?=
 =?us-ascii?Q?ALjVrLj8kNKAj7IwQxBwJhfZ0QCFIUgqfAqlro57iLSXx8vXV1EyEsaEgbZy?=
 =?us-ascii?Q?3H3UMaY1uFbLWOffuw2jASFNouIBRqPeGNLfhur2QB229piBTxBU223Cqt+N?=
 =?us-ascii?Q?dRWygb0S0/3V9iyxuN3mQBbUOocY4YDJhbqaxduzfHoRvp3sF+27l/fJaA3A?=
 =?us-ascii?Q?hsQgoZsV9s9k6nOMyYwGlmathlR+ZpuFThPgKQxNP+jXWM//TaaI7KXB6MPp?=
 =?us-ascii?Q?xZpIDOkNmEFoh2/sbcmCwCvK36InZ4EGETygbLOQwWjz82ezSpb684hIwXro?=
 =?us-ascii?Q?WJkgm9m6iJvyynLKm8sqanFNNrCL9W4LWR3RHGUF7jrOn/Wed/Kt7U6wdh5S?=
 =?us-ascii?Q?oD6V/DAeY/s4xbBblt60D2yp5FT9T8+WgAgeg0U1EpWg/aW7WwBbUQKehfwY?=
 =?us-ascii?Q?TcWztv7vykXGqCo6TR4Mku0i2caHoNAaD7ug55vtMDP+GCnPzsHHBsuPHk6H?=
 =?us-ascii?Q?Akmhu98quM1Dz1giJ7oKL17oLE+Wb/UNuOdhDAHWqKSxov925eytzISzhwRS?=
 =?us-ascii?Q?qu8YkQTUVH0Q1PTzgcjTW6g4fm+wT/WZ+q8+nw5IJafb/xOlmdLeK43kKYuk?=
 =?us-ascii?Q?NqilYvRozg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 777604f9-4622-4f7c-1ce7-08deeb82a5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 01:59:08.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6d6m/NgyLo87pFunnPAmiIBouST+YvxquVorc16KpcwnOceATthO1uhwm2T8+EhBXuLpo1etLGc5ujg2bXARK+I03aBH6dtA2X0188ISHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1917

>Subject: [PATCH net v3 1/1] tipc: avoid use-after-free in poll trace queue=
 dumps
>
>From: Zihan Xi <zihanx@nebusec.ai>
>
>TIPC socket tracepoints dump queue state through tipc_sk_dump(). Most
>queue-dump callsites already serialize that walk under the socket lock or
>sk->sk_lock.slock, but tipc_poll() calls trace_tipc_sk_poll(...,
>TIPC_DUMP_ALL, ...) without holding either lock.
>
>That lets the poll trace path reach tipc_list_dump() and backlog head/tail
>dumping while another context dequeues and frees an skb, leaving the trace
>helper dereferencing a stale queue entry.
>
>Stop the unlocked poll trace site from requesting queue dumps. Other queue
>dump trace callsites keep their existing output under the locking they alr=
eady
>provide, while poll still emits the event itself without walking live queu=
e
>members from an unlocked context.
>
>Fixes: b4b9771bcbbd ("tipc: enable tracepoints in tipc")
>Cc: stable@vger.kernel.org
>Reported-by: Vega <vega@nebusec.ai>
>Assisted-by: Codex:gpt-5.4
>Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
>Signed-off-by: Ren Wei <enjou1224z@gmail.com>
>---
> net/tipc/socket.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>e564341e0216..a006fc98a9b8 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -795,7 +795,7 @@ static __poll_t tipc_poll(struct file *file, struct so=
cket
>*sock,
> 	__poll_t revents =3D 0;
>
> 	sock_poll_wait(file, sock, wait);
>-	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
>+	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_NONE, " ");
>
> 	if (sk->sk_shutdown & RCV_SHUTDOWN)
> 		revents |=3D EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
>--
>2.43.0

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
