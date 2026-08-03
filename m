Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC921CFEF;
	Mon,  3 Aug 2026 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723223; cv=fail; b=cz684vetEJP+tIbnemOyEGdjd9HYXKZ+5xcODMHRzvT3LO0ptIROZkKslbgDa9EBqUmUJNqb2smoI427e/fV0xtOkJJE9lPE81aHV6fPujUyIq3HJOgP5DNFW+Id6gTAcCThA4m37IeeS5mulJXrMbCHlXOowkjb/f8LfkBWwGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723223; c=relaxed/simple;
	bh=0mXfWxeZA0SeGy03LECaq+T7OTsEc9xkGtMRdGN0/zU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bPYXM5HXVKbyn7mGvL8I/UOwiTNG6ydyeZcxr6EaoSfH0A1T3Hi5kyJ3Rqgfa5Fa10IKeeGyqJZPvHHEE3MhESXpx8DVFw5IlvM/I03x7K/xri7cY86UkyRH7hacL8F93Unb51ti+B/12QlWys1SdcRB5kyJIM+gm/4nUZot8r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=w0+u0TMr; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="w0+u0TMr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGDn11ZacMnQVaTmmst0zQjK2gSIs1bl5JEhNMsIBSaZJ1zx9vlB9CIbdkJPoLma42hKvuJm056QJgHBfjeFscNDdCd3EqrulZ5ewYhcNfwyDqhiujDLRzIwi5g8fHwnPGvs69Qjw7kmViZqNNrtZOdm6Dgj0Mg4hTNsT4lHNF2CFKRqLGKDDa2D7cUvtV9ZI3N5hzfN55jlb3rY8VIM1I+Z1B0WbkFJ4hLhODfgg1sBbs5PFnf10MEacqePYgd6+aiwyihB4htMIjFF1iJvDU+aOHqzUfR205Xq61T8DM2RazAbKlo6MEbLh2tVYRFM/IpnMTzStIAsHQ/yiKHutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkITDzHsl0cEh+kZyitidnyH5Xahy2BgolxPxjT1Bjs=;
 b=NfjkgxIOL3mp2dWFGnxLLrLK32yplkH2DdNx7iIUPNWIU7cKYZ/HtSNIChhj3u+4GJ5mkAe8EY7i2t28LB/M3Y/JqfCd5kPZw7eOlXkA+Jrta2iXrRfI6WntBOjTFH985JCH49RhexvmN2JxzMjlCtnBhc9luY8N7gL5kmM1+8GHJRYO8l75vwWNhPfeOGpt9jw+j8QtS6teL4Zp3m70roKFbYxCu4jzdsyB3yNJOZrpe6mn3VuaQYK9kMA+kQEkuzikYYFUmWcJLOsRMG4vZGCBInf6vEyGt2Qrf4ljUrc4TXgIV3f1nW/yEuV6L+kx02PhSFIgdrflXyiGqqyi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkITDzHsl0cEh+kZyitidnyH5Xahy2BgolxPxjT1Bjs=;
 b=w0+u0TMrxKBl75pCHFm2biWYd2Oo+Oz64xLZ1mGlyt8raNMv/giIajcLg5qiKZe314S/b917JhrFOVAqy2V2t8kHTEM5xmFgu0gVuoZtjprGZwdTMTmOG3Bh8AYflatXCZhKCrt1JA6mH49zv84MMUHB9g7Yc/tXMZWgpxPO5iJ04KfDjlK3qvc79rxOyHmEkV8pkIYOh/gKhVVCPAiZ7mmQmOMB6u5Qudx44/eo/6h5GB61J63dZAbDySWFMvOzkX45PBOQZtT36CeQ8CLhUHe90C8u1RF1S1NmaAnXDeHvxpHs5mnv7h0Qmniwg14FNNmEoCMcCKuD8TFo4N+JDQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA1P189MB3652.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:504::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.13; Mon, 3 Aug 2026 02:13:39 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0292.012; Mon, 3 Aug 2026
 02:13:39 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jun Yang <juny24602@gmail.com>
CC: Jun Yang <junvyyang@tencent.com>, "stable@kernel.org" <stable@kernel.org>,
	TencentOS Corvus AI <corvus@tencent.com>, Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: purge cong_links under the socket lock in
 tipc_release()
