Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793705031;
	b=qPzfkeT0R6hwzrjDGrXLKl1f+sHy9xWh7Aa8ZN5poZWj2IqVVLVU7EFLZ739/TVkke2t
	 I82G7rGyMUjq9eNfJ91tlWEOSGYXAsvRRUUVqSpKD+hA8GCrYFuSguHmjDawJCdolwYSq
	 0X/Mzw8diLboEEZ3C7po9MqHP+BCuOOF3EUQd1uxV7l62C1btHQLs/Ky9FciExw5NkUB2
	 DYWkCo6tCsWjVBHe02MNEJqyR587KQ52umc+a5g5cQSyyLPTUtJCSbqtyp51HLALmxb6K
	 oB9XTeWY0/P4SZDEobykyBpNJgYU8u5/NhGbbk1aHwcye97ntULMoV4BqObXJ/VXndg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705031;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=mq464/chbq1qB8kf6eKS4vDD7zKhIOzCRBOIjpJG+nI=;
	b=Kvl2/6eZmeJmGsrAnHaK/nm/nYc3MsM9MCR4D10iTFieSIAyGhj+En1RA0BcHvWttW/5
	 QV2/jzmy7R026qVwRYcIM4lNIFPYUCBoxlpl03Hs7hzNWaW1SySTNzQ1WYRpwk7lMuJ0+
	 lk5dJUsovziV/UZCMzOppFYeWbfZnhh7MX/guca6g0x+VTNi1+xfSPGFAELk1EzCfwCKE
	 jABiVzDxZMscagkQ9Inq/IfIihiRI0zSXiMpHnCBAIypngpl7AGFE/xir3kZQu0FeA02E
	 dXiKvtPlzjnHC1waSFzjdVdN1gz3+LENxaalXqGx8m8pIPktQVuLDq+gcxI7OWx1j9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Et86I+AQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FD606C59A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E37FD606C59A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Et86I+AQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793705030; x=1825241030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xcrdBXCAp76DLbUs/5Yqk8mqfgQA09cXU+5bGCtUWf4=;
  b=Et86I+AQZ9DdkcdLPqtvQdy6PwpAfBNLWb8UNi3TjjJ01w47Hswn6wjZ
   jd8oI3HwVnOolES49aGjvlVcN6ha+KPKsT59PAQsJN2pzJT4VwnyaBsLn
   eCOGuqgNxHD7kIBn/ZCNOgHfoDlBfxxtmb4QKbHS5bs3wxrUYQdj3RIk1
   Co43gf1QxEBiDBzZ9R0faZxdKDoKPt7D11UCvmLj3DPioMN6utQa/8sDj
   irFM1wDo0IGnzH68pXudmHtY4EhEBf2DYaDpmWt4lsBZPuBUEmvormmt1
   e0GEpq3rMUckvKzjgRN6wvcOejoeOc7AMoDcupOsZ1z/lX95oAvTtEFSr
   A==;
