Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE244A3EC;
	Wed,  9 Sep 2026 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941419; cv=fail; b=L0O10UIAsiKDiMVTmG4QCVPKyvjug5MBCEIjcBF2gIajL5sgOfM/3qTkLhQsuMKIxHqrsPHcZO4X3CQJjo3VUzUyx61Glr9tvqRzKd5yTiXFukC2qhKh9eRfWyF7eTXd0+itI5hInKZUCskCXu0tNwb9aG4mqYgc4JMYZhIZlew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941419; c=relaxed/simple;
	bh=rKUa69AmUvOWHcqcYmo3bRTpLpcd8N6P8vG9Bv2ge7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2k6vLKkk26sU5ywNw0FRkNydSXRLIqoXdI+dVliQ3ntRS+Eb9WurAeDVWdM8uPdVy3V+VBCDJXsY0++oXAkEVXIE6AMwPaGtzp/jfmVbJMoczJqcxEXSyUDPepoN0N98esSlclknbqpTRkkfFS7HFiaY20ou4RSCKvThLWePk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQ0Wu03Q; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQ0Wu03Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788941417; x=1820477417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rKUa69AmUvOWHcqcYmo3bRTpLpcd8N6P8vG9Bv2ge7g=;
  b=CQ0Wu03QEc1QVXtzfXE1U0ulHM2lSQ5q+mSLqvdIdMwOadfOHMgcMy88
   KBnmAMXLzF1M+12jW5kbcVAwKPULDiwoFJUdkLR0fNGIP8DV463EsSEFS
   e7o+QAr8MhIr2ziFzZCrk/9d5QUjjfwJ4jUJjXL0Y1qNIQAxQIRUAF8fc
   zkqy52XzvnJSsYC1jlwadrAEM+BWfAtx6WAu1oGU8uu9zhx/xDFNBVMKD
   IaT2+m+a2u9j7F2PKIu7mq8xkaAkV5UPvfyCjviR6TsIofxvGxxlz1MOT
   Qil54RbndN3+ZAzAxZ02mZFu/vIcrARqkaqb/4uhOH/l3GMqM+uJ4epQn
   Q==;
X-CSE-ConnectionGUID: 1eq/nSZhSP+EzdkqWO1QSw==
X-CSE-MsgGUID: s/hbUm56Sl2afSHjAKJ7DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="114901627"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="114901627"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:10:16 -0700
X-CSE-ConnectionGUID: U9t5995NSdCRRkjq1OKhKQ==
X-CSE-MsgGUID: hWAyzQaURGGk4YZISLr/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="267991672"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:10:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 01:10:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 01:10:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 01:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6uvtAzvYZRPFbPFUvuYuCZN2iS1tdAYyFkv3PZKt/fhdYlBmLPy2H/LEYVkmlRAdUHlRp3lcbYjDnVXeDPYP6H1y+dIy3KMHfoUGTS8DSoFG3MtlNH5vijgTTmv+39jDdVTIAQg9RCYu97GDEZenkzUVnjiXFXix4oByBmYezlPSPlDK7KuJKABrpwgnQ7BBEfLAYb0FBj9EPZzTW9SGOZP1YdJfSbNwV/kj7kMguYLIjQ4EWcqJsHMa0QcKLRf5rEuNOQTrKNl49q2RwXU1m+yMkV4ENeGF/81X0a+vMhk5wg4H85DSlIxNORQZWicySfitX+4fu6+VE0rECrSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if0foLFhHYVuXRsUN+3aDrwwVtMdJ5dguaRKbC48EFk=;
 b=R8q0acMAzBooSyG+3BbK7c4mr6N3orPpuAOB8oIyOr7VZIqrlTYwoo7Vlw9iPMTLFcxnOS6yGM138w59gnu9cLh8LKD+fyafgrQ/pqnQVoMSdGKTsBnpoZnwpr7mtlKQsdMb2oA3FemiSJbv8INJ7wnbY+XH+CrQjLGnVT9HQboOk59r68Tr8qOQ3PuqO6YJFp9E/xV3fZ87A0kZc0/FWukuJMWPb9s01d6A9SaYzToMoR2xcBA4Z6jsWlLYn+Oc7vTj74oPm0Vj/VNgwiBlfdW7tkdUvraZyURyQLYnsUvkWl14GkARQ+b2RFlFHJEs8x9ldL70QuFNCaG6PD+c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 08:09:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 08:09:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
	<PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Thread-Topic: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Thread-Index: AQHdPxOOZVYU8Wsvxk++P9pUHXqKb7bEqJ7w