Thread-Topic: [PATCH net] tipc: purge cong_links under the socket lock in
 tipc_release()
Thread-Index: AQHdINoXIkrjWyxEHEiOILfIgHLLNraLmSPQ
Date: Mon, 3 Aug 2026 02:13:39 +0000
Message-ID:
 <GV1P189MB1988C7E0BAE5936514CC689FC6D52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260731101926.31514-1-juny24602@gmail.com>
In-Reply-To: <20260731101926.31514-1-juny24602@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA1P189MB3652:EE_
x-ms-office365-filtering-correlation-id: 61bc25fb-b747-4ec4-5068-08def104d572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|11063799006|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info:
 v1b4KXeL3OfjQLrKdc7RKus1vSBuqjAZ1RQARlkOOOFT+8bj8yiJvY+FK7usL4QpTtT+mWm9iIHWcRMdbeg0SvbHU8YgS2ecJ7q1t7WWymnUV8ifH+mCjDnUIfvcxGl2RVs5LAQYtXcTxZx757g+YH0LWvXFy2jdtKmcMqhGfGfqGgDKYcfM6Bq1dZPEt8dI3SP5CrhYjr0hGR1b34hpGY9ncttlpEBv6Vnog5KNBkBhDKyuAOYlCUQLJ8RI0VrZ9KgMO1PvVsNQeNC5OYioNcccM5Q4Gp93gvJz1rGBQwapZ+P3NCtTehz9qGpnWNWP3LVogbE3kj7Yd6lNq048Jw/ibO81QwqxoGqecf0wDb7DTrUO5imrSjQRnRpveVVgT4nEC3ocBnunA/3MnSDKhy2OH05QxSjy+a/CUdX/8ITLcoMREfGSXwxed4blGkglDcqLXLpScOx6jgolaCX243U8ES5uTpDjV/jpBTyvdP18LSBhnBvqR3hzQjmBDR2CLVe+yVemVMxVYwJc6hLk8NPo9NMV8IfrvLjL/PUd0xCIzl7RW072RvFwb2soRetGTIMHEDmZYrXcPhpFiGZri/QhKRhzhibZurqIpdKB5WS0YgwPvNgZC48qFjmnaa7PSJjRukh/hItc7/FdgefmPCgtpB2qADhzBrpv5omthpfy1ES1ptVFD9gIMwBSCsQiebkkn61GIadpidJNjOF33i1Crr7XDOhhXP3cUV2jPCY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3pkZ9aG3x3q2jJUC2kd6jRCuk7/Crjp5MAbaH3HQ/cOhdVdRGaT+9J4RCRfC?=
 =?us-ascii?Q?Jb2lGtqaUv3f7tKvP8VOg1Ho0nec3+BMo3TiwZZXVes6r1K5z9RFKtSTVNXI?=
 =?us-ascii?Q?ptz2kQ15xQCJTmABzCEJPNrM5dkyNhzQow36Oa0GQo20NWu/YEojg7a5CnjK?=
 =?us-ascii?Q?U2+/je8iful2/RH48vPcAzsYTmV7ytrwivzT8hYSfGYd+woCDif8AkVSlhZY?=
 =?us-ascii?Q?d+t/SYiirxSP89KIksFSkppGKu6gE/X7WqRjFOj6bf158BCZw2auK+ewljpG?=
 =?us-ascii?Q?WIacv1FsORyfaFVCCerc34yaPMsmb1VlUCAFOf0j8PMPG8o6CvEyJWIqa+55?=
 =?us-ascii?Q?jgzRFdic2tT0JYLFKusx0B8yjAag4xfu9tbPVpKwM2JDPaWKAnPJVpGa988v?=
 =?us-ascii?Q?cDvYQQ9mrCE5UcPtbyK8OQhJl8jbe+cGPkSa2wcp34TMwwt47huBnzN0gSGJ?=
 =?us-ascii?Q?cdnQiuwqjgt71+2xQEGW8W4I2otznmM/35G4So8TcTFOMPBisKl7YHJfqtu6?=
 =?us-ascii?Q?t3Uwn5fXX/6MUi3kaktBO5QSnaqzIMWS3fSsb4IWWSI6Untf6B8JUfK0tALR?=
 =?us-ascii?Q?LeQHP7v6J1mmT6ob8lSxNFTsmvOk0DmEGUgSci2rY+ubBeTcDL/sodz4APpy?=
 =?us-ascii?Q?0BtJjebzzr25AUOsDfPUP4b24Rl6pAfbV4aKvTV+9shxzEGxvUVJUe5c0ir1?=
 =?us-ascii?Q?eK11D7W9Ndwfs6aJi2rAw2YuH6tGefi58aMJ8G85qAhQFhOzhai8htizfTj6?=
 =?us-ascii?Q?B4lXIaANT/oB4fqS9O6URuGJLYpuCXxJp8AFDY4m+UwB692oz2yR6a8kKPs8?=
 =?us-ascii?Q?J/dy2Ad1PsxhJusnYOD3cpuTmOzw8P4VK3kXA3KgHmwOCf70lDAAA2fzIV/c?=
 =?us-ascii?Q?b4LeqgGfjcdueCu5CgOA7kDI/YFZaUvoJ2TuLNDPxCd0uJic9ESY9auESUAw?=
 =?us-ascii?Q?1afh+5b1dyweIzpJ5KG5gIoieYmEBXTVJOGm1Kxd6SQGWRKU9e958FuFvIqr?=
 =?us-ascii?Q?wQRtgGsoBuW9uxc6rC6dpv+r/q4mqgAeyjwPeEr1jvNyMp6LSM6HwXMsi4Dr?=
 =?us-ascii?Q?BZpLO+m1DPG1zCEyWHkhYzYFTwuilek+nDaSMjWkj2kvRhRfocgthQs0f5CT?=
 =?us-ascii?Q?kUGuDcuTZp7HfL0InQ1L/MsfN1hQC0rCNp0keMClPHIzm/LwieHRckfU7MpC?=
 =?us-ascii?Q?Wh+Zdd+z2s4YmVedVK3XU29ravtyL87j3trFyx66mqEP8UuEDf9RNmhbf/9+?=
 =?us-ascii?Q?L7Lcv3TkvXbH4lI0b217nrCl+q1leIZ6cNQQpnhWTQ1CZWw7dp3DFATo/vPx?=
 =?us-ascii?Q?+c4ns6D/ElxO5uizv1zZN4LO8dmlb4HK5AMIDJ8R0o1JOXKkW/GmTKCv0132?=
 =?us-ascii?Q?pdyvWMQlZAjaJ7EAk5IZ2z/94DFag5h5jlS78VTYaX+7Llj2DQZDo2XY4H17?=
 =?us-ascii?Q?Xqnrff3DjMTH7NMaxAHDb4z5eO8Y9TJwYFtUFEjZ++rnKMivYmkaEBjdBe+K?=
 =?us-ascii?Q?1r0OIRdgejy2qjYH4PpmnqoV40hlqNhIvRojVO5mXhSfLdbgo4zxRZBN5TWh?=
 =?us-ascii?Q?TbM18nc+cl2d2SzMyfK3TOouM+csnzzGhhIprRkIxMbg4Wlmke4IlmHgVu77?=
 =?us-ascii?Q?kFqpbkXrjwo+iaFfUxJUPiYIgcdGLJCc+ltTXfz6SlnKtLHEIbI7WDsBpHVB?=
 =?us-ascii?Q?+pMya3NbX0M3Pn/0kWl40MbfRT2VUnga9i5UlpzFV3bnEpY2LEqY2D/HufG/?=
 =?us-ascii?Q?V+JHNb65hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bc25fb-b747-4ec4-5068-08def104d572
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 02:13:39.5894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isJDnwdiAJFs81sGHqT9PY3sAmu4HFvzTxuceCh5qQgxOcfncQHBHxGWddviDxMQdfzlqBZxolNoUCWaMAQ6QiBSYXSvPTw5J7mUhTRvF7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3652

