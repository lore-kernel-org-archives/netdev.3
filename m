Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023115.outbound.protection.outlook.com [52.101.72.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8353FA3C;
	Mon, 19 Oct 2026 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418187; cv=fail; b=Q0T9or7XWcC+Ccnm44JzUBUfHX5tkych3NUBTpas06PjsdQm7j7b5TrZd/XfB/YeIp8sg6ODBxbU05HzynJp8nqi2xsvnyuXpiRCth7XqI30lGMwULqKbjAokLNt6YuFrQ1LwJVX0TYu7fLx7b8SB/6gr2bGi/jLoBP04R4ruJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418187; c=relaxed/simple;
	bh=aB0fGfXUPsEaz7pwlVf4PiUEeTtafD2WdAAyC0jyz8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pFA1j8s8z3fD+BJB6KzSML/D3/NYRK6vEz7Erf5BNvOqeXAxU+DoWQaGzUVL2yDML4WFFSchiHjIkKZY6tiv4B+uYC4MLiXcKxCB0OBWyVwES7dzBhTRc+hw+rmpqS1Y3HBCmR5FNBIyWys+Oun678j5jxBZQnZfm+m7k+Zsp9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=visotia.com; spf=pass smtp.mailfrom=visotia.com; dkim=pass (2048-bit key) header.d=visotia.com header.i=@visotia.com header.b=jAWl1Air; arc=fail smtp.client-ip=52.101.72.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=visotia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=visotia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=visotia.com header.i=@visotia.com header.b="jAWl1Air"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqIXVqr1aqHRSuuy5oCn731gAxw/6ulQy5nBnKwmTMMDdXSaLv8nyssgET0c+jtnNcZfqPNfbi8oWNQhnuXcSsMKLmEYW0WpDF8h0b5rOoXvAc/nIVJDZ1iiwyU5NlH1qZJNatmyap0lG19yN2PDMmP3cm6jfqnPeG42xOMkE63AcQgFI3DGRRndeEPXYsGneBsfWOnVkgp9JAd681bksgjEAgtKJTbo/FxRAVMW6Lg5zRHv7SMPDf6eZjIcxIZSpZSZeINesQwLe3tnj3UuW0nE7U3pGONSe5R4bj9uCA4yiB/qvi1YuoQYJHZhQQ7BV3E7+vkYq5WeR8i8vWNtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttAz85wy1Fw/iowNlbSJsmYLKSFScOUNS6aE5pAI2+I=;
 b=hufkDeCUfBAPKeexhAyF6q4YllHNNImW0n7JUz7HPKSAFwdIRGEJF5njyr1zfAs5iO/a5q5HTOXRfzpTEZyf57ItcFQPVFNFenByzZGAulFw16oDW/o2ydAK18yZnoS4sqCdw8aMwIFR7cNhjOD8bWw1Y/+rjRUDtQZ9i2hggUBPu7k07f8VTCjYTiIhepIdNHADCXv/wsK7vSPGGMBlNKCjZWyvnkuysSbaf/ApN3dH/VtGbKFhe5wQOyzQqRgecGqRHe9SY9zfii04u6LQLzknhQ+jVof+ViqKzUBeVRUZVOu6qAQskxoySWzulo55Jc4DGnhUaAoZPlN9ls2Z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=visotia.com; dmarc=pass action=none header.from=visotia.com;
 dkim=pass header.d=visotia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=visotia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttAz85wy1Fw/iowNlbSJsmYLKSFScOUNS6aE5pAI2+I=;
 b=jAWl1AirlWDuCX707kqPAIuzoB+095PoG5utsn0biL6gKOibckQJrWOVHNMiAIO5xY3hogjQ+8b5HTEZSJBP08Eq9Rv7+puAza30WwYELKS2VNy+rFKBhPfqx/lqbRmXNM0ik9KeR45Phvk68GeR2GtKOf8oZltm/NiVmaGASRbhAb5j82+Tudj9JUKd9RbNifd978VvQnA++jnaUjwgbgBIbOidS/cZvPZIkfzzj7iGVx24NaTP7Mc6xgYOJc23oLO68zzwnjtZ0WATCHDBMItAXBeAETOQZLxVmPCXLKef/qc+7OmsR5TO08TSxUtyLl+7IT02+UCHeHAo/u0mBQ==
Received: from PRAP189MB1850.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:27b::14)
 by DBBP189MB1258.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:56:20 +0000