Date: Wed, 9 Sep 2026 08:09:55 +0000
Message-ID: <IA3PR11MB8986EA1B0F14E13E92DB0FA7E5B02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-8-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW5PR11MB5882:EE_
x-ms-office365-filtering-correlation-id: de1c4ef3-37d0-43a9-54e5-08df0e49bc04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|4143699003|11063799006|56012099006|3023799007|38070700021|10067099003|921020|22082099003|18002099003;
x-microsoft-antispam-message-info: mV8p+fQBG0S8FQLzN/9tP5jLmrbxj47x3nhQfJ/OINLZaODCg01/IAMLN4Oe7F1/HtC0h0VAAROtGjATJxJQNZOalPOayeuoACUv5Fra3EQbKaveDgvElV81kMF0imh3rvdFrIqS7J3Wrt/nSXDh8aysJmAOZ1rap/kOpOhW9Elnp/PIVv9XuF9TOTXl7iltRuPHph57kpVfNqA9sKA8LmjNGCFaLLjpbuhOCt5Q+O+GPqY66NSrkH1Bk8AfEFjOLtn/bsg77JGZ2TBPC7StGzw8cmvWJQMM3GwOfP9Y0ZmtB/cRXrQEdX+VnhYzrgZnZjECrTlUhsBWJTRVhlbCNyagL3g/mU94oDhJgsgJg5lq9sY5CfQ6SJII5XNgu/CfZBfnoSmxlMZdI8SOZcj3U/JqeN79xr6MIoicf6I54/XxIEV/A4Tr6tGdFOyiFOcgrvBQbDSf0J4p3HT71wLIQFebAdBnFfqbrcNd3paFOQl6nZDYQv0IWGXckjn7NtJQgunp4Fe2An2fCREfFow/wq+qSj9S1/NP6h/cIEUdLO86AYAXljjO2SZLNVhnMQ76uiCeQQk87AT4CCCWXuWT+39FaEPoMNWU//P7UNBTzLmBhO3Y1OwF5W7ZiMqfxTYyW2qrIX1Z5MlcCR371vIKuhOhQyJv1WElUyE0+RPCquB/FJ7r8hrq/k9rh6P9iZ6/BafNOIn0xvIsGVdIoCeA8fxPLmiXnclvzlkEKX95zKKvz4waZvvBcRIVqYvmQteU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(3023799007)(38070700021)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UQ0e0r+ghiGhpxAcTo7UTPMZGCzGy4zepWya4axD3GfRit7vCDpdEC1x4Ty9?=
 =?us-ascii?Q?Gpqrv8Yp8ALdP6CeKSxNLylLOg5gVB0AzejgafnfxM5CWZmSlgBYcs0Bwiqj?=
 =?us-ascii?Q?5a6MFVBKQ4vHMPvPIvz0peUoIRg2txlbSCUpPPcBoRH6QC3T1sjw8ijlCFP5?=
 =?us-ascii?Q?peOGGoZGfxgq8TZzml4WJChyQG7hxN9uB2Mhd4cOLw1pkqLTmzc1TtZ9eCC1?=
 =?us-ascii?Q?pm3Jb9mGvmRiODSHuGdUyubDbyg2hPajQ8TJjUJqb4abC+xxxe0yMKD6oJvc?=
 =?us-ascii?Q?4F2DoM9KdRE2Ncs88hHmgmzKVhfH1s5K9eh4cllE+sj6i5Pvhe0xDzMw8Rxx?=
 =?us-ascii?Q?9LrvDcLj0ymyhCnMHet/fLtmzLUI68r5v/sOXgWLsgRkqLOs/9Qb1DXdaVCv?=
 =?us-ascii?Q?obS9jhE7tfeAbwkzPNVBRdblqZb0V6qXemzCFa1GKokFHKf0FDEd5UO2WyCi?=
 =?us-ascii?Q?tfplF8sFsHIpcfFb06vdReFjqrTFJJjB+ZrU2JdUd+Kc3CPbFs9YX+Vmlo7X?=
 =?us-ascii?Q?oO/h5mxCDpXtgXyrmYTQ4o385DyEVynycEs5271RbTi3tzgDQIpfmPefU8Qt?=
 =?us-ascii?Q?SuhzRDQQhCQ6+VzzXsF82PSJUjPqOcppOXIBVvmXZiZTNt+Uo8ToocoAkWmi?=
 =?us-ascii?Q?SyT94MYYD1h4NfE9mx1fsVe9fQf7fhEkPIHhzSfILw0gYTz1qKWMllPySvwg?=
 =?us-ascii?Q?aruZf3IJyhB2pgwEk+VXQ2bvN+eQF4wWqVGUhftk8o/IoK6PLeFsBHS9XCSq?=
 =?us-ascii?Q?NtKdWZIiLhMucZ2yNQEJmEZpSnMyGz2RQQdESnDCblucncsqjt3WIqb0dTWu?=
 =?us-ascii?Q?M2d7TPXFzW4qf+SBh0iDVIIF1r4EMVzqWcyPOEzGTdtw7dmVlyv26JZKClZt?=
 =?us-ascii?Q?YgQkke1Ue+/gem8cogxS+4LW+1vqyWD2TPSOui01ZkUPQBTnAJXgdBgoKcGg?=
 =?us-ascii?Q?rRUqlx6IeJMcjB4/PB9npSFOdRY+gvBEa5BldM49c8jJJ/xUlN71oyLxIz+B?=
 =?us-ascii?Q?bPXQiNuImcAboKNEJ0RxjASn9oScGF6eZJn8gPG7CZXBcSSGCu5KxSczzKEL?=
 =?us-ascii?Q?fH/ZQ/ktsaYojMADbFrc0FLxQCvw22EIu7yxYTRnpo+JMg4/hY8mBVi5Lali?=
 =?us-ascii?Q?zyKDvjGRdOwp4oRQEU7EBvwYSif8sjYw7vMA7YbtzyUuT42AjWP2ujmLQnZ6?=
 =?us-ascii?Q?kI/5jUfkY8Ek9oey2AqVZcXFe7kfUAC4xQKK7Z/dKTuydpPa6T+pL2J9uVy1?=
 =?us-ascii?Q?qnJ6rlEXxjGFXnXSwsdmoC1l4+3TvLDUFEEkN8eFx2y+ySfdiU8J9hQ4If7u?=
 =?us-ascii?Q?OyCLEEn+uBeS/pEmppkMYAkCQszERhjdL3Q0FFD1GavjAgY7w0+ET+tgiuch?=
 =?us-ascii?Q?KYbPZoHrN/qwLoCW1buX0EFIp2ya2IlG2PAzr1bLb/nC29C8jhkHGBOYb9Gy?=
 =?us-ascii?Q?f4KaUDuSuKWInI0ETygQD4B7c1xRX3IX/EYxSmwybq+QLLWih/iUS6rllTuk?=
 =?us-ascii?Q?vIY1v4vaplbdXB4v3jtVd2twNHSlF1vOQOdDvxfH4jyIRDFfggjjSVw6875w?=
 =?us-ascii?Q?xGjk0dmCboeoAP+49WFyCSpP5PEHOUegafhSssy26RZZexStKzTWcb2wTODv?=
 =?us-ascii?Q?pI/zw6bAeB2pCIp1CDEK0jLOjRib2HzkuJ8yhee2NRVEmVL3+pdN1gDtjCPE?=
 =?us-ascii?Q?CpHyKVJA46OnAE3C0SQXEXWtT67yJqSS8M79h25BgiVXxFDUf9WzovckKiVD?=
 =?us-ascii?Q?8BbRxTaEXbr+K1AHun8ypAjFxZBueC0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h6uj1Ti6mYBEXVFnNXMV8U1j3qnoyD+qbFfpfqAQABSA9u1/VgJXzOwQdHJtsV0nJS/IZc2XMoVZg1c4/zq35lb/wJ/XS8b6Q1hDm6nfe+TauzOIRRInwHGxRJ+wAyWRzCB3VaXTqAEbKgyiQ3MkKTCJ6p18njFsWXCuP962uQQP3uKiclV8FOZMGUmSisFRq4+w+NaxRmMLIGoojrJsnXLEhVDe93U1XmPQBPBrUgfy0bNeH98KofTBGba6SCIgnbpkOaMXDDPxe+64d7XQ1Z5usjDCumv42RGhdrAuh7WlGbM5nvgLguD1uuJpgZ2oAMLWOhGUZFgYWRSUB5OU4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1c4ef3-37d0-43a9-54e5-08df0e49bc04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 08:09:55.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kO2FeNU3P07IsnW0EhLurYe1crMeGrrL5iGrrGEmUMhon8Aj5wm8zsg2/zcj5DNCxonO7kni9OfFt8m6Nksb0xqnHBIeLSE0zRxMgX6eAhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju
