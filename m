Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29239CD00;
	Mon, 10 Aug 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351792; cv=fail; b=bTS8H04IZAXwIWEBERPsPpwuNVGswnz6wbi8lN5NG1M+5acHDRf38hIDyljLzu5Tc5J9Ozy1GzBi0ryyCeHbf/3HcRbdp3ZeTeBqJnzuLRQfDx/t8l4dvvZKq91DwH/CCV9BVbWL3xooIm/NylRTuvhGjvlM+t/34YNUqN3/3aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351792; c=relaxed/simple;
	bh=8QywPMY1RtSD59TGgGEbiyy+WC61q4j6JT28+AbFtrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hH1WVQRCoBdqAmY2rzYaqmVzQTx403gA5GP7UMn65UJofi6W722ctV9+t5r4xXJz+VbQD69RIGMP+biwj+2HcbTXeaWxBcul9qEZCBT6+/KL/H8jPReFbjVMYNXXo7q/avW5/5i32AVdCKpUcDuAbz4ttLENu1Xi0JK+guj741c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iu8rIPeI; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iu8rIPeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786351788; x=1817887788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8QywPMY1RtSD59TGgGEbiyy+WC61q4j6JT28+AbFtrw=;
  b=iu8rIPeICLIefQSQ3rDsFd2dXVPpad3fjf/imwhOUlCMYITWJT3VRzIO
   aqTKjAxTc6MoYtzk3i49C7bQ7d8jkmv4X0runfFnn2MbL2ElsHXqWqvia
   Y9KHhpZI6gmRbrahiYlbkFlI8lXg3/ZAhiVW2e4hfk9rLYkMQzzwtuElJ
   zzd2W6KcVwFvRyrFEJFtJGdFP4wL0mUF3+wiEkEkn3n19QmyIjPkCssra
   m5PhFwqMYV5y8krThy8ncLjjka2DfRmQNDQSNGVuyrF51MH6YH6RTbqk0
   LvKBeBrcTlQt70GxvEePP3kpAwB1QMTJmAzbWvg873tlY0PC6Y4/3Apca
   A==;
X-CSE-ConnectionGUID: V66tQ4FESrWlPvRwzGS2Tg==
X-CSE-MsgGUID: 9eetqERIQ8ugTQ0IGWAWqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98219822"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="98219822"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:49:46 -0700
X-CSE-ConnectionGUID: SaH/pe+ZTNevgY/FPmufWA==
X-CSE-MsgGUID: 4fF+ytS1QU+8tQhIKgwMdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="268141212"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:49:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:49:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 01:49:46 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUL5SJIBrk7TpEVJr1anwE3fj5Fq2Md1UbJoHHgMzxoOe9pAPaF7ESlM48CDD+j/dx0tuBK3m3LsCZuvRNovrSd2hQmd6bQDWtRQxaPIIA8iuDtUS0skWpVEJRkbGZ14ntSsMXEkemeiXxyHeyqSfTv18fFkIbx/ByeogCDTKxpTeKGR5HBhIZW2PzMZTHg75BTFLyyddyFcZckEuLw5iAHkC4sUPlPbyw9cHWJoQ8HqlddcvAx45fhiZRkMc33xN7kVvP+tO6g3JB1NjuRD/vJ4/gg0puhsRmrBzF/8PXmNL6AepUsbDKUMpbZaetBqWnfCJE4a1QDdg+dz2EXuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK6HdogWyom0afaJx5//p0HB+sEIHQs9ZJ3L4vRgvRo=;
 b=QiiJadKBONM7G7Zu+z931ynF5dFnhGtXl8bx9G4nNTxq2YKViEW9DQGKUwh1otwRDrOCo4+DO9aVMiMupZlqaH2C1Pl7Wk/IZilgdbok3O33uY9WIqn4HyoudNqDrs3Gl+sxh7NOFjHFq8GTgXGvpBdGNeXtiQy3dJIGnLzIjFa7BeQIABP4I8ByuvoyIqsR10WQIRTZbloQ5qlhNeER+QegcEwKwtgrSYOMcN124Upkhi/g5OBmndGrCrGokx28fAfBB/Ux9NTAFvFA+uS0FP5wR/M4jHWDslkoN77Q9GI7f+qXncC19F9ihna0KNKxcpt4jR6svHCgK/LMLsCojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by DM4PR11MB6381.namprd11.prod.outlook.com
 (2603:10b6:8:bd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:49:42 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f%6]) with mapi id 15.21.0270.017; Mon, 10 Aug 2026
 08:49:42 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "pavankumaryalagada@gmail.com" <pavankumaryalagada@gmail.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com"
	<syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-bounds in
 e100_eeprom_load()
