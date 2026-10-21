Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605066;
	b=yQPyY9jqNni8b0wBmhTsUHWgq0Mx+1KLN64JEXKzPBExjzfHS/IKIahkF9DtwwR7SB1w
	 eB5NnBEZOcAPHoUbxDFSf66hCFot92BEe44T7SpBNOAQWUuTw7mhMuMOdPXztdbGyLnTr
	 NVUEr5LM/4skMaWB2cnt1TciiJ5/EUVlXrQ7aZqZ+Xs46Q98+7XlU7mk4eBv4Vnslovwb
	 5NbxCRblcAFCG4aHHfXS4Qk8wpqsR8uiTdLvcn5nZOje6VU3UsIfWKWSMxhsaHomDAEMU
	 d5lQR7GfriGaabGbwcsyTgNPZc3hEm/nAmN+CNz3BONgNNR8YejFT/A8dRaN1ugp6TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605066;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	bh=D4hKL7mfu3IVjfU/KnyemlxdqwWo09ZbuVuCCivfUBM=;
	b=rps8Iw+jZLsRXBzIc8b/RbHADZvzCdvNSViw9EdX9dMO9gjE4wP1mF2EgDa/dxEEkBg9
	 UXCoN5pBgEbhVnIkKVYnk+rCKOEqTj1VrUGvwRhQOYit6KTJNqQfChMpq7N2ZgicKr1j3
	 RKuiwvKeeqjC7gB7Ou1crVSaLbA6114slaGelVeCQltF25SvldiRwlnMc7Shq/fvLSLCy
	 G0lpK8/9S1zQ3mRE+lcKWUE3TRYRpRtH+DWdzQRthce8qKVFtPCfsALnwLnGfj00ZXTqf
	 omR8s7DcARJvEY5E9Rh/kXADUjtPARaWAjc6OtxugjRuXBQb44Vo/LudT/CJB5FrQNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="IKK/D+WO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02B606A321
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D02B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IKK/D+WO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792605058; x=1824141058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7OflW9qn8xSrG0Wk+U/+TAtnrJmj3XuFXxD2wM4UvVc=;
  b=IKK/D+WOvDQf4tP+VV7DXRwhIwd6r8deXGz8n3UNo6HAbVvvIKPifI6X
   JEnPvLO9iHSNo7oZq0cs2MDl4LwLJ5BUnS6bBs++hQ01gCRLY5xgvpZaQ
   FlZAU6lwKoSc3Rba65PN5EaP4DUscqSpEgsftHdeGySHxfsI0A/3y+NXJ
   X6416ZHK8CzmTP7ET3JEa8b8KwRLYu9lb66aW7YQu9Q6fOWVooumPp2P4
   1S0JGDdGfwDcLtUY2lqkneRCRf2qsRr//p4gsP9lllSBReW/w56s9Hibb
   vExCD0dRACA+0E9syM23AQs3r66qYPM6Noph1ms4zGyVC/fhyiB8ZhjLm
   w==;