X-CSE-ConnectionGUID: MQlMwEVuQ3+z2iPN88QF9A==
X-CSE-MsgGUID: hSGVVAVpR4WUuTr8yI31dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2304457"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2304457"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:23:49 -0800
X-CSE-ConnectionGUID: DlwBcvGeRFmoUj5c/jBdKQ==
X-CSE-MsgGUID: MNf5+NSFSViradZTiGyjnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6287399"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:23:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 03:23:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 03:23:48 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 03:23:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0nJ7hZ4H9UWJMLbbFB/RLQcDjuryZbvafQBfp04R67wuhVPDnX80RUEIJ2bEp02/Le6BLdbsc7aBRT2lvRc5uyoOl53BlvcS66v25jHecFwFGJ/wVY35ROXkqt25U4Ra8kfxsBHWu9QOScARd1B8vyYxhuQ+JNH5tLXIlPnm6zHQc7hzrrS41TOwzU0+lL3D0vG860+feUXIdy5C8NtzvLshm0AB9TMayQIsrK+hMEj0KJNF1/gSu/A59A38K6nBlB1mEkxZvP5VBPhND9YntkMZopdHSHxRhcivQ5NyuMExs9DxP6jUfRNJHvMDogTnxPRBdZ1Lscx+YmGPw7u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq464/chbq1qB8kf6eKS4vDD7zKhIOzCRBOIjpJG+nI=;
 b=MdxsjzLWcJihRLEdYlIjx/kOgmAQ74RBja4kRgyW7S1FvteWB9twtpmavx1l5iOW36qwmAogzZNc3+sJ2P48ctbT8PI/iNvuTzYuCQgVfESOnymd9GWMg59jCmVM4mQeOgw/hLMKxWmJmc9OEYDzKohmUHsqSOXM1acKJehZVnoHkTMjFtB62VPo/hdj1RwIjOLcULLnJX0etu1V+FqB/vql9pQKvtXi9n1/zOzVER1tISMslBqLXLw1+2Zi2icIl50axUDNL/b2zGo4MMjZOC9HruCGt8X4+SoQH1SE1zFFN+1dGRMjl6nvonj5PYtMW9vkDpLTiTtiUunoOxCICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:23:40 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 11:23:39 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Sashiko <sashiko-bot@kernel.org>
Subject: RE: [PATCH iwl-net 6/6] ice: register LAG event handler last in
 ice_init_lag()
Thread-Topic: [PATCH iwl-net 6/6] ice: register LAG event handler last in
 ice_init_lag()
Thread-Index: AQHdareSG1g1X14YQEWhrC18BpsNJLccNUIg
Date: Tue, 3 Nov 2026 11:23:39 +0000
Message-ID: <CH3PR11MB566895166EFE8B499CA2AA74AFE5692@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
 <20261102105346.30739-7-przemyslaw.kitszel@intel.com>