>Subject: [PATCH net] tipc: purge cong_links under the socket lock in
>tipc_release()
>
>From: Jun Yang <junvyyang@tencent.com>
>
>tipc_release() frees the elements of tsk->cong_links after release_sock(),=
 i.e.
>with no lock held:
>
>	tipc_sk_remove(tsk);
>	sock_orphan(sk);
>	release_sock(sk);
>	tipc_dest_list_purge(&tsk->cong_links);	/* no lock */
>	tsk->cong_link_cnt =3D 0;
>
>Every other accessor of that list runs under the socket lock, including th=
e
>SOCK_WAKEUP handler in tipc_sk_proto_rcv(), which does tipc_dest_del(&tsk-
>>cong_links, ...) while holding only sk->sk_lock.slock via tipc_sk_rcv()'s
>spin_trylock_bh().  Because the purge never acquires that spinlock, it pro=
vides
>no mutual exclusion against the wakeup path.
>
>A SOCK_WAKEUP delivered for this port can therefore run concurrently with
>the purge: tipc_sk_rcv() looks the socket up and takes a reference before
>tipc_sk_remove() unhashes it, is then delayed past release_sock() so
>sock_owned_by_user() is false, its spin_trylock_bh() succeeds, and it list=
_del()s
>and kfree()s a struct tipc_dest that the closing task is walking at the sa=
me time.
>Both paths free entries of the same list.
>
>__tipc_shutdown() does not close this window: it waits on !tsk->cong_link_=
cnt
>but ignores the return value of tipc_wait_for_cond(), which returns early =
on
>timeout, on a pending signal, or on sk_err, so the close can proceed with
>cong_links still populated.
>
>  BUG: KASAN: slab-use-after-free in
>__list_del_entry_valid_or_report+0x1ce/0x280
>  Read of size 8 at addr ffff888105ddda88 by task poc_cong_race/7856
>   __list_del_entry_valid_or_report+0x1ce/0x280
>   tipc_dest_list_purge+0xad/0x240
>   tipc_release+0x9a5/0x1340
>  Allocated by task 7856:
>   tipc_dest_push+0x11c/0x2f0
>   __tipc_sendmsg+0x1443/0x17a0
>  Freed by task 7851:
>   tipc_dest_del+0x1ce/0x280
>   tipc_sk_filter_rcv+0x1da7/0x2e70
>   tipc_sk_rcv+0xdaa/0x1a80
>   tipc_udp_recv+0x42a/0x7e0