Thread-Topic: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-bounds
 in e100_eeprom_load()
Thread-Index: AQHdKKMcK2tN4yEvR0Gq+sQBoCf5FbaW9loA
Date: Mon, 10 Aug 2026 08:49:42 +0000
Message-ID: <DS4PPF7551E65529B793FF5258AF910943FE5DE2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260810083355.21631-1-pavankumaryalagada@gmail.com>
In-Reply-To: <20260810083355.21631-1-pavankumaryalagada@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|DM4PR11MB6381:EE_
x-ms-office365-filtering-correlation-id: 3e6894e8-44d1-4467-49cd-08def6bc51ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info: Nim/oYi+gvNlo/kHCrEmoqtG0KZdUDFhEwVnpUXEfVFlLHkaWa2ruIRX9K8PkMfC7t7y/gOuTKOgx2b2wDrHhT5ZFNJo9M4UlBxCLr2hHDLN8WbzcMdpz9at6akxRsDXTi9daYlYg0dI7G7ziQJbcKJ+CLrZzYVK5HTkEDIa/Ie/6tIETUgZ2vnkzqiVqmkd/Oe/9nuYThdfmm64fFFxr+52DJ8KXDR4wfjk217Yuoj9i4uITfAo7DzJE3fEnttQvYaBSggg/fdHyZIPkq6yq8emNWHRi9FMDNtSuH9FFR1hhVlAiXVmSR4RjUwcjaY5g+rAVrrCM9CMA3Fw4ck3sTLq86Qw+1AHgJ72ciT5MkNLb32gGR2QGhLpo0aEB9oIjshiXsQ0ZjIeDY/wi8sZQ0tVJGq6NdCUhTg/+Nh+po3MJvVG0Aua/A5h68phJBLxJsEIxbZYv9i6wQTB5i9HPgKpcdL6FO3wdyJ3vw47B3D76Wt17dbZT8za48V3YG6RkN8tj8WkV0Lf6LTCBHP08Sn9NjEWonF2rNQ2BEz/W3CbFbCPaE3j5YhpePAL/WbwZzMrOs6iZ+91PTzfd8fiThPprAqfaIzsy6HI+V7vQdDJP2iNHEPBsOw1WdpCpU862xqJLiIMlDT0YivP+FVKjQqjeLQ8hIRLeT0sqp3i40K7WmOA0Vit5Gng8qNfsgr1aAnKVdYCDEAZIDRu/i0X6f7NTzyhlaw45TVoFL7AqIs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I0+aey44/s6ikayXNnevr4mRHNoGx4exWr8vZWFn5yiUiYxv7JcFOXBM2R8/?=
 =?us-ascii?Q?585smjsYhaN4zCUh0FrVWsSi39z+ZI+cj5f6D5CzyBkU1AL8lmWTRlz3uUyF?=
 =?us-ascii?Q?9SNqio7/c51TytTttT8/gsNw88+bKRaVb0/6TaAjhiFYmOl97g2KLL8AYmtj?=
 =?us-ascii?Q?2QTk2PRZ7lbKEjv33B3jCv57DCjPh28YHomwwwpQa4jc73vxd5J501f0sNIp?=
 =?us-ascii?Q?CVl4bld9tQ1NUw5z7a+qitrC4f27rpgoiBrc9WqVU3La99MHwJ19ymnpkaxa?=
 =?us-ascii?Q?0puMIRazOpvNClDSNyHqxvee/hgjc2BSfqcp2aqN/IqSTrYiYkt+r2JIfM8C?=
 =?us-ascii?Q?tk1wrhCGhQrEDqXDPNf4Y39HeFoq/CtomAZT7xJ/SPwH8ntHEnFVApdconPe?=
 =?us-ascii?Q?gkkcpQQVdbGa1EvgciZrqDC4pJOE18VIvMkRYHq6m0vcc6/ofWodUkYvBlMh?=
 =?us-ascii?Q?/xD+enY3A8+I0EPl9F+PJtW3laWSQ5bTXk5sW/SoMZ6ZvxGX2ETujvt1AtaV?=
 =?us-ascii?Q?N3ZX0KNHHLv4i3A5/M2AoIo+t3t8g0cJPZb8XZT3Irc4y2Czf/eASqXDj40c?=
 =?us-ascii?Q?0bMU023B90vOC5qcoPhdTcxpsdR2zNZGb/rra+Dr2s5QvemIxu/SzQInZek7?=
 =?us-ascii?Q?TRbbEnTv0mpDz6vrm373jvqObrCaqNVtpANHV3SSuVUskfKegknH4d+pubxh?=
 =?us-ascii?Q?LxM3cnrQmsBBfXQppXcKppfXQrJM7s5d2yV3wLOuLDTvbWY1HKAfhbl7Vqbz?=
 =?us-ascii?Q?IGPTi+jhcvSuJWghbki59xDhVpOSv3dSNYcaElXkpHiOL/YBAtThoHkIjcri?=
 =?us-ascii?Q?mdRefigNOWeCWriiVhcCg2UZtQxfZ/Qx/mGEb9JDYqBhz+kyTL+vqF0HeqJv?=
 =?us-ascii?Q?0C6gBKnGUUN9KjdEQertM+nQeOtoEIV7CwJoZA0ZBG9Kk/Zf27cvQUc6jAAw?=
 =?us-ascii?Q?cOBf6tpjIC5AcCti+9QR2qFKbN7cxaWHN2mfyDoO7CHGh2oLGnGXzx0mZs2s?=
 =?us-ascii?Q?J7eosFMqv84oyf3I/uO/fJ5Q9wGkG9vUtxDNbtfWl9TthynoEZ/0SCPU/o/z?=
 =?us-ascii?Q?FcFePqMvVP6+n/SVAcwq0qvS3DbYhZZv1KnAfH8r8Bg6Cr8jiK/FWSLBxzxv?=
 =?us-ascii?Q?2FLK3Bc1ocMmZB+x0rQ+qotFqw2/293JOgNVTLKydBFB6uruNQRpNU5NVsuh?=
 =?us-ascii?Q?tLLEJf8v+5UOOlPBnfM5+XvsNdbBcG+XKokAvXLcTTyrQ8w/XvmAMlDuZ4zS?=
 =?us-ascii?Q?DakTfyxY55NDAF7nhghjHE/oCDYthIkLsXHWwhkf++y8L2hmeJyo4hVDZRBg?=
 =?us-ascii?Q?4y9I0NF0hUmhPoenWGdpxAjuqLVBmTsoqp3l/N5A5IXlpiDepL2Mlx15viCB?=
 =?us-ascii?Q?U15PNNeibvP+SHMBufeQgvAemBwEWAFujW+bsSY/R0ZdHOHpzQ5qnLtgsiAr?=
 =?us-ascii?Q?AmljvGzHH1C3Wlvb8a/MR0P5HB3bLqtf/RsghaA4xFjwoW4xKBN9oEeVcuTb?=
 =?us-ascii?Q?9jXCX8nvtwJqXWez4odoMbuk7rkD+SFLGdAFhV9CqooKwQe+w7OSI35ndBmR?=
 =?us-ascii?Q?YWZKioYod9sgj3dihF36gECHfsUnYhgTpr4NVBz6knS3R+a+4cbfCc2YqfOU?=
 =?us-ascii?Q?xRzr/s0WI4FoVvHkL9zrz82lu6SDVdR8yeEjSirLKEmnxxUOuc1w4y+cEUgk?=
 =?us-ascii?Q?Ln7Wrw9ZMIfGzhmRmVO+p7dKDnkdmGRMexDydxROVuiS+gsQJ0z5n6qbziXv?=
 =?us-ascii?Q?EYMfhwDsTrlvXuh5joePILfXjzWtTwQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MkFmxCNHchAepKendLqW/n6GeY7ijNww3wdcq3XsTaCGoqoYhvPRAXVw69m1E9Yllx329lQywSB8dEjkHqcg9xobb08YfFfv0x7GuDTJZzoeCQ41ru0V7xio/XjR2ev0kEaro6AqRz1ikZx6mGw+pDOEFM70+u0IZKxBa6VYl7nHUAJgUuloaq0o7OyL0qnYo7d8mPETat61a2iFjK4djFwu9xk1/thyaPo8gK//OdUQtD2+JJFxb98Y3DSoTkgD7K+y4zDySGJ9/aejRTe9m3/NnUxYeWbgcAHTVg/EuHpBOzJL95jPWl20H+AZx2sXfQIwlOAzxAm1NT0HlfcfhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6894e8-44d1-4467-49cd-08def6bc51ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 08:49:42.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlj//4iSzEV9oP2sgSOu1vnJvwk51+OwdUVDdV9zO9UArMstMg96KDzdwPRTJ4bU/iyhw+Y4qU3KDFijx3HdyGvrYg8uO9lYwm1lHhL65Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6381
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of pavankumaryalagada@gmail.com
> Sent: Monday, August 10, 2026 10:34 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> skhan@linuxfoundation.org;
> syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com; Yalagada Pavan
> Kumar <pavankumaryalagada@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-
> bounds in e100_eeprom_load()
>=20
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
>=20
> When reading the EEPROM address length, e100_eeprom_read() can return
> an invalid length (0 or >=3D 16). Passing an invalid addr_len to bit-
> shift operations causes a shift out-of-bounds, triggering a kernel
> panic or UBSAN warning.
>=20
> Validate addr_len after reading it from EEPROM in both
> e100_eeprom_load() and e100_eeprom_save(), and return -EIO if the
> value is out of bounds.
>=20
> Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De0abb1d45ac291ebebeb
> Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> ---
> Tested in QEMU using syzbot c reproducer.
>=20
> v2:
> - Return -EIO instead of -EINVAL for an invalid EEPROM address length.
> - Validate addr_len in e100_eeprom_save() as well.
> - Drop the unnecessary 1U change in the shift.
> - Update the commit message.
>=20
> v1:
> https://lore.kernel.org/all/20260807145626.52692-1-
> pavankumaryalagada@gmail.com/T/
> ---
>  drivers/net/ethernet/intel/e100.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e100.c
> b/drivers/net/ethernet/intel/e100.c
> index 1de5cd41ea0c..464dc2d6cdb5 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -775,10 +775,10 @@ static int e100_eeprom_load(struct nic *nic)
>  		netif_err(nic, probe, nic->netdev,
>  			"Invalid EEPROM address length %u\n",
>  			addr_len);
> -		return -EINVAL;
> +		return -EIO;
>  	}
>=20
> -	nic->eeprom_wc =3D 1U << addr_len;
> +	nic->eeprom_wc =3D 1 << addr_len;
Why do you drop U suffix? For me it looks like you trade one warning for an=
other.
I'm for explicit (u16)BIT(addr_len), what do you think?


>=20
>  	for (addr =3D 0; addr < nic->eeprom_wc; addr++) {
>  		nic->eeprom[addr] =3D e100_eeprom_read(nic, &addr_len,
> addr); @@ -804,6 +804,14 @@ static int e100_eeprom_save(struct nic
> *nic, u16 start, u16 count)
>=20
>  	/* Try reading with an 8-bit addr len to discover actual addr
> len */
>  	e100_eeprom_read(nic, &addr_len, 0);
> +
> +	if (!addr_len || addr_len >=3D 16) {
> +		netif_err(nic, probe, nic->netdev,
> +			"Invalid EEPROM address length %u\n",
> +			addr_len);
> +		return -EIO;
> +	}
> +
>  	nic->eeprom_wc =3D 1 << addr_len;
I'm for explicit (u16)BIT(addr_len) here too, what do you think?

>=20
>  	if (start + count >=3D nic->eeprom_wc)
> --
> 2.43.0