In-Reply-To: <20261102105346.30739-7-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA2PR11MB5035:EE_
x-ms-office365-filtering-correlation-id: dfdd0658-0ced-4d2b-5476-08df399ce8d7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|261026121527099003|261021123027099003|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003|261102123227099003;
x-microsoft-antispam-message-info: R4PSQznRJyUBa7OAL5UocRq7ldHZRxpfACgYbIijAmIubzC0ILZuTluzLSwGoer9h9xJac0AXcwBSk01p13fjK/GoJShzPmNZJHBzYjh7s9Mmgc6uEhstFMb7rdcD/6xIOJwGSoUMGi6wn/i0CezMsU61cY7cr7MTzdljyeZF3oHhgPIlmHLjwQk6WBkgX01+wis20JQhK6W8bX2z9cAcbkt+57eXuPjAk5b6EB8d5scjjLO+J+H1lohl+WC9o6B9J/6mtAhvNemLvF9zGhS85Te26cF1HR4fCXwFtxcN8mVkEg5hwxkFH/M9HlvKjx1xx4yz4PthMwbuBaC+bkg7ZnAUe3A0wxJd6Atucdegh8E3wGz+vmkglxLVqIse6Lw+8HJEE5fTdazRP6fyjLbGzi/7rwqoSgPT1ApbPzYetlfTw+xE52m7C4cTY+s4VCBVf2cwoVeuVc5ShUjLMYkjwgq4rwOX7CYSdxzGmK8g5DgjK5YrDXZm2ITjQFoN1RjrGyjoS9f4YNMZScDsEKBTxQ1eaWZE1SLSoDQvtBu4/Z61gKteXABIfBW1StO07iBNORNsap0JMISIVM8BEy8knhWkX8LwEj98rFdCkoYAIp6jQ+v2skDMFo3mNxU7jO0F0Zi8fI+7aQ3CPhJ8E8lTjgOffybDfSfxPRIZdTKmOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(261026121527099003)(261021123027099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(261102123227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JSk1ywq85SbDkQlDONlHGx/ywgyul1nciMvb9fubHnVQHZZVe3Ic2RFnBaS4?=
 =?us-ascii?Q?0jqIsgC/jDzSz00NAkhxUAgOKcMyMYtgFgH8/eup4GOQSSNY4Oo7LnCdV9QG?=
 =?us-ascii?Q?a68jejPbQLcjBlX2dOBExeQW6gntKY7zk4VNv4sZWdfGmfbWDcB4vNpwvFV1?=
 =?us-ascii?Q?GOMy7o70yJ9DoDyE2zicg1tYEzXZinQfhjT6YAggveKQd6RUypeQu2z/eCrq?=
 =?us-ascii?Q?zFsd2k15i88bI3yQxhCuRMNO1We3xpnHmA+WLg2JvfRxJvsn9kvtH8sGhstK?=
 =?us-ascii?Q?Gzksr5U3BRGryQPPCtFcEcByB4MWjn4p+p8R8hn+IoNVhubntwj8OzCs4xKO?=
 =?us-ascii?Q?YjylWDPMQBk4Q6bgUjAZlOhZJR128/pwtJpY+YEWiWXP1zHA0y+ZtBu20AbU?=
 =?us-ascii?Q?SPtQJ/DrMSckna/6F2xmAEE3fHHxIB3AEEG7bjFBKvvwaI7mGFCnPaBnYCIv?=
 =?us-ascii?Q?QifhjHoJXUJyQwXgFYOs+0FtJ4LKBxuxHfn2upQeiHlkgC20+DQv9eldXBMc?=
 =?us-ascii?Q?9dLmDtMeS+pMfqwPoNKiqjaxeaC2EGD+3/ulfUGNR9c4bXSZeZpVHF/aPrA2?=
 =?us-ascii?Q?so6KheXGw/ycsfEl9vNqQIoz5m3LH7BcJYaMqjGI2m34FCTOz0B2BK9ZJ2jc?=
 =?us-ascii?Q?NcRdwV/b4KRaLFDlRBDSxZt1ywHFUr5546q53EM/Z3aCdYg2m/6/VRGbdoZI?=
 =?us-ascii?Q?dy50LV8qEQHuxgUFwrLHQbp1NGs+qOccweHYRL+PoS+ja5IDgXZCYWGNF9Oq?=
 =?us-ascii?Q?90+X9LyDMuz+AbjxxH1SXYgrmIedkPZiSCES8mhN9h7W1YTAZQt5K49vtO6J?=
 =?us-ascii?Q?wnt40dx9IFddysFwwu5MahvcIAxn6oavPupxJicind3XYBPFofAlZ3eNaRw4?=
 =?us-ascii?Q?ZUBkwwjC08HyjVz6rcDaVtjvRR2kg54J/sy77KHvqfh2TIAbiRordoV1Wzaw?=
 =?us-ascii?Q?4p67tNtU5W7U0RpfWtfVm1MMU7OZvewvgU7LkAwRcvlo+Tpncxr3so1Yw65V?=
 =?us-ascii?Q?bSWQigqXBkHbqvlD2AE+j1ZPOOD/2xxYb6Lripll9tK0eKqR1BSSAkAQGBN3?=
 =?us-ascii?Q?R4+lgvZYYgw/4M1ht8dx//mtCOIhnEtIaJCszPIV73j3ue5eE2L4F1egdjP6?=
 =?us-ascii?Q?RSJWo3bQXBmlqbBWOL6a39evmmzFuZISKcricgjP9P+GNro34J4Cmd3gARba?=
 =?us-ascii?Q?weVzFAl8DcTSLi5WlKyL+szpbAyJZ/6ya0W8KKJJv2rv9pbawjyQzfWetrwr?=
 =?us-ascii?Q?5naHLJ0gwGsTyZPBOgAfHgr+kFWx2W1WXvZd3401KxKNhsQ0/iuClbTIIM0o?=
 =?us-ascii?Q?Ke0HQr/xMOmCtYvuuQFJITGKimqEYO4a38/MlLqjqPE4n9y37ircs3dpQC0K?=
 =?us-ascii?Q?5Y6y0AtFfgF6TOaNIThaJPVN8H9CmROCFWex+UprL/cAkcJi75U0lzv7WfHB?=
 =?us-ascii?Q?zJMUPbWW3jI/gSF3vNg/Ki1Wsbrr6vi6pBnHBQnGWSEq3k2yVjasNBlY38X6?=
 =?us-ascii?Q?e6etJphLQbzPzBOn4amp1Hf1iEUjO2a/B3A+1nuha+/LQIVc+0L1JGGixmx7?=
 =?us-ascii?Q?DFrZ6x7q2J4xmFV331UbShpGfZWbE/dvt+Hr+MNaOD3u+/kzrcV9luObPQoO?=
 =?us-ascii?Q?hfz+5M5ddXbfRgPYAoK3wymRTgLBQ13uuv4DbrZGJli4U7P+5OLbmtT6EbSm?=
 =?us-ascii?Q?T/DQlomdUuN0Hn6bAxlZ4gRdlmRCCNvDxmtQE7PWF/6BGvKQn8YElK5RKIhh?=
 =?us-ascii?Q?K9qABc7Jnw7ZPMvpqlkHaZFCUR1IlHI=3D?=
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
X-Exchange-RoutingPolicyChecked: wuTlen3bQhCkCrOT0+wMR5oISPqFP/1fWK1Uj0VhOYOR7x+c8s4DJ5zUoygMf/r+F+rnPCbyZKUhrbITBajROmIfTobZS2HpVC4iUCz7TkmPr5i7lZut64+LthI8DKLsdbKa0XDf4O4SRtYuKR4kOO+CeBMmX3TEENYd90QyWreqIcBSzy0cOLS4IR8BRML9LBtwGiTstm1cDfHEk+6+4UlK7fIwTn11eB8QackIh2V0s/yjTAu86ZPYja26LPmT5aO0Topuwd/tQ16/k/DR60sz2FSwvhmYEsOuMZOSvrxkmbnOJ445eN9lB87cbMYxAlOGitvcNlEHrYDBtl5ZjA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd0658-0ced-4d2b-5476-08df399ce8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 11:23:39.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hT03oQgS16zruvPMu8Ji5dMSoF0tJTm/5LUZJzTwhBzdnaifCAgfe5E+tPDXNUZ5TmTvXpBTfbV4+pakJzF7SHmRPI9o7hwcOtY68DHYCbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Sent: Monday, November 2, 2026 11:50 AM
> To: intel-wired-lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Sashiko <sashiko-bot@kernel.org>
> Subject: [PATCH iwl-net 6/6] ice: register LAG event handler last in
> ice_init_lag()
>=20
> ice_init_lag() registers the netdevice notifier before it creates the
> LAG recipes, but when creating any of them fails, the error path frees
> the lag struct without unregistering the notifier. A failure of
> ice_init_lag() is not fatal to probe, and pf->lag is set to NULL, so
> ice_deinit_lag() won't unregister it later either. The next netdev event
> then makes
> ice_lag_event_handler() use the freed lag struct.
>=20
> Register the notifier last, after the recipes are created and associated
> with the profiles, so the error paths have no handler, nor queued work
> for it, that could use the lag struct or its recipes. Free the recipes
> if the registration itself fails.
>=20
> Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event
> handler")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-e0559bca-fcfd-4435-96f2-
> 15f7e3d74184
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
> b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 08a17ded0ad5..c4b8af01e2af 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -2601,12 +2601,6 @@ int ice_init_lag(struct ice_pf *pf)
>  	lag->notif_block.notifier_call =3D NULL;
>  	memset(lag->sec_vf, 0, sizeof(lag->sec_vf));
>=20
> -	err =3D ice_register_lag_handler(lag);
> -	if (err) {
> -		dev_warn(dev, "INIT LAG: Failed to register event
> handler\n");
> -		goto lag_error;
> -	}
> -
>  	err =3D ice_create_lag_recipe(&pf->hw, &lag->pf_recipe,
>  				    ice_dflt_vsi_rcp, 1);
I'm afraid act_act_recipe is allocated but never released on the normal tea=
rdown path.
See ice_deinit_lag() it has just kfree(lag);=20


...