> Rangoju <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>;
> Jijie Shao <shaojijie@huawei.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton
> <akpm@linux-foundation.org>
> Subject: [PATCH 7/9] net: phy: use linkmode operation return values in
> phy_device.c
>=20
> Use the return value of linkmode_and() where the resulting mask was
> previously scanned for emptiness. In phy_probe(), combine the AND and
> AND-NOT operations and use the return value of linkmode_and_andnot().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/phy/phy_device.c | 14 ++++++--------
>  include/linux/linkmode.h     |  9 +++++++++
>  2 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/phy/phy_device.c
> b/drivers/net/phy/phy_device.c index 94b2e85e00a3..3430605695c5 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1565,8 +1565,7 @@ static int phy_sfp_module_insert(void *upstream,
> const struct sfp_eeprom_id *id)
>=20
>  	caps =3D sfp_get_module_caps(phydev->sfp_bus);
>=20
> -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> -	if (linkmode_empty(sfp_support)) {
> +	if (!linkmode_and(sfp_support, port->supported, caps-
> >link_modes)) {
>  		dev_err(&phydev->mdio.dev, "incompatible SFP module
> inserted, no common linkmode\n");
>  		return -EINVAL;
>  	}
> @@ -3761,15 +3760,14 @@ static int phy_probe(struct device *dev)
>  	/* Some PHYs may advertise, by default, not support EEE modes.
> So,
>  	 * we need to clean them. In addition remove all disabled EEE
> modes.
>  	 */
> -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> -		     phydev->advertising_eee);
> -	linkmode_andnot(phydev->advertising_eee, phydev-
> >advertising_eee,
> -			phydev->eee_disabled_modes);
> -
>  	/* There is no "enabled" flag. If PHY is advertising, assume it
> is
>  	 * kind of enabled.
>  	 */
> -	phydev->eee_cfg.eee_enabled =3D !linkmode_empty(phydev-
> >advertising_eee);
> +	phydev->eee_cfg.eee_enabled =3D
> +		linkmode_and_andnot(phydev->advertising_eee,
> +				    phydev->advertising_eee,
> +				    phydev->supported_eee,
> +				    phydev->eee_disabled_modes);
>=20
>  	/* Get master/slave strap overrides */
>  	of_set_phy_timing_role(phydev);
> diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h index
> c08632c10c3d..49587a2e0f69 100644
> --- a/include/linux/linkmode.h
> +++ b/include/linux/linkmode.h
> @@ -26,6 +26,15 @@ static inline bool linkmode_and(unsigned long *dst,
> const unsigned long *a,
>  	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
> }
>=20
> +static inline bool linkmode_and_andnot(unsigned long *dst,
> +				       const unsigned long *a,
> +				       const unsigned long *b,
> +				       const unsigned long *c)
> +{
> +	return bitmap_and_andnot(dst, a, b, c,
> +				 __ETHTOOL_LINK_MODE_MASK_NBITS);
> +}
> +
>  static inline void linkmode_or(unsigned long *dst, const unsigned
> long *a,
>  				const unsigned long *b)
>  {
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