Please update the commit message with decoded stack trace (using linux/scri=
pts/decode_stacktrace.sh).

>  Oops: general protection fault ... Kernel panic - not syncing: Fatal exc=
eption
>
>Move the purge above release_sock() so it runs under the socket lock, the
>same discipline commit 844cf763fba6 ("tipc: make macro tipc_wait_for_cond(=
)
>smp safe") established for the wait condition.  A concurrent tipc_sk_rcv()=
 then
>either backlogs the wakeup because the socket is owned, or processes it
>against an already empty list, and no new delivery can arrive because
>tipc_sk_remove() has already unhashed the socket.
>
>Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link
>congestion")
>Cc: stable@kernel.org
>Reported-by: TencentOS Corvus AI <corvus@tencent.com>
>Signed-off-by: Jun Yang <junvyyang@tencent.com>
>---
> net/tipc/socket.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>d5d70eb230b5..9b45b16d0a31 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -647,11 +647,17 @@ static int tipc_release(struct socket *sock)
> 	sk_stop_timer(sk, &sk->sk_timer);
> 	tipc_sk_remove(tsk);
>
>+	/* Purge under the socket lock: a straggler SOCK_WAKEUP that looked
>the
>+	 * socket up before tipc_sk_remove() can still reach tipc_dest_del() on
>+	 * this list, and it only holds the socket spinlock.  Purging after
>+	 * release_sock() would race that list_del()/kfree().
>+	 */
>+	tipc_dest_list_purge(&tsk->cong_links);
>+	tsk->cong_link_cnt =3D 0;
>+
> 	sock_orphan(sk);
> 	/* Reject any messages that accumulated in backlog queue */
> 	release_sock(sk);
>-	tipc_dest_list_purge(&tsk->cong_links);
>-	tsk->cong_link_cnt =3D 0;
> 	call_rcu(&tsk->rcu, tipc_sk_callback);
> 	sock->sk =3D NULL;
>
>--
>2.55.0
>