X-CSE-ConnectionGUID: PWATSsSiQdOD4uNF4VF9zQ==
X-CSE-MsgGUID: vGbHMO9uRNy5X9mRp5FtJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1236122"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1236122"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:50:58 -0700
X-CSE-ConnectionGUID: wGx1CmDVRLKLRIzW38hPEg==
X-CSE-MsgGUID: htCl84KaSc2aNb+R1ifjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3168742"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:50:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:50:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 10:50:57 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn00jimDLgfd5D22pBfToZyx59tLXdy2LD61xc1EI69db0I9KHq3hxM13lXdKaOROfLiC2i4NFfBqFetHlduqxc4qjqd8YliYiJuhPVT0J7W5QMac22t1lYuDATOA6ccGoZjwdWvQHILhu4anF6aCBq6rS3sG/BvRT2ObbMxebP2zPOqGEmaY/kb75zTWYr0myuZZKrVCNQAkWclfCm8eonteF7DMjyde+2L5tGCaKIO7n9e8sSj5PY4W5VC0SkYt7at8gx77ROQ1LbtyqmKfJiziw5rZcO4Nik7sbpepaJkQpGAJJ/4ZVK3oirrUpxeQDFMr4UYZbP/kyh9sntqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4hKL7mfu3IVjfU/KnyemlxdqwWo09ZbuVuCCivfUBM=;
 b=TBPGTR01j9R6yvbMnBubj1Iswv3p7a9tGd2n0lnBv3chFZdwbGYfrNNjkNfdgehOdsYkNPt3pqptXhBwrv3gtnsZlKK+K4S4qWp+VZxLU4b/DQmsjInwW8yif32CI7qTA0OITj4oEO3j4C8I9IZd+UfAaNzJpYUAzqInrf0KORz2vF6j3iBEhqLZVsPnxW+F2eFCbBG3zLi74x6HCZ4z2b+lITZLzk3vWbEPtrgl5qK2sm0s3VJUOWBtUrnxWjENQPs8/Ey2wg7eLZEbnSmuKL1+4DWgn02nJ4lFEk0oTItxEr+loT35vHxfYVy4PvqtrKHQLu8PmykcqUeM+zaYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7155.namprd11.prod.outlook.com (2603:10b6:a03:48d::6)
 by MN0PR11MB6182.namprd11.prod.outlook.com (2603:10b6:208:3c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 17:50:55 +0000
Received: from SJ0PR11MB7155.namprd11.prod.outlook.com
 ([fe80::a279:5eee:c8d:31c9]) by SJ0PR11MB7155.namprd11.prod.outlook.com
 ([fe80::a279:5eee:c8d:31c9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 17:50:55 +0000
From: "Arland, ArpanaX" <arpanax.arland@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
Thread-Index: AQHdKdW2SBGz7EDTSEyARBBvI0QYyLcItLWg
Date: Wed, 21 Oct 2026 17:50:55 +0000
Message-ID: <SJ0PR11MB715561344E744C0E2543994380662@SJ0PR11MB7155.namprd11.prod.outlook.com>
References: <20260811181127.1142095-1-david.m.ertman@intel.com>
In-Reply-To: <20260811181127.1142095-1-david.m.ertman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7155:EE_|MN0PR11MB6182:EE_
x-ms-office365-filtering-correlation-id: 519a2e0d-0d39-4e95-8c62-08df2f9bdb15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|261021123027099003|38070700021|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: K30/EhbZCFo1B/imAfSekv7q//ZJTfDv+MdLBTYyTf+qnb7AB7JV6/XrBjzYEuD11M0TLjQXmsZdSK1NttLEhHJUUUzE9Js+phiXt/EK8g+mGFLLxU/J9QH2yMACK/m0W8AxXYxnpbf7xMg/3j1wDmdfTcpDnLPLFJzWLY+j6oI9VgY0/78qRyJAb5drqkiQnibh6RwMEswJhUKCd53kgl3B7u8wZCJt/w0XAkw+3qk33s2Yg4zg9gWPIkSQOxgV5Xlg96VC28iOZ7Gu/+ilHRT0+OZsT+AGaYDG7U5v74QXUxHaXpIc46qOltWSBKiM2wBJ3Jp+vm5jytI4KwTdvg/YCbCNxvujEK6FpvokbL8m2hVsbUZYGhMxI/32nzTL/WIGtRYHdiDOqpzdSkLZVyHQdEU1ra7vQREV+Dkx+TFMCech3Lzo6YiV4h5WeHzhVASzFUts0c0CPXVjFZgtni8LCwskj9o3vR/6DvOxrFtLHB8HjphmdyXi63ksicGK+iEFZMU3zLtCU1ftOvTsaPwU2z7ndJk9Q1SlDSG4j3nw2lAM+uEdXwOlECGXCexFelKlNiLJ4C/EBAi04SGAw14iE6cUscGGK0RXUkuzqzHzDqGLi2LVEGCZ3GxLrkYAPlNp6o2y1yIjC/LLc5/PsGIdYIbEiW9M+GAKcw6Hd94NWB9L8IfWteAF44diSiLEI/46FKfQSP0CnjuoAHdRfdFi9KvIaR+GB+xBu1OjlQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7155.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261021123027099003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z0wkhT1NStwrKMxaiiOco8osohHFoAhZI4rfspoeTQPgJlwIqCzbGmQLD85O?=
 =?us-ascii?Q?g2Wyq7CbCHErsyiM5+3okCiGcw5weH2RMMQMlX/CJjtIg5YyBKM6wCZpA2d7?=
 =?us-ascii?Q?Yc5d90LmpyEC5kj/HYUCic2eUoLK+85kGS7d4SOYWCvTSagQg+xFF5hoAMFX?=
 =?us-ascii?Q?3fRALpjFfRCnAsMlIjO4mk+QV2KJqa6xO5iPl7bZmvpOshQwHcdqB4tzuKk2?=
 =?us-ascii?Q?/tojp9x8o8x4b7/3NiWa+G7wnk24CVpdrOQVZ1e21xVZ12iKKbkoriO/3fQh?=
 =?us-ascii?Q?y778UzPSx45q6/GT9tw/lC35It2OKxlYGo82gUb3ADyqtzvnlg03ls2iycqS?=
 =?us-ascii?Q?5BuvTNYfLauS+BzNympt9CHl3MCAx4ktAPyr/f82G9acuTZfJmDEN32YRdux?=
 =?us-ascii?Q?LsTGuZo8oHYcfgoROI8HzMmWfBB/ud2OfvJwbSnC+vwAZAcinCsT04WqxNfc?=
 =?us-ascii?Q?IccFPn5nMDhMD+RH06uu+J64MG4dUgvHp/zqf7OSPb1bE7asol4U4gqDiImJ?=
 =?us-ascii?Q?oEFu4jYq9EnT0MWreqB+b+J+N0Ety8+TSRHugsMqNE1m3tXz8vAVl0XbH7HU?=
 =?us-ascii?Q?1aB8j6Hww59uZSDx6FIBzbDNo+Y448Jw0ZV5BFebSzrkymgn6XDDSEXNF7Gu?=
 =?us-ascii?Q?4uuPE1jOQJcPg0Zgy4J1fyERFKntb+QUBGemvQWLIP13vhgAYlXFoJ8zFQcI?=
 =?us-ascii?Q?zkO109eHamQvE+q2AfNT3ZJzLe4PiW9tLbGZ2jLqci6V0t5XcwKiauWW+yrT?=
 =?us-ascii?Q?scunGrK75a8/HT+U34WLzTuOEcRbvPl7MpQkP4dDdwQMG+4CA7zdsFCxlhhr?=
 =?us-ascii?Q?jnJ17OJUl6HLbYbW1mcv1sA1XcnpcLkig6kMeMcYwZuosPlpiIyGKsezIjvk?=
 =?us-ascii?Q?0bYZqOJwLWZsHaREyxHiUjQf7DGzm4tTgSXJsxmpCtH95Rn0ZOxvyW/afKMc?=
 =?us-ascii?Q?M3n7nF+bBBLVCXPAuHJdbpjkW6YoWBzoT9javS8jy5MI2Q0OIB67a41+/Kxi?=
 =?us-ascii?Q?IHSlbaf73UZ6Yv4NRoXHo571r32Q+UWxjYBQIrTWH+MDNaFEctuZ1ycCLx7Z?=
 =?us-ascii?Q?x53sHd/S7MKMqD0lHIK0Jd0v1yt/ur8nZ7+hse1uSSpMSCH01vnR9vfMboyn?=
 =?us-ascii?Q?WLTcLhUbO9wZfLmFkFM96q1FP74LNdXKZbkbf7+Rll1JKFfCMoSnFbs/QAuw?=
 =?us-ascii?Q?KZ0Eln8cV4/llmjBvpjfcGRb4f1qUA/d2PCq1omwgC6k8oweYoF1h5uf069m?=
 =?us-ascii?Q?ZlwBet6ScO9eQRNxx4/ftbJV8DrwR2677T1yzADreqfcXPBTR4QSMoPqRvhP?=
 =?us-ascii?Q?Kng0CFT+wfK+cj9ER4ylIs7uzWXl8at19Ino8L/nfuNMJjswceiaRHQwp+I9?=
 =?us-ascii?Q?p4AUauilY13eoIMppzfmUT/dIjhoRaivZNHju7Pq8Zd9uK2a38zuy8ig38k4?=
 =?us-ascii?Q?EPjzjlJzmdPyevs2oq9oCW2+KCv8m6tm4veP6Nb4+Y3ytcvn9+z/rlhS+Heg?=
 =?us-ascii?Q?qsf37+fPGjlbY9QmqAq5kaBGhKaQ5TbMjcHBq9gll32SmBOKYTNEqpz3Ioif?=
 =?us-ascii?Q?YUwbVSj0mqVoU8WTihCOV8h3MkD4YBqFVfuMBdlWgUnLQBRgiVcU/kM4p3uF?=
 =?us-ascii?Q?8vfwi9VHJtMhwtRQKGElwgoo7xiHrLGvozdZtxRSx0t31h1UYnADg/ekZ139?=
 =?us-ascii?Q?2t+XHEu0ddwnVBrZeSBBdnAC/xciRnzJ+OTGuP5nRVEAsJpNrex5AbaR5JLf?=
 =?us-ascii?Q?OX7cdxhZ+g=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: lS82cotZW2J+YE9bWDUGDivMdteCPJiKK9vyR8D6aBJ2HRej5gBpNrz6ut9QGALt6Z+wKdUOfRCiM0kcM6LjpSDqjzpGnPHDor4Rfegt3c5wpljjfpd6ZpueDm3mBNLK/qcTqbQlwhdEAJZGoXsbf+hcV82jQ20/tByyE24nyVMQzUeDS1BPCrlGcuZAjj3qO8y7ciGa/tXqFLHe1v4n3MfBUtDWYNUW80GEHTsvn2YjtlqRZxIswyYM5J0RWzAGJX3ewyoCFYzr5g4jwGQ+nFsWi76xZMRmqAq5B5jGGl2bdvuCuU/x1gS3uTFAAxhJI9oKP8dtqsgdcbOTrcaYww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7155.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519a2e0d-0d39-4e95-8c62-08df2f9bdb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 17:50:55.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VWWubxHEOQjUxvC70a3EviZLrNcMhXIxTrDgCKjS8xvD8HphEpZyTtzGoeKhbVM8nr7Q0vWr0hoqlsBDkfgmrfSLtPE20zGT+i///V/zqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6182
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
ave Ertman
> Sent: Tuesday, August 11, 2026 11:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP fil=
ter assumptions
>
> In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not nece=
ssary"), it was assumed that llpd_fltr_ctrl was a unique application of a f=
ilter instance and the other command in the flow was generic.
> This is an incorrect assumption, they are both meant to add a filter to h=
andle LLDP packets and only varied in the actual AQ call made.  The newer A=
Q call was created to handle a special case in some NVM images where a LLDP=
 filter was already existent and the old AQ command would generate an error=
 if a new filter was attempted to be added. The newer AQ command would dete=
ct this case and instead would add the current target to the existing filte=
r rule.
>
> Fix the flow so that the newer command is always used if available and on=
ly fall back to the older command when that is the only solution.
>
> Also remove the obsolete state flag from the PF struct.
>
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessa=
ry")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |  1 -
>  drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++-------------
>  2 files changed, 5 insertions(+), 14 deletions(-)
>

Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at=
 Intel)