Received: from PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
 ([fe80::5cce:ff09:8d2f:9cad]) by PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
 ([fe80::5cce:ff09:8d2f:9cad%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:56:20 +0000
From: Mikkel Eskildsen <mke@visotia.com>
To: Oliver Neukum <oneukum@suse.com>, Breno Leitao <leitao@debian.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: [BUG] cdc_ncm: soft lockup with netconsole over an AX88179B dock
Thread-Topic: [BUG] cdc_ncm: soft lockup with netconsole over an AX88179B dock
Thread-Index: AQHdX9CKh0EMeyYVbkas70+IWBbMn7cE45LV
Date: Mon, 19 Oct 2026 13:56:20 +0000
Message-ID:
 <PRAP189MB18502BDD2D1D59FDD6E602DEA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
References:
 <PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
In-Reply-To:
 <PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-DK
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=visotia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1850:EE_|DBBP189MB1258:EE_
x-ms-office365-filtering-correlation-id: 5d9abad5-5956-4861-2dcc-08df2de8c105
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|10067099003|18002099003|22082099003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 O9rYA2S9N9jsURDbfvy3kuzbvGosW6xlTB8F+Bui2E2OYdoJiM1Q3H+EzWrPkkR3Gp5WM8InQS11LJqK9Y1UFONWZJcMg+DnTFmw78g7Mh/UlOZfakvxLMArsC5rCjJtqcqg23mswLFGw7LB7Zt0+R7K64vHdLJ60XRVZI+oRiEDZ9+bExPB1OfuN31ia/V0THQIzAiTa67/PXB2bwcr0AXVo5dZy10XA2ghmxs0bqI7hP/CUq9PBnqa+FqTmHvPzEV1/Kps/pWI5lJDdsrmy6KHykPmxZJc3pL4y0sw3fBW7hp53kd7AIAhY2c6Imn3DY8j8jgWoY7wRBQVenRam3eUcPkd2ZqZ17NbtlCsA2QP1Xi6vlAlCQX0Olf+i5JihD4DTHSV8vH/Hl/nZq87d99npx9RmqZ4gLzgab2VCuvFhXTwqqNxDxLIkgP2Ev+udXxxuZu74Jvu3CMwUakuY2LQQr1ual0CmDMSXHZGY60/0nxQl5kzb8tBLvov1cAYu8wtlX6IbqVji4u0rnV0VtSSc29ftNC7/qcRd8mYEUqnIYw2kTl7kesADqK8aDKd9VeNYJIcjwo6AmhsIiusIblilNdiQYPlse2u80yH1iY6OY4IF77KA/pZM2wD5jwL4YcIDiyBsmB9EQwbLZn/48vcLk1WO5fdK6i6hO3Ya0ItK3+3+j5VVJQ/6r2mO8FrlU8ykjSiVJGL0AC/q4Kt63V1BmBb6C3P7lyOAnd5E1U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1850.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(10067099003)(18002099003)(22082099003)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3BefCOcTXZonHqBOuXLoslHHxiF69RLZeQL/WHYH1LB/MDEQVg0XFFoW8FsS?=
 =?us-ascii?Q?04PS8HYUeGfWbBBVugjetQeUgNp0fhOZQL682YGq261wpIg9tUUh2E9VY7j4?=
 =?us-ascii?Q?+rfial01f3JVerqCqOUQorHwCggF01ZcKNQLyJBKsiM9YspYO33HXzQXTNiW?=
 =?us-ascii?Q?DawyzIfuI/PUY0x1LQkt99YkHummhYdyHWg+qq9YT1XTFmV/H721/v7W+vtr?=
 =?us-ascii?Q?0nJS/SkpAs2yZMLP1o5E6+EaCsKMu/GeJV1p+zgGiKUEgaOwQfCnt5nGuYvm?=
 =?us-ascii?Q?zNL4CFT3bRkvfLXjhFxaAAw2saF5DA2x/Vt4kreEg2w5ToEHN7q/++g7PS92?=
 =?us-ascii?Q?hjm9j/2z+LBkHRc3hHDEeEo/w34emji5dgpQOLugzj8+c4rzv5I4OqFJpy58?=
 =?us-ascii?Q?wEHj96ZL4tHC0FK4s1vWr/Wvx3B/WTmucoeRLso9rpfAHCcI9/sRvjakOfdV?=
 =?us-ascii?Q?EPu9TDMxH7NPjNuT5KHB8sfMMnJXVyl9wKmNzckcn5C8yyBr3vOqziptOhF7?=
 =?us-ascii?Q?8jSh5b+4EyJSXsa1Fpi7BcWpLHfpM5KhINNP3t4z0+2pCWiew/RKGr61/7eM?=
 =?us-ascii?Q?jy9+8Mznhriz8SJHEfQs4qXgfX5ZDddkSJpEJ2fo2tziUc8h0Y0JbIkdMKxT?=
 =?us-ascii?Q?Lp9SsI8QPxmVjIpYPS7JQg+uJvyzQhLZGIjWw4LVGosxzz4qW+XHtWXW5J/c?=
 =?us-ascii?Q?siOFo3UDkUHJrp1v14EYEC4L9svrB5ZaT8kcWEQ9BKjqTnkncxwERPeAtaan?=
 =?us-ascii?Q?6V49LFzTUg5f9KeDk2vGB3GkpBzZHRR/gXQtqpLPOqanql4h9WyC2M5pqHn2?=
 =?us-ascii?Q?Ry39zE9vHfxtTbfJ8/ssgfkUQqv4KIbinIdYwAgic1n5HTtBZOZKL90i/wci?=
 =?us-ascii?Q?mdh8ldIMW9fmD3CyaIooc4XWoPmLJ1TpH6/B75I29eV7XIVI0sScR7CUL3JW?=
 =?us-ascii?Q?/FV2HxsLCUSuDnOoeQcjSqquGEcM9hpxoJGFZuJTukQwQNxdnqsaVnxYUmAq?=
 =?us-ascii?Q?m+D3sMVMP8KFhJgWu46xcmhYf1dVVf9Yg8lnEGaKZEjIUOGSOi2SubhSUaaA?=
 =?us-ascii?Q?Z0mFA1qW4DB6U3WzO6QKIScOo7kmQSvhwSMaoQe7yHTG0pCKsQW5nh9UrH/6?=
 =?us-ascii?Q?dChwjJS2bX4wSyapzJSpw0ln4rN64iob64Ag3oOvce6giTlTjKfs33OAvAY1?=
 =?us-ascii?Q?aU0W6XblFHV3h3uKQfeTLOastV7NBi02NULaSzStCHcc3HNhiCSeNvjBx27V?=
 =?us-ascii?Q?tbeJZ32trNatiKcruLUO34eqLcHmM2to5MyHkYrwhAxOaNiqmBaQuk7Dwu04?=
 =?us-ascii?Q?bJ7i7BWl5rMVylROM50YPOrfskX44LdH1gfbywz/4o6F6fC0dAgpUgDd88ue?=
 =?us-ascii?Q?Z7Bm/Msbmc6shlHBuZ+84UoAoVWgQfxfTSKx5/DfYBjWcHJvC76/LTFfdf5B?=
 =?us-ascii?Q?l7OBJOdAMrifF2mUMYSaaan14gWGAFujX7sCFvT9C3ZGH+627KT6gJWs1+qV?=
 =?us-ascii?Q?a7qVj7EUAFIKOe4o6MTo9q5nuMrPAHeyDeCnOoTrncAJvW/NYK/+yPO+1D6j?=
 =?us-ascii?Q?a1PyPe5vjMnnUhco/8uaGw0fa4yn6Gzuch7uf9azlUInkXnLwa7i8hnMKWij?=
 =?us-ascii?Q?KG4j/0eR+pgR5cMcxGWkVWIqpqVWbWS/1AIu1aqcUxit+Zm1VFnR19rj6uCn?=
 =?us-ascii?Q?aA1oqMF4XYbNjpAHFzIBDB90qRWdRpSb3KoUIV+PXfWZ8Lq9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: visotia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9abad5-5956-4861-2dcc-08df2de8c105
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 13:56:20.3168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0398e9f1-d93e-448d-9e92-963c448c9a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+1r0q2qN2hb2CRkzb6SgO5xreMYBSMUA3OeYgRtMNUu4CM4lR6cKmcvbm4nL6xK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1258

One more thing about the first panic on 2026-10-16. pstore had a second rec=
ord I missed.=0A=
=0A=
It is a hard lockup. A process creating a new netns spins with IRQs off on =
the lock in netconsole_netdev_event. My guess is that the stuck netconsole =
thread holds it, but that part of the log is lost. The other CPUs in that p=
anic wait in flush_tlb_mm_range and lock_sock_nested.=0A=
=0A=
The W taint is an unrelated page allocation warning from kswapd three days =
earlier.=0A=
=0A=
[611145.298500] Kernel panic - not syncing: Hard LOCKUP=0A=
[611145.298502] CPU: 9 UID: 1000 PID: 9088 Comm: forkserver Tainted: G     =
   W  OE       7.2.9-1-cachyos #1 PREEMPT(full)  458eaf81e04e4bc0eb2f59b851=
34c9935c8c6b28=0A=
[611145.298504] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODUL=
E=0A=
[611145.298504] Hardware name: LENOVO 83KJ/LNVNB161216, BIOS QECN29WW 04/16=
/2026=0A=
[611145.298505] Call Trace:=0A=
[611145.298507]  <NMI>=0A=
[611145.298507]  vpanic+0x202/0x450=0A=
[611145.298509]  panic+0x4f/0x50=0A=
[611145.298512]  ? nbcon_kthreads_wake+0x2a/0xa0=0A=
[611145.298514]  nmi_panic+0x3c/0x60=0A=
[611145.298518]  watchdog_hardlockup_check+0x261/0x290=0A=
[611145.298521]  __perf_event_overflow+0x220/0x380=0A=
[611145.298524]  intel_pmu_handle_irq+0x2d7/0x850=0A=
[611145.298529]  ? native_queued_spin_lock_slowpath+0x57/0x260=0A=
[611145.298531]  perf_event_nmi_handler+0x33/0x60=0A=
[611145.298533]  nmi_handle+0x69/0x180=0A=
[611145.298535]  ? native_queued_spin_lock_slowpath+0x57/0x260=0A=
[611145.298537]  ? native_queued_spin_lock_slowpath+0x57/0x260=0A=
[611145.298539]  default_do_nmi+0x36/0x110=0A=
[611145.298541]  exc_nmi+0x186/0x1c0=0A=
[611145.298542]  end_repeat_nmi+0xf/0x53=0A=
[611145.298544] RIP: 0010:native_queued_spin_lock_slowpath+0x57/0x260=0A=
[611145.298546] Code: 0f ba 2f 08 0f 92 c0 89 c2 c1 e2 08 b9 ff 00 ff ff 23=
 0f 09 ca 81 fa 00 01 00 00 73 5a 85 c9 74 0e 66 90 80 3f 00 74 07 f3 90 <8=
0> 3f 00 75 f9 66 c7 07 01 00 65 48 ff 05 1f 51 1c 02 5b 41 5e 41=0A=
[611145.298547] RSP: 0000:ffffd3913890f8f0 EFLAGS: 00000002=0A=
[611145.298548] RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000=
000001=0A=
[611145.298548] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffffc2=
842370=0A=
[611145.298549] RBP: ffff8ad1f76eb000 R08: ffff8ad1fb21a600 R09: 0000000000=
000000=0A=
[611145.298549] R10: 0000000000001008 R11: ffffffffc26c6e30 R12: ffff8ad68b=
438280=0A=
[611145.298550] R13: fffffffffffffff4 R14: 0000000000000005 R15: ffffffffc2=
84e668=0A=
[611145.298558]  ? __pfx_netconsole_netdev_event+0x10/0x10 [netconsole 3dd9=
ae90ed093db9d831cffd8ca5dea61ecdd887]=0A=
[611145.298565]  ? native_queued_spin_lock_slowpath+0x57/0x260=0A=
[611145.298567]  ? native_queued_spin_lock_slowpath+0x57/0x260=0A=
[611145.298568]  </NMI>=0A=
[611145.298569]  <TASK>=0A=
[611145.298569]  _raw_spin_lock_irqsave+0x3e/0x50=0A=
[611145.298571]  netconsole_netdev_event+0x4e/0x3c0 [netconsole 3dd9ae90ed0=
93db9d831cffd8ca5dea61ecdd887]=0A=
[611145.298574]  raw_notifier_call_chain+0x3f/0x70=0A=
[611145.298576]  register_netdevice+0x94e/0xb60=0A=
[611145.298578]  register_netdev+0x31/0x50=0A=
[611145.298578]  loopback_net_init+0x4d/0xa0=0A=
[611145.298580]  ops_init+0x70/0x170=0A=
[611145.298582]  setup_net+0x88/0xc0=0A=
[611145.298583]  copy_net_ns+0x21d/0x390=0A=
[611145.298585]  create_new_namespaces+0x1a6/0x250=0A=
[611145.298587]  copy_namespaces+0xc6/0x110=0A=
[611145.298589]  copy_process+0xe3d/0x1d40=0A=
[611145.298591]  kernel_clone+0xb3/0x370=0A=
[611145.298593]  __x64_sys_clone+0x94/0xc0=0A=
[611145.298594]  do_syscall_64+0xa6/0x3e0=0A=
[611145.298596]  ? do_syscall_64+0xe4/0x3e0=0A=
[611145.298598]  ? handle_mm_fault+0x2ed/0x750=0A=
[611145.298600]  ? do_user_addr_fault+0x255/0x4c0=0A=
[611145.298602]  ? do_syscall_64+0xe4/0x3e0=0A=
[611145.298604]  ? do_syscall_64+0x65/0x3e0=0A=
[611145.298605]  entry_SYSCALL_64_after_hwframe+0x76/0x7e=0A=
[611145.298606] RIP: 0033:0x7f09df54ed46=0A=
[611145.298610] Code: 85 ff 74 3e 48 83 e6 f0 74 38 48 89 4e f8 48 83 ee 10=
 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0f 05 <4=
8> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8 3c 00 00 00=0A=
[611145.298611] RSP: 002b:00007ffd08d00408 EFLAGS: 00000206 ORIG_RAX: 00000=
00000000038=0A=
[611145.298612] RAX: ffffffffffffffda RBX: 0000000058000011 RCX: 00007f09df=
54ed46=0A=
[611145.298612] RDX: 0000000000000000 RSI: 00007ffd08d01400 RDI: 0000000058=
000011=0A=
[611145.298613] RBP: 00000000000003e8 R08: 00007f09df22ea30 R09: 00007f09df=
22ea30=0A=
[611145.298613] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffd08=
d018f8=0A=
[611145.298614] R13: 7fffffffffffffff R14: 00000000000003e8 R15: 00007ffd08=
d018b0=0A=
[611145.298615]  </TASK>=0A=
[611145.298668] Kernel Offset: 0x1d200000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)=0A=
=0A=
Mikkel=0A=
